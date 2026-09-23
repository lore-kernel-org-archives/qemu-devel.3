Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADDEC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QpK-0007AB-Si; Wed, 23 Sep 2026 13:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnr-0006m6-VJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnh-0003hN-OA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0k6hYdy9n9pt5ZV4khXSiOuR4fbAslYUogsJM6eNfZw=;
 b=bo4l6+Sn8TXXCRGdRHSO6pVXYSKsRcTWBDxmxugoNhtf05yL7BO090ekN5WeAcwx5iJ2Lg
 FrBRz8hBqXkCddKkOzb3lntrPel6L4/G6LTO8NM/OYf3gGKTSztMj3l1eqmKl2gz06ri2p
 JanhQ+m8bVQ2f8oW0I+eW8D164hRg5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-NWMONXttOQaFViaDvr3omw-1; Wed, 23 Sep 2026 13:30:31 -0400
X-MC-Unique: NWMONXttOQaFViaDvr3omw-1
X-Mimecast-MFC-AGG-ID: NWMONXttOQaFViaDvr3omw_1790184630
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so17093385e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184630; x=1790789430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0k6hYdy9n9pt5ZV4khXSiOuR4fbAslYUogsJM6eNfZw=;
 b=Bl0zYIexHH6ivZdBEKXXtWKo7rL4JEPf9RtZnej5Sdq2i3W6Mkn0X4FAjmfl7NGFjg
 7XszzBhueB0VbKvith1VAoiAf5AvJ3KZI9VvBqfHIHC1XVstWdpMSVgVchHKQBsCM9+m
 0ehtgAg9HFDUGaaaxF++RI33H3rRO/S7a/j5Fmrf3JS63QBDF62mDT1iZVo1yGBvBHLv
 ETFuKII4utfBBmJ1a3SfEYL1rH3p26xpAO4CVktyN8sJKj58ojYyoCK1vW3bUVYl2C9f
 pKD0S5UVEk8gYZa8ewJCJ8raCbOc9GYMZs//HTdG3XdNvlWyHLtzvmN8TaQBLnr1Fu3f
 0Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184630; x=1790789430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0k6hYdy9n9pt5ZV4khXSiOuR4fbAslYUogsJM6eNfZw=;
 b=di26kODJP08cWl6mnU32cWMXfsn0KqirlXcmmTAtJXyW8gJA55J1w/CA+O9XJdkXV1
 GJmuxiKoa9GtZ8A+QXIN1AGUFvOvjj7kZT/d2eeMLPB0rWuGSOm3E/Uh6wDFEz3Hlh5A
 AJnivIOxjlqFWm1dfYH3Z8qbjRStFRA0wzT8PQU/T1w5rjOkSsyejwXGppktpdUCCp21
 tSYIBYWqQNH1i/7MldBPX88xBOL8jO5FCwNICDgqjbCTkx69fS17KPdR7JEFH0wwlBnj
 Ecvdu1GskSYw5akowMoqBFcS9mKSrf5o4fP0LSOmqpKRA02+aF2NXRQtoADYGAenNqBB
 LFYA==
X-Gm-Message-State: AFuF++mt9nCQRzNk72YY+mlVPOPjZkLJ8FyKGUZlxL/n3YqK73T35B1k
 ngfyDno7acfo2HJ/GWq8biiKAN4+xbjb0dJ+o4fs26na2Lr3ebNloxep3kJuGSPAeQBU8bqN+En
 KEwYTxZZOt8zeJ03dK3jMRbX0j8K2nVGGb+NdRWacFCFHwND5aQl4FHjADONg+VKaKirGWuC8jF
 J0kcGy43sZPs3h3NUQ+ymB9YijezPWFqiSxloDEgS8
X-Gm-Gg: AYBFou1X0YFyRuCoxy+IacBNup9LgUZdeAA5jKEvdS8MekSUH5xbI8A0+joZBe6BNtd
 Bq9+4pM6coX4sieviRyrC/IgLQqI2YmgX42mHQdfC6sU/s9Uon5LqCpckxFeBWym86bC0Zoz7G9
 MUMs3WjBrI4zhAlVM/GjaKOkEaJfMdapVWwcVy+fW5tsz6DTwaspQVOj01+lHFeTM/0gpYoRaaL
 AdOQaX6Mi78AWMxhy8sELlwdO04ObYqzYUM0giFFi7Hoi8xaSaYruAdsxTiXb+S92zfO7Y+ylcP
 2L0NM47v8gpS7/jT4zTji+/ex7Odedgdgl1DCfpNxEwpS9vwb0Jf+rnvH6ngHkTISpeI0R2HIkj
 O5YncFWr5PIZfCI9yDvFQSOMRYWiGBlNnqeZlSBODC7I73GYVUitajoNc8VcIebfbA2+bVMLHXo
 PAOqjkON9ajO2YjnM=
X-Received: by 2002:a05:6000:220b:b0:487:219e:5e20 with SMTP id
 ffacd0b85a97d-488670a04damr5962683f8f.51.1790184630296; 
 Wed, 23 Sep 2026 10:30:30 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:487:219e:5e20 with SMTP id
 ffacd0b85a97d-488670a04damr5962648f8f.51.1790184629894; 
 Wed, 23 Sep 2026 10:30:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a19bsm8977592f8f.25.2026.09.23.10.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 03/17] target/i386/tcg: use zextT1 for CMPXCHG
Date: Wed, 23 Sep 2026 19:30:07 +0200
Message-ID: <20260923173021.317809-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 target/i386/tcg/emit.c.inc       | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0e6175b8dbc..d8299a760c3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1365,8 +1365,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
     [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
 
-    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock),
-    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock),
+    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock zextT1),
+    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock zextT1),
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
     [0xb3] = X86_OP_ENTRY2(BTR,    E,v, G,v,             btEvGv),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index abf40123035..e4700473c9f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1760,11 +1760,10 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[2].ot;
     TCGv cmpv = tcg_temp_new();
     TCGv oldv = tcg_temp_new();
-    TCGv newv = tcg_temp_new();
+    TCGv newv = s->T1;
     TCGv dest;
 
     tcg_gen_ext_tl(cmpv, cpu_regs[R_EAX], ot);
-    tcg_gen_ext_tl(newv, s->T1, ot);
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
                                   s->mem_index, ot | MO_LE);
@@ -1787,7 +1786,7 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
              * not zero-extending it on 64-bit processors.  So, precompute
              * the result of a successful writeback and perform the movcond
              * directly on cpu_regs.  In case rm is part of RAX, note that this
-             * movcond and the one below are mutually exclusive is executed.
+             * movcond and the one below are mutually exclusive.
              */
             dest = gen_op_deposit_reg_v(s, ot, decode->op[0].n, newv, newv);
             tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
-- 
2.55.0


