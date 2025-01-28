Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0CBC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmUn-0000N3-EO; Tue, 28 Jan 2025 09:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmUG-0008EY-3z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmUD-0002O9-Ia
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:42 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so4736889f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074159; x=1738678959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jN7tNGrfnQkH1jp+7zEAfhWZCNwGy2KakJL6oRXbHIo=;
 b=TV29y09RKOW9xtqH++5r4H5mCmJPqDWmlztjWX8yRMiZkGVo/Jbw3GEhZWYSVjX4PY
 y/ge17IxfBxPD7KroxTHrSd3mgQEdltaM3SJuGG7OLzCbZ3FRTx6XV39yMRAgf7C4sCs
 lZsj7kKnPaq2dFuzjFufnDXAWvvz8krjU40TSOWItbvPXzuAVyXgoZtr0ysWfq9tzn9D
 dM3+W+B8SzrnrK0PR1Ec19OP+xP8dobdnzCpHGeWOJAwgm/8OThYMN7ANvhLqoREpImH
 8uv65GqO0CDCtfYp3tNGFcy7MbkvuJA0zl6UGq2TaXVEAG6JGhBfZx92nxwEmCWPzyBQ
 Wc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074159; x=1738678959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jN7tNGrfnQkH1jp+7zEAfhWZCNwGy2KakJL6oRXbHIo=;
 b=h5llxzRwTo168iBSOCU7YWSm3IogJsnPkEjRA4+p+H1AJdhKE6GhMDx3G5AQDhGfz4
 L+9SAV1efDii9jlcak2U2lSy5Ncx8HRY9KFGnaBP5cPjUgrNXXSEDGm7NErIPkyMphZC
 /wU7Gqx2O0R5XljtArKlQ91IrGRo5WIK9ET7ztt+u87mMjeA3jk4MH/TCjDI6foMp7Pp
 bUZwZ/rLrtdphhHAFHaciHbJ7PliLQNDZxHRcGL6hVr8gX/QqmuuVT9U9KYLeftBYFlN
 a42Jqn/B7Um/cXafQyjn+SJHUiOUgefID2taxFSmZi87WFC1nukX6dMjeRsqZJVwqqah
 /leg==
X-Gm-Message-State: AOJu0YwbPHk3RKoAtkIAjBLp27r9e3nyVmMGjrR6IpjjnOGzP7/5BBFr
 gOu9KmS75Tiw4n4c0JxkOiBO+pqFykJjV7l0qALmj1gjLGkT6npDG0gzluVwSBpizaE0xl5Ruav
 PjmM=
X-Gm-Gg: ASbGncuhnzDNKHuzXOgk5Hr2Slz2Gge4iNeCVS/Vvm+EnWQv/k2P/LKbrNExNnRJ7xx
 1PqhaAkXloKsQ/GIWoLmx9vLHZCeOT5ZRq0VvIUyBC0trBg13tNzafM+jRpAeIAzWVccSjrRpl2
 uar7iz/zJKsJdCx32yWEB02E1Ck6z76+o8YjmJ29HwG2U6wXUHt6qyjDqrcfCwsU7IrRHXQOfAR
 gE5e9Jmr2awzxDjBlzywTlvcauK6ZUm05m3Ge8bXVHma+NmRj9I4R7B6O37SXXNRUJSrx6far8V
 J3iKvOr0JDGtw4+zNsl+woGVmsfATRLXdVAioE1RNiGoBmbqNuPY339z1rHz3P8NVQ==
X-Google-Smtp-Source: AGHT+IHfjGCtubVM9RMAK88E03g9Q6/raB5p2ips8Ty3wdrHPHY423HNQ2wht5Ir+apIlpYx+7iAnw==
X-Received: by 2002:a5d:64e9:0:b0:38a:88bc:bae4 with SMTP id
 ffacd0b85a97d-38bf5784ab8mr43777014f8f.18.1738074159686; 
 Tue, 28 Jan 2025 06:22:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176434sm14462219f8f.13.2025.01.28.06.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:39 -0800 (PST)
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
Subject: [PATCH 9/9] accel/kvm: Remove unreachable assertion in
 kvm_dirty_ring_reap*()
Date: Tue, 28 Jan 2025 15:21:52 +0100
Message-ID: <20250128142152.9889-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Previous commit passed all our CI tests, this assertion being
never triggered. Remove it as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cb56d120a91..814b1a53eb8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -830,13 +830,6 @@ static uint32_t kvm_dirty_ring_reap_one(KVMState *s, CPUState *cpu)
     uint32_t ring_size = s->kvm_dirty_ring_size;
     uint32_t count = 0, fetch = cpu->kvm_fetch_index;
 
-    /*
-     * It's not possible that we race with vcpu creation code where the vcpu is
-     * put onto the vcpus list but not yet initialized the dirty ring
-     * structures.
-     */
-    assert(cpu->created);
-
     assert(dirty_gfns && ring_size);
     trace_kvm_dirty_ring_reap_vcpu(cpu->cpu_index);
 
-- 
2.47.1


