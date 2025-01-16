Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A63C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLh-00046r-R0; Thu, 16 Jan 2025 11:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL8-0003Wt-Eq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:30 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKz-0001Hj-Le
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:25 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so664331f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043396; x=1737648196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WxsgJL7chOGbG+/17n3vpjWqUAThC5sUhtSd92NFE0=;
 b=r1kSBipU0ujRFmyH8y1nN+NWxqVQz2rdfFzY8sRtX42+0b6rSiwafsle7hPcMJ0B36
 Qw6i7SIBYDZ9Pnetg5G3SrE8mOjkqao2h1Ibh7EZE4MDaZ2oe0xOm7RIIx2FEo9b/pqd
 8pbiSptJnJr+YkHovJ06L+jkDSg+so21EzgosH7qPOJ0zjceyvHkxfJH5JrQInDGJTPd
 s16u+3LasDyNvQJlTjzC7MFEu/e+o6vLnn04V95jjOmFdd/s2Rh7lKg8+BnHzWJBM6aO
 0IOtP6RHpTcz3EIRd62xGJuGIWY+8ypepYPC0Fc+CQ7diNzLMJY3VFA1RPn+vnGEyD87
 FP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043396; x=1737648196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WxsgJL7chOGbG+/17n3vpjWqUAThC5sUhtSd92NFE0=;
 b=FKQm3pA2vPIGeRNvrEOEYs0w0OnaR3fnf4F0OmOWVqWWz5eUma5pOB4Jw+YNxmUZuq
 SubEJDciU699jIUX3Xde0P5/vA9n56fdjeAQQ5va2mY+rViLXYm7MGOT0vhmZcJl92Pa
 FFtQe0I+FFZapl5t+aCES0l27xlRwg7WGlDscsZWtoP0JMZ+7nfgjdlE4QSCVWGJLUoT
 A+EKmbC9fLdKX+C4PVSyNXciUNRtdLQlMhtlKpYBJNAvC63xx9UuUbm3Apm44xaEwPCK
 TWSZSN+PZa+C2MiyNd+RVmtYWoFJaVK3vfuQI+heprXu0ntC0x6qHNF09yhKeRDhJt5Q
 2Riw==
X-Gm-Message-State: AOJu0YzGHTSYeIYVUHjVedxq+QBisDGBZ3oaCo2fCKrDJuYsLyOrPJ5Q
 CCtJRR2Zht8LeEIynVwfrQbzylW4u0NSfgesF43sAzzj/hfDMkDODaSeTVk8vms=
X-Gm-Gg: ASbGncu+tF0VvD6s4u0z4VjAJM5lDrVG+VQBeWzOG+YdefYL4eJwcEO5c2O8R+hm/hC
 +0KzfAYZmF0pOgzSpTVX4sgiw5reTMo5l2wLgACr3Wj13EGHNc6arLByNMSt0bo+yGI4iLRAZ55
 RN6sUWYbzKLkZdL3v2Q3hU+QLNtRIv4wxxZOEvKSK4EvNwwMVi7Tcp8alS8pBW4aOQHXFwUwSGy
 42avBrcOqIWuc5P36o7fhAQirm8cThcEF38PpalbfEC6DYFG+CxxS0=
X-Google-Smtp-Source: AGHT+IHsUWQphPMiMawoflbOpYf/a3QJ1uoNHC4fZBTjpQrVBskWFVCF9saFlmtlN9tURdpVGxynEQ==
X-Received: by 2002:a05:6000:1f85:b0:385:e411:c894 with SMTP id
 ffacd0b85a97d-38a873377b2mr31016041f8f.43.1737043395954; 
 Thu, 16 Jan 2025 08:03:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a859sm215673f8f.43.2025.01.16.08.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A73A6087C;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
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
Subject: [PATCH v3 12/37] contrib/plugins/howvec: ensure we don't regress if
 this plugin is extended
Date: Thu, 16 Jan 2025 16:02:41 +0000
Message-Id: <20250116160306.1709518-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/howvec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 9be67f7453..2aa9029c3f 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -253,6 +253,8 @@ static struct qemu_plugin_scoreboard *find_counter(
     int i;
     uint64_t *cnt = NULL;
     uint32_t opcode = 0;
+    /* if opcode is greater than 32 bits, we should refactor insn hash table. */
+    G_STATIC_ASSERT(sizeof(opcode) == sizeof(uint32_t));
     InsnClassExecCount *class = NULL;
 
     /*
@@ -284,7 +286,7 @@ static struct qemu_plugin_scoreboard *find_counter(
 
         g_mutex_lock(&lock);
         icount = (InsnExecCount *) g_hash_table_lookup(insns,
-                                                       GUINT_TO_POINTER(opcode));
+                                                       (gpointer)(intptr_t) opcode);
 
         if (!icount) {
             icount = g_new0(InsnExecCount, 1);
@@ -295,8 +297,7 @@ static struct qemu_plugin_scoreboard *find_counter(
                 qemu_plugin_scoreboard_new(sizeof(uint64_t));
             icount->count = qemu_plugin_scoreboard_u64(score);
 
-            g_hash_table_insert(insns, GUINT_TO_POINTER(opcode),
-                                (gpointer) icount);
+            g_hash_table_insert(insns, (gpointer)(intptr_t) opcode, icount);
         }
         g_mutex_unlock(&lock);
 
-- 
2.39.5


