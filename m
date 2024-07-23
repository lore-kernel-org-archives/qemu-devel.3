Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9158C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDFH-0002R0-Tb; Tue, 23 Jul 2024 06:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFC-0001lZ-Qa
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFB-0002Qr-4G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DSrvGWDM8WQlkDQ1QptgcjyZ8pct3cQ7nSxPz3zLafI=;
 b=IcG+BwXAtnTNdpMu6hSp/9JnAcp+RoFAk4hzliwvrFqq4eFkJK++ljO6nbgMZXcYqBYYKd
 UB0fLQCezaHmbrVMPTzIAd1enLV7oMeUiMx0b/022/i7mbh9wl4sc45i+4BwGOhoEoz9Eg
 IXN+FriFWlCHpXAxoyFdrSCWgQoq3Gc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Qe2uRs4EOJ-9_35Iymmz7g-1; Tue, 23 Jul 2024 06:59:41 -0400
X-MC-Unique: Qe2uRs4EOJ-9_35Iymmz7g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3685e0df024so3335509f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732380; x=1722337180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSrvGWDM8WQlkDQ1QptgcjyZ8pct3cQ7nSxPz3zLafI=;
 b=GR/fdSe6qOEhU5475bRFDebmMXjNLAK9FYKn9ln0xAe2/JeWtZ4ojb7fz5GLeJi1ks
 dRHEXj1HWm5Xxq/x/alVbk/z1IeOj1C1jPUkv6oEduh5XP2hUIAsHwMXLhMewl06LrwW
 izq/97ZCmKAFlZx88ttYUB5s5/2wujRxeD2Co5HKA7NkRcMJLIT79DAPN36lrmW1VHlA
 XAhoYhR+ocz7tP7FXjTo6R6EXiNNMDto+MVM//sE8jej7uVjG4J4xiAFdfHb2bCz3EsM
 7YvaPNTsakLzohE0fWAiP5desxxAa3gArlyXJOQy6wPw4haUfYSHCd8QdYR5qbwwKTy7
 PKMA==
X-Gm-Message-State: AOJu0YxuWPkqN/u5SAQx4Gkb6h6RwSeVlY1tIftDSyhS6R67zs9mhzbP
 rhc4OtPZCBAfcdEVXZsWk2GNlOaWey//J273tU7eQFurN4XsIko6CiP5x2B/V9hm7HY/jPRIqsp
 jTgcG/VmeBa6pVKPqN1CfCYez60YGFTRKIABZzb+Bv6CEj/Dsj0TsQ6+1moK/blRoRfvB114Z2w
 7RgSvdW9Has2ySs45Ge5IdShD7BEdr+A==
X-Received: by 2002:a5d:6192:0:b0:368:3717:10b3 with SMTP id
 ffacd0b85a97d-369bae23a3bmr6996556f8f.8.1721732380237; 
 Tue, 23 Jul 2024 03:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDGkgAVP/kDuWMvOLLt2He34A3BPca17yvCYj+TCX1z68E06+pzGqzRCme1ILua2kzi5o69Q==
X-Received: by 2002:a5d:6192:0:b0:368:3717:10b3 with SMTP id
 ffacd0b85a97d-369bae23a3bmr6996510f8f.8.1721732379504; 
 Tue, 23 Jul 2024 03:59:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3b763sm196791985e9.10.2024.07.23.03.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:59:38 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:59:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Xianglai Li <lixianglai@loongson.cn>,
 Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 42/61] physmem: Add helper function to destroy CPU
 AddressSpace
Message-ID: <24bec42f3d6eae035d5df48c057157f83b260e17.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
involves destruction of the CPU AddressSpace. Add common function to help
destroy the CPU AddressSpace.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-7-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/cpu-common.h |  8 ++++++++
 include/hw/core/cpu.h     |  1 +
 system/physmem.c          | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 815342d043..240ee04369 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -129,6 +129,14 @@ size_t qemu_ram_pagesize_largest(void);
  */
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr);
+/**
+ * cpu_address_space_destroy:
+ * @cpu: CPU for which address space needs to be destroyed
+ * @asidx: integer index of this address space
+ *
+ * Note that with KVM only one address space is supported.
+ */
+void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d946161717..1c9c775df6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -496,6 +496,7 @@ struct CPUState {
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     struct CPUAddressSpace *cpu_ases;
+    int cpu_ases_count;
     int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
diff --git a/system/physmem.c b/system/physmem.c
index 9a3b3a7636..0e19186e1b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -763,6 +763,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
+        cpu->cpu_ases_count = cpu->num_ases;
     }
 
     newas = &cpu->cpu_ases[asidx];
@@ -776,6 +777,34 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     }
 }
 
+void cpu_address_space_destroy(CPUState *cpu, int asidx)
+{
+    CPUAddressSpace *cpuas;
+
+    assert(cpu->cpu_ases);
+    assert(asidx >= 0 && asidx < cpu->num_ases);
+    /* KVM cannot currently support multiple address spaces. */
+    assert(asidx == 0 || !kvm_enabled());
+
+    cpuas = &cpu->cpu_ases[asidx];
+    if (tcg_enabled()) {
+        memory_listener_unregister(&cpuas->tcg_as_listener);
+    }
+
+    address_space_destroy(cpuas->as);
+    g_free_rcu(cpuas->as, rcu);
+
+    if (asidx == 0) {
+        /* reset the convenience alias for address space 0 */
+        cpu->as = NULL;
+    }
+
+    if (--cpu->cpu_ases_count == 0) {
+        g_free(cpu->cpu_ases);
+        cpu->cpu_ases = NULL;
+    }
+}
+
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
 {
     /* Return the AddressSpace corresponding to the specified index */
-- 
MST


