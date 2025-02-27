Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512F2C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelo-0001BV-DX; Thu, 27 Feb 2025 09:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel0-0007f9-Ja
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tneky-0003q1-PS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sU4JUhAK5XAEQyd9qSYhUnxLKsYgYIsyzAJD2IwPzIU=;
 b=UxN8L+pmpRAvWKPPy9JX5r5v2ixSu7kNKYzwa+/LvspKdu1XY1rEe7B66vm7kVOA283WDL
 A7mNpHNMPXtKz8ptGeG5XV1gMf+szdkg1VXuAeKhxJ4t6rqSl0hRhjhlPjonFqnov8k3yc
 gz1TdqJ0pL3Cb/IVixpavQe8kS4tnDE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-ApgzUnnTPYOD0V9g1-lFSQ-1; Thu, 27 Feb 2025 09:20:50 -0500
X-MC-Unique: ApgzUnnTPYOD0V9g1-lFSQ-1
X-Mimecast-MFC-AGG-ID: ApgzUnnTPYOD0V9g1-lFSQ_1740666050
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390eb06d920so101572f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666048; x=1741270848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU4JUhAK5XAEQyd9qSYhUnxLKsYgYIsyzAJD2IwPzIU=;
 b=fDO7QNAsmA5ySGy8gYcu9QcvKGG85qFwoyxer8+V8s2zhJcVCO+n/cumgNHAtxRQNN
 mzVnMVT4yLZE44nP3l1JfafeMuMWGkryphCSsho3gU1H2h4YvGBwPdSR0UBTguaR4DnC
 bkBRTeXGmYO1K9ut6xNGTjQjKHZRfhMA6yeX/IZ1hNEmJlgRxNX1bxZaryPkuZm2Ayyh
 G3Rl09DG6gz5sOVtSIXQ4tjy6B/U5tbk5eJRHex0m/kny2Z9kZJiZhKZUmuGmOWU3PoI
 vrn1mAlDcIcRlHTlXM6uxtJcrFgx4jC4mbWySHDyv+SKyg/D68vlLhsFubSnaVDfmJ8w
 /VhA==
X-Gm-Message-State: AOJu0Yw+u4j+yaPaiWrAj3m0jhrIGGJXmw3bBRmloQN06769RIWgKfeO
 H8oQWM+LNCVKuW2nf0NXIJbf5C0uDGMEXh+DbaKiqIazVqjVZwNfWYPzjhkuZTxKK58ceKcUiES
 oXgWUYseVK/ShxqXjBU8gFtLeZelEXIXQ4AXekxL8zTN6/L/TSbjcVmKOww4bhklnRR02h+9lA6
 I37cilovV/3pT1sBKlmTK4gvi35jydzGQ5XXWNg/U=
X-Gm-Gg: ASbGnct0dJNKr+sNYjrm/wXvBypQPWMCMYTfPj3kqFunTDRgS0JtfliZESMQV87dJGx
 DzsYEzxMQSXFj6wdt4vselNg1AtItxT7De9IpPbWpsPXeQXUJt00PlG90yTB8/YblMFnPMqvdu9
 QRyHM0xH7WW5IBR/FNEy1KvmEQkCZv6dmx6QuEZpASTB5iFyQj5+Sj6Qjfox+aEl1Own9fWAiED
 FqUA7SgD3eDwUOzRyqdFNsEIE/2QizGMnzu0JhUCiRL5/BxKPNcuuSbrjyhL5sGAG/bGn49eKwm
 at/Zxv7kgz2/0p/o1ex2
X-Received: by 2002:a05:6000:18ad:b0:38f:32ab:d4f4 with SMTP id
 ffacd0b85a97d-390cc5f58admr11636049f8f.4.1740666048629; 
 Thu, 27 Feb 2025 06:20:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdrJGfG1m9xhlSs8sYUhd0vadoDAk6nS4+smvPDgTgjagVwFjAhKtVfXfdtuQqpsk8rTQb/w==
X-Received: by 2002:a05:6000:18ad:b0:38f:32ab:d4f4 with SMTP id
 ffacd0b85a97d-390cc5f58admr11636013f8f.4.1740666048152; 
 Thu, 27 Feb 2025 06:20:48 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c1146b7sm129343066b.84.2025.02.27.06.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 25/34] i386/cpu: Support module level cache topology
Date: Thu, 27 Feb 2025 15:19:43 +0100
Message-ID: <20250227141952.811410-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Allow cache to be defined at the module level. This increases
flexibility for x86 users to customize their cache topology.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/20250110145115.1574345-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 72ab147e851..8799e22ed45 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -247,6 +247,9 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
     case CPU_TOPOLOGY_LEVEL_CORE:
         num_ids = 1 << apicid_core_offset(topo_info);
         break;
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        num_ids = 1 << apicid_module_offset(topo_info);
+        break;
     case CPU_TOPOLOGY_LEVEL_DIE:
         num_ids = 1 << apicid_die_offset(topo_info);
         break;
@@ -255,7 +258,7 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
         break;
     default:
         /*
-         * Currently there is no use case for THREAD and MODULE, so use
+         * Currently there is no use case for THREAD, so use
          * assert directly to facilitate debugging.
          */
         g_assert_not_reached();
-- 
2.48.1


