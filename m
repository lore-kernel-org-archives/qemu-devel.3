Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812AEC88E73
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NtE-0002iX-6g; Tue, 15 Sep 2026 03:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6NtC-0002iL-TP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6Nt9-00074F-Rf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789458454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FoUn6qdOZJSWwYeXPqr74N8BZaHlFGdiFGvSMkSME6I=;
 b=cRZC63rlCYqzm0yoyL1GRMmHY3eQw4IyLlN1aETS+g7nfsekPPuIZwPzcq/7ASJ+ECBzWb
 hcDAFZBeojaontnBz+A2Pl5HK009sYovxeknW/1V9PyIYLurVTIZ8hgmYV6vH60s5I6BnF
 bs5cKtO+uQ9xhBoIwdIDQf4PnEA36OE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-A-XVpRrKOZyLyeG1cUTq8w-1; Tue, 15 Sep 2026 03:47:32 -0400
X-MC-Unique: A-XVpRrKOZyLyeG1cUTq8w-1
X-Mimecast-MFC-AGG-ID: A-XVpRrKOZyLyeG1cUTq8w_1789458451
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e76a80fe5so24001955e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789458451; x=1790063251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FoUn6qdOZJSWwYeXPqr74N8BZaHlFGdiFGvSMkSME6I=;
 b=uNefU7Pglb4MBLtEghq+bB+rjHg9YH7jLoJukTvkIc0UBtljcIa18vII9wBvkqDP0R
 Z003JGB5qtkLXXxvaC2G77QtURn62TW7HhSMeMacGqKuedJMJpuTFpXqhj3CQQyDc89e
 tJObI3Jxw6y+N02Z5nsJVLThK/1kPQ+L1RDoNq5R1U2Qjzz0AmGoBs0PGQrXCwV2Iruq
 2hZdKyG0UlvlphzOtak1KO1LfiS5grXJe4sRvk2TjqrCkEJqa/+J9h8mQmmPefAUNBsP
 i5nNqwzIGzt+X9+edYOBQyIL3B8YiXNnDXNXADBxV3/OVQU+9cngu6b/pdUNfwxtjMac
 HhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789458451; x=1790063251;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FoUn6qdOZJSWwYeXPqr74N8BZaHlFGdiFGvSMkSME6I=;
 b=INIOSz1mGl7co+bK9NqbTj4W8XZPgsrLybDzDWr3KXqVxbxcFrlzwkJB/KT895Fj+e
 VJiv7esgYi9qs8ovlMxf8WlExQLbqCsXE7eqzqflOzk2GUc1zsoJpdAAiZ7VvcdZwlQ3
 m4OU2PD6x8QG55EZxpNpz+u7z/3dZZI8TtcZfNSnGFV7Wqu7kGQHtSa6UXXcl6+8/2Y2
 iw3NudpB0+dhS/plOjtW+o6bqgw6QS2lvsJ5CD04kRbaj4noe5FO9bQaYAynOPg5bpdY
 Mizwn1cZ0mycqHNvMwO/WahGQMdi/2iPGfBMO5xgnm87uXza+upDxKusR5ia4vwyBggJ
 I9Zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgNhlk1ebLIK12aH0XJ0B0lRWHJFF/TFldy3CsX8PadJlhHJ5LkeRqGr2mU+P7Tmd/s8qi5sPWiMes@nongnu.org
X-Gm-Message-State: AFuF++nOfdCt/S0jaGim4+Z+L3v7FDrsurzemNbgOUyPqZvZJ3bFEcOn
 9C1JvkKKWG1s3AptzZu7MnrfXYsbGotEEw4g1MDfABuiVF8T/Fz0UFc91HXibkSQOa4bm4avH2p
 uSLgDum4kt1qiWWi7CDvE1eCDAcAPLNCPqyCoyeOj/MVEn1R+BK8ZOQ/h
