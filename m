Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D9CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Lhv-0001TF-Nr; Mon, 29 Apr 2024 03:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Lht-0001RO-Mw
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:45:49 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Lhq-0001N3-Hz
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:45:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:290f:0:640:2b99:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4A68D60C97;
 Mon, 29 Apr 2024 10:45:36 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b739::1:30] (unknown
 [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZjK30T1IeW20-QsF2iRhh; Mon, 29 Apr 2024 10:45:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714376735;
 bh=ept533pZefmtPyNBxRHVJ1cw6ONie/Vts1QIK4R9WiQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Kv5H6PaZmX30HbKNelCwRcbp7VyVJgsBEQg1MH+gXMs5WzWfRW8NoUC9Qm6RarbJP
 gIOPJzt1fztKXcPQbZgIhOuZos0aOTZNIB2fMDwqYaONdma5dVrvqV9bW3VcvL3j3A
 XOEna7ZO/TmNXZNYjlqmMWhVbhYALNH3htQOr7Ek=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3b6fe3da-04df-4cd1-a428-4b5cae11510a@yandex-team.ru>
Date: Mon, 29 Apr 2024 10:45:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] qapi: introduce exit-on-error parameter for
 migrate-incoming
To: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
 <20240425181551.1465739-5-vsementsov@yandex-team.ru> <87r0etgp7e.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87r0etgp7e.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 25.04.24 23:30, Fabiano Rosas wrote:
>> @@ -797,13 +801,18 @@ fail:
>>                         MIGRATION_STATUS_FAILED);
>>       migration_incoming_state_destroy();
>>   
>> -    if (migrate_has_error(s)) {
>> -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> -            error_report_err(s->error);
>> +    if (mis->exit_on_error) {
>> +        if (migrate_has_error(s)) {
>> +            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> +                error_report_err(s->error);
> error_report_err(error_copy(s->error))
> 
> ...because later on you're reading from s->error at
> fill_destination_migration_info.

No, we immediately do exit() instead. That's just a preexisting behavior, moved into "if (mis->exit_on_error)"

-- 
Best regards,
Vladimir


