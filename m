Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0A5C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNYg-000335-36; Tue, 04 Feb 2025 13:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tfNYc-000321-CX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:21:59 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tfNYY-0002Kw-Lh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:21:56 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2b8e:0:640:2b6e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C932B60D52;
 Tue,  4 Feb 2025 21:21:48 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b591::1:31] (unknown
 [2a02:6b8:b081:b591::1:31])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lLprBe1Ik4Y0-5HU0Hyd6; Tue, 04 Feb 2025 21:21:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1738693308;
 bh=rD54t8/sPqdAAWIjxVCEzp+lV7sbyH7kxYKImw+iB3U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pQLqAMSUrTaGMtCo8sD9DG0JEgX0bnU3Hi4A5v8bzM1u87nwFJ5NXm+LV1HRVj2p+
 n+nsHUgiirbnFPh51BbI1MUlagB5+79vVSne8p7DxKVIy2GRP3gfR4lUsmtnBKhqvk
 g+aUsswdYSQwpnYZtbPvzkP53IgKbpK1dgcqlZZ0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ad84e140-de39-4740-b17e-963d7d5ecb35@yandex-team.ru>
Date: Tue, 4 Feb 2025 21:21:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] overcommit: introduce mem-lock-onfault
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
 <Z5Ju0ZnR6KEEF-Bu@x1n> <1abc7363-21be-4a9e-a946-c50deb266dea@yandex-team.ru>
 <Z6Iofl0pp1xDENHz@x1.local>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z6Iofl0pp1xDENHz@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 2/4/25 5:47 PM, Peter Xu wrote:

> On Tue, Feb 04, 2025 at 11:23:41AM +0300, Daniil Tatianin wrote:
>> On 1/23/25 7:31 PM, Peter Xu wrote:
>>> On Thu, Jan 23, 2025 at 04:19:40PM +0300, Daniil Tatianin wrote:
>>>> Currently, passing mem-lock=on to QEMU causes memory usage to grow by
>>>> huge amounts:
>>>>
>>>> no memlock:
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=off
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       45652
>>>>
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       39756
>>>>
>>>> memlock:
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=on
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       1309876
>>>>
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       259956
>>>>
>>>> This is caused by the fact that mlockall(2) automatically
>>>> write-faults every existing and future anonymous mappings in the
>>>> process right away.
>>>>
>>>> One of the reasons to enable mem-lock is to protect a QEMU process'
>>>> pages from being compacted and migrated by kcompactd (which does so
>>>> by messing with a live process page tables causing thousands of TLB
>>>> flush IPIs per second) basically stealing all guest time while it's
>>>> active.
>>>>
>>>> mem-lock=on helps against this (given compact_unevictable_allowed is 0),
>>>> but the memory overhead it introduces is an undesirable side effect,
>>>> which we can completely avoid by passing MCL_ONFAULT to mlockall, which
>>>> is what this series allows to do with a new option for mem-lock called
>>>> on-fault.
>>>>
>>>> memlock-onfault:
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       54004
>>>>
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault -enable-kvm
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       47772
>>>>
>>>> You may notice the memory usage is still slightly higher, in this case
>>>> by a few megabytes over the mem-lock=off case. I was able to trace this
>>>> down to a bug in the linux kernel with MCL_ONFAULT not being honored for
>>>> the early process heap (with brk(2) etc.) so it is still write-faulted in
>>>> this case, but it's still way less than it was with just the mem-lock=on.
>>>>
>>>> Changes since v1:
>>>>       - Don't make a separate mem-lock-onfault, add an on-fault option to mem-lock instead
>>>>
>>>> Changes since v2:
>>>>       - Move overcommit option parsing out of line
>>>>       - Make enable_mlock an enum instead
>>>>
>>>> Changes since v3:
>>>>       - Rebase to latest master due to the recent sysemu -> system renames
>>>>
>>>> Daniil Tatianin (4):
>>>>     os: add an ability to lock memory on_fault
>>>>     system/vl: extract overcommit option parsing into a helper
>>>>     system: introduce a new MlockState enum
>>>>     overcommit: introduce mem-lock=on-fault
>>>>
>>>>    hw/virtio/virtio-mem.c    |  2 +-
>>>>    include/system/os-posix.h |  2 +-
>>>>    include/system/os-win32.h |  3 ++-
>>>>    include/system/system.h   | 12 ++++++++-
>>>>    migration/postcopy-ram.c  |  4 +--
>>>>    os-posix.c                | 10 ++++++--
>>>>    qemu-options.hx           | 14 +++++++----
>>>>    system/globals.c          | 12 ++++++++-
>>>>    system/vl.c               | 52 +++++++++++++++++++++++++++++++--------
>>>>    9 files changed, 87 insertions(+), 24 deletions(-)
>>> Considering it's very mem relevant change and looks pretty benign.. I can
>>> pick this if nobody disagrees (or beats me to it, which I'd appreciate).
>>>
>>> I'll also provide at least one week for people to stop me.
>> I think it's been almost two weeks, so should be good now :)
> Don't worry, this is in track.  I'll send it maybe in a few days.
>
> Thanks,

Amazing, thank you!


