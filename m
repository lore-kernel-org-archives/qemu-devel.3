Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27398C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHm-0004iX-V7; Tue, 25 Aug 2026 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHj-0004iC-D3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHh-0000L6-2d
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPtHh49RCadU+YCqGBKM+gF8JI4PmoRUuMTtDPgOW9M=;
 b=NH7a0WgyYdy+mmvQmJWrviWeLJ7YozIMxr9Z+XOp4viOxIKXt3A/qZLK7P33mR+NRbwO/I
 hDIZnK6REcryuW2RHOSuucqRE45XwUN7ofUNAXTx/PVMlBazjHF7B24LNnYk7QFz0ATcYB
 easrCMqoavxBZOapikZfP2rRgMjqh0s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-hM5Vce8VPjSjbWxos5KiYw-1; Tue, 25 Aug 2026 08:29:43 -0400
X-MC-Unique: hM5Vce8VPjSjbWxos5KiYw-1
X-Mimecast-MFC-AGG-ID: hM5Vce8VPjSjbWxos5KiYw_1787660981
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c2192b12cd6so438601766b.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660981; x=1788265781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bPtHh49RCadU+YCqGBKM+gF8JI4PmoRUuMTtDPgOW9M=;
 b=W7YBxkaoUcdo13hMQEVCYuIHKBb9rBppIEQ4To8uK5zSWdXZ6Ks01TrdOo7sr6AcaD
 2+fPjHf//2Afzpfd0JIgQGsTF03yHFjr94ETIZs7UK/B2Zwl4vdLH8LIt0kX8T5zFER2
 5NNFiip6XXSIJZDMmVgA/N8JP/qWGZcTzhkwu1/4bNzxD6Jc8I6bLhC6/qwMEo67sfwR
 imVUMQYmfla+rkunSE8Mdcp08qcJ5L3tgHg1Z6mLXYMARWj+zsgPNopk9G6oQBdeYW5f
 zv3IFS2s2ZI0ZZ3KvQyomZ/r/nLaffivMPpOEuKAEcDRznd4JJw9pFpEGTAmo/kyTk68
 o0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660981; x=1788265781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bPtHh49RCadU+YCqGBKM+gF8JI4PmoRUuMTtDPgOW9M=;
 b=caC9yszPXs6o37f0Psy79YcWLmPocudwQ9+Ivtdf6qc3bN27IUALGx4x0ywEYr0Ynq
 YpuqvitUJxzv2zEuzMoY2nORa+sM0FEfwA7nja6T9b0pdUBkTYudcrkVPhUfEDRXH2cu
 QD9LGJEihuQGIIDGYLJPOVqwNsnbW4DIsn79iKM9Zyl9ERV0X8jrNh9l3tJC34YUYYWu
 xOg+k3koO7sR/jEe+c/I+0UWSlhW17093vdtNysZyCbvn/KlHlSlg8IKJRcUcGna9G70
 6Rjz2mK6ciRbEvoWCSx/ey3Psks/JC/7pc8eDdeWenhJu6W8n49ZDRCNKuWEOHPv1Htc
 Cj4A==
X-Gm-Message-State: AFuF++nQsYQ1CDR1Cj9eW8Vkc3pvDnm1GnpwMkHv9/p57W/YJyGmrsfk
 ys4ZShpgWtX5xnmgnkt1omDMlVs4/W7Cwa+XT+TdOL33HGm84YujqnKn0qAmk332F5ZKEAS57sy
 gDsAb0C2iEyXNlwA2767X453+g36AhF0xvndzqhfqB7oSMtC77SIJM5YLgBxFnTGbdtJOiSiM5H
 Vy4NOLUVBEFIXDGakCUj8wfvoL7r+vICkfQZwWju1d
X-Gm-Gg: AR+sD11PnhOTolMLcGDBGxwyvebG9/NCI41z2OSP60AF+qxs8At2UvVm1irDTZwFrJj
 H27ZSVQvTn7x1X+A+8Ns6+EvIBNC+SfSS1C5ovaxnv/LuaEUDqCNc1lEmbx9nz+NsBU8nSgoWZi
 8PiCtvYbJpX+bgW4SD2oWkrhbO2cN01kpfQTcuLQlC3BHIP1+M5dDbPDuTCqQ+EDnNW6I4nh0L2
 EOsQEOPiPSoGbYK+3zZMZS1Mk4QiFZLNfhh79NttkFayWPU6K3CmlabtXVit8a+4jG0BbXmH2Gr
 Gf4GM0YED4RL8xTsdkldPeBYjEWxR/PsQb5paB0Y1vnGJ4mWQfFueij20R+IBr0gqExM50+2gV2
 TP7xqa7+HB0nCQ9ImCBhTS5w6W7G28qj3E8QaAlSfOSdTgPoMFaVGKWg4k7/6SKS6iK2UevfLQj
 iSBlQ=
X-Received: by 2002:a17:906:4791:b0:c24:db68:ecfb with SMTP id
 a640c23a62f3a-c24db690609mr963378766b.11.1787660980789; 
 Tue, 25 Aug 2026 05:29:40 -0700 (PDT)
X-Received: by 2002:a17:906:4791:b0:c24:db68:ecfb with SMTP id
 a640c23a62f3a-c24db690609mr963368566b.11.1787660980104; 
 Tue, 25 Aug 2026 05:29:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968d5f59sm1729302966b.63.2026.08.25.05.29.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/20] target/i386/tcg: add definition for REX2 prefix
Date: Tue, 25 Aug 2026 14:29:08 +0200
Message-ID: <20260825122921.431739-8-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb6..2b94f4163d9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -50,6 +50,7 @@
 #define PREFIX_ADR    0x10
 #define PREFIX_VEX    0x20
 #define PREFIX_REX    0x40
+#define PREFIX_REX2   0x80
 
 #ifdef TARGET_X86_64
 # define ctztl  ctz64
@@ -208,7 +209,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
-- 
2.55.0


