Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5858CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcmN-0002eF-98; Fri, 21 Nov 2025 20:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTW-0006fi-F5
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTL-0003gM-50
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eiFTSrhmdRBgSz2YPDVLbDrwe9yxAidpMEUIApAw54Q=;
 b=CdU8rt4M7yQveRYpslTkw+kW1niVJ7k+7js08bb6k3EVWnE0ndDy4nWbOtgi8FydXi6H88
 t/8xNqR41VO2TOKw67PaAyaC9QSLuP87PgH8q4R86PcN+arDL2vkS8ZucXQgTmths7vOE1
 B26CBQcTwtEfzeoKccWTga/7flpD8jI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-BB8srPofOdylj48UcAZZxA-1; Fri, 21 Nov 2025 19:27:11 -0500
X-MC-Unique: BB8srPofOdylj48UcAZZxA-1
X-Mimecast-MFC-AGG-ID: BB8srPofOdylj48UcAZZxA_1763771231
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b29b4864b7so417796985a.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771230; x=1764376030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiFTSrhmdRBgSz2YPDVLbDrwe9yxAidpMEUIApAw54Q=;
 b=UKWgt2pOM02H0xt7GTBRUZqOUj4hQmlsQ8HoMNx4cK+by8mSTwaIoROz57nxi6jesg
 4BNyMjOyxh7yHj6YtWP2SCt4RDpMWSgkJwWHUl+J2f9WSNhduWVWiNB7kG+0RVT+mgpr
 hy3BPzsVSmkzoDn+MbEcwv84fEQWGU1YDNBoBYXcqjIEx67oeSIsXqDSmUU77fOoBmaS
 oCdcmZOK6tzcdJGlf7TSlfGZ+2tlEzrWxjowlUSsck9OwrMDuivkztDVDpJHAw5l35CF
 /sfV25S66cKP2VS/9u4UM/s8All5gKuPKRVKa2/TIVIHh5aZa76UZ889CLkryzm9Aat1
 7bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771230; x=1764376030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eiFTSrhmdRBgSz2YPDVLbDrwe9yxAidpMEUIApAw54Q=;
 b=owLQwjN7qLwy0IQ0hou4XPJpDzeqvQ+ahh4qm0FTtisfpDB7GkfGghaDNL7+J7/TDy
 DCpbU+f61YQAYJ3xU5S728zky8xMOzaav1QpZSY2697+BHFXRzP/xuNb+l+5GUFhIhml
 fL9C4fZXJgTEOliuLF2z207+I+Cn3axDUk62IEZlnncudUdyEk5fmcV+tU1v0zActu8b
 cgOQjSQ/eA/c0K8b1nHhwxqVKV0AeZONbRpO2d35TyzDdri5aIuh/IkGn3aLAbwAbo3z
 OCsX2tOQGXeTWDYq+hhU2DBBkalApQXUJS9sW6Su7Mv2JfcrfVCzy+U65lMb2GxUW+bU
 vWZg==
X-Gm-Message-State: AOJu0YwE4OnorRCGp6/ogMBbLDdL+PzZ23GU7Y5TiZSRznVVycWkCe/a
 as3Ap4wP9L60Ag0Vn2YZmAqXINIh3lHSPZnyPyue2Mm/5CWK2J6hZMfnkKm3eqPH2m9y2DBpnfc
 GtfsjKVVoMd5RgdyChDEbP1UfOlYj/YyJfZxJkkEB7KTUHOb/4XGQIU6WiFJERq2t7RxIxLs0y0
 11wdfUOvgqgoJZ9kLN06pJoksoaZpp/pMyPNTVoA==
X-Gm-Gg: ASbGncu9NwMbTWsJv6YJ+CdBNA6cn/4CC3ZmhjoceHKdiHjOgkwzOSIfLOiTN7kbewX
 KqfgW0mtLE3DIc7czjMd3spg6hsMp8uWtwP9VrKiA+Rvux2z4+8gQloybHwAR6RiTzBuOAT7MV7
 5ixgyGa9gLBz5q6x3MQS1gwWt2SQ92ZD0L6uy/xwfo08yEtoxtJme1APNUuh+AILqtbp9poEvV0
 CwpJoMThTHkAM45nuQ/+HLHv1FLRNLFC5jVZS0uZeu/4DsCbPQi6LblOBMOuHZ7/oAz8Gzgpu9z
 8Gm7Ncdk0UWvqlT2NWDdafiTVFQ6ZcfZKQzb8uWZkWwGGhQkJV57SWen0XfOIa3/I6k/yfs4BIM
 x
X-Received: by 2002:a05:622a:45:b0:4e6:ebcc:23fb with SMTP id
 d75a77b69052e-4ee5885c1e0mr55410081cf.36.1763771230208; 
 Fri, 21 Nov 2025 16:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSz5f8KKhFnfZCxHKcRs4RSrtJbzYl0HlcaNlsT3gTjs0zj4DUlPcOTqVzk00sH9PwVZvC/w==
X-Received: by 2002:a05:622a:45:b0:4e6:ebcc:23fb with SMTP id
 d75a77b69052e-4ee5885c1e0mr55409801cf.36.1763771229750; 
 Fri, 21 Nov 2025 16:27:09 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:09 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 8/9] tests/migration-test: Add MEM_TYPE_SHMEM
Date: Fri, 21 Nov 2025 19:26:54 -0500
Message-ID: <20251122002656.687350-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Add memfd support for mem_type.  Will be used to replace memory_backend.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251117223908.415965-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h | 13 +++++++++++++
 tests/qtest/migration/framework.c |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 70705725bc..9dec21c344 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -19,8 +19,21 @@
 #define FILE_TEST_MARKER 'X'
 
 typedef enum {
+    /*
+     * Use memory-backend-ram, private mappings
+     */
     MEM_TYPE_ANON,
+    /*
+     * Use shmem file (under /dev/shm), shared mappings
+     */
     MEM_TYPE_SHMEM,
+    /*
+     * Use anonymous memfd, shared mappings.
+     *
+     * NOTE: this is internally almost the same as MEM_TYPE_SHMEM on Linux,
+     * but only anonymously allocated.
+     */
+    MEM_TYPE_MEMFD,
     MEM_TYPE_NUM,
 } MemType;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 7f325e4753..1c662f86a9 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -280,6 +280,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
         backend = g_strdup_printf("-object memory-backend-file,mem-path=%s",
                                   shmem_path);
         break;
+    case MEM_TYPE_MEMFD:
+        backend = g_strdup("-object memory-backend-memfd");
+        break;
     default:
         g_assert_not_reached();
         break;
-- 
2.50.1


