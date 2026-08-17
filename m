Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470E1C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2al-0000FG-SK; Mon, 17 Aug 2026 15:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZE-0006LW-RN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZA-0006U8-3n
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4956242332dso39996295e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993210; x=1787598010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvpNndt5UQYV0DMSUg/YxV83XuMVe1Vd7A60QVj55t0=;
 b=EzLxsQ7h7PKMvxqnybAEcm1h1BMhqlr2usywChhukH6xlamvkKYO+AMpHXkAPEJhvW
 p0sLQIcI9/JzyadGYsnrXTVsSug+UrjsVWst4N8XloFIAXUyWnWiQJckYldeWuCnrk3d
 0hP/q8Y24dH4cxF58A63GMf4pR+K0ShrXRthNPQqnhpQ9NWeQPYo91WGV2A18QzL0H+X
 sxotWaczrutgug7ot1mROoKNcmEeodN/8WLZpZAGsBM9oA9IDMtcROMBdkFVhg4bJyao
 LNIrUJK/jP0bw2BSksByy3g071Od56IwCzn6qpPwVgRLw00aWCHgQe0BklJhQkxI68rO
 qjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993210; x=1787598010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CvpNndt5UQYV0DMSUg/YxV83XuMVe1Vd7A60QVj55t0=;
 b=jRqJX8hNHsmQD+FdQWrMvR6N4YRjuL734+BLQDOvfvz8hJ3/DlS08EvbdcJGJPdoKf
 QbDeNa5/3rI2ZbgGrI4eZyIa3uHTFWLCzhAGFTPCOdcf56r6JVuyk1/6LfruHaga0vqY
 iMeLBA5XbWYgmJMxthahXwmYxlEc+xbvSuaw/HYhik2f3mJEcK6+WwYs6xqc9k9TV9yy
 rW2xvhM4hWeuYeBj23A+5eO1124CSHGKS0z/oEijo4x3BUrnIMwJurQ0CjASwYzuCXZL
 PVy+MLRSlS+wWFLywX3Ki33ubSZ5P8S44YEF3onDSFl78GGYVprdcwdLEBsDehNXgrmo
 brdA==
X-Gm-Message-State: AOJu0Yyl/0sjyDkAQCfL0zeTRmYQlOVmFUu/DK9hKTV99xzzqCs289+T
 pqQ57IpaHMz9saTFLthiVryNtWBXwUmCc4ZScQ7vAyaTCEQcfGtnKV6QRe0erLIpjNk8UMkP1Ub
 U94YU
X-Gm-Gg: AR+sD13hIoaC4wP1BWnj7COJW1uFLMpsL1ZC5sAH9DL3JKx8fAJNiwN02T6afHyKlWu
 qhytwdB6HZREaBai7BUxxrNxoqYfcHCQwVnuK9QTY/7DDVuuAjylqEYfPd+F3elIDCdEE8g8cOF
 l01KJrt4ln8gBWRHc8i5f4KfVrZ7s5DO9NOEaIuySb4jAC82ql9yw/bNzogJojCw/+xtfC913To
 lEjoOj3pASdMhqDLydts/nrKnqZEsxKBVglauB0EbkJIZbLPuSvmifY/3E1StcM1qiezD43prW3
 R1eeOFLC5Jg8tCVcQBfhVOcJxp66hB6R/T7JN4ZVfkjhzApdyOAAps+U7c++M/Ib86ZqEASxxt/
 IUgFjnRZVzaSgoGy8+dz1tca31RCygALq7zLGgYT5AD+YSRmJb9vPLQmPm5w8BDd3gg7tYhEzHk
 z77Y7DamjwfiC6RTZKyZPxf1iZ0Ibzrl4Re4ho4UZ3IqgLtZUjyQ==
X-Received: by 2002:a05:600c:8b6b:b0:499:8f9f:e9ee with SMTP id
 5b1f17b1804b1-4998f9febbdmr348902645e9.7.1786993210441; 
 Mon, 17 Aug 2026 12:00:10 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:09 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 22/25] iotests: cover the qemu-img bitmap operations on
 parallels
