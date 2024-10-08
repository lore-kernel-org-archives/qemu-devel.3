Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC70CEF174
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 13:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syALf-0002wz-91; Tue, 08 Oct 2024 09:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1syALc-0002pQ-Tw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:33:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1syALY-0000U3-6w
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:33:56 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e029efecdso1832125b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728394430; x=1728999230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4KyCMqBV9tXcblqUlbQ/JGQVDhsuA9Y9d8nGwm2bfZc=;
 b=OWwzWayQHDZuxgv8x1Ep2bYiMhB1KcP/M165Czoz/ntbEmpZ2DGO8LhhPDo5S268A7
 XaizsDqvjSu18HhEGPNg/vBNgwfpa+eH9qopKVb8ZMtr2R1nBi5qIt5w1abBr9ikr8UW
 /z6ftrlZi65/b29F1ymfeHdAqV5NGfI1QtAmaJ4m+IHq2Yc5NRtVPhF86Sec0E13+GXx
 ty5opApwW1If2QE8HnjfWPmh2yhlxM6Aoxxp2S4vNsKWEimY+GevlGitRgn/Jec/O+gJ
 wZKGrRCPWttsLnuFTO7Y79fN46zEbuhpZBkQbKG22Z7rCW9Zvw9380/zj1t+H4laFgBF
 aGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728394430; x=1728999230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4KyCMqBV9tXcblqUlbQ/JGQVDhsuA9Y9d8nGwm2bfZc=;
 b=NzJmKg4mC+KUkvV4mTuZ1jrQzsyolSbliR5Yeegw6I1FeSFAbRedPT1Qi6nIOsvfwL
 RDTh7XTJBC9z3Uzv3U3d2YQ8ZVZYlDFSMJBCy5n6MwFlAmoDY7TYOefcxkRMfiQ5F6+m
 OOKNLaDtWr793dKkl/x5H97D3H6W8j9kXwDziXFX8+3i5ewNmgTldXogSl18u2WCo6q1
 vg505n+GEuLn/HrKc9RxJGuEcAISaX+Zqry5S8ET5803hNvLFLcN6Tifp/U90tSIkmnM
 qcZw1GiU9bUi4EN7gvIs0LmTkY3xCa071IdM11LFzj2GESoQ6hlga80aFTx7lyiHqrm7
 acgA==
X-Gm-Message-State: AOJu0YwMZ111BiV0PawflTF9TIhqNX4/xPUkcqB86cRckKkplsS8Mn1d
 kwYRZkix/WZg8osOtefeRxg+tXsvtHI4+ZQPrPKYx64f+gg/y0zKBx4KbdCJR4gaynqn5jtRTWp
 s
X-Google-Smtp-Source: AGHT+IFFoBwYi805MM1/ot/cky1pOUC94irUzKEFH2ZU/lw3PQ/HKPAFoTXva60P9ujxL6u3/OpOvQ==
X-Received: by 2002:a05:6a20:2d1f:b0:1d7:5ea:22d with SMTP id
 adf61e73a8af0-1d705ea0311mr5550259637.47.1728394430231; 
 Tue, 08 Oct 2024 06:33:50 -0700 (PDT)
Received: from KK6FJ77W06.bytedance.net ([203.208.167.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f683eddasm5827689a12.56.2024.10.08.06.33.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Oct 2024 06:33:49 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v5] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Date: Tue,  8 Oct 2024 21:33:26 +0800
Message-Id: <20241008133326.26767-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.66,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
CPUID.04H.EAX[31:26], which matches the expected result.

As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise we may encounter unexpected results in guest.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though threads-per-core should actually be 2.

So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
to solve the unexpected result.

In addition, we introduce max_thread_number_in_package() instead of
using pow2ceil() to be compatible with smp and hybrid.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff227a8c5c..0749efc52c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6462,7 +6462,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
-- 
2.20.1


