Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81C2C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xvd-0000yU-MA; Wed, 16 Apr 2025 04:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvZ-0000x3-Qn; Wed, 16 Apr 2025 04:15:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvX-0005Zk-Iy; Wed, 16 Apr 2025 04:15:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2240b4de12bso88138295ad.2; 
 Wed, 16 Apr 2025 01:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791319; x=1745396119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9Qi7tBom5Vd967CqXnYUihx6jXTbGRTUe5KQdGWTvQ=;
 b=SpCz4HYtCDtuC1SavBywNdwZQ95HibTWo9QtU6WQWolPvxweFfnxX+ukJgUViR0R5c
 EQNZO1c4F0rirB45n+RWZbMF7jzB9iZCU8dDrWtLkpdf6BSG89Y0/4hRiyAegwxZOfzA
 EPFXwqR4Qe7z4clIqxI0ChPdk5k67pdtucikMMP/syfdL8tpeoBoZCt7sEwb5X9+7wbk
 fu7ljoQ8SfeMyxwjmpopcvGvnNylGCzKEm+9r1NiPnaoAjhTISpZlRiKAr0xPXWEjDRR
 8+1qCIPmqhQXmSurKJ6Fy5lsdYOQLDSVAslWkjmA0CHe6GpS0sf/BpiQcH0m03Dv24Vj
 D/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791319; x=1745396119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9Qi7tBom5Vd967CqXnYUihx6jXTbGRTUe5KQdGWTvQ=;
 b=lDUmYoTXci3Qf8+zLXN64pQzEAARlfnNcLqRpD36N2mmiwD2tdh9vH2lhO3SrTg/+r
 vJ4NI/psf8/TkQol3sdY0JPPjDIzghw1mzutt4gJVITAL3KhL1O3SaIDSyM8fTfc7+sa
 t2y3efKjkCixVjMbhlr+yc8SzVXUOu8WKDIBXo48GjfBC+QBj3yuTtDV5hNVjCCSbOmp
 ojuYwWk9PdEXIU6e3tFzfeYV7EdCFto8r7x4eJ3PsGs3W2GF0s3/UA607K0534tCRLsY
 qCYcKAkQ6iFuVqGOIcgxqK0aiVgNB/8ZSlOxQ7DYMMKM6JdbW0+I5J1G4aOwOWi5t1VH
 0tHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKo+SntgSY3gPgd9sugpEoiaPvUVwsmSBv80cxDU2MyTULPeBq0AcBejiT2I1+3f9vQLbDke0BUUyCuQ==@nongnu.org,
 AJvYcCVbvRrfdb3C8nRuLp3Reg/IRQtNj/Kg2MxTbbaVXVzaXGeQ+GMemmZ15+iNBGDXdw3hD8g2ch1c2Go=@nongnu.org,
 AJvYcCW4gy+INKNKDQPMvi+we2EJAkTeXX7jPw3u/H6JCt0cmK3b6dT2y7PHjWLqIDUpVux00ak8Z19ih+sWDg==@nongnu.org,
 AJvYcCW7jZw4p9mwOxuu32nyUapzuwYaG7zP0q4E0dJQ+mC9eAi7x81TzLHyqsHaMu+HkbeWbov5+cFBrw==@nongnu.org
X-Gm-Message-State: AOJu0YyvI01pGya/+G+1KHQW2EypucGWUft3a8zEpZE9ehcHyPSVAtqY
 8mpE45scWW2aOUmWoQwrc4yKCjrr/lVQNT6ghYu/EsAScT6SCLCRwHuqsjh/
X-Gm-Gg: ASbGncuYec8mjsP1Su4aVkE4aB4ZAOH5OhLT0In3wFfD1XtBOjEBmOpl/t/mQaNCafA
 MxrnJ3w3Sc2lDvmu8LqQ5BGqYmXLb9DVYzD18Vs6Ez/lRH2P/KhqW7Vk+6rIL2vceDnbsi/6AWG
 nvYA0p1WWGmZD/c+ZE/e2pkFk4g6lkaC5ELUulpy8+IOUFkVrB9Q0fWhyjCJVvwYOcAqHAsilRm
 +Duij4ntdAjfa+EphqywDUocsCcOwoBKwgDy4n8VNGUunfa6fTRjXNixwwXRFLlonWXnIwiROUo
 q2SrhhfQ45VCtrqdN491C6c5KijQj1LTKI8EL6WDTE7OOqeHymkVC3qG2w==
X-Google-Smtp-Source: AGHT+IHs7Zf9k0205llWie78fgPTs0fh8TUGkAJGR/jHsaTgOeEs1xBeZHSl7kCo5gtKYgBFUS5wTA==
X-Received: by 2002:a17:903:2302:b0:220:c86d:d7eb with SMTP id
 d9443c01a7336-22c3597f330mr13078545ad.36.1744791318942; 
 Wed, 16 Apr 2025 01:15:18 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:15:18 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 02/19] qom/object.c: Fix type conflict of GLib function
 pointers
Date: Wed, 16 Apr 2025 17:14:07 +0900
Message-Id: <9774bf5ed472be69d5a1e4cd7bbb34184ab0a202.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62b.google.com
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call using g_slist_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 qom/object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 01618d06bd..87f84bac41 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1191,7 +1191,7 @@ GSList *object_class_get_list(const char *implements_type,
     return list;
 }
 
-static gint object_class_cmp(gconstpointer a, gconstpointer b)
+static gint object_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     return strcasecmp(object_class_get_name((ObjectClass *)a),
                       object_class_get_name((ObjectClass *)b));
@@ -1200,8 +1200,9 @@ static gint object_class_cmp(gconstpointer a, gconstpointer b)
 GSList *object_class_get_list_sorted(const char *implements_type,
                                      bool include_abstract)
 {
-    return g_slist_sort(object_class_get_list(implements_type, include_abstract),
-                        object_class_cmp);
+    return g_slist_sort_with_data(
+        object_class_get_list(implements_type, include_abstract),
+        object_class_cmp, NULL);
 }
 
 Object *object_ref(void *objptr)
-- 
2.25.1


