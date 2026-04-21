Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87FFF8FA94
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFD8j-0002iW-K4; Tue, 21 Apr 2026 11:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFD8W-0002eW-UL
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:35:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFD8T-0005XP-IK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:35:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so29354155e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776785724; x=1777390524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FHMi8h7Fn+GysCoJ54nKp2fCJyi0JqED1y7NK4Yge5U=;
 b=wkg9Cw0V5rlH1i6Bd0ljAIqzAnzcJ1JikI5wrBk+OgqKTjLlM8rR7oNOdcoxW9BkYd
 5GdtHtB26t1BT3n6v+epU7+n5INvrs/Xo/dUhZZgvahQLUzfLzUVxtdwp6NQgnPhTbva
 9rpGb//mqOfWYZykWjHlMp3bKp656fdDu6ZTsYaJTpjVn71/kjJUTE1uyMBEErH1bZo2
 2AjC8omCPwVL2ERnajVxRPfhMmQKx3/MTwmAC9DPdYKj/83WznZb+sznwnT9bt30BogK
 BueHDWozgG8S4k6T5yhk7n7TL3k7M2Ij+Esps/GLEXAbIArvcQ+I0Unq+X4b2MNZMDQz
 Fd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776785724; x=1777390524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FHMi8h7Fn+GysCoJ54nKp2fCJyi0JqED1y7NK4Yge5U=;
 b=bMdF+l4Pt1h+aPLlATQ/lJ8ojyontKlWkbvFL8JZ9lvBXfGCqeYM0UDkfaQsS2rpej
 iX2nbzQJ4Kwd+s8fsRsIzZeb9ZgnINrvu7NNfduStPgyZUtl7PG/S4S+sd7B0bv3O1+F
 yCy8H6ibKOCvRd8ttl8/wHizwz83kJ+r+4YuJ3PfV2eYdATnhdsxQoFyVz4U/MOW58c4
 SHV77KLSHMfA/Kkdj5bHzJW3WwH639IN76J4QsAv72FCjxBFXHqMIgKCJ/9QhT3nBFCw
 BlHG2v3SdmeuJSDSu+WzyOwixrOQ0XkJCvz0LsZrXsOmKDlfDMBeBdLT+SLQBvMw282l
 A4tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9IBbMrcQiSe9po04exhRsJsQJ5SEas6C3bBbUfHwb+NSbpelO/g759IYIQDDzDN0mgXoOy0NT1fw2@nongnu.org
X-Gm-Message-State: AOJu0YxSSAX8CMfjyfdLnkai+lRnEVmX/iuVaRbZK+QNnJtLs4BhS9rD
 1j2EhSVGKFgs66DSBtOz3NYbh76Ya1pDLmvm5NRIdWEjGJsV/xviQby64g8GcpGorr8=
X-Gm-Gg: AeBDievSYFm4ovttNQC1Vtyi+KFpYL0MfV0g4ys+ZjY4kSTolr9HHHQo+rlQrm3I226
 dHBqeAWMY2ie4Tj14SU3TzRhTnd5HCS2CSpLwBSRMqsiLOgoRDXkKsdkrZcyCmq/FeulKXmxl0q
 o7gzwQAglClHWIo8kk20+c/UHaT0d1L8xW5Uz+C60fxwQ2KqHw+63i4B9PwNFdZCzjj9fMyHcUJ
 k7bYV1ockLKEu/LUcw0xqxedGTO4gcL7DTss1AtIMmOs6JU6K+jCAbsxcOxtfw3xtUu5rV7nDsT
 a99g/bg+K974blsWasruqBOdUKARHuYmj4ESBoU2oRxZCR/DpNkzkgJe/gArLKU+Y+rIa5Yj78M
 hUZTLk27OiaRxAkDTQLPZNNjo1Mnpq9mLphMA6vjafKTiZJtFfm4c9acjFDpaBjAl6LPN08UWhy
 WnAfsOpfSaUlKPf4TBUTa2XSK126WUDRXgefaztBmx+p93Mu9jxGbLy2zfBf4hLKfCC8iK
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a52f2a5f0mr85008665e9.18.1776785724332; 
 Tue, 21 Apr 2026 08:35:24 -0700 (PDT)
