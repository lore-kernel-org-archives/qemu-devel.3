Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415C2CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV82-0001Gm-GB; Thu, 30 Apr 2026 13:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7z-00014O-5k
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7x-0004wC-GO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUisL0WWMxIYnrFNVpkf+gUnH44d+KEPMfMzg1X2Elc=;
 b=agwioOs57s13Upb8pDAlhOKfbjIMqYZlJqTClZKimaqnSNHDbRb2PDYtWcH35hvzXDyjiN
 CLd+uQfICGcfgBPgkUx5efAAt5jkz9nxDl07E0bmUAvf1W700jT5MEQp9wW8/WbkpXGgLQ
 98+1Q7oAinmX4qgNiHgPFDVqWOusI+0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-qUtKKCLXOduo4s3BDyylTw-1; Thu, 30 Apr 2026 13:24:38 -0400
X-MC-Unique: qUtKKCLXOduo4s3BDyylTw-1
X-Mimecast-MFC-AGG-ID: qUtKKCLXOduo4s3BDyylTw_1777569878
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b49260e3d5so18188186d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569877; x=1778174677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUisL0WWMxIYnrFNVpkf+gUnH44d+KEPMfMzg1X2Elc=;
 b=k8mA3/K/gvWbvs7/dKbjaJ8flzk3vyVkCKZ8NNysBM7FsIQUdDpNyfA6moR+sFPVMZ
 cQCXKnXGp9mhT6xoMod/TAGlNKcrMyOAHV26rIAD8RR7etra2lUVzsnG2RbS5g9UaRff
 mu/1PXq5128Dp5irJspysax1JothPeVEtaD5uhvlWZ3HR9S6gZ7nOugtBvdMPQ4bkbt1
 ApNxR45CHspiOZm+ws/qAeNCbjUYLOZuqg8nOsotq25goPpfbKkWnK+fsV0ufUbyNwW9
 542+xDtsM66QKSX+VjSr9cW3hXiNcQyhTESSCyDZBB5wsxwNHO1o99ku57ftsNtuXHZ/
 Jj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569877; x=1778174677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jUisL0WWMxIYnrFNVpkf+gUnH44d+KEPMfMzg1X2Elc=;
 b=P/kr26DLzMvAnKcL4I2s6YyQO3K1UpYMo8gNs+a/6lLpfeLwMEqmW+FpALilZH90A/
 2etV+BHI3buCGknkJPRQrSR6AKppoSri9QAMTgVrQHe5kA2FkCTkGH9RR4eMwVBGiryn
 sJ1Xx+aWb3dK9LripZSlcIaFqiha/CPujB4cNIagerBvZAJvtIm5kRuLG0Iz/9FetaKq
 nIaCZSITZxoWKodNJYIoyNHbdkHxRINFLrsuM18mBjusXtaPAuoC9z046y6iXQ4prTBl
 qUP0zhhtEXM/CClO26AexCws3O2mthtMyjTZuTAfxAtSL/z/1MQ5Kjy3Nf25pjN+GLsb
 B2Iw==
X-Gm-Message-State: AOJu0Yy4JsH8Lui2kiDeNjMZDxAx0VUV7oOcnqW7bXNfw+oayDLXH0aC
 cf0ajVcq1udVhTldjZ/SOfQsXcCdkq2KEcc6VEncxNsQTkyXke3P5elu+qMYioGJ49yt1L5Ry8B
 AbXuQyq6oG4v6+VO98qz8C73QuRLrpxJbFJf2nPXeUUFTKgoylW8w2JGswga4YjKRn5Y8ntkylE
 Kkn7EgrlN3AuP1SqwwSLn76OS4oVdOugGIdE6Va7sF
X-Gm-Gg: AeBDies8wfdsrfKu94tlILog4NQKCGvQAhg73hZ7KxeUN4+gfaYmLCccwwYGoHmN6Bu
 hzT1MktQAg0A3Royvep5eqrkJPuplZdQx8PLqrI60P/Hqs68JoyclN9uxMZK5mqC+9s1R2AbW0S
 qv5x1ZDWOfXfHUfqpgif0iMlgCYw/ZgM/LeGmU5p3BEmVWRNj2oxH9kTZcWiinpQdVP/a0rpMGa
 jQs8sy/2TdCJ50WBx22Y2LeOArrLr/lAMgeEToZvb1MMnKkUzNKGohsVpHg4Gcs4UJsvLjzi3ZV
 X8NDulyPLuZiD+qJvu1HHf6Hj/A/Ug/G5qUe7gWch4VMl/nUyTehqfbSkrzUbtRTWyfMNUpMsbI
 pgQN32e2voMA6jA21SUEo/SQxiRZkfG+LSfQIEo8fFSlCwGzPeLy691StgENCxFLKdnUOqfExAA
 Rd1vwTZPUkZ5zN/OFrcuajS0eqSuRkcVUlrww=
X-Received: by 2002:a05:6214:19c3:b0:8ac:a4f9:da76 with SMTP id
 6a1803df08f44-8b3fe7969camr56263946d6.26.1777569877194; 
 Thu, 30 Apr 2026 10:24:37 -0700 (PDT)
X-Received: by 2002:a05:6214:19c3:b0:8ac:a4f9:da76 with SMTP id
 6a1803df08f44-8b3fe7969camr56263496d6.26.1777569876650; 
 Thu, 30 Apr 2026 10:24:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff474374sm23105136d6.40.2026.04.30.10.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 48/58] whpx: i386: set WHvX64RegisterInitialApicId
Date: Thu, 30 Apr 2026 19:21:54 +0200
Message-ID: <20260430172204.1006673-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Keep Hyper-V aware of the initial APIC ID chosen.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-25-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 593a707e219..077a491664d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2475,6 +2475,11 @@ int whpx_init_vcpu(CPUState *cpu)
         goto error;
     }
 
+    if (!whpx_irqchip_in_kernel()) {
+        WHV_REGISTER_VALUE apic_id = {.Reg64 = x86_cpu->apic_state->initial_apic_id};
+        whpx_set_reg(cpu, WHvX64RegisterInitialApicId, apic_id);
+    }
+
     /*
      * vcpu's TSC frequency is either specified by user, or use the value
      * provided by Hyper-V if the former is not present. In the latter case, we
-- 
2.54.0


