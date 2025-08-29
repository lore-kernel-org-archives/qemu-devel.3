Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82EFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOb-00043J-QP; Sat, 30 Aug 2025 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us151-0001sv-A9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14y-0000Ya-4G
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TU+ohCQldOE8jzcl9QfpH85Y+2xtKzIGiqUp+GEQ8Cc=;
 b=QmUhP86Fcsdm/qDZziFoEfJWf5BtRBZK7VVtcenV/UAmMgFrfoGUx3vFSr1QzqTwAoREim
 o5WtkN9XWtleFOMjo2ONNZW5u5TlvfWQaFVQ0auUYTx+2dRFi0J1WSMRpubjOYUqrNW7kA
 H+ZbJwwQvgUknAwhj0JvJWWYIEa/5WM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-u9j31uDrMiC6J25rVZVjXg-1; Fri, 29 Aug 2025 11:31:47 -0400
X-MC-Unique: u9j31uDrMiC6J25rVZVjXg-1
X-Mimecast-MFC-AGG-ID: u9j31uDrMiC6J25rVZVjXg_1756481506
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3d1114879a4so335802f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481505; x=1757086305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TU+ohCQldOE8jzcl9QfpH85Y+2xtKzIGiqUp+GEQ8Cc=;
 b=tb2IMrCZwzZA0mdVyiwSNwOE30In82w72/f+qW8mJzasI8RBR+4B2ClPo6zmWplbwC
 IrjyMc6S6q2SpXaUvXH3HSH1qRCSU0slw9SlhNYnL6s2hYjqF9u2YUCGoTkds8feOr3l
 c1J7TxpAo3eLuOFRw0RjWAUkRZyB1QQRVHVysdsatW2pO/yauGhpEFeThyB1PJ75i7Z/
 JuvGkffW8djKjG6kuKeUl6fU7rAsw6bDAWLu667g+6cpAI9uNfz+4GCdpbs5cB9Jd3M9
 NjLwL3NL11UaqOiChTOXIw1orAxYydB4RGNTsw2VJkDuMyaSHzqP79yFYYBGb9NKsnou
 fFkA==
X-Gm-Message-State: AOJu0YwW+7BEDON68JZ+LAnQOFog03UdE63lLivMoqFXYUyNhqIpfzdF
 mOI4HBThWAeCXL4ajWVoAvUuAQEEmNiabie5zPahc3Qlh7YGVdFzEclQXxW1lnqPnBQGCpwHtfb
 BQO03vKgor6+DBhSKIBNF+y2QPfL11GtqDQ9yG9YnB+k0orIwIPym2+c6oNl2u4mJlFPZkAZeOG
 FcimsSFKO5ImnWTdhr/1vLaB+YPCmpDopMBafxck1f
X-Gm-Gg: ASbGncvzWKOceERlXGJ1ZPKBcYUlQ6Eoa121FO9iUqQ//NjGAR1J075r0fQ1YKU4g85
 GbPgk9B6jHshJfXA+/0B6cvf4m97AmiVMo0n9Ybu0gTcwgSu0PV0i51v4N/4Q98BRxrP/6Eeh5G
 MX9qbcwCuH/DBcIMxab5d5nAwc4UtS+5+8OPPhrNRPTDDZ9xzh7FjwoV2oyJz22fC912rx4PKqe
 gu5bLw3LlqL+QH9sfkRmI2PYGSLtqd12WGqeMOvAMFQqKMO7zC/lCKOalgRP302PQ9e62luhhc1
 OOZUqINL8EaheWLNMcR3ZfNpp3FT70Hwd6pVZgbBHXTDOtsGtIE6OVXkluvRocmxPVuMiHZK4ma
 a6cvRlAY6Wx7wiIUkvehxlWPqcEOCUVsIuhwvbDBwlZ0=
X-Received: by 2002:a05:6000:4021:b0:3ce:f0a5:d56d with SMTP id
 ffacd0b85a97d-3cef0a5dcd0mr3284104f8f.29.1756481504932; 
 Fri, 29 Aug 2025 08:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3fNvGmLL2L+TNMGiG0RAJ1/h7IlaHvOaUVfCOBvMbWXq5vkegRGJi9mW+Ms8D8wcZX1melw==
X-Received: by 2002:a05:6000:4021:b0:3ce:f0a5:d56d with SMTP id
 ffacd0b85a97d-3cef0a5dcd0mr3284070f8f.29.1756481504374; 
 Fri, 29 Aug 2025 08:31:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fba9c4sm3703019f8f.48.2025.08.29.08.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 12/18] accel/tcg: inline cpu_exit()
Date: Fri, 29 Aug 2025 17:31:09 +0200
Message-ID: <20250829153115.1590048-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Right now, cpu_exit() is not usable from all accelerators because it
includes a TCG-specific thread kick.  In fact, cpu_exit() doubles as
the TCG thread-kick via tcg_kick_vcpu_thread().

In preparation for changing that, inline cpu_exit() into
tcg_kick_vcpu_thread().  The direction of the calls can then be
reversed, with an accelerator-independent cpu_exit() calling into
qemu_vcpu_kick() rather than the opposite.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9241bcadb5f..3ae545e888f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -751,7 +751,16 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
-    cpu_exit(cpu);
+    /*
+     * Ensure cpu_exec will see the reason why the exit request was set.
+     * FIXME: this is not always needed.  Other accelerators instead
+     * read interrupt_request and set exit_request on demand from the
+     * CPU thread; see kvm_arch_pre_run() for example.
+     */
+    qatomic_store_release(&cpu->exit_request, true);
+
+    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
+    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
 }
 
 static inline bool icount_exit_request(CPUState *cpu)
@@ -780,7 +789,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
      * Ensure zeroing happens before reading cpu->exit_request or
-     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
+     * cpu->interrupt_request (see also store-release in
+     * tcg_kick_vcpu_thread())
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
-- 
2.51.0


