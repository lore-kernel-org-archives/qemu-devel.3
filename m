Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB18C982CD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x75ts-0007cg-2v; Thu, 17 Sep 2026 02:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x75tl-0007bz-1p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x75th-0005Mu-1o
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789627620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ut4CXaS5gWaB5Uc63CTOC1FGrMDVC8vhlQoznZwDbYk=;
 b=G+lfyLJfHdMNZDkeNSEZ4OsvhyjuJgzsarxp62DFSUqFVL3s0CKkvz+1Mq11ES8jgRXKCC
 ufSbvskjskK0tRCHrW0o+NNLsLgH2hKoMivpF06uJJ7/fkwxHragN/1EvpJASae1JycI70
 s8bRfMDc29Co9Xt7hdIBzAtl4Zlfhtk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-iuM8KNskPFCkxFiSTB59WA-1; Thu, 17 Sep 2026 02:46:59 -0400
X-MC-Unique: iuM8KNskPFCkxFiSTB59WA-1
X-Mimecast-MFC-AGG-ID: iuM8KNskPFCkxFiSTB59WA_1789627618
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso3280085e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789627618; x=1790232418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ut4CXaS5gWaB5Uc63CTOC1FGrMDVC8vhlQoznZwDbYk=;
 b=WR82RzdY48OVWE/XAdrYe+a5dKe8RAiGOM4+T22sBH/oA8ks5ibEkFqdiV5Ds9m5lW
 6LhY2kRLdUsqG7EVb5WlhwJZxWfx3gZFZPoJC68m8xYsto9PpAAZOQSqpGtEq8Jxq7o6
 ihBZFKI7D5jdovtzmtG0EoazCnpNJZ4/GkxkpD67RLVvqBqudUrS99y5p0T+CW7AI3GR
 0MrFMneYDnAhJaEprK7v/diHn0KSYf4GAd9CA5GztbUiXyg2SWWUV1gtZAZS8eyp6zq3
 Cs4r2pEYADD7qOuycJdvjKvrrGX2BADwt1PlOMENk6SVYrn7RLRIq5HflXVNyXaE56oz
 PdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789627618; x=1790232418;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ut4CXaS5gWaB5Uc63CTOC1FGrMDVC8vhlQoznZwDbYk=;
 b=WZhe0HSkSgDu5A/7IasjAq/Gq2EEyBXWq5YcEEfYqGEQ7nu/FYGazdj2Turm9bk+KC
 svM8DUDjUTJDuokyEcXfMSdDX5PDpIxB7qZWytc4ocuPPFREXLgskbfy/fUtDZN/9R1g
 oEUJ3et6QKps0lkaL7OPCPCWtesiwquIHh8SJwROTZn7aMRAeMWFQVuJk4+6wHHH46JS
 iE6+TY8UuoTBIu8CG/ZscVJxktBTGHphOPmIqLWeGe2mnHcT0yPccLOhe+eFLnt6KdUd
 2eWqfI8uiHZBEX0ev/9ArD+lpNaYf2VOVNzfNE9xvmD3+sziKaUVNpGsdr3y77az0oCE
 q2cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGVCxSND8LNwQJwDuPemZlR4gL5IICG0NXdzVWlvRVQp7f9uXlQq1u8iqUWVZ5cvySXbRqBu1qlYw3@nongnu.org
X-Gm-Message-State: AFuF++n2smQRC72fvg2vJjIHUW3bg9JW3yXcPBkbweLRsOMCrhwM2+Ur
 e3bpdGqqw/tfnp4Rjw/eacE175a0RjjzmViPSFmQL7ecU1pNi5E8c+duwi+qE4Pkexv9FjUwHia
 UPYj3K7OXupuM781736RyR0XiG5dWzlR4mu73dFc45FvodUHogIeLdjPK
X-Gm-Gg: AYBFou3lOKq7b59wKzgVw7Z61sf4UGvcx2ynNXLmC+9sAl1RM6l3EuuahdgtR96wzR6
 nCyhzACM23nfSSifDRj4gEy/AH/nnVb35Pxl+OevT7dQpjpgC9YwZy1NFUSTsEwJMCebWp+/Tsb
 XjqLqzSPdBSGFTDsqllGpaAbzsSRuaAAt71ZG5+Z37g/mcQStZ3UIPAi4rTaIe1KZTRyG7j2xDD
 9ZtIRu8tUZk/K49w0zkUgjbe4H3jV62Mu5vZetn31q5C9/c5Z6vXdzsfUTeI+lEmZozTqFdkMgH
 bVk67/S2a3VMVu5xE99DAIU0Ca3pWsXz4uwmaB783cMNh5rEaITwuh2LCLoN8Rz2GPJGxr0bTA=
 =
