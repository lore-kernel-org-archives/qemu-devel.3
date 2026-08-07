Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC31C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsI0R-0000vZ-70; Fri, 07 Aug 2026 06:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsI0O-0000uY-Ez
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:40:48 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsI0L-0001mL-UP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:40:48 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3406311a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786099244; x=1786704044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=poF5Jb9cl4x27B2EQOVFaeC4vqNMHWS87TvXHvegPw0=;
 b=hYwDeDYrkzXW5sT8U84oDNJncrpnoF++I9k2XgLCTD8S1hNTunWWlqamHCkUkBbndN
 gLRxO9/BY6iyOGJw+X9TnBqRbv56pO4nRJ9fnBCfsqG6e64cxywDGHIaKayW9sayEfcx
 15rOvgI0ok6g0RHhFxle2pVSt8fCAaWF66+UVdFEI34O1VIIAltfVhqogvJeNOkfkpR+
 phNq+RFYavvdcaRkzK32roA8wv0WXvR3yIFRGOgko2fxlhT109e7XB1I3PWBos6zvMwd
 jAoy1CZfbosRWOs6FHY3JS3uUb0Q63ajVRuQ7HBeapc4eByBF+sYf9OjAqBQ3BS3R0wb
 514Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786099244; x=1786704044;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=poF5Jb9cl4x27B2EQOVFaeC4vqNMHWS87TvXHvegPw0=;
 b=QG2NWBLvDG0N/iDKmEnu1tEJIxXZoTtZ4xXqN96bbxBmnqoK6TOedn6O0hEfl0p63l
 rvIALJH37K/Yvv6eKhfAbcMrYo4FjF+GoJm40ut8uDA3JiXuwPWr0P3VYBAmepExyuwx
 2L6CgfZ9REgypsoeiaUDvHiT1PI3TyEnx0lT8lp7OWIuQ7503y4qgYPop9P8iaV5+zWy
 QKBEQUpRBw1hoOh3W0TVZ87h83cDuXhWewTTpq5IvhL1iSqGK/tJKLOpCNHaNucFujvO
 GZl4lPwb7najI7MKGTuXm0BHUZTlXBkQgAqqTX6X8aHO4oDIJpKPRBmi+aFXJL/ToRUT
 083A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2+AQljO3K6ZIZ6q1VxpKYrRRoMpdOjHerB8SZv4qPRM5dlYphxkPmCsYPfJtxoEJab6wZv/nugBAI@nongnu.org
X-Gm-Message-State: AOJu0Yxy/3z1GxEaRdFdj9+eIqH2Rp3nNu3HEyKwslE708eVAHJ7vgV1
 CAXTmoFSkENcPIblHAvDxOdy3LZrwqAjJoz35ZPgTBqJvY2EDI4FIiaQ
X-Gm-Gg: AR+sD12Gd2+k/l1ibcgM6enqMp84RgtCon2KkgInXd5cx3z02qHuX6Vdz0hKxjZ9rTH
 KbYHKr+s2WG46uU3SqV56DZ7/TV7US2Vs11SLIl7lnG0bp6/k1UUMA9PATXycdViHTGE0/705Rm
 USDlLp/Zvl/5IGoKA3aY2lEeUGYtZfMv1JibuzQpq7+74NyWehieQ0f535TVnI6qWL1ruufYO/c
 6XWzmCCzdXgpPo8Pjkn6MtwkSlynAdYqi8VlL2Mr70FPHjOuacOyw0Iht0REsJvIavKOUxJv04L
 JripeqTJ9c3eMqLdAdW9PWiDHidghUFbFkUjRaVfyIpPX6fo1AZayqSuzoq9opwWff3lXs5DUD4
 4c/+jlDsSLnC2+xTcFN1CfFemeYNJuWWqIy39PeO7lXIhSH/NIwriQeK8Dcq0XW9iBWu0viC4RA
 eySkAhGs4uxasEPF479Swlk7lXFUikS7pPDT1xcFLxApnhvDSw4oH/NHudn/OhvJpdleS7U2G4Z
 nQmcbbu0LmjLtH5iA==
