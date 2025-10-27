Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1CFCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOI5-0003c1-Uq; Mon, 27 Oct 2025 10:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDOI0-0003bH-GW
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:33:41 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDOHr-0006wW-NH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:33:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B222B80A65;
 Mon, 27 Oct 2025 17:33:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5c::1:11] (unknown
 [2a02:6bf:8080:c5c::1:11])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KXdEKj1FwOs0-kLqkpbHi; Mon, 27 Oct 2025 17:33:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761575601;
 bh=r7nfKQjl4TK/fZMFYgVcnwxKfPAHyQPy/cMWq0dsQnQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Im5noNobmvOLTtMkTYeIZrhh3QglbFQPquvgWJu31a/7AYdVLfH+pxZEwBGw9H0p7
 EtXprGh0vhYnmrD7SVz4/tk9bdseLjXQ6JOl5uVZM0pSTkTDfNAnuOt3CLHA0fcH8v
 r8aHSj9/0w/uk/UbU8USMo5bAqo/sYLAV0qgSa/w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ad68df68-bd35-4ebe-9577-88cc98630aac@yandex-team.ru>
Date: Mon, 27 Oct 2025 17:33:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] tmp_emulator: fix unset errp on error path
To: Markus Armbruster <armbru@redhat.com>
Cc: peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org, berrange@redhat.com
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-3-vsementsov@yandex-team.ru>
 <87y0owodjd.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87y0owodjd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27.10.25 13:16, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Note, that called tpm_emulator_startup_tpm_resume() does error_report()
>> failure paths, which could be turned into error_setg() to passthough an
>> error. But, not on all error paths. Not saying about
>> tpm_emulator_startup_tpm_resume() return -1 on failure and we mix it
>> with -errno from tpm_emulator_set_state_blobs(). So, it all needs deeper
>> refactoring, which is out of scope of this small fix.
>>
>> Fixes: 42e556fa3f7ac
>>      "backends/tpm: Propagate vTPM error on migration failure"
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   backends/tpm/tpm_emulator.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
>> index dacfca5ab7..aa69eb606f 100644
>> --- a/backends/tpm/tpm_emulator.c
>> +++ b/backends/tpm/tpm_emulator.c
>> @@ -961,6 +961,7 @@ static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>>       }
>>   
>>       if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
>> +        error_setg(errp, "Failed to resume tpm");
>>           return -EIO;
>>       }
> 
> Anti-pattern: we call error_report() (via
> tpm_emulator_startup_tpm_resume(), tpm_emulator_set_buffer_size, ...)
> from within an Error-setting function.  You need to convert the entire
> nest of functions to Error.
> 

Is it a show-stopper for bug-fix? I'm afraid, I have no time to convert the whole
tpm_emulator.c.


-- 
Best regards,
Vladimir

