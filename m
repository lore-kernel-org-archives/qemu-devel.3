Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7129EC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpLG-0001Zc-GH; Thu, 27 Jun 2024 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLC-0001VV-7S
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpL9-0006Uz-H0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1faad409ca7so4181175ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495545; x=1720100345;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6MgmHQG/2ylhpi7rbXo5VyylZZdoY/6uUXCCV6pKunI=;
 b=3YEktQY4Cf9mZ6ojcJDmxaq+/SRt+RI0N6N1Vsn4KC9bV+AObK7oZWXsZoPohCBynS
 B474C4l4Gm4uFKO8qjb941adW3fuD4TNFGUq4BKrO3mMwtO8TPIBuQs2k87RpeWes9c/
 HNRmpoL3bEec3/Q0D8EkADytvqC646u2UQ9nyzDKqxMlC71sZ9Q9iJyDwAxscxpnjLSA
 wqh+94UWPrOBNfS+492EmEtqWrgu0QVN2snPVx8dGFC/MwJZdmLZTRStjMnLO+dhTmCB
 R3+ZAd0s8QuBZbyh9F1b6ykYQ4uxwAi2/SHmKE5IX86qYGm9kGJaHddVeoe8q/c/hl9W
 YqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495545; x=1720100345;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6MgmHQG/2ylhpi7rbXo5VyylZZdoY/6uUXCCV6pKunI=;
 b=a7cibJZBiq30t8nrzDYf2jgftOT4amw00UOHNiTKHDOTXMMSNClrIH9QOSq8v59FcP
 pHX7m/S4NQecHWu+Zu9kDgxL9mQDD7WmPsFSV4q/JkBxVZxZyJdW0HNri7CT+mb+X2qA
 qIuSCkF1UuHaLOstzh3wnCMq2VYU14SQ8GC/6VfQb+wXqJxWue2a0Wa5vs4k7TRJsEbT
 6G4B8VigR5rczWt1Sn+mhrkN1YWQrFqzVNObLQIkZLiEsLZWjNZ4jCmWSgiPmEcIfG39
 M39xYNBhBUOmdqy+O3f75Hh0JXOJQ+S82QcSJCR39WjWl2zmhsQomLWcRIcwjIrqVXDx
 CNzw==
X-Gm-Message-State: AOJu0Ywh96dCoBP8gXXM1/nxCP2NrqTW36JCIBIC/vbjE6bH+AakFSz1
 Bt5aOPl7pQUAxAByKLNcNdJwkFbNfizJfE2W0g1SXgKGIbmQzmyBDCn+NlYcSr8=
X-Google-Smtp-Source: AGHT+IEOQ/m6W0EaVrS87L9pcyV7z7eXSKdvdlz5a1XfK+ZrnOVnl6VAIXcrZ4tj5pOxawKYTrGRaA==
X-Received: by 2002:a17:903:228a:b0:1f6:dccd:c6db with SMTP id
 d9443c01a7336-1faac2df4b0mr24948755ad.30.1719495545496; 
 Thu, 27 Jun 2024 06:39:05 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac9791fdsm13201035ad.127.2024.06.27.06.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:39:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:52 +0900
Subject: [PATCH v2 09/15] memory: Do not create circular reference with
 subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-9-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

A memory region does not use their own reference counters, but instead
piggybacks on another QOM object, "owner" (unless the owner is not the
memory region itself). When creating a subregion, a new reference to the
owner of the container must be created. However, if the subregion is
owned by the same QOM object, this result in a self-reference, and make
the owner immortal. Avoid such a self-reference.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 system/memory.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 74cd73ebc78b..949f5016a68d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2638,7 +2638,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    if (mr->owner != subregion->owner) {
+        memory_region_ref(subregion);
+    }
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2696,7 +2699,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+
+    if (mr->owner != subregion->owner) {
+        memory_region_unref(subregion);
+    }
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.45.2


