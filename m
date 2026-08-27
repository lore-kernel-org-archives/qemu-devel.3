Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E95C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzas3-0002tp-6j; Thu, 27 Aug 2026 10:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzas1-0002tI-Kr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzars-0005uj-CF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzPmt7KVQkTpe1/d3/LXdqLWTe5gTJkqbQqLF5f/EEg=;
 b=DTpwgr+mu/7anPiwZ8yWSXTU8rvbNGer/Dne0TipnsPb0YoaLEAO5tViCuTlxUjsAFhplD
 TrPiv6x+13Xzf7WkjTwFCjDj002QUSxRr0HVlav2KhtqqB1NNN0hHRxbWke0z+bfiAu0x4
 qKxupgU+GtNX7jMmaSfM8rEHR2YbVdo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-HrBZcTE3OiS1TgDX_UGlFA-1; Thu, 27 Aug 2026 10:14:08 -0400
X-MC-Unique: HrBZcTE3OiS1TgDX_UGlFA-1
X-Mimecast-MFC-AGG-ID: HrBZcTE3OiS1TgDX_UGlFA_1787840048
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso1074158f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840048; x=1788444848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BzPmt7KVQkTpe1/d3/LXdqLWTe5gTJkqbQqLF5f/EEg=;
 b=EnUdsI+v+MXwhNxW6Q0trv1NcGVsuK2He1GTuAAvxk0GPMJbcrcXCUoItmirP0KG9Z
 8QHp2NThvJFoCif10NnY7KKUJDFi1gK31jiyxf6zsuGKP6lRf7IiVQ9xuKHRy5sOWJnu
 hefWCS8TdEJP3UsOfTDJNcmGhvXDL/EWF9dLOxcWyGMOTVjVt13pPdVQ4Qqtr+DUjcub
 5wpaePkKwaMQC8DI0dKg3RO68Q1NGie7OtCWpW4tFioMNAqgbbD6TxgQzuJeZvjn9YLs
 1pAG5+bqQB4Rchpxk+Fl5nzk5yVna8GFhAMKLcBTku4IT8kwZw6EPNMM2VVFDI2p9iX3
 gzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840048; x=1788444848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BzPmt7KVQkTpe1/d3/LXdqLWTe5gTJkqbQqLF5f/EEg=;
 b=oj+/urEK3U6+Ue5JLLrpbn0PRbgKoeEEqN/Q1v8zzatLCUyuU3hUX5HwWN6oYQIJM1
 Ah8L0+fjCeiu11d8UGY5RkmfFSmXlXcd5gSTHZtNZTW/lKSW4LhE0i1p0FWF4IAZqd6c
 zCECyhF88/QH8N3mxPedkrhvx/7aDQ63m4+wOaT8VRcVMiXGED9cX2Zwx8qzN0A0lRFG
 qJaOAnpwlwjNxdLQxJcce0h0hKiEjSkT2bEDc1MFLiEniE7H04lfKyL42OoMZyIWwWpp
 Y0/AvNGGR26Fys2Tne3rwBXXJT5Y5kazyC2CCNTOePAMFUKLAFRn4CSla2QEWsLetEON
 vUMQ==
X-Gm-Message-State: AFuF++l26B80EciJNNcT+Hzeyd/SfAP+Lke/TVz1pY2oAb1YLBRt1hef
 hTz6tazSLmnmRyn2iIIADQCCS4Aaz3RzpEEjnTMnOF521ahtcl/csi41AXaCL7A1hWInAuKVu1S
 PwHROIFRufTS9LZSHkfc8VQlUt1I6L2TxWCQeF8mfmweOgyquJMmIh2bLd2beH0N04W9lJklPpZ
 rCru0EAPNhOgf9IqoYV7+PhvbxEek9z7eWI/gst0Ah
X-Gm-Gg: AR+sD12hctTBKBak6v+ITM5uUfHw0V5r/h371RaUnOnynAESpwu3WtMk22wSNl69H2U
 E55obVoYe7u+j7+1aZ/ZlTFfp/RoxaD9WLsgLz+URKqoeXsCyZRhl9arwsBXBh9jVHQu5L/rftx
 AUZFVq74SG4Ox5fChmWe6flttWVdgJmKz5Xi0kPlwCmj5ALqRowUoX+9LcGnHzdBisc70mt9DVz
 wSLaXtfPFRBWKWTO0FZiCs5Wag0xXlV3KuBIu11L7vj3jt8woeC21LAJTqhl7q24xIbTuxgdiwO
 6j2b8F8zCigGzucVSN0dBj0jwOolZVDMuB/w6drKV71uRJapC4MkHU4pMgb0ZiYuFK/kT+mLhRV
 Ah1BOemgaYfV3XBhhQ2yWdTSDeELbFBn5Tlnz4p6VYYadkjTzkXUDvMPqPjgXZeOpLpuzS5+D2k
 1UW2o=
X-Received: by 2002:a05:6000:41d1:b0:482:f344:5325 with SMTP id
 ffacd0b85a97d-482f3445421mr7675589f8f.3.1787840047726; 
 Thu, 27 Aug 2026 07:14:07 -0700 (PDT)
X-Received: by 2002:a05:6000:41d1:b0:482:f344:5325 with SMTP id
 ffacd0b85a97d-482f3445421mr7675388f8f.3.1787840046768; 
 Thu, 27 Aug 2026 07:14:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27aa050sm9109506f8f.12.2026.08.27.07.14.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/23] target/i386/tcg: treat VEX as disabling high-byte
 registers
Date: Thu, 27 Aug 2026 16:13:05 +0200
Message-ID: <20260827141314.1099352-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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

This does not have any functional effect because the only instruction
where it would make a difference is VPINSRB/VPINSRW, and they disable
high-byte registers even for the non-AVX encoding.  However, with
APX it becomes a general property of the EVEX prefix and it makes sense
to treat VEX the same way since it *does* include REX bits.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index bbd1c3b7893..d8de290acb6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -208,7 +208,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & PREFIX_REX) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
-- 
2.55.0


