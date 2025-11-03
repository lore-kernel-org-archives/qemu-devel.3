Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B4BCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1m1-00017J-5A; Mon, 03 Nov 2025 16:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lu-00014t-Ta
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1la-0005Ny-RQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKv6Wkq2k6ueU++W0j4Jpj9adHe/TBCqtH0wdQ1hQcY=;
 b=XhNkuqvE/4kelBpna9X+yu15ZQz05hpbYhLh2SSJ+SakeD3CNCLUuW1IbgRn/cCG5X9PZi
 bgLK15xVQBxK7dmwU+CSGZXvWb0NOx8kg+pqzYzKVquyHOWQ2mlQMaceqhSmCZ2jjxelma
 yrXDjq8Du4g8Syixw7WYMkV8kxUpuyY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-0jqamX-kPXuYaeLx3TLLPw-1; Mon, 03 Nov 2025 16:07:02 -0500
X-MC-Unique: 0jqamX-kPXuYaeLx3TLLPw-1
X-Mimecast-MFC-AGG-ID: 0jqamX-kPXuYaeLx3TLLPw_1762204022
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ecf0501ec2so100538401cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204021; x=1762808821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKv6Wkq2k6ueU++W0j4Jpj9adHe/TBCqtH0wdQ1hQcY=;
 b=aaX586yEWG2SfjXHv6J3VNgXBRhhmNXsSlvw2SE/d9byeed5VqeYnVVHhnFlcN4X9m
 h9qsCJ6W/7UMxBanERr60uN0xIn1BDmPPRSuxT40GeY3LgNMgutVDmTGrqsZrVQ60K/2
 9cmT5AksKb/FWsfOndidWe0CYHm05o2EF/qwROJYBwqahGAs3ReMvlA5rbFwBHDFs+Vy
 eef1TXBz4ER4912ox8e1AKYlWYvb2DX/17vUsfmfo+8/U8Q+uCEBTH7yz/uN6D/dPYFX
 5DvbXur6DvS8IZBDyxa/tlApczjCyX1ukgez+vMx3GGGc2JiC+e2NEOwAAWIhX6K2KKL
 MNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204021; x=1762808821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKv6Wkq2k6ueU++W0j4Jpj9adHe/TBCqtH0wdQ1hQcY=;
 b=LqjqePpVrIkdcQyFjh/uKKjAjoZeCUWum6c7v9bemEW9X8lnN3AJL0xhYKusZ6H4L8
 6BwjqZIEdTqhhpk3QLeWhVDEz/K+GF52pELph0v98B7TbWsyFsMQoqYQniiMcRGA/vye
 s2SfhCsub9wi2G2ZGWYtgsCAjeuIpLqrzQQoBE9AuFVvAy09IYWiUD7Ub536Xni1H+R0
 9NIvBiPUfbNRyMUND5NxDIDYBva4ESlkJhh559rZY+bkTVm5j18mEtXbbGwuOQ4QzkFM
 8TL423N7fio+7w06cUdZpy01sRFxm8EXwP0T3LWiz3Me1MzON+8mtrPy5MZVKPfJYTx9
 +4KA==
X-Gm-Message-State: AOJu0YyUSkBpMIJStyFUZF9IGITcHF38OYZKZrpH8cNhSHSFBDsVb8aq
 ztLtl1RVmlmprl3qt9sbqr8cUHJthKqsbkX1PCHordTZDcvKHbAF32nYrTEBuw55N4CChv83N4z
 OOajstfC3pFOHFcdw5eYTNcAOdM6qpaL7wcK5t6dRN3tPtpsTirKnqhpHGqkHonHXFvG0BDZ3gO
 5yvJeWMLXKiYTbAY7ZQs03jSjR7/imcQsNPmnRfw==
X-Gm-Gg: ASbGnct3WFlqrrN5bCzfL4CDSfvBVYW2xpHlcyLJXLhkDH7iNmYdVjDKJK0hFjk9bjn
 OeeTXxrjR6xh1J0yvJGW/ppPRKp1/yuwqVnVQnM1RbsXUBAh+rwEOrp9OnS6twHq3xf8fER3wJN
 bFFPaTlDO0LbqJEiVWaVIfPpNhvuRzCfusQPlPv/dHdB8te1Sfgcp6LbhRTozoqJsefHQm2Y2bW
 PX6YR997r+qsg7fvv7jF55TcCmw8o1tnIePh+T1eUUe5SvrSQnBAf37IrbKT04QKq8Hkpfgzj+h
 WiTPEKnCd61YDywE1cIWvh/6opR8lZp7PA9LTmhh74GFoJMJ872DWhl5NaglFPi9
X-Received: by 2002:a05:622a:418e:b0:4e7:1eb9:605d with SMTP id
 d75a77b69052e-4ed30d4ef35mr164580191cf.11.1762204021048; 
 Mon, 03 Nov 2025 13:07:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBveRYy/QYvtQ7hk4nBhBNCdn+kMcMHpQPydEzNXeivQnb5dUJ8HWJY/SEhKmBDLw435N7DQ==
X-Received: by 2002:a05:622a:418e:b0:4e7:1eb9:605d with SMTP id
 d75a77b69052e-4ed30d4ef35mr164579611cf.11.1762204020471; 
 Mon, 03 Nov 2025 13:07:00 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 22/36] migration: Properly wait on G_IO_IN when peeking messages
Date: Mon,  3 Nov 2025 16:06:11 -0500
Message-ID: <20251103210625.3689448-23-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

migration_channel_read_peek() used to do explicit waits of a short period
when peeking message needs retry.  Replace it with explicit polls on the io
channel, exactly like what qemu_fill_buffer() does.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20251022192612.2737648-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index a547b1fbfe..462cc183e1 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -135,12 +135,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
             break;
         }
 
-        /* 1ms sleep. */
-        if (qemu_in_coroutine()) {
-            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
-        } else {
-            g_usleep(1000);
-        }
+        qio_channel_wait_cond(ioc, G_IO_IN);
     }
 
     return 0;
-- 
2.50.1


