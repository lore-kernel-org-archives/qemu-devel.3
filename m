Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E417CC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dK-0005sk-Gh; Wed, 02 Jul 2025 14:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cy-0005MB-Uv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cv-0002R6-0w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453608ed113so49554405e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482569; x=1752087369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUziXsuFH79ftSoY2fSSF/M1EWCCj+e2HlfSQ3oWfeU=;
 b=h3ju+G8NB67aaeJktPL0/8E7ENlalIp0Z7XXYPdO+qR79OlQ4j5iJ+gjzNjqsJzv+a
 XQkhNQdVqnkx4vdcmHBxohROJR6m1XxlxXAxplnV0DbAK6Wqq6k3F1EDw8IHw95mjGfR
 EdpbwVe7QSSOXpfUHuHdxIXgWUuLkE7PbEN14ZFuw0ttWtXtordlzJQP8Uhs4qZFUugt
 Rp3LU8bWJY4FnDbTlSxv8iI+8pPLdPoo5wymtb5v809362zkfeygaofRXxNYlNhgi5OS
 nwTGv8uYK37tDoplvmbEynY1huMF5f5kE43vkV7egVQmK9WQ8LsCZ0JW3AdHxnUrO2QX
 YaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482569; x=1752087369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUziXsuFH79ftSoY2fSSF/M1EWCCj+e2HlfSQ3oWfeU=;
 b=LB2lxUoSlWtLJ2eOV/57ZC9mobxn3pCAbyXb9DC2JG7sjEpDyeTOtZNGIi7pCrZW9V
 BMKERSNn63t+ABnMH8MlSEAbt0TSrDwlA2sRY7AuTXbJq7+wdfBgwSaMWQP1zwJ9XmZR
 ollBoA/ThMdPcBi6mRRbpF1+t9djuJTf8Kad7dWGfuzQ5tuT2L8/2OKzRK9bM6zrbkUd
 DZxxZhB+WZJFkmDgqNg4s0NHUwJ1Ajg/rg+p2lE+9tNsWSKzKTXSnQsckAiSnoJVkcoE
 nA9XO98etXPvt7Yg7YmjZL0/LPDggpPF+zKt/d6fMF9hcfxuLHXrnCovxmSh6auFNubJ
 prnQ==
X-Gm-Message-State: AOJu0YwIHeVI3leOTtET4CvPp7WaiUZJbyMqmHewSeYzM72V5ycwzIn9
 EUBO0cvscr+cFZAuQddXizxjfwCVAcASDjlusX6RXHt9jaG3PS8DNDZOAUm0L3DLwtL0LtrUJGg
 Qrz1W
X-Gm-Gg: ASbGncs+vohsa/SQiFg2QCe38F6gyxF3rvl10Gq1hOgii+emHqh07VcjDSyAmQsDTXF
 vHlDQhq3HXe1bTPRfbEzRhKZLlmTvVfSEKHubpHGpze/Ei5rglucuwRX6zj3WboACJlZfF6rUbL
 RHYQOlIvsmMgGIKyx7BpeZmmG9IK+yGEkb03x9tJZvtNprX6EAXx4HMqN0QcILHsSe3dtOVYhAt
 4qWz7foHwzOYlh+98xi9YlWAOXdLjMvfrmx5fRE6xIvpXPB4e8/liWGLBNFq78foyAJwqLUD0dw
 lhLe52OkJp0lLIUzvFZGurzwf02p0oNgH3E1JsiVcgYNuLzMPYs7TBsPPfcyFEdZOnHH6KV/nnQ
 wWv0NiVEaOb6rkSJhj5xbx/c5jZi4dfp8VNLVBE8cEJ1AFk0=
X-Google-Smtp-Source: AGHT+IGdkcmtPXmnftE1y4QtHYW023XI+dGuAS/Ka21cJnDx6XUz9/3rDI0kklaDytvcy4AlUg9byQ==
X-Received: by 2002:a05:600c:19c9:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-454a9c609b8mr8902065e9.2.1751482568635; 
 Wed, 02 Jul 2025 11:56:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52cbasm16886053f8f.62.2025.07.02.11.56.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 21/65] hw/core/machine: Display CPU model name in 'info
 cpus' command
Date: Wed,  2 Jul 2025 20:52:43 +0200
Message-ID: <20250702185332.43650-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Display the CPU model in 'info cpus'. Example before:

 $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
 QEMU 10.0.0 monitor - type 'help' for more information
 (qemu) info cpus
 * CPU #0: thread_id=42924
   CPU #1: thread_id=42924
   CPU #2: thread_id=42924
   CPU #3: thread_id=42924
 (qemu) q

and after:

 $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
 QEMU 10.0.50 monitor - type 'help' for more information
 (qemu) info cpus
 * CPU #0: thread_id=42916 (cortex-a72)
   CPU #1: thread_id=42916 (cortex-a72)
   CPU #2: thread_id=42916 (cortex-r5f)
   CPU #3: thread_id=42916 (cortex-r5f)
 (qemu)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 qapi/machine.json          | 3 +++
 hw/core/machine-hmp-cmds.c | 3 ++-
 hw/core/machine-qmp-cmds.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0650b8de71a..d5bbb5e367e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -80,6 +80,8 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @model: CPU model name (since 10.1)
+#
 # @props: properties associated with a virtual CPU, e.g. the socket id
 #
 # @target: the QEMU system emulation target, which determines which
@@ -91,6 +93,7 @@
   'base'          : { 'cpu-index'    : 'int',
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
+                      'model'        : 'str',
                       '*props'       : 'CpuInstanceProperties',
                       'target'       : 'SysEmuTarget' },
   'discriminator' : 'target',
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index c6325cdcaaa..65eeb5e9cc2 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -40,7 +40,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 
         monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
                        cpu->value->cpu_index);
-        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
+        monitor_printf(mon, " thread_id=%" PRId64 " (%s)\n",
+                       cpu->value->thread_id, cpu->value->model);
     }
 
     qapi_free_CpuInfoFastList(cpu_list);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c68..ab4fd1ec08a 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         value->cpu_index = cpu->cpu_index;
         value->qom_path = object_get_canonical_path(OBJECT(cpu));
         value->thread_id = cpu->thread_id;
+        value->model = cpu_model_from_type(object_get_typename(OBJECT(cpu)));
 
         if (mc->cpu_index_to_instance_props) {
             CpuInstanceProperties *props;
-- 
2.49.0


