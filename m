Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4FCD132BF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wjB-0000kh-M3; Mon, 04 Nov 2024 08:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7whq-0008SL-4N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7whl-00057b-G5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730725271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8C3Acu34XLUyTLphORhKtMiNz3iG4ofRe9tLEbm7rEA=;
 b=S2F8Y8NdPLWKltv5rsIF4UGL+9jdCCQvGUZyr5SK8KaazyRs3loJ2xxEFnJfpnrNvbSJo5
 5MzxwtBIbL3qU0IiqvoWQV87n2ykJUAIMJ+LnLhUvakqIUVA2cA5k2LuKXI9jDWu3GbPMa
 WL+45cdhCOIllUZgw9ludnixSVKUqpM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-dbwMDeWdP_yAPm04hP2ALg-1; Mon, 04 Nov 2024 08:01:10 -0500
X-MC-Unique: dbwMDeWdP_yAPm04hP2ALg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso4293496e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730725268; x=1731330068;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8C3Acu34XLUyTLphORhKtMiNz3iG4ofRe9tLEbm7rEA=;
 b=bg1IC6bCxcOoqztIIKRAFQMdy2DfbPi9gqf41ljz7eJw78tgW8jZDyCx5KxmetINj/
 fUk7O1g0M8hc9wtFg/WmbbuC+ZoBETszMYqkpwal1SzpekvFyeV50OpxNTMgqG/J2k8u
 ygu9EMRQz8FE38OkB0XA9JFOH4Al2I53kK/yHmXPX++TBfPSOZ8GO8mc7cfW35jvL4/6
 O45vYlVSrN4qBj7HiKPkkVkUTGeBUKKPMTLW3P6KIPGb/EYCI9m2uHwKoFaPl36frZLB
 OYqnhIQeoatayzAtGkBTcjLw5AO332ujetkyGnNK8EAjGpvO2qgEc3ztatSvEeSrFZ7b
 iF0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1y8C/BuqHWOu/on5RRalNdbKdo5kEMwv9D6S3mcf+eus/JkSOVMHWnjCFdrShEI8KvXxy9tFsflZA@nongnu.org
X-Gm-Message-State: AOJu0YwTMnKNcNUdj9yM4AlWc1shLzGTvt4W/WqEz/75F5wzjktR0/Va
 +FaAM+Px5rhu3lmU6P+G4CYlif75N8RJlmRNFeqrB8Cc56g2uG7lqUg60BAmMqerJ1+1oLwQIZq
 JADUWrkYs7VM9LMZFYLDNmRx43tlMi9ABwfqMvQ3i0vBsSD6ltld9
X-Received: by 2002:a05:6512:3d94:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53b34a1908emr18527002e87.41.1730725267776; 
 Mon, 04 Nov 2024 05:01:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzD0kYCVMHlf6t0W4midEKeiIXV0qXvLkNS0khBTX13yGGIb6toZeO8OElENU9R5HeH/vBzA==
X-Received: by 2002:a05:6512:3d94:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53b34a1908emr18526966e87.41.1730725267216; 
 Mon, 04 Nov 2024 05:01:07 -0800 (PST)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9479ebsm181183335e9.23.2024.11.04.05.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 05:01:06 -0800 (PST)
Message-ID: <c74f7199-67f3-4819-8c3e-541a0bb087be@redhat.com>
Date: Mon, 4 Nov 2024 14:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check-function failing on func-arm-arm_aspeed
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
 <28eba1fd-f5d8-4755-b8bb-074d3c087a75@redhat.com>
 <ZyjCGzS63fiBbT5B@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZyjCGzS63fiBbT5B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04/11/2024 13.46, Daniel P. Berrangé wrote:
> On Mon, Nov 04, 2024 at 01:12:16PM +0100, Thomas Huth wrote:
>> On 28/10/2024 18.14, Peter Maydell wrote:
>>> Trying a "make check-functional" I find that the func-arm-arm_aspeed
>>> test seems to hit a timeout:
>>>
>>> 18/18 qemu:func-thorough+func-arm-thorough+thorough /
>>> func-arm-arm_aspeed              TIMEOUT        600.08s   killed by
>>> signal 15 SIGTERM
>>>
>>> This is with commit cea8ac78545a.
>>
>> Cédric, is it working reliable for you?
>>
>>> Does anybody else see this, or is it some oddity happening only
>>> on my local dev machine?
>>>
>>> The "full log" in testlog-thorough.txt doesn't seem to be
>>> very full. All it has for this test is:
>>>
>>> =================================== 18/18 ====================================
>>> test:         qemu:func-thorough+func-arm-thorough+thorough /
>>> func-arm-arm_aspeed
>>> start time:   16:54:50
>>> duration:     600.08s
>>> result:       killed by signal 15 SIGTERM
>>> command:      G_TEST_SLOW=1
>>> PYTHONPATH=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python:/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional
>>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>>> MALLOC_PERTURB_=238
>>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
>>> MESON_TEST_ITERATION=1
>>> QEMU_TEST_QEMU_IMG=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-img
>>> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
>>> QEMU_TEST_QEMU_BINARY=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-arm
>>> QEMU_BUILD_ROOT=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang
>>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
>>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_arm_aspeed.py
>>> ----------------------------------- stdout -----------------------------------
>>> TAP version 13
>>> ok 1 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_04
>>> ok 2 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_07
>>> ok 3 test_arm_aspeed.AST2x00Machine.test_arm_ast2400_palmetto_openbmc_v2_9_0
>>> ==============================================================================
>>>
>>> Is it possible to get the log to include a pointer to the
>>> actual log for the test (including the guest console output)?
>>> It's hard to debug tests if they don't report what they're doing.
>>
>> I tried to add something to the log iff the test case failed (e.g. by
>> checking defaultTestResult().wasSuccessful() or something similar in the
>> tearDown() function of the test), but that does not seem to work ...
>> so all I can suggest right now is to print out the path to the test log
>> unconditionally, something like:
>>
>> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
>> index aa0146265a..7436f37bc5 100644
>> --- a/tests/functional/qemu_test/testcase.py
>> +++ b/tests/functional/qemu_test/testcase.py
>> @@ -47,13 +47,14 @@ def setUp(self, bin_prefix):
>>           self.logdir = self.workdir
>>           self.log = logging.getLogger('qemu-test')
>>           self.log.setLevel(logging.DEBUG)
>> -        self._log_fh = logging.FileHandler(os.path.join(self.logdir,
>> -                                                        'base.log'), mode='w')
>> +        log_file_name = os.path.join(self.logdir, 'base.log')
>> +        self._log_fh = logging.FileHandler(log_file_name, mode='w')
>>           self._log_fh.setLevel(logging.DEBUG)
>>           fileFormatter = logging.Formatter(
>>               '%(asctime)s - %(levelname)s: %(message)s')
>>           self._log_fh.setFormatter(fileFormatter)
>>           self.log.addHandler(self._log_fh)
>> +        print(self.id() + ' log file: ' + log_file_name)
> 
> Surely this is going to break TAP format parsing of test output, as
> diagnostics need to be prefixed with a '# '. I'm fairly sure it was
> meson that complained about such stuff in the past when I converted
> the acpibits test to the functional test

Our pycotap setup redirects this to stderr, so we're fine here. But if you 
prefer, we could also directly print it to stderr right from the start instead.

  Thomas


