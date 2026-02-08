Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68B9EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp1UT-0002Tl-6i; Sun, 08 Feb 2026 04:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp1UN-0002S9-6G; Sun, 08 Feb 2026 04:53:59 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp1UK-0000HS-2X; Sun, 08 Feb 2026 04:53:58 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 93099C058C;
 Sun, 08 Feb 2026 12:53:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d25::1:35] (unknown
 [2a02:6bf:8080:d25::1:35])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lrMnSh1BgSw0-3CbLBpzj; Sun, 08 Feb 2026 12:53:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770544429;
 bh=3D7f4ChWPkeDcvuOLeeyxzRoYz4VTgihEx/IVNJTy2M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=A27YpN9ea4k/LITWLT/lSHz53so6VKq5XAqMHzUq82R6Ghuw8b6LLpOmE2xZ5kDX5
 siVKSs+nIDMoaUh2EZgdCjaX5YzHV2NeEMxLfhm2oNG8hswAHuGIVoJstWf4n4VWgM
 g8JC8L1pxisMORT/Pnv0gadT2KKHqf4Bb/Y8UQ0M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <5bd45e4e-db27-4ee1-8df8-648ac1c0cfd9@yandex-team.com>
Date: Sun, 8 Feb 2026 14:53:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-4-heifetz@yandex-team.com>
 <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
 <14605571-e078-4d93-9f0b-411889a70076@yandex-team.com>
 <CAFEAcA_Kzy9DCnwM0CyO+X_RveRavhkSrBGoW_MXEeGstkgWsA@mail.gmail.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <CAFEAcA_Kzy9DCnwM0CyO+X_RveRavhkSrBGoW_MXEeGstkgWsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
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

On 2/7/26 22:24, Peter Maydell wrote:

> On Sat, 7 Feb 2026 at 10:24, Sergei Heifetz <heifetz@yandex-team.com> wrote:
>> On 2/4/26 17:53, Laurent Vivier wrote:
>>> Le 04/02/2026 à 08:57, Sergei Heifetz a écrit :
>>>> Reorder the code so the assertion of block occurs before it is
>>>> used in the subsequent lines.
>>>>
>>>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>>>> ---
>>>>    system/physmem.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index b0311f4531..4308e02940 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -2054,11 +2054,11 @@ static int memory_try_enable_merging(void
>>>> *addr, size_t len)
>>>>     */
>>>>    int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>>>>    {
>>>> +    assert(block);
>>>> +
>>>>        const ram_addr_t oldsize = block->used_length;
>>>>        const ram_addr_t unaligned_size = newsize;
>>>>    -    assert(block);
>>>> -
>>> According to coding style (docs/devel/style.rst):
>>>
>>> Mixed declarations (interleaving statements and declarations within
>>> blocks) are generally not allowed.
>>>
>>>>        newsize = TARGET_PAGE_ALIGN(newsize);
>>>>        newsize = REAL_HOST_PAGE_ALIGN(newsize);
>>> Thanks,
>>> Laurent
>> Should I remove the assertion altogether, then? I think the const
>> qualifier on oldsize is more useful than the assertion.
> I think personally I would drop the assertion. This falls into a
> category I think of as "assertion doesn't buy us anything".
> If block is NULL we're going to crash immediately when we
> dereference it, so the assert doesn't help to turn a hard-to-debug
> bug into an easy-to-debug bug (e.g. by catching incorrect values
> long before they're used) or to turn a nasty kind of failure
> into a safer one (e.g. by turning an array overrun into
> an assertion).
>
> And looking more closely, we call this function in only
> two places:
>   * migration/ram.c, where we've already dereferenced block
>     in the code just before the call
>   * system/memory.c, which asserts mr->ram_block before passing it in
>
> So I think the assert in this function isn't buying us anything,
> and the simplest thing is to delete it.
>
> thanks
> -- PMM
Thanks a lot for your detailed feedback. I completely agree with your 
points and will resubmit the patch without the assert.

