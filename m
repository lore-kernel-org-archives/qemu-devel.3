Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7666DE7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6JR-0002ix-Dn; Sun, 12 Jan 2025 17:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ix-0001j9-3q
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:37 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Iv-0006Ya-K2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385df53e559so2972793f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720372; x=1737325172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ng7p8uEQsgEiT4/xccHokv2a4110PAynaA5YHFbpMeA=;
 b=rx0She0JgICXStgVSoTNRrbzTbufO57krtHz+ujrKzUlM4ej6fuuV400OuCbgP0Iiw
 6WqSr3+wsASclAaFcga9Ozl7o8ZtFSo8Ma7PZzgDKwUbjT29r1D5CEWijBW4897G2dXB
 TfgG8c45xXf27vNc7wC8xJrXX3H+r0wH5w/ZprdKbM6MYVfbN4tTr8WfsRbY+/pyHjHB
 hKxMr1qLPQy5LDdRYq8Tyji6bLyiGe/gfJUm1Qld7LB14gaZSp1JUsB/31J0IkHCO0gC
 eR8PGan41Wl/SKZpPGdHr/wWzWBgGYHLyyTuahPrUTPUymjOnpEJfgLACEUPsY0/F2A2
 jVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720372; x=1737325172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ng7p8uEQsgEiT4/xccHokv2a4110PAynaA5YHFbpMeA=;
 b=ENv9R3GSkJcrnVQiTZyv2kxnZtpJun3ooYAwpfmUu4akgeP+vwx6wlLPCo8L65W8Y/
 s0xCsvmV9ekw8Ql8d2LUnqONejGN8fYp5LxPs7l0gBhMhxW5NQAca4e/RxYyfC5pgu5C
 7glMIJjte822caUHFev9HtL/R/66/Ii0AF1HSmQBYkGXp95ygDEQ5iv7bD/Mn6ea02l4
 eNbqkG7tRRS3btyUL5K0pfih9fRQWgTYUGpJhGnFhwl+3qKSUjp9itbGL8foaSe6c9x+
 Q3y+WvNbpTRsLA6XKcyqfAGcINZ7wTML5C8vz9Soa5djPMCeasr6RrQvDT72rzkGdn37
 +cow==
X-Gm-Message-State: AOJu0YxfZ5UHU0xwfMnrE4y8Scq5A3xJF8pqlFaqf4hT1lQo/a8wz3lP
 xq4jKgjLoJzKpHKtSQt/gKa3/bhNl9NQm0HBU7qFqXGlsmg8vjZRtZpgwd0zPgZIwWjrit7Djjs
 OwHM=
X-Gm-Gg: ASbGnctqvUc4cJLMrFqTnFERMWAdtoAFR5dmDfy7TjVrP+s/D5c38loOQx2iV1rF5IE
 Imn9nBT5pWS3lb+XqltNxexsq7b/dRQaaLoEJF5yVhfGK54BI3fudygmqXGVwA0GkYFF4zzBLYS
 IlpnsmAvsc507+84y11SZJLX1pXwqKPwdnsmfzGDVv7uvclUVvQG2mWSUKSUpu+gOmHXh7qVFLE
 XJDUQCOdoA7p25T3m/5YqqUHfQxi0tfI5ch9kxLQKTacB09r2g1joBIduf40GWqV8gKwtVD3JDK
 PD8HzcbJizdweqtAMVUn77JzB3PjCHg=
X-Google-Smtp-Source: AGHT+IF+BvMQt5kzkhszRcoo53LoAN0gJiciBDsss8wOyeigvqgh3HADhzQ7oycB7MCATWtakE4yZQ==
X-Received: by 2002:a05:6000:2aa:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-38a87086c15mr17848108f8f.0.1736720371683; 
 Sun, 12 Jan 2025 14:19:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e6236bsm122243305e9.37.2025.01.12.14.19.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keoseong Park <keosung.park@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>
Subject: [PULL 25/49] hw/ufs: Adjust value to match CPU's endian format
Date: Sun, 12 Jan 2025 23:17:01 +0100
Message-ID: <20250112221726.30206-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Keoseong Park <keosung.park@samsung.com>

In ufs_write_attr_value(), the value parameter is handled in the CPU's
endian format but provided in big-endian format by the caller. Thus, it
is converted to the CPU's endian format. The related test code is also
fixed to reflect this change.

Fixes: 7c85332a2b3e ("hw/ufs: minor bug fixes related to ufs-test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Message-ID: <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ufs/ufs.c           | 2 +-
 tests/qtest/ufs-test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 8d26d137918..428fe927ad0 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1164,7 +1164,7 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
         value = ufs_read_attr_value(u, idn);
         ret = UFS_QUERY_RESULT_SUCCESS;
     } else {
-        value = req->req_upiu.qr.value;
+        value = be32_to_cpu(req->req_upiu.qr.value);
         ret = ufs_write_attr_value(u, idn, value);
     }
     req->rsp_upiu.qr.value = cpu_to_be32(value);
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 60199abbee7..1f860b41c06 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -145,7 +145,7 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
     req_upiu.qr.idn = idn;
     req_upiu.qr.index = index;
     req_upiu.qr.selector = selector;
-    req_upiu.qr.value = attr_value;
+    req_upiu.qr.value = cpu_to_be32(attr_value);
     req_upiu.qr.length = UFS_QUERY_DESC_MAX_SIZE;
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
-- 
2.47.1


