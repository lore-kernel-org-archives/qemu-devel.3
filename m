Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93D7C3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPW-0005Zz-QW; Fri, 28 Jun 2024 13:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPK-0005YG-2a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPI-00029l-Hx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1Dd/q0yvFV1Rcm+rk+YwoeGVJGUNMen0d4jeqopdXw=;
 b=YFVG9ZZN9VjLyHSueUCTVetvBTzL/zEIwb2dkN05kQ58NMJhCsZ5WG95734B1R/7fuxEu4
 SKmSorlOGKA7ltJve5x71kSUY3nW+spH0ABQqlDZwcSkVG4PesuKSl04YB9QP2SOF1cM6V
 hpWHFQ2VHrYtLWWyBouFNS1OxG+UvMs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Hi7_3uahNkemX8807mJb5A-1; Fri, 28 Jun 2024 13:29:06 -0400
X-MC-Unique: Hi7_3uahNkemX8807mJb5A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d22ea3e71so606461a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595744; x=1720200544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1Dd/q0yvFV1Rcm+rk+YwoeGVJGUNMen0d4jeqopdXw=;
 b=NEticempQs83gDNbfsKJ5hh8Vav5BqLk7vaz7DlWQ9itbP5fFSFi9MOK1sxrHARotx
 173++f6jWGOvSVmlhXQrsjPftKthUhcKp4HznMPPoeNnLlRRDg2bffP8+Ye2BV7+WLCe
 ZlNiSo986CSJdhS1CdELYEIc3quPqxECsdzWA35IcoTq59tGSt+4+CgOqfbo54EIRqgf
 y4Bm9xz9LTHS5W52BGx57EvXWQ4GQLFwTaF2AfjDhYkPjQ5JApplz42HJCNj8ggMnVXC
 VbfA1YKfLoQ4gQxj6lES5CuNC1k82W5sCzl0H2a7ZJbG4ANcqX1VWJt1NPkIKuO4J04v
 4qrw==
X-Gm-Message-State: AOJu0YyDuEuutaWQbAgJjQVOGY02a8l7uRcbVivUFQeDxzAQgAlYgl5U
 eQ/mcHYjGGpS5SmG5LrOqUrKoPEkvBgeCUkdLupA0qJIqABIFN9bn87kIlbWBUx/Ouhgpc4qtON
 idiVsQbhv1R2dNM9No3w89W9NzR1P35ZEJ/G2xd3LjMMlKvxFxmbIFKPIxwYrBUohNoep478kVn
 WrwlTx7QnbYekt7dQYzodryfK12RbPTwMbF2GB
X-Received: by 2002:a50:8a96:0:b0:57c:947c:52f6 with SMTP id
 4fb4d7f45d1cf-57d4a2cd8ebmr13683870a12.26.1719595744623; 
 Fri, 28 Jun 2024 10:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCi/LNYsqi0Tp/zQGvOvEStoHRbuR6n00KmjMFzwTnHUixLO2vlbKMm05Jv8MYqEecdcoFWA==
X-Received: by 2002:a50:8a96:0:b0:57c:947c:52f6 with SMTP id
 4fb4d7f45d1cf-57d4a2cd8ebmr13683860a12.26.1719595744305; 
 Fri, 28 Jun 2024 10:29:04 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835f7sm1284662a12.8.2024.06.28.10.29.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] Revert "host/i386: assume presence of SSSE3"
Date: Fri, 28 Jun 2024 19:28:35 +0200
Message-ID: <20240628172855.1147598-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


