Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A8CFD647
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVFN-0007zD-Sy; Wed, 07 Jan 2026 10:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEn-0007mS-Ko
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEl-0007O8-GN
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767798854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnZA0IHH2GsMAGJ/CguzzLpofX9iu8pWCGdVSHIMEvU=;
 b=MlEqKFWG8gvx89i4fWBbATez9xmEdOWBqBpZF5cK60uY7qSoHXFYQfc38JvW7LoNRmKoMi
 eS3tqMZh2yRKMzXBOdG/4mOhna1GyCj1izJP8dJZx9UfK6AJyZgnKwa+M9bh9TJ5WZXXsC
 Pg9VyeSY3JF8aRfUkOE7vyreBlpZzuo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Aus9TCpXPfW205L6DGAdQQ-1; Wed, 07 Jan 2026 10:14:13 -0500
X-MC-Unique: Aus9TCpXPfW205L6DGAdQQ-1
X-Mimecast-MFC-AGG-ID: Aus9TCpXPfW205L6DGAdQQ_1767798852
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so1450284f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767798852; x=1768403652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnZA0IHH2GsMAGJ/CguzzLpofX9iu8pWCGdVSHIMEvU=;
 b=dnNLjp9KJS/HPPiHdkMNjLcdLNOxZPJfHVF6YRwA3+OIm7Avykgwoe4iodpkZ9/89/
 X+IlMbXatPIdpvvrUdtGmeKnGgDLf41AwSeHs2DwrD4BFuIWNKSR3CpgG+bU2nIowbeW
 U0gC5jSF3ECLkJAnc02r+obYURRnmWT5OX1hb74bHDqFuYo0RWL/ZQTFfFo/eVJBmz1W
 L9G5RzARRjemfWxdsljLbajvtKB8lNSEeJoRhQ5aIog0m05vD2R1pGVaIfjs+izO3h4j
 c4GJXbzg14DTJByMmov25eaHn1pAfjR7CtaEUKTT4H9vNKaanxF/AV+gqvCvh608m7Ni
 GIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767798852; x=1768403652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CnZA0IHH2GsMAGJ/CguzzLpofX9iu8pWCGdVSHIMEvU=;
 b=OYnkcKxB/RcLUUh2bhyOgN1OpfatLPnnj+rXTxwiB0UMIyyd0p9ko81k4bZvyWjbjH
 sdSNT3N3kQJgztY+GFM+zvNg1u7WHNgZ+M8SpjtaHWbFH5PiyhW95+j9qCtc0V7RH4ub
 82vKaYyjehzImxz6lsBeEELtovywOPsrK5p5/RN6gNGKWoNfpZ/1FYy6PRJJ2df6kmrn
 gEVq7zkoyCLcbiDSyz1yX8pCmrsn8KJvwJzqKa/0PQSaAWQUlYJmZ71l1TSQQy8rnFrN
 niZ5mOo7HX3pAiPv/RyZ8OCV0D0SwVuN6WZ8490X3tE1bF+hNT9dzLlDHTtCP/Lme9QG
 EtAg==
X-Gm-Message-State: AOJu0Yzhti+HJsGYIqIyemKn3nTS++jDZ5R8/UyKYZfAqeFfw3rNTWOw
 BGPhwiadDe/TKmiHhQCeOqoCSzpGmy13z1rvrzMO9lWyZwoqqdQrT3MuH2ZQg/PtaC0KVwMYpuR
 TJTgoanDCj4LItYuo/KAEytEN2Ggw6SWj5aA+tQ75Lmvi5yiYoW7SR+opZXSkV9h/RY9T07nLlH
 bgYSXIO7eRz0zuWtQOeh3Q/YxZ1/7L911uJyCQu7P1
X-Gm-Gg: AY/fxX7+7LoArm2k0rZf9QFCZDATF2QNoQ27k13wTLXl4eSxuk8HhBzhxXEWly3C1WB
 cKrnYbE6su0JT+Gu+XLkiqrmT8gpBkCT0sydysxhxFEW1JngRDIZRZmmRljgN+LWa5WTcDTyLWX
 42V52pttmXKRl7kxE6QuTC2IXrf0rRNi2AiQ5UGHTxgaRrjTChn9RwPCGdA9hWffl559K0D5x8u
 dk9wpKIiYQWxkJxHf/5ws6h34kH/KmyJmBYUa1JEI/RqBjduaJbvCKMqP6LX3+XSY3B0rFVT256
 YF+9XPU7nMmb3jpU+dtyo2dmug5dNLL9UdQuUriOW1qP7yDxrc4zE3hK07f+3jDvx8PpnFvI7HG
 NtG65IvGUR+JPfD++Os4C9n7OwVbpGil4X5npTUewMi8lnNcSzzHg6DsU1wdYSxD8ZjJ7l5KHtB
 0ie7+iVFzAVf+AyQ==
X-Received: by 2002:a5d:5d0e:0:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-432c378a8bamr3246269f8f.6.1767798851951; 
 Wed, 07 Jan 2026 07:14:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESAIrbAialmUD2EWrg2OCUpdekMaqKCZ5bX5RJPsm3INv5CyaxKtutBPbrjHvhzmLnVz01Jw==
X-Received: by 2002:a5d:5d0e:0:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-432c378a8bamr3246228f8f.6.1767798851410; 
 Wed, 07 Jan 2026 07:14:11 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5edb7esm10475826f8f.30.2026.01.07.07.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:14:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 4/5] target/i386/tcg: allow VEX in 16-bit protected mode
Date: Wed,  7 Jan 2026 16:13:59 +0100
Message-ID: <20260107151400.273916-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107151400.273916-1-pbonzini@redhat.com>
References: <20260107151400.273916-1-pbonzini@redhat.com>
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

VEX is only forbidden in real and vm86 mode; 16-bit protected mode supports
it for some unfathomable reason.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f662364c600..243df7e3735 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2875,7 +2875,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
          * VEX prefixes cannot be used except in 32-bit mode.
          * Otherwise the instruction is LES or LDS.
          */
-        if (CODE32(s) && !VM86(s)) {
+        if (PE(s) && !VM86(s)) {
             static const int pp_prefix[4] = {
                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
             };
-- 
2.52.0


