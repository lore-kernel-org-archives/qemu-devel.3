Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72330C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9U-0002vn-62; Fri, 11 Sep 2026 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x96-0002Ft-SN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x95-000878-C8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnAlDO2QjRLH3bD583YkEJaCzSVpdg74aK2h0Y1Pq7U=;
 b=KqdLIbTgY+VbgyiGuhBiemQfq5HR6Oc8D3TvhPiHisfSOZkTJrpyckr35OUUmpz4YgJw9a
 Bshj+tkpihwTe9hye+XDqnQT/0MoghwPThQOAKe1BMoq7ZJYakl2ZQjymFF8o+O808Yrqg
 Zaz7/h+1FzraKGZFgD6x0jZKTLiMrqk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-CXUgr5B8Pvu0XCGpQplybQ-1; Fri, 11 Sep 2026 05:02:05 -0400
X-MC-Unique: CXUgr5B8Pvu0XCGpQplybQ-1
X-Mimecast-MFC-AGG-ID: CXUgr5B8Pvu0XCGpQplybQ_1789117324
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-484337a63bbso362022f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117324; x=1789722124; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qnAlDO2QjRLH3bD583YkEJaCzSVpdg74aK2h0Y1Pq7U=;
 b=mSeSdlnRiB7EXWLYXJI8w/9sxgfgQ3RjefUJKbcu2jAVDPTbIUlZ7UBEbgH0U6NtE/
 wOABm6nw1PAT2vlzec9SQ7wJbfWk1mXnU5dbPKM7Lt4/LaZOsdFdyhPiTPre9A+R8GAf
 rtO8pNZ4qHWPLrDTKbpngTsSxEJLth7TN7ea/Moe+45idbv8LX27Von0QvA9VgUGfcMj
 JPD9S83lqlqdP/iK7O1Pj7aA8k/fZ4LBpBdMYmTo6sJHcRm7M8QrFakq/evacHOuY9iJ
 3oXhyMpjFk+zCqHYRv9LxFDlY/j+PuSOVOMw3JLOEcqmQtmbIFcL6CkkpymRqCiLvhN0
 mvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117324; x=1789722124;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qnAlDO2QjRLH3bD583YkEJaCzSVpdg74aK2h0Y1Pq7U=;
 b=k5yMttojNQky6ORBySRN4nW5JWJ+axcmL48gDa/bGj1SIXAoFEJQEp5KcFllM0fxSC
 8+yFkOOjfiHlw6LJwWPyfF5HqyD8jIXES9r0UO5mIH4jUmbs/hRxgd2O6NdBWrmO+Ao6
 bGpugPtx4faP+Nh5WnnX1mb/o1RsJCn4KWhMUhFyXRwhMP+z5O+RMFT035Ro8TYsWXe/
 Pim3eO0QKMPf84xQD4xNfgSx9wLeYMyJe3nBYlImynjZEvtzOe6d7bukkFF13NRG4CiX
 BAjJdAc3lkwniQjLZTnaPISMeqJfbLUKiIMWnMJhG5cGOhUrIs8Aq+AUetBBv0UcXoG+
 gl9w==
X-Gm-Message-State: AFuF++lIEqkj3iCR4xvzuoJl6x2wp/UDwisTSfReoro2n7pJ1sipEv1a
 Z1uGjkKCo1l8tTky5NfMyXnkxe+f3RGM4FyQlizocSP2NGCi/HKCCid//PCAFbP0RILmN0YbDTY
 TC20+X0TkzF+q2nht3cqutJUZ+LGYR6yjSl3zWLi/tECNXMAUh45B54NwhLhJQfVK1PadW+p4Ok
 7S21q80btDSKkayNH+itkyZ7c1wIhWOHWTKg==
X-Gm-Gg: AYBFou3+Ix+1PZot/xWeRZ854uBoeepLCiYUiDAmIi/0YgRfu5D0F+6zIUazEB52X+w
 hPG6aj+Z0YZL8I7fLYWSXgQVJDqrVagBqRv7fF55NmcQRYCA0xna0omb1HvDOtHbue6ZLdCHqPg
 YHL8F35FY0BbPGzROFGsqFx048FhOrdZEEXXoNnVRtdCKWA40bzoOc+KUj8/Yxen+NoVWtpRB95
 X8fpoaIvG8vrziOG76nVloNTClixb7dGsHW9PiJMIxRO+9Py8ulG+/tIPTMoull0mJlvm2oPL+M
 m/AGjDIF20wlJEKoohw1ZLxubRG/HOUizNvptjkQZGiB0emdJxlwJG8AiJMFtJXSaWtW5WN0Exy
 yw2NqSmDeEI864YUr+ZrUVzs=
X-Received: by 2002:a05:6000:4304:b0:486:f040:2e0e with SMTP id
 ffacd0b85a97d-486f04030f9mr1866658f8f.42.1789117323693; 
 Fri, 11 Sep 2026 02:02:03 -0700 (PDT)
X-Received: by 2002:a05:6000:4304:b0:486:f040:2e0e with SMTP id
 ffacd0b85a97d-486f04030f9mr1866599f8f.42.1789117323058; 
 Fri, 11 Sep 2026 02:02:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm4704823f8f.27.2026.09.11.02.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:02 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL v2 18/75] migration/fd: fix fd leak when fd is not valid for
 migration
Message-ID: <8cd740302600dded57a9509eb8e9d408229d0d24.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Both fd_connect_outgoing() and fd_connect_incoming() own the file
descriptor after resolving it from the monitor, but forget to close
it when migration_fd_valid() check fails.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Fixes: f1fcc1c101 ("migration: Remove fd: support on files")
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-11-vsementsov@yandex-team.ru>
---
 migration/fd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/fd.c b/migration/fd.c
index f05f95992f..02b39b150e 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -62,6 +62,7 @@ QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
     if (!migration_fd_valid(fd)) {
         error_setg(errp, "fd: migration to a file is not supported."
                    " Use file: instead.");
+        close(fd);
         goto out;
     }
 
@@ -97,6 +98,7 @@ void fd_connect_incoming(const char *fdname, Error **errp)
     if (!migration_fd_valid(fd)) {
         error_setg(errp, "fd: migration to a file is not supported."
                    " Use file: instead.");
+        close(fd);
         return;
     }
 
-- 
MST


