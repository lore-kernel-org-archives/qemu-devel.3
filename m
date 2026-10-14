Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCD9CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpsH-0002jQ-DC; Tue, 13 Oct 2026 23:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsF-0002aH-Fn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:51 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsE-0001nM-4K
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:51 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso233319a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949309; x=1792554109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5XxIluoWNJOPky+43A54tqXxiP/Qr347aDJgEPbhxic=;
 b=VR9KN5YXMEmAdndLNkEDCIyvECpbR9IJKDFazb7eeJ+gMU2HOOnMlB0B1u8rR5NoKw
 iJXG3GKechL9yKhDPmSrHPEyYOJ978jqVD8FuLXe3JzUlv9rtb38MjyzRo0U+gTt2skg
 ScQIBf7rIYmJC7hPBwqNrHnbnGfZGEPlbZ18ne9cvKb0/21tk9HMQFYTkDI/Xfx/pbFm
 3ZPCnqcFbq1PE4/1vS9s2ifoDF8LixuU0cPW4CK1YHpsBuN/GKvyZBzTxAYYXLGd4U/o
 HCAG13Kn+TF6kU4q8UclQA43UYmvI4vzIp7e5oBz9CA3lIUCqJ0INmJ9YO4x8zLQjQeP
 MM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949309; x=1792554109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5XxIluoWNJOPky+43A54tqXxiP/Qr347aDJgEPbhxic=;
 b=HBRT1Tm/JRX7+1YuKl9uz6KNmYa4JkbKYUTlwwpILxMEM3btuzt8+som5TY3a7bXPc
 j8yZb0kIpWJ0Tl4C3Ea3ofepzRXHgcBQjuTpbCGDSuMU7o40sXLUGgBEBQhkYfEkQLCY
 w99wP+vPZSUHMIAITWXdgEBFcdhVAhnjaaYlkK22u4tzXW/j6sfSX2NV/0sFwkEDPua5
 nB8t7JDL4ZLnK+19LT2Te1jjsioS+Krnp8G4ha3CoEcwDV+J9TpXCDz50I+OKUQ0CPzi
 EnFDobn0Pscz0sbUlCcuyLRf7JEOj0Jf9eWWmzoJe3Qz3CahmmLXVYM86PiCUvCLsdvK
 R5Cg==
X-Gm-Message-State: AFq9FYI9l1IHc+qPhsR+JRbw0DOYylpVOa3g/r8IOcaYbgjWzhC3ulDT
 7n2bDDKGJpWbcQBcDD0QbvX0T3EfizYHlnvuhLYfv/CrhomQY2cvu14wpIKmXg==
X-Gm-Gg: AYBFou1UJpSHnSbCiXvMH6UWsTEg8+gAAMKkKukf3BnnCN+MTDYxg4bwZig58g5Stfj
 XSJH0xjFIKkQNEBp8c6fByUk8PPG4SaenlVSIkOlULqZQHjFRwFI/0ZUy6d+WAm1IYh/OcIiMLk
 rDDdC2sC4XGHoqkrGTDirQpMOsfp3oLwtT9kYLBjruW7bbfQkTgK5c4dll7+VVpbx0zvuogiyuG
 bmzEND12GGq71Ewc5LRzj6xYUU6j6vtmsnlMT8R/nNjPJ1IZ9WB+z0POFq0KXp9+DoBrcHkJTUS
 Iju99GLtj6OllEJV8uf7ENIJNcN6Zda6qCht22TStWpUgwBo3jutjnVaZk3cYzmgEhof57FRqLe
 sJv32Pu3nhRsSOp9W/pfgYQHvF5TJvd6fSQ5Moq1c9yIbyHTuyXR1ta2Oc7l+paVWajwxKBRGyF
 FzGCXy3ze7oVkmxLgWztMmpH1Xo5IaZswroGEqyhGhsCo7W97IhMeuwwhJ43hPgdmp6SvzU3f4l
 NyikmrIvn/gn11CJfDd1vArmG8=
X-Received: by 2002:a17:90b:3145:b0:3a8:86d6:aab2 with SMTP id
 98e67ed59e1d1-3ab3a99b883mr12265038a91.63.1791949308750; 
 Tue, 13 Oct 2026 20:41:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/52] tests/qtest/bios-tables-test: Allow changes to riscv64
 virt SPCR
Date: Wed, 14 Oct 2026 13:39:01 +1000
Message-ID: <20261014033907.3332383-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Rick Richard <rick@sloservers.com>

Allow changes to the riscv64 virt board SPCR -- we are going to fix
an error in the UART description there.

Signed-off-by: Rick Richard <rick@sloservers.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261005104008.214588-2-rick@sloservers.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..aae973048a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.55.0


