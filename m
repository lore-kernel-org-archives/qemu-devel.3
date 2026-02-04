Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872B4EA794A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 23:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnm63-0007zb-8a; Wed, 04 Feb 2026 18:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkgk-0002W2-JI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:45:30 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ravis.opensrc@gmail.com>)
 id 1vnkgb-0003Ev-TH
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:45:30 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1233c155a42so443951c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241332; cv=none;
 d=google.com; s=arc-20240605;
 b=lmCo6Xd49PCt11pizg51trnCynNZewftz17nDxK75zodgKSu3Fl6VnkdsVVS5pNNdu
 86odk0YcMQ7RgP2xzQuBM8Z727l/6+LW7aiJCGt/ENt8Q/7hipXZoZhSCpDtwYPAnIY3
 YbdqBT5kIWLz7I90WHoYWK5o6VYt6IjNhjWb/0tMvAxC9nCYhZYwRCP2J9Hi9+XkiHvx
 6dntgVpanqmYuvSKFM83DcCVlkekfC5v8AsbP1fdiMNW8gTTzkc+mtlICnDgzDAZihLB
 Gj7AgHvPiCbR7s0ciiMyK+HPp/lP4+O/Cztx/ztLTiNEnRUR/j1w9lZ37WrPc/JUH5KP
 wgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5c/YEHv5IM764CbDu3MkA791h8iG/cd351LF381Debg=;
 fh=VGr6Cyjft57WzMCefZgm6aIJIm0x1AEevVwiL/glZqc=;
 b=LBTNNPU3VZqNiR7m0jRrezhl/cx5NHt8BITYA6iSIJ+uVNx0EJmCObW4WC8tS2NKOT
 gpDs+lEDUiBXxVgUFDgx8ZOo1pbpbTeRm+vOLENnvHpkdFIVb++JFP9vhh+6WJOOTAgx
 WzTabNYXNPb/BNmQqje88x2j+EC4tjat+rWUSEAf2UQ7CWZNQQJ/Ht+SBfENFWc8uaT1
 wruCGfdJotXW64IphhtaAXZ92rlLT/QbCOEcIccaRbIZ6ppykYe/+/TRKq7ERbjAAjsy
 I2vsRJzrfyzAbGUYTLZ+TMeYP6M4QbYdbJggaUiuKwhKkvQz4cEl1v5kCi1FrYxRied7
 Suqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770241332; x=1770846132; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5c/YEHv5IM764CbDu3MkA791h8iG/cd351LF381Debg=;
 b=F5q6qUBzjHh1kAcCFwxK8HtaaOsPx9k0UwHrgXMtnhqAK+hEqrw5xiRw2HSxTLtfow
 0N4pKj4HSlqYrVBZcUdRFcZlJmQJtE2IbmKiQwJIqEtoRcbQ1oRrQqEmWr2+3uWR0DNW
 N+gILplD95t0rG20Kf6vSHqPnvOMVVY/bCh+yl1pmNnw/tObGspP+7KLHXCY7akL2RXE
 V2vkq/oskXDIcmy4Dr6EFXKgrs6aqEOiNI5Ej9gJtvxIjhoxhiMoakC1YhT6H62Rj1Ni
 at5iXwoGWt6lbQezO3AM103BKt14NOwrM5WLjxZqjJYWHIiwhf8A70Z/leMz6hQpBLUZ
 Dj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770241332; x=1770846132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5c/YEHv5IM764CbDu3MkA791h8iG/cd351LF381Debg=;
 b=LHAkpg3nHMshZVd/52dQBy8Vo1+h8s+RFpMEZLw7tpiy27DsysQswapf785wCorx+T
 pDZE8WSDAq4hdS5l1jFeTcybo//E2kbM5J9o0SmXuUYu4Q8ky+eO7bfQDx1J9vGMnlHp
 x9CC1SXN6g+V4EUGZyPe5l63pRBLHfWFN6rpzLWrI6egFWpXqTxN4lqWwyNZzeSVm7zr
 O1Cr2E27EsfXQNmCXuU782piTaCtr1xIMLJe+v+YYvnRCHoklUvi+PDVLDoRAZPAhhVh
 gmnmZWzPAGbpqKbuIuByIquNXapRIc7vJoebnqRtQ7dc/KfnyoJE6rIF7SBCRdsOtpD8
 VcGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIrHVvpXUIZq6kL9NkBqm4a0BG/xTUOLSkd9D+W1TDJHVbWScoDMgjCHvghLkWRbH0UnREMSVSZUxZ@nongnu.org
