Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CDDE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWF06-0001O3-V2; Fri, 10 Jan 2025 08:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz9-0008PA-AQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:36 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz6-0005eH-OM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:34 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so332175166b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515411; x=1737120211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDcOQuQ0FeIjJVOE9LpnMnyUJh9d1dAyavbPyRQaK8I=;
 b=Six56XlApAQwFJFFj/xcmE9tv/CXNyfs3jKJbnpSXJ0AkUsauazoFMFGnycrGnaknN
 lWQH4Ad6hQaPia7tcCvVDMVMxa7L5l3lg1KYZAa4TnF0cs2MLgiTZ5mjU7yQQMo8VRkt
 /w8kHWfIK3SqvA1TnDoDuihFQsokhC98OoNu7DrW04hkt2SKNZlIBfM1yQAO4XZj7t76
 +YVJ/h1quXuJ4+e+KHqJVWjElU+/DN4Dzf6pUy5/NYQb4uLrxmnmRX4A8j2LZEzgFvlv
 X9Xu7h84Re1OmItAwA0OTXciiLJNoSdk4uvXiWoRCWHU/QtVfES0mhH5FSXqM6zQu9Nk
 Z8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515411; x=1737120211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDcOQuQ0FeIjJVOE9LpnMnyUJh9d1dAyavbPyRQaK8I=;
 b=ZSySwwJdYUAcYtBPXU3h0jlPvMX8uWYmXRp0c4LNZg2xdqW88GEX1ptmPYk4Kgd3H5
 kogUssA0HqipoR2/hQvVUOFahEjIRmkaRaKSDRPUBkCwav2cSING8p6C19h+L9A+dswn
 osMaw6QREnhnvd9UcTRhFGinPlaYMwKNAJdpGm/NRbA4+kp/BoFJf7UsrUORBjyxGjgp
 QbXuH7TnSk1zQ9/uhxog2/X92ZPbBlSec1kX7jTGCWxNY5n8WMFToEAf3fxpde2CJUrs
 myqhGxfdLyP876jVfTUiflaQdJWZqd4GCju75jMdT7heNCfgmxCbW4DgVGeTdQ8ghsbS
 cgxg==
X-Gm-Message-State: AOJu0YxEkEE97U3TpBSCeJfbVVlZBFU21L0rj/FD6rlStqrD149IqOql
 0FRvu+y7UjOg37PMyF4OOo+YQUhljLTmKezu6+zHgnPZy/BJfAQO3hxc9p4QEJg=
X-Gm-Gg: ASbGncv8nLmlUQvZNqIvcheo5cE4ggKoUO/QPBNH6MNU+y8GJy3RoibFSsHkj34Yt8l
 0qB67IXDOWrkEbojQVJsaFrgDTJJTg88F4kYHVLcLPOBJ56KuwXqkjV8fPRvzLuu9sdn87FsaQg
 0BKPxjD+eFNwXmmGTszmQx5PZpP6foVAxlbv67aD2cA+K9/mo+3XsxLlnNfXSuTSm5D86NEvmDy
 oYvYlVLX5J80L2F7Ei1shOoDgWB13QIcqlXPz92uRpyGaQdnjtx4fc=
X-Google-Smtp-Source: AGHT+IHg0boIKgIc4ipy8AaogBbG9tSMC8dRdiUkcV0SGN076Ontdoo/+xW/bUWSQ+/K1/8Oyd69yg==
X-Received: by 2002:a17:907:96a0:b0:aa6:87e8:1d08 with SMTP id
 a640c23a62f3a-ab2ab6bffc3mr773316966b.8.1736515411076; 
 Fri, 10 Jan 2025 05:23:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d9a46sm168913666b.54.2025.01.10.05.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE1A26144E;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 21/32] tests/functional: remove unused kernel_command_line
Date: Fri, 10 Jan 2025 13:17:43 +0000
Message-Id: <20250110131754.2769814-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

The Alpine test boots from the CDROM so we don't --append a command
line. Drop the unused code.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-22-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 2d9995a95d..b3d3b0ee51 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -41,8 +41,6 @@ def test_alpine_virt_tcg_gic_max(self):
 
         self.set_machine('virt')
         self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyAMA0')
         self.require_accelerator("tcg")
 
         self.vm.add_args("-accel", "tcg")
-- 
2.39.5


