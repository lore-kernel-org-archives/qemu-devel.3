Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03534C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYk-0003J5-SR; Fri, 23 Aug 2024 02:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYj-0003BR-0s
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:14:05 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYg-0003Bq-Fd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:14:04 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-273cf9bbb3eso977683fac.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393641; x=1724998441;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TqGUJw12uTAbvh8M71+t9HGKJ1QBUKeYyyQ+O3KoOC0=;
 b=iq4lraWW0+JKVzVOGOjeFPScRb2883/QCyZJvhlo5c+6q+wDiJueZWzoKkgT2fklXG
 Z+3gQTUSnd6Hyqf5l+vWNWCX82rHDpjnperHnLnTsqpTS6/R8wH3p9UB+NOmk6QU6vXz
 JzDteJJ0ajK56vbR+gENxcxlG4P7xFWq9AHKFCHd17jaUXn7+ejRv8SUh4ScwfpYsO4B
 cBcBOvfUgHh0PN52R0v2uTHKayPWhUyCEZYSeO5nC0gfx2gh556F2Arx/c9+XVdhhzWo
 Z22OLiTLLlDRGbCQqwakXVgEDL7EP5Mk1X6qqYiFc0Y9VNcK3537dFFGtfN2WKRHk6x2
 PHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393641; x=1724998441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqGUJw12uTAbvh8M71+t9HGKJ1QBUKeYyyQ+O3KoOC0=;
 b=A4E5/VlNTA8ZTubCbTTpWteSu7cpdwen0ZewwCJlp5Wn5x5BsiyrV5yf2AH3kELa2U
 emUXDGNX5GL+FKuUR7eWegrhnEIUKtLdmp+rUkJ0bUmQOGsL1tEpGKCiriINbDFpCT3z
 0R/vDrocHqeqe9YcwYXt9DqUTwoCNWlBEQB1vKmiNlJL8SB7hhLxBcCRaU4OtNBmisc0
 p+iFBvWLJ4wbxA2rsfWEMfv8O1OaliOBVwTDprXCxYLDbgtQSrOU540nnhNY9p/DW6wM
 F7m6aRaj+4y8XY5kD5BWEmFLy/RYE7SDGmzGDp7LAeIPiB2E502GEplUvvrokFfxPTvQ
 wpng==
X-Gm-Message-State: AOJu0YwZNnyxmfsQgTGJmad1vyDW34+aXqOEHP5vzQ8o/sH/XjvUbajs
 b9Eeywo42KCS11x0GkJKEUmtaO5XIaiRWSKrAZJ4rdJu6c+NsYcuWsHYxfmV89c=
X-Google-Smtp-Source: AGHT+IHAfk6dVYsonq3Hlwrg808+TTvRceTk+pc5LzEGFXYQT7ovRTiKEte4g/HUA21ToYZjiMQeOQ==
X-Received: by 2002:a05:6870:5587:b0:270:129f:8e65 with SMTP id
 586e51a60fabf-273e66589c9mr1134333fac.34.1724393641047; 
 Thu, 22 Aug 2024 23:14:01 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71434335fe1sm2302862b3a.200.2024.08.22.23.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:14:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 15:13:11 +0900
Subject: [PATCH v4 6/7] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-san-v4-6-a24c6dfa4ceb@daynix.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
In-Reply-To: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
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
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

memory_region_update_container_subregions() used to call
memory_region_ref(), which creates a reference to the owner of the
subregion, on behalf of the owner of the container. This results in a
circular reference if the subregion and container have the same owner.

memory_region_ref() creates a reference to the owner instead of the
memory region to match the lifetime of the owner and memory region. We
do not need such a hack if the subregion and container have the same
owner because the owner will be alive as long as the container is.
Therefore, create a reference to the subregion itself instead ot its
owner in such a case; the reference to the subregion is still necessary
to ensure that the subregion gets finalized after the container.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 system/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 5e6eb459d5de..e4d3e9d1f427 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    object_ref(mr->owner == subregion->owner ?
+               OBJECT(subregion) : subregion->owner);
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2670,7 +2672,9 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+    object_unref(mr->owner == subregion->owner ?
+                 OBJECT(subregion) : subregion->owner);
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.46.0


