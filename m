Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E047EEA794A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 23:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnm65-000802-Ut; Wed, 04 Feb 2026 18:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkWx-0001R3-Tm
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:35:23 -0500
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkWv-0002fs-2W
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:35:23 -0500
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-12460a7caa2so416384c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:35:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770240919; cv=none;
 d=google.com; s=arc-20240605;
 b=VAG77DG6nA49bXMcXGO96r41Cr24scRuFrrtDYFwFqXzp5EI3bzk0f3LEWUdBlWUP+
 TQmgENV5DOsHP0WT9V7nLVp/pjFOm7dd4B0o+ltFpFaTf3mUEb4gKa1vHFlf5WKFRoES
 IQy9GFm+jrKmLhtoGPMDDtTL9mamCjO1/upOTRa6T3PSyvxEZw3vN86QvL8/R/OW/MxZ
 7LA1Ae7QyTN1ZE59iDZMTjqw2xPsLLfFJOULPqTbdMwpDdj5nsznKvrLiDmJpUn7Uelv
 1hVYmuKQiI3stoqJLA9LyNRPY1DsnUEvYVv873v9tZ9gRjJxMluphTKcTPthgPUAwoSO
 SzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M3RQ59nUZ9Towd8GDsZPSDQjnVq07JYcR2GuclUxKQ0=;
 fh=MhSzTH+R64L3AukYtzap7dGayDkH+XAevKXN7juvoIQ=;
 b=DHUZVvmE55Q0xUZQbhBJYnwae9NrWSsNgfyW9RXrHpU7aZMSffRo8I0m8UlgoC0kim
 +hz1NzC6V4lXhOnjHY4BqA7PUD4QyShPKsiMbayH8nep3GrNzBRgYHzTlxtqtdJ/zmOf
 H9i9K3AJLm2uZRsNtdFN7GexX/ExLzrBNIJjF8klIiqojN3K97heWW4NYM+921mf5WfR
 Tgp464gKHZd+l4fxjJQ7LAGHR68W8COmgR3XENICANt1DpRyWiNibtY+GUXI0U4vKMto
 XyTFgzpqBvfbHW32Lm9yspvo5EJo/mM+SQG90v7YO87KQs/+78V0wMOZU9c9lQ78e6cc
 wcIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770240919; x=1770845719; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3RQ59nUZ9Towd8GDsZPSDQjnVq07JYcR2GuclUxKQ0=;
 b=f0Y2jZUKnAagx7j7aYBU2Y6nywF6T7/tj+ABDVHWAcYadRVoztOytSZ5e6y/1yYV7o
 eE9iuPq10md7a9AUGOZXIBdkGlma1crirLeANiyrxlzO80UOM+Mex0llHsSqs3Xq+WrO
 McCsSjo2rAriNHxI0haBlJWpEPU8PB/6p9NZn85yANyyT9nPZ/uGKj/6x4+D1Uj1yTnE
 H6CJVe/1TfjTi3GkprzxMlVPOY39UcRxhmS1XroHsgH3D9qWFNHVVKfkPPCxypW4qgQr
 nREvu+kIbo//geDorSY8CIBopGP+gdgevbi4K2tyilpkOdZk66+PRwW9m0quiqBZBDbM
 m4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770240919; x=1770845719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3RQ59nUZ9Towd8GDsZPSDQjnVq07JYcR2GuclUxKQ0=;
 b=QoQXRbbooezKaNX7iRsPNBf98RRjdkSledc2+5W6H4Lq6LcHAFpftxpIEChIOgaZrJ
 lqSRaALkhrXA4bQpLQMIwgBSSe1qClIsn6GgUjVxS3ESjB79VEeptAtiwcJRZSFlOJzS
 Y8i0BZcAoBsISc+1txUyXPBNyN3Kv7Z0mDkbyZMF9cadH3gvFbDcPFXGhDlVzfkYgVkJ
 8EmdOJNgFd2PEn1aNp7KI/ts65nE68NbSiebDORp5AZFBbL0SOCujRnPGCtW6FwyAHop
 JQRUZJP/GZyuaZgpCnsscvmPeltwwmq7RwrXzqB/Ac6AG7KnvhjcaFkv9ACXkeke0BID
 nSYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjlNeClInhcCxxTf3fJAqstVYMCzWgDUHnTgWxIBkhhAULqnuoorrpvsYyVBCIaEx2WQ+R7vUavIug@nongnu.org
