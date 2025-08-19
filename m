Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE37CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNrV-0001hr-Ha; Tue, 19 Aug 2025 11:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoNrO-0001gf-U4
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoNrM-00037E-2a
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755615763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kQ9lT1OjonXDE7ojtwUvyJ+YuUi3YecpWmE7wW/xZos=;
 b=DinsaILk7PRzavFSdVf2GkQyD6UCMQTMhBLfiPqWFxI9rDPzChe3uZvOTxQKyoXlqC6+yH
 G0FT9Gfa9sgSKv+KTbZ4UeTseqR9tUtIZTWEyqjUiUin8dRui6jbCgPKu0a2QCzL7RPsw8
 Kt9MrzgIVEEeAU8/SK2t00EkgLwzwTQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-9h8BQ-7YNfyi4h1iDxF53g-1; Tue, 19 Aug 2025 11:02:39 -0400
X-MC-Unique: 9h8BQ-7YNfyi4h1iDxF53g-1
X-Mimecast-MFC-AGG-ID: 9h8BQ-7YNfyi4h1iDxF53g_1755615758
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c2ba0so2520441f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755615758; x=1756220558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQ9lT1OjonXDE7ojtwUvyJ+YuUi3YecpWmE7wW/xZos=;
 b=fNmymtp4MoibB3Yyf2pkENe9i3o3rncKVHqbZ6EyaDmb535gIPwY04yMTJ+neN/ZZO
 mw33EZ1uTSs6ILOrI1/dGw3ezYQOUr+b58ownWjgXV+XzfWphnXn4sVWg/EkhjC97v2I
 YwdkDNAIZy2MfjhwDv0bQRC88ybgj+km6C+0kMwTEHsw4qI3bO/9EUTuOL3RB1xqU6ZK
 b46jJ915EwnmtZ4gNVPqkEIrG7lTrZqZLYBgyrKgbHp0CehxzdFfZh5TagLKaiiEXQX0
 Jhz5ZEJ9bvwNkQkrwshzOlMQ4obyREamxi+YyZjaPowPOB3TS53lwkzdu8Rvcj7+K8uG
 HrSA==
X-Gm-Message-State: AOJu0YyhO0t75w9MgH2tATUKL7W51ht7gSVY5OYkBJq1nNilqGlhGe+6
 xfAesjDPeZ2swZaRn9GT9dVkkmQZ97prPGIAcU915E1tBfTtoZJN2kh0iImTcd/vedHyrQyx708
 YAebAxjgLbAjw6SUf4TckiGY/zeyhm/fpFsi7R4eO8TYsJmnKC+TBSRdDCZW7vOcKE0fpfwE6FE
 qFLrm8K6kSLqZLotv0JVqVGanKCGRzPjKZhsfGzdGZ
X-Gm-Gg: ASbGncvKAwLUwt0n8Iw1UlcahhutODMS9IrxK3h6hJhmA8u87bIjvdrwGHDchNp99V8
 YMh+q9lK9NBy4ZHcO8N+Vg9WwuOYGI7ac/KrIfwTjL69lWit7S/6LBXXjtL9rFx0LHiNGBQDT6C
 4zc8Ahs0ArnUd2qgzmko/wEAWOzxzmPB05pnFpd5qcZxQ+THarwVzXCJIe0TMyjtAKDYIKdzU27
 +YSt0gwDBaWtgX+yNj1UM3/e6ro3PpRTF8RcnGYVrHtAUQGyychqTiKITpsnyYnQAojLsndPHmp
 kduEuFS+QWEEyF3ANu8azrxvwCeLsAtV3ybD03F0cQ==
X-Received: by 2002:a05:6000:288d:b0:3b9:53c:24a4 with SMTP id
 ffacd0b85a97d-3c0ec660816mr2218555f8f.39.1755615757687; 
 Tue, 19 Aug 2025 08:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbWaEW2Y+DdROqNsohhfADL+SQQamwgdgzbrFYgcLJ7bN0NnupxqVAuYZMLcGp9S8ytD51qQ==
X-Received: by 2002:a05:6000:288d:b0:3b9:53c:24a4 with SMTP id
 ffacd0b85a97d-3c0ec660816mr2218514f8f.39.1755615757138; 
 Tue, 19 Aug 2025 08:02:37 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077789c92sm3954741f8f.52.2025.08.19.08.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:02:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 "Christian A. Ehrhardt" <christian.ehrhardt@canonical.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 10.1?] Revert "i386/cpu: Warn about why CPUID_EXT_PDCM is not
 available"
Date: Tue, 19 Aug 2025 17:02:35 +0200
Message-ID: <20250819150235.785559-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit 00268e00027459abede448662f8794d78eb4b0a4.
(The only conflict is in the !is_tdx_vm() part of the condition,
which is safe to keep).

mark_unavailable_features() actively blocks usage of the feature,
so it is a functional change, not merely a emitting warning.
The commit was intended to merely warn if PDCM was enabled when
the performance counters are not, so revert it.

Reported-by: Christian A. Ehrhardt <christian.ehrhardt@canonical.com>
Analyzed-by: Daniel P. Berrangé <berrange@redhat.com>
Analyzed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 673f8583c80..6d85149e6e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8946,9 +8946,6 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     /* PDCM is fixed1 bit for TDX */
     if (!cpu->enable_pmu && !is_tdx_vm()) {
-        mark_unavailable_features(cpu, FEAT_1_ECX,
-                                  env->user_features[FEAT_1_ECX] & CPUID_EXT_PDCM,
-                                  "This feature is not available due to PMU being disabled");
         env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
     }
 
-- 
2.50.1


