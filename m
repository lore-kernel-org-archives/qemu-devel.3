Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EF1C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnas-00014l-41; Tue, 11 Aug 2026 10:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaX-0000N3-SV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:23 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaV-0001wa-IE
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:20 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-8f1a8e914a9so26039096d6.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458979; x=1787063779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sNEEyf0DhnqBWvsZHpey8UBC3nPrPs683XYOT8uHTkU=;
 b=QzXPoyaW3Sk2ZheorTZhOz2I0V9rWOCNWVcH5F/nloLKrFMIaPjxHJEwckmfK3bdmt
 3RHXljWFqedZ2q8toL2TiQSGNLaOsGn1vX2KqVSUZIkOn+V7Zk8ePV/3i9oIgyqG36lw
 0NOmfmhL98eekDoEZAzU6zz41x6u/sqUlyG8LB5aT30aieTAZbHlfCavvN0G3U6grc01
 6lLhqcs0mSHiQL20s5Crs3nq4DGOOwOenU5bCIfoNGJeeZcbPQxEEp/ZXWFPDGWhThHl
 xi3xbdw55dTnASP9bW3R/IRSkLAzWKuheMO6qeyq1rYvYOCOvoh6lei6IPF9XHgt1DqY
 +N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458979; x=1787063779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sNEEyf0DhnqBWvsZHpey8UBC3nPrPs683XYOT8uHTkU=;
 b=kNGORWp+q60FeLWJOrWVPRbtOn/4GpJsKE40rsZKU9P8x6TK066VU7KkjDbIdHH6I2
 Ewc+x1Nvf1hPj0tQlR1dKR+8sM77kSNHf+0q54d9QNI1rhUlnrk8da4Yuc+w9WUoMsx8
 Yn4CwzHA8Y7GIv2bhzZqWWNXDtyEZuXvcRf72yd8VFS8yKj8c9blOgVD/PKNkjrYxDkB
 54Bp4s5AbLc7AeZO3orAMlJoXYAuPKv0KT3TLfa+IsRa+3jhZBeXo7OmLZXAxAYwHQYR
 tbv7XpDb/NONzzxtLFnud6EE7zUk0uQIKWJFx/pmLaatLzI/3PDl1DOs+qbraw80ckVp
 XIrg==
X-Gm-Message-State: AOJu0Yyi7bjfhTNftvKDtEcdqmpjpguP4nNKsPbfwOKdiOHH9iDMAVAm
 OHjcRx+VwkEhl19WFpUXnw7mnSrYhKo6b5eMnRsp8QIC21nFYZpqjAHrrHD+2Q==
X-Gm-Gg: AR+sD10Kc6NlD0wqbgREGSQJPats7kId+KeluvdehA60ZtKtSD/pbTzXSL9E33ypC/e
 WPzmSEdyYChtpSWxUJ3FgLHlm476XCMuVcqa5cIzgGzYRrHYAYiXSpIzOo5AX29pnVBSaYaAWLs
 FowFoOZyfEjXp4hD1JFzz+liWsiIWoD6mGsFHdvBGu9wJ0S7tLw7bWYwV7463clLWxRjvIfg22X
 FS3MRziw2XTQnAdvFmylZf4r3SOpgBtY8GtmSFg5gruQ3eiKRUnw+fAX2SbCJi3Bm+jahPKjnZe
 PpjTgIEQh6TbGGP9HCXDf2nbzXizGPhI7RrqlvbNNEaTNSNlY+PGCIogo+5obT8x1QLu08/qiJT
 lpVGfpA2VxtnxZDUpLuNmaZrsrOqmqr25V/ao4FX4rNBzy66ZxHtBtERactfksaL2Y+TPMlDyoB
 jq3a2R3FxtYNEjFD1nDk11R8RXkcoRXGJEQgykrluNdzMaHMRBbdsZpmDm+nnzYZV2D3tNZC3iT
 8UvWuf43ZD2ee5JFeJV/lMQqP9f+DI=
X-Received: by 2002:a05:6214:4306:b0:8ee:756a:f1cb with SMTP id
 6a1803df08f44-90a6692620emr34950626d6.28.1786458978556; 
 Tue, 11 Aug 2026 07:36:18 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.36.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:36:18 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 18/19] docs/system/arm/raspi: move PCIe/GENET from missing
 to implemented
Date: Tue, 11 Aug 2026 10:35:55 -0400
Message-ID: <20260811143557.7862-19-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf36.google.com
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

raspi4b now has a working PCIe Root Complex and GENET Ethernet
controller (added in the preceding patches); move them out of the
"Missing devices" list and into "Implemented devices".

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 docs/system/arm/raspi.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1c3..a8fc37e920 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -36,10 +36,12 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
  * Broadcom Serial Controller (I2C)
+ * PCIe Root Complex (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
 
 Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
- * PCIE Root Port (raspi4b)
- * GENET Ethernet Controller (raspi4b)
+ * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
+   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``
-- 
2.47.1