X-Gm-Gg: AYBFou3tRwoF2+D2DBQrbKU9GkHysELRbeK9i1gtoZc+/BuI+MDwpVsYVCskDuMBZGg
 +hyzNl2zR2i4QlEx97t/x/NihDj18ksDeEUzbiwa91vDKX9nRAwVQw0tRbuE7TetyiTA9ThtyRG
 /SCvXtO+W4B1I6cEVZwKzQZJaEWHN34AyNEo5fofYDHFU1M9U3GpBNVnxoNhdVmWTALqIK2vHrZ
 AxU1ri6E5qSUcoGSEGOG1p60bnOo9tX6H+/y53a4K1oxR7c5QvK6FWIOF8JNHYZMyAe8e2wJVwh
 OBuwo+NqiBzeWP7ojM6Txl/hnJ8S/a/EUbF6tHHbhcIqwiN2vYvj8JGmlwAYNM8+L7QwxdSt6nq
 I3JtjQ15LeXgiTPhcmwW6Ed9WA/uM1BEZ0Pofh61WWA==
X-Received: by 2002:a05:600c:1c0e:b0:499:be2d:c290 with SMTP id
 5b1f17b1804b1-49e8222a2aamr751125e9.9.1789458449806; 
 Tue, 15 Sep 2026 00:47:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0e:b0:499:be2d:c290 with SMTP id
 5b1f17b1804b1-49e8222a2aamr749265e9.9.1789458447854; 
 Tue, 15 Sep 2026 00:47:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d695677sm51846735e9.5.2026.09.15.00.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 00:47:27 -0700 (PDT)
Message-ID: <471c83b2-5190-4eb2-a9c7-9286fb9b1399@redhat.com>
Date: Tue, 15 Sep 2026 09:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/9] igb: Add VF state serialization for live
 migration
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <20260902192054.3329753-4-clg@redhat.com>
 <846e77a1-56df-4d14-a1ee-d6c6489a2bcb@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <846e77a1-56df-4d14-a1ee-d6c6489a2bcb@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Akihiko,

