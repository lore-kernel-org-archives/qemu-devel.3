Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A502CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ij9-0000r8-Kb; Fri, 17 Oct 2025 07:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9ij4-0000ma-4t
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9iim-000615-Ri
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so5544465e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760700842; x=1761305642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqDslS9NKjHnUWYR3Oq3CSi9/FfiBOz9NHEnZxcZS80=;
 b=VQjIvxksVCWyo9LY+yz9ntgiSFcEST6QShBcpc62Bs844BaxkagGc3tn+6uhDKMyq8
 2/j6GXaBNAK7aZGqHK9Ufro++q4fDv7c8SV8tODKOLC/3AwS7IWq3QO3d0ijCUP+AZ2/
 JgUCChxN7GHaQQcUgn0JR8J69ddGLcWv8QtgWrQ4e+gH/p0A6A453MnhSnzFAnZ/OxbE
 fxgZYkfNzHZpWBd/z4N/BMtHE3Ur5+6juSSGP3WQeP3Mh/Pf4rEC9Vr/74+gXSJDKla9
 QQEGt63QJmYT71+jvSAuHGsWNl4EIf3KA1/mC+R58l9EY0fiziKv7CLWolFpMtYdzhE1
 uFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760700842; x=1761305642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqDslS9NKjHnUWYR3Oq3CSi9/FfiBOz9NHEnZxcZS80=;
 b=HgXZmJl/SofwY4GGmJnCvxzEfNRNtPURZMjx7fXVL2XDrev3nlFh67cE7XcTh9TQOQ
 miobVC0HD8nBtbyNnvmpxwYjN6oaKPiVDuR2RaXXNOIj6F+Ddr59peyyxWdGgzMZgLPB
 INPpggr8th2gsBN/SCa7PCGnG50OB4prCzM22+dduZO42Ha2Fxn9ZCOUmY3dCE0U1NXc
 exYeMTe6RdjMbIrTlQjC5Et+Lrcw21pSvptDgHX5y/uOshUA0fp98nZ6a6rfujEe53VM
 d3iB0BTbax1n12wN714v0WcEgMRPl0hm3n89kMWTN9yMvaedddf58CN0xTR2klDxUGM5
 saIA==
X-Gm-Message-State: AOJu0YxXoDnXadA2RjUhqcj/0IKOat7ymjKEutDWemAvTnk2vk+gM/6B
 0erZl7Rb2ka1c9162XqcGGcnbfvmXdw5Qt6LgMO56xa+KMVbG6xaoH23ljRNAg==
X-Gm-Gg: ASbGncuAlFQe1sSOGZchDboowEie5GUwNAHpon0MVuVjvGSM9M0x6bUAg+6kDKpJPEY
 C3NP0s/SKEDwL7/+G9YLliiapm8FiNnB14P/7iYzoJPQERwWENZUEYVEgKPDJ568XQ+v7MhjS/w
 wNqwTrRsYgAoGBJp+AV6sZ79cDM/iC9h+Ib6QH1ooXb6KqRVIWiZvg7HzPxVa7CS829hESngyYX
 UMYKYlMaQM6311ksAreAuL4n7wmvZmMK0DNXztdK7K894aKlFdxpqmNfzUjx4gm2xZhQ3ur6BKK
 N8ZCtZG+6b+qtnFnsJBIFYYeHfef9taNWqEVagb3LTX5FdWfLHxHv/Mpw4Ov4eGJcoR1q/E70w9
 KteSNAqFjnQtQnvIhYzkGmsV0dh5/HycJ4lEgFVyubYSJCfZrvDZG60EN3WWCHGQd0qpscSlR5o
 It66feIT2cfMxcJLwjCcwwfS7AbsJs6lcilq7pbnw3BPg=
X-Google-Smtp-Source: AGHT+IGrPw3UQyxZPdqjtHKNkflxp1U5RB7MM83GtBJGNyQZGFtG1sySZZLtOmG38BC7IEhw+bsWbg==
X-Received: by 2002:a05:600c:820b:b0:46e:27fb:17f0 with SMTP id
 5b1f17b1804b1-47117877244mr24190025e9.9.1760700842351; 
 Fri, 17 Oct 2025 04:34:02 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711444c8adsm80395435e9.13.2025.10.17.04.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:34:01 -0700 (PDT)
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
Subject: [PATCH 5/8] hw/rtc/mc146818rtc: Assert correct usage of
 mc146818rtc_set_cmos_data()
Date: Fri, 17 Oct 2025 13:33:35 +0200
Message-ID: <20251017113338.7953-6-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017113338.7953-1-shentey@gmail.com>
References: <20251017113338.7953-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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

The offset is never controlled by the guest, so any misuse constitutes a
programming error and shouldn't be silently ignored. Fix this by using assert().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/mc146818rtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 5a89062b4c..8631386b9f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -726,9 +726,8 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
 
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val)
 {
-    if (addr >= 0 && addr < ARRAY_SIZE(s->cmos_data)) {
-        s->cmos_data[addr] = val;
-    }
+    assert(addr >= 0 && addr < ARRAY_SIZE(s->cmos_data));
+    s->cmos_data[addr] = val;
 }
 
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr)
-- 
2.51.1.dirty


