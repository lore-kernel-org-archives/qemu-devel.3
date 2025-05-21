Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1023AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmey-0004dI-Ed; Wed, 21 May 2025 12:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmev-0004d5-IJ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:51:14 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmet-0007KO-K9
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:51:13 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so1262470966b.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747846269; x=1748451069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGcCBogciGYCcQtD2ipd63qJym+pfIRLPkHANZ4+71E=;
 b=vZcp78R77W8Vb9qYq1z0EOZyQXpiez9qvAPTNZe9u3I7+a4pUEHyZdNklqKyHCArf9
 fWMunRIqvhpsz4K9SDTFan6QHaLWQIck/hnsQz5A3Y2J3r1CZAoIP48rG8SXToa2jzsd
 E/KAIrERkBgdnqPBrWAthDljQEUoeAiiRk3rrwyJKXo4gzCWHMkIPGQzrQI+8+TXMjSG
 OkF5TNg88ODA2RJknYWO7zQdLRrtoE0kDMxCpp9A58Z1EYivfsQ7si+fXf9VZ+nSlVpA
 SAWUzsOIgmm/2gacORx8M4PzusDWQOGPyan12xxN38s26NOAp2aJKqEAt5LgMQBDN2ix
 eI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747846269; x=1748451069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGcCBogciGYCcQtD2ipd63qJym+pfIRLPkHANZ4+71E=;
 b=Ox0PvBVWTGnfkv5CyJSWiaYJGz9Ii83F1J90R7IVezAQTQQsmXKus9rfW0HPivzeS3
 y5pSo8p+Fz8tIS4PgxKaH41ZA4gmWqY/tjlf0FHoFfZUuqcp8NjVP/LTpExKWdHuzjJM
 t3/CZEhtu0BSNeqf0v3Hgjx5BYreT+FEuOlGFJezXmWxMl/XI5sfJnDrsbMGkWQIENrY
 g2Yjja53l3Wdl3cv7BYATY4kbVVenwCyJQ5nYC1aL8cMzAUDU8WICYh2kl9CvsAcUvHe
 tiMcAWAsjt1qh6VRuoVv8A9QZfA20PMaNQsARnix9CzrLt9yZwPdleXp2PQj2q3E9inz
 RMQw==
X-Gm-Message-State: AOJu0YzNTKJ1dGyPso6nJUjTAMHBbCrwHR+xchofSwOcfZF+G+zvJkrM
 qU3+SHHZPkMmNJLarHdeozjKdCqEXxEwQQuQRQ5miMZRpyPmCB22i+DLaGTd7xkuS7I=
X-Gm-Gg: ASbGncslvqwvGvjSaTct6br6usR7/LpFxEt+OqXQJSAvCQMoodmHLBRLQYQlbN4RbJ+
 eJ+x7LaaUtws9OybwpJLTnyfh+j4tDq+GsSWjHWiGshWwHFx0FG9pC0972+1sikTgBVYeipPv6z
 n+RSVjqakZYPGY1dI9xAkZBP1pIBCyfxFKVv77MI7BlyVHeaUvdlZGOyzzQdKiGlL7KBAaidWrb
 eU8tCBSB4Hki8FRNibuGUEVh3QI63USmgWghPUCGE+cr6qd1FmqEwPzHDtnl/tB126xF7OleLue
 foBA7XSl2daIWcn7S2ZxiB0zcN9jArAvkPNHOyMq2onqCyI7lwA0
X-Google-Smtp-Source: AGHT+IEETB0uQSx+vt2nQE05eghxn786gNgAonj45SZnNQqgb3soKKQpuLEkR2f2Qk6JFeEqJWJZnw==
X-Received: by 2002:a17:906:730a:b0:ad5:112:48e4 with SMTP id
 a640c23a62f3a-ad52d49e918mr2028702666b.18.1747846268911; 
 Wed, 21 May 2025 09:51:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4382e2sm932518866b.107.2025.05.21.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:51:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 951A25FAFC;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 18/20] gdbstub: assert earlier in handle_read_all_regs
Date: Wed, 21 May 2025 17:42:48 +0100
Message-Id: <20250521164250.135776-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When things go wrong we want to assert on the register that failed to
be able to figure out what went wrong.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 565f6b33a9..6023c80d25 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1343,8 +1343,8 @@ static void handle_read_all_regs(GArray *params, void *user_ctx)
         len += gdb_read_register(gdbserver_state.g_cpu,
                                  gdbserver_state.mem_buf,
                                  reg_id);
+        g_assert(len == gdbserver_state.mem_buf->len);
     }
-    g_assert(len == gdbserver_state.mem_buf->len);
 
     gdb_memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     gdb_put_strbuf();
-- 
2.39.5


