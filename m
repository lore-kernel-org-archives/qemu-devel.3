Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AF0CCD1A4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArSm-0000TV-PL; Mon, 20 Oct 2025 11:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vArSJ-0000JI-N4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:05:53 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vArSF-00070v-3a
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:05:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CF4B68088F;
 Mon, 20 Oct 2025 18:05:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a51::1:37] (unknown
 [2a02:6bf:8080:a51::1:37])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id f5XlVo5Fma60-ODfQifIV; Mon, 20 Oct 2025 18:05:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760972742;
 bh=76J9g/j50oFk70n8idfLwYl8tPo3Upx8dPTfZce5c78=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=PiXtitCy37NENMWsGWcT8+BR/YIFWSnoJBKZFZf1zafIh1cSM8TeN22bjUH99fsJa
 HPTCLcSuJakL0Jd3cF7vwt7YBscvpXFwUQEVVCdmFIKrszz06ovEvrZ5NNF2A8y8ol
 Sfa1unincxK9/+7JXMYk8k3Oa0SOxDnBIkk9PJxA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7d059286-f6a2-4dae-8af1-78a3c1fc5cb4@yandex-team.ru>
Date: Mon, 20 Oct 2025 18:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
 <87347d7s0j.fsf@pond.sub.org>
 <0ce2f913-36c2-44a2-8141-256ff847529d@yandex-team.ru>
 <aPYfqzljT3q2noDb@redhat.com> <871pmxskug.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <871pmxskug.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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

On 20.10.25 17:34, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Mon, Oct 20, 2025 at 02:22:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> On 20.10.25 14:05, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>
>>>>> Recently we moved to returning errp. Why to keep int return value?
>>>>> Generally it doesn't help: you can't use in a logic of handling
>>>>> an error, as you are never sure, that in future the logic in
>>>>> the stack will not change: it may start to return another error
>>>>> code in the same case, or return same error code in another case.
>>>>>
>>>>> Actually, we can only rely on concrete errno code when get it
>>>>> _directly_ from documented library function or syscall. This way we
>>>>> handle for example EINTR. But later in a stack, we can only add
>>>>> this errno to the textual error by strerror().
>>>>
>>>> It's a matter of the function's contract, actually.
>>>>
>>>> If the contract is "Return negative value on failure", checking for
>>>> failure is all you can do with it.  Same information as "Return false on
>>>> failure".
>>>>
>>>> If the contract is "Return negative errno on failure", the function is
>>>> responsible for returning values that make sense.  Ideally, the contract
>>>> spells them all out.
>>>>
>>>
>>> Do you know an example in code where we have both errno return value
>>> and errp, and the return value make sense and used by callers?
>>
>> If there are examples of that, I would generally consider them to be
>> bugs.
>>
>> IMHO if a method is using "Error **errp", then it should be considered
>> forbidden to return 'errno' values.
> 
> Several subsystems disagree :)

I'd vote, that in 99% (or more) cases, they don't reasonably disagree,
but blindly follow usual pattern of returning -errno together with
errp, while having no reasonable contract on concrete errno values,
and with this errno finally unused (used only to check, it is it < 0,
like boolean). In other words, the only contract they have is
"< 0 is error, otherwise success".

> 
> Quick & dirty search without a claim to accuracy or completeness:
> 
>      $ git-ls-files \*.[ch] | xargs awk '/, Error \*\*errp/ { on=1 } on && /return -E/ { print FILENAME ":" FNR ":" $0 } /^}/ { on=0 }'
> 
>> If there is a need for distinguishing some cases from others, then keep
>> with int '0/-1' example, but turn it into a multi-value return such as
>> 1/0/-1, or 0/-1/-2/-3/..., etc with named constants for the unusual
>> scenarios. An example of that would be QIOChannel were we introduced
>> "#define QIO_CHANNEL_ERR_BLOCK -2" to replace the need for EAGAIN checks
>> in callers.
> 
> Defining your own error codes is fine.
> 
> Reusing errno codes can also be fine.
> 
> In both cases, the function contract is a load-bearing component.
> 


-- 
Best regards,
Vladimir

