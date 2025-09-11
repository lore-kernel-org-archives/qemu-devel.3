Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DEDCAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 11:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwfND-0000jn-I3; Thu, 11 Sep 2025 07:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwfN9-0000i0-5b
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwfN3-0001DG-D4
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757589700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+yxvGMzFMIWXkNfIuSKcX0w4tmkZdfCiYcFwoI/3gMo=;
 b=bZVu1YXCF6PiQ0eLZHKhKvLHuZOn4YWXYTwkqsGYMurzdqhNp9ZQ4U4uNdewcRlx2Bo8Dt
 PGaMacVl7fMOtYIIqWh8t6DfRBUZE7bOfPgY+bkwBAhoeQDVlNHAJmlEDnVHRaSJyQMQKe
 XHFsyK6TDmws86DotCDfnzRA3MvLzMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-nFRYwRLvN66qNJNzyTQyIQ-1; Thu, 11 Sep 2025 07:21:38 -0400
X-MC-Unique: nFRYwRLvN66qNJNzyTQyIQ-1
X-Mimecast-MFC-AGG-ID: nFRYwRLvN66qNJNzyTQyIQ_1757589698
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e1e7752208so434073f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 04:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757589697; x=1758194497;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+yxvGMzFMIWXkNfIuSKcX0w4tmkZdfCiYcFwoI/3gMo=;
 b=C+KSc0XZbmlfzYUhp9C2mYFbqkn5/fFHB/K6jR2ISDpeEHjt228Je1XwvJ+VUqPZ+3
 p6qlaMVuBojcOZsIRggIDxWVKNIbT4GRIdAn7xcyJUdiiJFJB6qBIFrprG2laNUtXvuE
 QCdkKLkE+6LGCZ33pNClafrG1YfMG0l7OEfneRH7okdn243T3QcfX4I5zhQL1fKUQ0k+
 TGIpmgUTla/IoaviH5NlIU3hBt76/Gm6l/z4u3W1QDwnwn9VjemFFwB4mmRbKpT6LWfy
 jGy+q1GBuS98kSWr/dr4ewN4v3FuL1WtHTR8ZfOJl1lbqDLN4qCMB9P95GjZDqn1MgEU
 4kAQ==
X-Gm-Message-State: AOJu0YwGKDGqFqseYfoSwNezgfERUqgwqTHkLo2FHFcnd3DYoJrVZtEP
 lUtJTVxLZQ/gJnk7JXbwmZb1LYWFmH8PPdJCvkw5IjkiDPmvO3OzlQyMX71niYm9m64Lid0XLQW
 xVnDUYfoQYLyW18G6BZwp98Kr5PdM42TW/98aWkxVsggNbycEavHsOuBQ
X-Gm-Gg: ASbGncsu4fdjYAut8YgMtAY9YbwH3UsAGY8yfuuuTHAukV0wf6tcgKaOkNvYO1MD60W
 HK/fA8WyhSvV2XPbH0NPRUXsLKtZcpPUxSTb/3I9zmeoPVP7HpuXF9t8lQd4sntgcVDTNghMkni
 0cFV56mirjdq1e89Jd0rdmzVvU5KJjXuIqnzU+Af7GrcwsfABUgyVvnsL5KGj9/Ll1i4w0v0uRx
 jl3/yY6tA/7Xb/Wefc6i5Cd3sLEmg5tIgcP5vkmjQmUDzff6w5NrQSxtkvMovuzEkGjDkAMV1fz
 Icp4dLrjkzFWJOG1uwdi/U6wxTTIOsQCa81ATnKNTUsKWPFs9xtCXhkHOg1nJq6wtthUO2dniFE
 0jHeF1Q==
X-Received: by 2002:a5d:6588:0:b0:3e7:4277:ddb0 with SMTP id
 ffacd0b85a97d-3e74277e059mr10608456f8f.43.1757589697589; 
 Thu, 11 Sep 2025 04:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ18Wx0Exxhr0ltItQOszouvtE2JKPR3xHZ95FZ9a/RYhxxVKfEgo5lyp2xHVFFjT53jfcXg==
