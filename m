Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD4BD1AD43
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11GY-0003jc-9w; Wed, 16 Oct 2024 06:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GV-0003iZ-7k
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:27 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GT-00049f-QG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:26 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so7269124a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729074504; x=1729679304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcLknQffuaT4ojoTGdmSGCeAGfXDZnwetn6Ee4o+pCY=;
 b=gT/Nsc17ih6Evz5nQrcI7fZhg/YjhSjBSgLRc0P2u3Fu/tpXnaplahuUH7FVTq8vHw
 wl9yi+SgxketjT84drDdS8EYAcWP7zNX3ymwoLdwApclggpXOjIzJAB2DjzJ3FPj2TI8
 ZMj52AoI01itp3/uGnvhJ0CabZCiSDEwTOjr+4y9py/JwfLlSPMwSmA/2nplGtLl5Xdc
 u2bOCDWBAV1+Xk86DYLgT8ZVhO/fLnTpUn41begiMc6QABwy3NwBhTFQWbibfQ+IwXkJ
 VhiKwUzT76k2Q3Ky+/lIJkCInd1GOXeGn6nvPvYSmpeSYIkMybEYLKFwRelw3aNMnURN
 TJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729074504; x=1729679304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcLknQffuaT4ojoTGdmSGCeAGfXDZnwetn6Ee4o+pCY=;
 b=jcdRH37Y6gxB2UDe+pTooVblsbO/vsK5bHyLOLfWXswna3XdOZClx0Mi0RU4JB7DsU
 Cw3mSIyLVH4U0uZQ3k+dUbAzBxpNTkqzzZDShQjMvELsvS+HXxUGPhpCT+sgFsoEHV5j
 Qu6Tx/q2bIhOXXBt42+DkBgD4Zcts1DV5U7ZJfU33epg/e82slXVCajreq0lCWJ7L/qu
 U8/lu9T+r0R5YZfO0WUiifRn8iIDdeDkiVogVH+2kNwaL3CH1b1G56zSAvI4fl5b1t5m
 QJGjhzKg3XeMNoM2My0kLsvakIo+k1tIczh3EdhpjG5lXJomd5netGvZ8u8JKoWeXiwf
 8LTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBY6J+XMaZ/Xy4lciLpdlPxogRR1nAyW4SxkmLQoQNUlFDxbaQCQDOTml3TfVB4hh2RH5T5QbUVC7L@nongnu.org
X-Gm-Message-State: AOJu0YzSqZvRdmMLXWaZliLBE7UgilNThoehTbn/MaYZwatnU57xB2Dc
 HSuWdAqrEs/oFchxSg6l7FGrz7Sa/SsW5PLZ9Cosfj+1idisoQbrpfeE0Q==
X-Google-Smtp-Source: AGHT+IGeqNkFEzAJmjUgv9SBOdaNXbwaZ1PYb6q2FNk2/RygJ8/fE4wmbyxIlSWBWqioudYEUIiyLQ==
X-Received: by 2002:a05:6402:1e8e:b0:5c9:7024:234f with SMTP id
 4fb4d7f45d1cf-5c970242a14mr8582767a12.6.1729074504076; 
 Wed, 16 Oct 2024 03:28:24 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f85dcsm1566680a12.22.2024.10.16.03.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:28:23 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 5/8] chardev/char: introduce `mux-be-id=ID` option
Date: Wed, 16 Oct 2024 12:26:02 +0200
Message-Id: <20241016102605.459395-6-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016102605.459395-1-r.peniaev@gmail.com>
References: <20241016102605.459395-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x530.google.com
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


