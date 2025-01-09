Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB7BE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVq5t-0005cC-8m; Thu, 09 Jan 2025 05:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+10359aeb926cd7703950+7809+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVq5p-0005YH-KD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:48:50 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+10359aeb926cd7703950+7809+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVq5n-0007Cv-6f
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=gEEm0XmWgGxYNqlZSR/BIfsrWHk/pz1tfIvuH5Me270=; b=twL6bHT4E47Yme/UfySWkqm+jb
 yccVUq/OWEZg6R6kBqSQSB2xs7h3pFWMxG2cL4MIkN+dFz1EtSHPZFgh/eX4vuA2fjL+1JFXZkOf/
 4Fr1fN/eBrK0sWofgI5p1rSU5/LSA4j4GsHKLiu/5PthPaoUnZAcvSDdXG+clZeETC9nRnBJwIFYz
 Ar34JkJT/mV8pR0UagFa5V5ZyV1F0PseW7De7sEQDVlEnXQX81Mb8vDtu08PvTIRND2ETjZfBm5Cn
 kBtX9hcAmjYMD0ISTpH8DMU6W2PEdQzswn3UbXWvoAXCvFDyLCsv9T1mwamqe7AW4VXTyqkqHb9v4
 B93v+aGw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVq5e-00000005P9n-2B7e; Thu, 09 Jan 2025 10:48:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tVq5e-0000000Acl6-0Lx7; Thu, 09 Jan 2025 10:48:38 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 2/2] hw/xen: Check if len is 0 before memcpy()
Date: Thu,  9 Jan 2025 10:48:37 +0000
Message-ID: <20250109104837.2532259-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250109104837.2532259-1-dwmw2@infradead.org>
References: <20250109104837.2532259-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+10359aeb926cd7703950+7809+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

data->data can be NULL when len is 0. Strictly speaking, the behavior
of memcpy() in such a scenario is undefined so UBSan complaints.

Satisfy UBSan by checking if len is 0 before memcpy().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_xenstore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 5969105667..17802aa33d 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -532,6 +532,10 @@ static void xs_read(XenXenstoreState *s, unsigned int req_id,
         return;
     }
 
+    if (!len) {
+        return;
+    }
+
     memcpy(&rsp_data[rsp->len], data->data, len);
     rsp->len += len;
 }
-- 
2.47.0


