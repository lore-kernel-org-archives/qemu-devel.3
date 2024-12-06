Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE0EE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJah1-0004Pa-Vv; Fri, 06 Dec 2024 10:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJagq-0004OH-Bs
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJagk-0005lz-Vn
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733500576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hzTWMZjCfbSzqwoEJqLZnnszapFVnAw2IWE9efqvHdM=;
 b=V5aSWyA/Fy62zi9eZjy4YmfM975rrHHM89I5b89E4JYahbMJL19QDcjLrm3ImeEhPehQol
 ORnnLR4V9GGItDjA95oTCzToWHimdelxay9GdR5jRQprAojWbWuxuce9zNx2Mvo8oSgYPv
 ezn3oyygwxJdVIuUMriY7y7pEADxOi8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-AURzpDKQN6ChnfgicrZT3g-1; Fri, 06 Dec 2024 10:56:15 -0500
X-MC-Unique: AURzpDKQN6ChnfgicrZT3g-1
X-Mimecast-MFC-AGG-ID: AURzpDKQN6ChnfgicrZT3g
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385dfa9b758so973969f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500574; x=1734105374;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzTWMZjCfbSzqwoEJqLZnnszapFVnAw2IWE9efqvHdM=;
 b=doL9yTPpVoXacdUqFniU3F2/ScBkm/dEG6+D1rYkLanhmrU+tCNqgBh2b/sS+RGA0b
 urEumKPx2/lK7rgRp0zcF5nGKKm10XPXRk5YS9Gkax8++tgIX5mxP8UfYaIfVlyJ4ePD
 LkoItFYkjohXQJEE1HJp+Ka1hnmaoncL+gycBATSR4god/VIo8QM2q6m3Puo0sQvS/05
 SothvVO2kQ4DOJluusI8zMHDwjI9JVuMnxlnAsu2Xltt4EwXyjjw5xegAO2MRKQZa/4z
 1/RjDO3/9Qfw1fkmiBepgfydUv0XgNkppSYYkIYkkDnA4j8CB0EyvCC0397BjKgXPY85
 bznw==
X-Gm-Message-State: AOJu0YzZzJZwW8Drl3Ufjg72a5EbD56hdP9y9oT+Ey6oHDHZiLdqfwfK
 oPNl26LKx/xTkAiQpRFGL/FZDYm5P1UlDJRMZBdsLAik7DMIRCOtINq97LK2H3eHZHPfgBS7s/q
 l9fX4AfCeIICq2vhGsf+S2oNotrMzKQYo5vWptxZE46tjzOB/Qt8N
X-Gm-Gg: ASbGncuwVvSff1pVdPWxQjFoFalSxK6Pe34ghCtd1ozUpytAvvzvYMFRiegToI5vSzq
 7KCpSSOmkXsYDL9KtQc+V0UI9pu/0ffOp032JFTzjbT2NHvAOjgsRzwokzG+oQ4pD1UEbK+9a4q
 wSqRKzvF6WvpM8sU1uPQCphNT3m1MJLolqWzpMLnn/9YgrUk1Vlig12ga9wj2mrhHyCuAqM+fdM
 EbTqGXl0B+u5un4lBlbu6CwXm8nHiC0HCaKm/lsynoaw9VXLf5wzoMZZWpP7hbL5PTVHtOTwDBv
 XXqewQ==
X-Received: by 2002:a5d:6d8a:0:b0:385:f0d2:c34 with SMTP id
 ffacd0b85a97d-3862b3e6007mr2541433f8f.49.1733500574053; 
 Fri, 06 Dec 2024 07:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmTa5OTh47wB3OUP71hpA5SDinG9/SiyPy7U4Xt2IfBs0wszUr657wFLSaIzJQn6UvPYAp1g==
X-Received: by 2002:a5d:6d8a:0:b0:385:f0d2:c34 with SMTP id
 ffacd0b85a97d-3862b3e6007mr2541420f8f.49.1733500573666; 
 Fri, 06 Dec 2024 07:56:13 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4087sm4962463f8f.5.2024.12.06.07.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 07:56:13 -0800 (PST)
Message-ID: <86b6f948-6ddf-481e-81e1-de5ee27b6dbd@redhat.com>
Date: Fri, 6 Dec 2024 16:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/functional: Extract the find_free_ports()
 function into a helper file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20241204071911.664057-1-thuth@redhat.com>
 <20241204071911.664057-3-thuth@redhat.com> <Z1Ay61hpfABc6n33@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z1Ay61hpfABc6n33@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 04/12/2024 11.46, Daniel P. Berrangé wrote:
> On Wed, Dec 04, 2024 at 08:19:08AM +0100, Thomas Huth wrote:
>> We'll need this functionality in other functional tests, too, so
>> let's extract it into the qemu_test module.
>> Also add  an __enter__ and __exit__ function that can be used for
>> using this functionality in a locked context, so that tests that
>> are running in parallel don't try to compete for the same ports
>> later.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/qemu_test/ports.py | 53 +++++++++++++++++++++++++++++
>>   tests/functional/test_vnc.py        | 36 +++++---------------
>>   2 files changed, 61 insertions(+), 28 deletions(-)
>>   create mode 100644 tests/functional/qemu_test/ports.py
>>
>> diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
>> new file mode 100644
>> index 0000000000..d235d3432b
>> --- /dev/null
>> +++ b/tests/functional/qemu_test/ports.py
>> @@ -0,0 +1,53 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Simple functional tests for VNC functionality
>> +#
>> +# Copyright 2018, 2024 Red Hat, Inc.
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import fcntl
>> +import os
>> +import socket
>> +import sys
>> +import tempfile
>> +from typing import List
>> +
>> +class Ports():
>> +
>> +    PORTS_ADDR = '127.0.0.1'
>> +    PORTS_START = 32768
>> +    PORTS_END = PORTS_START + 1024
>> +
>> +    def __enter__(self):
>> +        lock_file = os.path.join(tempfile.gettempdir(), "qemu_port_lock")
>> +        self.lock_fh = os.open(lock_file, os.O_CREAT)
>> +        fcntl.flock(self.lock_fh, fcntl.LOCK_EX)
>> +        return self
>> +
>> +    def __exit__(self, exc_type, exc_value, traceback):
>> +        fcntl.flock(self.lock_fh, fcntl.LOCK_UN)
>> +        os.close(self.lock_fh)
> 
> This code will leave '/tmp/qemu_port_lock' existing forever.... which is
> correct, because if you try to unlink it after closing, you'll introduce
> a race because the 2nd __enter__ will now be locking an unlinked file,
> and a 3rd __enter__ that comes along will create & lock an entirely new
> file.
> 
> There are ways to make this safe by using stat + fstat either side of
> LOCK_EX, in a loop, to detect locking of an unlinked file. That is
> overkill though.  It is simpler to just put the lock file in the build
> directory IMHO, and thus avoid needing to care about unlinking - that'll
> be done when the user purges their build dir.

Putting the lock in the build directory is a nice idea - but it will fail if 
the user is using multiple build directory and running the test in the 
multiple directories in parallel. But maybe we could ease that situation by 
randomizing PORTS_START based on a seed calculated somehow by the build 
directory string?

  Thomas


