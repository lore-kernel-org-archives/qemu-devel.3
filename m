Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D76ACCD1A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAurN-0003TP-4O; Mon, 20 Oct 2025 14:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vAurL-0003TB-Kb
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:43:55 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vAurI-0000he-RG
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 14:43:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 26669825D1;
 Mon, 20 Oct 2025 21:43:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a51::1:37] (unknown
 [2a02:6bf:8080:a51::1:37])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jha8SP4FoeA0-w6KD1uRd; Mon, 20 Oct 2025 21:43:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760985826;
 bh=If091RNyou0/b95JJIW7oIq4eEMyThHSIGH1KMzC0ZI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=tgyE/21IVZtF9v6sU4Zs5B8OSBMseI60v3wFeKo8mOEB+8U3dakDY3Mts8WRw8qVI
 UtxsduDBIfX6oZ30dwgYZNM5CYV/a5NAE9ZgcM04IVuSXBiyvS2V2OxzoBdocfftpY
 eH7rDoRINhmVv1hNUGH5kQHczKymnGTTE2htjLhU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c11428cf-5ca1-40c4-a098-2d23d9fd8b04@yandex-team.ru>
Date: Mon, 20 Oct 2025 21:43:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
 <87347d7s0j.fsf@pond.sub.org>
 <0ce2f913-36c2-44a2-8141-256ff847529d@yandex-team.ru>
 <aPYfqzljT3q2noDb@redhat.com> <871pmxskug.fsf@pond.sub.org>
 <7d059286-f6a2-4dae-8af1-78a3c1fc5cb4@yandex-team.ru>
 <87zf9lplvc.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87zf9lplvc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 20.10.25 19:40, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 20.10.25 17:34, Markus Armbruster wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>>> On Mon, Oct 20, 2025 at 02:22:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>> On 20.10.25 14:05, Markus Armbruster wrote:
>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>>>
>>>>>>> Recently we moved to returning errp. Why to keep int return value?
>>>>>>> Generally it doesn't help: you can't use in a logic of handling
>>>>>>> an error, as you are never sure, that in future the logic in
>>>>>>> the stack will not change: it may start to return another error
>>>>>>> code in the same case, or return same error code in another case.
>>>>>>>
>>>>>>> Actually, we can only rely on concrete errno code when get it
>>>>>>> _directly_ from documented library function or syscall. This way we
>>>>>>> handle for example EINTR. But later in a stack, we can only add
>>>>>>> this errno to the textual error by strerror().
>>>>>>
>>>>>> It's a matter of the function's contract, actually.
>>>>>>
>>>>>> If the contract is "Return negative value on failure", checking for
>>>>>> failure is all you can do with it.  Same information as "Return false on
>>>>>> failure".
>>>>>>
>>>>>> If the contract is "Return negative errno on failure", the function is
>>>>>> responsible for returning values that make sense.  Ideally, the contract
>>>>>> spells them all out.
>>>>>>
>>>>>
>>>>> Do you know an example in code where we have both errno return value
>>>>> and errp, and the return value make sense and used by callers?
>>>>
>>>> If there are examples of that, I would generally consider them to be
>>>> bugs.
>>>>
>>>> IMHO if a method is using "Error **errp", then it should be considered
>>>> forbidden to return 'errno' values.
>>>
>>> Several subsystems disagree :)
>>
>> I'd vote, that in 99% (or more) cases, they don't reasonably disagree,
>> but blindly follow usual pattern of returning -errno together with
>> errp, while having no reasonable contract on concrete errno values,
>> and with this errno finally unused (used only to check, it is it < 0,
>> like boolean). In other words, the only contract they have is
>> "< 0 is error, otherwise success".
> 
> Functions that could just as well return -1 instead of errno exist.
> 
> Functions that return negative errno with callers that use them also
> exist.


But do functions that return negative errno together with errp, with
callers that use this errno exit? I don't ask to find, that's not simple.
I just say, that I myself don't know any of such functions.


upd: I found two!

how:

1. git grep -A 20 'ret = .*errp)'
2. in opened pager, do `/if \(ret == -E`


in iommufd_cdev_autodomains_get() we do something just wrong: we clear errp
after iommufd_cdev_attach_ioas_hwpt(), but return false, which is treated
as error (but with cleared errp!) by callers...


in qemu_read_default_config_file() we do correct thing, but keeping in mind,
that it's very seldom practice (around one case), we'd better add a boolean
parameter to qemu_read_config_file(), and parse errno exactly after call to
fopen().


trying with local_err gives a bit more:

git grep -A 20 'ret = .*&\(local_\)\?err)' | grep 'ret == -E'
block.c-    if (ret == -ENOTSUP) {
block.c-    if (ret == -EFBIG) {
block/snapshot.c-    if (ret == -ENOENT || ret == -EINVAL) {
hw/core/loader-fit.c-    if (ret == -ENOENT) {
hw/scsi/megasas.c-        assert(!ret || ret == -ENOTSUP);
hw/scsi/mptsas.c-        assert(!ret || ret == -ENOTSUP);
hw/usb/hcd-xhci-pci.c-        assert(!ret || ret == -ENOTSUP);
hw/vfio/pci.c-        if (ret == -ENOTSUP) {
nbd/server.c-    } while (ret == -EAGAIN && !client->quiescing);
nbd/server.c-    if (ret == -EAGAIN) {
nbd/server.c-    if (ret == -EIO) {
qemu-img.c-        if (ret == -ENOTSUP) {


I still think, that these are very seldom cases, some of them are just wrong,
some make sense, but their contract may be simplified.

> 
> I'm not going to speculate on relative frequency.
> 
> I much prefer written function contracts.  But if a caller relies on
> negative errno codes, there is an unwritten contract whether we like it
> or not.

Agree.

I just want to say, that usual pattern

int func1(..., Error *errp) {
     ...
     ret = func2(..., Error *errp);
     if (ret < 0) {
         return ret;
     }
     ...
}

is very error-prone, if func1 has some unwritten contract about _different_
errno values. As this unwritten contract may be easily broken somewhere
in the stack, not exactly in func1.


> 
>>> Quick & dirty search without a claim to accuracy or completeness:
>>>       $ git-ls-files \*.[ch] | xargs awk '/, Error \*\*errp/ { on=1 } on && /return -E/ { print FILENAME ":" FNR ":" $0 } /^}/ { on=0 }'
> 
> [...]
> 


-- 
Best regards,
Vladimir

