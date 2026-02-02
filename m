Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDD5E7314C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 09:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmq4I-0000cA-NY; Mon, 02 Feb 2026 04:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmq4H-0000XS-0N
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:18:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmq4F-0003H1-FI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770023878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3Pz7n7+AYNpxM9KfqJlclF0dfGQFBPgnsRoPIV0bGi4=;
 b=ayLDFvc3fPWsAQqfqgHHaq+VdoKh0lzO93TmdycDv7X6U3+8tJMkff5IEgcOPKKw+eCzbM
 /5tc3AFMRTifNFHvZuRpRwnzttLYjjoAgFzZmnFhV5289v3kNxXELqeVh2hA0rwPYASrf0
 CWSPD5TTT32cgAssktF0m6yEhEKEbgQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-ZQZy_FB6M8ip0tH4oz5VqQ-1; Mon, 02 Feb 2026 04:17:57 -0500
X-MC-Unique: ZQZy_FB6M8ip0tH4oz5VqQ-1
X-Mimecast-MFC-AGG-ID: ZQZy_FB6M8ip0tH4oz5VqQ_1770023876
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435db9425ebso4319472f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 01:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770023875; x=1770628675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Pz7n7+AYNpxM9KfqJlclF0dfGQFBPgnsRoPIV0bGi4=;
 b=BC6oWcDvwCLhoiMwHDdxw7WhAfilIMvc1lKrSKYINAp9fukKDRvQH304haF+6KSiky
 6EgMt4ak/3DHz4LkiPDLYGr7h3dugh68jLsMc7O01Pcw10AytOHvdLWz+TmcKRh4wDdS
 cBm7vED9jqkeSPmrzAiP2xeoKgTj29HrXK5JAtFQfaHO6Fc0Fg7vAGlrxum8MbSsLtfI
 ALO7ya5IPrOWJJzRtmRHbQAPV4MWVxLcD9LADRT1LGEV6yfWPJ3rnGlGAmAxb9sy2iAi
 K14hRvMGMDi37OdOraX6M2Nb7ymMHdWVVXMYmOfx4ynFB4YmtOzTvXsOutKDxSK3gfRU
 4U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770023875; x=1770628675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Pz7n7+AYNpxM9KfqJlclF0dfGQFBPgnsRoPIV0bGi4=;
 b=M5rWJwKdu60bJe/0X2Dkig4g4wY3/GSmhq5qK6WrbMlatVIsNgQwSfK4ofWawmUN90
 IVgKynby+D7KiJqp6cLvzOeiazSKkzb2QZDzocX+uJvzisATZrqEWO7r+r9euO0mrwYP
 huRCkQ6ftlvW3iP5GZ4Y219mazJ4R2ToB0suqotiJznaEYrH5YVe4DMHrVflYk0wVtbS
 Wyb+Fj1VjhkiN8Z7r8wsjYvekl3Z4uKWrxdR0KbVeSGAX1lNraZn4uJUCx41ZujYS5gw
 OWtKnl07vkzMS/YlYpNNfxFDYegJOE4LEYmRlJBZelzCETV5RGfAfj0E73QRGb7Hypf5
 Ud2A==
X-Gm-Message-State: AOJu0YwcD7cCGoVYsfFwnuiFC72j38j5illTcEmkxQEAw1emgj1fQezJ
 HKzwZbrn5As6iqiJFlYDvtZqxgBsSWZCNgLYQttCOgj26zjvGFalwYqdgYetWLTykveE0tU6RtA
 JScGeq9eNOKMDyVFggt+gDP5KyykLXTjyGvE4sEG9I+kXcmE1d+xSiGjbTHsQuo88ZQsWtJ5uiO
 mXYCiOIx+BIdnSTWHuwYgn6F5iMHePkYFA17eFTehydj0=
X-Gm-Gg: AZuq6aJwPsoTlV38gdZL7UehvEb2WUdM/DHghfowQxT6sQ1Jqd4JqD4WJJK5yglqVMe
 d426OYTud+N/3UCli8ie0TAy/6CPGS9r1AyzL5elnCFrjwBGfikhxsn7n6MWnSmE6IPO0CZCUAs
 g6vYCVRPpUtz5E2bPpOtrmcCPmg+aTTcHwIhWvx0P38B40mmLRgMSco1ii1V5+9uxDPa7ElHErO
 xAZ8W4wkKrKuY1JNKgSAsaoml9LgKHeKwO1x9xZV0DC6313T40FRL5RHbwf1B8v13P0bQVOLM8q
 pqFgY6LcXZTAcSm6A7a26hMwywNrGVHauf038cIxpU2OAfwFOHYnVxp2sk0/e8b19f9/EghvnAz
 KEtdhspOuKWZ/p+SCCaGXhkCblrJ7z33F8mGMp+DFsm4AkdXoyX3VURL5wGJT8tVK9MC5uIQyUs
 D3mpTXTKrUqWuM3w==
X-Received: by 2002:adf:fdc8:0:b0:436:db8:c4a7 with SMTP id
 ffacd0b85a97d-4360db8c4b2mr885190f8f.6.1770023875272; 
 Mon, 02 Feb 2026 01:17:55 -0800 (PST)
X-Received: by 2002:adf:fdc8:0:b0:436:db8:c4a7 with SMTP id
 ffacd0b85a97d-4360db8c4b2mr885158f8f.6.1770023874832; 
 Mon, 02 Feb 2026 01:17:54 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e135422csm44397694f8f.40.2026.02.02.01.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 01:17:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
Subject: [PATCH] Revert "tcg/user: do not set exit_request gratuitously"
Date: Mon,  2 Feb 2026 10:17:53 +0100
Message-ID: <20260202091753.28459-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This reverts commit b422a7bff64eaf55b8250225533ca1df42c3777e.

The reporter says "The commit breaks go; if you run go build in a loop,
it eventually hangs uninterruptible (except -9) with a couple of zombie
children left over".

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7c20d9db122..ad94f96b252 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -751,7 +751,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
     /*
      * Ensure cpu_exec will see the reason why the exit request was set.
      * FIXME: this is not always needed.  Other accelerators instead
@@ -759,7 +758,6 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
      * CPU thread; see kvm_arch_pre_run() for example.
      */
     qatomic_store_release(&cpu->exit_request, true);
-#endif
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
-- 
2.52.0


