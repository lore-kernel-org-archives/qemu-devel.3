Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4F5E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Q0-0002YB-Rm; Tue, 23 Dec 2025 09:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PB-00016d-Gx
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P6-0003lq-Vz
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDO3NcZzsYCTKOGAKAbVb7PIZgkmuIZqHwaZxYA+h1s=;
 b=AytWHmypg78vCtvwJzWSDynYAPA9LSpTJy2vkt37SRufVfr88U/mXPINKmbJviZSW4Kwm/
 qs4hYxrFaYaj9D11SQdwbjJ4MwZyk1ls2CdmimwVc83r+1Ctdg9U589P9CtYlKmFmSQOgi
 vdx5VbBTRTMWl2uZnwycXlK9RAxv6uE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-nXJa46XaN0ecuDLn3tXzmw-1; Tue, 23 Dec 2025 09:30:23 -0500
X-MC-Unique: nXJa46XaN0ecuDLn3tXzmw-1
X-Mimecast-MFC-AGG-ID: nXJa46XaN0ecuDLn3tXzmw_1766500221
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a25a341ebso115189516d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500221; x=1767105021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDO3NcZzsYCTKOGAKAbVb7PIZgkmuIZqHwaZxYA+h1s=;
 b=ZZKWdkdGwyedWY0y2Nsvkdu6CZ+JCM5Fj1PLye5r7OpS9pzSlHB5epi359xakkfZzQ
 mayo/029MSdJT3GjfhrFg1wVVr+BZwcBOkd1eI7XzGIbLTYfXP/g2XCQM/f4jJH2BGc8
 FE+XUSjYzqj7xa+yxK1k1jZoBhmEvHZ6YpVStxQwLQYxTgCSzLsivfM/+I5Y8rAG8c2G
 X5TgKmKbEDBpPh2BrXyeShtVjznuMG8MJuGFSrUv29JfmcN4oDi3i/VLuuJua4pYVZC0
 QFBKWzqhlF8PAAAwsb8cu12MrYquzbDS68wMkeoJF/cUBCJmHI2/7usTmpEByoahS4eW
 W+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500221; x=1767105021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDO3NcZzsYCTKOGAKAbVb7PIZgkmuIZqHwaZxYA+h1s=;
 b=goJcx9uL8ZR9EKGulfDhI/bP71qQi5ett2vJvc66AlMr/68BeAcBhnPQh7DxE7z84S
 oB79tu0aV7hhu25p/NKqDuei81/YLDFTbqSQx4mid/r0gz0HH8G9YO2VDs/rNzeDA6xQ
 ZqJljX4+CpyzZbZRhyJzfebH8cjs80RdPbx1+8YklOAQ5SDgFqaVOqPMyiGewObA5wxj
 14xfGkR2zsuURn5yjXZ6JH4+9y/He6lb6+itM9490Nkv8KHvzsRjrtp2bHrwUdE7+4Xd
 by+0ADWp1dEXa8//ir9MeAYqdJumKxtTG1hJ27v/gtxMJtSJwrvAcP4yV463hKLNIGYW
 uWXQ==
X-Gm-Message-State: AOJu0Yzm7pF78zzsb4GpofhGcrf0MKoco3n23Nl84p+8ZfCuW+QFIvTP
 A+3ijkm82QgzY7mGV9t75e/KxvscYeou384u/re1aJbQFVmjzJglgsMZ1JDQ1JBVeoiVj/8sfBi
 /aHZCYLI8XFX2vTvxa6VvybJMTulQQj6T+vF1th3pS6j9+avwwyewhCX9zqDpZ0fbMe+ixtbSWM
 vFo7e00mO9KeFTr5OSr/CxhW91w7K4FazX3KxiMg==
X-Gm-Gg: AY/fxX60TtoQHmWSjQgGxoILSEpb5pGeVQBisFpAG9p1plRrqVL1V23Ex5LJySYwHh+
 OYI5VGSniwrQt6JUnNEeEcfDwOGM+9oPNm6c1PAGmNr0LQEVDM/9L+EchNWsMCXRIH//qdnm2pt
 WIHPtQWAAeuzMNxehFX6qRfcp6qNBGsc0pOE9bBaeSDqlYq3aiVWWwDda9nq1R53pUk20fuMmK/
 Sj2dXUL3TYJwEn1X3xVHC9Fo4dB8y+hZZSSpmObOxto0iPbb1cCvrVMuhM4xSc7phlmOkEfFr6c
 o7C/5cBVwVkALixNDXuHJ010JyfvFr2+B2/Tb9M6dOLzVVxRp5TOifFuR04US/cWgK/iWg4oD22
 1G6Q=
X-Received: by 2002:a05:6214:2cd6:b0:888:1f18:79fe with SMTP id
 6a1803df08f44-88d87606914mr176024346d6.45.1766500220661; 
 Tue, 23 Dec 2025 06:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDQAZB/6GNZM+a4YsVdVTxWP8qxuLGDuzKKRE5fNglzZByS1KZP1L2mpGhcSBqFLw63uY4lA==
X-Received: by 2002:a05:6214:2cd6:b0:888:1f18:79fe with SMTP id
 6a1803df08f44-88d87606914mr176023556d6.45.1766500219944; 
 Tue, 23 Dec 2025 06:30:19 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 15/31] migration: Fix leak of block_bitmap_mapping
Date: Tue, 23 Dec 2025 09:29:43 -0500
Message-ID: <20251223142959.1460293-16-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Caught by inspection, but ASAN also reports:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
 #0 in malloc
 #1 in g_malloc
 #2 in g_memdup
 #3 in qapi_clone_start_struct ../qapi/qapi-clone-visitor.c:40:12
 #4 in qapi_clone_start_list ../qapi/qapi-clone-visitor.c:59:12
 #5 in visit_start_list ../qapi/qapi-visit-core.c:80:10
 #6 in visit_type_BitmapMigrationNodeAliasList qapi/qapi-visit-migration.c:639:10
 #7 in migrate_params_apply ../migration/options.c:1407:13
 #8 in qmp_migrate_set_parameters ../migration/options.c:1463:5
 #9 in qmp_marshal_migrate_set_parameters qapi/qapi-commands-migration.c:214:5
 #10 in do_qmp_dispatch_bh ../qapi/qmp-dispatch.c:128:5

Note that this is entirely harmless because the migration object which
contains the MigrationParameters structure is kept until the QEMU
process exits.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index d55fde222a..1ff728b6a2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4139,6 +4139,7 @@ static void migration_instance_finalize(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
+    qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
-- 
2.50.1


