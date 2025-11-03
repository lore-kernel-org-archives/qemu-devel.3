Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4341CCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lx-00014w-19; Mon, 03 Nov 2025 16:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lt-00014e-Kj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lf-0005QA-D1
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjs+hEnyEnb+x771M+p8O7Iiqf1MdREZ/cqrEg0Ze3c=;
 b=O/LKBZR/UMcTmhSfsO7E0uNj8tbbxpXQmrMuHeuVlcJtit8O+eulEFNkU63A7mxbNK6XYZ
 dQNQDguiNj/4OxUrswNPjK3nD22OtUl9vsbl1Vd9kvNQA9QymZ7ikm5zMr7PoZ6gb02kK4
 GWpQJlzgvpP43MDUeN4P5fDtyFJa/Po=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-L-JmnSoFMQSy061Ll-tGkQ-1; Mon, 03 Nov 2025 16:07:06 -0500
X-MC-Unique: L-JmnSoFMQSy061Ll-tGkQ-1
X-Mimecast-MFC-AGG-ID: L-JmnSoFMQSy061Ll-tGkQ_1762204026
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88046a6850bso69823986d6.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204025; x=1762808825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjs+hEnyEnb+x771M+p8O7Iiqf1MdREZ/cqrEg0Ze3c=;
 b=rM1v/Yp//ChuuHVd5jgey8hv5azcGnb8GuGr9LplGhFOXtsf1njBNul0bF5VHZ3d0F
 sYFVggAeZ4k68GAk3JTZNzZrWBgIu4W85YiO7/YJHyhzdL7Ay/PeLGeBaoMfO3q+WMUs
 KY0bx85r9b3L3GHYiwhn63IMD+sWNuzoVmaF7AhqUB8CqR9hJeX0sDzhxqQzeAdJJXLe
 YN8lLg4vmbPztTS8ffVDZYgXC1Tu/8R6CuyghpO2A5NhVgdDRYgB/Vv+l2NIpNJuSVvQ
 FlcF8XYrU/mN/il+tTuHxDfBa1fF3sV4OJGD+gxTy6r0XSWdPyQk1P0HDWjF9RO5oVUp
 0uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204025; x=1762808825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjs+hEnyEnb+x771M+p8O7Iiqf1MdREZ/cqrEg0Ze3c=;
 b=s6oMWHaNKLd3KQjk303juggsR6GpXkflnb1xzUXgqLXaMm7Jc1m+UdS9AiB+4wLVNd
 FGgbIF7jblekqqcRyhlgmfls/zdZpwxxxxNRHuOONk0h6/fHVf/6qmWqEI3LH4Z5C1+y
 5HtvdBhPrYO62fCFwvZkdtJSJ8dMcJ7v6vp9pOWTAkDPdLn68DW1FZnu7L8FvgxceX+i
 VhPFmqjJXxUYM36kpORm6b1ZHJt2zfnBUzSr60i2z/fp1XpNkxXXhW6QCm/n40/W76P3
 e79byGuDntJ6Fpb44o1Ap+L41rbIXHw8azAji2eVHK3u7nkUgrzJ+NQMpvnDT2YEGQe1
 FAIQ==
X-Gm-Message-State: AOJu0YzbQv8hOOLAzT+55rX0y8FnHT+yobDwW9wu9EVinu6e6+7RzBkE
 HQAiIBpyA54LJWisJXYNatJzTeExzKYg3g2LlysuGCkvlFL0we7/Vywv6Egd4sD53IYgfX198Fi
 NTOWRINfWKghASZ3WQTk+59iSS+4D+JbLp1Ki8eBw4Zo1qd+dicrdjDB6XI+ajblKKwehBEikf7
 QVvMq4xhusqwyhhyS5UB0kANK6i+iOsC/97HWqZQ==
X-Gm-Gg: ASbGncvKFvKRTSiGpEQYWMLPyhoGyMU/1I9GAV/R/oBQhbYZX2U4wJscpYZMmtEjye+
 uRW35/PFm49mTv55u9CDYJU/T+u9Mr/7rctG422rInKgeIDO61u0qPQz6Y2yrTzpL9WhMYAZ5Un
 Jw/BeY5CHl4XKpnyhcHpg14BPh7RRo2OOBm5bDk8mCbTgpJFaApcbxvP54tUtkQ4N+t0PtOUGCT
 ZU16Q5k++6igkAJg3c0ix4UxQxNUhBbL/lbWD29/jKPOo+FkA1i+2R8tFRfX5tz7G9P+Ll3Oj94
 Um5HrzD7u33qIHeVAQPlTJ+oNbc6U0oOAGJOTYZn6al7OrNlAkO0RdI0l+zGHKzY
X-Received: by 2002:a05:620a:3711:b0:892:a71a:c02 with SMTP id
 af79cd13be357-8ab996871f5mr1472833585a.23.1762204024566; 
 Mon, 03 Nov 2025 13:07:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2DNORKh+D6fj5bCQNbH0VK/kcT72jodWjKMJxVMMUel5HH8fv3WT8euZbwxvU/HidusnHfw==
X-Received: by 2002:a05:620a:3711:b0:892:a71a:c02 with SMTP id
 af79cd13be357-8ab996871f5mr1472828185a.23.1762204023928; 
 Mon, 03 Nov 2025 13:07:03 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 25/36] migration/vmstate: stop reporting error number for new
 _errp APIs
Date: Mon,  3 Nov 2025 16:06:14 -0500
Message-ID: <20251103210625.3689448-26-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The handlers .pre_load_errp, .post_load_errp and .pre_save_errp
should put all needed information into errp, we should not append
error number here.

Note, that there are some more error messages with numeric
error codes in this file. We leave them for another day, our
current goal is to prepare for the following commit, which will
update interface of _errp() APIs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20251028170926.77219-1-vsementsov@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index fd066f910e..677e56c84a 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -157,9 +157,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->pre_load_errp(opaque, errp);
         if (ret < 0) {
             error_prepend(errp, "pre load hook failed for: '%s', "
-                          "version_id: %d, minimum version_id: %d, "
-                          "ret: %d: ", vmsd->name, vmsd->version_id,
-                          vmsd->minimum_version_id, ret);
+                          "version_id: %d, minimum version_id: %d: ",
+                          vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id);
             return ret;
         }
     } else if (vmsd->pre_load) {
@@ -259,8 +259,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->post_load_errp(opaque, version_id, errp);
         if (ret < 0) {
             error_prepend(errp, "post load hook failed for: %s, version_id: "
-                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
-                          vmsd->version_id, vmsd->minimum_version_id, ret);
+                          "%d, minimum_version: %d: ", vmsd->name,
+                          vmsd->version_id, vmsd->minimum_version_id);
         }
     } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
@@ -441,8 +441,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->pre_save_errp(opaque, errp);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret < 0) {
-            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
-                          vmsd->name, ret);
+            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
             return ret;
         }
     } else if (vmsd->pre_save) {
-- 
2.50.1


