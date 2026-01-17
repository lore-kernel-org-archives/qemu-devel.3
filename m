Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B078CD4A5F5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxuv-0001C6-9d; Fri, 16 Jan 2026 23:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxut-00019j-4K
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:28:03 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxur-0001ct-PW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:28:02 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-81ef4b87291so1407946b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624080; x=1769228880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMZU8mEUILIye8L6yHPGwpbqe/swpnXtsqBh42LNfuk=;
 b=CTZe1swLism6dpQd6jCjySiaxvssFsr5vGsIspkWjF9Yzc5Ppjxgm3lEENg1jsY/lI
 Qqg/1QCe6cy7phQy8Gkn1y693RiXAS3ICt/AW7QYfftWpbm8zSqAAzYSz77nADxxAXCf
 ISA5MUaMnn1nLuxkM+9TxHVVnPi0g+djG+uVHo7IqFwi7q6puoq7MzpZLkZphN1+iGJ8
 Go/F4WhbDmiUIaq+BUsmn7Jp3nAGIT5+uft3nxuM52CszJTsmSP7lyldZcfdm6r2SFHK
 dCISHABQp4NkibN2mMGZWuUEOABSR+em1r7KmrLYrP1nMtWluvnQ50YAJw+TeJuBrw3r
 pNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624080; x=1769228880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OMZU8mEUILIye8L6yHPGwpbqe/swpnXtsqBh42LNfuk=;
 b=IAwVN9KaFwmHaSwi+TWK9rMgBfXGKDZUJxbOmvVnhtmXTmhFJXQapPUjRpBlCiyfMF
 2UVE2lM60+BqqoFzWMYB/0qD0kAzAlTDcvKH5vlMqnDpCgIObhrG08ajDFmJtCoNxdwu
 /6zFUbUgjhUUUHaMGjGYIqC+NBELBATSBKbww+dOvPBljLCLi6XtM1znmv0n5685BALh
 t9Irw/qwIl+afTr4zqqg7peCxaM6oGimF7R3nordERW1H0ShD0juXAS3WvxnOW67F78O
 U5E6D5uxRrJsyn3F4FDqzlQghvb7kwISIFKNd3xOHypQ8Bqy6Hmp9a1G8OEbhkIkYkP3
 CmFA==
X-Gm-Message-State: AOJu0YxttOKt6DPEQS+qj94Sg8x/Yoq8SPhgxp201cA0RXDzB9qx1+0s
 Efv9msN3pjAJ3MzEAV1SRw6SZqIuY2diG8KHtJhVKu3VZ4Co6/Up9Z/5
X-Gm-Gg: AY/fxX77SjzasAWmvS8l68JATnyJe0hoH4BGIsGuafNdjOWOqkEIcU3GhfC2ozq64EY
 z7UWMdG4rP5KI5v8n3QjJa4ive8s/6X22ihlY7e/3/KifuE31xGvmzJSQWGaRur8vQtREHW3W83
 4OSE6BkFPzMSKuww37jp4iBq6+xKSAwg4QFB8pkHIaoQSeHorkiY3oy7oUkphoDWrbFg5CHGg43
 7GnupDltL8VDEGutb68UEGXLfGXzXhceRbCoT+FRbocqpOertDMgDxxsE15sVXIhIRvwviMcj2g
 sEGazuveBPorxqoGZ7xHbqJXlOQ5HMfuuwsyur/JDCDjQ6jbA0g74CzzrwRg45d81j1xHfH5eLe
 bzPAWEsXEVzLvqOGeb/ew7ALYl1qN1QAmJ3V/3t319lGOPD4M0DOTlkqxvuKbT0kzTPjv4Y/LzP
 1rf05XQ0KoD52OKk8stlxrWUWYIWcFym/PXRuirkkxgu6Zpqq/V8qD2wid7Vds1w==
X-Received: by 2002:a05:6a20:12ca:b0:371:5a31:e486 with SMTP id
 adf61e73a8af0-38dfe59047fmr5402922637.6.1768624080429; 
 Fri, 16 Jan 2026 20:28:00 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:28:00 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 8/8] tests: update riscv64 virt RHCT
Date: Sat, 17 Jan 2026 12:27:29 +0800
Message-ID: <ca2e4e3eb1aac3ac3d79f2fd5aad4de35d650ca2.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update the golden RHCT table for riscv64 virt after the
Sdext/Sdtrig changes. Rebuilt with tests/data/acpi/
rebuild-expected-aml.sh.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 tests/data/acpi/riscv64/virt/RHCT | Bin 416 -> 422 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 52a4cc4b6380eee3299b965271a39e9e01f5a698..b9a288b299ef98491d33d3c5cda59c50ab434fc9 100644
GIT binary patch
delta 42
ycmZ3$yo{ME$iq2g86yJ&quE3*16CJCMh5GN_G_3@D<(eQ$Wg<{z|h9XzyJW>g$hRi

delta 39
vcmZ3+ynvZ2$iq2g0V4wg<L!xD2CR0Bj0~m|?bl5FxR#@gk%6Isk%0jK&&vt*

-- 
2.52.0


