Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE31D58E6F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 07:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwxMd-0003an-4g; Mon, 02 Mar 2026 02:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vwxMb-0003a5-HR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 02:06:45 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vwxMY-0004LU-Ic
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 02:06:45 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D756A8076E;
 Mon, 02 Mar 2026 10:06:35 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:803e:400:8660:42cb:3b5a:b42a])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q6gOcX8AtKo0-50abgYHu; Mon, 02 Mar 2026 10:06:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772435195;
 bh=SeliCw1lb0DPkrqtY0VSJoCuI2uSNDoERU7yn7xRsR8=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=PcriPsr0MaqIO3+D4UEpuzr8AKTSpHk2o5yyq1Le9DcY+clIjpYc1hTSHVc4a8Gox
 FcmjYhNz10mNglE9v1gAAagElAcgRhAgoXiJKDYSHiA6FgXx2zgtp9whhcAJN5h7wo
 if6YjOpQKfXfEplVwb0hslrO/JY5t+CaSc9lV4Bo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v2] vmstate: fix subsection load name check
Date: Mon,  2 Mar 2026 12:06:26 +0500
Message-Id: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

When loading a subset, its name is checked for the parent prefix. The
following bug may occur here:

Let's say there is a vmstate named "virtio-blk", it has a subsection
named "virtio-blk/subsection", and it also has another vmstate named
"virtio" in the fields.
Then, during the migration, when trying to load this subsection for
"virtio", the prefix condition will pass for "virtio-blk/subsection" and
then the migration will break, because this vmstate does not have such a
subsection.

In other words, if a field inside vmstate1 is set via vmstate2 with a
name that is a prefix of the parent vmstate, then the field can "steal"
a subsection belonging to the parent state.

Looks like it happens because migration stream for "virtio-blk" looks
like this:

 [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]

"virtio-blk" contains "virtio" field, so migration stream is:

 [virtio-blk header] [virtio header] [virtio fields] [virtio
subsections] [virtio-blk subsections]

And when we load the subsections of the "virtio" device,
vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
this is his subsection. This is where we encounter an error.

Thus, the error occurs due to the fact that vmsd does not know how many
subsections it has when loading (this does not appear anywhere in the
migration stream), so it tries to load all the appropriate ones by
names.

Fix it by checking `/` at the end of idstr.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 migration/vmstate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..187f3861f2 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -613,7 +613,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
         char idstr[256], *idstr_ret;
-        int ret;
+        int ret, vmsd_name_len;
         uint8_t version_id, len, size;
         const VMStateDescription *sub_vmsd;
 
@@ -631,7 +631,10 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         memcpy(idstr, idstr_ret, size);
         idstr[size] = 0;
 
-        if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
+        vmsd_name_len = strlen(vmsd->name);
+        if (strncmp(vmsd->name, idstr, vmsd_name_len) != 0 ||
+            /* to avoid taking parent subsection here */
+            idstr[vmsd_name_len] != '/') {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
             /* it doesn't have a valid subsection name */
             return 0;
-- 
2.34.1


