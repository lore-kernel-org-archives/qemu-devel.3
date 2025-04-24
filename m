Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183D7C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 16:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yz0-0006Xe-5A; Thu, 24 Apr 2025 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yyv-0006XD-E5
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yyj-0005Oa-62
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745510346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PnVad0q7qa+IjLcEJ+JXAYyAIZeyBQ4jbDb4gWo3EgM=;
 b=ConXNhAKngKGyLxy7W4g3Ha4MfuAqUu8RZ7s0I+4iTQaVLn4HxeyAfgAPLSFpsQvCvT1bD
 QM4KhpSwQZwBwnegxWKHyOvLgWZGIig6yeKVHSnUy/LnY/ETrY8k5/QFriMgA2MCHx4Ks9
 DhU3a/jm4v9bgxGQ3Ij021QEecGfPyc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70--xy7pWQSMIaUkRH_7nhgcA-1; Thu, 24 Apr 2025 11:59:04 -0400
X-MC-Unique: -xy7pWQSMIaUkRH_7nhgcA-1
X-Mimecast-MFC-AGG-ID: -xy7pWQSMIaUkRH_7nhgcA_1745510343
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so6541555e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 08:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745510343; x=1746115143;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnVad0q7qa+IjLcEJ+JXAYyAIZeyBQ4jbDb4gWo3EgM=;
 b=hT72Mu09s0/RhBxh8uFgKQgbNbt09vVCEfWgatqjDqu+vlfcXS3NEiEDp7TjF/LUlM
 hv6jaEEZ+Ds2/KGtZ6jcScuXca7OK3KQIO0GDRCgpHmVsFTRNDhOcJMfew7mb68D9Emp
 SttVLEMGEG/ErkgOLv4qi/iKqDKgvHLAe5vpa5whbf+G+yN+p3Z4TTNLdHNzAqjx+z/I
 lkdiIjqSIcz0ax132wX29zA6bIEWHx0tawE1FvdQOru+qQnQCrsx+zaZg4/0bY56q+PP
 zE8skx1bACCRRLzkS422cUXW5quakEd6k9tAcaqS//o4LLWSuz0KTj9wZ9cmIjstGA3Q
 m0nQ==
X-Gm-Message-State: AOJu0YzZ6RYOR5EYI6Y7BmLXa5n73leixTV7b0esul/lBkDDJ5YrqvV0
 XDNu9HNxogrO7FkPaTGkh7R8wVu5apgNVNV/pQ1DqEUqdsnULXPuatcsHwCZm+SavXybRy4lQwL
 +3UMc24MgNQ1wSQVoX9eSm2ww2jyLo7r0yJgG6+L81gsGdqaaUTsq
X-Gm-Gg: ASbGncvp38DB//LYvD4z9QBbDEDHYusQt5U13oGJPzvYtXHnEGHReFDHgZmw7QKTPzs
 +Su8KYZE0hto8YY3HFDXZZ5Cnq+PmVyWKp6WL+98i2JNCWRaKi8BmGim0XqNCuzAqOml5mjXsmz
 IODuI3qPv/nLuflFuVKjwfxI+eJKq6XcLBdweIgYlI7UatDN6y/RP7Jo02eSPTUgM8BWw9WXio8
 zHpUWoF9o+KiQPVwV0JxqejQxbg2wNSWHzqyPY3Ar1NL0vwL4EnjoDNUvLLS3LMP0Vx0PMzAtDd
 WYi4oA7Otjj0Q7+wIUC+it1x/+Qg5u+wJBsfkmlTdIEHrw0=
X-Received: by 2002:a5d:59a2:0:b0:399:7f2d:5d23 with SMTP id
 ffacd0b85a97d-3a06cf563f9mr2888983f8f.14.1745510343547; 
 Thu, 24 Apr 2025 08:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzfC5mrBslA2bVz2XJzGkGhyRa8FcnX/RQ4gNGdGBfqSgzUAV6PIhsLwHK9Ff9BTjNARCTdA==
X-Received: by 2002:a5d:59a2:0:b0:399:7f2d:5d23 with SMTP id
 ffacd0b85a97d-3a06cf563f9mr2888973f8f.14.1745510343193; 
 Thu, 24 Apr 2025 08:59:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a812bsm2592256f8f.17.2025.04.24.08.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 08:59:02 -0700 (PDT)
Message-ID: <72895a6b-9ba2-4d6a-9296-accc0b486890@redhat.com>
Date: Thu, 24 Apr 2025 17:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] vfio: add vfio_pci_config_space_read/write()
To: Tomita Moeko <tomitamoeko@gmail.com>, John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-12-john.levon@nutanix.com>
 <ed4d5a1e-61dc-4041-a24d-c1a0bd49fa3e@gmail.com> <Z/aYPiAhqSaIrc/u@lent>
 <a76453a8-c35d-46f9-b0b4-4fe35a5153ba@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a76453a8-c35d-46f9-b0b4-4fe35a5153ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/25 18:30, Tomita Moeko wrote:
> On 4/9/25 23:54, John Levon wrote:
>> On Wed, Apr 09, 2025 at 11:51:09PM +0800, Tomita Moeko wrote:
>>
>>> On 4/9/25 21:48, John Levon wrote:
>>>> Add these helpers that access config space and return an -errno style
>>>> return.
>>>>
>>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>>> ---
>>>>   hw/vfio/pci.c | 134 ++++++++++++++++++++++++++++++++++----------------
>>>>   1 file changed, 91 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index ddeee33aa9..c3842d2f8d 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -964,6 +964,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>>>>       }
>>>>   }
>>>>   
>>>> +/* "Raw" read of underlying config space. */
>>>> +static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
>>>> +                                      uint32_t size, void *data)
>>>
>>> Returning ssize_t here might be better here to avoid casting issues,
>>> though we would never read/write something exceeds INT32_MAX.
>>
>> I considered this (and the later helpers in the patch), but most of the existing
>> code already uses int. Happy to look at fixing the callers too (e.g.
>> vfio_msi_setup()) if that's everyone's preference.
>>
>> regards
>> john
> 
> I checked the code, caller casts return of pread/pwrite to int because
> the `count` argument, bytes read/write at most, they passed does not
> exceed int. Given that uint32_t can exceed int, returning ssize_t here
> and let callers to determine cast or not is better I believe.
I have no strong preference. The less change the better I would say.

Thanks,

C.
  


