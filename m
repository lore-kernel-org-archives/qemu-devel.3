Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08276C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaeJ-0005zV-5S; Mon, 10 Feb 2025 15:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaeE-0005QB-4Z
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:54 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaeB-00044G-OO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:53 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38dc33931d3so2064072f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220289; x=1739825089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DX9DBgf/ZOjZteqt+lpORZoLsvdeqNqe4QCTU3mIslQ=;
 b=aFl8WVcBNxqk6VFSulXAazssOGbIMqlsh6dyZFDpWf26BlolJ0Pup6aOQTcqAHjyPo
 tC/PUvupnp25athQhnC/zbRuRwxQbKKs7Uzx71g7RvBCLU/p+Fc23mjz9r4r0x6N4iW0
 zOM6N24Hv1GxhnN62uwx2Wu/xXWBPmYNG57YSE5k6YytzSJOSLCAH/jQe/jAqikoE3l9
 FdoSB32VyCEmpn5c6UJGLtGQk/zxZJ3qshDIvvJta9OfzqMyhaQEunT6Rj6E75BjTNs+
 yyDOdUTilOPgUDfoMxhCWijkARBEmLvRTAvZ3GHa65SiEPW3prhKq9Y8FN5eqznEH7ZT
 PArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220289; x=1739825089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DX9DBgf/ZOjZteqt+lpORZoLsvdeqNqe4QCTU3mIslQ=;
 b=LMi4NR8bebWI5CSATBoFgoaEnWzoU/cST8i9lPlgd5V7RlVVe84oS0L3It5Bbi+Kqv
 VatADdebg88surD3XL8uU+RjRyO1bWK+P/F1A6xJsaBPPLT9DCA5CLhL0VllvN0SdJ9d
 hI4dO8ghrFP09st6uEKXKQRQe5KYaBWSCE7Mv+yqmyixyAAmHLIEeUrvPmSv5WWLjcnN
 AjUJ0bMKlhlUuULQ7L0pzLRf6blcdGuupGUMx9nFZSboDjiqhlWh0CHPeuoYZHauY1QW
 wmDdV9QmpRySlGzIXOE6Pb4mjcRABnpDJiMQrPXXnSJ451MYhdwLR2k+TetDBQtsgN55
 iMOQ==
X-Gm-Message-State: AOJu0YwmV80gi8w49+mlMmJBoMQzYRKSceRBaMTqUbmywzA9YOvWQKG0
 CsvF1YxEYclQUVJFKqG6BfBUMI3xepTmCTwyibgP76m/DstkhoUP+/F63+5LqmCtyTnfJbPdc6A
 GvMY=
X-Gm-Gg: ASbGnct8ZOyRqew9/nRTaEufCvZVXQLf4h3lD0eIAFPpMKbLqFFgfTatiMJ6FAA81/n
 KXKFjFLtHqGXhGyNwNXGsGpcai7UuMS3yIGbugBo4RpmpZ5Tet55RnlraSS8dZWtKHtWm1GnyYw
 vP00ZpJXGhpdVMR/BycckYQ56DbbEBeZ60Jy7jn1OnyhQmmRHxTNRej+erl3LoMrmkF8JD9+i6N
 nLOyG285uqgjUBqZly8J96/HjhgnrPLZWA3WoQT98DozYpaZUT5mX1llTM6KrzEbasURMhdkL1v
 mXHZDIH1WyeneyGNjEIYGW6jfCxtTmxasYgKB8Jbve+At15qRVMNE7yH3KU7F+gJhQ==
X-Google-Smtp-Source: AGHT+IGP29UJrV3lIdnox1Xfuir7/Weit+kMYgyB2VN/CZwycNsHQHztvTbxndodUrefO0FY0lktpQ==
X-Received: by 2002:a05:6000:186f:b0:38d:e052:625a with SMTP id
 ffacd0b85a97d-38de05263fbmr4435911f8f.16.1739220289575; 
 Mon, 10 Feb 2025 12:44:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11200sm189100565e9.38.2025.02.10.12.44.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/32] hw/net/smc91c111: Ignore attempt to pop from empty RX
 fifo
Date: Mon, 10 Feb 2025 21:42:04 +0100
Message-ID: <20250210204204.54407-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The SMC91C111 includes an MMU Command register which permits
the guest to remove entries from the RX FIFO. The datasheet
does not specify what happens if the guest tries to do this
when the FIFO is already empty; there are no status registers
containing error bits which might be applicable.

Currently we don't guard at all against pop of an empty
RX FIFO, with the result that we allow the guest to drive
the rx_fifo_len index to negative values, which will cause
smc91c111_receive() to write to the rx_fifo[] array out of
bounds when we receive the next packet.

Instead ignore attempts to pop an empty RX FIFO.

Cc: qemu-stable@nongnu.org
Fixes: 80337b66a8e7 ("NIC emulation for qemu arm-softmmu")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2780
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250207151157.3151776-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/smc91c111.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index b18d5c23c39..0e13dfa18b2 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -182,6 +182,15 @@ static void smc91c111_pop_rx_fifo(smc91c111_state *s)
 {
     int i;
 
+    if (s->rx_fifo_len == 0) {
+        /*
+         * The datasheet doesn't document what the behaviour is if the
+         * guest tries to pop an empty RX FIFO, and there's no obvious
+         * error status register to report it. Just ignore the attempt.
+         */
+        return;
+    }
+
     s->rx_fifo_len--;
     if (s->rx_fifo_len) {
         for (i = 0; i < s->rx_fifo_len; i++)
-- 
2.47.1


