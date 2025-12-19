Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C112D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfSb-0007hO-Ha; Fri, 19 Dec 2025 13:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSa-0007ao-6n
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:44:16 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSV-0001Z5-23
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:44:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso17086095e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766169849; x=1766774649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1eSU5ukQptXMdjPd6mkevOO2H+c9IMa2vy06wvI0zk=;
 b=zfNby3nJnG82cuZj7TowrzfiPxApYAH4WdhDazcYH80qPKDOvIDcppUe9uPxoDoKwY
 cWc2sRWnF/PrbEXUuKeeYnGdsunx/672N6wHXKASnmB4bueLew21BlLplDbxkIosEw1y
 mL/T5iZnRI4RB4r6qnKG9FufVhrwyELNitQO+hlF7y5qQ+cv28GEXMnYPWS650MOjPmo
 owsyrHw8EbS9fKKzWDo0BpF1GWGjzXiKoTIuvHK2gCQWFjMRifxZiZVUY8YalEihjmqm
 RLCMzvMZkmLCUoYMX6ZG6jTwY8Hex6ouJEY0bAP+Xl8m3wuQVW9cR7W7Uv6OmNFEj+AU
 +qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766169849; x=1766774649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A1eSU5ukQptXMdjPd6mkevOO2H+c9IMa2vy06wvI0zk=;
 b=rE9N2yIXy7urBWdFeJDeOQzeffMZGxWyYGu7/vU7Jx5b2pTlffyCi6KFVIy2PVUhtB
 XMhNWB8aa+hTARF05vf5guZdA9Ntxqs+QsOtA/J4qo8mhmbaaKcNtPoJIWfoWK6fR66Q
 CH5LkK4kon86Ye2HhwEGU2GR0pZjgDZ+VVJfW7klOLAPWLs3J6F8SmJz565fgznsq26R
 T6hx9Cp2Vw+jN/R/puzPM9myOYn162oICQULBVtBXiGqvCp0Ix8BWPKxBLGIgyh6jhpD
 4++r7EltYUau5/CIaVAVSAIA92fjZ9+VCr3KnKtWq5Mw3Dyo/2YAm87pjFkM9MZgIWfJ
 9hLA==
X-Gm-Message-State: AOJu0YxiV34vVmnDl0oPyIJCHTjBqJnA6j5wsp1eGrQrP+IUAliggtX5
 wf/pkaVSWdI0DoiM42eN2zGOfJ9/4zo2gA916JgGZMGuOEIbxO4W4vWcF8ev//f+Fli3BFSLK9O
 C8R5X+LU=
X-Gm-Gg: AY/fxX4mzlOaW4CRc0n08AKbtTgi/Rj2G3wRpSUMXjbg6jE8BoYyzCbWFoHENQLOTLi
 RBs/+McpOGAdWG0lygwYXgRa34/PoLe0cEJhcZ/IY6eHypDri3rGehKbp0X++QNlDXw1Z/zs+DX
 Yppgp4ic8Eg/4eEIizvRzxAlYhCsHUQaAhUz18NjaQPSKg8h/J8aLxiXIXilPr4Rt+7SxE/h9ha
 lUbp38AttbZjHG1omsmP4L1fKAvqEZOYkLXrh03Lah7wEv+c9yaK0h4yhoEIW1bgFi7dsLTtWJa
 +a5Owf73PTLSf9u1yzmL2X3kun35Tf0ePhKEgFkraxf54oYNuzsd93GrvMWMmjEv3J0lQ9kneQa
 wLC+DS9han6Awj7S/2uzgkLW4AYZuisGUYOLuKSmPQZN/2nSp/qOXB92rDM3Kxixpk/69fkNg64
 4M6tevZEPov4n8cDHEOAYUm9o+8Vfd3ahqzlguiT3/ekkU3thX9QHh/cnDJBQG
X-Google-Smtp-Source: AGHT+IHx7vFXnTjnfa1UdGf3y4RgRJeGbmJtKHlRsAHpKM8Vuq/4pHnLrpscon+dWy4jolQoIIdNlQ==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id
 ffacd0b85a97d-432448b7f11mr8119684f8f.18.1766169849292; 
 Fri, 19 Dec 2025 10:44:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm6272216f8f.42.2025.12.19.10.44.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:44:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] configs/targets: Forbid Hexagon to use legacy native
 endianness API
Date: Fri, 19 Dec 2025 19:43:45 +0100
Message-ID: <20251219184345.96786-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219184345.96786-1-philmd@linaro.org>
References: <20251219184345.96786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


