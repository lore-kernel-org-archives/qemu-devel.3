Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBF8C282C5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhIZ-0007GG-ER; Thu, 27 Feb 2025 12:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGY-0005DM-Hy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:43 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGR-0002Kz-5W
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:42 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390dd3654aeso712232f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740675681; x=1741280481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3eBHAjIfoWoER90J1BI6uWWgCZy3qo5qcX1iHAUzyn4=;
 b=pTx650BF88pwURSNtkaW9ihptXo2Zxguy/0qRG3lsf5ZoHtHQh/PTztp0muL/tFNUd
 pdHUXsfZxxjyWQzSbsCwImzn4VW6Gf15rxIX9v3ZOORI/S0FQ1j1RGmTJMyAJA2vv3wx
 G55ffpEIxi23hjgwi/GpGKfAzss5W8J9AybjfvstgHi8GsFUaE7oOdlgW9636Fb013jR
 GLHhd78v7Q84CJDbwijkSr3p7QVjkiQGCAUvegDxFnDvDZjJWAucX3n82hExy+GrD9cD
 DjDcPKAUOmeD1VO1kveyKPQ2p6N1Xa5/DXNPV0of3Ruu9I2SyaP439s0Wi6c59Co89QK
 Um/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675681; x=1741280481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3eBHAjIfoWoER90J1BI6uWWgCZy3qo5qcX1iHAUzyn4=;
 b=ug4Iv8ytNd8SYqRKLKxqmAWKF/C08ga1F6tCrBkWwFBy4RRP0pk0Egl9v5jrFLQSGg
 4mbI2jKKecZuqNpzRnRzQvzIRZyBEDIVxCnGjZGQ45ZplTJ8Z9/vPVh1eJUOVVyKmT5D
 xbubYl7JUpIYSgboaGf0CPj90wDAl/axwwafyewGDAzBMbGuXlbhBQYQII4HHqybra3J
 dZ/R8NH1P9pPJaFByfR1ksP1pI3bjVwsEnNDZB0+Pm0MbOdNwdO/MnjJ+v+yYMKtcdvR
 5weFxB+Eh4Iri+uGkJtUeHnNKaj8coDRCAqalxnAxrAStbxi4yPwnbeSkbgMiEn7YvNS
 54Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFF7PJVmZT1Vpqohymf3DY6wTC5fetaXdN9ws/Lp6+J6HNjf78ScEEeWeem07nMhzE2fnvWDVwdvx/@nongnu.org
X-Gm-Message-State: AOJu0Yw2DpiCSk/UXmuQMxKJsKE4i8o8lgAml2xJmaprjBpEoISaebpV
 qfjaldIJEDH4/EufF+h9yrUUgvrUi07Ub+o4IpqEpS/4V/tV9zKzWQX6ia63/gk=
X-Gm-Gg: ASbGnctI4pHByXCY2Jilyb/sVuGm86Edvf0EtG0c2sb9e5Xf+W6uXgbcLqZJvfXoWCZ
 gTqs5TeHu8y5o20Z9APp8IHmlLoLt6u2p1mCafeyGgFvvuRFcu/CENV8RI9OmSsGo6fLnDGAimJ
 QAzsh9L4K/vNQojrwZxbEFsHzbwhsoE6eQ/P/0yTWBWKr7HbyaTD6ibmnGpjCU0qiFb8RjG3PGl
 lnABV4P3oabMfzQAZ8EZBrgEz6EV9BCGPspf3GFvATsl8EH6vfvJlT0o/UpzZ8WA2Pb4qUBpdWH
 rvlRaEy4oISRAf+AYlukKkH+Wr53zI3U
X-Google-Smtp-Source: AGHT+IHmbdKSPGNUse22QHlr/5LddtNWwvVvq6sG0IRUK0BywK0VgXUCXYpLndHD17mmcqfouFsHMw==
X-Received: by 2002:a05:6000:1545:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-390cc63cd3amr10386207f8f.49.1740675680565; 
 Thu, 27 Feb 2025 09:01:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5871f4sm62747565e9.39.2025.02.27.09.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:01:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/arm: Remove printf() calls
Date: Thu, 27 Feb 2025 17:01:12 +0000
Message-ID: <20250227170117.1726895-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

I noticed while looking at the sx1 functional tests that
the omap1 device emulation code prints to stdout
"omap_clkm_write: clocking scheme set to synchronous scalable"
which the test dutifully captures to its default.log.

Printing this kind of debug or information message to stdout
is definitely not something we do any more; so seeing it
prompted me to clean this up for hw/arm:
 * printf()s for guest errors or unimplemented functionality
   should be qemu_log_mask()
 * printf()s for minor informational things should be
   tracepoints
 * printf() for debug that have been ifdeffed out forever
   could in theory be tracepoints, but I didn't feel it
   worth the effort of conversion in this case: I doubt that
   anybody will be trying to debug this code or that the
   specific handful of debug ifdefs would be what they'll want
   anyway. If anybody ever does need to do debug here, they can
   add the tracepoints that are actually useful to them.

thanks
-- PMM

Peter Maydell (5):
  hw/arm/omap1: Convert raw printfs to qemu_log_mask()
  hw/arm/omap1: Drop ALMDEBUG ifdeffed out code
  hw/arm/omap1: Convert information printfs to tracepoints
  hw/arm/omap_sx1.c: Remove ifdeffed out debug printf
  hw/arm/versatilepb: Convert printfs to LOG_GUEST_ERROR

 hw/arm/omap1.c       | 126 ++++++++++++++++---------------------------
 hw/arm/omap_sx1.c    |   4 --
 hw/arm/versatilepb.c |   7 ++-
 hw/arm/trace-events  |   7 +++
 4 files changed, 57 insertions(+), 87 deletions(-)

-- 
2.43.0


