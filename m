Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0333EC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmUn-0000Q0-Er; Tue, 28 Jan 2025 09:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmUA-0008B1-HX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmU8-0002Nd-UV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so4105758f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074155; x=1738678955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRDTHlfvyOrER0eUl5RKITSLiEo3HyKeVBvSp+Og3D8=;
 b=EQ6Rz2q1RpHqCwi9yC8iP0Ps8Zmm9RzEwhWHQhgUStLFMG0E+gdFSDrirh7Fhga1bG
 W7TK1qhm0NA7wqotPZger2/wv5o41QviygPULx+BoPiLfPVLoQ/IVCNQIYL3uHcZcvOa
 AEIMxQEJNpf4byE9pVwfQoz11IXqs8K9ot15UF214pzhz36OfigOk1Plwh4+xseQUAkp
 +ktNLAw2gcZ18/IEZydfu0zBzGi+6GBckYg8KCNOhyGt0HVLYBiJYnfaD0Qvsy4v80Y+
 1qrt7qUq2mCuYGscEZ5FBqYOJPi9ByMiI1V6jJ4nmk1Jb1HpkWeK0SZFAHPucPdKcn+u
 Pe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074155; x=1738678955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRDTHlfvyOrER0eUl5RKITSLiEo3HyKeVBvSp+Og3D8=;
 b=YlEWfEuJZN8M74EobWpV4D+UxqfwTKWMaA+NoTz2UV6UaDK3zSpmByujx43w0Tgr0N
 e/eiEdwpd9HrpUfR3U+Ec8EAbp3NSnKqSRwjkK9C/21/o4xvQ44dq7lBAZ8vtypea1hA
 PiUww4cQvCbhMe+Xc2XMvEk7RC2JKLzlCVAnDtg3O4EyaQ7jAcJZY/A9kh9wOSkGpO95
 8E2L21yT9OfB3iB92E1wkWzEzV4A46ugqrn/Kqn4PEdRdkuuD0pHnQ2fgMXrkcmNrbTP
 C7iTTw9RRZenqAbnZDTYirBn36oxYdEtUPBwunX71+4kEhZ7RsUjEszGqVHuNJlLFs5I
 pLPA==
X-Gm-Message-State: AOJu0YxZT3L+ZC31Gs2ym852cU2su7b4OWa5WSggFo1Gt8Wr+oPuAoMI
 BAAwArOR13Y5gD4ljVo11xyHa7bZp0YAaZFmhhm+rkP010wHh4eltjBAKfMaL6dqRUaKgMA/4QV
 EnBI=
X-Gm-Gg: ASbGncsvaGkPneE9CV+koFTAKZEOgQFo2degNcCQWWsC88WVNEOpZIeVwyL/1zXA3nn
 xJulGGdQqosPHIcrapx745ORk/x4M2G08IrMRNAB8DSjk2PwCEpEEjKHQs7lCRd+flh7kbnxqoc
 5nak4VJLT/Vnli4hXwSeZsYBv5ecu2z1os180ALA8VFt7APRg0glbwVUVVvyq1J6BgHsFjLeHeG
 zU3KLKTRm+uPAUb4e0MXAdFDpCj3W6TK5QyOdtdCzxdRqgoA0ztXZMcnIyzFGtnDqGIxzp+xKBD
 gIGCxEmcO/YiNnxLqnZpeVxwvJGmZ44M1NIN8RvpYLDsjaclEYWVY7cas0/PlGmqiw==
X-Google-Smtp-Source: AGHT+IGUPaLAqP3HpLzD0IitgxG+YT9FIQ6tbXwdivHVU4DsFGAjOBMGO6K9Ad7biFURl7kv8n/Uug==
X-Received: by 2002:a5d:6c65:0:b0:38a:888c:676f with SMTP id
 ffacd0b85a97d-38bf565f13bmr45683211f8f.15.1738074154855; 
 Tue, 28 Jan 2025 06:22:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c3fedsm13952511f8f.85.2025.01.28.06.22.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 8/9] accel/kvm: Assert vCPU is created when calling
 kvm_dirty_ring_reap*()
Date: Tue, 28 Jan 2025 15:21:51 +0100
Message-ID: <20250128142152.9889-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Previous commits made sure vCPUs are realized before accelerators
(such KVM) use them. Ensure that by asserting the vCPU is created,
no need to return.

For more context, see commit 56adee407fc ("kvm: dirty-ring: Fix race
with vcpu creation").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790433c..cb56d120a91 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -831,13 +831,11 @@ static uint32_t kvm_dirty_ring_reap_one(KVMState *s, CPUState *cpu)
     uint32_t count = 0, fetch = cpu->kvm_fetch_index;
 
     /*
-     * It's possible that we race with vcpu creation code where the vcpu is
+     * It's not possible that we race with vcpu creation code where the vcpu is
      * put onto the vcpus list but not yet initialized the dirty ring
-     * structures.  If so, skip it.
+     * structures.
      */
-    if (!cpu->created) {
-        return 0;
-    }
+    assert(cpu->created);
 
     assert(dirty_gfns && ring_size);
     trace_kvm_dirty_ring_reap_vcpu(cpu->cpu_index);
-- 
2.47.1


