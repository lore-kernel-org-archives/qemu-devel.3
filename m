Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E3AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQU-00079P-DF; Fri, 12 Apr 2024 03:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQT-00078Z-7c
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQJ-0007Dr-5S
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso5128175ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907249; x=1713512049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3QxLZpCYn/H6Te2A9HVNEOscia45z8pGQiv2WcFZT0s=;
 b=sqmwV4bcV2mM3oMSICPtAvruRkJsxnk65pSTxClQmxUHHaRai22N9eQ9LJUT5vwie1
 52MGSDVhIRL33nrl52nR5BpV224k+2zShb8eLuNQPdakNotfBRGFz0nz1kuZkRmdwnUI
 XyKAF3M+r9AbB7TLdVyf16TiQzpvw2RfX1XP0geMZuacpXbTunV6uJIs46cZHkLgEpv2
 x30OuoVf1N6AvW4H1B+swjmU+bTTTRAAJygk/agqloXCnOURIZo7shVk43171+un6d1T
 rdDTzjKygy00fQgwUThsBAhNTGzCk9lnxXPDb4iwn5+owii4NiYVPaCXGQcAOQfWqJAn
 GxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907249; x=1713512049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QxLZpCYn/H6Te2A9HVNEOscia45z8pGQiv2WcFZT0s=;
 b=gO6UitRlUFFPy2Y5kl8KEnYLboqXOCc7slKnVGutn9APgNz0SKuwGtwNozIhGQQN0P
 JQ6/h7JVkWzwpWD8kZyM0TRlsm7B/TXGREtI4T2unMmhZCCiXllJ5rgkQ+xFDGXKilgc
 Jj2HFXdFqvsSbLqwwgcHzgoY2g8Za89pM7Yga+Ud6+f1QWBP00VXrfewGExNs0788DkD
 GgemT+gbhLHpQs8rDhS5W0ufjcaW+deRB5e4VzxuJNU9UyYA+a0i+QhWcAfcMFqQlYYN
 SmcmR2vm5usMcklGfmKmadoc9h0G0vN8Yi2VVLG1tz1nyaP0S3pA1qL6ouzwCbJrurhz
 KAnA==
X-Gm-Message-State: AOJu0YzJzlDjCJNPEZ5gEd1JqM6exMNEq7gamlQndKOST/e/qsxuoYzg
 2Fg5qghuX3jPEjd6/tXstPwPU21/dj2ZJpCWrKpiNI/JIfneapJvXm8e7ORwG/LxLE0ZOSoZYdh
 9
X-Google-Smtp-Source: AGHT+IG5RBGt5Un9YK75iOBNtHp3ZYReVPH39LObGB0GWouGYiwCRgbyffJJEM8+R9qOEXv7q56dQg==
X-Received: by 2002:a17:902:7008:b0:1e2:a5b3:e7 with SMTP id
 y8-20020a170902700800b001e2a5b300e7mr1477387plk.58.1712907249051; 
 Fri, 12 Apr 2024 00:34:09 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/27] target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings
Date: Fri, 12 Apr 2024 00:33:46 -0700
Message-Id: <20240412073346.458116-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/kvm/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe9293..1fc809b2f9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5275,7 +5275,6 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     uint64_t code;
     int ret;
     bool ctx_invalid;
-    char str[256];
     KVMState *state;
 
     switch (run->exit_reason) {
@@ -5335,15 +5334,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_NOTIFY:
         ctx_invalid = !!(run->notify.flags & KVM_NOTIFY_CONTEXT_INVALID);
         state = KVM_STATE(current_accel());
-        sprintf(str, "Encounter a notify exit with %svalid context in"
-                     " guest. There can be possible misbehaves in guest."
-                     " Please have a look.", ctx_invalid ? "in" : "");
         if (ctx_invalid ||
             state->notify_vmexit == NOTIFY_VMEXIT_OPTION_INTERNAL_ERROR) {
-            warn_report("KVM internal error: %s", str);
+            warn_report("KVM internal error: Encountered a notify exit "
+                        "with invalid context in guest.");
             ret = -1;
         } else {
-            warn_report_once("KVM: %s", str);
+            warn_report_once("KVM: Encounterd a notify exit with valid "
+                             "context in guest. "
+                             "The guest could be misbehaving. "
+                             "Please have a look.");
             ret = 0;
         }
         break;
-- 
2.34.1


