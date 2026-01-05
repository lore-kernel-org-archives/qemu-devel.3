Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867C3C2A088
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vchTF-0006PP-1p; Mon, 05 Jan 2026 05:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vchT7-0006P2-TV
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vchT5-0002BK-5G
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767607532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jGEqFYFRgDT/QyXzachMryu5thHWHlgHmcOxiB8snFo=;
 b=RnEc008fcWcdtwo5AGCO/s1vb9yvcgEyu11LN9zHYwAOxbp9Vnzv7otDfBkIaKQfXi5gDP
 DNSIQAv76MY/ScLClcfI3DtKgUpBKBDwp5T8+tqqAs0Uk4LU6IthXUWsNjZ78KZPJWOODU
 SKV2eitOWiSiw6eDzgu3eR548vwAlMg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-7GX6oGiJNDWud7-IPr4Ptg-1; Mon, 05 Jan 2026 05:05:31 -0500
X-MC-Unique: 7GX6oGiJNDWud7-IPr4Ptg-1
X-Mimecast-MFC-AGG-ID: 7GX6oGiJNDWud7-IPr4Ptg_1767607531
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-64d55e87f40so12861365a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767607530; x=1768212330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jGEqFYFRgDT/QyXzachMryu5thHWHlgHmcOxiB8snFo=;
 b=jRmdppoGslYhSfj4mU4nQxENQF+OwgQ8rrcqbEbW90BoRuimfc5AbwtJGI1HDU4e5p
 0k1Qw6/Nw6mm3TeNRXP9wsLD6qK01BSdxcI8NL/ev+ukq7jEXKIRvCqdXXzV4a4TCC2f
 vJy+heP0euNoo9aGk1n9BlOT3ljanEg72LipRkuHFGj7vW/8XMWfXZ++VGyADbTP6AhB
 xVvarnG/hb2LYdtiLa4cYiN+lw4AYzHJYx4olIpNrISrgHJn3UKtvJRatBaDzpJVJ7zC
 Ut6PHHEpDRdygWdoG9cQyA4wFhvJxdXOUe75gZZ91qyU+hjy0tYqa0CBe6SKQMFhEQ+2
 LNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767607530; x=1768212330;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGEqFYFRgDT/QyXzachMryu5thHWHlgHmcOxiB8snFo=;
 b=V9wxbz/sXY8ktdUVOtstompFyylsq7qQhmrgYCcP3zbsAYypbnQMnr4WqBqzmKSBkJ
 bqOzHwupdox8PwS/GA+BWEysLV6KGG3RxpP5RINDYKoxdhy0UZt+Xyha1DqPzdUMa5t3
 yFlUc5EFBvMnWAHCBTjPcZ8pIF7xNuqp/x/qK4cdue93yzZfZSJnL4bOyvcriGDC3kKc
 2rTkPYe2zNSubCZVwSZSn5gtSnO2lA1OA57GFU39Ku4gPi349d07NFsLU/GKWoNeSgsh
 +z8+LW4dvLEXqH7Pi2FecEpd0EM/7QOToe/POQ5OkgM2KRZWwFN3nGL32Cv/0MrbzAiJ
 zFzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXin5GxyozoSPs6/qQULPozoIukTiWAmlVvU3U8hUGFMr/JvQttGogUvH0O9XQiqsO1JbLqD6wFkR2@nongnu.org
X-Gm-Message-State: AOJu0Yx6+2UK8ZRjKdAOb4Y37TvNhBTtS1Q+0/yH9jrTEm+/+R6vkVST
 08VZCJl7QA3AMcN2VHfkrq3FpnR+HpNd/q1uaCoTI0xusq7ipCYV+NV9ZeupOdoa1G3Pkynn6K1
 muYHsdatDjCwD3ZZsqzWhM11ITZVmYyuFudyidzyJhRGfGsoLIJCLuuuC
X-Gm-Gg: AY/fxX7jWWa/0SKgXEyxWOicyikzmRUaZjZff2cdpby2fv5gxjyp+n+IGma1v7WvmYY
 elPJWqQyU6QPrMOHwHA+g1V3YQkDcoqTp4+SloBF8CMXqOXe94JbdrbTmh4A4+en9eIKVGACWON
 eLFCcId0UlPt5pYHRL3s3xbf5q2D0SI6muOjpLTxqVko8osPvimUVM+1QV5jyHHPTaz9CATjHPa
 eJDrSPiQ6r2C/6A5jlKo+f5M10zRKZdOUJ9VIB0c8V4z1/sVV0JZpUXDVyEnodj9gMT7U1xUqQd
 //uAYUMmY9FBx3fe8NJth1KeceVbgVYEMw1yS21VNlC/dFcgjk2KQBZTDxPZ7JeQusUyZRRV2rP
 NiwIHsQ==
