Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71512C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk0jO-0001bU-H4; Thu, 07 Aug 2025 09:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1uk0jM-0001Yi-Eh
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:32:28 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1uk0jK-0005TD-9P
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=yasXubjeJHi0ZBoyjqjGFhQBPU2iz7M9i/oPJKlqIqI=; b=wudeg1BKPcwU
 D8iAYeug/h/9xm2UopWiGkgzNNDne7GPexXzXWV+c198oWfog25DmUgsTelluPV/XmLKE2tYlOV67
 yz/w/j+M+vz2C/0IVzhISJi82qI6LY9Zyaf2OTMUo9zPrlY19mfI/3VeiX622aGeStTbhWz0QHXax
 pdpsyAMkReuA7KrmbntD/DhfTOBVnUMil53Lk0+a93uyjdAxRlkHWS6TXYKbdyVJrHnc4mnLsXpY9
 pjA7AztNp6Kp8etQSE5fSVvnEAWpY1EphasKGrnHpzwVxGLJrWplSdR7ElmyYbrXyAsP3OxeMQK5C
 jvhGAgQvn1Df8Q9oaTPcpQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1uk0F7-000wcL-2z;
 Thu, 07 Aug 2025 15:32:20 +0200
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 1/1] qga: fix potentially not initialized nr_volumes in
 qga_vss_fsfreeze()
Date: Thu,  7 Aug 2025 15:32:21 +0200
Message-ID: <20250807133221.1135453-1-den@openvz.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In this function we could have this variable not initialized. If this
could be acceptable on error, the variable could be left not initialized
f.e. as follows:

void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
{
    ...
    if (mountpoints) {
        ...
        if (num_mount_points == 0) {
            /* If there is no valid mount points, just exit. */
            goto out;
        }
    }
    ...
    if (!mountpoints) {
        ...
        if (num_fixed_drives == 0) {
            goto out; /* If there is no fixed drive, just exit. */
        }
    }
    ...
}

Stay on safe side, initialize the variable at the beginning.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kostiantyn Kostiuk <kkostiuk@redhat.com>
CC: Michael Roth <michael.roth@amd.com>
---
 qga/vss-win32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qga/vss-win32.c b/qga/vss-win32.c
index f444a25a70..b272bfc782 100644
--- a/qga/vss-win32.c
+++ b/qga/vss-win32.c
@@ -157,6 +157,8 @@ void qga_vss_fsfreeze(int *nr_volume, bool freeze,
         .errp = errp,
     };
 
+    *nr_volume = 0;
+
     g_assert(errp);             /* requester.cpp requires it */
     func = (QGAVSSRequesterFunc)GetProcAddress(provider_lib, func_name);
     if (!func) {
-- 
2.45.2


