Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24780C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yP-0003z8-Op; Thu, 20 Aug 2026 12:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yL-0003uY-Iz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yJ-0005QP-Dr
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+3VB50P9IeYwtauM/g5NERrE6CRpOAQgHkmrcSXNw8=;
 b=jM0HNcmCPrGrmTR0mx6H6UjPt6d1PCscNNKb2f3Nxol6gQ973kubr2BsbdlAudCslVEeZ2
 YQt5SsKRefcfCbri/jsXCUsXT/TlwJ/30+6B7a0y/4M2EOdD8TR09ItOXLEgvT/iRBc2yz
 sYL2RG7BOL/7uwFKbAj1c01V5NLsCqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-06j2AidNP5ur2B_JRIC1Fw-1; Thu, 20 Aug 2026 12:50:25 -0400
X-MC-Unique: 06j2AidNP5ur2B_JRIC1Fw-1
X-Mimecast-MFC-AGG-ID: 06j2AidNP5ur2B_JRIC1Fw_1787244624
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso171185e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244623; x=1787849423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/+3VB50P9IeYwtauM/g5NERrE6CRpOAQgHkmrcSXNw8=;
 b=cvBIx06BwvJPrYzhV8psylRK4BzPHDFgp/IOEhEEZlAVZVDkucvLAgmezGMKo1stS3
 fDmBWCsRuBGFrfYVL60sBaFsdoCixfSMD8pQmoWKEafxBJMYJodBStpqQKovZF5dD34B
 pssrErlm3rpMZOWcjNrW7AOoI8x19Zu6tlQTfXc5DXxsNhBspBJKlLe3c1v8vqJH+Q03
 9H1Taboar5G9T2EMqODh+5cYcE11XizTNLB5ta0DMtkU5Kkv2axlM47h3+Y3pn9f901a
 7IA8Y40pu14J6It38/S1NvNUsjFc2hi7/DxDSnXMmXzNmOOUj7BJCqPXzxVkl+VbOzpc
 0PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244623; x=1787849423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/+3VB50P9IeYwtauM/g5NERrE6CRpOAQgHkmrcSXNw8=;
 b=VfnODmBxHfQ27Ds3oil8Ck4v/hNuxBTh7CwYF8uSoDtTlUDOgnYaAa8tjhFsheZ7vb
 MjCDqjsFhutkESlQWc8K0uOQPK4KDxw1vw+7r4ehbG8CtwLOF1tStvDjWCRTBO/Yov+i
 xcDOzNpGAHNquTp1xsaWIyV66YiXReYJk3WZbkJ6LHDwzkgTWFZqPFRKJHB+yGkYUpdf
 +T7z1GwcpGwbxB0RkEDriKetd+22Z9Fv2wZLLk3zJpNk2yuaLLPoMlY0YzvwVdDHUpCn
 7T8to2CX/+6fs2AtqkLrOTGqKIA1/j8kQjyHm9Inkn+Kdp7at2owMT8ebNDEwuI/iJ1p
 0/Cg==
X-Gm-Message-State: AOJu0YxkPJJwJtc1oHniawbmCrm3kDulJPviQomuSEXR7yKGYJzwMVEP
 CIHOQ2cpAg7Bm45Y8rvghoLqkq7wmrQYWrvwSWShgM0VVN+sNMCFGhSZ0EXj246XordlBrOCQga
 eysvGsIkYa90ifCjNIMlmhHDVqQIUUlHOi2HMqpLI/z+RU94ewD+M4iyvaXQYoGPDEIQNmJ1jJJ
 zsK/B/9zpHqTBCF1wDBPRdAVr5F8zptktluBEWTISH
X-Gm-Gg: AR+sD10/2t3gIt3dXO7H7ci2UlFU6BW7a8WNqOV02xS1Y49bzJw8JSxzOtCozEvAw2X
 NyCfpPa6nbiA5+5+eSmK8ZM9xfN0XM1Zh7jZeLl4+uPv9EJvDUg0kO0ooihXMXVwyf03Eh4NZhu
 5e0tkxXxKtoH3cvgm/TcVTLHSSNX23WZQpnygHv2TYxvqSyBYoq4AjJcVXE7ygjmCydDvgmdK+A
 JlDxcCt7qm/XhCXyjdo7BN7LYmtoVAQE8e8GEBqVT0OBl3kYSBB70P/tlFmklDxnB5wseeXe04n
 Qxic9hThPpeANjl7TIT8qwp0xg2O+X6kKlWWq0/PF0otwl2R8lBg+7AwLdxjPZ8Hj4w6xisjBF0
 wBIWAxfa5Tnva7sxDINb/MrPzLcGtdiI1eP8MLClZHFGWxWOCl9gFmEKSyiGKIEXBJLESDjQisn
 Wi9a4=
X-Received: by 2002:a05:600c:8b25:b0:499:8807:345f with SMTP id
 5b1f17b1804b1-499b84617bdmr3969685e9.13.1787244623569; 
 Thu, 20 Aug 2026 09:50:23 -0700 (PDT)
X-Received: by 2002:a05:600c:8b25:b0:499:8807:345f with SMTP id
 5b1f17b1804b1-499b84617bdmr3968425e9.13.1787244623079; 
 Thu, 20 Aug 2026 09:50:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b29e19f2sm49098615e9.4.2026.08.20.09.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/53] target/i386: decode opcode extensions group 3 /1 as TEST
Date: Thu, 20 Aug 2026 18:49:10 +0200
Message-ID: <20260820164957.1895963-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

From: Andrey Polivoda <apolivodaa433@gmail.com>

According to Table A-6 in Volume 3 of AMD64 Architecture Programmer's Manual,
opcodes F6 and F7 (opcode extensions group 3) with ModRM's reg field values
of 0 and 1 can be used to encode a TEST instruction.

Although Intel 64 and IA-32 Architectures Software Developer's Manual leaves
the cell 1 of opcode extensions group 3 blank in the opcode table
(Table A-6, Volume 2D), the instruction in a group 3 with reg field of ModRM
byte set to 1 actually behaves like TEST instruction on Intel CPUs.

Currently, QEMU decodes group 3 instruction as TEST only if reg field of ModRM
byte is 0. When the reg field is 1, QEMU raises a #UD exception.
This behavior does not match real Intel and AMD hardware.

This patch fixes this issue by duplicating the existing [0x00] and [0x08]
X86_OP_ENTRYrr(AND, ...) entries into slots [0x01] and [0x09] in the
opcodes_grp3 table.

Fixes: d7c41a60d0c5 ("target/i386: move C0-FF opcodes to new decoder (except for x87)")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3580
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260621032524.1138213-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index faf74b00bbd..9c429e113de 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1624,6 +1624,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
         [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
+        [0x01] = X86_OP_ENTRYrr(AND, E,b, I,b),
         [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
         [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
         [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
@@ -1633,6 +1634,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
         /* 0xf7 */
         [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
+        [0x09] = X86_OP_ENTRYrr(AND, E,v, I,z),
         [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
         [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
         [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
-- 
2.55.0


