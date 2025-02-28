Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4C7C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxGw-0004tx-0d; Fri, 28 Feb 2025 05:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnxGr-0004nM-Qt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnxGp-0000WX-E3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740737221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZoWcQKbDGmjHDQW93sPDuPbIhjy5Je92nHQX64U0HJU=;
 b=hUQDjQxqazq8U2gaPom+K3ZzmXK3yUrze1XWhprHCWP3Y7pJUX9FfDqyf7HFH5j657F4g0
 htRMg80pcMtH0rkzCB3t+Ud14ekhRCUdzXjobewcV7qbWJThrotSTwlAlYHv28JzPR/9wE
 eRHctS34uqPHEm+WZOgtl/L/Rq0DEMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-2TY5qLe1OXSkXr_otxbpOg-1; Fri, 28 Feb 2025 05:05:37 -0500
X-MC-Unique: 2TY5qLe1OXSkXr_otxbpOg-1
X-Mimecast-MFC-AGG-ID: 2TY5qLe1OXSkXr_otxbpOg_1740737136
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390de58dc4eso2068088f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740737136; x=1741341936;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoWcQKbDGmjHDQW93sPDuPbIhjy5Je92nHQX64U0HJU=;
 b=mZ7I6wMTaPtgTYDkxPPbKYLmjaHSydwRAKYXfe1Rv/MhQeiWvcLhvX8ul2cjk2Xw5H
 PgWcDkdN9RHiYwYtCZHdUR8olBBPieKT8gna1Qn9sw2iKJyJdVn3XTpCtmOFxpwi73f5
 Tcqm5qytGigmBfcxIs/ExCdBWwEaHXI9gHZwZ1Z30O/z6tYS9OXflyOFUoh27TeKynup
 rwbh3YyuMW/KfP04ju/3+R2lRE8lcjt8AIGfOzMYHMvwT12tStQONRuYrL0wSVlJkeVG
 gFGD9byDTZMMyh+SM943mTyt2213ZiZJWgXKGt3f8NcimE+rwU/Z1i2KUyZO5OZoiqk1
 ZbjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHIMBqUl7N35qe4UmAUWnw56NIK389jgFM2YNIQo9IgaoJHHOPetLo+U8tf6hbVQbat6XSOmvy5aOi@nongnu.org
X-Gm-Message-State: AOJu0Yyy4fUsPsqMkNxTSSA+RoWTDPPcmFHi99DM6TdTsSllUFdyfGRV
 6o0jl3ihyRZeuJd2dwSTcTcMyFZdPsL4e/ZW5aTZxj+XxRr7b+y+brF5PBDIzQ7Nc+1WealQdQv
 Dkrk5QQk9rQdqGr4YfnJanF6enPE2yCKC2evd8o79KyVBJ0dmXhd+
X-Gm-Gg: ASbGnctWyxfEzRjPyHFNmmI8il5aB2LqVdvpWl/bXH+wdVk8rmTe6WyjBTSSkK6TT/X
 VVTZ2jElk/FG7kz8TsZLkmZzEchzHeXqWigy0kncIInDyrBv87i+7X6yHp0GJj2Z3ezd7S0UuIN
 B362bS8hdKghDm56ih4KAwiJHU85t7uh3BucJnCVG/wcG2YTEg1KctezJduJO7gDAPoOK4gVOuE
 equ5aqRhXOoVoXBLo9XqCNAR0PE9ZtN4DlyHa4NiIBil4Jbx7Pc6SylYqYVasVaEB9oqmNbwvA4
 Spjiv4Ps5T/Sz/3KvmZEDWciuZkPNBSpFAXYAXLnlC9NuHHfc9tm+gtSI+4=
X-Received: by 2002:a05:6000:1ac6:b0:38d:cab2:921a with SMTP id
 ffacd0b85a97d-390ec7c8e9amr2704345f8f.1.1740737136059; 
 Fri, 28 Feb 2025 02:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB3S99ripu6lT9vNUeuan0oHntim6Nt3SooBnMKzPonrvuWIQEhxoa2ZLg0QBVa+xV/Et90g==
X-Received: by 2002:a05:6000:1ac6:b0:38d:cab2:921a with SMTP id
 ffacd0b85a97d-390ec7c8e9amr2704302f8f.1.1740737135586; 
 Fri, 28 Feb 2025 02:05:35 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a7473sm4794377f8f.38.2025.02.28.02.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 02:05:35 -0800 (PST)