X-Received: by 2002:a05:600c:8b35:b0:49e:6861:50f7 with SMTP id
 5b1f17b1804b1-49eac4626c0mr57300845e9.5.1789627618051; 
 Wed, 16 Sep 2026 23:46:58 -0700 (PDT)
X-Received: by 2002:a05:600c:8b35:b0:49e:6861:50f7 with SMTP id
 5b1f17b1804b1-49eac4626c0mr57300325e9.5.1789627617076; 
 Wed, 16 Sep 2026 23:46:57 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd232b25sm48095595e9.4.2026.09.16.23.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 23:46:56 -0700 (PDT)
Message-ID: <1da14833-d44c-4e22-8603-496a6063172e@redhat.com>
Date: Thu, 17 Sep 2026 08:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/functional/ppc64: extend pseries migration
 tests
To: Aniket Sahu <asahu1x@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-2-asahu1x@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260916103635.7797-2-asahu1x@linux.ibm.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/09/2026 12.36, Aniket Sahu wrote:
> Made a few changes to test_pseries.py to extend the migration
> tests to validate exec (socat) and UNIX paths.
> 
> - Refactored test_ppc64_linux_migration to a private method
> _do_linux_migration(dst_uri, src_uri=None).
> - It is then called by three separate methods which exercise the
> TCP, UNIX and exec paths via the migrate_vms method from
> MigrationTest.
> ---
>   tests/functional/ppc64/test_pseries.py | 41 ++++++++++++++++++++++----
>   1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
> index cb6d25dc81..19f31141b1 100755
> --- a/tests/functional/ppc64/test_pseries.py
> +++ b/tests/functional/ppc64/test_pseries.py
> @@ -8,8 +8,9 @@
>   # later.  See the COPYING file in the top-level directory.
>   
>   from qemu_test import Asset
> -from qemu_test import wait_for_console_pattern
> +from qemu_test import wait_for_console_pattern, which
>   from migration import MigrationTest
> +from qemu_test.ports import Ports
>   
>   class PseriesMachine(MigrationTest):
>   
> @@ -88,12 +89,20 @@ def test_ppc64_linux_big_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> -    def test_ppc64_linux_migration(self):
> +    def _do_linux_migration(self, dst_uri, src_uri=None):
> +        """
> +        Boot a pseries kernel on a source VM, wait until Linux is up, then
> +        migrate to a destination VM over the given URI(s) and verify the boot
> +        continues on the destination.
> +        """
>           self.set_machine('pseries')
>   
>           kernel_path = self.ASSET_KERNEL.fetch()
>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>   
> +        if src_uri is None:
> +            src_uri = dst_uri
> +
>           dest_vm = self.get_vm(name="dest-qemu")
>           dest_vm.add_args('-incoming', 'defer')
>           dest_vm.add_args('-smp', '4')
> @@ -111,16 +120,38 @@ def test_ppc64_linux_migration(self):
>           source_vm.set_console()
>           source_vm.launch()
>   
> -        # ensure the boot has reached Linux
> +        # ensure the boot has reached Linux before migrating
>           console_pattern = 'smp: Brought up 1 node, 4 CPUs'
>           wait_for_console_pattern(self, console_pattern, self.panic_message,
>                                    vm=source_vm)
>   
> -        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
> +        self.migrate_vms(dst_uri, src_uri, dest_vm, source_vm)
>   
> -        # ensure the boot proceeds after migration
> +        # ensure the boot continues on the destination after migration
>           wait_for_console_pattern(self, self.good_message, self.panic_message,
>                                    vm=dest_vm)
>   
> +    def test_ppc64_linux_migration(self):
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            self._do_linux_migration('tcp:localhost:%u' % port)
> +
> +    def test_ppc64_linux_migration_unix(self):
> +        self._do_linux_migration(
> +            'unix:%s/migration.sock' % self.socket_dir().name)
> +
> +    def test_ppc64_linux_migration_exec(self):
> +        if not which('socat'):
> +            self.skipTest('socat is not available')
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            self._do_linux_migration(
> +                'exec:socat TCP-LISTEN:%u -' % port,
> +                'exec:socat - TCP:localhost:%u,forever' % port)
  Hi!

I'm really not sure whether this change is really justifiable: Linux is now 
booted three times, which will take a lot of additional time during testing. 
And that's just for exercising two additional migration channels which 
should be orthogonal to what happens in the guest? ... and we test those 
channels in other tests already ... sounds like too much wasted testing time 
for little gain to me.

Since our CI testing time is not unlimited, I'd prefer to rather drop this 
patch. Or if you really really think we get a lot more test coverage by 
exercising more migration channels here, then test the additional channels 
with migrating a guest that sits at the firmware prompt only, like you did 
in v1 of your patch set. But still, please also add some proper 
justification to the patch description why this is necessary from a test 
coverage point of view.

  Thanks,
   Thomas


