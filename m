Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335C5C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWJK-0000kU-DG; Thu, 01 May 2025 11:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWJ7-0000jj-Iv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:58:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWJ3-0003QS-UH
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:58:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so17093485ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115115; x=1746719915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kMJUrhqNeBJZH8crcM96ODWraALMTusCwata4BwfcKs=;
 b=w9E6pSrVOk8F+hNsQG2QfAaV+Dcm7rgSu7orJeixBf9Dx/HsPLYvG2uaHJr3UrnmOk
 aaz3Gjz9Z+7RccHSj52CGIVmF+iH3Ul21kTZ2nNTyAuwGDqCceJavdAOiOArUPaeMyfA
 iZvwYbGFXhE2y1DQwkfTL1RmIm80Ngqm+wgjVbLq55a6AiFm3nwKK5f+y8mG5yGza5nv
 epTTJ9bvs/ket+BzBCn4UZT4/wQJKp65U+YUykohrE46Fv8+6GWJyaeBAvBXBgQUchwN
 AaA7l7bpUH7Eo+KH6uPB6qbDj8ChHsMdccyh+30/9b5YY1WKWM7qNXWdB2M2Xe+a30nF
 5rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115115; x=1746719915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kMJUrhqNeBJZH8crcM96ODWraALMTusCwata4BwfcKs=;
 b=ahn7WsOeLie1xTOxQ2ejmexKZtLQ1y2ueUhckfkNOXQ2W3gBZ3lPX6uCJhKO9saYZP
 9bAQmkai/xrgNEWg5XPUGICr1aB8CkGMaDHoW0lC9Roe5YQrrZaAc9XrNSBc/OVb6vts
 d5vzAS/hPPW4ZrHzMaAl1GfT++gvb23lWmq4JlouzQgHctdTiEFO+9IPv8jIP3BWTM6J
 NBI/0iOvkrtQejtc50Yh8Q/3YgyAVpNP9wrTQiCztgMifTyeOpoSS+2/OO0Iog6niwAx
 bWwC+UaakPz6Yk/yA6PLFX+86DwddTxDJaiZUG1RtYlk5WgtZWTu2tUWBmKy2SwmY2mL
 mPug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdjWjARfEOFry09MYNeBsO81+RMLqUDiiPTWrBUHnjGvtHjkkwBChc/EYxURkdbZIJsD/AlY5AQ6/Y@nongnu.org
X-Gm-Message-State: AOJu0YzMpiGy98sgR+2iZ5ONDFX9syDef3JuXKJG13LIz8yMUkLkaFx2
 y+HJb+N/0/oowsHB2a9hRZuE9N3t0qxezc4dXA+xREseNBL23DIWImTT2VcnYrk=
X-Gm-Gg: ASbGncsaQKkByqSXmFu8PJ2LTotM5oAF7pS9tPnatzc8t8S9JExk81dSvfSoeVkvXyv
 8J+em94/PlWJM8xTTNWGv/9YQ/07HTBuebK8QrNbjy5zgySPVnujlNjr91Fc+MUE9iX4aKCZwhJ
 nsLzI/aVlNWAzCzffUflJhzX1uypH5wHTxbupJ23DXvRNWkY6WHJFP1jy7XoPn08z7Ab7os9jiF
 7qmwqmh9HBTXbxMowDP23qeDQufutgFWAqtQU7r1XOQFIv3V5WajQyh+Ag1Ks3i6oiz+MEOuf2S
 ReuNwQjVhcRued6PgAvFc62vbIXZq70G2FqkZTWxKgH2epiqYBz+xg==
X-Google-Smtp-Source: AGHT+IEm7/JjKoPfkasxlrMQ+CYFtH/dE5nEl0H7+tupVZ6GCOXiMLds1b3wDPtfE9ADW5E/5fSolg==
X-Received: by 2002:a17:902:d487:b0:224:1074:63a2 with SMTP id
 d9443c01a7336-22e0864dc66mr52258745ad.43.1746115115177; 
 Thu, 01 May 2025 08:58:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e242sm8487915ad.53.2025.05.01.08.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:58:34 -0700 (PDT)
Message-ID: <5a0ff4e4-6687-4651-aff2-626615451a5d@linaro.org>
Date: Thu, 1 May 2025 08:58:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-5-thuth@redhat.com>
 <d47d36db-f94c-45ee-bdf0-477607703461@linaro.org> <aBOE8iwN0oIVfwTi@x1.local>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBOE8iwN0oIVfwTi@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/1/25 7:28 AM, Peter Xu wrote:
