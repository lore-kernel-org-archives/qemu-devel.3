Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BE2EE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPp-0001mm-IN; Thu, 12 Sep 2024 01:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPn-0001c9-6p
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPk-00031P-8j
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-206aee4073cso6393075ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119042; x=1726723842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afEpHTThU9gcnAC+v8AUAUMqHz1ovSP2re97I4R4gXU=;
 b=KgglOKSIg2MmI2waqSM3mGr8nm36QuJndYnw1ySGxAPdzDSjnVf6/QzbjO1PbgXPNN
 Wbvl+xuHqEanhpAqhAqVldByOid6dvDK7VORw7fuNSRRLPr37jI9/Egy+LsZjgOHp+Am
 IJNLZjqsamyWLi1cqmqS9ZxIiyRi+cT1KrUQXowiRS/lZy80Cv/1mz07or6uUb20M8vK
 AjBYD+AoKvrD943OU+SRnHS3aDJBg9+qlyrfdO+9V3Rugfa56XITi1pBHxKK4LwvH/55
 biqNrs/L68a0p3S6cha5NVjsDyTca7Be+Ds0kgVhkEk/C0mJiBt7ggOgAkOp+j2cjdT+
 9Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119042; x=1726723842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=afEpHTThU9gcnAC+v8AUAUMqHz1ovSP2re97I4R4gXU=;
 b=Ytmknq8YvC/EQF6dIIyljbh9CTmzv5kftb6s3hL0+mP8hzoMHUAsZKEP8ueb9xKbjH
 +OtOooglyMXnmK3MScwJLyu9M34yAopDYptUzbcu40h5Ytb72+KZE9+uqAmRPEma1ShA
 zlr908+j7dwBr5s6pJw5/B4O/+wvhkqiCll3YKh5ePPl88qJCkOsYicNo2YZyWJRJKIA
 JCbbwjoRMlf1C3jd4HQwzH8Qoco4KmyuNuINZGMFZo3OYeZM7aR3zLdja9gu7sVFbgT3
 qmWG4QlphtiINCp+jp74bBH+2x6Eqich9EDO8atOyF1z9RRxPBrRv+IxRLyxWQxG3D+E
 JSig==
X-Gm-Message-State: AOJu0Yy/PsxK/nZFTxxmp/3c/JrESgkaSogGvKPxjAQjQnfqUGInPmMn
 aRSJnDkoqA2NIs7oZEMfv5YXjCh3MrC42G5DFvR+XvX9NdPo2a2mOv1/DQ==
X-Google-Smtp-Source: AGHT+IFLkyOPvfMxjuwvzIVQiGo14LpK/PsBzTt6ydSwAGkRuQrl6vuJ2lPB1avNUzCiZ++8QivwFA==
X-Received: by 2002:a05:6a21:3a41:b0:1cf:5aba:eac4 with SMTP id
 adf61e73a8af0-1cf76493e8emr2272974637.41.1726119042105; 
 Wed, 11 Sep 2024 22:30:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 14/47] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Thu, 12 Sep 2024 15:29:19 +1000
Message-ID: <20240912052953.2552501-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Extend memory transaction attributes with process identifier to allow
per-request address translation logic to use requester_id / process_id
to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240903201633.93182-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/exec/memattrs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 14cdd8d582..e27c18f3dc 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+
+    /*
+     * PID (PCI PASID) support: Limited to 8 bits process identifier.
+     */
+    unsigned int pid:8;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.46.0


