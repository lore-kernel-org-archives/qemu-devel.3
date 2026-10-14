Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0300CCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH1ro-0000Wy-KZ; Wed, 14 Oct 2026 12:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xH1rQ-00007u-PD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xH1rL-0006Ad-Ei
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791995382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t9ZCiBlTP/Jim/W9ooGlLEMJrd5sZ9XcMM3UywIpp+I=;
 b=fWoJEfpM/RrPtYUbcP7nblQE1LimHfTenJastknfXD+lfYQAYm4LjGTXc9qXrY1WshIylw
 uRK2A/R4vurxamiZWQUYqexO9+xr7rIbZrUs0hLTnFMjPcnFgMLYh9/gp8KcT37DtdNNKW
 zJhHldSxdNgpAb8A62hMWj4FZwS7gHs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-yAamtt7TPE6rJstDGOLvzA-1; Wed, 14 Oct 2026 16:29:41 +0000
X-MC-Unique: yAamtt7TPE6rJstDGOLvzA-1
X-Mimecast-MFC-AGG-ID: yAamtt7TPE6rJstDGOLvzA_1791995380
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1721559b4so45142125e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791995380; x=1792600180; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t9ZCiBlTP/Jim/W9ooGlLEMJrd5sZ9XcMM3UywIpp+I=;
 b=thnWDSlIKVAXWXCc8RZgkM5YxocRH5jqio9g7dtC9TlnNZPhI3uCm7/yRZutspLR/L
 58bvbxUMgFGFQLLO/y0xDwa5z3BDvxxcU7g+lwUcch2r4t4bxAqRnMBqEfNQxteYFWbB
 KFGdBZ/AEYGL/jk9+pxUTq/HlORWHUQq4XxrzLNgWNTtI2E+M41Xmt5SxTEfhlab95Q7
 44YwZRoFFvnTAr3ezbimcKPUElXv+CJi7evbzZ0REJ1DbiJSAOd+lM8MUzroQiJY5RRm
 HBoHijqU29lktYYrlFvJua4slBPzQ33Hmj/qwBKytds4RIQ2kfA6Lrs1gGeMam3XpnQx
 ADCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791995380; x=1792600180;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t9ZCiBlTP/Jim/W9ooGlLEMJrd5sZ9XcMM3UywIpp+I=;
 b=NRCX7EHEa+vWZJnfgu6IWN6jvZELwq0DgoeOb+l31RIj/W0yj16Kn71w8VBVUzrBzA
 KZ+4c69I5eKhW02NcFK8m4XUcZy3bo/8BpCcE5ILYdZOC/0gV54Uz3vtmokuOgoLmXe2
 ARbb79Vu/xj9NqYjwqbcx9mynUbPIM9cxQJ9iQEXIh2tAlgTG/EGtseNdT/GP5h5nX6p
 r5MbFM48mkB/2YaQp2D93N2th+AYYjr43pvD05t02UQH8wD48OVk/ccvZ4N+eOKKDkiY
 MaoxHoFn/qknIs9dW91KHbo1dVyl43KafoQtIIigbkIAhOdLtcVzsS5ECLNR7r7uYbCe
 9KIg==
X-Forwarded-Encrypted: i=1;
 AKwUvByzn2v9lAzL+Yx4H88TfnsjlmDe08BDw37m1oV9VUT4wJS268LT+fePvH5q+mAiof1PlCiLIe5ajwiv@nongnu.org
X-Gm-Message-State: AFq9FYJwYyYzyYwkVmhuDwhllA3akwtXnpgsSVBCXaPy8jQ9RsvRghdm
 WV1/pTssUTQcmA8iVFNrrgq3fEzb37CrwEkJU+b8C3L/OumOZTeUeTugt4o5Udat81O3r8g6Gxu
 Hi0Fovp7ULyUtNZsp2kMWnC8CJkF+itArNipAuU7BN0sQ4T1b2/079+rg
X-Gm-Gg: AYBFou2tXlNI4FHrEFj+pvPsP57vLtfdN87Y07EtXOnb20ABUqXacT+vB8olxDBJo8w
 2zWcJ/XeTHiDqh99RLF3/V8IMACJS7fUVKX/pSXW3uN7fXDoWbpyHz/cG7hxMcLFspV5/11m/N2
 6M+F3WPDx++THXatGtuyfOkSGUTHzvg3mb2/io3Cv6gLDhSV6cNwiu5OaUe5oRIJ+Ol9IfLPHgZ
 TcMk6I8aGMNq6rHu5BNjlGXn6pmHFMXMteN3QSE5rYCk5PxKVFyTt+SDjijon6NQVMFa4PFR1wF
 upGD41UtP9d8JxakifdsfQ1dZTVQOwH+EhM4VkOZxRf36yMfTX8TMqWJGeCVdc0UYAGnMGPlpds
 wnR3fpwkU5uMVkHgt+QO7u55tR0Ii9zg2GyqP1all
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr328236055e9.0.1791995379609; 
 Wed, 14 Oct 2026 09:29:39 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr328235485e9.0.1791995379125; 
 Wed, 14 Oct 2026 09:29:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd97ed6asm3159455e9.6.2026.10.14.09.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 09:29:38 -0700 (PDT)
