Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DABC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0LX-0008RR-PA; Tue, 07 Jul 2026 03:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh0LV-0008R0-P1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh0LT-00075U-9Z
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783409754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OFHW1cBmWJtrj0tPMdxE8hn8T5GG0TprzcllFMJSj4w=;
 b=BH4f1sczUD6bNOfyJaFlg4U4JhOgdj6gJixsmDeL8sSGkCrIVfqIbqLjWjNPwtCjHZdGFH
 1zCTWw5SyJY3hXacSSTzrc4SsOykqjI8nsetFtUyOG2L7M2rlo6CbfI7vqwuBtw/Wscv2R
 k0VI1aOsvD1/b4NTgg9J0ggpcGvMdUU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-R_pvKSDWObmHOOS93uQZ_w-1; Tue, 07 Jul 2026 03:35:52 -0400
X-MC-Unique: R_pvKSDWObmHOOS93uQZ_w-1
X-Mimecast-MFC-AGG-ID: R_pvKSDWObmHOOS93uQZ_w_1783409752
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-476d52b13d7so2936039f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783409751; x=1784014551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OFHW1cBmWJtrj0tPMdxE8hn8T5GG0TprzcllFMJSj4w=;
 b=WJLQ9nwgoW4fhg/VqqCfR8VRoUk7jd4kCEcHCjv8r7kO/bMbZ+EWuw9SdCPITs7Mq4
 7SUndUXjSp/uEeB0Wrp49Qs6xqZGtikfRR9PFjMDwtr0AfG81hIrsEQEBP8K2rKuFjTM
 /j9Ms84kpbwjqad4noPMHCPj15O7uNFHOkHPiWel00URkdJ0Dz2DWTnOvmhfAYQJb1rM
 z7exUwd2LIKduXVhEvY1p6s3uvk7p9VWCAj6eSJNvx1dkec2smI4HokOH3vjKSh0Oj3r
 Rb/CpH2vZBgbkRF6dHKQo/43u+hIvF/loha/FOARGDNvF+9AAuGkCGNTinAWMmwxHPg9
 Rzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783409751; x=1784014551;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OFHW1cBmWJtrj0tPMdxE8hn8T5GG0TprzcllFMJSj4w=;
 b=DUcbV3cnC1QzcjlvXyvVyLwHHjm0XcUNg1s2xkdPuLx1HKXAJHTMYL80c3OyuAHdOW
 DDjWXcVb6fwvQySfNS6XC2VIVR6f4Sh1a+bV6XeO7KSlyX13a3cOmUWViYN+hjppN39k
 wBWiZk7LHNPN9hxPydtOcD4okeYXa4+81mQhql3ojhXhxj27MkDbdOWCzs7J1ClbG51t
 K6p4imXOObgQq0bqOEQVDvrS+GnD5fwujjb1LNc2GA6UMvyMjTzuSIX3iI3NVm6akxE9
 CQKPl7iKqZs463h/oAoH0l24aVYVAa8LmQC1WwTU4edrKurZG60nOO3ufSfs04IAe/VZ
 69TA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2EnfZBKi2yjlbgmtE8Em8FYKD6miH8RkKKgYrV2/uc7eehj2Y/pNQFHS4kA9pYjHhnMFCVYBb0mnQ@nongnu.org
X-Gm-Message-State: AOJu0YycgP7NrS3HqghN19fafs5VMCpYtA6dA3bfTU/vGDr9yVr8Ej0H
 wEgYf9LA/PkJXIlSm5mH34X8GKxAgW9d2Rb/sDP8laBN7odLRyqjzqD6FLBRz78m96yceQ1KsVw
 UW8W8Zd4Ftw8ppgwIUYbn+CvYVcik4osaoYmzH0eGMPNO4esa8SMLEC3h
X-Gm-Gg: AfdE7cnDf93kUmC9AgL72M+mufb+jdFZt0G/v3YwZoLq8TOSypj0K0swqZwqllk+JPv
 IJKGZFzPoWQ1SF4KDRx5AdH6uagtbVzL4BmIHRu0U8dnc0d3K5a570N8B4KYKPIPHSf1hySWQKE
 UBZutgPwOEO8u+HywUCFNQ8fZ9BlzJYh6+/nbmSLLGZTAd6Z0U2OHhzc3uMhQY/69agdeho2VTF
 RqN1aeS7rsbbLmt9Xp5oilsAyYv3WUPLKRT766Md5cRi26hwuFsnUBcYXXIg2jtCz6ufE1cQFn/
 XOj9AWQIDaVE7G2Zj2NWFiNkLzSF5yIL4ovL30QUXsniRyycuIRUj0ha5iuaN7wM8y8Xz0UiTIQ
 MM50X8VsvNS8BFORD/2j7+jmSprEze3EuerrFZgdW6Rc+bCH2Ug==
