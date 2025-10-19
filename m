Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B85CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaZ1-0007Pi-E6; Sun, 19 Oct 2025 17:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYy-0007Nw-Pk
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:37 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYx-00020u-4Q
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:36 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63bf76fc9faso6786556a12.2
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907813; x=1761512613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtQk0GJuCq/JgD3T73Q/ujEtbCnLstw5lfgjKUjPFqo=;
 b=aAA8+gX6R/9tKpIDsefUJKgfN1QjO3XBKsLwlPBIrV+92Pc6eRjs8xdErmJo5mHgYM
 xMko4V2v+A4zOZEbYU29bZLHPqXWTgogreSxDcjEvu7M5MzaGWCwd8hghr8xPA76bvd/
 Jj6EOKPWxM2mtpUELd504kMLw+wTk/BPl0DMeBbWRCGAWKP/IAP2w7c5VMOYUlyykiXD
 7Nw5zyYiCa0yY1902MwnxF7fJcA6in1GOr908PJbgqUNurYd4C5xShHheT0MwLbGLYVs
 iDScGqanfQ0AFw8MKXpFBdro4p1ijHywl6U8ty4D6doLK3L40vEylMC6jEvUytqQlGN1
 jMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907813; x=1761512613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtQk0GJuCq/JgD3T73Q/ujEtbCnLstw5lfgjKUjPFqo=;
 b=MRMT4Dwvsv0uMIib8LIzeYL+jfjJTOftjR62jW+fb+YFIZc1Z1+0eEsj/27ydiPsbd
 dBP2DaE/phPpYZBysBP9/UQTxYJBrYA8fNye/fiaI6kjFpQhCGXgzxV/7TxCQWf8xuTs
 +EZK2EBWY6zOHajSrifuye435rRb+ljzrL/yH5uRSoUykhQps9mhLiX++QqovjKLwFx4
 0+QNzJ2WFUA7jEmyN4FxP3XlSaziaV/Ec08WER0f1i8PiikF85KDpiezOVeg8FTewOmY
 f+dRsbg8xvSfu82W4hzelEYy/CfYw2d+lasjZgx5SQAuvCsAb+3CZP1CJek0WG3rTyIe
 lkQQ==
X-Gm-Message-State: AOJu0Yy0O0ykFOE0xTc1QYU9JRA2+acaPayYcwhPyMw80eODRDmhd6K1
 IYxGauZEtFQR7c6AAnRJT6lp37oWRDthzTM0CKt/GuK4/mV3KClX69MSke/rJAWO
X-Gm-Gg: ASbGncva+0xzUoUKIuGYVd7I/iMOwqYTvNMmpGCOOV7KyA0HU541MGYwbDeGv7lTlyB
 rVLkRG7LraogLJOMFHgGO1Cs++oQekSnOH165BxmhU9KABRtcz4Bu23h6MsJdLtDltIVEvypYtf
 hwqAckryPiEyuw6uz2SF7torXej3ByTUHLs4aSNlMMlkVcS/7x1o+dEr6CFp2RTmZPH/K1Ts1KK
 FlbWPWJA3gdbFKRxXfHO/57j2c55NHY/fZKkLvdRp8unNJSCjvaQxcAQO4O7bVDHRT6kc2xOwzx
 0E5QCqmx6XASNM1mZosBFV8BBh6cJtXtny4rDl7bIT7HJsWsjS2Bp4elKeDkqPRNLaVIOZ/tQQL
 UTyjeVa+ZeDsHUbh8fxqDlkHAlZsH01mPDIWH/X793rNuOYEHiymk9shA3hLTJYkx1xvn8B4U13
 rf/jqsknRdghGp4UV3p7tWAJYhC4rliXqLKYzd8+MtVnUfvfbXDqeH668ut4UCiRtXMHyl
X-Google-Smtp-Source: AGHT+IHY1dRS1/AWHrm1rZJe4vZW5z0gZL042o9tHw8kn9F5IjQFgcfvzYbj4kRdNYLhXWOzFUb3tQ==
X-Received: by 2002:a05:6402:5189:b0:63c:3efe:d970 with SMTP id
 4fb4d7f45d1cf-63c3efeee6emr6840546a12.31.1760907813103; 
 Sun, 19 Oct 2025 14:03:33 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:32 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 04/10] hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
Date: Sun, 19 Oct 2025 23:02:57 +0200
Message-ID: <20251019210303.104718-5-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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


