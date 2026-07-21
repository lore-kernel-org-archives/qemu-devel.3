Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F60EC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm3eG-0002dK-2z; Tue, 21 Jul 2026 02:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm3e7-0002br-FT
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm3e5-000107-5r
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784614079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uge8e9Gc6iyZ8ABJQi6bPBexHYNmQGXZnp9Bx4zBf70=;
 b=F3e1gaaSANUeS/cE5uIALq5EjVRdMdYkXjgpI1dE3yaCXzE8M68LUde8oKVupFr75JCc8+
 JO61zsnWao5c7ElC7lo5pO1dDzvLMx6MVM0fY6cB5UfVd+jvtQtiU7o2gdLlwp9oHoRAc+
 ulyyTiZnhqH+IQ0YS1Y0YVb5aCK0iuM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-IJitwLfJOJy0wiOKehgaNg-1; Tue,
 21 Jul 2026 02:07:54 -0400
X-MC-Unique: IJitwLfJOJy0wiOKehgaNg-1
X-Mimecast-MFC-AGG-ID: IJitwLfJOJy0wiOKehgaNg_1784614073
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 525631809CBB; Tue, 21 Jul 2026 06:07:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F0E81954233; Tue, 21 Jul 2026 06:07:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC56321E6920; Tue, 21 Jul 2026 08:07:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH v19 01/15] net/tap: rework tap_parse_script
In-Reply-To: <20260714154246.1242856-2-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 14 Jul 2026 18:42:29 +0300")
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-2-vsementsov@yandex-team.ru>
Date: Tue, 21 Jul 2026 08:07:48 +0200
Message-ID: <87wluoswnf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> Factor out tap_is_explicit_no_script() helper, to simplify
> further changes.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/tap.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 57ffb09885c..fedd48c48d2 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -92,19 +92,34 @@ static void launch_script(const char *setup_script, const char *ifname,
>  static void tap_send(void *opaque);
>  static void tap_writable(void *opaque);
>  
> -static char *tap_parse_script(const char *script_arg, const char *default_path)
> +static bool tap_is_explicit_no_script(const char *script_arg)
>  {
> -    g_autofree char *res = g_strdup(script_arg);
> +    if (!script_arg) {
> +        return false;
> +    }
>  
> -    if (!res) {
> -        res = get_relocated_path(default_path);
> +    if (script_arg[0] == '\0') {
> +        return true;
> +    }
> +
> +    if (strcmp(script_arg, "no") == 0) {
> +        return true;
>      }
>  
> -    if (res[0] == '\0' || strcmp(res, "no") == 0) {
> +    return false;
> +}
> +
> +static char *tap_parse_script(const char *script_arg, const char *default_path)
> +{
> +    if (tap_is_explicit_no_script(script_arg)) {
>          return NULL;
>      }
>  
> -    return g_steal_pointer(&res);
> +    if (!script_arg) {
> +        return get_relocated_path(default_path);
> +    }
> +
> +    return g_strdup(script_arg);
>  }
>  
>  static void tap_update_fd_handler(TAPState *s)

Before the patch, we default @script_arg to get_relocated_path(default)
first, then check for "" or "no".  After the patch, we do it the other
way round.  Works, because get_relocated_path() never returns "" or
"no".  Worth mentioning in the commit message?

The new order feels slightly clearer to me.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


