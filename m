Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB30CDC198
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQ1g-0005ew-9c; Wed, 07 Jan 2026 04:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdQ1d-0005Xc-PP
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:40:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdQ1b-0004Lr-EV
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767778817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fIPG5e//R98QwevC0odLZcGlo0ncOFyKV9+xctEXZTc=;
 b=NKVP/fcFChnMAmlMQPPuO9wstW22NsLTkZ5ChKmwf8OitdXl7ltAY0jdg7UDSXBpLPBJ5J
 mM7c7L/XQJN9j/ohZdidXE2FYfFZQ9yEChaRT7O2/x58VRLQbjAx/li0gLViut/zfSu7b2
 H1y94Q9/cbmmkFYxDYQDO7niT1asx+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-CUotsenoNbO6oxkbtWSdRQ-1; Wed, 07 Jan 2026 04:40:16 -0500
X-MC-Unique: CUotsenoNbO6oxkbtWSdRQ-1
X-Mimecast-MFC-AGG-ID: CUotsenoNbO6oxkbtWSdRQ_1767778815
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47777158a85so23438625e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 01:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767778814; x=1768383614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fIPG5e//R98QwevC0odLZcGlo0ncOFyKV9+xctEXZTc=;
 b=sk+qWtihffOBQFkzDri126xY3uINX2x8ISLKEb+upcSSy2nSOJIcMxXVpxKD5PGY4m
 Qa8vM5W0BubUyFLU3mLD13MzEv5gynBKisbx8TVpAbO86m0nhQpMtHdAa6Z2Q30J+xiL
 htl8PdU3TatqKEKeS9yXcx5pKgOFxAswivAt5TLTQoxt7EOb2+vGbEKy8llKLJZZgfe0
 UdlwBZbrdhxdD+WZDvpyhC5v/WRoc4hBWYv5uyNhqL8r5SXKqctM/CR3kpDAgO2/VvWG
 CrtpeI6jJ3ooCIlnFGphRgQeDzi2W+EbWMDNzJ3nEZIEPNh/VLw230ZFvtvG9+Jv07eR
 S+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767778814; x=1768383614;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIPG5e//R98QwevC0odLZcGlo0ncOFyKV9+xctEXZTc=;
 b=dvDGyHK+7rsLeQa1Hw84yAq5UbSLqYIRq1bHdbaJglXkJdadPy/fE260gbqT06YB8k
 nh7hmu7ih/zR/N9sANlexDiVNi/dxtkwF7H4GgNOBrG424psNse7fQATpSeJggB57O/Q
 cmHk97FvnmUduCMEpUZm+emu8kH3m2iym9fG9WVclNTmVSly/5CqxBh68bnGXUTKvjQ6
 T2sfFiDtX9aqIyEEgdISnDyjh4ps6+KD2jsBI1n+sedgUvebF2rqUEkdqihixNEKISSO
 BiI/WcEyYuwEfKiFvBacG6ZeV6f0oIHCJ74XCASdRi8Zt7XOMblafUc2t/GzdbAGzBHq
 XbVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCxZ0+Gs/TNyraAZgBRH+RlDuB9ZBTI0N26Oal5hDfESJgoQTd7LnTr6jXKUulINrn6kQpirE5qNk4@nongnu.org
X-Gm-Message-State: AOJu0Ywse/YMhgSU/EorSFE15mytwcFID9/JjVO9aFSp6p2+xTpV+eHQ
 ZMp4QSvsTMT2z/eNDqsKzuhbexF/82Z6UYDZjNCfPQ1RMAF/xqzofiLi5j2jKiXKt86o208CrAh
 i3VBpZzULDz1aVXsJSYv9+xBxLw9ytFxO5S1VElQE1cXOkH9jV4GzpdZU
X-Gm-Gg: AY/fxX41DVr1C09dFi+XE7FpMmWQpTrFEW47HIOJh8GXzedSFk61mZQZPFPdruKvNNE
 1cbz4JrMvStvo1ALmLH1H+4nBrPwmQ/dZUw76oKdQ1nB5ORC4lPnfsnsEI8BeRBM892ur+U4EB/
 e2ULQY9UIUdmfMD0rEUMYk9KPRD6NSkLRVswfTmS/Dd9+Fg3MgsAT2zrC3mdNc+n68PqLXQmGvN
 B4S3OONmSWBAWk1r8RRAGWeTAn/UmoCE+gKLOhQNP0BXB+RPIvMLPQtmXAt2Obl5L6lzPekU8T1
 rVYoJ46BuyZGRLAy3m9KsxbfXpbaKECHemXV6BzSRZIntuywxqZORU0LXX2xtruhPj4+F84BLnM
 +KkwJw6cRYFJEqeSomSnE3hm7jcPGdQTHNrM=
