Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4707BC3ABC9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 12:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHiDp-0002Cf-BI; Wed, 21 May 2025 08:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHiDe-0002C9-RV
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHiDU-0006M6-7u
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747829193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SkLn7LJzVBQLwo9TZ12ga5ZwsyagVTKXTqYGs3uNETQ=;
 b=eHslpK1xP7JSZUzrJ27yMZJOgbvxiHsvgStyHrUt3fqAv8ZJWQ+JWeqNQd1l5O2gpUEZB6
 bNyvrefjoKRIzbJFk+kGMFwGQBgNKpyAZ3uY+0fi3lOZcE2jiOgb2oGBsVCxNFJThjwfvY
 AXyhHQM4RTvwYlNbLzG7i1TeiEyYxgk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-WDay0rS8ObmIojcSxTnR_A-1; Wed, 21 May 2025 08:06:30 -0400
X-MC-Unique: WDay0rS8ObmIojcSxTnR_A-1
X-Mimecast-MFC-AGG-ID: WDay0rS8ObmIojcSxTnR_A_1747829190
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso28465495e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 05:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747829189; x=1748433989;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SkLn7LJzVBQLwo9TZ12ga5ZwsyagVTKXTqYGs3uNETQ=;
 b=HzNIn4kFuD4uN8/NpREjZjnywW8OOHlb0u+3REEZl/ctUrCPRsHDRAQgfQdULir9s4
 L11ejRljW/1dsz9rEIzXkfcsUGBbeAYTb+G08mnLXeiyieil0L/cndmPXJzNs/r8it7X
 X4gqASWBuQKB8VA4fdwBDH55GFoR1jLMx50BnCqORUK9fFoJPeMrH2j1SQTUERxQTRz8
 svKInVLKAJksmgWDwsigxo4i6sNDceTAwwP02qX0ZNMGLAAf3YevPZSM3aPEA+ktcsTW
 B2FYgIXMOcsAHsrwHCeTWVegplMl2ioNgyTvQCG5cyaSo/1UwZieRF5V1qtAeuiavYBB
 B7rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJqI56fuEzVIWZ5gc3D/YfLu8WYZ4vnOlryCD5WpfOk2LcgP3dRnTz2xn1pUc0k5O3QZRtqLq8gXJm@nongnu.org
X-Gm-Message-State: AOJu0YxDUKQQ266CrTGfOGjw5/i1dxGxBTSarxSrHi2IkfJargbfFRE9
 8mQ3PRDWZ5IrIjDoTnq1Oa41Ljk/VkpSaIkcF7DWh/dPGz47bS2LQoJs8N+PV8V8Q3gRE7zDGW4
 tiMOO83nJ8JqEb6WmRnEASoNiTjYpjrKjpKXrESlYdNt2GRTuYJ+4tkyN
X-Gm-Gg: ASbGncux9n8ru7di3Ca7cFS/96saR8Q7cjre6aq1d3pV+uwzNKtzoHcNz6e6zW3H0tP
 s3pLQLT6Z/daDKmbKwudNIgTqv0h+SXpGgXa8kteY0f2rnJFOgH0tPa8WcMex+84Y28+K2w+TER
 d3WTODvuy5VUQuEhBnQ35CpHUtGZTe5B3nXHB5J20a+D+Z6wVmXbvVZxm8pmJTaQtrIf6F/MUj5
 vT5o439BhUAd8V69XZfDJVQw8GO2leAPU5Qs2gugAPAkEi8sXNowozRZ4pMZ57o7aETaATkntsN
 6IYc9cBSA2tARjF0Z0NKtbIqI/rfJIGwOeQapIXfALU=
X-Received: by 2002:a05:600c:1547:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-442fd672078mr158631445e9.21.1747829189455; 
 Wed, 21 May 2025 05:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF3qO3dqefBn71MaQPMFIuvEsz3Y/3jPDYcWNGOpE/rlpXpTHdkm2oNKhktDS5GQ3Eoh+ezw==
X-Received: by 2002:a05:600c:1547:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-442fd672078mr158631005e9.21.1747829188927; 
 Wed, 21 May 2025 05:06:28 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d1fasm1739094f8f.1.2025.05.21.05.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 05:06:28 -0700 (PDT)
Message-ID: <5f154235-5777-4349-971b-e9fdfecba065@redhat.com>
Date: Wed, 21 May 2025 14:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] tests/functional: add memlock tests
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250417114008.169350-1-dtalexundeer@yandex-team.ru>
 <20250417114008.169350-3-dtalexundeer@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250417114008.169350-3-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 17/04/2025 13.40, Alexandr Moshkov wrote:
