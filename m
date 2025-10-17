Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6DBCCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ij9-0000qZ-ID; Fri, 17 Oct 2025 07:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9ij5-0000og-TJ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9iiq-00060Z-8e
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso5240685e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760700841; x=1761305641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtQk0GJuCq/JgD3T73Q/ujEtbCnLstw5lfgjKUjPFqo=;
 b=L5S3gMOhGJk/y0aLQRV9tOioqwVF78P0Mq2DppWoJsiodn+hSvClkUaCNIJQlVlFkd
 aO25xRZLgyN0hcZGC5MYEDEPxT9qEBuJt2LWpPp9s9nwOP2y6NsV+VYVeP+JMmwsnxTQ
 A0cWPzMogKS9Uovc8A12oKjcMtCq/rcRzn9gG9XzbPl70WI/CQJCoO8n3s1EDQXwkUcz
 wgwCNdf/o0YB2RCUh/XfEG1UCGw6Ft6JFWCIYp6/n3vYvKliG6J/k0SGgunx8s8QcYEM
 0LSdgc3vSgub21czHuE6lmbQ7J7wgFAHh0VK5QmP3LsWMSck6RU7GhSgHHbr+4HF4kJC
 uq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760700841; x=1761305641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtQk0GJuCq/JgD3T73Q/ujEtbCnLstw5lfgjKUjPFqo=;
 b=ojicznkREtfqy29wyyZjUGSTQVBQ1tyLYc4hZYqyX5lYo9CibV36I9e43mqemW0EKd
 aB6PL4Ma7HMiGyRndLbFiVpzCk7AuGNz6Hto31tLfJzfAchqszjP4ybEFl2sDRt+Ssrb
 nnpTcUPgkZiz0hE5BWcnw7HuR39AcUv0jrCIYj1u/+NAv5HxbLwY7TDEZdfsaGRPmIo+
 jBuwHeaXvSDXHZk2GvGzQfRVLgu/sGbrlwTMrWQwxBnKfp1tN05H1Au4ZxT0yUHOUO6J
 5IJZ6RUhDAotPQzcv01MC9GtZyBCYox0QGhXZ3rCCGVbAHYCzd35BzT9+WzU51wWGJ75
 e4Bg==
X-Gm-Message-State: AOJu0Yw7p6Fe3jnRL4XJfzpCf1RA/Q05Cf83wZ5ZiTzYN5/J/idGzadJ
 E3hsHOxlI68YfWDVRNDfT/PNhrr3SFjS6FZKb+tf5CwpMwK9Am7sgEw+sAjrsQ==
X-Gm-Gg: ASbGnctF62gNT9VSIXQDx8T184eGtVXCBQTrAy2rdayjz8W66qhHsmBBkYXymMnI4hT
 AM6WLL83AG3s0Xc3QAHPxLBZXqT4MFZnT3Zt7U3epdCulFkA/fa7cd8VYz5wQOITCVwNrZiDVbu
 N0Sb7RGsnd1Y5rj6kioA3WzIGN8tcXpBsNrX/JFb3dfXhg60G3NxTDPflHrNN2zagZ/UcPe6cdq
 cRYz9OxZQaYFElERRiksoMFLxXZzJNx+klxXJVxcHJacHgstUXBIp9B3IaMxHyBAO0chBBdGRNw
 H6vj106UApEXDh8BE2QkYLfGBpy6pssrGKBXVMMbkgHGcMWKx0EYQ6fcoja4i0WiIApKPztCclk
 yc+vTagEgnz62VF1z/sPVmxYfJLqIznCWe8deMoELonSumVx517i+0kXygDsC9r4MhX16Vwounm
 KpAvtbqaqW71G6yccqR2mu+SV4pdILE9yKU3F5WJAq3l0=
X-Google-Smtp-Source: AGHT+IHnu+GakzzSeEi2iUO0tTroVaMAXrhyHBzxS5+N+mWFSMCsDYg1lzurYZznwJfsxWlWvCdE2A==
X-Received: by 2002:a05:600c:4e11:b0:471:c72:c807 with SMTP id
 5b1f17b1804b1-471179079c7mr26540505e9.22.1760700841253; 
 Fri, 17 Oct 2025 04:34:01 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711444c8adsm80395435e9.13.2025.10.17.04.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:34:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 4/8] hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
Date: Fri, 17 Oct 2025 13:33:34 +0200
Message-ID: <20251017113338.7953-5-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017113338.7953-1-shentey@gmail.com>
References: <20251017113338.7953-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Avoids the error-prone repetition of the array size.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/mc146818rtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 61e9c0bf99..5a89062b4c 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -726,13 +726,14 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
 
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val)
 {
-    if (addr >= 0 && addr <= 127)
+    if (addr >= 0 && addr < ARRAY_SIZE(s->cmos_data)) {
         s->cmos_data[addr] = val;
+    }
 }
 
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr)
 {
-    assert(addr >= 0 && addr <= 127);
+    assert(addr >= 0 && addr < ARRAY_SIZE(s->cmos_data));
     return s->cmos_data[addr];
 }
 
-- 
2.51.1.dirty


