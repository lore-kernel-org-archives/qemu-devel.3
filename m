Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F239D11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krI-00062l-4s; Sun, 03 Nov 2024 19:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqw-0005MI-VN; Sun, 03 Nov 2024 19:21:58 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqu-0002jE-Ox; Sun, 03 Nov 2024 19:21:54 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e7086c231so3039691b3a.0; 
 Sun, 03 Nov 2024 16:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679711; x=1731284511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diqtDboffH4PVwPLiDsjTddqv3X52rB5uwdlE74AvHo=;
 b=PehCk+KKU6/ry3dOTUKmJIgerpxofXRsiXpIIz7fWMOvUfmbng8Xu1z8n+quFQYeSB
 5H6w97/HbqdI/RZb9PntCTe8PUxLwRi30mHnUEPOGSUtYgVlU2LPK5HI/7YXT7CeLGxq
 A+2RRoAI5Y2p+n61xZu/XPg+L+gJUUSL2edILQ4Ai2jAjHugwMcYH/xEH0RA9EeY8NP/
 l/Dz/s9kLUETZdJTNgcZ0e+1OzRm9q2A4vyn1BWRDtswQHx+r/Pb6YMIfRch+VeQKzss
 iKN6JY47CPfZlaa9H8DCc0ZuJSfliCuTHG4Wu0VEHYUHFnLtAkk+0Sx3J/xSH3O0/A4o
 wI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679711; x=1731284511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diqtDboffH4PVwPLiDsjTddqv3X52rB5uwdlE74AvHo=;
 b=VB91vxd3LIvi1on2FgSHsqehpd0hDYE0AgyjFD8cZltVs5puRJe5GcgFZWHz+HUekw
 B07JCtpAtrQl9GuQAAzASl6mVSjTEuK14/D8K8rHKkDRfnsrn5sYhTqAPdOhRlQDtWJd
 IFdiED0FEH9zNAyJM98ax3xSevwA6XRPHT+25fpXJTT7sof9au2g6qZPCz4scSvPjUg/
 DMozsU6/MbLmm857zIxIH1l4yTrz44hHjJSpUAQefXgOWm1HgOda5WEj3q+7DiURwHH3
 4usb9WVwN1DjQl2KKa49TBGYh7t4H8M1W7C4VtJlu63ybIE6ZX+1iEMkbSifXiUQwy0x
 /JfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSZVM9z7SOzVK4UGm8ZVE5tO3h9vSHDdhqcqnyoyWLlnP22FT5m1hGyboQ0oUmVhTTnJ3vLOmyfw==@nongnu.org
X-Gm-Message-State: AOJu0YxK4f9zHtLamK1Bha9FIM4M7S7Xe1PEsE/GjqdCz4KsyxOT0C8l
 1y7RtFQQ7RPGVjByR0KaOQr5ITwlPWSdtH1RfasQ32k6mLHtAkOyrBoM8Q==
X-Google-Smtp-Source: AGHT+IFVRfln4oS+AzrD3B9yMKo0hefucZqEgXWtwrgvrXVY7mg1+C6OOENuBPB47eavqGYpI0dhug==
X-Received: by 2002:a05:6a00:80c:b0:71e:5d1d:1aa0 with SMTP id
 d2e1a72fcca58-72062f4e529mr41653388b3a.6.1730679710652; 
 Sun, 03 Nov 2024 16:21:50 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:50 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 44/67] spapr: nested: Add support for DPDES SPR in GSB for TCG
 L0
Date: Mon,  4 Nov 2024 10:18:33 +1000
Message-ID: <20241104001900.682660-45-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

The DPDES support for doorbell emulation and handling for KVM on PAPR
guests was added in Linux via [1]. Subsequently, a new GSB (Guest State
Buffer) element for DPDES was added in Linux; the same has been missing
in TCG L0 implementation. Add support for DPDES register's APIv2 GSB
element and required handling in `spapr_nested.c`.

Currently, booting a KVM guest inside a QEMU TCG guest fails with the
following crash. The crash occurs while handling the GUEST_RUN_VCPU
hcall made in TCG L0. In the hcall handling path, map_and_getset_state()
calls getset_state(), which, in turn, calls guest_state_request_check()
to validate the GSR (Guest State Request) elements. During this process,
guest_state_request_check() iterates over the GSR elements and receives
a NULL return code from guest_state_element_type_find() for the type
variable corresponding to the DPDES register's elemetn ID (which was
unknown to TCG L0). Subsequently, getset_state() returns H_P3,
ultimately leading to the hcall failure and causing the KVM guest to
crash.

  KVM: unknown exit, hardware reason ffffffffffffffea
  [ ... KVM register dump ... ]

Fix this by adding the required support in TCG L0 implementation of
APIv2.

[1] https://lore.kernel.org/all/20240605113913.83715-1-gautam@linux.ibm.com/

Fixes: 4a575f9a0567 ("spapr: nested: Initialize the GSB elements lookup table.")
Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_nested.c         | 1 +
 include/hw/ppc/spapr_nested.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index c02785756c..1b41c8fb8b 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -982,6 +982,7 @@ struct guest_state_element_type guest_state_element_types[] = {
     GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_FSCR,  fscr),
     GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PSPB,   pspb),
     GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CTRL,  ctrl),
+    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DPDES, dpdes),
     GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_VRSAVE, vrsave),
     GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DAR,   dar),
     GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_DSISR,  dsisr),
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 93ef14adcc..3b5cd993c2 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -99,7 +99,8 @@
 #define GSB_VCPU_SPR_HASHKEYR   0x1050
 #define GSB_VCPU_SPR_HASHPKEYR  0x1051
 #define GSB_VCPU_SPR_CTRL       0x1052
-                    /* RESERVED 0x1053 - 0x1FFF */
+#define GSB_VCPU_SPR_DPDES      0x1053
+                    /* RESERVED 0x1054 - 0x1FFF */
 #define GSB_VCPU_SPR_CR         0x2000
 #define GSB_VCPU_SPR_PIDR       0x2001
 #define GSB_VCPU_SPR_DSISR      0x2002
-- 
2.45.2


