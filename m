Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FD4C44518
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQs3-000499-LT; Thu, 16 Jul 2026 14:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkQrq-00046d-2i
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:31:30 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkQrn-0005c4-DL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:31:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 1749BC04DA;
 Thu, 16 Jul 2026 21:31:22 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id KVW2eV5WFeA0-mOHXQvJd; Thu, 16 Jul 2026 21:31:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784226681;
 bh=RPwNsPFdObdDEv2IabH4qv8Qx/wv1+DwH4tGo+CSvvE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BWmF1Fk/w7INh4qj0P88uIGPqSmovyV6U3VRRqRKrAPDxRNVfHKUToQWSHT3F4o4N
 tIyjsExGs1zL+mGkg0atm8ZnBH3UmZuj8+rIguHq9eVD/NZtkeupIKuzrW3sFB5cMC
 dzkSmUHvBXB3vkkJQoeAD0GawAAifasof5AW9jRg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a25f11c4-8410-42ef-856c-460b06c3d61c@yandex-team.ru>
Date: Thu, 16 Jul 2026 21:31:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 12/15] net/tap: disable read polling for stopped VM
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "raphael.s.norwitz@gmail.com"
 <raphael.s.norwitz@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "berrange@redhat.com" <berrange@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "mark.caveayland@nutanix.com" <mark.caveayland@nutanix.com>,
 Jason Wang <jasowangio@gmail.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-13-vsementsov@yandex-team.ru>
 <E62E987C-8A7C-4E76-ABC2-7816B3955B96@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <E62E987C-8A7C-4E76-ABC2-7816B3955B96@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 15.07.26 17:51, Chaney, Ben wrote:
> 
> ﻿On 7/14/26, 11:44 AM, "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
> 
>> +static void tap_vm_state_change(void *opaque, bool running, RunState state)
>> +{
>> + TAPState *s = opaque;
>> +
>> + if (running) {
>> + if (s->read_poll_detached) {
>> + tap_read_poll(s, true);
>> + s->read_poll_detached = false;
>> + }
>> + } else if (state == RUN_STATE_FINISH_MIGRATE) {
>> + if (s->read_poll) {
>> + s->read_poll_detached = true;
>> + tap_read_poll(s, false);
>> + }
>> + }
>> +}
>> +
> 
> tap_read_poll is called in a few other places. Is it necessary to update read_poll_detached there as well?
> 
> I'm not sure that it is, I'm trying to wrap my head around any possible ordering issues and it isn't obvious to me one way or the other.
> 

Good question!

Hm. The whole patch is about source QEMU process, to not poll, when we expect that target is already handle packets in TAP.

Let's go through calls to tap_read_poll (except for tap_vm_state_change):

1. tap_send_completed() -> tap_read_poll(true). Called asynchronously from packet sending (to guest) code. Actually, that may be a problem. If callback comes when
we are alredy switched to FINISH_MIGRATE, it breaks the logic, need to fix.

2. tap_send() -> tap_read_poll(false). It's safe. But it may break "if (s->read_poll)" of this patch, if somehow interleave with sate change (not sure it possible, but better to fix)

3. tap_cleanup() -> tap_read_poll(false) - safe

4. tap_post_load() -> tap_read_poll(true) - safe, it's not about source QEMU

5. net_tap_fd_init() -> tap_read_poll(true) - safe, it's on tap creation

6. through tap_poll() from frontend code, when transfer control to vhost.

--

I'll remake this patch. Better idea: modify tap_read_poll() itself:

--- a/net/tap.c
+++ b/net/tap.c
@@ -100,7 +100,7 @@ struct TAPState {
      Notifier exit;

      int queue_index;
-    bool read_poll_detached;
+    bool enable_poll_on_resume;
      VMChangeStateEntry *vmstate;
      bool local_migration_supported;
  };
@@ -157,6 +157,10 @@ static void tap_update_fd_handler(TAPState *s)

  static void tap_read_poll(TAPState *s, bool enable)
  {
+    if (enable && runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        s->enable_poll_on_resume = true;
+        return;
+    }
      s->read_poll = enable;
      tap_update_fd_handler(s);
  }
@@ -166,13 +170,13 @@ static void tap_vm_state_change(void *opaque, bool running, RunState state)
      TAPState *s = opaque;

      if (running) {
-        if (s->read_poll_detached) {
+        if (s->enable_poll_on_resume) {
              tap_read_poll(s, true);
-            s->read_poll_detached = false;
+            s->enable_poll_on_resume = false;
          }
      } else if (state == RUN_STATE_FINISH_MIGRATE) {
          if (s->read_poll) {
-            s->read_poll_detached = true;
+            s->enable_poll_on_resume = true;
              tap_read_poll(s, false);
          }
      }
@@ -964,7 +968,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
      int sndbuf =
          (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;

-    s->read_poll_detached = false;
+    s->enable_poll_on_resume = false;
      s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);

      if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&

-- 
Best regards,
Vladimir

