Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EB5C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 12:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0lq-0003Wm-3w; Thu, 06 Feb 2025 07:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0lh-0003TU-2Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:06 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0lb-0004Ts-M1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:04 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5dcdfa7df68so1502046a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 04:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738844037; x=1739448837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZB8DoT72mipnLBEFwjr7x6yqc4w1T76dTeiV9+kci8=;
 b=B+LJsHAbxurfWm0sYYF84IBephDb1eQKDEz5MGLXfrbqvZgjueNKEtxWysMiETSXOC
 5anLrnqCe0k2lUNBgJhju+OGOL3GNvSDkHbaOuFExZj+iEHZnJpmlHGBYsIVCM+vrphM
 L5c/l65Vh7QTA07SLSV13kYCoE2eqB+lQK2EkWfoddd7UoudPC81wQQ6ySItq7FSAZNt
 3QybtH5MEkHXKCBCLEZTfURMLP4LCc0LDd/bQi5YIjh9RP3MJhzJC7jgSmPltqyMrXz3
 hodq/DZgB28Aw69psI3KjopNTDmBvRrMbttal84BFSH9RU+TAFGOO1Kcauohot5qjuh9
 1IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738844037; x=1739448837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZB8DoT72mipnLBEFwjr7x6yqc4w1T76dTeiV9+kci8=;
 b=GrWBx6XLNev5ZRxY36tzUdg22QURlcd1PVl9D9xMNuqpgkzNfrVC3pEq0+c1uqptuH
 mX9hbwyb6TjBP+U3Rym9D+BwLAGp2/NiKYbL8BR4ZSwZwCYmTq+lwPh8AO+sE94NAqBA
 nO4PHX6xbKecW5c+Ss278h2WGuZglx95T4297UH2JvHKQ3a/BvKATwzR7bGSWY/ka2X5
 mOH/Aj7RFv3KixEzCiRzJXnBukZsWDtvJtFUVF2CSSPB1D1qCafPJ2ZOAri+yMXBUfta
 oJZyBOHAzM8rZFxMCEeFzYWI/3vEuuXnBVaS2jmI3p/LVWWfK0akl2U99MJRWKxVLZOL
 DWIw==
X-Gm-Message-State: AOJu0YyI5sjbkOZqElb8BN0EGU2t0AX9rn++fDdxFcaigPJfEGES2iYh
 EauJ/cGI7Q49CJDAYqkHnrQwx1ue/lQMSj9i/VrORi80j14wh3sKeLzJ36WCscc=
X-Gm-Gg: ASbGncun43fds1jsS575WIMYRjSU3nWoVTNPIMsnC6Y+revfrv+Cf7W5yOyljkpjHiR
 Zf3+ZGgogXYMdFyQqSg3VcXKtRjkrSIZI73WIEwfNwGzjMyFHSAUKnMarKKRFfukl/1kPGHYPCQ
 mrhzkqAl+rx3Q7P5yBk8QPBH0Dz9zP1DbOjALm3e+nKlEDlasH5gRx4Vn5ic667Y15trqkyCnKw
 PtUmWm9dVVPuND9/Pch7sGYOOTtysIotOmdybDo6RjMDkXrkxRqqR7oa2TzOsQvMq5oO7u+BKMU
 RzM4KYtxUKjqktUmv+hYz9ULj5ib2lxLYqlhCpyPl+g=
X-Google-Smtp-Source: AGHT+IFsXBKymWSSgR852oOJKW0WjA4ohwVmbY5eKUpVFRa37x7wxMBIwBafIZlaIInssfKvwP08Xg==
X-Received: by 2002:a05:6402:388c:b0:5d9:8877:895a with SMTP id
 4fb4d7f45d1cf-5dcdb732cd0mr7859755a12.17.1738844036502; 
 Thu, 06 Feb 2025 04:13:56 -0800 (PST)
Received: from corvink-nb.tail0f5ff.ts.net ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7ade9sm772388a12.25.2025.02.06.04.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 04:13:56 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 2/4] scripts/update-linux-headers: include PCI ID header for
 Intel GPUs
Date: Thu,  6 Feb 2025 13:13:38 +0100
Message-ID: <20250206121341.118337-3-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206121341.118337-1-corvin.koehne@gmail.com>
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x531.google.com
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

From: Corvin Köhne <c.koehne@beckhoff.com>

We've recently imported the PCI ID header for Intel GPUs into our tree.
Add it to our helper script to make it easier for us to sync this file
in the future.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 scripts/update-linux-headers.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8913e4fb99..a4ff5a8fe9 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -269,6 +269,12 @@ mkdir -p "$output/include/standard-headers/drm"
 cp_portable "$hdrdir/include/drm/drm_fourcc.h" \
             "$output/include/standard-headers/drm"
 
+# Linux does not install the PCI IDs header for i915 devices, so we have to
+# pick it up from the source tree itself.
+mkdir -p "$output/include/standard-headers/drm/intel"
+cp_portable "$linux/include/drm/intel/pciids.h" \
+            "$output/include/standard-headers/drm/intel"
+
 cat <<EOF >$output/include/standard-headers/linux/types.h
 /* For QEMU all types are already defined via osdep.h, so this
  * header does not need to do anything.
-- 
2.48.1


