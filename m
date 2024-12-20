Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45801E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaUD-00060p-FJ; Fri, 20 Dec 2024 05:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaU7-0005uR-Lu; Fri, 20 Dec 2024 05:43:57 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaU5-0005O3-LS; Fri, 20 Dec 2024 05:43:54 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7fd2ff40782so1534633a12.2; 
 Fri, 20 Dec 2024 02:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691431; x=1735296231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jvfp4tXxGdJYBXXPUHySvHV3oIx1k2wq60uhteeuWk=;
 b=ilzwcpYvP7PHwFaUEV+2hOuQJcL0mC5pKg1tSvxmt9ANkwUC8qhFuFT5Jh1+S8w/wU
 E3PC1+Kv/sCck1wKbbURk71AYlzn5PwhhpJHyPzFZNda2SPykj4PiUxfc0JTxv+ujFkI
 dgfxzVuTxHYMFtEQNGtobuSlXRdYmDaCBpPnHjBXCGCujt/d7e7/+dE3hVbOuGM4DaIi
 gC0nj32viyxI5+cN2MTYXK71z8EvgRzRlxthuZGLBSfi2TEZwEFhePVN25cs+2uMLrSh
 lK05ElngcrF/A5p39bHkdApIAZRWfsHQr888xRX3BT1iG6ZN7UrLvaehYZTMTt9uI3oP
 XKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691431; x=1735296231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jvfp4tXxGdJYBXXPUHySvHV3oIx1k2wq60uhteeuWk=;
 b=GjxA5yaEBU86nKULlObVoWWTGNBzWWdclGks6FusRQRVWuGXCOaIoJaKNOgyTZcIfs
 tmJRdNKhDiknAjoLgVxcY9VS51YR5aTRcCY6/HGoPId8vxa7xecBgWJgVZJOu1TyJbQF
 xzXlaD8cYFPyOl/uIIzFEL7Piy8+VbbySIv6GWzIFE3VMMNr2M23+6HBhYoCcMJDk37Q
 5N5mEtKH56Ib1kC2WqCEzGLq+0atW3SQuk0YJn8EXMcGhvrey9cpgFZmpogDpxnZxQ4o
 kSDVSYEtUwhK3ovLSWuuSIx4SjEsASIDt/5LwvYWyradnvjK+LuFA3rBJyiTMRyYap/I
 87+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5FdI5SNQoh8IYCHJS11lL3Z6LnA102tEAC5jIRJwJLtCYyjCDBzUfkYneLzlXQtJwW4UOu+pheUEn@nongnu.org
X-Gm-Message-State: AOJu0Yyp2dnloc24F13PcT1WWWepcVCvBs0fHEwhwa629IDYTYl2slsE
 kzIh1b74O9qY07yGmL+hgf77k5V4d9SkQ+xXjRw96G1ylVRqPIwFEnQQ/A==
X-Gm-Gg: ASbGncsghU5DStpgyGGZGgjPIDkVGxg+dM0qckZACRvVNUPpJJkAhmFu7PilOM3GyB3
 jj0Y37YbutMPSATqb0k6xNKBoHzh7vMewDXCZSNiAAbQBZXQSEjHjZTljnFUAKpvfd2vUdeOmjl
 DYkUScoCiwCy+yjMpfGNiIojIb8doPrc4GLw57WD/tIk0ylUd28Sac9Ed2MJTi7eIS5aH4/q+Lr
 jonoxzSRR7bGE5wEtqI6q9RBbYVasikmsI6bWKc4kMjm2GJsag12A3BUEf2gmok5Ap4eYpwfqXY
 3Gx83c0WRw==
X-Google-Smtp-Source: AGHT+IEBXh3mgydDemWGOsIGc+458hM4rBbHR3qnIMTvhJO7NHHHPbbS2Zxl60i2wmMi7Nekxhe8EQ==
X-Received: by 2002:a17:90b:2f07:b0:2ea:9ccb:d1f4 with SMTP id
 98e67ed59e1d1-2f452d32b5fmr4561997a91.0.1734691431583; 
 Fri, 20 Dec 2024 02:43:51 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:43:51 -0800 (PST)
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
Subject: [PATCH 10/17] qmp: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:12 +1000
Message-ID: <20241220104220.2007786-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

Convert aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(),
which can specify the clock type, making it compatible with
record-replay.

qmp dispatching does not affect target machine state, so it should use
QEMU_CLOCK_REALTIME so it is not recorded and replayed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 qapi/qmp-dispatch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 176b549473c..4a07d75a856 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -254,8 +254,9 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
             .errp       = &err,
             .co         = qemu_coroutine_self(),
         };
-        aio_bh_schedule_oneshot(iohandler_get_aio_context(), do_qmp_dispatch_bh,
-                                &data);
+        aio_bh_schedule_oneshot_event(iohandler_get_aio_context(),
+                                      do_qmp_dispatch_bh, &data,
+                                      QEMU_CLOCK_REALTIME);
         qemu_coroutine_yield();
     }
     qobject_unref(args);
-- 
2.45.2


