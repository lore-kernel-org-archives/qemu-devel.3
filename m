Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504FC79FA9
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3SzI-0005f6-6P; Mon, 07 Sep 2026 02:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzG-0005eg-R4
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:37:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzF-00065L-C8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:37:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d715f4a587so45936515ad.2
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763068; x=1789367868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8VZvJfwzEx83my0luzHgdVUOYxehjQZN8hTGEXB0zHU=;
 b=eHHisUDr2rXX/Aa+2RR8osQDVk1+rN8aoY6gf14g0yTOoU462DXIkad7St6AMA020S
 9MgRMQk0asrXwoJe9hwro4Fgw12ongHtPIGQ/ve3PmL7U9yaMzuDgsBTtg4KJMoB9HkH
 L3eP6SX4/U2s9rjRVs2MGIgWX1l+1rCjfNR4EQbc0e/I8p3B9Li7o3MJe3B0JVOCwGO8
 WX533DwBB7+CBSEucfEqqsMq11WOyNtcZO58UkkhXQaJLRNO1rp5M9wWoqNb4MgutFrj
 5fmIUddoSz6S6g/+XMnn9+fFzg9FmO8X2X3scF86Iz7TiqhAlehquUdNOkSWfZ+fYzfK
 PcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763068; x=1789367868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8VZvJfwzEx83my0luzHgdVUOYxehjQZN8hTGEXB0zHU=;
 b=LTeUvOQLULH7ZZJvoMfhOCKRZijchIemZUC0SNm++DOLq1AvPkr2LL+WOJC47L52OD
 4ThhZHG2CFrj83MOsiVRx7RzBU64KJyycGUlZr+pHfueAMwjqTJ+0cXpqbClgCrgZOLn
 EtFh0NCqg9cy9DqZIbm+3OYJlw6yO3JNxM8PLDVd1q1tfD3nFZRlMlrj+Hzyq4CTBWcI
 lTOkWkzED+nAf3mHwIYsahhWOinf6GFpypibi5KqiBWp6JpEbq440gGAZ3AUwD+DYeFC
 swEjUzQhOGO5IVGztuQcVY66BgI3S5gk8T75OMdfrXGqjofe5rdUrg35qqQGJEGXwraT
 8Pkg==
X-Gm-Message-State: AFuF++kKyjZaIV7j9bEn/vijZ9hL9yCA8Eayr3rkt11sTK6sAiV4MhaX
 9PZcRjwdxXztEsiYp2+By3Y0wzjhBIqB2t1DyM+se9qdspXxWFlXXc8HW47WZ5d8He/uYA==
X-Gm-Gg: AYBFou2Ft607sOaVX0XXQmhF4OwJj/jEOy5CjssR9Kfi+2AghIGxlDbtAosAKp98YJ/
 zwcECOHBxTjjNxIPvS55zdzNdyT9VelUZ93B6mdFFlLdiZuvw8OFcvb6cGBYi9AAHessL7eo+QV
 TUHsphBiCuYPDXYNq71qa2MM75T7fJ78vntclgzzlf1DB4sh4QnOxYrOVyOrB5Bf5TxibxDMFfo
 fCizbPpujFRUTcutC1jNOAcWa7iyqDBli2ZR4EKE1Z2SqlTeZFclNUZS2GzKuKtPwgeEDgLirQZ
 qVSdaR7aJ28wBlFwyKXRYAU+971ksDclqBUILhNwZF3R/JftHRMB7Zfll+1ndjy48kzWvANRfWZ
 pJHAsuEra5FdrNZiNagarkM/nX1Ykoj5J6aZtLtUJXbXEs3CD+ib8R7UFYdnlnVK70jDnFxt8+p
 Tp6+ph5msEvD+yUo8xVtA4Fi2jx+uvKcoLN0jcDzSCOjvQjQe+Cr0d54OiUXI16NHvPXkezP3QH
 OaXhaiQxirlfzPy
X-Received: by 2002:a17:903:468d:b0:2d9:56d8:75f with SMTP id
 d9443c01a7336-2db1266772dmr334377145ad.9.1788763067940; 
 Sun, 06 Sep 2026 23:37:47 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:37:46 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V15 01/14] qapi/misc: Fix missed query-iothreads items
Date: Mon,  7 Sep 2026 14:37:12 +0800
Message-ID: <20260907063725.626685-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62d.google.com
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index a21ba61b96..baa50cc844 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.43.0


