Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30BECD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLie-00088q-2H; Tue, 19 May 2026 10:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLia-0007zb-3u
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLiX-0007nj-Ac
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso49349695e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779201997; x=1779806797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8t1iShycKMOk9DKixWKJ+LNY4Nu+iOM690vC3QqkeQY=;
 b=NZW8Tw6IkZQOyvMpTxqciqdgWw9ZGBc4Y1JQP8Tiv+hbbmLIeuKrZOGb9QIMKxKwrA
 YxCWuYjo4ex95xUUt/jAOCo4I8iXLz0pbRKQ7XP684GRJYkSjLlfztwsWMd4G5n0sr0j
 Rfy7Q2/34eRlwsparwr31sLtgrPiCZiLy/U0SviwizUo7HxPCh/Ce7WUTCZZClDvE1bf
 0Fp+G6pviCvJ9EVmxg13AAqXS7WfGhHyiyyvujXUdIpIQbqp8bLjBiAVRzfIa2AZa3UN
 6+heDSDB2LW2IUXJvgVSdUzsUxRt3lZluaOfEE2AYEq3rQh/y81UJpKArMuw2ERlr+qL
 QNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201997; x=1779806797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8t1iShycKMOk9DKixWKJ+LNY4Nu+iOM690vC3QqkeQY=;
 b=U//1xYIi0wxxfMBAXIzEv88d8aLS/vgEyx9O/gInGwWkKL6aVBEWfPg9NPVXiqSObe
 jBwVkpkn+PnpG2Kn1l8Dp8eTnlGpoleiotayQW5TKBOGJ1/ubZTAaItbGtFjiFgP7IHD
 yk1KY72mh3GoaYhRsn2Ff1iKbebNjDkypu8f2CJ8Hn5sivLNFYAcyIVBBaaxBFqcpOsO
 ddD/71pyg46bt/X+00bPXqBW4KbJjrn/6o3vDFs8N20e4CSVoe3lJECLJzstsuXaPLTG
 3UOyLAUhATofXvqK9LogJWxOqIiHTH0Iop4A06qN5pBt4zMMCZPOZh+jqNO4WU/0L8iE
 DeeQ==
X-Gm-Message-State: AOJu0YzOPOMHMV4ikGalXdn7HhY58oI9Jqn4WMIS6y/wyiWX8ht9blN6
 jlPMnmV4WxjSsHaoZ3WUASk4Jpp4t34gDey7TtT0VLrDj3ER2wk/Tsrr6aQl+JyPvoDL+5a6FLq
 h4HH+ZzQ=
X-Gm-Gg: Acq92OHU6TcS7ptB9qilVmV2q9YFLP9YD5GZk3SKcks04mXmAQwKv3YQZwbOe8clrl4
 +YAUpOxncX3yCczI7DUEXiFAtflVQIo6OK35WmhUPGm5poWulxxUHh5b96UYh48Ud4NQA5jBeo3
 HUM5oezj4OQXU1zqBO2wqXsb55JXCQ5a9KBUBNDKdLjJyNpkoUm7bJ0LcTTTljVaTl2mIgok/Hp
 6obNGYd2hkv0txLfGW04FeoMmvWiBPG1WIBgmvO6OsPI93zRR9J+cpLTOvz9ZsjjpNnAU8ch5FX
 m8JBd7enG2J0s9uXsmboVUtlT61Dds7XnC10PW8DsJG9+DXXheOO1MlKhpQ7KB2N9jkTFkl1agP
 Biy9SzY8wYiYTgUsVrHzRHMigZoiAd+o031LPloyU+bU6lYKKJbKDqJbgMTM3rdwhgdEOYTWX4y
 JWyJNeWt8f9k7gg/b+UT0EEicCANNPoWJqerqwRJJQkU9dfkvC93bftOdZHcyCsL6jnie5yUpr
X-Received: by 2002:a05:600c:4692:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48fe6325978mr309489685e9.20.1779201996709; 
 Tue, 19 May 2026 07:46:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694f2csm333008815e9.4.2026.05.19.07.46.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:46:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 06/18] hw/arm/meson: Remove now unused arm_ss[] source set
Date: Tue, 19 May 2026 16:45:41 +0200
Message-ID: <20260519144553.91483-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 7c3d66f4378..88e7ad1a3ed 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,4 +1,3 @@
-arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
@@ -108,5 +107,4 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(files('boot.c'))
 
-hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.53.0


