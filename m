Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD85C54E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCBC-000359-61; Wed, 28 Feb 2024 00:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rfCB9-00034R-0e
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:08:28 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rfCB4-00053m-IR
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:08:26 -0500
Received: from [10.12.10.172] (unknown [78.37.10.254])
 by mail.ispras.ru (Postfix) with ESMTPSA id 3101C4076747;
 Wed, 28 Feb 2024 05:07:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3101C4076747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1709096875;
 bh=sTCmqZZkEpLe0jud6IibJdv7Jwg6njB69o0+VLvJoiU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Hzf9sl/54yCHOF24AS7Bh/nZU8ki7dGWgmIBwXHlJJHkpxANzw4AhFjY2udwh8Pfp
 mcmTn4cEflqnnf5R2BsSfsY13HN9J7A1wpB1PdKGQizdsD28f0syDMY332Pixf0eqL
 TmSrQ+yFb/ZpApHtIlTLmsm65vvD8wdJkks+OtxM=
Message-ID: <b212b1a1-eca9-40ae-992b-ff24f41844e3@ispras.ru>
Date: Wed, 28 Feb 2024 08:07:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] replay: simple auto-snapshot mode for record
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20230814163135.187882-1-npiggin@gmail.com>
 <20230814163135.187882-5-npiggin@gmail.com>
 <95adc4ea-225c-bcd5-cec2-9edf1c2cf496@ispras.ru>
 <CZEU6LST3QJK.25NCID08671V5@wheely>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <CZEU6LST3QJK.25NCID08671V5@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26.02.2024 10:36, Nicholas Piggin wrote:
> On Fri Aug 18, 2023 at 2:36 PM AEST, Pavel Dovgalyuk wrote:
>> On 14.08.2023 19:31, Nicholas Piggin wrote:
>>> record makes an initial snapshot when the machine is created, to enable
>>> reverse-debugging. Often the issue being debugged appears near the end of
>>> the trace, so it is important for performance to keep snapshots close to
>>> the end.
>>>
>>> This implements a periodic snapshot mode that keeps a rolling set of
>>> recent snapshots.
>>>
>>> Arguably this should be done by the debugger or a program that talks to
>>> QMP, but for setting up simple scenarios and tests, it is convenient to
>>> have this feature.
> 
> I'm looking at resurrecting this to help add a bit of testing...
> 
> [snip]
> 
>>> +static void replay_snapshot_timer_cb(void *opaque)
>>> +{
>>> +    Error *err = NULL;
>>> +    char *name;
>>> +
>>> +    if (!replay_can_snapshot()) {
>>> +        /* Try again soon */
>>> +        timer_mod(replay_snapshot_timer,
>>> +                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
>>> +                  replay_snapshot_periodic_delay / 10);
>>> +        return;
>>> +    }
>>> +
>>> +    name = g_strdup_printf("%s-%d", replay_snapshot, replay_snapshot_count);
>>> +    if (!save_snapshot(name,
>>> +                       true, NULL, false, NULL, &err)) {
>>> +        error_report_err(err);
>>> +        error_report("Could not create periodic snapshot "
>>> +                     "for icount record, disabling");
>>> +        g_free(name);
>>> +        return;
>>> +    }
>>> +    g_free(name);
>>> +    replay_snapshot_count++;
>>> +
>>> +    if (replay_snapshot_periodic_nr_keep >= 1 &&
>>> +        replay_snapshot_count > replay_snapshot_periodic_nr_keep) {
>>> +        int del_nr;
>>> +
>>> +        del_nr = replay_snapshot_count - replay_snapshot_periodic_nr_keep - 1;
>>> +        name = g_strdup_printf("%s-%d", replay_snapshot, del_nr);
>>> +        if (!delete_snapshot(name, false, NULL, &err)) {
>>> +            error_report_err(err);
>>> +            error_report("Could not delete periodic snapshot "
>>> +                         "for icount record");
>>> +        }
>>> +        g_free(name);
>>> +    }
>>> +
>>> +    timer_mod(replay_snapshot_timer,
>>> +              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
>>> +              replay_snapshot_periodic_delay);
>>
>> I'm not sure that realtime is not the best choice for such of a timer.
>> Virtual machine may be stopped or slowed down for some reason.
> 
> My thinking was that, say if you snapshot every 10 seconds of real time
> executed, then you should have an upper limit on the order of 10 seconds
> to perform a reverse-debug operation (so long as you don't exceed your
> nr_keep limit).

But in some cases savevm itself could take more than 10 seconds.
We'll have infinite saving in this case. That's why I propose using 
virtual clock with the QEMU_TIMER_ATTR_EXTERNAL attribute.

> 
> Is it worth worrying about complexity of slowdowns and vm pausing?
> Maybe it could stop snapshotting on a host pause.
> 
>>> +}
>>> +
>>>    void replay_vmstate_init(void)
>>>    {
>>>        Error *err = NULL;
>>> @@ -81,6 +128,16 @@ void replay_vmstate_init(void)
>>>                    error_report("Could not create snapshot for icount record");
>>>                    exit(1);
>>>                }
>>> +
>>> +            if (replay_snapshot_mode == REPLAY_SNAPSHOT_MODE_PERIODIC) {
>>> +                replay_snapshot_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
>>> +                                                     replay_snapshot_timer_cb,
>>> +                                                     NULL);
>>> +                timer_mod(replay_snapshot_timer,
>>> +                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
>>> +                          replay_snapshot_periodic_delay);
>>> +            }
>>> +
>>
>> Please also delete placeholder comment for the snapshotting timer
>> in replay_enable function.
> 
> Wil do.
> 
>>>            } else if (replay_mode == REPLAY_MODE_PLAY) {
>>>                if (!load_snapshot(replay_snapshot, NULL, false, NULL, &err)) {
>>>                    error_report_err(err);
>>> diff --git a/replay/replay.c b/replay/replay.c
>>> index e64f71209a..fa5930700d 100644
>>> --- a/replay/replay.c
>>> +++ b/replay/replay.c
>>> @@ -29,6 +29,10 @@
>>>    ReplayMode replay_mode = REPLAY_MODE_NONE;
>>>    char *replay_snapshot;
>>>    
>>> +ReplaySnapshotMode replay_snapshot_mode;
>>> +uint64_t replay_snapshot_periodic_delay;
>>> +int replay_snapshot_periodic_nr_keep;
>>> +
>>>    /* Name of replay file  */
>>>    static char *replay_filename;
>>>    ReplayState replay_state;
>>> @@ -313,6 +317,27 @@ void replay_configure(QemuOpts *opts)
>>>        }
>>>    
>>>        replay_snapshot = g_strdup(qemu_opt_get(opts, "rrsnapshot"));
>>> +    if (replay_snapshot && mode == REPLAY_MODE_RECORD) {
>>
>> Can such a snapshotting may be useful in replay mode?
> 
> Does snapshotting do anything in replay mode? 

Yes, you can create as many snapshots as you want if 'snapshot=on'
option of the disk image was not used.

> I assume if we did
> snapshotting based on the machine timer then we'd have to support
> it here so the timer events get replayed properly, at least. But
> I was trying to get by with minimum complexity :)

Use QEMU_TIMER_ATTR_EXTERNAL attribute for the timer and then its
events will not affect the replay.

> 
> Thanks,
> Nick


