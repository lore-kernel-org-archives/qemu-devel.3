Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6245BCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLKuj-0001oW-U7; Fri, 08 May 2026 09:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wLKui-0001oE-Vl
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wLKug-0004EI-6X
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778245597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5sJzRRKNlBRPA+UoypqIlNiwhFhujhDw+Cg+ASkfvw=;
 b=CMrkB67Nyrvdy8lalbJdDM0MFnhZ4U7XAA2Ww+23TKP+UcBpjTttUiZP2VKBdaK7bbHcDk
 ozg/hRPQnylcJV57OBkYWtpbKioDmZDLM46bKUJkGvLDs9VzzSLt51w+1bOjqtI+Rk9xtm
 O8dUyxhLqhudG3Gz4CwrZeug9dNkszA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ClDvzwnpPu6-TdMFbTKibQ-1; Fri, 08 May 2026 09:06:36 -0400
X-MC-Unique: ClDvzwnpPu6-TdMFbTKibQ-1
X-Mimecast-MFC-AGG-ID: ClDvzwnpPu6-TdMFbTKibQ_1778245595
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d144d3428so11645955e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778245595; x=1778850395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B5sJzRRKNlBRPA+UoypqIlNiwhFhujhDw+Cg+ASkfvw=;
 b=JdHJF+3/ftTAtRax2R3CJdttNQvAPF6No7W2OatN1NznY6i8bx3mQCzY4Yojm7qwpn
 FWbS3T4AH/MWDpvTH1K59PJ/7sAszDLvSX79qgoVz6/TAq9A3+o5gYdvRd4tqmmux69d
 PhQLvkVVLo+QKPy9KwOZUM266EPziCBF1nPCoawBrI0+vAQDitCjkoeG5HWGVrKNWBCF
 J6Zth2OOkYwFEOldmnyegIE+M/QPxsP2KvvnWHskg3XMdcIXDsfRBZOr63uE8tHV253n
 /lwSI0yLmgN0K6CH4HGvWMtHoLxY4dk7sIk65WPeCjoNjRDfrTJbTa6L+9JztKkmlIcp
 rVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778245595; x=1778850395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5sJzRRKNlBRPA+UoypqIlNiwhFhujhDw+Cg+ASkfvw=;
 b=AJSeQe9I9tnex3xirm3eOqWo6BtF7fUZU5RIxSV7hB4uHYnKbupFhB4/El8F3qOMVU
 VZ/+D6ttnZhEsA/uPlHc0g9fWjGtjt49N87AKYNRgR6eicjjthu7D0UDPbnQwlHpEgFv
 SYGj93NBYX7hyeK+6jubleEMzLjqQrEDRoPEGv8ASun7LVMuwHrVLLLZNB0865Z54kko
 deoOQbG896oxC7sCRGhiwj/XWmUaPf9LkDc7DyJR5AmHSlw6hRQcqb14GWoZ6Fe0cuZ4
 sII+Mv4TQba9pkSa2GFvko3Mhbs+HoVh5+IvWMn5pLpIsGV/2sybo/PByqZnSq0YiuxB
 AiFg==
X-Gm-Message-State: AOJu0Yz8EWUz7cO4Art+Vx+lPqQ71KhGpcSwIS9dTk/M5vwCndMcb5B/
 Zv614XEp5PDUnsWH3WfL152oF+lZRKnsqP+NWdssNp09ZCgYROehC5/jlAZpgt/gack7x1HiNq7
 lckhkDAEGQaatnV4wMEop3uDJRJNQCp65fCdJRorATLnV4Hh7Uqx5kCoU
X-Gm-Gg: AeBDieuaRL5cgOS41ZJhZZfqwAAwm/c3BKq4WB2PMSGVbbP9Ng/LcQAEhmFBHcFnrQ7
 o35VL06IfM+g0S4mZM+LQTGYAHcd7MDzai+kNnm90pKHNi8WnzCbIEg011RIYXtxL2hK3vXDxJE
 ShivLvZF8yhQu1ITZVO8JN4zSFNL6Bqkiok0vnGHlj4e3mjfmvtWv19LPSczLAJOvQQx+f6Ajed
 Az+4G4ChNiG7EGD9bQdvZkCirZ4eOK3D+7X3fmrnNzTIt3SLJd2wyEOmgHllhShw8786J5+dBWJ
 wTYVP/mS4uhjI5KHm2AwXQ6OWdD/4L1FnUVsBWTGddp1tfk4NjHl5giTtFXWwMz+zofWwB0m+TI
 a8cvb7gedumbvU0s/Wg8AW8ME/gOwnS8nrst/6KEYkqukW70pY44mYa4L8WxR5cT/ZvFGFNirKk
 ReROc2lrWYYKlJWYd+8QbusOiVNSoXtN9mWU5+njKdN/81Ywq4iD4=
