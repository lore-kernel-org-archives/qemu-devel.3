Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8750DD374A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rl6-0003Xd-MQ; Thu, 17 Oct 2024 10:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl2-0003WP-V1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:45 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rkz-0005dy-Tb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:44 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso1203957a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176340; x=1729781140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcLknQffuaT4ojoTGdmSGCeAGfXDZnwetn6Ee4o+pCY=;
 b=Rn/d9xVEyTZikeUBgk2zKWDml8U6e/x1G+niwIFwvFYRqeHeoB0QEHgYeTvRLAbUAY
 ykgs433a26KhzIg4AOx9D97LsfXbmidf5VZKoFSM2ruVDyn1nTIh3goXvU2RZAi6dU47
 hRM+L8KcFwwk+6dbr3YQtSq490pKY0L8dmt1I/DzJ53G/lRMsly4jIKfPkiZFpOiBoEC
 bnlU7rRguJ0Wvev4bOJpVyDwJliLuGKCmIrGwA7jEv7Z+aeDL7OCkZqjFnlKK42G29gN
 sJhEssWR8h1W45sddHZICfLDV0s81zHBuAI+a9d1kCHLx4whVb5R2Ley1nPgVd38A6zh
 PwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176340; x=1729781140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcLknQffuaT4ojoTGdmSGCeAGfXDZnwetn6Ee4o+pCY=;
 b=WwM+5Y/eXi2VVu9HA1aCjbkZPB2IYJetjaZsPQN3JIKI6WkUQ8MACDEQfHEUeDZHfr
 QIlt1mD6yRkjd4w3auSa+sOyD8161ga556m61mKcHfpoPaHgPf8CkR2DDpPg4x+e/yyP
 IMkvAAZqUXJnZtSEeBk3E2qoMVcDxdad48w9uUyC/XhQJpV3/GVNIQ2WQr3NyH2RofMY
 I+JJ3h8af+KSQR2yY4YfliydfjNF2A2sL4tcgGsMZVHn/erMzngSh5vxkZSHxngPfeoj
 nbZKb7GQMLgjWkhOKwhTkKrrsGTGFFFto+N3nb/ZTlWw9pXjxIi6bymzd54RI7At+4Xi
 DbTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPBJy3M8nf7rgddUeqvsDO/Y4/2pKhtynHjddbmAwUFEdMaMxPzKR37J7DxDSFUTjSejZWTqCj57dF@nongnu.org
X-Gm-Message-State: AOJu0Yx9A5T7bKh33vtrEcIMzCwofnFntUpB5t+xcZ5V3cqi4KWqaSAl
 NH9LlNr5NYWjNphW1TU+5qonQI9n3nctxiz9aplIVMrxdpj5rW240BY1w6YR
X-Google-Smtp-Source: AGHT+IFGSayl88pRs72BuiytCGOTv9sFpDs8PbGAUOpFxe/1e5WwWz42kCQHovDYXSVI08z5JDqRnA==
X-Received: by 2002:a05:6402:34c9:b0:5c5:c5c0:74ec with SMTP id
 4fb4d7f45d1cf-5c9950e7399mr6168530a12.24.1729176340314; 
 Thu, 17 Oct 2024 07:45:40 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:39 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 5/8] chardev/char: introduce `mux-be-id=ID` option
Date: Thu, 17 Oct 2024 16:43:13 +0200
Message-Id: <20241017144316.517709-6-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
References: <20241017144316.517709-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x531.google.com
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

Patch introduces `mux-be-id=ID` option for all chardev devices.
This is necessary to attach chardev to `mux-be` for backend
multiplexing. Actual implementation wimplementation will follow.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char.c | 3 +++
 qapi/char.json | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index d8dbdb6f84f1..cffe60860589 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -933,6 +933,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "mux",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "mux-be-id",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "signal",
             .type = QEMU_OPT_BOOL,
diff --git a/qapi/char.json b/qapi/char.json
index e04535435034..fb0dedb24383 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -199,11 +199,15 @@
 # @logappend: true to append instead of truncate (default to false to
 #     truncate)
 #
+# @mux-be-id: id of the mux-be device for backend multiplexing
+#     (since: 9.2)
+#
 # Since: 2.6
 ##
 { 'struct': 'ChardevCommon',
   'data': { '*logfile': 'str',
-            '*logappend': 'bool' } }
+            '*logappend': 'bool',
+            '*mux-be-id': 'str' } }
 
 ##
 # @ChardevFile:
-- 
2.34.1


