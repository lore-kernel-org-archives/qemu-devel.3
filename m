Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BD2D29FBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKH-00070j-D8; Thu, 04 Dec 2025 14:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKE-0006zP-Ud
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:14 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKD-0007NC-40
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso14551495e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877751; x=1765482551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATqSGwuBrxD0u6XQm/ZM2RowzefB/jG7EGwLrbJNsjM=;
 b=EcneuD6jlfjRZN9TQf7duAYYSDNVwb/NamlFBEXJdgGs4IZDafHWE9B5pcSrpe9KCj
 lMNwJ+gtUBiFHqAfTJ9mGgT5/Fw9yDLaNpbCcDXitMbB9ZqKtwmka7XuLZCyqoEva4bG
 L+9x3LHy9i4I6iFbLoVzIXDeAE/HYqd3rOeiGqo/t8RfwWEezFxg87nvZpnxPm3r5wEH
 g9rXnJAdFX+r1HvBM7B0TNpgj9GP3tveRRJTiUL+RIhEmaU4lJpNUv9KZPN4+ZOpQo0d
 fvxDD+DFsjFhe8mhqf8LGXAlMwKCbUgt5j9GIo4uMo0O89qtzSixbxBXzy/F0IvrJzYr
 cAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877751; x=1765482551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ATqSGwuBrxD0u6XQm/ZM2RowzefB/jG7EGwLrbJNsjM=;
 b=TtpRAKLBC41K5G5U0B8SsHG4lXOIHp5eADzPdA/Bk3vT7JDumv13obuJDV5AuYybd0
 EGbPhavzpMOcUAd4k4AYVIqiKcXCMEV+g1+UsWHkspW1h3OHZfS1/mKSgUvGyCJ07Sap
 MXCWgeAFX24Yk8aK4hfd8QP0KhYeFXVY9hAf0ynwml17bzEWua7AcE1qFpiVvdKc1Bbh
 LmyanV5LU8WwrndvKOHXrR1Tx72Rln11DsYHeuNjMeK0gQTGJQVXXXzs1xIlGNqocIu8
 VCRnOV5QvP7IN8HKD2fWhZJjd5nx9XVsG7kYM9rlKcgP7SmB/t04TvJbkcJDk95cfj2g
 qqWQ==
X-Gm-Message-State: AOJu0YwSV/pkP0YzIkTf2AV6ikbO1VfuBmw91Ybo7DqbbN7kX3RnbKS1
 poudiopQkkzs/wx2CeoIHxmbycXE4F+0YVZ4QMafYnbiwdbcKDIg/EaAxj9JnpolwZpIaHQI35y
 zZwjl
X-Gm-Gg: ASbGncuoBgNiEelCluwF2K34VHx7a7CN7QtZZeF1TOIGeHQbzhRq3AOxE/oCiALGASy
 kDc3/1z2x7OlcqByjSsXfxvmrCsdqDh8LlylRwJQ3BNe8EQViH3NNZmP8ZD1TmDgP5LlA7y1F4v
 sF143mMwYyC706faUMZCRNJTim8102CWgbFuN2VDlzlhFmD8OW8bOqqrAbc1g6p/dwEORxyt3vF
 F4m3bZGkAx94+1gHUwUzrUexIW+Vt471iZXMS7IAGSg+oglRY/tfXz7zKfPhlqDJG81QfYYo/ZU
 iTjsmLZrAShw0esd/VT7qDLzhmI7FO18fstno4HnPenu3egTlNqcO83SbyAVUsRXuzNncfv9NCC
 EcFtBa7qnTXd3LwkY8rNMd+T6pZk5XV0iv5iMssqjT9Lho6XXuwlZvtX0mACIU6MyN0XSOrypAA
 G7qDOwM7Yzm4shgI29ijvxGA==
X-Google-Smtp-Source: AGHT+IHVFWyRnT2MuS9Fztiv/ZdGkH6yRsuiZwr57AfpH3iIuYdyfsbTGF6k1samAcnmy3LLpRysOg==
X-Received: by 2002:a05:600c:4f90:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-4792af43aa3mr70283635e9.32.1764877751449; 
 Thu, 04 Dec 2025 11:49:11 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b157783sm50573445e9.5.2025.12.04.11.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC8275F910;
 Thu, 04 Dec 2025 19:49:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH v2 11/11] plugins/core: allow reading of registers during
 discon events
Date: Thu,  4 Dec 2025 19:49:02 +0000
Message-ID: <20251204194902.1340008-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We have protections that prevent callbacks that didn't declare
themselves as wanting to access registers. However for discontinuities
the system state is fully rectified so they should always be able to
read the register values.

a1688bc86ce (plugins: add hooks for new discontinuity related callbacks)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Julian Ganz <neither@nut.email>
---
 plugins/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 8f8bc7219c2..b4b783008f7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,6 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to = cpu->cc->get_pc(cpu);
 
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -127,6 +128,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
             func(cb->ctx->id, cpu->cpu_index, type, from, to);
         }
     }
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 }
 
 /*
-- 
2.47.3


