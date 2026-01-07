Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1BECFD653
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVEv-0007of-6i; Wed, 07 Jan 2026 10:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEl-0007lF-O7
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEg-0007NV-2y
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767798848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJTfX9vnrMV0tPHM38seWbDHpgKlBHplIleCEmi8Ac0=;
 b=WGH8UzJ23q6fmbUwTy1LMoRhKnBTV0H4NRoSn8Wz/fj2tpG4K1mgvG8zUQ2JNGsusqALo6
 gfWYmLsxh5X9HzOzAQcb7Y3SGyasuIEPuMuU0nB0Pb0gPYAHxCF4fghKL33lYhBvdIf2mk
 F0v4gGeVSf3cvw5ckIIW0Axqd1XNWsM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-mcfZsUneMn2dz3Lo63Ngew-1; Wed, 07 Jan 2026 10:14:06 -0500
X-MC-Unique: mcfZsUneMn2dz3Lo63Ngew-1
X-Mimecast-MFC-AGG-ID: mcfZsUneMn2dz3Lo63Ngew_1767798845
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47a83800743so5161915e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767798845; x=1768403645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SJTfX9vnrMV0tPHM38seWbDHpgKlBHplIleCEmi8Ac0=;
 b=HYF+DmoVL0VQanjS+UhhvTqoNRCy92bE9Y661lAIuwxc6D6aB3jg+HeFaH3DCDz31h
 8zMsZfuRmgmFZeaJIHRU6pUm4VSiuE2CDwRCYHWGYa+IAvNGgj075FrwYKBrs66JAAOs
 LC+ddE58813mJ9veErYXzW0dwRYGXjn/nkQxcrWZ7hzcDPGzCwXf6sR29BpJlpzVMJKW
 ruXP3QSvAuW8gTM3KyWqgLi8kmHBK9C5ZnymDbcCoGRq6hxS1wVACnWled2x6FF3hPdd
 8jQFwfcM0HZgCPriYaSoFL0KNB1Br7DzwnfehYbqUsSqsf5GC/EZCutPt11jQT3zEvrp
 3dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767798845; x=1768403645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SJTfX9vnrMV0tPHM38seWbDHpgKlBHplIleCEmi8Ac0=;
 b=Xv8mkeLdJEE+TZ9Ip+l3HT+XTp2SwIDc8BbaDBW190LcPM+AkBIS9oaYLzZTsioYJA
 Mf4JhoC97OmnTDBAgbizfjZNw9MI36sAYxomB85MeMP0JqkotA7jpREurO6/CmqJKTUN
 WaHbKnhdOk0abajJ3C3j+eL+LgioPyyzX/RGnXiT7VObk4T2kuE+l9iOsWhXSlLargml
 y6SJtztf4DcsyS/rCrG68DWmmukeRFTg3URXGq3ObytbiuOqgaDUpD3GtH0LNdhRm2XL
 DhwPOJpruY//Ybe5avvQy8LU3P7MOuuB0d86OqX7D5T5xX1mjo5XPiaJ/qzdNXXGhtgb
 gCJQ==
X-Gm-Message-State: AOJu0Yxg2zph7ECgx/PJCDx88wnMJTdINrnKxkTR6bmG9d2oak5Xv4a/
 Mll1g/+DMeb+P1hnALz47hnpLcv4JYPomnn1LXEtVPxdLj9/+vClHszZXLYTcaK0JrlMDkVjMVi
 +9Kd/mJOiEMFUqdXE4jxTpcgym6CjZWRt00oygB24mIj3mbEX68w5fRlsyatXi+Zp7H2TIBU7To
 y0nXRqFxX0fwV7oEHcUjRvIs10c7O+9/uKIsESQJK6
X-Gm-Gg: AY/fxX7HwRDYXSUJjwot4YGvga6Pm5ig9RKbJfSl6jej+pxwlobdx3y9Ma54SFTYtv0
 7WEbcl1WeH53EVONU2BYSrg84alnYsVC1uoUeNEX1riknPe7FJSx1v4/VymVTmcnuTiUj8OY15O
 MTuBIJFrQxg/+RYCmLKEtLmOOA77O7SVp0GrJhDrG0y+4ixoCIHkJlu9dzpjDz0CREN/kxMmVy1
 AOrEz6BNNQ3qxaa+HScdNbwaU/22M9feSDvUliFtq+EgkNUBaE2zAHwqNIOdLehACX5VqmGLm7s
 tdNdnZuiWCXP/Zk41U6zOjT0vPfpyyg+mmrA0HZ9WC/2I9Jck1sOg1pb43gcYzAUyeDn7goaHbQ
 +HXvaFTWJNgYlu+Z1qvmrm95WF2MjYpc4ANmcEEKzxl5pDoz4WC5a9chlGZTKlpwv/x0xoBQxyM
 WYvxfM2b3VSGj4dQ==
X-Received: by 2002:a05:600d:41c9:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-47d8484a4e7mr33591065e9.8.1767798844800; 
 Wed, 07 Jan 2026 07:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOIPi4aN4GlTO/H6W+R1mDzN95/Wjj+L5odpbRwQSL+QYxRbsJ3x2gZjvx64XGG7DvhI2C6A==
X-Received: by 2002:a05:600d:41c9:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-47d8484a4e7mr33590685e9.8.1767798844367; 
 Wed, 07 Jan 2026 07:14:04 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c86sm105075265e9.3.2026.01.07.07.14.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:14:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] target/i386/tcg: remove dead code
Date: Wed,  7 Jan 2026 16:13:56 +0100
Message-ID: <20260107151400.273916-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107151400.273916-1-pbonzini@redhat.com>
References: <20260107151400.273916-1-pbonzini@redhat.com>
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

Remove dead code; it arose when I noticed that, because 0x3? opcodes do
have a pop, case 0x32 works just fine as fcomp (even though 0x?2 is fcom):
there is no need to hack the op to 0x03.

Reported by Coverity as CID 1643922.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7c444d5006d..460848e4223 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2543,9 +2543,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 break;
             }
             break;
-            /* map to fcomp; op & 7 == 2 would not pop  */
-            op = 0x03;
-            /* fallthrough */
         case 0x00 ... 0x07: /* fxxx st, sti */
         case 0x22 ... 0x23: /* fcom2 and fcomp3, undocumented ops */
         case 0x32: /* fcomp5, undocumented op */
-- 
2.52.0


