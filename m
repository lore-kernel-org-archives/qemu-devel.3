Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B8BC02190
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 11:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spQXg-0003K0-J2; Sat, 14 Sep 2024 07:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1spQXf-0003Ib-1s
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 07:02:15 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1spQXY-0001R1-Kt
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 07:02:14 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso2686160a12.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726311722; x=1726916522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GR/HGyAr9qr2GTW6o3wD5zxUc45IeTLnMegr1ek0CeM=;
 b=P3YSUlFYP8r3/D6n6+ujaxXxMmch+gerIflGaoGfUeNms+EML7fNP0SbDV61qCZEMj
 X+sduAtKWl/mmgTpto1l5Hs3GPR6oPa9nDpJx/lx51+BmI6lC7MPgFx8aRmqfi7vlFSq
 3JzOB5HfqcGEhrlpVPBNHz8rsTEKT9ifoP1KZFHYWV1xsj7o2+VIzPMSOJ+pXdsCV134
 s8cu5l7CyQKsKmqFC4KSnPtixJxUqr3jOkrup9ldH9Uv5fheYyrtM+R+c7tDMoROFJCm
 2+hTPS5T8x5IYyppoLcgTh4QVTaD0xj7W17JItEyRj2ItybYjJpY4XS8fUM9JitQNAfY
 pCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726311722; x=1726916522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GR/HGyAr9qr2GTW6o3wD5zxUc45IeTLnMegr1ek0CeM=;
 b=TqXRdJYK4RkHIvN585IGDsgKp59JxklLQvoMwo3nXwQoc/ax3MpZ9ULsxvUMRzPTa8
 1PfOk0673uieE/EcozUhSpoVxesq3Qs6AbLfVMOg6iJZX7Fq19oTdBBQQB967G/gheEG
 s8nulM7sIh6PAa6E+7TJQhopAg7QfjDCYWt6l9EEpQl+lBHlfMhygbKzwKHtUL57hX16
 2dXc22uMVg03Ypk6l7Zs4v6S6YvSlwGRXiWKgSDAcABf9GkCq+3+0p7pp1/sWKl1hC6R
 XDnDvbraG/6l60hyM6MBOhfJhNG7nq3ms5vzfCeBcQ4crho1rrqFBt6JW43tg9T6cI4Q
 5W+A==
X-Gm-Message-State: AOJu0YxCnWhKfARLWM/jf9FXSfBoDirZHwBE27EEcKWZaMYksBUyym8U
 nMz6rGTZIKSE5uRGmYZhy17KZJCgw5qXDLC61Jzw2DFdSvHxCnaE5m/9YhSaOTbzNEH59zzcykW
 x
X-Google-Smtp-Source: AGHT+IGXaWv8aTxBvlvPD1nSo8/S8Xi3+duKPnbA/EmQNDk4gx9bw+lPlBjyZ1KPHe//5pwopZ1W7Q==
X-Received: by 2002:a05:6a20:d80d:b0:1cf:3201:c3ad with SMTP id
 adf61e73a8af0-1cf764aff3dmr14534980637.49.1726311721683; 
 Sat, 14 Sep 2024 04:02:01 -0700 (PDT)
Received: from MacBook-Pro-2.local.bytedance.net ([203.208.167.148])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db4991cfd2sm980043a12.48.2024.09.14.04.01.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2024 04:02:01 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v2] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Date: Sat, 14 Sep 2024 19:01:27 +0800
Message-Id: <20240914110127.67690-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When QEMU is started with:
-cpu host,migratable=on,host-cache-info=on,l3-cache=off
-smp 180,sockets=2,dies=1,cores=45,threads=2

Execute "cpuid -1 -l 1 -r" in guest, we'll get:
eax=0x000806f8 ebx=0x465a0800 ecx=0xfffaba1f edx=0x3fa9fbff
CPUID.01H.EBX[23:16] is 90, while the expected value is 128.

Execute "cpuid -1 -l 4 -r" in guest, we'll get:
eax=0xfc004121 ebx=0x02c0003f ecx=0x0000003f edx=0x00000000
CPUID.04H.EAX[31:26] is 63, which is as expected.

As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise we may encounter unexpected results in guest.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though theads-per-core should actually be 2.

So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
to solve the unexpected result.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c2e6f3a71..24d60ead9e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
     return num_ids - 1;
 }
 
+static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_info)
+{
+    uint32_t num_threads = 1 << apicid_pkg_offset(topo_info);
+    return num_threads;
+}
+
 static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
 {
     uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
@@ -6417,7 +6423,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            *ebx |= max_thread_number_in_package(&topo_info) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
-- 
2.20.1


