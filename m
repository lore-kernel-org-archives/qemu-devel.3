Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE4FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1S-00081d-Ml; Wed, 01 Jul 2026 06:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1L-0007tp-CO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:19 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1I-0004Nn-15
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:17 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-13b355fbb1aso1328422c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901095; x=1783505895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNvGQpzbbrugJ5jYcQ05mYd42IlYP+x1m5KuM5cZI4M=;
 b=JJUZzKPtQYIXxtgQmaM3EExtV+d2vsswTuxRC0QTVq4LoApE7R0xGUqudMbCQZs44N
 co7a5CA9uWP65nqXckeb/tcHyQYPekL149lqHbLxK6nA4kmuI4BEIije+AXHoBL//E/w
 nBGfBao7lMshUAIGSIZpcpmRY/rzYsD5XzVBO4wzUxSE1QB5ip2xAm//MuAegbfyhOxu
 vhTQGM/O2p5tzhHtWQ1izwikgatTcp/LTp1tIIw/8riRlp6nOaAstNxlcTiAYs/Oo8O4
 Fa9NW+2TPnjWFkaXtBR7eQMVinIKKvPBn1JNgGW89SXpa6kjxRUJN13jlNjNah0X2qtR
 xWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901095; x=1783505895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DNvGQpzbbrugJ5jYcQ05mYd42IlYP+x1m5KuM5cZI4M=;
 b=ZupqBmscYRclx1tX+aAE+4ML+YxEa3lTFbU7YuT7KoRjqj/hv5fKuf1QCqyivjJbql
 Nxlop0/ZxVav/IjtuQScYfPRx6lOTXitWTrDj72O9FrmHH1qUstjbqGJIZNDLwq4JQrR
 WuizNYrX2QJpJKQgmYJDDZd/I9sbupsGnahbhlZT4iju22mryiPITNECwTpd+oHprZqw
 y7TSj+HnpxcDi5kLhHj8orlWF+zeyOUfQlVlp5gn3cFDGR9UBxHshZYP3pcNNelEmXtK
 LuDRd7HYg74vtXe3q/+eTuanab9abgZhbl5uZMPC4e9He/z7oqcQfwPt1C5Y07sD+KSz
 DnVg==
X-Gm-Message-State: AOJu0YxXvHAdqV9cBzVwlIH2U3+E6CoY5rp7wudDgJx7TdUduXUtRV6t
 E4iseTwiE9wktV+obT/xXFmD62mzb3dPyE7ciFh8Jhfg8OmL5rUIuAzYRN7eMQ==
X-Gm-Gg: AfdE7ckPg/nXgTM8dQy+1NDmxJefi2XJnMy+Kq2i62jxDCJB5wF6xdkx5qrD7iOC//B
 Fhyo0jbxJogGzqJPjbwKnq1+1J0XzmA2VxKXC7OkLwIxVINVn1St7GLsMiizgtjOuBhMDRTU8k5
 yC6NnWqhDZ5E5oHt6VMm0dc5HbFzt/7xtljTzCYWRUyi7ZKqnZGKv/nFa0ppIaV23lNmKiJY+JV
 UMpGwpoSREoIJO6/fJmj/3ZskOO5CVUy2Rh+qcnrtiPXpAMJCSnaLG4uVy4U9Wn4dg4S7354D2i
 kVE9zj0T9Wvw9hsVabUXXVKLatgZK4sVPHX78537ZC/1fr9GRdP61SnFgN6LqJwk0nzTehaT5lB
 ILPIzqMqsJjoChstGBLOfYWEzK2YoYvRyuUNJ2dlpgRLu4NU8832y5v3FlYxjFXbRfWOk3Upd28
 e0q795z7P8JUo9Yyrx6GLxKwo8gDcLJh4=
X-Received: by 2002:a05:7022:392:b0:137:ef8d:a58 with SMTP id
 a92af1059eb24-13b390d6b3emr234233c88.3.1782901094462; 
 Wed, 01 Jul 2026 03:18:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 02/39] tests/functional/riscv64: Use newer kernel for tuxrun
 boot
Date: Wed,  1 Jul 2026 20:17:15 +1000
Message-ID: <20260701101752.2522962-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1235.google.com
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

From: Joel Stanley <joel@jms.id.au>

The published tuxrun kernel is 6.4 which predates the introduction of
AIA support in Linux. Update it to a 6.11 kernel, the newest build
on the tuxrun site.

Boot times on a laptop are slightly longer but still reasonable:

                       | v6.4.16 | v6.11.9
  ---------------------|---------|--------
   test_riscv64        | 4.82s   | 5.56s
  ---------------------|---------|--------
   test_riscv64_maxcpu | 4.94s   | 5.30s

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260617054034.1020724-3-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/test_tuxrun.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
index 0d8de36204..43d1242be5 100755
--- a/tests/functional/riscv64/test_tuxrun.py
+++ b/tests/functional/riscv64/test_tuxrun.py
@@ -17,8 +17,8 @@
 class TuxRunRiscV64Test(TuxRunBaselineTest):
 
     ASSET_RISCV64_KERNEL = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
-        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadba')
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
     ASSET_RISCV64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
         'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004')
-- 
2.54.0


