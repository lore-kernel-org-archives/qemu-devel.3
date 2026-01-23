Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A348D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIoy-000162-QA; Fri, 23 Jan 2026 10:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInE-0006zM-H2
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInB-00030H-Vf
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so26645765e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180984; x=1769785784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M1oVYxqoM8J9nRz2MCulkkHN20WO4j52vl4dcwX6S6s=;
 b=kcFZlwjf78Rr73jes8P2nGksCoi3wZycOT2QJtzcIzNJ1eR2mPdXIGWnxX83h0o2xx
 C/eTUpgnOgl+/+PnBCVWUGCmRwWrmYJGKfWdoZSSL3fGn8kvc6GDnvGwuN29X1slDBnV
 8wdlsnwkT1cuC59EOgiaT+yBaUGg351mge/wNcedj67CQgu+YN0V5B+6oi7Ap54zI5fc
 oVSWvkMcnyOm9PKXvLQZdOnKSZ4JvBcpfOhdS/2GtYWJzXBBhdtD3b7ZDtKnyQaRvDhc
 jTvH5CMLC4ES2PzG5BiiZRJV4ICzEveQuhTwOzhOUQ6GlYurPbpVOmykKQ/7xkJ3K5Jp
 4blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180984; x=1769785784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M1oVYxqoM8J9nRz2MCulkkHN20WO4j52vl4dcwX6S6s=;
 b=N6YQnU2H6Srk8sgnFmMxVDoZ6CMhHwHRD2DcAbP51gYziYFNcIcNAf5mBzjD1RjH9t
 AyND9P+g/IOuHHCzLUtLkvD+8a1K8s+rslpua5uY1xQl/llkAziZ3x4QbChaJ6+0Veke
 Zr35Pgf2/poZKnbuVf8P7dyHWQ9RixZinWcRP0FXYV3jg5HibVKBgTlgm7l8QFGQsEQ/
 rumqdAiGnw/JaWjyF2gzyLH3uxE279UVG5tr9nslnw7qVUZ173ykQQfuwinTYBSYV5qI
 5jcZDkggEgP1OpFFO/FNOW8Sz7WpcTU712y77AM8W/LMqRGQB47U54JAcnWmvM2Jb9fE
 +8Sw==
X-Gm-Message-State: AOJu0Yzmjace+OnZoTN4j+Y1NU/p2nKzY8RfHvZSOU0zHpUuTh8nn/vx
 aj0R1w47WKvzWyKzkbgWFQAfzntxBS3L/W6QrjaQG+zpP+yejWvPCJL7Mv0a/uHwU9XJB4vePS3
 IbWKoADI=
X-Gm-Gg: AZuq6aJAjdr79aBZrYV5fNyoYjFiGUqV6oUMKyosQx8KJENKtLETzo4b5b6rxInRlGg
 m87KHlTIeZ4qZFr3/QRpyggFkLT4KMZ1L54Y6hbIBhSXQK/hpn/iIrs0VgynJ5no/fyZk1kU8lc
 Mbxkzrl949iNUdzYxYzk2OUD7aQ5J+/7TfX/toWzCbtDtkvmx2OzRkklwfSJudarDvHpsH5NvzJ
 suOeCwxbMxBpSh59QUeZxPojwjkh/hre+sG7mQMk2Yx8xmBooi/swGT+0jJKZjh/wUFtOCfUI7U
 GFlZx6/Uj/OkXZ0wcQxfeCy/9DcAD6SkKznkRIF2aPQTg4suK2zJ0eKTjs5miMWk6GS19Jgbbjz
 3rgPYg3pOju6o5dOWaOUOF29GIJ6AxcjuIjTXOOkv8yYyjlDKcYFMROWBp/R9/fv0ua1NprQFN3
 IWv4QWPtJTnfWtcK163b9HQTTWPfbChg0Dpye9I40UAoJAGZVzdnYp
X-Received: by 2002:a05:600c:45c8:b0:47e:d943:ec08 with SMTP id
 5b1f17b1804b1-48053b17da3mr3208555e9.28.1769180984292; 
 Fri, 23 Jan 2026 07:09:44 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/22] docs/system/arm/imx8mp-evk: Avoid suggesting redundant
 CLI parameters
Date: Fri, 23 Jan 2026 15:09:20 +0000
Message-ID: <20260123150941.1877768-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Commit 094fd7d36f2a ("hw/arm/imx8mp-evk: Add KVM support") introduced KVM
support for the imx8mp-evk machine. KVM only works with the "host" CPU type
such that it has been made the default CPU type for KVM. No need to repeat
that on the command line.

Fixes: 094fd7d36f2a ("hw/arm/imx8mp-evk: Add KVM support")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20260114213227.3812-3-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 79600cf39a..e60a422824 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -66,7 +66,7 @@ KVM Acceleration
 ----------------
 
 To enable hardware-assisted acceleration via KVM, append
-``-accel kvm -cpu host`` to the command line. While this speeds up performance
+``-accel kvm`` to the command line. While this speeds up performance
 significantly, be aware of the following limitations:
 
 * The ``imx8mp-evk`` machine is not included under the "virtualization use case"
-- 
2.47.3


