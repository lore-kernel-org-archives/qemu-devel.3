Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E98E81BCF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSWt-0007GO-ME; Mon, 09 Feb 2026 09:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVx-00071m-BZ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVv-0005iV-FC
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770648322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlDKYwEF4UaJkW8mlh4JLyxhYfOaMXJXhMZFXwfXeOY=;
 b=aGnQaAzwLZCZztQ9kgHLhiC2YR1GaavBap3hecBTZEKzgfqYx4+TD7koBnNgn84BggN9gV
 Utgsh//I6cbT+4sgE7EyCA3QkWiVdoWiwp/HDd4d9bvopi//sKAWBo1R+Sj9fm2Zy4HnHP
 XmLWtFf8I5HUaAPUZ/wHbvhu5yurHD8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-UxoNFD5CMX-9dTZ6V7rDmA-1; Mon,
 09 Feb 2026 09:45:19 -0500
X-MC-Unique: UxoNFD5CMX-9dTZ6V7rDmA-1
X-Mimecast-MFC-AGG-ID: UxoNFD5CMX-9dTZ6V7rDmA_1770648315
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDC0219560AE; Mon,  9 Feb 2026 14:45:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58A0130002D8; Mon,  9 Feb 2026 14:45:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkrempa@redhat.com, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/9] scripts/qemugdb: timers: Fix KeyError in 'qemu timers'
 command
Date: Mon,  9 Feb 2026 09:45:00 -0500
Message-ID: <20260209144508.45268-3-stefanha@redhat.com>
In-Reply-To: <20260209144508.45268-1-stefanha@redhat.com>
References: <20260209144508.45268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Currently invoking 'qemu timers' command results into: "gdb.error: There
is no member named last".  Let's remove the legacy 'last' field from
QEMUClock, as it was removed in v4.2.0 by the commit 3c2d4c8aa6a
("timer: last, remove last bits of last").

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20251204105019.455060-3-andrey.drobyshev@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/timers.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 5714f92cc2..1219a96b32 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -36,10 +36,9 @@ def dump_timers(self, timer):
 
     def process_timerlist(self, tlist, ttype):
         gdb.write("Processing %s timers\n" % (ttype))
-        gdb.write("  clock %s is enabled:%s, last:%s\n" % (
+        gdb.write("  clock %s is enabled:%s\n" % (
             tlist['clock']['type'],
-            tlist['clock']['enabled'],
-            tlist['clock']['last']))
+            tlist['clock']['enabled']))
         if int(tlist['active_timers']) > 0:
             self.dump_timers(tlist['active_timers'])
 
-- 
2.52.0


