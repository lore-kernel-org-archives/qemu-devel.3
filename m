Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191DECAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huz-0005So-Pw; Fri, 03 Oct 2025 11:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huR-00059e-2a
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htl-0007ii-9q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yw09ewyfYxR8aQNnIwkazbCaU4dtR0KImSpfxhsC/aE=;
 b=hoNS838asvmO021sd47PUHIN3/WT1MSeYt7jNd9+ad2POc9Es7MHJQ83XeIT6AbT2LU2ZL
 G/hGEmsrmKFmXjuUQbEou3Q8X0sKFzl3E98F5A8xt+IxpF2UcMEztpaO18YcZuPQo7hEi4
 z899eQPumKUIoatyYgnZh08gIBx+1VI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ePDAm-rRNQW7hgTLucZlKQ-1; Fri, 03 Oct 2025 11:40:40 -0400
X-MC-Unique: ePDAm-rRNQW7hgTLucZlKQ-1
X-Mimecast-MFC-AGG-ID: ePDAm-rRNQW7hgTLucZlKQ_1759506040
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-81a8065daf4so29084536d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506040; x=1760110840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yw09ewyfYxR8aQNnIwkazbCaU4dtR0KImSpfxhsC/aE=;
 b=CV0AS3fX8SOl+0YGJhDMV3JrZrGrfZm1Q9vMA7rLR71l3Rk5IpEGYEoc8KGShj9qw3
 fcmB+Ol0/8A/WL8OGwjUtc9aTlcRAMmJyMNWumDtBZ/Wj+hSVSQSuRefMvn25tcyjK0Q
 OzYcFcZ6y2rh0c61YkhHQX03YMUtaES+E7BkRsXXNouK+itZrZUOb7XzJ27vfl232zSB
 21ZrT2+VESBxlsj3wEU7oUuxytFxs6CaplAmbxQZ+Vxc0cAlTVlvM1XHnjww6sfsvQQh
 HKX7RGpNAL5Kc5cQvG6PkJFZvbDm5hJuF2mJAVkk+EReFO9ao1NUP/U8fB4WiBYhHjlP
 Njdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUryPynXK+uUqRalhX91ILRzTv/VUo6k7M9YdAbBvPDuulFYWrDapHsJDMAV/tsm0/99Zh42eht6KsY@nongnu.org
X-Gm-Message-State: AOJu0YwDTxmLcYfp+gfj/NUAUiluOzLsz/64F9pQDQMOmje3bUqVFvME
 qAEbeUIbnnGakYhG658wfR5Zv8OCWAOnVKqUpC5fAW0kIAPRJBing/F22oLg6XY6yE+AygPJ5Mr
 crDLk1Tjr3lJt8ZD8z9vt3LIrb0fcdXvUuTSKDvUZMMyBXJO/GNFQYwLy
X-Gm-Gg: ASbGnctRMpHOHQbgpd1HmJnxY6/A1aN15lp0wPLWT3Qigs0JB5bD1ULkNm1Pdtffz7T
 cltI5gTW779BxiCcRixO3D8WnJMewAoRxghAU3+j/pLPR0ILlW5fGl8aPu8vK1+/go7ex6wy92F
 Cb+ZyX8eaTlLcKIMitNeLeaEmyLZqs9xPJRHael8YHtSEM9nDvqBRbKQQ1v9RIOiYaXryp0nww/
 V8ukRZotbJFcbOlOIuqcOlUacAJGSdx4oGVTWJc2ZMO1uzBcgeaTq5im5+XMmB2OrtxjtraAvWj
 9Sewq7sNuIS3hvAnIusytRxSi7XN7Pnuacrv9g==
X-Received: by 2002:a05:6214:301e:b0:879:6db9:148d with SMTP id
 6a1803df08f44-879dc7e77admr43971766d6.27.1759506040023; 
 Fri, 03 Oct 2025 08:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdDv8exy8l6lE+ZclP/FQ+WARpI+03KumZX0Z8diefisqAhhtKUCMVh+PfW4p9JDGmU9GbRQ==
X-Received: by 2002:a05:6214:301e:b0:879:6db9:148d with SMTP id
 6a1803df08f44-879dc7e77admr43971236d6.27.1759506039438; 
 Fri, 03 Oct 2025 08:40:39 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 34/45] memory: New AS helper to serialize destroy+free
Date: Fri,  3 Oct 2025 11:39:37 -0400
Message-ID: <20251003153948.1304776-35-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If an AddressSpace has been created in its own allocated
memory, cleaning it up requires first destroying the AS
and then freeing the memory. Doing this doesn't work:

    address_space_destroy(as);
    g_free_rcu(as, rcu);

because both address_space_destroy() and g_free_rcu()
try to use the same 'rcu' node in the AddressSpace struct
and the address_space_destroy hook gets overwritten.

Provide a new address_space_destroy_free() function which
will destroy the AS and then free the memory it uses, all
in one RCU callback.

(CC to stable because the next commit needs this function.)

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250929144228.1994037-3-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 13 +++++++++++++
 system/memory.c         | 20 +++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 827e2c5aa4..08daf0fc59 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2735,11 +2735,24 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
  * Note that destruction of the AddressSpace is done via RCU;
  * it is therefore not valid to free the memory the AddressSpace
  * struct is in until after that RCU callback has completed.
+ * If you want to g_free() the AddressSpace after destruction you
+ * can do that with address_space_destroy_free().
  *
  * @as: address space to be destroyed
  */
 void address_space_destroy(AddressSpace *as);
 
+/**
+ * address_space_destroy_free: destroy an address space and free it
+ *
+ * This does the same thing as address_space_destroy(), and then also
+ * frees (via g_free()) the AddressSpace itself once the destruction
+ * is complete.
+ *
+ * @as: address space to be destroyed
+ */
+void address_space_destroy_free(AddressSpace *as);
+
 /**
  * address_space_remove_listeners: unregister all listeners of an address space
  *
diff --git a/system/memory.c b/system/memory.c
index cf8cad6961..fe8b28a096 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3278,7 +3278,14 @@ static void do_address_space_destroy(AddressSpace *as)
     memory_region_unref(as->root);
 }
 
-void address_space_destroy(AddressSpace *as)
+static void do_address_space_destroy_free(AddressSpace *as)
+{
+    do_address_space_destroy(as);
+    g_free(as);
+}
+
+/* Detach address space from global view, notify all listeners */
+static void address_space_detach(AddressSpace *as)
 {
     MemoryRegion *root = as->root;
 
@@ -3293,9 +3300,20 @@ void address_space_destroy(AddressSpace *as)
      * values to expire before freeing the data.
      */
     as->root = root;
+}
+
+void address_space_destroy(AddressSpace *as)
+{
+    address_space_detach(as);
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
+void address_space_destroy_free(AddressSpace *as)
+{
+    address_space_detach(as);
+    call_rcu(as, do_address_space_destroy_free, rcu);
+}
+
 static const char *memory_region_type(MemoryRegion *mr)
 {
     if (mr->alias) {
-- 
2.50.1