X-Gm-Message-State: AOJu0YwxEppGcp8MXYGN+KGnHmNjE3DHecllDT61exjXRSoqYAAETFDA
 zfw3lGU5xnqnmGVKTH3dPKmIVhf78rmLAJ4veN410fuSOrIupsOGzsuwGoriJr2uWEcz1HxkWEw
 zK6omsKtLJdY3NhG8CJmsDDCmzSiwgw==
X-Gm-Gg: AZuq6aLA8dyVb8JIq4lel7BhU1K/G/GXXbtA/cIggGr7CHFRvZNGU7ygQ760bLn/o3h
 KxL2CVXt0aoP3Tl+POqM9ZNaOsfk3W9YPO3dZ6rYTzymEVpXcjXIpmeQVElaoJC0zb7nFni21oZ
 qcgXeB43AaGEz4cHkPcNA1BuBNnJ4FV78IlpDuQgW9LFBpsXvillZ/SXUVCZJlNCnN2cs7iv/A6
 c1+QL6/KxcU6JVytO36fPPdeXcYRCPhILF7K5NbVNJq+OvKkJcLv2HJ+av15HkH+SfNYKk=
X-Received: by 2002:a05:7022:6b9b:b0:124:9e46:82fb with SMTP id
 a92af1059eb24-126f47d9bf5mr1768151c88.38.1770240919229; Wed, 04 Feb 2026
 13:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
 <20260119111542.788389-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-3-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:35:07 -0800
X-Gm-Features: AZwV_QgkXMJg8jDxHD0sl5cCn0DBoKKDr62lcBMCAWXiD11iLe_MubokxRMQjtU
Message-ID: <CALa+Y16OT6Ew_fhC-Y_=E3N3E_eGHWt3yQuFJJS6Za1Wt8jMBg@mail.gmail.com>
Subject: Re: [PATCH qemu v4 2/5] hw/cxl/events: Update for rev3.2 common event
 record format
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
 shiju.jose@huawei.com, 
 armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
 Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=ravis.opensrc@gmail.com; helo=mail-dl1-x1243.google.com
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

On Mon, Jan 19, 2026 at 3:16=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
>
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
>
> Update all related specification references to CXL r3.2 to ensure
> one consistent source.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Expand the LD acronym (Markus)
> ---
>  qapi/cxl.json               | 21 ++++++++---
>  include/hw/cxl/cxl_device.h |  7 +++-
>  include/hw/cxl/cxl_events.h | 15 ++++++--
>  hw/cxl/cxl-events.c         |  3 +-
>  hw/cxl/cxl-mailbox-utils.c  |  3 +-
>  hw/mem/cxl_type3.c          | 70 ++++++++++++++++++++++++++++++++-----
>  hw/mem/cxl_type3_stubs.c    | 24 +++++++++++--
>  7 files changed, 122 insertions(+), 21 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 55a088586e53..82001c0591d8 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -33,20 +33,33 @@
>  ##
>  # @CXLCommonEventBase:
>  #
> -# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> -# Table 8-42 Common Event Record Format).
> +# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
> +# Table 8-55 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
>  # @log: event log to add the event to
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> +# @flags: Event Record Flags.  See CXL r3.2 Table 8-55 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @maint-op-class: Maintenance operation class the device requests to
> +#     initiate.
> +#
> +# @maint-op-subclass: Maintenance operation subclass the device
> +#     requests to initiate.
> +#
> +# @ld-id: Logical Device (LD) ID of LD from where the event
> +#     originated.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLCommonEventBase',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> +            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> +            '*ld-id':'uint16', '*head-id':'uint8' } }
>
>  ##
>  # @CXLGeneralMediaEvent:
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 165355baf9da..e461a824b692 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -723,7 +723,12 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d,=
 uint64_t dpa,
