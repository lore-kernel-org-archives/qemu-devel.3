Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17E9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8av-0006dP-Ur; Tue, 21 Oct 2025 05:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB8at-0006ce-Ow
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB8ao-00075k-26
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761038623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1tUJolkWNZAnhCeEw0ENapzaF/dM2ZzHHZRREcK4HGo=;
 b=hsCklhu2UXeBdLvzTSb+LwVx4H7q+Wk/3/G4zjsYebSngmG/U5W7JUxu14gi/T8szjRVsP
 2yYI402Vk9N3DLkK2poQaqx/sdk+dtwQTO4/lwiNWzbf9On1IfMcdN/4AbJbJd17uVlBAM
 xo+4oe1Q9jrzSdQ8nYTkbDDm5mrFhC4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-saz0BSh2PYa08844NtEwYw-1; Tue, 21 Oct 2025 05:23:41 -0400
X-MC-Unique: saz0BSh2PYa08844NtEwYw-1
X-Mimecast-MFC-AGG-ID: saz0BSh2PYa08844NtEwYw_1761038620
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4710c04a403so56987255e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761038620; x=1761643420;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1tUJolkWNZAnhCeEw0ENapzaF/dM2ZzHHZRREcK4HGo=;
 b=cg4fny68HVjpt/+ob/IdStIpwVDXE0GCbNq4NYVPheRR1RNq+HE9PhYuGTnlYqpPhz
 RhlNtCGtJNBMDBFQVRNafbwkwxWtL0elwgxyD9FabxC3AB7HoIzTwTlqw6yNNx0GSDBx
 8jwzWJ1fKl4Ej9nDaBxTI6HOJoorWd9mzVoBZjXEOAFaSGC3W9zqlBXQliVkMr4Ag/iU
 t+grBpTAMJlZzw/aHJVgFJ5sArnD5u4k/FX/XBZP3u6nccip5r/Al+Lhvm2HjPEkyNma
 q9KzEfKCpU6Vpz25maQcFX5Ezo4Bni0CRs6KnlQHd2zTWhlh5POIrPnMJHBUXJxAuLFR
 0Asw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnPOZDpa3HxI1VROh/8Q4cDxoadKLKCU/ps62Gt6j0h0XCjYapW8dbyKokW8PsAFr5WFpA143KwcMX@nongnu.org
X-Gm-Message-State: AOJu0YxfmVjua4P3xuV7dJGPX/GfL9VIZFbVQ/hfXXjLMqr6pLnyycUO
 3vV/KEowpiwPPmPuB69V3R9ujC3E5Gc8lJ0w5KTJslOn1L3hQNxcw9qNNosZs0JoPZmXzkcxvHi
 SRj0/eZXEVpo31I9Yb2NrTnay/Mgo+45odSzTDKdASkF+ZXY7/c4GJ1NB
X-Gm-Gg: ASbGncu0Fw7gCsNrEG6pMnlNAfGHFA9+m5QK0EJ50QCPjpMdi2iEp1WJyBI5e37VBpG
 yLrLSmFao3if0CyMg2ch0lDzADcr1UUMfJ923btdCDBCBC/w0wVLDZbhxUZ7Bpngr5OGawGrk/k
 2Sm+CkZt5OjQgEbqiyVHE3bzzhAXRSYsL+5tEnqAnY/XkNh1iYq6YvNhPPTh4DxTRwi5JfPCuPT
 045NtChNOC1rRd1eXoch+p7HNLOGXmDhVghjhkJdz+acy1L8SsAvc8zpM1PHNthGVYTOpC2Dtrs
 cr8kL0xfhYv5cLIDhNrnVpheRllklBRdS9lZnMkAdMZG0YLY8DRfmEnr1jJW11rVPp44hDwLf9H
 Wd4QH8UFOYrS3BANYNB/7Cs1g
X-Received: by 2002:a05:600c:1f93:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4711791c66fmr132852675e9.28.1761038619866; 
 Tue, 21 Oct 2025 02:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJlr/x6R/KmSCdVDoUrj5p8oeA36Ib0ZY6wMKyN3IwctKe1tLTsF3KshH3XF8k54LLBvosw==
