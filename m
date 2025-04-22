Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E953C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76BA-0001FJ-6a; Tue, 22 Apr 2025 01:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76B6-0001Ed-Pq; Tue, 22 Apr 2025 01:28:17 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76B5-0007n8-3f; Tue, 22 Apr 2025 01:28:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fb0f619dso52997455ad.1; 
 Mon, 21 Apr 2025 22:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299691; x=1745904491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NQ7+0cp0B4BZ+F+1DEhH1LfKFVn/DFHA6zpy9bi3Vg=;
 b=OKGZb1tGCjl1neV+k4kKlNonOETqQ118aBaIpxqd4qPo682z6vOFsRpzigwPnfTByP
 r3w97z2gKIA1J7D7Hyl0w5Dcsw6FGxPWIedu4/KK+LG8YaZadu8g98iDS3hYTYI8o9eF
 crPFU4OPKPPzCfNFbgiAVKZJoFu6eRlTenXAyP7KkT07qzQXUy+7NJkSNcB64NKjuTPw
 r/8s/troXnlhgoaqdNy8ZabTnnmnnALH2BRkmsF2jOu/DTFg1BmNiVhSz17OMMLFw9lm
 ZCV63p8iYW6y0U6ZTdBeFoBt9S60yH8CkqcnLtwZRbxxxyZgqANdiU3g9MT31nxWMIxU
 IKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299691; x=1745904491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NQ7+0cp0B4BZ+F+1DEhH1LfKFVn/DFHA6zpy9bi3Vg=;
 b=MzO6jtgGnTscYRqb0OOO2s8FHUt6v+FZ7TnyeZ/3+msm5ifdDqx1jYzNPaUc3+vEGH
 boka7uqyivYSEAY1vT+lS4+CkJmKQWwePncZCbNRHmObm7+MyLBNCTFv4Vu8EJb0XzaZ
 LT9i5yKyJQYdhvLF5dGN5CQxYWFX/ev/z1krdWZE+ssnCxW6+5Q1jKE1Zk24crG8GW7H
 /vCNSz/nZK/xQVjaRtXkW8+AsdxKZju/Iz6fE4ltiEMtGwkB8h5oDwl1j1k+hkV8/FxR
 8Y66hEtJRMqKd7iygQouL3iiEYcJ05mfuHOvCp/sYkIIwE549v1tXMmD38fPS6WHg8A7
 T5cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4RF8pBp1JZb5mDFpQ1j0GcfiKoDhrf6XeLW4CEI2z3p/5CkwypDQr79TLpV9aGP8TXKR0b/W6cg==@nongnu.org,
 AJvYcCU5GtzUSubiR/JdGsGBj6t7zGbC4KaAhF3r313ihXAGLdVJL1BwaYDIiK9zjd2QBH7MydKaaS22KXNR0w==@nongnu.org,
 AJvYcCUDYG+81o/3WruZzjZaDl7zvmDiz3QM9TmTzWFq2fQgXL6k9BDH/CyCYcgkWk8uvtTqr7DQv9UljNY=@nongnu.org,
 AJvYcCUUljhEHIWBOwSxM/csCtbgY029ccj7f8aCWWCiP2Oozs2HQC9EEmImMkbqr7jucsb5teBJMewcD5e6tQ==@nongnu.org
X-Gm-Message-State: AOJu0YxwgMeZkGA3tfaQWME8ARJMDh6dLriyO/E7qym47R89xPErOCwX
 sWDZP7JETuQMWj7/rwXJ70KOIJJ5k3SxBZYLnBM8Kk5FLev83BIOvNgQeHs9
X-Gm-Gg: ASbGncsVkqt/r+OD9LVm3PHNQcnHO6yVNnYie4LZkVybBc/JvDY53WAP2WPJzM7/rhG
 U25ruZVfM4TjPCVJqteXzqZfYDImTwddMyP4HfdBd9sNHniBmYLumuu5x0g5H/IQONz9zyeiS+B
 eh090vBgWSyQHKj2mR3NwWqs5/PSJLmzuzWITHIMpStDFlK6l9QwSsTzu050PvvvWF+nS/Wp4G5
 9bSI+uOe8lzhxDdzvTpyH+fRHWR1U8njo2ypMudPwDblwHYaPvryw2mA/efhDw1zK2hrlYgS9RE
 kJsgH9F3w/4OEt/dugvjMhuoCHZ7WRHMgjkPEXq5QnaqHxyeAo8ThXOtmDE=
X-Google-Smtp-Source: AGHT+IFQZuSA5UEEZIfqmUdfgADL4wO5YWoqm3vdhDf1L+aFr2jGRlrpu12P1/0vzKEaAX8X39f6sA==
X-Received: by 2002:a17:902:d4c2:b0:224:de2:7fd0 with SMTP id
 d9443c01a7336-22c535b2b3bmr201215225ad.25.1745299691273; 
 Mon, 21 Apr 2025 22:28:11 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:10 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 01/20] hw/core/loader.c: Fix type conflict of GLib function
 pointers
Date: Tue, 22 Apr 2025 14:27:05 +0900
Message-Id: <26dfe9191154ca65dca6ef51ce768ad2a0c30d5f.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x632.google.com
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

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 hw/core/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2e35f0aa90..93a8b45d28 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1410,7 +1410,7 @@ typedef struct RomSec {
  * work, but this way saves a little work later by avoiding
  * dealing with "gaps" of 0 length.
  */
-static gint sort_secs(gconstpointer a, gconstpointer b)
+static gint sort_secs(gconstpointer a, gconstpointer b, gpointer d)
 {
     RomSec *ra = (RomSec *) a;
     RomSec *rb = (RomSec *) b;
@@ -1463,7 +1463,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
     /* sentinel */
     secs = add_romsec_to_list(secs, base + size, 1);
 
-    secs = g_list_sort(secs, sort_secs);
+    secs = g_list_sort_with_data(secs, sort_secs, NULL);
 
     for (it = g_list_first(secs); it; it = g_list_next(it)) {
         cand = (RomSec *) it->data;
-- 
2.25.1


