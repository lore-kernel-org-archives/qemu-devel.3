Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F23AEA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 23:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnm62-0007yq-IQ; Wed, 04 Feb 2026 18:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkjn-0003VL-Ej
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:48:40 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkjT-0003x1-Uv
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:48:38 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-124a677c9afso297977c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241621; cv=none;
 d=google.com; s=arc-20240605;
 b=AYSeD+4oZUzQoAATxCKhr5MEsPP/kHoPPZxfxTOQhPCtJhDIO4ojmHkkHD0rjo636b
 5IxNjXESJBS8iIkYfWBegxsVloyBuZN6BqrMvP9kvC6EV2FVAsoVFObKNQb0XCY0Jobi
 KJMIR+6LGVjZDun4U9plE/0fQQLdxFKqrppCoNbXEeq7Bn3rYZ3eL4NNMJTk+zacYFw9
 Iq+ZBLBURe3kph5fiH8vU+8KPucVDkeradr28dnzLPYNb64gVw4LjlxkdWUPg4BTe4id
 pOPv5Km5Sf8ohiWdPhftiwQ2lhq4RvehqWHmQPhBf4roEWoV2l4v37dD9wtGsPS2ytpd
 2jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NAnGPKUaTJbrlcxFs0fhKTBs0MXjGFWJLTU73DFyTrE=;
 fh=ScoD48Z9NVMpz4i/xh29uK3YCtOhGR8CwqPjwXfYHLo=;
 b=C111Ge3K4CDZreOU000cYXw9Zd7QTbQlz37hiwXd61KAM+kBO7nG6/pEY2Jf4l51DJ
 YGhlOUO5OfMLxpJLLjgYfSLm+8j78P5B8Odtul70JtFlOmtGpYUV+0gZKxRWhEHEzsUD
 xhC9356ErdE2y0vda2TWE90oYXFRP/6WKUR/Oyi2d5hHFbk1u8gQhWp33oGwwtvjPTCQ
 VL6y17mgv8Kp094/3Z3VgRt8MjcCD7pc7N48x2zbD1i8HPf+yS3rU+zoDU6AfI8+j1pq
 r8+AxQvLuUxP4GMimcaJgnCRnm2xTVClDIsJbSO9FmwXzXAZf7ICB3YgDsznxW7Q7aCw
 sdxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770241621; x=1770846421; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAnGPKUaTJbrlcxFs0fhKTBs0MXjGFWJLTU73DFyTrE=;
 b=KRQoR6OkfczMGVWY/ZDZhXyId53nQDvvsi+PeLYOJ1lFq/MN7ficzSXtqqrvYdB83t
 yxlq0hXJBDzbGjmlAwo3KQ9SB6si+oDXoZxRt5JomG0Ho27kbeTpchPYiVdOElp9oZL3
 G5WJdx+meV0l9jSwrMa8a7FMay330ZU4mmAW7MPuMn7u0OnRzouebMQqYkkroGxROCBU
 x2Lf1BW84Z5OyVA/N9a0X1xkwb6i60fVF1yitxcyGjVU154WGFwG38pbWM+ja9XNxaSU
 QvxnihK23Wur08ChbU37LPqb/2h3nO9sukhk7bXfSmgs9dU5dZ/Wrqhlv5mqUIWYMNuV
 E7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770241621; x=1770846421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAnGPKUaTJbrlcxFs0fhKTBs0MXjGFWJLTU73DFyTrE=;
 b=HneoCPkA8gWjiL1XOQKuqS5oApQ++hcwCYA4hA3uLrwuoGMAzvNYjWoezU20bTV8Id
 ttbGDuURylzEogjb1r9X9cVfGsXyWeDY+/9LGgN4GJy0FKvTGeDWiMgpJncNgD8zVNa7
 pVs5LAiqnsb8oqSkMI2qeWd75Q1s9POgVR+17BKUu03vlN0BYVsAS7ugKUL4aohf6taF
 lWd3vRhVorMgM7wLnn3Gvf7da2a1ndS9ergEKypLa0njvB2e/HY62B+KT4VNtDTmSfWZ
 P9A9rdvFQcQVytuT63UsAfo0VU3A2nQVquW5O3BCbwdRRF7P7JaRNFak83tu9bhfXGz8
 8upg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw/Ja5vhttSD8uy6KCSmGMSCGnVxANUJQfPzUzodT32iOexdx/ODaTfizDNgIxhlOgNwG4k3W2OUkU@nongnu.org
