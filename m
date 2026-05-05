Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D24CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKFie-0008O6-IK; Tue, 05 May 2026 09:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wKFic-0008Nn-NU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wKFia-00061D-Pn
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777987303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRsx9dqGyJHJ/wztQdWsNcV7+KU0v0IAsUXSz4FQbpU=;
 b=TEO7eXnzNT6thmsvbEEJep8PJPrPOBQfD6zuZdlgoJArQ+0cgt05HlrN06ZH1k2WMMOsMG
 7K7s76IoP6QccXa+pzcr9D7wk6fikKYkSB69WcCChf/u6Xy1WLGH79XttS9VgVRwDqZOGt
 5NZfU3pX2cB/yiJ3Zr5VedycCaUIbaA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-AICaRIVNOyOfECGRznhEKA-1; Tue, 05 May 2026 09:21:40 -0400
X-MC-Unique: AICaRIVNOyOfECGRznhEKA-1
X-Mimecast-MFC-AGG-ID: AICaRIVNOyOfECGRznhEKA_1777987299
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a55ecc32cso48983845e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777987299; x=1778592099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRsx9dqGyJHJ/wztQdWsNcV7+KU0v0IAsUXSz4FQbpU=;
 b=pT57TLwQBNq508ybWmvLJwRXKpdNlgp333uvju3ol61KAA4Kyxt3EMFKWMAKDQbrHl
 D7sX5VRU8I5+Ve8TttGGMsS3rhjGvl6S+TzwWCEEAIhV32Co3qXL0LQJDJTTMgJcaiId
 jxr+HDN5UBZjRusQRgnzMSVx5iSGpj1Y02Bk+C/5g3C+crtzYimoqPY/kBOhqd23DYfy
 TXCxOGH+PlZdPbZnstfiAsMYETXx4XuyxJgfdVQ0fuYu2IcFabpydU9twshxwXydxm0Q
 dbLTgQYdPoWd/0LQngmC804EjtbscZ0Ac0jCvrMzDAlFNvnLu09DasY9wg0DnN/msL7/
 sOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987299; x=1778592099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRsx9dqGyJHJ/wztQdWsNcV7+KU0v0IAsUXSz4FQbpU=;
 b=khdvj42KQnsfvtyqUK0mxbSD6RpubnolH0u5VRxa6GEuTLthELSlA3avj9B+dSOhNw
 IoMdV8t1Kn5jrkVv+4xbfqTlVmpBEpARnIq5BLITbGjg2buh8xkL8pxrgNjV7wKQkOqS
 N9+VBt4O4aRjuszfOHuJG08ScwucRSUuG2zRQTYoMi4V9fZr3hRXvBlxlSzlIq5SyJrP
 29Mn3RgtHKR9Ed7D0VFVJfZUUHB4F5O4EBylcAdQ//GW9lS3lrxq6sC5+FQHmYHSqDDq
 z0gmOq3S04SZyWBEEl7Dak0rQ/vlsOu3i7071nBBL5YmPH5BoYjstZy3e9CC4mgbZ0lu
 IlrQ==
X-Gm-Message-State: AOJu0YzuHZkhLmnQrNnlb8nUmlxhjqGTxikziAGVcwLhSmKixbBaCCb8
 wGEZhcc9ClrmpDGQuTjQTuT/Bgf2YKhoN2sRL4x6/x5QVSh49m2DUV81C90NeYSaDa8/reAFfrO
 JprWL1ZTSE91H0Y5iuebF19WKtjX8Szg5ohU+yCX5r2bRto5s+Z8CHXnf
