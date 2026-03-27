Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A60810ED67F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68Gz-0002my-Hy; Fri, 27 Mar 2026 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1w68Gw-0002mp-MA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:34:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1w68Gu-00024r-Sx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:34:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b949bf4easo1287100f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1774622086; x=1775226886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QJcL6p7alzRTJ3dPJyskl2pWpoSpOzUzdB70X70o3z8=;
 b=q20ZfF7iw1fE7hSrm+DGEOb34HsKi/5MuVZwAlwNFsyMEQwWrx+Hpl72Us3Tb41nsG
 6T41Rt7+sme/UGyayGoNQXllTfYmqrA11NrVMoyoEAKo3R/bWbKuL930b7Ad7I2KlLEo
 bQjsMOPtijytRnFnwPuzZ+rC8vcZktCDFbkeVBhOLVZSxiKjsvY7o/ZevgzwXscwdhd1
 xdOIH6789eym8KZ1cMdXiv7Jd+E1qVNXVy0DR4CUIbfylggsK6EM3QJydLQV6WT9TY49
 ECKOwCBMYygdYfzsxIG9fH3mMTgPZWMadKSdVwE2ifVhwaY45Z6nWzmFHY/a56p+ZZW2
 28hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774622086; x=1775226886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJcL6p7alzRTJ3dPJyskl2pWpoSpOzUzdB70X70o3z8=;
 b=NwMWgsSoB9dH+nPOfFfSFAyjSrBgWbDbbgTFOq6c7yeaLe2LdWhn1HTJlHKxYZS5oG
 666O4vCBY+XUcpRzRw8Z7IAnxFpYDVKcpJFTszCXd4xDjZy8gcLjq7eZ5KgH5y4srBsB
 EsAG4hdUZNFKm3duKD+RZD0gFnD7cEWA1Gvu7LPCB62cuxvHw7pU1XJaHmj4vcxOP445
 c7o2/6Sj4oD9sFKYqCehz8hGzX7gnQTTrhXZgZ4OW6dF7hGgfBZ+M+hRSa8qEPxDsfJ1
 /ZYluZGbV2CbZzNbr82TCWu9zGtLhXr6eEeDzU5M5DwsZP73QNv3Fvp4pTmLubmt6oKR
 P7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWbR89nvMQAPiIbIrj8+3jmgOfuMPKVNd1kV6FQQWTmHBvu6EeVgBQ30jZACK/EIR2LKX9a08+GHA9@nongnu.org
X-Gm-Message-State: AOJu0Ywt5ZPHRJqXL6INdrbMHimqHC5lpd7n1KAS0gkwhkHZYqXL92o3
 SeA0jXT225ZjsT63J0YZj0mR0fn38+kjHpBynyRtGrLvrr1IxFnh74Y9BDLB2ID0C2g=
X-Gm-Gg: ATEYQzyLAnOagZZpBSIVUYsUoksfhQ2+q+GbRTehax0UD/6SnX0u06BuRUSyAj4dflv
 9LRFZNoG1oIm2U/aDOuBCv0ZM4KBnpUVUGh8e/FkLw37q2YWZp/Bz27M6SpAV5ch7GLzTNR+llk
 GAZQi9jDr9oCvv3Q4Rc7wu7hgLpeteO4ciBgAE+HrymdbWo7z+Fz6Yf8KPmnlOFOVMnz4KOILeX
 T1IHNOIW8dWXtcCquIgM1WBC61oo84tUrLj8aqpiZCA0kjkIlurxtNxIBfqWnjTcYZ3MDN3f1wK
 55mJLW6VCTdjrBIFYseAvUwcjtseZ3xbLxoCO99Nw8ZhPMGNruqYNrKdzXLt23iJguZ+ko9tJDX
 m5LfVjgluxyjp3QQOdvctZyvtIyys5wRT2A/+CehyU7PHIhJzNhdr5RdbRt0VdxCBrozw/Zf68c
 ltjcQPKrH2hjs6XekVo1TMp7ialJxidaowf3nzMDeUECNz4Ns3UolDE1GjS4Y+9DpPLHsHkyFiq
 SujwRoC96Qox3e50A==
X-Received: by 2002:a05:6000:2409:b0:43b:4703:9dd5 with SMTP id
 ffacd0b85a97d-43b9eb10cbcmr4414844f8f.18.1774622085454; 
 Fri, 27 Mar 2026 07:34:45 -0700 (PDT)