Date: Mon, 17 Aug 2026 20:59:39 +0200
Message-ID: <20260817185942.1065143-23-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

qemu-img-bitmaps drives convert --bitmaps and every qemu-img bitmap
sub-command, but for qcow2 alone. It is built on a backing chain and a
rebase, which parallels has neither of, so half of it could not run
there and the format is left with no coverage of any of this.

Cover what applies in the parallels test instead. A copy made with
--bitmaps has to carry them, and raw has to refuse them. --merge and
--clear leave the bitmap count alone, --remove-all sweeps it to zero,
and --remove-all --add in one invocation leaves only the bitmap which
was just added.

An image which was not closed correctly is left out. parallels-checks
covers that already, next to the code which drops the bitmaps.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-bitmap     | 39 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-bitmap.out | 12 ++++++
 2 files changed, 51 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
index 1cf2fd2add..37367defa6 100755
--- a/tests/qemu-iotests/tests/parallels-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -273,6 +273,7 @@ stored = file_path('stored')
 copy = file_path('copy')
 STORED = '9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69'
 OTHER = '11111111-2222-3333-4444-555555555555'
+MERGED = '22222222-3333-4444-5555-666666666666'
 
 
 def read_header(off, fmt):
@@ -430,3 +431,41 @@ log('--- and the image is still readable')
 res = qemu_img('info', '-f', iotests.imgfmt, stored, check=False)
 log('image opened' if res.returncode == 0
     else iotests.filter_testfiles(res.stdout).strip())
+
+
+# qemu-img-bitmaps drives these for qcow2 alone, as it is built on a
+# backing chain and a rebase, which parallels has neither of.
+
+log('--- bitmaps can not be preserved into raw')
+make_image(STORED)
+res = qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O', 'raw',
+               stored, copy, check=False)
+log('    ' + iotests.filter_testfiles(res.stdout).strip())
+
+log('--- convert --bitmaps carries the bitmaps into the copy')
+make_image(STORED, OTHER)
+qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x11 1M 64k', stored)
+qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O', iotests.imgfmt,
+         stored, copy)
+info = iotests.qemu_img_info('-f', iotests.imgfmt, copy)
+data = info.get('format-specific', {}).get('data', {})
+log('    %d bitmaps in the copy' % len(data.get('bitmaps', [])))
+
+log('--- merging one bitmap into a new one')
+qemu_img('bitmap', '--add', '--merge', STORED, '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- clearing a bitmap keeps it in the image')
+qemu_img('bitmap', '--clear', '-f', iotests.imgfmt, stored, STORED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- remove-all sweeps every bitmap of the image')
+qemu_img('bitmap', '--remove-all', '-f', iotests.imgfmt, stored)
+log('    %d bitmaps after remove-all' % len(bitmaps_reported()))
+
+log('--- remove-all with --add leaves only the new bitmap')
+make_image(STORED, OTHER)
+qemu_img('bitmap', '--remove-all', '--add', '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    ' + ' '.join(bitmaps_reported()))
diff --git a/tests/qemu-iotests/tests/parallels-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
index 994c67390e..df6f676106 100644
--- a/tests/qemu-iotests/tests/parallels-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-bitmap.out
@@ -92,3 +92,15 @@ read 65536/65536 bytes at offset 0
     0 bitmaps stored
 --- and the image is still readable
 image opened
+--- bitmaps can not be preserved into raw
+    qemu-img: Format driver 'raw' does not support bitmaps
+--- convert --bitmaps carries the bitmaps into the copy
+    2 bitmaps in the copy
+--- merging one bitmap into a new one
+    3 bitmaps stored
+--- clearing a bitmap keeps it in the image
+    3 bitmaps stored
+--- remove-all sweeps every bitmap of the image
+    0 bitmaps after remove-all
+--- remove-all with --add leaves only the new bitmap
+    22222222-3333-4444-5555-666666666666
-- 
2.53.0


