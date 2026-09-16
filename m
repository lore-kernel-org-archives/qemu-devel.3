Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D16C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pik-0004NF-LQ; Wed, 16 Sep 2026 09:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pii-0004Mr-PS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pig-0004QX-Vm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789565438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=j5c0biV9iQHx94S6dDH/D1q56dQuwxRdl/1B0iDzMA0=;
 b=jBdi+2ULAvAi+H84I6Il87e6O4UjnqYopBzRKXJJvYN4DAcV7VAQMpLNV0yWQaOl36zk+F
 pqaUJOzF4MVzIGD1zMQsVcPzhE2mj+9N8bQPix1XHj4LpFWjDqBiGkaFcePhpQ6lTnUSWT
 l1xmPjRKcdziy85mpTk4XnLpIY5ysZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-FjNFo5B5PK2igqPJqplqnA-1; Wed, 16 Sep 2026 09:30:36 -0400
X-MC-Unique: FjNFo5B5PK2igqPJqplqnA-1
X-Mimecast-MFC-AGG-ID: FjNFo5B5PK2igqPJqplqnA_1789565436
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so55549905e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789565436; x=1790170236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j5c0biV9iQHx94S6dDH/D1q56dQuwxRdl/1B0iDzMA0=;
 b=IlULAf0ZCGG5vZ6yeageuDNYuwncRX1dW9CRgoJxQqnmlHGBIvUlNrEcTzbz//mgzC
 WQCwr8FcbyGFAylXpEEy+kM9Lx5X0TJPouCik336jJagvkEkvmgOwKbCW0hEF6oSmV7S
 /6U/6dQe3bHP3HrTMyFrlCaVpGSE6Twbk3k7XkdLHA8nOKhZrGCyAqaJPrLozDQFiKCP
 o/ZX0Ytj/ooFyVqoEiienDObPdthuFjCH3SzGZ34ZGIjqaCZWHQgGD693gtS8IsaMbdJ
 UrIdhUPkOBiML0y48mwLE6axNYIz7Lh25qRcaC9JBUSgcRvJMP66/PRUduXkc92SdEuN
 6ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565436; x=1790170236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j5c0biV9iQHx94S6dDH/D1q56dQuwxRdl/1B0iDzMA0=;
 b=UCER8x9mLpmP0juZXZ8AEV3jheE1y3w6DSH8PWYO/n6D9W44CAEi46brHJiSnkmdCK
 YOOqMyRNLVdEJQFpYO5oEfgrLGJYCT/yVjdy/KmRoaGcXjUgQ+hBV7xtkJvSnYSkkLvo
 jEDbi5zs+WrgG91c16anER2X92leuz96WJXF26L2iKHPB8kK8h0DT7w4ILmhgiT6vsbz
 pWElXQslTTNQonuThRFek5jNiTMIl5IEo7QF6GTTezZUHE3SqGHfuZdFk4KlOqA3qjP+
 CcfLXojcYxB6bnupgIAWkvmgjap7mH3jHujWTplwX2Eo53IYSR3rLkqkM0niS9NGldF8
 bt7g==
X-Gm-Message-State: AFuF++lfkIABvmagd8TV7bEia/L7JuY+EnIn33Uik0e6pWRTRH9udO97
 w051JUH1rygfqEgB6AIhclqDuRaGSyO0ajI9tMbrHivsm8h4orNSPpevLbs9JQEY1QFeMUj78a4
 vj1p6/hx3Io56NrrOoS5yKw52GIzmopszOuGMhNKCVMYoagpDAm7GDq/HAmi3t10o3s4K6sSGmt
 oL1tD6dXOeewoBAXIR+/B5WVPG4NMSGhWTfem7xIwg
X-Gm-Gg: AYBFou3fp0BMb1FfMjPWAyMIcHkqx0SAZFVUYLRu/XqQTANvcnVSdddx9CM92dFe7dG
 x7KdJshIzqJqghzTKdnTvf6dZLTSg5DoBwJuoVPe/mgfJf32jOSYVSTiIlvN1nGgtLYajrp95Xd
 PWN6if+l7xXEdz/3sw/26cmmU1OImpj4Zn3Rv7sPkCqFAmmH8I2cJUKQH9lPrt8/9DKsGHFjOf/
 AWmPTXwXitpD/ggJSIyNius5Q6rP04D87FFBrc+G7hV28GZhgB2PrzxPUR5t/Bv6jG9LsgZJmHN
 lCUrh1l+v1G613eCapcS+BxUgZ+kOU7ObX+AEaCBQxPMobYXMq+s5LbOGJ6pXD1xWfieo250blU
 3XKIVEoHE7YIVCR3+CYZ/kG/E9eMOInGOq5bLH2itQf0XGeglKOf+Yv6gb9X+zDfUgqGRZz8VZw
 3FZPyA
X-Received: by 2002:a05:600c:3b9c:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49eb732e48cmr41226465e9.17.1789565435458; 
 Wed, 16 Sep 2026 06:30:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9c:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49eb732e48cmr41225795e9.17.1789565434982; 
 Wed, 16 Sep 2026 06:30:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd83e39sm19360635e9.4.2026.09.16.06.30.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:30:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386/tcg: compute C of CC_OP_ADOX without going
 through helper
Date: Wed, 16 Sep 2026 15:30:33 +0200
Message-ID: <20260916133033.875328-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With the CC_OP_ADOX cc_op, the carry flag remains in CC_SRC just like
with CC_OP_EFLAGS.  Add CC_OP_ADOX to the same gen_prepare_eflags_c
fast path as CC_OP_EFLAGS, to avoid generating a helper call.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb6..d13e8cdf3f0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -924,6 +924,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .rhs_type = CC_PREPARE_DIRECT };
 
     case CC_OP_EFLAGS:
+    case CC_OP_ADOX:
     case CC_OP_SARB ... CC_OP_SARQ:
         /* CC_SRC & 1 */
         return (CCPrepare) { .cond = TCG_COND_TSTNE,
-- 
2.55.0


