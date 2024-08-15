Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67790C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnE-0003va-1i; Thu, 15 Aug 2024 10:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn0-0003GB-4Q
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:23 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmx-0000Cf-5Y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:20 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso1540953a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733358; x=1724338158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qa09G1wxoease4Cu4sCuCaUUU6r75hWrRIJjosTbxU=;
 b=WCe8LRdCXDfVlYm4pqnRhDHxWH5YHRnnPM8NQeb7Za2boxVapsHn++imRHT0LTcW5u
 grzR15lQKqXnQXxfvJhLCEXSOEzmlbHfUub0CUcUwtdvks3NuKypsrPGGxBfZasD2E7K
 eJzQRRqcb7jnbsF2628Wg4cpNVfLG+To40Twg3HdVyBk8YO74y6cI3bhBnWNagYHPWne
 q4hHKb0Pw5caK9qy/Ut9DiT6FQY/DJl3rdG9DgYkTT+GHLpUwDOOv0Qq3h8smv4eamB4
 aU1slm4gXvcmxqpB5qq2BWutS94zd2zwZ55EnrXINA8lCIh8S+B2y0pbX/+Wyg7u/7C+
 zx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733358; x=1724338158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qa09G1wxoease4Cu4sCuCaUUU6r75hWrRIJjosTbxU=;
 b=Jkh45CX9eg79spHiDoNMSUpV2scD1TZJ+pOke4BFGYe4r9YX/FZ2KoYBx8gXker6Z1
 cs3+qfZDAOs7Q+E33TBgZyGFaayo51KemHTEE2Ia2tWFtQIGyXWg7eTYTwkEKXGzZCbx
 DmmnLJ7vYq+WMHlxSTcIA0h8sLB3h5heVaVsDTpvjdDqOnthMZPsaCIygVcZsO+J1D82
 OuDWlhqYPZRmkhyH/QrUWeCHED+ahcHPEPT2VpPr/Iey0w7e3uwqzJ/4INJ/NyeX6I7d
 V8DQFqGnj78e2teOebMvc1ts2hmMQCh05lf8+XtTgmCt27y6WS2skJa991XUg0Z+PPET
 oASw==
X-Gm-Message-State: AOJu0YyF2OrFjkaJhL6h0IBGi/qc6iZk+hAy3n3wZLoV5FPzKJUamZgg
 w0am5NDnWxyXF6W1Ka/cTGhp0FXYRTYzHrqyxkGr9VctfF+kqOzM8LPYcUVK7FE=
X-Google-Smtp-Source: AGHT+IHfI52dvC6OqQXSPocpfhnlQTaTV5SCNu8BxKIkNJ0EN6xI3YXiY2B69GiBkO77L/Y0gH0wGA==
X-Received: by 2002:a17:907:803:b0:a80:d64f:6734 with SMTP id
 a640c23a62f3a-a8367070b7dmr432663066b.60.1723733357286; 
 Thu, 15 Aug 2024 07:49:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838393599asm112187266b.132.2024.08.15.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BABB5F940;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 05/21] configure: Fix GDB version detection for GDB_HAS_MTE
Date: Thu, 15 Aug 2024 15:48:55 +0100
Message-Id: <20240815144911.1931487-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

The test gdbstub/test-mte.py requires a GDB version that supports the
qIsAddressTagged packet. According to GDB NEWS [0], this packet was
first made available in the GDB 15.1 release, not in 15.0, so this
commit fixes it in configure.

[0] https://www.sourceware.org/gdb/news/

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2477
Message-Id: <20240804161850.2646299-4-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-6-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 97de85d710..d08b71f14b 100755
--- a/configure
+++ b/configure
@@ -1675,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


