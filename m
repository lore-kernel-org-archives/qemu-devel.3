Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F066CD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 11:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slQXv-0002Qs-Ud; Tue, 03 Sep 2024 06:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1slQX2-0002Mt-75
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 06:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1slQWQ-00082c-Px
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 06:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725358291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txwN6RjZve6g0ayM7naxYo4Xm12eUr5K9g2/bl2gMXI=;
 b=ChE7QARDu6rBVft+mFrglpj0S1e28hRJJrdRYA9JQwM2Dys3d40HMue7WiYq0avTgxVLYm
 Ih5yqsqGdi46nn/B+xNsJtC69ZJQfzalWKqIEjITIW9pK7oU9MHbfQxrGvq8dgq3bmU3zR
 CAZx1caA9nGYKj/a0jlHKh/LreRzp/0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-a4_X68tZMra8AoAkuIIs_g-1; Tue, 03 Sep 2024 06:11:29 -0400
X-MC-Unique: a4_X68tZMra8AoAkuIIs_g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c358223647so33482876d6.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 03:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725358289; x=1725963089;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=txwN6RjZve6g0ayM7naxYo4Xm12eUr5K9g2/bl2gMXI=;
 b=NuMLmtc+NKpCSLoUmYZ/ABMAhfWffNUs79xe3fi7TY3xNsaM/lI2Hr2QeKYZDuVxCq
 jYhf8TasG9TczIi/03U7EBtxzL8AYFil7aUvyFZN+Zm60zKZeaZCMxonyHjjnKKbekui
 jxcnMrs4jpvGOjdGNmpdudGJOjyQ97HR2QAdBeTt6NJSzsCLokY9yMULZZWFqFze+roe
 U7abGMqHh/wfhBoeTv3qk/GuDKw5nQZyepQ4RII7AHv+mx16TDYKxIZLfRvDdvfcZNxT
 DcUCKnorFAEcRxMyqtxLH3fwzy1DVSRfmCsBbK+v20Y/s6NJdP50aLSDwXQGhyQjZdxN
 iiYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVHNYExErIVjpM4J1d37L+12si19gX4z90ISu5kHwkIxgMmglz3m00HrmDpp4uciID0kOVrKgKRogU@nongnu.org
X-Gm-Message-State: AOJu0Ywsy6L1gGBzFgW4RiBqsE2zTo3Tbw1W6mo0qheHxj5irIwlPFGM
 w670fG6CN7nROSLAFhlrFZAsYvt46qjOOc2EPeGlhDFRqZrITOHGL6ufnqcH+pSxiY2cOSDJT/X
 jJDo9s8gANTdK+gZA16hKgm7yKoCZ2+Vfzs9Wma9heUivYYN6uAwS
X-Received: by 2002:a05:6214:5d91:b0:6bf:9076:3315 with SMTP id
 6a1803df08f44-6c355684c93mr90718066d6.13.1725358289499; 
 Tue, 03 Sep 2024 03:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGglw/2Y1dO2dHZsvR3pT5+KwqmJ1lLK1dBt3hDJRJv1Rabpj+WffQV1m58gWaonyyhhmlJYw==
X-Received: by 2002:a05:6214:5d91:b0:6bf:9076:3315 with SMTP id
 6a1803df08f44-6c355684c93mr90717836d6.13.1725358289053; 
 Tue, 03 Sep 2024 03:11:29 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.98.235])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c35129ed82sm39043866d6.66.2024.09.03.03.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 03:11:28 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:11:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, "Zuo,Boqun" <zuoboqun@baidu.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH V2 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Message-ID: <mu4hif4l5f2di4yk3asmyoloeqdexm2wgxfsna6ddaukfztec7@6lzpcwyctveh>
References: <20240820115631.52522-1-gaoshiyuan@baidu.com>
 <qrb7lbdypu2ctim57dxn7copcbmclpxnb4k2uadnm5v6ehawwc@xzhkhvs46xhw>
 <9766b5a2ca8c43f3be60b2bfd0fc5226@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9766b5a2ca8c43f3be60b2bfd0fc5226@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Aug 29, 2024 at 01:13:43PM GMT, Gao,Shiyuan wrote:
>> >--- a/hw/virtio/virtio-pci.c
>> >+++ b/hw/virtio/virtio-pci.c
>> >@@ -610,19 +610,29 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
>> > {
>> >     int i;
>> >     VirtIOPCIRegion *reg;
>> >+    MemoryRegion *mr = NULL;
>>
>> `mr` looks unused.
>>
>> >+    MemoryRegionSection mrs;
>>
>> Please, can you move this declaration in the inner block where it's
>> used?
>
>ok, I will move to inner block and remove unused `mr`.
>
>>
>> >
>> >     for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
>> >         reg = &proxy->regs[i];
>> >         if (*off >= reg->offset &&
>> >             *off + len <= reg->offset + reg->size) {
>> >-            *off -= reg->offset;
>> >-            return &reg->mr;
>> >+            mrs = memory_region_find(&reg->mr, *off - reg->offset,
>> >len);
>> >+            if (!mrs.mr) {
>> >+                error_report("Failed to find memory region for address"
>> >+                             "0x%" PRIx64 "", *off);
>> >+                return NULL;
>> >+            }
>> >+            *off = mrs.offset_within_region;
>> >+            memory_region_unref(mrs.mr);
>> >+            return mrs.mr;
>> >         }
>> >     }
>> >
>> >     return NULL;
>> > }
>> >
>> >+
>>
>> Unrelated change.
>
>Perhaps this would be clearer but not universal in Version 1.
>
>Without this patch, Only lookup common/isr/device/notify MR and
>exclude their subregions.
>
>When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify MR has
>host-notifier subregions and we need use host-notifier MR to
>notify the hardware accelerator directly.
>
>Further more, maybe common/isr/device MR also has subregions in
>the future, so need memory_region_find for each MR incluing
>their subregions and this will be more universal.

I see, I don't have much experience with this, but what you say I think
makes sense. I would wait for a comment from Michael or Jason.

Thanks,
Stefano

>
>@@ -610,13 +610,22 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
> {
>     int i;
>     VirtIOPCIRegion *reg;
>+    MemoryRegion *mr, *submr;
>
>     for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
>         reg = &proxy->regs[i];
>         if (*off >= reg->offset &&
>             *off + len <= reg->offset + reg->size) {
>             *off -= reg->offset;
>-            return &reg->mr;
>+            mr = &reg->mr;
>+            QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
>+                if (*off >= submr->addr &&
>+                    *off + len < submr->addr + submr->size) {
>+                    *off -= submr->addr;
>+                    return submr;
>+                }
>+            }
>+            return mr;
>         }
>     }
>


