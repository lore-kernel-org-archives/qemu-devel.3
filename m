Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2B0C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6Z-00084E-UW; Tue, 11 Feb 2025 11:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tht65-0006sG-5K
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tht62-0003U4-Lq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739291209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ag7/kcTmaUTRSM6LCTBcCbtLWMglMNq0WLwQy0Or26E=;
 b=gxqpBldNMjC5iboHi2L0ONV/vfqiUuX3ENU5fW8zOxLfyHIvmedCs1k+8fpCD/kPMysUfx
 hzNr5aP2PN8gKJIEN3JnKWZZUd7I+CPrFv8tzsw6qI9gakfjHGZQ9Epc6OFjtdZCtJUxq4
 C4G6H/29RCktTZnNQZcLOLJJlJeOiu0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-6iYNa6D4OD6Ozhd0_MbsNA-1; Tue, 11 Feb 2025 11:26:46 -0500
X-MC-Unique: 6iYNa6D4OD6Ozhd0_MbsNA-1
X-Mimecast-MFC-AGG-ID: 6iYNa6D4OD6Ozhd0_MbsNA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dcd8ddc5eso3001674f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291205; x=1739896005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ag7/kcTmaUTRSM6LCTBcCbtLWMglMNq0WLwQy0Or26E=;
 b=t7oaIIu38XDmFxCDW6gJZIkdjt5KAEpp359c10mvxdGacAZwEOHtiABjdXU8eVgyAl
 fmn1s5fM+N4lTV68XuKX1rZ2bYjTIYDDWxMGRCQsDbxqmS6i83uIxDwMhpXeAgnVLQuh
 /cP696RQf3Od4Bk8BiHkw4pcDNwd84Vn13cys8ARzuQoKqlRGlPYogkM8uDOggUTpkOr
 y44DylSTYhD9F17Asls+11FNePgjFTi5aYVqwSEqcAIkdhYMXnPR1xBC4prmWDQqcagN
 Am8gceXellQ3pRzRTsghon5kPvhRu+IBcgqI2F+T2nERXAWsBSpxPhynWFC0E/qmSMxT
 wFYA==
X-Gm-Message-State: AOJu0YyzcKs2/P3lSq2xiKhYciBhsKkNNWmE4+gy0yUT3iDtHjkoxTV/
 SqRLmWXKlrkR54DBmQsgZmNY/C/JE2xcAkmTvXVO6ok6wKtrw+83864xQf5H13dIBFsSIJtS7sO
 EJQo4GOGTSkVaiAWK0+9L6FqpSZBMpGcuxO1d/iMFEGRZdUZo7Vzs
X-Gm-Gg: ASbGncvz2yarlYFOg+FxIjOuQnYHYTvb2lSuIt19+3vZsab77orRfSPWO44cxN+w8hX
 41ZB3JqHdbQuWE+kWGwjtk5d8IPblbAi85h8wgCPv3IgjCO3xa2t0dQjcVD0TcBMYyCFeSrzzpP
 WY+o+3lmy7yXnrg+CDsH/kTRN+Z5CpjplBJDYSiKOknQX8LvqW6ak30jxv9BttLnPOwOYcL4AL/
 SqpOJ+p+1TCzJf1Dx5JKNYkqFiGUCxWvkfZ1IV6ttJiCg/Vp3uUTK69vdVKXMs5HzHsBQo3JHNV
 hB9zlCA/GApGU9tBzxma+pQiKGqreNGKgjtdorwjIYz1JrH5FWjh+g==
X-Received: by 2002:a5d:5850:0:b0:38d:d118:8b4d with SMTP id
 ffacd0b85a97d-38dd1189408mr13736526f8f.54.1739291204817; 
 Tue, 11 Feb 2025 08:26:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+8OtW7y97gZpe/WvXipk8JHhm/p06mhyuoVWwvTI+QMyndALi668ow53/APRjnvchayGXkQ==
X-Received: by 2002:a5d:5850:0:b0:38d:d118:8b4d with SMTP id
 ffacd0b85a97d-38dd1189408mr13736472f8f.54.1739291204165; 
 Tue, 11 Feb 2025 08:26:44 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbf2ed900sm15117663f8f.53.2025.02.11.08.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:43 -0800 (PST)
Date: Tue, 11 Feb 2025 17:26:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net, mst@redhat.com
Subject: Re: [PATCH 1/1] vhost-scsi: support VIRTIO_SCSI_F_HOTPLUG
Message-ID: <uut6fljzuwk6rwbzmnc7ieftwtyuwdjimehn5frluldt3cqudq@ndvyu6iu4gul>
References: <20250203005215.1502-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250203005215.1502-1-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

On Sun, Feb 02, 2025 at 04:52:15PM -0800, Dongli Zhang wrote:
>So far there isn't way to test host kernel vhost-scsi event queue path,
>because VIRTIO_SCSI_F_HOTPLUG isn't supported by QEMU.
>
>virtio-scsi.c and vhost-user-scsi.c already support VIRTIO_SCSI_F_HOTPLUG
>as property "hotplug".
>
>Add support to vhost-scsi.c to help evaluate and test event queue.
>
>To test the feature:
>
>1. Create vhost-scsi target with targetcli.
>
>targetcli /backstores/fileio create name=storage file_or_dev=disk01.raw
>targetcli /vhost create naa.1123451234512345
>targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/storage
>
>2. Create QEMU instance with vhost-scsi.
>
>-device vhost-scsi-pci,wwpn=naa.1123451234512345,hotplug=true
>
>3. Once guest bootup, hotplug a new LUN from host.
>
>targetcli /backstores/fileio create name=storage02 file_or_dev=disk02.raw
>targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/storage02
>
>Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>---
> hw/scsi/vhost-scsi.c | 3 +++
> 1 file changed, 3 insertions(+)

LGTM:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


>
>diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>index 8039d13fd9..d3a260f6a7 100644
>--- a/hw/scsi/vhost-scsi.c
>+++ b/hw/scsi/vhost-scsi.c
>@@ -359,6 +359,9 @@ static const Property vhost_scsi_properties[] = {
>     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
>                                                  VIRTIO_SCSI_F_T10_PI,
>                                                  false),
>+    DEFINE_PROP_BIT64("hotplug", VHostSCSICommon, host_features,
>+                                                  VIRTIO_SCSI_F_HOTPLUG,
>+                                                  false),
>     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
>     DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
>                      conf.worker_per_virtqueue, false),
>-- 
>2.39.3
>


