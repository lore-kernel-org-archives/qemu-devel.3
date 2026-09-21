Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E73DC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Xj4-0005oT-1d; Mon, 21 Sep 2026 02:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8Xj1-0005o2-Q2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8Xiz-000871-GR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789972919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9z+AUuBPmcHYe5dsM7/1uRutYQMCmmY4UJbL2uQO2Wo=;
 b=dm5ehAyGTdXvSb1dURCvBeMQSSKJFf2P0+68S4JR2YoxBtZcZlOz2Lcj+T3+7t7yp/kwF4
 ljbQ4tHye54NpH0QtxHu/b+2CxBOxS0qV0+ApphsIZq9Bu3tofthv8mS6ZfUUu0KgszWOI
 t26p7caw+I/NNcyzdZTOikX3SxzKGP0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-nd5i96KfOl-ksCHz2QcZ9A-1; Mon, 21 Sep 2026 02:41:57 -0400
X-MC-Unique: nd5i96KfOl-ksCHz2QcZ9A-1
X-Mimecast-MFC-AGG-ID: nd5i96KfOl-ksCHz2QcZ9A_1789972916
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-472c330e555so1023648f8f.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 23:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789972916; x=1790577716; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9z+AUuBPmcHYe5dsM7/1uRutYQMCmmY4UJbL2uQO2Wo=;
 b=iYxwufh6/OR5EiF0tIjQSn4aPbfLFHCV+ZTpc4ZQydqBFMoNyFRKqYoVgoIEctTG3+
 huks+uciYuyHNePcRC5LrriOywtWbPTJpknuX/GXKNxlJFbA4N3+RJ2pEcxKUxyJLjs3
 Uva6wrTseFH8wbp7YuRdcTyAiIMfbG8ORi+N46c8HSVLVzmqN84FEcywHHuEkAvkztl+
 NIXA6S6DizSgiJ5JfM0/1nga/TJZzANI6dnhGRwokxGz7KNDKv00KwnMpvF1a2BQ39Gy
 EIGOPM6UjwsoI6yZ5uKgKksC8DjjGLmVfD+jxuMq6I0x+ranpfwjxnVwQwhVpol3uOHq
 EpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789972916; x=1790577716;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9z+AUuBPmcHYe5dsM7/1uRutYQMCmmY4UJbL2uQO2Wo=;
 b=NLBpVrZB05FvTdPlEyFgDNUwVFtuArkEA0j/ZIoQF4QLTgB97wSdtX0h5zZ3v6ExIO
 STLDZ0ogcQllYlgR97eZuBdG1MUEmUSofBgw6bohRZSCtDbvlC/WFS7pbghCRtZ46wZX
 ZGM97gvmYRz52RYG+jCSmqvk4vLalIN9x+URnn4yM1PSAG2Ud41XuJ1pvyw/1jLL5Rno
 CI49eR4sKUvOimdW8rS3WK8upRXftPuW7EnCdfGIyQGKE6VIidvW0U+gcRp7Y/wW6+P4
 gr+iHMAFNdlTjrLOF1ITB8k2pm7/YoV4JbekDX5tyAiHaebjx7Tu9BCYFdRDhNvx36l+
 ffyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoIEUw30cPWAcWEZ60a8W3tROQ0R2CdUS1tc95N5AQGOGJS8jzRrgylICHpK5X2kalndSCob2BvxlW@nongnu.org
X-Gm-Message-State: AFuF++nAmxUvFETWbOVZX+yglAdSrXWFnaA8A/pnYWcPP7AyWt5aFiO0
 jGuQldbfUw0pxvOPzhf9uc/8Dg1wzdVBlW11gHkvkF3px3NhOF0/uWvWHpkFCr2kLgr9dgzeBDK
 oHrqxxSwHzdL/4W0x8HyJuY3HQKt2ZHRzMwB+rfvX6g5bkqcmZ8cuA/h6
