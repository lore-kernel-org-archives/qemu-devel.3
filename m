Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E487CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vd0-0008Sm-4H; Tue, 30 Sep 2025 04:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vcv-0008SO-93
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VcI-0000j4-Nc
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso37507035e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220500; x=1759825300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6Y+9YynyQUWZr+3xZXfGIWc6Jhbj4AT6sZ58oDn40Q=;
 b=Vax9MQ75UShvTQwdMZ8BfHs21FX35igSprLmupd/8n1tPdCmZbLAjL8Cg78AF1qKFr
 FO9FaRjX5LrAYt08m4h37+TsK8yBcHjVGhLMyOpJhPYLvCh8Vg3YDuQYphx4JMsu6+JO
 GReM9CTqBADPnt0a4668uTDBSGK0ycXW7xSgW/sFCIv78NL7h9KuuP52ReSvfUfXkY1S
 zNr8erALBX8uICUIK03r83Yx6G30CttcMVnYwGHkkOXV0/SwvPe+jCSuTdb67d1mxG/5
 waGCeys96pKeo5wRDW/c/AJSQ6Lr1W6EXw25gq54QBIvpdl/BHxp8M3Wh16r4LbadJx1
 PVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220500; x=1759825300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6Y+9YynyQUWZr+3xZXfGIWc6Jhbj4AT6sZ58oDn40Q=;
 b=rnX1Y5MtLNt0yf54U1VS/Nqdg1PjtntduabpU6pA3fqYEesp66BJ5WDVTW/+6IKDp2
 7vS4L4iPe6HZhu/u7LxFoej7QtFngQbcnVhXEytIs1d5IsMEYhS9fvLOUN7LZojg9G9I
 b5eu6dmAHbzLBaJtZjK7AmIUaVEYMHcKVzH4VOYWcAv5geqJKZTtlTjZkkddACfO81v7
 AEpOkI6DyEIyqLVNp3kDsKnhIx5IbJlDMVlUtlwKQxmV02dlhKJtPbf/u76AcSxJd97G
 D8fTLerm5TL8Pb1yr4tvabo/8fwVKpcniyLUZNXI6sb5cFpbPZEpCraNnDLkWYZ3Ub2K
 iN9g==
X-Gm-Message-State: AOJu0YwZwe3TTYVxTP+RhoRb+cZ+GKsvfPRAkyaxQHXIHAuq3rzSe+Z2
 W+MyErKqGDbubHljVlql2McpNV6MPlsIaOfdDmC45mXwOAaCIryTs2Ns5k2+yB2rjCzID2g/4X9
 w0QI4s3DdqqL2
X-Gm-Gg: ASbGncu8czb2kp16dGATtLNbhMpDAbx/m8lzgiL0B9sJfbnlX4ZFu60A7mQMz6YfiDP
 KvjRkFkwEchNXCtjLGfRoJQ+Wf/Dx0vXWhMPLN5l1Ft9xNfitfvfUH+LScp7ncj3yU3y6uKl7/n
 6IkaqM8zsvTpwgMnIORb+LwjtZpkOE9yk3Sv6Sr76Ox8HIcJTB2FhlmtfByPcw+sUXnx6DAxm6B
 5ehHNpBnY6XbwkIxGqeE+M6/PzvwzAEwUoYhunRPOTbKjNeKfF3/IQtqiq0cRetvE2Qr9aPE3ZB
 DtkqpRdNuGhSDTh77q9KNV3+kNI7W2sAFmsd5qs5jRtCJgfa1Jsnjx61GDTfOveuhtVQpKvXnrx
 eOVt66LwlT6cO7e8QPOQstrytXKuY4g1LrrShBx1UN0sjn4c4Xfcvs0FV/J6SshDe2Ax600mDJj
 Vlr4w4EyqiuolqgK1Mky7R
X-Google-Smtp-Source: AGHT+IEvqZbVxTkOzuE7/OdSy85DpVZk0C8frEdFACso26c6+h9s7puUVSPKjShsswhtViU8Ba02iA==
X-Received: by 2002:a05:6000:18a7:b0:3e9:d0a5:e436 with SMTP id
 ffacd0b85a97d-40e437371acmr19688375f8f.23.1759220499859; 
 Tue, 30 Sep 2025 01:21:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb1a3sm22070432f8f.10.2025.09.30.01.21.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:21:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 02/18] system/memory: Better describe @plen argument of
 flatview_translate()
Date: Tue, 30 Sep 2025 10:21:09 +0200
Message-ID: <20250930082126.28618-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

flatview_translate()'s @plen argument is output-only and can be NULL.

When Xen is enabled, only update @plen_out when non-NULL.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h | 5 +++--
 system/physmem.c        | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a10..3e5bf3ef05e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2992,13 +2992,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  * @addr: address within that address space
  * @xlat: pointer to address within the returned memory region section's
  * #MemoryRegion.
- * @len: pointer to length
+ * @plen_out: pointer to valid read/write length of the translated address.
+ *            It can be @NULL when we don't care about it.
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
 MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr addr, hwaddr *xlat,
-                                 hwaddr *len, bool is_write,
+                                 hwaddr *plen_out, bool is_write,
                                  MemTxAttrs attrs);
 
 static inline MemoryRegion *address_space_translate(AddressSpace *as,
diff --git a/system/physmem.c b/system/physmem.c
index 8a8be3a80e2..86422f294e2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -566,7 +566,7 @@ iotlb_fail:
 
 /* Called from RCU critical section */
 MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
-                                 hwaddr *plen, bool is_write,
+                                 hwaddr *plen_out, bool is_write,
                                  MemTxAttrs attrs)
 {
     MemoryRegion *mr;
@@ -574,13 +574,14 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
     AddressSpace *as = NULL;
 
     /* This can be MMIO, so setup MMIO bit. */
-    section = flatview_do_translate(fv, addr, xlat, plen, NULL,
+    section = flatview_do_translate(fv, addr, xlat, plen_out, NULL,
                                     is_write, true, &as, attrs);
     mr = section.mr;
 
-    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
+    if (xen_enabled() && plen_out && memory_access_is_direct(mr, is_write,
+                                                             attrs)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
-        *plen = MIN(page, *plen);
+        *plen_out = MIN(page, *plen_out);
     }
 
     return mr;
-- 
2.51.0


