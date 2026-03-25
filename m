Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B593109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RLu-0004lI-N2; Wed, 25 Mar 2026 12:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLq-0004h4-KK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLo-0004PO-Rp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qoHEA22Z7ge7lGvugyBmZQB1jnxcxxOh+dfFXxtUbI=;
 b=iR+QTNJmS7VBt9VhC0YShNCYfqxyGQvCVIhRbznAUIJlk2PJ6jcxRqnSoWiK4tTGS7RY+C
 es8s+kJypooFVkwJkp9H4V2q75G/jCoGAE1X+hxvxhZx0BQVJ4DvTztTF02p9/qSYFuEda
 v8J7G4/DgKop1MR2rrWLqHh9abw+Bmg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-oNn97uyUM3OUIVSGeO5aTg-1; Wed, 25 Mar 2026 12:44:58 -0400
X-MC-Unique: oNn97uyUM3OUIVSGeO5aTg-1
X-Mimecast-MFC-AGG-ID: oNn97uyUM3OUIVSGeO5aTg_1774457097
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4852cf0318dso497685e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457096; x=1775061896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qoHEA22Z7ge7lGvugyBmZQB1jnxcxxOh+dfFXxtUbI=;
 b=BA9dE7BVdSJhjmRuqyqf99ecUxvoVR7MNL20YhV+tHseIkc5DjhU6mZB2/uLGZJqIX
 KfEfpNfMP4JqVm7Ryjs0jYebEpSGNHkDB4kgJ0RGQVOddgfsIHxe1WHMWluLf3Tw9E8A
 qBcB8JhOjxuSLe+W+KivT6f6eQHeUZ8HLf67xGRJ5te33HEDUbtG+3NdsWYvImkOjq2N
 nepBVOLWnUHEQmSjZqaJEMhpz30/d6wqE0WINOM5jrXHTx5VT1pRJG8Ys+G39i8YuKzy
 c59UIN26bsF1vKFrpoI6At/8lFJ3KeuycalLbaZ4m/9Asg8CdBuwIfgic58tqIcU4FkT
 hS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457096; x=1775061896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0qoHEA22Z7ge7lGvugyBmZQB1jnxcxxOh+dfFXxtUbI=;
 b=bKBnlvAtuUxtKLy9Ox8QIPw8QoXT9cvBM3SCPCfRA8w4XGFZNuG07qC4+pVd71NiW7
 BZQXCqeGz3lb3hfou7+i/3y5VPQ6tmUkauI+6ScBd5NfiB7z7Rpramf8M8GxTu3t4sH7
 yNGozKPMlEMX/aeLxRNMjaCMhq8X8Ya2Kgkqwkieo9gB5rqyIvLAQXSYUHMrOfuu/Vs7
 Nz1+paj11RZ0l+5gqgJ+/WtEwQgUwjOXLaMSwE2TrlnIx4qO04fQcu8mXFOTTz4rPePt
 BUmK/gJIhi14gwFbP0mLu2A1hpS6R9dwQB3S90DvDWZmfSevAypA34xwD21SSB3nJ+Qq
 BqZQ==
X-Gm-Message-State: AOJu0YxfENCbPMAlh2zR4S6QSRlsBjAtXk6VBddgmv6+fFHBfh/pRJtM
 xVmgvXvgMA+uugi6SAymv5JXa+h89FqXwXlXzaelh8Y5JHJvpYI4Gf2Le9E0P6CurTcdWRzEl8E
 ioMPt7wSYs8GgwEcNIR3m6MkVhZzBIOfKUjkfUW8pVyAHrdV/1P6DJsNLbYYmtGpSY9bI6y7Ygl
 MZvxGBgRQcNY9Xjf+jTP9U/fzlyZvsDg5SIVbke2eP
X-Gm-Gg: ATEYQzyzUaz8Ynps0hZNQenCuMhgyoCkcZQD+B9jj9Rbpqul0lzmGGIweYyGh2NFNv2
 7ugcZElFmTwMesxCDi8dNXNG+2XW6G6Dda0O8e7k1+hdZPwm5HYGiUpttkgWi8X7v1eFJX8Y5ij
 jf9KlpNzY1ngAHLxEFW28gFrNAyz+n5Wz3YXq7hYd4yp9ncxgPzZOXJa2ReRUIL9GbsOdWlqQgY
 Y2LUCaTtjviofAkpAto6TEB3cWMNAWT0c0imZk8aZTnHOfA0Fz5lQzybTW+llK9Se6dlQEOFqhh
 2O3C6HktkWVN0L6V2o9xvIDezDr/1dv9vn+TJcLMhqp0/Mck9uvEfJ7kgX/glthscY3HynN7Yzx
 ABXLXrRd8ArBfwbr4OLclJpQlhMQR6jeNgW8ZQ8p6cPj/cFutGqIWD9XBlz2V9Y64wUjAtAKsEq
 UnDvCJmYHy3g+wZhgNVwh7aweX
X-Received: by 2002:a05:600d:8453:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48716051e4emr44478875e9.19.1774457096524; 
 Wed, 25 Mar 2026 09:44:56 -0700 (PDT)
X-Received: by 2002:a05:600d:8453:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48716051e4emr44478545e9.19.1774457095883; 
 Wed, 25 Mar 2026 09:44:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487113d73c0sm159091275e9.0.2026.03.25.09.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:44:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alyssa Ross <hi@alyssa.is>
Subject: [PULL 01/19] tests/functional: preserve PYTHONPATH entries
Date: Wed, 25 Mar 2026 17:44:35 +0100
Message-ID: <20260325164453.72127-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alyssa Ross <hi@alyssa.is>

Otherwise, it's not possible to use a packaged qemu.qmp.

Fixes: 1497377857 ("tests/functional: Prepare the meson build system for the functional tests")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
Link: https://lore.kernel.org/r/20260323084739.1013748-1-hi@alyssa.is
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/functional/meson.build | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9bec5a07516..8c4d7f70e17 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -76,8 +76,10 @@ foreach speed : ['quick', 'thorough']
     endif
     test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
     test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
-    test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
-                               meson.current_source_dir())
+    test_env.prepend('PYTHONPATH',
+                     meson.project_source_root() / 'python',
+                     meson.current_source_dir(),
+                     separator : ':')
 
     # Define the GDB environment variable if gdb is available.
     gdb = get_option('gdb')
@@ -96,8 +98,10 @@ foreach speed : ['quick', 'thorough']
       teststamp = testname + '.tstamp'
       test_precache_env = environment()
       test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
-      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
-                                          meson.current_source_dir())
+      test_precache_env.prepend('PYTHONPATH',
+                                meson.project_source_root() / 'python',
+                                meson.current_source_dir(),
+                                separator : ':')
       precache = custom_target('func-precache-' + testname,
                                output: teststamp,
                                command: [python, testpath],
-- 
2.53.0


