Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A046D4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVi-0001Da-4V; Thu, 15 Jan 2026 13:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVP-0000iC-2F
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVH-0005vm-9j
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-431048c4068so713727f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503326; x=1769108126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4gjXCy79pe4NWZapLMTTRsh607ELXIo37IZ3HiA37hQ=;
 b=JazjuQWyRkhZm0CNdAH3piTrgnhiN/JwgNlhn1+NED7hWHI8QSlFS1vtBgQ4ih9VJt
 gfyoMReIBxyTAEJRL+TJEAHc6Bwa2bbpVkLa21OKaHSFJN0n+XDQHnxTcNqsTcjSfQE4
 eDkXF728ZmGESlPy7Q/5sczknA6tW8oRiVjKftBLh8/yk3PAf8cOcDBvrGIbpL0zvfgp
 GZE9TfsXHXPoAtTs12dbqaOImOBTK/eO5usS5T5I51XDtZDp9fgQznYD9/q4derMfNko
 7A8ZT3z5qAwG0j6pnzaOc5XMBHPACOiBiBhOzPdipji2YiNCKt4sAgLWLcWtvYz4JJ6I
 vkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503326; x=1769108126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4gjXCy79pe4NWZapLMTTRsh607ELXIo37IZ3HiA37hQ=;
 b=nIE+vV4mZTGz7oP78RzLttMhVmwXXJLwYeatDMxha7VhUNzmDS89ft2OC8iXio6V9M
 LIQkc08KIYN5FtlGGEMaWnbPMOQ25hE+Rs52YckR5scBrO8zcZkQIFkHDAaftRY1vSxq
 93FwxewcRlrMZEVmX12QfV6b3XsQfCUYk3cMbutMsgbl+Qr83/UivsFhiY+ywz2ZbaYH
 vbzrDnBH61O1oZg4Z9UIp6/O476OD+rBEIV13fgo4/WEZyyPH0aX7RgfBrM0KNBr/ZGa
 BCo9epvMvtQkjcyohIP7CMX0vFfLmAuZ+BgQgqskY/s7ou06Q49BkFWqqWdnivKkiVdT
 dIGw==
X-Gm-Message-State: AOJu0YxI7XaLfDOWnRJvT1+IzVf50kvy1QxeC4mEBhrvU204TEIu5VPa
 G7Ka38fRe1PWm9mwrnWF0OlrAUUzoPd61j4eirikJtDPUgDp7lAcqR1760DKyjSL173Mqy2oRVb
 /nMG1
X-Gm-Gg: AY/fxX6Czc5rgW9VxSloPkngYZV1jTgFM/jhNEAYiOP3iNMjflp4Dhxp6V5ambBSTSz
 wd7KNecn2IK1p+23tVtT4xZqBMgwkxwvM35K5iV3W471NDsg+ES6ZmQj5qiUc0o4Pr9T37j4i/u
 TrGy3gNy2OgChfr2qZvD8rSbrHrT1J3mNh4Ja+aAjDAM+A5WgECIiYM7+fwAbJbNv9I5jIFdOGY
 jer6c4EazjxO7HSvTovh4UWHmoGQR0qh6gxCAd2cYTgXgZL5If3WxPRnMLrlz6pWMj2szhxcHLD
 ClOwGzp0LNOTOWHZCUtKlIgoZ3j8DCFTmBGWFZpUTPjOB4aSV62VVof0e8q6Hs9pjfw5cA4OSZz
 hXqv5EODtjm+UGj+rx7MzjTHu+iQp2DOxsnjJcEScWzLkqZ0iYXSyPwGqyk2c1vV5d7hSTkK3xr
 ZuG6P9QkZ1NFZUbZVsWDJViF8Cj87IDJTZ8OE6ky2eg0PRzgWGrpinlzvYoRIlLOtRG6GfqyrTe
 OXwKd7W56jsL6bTEexiQVz4qWoemQSxbnnTeYowT0e2EA==
X-Received: by 2002:a05:6000:288c:b0:432:c03e:a78e with SMTP id
 ffacd0b85a97d-434df116480mr5396491f8f.27.1768503326534; 
 Thu, 15 Jan 2026 10:55:26 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/25] docs/system/generic-loader: Don't mention QemuOpts
 implementation detail
Date: Thu, 15 Jan 2026 18:55:01 +0000
Message-ID: <20260115185508.786428-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We currently say "All values are parsed using the standard QemuOpts
parsing".  This doesn't tell the user anything useful because we
don't mention QemuOpts anywhere else in the docs.  What we're really
trying to tell the user is what we mention afterwards: that the
values are decimal, and you need an 0x prefix for hex.  How we
achieve it is an implementation detail the user doesn't need to know.

Drop the explicit mention of QemuOpts; this in passing removes a typo
"QemuOps" that we made in one place. Put the informative note
more closely associated with the <addr> suboption which is the
one that users might most reasonably assume to default to hex.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/generic-loader.rst | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
index 3ac39cfbbe..d5416711e9 100644
--- a/docs/system/generic-loader.rst
+++ b/docs/system/generic-loader.rst
@@ -21,6 +21,10 @@ can be done by following the syntax below::
 ``<addr>``
   The address to store the data in.
 
+  Note that as usual with QEMU numeric option values, the default is to
+  treat the argument as decimal.  To specify a value in hex, prefix it
+  with '0x'.
+
 ``<data>``
   The value to be written to the address. The maximum size of the data
   is 8 bytes.
@@ -37,10 +41,6 @@ can be done by following the syntax below::
   The number of the CPU's address space where the data should be
   loaded. If not specified the address space of the first CPU is used.
 
-All values are parsed using the standard QemuOps parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
 
 An example of loading value 0x8000000e to address 0xfd1a0104 is::
 
@@ -57,14 +57,13 @@ can be done by following the syntax below::
 ``<addr>``
   The value to use as the CPU's PC.
 
+  Note that as usual with QEMU numeric option values, the default is to
+  treat the argument as decimal.  To specify a value in hex, prefix it
+  with '0x'.
+
 ``<cpu-num>``
   The number of the CPU whose PC should be set to the specified value.
 
-All values are parsed using the standard QemuOpts parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
-
 An example of setting CPU 0's PC to 0x8000 is::
 
     -device loader,addr=0x8000,cpu-num=0
@@ -85,6 +84,10 @@ shown below:
   The memory address where the file should be loaded. This is required
   for raw images and ignored for non-raw files.
 
+  Note that as usual with QEMU numeric option values, the default is to
+  treat the argument as decimal.  To specify a value in hex, prefix it
+  with '0x'.
+
 ``<cpu-num>``
   This specifies the CPU that should be used. This is an
   optional argument with two effects:
@@ -104,10 +107,6 @@ shown below:
   This can be used to load supported executable formats as if they
   were raw.
 
-All values are parsed using the standard QemuOpts parsing. This allows the user
-to specify any values in any format supported. By default the values
-will be parsed as decimal. To use hex values the user should prefix the number
-with a '0x'.
 
 An example of loading an ELF file which CPU0 will boot is shown below::
 
-- 
2.47.3