X-Gm-Message-State: AOJu0YxoEa4zabmdJCZ19BD1xyVwhdRFFH8KCZriKjzgr+UpfQIGYcg9
 0c6wJDVXq8Y5IgGgD8e/5sa/6iJxQbZo3ZmqXHm6ZK7t11ziuOkBYovjFQnWDvMeJV6xB3KrZmz
 6436oT1fPZefbxx9m5AUika/nbniskg==
X-Gm-Gg: AZuq6aKXNrCG6dhSnyUPIs0od8ykaPa1S7juPOfGEMIWuUxdrOAtzelmTNfWwRSbYQU
 aG4YzBcKexJibKQSPlow3umZ/yDy8nRad6pCtqtnuw9RRuoo524SczAMf9NDdoTRjF5UPtSaSMJ
 n7Ch/ccTDzIJvO6u8CTzhoXabbJL7IvHBHjwcoaktpvbWMx6O9IJRQy/K0xijpvS3AWk6dHGxvL
 LK1CmakW3CKkeH8vIOY4oIrN/iPITlmzbwiQJolfMHhuu/zFx5mMBGWqSBrdacB3a5t6/E=
X-Received: by 2002:a05:7022:6a1:b0:119:e55a:9bf6 with SMTP id
 a92af1059eb24-126f478e3c5mr1796566c88.18.1770241621438; Wed, 04 Feb 2026
 13:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
 <20260119111542.788389-6-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-6-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:46:50 -0800
