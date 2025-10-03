Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC46FCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv3-0005V6-OA; Fri, 03 Oct 2025 11:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huo-0005MK-A7
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hty-0007j4-2N
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0M3OgM7fC41JZEMnOWkaqWz/xO9x3D7QwUK/MkVlLM=;
 b=L2iIuVoyeRVubokjg/96WGZ1r5mTsci7S8Zraj66JKrEfHNlnQ5syBCo2Tf5tK2+4bsMFz
 abIHcQWAdJ9jxXEpT7F4oBq5qeepmzySsaQO1aiffuzJjEMDFAb5u42pi5QOm0zzMiNIXX
 ie3xsA4rOZK5ACZS4lt3mDwngeWOLXI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-5aSCGpkXPLeQ5GvKXesOFw-1; Fri, 03 Oct 2025 11:40:39 -0400
X-MC-Unique: 5aSCGpkXPLeQ5GvKXesOFw-1
X-Mimecast-MFC-AGG-ID: 5aSCGpkXPLeQ5GvKXesOFw_1759506039
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78e30eaca8eso74445146d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506039; x=1760110839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0M3OgM7fC41JZEMnOWkaqWz/xO9x3D7QwUK/MkVlLM=;
 b=CQpRzJp1gsGXH8zGrMjyhfdCtKBsdZgR8Rr0PJlNj5TV0i7HkEyqFRyfmWyNWvcP9i
 HnB8uCv/RRrGoZ6D1CnvjpDOAiDMFyy5KaqT4xYoA5B6h0Zm98W583c8OfJOK1KtfaME
 GYAORHO2ZaDdJwI+EGRdraxXbhpzazkjG64dfdagJjbGD7hLz4bBhJ8TzQbAXqiil5/A
 YSD0bcbULKIvTX/OWiNYyZ4+N+wOfny8pGUB95zJEtq+XrtyJdTrMPgnCSf0pM3RKs2T
 QCmqVcTCmk9+nc+TEVUJx/OEznm6Rm0l+0dmDUdDXmG11kUIKy/HYrXwsspPaYwXORoF
 3SaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOs2ER9R+RG1/7/xiBWy8vuwdE6E/jx6JkEBMqzE9vBeJLy4P0TUyYFIfjr39g6Wpi59xC9R7o5+en@nongnu.org
X-Gm-Message-State: AOJu0YyhqzGdUynjNHzaJO5jKJXMZqefzKZOO6jyra7tht6/AIlZOVAs
 b3SuC8SQqccrHZ6u5/cc1IkfMKO5zYTvy+QVyet5GLAwpjd4Z121L4g8DDC+xmZ5qV165cYw415
 JHyjGa4b1weG4DAKdaP8a+AS+R4eP0dJCcgqIdQ0hx9+nL900b+xOrB5a
X-Gm-Gg: ASbGncvqO1Fp/+1RwOXhMpGMwe9wC1JPMtvizwMiTxxWZttqjum9LWG7c2E1ZcOlPUz
 Ht2eyhQ3xcI7SICDluerXM/VphhO3g1a/hv5PKORtbq4pTheb1iVmzMRd3oN90kY2A4ieQKT20+
 9nIcwYiMOhZLp4AlQRZ18V4vZlbpXvqrj7uE4HW94Iahux2DQ9AIZB8fbyrXjYHTRwiTAmMQ2oe
 15IQZPLcjHwqdlIpVWtUBPWPj2bMJDEQj4OuflcLSYtPN3QaZIS4v69PVylRIlg8X4AlHIOfPlR
 r4fJwBck5ina2x0cKXUFUeVHszDjVmIE3x6jug==
X-Received: by 2002:a05:6214:528a:b0:86c:3615:96fc with SMTP id
 6a1803df08f44-879dc82c234mr46970266d6.36.1759506039232; 
 Fri, 03 Oct 2025 08:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYSj0BosQhQYS9VIw3kXOKX8tGb62Cfw/Ah+Ov+tUfXzViUaWlzdY73fkieaYRa5oYBpqZBA==
X-Received: by 2002:a05:6214:528a:b0:86c:3615:96fc with SMTP id
 6a1803df08f44-879dc82c234mr46969496d6.36.1759506038400; 
 Fri, 03 Oct 2025 08:40:38 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 33/45] include/system/memory.h: Clarify address_space_destroy()
 behaviour
Date: Fri,  3 Oct 2025 11:39:36 -0400
Message-ID: <20251003153948.1304776-34-peterx@redhat.com>
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
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

address_space_destroy() doesn't actually immediately destroy the AS;
it queues it to be destroyed via RCU. This means you can't g_free()
the memory the AS struct is in until that has happened.

Clarify this in the documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250929144228.1994037-2-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a1..827e2c5aa4 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2727,9 +2727,14 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
 /**
  * address_space_destroy: destroy an address space
  *
- * Releases all resources associated with an address space.  After an address space
- * is destroyed, its root memory region (given by address_space_init()) may be destroyed
- * as well.
+ * Releases all resources associated with an address space.  After an
+ * address space is destroyed, the reference the AddressSpace had to
+ * its root memory region is dropped, which may result in the
+ * destruction of that memory region as well.
+ *
+ * Note that destruction of the AddressSpace is done via RCU;
+ * it is therefore not valid to free the memory the AddressSpace
+ * struct is in until after that RCU callback has completed.
  *
  * @as: address space to be destroyed
  */
-- 
2.50.1