X-Received: by 2002:adf:e909:0:b0:475:f0d1:eb5d with SMTP id
 ffacd0b85a97d-47de66e3e5amr3351501f8f.56.1783409751563; 
 Tue, 07 Jul 2026 00:35:51 -0700 (PDT)
X-Received: by 2002:adf:e909:0:b0:475:f0d1:eb5d with SMTP id
 ffacd0b85a97d-47de66e3e5amr3351441f8f.56.1783409750613; 
 Tue, 07 Jul 2026 00:35:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm32772922f8f.0.2026.07.07.00.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 00:35:50 -0700 (PDT)
Message-ID: <e23912fe-bcfa-475a-803e-caa46797f92f@redhat.com>
Date: Tue, 7 Jul 2026 09:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/12] tests/data/vmstate-static-checker: Add dump files
 from QEMU 7.2.17
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, cohuck@redhat.com
References: <20250924063956.519792-1-thuth@redhat.com>
 <20250924063956.519792-6-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250924063956.519792-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/24/25 08:39, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> For automatic tests, we need reference files from older QEMU versions.
> QEMU 7.2 is a long term stable release, so it's a good candidate for
> checking whether the migration could still work correctly. Let's add the
> files from that version that have been taken with the "-dump-vmstate"
> parameter of QEMU (compiled with single machines and the configure switch
> "--without-default-devices" to keep the json files reasonable small).
> 
> Some devices also have been removed manually from the json files, e.g.
> the "pci-bridge" (which can be disabled in later QEMU versions via Kconfig),
> and some Linux-related devices like "scsi-block" and "scsi-generic" and
> KVM-related devices. Without removing them, we might get errors otherwise
> if these devices have not been compiled into the destination QEMU build.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20250912100755.316518-4-thuth@redhat.com>
> ---
>   .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
>   .../vmstate-static-checker/m68k/virt-7.2.json | 2936 +++++++++++++++
>   .../ppc64/pseries-7.2.json                    | 1068 ++++++
>   .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
>   .../x86_64/pc-q35-7.2.json                    | 3297 +++++++++++++++++
>   5 files changed, 10347 insertions(+)
>   create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
>   create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
>   create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
>   create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
>   create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json

On a s390x host, this test fails :

▶ 108/658 test_vmstate.VmStateTest.test_vmstate_7_2                                   FAIL
108/658 qemu:func-quick+func-s390x / func-s390x-vmstate                               ERROR            0.23s   exit status 1
>>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MALLOC_PERTURB_=8 MESON_TEST_ITERATION=1 QEMU_TEST_GDB=/usr/bin/gdb LD_LIBRARY_PATH=/home/legoater/work/qemu/qemu.git/build/tests/tcg/plugins:/home/legoater/work/qemu/qemu.git/build/contrib/plugins QEMU_TEST_QEMU_BINARY=/home/legoater/work/qemu/qemu.git/build/qemu-system-s390x PYTHONPATH=/home/legoater/work/qemu/qemu.git/python:/home/legoater/work/qemu/qemu.git/tests/functional QEMU_TEST_QEMU_IMG=/home/legoater/work/qemu/qemu.git/build/qemu-img RUST_BACKTRACE=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MESON_BUILD_ROOT=/home/legoater/work/qemu/qemu.git/build /home/legoater/work/qemu/qemu.git/build/pyvenv/bin/python3 /home/legoater/work/qemu/qemu.git/tests/functional/generic/test_vmstate.py
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
Traceback (most recent call last):
   File "/home/legoater/work/qemu/qemu.git/tests/functional/generic/test_vmstate.py", line 55, in test_vmstate_7_2
     self.fail('Running vmstate-static-checker failed:\n' + cp.stdout +
AssertionError: Running vmstate-static-checker failed:
Section "s390-sclp-event-facility ", Description "vmstate-event-facility": expected field "receive_mask_pieces[1]", got "receive_mask_pieces[0]"; skipping rest
Section "s390-sclp-event-facility", Description "vmstate-event-facility/mask64": expected field "receive_mask_pieces[0]", got "receive_mask_pieces[1]"; skipping rest


The reason seems to be that the reference JSON s390-ccw-virtio-7.2.json
file was generated on a little-endian host (x86_64), s390x is big-endian.

The fix could be in vmstate-static-checker.py to treat
receive_mask_pieces[0] and receive_mask_pieces[1] as interchangeable.
Or regenerate the vmstate on s390x and skip the test on other
platforms. What do you think ?

Thanks,

C.


