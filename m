Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27B4EE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPf-0001BN-Sx; Thu, 12 Sep 2024 01:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPW-0000rk-VI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:31 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPV-00030E-CM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:30 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso552730a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119027; x=1726723827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EfpUjlJoapmNabWHYxOeHBJ2rWzJCTO2iJ5K7dyJK0=;
 b=FfwRmmwWmzk3ThrglottA0+tDXlniKQ3N0lwAXppamdlED/wuY2rCDx1/2swuFkiJg
 C9TuXLjD2IBC64AcSEkC4AIFVwqEyfPjyPLvtFflqAGjYpZIcPmid3elBTC8vA0/PDEy
 5qpz4o3gMvEkSqxgLyqsrzj6hcUSkZx8QkL9l4dqEfNaB8fhyckWVl6bnVIHV7eWfTTD
 WGQZLs2yHCt1/TslGUZtSvmGJHVCcNxb+PBuSlikPY1mBrtuNALRuAT1WUV/14IutcUV
 BOYFDH18RPMkMr0ToADcNrhwRzOuUi+OZB+IG5G52F71jng/KEUac2ZBsZLZI8OFlqoM
 kfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119027; x=1726723827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EfpUjlJoapmNabWHYxOeHBJ2rWzJCTO2iJ5K7dyJK0=;
 b=Yi0ypLQUcXB96k1ZLa7IM0aVXKjUU1sSptik5FmiGWw+bScFo7rRhTcRLnZaSrBuf6
 PzTHrONAQE5MgPhAJvunNZhkGhyyOaKf2dzYHEri/gG8fwu6OjvbWw1KDmvo70zFZBJD
 xxwc9GmstytYIus5/wYq5kkhF3H/8lvneaRZKMAg5jllBNY1hptQxdwbwE8NZQB0vaky
 lwSqtFCwHVVM17hr8QAhWjX3tM7QiSntiod1lgSXsHDvZkCEmrivLvltC3X6UNV0xv1a
 8QJ6cyoWNPoYltcoT6uNQ6MN+rmMhpBb9JGd0c2GRJvC/NZ2SI4BTNIAalcX9knX83ey
 j0SQ==
X-Gm-Message-State: AOJu0Yy867aokBr/xQwLJ3nlXkPigcaKTLOwWQIyedMMooBisI8Kko+0
 dJb4/QC/Y51iAdiv0J/2L2NCNMI88Web6rX1tdnmPX611bdc+0J0TrovoA==
X-Google-Smtp-Source: AGHT+IEOxXXdYaUc+ZCD6Jq811wkYqmu8Rf8jbRARxhIxaGj3q5CuxKdihHUyzOH9ZjNKnZ+qnrEZg==
X-Received: by 2002:a05:6a21:58d:b0:1cf:5370:3b0 with SMTP id
 adf61e73a8af0-1cf75f00300mr2655576637.12.1726119027526; 
 Wed, 11 Sep 2024 22:30:27 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/47] target/riscv: Stop timer with infinite timecmp
Date: Thu, 12 Sep 2024 15:29:14 +1000
Message-ID: <20240912052953.2552501-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

While the spec doesn't state it, setting timecmp to UINT64_MAX is
another way to stop a timer, as it's considered setting the next
timer event to occur at infinity. And, even if the time CSR does
eventually reach UINT64_MAX, the very next tick will bring it back to
zero, once again less than timecmp. For this reason
riscv_timer_write_timecmp() special cases UINT64_MAX. However, if a
previously set timecmp has not yet expired, then setting timecmp to
UINT64_MAX to disable / stop it would not work, as the special case
left the previous QEMU timer active, which would then still deliver
an interrupt at that previous timecmp time. Ensure the stopped timer
will not still deliver an interrupt by also deleting the QEMU timer
in the UINT64_MAX special case.

Fixes: ae0edf2188b3 ("target/riscv: No need to re-start QEMU timer when timecmp == UINT64_MAX")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240829084002.1805006-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 8d245bed3a..bc0d9a0c4c 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -92,6 +92,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
      * equals UINT64_MAX.
      */
     if (timecmp == UINT64_MAX) {
+        timer_del(timer);
         return;
     }
 
-- 
2.46.0


