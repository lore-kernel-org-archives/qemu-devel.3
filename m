Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9E9E6ADCB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVZ-0005jw-5h; Fri, 22 Nov 2024 17:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVX-0005ig-I0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:11 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVW-0003jR-3W
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:11 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-724f42dcc54so26407b3a.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315929; x=1732920729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmstBEWZ50Za7IRe6C2dqQ3XXwaKAhfyFkBFHFaPams=;
 b=iAq/RaiVNuU6GpQQXOiv+yoZEAjhjUttIHyGwv8Jaj/ID0nkw/aquyMm7MLd3aAV0q
 PabtnVLJ/8uwL3qXptY7ITDvpshE9U3YDa1N49z2hIRSxGDIZ9ixYRFrX12K0AlEVECB
 nJvv/K7HGgmz1E8ECR9HoReRVqYQmISfgFWvDygXp0WZUpN9Yjlk3JM9qb9488MatQdK
 w/FurZLebZJjj7/FkYxq88LJeQzAYtukF2MxHIzRb+tSVAb2ckSD1wjVx4N9ygSNStHK
 7nCXlGkZWF3WW/oGmqDct/N8COwMtTSxDtN4wJgHrHgVKx33GREMzMfSffF0qSgfcFN5
 pkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315929; x=1732920729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmstBEWZ50Za7IRe6C2dqQ3XXwaKAhfyFkBFHFaPams=;
 b=bNENfq88tuww9yVEXiHlYXWjvAaIwBo/48e3VbSgd/68iWtoC27rv3Fy9LoXRFIZHe
 64iXFhmigjbTwHSJXhg6tJwZ3uuwYWc9prRo0oExaS+hED0B21oQ/PuuVV+frjDyTsKu
 QbRi95GrVh8NF5mu2t9oS0P7HTb9cPfUScT5safL88vVIwUzS0zdz6IwmrVd0W1s107K
 jHyXbR/G1FInRg5i+mjjNc7V2l+dLxISC1fSAruG4miOd+Yk/7zm059bZk8zZ4yF2CwY
 V682qBO9QIq7FvwfpajdPP7i+idqDygXbivpZCydUpGqSPII02cekygmQArOqblF8IXV
 bwpg==
X-Gm-Message-State: AOJu0Yyz3NfXH0XXBWgAlTXLmIy+YKqOBFunzujBWB0UGx/I7AeEXxTJ
 aV8UlplHhIlXtH6Pm5qpqH3OjOo9SKtdRdFNmyFYp0Qqw7lFbnum6dq1ixODgOb7MOSHlTuYj+/
 n
X-Gm-Gg: ASbGncuHrPAzq0jmIx3vkneK+MutPVRdREehcERKAwXqjr1WMVjnqMH6Gfzo/CkapKo
 NtpiSJL49lvWxD0iuDF9p/NbG9lsdZeW7nN8QTtF7C/ad7rsiEl5EngjLnxiGLdptP60D68aFyN
 VYCOJapZ+iUDhPs2T7q4bZbY8qlpcFgsqKf0LNnG8FZowqx7vR+DyG2oPfP9H132qlhbya66X1n
 lBB8w7qlqE23oNK/vDYg/TEft9lrOUP/md63kdtCECIO9laUrmK6yDpNx2njPgBqvJx6RYhK9wH
 9whsYW95tsXQ3A==
X-Google-Smtp-Source: AGHT+IEavfSCRoqZrbP2bJNUWIQ21VT2wKIqeM7yraG1CvXU601S5Uvxh1e6I8D59/bEmcPZq/nHzQ==
X-Received: by 2002:a17:902:7241:b0:211:ff1c:e611 with SMTP id
 d9443c01a7336-2129f576484mr48093465ad.30.1732315928808; 
 Fri, 22 Nov 2024 14:52:08 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/12] docs/system/arm/: add FEAT_MTE_ASYNC
Date: Fri, 22 Nov 2024 14:50:42 -0800
Message-Id: <20241122225049.1617774-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 50d0250b1eb..47f5123a31d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -94,6 +94,7 @@ the following architecture extensions:
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
+- FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
-- 
2.39.5


