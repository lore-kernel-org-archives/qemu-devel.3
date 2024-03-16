Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F1DC54E5D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 15:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlWEb-0003xv-GN; Sat, 16 Mar 2024 11:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1rlWEZ-0003xc-6y
 for qemu-devel@nongnu.org; Sat, 16 Mar 2024 11:46:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1rlWEU-0006JH-6X
 for qemu-devel@nongnu.org; Sat, 16 Mar 2024 11:46:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4140aadfe2eso132985e9.1
 for <qemu-devel@nongnu.org>; Sat, 16 Mar 2024 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710603959; x=1711208759;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a9gA9pAkbYWZhIoKitajuYItNdVaHTbx3SAp1P6Gr9c=;
 b=KUOobhuVOgiUfX3QIVOjQyzDbDlDKH61bmcmxvKjx24PQ14IRnI1RJ6Ed207A8DLWD
 +VQV3vqWfWfFVj7YUOgd2sc5OHTSOzoUt8IAJzQ3rAZxzwzd0yGcoNAdQ3G0dfxRbyeb
 zKuz+v4US7Yw/BSI4KoSrj865cRcCyndths72I5BPFSF9T++ToQi1J9xwab6rLnFb1xS
 tglM2D4b9Z+o95hOh/7Cy//P9Uk1U5CFYRtauAspMynBQHp5q4RH6ehwxE9bjYdpaHQz
 vGwByLwYWq473HauMnlUkWePsQUZ2Mr6T3q6NcmBa54154o6W6jVvYe3btUHYBo9sSly
 5WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710603959; x=1711208759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9gA9pAkbYWZhIoKitajuYItNdVaHTbx3SAp1P6Gr9c=;
 b=h1r1qXrEpmAbN20+lCb1wXLBrWy8tnmJzHUUb85r/tOlb/V0IQMTUnUTO6n1YM1mkp
 4d/d8dC0Nr9QAQtx8AZ8zswPY7cv7Ig5ARyhco1Jy5tdw2eFgnD9A7g8kg/h7YQH04Er
 VuQKhM5++Ynq2jcDfxZfwBTE2lixVQPftkXjrhCfGZGy6yZ3xalr+8AfTuGxyb4rdjoj
 YnNVRH/wcgTm7GHnWyYWOw0YAymzOKpRU0CFQGFGv1gd4KgygQSZZAaLjsJB1FaPKdoB
 aHa10EmPmjsN3HbEvQin5Ce4hg6iNEIoE8SIU0AQ9N9+00Hlr++NRM3qRM9wo6jv77++
 B9oQ==
X-Gm-Message-State: AOJu0Yz9qCHbc5l0VLIR3b1jNdD+HFMIIza3sauqLpT1cqI7CqqTeWcx
 W+nRlwmol6UAYxJqWnWSBlb9MeVIU2gWzu83YLGTgiVyN+SDf0TWHThDgYmbB6I=
X-Google-Smtp-Source: AGHT+IFbL4Jarq6zMgJpaIjJ0+QKwEPuFFx5dnUVw6RP/Q1oZlB6JSXt2hOuQBXOBZts1pLmOFkVJg==
X-Received: by 2002:a05:600c:1546:b0:413:fd44:4f02 with SMTP id
 f6-20020a05600c154600b00413fd444f02mr4572071wmg.40.1710603959387; 
 Sat, 16 Mar 2024 08:45:59 -0700 (PDT)
Received: from localhost ([193.47.165.251]) by smtp.gmail.com with ESMTPSA id
 p18-20020a05600c359200b00413eac2e806sm9228303wmq.29.2024.03.16.08.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 08:45:58 -0700 (PDT)
Date: Sat, 16 Mar 2024 16:45:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 stefanha@redhat.com, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 leiyang@redhat.com, schalla@marvell.com, vattunuru@marvell.com,
 jerinj@marvell.com, dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Subject: Re: [PATCH v3 for 9.1 0/6] virtio, vhost: Add
 VIRTIO_F_NOTIFICATION_DATA support
Message-ID: <ZfW-tO4zXeAWDgFg@nanopsycho>
References: <20240315165557.26942-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315165557.26942-1-jonah.palmer@oracle.com>
Received-SPF: none client-ip=2a00:1450:4864:20::32e;
 envelope-from=jiri@resnulli.us; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

Fri, Mar 15, 2024 at 05:55:51PM CET, jonah.palmer@oracle.com wrote:
>The goal of these patches are to add support to a variety of virtio and
>vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. This
>feature indicates that a driver will pass extra data (instead of just a
>virtqueue's index) when notifying the corresponding device.
>
>The data passed in by the driver when this feature is enabled varies in
>format depending on if the device is using a split or packed virtqueue
>layout:
>
> Split VQ
>  - Upper 16 bits: shadow_avail_idx
>  - Lower 16 bits: virtqueue index
>
> Packed VQ
>  - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
>  - Lower 16 bits: virtqueue index
>
>Also, due to the limitations of ioeventfd not being able to carry the
>extra provided by the driver, having both VIRTIO_F_NOTIFICATION_DATA
>feature and ioeventfd enabled is a functional mismatch. The user must
>explicitly disable ioeventfd for the device in the Qemu arguments when
>using this feature, else the device will fail to complete realization.
>
>For example, a device must explicitly enable notification_data as well
>as disable ioeventfd:
>
>    -device virtio-scsi-pci,...,ioeventfd=off,notification_data=on
>
>A significant aspect of this effort has been to maintain compatibility
>across different backends. As such, the feature is offered by backend
>devices only when supported, with fallback mechanisms where backend
>support is absent.
>
>v3: Validate VQ idx via. virtio_queue_get_num() (pci, mmio, ccw)
>    Rename virtio_queue_set_shadow_avail_data
>    Only pass in upper 16 bits of 32-bit extra data (was redundant)
>    Make notification compatibility check function static
>    Drop tags on patches 1/6, 3/6, and 4/6
>
>v2: Don't disable ioeventfd by default, user must disable it
>    Drop tags on patch 2/6
>
>Jonah Palmer (6):
>  virtio/virtio-pci: Handle extra notification data
>  virtio: Prevent creation of device using notification-data with ioeventfd
>  virtio-mmio: Handle extra notification data
>  virtio-ccw: Handle extra notification data
>  vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits
>  virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition

Jonah, do you have kernel patches to add this feature as well?

Thanks!

