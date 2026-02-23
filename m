Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA80AEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZnU-0004kC-Oh; Mon, 23 Feb 2026 12:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZnS-0004iN-Au
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:32:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZnQ-0006z3-2w
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:32:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso30680635e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771867954; x=1772472754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5T7sRVsjsc0vAswkiMt0T0Tfylq5nMVM08uSQ21feNs=;
 b=ZXmbh9y3DFDSSbMq1rFdD5RZjsXoaqGLdHSVMrhyPUL5Fo30CBQgREA52f9YcP4U69
 6eAGccQkG1m56S6njEc5rO4Rh4jqssQaSF+PGY9Cnd2RTRYRoZSJM3I9RSSXddVq4iQj
 vjiUZLa0voMm89atvkYwqUuADfG+LQuY8gd3sAhedKVmyIemOEvV1tQWWy6oCDc4AXeN
 cs8orHt/j9xEMCkU/N0DvDPo2hXsF7qd7MFhgjN2jWaY76AneJUeMuRJRyUeS6yme3M9
 8mvxObrBRSiEc856juHWTLSapqzrnf5zVnPwYC1n/NMpPK1i5TY6BNciMlP1hWLQj7Rq
 7XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771867954; x=1772472754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5T7sRVsjsc0vAswkiMt0T0Tfylq5nMVM08uSQ21feNs=;
 b=Gw5hO9YgPiyzDaQ1mZIXz83XBuvNUAF5iDHkKSuL20mDBnTF8GPzXB0CI47TU1uZOG
 NcdacNL8muWeWroeDRm3JQzbBfD55gA+uqSNNmNmyL5xYQrP/ymJywgVWz3WJcmScrTs
 dNwhsfLUl0HidEZEfdgxcpWS5RZJL1BKeyDweGRNZcU1F9hrTwG7vfbpV5aZqCwFCeZe
 8D5tdrWmYKX5GsE2vl6S6FFGEdXlzSw5vX5PBKSIrwEuSYH7I3SCaxpyE7+My2zSdU4A
 cB3lMajRe5AbcabrjuVBuHdTSN+fAjzDmQPktY1XkMFQnotu7c2CPOGhyhot8yygC4ye
 46Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUttcOj/huu54hyXNqR8+7I+QXkWo6JhjU9m8QKQox20Ff0HEZoWL4pHKPjL8UoJukKOlaR56JC5UXs@nongnu.org
X-Gm-Message-State: AOJu0YxLViM/r3dy/fHR3kWiaw/gSD/qjYCjj9z1UmKYMxgdLchAhHjP
 /546hHVIKfW9jpVT8EHKrkwit69CIFOumrwXqJhUvhdyG8zcfbBuJNgryKRoWSTcLB8=
X-Gm-Gg: AZuq6aL99SE7sTLCxkVfLh7gFLjPLFnYcGMOKezOZJNmKG9KjYUWO9YuDW2+r1Td7W+
 uPsuw2Ektd6ZlCses4Nnf5FHACV2mTn/6uFLQLxNTzCYs8NnCDnzYfqgpRliNGP5CALuFBVyV7i
 rQSBl1q8jA5TuY41Flo2oJpO66DppNm+g7dpspX9DAqgZiICDEZK+rGpqykB2wTp40LqZYt90dU
 aomGq09FSgV4lMPsq7ujTD5wmLPqSf6Cg3KHPnd9z4jL/oth0cnpQ5C46yse8ZLwnUglQf35QPt
 cITTZ4pMxZScUeagFSYo2jrnIUq4JMiCItkuafW6JvoJ62TwHF0elIiDWlPpgdi2/tk+2v5j1dZ
 9IpY0KgUBLRFdJCdGMLg5e134gu/mXa/oDSftDxbcvUwW4i/2OsX4Z0syqv/9BM7f83iVYEIorD
 uKna2nJdxXtnmaRUs2R9+P3gn+rOyuBhcOtU/eljaX2cpse9QCbq594smSQf1OeXXIFZOOSFqYY
 ZQBwUTfrg3wM5Z2v0ncUDWq70zys+FfDx45Vxi5SA==
X-Received: by 2002:a05:600c:3e11:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-483a9492398mr157257695e9.4.1771867954184; 
 Mon, 23 Feb 2026 09:32:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483b823842esm725145e9.10.2026.02.23.09.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:32:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm/kvm: Don't free migration-blocker reason on failure
Date: Mon, 23 Feb 2026 17:32:32 +0000
Message-ID: <20260223173232.453165-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The migrate_add_blocker() function documents that if it fails it will
free the Error it is passed via its reasonp argument and set reasonp
to NULL.  That means that in kvm_arm_enable_mte() we don't need to
call error_free(mte_migration_blocker) in the failure codepath.
Doing so is harmless because error_free(NULL) is permitted and does
nothing, but we can remove the unnecessary code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This seems to be the only caller of migrate_add_blocker() that
was doing this.
---
 target/arm/kvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ded582e0da..388766c846 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2540,7 +2540,6 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
         error_setg(&mte_migration_blocker,
                    "Live migration disabled due to MTE enabled");
         if (migrate_add_blocker(&mte_migration_blocker, errp)) {
-            error_free(mte_migration_blocker);
             return;
         }
 
-- 
2.43.0


