Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA4E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN29K-0007Q9-3U; Sun, 15 Dec 2024 22:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29F-0007Ov-Jm
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:57 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29B-00061u-SF
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:56 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f321876499so1745343eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321113; x=1734925913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DaDZY2PakYwtW8fn8wM9TTYAQMU58H2dT6JGLMZPUmI=;
 b=qzePmA3ph7gtye729jsj2XGO+jx7FBXlmcmiyjWpwiv3NMdtMxf21ntt+0EyfzCxxn
 1FCE8DiOO+e0z1rmyRaCoLtFGj0Zz6mXoLmzMSc4aYf1+GW3Q99VRI5HXnv6Kf8+Nvzk
 88YMDpJFj9RUoI6cOk473O1VJCAZy0AKrel+mhLIvhRDamKnpM7RPf8/xd5WMSopgr76
 ydQZIzdV2rd6KdhWbCXm0R3wzxI+1tC0Wr+ciuvoHMpgVKA1q/cw2pvkWw8UQJ3kNW3R
 wUR3x4tP8t8/n3z0c1+w5kMmo/pFD6hEnUlCEjk4TjrCxc54IK2Z+rc2bu+UoGSTmha3
 DEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321113; x=1734925913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaDZY2PakYwtW8fn8wM9TTYAQMU58H2dT6JGLMZPUmI=;
 b=JXy7ELZoybT1He6rXI3ipKSwyyE+c2wVGCg46L6VJKgLNMQZAoWqacXz30BVf/fqIN
 qaLo7nhFKY6hPJjvvBwznDRu6bUI0/OmNRaDtHjkgSSiaWotG2CzxZAfalbPkWqAIuL2
 FiXGrj+1d0EpePoZ/jJ8U04G4ZcASPfquYzXeeJrGMBb5iJmNBxwhtaN8WxD6EWZrckP
 Me8s7F5ZcZ6j9wuOENx3PMQtCvcU1fg+ZEHNDQWJ561CVWnC7NUJKpLYbqTSfRu6XLcW
 MkO9sosqLgl2Z8dug/IdrjzBVXkB6FVwxhwGAAuIr8F1cUsU8YLI0f+3A46uczW+KW2H
 CeRw==
X-Gm-Message-State: AOJu0YwsQfRRv5bsBxScHoEe7PFW7kvIPeCXUGdGBaViPYmsDyCBn18r
 dybbOkISRhW5wkpl2fxjT5naUibq+d06Ch7EqiXtnyaJ2o6cIyRAvYcRi/KhZiH3RPxuIvKSgA4
 nOAWDJxyw
X-Gm-Gg: ASbGncv/WqEwl6nW1it7ZW36H9b5FdGVcf2X5j4MjPWzudhKVI+MvuuVmcQyW6cRWBB
 gXDC0BjbAoIJYNMwxyMuf1jzc2utIvJzhGLm5am9WogqOwFkLrmwF22ixz6zz1su/X56unO4cR6
 9HiOdb9KT+W3O+I6iSAufzc0xixBGTuTKu7fcxnBFE2eflbQFyRmQ2dQ3cpBH79sedOQLm+Yyhv
 bfXIMY3RkaJnR4y0XWGuwDIzsmbUDonHtrVGpjUSA/L91yiRaP4hU46UWNfFKYNXiMkqs+5qR0Y
 tH0eeM1CphDUtujlNpT/av188BPCPbWHX3j3dGJtieM=
X-Google-Smtp-Source: AGHT+IEGt2Pn32YK3d4DOMXRbDlRJTeMqTXjNrIgljomyxAiHsj3nhZWCHGeq540Tmjy1gDfrt8l9A==
X-Received: by 2002:a4a:d310:0:b0:5f2:b6d5:bf53 with SMTP id
 006d021491bc7-5f3240152e9mr7890576eaf.1.1734321112780; 
 Sun, 15 Dec 2024 19:51:52 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/24] hw/core/qdev-properties: Constify Property argument to
 object_field_prop_ptr
Date: Sun, 15 Dec 2024 21:51:07 -0600
Message-ID: <20241216035109.3486070-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-properties.h | 2 +-
 hw/core/qdev-properties.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3680cd239f..447767688b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -201,7 +201,7 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* Takes ownership of @values */
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
 
-void *object_field_prop_ptr(Object *obj, Property *prop);
+void *object_field_prop_ptr(Object *obj, const Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(Object *obj,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a3d49e2020..61929b2865 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -51,7 +51,7 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
-void *object_field_prop_ptr(Object *obj, Property *prop)
+void *object_field_prop_ptr(Object *obj, const Property *prop)
 {
     void *ptr = obj;
     ptr += prop->offset;
-- 
2.43.0


