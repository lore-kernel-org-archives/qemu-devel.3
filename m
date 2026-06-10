Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A8CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHuS-0005Ek-K1; Wed, 10 Jun 2026 08:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXHuQ-0005Dx-CH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXHuH-0003qm-Ud
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781093980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t/6TizB8C1cqu0uWMDVTOo+qpPTL27Y7UCm81lI5ogI=;
 b=JLVDNzf3qYQcJaCU4ZjJIgpAsmbR8AD4uKZl6flrWJpmiZ2Hb5D4Fp0HyH1uxuvEPrvdL9
 18mWCwgUHo/G6YEQE4OdZGm4zsQIb5QYHMe4/4dpzGUyPCUCE0sJ8b5lTIqjXl8PhlkZfX
 h7XRLg4bVAYFfC0WcKV7qdXN8j3Vy48=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-HbOlgJwRNduUdiF4Bi2EjA-1; Wed, 10 Jun 2026 08:19:39 -0400
X-MC-Unique: HbOlgJwRNduUdiF4Bi2EjA-1
X-Mimecast-MFC-AGG-ID: HbOlgJwRNduUdiF4Bi2EjA_1781093978
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8422f987f2eso10384950b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781093978; x=1781698778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t/6TizB8C1cqu0uWMDVTOo+qpPTL27Y7UCm81lI5ogI=;
 b=PZiAO2cCANKlYUup5C0xuwLUXgrVGkSqgVgiKipZihRumwrohBNLV1WsLMTmZCq6fI
 B6sM4Q5rC1fpabIbrIwrGtPqQ8oG+GKnNUgzo8d+FIIuEhuMIoaPZOcE24r/mSfO7r7T
 /JRf+Lw7Z6tELVYSAhhv+fnBxwHXiIHElL7rK3G9bRHea2qnvjI//VH5lZxopZamdteh
 +8NZ0/ou3zcHdVwvlfqeZobm/tR9IqfIkwErc81cipe18iOp28eTqLduVmykg+IbG64h
 wn+yGJopVVeDs15kZdNV1x/J87PaR+O5jeO8U7bj78y/5+dV/mLQl7DJDqmu4DbLxfZR
 QgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781093978; x=1781698778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/6TizB8C1cqu0uWMDVTOo+qpPTL27Y7UCm81lI5ogI=;
 b=f3wLQeTEqgIfMN+F2eznJMMLyVPLNP3OSD3O1F9k6qS7xXYfzxHzOzsveuSGO7Caqq
 UBEe07xkweeD9hEemEB5fSJAc7N7r/hRazXHqp8PiwkpLQjGORmtv53dtkc/PuJ7hK5F
 MuzLrWMpX7yIMcNkgzA/1XHhPbaRZysjSIUBw7BAlSVdBFMscUhn7USQ6mWZAdDi7U79
 kl2dQ9fyxN9DWglmU6/HeTFwprkl7Ris8+nf2s8yEY3CBGL4VOhBQb6OhjwzTWtazA57
 LwdNf/EwfkU/owfNRil+s6ldop3abFaR7An0Oi57tSsQM42zXC7MdfLsQ2M080Kn98zz
 hxJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZDf+f042k2K9WiP69D9ZuO3/N1w+y0kxhnUonm991f/yPjyuC0VYiR7zCWcfbiZx55HOQe9k0JC3i@nongnu.org
X-Gm-Message-State: AOJu0YxJylbicq9qdRcuWMlb9xgw9OUBiPZYfPKMeD/I2RYwKCTfu4aw
 QFvGBsI+N8x4mnyz98Ez6jdKph4rC9DIRnKT7LFP9iU9V2fDJKlNNLpin1c1JZqz53s/oeZ5UsE
 MUjod7u4t43JkW8xbia2VqWH5obWQYBUpOEw4duQ0Vqsb9c96wA16fZs2
X-Gm-Gg: Acq92OEsG7twFjAX/8o+IcjuPdQ7Q/w/NWIiCQ/pP60mcjh4Y2vta4Kjo6e/JYsZSM+
 1rfzzp/IOQZugeJgVWS6AAp5r0SrVGMrsqeTPrblmM9TkcrdNSu27GKf6FQd9IO+C3lyaAxmjMe
 EENqdJDSzirO3aroXCEkwXlVeDzOtCxRU/YnnDq9BUqvHPfh90WKj6yM8qsXpYRR1+OOx+Z/NXh
 4yn9nQ0o5VqWwe1gaR4AuX9gcFwsFBLpC5CZp96CTzb8MY//S0idP6Utq4N2duKUmfp7kNW3eIX
 NQGyuOhG0JWiZrGYBH5ORzhuI6nLMNioE+pCx9+QUIbhUOePzZB7TaLb7P77ee09qeX+8KRCt1p
 txH33hmqOz5AlVVpBMdtZttdWFCVDENeDp9pDt8mDrKSZ5CRMIrRxXpyAeZCBhTpF7eLQQArLE6
 Y=
X-Received: by 2002:a05:6a00:3494:b0:83e:e897:a394 with SMTP id
 d2e1a72fcca58-842b0c0c621mr25008156b3a.7.1781093978140; 
 Wed, 10 Jun 2026 05:19:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:3494:b0:83e:e897:a394 with SMTP id
 d2e1a72fcca58-842b0c0c621mr25008128b3a.7.1781093977663; 
 Wed, 10 Jun 2026 05:19:37 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282221086sm24890377b3a.10.2026.06.10.05.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 05:19:37 -0700 (PDT)
Message-ID: <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
Date: Wed, 10 Jun 2026 22:19:31 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260610080947-mutt-send-email-mst@kernel.org>
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

Hi Michael,

On 6/10/26 10:12 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
>> On 6/10/26 7:54 PM, Pavel Hrdina wrote:

[...]

>>>
>>> You did not answer the question that Daniel was asking, how will user
>>> know that max-bounce-buffer-size should be used if it's necessary to fix
>>> guest system hangs and how will user know what magic value should be set?
>>>
>>
>> Sorry that I missed to answer Daniel's questions. For this specific case,
>> user need to enlarge the bounce buffer size when seeing the following error
>> message. We can add an explicit one in address_space_map() if the existing
>> error message isn't obvious.
>>
>>    qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>
>>    void *address_space_map(AddressSpace *as,
>>                          hwaddr addr,
>>                          hwaddr *plen,
>>                          bool is_write,
>>                          MemTxAttrs attrs)
>>    {
>>        if (!memory_access_is_direct(mr, is_write, attrs)) {
>>            if (l == 0) {
>>                error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
>>                *plen = 0;
>>                return NULL;
>>            }
>>        }
>>
>> As to the value user should take for max-bounce-buffer-size, it is really case by case
>> and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
>> smallest value works for them. The worst case is to set 0xFFFFFFFF.
>>
> 
> 
> This is not at all reasonable. All kind of fixes are possible but
> fundamentally, bounce buffering data path is by itself already a
> bad idea.
> 
> I have no idea what does bounce buffering device ram accomplish.
> 
> In the end, qemu still simply reads the memory from/to the buffer.
> 
> My suggestion is to first of all look for ways to mark the
> memory as direct.
> 

As I explained to Peter Xu in another reply, we can't simply mark the (RAM
DEVICE) memory region is directly accessible. The memory region is initialized
by memory_region_init_ram_device_ptr() in hw/vfio/region.c::vfio_region_mmap().

The  accesses to the memory region is handled by 'ram_device_mem_ops' where
{ldn, stn}_he_p() are used in its read/write handler. They're different
from memcpy() since the data endianness is well handled in {ldn, stn}_he_p().

Thanks,
Gavin



