Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4B4C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw2C-0004pi-Qj; Fri, 14 Aug 2026 13:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw2B-0004l8-Gk
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:35 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw29-00080n-Vs
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:35 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1178663a91.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729772; x=1787334572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pv+mg0Z9mw8NIXvdNaS8CPR/ozwe3Vna0l1dvUjXDw0=;
 b=GgVp7ql9iHVB/APVe0R2JGaPpxFUGXRRyQiHf1uz28kLQPV+z4kvSqgZXkiYPJbo40
 p41D9ley65I49o7/7vNa65DmsIwnIXjhjOWG/w+I3R4ZUq15RjCLHMhqYD31ycPxQaYT
 4FeKEfwP6xJDAd2s4zsJaNvZbXT4RwhZmqGH34Tj0duNnT/stN1Q6TmNz+QcYP0DJWw4
 NMnGoStE9mE4xFKgoQyuCIvKJMsmQw+eA7RMceieZ3v70DWi8+p3VxI8Ybc4PwvTb0Rs
 0FLQxq+uoDDJ6tN7R1QHt4qlWt10DS4WRgoAGELxTBJFu2JB9/9rVRZYyFZRI1n1A3n/
 K7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729772; x=1787334572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pv+mg0Z9mw8NIXvdNaS8CPR/ozwe3Vna0l1dvUjXDw0=;
 b=I9uvoyBfIFauXx+IUGLOW8+V7nhCVsAIaBjG/hmhazmARRoXIM7FA9EuaZHFPW+uTd
 NkcM3GvehvhCJKlsEIaBIyF9Db/Z8Navqp87nzyGYyn5wZ7WFtJ2ZsONnrfz4IjotHAC
 VSANTzvzL5R87AbcXZmGVXC7RFdx84uocUZibHha16lBcCz3/kY8pClrbng4kBRAiKkX
 JhdU7b3Uw2sm8NF76eSQuHyN1N+RYZueRxEpkLZRt33V/Yoso+5hKmimPGA+Afqjylir
 1JBpBQzheQF9YsC0wfBH3xh+CmE2r8fNpHjRqmJLwht9bR0s77aw6fRKU0RZl0BO6lr/
 /AMg==
X-Gm-Message-State: AOJu0Yw5QuTMNaN0wplK8bcGnBiJVgkrOppuRDeFkIzaISOnUHJ41twd
 ovqM+SSMZvIfa5QwDvxj9ylFP+wJ/WJehL43YANjwekUabj0+YpTOcN1KyjpWwHC8mU/3A==
X-Gm-Gg: AR+sD11WH5UpNN95TduamHflmODXi3ZE9gm82z4AO9AiYm4IooSXLv+iDvejWYRp0Lu
 T8rmSNJMLVIRqGzjNR7wWjdk0xOJS5PknW9IlfiLr4jkZqdAWmxHiJZh7/s4O1I+oRIx6rm/HHt
 b2hJj1EJL/hsR9c5C3y30rfWY0RN36UBLskg2oESH7gD1xZ+LbsbyItkyQtncj43TayuElAdrHl
 mLjCZjTTyhaMPlj/hgMc4ODm3nP4cPtO6ck5OUpAXNTFq2nf+EJlwNhR2N4NJBq5vlVaJqSRvf0
 fVGjYU/q/+U3O0ED2XGpK6D/fj9ghpY+d8uechNfqWm5yNZKUQI1O+8lLZKta9vn8Jf9iPK0wdb
 n5kM6xkWRqmnE6sisApu5JAJ0BsEKwbS9eaYxoUaUUlkK0P+aht2v/kZ/vJ5T3ka9bWXabfFlYL
 1N6bGmE3HRvh0YgahGO1qk9Nllg/gYCyg73id72BKGRirq+TkW5orMjV2XdxxJN88UXA4oe9kVS
 r9heOEQ
X-Received: by 2002:a17:90a:dfd0:b0:38f:23d6:b4ad with SMTP id
 98e67ed59e1d1-3933b792985mr8734887a91.8.1786729771892; 
 Fri, 14 Aug 2026 10:49:31 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:49:31 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 14/15] iothread: remove legacy iothread_get_aio_context()
Date: Sat, 15 Aug 2026 01:48:28 +0800
Message-ID: <20260814174830.1691540-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

All production callers have migrated to either the holder-tracking
iothread_ref_and_get_aio_context() API or the explicitly unsafe legacy
accessor. Remove the now-unused ambiguous getter.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 1 -
 iothread.c                | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index 2ef8c1a1bb..9850cdb3dc 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -66,7 +66,6 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
 
 /*
  * Return @iothread's AioContext without registering a holder or taking a
diff --git a/iothread.c b/iothread.c
index 3afa296aa0..1e9c9cb62e 100644
--- a/iothread.c
+++ b/iothread.c
@@ -422,11 +422,6 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
-
 AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
                                              const IOThreadHolder *holder)
 {
-- 
2.54.0


