Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619B6E77197
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyff-0000kU-Ud; Sat, 04 Jan 2025 02:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyfQ-0000ib-GR
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:33:54 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyfO-0004XU-U7
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:33:52 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso18351399a91.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976029; x=1736580829;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X15McHDUebM0CGywNdJKCJ3ISoR67bIHiMkS80YfTys=;
 b=TcdZo88puSQjpkZDaFhGyoUu4dcMAeILVmehGdNSGL57oXht6IzZ6oJIhxo1OeNjAo
 LYL9UMsMgki/pPHaY9fVJFRMcGNa9UBdVAI5QAavJR9W2lmqTqZBIMa2y/IL6y9zzk8s
 qDhqhSAzS2W2zxX9YwdSluAf4xgU2lAcNX7WfqmExfLNi+pVMP1LLrsvH2iRPZQ0WmUA
 75mAsARlxB9MxewHS4Pk5fwAXnIhTcTw/u86Bcn0YHiZOEumgwj4V6hom04leNfFatE+
 WBwE2UF+sYyaLczuv1+aeyT0GA5u53xDnmFtdTENz2fyZ6qxXxG9OfeFN+EW6NgJpv3P
 hy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976029; x=1736580829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X15McHDUebM0CGywNdJKCJ3ISoR67bIHiMkS80YfTys=;
 b=IDC+HzQBE/njznOHKcD2NhOep+iJH2Ex0ymBbuQWjcG3qwuqihVKuy9wTOWIuHv4Bc
 aB6tzsqAM3G1b+o6rbzmLJLZzGQQuezAhGuX+2eLiq+NgW90ES1z5vO2JANeWbHpuHly
 iD5BBQqXmo122E0E78fEuKnt+2DoGZny8eUOC+Orkh4i1d7ReG62cwopwPQZeWgNrGup
 sofyciCpv6EF3p4NRJYUvZfEBOZFESQaVhZNMM5gSOK1/iFyJZ+G0GT8Fn/iKeXviojQ
 FAJqyVGAvdT1Mr+/f8Im0eZKKY8RdBx1CMCTnJLJbArvy+TfTgC/WWpx94fmLdLre6mx
 SddQ==
X-Gm-Message-State: AOJu0YxhAO3BFrQqxuPA7aT5OfLCaQJ6B1SFnG1KJdT9LhYncFg6X4fo
 GiR7Z3LOhvfgrWzSAKtWO1w673ZJsGto6RLalF6gD84X3D0vtIaelCmqBZDWeAg=
X-Gm-Gg: ASbGncsEXBRuRdl/4YE/pvzZ9hF+tedb51lWvBfb47Lj4866xlzVKiREZB/mNBBbhIV
 NJCO6uMNwop/d/Fb0WjdH7P/2XOEo86ongijQgpUB6IkjJVaa2Qpv9iupkuDJpQRyJCzxz3//2U
 Lr9+/ikZdLFqN/UzciObqxK00/xGD9Kq3L1+uSev1DU1w4MHuR3ANpHjDGZYhXLTiB3o6H2RBXt
 DCw0KJRd7tIRHWEeKfJRHieZPnFxKsTl6XIskZQfOGIpFiqDf/pmRJRASMW
X-Google-Smtp-Source: AGHT+IE3YuQCANANn+pWwhcjhsHFLpV/xD3HexN240kiSAXEpvFQcHGwX2gppeptlyGXI8OHGDFgJA==
X-Received: by 2002:a17:90b:2dc9:b0:2ee:8c98:a965 with SMTP id
 98e67ed59e1d1-2f452f01608mr68888053a91.34.1735976029622; 
 Fri, 03 Jan 2025 23:33:49 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f447799048sm29775644a91.10.2025.01.03.23.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:33:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:33:35 +0900
Subject: [PATCH v5 1/2] memory: Update inline documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-san-v5-1-8b430457b09d@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not refer to "memory region's reference count"
-------------------------------------------------

Now MemoryRegions do have their own reference counts, but they will not
be used when their owners are not themselves. However, the documentation
of memory_region_ref() says it adds "1 to a memory region's reference
count", which is confusing. Avoid referring to "memory region's
reference count" and just say: "Add a reference to a memory region".
Make a similar change to memory_region_unref() too.

Refer to docs/devel/memory.rst for "owner"
------------------------------------------

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

Clarify that owner may be missing

---------------------------------
A memory region may not have an owner, and memory_region_ref() and
memory_region_unref() do nothing for such.

memory: Clarify owner must not call memory_region_ref()
--------------------------------------------------------

The owner must not call this function as it results in a circular
reference.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d50..cd91fe0c51cf 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1220,29 +1220,21 @@ void memory_region_init(MemoryRegion *mr,
                         uint64_t size);
 
 /**
- * memory_region_ref: Add 1 to a memory region's reference count
+ * memory_region_ref: Add a reference to a memory region
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function adds a reference to the owner.
- *
- * All MemoryRegions must have an owner if they can disappear, even if the
- * device they belong to operates exclusively under the BQL.  This is because
- * the region could be returned at any time by memory_region_find, and this
- * is usually under guest control.
+ * This function adds a reference to the owner if present.
+ * The owner must not call this function as it results in a circular reference.
+ * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */
 void memory_region_ref(MemoryRegion *mr);
 
 /**
- * memory_region_unref: Remove 1 to a memory region's reference count
+ * memory_region_unref: Remove a reference to a memory region
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function removes a reference to the owner and possibly destroys it.
+ * This function removes a reference to the owner and possibly destroys it if
+ * present. See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */

-- 
2.47.1


