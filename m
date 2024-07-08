Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73E3C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiId-0001I9-54; Mon, 08 Jul 2024 02:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIS-0000pW-UH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIR-0001tZ-8H
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb19ca5273so13823375ad.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421782; x=1721026582;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/jMKYGPTJJ9yGUeaxRp22EHnHqtIFtM17jmMaxbQ8UI=;
 b=j2HT0RAUbZZxKB10/HMcBMSXEQj+NeEX6239LW8mgwDmiN7hZoBMAaZvflHpD7tDcX
 PsyB1miAT6eGi7+Ph6IclKthRarD6fK64kWVgxUJZeS8FxaMb4J4E08TxliKSqTE+6mF
 pFy259RJTz9ieNe7HWJtQj2r6eGMI13pSw7i7oxrpE3iTNzUXpBogEALEgsalCMMv1SA
 IBEgmFFX4mEVIhjBMBAEHpHqd223dHU+a0CSXEH6/4yjZfOPG7pDYueq4iq1Hb6aMpex
 OX4xm2+KOwic4yn+WpuW6F8zP7zOQEYMWSvcXMhgg/I4MD0O7x+pAziY07NMsd1SkPt7
 gN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421782; x=1721026582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jMKYGPTJJ9yGUeaxRp22EHnHqtIFtM17jmMaxbQ8UI=;
 b=CNnwL0DcbGCdZwYb2cJem9Hcg52v7SRShhIFKQL8dVifxlHFLGYIvI4V36nCJGUNG0
 0sbzmF3qoAcB2g+lNuHqg5FNjr2zKJ++yPE8NEr1juYXYYNLepK79YW0o3elXSBNkF+h
 Nf2i1FUOiJrGCh9fjK4bEvL40ulrDeVvnutLRPVEK4TXbzxhl5jRns1nXoGe6BxrPclF
 /JRpOiNn5hXE53p9JGeIyDEBAH4d/wrzY7J4YOl+FnlYmgAVzlVyLdeE4vpHtqua0eW6
 xJH5hTQrS/QohCrEoFbmQIT04hy4E0aQNKHNFK4WV8cLeO+4AH+m2phastHDm0BorBtI
 gelg==
X-Gm-Message-State: AOJu0YyFIq5dv143OoeFF9bpHRNWu0rcsXt/TL6KztX8xfY71eJ67AnX
 KqepkmwqPgT0g6jcKfcpVegxeuVXnkioDZjU9T5aT1VtR9YIfWnlGjmJIkq7jc8=
X-Google-Smtp-Source: AGHT+IHM55HaZNNo61Hs7ynNHCbQVGIhDn1FJn7IXBZtorbAel5T9LcyEgQlWQGY2x96E9xCEU8/mA==
X-Received: by 2002:a17:902:f64f:b0:1fb:6260:8eab with SMTP id
 d9443c01a7336-1fb62609109mr30287365ad.64.1720421781978; 
 Sun, 07 Jul 2024 23:56:21 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb1fb30ba3sm85254985ad.89.2024.07.07.23.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:16 +0900
Subject: [PATCH v3 5/9] memory: Refer to docs/devel/memory.rst for "owner"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-5-b03f671c40c6@daynix.com>
References: <20240708-san-v3-0-b03f671c40c6@daynix.com>
In-Reply-To: <20240708-san-v3-0-b03f671c40c6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index a5af05864274..e1bd29550c15 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1245,15 +1245,8 @@ void memory_region_init(MemoryRegion *mr,
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
@@ -1262,10 +1255,8 @@ void memory_region_ref(MemoryRegion *mr);
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
2.45.2