Received: from [10.193.39.66] (140.170.88.92.rev.sfr.net. [92.88.170.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm627725225e9.3.2026.04.21.08.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 08:35:23 -0700 (PDT)
Message-ID: <c0fbd10c-9e6b-4d6d-8c5c-92645d2746d9@linaro.org>
Date: Tue, 21 Apr 2026 17:35:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] tests/functional/riscv64: Add tt-atlantis tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-12-joel@jms.id.au>
 <87ba28f4-aeab-4015-8f9c-9d3a53c0cb7a@linaro.org>
 <aedEGxGq1qKhGI5d@lima-default>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aedEGxGq1qKhGI5d@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/4/26 11:45, Nicholas Piggin wrote:
> On Tue, Apr 21, 2026 at 08:05:48AM +0200, Philippe Mathieu-Daudé wrote:
>> On 21/4/26 07:31, Joel Stanley wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
>>> tests/functional/riscv64/test_sifive_u.py.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>> v3:
>>>    - Fix path to test files
>>>    - Dedupe command line root argument
>>>    - Remove unused import
>>> ---
>>>    MAINTAINERS                                  |  1 +
>>>    tests/functional/riscv64/meson.build         |  1 +
>>>    tests/functional/riscv64/test_opensbi.py     |  4 ++
>>>    tests/functional/riscv64/test_tt_atlantis.py | 63 ++++++++++++++++++++
>>>    4 files changed, 69 insertions(+)
>>>    create mode 100755 tests/functional/riscv64/test_tt_atlantis.py
>>
>>
>>> diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
>>> new file mode 100755
>>> index 000000000000..f6f4b7ceec34
>>> --- /dev/null
>>> +++ b/tests/functional/riscv64/test_tt_atlantis.py
>>> @@ -0,0 +1,63 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Functional test that boots a Linux kernel on a Tenstorrent Atlantis machine
>>> +# and checks the console
>>> +#
>>> +# Copyright (c) Linaro Ltd.
>>> +# Copyright 2026 Tenstorrent
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import os
>>> +
>>> +from qemu_test import Asset, LinuxKernelTest
>>> +
>>> +
>>> +class TTAtlantis(LinuxKernelTest):
>>> +
>>> +    ASSET_KERNEL = Asset(
>>> +        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
>>> +        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
>>> +    ASSET_ROOTFS = Asset(
>>> +        ('https://github.com/groeck/linux-build-test/raw/'
>>> +         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
>>> +         'rootfs.ext2.gz'),
>>> +        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
>>> +
>>> +    def do_test_riscv64_tt_atlantis(self, connect_disk):
>>> +        self.set_machine('tt-atlantis')
>>> +        kernel_path = self.ASSET_KERNEL.fetch()
>>> +        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
>>> +
>>> +        self.vm.set_console()
>>> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon=sbi '
>>> +
>>> +        if connect_disk:
>>> +            kernel_command_line += 'root=/dev/vda panic=-1 noreboot rootwait '
>>> +            self.vm.add_args('-device',
>>> +                             'virtio-blk,drive=drive0,serial=0x1234,bus=pcie.0')
>>> +            self.vm.add_args('-drive',
>>> +                             f'file={rootfs_path},if=none,id=drive0,format=raw')
>>> +            pattern = 'Boot successful.'
>>
>> Should we run a full shutdown to test up to the halting payload
>> (patch #4)?
> 
> Halting payload is only used when there is no kernel given, not sure if
> it's good cost/benefit to test that, it's just in case user screw up
> they don't get blank screen apparent hang.
> 
> A shutdown test all the way to machine halt would be good, although I
> don't know if we model that properly in the atlantis machine yet. Maybe
> something to expand on later.

OK, then we are good.

>>> +        else:
>>> +            kernel_command_line += 'panic=0 noreboot '
>>> +            pattern = 'Cannot open root device'
>>> +
>>> +        self.vm.add_args('-kernel', kernel_path,
>>> +                         '-append', kernel_command_line,
>>> +                         '-no-reboot')
>>> +
>>> +        self.vm.launch()
>>> +        self.wait_for_console_pattern(pattern)
>>> +
>>> +        os.remove(rootfs_path)
>>
>> Since you call uncompress() with implicit @target=None argument,
>> scratch_file() is used:
>>
>>          Construct a path for accessing/creating a scratch file
>>          located relative to a temporary directory dedicated to
>>          this test case. The directory and its contents will be
>>          purged upon completion of the test.
>>
>> So IIUC no need to remove manually. Do you have an issue with it
>> to remove it manually?
> 
> No, I just copied it from tests/functional/riscv64/test_sifive_u.py :)
> and looks like same pattern exists in a couple of other tests as well.

Good opportunity to clean it ;)

> 
>>
>> Otherwise,
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks,
> Nick