X-Gm-Gg: AYBFou0zV4EgxbcoH70AqpNd4RG1FDk4i6C7xB7DQhmTWVM4NmD+X1S//nEANvmZ67r
 M+RzR+fdugSvxIC6cJWfij5c2t3EsOzX9WqjG9FEUrNqHqMxORikUcSW/H4l065PtfldH3w2zpM
 5um8I3Irme0cpxdlesAAOe4+uvi6Wy6yPp/e7A9nnvCdz6ndFPC1bK6jbFXHG8wZAes59ACjlKt
 MPpsWIVNH06yLkVdZ97G49zSkulEFlKVIX3hV3VjZbvhZNO6KfvMceZHH3uMaKZ9PKlUoS9a7p0
 KHdSh0xN1iFFUD0xAT8XpZQhvqrhsWLeO4u4FatPkBLsZtsMZMQ5azlEZOMzgXg59NiF/WXk
X-Received: by 2002:a05:6000:1885:b0:484:3317:a19 with SMTP id
 ffacd0b85a97d-4871e261d35mr14056299f8f.26.1789972915957; 
 Sun, 20 Sep 2026 23:41:55 -0700 (PDT)
X-Received: by 2002:a05:6000:1885:b0:484:3317:a19 with SMTP id
 ffacd0b85a97d-4871e261d35mr14056277f8f.26.1789972915582; 
 Sun, 20 Sep 2026 23:41:55 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562bcbsm22257619f8f.16.2026.09.20.23.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 23:41:54 -0700 (PDT)
Message-ID: <6b96c87b-a1c5-4a84-818c-a56e847faaec@redhat.com>
Date: Mon, 21 Sep 2026 08:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/functional/ppc64: extend pseries migration
 tests
To: Aniket Sahu <asahu1x@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, rathc@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-2-asahu1x@linux.ibm.com>
 <20260918235644.a26929da-e7-amachhiw@linux.ibm.com>
 <5fd2c8fd-e4d7-4e4c-a6e4-95494c633951@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5fd2c8fd-e4d7-4e4c-a6e4-95494c633951@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 21/09/2026 07.56, Aniket Sahu wrote:
