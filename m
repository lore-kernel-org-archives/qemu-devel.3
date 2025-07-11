Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB7C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFGr-0003Sc-HW; Fri, 11 Jul 2025 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaF2Z-0006yq-FU
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaF2V-0005fX-3F
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752245267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcLf7RPBGZWS3JvRxki85GIWm+Flls34Eod+sx2lJL8=;
 b=R+YeTKbU3mv9lm9GvAnuoC+wOLo6hi79vXO8PdY6WTsCIWMYv880v+tdVvYCzSRsAVr5nB
 +Cvws34ndIaXqN+GQFOFhmIDNlrO/5EwXYVvnSXThTnDJBbGemeiFqgemtKmg5bneml/Oz
 D8dW6a6DvZbXJsTPOne/jHGF7UscWpQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-UaC8JkYBMWOePx-XHz1dcg-1; Fri,
 11 Jul 2025 10:47:44 -0400
X-MC-Unique: UaC8JkYBMWOePx-XHz1dcg-1
X-Mimecast-MFC-AGG-ID: UaC8JkYBMWOePx-XHz1dcg_1752245263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D93D1801207; Fri, 11 Jul 2025 14:47:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F385219560A3; Fri, 11 Jul 2025 14:47:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56EDB21E6A27; Fri, 11 Jul 2025 16:47:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>
Subject: Re: [PATCH V4 2/3] python: use qom-list-get
In-Reply-To: <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 10 Jul 2025 09:24:53 -0700")
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
Date: Fri, 11 Jul 2025 16:47:40 +0200
Message-ID: <871pqmwzqr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Use qom-list-get to speed up the qom-tree command.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Quick test...  Differences in output before and after match expectations
(see appended diff).

New version:

    real    0m0.446s
    user    0m0.062s
    sys     0m0.017s

Old version barfs a stack backtrace (appended), and is ~18x slower:

    real    0m8.176s
    user    0m0.395s
    sys     0m0.126s

Did you see the stack backtrace, too?

Regardless
Acked-by: Markus Armbruster <armbru@redhat.com>



$ diff old new
59c59
<   rtc-time: {'tm_year': 125, 'tm_sec': 24, 'tm_hour': 14, 'tm_min': 39, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
---
>   rtc-time: {'tm_year': 125, 'tm_sec': 28, 'tm_hour': 14, 'tm_min': 40, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
486c486
<   date: {'tm_year': 125, 'tm_sec': 25, 'tm_hour': 14, 'tm_min': 39, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
---
>   date: {'tm_year': 125, 'tm_sec': 28, 'tm_hour': 14, 'tm_min': 40, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
832c832
<   legacy-memory: <EXCEPTION: Property 'qemu64-x86_64-cpu.legacy-memory' is not readable> (str)
---
>   legacy-memory: <EXCEPTION: property could not be read> (str)
1109c1109
<   crash-information: <EXCEPTION: No crash occurred> (GuestPanicInformation)
---
>   crash-information: <EXCEPTION: property could not be read> (GuestPanicInformation)
1554c1554
<   legacy-i8042: <EXCEPTION: Property 'vmmouse.legacy-i8042' is not readable> (str)
---
>   legacy-i8042: <EXCEPTION: property could not be read> (str)
2436c2436
<   legacy-iothread: <EXCEPTION: Property 'virtio-blk-device.legacy-iothread' is not readable> (str)
---
>   legacy-iothread: <EXCEPTION: property could not be read> (str)
2493c2493
<   legacy-iothread: <EXCEPTION: Property 'virtio-blk-device.legacy-iothread' is not readable> (str)
---
>   legacy-iothread: <EXCEPTION: property could not be read> (str)


Exception ignored in: <function QEMUMonitorProtocol.__del__ at 0x7fcfcd080d60>
Traceback (most recent call last):
  File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py", line 310, in __del__
    self.close()
  File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py", line 281, in close
    self._sync(
  File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py", line 102, in _sync
    return self._aloop.run_until_complete(
  File "/usr/lib64/python3.13/asyncio/base_events.py", line 719, in run_until_complete
    return future.result()
  File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_for
    return await fut
  File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py", line 399, in disconnect
    await self._wait_disconnect()
  File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py", line 719, in _wait_disconnect
    await all_defined_tasks  # Raise Exceptions from the bottom half.
  File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py", line 870, in _bh_loop_forever
    await async_fn()
RuntimeError: cannot reuse already awaited coroutine


