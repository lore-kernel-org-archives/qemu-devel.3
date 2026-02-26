Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1B8FD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdih-0005XG-U1; Thu, 26 Feb 2026 10:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiZ-0005QH-Ka
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:56:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiX-0003oJ-U7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so9659245e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121356; x=1772726156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jbj1sPJQ+uYTLuU5zSZYzgNaueHVlD9yhTCYeNJfHjI=;
 b=uLR29qqXGMFc3kNrMPM52w3emy5OfNADSbakFtnuh/0tTk9uK60xW8ter0e/eu8O94
 0Uxmp0Vjja6zyeLUob3PVEM2BSo2ebzEAm/YrAPU83DOj1WxbYvCmqe7SeRpMHOA+Tb2
 RFSbbo+Ew2jwwvXaZOrmUMNEGf9MBZgPCAdXGBrXYHW+6OwhYNLoUmOML/20Ro0waZ4F
 7heC1GbZFxOkYRYnvfzDYQ6ys0+zS9TUnemrFfJADrYJsoYItwVhneX88ladtELP0hYK
 GoKq0pdmrpE494GhMADRfsgEJfrAM1nC60oVrqTXRojwEPpAtC1A00s9ZiqPwVWX6zCf
 6K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121356; x=1772726156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jbj1sPJQ+uYTLuU5zSZYzgNaueHVlD9yhTCYeNJfHjI=;
 b=VZMZ+3ZuqIffu32itC/90lRxCnTm7qAg91uBSjsGwoeLjxRXxAOU9sA5EuuhGGo2Di
 V1vr6moIZeK1sWzRUeJ9QoodepYrddJpqOnWrVG1mEH77ZAtCFayq4peftLATOzTyI99
 Symo+8/CljXjMZVi87/qkpiB/DOytVmErwgfj5/J6ZNXM7ZfP/z/Ld6lpuiE+Vb1lKa+
 ymkNAGKBUEH3Sl5I3Vlz/q6/Yz/AQw0jSwbuXM4+tNs1YZUXyD48vb0YYnWwZAa4F7Cz
 qaehqPIgBuSr7jH/OPWMtdZMZ72snxZJ0XjP8yVxBHb8cspegcx27jy8v+0LnA3DrO65
 tMFA==
X-Gm-Message-State: AOJu0Yzmaxc3J2XVJI2n3TO1jAJCLCwBJT7zBkuTojF/a0G+3N9AWQ10
 o4O73CK8dyW183CgKZxG4mULny5yJjZnDt7xhlqDUvjS9bcyLqFzJMCjCO/0X8N0FyJfDKyc1I6
 Q1rvE
X-Gm-Gg: ATEYQzxN0xjK/B5h1lfdxw9BGFIPZ9KF1KwBawe1m/cnM7XZOkVybLxSlU6kY9XqGv4
 FreAjHsf+OQqleybWM/p/HyvciA6DowigPru5Mi3aUXuw/vZ5dF3Jcxb6DE2zyqSnUh/b7qw/kj
 tIU/QOSnTBt50iSfqY+NbLii/7190LhjzOQAJHnF4efqneJ8WAybxIMcI31tmQUQVZXFPAWMsll
 sdGqr33042ag6VSBu8hZBUOpQr6BjPvmVyle6Lk6Ij/VpNSyjdXWbuGHWWSu5tQOP+lqg78l1cp
 uHtRNd76NjCHQrT2+YnhMV+QfaYTyFJQMo6phXOW1eG7xbaWUCVSdhFFsD+0TEFDniSBCsBTxh0
 1lTyvJoS0BXeY/g2XQJRnrXn+zhuZMeYF7I4nU/Cyno9cS0J0vDP5jFk/hEvq3qxxby36eowpBW
 k0pq+VPUqV8v2/e7aRvjwwRdMh7cE3/GTVY2sVW845tx5TAsWBqX+dHsK6Sp9V+kVhDiuLDEzHn
 Vpl0KYSz5MmHgx6T3qjVq711ezTrG8=
X-Received: by 2002:a05:600c:4057:b0:483:c12b:fe46 with SMTP id
 5b1f17b1804b1-483c12bff6cmr67799855e9.10.1772121356030; 
 Thu, 26 Feb 2026 07:55:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] target/arm/kvm: Don't free migration-blocker reason on
 failure
Date: Thu, 26 Feb 2026 15:55:34 +0000
Message-ID: <20260226155535.1171290-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260223173232.453165-1-peter.maydell@linaro.org
---
 target/arm/kvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4908138764..eaa065d726 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2554,7 +2554,6 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
         error_setg(&mte_migration_blocker,
                    "Live migration disabled due to MTE enabled");
         if (migrate_add_blocker(&mte_migration_blocker, errp)) {
-            error_free(mte_migration_blocker);
             return;
         }
 
-- 
2.43.0


