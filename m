Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E586EEA794D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 23:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnm63-0007zv-Ox; Wed, 04 Feb 2026 18:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkgm-0002XS-CJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:45:32 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkgc-0003JQ-8J
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:45:32 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1233c155a42so446055c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241467; cv=none;
 d=google.com; s=arc-20240605;
 b=Aq1VAkIPsSoMHZ3ic5PO3tj4ncw9VB2SCVgsFGOkcjMTyue6seM5fVggWxOvrZbqV7
 o72QpODJDLrxBxCsssKrBIeLPIa9j83BosBuGtSRsBVU4Hgn6Epbm/HNZmkTVmkz7p4a
 Do9/k7a6x4lWlqcgH1sp3U03bdTRSPbd/2LJZb9/cf7kYzDrFJEHpKYidjrAD0grifR/
 S4QrLNK7j3TFUAR2vg+HdhoWpiHiA0dO6vV1SeCJhTpVMeFRb21Ib4Qt7L9ZIFN8iv09
 38HQNHcmPK3Z/+yJnbFQRoIaWI8Z8pM2diPS49c/k6SZoZP6eQTKO2RPfD4/LhAYIa/G
 rS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PvTtBBJSlojlrae51xh5mjCo03hqZlOza85tsomIVDQ=;
 fh=n4VmXzZeAcby728BbqFOg6UV9Vk8m+071RLfAy19yhI=;
 b=Smh0lSzfnxOyUvqzBrCt8zThz5CIiPfIekf9qgbMI20e6+6au+fVj+0hBOPSe2bwrJ
 uICetGfIYe1r5oliInnMIIkoFn8wSrEa1+V2mejtwMccS04/Fi8j54Ke+O+WVoFZGIxM
 +26xhDe35T/Mdcapl8sIBLJdOPMyJeqP7qLc2l+2m0Hvj0z2qt/mT7lmvLuj6BbAbnSY
 PPjc/Jtp1eXS581O3MM4FMtSmBrJdhD9Tol6KyrtFpOiG/1y+IDpVCXZ8nbLA3IWTZpq
 IpIoCDUnJvK+9m/ggGh5hSK1niIzGH8RGrPaaEcMvYoFDYYOdPVW251Cv6uXPGuJVEBS
 r0EA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770241467; x=1770846267; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvTtBBJSlojlrae51xh5mjCo03hqZlOza85tsomIVDQ=;
 b=awr1yr71H1vlrjHdzQZjQavwYvswU1pz1K8tFcMrQFnEKbxlCno1a8OxCetaQOaDi/
 vIC9AVCKwxBp7c9CpL6mNAMCdgxx21luBx92V1KLxUad/ohsii5IcwE6ZgmUOAPu6Yvz
 zuSbu3AabkrjH0BJsprn0ibRUKz2pALMJBPiqx+nsKyNcz3m3x5wSsncjNfFhY1BI/mi
 2At2NfbJnxfo6JUnk5Fd0IvFscXjoDZyfaTfI0Q4pvCDdQxanSrtrMK3cVu5iLywLEaj
 5Ndu/i0ryWzcQ2dmOMOfID55mL7UpQfHluUdOAuch/SmACbhifQasvnGsMeOXKJ4WwKc
 inKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770241467; x=1770846267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PvTtBBJSlojlrae51xh5mjCo03hqZlOza85tsomIVDQ=;
 b=w1xZ+I328VBnXIDO2Lv0l2GVQ7tC7/QBMQahPxU0xhdrvDqGxb2640jxgit4BVXLp6
 pqwGevtPfFv+HgyOO4qEeYqN4sPWhr0r8EcVWFEAMwh3TJgvwkJv6cYCJclfT12uTesK
 229mN4sAuSkagQ/MlYTWd8DNF0Pk2hAA5Juyprz8bkepUUJIqxfBo7dJt9Ney+kbHdDb
 mH502GJjPU0OZ+gWO9jOpfpKLu0Tvx5bsHsSxZq30c88ED1U8Y6Mv41JuAu4KvAutqh5
 87AEikL8eqqljo4hkmv4wlweM4YOJN/9q5uhfVI3uDfnYRCSnvA3OEV7o+l4zGZqK/3v
 glNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2uf9eztxfvQ/+TZ8+xcknqCFkWyXNJ9cydfrga8OolcTtabqG1+vtVTZ/WeagRHvCBLYrJwTOlfUD@nongnu.org
