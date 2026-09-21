Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EBFC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 17:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8hng-0000AC-TF; Mon, 21 Sep 2026 13:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8hnX-0008Va-Ay
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:27:26 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8hnT-0003Q9-0K
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:27:20 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so32443955e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790011637; x=1790616437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D9YNSAWl4KcvgdDn/ys0gAnOcyAPBG7s8COCA+VV1T4=;
 b=QVzS1xPF7QI+c/KIFAFs9MYBiKmehmDm+HRF7jHBO25u7VGdkTU+almlPRy1NF0yOH
 K1Q9hQWOvzlM3P8DmRDXkfZYGz1oJMp/kDOXzpcae3pIbneuLVw4pKZfta3+/nxTajNT
 qxggSYpaX5kcuGHLWNODS8RRInxfrdGXIJ08VQs+pthpqZ7rBfVXgx1pvj8eUJlv7Pou
 BDeSVPuZtBm0lZ2JmxAbeaNBMky7YbQacWu8R3/PA/bPkKrG+8zc8iWzRktUnCHAOBfI
 Kvjczgu0GTlkKXYVcHraFCpIUbu5UiZWY+cvL9ebEbZJTN1pNEA72kXP+qx07oLMOKHd
 bbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790011637; x=1790616437;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D9YNSAWl4KcvgdDn/ys0gAnOcyAPBG7s8COCA+VV1T4=;
 b=ZErMbCfmaQ93P0gRA4oZFgfJcF17XJu4DtyL97MjyOJC4jh+pgQo8q1aAyrDEahXBY
 w1QYbasFl5ZFuxtU38KVMhET7eWp3EHtQCN/InzOcYT61twKYqyNx/Nbkd/e1M9l5n/W
 KVNTl8ICOG9DFCayzoxuvxoOwS3ufPph70OmJjmOt+IC4YCdJSgOnohFNZ8PdqbWoXwZ
 xayN3jiMo9W+b1+zU7afje1lpBZx9926OMHLzq31IfyU/2IVz/+HgvEY1yrbj4BKkMBb
 s6QAXlNFiSgrc3Ev5QyWJVy6YZDeuFJLDuTYLY0cW/oWsuWYhvV1rtoS+Blw0uloCGgR
 KHWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBydU2hPZmEASaaptzkadksS5EgnvUPGt45p1wuqT1IlDHMA3o45BFmzdmy1R1Fgb7DehKyLeTjBV4ap@nongnu.org
X-Gm-Message-State: AFuF++lh3W08NfNX1nIrMiFgc3EqYYwuSTMi/4v5etQ/Hy8uC+ewX9RX
 4HvJtnMqdt5m1lQnMalE7unw0r3EfXhF4xL8O9VfafjCMT3zs/ZrKqRD
X-Gm-Gg: AYBFou0glJ1X9xWVApepaRtVbBR34jI+LcnJXvVsJOqi+ty4VnLu+bsV+Cb39kArD4D
 8FX3hyZg4WaONU1nqSi5/t9AE+QQUGXWYe8IyuvewdLzDMiiYgYShWjEqDIY6iJwbkQoifUu8z9
 dpLfllBOjISJpHePVx2QyvpIIqBQ2vO9hBOuet1mqSrOG2+Hc2pJyN4FkxKlr864RVnxR3PkrNL
 g8NIu7j9alloJ+dHHSTKl+v5qZtewnPn0wBPuT9VuWIZzJ76ixd2PHpq6AXfZTvAfoqupIS2VoY
 5S2ZT7PB72XJ4DOQVTRs8P0h1o7/zoTZRbWsBrWI3zl9a4niYOOTOFXxIKLxmG/9FNyRyKtLcbu
 MdD5/4oWOUic4V3t6Rcv42e5+by5Y9/3sEa6VhU16ZP/vQ5azsCmJ/e1FyO0RrpsuYPJ0Wffjdv
 HdbhKWrMBC7/uFIRA0z15SPWOlKT17z0XhljdBnefiYFiPaT9Yk+xjVtXbRrW94s9WWRdJzG9sF
 eY=
X-Received: by 2002:a05:600c:350d:b0:49e:8184:f63b with SMTP id
 5b1f17b1804b1-49fc5736085mr153101485e9.16.1790011636864; 
 Mon, 21 Sep 2026 10:27:16 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8a638fcsm7118745e9.0.2026.09.21.10.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 10:27:16 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:27:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv3_08/10=5D_MAINTAINERS=3A_Merge?=
 =?US-ASCII?Q?_MCIMX8MM-EVK_and_MCIMX8MP-EVK_entries?=
In-Reply-To: <20260920115458.481605-9-gaurav.sharma_7@nxp.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
 <20260920115458.481605-9-gaurav.sharma_7@nxp.com>
Message-ID: <5C670FBA-83BE-46C0-8B74-E15586C85B32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 20=2E September 2026 11:54:56 UTC schrieb Gaurav Sharma <gaurav=2Esharm=
a_7@nxp=2Ecom>:
>Merge the separate MCIMX8MM-EVK and MCIMX8MP-EVK MAINTAINERS entries
>into a single combined entry covering both SoC families=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> MAINTAINERS | 13 ++++---------
> 1 file changed, 4 insertions(+), 9 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 6be9c5725b=2E=2E7120784ec7 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -933,29 +933,24 @@ F: hw/pci-host/designware=2Ec
> F: include/hw/pci-host/designware=2Eh
> F: docs/system/arm/mcimx7d-sabre=2Erst
>=20
>-MCIMX8MM-EVK / iMX8MM
>+MCIMX8MP-EVK / MCIMX8MM-EVK
>+M: Bernhard Beschow <shentey@gmail=2Ecom>
> M: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
> L: qemu-arm@nongnu=2Eorg
> S: Maintained
> F: hw/arm/fsl-imx8mm=2Ec
> F: hw/arm/imx8mm-evk=2Ec
>-F: include/hw/arm/fsl-imx8mm=2Eh
>-F: docs/system/arm/imx8m=2Erst
>-F: tests/functional/aarch64/test_imx8mm_evk=2Epy
>-
>-MCIMX8MP-EVK / i=2EMX8MP
>-M: Bernhard Beschow <shentey@gmail=2Ecom>
>-L: qemu-arm@nongnu=2Eorg
>-S: Maintained
> F: hw/arm/imx8mp-evk=2Ec
> F: hw/arm/fsl-imx8mp=2Ec
> F: hw/misc/imx8mp_*=2Ec
> F: hw/pci-host/fsl_imx8m_phy=2Ec
> F: hw/rtc/rs5c372=2Ec
>+F: include/hw/arm/fsl-imx8mm=2Eh
> F: include/hw/arm/fsl-imx8mp=2Eh
> F: include/hw/misc/imx8mp_*=2Eh
> F: include/hw/pci-host/fsl_imx8m_phy=2Eh
> F: docs/system/arm/imx8m=2Erst
>+F: tests/functional/aarch64/test_imx8mm_evk=2Epy
> F: tests/functional/aarch64/test_imx8mp_evk=2Epy
> F: tests/qtest/rs5c372-test=2Ec
>=20

