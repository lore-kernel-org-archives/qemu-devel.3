Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2629AC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGZ-00085Y-5Z; Tue, 28 Jul 2026 06:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGX-00084Q-UX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGV-0008GV-5A
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:29 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fe400c14aso3782792a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235346; x=1785840146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6peXfCAI9PBCc+mW0GS1f5pARDqtu1ectajEcLcGxc4=;
 b=f4wKxxHdnTsneEaYLagWRIZFAxSij4aqiitL5/2Olx3WWwSXXu3otwznP4f8xx20AY
 9XFsMYdaNqCa5QIldQCiBLRqh4T6HrWdvTadHqgm84Xh4F5gCnrjdaBliFS0OmcKZBiW
 Nl8j4/dTpMpwmObkDNf96/Z/kfgBJI2P7sfnAUuByrNTHcLpqQBkhiXISIpDs4lv4EK4
 epUkmHf7wij7GmI8FmlBy+ze8oBPYifh78gzOkuJ/ZiJ8XNO0h1yThZpiCDmg7JoDPXG
 h/EXrhffRUlGV5sLdgXD6S60rc5gO6LoaUGWTGxyjmQvROqeqg1OyvaO0KmwFhf0wsc0
 mLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235346; x=1785840146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6peXfCAI9PBCc+mW0GS1f5pARDqtu1ectajEcLcGxc4=;
 b=RWNjeRSjo9LOxZJ6lrlX+GzvTVA9cJk78utPGPuqunlkI3h+DtbCYQMKrOkycmKj9G
 aO6jbUwQQrXqdiP9tk8GNZws29oRXsHi2LsEWyI8LPtfGGF1rADKftsC8GYY9SjDe8J4
 F5Imd3Ca7ZkORwgz8gpGODQQU1yQNCXQcicNITHeAHGjxux9AbJyUJDrbtmxeoRQCZti
 h1Z7wOIR1HGMg2U2keC96dH+a2kAGxFaQhidEhcxbRrc7PhoAqTd2xnRsFqeAp+OU9Mj
 1yImYrQ2PUFmJKD+cl/6raYBiMjwQGFnp3v/LqnI1oFNjjoecrJo8Zm33+G8a9YSVzpO
 7oJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoH22UBYVUUo0jGlXnbKyqzjDYBtB3OrXU7l+Mk1D9RjBWU48gDHz6sy3ZRKJlDRZOYkKstXwXrwAdV@nongnu.org
X-Gm-Message-State: AOJu0YzcY1qJnyKoy3V1eK0XVVLZopOHHpWsWZs5LVhmE2FYmY5fDOt2
 UAXzXvd+2XS9G85AFnJ/70IC8Tj2CnMbmjIsaspJHmnklTAYS4cBoSwK3y7dN2ZH9Kg=
X-Gm-Gg: AR+sD12WreBvpWFzfMeGUpa8WHNgwSE+KqxjUhqKaimxBtGDm7vVRU5XRaZ7j7dIy3Q
 Bg6xmLBLbHeGDOuqUPkOr6u9F+/fS11OOISzi0b10EHAeGta34Hq1UrUI2HXCpjsbnDQHmvkfeT
 freVcLIiex2IsCeivMKXb3ydriG+jZsE0qefPR5WAFVkEcVwD6LKK0Xw+Y5GgRqwUtrPzW9kXPv
 tJ+SnkADZhoZ1ZuY2zpH9Crk3DEnOmZEdkq6hl5zLSycqf817r/CT2Kkzp0DSF/bT/GSi1yV+An
 jLzu/vhbxHEvICr2jt79uqoenpk3RSBvRN4ROHM38FGyV6GIlSF3Tju6rS3wzjU9knMZzkYJxip
 iLSzAG+0vfqtGnA/k1O5BAbUWBHLtHzXN5ydc4AnJdh/XZRuSv0oHSj1i/zCveqdG4Q==
X-Received: by 2002:a17:907:3ea5:b0:c15:ee0d:9a32 with SMTP id
 a640c23a62f3a-c1f71d86427mr93044566b.21.1785235345700; 
 Tue, 28 Jul 2026 03:42:25 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:25 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/9] parallels: fix integer overflow in header size calculation
Date: Tue, 28 Jul 2026 12:42:13 +0200
Message-ID: <20260728104221.3981592-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
References: <20260728104221.3981592-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=den@openvz.org; helo=mail-ed1-x52a.google.com
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

parallels_open() caches bat_entry_off(s->bat_size) - a uint32_t -
in a plain int before it feeds into s->header_size. Near the
"Catalog too large" bound the value exceeds INT_MAX and overflows
on assignment.

Match the cached value's type to bat_entry_off()'s return type.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 7a90fb5220..59f00c64a6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1240,7 +1240,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
-    int ret, size, i;
+    int ret, i;
+    uint32_t size;
     int64_t file_nb_sectors, sector;
     uint32_t data_start;
     bool need_check = false;
-- 
2.53.0