X-Gm-Gg: AeBDiesLxOWGx9SMAK28KDAlvLBUU5SFG+07EskdwzG71UiT4FGt8V1tCBObWmIasZK
 72om+Wz2DqIoUHfCR+sMDl9WLWZ3JfAP8P3a+kIQRZ4U3SEuiq9i8hzagVLqIqRSxz7T5JTiRXb
 zZaeLyr7kCWrXfmuWCcr4LwsR1+PhqCRc11EpDdAMtuk2M3wSOo0GfAPYik1W+btuYSFirenb2L
 fzipp5OyKaaEejEE6Nje2mQUS+wzhD0x7ew5wQMts4bmCmqOsMpgXjACH/uTB90lBDAkUDQciFE
 j88zqhkfFv4QQZ5MydsDpDPfJZvZoaKyQ3BzvpeOzydHl0WUANsx8srLYljS5HWOdkpG46KXmud
 uPREHg6cgapFG9OdJOJqQBUdVSda2eOpIH3+s9aImCjK8x+E+ntnuYmxmPeQoUvOzYm33oP0SVG
 TRYiVB+c53UA7vyK7fRiE5e3YiDVw1pQ3O/VmbcMXT8QqKCtXXSfYkIh3AMaJ6DA==
X-Received: by 2002:a05:600c:a30a:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-48a98674f9emr175155365e9.24.1777987299351; 
 Tue, 05 May 2026 06:21:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-48a98674f9emr175154665e9.24.1777987298706; 
 Tue, 05 May 2026 06:21:38 -0700 (PDT)
