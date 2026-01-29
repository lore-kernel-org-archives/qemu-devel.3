Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F13D358FB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPJk-0004hS-4t; Thu, 29 Jan 2026 05:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlPJh-0004bl-Uy
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlPJg-0001RT-3A
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769682717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e6watJyihO1nbHDHgQ1WkdCViM6FWfRe9wa3amZigP8=;
 b=cCgKJMYs15Hhj1jc5A8FJFyzee67sKoj0mvBc4MKw5tSIQUzJ4f+iFvwnseK4itAPb0He/
 6TcrilLZ9LluYLwdO0D9/mUSBthD8arnATPngnPgJvI/k8fJOYwMPdPKG2eC7fx2ttPZNO
 mFZDYVj8epLMNmSOjZL/mZK5gm/3dts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-NxZ3upizMYijzsL6OgRgAQ-1; Thu, 29 Jan 2026 05:31:56 -0500
X-MC-Unique: NxZ3upizMYijzsL6OgRgAQ-1
X-Mimecast-MFC-AGG-ID: NxZ3upizMYijzsL6OgRgAQ_1769682715
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fd46385c0so554465f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769682715; x=1770287515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=e6watJyihO1nbHDHgQ1WkdCViM6FWfRe9wa3amZigP8=;
 b=CvqLFyUneD5bAsQ+tSKyrvfWwMcQHQ0hb8/w2NRbUT8aQ6hLp+VARmNH6x8SyFhSwc
 F91Cj0wQYat78PTsXsIJK7eAAYv+qaZFsfWq4IQ8NdV5RpUTEH3LV/irdRMchWozILju
 4qOH3SaO28GVvn2J3k2JqmXn7Ou5qqGhtxdLZPXWsYOokNUv3f1C1tjLdlfUVBP+7fsS
 Lu1eO2Xg2sXWqlTvYjExTpwabpfyzmJxL1J3oBfXVaWCTksUELuw8W9sfBRk/8zMoR4A
 Y+W7WPL8A+v72GTct69xDbevaCnIQpNvAp8lfaQ9vtT+eQ5dosznNOH05JePleLB5AUR
 p3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769682715; x=1770287515;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6watJyihO1nbHDHgQ1WkdCViM6FWfRe9wa3amZigP8=;
 b=H19/4jubfhY3PaErtSM1mVXM0Mmp+jjRtl8vIlw3xb9TKv7tbECCKs5IoWF28AWDLg
 zQksaFngA9dJ47CdFx0YmT18uED5mMDSh//DrALY3Kd3OzHEWpLsAotV61BfhZB3m8un
 EXyYxsMjs9OnTyfbI2M+nRfr1GnF+PerIx5gKBiuLqWTcMUboabR+LIddxi7FwbU3Ji3
 ds1mVWBJEY6hb5nMRzXhj6s59UFqUP5sB+hZDsbhAzPjejDnf/sNv3Z8UT/GlN+jOsPu
 QZ4TTggcmLHfxnXalpPo8X69nkTiLeQAKUS/eEXZwvQkcDyv947ukMYuBLOyzfV+ZCoK
 05cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEo2e52qVuNGN2PH/MzlkZ2pK3L+13nkwTyznE0hO2wov+T72BVSpa+C/gv7MrWpL9e3+7lqJ0Gzis@nongnu.org
X-Gm-Message-State: AOJu0Yw7OTKiA8zBvIuQf3kJNxQh1EbmV7A7OMXNTwaJsu0lyVqsJxr+
 KkS0uj5hBcRHUopR09yb/bikETYHlzks5hvk5rnLHnUZgh4hK00L8Wz2P2+gNzdXU/UwAkaYMcw
 RO+9LsMtYgwTaS0YX+zuNYNOmzhQLjqmS4y6jteWMxlVXT79ShUfw12ss
X-Gm-Gg: AZuq6aJHKiV/6W1oehxVbJsLbL5jIYjRv2f40LCR017n762r1lMoczn2GSFwUiqWVQP
 m3KDgyU6a3y22UB1CLnOirFRutGfbZH5hCVOB6kZjc0G4cTDCHsH/E86lK34Vp41dYcrrNSCbii
 3Hr/foRjKYtkyiAIyo5zIit/hnMUlBqK8O1Os514OZhrXG4BssPb0RP/NRDOfTjRIjQ7hgxCUMR
 TsIEPXqY/TxezuJzUdXqNhmvlXhmHp/aCwLu7SMcBFZ3qpb6s4z0mYqbWDKZd/ofcVpSnzdHr1/
 0tF5Lzb3FjAhaxzyMArgMLPHp+fq2yVG85nAaffNZwDnTuzIe7aq/Tp/Py22f8lU7FJ1t4USH/U
 B/ee1eXs=
X-Received: by 2002:a05:6000:401e:b0:431:74:cca with SMTP id
 ffacd0b85a97d-435dd0b29fcmr11373368f8f.44.1769682714835; 
 Thu, 29 Jan 2026 02:31:54 -0800 (PST)
X-Received: by 2002:a05:6000:401e:b0:431:74:cca with SMTP id
 ffacd0b85a97d-435dd0b29fcmr11373341f8f.44.1769682714409; 
 Thu, 29 Jan 2026 02:31:54 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee040sm13467504f8f.11.2026.01.29.02.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 02:31:53 -0800 (PST)
Message-ID: <a21c41cc-3da9-4820-9980-023a8e197fbb@redhat.com>
Date: Thu, 29 Jan 2026 11:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] pc-bios/s390-ccw: Remove redundant vring schid
 attribute
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-3-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The schid is already stored as an attribute of the VDev itself and any other
> instances are copies of this same value.  To avoid CCW specific attributes in
> the VRing let's just access the existing VDev schid attribute as needed.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
>   pc-bios/s390-ccw/virtio-net.c    | 2 +-
>   pc-bios/s390-ccw/virtio.c        | 9 ++++-----
>   pc-bios/s390-ccw/virtio.h        | 3 +--
>   4 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 4b819dd80f..019c2718b1 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -42,7 +42,7 @@ static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_add
>       /* Now we can tell the host to read */
>       vring_wait_reply();
>   
> -    if (drain_irqs(vr->schid)) {
> +    if (drain_irqs()) {
>           /* Well, whatever status is supposed to contain... */
>           status = 1;
>       }
Just a thought: Maybe we should rather get rid of the global access to the 
"vdev" in the long run (in case we ever want to deal with multiple devices 
at once), so it might be nicer to add a "VDev *vdev" parameter to the 
drain_irqs() function now instead of making its parameter list "void". 
Anyway, it's just a thought, we can also still tackle this later if needed, 
so I'm also fine with this patch as it:

Reviewed-by: Thomas Huth <thuth@redhat.com>


