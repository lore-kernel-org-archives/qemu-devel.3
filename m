Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8140FCEACEF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 01:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK4y4-0007n0-TV; Fri, 14 Nov 2025 20:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK4xp-0007fu-Nj
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 20:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK4xm-0005qE-I6
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 20:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763169624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SFCxemDtbldpYBFLts23LyQ+KluOcI8vUawyMSrV5ow=;
 b=X271iJqgJRDFwuk651Y2QLWbwBxlOCEnXc40j5HBLnox99XXFRzbyyO06gUqQx0+vc8Iz3
 Uslp0Udv1QMQ7VE9zz+dKM16P2qHIQCByyMVw7va4ydlEP0Z+StCdt7Sw19yGlN1C8lwmH
 d8wvZCFT2+C4Wsvera5fWXLlnh3n4g8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-Dps24Dq3NPqIG3oij_MrNA-1; Fri, 14 Nov 2025 20:20:22 -0500
X-MC-Unique: Dps24Dq3NPqIG3oij_MrNA-1
X-Mimecast-MFC-AGG-ID: Dps24Dq3NPqIG3oij_MrNA_1763169621
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b487cda00so1266986f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 17:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763169621; x=1763774421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SFCxemDtbldpYBFLts23LyQ+KluOcI8vUawyMSrV5ow=;
 b=N8fKC8/5WBSCF0YeJn9iG4ay72rN0gqJRbUFSy5YloRt6YtPTXZOUL79f1GoSng49l
 qdkDOZEaQ7s3YGVStVxqWYu1ClK7o24PnXgsToOHJhtU9r5bUjebJ1GFPPW39jS+x3gP
 LCKDYI8zkHNFVvTTi97QeXfc/QWp9IoUmHhLSLp1pwbsMN3tpKJmswEjt4qHDhoHHAq1
 SQyfUs1sbA9qs2gy/ht5ckagorSqG6XkdO5CbzlyvlhAi6ORNRm71hHrQ6dT+FvknsXb
 6Z33jnRL/3pAhcXDfXbYoDrxp8VDvxrHdYCB+OYLZGVywokm85ODjBjF10X/1Pn8xC1h
 iagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763169621; x=1763774421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SFCxemDtbldpYBFLts23LyQ+KluOcI8vUawyMSrV5ow=;
 b=TfCVKgoUOxrg4aFVR2ml/Cm1SfK/aqxd7XoAp5p3EQsQkyBzK+oVn5y2l446jt8XZl
 cZtwd6C0QlIF94/j3HeKFSSHFLypMWfU8fBoI+TrUCv7Y3cNySHuIOyOBa/I2kp2F1WZ
 HbiJuUcEBsPisiQ6GQ6S4vM3bOG6wZU4jgYVXylm9xZXNzQ00oTTC7rCRUpDVtuEU25y
 JxTv87xQSpio/QPRv5tajT1J2t0YeE5MgLLV2TN/QpZQJAAOR2J3eMzWJXYrmGiaRz5d
 ZnOpt80cTSjdWwBc0SfDf9ZkUDL2IywNgbaBZKaIHG6rZgonVttIv+8CexGlw+5n9cjE
 Po3A==
X-Gm-Message-State: AOJu0YxpHxxZUvACnCyLgCuqi/a+J4ejBfYoJwFgkKZogRI/g3CxQno7
 ac9IIprM6N/EDDWl5ZrKK1l89iQ8YCJOa0qOKD5enr1bPq4rwU/2phLruXXWY35JW/39fYCjxnF
 6sc4MceyxsD8l3SSgo5u9KsM3jO/yuuhEwhSTmiBFjmQQ5sHyKk8IDYvgMSV/CDVYtorSss6TzX
 ZP/F0WACyY727GRtbcWzooIPdJMhPNISvG0gdq+Idw
X-Gm-Gg: ASbGnctpOk9WsgjZYz4oudWvUM+ak1nY0c/Fp7SLlhbo6CEnQtzLTa8ZPUzLHkch86B
 J4yfwLFO0ZMtSx5m9acRD39jqbEG6kvlgTOvfmNjTVmuCJ32W45MFzHZihdQiSeAPHwIuSE+v9a
 0XyP2CmIinRoaJT1WwdKL80y+zc5E2/dkrK3FnPETlLosljOHmSUAsBuVAMgedDcny8AIsK7Tid
 Wra6gnIo8hFUzCf7KjNKJC4V33Nu3PeYTealU0hYmgIZ0Bgx7NVrHHpI00NP1R10llFOzrVV3dJ
 ANFVNV5xzkimbu8UJ6TKCVlgzbUvQwrxr5cz1Nqk+fY0zpZspOOjhclQT5AmATXr/wSe5/kgsgE
 dfzD+er5kCXtYex1MEr6rsCi8xfnmTujsNWr2hij5wsXrTk6yNlWWCX9d4DSmN/pVu4X+Zl7cBX
 +SM3De
X-Received: by 2002:a05:6000:2209:b0:42b:3ed2:c08b with SMTP id
 ffacd0b85a97d-42b59375e29mr4477060f8f.51.1763169621094; 
 Fri, 14 Nov 2025 17:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu8VEP3bJgxvoq35uVRYLW4+AoztiIx5lEdLrN6J+VU0ASpKl1ZWd0HFvxo049s8K1EUNz6A==
X-Received: by 2002:a05:6000:2209:b0:42b:3ed2:c08b with SMTP id
 ffacd0b85a97d-42b59375e29mr4477053f8f.51.1763169620612; 
 Fri, 14 Nov 2025 17:20:20 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e846afsm13127483f8f.13.2025.11.14.17.20.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 17:20:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: fix stack size when delivering real mode
 interrupts
Date: Sat, 15 Nov 2025 02:20:19 +0100
Message-ID: <20251115012019.148444-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The stack can be 32-bit even in real mode, and in this case
the stack pointer must be updated in its entirety rather than
just the bottom 16 bits.

This is the testcase of https://gitlab.com/qemu-project/qemu/-/issues/1506
but there are other issues.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 667b1c38696..41cd63ef3a1 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1161,7 +1161,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.env = env;
     sa.ra = 0;
     sa.sp = env->regs[R_ESP];
-    sa.sp_mask = 0xffff;
+    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
     sa.mmu_index = x86_mmu_index_pl(env, 0);
 
-- 
2.51.1