On 9/8/26 10:01, Akihiko Odaki wrote:
> 
> 
> On 2026/09/03 4:20, Cédric Le Goater wrote:
>> Implement per-VF state serialization and deserialization for the SAVE
>> and LOAD commands. The wire format consists of a header (magic,
>> version, VF number, register count), per-VF register offset/value
>> pairs from a whitelist, RA table entries owned by the VF, and TX
>> queue contexts.
>>
>> Register offsets are relocated on load so a VF can migrate to a
>> different VF number on the destination. RA pool ownership bits are
>> swapped accordingly.
>>
>> AI-used-for: analysis, code (prototype)
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/net/igb_core.h      |   2 +
>>   hw/net/igb_migration.h |   2 +
>>   hw/net/igb.c           |   5 +
>>   hw/net/igb_migration.c | 347 ++++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 354 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
>> index d70b54e318f1..60724e2824ab 100644
>> --- a/hw/net/igb_core.h
>> +++ b/hw/net/igb_core.h
>> @@ -143,4 +143,6 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
>>   void
>>   igb_start_recv(IGBCore *core);
>> +IGBCore *igb_pf_get_core(void *pf);
>> +
>>   #endif
>> diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
>> index ea40ac65c54b..b2f601e74346 100644
>> --- a/hw/net/igb_migration.h
>> +++ b/hw/net/igb_migration.h
>> @@ -73,6 +73,8 @@
>>   #define IGB_MIG_ERR_NO_BUFFER           3
>>   #define IGB_MIG_ERR_DMA_FAILED          4
>>   #define IGB_MIG_ERR_BAD_SIZE            5
>> +#define IGB_MIG_ERR_BAD_MAGIC           6
>> +#define IGB_MIG_ERR_BAD_VERSION         7
>>   /* Shared buffer constants */
>>   #define IGB_VF_STATE_MAX_SIZE           4096
>> diff --git a/hw/net/igb.c b/hw/net/igb.c
>> index 7268e5473fc3..f39f2bc3a04e 100644
>> --- a/hw/net/igb.c
>> +++ b/hw/net/igb.c
>> @@ -133,6 +133,11 @@ void igb_vf_reset(void *opaque, uint16_t vfn)
>>       igb_core_vf_reset(&s->core, vfn);
>>   }
>> +IGBCore *igb_pf_get_core(void *pf)
>> +{
>> +    return &IGB(pf)->core;
>> +}
>> +
>>   static bool
>>   igb_io_get_reg_index(IGBState *s, uint32_t *idx)
>>   {
>> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
>> index 8e7e6fac9b9b..c34035974620 100644
>> --- a/hw/net/igb_migration.c
>> +++ b/hw/net/igb_migration.c
>> @@ -10,18 +10,241 @@
>>   #include "qemu/log.h"
>>   #include "hw/pci/pci_device.h"
>>   #include "hw/pci/pcie.h"
>> +#include "net/eth.h"
>> +#include "net/net.h"
>>   #include "igb_common.h"
>> +#include "igb_core.h"
>>   #include "igb_migration.h"
>>   #include "system/address-spaces.h"
>>   #include "trace.h"
>> +static IGBCore *igbvf_get_core(IgbVfState *s)
>> +{
>> +    return igb_pf_get_core(pcie_sriov_get_pf(PCI_DEVICE(s)));
>> +}
>> +
>>   /*
>>    * Per-VF state serialization / deserialization
>>    */
>> +#define IGB_MIG_BLOB_MAGIC        0x4D494742  /* "MIGB" */
>> +#define IGB_MIG_BLOB_VERSION      1
>> +
>> +typedef struct IgbMigRegPair {
>> +    uint32_t offset;
>> +    uint32_t value;
>> +} IgbMigRegPair;
>> +
>> +typedef struct IgbMigTxCtx {
>> +    uint32_t ctx_desc[8];         /* 2 × adv_tx_context_desc (4 dwords each) */
>> +    uint32_t first_cmd_type_len;
>> +    uint32_t first_olinfo_status;
>> +    uint32_t first;
>> +    uint32_t skip_cp;
>> +} IgbMigTxCtx;
>> +
>> +#define IGB_VF_MAX_FIXED_REGS     64
>> +#define IGB_VF_MAX_RA_REGS        48  /* (16 + 8) RA entries × 2 (RAL+RAH) */
>> +
>> +typedef struct IgbMigBlob {
>> +    uint32_t magic;
>> +    uint32_t version;
>> +    uint32_t vfn;
>> +    uint32_t num_regs;
>> +    IgbMigRegPair regs[IGB_VF_MAX_FIXED_REGS];
>> +    uint32_t num_ra;
>> +    IgbMigRegPair ra[IGB_VF_MAX_RA_REGS];
>> +    uint32_t num_tx_ctx;
>> +    IgbMigTxCtx tx_ctx[2];
>> +} IgbMigBlob;
>> +
>> +#define IGB_MIG_BLOB_SIZE            sizeof(IgbMigBlob)
>> +
>> +QEMU_BUILD_BUG_ON(IGB_MIG_BLOB_SIZE > IGB_VF_STATE_MAX_SIZE);
>> +
>> +/* Register offsets that constitute a VF's state slice */
>> +static int igb_vf_reg_list(uint16_t vfn, uint32_t *offsets)
>> +{
>> +    int n = 0;
>> +    int q0 = vfn;
>> +    int q1 = vfn + IGB_NUM_VM_POOLS;
>> +
>> +    /* Per-VF control and interrupt registers */
>> +    offsets[n++] = E1000_PVTCTRL(vfn) >> 2;
>> +    offsets[n++] = E1000_PVTEICS(vfn) >> 2;
>> +    offsets[n++] = E1000_PVTEIMS(vfn) >> 2;
>> +    offsets[n++] = E1000_PVTEIMC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVTEIAC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVTEIAM(vfn) >> 2;
>> +    offsets[n++] = E1000_PVTEICR(vfn) >> 2;
>> +
>> +    /* Per-VF statistics */
>> +    offsets[n++] = E1000_PVFGPRC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFGPTC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFGORC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFGOTC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFMPRC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFGPRLBC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFGPTLBC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFGORLBC(vfn) >> 2;
>> +    offsets[n++] = E1000_PVFGOTLBC(vfn) >> 2;
>> +
>> +    /*
>> +     * Mailbox control registers only - the 16-dword payload buffer
>> +     * (VMBMEM) is transient and drained on quiesce.
>> +     */
>> +    offsets[n++] = E1000_V2PMAILBOX(vfn) >> 2;
>> +    offsets[n++] = E1000_P2VMAILBOX(vfn) >> 2;
>> +
>> +    /* Per-VF config */
>> +    offsets[n++] = E1000_VMOLR(vfn) >> 2;
>> +    offsets[n++] = E1000_VMVIR(vfn) >> 2;
>> +    offsets[n++] = E1000_PSRTYPE(vfn) >> 2;
>> +
>> +    /*
>> +     * VF receive addresses (RA/RA2) are saved dynamically in
>> +     * igb_core_vf_save_state by scanning for entries whose pool
>> +     * bits match this VF - the PF driver chooses the RA slot.
>> +     */
>> +
>> +    /* Interrupt routing */
>> +    offsets[n++] = (E1000_VTIVAR + vfn * 4) >> 2;
>> +    offsets[n++] = (E1000_VTIVAR_MISC + vfn * 4) >> 2;
>> +
>> +    /*
>> +     * EITR (Extended Interrupt Throttle Register) - 3 vectors per VF.
>> +     * Each VF has 3 MSI-X vectors, each with its own EITR controlling
>> +     * interrupt coalescing. Without saving these, interrupt
>> +     * throttling resets to zero after migration which can cause
>> +     * interrupt storms or latency changes. VF N uses PF EITR indices
>> +     * (22 - N*3) .. (24 - N*3).
>> +     */
>> +    {
>> +        int eitr_base = 22 - vfn * 3;
>> +        offsets[n++] = E1000_EITR(eitr_base) >> 2;
>> +        offsets[n++] = E1000_EITR(eitr_base + 1) >> 2;
>> +        offsets[n++] = E1000_EITR(eitr_base + 2) >> 2;
>> +    }
>> +
>> +    /* RX and TX queue registers for queues q0 and q1 */
>> +#define ADD_QUEUE_REGS(q) do { \
>> +    offsets[n++] = E1000_RDBAL(q) >> 2; \
>> +    offsets[n++] = E1000_RDBAH(q) >> 2; \
>> +    offsets[n++] = E1000_RDLEN(q) >> 2; \
>> +    offsets[n++] = E1000_SRRCTL(q) >> 2; \
>> +    offsets[n++] = E1000_RDH(q) >> 2; \
>> +    offsets[n++] = E1000_RDT(q) >> 2; \
>> +    offsets[n++] = E1000_RXDCTL(q) >> 2; \
>> +    offsets[n++] = E1000_RXCTL(q) >> 2; \
>> +    offsets[n++] = E1000_RQDPC(q) >> 2; \
>> +    offsets[n++] = E1000_TDBAL(q) >> 2; \
>> +    offsets[n++] = E1000_TDBAH(q) >> 2; \
>> +    offsets[n++] = E1000_TDLEN(q) >> 2; \
>> +    offsets[n++] = E1000_TDH(q) >> 2; \
>> +    offsets[n++] = E1000_TDT(q) >> 2; \
>> +    offsets[n++] = E1000_TXDCTL(q) >> 2; \
>> +    offsets[n++] = E1000_TXCTL(q) >> 2; \
>> +    offsets[n++] = E1000_TDWBAL(q) >> 2; \
>> +    offsets[n++] = E1000_TDWBAH(q) >> 2; \
>> +} while (0)
>> +
>> +    ADD_QUEUE_REGS(q0);
>> +    ADD_QUEUE_REGS(q1);
>> +#undef ADD_QUEUE_REGS
>> +
>> +    g_assert(n <= IGB_VF_MAX_FIXED_REGS);
>> +    return n;
>> +}
>> +
>> +/*
>> + * Scan RA and RA2 arrays for receive address entries assigned to
>> + * this VF. The PF driver picks the RA slot, so we cannot use a
>> + * fixed index - instead check each entry's pool bits.
>> + */
>> +static int igb_core_vf_save_ra(IGBCore *core, uint16_t vfn,
>> +                               IgbMigRegPair *regs)
>> +{
>> +    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
>> +    int n = 0;
>> +    static const struct {
>> +        uint32_t base;
>> +        int count;
>> +    } ra_banks[] = {
>> +        { RA,  16 },
>> +        { RA2,  8 },
>> +    };
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(ra_banks); i++) {
>> +        for (int j = 0; j < ra_banks[i].count; j++) {
>> +            uint32_t ral_off = ra_banks[i].base + j * 2;
>> +            uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
>> +            uint32_t rah_val = core->mac[rah_off];
>> +
>> +            if ((rah_val & E1000_RAH_AV) && (rah_val & vf_pool_bit)) {
>> +                regs[n].offset = cpu_to_le32(ral_off);
>> +                regs[n].value = cpu_to_le32(core->mac[ral_off]);
>> +                n++;
>> +                regs[n].offset = cpu_to_le32(rah_off);
>> +                regs[n].value = cpu_to_le32(rah_val);
>> +                n++;
>> +            }
>> +        }
>> +    }
>> +    return n;
>> +}
>> +
>> +static void igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
>> +                                    IgbMigTxCtx *tx)
>> +{
>> +    struct igb_tx *src = &core->tx[queue];
>> +
>> +    memcpy(tx->ctx_desc, src->ctx, sizeof(tx->ctx_desc));
>> +    tx->first_cmd_type_len = cpu_to_le32(src->first_cmd_type_len);
>> +    tx->first_olinfo_status = cpu_to_le32(src->first_olinfo_status);
>> +    tx->first = cpu_to_le32(src->first);
>> +    tx->skip_cp = cpu_to_le32(src->skip_cp);
>> +}
>> +
>>   static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
>>   {
>> -    int size = 0;
>> +    int size = IGB_MIG_BLOB_SIZE;
>> +    IGBCore *core = igbvf_get_core(s);
>> +    IgbMigBlob *blob = buf;
>> +    uint32_t offsets[IGB_VF_MAX_FIXED_REGS];
>> +    int num_regs;
>> +    int q0 = s->vfn;
>> +    int q1 = s->vfn + IGB_NUM_VM_POOLS;
>> +
>> +    /*
>> +     * Save PVT shadow registers (PVTEIMS/PVTEIAC/PVTEIAM) instead of
>> +     * extracting from PF aggregates - the L1 PF driver may have
>> +     * transiently cleared EIMS via EIMC. The load path ORs them back.
>> +     */
>> +    num_regs = igb_vf_reg_list(s->vfn, offsets);
>> +
>> +    if (!buf) {
>> +        return size;
>> +    }
>> +
>> +    if (size > buf_size) {
>> +        return -IGB_MIG_ERR_BAD_SIZE;
>> +    }
>> +
>> +    blob->magic = cpu_to_le32(IGB_MIG_BLOB_MAGIC);
>> +    blob->version = cpu_to_le32(IGB_MIG_BLOB_VERSION);
>> +    blob->vfn = cpu_to_le32(s->vfn);
>> +
>> +    blob->num_regs = cpu_to_le32(num_regs);
>> +    for (int i = 0; i < num_regs; i++) {
>> +        blob->regs[i].offset = cpu_to_le32(offsets[i]);
>> +        blob->regs[i].value = cpu_to_le32(core->mac[offsets[i]]);
>> +    }
>> +
>> +    blob->num_ra = cpu_to_le32(igb_core_vf_save_ra(core, s->vfn, blob->ra));
> 
> The serialized state contains RA entries but excludes VFTA/VLVF and MTA/UTA state. 

VLVF should not be too complex to add support for. It is the same pattern
as the RA scan.

VFTA/MTA/UTA support is tougher. IIUC, these are PF shared tables and there
are no per-VF bits. So we either need to add per-VF shadow tracking, which
is intrusive or, to begin with, we can ignore: detect and warn.


> A guest-configured VLAN therefore resumes on a destination lacking its filter membership: packets are rejected by the global VLAN check or have their VF queue removed  in igb_receive_assign(),. Likewise, restored VMOLR.ROMPE cannot receive subscribed multicast without its MTA hash bits. These are guest-requested settings communicated through the PF mailbox, and the resumed guest does not recreate them automatically.

yes. If we could restore some of the VF state using the PF mailbox, we
would avoid poking the core igb device from the VF but the model doesn't
have enough support yet.

> 
>> +
>> +    blob->num_tx_ctx = cpu_to_le32(2);
>> +    igb_core_vf_save_tx_ctx(core, q0, &blob->tx_ctx[0]);
>> +    igb_core_vf_save_tx_ctx(core, q1, &blob->tx_ctx[1]);
>>       trace_igbvf_mig_save_state(s->vfn, size);
>>       return size;
>> @@ -29,11 +252,131 @@ static int igb_core_vf_save_state(IgbVfState *s, void *buf, size_t buf_size)
>>   static int igb_core_vf_max_data_size(IgbVfState *s)
>>   {
>> -    return sizeof(s->mig.mig_data);
>> +    int size = igb_core_vf_save_state(s, NULL, 0);
>> +
>> +    g_assert(size > 0 && size <= IGB_VF_STATE_MAX_SIZE);
>> +    return size;
>> +}
>> +
>> +static void igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
>> +                                    const IgbMigTxCtx *tx)
>> +{
>> +    struct igb_tx *dst = &core->tx[queue];
>> +
>> +    /*
>> +     * Preserve the destination's tx_pkt - it's a host-side object,
>> +     * not guest state
>> +     */
>> +    memcpy(dst->ctx, tx->ctx_desc, sizeof(dst->ctx));
>> +    dst->first_cmd_type_len = le32_to_cpu(tx->first_cmd_type_len);
>> +    dst->first_olinfo_status = le32_to_cpu(tx->first_olinfo_status);
>> +    dst->first = le32_to_cpu(tx->first);
>> +    dst->skip_cp = le32_to_cpu(tx->skip_cp);
>> +}
>> +
>> +static uint32_t igb_vf_relocate_offset(uint32_t offset,
>> +                                       const uint32_t *src_offsets,
>> +                                       const uint32_t *dst_offsets,
>> +                                       int num_offsets)
>> +{
>> +    for (int i = 0; i < num_offsets; i++) {
>> +        if (src_offsets[i] == offset) {
>> +            return dst_offsets[i];
>> +        }
>> +    }
>> +    return 0;
>>   }
>>   static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
>>   {
>> +    IGBCore *core = igbvf_get_core(s);
>> +    uint32_t src_offsets[IGB_VF_MAX_FIXED_REGS];
>> +    uint32_t dst_offsets[IGB_VF_MAX_FIXED_REGS];
>> +    int q0 = s->vfn;
>> +    int q1 = s->vfn + IGB_NUM_VM_POOLS;
>> +
>> +    if (size < IGB_MIG_BLOB_SIZE) {
>> +        return -IGB_MIG_ERR_BAD_SIZE;
>> +    }
>> +
>> +    const IgbMigBlob *blob = buf;
>> +
>> +    uint32_t magic = le32_to_cpu(blob->magic);
>> +    uint32_t version = le32_to_cpu(blob->version);
>> +    uint32_t saved_vfn = le32_to_cpu(blob->vfn);
>> +    uint32_t num_regs = le32_to_cpu(blob->num_regs);
>> +
>> +    if (magic != IGB_MIG_BLOB_MAGIC) {
>> +        return -IGB_MIG_ERR_BAD_MAGIC;
>> +    }
>> +    if (version != IGB_MIG_BLOB_VERSION) {
>> +        return -IGB_MIG_ERR_BAD_VERSION;
>> +    }
>> +    if (num_regs > IGB_VF_MAX_FIXED_REGS) {
>> +        return -IGB_MIG_ERR_BAD_SIZE;
>> +    }
>> +
>> +    uint32_t num_ra = le32_to_cpu(blob->num_ra);
>> +    if (num_ra > IGB_VF_MAX_RA_REGS) {
>> +        return -IGB_MIG_ERR_BAD_SIZE;
>> +    }
>> +
>> +    int num_offsets = igb_vf_reg_list(saved_vfn, src_offsets);
>> +    igb_vf_reg_list(s->vfn, dst_offsets);
>> +
>> +    for (uint32_t i = 0; i < num_regs; i++) {
>> +        uint32_t src_off = le32_to_cpu(blob->regs[i].offset);
>> +        uint32_t value = le32_to_cpu(blob->regs[i].value);
>> +        uint32_t offset = igb_vf_relocate_offset(src_off,
>> +            src_offsets, dst_offsets, num_offsets);
>> +        if (!offset) {
>> +            return -IGB_MIG_ERR_BAD_SIZE;
>> +        }
>> +
>> +        core->mac[offset] = value;
>> +
>> +        /*
>> +         * Sync EITR to eitr_guest_value[] shadow array, stripping
>> +         * E1000_EITR_CNT_IGNR so guest register readback returns the
>> +         * correct value.
>> +         */
>> +        if (offset >= EITR0 && offset < EITR0 + IGB_INTR_NUM) {
>> +            core->eitr_guest_value[offset - EITR0] =
>> +                value & ~E1000_EITR_CNT_IGNR;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * MSI-X table/PBA is not saved - L1's VFIO reprograms it with
>> +     * destination-specific IRTE references after migration.
>> +     */
>> +
>> +    uint32_t src_pool = E1000_RAH_POOL_1 << saved_vfn;
>> +    uint32_t dst_pool = E1000_RAH_POOL_1 << s->vfn;
>> +
>> +    for (uint32_t i = 0; i < num_ra; i++) {
>> +        uint32_t offset = le32_to_cpu(blob->ra[i].offset);
>> +        uint32_t value = le32_to_cpu(blob->ra[i].value);
>> +
>> +        /* RAH entries: swap pool ownership bits */
>> +        if (offset >= RA && offset < RA + 32 && (offset - RA) % 2 == 1) {
>> +            value = (value & ~src_pool) | dst_pool;
>> +        }
>> +        if (offset >= RA2 && offset < RA2 + 16 && (offset - RA2) % 2 == 1) {
>> +            value = (value & ~src_pool) | dst_pool;
>> +        }
>> +
>> +        core->mac[offset] = value;
> 
> Please validate RA offsets before writing core->mac. 

Drat. my bad. It should be done and it's easy :

    reject offsets not in  [RA, RA+32) or [RA2, RA2+16)

> A valid-sized LOAD blob with one RA entry and an out-of-range offset produces an out-of-bounds 32-bit host write. LOAD reads this blob directly from guest RAM. Please validate all offsets and saved_vfn before modifying state.


I think we should drop VF relocation support.

     if (saved_vfn != s->vfn) {
         return -IGB_MIG_ERR_BAD_VFN;
     }
  

I was too optimistic in v2. This adds too much complexity and we haven't
covered the simple case yet. Let's consider that VF number is part of
the migration state to have more invariants and avoid collisions.

> 
> This loop also changes the VF pool bit but preserves the source RA slot. A valid VF0→VF1 migration onto a destination already using VF0 overwrites destination VF0’s primary MAC entry. Linux assigns the primary entry as rar_entry_count - (vf + 1); receive filtering consumes these slots directly in igb_receive_assign(). Thus the unrelated destination VF loses unicast reception. Existing destination entries owned by the migrating VF are also left behind.

There should be no/few entries on the destination for the VF being
migrated, only the fixed primary MAC entries for the VF. So, with the
same VF number enforced, slot assignments should be deterministic
and we can scan and clear any entries with this VF's pool bit at load
time.


Thanks,

C.

> 
> Regards,
> Akihiko Odaki
> 
>> +    }
>> +
>> +    uint32_t num_tx = le32_to_cpu(blob->num_tx_ctx);
>> +    if (num_tx != 2) {
>> +        return -IGB_MIG_ERR_BAD_SIZE;
>> +    }
>> +
>> +    igb_core_vf_load_tx_ctx(core, q0, &blob->tx_ctx[0]);
>> +    igb_core_vf_load_tx_ctx(core, q1, &blob->tx_ctx[1]);
>> +
>>       trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
>>       return 0;
>>   }
> 


