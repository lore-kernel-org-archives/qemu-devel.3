Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A795C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDqv-0002Tl-Fk; Fri, 10 Jul 2026 12:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqr-0002SV-8o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqo-0006bQ-HA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso9683115e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1783699997; x=1784304797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3p5PUASyHfF4eEZ7QhRrsGOCqAhKmkzJnGDOtWRz5lY=;
 b=tRsWcJWTj8j+7fv1Zsr4INu/NVu6ogKNBaL9eZR0CXKmcYetlH+7beVKqEsCSWxvbE
 IRDzMclNHUwbsllqrKimVn1WsdpWcdDXYLvXIOCRtKYga1DvOxfJgk3BS7uC+hSBe9Tf
 U4lBE395KeopLHlqoEZAWYnG8e5ZAZZL4p79FeCtlmBg698bhia3f2RB6nBv2A0mNRQJ
 B9TheJTsm9INdyoZ3ZiKwx1Y3XIrhGVUqt+KCuBbwpzzZR50+vvP0AT1ChAzPDR5H2nd
 RcrOT1baKIMQ+Gw53Sx46vwDF0OOEe5D2c6Y7ijV8rrM9E7CNCD+BaXgtPkt+5oUN/I0
 obRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783699997; x=1784304797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3p5PUASyHfF4eEZ7QhRrsGOCqAhKmkzJnGDOtWRz5lY=;
 b=OrXEmQqu4r+1t0W8ba5juMhQbC1mhniFUfi0HlFXFpnbhHRMUlD6WfK5ylwi2iO69S
 22GUaigg7Q7390KQjRbFc4taoyv4p3CJ7Fqje3MMHd9ewHYqcjPEd072OfmLXaeYcFOE
 t05kd7n7Rb9krY7I7LJGNIRqWAHYu+t9i/W3EZeosCdHRFeNGk+JyrGkaJv6HYvN8XNb
 RhT69JgtsjFuwBxodJyAPczOyApWcB8Wot/FY6bpaKTkvURqX9zr3L5H4tXECM1nZyxg
 8rk8zK1eF9lsgT54cuuQbrY+tZYvzEbP7epR8etO5vmpx6lHwpxWe76tDclBosStvHJv
 OnYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr876sGQ7nkF8utsWNR+/3DWEHXchUO7Bw72HTY4xlBpEjdEjOkm02uzM/i05W96NWZp+2f6ibeeg/O@nongnu.org
X-Gm-Message-State: AOJu0Yw5VCFtb3yrsyqrT4NE3IGFI9noVVwD//BDngJgTYuy3UgXzLhQ
 LlC7c4wguRvuz6WqK2zgg/9HT9jjYWUg2Ln/p1iD8r83pyTmMaJTvKsE9XJENYt9w+k=
X-Gm-Gg: AfdE7cm/+Fcff4cFCuEMyai2rS5O8aeaYc5nIGNU74I1nP70rXJ5JrJfJzs4hilJPun
 xQzA/jSWh2d5zWd5LxcAjdaUXUJTpQaU8bbrUKOGM12++3pehVUiQK/xKDKB64TUaZHo4rvkgGd
 7Ua3ibO0FJvEDc+FFyuNhTM4/lkvm8Q+2YhXQ5qrDMFOfDtTbLuZaLlSRM3bwgan9Gasy1ChY34
 RXzVqYjo45Ge4pu0POBsgmUeGLG0sYU0T1xr9lRwocw2C0SSsu63nj/JbY6KCVwCiLd34ujQsNh
 yrKqGpI8QeGSQC2brzFjA6pRAQHNyS2iWeHY2tG5OtgjIr6V/qe0vOMO4QsjNZOpuehYkT6I8dS
 uSilb81f8y40IT0CZGl8Jb+l6/yjRGKpDroBpl2eZHp4ZmjoIn1ZOql8OfYasatZ3gesedyoesw
 rTaQ==
X-Received: by 2002:a05:600c:354e:b0:493:d216:ed96 with SMTP id
 5b1f17b1804b1-493e68930bdmr129365835e9.9.1783699996986; 
 Fri, 10 Jul 2026 09:13:16 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:5926:51ec:1f64:b9b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm59944836f8f.33.2026.07.10.09.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:13:16 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 3/3] iotests/migrate-bitmaps-postcopy-test: drop the postcopy
 timing assertion
Date: Fri, 10 Jul 2026 18:13:09 +0200
Message-ID: <20260710161309.1104712-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710161309.1104712-1-den@openvz.org>
References: <20260710161309.1104712-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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

test_postcopy_success asserted `downtime * 10 < postcopy_time` to
confirm the run spent meaningful time in postcopy. This is an
unnormalized wall-clock heuristic tuned to old hardware (commit
e80a4150a5), and fails on fast hosts where the bitmap payload now
transfers in under a second while switch-over downtime stays fixed
(e.g. downtime=0.6s, postcopy_time=0.8s).

It is also a weak proxy for the regression it guards against
(postcopy degenerating to precopy): that is already covered by the
bitmap sha256, mid-migration update and persistence checks, none of
which depend on this timing.

Drop the assertion; keep printing the timings under debug.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index c519e6db8c..f9c55b6395 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -186,7 +186,6 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         downtime = event_dist(event_stop, event_resume)
         postcopy_time = event_dist(event_resume, event_complete)
 
-        assert downtime * 10 < postcopy_time
         if debug:
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
-- 
2.53.0


