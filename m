Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F954CED624
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKov-0000ii-JP; Tue, 18 Nov 2025 07:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLKou-0000iO-O9
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLKot-0006QB-08
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763468906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fxd+PxT7dydSscqeJ3r6lJAv0smOVLnvqZkTiVpuyO8=;
 b=CHEaCflQptJJr2Yk3uy7sHsTq3yCab3e9/GEVue4XFC/P65xg5pwLRwXWipbWQdxI41eCU
 YMdAGZ5h/hBlTINzVTrk3btXgHeQbk61JRr8ur++w/ro//Ryk4BasD0EZmRBPFeGeMUbMV
 d+y/MGe0zfOdObUO/AWseluotw24OtI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-GGIoNo6xMS2uJLF9u8ZDMA-1; Tue, 18 Nov 2025 07:28:22 -0500
X-MC-Unique: GGIoNo6xMS2uJLF9u8ZDMA-1
X-Mimecast-MFC-AGG-ID: GGIoNo6xMS2uJLF9u8ZDMA_1763468901
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775fcf67d8so37111895e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763468901; x=1764073701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fxd+PxT7dydSscqeJ3r6lJAv0smOVLnvqZkTiVpuyO8=;
 b=Er4Xba4RnWVZ/50S90MAlVmoxDSGgCMerJMrCl/fYxstmxtKgHihrCPdu3DdTgRC1s
 1QSXzAzNJKaWFFThZ5Rs7pfNKTl6XvSGIlUu8b2ZKQogIIrnLwH4IhBpRTSR1fBFfagl
 uD0S+SIVQZ/tTJj0lIRrJogL8drbDNiWXly2fZ9aW0pClsZiBaUSD3W4CiL3ZiYJb6f4
 mbwHMNzstE9J9nV7ViXSymvkY3Htvljm5N1fAg1w5jQNavSot9/QsPVXi4PPK5ZOmUMV
 PAp2AbvrD9HpEwhc0EK+NGfLaxHqs9A1SPT+ElqdIigaGkVWqwsqnxEe4g0/SczOPHKQ
 O0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763468901; x=1764073701;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxd+PxT7dydSscqeJ3r6lJAv0smOVLnvqZkTiVpuyO8=;
 b=CykN41LCqLr6rDOqL/bU163RvTahQJ+f4DAmch2hebKgEGb4KW/lwdBs+YM2hCqmXS
 b88KbVtfvLIatARa6EJ1S+veTImKulctSq/2PLkhbVGjp6CXFwnqBhHCX8q85ialWpg7
 zqWFEl7sZfstpF/0YtpgGf+Fdwunn1Zofin+ficCratJPYHXMJpKKNm/7RwsgwGY5Mu3
 htfYmeUMQLYMNdpROX5c+VrVMMmaCifCRpajr4jY0TNPy4SbHXiFff+O3jVQAtSTUVDL
 KQa42jTtCmSeXyacfN2clLi6rthbExeak+M6Z7l2LScw5jZlvVMXrlRA8Up+0kTUVAEh
 WNlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCTBp0Jw3iIItb8tQP+0l41V6O/f9iMZHGbu9rdSARwiKVt+iWaWczzhjNWhu9xcXSrVAz+O6TMKSo@nongnu.org
X-Gm-Message-State: AOJu0YyfNeUA82yBXW/LiOh9yqF5hpzALN4uCq1Adg50m53/CT8m1oLZ
 XqjW8RQRi2iD5gfITjzLpi3p3laml7ZVze03bkLfbFzedCgB5xtUu+RPYG4aMBMQcqBsuXFTsZn
 jZIBAZYP7YR0uTmkJCXUkDsbX9LsArWo7+t3duy3CeV4uMCNA77loI7y4
