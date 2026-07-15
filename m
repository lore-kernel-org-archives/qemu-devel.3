Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CE6C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjwxF-00041W-LD; Wed, 15 Jul 2026 06:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwxA-0003zZ-5Z
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:35:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwx8-0000vE-F0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:34:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so37729835e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784111697; x=1784716497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqCHlCT/qklGcub9P4p3p6WygT/7lJQfYfoI/OJ3UEo=;
 b=atl/JfPVOC7JI3pa8txHj00KWQVKxZ4ZdNF8kmQVxbSRK05IhG6clkMMwaa1+8cLXw
 YgUUWvbDxwAjgn54RSvP0gjMmIu7atsz2SPTrJbFK1Ntz1/jKue+qmvcvpdIWD2TEfbJ
 XhjBXztLYVb5saQHBJ5Dzvxlthi7jkmD5y/U7W5p5QNQcjvBdrs0PBVl6us9xXqOFKQM
 2XbrAhMlULOR8hFN3G/UCdcrXxvZEkI/3mdaFgs+sAdSYgBKEUg89wRVtrXQ2Rt8imF4
 qnxANEyQjygX5Yne+MuKcBLxx/FyStGKBFaR3Z9tZPDSnFjVqhR1fBC/XmE4aNkgVu0N
 zXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784111697; x=1784716497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PqCHlCT/qklGcub9P4p3p6WygT/7lJQfYfoI/OJ3UEo=;
 b=Tr7QvKxCPhUC6dErnGUonz1QOf10sfdT7dPAkx2yV1aUkfAZcvbjdjVFAqmwD35oZM
 D0mdUWYuaJbRMWpcH1uMKIpxeM1XZsDz97Sr2kbx0c+tIgjGYe2gntyG/3pw02XNSeB1
 Vk7O1QDy4GYuyvrhTYA6cVyR7zTJzTmoCBaHRFqQLjBGFnqLLrLo7xW73YLUP/tXf1wC
 wuQ6vc28ujbbJNbNSemOUSxHk5Wxbnag4f/yANo/fa3EbsyO4nbOg/0nZA8y/Unx3WDu
 sZY3qnELc/YRxyKboLdUBay8XQ+j9g5w/QADKcUgU8E57DmVA3pnBEJR295F1rFeiuvc
 5UBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI4ruP3MOK8R8NQAPEoUyIbIKlQJNoatlq3C5ItRFe7QoI2TK58fenQPUnf8mIbMM310jpL1spObod@nongnu.org
X-Gm-Message-State: AOJu0YxR2CtAeTFZdDWlnMA45A29Yc1iIiu0xnBCpQMTJJh9gEhfCDoo
 DtEcBiUuDVPV58C8TxQi1DLu+rDw3sNjxpuZRb6yM1F1ekXHRbG5CnlqV4P3uTEd8UzTcYe2aT+
 AtAgjdrI=
X-Gm-Gg: AfdE7clW8QuDrmcGakDjgzadCMTssNBkOX5wVagPhu9FEuW1bQWCha9p4OzRkLoloXZ
 N4recOlCTMNEeBqsdmcGbCryBxSvuhlq4Zd/oH+5GqQ1vhDC+R7GKPa3EWdmBc3YOKXjw+/ciAu
 NIxwXvHhMGoWxAdQPpXpPRJERlGK5PhBaltjZmI2Rdbga/bw3sRYEqG5K2gpM1a4fU89hzKREb1
 ZhBDIpFhd8YC9p5QtLIyP/75xrl58Bui3+69DRPRlwy/NXb+1LT+qn6Qx710EX28zd7O2xKe+RL
 CWyABDm24eywL3wp266aY0wZiw2lpH5B3sC9kqrsS8CiEEmnVVguklFFqe45aGiY1vEwy9+EANf
 OEIHDYwcLRe++JFWgKPtdrq3I3HIO+givysyx7ruj8698TvH2kegjK6KWKu/HxdqHBwvSfUvSzT
 F0mQ==
X-Received: by 2002:a05:600c:8285:b0:493:e46e:157d with SMTP id
 5b1f17b1804b1-4953c273dd1mr26121025e9.19.1784111696955; 
 Wed, 15 Jul 2026 03:34:56 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:c44f:405f:37a5:5992])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm17292644f8f.18.2026.07.15.03.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:34:56 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 3/3] iotests/migrate-bitmaps-postcopy-test: replace the
 timing assertion with a content check
Date: Wed, 15 Jul 2026 12:34:51 +0200
Message-ID: <20260715103451.1930909-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715103451.1930909-1-den@openvz.org>
References: <20260715103451.1930909-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
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

`downtime * 10 < postcopy_time` was an unnormalized wall-clock
heuristic (commit e80a4150a5) that fails on fast hosts, where the
bitmap payload now transfers in under a second.

Check the actual invariant instead: right after RESUME, bitmap0's
content hash on the destination must not yet match the fully
migrated value. Throttle max-bandwidth first, since all-zero chunks
skip the payload write and would otherwise let a fast host finish
the transfer before the check runs.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 .../tests/migrate-bitmaps-postcopy-test           | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index c519e6db8c..33ff2b861f 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -160,12 +160,26 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         self.vm_b.cmd('migrate-set-capabilities', capabilities=caps)
 
+        # Throttle so the chunks covering our discards (the only ones
+        # not skipped by the all-zero fast path) can't outrun the check
+        # below.
+        self.vm_a.cmd('migrate-set-parameters', max_bandwidth=16536)
+
         self.vm_a.cmd('migrate', uri='exec:cat>' + fifo)
 
         self.vm_a.cmd('migrate-start-postcopy')
 
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
+
+        # bitmap0 can't already have its final content: that requires
+        # the bit data to have actually arrived.
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap0')
+        assert result['return']['sha256'] != all_discards_sha256
+
+        self.vm_a.cmd('migrate-set-parameters', max_bandwidth=0)
+
         return (event_resume, discards1_sha256, all_discards_sha256)
 
     def test_postcopy_success(self):
@@ -186,7 +200,6 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         downtime = event_dist(event_stop, event_resume)
         postcopy_time = event_dist(event_resume, event_complete)
 
-        assert downtime * 10 < postcopy_time
         if debug:
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
-- 
2.53.0


