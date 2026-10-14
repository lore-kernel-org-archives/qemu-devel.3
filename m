Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0563EC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH22H-0005bv-BS; Wed, 14 Oct 2026 12:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xH22E-0005bF-Fb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xH22B-0007XI-Se
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791996054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J/PMkuWniVW+RfDPJe136EJ5Y4+AOr9vJz1bFBNWrBg=;
 b=F7uY2S+Bmd7hYtI367FdMnbNi7+SaElXbu4gZlArcf8dZytHT31qJrbidOt5qZYqZcwa0a
 ZT+qBMAu95q2JJHswjQlCbnCq4xYzHSY7Zmk/V07wrs3GjnCZYkIkzF9Rt5BJs91S+7Slu
 SYgdZVXZ1gXTPUgydl/c5LYIkDaVj18=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-MhZNPnIaMJ6FU0Nw8Ni8kw-1; Wed, 14 Oct 2026 16:40:52 +0000
X-MC-Unique: MhZNPnIaMJ6FU0Nw8Ni8kw-1
X-Mimecast-MFC-AGG-ID: MhZNPnIaMJ6FU0Nw8Ni8kw_1791996051
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a013ea30c0so31550315e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791996051; x=1792600851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J/PMkuWniVW+RfDPJe136EJ5Y4+AOr9vJz1bFBNWrBg=;
 b=MEm/K/saV7Q8hCW0qnnXfEVNcPtm/2LuNGdCTQLLMeMLuTF8Nj00KOJXSRQ17KvsJ0
 X9cjPl5SmNqVrKyoYFR7ySOa6ZmJJui0swQsV9MSZctrgM6SvUGk+Q3K8iaSoV4WVN1A
 4nKJAGY93m+2C6zaKoP0FvtlSw6+RFz3f/eVUjZgwk41TI2ETJRmvVYKIftwUK49xPtb
 PHQK9guhLZB7XJ8h/TtLhngyHYd0hUvFgiZdNwDtGXJPSA3msf25GMKfsDwZtBo2pdn3
 azi9XXvPaHTSSFgmLEJbC+OOgi1JfjV5HLXNINCblfzpjerflctl8gkVPuGVOlJqXBEJ
 jzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996051; x=1792600851;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J/PMkuWniVW+RfDPJe136EJ5Y4+AOr9vJz1bFBNWrBg=;
 b=oxZm+5GvAlQ7qjZPqso82QFq96MXi33NLx8ElCkzOJ/W130dTIMVlqZrHl2mtqMEz4
 VnkITTQ2JG9ZaOQi+cTupy1RA9NiQMrkrzNHcEVHi5lHcL1ippll5VSiDc91PXWMMBwJ
 QwISWD6mU1g98GyJooj6KOgEOB0qr7MtblmE9e74hZASy7NJSYAuKxhnthyUiXZl97v8
 HlF+iWTN91WVSXKWi8arWlNXrrpTJ8DS9KJSnwBEjv2Km5TYKbf+CUnJplpJLxmWI2Ls
 xKiV4JwsbJBDriT/UlyvgNaKA+osHYogrvHig7+QjGRb0u+dLsL6lM6uwf26w3HEKuGm
 19Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykoTH8U9w+WAzLQe+nKq1EW/3E0MUjxVLgR6uw7gLdi09YxKEIIru1KJWBT2Ts1aDS8iKkE5+ULu6u@nongnu.org
X-Gm-Message-State: AFq9FYJZHQPuXXu12u27B4LcoCeJnkzUIS7BasRIbjXoudYBOcbdctpA
 HC5s52bASD/dAyEgmm1IiUp8jp55J97f+UI8HplvYbr/Gk2ZOU4XpES/8FAj9gqlFdYPYfdisFS
 b7Iw4ywT6BMzoCA/h95EVxvvAsNyTU/fRTfdIvowikHex1R+WQyO/+QHE
