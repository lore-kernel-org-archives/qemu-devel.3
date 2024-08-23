Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A201C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYb-0002cc-K6; Fri, 23 Aug 2024 02:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYY-0002QR-B0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYN-00037j-Hs
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:52 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2021c03c13aso12241735ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393622; x=1724998422;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0K7RxwRuv9YcnxMw2PosqOuYZUXE/imSqne2Rr+Wijc=;
 b=aFIM2zW9IUGrpVHHauYwa8lcCNcrIbTy9PQcKTSk8yZTicER7rLQaMdaOYGxa6eLpk
 o/zzb+eVugQBD6/T58wHXJY/CsYScIth7WEs7S9kvQ2mts+qQrgDpCmHWqgr3MSs8rjv
 tSivx6JMLEzw714LqFOwJ0pV49WOaDHPAQGIZTVHNhjPDHBVa9lrlUSwxkAWlBwBagki
 jf7fiqOB83bMmc/p1ujejB5chfyOYd+ODw2h7fLr05FRl68vttfYNA8vk2Mk6qYQQtjQ
 psmE9jBYZGUcyjkkkhPjzZR1LpDTiqB2aFtmxNBvoQRVjYhNaDdBSLzmR8LjZ8qYZBOU
 ZjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393622; x=1724998422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0K7RxwRuv9YcnxMw2PosqOuYZUXE/imSqne2Rr+Wijc=;
 b=H8ZTZeW5m/ayRvnodUCuX0yYBqHZW3KVbCNkkZQ0eYdx0Xy/CHlUMBG5uL7VjXbFyW
 QgZISjRsVPH9KTDztd7PBoSvhhQG/6PxhFdwOsPReFusE30ZweJg/j38rcJB/Aoz3GiG
 NcXtqYAFk+9f/9gKyIYfFj5BvUwylQAmZS1Wda0cdmD0E5kiHStoAXIppX9vjWKGMsBc
 E0fOqNYmZgqvTGqBOB7rC99ppftavq+RHL6RIGjXtiABQl1AixHDMRLPNjwbH8jL/nhG
 zej6B0jdoGQwXfcj5ftfbh5GMHk0sanTH6URCnNbYgeW9G5U/dMsfw1OdW24UzUI0e1t
 15vw==
X-Gm-Message-State: AOJu0YwXmzs29BW/g3tSv7tuw0X8gBTd906gUnqhCvtt8wAjm1fABtIt
 sRPr/PeK9ZthGWtoFmzxcVMlh7w/gSdJJ0qi+jCjuQv6LoWSoOj735WjTXj0klQ=
X-Google-Smtp-Source: AGHT+IEAngTao5BZsP0x6bDwn8uzYT07K8nnRx/E7okr5ZhVBwjQFP3fKv8hQyXPsvSnEWre4QJ+nA==
X-Received: by 2002:a17:902:ecd2:b0:1fa:97ec:3a4 with SMTP id
 d9443c01a7336-2039c44c05dmr24395855ad.8.1724393622109; 
 Thu, 22 Aug 2024 23:13:42 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20385566479sm21646755ad.58.2024.08.22.23.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:13:41 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 15:13:08 +0900
Subject: [PATCH v4 3/7] memory: Refer to docs/devel/memory.rst for "owner"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-san-v4-3-a24c6dfa4ceb@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

memory_region_ref() and memory_region_unref() used to have their own
descriptions of "owner", but they are somewhat out-of-date and
misleading.

In particular, they say "whenever memory regions are accessed outside
the BQL, they need to be preserved against hot-unplug", but protecting
against hot-unplug is not mandatory if it is known that they will never
be hot-unplugged. They also say "MemoryRegions actually do not have
their own reference count", but they actually do. They just will not be
used unless their owners are not themselves.

Refer to docs/devel/memory.rst as the single source of truth instead of
maintaining duplicate descriptions of "owner".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index b9f0ad09bfad..461e42d03491 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1219,15 +1219,8 @@ void memory_region_init(MemoryRegion *mr,
 /**
  * memory_region_ref: Add a reference to a memory region
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
  * This function adds a reference to the owner.
- *
- * All MemoryRegions must have an owner if they can disappear, even if the
- * device they belong to operates exclusively under the BQL.  This is because
- * the region could be returned at any time by memory_region_find, and this
- * is usually under guest control.
+ * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */
@@ -1236,10 +1229,8 @@ void memory_region_ref(MemoryRegion *mr);
 /**
  * memory_region_unref: Remove a reference to a memory region
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
  * This function removes a reference to the owner and possibly destroys it.
+ * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */

-- 
2.46.0


