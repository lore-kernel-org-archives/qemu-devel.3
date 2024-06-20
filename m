Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5B5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEVQ-0002Zd-5M; Thu, 20 Jun 2024 05:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVI-0002Nt-Gf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVG-0005V9-SE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edfgvS3ELSSOyELG7RxvO1gV2FBychxCHSiOtjvR6gU=;
 b=FxWm4nv+CsGBq8Ej2hm5A+S8GiA2kPifuvqKvW0MJ1lDlk77JJIkQO9vFaldV0M8cjrM39
 jFDCfJgOS9vljGuV1vWDgiQTBboF31qZ79vCNQCuuosMGo+CskT3GGQvd4sFWH82nw/mtt
 YeeDFqK1XDUcP616VhiWAtnV+pUb23U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-jvH3huPtMB22kTNjaaeIbw-1; Thu, 20 Jun 2024 05:54:46 -0400
X-MC-Unique: jvH3huPtMB22kTNjaaeIbw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d05177afaso1762302a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877284; x=1719482084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edfgvS3ELSSOyELG7RxvO1gV2FBychxCHSiOtjvR6gU=;
 b=LrIMp2OQjuSAhPld9q/JcNwzWnRDSsFUDm+6t9DtVPPPDTHWTq/P3sZsd8ZsCvY0jt
 Qu4TRAx3/rdoNwIyFnyx9zRng1WCqZlF/54mQI0mIb4Sd4ORb3VauvLQaBph6JhTvUOR
 +a1wQn251KfHQ+vxIY1C2zpGzBlDAnffJxKDlqlrprKYFAQ00lHEGMqeDLwMaBbLJAVX
 FchxmbqLd6IKizCsJr1Sz7u6AKL9KTSaX+ftSlApIsH76PJcyluq+hfRTQi1pqt1g9W4
 m0WHYr1lsAUiSIXaESutX/MHiInZ2iGJBQ6CiNi6yfEgyhOettwajXAyScNcRsqKJJhI
 hVVg==
X-Gm-Message-State: AOJu0YyqBJTA6ExYITTsKUG2XH9e/R98xmgiIXq2pRlIM+dAXKUWTDMV
 K82l6ryCoZ44O3LOZfNcUQSpKPB0xy0/8WjRjyBIZwpwL7LqlsmSWcmnsxibw7uuHDiYTMELMs6
 r1asw9TfbR3yguyCXhN3P6Fj8yxQd/JLMgbc9CLKndhvEvaLTFeARuITbcGN7axnPfmADEpNePq
 WGf0q+b1oNtNajzTFVWNFpBxFKpkEKAukFm+40
X-Received: by 2002:aa7:d943:0:b0:57d:1d9e:d1fe with SMTP id
 4fb4d7f45d1cf-57d1d9ed435mr1742409a12.9.1718877284106; 
 Thu, 20 Jun 2024 02:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5xX2HtQ30O1ak0ERNiiVoWS/wk9WiExgclELgLPcw5tkqMBZ5w461WrLaAax0ZDijlVDK5w==
X-Received: by 2002:aa7:d943:0:b0:57d:1d9e:d1fe with SMTP id
 4fb4d7f45d1cf-57d1d9ed435mr1742391a12.9.1718877283757; 
 Thu, 20 Jun 2024 02:54:43 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72ce08bsm9390731a12.1.2024.06.20.02.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 08/10] target/i386: list instructions still in translate.c
Date: Thu, 20 Jun 2024 11:54:17 +0200
Message-ID: <20240620095419.386958-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620095419.386958-1-pbonzini@redhat.com>
References: <20240620095419.386958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Group them so that it is easier to figure out which two-byte opcodes to
tackle together.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index fa51aadfcf2..f01a4f1f1fe 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -129,6 +129,37 @@
  *
  *    (^)  these are the two cases in which Intel and AMD disagree on the
  *         primary exception class
+ *
+ * Instructions still in translate.c
+ * ---------------------------------
+ * Generation of TCG opcodes for almost all instructions is in emit.c.inc;
+ * this file interprets the prefixes and opcode bytes down to individual
+ * instruction mnemonics.  There is only a handful of opcodes still using
+ * a switch statement to decode modrm bits 3-5 and prefixes after decoding
+ * is complete; these are relics of the older x86 decoder and their code
+ * generation is performed in translate.c.
+ *
+ * These unconverted opcodes also perform their own effective address
+ * generation using the gen_lea_modrm() function.
+ *
+ * There is nothing particularly complicated about them; simply, they don't
+ * need any nasty hacks in the decoder, and they shouldn't get in the way
+ * of the implementation of new x86 instructions, so they are left alone
+ * for the time being.
+ *
+ * x87:
+ * 0xD8 - 0xDF
+ *
+ * privileged/system:
+ * 0x0F 0x00               group 6 (SLDT, STR, LLDT, LTR, VERR, VERW)
+ * 0x0F 0x01               group 7 (SGDT, SIDT, LGDT, LIDT, SMSW, LMSW, INVLPG,
+ *                                  MONITOR, MWAIT, CLAC, STAC, XGETBV, XSETBV,
+ *                                  SWAPGS, RDTSCP)
+ * 0x0F 0xC7 (reg operand) group 9 (RDRAND, RDSEED, RDPID)
+ *
+ * MPX:
+ * 0x0F 0x1A               BNDLDX, BNDMOV, BNDCL, BNDCU
+ * 0x0F 0x1B               BNDSTX, BNDMOV, BNDMK, BNDCN
  */
 
 #define X86_OP_NONE { 0 },
-- 
2.45.2


