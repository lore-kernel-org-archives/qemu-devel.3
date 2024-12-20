Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2DDE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaTf-0003Td-9C; Fri, 20 Dec 2024 05:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTc-0003LQ-8R; Fri, 20 Dec 2024 05:43:24 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTa-0005Ho-KM; Fri, 20 Dec 2024 05:43:23 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso1233023a91.2; 
 Fri, 20 Dec 2024 02:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691400; x=1735296200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zksXftHHwiMlh0b8VvEId2Ivj+FLbCTYmyX55d90oHA=;
 b=Gd1lPxw4Z7HqQG6bw/Zn8NioIy2CA1UXuYQQ9yH6agmHjD1fiKUgjIMxPdJ9LJnIj3
 3dI3nyBfj2Hs1LWJrUMs6OWDkrxL2tOHxuG4Xblf4yb6iykyg/IiRPH9UJwAFMZwzQZW
 LRbchVrrnJQX5ltXZzWgjbXYETXkNI3f1gIQMgEF4sg9djybiCened/5lg/uR0x8jd3o
 lOUc+7rEVSjsM/4Ashfet8WK5R3KUnNu0YnFsjfsCObJu7dbEuVzAsJVnQFX140ntdBZ
 ECOQE945BZmy4ghyVHg4OL/vlZd+Y1ClMXBQ3Lu5Rcq840RLoDDf/PpJ6X/E6kKURLWB
 YtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691400; x=1735296200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zksXftHHwiMlh0b8VvEId2Ivj+FLbCTYmyX55d90oHA=;
 b=N27SwVBcXRkIBF0Wd7DrydHAqkmpdXlwe56qPGu8F9MpDWWUTty6x44DdRJO+GVmAG
 fe+80BHxPFznCg6vfoVCtvnh81AJ1qig0eYnnNUmbSJrr8m4dqUh13AlcZ0uiN4P7Jlf
 UVKMcMkO864Xkyn3XakiHYYdFuu8a/SDjqJZB4d9WH5bpIDlLfgwmt8qLxVxj9edIRJD
 leUdph7Cwh+IFewW6k/SbIMsZJoAI8J5IDswvanyUm5cNsT57qJy6PvfIg6kuifNbjiR
 Ys2aYyDolsGU8HgcINaGkIhqlO3RUDxZ1PHlCLfJD8Xk4xXjp4ke2NjyS0dX1OgmmIsy
 nrQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2iGKpnV/TeH9nUVJtF6rwlZuhdoNMw7V/4KqJvfCedIGqr6DJtvXZ8DJIhH9QlABjQdknRn4AYBh0@nongnu.org
X-Gm-Message-State: AOJu0YwFIvFih5VHlPLlVCEEHmXxNgiAgkvy4uVTn2ngqIZd3NGBRBAK
 HWq2mc2xY4E+c0VrIxkqPiMxfSFLtI11mmox9deNeInocpq5O5NuRpnYZQ==
X-Gm-Gg: ASbGncuVRror67onntK1QLQcZkJ6iCqIzNWaKAwhGvW/pDmp3UVmagfK/5Mzg4z3bZQ
 Xpqh+fzjyRkvUiM/ETDo3/xL6gPPNa98/FsGsthNWaEeffPRsefOvZ4GkzM/JoWE0oFJO7e8mKu
 yMif4J/kqrfH3oxdn6sCd0ghQsWHY9ScZRNgVG6xIGNYYKnu1XE4Xfljf7N68A6MQvBJBod+40v
 zrUha8gZ4/5rwJWN0/zu3wPfbLZlvjzCeXyB7O6ICS1eKttJTdbYM76RbYjqSxrPO7SrxvFjxNb
 gaakoUmgdg==
X-Google-Smtp-Source: AGHT+IHiVTvCdG8c+tqi1QzE1itrqIdqMLNwmktRH+xJ4aSdg114C7HWjkLMwJf8tbeM+EZ1JcD7nA==
X-Received: by 2002:a17:90a:d00b:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f452e1d13amr4007490a91.14.1734691400492; 
 Fri, 20 Dec 2024 02:43:20 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:43:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 06/17] util/aio-wait: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:08 +1000
Message-ID: <20241220104220.2007786-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Convert qemu_bh_schedule() to qemu_bh_schedule_event(), which can
specify the clock type, making it compatible with record-replay.

aio_wait_kick does not affect target machine state, so it should use
QEMU_CLOCK_REALTIME so it is not recorded and replayed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 util/aio-wait.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/aio-wait.c b/util/aio-wait.c
index b5336cf5fd2..2137abd4d29 100644
--- a/util/aio-wait.c
+++ b/util/aio-wait.c
@@ -51,7 +51,8 @@ void aio_wait_kick(void)
     smp_mb();
 
     if (qatomic_read(&global_aio_wait.num_waiters)) {
-        aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
+        aio_bh_schedule_oneshot_event(qemu_get_aio_context(), dummy_bh_cb,
+                                      NULL, QEMU_CLOCK_REALTIME);
     }
 }
 
-- 
2.45.2


