Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE61C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJN-0000ON-DC; Fri, 20 Jun 2025 13:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJM-0000OD-S0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:13:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJL-00049O-Bk
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:13:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso1801852f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439633; x=1751044433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLTCRodz0o5mysvOupAvvLEmxMjOqF4SQNNVOBDDWiw=;
 b=DkyTHxMPyrU+Js/I1qfwF8faP7wGR0Fv+Q+H2W84dVxA8+ufY5XgtDIhX8Fx1L9VGy
 PwQkCA7GwwKv7UyYvTia1nC4CnlBPRXWtwHZjq94I31AwelLHQcgHbdvgrZyY4u+R1ya
 nq6EyIS5dd8H7M3qad6NGG0jCmoDfe1/Cw43Dahzy5zlW6BcDv0Dod+qYs75T1CNqepa
 PnkdfbSmw1zL9019f4zrMd1Ulu+iwdy63K+LO9fDv4UFHLjNkUmapLYBcq4LSLnUsswR
 hrCTgqNtXZ4+VpG3XZ3S7Co76yVytTQVAtR3prAqPQg1IVdoVA8iQzFIExQuxIvGjDub
 ZnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439633; x=1751044433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLTCRodz0o5mysvOupAvvLEmxMjOqF4SQNNVOBDDWiw=;
 b=eeBSLGmpj+qGKiHvU2kYp523RdwiGjH7OG13wt8lg5W4BWqdsi+xtDYzWw7qzgiJdZ
 c5B6b9ETo0LZsoVVhhr0K4phdhhbQiJW38Op8K8iH3MtjQUtWsl3THQfi/Lee1Thsd4a
 bePapPElc3NOgYWsRvxPNs0XdJh/6WljyCTmt0ewxtJsurVAyaNDsYEp2ShPIMklDVHa
 TVRZKeg38vKavH7E+TDnRf+LAimqSj3/kNB4DJmArOxCXb4rWebXoTpeBG6oI5bG4YDI
 O+vgw59IUlUOY9xtwltskbo8TznEfMyUCEHGjGxBaDyyer/dcrFu922iRYqfHTcMPZpj
 Xrdw==
X-Gm-Message-State: AOJu0YyqJ8wyZenfutT82bQea8cSt3pYrSCQIHQqv6Oh31MS3b8N2NDs
 0BOOgtAipa0Q50nFcIjqMx1UGOKV8njCAQuob77HOhwfyNcBzfChnOgg/j//tvhM8SRNK9rvQx7
 0ub/DQak=
X-Gm-Gg: ASbGnctCELINqv1Axj37hQSnC5W2mR9OVQBTSC4SpJycQ+DHzhIX0VoMKHSK3vHS4VD
 dHQb5bW7kX1hj+W6t2wU1gQi70XLCe6qNsS+xpFR96fP2gehhvOVQR/t17rZ2dFbBEzm0CO3Ibw
 z+eoAi+upVI9Le5Z2X11Re70C7PgEqfNtn761UWCAwIWaN76DDXleffHUKHhZD8pd4pg8R+quoS
 R32ViF/TV541CRqbQTTAdClD5Pu40/L/oJ2HJP2jBw+GOSHxIWR9FBfOVVdUz+fA0X4EvP09DK0
 1CIPSm6veExnvSTt32x7HKwA0R3WMg3uN7N3pOs0eLOKtk5NhhLy7hqktOftBXns9rzhaSMt+Kt
 y3yuS6K3X8QbNLbjxagrTfx03VUqdwT4NxhyL
X-Google-Smtp-Source: AGHT+IHe0qDpGZhRv+0c12EZzI+rlrjv+/k20MGv24cklyzD19GJoFw/Ub/AG738N+6wC6W6RY+uPg==
X-Received: by 2002:a05:6000:70d:b0:3a4:ec32:e4f3 with SMTP id
 ffacd0b85a97d-3a6d12e8d73mr2677942f8f.17.1750439633503; 
 Fri, 20 Jun 2025 10:13:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebced8asm65478975e9.40.2025.06.20.10.13.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:13:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 02/48] system/cpus: Defer memory layout changes until
 vCPUs are realized
Date: Fri, 20 Jun 2025 19:12:55 +0200
Message-ID: <20250620171342.92678-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

vCPUs are not really usable until fully realized. Do not attempt
to commit memory changes in the middle of vCPU realization. Defer
until realization is completed and vCPU fully operational.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca309ea..7004de3992c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2773,6 +2773,14 @@ static void tcg_commit(MemoryListener *listener)
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
     cpu = cpuas->cpu;
 
+    if (!qdev_is_realized(DEVICE(cpu))) {
+        /*
+         * The listener is also called during realize, before
+         * all of the tcg machinery for run-on is initialized.
+         */
+        return;
+    }
+
     /*
      * Defer changes to as->memory_dispatch until the cpu is quiescent.
      * Otherwise we race between (1) other cpu threads and (2) ongoing
-- 
2.49.0


