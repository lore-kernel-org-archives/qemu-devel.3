Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648A0CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 13:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI4Dq-0005oP-Lm; Sat, 17 Oct 2026 09:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI4Dn-0005o2-Ip
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:13:11 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI4Dk-0006wV-79
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:13:09 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8726acc5eadso5887727b3.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 06:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792242787; cv=none;
 d=google.com; s=arc-20260327;
 b=BRHDMwAhsD3W4HCBZebXFDoumRswh95jCDWTVe9GwjGv7rDp3rIFVD8XKkNF+a/1Qz
 U/2/G46XJUDwUNxXrewpxCgKM65EPO6xfFU/cRJ/6GxP+sAGUdGn5cjsegFVT2ZGtrwr
 VaIWIBiR2BmA2YRNPt3rXCyWr8XvcB07HjM7yCdJPqlFLZkf8573XMhqkfCPw7PLYgfW
 qculWgg7mrFJcPDh20RngvTjLIQp0fGBeq+mCCol/2NiuIi2nSsOjIRgmZv12COjncuH
 QM0TO+tRXpeYjblRMUEVKrj4WuyFJSb0HreSBMGudNCiDH2Yg9n/77EFQDkYxUAvX7Nb
 Uv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KiH9lCN80VTfNm8iRgopCmf+VLX6kHS52Kc2gPJrrXI=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=Lo8miH5CV7Aw0VMWNEMvXnIuAvubqjxBLEL6GcPGdm/9KgNY0+U+mYj/5N5SugajNM
 Tz9ByMXb1LVOkFlfSPvdMCtkbOR+QSo+v0pTR54z+r5XT3RwIFAik13FkYeZMT9bEGFM
 /C00GiQPhzc9XpkXGhVpOIvapKGKeZAU2sZy/C9ynYCYo+jWA6dttYL5lUxCysOzCPsg
 X48LSuha7xbOqwklSfewQXJ+ozmgqM3YGydjukQzH8DTjlsRpvQlrOqLLKHE/x5E1BfK
 wA6H+F7ObY66Qvu1xd/YdQMUY0U9n+m3WcXRi34Y6ya6KuSBZcgb++C5YpF6mXmJq8mk
 ppEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792242787; x=1792847587; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KiH9lCN80VTfNm8iRgopCmf+VLX6kHS52Kc2gPJrrXI=;
 b=n9VWJROeqk7Pgo5G0Axc2bTaAwIJUkuTFt7wnE/3KP0jAkhXd/MmpQo3/2yEaXqKD1
 GQtYLT6gQv3F42f/NPRgpWMNyHmtfLo++mSiYMI0iie+hjJqMGowTdw5cKFqJVMOcM9a
 8PKCnpVSdMavw4i+U8td0gdHHwwC54mhdBQMbLzuZsyD0yf6DgtCpZOWFkfqQWA0uozv
 bhxniF5byU+sFb/YzGCksK8OPb8v2r72LcR4Wk1FRPE5PDcdiETzHi70njYo0QIwXnE/
 zaX0wI8zjBg9QwaTSIapudOIJ2jlv8WfuibTtcabyQUDSCAbGJ6yXCSPfLU7pDTYe/lo
 y5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792242787; x=1792847587;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KiH9lCN80VTfNm8iRgopCmf+VLX6kHS52Kc2gPJrrXI=;
 b=LGsAY6DTDv8aITdf1x9bWwH+Sq6rZ3f91C/dHFDD14RsMmOg/GFhaBqauFYegW4fsR
 6FjtJATkeJsSNBj1mtEnAzjO6L3FADoHVY+hNTeaVvWeFGOw/Q+Jeh7nMLh5kXL+Opem
 teVxskfYIFgvYtPAWZMWnyW5psRI/AhkGN/R1bCoLiTMhDUFnDEzVOhbp1LS4LKwKuhM
 vambonn1zIp9eW8wfaeh+paonvWwP6N2QtzLm/i1tTaanvY3iK7yYVDtP2sLasPeq05q
 x4/yHi7zLCH0mOgnejQ8qLqyEFKM+LBvre+zLtq+kuNZdWLExqpmMvnwpZq+7EEBeQIR
 01kw==
X-Gm-Message-State: AFq9FYImTHFyQbNWN2vN+msC4AAyNEQrGRg31T9s5vhU0nxjzrpUGiZq
 /VOB0SJC76ZbKgvwNFyqBaAkCNcLHzYylA7MaY72s3tmzY2pg+6oW+gf78xD9bHVGm8ldrzDyn/
 hvmXWK3hasIO3DPYpnstFzSAptAIxtE+VYarDcgblJw==
X-Gm-Gg: AYBFou10G/GGSe8+NSwFLlFRTWtU93Obf9YbsnyXPsC0TYUxaNfA5XfgA4fcu3fnBUq
 ajDpaelAkxlAUeBZ1aycVuUaiUa7XLJ18XCcDo2MjExZZoESl4jrVxOjXqi1t+NKDOOJGO9FIZ8
 iPWDr1v+nI8eTf0+gk7c+dYFmgvDcR0eoTVGwCryNHXnNRj2BKvhw+pFVAu8xPZQLtMoTlvXSWA
 OY6az9jyoeWXbjw1Gv2HWG5DR3FsT7ydtUuNgDfRdYqUI784ZVO/7t2wTSWKngluCcywybS0wwy
 mdS7By8rOSzkKZVLeEP+P4SM1+JIAEFsYf42BYhDRU+laVLlRxR5o52W9XR4P0iNSLIoUBBPh2g
 qdpDRjI6cZF815pMsHGPshBjiM7z3XRTq4gNkz+c=
X-Received: by 2002:a05:690c:a0ce:b0:8b0:dd35:7b9b with SMTP id
 00721157ae682-8b0f222e104mr7761717b3.67.1792242786578; Sat, 17 Oct 2026
 06:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-17-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-17-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 14:12:54 +0100
X-Gm-Features: AclHuK_9VqJFOLR9L-ked9MBiuBAPGh6za91QteeWgHb04ED9396j7sWa9Wq5DM
Message-ID: <CAFEAcA9n+Y+nWZwNukc92iT2vg+x_5uEWieDrcziaD7oCoeXNg@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] tests/functional/aarch64: add raspi4b GENET
 networking test
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add test_arm_raspi4_genet, exercising the raspi4b GENET controller
> end to end: boot with a -nic bcm2838-genet device attached, confirm
> the guest driver probes it ("GENET 5.0 EPHY" in the kernel log),
> reach a shell, and confirm the link actually comes up
> ("ip link show eth0" reports LOWER_UP) rather than just that the
> device exists.
>
> Verified locally against this series with the exact kernel/initrd
> assets this file already pins (raspberrypi-kernel_1.20230106-1 /
> groeck linux-build-test rootfs). The link only comes up because the
> MDIO patch handles the PHY autonegotiation-restart request (BMCR
> ANRESTART) correctly; without that the link never comes up and this
> test would hang at the "ip link show eth0" step, so it also serves
> as a regression test for it.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  tests/functional/aarch64/test_raspi4.py | 30 +++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
> index bacecbbe9c..f703fc69ae 100755
> --- a/tests/functional/aarch64/test_raspi4.py
> +++ b/tests/functional/aarch64/test_raspi4.py
> @@ -109,5 +109,35 @@ def test_arm_raspi4_initrd(self):
>          #self.vm.wait()
>
>
> +    def test_arm_raspi4_genet(self):

I think you need

        self.require_netdev('user')

here, to skip the test on builds which were configured without
the usermode networking backend.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

