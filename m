Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B075E6C5F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJjq-0007u0-HD; Mon, 02 Dec 2024 22:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjn-0007tB-Nl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:12 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjl-0005Y8-PO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:11 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-214d1c6d724so39179435ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733197088; x=1733801888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRHaR9pcBAF9H3M4At6noJSbZrF61K68F3kyhCd72IY=;
 b=h/QnCGqbZ4ThoW7K1Nl8vT60WyNjUJEjg+/j7OP8v+mLNxpNcTOrGNEovcAnB7tk+W
 yislWyPpL59anIJU/GNw+i4CWYe38+MVHJ+7C5MoMxk5L8K9B3XzsbFv2GKhGenk5zm/
 bOEtlHh5ByzqqELfCFgpMDDpWwbs2ApnkcTE0W9fKorRt9X0lngNvTBzkwaLhAMnTcBD
 Av+QjUV1WU4AOcJMMPZ2sRHkOzbGHNYBhqdRcpGrY4UPgR/qCEn5M96znEuzNYYQfT8N
 p0dpYCvJdMSFYCxvamKR+0iCP7oNvIK7tcesO0HWNSWh0npjkUvBxkVFWb5l7pjsfFCp
 Zsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197088; x=1733801888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRHaR9pcBAF9H3M4At6noJSbZrF61K68F3kyhCd72IY=;
 b=ID21AnFdAwf04tG7llaznzD3dFhrNuqRyyBdoild2x2h7MGFIE8p50X5S3TD/FLma2
 7QF3a1L4Mt+ZNqHzEoiVgebaZze/7YdGgCZtShuSGW8sDX41DXEciNXQsfau+E4Pawh/
 HyYbYET/3cFmvIahCLPTiwV2ovUG+71R2AcWK1ept5IfhQsgU1Kq4VDp5doiwuBT1lPq
 JUKzqs0HWFnZS3BCYK7C9Oza2s3Zoj7RF2RkMrSlFZKGqcvOp5w3YhtAulkiKoYVhQoS
 4MG4Npsbcj912cDDZSwU+ZDLnJ2IZ3KL6tmzL6LaqVewHndzMO0yXyWapqq1RWDQ21Hb
 LLnA==
X-Gm-Message-State: AOJu0YwtycgCefydA0AIEO2QcydMmDc2SC9oeamRpvz7RWtZDf8uMKo3
 ySjf1EnWJs0vE5jSig0z5jEubXPBsyvth8L/vz1aa2fzoXFcGP7tJYbxcNcZkOGeYdYQ/TgRqyW
 Ui8+Fq9lDMLRsWPYGI/HFuB+1L6cluToiuG5HkxUZ18HHoyJRkhcq79aqs6vHsYKgEZ9n8cf3CP
 P0yS9JVmvnWBLAZZispiGm9CT0950wsgMtMsHK5A==
X-Gm-Gg: ASbGncuK2qjQMGqHgAKSQH/6NAGK3DGwaUC5fUc+IBnfSgHeDLkag3noj2nJaxXICQn
 cPw0oXb7CS+BxXw3fbeBT8i4zeYTRH1/pVbnSV9N22WTFLKi/HRyVLBYI/jIzzL4k0//kFCCXks
 x4JgXJn2q1UgKC7Qk8LdRdUnlKPqInLOS6G9FeWctDpgumFixlGn0kQXXxE0umAs7Guv9AZAzXA
 ZcLfH0xfCVghhXnsxeDMGjGQzPLgKLHftE45iVapaN+inIJagYAk6OIiVeioiuYgv0GoctnyNcg
 x+d3hnyT
X-Google-Smtp-Source: AGHT+IEXojA/sOEDHW1MM7Nmm2rTZq6wRWPJN6Ug3GKxIkgNleZTZey3K35LdsgOa+hNLhFLHeH1Hw==
X-Received: by 2002:a17:902:e747:b0:215:6afb:5b24 with SMTP id
 d9443c01a7336-215bd174cabmr11952405ad.48.1733197087714; 
 Mon, 02 Dec 2024 19:38:07 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21566732e1fsm47111135ad.134.2024.12.02.19.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 19:38:07 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v5 1/6] target/riscv: Add svukte extension capability variable
Date: Tue,  3 Dec 2024 11:49:27 +0800
Message-Id: <20241203034932.25185-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203034932.25185-1-fea.wang@sifive.com>
References: <20241203034932.25185-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..d8771ca641 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_svvptc;
+    bool ext_svukte;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.34.1