X-Received: by 2002:a05:600c:a118:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48e51f32870mr149164845e9.14.1778245595055; 
 Fri, 08 May 2026 06:06:35 -0700 (PDT)
X-Received: by 2002:a05:600c:a118:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48e51f32870mr149164445e9.14.1778245594584; 
 Fri, 08 May 2026 06:06:34 -0700 (PDT)
Received: from ?IPV6:2003:cf:d713:2001:af32:685a:7b5a:da25?
 (p200300cfd7132001af32685a7b5ada25.dip0.t-ipconnect.de.
 [2003:cf:d713:2001:af32:685a:7b5a:da25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b071sm4233051f8f.14.2026.05.08.06.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 06:06:33 -0700 (PDT)
Message-ID: <8ec42109-4123-4cc7-a55e-9aa2576a791c@redhat.com>
Date: Fri, 8 May 2026 15:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/28] fuse: Manually process requests (without libfuse)
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-18-kwolf@redhat.com>
 <2493d422-d58a-4409-aee4-e932a4e0a73c@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <2493d422-d58a-4409-aee4-e932a4e0a73c@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08.05.26 13:55, Fiona Ebner wrote:
> Dear maintainers,
>
> Am 10.03.26 um 6:37 PM schrieb Kevin Wolf:
>> From: Hanna Czenczek <hreitz@redhat.com>
>>
>> Manually read requests from the /dev/fuse FD and process them, without
>> using libfuse.  This allows us to safely add parallel request processing
>> in coroutines later, without having to worry about libfuse internals.
>> (Technically, we already have exactly that problem with
>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>>
>> We will continue to use libfuse for mounting the filesystem; fusermount3
>> is a effectively a helper program of libfuse, so it should know best how
>> to interact with it.  (Doing it manually without libfuse, while doable,
>> is a bit of a pain, and it is not clear to me how stable the "protocol"
>> actually is.)
>>
>> Take this opportunity of quite a major rewrite to update the Copyright
>> line with corrected information that has surfaced in the meantime.
>
> a colleague ran into another issue with a fuse export, this time in 
> combination with virt-fw-vars and bisecting points to this patch. 
> Before commit a94a1d7699 ("fuse: Manually process requests (without 
> libfuse)") the reproducer [0] completes successfully, after that 
> commit it hangs at [1]. The issue is still present with current 
> master. I can dig into the details next week.

On my system, virt-fw-vars opens the file with O_TRUNC (after “INFO: 
writing raw edk2 varstore...”). It then tries to write to the file, but 
this returns a short write because the export is not marked as growable, 
and for some reason, the write is infinitely retried instead of aborting 
on ret=0 (which should indicate ENOSPC for writes).

Using growable=true makes it work.  (For me :))

For some reason, before said commit, libfuse just did not pass that 
truncate on. I’ll look into why exactly, but so far I would say the FUSE 
export behavior is as I would expect it.

Hanna

>
> Best Regards,
> Fiona
>
> [0]:
>
>> #!/bin/bash
>>
>> rm /tmp/disk.raw
>> rm /tmp/export.fuse
>> cp /usr/share/pve-edk2-firmware/OVMF_VARS_4M.ms.fd /tmp/disk.raw
>> touch /tmp/export.fuse
>>
>> (
>> ./storage-daemon/qemu-storage-daemon \
>>     --blockdev 
>> raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw \
>>     --export 
>> fuse,id=exp0,mountpoint=/tmp/export.fuse,node-name=node0,writable=true \
>>     --chardev socket,id=qmp,path=/run/qsd.qmp,server=on,wait=off \
>>     --monitor chardev=qmp,mode=control
>> ) &
>>
>> sleep 1 # too lazy to do proper synchronization for the reproducer here
>> virt-fw-vars --inplace /tmp/export.fuse --distro-keys windows
>> echo '{"execute": "qmp_capabilities"}{"execute": "quit"}' | socat - 
>> /run/qsd.qmp
>
> [1]:
>
>> INFO: reading raw edk2 varstore from /tmp/export.fuse
>> INFO: var store range: 0x64 -> 0x40000
>> INFO: add db cert 
>> /usr/lib/python3/dist-packages/virt/firmware/certs/MicrosoftWindowsProductionPCA2011.pem
>> INFO: certificate already present, skipping
>> INFO: add db cert 
>> /usr/lib/python3/dist-packages/virt/firmware/certs/WindowsUEFICA2023.pem
>> INFO: certificate already present, skipping
>> INFO: writing raw edk2 varstore to /tmp/export.fuse
>
>


