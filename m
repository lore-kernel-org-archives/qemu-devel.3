Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59075CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ski-0000fn-Vi; Tue, 30 Sep 2025 01:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Ske-0000fM-3S
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3SkT-0008IX-HX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759209478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iJqbxLGZBRbCdI1fp8Wxe0FpNDpA/eSstK1MYNC/cEM=;
 b=E76z3/bStZQhRHS5+0INiEpdVFBOu80z85uBZEeImRoM5wzMrv/epMAKI/8qikTN7NxwN4
 4CQNlggBoLRALTK6zMfLm+vkCXHHOxt+5sp4j0lS2eXMaOQ7hL9cleWxeyjrYTDkMHpaw8
 1wPckSIn1pdwYX8Xyygio2v1YJ0Xib0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-FQTyQpZKP_mQyxX6zsgs7A-1; Tue, 30 Sep 2025 01:17:56 -0400
X-MC-Unique: FQTyQpZKP_mQyxX6zsgs7A-1
X-Mimecast-MFC-AGG-ID: FQTyQpZKP_mQyxX6zsgs7A_1759209476
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-636260bcc31so2527862a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 22:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759209476; x=1759814276;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJqbxLGZBRbCdI1fp8Wxe0FpNDpA/eSstK1MYNC/cEM=;
 b=WMnWgoLldasyBmTuf3l6PKPFtLeRnssKBiCqQiphLUDYnUIgVKQcs+olfFzElqsZIn
 bHDFX0nHTPT6dqSba9icv7Ubq7qFcuDlYISN18bLtTw0w1EL4raaGb3o+ijfRVq344QZ
 z3u25YXWS8sco4Rj0thmkr04oUqrWv4ok1li2ac7AArNv4PhKwWD9eHZibpwsc4MvwOH
 SBaRK9nMgllauxw71LLh0L40qOj+fu6GmfuyemC5vPyRwu9/GcjWMAdxcpvovS+ZO5Fk
 bMOOoJAGzoQytHfL4hudb0e00p9GnMyH3cnniXZfNwa0XoeopxqS924FytxDT0eMkCGp
 CcnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIWsKoBeKZTa+qEFU+0COmaL6y701Ghi+9lwEIiLV5vjOcjF2bd1bBY800braSgagAP9LmFi38goYB@nongnu.org
X-Gm-Message-State: AOJu0YwvjF98d3ntoDv7QnUll8C/oVVxWQoVhZt12jVC/nhP5belWur7
 y8ys8O2stpXJyuxPMPvC6fb1lsyDiiAs5kk07j0/cSMju7mx6xn+78wMRfwNMqO/DuymPEptIB8
 4qEPELwah0MbQYy9lWv0jUxthjVrRrkM/ZRV0uOHdZlIUQZzKaaiYrhKi
X-Gm-Gg: ASbGncvSFLrSt5O1zmGV50FeeyIgyFfB8QYNBIjK5xWqNWa510Nwt5j4BsdoOacfH/o
 BC2L7z9ISlbs8dV3SxudvZJpEWNdXfDbkP185R2A+hG8W9a0RSSwTr42IjwubqtJmnVjFJe8o5f
 YHcuiOAenyh4AkvsBSdEELpomT9k0IO8ZQDjzqIJv/nDoCldEYFEldmsUjjl4VKHWfnk3kkAuq2
 Qpqml+A6mrW++nv/EIkcH3srQ2XuuKoGFdq09CBbRnIEPp2E5fHdqiGtwz7IpawFB0SiYP4omuV
 eO4jmDoiURmecMc3uAejtxmmwueJPxfPPWL+qN0qf4sQRcqDIHIhauJ5VY+gs/xg7TkBLFUx1et
 1ThDsn1msUw==
X-Received: by 2002:a05:6402:50c7:b0:62f:9731:a1c6 with SMTP id
 4fb4d7f45d1cf-6349fa73ddcmr16749809a12.21.1759209475648; 
 Mon, 29 Sep 2025 22:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi7qy8AylS4ZYYZEIvYs0+dEtIn2Z48rzfXoS45/r1i/R2wezJa6kDRndbNzkhCIJTHuXZOA==
