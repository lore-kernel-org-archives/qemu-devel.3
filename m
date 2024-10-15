Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15290D1F9C6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 19:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0nfK-0003NU-5M; Tue, 15 Oct 2024 15:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0nfI-0003NC-Lu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:57:08 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0nfG-0005vS-Uv
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:57:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 430D821CE9;
 Tue, 15 Oct 2024 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729022225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1g8WTK7D8qNPau56BfEXcHsLHqvMalmJUzAVVpu8B5U=;
 b=1QHhTx6zPWylpWcSex42WwuItR+uwbivxktavGYdt9akjFPHu2UH2SZgU8wBFh5CY5mCaR
 4g9SA3mNoraNTvX3bJ2Y1pTB4ANNHpFMnOvE4bYOA9E2chuv1YeW01gaoRSn9Q8W94abed
 LRmhVEzDoZD1aVksJslf8J7moyadVcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729022225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1g8WTK7D8qNPau56BfEXcHsLHqvMalmJUzAVVpu8B5U=;
 b=/RHJ2aIPSFn4aRCU6QRnx5e1gPJ+00rvCZ/UqrFZmQ1P+eEmSoqnxQKESAFXp50hJI5m8d
 hGT1bs137vCuhpCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729022225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1g8WTK7D8qNPau56BfEXcHsLHqvMalmJUzAVVpu8B5U=;
 b=1QHhTx6zPWylpWcSex42WwuItR+uwbivxktavGYdt9akjFPHu2UH2SZgU8wBFh5CY5mCaR
 4g9SA3mNoraNTvX3bJ2Y1pTB4ANNHpFMnOvE4bYOA9E2chuv1YeW01gaoRSn9Q8W94abed
 LRmhVEzDoZD1aVksJslf8J7moyadVcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729022225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1g8WTK7D8qNPau56BfEXcHsLHqvMalmJUzAVVpu8B5U=;
 b=/RHJ2aIPSFn4aRCU6QRnx5e1gPJ+00rvCZ/UqrFZmQ1P+eEmSoqnxQKESAFXp50hJI5m8d
 hGT1bs137vCuhpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDE4913A53;
 Tue, 15 Oct 2024 19:57:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7TBUIRDJDmfeYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Oct 2024 19:57:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: tpm-tis-device-swtpm-test timeout
In-Reply-To: <865424c1-f79c-44ad-b70f-8bf3e455e025@linux.ibm.com>
References: <87jze9qlrp.fsf@suse.de>
 <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com>
 <87h69dqigg.fsf@suse.de>
 <865424c1-f79c-44ad-b70f-8bf3e455e025@linux.ibm.com>
Date: Tue, 15 Oct 2024 16:57:02 -0300
Message-ID: <87ed4hqgvl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Stefan Berger <stefanb@linux.ibm.com> writes:

> On 10/15/24 3:22 PM, Fabiano Rosas wrote:
>> Stefan Berger <stefanb@linux.ibm.com> writes:
>> 
>>> On 10/15/24 2:11 PM, Fabiano Rosas wrote:
>>>> Hi Stefan,
>>>>
>>>> I see the tpm-tis-device-swtpm test timing out, could you take a look?
>>>>
>>>> qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-test time out (After 60.0 seconds)
>>>> 135/138 qemu:qtest+qtest-aarch64 /
>>>> qtest-aarch64/tpm-tis-device-swtpm-test TIMEOUT 60.01s killed by signal 11 SIGSEGV
>>>
>>> Is this something new or been happening for a while? Does it happen
>>> consistently? I just build the master branch and ran the tests on a very
>>> old machine, I mean 13 years old. The host runs Fedora 40 with
>>> libtpms-0.96-6 + swtpm-0.9.0 from the distro:
>> 
>> It's the first time I see it. I can reproduce consistently by running
>> that test in a loop while make -j16 check is running in another window.
>
> So this here is failing for you every time?
>
> QTEST_QEMU_BINARY=build/qemu-system-aarch64 
> ./build/tests/qtest/tpm-tis-device-swtpm-test