X-Received: by 2002:a05:6402:1ecf:b0:64d:3550:4bb6 with SMTP id
 4fb4d7f45d1cf-64d35504e3dmr43525831a12.33.1767607530487; 
 Mon, 05 Jan 2026 02:05:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQPUJhQHfEeJBJvFWyaBi8lquycIp4aaQMQCJKVsgGY120Qr/HrTgpAEU/HBkVzVkZfKA7Bg==
X-Received: by 2002:a05:6402:1ecf:b0:64d:3550:4bb6 with SMTP id
 4fb4d7f45d1cf-64d35504e3dmr43525809a12.33.1767607530030; 
 Mon, 05 Jan 2026 02:05:30 -0800 (PST)
Received: from [192.168.0.8] ([47.64.114.65]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6505d03b868sm787700a12.22.2026.01.05.02.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 02:05:29 -0800 (PST)
Message-ID: <a270e66c-b1bd-4134-adae-ae60e5c905d7@redhat.com>
Date: Mon, 5 Jan 2026 11:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/functional: Add a OS level migration test
 for pseries
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251217164549.4311-1-farosas@suse.de>
 <20251217164549.4311-3-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251217164549.4311-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17/12/2025 17.45, Fabiano Rosas wrote:
> There's currently no OS level test for ppc64le. Add one such test by
> reusing the boot level tests that are already present.
> 
> The test boots the source machine, waits for it to reach a mid-boot
> message, migrates and checks that the destination has reached the
> final boot message (VFS error due to no disk).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/functional/ppc64/test_migration.py | 12 ++++++++
>   tests/functional/ppc64/test_pseries.py   | 35 ++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
> index 5dfdaaf709..a3b819680b 100755
> --- a/tests/functional/ppc64/test_migration.py
> +++ b/tests/functional/ppc64/test_migration.py
> @@ -4,6 +4,7 @@
>   #
>   # ppc migration test
>   
> +from qemu_test.ports import Ports
>   from migration import MigrationTest
>   
>   
> @@ -21,6 +22,17 @@ def test_migration_with_exec(self):
>           self.set_machine('mac99')
>           self.migration_with_exec()
>   
> +    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            uri = 'tcp:localhost:%u' % port
> +
> +            dest_vm.qmp('migrate-incoming', uri=uri)
> +            source_vm.qmp('migrate', uri=uri)
> +            self.assert_migration(source_vm, dest_vm)
> +
>   
>   if __name__ == '__main__':
>       MigrationTest.main()
> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
> index 7840c4e3ff..e15a8956a5 100755
> --- a/tests/functional/ppc64/test_pseries.py
> +++ b/tests/functional/ppc64/test_pseries.py
> @@ -9,6 +9,7 @@
>   
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import wait_for_console_pattern
> +from test_migration import PpcMigrationTest
>   
>   class PseriesMachine(QemuSystemTest):
>   
> @@ -87,5 +88,39 @@ def test_ppc64_linux_big_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_ppc64_linux_migration(self):
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> +
> +        self.set_machine('pseries')

It's slightly better to do set_machine() first, before the ASSET_* lines, so 
that the test is skipped without fetching the assets in case the pseries 
machine is not available.

With that nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> +        dest_vm = self.get_vm(name="dest-qemu")
> +        dest_vm.add_args('-incoming', 'defer')
> +        dest_vm.add_args('-smp', '4')
> +        dest_vm.add_args('-nodefaults')
> +        dest_vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        dest_vm.set_console()
> +        dest_vm.launch()
> +
> +        source_vm = self.get_vm(name="source-qemu")
> +        source_vm.add_args('-smp', '4')
> +        source_vm.add_args('-nodefaults')
> +        source_vm.add_args('-kernel', kernel_path,
> +                           '-append', kernel_command_line)
> +        source_vm.set_console()
> +        source_vm.launch()
> +
> +        # ensure the boot has reached Linux
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message,
> +                                 vm=source_vm)
> +
> +        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
> +
> +        # ensure the boot proceeds after migration
> +        wait_for_console_pattern(self, self.good_message, self.panic_message,
> +                                 vm=dest_vm)
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()


