Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E26BC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHei-0006HH-DE; Thu, 03 Jul 2025 06:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcZ-0004AV-E9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcW-0001Ie-3C
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4530921461aso52351205e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540206; x=1752145006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avPL5wc3uCAbxMdjiOjEAiPWhgKLP3dI+/bwFAvHMvE=;
 b=VrBrawMtvkFTzczYbWxkowUXHucat12q/izN8/3Jhib04TlsFVl9OysdbIojz6Z0Q9
 9MrWH2RJOmtaWi9HLA3ncio4cNmJoMnuADTe5EBfhaS8vsPvg99bvRr+/DLK7QXoO1AP
 e9g8m+z8KPtK0isvV4tHrkmPUeT94SpSy8wmIw8E7csJiXKfJW30sAFXx7EwNPksmLaq
 ufHZ7SCTFnfa1SsJkCW/eUvR5EflW78Ko/GbwAQLqjdWU8sLuUvXkq67B0WRggVZ+3ij
 XU3QdK88o+0Xw72za9ysUL4oJBukDN7g4Q6vfAw5aUIQqB2BjtBDqKX7rTxTRmDuMRSd
 bYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540206; x=1752145006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avPL5wc3uCAbxMdjiOjEAiPWhgKLP3dI+/bwFAvHMvE=;
 b=gDjgqblFfVD6KwZFexa1Mst+9Pz5kJ0kyIuXopvSV9lTNOZ+HtpGxHb6llj+QduaIe
 rXwjr6tT2udp0OwjvP5IRFOGJy3Y0OD3MIKsC3Iuccm7gq6LqE6VBEreoKQYQnBexDZ1
 INnm4srcgHH0BGHJc5oR7TiH6Z7AajBtgusoEHtMP6NotlgMzcKuOehU80MlShOwgB6/
 +zQ8eiIb/gpZvqpdpyTEvxqttSGQ5neYWzV2bVUHFyC5hhCj+BUZbiQYWqZR9H5MPsx2
 bAtYCL3AcUBR+7GYalzEeYI5bsvPjuSI7WW4i/CDop4aEmwnqU4gS5ZJmFXc3i3AcwSH
 WaxQ==
X-Gm-Message-State: AOJu0YxkogArwUlpP77SA57HOOa5Z46/84XwMODzVIOL5Vnfmgpf/v0D
 EOm55WWPs2yDWEoEpZOXRfRCeC8MVs0TimTr3S5mh4vduclJ65MbeOa1wHKpfwijaOtaeWDe/ew
 TcP4yuYk=
X-Gm-Gg: ASbGncvl83rAHaJsiNX9fNvA91JOQRUoMMaIJE42rXWSbtoXcCKNOVg4ehRcR3MyX4T
 vh4pQq+sh3OVRlvKZQdoa+2CqZs1wfSLabmQoRa3if8YzSm1pwK3LAxq35OBhK9trKHF5lSh71z
 igZtNs04w3v3e5Zkrj6NEWQpPNcVaFiMrNf7jHnSmal166l139MulvPDsw1qo3uWLZ0L0wQFgYW
 Hmqrn5k0US3sxOqkCNDERbJ5GH0+XQiez7s5lole39xoch2U1BnazqfCdBD2Z/hMr6jQPVeQ4Ye
 /gJpxDorI2/fbwU8Zu+bpzOs1qSn8qAu0AhNMNdpahn9Mw+yy0lTe3SZOVYdY0dmRJzykPNvFHl
 u0y/WYEuH/DM=
X-Google-Smtp-Source: AGHT+IGyPvuqIv/SGuixXi+1VvkuwA0WJu7ZVXgAGGMvrrytdxcSAu7kAXv18Jv+0lv4kiMADofGDw==
X-Received: by 2002:a05:600c:19d4:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-454ab3a90c4mr20498175e9.22.1751540205880; 
 Thu, 03 Jul 2025 03:56:45 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969a20sm23570015e9.1.2025.07.03.03.56.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 12/69] accel/hvf: Re-use QOM allocated state
Date: Thu,  3 Jul 2025 12:54:38 +0200
Message-ID: <20250703105540.67664-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6af849450e1..c256cdceffb 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -325,7 +325,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
     int x;
     hv_return_t ret;
-    HVFState *s;
+    HVFState *s = HVF_STATE(as);
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
@@ -339,8 +339,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     assert_hvf_ok(ret);
 
-    s = g_new0(HVFState, 1);
-
     s->num_slots = ARRAY_SIZE(s->slots);
     for (x = 0; x < s->num_slots; ++x) {
         s->slots[x].size = 0;
-- 
2.49.0


