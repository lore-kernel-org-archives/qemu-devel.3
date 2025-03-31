Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A257C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8G-0002Cs-Le; Mon, 31 Mar 2025 15:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8B-0002CA-W1
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8A-0003OB-82
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4124684f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450548; x=1744055348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGSB9mapXUSE8SJ3Sr9SkrYPIF47w1Iq0wn1bPdtMLw=;
 b=DU+zAT9qdxNnS/ZMmQhCoTDdwcbRmsS7Czmszjb655L3Yep/Jsg1W6kQ2lCq43HA15
 bxBAhCpWnqOY27r+yq6Adm6uiBotgzLOkc4TgYjaJmORgNA9DTpqwr2xV8loARsXDI6F
 D13TtFfXv5cflxWE3OJXJy5mhTU6iXJS1CbpndYs4nQ7oRxOYlerkAMDfrH+1AvUNDW1
 R2LueTLnAswXBZ2e5glIQjgpFphY+MEQ6TmmFcCrEdxl79g0DvjOOHttgqtiY2Dx/5/C
 7AfmMhFeExdFLHryTol7vFpEGy5op5eKJPM6RX5JO0O5RfmdEm/OzR/eaLIEeDMQ+DBz
 +eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450548; x=1744055348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGSB9mapXUSE8SJ3Sr9SkrYPIF47w1Iq0wn1bPdtMLw=;
 b=TNHHgkjKaewidqfcRL7Uvi4jLikdME5UJf8cXZ+aoy9t1IIFjMFlIyWpSfQDqibtOj
 dY6YgLQiGm+ZWwea+ODHNMccurEzVX2QZwYSWVN0VkmfOiuGrMyLhlOEP/ciC8Zbqjx2
 ggahnbByRKr/q9aq0P5VlPw28l31FU9htjA9u+78gpxiHXG6j1G31VPWwqe73MoEN8gh
 VnjgYxBZEhcFPHk/SNVpWiqIfPa46GgdQaUqGDXNBGdaIFtm6gHeYH8CX1nIWSBgpdqc
 VMTZ2LxVsOozF3bksigaQjttglragVAGZlms37mqlT2T7sTdH1IDI9EdIbeVlaOPS18E
 sMVg==
X-Gm-Message-State: AOJu0YyaLISOIRnaOsIRPEHbv705bB0cfLOz8ndqW5ZdOg+ZITPhv/mf
 4ZiBDbTYTxu4mFxNxFWeoaLFOrRV1+5JfBvNv0Jp+rZWblkNTwKjeaaXhxm4092DvwnNFTuv+Lu
 i
X-Gm-Gg: ASbGnctR7A8IWns2zYqbccg0/+tE9zL6QPIb6n5Y6sFNworfKmFMxorbbvway8sHq59
 s7+3SoDl6U3jKjUxfkgF4oZO5gsPxsCm7aB4euKLvChX6J86AfW8WyB4I9bk9vofj6JYSW25gSn
 M1uCq5LgB+mw7JoJme+7lfmMfIGoGO7jfCynNd3vg/wbylJNwlXaMYEMdLtlHNHMtE0uA2cfKpY
 UpOfBv+uvgOQxs0AZYr5G/jLh9aa3rrRBDpTKPmLOITwdX7JE+vBZ80a7avBovQwVCiUU9ZCNPW
 9WwqHctT7nU5cP8oszECZ/UEr0LveU6dgQAkIYu8F6qjJ6QESvwOpxFZZvGZ9Aqv5yJz6J1CEM3
 NVK4lYfUZAInE4Sb/Mt4=
X-Google-Smtp-Source: AGHT+IElYu8ocsLvCmfRnWTGPKq623j/uljhjRvmQDkaiPOrNDjYYhvk72SnGcXpOe7ERu2ukeNqJw==
X-Received: by 2002:a5d:64c2:0:b0:391:255a:748b with SMTP id
 ffacd0b85a97d-39c12118f10mr7515853f8f.39.1743450548315; 
 Mon, 31 Mar 2025 12:49:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0d1sm12080196f8f.70.2025.03.31.12.49.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/23] hw/mips: Mark the "mipssim" machine as deprecated
Date: Mon, 31 Mar 2025 21:48:07 +0200
Message-ID: <20250331194822.77309-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Thomas Huth <thuth@redhat.com>

We are not aware of anybody still using this machine, support for it
has been withdrawn from the Linux kernel (i.e. there also won't be
any future development anymore), and we are not aware of any binaries
online that could be used for regression testing to avoid that the
machine bitrots ... thus let's mark it as deprecated now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250121103655.1285596-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e2b4f077d45..76291fdfd62 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -292,6 +292,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
 Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
 CPUs. Big endian support is not tested.
 
+Mips ``mipssim`` machine (since 10.0)
+'''''''''''''''''''''''''''''''''''''
+
+Linux dropped support for this virtual machine type in kernel v3.7, and
+there does not seem to be anybody around who is still using this board
+in QEMU: Most former MIPS-related people are working on other architectures
+in their everyday job nowadays, and we are also not aware of anybody still
+using old binaries with this board (i.e. there is also no binary available
+online to check that this board did not completely bitrot yet). It is
+recommended to use another MIPS machine for future MIPS code development
+instead.
+
+
 Backend options
 ---------------
 
-- 
2.47.1


