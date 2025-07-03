Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AF1C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgc-0008Ex-IJ; Thu, 03 Jul 2025 07:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdP-0004zJ-1r
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdN-00025v-Bt
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45310223677so38344625e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540259; x=1752145059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyDIfVgkjNXaUsE4JArqlEQoqhWF6dxOZmRK2K42QUQ=;
 b=Vln3hpGHaw27EhzcxNP8BFdT2NrAsYPy7TzDVfZJxth/rs1Udh1NTvhtrQ0LJhU0xI
 FHOHoUuWPOe6er7hL2RSZFahn84yYHQ16dcuSRjRJwiXiZQxDUkymOM1E5MSUlnxzPT3
 LdUOelbnRLUukuLByd9gUpvLDC31cXkvXA4Q5wFJf3L2+mcjiskLgWzYm0Lsid8SrSBg
 RB5TlncPmHeRzOtchNgXcd6ElJ/czgst1KGXufAReEFGUEyukskm8hgI+H6ld8RTbtDE
 /2IbW51JNB1pFoRcBSkIwwoXl8N3wQw/wiGSGj7dqGWPCZK7LK/NwrwXQDLQVmefzbXP
 xKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540259; x=1752145059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyDIfVgkjNXaUsE4JArqlEQoqhWF6dxOZmRK2K42QUQ=;
 b=d8x5dgxheMy60YNmoCVYPpDan+KvI0xQ6dViS2n3Gd1udofgOsAezOoK7eAyhtQYXM
 oX6+1UsOAaOOX7j6MZbSQh0FokVUZWTPKIFeltnL/KLEJ7QisPlXjmUtfsIhBxgfqeDF
 eebnCEPwlzgJCE/hfzBxQohaNILIRULU3m576Dr82R7G0tIhVUl+kIeFKC/X7uhBVHXd
 0v+C1BaTgsfNFqH3z4B/UxsXr713pI15KOno1y14mx/zSGEX9faUdexrWq/KLnSS2s2W
 izyRtUVd5AUzCjWOey4MCSknazLDQy6wKVRGIjkxCoe71tR/ZVUCv/WZ48VSp4aILjhQ
 eBgg==
X-Gm-Message-State: AOJu0Yx4L8NL4iC4SGRZEzjkuXTHdWaJDTid/6+trHTWwt89dIFE4Mug
 YTGvFoXDUasICw/P90ZqRRLt0hfhlYVPB/CrIWqBQxTvv7hASII9X76jtkcnVX+3fo9CN4LDgBA
 8TAY/knU=
X-Gm-Gg: ASbGncvqUHlJBozSOl9p/n0MJoJvTXKKn1/h+62wUC4iQxY60KhjykMZ6kVAsZEDozo
 8CO9UzlpGfm/juCyQeS60zDg6V748YJ+BlGivh5ZKZso4Hbm3qyUJsWKu4jwGyvpVrLAByTJZLs
 sQi+KlyQt1dEf283PI2JAWDQ2sdWDpXZesY/yPE+J6tVoLVagQHhNoy/juEgsZ0sr0jPHW3Amh2
 8M5hBMCjUmJmL+3KLYsccHlTf+2UTR2hJD+V70iNhyh7PWqTwVj/fPc4tOiuUggsZPK3K/u1t0H
 /oKgYuaSbYJ9Rx9QuHd5anM8JfQY90psM8wOWNJG/axEGNCy9IVuVsvqU4Ri5k19tzGKBQQij6r
 MGOH3RTZtZJM=
X-Google-Smtp-Source: AGHT+IFnMUp9ULAlreAnLA58eLaPSmiRt8sgmToqT8PTkCSUBzjcdHDj/cVj5qFUEozQJ4tUqy3gXA==
X-Received: by 2002:a05:600c:3f0c:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-454a36e91eamr71382595e9.14.1751540259254; 
 Thu, 03 Jul 2025 03:57:39 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a999d399sm23784825e9.25.2025.07.03.03.57.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 22/69] hw/core/machine: Display CPU model name in 'info
 cpus' command
Date: Thu,  3 Jul 2025 12:54:48 +0200
Message-ID: <20250703105540.67664-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
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