X-Gm-Gg: ASbGncsf403hQC0pvyTfyKHPsNs1AjSmOsR4gYO12R1eASYEOHpqhGwJ5fzuTLyNYmo
 ug3cUD71wp6mYE9y/lNXnjXzZyXwmrpSzakek1QMmIwS5VVivBDM8Fsd/lvNc2VcurRpGiHEChF
 2XNZJl2FnxYrurMBf8uN5u0se5l83BTyjljRqA9RYyuBF0Cco9uBZmWrFJ+8ZAokO0DqYS/hLhH
 OHu4MgmFrmpjywpDyb1t0K9ienLIZ0mqb+LvlGGXRrOe6M4vvsYQAQwtoCVLg1PZi9fK1fIK62b
 7LRf5V13mHpjN0SgfeQifaJdRVw65jMT9UDY9h4Jv8PPUgnxpVs+n3l8l/jjiV2RH2E4jvYkM0C
 cI7aPoE4=
X-Received: by 2002:a05:600c:1f83:b0:477:54cd:2030 with SMTP id
 5b1f17b1804b1-4778fe797afmr152097595e9.21.1763468901475; 
 Tue, 18 Nov 2025 04:28:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwQkunRUCF1HsOocTAF1bWfUCC2Y6vyGqnyb5zK9z0HqcBASpHupM3mlvkq90FwRYAtfrIng==
X-Received: by 2002:a05:600c:1f83:b0:477:54cd:2030 with SMTP id
 5b1f17b1804b1-4778fe797afmr152097265e9.21.1763468901029; 
 Tue, 18 Nov 2025 04:28:21 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm91390325e9.14.2025.11.18.04.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 04:28:20 -0800 (PST)
Message-ID: <50f79156-dd93-40c4-831e-66e558531be8@redhat.com>
Date: Tue, 18 Nov 2025 13:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
To: Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>
References: <20251118093945.35062-1-thuth@redhat.com>
 <20251118130218.30d3da33.pasic@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251118130218.30d3da33.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/11/2025 13.02, Halil Pasic wrote:
> On Tue, 18 Nov 2025 10:39:45 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> Consider the following nested setup: An L1 host uses some virtio device
>> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
>> device through to the L3 guest. Since the L3 guest sees a virtio device,
>> it might send virtio notifications to the QEMU in L2 for that device.
> 
> Hm, but conceptually the notification is sent to the virtio device,
> regardless of hypervisors, right? But because for virtio-ccw the
> notification is an DIAG 500, we have the usual cascade of intercept
> handling. And because we have never considered this scenario up till now
> the intercept handler in L2 QEMU gets called, because it is usually the
> responsibility of L2 QEMU to emulate instructions for an L3 guest.

Right.

> I think vfio-ccw pass through was supposed to be only about DASD.

Yes. And we only noticed this bug by accident - while trying to pass through 
a DASD device, the wrong device was used for VFIO and suddenly QEMU crashed.

>> But since the QEMU in L2 defined this device as vfio-ccw, the function
>> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
>> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
>> but since "sch" belongs to a vfio-ccw device, that driver_data rather
>> points to a CcwDevice instead. So as soon as QEMU tries to use some
>> VirtioCcwDevice specific data from that device, we've lost.
>>
>> We must not take virtio notifications for such devices. Thus fix the
>> issue by adding a check to the handle_virtio_ccw_notify() handler to
>> refuse all devices that are not our own virtio devices.
> 
> I'm on board with this patch! Virtio notifications are only supported
> for virtio devices and if a guest for what ever reason attempts
> to do a virtio notification on a non-virtio device, that should be
> handled accordingly. Which would be some sort of a program exception
> I guess. Maybe you could add what kind of exception do we end up
> with to the commit message. I would guess specification exception.
> 
> But I would argue that the L3 guest didn't do anything wrong.

That's the point - the L3 guest just sees a virtio device, so we should not 
punish it with program exceptions just because it tried to send a 
notification for the device.

> Pass-through of virtio-ccw devices is simply not implemented yet
> properly. And even  if we were to swallow that notification silently,
> it would be effectively loss of initiative I guess.

I think the current patch does the right thing: It returns an error value to 
the guest (just like we're doing it in other spots in this function 
already), so the guest sees that error value and then can finally give up on 
using the device.

> So I think it would really make sense to prevent passing through
> virtio-ccw devices with vfio-ccw.

That could be a nice addition on top (in another patch), but we have to fix 
handle_virtio_ccw_notify() anyway to avoid that the L3 guest can crash QEMU, 
so it's certainly not a replacement for this patch, I think.

  Thomas


