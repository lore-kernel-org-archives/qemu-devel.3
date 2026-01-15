Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C943AD4116C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLbj-0003UA-DZ; Thu, 15 Jan 2026 06:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbN-0001fX-7D
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbL-0003y4-Pk
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmbYcV3xCktb3nD7uOxXTtNY5+oBGTXUObgEPKOEJgI=;
 b=B5Wh4XhApzuRHdiZCcWUrRSNyjbvVorizHJqj1NDJWfkLvKkAHeRcytL5OG0sYZnm7ELFb
 DqRa3S1cbsidtT0miyNIf6PUuZADRbCwJ4d75agm2L416BoKJ0/7N9qS7RCnwEz2C+ohgR
 NP8ASXIAZsmTTAad/6+SiAo/Z7IsEW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-LvfkmLDkPcyMSnlzOn6aIQ-1; Thu, 15 Jan 2026 06:33:16 -0500
X-MC-Unique: LvfkmLDkPcyMSnlzOn6aIQ-1
X-Mimecast-MFC-AGG-ID: LvfkmLDkPcyMSnlzOn6aIQ_1768476796
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4310062d97bso534245f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768476795; x=1769081595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmbYcV3xCktb3nD7uOxXTtNY5+oBGTXUObgEPKOEJgI=;
 b=i22EwQeNY3EjOL4xXs3p7EtZH1WC2IzAAEVcj3Gxt8AuJ7Hek0M9TF7XiajfFos87Q
 3TrCeWAVmmqLRsb9nLluh1HzYyPQYCQJBkJd4coPROi5mvnQkp3SGgxek8rkaTUzkXam
 2W4vXr0+sd2ZLLIUzweX8VZ3QwiHEnY9mW/d+KbwLl/OOE+OwGFf4JbfC28PzmnbjqEq
 sQ6HOWOu1Z8ZBgK6PXH0LKTX2uNlD4uSkSw1oupL6SyCd8JJe/uKdZNJmjWAGNzNv/+w
 ic7Xdaqc0T2skhzvLvogpGKLH7oqwzhu/m3I9MzYAu8xb9tiB8Oh5ZcPXdXRdWs0QwlC
 cUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476795; x=1769081595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SmbYcV3xCktb3nD7uOxXTtNY5+oBGTXUObgEPKOEJgI=;
 b=RluIucHPuiIGocoU6Yq7i5C3SL50u83UFNdF4wZ6xZuq7TDwk/8vyvdn5keT9CO80n
 AihLyyUlrv+NdNM+3Ct+O8hQtdYjP7QeXTcNhvdooMTJmRW0cSNLwrB+rIjUXF3rL3oI
 ULgt22jl7IAxD4BsW5EeYEuaoYiwhCQIn1DnauMcqtfvGHE+Ryt8w7fklk3Q3z2GwyWz
 ldSFk9NIjiAt4EHQMXpgWDEYNesy8SMQ9UpHpNKLmv5gq8yG+ye3CScTE/xUHZWTvuBO
 Z7hQ6FBJLwqA/Vp8pYZED+Q6GOUjSXhPr3ZrbAECI+aHJJPjauiksOiWRuau7aKsAuaf
 pLZA==
X-Gm-Message-State: AOJu0YxzYSsejmYIbY6VHj67VgaQQOC3Y0vsOfH2jQSmjAN+GZTC5yIh
 xdpslx0oP8cm8UxkXTz/7JZevGssmvZYds8iZT7BIz4QMHm63APnBXGhhPRn9Sfam9FOk8c0loA
 6yOtHUE5RiERF1NmtAGUixx4EtXTIFDcR5pQDIlvio1AoYZ0mtDXW+kWIbMp1dIVlwZNwCftUV8
 P5IAWRNutPddWZueC+fr9K3CBRUWjuUj9+Ipti+HAK
X-Gm-Gg: AY/fxX6sxjTdY8YCZzj3c/kZCKOLFZLYE7PZ0+9wW1sO6c4jID/xNg0luZ1a/Cdfk5q
 TrxzbI4SL0Nlq9CvS3IM3q9d7M4DpSmw3+D3QhDuuSq/5K5/RDQNQjDR1/JlaUsHmISRaDYVBnX
 sv7FddDofGixJdVBWXqsU+xyl/UYGF0/OswZvkS7BfEuaO6NS+BLmuS3Pg8XWSyaY2kkwGyO2Rc
 YRAUr44XQe/3jt8R5NSGAGB7uLUEOvE77HxDZdS7b2Z1SpqVVBhO7ec4C3ZrbjoMStTwh2gWa7/
 L8ZUHqnQ0LEZlMfXcomt4ybLLhfkNFaEL8ChxTQBxIQmfMuxjUIJoXRXPfurHanSVjzDb2zTT3P
 mL30OcmbLNLR4r9msW8QNy9+WYYju1Fkh54PNhdQJ4Tk3ThR/o2ISdJUuULdFCwRhPr1LOedXum
 q4K4tJlt32vDzThQ==
X-Received: by 2002:a5d:64c5:0:b0:431:488:b9bc with SMTP id
 ffacd0b85a97d-4342c4f3982mr7524713f8f.10.1768476794845; 
 Thu, 15 Jan 2026 03:33:14 -0800 (PST)
X-Received: by 2002:a5d:64c5:0:b0:431:488:b9bc with SMTP id
 ffacd0b85a97d-4342c4f3982mr7524665f8f.10.1768476794306; 
 Thu, 15 Jan 2026 03:33:14 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653560sm5539562f8f.10.2026.01.15.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:33:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 3/6] target/i386/tcg: remove dead constants
Date: Thu, 15 Jan 2026 12:33:03 +0100
Message-ID: <20260115113306.126905-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115113306.126905-1-pbonzini@redhat.com>
References: <20260115113306.126905-1-pbonzini@redhat.com>
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

NB_OP_SIZES has been dead since the conversion to TCG, REG_L_OFFSET
since 2015, the others somewhere in the middle.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 460848e4223..20aa94347b0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -374,30 +374,6 @@ static void gen_update_cc_op(DisasContext *s)
     }
 }
 
-#ifdef TARGET_X86_64
-
-#define NB_OP_SIZES 4
-
-#else /* !TARGET_X86_64 */
-
-#define NB_OP_SIZES 3
-
-#endif /* !TARGET_X86_64 */
-
-#if HOST_BIG_ENDIAN
-#define REG_B_OFFSET (sizeof(target_ulong) - 1)
-#define REG_H_OFFSET (sizeof(target_ulong) - 2)
-#define REG_W_OFFSET (sizeof(target_ulong) - 2)
-#define REG_L_OFFSET (sizeof(target_ulong) - 4)
-#define REG_LH_OFFSET (sizeof(target_ulong) - 8)
-#else
-#define REG_B_OFFSET 0
-#define REG_H_OFFSET 1
-#define REG_W_OFFSET 0
-#define REG_L_OFFSET 0
-#define REG_LH_OFFSET 4
-#endif
-
 /* In instruction encodings for byte register accesses the
  * register number usually indicates "low 8 bits of register N";
  * however there are some special cases where N 4..7 indicates
-- 
2.52.0


