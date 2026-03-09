Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B340F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcxD-000123-IH; Mon, 09 Mar 2026 11:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwy-0000EO-G8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcww-0000er-RN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso108445445e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071717; x=1773676517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8/T06OpHJH5m9fii5ifmkMMsmok/9oyj+L/ZSYDiSkw=;
 b=FzxdbZ7yfZdgQs9pF2q1/tTxoFejPWElGYWqYDdx8uUVPqjjPSQseWStxaafNX7qoE
 /Zeb92+BQY54mnWTVJ2rGfvttVeK/6Qkhx4fqV6avnEtlUJCeFjuc9y8JeKRnEN6YLny
 uIlX7W8hLcWQCUprOqgjQgbNDqxKovvzGqCuyHJ72YsEQGeUTRHWssKc5pv6BlaalqNM
 27/SV4H69GZoZZbK9QjsiPc+0284kaIM+8BecmIcE8VKpbm0yFHXN3eAEnfege/0h1H9
 GLPiYqvRPXLNKLbT5i84p4puBj0RUz6K96r6BIlxsuf3np3+UDZ2hFhIUHbu/sA2V6yj
 RJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071717; x=1773676517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8/T06OpHJH5m9fii5ifmkMMsmok/9oyj+L/ZSYDiSkw=;
 b=alkWsQWlfNGuJ0qk8C/besDJK5MBXHvWYOP0icYREZqXX7cPvTVHrBqU3F6fpkt7aN
 kbhOMSZHRhnXU8HWXn7REbZDhyC3ZA2GgZG7oeQIL0tFagtfgJs4O/9H9gv2tfy0TV7k
 0lQBSHEug+i/y07Cv6I7mEgZNhcryGmhax7qB2uPzHaKJ59+J5zm40hLC6bteoH0Ghlk
 zQWh9v0RqpXj9SIzf3bJtb4Uq4Xj+vvXmlYthCw4ufz5p9vLHhlSjA5vxlp5rb0pOV20
 bU+/NX3imkwW9gr7VYsv2620loLHjnlSocCZM4gvgACkTiQhul3oBDDwxh00e3Rqe4IO
 7A1w==
X-Gm-Message-State: AOJu0Yx3YsZxdYBb9McqZAK8JevDki9NJJwH1YHMJlJ3lJGNVHGK23MO
 iLxShWvK4WC/BAieYkQjnQPDkZv/LV1NBWBbyx2KTfAjk8mX3kdkZW9TxhaC3YoYjIdmu5DAT1m
 DnpNOwFU=
X-Gm-Gg: ATEYQzz/MJK8mEZA6WaWOhwRv+sbko0tHS5LcRWxlIt0d2yTqnuAtKko30hb6+ZXxT7
 Fba0LSLWQqQnO9jsbypTiq1QKtlE9yw2WUwbBib5aeXF+KoEq+lNHlet/Bgv7Ij5MLURh/lCvhp
 ztTWYQ6Vw83gl07fyX0S7xbbLk2rrjEAuM1SYd830hhGM8qMiamdE+f454JVkzzcihkWEK7p1ZS
 8FokXG7GZY/WQyoM0771ioi547JtNgn2xCc6X/9ceYrrsMpiNkxOIxzLVnCQ7GxZhGBkm1Z/boX
 4NvCf1Fj17fqMF7XDHcUeianYWieAXEx4s3KfOVzOyRTbmE/glfapjoIsDLUOb+LAF8NSQtSHlc
 A5Rdr+gz1mFQWsD1IW0QpKStEcBna1WVlzK5NY2Wc5PYfgXtsqXEc4/Vc7QnBr+SAqM6sGf+PLn
 uthJRvVELWbw/p7nZjEKk1c0+lLKxT+R7yDjotOGT+qEzaY/sv05rczYZtdIak5QAp0mwbTYYu
