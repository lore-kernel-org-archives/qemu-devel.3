Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BB0C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb5-0000NN-6E; Fri, 02 Feb 2024 10:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb1-0000KB-M3
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaz-0004To-HO
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fc22f372cso13027445e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888207; x=1707493007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZWs5NQ83i9qIQWdiDsw7uY28XWqWXL7f3H4Vv5HjyFk=;
 b=oWy1M/0+YRXxnBTR9lTl5NwH3CaBOQO/Xo8d138qwTz6fx7QxX3Hw6t2zZaDL1fuEt
 k5ZCX3xfumf1hvNWqBEC+nPuqE1t08/odr5JmtzyqeVgjhDPCTapZojiqNpMQJNbxbHq
 PRr495DWl1Ue8gQxYTnGkMeyNb9wsqK183qg6VOj1G1YmdO9Nyq8v2Ke+p2Zx5pWN/Cl
 1rcQu1Y88JzvpeF9KfQjGn9Y29j3YjhqVxuECetDH9kuF/fk/RMg/u8j4BF8Qf7jU9NJ
 2mBvSb20z6yprHbWOuLfafPaoldrPYZh2AOswYa/6LU8xZ80SkbyTNw1J6Grs06I2BwT
 Oxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888207; x=1707493007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWs5NQ83i9qIQWdiDsw7uY28XWqWXL7f3H4Vv5HjyFk=;
 b=k1OfqBbpAzmFFyg4K3SFjesbjC/mHQL2ta078S0EHWL/5On+PEgnhgSoIrw6r88JRw
 xYTa+SYaJT6NhtiuTxx3RvNJ16sTuBsunuxEJfx+BZCFWaXP0YwqgegFao18wlg/zWsh
 rg5gNZmLMGFuxnGZrN78pLfOD3mze5+Q9zPptwvuFJz8rCdY8B1Ag9p3rICcXrxUuLR2
 eDzCk6VWVYqfW0zBLhZ8gYTdjyqofKXC/ui+m3R4fupwj/3e+xYd+vuceM++RwtQBdrB
 fuBIbNQnNKOUvuCsbGnwrpG9RRwgsptWi0Gka9oBkXnVtV2ihKy9bCPI4WyeB1C9lccz
 lbMA==
X-Gm-Message-State: AOJu0YzQoF6vjccjIgDEU2p8cNqdxdKyomFyR1xAz4I8TmHJk2jeLvhO
 KySkdZbzvcDD8w2ky31Khb+sXKY1stcUg3ZL1jhD4X+b5dW10mNBhx/9q9GZct+ldhuPL5mPWjv
 V
X-Google-Smtp-Source: AGHT+IHYqN0mgP1AKwNRqrle4dSLA2BlefKdWaul/a4T3jBkJGdElOV+nuNrbS+ES44Jr+iPySCIqg==
X-Received: by 2002:a05:600c:4f0f:b0:40f:bde5:763e with SMTP id
 l15-20020a05600c4f0f00b0040fbde5763emr3450154wmq.32.1706888207230; 
 Fri, 02 Feb 2024 07:36:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/36] hw/arm/musca: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Fri,  2 Feb 2024 15:36:19 +0000
Message-Id: <20240202153637.3710444-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Musca boards use the embedded subsystems (SSE) tied to a specific
Cortex core. Our models only use the Cortex-M33.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Remove the now unused MachineClass::default_cpu_type field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240129151828.59544-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musca.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 770ec1a15ca..e2c9d49af58 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -605,7 +605,6 @@ static void musca_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = 2;
     mc->min_cpus = mc->default_cpus;
     mc->max_cpus = mc->default_cpus;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = musca_init;
 }
-- 
2.34.1


