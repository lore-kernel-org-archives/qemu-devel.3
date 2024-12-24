Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B654E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 07:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPzHw-0006FF-GK; Tue, 24 Dec 2024 02:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1tPzHr-0006Ed-BT; Tue, 24 Dec 2024 02:25:03 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1tPzHo-0001GR-WB; Tue, 24 Dec 2024 02:25:03 -0500
Received: from [10.35.8.17] (unknown [80.250.189.26])
 by mail.ispras.ru (Postfix) with ESMTPSA id 4698140755C3;
 Tue, 24 Dec 2024 07:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4698140755C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1735025094;
 bh=pcQElPpPbHw4hCPXZT0usjI6bfVPLp0Lgp+18mPa9Ck=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dI/gPw3n83kGqFDvWpwxcqwV6y44pmIDmUVhlj7mj9stPyijtr7TB8zr+q77ToriW
 yyHr7s5r2us0HeU01eYK7hW+i0Qe2TWLEHugfEUtKUQX94C/xiOxngI9FS//0cHFJE
 aC9bP00JfO24eYbjbnm9U+Z9/UtcRhh+8DgVYqAg=
Message-ID: <51af6ae2-db61-44f5-bde0-bf2eb98923eb@ispras.ru>
Date: Tue, 24 Dec 2024 10:24:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] replay: Fix migration use of clock for statistics
To: Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-2-npiggin@gmail.com> <Z2Wb7T8oH0xbk576@x1n>
 <D6H1LG4QEYL3.3B6MWT5ZTMAQG@gmail.com> <Z2mdNtwd9UzAUVBB@x1n>
Content-Language: en-US
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <Z2mdNtwd9UzAUVBB@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 23.12.2024 20:26, Peter Xu wrote:
> On Sat, Dec 21, 2024 at 01:02:01PM +1000, Nicholas Piggin wrote:
>> On Sat Dec 21, 2024 at 2:31 AM AEST, Peter Xu wrote:
>>> On Fri, Dec 20, 2024 at 08:42:03PM +1000, Nicholas Piggin wrote:
>>>> Migration reads CLOCK_HOST when not holding the replay_mutex, which
>>>> asserts when recording a trace. These are not guest visible so should
>>>> be CLOCK_REALTIME like other statistics in MigrationState, which do
>>>> not require the replay_mutex.
>>>
>>> Irrelevant of the change, should we document such lock implications in
>>> timer.h?
>>
>> I guess the intention was to try to avoid caller caring too much
>> about replay internals, so I'm not sure if that will help or
>> hinder understanding :(
> 
> CLOCK_HOST should be the wall clock in QEMU, IIUC.  If any QEMU caller
> tries to read host wall clock requires some mutex to be held.. then I don't
> see how we can avoid mentioning it.  It's indeed weird if we need to take a
> feature specific mutex just to read the wallclock.. But maybe I misread the
> context somewhere..
> 
>>
>> I think the big rule is something like "if it affects guest state,
>> then you must use HOST or VIRTUAL*, if it does not affect guest state
> 
> HOST clock logically shouldn't be relevant to guest-state?

CLOCK_HOST is used for rtc by default. As the rtc affects the guest 
state, therefore CLOCK_HOST affects guest state too.

Migration is not related to guest state change, therefore it should 
either use realtime clock, or set some flag to make host clock reads not 
tracked by record/replay.

> 
>> then you must use REALTIME". record-replay code then takes care of
>> replay mutex locking.
>>
>> Does get a little fuzzy around edges in code that is somewhat
>> aware of record-replay though, like migration/snapshots.
> 
> Said that, I agree with the change itself - any measurement may not want to
> involve NTP at all... which HOST / gtod will, but REALTIME won't.  However
> this patch doesn't seem to be for that purpose..  So I'd like to double
> check.
> 
> Thanks,
> 


