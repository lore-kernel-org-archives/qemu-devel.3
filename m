Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAD7CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJn-0002R2-0N; Tue, 14 Oct 2025 16:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJQ-0002DF-5B
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIx-0005La-Mo
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:59 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b679450ecb6so3095612a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472448; x=1761077248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxdES7ALgDg44Eo9u3HIFuaCLq3lHqPVHj7YyhO0Mr0=;
 b=pZZH9tyJ2lT15K2FLX9M0mmKzMFdGs43QaGC8hjfA4btFiD+cr87oPaUr6Xut5pchV
 Isz2WxwyJkMNJG9LVJphog2zXX3mptkpmX8i2kYtIeu0rNLqIBjo108S1u4pUVz0qFRk
 5LnN9zVjEWneeZ3dd0LdNjkr8Vx3dsay8fnTHrz+h12ue5Z+vweSkW3u5D1SBw3TP2HW
 gHbt/3aazdowDLOnGB0k3Ytg26XZEu34V0n8ukcY6LKka1C8N21be5P4Cy12gjBzDvKz
 c4xeJwu6Clkrl0tXbo05+L6T468VBBmej3dIfAjR9IRKkdvKJW/YyznaU2SR/gjI6N3R
 clLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472448; x=1761077248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxdES7ALgDg44Eo9u3HIFuaCLq3lHqPVHj7YyhO0Mr0=;
 b=ARkI+3BgcAEmQ6ghbFc1JPocnhuRCan4yNnIsg/J9v/2RXKzgYLJwxWeLNIkvTF1qy
 Boc7tzpFpCw18U40PORxnJcst/mbw24C51zaehGQELw9nLm1K0rGqatwnIbv13JAYO0b
 KUck7hlYGVTLgDin6bTTyKozIDErckuMWSKhMJOW0UNdi3ZFHAFfO8ybSH7Qfu+z0ubr
 SU2zVCQnBkGaN3kF9aCa+Rtm5EO2nQ4TRBKMobwQf2qrd8ccWtMxb3Ybl2Q199aBMB3h
 zvB7nsoev6S0U59FkMKHJphP7Ov05a7U/Pq0G/R+RjLnE92hC0T4YagOCYtP5pGLQ1pg
 TtVQ==
X-Gm-Message-State: AOJu0YwnG63oPvAr729zJiccHpyxg+JMROx5Ummdnabccj9FNIUVoeC9
 MPU5v+Z1Plfk9yKqI4RBC7AvpugIa1yg6eo0Etsbsz5B3mJBeRpvscFPLsUeFTzyQL9l0IARJlJ
 8y1Mjh/o=
X-Gm-Gg: ASbGncsIArH3luy7bk7vI8EqA502pIrkt5eL0zCxxVwQgYjXTIDq+fzQyNhVYQUfsna
 Jz77t3lDnN7oi+NhVA8MdMb4k0IeE77j548huM11h+eJUtn9aiEC7gPWmRUrOItNlANeD1c4tzm
 K4qDRolxhb6PnbjtgUFpmZSCsC7/R5REP8VmCUvts0npx5cUTFMV8mHHQFeNzatOrYB2X3l4JSZ
 INoHIUCO4EYthkDitlZJ9maq/bZGwUPZf0QLTPzxP0AjEUVZvDCDdnrnozCe7hGflX/iOuk9noI
 cxaRyQxhvK1PZZh49QLKVS/du5oyT1AupmDI8/0WcsSvkZJow+HL/ooO/gA/LWaG9mPOX6lS/EC
 W3LfdPu8djEi1EzEKarlfItJPtHcHCzlxBY7SOHF9FUzWe+tDLgf2kjXTX8xd9Q==
X-Google-Smtp-Source: AGHT+IExpePb4rAAcohJzChw58kULvuSdv+qtWIWBQOWumWhZlDu9PuVhqvja9ZFXog9eKRYzePNZg==
X-Received: by 2002:a17:902:f708:b0:272:dee1:c137 with SMTP id
 d9443c01a7336-29027238ee0mr327616435ad.13.1760472448410; 
 Tue, 14 Oct 2025 13:07:28 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 13/37] target/arm/kvm: Assert no 128-bit sysregs in
 kvm_arm_init_cpreg_list
Date: Tue, 14 Oct 2025 13:06:54 -0700
Message-ID: <20251014200718.422022-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

KVM has not yet enabled 128-bit system registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4f769d69b3..3e7738592f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -804,6 +804,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         arraylen++;
     }
 
+    assert(cpu->cpreg128_array_len == 0);
+
     cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
     cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
     cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
-- 
2.43.0