X-Received: by 2002:a05:6402:50c7:b0:62f:9731:a1c6 with SMTP id
 4fb4d7f45d1cf-6349fa73ddcmr16749783a12.21.1759209475247; 
 Mon, 29 Sep 2025 22:17:55 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634c4b96ff6sm6611079a12.46.2025.09.29.22.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 22:17:54 -0700 (PDT)
Message-ID: <2171c08e-0224-4309-8657-ed9d2e8036aa@redhat.com>
Date: Tue, 30 Sep 2025 07:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/28] pc-bios/s390-ccw: Define memory for IPLB and
 convert IPLB to pointers
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-15-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-15-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Define a memory space for both IPL Parameter Block (IPLB) and
> IPL Information Report Block (IIRB) since IIRB is stored immediately
> following IPLB.
> 
> Convert IPLB to pointer and it points to the start of the defined memory space.
> IIRB points to the end of IPLB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/iplb.h     | 12 ++++++++++--
>   pc-bios/s390-ccw/jump2ipl.c |  6 +++---
>   pc-bios/s390-ccw/main.c     | 34 +++++++++++++++++++---------------
>   pc-bios/s390-ccw/netmain.c  |  8 ++++----
>   4 files changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index bdbc733e16..11302e004d 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -20,7 +20,7 @@
>   #include <string.h>
>   
>   extern QemuIplParameters qipl;
> -extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> +extern IplParameterBlock *iplb;
>   extern bool have_iplb;
>   
>   struct IplInfoReportBlockHeader {
> @@ -85,6 +85,14 @@ struct IplInfoReportBlock {
>   } __attribute__ ((packed));
>   typedef struct IplInfoReportBlock IplInfoReportBlock;
>   
> +struct IplBlocks {
> +    IplParameterBlock   iplb;
> +    IplInfoReportBlock  iirb;
> +} __attribute__ ((packed));
> +typedef struct IplBlocks IplBlocks;
> +
> +extern IplBlocks ipl_data __attribute__((__aligned__(PAGE_SIZE)));

I think it makes more sense to specify the attribute in the .c file instead 
of using it here in the header.

  Thomas


>   #define S390_IPL_TYPE_FCP 0x00
>   #define S390_IPL_TYPE_CCW 0x02
>   #define S390_IPL_TYPE_QEMU_SCSI 0xff
> @@ -127,7 +135,7 @@ static inline bool load_next_iplb(void)
>   
>       qipl.index++;
>       next_iplb = (IplParameterBlock *) qipl.next_iplb;
> -    memcpy(&iplb, next_iplb, sizeof(IplParameterBlock));
> +    memcpy(iplb, next_iplb, sizeof(IplParameterBlock));
>   
>       qipl.chain_len--;
>       qipl.next_iplb = qipl.next_iplb + sizeof(IplParameterBlock);
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 86321d0f46..fa2ca5cbe1 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -43,11 +43,11 @@ int jump_to_IPL_code(uint64_t address)
>        * The IPLB for QEMU SCSI type devices must be rebuilt during re-ipl. The
>        * iplb.devno is set to the boot position of the target SCSI device.
>        */
> -    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
> -        iplb.devno = qipl.index;
> +    if (iplb->pbt == S390_IPL_TYPE_QEMU_SCSI) {
> +        iplb->devno = qipl.index;
>       }
>   
> -    if (have_iplb && !set_iplb(&iplb)) {
> +    if (have_iplb && !set_iplb(iplb)) {
>           panic("Failed to set IPLB");
>       }
>   
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 76bf743900..c9328f1c51 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -22,7 +22,9 @@
>   static SubChannelId blk_schid = { .one = 1 };
>   static char loadparm_str[LOADPARM_LEN + 1];
>   QemuIplParameters qipl;
> -IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> +/* Ensure that IPLB and IIRB are page aligned and sequential in memory */
> +IplBlocks ipl_data;
> +IplParameterBlock *iplb;
>   bool have_iplb;
>   static uint16_t cutype;
>   LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
> @@ -51,7 +53,7 @@ void write_subsystem_identification(void)
>   void write_iplb_location(void)
>   {
>       if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
> -        lowcore->ptr_iplb = ptr2u32(&iplb);
> +        lowcore->ptr_iplb = ptr2u32(iplb);
>       }
>   }
>   
> @@ -162,7 +164,7 @@ static void menu_setup(void)
>           return;
>       }
>   
> -    switch (iplb.pbt) {
> +    switch (iplb->pbt) {
>       case S390_IPL_TYPE_CCW:
>       case S390_IPL_TYPE_QEMU_SCSI:
>           menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
> @@ -191,8 +193,8 @@ static void boot_setup(void)
>   {
>       char lpmsg[] = "LOADPARM=[________]\n";
>   
> -    if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
> -        ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
> +    if (have_iplb && memcmp(iplb->loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
> +        ebcdic_to_ascii((char *) iplb->loadparm, loadparm_str, LOADPARM_LEN);
>       } else {
>           sclp_get_loadparm_ascii(loadparm_str);
>       }
> @@ -216,21 +218,21 @@ static bool find_boot_device(void)
>       VDev *vdev = virtio_get_device();
>       bool found = false;
>   
> -    switch (iplb.pbt) {
> +    switch (iplb->pbt) {
>       case S390_IPL_TYPE_CCW:
>           vdev->scsi_device_selected = false;
> -        debug_print_int("device no. ", iplb.ccw.devno);
> -        blk_schid.ssid = iplb.ccw.ssid & 0x3;
> +        debug_print_int("device no. ", iplb->ccw.devno);
> +        blk_schid.ssid = iplb->ccw.ssid & 0x3;
>           debug_print_int("ssid ", blk_schid.ssid);
> -        found = find_subch(iplb.ccw.devno);
> +        found = find_subch(iplb->ccw.devno);
>           break;
>       case S390_IPL_TYPE_QEMU_SCSI:
>           vdev->scsi_device_selected = true;
> -        vdev->selected_scsi_device.channel = iplb.scsi.channel;
> -        vdev->selected_scsi_device.target = iplb.scsi.target;
> -        vdev->selected_scsi_device.lun = iplb.scsi.lun;
> -        blk_schid.ssid = iplb.scsi.ssid & 0x3;
> -        found = find_subch(iplb.scsi.devno);
> +        vdev->selected_scsi_device.channel = iplb->scsi.channel;
> +        vdev->selected_scsi_device.target = iplb->scsi.target;
> +        vdev->selected_scsi_device.lun = iplb->scsi.lun;
> +        blk_schid.ssid = iplb->scsi.ssid & 0x3;
> +        found = find_subch(iplb->scsi.devno);
>           break;
>       default:
>           puts("Unsupported IPLB");
> @@ -311,10 +313,12 @@ static void probe_boot_device(void)
>   
>   void main(void)
>   {
> +    iplb = &ipl_data.iplb;
> +
>       copy_qipl();
>       sclp_setup();
>       css_setup();
> -    have_iplb = store_iplb(&iplb);
> +    have_iplb = store_iplb(iplb);
>       if (!have_iplb) {
>           boot_setup();
>           probe_boot_device();
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index a9521dff41..457fbc3095 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -528,11 +528,11 @@ static bool virtio_setup(void)
>        */
>       enable_mss_facility();
>   
> -    if (have_iplb || store_iplb(&iplb)) {
> -        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
> -        dev_no = iplb.ccw.devno;
> +    if (have_iplb || store_iplb(iplb)) {
> +        IPL_assert(iplb->pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
> +        dev_no = iplb->ccw.devno;
>           debug_print_int("device no. ", dev_no);
> -        net_schid.ssid = iplb.ccw.ssid & 0x3;
> +        net_schid.ssid = iplb->ccw.ssid & 0x3;
>           debug_print_int("ssid ", net_schid.ssid);
>           found = find_net_dev(&schib, dev_no);
>       } else {


