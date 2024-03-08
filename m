Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A28BC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiAg-0007UX-HU; Fri, 08 Mar 2024 16:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAW-0007S8-NX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:24 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAU-0001jp-Rv
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:20 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dd5df90170so15855565ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934856; x=1710539656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=Wd3VqQ0e7PrPfgtBdpY5hB3r6EhgPFN/6jLwRXKYgMyT6Gc/asaMqGkI0pDCdR1Enu
 HHKkfc/9PdLGiTXi+/sE8oCXBfqT6M+lr2XEJmHCbgRab4gpyz3EuyGE9W/RncHlHONP
 wzMW498ZkvuDFYlPhhlopzAAtMHsxZ2Xz6/aJitRcAJBzqoS+68tz4P6uAmeFA2cO/au
 TcDPcazWVjj6rpPOMCLbUa65M6tG6xA/1FBUFE9omUQKYzIpLT9N/6vJibr+upw35GJ+
 UTT13KUWEKA1NbkSTPM+Jz66LVvJEdcfqwKR3MHD9DmIErrG07YmOXOCt4Sar4yAqOC5
 7SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934856; x=1710539656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=KfJMDqvJ6SdJL/gBU/pxGIBS4d9M1vZGW5/fdMlVvM1cUO5hxqreI5lDo9SN3yYdyJ
 JjqGm0trZ+yuB82n42CVx9qw9UwZpcd+vElNUJV/oa8chgUngGGdf+GyWPHde40kaGzd
 aA3KsaPlO5+ka7IHzG8Kz+jTeZy9t+I0jGHURvQXw66W8pGhSRwvpRIme55s1iO/BQFw
 L7AgOpS3HnnS+fTrIO6lDIlifk1iFIG3xfM9K/sJSihoW1EITuevy38ts52BdaheUd4m
 8VkQPs5qmPVs3v+RBUQ3IlJfh69XmAGW1tlviLyPY2TiOMptnzLBehViWitHUM+RzLzc
 NWyg==
X-Gm-Message-State: AOJu0YxeGfExep2GBgWJxLWs0YaRy/7c5MBS/WcrQy7WeDn7i3Kai+l3
 xT8xzXNlK8hwLykXTVpV2qATVmRzdJ9qfisBnJ6UgRP7q1Wm6GTYt4jXLqbp1UGcPFojqMbexdH
 Z
X-Google-Smtp-Source: AGHT+IFzqmMvGQlwLQ4IpczoMUu1MmQuyHic9I6riTVOWmCkgC0dMK1/r11Dw+oHDHI7lfBUOXr87A==
X-Received: by 2002:a17:902:c7ca:b0:1dc:c161:bce6 with SMTP id
 r10-20020a170902c7ca00b001dcc161bce6mr1617251pla.15.1709934856505; 
 Fri, 08 Mar 2024 13:54:16 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 01/10] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Fri,  8 Mar 2024 18:53:41 -0300
Message-ID: <20240308215402.117405-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe56c007d5..ca79571ae2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


