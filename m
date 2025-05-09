Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569A2C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 05:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDGbj-00087U-91; Fri, 09 May 2025 01:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDGbe-0007zP-LN
 for qemu-devel@nongnu.org; Fri, 09 May 2025 01:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDGbd-0001SO-47
 for qemu-devel@nongnu.org; Fri, 09 May 2025 01:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746769744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krvaltcFvhNLjsr3BuKOyMAUvbh3302fpYEKx4219Dc=;
 b=EVxYTy16fhHj7oa4tSw0fxxo4Gv2FFOQMItw7LAUwwtCd9XLt+fMa65dee7eiE/gX2gMQJ
 qo+RoYxqOs6YV5AxLF6tzk6pAyxQEJqi9KcclGoWQKwhRD7cMBKrQ8Zj4wMM0vUEC+evkb
 9xgE0v8SF9pPNK5wUqtgZcrbiu4H7Ic=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-26ylSVFkOY6-8U4pd7WPyw-1; Fri,
 09 May 2025 01:49:01 -0400
X-MC-Unique: 26ylSVFkOY6-8U4pd7WPyw-1
X-Mimecast-MFC-AGG-ID: 26ylSVFkOY6-8U4pd7WPyw_1746769740
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5208F19560AE; Fri,  9 May 2025 05:49:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8FB21955F24; Fri,  9 May 2025 05:48:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C8E521E66C9; Fri, 09 May 2025 07:48:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  armbru@redhat.com,  Peter Foley <pefoley@google.com>
Subject: Re: [PATCH 1/2] util: fix msan findings in keyval
In-Reply-To: <20250508222132.748479-2-nabihestefan@google.com> (Nabih
 Estefan's message of "Thu, 8 May 2025 22:21:31 +0000")
References: <20250508222132.748479-1-nabihestefan@google.com>
 <20250508222132.748479-2-nabihestefan@google.com>
Date: Fri, 09 May 2025 07:48:57 +0200
Message-ID: <87cycibagm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Nabih Estefan <nabihestefan@google.com> writes:

> From: Peter Foley <pefoley@google.com>
>
> e.g.
> I	2025-02-28 09:51:05.240071-0800		624	stream.go:47	qemu: Uninitialized value was created by an allocation of 'key_in_cur.i' in the stack frame
> I	2025-02-28 09:51:05.240187-0800		624	stream.go:47	qemu: #0 0xaaaac49f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5
>
> Signed-off-by: Peter Foley <pefoley@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  util/keyval.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/keyval.c b/util/keyval.c
> index a70629a481..f33c64079d 100644
> --- a/util/keyval.c
> +++ b/util/keyval.c
> @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>  {
>      const char *key, *key_end, *val_end, *s, *end;
>      size_t len;
> -    char key_in_cur[128];
> +    char key_in_cur[128] = {};
>      QDict *cur;
>      int ret;
>      QObject *next;

Prior review of Peter's patch concluded this must be false positive:
https://lore.kernel.org/qemu-devel/14168384-ecdb-4c05-8267-ac5ef1c46fe9@redhat.com/


