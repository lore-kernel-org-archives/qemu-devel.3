Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F836E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyfj-0000oF-9H; Sat, 04 Jan 2025 02:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyfY-0000jo-7L
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:34:03 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyfW-0004YA-Qb
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:34:00 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso16280143a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976036; x=1736580836;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FmQmqRoZoVpBuUWMsWoA3ZXBC95hvdxu9mQlkpJR1U4=;
 b=UqnDMiIohno1vbBDtn2K4bU3aLasCoWSBAnNZEnQfsEYmN1qyJUftti7gJt57gDGry
 aL5CsIeOPJMVHcE9w2nHsKPqbe0hct3kAmYIYIj0N2X+W5qFnM8gmkKPOkOSUyflOig8
 Svz5RU69UQ6NYfdCzbh/ucUakJX0gbyYgki/zUZOlkePn/Vd86+27c+r4l1NA8iJoTMz
 4RDgnBVMwb0MJSQb9ROnUyo/oswwLMJolJk8hygqyI9OyYvIXCEmaCLuIrDaeWYgZ7iE
 IBr+aqouXlC0s8uKdILleMXR2IlO0x5Ah9LLEE2Mge/i+KBPFULEy1QjzDePL1Mxz3kL
 RFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976036; x=1736580836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmQmqRoZoVpBuUWMsWoA3ZXBC95hvdxu9mQlkpJR1U4=;
 b=C7Q6SbDUwnz7JbHa3GOUqKnL3MZ5JAnypq4uNLo9SZaKayMe16nP5ug84kW3+AffOO
 vcr5ZU2MPhgg1zkBFlPIRro4E8IXCHFUWR9PPAKBXON1ZLYx3I/6xQE076POmCmU1ihU
 Ek1GQvB66Y5C81d/8UiTcOUVPsoRHiuWJ4DoRLaQWL35ycUvRVwpO0upAinOOLQengZ/
 i3ZFv+JFlovc8wUfvR7ybg2v2Y68D8PCA3L4RYueeFKFLLLYqO0Tmqznf0hHIuvBc0Fn
 FPTcpH7OK3Cr1K4WdhwEB06Uu6DoAyTdvuKur/8YImTcWAIrkgwTkDiki6pxXs5hCSZg
 kfoQ==
X-Gm-Message-State: AOJu0YwygHatRLkUMMBIsfmTVptuDRLKBny4P+GsmR9JK1iGExk/6Dqu
 UixxyMcNVXoDZSaO2Q/moOSplXKIdMOHXSnG2dJjNSxvciLm2peH7SskfThBzQY=
X-Gm-Gg: ASbGncsJJLJAJoFNm+WhAMm3aEwf8qBACp5ym7HfKdw/36zrOzQ9TqPY3eMF6iejnCy
 JiqAvMvDno3yTCqPKQ+CkYuo9helZiRytz4cx1pPWy9EdexCK9VHO0vwv3UW24iKl13TJ11+AqN
 Dws5efzDvo3RlHO3ONi2nhu94c1z8xjJeqnbP6GqFe7ZNW2zUUPsB19GHIG36fJdl/jIafVl3IS
 8rgH80XLSdYakSOeCIqHH3XZoOhy6sigttn5B0IiOlJExQDqCOrYeA4oAdn
X-Google-Smtp-Source: AGHT+IEZIbBS4o9zJftEjQUEomOOL4cxjelKHf6/Eg4YfsOwWE0OCG+7iDptMIpHY76zX+g64HZapg==
X-Received: by 2002:a17:90a:c2c4:b0:2ee:463d:8e8d with SMTP id
 98e67ed59e1d1-2f4437bf735mr84231699a91.14.1735976036291; 
 Fri, 03 Jan 2025 23:33:56 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f454f58087sm30691132a91.11.2025.01.03.23.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:33:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:33:36 +0900
Subject: [PATCH v5 2/2] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-san-v5-2-8b430457b09d@daynix.com>
References: <20250104-san-v5-0-8b430457b09d@daynix.com>
In-Reply-To: <20250104-san-v5-0-8b430457b09d@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 78e17e0efa83..16b051249c5f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2644,7 +2644,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    object_ref(mr->owner == subregion->owner ?
+               OBJECT(subregion) : subregion->owner);
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2702,7 +2704,9 @@ void memory_region_del_subregion(MemoryRegion *mr,
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
2.47.1


