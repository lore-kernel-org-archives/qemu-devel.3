Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C12C5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQK1-0001co-CV; Tue, 18 Aug 2026 16:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQJz-0001cY-HK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQJy-0001WA-6H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787084525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LtxTBKt05tOFt06nPaJD3W0nNF7bI3ZeroHrXixK1I=;
 b=SGuxSMAEbY7ECNv4Y10tUXwDLynlioApOqiAkKjc0vuiD5dYB1pTkZtCU0BY1erCfjEaqS
 DkgLmY7YiKkgq6ONbXzql25K7aK2fLWrEPPzM5G/9uEOJp5fx5Ib3fFtSsH8SHWA2tOncy
 mDYV0RdyNKgbWOT5XC3QsY4UO7ql/as=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-j8Deru6NPYKwAOP9boKSTg-1; Tue,
 18 Aug 2026 16:22:01 -0400
X-MC-Unique: j8Deru6NPYKwAOP9boKSTg-1
X-Mimecast-MFC-AGG-ID: j8Deru6NPYKwAOP9boKSTg_1787084520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 148241956057; Tue, 18 Aug 2026 20:22:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94F8F195608A; Tue, 18 Aug 2026 20:21:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 03/32] qapi: add 'insecure-types' option for -compat
 argument
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20250926140144.1998694-4-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-4-berrange@redhat.com>
Date: Wed, 19 Aug 2026 00:21:49 +0400
Message-Id: <178708450915.1320462.6965992998165943728.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rcH+eegaX/LlU/SJ+qna0vx+5kCHbpWoxBWgo9NLmRw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhL7fmOpK0EaemOhIG4WYvpd6BYwZRMyksmsLW
 2TyYPrIZKyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoS+3wAKCRDa6OEJdZac
 5ROYEACG0xaHEthrnE1JAHcYrFYrgTH79qpwinfcci/6Djj12QP9EjbJIID9ODrObilB0jdi8QA
 HoT14MrNI+6G+YgFTkEhWx26z22K43S25f/T+PxpbgU3s97caw89rifaxUrGmdoek2EcQwcy99I
 T8DpNVMlEKmVGIFrWY5OYFNli7bXsc/qjznaYvZyHfvtM6DGuRPHqaWluiTwp3l9iO7ATqIPFRC
 hSsywzpbHmRc4xpyA8xuVf1JRINsvDtfKLbTY7e2WYA452bascLT5+fb0AeEaJUJWX7wmV7B+dI
 fFnj8ToNjr64rhkyVHoBdzW4BAnm6GhxVxqIMFz9qD/dGLFBaFP7a5zWIoqL1vpYB2jTVYnnTV5
 WpFKXDANapPGSQql84f4FC1AQVs8vYY8Ikoz5xBNn91Can18mZk7RjPFwFWXGkiQ2ABA3RFysIC
 sR+C8iCphI96U+yminTHoiDnclSsuBcI4UBy01IH2V/M2aSgq1Y3Pp1mauQ/9pzpTepaxG54Q1p
 WDHctguFzQAakiZ/qXdfBnZ+qZnhAmtZQIQtrvSO6ADgSbd8F9Y25bmTMthAQTnHYNEzT3HGOm9
 wrWJB1UQeTzosGEnI+MwUEHPW3TW/C/2Mcds1mrk8EkKo64LeOguDTaCXoQmgHdk2ZK7gMWBLRf
 XL3wZKKqvx+YS3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> This introduces a new 'insecure-types' option for the 'compat'
> argument that accepts three values
> 
>  * accept: Allow any usage
>  * reject: Reject with an error reported
>  * warn: Allow any usage, with a warning reported
> 
> For historical compatibility it defaults to 'accept'.
> 
> The 'reject' and 'warn' values will take effect for any type
> that has been explicitly marked insecure, or is lacking an
> explicit declaration of its security status.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


> Message-ID: <20250926140144.1998694-4-berrange@redhat.com>
>
> diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
> index ea65e10744ab..b2d0835c3697 100644
> --- a/include/qapi/compat-policy.h
> +++ b/include/qapi/compat-policy.h
> @@ -24,6 +24,11 @@ bool compat_policy_input_ok(uint64_t features,
>                              const char *kind, const char *name,
>                              Error **errp);
>  
> +bool compat_policy_check_security(CompatPolicy *policy,
> +                                  const char *typename,
> +                                  bool isSecure,

It should take a "const CompatPolicy *policy".

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


