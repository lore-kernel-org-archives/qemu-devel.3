Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4F2C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqTn-0005LY-L3; Tue, 25 Aug 2026 08:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wyqTl-0005LD-TD
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wyqTk-0005oW-6V
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787661729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tAuwrbquIP3Kxb5YoLyWvJc/gbwvQ3FjLeU93AzdOQs=;
 b=KVQcxJEfzJvLR3GIxD4+8BawW/IBPa9Gb3OW9azWg+svrXabs0XlYAd+RbK1C7teK3qaeE
 OSdD1mtKeR0yjOsLVswXRGJesIsosvP++AkNmEGxtq5m6a5HsjcS5xLC7PQVcIb5TfHi5Z
 AbCWFHaqQ9HyFr0KtYYwXBFJEVI1y7o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-j2cbq4mcN4GCURV5DoQ5fA-1; Tue, 25 Aug 2026 08:42:07 -0400
X-MC-Unique: j2cbq4mcN4GCURV5DoQ5fA-1
X-Mimecast-MFC-AGG-ID: j2cbq4mcN4GCURV5DoQ5fA_1787661726
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6f73d0f89so7609745ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787661726; x=1788266526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tAuwrbquIP3Kxb5YoLyWvJc/gbwvQ3FjLeU93AzdOQs=;
 b=X10lqCEbTi/48UoR4hfN2TeanAydvtNDHmJ7P0X7ZUTA7PQbNxKttSvn4hFteXlmzy
 VKxyTYVa4XZsUcOsnZJ+0sG3xKk7h6DjKMuV0fGR01cLYmrt1x2OsjaZGX589R3ae/eX
 tLEiBNrXk6GA0aw/Tw5qsNHGFAHpDRW5YS7Sk0daAZH5M1yysHjozVTmS81wnKPknP8B
 GPaa4LnhC8BEM5aZaJpubNcB+wsAZJkzVl2jNKRgNTqmPmkHZm5LnXWCzSbIJiuNh8Rq
 nI9sVxqYGo24JSMEtXE2otGacaKzb6J0Qk1HSjByw3S5jAMgrFLNWWRDJ5SY2OE9J3Rx
 frsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661726; x=1788266526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tAuwrbquIP3Kxb5YoLyWvJc/gbwvQ3FjLeU93AzdOQs=;
 b=NGFx3Vsd1G8p4bRN6CBoIPkLCsS4Q/NGVkzt66Sz65iv8W1o2BiHfYQdfFukfu76Lr
 Nwc6WqQUUf6CAeAABjNjrcJRrusbM7sHDyjG4Hy7j6wkDYvhLXI31MqJa4wAeFWdzfLy
 umQlh2SAj/CtSFuiVju0+T6rlAWd6UawlLYiZvNfEudDFqpiIo0GyPXwSGp5E5IDe+qK
 t9bR6/A2ES5DXeMihXJDZ5YE8p+A+4877ZT5ZD02tJipA8zg0wu/zonCrA7yBzPMFE+a
 2SdaEyDa323WoMI7O3II7xtKmjw49pcuHiarc2VCe08E8tTIPy02kQUsy4pEXeItpG3x
 ZIOA==
X-Gm-Message-State: AFuF++mUp8xEui775BgTa5t5q3HmpN5LRSwKeYgx+h8GLX26CwzXEN/j
 2GdyBmNergBLKKZDbO2ABR4loEkZXNRTLHzPAvORq62F3S2iOSAAX31adAy2HLokPvAIdiDl4qT
 m2nI+5b9qSsvCemuQD/dVn3yRxKEyWi826FalMrkI9jUf3e7e0aeAFSB4
X-Gm-Gg: AR+sD138GIlmp/1GXq7xFOEqtBxoeqR+SMS8W/cG4o58XWXpm61B5yvSH5qQNdCXmsq
 oC6ntAYJS3JwUe/xOG11a3f0Aww19xhmHBPJVeZfySU5OOFjL8vqxSbJa5rHc13xhssdKKkeEAH
 xrdk8wuDfMBk7BLkCrrwU7N/eDCtidoY+VNui6spk94QVkp0tg/5hkWd+VTZF4+3JOpJ0YVCNAF
 15CuCLgWywgFbL4VfAk0RirWk4M39eFRgTAXrJ5WvIK2iafQ1POZTWg91IH4J1sKKiB4mwwtaU6
 HUUTNNu+MH9DCWQlVfLkRvQUfxTgIW2Q/p8zNe4HvwRqoB/uhJZWnIyxUNa0OwvsD535YxpjZEo
 /8PBu9F5oYEdh5V0NuEJCbPwtfQDDki4oRw==
X-Received: by 2002:a17:903:32c3:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d6dcc248c5mr112795605ad.13.1787661726130; 
 Tue, 25 Aug 2026 05:42:06 -0700 (PDT)
X-Received: by 2002:a17:903:32c3:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d6dcc248c5mr112791275ad.13.1787661724159; 
 Tue, 25 Aug 2026 05:42:04 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.132.56])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d676761c1fsm26759265ad.16.2026.08.25.05.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:42:03 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>,
	Gerd Hoffman <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/vmlaunchupdate: do not clear control bits upon fw-cfg
 select op
Date: Tue, 25 Aug 2026 18:11:39 +0530
Message-ID: <20260825124139.6900-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The control bits define the behavior of the interface and clearing the bits
upon reading or select operation will break that behavior. For example, after
CTL_HOST_IGVM is set by the guest through a write and then subsequently, if the
guest tried to read back the values from the fw-cfg interface, the read would
clear CTL_HOST_IGVM. This would break restoring the host IGVM upon subsequent
reset.

Fixes: 30688c02a76e50e4 ("hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg interface support")
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/misc/vmlaunchupdate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/vmlaunchupdate.c b/hw/misc/vmlaunchupdate.c
index afa2d278ae..847d2d963f 100644
--- a/hw/misc/vmlaunchupdate.c
+++ b/hw/misc/vmlaunchupdate.c
@@ -41,7 +41,6 @@ static bool vmlaunchupdate_supported(void)
 static void init_vm_launch_update(VMLaunchUpdateState *s)
 {
     s->launch_update.capabilities = VM_LAUNCHUPDATE_FORMAT_IGVM;
-    s->launch_update.control = 0;
 
     if (s->disabled) {
         s->launch_update.control |= VM_LAUNCHUPDATE_CTL_DISABLE;
-- 
2.42.0