Message-ID: <8fabff75-f7d7-40a0-bd8d-acef46b76530@redhat.com>
Date: Wed, 14 Oct 2026 18:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
 <c18f2fde-5dae-45c5-a61a-8cade3ae5286@redhat.com>
 <87h5ioepb9.fsf@pond.sub.org>
 <3f38296f-012f-40af-807d-5979e4759015@rsg.ci.i.u-tokyo.ac.jp>
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
In-Reply-To: <3f38296f-012f-40af-807d-5979e4759015@rsg.ci.i.u-tokyo.ac.jp>
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

On 10/14/26 15:07, Akihiko Odaki wrote:
>>
> 
> Thank you for the guidance. Rephrasing your points:
> 
> - Negative errno is often convenient, but an alternative set of error
>    codes are used when it's a bad fit.
> 
> - KISS: encode specific error conditions to be distinguished instead encoding all.
> 
> This brings us to a common architectural intersection: How should a function handle and propagate errors when its callees return overlapping -errno values that require different treatment by the caller?
> 
> Both virtio_gpu_create_udmabuf() and vfio_device_create_dmabuf_fd() face this challenge. Evaluating the available design options against your advice yields the following:
> 
> 1. Use custom error code enum.
> 
> Defining an enum is not as convenient as negative errno, but it is KISS; it encodes specific error conditions we care about:
> 
> enum {
>      VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
>      VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
> };
> 
> static int vfio_device_create_dmabuf_fd(..., Error **errp)
> {
>      ...
> 
>      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>      }
> 
>      ...
> 
>      ret = vfio_device_get_feature(vbasedev, feature);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
>                           "Could not create dmabuf fd via VFIO device");
>          return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>      }
>      return ret;
> }

Works, it's heavy.

This function has a single caller, and the enum values break the
-errno convention that the rest of the fallback chain uses
(virtio_gpu_create_udmabuf returns -errno). The caller would
handle two different return-value conventions in the same fallback
sequence.

A VFIO_DMABUF_CREATE_ERR_* enum defined in a VFIO header that
hw/display/virtio-gpu-dmabuf.c must include and switch on.
That's adding a VFIO-specific error vocabulary to the display
subsystem's control flow. It introduces a layering violation.

What is important is to acknowledge that how the implementation
arrives at "not applicable" (device lookup failed, region lookup
failed) is irrelevant to the caller.
A VFIO-specific error enum in the return type inverts thatrelationship;it makes the caller encode knowledge of the implementation's internal
failure modes. That's the opposite of what a library API should do.


> 2. Remap -errno.
> 
> This is what Cédric suggested [1].
> 
> The negative errno values returned by internal callees do not precisely represent the error conditions we need to handle, making negative errno a "bad fit" here. However, the main issue isn't negative errno itself, but rather that we must handle negative errno values originating from different function calls. We can remap the values to resolve this:
> 
> static int vfio_device_create_dmabuf_fd(..., Error **errp)
> {
>      ...
> 
>      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
>          return -EINVAL;
>      }
> 
>      ...
> 
>      ret = vfio_device_get_feature(vbasedev, feature);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
>                           "Could not create dmabuf fd via VFIO device");
>          /*
>           * Remap -EINVAL: caller uses it to mean
>           * "addresses incompatible"
>           */
>          return (ret == -EINVAL) ? -EIO : ret;
>      }
>      return ret;
> }
> 
> The downside is that it is not KISS; the condition to remap errno encodes more possible errors, but they do not matter to the current caller (and it coalesces error codes from vfio_device_get_feature(), though that is also harmless for the caller).

The KISS argument is a bit thin here. you acknowledge yourself that neither
concern matters to the caller.

> 3. Another better idea?


If the downside is to encode knowledge about what vfio_device_get_feature()
might return (that the caller should not even know about), and future changes
to that function's error codes could silently break the contract, let's use
-ENODEV as a compromise.

   int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                    Error **errp)
   {
       ...
       if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
           return -ENODEV;    <--------
       }
       ...
       for (i = 0; i < iov_cnt; i++) {
           if (!vfio_region_lookup(iov[i].iov_base, &region,
                                   first_rb, &offset, errp)) {
               return -ENODEV; <----------
           }
           ...
       }
       ...
       ret = vfio_device_get_feature(vbasedev, feature);
       if (ret < 0) {
           error_setg_errno(errp, -ret,
                            "Could not create dmabuf fd via VFIO device");
           return ret;   /* pass through kernel errno unchanged */
       }
       return ret;
   }

Caller becomes:

   res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
                                                 res->iov_cnt,
                                                 &local_err);
   if (res->dmabuf_fd == -ENODEV) {
       error_free_or_abort(&local_err);
       qemu_log_mask(LOG_GUEST_ERROR,
                     "Cannot create dmabuf: incompatible memory\n");
       return false;
   }

Thanks,

C.


