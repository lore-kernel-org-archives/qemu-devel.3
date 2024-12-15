Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD58E77183
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0z-0005qF-41; Sun, 15 Dec 2024 14:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu0C-0004UR-0g
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:04 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu09-0001Yz-Qi
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:03 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71ded02b779so1778978a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289800; x=1734894600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6+2f1Qt1iQIeMMghV4HJ5IGr7dqh4AUipAH5VoHJh0=;
 b=RwsVarAYPgwtvuSWoBVqNdWHXtOJwqbNcgaef0U0rRbwjkBqjkKz6KOFJRlgM1Gn2x
 2eUekLhPfJ/sI+8szMXKJFI8/kQ5PwTBUCHIGCe3zTToIY7G31XvvxujO6kTm79Lmfcf
 7EKjyxoalqEsL5+WLC0LRzRDID+oN/RfuDo39WTS1Gsy5w6qW4BXqAaMjlFTuZFxHTeS
 ToIK7pZv1qs1TFlkWT4QPQ/T7wFB7hwdvquCqrSmIzeiwWa4ZLrEOr7zLh2+Tqxh6WFk
 ajoCpZrPBOJwRkut7rPKuWEBXTh2g8pUwpcSTGL4pZ/NFKWZmFXjBORRvDRYMuQNnzHP
 Xr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289800; x=1734894600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6+2f1Qt1iQIeMMghV4HJ5IGr7dqh4AUipAH5VoHJh0=;
 b=B/xSMPmtmGsUn7npBb13MWhOOSj11wHzmHNONb5XHfW3umbtXKs9D8XRQvYle0bDC7
 emPtdEZPKUx0VFKs4xBrpZ7UyCTe9C1C6LjCD1O8IF0aPxjFVgLN0fPoXdG0d/aGfInk
 +MKdSw9/9pvOVWAzlLn9nODuQK3KjwFDJ2plPaR3rw92bSnenDvRgoB2y8kUhNdFEoVk
 o51AKYUt4QFcp+xwgNWGAflNJ1OO8Wh4bemFmvlvTgGPncF7gH87lNosXUUukkAaZzHF
 BS9dvk8bj7oXsfxO1Az7nUy3CN3tPS7JnLIYHvfme6wzrhaQz3opZ1O/nQ5eDm9lrvci
 mx/g==
X-Gm-Message-State: AOJu0YzM6YgNVhA6mb7Ygkvb8XZI7ig0taLYajaV2Vrr4HsvWiBJleSh
 HKFbm9NriV/rnsrBZnPvKwSq5cYTl6nXdzLx9UGzh4uhsDyF4hOBhxsGrVVXH6dkaIqGbKj1Orf
 LLfgiVCfj
X-Gm-Gg: ASbGncuAILFrRILRvyPVJQTW0r3IOjtF2UHPRG8TD8o42iAjP3z0ioeqZCZa75yqNrY
 fI0dDaxtFoSEcxaINCAFE8vvqGqlsEuJc2Hl8YaPDYBPhe7tBiD67C25+0Hv6NH1Y5SBDTH2EV8
 UHb8oomMJUIJUSA+y+jPFG07M9Aw+XmaAPgFelYGn5TkR/wzBn/M2xmNOi4ILbzLREuHjX1VnFH
 PtlsWZ3crMbvQEv2lyXOGk7yHj0DblU5lGtRmfQmkTVS9XIPQE8UP62vC9y6WbO1g0YOsFMZu+w
 VAAuzJ+/gFABJTSiPyP8pNVFXsSeVizxX57Xjmd6ync=
X-Google-Smtp-Source: AGHT+IEnW5bRe93Ynfg5XMkLI9FRyM95SbH7D43W3bwy0X1V7Be2KyQhoC7SknTI9FqJuJOBdMBkXw==
X-Received: by 2002:a05:6830:368b:b0:71e:946:80c4 with SMTP id
 46e09a7af769-71e3b874820mr5890609a34.12.1734289800675; 
 Sun, 15 Dec 2024 11:10:00 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:10:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Jason Andryuk <jason.andryuk@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 65/67] hw/xen: Constify all Property
Date: Sun, 15 Dec 2024 13:05:31 -0600
Message-ID: <20241215190533.3222854-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/xen/xen-bus.c | 2 +-
 hw/xen/xen_pt.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 95b207ac8b..0d7defb8cd 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1092,7 +1092,7 @@ unrealize:
     xen_device_unrealize(dev);
 }
 
-static Property xen_device_props[] = {
+static const Property xen_device_props[] = {
     DEFINE_PROP_UINT16("frontend-id", XenDevice, frontend_id,
                        DOMID_INVALID),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 3635d1b39f..557aa98be4 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -931,7 +931,7 @@ static void xen_pt_unregister_device(PCIDevice *d)
     xen_pt_destroy(d);
 }
 
-static Property xen_pci_passthrough_properties[] = {
+static const Property xen_pci_passthrough_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("hostaddr", XenPCIPassthroughState, hostaddr),
     DEFINE_PROP_BOOL("permissive", XenPCIPassthroughState, permissive, false),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


