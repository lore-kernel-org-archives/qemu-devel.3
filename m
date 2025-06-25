Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F12C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQIr-0008UG-5C; Wed, 25 Jun 2025 09:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUQIl-0008TR-Bu
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUQIg-0000BD-U8
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750858587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7BCOCbzDm2MeCoHk5tQ3Cz/favCS5gp+hfXzv3pgbN0=;
 b=UFGGbMh60n2w2GZapgtSphvm3X5YUobpVU79Y4ABNrOdfqogwtFGPt5OADpONtED+Uc0ij
 kew+QDM5/jIkBMTgZMFKnzrxEhcVCZOFbFidnXtG+QFJdjtrOryfM3r7TCDUKLxmVpfD0o
 PAoSRHw1oUaa1NcZGjUdwSb3oDA09aI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-KEOABmNVMkKJdkIDpATDzA-1; Wed, 25 Jun 2025 09:36:25 -0400
X-MC-Unique: KEOABmNVMkKJdkIDpATDzA-1
X-Mimecast-MFC-AGG-ID: KEOABmNVMkKJdkIDpATDzA_1750858584
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so55882555e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 06:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750858584; x=1751463384;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7BCOCbzDm2MeCoHk5tQ3Cz/favCS5gp+hfXzv3pgbN0=;
 b=Ts+dUu8ClwbJiXnZY1f4jNxxpXdk4YQAF8hrkwoB6imk7vqcJEasxcVcsHaojiJYfm
 ReG7+SUJnrKaV3dlU+QJ00LsA+eN1n9G3mV4lIlm28ic2r+urcAXoEMqE77hYL7J2lUc
 zS+zz5DtB49m0eofnaFrZkUCPXwhYsVWuvXbudvU4YWmMglFY3exo5ZiWT2ZYKfMPxZ7
 04CZCxO6YsKNPxXLgvY2t/852gLHsUfZKw6Fz8O3b2up1d7u/uczwyOOGwBv3jvyqBs4
 t1PvDYkIjXYjR6buidjlb4def22nrIWaKmhV8kbcY9az/uc9q8rPZqKmlc7YCAck6VY/
 eU6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeDIKAGZupXn2Sl2Umgf7ETRjwrxsXSxR1PAJ12AKAh641q/aTLieFwLtL5e13HEPY9pEyxB+yvidt@nongnu.org
X-Gm-Message-State: AOJu0YxLp5z7zpb0qvz1giVI6eSasA+dQbgUrE2HJd0rx/Bhp6M/ZkNO
 lZ+VbUh/Ng/xbXRaiyJ5RC/gpkGlxPtCufg4hOoNj6kXbh/RkWgEFh4WJggmg54+piskQpjhOpe
 KG9GP9rMwEkH2p8Ki6Kgs9+nOHdLmoRRPyAAQlGrlz3/Z+SQSXnlb9/Rv
X-Gm-Gg: ASbGncvLaiUNSIlxSIfcx5UVYM7Mb3s+eUemKT1hQcaadxDKGSoeaAGMKbHpfhU/vyS
 BcweXxPF5g2tvlL3TOWI4aM68YmSgCVbPNGsdY/jufKqNrDxTvnl1gSrhBgIu/7a7amWgnL69Q+
 2AMfu9HtLa7NQ6viG0FT201FrpFFWCqeKOVBhzOxXCVUGTAwNiUsVoDMHBmrHs+XEZqkQ9OyXLj
 +QTOL8h5NN5RXxUo8S0DWnYQSgTVvDGNJ2DD5ZFAiB1TbKIhPCEoX3ecnQ30nlGzOYUJ0EV5Zjx
 pCjKLSmyrLosHY2T3mmSPLhuWurMiB/2gPJVloMPc3FwjO4=
X-Received: by 2002:a05:600c:4e8a:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-45381aaff08mr34050665e9.14.1750858584530; 
 Wed, 25 Jun 2025 06:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuDEs0Of6VUXpQBUnPo+0CdAnZU22Y2LYVV5B6kfRufxinoiutzEZHbJnsaZCrwPXMRz3HvA==
X-Received: by 2002:a05:600c:4e8a:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-45381aaff08mr34050285e9.14.1750858584086; 
 Wed, 25 Jun 2025 06:36:24 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45382349548sm20660475e9.10.2025.06.25.06.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 06:36:23 -0700 (PDT)
Message-ID: <0755e5fc-5887-42e6-8400-65418dd4fa96@redhat.com>
Date: Wed, 25 Jun 2025 15:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x/ccw-device: Fix memory leak in loadparm setter
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>
References: <20250625082751.24896-1-kwolf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250625082751.24896-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 25/06/2025 10.27, Kevin Wolf wrote:
> Commit bdf12f2a fixed the setter for the "loadparm" machine property,
> which gets a string from a visitor, passes it to s390_ipl_fmt_loadparm()
> and then forgot to free it. It left another instance of the same problem
> unfixed in the "loadparm" device property. Fix it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/s390x/ccw-device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index 19c2238f76..8be1813b9e 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -57,7 +57,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
>                                    Error **errp)
>   {
>       CcwDevice *dev = CCW_DEVICE(obj);
> -    char *val;
> +    g_autofree char *val = NULL;
>       int index;

I was able to reproduce the leak with a command line like this:

valgrind --trace-children=yes --track-origins=yes --leak-check=full \
  --show-leak-kinds=definite ./qemu-system-s390x -nographic -accel kvm \
   -drive if=none,file=/tmp/disk0.qcow2,format=qcow2,id=drive_image1 \
   -device virtio-blk-ccw,drive="drive_image1",bootindex=0,loadparm=4 \
   -device virtio-scsi-ccw

And I can confirm that your patch fixes the issue, thank you!

Tested-by: Thomas Huth <thuth@redhat.com>

I'll queue it for my next pull request.


