Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A2AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9ZG-0004lF-IJ; Fri, 01 Mar 2024 15:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg9ZE-0004kn-T2
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg9Z7-0004yu-F0
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709325188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JekRTZsMlrf+FEvkqJPtKIxNmwHErCIsbh0T0Zg3mA=;
 b=ODqjVfuzsSL67o/lwyUs7EGPXs9MVe7ATpe7egAb972ZEFCRKhI7/0Yog7e4oP78JMafvp
 N8H9t14mhETYA57CUajc9947p6EY/yAXlP77apNm8N4dTdhBglcmTxtTDvCbfW1vDDSugU
 SU9HKFWjxJ90dd1/1mPOMfhA0vANhfo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-aK0FZuCCNlSYNi-XZ4YoNg-1; Fri, 01 Mar 2024 15:33:07 -0500
X-MC-Unique: aK0FZuCCNlSYNi-XZ4YoNg-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dd001f821caso1146881276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325185; x=1709929985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JekRTZsMlrf+FEvkqJPtKIxNmwHErCIsbh0T0Zg3mA=;
 b=QmLAiUpR143C07HzoC0g4kBTE7X3U4zkeEsjmqqmT55DG7u2o/rxolt6QiL6CsnYvI
 vvE4l8V8pwjscij93HwUuv/eL407DC5St36AjAxtEW9UUWm8U2CS02acQgSYIjhVe3qX
 JZ91xd35P9J+FUU4kcVKGcO585aMjdH/sJsQABVbK1oqAcTTQ3MwJvK3xuH5hSTvLUZS
 XE5826awIkP64q31PwB3ENaOR0hmSJpwjqBm4VDcyNvwKvR6C9Of4Esnq3XMkS/kfuTq
 UrwIPpZqtcEm7AkH5+llPj1L16EN+SqBQg0DQ8TTTVCJSF8S2zSZm1PK6/6WZ4v4axvg
 Q+ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDpAVhXrqiweiqG5z4qYjRVZhPvOoMrypd8Lygyomxn159azbMzapT4ye4cQtTx/5nvsAdX6+Oo4zIfItKmNzUi5HxT/g=
X-Gm-Message-State: AOJu0YzGczngxdktb4tL6yNu4Yqxsu9ybuxBCejNTKDJbceMlS7HhT7X
 nsUG5NktbJ6farNBvIIKlB3aE1+NcjU4CASM0RHlySwPsVkVgIlZ9nqs1iKQy2XPAohlZDYCrh6
 hoPsu8Fv+KSKFtqZ5SrJ83e5c1DO4PmqYDaY5NZ72F1cKP6ytghnTAjcV+W2VNVE6Mf6cpXTumQ
 RR/rZiZAnl8QWb5riVCE3hVicS2iA=
X-Received: by 2002:a25:ba48:0:b0:dcf:9aeb:73af with SMTP id
 z8-20020a25ba48000000b00dcf9aeb73afmr2106893ybj.2.1709325185701; 
 Fri, 01 Mar 2024 12:33:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGebWf+1TXP+6k5ZRJI3Gxcr22nlqFqDK3NKq9d2JbPHvQ5STmvxtAAYyiUDQGCC/9HqwFXhJbf0ttCfq6apRo=
X-Received: by 2002:a25:ba48:0:b0:dcf:9aeb:73af with SMTP id
 z8-20020a25ba48000000b00dcf9aeb73afmr2106869ybj.2.1709325185470; Fri, 01 Mar
 2024 12:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
In-Reply-To: <20240301134330.4191007-1-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 21:32:29 +0100
Message-ID: <CAJaqyWfD96Dh9gVavzC22KuaG4bwJ0m7sbWOsy9fR4y1HJ3-Gg@mail.gmail.com>
Subject: Re: [RFC 0/8] virtio,vhost: Add VIRTIO_F_NOTIFICATION_DATA support
To: Wentao Jia <wentao.jia@corigine.com>,
 Rick Zhong <zhaoyong.zhong@nephogine.com>, 
 Xinying Yu <xinying.yu@nephogine.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 jasowang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, 
 raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com, 
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com, 
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com, 
 iii@linux.ibm.com, cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, 
 stefanha@redhat.com, qemu-block@nongnu.org, qemu-s390x@nongnu.org, 
 virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Wentao / Rick / Xinying Yu,

Would it work for you to test this series on your use cases, so we
make sure everything works as expected?

Thanks!

On Fri, Mar 1, 2024 at 2:44=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> The goal of these patches are to add support to a variety of virtio and
> vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. This
> feature indicates that a driver will pass extra data (instead of just a
> virtqueue's index) when notifying the corresponding device.
>
> The data passed in by the driver when this feature is enabled varies in
> format depending on if the device is using a split or packed virtqueue
> layout:
>
>  Split VQ
>   - Upper 16 bits: last_avail_idx
>   - Lower 16 bits: virtqueue index
>
>  Packed VQ
>   - Upper 16 bits: 1-bit wrap counter & 15-bit last_avail_idx
>   - Lower 16 bits: virtqueue index
>
> Also, due to the limitations of ioeventfd not being able to carry the
> extra provided by the driver, ioeventfd is left disabled for any devices
> using this feature.
>
> A significant aspect of this effort has been to maintain compatibility
> across different backends. As such, the feature is offered by backend
> devices only when supported, with fallback mechanisms where backend
> support is absent.
>

Hi Wentao,


