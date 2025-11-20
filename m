Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2182CF6499
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMD-000372-4n; Wed, 19 Nov 2025 19:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMB-00036s-Cr
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsM9-0007PC-Si
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyGxYNW5IV1mR/jWc9nz65+A1YzvJPGyS3EIkWGspqo=;
 b=K5pZZq+LS+kV4NVjAYYifrdl8wO49Gn5FzOVwgdHQ2/89M9UGuNO70sB/piRGbaxvUpaw8
 3a40SK4zc280zGczFxmXI7FU3CDodXtNKf69Izi6BMvU8AdBFmy0vrMDEkID7iZ5+wY4xh
 +WrJhBAqpQTThUWriV/Ed7MsEs3Kq84=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-wVHt3bmoOfGGvuKdLAh0jg-1; Wed, 19 Nov 2025 19:16:58 -0500
X-MC-Unique: wVHt3bmoOfGGvuKdLAh0jg-1
X-Mimecast-MFC-AGG-ID: wVHt3bmoOfGGvuKdLAh0jg_1763597817
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47777158a85so5166345e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597816; x=1764202616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyGxYNW5IV1mR/jWc9nz65+A1YzvJPGyS3EIkWGspqo=;
 b=Yn/JCrwPz6iI3JpV949xWxHmhLMCx1DP7EuRVYVA8APa+nO657vg/xKFGFfD5jUZcE
 TR0qRwTTWVYyrd7shPpYPg7auj4WVEh7zj7Zb+BhsuxZK9znW3Oa52cb6N2tT4xel/ry
 2S+iTK2y9avsdyPGWrbxRLpO7Vl32lW2Z4TEeiFHJMv8Vh1JWStUgIfiiGNow9vdHHdB
 JUFv5RoP2MUhizJ/iB0Fwu+RvAKR+TvW1jJ79sr+mcGfyP4fH94qMF2DouVAF7N2rUGC
 QaloeMjpeAs6/Ou5BXaNM/nYZpDu67Fv3Ho9MXvmY5MvexGqk9PI1Mk5FbVVwZs6LP3p
 nGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597816; x=1764202616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pyGxYNW5IV1mR/jWc9nz65+A1YzvJPGyS3EIkWGspqo=;
 b=HJ/clZPWJxK1Xd1KKtlUEZbhfhzdKubmd5YOrjQPqiVE491TRzmJK26jyyjiJyZ5tc
 iopQKk0g7uGkTZmAvjUpBfCt7S9XorXM0OWVHk63FiIK2DCZ//V6Qqv/QWFRsxWACq7x
 eealFFrNm8A/gbgy4GmeZ9cg4bsls04Pf1oodoGHaVwiwuVl7/9BwiUkYFVgUBQswBPN
 3Kk7ImTxNLmFjM65vJ7JfJnXxBS5CGbO2881KOTzz6fGvp9d1HZ9lwp8e174w4zFguwb
 D+4cRKXSnn/kglFr0wnMKnWzUJTzRtVnt2llqzdODe/QYwH2D1Vtwx6CMjliUY+978S1
 u9Ug==
X-Gm-Message-State: AOJu0YzSXxDxfsoM88nQ73qExzx2Q/nuPkso88dgGoYaOUVsyzjle66g
 qR4rSoZ75a87CrjxC279LcG8feL6B7Of62vDbUAKgiMadtaSELWmw2tHIzejGCyyhf7MSVaRjOK
 Cc4/RqWvNtjMEYWWBU/GbVekdedJD8yROKfkaskQdJRbE2l/hFrNVL1fdXQY+PeRrOqbGO/+Lm7
 gnNSkdHAihqzfMI5+Nik+1lU//Varj3iJEXBv9Fb0p
X-Gm-Gg: ASbGnctJgmmm/1kMlPTzZ+ldQyP/HKyE2R7WKsp+A5n53/jQVSforVNQjTvIPJyjnSa
 4TtjSdyhdP6eVKGVylLklsZDAycRrz4sOF5DfFlLkLYhtlmj+YHfKu68dyNBTmgWW66nM2qSZfH
 6UTP6aNlo7z4vQEc/7Iwulz1wWEZoa6fMYe/o8ThvUYkP1snbb9ODO0e8uXLYHFCis4pTpuUk4p
 t2jULTN+hN03eoFiXSADYlqyoDxxoWbihNcrloWu2yDO6AEWiFet1Pe2Cj2olBgUihj77g8IFTy
 mambn8LNM62ptttgjSOhXEKV3FOQnrtHdjNMSo6x2PaazcE/qU+HPVtJzEe6T6q67mzVJnq2gWG
 UsB84gl+2/HGA861gjlGyaeBKPKGvIAlRQwOcX/PgttPo7RR7ut1v5cHGuJTf7tSlYx8BKxwOA/
 /WMbDL77AJXEoDqiw=
X-Received: by 2002:a05:600c:5490:b0:475:dae5:d972 with SMTP id
 5b1f17b1804b1-477b8a90470mr11069485e9.23.1763597816271; 
 Wed, 19 Nov 2025 16:16:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ8DQ3mw2eXmW1Ae4dkwMy8vr6W4MnSf2zlUNdKAHSQEmtBHxgdOPA8vu2dAanpS6wGt63EQ==
X-Received: by 2002:a05:600c:5490:b0:475:dae5:d972 with SMTP id
 5b1f17b1804b1-477b8a90470mr11069415e9.23.1763597815846; 
 Wed, 19 Nov 2025 16:16:55 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm1965265f8f.36.2025.11.19.16.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:16:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: [PULL 02/10] target/i386: emulate: Make sure fetch_instruction exist
 before calling it
Date: Thu, 20 Nov 2025 01:16:41 +0100
Message-ID: <20251120001649.1085913-3-pbonzini@redhat.com>
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Currently, this function is only available in MSHV. If a different accelerator
is used, and the code jumps to this section, a segfault will occur.
(I ran into this with HVF)

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Link: https://lore.kernel.org/r/20251114082915.71884-2-phind.uet@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 97bd6f1a3be..d037ed11420 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -77,7 +77,11 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         memcpy(&val, decode->stream->bytes + decode->len, size);
     } else {
         target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
-        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
+        if (emul_ops->fetch_instruction) {
+            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
+        } else {
+            emul_ops->read_mem(env_cpu(env), &val, va, size);
+        }
     }
     decode->len += size;
 
-- 
2.51.1


