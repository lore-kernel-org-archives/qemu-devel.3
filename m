Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A61FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 21:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMDVr-0001lW-Jp; Fri, 13 Dec 2024 16:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMDVl-0001jV-Ge
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 16:47:50 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMDVi-0006vt-Vg
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 16:47:49 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71e1597e3b4so598374a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734126464; x=1734731264; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjUocBofaeW46xXvn1ZLdIoxtZGiEOLNEGs0i8bqzNU=;
 b=WbuEotmrHkfasT4Z5I+mVsLrsSt0ZlAnstPgT50T/233a3Af4pNAEtLlr7U+xaRRni
 ew+3ImSMBPJu+V0d6QvdWA521Cq/ueRB6oo5FvFaN4ZIGt1RXoLdgdGViv/GUFqcbkXp
 uFyGUP6gp02C+0WkkxOiieJH7hFlSz69JVz1Zp78lxRQ97agd1PLmcx7QoCHakmy4hix
 YjEYolj0SRJUbUYUoK+kypoGbZBezQy8kOOve/MelQB4vCN/ZGzLad+0MUe5gvz7OLpZ
 iB1p9dnDiKjqFajieuY9KxKq+T7UWn1YIReUHqMwCOAdMDAFBGXsUAix40eoSo8TRnZR
 uEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734126464; x=1734731264;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cjUocBofaeW46xXvn1ZLdIoxtZGiEOLNEGs0i8bqzNU=;
 b=G+wivh9i16LMIT5GVsEtMqg6BZIsfpme1LKG7hObUJY+4vdAfPmsEAw/+KpTghDyyq
 KpJTT+xBaBnSQrgVRqmnHWRHJaepo6/Yxx5KGBERGhEOMPD6BMI1jSVAVgqvlayBvpcC
 GsohB4qEcvjdO0iGQR11+z64/MUwvKyCOkZ+CG4aBJyq40IsTJqzujUUs+HZT34VjAPB
 dmUh9328ilE42BdfOtIrYGSZMQ6uTRAmVa5ANP+MLCXc5i9/Vo0zr/Mi03RwYV6/ow3X
 EuK5BhtXk+Se8GgA+BOwaxWu4cZRxhglsPl8l+a3+qr0lDG5QrinRl/0atzxV4BjjcDC
 u5iw==
X-Gm-Message-State: AOJu0YxJOy9Q2O6FjvDRJErr8eCKrY4TrYx7ATouiCItzhXvzExvYAZQ
 1cn79prDszMD7UcpHW+WDugsi9w7Pia00ipWJ2KGEGL3fuDhWgkx/+b5ULZWvzgVvuAC8xMvDXd
 XztJH0sD1
X-Gm-Gg: ASbGncsGONly6qnXMtJstzfZCXj97PDlnpj2+8UCh9QTd/2EiJn4F0UejiaDBK4BDNV
 Uc+zczVyHau2P3CjszjIcZbpIPDC3JjLwTAhmj1+N35syPlSBtrlaGtyHpx4PkqL39N2dmQAQUs
 H7jaDDe9VVQ2u7uMiCGZ9DSUBoEuVhTYcgJcSfhm/wd0VjHTdx7uNVbZUzyBWCS9pPryZUQW2SM
 ACyHgZs0atqXPVodsWnfbpJhz1AUJ0Ecto84N7dz5edMADoo5/Dla98DadvgU6D8cOEL4VeZvUl
 pw==
X-Google-Smtp-Source: AGHT+IGVLTFVKOuMXp92BEKS2RS4KfKrWIc1SiRsIcowrCsvfmvVph+T+PW5G942xL/NW2bFEzWRSg==
X-Received: by 2002:a05:6830:6997:b0:71e:eb1:f75a with SMTP id
 46e09a7af769-71e3ba22a0cmr2658602a34.21.1734126464182; 
 Fri, 13 Dec 2024 13:47:44 -0800 (PST)
Received: from [192.168.242.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836dc94sm94987a34.32.2024.12.13.13.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 13:47:43 -0800 (PST)
Message-ID: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
Date: Fri, 13 Dec 2024 15:47:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: contrib/plugins does not build on 32-bit host
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Hi,

Several of the recent contrib/plugins/ patches do not build on e.g. arm32.
All of the issues are related to casting between pointers and uint64_t; there is a Werror 
generated for casting between pointers and integers of different sizes.

I suspect all of the instances will need to use separate structures to store uint64_t 
within the hash tables.  The hash values themselves can use uintptr_t, as "hash" by 
definition loses data.

The following is *not* a suggested patch, just touches every place with an error to 
highlight all of the places.


r~


diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 512ef6776b..9f1b05fc35 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -474,7 +474,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          uint64_t effective_addr;

          if (sys) {
-            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
+            effective_addr = (uint64_t)(uintptr_t) qemu_plugin_insn_haddr(insn);
          } else {
              effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
          }
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index b39974d1cf..8f8ebf87cd 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -215,10 +215,10 @@ static NodeData *fetch_node(uint64_t addr, bool create_if_not_found)
      NodeData *node = NULL;

      g_mutex_lock(&node_lock);
-    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer) addr);
+    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer)(uintptr_t) addr);
      if (!node && create_if_not_found) {
          node = create_node(addr);
-        g_hash_table_insert(nodes, (gpointer) addr, (gpointer) node);
+        g_hash_table_insert(nodes, (gpointer)(uintptr_t) addr, (gpointer) node);
      }
      g_mutex_unlock(&node_lock);
      return node;
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 02bc5078bd..9b3d356dea 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -111,7 +111,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
      ExecCount *cnt;
      uint64_t pc = qemu_plugin_tb_vaddr(tb);
      size_t insns = qemu_plugin_tb_n_insns(tb);
-    uint64_t hash = pc ^ insns;
+    uintptr_t hash = pc ^ insns;

      g_mutex_lock(&lock);
      cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 739ac0c66b..6d84ea77f2 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -169,7 +169,7 @@ static IOLocationCounts *new_location(GHashTable *table, uint64_t 
off_or_pc)
  {
      IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
      loc->off_or_pc = off_or_pc;
-    g_hash_table_insert(table, (gpointer) off_or_pc, loc);
+    g_hash_table_insert(table, (gpointer)(uintptr_t) off_or_pc, loc);
      return loc;
  }

@@ -201,7 +201,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t 
meminfo,
          return;
      } else {
          const char *name = qemu_plugin_hwaddr_device_name(hwaddr);
-        uint64_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);
+        uintptr_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);
          bool is_write = qemu_plugin_mem_is_store(meminfo);
          DeviceCounts *counts;

@@ -224,7 +224,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t 
meminfo,

          /* either track offsets or source of access */
          if (source) {
-            off = (uint64_t) udata;
+            off = (uintptr_t) udata;
          }

          if (pattern || source) {
@@ -247,7 +247,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)

      for (i = 0; i < n; i++) {
          struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
+        gpointer udata = (gpointer)(uintptr_t) (source ? qemu_plugin_insn_vaddr(insn) : 0);
          qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
                                           QEMU_PLUGIN_CB_NO_REGS,
                                           rw, udata);


