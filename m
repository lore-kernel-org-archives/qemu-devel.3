Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE50C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVJ-00079z-MM; Thu, 16 Jan 2025 11:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTo-0003jd-OG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTh-0004Ue-1L
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso7365125e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043935; x=1737648735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLe5w9j4DHWXPaIRe+z3KvHnXl+5bNcDKy/lW4VDWAc=;
 b=b8AgYZ7v4Ci5SiEAI1jmHvCkVJkCFl3OIi1EMoENcN/OgUvOoOu0oYOic9VipuR3aA
 7+raSBpQbI+k2xNQyCHeB5H6OwGV5NGDy+/MwkQwf7CjKqOPTboXh7oNd0N1/xHXTTtC
 4bneX0fUk4un/hp1JSJTG3b2jUvOG82iaeSfPP7+l8im1AUfyyKuJ6v2hcPSxeKPQcRJ
 OahPh0JShLO/9wUbwB03Lzy4R6fU+2D7ddMjhp6RtQlBqiLx9l86sCrGVX/t+JUsHgHA
 0ERnfQb3oBetbpiCO5Z0oMXgGmBMSQIuU7v5Oaq5KxAdpgTaU9lOKd7Uv7uBsANZhv94
 jbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043935; x=1737648735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLe5w9j4DHWXPaIRe+z3KvHnXl+5bNcDKy/lW4VDWAc=;
 b=G7W+7lOTyTYFMPBmS7k9kSUVWS+N4T5Lw6CME5Q9XbFQEACMdwSORc2XvR/3JZ4VDK
 7a8lva2zeXA/AxNNWsehWLVoZb5UuroEFp3O6vKFgDZvRhVH7LUlbPNI8Dabs87ZpvBd
 INQvns6B0rPVaDnJGCIVFXmE+pYTWdoQ4Ysa9HxEbjCU+V54KLCPdtHrkT21vZAyAm7k
 6SAko0HcQ3/rVD7rJIWdKqT2W9jmu5iPRMbKaHsIBgFUtbiF4qP+CD97DwV9Pbel4us9
 ndu0ePmNe2EbMnPHfLVXuIf0zjGYmvXFeRv/iPxsM8aYWf843EYpBxT1Je5DZRbvnnsj
 ZLcQ==
X-Gm-Message-State: AOJu0YySfY78MYmFq/D4gtntMXb2dcZZ7h+uzsX95ocs7bpjjGQTAbVr
 EJmQZabu3BgW2AJnKireQ/I0fkLkHMtBBeg0OvbRCDiKSGLj7xLKXjvHRN6v8RQ=
X-Gm-Gg: ASbGncuUig/CPYCJLXR6E9cYm7a/bDd4m1NZW1BenXBAW97McLfJJaxwHBYyLSMmXRO
 N1Z7TJspoaEZKSvGM8DysH5muUDsqn0yox3hJmmoeNbG40HchYa84bsiTCE5xrfzen37E2u2UXQ
 j0XSNyHASYMExRYUW/62HU6hRjKjGNHfS0NIKA1+dZwlZ1Nrs6kgJTVqHnb0cT2FC0S2wNeJyYm
 ROwYRFBiEAYbCfyTgf9zezwX9e45olRmlEH3NKgHIqEjctinjX/w30=
X-Google-Smtp-Source: AGHT+IGW5wYt2DWPIkVBjiq06mGFgkl2qsUn7l82B2h4BRIDMEcksTW2k1cc1Zs0sXRM401iXHBwUA==
X-Received: by 2002:a05:600c:314b:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-436e26ebb6fmr201501935e9.29.1737043934086; 
 Thu, 16 Jan 2025 08:12:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c6179sm63871185e9.22.2025.01.16.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36F35608DD;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 28/37] tests/qtest: fix some copy and paste errors in kdoc
Date: Thu, 16 Jan 2025 16:02:57 +0000
Message-Id: <20250116160306.1709518-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

A number of copy and paste kdoc comments are referring to the wrong
definition. Fix those cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/libqos/qgraph.h | 2 +-
 tests/qtest/libqtest.h      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index 1b5de02e7b..81fbfdd0e2 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -355,7 +355,7 @@ void qos_object_start_hw(QOSGraphObject *obj);
 QOSGraphObject *qos_machine_new(QOSGraphNode *node, QTestState *qts);
 
 /**
- * qos_machine_new(): instantiate a new driver node
+ * qos_driver_new(): instantiate a new driver node
  * @node: A driver node to be instantiated
  * @parent: A #QOSGraphObject to be consumed by the new driver node
  * @alloc: An allocator to be used by the new driver node.
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f23d80e9e5..fa08c7eca5 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -365,7 +365,7 @@ QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
 char *qtest_hmp(QTestState *s, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 
 /**
- * qtest_hmpv:
+ * qtest_vhmp:
  * @s: #QTestState instance to operate on.
  * @fmt: HMP command to send to QEMU, formats arguments like vsprintf().
  * @ap: HMP command arguments
@@ -904,7 +904,7 @@ void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
 
 #ifndef _WIN32
 /**
- * qtest_qmp_fd_assert_success_ref:
+ * qtest_qmp_fds_assert_success_ref:
  * @qts: QTestState instance to operate on
  * @fds: the file descriptors to send
  * @nfds: number of @fds to send
@@ -921,7 +921,7 @@ QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
     G_GNUC_PRINTF(4, 5);
 
 /**
- * qtest_qmp_fd_assert_success:
+ * qtest_qmp_fds_assert_success:
  * @qts: QTestState instance to operate on
  * @fds: the file descriptors to send
  * @nfds: number of @fds to send
-- 
2.39.5


