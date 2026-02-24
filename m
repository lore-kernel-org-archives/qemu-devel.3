Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F70EF5862
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvcd-0006B4-Oz; Tue, 24 Feb 2026 11:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvcZ-0005zW-4s
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:50:54 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvcX-0002d3-HD
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:50:50 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso205794d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951848; cv=none;
 d=google.com; s=arc-20240605;
 b=dbIOOfPeByTgGlGb/2d+TdXzCqLfoNRWOOdzS5pTIj9vdQaF+Rb1TE/+x1x1wMnzHO
 WLexfJYD+tyucdSnTdDBhsoGWw8/L0nxdkT3tCImBeaWXcffAw0+QiNhYmxlQrlhGzwk
 SRLIH9VDHX9m2HJ46K+cH36uFLmxItkdJ5wICcmtF3nGuIQp74LE1FFUobNN2eNP0Fww
 qvvme/qIqsosZuQogaFwdYt90JiWdXOwrft3HSrKkX8ESAaPwzGpQ6VrzAiCgkMVXwfY
 tUsxti6FV1uBAiarpaMHBTAXjP5LnRr797nKh6qftn0az+K/++/jRW7Ihrjd0nkPXVsK
 xWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=00dSWe7BmLlsAnZnOfBC82/in6S1eabQNvJcIpcdFv8=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=TENxJEgumzRD5jxZHLqeF7Nuhrys/0CESLV6yRrVw+7xv0vci41gLki5dNv4q4Ff5U
 BmEE92sKQbgNW8bGvKWBpBHwyV/B7gKEYXx9qwGTUlf1Cm2fQmdZc2P4QoNDfjstLahT
 vMwYgzVCzM1FDWRkW4l4DKFC43t96GLi1t0BLvTiPILmRXr9fNV24BH2wNQPdnBIHTtw
 29fZsz/Hx3JI2yIffjVJXP2uXjVTkc0k+wykKaCZDd9gMqxta1tzjnN5XmKRZLFWvvbI
 oMnSaXNo3LivuKFRu/O++9T7K+h1zMKbhBWI+Dgqf7evMFTsGGsbWsk89aGDA+ptbjeW
 CW2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771951848; x=1772556648; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=00dSWe7BmLlsAnZnOfBC82/in6S1eabQNvJcIpcdFv8=;
 b=R6HD910JZxv+FwhpMs96ZZBW/21oTe+IX/NXAjg6dywEn7BDtB3S7JtQWFL5+CqFHY
 ttezomLE8g+wu0xo1McXRyEUr3vd1e+4zPscf+PNg1XRJaGQSm23Uh0n88XAZN4NeNBB
 a5ySn3FDBR48W86ZcQIUHThnYHzyOuMofznAA8x4mSkGwNMjzFivH5JODiOTU/aXmp/y
 RdPODE/w8S14Pq8En7/T7G8DEInpPzrWTzvI/j5bb8y2TjcC0I3BW20SwXsxsFvRBuPf
 hCw5bHoS07RZzOg6WHqZh32N7YDjKuUCgC9X2y5RKDHIpoJCoQzUVfVdyoJo+MEHDI5w
 5rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771951848; x=1772556648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00dSWe7BmLlsAnZnOfBC82/in6S1eabQNvJcIpcdFv8=;
 b=kh+EA/25loJpjfZ3D1VRe+MknN/oLYWS6xKLScDMRpGcaYGwC92CSTn63ZNdlZw7YJ
 HkrtlrIftoTvU1UYbth6q5gRrQF01GyrWnSHO2f6601m6KHb0N4HdC9dof7XHcD3eGLt
 likjypMCB5MkDzPq9KXCV+5KYy88z4JI/i7kTbaTLHmf/Pr1huk7QxbS1rJZeXPPFWcd
 ciGqs9nk+sL9hWO2hIoidYF6EuUFCx8appdgMWOQLTYXBCWEhI494VVbThiIzsALnlAw
 pUfQPcorGNIIoWPF8G25wC+hK3tFETJweU/X3/o0aAN3vICbmFt2EzvPC0PK5tOwqe53
 loRA==
X-Gm-Message-State: AOJu0YyGP6aVTOiNMOxXnetd/umLr0To8N2HQZ+8EXkPwdJfZre71WYM
 5Z+UPNq+zTGFvfbqDFRUJkCVeXZ4zXUfRfmjmvzGK8UXXhUTpmd54yUp96PMq6oSZgWft7vODSn
 n2XWYfaTD7stsfrqBDJ+lt9SXFLubss5bPk+nv+V1lwa7XVDtuGWS
X-Gm-Gg: ATEYQzxngmaUFjTudbdNfwkE5mtjF91hOwkFssDCrY4VULQ8WYy68qUqJfKQusn2d/e
 anSpRxvL+a0Rbz+WpISfF/i5F195HCRUBT/IpjqeaBC/svxPuO5N/IqyoBGNQcFKIe7ScQFsyri
 5N+e/9j4MASAM884zGl1g6cTMolm7UG0N2Ei1R9d3xKWjmCtOPr61tBfwnzbevOkUdJf20MUwOF
 K3eA6o3LgHNyVCooPaJ6h7wHyCbd7lUNBSf9/zkh7QWgmCAJfF7I70W9BpV7ZBU9s6YBb406OHW
 Hujz67TZWUUAQ7q1QGt+TskDqVzSUuv+3XfE1pzlrDr3r7MFLt1cFB4Sl48o2fgq1SM=
X-Received: by 2002:a53:c048:0:10b0:649:da44:78ad with SMTP id
 956f58d0204a3-64c78e3f7a5mr8230040d50.49.1771951847928; Tue, 24 Feb 2026
 08:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-9-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:50:36 +0000
X-Gm-Features: AaiRm50N692azRy-mIXBIpIfHTZIbUn7gMSvx0hrktkjsoU8tWBMEVY0Ui-VCEM
Message-ID: <CAFEAcA_wFx4_DNrrEsLg4mh-B_NU7OzqEipbYr8uMAXpuwmquw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/13] target/arm: Drop kvm_arm_pmu_supported
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 16 Feb 2026 at 03:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This function has only one use, so inline it and drop the stubs.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm_arm.h  | 13 -------------
>  target/arm/kvm-stub.c |  5 -----
>  target/arm/kvm.c      |  7 +------
>  3 files changed, 1 insertion(+), 24 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

