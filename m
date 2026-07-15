Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2F7C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjuhR-0004Nr-8f; Wed, 15 Jul 2026 04:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjuhQ-0004LQ-9X
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:10:36 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjuhO-00069x-AJ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:10:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 09C748082C;
 Wed, 15 Jul 2026 11:10:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c75::1:c] (unknown [2a02:6bf:8080:c75::1:c])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id WALpNY0X4Gk0-4KxoMm6l; Wed, 15 Jul 2026 11:10:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784103032;
 bh=3T8pkd7GijVKgduP/ehtxpp0qXt7S42C5sp6D51R1HY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Rk9QahDiLMbQl9SqVZMm+fVz7SU3l7DERjH4xMkq3ghp1VghaBKUiTJ4PR3K/abMu
 8JW5KSweKi3YJTykBX8tqTFdvZxPnrnUCK5eQLyF9q1N6d8cryU+aYBNp+6/IyYpCk
 1ftFguFIUl2enF4fwx3Dy1QnElOyQ/HGBIwqNUmA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d8da49c7-1d7a-44ee-88ea-0937d1a899cb@yandex-team.ru>
Date: Wed, 15 Jul 2026 11:10:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/15] net/tap: support local migration with virtio-net
To: jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-14-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260714154246.1242856-14-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 14.07.26 18:42, Vladimir Sementsov-Ogievskiy wrote:
> Support transferring of TAP state (including open fd).
> 
> Add new property "local-migration-supported", which defines
> whether local-migration is actually supported for this TAP device.
> Starting from 11.2 QEMU Machine Types it's enabled by default.
> 
> Note that local-migration (including migrating opened FDs
> through migration channel, which must be UNIX socket) is
> enabled by global "local" migration parameters. But individual
> devices may have additional options to enable/disable it
> per device.
> 
> The tricky thing is that we need to know whether to call open/connect in
> TAP initialization code, i.e. we need to know the value of migration
> parameter "local" when creating the TAP device.  For incoming migration,
> we can know only for TAP devices created with QMP after setting the
> migration parameter with QMP.
> 
> So the full picture is:
> 
> On source, to start outgoing "local" migration you need:
> 
>   - migration parameter "local" set to true
>   - "local-migration-supported" TAP option set to true (the
>     default, starting from 11.2 QEMU Machine Types)
> 
> If at least one of these options is not set, TAP backend
> doesn't participate in migration.
> 
> On target, things are more difficult:
> 
> Same, you need both "local" and "local-migration-supported"
> be set. And same, if one of them is not set, TAP backend
> is initialized as usual, and doesn't accept any incoming
> state.
> 
> Additionally, if you are going to set "local", it must be
> set before creating the TAP device. If TAP device created
> with "local" unset, it initializes as usual. If you enable
> "local" after it and start incoming migration, it will fail
> in .pre_load handler of TAP backend.
> 
> Moreover, there are interface restrictions: if you create TAP
> device when QEMU is in INCOMING state, and both "local"
> and "local-migration-supported" set, most of TAP options are
> not allowed, and script/downscript are required to be explicitly
> unset (set to "" or "no").
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> ---
>   net/tap.c     | 165 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   qapi/net.json |  22 ++++++-
>   2 files changed, 180 insertions(+), 7 deletions(-)


squash in, to mark it unstable:

diff --git a/net/tap.c b/net/tap.c
index 4162820bcee..250ae15acb7 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -558,7 +558,7 @@ static void tap_class_init(ObjectClass *klass, const void *data)
  
      vc->get_id = tap_vmstate_if_get_id;
  
-    object_class_property_add_bool(klass, "local-migration-supported",
+    object_class_property_add_bool(klass, "x-local-migration-supported",
                                     tap_get_local_migration_supported_prop,
                                     tap_set_local_migration_supported_prop);
  }
@@ -958,8 +958,8 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
  {
      TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
                                    name, fd, vnet_hdr, queue_index,
-                                  tap->has_local_migration_supported,
-                                  tap->local_migration_supported);
+                                  tap->has_x_local_migration_supported,
+                                  tap->x_local_migration_supported);
      bool sndbuf_required = tap->has_sndbuf;
      int sndbuf =
          (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -1130,7 +1130,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
          return -1;
      }
  
-    incoming_fds = tap->local_migration_supported && migrate_local() &&
+    incoming_fds = tap->x_local_migration_supported && migrate_local() &&
                     runstate_check(RUN_STATE_INMIGRATE);
  
      if (incoming_fds &&
@@ -1140,7 +1140,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
           !tap_is_explicit_no_script("downscript", tap->downscript))) {
          error_setg(errp, "Local incoming migration of TAP device (-incoming, "
                     "migration parameter @local is set, "
-                   "TAP parameter @local-migration-supported is set) "
+                   "TAP parameter @x-local-migration-supported is set) "
                     "is incompatible with "
                     "fd=, fds=, helper=, br=, ifname=, sndbuf= and vnet_hdr=, "
                     "and requires explicit empty script= and downscript=");
@@ -1168,8 +1168,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
      if (incoming_fds) {
          for (i = 0; i < queues; i++) {
              TAPState *s = new_tap(peer, "tap", name, i,
-                                  tap->has_local_migration_supported,
-                                  tap->local_migration_supported);
+                                  tap->has_x_local_migration_supported,
+                                  tap->x_local_migration_supported);
              qemu_set_info_str(&s->nc, "incoming");
  
              s->fd = -1;
diff --git a/qapi/net.json b/qapi/net.json
index d0d6e303b0d..e244cc62658 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -435,7 +435,7 @@
  # @poll-us: maximum number of microseconds that could be spent on busy
  #     polling for tap (since 2.7)
  #
-# @local-migration-supported: enable local migration for this TAP
+# @x-local-migration-supported: enable local migration for this TAP
  #     backend.  When set, local migration is enabled/disabled by
  #     migration parameter @local for this TAP backend.  When unset,
  #     migration parameter @local is ignored for this TAP backend.
@@ -447,13 +447,17 @@
  #     after creating TAP backend with @local-migration-supporeted
  #     parameter set) will simply fail.
  #     Moreover, when QEMU is in incoming migration state, migration
-#     parameter @local is set and @local-migration-supported is set,
+#     parameter @local is set and @x-local-migration-supported is set,
  #     the following options are not supported and must not be set:
  #     @fd, @fds, @helper, @br, @ifname, @sndbuf, @vnet_hdr.
  #     Additionally in this case @script and @downscipt must be
  #     explicitly disabled (empty strings or "no").
  #     (Since 11.2)
  #
+# Features:
+#
+# @unstable: Member @x-local-migration-supported is experimental.
+#
  # Since: 1.2
  ##
  { 'struct': 'NetdevTapOptions',
@@ -473,7 +477,8 @@
      '*vhostforce': 'bool',
      '*queues':     'uint32',
      '*poll-us':    'uint32',
-    '*local-migration-supported': 'bool' } }
+    '*x-local-migration-supported': {
+      'type': 'bool', 'features' : [ 'unstable'] } } }
  
  ##
  # @NetdevSocketOptions:
diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
index bcc0a60dfe9..5edf3f0fee2 100755
--- a/tests/functional/x86_64/test_tap_migration.py
+++ b/tests/functional/x86_64/test_tap_migration.py
@@ -329,7 +329,7 @@ def add_virtio_net(
              "queues": 4,
              "script": "no",
              "downscript": "no",
-            "local-migration-supported": local,
+            "x-local-migration-supported": local,
          }
  
          if not (local and incoming):



-- 
Best regards,
Vladimir

