Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ABDC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0sI-0002h3-Su; Tue, 07 Jul 2026 04:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh0sG-0002gH-IS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh0sE-0005Ki-FV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783411784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XPSnaQu5SlWRi9R11DSnj7ixYVNfzyRWFjjo9CaVSDM=;
 b=H+zfBvz0LelCcicV9nZrwDmuwHi92izK01e6umerKTOj0NHsVDfqGSznTdgMMtvM6dZiak
 cpp6ZnsdXVwFleAcBvCHTlzDePqbzFVuLQ3iC+yggLwlU27BhzkJFpc8FwnwfBAHI+S0/s
 D2AjBT0Ab9BhqG79OzahColcLAkH5yI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-VIaylUWAM9C7WsgUIjGB4Q-1; Tue, 07 Jul 2026 04:09:43 -0400
X-MC-Unique: VIaylUWAM9C7WsgUIjGB4Q-1
X-Mimecast-MFC-AGG-ID: VIaylUWAM9C7WsgUIjGB4Q_1783411782
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so2149099f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783411782; x=1784016582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XPSnaQu5SlWRi9R11DSnj7ixYVNfzyRWFjjo9CaVSDM=;
 b=DTVRj2iwqkTrvR3tTnZNytCnafQ6FdeQYm7pYENCTMV/NJh6aBo3EiIWhQwnjBBmPQ
 SJ/V4xv1/KwAbh5a5UT0BF6GBEtiTY8/1qHjlHy8li701MeYaSPTjh5zx1BoNrfOpvrd
 6fq9KXhcjYn0fWVSrmF2OdgK8V0b4nkigiKIQLmenQS2cJR4J5In0X+FTzslvJjNFw9i
 /H0aH9qQB+fyKyQ9mZuvWxUUMlcaeCSNDdLF29zdvR+2/eGcBYiHDwUSU2suwcOJ+i/Z
 ZdXMhdwTV1xghMdakvwYrUZ3kf+0THr4F+Dimj+7CH4d4vSwBjtQMSMoGaIEUtbQiwwp
 ki7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783411782; x=1784016582;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XPSnaQu5SlWRi9R11DSnj7ixYVNfzyRWFjjo9CaVSDM=;
 b=Tj1IIaGLTTnxMvLVs8FRShZUoo9Tn430CB99qhmHOHWDUuakc0ViRPhprd5MYEPBNU
 ousbgcjhQS2MNj0wvLX+C961nJy7h1AnGzvg9PacLBqG3DrEWD5NcYbPNcI0z0Ibj3os
 bjT8rmnGMBuMxAotQvnH+vAWlNxjmpkKT+xCu0rY/uh+4D7L1eLE2enHyIUV7W2vrn+m
 uCpSXOLbSe4Bq/WR6Ve3Ng5A93AryrKL/VDkE/+A3unGXr8MKHADc8eULfQxsVvi5jHC
 rhmACZAeyQV/jw/+WIxPuIzIY3WWztZkTZHv0WCQ6TJDrFECI0I3U6FTqHmJDT1fZtyd
 hWrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgKviS5cYvnFyMiCbDztb3+Rk2RwBsE5HVEVCROYd7CDhfQCThg7D5IP0v49bTjWJjQLNcSuptacsY@nongnu.org
X-Gm-Message-State: AOJu0YyR8thR6MDOIUA/NkDC+neQxnwYV24iZMmALfiK0yl7W1KppBnx
 sUgr2vbqYv7WC+3xgKSqeDveAaf0kLPRymdafNsb+jc0SumRlfwMal9nu9FK6UWWlNkH4DXF41j
 bXNhDx3i39Dgzrw2ObU86P+Lb24f7yJFlgYuPZH4noFqj6H2RaVxwMwTo
X-Gm-Gg: AfdE7ckiVr4BvguhXHYK3sXVt2lvfUNoCR4xaDpq4CuFRaKNyiIgZMa5mltc4jke8jI
 R8kwbRjlKZVrDaN/gaWqcDSlK1VxXl82AUQl59eFSTdlPNFix5C0SPtDzBQDWtLGR1GT3tSPDaZ
 2Ns0YcQDXTn5lz8rjcdTqIpn2LOiSIu65Xac03XBsNCF5R5q3fqGTLx17AM1Qu+NDpO+bVl+JEa
 4B4iN2PhkXxZ77ZK92FvALTC8opTMWYVL+AfrAe6YxNp5zVXZ3xIWIZZznRhMxbPccpYD/bfX99
 3nIm7NfyUMwexuVvMpdmZe1YnrscurDJqsV//GjnJbbj/+5IZe8+f64yObFtggG9DYE9LLbh59J
 q/BFY0A==
X-Received: by 2002:a5d:40d2:0:b0:46e:230f:d095 with SMTP id
 ffacd0b85a97d-47de6651062mr2997941f8f.7.1783411781796; 
 Tue, 07 Jul 2026 01:09:41 -0700 (PDT)
X-Received: by 2002:a5d:40d2:0:b0:46e:230f:d095 with SMTP id
 ffacd0b85a97d-47de6651062mr2997915f8f.7.1783411781362; 
 Tue, 07 Jul 2026 01:09:41 -0700 (PDT)
