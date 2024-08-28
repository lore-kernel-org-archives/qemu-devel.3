Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A24C5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKpS-0000Pr-12; Wed, 28 Aug 2024 11:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjKpQ-0000Ou-39
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjKpO-0007Qd-8B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724859801;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PXvBq6OBvBIN6gDX/QcIipOidCvGamPJMpUlOHiuZOY=;
 b=W1beZGSMRwTdcDt6TzdoxKFB7GigHucjXM6MAiQelkdjTyJvJtIZJvrjpIMRupMGTJYO7Z
 HsbBivAFzmVWNawHkd8CDliUu6gAleKpetkIw/CErIFSOIc5yLeSiz0KYwLKpF9kQ0zjZi
 6Wx58lTflsk1GtRedOtOd5yhkXDD4LA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-BgYQqfTcOd2Yh31hiyTLng-1; Wed,
 28 Aug 2024 11:43:13 -0400
X-MC-Unique: BgYQqfTcOd2Yh31hiyTLng-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5CA81954B00; Wed, 28 Aug 2024 15:43:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 400C619560A3; Wed, 28 Aug 2024 15:43:01 +0000 (UTC)
Date: Wed, 28 Aug 2024 16:42:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v5 6/8] hw/core: Add Enclave Image Format (EIF) related
 helpers
Message-ID: <Zs9Fgb-I__0TNok_@redhat.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-7-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822150849.21759-7-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 22, 2024 at 09:08:47PM +0600, Dorjoy Chowdhury wrote:
> An EIF (Enclave Image Format)[1] file is used to boot an AWS nitro
> enclave[2] virtual machine. The EIF file contains the necessary kernel,
> cmdline, ramdisk(s) sections to boot.
> 
> Some helper functions have been introduced for extracting the necessary
> sections from an EIF file and then writing them to temporary files as
> well as computing SHA384 hashes from the section data. These will be
> used in the following commit to add support for nitro-enclave machine
> type in QEMU.
> 
> [1] https://github.com/aws/aws-nitro-enclaves-image-format
> [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  hw/core/eif.c | 719 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/core/eif.h |  22 ++
>  2 files changed, 741 insertions(+)
>  create mode 100644 hw/core/eif.c
>  create mode 100644 hw/core/eif.h
> 
> diff --git a/hw/core/eif.c b/hw/core/eif.c
> new file mode 100644
> index 0000000000..2cfd5c911e
> --- /dev/null
> +++ b/hw/core/eif.c
> +static bool get_SHA384_digest(GList *list, uint8_t *digest, Error **errp)
> +{
> +    size_t digest_len = QCRYPTO_HASH_DIGEST_LEN_SHA384;
> +    size_t list_len = g_list_length(list);
> +    struct iovec *iovec_list = g_malloc(list_len * sizeof(struct iovec));

Even if probably harmless in this case, it is best practice to use

   g_new0(struct iovec, list_len)

because glib then checks for integer overflow when doing the
"count * sizeof()" multiplication on your behalf.

> +    bool ret = true;
> +    GList *l;
> +    int i;
> +
> +    for (i = 0, l = list; l != NULL; l = l->next, i++) {
> +        iovec_list[i] = *(struct iovec *) l->data;
> +    }
> +
> +    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, iovec_list, list_len,
> +                            &digest, &digest_len, errp) < 0) {
> +        ret = false;
> +    }
> +
> +    g_free(iovec_list);
> +    return ret;
> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


