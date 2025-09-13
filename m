Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A820BCAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNS-0002zL-7x; Sat, 13 Sep 2025 04:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN5-00021k-Vf
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN3-0005KZ-Bv
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KoI6yvC21dslA1v98yDlQjqFTRjNFP/v63K9eXeIsBI=;
 b=cKlFq5sTnWmWh10czgr8ZMThBHe19up1o6nY04jkmlNe7LW0jJL9WtDgkrduKmMUlEltgP
 68nH+rowbEMVrYOQ/wBynOqrKjT/pA9CuZqX/oL8EvFzlyoPt4gG+dfsSyu+zUC+uXkl/j
 vx4yUJuYgzToJFH2vMuYSYtCHC+N5iI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-pUaZbQgMOgO5lJVkXi1jHw-1; Sat, 13 Sep 2025 04:12:30 -0400
X-MC-Unique: pUaZbQgMOgO5lJVkXi1jHw-1
X-Mimecast-MFC-AGG-ID: pUaZbQgMOgO5lJVkXi1jHw_1757751150
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e75fcdddbdso1295799f8f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751149; x=1758355949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KoI6yvC21dslA1v98yDlQjqFTRjNFP/v63K9eXeIsBI=;
 b=cUFJ6SjIUPboW+tTF8Bzh1eCjhOH58YL4vkwulDJaiSzPOmYNjpTWwKlABuAvPEHHP
 zf5b3jtCUiN8ZkTKPEi5Irb3PEUazy0zBV62joa1LmSLgiL2rUt1C48WofNOmCg4xSjf
 Y4vkET8jQu5OGsEZoANB+Nj6ILA+WIEvdbu13CQuRo/reXbhVBk086rPIOqvtBvS7akV
 sWW5CLUoI9W26i4CsoLY8VEcF9EvTb/zwxIvYfCWty7twID16eWifzcJncihqjFxNMwH
 PDlWFPqDAL9Bv73pb5zR9Ln+LXqu3w/LfGI1QTKd8hHaU0rUNzIThvxovliCj4rVzMU2
 OYYQ==
X-Gm-Message-State: AOJu0YzD3UxAYMiwkftjep8/OsyTsRM460huqAoM+Vzrc09WtqebCyBg
 rsqgxpxQro/+jo+eUm6DldahY+73fr87YMqlbVeTSJwfNyGxbIDuqkn4Vj7FEVqjzQiJ7XUA3uV
 0okfPKxBlFmWL3++4N69fq5ymR44XE4biYDuSwlaLOTXgUZ08PqDY+9RmyJWssx2B70Z++ttsJ2
 Jr2LtSP2ZNnEdA/P7vtGgiF4076qVSm5X2d50ozETy
X-Gm-Gg: ASbGncu1rS8lI2rbiTQEKCEFiDN8fRwVfCOgvPRve8WtUif81FmErsSTEYRWuWhQSkH
 JQUNXE50lkhH9F+sNTiPbhoGqgqbM9N33HCsvKYzEb0bOBPAF7DmF5dQL/5hW3GBS6CIQqxAFzD
 iavf/K+H+bnGEeVcKac+Z2Y/3EZUe7heWr1I7NKIhTJxaWdii2NWnu0LlSaTknvRaouoMt64cTT
 Amb8425SEFTJNz2PrN0jY0N8HpyRvJH5903FqP5NjDJTUqSCSu9N1X3J4O+PBCLEtse8nfpV1h6
 +47jRSGvoQ2vCSWh3gtzUXmqoQn/zIRjvv2AvrjFpMAHc/Aub6nY0Xe9qMxeH0z2Wn/XSQh8nid
 5BP8PwKmk9nxHIatigFFBYztdFbGmJEltNpg03VxJpd8=
X-Received: by 2002:a05:6000:420f:b0:3e5:955d:a81b with SMTP id
 ffacd0b85a97d-3e7659c4248mr5016865f8f.34.1757751148850; 
 Sat, 13 Sep 2025 01:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIE+15wQYUhMNqii8b89mH4X0yxHS5Pb4oyidKdzD45sVy0lZSe5czC38SfsyaH3c3EQOGtA==
X-Received: by 2002:a05:6000:420f:b0:3e5:955d:a81b with SMTP id
 ffacd0b85a97d-3e7659c4248mr5016843f8f.34.1757751148392; 
 Sat, 13 Sep 2025 01:12:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e766659ea0sm6028410f8f.43.2025.09.13.01.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 60/61] accel/kvm: Zero out mem explicitly in
 kvm_set_user_memory_region()
Date: Sat, 13 Sep 2025 10:09:41 +0200
Message-ID: <20250913080943.11710-61-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Zero out the entire mem explicitly before it's used, to ensure the unused
feilds (pad1, pad2) are all zeros. Otherwise, it might cause problem when
the pad fields are extended by future KVM.

Fixes: ce5a983233b4 ("kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250728115707.1374614-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 633b72bde2d..72b571a6972 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -358,7 +358,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
-    struct kvm_userspace_memory_region2 mem;
+    struct kvm_userspace_memory_region2 mem = {};
     int ret;
 
     mem.slot = slot->slot | (kml->as_id << 16);
-- 
2.51.0


