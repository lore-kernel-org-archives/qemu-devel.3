Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAD9C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqVr-0007tG-U6; Thu, 27 Jun 2024 10:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVo-0007t6-IJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVm-0007Ho-Vw
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2IS7msecJ7gmIh0NCWZXMeuw+h41Tdg1NGfSCga9pg=;
 b=ZhQvZfLaCJG7EBhqu4mirygfdSx8nH4lMKCPnQvCy02yTjPxC4L0E2CURGhPebQXcCNfZF
 ujsOxkOi4J+SpwYT5ax2iiKkEPlGJJ9q1AkNCdC/bHcsLa+84soZDHVCBR36yFfdgsTIMn
 B1g3ZXpgp6LIQ51vKUmOqzcOzWXTgpI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20--DyqZtr_Pzqtl-LASBiWbg-1; Thu, 27 Jun 2024 10:54:07 -0400
X-MC-Unique: -DyqZtr_Pzqtl-LASBiWbg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec5f22cbedso38627791fa.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500046; x=1720104846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2IS7msecJ7gmIh0NCWZXMeuw+h41Tdg1NGfSCga9pg=;
 b=aNJTL3EKsyZ0NzFiPCai3JQfp2Zt7bNrTiQd/7xnRfdCSNpHNlaU9P+MEMl3nw94FP
 0LkyTZ6pJGLl/Ss0/bklqLcg5Y7gtqwfhqsBeMTQzu0O2QeTxcdujz6zz6yU7cNQ7FDY
 PzbCwptyXjOJ4lY3hCxyhauzwNAYHJEBp3ao6x3nNKhBL++vy+wTuHyYBUqspZoqCMFs
 Ix5Rgxq9HSnFWvCB8QUl3QXOJVYP0nrqk+Mim7kEk34rci/3dAhs+XHac4vVnpt9QZhp
 e0epQjFncZgm4c3ZazYO4PXOMQFUbfrJTeKQMP8t25r+Aotpl6g23PR8fQ3ipgm/8+IV
 HpWw==
X-Gm-Message-State: AOJu0YyuUmKQmoP8CydsZ2N7O9CAst1IZbNuCOEuMXw19y6ew5ddZD+k
 yzQnL6mOfw3d4iRsF947bWp4o8QtdocKXc1yJmA46tEC5lum9QqYPjouTaYaNbwOzUW8ddV/MZl
 lkbjBWy3L75Pa82LGkHLLq/dqP9A6WYRbs/lDhVbkxmZaxdeKXNoa72tJl1wU/vODlGitFOps1x
 mnr5sM5YqlpvzOpu/AhbNNgfh6+ulEY6C4o/aP
X-Received: by 2002:a2e:9213:0:b0:2ec:4de9:7334 with SMTP id
 38308e7fff4ca-2ec5b2fd2bdmr102371951fa.11.1719500045832; 
 Thu, 27 Jun 2024 07:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1k+lYbTD+7n4O80+xmu4J3yLVNOrQN8wKmP+f+TOBZeuFiPrz/dpymR3tuctAyStwfx8mmg==
X-Received: by 2002:a2e:9213:0:b0:2ec:4de9:7334 with SMTP id
 38308e7fff4ca-2ec5b2fd2bdmr102371671fa.11.1719500045296; 
 Thu, 27 Jun 2024 07:54:05 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-584d1280e88sm977815a12.39.2024.06.27.07.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:54:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 2/5] target/i386: SEV: store pointer to decoded id_block in
 SevSnpGuest
Date: Thu, 27 Jun 2024 16:53:54 +0200
Message-ID: <20240627145357.1038664-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627145357.1038664-1-pbonzini@redhat.com>
References: <20240627145357.1038664-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not rely on finish->id_block_uaddr, so that there are no casts from
pointer to uint64_t.  They break on 32-bit hosts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6daa8c264cd..2d4cfd41e83 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -153,6 +153,7 @@ struct SevSnpGuestState {
     /* configuration parameters */
     char *guest_visible_workarounds;
     char *id_block_base64;
+    uint8_t *id_block;
     char *id_auth;
     char *host_data;
 
@@ -2170,16 +2171,15 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     gsize len;
 
     finish->id_block_en = 0;
+    g_free(sev_snp_guest->id_block);
     g_free(sev_snp_guest->id_block_base64);
-    g_free((guchar *)finish->id_block_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
     sev_snp_guest->id_block_base64 = g_strdup(value);
+    sev_snp_guest->id_block =
+        qbase64_decode(sev_snp_guest->id_block_base64, -1, &len, errp);
 
-    finish->id_block_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_block_base64, -1, &len, errp);
-
-    if (!finish->id_block_uaddr) {
+    if (!sev_snp_guest->id_block) {
         return;
     }
 
@@ -2190,6 +2190,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     }
 
     finish->id_block_en = 1;
+    finish->id_block_uaddr = (uintptr_t)sev_snp_guest->id_block;
 }
 
 static char *
-- 
2.45.2


