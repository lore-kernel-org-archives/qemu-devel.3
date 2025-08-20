Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ABDCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 07:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uocrq-0001Y5-Sn; Wed, 20 Aug 2025 03:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uocrk-0001We-Fy
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 03:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uocrd-0007Ee-7K
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 03:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755673443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BMSc/iniHAiKFcplGyvO5dR80G4NSUBLQbcG6dDH4P0=;
 b=c13KiJ9e2ha20x3TzLj0xS7YYZpY1XX5tw5/l2UHs7FAuw4w7ICDB8mBpHR9mFLDH0PYqT
 QVTjxztzNHp+sF3hdTj0GwPrGVKT9UEgwk/V01dtg45AJxVTRxtRwU9NoyFgBvam4KRNVo
 QQOXgJvL3IsFXfyrvk6Z+ip9I6F1sTE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-CdrDVPkHMoyVfx5Uu96YJQ-1; Wed, 20 Aug 2025 03:04:00 -0400
X-MC-Unique: CdrDVPkHMoyVfx5Uu96YJQ-1
X-Mimecast-MFC-AGG-ID: CdrDVPkHMoyVfx5Uu96YJQ_1755673440
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e870627e34so2750916985a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 00:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755673440; x=1756278240;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BMSc/iniHAiKFcplGyvO5dR80G4NSUBLQbcG6dDH4P0=;
 b=F/H7AcTF/LhlDjDBHG8JhbgJDjyZqmysvmQnxmS0Af61BAlrNfDcLFrhuCU7HAjTzE
 F6FkB801CpWrKDbRoIW6yAUDAuzvffNUQzUb+MvXtZpdVnA6CkVwTPReUa8xKhhM5aGz
 I9paxYrtoyksqkzgE/+KXwLXnigKkzUtWZpC9xUKRuXWbAF+1N/LtPuhAUH63r/I2TtJ
 EOCx22qy1WH7NQ2sjfjlzWi3S8VPf7LBXJmOEIcPOE26S/o6u9MeVss5P49DpVghoPeO
 b63Re257gNGmYOX5R7Jgl4U1NSuqTlyd3a7TLZhLUpAeMEayTL8wAgKgRJMqAVVBvAq0
 O4Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMnDRwccZgPPb3/picO33MZDOa2UKqrrz6QXFloDSE9KIHrtrUnnRCGJXMDkodr6IcCxzxzAv8tzc6@nongnu.org
X-Gm-Message-State: AOJu0YyOy83BRCLW5Op042PPSeYF6YhYl6URwP3SXBk3WoawVszrZZb6
 sdggEXCDQsxaX04OUxg2AsxD13vMNO/Wo+g8QzIfCwiUHCzYeARY0a9lDf9uoXmGVDRwPKHDZ2K
 hshKresgctPqrrbMwBcHzK7h7QIGQJCaabC6kapZLq7VgqhCikECcEP29
X-Gm-Gg: ASbGnctCO9p297VTfz8lgkC6RrFETN74F+zgBVIf19jDaNnh9Rys+2h6Qw2uIGHHtdy
 vc3JgEhSGeHf6sZrtAqIrejuzD4YRHKnk/nUMcuD3k+KwM9j7NSMXpldujbCcURO9Hf+pNQ1N/p
 LYZpSUAOJXc+BqjaEPLDyw4Km9fOVOkwLgqyhUK7Rl2psw+J3VP0QPUAnwAIrquschQ9m6LzD41
 o7tEqqRCswnoqTyffz/RfHmbmzoeCz1H6GsYTAGsRxCYS8BPV0QXIiwogi7rbge5UxUWB4D1Oii
 yItvHViAu5Q48xxW7uTFxjb/7Uf32RGi0R+Q8hRofhTDeGgzKu7zuAcypeBH17xWSuty/Pd837w
 GXTE=
X-Received: by 2002:a05:620a:46a8:b0:7e8:7b6c:f2d8 with SMTP id
 af79cd13be357-7e9fcbae88cmr248155685a.50.1755673440092; 
 Wed, 20 Aug 2025 00:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLjX5U2w9a/NwFnyvpG9ZMGjI3eUtu/zEmcRTAY+VJVhdUXVoJzoySyd9JR3vNV/qGVAilWQ==
X-Received: by 2002:a05:620a:46a8:b0:7e8:7b6c:f2d8 with SMTP id
 af79cd13be357-7e9fcbae88cmr248153085a.50.1755673439496; 
 Wed, 20 Aug 2025 00:03:59 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-073.pools.arcor-ip.net.
 [47.64.112.73]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e9fd472d07sm86624885a.0.2025.08.20.00.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 00:03:59 -0700 (PDT)
Message-ID: <8eb9dd92-b33f-41c5-ade1-416f22b215a7@redhat.com>
Date: Wed, 20 Aug 2025 09:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] tests/functional: Add a OS level migration test
 for pseries
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Fabian Vogt <fvogt@suse.de>,
 Peter Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250819223905.2247-1-farosas@suse.de>
 <20250819223905.2247-4-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250819223905.2247-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
> There's currently no OS level test for ppc64le. Add one such test by
> reusing the boot level tests that are already present.
> 
> The test boots the source machine, waits for it to reach a mid-boot
> message, migrates and checks that the destination has reached the
> final boot message (VFS error due to no disk).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/functional/test_ppc64_pseries.py | 41 ++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/test_ppc64_pseries.py
> index 67057934e8..7a7e0fe8ae 100755
> --- a/tests/functional/test_ppc64_pseries.py
> +++ b/tests/functional/test_ppc64_pseries.py
> @@ -9,6 +9,8 @@
>   
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import wait_for_console_pattern
> +from qemu_test.migration import Migration
> +from qemu_test.ports import Ports
>   
>   class pseriesMachine(QemuSystemTest):
>   
> @@ -87,5 +89,44 @@ def test_ppc64_linux_big_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_ppc64_linux_migration(self):
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +        uri = 'tcp:localhost:%u' % port

  Hi,

this is not how to use the context for Ports: Once the "with" block is left, 
the locking for the free port will be gone and you're subject to a race 
condition with other tests running in parallel (see the __enter__ and 
__exit__ methods in tests/functional/qemu_test/ports.py ... and yes, there 
should be more documentation for this).

You've got to put everything up to the point where QEMU takes the port into 
the "with" block, i.e. everything up to including the Migration().migrate() 
line.

  Thomas

> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> +
> +        self.set_machine('pseries')
> +
> +        dest_vm = self.get_vm('-incoming', uri, name="dest-qemu")
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
> +        Migration().migrate(self, source_vm, dest_vm, uri, self.timeout)
> +
> +        # ensure the boot proceeds after migration
> +        wait_for_console_pattern(self, self.good_message, self.panic_message,
> +                                 vm=dest_vm)
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()


