Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1BBCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV8e-0002fi-V7; Thu, 30 Apr 2026 13:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8K-0001yQ-Sy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8F-00052c-Uc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLW0aaUZkJx8RbCCaKKrQoxsx4JCtu9Gx9IDHjchKLU=;
 b=dvQoMx7vqkDkMmnS3knTxlOrKd3yzojFn45gcUDJXuyV5faFPUk8Ac1ABwORCHQD4i9JWF
 uWCwEwtKvb2W0FmQnoxeWPSkHyGVtMwV/OTiwUCEyI3zCrJ3om7QE1ujglRWooMNOWvhml
 GpkpHmQgzfjX52NPW7RJ6RLigL3P7GE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-TISnxUsuN4SAmG_JaSvqtg-1; Thu, 30 Apr 2026 13:24:57 -0400
X-MC-Unique: TISnxUsuN4SAmG_JaSvqtg-1
X-Mimecast-MFC-AGG-ID: TISnxUsuN4SAmG_JaSvqtg_1777569897
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d654ade33aso487389985a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569897; x=1778174697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLW0aaUZkJx8RbCCaKKrQoxsx4JCtu9Gx9IDHjchKLU=;
 b=PIWTcvgKHcp+j1uYafRifGHROaTtXx3EUEN8NfO6tWk294EVg4QaHYGV9MLeQDdNpl
 ElmJpXmK0LmpSDHAUy+yXMzvNN72Cf9B6rdmoUftNSLUBxUe5eg9hle0mxcnghEJfaDY
 obyjeQmphdXbR+goG3PBhQTbRII0xXofVM4SR0RydpZLWLLpv8gDr+ksVr/BOlqFyR7Q
 P+pdg/2ccCYfO2A3pkkjnV47NtJQ9/E1OKSgnWXpd+oZRWji2kLZ32Ls9uQGb9aK5tRe
 ZQIEmA/Wf/OYpAgNsYVgyIv5+/ktnCGbJ44W3YGDtA2VMQUMuZ+h8BuvhqiDdiJEwKhQ
 1KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569897; x=1778174697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nLW0aaUZkJx8RbCCaKKrQoxsx4JCtu9Gx9IDHjchKLU=;
 b=g97e1talYysu2UW4uEQWXyKxLM89+kHvt9EwdQq+GGGxMZHWnZ7uVb1hhLZmjnUg/c
 yYFMIsU4h8ukw7NwpHTBwBfHwLtKritkmx4m4oT0ozi69J3pl8bjztIaaH++7y6b+FEm
 JNNVS8YIKVMvxBdb6ZDj+6f+/yE9zXGbY3sMwZRqUyvd/kMqu9tCd9Kj41MnDQJpQzxJ
 QhDpC+0zOaQ+B/YaJLJf7Z8rsR0Jwd4KkPXKwC88Mz+11fbcQ7wYSm8B0Vb9LNz0GMyq
 9GAezI7zm1pomvC+tGPnBCVw6lRlYlByFRIg+AmLbuthHamxwn/k73IbOxpoXGwTCkq9
 aing==
X-Gm-Message-State: AOJu0YyPObOlr7BgwlxqOQaqGdS7CzLS/wjTATCre4P0Rqk9ddmzdM8y
 f26DY51lm8MujuliFM9iTgDt4rGBgr2DMG+gly3OSOkbr+v+cYakgEj+ZUY3Q+GdihY/tGK+wx3
 AOZReTJ/XntjE6XSzN6LZk4bvnLJIa6qrWOibqp68zFQcgtWZYjpyTuo7ElPj1U+WL2E0kDtF9y
 /wur0yvP0t742QoGD77woMCODPTEpfITKSHZ/v8S8D
X-Gm-Gg: AeBDievwFnR+dw86kXL0B4wg7CbnEHTvGu5nWha6xGBkEpmyDMMoeOfOCUUUotU/JM5
 fOdfvKoYK79/uF507hF45wesGQR1Koi4RUUJXZKQ4QEoLO+VGVb8yESE8VGbI67dfWarQ4tyL71
 y8km6ExsFxKYMvCpuklNsu8HFHW4D6s5PUmldFZI2Fbzz+12q0EPQ9dQYl+GWI4L6F9kT6ppXw8
 ta+rslmBM2nGfLNHtiXZAtldyFX+KqeNsLQAoOkrJaNHxTHLqRSd0EZ4APpXn5vt7CNWfVR+d94
 XQDWIQqHV0aXmKIUgUsfFbFG+TIiutaDuNMkUdxntor9dqQiQpshJOACK60hfX0QhV2u+FoYtX/
 P4LHPdmbf0JIlVBKL+rI4ca6Egeol+Y51y6Pjg/10Aaa8YyHjT4TJpTwVr/fFR2cNkfA7frKGoL
 dP28ekAevYqjTgA0eK3r9uHbnTL/o6ypg2K78=
X-Received: by 2002:a05:620a:4726:b0:8f2:8bb8:cb6d with SMTP id
 af79cd13be357-8fab8d08b37mr468671485a.12.1777569896864; 
 Thu, 30 Apr 2026 10:24:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4726:b0:8f2:8bb8:cb6d with SMTP id
 af79cd13be357-8fab8d08b37mr468665385a.12.1777569896335; 
 Thu, 30 Apr 2026 10:24:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb09fc964sm27957485a.9.2026.04.30.10.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 55/58] whpx: i386: update migration blocker message
Date: Thu, 30 Apr 2026 19:22:01 +0200
Message-ID: <20260430172204.1006673-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Quite a part of it is from older times...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-32-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ce04d6b06f9..5750539ee49 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2622,8 +2622,8 @@ int whpx_init_vcpu(CPUState *cpu)
      */
     if (whpx_migration_blocker == NULL) {
         error_setg(&whpx_migration_blocker,
-               "State blocked due to non-migratable CPUID feature support,"
-               "dirty memory tracking support, and XSAVE/XRSTOR support");
+               "State blocked due to missing dirty memory tracking support,"
+               "And some system register/state save-restore ");
 
         if (migrate_add_blocker(&whpx_migration_blocker, &local_error) < 0) {
             error_report_err(local_error);
-- 
2.54.0


