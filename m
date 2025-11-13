Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E24CD4F3E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 03:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJNc3-0006dq-8w; Wed, 12 Nov 2025 22:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yshxxsjt715@163.com>)
 id 1vJNbn-0006T5-UI
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:02:52 -0500
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yshxxsjt715@163.com>)
 id 1vJNbg-00023X-Vx
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ra
 5/RBkmbEXYG5nyuX9E2IPU2e7dR6TcxH/WLoVIYuI=; b=GlBV7cV7GV0A6xxTOQ
 jatnx+Z/6jSis/gkc7NZXa0ctbbNYqxz8+N1Vct39R8oqS2OZDSZtNxnZfnPuMOL
 Q2X5a14VCey/CEMrbYhB9A7tolYC+hM8cUAvb0tP1CI9jtkYxbXisNeR4ZcpgM9i
 GGojukS+tS/DczunNbp43DxXI=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgCnNvtHShVp45AnDw--.29973S2;
 Thu, 13 Nov 2025 11:02:32 +0800 (CST)
From: shenjiatong <yshxxsjt715@163.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	pbonzini@redhat.com,
	shenjiatong <yshxxsjt715@163.com>
Subject: [PATCH] rtc/mc146818rtc: fix QEMU crash when time runs backwards
Date: Thu, 13 Nov 2025 11:02:11 +0800
Message-Id: <20251113030211.6283-1-yshxxsjt715@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgCnNvtHShVp45AnDw--.29973S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy3CF13WFyrGrWxtF4kXrb_yoWDKFgEga
 9Fqas8CFW3AFWfZF4qyw17Aw1Fk3yIgF1kuryqkr97KFy5Gwn8CF1q9r4kXFn8Z3yagF43
 Zwn8AryUJwn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRttxh7UUUUU==
X-Originating-IP: [113.128.83.105]
X-CM-SenderInfo: h1vk555vmwliqv6rljoofrz/1tbiJhsFL2kVRxdvWgAAsO
Received-SPF: pass client-ip=117.135.210.3; envelope-from=yshxxsjt715@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Loosen restriction on computed lost_tick. When QEMU's rtc_clock is set
to host, the walltime is used for mc146818rtc which requires computed
lost_tick to be strictly non-negative. But host walltime could possibly
run backwards, for example, configured by NTP service. Under such
circumstances QEMU process could crash unexpectly. This situation is
easy to reproduce for Windows 2012/2016 guests.
---
 hw/rtc/mc146818rtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 8631386b9f..04185eb6e9 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -173,8 +173,7 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
         next_periodic_clock = muldiv64(s->next_periodic_time,
                                 RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
         last_periodic_clock = next_periodic_clock - old_period;
-        lost_clock = cur_clock - last_periodic_clock;
-        assert(lost_clock >= 0);
+        lost_clock = MAX(cur_clock - last_periodic_clock, 0);
     }
 
     /*
-- 
2.34.1