X-Received: by 2002:a5d:6588:0:b0:3e7:4277:ddb0 with SMTP id
 ffacd0b85a97d-3e74277e059mr10608432f8f.43.1757589697136; 
 Thu, 11 Sep 2025 04:21:37 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607770c2sm2093345f8f.8.2025.09.11.04.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 04:21:36 -0700 (PDT)
Message-ID: <58d82de4-25ac-48f5-ae80-181faf2bf8cf@redhat.com>
Date: Thu, 11 Sep 2025 13:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Some iotests are failing with -luks
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, hreitz@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>, Hyman Huang <yong.huang@smartx.com>
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
 <aMGijXg9XIpbbn-v@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aMGijXg9XIpbbn-v@redhat.com>
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

On 10/09/2025 18.08, Kevin Wolf wrote:
> Am 10.09.2025 um 17:16 hat Thomas Huth geschrieben:
>>
>>   Hi,
>>
>> when running "./check -luks" in the qemu-iotests directory,
>> some tests are failing for me:
>>
>> 295 296 inactive-node-nbd luks-detached-header
>>
>> Is that a known problem already?
> 
> Not to me anyway.
> 
>> FWIW, 295 is failing with the following output:
>>
>> 295   fail       [17:03:01] [17:03:17]   15.7s                failed, exit status 1
>> [...]
>> +EWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
>> +EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=6 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
>> +EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=10 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
>> +E
>> [...]
>>
>> etc.
>>
>> 296 looks very similar (also a "qemu received signal 6" error),
>> but the others look like this:
> 
> When it gets signal 6 (i.e. SIGABRT), that usually means that you should
> have a look at the coredump.

With "-p" I additionally get this error message in the log:

