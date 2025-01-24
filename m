Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB39BC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFG-0006IA-2E; Fri, 24 Jan 2025 04:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFE-0006G5-9j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFC-0003dq-M6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+omDzyHoZTIzAUYMRxi5mDLkt7qKuTv7D0ZlYB6tvI=;
 b=YJazdJ1Qhr4WSAJt9HIcQ9WMWMQLawEHjCq4bGJR6DrpsGteDtmi/5ck7HpoRVnalTWD7n
 gWtyplwlIK+lWx2km62ATLvgQwPErDI7NmkyknZ0ifx2cbX+x6BbcuoFgyGGSuZVZXfTHF
 h9xWxI0/6mk605ClLRejds0RFtwjCOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-7hifE_YkO8-P40tqEEvKSw-1; Fri, 24 Jan 2025 04:44:49 -0500
X-MC-Unique: 7hifE_YkO8-P40tqEEvKSw-1
X-Mimecast-MFC-AGG-ID: 7hifE_YkO8-P40tqEEvKSw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38bf4913669so1009534f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711888; x=1738316688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+omDzyHoZTIzAUYMRxi5mDLkt7qKuTv7D0ZlYB6tvI=;
 b=ltzQ2C8WZFFym/nFgY2cDlvN6LHH1Xywx03UViXOaL/cjyT17485BaYxbQ22kaa0tO
 80AVnzvNBtTDOhaO1g7Cz1XzgB1HyXyuXgdYUaS/5w3zZ3VMyGwz5oeXqzUmsO/vok25
 Gofh51TwdSHcxEZWpaDRM33EzQ+6+kOQTcT8ygdcDWNAOQCqqG2sb+XQLseQbsJ0q35D
 5x5APF51yRMx5wV+l/zYbueNapzTeKpste2DUhhN6GStqyj2upPTI1tHJLajPN1c+MGs
 hPJuwLyejBHNG8X2yG+5Q5s6OBkmkniQfkcI/n04sok9FylpayhpZ5sIY0TuF0ozc87R
 4WMQ==
X-Gm-Message-State: AOJu0YwRNMDwm8T2AOekjIwb9GE39N6o6cp9x+6EmW2/D/sSABKKArYj
 k55evekpIvkCfs9f3pbHAcouvEahTwUph4kpL2ZSl9e+prmc6A8KGh3aK/OwDaNcha6fybj2Wqc
 eGXUR80I/a1bJjjcQWCOknXc++ffjqx5gvNUMzB82d6arakungDE+GVNmAkdGeBOsbqr6mVyAdy
 HZyrVZjuQQxfVkj4qDO7NeAvH0eoyF4USnPGI1fL8=
X-Gm-Gg: ASbGncvxtxPdw0D+fmM57kxQUrP0QjXivW4s32CrJ4LB/R4OO0g8NAdZeKTEbtFtvMs
 exJiUl8UzyPzDCKcPSmieqUzDSuTK3ua+9PQFlUJdxZbqVz8iQJuTDU8cZXnt/3lfRdj+JgfiM3
 ddo6NvMmldpYks0CU+/afUI4wASF3fBwfnNUJOQnkuegGjPBjDIcIPySppi43jEee9ELESv4OhX
 rd+ga5+Udljcoys77f0ac/5rvzszVDRssr6ErQOe+Tqhe02e7RJqXpnR9UNsw1/0p4STWOdtg==
X-Received: by 2002:a5d:6650:0:b0:38b:ed0d:c1b0 with SMTP id
 ffacd0b85a97d-38bf57b41cemr24412400f8f.40.1737711887909; 
 Fri, 24 Jan 2025 01:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRCY9OUKh8mTE8mS0BrKff1DNNelZch4BhAopUG1VNs5NS/ZuH7ObRdryjqz6groFJVsRxPw==
X-Received: by 2002:a5d:6650:0:b0:38b:ed0d:c1b0 with SMTP id
 ffacd0b85a97d-38bf57b41cemr24412383f8f.40.1737711887448; 
 Fri, 24 Jan 2025 01:44:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6e2sm2159361f8f.23.2025.01.24.01.44.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/48] target/i386: inline gen_jcc into sole caller
Date: Fri, 24 Jan 2025 10:43:56 +0100
Message-ID: <20250124094442.13207-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

The code of gen_Jcc is very similar to gen_LOOP* and gen_JCXZ, but this
is hidden by gen_jcc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-2-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 --------
 target/i386/tcg/emit.c.inc  | 5 ++++-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index dbc9d637c4b..3b68441a561 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1847,14 +1847,6 @@ static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
     gen_jmp_rel(s, s->dflag, diff, 0);
 }
 
-static void gen_jcc(DisasContext *s, int b, int diff)
-{
-    TCGLabel *l1 = gen_new_label();
-
-    gen_jcc1(s, b, l1);
-    gen_conditional_jump_labels(s, diff, NULL, l1);
-}
-
 static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c4cc5f48d83..a193d32ca76 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2297,8 +2297,11 @@ static void gen_IRET(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_Jcc(DisasContext *s, X86DecodedInsn *decode)
 {
+    TCGLabel *taken = gen_new_label();
+
     gen_bnd_jmp(s);
-    gen_jcc(s, decode->b & 0xf, decode->immediate);
+    gen_jcc1(s, decode->b & 0xf, taken);
+    gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
 }
 
 static void gen_JCXZ(DisasContext *s, X86DecodedInsn *decode)
-- 
2.48.1