X-Gm-Gg: AYBFou1Xbj0P6t6l2os4RfiwNgmrCES5u49QLR89qf64FXZjy0Uci114tuvh0ZHYIUy
 zaQqWxJWnPGAykojtI6D/IytFRsuhcHpCzB5fhELs6hUvo9GdWj/gcJ5IHI2O2ipyxIsILRnaW7
 yEIkEOsiPwA/O2S7m4In7ug4JGL+qLTS2Vhd3ShCqLK+guFUJdWltpWIq4PALC/BY8CUqCivH3u
 FyFUwH/tK1uDb3e4JWYn454CPrdN8rgHZyLiV0Ahpp5C9o50ZMpOpDp/2kxHa9a4owblvYtJmgi
 XjoZUWSFT5o5e7jrJQu+j1L39BlBT/noFjjQmFmRfO/ySk+7GmupXQUo0U4RViA9cuFEqAPDjXW
 PnURdgb2pOk3ln/zUIZR3bDiUhuv+wsUyWffYLMZK
X-Received: by 2002:a05:600c:8b83:b0:4a1:811c:8064 with SMTP id
 5b1f17b1804b1-4a18e4d5512mr318081245e9.26.1791996051250; 
 Wed, 14 Oct 2026 09:40:51 -0700 (PDT)
X-Received: by 2002:a05:600c:8b83:b0:4a1:811c:8064 with SMTP id
 5b1f17b1804b1-4a18e4d5512mr318080875e9.26.1791996050751; 
 Wed, 14 Oct 2026 09:40:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48ded185de7sm4561526f8f.31.2026.10.14.09.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 09:40:50 -0700 (PDT)
Message-ID: <edb6fd9c-4b6b-4171-9e71-e38f9546055b@redhat.com>
Date: Wed, 14 Oct 2026 18:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
 <c18f2fde-5dae-45c5-a61a-8cade3ae5286@redhat.com>
 <12afec43-1da5-4326-9395-73441effe9c6@rsg.ci.i.u-tokyo.ac.jp>
 <458252ce-c1b8-4df6-8268-4ae09cd96d56@redhat.com>
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
In-Reply-To: <458252ce-c1b8-4df6-8268-4ae09cd96d56@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On 10/14/26 09:41, Cédric Le Goater wrote:
> Hello !
> 
> [ ... ]
> 
>> Choosing between qemu_log_mask(LOG_GUEST_ERROR, ...) and
>> error_report_err() is also a machine decision. The caller needs to
>> distinguish incompatible backing from other failures to select the
>> reporting path; human-readable attribution in Error * is insufficient.
>>
>> The -EINVAL ambiguity therefore remains. vfio_device_get_feature()
>> also returns -EINVAL when the backend lacks the operation. If we
>> propagate that unchanged, your diagram classifies it as incompatible
>> guest memory. Using -EINVAL for that classification requires an
>> explicit mapping that keeps these other failures distinct.
>>
>> Regarding -ENODEV, virtio_gpu_device_realize() already requires
>> virtio_gpu_have_udmabuf() for this blob path. udmabuf_fd() caches the
>> opened fd, so the availability-related -ENODEV should not occur
>> after successful realization.
> You raise valid points :
> 
> * -EINVAL from vfio_device_get_feature(): You're right. That needs a
>    remap to avoid the -EINVAL collision.
> * -ENODEV: Correct, I'll drop that suggestion.
> 
> So, we just need the one-line remap above to avoid the -EINVAL collision.
> See a proposal here :
> 
>    https://github.com/legoater/qemu/commits/virtio-gpu-dmabuf
> 
> Fixup patch :
> 
>    https://github.com/legoater/qemu/commit/653c41e89468f82bbdfcaeafe75473b84f5a1e49
> 
> Also below,

I updated branch

     https://github.com/legoater/qemu/commits/virtio-gpu-dmabuf

with the -ENODEV approach.

Patch below,

C.


 From 3b741e23bb9e9bb80b9f2c78d53b3a4bbcefb795 Mon Sep 17 00:00:00 2001From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Date: Wed, 14 Oct 2026 00:00:00 +0200
