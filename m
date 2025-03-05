Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7177CC282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdwy-0001OY-Nz; Tue, 04 Mar 2025 20:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdww-0001O0-Tr
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:30 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwt-0008LD-4W
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:29 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22359001f1aso141898365ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139605; x=1741744405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+v51xfDzyLDQdhDH4NQnLLxRK59n+7mC2qFfSEYePA=;
 b=WKY0vTCmeWafLlU+72pwzSv0YbGDYjiLS4zimjVl7Ka8tNctz527TfLE3BVeeOfmaH
 RI/Vfp4+n8Tm9cO5u2oZxhJX7cXeB6hJNn7VXdOLN+m9Km6Pci3ieDjdfILUIpDiRNMd
 NcmnkBViLs6Z+aQTWV4AtDvLKCajCi5/Ti9kCgQjtUY+2RWyVNsx/3jMYivThnTyuXw3
 J8wSNyTQ3iqCqvm241qTFvqwmMEMrMUolll0MD0I92Kxl1hZ1zkUON4quzIdrRzJr0R0
 IUXDZy0HXw9JLRf24GJMCcHRW6YJTqgPMmT5uxwkcYr/w5E73pL10CZdl7/B+EbocpyI
 CZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139605; x=1741744405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+v51xfDzyLDQdhDH4NQnLLxRK59n+7mC2qFfSEYePA=;
 b=R8HvDKiDbuDMRyJib+fcHcTGGkegZbK6r0jRVLmkhmMGvmEoDhN3N4uURPVXJjrV8r
 gpY5G/LG6WYuH3NBhJHr39duN9JWYsBDV4t5enO/6CZpjUtYxf8oGSdLBJe2MFrpVjq0
 FCGcmLYTcoSkUGdEPh7jNMaVPWOnpMrWyLU0mtLQU0SkiNJXhio+GdurtSUJtU0CSvbC
 qQey5FD9Vai5XR6YxfqROPxD3QHbVwNFhWDa7HwlPr2n9cKVago6MvS1QJ1oJ7KMUx/D
 VX7iczxbyZ31+HqtdsXqn/EWJLiMfdLd9jNf9Ib7HARoAiFeKgIjh6w2RFbYdl8kDX9p
 caRA==
X-Gm-Message-State: AOJu0YxdgJsuOaot4QMNQXCIey0KNtweFLf17xAYATksDjN4u5f+8DKX
 MNwd2YXoF4Se/vru4EIXxoo5CgBIsSUMj5iQ6uOOgtgkkV/MNM5XvmyfdEqrS9Q=
X-Gm-Gg: ASbGncuE1Rr6xcDX6WEHijqeOxNWqWrKs4H9CZAccDZN6ej7lK37aQohJHrJem2hjwV
 SL6v1jWVG8K2lCkv7686TbkD0A/Pds+XHa0dj5E+etXK3UsSlhqm58Q/54TRcLDaxVpH5LH8gp5
 cVoH6XxN/PTSgY+Baad4lT6EHkz1rQ1NgNRCVvxo8Q+ORnUwVKoKpoX/9pJVxUyBAiI6VAAOpwy
 b6h8wa6NEYWPMB1ccLRO9qVwOUfgtzmC0xT6n6eAtvVGnlkvOtgn+BeZm7DdZPWi2kAoxkITXQq
 tp4gKVaAH1qCNveOUSE6gR0icHOX8fCNEPYpBRsmLNSu8lbrNkMCCteRDRLMCbFI/0gXPu62Ro0
 2QOnConBvRkmwWOPsyWki3q5kanTnKcp1F8b37YOTBhTi6y4n7u4=
X-Google-Smtp-Source: AGHT+IHLiR7SErwwawN0g7zitmlYgMDqDY4OdhZdebE62UqDn0dzwT37BfKoC4TeD0POqMtxPkwIQw==
X-Received: by 2002:a17:902:fc44:b0:220:ff3f:6cba with SMTP id
 d9443c01a7336-223f1d22362mr27671765ad.38.1741139605462; 
 Tue, 04 Mar 2025 17:53:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/59] target/riscv/csr.c: fix deadcode in aia_smode32()
Date: Wed,  5 Mar 2025 11:52:12 +1000
Message-ID: <20250305015307.1463560-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Coverity reported a DEADCODE ticket in this function, as follows:

 >>>>      CID 1590358:  Control flow issues  (DEADCODE)
 >>>>      Execution cannot reach this statement: "return ret;".
 > 380             return ret;
 > 381         }

The cause is that the 'if (ret != RISCV_EXCP_NONE)' conditional is
duplicated:

    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
    if (ret != RISCV_EXCP_NONE) {
        return ret;
    }

    if (ret != RISCV_EXCP_NONE) {
        return ret;
    }

Remove the duplication to fix the deadcode.

Resolves: Coverity CID 1590358
Fixes: dbcb6e1ccf ("target/riscv: Enable S*stateen bits for AIA")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250121184847.2109128-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 75f21ccabb..dc0a88a0f0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -376,10 +376,6 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
         return ret;
     }
 
-    if (ret != RISCV_EXCP_NONE) {
-        return ret;
-    }
-
     return smode32(env, csrno);
 }
 
-- 
2.48.1


