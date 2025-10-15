Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07004CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8v8m-00027H-6t; Wed, 15 Oct 2025 02:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8v8k-00026p-H3
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8v8h-0004qG-Bs
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760510250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9piosyVH5A6mo3aUpmW+GtV0kg92wFSrxl0TNNJtXE=;
 b=EHTwswLPSm7xczU8+oyuIbwQIr+MyU3UV+QwyUVEhkogyM+/sH6jdMZ7Zql0hUvFOEvlGG
 xwvThyB+nz9yhfu2xHbWEVmO3BOGwdmCPlfHN0PQYKs/QvEF5Zc2AnqhD09FW89e7biEso
 PC3LokgHHng0cHejDU/sNufyd4IxkZ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-Hu4e9JJEO26fp9Ss2Psueg-1; Wed,
 15 Oct 2025 02:37:27 -0400
X-MC-Unique: Hu4e9JJEO26fp9Ss2Psueg-1
X-Mimecast-MFC-AGG-ID: Hu4e9JJEO26fp9Ss2Psueg_1760510246
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE97818002E4; Wed, 15 Oct 2025 06:37:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D80E30001A5; Wed, 15 Oct 2025 06:37:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC70C21E6A27; Wed, 15 Oct 2025 08:37:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  raphael@enfabrica.net,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru
Subject: Re: [PATCH v3 3/7] chardev/char: qemu_char_open(): add return value
In-Reply-To: <20251014152644.954762-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 14 Oct 2025 18:26:40 +0300")
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-4-vsementsov@yandex-team.ru>
Date: Wed, 15 Oct 2025 08:37:22 +0200
Message-ID: <877bwwk6vx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Accordingly with recommendations in include/qapi/error.h accompany
> errp by boolean return value and get rid of error propagation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 4a531265c1..c874a2d31e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -246,14 +246,20 @@ int qemu_chr_add_client(Chardev *s, int fd)
>          CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
>  }
>  
> -static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
> +static bool qemu_char_open(Chardev *chr, ChardevBackend *backend,
>                             bool *be_opened, Error **errp)
>  {
> +    ERRP_GUARD();
>      ChardevClass *cc = CHARDEV_GET_CLASS(chr);
>  
>      if (cc->open) {
>          cc->open(chr, backend, be_opened, errp);
> +        if (*errp) {
> +            return false;
> +        }
>      }
> +
> +    return true;
>  }
>  
>  static void char_init(Object *obj)
> @@ -1015,7 +1021,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
>  {
>      Object *obj;
>      Chardev *chr = NULL;
> -    Error *local_err = NULL;
>      bool be_opened = true;
>  
>      assert(g_str_has_prefix(typename, "chardev-"));
> @@ -1031,9 +1036,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
>          goto fail;
>      }
>  
> -    qemu_char_open(chr, backend, &be_opened, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!qemu_char_open(chr, backend, &be_opened, errp)) {
>          goto fail;
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


