Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20355FD7070
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2RVd-0008AD-Rv; Tue, 17 Mar 2026 06:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2RVb-0008A4-Ca
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2RVY-0007xx-F6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773742718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k4yl5opEvODS2xhVS5IvjpNroLwGK51xT2pTGzcJd/c=;
 b=UH7w96dDSHLja6F2CbBmogbgMMh2myJFK/thGtJ41nm4IzgBBZPCFNl68N6T5jUejvVmKC
 vaylXpOaAA0O6wmM0HVhJQlfDhwAFmQ1eu3k6q4vRvsqZFdJJuo6jSWAtzWlkT/gi1MlfP
 LAyCXcXUsogFEGdZ/zAUAe9dbeWIWXI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Y_ZBu3lYN1SXIIY_trySAA-1; Tue, 17 Mar 2026 06:18:34 -0400
X-MC-Unique: Y_ZBu3lYN1SXIIY_trySAA-1
X-Mimecast-MFC-AGG-ID: Y_ZBu3lYN1SXIIY_trySAA_1773742714
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853040372fso51950995e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773742713; x=1774347513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=k4yl5opEvODS2xhVS5IvjpNroLwGK51xT2pTGzcJd/c=;
 b=UDYm7bK+VRAqFZiBEBvByVxqyANnZ/iMiH9ciZj1tIHy9fuokWM5ri9KZI4fNqkmaV
 pZzA2EVUxcmCLPTlZ3UbvOWXv9aQAKRTfVf7J+rPggPlKqOrnv6cFJeBSZZ/bvyP0Dye
 sycJ66hNucbW1fLXg4TdUFsNayoK+CT/Nsz3UsbJfjZERQnyjZDOIm0HqpjxUWjv4xY6
 2X3WU7TVgCRf6pRI4Mi9g7TPG0VVg6EJNqtCDKskZ5RqSoBCK6jFjquobow8/FQNPmob
 G5GVnvdjw3WJko0CvA+tw4o0mZVHTvVdJaiKxEg7+aJgifueBmxX+XQlVRGyiFNd/xfl
 cHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773742713; x=1774347513;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4yl5opEvODS2xhVS5IvjpNroLwGK51xT2pTGzcJd/c=;
 b=Kg3A0kECzNhlCJ5GBbLnXAlooLGjxFHMOfaURoZGaBb2Cmb4zrtSfDxAtgaaw5KQYd
 D4z5xvKs3RY1GdY9oi7NcYBdkEr2uonNN8+WlbtyoX0Yl97w0yE18NhXt4lAnzuYw6G5
 TjVm2Mg99BmjkT8AZpFq1+J3SAMb0XPKsyyONd7CuusMQIeNYf9Jo+Gc0aqlZsJ1Fbdv
 N4L7oEeljlH1ZbZ7FuclDtegmFyRKg2KoADNCfCu0ggckCwCkj/10dgfCvOG9jJcjhsW
 6qaXE1NZPGU6mJQBQf2rBVPXCdGPCyWvk+8Qfys3wNvgii5QwbX4GzsSkzKA/FeslR/T
 Eg9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpCWoIayqSYv9HgrIdLS5m9eEmahsrztt6SQWEHH5tXBZ5FI872Gal/kqe/SBEVY2rhgxZDwlh9lOr@nongnu.org
X-Gm-Message-State: AOJu0YwdfQGbz4ESyMtBpQB0Bbw+91/6MYDjMLARmHbo2Xwgii3XAKWz
 xtgnklFg+oAlpvn7l3+Sqwyzef62zsMfkE8qaWZyGs5b0n/XS1qJR1mC3tN+nCqurBao923wTY1
 OfYHAnOURWzATleAD+knvl9fTpbqoTYqCLTbAlvpbmLedzkN8g7Fc+3Gp
X-Gm-Gg: ATEYQzyBgXYWTjeaoWe2r4nh7A+zpdSzA6ZU1DT5QScrcjLAikLArdb3SD+xQ2a0lAT
 v0/pwy23l7cSKy09OXVNoV2HUsqGJvUAHovUdKxUshRYJcG4dZiV2EBPs581qGUUcPLwClsCO0H
 uusZxsf65j5MaSIFcTs6Vv0TWLTlf9tau86Zp3+WOrLDLId7FZDcklhAz+saL/9gM77xkplZ0nk
 e3/1aThpdzVCl1d9mJCzEo6WeWG8qLftHc47Mak9/fow8t2z0/ZMIc/aswCtbJ112sJsmowrBIe
 aF5POqE7L87K0fl9icPGwJtiDELqGMs1UIrq99WcHzH7SzRrdE8GVD54wrXDveFkx6bdx+iYVVW
 CaXbjRiQ+mxqbi2x0Os/xhTXl3/XfMbj8+TrUGQ+Vuz5Tuvwstsbz7O0XPwYJ
X-Received: by 2002:a05:600c:a45:b0:485:4006:960c with SMTP id
 5b1f17b1804b1-48556702a7dmr291270725e9.16.1773742713605; 
 Tue, 17 Mar 2026 03:18:33 -0700 (PDT)
X-Received: by 2002:a05:600c:a45:b0:485:4006:960c with SMTP id
 5b1f17b1804b1-48556702a7dmr291270355e9.16.1773742713149; 
 Tue, 17 Mar 2026 03:18:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c340sm58088805e9.7.2026.03.17.03.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 03:18:32 -0700 (PDT)
Message-ID: <664eb0bd-cd2d-4813-91d4-2a48e18bba55@redhat.com>
Date: Tue, 17 Mar 2026 11:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-11-vivek.kasireddy@intel.com>
 <04fa350a-b181-483b-8cbd-2ba5171174ba@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185D57A5228ACBD883CCA99F844A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <CH3PR11MB71779A42788AC6E84035F362F841A@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR11MB71779A42788AC6E84035F362F841A@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Vivek,


On 3/17/26 06:42, Kasireddy, Vivek wrote:
> Hi Cedric,
> 
>> Subject: RE: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for
>> blobs associated with VFIO devices
>>>
>>> On 2026/03/11 11:50, Vivek Kasireddy wrote:
>>>> In addition to memfd, a blob resource can also have its backing
>>>> storage in a VFIO device region. Since, there is no effective way to
>>>> determine where the backing storage is located, we first try to
>>>> create a dmabuf assuming it is in memfd. If that fails, we try to
>>>> create a dmabuf assuming it is in VFIO device region.
>>>>
>>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
>>>> backing storage is located in a memfd or not. If it is not, we
>>>> invoke the vfio_device_create_dmabuf_fd() API which identifies the
>>>> right VFIO device and eventually creates a dmabuf fd.
>>>>
>>>> Note that, for mmapping the dmabuf, we directly call mmap() if the
>>>> dmabuf fd was created via virtio_gpu_create_udmabuf() since we
>> know
>>>> that the udmabuf driver supports mmap(). However, if the dmabuf
>> was
>>>> created via vfio_device_create_dmabuf_fd(), we use the
>>>> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
>>>>
>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>
>>> Now I think this patch implements proper handling of all error
>>> conditions and conforms the convention.
>>>
>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Thank you for taking the time to review these patches!
> Can this series be merged to vfio-next given the dependencies on
> the newly added VFIO APIs?
I could merge in advance the VFIO changes but the series does not
apply nor compiles. We need feedback from the virtio-gpu maintainers
that this proposal is a useful feature too.

Since this is QEMU 11.1 material, we have some time. Let me review
it first.

Thanks,

C.