qemu-system-x86_64: ../../devel/qemu/block/graph-lock.c:294:
  bdrv_graph_rdlock_main_loop: Assertion `!qemu_in_coroutine()' failed.

With -gdb I can get a back trace that looks like this:

Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
0x00007ffff4ba7e9c in __pthread_kill_implementation () from target:/lib64/libc.so.6
--Type <RET> for more, q to quit, c to continue without paging--
#0  0x00007ffff4ba7e9c in __pthread_kill_implementation () from target:/lib64/libc.so.6
#1  0x00007ffff4b4df3e in raise () from target:/lib64/libc.so.6
#2  0x00007ffff4b356d0 in abort () from target:/lib64/libc.so.6
#3  0x00007ffff4b35639 in __assert_fail_base.cold () from target:/lib64/libc.so.6
#4  0x0000555555574eae in bdrv_graph_rdlock_main_loop () at ../../devel/qemu/block/graph-lock.c:294
#5  0x0000555555aa2f43 in graph_lockable_auto_lock_mainloop (x=<optimized out>) at /home/thuth/devel/qemu/include/block/graph-lock.h:275
#6  block_crypto_read_func (block=<optimized out>, offset=4096, buf=0x555558324100 "", buflen=256000, opaque=0x555558a259d0, errp=0x555558a8c370)
     at ../../devel/qemu/block/crypto.c:71
#7  0x0000555555a5a308 in qcrypto_block_luks_load_key (block=block@entry=0x555558686ec0, slot_idx=slot_idx@entry=0,
     password=password@entry=0x555558626050 "hunter0", masterkey=masterkey@entry=0x55555886b2a0 "",
     readfunc=readfunc@entry=0x555555aa2f10 <block_crypto_read_func>, opaque=opaque@entry=0x555558a259d0, errp=0x555558a8c370)
     at ../../devel/qemu/crypto/block-luks.c:927
#8  0x0000555555a5ba7e in qcrypto_block_luks_find_key (block=0x555558686ec0, password=0x555558626050 "hunter0", masterkey=0x55555886b2a0 "",
     readfunc=0x555555aa2f10 <block_crypto_read_func>, opaque=0x555558a259d0, errp=0x555558a8c370) at ../../devel/qemu/crypto/block-luks.c:1045
#9  qcrypto_block_luks_amend_add_keyslot (block=0x555558686ec0, readfunc=0x555555aa2f10 <block_crypto_read_func>,
     writefunc=0x555555aa2e50 <block_crypto_write_func>, opaque=0x555558a259d0, opts_luks=0x7fffec5fff38, force=<optimized out>, errp=0x555558a8c370)
     at ../../devel/qemu/crypto/block-luks.c:1673
#10 qcrypto_block_luks_amend_options (block=0x555558686ec0, readfunc=0x555555aa2f10 <block_crypto_read_func>,
     writefunc=0x555555aa2e50 <block_crypto_write_func>, opaque=0x555558a259d0, options=0x7fffec5fff30, force=<optimized out>, errp=0x555558a8c370)
     at ../../devel/qemu/crypto/block-luks.c:1865
#11 0x0000555555aa3852 in block_crypto_amend_options_generic_luks (bs=<optimized out>, amend_options=<optimized out>, force=<optimized out>,
     errp=<optimized out>) at ../../devel/qemu/block/crypto.c:949
#12 0x0000555555aa38e9 in block_crypto_co_amend_luks (bs=<optimized out>, opts=<optimized out>, force=<optimized out>, errp=<optimized out>)
     at ../../devel/qemu/block/crypto.c:1008
#13 0x0000555555a96030 in blockdev_amend_run (job=0x555558a8c2b0, errp=0x555558a8c370) at ../../devel/qemu/block/amend.c:52
#14 0x0000555555a874ad in job_co_entry (opaque=0x555558a8c2b0) at ../../devel/qemu/job.c:1112
#15 0x0000555555bdc41b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../../devel/qemu/util/coroutine-ucontext.c:175
#16 0x00007ffff4b68f70 in ?? () from target:/lib64/libc.so.6
#17 0x00007fffffffc310 in ?? ()
#18 0x0000000000000000 in ?? ()

>> inactive-node-nbd   fail       [17:13:56] [17:14:04]   7.5s                 failed, exit status 1
>> --- /home/thuth/devel/qemu/tests/qemu-iotests/tests/inactive-node-nbd.out
>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-inactive-node-nbd/inactive-node-nbd.out.bad
>> @@ -1,239 +1,64 @@
>>   Preparing disk...
>>   Launching VM...
>> -{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
>> -{"return": {}}
>> +ERROR:qemu.qmp.qmp_client.qemu-223907:Failed to receive Greeting: EOFError
>> +ERROR:qemu.qmp.qmp_client.qemu-223907:Failed to establish session: EOFError
>> +Traceback (most recent call last):
>> +  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 425, in _session_guard
>> +    await coro
>> +  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 250, in _establish_session
>> +    self._greeting = await self._get_greeting()
>> +                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 270, in _get_greeting
>> +    msg = await self._recv()
>> +          ^^^^^^^^^^^^^^^^^^
>> +  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 1009, in _recv
>> +    message = await self._do_recv()
>> +              ^^^^^^^^^^^^^^^^^^^^^
>> +  File "/home/thuth/devel/qemu/python/qemu/qmp/qmp_client.py", line 402, in _do_recv
>> +    msg_bytes = await self._readline()
>> +                ^^^^^^^^^^^^^^^^^^^^^^
>> +  File "/home/thuth/devel/qemu/python/qemu/qmp/protocol.py", line 977, in _readline
>> +    raise EOFError
>> +EOFError
> 
> Not sure what this is. It looks like the QEMU process failed to start,
> maybe it didn't like some command line option. I would expect an error
> message on stderr, but I'm not sure if qemu-iotests automatically
> displays that in such cases. I thought that yes, but maybe I'm confusing
> it with a different case.

With "-p" I'm getting this additional error message:

qemu-system-x86_64: -blockdev luks,file=disk-file,node-name=disk-fmt,active=off: Parameter 'key-secret' is required for cipher

  HTH,
   Thomas