X-Gm-Features: AZwV_Qh3pdu43vYRi40T8RcKXzsoqh7kT818XSaxbGAsCpHsx5vB6kaswYq2rz8
Message-ID: <CALa+Y15qZgpNg+y2iujVN6zeYPB1JNXi0C4fbwWieGWtQ3UpbQ@mail.gmail.com>
Subject: Re: [PATCH qemu v4 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
 shiju.jose@huawei.com, 
 armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
 Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=ravis.opensrc@gmail.com; helo=mail-dl1-x1241.google.com
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

On Mon, Jan 19, 2026 at 3:18=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> event record has updated with following new fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
>
> Add updates for the above spec changes in the CXL memory module
> event reporting and QMP command to inject memory module event.
>
> Updated all references for this command to the CXL r3.2
> specification.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v4: Update spec reference in the actual command as well (Markus)
> V3: Update spec references for whole command (Markus)
> ---
>  qapi/cxl.json               | 30 ++++++++++++++++++++----------
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  4 ++++
>  4 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 1dc8b08ca301..81d6198ba030 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -214,20 +214,20 @@
>  ##
>  # @CXLMemModuleEvent:
>  #
> -# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
> +# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
>  #
> -# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
> +# @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
>  #     Event Record for bit definitions for bit definiions.
>  #
> -# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
> -#     8-100 Get Health Info Output Payload, Health Status for bit
> +# @health-status: Overall health summary bitmap.  See CXL r3.2 Table
> +#     8-148 Get Health Info Output Payload, Health Status for bit
>  #     definitions.
>  #
> -# @media-status: Overall media health summary.  See CXL r3.0 Table
> -#     8-100 Get Health Info Output Payload, Media Status for bit
> +# @media-status: Overall media health summary.  See CXL r3.2 Table
> +#     8-148 Get Health Info Output Payload, Media Status for bit
>  #     definitions.
>  #
> -# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
> +# @additional-status: See CXL r3.2 Table 8-148 Get Health Info Output
>  #     Payload, Additional Status for subfield definitions.
>  #
>  # @life-used: Percentage (0-100) of factory expected life span.
> @@ -243,6 +243,14 @@
>  # @corrected-persistent-error-count: Total number of correctable
>  #     errors in persistent memory
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-type: Device event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLMemModuleEvent',
> @@ -252,14 +260,16 @@
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
>              'corrected-volatile-error-count': 'uint32',
> -            'corrected-persistent-error-count': 'uint32'
> +            'corrected-persistent-error-count': 'uint32',
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            'sub-type':'uint8'
>              }}
>
>  ##
>  # @cxl-inject-memory-module-event:
>  #
> -# Inject an event record for a Memory Module Event (CXL r3.0
> -# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> +# Inject an event record for a Memory Module Event (CXL r3.2
> +# 8.2.10.2.1.3).  This event includes a copy of the Device Health info
>  # at the time of the event.
>  #
>  # Since: 8.1
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index a3c5f2ec20e6..4a7836ad7227 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -166,7 +166,7 @@ typedef struct CXLEventDram {
>
>  /*
>   * Memory Module Event Record
> - * CXL r3.1 Section 8.2.9.2.1.3: Table 8-47
> + * CXL r3.2 Section 8.2.10.2.1.3: Table 8-59

Minor Nitpick : Table reference in commit message should match code
reference of Table 8-59

>   * All fields little endian.
>   */
>  typedef struct CXLEventMemoryModule {
> @@ -180,7 +180,10 @@ typedef struct CXLEventMemoryModule {
>      uint32_t dirty_shutdown_count;
>      uint32_t corrected_volatile_error_count;
>      uint32_t corrected_persistent_error_count;
> -    uint8_t reserved[0x3d];
> +    uint16_t validity_flags;
> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t sub_type;
> +    uint8_t reserved[0x2a];
>  } QEMU_PACKED CXLEventMemoryModule;
>
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3da538bafb64..4dc9b223f476 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1937,6 +1937,9 @@ void qmp_cxl_inject_dram_event(const char *path, Cx=
lEventLog log,
>      }
>  }
>
> +#define CXL_MMER_VALID_COMPONENT                        BIT(0)
> +#define CXL_MMER_VALID_COMPONENT_ID_FORMAT              BIT(1)
> +
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
>                                          uint32_t flags, bool has_maint_o=
p_class,
>                                          uint8_t maint_op_class,
> @@ -1953,11 +1956,16 @@ void qmp_cxl_inject_memory_module_event(const cha=
r *path, CxlEventLog log,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_erro=
r_count,
>                                          uint32_t corrected_persist_error=
_count,
> +                                        const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        uint8_t sub_type,
>                                          Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
>      CXLEventMemoryModule module;
>      CXLEventRecordHdr *hdr =3D &module.hdr;
> +    uint16_t valid_flags =3D 0;
>      CXLDeviceState *cxlds;
>      CXLType3Dev *ct3d;
>      uint8_t enc_log;
> @@ -2000,6 +2008,18 @@ void qmp_cxl_inject_memory_module_event(const char=
 *path, CxlEventLog log,
>      stl_le_p(&module.corrected_persistent_error_count,
>               corrected_persist_error_count);
>
> +    if (component_id) {
> +        strncpy((char *)module.component_id, component_id,
> +                sizeof(module.component_id) - 1);
> +        valid_flags |=3D CXL_MMER_VALID_COMPONENT;
> +        if (has_comp_id_pldm && is_comp_id_pldm) {
> +            valid_flags |=3D CXL_MMER_VALID_COMPONENT_ID_FORMAT;
> +        }
> +    }
> +    module.sub_type =3D sub_type;
> +
> +    stw_le_p(&module.validity_flags, valid_flags);
> +
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) =
{
>          cxl_event_irq_assert(ct3d);
>      }
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 231dda263fa4..98292a931c16 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -78,6 +78,10 @@ void qmp_cxl_inject_memory_module_event(const char *pa=
th, CxlEventLog log,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_erro=
r_count,
>                                          uint32_t corrected_persist_error=
_count,
> +                                        const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        uint8_t sub_type,
>                                          Error **errp) {}
>
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t le=
ngth,
> --
> 2.48.1
>
>

