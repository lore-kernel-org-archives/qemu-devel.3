Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2262CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 04:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUfgw-0003nu-FC; Fri, 19 Jul 2024 00:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sUfgv-0003mr-0p
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:58:01 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sUfgs-00082r-HW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:58:00 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-70b31272a04so343006b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 21:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721365076; x=1721969876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zPRBGV/CuDOGRpqBmJ8kDagq4x/fn1n7dozwqcVZQds=;
 b=L4ytQxK7FvQMLsEG/wUGGEcuEpPJglVNZ2eTCB9lK3R0zePfjWTc69QTqipXSGvJND
 q6WKw54MaK9dIBWM8ya15ybhNsbgYG2wJ7/7SSmvujH4SH2+tDvBB96AMmhmRdhYDA9l
 N7mpQcRtXLlVNA/z8n8u53WPodq2cz8630TcqPky+J0Gkje7GDrMaghF3vv/tRrMlCUK
 ivzgqsd4HHqL+SlgMNZ+rIAIvSZgTcxlW7QBmHbgfQRolA2poyi4o7l/3b8bU8RJjG2y
 F0TGecQYVYefmVRksSfVk04VM85Qu0ukQIuL1QEZ0k3PNntA8acPbAFQoTNAPXIzVtvo
 LE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721365076; x=1721969876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPRBGV/CuDOGRpqBmJ8kDagq4x/fn1n7dozwqcVZQds=;
 b=HywkHouCNLOPAKf2x6gkrgfdaEYwCBYTKchvMYQW6zRCoEcYGrc3SDInYNvSjEYj5c
 k9setCl+V2ucakn1KoAtO4bzNNVhyRSsq1g/E6ZPFF/C76C4B6+vN/6oVGubbTFSBVHW
 wfTMa7Uegyy2pLxhlDs0nBr0zSDPid079IuJwlZXkMIcbUgH1/3cuSENyFIXq/OJcspI
 gmcTr04z6uDkJuwpyuSd/HA8RrMq3YqIgXHwc8FYlW7ohHO/q+eAdQqop7KTUovq5iXD
 vM3tSKdsjuEBAFyc02SQfXWriNsxkRK2vAp6JvpsgL+soY+XpWFfPnXPhu9ZCVdsToS9
 lFKA==
X-Gm-Message-State: AOJu0YwnMwbjNWj5jXWqZYfkSCKQIHjTGIXB1cYPlbyUvfVCO0SH76Y5
 V1D+Volt1pM6fpRZjaGTtoTo4jA1jNHR0S1TtWK9toZd640fz2sHSxsAiick
X-Google-Smtp-Source: AGHT+IFOrqX+6QVZZghTxtL0gduGv5mg3MYrQrGCl4VA4cMz/WCFJbodY8jQYsckH5NWJdjrORWzZg==
X-Received: by 2002:aa7:8895:0:b0:706:738b:2c3 with SMTP id
 d2e1a72fcca58-70cfd78cc1cmr2351489b3a.2.1721365076223; 
 Thu, 18 Jul 2024 21:57:56 -0700 (PDT)
Received: from localhost.localdomain ([223.104.132.29])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff49141dsm387184b3a.44.2024.07.18.21.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 21:57:55 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: qemu-devel@nongnu.org
Cc: luzhixing12345 <luzhixing12345@gmail.com>
Subject: [PATCH] docs: add more information about CXL2.0 device type
Date: Fri, 19 Jul 2024 12:57:33 +0800
Message-Id: <20240719045733.26021-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luzhixing12345@gmail.com; helo=mail-pf1-x441.google.com
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

Add more information with CXL type1 and type2 devices.

Original doc says "May also have device private memory accessible 
via means such as PCI memory reads and writes to BARs.", but actually
CXL type1 devices doesn't have device memory.

Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
---
 docs/system/devices/cxl.rst | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 882b036f5e..ee50a3c18d 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -46,20 +46,14 @@ CXL 2.0 Device Types
 --------------------
 CXL 2.0 End Points are often categorized into three types.
 
-**Type 1:** These support coherent caching of host memory.  Example might
-be a crypto accelerators.  May also have device private memory accessible
-via means such as PCI memory reads and writes to BARs.
+**Type 1: Accelerators without device memory**. These support coherent caching of host memory. Example might be a crypto accelerators or smart NICs that use coherency semantics along with PCIe-style DMA transfers. Type1 devices implement a fully coherent cache but no host-managed device memory.
 
-**Type 2:** These support coherent caching of host memory and host
-managed device memory (HDM) for which the coherency protocol is managed
-by the host. This is a complex topic, so for more information on CXL
-coherency see the CXL 2.0 specification.
+**Type 2: Accelerators with device memory**. These support coherent caching of host memory and host managed device memory (HDM) for which the coherency protocol is managed by the host. Type 2 devices are accelerators such as GP-GPUs and FPGAs with device memory that can be mapped in part to the cacheable system memory. These devices also cache system memory for processing.
 
-**Type 3 Memory devices:**  These devices act as a means of attaching
-additional memory (HDM) to a CXL host including both volatile and
-persistent memory. The CXL topology may support interleaving across a
-number of Type 3 memory devices using HDM Decoders in the host, host
-bridge, switch upstream port and endpoints.
+**Type 3: Memory devices**. These devices act as a means of attaching
+additional memory (HDM) to a CXL host with different memory types, including supporting multiple memory tiers attached to the device with both volatile and persistent memory. The CXL topology may support interleaving across a number of Type 3 memory devices using HDM Decoders in the host, host bridge, switch upstream port and endpoints.
+
+See more information about CXL.io CXL.cache CXL.mem in the `CXL 2.0 specification <https://computeexpresslink.org/past-cxl-specifications-landing-page/>`_.
 
 Scope of CXL emulation in QEMU
 ------------------------------
-- 
2.34.1


