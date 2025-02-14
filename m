Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC03C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 10:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1titN9-0003EC-Vl; Fri, 14 Feb 2025 05:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titN8-0003Dx-QT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:38 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titN7-00068w-DW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:38 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so34819525ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 02:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739530596; x=1740135396;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9RC6MJMkMFddmaETe/J83cE8JOgsz6X2WCSfCIYCZQ=;
 b=qh13ko74I1pL260zYrxEjcda/ZDVGHwWIHGdz2TvrJ0v0zONPWAqH6TyBR/ts+uwGX
 jizp/oleph8YF/xdjvVTEhFSKpOXjdQ94KJN8c2fau0TSrqF7U7voApKhAGGlz1gUTF3
 miXHKZZ0nwpzNqZxon7H2vOF5i0CT2IJk7dVuX2U9Q0lCMXNf6WaD6obZAHLbBl7TXeY
 CTwOk1CSiKP4SwbQqrqvyesCQT2Px3TMmp4yWnCziUKCTugfxUNSzmSBpPslL3XtU3qF
 VBNU8osoVMnFpUQsk0Zs/1r2zKXZWIkSdSGi5C8RJgt1Av6+xncR1FYmSpTC7+hmBcTj
 3KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739530596; x=1740135396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9RC6MJMkMFddmaETe/J83cE8JOgsz6X2WCSfCIYCZQ=;
 b=r4yXy7D4IYOMC9V8NJrp/wCZh/hQlWlLRjkCPxOBdpWf8EsugTx31AdShSXdd1QMrv
 10B6dRkoqYQQJosQ8VWZLQSu75Yt200dV+CJ3LsRTNXstEXMvIikYcEzYsoqt9i8Gv0O
 wIyTbsKsZ4FZgRCKKHJeGP8EBOcX7vuthoD/mv88z1apOb2trk7zuRJcGjRZyGn6fmBk
 Ci9zJioaHJRy87E+kxKYR4G1enWx1zOJH8PjefLAZn2hxvP74vK9QVgU/MpSGyIC637F
 qIvBFBhPEspdTjtkzo40zvcNVS0j6a7WgXZr4w5Yx39WgIiz2UzRgCMFdg9sOBS7+Y5x
 c7OA==
X-Gm-Message-State: AOJu0Yz2Kozrs73JM8EngZYjPKHBXQw3qw2aTRm4vhGJZ6yXdpPOyHc2
 dw34J2aSbTVZWFS4E0KCW7YJnUusXVUrmxeBt11zhz2ZIEBG3Tyzq1fk5S/pJegrY01FTRjR/pE
 hmOWztw==
X-Gm-Gg: ASbGncu/bVTFVXy5azgHJrcewKiGoeA1P3srFHPiV9WYwwjqyOFkk3vQVa3fVzeygXW
 ZRUSYiZU2eLeEihKIy8cPZ68xVlhnpXsz4GIOq96xc0CkD0AKKmrBEKnBu3rhqUSoxTH+i+DjZq
 JplAaOa/PP3bZK6XS5NqBbjLLsrMnW5JPdb1xdTdSs9WOJsU7qOUEsBr+Yn2cd2EChlHkSVrfyQ
 J18evlcymNwqIYEbPvSL7KKLLlbkgwBPVlg6vrjhGnuAcrQ10px+Wp45HIZXNZJD4KboPkVycN8
 YQSDDRQXrbUueCDs1tzp7JwNE0dmtPfDYdX1vXCY
X-Google-Smtp-Source: AGHT+IEWKI986gekBhsLte+HVdc3e6GzoxcAUICOEAjxzeZ4R+CLIGPpS43kGK9KD9/D/Zy59OC2dA==
X-Received: by 2002:a17:903:1ca:b0:220:d257:cdbd with SMTP id
 d9443c01a7336-220d257ce68mr113327545ad.48.1739530595599; 
 Fri, 14 Feb 2025 02:56:35 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add0987b223sm535013a12.17.2025.02.14.02.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 02:56:35 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 RESEND 2/4] guestperf: Nitpick the inconsistent parameters
Date: Fri, 14 Feb 2025 18:55:24 +0800
Message-Id: <c8e3768c0d21b47456ad80376ddee63122d60cf7.1739530098.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739530098.git.yong.huang@smartx.com>
References: <cover.1739530098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/migration-stress/guestperf/comparison.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration-stress/guestperf/comparison.py b/tests/migration-stress/guestperf/comparison.py
index 42cc0372d1..40e9d2eb1d 100644
--- a/tests/migration-stress/guestperf/comparison.py
+++ b/tests/migration-stress/guestperf/comparison.py
@@ -127,7 +127,7 @@ def __init__(self, name, scenarios):
     # varying numbers of channels
     Comparison("compr-multifd", scenarios = [
         Scenario("compr-multifd-channels-4",
-                 multifd=True, multifd_channels=2),
+                 multifd=True, multifd_channels=4),
         Scenario("compr-multifd-channels-8",
                  multifd=True, multifd_channels=8),
         Scenario("compr-multifd-channels-32",
-- 
2.27.0


