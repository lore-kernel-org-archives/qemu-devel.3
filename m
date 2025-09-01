Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E9ACA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2eM-0000HM-T5; Mon, 01 Sep 2025 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eD-0000FG-Nw
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eA-00065u-S4
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujlFs9aXcF9f/wxxVzM/Vww2KayqUQ2rRaBGwtYJtpc=;
 b=bO04Oy+QeaWpgFc9JESC2Fo1chxjP0N9TppfWMBO4UKAusVoy/0wSrziWpepoKTtHqmdjO
 8sETBWrpdTOkSGB/RDP1Sp5/vG0H9QKe9ciQ+/Geg4J2gIm4ttNV6behNvTfR7Tk7PSVm2
 2FYQaS4jIOy4AJ4hg2YGwgx5u+uQkms=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-GlFzNgjvNuy4_wXpUhZI4Q-1; Mon,
 01 Sep 2025 07:24:24 -0400
X-MC-Unique: GlFzNgjvNuy4_wXpUhZI4Q-1
X-Mimecast-MFC-AGG-ID: GlFzNgjvNuy4_wXpUhZI4Q_1756725863
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37DD3195609D; Mon,  1 Sep 2025 11:24:23 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 952CE180029C; Mon,  1 Sep 2025 11:24:21 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 2/9] qga: fix potentially not initialized nr_volumes in
 qga_vss_fsfreeze()
Date: Mon,  1 Sep 2025 14:24:06 +0300
Message-ID: <20250901112413.114314-3-kkostiuk@redhat.com>
In-Reply-To: <20250901112413.114314-1-kkostiuk@redhat.com>
References: <20250901112413.114314-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

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
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250807133221.1135453-1-den@openvz.org
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
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
2.50.1


