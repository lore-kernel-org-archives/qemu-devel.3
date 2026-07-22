Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C841C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaO1-00059S-Gp; Wed, 22 Jul 2026 13:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaNz-00058t-Ao
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaNx-0001Y9-Mc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4956869750eso14249545e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739932; x=1785344732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NiCfracLLvn4exF/YmQ5C0p8DSUHbxX5ZlcIeQT0Ajo=;
 b=i/3x59MKEZ9QRKMjDAly3dUSvyvEpN0wH5LW5GTm9FxgxXS+e4hNDDsPmQ+Sc42Vy2
 oaD4poN1SqGDYOHziyiyEZUoPYONtK6ae8ZXZprtWlvvTUkat32yFby60zOLWBYCrBQ2
 GmkaW82eENIkPWW3Z+ZRuOoG2ZUUCXt8C510fDMEn6pAA/po2e9CAROXdsUO5N1W9JDP
 ZOprt4od1Je09rW2d+5LlyPWNssvl6waOyTarvTofmLU4eSv8bvFivo+hLRpvh3EfvGS
 jUatWMnGBqfZJ7JTZQK+pJVETf5lZTiXXsS/rVG2tzudx0/5CzicEbIyBfsNycY06w3v
 Vo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739932; x=1785344732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NiCfracLLvn4exF/YmQ5C0p8DSUHbxX5ZlcIeQT0Ajo=;
 b=ZwiCNMhZym11rmCCVeNXmB8eLYOQun4FaaNPNWpPxZJx6f1+Ql0Sq7VH58tjHV+Ztq
 YqO6MRMXOz1ABLjdco2BCu72wj4cUAUzDyxknUSopTOn6JH9WChTgpOTvoaf3vfpCUQ8
 fnVoJDGm83aVsF6KLA/m4U7nTMPsq+8EpW2+sPyindFAOPQVzX+ep8hk7+LHEl1cR2iV
 yec1mOH4V2JFK5b0joGGixkZ538XwZLrZ54Bwgo0ThFs/bAUrBu0dW9Snp6SnB4jcsJq
 CWFKsK+CifnAd/VObx4dBDsrE7myjow5YpMxJc/uya2izMps/Uf031jTfvXYF57E2ZDn
 JfbA==
X-Gm-Message-State: AOJu0YwyMsSiXmed+XKo+KAXEQpQ7+1nb5qovqHVbEGx0vDsQqsCSYIi
 bhwFSlGad99+r8ztgEhPn1Z8KakLZJaxbJiA3xJwboU1PoLCq9+1n4cLNT79vNj5LYi0/690iSX
 yu3sp
X-Gm-Gg: AR+sD12IvHLZsBio2ACs/I+LO6m7gZIiJRdI4tlKCYrDWJoFpEDEmwY9fP0VSSxxMCU
 tXZQQi5GWsrF+jtLLaUsJ5ZqwAYr1e5+tVQqNlV33pxcuIqNSavi4vFHmVGqMKCwRGqIuG8tXel
 D1ERDiR0J0xUeUu0fkdVibjsukHiyZg7EBtqt+OWnqdXUxDsrmGTqyH+z3scXgpJGDwarZKi9NS
 C9tQYcqhttyvYdCk2ltJfh+q4bLPoo9/CalzJ04Nh2j+MOEMpuVbGAhAmlr6/CrCVixmbhanQ6G
 s8HyBI7PaUyehfOydF1Kdk5jwayKOyj3SRYLSogijl51/tR0/nK++lMUuEcJQJHoGe+kHT3RTr3
 Azc1AIB8i2lFGsu4q8KV+XxDI6Kpm7a2T3lpD824duJP19rVIxgQ6tnTu2vjgzPh/fbTqNVn55P
 0=
X-Received: by 2002:a05:600c:3515:b0:493:be13:98b with SMTP id
 5b1f17b1804b1-4954a50c47emr257354455e9.23.1784739931698; 
 Wed, 22 Jul 2026 10:05:31 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
Date: Wed, 22 Jul 2026 19:05:18 +0200
Message-ID: <20260722170527.2593225-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

This series fixes a bunch of reachable asserts within parallels
block drivers through a specially crafted images.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>

Denis V. Lunev (9):
  parallels: fix integer overflow in header size calculation
  parallels: read header/BAT table in bounded chunks
  parallels: fix bat_entries overflow in image creation
  parallels: reject BAT entries pointing outside backed storage
  parallels: validate bitmap L1 table size before allocating it
  parallels: skip loading a genuinely empty bitmap L1 table
  parallels: avoid fatal abort on large bitmap L1 table
  parallels: validate BAT capacity against advertised disk size
  MAINTAINERS: update parallels tree location

 MAINTAINERS                                   |   2 +-
 block/parallels-ext.c                         |  52 +++++----
 block/parallels.c                             |  74 ++++++++++---
 tests/qemu-iotests/212                        |   8 +-
 tests/qemu-iotests/212.out                    |  10 +-
 tests/qemu-iotests/tests/parallels-checks     | 102 ++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out |  59 ++++++++++
 7 files changed, 270 insertions(+), 37 deletions(-)

-- 
2.53.0