X-Received: by 2002:a05:600c:4e0e:b0:477:abea:9023 with SMTP id
 5b1f17b1804b1-47d84b18e0dmr20604825e9.9.1767778814536; 
 Wed, 07 Jan 2026 01:40:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX2fXnG/kmNnR2HhcN+ezZxOEsfbVUtCCgKUsAqGzYaX6S1UxOumkK0IMbrp4BdsuBoMgSuw==
X-Received: by 2002:a05:600c:4e0e:b0:477:abea:9023 with SMTP id
 5b1f17b1804b1-47d84b18e0dmr20604495e9.9.1767778814065; 
 Wed, 07 Jan 2026 01:40:14 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef885sm87717235e9.9.2026.01.07.01.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 01:40:13 -0800 (PST)
Message-ID: <1a5926ec-8bf5-49de-9228-595d3910275f@redhat.com>
Date: Wed, 7 Jan 2026 10:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-4-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251210205449.2783111-4-jrossi@linux.ibm.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Separate the CCW specific virtio routines and create generic wrappers for easier
> reuse of existing virtio functions with non-CCW devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
> new file mode 100644
> index 0000000000..e121826625
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-ccw.c
> @@ -0,0 +1,242 @@
> +/*
> + * Virtio functionality for CCW devices
> + *
> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
> + * Copyright 2025 IBM Corp. Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include <string.h>
> +#include "s390-ccw.h"
> +#include "cio.h"
> +#include "virtio.h"
> +#include "virtio-ccw.h"
> +#include "virtio-scsi.h"
> +#include "bswap.h"
> +#include "helper.h"
> +#include "s390-time.h"
> +
> +/* virtio spec v1.0 para 4.3.3.2 */
> +static long kvm_hypercall(unsigned long nr, unsigned long param1,
> +                          unsigned long param2, unsigned long param3)
> +{
> +    register unsigned long r_nr asm("1") = nr;
> +    register unsigned long r_param1 asm("2") = param1;
> +    register unsigned long r_param2 asm("3") = param2;
> +    register unsigned long r_param3 asm("4") = param3;
> +    register long retval asm("2");
> +
> +    asm volatile ("diag %%r2,%%r4,0x500"
> +                  : "=d" (retval)
> +                  : "d" (r_nr), "0" (r_param1), "r"(r_param2), "d"(r_param3)
> +                  : "memory", "cc");
> +
> +    return retval;
> +}
> +
> +static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
> +{
> +    Ccw1 ccw = {};
> +
> +    ccw.cmd_code = cmd;
> +    ccw.cda = (long)ptr;
> +    ccw.count = len;
> +
> +    if (sli) {
> +        ccw.flags |= CCW_FLAG_SLI;
> +    }
> +
> +    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
> +}
> +
> +bool virtio_ccw_is_supported(SubChannelId schid)
> +{
> +    VDev *vdev = virtio_get_device();
 > +    vdev->schid = schid;

At the calling site (virtio_ccw_setup), you're doing:

  if (!virtio_ccw_is_supported(vdev->schid)) ...

i.e. vdev->schid is already set up, and you already have a pointer to vdev 
there. So I think it would make more sense to replace the "schid" parameter 
of this function here to a "vdev" pointer, and drop the call to 
virtio_get_device() here, and not to re-assign vdev->schid here.

> +    memset(&vdev->senseid, 0, sizeof(vdev->senseid));
> +
> +    /*
> +     * Run sense id command.
> +     * The size of the senseid data differs between devices (notably,
> +     * between virtio devices and dasds), so specify the largest possible
> +     * size and suppress the incorrect length indication for smaller sizes.
> +     */
> +    if (run_ccw(vdev, CCW_CMD_SENSE_ID, &vdev->senseid, sizeof(vdev->senseid),
> +                true)) {
> +        return false;
> +    }
> +
> +    vdev->dev_type = vdev->senseid.cu_model;
> +
> +    if (vdev->senseid.cu_type == 0x3832) {
> +        switch (vdev->dev_type) {
> +        case VIRTIO_ID_BLOCK:
> +        case VIRTIO_ID_SCSI:
> +        case VIRTIO_ID_NET:
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +    return false;
> +}
...
> +int virtio_ccw_setup(VDev *vdev)
> +{
> +    int i, cfg_size = 0;
> +    uint8_t status;
> +    struct VirtioFeatureDesc {
> +        uint32_t features;
> +        uint8_t index;
> +    } __attribute__((packed)) feats;
> +
> +    if (!virtio_ccw_is_supported(vdev->schid)) {
> +        puts("Virtio unsupported for this device ID");
> +        return -ENODEV;
> +    }
> +    /* device ID has been established now */
> +
> +    vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> +
> +    virtio_reset(vdev);
> +
> +    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
> +        puts("Could not write ACKNOWLEDGE status to host");
> +        return -EIO;
> +    }
> +
> +    switch (vdev->dev_type) {
> +    case VIRTIO_ID_NET:
> +        vdev->nr_vqs = 2;
> +        vdev->cmd_vr_idx = 0;
> +        cfg_size = sizeof(vdev->config.net);
> +        break;
> +    case VIRTIO_ID_BLOCK:
> +        vdev->nr_vqs = 1;
> +        vdev->cmd_vr_idx = 0;
> +        cfg_size = sizeof(vdev->config.blk);
> +        break;
> +    case VIRTIO_ID_SCSI:
> +        vdev->nr_vqs = 3;
> +        vdev->cmd_vr_idx = VR_REQUEST;
> +        cfg_size = sizeof(vdev->config.scsi);
> +        break;
> +    default:
> +        puts("Unsupported virtio device");
> +        return -ENODEV;
> +    }
> +
> +    status |= VIRTIO_CONFIG_S_DRIVER;
> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
> +        puts("Could not write DRIVER status to host");
> +        return -EIO;
> +    }
> +
> +    /* Feature negotiation */
> +    for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
> +        feats.features = 0;
> +        feats.index = i;
> +        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false)) {
> +            puts("Could not get features bits");
> +            return -EIO;
> +        }
> +
> +        vdev->guest_features[i] &= bswap32(feats.features);
> +        feats.features = bswap32(vdev->guest_features[i]);
> +        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false)) {
> +            puts("Could not set features bits");
> +            return -EIO;
> +        }
> +    }
> +
> +    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)) {
> +        puts("Could not get virtio device configuration");
> +        return -EIO;
> +    }
> +
> +    for (i = 0; i < vdev->nr_vqs; i++) {
> +        VqInfo info = {
> +            .queue = (unsigned long long) virtio_get_ring_area() + (i * VIRTIO_RING_SIZE),

Would it make sense to add a "ring_num" parameter to virtio_get_ring_area(), 
so that you could call virtio_get_ring_area(i) here instead?

virtio_get_ring_area() would then look like this:

char *virtio_get_ring_area(int ring_num)
{
	return ring_area + ring_num * VIRTIO_RING_SIZE;
}

?

> +            .align = KVM_S390_VIRTIO_RING_ALIGN,
> +            .index = i,
> +            .num = 0,
> +        };
> +        VqConfig config = {
> +            .index = i,
> +            .num = 0,
> +        };
> +
> +        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),
> +                false)) {
> +            puts("Could not get virtio device VQ config");
> +            return -EIO;
> +        }
> +        info.num = config.num;
> +        vring_init(&vdev->vrings[i], &info);
> +        vdev->vrings[i].schid = vdev->schid;
> +        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
> +            puts("Cannot set VQ info");
> +            return -EIO;
> +        }
> +    }
> +
> +    status |= VIRTIO_CONFIG_S_DRIVER_OK;
> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
> +        puts("Could not write DRIVER_OK status to host");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
...
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 0f4f201038..0488b3a07e 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -2,6 +2,7 @@
>    * Virtio driver bits
>    *
>    * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
> + * Copyright 2025 IBM Corp. Author(s): Jared Rossi <jrossi@linux.ibm.com>

I assume you wanted to put Authors on a separate line?

  Thomas



