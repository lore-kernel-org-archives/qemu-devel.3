Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1623E7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBQo-0007L4-6k; Fri, 10 Jan 2025 04:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tWBQm-0007KW-Jq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:35:52 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tWBQk-000182-UM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:35:52 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so543658966b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736501749; x=1737106549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heAlNNCsF7d+p9roHrTGYRStQWTNbLe8js38yKlHKDA=;
 b=fYx3luO5HkedtxBS0UOk38igmMoAHUMxuixOmCLWubQf07d7ooWkVfmBGwjcjchnVz
 2/OuzmmXFPoja5Q0turv2Ebm3zbwJ6i2c/By/pmQ+QfXl0utXcpcdS4l0NVwnwtpawKG
 2N+E9eAsuXzRI6qiQbIsdgz1hJTsfValVLm4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736501749; x=1737106549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heAlNNCsF7d+p9roHrTGYRStQWTNbLe8js38yKlHKDA=;
 b=IbU+FASgBL5xhEkwAR62+1yad+n/Tv7hhOPC9rHpQc4j5A97sgRD9a9eSbZ/RooR8/
 UIqDlcDKm642mP/P/cIWgCv6i/XH1vg5oJOIxrVdLkqXL9S9Cnzo+rNFOqxDCpYpo5ng
 zK/aXsFg9wYcECLLNzx36C+3ASpZ4MnIDjOfufEjrzFudhuESXG+SIFACbHz/wcbVN9t
 RgiWXVZQ/RdCAPZGFuUdliwv7+3CbH32QcjJEklQ4v1jGrnAh72EbComgChUmW7miJca
 IBGMJgoEVyO5kSq1PUKc8Ahl4wf4A74L4lkI3VaJOsD3U9I57wSm+pPZvOMBo7mKGI+l
 EzxA==
X-Gm-Message-State: AOJu0YyC0P4iQHOx7s9Fxlepg+F4hn6OEY4ZZBHE6eD4dfoYigZkfw/w
 tu0Ysk/GbxnBlumY0hrTGZ1VCoaq6oFvQcy5BxRM3N9Y6EgkmDW98n/rLBbcCggHfZpDMbvAR0q
 7
X-Gm-Gg: ASbGnct6BangnkQCVhScUCL2qpMXGPnOpLa7evZS1P+aKxgVrS5oo/gaVpgjyrpilkG
 6DNhuqkWh1YSHn9IF/nly8/WA/DsLiVBoipH8x4ZzQC9a/wBxld968+JP3gY5PMsjRaA9Q50pQx
 h90uPeNc8NjX0VmGdCF9Neyf2H51U3eLwJkRi/jPPLACVqLQAWch0S2C/niZPS2ZgvdaiU0+Q11
 LhLYMMkWxukOMyjshxlanbBRggBJdmBE8V7iaKiS83mzjpObzZKqqZbxgdW1P9LvwM=
X-Google-Smtp-Source: AGHT+IF9I+Bn1k3Y/QmCjZal+54tLnhYTkVBay0iOh00OvkCwpx1fGD8280XTGNWMnzZIdz6+zIOPQ==
X-Received: by 2002:a17:907:7282:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-ab2c3c79cf5mr496036166b.17.1736501749069; 
 Fri, 10 Jan 2025 01:35:49 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9562519sm149700166b.132.2025.01.10.01.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 01:35:48 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 1/2] hw/xen: Add xs_node_read() helper function
Date: Fri, 10 Jan 2025 10:35:30 +0100
Message-ID: <20250110093531.23221-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250110093531.23221-1-roger.pau@citrix.com>
References: <20250110093531.23221-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=roger.pau@cloud.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

This returns the full contents of the node, having created the node path
from the printf-style format string provided in its arguments.

This will save various callers from having to do so for themselves (and
from using xs_node_scanf() with the non-portable %ms format string.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[remove double newline and constify trace parameters]
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: xen-devel@lists.xenproject.org
---
 hw/xen/trace-events             |  1 +
 hw/xen/xen-bus-helper.c         | 22 ++++++++++++++++++++++
 include/hw/xen/xen-bus-helper.h |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index a07fe41c6d3b..461dee7b239f 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -39,6 +39,7 @@ xs_node_create(const char *node) "%s"
 xs_node_destroy(const char *node) "%s"
 xs_node_vprintf(char *path, char *value) "%s %s"
 xs_node_vscanf(char *path, char *value) "%s %s"
+xs_node_read(const char *path, const char *value) "%s %s"
 xs_node_watch(char *path) "%s"
 xs_node_unwatch(char *path) "%s"
 
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index b2b2cc9c5d5e..0fba7946c55e 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -142,6 +142,28 @@ int xs_node_scanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
     return rc;
 }
 
+char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
+                   unsigned int *len, Error **errp,
+                   const char *node_fmt, ...)
+{
+    char *path, *value;
+    va_list ap;
+
+    va_start(ap, node_fmt);
+    path = g_strdup_vprintf(node_fmt, ap);
+    va_end(ap);
+
+    value = qemu_xen_xs_read(h, tid, path, len);
+    trace_xs_node_read(path, value);
+    if (!value) {
+        error_setg_errno(errp, errno, "failed to read from '%s'", path);
+    }
+
+    g_free(path);
+
+    return value;
+}
+
 struct qemu_xs_watch *xs_node_watch(struct qemu_xs_handle *h, const char *node,
                                     const char *key, xs_watch_fn fn,
                                     void *opaque, Error **errp)
diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
index d8dcc2f0107d..6478d25be5e6 100644
--- a/include/hw/xen/xen-bus-helper.h
+++ b/include/hw/xen/xen-bus-helper.h
@@ -37,6 +37,10 @@ int xs_node_scanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
                   const char *node, const char *key, Error **errp,
                   const char *fmt, ...)
     G_GNUC_SCANF(6, 7);
+char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
+                   unsigned int *len, Error **errp,
+                   const char *node_fmt, ...)
+    G_GNUC_PRINTF(5, 6);
 
 /* Watch node/key unless node is empty, in which case watch key */
 struct qemu_xs_watch *xs_node_watch(struct qemu_xs_handle *h, const char *node,
-- 
2.46.0


