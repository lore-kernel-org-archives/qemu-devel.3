Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0E7F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vg-0000Mp-5x; Tue, 24 Feb 2026 22:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vd-00006O-MP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vb-00089v-V3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=eIUX1RAsPMQzLuBgKcqe3gwRzcabsHXq8yM+NEWLQaCOT8+ztuHHK7QuZ8xDdf98SJ7Y7y
 ipEGkjtYl3kbQ8BdAt3CPs8Ur8YNvk7zTcryTjoj06O/IwajsC3oXThlzVwf28fMP0OqMM
 XXFLOz1Qx9GP5eJKdcu3X2hfGz+xRd4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-a0fpxCuNMPqLjX4yfsNOAQ-1; Tue, 24 Feb 2026 22:51:09 -0500
X-MC-Unique: a0fpxCuNMPqLjX4yfsNOAQ-1
X-Mimecast-MFC-AGG-ID: a0fpxCuNMPqLjX4yfsNOAQ_1771991468
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso5723769a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991468; x=1772596268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=e3YgGTrmadu5zYBMXAYMGGjdJJv9IUzm+5OGJgB3YbfNWf8BZ0vm/rH52NshteN4mn
 3JZfDpo08YQckKYPsyVxnab6mrxTb+EwlNSr3R0yklomSauZaOAKzkAaU/sRpI7Q9/AZ
 31wUSuWm2koLXx94bn/BKR2V0KYOrVO/LJxfpXkz+xL/qQt1AgDsgz+V+3VOWjEc72T0
 j8efEc+8Z3ym5XCJpHSqsV/rky3hY6zofSs+MYUiwIAqJCIMYv23+7VHUJkBIbCVZJWr
 R+p2Xo5XgdCmXvfA5Enq7+NndxiFHDr3O6rqN9tXzDR7m7vbNgRrd9uIjSGENyccE76r
 OV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991468; x=1772596268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPhZf11AJ6OznTneTjtivFAiVtwbcW8pDml41uWPO3Y=;
 b=wWXlbOVRmw0MJhXi+IirNs+z25s/STyYo3cxDz/3MLJRpTopaNkNxJeYawMNyhTuSJ
 +JGLKcAh/c5UBWAhRfQJafDRLj4uNooTyS8dDAX+m4PzK52aKarxb73xZeeCz927+yW+
 31JTmW1T3LJ4QpSctkpWfQTKmz0OQrIjT2SdW9i2hApAdEEBFWgbdzklv3w3sYMc5lHR
 JqTjiaMW7Dx+1zxeZmD7OA8tpHGHnu9C1BK8PQhVTmM/4Fqf9sXkwd3Imgtw91J98R3K
 3dyG2fPTU0CmZbNKikR3GIWP/Abbli7E7LhdfR8KBsijIUTT3Tj0VDPyynw9URbr6raF
 N+gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB/avbtSkG1o5BkMsmqf7A4KXL7Gb3tDHPSjTNA6dtsHW0tnfuTUqWUFhnx2Z+ADP9/vUS9eDhs5Uy@nongnu.org
X-Gm-Message-State: AOJu0YzX2HjnICvP5p6idb5A/kR3pgffizue9t/1rdoIKXHjh/R6oa6l
 KgIneMGc5ykKOScDokRfm9vtnqpch94pGo0MQkGUKgntaZD0q3qbei1gHeYwRixEs97JAunbn99
 S7tIkrPsEfg7B7Sk/5aZHzOIo61jE+0AIo37RC27WHNob7YzyXXPn4zPO
X-Gm-Gg: ATEYQzyYx4xuFInlFCGA8xXfoBYhN/C+PoVwYLdjig1PkV7SmE96uF3c6uOJ8jvRRwF
 akqUkhop9iegNfXelOs406zlmFHMzsZYRDtFtvMslEuGwJTtyox3Kug+4O1KZE/moIGw7xqaXyG
 y/prPWoub2/9NKGHEzCuRQUEM7IuHEEY7G7ClaRewyWCyNiBAgT4qeGKC0k689jaESCH9ZqjGwV
 gZnHSTElw/EhLYYBBzyvG+HaglOp103RTwlozOqPNxusze1zqU+W4IRJ8HB4yFaF8Z3RBgWECJw
 LvtfAIghZB0rygBIz4oWNvSobQiOosguw0OxdFlRzpCdNR7y2w1KnJ3SmSjFlsZ9I0aaZ8DQ3rY
 togDTnRetRMGowinJd+eQ8OIvHDFmraNRQxbnWCwVtt12tYvcyia96qQ=
X-Received: by 2002:a17:90b:5687:b0:33b:be31:8194 with SMTP id
 98e67ed59e1d1-358ae902e84mr11052150a91.34.1771991468528; 
 Tue, 24 Feb 2026 19:51:08 -0800 (PST)
X-Received: by 2002:a17:90b:5687:b0:33b:be31:8194 with SMTP id
 98e67ed59e1d1-358ae902e84mr11052135a91.34.1771991468243; 
 Tue, 24 Feb 2026 19:51:08 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:07 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 18/35] i386/tdx: add a pre-vmfd change notifier to reset
 tdx state
Date: Wed, 25 Feb 2026 09:19:23 +0530
Message-ID: <20260225035000.385950-19-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

During reset, when the VM file descriptor is changed, the TDX state needs to be
re-initialized. A notifier callback is implemented to reset the old
state and free memory before the new state is initialized post VM file
descriptor change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 37e91d95e1..4cae99c281 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -405,6 +405,36 @@ static void tdx_handle_reset(Object *obj, ResetType type)
     trace_tdx_handle_reset();
 }
 
+/* TDX guest reset will require us to reinitialize some of tdx guest state. */
+static int set_tdx_vm_uninitialized(NotifierWithReturn *notifier,
+                                    void *data, Error** errp)
+{
+    TdxFirmware *fw = &tdx_guest->tdvf;
+
+    if (!((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    if (tdx_guest->initialized) {
+        tdx_guest->initialized = false;
+    }
+
+    g_free(tdx_guest->ram_entries);
+
+    /*
+     * the firmware entries will be parsed again, see
+     * x86_firmware_configure() -> tdx_parse_tdvf()
+     */
+    fw->entries = 0;
+    g_free(fw->entries);
+
+    return 0;
+}
+
+static NotifierWithReturn tdx_vmfd_change_notifier = {
+    .notify = set_tdx_vm_uninitialized,
+};
+
 /*
  * Some CPUID bits change from fixed1 to configurable bits when TDX module
  * supports TDX_FEATURES0.VE_REDUCTION. e.g., MCA/MCE/MTRR/CORE_CAPABILITY.
@@ -1549,6 +1579,7 @@ static void tdx_guest_init(Object *obj)
 
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
+    kvm_vmfd_add_change_notifier(&tdx_vmfd_change_notifier);
     qemu_register_resettable(obj);
 }
 
-- 
2.42.0