Received: from ?IPV6:2003:cf:d713:2006:5bdb:d00a:a128:cf2d?
 (p200300cfd71320065bdbd00aa128cf2d.dip0.t-ipconnect.de.
 [2003:cf:d713:2006:5bdb:d00a:a128:cf2d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb69800sm342578505e9.2.2026.05.05.06.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:21:37 -0700 (PDT)
Message-ID: <a6b65dc8-1ec6-4b45-8c50-6f2f2e517ecd@redhat.com>
Date: Tue, 5 May 2026 15:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/28] fuse: Set direct_io and parallel_direct_writes
To: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-9-kwolf@redhat.com>
 <72090fa4-2f4e-483d-9ceb-c19b8119a25d@proxmox.com>
 <17fe584f-6c64-4ccf-8253-c813665e0070@proxmox.com>
 <e86b82e4-a85d-46d2-bb8f-4e0f59e49a44@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <e86b82e4-a85d-46d2-bb8f-4e0f59e49a44@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05.05.26 13:01, Fiona Ebner wrote:
> Am 05.05.26 um 11:03 AM schrieb Fiona Ebner:
>> Am 30.04.26 um 4:20 PM schrieb Fiona Ebner:
>>> Dear Maintainers,
>>>
>>> Am 10.03.26 um 6:33 PM schrieb Kevin Wolf:
>>>> From: Hanna Czenczek <hreitz@redhat.com>
>>>>
>>>> In fuse_open(), set these flags:
>>>> - direct_io: We probably actually don't want to have the host page cache
>>>>    be used for our exports.  QEMU block exports are supposed to represent
>>>>    the image as-is (and thus potentially changing).
>>>>    This causes a change in iotest 308's reference output.
>>>>
>>>> - parallel_direct_writes: We can (now) cope with parallel writes, so we
>>>>    should set this flag.  For some reason, it doesn't seem to make an
>>>>    actual performance difference with libfuse, but it does make a
>>>>    difference without it, so let's set it.
>>>>    (See "fuse: Copy write buffer content before polling" for further
>>>>    discussion.)
>>>>
>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> Message-ID: <20260309150856.26800-9-hreitz@redhat.com>
>>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>> ---
>>>>   block/export/fuse.c        | 2 ++
>>>>   tests/qemu-iotests/308.out | 2 +-
>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>> index 0422cf4b8af..d0e3c6bf61f 100644
>>>> --- a/block/export/fuse.c
>>>> +++ b/block/export/fuse.c
>>>> @@ -582,6 +582,8 @@ static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
>>>>   static void fuse_open(fuse_req_t req, fuse_ino_t inode,
>>>>                         struct fuse_file_info *fi)
>>>>   {
>>>> +    fi->direct_io = true;
>>> unfortunately, turning on direct IO here breaks a use case with swtpm.
>>> Reproducer below [0], which fails with an error message
>>>    /usr/bin/swtpm exit with status 256:
>>> after this commit.
>>>
>>> Dropping the FOPEN_DIRECT_IO flag in current master makes the reproducer
>>> work again.
>>>
>>> Should there be a BlockExportOptionsFuse property to control the direct
>>> IO flag and have it be opt-in to avoid this breakage (and potentially
>>> others)?
>>>
>>> Best Regards,
>>> Fiona
>>>
>>> [0]:
>>>
>>>> #!/bin/bash
>>>> rm /tmp/disk.qcow2
>>>> rm /tmp/export.fuse
>>>> ./qemu-img create -f qcow2 /tmp/disk.qcow2 4M
>>>> touch /tmp/export.fuse
>>>> (
>>>> ./storage-daemon/qemu-storage-daemon \
>>>>      --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
>>>>      --export fuse,id=exp0,mountpoint=/tmp/export.fuse,node-name=node0,writable=true \
>>>>      --chardev socket,id=qmp,path=/run/qsd.qmp,server=on,wait=off \
>>>>      --monitor chardev=qmp,mode=control
>>>> ) &
>>>> sleep 1 # too lazy to do proper synchronization for the reproducer here
>>>> swtpm_setup --tpmstate file:///tmp/export.fuse --createek
>>>> echo '{"execute": "qmp_capabilities"}{"execute": "quit"}' | socat - /run/qsd.qmp
>> Self-contained version modeling the relevant part of swtpm_setup:
>>
>>> #!/bin/bash
>>>
>>> cat - > /tmp/mmap.c <<EOF
>>> #include <assert.h>
>>> #include <fcntl.h>
>>> #include <stddef.h>
>>> #include <sys/stat.h>
>>> #include <sys/mman.h>
>>>
>>> int main(int argc, char **argv)
>>> {
>>>      struct stat st;
>>>      int fd;
>>>      void *ptr;
>>>
>>>      assert(argc == 2);
>>>      fd = open(argv[1], O_RDWR|O_CREAT, 0x640);
>>>      assert(fd > 0);
>>>      fstat(fd, &st);
>>>      ptr = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>>      assert(ptr != MAP_FAILED);
>>>      return 0;
>>> }
>>> EOF
>>> gcc /tmp/mmap.c -o /tmp/mmap
>>>
>>> rm /tmp/disk.qcow2
>>> rm /tmp/export.fuse
>>> ./qemu-img create -f qcow2 /tmp/disk.qcow2 4M
>>> touch /tmp/export.fuse
>>>
>>> (
>>> ./storage-daemon/qemu-storage-daemon \
>>>      --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
>>>      --export fuse,id=exp0,mountpoint=/tmp/export.fuse,node-name=node0,writable=true \
>>>      --chardev socket,id=qmp,path=/run/qsd.qmp,server=on,wait=off \
>>>      --monitor chardev=qmp,mode=control
>>> ) &
>>>
>>> sleep 1 # too lazy to do proper synchronization for the reproducer here
>>> /tmp/mmap /tmp/export.fuse
>>> echo '{"execute": "qmp_capabilities"}{"execute": "quit"}' | socat - /run/qsd.qmp
> The kernel docs [0] mention:
>
> "In direct-io mode the page cache is completely bypassed for reads and
> writes. No read-ahead takes place. Shared mmap is disabled by default.
> To allow shared mmap, the FUSE_DIRECT_IO_ALLOW_MMAP flag may be enabled
> in the FUSE_INIT reply."
>
> I quickly tested with setting FUSE_DIRECT_IO_ALLOW_MMAP in
> fuse_co_init() (it's part of the flags2 ones, so also requires
> FUSE_INIT_EXT to be set in the flags) and this makes the swtpm use case
> work again :)
>
> So, should that flag be set by default (if supported by the kernel) for
> backwards compatibility? Or what should we do about the issue?

I see no reason not to set the flag (FUSE_DIRECT_IO_ALLOW_MMAP). Sounds 
very good to me!

Hanna


