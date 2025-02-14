Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE09C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyHh-0001EN-3f; Fri, 14 Feb 2025 11:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiyHe-0001DP-A8
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiyHb-0007sF-K5
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739549473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PNbLBcxiNOXGXWHnqrfWC7MuNetKDBLr4nXAjzPyXpY=;
 b=DDah5b6bp7OYBOlGj2SIpTUds0JmQbA9uKcbXyQm/V2yZaAZJiBpqT8mR8gXa+u9UdWgAE
 u+2hslfBlF78YyO6/beX+FCGOz5i/zQiFhfysq2Bs66kWsWEqMN722qyb0AGBrGh9FUebW
 dkntvDX0eF1i7BLEPVyzS/MwJkHGRW4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-GCzR2r10N3ykHTsNWhQfkA-1; Fri, 14 Feb 2025 11:11:12 -0500
X-MC-Unique: GCzR2r10N3ykHTsNWhQfkA-1
X-Mimecast-MFC-AGG-ID: GCzR2r10N3ykHTsNWhQfkA_1739549471
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so20032275e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739549471; x=1740154271;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNbLBcxiNOXGXWHnqrfWC7MuNetKDBLr4nXAjzPyXpY=;
 b=Zcj3QMRp7CfQPgoiF7+AUXGRFw1SQzHTtRvmttpWJmjaRrT4gXLZYNBSPQ9iaFc+ac
 fNhpNdh43iuEBaxdO/pcUjLhPAmpwTv8i0267ohF2vX+0rjKmAVR7O+SkORmTEPTSB2g
 5pxvzdTcKKXzSqhDdiyRE78xWPD9iVVpCmUSqhWoPefDxzhZdD5UJ7dJXHCKZX64qdfO
 qmbqqrrsUG7ePLzCuYysrUOrKJyl00m1MeZl9r0zmnfru5/M87RqJjLxCex+5XdyDNwn
 G68XOa4WThaPYbnxm2sA0WsKc7fb49fAyBPOzYvVT2hWp/IBJp7Dw7JM8gEnjIdomZZs
 ajBw==
X-Gm-Message-State: AOJu0YyH5JQkPlW7Z4qPhQcKbqVv8On3NIK3zfo2ECeREP/efBzJ8ZCD
 Ztweu8W3On5BSF21aKpwBGc0+kHsvZguoGNoER7QrbWXR2DzvZifwI4W87WrcqVb+xBlNzxN2n7
 I0E4ypIXAsl+cd+gedwBDk3l3y/j9DgV9ZHJrJZnRT8dii+ZCVrcg
X-Gm-Gg: ASbGnctchbdXk9uUTNk9T7U9PwYY/VVtUfs/53quPvzzWIaek3nFuLVl+OJlnC1mcLa
 PjiIc+9DGePXsOpksPbD/W3BlTtibeEFkrGV953/s89SzwbX+Ic0qtsYzHHp2vEmZGbgG2K7fws
 0B1tFW34vb9TUXY51/e3nJ4GQL4GMBU7bn8kz+eADcbHmEOnwrfsp9lx8DimxmfjLY3HKxGnOuo
 yU0uLC0TQK2dSwFCS4rr+qs6BoDEgGJs6z/7YagZrbwf+TTAhIKfc/tSJkCVcQu4CnXd1LdP2rr
 4AETlkwGVHcr9qC57/m7fuuD/WdFP+FuLIJBqmvzrqM=
X-Received: by 2002:a05:600c:5597:b0:439:59cf:8e16 with SMTP id
 5b1f17b1804b1-43959cf9023mr129717825e9.23.1739549470595; 
 Fri, 14 Feb 2025 08:11:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEuCWN20v94I7BOyVDCFeOpy3IVGYHXFVI7hgS4bWXcSlpSfnz0Rskf8SzXu4LuL6gZrOCRQ==
X-Received: by 2002:a05:600c:5597:b0:439:59cf:8e16 with SMTP id
 5b1f17b1804b1-43959cf9023mr129717255e9.23.1739549470066; 
 Fri, 14 Feb 2025 08:11:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7b68sm4902056f8f.85.2025.02.14.08.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 08:11:09 -0800 (PST)
