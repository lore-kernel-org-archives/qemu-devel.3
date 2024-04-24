Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05B3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzjAh-00059M-9H; Wed, 24 Apr 2024 16:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzjAa-00055S-5E
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:24:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzjAX-0006XU-SI
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:24:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f0b9f943cbso331863b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713990280; x=1714595080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6k1TEiVk/yosToW5KCtbEMqzVSjxDe3oLoEdhyG1u/s=;
 b=DyOIafxouxjdtnMG3pX5z1SRPAkrv7lr6O3eS2eiI9G56V7MrAg3veyaCbC4QDdVw4
 UjcF+mM2o5G+RIkCOwi3801PjjMFt1JhfrpCxEqOOtth5TuZM+rZ4AhSNrQc8Dh05emA
 n+7J/dOe++72dyyReAAwhulzB1RVuJOdTZOaqR3XxY/moNqJ4ff27BpkGt8SzR4ctQAX
 6TkMz2XFajep5jXRAGCB7i28zpYQRpmywz/8pNdSR/tQ1pK7zuUebG1aIDYhQIXXeaT/
 WhwhKWXZGqYeAzs0uKfGkmRSfqq1FOnjy0L6R+JVOdZh1vksU3Pn8fQeNqjWnDGwzgei
 cMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713990280; x=1714595080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6k1TEiVk/yosToW5KCtbEMqzVSjxDe3oLoEdhyG1u/s=;
 b=qmRgyaBmZFC2y88/EY7+p+mvcAKo5roUxN3AOAlyEmRimFxnLD2exRjgWCvUdkzGvO
 T8XI/BAxzfE+E7Cmk63j8c7XkvyRNqBqouzwprkEMGoJY+GS3fFLDi2zU1VwmDufi14M
 RZW+HMBi9rqwICDMCwqa1WkGhzsjxvQs8KCXVMwO/nLp8frqKZB0VB/bHRubeZBIv1aL
 r3UTgMiqbXjX4bPS9TSsmJ9I6V2qMRYVO78zYb7WmvGmoCgazqXFY4V8H8fG4fdrTrCr
 TJto1nmRO835BMR+IVgQs6317jODWdJNYHbDo7FCGwmUkVOYzrYTMKrw5BvNcekcFm5x
 w26Q==
X-Gm-Message-State: AOJu0YzidUQFjYz/1PXpHdh4ndjdmJq1pRs/RFmWSXoDNq1+w1Tov8VY
 zhA5yqTSFHvHXhDFzih6zujDhGxFnhcMJtdvi/xBe9SUsx/rbxGiDqcV1XZRkCTnd6gcyWE8BnS
 F
X-Google-Smtp-Source: AGHT+IFjAy4P2BunZ2vBAbReCxsWdtAGGpbKIsRhXCgwMJf9aIMeHrx+Za/wGLdCUYmVbsAYeINLWw==
X-Received: by 2002:a05:6a00:2d87:b0:6ed:60a4:6d9c with SMTP id
 fb7-20020a056a002d8700b006ed60a46d9cmr4422296pfb.4.1713990279992; 
 Wed, 24 Apr 2024 13:24:39 -0700 (PDT)
Received: from grind.. ([191.255.35.121]) by smtp.gmail.com with ESMTPSA id
 fm8-20020a056a002f8800b006ed059cdf02sm11862015pfb.116.2024.04.24.13.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 13:24:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 mjt@tls.msk.ru, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/2] checkpatch.pl: forbid strerrorname_np()
Date: Wed, 24 Apr 2024 17:24:25 -0300
Message-ID: <20240424202425.534338-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424202425.534338-1-dbarboza@ventanamicro.com>
References: <20240424202425.534338-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Commit d424db2354 removed an instance of strerrorname_np() because it
was breaking building with musl libc. A recent RISC-V patch ended up
re-introducing it again by accident.

Put this function in the baddies list in checkpatch.pl to avoid this
situation again. This is what it will look like next time:

 $ ./scripts/checkpatch.pl 0001-temp-test.patch
 ERROR: use strerror() instead of strerrorname_np()
 #22: FILE: target/riscv/kvm/kvm-cpu.c:1058:
 +                         strerrorname_np(errno));

 total: 1 errors, 0 warnings, 10 lines checked

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7026895074..f7ffa74858 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3078,6 +3078,9 @@ sub process {
 		if ($line =~ /\b(g_)?assert\(0\)/) {
 			ERROR("use g_assert_not_reached() instead of assert(0)\n" . $herecurr);
 		}
+		if ($line =~ /\bstrerrorname_np\(/) {
+			ERROR("use strerror() instead of strerrorname_np()\n" . $herecurr);
+		}
 		my $non_exit_glib_asserts = qr{g_assert_cmpstr|
 						g_assert_cmpint|
 						g_assert_cmpuint|
-- 
2.44.0


