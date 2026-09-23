Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57738C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MOG-0002e0-A6; Wed, 23 Sep 2026 08:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9MOD-0002dk-Am
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9MOB-00037b-OS
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790167673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=paF8CjpgDLCoqjf2gPrt4hqs+WsAj0bpqYw16w1K67U=;
 b=Z/YQ+p0aK9MXYoQdJVxTHWnLw3s1UMBA2AhxmD26iBXCwt16iD+KRt+zsx53iDj77DuEA4
 ZORh/GnpxK561EUFSFqEiePHQL8G3yeWoA6QB82dOlRBqzzXsuoKhQM3nKdOWEBQ0m3FQY
 HY0YdXPrrY8buZB2imAAD6MACVq/d0U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-qlwBd1i0OayP3pXyXvoEKQ-1; Wed, 23 Sep 2026 08:47:52 -0400
X-MC-Unique: qlwBd1i0OayP3pXyXvoEKQ-1
X-Mimecast-MFC-AGG-ID: qlwBd1i0OayP3pXyXvoEKQ_1790167671
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-486f3dbf7d2so909580f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790167671; x=1790772471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=paF8CjpgDLCoqjf2gPrt4hqs+WsAj0bpqYw16w1K67U=;
 b=nYXZZdk/nsSjCzuWhLkdFCTQWS0wz2ZjGoJAopT+dC5h5vK3O2sDRoZ+kFz/jY5uK2
 yMMUelGDqzHCpXRqoVulngh9nqFrpIM01YI1w1aKmC6KASNU0Ie5iM2vbCFwHvvwCoaJ
 r73SAT5za8urQQegE4dq0u2UTDXKGZT0DIv3JdBjB/yeY/4Y1EEcdMNkM8l31AasHZyA
 RFQP09+KQa9HpEoySreQHicswaALxIh6tzLOhuOXFI0tDl22EVukSmgLdLwWOLJWJboV
 ObGbK4Emp4YFEC5UbRy8NCVH4IRD3kswcuDAuypzZlKs/krj+BeszwV8GzTvC/dKWJxn
 cLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790167671; x=1790772471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=paF8CjpgDLCoqjf2gPrt4hqs+WsAj0bpqYw16w1K67U=;
 b=KsDY4Q+h6e1HIsXpyxs2r/EmhhK9IUyGPhnksrwABuCrXPkv2Ksmb5vApMHKd3fsmw
 lKvyJaKunb6c1Nm8zASqLAk0ef2D7z2AekhJjnQXTx+2KTkEhe0/qKuw/z5yCzwpJr3Q
 EigZBtC4TXaeGAtEuQtKAK6CeeZXDIrwKPUEA1Z1NYrwPI2kzJDWzhfUUcNIspdBbKbp
 2TlPa6qQdGHzinAkWGlxibsIwuuFi2wLgELXw1Wg2oZgn6BRhYKjcUuVGcA8eO4qIm7U
 jpou7o62e44ueK9lwRYbIzp8EhrhOy8tZP28kCgWu7kzaAwyW/uaw2Q48t6LRlyzmINJ
 IHGw==
X-Gm-Message-State: AFuF++nfoXO9GfG46XmMQRMSomGwWdQRvfpMpF3NBmlIcGmjqzLq92l9
 ksPCkoekKQ3zgTTwuOQmK+AB2Iw630RNPvuZt2BhpfOtAyflEcgQgvIiHs61q/lUYsRSnGmb4A6
 wYl5jh1CkmBNi3+aP2EuneIB8MDnWePE3UBmtZueCFBjzIamTjG6HCJxrqCc4/+5qI6S4OUrL4a
 twEsoQW6CN1cxRqb3BFff/FB6suIvWLHhoC4bb6FRo
X-Gm-Gg: AYBFou1VEGgMVCD8IWtdWwG1YjJf1YdVROd0KsPsNFO+Tkmbs8jjeE5Am4ieVeup0lu
 xlQHHQ6W58fy1wfoAZIzGpGaZqFydJt5PPB3QXBwcEp79AhNVdE0ztYSRoM32dWXvLMefAuXR50
 xkKUVMQrPfPC/v1EgDlJtDiiqihfMTcbeA7o9H78kNEgwMOkpuYc5Z5dMQF/7t5c9YpSx1ilNu0
 Q7M4RKx58AMnYpdagMjNtZ1ZLJg/Pdd8qp7ZmyA2FFB461doE8zE1O6mi7nJV6UnN/2BzVpeRv1
 gFjvXmzkKY64IaVO+8XOUEyck14k6QD+Tk7qbQnc6NA8NWsgPTuSUhacOouavDaLJXHM2NE8vfb
 WrbTkIJY2buBnZcZ9SM4aw+PHuaPv/B279CIGQSWM9x29lzJ+hj3t3CFVihOQ2xNgAlE/tHFtmy
 zMd+G1
X-Received: by 2002:a05:6000:41cd:b0:487:342:d143 with SMTP id
 ffacd0b85a97d-488670a0390mr4151889f8f.33.1790167670964; 
 Wed, 23 Sep 2026 05:47:50 -0700 (PDT)
X-Received: by 2002:a05:6000:41cd:b0:487:342:d143 with SMTP id
 ffacd0b85a97d-488670a0390mr4151840f8f.33.1790167670486; 
 Wed, 23 Sep 2026 05:47:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682668e7sm7958890f8f.4.2026.09.23.05.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:47:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] target/i386/tcg: fix REPScalar with memory operand
Date: Wed, 23 Sep 2026 14:47:49 +0200
Message-ID: <20260923124749.273446-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
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

By the time validate_vex() runs, e->s2 is not used anymore and
decode->op[2].ot has already been filled in by decode_size().
So it's the latter that has to be adjusted, just like before
commit b7d4ec4832d ("target/i386/tcg: move VEX validation early",
2026-08-26).

Fixes: b7d4ec4832d ("target/i386/tcg: move VEX validation early", 2026-08-26)
Reported-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 8d1e581cfde..26f6d6277be 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2671,7 +2671,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
             }
             assert(e->op2 == X86_TYPE_W && e->s2 == X86_SIZE_x);
             if ((s->modrm >> 6) != 3) {
-                e->s2 = s->prefix & PREFIX_REPNZ ? X86_SIZE_sd : X86_SIZE_ss;
+                decode->op[2].ot = s->prefix & PREFIX_REPNZ ? MO_64 : MO_32;
             }
         }
         break;
-- 
2.55.0