Message-ID: <266c602b-063a-4682-b1ad-bdfe6b3ac264@redhat.com>
Date: Fri, 14 Feb 2025 17:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio: Add property documentation
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tomitamoeko@gmail.com, corvin.koehne@gmail.com,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250214143415.1686526-1-clg@redhat.com>
 <20250214084445.339f3476.alex.williamson@redhat.com>
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
In-Reply-To: <20250214084445.339f3476.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/14/25 16:44, Alex Williamson wrote:
> On Fri, 14 Feb 2025 15:34:15 +0100
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Investigate the git history to uncover when and why the VFIO
>> properties were introduced and update the models. This is mostly
>> targeting vfio-pci device, since vfio-platform, vfio-ap and vfio-ccw
>> devices are simpler.
>>
>> Sort the properties based on the QEMU version in which they were
>> introduced.
>>
>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Should we introduce documentation for properties like the kernel has
>>   in Documentation/ABI/*/sysfs-* ?
>>
>>   Changes in v3:
>>
>>   - Re-organized the vfio-pci properties based on the QEMU version in
>>     which they were introduced
>>   - Added property labels
>>   - Improved description as suggested by Alex, Tomita and Corvin
>>
>>   Changes in v2:
>>
>>   - Fixed version numbers
>>   - Fixed #ifdef in vfio/ccw.c
>>   - Addressed vfio-pci-nohotplug
>>   - Organize the vfio-pci properties in topics
>>   
>>   hw/vfio/ap.c       |   9 ++++
>>   hw/vfio/ccw.c      |  15 ++++++
>>   hw/vfio/pci.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/platform.c |  25 ++++++++++
>>   4 files changed, 171 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -257,6 +257,15 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>>       dc->hotpluggable = true;
>>       device_class_set_legacy_reset(dc, vfio_ap_reset);
>>       dc->bus_type = TYPE_AP_BUS;
>> +
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>>   }
>>   
>>   static const TypeInfo vfio_ap_info = {
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 67bc137f9be6d43c5970c6271f3cdbfffd8a32de..ea766ae26c744c05515e1cc80a486a3462d82834 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -717,6 +717,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
>>       cdc->handle_halt = vfio_ccw_handle_halt;
>>       cdc->handle_clear = vfio_ccw_handle_clear;
>>       cdc->handle_store = vfio_ccw_handle_store;
>> +
>> +    object_class_property_set_description(klass, /* 2.10 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "force-orb-pfch",
>> +                                          "Force unlimited prefetch");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>> +    object_class_property_set_description(klass, /* 9.2 */
>> +                                          "loadparm",
>> +                                          "Define which devices that can be used for booting");
>>   }
>>   
>>   static const TypeInfo vfio_ccw_info = {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9a55e7b77324babf7295132b08e3ba23b482a291..cdf4cdcf88c143ff145427cae3fd64239a2d1e74 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3433,6 +3433,119 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>       pdc->exit = vfio_exitfn;
>>       pdc->config_read = vfio_pci_read_config;
>>       pdc->config_write = vfio_pci_write_config;
>> +
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "host",
>> +                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "x-intx-mmap-timeout-ms",
>> +                                          "When EOI is not provided by KVM/QEMU, wait time "
>> +                                          "(milliseconds) to re-enable device direct access "
>> +                                          "after INTx (DEBUG)");
>> +    object_class_property_set_description(klass, /* 1.5 */
>> +                                          "x-vga",
>> +                                          "Expose VGA address spaces for device");
>> +    object_class_property_set_description(klass, /* 2.3 */
>> +                                          "x-req",
>> +                                          "Disable device request notification support (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO "
>> +                                          "accesses (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-intx",
>> +                                          "Disable direct VFIO->KVM INTx injection. Allows to "
>> +                                          "trace INTx interrupts (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msi",
>> +                                          "Disable direct VFIO->KVM MSI injection. Allows to "
>> +                                          "trace MSI interrupts (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msix",
>> +                                          "Disable direct VFIO->KVM MSIx injection. Allows to "
>> +                                          "trace MSIx interrupts (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-vendor-id",
>> +                                          "Override PCI Vendor ID with provided value (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-device-id",
>> +                                          "Override PCI device ID with provided value (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-vendor-id",
>> +                                          "Override PCI Sub Vendor ID with provided value (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-device-id",
>> +                                          "Override PCI Sub Device ID with provided value (DEBUG)");
> 
> Nit, we don't seem to have a character limit, so I'd go ahead and
> s/Sub/Subsystem/.

done.

> 
> 
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    object_class_property_set_description(klass, /* 2.7 */
>> +                                          "x-igd-opregion",
>> +                                          "Expose host IGD OpRegion to guest");
>> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
>> +                                          "x-igd-gms",
>> +                                          "Override IGD data stolen memory size (32MiB units). "
>> +                                          "Assign 00:02.0 from the host to 00:02.0 in the VM");
> 
> Maybe it's a good general hint to assign IGD identity mapped to the
> same PCI address in the guest as on the host, but it doesn't seem
> particularly relevant to this specific option.