Subject: [PATCH] vfio, virtio-gpu-dmabuf: Replace custom error enum with
  standard -errno
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop the VFIO_DMABUF_CREATE_ERR_{INVALID_IOV,UNSPEC} enum from
vfio-device.h and use standard negative errno values instead:

   - -ENODEV: iov addresses do not belong to a VFIO device
   - -ENOTSUP: VFIO not compiled in
   - other -errno: forwarded from kernel VFIO ioctl

Use -ENODEV (instead of -EINVAL) for the "not applicable" case so
that kernel errno values from vfio_device_get_feature() can pass
through unchanged without collision.

The virtio-gpu fallback logic (try udmabuf, then VFIO) checks -ENODEV
to decide whether to try the next backend.

Also fix several issues in the same code:
  - vfio_device_lookup: use global_next (not next) for vfio_device_list
  - Move vfio_device_create_dmabuf_fd/vfio_device_mmap_dmabuf
    declarations outside #ifdef CONFIG_VFIO guard so prototypes are
    visible to the stubs (fixes MinGW build)
  - Remove trailing \n and trailing space from error_setg messages

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
  include/hw/vfio/vfio-device.h  | 16 ++++++----------
  hw/display/virtio-gpu-dmabuf.c | 22 ++++++++++++----------
  hw/vfio/device.c               | 20 ++++++++++----------
  hw/vfio/dmabuf-stubs.c         |  2 +-
  4 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4b8fb6205604..81bc68b28b41 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,13 +41,6 @@ enum {
      VFIO_DEVICE_TYPE_AP = 3,
  };
  
-enum {
-    /* The Guest passed addresses stored in IOV are invalid */
-    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
-    /* Guest or Host may be at fault for this type of error */
-    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
-};
-
  typedef struct VFIODeviceOps VFIODeviceOps;
  typedef struct VFIODeviceIOOps VFIODeviceIOOps;
  typedef struct VFIOMigration VFIOMigration;
@@ -331,6 +324,8 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
  int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                                  struct vfio_irq_info *info);
  
+#endif
+
  /**
   * Create a dmabuf fd by first translating the addresses in the
   * iovec array into VFIO region offsets and then invoking the
@@ -340,8 +335,10 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
   * @iov_cnt: number of entries in the iovec array
   * @errp: pointer to Error*, to store an error if it happens.
   *
- * Returns the created dmabuf fd or either VFIO_DMABUF_CREATE_ERR_UNSPEC
- * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
+ * Returns the dmabuf fd (>= 0) on success, or a negative errno:
+ *  - -ENODEV: iov addresses do not belong to a VFIO device
+ *  - -ENOTSUP: VFIO not compiled in
+ *  - other negative errno from the kernel VFIO ioctl
   */
  int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                   Error **errp);
@@ -360,7 +357,6 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
   */
  void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
                                Error **errp);
