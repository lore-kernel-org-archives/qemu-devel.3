Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5EEC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKnA-0007Ws-JN; Tue, 04 Aug 2026 15:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKn9-0007Sl-0P
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKn7-0005Dm-GZ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+5DIBFkHj3MpvRH+EMQbVA7d1EFloNPTRZrCzMHzlM=;
 b=DeP+dib5dyx6p4gr8KYpycrgirLWzICuL/RhIjm8Pn6EEofSM0RaJH2tXi1OvhvjoNINx4
 rNwwmHfPcUazrGGivNBPIQdnmBRNcK5KI7DMbYAheLv2RyfdqIWVWbQUiU8HPHe15GtKR7
 Lhe2Z2ecxUgz7HxtjpyyGkwF1sZjUuE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-rwx_Ch1JNR2GoY7FVw2Xww-1; Tue,
 04 Aug 2026 15:27:07 -0400
X-MC-Unique: rwx_Ch1JNR2GoY7FVw2Xww-1
X-Mimecast-MFC-AGG-ID: rwx_Ch1JNR2GoY7FVw2Xww_1785871627
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCCFE19560A1
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2026 19:27:06 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B1FA1956087; Tue,  4 Aug 2026 19:27:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:56 +0400
Subject: [GIT PULL v2 9/9] qapi/dump: add allowed-by-guest feature to win-dmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-9-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MW7OVd74nIo16HSj5Bdl5yYs6LiN+vBhp4QxuK4O7gg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzUKC+0tlJewrUwimVj1MsxjSR5lz1y32TEU
 qKbrsAjdBWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI81AAKCRDa6OEJdZac
 5X1bD/kBAat/kP6dRvFQWmW4yzLmFD/tn3HaMBtEEoTQtaJiSUCHQrQVfFocR+xvirEtoqChi+E
 iqB25JLTtG5nw4amuCplGwniGHgrur7Mb7P6RC9VByK+Mgiox1lhI1SX2f30sAcOdNA8e+8vcIf
 XgxiSueojWPEaKsQqZxLP7lFgQPlVbHG4yoKPsBlLrOw7lKgMdDkbkr8ZfW0OU3FG/x+YZmI06v
 uEdVI16auVD4xX8qLKG78Ww+Pi0mjJ+k0VkTq3DPRkTCtNJk3r0rvZKyysJi+QLJSC26K3+Z7Dp
 HIQpkUL8nzDwIsFhufDaBufcSL7a5xnQssS6Nj6RsjTCuzMkUni1UOtCXM5mGM7Uwwa1OfX3NBW
 fbUvv3SGqr8c4TjjZ++sNTbubl83Qq4Ftx/Qo1003KP92cKYQI0SOAWgGxng0r4NUWCALLqhrJq
 cEn1r3LNXcmZ7YaS4Owx8PBWs2oNDjLJQpNWCEnkIcATc515O9jrL+Mw2QErdTnygW/EktrqvnA
 i+SXstovAJstVK9LYdFoQEDkI3/+ioRo412TX6uMBH8fOnwmNXIRoCiIEthE+5RGAthvBRvGZLZ
 BrevtIoQYQOhAw8HGI/nDOjPFgbx9CUnQpw2kPZGqPjMIhP406kcieSMVIUjlKCMAljNPBdFT2U
 hca1E6Ev3YLID+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

Commit 1c0e259c5a35 ("dump: make win_dump_available() check vmcoreinfo
for a Windows dump header") changed two things in a way that is visible
to QMP clients but not to introspection:
query-dump-guest-memory-capability now lists win-dmp only for a guest
that has published a Windows dump header through the vmcoreinfo device,
and dump-guest-memory, which shares win_dump_available(), rejects the
format otherwise. Before that, both accepted win-dmp on any x86
machine.

A client that wants to select win-dmp automatically therefore cannot
trust the capability query on its own: on an older QEMU it reports
win-dmp for every x86 guest, Linux ones included, where the resulting
dump is useless. libvirt ran into exactly this while picking a format
for on_crash and watchdog triggered dumps, and has no way to tell the
two behaviours apart.

Add an 'allowed-by-guest' feature to the win-dmp member of
DumpGuestMemoryFormat so the fixed behaviour becomes discoverable.
DumpGuestMemoryFormat is reachable from both
query-dump-guest-memory-capability's return type and
dump-guest-memory's arguments, so a single flag covers both halves of
the change. Where the feature is absent, a reported win-dmp says
nothing about the guest, and a client that needs the dump to be
loadable afterwards should fall back to elf.

CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260731155001.1204103-1-den@openvz.org>
---
 qapi/dump.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 726b5208703c..690f3963fe15 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -38,6 +38,13 @@
 # @win-dmp: Windows full crashdump format, can be used instead of ELF
 #     converting (since 2.13)
 #
+# Features:
+#
+# @allowed-by-guest: If present, @win-dmp is listed by
+#     `query-dump-guest-memory-capability`, and accepted by
+#     `dump-guest-memory`, only when the guest has published a Windows
+#     dump header through the vmcoreinfo device (since 11.1)
+#
 # Since: 2.0
 ##
 { 'enum': 'DumpGuestMemoryFormat',
@@ -45,7 +52,7 @@
       'elf',
       'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
       'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
-      'win-dmp' ] }
+      { 'name': 'win-dmp', 'features': ['allowed-by-guest'] } ] }
 
 ##
 # @dump-guest-memory:

-- 
2.55.0