> On Wed, Apr 30, 2025 at 09:10:30AM -0700, Pierrick Bouvier wrote:
>> On 4/29/25 8:21 AM, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> We've got this nice vmstate-static-checker.py script that can help
>>> to detect screw-ups in the migration states. Unfortunately, it's
>>> currently only run manually, so there could be regressions that nobody
>>> notices immediately. Let's run it from a functional test automatically
>>> so that we got at least a basic coverage in each CI run.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    MAINTAINERS                      |  1 +
>>>    tests/functional/meson.build     | 13 +++++++-
>>>    tests/functional/test_vmstate.py | 56 ++++++++++++++++++++++++++++++++
>>>    3 files changed, 69 insertions(+), 1 deletion(-)
>>>    create mode 100755 tests/functional/test_vmstate.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 65fb61844b3..6a8d81458ad 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3525,6 +3525,7 @@ F: migration/
>>>    F: scripts/vmstate-static-checker.py
>>>    F: tests/data/vmstate-static-checker/
>>>    F: tests/functional/test_migration.py
>>> +F: tests/functional/test_vmstate.py
>>>    F: tests/qtest/migration/
>>>    F: tests/qtest/migration-*
>>>    F: docs/devel/migration/
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>> index b317ad42c5a..9f339e626f6 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -76,6 +76,7 @@ tests_generic_bsduser = [
>>>    tests_aarch64_system_quick = [
>>>      'migration',
>>> +  'vmstate',
>>>    ]
>>>    tests_aarch64_system_thorough = [
>>> @@ -164,6 +165,10 @@ tests_loongarch64_system_thorough = [
>>>      'loongarch64_virt',
>>>    ]
>>> +tests_m68k_system_quick = [
>>> +  'vmstate',
>>> +]
>>> +
>>>    tests_m68k_system_thorough = [
>>>      'm68k_mcf5208evb',
>>>      'm68k_nextcube',
>>> @@ -230,6 +235,7 @@ tests_ppc_system_thorough = [
>>>    tests_ppc64_system_quick = [
>>>      'migration',
>>> +  'vmstate',
>>>    ]
>>>    tests_ppc64_system_thorough = [
>>> @@ -265,6 +271,10 @@ tests_rx_system_thorough = [
>>>      'rx_gdbsim',
>>>    ]
>>> +tests_s390x_system_quick = [
>>> +  'vmstate',
>>> +]
>>> +
>>>    tests_s390x_system_thorough = [
>>>      's390x_ccw_virtio',
>>>      's390x_replay',
>>> @@ -305,8 +315,9 @@ tests_x86_64_system_quick = [
>>>      'migration',
>>>      'pc_cpu_hotplug_props',
>>>      'virtio_version',
>>> -  'x86_cpu_model_versions',
>>> +  'vmstate',
>>>      'vnc',
>>> +  'x86_cpu_model_versions',
>>>    ]
>>>    tests_x86_64_system_thorough = [
>>> diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
>>> new file mode 100755
>>> index 00000000000..3ba56d580db
>>> --- /dev/null
>>> +++ b/tests/functional/test_vmstate.py
>>> @@ -0,0 +1,56 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# This test runs the vmstate-static-checker script with the current QEMU
>>> +
>>> +import subprocess
>>> +
>>> +from qemu_test import QemuSystemTest
>>> +
>>> +
>>> +class VmStateTest(QemuSystemTest):
>>> +
>>> +    def test_vmstate(self):
>>> +        target_machine = {
>>> +            'aarch64': 'virt-7.2',
>>> +            'm68k': 'virt-7.2',
>>> +            'ppc64': 'pseries-7.2',
>>> +            's390x': 's390-ccw-virtio-7.2',
>>> +            'x86_64': 'pc-q35-7.2',
>>> +        }
>>> +        self.set_machine(target_machine[self.arch])
>>> +
>>> +        # Run QEMU to get the current vmstate json file:
>>> +        dst_json = self.scratch_file('dest.json')
>>> +        self.log.info('Dumping vmstate from ' + self.qemu_bin)
>>> +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
>>> +                             '-M', target_machine[self.arch],
>>> +                             '-dump-vmstate', dst_json],
>>> +                            stdout=subprocess.PIPE,
>>> +                            stderr=subprocess.STDOUT,
>>> +                            text=True)
>>> +        if cp.returncode != 0:
>>> +            self.fail('Running QEMU failed:\n' + cp.stdout)
>>> +        if cp.stdout:
>>> +            self.log.info('QEMU output: ' + cp.stdout)
>>> +
>>> +        # Check whether the old vmstate json file is still compatible:
>>> +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
>>> +                                  self.arch,
>>> +                                  target_machine[self.arch] + '.json')
>>> +        vmstate_checker = self.data_file('..', '..', 'scripts',
>>> +                                         'vmstate-static-checker.py')
>>> +        self.log.info('Comparing vmstate with ' + src_json)
>>> +        cp = subprocess.run([vmstate_checker, '-s', src_json, '-d', dst_json],
>>> +                            stdout=subprocess.PIPE,
>>> +                            stderr=subprocess.STDOUT,
>>> +                            text=True)
>>> +        if cp.returncode != 0:
>>> +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)
>>> +        if cp.stdout:
>>> +            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
>>> +
>>> +
>>> +if __name__ == '__main__':
>>> +    QemuSystemTest.main()
>>
>> Thanks for this series Thomas, it's very useful.
>> Could we extend this automatically to test migration on all combinations:
>> {qemu-system-*} x {machine}?
>> We could generate a single list of references, containing hashes of all
>> outputs, and a simple and clean command to regenerate all those, and
>> associated jsons, so we don't pollute qemu code with tons of json.
> 
> I think a major challenge would be false positives, and how to filter
> them.. when we put anything into CI.
>

A fail would be expected everytime something changes:
- it can be a default field that has a new value (particularly sensitive 
for cpus)
- it can be a new cpu field that is added
- it can be a board definition change
- it can be a hardware related change

In all cases, even though it does not break migration, it's interesting 
to know such a change happen.
As well, if it's simple to update and get differences of the various 
dumps per {binary, board}, then it's trivial to identify and comment the 
"false positive". The more often it runs (ideally, per PR, or per 
series), the easier it is to identify what changed.

> Side note: yesterday I just wrote a script to do exactly this, by auto
> build binaries and check all relevant archs over all machine types
> supported.  It looks like this:
> 
> https://gitlab.com/peterx/qemu/-/commit/c4abfa39f8943cd62f0d982ecb36537df398ae70
> 
> The plan is I can run this at the end of each release, though.. not yet for
> CI.  I also don't have plan to upstream this script, maybe I'll keep it
> myself as of now unless someone thinks we should have it.
>

Glad to hear we have a script, but sad to hear "will run manually once 
every 6 months".

> PS: I just ran it over v9.2..v10.0 over the default 4 archs
> (x86,arm,ppc,s390) and a huge list was generated..  I believe most of them
> are false positives, I'll delay walking the list for some time..  I
> attached the result at the end in case anyone is interested.
>

Would that be possible to post this on an online forge like GitLab, and 
commit the previous and new versions of dumps (the data, not the list of 
failures), so we can see all the differences in a nice way?

>>
>> This way, we can automatically detect that we never regress, not only from
>> release to release, but commit to commit.
>>
>> In case we need to update reference, people can point what's the actual
>> difference in the commit message.
>>
>> As well, since I took a look into that before, this check is not enough
>> regarding migration. Beyonds the VMDstate, we should check as well that the
>> default values of every field are not changed. For instance, we recently
>> changed the default pauth property of arm cpus, and without a careful
>> backcompat, it would have break migration. It's a bit more tricky, since
>> there is nothing available now to dump this (I hacked that using a custom
>> trace). And definitely not something in the scope of your series, just worth
>> mentioning.
>>
>> I hope we can one day get rid of all "Is this change safe regarding
>> migration?" comments because we know we can trust our CI instead.
> 
> IMHO it's extremely hard (if not impossible) to guarantee that, because
> some migration bug may only trigger in special paths that not always
> happen, e.g. it can even involve guest driver behavior.
>

It would not cover 100%, but if we already make sure that a VM stopped 
at end of qemu_init() has a predictable dump, it's already a huge win 
over having nothing.
We can use the same argument that current QEMU CI does not cover 100% of 
the code (*much* less than that from what I tried), but it's still 
better than no test.

> Said that, Fabiano used to work on supporting device-specific tests in
> qtests/migration-test.c.  I don't think it landed but maybe we have room
> for specific device tests using qtests/migration-test.c framework.
> 
> https://lore.kernel.org/all/20240523201922.28007-1-farosas@suse.de/
> 
> Thanks,
> 

Regards,
Pierrick


