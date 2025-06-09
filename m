Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F1BC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOi6I-0007xW-AR; Mon, 09 Jun 2025 15:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi6B-0007vv-EB
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:59 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi64-0002Ri-KJ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:59 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-312e747d2d8so4072981a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497029; x=1750101829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaQPhhHbCamu4uXY+C/FHHXcY6DZYaSMK3JVJyC1xcc=;
 b=Mch1PvDMr3pVTeYfIYtiMd01slxUsZK2rrY/ePvHjzs+X2NJoHmrU6AlLoMCUQC9HT
 TVNlJgBD93XMHk7B9smEHhNKJ+tJ1zkbh3aefOoi5lk0XysN6gb6u0afu6MNT2o82Vex
 UNGe9n8uLXsnawoN83zFpeXSy26B5a7Oc5OZP3k6QTxpgIkn2CQW695Qj+9jDMteifuC
 DQ7bci6TSs+TGAb8JCPgjSQNGCMKnI8Ks9XWIVzGIx8Oqn6oEdqCdvU+KQKxGgHji//q
 KcdscBDyf2MkWztctjfsdFuMYvUaqRyR1Fp/Ytvz70HizJW18K7ppnv+TTMnW7depN4y
 MSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497029; x=1750101829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaQPhhHbCamu4uXY+C/FHHXcY6DZYaSMK3JVJyC1xcc=;
 b=wfoPEk7Uei2Ao/hrvJooR0BMbC1Jk1S1ylJqnj8cp2EICK7eQYI2aFjBKD9347S0oA
 h7bLozZXWiHYaD0UjoyeH49HrMoRvNy7wc+ZJi6LhKiYttxCVu0W14ZOHb6JpPB7awBi
 zUZXiDwXUaLo6TK9tK155Xm/vt/68PUFlwRDW6/hA4JQCYiQjOBwAn31bYhb64Yton6i
 pH/dbEaQje5Pk0OIMFpvO3QUdPbBevrhg2zCfPpCGOXiT7KPReruzHKB0Du3hEHoAsub
 vgGSQ1IRC8phcp0W7zQrvDsEQGU03yjBGpJFMeqa+ivE92E1lZ/bRQQcTMtQ4dX4nVfR
 PT/g==
X-Gm-Message-State: AOJu0YxZf57RNmbHWua8HjBEJG5o+iQIhj8pVGbmQ/sxHcZ5SoFsvZl7
 1T4nBbD5OqmY+9QH8ve5j5urItcxgwYHcxOE9NzxFT5lh672wTiAuBDdjcLL8+c1
X-Gm-Gg: ASbGncsTKlSAYnDCGA0ahfk56ru4561nEzgoVfurls9gAJCVl7i1vKXKjflgSx5a2su
 Pknv4H9Ea8MuAxGEpd8qA9fT4vKJDf8WUk03asCK74zRk1Xd1WF45Tgh6yNLCXntGZJvHS2uQI7
 Pk0w7gNPXjoMIycafGbMwNT0gLxGFGTafX7CoOmSSZtDHxMFFRrzZI+1pIWPYqP2uvM3LLgt5ON
 seeAfPMjyjxnVJrgLYFKyGGcCKEv2zPIhidVVM5MaUfsYv4wQAEfaVWPO/aBgWt9c9HMX57x7cj
 TIxFXiy1IjE/3QYn/u9KHQ7fB8gazXveV+YJ2Yzu+zUc9mlYKV9bSfv+hMIKj1eudKbkHl2+
X-Google-Smtp-Source: AGHT+IFvNTGo/vEhg/QZV8d6HPL7CP2k5Zz64RO5dAZ9c0LYUXK7bwk95posZjnYSbMCFRTDf7w8cw==
X-Received: by 2002:a17:90b:5291:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-3139dfaee85mr859239a91.3.1749497029281; 
 Mon, 09 Jun 2025 12:23:49 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b044ef2sm6057658a91.3.2025.06.09.12.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:23:49 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v10 8/8] plugins: Update plugin version and add notes
Date: Mon,  9 Jun 2025 12:23:42 -0700
Message-ID: <20250609192342.316156-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609192342.316156-1-rowanbhart@gmail.com>
References: <20250609192342.316156-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 5eecdccc67..c450106af1 100644
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


