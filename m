Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6CBC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 06:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtQS-0008Nj-Os; Fri, 30 May 2025 02:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKtQQ-0008N6-3O
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKtQO-0002ee-3W
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748587263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=30vzHzoT8CR5e+wth/rC2ifkhVU0gf51OjRUcYZfLnM=;
 b=HHsC1+6yD2iE8sJuM6zh+58tQVdQjdvuznku/ITeKI1TnM8ibG/2ewe7VDpq2zREUkdeGV
 iTo+Nk+kKRHPLPAB6fhMgkbnZc0wXzUh4effe2QHJfj7SABxX5OpFZ2pMYV2goeB9in1JN
 d3NHVTq6zBZ/K8Yq3yH0dEILBD0/zWU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-dKVxd7DBPiOy5QUou6DyaA-1; Fri, 30 May 2025 02:41:01 -0400
X-MC-Unique: dKVxd7DBPiOy5QUou6DyaA-1
X-Mimecast-MFC-AGG-ID: dKVxd7DBPiOy5QUou6DyaA_1748587260
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad8a2dc92ddso121882266b.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 23:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748587260; x=1749192060;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30vzHzoT8CR5e+wth/rC2ifkhVU0gf51OjRUcYZfLnM=;
 b=lwMiYPQ84qQzOl+zaIO5WRB9toL0Fgylde16iMaTNGaWTTXlU7u4zMeww5MSJaDbCT
 oNi00jmfcGnbnOLvOTFbW+J6nTACf9nSx8OKr/wN6nBNed4fJMkpPtHWzWTFygLp12XG
 q4lxvYeGIn1FIH6Z2WbroqEGn64MLja0w+Iv4u1qr1Itd4VSgDxWSTb/dT63+KoEF/UV
 gGaoy1mHJx8Goyy+Cttn9BORJ5nllIteCvR/DFEpNsPs8TlePKchtCqtItNClNwZmZrW
 C2reaA/4rhzF+GaiH7Asu6hnceZNSKSj9AZlputMGKb1Qlr/Mc5vGgED/F+sgq4mqO9u
 QgSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz+5yO302LW7R+1vePuA0aTDuV7UcJPFZAqvbl3EITEz+uJUF+Z5hwJCcJuBiBTsy6B5yrDwRCXu+h@nongnu.org
X-Gm-Message-State: AOJu0YykqY2XnZIia885/0ShBOR0cenv4EtIDNKji6DZQqexJ3bwlhFx
 Obmexh2mcagdNiOJSHOU06pg8N45zPpi0jDcO+19TAAIXiiwM0tgx1tsPfvI7a4sT+1tCBUzuua
 kHVU63mrVR1ILngh8a8OuuO6tQO+e7IUELYFYCLv/zNS3r/k4hVbK+j4k
X-Gm-Gg: ASbGncsDx1eI6QW7Sm7gCQjzPeTqsmuGHtI/U4mFXqxacBezs9DePp1jb7Xo5P3nyxw
 jtwXb1FqoZWZ+ub9LNqUailjz+hTnjL2QjXganL5jKVCjGIIuAqLe1LPoq4oG/cI5oAk9QM638R
 Wj27cnDsQlGzpqRRvw2UAdA9rBoasnRuQv5UDe1Ysh/VJEIC2EqmZRnJ8Qmc0GvxS8bfXQZ/2b6
 aUIuIj0+FbLqsYfBHSO6HiyItK+5H2p3ePD9xXeAIwvg7ENkMRQIlGpDaZz2m3ARDCDsZWII6hv
 iTsC8Da7JieLT03ack4+9IWECU8H1krrCorXWtLW0z4yV4NNvEt2gjNWKJW6l7s=
X-Received: by 2002:a17:907:2d14:b0:ad8:99cc:774c with SMTP id
 a640c23a62f3a-adb3244d36fmr209683166b.58.1748587260368; 
 Thu, 29 May 2025 23:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOzZQodEaSWccSRPmDhNo1nxS0gard5BW+HGNQ4wyDOYhwfh27+IfNFOthEllEQ6tXsPTNFQ==
X-Received: by 2002:a17:907:2d14:b0:ad8:99cc:774c with SMTP id
 a640c23a62f3a-adb3244d36fmr209681066b.58.1748587259930; 
 Thu, 29 May 2025 23:40:59 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2a762sm1146111a12.4.2025.05.29.23.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 23:40:59 -0700 (PDT)
Message-ID: <0daf1791-e44e-45a5-ab68-55a3cc0c6f6a@redhat.com>
Date: Fri, 30 May 2025 08:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: fix 240
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250529203147.180338-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250529203147.180338-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/05/2025 22.31, Stefan Hajnoczi wrote:
> Commit 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
> removed the limitation that virtio-scsi devices must successfully set
> the AioContext on their BlockBackends. This was made possible thanks to
> the QEMU multi-queue block layer.
> 
> This change broke qemu-iotests 240, which checks that adding a
> virtio-scsi device with a drive that is already in another AioContext
> will fail.
> 
> Update the test to take the relaxed behavior into account. I considered
> removing this test case entirely, but the code coverage still seems
> valuable.
> 
> Fixes: 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/qemu-iotests/240     | 2 --
>   tests/qemu-iotests/240.out | 4 +---
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> index 9b281e1dc0..f8af9ff648 100755
> --- a/tests/qemu-iotests/240
> +++ b/tests/qemu-iotests/240
> @@ -81,8 +81,6 @@ class TestCase(iotests.QMPTestCase):
>   
>           self.vm.qmp_log('device_del', id='scsi-hd0')
>           self.vm.event_wait('DEVICE_DELETED')
> -        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
> -
>           self.vm.qmp_log('device_del', id='scsi-hd1')
>           self.vm.event_wait('DEVICE_DELETED')
>           self.vm.qmp_log('blockdev-del', node_name='hd0')
> diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
> index 89ed25e506..10dcc42e06 100644
> --- a/tests/qemu-iotests/240.out
> +++ b/tests/qemu-iotests/240.out
> @@ -46,10 +46,8 @@
>   {"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
>   {"return": {}}
>   {"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
> -{"error": {"class": "GenericError", "desc": "Cannot change iothread of active block backend"}}
> -{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>   {"return": {}}
> -{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
> +{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>   {"return": {}}
>   {"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
>   {"return": {}}

Thanks for fixing it!

CC: qemu-stable now since this was also in the 10.0 release.

  Thomas


