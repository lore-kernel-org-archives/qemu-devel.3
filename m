Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9CECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnyF-0004a6-Pe; Mon, 20 Oct 2025 07:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vAnyC-0004ZZ-Ae
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:22:32 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vAny8-0007D7-4J
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:22:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7A9EA807B9;
 Mon, 20 Oct 2025 14:22:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a51::1:37] (unknown
 [2a02:6bf:8080:a51::1:37])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MMT9qJ4F3eA0-r0mmLLyh; Mon, 20 Oct 2025 14:22:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760959342;
 bh=gP4uucnZa1ra9/baYNOGp0AGEjkEV8CLMy4oICVnWec=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sSTXE4MSL6PkRLNihrsJ99dX6X1uOvm/8rUpLxN+h2NbbPfK60SK1hz2tMrmaADlx
 wMAZVbSTcRHKW3LhJ5fFxspjjY5IlWPWkirVSHB4IWT7Nh4x6+IgArFee22EWb2qyW
 uUXo8Qgj4Dh6hWDbZyH9A2/dMN0FGogtBdqkgWvQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0ce2f913-36c2-44a2-8141-256ff847529d@yandex-team.ru>
Date: Mon, 20 Oct 2025 14:22:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
To: Markus Armbruster <armbru@redhat.com>
Cc: peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
 <87347d7s0j.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87347d7s0j.fsf@pond.sub.org>
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

On 20.10.25 14:05, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Recently we moved to returning errp. Why to keep int return value?
>> Generally it doesn't help: you can't use in a logic of handling
>> an error, as you are never sure, that in future the logic in
>> the stack will not change: it may start to return another error
>> code in the same case, or return same error code in another case.
>>
>> Actually, we can only rely on concrete errno code when get it
>> _directly_ from documented library function or syscall. This way we
>> handle for example EINTR. But later in a stack, we can only add
>> this errno to the textual error by strerror().
> 
> It's a matter of the function's contract, actually.
> 
> If the contract is "Return negative value on failure", checking for
> failure is all you can do with it.  Same information as "Return false on
> failure".
> 
> If the contract is "Return negative errno on failure", the function is
> responsible for returning values that make sense.  Ideally, the contract
> spells them all out.
> 

Do you know an example in code where we have both errno return value
and errp, and the return value make sense and used by callers?

> No difference between "documented library function or syscall" and a
> function we provide ourselves.

I agree... Still the only difference is that for library function
it's OK to provide specific error only for caller to be able to print it
to the user (with help of strerror). But for our functions with errp,
it's assumed that the whole information for the user is already in errp.

So I now think, shouldn't we actually do

diff --git a/include/qapi/error.h b/include/qapi/error.h
index d798faeec3..1c2484187f 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -43,8 +43,7 @@
   *   avoid useless error object creation and destruction.  Note that
   *   we still have many functions returning void.  We recommend
   *   • bool-valued functions return true on success / false on failure,
- *   • pointer-valued functions return non-null / null pointer, and
- *   • integer-valued functions return non-negative / negative.
+ *   • pointer-valued functions return non-null / null pointer.
   *
   * = Creating errors =
   *


?

> 
>> Let this new, recently added API be simpler and clearer, let it
>> return simple boolean value, so we shouldn't think:
>>
>>    - should we handle different error codes differently
>>      (if yes - how exactly, if no - why do we need this information?)
>>
>>    - should we add it to errp, or it was already added earlier in
>>      the stack
> 
> When no caller actually needs to distinguish between errors, bool is the
> most obvious interface.
> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   backends/tpm/tpm_emulator.c   | 10 ++++------

[..]

>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -153,15 +153,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>>           return -EINVAL;
>>       }
>> -    if (vmsd->pre_load_errp) {
>> -        ret = vmsd->pre_load_errp(opaque, errp);
>> -        if (ret < 0) {
>> -            error_prepend(errp, "pre load hook failed for: '%s', "
>> -                          "version_id: %d, minimum version_id: %d, "
>> -                          "ret: %d: ", vmsd->name, vmsd->version_id,
>> -                          vmsd->minimum_version_id, ret);
> 
> Numeric errno codes in error messages are an anti-pattern.
> 
>> -            return ret;
>> -        }
>> +    if (vmsd->pre_load_errp && !vmsd->pre_load_errp(opaque, errp)) {
>> +        error_prepend(errp, "pre load hook failed for: '%s', "
>> +                      "version_id: %d, minimum version_id: %d, "
>> +                      "ret: %d: ", vmsd->name, vmsd->version_id,
>> +                      vmsd->minimum_version_id, ret);
> 
> Did you forget to delete ", ret %d:" and its argument @ret?  It's always
> zero here now.
> 
Oh right, thanks.

-- 
Best regards,
Vladimir

