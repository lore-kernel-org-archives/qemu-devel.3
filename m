Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44947C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPRa-0001ji-2e; Tue, 03 Jun 2025 07:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPQ-00084P-Ee
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPM-0002DQ-Fz
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:20 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-604f26055c6so12323801a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948535; x=1749553335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDnhi2MxHDPqhcsbyRznzpXsnFp4P/npzVTkA5anp34=;
 b=hlgTSLyfu4rRRD5qdidZpRtzgYiVrgiJpU9Dh9kNDu1Jz1RjS4EDVogcFTT4bwMc4B
 ppdbkLsagSRBlsfC2nkLb9yoRQ/YjCKxD0DTL2865jxo6yFQQWhHpDiGewokW3IGp1pg
 kv8NqlBumPe1LgCyy0XWGnIql9vADyN3RcjRQqQ5mLtTc388D3nWvPb1dhpOMJr8Tt+A
 ++3u0ryF1g+KTB/WFKvO1mo12eXBYafqlOeA33SIhwIRtZG1hEQbIBQ7JZNNdxE50W8K
 C9ZuC3GgdGgc6Xz7H9Bzlvq9xUz45Ftm74rgiT7bS3W4aR9ivpgw2djsE7DRCd9cy0mD
 DJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948535; x=1749553335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDnhi2MxHDPqhcsbyRznzpXsnFp4P/npzVTkA5anp34=;
 b=QKNYaowdKdRjgbYKu645bzeeXybjLQXghBZ14ZUPZcbfMAbn2piA/bicZbPbz2tovf
 rOmyV0cYN9mxgJ676eCFbQEbfXYPYBZsymyydEWSs+GxLWe0Xa+7+pdVgXpT5MNFp0/P
 /R4v/mGX5EOWtVyyRXCFm9ciRLXOntdveISvn76DneMupV1vBroVT4eM7GnhWk/L4+IX
 YKVJI+32C77rVyRynrM9/WG83kooLhme/tt7rt1oUqZ5TF2PUffj8bEzxxaVxegEEyYo
 xiK/xWH699V5NkKSrcn8cKZ54XECf6Xo7EMTu2d4u5+OHhxqmhU/f76yIARDr2vY8G/N
 Ng7Q==
X-Gm-Message-State: AOJu0Ywo2ikls7J3BBMDQIA/lmfrcrjms7y2l9iERlGeX7Azs6WmfVK0
 E3P+vGOQPgb9gICAD7yVkgPNDurLe2CavNGDW+ebcSWeLrxBE74XdS9+743JHFZfAd8=
X-Gm-Gg: ASbGncsX086A/RaCJTElQo1X8MQWzMLlcYaVkP5Ud+sk51l5nBSAFf4Y7Q3jHi0Ps9P
 Mkfu/3Cy+wcUAOksGtt3L0HQnRWI+WZhtpiBxhHnVhDBEwitXMTp2BhzNf3k+1oMNGUOjOenT5D
 8dwbBaOKdjUIcPnmIDZQTJBmpo8uaomvw/hR1J0jovYUTQc3F1zXOQ3VOrHeXadTZm7bdLQGh/r
 OhmdNn8hwrIjPPmKYrL5rVPAQSTn0wdWNL5/q5aTTW6f4x6RYN0ns4JBQv9LQ/je3iR9nWhzJge
 bT4rTzuOzaVt0MvhZfZzoN7Jn9bl4aKyZ9aZtHjOQNopMlURE4ub
X-Google-Smtp-Source: AGHT+IHef1ZTopYq/fB5trd7ww91BUE0eCRuJs5XjHevQmMiqmwMJcAcQK5aSLVnwY0zsJWOvQZsxQ==
X-Received: by 2002:a17:907:96a0:b0:ad8:8b49:57d4 with SMTP id
 a640c23a62f3a-adde66fc817mr239693566b.28.1748948534877; 
 Tue, 03 Jun 2025 04:02:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fed8bsm939567666b.28.2025.06.03.04.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D8065F9FA;
 Tue, 03 Jun 2025 12:02:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 15/17] gdbstub: assert earlier in handle_read_all_regs
Date: Tue,  3 Jun 2025 12:02:02 +0100
Message-ID: <20250603110204.838117-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