X-Gm-Message-State: AOJu0YzBziM3NafS86/FZdwgi9ql/DifFlEvwJXoSnWIibWuGy3UaJRt
 Avmc4MIHcWhrMjMDLtCo1/v6Wh5dSG5pVucQ70FpZqvE8WFR5zqq7JNiRr8R3kmf6QYif7o+3P7
 xHBBbTcqSoowtHTEfHmwwU/LiuE4oMA==
X-Gm-Gg: AZuq6aIJpeNU0C44C72hgLpbQnWDDNhPBoEAiHERDCNLqQ7jfDmcTsi8CsJs594YbuR
 6DwC2QI1aI28JmRyYSsEBSqqcc1SIPvUepJDhrX78/mxIdzgLmL9Yicz92CUypdS47V68Un594D
 kPMc73dbCH/8PSXmjWk7sW4/RwjiJCCU4QCYCs7bRox3OIZN3IyOTJIja/kNhW4sFiWfR/+60F6
 9768u5Mr9sMeWV5hky1EJFfZhi/Mb29pD5N4HtzrqWVEpkFB28sH/npHZfVspCTJUrKrYk=
X-Received: by 2002:a05:7022:2506:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-126f478f949mr2206138c88.11.1770241331526; Wed, 04 Feb 2026
 13:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
 <20260119111542.788389-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-4-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:42:00 -0800
