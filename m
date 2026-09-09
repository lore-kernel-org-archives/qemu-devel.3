Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFEBC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfH-0001fk-9C; Wed, 09 Sep 2026 11:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfF-0001fF-CV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfD-0002r8-R4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFQlekjKWMWAZqQHp/Ga4e+ueWlo5/2upHua7TvBBEo=;
 b=Hlx5mUONARHM22oUzuzR5vBpHVe+Yq+ZMDBAl/dy0dhIYLMS3BwJ9D4rY3uzGkBn+USfqk
 R9qZ8rreHAyYuNcOI8H3UwsYfltj8yKl9iIf3aO+1tCllfY+n5hbGRVfXMCeSGBETN6amq
 L6QrSL17oUN6/0CCLMw68M+SANxGKOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-V-DPj_-pMg-HGmO_4FlSgQ-1; Wed, 09 Sep 2026 11:56:41 -0400
X-MC-Unique: V-DPj_-pMg-HGmO_4FlSgQ-1
X-Mimecast-MFC-AGG-ID: V-DPj_-pMg-HGmO_4FlSgQ_1788969401
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49545071724so53451745e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969400; x=1789574200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GFQlekjKWMWAZqQHp/Ga4e+ueWlo5/2upHua7TvBBEo=;
 b=m0mVw6FtpHAIjFkIon2K75x1G+UZv1Rz7qnyFswhOlVPceMyLGWLlIRAL7dH9qJH7t
 AkKMDB5jFO9GKuWX4eUQCpsulYBfXGOk/lWWj/8TnkSX3XEYMnqExFGfkN9lsc2rvZPA
 zpre9BHqDmaz4hIDz2x/BAySC6CU4SQYpGCeO0h2rDWdxkZInu1l7qJx6XYrwpTHdPuC
 OxilhaNEyiOM6+WhwjPaOoKDvpwmfZqjorBuF9AW1ojqsGSJQnMI21pvqAZ26Q7MKTiy
 2Cdtk5jkJ5vA7WcrI1mPjXz5JJ3FUy70cGHHmbjTLDhNO+m3ta97hQkRkWK5ZXDIRPPz
 dmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969400; x=1789574200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GFQlekjKWMWAZqQHp/Ga4e+ueWlo5/2upHua7TvBBEo=;
 b=kaTPNM7WTWXs+OAV45/YoNA6u314YA17AElxrfP9viCG8gOitQlU7oKu+H/w/6zsEE
 dd4lDZv7B29S/EJQ26N2H1cXWiNn0hdVO4kIrV1fLJCAeF2g6dXDjjWiyTB1HRQnIqA2
 VNi/BNbEYqDROJqhJMbwbbxl9IZA3qcKdV7jfD4lQ9BLoa9cqc3ciKgnNTFQbK/k9wKU
 +aUkXEl8AOeI73HLUHIDxjWG07WMo//b9hebxAv+AJJEZQE+4C6GdeeKkJ4Hsm/TM2GL
 sxt4f0QvvEsjkimML0YfucYz7AdNnF67BHORagiC0XnJKp2qTES38/9Vb4fvDYcdOPo4
 qMKA==
X-Gm-Message-State: AFuF++mNf/nPA4r8vAVoHaG2J1uwVel0Igav8PQHXbnXRWRvP6qhNV+U
 KEiVZukC1ft8R5lw3QRxywZcB7uXYTDSRfpWzcVGXB5tmK37VU1pWwo1jUX4AMB7SgQBQ7tFMrg
 mfQbV1AF7LECIQWQaJk+Tn8zIB+PWZ+pKHjvnmf7I1I4jx77s3B+n/pKN+ZcGoQXGDQS0Ne5Oec
 RYNHJwERrAFMFTXtJBaj0ENlsZ4+3cj2qmk1nMlxqz
X-Gm-Gg: AYBFou0dvG2nlntAHvOD0DHD/txVCQ1Skb75P3fwoEqO/PaCQQhOxDEygLNE186ywaV
 KvdTSgLvx+WRtGITlNCjfH3eLhW7MdQMbMPSBM3bnMxm5C5COpLNkuzYBsgnpcSq6omfco8WHmY
 M2P8h6bFwz+AofY0Gk5YP43r/VYEXftCsZAypC+P3HwPbjEN2Y5RL64QxiHgu0qGb2rnT7OZYmw
 kOimOAsRF4/rXgftu5r1c00k3uxQTaMWGsmfb5Csk+F1VXxZoqAVDPpcxAl2AN6ZzzldIo1tsNh
 xYLrHekB+LU3lQRcHEd7rmZgT55qEmk8OmH/wLO5YzH12yMmYud6OHqjtc77DQ+Y1dRSno1bK/F
 RVghwJ5umHw0qF/WJSaDyRmmfcN2g6uPMJkmLg53//+qFE0VdZNF999FvNQN7Zt7Np/nevY9oZg
 K9fIjZ
X-Received: by 2002:a05:600c:1f8b:b0:49d:797:83bf with SMTP id
 5b1f17b1804b1-49d07978531mr255713695e9.21.1788969400585; 
 Wed, 09 Sep 2026 08:56:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8b:b0:49d:797:83bf with SMTP id
 5b1f17b1804b1-49d07978531mr255713415e9.21.1788969400165; 
 Wed, 09 Sep 2026 08:56:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm240085e9.6.2026.09.09.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>
Subject: [PULL 05/12] target/i386: Update FPU tag word for FXCH
Date: Wed,  9 Sep 2026 17:56:17 +0200
Message-ID: <20260909155624.1082893-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Simon Scherer <scherer.simon89@gmail.com>

FXCH ST(i) exchanges the contents of ST(0) and ST(i). Both registers
receive a new value, so both should end up marked valid in the FPU tag
word, regardless of what they were tagged before the swap.

helper_fxchg_ST0_STN() swaps the two values but never touches either
register's tag. So if either register happened to be tagged empty
beforehand, it is still wrongly tagged empty afterwards.

Mark both ST0 and ST(st_index) valid after the swap.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260902120419.212855-3-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f42448ab206..2149f4b1d20 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -521,6 +521,9 @@ void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
     ST(st_index) = ST0;
     ST0 = tmp;
 
+    env->fptags[env->fpstt] = 0;
+    env->fptags[(env->fpstt + st_index) & 7] = 0;
+
     /* C1 is unconditionally cleared to 0 */
     env->fpus &= ~0x0200;
 }
-- 
2.55.0


