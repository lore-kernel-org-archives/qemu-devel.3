Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC02CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 06:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoceZ-0006Jq-PH; Wed, 20 Aug 2025 02:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoceX-0006JY-Ka
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoceT-0005p8-Hv
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 02:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755672627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iiH+5G1LrqWTtlUO8i7gFLd6R1eeHFfiUdjOtVkcmGM=;
 b=IhGGuqi0GW7GYyq8V7syIf7k8mFpL6HLEbZvNE3EWvnkQ/GifpkB/Vbgzu3sWHPvRaF7KL
 1U7bBwr+FikHi255p7aLZ0cHBUretRSQKphhbbSzEab1YWkgmEiYI+eFGCs5CHZonp2C4S
 4f3MsGSXSdXDbRhEb+iiK7AS/p6fgmQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-MHVjJBa1MBSVFrQHhUlPYw-1; Wed, 20 Aug 2025 02:50:24 -0400
X-MC-Unique: MHVjJBa1MBSVFrQHhUlPYw-1
X-Mimecast-MFC-AGG-ID: MHVjJBa1MBSVFrQHhUlPYw_1755672624
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e87068f8afso1743819785a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 23:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755672624; x=1756277424;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iiH+5G1LrqWTtlUO8i7gFLd6R1eeHFfiUdjOtVkcmGM=;
 b=Y+o1qfWTCNIrZrRKPelBSBf0aiLdG6DeCxjOVfSKvRXCUqz2LSdbJbd8eEokL5L+Io
 L8BPy+/Pv7G1q2qRkfCgXitw7grGq+nznk714xzLYqDytD9Ixia3ALOhcT7K+VjhJ44g
 i7F2BAIQ5wyptG1QFyQMtvkxK1ZEqxReBCJB2eLq5tVVdRDuSkbm8b/8IMKwwR+hal9O
 7qBxjI2yW7YRlKx5j3HIGxq4GqsO7+sACwjiBFU7TW1bExV+mXKibbN2mX9yKIEeMXyr
 38h5o5LWhQs9n/KxLxfho7Gxktq/Up//eUut6Q/BtoGWYu6QdeOVj78YNXmu/EjIWdUz
 Qd2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXA/mCmttbxM6Ywtm4VRnE4smILUmfhMzljun00tGCACFv5+Uu5axH+Yk/fkwMhdk0QFLhJREFmZ2y@nongnu.org
X-Gm-Message-State: AOJu0Yx3T6bCmuYCpbGBrNF5/F//9Pwv6Dn+ZjdcghtxJnUWsT3FS+gJ
 Qr5souRAAlSJRRqj2mwAB8Kz7bvDJmz3JLNa2N0XFi4JBygq5Y3IHGPBAq684BGGhzeaBUcDtC7
 9reAJwG458naTHZ/GiHJGCtJxCa6bt1m9DoFaECBumCCH1tmDlqhSK6ZB
X-Gm-Gg: ASbGnct2YfA5Kr2tH3xHmH8ajyjwx+ZSNS77+pfZniw49YEx6SuC3iQFVS3MOXF+YmI
 NGmMxNpuEOxkiglHngpNyEn4ciV8MplqOmLVpFFKS9vO3fqKCEX/LnIimBZKc/eZsYKEKcyQ3bD
 WfVh8Msq6G3mYqLaPb6YIMYXFtTXczdAd0YW077G9uXpBBFXIXiEFjNTerqQipkstjp/i+g+1IS
 iplIBj/c+gdCSx1HElWBhhRldobOVnPl6S3HYZaYvaYivKxxcBsMpQYVY7Htt0reNIrST2rxemm
 uXdPao6PN9VnM5NRO2LEH0Jet8yD4w8mFSlbGT74ZTro5LAQ5x057AzVA4cAY5fom+BU8Dd4a92
 x49s=
X-Received: by 2002:a05:620a:1908:b0:7e8:63c6:2896 with SMTP id
 af79cd13be357-7e9fcb7871cmr224267185a.44.1755672624355; 
 Tue, 19 Aug 2025 23:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQCFTjzycKfJhmnC0bWoV8uNIj622bI+vuz2kjlrVp8QOtdxnFdHIQHO15w5TfrV42XIQZMQ==
