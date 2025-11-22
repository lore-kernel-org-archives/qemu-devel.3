Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C171ACFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcjZ-0000US-Ox; Fri, 21 Nov 2025 20:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTQ-0006c9-CF
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTG-0003du-1Q
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQqUtJS6s4eQNmQ6rnbU7MPx5N969oxd9HmJpVpakkI=;
 b=NnUT6wxlxAzw2Tu7lmNrxna3SaeI9QI/dKQwYZEBx/tmZ0n0XC8S8jG25uz7HumuQbj/d2
 pq//d2wgWR65JhW+VhAQw/GWXpV92koIFGOFKp6wwzUSvvnKxuNvXhBGryol0GR8xJKcck
 tkECyJ/blHsPQSf3BRUuy0ezO2THaPU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-Hvuxbo81OHa3Jn8-xd5Ncw-1; Fri, 21 Nov 2025 19:27:02 -0500
X-MC-Unique: Hvuxbo81OHa3Jn8-xd5Ncw-1
X-Mimecast-MFC-AGG-ID: Hvuxbo81OHa3Jn8-xd5Ncw_1763771222
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ee41b07099so28309491cf.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771222; x=1764376022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQqUtJS6s4eQNmQ6rnbU7MPx5N969oxd9HmJpVpakkI=;
 b=MzSTRVhXPpk+0e1eKNuZVi+M/hk5kt9hMCB90TF3cVHOGGY5kMDd1cOPqOK4Uuwl4/
 HGvH5+zBg4mRqArfPj0hxSEqF/AZ6cQE7bTjMzPJlbteRG2MgipHCQa/jl1VFBSGn9nj
 5YRxTCGbdNOWs9pT3CVp1uvRDaia2vbSF7C6BBlxJh9lRnR/Ph+x87x2EwtcZhzq6rc+
 z0XQyXMRnpsqPmkJ2FzkPHH6X+lI+5WKEmDkeQM1FZ+tyzd+WMAlyJv9D8hBrSlLP/93
 DFd16947NHoea+8kTP2yYrYF3mJd3loICfMVR9yyI2vjcEh45s8bcSvSbcCI5lyI03un
 dm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771222; x=1764376022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QQqUtJS6s4eQNmQ6rnbU7MPx5N969oxd9HmJpVpakkI=;
 b=mhhs1KsYNK+1F9KOEMz5Gwbg6D8/s9PXgd+dxNx/y69TqMBip+4cC2YIsENnRKr5IS
 Tb1/HUffyXDr4wJpXNHBGVgTueLEJqCzdRmV0Sb67ZJzt6n14BxpPU2yZhWSPQY8SQxU
 tkheWelntaPjlLdczKvAPaaWURR8NFVBmkOa2lNMNJNpkfSlrCRsAbyOZz0bUflZ+FFQ
 dGd6TIyeF3+9IRcH+dp++EIJrCjK7UFHUk/UxWbJkvYBZKNcvgt4rS14EGR6B9GYCZFi
 WvuxHxVKinOcuP93atpqZNDFYOXvXJilEZyFf2sUwIz1u+Gdv9RvSFPhuZWbcWmyezJ3
 rhhg==
X-Gm-Message-State: AOJu0YyIa6mGWfiEHgaJqWG0GKTWWFkxiMBH2zt3kIKTHI/1mfeh7BRB
 GLH+laeIkFGv1d+TfAg/L3JDwJcu8caJBvTG6YVTbDtVt/Sq6+EspMRW/xJNWmm+Y161Onc5Npy
 ONYN8lefU0eppczeOaoc+zT42OM3zPVhghB/6slIMXfL93K1TaukSrnbpzFpDPLUUVh0nLBTX9J
 DS/cUcvLYgIQYjnvRuV3cDO4zCgmN+/lZG9pwx9Q==
X-Gm-Gg: ASbGncssI9dPgmltj9ttFtN0uvxwVMt0VMoZu2etP72gqDBzpGkTjvdoy3ZlS6EbdW8
 1Ypqq6lb5nI0WTn0DWW3oocnk+yzKJe3iLqEVDHnfAE17+gbcxagTrMEiRh6PSzFrdlmQLY0jbQ
 Eo/3SbTwRxzKockd9oarbfznU/yZBcSiKtIEAK2UI9sKEJ70glr6VJDni7sJ1hxCXy0OI062B4J
 fzJo54qIy0bcDbIkxLsqLgAozvV2YwOA+4Q3A20Pjnuj/5Ls4igH39syR/4qwCXMlDbKul4gQHF
 oKJK1qYaKczam2rAwLiO6m9B2ZpDVqeMdCpD3IoyNYT9oK3g+8iXHZ719UGbN1/QF6h/a5psM0h
 D
X-Received: by 2002:ac8:5e0e:0:b0:4ed:b47d:8f68 with SMTP id
 d75a77b69052e-4ee58841a89mr50437661cf.15.1763771221821; 
 Fri, 21 Nov 2025 16:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/UemtddXhN4vBrN899zt+bLX9Lwt5VAvY8p62EQ+z4AMiHCqhLYebivk3p5tj+9iLXOOezQ==
X-Received: by 2002:ac8:5e0e:0:b0:4ed:b47d:8f68 with SMTP id
 d75a77b69052e-4ee58841a89mr50437381cf.15.1763771221302; 
 Fri, 21 Nov 2025 16:27:01 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/9] migration: set correct list pointer when removing notifier
Date: Fri, 21 Nov 2025 19:26:48 -0500
Message-ID: <20251122002656.687350-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

In migration_remove_notifier(), g_slist_remove() will search for and
potentially remove an entry from the specified list.  The return value
should be used to update the potentially-changed head pointer of the
list that was just searched (migration_state_notifiers[mode]) instead
of the migration blockers list.

Fixes: dc79c7d5e1 ("migration: multi-mode notifier")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20251113213545.513453-1-mjrosato@linux.ibm.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1b2c02d7fa..b316ee01ab 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1693,7 +1693,7 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
         for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
-            migration_blockers[mode] =
+            migration_state_notifiers[mode] =
                 g_slist_remove(migration_state_notifiers[mode], notify);
         }
         notify->notify = NULL;
-- 
2.50.1


