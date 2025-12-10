Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EAFD3C54B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4B-0004nX-VX; Wed, 10 Dec 2025 08:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK41-0004ls-Vh
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK3z-0002xz-Kh
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOEA4Cf29Q+xGQvjsNLZGJMDbKafwDbOsr1rji9RRPQ=;
 b=h8P/c4tpesXPhLHq3COUK5t5mE6pncptdcgj2jkgSR7ubx8vBOtsrRVppc3g3EtQIrvmtq
 0LNBtRnPCPLtstuHO3YmtVAadxDlCr93Ag+bYEwJDpT98Oi4fTQQvziNZ36afWJeCR2sX4
 4HbeiEh9jN7sJ2iAtNjysPdaP1Pr3vw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-LMiMYf7rOdiyTCdKJbOSow-1; Wed, 10 Dec 2025 08:17:01 -0500
X-MC-Unique: LMiMYf7rOdiyTCdKJbOSow-1
X-Mimecast-MFC-AGG-ID: LMiMYf7rOdiyTCdKJbOSow_1765372620
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42e2e3c3e1aso3355392f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372619; x=1765977419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOEA4Cf29Q+xGQvjsNLZGJMDbKafwDbOsr1rji9RRPQ=;
 b=kZfKZW6aFryOsHABxHB9VOKa+lNEqk4Ljb1AWNFySyqkH28aUQsAkaJ4gQQRA2RbnC
 MG7+AleakSlkkfh+qHS1ESTwR6F+6wFNUNrOFBKA8ebhQO2xoTWGeGLfehgo+OSoLQ2N
 4KvHSj1UP0DGoB+ASTYiI17N4hHfEUGObk/yuH57jM7wzLE7vmdSwoQoWnDieJSg7EmD
 +boQDX/M9+gs6ke3qfk1ljlq8uuH4p2uSMgXG5s2mRgDbJAyvc3o02YhfvFGe+z+iiV1
 cGW2WBtmy2G6i9RGEwEntU9wrLZSMWPVoQrP5OZunj2LBnzjuUaemRNbQuu2N9U+m9HA
 HWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372619; x=1765977419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOEA4Cf29Q+xGQvjsNLZGJMDbKafwDbOsr1rji9RRPQ=;
 b=kFn8GbIYOxm3Chpdn+HTkF8hkBfYT2hiVPb93LyclIwl70E8/H/PkKYiu8wiuD+VET
 jNlqANR8Vt8jCM+btr7ZYqULJl3hAY5G2iEWtFeylQ+dW3f5K0i02+tw+MKIvt+/SCzz
 kwr9XFcW+CQyOzzgxQ2UYHzOTZJEYdA70YTsTzEUrdoOQMG8F/vCyKQXrNw/0+i0wu0c
 VQG1THYHJ3A6rP8trWh39vpAYpDAnS+0H3FV8MfCRKX5xUBx7kFWYlzuZqvB/U8Vdfyq
 EjQ2CfmU+VETK76rhdpfndniFL488duCypsxnxbysnsywrgyLkfK+m91L/OynE57+jn9
 LgEg==
X-Gm-Message-State: AOJu0YwA08/KVsH6OeJyhiU+N8R0SldfSfeOZCLwqvmkfo6zJA9YH3zL
 YmzG0ILZTzAAnjb2jdnBDJSpAIGit62D5j0w0lMGMJCF7xTkmYFaQP9qZ9dsxQMyKLEf/YjkP5s
 NKxpGEoxDTDmIX6oCC6MkLmz4cFlW1gd3xrrC6EoqcNfryJHl92mRqqcuQT/NboBV2BZm7dhej7
 xgJoh6UonyHq8VZHWL0TRRVV5GfrzfrEIFsytl4ABD
X-Gm-Gg: AY/fxX7QuyfdtrqUo3lPZUA25eI6zcL4SEw9/P2sKCBB5ju1e+C2OKadtPY00FBKe/p
 LCg+TxYFF67of2m+iu5wQGt+k+qV+L7RPF4eLIGNgYVoPLPwseQVB15ZsEa7YMNS7SCnaxDDtbS
 klCXJEd8YZSOdFwx9Zmeuqp2kYiAY/SPrWof0ABAQdo3X+iZJXLhx/Bb/4BNuejloJtpY8tVyza
 P0Xd8qXBOgHQ94lUiZuqHdIO9alVMT3ALvCRztUbBupLcaBNl2VuOk1jkBiHdExqFvZLv90ZVbm
 qfFjxSoUcpnhHR+uQvJutJlTHufPE1BqRJT6oeVZk6N/hlX0axgqoRtl61qV//Le1RXVbjqtpzl
 +y1ZhCerHm7JSkIe7o1vFG9yuASzI/XLDX8wyezzVu/kG0zSVnuAPrS5mT+ru+VkTTDb0NcJTc6
 059s3dB9IfrumI0pM=
X-Received: by 2002:a05:6000:4023:b0:42c:b8fd:21bb with SMTP id
 ffacd0b85a97d-42fa3af8bebmr2607707f8f.39.1765372619463; 
 Wed, 10 Dec 2025 05:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNW+qqJUUS7i4wTIMn/+LMzIOafvXr0U4T7pmvj4NuoJG3Z6UXTqm4jsrvH/OTFQzGEWZ0RQ==
X-Received: by 2002:a05:6000:4023:b0:42c:b8fd:21bb with SMTP id
 ffacd0b85a97d-42fa3af8bebmr2607678f8f.39.1765372619040; 
 Wed, 10 Dec 2025 05:16:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm36370678f8f.3.2025.12.10.05.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:16:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 02/18] target/i386/tcg: ignore V3 in 32-bit mode
Date: Wed, 10 Dec 2025 14:16:37 +0100
Message-ID: <20251210131653.852163-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From the manual: "In 64-bit mode all 4 bits may be used. [...]
In 32-bit and 16-bit modes bit 6 must be 1 (if bit 6 is not 1, the
2-byte VEX version will generate LDS instruction and the 3-byte VEX
version will ignore this bit)."

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0b85b0f6513..c9b4d5ffa32 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2665,7 +2665,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                     goto unknown_op;
                 }
             }
-            s->vex_v = (~vex3 >> 3) & 0xf;
+            s->vex_v = (~vex3 >> 3) & (CODE64(s) ? 15 : 7);
             s->vex_l = (vex3 >> 2) & 1;
             s->prefix |= pp_prefix[vex3 & 3] | PREFIX_VEX;
         }
-- 
2.52.0


