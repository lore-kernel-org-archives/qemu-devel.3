Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADB4CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDca5-0008H8-AO; Tue, 28 Oct 2025 01:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcZz-0008Fe-NT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:49:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcZx-0003j7-Ga
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:49:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso76769705e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630547; x=1762235347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h63K7KJw7fL2qe3qT9jwFp5KsLmsyTaO/eJCwYKGslM=;
 b=ivNiX5gLvdSK2zHFSa4rXWmApyHJobHQYexH7cDiArJl1yqu6a7q/pGdLagGz9C2Jy
 jf1zVi6bBAiakJTZ5BEQbQZMa6IAb7J3vW6HrNhmNUMWaOaAMTtqCdlZIqPjT451tGER
 nL7w/NFGojZgc8kIHwdIvnglkPi5Ch2n7zGay4dbeWWfypl6IG3/GHooe4Zwi2I0LoNn
 5tXgeCiajruXfwkNZLel05M0SaWQcDNBZXLcO9TRXhKzvCpY+KURU1+i26i9Wh8Xi5a5
 S/LQNEWpxRntAZQFxtIFctb0g7kkR0zPf0bZqNFkhg+IMcyC3ttgeNPnAeU2WslNlaeO
 thHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630547; x=1762235347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h63K7KJw7fL2qe3qT9jwFp5KsLmsyTaO/eJCwYKGslM=;
 b=C8SdQ4LIvayDP/8wixua20l6kh5EG1m2QR5V+0C5RDv40a10TuNaLRd8bhFrgVBAuE
 jUGkHlnrH+u2a/6BBvhKZ3ffYRBAmjEukT9chgbXwTURhqnOwTXYHFmnPzAHEWK80ztA
 fD+wucgjZo6+UgA4toz4lLGgfR4QVdLkSiL1I7AwNzMpOfJ5nuQVKdvY5ci4Syj/6n2G
 UgMyMpPynBf7yjYK8gOtwdp83qm4EGntsZUwhYqx25HixbFVMltzgMIIWcg9CLwXdEMi
 xnjhUbwhY6qQnQ7B7/StHnLTy0D6J+FL2sSfNH+K2U0kvz0SxvbeussO1Kdf2HUC5ind
 +RVg==
X-Gm-Message-State: AOJu0YwCmQGFeCB+bsgD83ZeP5OG/oXrTUK4MmeAX97naSD6XFzRya1T
 rN10QEoxseBAtHdsq3rcjAJkseHd0dZUQbIoOBBPDR7Ox/28+S39O6oKG77CCy50Yl/AxtoUdZM
 pTrD3Fzg=
X-Gm-Gg: ASbGnctIHyiK/M5oFy3va/hDoQ6vy6tscfObhprI15JV7r16kzQeotrZbVFfu5RmiL7
 hBec4Te9oYypvhMpih5A2OpuT+LMT3q13DtAbnCKxjG9iydpCb0n20xOGGXXAGqcel/EBtXqnff
 UjefDUhYVOYeXyJivaIgdCnFBgdOYdLqGnD+IIFjGTo1NZnx8df7/fF8/CutyeFTTUOBSCiGxW/
 bcgZ1s+NpLQ6lXnmarYdxk/Zdx7CTNZDQNAOBqVSMxpON45aH8oK6nknq3To+e7ZQLIhUeBSk6Y
 W/s0Fo/ng5KrL7CwG7cn2ypBgmqYgX+/+vBaDuJZHtlUKiVJ0yEK+6MqBFXDWbuhumVcb0h6f02
 RtIRUzee0A681fNrydtIgakqjGdlu8OtZcFjuozRLxVHhLeftydvaov5e8ihNIaoYZh+2/UHnNY
 5uaJ0kovuO900P81ZPzjMw16RM5bkAt9iEjmguiQZaoSBuZz2ZFGTGzeI=
X-Google-Smtp-Source: AGHT+IG8SyepO8HAE4XKAL4Hjo11+ewbrPLiNSuCnBknM7uUOvKDJVBR/LhWSReNENe8yY2P7TaJLg==
X-Received: by 2002:a05:600c:680a:b0:471:13fc:4ad3 with SMTP id
 5b1f17b1804b1-47717df7ee5mr17662185e9.2.1761630546982; 
 Mon, 27 Oct 2025 22:49:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd478202sm174432655e9.14.2025.10.27.22.49.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:49:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/59] target/arm/hvf: Mention hvf_sync_vtimer() must run
 on vCPU thread
Date: Tue, 28 Oct 2025 06:41:45 +0100
Message-ID: <20251028054238.14949-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since hvf_sync_vtimer() calls hv_vcpu_get_sys_reg(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8095cb0805a..bfccf5e9a2a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1764,6 +1764,7 @@ static void hvf_wfi(CPUState *cpu)
     hvf_wait_for_ipi(cpu, &ts);
 }
 
+/* Must be called by the owning thread */
 static void hvf_sync_vtimer(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.51.0


