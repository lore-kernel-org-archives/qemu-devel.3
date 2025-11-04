Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB80CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 22:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGPTX-0005BH-4b; Tue, 04 Nov 2025 17:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGPTS-0005Ad-Ca
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:25:58 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGPTQ-0002iH-Sy
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:25:58 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-4330fc37de7so17928615ab.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 14:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762295155; x=1762899955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9u9MY3wg/+9kilol1VjbDlpWswXgOAETWko5ZvhjDg=;
 b=eVRHh9aokcuKvIAJyN7xGLvpq3e1OiOZQqNhVDWtDUG6HEXH/OFeL8r4RBIH4A7rNP
 8ywGOaQYibgTDKuYw+hY7sDmTFjgNGoeaMb0XXuCX7QM2l5h5Je2GXUXWZ58Kddk4QDl
 +7YmmALbxWukI8c4ArcMiwqrLmB0Q4258h5JtW4gs+Y9uqZD3OTtYh7h9OX50fWj3sjR
 Vba/plejVQ4b65nTSq2mxW7FTTciql4NJ6HFIoyJJv/yaBWQpqmSCXEu3MRg/3dtEYHa
 igQWm4Smg3Md6qn/fDr4oiEBSL9Ir3DAGJq06WVAvBmGMxv9HKCSnIpguzZsak/+7uIk
 s+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762295155; x=1762899955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9u9MY3wg/+9kilol1VjbDlpWswXgOAETWko5ZvhjDg=;
 b=K/sj1lbeFErIDAWkeBAICY7qAjyrjyi+q87macJQeavm91YlVAU0JmdjOGHyCzDuag
 wAnkvXj/o36KPwNorJ0ft/AhFAHQxM4UqrRO3NMMh8FMtEj1YmSnQKT1yib6sKYu6Zy2
 7q0RVeaXH4YVyv6JC75UmEDlG08RHkNdFNm7pQyqfx5kqb1BRZ50BVKdMx4ssUMDJ1Th
 086mb6z+rrI0sw+a5X57kVb7fjrqccuzi4cDiJTkKX7nko/Bbook+HUjyGsH7GdoZis5
 lS6IuT6LnrxbXw16/g7Fk4td8rxTSuXumDt6b3/9b2noep8tzFpAV5PrxnqsRS+/UvmB
 U6/Q==
X-Gm-Message-State: AOJu0YyrCQ2F+x+tKH6vvtv8LTIE7LQi8fGyTi2HlwPkGOtKVWi6w6bb
 p/nf4jdb3UBNyHrpYgAnz/gB85zKbxe3siLssGHnPPgnDweMC5JTPTp1uKHEzcax3B4=
X-Gm-Gg: ASbGncv70qDmfRfcxa33oPP62TEdjNY7ZL2NhwVLhfg8TKkz1G38vsdhMibKuuQyVau
 6o1WBcylRVr+7Rpn29o3brOc/pslx5SpMeqEcP+Qf9XjRuEKXBHXo0ARm9tZYXJvwvmlUxl2wFm
 OyPpYd4rUdY45oPxksXQJzNE5+jiSBlJv2K6kfzXDMfD44izpzyjTVF+cvFA4tLD2baCSCPupw+
 6V/gA2lOWLVBz7znwkPy564n/KwxLH/mKKxF2qmpUjGznahsaXrXBdgmdbvQbahftckg7LAU4+z
 zm6xNRFMFtQSfpUF13Any6HgK0zn/YxdvQ9S5eLoTm3/ycePs7MBgRpKpH4TkfQdQ1pvxS+F4c4
 RoI6fqJajsk+Wq4QKURFCKL2sXc0ys4rxwTrZXR5e49VOzoFra0dvAyVos9wWSAFt8+QEbT7H53
 WyOxfckUsKHWhM/V95MelBhQQKSAkuTClCPXOuUb2URQN7wXjinnowQWNsWq3OTvb1BA==
X-Google-Smtp-Source: AGHT+IHbazbxN1fpeTYkHEqrPMpQr24Pb0K3gUxAm27ST3l3sAYV0K5nXp8f/HoBCo/ou0uj7wI2Ow==
X-Received: by 2002:a05:6e02:160a:b0:431:d8ce:fa1d with SMTP id
 e9e14a558f8ab-4334076997fmr15776055ab.4.1762295154986; 
 Tue, 04 Nov 2025 14:25:54 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7224a84c3sm1755789173.0.2025.11.04.14.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:25:53 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 3/3] Hexagon (tests/tcg/hexagon) Add test for USR changes
 in packet
Date: Tue,  4 Nov 2025 15:25:48 -0700
Message-ID: <20251104222548.108264-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104222548.108264-1-ltaylorsimpson@gmail.com>
References: <20251104222548.108264-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x129.google.com
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/usr.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c
index f0b23d312b..8becd8195d 100644
--- a/tests/tcg/hexagon/usr.c
+++ b/tests/tcg/hexagon/usr.c
@@ -608,6 +608,30 @@ TEST_CMP_xx(uint32_t, uint32_t, FUNC, SRC1, SRC2, RES, USR_RES)
 #define TEST_CMP_PP(FUNC, SRC1, SRC2, RES, USR_RES) \
 TEST_CMP_xx(uint64_t, uint64_t, FUNC, SRC1, SRC2, RES, USR_RES)
 
+static void test_usr_packets(void)
+{
+    uint32_t usr;
+    /* Test setting USR bits inside and outside packets */
+    asm(CLEAR_USRBITS \
+        "r10 = satub(%1)              /* Set usr.OVF */\n\t"
+        "{\n\t"
+        "    r11 = convert_uw2sf(%4)  /* Set usr.FPINPF */\n\t"
+        "    r10 = memw(%5)           /* Force pkt commit */\n\t"
+        "}\n\t"
+        "{\n\t"
+        "    r11 = sfadd(%2, %3)      /* Set usr.FPINVF */\n\t"
+        "    r10 = add(r10, #1)       /* Doesn't force pkt commit */\n\t"
+        "}\n\t"
+        "%0 = usr\n\t"
+        : "=r"(usr)
+        : "r"(0xfff),
+          "r"(SF_one), "r"(SF_SNaN),
+          "r"(0x010020a5),
+          "m"(err)
+        : "r2", "r10", "r11", "usr");
+    check32(usr & 0x3f, USR_OVF | USR_FPINVF | USR_FPINPF);
+}
+
 int main()
 {
     TEST_R_OP_R(satub,       0,         0,         USR_CLEAR);
@@ -1097,6 +1121,8 @@ int main()
     TEST_Rp_OP_R(sfinvsqrta, SF_small_neg,  SF_HEX_NaN,       0x00, USR_FPINVF);
     TEST_Rp_OP_R(sfinvsqrta, SF_SNaN,       SF_HEX_NaN,       0x00, USR_FPINVF);
 
+    test_usr_packets();
+
     puts(err ? "FAIL" : "PASS");
     return err;
 }
-- 
2.43.0