> 
> On 19/09/26 12:15 AM, Amit Machhiwal wrote:
>> Hi Aniket,
>>
>> Thanks for the patches.  Please find my comments inline below.
>>
>> On 2026/09/16 04:06 PM, Aniket Sahu wrote:
>>> Made a few changes to test_pseries.py to extend the migration
>>> tests to validate exec (socat) and UNIX paths.
>>>
>>> - Refactored test_ppc64_linux_migration to a private method
>>> _do_linux_migration(dst_uri, src_uri=None).
>>> - It is then called by three separate methods which exercise the
>>> TCP, UNIX and exec paths via the migrate_vms method from
>>> MigrationTest.
>>> ---
>>>   tests/functional/ppc64/test_pseries.py | 41 ++++++++++++++++++++++----
>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ 
>>> ppc64/test_pseries.py
>>> index cb6d25dc81..19f31141b1 100755
>>> --- a/tests/functional/ppc64/test_pseries.py
>>> +++ b/tests/functional/ppc64/test_pseries.py
>>> @@ -8,8 +8,9 @@
>>>   # later.  See the COPYING file in the top-level directory.
>>>   from qemu_test import Asset
>>> -from qemu_test import wait_for_console_pattern
>>> +from qemu_test import wait_for_console_pattern, which
>>>   from migration import MigrationTest
>>> +from qemu_test.ports import Ports
>>>   class PseriesMachine(MigrationTest):
>>> @@ -88,12 +89,20 @@ def test_ppc64_linux_big_boot(self):
>>>           wait_for_console_pattern(self, console_pattern, 
>>> self.panic_message)
>>>           wait_for_console_pattern(self, self.good_message, 
>>> self.panic_message)
>>> -    def test_ppc64_linux_migration(self):
>>> +    def _do_linux_migration(self, dst_uri, src_uri=None):
>>> +        """
>>> +        Boot a pseries kernel on a source VM, wait until Linux is up, then
>>> +        migrate to a destination VM over the given URI(s) and verify the 
>>> boot
>>> +        continues on the destination.
>>> +        """
>>>           self.set_machine('pseries')
>>>           kernel_path = self.ASSET_KERNEL.fetch()
>>>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>>> +        if src_uri is None:
>>> +            src_uri = dst_uri
>> The default behavior of src_uri=None is non-obvious from the docstring.  
>> Could
>> you mention that it defaults to dst_uri, and that callers using transports 
>> with
>> different source and destination URIs (such as the exec: case below) need to
>> provide src_uri explicitly?
>>
>>> +
>>>           dest_vm = self.get_vm(name="dest-qemu")
>>>           dest_vm.add_args('-incoming', 'defer')
>>>           dest_vm.add_args('-smp', '4')
>>> @@ -111,16 +120,38 @@ def test_ppc64_linux_migration(self):
>>>           source_vm.set_console()
>>>           source_vm.launch()
>>> -        # ensure the boot has reached Linux
>>> +        # ensure the boot has reached Linux before migrating
>>>           console_pattern = 'smp: Brought up 1 node, 4 CPUs'
>>>           wait_for_console_pattern(self, console_pattern, 
>>> self.panic_message,
>>>                                    vm=source_vm)
>>> -        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
>>> +        self.migrate_vms(dst_uri, src_uri, dest_vm, source_vm)
>>> -        # ensure the boot proceeds after migration
>>> +        # ensure the boot continues on the destination after migration
>>>           wait_for_console_pattern(self, self.good_message, 
>>> self.panic_message,
>>>                                    vm=dest_vm)
>>> +    def test_ppc64_linux_migration(self):
>>> +        with Ports() as ports:
>>> +            port = ports.find_free_port()
>>> +            if port is None:
>>> +                self.skipTest('Failed to find a free port')
>>> +            self._do_linux_migration('tcp:localhost:%u' % port)
>>> +
>>> +    def test_ppc64_linux_migration_unix(self):
>>> +        self._do_linux_migration(
>>> +            'unix:%s/migration.sock' % self.socket_dir().name)
>>> +
>>> +    def test_ppc64_linux_migration_exec(self):
>>> +        if not which('socat'):
>>> +            self.skipTest('socat is not available')
>>> +        with Ports() as ports:
>>> +            port = ports.find_free_port()
>>> +            if port is None:
>>> +                self.skipTest('Failed to find a free port')
>>> +            self._do_linux_migration(
>>> +                'exec:socat TCP-LISTEN:%u -' % port,
>>> +                'exec:socat - TCP:localhost:%u,forever' % port)
>> I share Thomas's concern about CI cost.  With this patch, Linux is fully 
>> booted
>> three times — once per transport variant — which significantly increases the
>> wall-clock time of the pseries migration test slot.
>>
>> The UNIX and exec transport paths are already covered on ppc64 in
>> tests/functional/ppc64/test_migration.py, though against mac99 rather than
>> pseries.  If the intent is specifically to validate these transports on the
>> pseries machine, that is a reasonable goal — but does it require a full Linux
>> boot?  The transport layer is independent of what the guest is running.  A
>> firmware-only pseries migration (as was done in v1) would cover the
>> pseries-specific migration path with substantially lower CI cost.
>>
>> Please clarify in the commit message why a full Linux boot is needed here, or
>> consider using a firmware-only guest for the two new tests.\
> 
> Hi Amit, Thomas,
> 
> I do agree that full boot test cases might be unnecessary, however it was 
> suggested by Harsh during offline discussions that if a full boot test 
> already exists for TCP, so perhaps the best course of action here is to 
> revert back to the firmware-only test cases from v1. I do need suggestions 
> on if we should extend test_migration.py or make a new file for the ppc 
> machines.
I think I'd just turn "mac99" in test_migration_with_unix() and 
test_migration_with_exec() in test_migration.py into "pseries", and keep the 
"mac99" in the tcp test there. That should give enough test coverage for 
both machines in quick test mode.

  Thomas


