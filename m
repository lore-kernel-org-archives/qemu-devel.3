Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1E3C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8C-0002CB-Pv; Mon, 31 Mar 2025 15:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7w-00028y-J7
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7u-0003M0-QW
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso32449265e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450533; x=1744055333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/pv1g6SQzEtfRxwgUUw5mriOJrSVBq7ehEQgs2d4yE=;
 b=pLHJFmGR37+1Y59nMqRDDw25XUavmYoLjKm2jlcWVIyq0PIqe4Ze7lt0PVHCHtAqaj
 NfSvPDh8ET1wC+5fweAllBAqMJ7dVA8LcbKfBbTPcKhxM7LHO+ml7UJ03QWLc1p2eQWO
 nIu6nkBY4mgsRcp5BORco+mEsABWSM1kmctUw06+UD0o+B0ru7YZJcEXwXOsplc8+v7g
 CUgnIP9YD333Q3HqKzvK4etOqTDwBxtjQj0MLxYp0PVVzkszrU/kOaZa7/UqqzA3T0Rm
 iErYhM6jEmWn7vPHHX4dOvUhWHJNBDSITmVoaUYKx7D9ddsiyOUBSD+s5RkoJGdTBJX9
 mlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450533; x=1744055333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/pv1g6SQzEtfRxwgUUw5mriOJrSVBq7ehEQgs2d4yE=;
 b=VZnqoG8TYoHoaADjn51/yKDQKPOb99WuLrxX+P9P7W6yh+dI3PWwwgMbpBu6ltzyC/
 njuwHAnkRMT/zfySgVCAWARAEHBuUTCImYa9Xx3pyGyzPGzQ43eDk4NloUrNxjqWzkxd
 MiTmhTu6+hbv4xYT64USRWdJv8qTcauv7APToSQw4ExCyLAMIV91UAb/Oqd95k4CA+pV
 S/itsC1rYsBtx8ropmmE6iNHEKrWx1FgUuJI5aNCN4KbJlFSqXzTInA1LGClb96agNIU
 7tlLXKJaHO040CLMWmrn7WCV1b4OOnm2gi0jo5OvAU+Dprf3vplGZT6rlWn5Pq0kwFTI
 NGiA==
X-Gm-Message-State: AOJu0YySFjOWle+iUEb5lChCMqk3RRe5uc5Kh0kp80wAXO2mUI8j6CKg
 VIBbdgPiWLKmLV0x2obW1wEasZX8mf+JBRBmF6FdYm5BNZQoMS2DcrtzxMuy3RruomOrpE8Pbx3
 r
X-Gm-Gg: ASbGnctbGrUzDQ7p74K7onZ6lT6d4PErvEuLMh55E0cUIODl/xKeE+dp4eyYkDljrvn
 ttVSQ0h7tQOXR5AcZnmOu97Y70VyqgGUtc8biALtSIHPVjuDc4dVK5/bmok5X4ktnOwyLgVHYPg
 MWf/w9gwx+kSF7PGlylZiYbfBuimG9PTDu+n98jFCbdK5DX927pPZeswKF2WHbuMEF/GJ0J+NzM
 eFnWpIvMseCsG9dXsq5CBIZVaS0sY85IVK+7tPe3ZSP9ytZ9Zjl4O601UlYKiJUd06HG5JwcVba
 VE1P+dyafWaE2d4B/6AAdXokPi56JI9IUkmAivQ/+UxcPEJvJhFnw/bsdqsDFKgxKWJL6H8Fvv2
 XSGd2wvFTimcBXy2HO3I=
X-Google-Smtp-Source: AGHT+IF0YV3zr/3HgoIrqEAl30NN6fhBbaHxWHBhqEFYztdkpVyTCTnvk22W2ix5n72TBHEJmcpEEA==
X-Received: by 2002:a05:600c:4e4d:b0:43d:2230:303b with SMTP id
 5b1f17b1804b1-43db62b76b3mr80635945e9.20.1743450532811; 
 Mon, 31 Mar 2025 12:48:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90000a09sm130321915e9.35.2025.03.31.12.48.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/23] hw/block/m25p80: Categorize and add description
Date: Mon, 31 Mar 2025 21:48:04 +0200
Message-ID: <20250331194822.77309-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250325224310.8785-3-philmd@linaro.org>
---
 hw/block/m25p80.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b84c6afb327..0887c103e4f 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1870,7 +1870,9 @@ static void m25p80_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_m25p80;
     device_class_set_props(dc, m25p80_properties);
     device_class_set_legacy_reset(dc, m25p80_reset);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     mc->pi = data;
+    dc->desc = "Serial Flash";
 }
 
 static const TypeInfo m25p80_info = {
-- 
2.47.1