>                                    uint64_t len);
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
> -                             uint8_t length, uint64_t timestamp);
> +                             uint8_t length, uint64_t timestamp,
> +                             bool has_maint_op_class, uint8_t maint_op_c=
lass,
> +                             bool has_maint_op_subclass,
> +                             uint8_t maint_op_subclass,
> +                             bool has_ld_id, uint16_t ld_id,
> +                             bool has_head_id, uint8_t head_id);
>  void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
>                                               CXLDCEventType type,
>                                               CXLDCExtentRaw extents[],
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 758b075a64b9..4d9cfdb621ea 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -29,9 +29,15 @@ typedef enum CXLEventLogType {
>
>  /*
>   * Common Event Record Format
> - * CXL r3.1 section 8.2.9.2.1: Event Records; Table 8-43
> + * CXL r3.2 section 8.2.10.2.1: Event Records; Table 8-55
>   */
> -#define CXL_EVENT_REC_HDR_RES_LEN 0xf
> +#define CXL_EVENT_REC_FLAGS_PERMANENT_COND BIT(2)
> +#define CXL_EVENT_REC_FLAGS_MAINT_NEEDED   BIT(3)
> +#define CXL_EVENT_REC_FLAGS_PERF_DEGRADED  BIT(4)
> +#define CXL_EVENT_REC_FLAGS_HW_REPLACEMENT_NEEDED BIT(5)
> +#define CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID BIT(6)
> +#define CXL_EVENT_REC_FLAGS_LD_ID_VALID BIT(7)
> +#define CXL_EVENT_REC_FLAGS_HEAD_ID_VALID BIT(8)
>  typedef struct CXLEventRecordHdr {
>      QemuUUID id;
>      uint8_t length;
> @@ -40,7 +46,10 @@ typedef struct CXLEventRecordHdr {
>      uint16_t related_handle;
>      uint64_t timestamp;
>      uint8_t maint_op_class;
> -    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
> +    uint8_t maint_op_subclass;
> +    uint16_t ld_id;
> +    uint8_t head_id;
> +    uint8_t reserved[0xb];
>  } QEMU_PACKED CXLEventRecordHdr;
>
>  #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 7583dd9162f6..5356dfb5b300 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -271,7 +271,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3=
Dev *ct3d,
>                              &dynamic_capacity_uuid,
>                              (1 << CXL_EVENT_TYPE_INFO),
>                              sizeof(event_rec),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            0, 0, 0, 0, 0, 0, 0, 0);
>      event_rec.type =3D type;
>      event_rec.validity_flags =3D 1;
>      event_rec.host_id =3D 0;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6cfdd98168f9..e9528da70cc4 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3458,7 +3458,8 @@ static CXLRetCode cmd_fm_set_dc_region_config(const=
 struct cxl_cmd *cmd,
>                              &dynamic_capacity_uuid,
>                              (1 << CXL_EVENT_TYPE_INFO),
>                              sizeof(dcEvent),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            0, 0, 0, 0, 0, 0, 0, 0);
>      dcEvent.type =3D DC_EVENT_REGION_CONFIG_UPDATED;
>      dcEvent.validity_flags =3D 1;
>      dcEvent.host_id =3D 0;
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6eb20137a04f..371bd4dc6ab2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1592,12 +1592,39 @@ void qmp_cxl_inject_correctable_error(const char =
*path, CxlCorErrorType type,
>
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
> -                             uint8_t length, uint64_t timestamp)
> +                             uint8_t length, uint64_t timestamp,
> +                             bool has_maint_op_class, uint8_t maint_op_c=
lass,
> +                             bool has_maint_op_subclass,
> +                             uint8_t maint_op_subclass,
> +                             bool has_ld_id, uint16_t ld_id,
> +                             bool has_head_id, uint8_t head_id)
>  {
> -    st24_le_p(&hdr->flags, flags);
>      hdr->length =3D length;
>      memcpy(&hdr->id, uuid, sizeof(hdr->id));
>      stq_le_p(&hdr->timestamp, timestamp);
> +
> +    if (has_maint_op_class) {
> +        hdr->maint_op_class =3D maint_op_class;
> +    } else {
> +        hdr->maint_op_class =3D 0;
> +    }
> +
> +    if (has_maint_op_subclass) {
> +        flags |=3D CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID;
> +        hdr->maint_op_subclass =3D maint_op_subclass;
> +    }
> +
> +    if (has_ld_id) {
> +        flags |=3D CXL_EVENT_REC_FLAGS_LD_ID_VALID;
> +        stw_le_p(&hdr->ld_id, ld_id);
> +    }
> +
> +    if (has_head_id) {
> +        flags |=3D CXL_EVENT_REC_FLAGS_HEAD_ID_VALID;
> +        hdr->head_id =3D head_id;
> +    }
> +
> +    st24_le_p(&hdr->flags, flags);
>  }
>
>  static const QemuUUID gen_media_uuid =3D {
> @@ -1637,7 +1664,13 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog =
log)
>  }
>  /* Component ID is device specific.  Define this as a string. */
>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint64_t dpa,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint64_t dpa,
>                                          uint8_t descriptor, uint8_t type=
,
>                                          uint8_t transaction_type,
>                                          bool has_channel, uint8_t channe=
l,
> @@ -1675,7 +1708,10 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>
>      memset(&gem, 0, sizeof(gem));
>      cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            has_maint_op_class, maint_op_class,
> +                            has_maint_op_subclass, maint_op_subclass,
> +                            has_ld_id, ld_id, has_head_id, head_id);
>
>      stq_le_p(&gem.phys_addr, dpa);
>      gem.descriptor =3D descriptor;
> @@ -1719,7 +1755,13 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>  #define CXL_DRAM_VALID_COLUMN                           BIT(6)
>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
>
> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_=
t flags,
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
> +                               uint32_t flags,
> +                               bool has_maint_op_class, uint8_t maint_op=
_class,
> +                               bool has_maint_op_subclass,
> +                               uint8_t maint_op_subclass,
> +                               bool has_ld_id, uint16_t ld_id,
> +                               bool has_head_id, uint8_t head_id,
>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -1762,7 +1804,10 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log, uint8_t flags,
>
>      memset(&dram, 0, sizeof(dram));
>      cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            has_maint_op_class, maint_op_class,
> +                            has_maint_op_subclass, maint_op_subclass,
> +                            has_ld_id, ld_id, has_head_id, head_id);
>      stq_le_p(&dram.phys_addr, dpa);
>      dram.descriptor =3D descriptor;
>      dram.type =3D type;
> @@ -1822,7 +1867,13 @@ void qmp_cxl_inject_dram_event(const char *path, C=
xlEventLog log, uint8_t flags,
>  }
>
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint8_t type,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint8_t type,
>                                          uint8_t health_status,
>                                          uint8_t media_status,
>                                          uint8_t additional_status,
> @@ -1861,7 +1912,10 @@ void qmp_cxl_inject_memory_module_event(const char=
 *path, CxlEventLog log,
>
>      memset(&module, 0, sizeof(module));
>      cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(modu=
le),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate))=
;
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            has_maint_op_class, maint_op_class,
> +                            has_maint_op_subclass, maint_op_subclass,
> +                            has_ld_id, ld_id, has_head_id, head_id);
>
>      module.type =3D type;
>      module.health_status =3D health_status;
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index c1a5e4a7c193..91b1478114d9 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -14,7 +14,13 @@
>  #include "qapi/qapi-commands-cxl.h"
>
>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint64_t dpa,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint64_t dpa,
>                                          uint8_t descriptor, uint8_t type=
,
>                                          uint8_t transaction_type,
>                                          bool has_channel, uint8_t channe=
l,
> @@ -23,7 +29,13 @@ void qmp_cxl_inject_general_media_event(const char *pa=
th, CxlEventLog log,
>                                          const char *component_id,
>                                          Error **errp) {}
>
> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_=
t flags,
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
> +                               uint32_t flags,
> +                               bool has_maint_op_class, uint8_t maint_op=
_class,
> +                               bool has_maint_op_subclass,
> +                               uint8_t maint_op_subclass,
> +                               bool has_ld_id, uint16_t ld_id,
> +                               bool has_head_id, uint8_t head_id,
>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -38,7 +50,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEv=
entLog log, uint8_t flags,
>                                 Error **errp) {}
>
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
> -                                        uint8_t flags, uint8_t type,
> +                                        uint32_t flags, bool has_maint_o=
p_class,
> +                                        uint8_t maint_op_class,
> +                                        bool has_maint_op_subclass,
> +                                        uint8_t maint_op_subclass,
> +                                        bool has_ld_id, uint16_t ld_id,
> +                                        bool has_head_id, uint8_t head_i=
d,
> +                                        uint8_t type,
>                                          uint8_t health_status,
>                                          uint8_t media_status,
>                                          uint8_t additional_status,
> --
> 2.48.1
>
>
No comments.

Reviewed-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

