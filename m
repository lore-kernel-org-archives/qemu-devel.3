Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F17E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvo-0007Ev-46; Sat, 27 Dec 2025 04:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvm-00073N-EI
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvk-00074C-RM
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EH6Qg1VTw6AKfKDVywah0DcEUcfi1K/cKzxM043Y9m4=;
 b=IHEAcOZ4PamSYJL4M7MKOOgcwKniPZ77s0JEFZpDiV8qIsqYZdvLtGczn5eIzSzLVOJ1zg
 zyvLwuLmzLk+z6Icl5mRECCZUg9xZYzYW2idht0zmngg7i4Do5CnqtKoqHSFyp0gUmjMxT
 qOGabcRaJ2OYD2J1sZZx8JOSiNX0JkA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-aW-IDefcOpi27FnqufNiCQ-1; Sat, 27 Dec 2025 04:49:46 -0500
X-MC-Unique: aW-IDefcOpi27FnqufNiCQ-1
X-Mimecast-MFC-AGG-ID: aW-IDefcOpi27FnqufNiCQ_1766828985
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so56181765e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828984; x=1767433784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH6Qg1VTw6AKfKDVywah0DcEUcfi1K/cKzxM043Y9m4=;
 b=I31tIhaCLs6MALJaaEG9V+Gx4Cy7sCNNdrqrAS5Q8d5EjHFI5MKMd9otcAYMU28Lp7
 aoAQPVC3ZCsx06vmSZ21uzDRm63cYqGZ+HgQUstf7An0dBJIDoydXtCJktC+MMezXKpg
 N0QxKE268oFEgYPuRsTG1donb5WZVi8bbyoTNoje1p1DfLUdXzlXM2JEgoQ2K9mwyvCM
 w9D/5kTpfUm0Srbg9CtKmhQ6GSgDihgV5V8Yeb/G4948bU9djSugjeR8oGLDmL6+xFbX
 SxUJEV6mJCnzikusPjqk1eoVnS5j8ldiT/d3vzXEPc2GjYZCkOQF06w2zkZdIyZpKxVV
 hhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828984; x=1767433784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EH6Qg1VTw6AKfKDVywah0DcEUcfi1K/cKzxM043Y9m4=;
 b=S/6hXTbeKX4VCyTLD4iMFsw6PZMwvxSVcnQePc1XaPCyjAfVKlum4O0VFKhADYdEBQ
 3WXCV0xPL7hJSW1vOsnrYnHbdADqDVQy2N3QCsIy8Fxd3+h3XlSB3DdNgk1IT2LkS/ML
 XpD1Yg12n6PX/7+1SFoId4VRDktDCtls6Gh115pIJ0wpntvHvdXmiwCi0W8m8dLmlua/
 K+LsBeuf5Y/pLdoaUNMf57ItpjFxmDu/rkhE+1IcBsHkTj1qm32oVJsLkY7Q/ioPJBfz
 frGkegp8Q+O3ez6gqTMrX9Ffoo6ZqErZV8VLS4TKPAnDLevezNU5XdSKm+MEqmTstnsj
 jwyA==
X-Gm-Message-State: AOJu0YwJSmRhU14gfQJlqMHJYVMHyN5EV3figDJNz9Hsx2LFf49h4C/d
 W9ntfsFnpEYqFpJGT6KCixW4WoaVaDyrUsn6bc8AmDD2ApZwCOArxQVFRrV0yjtf4JlwrkgKHu6
 9IEfJrp4o3K9CH9zZBGrvy7OAPMrGcOedN3MbWc3Mmvp12ilqUW2ksfEOJG/LPpZlTfM8ApoMz3
 jLqC7fZHwMwRgH01yBSp/J57Apmkqdi9beIyFEM9p/
X-Gm-Gg: AY/fxX4lIwtrt+kEFd7sPTO++oO6AxL3qTdfms3M2GwZweAiFrjiVrSx86pMAD1W5BF
 RaSVMRPmL/CMw0t5RSd7gfiz3Ez/xZCuQ47GdSAxXBChcva6+JdTVRBt7MybzGa3/4lYfJVtHNp
 W7Y6vDYIz1jtuG/7mMehpJhovZkSdBbbXruEjPL8qzh8xm1R7tmN0Kgx68EjzXG820/nWVRQz/4
 6JRJ/xtKhBavl7N4KspvlP/BGYx7NQ33ugmmowE5itQK+v0aR9IRaKFei4+JksaOr8WVlSvb6j0
 ES4lH5BTLgY02jjE2ZpAMkZdE7TP1MgMUsi/FrNBLZD6AEA9Do5uYlmZqSQL/sUb5pVqAB0D1nb
 mQ/xuiesb5B9zG1bMQ1OFxSKfOpsrWxnx04hKzvEarF5vTFu6ogNDDBV04/yvImTTWht4GRnXIS
 pf20m3RgeqY61qnDg=
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-47d1953d798mr285457995e9.11.1766828984685; 
 Sat, 27 Dec 2025 01:49:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmNi0Dq1zPjCEZ+ZVOFhnCuvMg4/I4fpcMXbhlBzTkybkn/9sS9pv8N7KpmuZKspgLvGHn0Q==
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-47d1953d798mr285457795e9.11.1766828984307; 
 Sat, 27 Dec 2025 01:49:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b0d5asm490570095e9.13.2025.12.27.01.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 114/153] i386/cpu: Drop incorrect comment for CPUID 0x1E
Date: Sat, 27 Dec 2025 10:47:19 +0100
Message-ID: <20251227094759.35658-40-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

The information (tmul_maxk and tmul_maxn) in CPUID 0x1E.0x0.EBX is
defined for architecture, not for SPR.

This is to say, these "hardcoded" values won't change in future. If
the TMUL component needs to be extended for new palettes, there'll
likely be the new TMUL instructions, or new types of AMX instructions
that are _parallel_ to TMUL that operate in particular palettes,
instead of changing current tmul_maxk and tmul_maxn fields in CPUID
0x1E.0x0.EBX.

Furthermore, the previous attempt [*] to make the 0x1E.0x0.EBX fields
user-configurable is incorrect and unnecessary.

Therefore, drop the incorrect and misleading comment.

[*]: https://lore.kernel.org/qemu-devel/20230106083826.5384-2-lei4.wang@intel.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20251118080837.837505-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4421c458498..67769200d0d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8403,7 +8403,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     }
     case 0x1E: {
-        /* AMX TMUL, for now hardcoded for Sapphire Rapids */
+        /* AMX TMUL */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
-- 
2.52.0


