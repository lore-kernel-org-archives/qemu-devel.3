Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B006BC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 11:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5NOq-0000PI-U1; Thu, 17 Apr 2025 07:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u5NOi-0000Ni-RG
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u5NOf-0001Jd-5Q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744889226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nAYNIhnLHSpyV95FsSHirP9NS7+HCHVtCQEikZ7wWJM=;
 b=JLtw8QDtvvkrvqXW/319qh/euUjC2Up91iic6g9777wbIGwp4ByylSYRCtSLevxMml+fKF
 MR0yNzzpJBgPsqz9hVUiIANBH0FOAXQ2SCpp6qXgBMH4tC1iCX9l8Gv8tRB8+aLjAIZDGP
 KlTFXZnq9r2mb8jE8OcYatQiVjZVB6Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-XWtIU-LrOqyLuhRPYhg6XA-1; Thu,
 17 Apr 2025 07:27:05 -0400
X-MC-Unique: XWtIU-LrOqyLuhRPYhg6XA-1
X-Mimecast-MFC-AGG-ID: XWtIU-LrOqyLuhRPYhg6XA_1744889224
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C02771955D86; Thu, 17 Apr 2025 11:27:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.151])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9C3A1800D9F; Thu, 17 Apr 2025 11:27:01 +0000 (UTC)
Date: Thu, 17 Apr 2025 12:26:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 2/2] tests/functional: add memlock tests
Message-ID: <aADlgWm8Z6yHiO0H@redhat.com>
References: <20250417111321.167008-1-dtalexundeer@yandex-team.ru>
 <20250417111321.167008-3-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417111321.167008-3-dtalexundeer@yandex-team.ru>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 17, 2025 at 04:13:21PM +0500, Alexandr Moshkov wrote:
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
>  tests/functional/meson.build     |   1 +
>  tests/functional/test_memlock.py | 102 +++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100755 tests/functional/test_memlock.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 0f8be30fe2..339af7835f 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -61,6 +61,7 @@ tests_generic_system = [
>    'empty_cpu_model',
>    'info_usernet',
>    'version',
> +  'memlock',
>  ]
>  
>  tests_generic_linuxuser = [
> diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
> new file mode 100755
> index 0000000000..b62f12a715
> --- /dev/null
> +++ b/tests/functional/test_memlock.py
> @@ -0,0 +1,102 @@

Forgot to say last time this also needs

  #!/usr/bin/env python3

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
> +
> +
> +if __name__ == '__main__':
> +    MemlockTest.main()
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


