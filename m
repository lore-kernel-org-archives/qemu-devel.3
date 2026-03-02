Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79ACD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvt-0001Kj-Ms; Mon, 02 Mar 2026 03:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyv4-0005mz-Rv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyv1-00020P-6x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9u53hMXx9IfJyrriLWgxmlEcqPjwDvz8vV2vMP3sM0=;
 b=CZCCXZTuGAoT+Txr8Lz4TqFsuqBFcp7k5Z4luXq53mJBA4xwzr2ZvZunx8PeaTnQiXVxzc
 3AYOGL6q1rV3S9JAIr6JFw4jXsWuTWarXHXt3HrGfFF103AGILX0lf/FIyUWveEZR3W7sG
 dbP+wrIFXmWjzG33k83m7TXaaE0EyW4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-vM0PCvQIMIqzSEB9SpglAg-1; Mon, 02 Mar 2026 03:46:20 -0500
X-MC-Unique: vM0PCvQIMIqzSEB9SpglAg-1
X-Mimecast-MFC-AGG-ID: vM0PCvQIMIqzSEB9SpglAg_1772441179
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836c819456so28177775e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441178; x=1773045978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9u53hMXx9IfJyrriLWgxmlEcqPjwDvz8vV2vMP3sM0=;
 b=GRyqjncXo6nwpcUsIL+qbNoyBdDJ/fgfUAB0KW+q2uFUPR7rVP52I6AHWbYbFzc8SR
 7MxNbLf7hS9mULz2eofmqIXy8yl3NnBFLp3b+qJK4e1FT0qhU794jPxnZKFIENqhhQ3L
 7xDEpu5Qa80Xs2BvchPeFe4b4/Tugk6LuottaXX1MZle0tqv+a+VuBJjY/swAsGYT5vg
 i8tbVq9+StuQiGVRLrFx3jYUzl8JUP5cvjfSTO2tjDrqOA65qk0ovesn5R7ZjMDD5LLW
 hxjwZxitUk21S1NBwxttDwaYgkv0OiP5mKDlEs28cSMzH8cJ+zPKpCSUxzv8CFaeABUq
 TwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441178; x=1773045978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X9u53hMXx9IfJyrriLWgxmlEcqPjwDvz8vV2vMP3sM0=;
 b=qapKCR1YVBmz6RBUgRTHUeIUxi6u0/S+s2fIOvQchJZMhjeMe+zza5iaFu0IDbBH9V
 umMN7AAxZUsE2nbfZTb30XCs7tu8M8HqTpbswRyKD7Oi0lN1YajLhtQjBhuwCXLU6a25
 P2BArrXBujTWPw5PYqogvJaxCnMuVCfSs0VeDBKGOoxDZuXENsVD9xImhew3UNomeouf
 PVU0rdyCsDf1dYFYulf3pCAlWNJcXKQBY5tZvm7ebT0j/yM5a9NfppF5ezoP2YqdYVOu
 vCGjcMFb1MOdJi1g17f3TFT53PNk23FrIWZddkh+DPaWnY1aLW5xGyIpLNPF5ZrcDe/M
 83Rw==
X-Gm-Message-State: AOJu0Ywdgi+kMRnnCTgixMmS0kbkabydqn+bQi+baYR1ICPAQWMO7nEM
 oMCKs5yQJJld6DdFg5IJsvaMOxB0xYk2LVgxHAfGyjsFKEzTSvx5T9UD/DZIrBeYOKHb1vf0TXD
 scAJSP4cIq45PBgl46HvCQhwKqRIRE+5mhQHbpQXhJSVBqg8W4hFmt236aagqjuvqIg/6QiF18h
 6/iOXaSHsI8JMijhvirrUlWD+WLqgqgmxpz0GaCRt0
X-Gm-Gg: ATEYQzyTbjK2CWwFn1idtwZzzyKiZAymfdP0nSNF47aQQkSlmFxc0KqADTouSr/3N1x
 S0SLNmw+oYM45fxgsyAQX0RDqbCpFvrXgXEGRwvuybki4tAW+t3x1yldzIRfaYmsRAvEI5dmmUm
 q7zLMGd5kP0vQUCUWXIvVPDKB81Kk66jKF0E3Lh+Hjv8bS4QNgAEbMRyUStdbMCuwwk3X1Uy9Fi
 Zg2ECAiV5P+wfiViezRxTKZTQFsOf1HslISemCDm776+TF0ZdmOGlS/mlvNX2sr/86y2LElO6XN
 ELGSfzQuBPsFfgL6SWVjWTYTIrX2WDc65DOYEkUJMrsP4QvouXIWP0amBsqKf58YOF76uhdd91V
 Tk7vMuS6TngzXksYEWoR8yEvVCWHXkiv1BZjiqdAnISriYJhLHtfkMJaRY8Peqf4eRyY3qkuLPa
 K0peBgDrlbduzOaVUCGtO0+RAbFuM=
X-Received: by 2002:a05:600c:1f91:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-483c9c2d7d6mr193328495e9.33.1772441178016; 
 Mon, 02 Mar 2026 00:46:18 -0800 (PST)
X-Received: by 2002:a05:600c:1f91:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-483c9c2d7d6mr193328025e9.33.1772441177458; 
 Mon, 02 Mar 2026 00:46:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb789efsm205325885e9.2.2026.03.02.00.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 059/102] i386/tdx: add a pre-vmfd change notifier to reset tdx
 state
Date: Mon,  2 Mar 2026 09:42:54 +0100
Message-ID: <20260302084338.473368-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

During reset, when the VM file descriptor is changed, the TDX state needs to be
re-initialized. A notifier callback is implemented to reset the old
state and free memory before the new state is initialized post VM file
descriptor change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-19-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 37e91d95e1e..4cae99c281a 100644
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
2.53.0