X-Gm-Message-State: AOJu0Ywv0wp63d3IZaf8J2e/Uc4tOMLgUKWpdInWKGZcqYy01py58wTB
 3Zeet8IO1xIqYjtyR4894WTvPnJvAAoRyIzZ173oHMSqHiptqxhnoR9eBUwESvVAs2UbRTqU/VU
 37HxUwtZVjP/JmCEpvTdISmftAJuzNg==
X-Gm-Gg: AZuq6aLdu6F3nsJcINV8YN/o4mhRW3uX6hSCaL9sWAoIn1N70Vkr9rEqlIndalfsT91
 It+gGgIo5Ni8XKAWzQupaxA+YPIc8tQ5iFZzoyPN66BY7nqnlsfAAIDyYpEhn6PANnudmS3VEy5
 JREqgbyLLt9jfrsUT74oV4BRFIRT3x4iF02pjLhecXCcCLstx3E4akYc0+XZQjBjnhF76BgbasG
 wj3jMJfRO5L84U+3pfW8oPdZ5aLiKeS/tPKBozUNJBUWgOMxGx3UWEKGoKaLbkzsKprClQ=
X-Received: by 2002:a05:7022:403:b0:11e:3e9:3e9f with SMTP id
 a92af1059eb24-126f48ee2cemr1851333c88.50.1770241467170; Wed, 04 Feb 2026
 13:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
 <20260119111542.788389-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-5-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:44:14 -0800
X-Gm-Features: AZwV_Qgepb2j0CPBa1ynab4EN2iLg4ekEsMtjEklsND7qpJKBHYIWjjvjqEGAeI
Message-ID: <CALa+Y15pZYQU3xB+5xudhPiJVKwd29k0g+itFSgydPoGLoqi_Q@mail.gmail.com>
Subject: Re: [PATCH qemu v4 4/5] hw/cxl/events: Updates for rev3.2 DRAM event
 record
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
 shiju.jose@huawei.com, 
 armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
 Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=ravis.opensrc@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 18:15:41 -0500
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

