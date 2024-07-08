Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927D1C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiIR-0000i0-60; Mon, 08 Jul 2024 02:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIN-0000RJ-Gy
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIK-0001qt-Q3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fb72eb3143so7930115ad.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421775; x=1721026575;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ChRWheJjblqVP5q7+vXrOZ0CV+wipm1YZa2EmXXOkpw=;
 b=WbcPQOoiOMsaor48S+cvkvH82+Z8fYBS0IxHLoz9wn8U3rLu1bkDrniGb8N6yW7vRg
 Cg0l/XAwoFGsCeanGGonUV6erfY3kqcP4Iq9b+Iqp4vKk7lVh9bD3f7dapWvIbCTbPJt
 ECK2Zzqaci5jJAw6A6d0xWnQifp1TmnUt+CIJ0Fg3KXXY32VVvC8SUQEVDt2+kqFks+7
 IEaTDY1CGpwRXtzAf7lj42i9b3bzEn5TllfG3/Obdsw12BL0UYKrX2zaU5VHJIv4iBRw
 QW+/UFatQCxPDrl95OQ9S1VjZnQlqMfKVGd2mawKvnFeNA/5FrX98omnx9U/BA3RZ4a0
 7l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421775; x=1721026575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChRWheJjblqVP5q7+vXrOZ0CV+wipm1YZa2EmXXOkpw=;
 b=A/CPoqBxoJVuJ42sVgTFT/QRdMr76UYAgku9uom7njQO+/yH9Wnz15gklDOBitzj26
 hQcb3ISL/1LEj/CBACbZ3Uu6sTRHCKaIsBJ9DSDQBuwaf2ByQCP1ZAaUDy7mGIqHhZTF
 QdsTUqwBCaKVjCghve+WrA9hh7SnNiE6yY19YCg7ah6Crjg8xiaIHNod0/kZvitoCOSc
 QnmbccKlEVQdRGpSbIwPCvv8TJdid65xNXxzHUx+w3wcRQqKiTNRenBkyQ10f27Gblmj
 K7FH6EHRNnGv4S7sPtnrS/62PFFSGtL+sV7ED+rLu4Q3clPMtfU27d/XS7TNjwNA3jCz
 YcHw==
X-Gm-Message-State: AOJu0YyLSWzahdar6Xq4pBmSrJ9zEQaVm7IhdG8bhxD7FJRN6YxP8+1E
 VDdJTn7ZHhzqsbIk41dWTGEtEtu4+WXrXr8gyz/kyNF745pJECgpOm+JiLSXBp8=
X-Google-Smtp-Source: AGHT+IEVqu/8DsEhzBCxZKr1jWnPsEYZhX59/+YkowLt6y09KqyZz3Mfs436iKNSVuV3e2T20/W0hA==
X-Received: by 2002:a17:902:dacd:b0:1fa:ce44:1cb3 with SMTP id
 d9443c01a7336-1fb36c3a357mr192999235ad.0.1720421775458; 
 Sun, 07 Jul 2024 23:56:15 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb5962888csm43274235ad.61.2024.07.07.23.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:15 +0900
Subject: [PATCH v3 4/9] memory: Do not refer to "memory region's reference
 count"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-4-b03f671c40c6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

Now MemoryRegions do have their own reference counts, but they will not
be used when their owners are not themselves. However, the documentation
of memory_region_ref() says it adds "1 to a memory region's reference
count", which is confusing. Avoid referring to "memory region's
reference count" and just say: "Add a reference to a memory region".
Make a similar change to memory_region_unref() too.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c26ede33d21e..a5af05864274 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1243,7 +1243,7 @@ void memory_region_init(MemoryRegion *mr,
                         uint64_t size);
 
 /**
- * memory_region_ref: Add 1 to a memory region's reference count
+ * memory_region_ref: Add a reference to a memory region
  *
  * Whenever memory regions are accessed outside the BQL, they need to be
  * preserved against hot-unplug.  MemoryRegions actually do not have their
@@ -1260,7 +1260,7 @@ void memory_region_init(MemoryRegion *mr,
 void memory_region_ref(MemoryRegion *mr);
 
 /**
- * memory_region_unref: Remove 1 to a memory region's reference count
+ * memory_region_unref: Remove a reference to a memory region
  *
  * Whenever memory regions are accessed outside the BQL, they need to be
  * preserved against hot-unplug.  MemoryRegions actually do not have their

-- 
2.45.2


