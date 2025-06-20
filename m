Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE78C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfM7-0003ew-5k; Fri, 20 Jun 2025 13:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKM-00012A-Ij
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKH-0004Fp-SQ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so1771835f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439692; x=1751044492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1OZb9Kl+4lZDh9KBCT1cYYDblubQbpp2G1iwduVoYo=;
 b=fSztmfNTBrZHWiFGvuOnK4LfTvUHpLVstT9QpoGf6K+nUiIKTfHblgSKEQRnRMOF3+
 76DICWWw0+Ryekt5fYvPaQCJs018hVDGAfcOPU2m/bLDORiFHYcY0CXrIwit6Bfp4s5a
 EmSbchxSfBGWDMqwbYEypKF0nBf93wgd31iqJn4cfJ/0apk/guCHPrKH2wRkA6z72DOX
 a6m5TpYR2tt0TIsvVEgwkEFRNRf0k5kKWTXSIn99NJmF8TQfstAUocw6V7D3C3Y3dPa2
 nIIfRjYapVTjDHsmsU7jhBn6Svw3csR1VWcw/jeF/CQtN6TobnKP9e1QYdxJkZlOMAL8
 t6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439692; x=1751044492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1OZb9Kl+4lZDh9KBCT1cYYDblubQbpp2G1iwduVoYo=;
 b=ETuu6iPZ/4rZcQLIqlp41/Tap6kctz1CUj08fFIP5fCzEWXNfahKBWOaQgQOrrkEpD
 lg+mfVZef2FWEGT7JI9s0P3Z170U1sD1OGgXfuzSOpqN5Iuuz/TOWdPO0OFCiOI/khki
 kluFZbzw1ztgRGJSFWdnAe2M10wXdxh0bEsr4w0sFvfgndXF8zeySiIKLrkGny5hAQqC
 LQt+HmiLQZvCJRCthDst1skkzTWBosdRcb4GKfIIpy3f6oAWEHOUKeO6pEKuUBsHgviB
 pzCLEGh3eLSRuYdkROc74MFoeV30/+pQriG9RRaA7HZgwLc3lo2pE7I/3J6T+ptOu+Um
 21sw==
X-Gm-Message-State: AOJu0YxJ+f5Z+mkzKmFMYcqDxrc2DBOK9RmIZYqCLLbf/4cbB83q9CRP
 4Lyv50QLe+PmvuOW9ici4iw1Bh87LmLO8zSQPk2a+m6nhnR/p79Rm1O48EDbawHLkDSQpTe+Wpz
 9X/FzKSs=
X-Gm-Gg: ASbGncuEZPLOfcfVEcYwngzNznVGvp0RT4lL0WNG4WHKrGAWhHenb0LBk+P/N1YL0lR
 vIds18d9cJzX5O22WMcrbDeQvpBpuFkPLk0YJ0hmP6GnkJ9yJKrf8gEf1/3pIBII+SF1gAbyz6b
 0cXgUavthmB2DClXatsT5S28X7oG2ghFcLOCKk4g5SHOJVWjQvlpOtWZ8Yzag4lKvNhCjICtubU
 buFh9nliserUlCUI7Wl3d9w2hChogTmuZc9MzOn3Vi1T44tgPAZ+0WGoRaMqiqJxrgJPjsz2RlW
 eOtXN1qJFdFQ/BkJGgaF/4wgs2DPv9U7FZnwXfXrXQWSfT17UswOVPIIytbYTd4xflTloMD73z8
 TUmxbprxxlMxx6w1dccgP215dGT+ko8pOUsVf
X-Google-Smtp-Source: AGHT+IEuhKRuRuevLkLePrHTo519fVyJMoG8BDRnu4NdTcB97R4RjZ/mg5tmiLaUAGgn1SFlcjC7Vw==
X-Received: by 2002:a05:6000:65c:b0:3a4:e667:922e with SMTP id
 ffacd0b85a97d-3a6d12dbe56mr3188809f8f.4.1750439691994; 
 Fri, 20 Jun 2025 10:14:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187e80sm2545362f8f.78.2025.06.20.10.14.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 14/48] hw/core/machine: Display CPU model name in 'info
 cpus' command
Date: Fri, 20 Jun 2025 19:13:07 +0200
Message-ID: <20250620171342.92678-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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