X-Received: by 2002:a17:90b:48c9:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-3903c58f06fmr22350992a91.13.1786099244394; 
 Fri, 07 Aug 2026 03:40:44 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6dfcdsm2044961a91.4.2026.08.07.03.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 03:40:43 -0700 (PDT)
Message-ID: <25c0f24c-1381-4441-aab2-73c6640d74ab@gmail.com>
Date: Fri, 7 Aug 2026 19:40:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] ufs: Refactor common core out of the PCI
 implementation
Content-Language: ko
To: Mikail Sadic <mikail.sadic@ibm.com>, clg@kaod.org, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260730200945.1113936-1-mikail.sadic@ibm.com>
 <20260730200945.1113936-7-mikail.sadic@ibm.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260730200945.1113936-7-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Mikail,

Thanks for reworking the UFS support in v2. The shared controller code
removes the duplication I pointed out in v1.

After considering the structure further, I would prefer to model UfsHc
as a plain controller core and have separate PCI and generic SysBus QOM
devices contain it, following the AHCI model. This keeps the PCI and
SysBus object layout and setup out of the shared UFS code. The generic
SysBus device can then be subclassed by Aspeed and other platforms.

I have prepared and posted a separate two-patch series implementing this
structure:

https://lore.kernel.org/qemu-devel/cover.1786096976.git.jeuk20.kim@samsung.com/

Could you please rebase the UFS-related changes in patches 6-8 on top of
this series for v3? The Aspeed device can then derive from
TYPE_SYSBUS_UFS and provide only the AST2700-specific HCI version
setting.

Sorry for the extra churn.

Thanks,
Jeuk

