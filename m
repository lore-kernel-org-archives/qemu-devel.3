Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AB5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJba-0006gM-AX; Tue, 04 Nov 2025 11:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbT-0006fP-Cl
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:51 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbR-0007Jb-Qu
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so42786875e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272588; x=1762877388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09if3quT8vnKDUHuOjmOHKUfaA1XeBQDUDHKw2iQQ/M=;
 b=B/o2x6Dmy+AJcDbBDabYOlAJXQT4O6Ryfuyo535WP54b+ci50m2gpcXusQgSL0jJx+
 aaDtprGSpf9hR2NsBPCZYfkuqLp5Yf9c0K1FbEhm1nDEHVLTSdiZrGNuZ5UukFo0RXPi
 Q8HVtDMdgPlzCVzEAGPmA6nplRtwzAKEryozNVoUrAavfSqxWmTpaAwLiYxT6+YPB1UV
 /2jBCQ7U3Iute1FKQZCHreTUwg3RmXNJqLRR9srET0L6rDkVnx+R0RR8nhB0tyBZWDQP
 1R06uDuphC0b69Tamjr4mdArnSDpA9ChH0AjD/tX/R0K4Ca3VVzhFEBMFY8of0ozP+4J
 ajaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272588; x=1762877388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09if3quT8vnKDUHuOjmOHKUfaA1XeBQDUDHKw2iQQ/M=;
 b=s4tPlMpfmmn25o/wPi4LXL61GiIGGmyi5BQOaANRTH48XdXxwIUSX0ngyMQy8BNy2r
 0k9Rj0vMbxH2o51ucwNufuKD+QQeU+OXZHqj2A+q5tMPjLhq0wrPcGdkSRqWC8Z2KM+x
 heORtzdL/D2gVGctm/6+b55QkUDaQXuGndWBpanRZ7n5pBw8EpbRH88xb7KpvnY7Ow1m
 oq9TGU27e8eCqu7Eo8aQOwv/YlJN0QMU5CPKSAF5acStDyOvQmt3KZnuA5dT3TNqreBu
 4hSsOKbFRtFKi2E1Luxg9T0BG9o0BIBeF269q1bGIKWqTsWGH6tQvHkksRmfVysyMnHu
 mNQQ==
X-Gm-Message-State: AOJu0YykSJYkQUmMtkkrKa4UbLTXTTXh98llf5biGnAmR61jS9T0c07w
 dIGDtFeJ/jUU7bomPgXEpO0KAOo6AbB75lOEMNQQ7sy0MUxX3KwrJIGI/zkD8CGQOqqL5nb1xsU
 bSWum
X-Gm-Gg: ASbGnctkTBpAzru1gMd84cCaDj8e8Xx+qNm/gg1FBLf/L3UY+wWZ5FaU7Bqv0Q+1TpP
 mDKjYfwCVdXEEQPxuaBrkpTjPeyJKmaFBKyTjf/7wGMJoXPVl3CMeB+V/RBk+vQvxRrQFE/gWwo
 JH9p2YvC24Q4YRwweS3OpRCxYIIXblttBvGAepMg5mZ1e3N3Czxa8or5cBHxfv3f5OFTrcygSu1
 sQn4P9PyCM6x+eH26Ez1XUjzHtIYqtV2DWQAoe4hPSheEL5YaK26XYSY0/E1ZznjV7DNwZ8aBOk
 taL2qzcfo5CF/wOrH3RvkPSInLgxC3uvE0Zbl9HIKuyWMriY8PfYS+XPTxGyu9fRWRncF0hmCYr
 ZXAUiQP5suLceAhmkXv+LV+qAaZf+QFdiiL/DayNgmPr+1XwR+kvNgwyQE2yJ+7m8e0MgmxvtJ1
 J0qp+nDg==
X-Google-Smtp-Source: AGHT+IFX0GrZA0QuN2x0bkKN4Rx22FC1wg7I1DyDOBg0/AbdhXmBriUU9eZ452O+rttpN5Hl36E72g==
X-Received: by 2002:a05:600d:8346:b0:477:54cd:202f with SMTP id
 5b1f17b1804b1-47754cd2267mr23515645e9.3.1762272588133; 
 Tue, 04 Nov 2025 08:09:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 2/9] scripts/clean-includes: Remove outdated comment
Date: Tue,  4 Nov 2025 16:09:36 +0000
Message-ID: <20251104160943.751997-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
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

Remove an old comment suggesting a manual shell line to use to find
files to run the script on. The script's exclude-list and its
support for directory names make this irrelevant.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 07c0fd44e46..568033ee9c1 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -39,15 +39,6 @@
 # removed.
 # Other files (including C++ and ObjectiveC) can't be handled by this script.
 
-# The following one-liner may be handy for finding files to run this on.
-# However some caution is required regarding files that might be part
-# of the guest agent or standalone tests.
-
-# for i in $(git ls-tree --name-only HEAD) ; do test -f $i && \
-#   grep -E '^# *include' $i | head -1 | grep 'osdep.h' ; test $? != 0 && \
-#   echo $i ; done
-
-
 GIT=no
 DUPHEAD=no
 
-- 
2.43.0


