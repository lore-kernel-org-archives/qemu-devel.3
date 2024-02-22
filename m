Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9865AC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFuv-000700-LB; Thu, 22 Feb 2024 15:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFut-0006z5-8Z
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:39 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFur-0002c9-NW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:39 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d73066880eso2070575ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634615; x=1709239415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4czMnwy4ONozXZRRucTuxGhHSF3+8ljKdOePhx3D1do=;
 b=anpyhmLpTbAXrCgl01JfOe98PpXZ6jVSSm19PoQ+fTrjYHyqLNTFNuWjBcZt2GpZTz
 lueict9CA5G0Go9AkP+u2i4GSpwSfW4uWCn9vzkX2TO+Az8wg4YWbNneg9q04a8HfBVi
 q0qOxfU7Szs+UUWgySNCE5aFye/1ADTSFhOBNU69AvLAojCpORpIrSVZ8H92373l1U8K
 vO6csWLOXXEes+uIJPUZI+G35elCYi/1sVTOVLaxfY86Yj9NcSEuZ9/ZUwe/4W030X0S
 b10u71flj/uKef38ZHFptHdvoVYne3oPAMttM100AReLo2tV+x9FCN7yEILwLWaOjQn6
 jL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634615; x=1709239415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4czMnwy4ONozXZRRucTuxGhHSF3+8ljKdOePhx3D1do=;
 b=jHza5xslqljIYQtJzEs1x8Jha+4/yt1RkIvOrWEF2cScrvdlPWYL3VdjD6N+1QHomn
 5SXpPzNw/RwdrFJx+B8D73i/HFEb1BFyJm3XTbXiQZdVF1krDC6IJZxCNvOMfxAWrHdS
 9hVgZwmCMl6KskP+xZyDhxVEVmJr+trT5Vu9DSqDXbW6aZndqkmY+E5LaemJGv4K1JnO
 +eDYoa9Tb8Di8/PhvtpCCW7UrS6UhM25+jr1u+DrnnWboG7VVGaIOKCYk8tzSYYy2meF
 BuDbCnDzCGQ43OlgQOdJ9sVDGON7CxP6aLX2bdZI111QdT9Cbws/0QxGazbBEGjBIMJL
 QHog==
X-Gm-Message-State: AOJu0YzWi00xYrvwYt086PBCq4wuP86IW5+pD1PXHwqstKPJ0GberX0A
 Dfz80Lb6SZpWFQoAmgWhbIKpWKismj2Rlp9SQyLGEdm6xvx9AJ4EX0UygBd6mwMGljq6t0Xo7RA
 +
X-Google-Smtp-Source: AGHT+IH6fkUsuO7V5W/elbU7FrcWJw9+jn/TcS2Q+OEznwW02JUaE73O465WG9Zn5HBaRLp6rXW1bQ==
X-Received: by 2002:a17:902:f68c:b0:1db:e9ea:31 with SMTP id
 l12-20020a170902f68c00b001dbe9ea0031mr15479254plg.62.1708634615327; 
 Thu, 22 Feb 2024 12:43:35 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 06/39] linux-user: Remove qemu_host_page_{size,
 mask} in probe_guest_base
Date: Thu, 22 Feb 2024 10:42:50 -1000
Message-Id: <20240222204323.268539-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The host SHMLBA is by definition a multiple of the host page size.
Thus the remaining component of qemu_host_page_size is the
target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-4-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e918a13748..e84a201448 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2893,7 +2893,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
 
     /* Add any HI_COMMPAGE not covered by reserved_va. */
     if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
+        ga->bounds[n][0] = HI_COMMPAGE & qemu_real_host_page_mask();
         ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
         n++;
     }
@@ -3075,7 +3075,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
                       abi_ulong guest_hiaddr)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
+    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
     if (reserved_va) {
-- 
2.34.1


