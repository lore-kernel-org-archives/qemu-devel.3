Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1AACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIYD-0001oj-UP; Wed, 10 Jun 2026 09:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXIXg-0001X9-Vh
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXIXd-0002n0-C1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781096420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGARpbAu/Jsyj5xVk83kPSGBTcgWkCsoFPUaUv9at98=;
 b=QsGNNpJejM3efojpIQQCodEqjmMZ5oV43jlgQ3ZkjyPLct9rC17SFytROrjWR9p5pOBnPn
 dvYzULR0qttBmctUXnutyS4p/3+jxR5mAjJfB5BkFZxOU7zRLJDOzd6gJazErD5h0bKbyo
 O/cnd5uMXb++KPmmrD95gPkySDWZPYQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-BO7xQOVJNmeK4TYjjffmVQ-1; Wed, 10 Jun 2026 09:00:12 -0400
X-MC-Unique: BO7xQOVJNmeK4TYjjffmVQ-1
X-Mimecast-MFC-AGG-ID: BO7xQOVJNmeK4TYjjffmVQ_1781096411
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8584e3fc96so3413233a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781096410; x=1781701210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PGARpbAu/Jsyj5xVk83kPSGBTcgWkCsoFPUaUv9at98=;
 b=NBZze/HRTZcIJ2Ix1aU5pFa8nZTdhMIGFemKcNNCkcCVGNRFd/qxw9Wd5lEVGkmjVb
 ipSEljThJIwJ3ulSQxkabhmrKLswYIP7W2YiXXkjY4GpWpBMJEPaUlhcidEQEGjAhHwI
 o/VGd1kLl4vs94ibl9VLnixb5o/77FwjkPfg8sF6ZmKsk19WZiY5pmCF7CgA/lko4D4F
 BDpjYF+U+sb+X28VlxH1z4L40gHo7kGxJ2ac2ABB4sOn7FlGBvz6XaMq+QYiVgNkrEvc
 3NbrUJ2NFfBmVkGCLG+rRdQdHcZ/DUxRB406BvE9zGBCrdNbM6Kr7hH7SRUXCCSK2El5
 9SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781096410; x=1781701210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PGARpbAu/Jsyj5xVk83kPSGBTcgWkCsoFPUaUv9at98=;
 b=lXi35iiqXdqyuWC3VwwQP6F59EbG0TfjyiBk5ZiDvhNEywi8y1FwFO9RvYw9NQdOnX
 UC//aY67cZ+8uFGwzniCoTasnJRN2z5OuID0cwmfplf0XCHfCdZbEsUUP6QYcZZySlX5
 sCSJqtdqv+D2wx1UMVqI+SIU4Gbf2wE6Rb9ewjmb7gOGeQK0Z7HyhEiSl1n6/PDedWMw
 7woYrJ9jP+kn0fUCm9iSYnr61U6RJQxDAG5WlH3HdRVB+Ie1Zwf0KUXrsGqSQBmdPBWX
 YtKVUESDMV1n1SzpXxOZ2VJm9RG+VYrwpq1TbaSreIxowgajA5dyQwYJMQLqkj3TkBIE
 /tQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R/jDqkQzhvTp06m7z4SoCEBFLYoJ/1WAYcEbqEsCKeTId/1fc1fgJEVNzi2STjL1wFklR2WRglhed@nongnu.org
X-Gm-Message-State: AOJu0Yxv6Q4NzBDPvGY8UNlRR8AObzD4IezbPUFchz9cH5ss3OZPiXNY
 82IynF7EEuetAdFo+e0Rb/RYiCavRMEY0X8n/Xd9ELbmebtnXEJPVwcF7N7AxQIGvg8TaxIaKUS
 GHK0aJe1Ocxll/4P8y2AlQh4wcPExRJpH6OxIf56WTm1nbey2vg1gCf6k
