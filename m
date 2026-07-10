Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A207C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5ny-0000zo-9u; Fri, 10 Jul 2026 03:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wi5nw-0000zd-S2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wi5nu-0007d4-SY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783669064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgZmUfYDVV54E+bvl7OuDJJ7IZEJ9yLm3bm2KVdRi7o=;
 b=UPamX4ORZDyW/R1ODQfAme+E/NoeI9lwZEbmeifN6OybDfwLfRJWgBEGeJFOP9D6XJzFzr
 O6S8TbwsonaXVhYjc94f2qbtmnVJQEGc3x7MryyZygdYaEXUwOLZw4ftKLYOlTLGP9LUpL
 +37XWpDUb0b3RSwEBaDBnNmspFL/L/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-2WmG_0GePLyt8kwFI5h1Vg-1; Fri, 10 Jul 2026 03:37:40 -0400
X-MC-Unique: 2WmG_0GePLyt8kwFI5h1Vg-1
X-Mimecast-MFC-AGG-ID: 2WmG_0GePLyt8kwFI5h1Vg_1783669059
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4731a357b0aso628960f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783669059; x=1784273859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BgZmUfYDVV54E+bvl7OuDJJ7IZEJ9yLm3bm2KVdRi7o=;
 b=KRzG8uPQ7JKtCOAZpD45Wx8cpZGIxofcCs3SDc+AfZ3SOLrIqd9rwjuqy3zcXeYmqq
 IXILjRHnBie5ZV0ZsJpNBym8GeIt2lpEUz0Xe2nvQW3andio4tMjT/RBkAx7DnU5tIcy
 p8fce30Yb6ETc9BQ2rgOK8jc8MBhnoZ6QqQtTZAW4vr8PH9R0fKeakPykexkZMWjIeZP
 p5EX0L0Qco3e7CFn0wVgUXyz7tE9cg2rkz4rlJys4a/YZD5E/wdjm66Q1DwIsK86t3sK
 xYyBLFc0y/QchOEG8wSUMrObFctxpqkIn/CZPjYlFituYIHNdRFBJ1E7PiTNhi9bmxH9
 e/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783669059; x=1784273859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BgZmUfYDVV54E+bvl7OuDJJ7IZEJ9yLm3bm2KVdRi7o=;
 b=WB8VL3kGPxysZLYlAfeYQGVuh47Wlo9xU6HlGYaUgRTqEN44A77jhtbvUkRPLheMhK
 lI7XjfVT80kBaOiQ/XxnSu1zlluBz0nFR9Go9Mw9fcTHKG1xAHbM31xpuMJO6YxNG40k
 uGxYzc5lxV+Pi6aQv2IRXxaaw/djrm4wzZvyemcdGKmZgSv60JYjZdNfQI9XEECBiGGA
 uJjkALatAan4ZgOClMN2ZArIqmvo4Ed27hL+jEA8hI4cPWBjHSimPVCOBuJJUDEcY/3t
 pXo2goRcCxBCdjv0bnhO7XCdsP25GWdE6/kYNCSG9mjVbRKJDSLSpCY/E48q+tS/LbyC
 2Brg==
X-Gm-Message-State: AOJu0Yz5ERbBeihgrq3C0xg1Vtmfj276hxBbGMA1OngWlEP/4I13OVrf
 IIYJm7gB4BgOPc02lXF84/GVNpPnWHCvA8BhUkpVOPf3FexIIuI46igRFB0R8++87mcUHGnXinJ
 AOYA2tRoYTfss7tTf5ivUMipgTd5pUBHNwGUkWruTnYK/nO2zUvhiweSR
X-Gm-Gg: AfdE7cni6PhRg0uSFWA7wolrQUQm4Up4kqe2dswD4S8diHwdLsjJ0qaNq80jBcI1zZo
 HqcOxp9PBjPs9kcDWF6y/uSDLylMH/MI0XUbetcIaniTdGOyxCctpFGJA1FAkLipNIh9OK9M7rs
 YfqpIIXihSShdEWqlyTofCAn7hnHhdw/DvKkSFla/tDoxWddmRO44PSwc/T8xC4oAgjBZJtJC40
 3PEOI6MFUuUYuHJ3ylFgVXw3pEB16ZU6cld9h+7GAlJXguCA8zVQSgLpqVAqEQBlmb6GAdwGUuk
 h1rHI2pnZZnnxLLVSUILfTD8aM0zUITsNVby+1KRJ9itTdHSv3Lh4uOrTvgxbB2yEIhJmA4=
X-Received: by 2002:a5d:5f88:0:b0:475:2171:add with SMTP id
 ffacd0b85a97d-47df072e297mr11282199f8f.22.1783669058981; 
 Fri, 10 Jul 2026 00:37:38 -0700 (PDT)
X-Received: by 2002:a5d:5f88:0:b0:475:2171:add with SMTP id
 ffacd0b85a97d-47df072e297mr11282174f8f.22.1783669058598; 
 Fri, 10 Jul 2026 00:37:38 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960af0sm53097288f8f.30.2026.07.10.00.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 00:37:38 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:37:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Jia Jia
 <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Message-ID: <20260710093737.4948ded4@imammedo>
In-Reply-To: <d07de8d7b33fbbdd84909c21b67156fe564dc050.1783604079.git.qemu_oss@crudebyte.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <d07de8d7b33fbbdd84909c21b67156fe564dc050.1783604079.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 9 Jul 2026 15:50:36 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Harden security by disabling hotpluggable property, to prevent
> issues like fixed in the previous commit.
> 
> Virtio-9p is a pass-through file-sharing device that provides a
> guest mount of a host filesystem tree. Unlike block or network
> devices, guest-triggered hotplug of the 9p device has no practical
> use case: the guest cannot recover from the device removal, and there
> is no protocol-level device-loss scenario as with block or ethernet
> devices.

hmh, I'm no maintainer of 9pfs, but to me it looks like any other
storage device.
One should be able to unmount/stop using it and unplug
(it doesn't really matter if unplug is triggered by guest or host side).

> Prevent guest-triggered hotplug by marking the device as
> non-hotpluggable. Device removal via QMP is not affected by this, as
> the QMP removal path is not reading the device's hotpluggable field
> at all.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/virtio-9p-device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 1ec48fc9e0..ba43fd22d2 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -273,6 +273,7 @@ static void virtio_9p_class_init(ObjectClass *klass, const void *data)
>  
>      device_class_set_props(dc, virtio_9p_properties);
>      dc->vmsd = &vmstate_virtio_9p;
> +    dc->hotpluggable = false;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>      vdc->realize = virtio_9p_device_realize;
>      vdc->unrealize = virtio_9p_device_unrealize;


