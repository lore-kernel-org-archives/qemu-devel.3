Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC63EF3718
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeWO-0006vn-31; Mon, 09 Mar 2026 13:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzeWK-0006uY-C0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:35:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzeWH-0001AG-Iv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:35:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5095A5969EC;
 Mon, 09 Mar 2026 18:35:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id CAupszNvGSGP; Mon,  9 Mar 2026 18:35:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 40D305969E5; Mon, 09 Mar 2026 18:35:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F2E05966F4;
 Mon, 09 Mar 2026 18:35:47 +0100 (CET)
Date: Mon, 9 Mar 2026 18:35:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
In-Reply-To: <0a0f0d55-24ed-4018-addf-dac2b7bcfe6e@linaro.org>
Message-ID: <e5bef5ed-23e9-119d-3f63-a45343cc9c53@eik.bme.hu>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
 <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
 <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
 <0a0f0d55-24ed-4018-addf-dac2b7bcfe6e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
> On 3/9/26 9:38 AM, BALATON Zoltan wrote:
>> On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
>>> On 3/5/26 9:15 PM, Pierrick Bouvier wrote:
>>>> When using llvm-addr2line in replacement of addr2line, it will output
>>>> zero sized symbols, which can shadow other binaries depending on where
>>>> there location is (happens with arm-trusted-firmware and its different
>>>> binaries). Thus, those symbols.
>>>> 
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    contrib/plugins/uftrace_symbols.py | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>> 
>>> 
>>> This was merged into master (a8ff516c2f5ec05fb8b8bf4bceb88f49701f80d6).
>> 
>> I doubt the usefulness of such messages. People will know when pulling
>> from git and this list already has high enough volume. If you think this
>> is useful for contributors could you please send such mails off list only
>> to involved parties?
>
> From what I understand, since you were not directly CC on this series, your 
> problem is not especially with the message in itself, but with the fact that 
> "this list already has high enough volume". I personally don't suffer from 
> that, even though being CC on all patches touching docs/, because my email 
> workflow allows me to follow threads I have specific interest with, and 
> ignore the rest.
>
> In general, a mailing list is not something you are supposed to read 
> exhaustively. Instead, you're supposed to track your personal interests out 
> of it. For an analogy: When you go to your local supermarket, will you try to 
> follow every conversation happening there?
>
> If you feel it's too much for you, then maybe there is something to look into 
> how you track the mailing list, and my advice would be to use a threaded 
> view, with tags and mail filters to reduce the high volume you seem to 
> receive on a daily basis. If you're interested, I can share my (simple) 
> setup, and maybe you can get inspiration from it for your personal usage.

Threaded view does not help because the thread is already deleted when the 
separate "this patch was merged with commit hash" message arrives so it 
will show up at top level again. Ignoring everyting not cc'd to me would 
make me miss useful info about where the project goes or being able to 
review a few patches because I would not see them.

> To be honest, I was thinking to organize a small BoF on next KVM Forum to 
> allow people to share their personal tips with handling emails.
> It seems to be a common issue, and some maintainers even missed some series 
> they were supposed to review, or to pull them. For myself as well, it took 
> quite some time before having a correct workflow. I even went through the 
> idea of "reading everything" and quickly dropped it as it was unbearable.

This also suggests maybe there's too much traffic on the list so it would 
be useful to think about how to reduce it. However maintainers are 
supposed to be cc'd on series they should care about so they should not 
miss them but maybe the problem here is more that there are a lot of areas 
without maintainers listed or those in the MAINTAINERS file don't respond 
even if cc'd. Just email workflow may not help with that.

>> Getting messages about patches being queued is useful for other
>> maintainers and contributors to know the patches are picked up and then
>> they will also see the pull request on the list and when the pull request
>> got merged. Getting separate messages for each patch in a pull request
>> does not add more info to that for people already following the list.
>> 
>
> Except that some maintainers, including me, don't cc original authors when 
> sending a PR (that's a deliberate decision). As well, some top maintainers 
> don't always send back a message once the PR is done. Or they don't include 
> all authors on individual patches.

I don't think that's a problem. If somebody is interested they could 
follow the list or filter it e.g. for their S-o-b or simliar to get those 
messages or pull requests even without being cc'd.

> So for consistency and the series I personnally track, yes, I believe there 
> is a value in notifiying original series and author.

I'm OK with that, what I doubted is that it is useful to send this to the 
list too. Wouldn't it be enough to only send it to the people involved off 
list?

> It's totally right for you to mention you don't like it, feel free to ignore 
> the message. However, I feel it's a bit beyond your rights to decide what 
> people can or can't send on mailing list when you are not in CC on the 
> concerned thread, don't you think?

And that's what I did. Mentioned that I don't like it and asked if this is 
really something others want or think it's useful to get these messages on 
the list or could it be done without increasing list traffic. How did you 
get the impression I told you not to send such messages at all? Just asked 
if it's really necessary for everybody on the list? The same way don't you 
think it's beyond your right to decide how I choose to read the list? I 
think this is a misunderstanding and I don't want to tell you what to do 
but wanted to discuss if there's a better way to do this and tell you my 
opinion. Don't know why you felt offended.

Regards,
BALATON Zoltan

