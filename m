Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3553CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDk-0005OT-Ec; Tue, 14 Oct 2025 09:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDi-0005NM-Jc
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDe-00011N-Oo
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfpYXKeThudHsYbBI1p5Y6IAia2GV9M0i2k7RLhVCJc=;
 b=CyAb45UNTc5wZtDKw/K63dGBNgru4Zo641oAmBNXe9GE4XMOLI5yZ/0X+R078WRtvYz0/5
 HRvwIKeLvn4JhrqkB34J7wbrE1POvw4SM7OONrfB2tk4jWZ7fXsZfg1fgxIPdcB91/b/e9
 th35O1wN6DlfAxcvjYMKqQOBsJhhnHk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-puDYPegMMpCtKHc5abHQOQ-1; Tue, 14 Oct 2025 09:37:32 -0400
X-MC-Unique: puDYPegMMpCtKHc5abHQOQ-1
X-Mimecast-MFC-AGG-ID: puDYPegMMpCtKHc5abHQOQ_1760449052
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso4320099f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449050; x=1761053850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfpYXKeThudHsYbBI1p5Y6IAia2GV9M0i2k7RLhVCJc=;
 b=tPOEwaEYByA7NMm++T7KPTZvm56b+xgluJei96QWZYcSyNWsO2Y/nnUqxaJimy5vTW
 oqtp0uXo+SQfwxb6rEm+siUaPn0Vm2Ccu9H4m9DbGoJXyUqRPEUnpLEcAuOgyZE/5rsO
 FBEywyZN8v74euuG2ElEs7CtJbBJ6X9kzSBnW76T1/xxPYfE7Wc/ko3umDi/iuZHzTHA
 Y3y2dhXrc1ah6yLilof6F8oqHqr+iDprBAQOjt1OZIXZ8+kKbxNQFMZmB1yd9/28oRRG
 22zJNomSruqUNF8wEUu63jFTSsQuKVj8e85EJ2LzNLCN8CKoOStKmckkYmSylUPLMfas
 j3uw==
X-Gm-Message-State: AOJu0YxjrCtjEe4PhObc0b9MCpF0mD4UwLUVtZj9rC3lkoiciOtZOAyR
 4QHAk2EmI73mnuA/m0OpUbDkoNu5JhKn8k1WIJosk7m82/ARCHgC8PPKQgSEk2rTN165Hx9AWnc
 op8MimlWxWVumZFZ3epoVPXnQfyPnx8Mk2PgCmvo+9njUpE/nGvLk7EBCo4Xl5my9KWixEbbnVu
 /u2MOWn9HOikAAHYi1bzO+93HlNTMAwrPAkUJyTBWd
X-Gm-Gg: ASbGnctx0JN11ux84IsP6Fm1qRnmvvMXvBp0EkZELF0k3tPNoGgaa4vCsry/Ng+3Ojz
 sj6uYyohDQTj5Rr4FuNImsSKu3Mkr5UFOv0hRjMaW2Kxy0Bx4cpbdSrAVA8wA0dD2Xjo2mZHMqg
 cSWWFBC6Q9n5YhApqJTHVQK/Q6u+TMUJO75Usp32ikvxPjhQK99BvhYaUTwkK3BMVDlnVfueFCx
 X8dS0/i3Fb0J5L15A1ZtFUqeAIv3p3b9stnrReA8y2jQG2RTzrAlIx6TMUEFDfqty+KmJSrpofz
 CdoZSIKnkZl8aSz7lys5lrJmQscr1dH05r/bQFNwtUPmqf95DM/hnm5SOvgHaIiTpOGq26AteFS
 8In6XMT2entRP1aoSMKXy3uG4tcS/GclklXzaSjM310o=
X-Received: by 2002:a05:6000:420c:b0:411:f07a:67ff with SMTP id
 ffacd0b85a97d-4266e8de19dmr17312474f8f.42.1760449050481; 
 Tue, 14 Oct 2025 06:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJMXdr4xgukabgdGHaoZnSD9ZlHKVGuhhxfFDtFRQRpo18ts2ch8mbf+0uAit5k5IuiPzbiA==
X-Received: by 2002:a05:6000:420c:b0:411:f07a:67ff with SMTP id
 ffacd0b85a97d-4266e8de19dmr17312443f8f.42.1760449050048; 
 Tue, 14 Oct 2025 06:37:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm23585131f8f.42.2025.10.14.06.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>, qemu-stable@nongnu.org
Subject: [PULL 07/28] target/i386: Fix CR2 handling for non-canonical addresses
Date: Tue, 14 Oct 2025 15:36:52 +0200
Message-ID: <20251014133713.1103695-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mathias Krause <minipli@grsecurity.net>

Commit 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
accidentally modified CR2 for non-canonical address exceptions while these
should lead to a #GP / #SS instead -- without changing CR2.

Fix that.

A KUT test for this was submitted as [1].

[1] https://lore.kernel.org/kvm/20250612141637.131314-1-minipli@grsecurity.net/

Fixes: 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Link: https://lore.kernel.org/r/20250612142155.132175-1-minipli@grsecurity.net
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/system/excp_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 50040f6fcaf..f622b5d588e 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -592,7 +592,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                 if (sext != 0 && sext != -1) {
                     *err = (TranslateFault){
                         .exception_index = EXCP0D_GPF,
-                        .cr2 = addr,
+                        /* non-canonical #GP doesn't change CR2 */
+                        .cr2 = env->cr[2],
                     };
                     return false;
                 }
-- 
2.51.0


