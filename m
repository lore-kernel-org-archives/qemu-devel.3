Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDC9C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3q-0002MD-6P; Mon, 19 Feb 2024 03:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3m-0002A9-At; Mon, 19 Feb 2024 03:31:34 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3k-0002Ma-Hl; Mon, 19 Feb 2024 03:31:33 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d918008b99so32898635ad.3; 
 Mon, 19 Feb 2024 00:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331490; x=1708936290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MQLJMvPdch8iu3qVmH7fTRcc+ezZiJrrzTjkVWYHh8=;
 b=bK8Ev0uNEcSlJ5Z5SOWJLWjqLpfqSfbjWp/TYAco1pivkDy4zpTV9fQLYgFnmAtgbH
 6TBYjeQ2rLq60XQKINl6XQR2iQvtLJb1fFaQDXQqxwnBwqV8Li4ncJ9oShhVlSED2STE
 PEEFmIfNeU4Z2X6E9K8Cc3znhGrqir5bNDYUjuSoPNL9lP1ZpAClDdXzq7K7hAP6nzT5
 Foaw9AbHD9hfD8Q87WpVsCsjCajj4Z4btUxYPOnyLU1U9LG8iT3fnz8bdFs6gJZvW1KR
 gILkntDF/Kc+lRx7dc6cBVd5cLjoo5VycfPaxvOmSeGozT5op0CLcVZ3rxWN2/UljxOG
 SruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331490; x=1708936290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MQLJMvPdch8iu3qVmH7fTRcc+ezZiJrrzTjkVWYHh8=;
 b=lrzqiQwHsHaYN9VqMU1KFrXRWtzA1LJfFuxMc92F+HSzM6+ecMwWcDJkOyou9CKK2A
 PBaqH2YwBkQAK+BmVB35617dKyqS5g+Tjg963z+Cj1x5YHwllW/TASEjDZf0y/cq82ji
 6eIp3eKPvpKwAkNGamgCbH9/AK9mJ3Kmm9K2ecGS4Vaue/zYH5Aef4cmNF8P4oETukov
 3OHBdlPS7CFYiQubbN7IMC29UQC0lOxR5SKBPm9epQ4qyMWk/F9in/7kVmGLuPoh7uju
 n9EV48s6sLn8zd1pVcHsghjVJiTcQ3G8v+Ic8i/8MoZ85PdcYnq3QE0nIHETpnvJDHr/
 pxwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCiGqRUHbvafSULk0+VRHEVQZBegEim3aeA4n5D6oNUgGDtGmh2CQEc1ZDH6cdXpjDGtotxcXJffUYSfANP9PRERfL
X-Gm-Message-State: AOJu0Yxk2qxCMD4jsp6fpEjwDfYew7bUwA77X0xVlF+MG43t0Tbp7LLo
 3s7T4MYDHbW+AqTt2vikuf5go/r9Inm0GAGFnOjLgs7mWZ6eQC39x0rSOUMf
X-Google-Smtp-Source: AGHT+IHGEkXjdCaxTxthr8SakBR73OB4cstdDbl5pdfQFivhqwX5BliOvMAotFrRalDSn48Di087kA==
X-Received: by 2002:a17:902:d508:b0:1db:d3d7:88a7 with SMTP id
 b8-20020a170902d50800b001dbd3d788a7mr4415456plg.49.1708331490381; 
 Mon, 19 Feb 2024 00:31:30 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 20/49] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
Date: Mon, 19 Feb 2024 18:29:09 +1000
Message-ID: <20240219082938.238302-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Cédric Le Goater <clg@kaod.org>

pseries machines before version 2.11 have undergone many changes to
correct issues, mostly regarding migration compatibility. This is
obfuscating the code uselessly and makes maintenance more difficult.
Remove them and only keep the last version of the 2.x series, 2.12,
still in use by old distros.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/ppc/spapr.c            | 1 +
 roms/skiboot              | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5a2305ccd6..36bd3e15ef 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -229,6 +229,14 @@ The Nios II architecture is orphan.
 The machine is no longer in existence and has been long unmaintained
 in QEMU. This also holds for the TC51828 16MiB flash that it uses.
 
+``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Older pseries machines before version 2.12 have undergone many changes
+to correct issues, mostly regarding migration compatibility. These are
+no longer maintained and removing them will make the code easier to
+read and maintain. Use versions 2.12 and above as a replacement.
+
 Backend options
 ---------------
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b442d18317..d1c6d70d8d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5083,6 +5083,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
     compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
+    mc->deprecation_reason = "old and not maintained - use a 2.12+ version";
 }
 
 DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
diff --git a/roms/skiboot b/roms/skiboot
index dbd5de6624..24a7eb3596 160000
--- a/roms/skiboot
+++ b/roms/skiboot
@@ -1 +1 @@
-Subproject commit dbd5de6624d7466bb67d1eb4e57bc3a8e2ad9e87
+Subproject commit 24a7eb35966d93455520bc2debdd7954314b638b
-- 
2.42.0


