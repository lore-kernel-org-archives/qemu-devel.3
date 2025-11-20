Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F29CF6497
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMH-00038f-QX; Wed, 19 Nov 2025 19:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMF-00037p-9d
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMD-0007Px-Gv
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TndT4OS9g9ZV9Pv6S9WKvqcKhsN3Lm5nxn+5ird3ts=;
 b=LYzrl3cUs9bqdmk++EfvJxD3UoVpHpzYKCQKjZOGzRYFf/7Y3ybVMUkUByA661nSMCUA0G
 bdfg3tOzzyj+nen05y1DGOs/ib9ti/x7pxTI7KVYzUnhIvJL5Jb4/TrFbloMuZ3QQvCK6q
 HgYr5pYBPa47Ugi16lYAE5E1m97GFJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-x15IepWOO4q7gPRZjBZQgg-1; Wed, 19 Nov 2025 19:17:03 -0500
X-MC-Unique: x15IepWOO4q7gPRZjBZQgg-1
X-Mimecast-MFC-AGG-ID: x15IepWOO4q7gPRZjBZQgg_1763597822
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b2ffbba05so128053f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597821; x=1764202621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TndT4OS9g9ZV9Pv6S9WKvqcKhsN3Lm5nxn+5ird3ts=;
 b=r3+XLwvdxhXgQJ3OyShxTW4qekVdDj+9w5v/YKNUChz5FZskoWpl66QvYA51Tw+lmt
 RKQsHbjwcYJ+uNx/Fa19wLW0jSSNCqFwm2dNRKXwG9a0uJTPDbax3830vDHzGX+r7tll
 OBI/HtA5Z58wQRmrqTlU2zbK3/XVbmZH4yo64QhdPm4tp9pX8IVQHPI8RIGwYQMR3T+Z
 j10nR74oIrVZUkH874fFImAj7pCOOqiPGxjSOWmLI4/PHpdh6N2/EVY3+nfmJnHyXiFl
 iN3P1y/DJja5AMz7RW5W/qumOoJ7JIh99EyE3J4OUsYbu4SVgRxx21zmpfZRE184A+1q
 B0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597821; x=1764202621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2TndT4OS9g9ZV9Pv6S9WKvqcKhsN3Lm5nxn+5ird3ts=;
 b=QRBl/Os9v9DevrncIhtZvzcr2dPMr3cAR0qBEMK19TEiHRw/cy+WlG3s8PGH+nBjFN
 4ELvfjPc7QA4pW1kOh4aTzKqmVl9WDAJk4OcF7JNk31aIZCUHdTpohkv35d35BUevmc4
 VhVVBSSoGDQHWT65KmNVW+WxLVNJ69O5ehQirAmk8GNSkiOgFKuiuKq9QoYoUHSO6spE
 Om6YMFL50M8tkUyiGJX8cbJvKphLiMG9w0YyN0wHaxmE0Fv7qYavbKbmopzkoPbJzHXK
 UV6q0f1m5SmK+PliyLTEJ95CpNre+KYDz8i4g3+AWfezplhQiVkwJp3KQe5irL7z13l0
 mv6A==
X-Gm-Message-State: AOJu0YxpkS/wrDr979gy9DK1UuDV6OqLR+cuqtDMdwJKiorDrGXua29W
 3IiYwc4w4w7IOFOZNwxBAtpLaUK8nWWyVnWoQPIYy3zh5lk75btC2F4yk9VUKFLMvUjPR2DFVsh
 QmypvZgr9RQhve/8yr661474ZxklaXyzZJlZQVEMdZm74wOpKRFdfvWxkhAQKNrsj/oZnD7sGa6
 3JYXSWb1No/84n1apfYFUtkPbWa7UpEAz078V+DKgT
X-Gm-Gg: ASbGncs3ALuYANHM8x6K42uUg1ZJmsMnrGt+Rc/liyMQ4QAtaqVyRTLdXWXdb3aWDn7
 vJp8fdDxTmE8CvdgyUwaIqw+sszheUGQGwC63WlyU3NnSQtSTi+7exancBRqLRuo9lRXmenFE+Z
 UxBpLsTDqq8n0DiLXj8Z7iVh2fUYoRdX/DDrdpoUYufC4fgMW4WCJWuUjSph1GREDbyown3Q3F7
 r0wi30j89gSABT/LLttGVKylF53//9OYz0H1cbqfzd4oGCsV4h3ar78mFFZPuwyVy+EGsolmYqI
 PzmDD+M8pd7T+TDYqCwfCXgxlb4bciVB2bfDenlWTilg7o1C3afmK9GkrJug5U4PzgofgaDIWzI
 G7sHwwdVsJ4930HoYeo14o9k+pAJSWF729ehm0RA10IhN6aKjs94dEnA2StdsAwuB4ZLMcUEPwU
 2CLdw1CSSUfP0Tiso=
X-Received: by 2002:a05:6000:1ace:b0:42b:2e65:655e with SMTP id
 ffacd0b85a97d-42cb9a6069cmr553984f8f.27.1763597821470; 
 Wed, 19 Nov 2025 16:17:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELgrqmdJOT/QSkVZtF94mQ6wlNG4CcEftZTO2S11NjB4+HK1LGKGquWRyUz3L5Zrtoy8Xj3Q==
X-Received: by 2002:a05:6000:1ace:b0:42b:2e65:655e with SMTP id
 ffacd0b85a97d-42cb9a6069cmr553965f8f.27.1763597821049; 
 Wed, 19 Nov 2025 16:17:01 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8ff3sm2052149f8f.29.2025.11.19.16.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:16:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 04/10] target/i386/tcg: validate segment registers
Date: Thu, 20 Nov 2025 01:16:43 +0100
Message-ID: <20251120001649.1085913-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Correctly reject invalid segment registers, including CS when used as
the destination of a MOV.  Ignore the REX prefix as well.

Fixes: 5e9e21bcc4d ("target/i386: move 60-BF opcodes to new decoder", 2024-05-07)
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3195
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 805cfd08e83..0f8c5d16938 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2059,7 +2059,12 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_S:  /* reg selects a segment register */
         op->unit = X86_OP_SEG;
-        goto get_reg;
+        op->n = (get_modrm(s, env) >> 3) & 7;
+        /* Values outside [CDEFGS]S, as well as storing to CS, are invalid.  */
+        if (op->n >= 6 || (op->n == R_CS && op == &decode->op[0])) {
+            return false;
+        }
+        break;
 
     case X86_TYPE_P:
         op->unit = X86_OP_MMX;
-- 
2.51.1


