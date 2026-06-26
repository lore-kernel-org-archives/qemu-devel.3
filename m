Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9AACDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3f5-0003dO-Rp; Fri, 26 Jun 2026 06:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3f5-0003ai-07
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3f3-0005ST-6n
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgCjIZjGwX7SpaWajCTdC373pSdn6nF6m99W2fnMJbo=;
 b=FQeko2rUs1X5Q7OiY4j/rX7HA3LZDSiBKof2W64KSb7/fuqnmptzrl4lc9a7jNayJsxLg3
 cToyFNO4F68lliqlvn0jIQRo5PWZIovOR8MZihyD/x/LojQfT97Hp+4fHaLMjmePU6tgv4
 Rjn/Unyg4dp+in3C/hYkDhUr/GM2MQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-smGT3y6pPY-7Q1bHB0Zk_Q-1; Fri, 26 Jun 2026 06:19:47 -0400
X-MC-Unique: smGT3y6pPY-7Q1bHB0Zk_Q-1
X-Mimecast-MFC-AGG-ID: smGT3y6pPY-7Q1bHB0Zk_Q_1782469186
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490e547f3cfso11331215e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469186; x=1783073986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgCjIZjGwX7SpaWajCTdC373pSdn6nF6m99W2fnMJbo=;
 b=fNYdPf49ex9eZZXQ6uFuM7T5FsH5DRsIb47+zwdZoadX/hzSQ7mvoEpjvo2A2t+ViO
 v5djJng8yAA+HJQRlmcM1EYK7auB+jkWS58slYlRmc69n9+M97ZwicCcUQBXX1mCrp82
 LjxJhKmiWjm+i+1MemcIzpVGWik1IXGMyeX2E/aaxnRVb5dY5k1xK3ze9WSJ5WeoHzdp
 2XrkfQJmY2kmyioOeBiRPvt9MsUEFZou3EpK85oI2Fw9NR3I9Ql6uAYENY56JqVVJiTs
 h9AjkuMGv5gtDe4jpWtM92lJnImm0y42FIu0bNXhDFF6ke9BLMTTO7n5vbzbtZBAbtit
 UTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469186; x=1783073986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VgCjIZjGwX7SpaWajCTdC373pSdn6nF6m99W2fnMJbo=;
 b=fVD16DO7p8Y2H/594+cskAhQbtDs4leAPn7XFzZJuv0xNAxt8ijLijP8mGFyMSW9Me
 N8wU3eT2E9fabOh04tjoyNPujoFit2aIu5+BZJE4YilKXkSyQdO4pPUJNRJiqJs6Lmk/
 YLdtxzmwzolJkb9oiu6JvdzOVnmgvVRTUnSpJtyTOyKoRHdljA6L50YJqj3+/QLrDRBN
 DSh8LjGvDdP+Cli5sP1Z9Et59n3MIMYK9EYgbM4WnwR95/rYD6YEf5HsJCxEV1+6H4zy
 socze3xktlND8iMFLsYoAvRuAUl3l4eBkytAcZZ1CYhg5n0SLdL3wW/VgYEJvUWOuaat
 6A1A==
X-Gm-Message-State: AOJu0Yy+odOMyDMRVW8VT8efKQR1Byr66y2V6ph2s+11h1hkQ+pdLKW4
 IpZKd3RzHF6h1sBuTx+svsx1FJ9GtCIwANhnn6GoD8A7mEGU2vu7Su2gIsGTEBz6lb+HUE0mzpe
 f73yqyxzBZ6Xn/NPHCLZt4DcM8FhNgIfg4U/ORQqagQ0za3GU68loJVT7m4OCoukaghdEcm7S5S
 qErpvO1cPCfMXIJ+ydt65Qa1OTyfksN5VHnDfG17l+
X-Gm-Gg: AfdE7cmBU5fumJJR7fipY3VhT12Ygasl0bWoICxqxEW8lF4i3MNMlf4AM4WYVoi1P9R
 VaI01h2yUKb63sZjOS+6NC+W45REYxCSBXXy5FEXSfbk60M6TQEqV8uqhHYUwqvyaPLmJrEzJTM
 TvQQPIg/+Cj2Q/xK0i2j2KJWAF9avI+qHir4N/DVhwEe18sngeZzJsAiYUBYV89CW9ua9Dhk2fe
 Gnjh7/Dowi/fMY5lurKy0Elr9M7D4YV2AbTvIAUl6Vybim/hbbncns01+Gv872MrWGsI1z+lm5o
 7+ggPVlPkXh/geBTkuJzZ7cH7UWKLpmyRMDOQDOiRiK1GM9F8FFxwASdtiOJMtNymEMihc7rlG7
 fGMaM0Lpln9BfinpmxccKBKM3D5YWQIVedZ1mIYuYEbX1lgCstbdsKvnscikbeHEP79f6uvGYZ8
 DINEOdY34XSWPLINdO
X-Received: by 2002:a05:600c:524c:b0:492:4d52:315f with SMTP id
 5b1f17b1804b1-492667e864dmr87631605e9.0.1782469185976; 
 Fri, 26 Jun 2026 03:19:45 -0700 (PDT)
X-Received: by 2002:a05:600c:524c:b0:492:4d52:315f with SMTP id
 5b1f17b1804b1-492667e864dmr87631015e9.0.1782469185453; 
 Fri, 26 Jun 2026 03:19:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690a1a85sm116074675e9.15.2026.06.26.03.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 43/45] i386/tdx: Use .has_gpa field to check if the gpa is valid
Date: Fri, 26 Jun 2026 12:17:46 +0200
Message-ID: <20260626101748.1728079-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

When translating the QAPI type GuestPanicInformationTdx into its C
struct, the generated code provides a .has_gpa boolean field to indicate
whether the optional gpa field is present.

Replace the magic sentinel value -1ULL, previously used to signal "no
valid GPA", with the idiomatic .has_gpa field.  This removes the
implicit sentinel coupling and makes the validity check self-documenting.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/r/20260512082108.621596-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c     | 2 +-
 target/i386/kvm/tdx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index 0e1cb3b4e67..09be7c8d202 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -706,7 +706,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           " error code: 0x%" PRIx32 " error message:\"%s\"\n",
                           info->u.tdx.error_code, message);
             g_free(message);
-            if (info->u.tdx.gpa != -1ull) {
+            if (info->u.tdx.has_gpa) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
                               "can be found at gpa page: 0x%" PRIx64 "\n",
                               info->u.tdx.gpa);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index df46fce7693..da4478cb21f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1403,7 +1403,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     uint64_t reg_mask = run->system_event.data[R_ECX];
     char *message = NULL;
     uint64_t *tmp;
-    uint64_t gpa = -1ull;
+    uint64_t gpa = 0;
     bool has_gpa = false;
 
     if (error_code & 0xffff) {
-- 
2.54.0


