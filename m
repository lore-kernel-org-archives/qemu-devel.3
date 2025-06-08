Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40744C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 22:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOOru-0005CJ-VP; Sun, 08 Jun 2025 18:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOrk-00058q-Bu
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:48 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOri-00031Q-Qf
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:48 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b2c40a7ca6eso3517709a12.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749423105; x=1750027905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=nkP5VZQjbW6Tax0UAlX+BbfokzkKsEFuM/AaOMAaUfAdUkGX6RLuYZH8yL4It8u2u+
 CuR3/7qmk4yrN8wZL8PLTUp4syptYCF3cA4aUZP985HC1iWhcfNFFqWQPUs1sVHHhzEw
 8/b6DA18WK+mah7ntLJnHgrj5Z6lFa5duos1g+MnMj1JOpXwjVoiolcrv48/Yln/+X5F
 lYdEsI5cfmqyxWDP1acVyj8l18UdoaxwuCkZmIZpggC9JIXGX88cnvWnmmzNS2yFnSLH
 HA/k9+HK365Qzf/MsXaqJO99BgISHxCZBe41jnK2fLaaEC5b6jrFIHfmQsXa3RMf3Af8
 uY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749423105; x=1750027905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=KCz4hAdUih8ozEljDhsgCkiWXo6w+p4hlkho5tgr7Irwlr7THkciDJ/yeDE6JxAiTj
 iccLIFwHZoOVHvXqMVj94jXhaDb6DjfjMYtuUi+91tOFgL7qYoUSB0POh20l80GfQ2Pn
 D5s/nx2wHaBpe9ungs3DdYQFoYnp6Br4bcdhr1J2IZpNOX68exKwOlZLas6jDuQSo2U9
 xVeKe7wbBOpvs8d4I4JkL2YJbSYPjj22lH15S0kEwaBZwsbot8fWJmEDX9ti2hSBxhM7
 1dqFyePVSlCKrW9v8+FE8XKBYLCoSZjncP2vPWndSDRXZTnxxb4COf0QjBxmGd4e4CWa
 XiWg==
X-Gm-Message-State: AOJu0Yx+CrluEr8KNJFg1FuSGGrQqUGQhMzkI45lkP4uWEBJr0/ZfoXF
 7uMRcHhtXd23UuVFZ6q0tlvV6lpmuIEBTdu32zcHaecuXuFlVtEq1ymgcqZaShPY1QA=
X-Gm-Gg: ASbGnct1h4zUzoNnrl1ezVY6Ncl5LqRKdBANGIIQbrD0ciO9ZuhXbF89mR4uUxrn76n
 bPgnMuQpFBBdcvObL11gAyCv31Qz+780XF8pFbE6rGcc1lX/KwXmEgZObX9YPMN1yJgBqplGmod
 6wGQz78yu7VlCHjd953CnvfwqA28fE7OClfvt4M5CRk9CNFufuCzE4uK8gFSIppIJQnZN/rjKYT
 TQNoIjLQvBeYtrtl5Gfmkqi9uAPRAzRbFQx0FkabTrfYNjoYQfAVdp/yCRFbGkQLp++KqhAMiZy
 PA+WsbGpu8Zc/q0CPB9r/jf0uhXbwq9Xu1F+CTEqArTZ1MQHiCZ3XSHmt4YIbQ==
X-Google-Smtp-Source: AGHT+IHVrOrOPliO8a5wjVXxY6WuUiQZ8G8fVHzC6CGywg+9IBViLrn1yj/bmrr6jrmIDpAbCg9ODg==
X-Received: by 2002:a17:903:244c:b0:235:866:9fac with SMTP id
 d9443c01a7336-23601cf0a49mr166529645ad.2.1749423105333; 
 Sun, 08 Jun 2025 15:51:45 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b128012sm4395970a91.32.2025.06.08.15.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:51:45 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v8 9/9] plugins: Update plugin version and add notes
Date: Sun,  8 Jun 2025 15:51:36 -0700
Message-ID: <20250608225136.3340370-10-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608225136.3340370-1-rowanbhart@gmail.com>
References: <20250608225136.3340370-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x52d.google.com
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


