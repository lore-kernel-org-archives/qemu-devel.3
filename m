Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7FCC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wTb-00070V-25; Fri, 11 Sep 2026 04:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x4wTV-0006wP-GS
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:19:09 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x4wTQ-0008EE-GH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:19:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:2219:0:640:5d89:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 88F3D8079A;
 Fri, 11 Sep 2026 11:18:57 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:4d::1:17] (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id tILW3DBf94Y0-4z3B5OYF; Fri, 11 Sep 2026 11:18:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789114737;
 bh=UETXf7l7aaEzMO9kYOsfG8kmGSDgFJmKjM7H5hoGnJM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SJIKoo+axJTBKEnwIUmiPHNtlDReOaOOLx29cOHC+AQhgzSbSnFTT22bvvKwflJia
 jZ7Ro+FF0z97gUnmlSyZLesDt8sEZCguRL819ErCLk6k5sODHcthz6va4LrJjnLbl4
 fGJ79wehzeOZX6T5NOYbMTVb4/eRmUBDfGQ58kfs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <791fcee1-2bdd-4bbe-a5bc-d755b2e457e8@yandex-team.ru>
Date: Fri, 11 Sep 2026 11:18:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] runstate: make runstate actions private
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 alejandro.j.jimenez@oracle.com
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
 <20260904205749.510493-7-vsementsov@yandex-team.ru>
 <2f415ee0-373f-4879-b472-336540b7b7af@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <2f415ee0-373f-4879-b472-336540b7b7af@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08.09.26 10:28, Akihiko Odaki wrote:
> On 2026/09/05 5:57, Vladimir Sementsov-Ogievskiy wrote:
>> The action variables are now used only within system/runstate.c.
>> Move them and qmp_set_action() there, make the variables static,
>> and remove runstate-action.c and its header.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   MAINTAINERS                      |  1 -
>>   include/system/runstate-action.h | 19 -------------
>>   monitor/qmp-cmds.c               |  1 -
>>   system/meson.build               |  1 -
>>   system/runstate-action.c         | 46 --------------------------------
>>   system/runstate.c                | 34 ++++++++++++++++++++++-
>>   system/vl.c                      |  2 +-
>>   ui/cocoa.m                       |  1 -
>>   ui/sdl2.c                        |  1 -
>>   9 files changed, 34 insertions(+), 72 deletions(-)
>>   delete mode 100644 include/system/runstate-action.h
>>   delete mode 100644 system/runstate-action.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7183babd6aa..2cee4c71b7a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3514,7 +3514,6 @@ M: Paolo Bonzini <pbonzini@redhat.com>
>>   S: Maintained
>>   F: include/qemu/main-loop.h
>>   F: include/system/runstate.h
>> -F: include/system/runstate-action.h
>>   F: util/main-loop.c
>>   F: util/qemu-timer*.c
>>   F: system/vl.c
>> diff --git a/include/system/runstate-action.h b/include/system/runstate-action.h
>> deleted file mode 100644
>> index db4e3099ae5..00000000000
>> --- a/include/system/runstate-action.h
>> +++ /dev/null
>> @@ -1,19 +0,0 @@
>> -/*
>> - * Copyright (c) 2020 Oracle and/or its affiliates.
>> - *
>> - * This work is licensed under the terms of the GNU GPL, version 2.
>> - * See the COPYING file in the top-level directory.
>> - *
>> - */
>> -
>> -#ifndef RUNSTATE_ACTION_H
>> -#define RUNSTATE_ACTION_H
>> -
>> -#include "qapi/qapi-commands-run-state.h"
>> -
>> -/* in system/runstate-action.c */
>> -extern RebootAction reboot_action;
>> -extern ShutdownAction shutdown_action;
>> -extern PanicAction panic_action;
>> -
>> -#endif /* RUNSTATE_ACTION_H */
>> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
>> index 6d0ba75ff16..f89237eb238 100644
>> --- a/monitor/qmp-cmds.c
>> +++ b/monitor/qmp-cmds.c
>> @@ -22,7 +22,6 @@
>>   #include "system/system.h"
>>   #include "system/kvm.h"
>>   #include "system/runstate.h"
>> -#include "system/runstate-action.h"
>>   #include "system/block-backend.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-init-commands.h"
>> diff --git a/system/meson.build b/system/meson.build
>> index 41e2e4a292d..dd4622ae08c 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -22,7 +22,6 @@ system_ss.add(files(
>>     'qdev-monitor.c',
>>     'qtest.c',
>>     'rtc.c',
>> -  'runstate-action.c',
>>     'runstate.c',
>>     'watchpoint.c',
>>   ))
>> diff --git a/system/runstate-action.c b/system/runstate-action.c
>> deleted file mode 100644
>> index f912bc837f2..00000000000
>> --- a/system/runstate-action.c
>> +++ /dev/null
>> @@ -1,46 +0,0 @@
>> -/*
>> - * Copyright (c) 2020 Oracle and/or its affiliates.
>> - *
>> - * This work is licensed under the terms of the GNU GPL, version 2.
>> - * See the COPYING file in the top-level directory.
>> - *
>> - */
>> -
>> -#include "qemu/osdep.h"
>> -#include "system/runstate-action.h"
>> -#include "system/watchdog.h"
>> -#include "qemu/config-file.h"
>> -#include "qapi/error.h"
>> -#include "qemu/option_int.h"
>> -
>> -RebootAction reboot_action = REBOOT_ACTION_RESET;
>> -ShutdownAction shutdown_action = SHUTDOWN_ACTION_POWEROFF;
>> -PanicAction panic_action = PANIC_ACTION_SHUTDOWN;
>> -
>> -/*
>> - * Receives actions to be applied for specific guest events
>> - * and sets the internal state as requested.
>> - */
>> -void qmp_set_action(bool has_reboot, RebootAction reboot,
>> -                    bool has_shutdown, ShutdownAction shutdown,
>> -                    bool has_panic, PanicAction panic,
>> -                    bool has_watchdog, WatchdogAction watchdog,
>> -                    Error **errp)
>> -{
>> -    if (has_reboot) {
>> -        reboot_action = reboot;
>> -    }
>> -
>> -    if (has_panic) {
>> -        panic_action = panic;
>> -    }
>> -
>> -    if (has_watchdog) {
>> -        qmp_watchdog_set_action(watchdog, errp);
>> -    }
>> -
>> -    /* Process shutdown last, in case the panic action needs to be altered */
>> -    if (has_shutdown) {
>> -        shutdown_action = shutdown;
>> -    }
>> -}
>> diff --git a/system/runstate.c b/system/runstate.c
>> index 5d10ff0df99..a5f16da975e 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -2,6 +2,7 @@
>>    * QEMU main system emulation loop
>>    *
>>    * Copyright (c) 2003-2020 QEMU contributors
>> + * Copyright (c) 2020 Oracle and/or its affiliates.
> 
> The deleted runstate-action.c explicitly licensed qmp_set_action() under GPLv2. The move retains only Oracle’s copyright line under the destination’s MIT header. I guess noting that this file is licensed under GPLv2 is the right thing to do here.


Hmm.. Funny thing.

To move qmp_set_action() we need an ack from Oracle. Alejandro could you ack it?

To move the whole system/runstate.c into GPLv2, we need and ack from "Copyright (c) 2003-2020 QEMU contributors", which is a lot more difficult.

To be honest, I don't believe, that qmp_set_action() worth worrying. It's a small simple function. I think, we often move functions from one license to another, and don't even look at them. This patch is noticeable because it removes the whole file, and license is visible in the diff.

Any opinions?

-- 
Best regards,
Vladimir

