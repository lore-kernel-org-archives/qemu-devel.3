Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DF6C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Ftt-0004Xu-4B; Mon, 14 Apr 2025 05:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4Fti-0004XV-UM
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4Ftg-0000Zh-Hz
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744622068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rmcJmxBBERd2KzCJkgT6vfe7gtCgJ2OpF+UfMCBbvzU=;
 b=AxICDCMBzoDcpapeZwjiiaSPSgCd30htV7TANJh6I2U73ZsTHSZPA5fbVwGQhW6TysdtQi
 1+/fiEUfL80GOeOF4FCK7cc5Vc6RRrapF8cVn9ayIN12VtEDsEbDvIa+en42A32STBsI5T
 NRXHMoMfDvUnfpmrVztn7PJhzEuZicY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Y5JNtO0FPAqLLwyntBNu3Q-1; Mon, 14 Apr 2025 05:14:26 -0400
X-MC-Unique: Y5JNtO0FPAqLLwyntBNu3Q-1
X-Mimecast-MFC-AGG-ID: Y5JNtO0FPAqLLwyntBNu3Q_1744622065
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39123912ff0so1583489f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 02:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744622065; x=1745226865;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmcJmxBBERd2KzCJkgT6vfe7gtCgJ2OpF+UfMCBbvzU=;
 b=Ha9lsDQ5YNEFCHEx0qjVKMNrcnOcBk4xARSI9ZjLMYSw9Q+mTvmJwtECTn+FeXRspk
 E/v8mCOj2XCymIrgoSu7ON880uhcsINE84X+0AIZb40FEKfXLZnponLSXx9iXcMqJaxU
 LTsX5YNY8xBo/LIr3ZfJ8Xmxkzl4ELEaoMbVtF68PyDe7+FIqFSXAQ2BoVdvL09IepB7
 rrA/WrMcTu9aYjAI4WSrMnPmyudvhuHiocHNRSRznTiNOSBPlq+8ra/chTaT86jPS0p+
 MXcJpPJIOZAuJMjlv6bHmkjzT/xHuR+Tipt4KuBTn9HGWKaTjpRkSaI3RR2MOwRKJ/sJ
 sJrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXpM+1Z8eBscQGw9dpTnNNC/ELQ7XuCrwixjJC1Kpi6Xh77tdmECLTb0+9x3TlVFKDBWHS1tpInQwF@nongnu.org
X-Gm-Message-State: AOJu0YytfvUsEnLv45xZbNAICDoUYnwlNuVJsH9gzlcSagVsoWLUFLlt
 SbV1iEfpreJX3BAizv/rOnCmYbD879rqakd40C5nAOZp2iFC6G1NOpGvCagKkLt4VN1vBdgS9bo
 HE+2bhcvt/fPww4E5KH6TT8s1wJiWmqxZfEpwFhRvJIozV9mCAN7B
X-Gm-Gg: ASbGncszD6XV44VUTkpj4pE+ghTlqdcTNn2MCQrYuGZs9583DOUfTzsS6MY8c2oZr9X
 vWcwzhgcsqxqicYpJkqcatm5gRX2ahnHGCRrejsJt7TwpOQO2rgGu2gklkKDLvfH4fjbxMSekye
 Dpc7UO+tnWfxVrAZuffm7xCAEk7K01DVOQvQ1RYWJvaPiIWnqSzlTxpfSQ9lpzXXj0kpmruAquN
 Rmx+W0+S2T1mMvRrkhfM/wiO7v8tRAVDOvoiVAK36T6Og3p1LEG3B6sv5Ea+fj+ss8RyYAGZqrc
 halzcuWlk29SeeWe
X-Received: by 2002:a5d:64a9:0:b0:39c:2264:43ea with SMTP id
 ffacd0b85a97d-39ea51d36a4mr8998028f8f.3.1744622065236; 
 Mon, 14 Apr 2025 02:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGniTMK2XVbY6fNx5zEFVweB3dJgF/WWtFHZeQvqYtDyH7UrIvB671EmCpncCW6BrltBvJbTw==
X-Received: by 2002:a5d:64a9:0:b0:39c:2264:43ea with SMTP id
 ffacd0b85a97d-39ea51d36a4mr8998000f8f.3.1744622064750; 
 Mon, 14 Apr 2025 02:14:24 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39eae97b249sm10480975f8f.58.2025.04.14.02.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 02:14:23 -0700 (PDT)
Message-ID: <cbf25ba4-7e0a-423a-8662-efdb98ce50d4@redhat.com>
Date: Mon, 14 Apr 2025 11:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/avocado: add memlock tests
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>
References: <20250414075702.9248-1-dtalexundeer@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250414075702.9248-1-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/14/25 09:57, Alexandr Moshkov wrote:
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

Hi Alexandr,

tests/avocado is being phased out and will no longer be present in QEMU 
10.1.  Can you write the test using the framework in tests/functional 
instead?

Thanks,

Paolo

> ---
> 
> v1 -> v2:
> In the previous send, i forgot to specify new patch version (v2)
> So i resend previous patch with version specified.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   tests/avocado/memlock.py | 98 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
>   create mode 100644 tests/avocado/memlock.py
> 
> diff --git a/tests/avocado/memlock.py b/tests/avocado/memlock.py
> new file mode 100644
> index 0000000000..935cc3dc42
> --- /dev/null
> +++ b/tests/avocado/memlock.py
> @@ -0,0 +1,98 @@
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
> +from avocado_qemu.linuxtest import LinuxTest
> +
> +
> +SMAPS_HEADER_PATTERN = re.compile(r'^\w+-\w+', re.MULTILINE)
> +SMAPS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
> +
> +
> +class Memlock(LinuxTest):
> +    """
> +    Boots a Linux system with memlock options.
> +    Then verify, that this options is working correctly
> +    by checking the smaps of the QEMU proccess.
> +    """
> +
> +    def common_vm_setup_with_memlock(self, memlock):
> +        self.vm.add_args('-overcommit', f'mem-lock={memlock}')
> +        self.launch_and_wait(set_up_ssh_connection=False)
> +
> +    def get_anon_smaps_by_pid(self, pid):
> +        smaps_raw = self._get_raw_smaps_by_pid(pid)
> +        return self._parse_anonymous_smaps(smaps_raw)
> +
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