On Mon, Jan 19, 2026 at 3:21=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
> has updated with following new fields.
> 1. Component Identifier
> 2. Sub-channel of the memory event location
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Volatile Memory Error Count at Event
> 5. Memory Event Sub-Type
>
> Add updates for the above spec changes in the CXL DRAM event
> reporting and QMP command to inject DRAM event.
>
> In order to ensure consistency update all specification references
> for this command to CXL r3.2.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: Update spec reference in related command as well (Markus)
> v3: Update all spec references for this command to 3.2 for consistency
>    (Markus)
> ---
>  qapi/cxl.json               | 33 ++++++++++++++++++++++-------
>  include/hw/cxl/cxl_events.h |  9 ++++++--
>  hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  7 +++++++
>  4 files changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4ff66fc6c16c..1dc8b08ca301 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -131,21 +131,21 @@
>  ##
>  # @CXLDRAMEvent:
>  #
> -# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
> -#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> +#     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
>  #     Event Record, Physical Address.
>  #
>  # @descriptor: Memory Event Descriptor with additional memory event
> -#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
> +#     information.  See CXL r3.2 Table 8-58 DRAM Event Record, Memory
>  #     Event Descriptor for bit definitions.
>  #
> -# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
> +# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-58
>  #     DRAM Event Record, Memory Event Type for possible values.
>  #
>  # @transaction-type: Type of first transaction that caused the event
> -#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
> +#     to occur.  See CXL r3.2 Table 8-58 DRAM Event Record,
>  #     Transaction Type for possible values.
>  #
>  # @channel: The channel of the memory event location.  A channel is an
> @@ -169,6 +169,21 @@
>  # @correction-mask: Bits within each nibble.  Used in order of bits
>  #     set in the nibble-mask.  Up to 4 nibbles may be covered.
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-channel: The sub-channel of the memory event location.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#
> +# @cvme-count: Corrected volatile memory error count at event.
> +#
> +# @sub-type: Memory event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLDRAMEvent',
> @@ -177,13 +192,17 @@
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint=
32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> -            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            '*sub-channel':'uint8',
> +            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
> +            'sub-type':'uint8'
>             }}
>
>  ##
>  # @cxl-inject-dram-event:
>  #
> -# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
>  # This event type is reported via one of the event logs
>  # specified via the log parameter.
>  #
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 352f9891bd36..a3c5f2ec20e6 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -138,7 +138,7 @@ typedef struct CXLEventGenMedia {
>
>  /*
>   * DRAM Event Record
> - * CXL r3.1 Section 8.2.9.2.1.2: Table 8-46
> + * CXL r3.2 Section 8.2.10.2.1.2: Table 8-58
>   * All fields little endian.
>   */
>  typedef struct CXLEventDram {
> @@ -156,7 +156,12 @@ typedef struct CXLEventDram {
>      uint8_t row[3];
>      uint16_t column;
>      uint64_t correction_mask[4];
> -    uint8_t reserved[0x17];
> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t sub_channel;
> +    uint8_t cme_ev_flags;
> +    uint8_t cvme_count[3];
> +    uint8_t sub_type;
> +    uint8_t reserved;
>  } QEMU_PACKED CXLEventDram;
>
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d03a9f0edc29..3da538bafb64 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1783,6 +1783,13 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>  #define CXL_DRAM_VALID_ROW                              BIT(5)
>  #define CXL_DRAM_VALID_COLUMN                           BIT(6)
>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
> +#define CXL_DRAM_VALID_COMPONENT                        BIT(8)
> +#define CXL_DRAM_VALID_COMPONENT_ID_FORMAT              BIT(9)
> +#define CXL_DRAM_VALID_SUB_CHANNEL                      BIT(10)
> +
> +#define CXL_DRAM_EV_DESC_UCE                            BIT(0)
> +#define CXL_DRAM_EV_DESC_THRESHOLD_EVENT                BIT(1)
> +#define CXL_DRAM_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
>
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
>                                 uint32_t flags,
> @@ -1802,6 +1809,12 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log,
>                                 bool has_column, uint16_t column,
>                                 bool has_correction_mask,
>                                 uint64List *correction_mask,
> +                               const char *component_id,
> +                               bool has_comp_id_pldm, bool is_comp_id_pl=
dm,
> +                               bool has_sub_channel, uint8_t sub_channel=
,
> +                               bool has_cme_ev_flags, uint8_t cme_ev_fla=
gs,
> +                               bool has_cvme_count, uint32_t cvme_count,
> +                               uint8_t sub_type,
>                                 Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
> @@ -1888,6 +1901,35 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log,
>          valid_flags |=3D CXL_DRAM_VALID_CORRECTION_MASK;
>      }
>
> +    if (component_id) {
> +        strncpy((char *)dram.component_id, component_id,
> +                sizeof(dram.component_id) - 1);
> +        valid_flags |=3D CXL_DRAM_VALID_COMPONENT;
> +        if (has_comp_id_pldm && is_comp_id_pldm) {
> +            valid_flags |=3D CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
> +        }
> +    }
> +
> +    if (has_sub_channel) {
> +        dram.sub_channel =3D sub_channel;
> +        valid_flags |=3D CXL_DRAM_VALID_SUB_CHANNEL;
> +    }
> +
> +    if (has_cme_ev_flags) {
> +        dram.cme_ev_flags =3D cme_ev_flags;
> +    } else {
> +        dram.cme_ev_flags =3D 0;
> +    }
> +
> +    if (has_cvme_count) {
> +        descriptor |=3D CXL_DRAM_EV_DESC_THRESHOLD_EVENT;

Same issue as the general media event patch - the modification to
 'descriptor' is not written back to dram.descriptor which was assigned
earlier.

> +        st24_le_p(dram.cvme_count, cvme_count);
> +    } else {
> +        st24_le_p(dram.cvme_count, 0);
> +    }
> +
> +    dram.sub_type =3D sub_type;
> +
>      stw_le_p(&dram.validity_flags, valid_flags);
>
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 2047e9784694..231dda263fa4 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -53,6 +53,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEv=
entLog log,
>                                 bool has_column, uint16_t column,
>                                 bool has_correction_mask,
>                                 uint64List *correction_mask,
> +                               const char *component_id,
> +                               bool has_comp_id_pldm,
> +                               bool is_comp_id_pldm,
> +                               bool has_sub_channel, uint8_t sub_channel=
,
> +                               bool has_cme_ev_flags, uint8_t cme_ev_fla=
gs,
> +                               bool has_cvme_count, uint32_t cvme_count,
> +                               uint8_t sub_type,
>                                 Error **errp) {}
>
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
> --
> 2.48.1
>
>