On 7/31/2026 5:09 AM, Mikail Sadic wrote:
> In preparation for a sysbus UFS frontend (used by the Aspeed AST2700),
> separate the transport-independent UFS host-controller logic from the
> PCI-specific glue, following the pattern used by SDHCI and XHCI.
>
> UfsHc's PCIDevice parent is replaced by an anonymous union of a
> PCIDevice and a SysBusDevice, and the controller gains an explicit
> AddressSpace *dma_as used by ufs_addr_read()/ufs_addr_write() and the
> SG-list helpers instead of the PCI address space. Interrupt delivery
> goes through qemu_set_irq() in ufs_irq_check(). The realize path is
> split into a transport-agnostic ufs_realize_core() plus ufs_init_mmio(),
> and UfsBus gains an 'hc' back-pointer so ufs_lu_realize() no longer
> reaches through the PCI device. TYPE_UFS remains a PCI device, so
> '-device ufs' is unchanged and the PCI ufs-tests qtests still pass.
>
> Two small behaviour additions ride along on the core so that frontends
> with differing geometry and bus-scan behaviour can be modelled:
>
>    - ufs-lu gains configurable 'logical-block-size' property. It
>      defaults to UFS_BLOCK_SIZE, so the PCI device is unaffected.
>
>    - an unmapped LUN now answers INQUIRY as "not connected" rather than
>      failing the request, so that a host bus-scan does not observe
>      controller errors for absent LUNs.
>
> Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
> ---
>   hw/ufs/ufs.h | 18 ++++++++++++++++-
>   hw/ufs/lu.c  | 50 +++++++++++++++++++++++++++++++++++++++++----
>   hw/ufs/ufs.c | 57 ++++++++++++++++++++++++++++++++++++----------------
>   3 files changed, 103 insertions(+), 22 deletions(-)
>
> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
> index feb47f460d..3d4be8deb5 100644
> --- a/hw/ufs/ufs.h
> +++ b/hw/ufs/ufs.h
> @@ -12,7 +12,9 @@
>   #define HW_UFS_UFS_H
>   
>   #include "hw/pci/pci_device.h"
> +#include "hw/core/sysbus.h"
>   #include "hw/scsi/scsi.h"
> +#include "scsi/constants.h"
>   #include "block/ufs.h"
>   
>   #define UFS_MAX_LUS 32
> @@ -27,6 +29,7 @@ typedef struct UfsBusClass {
>   
>   typedef struct UfsBus {
>       BusState parent_bus;
> +    struct UfsHc *hc; /* host controller owning this bus (frontend-agnostic) */
>   } UfsBus;
>   
>   #define TYPE_UFS_BUS "ufs-bus"
> @@ -77,6 +80,7 @@ typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
>   typedef struct UfsLu {
>       DeviceState qdev;
>       uint8_t lun;
> +    uint32_t logical_block_size;
>       UnitDescriptor unit_desc;
>       SCSIBus bus;
>       SCSIDevice *scsi_dev;
> @@ -141,7 +145,15 @@ typedef struct UfsWb {
>   } UfsWb;
>   
>   typedef struct UfsHc {
> -    PCIDevice parent_obj;
> +    /*
> +     * The controller can be instantiated either as a PCI function or as a
> +     * sysbus device.  Following the SDHCI model, both frontends share this
> +     * state structure via a union of the possible parent objects.
> +     */
> +    union {
> +        PCIDevice pci_dev;
> +        SysBusDevice sbdev;
> +    };
>       UfsBus bus;
>       MemoryRegion iomem;
>       UfsReg reg;
> @@ -162,6 +174,7 @@ typedef struct UfsHc {
>       Flags flags;
>   
>       qemu_irq irq;
> +    AddressSpace *dma_as;
>       QEMUBH *doorbell_bh;
>       QEMUBH *complete_bh;
>   
> @@ -302,4 +315,7 @@ void ufs_build_query_response(UfsRequest *req);
>   void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
>   void ufs_wb_update_avail_buffer(UfsHc *u);
>   void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
> +UfsReqResult ufs_emulate_absent_lun(UfsRequest *req);
> +void ufs_init_mmio(UfsHc *u);
> +bool ufs_realize_core(UfsHc *u, Error **errp);
>   #endif /* HW_UFS_UFS_H */
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> index 13f4a90145..a0b5574668 100644
> --- a/hw/ufs/lu.c
> +++ b/hw/ufs/lu.c
> @@ -308,6 +308,44 @@ static int ufs_emulate_wlun_inquiry(UfsRequest *req, uint8_t *outbuf,
>       return SCSI_INQUIRY_LEN;
>   }
>   
> +UfsReqResult ufs_emulate_absent_lun(UfsRequest *req)
> +{
> +    QEMU_UNINITIALIZED uint8_t outbuf[SCSI_INQUIRY_LEN];
> +    uint8_t sense_buf[UFS_SENSE_SIZE];
> +    uint8_t scsi_status;
> +    int len = 0;
> +
> +    if (req->req_upiu.sc.cdb[0] == INQUIRY &&
> +        !(req->req_upiu.sc.cdb[1] & 0x1)) {
> +        /*
> +         * Standard INQUIRY to a logical unit that is not mapped: report it
> +         * as "not connected" (peripheral qualifier 0x3, device type 0x1f)
> +         * with GOOD status, like real hardware. Host-side bus scans then
> +         * skip the unit quietly instead of flagging a controller error.
> +         */
> +        memset(outbuf, 0, sizeof(outbuf));
> +        outbuf[0] = TYPE_NO_LUN;
> +        outbuf[3] = 0x2;
> +        outbuf[4] = SCSI_INQUIRY_LEN - 5;
> +        len = SCSI_INQUIRY_LEN;
> +        scsi_status = GOOD;
> +    } else {
> +        scsi_build_sense(sense_buf, SENSE_CODE(LUN_NOT_SUPPORTED));
> +        scsi_status = CHECK_CONDITION;
> +    }
> +
> +    len = MIN(len, (int)req->data_len);
> +    if (scsi_status == GOOD && len > 0 &&
> +        dma_buf_read(outbuf, len, NULL, req->sg, MEMTXATTRS_UNSPECIFIED) !=
> +            MEMTX_OK) {
> +        return UFS_REQUEST_FAIL;
> +    }
> +
> +    ufs_build_scsi_response_upiu(req, sense_buf, sizeof(sense_buf), len,
> +                                 scsi_status);
> +    return UFS_REQUEST_SUCCESS;
> +}
> +
>   static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
>   {
>       uint8_t lun = lu->lun;
> @@ -394,6 +432,8 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
>   static const Property ufs_lu_props[] = {
>       DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
>       DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
> +    DEFINE_PROP_UINT32("logical-block-size", UfsLu, logical_block_size,
> +                       UFS_BLOCK_SIZE),
>   };
>   
>   static bool ufs_add_lu(UfsHc *u, UfsLu *lu, Error **errp)
> @@ -435,7 +475,7 @@ static void ufs_init_lu(UfsLu *lu)
>       lu->unit_desc.length = sizeof(UnitDescriptor);
>       lu->unit_desc.descriptor_idn = UFS_QUERY_DESC_IDN_UNIT;
>       lu->unit_desc.lu_enable = 0x01;
> -    lu->unit_desc.logical_block_size = UFS_BLOCK_SIZE_SHIFT;
> +    lu->unit_desc.logical_block_size = ctz32(lu->logical_block_size);
>       lu->unit_desc.unit_index = lu->lun;
>       lu->unit_desc.logical_block_count =
>           cpu_to_be64(brdv_len / (1 << lu->unit_desc.logical_block_size));
> @@ -475,8 +515,10 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
>       scsi_dev = qdev_new("scsi-hd");
>       object_property_add_child(OBJECT(&lu->bus), "ufs-scsi", OBJECT(scsi_dev));
>   
> -    qdev_prop_set_uint32(scsi_dev, "physical_block_size", UFS_BLOCK_SIZE);
> -    qdev_prop_set_uint32(scsi_dev, "logical_block_size", UFS_BLOCK_SIZE);
> +    qdev_prop_set_uint32(scsi_dev, "physical_block_size",
> +                         lu->logical_block_size);
> +    qdev_prop_set_uint32(scsi_dev, "logical_block_size",
> +                         lu->logical_block_size);
>       qdev_prop_set_uint32(scsi_dev, "scsi-id", 0);
>       qdev_prop_set_uint32(scsi_dev, "lun", lu->lun);
>       if (!qdev_prop_set_drive_err(scsi_dev, "drive", blk, errp)) {
> @@ -497,7 +539,7 @@ static void ufs_lu_realize(DeviceState *dev, Error **errp)
>   {
>       UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
>       BusState *s = qdev_get_parent_bus(dev);
> -    UfsHc *u = UFS(s->parent);
> +    UfsHc *u = UFS_BUS(s)->hc;
>       BlockBackend *blk = lu->conf.blk;
>   
>       if (!ufs_lu_check_constraints(lu, errp)) {
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 464fd465b3..1489bd3321 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -102,7 +102,8 @@ static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
>           return MEMTX_DECODE_ERROR;
>       }
>   
> -    return pci_dma_read(PCI_DEVICE(u), addr, buf, size);
> +    return dma_memory_read(u->dma_as, addr, buf, size,
> +                           MEMTXATTRS_UNSPECIFIED);
>   }
>   
>   static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
> @@ -117,7 +118,8 @@ static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
>           return MEMTX_DECODE_ERROR;
>       }
>   
> -    return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
> +    return dma_memory_write(u->dma_as, addr, buf, size,
> +                            MEMTXATTRS_UNSPECIFIED);
>   }
>   
>   static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
> @@ -222,7 +224,7 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
>       }
>   
>       req->sg = g_malloc0(sizeof(QEMUSGList));
> -    pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
> +    qemu_sglist_init(req->sg, DEVICE(u), prdt_len, u->dma_as);
>       req->data_len = 0;
>   
>       for (uint16_t i = 0; i < prdt_len; ++i) {
> @@ -317,14 +319,12 @@ static MemTxResult ufs_dma_write_upiu(UfsRequest *req)
>   
>   static void ufs_irq_check(UfsHc *u)
>   {
> -    PCIDevice *pci = PCI_DEVICE(u);
> -
>       if ((u->reg.is & UFS_INTR_MASK) & u->reg.ie) {
>           trace_ufs_irq_raise();
> -        pci_irq_assert(pci);
> +        qemu_set_irq(u->irq, 1);
>       } else {
>           trace_ufs_irq_lower();
> -        pci_irq_deassert(pci);
> +        qemu_set_irq(u->irq, 0);
>       }
>   }
>   
> @@ -1092,7 +1092,7 @@ static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
>   
>       if (!is_wlun(lun) && (lun >= UFS_MAX_LUS || u->lus[lun] == NULL)) {
>           trace_ufs_err_scsi_cmd_invalid_lun(lun);
> -        return UFS_REQUEST_FAIL;
> +        return ufs_emulate_absent_lun(req);
>       }
>   
>       switch (lun) {
> @@ -2488,6 +2488,12 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
>       return true;
>   }
>   
> +void ufs_init_mmio(UfsHc *u)
> +{
> +    memory_region_init_io(&u->iomem, OBJECT(u), &ufs_mmio_ops, u, "ufs",
> +                          u->reg_size);
> +}
> +
>   static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
>   {
>       uint8_t *pci_conf = pci_dev->config;
> @@ -2495,8 +2501,7 @@ static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
>       pci_conf[PCI_INTERRUPT_PIN] = 1;
>       pci_config_set_prog_interface(pci_conf, 0x1);
>   
> -    memory_region_init_io(&u->iomem, OBJECT(u), &ufs_mmio_ops, u, "ufs",
> -                          u->reg_size);
> +    ufs_init_mmio(u);
>       pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &u->iomem);
>       u->irq = pci_allocate_irq(pci_dev);
>   }
> @@ -2689,25 +2694,43 @@ static void ufs_init_hc(UfsHc *u)
>       timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
>   }
>   
> -static void ufs_realize(PCIDevice *pci_dev, Error **errp)
> +/*
> + * Frontend-agnostic realization: everything except the host-bus specific
> + * MMIO/IRQ/DMA plumbing, which the PCI or sysbus frontend sets up around
> + * this call.  The frontend must assign u->dma_as before calling.
> + */
> +bool ufs_realize_core(UfsHc *u, Error **errp)
>   {
> -    UfsHc *u = UFS(pci_dev);
> -
>       if (!ufs_check_constraints(u, errp)) {
> -        return;
> +        return false;
>       }
>   
> -    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, &pci_dev->qdev,
> -              u->parent_obj.qdev.id);
> +    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, DEVICE(u),
> +              DEVICE(u)->id);
> +    u->bus.hc = u;
>   
>       ufs_init_state(u);
>       ufs_init_hc(u);
> -    ufs_init_pci(u, pci_dev);
>   
>       ufs_init_wlu(&u->report_wlu, UFS_UPIU_REPORT_LUNS_WLUN);
>       ufs_init_wlu(&u->dev_wlu, UFS_UPIU_UFS_DEVICE_WLUN);
>       ufs_init_wlu(&u->boot_wlu, UFS_UPIU_BOOT_WLUN);
>       ufs_init_wlu(&u->rpmb_wlu, UFS_UPIU_RPMB_WLUN);
> +
> +    return true;
> +}
> +
> +static void ufs_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    UfsHc *u = UFS(pci_dev);
> +
> +    u->dma_as = pci_get_address_space(pci_dev);
> +
> +    if (!ufs_realize_core(u, errp)) {
> +        return;
> +    }
> +
> +    ufs_init_pci(u, pci_dev);
>   }
>   
>   static void ufs_exit(PCIDevice *pci_dev)

