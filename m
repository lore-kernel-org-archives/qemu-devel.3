Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D9CC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjzvs-0008UC-Mf; Mon, 17 Feb 2025 07:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjzvE-0008DE-74
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjzvA-0004GN-UP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739794098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yQHFinggyBHz5OeCqu4arXdqerpATUVpiQsl1u89y3g=;
 b=dwrYneYu3BDpMGK7DEfL+kZzPS7R+Dk07bL4GVe8cJ9qWwha+qRgHUSOAIkfdf35bKXL1M
 LdNGIXgdNKhCCAN7eD/ocp+6pAhW8M9NXSbS2PsGNwbIrQbDsPluVnWolacIZmD14rYkN3
 yXrQpEXwrvsMoGV3CsMPzeV424JiPrQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-nNHwBpE-NkSjzKQ2iMwIOg-1; Mon, 17 Feb 2025 07:08:16 -0500
X-MC-Unique: nNHwBpE-NkSjzKQ2iMwIOg-1
X-Mimecast-MFC-AGG-ID: nNHwBpE-NkSjzKQ2iMwIOg_1739794095
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so35790415e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739794094; x=1740398894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQHFinggyBHz5OeCqu4arXdqerpATUVpiQsl1u89y3g=;
 b=NfwMT9TYNRPFd+VEpy5U9ZGLYd/fc1bZMJ+dcZH1wBPqt9oa/zDtQM8PH7lkP/kGHm
 /whpOnwa5x7G4+fOv2uFKvXRCtdx+RS8P2iLleaRL1KQmmJkUMkOnXLSkgjmG000Ta1g
 3trBFFYoXJIawwb4BYGWJnqY5qjAcDDmwque16YNyW4O/fKG8zfhB/djmrDs8i/EIymo
 N7suYEjNHYROVkVOaQGrF6gEO5hI152pf7yUbuqpBjU2XaIHQxGLo99J9mVGrVRwwDjm
 O8ltowAfGBkz3CWySB6MN8L6HMYjkBVYp2GD7cJZhADlPBHnaAgpG03ryUX6gJ24HsAL
 w1EQ==
X-Gm-Message-State: AOJu0Yy2Es/4mz2BFsY27nYpgvoNUDZrm5TEwWqwJi1KeG2c40jXdogO
 pYlZuCAVkRAtLor9aMgr7DXkew2eN6aqjaToqiQ0EhaSb1dD6zrs2kEC6kFR4/zFPHAqVkYuZbe
 9XgWQXmOfQqcpHfnb2o2nZxCw9bzccBhLO4bHfRVUKEU9QQTPSBDasYyZ4bGqN6yHxn0vKaFrJc
 M6RvPR6z5mLFVoHHjq32ppjnI8g0tOsN/kpG8RdWM=
X-Gm-Gg: ASbGncunOaxZcbHaveNQkrk2GlG6MSrR9aC5tjtBdsJEAa9WSEg3p/m0+67BXUaWJUw
 BE0LHd++8QT2dNDdl1n5yAnEslxkWEO4Q7o0DnuYqGPQlcexWFAOX3unhB1d74Jc4IOiXRpSYi+
 /w573CKR5fPznnhXa5RjlPmVAB7CRnFrBm1IGbSh8t96nbI5bjeSF6h7UFBwhtUaaX2iWhjJJRk
 nri3nRddbXgNGNqixeccX03w3V1iLRb/4v9UwZiLUmme50eKQe56Qv6gciErH97SOviIYaB6Ooo
 7r6pA64I6m4=
X-Received: by 2002:a05:600c:1c24:b0:439:6304:e28a with SMTP id
 5b1f17b1804b1-4396e5b56e7mr103496995e9.0.1739794094669; 
 Mon, 17 Feb 2025 04:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8n5jj5ck4rmbzE3ykGpBKMNW4HFIrj5UhhZI9CD+6O+k4QAQZTjTfwb8phy7krBRb7oP3Dg==
X-Received: by 2002:a05:600c:1c24:b0:439:6304:e28a with SMTP id
 5b1f17b1804b1-4396e5b56e7mr103496705e9.0.1739794094276; 
 Mon, 17 Feb 2025 04:08:14 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f8c1sm152463365e9.8.2025.02.17.04.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:08:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	qemu-stable@nongnu.org
Subject: [PATCH] physmem: replace assertion with error
Date: Mon, 17 Feb 2025 13:08:12 +0100
Message-ID: <20250217120812.396522-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It is possible to start QEMU with a confidential-guest-support object
even in TCG mode.  While there is already a check in qemu_machine_creation_done:

    if (machine->cgs && !machine->cgs->ready) {
        error_setg(errp, "accelerator does not support confidential guest %s",
                   object_get_typename(OBJECT(machine->cgs)));
        exit(1);
    }

the creation of RAMBlocks happens earlier, in qemu_init_board(), if
the command line does not override the default memory backend with
-M memdev.  Then the RAMBlock will try to use guest_memfd (because
machine_require_guest_memfd correctly returns true; at least correctly
according to the current implementation) and trigger the assertion
failure for kvm_enabled().  This happend with a command line as
simple as the following:

    qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
       -M q35,kernel-irqchip=split,confidential-guest-support=sev0
    qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/physmem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 67c9db9daad..1ddf9fb10d0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1882,7 +1882,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_block->flags & RAM_GUEST_MEMFD) {
         int ret;
 
-        assert(kvm_enabled());
+        if (!kvm_enabled()) {
+            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_discard_require(true);
-- 
2.48.1


