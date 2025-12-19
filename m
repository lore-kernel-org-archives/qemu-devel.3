Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5C3D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfZ0-0002sQ-17; Fri, 19 Dec 2025 13:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYy-0002sI-9Q
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYw-0002iy-U8
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso16266305e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766170249; x=1766775049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITBhL+4Z9Lk/zIAEQOxBeQYzKPZ8jeAb4forELoRH1w=;
 b=lhN0SSNBNEfXvz26oklfhhePLieqwls908yytBKgaX1mWhWrmuYHSmaZAGoX/OXgLp
 kB6Tv6p3Du6hn25gftp95emVc112qhARm1C6o29Ebrk7IjBI8WHKHe3IFtqzYFvZ6xIE
 btWOpeo5bqd0pnweSF3DzoDMnayGKKkOWrbfQQ2iZssRHCfH8IRHEFiJ03153KeHyKJv
 dPQE6iFKs0c++JV8K9dWcGT2bHAaj6F3W7AdDZMBWgta3G0/xpmtskBSDINB2rP5NCn2
 CIWlgy9fw6z01uRuIMb2Tzq2J79jV/6frn5Ei+7El6CJaqTm0PzUiYw5hysJvD0LYKYP
 AQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766170249; x=1766775049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ITBhL+4Z9Lk/zIAEQOxBeQYzKPZ8jeAb4forELoRH1w=;
 b=QqFlnFnj42z+vblrQxYA9qUbLAIzcD7SU2QL40ptRP+B7dZ5+D14TiuhKZdZg5dpTi
 dASCI0db46E2/SwlMtHyj1eQ8wwQMfy8gbWRZ6omUibQWc4Dbewy05DqEmFfYglfzsHK
 yR+9zI2nr8Q1r1m+aMQG3NYbve42M9HWDbZ6LRLhkJKPRG7YuXZv9F0SSl/VhFOyX87C
 IfDndCeuspwNYzLYrsy21bqvUdy2GoD1Awm4Uur9H9h2wZCDvHeJk31bE2o7E8NjHAaH
 7FEuAHR+bFEOMA8Nn8s+OeL+4qUwWwDoBH1ee7V+Fju3Q9y4/vuUVY0xK30+NsgjyM11
 MmFw==
X-Gm-Message-State: AOJu0YwHJebI0GshSinyiPCQwQpqm1y09jdaFzhLGDbxKZemhMKOnb3G
 iYRLdX0DRUgbU6q3oKqRToZSOJKqxf+7aWVeCV+W4L3aYQjlt3e36wX2gZRMiFKqfoQB5GUQGu6
 5EsVz9Ak=
X-Gm-Gg: AY/fxX5+7ZB98FaoN/Zb/Pj2e2c5tCBMKYm6KSSSivkn57p/bqc/LuMFrjSOg/ZELV5
 U0UnQb7LHwliXr9vC42emOfGaAK2PT0wjzPjLnxp58zsIPxajyLEmtHLbQ8oVLyaR7OZ8UTzZqM
 jWR5vGqXurEdAdikV2g82iCRzoIkHrKoFIHiAKIA6WgX8ahTEda7SoeS0k3X9xroPhUein1GXMY
 mHwHQ+iJdxCu8brWZSCpBzeSVpDnDQWwquWwrh5ft2vpodk2dyv4xoXfokea6qMQy8YKvMPSM9l
 8kz0VNlSLv44Lc2BGE8L4ssp2TOYJcScclrPRtLAFyMwNr1blJ7umnjOvdGQuteV9EQ67JChKwQ
 1fcdKRlEflYiYVU5A1+1H6ssNcgnybu+tUohjHDSIfUXse1638LXGW7qNELa/NgvaChD/Eqh1eJ
 mBNPp1XAaeYaD0+cHkCOfJLSfjK+cnWHkomzcLGpgDXm3Bvw9OLfM1RM52jBug
X-Google-Smtp-Source: AGHT+IHClaqhrv8uYe0flLo5YjKta25VvTtN69QclAlaOIMItLftA9jctFBXPHPVFdYT8ga4pwkMAw==
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-47d18bdfc61mr39503895e9.13.1766170249048; 
 Fri, 19 Dec 2025 10:50:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2724fe8sm140351515e9.1.2025.12.19.10.50.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:50:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] configs/targets: Forbid Hexagon to use legacy native
 endianness API
Date: Fri, 19 Dec 2025 19:50:25 +0100
Message-ID: <20251219185025.97318-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219185025.97318-1-philmd@linaro.org>
References: <20251219185025.97318-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The qemu-hexagon binary is buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits related to this change:

  - beb38fda0f0 target/hexagon: Replace MO_TE -> MO_LE
  - fdcb7483ae0 target/hexagon: Explode MO_TExx -> MO_TE | MO_xx

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/hexagon-linux-user.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index fc09ae96a54..aec1a04d1b4 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -3,4 +3,3 @@ TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
 TARGET_LONG_BITS=32
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


