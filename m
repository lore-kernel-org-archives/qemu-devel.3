Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B76D33994
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsQ-0005aQ-FO; Fri, 05 Dec 2025 11:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsE-0005XO-Os
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsC-0005ld-Sl
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso19642235e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952895; x=1765557695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rE+4JaESMxx65UWEyNZXMtlyYKEPHX61flyGj4szr4=;
 b=n7FR25De3DhNiobrbrV1AA1/a/SVWeAfYwp3PR6KXRpIJ2BdDO4t+gQUvlNzFxzu8u
 JA/dx5zsNTEn3yhbVt7x7YPXa7YKi0b6TPDykDg7mQA74e7pQz1cvynY6Ah68AXatuFC
 YnFq93bH69t0GbqxrQLQtDATS52lT2365oBQfjBadg/5NxHoAKNJ+B3LOfisFl8LVeIN
 amKtJQJoz6tSI3HbqtVmJ7wU9JTt4zYekZV2/TNN0YOKAVtTj49PgXGel1Y7H9TuOyyb
 3d8BUf2gm39RDee2NLTxqKPyveszYMO+sIW8Htdc2jv9XlxSgK/ih38/Cx5K9D6gQkN4
 Teug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952895; x=1765557695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7rE+4JaESMxx65UWEyNZXMtlyYKEPHX61flyGj4szr4=;
 b=eFfkAm3XDu4f9AK1wasTC74iYifz16gu5hPxFFHb1CBQYi7t0u1Np2ZYOGxzowIAFq
 +4mq4SedipbHq/T4BvGxO3hNHZpnMlh7a8Ls4ZYd+4YHvAK+uKw7V4tz/t99R4OQUUUU
 2h+y+SkWdphJlFD53LRt9RrBHo3HFZu1ue0F47GmOdCTu139BGknD0uxc1xBZk75ymPv
 FqBiebVsRCnqEkQoL0m32AtLzt/eq31SnjyQ7R+s6TjwqvjxGWCRsdZWy4EMfhRvvqH3
 +etLpezbaUaNuAsOSo5gf3dBXHafI823MEX/w14dDkno1K9CG0jJCO32YhEM1jehg+sy
 ebkg==
X-Gm-Message-State: AOJu0YzLlxU5qcW3RJez2nh4mfVuu6kTKlcab+cq3RT0aXJZGLnDp/ZR
 ucTParkTtIqVH2WNhunxmlBLnx8gf9kfYgsflFDxr1M23vdvtxq7f69bIxPKIBfHVXk=
X-Gm-Gg: ASbGncufPSSh1eE8ptNBvmCv9OPkd884Q1WqVGiuPNBNVOFOOcVtxw8SQzxxcVVW5nM
 cBY8CUhyv98AcocqBF7G3cfjNR5DhXL0VCMHI4D+EhJ3FqP70wWcrOAZYJWXN8karID8eGeRe4o
 FshQUho1FLY1whkj8YABLta13JeI3SciPRyeseBALU5/0nF3qa5reCEMZpkNDlxL7ABfVBL1CrS
 w9V1Ky2ZKnS83q6RkJa9jgIDuzCqgTf3gNEdABBMtw0R0UWr3PfwxZUqAM8+cA2k7SvgrB5qqNJ
 AQftmOSjCkLm5o4/0m7IlhXwFK3g5qR/NNFl4G+Af2cOiUuCq8Q5AyH4ao/r9YW7dVfZBIFC+UG
 nmjBgg4jrSgwhqRPojeoYE96DC4ae4xIPQgMcj/IGknu4M+AnT90ctSnTrwskBhM4vMbvY7CqCI
 YCtw17knVwwyA=
X-Google-Smtp-Source: AGHT+IHAVk56YLlSRLmDP26XUGgLhNFVMdahiQOlO0jnfZkZey8YU8yWsky3Rj224nEGT8qjlyPULQ==
X-Received: by 2002:a05:600c:474b:b0:477:9392:8557 with SMTP id
 5b1f17b1804b1-4792af30ebcmr109932175e9.18.1764952894598; 
 Fri, 05 Dec 2025 08:41:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4793092c32asm93574865e9.6.2025.12.05.08.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1EEF25F913;
 Fri, 05 Dec 2025 16:41:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Ganz <neither@nut.email>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 12/14] plugins/core: allow reading of registers during discon
 events
Date: Fri,  5 Dec 2025 16:41:23 +0000
Message-ID: <20251205164125.2122504-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Julian Ganz <neither@nut.email>
Reviewed-by: Julian Ganz <neither@nut.email>
Message-ID: <20251204194902.1340008-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


