Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3D7C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHRY-0001Qt-5h; Thu, 20 Jun 2024 09:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRV-0001QF-Q3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRU-0006Wk-1S
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1Dd/q0yvFV1Rcm+rk+YwoeGVJGUNMen0d4jeqopdXw=;
 b=QkhEdI6rCHFBYbj8ZcBmgbNzhY+BH2FpZAReDH/nR/8JS45KWXky8cBO65XvCJnO1eXq+O
 HPql0YLO8Ui16TLSH+eLqkRdSbdztrQ8+VGwnPJgUH2MOCwsm9m/ruC4k7YbwOVmp6htug
 tf3sMKaS47XinbNw3REY8yHAZGIErAI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-rRws4LMSNFqBVquPjpmL8Q-1; Thu, 20 Jun 2024 09:03:05 -0400
X-MC-Unique: rRws4LMSNFqBVquPjpmL8Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6efbb08949so36771166b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888584; x=1719493384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1Dd/q0yvFV1Rcm+rk+YwoeGVJGUNMen0d4jeqopdXw=;
 b=s3wn/Tn+yq4ok/sKwqjoJPtZupUxzmxJFqKDBFGvnPNZEKNJHBRBCeVgfs7S+2z0fO
 390Pu6t4dY1Wa6hBgbNHescyCDc92hUkxFkGl80UiTBMu/qZw+dkrGotcKgd/voxVpkD
 XHxxM3QXnnsdM4XbmSBV5IxGPgeRCA9Ly42JjOjH8odD6RPiDiFCwSqE86NEEcpYEjQA
 kuz0Y+aiv4m8OGYYpzLirMBUunDOm63quAQoOXpV6buQqvmaERX+i/+peENhoDjfZlxo
 IgX2Wu8wE2ejX4mS64A8/9WiLZ29KHni7TgZKKjiM9HKZWVgixbM+oh3HvMy/J7r6ydj
 nfWw==
X-Gm-Message-State: AOJu0YyWL1H4lDEZACXtrtcL7lW7JaXKu2AyDrUbOK8Sf6ielH7YiBsl
 J1+BHaIA2HnccXjNi2CiiDF5lI5xH1Bs4GLsKPG4cJ1NLPhVdGF0ZzsfMYh6qaepD+xT6eYR6AL
 yqeGQAqcFLD85BsIzMms3CjV+ZUSHt5ReWOPF7vlmyMOP64CYh/b0Ns3q/X5XPIGRoQ60pEVMEf
 mVY1sJnC8JOQ+fKrv1JvzeYpaDQmVawsoPfGJ0
X-Received: by 2002:a17:907:d30c:b0:a6f:b1fa:aa24 with SMTP id
 a640c23a62f3a-a6fb1faaa8dmr371966366b.5.1718888584329; 
 Thu, 20 Jun 2024 06:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHRVK/lLtA1fciNUQY7dGRTNR3lwYErop8nKJa0PTh/upPFcXV3U1WntbRveVeG1j0iC0pOA==
X-Received: by 2002:a17:907:d30c:b0:a6f:b1fa:aa24 with SMTP id
 a640c23a62f3a-a6fb1faaa8dmr371963766b.5.1718888583928; 
 Thu, 20 Jun 2024 06:03:03 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa415dsm772240266b.220.2024.06.20.06.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:03:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
Subject: [PATCH 2/6] Revert "host/i386: assume presence of SSSE3"
Date: Thu, 20 Jun 2024 15:02:50 +0200
Message-ID: <20240620130254.415699-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620130254.415699-1-pbonzini@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This reverts commit 433cd6d94a8256af70a5200f236dc8047c3c1468.
The x86-64 instruction set can now be tuned down to x86-64 v1
or i386 Pentium Pro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/cpuinfo-i386.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 6d474a6259a..ca74ef04f54 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -38,8 +38,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
-        /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
-        info |= (c & bit_AES) ? CPUINFO_AES : 0;
+        /* Our AES support requires PSHUFB as well. */
+        info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
 
         /* For AVX features, we must check available and usable. */
         if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
-- 
2.45.2