-#endif
  
  /* Returns 0 on success, or a negative errno. */
  bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index f59a5e76ff3c..8713b97c9c68 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -39,21 +39,21 @@ static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
      udmabuf = udmabuf_fd();
      if (udmabuf < 0) {
          error_setg(errp, "udmabuf device not available or enabled");
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        return -ENODEV;
      }
  
      list = g_try_malloc0(sizeof(struct udmabuf_create_list) +
                           sizeof(struct udmabuf_create_item) * res->iov_cnt);
      if (!list) {
          error_setg(errp, "failed to allocate udmabuf create list");
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        return -ENOMEM;
      }
  
      for (i = 0; i < res->iov_cnt; i++) {
          rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
          if (!rb || rb->fd < 0) {
-            error_setg(errp, "IOV memory address incompatible with udmabuf ");
-            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+            error_setg(errp, "IOV memory address incompatible with udmabuf");
+            return -EINVAL;
          }
  
          list->list[i].memfd  = rb->fd;
@@ -66,11 +66,13 @@ static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
  
      fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
      if (fd < 0) {
-        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl failed");
-        if (errno == EINVAL || errno == EBADFD) {
-            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+        int saved_errno = errno;
+
+        error_setg_errno(errp, saved_errno, "UDMABUF_CREATE_LIST: ioctl failed");
+        if (saved_errno == EINVAL || saved_errno == EBADFD) {
+            return -EINVAL;
          }
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        return -saved_errno;
      }
      return fd;
  }
@@ -150,13 +152,13 @@ bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
          pdata = res->iov[0].iov_base;
      } else if (res->blob_size) {
          res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
-        if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+        if (res->dmabuf_fd == -EINVAL) {
              error_free_or_abort(&local_err);
  
              res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
                                                            res->iov_cnt,
                                                            &local_err);
-            if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+            if (res->dmabuf_fd == -ENODEV) {
                  error_free_or_abort(&local_err);
                  qemu_log_mask(LOG_GUEST_ERROR,
                                "Cannot create dmabuf: incompatible memory\n");
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 5bc044376441..f7b4e40dc119 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -686,18 +686,18 @@ static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
  
      first_rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
      if (!first_rb) {
-        error_setg(errp, "Could not find first ramblock\n");
+        error_setg(errp, "Could not find first ramblock");
          return false;
      }
  
      *first_rbp = first_rb;
-    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
          if (vbasedev->dev == first_rb->mr->dev) {
              *vbasedevp = vbasedev;
              return true;
          }
      }
-    error_setg(errp, "No VFIO device found to create dmabuf from\n");
+    error_setg(errp, "No VFIO device found to create dmabuf from");
      return false;
  }
  
@@ -716,7 +716,7 @@ static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
  
      rb = qemu_ram_block_from_host(addr, false, offsetp);
      if (!rb || rb != first_rb) {
-        error_setg(errp, "Dmabuf segments must belong to the same region\n");
+        error_setg(errp, "Dmabuf segments must belong to the same region");
          return false;
      }
  
@@ -725,7 +725,7 @@ static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
          *regionp = region;
          return true;
      }
-    error_setg(errp, "Could not find valid region for dmabuf segment\n");
+    error_setg(errp, "Could not find valid region for dmabuf segment");
      return false;
  }
  
@@ -742,7 +742,7 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
      int i, ret;
  
      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
-        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+        return -ENODEV;
      }
  
      argsz = sizeof(*feature) + sizeof (*dma_buf) +
@@ -757,7 +757,7 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
      for (i = 0; i < iov_cnt; i++) {
          if (!vfio_region_lookup(iov[i].iov_base, &region,
                                  first_rb, &offset, errp)) {
-            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+            return -ENODEV;
          }
  
          dma_buf->region_index = region->nr;
@@ -772,7 +772,7 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
      if (ret < 0) {
          error_setg_errno(errp, -ret,
                           "Could not create dmabuf fd via VFIO device");
-        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+        return ret;
      }
      return ret;
  }
@@ -811,7 +811,7 @@ void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
          }
  
          if (vfio_device_get_region_info(vbasedev, region->nr, &info)) {
-            error_setg(errp, "Cannot find region info for dmabuf segment\n");
+            error_setg(errp, "Cannot find region info for dmabuf segment");
              goto err;
          }
  
@@ -819,7 +819,7 @@ void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
                        MAP_SHARED | MAP_FIXED, vbasedev->fd,
                        info->offset + offset);
          if (submap == MAP_FAILED) {
-            error_setg_errno(errp, errno, "Could not mmap dmabuf segment\n");
+            error_setg_errno(errp, errno, "Could not mmap dmabuf segment");
              goto err;
          }
          len += iov[i].iov_len;
diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
index b9e03a162a75..241a9761ef5e 100644
--- a/hw/vfio/dmabuf-stubs.c
+++ b/hw/vfio/dmabuf-stubs.c
@@ -13,7 +13,7 @@ int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                   Error **errp)
  {
      error_setg(errp, "VFIO dmabuf support is not enabled");
-    return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+    return -ENOTSUP;
  }
  
  void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
-- 
2.56.0