X-Received: by 2002:a05:620a:1908:b0:7e8:63c6:2896 with SMTP id
 af79cd13be357-7e9fcb7871cmr224265885a.44.1755672623996; 
 Tue, 19 Aug 2025 23:50:23 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-073.pools.arcor-ip.net.
 [47.64.112.73]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e1e15besm900592285a.72.2025.08.19.23.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 23:50:23 -0700 (PDT)
Message-ID: <f20c54fd-4cc3-4689-8eb8-c934aa462e7f@redhat.com>
Date: Wed, 20 Aug 2025 08:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] tests/functional: Extract migration code into a
 new class
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Fabian Vogt <fvogt@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250819223905.2247-1-farosas@suse.de>
 <20250819223905.2247-3-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250819223905.2247-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/08/2025 00.39, Fabiano Rosas wrote:
> Move some of the code from test_migration.py to a new class so it can
> be reused to invoke migrations from other tests.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> I see this conflicts with Thomas' series, I'll update accordingly.
> ---
>   tests/functional/qemu_test/migration.py | 40 +++++++++++++++++++++++++
>   tests/functional/test_migration.py      | 24 ++-------------
>   2 files changed, 43 insertions(+), 21 deletions(-)
>   create mode 100644 tests/functional/qemu_test/migration.py
> 
> diff --git a/tests/functional/qemu_test/migration.py b/tests/functional/qemu_test/migration.py
> new file mode 100644
> index 0000000000..37988704e8
> --- /dev/null
> +++ b/tests/functional/qemu_test/migration.py
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Migration test
> +#
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Authors:
> +#  Cleber Rosa <crosa@redhat.com>
> +#  Caio Carrara <ccarrara@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import time
> +
> +
> +class Migration():
> +
> +    @staticmethod
> +    def migration_finished(vm):
> +        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
> +
> +    def assert_migration(self, test, src_vm, dst_vm, timeout):
> +
> +        end = time.monotonic() + timeout
> +        while time.monotonic() < end and not self.migration_finished(src_vm):
> +           time.sleep(0.1)
> +
> +        end = time.monotonic() + timeout
> +        while time.monotonic() < end and not self.migration_finished(dst_vm):
> +           time.sleep(0.1)
> +
> +        test.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> +        test.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
> +        test.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
> +        test.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
> +
> +    def migrate(self, test, source_vm, dest_vm, src_uri, timeout):
> +        source_vm.qmp('migrate', uri=src_uri)
> +        self.assert_migration(test, source_vm, dest_vm, timeout)
> diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
> index c4393c3543..1c75a98330 100755
> --- a/tests/functional/test_migration.py
> +++ b/tests/functional/test_migration.py
> @@ -15,6 +15,7 @@
>   import time

I guess you could drop the "import time" here now?

Apart from that:
Reviewed-by: Thomas Huth <thuth@redhat.com>


>   from qemu_test import QemuSystemTest, skipIfMissingCommands
> +from qemu_test.migration import Migration
>   from qemu_test.ports import Ports
>   
>   
> @@ -22,25 +23,6 @@ class MigrationTest(QemuSystemTest):
>   
>       timeout = 10
>   
> -    @staticmethod
> -    def migration_finished(vm):
> -        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
> -
> -    def assert_migration(self, src_vm, dst_vm):
> -
> -        end = time.monotonic() + self.timeout
> -        while time.monotonic() < end and not self.migration_finished(src_vm):
> -           time.sleep(0.1)
> -
> -        end = time.monotonic() + self.timeout
> -        while time.monotonic() < end and not self.migration_finished(dst_vm):
> -           time.sleep(0.1)
> -
> -        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> -        self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
> -        self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
> -        self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
> -
>       def select_machine(self):
>           target_machine = {
>               'aarch64': 'quanta-gsj',
> @@ -67,8 +49,8 @@ def do_migrate(self, dest_uri, src_uri=None):
>           source_vm = self.get_vm(name="source-qemu")
>           source_vm.add_args('-nodefaults')
>           source_vm.launch()
> -        source_vm.qmp('migrate', uri=src_uri)
> -        self.assert_migration(source_vm, dest_vm)
> +
> +        Migration().migrate(self, source_vm, dest_vm, src_uri, self.timeout)
>   
>       def _get_free_port(self, ports):
>           port = ports.find_free_port()