Message-ID: <a7f66c0f-1355-43e6-b20d-eddaef6fb1d1@redhat.com>
Date: Fri, 28 Feb 2025 11:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 36/36] vfio/migration: Update VFIO migration
 documentation
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <2031790b755aa95b61470b286fa787b78be08107.1739994627.git.maciej.szmigiero@oracle.com>
 <cbebee68-f891-4946-885d-01a8ed24e6c1@redhat.com>
 <7c41add3-72ad-4aec-bd74-3c9715fda5c7@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7c41add3-72ad-4aec-bd74-3c9715fda5c7@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/27/25 23:01, Maciej S. Szmigiero wrote:
> On 27.02.2025 07:59, Cédric Le Goater wrote:
>> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Update the VFIO documentation at docs/devel/migration describing the
>>> changes brought by the multifd device state transfer.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   docs/devel/migration/vfio.rst | 80 +++++++++++++++++++++++++++++++----
>>>   1 file changed, 71 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
>>> index c49482eab66d..d9b169d29921 100644
>>> --- a/docs/devel/migration/vfio.rst
>>> +++ b/docs/devel/migration/vfio.rst
>>> @@ -16,6 +16,37 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
>>>   support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>>>   VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>
>> Please add a new "multifd" documentation subsection at the end of the file
>> with this part :
>>
>>> +Starting from QEMU version 10.0 there's a possibility to transfer VFIO device
>>> +_STOP_COPY state via multifd channels. This helps reduce downtime - especially
>>> +with multiple VFIO devices or with devices having a large migration state.
>>> +As an additional benefit, setting the VFIO device to _STOP_COPY state and
>>> +saving its config space is also parallelized (run in a separate thread) in
>>> +such migration mode.
>>> +
>>> +The multifd VFIO device state transfer is controlled by
>>> +"x-migration-multifd-transfer" VFIO device property. This property defaults to
>>> +AUTO, which means that VFIO device state transfer via multifd channels is
>>> +attempted in configurations that otherwise support it.
>>> +
> 
> Done - I also moved the parts about x-migration-max-queued-buffers
> and x-migration-load-config-after-iter description there since
> obviously they wouldn't make sense being left alone in the top section.
> 
>> I was expecting a much more detailed explanation on the design too  :
>>
>>   * in the cover letter
>>   * in the hw/vfio/migration-multifd.c
>>   * in some new file under docs/devel/migration/

I forgot to add  :

      * guide on how to use this new feature from QEMU and libvirt.
        something we can refer to for tests. That's a must have.
      * usage scenarios
        There are some benefits but it is not obvious a user would
        like to use multiple VFs in one VM, please explain.
        This is a major addition which needs justification anyhow
      * pros and cons

> I'm not sure what descriptions you exactly want in these places, 

Looking from the VFIO subsystem, the way this series works is very opaque.
There are a couple of a new migration handlers, new threads, new channels,
etc. It has been discussed several times with migration folks, please provide
a summary for a new reader as ignorant as everyone would be when looking at
a new file.


> but since
> that's just documentation (not code) it could be added after the code freeze...

That's the risk of not getting any ! and the initial proposal should be
discussed before code freeze.

For the general framework, I was expecting an extension of a "multifd"
subsection under :

   https://qemu.readthedocs.io/en/v9.2.0/devel/migration/features.html

but it doesn't exist :/

So, for now, let's use the new "multifd" subsection of

   https://qemu.readthedocs.io/en/v9.2.0/devel/migration/vfio.html

