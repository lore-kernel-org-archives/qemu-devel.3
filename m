Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C21EEF30D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy225-0008Ru-Su; Thu, 05 Mar 2026 01:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vy21n-0008CT-MU; Thu, 05 Mar 2026 01:17:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vy21j-0002Va-VR; Thu, 05 Mar 2026 01:17:43 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6256HKcr066823
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 5 Mar 2026 15:17:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PO1Qslwg9u04nJdizAJfbxCF6DX96er2JVAT/7p3EVU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772691444; v=1;
 b=rPtdvqGGLXBY+HAMb5cp3a5nV7czwyK8l5kX62mNwQkmGfK4d/gGB9w++uQdRDUf
 M8TD9n7w9iIK9JX6feDZnC9NPQ8NKGZPlY9ARxEFG5/OIT0BEB3c6/ITVICOBTnI
 gnGUFU/oE9enTGsKUTi+1guohH2JNMx5T476LMMVgxrnF5jAaRZ1U8aWgGNlN8Xk
 JMNSzHgnKlnEc3tUwDr5D3QO/HT/a32ZKQ7/KwDFN8nRjVXwgob147T3u1351qbc
 riRgohgTPvn8SVPt+6lOhu5D+yg5AEypJi6nd5d022JUYIYvRPbVhJc1UVh02Ua+
 2mhLLj/INca1qfeRKN9Oyw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 05 Mar 2026 15:16:46 +0900
Subject: [PATCH v4 3/4] tests: Clean up double comparisons to avoid
 compiler warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-nvme-v4-3-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
References: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

To enable -Wformat-overflow=2, we need to clean up a couple of false
positives:

[2/5] Compiling C object tests/unit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o
FAILED: tests/unit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o
cc -Itests/unit/test-qobject-output-visitor.p -Itests/unit -I../tests/unit -I. -Iqapi -Itrace -Iui -Iui/shader -Itests -Itests/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-6 -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -fsanitize=address -fstack-protector-strong -fsanitize=undefined -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2 -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /home/me/q/var/qemu/linux-headers -isyst!
 em linux-headers -iquote . -iquote /home/me/q/var/qemu -iquote /home/me/q/var/qemu/include -iquote /home/me/q/var/qemu/host/include/aarch64 -iquote /home/me/q/var/qemu/host/include/generic -iquote /home/me/q/var/qemu/tcg/aarch64 -pthread -fPIE -MD -MQ tests/unit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o -MF tests/unit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o.d -o tests/unit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o -c ../tests/unit/test-qobject-output-visitor.c
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
../tests/unit/test-qobject-output-visitor.c: In function ‘test_visitor_out_list_struct’:
../tests/unit/test-qobject-output-visitor.c:578:26: error: ‘%.6f’ directive writing between 3 and 317 bytes into a region of size 32 [-Werror=format-overflow=]
  578 |         sprintf(actual, "%.6f", qnum_get_double(qvalue));
      |                          ^~~~
../tests/unit/test-qobject-output-visitor.c:578:25: note: assuming directive output of 8 bytes
  578 |         sprintf(actual, "%.6f", qnum_get_double(qvalue));
      |                         ^~~~~~
In function ‘sprintf’,
    inlined from ‘test_visitor_out_list_struct’ at ../tests/unit/test-qobject-output-visitor.c:578:9:
/usr/include/bits/stdio2.h:30:10: note: ‘__builtin___sprintf_chk’ output between 4 and 318 bytes into a destination of size 32
   30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   31 |                                   __glibc_objsize (__s), __fmt,
      |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   32 |                                   __va_arg_pack ());
      |                                   ~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

These buffers cannot actually overflow because the doubles are
between 0 and 31.0/3 inclusive.

However, formatting doubles just to compare them is silly.  Compare
them directly instead.  To avoid potential rounding trouble, change
the numbers tested to be representable exactly in double.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 tests/unit/test-qobject-input-visitor.c  | 8 ++------
 tests/unit/test-qobject-output-visitor.c | 7 ++-----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 84bdcdf702e0..beee11db4e47 100644
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
index 407ab9ed505a..3c47b28f6638 100644
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


