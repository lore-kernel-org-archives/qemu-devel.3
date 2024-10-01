Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A2CEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdYp-0001db-Ai; Tue, 01 Oct 2024 10:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svdYn-0001Wj-2m; Tue, 01 Oct 2024 10:09:05 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svdYe-00023t-As; Tue, 01 Oct 2024 10:09:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a3:0:640:33b5:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 21F976003B;
 Tue,  1 Oct 2024 12:54:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5sWnJw1Iga60-O0dn97Jg; Tue, 01 Oct 2024 12:54:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727776446;
 bh=uLNJt9cmEOePQhreo7TH0vvPWBVritTAxkgy9K7Bd5k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Rny1Cn5W1oKcWxueGsYbBPsLEuOL89UPUaySYLafHlXLFMGL0RweAMYkE4l6f/tQn
 wTmMhsWwIWY+aPb3NQbLHnN+Ik5PcFx7Uss+k+p27Mj75v7a94AlWKBkNasZCGTlIh
 brD3X8krMu0roSluQpgE3bFahnu+W5Kfr67fruF4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <29cd78e2-be26-41a4-92c4-a327efe76177@yandex-team.ru>
Date: Tue, 1 Oct 2024 12:54:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report][RFC PATCH 1/1] block: fix failing assert on paused
 VM migration
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eesposit@redhat.com, den@virtuozzo.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
 <20240924125611.664315-2-andrey.drobyshev@virtuozzo.com>
 <6fb3340a-f685-422f-acaf-ad968e854847@yandex-team.ru>
 <0faf2b77-0cda-4823-8c3f-986be7d6964c@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <0faf2b77-0cda-4823-8c3f-986be7d6964c@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 30.09.24 17:07, Andrey Drobyshev wrote:
> On 9/30/24 12:25 PM, Vladimir Sementsov-Ogievskiy wrote:
>> [add migration maintainers]
>>
>> On 24.09.24 15:56, Andrey Drobyshev wrote:
>>> [...]
>>
>> I doubt that this a correct way to go.
>>
>> As far as I understand, "inactive" actually means that "storage is not
>> belong to qemu, but to someone else (another qemu process for example),
>> and may be changed transparently". In turn this means that Qemu should
>> do nothing with inactive disks. So the problem is that nobody called
>> bdrv_activate_all on target, and we shouldn't ignore that.
>>
>> Hmm, I see in process_incoming_migration_bh() we do call
>> bdrv_activate_all(), but only in some scenarios. May be, the condition
>> should be less strict here.
>>
>> Why we need any condition here at all? Don't we want to activate
>> block-layer on target after migration anyway?
>>
> 
> Hmm I'm not sure about the unconditional activation, since we at least
> have to honor LATE_BLOCK_ACTIVATE cap if it's set (and probably delay it
> in such a case).  In current libvirt upstream I see such code:
> 
>> /* Migration capabilities which should always be enabled as long as they
>>   * are supported by QEMU. If the capability is supposed to be enabled on both
>>   * sides of migration, it won't be enabled unless both sides support it.
>>   */
>> static const qemuMigrationParamsAlwaysOnItem qemuMigrationParamsAlwaysOn[] = {
>>      {QEMU_MIGRATION_CAP_PAUSE_BEFORE_SWITCHOVER,
>>       QEMU_MIGRATION_SOURCE},
>>                                                                                  
>>      {QEMU_MIGRATION_CAP_LATE_BLOCK_ACTIVATE,
>>       QEMU_MIGRATION_DESTINATION},
>> };
> 
> which means that libvirt always wants LATE_BLOCK_ACTIVATE to be set.
> 
> The code from process_incoming_migration_bh() you're referring to:
> 
>>      /* If capability late_block_activate is set:
>>       * Only fire up the block code now if we're going to restart the
>>       * VM, else 'cont' will do it.
>>       * This causes file locking to happen; so we don't want it to happen
>>       * unless we really are starting the VM.
>>       */
>>      if (!migrate_late_block_activate() ||
>>           (autostart && (!global_state_received() ||
>>              runstate_is_live(global_state_get_runstate())))) {
>>          /* Make sure all file formats throw away their mutable metadata.
>>           * If we get an error here, just don't restart the VM yet. */
>>          bdrv_activate_all(&local_err);
>>          if (local_err) {
>>              error_report_err(local_err);
>>              local_err = NULL;
>>              autostart = false;
>>          }
>>      }
> 
> It states explicitly that we're either going to start VM right at this
> point if (autostart == true), or we wait till "cont" command happens.
> None of this is going to happen if we start another migration while
> still being in PAUSED state.  So I think it seems reasonable to take
> such case into account.  For instance, this patch does prevent the crash:
> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index ae2be31557..3222f6745b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -733,7 +733,8 @@ static void process_incoming_migration_bh(void *opaque)
>>        */
>>       if (!migrate_late_block_activate() ||
>>            (autostart && (!global_state_received() ||
>> -            runstate_is_live(global_state_get_runstate())))) {
>> +            runstate_is_live(global_state_get_runstate()))) ||
>> +         (!autostart && global_state_get_runstate() == RUN_STATE_PAUSED)) {
>>           /* Make sure all file formats throw away their mutable metadata.
>>            * If we get an error here, just don't restart the VM yet. */
>>           bdrv_activate_all(&local_err);
> 
> What are your thoughts on it?
> 

Hmmm... Don't we violate "late-block-activate" contract by this?

Me go and check:

# @late-block-activate: If enabled, the destination will not activate
#     block devices (and thus take locks) immediately at the end of
#     migration.  (since 3.0)

Yes, we'll violate it by this patch. So, for now the only exception is when autostart is enabled, but libvirt correctly use late-block-activate + !autostart.

Interesting, when block layer is assumed to be activated.. Aha, only in qmp_cont().


So, what to do with this all:

Either libvirt should not use late-block-activate for migration of stopped vm. This way target would be automatically activated

Or if libvirt still need postponed activation (I assume, for correctly switching shared disks, etc), Libvirt should do some additional QMP call. It can't be "cont", if we don't want to run the VM. So, probably, we need additional "block-activate" QMP command for this.

And, anyway, trying to migrate inactive block layer should fail with some good error message rather than crash.

-- 
Best regards,
Vladimir


