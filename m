Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920BAC677C4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 23:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOP7w-0005uh-7l; Sun, 08 Jun 2025 19:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7u-0005u7-U1
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7t-0004dA-Dm
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2320d06b728so31924345ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749424108; x=1750028908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=d+6uLiJw+Qagwz5f9pr3X3cWvJGJ2qP9laS0CrVELeIGNXVxx2rzLsX44LjeD4tlBv
 OBosR3ue4/bOnI20KkzcQdx7pOGOHjEe3DUlV2Yiti09+sWmj7CMQ2eJd1x/2+7qbbG9
 ar//6QQPl+5xFdjzXhc9Y5jcmCU0iuZE6BcilXiEBxqXhlVy2MhoAp378KXinMByufmh
 iKeIK83fJzg7/F/Uy/dprScoDYc/878rbC0DPDW/GUZ0g/M14DO0C+fgOkOONaC0dXby
 MXSQ2wfILF2K03xIYh6kyLU6bn/YRqxW7fgixqCpDbz95r9MxOmeudPBf7xAIOAki40G
 PXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749424108; x=1750028908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=iR697pk2RGgmXAu5KLLzbqcuZ9NdfrEBfq4Jl7nWCDbjpTNKdy2L9PsRD4gvCRmuiR
 2AaNh0imwWLyko4RJht7qmA0XNe52eYoEnticQY4QaW5drPP8mDoC3dMVr6jyMIruXxn
 ZqJzLKkXpw6nzBb2+TyIUB8At9urIxinsaXimGx9Qh/mzM+8mm2CKFdsbHwtZrJxUMXn
 DxN+CeL4PwKZQRz6zEY7WRYaqhIHEQcyNi/+VgN+S2AY6OZc8B+EdSMptXf3jHTTtmBH
 cJOFTsQXH/3EohBAGkQtdi6hy3EvmYhI/hEiSbEzPof8gmEiHHcarxUsdnHPGWKL//9C
 jlyA==
X-Gm-Message-State: AOJu0YyuL4kINXDnlwNAvl239BdKCBfnRW6z2lvNhgkuCaHWo8R7JLHF
 QXQYsqCJ9bqJrzz67+MF85gjHNcb8SmFvGrl2bn7ysgBuOqOyeHjpBlpsmY+NKh0RSo=
X-Gm-Gg: ASbGncvr09A0upNuGECGMwCC2qZk1JeAhelBKHbwkIjre2cU8bbAkdKibJf1ETg4HLk
 MYS9lvoAIMNREpOsf44plZdPr3lMVxu/1mGsl9xkd86t60uGZjyOftny84jokLVyqKsMOqRL6MK
 jBvl2C4Yt7MA0U5nipYKU6NYBh4O6cxXSwiwMt/d6qTievT7jaKMse6DaA+UAfPTj08jNrCuWBk
 R1PWAgOr6OPSiJQwDBi1lT21t6IYjcbtdpq92tPC/PY0p1lnCsFXMTiRlj7DwssbefHva5pPN5F
 im/Omm3rWQwdyqKeafJoF6mLwfxRnAySMUXZttxIk/4Uf9Hez3QJdmWhTDGWMg==
X-Google-Smtp-Source: AGHT+IH2suhQxXX/VqnJtSEqNAfS34Gc3VukV3jBVRTogIa9BnS3aSK064cHp377sOflD6FVHyyjWA==
X-Received: by 2002:a17:903:3bd0:b0:234:8ef1:aa7b with SMTP id
 d9443c01a7336-23601cfe4a4mr142402545ad.20.1749424107928; 
 Sun, 08 Jun 2025 16:08:27 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504f09sm43421325ad.223.2025.06.08.16.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 16:08:27 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v9 9/9] plugins: Update plugin version and add notes
Date: Sun,  8 Jun 2025 16:08:19 -0700
Message-ID: <20250608230819.3382527-10-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230819.3382527-1-rowanbhart@gmail.com>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 2cb5de9f64..170a79e667 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.49.0


