Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9E0103E301
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dFv-0008Bj-7W; Thu, 12 Mar 2026 06:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w0dFc-00089P-4q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:26:45 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w0dFZ-0007pn-8i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:26:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A26D6C01F7;
 Thu, 12 Mar 2026 13:26:33 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:d92::1:36])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QQEsZG0AuW20-xaLKK0PX; Thu, 12 Mar 2026 13:26:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773311192;
 bh=eyWrAUGpnm8lk1oCNSnd46J8JAn0h8TRHhlxMcluFrg=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=0VtVKq6ZM9I+mwwSxktTm3VZzwY6VRv4anTVRe3VmnGSTS3gEl5sZMPk4B4Dv+KB5
 6lg5eUfkhr+g3VO/lJZCHGmIuGJbQSHIswN8LlfP8YpXJix80Yo1b8CXTZGDjNVB6n
 984FRNVvEst8i6SO/X868tCXaXTBv8cV4iRovMMU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v3] vmstate: fix subsection load name check
Date: Thu, 12 Mar 2026 15:26:26 +0500
Message-Id: <20260312102626.891359-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

To fix this issue, we call vmstate_get_subsection() and, in case of
fail, ignore it, pop the VMSD stack and will try to define this
subsection for outer VMSD

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 migration/vmstate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..8f3a69c26e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -639,9 +639,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
-            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
-                       idstr, vmsd->name);
-            return -ENOENT;
+            return 0;
         }
         qemu_file_skip(f, 1); /* subsection */
         qemu_file_skip(f, 1); /* len */
-- 
2.34.1