> Add new tests to check the correctness of the `-overcommit memlock`
> option (possible values: off, on, on-fault) by using
> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
> anonymous segments:
> 
> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
> * if `memlock=on`, then Size, Rss and Locked values must be equal for
> every anon smaps where Rss is not 0;
> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
> smaps and anonymous segment with Rss < Size must exists.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   tests/functional/meson.build     |   1 +
>   tests/functional/test_memlock.py | 104 +++++++++++++++++++++++++++++++
>   2 files changed, 105 insertions(+)
>   create mode 100755 tests/functional/test_memlock.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 0f8be30fe2..339af7835f 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -61,6 +61,7 @@ tests_generic_system = [
>     'empty_cpu_model',
>     'info_usernet',
>     'version',
> +  'memlock',
>   ]
>   
>   tests_generic_linuxuser = [
> diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
> new file mode 100755
> index 0000000000..eaf3d46dec
> --- /dev/null
> +++ b/tests/functional/test_memlock.py
> @@ -0,0 +1,104 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that check overcommit memlock options
> +#
> +# Copyright (c) Yandex Technologies LLC, 2025
> +#
> +# Author:
> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> +#
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import re
> +
> +from typing import List, Dict
> +
> +from qemu_test import QemuSystemTest
> +from qemu_test import skipLockedMemoryTest
> +
> +
> +SMAPS_HEADER_PATTERN = re.compile(r'^\w+-\w+', re.MULTILINE)
> +SMAPS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
> +
> +
> +@skipLockedMemoryTest(2_097_152)  # 2GB
> +class MemlockTest(QemuSystemTest):
> +    """
> +    Boots a Linux system with memlock options.
> +    Then verify, that this options is working correctly
> +    by checking the smaps of the QEMU proccess.
> +    """
> +
> +    def common_vm_setup_with_memlock(self, memlock):
> +        self.vm.add_args('-overcommit', f'mem-lock={memlock}')
> +        self.vm.launch()
> +
> +    def get_anon_smaps_by_pid(self, pid):
> +        smaps_raw = self._get_raw_smaps_by_pid(pid)
> +        return self._parse_anonymous_smaps(smaps_raw)
> +
> +    def test_memlock_off(self):
> +        self.common_vm_setup_with_memlock('off')
> +
> +        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
> +
> +        # locked = 0 on every smap
> +        for smap in anon_smaps:
> +            self.assertEqual(smap['Locked'], 0)
> +
> +    def test_memlock_on(self):
> +        self.common_vm_setup_with_memlock('on')
> +
> +        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
> +
> +        # size = rss = locked on every smap where rss not 0
> +        for smap in anon_smaps:
> +            if smap['Rss'] == 0:
> +                continue
> +            self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
> +
> +    def test_memlock_onfault(self):
> +        self.common_vm_setup_with_memlock('on-fault')
> +
> +        anon_smaps = self.get_anon_smaps_by_pid(self.vm.get_pid())
> +
> +        # rss = locked on every smap and segment with rss < size exists
> +        exists = False
> +        for smap in anon_smaps:
> +            self.assertTrue(smap['Rss'] == smap['Locked'])
> +            if smap['Rss'] < smap['Size']:
> +                exists = True
> +        self.assertTrue(exists)
> +
> +    def _parse_anonymous_smaps(self, smaps_raw: str) -> List[Dict[str, int]]:
> +        result_segments = []
> +        current_segment = {}
> +        is_anonymous = False
> +
> +        for line in smaps_raw.split('\n'):
> +            if SMAPS_HEADER_PATTERN.match(line):
> +                if current_segment and is_anonymous:
> +                    result_segments.append(current_segment)
> +                current_segment = {}
> +                # anonymous segment header looks like this:
> +                # 7f3b8d3f0000-7f3b8d3f3000 rw-s 00000000 00:0f 1052
> +                # and non anonymous header looks like this:
> +                # 7f3b8d3f0000-7f3b8d3f3000 rw-s 00000000 00:0f 1052   [stack]
> +                is_anonymous = len(line.split()) == 5
> +            elif m := SMAPS_VALUE_PATTERN.match(line):
> +                current_segment[m.group(1)] = int(m.group(2))
> +
> +        if current_segment and is_anonymous:
> +            result_segments.append(current_segment)
> +
> +        return result_segments
> +
> +    def _get_raw_smaps_by_pid(self, pid: int) -> str:
> +        with open(f'/proc/{pid}/smaps', 'r') as f:
> +            return f.read()

The patch looks basically fine to me, but here you should consider that this 
might be running on a non-Linux system, too, I think. So in case the open() 
fails, just do a self.skipTest() ?

  Thomas