Sorry, I was unclear. No, that runs for about 30 iterations before it
fails. I just ran each of these in a terminal window:

$ for i in $(seq 1 999); do echo "$i =============";  QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/tpm-tis-device-swtpm-test || break ; done
$ make -j$(nproc) check
$ while :; do ps aux | grep -v grep | grep swtpm; done

The result is:

$ for i in $(seq 1 999); do echo "$i =============";
QTEST_QEMU_BINARY=./qemu-system-aarch64
./tests/qtest/tpm-tis-device-swtpm-test || break ; done
...
...
22 =============                               
# random seed: R02Se1d542a529b7d9bfdfdcaf9d5359cbb9                                            
1..2                                           
# Start of aarch64 tests                       
# Start of tpm tests                           
# Start of tis-swtpm tests                     
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-14870.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-14870.qmp,id=char0 -mon chardev=char0,mode=control -display 
none -audio none -machine virt,gic-version=max -accel tcg -chardev socket,id=chr,path=/tmp/qemu-tpm-tis-device-swtpm-test.VWOBV2/sock -tpmdev emulator,id=dev,chardev=chr -device tpm-tis-devic
e,tpmdev=dev -accel qtest
ok 1 /aarch64/tpm/tis-swtpm/test               
# End of tis-swtpm tests                       
# Start of tis-swtpm-migration tests                                                           
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-14870.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-14870.qmp,id=char0 -mon chardev=char0,mode=control -display 
none -audio none -machine virt,gic-version=max -accel tcg -chardev socket,id=chr,path=/tmp/qemu-tpm-tis-device-swtpm-test.VWOBV2/sock -tpmdev emulator,id=dev,chardev=chr -device tpm-tis-devic
e,tpmdev=dev  -accel qtest
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-14870.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-14870.qmp,id=char0 -mon chardev=char0,mode=control -display 
none -audio none -machine virt,gic-version=max -accel tcg -chardev socket,id=chr,path=/tmp/qemu-tpm-tis-device-swtpm-test.QXOBV2/sock -tpmdev emulator,id=dev,chardev=chr -device tpm-tis-devic
e,tpmdev=dev -incoming unix:/tmp/qemu-tpm-tis-device-swtpm-test.VWOBV2/migsocket -accel qtest
Segmentation fault (core dumped)               
$ swtpm: Data client disconnected
swtpm: Data client disconnected

>
> This test would start swtpm. Do you see it running while this test is 
> running? It should show process like this running for a very short time 
> obviously  [ while :; do ps aux | grep -v grep | grep swtpm; done ]:

I see several of:

fabiano 30146 0.0 0.0 18056 5564 pts/9 S 15:11 0:00 swtpm socket
--tpmstate dir=/tmp/qemu-tpm-tis-device-swtpm-test.DQFLV2 --ctrl
type=unixio,path=/tmp/qemu-tpm-tis-device-swtpm-test.DQFLV2/sock --tpm2

> stefanb  4087462  0.0  0.0  11040  3732 pts/6    S+   15:30   0:00 swtpm 
> socket --tpmstate dir=/tmp/qemu-tpm-tis-device-swtpm-test.D3SLV2 --ctrl 
> type=unixio,path=/tmp/qemu-tpm-tis-device-swtpm-test.D3SLV2/sock --tpm2
> stefanb  4087467  0.0  0.0  11040  3660 pts/6    S+   15:30   0:00 swtpm 
> socket --tpmstate dir=/tmp/qemu-tpm-tis-device-swtpm-test.H1SLV2 --ctrl 
> type=unixio,path=/tmp/qemu-tpm-tis-device-swtpm-test.H1SLV2/sock --tpm2
>
>
>> 
>> I'm on openSUSE Leap 15.5:
>> 
>> $ rpm -qa | grep libtpms
>> libtpms0-0.8.2-150300.3.9.1.x86_64
>> 
>> $ rpm -qa | grep swtpm
>> swtpm-0.7.3-150500.2.1.x86_64
>> 

