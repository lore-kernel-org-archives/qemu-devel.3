Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1E9C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQV9-0006av-1A; Wed, 26 Jun 2024 07:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQV4-000681-2b
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:42 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQV2-0004ty-LF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:41 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c80637d8adso4449629a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400058; x=1720004858;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JjfUQuEae0R8cdwKe9GcIhsbAslV8NkVY8L54kIHCMI=;
 b=l9ztF6AcLQSVChSCqqJTVVqo7+jKpUWgnPMiUxZpvHikcOUFocHhkQwup+YXESG9MO
 hn11/otHE6WhB7RITSKgzU+HIgFEzkUv+DLSSHH1PPQBypmx1cAHmJRGctXryudyDGDG
 wFuGDna8q7PNtPjxKJ7JY0wltz8X3vAgNbxlhNSKxRSKf4KgQUPRBl6xVMLrVDaDWaer
 fviB7UiDYcYX9R5mQIcaB3nS1JYV0g2nOyRmJ+yjpmnDPLBVHhKsuiueGwAiw26G175I
 H/hwLJBO16/cyReHYHbhwtAikCHbXMZBgJ57LAaqaeoueZp/5Jf1l0iDCV++BmbohVeN
 KXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400058; x=1720004858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JjfUQuEae0R8cdwKe9GcIhsbAslV8NkVY8L54kIHCMI=;
 b=GhEscsgubnSBmpCLp9gJw/mw+lLNmczcMT8Dn7R7m7H8DyuQFMvBH7HSwBXu8m8TYI
 mMKE1j4Jrxc5EqgaNSvqyuSFWLR4r9OBzporEs6zH8RgnnZGnn9IYAQgLLDz4CevVa6h
 62v59wDMzQZxAya05lfnsbkIgeYSF4OsFcJaSI4WJ/V3jZ0NcUYnXKTNZSLoUyjHmi/T
 zDNy1FYDe/tvKQ8YgqvlXvUq9ZqsQ4n8LJAPQhMVU1cifn07HP6KWqlz7P1RHQ4KSICZ
 8hu2YT7vk2ayxNp2/4F8APU8ILPKXTnnKiOdAIZ6xgEOep7zaoosBU/2fvCntxLxh+dQ
 7aXQ==
X-Gm-Message-State: AOJu0YwSbwNMrmHo2TtB2agiFRt8F/oL4/A1wAdd8iLTn85DRo9DxkK+
 bVvV18LZ2op2iNOYrWrC27V6tmdZrmEX7vgxq2icLB9b0LrX3Ipk6mhgH27eMyg=
X-Google-Smtp-Source: AGHT+IHIDN4tW4JDc5fTZQZIemw+tavBwEvCkW8YIJ5Fh9l7Zao3bup8RJjQetrfRxOeOkLABmRjvA==
X-Received: by 2002:a17:90a:fe0a:b0:2c1:aefa:1e7f with SMTP id
 98e67ed59e1d1-2c85819fa27mr8551111a91.3.1719400058416; 
 Wed, 26 Jun 2024 04:07:38 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8d8094371sm1377063a91.54.2024.06.26.04.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:33 +0900
Subject: [PATCH 10/14] tests/qtest: Free unused QMP response
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-10-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/libqtest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index d8f80d335e74..28683fee28b2 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -743,6 +743,8 @@ QDict *qtest_qmp_receive(QTestState *s)
                         response, s->eventData)) {
             /* Stash the event for a later consumption */
             s->pending_events = g_list_append(s->pending_events, response);
+        } else {
+            qobject_unref(response);
         }
     }
 }

-- 
2.45.2


