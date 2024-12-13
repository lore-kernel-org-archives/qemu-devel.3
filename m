Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63254E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2I-0003Di-UO; Fri, 13 Dec 2024 14:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1o-0002Vx-O4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:53 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1l-0006YH-Oz
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:44 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f2efd94787so1261754eaf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116918; x=1734721718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfKmXC0aO5/KmkpGNbMSuzTs1IA6VJWmA6AglE8msBg=;
 b=qjWhxzLw+f1qeJgL5O8Zc3lFfp3RKZWDtvvi7yqOtsv9sr8orZIXZUsgQr9S4x62yu
 AMeb/m4nkItMS+Ufo/vRok1YVHtjdBM/W47xTo3aw2YqeLrZraCi9jQf4g9dBv/yNXSm
 9oqePjZT7ibAEF+71SZZaKXJa8OZ7xeacaqk5WEqyjYlLBM/M/5RtCLMLfyK1Fcq7McT
 h6FIgE5FkxPBaU06lribmkfwKT0ht3r40B1RCUjpCts9QI0GlehF9oe6yDL19r9xA9yI
 TLVsX1RAMb7TAJjK/6BvNN2sMMVSkUc/lanDjDMA+RN8qEnZYr/20V4LgQ99ZLHSl6wD
 cA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116918; x=1734721718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfKmXC0aO5/KmkpGNbMSuzTs1IA6VJWmA6AglE8msBg=;
 b=glTmQ5HdF0P4AZn3zw2wz8HDxWmm5TbbX6lYMmcjKRFESYttU9HgQxSl7dn0cr8MEv
 SlfeJbIjnMJgrDf+dMQrtmTvbsNTOvaVefLM51qLboCSRPQUh6ov3cJSNaeOtqlEVaZC
 OWyIdQkx2VFk0eP3ZUpXH18l2/YZAtTwk/p0Igc6kVbJ90p2Im9duxOVcDNowjA46fHp
 tUhfhMIv8a1cDZfjjp2KmXIph4WqahT08dextGxziuBghrU8WUcWz8gKIixLLwUuvs5A
 SLlfP9lZc2GSsY+iGljwzjMqXzfHIDorPX67+PHZS4gmiNrQJwYUiSc7RPffw5d8bQ7d
 VwAw==
X-Gm-Message-State: AOJu0YzvmE5+IUwKBCXzvNbmjU3fZHGDqpm+I0Npi+a4bi3xy9o7GGez
 2tcL112UvTYsSku7KLePEwiILfyom0uWrbTPXanLBKmC9i//WLTWqL+ZE8aqwKV0NgznlqzMNNl
 CbjtkGOIC
X-Gm-Gg: ASbGnctt7sPTipTnk+dVMQqihSa8BTfxy1B574vjKfD4jETBK7S3uPPKHgXxBC8a0F8
 TVuEFE/dxYLEPa9u0pVMyNHA6Q6kIUZByhkBOFBvTs18ioLP0aYhorwXLEAoQHtAasJ5lYhZapO
 JLEV1IYpFK+bOwEoPU1iM1fKGFEE1sTKMPWjQshredyg0mglsoY4RXzu71ymFYBQ6Mfm9C5qpzz
 OUoon98k9CRIEOBVb+na3BmBEbXJRWcep0ueavgqhD4IZd/pZl2E9r2SJMnRpoD
X-Google-Smtp-Source: AGHT+IFBh0w3wiKDbzz+9uNaaz1zJxDy6soOwdiPtR43E72iVjvprcArmIC3+dGDij/2H8+Jeg7Y4A==
X-Received: by 2002:a05:6820:1ac6:b0:5f2:9d29:2c3f with SMTP id
 006d021491bc7-5f32948b437mr2513007eaf.6.1734116918140; 
 Fri, 13 Dec 2024 11:08:38 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PATCH 09/71] target/s390x: Constify all Property
Date: Fri, 13 Dec 2024 13:06:43 -0600
Message-ID: <20241213190750.2513964-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index adb27504ad..4702761ca3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,7 +309,7 @@ static const gchar *s390_gdb_arch_name(CPUState *cs)
     return "s390:64-bit";
 }
 
-static Property s390x_cpu_properties[] = {
+static const Property s390x_cpu_properties[] = {
 #if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
     DEFINE_PROP_INT32("socket-id", S390CPU, env.socket_id, -1),
-- 
2.43.0


