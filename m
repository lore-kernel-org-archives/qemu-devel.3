Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB200C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgCU-0005Ak-7d; Mon, 23 Jun 2025 08:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAR-0003Ud-GK
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAP-00016k-Lj
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so21239125e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681250; x=1751286050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XMJ0zIICEYOJOmZnjjg6la4eos6APBolhDpaT3Vg7M=;
 b=dn8/lNAXyiU6RgrIIOdcgb3JdUGQf2O8D6bpKprEPKb/dQvne94iBsSo4gaVEKuKIF
 V2Gj+vJQosn4ZO3w592sc3G/491ubQL6FftxaJh6DWhqs+U49QMFXsPpk/PJDAAlGsHg
 8s/MMFxB9XOccBAJM/kBodgzl079Tei/oxsEBt/CneNeCF8BKEw5qC13V7aswsJEVmiB
 WAXNE2gsD0o5pVK48fFHyTHjK4GGoKB1UZ53eCKm+S+J12CoABMRrbuwcSVmGZoT76dx
 VG87fZlQz4YMgvhR/Jf+VanbkrbJB3UBspqVJoCGu0zNfGaZqhDASe8XDpdGfZvqqMb6
 iZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681250; x=1751286050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XMJ0zIICEYOJOmZnjjg6la4eos6APBolhDpaT3Vg7M=;
 b=LSPfGpzXdeb97FXC4wqiROHP/DKk8dLtGpL/PdAJaGEltP5XoJTgqRKba132nFWtCY
 MbvM8wiJ2qOohymM/lPe+PyTokRJL6qkxU6p60e+9YFpSJ6BnPIEW6YDvld6mj44jz+L
 /SrJTB9H45BIQeD9DRDk836NQAt52Ou5BnGIbNiISIKmL4DyymJSfVDBT2t70x2NQh/w
 KJx9IZYh9/pJjzrRQpFlsxBvsbGcFPcwzQZ7l7/niC4u+X9X9UNaDEF95aYzeEmKGZFp
 +jJdLdcsMLb9dzb+u6U5BgaRREgpbp9PxKzyJo02CSizptYfvwW7mwvBlL7lAne7I1oz
 GxlQ==
X-Gm-Message-State: AOJu0YztFSH+3Nw0jD7+PipG2iSYjsEVuZMLf7TwUDAvZgkf2ICgS5GV
 oVbrezNrS1VthcJ95S72PDNgdzhcyNdSgPPos3WG3IKl66M/2yVEnLbEgduKV3zUU9WRvg53Qso
 DpDce
X-Gm-Gg: ASbGncuffAU0Xhs99n3kkwQvsHsiUs1O99sqRsNXtC/CCS1JPwFxveXtgFrkNQIh92N
 wx0wDfEUt/qSlejoG9hkpxe6xwQK2XKf8z9SNFFRScEauqUN0Y1R8MLnA+14cM4O9TlVb9tlaRu
 QKat83AtD3MZoW42I+B7hbQhdwhQcfnsmQWcqwQyOpyeTepBkp9pP8pXYPjC0mHEPaAVg7YPROM
 ZE6OkfVJrz/4fIGUrJTQRTgRxXhwNzae5cT4Ykxjl8Ak0rZ0LQq43V7B9a6npMzbwAHuDscUoeI
 yhCZDSMHTYxejbqVnVXZkQRnQUEfN8gakZdlD8hHUJ+RPRCUgf1r94LnudIcHKaH/Mp8aLLIINZ
 FMt2DMbXaVzJPLdjAwPLt9Nd7OfHz7wOvD2N+
X-Google-Smtp-Source: AGHT+IEa/iknzQpht+lrSGEcOk6XAtkG3t/fuyvBomWpFBo82CfJvaf+wwRcGbgYUNKrlTzMZ6RvuA==
X-Received: by 2002:a05:600c:5024:b0:442:f482:c42d with SMTP id
 5b1f17b1804b1-453659c9c39mr118467105e9.9.1750681250095; 
 Mon, 23 Jun 2025 05:20:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f10138sm9313250f8f.3.2025.06.23.05.20.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 24/26] tests/functional: Require TCG to run Aarch64
 imx8mp-evk test
Date: Mon, 23 Jun 2025 14:18:43 +0200
Message-ID: <20250623121845.7214-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The imx8mp-evk machine can only run with the TCG accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_imx8mp_evk.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
index 638bf9e1310..99ddcdef835 100755
--- a/tests/functional/test_aarch64_imx8mp_evk.py
+++ b/tests/functional/test_aarch64_imx8mp_evk.py
@@ -49,6 +49,7 @@ def setUp(self):
                      self.DTB_OFFSET, self.DTB_SIZE)
 
     def test_aarch64_imx8mp_evk_usdhc(self):
+        self.require_accelerator("tcg")
         self.set_machine('imx8mp-evk')
         self.vm.set_console(console_index=1)
         self.vm.add_args('-m', '2G',
-- 
2.49.0


