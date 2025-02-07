Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708B4C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLbJ-0005wt-11; Fri, 07 Feb 2025 05:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLbB-0005uc-NO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLbA-0008WU-9C
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79wQisxmrG4uGvWqFVzBGJF7Meflxb2NnqvI+vXjWx4=;
 b=SnJFikfy9qhmfQiiT/OE9TaPiuPqOR260hb89SNaLb6oGe0eLoUfv/RPCMb5/A4usUx9Kc
 ewUtYwND0TIXamxson1eKAbJNH3IfFa2fVr4ostryaYJVp+QEHGcE41ziF8ayxXygShUPn
 Nly8VnAKe1JDzNnEiLkRQnpnMkeaGWM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-4954BYXrOMuuZcrIUGnEpA-1; Fri, 07 Feb 2025 05:28:34 -0500
X-MC-Unique: 4954BYXrOMuuZcrIUGnEpA-1
X-Mimecast-MFC-AGG-ID: 4954BYXrOMuuZcrIUGnEpA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab789e71f9bso53509066b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924111; x=1739528911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79wQisxmrG4uGvWqFVzBGJF7Meflxb2NnqvI+vXjWx4=;
 b=KGe5Ufmx5TpFugZNMPNov4cpXIrCkx5moTwO3DKyLsVDhJMNHu3EwGs0r/y+pr7Y6o
 TW4I9XDyy+nA7Jokw+rWLEoBr1DhHQTPiBl/DTHP9J1N0NgZy0pB9nRYDWo4WmBRK9u4
 XUmZQGJPmvE2rHLyaRgowP3Lh1QyB6UTt2NTYc5lpEe09QYLuI1o8TDJTjynUPm/jHm3
 UKgTSd7S09A48wRBa000ideXHXBoYbMU0qPGRYyXdWoTBnqYU60MhT84+RAJKvjQ4QEg
 /33ZpJI4yvz5fvryT9GMdIXDn5q4beHb/tZQlEkDQd2zVNK/Db+qlYvwRHGPw/VoADWJ
 b5+A==
X-Gm-Message-State: AOJu0YxYLQcoSwlE8q99cA30jWSSYqCy1wuN219u1k4oosu63UpVEP0y
 eBMh1y3THfSAnmlOTXWsbASMoBVQhLI0K7/lXxWw8Lx1xK3t+8vWhi62qtrVUjGkZFZCZfp7co8
 CfNP3G7FXslwovoNFeR52QKThqgSuabCLebAZadljVzWwp2UGT0W6WuwhNRWsH/MWuLrBXbsVxg
 FwjOd/vG8PEqWHSC2mQEzlt8S9zg5oufLOmk9MMxs=
X-Gm-Gg: ASbGnctRWIjRTXDX3fxJuXVqJmEGHBiyKCwpG1hO8ORg2SnSJvscTb1WiQGtyDokN8z
 PSJ74gVJCyiZGgn2EqPLgT4mx0RD6p7fz2gYIE1WKzu/bMJe0XIs0oBwhw+Ee9V9ek+naBlrgNj
 7aLsBqxDK1fKsChg3UArNei2ai8RxRj3IqIrPrloQxTNtuSgFfERyny2IzmOOVk5R+begDmKo/B
 3omJCLX5q5cvojpWVBWpN+VcSwZKHHZMcpvSt3UTBVw18eQE4nxcP7u14wKpUP0miEEjBeK51am
 Om3ihw==
X-Received: by 2002:a17:907:803:b0:ab6:fe30:f48b with SMTP id
 a640c23a62f3a-ab789c30c0bmr278040666b.52.1738924111433; 
 Fri, 07 Feb 2025 02:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGyDaLA66EyI/0O036QTw3l6s6OFhJypZYluvdED98KkntEyhoXeLZ0lyeCtp3tgitQMjfGA==
X-Received: by 2002:a17:907:803:b0:ab6:fe30:f48b with SMTP id
 a640c23a62f3a-ab789c30c0bmr278037666b.52.1738924110953; 
 Fri, 07 Feb 2025 02:28:30 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de44e4bc17sm1170755a12.70.2025.02.07.02.28.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:28:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] tcg/optimize: optimize TSTNE using smask and zmask
Date: Fri,  7 Feb 2025 11:28:01 +0100
Message-ID: <20250207102802.2445596-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207102802.2445596-1-pbonzini@redhat.com>
References: <20250207102802.2445596-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Generalize the existing optimization of "TSTNE x,sign" and "TSTNE x,-1".
This can be useful for example in the i386 frontend, which will generate
tests of zero-extended registers against 0xffffffff.

Ironically, on x86 hosts this is a very slight pessimization in the very
case it's meant to optimize because

 brcond_i64 cc_dst,$0xffffffff,tsteq,$L1

(test %ebx, %ebx) is 1 byte smaller than

 brcond_i64 cc_dst,$0x0,eq,$L1

(test %rbx, %rbx).  However, in general it is an improvement, especially
if it avoids placing a large immediate in the constant pool.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/optimize.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8c6303e3afa..bca11cc427b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -766,6 +766,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
     TCGCond cond;
+    TempOptInfo *i1;
     bool swap;
     int r;
 
@@ -783,19 +784,21 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
         return -1;
     }
 
+    i1 = arg_info(*p1);
+
     /*
      * TSTNE x,x -> NE x,0
-     * TSTNE x,-1 -> NE x,0
+     * TSTNE x,i -> NE x,0 if i includes all nonzero bits of x
      */
-    if (args_are_copies(*p1, *p2) || arg_is_const_val(*p2, -1)) {
+    if (args_are_copies(*p1, *p2) ||
+        (arg_is_const(*p2) && (i1->z_mask & ~arg_info(*p2)->val) == 0)) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_eqne_cond(cond);
         return -1;
     }
 
-    /* TSTNE x,sign -> LT x,0 */
-    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
-                               ? INT32_MIN : INT64_MIN))) {
+    /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
+    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_ltge_cond(cond);
         return -1;
-- 
2.48.1


