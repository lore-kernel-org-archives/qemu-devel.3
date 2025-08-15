Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6D8CA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 06:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umoLE-0007we-7g; Fri, 15 Aug 2025 02:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1umoLC-0007w2-Ql
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 02:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1umoL9-0004Sc-PA
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 02:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755240901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QfpRJDOx7vIf6iHMO1GUhD3FuyAbfUVze5LyzZkdcbY=;
 b=Lvtl9d5Y4KhpQKVDKr5yMfmahBaivAVc8Rvqo7cis+/pgg+9AVG95QyOqdgtxMBCwb51uh
 FPCUtPOUFK4kDZA067ndCpJujBDgTYRfZ8MhRjCu9Zmjl+xhN9efmAp8/HjE47Z0pqCRp0
 1tNvP2/6bVRw2eHTQdWRcOaBi0y9Fgc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-QT3TqY1WOUqonXpbrGufpA-1; Fri, 15 Aug 2025 02:54:59 -0400
X-MC-Unique: QT3TqY1WOUqonXpbrGufpA-1
X-Mimecast-MFC-AGG-ID: QT3TqY1WOUqonXpbrGufpA_1755240899
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24458274406so36115015ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 23:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755240899; x=1755845699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QfpRJDOx7vIf6iHMO1GUhD3FuyAbfUVze5LyzZkdcbY=;
 b=Rj5fmmIT2qbO4btMxxYQo6VQ9EcKA7UtiWtPo0Q6aGjVobexBdbU8Cg5Wx0F1q9nGN
 vFmF5DALX5nl/Us5mgyYi3F/v5owc9354aYkYGoj8vGAN6kWpcjbVk7VV7Y6G5HM1/Pf
 MXHIeVFEhp7Ma94A+4Y2mpeYvuHqXTWsbaMdTcStK0TeRpDIXhlmMwnIDbDDHKltHXtY
 7HyapT2AOMmEnfINtYJ6keRh1pNcU+eGsuwlEinn2pxet+9+qnxb/LJZK7WIQcqoU9HO
 fIYOnd+TwJ3THoxCqvvkMGiKPT1CitWmgcNuy2VBiEuaKMsTpVgWxNFOMi+tmutxpwbv
 g/Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVChnbGfULganHSS4lVMbr8kpHhrfgWpIzJ+AnxWByavCkjI0WhVPME5WdjvWkqFupfSutRYid+xjLQ@nongnu.org
X-Gm-Message-State: AOJu0YzFh2mBRNMOjsOLIJ875NwV5VQgG2fxOm8gUFhTFdJYhmW7ewGs
 xdVthPAOeRlWfOR9ZG/B6h82LoQu4TfgNurV66Ww58pXakxN8XfToJB7Ko2eNdWBJLa4YSgERDD
 UNJ8ivz8uyIpiWKjv4lpbBb00yO8JdQdIpwqK32npTsi6JRWPVY49Q2AB
X-Gm-Gg: ASbGncsm/95RsQVtkI1az1lTojAqnJ7+yHQ2qz0Vetzo/7MzmvB5tvbKtBRt7NvhEdm
 1r1oGqQd7Vt52cGG0gZ41M3JaBxNyaUP3hOaq0SDJqb701QmMeVE2uZOW0JupoM4JAK4RFYFUAR
 GzpCk6AmXBdPOwvTbv54YPfbJeFaTsTnN1QRkkqxAGhIZCXFk8YTaGF6I8pWJ/4gLvovvT9Qzvu
 oi4EeyLXw4mwISJDb9RBF6nOrB25kldSpUOnzNZrQ14APWmS9rOargtBPfsVf5uZ1AtPjznvob9
 hLnjL56vbNk5PbhSUdYEaVDvowMVlwDNKWvvl7ijr6X/Ax7Uh/aEBUNA
X-Received: by 2002:a17:902:cccb:b0:240:a430:91d with SMTP id
 d9443c01a7336-2446d6d389cmr13456535ad.10.1755240898692; 
 Thu, 14 Aug 2025 23:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5cHP3euI0v4J2p434uBJ3KCjz24PzAMWpErVQO+9dbSjp4LF6SrU77UG22N2IuKad71zFqA==
X-Received: by 2002:a17:902:cccb:b0:240:a430:91d with SMTP id
 d9443c01a7336-2446d6d389cmr13456335ad.10.1755240898229; 
 Thu, 14 Aug 2025 23:54:58 -0700 (PDT)
Received: from ani-lenovo.domain.name
 ([2401:4900:1c84:e19a:d863:5334:4ba4:f128])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2446d5a1390sm7288125ad.164.2025.08.14.23.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 23:54:57 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: richard.henderson@linaro.org, Ani Sinha <anisinha@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to kvm-all.c
Date: Fri, 15 Aug 2025 12:24:45 +0530
Message-ID: <20250815065445.8978-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

kvm_park_vcpu() and kvm_unpark_vcpu() is only used in kvm-all.c. Declare it
static, remove it from common header file and make it local to kvm-all.c

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c  |  4 ++--
 include/system/kvm.h | 17 -----------------
 2 files changed, 2 insertions(+), 19 deletions(-)

changelog:
unexport  kvm_unpark_vcpu() as well and remove unnecessary forward
declarations.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f8..f36dfe3349 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -414,7 +414,7 @@ err:
     return ret;
 }
 
-void kvm_park_vcpu(CPUState *cpu)
+static void kvm_park_vcpu(CPUState *cpu)
 {
     struct KVMParkedVcpu *vcpu;
 
@@ -426,7 +426,7 @@ void kvm_park_vcpu(CPUState *cpu)
     QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
 }
 
-int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
+static int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
 {
     struct KVMParkedVcpu *cpu;
     int kvm_fd = -ENOENT;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 3c7d314736..4fc09e3891 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -317,23 +317,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
-/**
- * kvm_park_vcpu - Park QEMU KVM vCPU context
- * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
- *
- * @returns: none
- */
-void kvm_park_vcpu(CPUState *cpu);
-
-/**
- * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
- * @s: KVM State
- * @vcpu_id: Architecture vCPU ID of the parked vCPU
- *
- * @returns: KVM fd
- */
-int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
-
 /**
  * kvm_create_and_park_vcpu - Create and park a KVM vCPU
  * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.
-- 
2.50.1


