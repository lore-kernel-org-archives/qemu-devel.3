Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D07D5CCA0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 11:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t67Jy-0003g5-QS; Wed, 30 Oct 2024 07:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t67Jv-0003fh-T8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t67Js-00004r-E5
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730289418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+N0H1B0MA9hvpjt5R/6tUfhVLls/ZeuOgKaKy+cMRw=;
 b=NFTTcchoEclIdqj1LSQrVgqG7HZkc67Ckw9osUOfmY8OAiCJjcwvmUKAE72wjzCfGerYgY
 bGf3DXnxdmQ2nxgR3o1HUhNzgGA1BwrMNbNgAIpLTg08sa6sGym76yZKgReja6n2qX1N5w
 5i8sS6lvmFL9pgOTDtwTKwJWTyp4wfI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-dy-fwaTbPpiOIvRVteR4Qg-1; Wed,
 30 Oct 2024 07:56:55 -0400
X-MC-Unique: dy-fwaTbPpiOIvRVteR4Qg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 765AD19560B0; Wed, 30 Oct 2024 11:56:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7103E19560A2; Wed, 30 Oct 2024 11:56:52 +0000 (UTC)
Date: Wed, 30 Oct 2024 11:56:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: liequan che <liequanche@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH V3] crypto: Introduce SM3 hash hmac pbkdf algorithm
Message-ID: <ZyIfAd_tWU-FzzbM@redhat.com>
References: <CAAsfc_puem7rZtC2TkEvP81P9edMvNuT3tVM7TPH3NQbR-VC9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAsfc_puem7rZtC2TkEvP81P9edMvNuT3tVM7TPH3NQbR-VC9g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 30, 2024 at 08:58:21AM +0800, liequan che wrote:
> Introduce the SM3 cryptographic hash algorithm (GB/T 32905-2016).
> 
> SM3 (GB/T 32905-2016) is a cryptographic standard issued by the
> Organization of State Commercial Cryptography Administration (OSCCA)
> as an authorized cryptographic algorithm for use within China.
> 
> Detect the SM3 cryptographic hash algorithm and enable the feature silently
> if it is available.
> 
> Signed-off-by: cheliequan <cheliequan@inspur.com>
> ---
>  crypto/hash-gcrypt.c           |  3 +++
>  crypto/hash-nettle.c           | 14 ++++++++++++
>  crypto/hash.c                  |  3 +++
>  crypto/hmac-gcrypt.c           |  3 +++
>  crypto/hmac-nettle.c           | 11 ++++++++++
>  crypto/pbkdf-gcrypt.c          |  6 ++++++
>  crypto/pbkdf-nettle.c          | 13 ++++++++++++
>  include/crypto/hash.h          |  1 +
>  meson.build                    | 39 ++++++++++++++++++++++++++++++++++
>  qapi/crypto.json               |  3 ++-
>  tests/unit/test-crypto-hash.c  | 16 ++++++++++++++
>  tests/unit/test-crypto-hmac.c  |  8 +++++++
>  tests/unit/test-crypto-pbkdf.c | 16 ++++++++++++++
>  13 files changed, 135 insertions(+), 1 deletion(-)

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

In testing this, I hit a pre-existing bug in our hash availability
detection which causes tests on fail on RHEL/Fedora. Not the fault
of your patch, it merely exposes the problem:

 https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05589.html

I'm queuing your patch, but I have to wait for review of the
above two fixes before merging.


BTW, your email here was sent as mixed plain/HTML and your mail client
has applied line-wrapping to the plain text. This prevented git from
applying the patch.

It was easy enough for me to fixup the line wrapping, so no need to
resend this, but in future please ensure to send patches as only
plain text, no HTML, and without line wrapping.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


