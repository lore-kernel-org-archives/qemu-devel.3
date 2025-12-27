Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7200BE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQus-000361-A9; Sat, 27 Dec 2025 04:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQui-0002O7-7P
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQud-0006uZ-C9
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1NClWp8k93LnwznfnQ9F9fegAQxKZaohNu9b81EugQ=;
 b=M62RSQuoIQBkxMckx0nbBdQjon5MJRz0cyT1LxXA31aj87gzFW97j+OcUSbpN0aqr9Nd5m
 pXw2HDt68eTWR/ftcTRZaw+E1BEYhQMLPmeOsg902zZtQ0GSfrDsd0uHbe5+DHml74Ss+/
 +8i7vTHp346Wxe+4/8scDhTrs7f+cMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-WvQ_x1cHOEac6ync84v1YQ-1; Sat, 27 Dec 2025 04:48:35 -0500
X-MC-Unique: WvQ_x1cHOEac6ync84v1YQ-1
X-Mimecast-MFC-AGG-ID: WvQ_x1cHOEac6ync84v1YQ_1766828914
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so552062f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828913; x=1767433713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1NClWp8k93LnwznfnQ9F9fegAQxKZaohNu9b81EugQ=;
 b=fqIJgrse+35In4vMrfBPzECKXsAN6mshjvcNbOJmZ0Grr8Bh2kQLHd2WT+GXbmJXi5
 lbuZL8v3zLajZBC5XvDGmNqwiCU+z9RV/Bjq2lUqAGoPfs6sZfiv1e+ERLedp74rEPAg
 g5lV7WFO6bGWGczNQ3xrY28M1x35R6CDjKIvqfAbLWUZtsI07EqJfctHMTZIA9CrpvW0
 SPeC3oDVClyhbM0Z3jTRvAjF/dyk5IoJjYltNCtqw6bCqU1KcdNdxRu7ntqJmVWgN6AL
 UVkU8jZusDCFoJlez31Xy4MGajbw8ezNMmyRwCbLuvzMN/VWojf5TdJA65C9zwPlUUGA
 j8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828913; x=1767433713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B1NClWp8k93LnwznfnQ9F9fegAQxKZaohNu9b81EugQ=;
 b=UwSQj8TG0hUb6nH2Kc/mES/u4w6m5OYB5ZBQAD9ahkrGc91fntI3YlxFWrMdkW5GpZ
 fqNaog/a0k5uC5Zxwmcrvt8iRY1RpanREP670wOqxrFtxIO374YzrEl6gc1hotJGy1j0
 joHmX8ZU8+DrJeQS4un/OkaNWbKOP38yb5IPdwatdmoqyUXUoTd0tZJ82i//ZVUoMoWe
 vJv9mvbkLJu8xc0pECA2V80gw+5zBwetGsUv6PEmNNHTozskillecpDGWfgSwLUNTbYp
 tj4L2jvKcAtovkb9cYCa88hwihkSRHRghVjYUmnN8spp97pF9A+S8Ho18RDkDzjqBQ7N
 7jgw==
X-Gm-Message-State: AOJu0YzmdFPImNsW4R3A5hHwo1tHPlX1Ip0I71Jk2ITPxbMUbwOMqpLc
 3GvPBOPyqRkdoh5p5qE1AfjDDlhrH6YesGn/Axz9FkvSKqEeiCiF3m9HzaCDkAcUyXZA8m2Frvb
 s74aicm4tbNh+Hej1muAn8C3KhXKYQCCiE1pTfYk6kWaS6rS7K49EByZkr6MfGNkK3Oev9wp6YH
 vuJBQDd28Uo7YkNZOSJ6Wro3QtYq15HJV0r0Czm/+N
X-Gm-Gg: AY/fxX70YCj25Rl8KJ5b3VvD94PsExTRjhgzgFczGvVulBpVl9jFTfkHC7N4I9yCqW2
 RrDsFE4q3dtY4FU77iHT3r1ghRnUEHNuI/+Byhg/jjAHYOiJTO39aG7hPmG2Joh6cTA54z13fBf
 1lNQmAMSRKW4j4ImG+aU1HtHuYEuoLwRgXOr+8HUxWGqidTz+OXsFHX1zhWkaSPpTNaU9XyGutA
 1XGDs86vzGkQn0F6OluzU5+N7+iFnJYgTGCITc0bO2iAef0vbWojVqgMDcFeqWbmwuy7olzaACI
 v6ooG7y5RqRuwGFlqI0gl9AZKvXmnj8dwOagbHl2ckaGCijoRd136bJmVS9iqPvJQ9HsIfYRjWS
 iwv03kRSeaHCeICUinU1RxsskU2SNoh7gz/xJgnomBUTKSoN4/RGA68mneRwzJyTiNtmhP/DMOh
 v73wOLpC/XjR41K+I=
X-Received: by 2002:adf:b605:0:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-4327d2a2d3dmr7559583f8f.60.1766828912963; 
 Sat, 27 Dec 2025 01:48:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiV9bpbN4q8ShhY/lYm9lf1k9/TfLV68VC/9arPx+AxLNQKsN/4pdCOsCKwDeCUGUdNBb5hA==
X-Received: by 2002:adf:b605:0:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-4327d2a2d3dmr7559559f8f.60.1766828912397; 
 Sat, 27 Dec 2025 01:48:32 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227casm50084695f8f.15.2025.12.27.01.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>, Chao Gao <chao.gao@intel.com>
Subject: [PULL 089/153] i386/machine: Add vmstate for cet-shstk and cet-ibt
Date: Sat, 27 Dec 2025 10:46:54 +0100
Message-ID: <20251227094759.35658-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yang Weijiang <weijiang.yang@intel.com>

Add vmstates for cet-shstk and cet-ibt

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-18-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/machine.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index bf13f7f0f66..57a968c30db 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1690,6 +1690,57 @@ static const VMStateDescription vmstate_pl0_ssp = {
     }
 };
 
+static bool shstk_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK);
+}
+
+static const VMStateDescription vmstate_shstk = {
+    .name = "cpu/cet_shstk",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = shstk_needed,
+    .fields = (VMStateField[]) {
+        /* pl0_ssp has been covered by vmstate_pl0_ssp. */
+        VMSTATE_UINT64(env.pl1_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl2_ssp, X86CPU),
+        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
+#ifdef TARGET_X86_64
+        VMSTATE_UINT64(env.int_ssp_table, X86CPU),
+#endif
+        VMSTATE_UINT64(env.guest_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cet_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) ||
+              (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT));
+}
+
+static const VMStateDescription vmstate_cet = {
+    .name = "cpu/cet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cet_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.u_cet, X86CPU),
+        VMSTATE_UINT64(env.s_cet, X86CPU),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_shstk,
+        NULL,
+    },
+};
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1840,6 +1891,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_arch_lbr,
         &vmstate_triple_fault,
         &vmstate_pl0_ssp,
+        &vmstate_cet,
         NULL
     }
 };
-- 
2.52.0


