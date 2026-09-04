Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AE0C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TC0-0004RA-9f; Fri, 04 Sep 2026 08:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2TBr-0004PV-Of
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2TBg-0003d0-Pi
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788525503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dQfbiO9toUGkrB+WltFq9keW0tc7gQSKaOnRrvcb8ac=;
 b=PJKwqwIl1v6t9ut8vC0K0vVfwh7OR2W5gXF6fVKOuDBLq/wMB4iVS8//nWvJYPVCllgdHp
 +VruhtYc5WSu2jRIf11/qHVGWau9qPA+A0iRgt+6ArD52/7TkcAD0jMouiaX+osK2Br+0j
 LC2nf3bsBSYeqBIu8IHtAyzQ00Wocyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-8S4JPzH8MamQR_9VK8No-g-1; Fri, 04 Sep 2026 08:38:07 -0400
X-MC-Unique: 8S4JPzH8MamQR_9VK8No-g-1
X-Mimecast-MFC-AGG-ID: 8S4JPzH8MamQR_9VK8No-g_1788525486
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so11844195e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788525485; x=1789130285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dQfbiO9toUGkrB+WltFq9keW0tc7gQSKaOnRrvcb8ac=;
 b=UpLPacd47rcdgCHJF1WEe8lsNA52+woyXDXFtrLGZw9UxORPSdUZidl1ie4xGjG6qa
 VEv7nkqJ1LLw3BW/4sPwJTR4jZcZivPfBDP3QFB3/wWCN7L2Ndrnoi1kMccCyQAyKoU8
 L99T3Y/A9kqebFfjaLqqx856n1b7wcXMziNt38Bhy1iaLsSBc6sn7Dxh3NHBTPWcE6w4
 6taDs7oW6JijB6LwlaPrW/7w+TTg7YiItfddXbb4TdhkCffLOxshbAB5ePICcq6w/w7e
 FbWKW/1puT27oblpM/uw4Mkz5iIaD/NCLcwBWB2SdLCEZeGBPey+EjblrTJ4hg7Ur9dP
 0jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525485; x=1789130285;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dQfbiO9toUGkrB+WltFq9keW0tc7gQSKaOnRrvcb8ac=;
 b=drut74EQBj/XOaOzpvLqlDNASeSX0AbTh/GyHNmAtcoHJMMI10mneqcR28CYT+YJ92
 oUHyYAbXCI0Bi1FuDfBMglMi5qi1lULfJdNjS+Gi1UxZ8TQENBoXQHHvpHymZ/eyA/O/
 l/RR+wHJDbg3cQN4991hQ0MNtcyKKcITj6WbJ+UL0DkbW/jIkh3oO/SIL3Z6f1uMC3uH
 GFr1J7H1Hrga/K8wLl1rq57pwrDejqU8r2F6roaA9jYCvJoAKtUoWOIhtPgdpNPbCfUY
 wFnzxNOzk1uSaoVKaVEPT5frn2fSsoiIzp2q6zoOGITnfvN96vRuzmIK2rPorCcxrc+N
 3kcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqbxi6CHY26ptAwRsFJ10sZcr9luznmEuq8CqWA63RdcWifBXyz1jJEOSXL+Q/jMYLsidE/Fk/FiSG@nongnu.org
X-Gm-Message-State: AFuF++kQ6g+MrW+ZHD86YWRtL8VgqSVNxGEfcrFo4U8QNW/Ow+zQ7shf
 mhcMQGu4KVE00hI8BEcopdNPqLKTon6VkrEoQ5wwWVI7kSBQ8UTVcQZiSpXlOm9MZhIKPnd8jxC
 Y5tYVb0lIoYbOwltl2BrSPSt8eMEZhBTl93W0Lyga0C1wKD+BJeC3TpkV
X-Gm-Gg: AYBFou0m60z6WFXVwNXAucHwNpB/MlYHZHOOtpKosnyL3mFn0jTpO1GaY5w0vvOhr3M
 0wzwqnUXsl9TVLusXGrGINnNbQ4hXAK+AieTRBlzjR3c2Hmki92+wkFvWmr7NKDJjVSWxbxJPWh
 XIqREobLKGYJajXnXsCsMPyoNuDPlLuhbAFsEwiz870oVmdDrGdUzotBqTROVc/wtnAV+9W4pVm
 MlYZuQKJW6kvwArfC2yf99YcsAng27F3WjLPaQJGZWdNyw83SAR6ezNkdeWmOH5O+CWf1OlNznJ
 0+elz782ZxlHtZy9WfUjTy4Xxr4GjcuXfo9wafGOtU7r18gizbkbRanyWA2z4RHcna4YckdTEyl
 AnUrNRDxnJzPL2FIo/T0h0hKALGXChZzeLf03RiA=
X-Received: by 2002:a05:600c:6088:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49cfc6cc100mr28414435e9.27.1788525485518; 
 Fri, 04 Sep 2026 05:38:05 -0700 (PDT)
