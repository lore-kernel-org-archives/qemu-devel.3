Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1164C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRjs-0004hq-GP; Tue, 20 Feb 2024 10:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRjp-0004bp-Iu
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:53 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRjn-0003n8-Kx
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d375993f4so1577153f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708441729; x=1709046529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BjoHKgBAqJhVWzvihYewG3Mo1EyFTHucbJxjZyHAzY=;
 b=AF+XmJU8/fUgGnqSZvgXti+xcRjoOEmzKEXYzoEXX8ml2TopiLAI4hY9B+EUzWxZwC
 XX5qqKBICmOCl7znej2swDKPfbWhJbkBurQR39gScvF4F9hPnJbun7UMfkfI5w5Ir8s1
 Jq7DBfbiLvZ9v2+/qjZa89cNYojP6IG0IWUlKgEONicpaIoEi/cirphZg0QURl7TZzFc
 8iJCZPILL7iBjl4hHGeJzXTCSXKC6MkOjTe+EjrjWSlsP7EEMlsuy1x7zvmk6uaQiyGb
 8ismPWGXnRCEdLNoLD43PlN7U3Wb4xCCVDQF9xWUeen0CPRx1C6USsDVHdugqS2bVmMB
 /FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708441729; x=1709046529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BjoHKgBAqJhVWzvihYewG3Mo1EyFTHucbJxjZyHAzY=;
 b=o8nURtsClWlt6IgDEa3CZEXlpxzTDfUnV2R2PuL/goJIGUtbhzPQSW8KoN3XBoHtWH
 fWDAXFPxNda235+jrseUR3CpcTYPoqdT7/EmWKzuCiSBhRN+cwk5Cdu3chVbGHN3QDZ+
 Zlvi+BlGKAUxN2B+23SmOwUu3sKKWcSSuuKwW4aukWlSmDEw5tZqbfpRvXiasdioUHO5
 raDTP0V6hJK9hHKDxUo9fcbBuL8pb2ZVL2nmUVv0bP0o1v9dBNy9JEEPaqi3Hrwtb2lo
 jIQliuczg/DH3kCi9yyJBCwJsk9gasRVszT4UE0eZXlsUxDv1/ZClA7aZZOuRjSeqSAV
 Q0pQ==
X-Gm-Message-State: AOJu0Yzn3oQqWbkRAEDiVJ48feVFl5yJqLhRuSEnwhr90HJSTl9ZvwwR
 +8qOAavr5Gcid6XGAj72PYGn58eTHEt2mEK27DgIZu9bu+mQtATi86iI/buvy1LfkIn+CPjPpXj
 y
X-Google-Smtp-Source: AGHT+IFhbrq0b+Ii24quknvkw7x8518WJST0xOOA9vnYm4SCMWy0cblWllaVknoPniV2diA8rEdDCA==
X-Received: by 2002:a05:6000:887:b0:33d:6bc6:26ef with SMTP id
 cs7-20020a056000088700b0033d6bc626efmr2045846wrb.14.1708441729095; 
 Tue, 20 Feb 2024 07:08:49 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 14-20020a056000154e00b0033d10bd6612sm14090980wry.81.2024.02.20.07.08.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 07:08:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/4] hw/s390x/virtio-ccw: Always deliver NMI to first CPU
Date: Tue, 20 Feb 2024 16:08:31 +0100
Message-ID: <20240220150833.13674-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220150833.13674-1-philmd@linaro.org>
References: <20240220150833.13674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We can trigger NMI from HMP or QMP.

QEMU maps the NMI to the s390x per-CPU 'RESTART' interrupt.
Linux guests usually setup this interrupt to trigger kdump
or crash. Such crashdump can be triggered in QEMU by HMP
"nmi" or QMP "inject-nmi" commands.

Using QMP, since we can not select a particular CPU, the first
CPU is used (CPU#0). See the documentation from commit 795dc6e4
("watchdog: Add new Virtual Watchdog action INJECT-NMI"):

  @inject-nmi: a non-maskable interrupt is injected into the
               first VCPU (all VCPUS on x86) (since 2.4)

While we can select a particular CPU on HMP, the guest behavior
is expected to be the same if using CPU #N or CPU #0. Since
always using CPU#0 simplifies API maintainance, update s390_nmi()
to deliver NMI to the first CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/run-state.json        | 5 +++--
 hw/s390x/s390-virtio-ccw.c | 4 +---
 hmp-commands.hx            | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 08bc99cb85..a2542f1a50 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -320,8 +320,9 @@
 #
 # @none: nothing is done
 #
-# @inject-nmi: a non-maskable interrupt is injected into the first
-#     VCPU (all VCPUS on x86) (since 2.4)
+# @inject-nmi: a non-maskable interrupt is injected (architecture
+#     specific: on s390x only the first vCPU receive the NMI, on
+#     other architectures all vCPUs receive it). (since 2.4)
 #
 # Since: 2.1
 ##
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 62804cc228..ba1fa6472f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -605,9 +605,7 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
 
 static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
 {
-    CPUState *cs = qemu_get_cpu(cpu_index);
-
-    s390_cpu_restart(S390_CPU(cs));
+    s390_cpu_restart(S390_CPU(first_cpu));
 }
 
 static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 17b5ea839d..2b01bb5926 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -851,7 +851,7 @@ ERST
     },
 SRST
 ``nmi`` *cpu*
-  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
+  Inject an NMI.
 ERST
 
     {
-- 
2.41.0


