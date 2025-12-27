Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C1BE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvH-0004jc-G9; Sat, 27 Dec 2025 04:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvF-0004fd-K4
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvE-000707-6f
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWE7+QagFTlCLC+13BlNUnTL03oJZAhW49htiMppSVI=;
 b=VgrduATeOq2ACpY0S6SQaeFv7+dGQ+A1tO3HDjRBg5CP7gpipJgodZBTu3HlYu1FvZfwRr
 aDoRwDTxdLesKX9vzCLg0gbUJhUvE5zo2/SJa/Letv9SPaq1o+6hUYVSYiKQ41cTQLnQtQ
 axmy5BJhAmPG4UrIX2A+/TDd3EhVH9c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-DHMFtUhGONOoM-QHuCw7kA-1; Sat, 27 Dec 2025 04:49:14 -0500
X-MC-Unique: DHMFtUhGONOoM-QHuCw7kA-1
X-Mimecast-MFC-AGG-ID: DHMFtUhGONOoM-QHuCw7kA_1766828953
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so6229129f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828952; x=1767433752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWE7+QagFTlCLC+13BlNUnTL03oJZAhW49htiMppSVI=;
 b=Fq+3IDvEt9dXfsmqMWHP199tg68uMCaSm9YYodyxq8E4W9uwbYbBDJVkFBEkrfyg8f
 ixjeQm+ENl3u3w2F6akbZgQWrW/HoriU3twwbUNbpH6qcAyYeG/eaDPjWdtMATPn+H4F
 UpX7UJW/gSGu75rcroorDsqhcQgrDLPv20ZUbM+2eBm8oJWf42RZuRGb31Szzu4Mzvfv
 gkPvXgL4jdElXI/goBHpJYrVKwIXpiNRoF7eTx1Rtw89KkQ8/Y3cP+BilzvLAW/nsRMX
 RQcXkt8O2FgyiKM6at647hOeq4L3Iu5sMxbmBW7y/USsiXuogbZRXYl2SJXg9XJcxt0V
 Lb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828952; x=1767433752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QWE7+QagFTlCLC+13BlNUnTL03oJZAhW49htiMppSVI=;
 b=kKu56PC87502QKWOJ5MB4wA3ejJiW205VCBMm8yZolRpPRIMV41Vafmw6gfpcA9Hw0
 GT+Vmu4gI4OblZEMaFBIXG6BYCTMtuMQdUoDzHIO58rjfpvUwjJjiB0C885w7l9WXfXI
 LeR9/POqPBCC5chJddgznfGWEjMd+8WycSyrC0QLtyt/kCmxYfsZBy0v8i261Po5AB8Y
 eeFCeUCCZSnpQ9+DJRYaab1JKHewmJd7VLFESVwrIILbFzUPGE02yqRb0RZtxUZVOfnU
 IStfDChmRQ+0OuXx3hPCpNSXjmHpa/toE44nnOlpGmMxXU4JSO8OLW5URpx5GpU6E0bI
 Ikdg==
X-Gm-Message-State: AOJu0YyjUF8emgPuAk2+gkDh29ahWBPS3TNwitKbo9+TPTWAHtvZJVa3
 wSN9r21MsTdM7TX7OclVPtlB/UNMELOa+RQeg66t5i64ar9XZe5YlzKsCK4JBoYyABgmKsTePcI
 Yzxveuuyn1GAQbWmIKqaBBKzve6NdRGXxnBfqR06ygfiV4a9vDc9JQd+ApelATvmpXq0rT2Rka7
 QkcIXFWmp2frnt6YW3u+7YNwg946reps+tz0VsYDJp
X-Gm-Gg: AY/fxX6zYJ3+hLqChJCvDx9w1wzcxmgPvqnAfnTCVsdvVcOO30VoEtkVJwBby1JZ/b5
 mFbjVCWU/9qQfnqB/qxwSL+sUx8Gt3/QtlCwyXmc1fK7J9ojnbSuOJDjjxLxxnQNU210A0Q3uQY
 g16ZvvcYssdAk+Lh/Ker5puZ9G3yCy4YmJuUa14pDWm+uDk8TJeP1PMzK/1mVNBJDNHpAjXvavk
 bHFLLzv137l0ffaq28B2QjaEFhrPv5FOnbAWkgZJK+z6+VEdpcgYd36cWMh/qxeYCRuGyHWb/OL
 C01abPpMnu1ZogvT370609ksTPdHiWoGwjzUmSJOycC/tv6YlQhtxrw+E5G+XdoZXhmufK0Mnfp
 IXXbHLL06dzbOMjVEtj7lxYL9pUY5OMPnXdqQcElpOP0wotaG4CSBCoDyLFfUFOQRXvYNDYIRaN
 opFltfwUH9CAXkJ/k=
X-Received: by 2002:a05:6000:2890:b0:430:f23f:4bc9 with SMTP id
 ffacd0b85a97d-4324e7092e0mr31952021f8f.62.1766828951778; 
 Sat, 27 Dec 2025 01:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhOZiofwFkNOHJFg80feApbiaGaXqp10tUPjGFfGoKj839kTXLfyHVGz8iDz+Qgz++b8lE4w==
X-Received: by 2002:a05:6000:2890:b0:430:f23f:4bc9 with SMTP id
 ffacd0b85a97d-4324e7092e0mr31952004f8f.62.1766828951337; 
 Sat, 27 Dec 2025 01:49:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm49662334f8f.31.2025.12.27.01.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 103/153] i386/cpu: Mark APX xstate as migratable
Date: Sat, 27 Dec 2025 10:47:08 +0100
Message-ID: <20251227094759.35658-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

APX xstate is user xstate. The related registers are cached in
X86CPUState. And there's a vmsd "vmstate_apx" to migrate these
registers.

Thus, it's safe to mark it as migratable.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c9efd3a9d46..0f618ffb03d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1544,7 +1544,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
-            XSTATE_PKRU_MASK | XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK,
+            XSTATE_PKRU_MASK | XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK |
+            XSTATE_APX_MASK,
     },
     [FEAT_XSAVE_XCR0_HI] = {
         .type = CPUID_FEATURE_WORD,
-- 
2.52.0


