Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A871FC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxH-0001fq-Rb; Tue, 04 Mar 2025 20:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxF-0001ev-U4
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:50 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxB-0008OZ-4j
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:49 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-219f8263ae0so117542495ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139623; x=1741744423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8N6MEGFDIHjOSuYNMKKhiEimg5+OYRGOfgpJpZgUeDw=;
 b=BeENMTw26zP9TEnmRcwBufwB+uIn5iRLHSN6fUjV8FmzdmXtpB+4Z7wH3Aw/heb5rd
 Fz79m+b1vS9et+5o95/Wzu4QeSKh0jUXUED3eH2vIgHC5WyMTUavAv6iSeoRJ+N0sD9d
 WFOMQe7DL8Wr9jb0N1KYQ7dq4Jid6n8nDAe8uPK0URGOcEW0EQiCDL8oDc29AEbh4DjB
 YirrPQDYmgd0qjZUluOAFrRA5sdZrFHtA69mpHBeL7girP1tsFiiDN/q+EZ11tjjH7l2
 a3Bu/ViM1k14hVtSdwBVNLpJiQj+9Y6dMQTOr+useZxrLQQy0GGbZJVk/2Nbmmz8TbNf
 Z3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139623; x=1741744423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8N6MEGFDIHjOSuYNMKKhiEimg5+OYRGOfgpJpZgUeDw=;
 b=vj1CoaD5X2P/fR+Awh2gkKD8NcKvz31Lxdeh1PRbEC3GxxJQ+SgkuHmbEyXUze75wc
 exn6UOXuPJ+3HfA4lO96VdJSOUlBPaZJ8LqLUg6vAKpY0ER9PB4Bgk7Vn1fjairQZGeh
 snkBChKYiZ6viZWBGd+MZh3zWc7UJx+3HibJpJ4wUVnkwjFrGrlq3uLCg5QFL0pggAeJ
 sPW8RN6LaaA1+zI02tiwjlk6TggBajYcXhtKbMn5Ho0WN9SxmRciCmyOx4FXWUSI2823
 pecnrbY7swHqvNykPERLFgTPSElEt8kWxGc4B9H1VYgehci7I0ZzhYKvMLnbGziliq7+
 Fx5w==
X-Gm-Message-State: AOJu0Yy+MSR6nHMMW+BaK2F2vEfKln2JJ7wnF6DvIlFEbINCvdjcmlNe
 Nsw+9vkkO+0AIKu1eg9M1XUUoQEzoPl931KlTYOozymNpDFhDDyy6YheQcwA6DU=
X-Gm-Gg: ASbGncunKrKb6GmgtAaqWFi4VMJG2HDKIhrX54THm+9fZck7+fxJ+PQ5NjUPDo+t7Ex
 3TkgdFhO3+0L7g26v2jhJB/ucsVblXFi5OhnCoHwAuf0yKZZkNGxtEszzjKCt6H5TMlsgKsbDZG
 B/utOmcYQFtFAvxgmJM/zcToKMgY0Lvo8zklmK51Byi4kXjBj3lCaJy+ANiyby2h0axU8nlEAsT
 Qct6gJlz4iWDdpPUPB3CB6WoYpuFcTWJyz9DE2hznTDkDUV94YcvajQExZgwVflphs8fYvAN4+P
 7JYMv4PYISSbHjfIl4jjcoIF5sXbeTb6oTfwulz+SpRaqz1lvQ6NHWPKtXqusEk5ukhVv1cEDor
 VJv21FBp4yxaVXDOxTsG2gp93SeU+SSY2l1AYSonQqUq6f/+rMyA=
X-Google-Smtp-Source: AGHT+IFhg9gJdCmhmF4iS6fYMfgWgp1f6Cun7TOiUkixcL656S4wJAzRS4YNaxU4oIndhgTQ4lDg5g==
X-Received: by 2002:a17:903:1c3:b0:223:50f0:b97 with SMTP id
 d9443c01a7336-223f1d20df7mr16418535ad.52.1741139623420; 
 Tue, 04 Mar 2025 17:53:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Huang Borong <huangborong@bosc.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/59] hw/intc/riscv_aplic: Remove redundant "hart_idx" masking
Date: Wed,  5 Mar 2025 11:52:18 +1000
Message-ID: <20250305015307.1463560-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

From: Huang Borong <huangborong@bosc.ac.cn>

Remove the redundant masking of "hart_idx", as the same operation is
performed later during address calculation.

This change impacts the "hart_idx" value in the final qemu_log_mask()
call. The original "hart_idx" parameter should be used for logging to
ensure accuracy, rather than the masked value.

Signed-off-by: Huang Borong <huangborong@bosc.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250115035105.19600-1-huangborong@bosc.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4866649115..0974c6a5db 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -421,7 +421,6 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
             APLIC_xMSICFGADDRH_HHXW_MASK;
 
     group_idx = hart_idx >> lhxw;
-    hart_idx &= APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw);
 
     addr = msicfgaddr;
     addr |= ((uint64_t)(msicfgaddrH & APLIC_xMSICFGADDRH_BAPPN_MASK)) << 32;
-- 
2.48.1