Received: from nuc.fritz.box
 (p200300faaf260200b5bd0daccf856f73.dip0.t-ipconnect.de.
 [2003:fa:af26:200:b5bd:dac:cf85:6f73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2c8sm14563154f8f.20.2026.03.27.07.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 07:34:44 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] gdbstub: Update x86 control register bits
Date: Fri, 27 Mar 2026 15:34:13 +0100
Message-ID: <20260327143413.254227-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The control register bits haven't been updated in a few years, making
them lack behind features QEMU ganied in these years.

Update them to the current version of the SDM and sort the 32bit version
to be in line with all the other definitions (descending order).

This should remove confusion when debugging, for example, CET-enabled
guests:

- before the change:
  (gdb) info registers cr4
  cr4            0x8000f0            [ PGE MCE PAE PSE ]

- after the change:
  (gdb) info registers cr4
  cr4            0x8000f0            [ CET PGE MCE PAE PSE ]

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 gdbstub/gdb-xml/i386-32bit.xml | 47 +++++++++++++++++++---------------
 gdbstub/gdb-xml/i386-64bit.xml |  7 +++++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/gdbstub/gdb-xml/i386-32bit.xml b/gdbstub/gdb-xml/i386-32bit.xml
index 7a66a02b67e3..1dec40e1d2c1 100644
--- a/gdbstub/gdb-xml/i386-32bit.xml
+++ b/gdbstub/gdb-xml/i386-32bit.xml
@@ -87,27 +87,34 @@
   </flags>
 
   <flags id="i386_cr4" size="4">
-	<field name="VME" start="0" end="0"/>
-	<field name="PVI" start="1" end="1"/>
-	<field name="TSD" start="2" end="2"/>
-	<field name="DE" start="3" end="3"/>
-	<field name="PSE" start="4" end="4"/>
-	<field name="PAE" start="5" end="5"/>
-	<field name="MCE" start="6" end="6"/>
-	<field name="PGE" start="7" end="7"/>
-	<field name="PCE" start="8" end="8"/>
-	<field name="OSFXSR" start="9" end="9"/>
-	<field name="OSXMMEXCPT" start="10" end="10"/>
-	<field name="UMIP" start="11" end="11"/>
-	<field name="LA57" start="12" end="12"/>
-	<field name="VMXE" start="13" end="13"/>
-	<field name="SMXE" start="14" end="14"/>
-	<field name="FSGSBASE" start="16" end="16"/>
-	<field name="PCIDE" start="17" end="17"/>
-	<field name="OSXSAVE" start="18" end="18"/>
-	<field name="SMEP" start="20" end="20"/>
+	<field name="LAM_SUP" start="28" end="28"/>
+	<field name="LASS" start="27" end="27"/>
+	<field name="UINTR" start="25" end="25"/>
+	<field name="PKS" start="24" end="24"/>
+	<field name="CET" start="23" end="23"/>
+	<field name="PKE" start="22" end="22"/>
+	<field name="PKE" start="22" end="22"/>
 	<field name="SMAP" start="21" end="21"/>
-	<field name="PKE" start="22" end="22"/>
+	<field name="SMEP" start="20" end="20"/>
+	<field name="KL" start="19" end="19"/>
+	<field name="OSXSAVE" start="18" end="18"/>
+	<field name="PCIDE" start="17" end="17"/>
+	<field name="FSGSBASE" start="16" end="16"/>
+	<field name="SMXE" start="14" end="14"/>
+	<field name="VMXE" start="13" end="13"/>
+	<field name="LA57" start="12" end="12"/>
+	<field name="UMIP" start="11" end="11"/>
+	<field name="OSXMMEXCPT" start="10" end="10"/>
+	<field name="OSFXSR" start="9" end="9"/>
+	<field name="PCE" start="8" end="8"/>
+	<field name="PGE" start="7" end="7"/>
+	<field name="MCE" start="6" end="6"/>
+	<field name="PAE" start="5" end="5"/>
+	<field name="PSE" start="4" end="4"/>
+	<field name="DE" start="3" end="3"/>
+	<field name="TSD" start="2" end="2"/>
+	<field name="PVI" start="1" end="1"/>
+	<field name="VME" start="0" end="0"/>
   </flags>
 
   <flags id="i386_efer" size="4">
diff --git a/gdbstub/gdb-xml/i386-64bit.xml b/gdbstub/gdb-xml/i386-64bit.xml
index 6d889692114d..9ac9164e6a99 100644
--- a/gdbstub/gdb-xml/i386-64bit.xml
+++ b/gdbstub/gdb-xml/i386-64bit.xml
@@ -102,9 +102,16 @@
   </flags>
 
   <flags id="x64_cr4" size="8">
+	<field name="FRED" start="32" end="32"/>
+	<field name="LAM_SUP" start="28" end="28"/>
+	<field name="LASS" start="27" end="27"/>
+	<field name="UINTR" start="25" end="25"/>
+	<field name="PKS" start="24" end="24"/>
+	<field name="CET" start="23" end="23"/>
 	<field name="PKE" start="22" end="22"/>
 	<field name="SMAP" start="21" end="21"/>
 	<field name="SMEP" start="20" end="20"/>
+	<field name="KL" start="19" end="19"/>
 	<field name="OSXSAVE" start="18" end="18"/>
 	<field name="PCIDE" start="17" end="17"/>
 	<field name="FSGSBASE" start="16" end="16"/>
-- 
2.53.0