X-Received: by 2002:a05:600c:8b68:b0:485:3991:5d4 with SMTP id
 5b1f17b1804b1-48539910730mr77717675e9.31.1773071716958; 
 Mon, 09 Mar 2026 08:55:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852470a654sm88786445e9.29.2026.03.09.08.55.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/49] tests: Clean up double comparisons to avoid compiler
 warning
Date: Mon,  9 Mar 2026 16:51:56 +0100
Message-ID: <20260309155219.62400-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

To enable -Wformat-overflow=2, we need to clean up a couple of false
positives:

[2/5] Compiling C object tests/unit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o
../tests/unit/test-qobject-output-visitor.c: In function ‘test_visitor_out_list_struct’:
../tests/unit/test-qobject-output-visitor.c:577:28: error: ‘%.6f’ directive writing between 3 and 317 bytes into a region of size 32 [-Werror=format-overflow=]
  577 |         sprintf(expected, "%.6f", (double)i / 3);
      |                            ^~~~
../tests/unit/test-qobject-output-visitor.c:577:27: note: assuming directive output of 8 bytes
  577 |         sprintf(expected, "%.6f", (double)i / 3);
      |                           ^~~~~~
In file included from /usr/include/stdio.h:970,
                 from /home/me/q/var/qemu/include/qemu/osdep.h:114,
                 from ../tests/unit/test-qobject-output-visitor.c:13:
In function ‘sprintf’,
    inlined from ‘test_visitor_out_list_struct’ at ../tests/unit/test-qobject-output-visitor.c:577:9:
/usr/include/bits/stdio2.h:30:10: note: ‘__builtin___sprintf_chk’ output between 4 and 318 bytes into a destination of size 32
   30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   31 |                                   __glibc_objsize (__s), __fmt,
      |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   32 |                                   __va_arg_pack ());
      |                                   ~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
FAILED: tests/unit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o

These buffers cannot actually overflow because the doubles are
between 0 and 31.0/3 inclusive.

However, formatting doubles just to compare them is silly.  Compare
them directly instead.  To avoid potential rounding trouble, change
the numbers tested to be representable exactly in double.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260305-nvme-v4-3-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-qobject-input-visitor.c  | 8 ++------
 tests/unit/test-qobject-output-visitor.c | 7 ++-----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 84bdcdf702e..beee11db4e4 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -500,7 +500,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
     g_string_append_printf(json, "'number': [");
     sep = "";
     for (i = 0; i < 32; i++) {
-        g_string_append_printf(json, "%s%f", sep, (double)i / 3);
+        g_string_append_printf(json, "%s%f", sep, (double)i / FLT_RADIX);
         sep = ", ";
     }
     g_string_append_printf(json, "], ");
@@ -583,11 +583,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
 
     i = 0;
     for (num_list = arrs->number; num_list; num_list = num_list->next) {
-        char expected[32], actual[32];
-
-        sprintf(expected, "%.6f", (double)i / 3);
-        sprintf(actual, "%.6f", num_list->value);
-        g_assert_cmpstr(expected, ==, actual);
+        g_assert_cmpfloat(num_list->value, ==, (double)i / FLT_RADIX);
         i++;
     }
 
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 407ab9ed505..3c47b28f663 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -538,7 +538,7 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
     }
 
     for (i = 31; i >= 0; i--) {
-        QAPI_LIST_PREPEND(arrs->number, (double)i / 3);
+        QAPI_LIST_PREPEND(arrs->number, (double)i / FLT_RADIX);
     }
 
     for (i = 31; i >= 0; i--) {
@@ -571,12 +571,9 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
     i = 0;
     QLIST_FOREACH_ENTRY(qlist, e) {
         QNum *qvalue = qobject_to(QNum, qlist_entry_obj(e));
-        char expected[32], actual[32];
 
         g_assert(qvalue);
-        sprintf(expected, "%.6f", (double)i / 3);
-        sprintf(actual, "%.6f", qnum_get_double(qvalue));
-        g_assert_cmpstr(actual, ==, expected);
+        g_assert_cmpfloat(qnum_get_double(qvalue), ==, (double)i / FLT_RADIX);
         i++;
     }
 
-- 
2.53.0


