Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF17D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYG-00067G-Eg; Mon, 15 Dec 2025 15:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYF-00065w-LH
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYE-0005i0-7x
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8ZubJdrLstUHPQhh3/7CyY2NbdwUkv9s3/htRkbmeA=;
 b=BI/1aq49J3lLcDSwmeX7qciWeJnXRD1BsRaDfmokeSdSKNx1VNroSEBMnVE6lHpXM8JcBt
 3Bkep7/y/A6IVbL0RAgLqG1AnU1lJAM6Y8LbFEFpioyUqBGiP7rsZxXvZQ/9cN3VNsJNBY
 tSq6YYBfCzuPfANUY3kZJ+LGrjgbAYg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-IINjn6UmPw2bLcK9PsvMzw-1; Mon, 15 Dec 2025 15:52:11 -0500
X-MC-Unique: IINjn6UmPw2bLcK9PsvMzw-1
X-Mimecast-MFC-AGG-ID: IINjn6UmPw2bLcK9PsvMzw_1765831931
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b1d8f56e24so898725785a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831931; x=1766436731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8ZubJdrLstUHPQhh3/7CyY2NbdwUkv9s3/htRkbmeA=;
 b=OzSlpMS336lxbjGrgeOKqHWwWG+/rhrOGPEaNq7P6ToMtzyIWWL7b+wwMHQHvLRKZc
 DS/qSIZn54Ny8kpWqU4i2vk+tPfZ4T2F1HrJbAFmgSicV656OGoqQ67N9Ef/A6K2c7Qz
 G9I5GNIlAnT7sJXJ0T7s5JUkGA/JYWKQtApvOEV1q1IdbCZczztjRm6LGPFDbZwVQU6m
 lXRX1oshSy1oy+P+JIafjcVswTXmDWGGltX1Vv+VU8XxJ7Kb/dU4/DyrX4joCL+U//Ch
 cxeKzDScbZ/4SJJyK/P/DT6AF1tmDoxMwLuK0nO4yHAQGFWlMJweU/wWSvuhhpTPnrf6
 yErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831931; x=1766436731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v8ZubJdrLstUHPQhh3/7CyY2NbdwUkv9s3/htRkbmeA=;
 b=jp0rbtI2BrZOQjSBrEd6ApFd4W9+LOobuR3tm9Q8UaNg5WEyRPJtb3F4I3FOcORJd9
 HoTv09co1SBUCm33rXtlgtJRTQHC7fPJnTgmocl+JJoctS2x2EBK+abMIpMfXd3iFoSV
 1CgeD75+SXFB9gB9e0dmG1qBQD8LRWCpOib9Que3E0frpn9Po/MDYpE94vXXtE0o/CEB
 IrXOaOasKahNbGaVTybaWwUc5t5x1apLQY45PFNcoIMKwEhG8IbnrXf1TzZLVOx8k9EZ
 teNK7HVrze42MP7Ur1QHYn8J69gMrLCWJCF9mXYXjsoz+87XjNLPIZsm21DY8vgCjun3
 bwGA==
X-Gm-Message-State: AOJu0Yx48upwz1Q/xGstgZFShKmrPK9AVPVNhl0zmpud+XEgeUWBWKe/
 tYJnHX2BK9v7FPvojOQ3qW+1wHouwDi9We+KXbBUemmGoABo43FxOFTPuFvgIKFtFPFF4iW0wW9
 MP8+BzjR1Ktqy9tMqABtAHABo84cMUbSNuVk2J8vIQyQQZ8m/caIPFCm4r1yrvfbxxko0jtWEce
 TZYNbdNaDYJAVlaDQ097cbORCthmWCscpxWOjxEg==
X-Gm-Gg: AY/fxX5XdDZXDSlkw29JKVD+996yOmQ4gIIz4s0+w+Ths7owtUti3yKClu+iZnJvmsD
 FUbtrJoCpSUvBqU9uLtDvYjgzL3QxU8dm/WrXCiLbjsCs56Y0euE0u/ig1dYCRCZnUHOp2TerdO
 R/vE1BToAqEkdN3WXaiiXdHA0EhrldGCYMv18Z1LHUPRF9/NWchAFZNNHf5XKwd0cEimJ9D172W
 Yrzjf0mBW9ID847I29/EyqEduFNR1z2ZwW4CGSkSO+7AKfvQJwYMBTbX8apJbvdmLzAyt+MfrR6
 gKellfKjznLAIwHZ5+jJkgBttJQe0aVSSjI0Wrh2ILlT2MdhyYpXytr6qz3K/yVsMLNMqWL+iv7
 q
X-Received: by 2002:a05:620a:4621:b0:8ba:1326:8c56 with SMTP id
 af79cd13be357-8bb3a38895amr1784640285a.63.1765831930972; 
 Mon, 15 Dec 2025 12:52:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4ZKjiocK9hhofHjOVY+TOu1rLK61wKaslSAfGoaX0AdwCotGzXdXZQXjTXD7WcLDStaLOlg==
X-Received: by 2002:a05:620a:4621:b0:8ba:1326:8c56 with SMTP id
 af79cd13be357-8bb3a38895amr1784635185a.63.1765831930368; 
 Mon, 15 Dec 2025 12:52:10 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:09 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Date: Mon, 15 Dec 2025 15:51:54 -0500
Message-ID: <20251215205203.1185099-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

So that there will be a verbal string returned when kvm not enabled, or kvm
not compiled.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c    | 5 +++++
 accel/stubs/kvm-stub.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 68d57c1af0..c32fbcf9cc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4492,6 +4492,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         .flags = flags,
     };
 
+    if (!kvm_enabled()) {
+        error_setg(errp, "guest-memfd requires KVM accelerator");
+        return -1;
+    }
+
     if (!kvm_guest_memfd_supported) {
         error_setg(errp, "KVM does not support guest_memfd");
         return -1;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 73f04eb589..01b1d6285e 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -123,6 +123,7 @@ bool kvm_hwpoisoned_mem(void)
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
+    error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
 }
 
-- 
2.50.1


