Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA641CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGexR-0001te-E4; Tue, 13 Oct 2026 12:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGevf-00019L-NU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:00:57 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGeve-0007uo-0l
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:00:39 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-676804a3a22so2613933d50.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907236; cv=none;
 d=google.com; s=arc-20260327;
 b=o+bzHaLmQcIJ4vPGO05aviTlN2QGn8H60U3/Q+bLZ08/Cw78vgkpi83UEZjQmBMiyx
 5UEdlStvkx3Ia8PjeIM1UiTtA5zAX7StN9+rt4ZaMP7anC7niKw4D3iTVgcMsTaOyTxO
 lVSWvqJ1lAd/TCbFYYy92T7WWYnNX4BU9BvQiDTMJPtbfY/cSgpKXL7MW+2XvyuwOpjf
 jqn+qwDPd6H1Ixs+nmta5UzKNWTc/QuYBhBOn1Z/W4p20MgGN3Mim1Q+eVJusXD4kdLG
 jPXfaoIpLPU+Fn+mL+y/YdWIAu60KL5JBvVzUrRgJlu6BJUI7frSYoi6NjWg7TocisbF
 w4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D/uivC4tktPPj9uqDCsidcrW7/PSmgccuKFkXyRWMQc=;
 fh=DNKNBphZpoK+K553HJZNLWiC0Uq+XE2Bjw578JHv4u0=;
 b=qTfhLIf4d5dXNBv8f6qFHRO/11jdcZzM7pyxuyAG5+FhIXq5ZQRfNPZY6lA9ig7fsk
 L51jfVGiq77Jx++g/Q4yT7J8d/4mCtbk3ccz/Qb/+IkgQ2/wXbAAc6NZZeaDeIdHbCrd
 mkuGyqLwbTXX6rj/rePEBSb5JL2SMY+j7fA0ILAX5V06gr/bShJuNLqGl0lMLyp4hPJr
 a0xRz88aKRpQCEaSPE+URjmfjHo5oj5ANslNgMOhZX/AzeLwSVVcu5PrcDaENjwWVsY7
 ZbFoETrS6hPfxhBnOupIu6nfLFakOiYvPXEZjsZONeouveI5KeIHSDxTHajLL9qrJa3B
 dRBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907236; x=1792512036; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D/uivC4tktPPj9uqDCsidcrW7/PSmgccuKFkXyRWMQc=;
 b=mQmBH7vW+hcwFy4hzJJtHqEtjSUTsLcw1HQxqvNjKKw1X3Ny7tp2ZyApFNY1xpC1j3
 8keGqmkE0AfvGD6NjMIx8U/vv5q+hEBhA9OeXwWtAXmtKrxjYVv7q1ZygRU/Btk9mZ0F
 wR0mHbYUsNVa793+jt8PvyDI0oTduOhNdFUrIkfa7yDh/2gWXOQRCTHSNv+Mxp5VZWIa
 IrT3PQ4kTMjjJvAHcyiH0wfODFJD4/CWSbEPVEg7FiQmpZJR/1+K6qVxzgmctUf1OiRN
 ZKv7kVmHIdPu9a2Slkd/qB41G0U3EA/sc/uiTLPuwmqJL5jqbxTwUv0MA43wj8OYB1ia
 dVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907236; x=1792512036;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D/uivC4tktPPj9uqDCsidcrW7/PSmgccuKFkXyRWMQc=;
 b=e4Xe1QA/1PreWGYMEu/ChyDe1Bz6DV6OvcohSYDpU61KHAwimY8aSVJ49cb8K5sNws
 Fb6P8R2y9u2KVcvKQqETwx7t85/gWrGdNrIIUw5Xsf7CnuoyHLGf9IcuDtMvUxLH9c/5
 Qv1LVWPJ5yNwpzpv6gce2CCXmL3VnwZdphr5wgUUIEZB9ZjO1BdDLG2EIzJd4RH3oZDM
 O/98jtycNEXoQlOeellLl1Be1GVMMB3pZv7tKHzmHAZXCkPvEETlYG/bUi2BLdRMHxEl
 7Ws03tGcmX1v8fe9fJ1ZowgZBeDmvwQ2ug4H+PUu6ft4wllEm+1r5Tp401AecQp35Dj9
 8PmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqZvBPIiXIdQyiVJPjQt87GaeOrNG4rSNbI2E3Z7TUM+8tNSOPNyxz0KG4bdSldcBXm2K89jXUcnzD@nongnu.org
X-Gm-Message-State: AFq9FYKvryjRzJmcJvVZCtH2Ytt73LI54NctMMru9Wh43Ubt7gsbfb91
 6JBtxjfCmV+n8/LNHHF9DjfznVSPP3il+mJtgeH5tqEW6ldGpGDVp3KKQM12pkDdJgqWHeMOLdO
 TVQXmPcT1BsV4VqloOE/+dfy7PJupV55SecSc6l7Xzw==
X-Gm-Gg: AYBFou1WSUpsmLP1hFysmH9QPqr9TmnBZQe++BgqFNDd6iJ/oEnmUq8670uwSykbJ8G
 42+3DWSaWRgcNCRkSUcTQvTXFKWEJEexuVrQLolJkLOpy3XCcJhVg+iBlYZ9psWGCh8GySB9caQ
 6oZJxfjlqQ5vl8SgqDottRW2VoHrRNii9rtlcpXqto7BzdL0VOV/BaTOHiZrHJKnbGCqg+rBVq8
 TtzWIcaQXPUcb/T2FBNjtSL4OY3QJCRC9MiQgQdZ9eYwzOUy7JmABfRLUCOhQqajG2Tpa36Qibv
 +cfWMKOUvvGd+GSWEgNkKiljm3ngDOTd0Zj4SX/GGA7THUR6l2pJUP6cGQ/9u8wdAp/kqFjPuGp
 kUCM4AKAw2L8y2wseskcU6tJOkgofSWiWuJCh79w=
X-Received: by 2002:a05:690e:4893:20b0:677:d251:ccd9 with SMTP id
 956f58d0204a3-679362827bemr3036296d50.48.1791907236209; Tue, 13 Oct 2026
 09:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-13-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-13-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:00:24 +0100
X-Gm-Features: AclHuK9oncqSnpk2WtX0BIztDFi6jgbDUd4jevuwU9CNMC7v0XFSzmKBIWC2eE8
Message-ID: <CAFEAcA8NTf=j7_D1_zN20cX1ogGsw5s0wxO2y8mvze0f1phiTQ@mail.gmail.com>
Subject: Re: [PATCH 12/22] kvm/i8259.c: convert to use DEFINE_TYPES() macro
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/kvm/i8259.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