> 
>>
>> This section :
>>
>>> +Since the target QEMU needs to load device state buffers in-order it needs to
>>> +queue incoming buffers until they can be loaded into the device.
>>> +This means that a malicious QEMU source could theoretically cause the target
>>> +QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
>>> +
>>> +The "x-migration-max-queued-buffers" property allows capping the maximum count
>>> +of these VFIO device state buffers queued at the destination.
>>> +
>>> +Because a malicious QEMU source causing OOM on the target is not expected to be
>>> +a realistic threat in most of VFIO live migration use cases and the right value
>>> +depends on the particular setup by default this queued buffers limit is
>>> +disabled by setting it to UINT64_MAX.
>>
>> should be in patch 34. It is not obvious it will be merged.
>>
> 
> ...which brings us to this point.
> 
> I think by this point in time (less then 2 weeks to code freeze) we should
> finally decide what is going to be included in the patch set.
> > This way this patch set could be well tested in its final form rather than
> having significant parts taken out of it at the eleventh hour.
> 
> If the final form is known also the documentation can be adjusted accordingly
> and user/admin documentation eventually written once the code is considered
> okay.
> 
> I though we discussed a few times the rationale behind both
> x-migration-max-queued-buffers and x-migration-load-config-after-iter properties
> but if you still have some concerns there please let me know before I prepare
> the next version of this patch set so I know whether to include these.

Patch 34, not sure yet.

Patch 35 is for next cycle IMO.

For QEMU 10.0, let's focus on x86 first and see how it goes. We can add
ARM support in QEMU 10.1 if nothing new arises. We will need the virt-arm
folks in cc: then.

Please keep patch 35 in v6 nevertheless, it is good for reference if
someone wants to apply on an out of tree QEMU.


Thanks,

C.


> 
>> This section :
>>
>>> +Some host platforms (like ARM64) require that VFIO device config is loaded only
>>> +after all iterables were loaded.
>>> +Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
>>> +device property, which in its default setting (AUTO) does so only on platforms
>>> +that actually require it.
>>
>> Should be in 35. Same reason.
>>
>>
>>>   When pre-copy is supported, it's possible to further reduce downtime by
>>>   enabling "switchover-ack" migration capability.
>>>   VFIO migration uAPI defines "initial bytes" as part of its pre-copy data stream
>>> @@ -67,14 +98,39 @@ VFIO implements the device hooks for the iterative approach as follows:
>>>   * A ``switchover_ack_needed`` function that checks if the VFIO device uses
>>>     "switchover-ack" migration capability when this capability is enabled.
>>> -* A ``save_state`` function to save the device config space if it is present.
>>> -
>>> -* A ``save_live_complete_precopy`` function that sets the VFIO device in
>>> -  _STOP_COPY state and iteratively copies the data for the VFIO device until
>>> -  the vendor driver indicates that no data remains.
>>> -
>>> -* A ``load_state`` function that loads the config section and the data
>>> -  sections that are generated by the save functions above.
>>> +* A ``switchover_start`` function that in the multifd mode starts a thread that
>>> +  reassembles the multifd received data and loads it in-order into the device.
>>> +  In the non-multifd mode this function is a NOP.
>>> +
>>> +* A ``save_state`` function to save the device config space if it is present
>>> +  in the non-multifd mode.
>>> +  In the multifd mode it just emits either a dummy EOS marker or
>>> +  "all iterables were loaded" flag for configurations that need to defer
>>> +  loading device config space after them.
>>> +
>>> +* A ``save_live_complete_precopy`` function that in the non-multifd mode sets
>>> +  the VFIO device in _STOP_COPY state and iteratively copies the data for the
>>> +  VFIO device until the vendor driver indicates that no data remains.
>>> +  In the multifd mode it just emits a dummy EOS marker.
>>> +
>>> +* A ``save_live_complete_precopy_thread`` function that in the multifd mode
>>> +  provides thread handler performing multifd device state transfer.
>>> +  It sets the VFIO device to _STOP_COPY state, iteratively reads the data
>>> +  from the VFIO device and queues it for multifd transmission until the vendor
>>> +  driver indicates that no data remains.
>>> +  After that, it saves the device config space and queues it for multifd
>>> +  transfer too.
>>> +  In the non-multifd mode this thread is a NOP.
>>> +
>>> +* A ``load_state`` function that loads the data sections that are generated
>>> +  by the main migration channel save functions above.
>>> +  In the non-multifd mode it also loads the config section, while in the
>>> +  multifd mode it handles the optional "all iterables were loaded" flag if
>>> +  it is in use.
>>> +
>>> +* A ``load_state_buffer`` function that loads the device state and the device
>>> +  config that arrived via multifd channels.
>>> +  It's used only in the multifd mode.
>>
>> Please move the documentation of the new migration handlers in the
>> patch introducing them.
>>
>>
>> Thanks,
>>
>> C.
>>
> 
> Thanks,
> Maciej
> 