Received: from [10.22.2.34] ([91.26.127.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e3e2702sm32342253f8f.9.2026.07.07.01.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 01:09:40 -0700 (PDT)
Message-ID: <d6a7e355-4df1-4be3-a537-9ea01c9c27a3@redhat.com>
Date: Tue, 7 Jul 2026 10:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/12] tests/data/vmstate-static-checker: Add dump files
 from QEMU 7.2.17
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, cohuck@redhat.com
References: <20250924063956.519792-1-thuth@redhat.com>
 <20250924063956.519792-6-thuth@redhat.com>
 <e23912fe-bcfa-475a-803e-caa46797f92f@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e23912fe-bcfa-475a-803e-caa46797f92f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/07/2026 09.35, Cédric Le Goater wrote:
> On 9/24/25 08:39, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> For automatic tests, we need reference files from older QEMU versions.
>> QEMU 7.2 is a long term stable release, so it's a good candidate for
>> checking whether the migration could still work correctly. Let's add the
>> files from that version that have been taken with the "-dump-vmstate"
>> parameter of QEMU (compiled with single machines and the configure switch
>> "--without-default-devices" to keep the json files reasonable small).
>>
>> Some devices also have been removed manually from the json files, e.g.
>> the "pci-bridge" (which can be disabled in later QEMU versions via Kconfig),
>> and some Linux-related devices like "scsi-block" and "scsi-generic" and
>> KVM-related devices. Without removing them, we might get errors otherwise
>> if these devices have not been compiled into the destination QEMU build.
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Message-ID: <20250912100755.316518-4-thuth@redhat.com>
>> ---
>>   .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
>>   .../vmstate-static-checker/m68k/virt-7.2.json | 2936 +++++++++++++++
>>   .../ppc64/pseries-7.2.json                    | 1068 ++++++
>>   .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
>>   .../x86_64/pc-q35-7.2.json                    | 3297 +++++++++++++++++
>>   5 files changed, 10347 insertions(+)
>>   create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw- 
>> virtio-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
> 
> On a s390x host, this test fails :
> 
> ▶ 108/658 
> test_vmstate.VmStateTest.test_vmstate_7_2                                   
> FAIL
> 108/658 qemu:func-quick+func-s390x / func-s390x- 
> vmstate                               ERROR            0.23s   exit status 1
>>>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MALLOC_PERTURB_=8 MESON_TEST_ITERATION=1 QEMU_TEST_GDB=/usr/bin/gdb LD_LIBRARY_PATH=/home/legoater/work/qemu/qemu.git/build/tests/tcg/plugins:/home/legoater/work/qemu/qemu.git/build/contrib/plugins QEMU_TEST_QEMU_BINARY=/home/legoater/work/qemu/qemu.git/build/qemu-system-s390x PYTHONPATH=/home/legoater/work/qemu/qemu.git/python:/home/legoater/work/qemu/qemu.git/tests/functional QEMU_TEST_QEMU_IMG=/home/legoater/work/qemu/qemu.git/build/qemu-img RUST_BACKTRACE=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MESON_BUILD_ROOT=/home/legoater/work/qemu/qemu.git/build /home/legoater/work/qemu/qemu.git/build/pyvenv/bin/python3 /home/legoater/work/qemu/qemu.git/tests/functional/generic/test_vmstate.py
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> stderr:
> Traceback (most recent call last):
>    File "/home/legoater/work/qemu/qemu.git/tests/functional/generic/ 
> test_vmstate.py", line 55, in test_vmstate_7_2
>      self.fail('Running vmstate-static-checker failed:\n' + cp.stdout +
> AssertionError: Running vmstate-static-checker failed:
> Section "s390-sclp-event-facility ", Description "vmstate-event-facility": 
> expected field "receive_mask_pieces[1]", got "receive_mask_pieces[0]"; 
> skipping rest
> Section "s390-sclp-event-facility", Description "vmstate-event-facility/ 
> mask64": expected field "receive_mask_pieces[0]", got 
> "receive_mask_pieces[1]"; skipping rest

Ugh, that's ugly!
> The reason seems to be that the reference JSON s390-ccw-virtio-7.2.json
> file was generated on a little-endian host (x86_64), s390x is big-endian.

Ack.

> The fix could be in vmstate-static-checker.py to treat
> receive_mask_pieces[0] and receive_mask_pieces[1] as interchangeable.
> Or regenerate the vmstate on s390x and skip the test on other
> platforms. What do you think ?
Easiest work-around for the test is likely to drop the 
""s390-sclp-event-facility" section from 
tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json, so that it 
does not get checked at all anymore.

But note that there is a real bug here. This:

/* we need to save 32 bit chunks for compatibility */
#ifdef HOST_WORDS_BIGENDIAN
#define RECV_MASK_LOWER 1
#define RECV_MASK_UPPER 0
#else /* little endian host */
#define RECV_MASK_LOWER 0
#define RECV_MASK_UPPER 1
#endif

from commit 98e43b71b25330566d902fbdc8fe35041c2decbe will also break 
migration e.g. from a big endian TCG host to a little endian TCG host.

To fix it properly (at least for new machine types), it's maybe best to 
introduce a proper 64-bit field for new machine types, and handle the chunks 
as good as possible for old machine types... Anybody wants to have a try to 
cook a patch?

  Thomas