X-Received: by 2002:a05:600c:1f93:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4711791c66fmr132852415e9.28.1761038619269; 
 Tue, 21 Oct 2025 02:23:39 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c65sm19296905f8f.15.2025.10.21.02.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:23:38 -0700 (PDT)
Message-ID: <da4df4ea-91b6-4dbc-9588-15db3f55b802@redhat.com>
Date: Tue, 21 Oct 2025 11:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] pc-bios/s390-ccw: Split virtio-ccw and generic virtio
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-3-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020162023.3649165-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  Hi Jared!

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Separate the CCW specific virtio routines and create generic wrappers for easier
> reuse of existing virtio functions with non-CCW devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.h                   |   5 -
>   include/hw/s390x/ipl/qipl.h      |   6 +
>   pc-bios/s390-ccw/iplb.h          |   4 -
>   pc-bios/s390-ccw/virtio-ccw.h    |  25 ++++
>   pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
>   pc-bios/s390-ccw/virtio.h        |  11 +-
>   pc-bios/s390-ccw/main.c          |  13 +-
>   pc-bios/s390-ccw/virtio-blkdev.c |  57 +++++---
>   pc-bios/s390-ccw/virtio-ccw.c    | 240 +++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio-net.c    |   5 +-
>   pc-bios/s390-ccw/virtio-scsi.c   |   7 +-
>   pc-bios/s390-ccw/virtio.c        | 209 +++++----------------------
>   pc-bios/s390-ccw/Makefile        |   3 +-
>   13 files changed, 367 insertions(+), 220 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/virtio-ccw.h
>   create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 505cded490..aec2244321 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -103,11 +103,6 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>   #define DIAG308_PV_STORE            9
>   #define DIAG308_PV_START            10
>   
> -#define S390_IPL_TYPE_FCP 0x00
> -#define S390_IPL_TYPE_CCW 0x02
> -#define S390_IPL_TYPE_PV 0x05
> -#define S390_IPL_TYPE_QEMU_SCSI 0xff
> -
>   #define S390_IPLB_HEADER_LEN 8
>   #define S390_IPLB_MIN_PV_LEN 148
>   #define S390_IPLB_MIN_CCW_LEN 200
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 6824391111..aadab87c2e 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -20,6 +20,12 @@
>   #define LOADPARM_LEN    8
>   #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>   
> +#define S390_IPL_TYPE_FCP 0x00
> +#define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PCI 0x04
> +#define S390_IPL_TYPE_PV 0x05
> +#define S390_IPL_TYPE_QEMU_SCSI 0xff
> +
>   /*
>    * The QEMU IPL Parameters will be stored at absolute address
>    * 204 (0xcc) which means it is 32-bit word aligned but not
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 08f259ff31..926e8eed5d 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -23,10 +23,6 @@ extern QemuIplParameters qipl;
>   extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>   extern bool have_iplb;
>   
> -#define S390_IPL_TYPE_FCP 0x00
> -#define S390_IPL_TYPE_CCW 0x02
> -#define S390_IPL_TYPE_QEMU_SCSI 0xff

This patch is doing quite a bit of different changes at once, making it hard 
to review ... It would be nice if you could at least move the 
"S390_IPL_TYPE_*" movement into a separate patch.

> diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/pc-bios/s390-ccw/virtio-ccw.h
> new file mode 100644
> index 0000000000..366c4812af
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-ccw.h
> @@ -0,0 +1,25 @@
> +/*
> + * Virtio definitions for CCW devices
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef VIRTIO_CCW_H
> +#define VIRTIO_CCW_H
> +
> +/* main.c */
> +extern SubChannelId blk_schid;
> +
> +/* virtio-ccw.c */
> +int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli);
> +int drain_irqs_ccw(SubChannelId schid);
> +bool virtio_ccw_is_supported(SubChannelId schid);
> +int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd);
> +long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
> +int virtio_ccw_setup(VDev *vdev);
> +int virtio_ccw_reset(VDev *vdev);
> +
> +#endif
> diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scsi.h
> index c5612e16a2..7a37f8b45a 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.h
> +++ b/pc-bios/s390-ccw/virtio-scsi.h
> @@ -69,6 +69,6 @@ static inline bool virtio_scsi_response_ok(const VirtioScsiCmdResp *r)
>   
>   int virtio_scsi_read_many(VDev *vdev,
>                             unsigned long sector, void *load_addr, int sec_num);
> -int virtio_scsi_setup_device(SubChannelId schid);
> +int virtio_scsi_setup_device(void);
>   
>   #endif /* VIRTIO_SCSI_H */
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 597bd42358..1c1017a0db 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -109,6 +109,8 @@ struct VRing {
>   };
>   typedef struct VRing VRing;
>   
> +char *virtio_get_ring_area(void);
> +
>   
>   /***********************************************
>    *               Virtio block                  *
> @@ -138,6 +140,9 @@ typedef struct VRing VRing;
>   /* Barrier before this op. */
>   #define VIRTIO_BLK_T_BARRIER    0x80000000
>   
> +/* For device bus switches */
> +extern int ipl_type;
> +
>   /* This is the first element of the read scatter-gather list. */
>   struct VirtioBlkOuthdr {
>           /* VIRTIO_BLK_T* */
> @@ -236,6 +241,7 @@ struct VDev {
>       int cmd_vr_idx;
>       void *ring_area;
>       long wait_reply_timeout;
> +    VirtioDevType type;
>       VirtioGDN guessed_disk_nature;
>       SubChannelId schid;
>       SenseId senseid;
> @@ -268,8 +274,9 @@ struct VirtioCmd {
>   };
>   typedef struct VirtioCmd VirtioCmd;
>   
> +void vring_init(VRing *vr, VqInfo *info);
>   bool vring_notify(VRing *vr);
> -int drain_irqs(SubChannelId schid);
> +int drain_irqs(VRing *vr);
>   void vring_send_buf(VRing *vr, void *p, int len, int flags);
>   int vr_poll(VRing *vr);
>   int vring_wait_reply(void);
> @@ -282,7 +289,7 @@ int virtio_net_init(void *mac_addr);
>   void virtio_net_deinit(void);
>   
>   /* virtio-blkdev.c */
> -int virtio_blk_setup_device(SubChannelId schid);
> +int virtio_blk_setup_device(void);
>   int virtio_read(unsigned long sector, void *load_addr);
>   unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
>                                    void *load_addr);
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 76bf743900..7299b8911f 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -19,11 +19,12 @@
>   #include "virtio-scsi.h"
>   #include "dasd-ipl.h"
>   
> -static SubChannelId blk_schid = { .one = 1 };
> +SubChannelId blk_schid = { .one = 1 };
>   static char loadparm_str[LOADPARM_LEN + 1];
>   QemuIplParameters qipl;
>   IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>   bool have_iplb;
> +int ipl_type;

Having two new global variables to pass around information is somewhat ugly...

>   static uint16_t cutype;
>   LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>   
> @@ -216,7 +217,7 @@ static bool find_boot_device(void)
>       VDev *vdev = virtio_get_device();
>       bool found = false;
>   
> -    switch (iplb.pbt) {
> +    switch (ipl_type) {
>       case S390_IPL_TYPE_CCW:
>           vdev->scsi_device_selected = false;

... could we maybe set up vdev->schid here already (or in virtio_setup 
below) ...

>           debug_print_int("device no. ", iplb.ccw.devno);
> @@ -245,15 +246,15 @@ static int virtio_setup(void)
>       vdev->is_cdrom = false;
>       int ret;
>   
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_NET:
>           puts("Network boot device detected");
>           return 0;
>       case VIRTIO_ID_BLOCK:
> -        ret = virtio_blk_setup_device(blk_schid);
> +        ret = virtio_blk_setup_device();

... and then simply pass vdev as parameter to virtio_blk_setup_device() here ...

>           break;
>       case VIRTIO_ID_SCSI:
> -        ret = virtio_scsi_setup_device(blk_schid);
> +        ret = virtio_scsi_setup_device();

... and here.

Then we don't have to make blk_schid global.
(Please also make this as a separate patch first, since this one here is 
already quite complicated).

Would it also be possible to store ipl_type in the VDev, so we don't have to 
make this variable global?

>           break;
>       default:
>           puts("\n! No IPL device available !\n");
> @@ -316,11 +317,13 @@ void main(void)
>       css_setup();
>       have_iplb = store_iplb(&iplb);
>       if (!have_iplb) {
> +        ipl_type = S390_IPL_TYPE_CCW; /* Assume CCW for probing */
>           boot_setup();
>           probe_boot_device();
>       }
>   
>       while (have_iplb) {
> +        ipl_type = iplb.pbt;
>           boot_setup();
>           if (have_iplb && find_boot_device()) {
>               ipl_boot_device();
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 4b819dd80f..df6a6d5b70 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -11,6 +11,7 @@
>   #include <stdio.h>
>   #include "s390-ccw.h"
>   #include "virtio.h"
> +#include "virtio-ccw.h"
>   #include "virtio-scsi.h"
>   
>   #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
> @@ -40,9 +41,10 @@ static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_add
>                      VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN);
>   
>       /* Now we can tell the host to read */
> +    vring_notify(vr);

Why is there suddenly a new call to vring_notify() popping up here? ... if 
it's necessary now, this deserves a separate patch, I think.

>       vring_wait_reply();
>   
> -    if (drain_irqs(vr->schid)) {
> +    if (drain_irqs(vr)) {
>           /* Well, whatever status is supposed to contain... */
>           status = 1;
>       }
> @@ -53,14 +55,14 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
>   {
>       VDev *vdev = virtio_get_device();
>   
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_BLOCK:
>           return virtio_blk_read_many(vdev, sector, load_addr, sec_num);
>       case VIRTIO_ID_SCSI:
>           return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);
> +    default:
> +        return -1;
>       }
> -
> -    return -1;
>   }
>   
>   unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
> @@ -119,7 +121,7 @@ void virtio_assume_iso9660(void)
>   {
>       VDev *vdev = virtio_get_device();
>   
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_BLOCK:
>           vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
>           vdev->config.blk.blk_size = VIRTIO_ISO_BLOCK_SIZE;
> @@ -129,6 +131,8 @@ void virtio_assume_iso9660(void)
>       case VIRTIO_ID_SCSI:
>           vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
>           break;
> +    default:
> +        panic("Virtio device type mismatch for iso9660 IPL");
>       }
>   }
>   
> @@ -139,13 +143,15 @@ void virtio_assume_eckd(void)
>       vdev->guessed_disk_nature = VIRTIO_GDN_DASD;
>       vdev->blk_factor = 1;
>       vdev->config.blk.physical_block_exp = 0;
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_BLOCK:
>           vdev->config.blk.blk_size = VIRTIO_DASD_DEFAULT_BLOCK_SIZE;
>           break;
>       case VIRTIO_ID_SCSI:
>           vdev->config.blk.blk_size = vdev->scsi_block_size;
>           break;
> +    default:
> +        panic("Virtio device type mismatch for ECKD IPL");
>       }
>       vdev->config.blk.geometry.heads = 15;
>       vdev->config.blk.geometry.sectors =
> @@ -162,8 +168,7 @@ bool virtio_ipl_disk_is_valid(void)
>           return true;
>       }
>   
> -    return (vdev->senseid.cu_model == VIRTIO_ID_BLOCK ||
> -            vdev->senseid.cu_model == VIRTIO_ID_SCSI) &&
> +    return (vdev->type == VIRTIO_ID_BLOCK || vdev->type == VIRTIO_ID_SCSI) &&
>              blksize >= 512 && blksize <= 4096;
>   }
>   
> @@ -171,41 +176,44 @@ int virtio_get_block_size(void)
>   {
>       VDev *vdev = virtio_get_device();
>   
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_BLOCK:
>           return vdev->config.blk.blk_size;
>       case VIRTIO_ID_SCSI:
>           return vdev->scsi_block_size;
> +    default:
> +        return 0;
>       }
> -    return 0;
>   }
>   
>   uint8_t virtio_get_heads(void)
>   {
>       VDev *vdev = virtio_get_device();
>   
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_BLOCK:
>           return vdev->config.blk.geometry.heads;
>       case VIRTIO_ID_SCSI:
>           return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
>                  ? vdev->config.blk.geometry.heads : 255;
> +    default:
> +        return 0;
>       }
> -    return 0;
>   }
>   
>   uint8_t virtio_get_sectors(void)
>   {
>       VDev *vdev = virtio_get_device();
>   
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_BLOCK:
>           return vdev->config.blk.geometry.sectors;
>       case VIRTIO_ID_SCSI:
>           return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
>                  ? vdev->config.blk.geometry.sectors : 63;
> +    default:
> +        return 0;
>       }
> -    return 0;
>   }
>   
>   uint64_t virtio_get_blocks(void)
> @@ -213,24 +221,29 @@ uint64_t virtio_get_blocks(void)
>       VDev *vdev = virtio_get_device();
>       const uint64_t factor = virtio_get_block_size() / VIRTIO_SECTOR_SIZE;
>   
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->type) {
>       case VIRTIO_ID_BLOCK:
>           return vdev->config.blk.capacity / factor;
>       case VIRTIO_ID_SCSI:
>           return vdev->scsi_last_block / factor;
> +    default:
> +        return 0;
>       }
> -    return 0;
>   }
>   
> -int virtio_blk_setup_device(SubChannelId schid)
> +int virtio_blk_setup_device()
>   {
>       VDev *vdev = virtio_get_device();
>   
> -    vdev->guest_features[0] = VIRTIO_BLK_F_GEOMETRY | VIRTIO_BLK_F_BLK_SIZE;
> -    vdev->schid = schid;
> -    virtio_setup_ccw(vdev);
> -
>       puts("Using virtio-blk.");
>   
> -    return 0;
> +    vdev->guest_features[0] = VIRTIO_BLK_F_GEOMETRY | VIRTIO_BLK_F_BLK_SIZE;
> +    switch (ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        vdev->schid = blk_schid;
> +        return virtio_ccw_setup(vdev);
> +    }
> +
> +    return 1;
>   }
> diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
> new file mode 100644
> index 0000000000..1d6e8532f6
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-ccw.c
> @@ -0,0 +1,240 @@
> +/*
> + * Virtio functionality for CCW devices
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>

Since you're copying over functions from another file, I think it would make 
sense to add the copyright statement from the other file here, too.

> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +bool virtio_ccw_is_supported(SubChannelId schid)
> +{
> +    VDev *vdev = virtio_get_device();
> +    vdev->schid = schid;
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
> +    vdev->type = vdev->senseid.cu_model;
> +
> +    if (vdev->senseid.cu_type == 0x3832) {
> +        switch (vdev->type) {
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

You copied the is_supported() function to the new file, but also kept the 
original. As far as I can see, virtio_ccw_is_supported() is not used at all 
in your new code, so you could remove that here again? Or remove the 
original function and only use this one here?

> +int drain_irqs_ccw(SubChannelId schid)
> +{
> +    Irb irb = {};
> +    int r = 0;
> +
> +    while (1) {
> +        /* FIXME: make use of TPI, for that enable subchannel and isc */
> +        if (tsch(schid, &irb)) {
> +            /* Might want to differentiate error codes later on. */
> +            if (irb.scsw.cstat) {
> +                r = -EIO;
> +            } else if (irb.scsw.dstat != 0xc) {
> +                r = -EIO;
> +            }
> +            return r;
> +        }
> +    }
> +}
> +
> +long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie)
> +{
> +    return kvm_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY, *(u32 *)&schid,
> +                         vq_idx, cookie);
> +}
> +
> +int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd)
> +{
> +    VRing *vr = &vdev->vrings[vqid];
> +    int i = 0;
> +
> +    do {
> +        vring_send_buf(vr, cmd[i].data, cmd[i].size,
> +                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
> +    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
> +
> +    vring_wait_reply();
> +    if (drain_irqs(vr)) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
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

As far as I can see, run_ccw() is now only used in the new file, so you 
could make this function "static".

  Thomas


