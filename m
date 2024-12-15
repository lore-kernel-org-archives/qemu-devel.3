Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E745E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaM-0004ZE-JF; Sun, 15 Dec 2024 04:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaL-0004Yd-4x
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaJ-0006yq-GW
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyQ9wLbCKDjV+T8LPYPoAogaZ9aobQT720NgGO1dskY=;
 b=O/uXSGAHbif23rhze7e/ZQxQww8XsPuB4nsqbpSptcN0IKBrY17I5trTGpFX4Et1UkCdXY
 TfQwOENm6uLJj/JB/Zset72kECySws11l6P4O4Bp9s4dmVXVldrJGmqh8y6B36ZduANCyR
 fXLUEvCBYgkOmoM/fBBx0eSxnB4ebPw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-2KNboUw-PR--IDjg476Y2g-1; Sun, 15 Dec 2024 04:06:41 -0500
X-MC-Unique: 2KNboUw-PR--IDjg476Y2g-1
X-Mimecast-MFC-AGG-ID: 2KNboUw-PR--IDjg476Y2g
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436228ebc5eso345425e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253599; x=1734858399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyQ9wLbCKDjV+T8LPYPoAogaZ9aobQT720NgGO1dskY=;
 b=Z1DKw44bcrLbrX1FchkTc4jc7JsyYZthpXhOuNX+n3B9NaGNuwTSjJUGTgfsBSHTN4
 4AiivCqmwKePPD09Bc3O7v6yczzj5ZyRI0iD/oj7BG3Ql/bW/A+EcHkxHBR90B+taPuw
 LhYVSBp8LnX0tSUIQ9Mrq4R4CEO2dymDLchjeoCWhSkegzBSW3EU6LhQgoR6rqjKS5+r
 kKNiZW8PYd2uMeU6Y3v7xaNz5INxEP2cfF7xeYAwok1ljj4aLVNrOESeWlfDLXIg3yuA
 YJJwzcB0qq9cbVTZ6eFJlBbqCVMi54YJcn9KrakidOQvo+sWhais/hOxRZck0lS3pii8
 6EFg==
X-Gm-Message-State: AOJu0YyFXwry+feK/u1BEQxIRd3XQ9w+XkrXpURT/bnEVeckXEXsQU1N
 iod4vmxPvn1K8d2/MqW9t9bsoOWMekdwEUDwEDRqAr/wFgB4/bo/sKQQv3sGURpku8NIh20wLnj
 JkdrVYGExVN6Xegjcvdx84XQ9ktrEu3QMyT2w6ui/lwPm+9NDxYSECTyT9c7gxxDG2e6tu7sSa6
 EMoCQRTW1TbdEaatWPwAjpxttk8ayuIAhcSx3X
X-Gm-Gg: ASbGncvqUCBwp3M+4g+HCop/qkmnKP8l24WygozvB6iA4/o+X9eq9OXbhWp/jp8PLvM
 kc5tn8btTR4z6IxVXiXJ9zkWeXnZVSsPwwZpmii07L2UyNbkYRM+/G8puXBvVUKyMfcT1PoyLD0
 KMCJfi36ERpMlR8Z/FtcVCYIoAB7ImfLi5W0bfd2hII4b4/KIWhRRg7m5Hyz2eFLBmxNFcgjxZm
 RWSKsu+T3M+wLF5LNYtUlTHpUA3+fWpYrlLA05thGFSlEZGCn6hv7k4jBU=
X-Received: by 2002:a05:600c:1e87:b0:436:2923:d23a with SMTP id
 5b1f17b1804b1-4362aaaacdemr67798715e9.33.1734253599047; 
 Sun, 15 Dec 2024 01:06:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY6XxQ1kkFUAQYQchIxSuLl6sJEOV/OkesHZY8hxwQkH9d9IWdxbWI4eM49e+N9LO5rrofOA==
X-Received: by 2002:a05:600c:1e87:b0:436:2923:d23a with SMTP id
 5b1f17b1804b1-4362aaaacdemr67798335e9.33.1734253598557; 
 Sun, 15 Dec 2024 01:06:38 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255531b1sm106296625e9.2.2024.12.15.01.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 08/13] target/i386: make cc_op handling more explicit for
 repeated string instructions.
Date: Sun, 15 Dec 2024 10:06:07 +0100
Message-ID: <20241215090613.89588-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since the cost of gen_update_cc_op() must be paid anyway, it's easier
to place them manually and not rely on spilling that is buried under
multiple levels of function calls.

And since cc_op will have been spilled at the point of a fault, just
make the whole insn CC_OP_DYNAMIC.  Once repz_opt is reintroduced,
a fault could happen either before or after the first execution of
CMPS/SCAS, and CC_OP_DYNAMIC sidesteps the complicated matter of what
x86_restore_state_to_opc would do.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4ff0ccf71cb..4b53a47000e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1345,14 +1345,29 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
      */
     s->flags &= ~HF_RF_MASK;
 
+    /*
+     * For CMPS/SCAS, the CC_OP after a memory fault could come from either
+     * the previous instruction or the string instruction; but because we
+     * arrange to keep CC_OP up to date all the time, just mark the whole
+     * insn as CC_OP_DYNAMIC.
+     *
+     * It's not a problem to do this even for instructions that do not
+     * modify the flags, so do it unconditionally.
+     */
     gen_update_cc_op(s);
+    tcg_set_insn_start_param(s->base.insn_start, 1, CC_OP_DYNAMIC);
+
+    /* Any iteration at all?  */
     gen_op_jz_ecx(s, done);
 
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+    gen_update_cc_op(s);
+
+    /* Leave if REP condition fails.  */
     if (is_repz_nz) {
         int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
-        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
+        gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
     }
 
     /*
-- 
2.47.1


