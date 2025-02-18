Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BEDC021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQz-00053U-W3; Tue, 18 Feb 2025 11:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQx-0004zJ-F2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQv-0000lw-Vh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:55 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso21247915e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739896012; x=1740500812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mperaQfcVOBqRRYRjHccBT2TwBZt0VUagowA4iRkLpA=;
 b=xd+xG20vd2eayFJ+youg2RjBW6E435A0yO4Owqzf7dLSkrGYVUPltNWIwTMp8zOyX7
 Mx2h2PfhS1G310h+tzwBOv0cA6+qZxyZBhg4IugyW8RxZ3hxlda6WRYoummZsj7H4x9j
 0lhKlhSPFiLIwrgcYmnIV94Z6MT59DpMTxc7DYTW9UgeSrHCXdAC/BymPvtPEO4UAhyi
 oeKiumEdFq7Q1sOaTzfSD0hw/lMR4QbhmNwAYvOO+GHt6RjbUmVZMcPu3mPjRSfJPx2M
 ERW1C9qBbWdX/bdST8JzYKPp+WBr2xRkzgp37KTxImntJq80DqeyiteOcdZlj8u6gE2f
 uhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896012; x=1740500812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mperaQfcVOBqRRYRjHccBT2TwBZt0VUagowA4iRkLpA=;
 b=daKdy1BPbxRbGJFct0lddVcY2M/fTUSLYxs27ih17A6TU8/zpz7/KcXsff+mmyRBGN
 A28C8mJigwWKbzpmh2a2OLntzfb7ubetDUgy1bQNuZNe4vAHzcIGG5o3ExAWptgUNa4H
 yhXgaCuPb2ZInHiw6dz/u69XoFx0hDK50Ye2EJc+eVM9jcOB/uEnuXB57D8O+az9TpiI
 cRODlPDQxndnPKNy/UKn2S/bPkGZGfSPpqnBpikk6ZAX2oTtICpP0j6EY/GfX4dGxrcs
 J1kR1eyTwyUxLLPWWxqi01tOXa5DUp/n/GtBbE6WbfpWveRenMJK6qPEtH6Jf1FGjiPC
 SIig==
X-Gm-Message-State: AOJu0YyBRBRZoIP4OaCy3Ac8TMh6f6v1u9CWov5Ev3JEqhrxhMfof9Vk
 npLXENDGsC3hlKeIskuuiQpInBBa+JJUBosMwLfrxsjI14MBUOr7+9FD6ZolAWeYXGirvSV+KUa
 Xmms=
X-Gm-Gg: ASbGncvodcdfdozjzV/v1vRIzq0YMx8jBm+JSHqsVYB4Q8n/WAwkWBcUHP9F3o9Amad
 tdqv3/VDXZyDa6DZFb/Zs+6y4wfBp/84renHw649QBfnDwX004/4ed9GRszyYlsDr4Flv1Bdtbs
 +VYIWdVmZ5KnytVRuJVI3GcqsoB1BQt9Pj3czKkNmdan87UFSqPZRKHwu0RnoLFWzDBfZHy3KHE
 kf6uWFUxuKlDvuN8GIoVIN6r5EiWAOa3yRAd2z32GjZZ6nAAfyKcMVVQUxfOM5Bjco6dpLlz6TI
 qO+f1JSep7+WkxXaCN6O4rWTzXuMc3uc3iAmxeYjy5C/pU4o/SqEpJp+Gf/Ffyh0Tw==
X-Google-Smtp-Source: AGHT+IF7J9TVuOyN/e8Zf762aLNRW9ueMObB9uugOr+4mEzA/SYgnf7ANAVSmsXQfhVb+gVyh0mcig==
X-Received: by 2002:a05:600c:511f:b0:439:43b1:e60 with SMTP id
 5b1f17b1804b1-4396e6df40amr143667775e9.17.1739896011980; 
 Tue, 18 Feb 2025 08:26:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43990f53847sm35280935e9.1.2025.02.18.08.26.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 6/8] hw/xen/xen-bus: Reduce included headers
Date: Tue, 18 Feb 2025 17:26:16 +0100
Message-ID: <20250218162618.46167-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Have "hw/xen/xen-bus" include the bare minimal set of headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-bus.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 2adb2af8391..bdbf1ed6fd0 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -8,9 +8,10 @@
 #ifndef HW_XEN_BUS_H
 #define HW_XEN_BUS_H
 
+#include "hw/qdev-core.h"
 #include "hw/xen/xen_backend_ops.h"
-#include "hw/sysbus.h"
 #include "qemu/notify.h"
+#include "qemu/queue.h"
 #include "qom/object.h"
 
 typedef struct XenEventChannel XenEventChannel;
-- 
2.47.1


