Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68F9CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcm1-0002Y8-8U; Fri, 21 Nov 2025 20:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTL-0006Yd-FR
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTB-0003dG-5M
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMyNYRaZIbZKePdD41f98ajmZ0H3U11uYcSXUx13bYo=;
 b=fhY9UOersFqun0PKPj5+KKZqsM0fg4tZuQHx1vOgr8gjRE9bvfQDyN9E9O91arAeOQD8yU
 Zdyxjb0VCogQ9mv/uTMkpLy+4Cu3nlqSa3fF9ogFzEy5/olgJfxFmOkDArUDPff6n+Ww0Z
 ObfFS+stwbZwe25cuW9ZjXdcxTA/nBQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-OQgdZ32lMySUMV4vliOu0w-1; Fri, 21 Nov 2025 19:27:01 -0500
X-MC-Unique: OQgdZ32lMySUMV4vliOu0w-1
X-Mimecast-MFC-AGG-ID: OQgdZ32lMySUMV4vliOu0w_1763771221
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed74e6c468so35395191cf.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771220; x=1764376020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMyNYRaZIbZKePdD41f98ajmZ0H3U11uYcSXUx13bYo=;
 b=tDRwzz6iQoS78VOopH+N/yuaaKeKO/i1xJzu5eHm/wcfWoKNtowRhn0QW7QgsT5ZlP
 vNM9COhAiGwHJnljPj5AGka7lLWbV8XHNasUUkLD9J1umwHc3hRUsg40i+k9PdpL1y4x
 GMBIbteMZFlq5813h7vCdEEz6MOfBCcjSxYUNsjpZHIaGWPvMwAgDmMRjG0aMavv6mix
 8L4X0zpYK7GtEZNURnr1kjE+VtlZk50/U3iEsoRMLJ4OXRs79rNnYh+MZWvATpzX2AiS
 GBiuMxQhb9Xjcu7KxsLvNz5ePBNQcWmyp+OSOlplQ6flkhS7nAVOhklbf7uLKc4UfM10
 Okkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771220; x=1764376020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zMyNYRaZIbZKePdD41f98ajmZ0H3U11uYcSXUx13bYo=;
 b=siaFctH8mjAKZpClbCn2v9lOR4YHms8FARSUHXVDh/Ojugy6nKeoBc/IAh5WeHRflP
 cusATgH+qcV4yJ0Igyh14YQPjQoJzCTHl2BqzgRfQV1FX4X8Eu/7JYUQeB1w6nptlG+c
 v9S+qqCKeoBZ7u0bOICT4jYSS8DUKmrMlUfYGRn9CV+h8/ynTOX8nLgLgQkRyjUiG1I5
 nCIKy7zduMJTA8jd3ord5oGAHxvnOkPxxbnJLGjPOC9jdPYWqsxJlWXeZRSuDGEi0NRL
 9MbW3Zv7ECLGXhzWjOxt6syNl8UKCGYMgkSf1VCDBJhTaIOd41HLLlDyvewgP0bWVrsb
 QZXg==
X-Gm-Message-State: AOJu0YwNhkTaVwieNkFNmvOuvTKnktfyxmyBh5WSeE00c85ysBu3zZsx
 84d7BsbyCMglO37k1XNQKZ9wTsbwztsYd+ENLvQfrx55o1wV4MkLREcPHtArs4/CUscCVD4YMFz
 qX5J5Cu2MBH0Su+CGwLUl3/deNjC+Qxb5bmEigGBbgSn5zicA4Lxq96g1oBr1lHn9sDDEDlLzuq
 /Du57QCNUnMt6mwq98ACEC3Mt3bmZcvr4rFyUH/A==
X-Gm-Gg: ASbGnctUUlVRbtzWiMshZ87ByNHQ7OE30AceFKpozrRXOO4B/l/FVaJS9dMYrMf9nIv
 gIO96ScIwi/qNoVEKA/6D7ILZhBVkXiPB+C88eNgYS6hYxbclwzCbCfhQdPcGU8qqKbABuNtOKn
 MFD5RO+Dlrkawsaa54+ZlhrAOlizlJaSJxQsRkQtknQwS6ekfPpHdxkp9d5IwpVPdT0uwAG6WzP
 adjVdwv7VTEndRTN17Wkek/u8LjU80evUINyzrGwTAGffK+mxLYnOMRvcvQ8RyVLyS0irJy73/n
 fgG/H9sQ5DVqrZRIFnSIEXcoYcSWem5EYSIE7z5hymfLf/fEWOtFKC736S2pjuB+HK7FzyJ6d8w
 X
X-Received: by 2002:ac8:5e0e:0:b0:4e5:6c5e:430a with SMTP id
 d75a77b69052e-4ee58932460mr55183961cf.64.1763771220314; 
 Fri, 21 Nov 2025 16:27:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsAxxZ6lPhW7AKm6qQs9J/qNuICvvvyNfe+7ht35UB0QBm1LpAz08XIdOoie8r+fxf87hX9w==
X-Received: by 2002:ac8:5e0e:0:b0:4e5:6c5e:430a with SMTP id
 d75a77b69052e-4ee58932460mr55183611cf.64.1763771219702; 
 Fri, 21 Nov 2025 16:26:59 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:26:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>, qemu-stable <qemu-stable@nongnu.org>,
 Zhang Chen <zhangckid@gmail.com>
Subject: [PULL 1/9] migration: Fix transition to COLO state from precopy
Date: Fri, 21 Nov 2025 19:26:47 -0500
Message-ID: <20251122002656.687350-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

From: Li Zhijian <lizhijian@fujitsu.com>

Commit 4881411136 ("migration: Always set DEVICE state") set a new DEVICE
state before completed during migration, which broke the original transition
to COLO. The migration flow for precopy has changed to:
active -> pre-switchover -> device -> completed.

This patch updates the transition state to ensure that the Pre-COLO
state corresponds to DEVICE state correctly.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 4881411136 ("migration: Always set DEVICE state")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Tested-by: Zhang Chen <zhangckid@gmail.com>
Link: https://lore.kernel.org/r/20251104013606.1937764-1-lizhijian@fujitsu.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c2daab6bdd..1b2c02d7fa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3081,9 +3081,9 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
-    if (migrate_colo() && s->state == MIGRATION_STATUS_ACTIVE) {
+    if (migrate_colo() && s->state == MIGRATION_STATUS_DEVICE) {
         /* COLO does not support postcopy */
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
                           MIGRATION_STATUS_COLO);
     } else {
         migration_completion_end(s);
-- 
2.50.1


