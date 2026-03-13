Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77311106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vxn-0004yL-Cm; Fri, 13 Mar 2026 02:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxY-0004fW-LH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxW-0007Ym-3b
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso17141155e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383116; x=1773987916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awjWB7o8/7gqjyQUYwoGFAJKD7rlAN4iC2SP0ovtwBw=;
 b=BBuTngOMsn506jsSP09r1x5u9Nl2mOjaBRpPzIjC9oGz0yLI28rbgEiIgmQz/SfKDR
 9AjgMDCmmT2Rx+U8xWJqSEEDmvy+O0aBfHsuugbBhtP5mA7HDidV6d8EXPvsre7pj6+i
 sEoQ4F+As4J0jw4RDy9ytMmSAMlSOK3c/T+skECNYP0K9xu21h+aG42IAl91WQaRcOD1
 7uXwiuJ1r9vvcpUhf4pdFHIUDVGySKjt+Ftt0fPeM7XE1ueGsmdh3VPvrvIoNGFjLGYT
 BffBvnop6WA2T/h69uuf9tckbuYVEmA/Ip/x8Q1wsThw+m3rGpeSbl4o5opQL92NHnmI
 0dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383116; x=1773987916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=awjWB7o8/7gqjyQUYwoGFAJKD7rlAN4iC2SP0ovtwBw=;
 b=f9xSJ8B3NywbLg1d4rddS9f378c3bQpXkkWwiQcuP5UHRbZqvVoPQc61sJfU72Z99T
 HEluLhahcvNwG7KteEpILFNuBL9RL8ICqfalBhSrebcHeW6XbEsDa4XRMf8ODCeT0Swr
 YTpTgcMtXgkUWpDdU/ZF9tzx1PypQbUcggt1hF0z0CfEZGx2DhpJ/DeABOrtoad0s+yw
 ALYuWWbazBHfY4sam49KtWYEIVSosE9EVh90plQDxJXyk2DJpCvjcFc1HGS/nY5n8+H2
 ulhZs8RqBuW2NNW0jw5J9Z+a+/e8+8sNinNNQ6hmjfuJDu3QNyDzSu+Y2LssX+VYxv1f
 k0Tg==
X-Gm-Message-State: AOJu0Yxnq7F4Ja2Zs4qtDecvQEVJITBTkT4MObBA/4+Vppuff2mpCGL/
 9hF7AuJxYnh71MYdjyaeEGCv6oIgbNz59nY1ilIiKOuZizccWFbYHu+eLfh9Tp7XZ5vpg+xniDI
 3ytzRIXk=
X-Gm-Gg: ATEYQzxglqgfPFUllStUuHAUlGK/9ZFntcFBYVyy7IHUwws8itiAKVVmJvx6t2jpLG0
 MNOSgo9/uIiQRLPyDFc1+UKpu6HhPIKmzIpQ0VkqfjCJI4zzY+Q41QfBu5soouGbGUYKR+LMm6B
 9TJL7YOOCpOvJZO+z135hb7VYxMM7H4LHHeI/S7FCwvrKbA+3Oic0DBPvWcGpQQfpqpZC1XkHrv
 USEjbQyJHjVn7rG6OT5yy7STtoXo8Vz/9jEHUILAsWtqBkXzH8PjF9+OieEHaHJ34xTbn1cRbaQ
 5EIN8QVOYj9NgXci2zMqdIw36w5bMH5y0Dyk31k76pwVOt4BUYxOeLYwH+JC6kuP7xzF4Nbbhf6
 BfogBBD4JOlo1VEOgbxdPGebbELGUDcIHOC2Txsq2kXxhP/VXNHwfsVKbGoIZ4GjSBJP6zAiYNb
 Dk1/B6LytCSDeVFFAgPJCnbV7Pk4TgXPiMI6Rrrb5RlzjJ6U/ZkOPPvf1WQbDmS54JE5GhvpjJf
 sTTYQ==
X-Received: by 2002:a05:600c:3e05:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-48555ab09e1mr34187585e9.4.1773383116224; 
 Thu, 12 Mar 2026 23:25:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e912fsm496075545e9.2.2026.03.12.23.25.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:25:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 38/38] hw/misc: Build 'mac_via' as common unit file
Date: Fri, 13 Mar 2026 07:20:54 +0100
Message-ID: <20260313062055.2188-39-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
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

Nothing there is target-specific anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a2601e1c433..cd084a19363 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -154,7 +154,7 @@ system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
 
 system_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
 
-specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
+system_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
-- 
2.53.0