X-Gm-Gg: Acq92OHHCAjFC01xsYzCtFVlpkU+L8Uw+1ZKr6QR54/hKTKhVf6hZmkjWQCy74RCIL5
 kn7IOThUh459Y/J43jxYybYmz5hCsKRAGcX4Bsc8mj2bt9pBcF46zhqIrO7Bw/LrXxuZItnkhYD
 2IvvEr6C2FzO63AA0rjY0cD8dQLHp8ocmM11skEN9Kn61rZrzB9hSw9AoXULQSd1YKvJIPwC1Gl
 ZnDsoK7lWzpSGyWWCxrXe1ahmGkSrScgaV00amaNsO/BLCzOHH1R8uKHcbKSBFGuEFhT4OZk9HW
 lmDMS3JbixcXYWu7/hP2pscX8W6N78p/fduJzikPVR4iKIp9Qd7aBZ9NqmpjtokPNar+s6B3IFk
 0JcIOd3U2odZfTuEcDi6m6Err2SMGdnvUq9bowFNdSPwXHxaCOPTJa6Ixuyh4J38JLFfx3uRdNN
 k=
X-Received: by 2002:a17:90b:3c87:b0:36b:9e24:c692 with SMTP id
 98e67ed59e1d1-370f0b57f02mr25559037a91.20.1781096409002; 
 Wed, 10 Jun 2026 06:00:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3c87:b0:36b:9e24:c692 with SMTP id
 98e67ed59e1d1-370f0b57f02mr25558977a91.20.1781096408260; 
 Wed, 10 Jun 2026 06:00:08 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf90a32sm28455443a91.1.2026.06.10.06.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 06:00:07 -0700 (PDT)
Message-ID: <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
Date: Wed, 10 Jun 2026 23:00:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jugraham@redhat.com, shan.gavin@gmail.com
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260610082637-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 6/10/26 10:27 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 10:19:31PM +1000, Gavin Shan wrote:
>> On 6/10/26 10:12 PM, Michael S. Tsirkin wrote:
>>> On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
>>>> On 6/10/26 7:54 PM, Pavel Hrdina wrote:
>>
>> [...]
>>
>>>>>
>>>>> You did not answer the question that Daniel was asking, how will user
>>>>> know that max-bounce-buffer-size should be used if it's necessary to fix
>>>>> guest system hangs and how will user know what magic value should be set?
>>>>>
>>>>
>>>> Sorry that I missed to answer Daniel's questions. For this specific case,
>>>> user need to enlarge the bounce buffer size when seeing the following error
>>>> message. We can add an explicit one in address_space_map() if the existing
>>>> error message isn't obvious.
>>>>
>>>>     qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>>>
>>>>     void *address_space_map(AddressSpace *as,
>>>>                           hwaddr addr,
>>>>                           hwaddr *plen,
>>>>                           bool is_write,
>>>>                           MemTxAttrs attrs)
>>>>     {
>>>>         if (!memory_access_is_direct(mr, is_write, attrs)) {
>>>>             if (l == 0) {
>>>>                 error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
>>>>                 *plen = 0;
>>>>                 return NULL;
>>>>             }
>>>>         }
>>>>
>>>> As to the value user should take for max-bounce-buffer-size, it is really case by case
>>>> and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
>>>> smallest value works for them. The worst case is to set 0xFFFFFFFF.
>>>>
>>>
>>>
>>> This is not at all reasonable. All kind of fixes are possible but
>>> fundamentally, bounce buffering data path is by itself already a
>>> bad idea.
>>>
>>> I have no idea what does bounce buffering device ram accomplish.
>>>
>>> In the end, qemu still simply reads the memory from/to the buffer.
>>>
>>> My suggestion is to first of all look for ways to mark the
>>> memory as direct.
>>>
>>
>> As I explained to Peter Xu in another reply, we can't simply mark the (RAM
>> DEVICE) memory region is directly accessible. The memory region is initialized
>> by memory_region_init_ram_device_ptr() in hw/vfio/region.c::vfio_region_mmap().
>>
>> The  accesses to the memory region is handled by 'ram_device_mem_ops' where
>> {ldn, stn}_he_p() are used in its read/write handler. They're different
>> from memcpy() since the data endianness is well handled in {ldn, stn}_he_p().
>>
>> Thanks,
>> Gavin
>>
> 
> What is endianness set to, for this region?
> 

The endianness of the memory region is set to that for the host.

static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
     .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
};

Thanks,
Gavin


