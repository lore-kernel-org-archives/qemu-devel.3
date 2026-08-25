Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D5AC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHj-0004hq-4Y; Tue, 25 Aug 2026 08:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHd-0004gr-KI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHb-0000Jk-Sn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzPmt7KVQkTpe1/d3/LXdqLWTe5gTJkqbQqLF5f/EEg=;
 b=XhWl03Uk+CUfaWuhtrrfTvEsGWk9zYQ//1JER+zLxjtG7Q5C2h3CbyWR5nVjnC5yR3ui+B
 lgIkbyW+kVkxoz5pZJDqxi+ceR1WYs6h/6shJPHkXE+6pRGTv9tZJuvhh/eG5NTEFOktFb
 uQ7KW/73SiS3PurZjwt1SssjW7I4NtI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-mMPR4ICqMJSDBUakETW6Tw-1; Tue, 25 Aug 2026 08:29:38 -0400
X-MC-Unique: mMPR4ICqMJSDBUakETW6Tw-1
X-Mimecast-MFC-AGG-ID: mMPR4ICqMJSDBUakETW6Tw_1787660977
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47162f83c75so336417f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660977; x=1788265777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BzPmt7KVQkTpe1/d3/LXdqLWTe5gTJkqbQqLF5f/EEg=;
 b=uHWXnwGZKkG1LKH5O1o8YrlVPLdtqBd7TPx/mnoiMjlaIcWEUDShs1ZEQ0lgkQA9wK
 gA0MQlPlTK6jZhKGjlEAdTyvbuhMKIPyo1yWFNV9PNnmeJKMus36mC6LN1Q9jJ/XxiOF
 zRm7Xg7KmB3Fqj5nzLFxEAAUvNfF0WcMKyK+Rv+NIKy6MdQchpRGGd0sUg4vkMCHefP+
 gLymhaOjmRINMzMa0/kWZu+hfYxfDdfAnXj5glbkTHWciK/8iGmjHZj91RaanHBZKXMK
 oDro9jjW1CFVKBaz4SehvSlpC88qJYf7dq99WJypByMMzLLHUiC6RhI0bK60AW2q1+VW
 LAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660977; x=1788265777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BzPmt7KVQkTpe1/d3/LXdqLWTe5gTJkqbQqLF5f/EEg=;
 b=JCInmNuUVNj48FmJBHKvkR+I4MsI69FVmDc9T6r+YVyuKEcFRSMuHUkmXgtzXx9T8C
 1N2doKreW3ifq29TSxy8mP6LfmTFxLR2OIhe/Sa2aNxz4PCjgNN0LWvxSAFQW+guEjdZ
 PtASMzdfyE9phEM57JZbdm5vBFDU9ZmF8ViMoD29GAGKde4YM3P1fE4qNOjvsBesgjti
 RuvsiiHrzdBxiCVveuTaVLb0aSL0wgWpsUSF+O5SImYnplygxfBdDF0SAOdIChobscfc
 /Vs2eb295Qk1q73CKuGbyd/JyhJ9l3SwTvgr9TNgzNn3dbiZmPE9FPC7ZUYHKxPDfwkD
 cjTw==
X-Gm-Message-State: AFuF++mu2DZ5C5yxjH2TF/HtdAOmnZMSwXu8uDuuehOqrhk966GiiPjH
 CAK7w8OMkb9eHsf6YSGsfYyijVy6HJ4vGJT6+M8c0ZTMvLarOxVsQqkXat5QEtBCALfrUqE+qk4
 rbRttB5A8T7UWl6Y80L4tT/DNFo+rvGOUzA7Ta34d8VzVBBO054pLGlKVx03diHeq1HIHIZH7TJ
 wX70c2AMufDZYdu7aJUaKu66MKKpCWapKi1pbLF14L
X-Gm-Gg: AR+sD13HhY/gRThX+xLqp0ZrlBdceP3vVmHAkenwbQ2ClMfa3iL98o+fiF6VC/0XhVQ
 s3gDu8IOxk7s0LZTCxBotJbpMQlOOLzrNcRPqe9pcpTsjGaWucdvxTub0BiCimTJUx3BHTeIqjl
 XTXKHbAY0cU+vgRasj5bIBTpfrbofTV+FRwRP4/2DPqWYFHCYDjZ1aALcTDGjJ0TA6DSodO5itb
 3YhUr+AuEey8kGPKmD56ryfpmtkxT01LKFVMoN1mN42kKGdvmFycgWJTSmHXtCsH2mEzUf/NE8R
 iWjTczBnJyPl4iUZGtbD07XD6GtP9nqv6Mx/DQ9vPpa6GCXK3MQ0b4yrnwEJpiumpsubqY0GPJM
 /XFizsiZzdrh3VSzb7Xj3vi8blZynAhG4uANB8vBHSYUS810hwqQTwmgTNCwIUVrQHQw2+tag5t
 B9JTk=
X-Received: by 2002:a05:600c:3492:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499d6338030mr68738235e9.7.1787660976744; 
 Tue, 25 Aug 2026 05:29:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3492:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499d6338030mr68737695e9.7.1787660976246; 
 Tue, 25 Aug 2026 05:29:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d633cac2sm29459815e9.2.2026.08.25.05.29.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/20] target/i386/tcg: treat VEX as disabling high-byte
 registers
Date: Tue, 25 Aug 2026 14:29:07 +0200
Message-ID: <20260825122921.431739-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
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


