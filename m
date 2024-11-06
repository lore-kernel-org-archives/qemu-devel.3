Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE838D44D4F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dvn-0007RY-Tm; Wed, 06 Nov 2024 06:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8dvf-0007Qw-GZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8dvd-000748-W1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730891425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WPQX6LdunKV1tBtIKNeC2c+cJxxT5F18zbNYIUyT0y0=;
 b=Zy87/7Qr5emdlmQftc5tK8h/NRK11bfTrE06sFAdfziPMRXkIqNQi9aMJf1bEsXtls/aL2
 dZIFt2WJWm14AV8djUKpiTddsONfysSqW+6HU1ps02MhtR1VmxQOZVc9kAEK1RmMek61PO
 LkSk4dGPOOc2DXzKxqjcLMioZStNiQ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-hWwlg2ICPeODdkv8DIxQsA-1; Wed, 06 Nov 2024 06:10:23 -0500
X-MC-Unique: hWwlg2ICPeODdkv8DIxQsA-1
X-Mimecast-MFC-AGG-ID: hWwlg2ICPeODdkv8DIxQsA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so46414295e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 03:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730891422; x=1731496222;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WPQX6LdunKV1tBtIKNeC2c+cJxxT5F18zbNYIUyT0y0=;
 b=ejL5UwMhVEo/KudBI7UPu/be4UtyPHjjh+FBB9vHEFFx6LAauHlRc12c7bD11cMaHL
 i2QNqC6b8Di9h/m7iKKuP8aIDZ6bFsK2q9ffQxhj9am236s4v69HD/xAMG9gwKWRysN8
 rCCZ6aqJsIj2XK+Mf0hRBfhLhjd5J80eQQizg2LJpUvCCKiK+lyH5iLUVDgZDSjQMsTu
 FR8aazdzTTlJemFRwr8KXS5I2f1TRL2mF+rwERPGogzUJjanezVCBjGNWHLZCxVbN+B/
 KFW94YoR3A/swB8qY8XIBvGU6YCk08IhZMUsO5wS6gsqaH/Ih8ZSR+Uaj/N73FqO+H45
 eLvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe5dSKltzNRFbEiAgOqLywogzCoYhQjDdxVhTT5iSQOfOJOVK/cNW+IbpqZ6KrdRZ7MdfBN2JVtZhE@nongnu.org
X-Gm-Message-State: AOJu0YzNnQzUdcy55P+PpZG2lHA6uCKw75wt27qL4RBT5Li33Ov8vqqh
 zt2Pt5LfHGCtpTG0hkjJEHuIJML6LNm5tUCphnEiig+K4aF5yyW3iv0YHb/dN1Ua+xjZVVo9u0S
 IMukoX3pIscV3BnUfCKfQ4YdcnIQM2IPdzRtEBczUUvZLTXJFeSIL
X-Received: by 2002:a05:600c:1f91:b0:430:57f2:bae5 with SMTP id
 5b1f17b1804b1-4327b7eac96mr194924585e9.27.1730891422265; 
 Wed, 06 Nov 2024 03:10:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5t2CdYR3whYIY9T54GngfEhiEu13B6YrlqhLfYUoJEfWEy78Qf0gLOZKdNi2nL7xj3+VGRw==
X-Received: by 2002:a05:600c:1f91:b0:430:57f2:bae5 with SMTP id
 5b1f17b1804b1-4327b7eac96mr194924335e9.27.1730891421819; 
 Wed, 06 Nov 2024 03:10:21 -0800 (PST)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e725dsm18817890f8f.56.2024.11.06.03.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 03:10:21 -0800 (PST)
Message-ID: <6d6466b5-1d6c-49b3-abb0-f268aa617c6a@redhat.com>
Date: Wed, 6 Nov 2024 12:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] s390x: Add Full Boot Order Support
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel@nongnu.org
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <7800f880-d362-40b6-aaef-2085dcb78ad0@redhat.com>
 <c5bff27a-0aae-4356-9403-89d126426610@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c5bff27a-0aae-4356-9403-89d126426610@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/11/2024 17.42, Jared Rossi wrote:
> Hi Thomas, Sebastian,
> 
> It looks like this is simply caused by the "is_cdrom" value only ever being set
> to true.  I think it is a one-line fix that just makes sure to initialize the
> value to false each time we try a new device:
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a4d1c05aac..3fdba0bedc 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -214,6 +214,7 @@ static void boot_setup(void)
>   static bool find_boot_device(void)
>   {
>       VDev *vdev = virtio_get_device();
> +    vdev->is_cdrom = false;
>       bool found = false;
> 
>       switch (iplb.pbt) {
> 
> I tested it with the two scenarios you mention and with the existing qtests,
> and it seems to work correctly now.

Agreed, this seems to fix the issue when all devices are properly marked 
with bootindex properties. But it still persists in case the BIOS has to 
scan for the boot device, e.g.:

qemu-system-s390x -accel kvm -m 2G -nographic \
  -drive if=none,id=d1,file=/tmp/bad.dat,format=raw,media=cdrom \
  -device virtio-scsi -device scsi-cd,drive=d1 \
  -drive if=none,id=d2,file=good.qcow2 -device virtio-blk,drive=d2

Isn't there a better place to set the is_cdrom variable?

  Thomas


