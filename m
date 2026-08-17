Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60230C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxWZ-0005lO-AA; Mon, 17 Aug 2026 09:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvxWW-0005TP-5O
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:37:08 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvxWT-0007Ud-Nd
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:37:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 66E0DC08DD;
 Mon, 17 Aug 2026 16:37:00 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d2f::1:33] (unknown
 [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id waUkvx8WU4Y0-cqErcOlK; Mon, 17 Aug 2026 16:36:59 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786973819;
 bh=UKodJgvHSdcurvxa5YekzIPXPMpPEsKlmLV6fxVAX8o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Yng19hPFAUQtbxb2KGulk3aXC52sTYCsml3trJwteDfvslOyK/2KMeJ1RvevVz3Rz
 pbBcTXZ3m0nuAZ83XxUa5VT4ea4Ba0DO1Ix9iop5hSr0qe/l43s+OYUFwn8OYgEN1/
 ucCt76sV7Pvdsq8sWb5lxuG+1pjq8S5gItpZjrtA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d47ec257-0d52-4ff3-b06e-94f22de0a922@yandex-team.ru>
Date: Mon, 17 Aug 2026 16:36:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] python/qemu/machine: add possibility to postpone qmp
 connect
To: Thomas Huth <thuth@redhat.com>, jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
 <20260729093146.1893719-2-vsementsov@yandex-team.ru>
 <b9479124-570a-4a81-8200-a76e3157d26f@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <b9479124-570a-4a81-8200-a76e3157d26f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 14.08.26 10:06, Thomas Huth wrote:
> On 29/07/2026 11.31, Vladimir Sementsov-Ogievskiy wrote:
>> This is need to test cpr-transfer migration, as on started
>> target QMP is not available until we call "migrate" on
>> source.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   python/qemu/machine/machine.py | 53 ++++++++++++++++++----------------
>>   1 file changed, 28 insertions(+), 25 deletions(-)
>>
>> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
>> index bfb59d4c0bf..00154b8591f 100644
>> --- a/python/qemu/machine/machine.py
>> +++ b/python/qemu/machine/machine.py
>> @@ -449,17 +449,17 @@ def _post_shutdown(self) -> None:
>>           self._user_killed = False
>>           self._launched = False
>> -    def launch(self) -> None:
>> +    def launch(self, do_start_process=True, do_qmp_connect=True) -> None:
> 
> Could you drop the "do_" prefix from the parameter names? ... that does not provide any additional value here, I think.
> 
>>           """
>>           Launch the VM and make sure we cleanup and expose the
>>           command line/output in case of exception
>>           """
>> -        if self._launched:
>> +        if self._launched and do_start_process:
>>               raise QEMUMachineError('VM already launched')
>>           try:
>> -            self._launch()
>> +            self._launch(do_start_process, do_qmp_connect)
>>           except BaseException as exc:
>>               # We may have launched the process but it may
>>               # have exited before we could connect via QMP.
>> @@ -482,31 +482,34 @@ def launch(self) -> None:
>>               # that exception. However, we still want to clean up.
>>               raise
>> -    def _launch(self) -> None:
>> +    def _launch(self, do_start_process=True, do_qmp_connect=True) -> None:
>>           """
>>           Launch the VM and establish a QMP connection
>>           """
>> -        self._pre_launch()
>> -        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
>> -        # Log a simplified, developer-runnable command:
>> -        # Exclude harness-managed infrastructure args (harness_args)
>> -        # and wrapper.
>> -        debug_cmd = [self._binary]
>> -        debug_cmd.extend(self._console_args(interactive=True))
>> -        debug_cmd.extend(self._base_args)
>> -        debug_cmd.extend(self._args)
>> -        LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
>> -
>> -        # Cleaning up of this subprocess is guaranteed by _do_shutdown.
>> -        # pylint: disable=consider-using-with
>> -        self._popen = subprocess.Popen(self._qemu_full_args,
>> -                                       stdin=subprocess.DEVNULL,
>> -                                       stdout=self._qemu_log_file,
>> -                                       stderr=subprocess.STDOUT,
>> -                                       shell=False,
>> -                                       close_fds=False)
>> -        self._launched = True
>> -        self._post_launch()
>> +        if do_start_process:
>> +            self._pre_launch()
>> +            LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
>> +            # Log a simplified, developer-runnable command:
>> +            # Exclude harness-managed infrastructure args (harness_args)
>> +            # and wrapper.
>> +            debug_cmd = [self._binary]
>> +            debug_cmd.extend(self._console_args(interactive=True))
>> +            debug_cmd.extend(self._base_args)
>> +            debug_cmd.extend(self._args)
>> +            LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
>> +
>> +            # Cleaning up of this subprocess is guaranteed by _do_shutdown.
>> +            # pylint: disable=consider-using-with
>> +            self._popen = subprocess.Popen(self._qemu_full_args,
>> +                                           stdin=subprocess.DEVNULL,
>> +                                           stdout=self._qemu_log_file,
>> +                                           stderr=subprocess.STDOUT,
>> +                                           shell=False,
>> +                                           close_fds=False)
>> +            self._launched = True
>> +
>> +        if do_qmp_connect:
>> +            self._post_launch()
> Honestly, I think this is quite confusing that callers now have to run "launch()" twice if they want to have a staged initialization.
> 
> Could you maybe drop the do_start_process parameter, just keep the qmp_connect parameter here. Then wrap the QMP connection stuff in a new separate function. So callers could do:
> 
>     vm.launch(qmp_connect=False)
>     ... do other stuff ...
>     vm.qmp_connect()
>     # instead of vm.launch(do_start_process=False, do_qmp_connect=True)\
Yes, that looks better, will do, thanks!

-- 
Best regards,
Vladimir

