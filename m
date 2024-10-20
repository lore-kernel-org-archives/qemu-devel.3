Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865E3D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG8-0003Yf-9Z; Sun, 20 Oct 2024 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFp-0003OE-Kv
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFo-0005Qp-9J
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpF+XZQI4Pde12kaWW1aCvqAcg4Fwt6yZrI1Joisxg4=;
 b=gWBSXxr1VMN4c+3stP/WxKAiXpJ/3/B5FxIKCMnXJQWlsf5DQ7z+w8ERzOa11ulNW16196
 rOcoalY7aosbk4THK76WLErpFxCQxCMWyjm+2/hpz9e4dlfpfPayXXe0UeS15sDjQlhqVy
 J7ji5x7goX6mS7vApXs/4aKf9VtPq3Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-iwtDBgByN0KxoIDBhqrQRw-1; Sun, 20 Oct 2024 11:54:00 -0400
X-MC-Unique: iwtDBgByN0KxoIDBhqrQRw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so1859772f8f.3
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439637; x=1730044437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpF+XZQI4Pde12kaWW1aCvqAcg4Fwt6yZrI1Joisxg4=;
 b=G8VC+kog5E+tz6dULMzvCaz3YLi/5kxYQBmah4Edfb8PxdPv6ywtQMA2SCHYsP/6NM
 Nva5f8dnO8AUq6Hn9DIFE03OQSZZ49ItSt6svQOonEpLGtiRKKZUCVKMJ/9k+67l7sPt
 MRJ7kEG6vnvA9NavJX7p92IMPMWOFlrsb2DgNM74laEk+3OG9jhD7RnVxXHpFiQpGQrB
 JXHzv/c0Op+7TOViFZXRDKUJEYqIBeznB9Mx0vGNdCdVu0bezpcqwD8UvT3pRxQV2Mhu
 /vZfSP/VO+EVJnfbtkSVJTMlu/dsfCh/IldVrAyUQiPX/0GID/SdeDRmmJQkLPJIcEPt
 halA==
X-Gm-Message-State: AOJu0Yzy5LzTpPYher/9Iz632udg0WpUijztBiOiQvv7y38IzUJM2BBw
 rBJb0LEFBFWL/IHmQWPOQy/kqIXTzUwZVd2FickNYoE5ZR6bGqg7N9fVaxkPIGImQDP3p8XlnL/
 CcFQKdE4XiRkhXqrZW+gbwLRLj0cQej/weBUMT3qcwF6c6szXSWMJAqcTxBEF5OZgjh8rZu5M4i
 K3GPWy0S58Lhqcdi6yVOz886hkyckqSVL07A/yWdA=
X-Received: by 2002:a5d:6d89:0:b0:37d:5429:9004 with SMTP id
 ffacd0b85a97d-37ea2137362mr6584622f8f.3.1729439637485; 
 Sun, 20 Oct 2024 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQiLcp+sMriC3fEshp7X9Kj1/ATuY9OiLmqLwg1xi+1eM94iYTYOUUxkZxo3WBvy5TELIP4w==
X-Received: by 2002:a5d:6d89:0:b0:37d:5429:9004 with SMTP id
 ffacd0b85a97d-37ea2137362mr6584611f8f.3.1729439637101; 
 Sun, 20 Oct 2024 08:53:57 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a57e0fsm2006002f8f.47.2024.10.20.08.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 09/14] target/i386: add a few more trivial CCPrepare cases
Date: Sun, 20 Oct 2024 17:53:19 +0200
Message-ID: <20241020155324.35273-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d3bbcf7317c..6e89d4faef1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -993,6 +993,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
                              .no_setcond = true };
+    case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
     case CC_OP_MULB ... CC_OP_MULQ:
@@ -1021,6 +1022,8 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
         }
         gen_helper_cc_compute_nz(reg, cpu_cc_dst, cpu_cc_src, cpu_cc_op);
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = reg, .imm = 0 };
+    case CC_OP_POPCNT:
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
     default:
         {
             MemOp size = cc_op_size(s->cc_op);
-- 
2.46.2