X-Received: by 2002:a05:600c:6088:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49cfc6cc100mr28413765e9.27.1788525485037; 
 Fri, 04 Sep 2026 05:38:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:bf4:da16:e208:c6bd?
 ([2a01:e0a:1292:d530:bf4:da16:e208:c6bd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771de2fsm69282125e9.8.2026.09.04.05.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 05:38:04 -0700 (PDT)
Message-ID: <135d159a-2117-4595-ac6c-4d0ff4c843a9@redhat.com>
Date: Fri, 4 Sep 2026 14:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] vfio-user: support multiple FDs backing region
 mmaps
To: Naman Gulati <namangulati@google.com>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20260826050039.2068138-1-namangulati@google.com>
 <CAMP57yUuJUrpPtvf6Nf5SoDZ7Z+dfXFmHB-0AJ+vhzysjvgxYQ@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
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
In-Reply-To: <CAMP57yUuJUrpPtvf6Nf5SoDZ7Z+dfXFmHB-0AJ+vhzysjvgxYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Naman,

Thanks for the series. However, the multiple FDs are a vfio-user
transport detail. The core VFIO only needs to know "which fd to
mmap for this subregion" and it doesn't need to manage arrays of
FDs per region. So, I'd prefer :

  1. No change.
  
  2. Add 'fd' and 'fd_offset' to VFIOMmap :
  
      typedef struct VFIOMmap {
      ...
     +    int fd;             /* per-mmap fd, or -1 to use the region fd */
     +    uint64_t fd_offset; /* offset within fd for the mmap call */
      } VFIOMmap;

     This is the only core VFIO change.

  3. Add a 'setup_sparse_mmaps' hook to VFIODeviceIOOps
  
  4. vfio-user: support multiple FDs for sparse mmap regions
     All multi-fd logic stays in hw/vfio-user/device.c

Thanks,

C.


On 9/3/26 19:46, Naman Gulati wrote:
> Gentle ping on this series incase it got lost in the noise :)
> 
> On Tue, Aug 25, 2026 at 10:00 PM Naman Gulati <namangulati@google.com> wrote:
>>
>> This series extends the vfio-user protocol specification to allow
>> servers to pass multiple file descriptors for different sparse memory
>> areas to be mmap'ed within a single device region.
>>
>> This extension is intended for exposing paravirtualized PCI devices via
>> a vfio-user server that may have multiple unique sub-regions in a BAR
>> backed by some mmap'able buffers sourced from distinct file descriptors.
>>
>> This change introduces a new capability:
>>    VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
>>
>> Unlike VFIO_REGION_INFO_CAP_SPARSE_MMAP (which maps all sparse areas
>> from a single open file descriptor), this new capability defines an
>> array of sparse mmap areas where each area contains an index into the
>> array of file descriptors.
>>
>> When all sparse areas share a single file descriptor, servers may
>> continue to emit VFIO_REGION_INFO_CAP_SPARSE_MMAP and send exactly one
>> file descriptor in SCM_RIGHTS for backwards compatibility with older
>> clients.
>>
>> The extensions in this series also lays the groundwork to make use of
>> the in-development series [1] extending vfio-pci to return distinct
>> dmabuf FDs for discrete regions of a device's BAR. A vfio-user server
>> may choose to return dmabuf FDs for various regions of a device's BAR to
>> map a vfio passthrough device into the guest, in order to retain control
>> of the device and be able to revoke mappings passed to the VM.
>>
>> libvfio-user server side changes WIP on github [2].
>>
>>
>> [1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org
>> [2] https://github.com/NamanGulati/libvfio-user/tree/multi-region-fd
>>
>> ---
>> Changes from RFC:
>>    - Refactored the get_region_info callback to keep vbasedev constant
>>      and take in a VFIORegionFDs* out parameter to store the received fds.
>>    - Link to RFC: https://lore.kernel.org/qemu-devel/20260811233930.401797-1-namangulati@google.com
>> ---
>>
>> Naman Gulati (3):
>>    vfio-user: add multi-fd region mmap capability
>>    vfio: mmap sparse regions backed by multiple FDs
>>    vfio-user: implement client support for multi-fd region mmap
>>
>>   docs/interop/vfio-user.rst    | 71 +++++++++++++++++++++++++++++++++--
>>   hw/vfio-user/device.c         | 66 ++++++++++++++++++++++++++++++--
>>   hw/vfio-user/protocol.h       | 20 ++++++++++
>>   hw/vfio/device.c              | 49 ++++++++++++++----------
>>   hw/vfio/region.c              | 41 ++++++++++++++++----
>>   hw/vfio/vfio-region.h         |  8 ++++
>>   include/hw/vfio/vfio-device.h | 32 ++++++++++++++--
>>   7 files changed, 249 insertions(+), 38 deletions(-)
>>
>> --
>> 2.55.0.860.g4b6b3295ed-goog
>>
> 