X-Gm-Features: AZwV_Qim6-6gtJPN1ilsYZ97WF7on0oMm6F1Kq0bMDH0-DIhzDImPu1Ygl6JVDY
Message-ID: <CALa+Y15jKXUH=9k5aBveN4WN0AK1QW6VHGLHTVVgTF+-2hXvhA@mail.gmail.com>
Subject: Re: [PATCH qemu v4 3/5] hw/cxl/events: Updates for rev3.2 general
 media event record
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
> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
> table has updated with following new fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 4. Support for component ID in the PLDM format.
>
> Add updates for the above spec changes in the CXL general media event
> reporting and QMP command to inject general media event.
>
> In order to have one consistent source of references, update all to
> references for this command to CXL r3.2.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: Update the spec reference in the related command to 3.2 as well.
> (Markus)
> v3: Update all references to 3.2 for consistency.
> ---
>  qapi/cxl.json               | 29 +++++++++++++++++++++--------
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 29 +++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  6 ++++++
>  4 files changed, 61 insertions(+), 10 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 82001c0591d8..4ff66fc6c16c 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -64,22 +64,22 @@
>  ##
>  # @CXLGeneralMediaEvent:
>  #
> -# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
> -#     lower bits include some flags.  See CXL r3.0 Table 8-43 General
> +#     lower bits include some flags.  See CXL r3.2 Table 8-57 General
>  #     Media Event Record, Physical Address.
>  #
>  # @descriptor: Memory Event Descriptor with additional memory event
> -#     information.  See CXL r3.0 Table 8-43 General Media Event
> +#     information.  See CXL r3.2 Table 8-57 General Media Event
>  #     Record, Memory Event Descriptor for bit definitions.
>  #
> -# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
> +# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-57
>  #     General Media Event Record, Memory Event Type for possible
>  #     values.
>  #
>  # @transaction-type: Type of first transaction that caused the event
> -#     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
> +#     to occur.  See CXL r3-2 Table 8-57 General Media Event Record,
>  #     Transaction Type for possible values.
>  #
>  # @channel: The channel of the memory event location.  A channel is an
> @@ -94,6 +94,16 @@
>  # @component-id: Device specific component identifier for the event.
>  #     May describe a field replaceable sub-component of the device.
>  #
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#
> +# @cme-count: Corrected memory error count at event.
> +#
> +# @sub-type: Memory event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLGeneralMediaEvent',
> @@ -101,13 +111,16 @@
>    'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> -            '*device': 'uint32', '*component-id': 'str' } }
> +            '*device': 'uint32', '*component-id': 'str',
> +            '*is-comp-id-pldm':'bool',
> +            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
> +            'sub-type':'uint8' } }
>
>  ##
>  # @cxl-inject-general-media-event:
>  #
> -# Inject an event record for a General Media Event (CXL r3.0
> -# 8.2.9.2.1.1).  This event type is reported via one of the event
> +# Inject an event record for a General Media Event (CXL r3.2
> +# 8.2.10.2.1.1).  This event type is reported via one of the event
>  # logs specified via the log parameter.
>  #
>  # Since: 8.1
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 4d9cfdb621ea..352f9891bd36 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
>
>  /*
>   * General Media Event Record
> - * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
> + * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> -#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> +#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
>  typedef struct CXLEventGenMedia {
>      CXLEventRecordHdr hdr;
>      uint64_t phys_addr;
> @@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
>      uint8_t rank;
>      uint8_t device[3];
>      uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t cme_ev_flags;
> +    uint8_t cme_count[3];
> +    uint8_t sub_type;
>      uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
>  } QEMU_PACKED CXLEventGenMedia;
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 371bd4dc6ab2..d03a9f0edc29 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1646,6 +1646,11 @@ static const QemuUUID memory_module_uuid =3D {
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
>  #define CXL_GMER_VALID_COMPONENT                        BIT(3)
> +#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
> +
> +#define CXL_GMER_EV_DESC_UCE                            BIT(0)
> +#define CXL_GMER_EV_DESC_THRESHOLD_EVENT                BIT(1)
> +#define CXL_GMER_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
>
>  static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
>  {
> @@ -1677,6 +1682,12 @@ void qmp_cxl_inject_general_media_event(const char=
 *path, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device=
,
>                                          const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        bool has_cme_ev_flags,
> +                                        uint8_t cme_ev_flags,
> +                                        bool has_cme_count, uint32_t cme=
_count,
> +                                        uint8_t sub_type,
>                                          Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
> @@ -1737,10 +1748,28 @@ void qmp_cxl_inject_general_media_event(const cha=
r *path, CxlEventLog log,
>          strncpy((char *)gem.component_id, component_id,
>                  sizeof(gem.component_id) - 1);
>          valid_flags |=3D CXL_GMER_VALID_COMPONENT;
> +        if (has_comp_id_pldm && is_comp_id_pldm) {
> +            valid_flags |=3D CXL_GMER_VALID_COMPONENT_ID_FORMAT;
> +        }
>      }
>
>      stw_le_p(&gem.validity_flags, valid_flags);
>
> +    if (has_cme_ev_flags) {
> +        gem.cme_ev_flags =3D cme_ev_flags;
> +    } else {
> +        gem.cme_ev_flags =3D 0;
> +    }
> +
> +    if (has_cme_count) {
> +        descriptor |=3D CXL_GMER_EV_DESC_THRESHOLD_EVENT;

The modification to 'descriptor' here is not written back to gem.descriptor
which was assigned earlier in this function.

Suggest moving gem.descriptor assignment after this block, similar to
how valid_flags is handled in this same function.

> +        st24_le_p(gem.cme_count, cme_count);
> +    } else {
> +        st24_le_p(gem.cme_count, 0);
> +    }
> +
> +    gem.sub_type =3D sub_type;
> +
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
>          cxl_event_irq_assert(ct3d);
>      }
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 91b1478114d9..2047e9784694 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -27,6 +27,12 @@ void qmp_cxl_inject_general_media_event(const char *pa=
th, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device=
,
>                                          const char *component_id,
> +                                        bool has_comp_id_pldm,
> +                                        bool is_comp_id_pldm,
> +                                        bool has_cme_ev_flags,
> +                                        uint8_t cme_ev_flags,
> +                                        bool has_cme_count, uint32_t cme=
_count,
> +                                        uint8_t sub_type,
>                                          Error **errp) {}
>
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
> --
> 2.48.1
>
>

