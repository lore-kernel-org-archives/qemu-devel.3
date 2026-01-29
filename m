Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA630D61021
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTYn-0001xL-Ll; Thu, 29 Jan 2026 10:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vlTYk-0001wL-VX
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vlTYj-00013W-BW
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769699027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+jtpRW2kGnaSfuoRNOmz//H9sL6IufCkQZdTQrcCW0k=;
 b=S2wZ0ExA465KLaNbjzCs7+JXKJZYKcG0xJ1fabhjQ8SVPoWs9w5rkBAlzFgQyil5vLMZhE
 uLZ1+bhvpqsJuO3acYd2mbhEQoZY1ofecAVaGO5jwWVyyj4gDmMnsz8XnNgHzS1tYKXyLj
 J52wp6bleU3o4e6uRAi69rdSnQKFqbs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-64acnFH9OhKZY5VrDBBbHA-1; Thu, 29 Jan 2026 10:03:45 -0500
X-MC-Unique: 64acnFH9OhKZY5VrDBBbHA-1
X-Mimecast-MFC-AGG-ID: 64acnFH9OhKZY5VrDBBbHA_1769699024
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so597132f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 07:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769699024; x=1770303824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+jtpRW2kGnaSfuoRNOmz//H9sL6IufCkQZdTQrcCW0k=;
 b=nFAHIU9O+PAK4vZjZeGrK3d/9dnH8bpJfQHESjSiGVnr2xL8Jk/b6sHP+wBS7U/pTt
 rsKNGk1kNoeHhuJDFh8nDYhUkp9OJXvTqaT19OCYMscHzrmlSouwvOXIjcEMzL7LSz51
 3yU7WYcULu9y+nChYRni2+RL7/X5E6jVAynmvWu+q7vX6xatXAo5LIb/K07jfHviy7Jt
 mndnpm874ITsPD4jp9UJPGVsDeCGLD7Y7XHHohfKF5B6ElyDZwUkFMlT9s6hFbtxKSkS
 J5sNlcwMHMRFEBePYxqhmvpmmci0aZ70kCvpSIJNDsplpxBc7u51NXnRxT06R6Twel3S
 kW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769699024; x=1770303824;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jtpRW2kGnaSfuoRNOmz//H9sL6IufCkQZdTQrcCW0k=;
 b=WkDMBxFtxY4PxmCArJYGdpq5X2VGlNw+dGuW7WGwIXB2M2WQUuQPU7927V23aybKEq
 ZHiWw0CiVSi6lN93YU6Uj6FHoO8xk51opovqWesXJPu4ePlB2UHtvflaOMIAO5xEPna8
 JbTWS5SC2Si3zo1mWuZenx5VT0ELPz2KJEGm3kutvVbwq7MeLmMw3GbWeyZx7iIqgjVy
 NzmfbR2bM+Cd0DsDHY0TUFMsjVjAyr85VRYZZwgEX9PwR2NeU4YnezQMxbVirAflTIMO
 bCk7GBnF4pFNanRpnpBT4NugYVhiI+MQKb0uU3910WnfmoSuXfR9eXBfF5MaEQnAOly1
 YfxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViw5eX/eVobeSILqzWIIsTdPVG2XM6Kne2Ijm4qdGxmL1+ae9gsdwc1aRqKH3tnfv9ewJxAOC4gNu+@nongnu.org
X-Gm-Message-State: AOJu0Yxe4emy+AX80/YHQsQrkXg9OQQ2HjYb7fc6Ge4H73EBGzqN7MMO
 gyZTBUdIGY010CoxlIZyH7363al4eTlAJWTZEnbl3b8CP45wEEcDs83A3yh9uLINGGQ6dV8w43P
 cN/PAggY74ycqO3DokENEms2fzMUzPSsou3jfNdpT4Tokd7pELsBegUeM
X-Gm-Gg: AZuq6aII4EjHGitmtIoU0R66kNTpB6t+xlLO+4yDLxZ6K6i6mgpEOwnBAtJkKDbvwXr
 Sw4Hyu639bUjZOIAZ2R81kdd3pwtxUfCXWE/bFU5gVuwEGGUFQBcxad1VH7dB4ri/jbnT2sPPQt
 5Kmnyfqlc+2lgtruN55nLlHsIJDOGr49gYCTPEeVC7FHvXMXIyKyFyFzslxsfVDShB7P++Ol1H5
 NYPL8gtafg3yJ1dMXXJZ1sARLI9YeouLGXa54BHdyz0DovBwNYkpYitblWSxx7E1g/H18uMGWoo
 CsU5k08o+bNJ1SaDXKEC00XQaoPsnc8KxPsZQLf5TQ1AB6mtMU4NoFG2ySIiMWhw/Em2Yz5U+Vu
 zo9u85933Jzh0LdC3tDP8QxL+6FYvmRyjNsNtfalle5FHNjE8
X-Received: by 2002:a05:6000:2501:b0:430:f40f:61b9 with SMTP id
 ffacd0b85a97d-435dd04c936mr12103146f8f.4.1769699024183; 
 Thu, 29 Jan 2026 07:03:44 -0800 (PST)
X-Received: by 2002:a05:6000:2501:b0:430:f40f:61b9 with SMTP id
 ffacd0b85a97d-435dd04c936mr12103111f8f.4.1769699023615; 
 Thu, 29 Jan 2026 07:03:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16339795f8f.13.2026.01.29.07.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 07:03:42 -0800 (PST)
Message-ID: <8ff61949-2619-48db-8f81-fbc84c1b5463@redhat.com>
Date: Thu, 29 Jan 2026 16:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-9-vivek.kasireddy@intel.com>
 <1bddcc61-9640-4d63-a972-ab16b0061611@redhat.com>
 <IA0PR11MB7185685AEB4BC657C167EB0FF89EA@IA0PR11MB7185.namprd11.prod.outlook.com>
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
In-Reply-To: <IA0PR11MB7185685AEB4BC657C167EB0FF89EA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,


>>>    {
>>>        res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>>>                             MAP_SHARED, res->dmabuf_fd, 0);
>>>        if (res->remapped == MAP_FAILED) {
>>> +        res->remapped = vfio_dmabuf_mmap(res);
>>> +        if (res->remapped != MAP_FAILED) {
>>> +            return;
>>> +        }
>>>            warn_report("%s: dmabuf mmap failed: %s", __func__,
>>>                        strerror(errno));
>>>            res->remapped = NULL;
>>> @@ -139,8 +236,12 @@ void virtio_gpu_init_dmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>        } else {
>>>            virtio_gpu_create_udmabuf(res);
>>>            if (res->dmabuf_fd < 0) {
>>
>> Why test dmabuf_fd ? Can virtio_gpu_init_dmabuf() be called mulmtiple
>> times ?
> Yes, virtio_gpu_init_dmabuf() can be called multiple times as the Guest VM
> creates/uses new resources/Guest blobs, which can happen frequently.
> Are you suggesting that it is better to make virtio_gpu_create_udmabuf()
> return res->dmabuf_fd explicitly as opposed to the current indirect approach?

Yes. Good idea. It would be improve reading.

Thanks,

C.


