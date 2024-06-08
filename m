Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDB0C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrez-0006Hf-JZ; Sat, 08 Jun 2024 04:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrex-00064z-F5
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrev-0001an-NZ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsXxfg6KJYeTLs0rcYYWAUKjN6thGDY6LKdrDrsYTIE=;
 b=dJPjDTPMUtU2m3nNJk0BKWC0qZNiCf9xH6cEMorVrCOgjamLg0wM2Dx1p8ezQ+zO8heOGF
 YFaAMvxvviyX6/Azfr2hXDSiyFwsXWZGZ9SEdCtvvaIil/rsk8iEiTmqTbl5XDj8hx5XYk
 gbpo2oQU2m7GfryIA+bq+ruFI5WESJw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-y0htr_QWPbCxYaIjNf6FOQ-1; Sat, 08 Jun 2024 04:42:40 -0400
X-MC-Unique: y0htr_QWPbCxYaIjNf6FOQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6efac81377so29411366b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836156; x=1718440956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsXxfg6KJYeTLs0rcYYWAUKjN6thGDY6LKdrDrsYTIE=;
 b=Sb/GvHrckHhK7x3qt9uQH6h9wBsnQ8rPWw4aOI9Du3MtnRlqL0z0I6JpsQTDu1ZQh0
 yyodp0T/7SX9e3BMk5gjrnVIUn+KynX3jeRNC+dR+4ZASiHJx08OxStDziVo1/6FY884
 BzTbL9UE0HRjD0jk3k/8GW1fS+S19hwbIujemUlxtrm+Mp9dY+iHPkG8VI+txEdQPbUq
 BbEA5+sOxql+wlXDo/49Rb1rWQicRf0Suimzl6nvmbwLlpZL1FFNzDGK1rdRaIuYSmII
 UamagCaz7WdxmLkPi2+lkTEJq9RiYwwPkOPcGhXgvFR7nKdf/Iu5V09+XaRVmThQyB/f
 HmRA==
X-Gm-Message-State: AOJu0YwNbt3QZ14vZBbJtgmKL01hviLnFmM/PQIrvk1PFE4uPvJgcYL8
 p7CKsKYMlYvIdZe5GEf/0JnHBG+VlbCARu5xlyvnjDFe/Ykv0fSGp5F3cx8CxHvAX0MfeSCLuBa
 mUOlERR+vgZ++PqZC6zz90NkPIO01QlJdP1pgNzhlFJ95/6GtcLYjZp9L3p6gSm604pDU5MFt0L
 SMtgtre32nnQ0OnrGHmmuk9VUfyZYV8NAJjbsB
X-Received: by 2002:a50:999d:0:b0:57c:6ae2:abda with SMTP id
 4fb4d7f45d1cf-57c6ae2ac5emr959964a12.5.1717836156152; 
 Sat, 08 Jun 2024 01:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH6lacvikIHqBfLWvLSsEWT/BDDFmbD2D/kbm8esJfiKG5YkEFOu4raCmDMaiSkBq1Q+JSSQ==
X-Received: by 2002:a50:999d:0:b0:57c:6ae2:abda with SMTP id
 4fb4d7f45d1cf-57c6ae2ac5emr959951a12.5.1717836155811; 
 Sat, 08 Jun 2024 01:42:35 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0db916sm3950555a12.35.2024.06.08.01.42.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/25] target/i386: assert that cc_op* and pc_save are
 preserved
Date: Sat,  8 Jun 2024 10:41:11 +0200
Message-ID: <20240608084113.2770363-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Now all decoding has been done before any code generation.
There is no need anymore to save and restore cc_op* and
pc_save but, for the time being, assert that this is indeed
the case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1bca4043a5c..67f2e792166 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3834,15 +3834,9 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     case 2:
         /* Restore state that may affect the next instruction. */
         dc->pc = dc->base.pc_next;
-        /*
-         * TODO: These save/restore can be removed after the table-based
-         * decoder is complete; we will be decoding the insn completely
-         * before any code generation that might affect these variables.
-         */
-        dc->cc_op_dirty = orig_cc_op_dirty;
-        dc->cc_op = orig_cc_op;
-        dc->pc_save = orig_pc_save;
-        /* END TODO */
+        assert(dc->cc_op_dirty == orig_cc_op_dirty);
+        assert(dc->cc_op == orig_cc_op);
+        assert(dc->pc_save == orig_pc_save);
         dc->base.num_insns--;
         tcg_remove_ops_after(dc->prev_insn_end);
         dc->base.insn_start = dc->prev_insn_start;
-- 
2.45.1