ok. Removed.

>> +    object_class_property_set_description(klass, /* 2.11 */
>> +                                          "x-nv-gpudirect-clique",
>> +                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
>> +                                          "clique for device [0-15]");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-no-geforce-quirks",
>> +                                          "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). "
>> +                                          "Improves performance");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "display",
>> +                                          "Enable display support for device, ex. vGPU");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-msix-relocation",
>> +                                          "Specify MSI-X MMIO relocation to the end of specified "
>> +                                          "existing BAR or new BAR to avoid virtualization overhead "
>> +                                          "due to adjacent device registers (sPAPR)");
> 
> I'd drop sPAPR reference, there are other reasons it can be useful.

done

> 
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-kvm-ioeventfd",
>> +                                          "Disable registration of ioeventfds with KVM (DEBUG)");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-vfio-ioeventfd",
>> +                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds"
>> +                                          " (NVIDIA, DEBUG)");
> 
> Likewise dropping NVIDIA here.  Only currently used by an NVIDIA quirk,
> but that could change.

ok

>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "x-balloon-allowed",
>> +                                          "Override allowing ballooning with device (DEBUG, DANGER)");
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "xres",
>> +                                          "Set X display resolution the vGPU should use");
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "yres",
>> +                                          "Set Y display resolution the vGPU should use");
>> +    object_class_property_set_description(klass, /* 5.2 */
>> +                                          "x-pre-copy-dirty-page-tracking",
>> +                                          "Disable dirty pages tracking during iterative phase");
>> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
>> +                                          "enable-migration",
>> +                                          "Enale device migration. Also requires a host VFIO PCI "
>> +                                          "variant driver with migration support enabled");
> 
> Variant or mdev.

done

>> +    object_class_property_set_description(klass, /* 8.1 */
>> +                                          "vf-token",
>> +                                          "Specify UUID VF token. Required for VF when PF is owned "
>> +                                          "by another VFIO driver");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "x-device-dirty-page-tracking",
>> +                                          "Disable device dirty page tracking and use "
>> +                                          "container-based dirty page tracking");
> 
> This sounds like debug to me.

Probably. I am waiting for Joao and Kirti's feedback.

> 
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "migration-events",
>> +                                          "Emit VFIO migration QAPI event when a VFIO device "
>> +                                          "changes its migration state. For management applications");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "skip-vsc-check",
>> +                                          "Skip config space check for Vendor Specific Capability "
>> +                                          "(NVIDIA, DEBUG)");
> 
> Required for a specific migration use case with NVIDIA, but the option
> is generic.  Given the polarity is by default true for the current
> machine type, we might also indicate this provides an option for strict
> VSC content enforcement.

done.

> 
>>   }
>>   
>>   static const TypeInfo vfio_pci_dev_info = {
>> @@ -3461,6 +3574,15 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>>   
>>       device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>>       dc->hotpluggable = false;
>> +
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "ramfb",
>> +                                          "Enable ramfb to provide pre-boot graphics for devices "
>> +                                          "enabling display option");
>> +    object_class_property_set_description(klass, /* 8.2 */
>> +                                          "x-ramfb-migrate",
>> +                                          "Override default migration support for ramfb support "
>> +                                          "(DEBUG)");
>>   }
>>   
>>   static const TypeInfo vfio_pci_nohotplug_dev_info = {
>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>> index 1070a2113a17edb9ebafb5066e51ee2bc52a767d..61b8b856fac26e26a4805dc2d5e65266b907ef58 100644
>> --- a/hw/vfio/platform.c
>> +++ b/hw/vfio/platform.c
>> @@ -674,6 +674,31 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       /* Supported by TYPE_VIRT_MACHINE */
>>       dc->user_creatable = true;
>> +
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "host",
>> +                                          "Host device name of assigned device");
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO "
>> +                                          "accesses (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "mmap-timeout-ms",
>> +                                          "When EOI is not provided by KVM/QEMU, wait time "
>> +                                          "(milliseconds) to re-enable device direct access "
>> +                                          "after INTx (DEBUG)");
> 
> INTx is a PCI-ism, maybe we should just call it level interrupts.

changed.


Thanks,

C.



> 
> Thanks!
> Alex
> 
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "x-irqfd",
>> +                                          "Allow disabling irqfd support (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>> +
>>   }
>>   
>>   static const TypeInfo vfio_platform_dev_info = {
> 


