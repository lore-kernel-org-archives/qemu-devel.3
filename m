Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8526CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7r-0000BX-8Q; Thu, 30 Apr 2026 13:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7n-0007uN-AA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7k-0004sy-Nw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3uz8H/L1RNNs5rdW3bWDRvUgD0FldqAcPwJY22ip50=;
 b=XrKCgCbEh3OPBCM+sze0XSXGvCYyC1HAixa4n/JVmZdqr1YRVJNSz4WdCMk9h70eMnd+fd
 S6hjD2+/MPmeRVi92v059wXBqyeWuZS8k1SHWTtr8vQGfSNOdu5iNpq1i2NDVq/gx/GTx7
 kCgUtCmyScLm7ovmlEqZ0OOpEwNe08A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605--QbuL3CRO9OkQAEbqjJ4bg-1; Thu, 30 Apr 2026 13:24:26 -0400
X-MC-Unique: -QbuL3CRO9OkQAEbqjJ4bg-1
X-Mimecast-MFC-AGG-ID: -QbuL3CRO9OkQAEbqjJ4bg_1777569865
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd722c1a69so242161585a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569865; x=1778174665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3uz8H/L1RNNs5rdW3bWDRvUgD0FldqAcPwJY22ip50=;
 b=Op22/uy5sTvxz/Bx+/w+egbRutW328gb1LfieWcnReogRWYRnWe+Y8t4YiZJ4d2tt9
 XpzyzMc8wvEoyr06mIuIv8SkLqKvkSeieJSXpQ6hktLPK59+Z+IXgJb27E36Bb8glqh7
 hIYHTsJsFGUAUSBcsPT6VYkjEyAxJRUQpyFotVohbLrMafluORSj2B23S/iK+vJKCt3f
 KiA5K071gVbIUCcIpjODCaOBmqZ8tARQWtzAfMzoRQgVP47Oizde72bwVd654zqZvXxq
 KZnLAVIx5fsRCTkAHQV2IvBNfxYuk+BCCY83D7wUX83/q6AU/CgXKkdqeokNXaeoj+PF
 Xq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569865; x=1778174665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D3uz8H/L1RNNs5rdW3bWDRvUgD0FldqAcPwJY22ip50=;
 b=JLWb1S9112X/YB3cQJsGiPgBrUY0pnWkRKq+U6WKd8Zf6zEgdPMXeNK+UmKsvYjOJO
 aeo5EfTDJPWXDDiDJi6krYBU0kPCf83zjtDBhUjqL9ehnYwXco6E5zYg8FsExzxNjB/r
 HwOrK9/nc0wPV+g1ep1PNG/HuNplRJfC00LoIj7XaPkYMxI0OGAAaEmEBWP3OXTHXJ63
 sUma5qlGXadV+Kk9b5QK4P1Ifi6DwamF2kjZJjq6tiO2HV5PUxultKFVTaCVSsgqjtMf
 RSp/avuWox6hcGq/kCkAaeJm21Fsx8Nm9CABYSM+v53ebZsaO7d2zaagLpTPb8Yx0Dlb
 XXdQ==
X-Gm-Message-State: AOJu0Yy6BQiZly2FLASOwobUKFFqEx5W4DG5V/s5NlK/UgKi9yqMsCMh
 vtMSpH6w4+T/lRqtZMdKftRyzXDUmtRucrxhV1EHkg0DEoV1s4blR8m776+B3l1naPnpNixdZr3
 hLIwHYxSMR21LqJx8i5YdWmMX+I5WIGRrIyADvEKU7b6aYNnBABi4bPQ3Ct/eCdgfpqS6DoxuK4
 mMvLaTb/CC+TzT2VxT5L2HhP2LT8oYJqJI7XtZ5n7C
X-Gm-Gg: AeBDiesoKMTdW/RQkupX5L53IdiCFZFgPbaplugZpYOuJ+hmOXlp1s0UyT1lGElK/52
 XAqSURlQMo2x10Bijt2K/vuOc6HW17HsHp2arxQV53ZVNCvtx4dMe6K3RHjpNMn1z/JLdhSXGN2
 k0/Ozi+n8A01c2gwEO62xhNPbyaIggvPt99HklC2quSGA5PCp+l6+J1UV/tKI2MqukULGsSfhDB
 RaCIGvyzhdKOCaUj21DzwqEhIz3AZf/LDkaXGLfmq3WDpHYmWPLjGReAlxQRDoFlPp0WSql2fZq
 5rJ2+9egp70SeVqP9dxnKMpaJV+uvwhffdPu1jVxShJ+Qk14fIgH04fk1tpWY2Rpym0ecMKG5dE
 iYkIVImg6BBeCvI2UcWaKzjhq5jfQwHVdtg407ST/QakIXp5jc0LvhuWllTcadDhOK1LKAHApxn
 AUJLd3fnongHISIktOhgI6o8avp1CJzdzDUpw=
X-Received: by 2002:a05:620a:17aa:b0:8ef:ca26:dcd6 with SMTP id
 af79cd13be357-8fa875a404fmr629345785a.21.1777569864768; 
 Thu, 30 Apr 2026 10:24:24 -0700 (PDT)
X-Received: by 2002:a05:620a:17aa:b0:8ef:ca26:dcd6 with SMTP id
 af79cd13be357-8fa875a404fmr629334885a.21.1777569864000; 
 Thu, 30 Apr 2026 10:24:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb12d44e0sm25518985a.17.2026.04.30.10.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 44/58] whpx: i386: ignore vpassist when kernel-irqchip=off
Date: Thu, 30 Apr 2026 19:21:50 +0200
Message-ID: <20260430172204.1006673-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Linux tries to set vpassist even when none of the enlightenments
using it are available.

So ignore the page it sets.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-21-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8fbce415903..11c9d8729fa 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -51,6 +51,7 @@
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
+#define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
 
 static bool is_modern_os = true;
 
@@ -2123,6 +2124,18 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                 }
             }
+
+            /*
+             * Linux tries to use it anyway even when not exposed.
+             * Ignore the write as the VP assist page is not used.
+             */
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_VP_ASSIST_PAGE
+                && vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()
+                && whpx->hyperv_enlightenments_enabled) {
+                is_known_msr = 1;
+            }
+
             /*
              * For all unsupported MSR access we:
              *     ignore writes
-- 
2.54.0


