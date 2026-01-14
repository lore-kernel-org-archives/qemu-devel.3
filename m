Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F93D39013
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 21:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg8Ua-0008Ud-T4; Wed, 14 Jan 2026 16:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vg8U1-000852-0D
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:32:58 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vg8Tw-0004hB-VZ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:32:51 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso40256066b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 13:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768426367; x=1769031167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzXfkJQP3HTTv/Iz3UDFpE7UMShn1ruzD17zw8BmbSU=;
 b=HQKHvGQmfEbN2SWCtDjWr6mNv+xD4eUuQtJZxz9IB25QHLp+CHq0TLso+SQgNx1za9
 6PTeP/Bbj04jsqnT3ksNYY0Inwcdt5lnG0gFX7sLMOUDbMh0guFIThwqw+CdspSiCB3X
 VHjXAR5HWr/IfjHyzTisot/Mf1AeMaupfH4FrPiihGdi1RDK7Fc6oclFvjMak0njXN5C
 WvF8QBi5j0LQtucnxC/TMs6TQPFZtSoyIAHT7Rc3QPBq12azxmtV5smm4DVPgruqBzsP
 LIemaxFUF6nFcN0ewnZQNTIgVcH9Ra46t+Y+SZ1qOdLjdlqqE6HjuFXWV7uXQnvTThIt
 q6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768426367; x=1769031167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JzXfkJQP3HTTv/Iz3UDFpE7UMShn1ruzD17zw8BmbSU=;
 b=lP/wkQEkJ3E2SRX4VV5iqWZEyo0YoO0m02kGjDyN01wI/Coqt5AtVnLh2lqx6VzbsK
 jF+lTtG7xOxekI/hblwwiMciHCJ9gRZYhklBjhXvCi0qL/+zPvsnT5Y1czjmYu1J0wiS
 +BFl8zpBkU5Cp+89sYmVVJWRz2bO/JniUnRzyL/GmPFRsajKiwc57PXko/AAgg6ZWPVI
 CgKBzUZSCMfStkPaX5UKVGO/FNrVd8ar0hnAguLkJ21ikEfU/+KjHqZEmalHq7dmxOFM
 U8ap9qerau53NTPLoMClES0e6mptyuqed31+sNuyOgf4FI2lNd4MtpECa9qBzB/6uFpG
 +Wtw==
X-Gm-Message-State: AOJu0YyOmfQoqKx3KdYTc1WgQsysI+/qvsHJczfyIQSVuN65pmAbFyUT
 yO45GzjaUYfQOJD2CmCuWjmYWHNuA8QST0co303odg6MFyjp4hUom9AW6nB5qQ==
X-Gm-Gg: AY/fxX6YIhxD5ThThaOVjAXkeUkaUjwi4nPtzF21Tu3aLfsuQP+nFY/skNMq4yJO+TT
 1RxNYGmNWgU9KtTjRR7p23/ycAIx8yzp6fP6whMsBYmdLDRxPf9hwb/Ov/tNKmuIRJprFlgyeJN
 bJCYL7tr58Iz9JDE4hRG5f/DQM+vqdwGGNCt4A0rApj1TrOlHSPzjh/3eozW5WowW0L9PSMUlQy
 XbZhYqWes2zkRRB/l0VyqTkgBQw4CvRORwTrMzaKx47O16aJn1V74Cv0gRPt0jT6LOES5GCp6iG
 asx0LIV+Ug5K4MCo0LJ2M+29DCJGBFg3zhjqU7Brj3Ll0Q0VcMNObyX2yHEDmKKlZrmbYVwsr2K
 3xecSjk6uvVAtLsaLnksaynZpvBczUwAlkMlN8R0NMfMpWKKPF8MIyJEKz6OpozeBVYF55Xh/MN
 ku9htt6j7eYVF3HNEk4udDcX7bj5BFcZQtsSFfUZXr04a8Doze1qXSWtDV+m+e4CsggPwVfA==
X-Received: by 2002:a17:906:c110:b0:b76:bcf5:a38a with SMTP id
 a640c23a62f3a-b876743fb85mr282319166b.0.1768426367116; 
 Wed, 14 Jan 2026 13:32:47 -0800 (PST)
Received: from archlinux (dynamic-089-012-235-150.89.12.pool.telefonica.de.
 [89.12.235.150]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87124e1a1esm1081252566b.48.2026.01.14.13.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 13:32:46 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 2/2] docs/system/arm/imx8mp-evk: Avoid suggesting redundant
 CLI parameters
Date: Wed, 14 Jan 2026 22:32:27 +0100
Message-ID: <20260114213227.3812-3-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213227.3812-1-shentey@gmail.com>
References: <20260114213227.3812-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit 094fd7d36f2a ("hw/arm/imx8mp-evk: Add KVM support") introduced KVM
support for the imx8mp-evk machine. KVM only works with the "host" CPU type
such that it has been made the default CPU type for KVM. No need to repeat
that on the command line.

Fixes: 094fd7d36f2a ("hw/arm/imx8mp-evk: Add KVM support")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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
2.52.0


