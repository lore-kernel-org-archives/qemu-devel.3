Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560D110F2843
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69I4-0001Bs-PZ; Fri, 27 Mar 2026 11:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w69I3-0001Af-5g
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:40:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w69Hz-0000zY-Or
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:40:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC6D05BD9A;
 Fri, 27 Mar 2026 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774625997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mf7cU7TgraW1UzFcjlNKkoITFv+WT3LUEhXuLD9ppto=;
 b=IUv21nkokQjxM0Do2Cvm4N9xc5laDupQ9WIe5WyD/TmO+X1F2mc/ZutKSD89TO998l1irF
 apFbnGBc5QsSfpOtKjIhNI6W74kqaXZ8l1PCJNXyQOzbCL+Il8Rx05RsncK6BXMeND8xkm
 8MvdXEKZVVeBunUjjlso7FEhFJkc32Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774625997;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mf7cU7TgraW1UzFcjlNKkoITFv+WT3LUEhXuLD9ppto=;
 b=h/0J+Pn2zPXyiURpQrRgCCS4egQx5yUIdBgahavwn1Qp1yDh7u4PQCpcjNQNSVRkp5Ew/d
 XBylqhJt0wNTQhDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IUv21nko;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="h/0J+Pn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774625997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mf7cU7TgraW1UzFcjlNKkoITFv+WT3LUEhXuLD9ppto=;
 b=IUv21nkokQjxM0Do2Cvm4N9xc5laDupQ9WIe5WyD/TmO+X1F2mc/ZutKSD89TO998l1irF
 apFbnGBc5QsSfpOtKjIhNI6W74kqaXZ8l1PCJNXyQOzbCL+Il8Rx05RsncK6BXMeND8xkm
 8MvdXEKZVVeBunUjjlso7FEhFJkc32Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774625997;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mf7cU7TgraW1UzFcjlNKkoITFv+WT3LUEhXuLD9ppto=;
 b=h/0J+Pn2zPXyiURpQrRgCCS4egQx5yUIdBgahavwn1Qp1yDh7u4PQCpcjNQNSVRkp5Ew/d
 XBylqhJt0wNTQhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1751F4A0A2;
 Fri, 27 Mar 2026 15:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zk/yNcykxmlwGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 15:39:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fengyuan Yu <15fengyuan@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif
 <clement.mathieu--drif@bull.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, Fengyuan Yu
 <15fengyuan@gmail.com>
Subject: Re: [PATCH v3 1/2] tests/qtest/libqos: Add Intel IOMMU helper library
In-Reply-To: <c4f7bf5d7985891a2db291193669ebe15dd2ba15.1774421649.git.15fengyuan@gmail.com>
References: <cover.1774421649.git.15fengyuan@gmail.com>
 <c4f7bf5d7985891a2db291193669ebe15dd2ba15.1774421649.git.15fengyuan@gmail.com>
Date: Fri, 27 Mar 2026 12:39:54 -0300
Message-ID: <87y0jdgu2d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com,intel.com,bull.com,phytium.com.cn];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,gmail.com];
 RCPT_COUNT_SEVEN(0.00)[11]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AC6D05BD9A
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fengyuan Yu <15fengyuan@gmail.com> writes:

> Introduce a libqos helper module for Intel IOMMU (VT-d) bare-metal
> testing via iommu-testdev. The helper provides routines to:
>
> - Build Legacy-mode structures: Root Entry Tables, Context Entry Tables,
>   and 4-level page tables for 48-bit address translation
> - Build Scalable-mode structures: Scalable Context Entries, PASID
>   Directory Entries, PASID Table Entries, and 4-level page tables for
>   both second-level and first-level translation
> - Program VT-d registers (Root Table Address, Invalidation Queue,
>   Fault Event MSI, Global Command) following the VT-d specification,
>   with GSTS read-back verification for each step
> - Execute DMA translations through iommu-testdev and verify results
>   by reading back guest memory
>
> The module supports all major VT-d translation modes through the
> QVTDTransMode enum:
> - Legacy pass-through
> - Legacy translated with 4-level paging
> - Scalable pass-through
> - Scalable Second-Level Translation
> - Scalable First-Level Translation
>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
> ---
>  MAINTAINERS                          |   1 +
>  tests/qtest/libqos/meson.build       |   3 +
>  tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
>  tests/qtest/libqos/qos-intel-iommu.h | 185 +++++++++++
>  4 files changed, 643 insertions(+)
>  create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
>  create mode 100644 tests/qtest/libqos/qos-intel-iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd8ba14450..ba0901bf4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3606,6 +3606,7 @@ S: Maintained
>  F: tests/qtest/libqos/qos-iommu*
>  F: tests/qtest/libqos/qos-smmuv3*
>  F: tests/qtest/libqos/qos-riscv-iommu*
> +F: tests/qtest/libqos/qos-intel-iommu*
>=20=20
>  Device Fuzzing
>  M: Alexander Bulekov <alxndr@bu.edu>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.bu=
ild
> index 4a69acad0d..96f2fc48b4 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -73,6 +73,9 @@ endif
>  if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
>    libqos_srcs +=3D files('riscv-iommu.c', 'qos-riscv-iommu.c')
>  endif
> +if config_all_devices.has_key('CONFIG_VTD')
> +  libqos_srcs +=3D files('qos-intel-iommu.c')
> +endif
>  if config_all_devices.has_key('CONFIG_TPCI200')
>    libqos_srcs +=3D files('tpci200.c')
>  endif
> diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qo=
s-intel-iommu.c
> new file mode 100644
> index 0000000000..f8ca4c871b
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-intel-iommu.c
> @@ -0,0 +1,454 @@
> +/*
> + * QOS Intel IOMMU (VT-d) Module Implementation
> + *
> + * This module provides Intel IOMMU-specific helper functions for libqos=
 tests.
> + *
> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i386/intel_iommu_internal.h"
> +#include "tests/qtest/libqos/pci.h"
> +#include "qos-iommu-testdev.h"
> +#include "qos-intel-iommu.h"
> +
> +#define QVTD_AW_48BIT_ENCODING    2
> +
> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx)
> +{
> +    return ctx->config.expected_result;
> +}
> +
> +uint32_t qvtd_build_dma_attrs(void)
> +{
> +    /*
> +     * VT-d obtains the Requester ID (Source ID) from PCI bus/devfn rout=
ing
> +     * via pci_device_iommu_address_space(), not from DMA attributes.
> +     *
> +     * For scalable mode, iommu-testdev does not set MemTxAttrs.pid,
> +     * so the device's VTDAddressSpace has pasid=3DPCI_NO_PASID.
> +     * vtd_do_iommu_translate() remaps PCI_NO_PASID to PASID_0
> +     * when root_scalable is set, which matches the PASID=3D0 entry
> +     * we configure in qvtd_build_pasid_table_entry().
> +     */
> +    return 0;
> +}
> +
> +static void qvtd_build_root_entry(QTestState *qts, uint8_t bus,
> +                                  uint64_t context_table_ptr,
> +                                  QVTDTransMode mode)
> +{
> +    uint64_t root_entry_addr =3D QVTD_ROOT_TABLE_BASE +
> +                               (bus * sizeof(VTDRootEntry));
> +    uint64_t lo, hi;
> +
> +    if (qvtd_is_scalable(mode)) {
> +        /*
> +         * Scalable-mode Root Entry (Section 9.2):
> +         * lo =3D Lower Context Table Pointer + LP (Lower Present)
> +         * hi =3D Upper Context Table Pointer + UP (Upper Present)
> +         *
> +         * Lower table covers devfn 0-127, Upper covers devfn 128-255.
> +         * Only lower half is needed for test device (devfn < 128).
> +         */
> +        lo =3D (context_table_ptr & VTD_ROOT_ENTRY_CTP) | VTD_ROOT_ENTRY=
_P;
> +        hi =3D 0;  /* UP=3D0: upper context table not present */
> +    } else {
> +        /*
> +         * Legacy Root Entry (Section 9.1):
> +         * lo =3D Context Table Pointer + Present
> +         * hi =3D Reserved
> +         */
> +        lo =3D (context_table_ptr & VTD_ROOT_ENTRY_CTP) | VTD_ROOT_ENTRY=
_P;
> +        hi =3D 0;
> +    }
> +
> +    qtest_writeq(qts, root_entry_addr, lo);
> +    qtest_writeq(qts, root_entry_addr + 8, hi);
> +}
> +
> +static void qvtd_build_context_entry(QTestState *qts, uint16_t sid,
> +                                     QVTDTransMode mode, uint64_t ssptpt=
r)
> +{
> +    uint8_t devfn =3D sid & 0xff;
> +    uint64_t context_entry_addr =3D QVTD_CONTEXT_TABLE_BASE +
> +                                 (devfn * VTD_CTX_ENTRY_LEGACY_SIZE);
> +    uint64_t lo, hi;
> +
> +    if (mode =3D=3D QVTD_TM_LEGACY_PT) {
> +        /*
> +         * Pass-through mode (Section 9.3):
> +         * lo: P + FPD(=3D0, fault enabled) + TT(=3DPass-through)
> +         * hi: DID + AW
> +         */
> +        lo =3D VTD_CONTEXT_ENTRY_P | VTD_CONTEXT_TT_PASS_THROUGH;
> +        hi =3D ((uint64_t)QVTD_DOMAIN_ID << 8) | QVTD_AW_48BIT_ENCODING;
> +    } else {
> +        /*
> +         * Translated mode (Section 9.3):
> +         * lo: P + FPD(=3D0, fault enabled) + TT(=3DMulti-level) + SSPTP=
TR
> +         * hi: DID + AW(=3D48-bit, 4-level)
> +         */
> +        lo =3D VTD_CONTEXT_ENTRY_P | VTD_CONTEXT_TT_MULTI_LEVEL |
> +             (ssptptr & VTD_CONTEXT_ENTRY_SSPTPTR);
> +        hi =3D ((uint64_t)QVTD_DOMAIN_ID << 8) | QVTD_AW_48BIT_ENCODING;
> +    }
> +
> +    qtest_writeq(qts, context_entry_addr, lo);
> +    qtest_writeq(qts, context_entry_addr + 8, hi);
> +}
> +
> +static void qvtd_build_scalable_context_entry(QTestState *qts, uint16_t =
sid)
> +{
> +    uint8_t devfn =3D sid & 0xff;
> +    uint64_t ce_addr =3D QVTD_CONTEXT_TABLE_BASE +
> +                       (devfn * VTD_CTX_ENTRY_SCALABLE_SIZE);
> +
> +    /*
> +     * Scalable-Mode Context Entry (Section 9.4), 32 bytes =3D 4 qwords:
> +     *
> +     * val[0]: P + FPD(=3D0) + DTE(=3D0) + PASIDE(=3D0) + PRE(=3D0) + HP=
TE(=3D0)
> +     *         + EPTR(=3D0) + PDTS(=3D0) + PASIDDIRPTR
> +     * val[1]: RID_PASID(=3D0) + PDTTE(=3D0) + PRE(=3D0) + RID_CG(=3D0)
> +     * val[2]: Reserved (must be 0)
> +     * val[3]: Reserved (must be 0)
> +     */
> +    qtest_writeq(qts, ce_addr,
> +                 (QVTD_PASID_DIR_BASE & VTD_PASID_DIR_BASE_ADDR_MASK) |
> +                 VTD_CONTEXT_ENTRY_P);
> +    qtest_writeq(qts, ce_addr + 8, 0);
> +    qtest_writeq(qts, ce_addr + 16, 0);
> +    qtest_writeq(qts, ce_addr + 24, 0);
> +}
> +
> +static void qvtd_build_pasid_dir_entry(QTestState *qts)
> +{
> +    uint64_t addr =3D QVTD_PASID_DIR_BASE +
> +                    VTD_PASID_DIR_INDEX(0) * VTD_PASID_DIR_ENTRY_SIZE;
> +
> +    /*
> +     * PASID Directory Entry (Section 9.5):
> +     * P + FPD(=3D0, fault enabled) + SMPTBLPTR
> +     */
> +    qtest_writeq(qts, addr,
> +                 (QVTD_PASID_TABLE_BASE & VTD_PASID_TABLE_BASE_ADDR_MASK=
) |
> +                 VTD_PASID_ENTRY_P);
> +}
> +
> +static void qvtd_build_pasid_table_entry(QTestState *qts, QVTDTransMode =
mode,
> +                                         uint64_t ptptr)
> +{
> +    uint64_t addr =3D QVTD_PASID_TABLE_BASE +
> +                    VTD_PASID_TABLE_INDEX(0) * VTD_PASID_ENTRY_SIZE;
> +    uint64_t val0, val1, val2;
> +
> +    /*
> +     * Scalable-Mode PASID Table Entry (Section 9.6), 64 bytes =3D 8 qwo=
rds:
> +     *
> +     * val[0]: P + FPD(=3D0) + AW + PGTT + SSADE(=3D0) + SSPTPTR
> +     * val[1]: DID + PWSNP(=3D0) + PGSNP(=3D0)
> +     *         + CD(=3D0) + EMTE(=3D0) + PAT(=3D0): Memory Type,
> +     *           all Reserved(0) since QEMU ECAP.MTS=3D0
> +     * val[2]: SRE(=3D0) + FSPM(=3D0, 4-level) + WPE(=3D0) + IGN + EAFE(=
=3D0) + FSPTPTR
> +     * val[3]: Reserved (must be 0)
> +     * val[4]: HPT fields, Reserved(0) since QEMU ECAP.HPTS=3D0
> +     * val[5]: HPT fields, Reserved(0) since QEMU ECAP.HPTS=3D0
> +     * val[6]: Reserved (must be 0)
> +     * val[7]: Reserved (must be 0)
> +     */
> +    switch (mode) {
> +    case QVTD_TM_SCALABLE_PT:
> +        val0 =3D VTD_PASID_ENTRY_P |
> +               ((uint64_t)VTD_SM_PASID_ENTRY_PT << 6);
> +        val1 =3D (uint64_t)QVTD_DOMAIN_ID;
> +        val2 =3D 0;
> +        break;
> +    case QVTD_TM_SCALABLE_SLT:
> +        val0 =3D VTD_PASID_ENTRY_P |
> +               ((uint64_t)VTD_SM_PASID_ENTRY_SST << 6) |
> +               ((uint64_t)QVTD_AW_48BIT_ENCODING << 2) |
> +               (ptptr & VTD_SM_PASID_ENTRY_SSPTPTR);
> +        val1 =3D (uint64_t)QVTD_DOMAIN_ID;
> +        val2 =3D 0;
> +        break;
> +    case QVTD_TM_SCALABLE_FLT:
> +        /*
> +         * val[2] fields for FLT (Section 9.6):
> +         * SRE(=3D0, user-level DMA only) + FSPM(=3D0, 4-level) +
> +         * WPE(=3D0, no supervisor write-protect) + IGN + EAFE(=3D0) + F=
SPTPTR
> +         */
> +        val0 =3D VTD_PASID_ENTRY_P |
> +               ((uint64_t)VTD_SM_PASID_ENTRY_FST << 6);
> +        val1 =3D (uint64_t)QVTD_DOMAIN_ID;
> +        val2 =3D ptptr & QVTD_SM_PASID_ENTRY_FSPTPTR;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    qtest_writeq(qts, addr, val0);
> +    qtest_writeq(qts, addr + 8, val1);
> +    qtest_writeq(qts, addr + 16, val2);
> +    qtest_writeq(qts, addr + 24, 0);
> +    qtest_writeq(qts, addr + 32, 0);
> +    qtest_writeq(qts, addr + 40, 0);
> +    qtest_writeq(qts, addr + 48, 0);
> +    qtest_writeq(qts, addr + 56, 0);
> +}
> +
> +/*
> + * VT-d second-level paging helpers.
> + * 4-level, 48-bit address space, 9 bits per level index.
> + */
> +static uint32_t qvtd_get_table_index(uint64_t iova, int level)
> +{
> +    int shift =3D VTD_PAGE_SHIFT + VTD_LEVEL_BITS * (level - 1);
> +
> +    return (iova >> shift) & ((1u << VTD_LEVEL_BITS) - 1);
> +}
> +
> +static uint64_t qvtd_get_table_addr(uint64_t base, int level, uint64_t i=
ova)
> +{
> +    return base + (qvtd_get_table_index(iova, level) * QVTD_PTE_SIZE);
> +}
> +
> +static uint64_t qvtd_get_pte_attrs(void)
> +{
> +    /* Second-level: R/W in every paging entry (Section 3.7.1) */
> +    return VTD_SS_R | VTD_SS_W;
> +}
> +
> +static uint64_t qvtd_get_fl_pte_attrs(bool is_leaf)
> +{
> +    /* First-level: x86 page table format (VT-d spec Section 9.9) */
> +    uint64_t attrs =3D VTD_FS_P | VTD_FS_RW | VTD_FS_US | VTD_FS_A;
> +
> +    if (is_leaf) {
> +        attrs |=3D VTD_FS_D;
> +    }
> +    return attrs;
> +}
> +
> +void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
> +                                   QVTDTransMode mode)
> +{
> +    bool is_fl =3D (mode =3D=3D QVTD_TM_SCALABLE_FLT);
> +    uint64_t non_leaf_attrs, leaf_attrs;
> +
> +    if (is_fl) {
> +        non_leaf_attrs =3D qvtd_get_fl_pte_attrs(false);
> +        leaf_attrs =3D qvtd_get_fl_pte_attrs(true);
> +    } else {
> +        /* Second-level: all levels use identical R/W attrs (spec 3.7.1)=
 */
> +        non_leaf_attrs =3D qvtd_get_pte_attrs();
> +        leaf_attrs =3D non_leaf_attrs;
> +    }
> +
> +    g_test_message("Page table setup: IOVA=3D0x%" PRIx64
> +                   " PA=3D0x%" PRIx64 " %s",
> +                   (uint64_t)iova, (uint64_t)QVTD_PT_VAL,
> +                   is_fl ? "first-level" : "second-level");
> +
> +    /* PML4 (L4) -> PDPT (L3) -> PD (L2) -> PT (L1) -> PA */
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L4_BASE, 4, iova),
> +                 QVTD_PT_L3_BASE | non_leaf_attrs);
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L3_BASE, 3, iova),
> +                 QVTD_PT_L2_BASE | non_leaf_attrs);
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L2_BASE, 2, iova),
> +                 QVTD_PT_L1_BASE | non_leaf_attrs);
> +    qtest_writeq(qts, qvtd_get_table_addr(QVTD_PT_L1_BASE, 1, iova),
> +                 (QVTD_PT_VAL & VTD_PAGE_MASK_4K) | leaf_attrs);
> +}
> +
> +void qvtd_program_regs(QTestState *qts, uint64_t iommu_base,
> +                       QVTDTransMode mode)
> +{
> +    uint32_t gcmd =3D 0;
> +    uint64_t rtaddr =3D QVTD_ROOT_TABLE_BASE;
> +
> +    /* Set SMT bit for scalable mode (VT-d spec Section 9.1) */
> +    if (qvtd_is_scalable(mode)) {
> +        rtaddr |=3D VTD_RTADDR_SMT;
> +    }
> +
> +    /* Set Root Table Address */
> +    qtest_writeq(qts, iommu_base + DMAR_RTADDR_REG, rtaddr);
> +
> +    /* Set Root Table Pointer and verify */
> +    gcmd |=3D VTD_GCMD_SRTP;
> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
> +    g_assert(qtest_readl(qts, iommu_base + DMAR_GSTS_REG) & VTD_GSTS_RTP=
S);
> +
> +    /* Setup Invalidation Queue */
> +    qtest_writeq(qts, iommu_base + DMAR_IQA_REG,
> +                 QVTD_IQ_BASE | QVTD_IQ_QS);
> +    qtest_writeq(qts, iommu_base + DMAR_IQH_REG, 0);
> +    qtest_writeq(qts, iommu_base + DMAR_IQT_REG, 0);
> +
> +    /* Enable Queued Invalidation and verify */
> +    gcmd |=3D VTD_GCMD_QIE;
> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
> +    g_assert(qtest_readl(qts, iommu_base + DMAR_GSTS_REG) & VTD_GSTS_QIE=
S);
> +
> +    /* Setup Fault Event MSI */
> +    qtest_writel(qts, iommu_base + DMAR_FECTL_REG, 0x0);
> +    qtest_writel(qts, iommu_base + DMAR_FEDATA_REG, QVTD_FAULT_IRQ_DATA);
> +    qtest_writel(qts, iommu_base + DMAR_FEADDR_REG, QVTD_FAULT_IRQ_ADDR);
> +
> +    /* Enable translation and verify */
> +    gcmd |=3D VTD_GCMD_TE;
> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
> +    g_assert(qtest_readl(qts, iommu_base + DMAR_GSTS_REG) & VTD_GSTS_TES=
);
> +}
> +
> +uint32_t qvtd_build_translation(QTestState *qts, QVTDTransMode mode,
> +                                uint16_t sid)
> +{
> +    uint8_t bus =3D (sid >> 8) & 0xff;
> +
> +    g_test_message("Build translation: IOVA=3D0x%" PRIx64 " PA=3D0x%" PR=
Ix64
> +                   " mode=3D%d",
> +                   (uint64_t)QVTD_IOVA, (uint64_t)QVTD_PT_VAL, mode);
> +
> +    /* Clear IOMMU structure regions to avoid stale entries */
> +    qtest_memset(qts, QVTD_ROOT_TABLE_BASE, 0, 0x1000);
> +    qtest_memset(qts, QVTD_PT_L4_BASE, 0, 0x4000);
> +
> +    if (qvtd_is_scalable(mode)) {
> +        /* Scalable: 32B context entries need 8KB */
> +        qtest_memset(qts, QVTD_CONTEXT_TABLE_BASE, 0, 0x2000);
> +        qtest_memset(qts, QVTD_PASID_DIR_BASE, 0, 0x1000);
> +        qtest_memset(qts, QVTD_PASID_TABLE_BASE, 0, 0x1000);
> +    } else {
> +        qtest_memset(qts, QVTD_CONTEXT_TABLE_BASE, 0, 0x1000);
> +    }
> +
> +    qvtd_build_root_entry(qts, bus, QVTD_CONTEXT_TABLE_BASE, mode);
> +
> +    if (qvtd_is_scalable(mode)) {
> +        /* Scalable path: context -> PASID dir -> PASID entry -> page ta=
bles */
> +        qvtd_build_scalable_context_entry(qts, sid);
> +        qvtd_build_pasid_dir_entry(qts);
> +
> +        if (mode =3D=3D QVTD_TM_SCALABLE_PT) {
> +            qvtd_build_pasid_table_entry(qts, mode, 0);
> +        } else {
> +            qvtd_setup_translation_tables(qts, QVTD_IOVA, mode);
> +            qvtd_build_pasid_table_entry(qts, mode, QVTD_PT_L4_BASE);
> +        }
> +    } else {
> +        /* Legacy path */
> +        if (mode =3D=3D QVTD_TM_LEGACY_PT) {
> +            qvtd_build_context_entry(qts, sid, mode, 0);
> +        } else {
> +            qvtd_setup_translation_tables(qts, QVTD_IOVA, mode);
> +            qvtd_build_context_entry(qts, sid, mode, QVTD_PT_L4_BASE);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +uint32_t qvtd_setup_and_enable_translation(QVTDTestContext *ctx)
> +{
> +    uint32_t build_result;
> +
> +    /* Build translation structures first */
> +    build_result =3D qvtd_build_translation(ctx->qts, ctx->config.trans_=
mode,
> +                                          ctx->sid);
> +    if (build_result !=3D 0) {
> +        g_test_message("Build failed: mode=3D%u sid=3D%u status=3D0x%x",
> +                       ctx->config.trans_mode, ctx->sid, build_result);
> +        ctx->trans_status =3D build_result;
> +        return ctx->trans_status;
> +    }
> +
> +    /* Program IOMMU registers (sets root table pointer, enables transla=
tion) */
> +    qvtd_program_regs(ctx->qts, ctx->iommu_base, ctx->config.trans_mode);
> +
> +    ctx->trans_status =3D 0;
> +    return ctx->trans_status;
> +}
> +
> +static bool qvtd_validate_test_result(QVTDTestContext *ctx)
> +{
> +    uint32_t expected =3D qvtd_expected_dma_result(ctx);
> +
> +    g_test_message("-> Validating result: expected=3D0x%x actual=3D0x%x",
> +                   expected, ctx->dma_result);
> +    return (ctx->dma_result =3D=3D expected);
> +}
> +
> +static uint32_t qvtd_single_translation_setup(void *opaque)
> +{
> +    return qvtd_setup_and_enable_translation(opaque);
> +}
> +
> +static uint32_t qvtd_single_translation_attrs(void *opaque)
> +{
> +    return qvtd_build_dma_attrs();
> +}
> +
> +static bool qvtd_single_translation_validate(void *opaque)
> +{
> +    return qvtd_validate_test_result(opaque);
> +}
> +
> +static void qvtd_single_translation_report(void *opaque, uint32_t dma_re=
sult)
> +{
> +    QVTDTestContext *ctx =3D opaque;
> +
> +    if (dma_result !=3D 0) {
> +        g_test_message("DMA failed: mode=3D%u result=3D0x%x",
> +                       ctx->config.trans_mode, dma_result);
> +    } else {
> +        g_test_message("-> DMA succeeded: mode=3D%u",
> +                       ctx->config.trans_mode);
> +    }
> +}
> +
> +void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
> +                               QPCIBar bar, uint64_t iommu_base,
> +                               const QVTDTestConfig *cfg)
> +{
> +    QVTDTestContext ctx =3D {
> +        .qts =3D qts,
> +        .dev =3D dev,
> +        .bar =3D bar,
> +        .iommu_base =3D iommu_base,
> +        .config =3D *cfg,
> +        .sid =3D dev->devfn,
> +    };
> +
> +    QOSIOMMUTestdevDmaCfg dma =3D {
> +        .dev =3D dev,
> +        .bar =3D bar,
> +        .iova =3D QVTD_IOVA,
> +        .gpa =3D cfg->dma_gpa,
> +        .len =3D cfg->dma_len,
> +    };
> +
> +    qtest_memset(qts, cfg->dma_gpa, 0x00, cfg->dma_len);
> +    qos_iommu_testdev_single_translation(&dma, &ctx,
> +                                         qvtd_single_translation_setup,
> +                                         qvtd_single_translation_attrs,
> +                                         qvtd_single_translation_validat=
e,
> +                                         qvtd_single_translation_report,
> +                                         &ctx.dma_result);
> +
> +    if (ctx.dma_result =3D=3D 0 && ctx.config.expected_result =3D=3D 0) {
> +        g_autofree uint8_t *buf =3D NULL;
> +
> +        buf =3D g_malloc(ctx.config.dma_len);
> +        qtest_memread(ctx.qts, ctx.config.dma_gpa, buf, ctx.config.dma_l=
en);
> +
> +        for (int i =3D 0; i < ctx.config.dma_len; i++) {
> +            uint8_t expected;
> +
> +            expected =3D (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
> +            g_assert_cmpuint(buf[i], =3D=3D, expected);
> +        }
> +    }
> +}
> diff --git a/tests/qtest/libqos/qos-intel-iommu.h b/tests/qtest/libqos/qo=
s-intel-iommu.h
> new file mode 100644
> index 0000000000..c6cacc5c3f
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-intel-iommu.h
> @@ -0,0 +1,185 @@
> +/*
> + * QOS Intel IOMMU (VT-d) Module
> + *
> + * This module provides Intel IOMMU-specific helper functions for libqos=
 tests,
> + * encapsulating VT-d setup, assertion, and cleanup operations.
> + *
> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QTEST_LIBQOS_INTEL_IOMMU_H
> +#define QTEST_LIBQOS_INTEL_IOMMU_H
> +
> +#include "hw/misc/iommu-testdev.h"
> +#include "hw/i386/intel_iommu_internal.h"
> +
> +/*
> + * Guest memory layout for IOMMU structures.
> + * All structures are placed in guest physical memory inside the 512MB R=
AM.
> + * Using 256MB mark (0x10000000) as base to ensure all structures fit in=
 RAM.
> + */
> +#define QVTD_MEM_BASE             0x10000000ULL
> +
> +/* Root Entry Table: 256 entries * 16 bytes =3D 4KB */
> +#define QVTD_ROOT_TABLE_BASE      (QVTD_MEM_BASE + 0x00000000)
> +
> +/* Context Entry Table: 256 entries, 16B (legacy) or 32B (scalable) per =
entry */
> +#define QVTD_CONTEXT_TABLE_BASE   (QVTD_MEM_BASE + 0x00001000)
> +
> +/* Page Tables: 4-level hierarchy for 48-bit address translation */
> +#define QVTD_PT_L4_BASE           (QVTD_MEM_BASE + 0x00010000)  /* PML4 =
*/
> +#define QVTD_PT_L3_BASE           (QVTD_MEM_BASE + 0x00011000)  /* PDPT =
*/
> +#define QVTD_PT_L2_BASE           (QVTD_MEM_BASE + 0x00012000)  /* PD */
> +#define QVTD_PT_L1_BASE           (QVTD_MEM_BASE + 0x00013000)  /* PT */
> +
> +/*
> + * Invalidation Queue.
> + * IQA_REG bits[2:0] =3D QS, entries =3D 1 << (QS + 8), each entry 16 by=
tes.
> + */
> +#define QVTD_IQ_BASE              (QVTD_MEM_BASE + 0x00020000)
> +#define QVTD_IQ_QS                0    /* QS=3D0 =E2=86=92 256 entries */
> +
> +/*
> + * Fault Event MSI configuration.
> + */
> +#define QVTD_FAULT_IRQ_ADDR       0xfee00000   /* APIC base */
> +#define QVTD_FAULT_IRQ_DATA       0x0
> +
> +/* Scalable mode PASID structures */
> +#define QVTD_PASID_DIR_BASE        (QVTD_MEM_BASE + 0x00030000)
> +#define QVTD_PASID_TABLE_BASE      (QVTD_MEM_BASE + 0x00031000)
> +
> +/* Page table entry size (8 bytes per PTE) */
> +#define QVTD_PTE_SIZE             sizeof(uint64_t)
> +
> +/* FSPTPTR mask: same as VTD_SM_PASID_ENTRY_SSPTPTR, bits[63:12] */
> +#define QVTD_SM_PASID_ENTRY_FSPTPTR   VTD_SM_PASID_ENTRY_SSPTPTR
> +
> +/* Default Domain ID for single-domain tests */
> +#define QVTD_DOMAIN_ID            0
> +
> +/* Test IOVA and target physical address */
> +#define QVTD_IOVA                 0x0000000010200567ull
> +#define QVTD_PT_VAL               (QVTD_MEM_BASE + 0x00100000)
> +
> +/*
> + * Translation modes supported by Intel IOMMU
> + */
> +typedef enum QVTDTransMode {
> +    QVTD_TM_LEGACY_PT,          /* Legacy pass-through mode */
> +    QVTD_TM_LEGACY_TRANS,       /* Legacy translated mode (4-level pagin=
g) */
> +    QVTD_TM_SCALABLE_PT,        /* Scalable pass-through mode */
> +    QVTD_TM_SCALABLE_SLT,       /* Scalable Second Level Translation */
> +    QVTD_TM_SCALABLE_FLT,       /* Scalable First Level Translation */
> +} QVTDTransMode;
> +
> +static inline bool qvtd_is_scalable(QVTDTransMode mode)
> +{
> +    return mode =3D=3D QVTD_TM_SCALABLE_PT ||
> +           mode =3D=3D QVTD_TM_SCALABLE_SLT ||
> +           mode =3D=3D QVTD_TM_SCALABLE_FLT;
> +}
> +
> +typedef struct QVTDTestConfig {
> +    QVTDTransMode trans_mode;     /* Translation mode */
> +    uint64_t dma_gpa;             /* GPA for readback validation */
> +    uint32_t dma_len;             /* DMA length for testing */
> +    uint32_t expected_result;     /* Expected DMA result */
> +} QVTDTestConfig;
> +
> +typedef struct QVTDTestContext {
> +    QTestState *qts;              /* QTest state handle */
> +    QPCIDevice *dev;              /* PCI device handle */
> +    QPCIBar bar;                  /* PCI BAR for MMIO access */
> +    QVTDTestConfig config;        /* Test configuration */
> +    uint64_t iommu_base;          /* Intel IOMMU base address */
> +    uint32_t trans_status;        /* Translation configuration status */
> +    uint32_t dma_result;          /* DMA operation result */
> +    uint16_t sid;                 /* Source ID (bus:devfn) */
> +} QVTDTestContext;
> +
> +/*
> + * qvtd_setup_and_enable_translation - Complete translation setup and en=
able
> + *
> + * @ctx: Test context containing configuration and device handles
> + *
> + * Returns: Translation status (0 =3D success, non-zero =3D error)
> + *
> + * This function performs the complete translation setup sequence:
> + * 1. Builds VT-d structures (root/context entry, page tables)
> + * 2. Programs IOMMU registers and enables translation
> + * 3. Returns configuration status
> + */
> +uint32_t qvtd_setup_and_enable_translation(QVTDTestContext *ctx);
> +
> +/*
> + * qvtd_build_translation - Build Intel IOMMU translation structures
> + *
> + * @qts: QTest state handle
> + * @mode: Translation mode (pass-through or translated)
> + * @sid: Source ID (bus:devfn)
> + *
> + * Returns: Build status (0 =3D success, non-zero =3D error)
> + *
> + * Constructs all necessary VT-d translation structures in guest memory:
> + * - Root Entry for the device's bus
> + * - Context Entry for the device
> + * - Complete 4-level page table hierarchy (if translated mode)
> + */
> +uint32_t qvtd_build_translation(QTestState *qts, QVTDTransMode mode,
> +                                uint16_t sid);
> +
> +/*
> + * qvtd_program_regs - Program Intel IOMMU registers and enable translat=
ion
> + *
> + * @qts: QTest state handle
> + * @iommu_base: IOMMU base address
> + * @mode: Translation mode (scalable modes set RTADDR SMT bit)
> + *
> + * Programs IOMMU registers with the following sequence:
> + * 1. Set root table pointer (SRTP), with SMT bit for scalable mode
> + * 2. Setup invalidation queue (QIE)
> + * 3. Configure fault event MSI
> + * 4. Enable translation (TE)
> + *
> + * Each step verifies completion via GSTS register read-back.
> + */
> +void qvtd_program_regs(QTestState *qts, uint64_t iommu_base,
> +                       QVTDTransMode mode);
> +
> +/*
> + * qvtd_setup_translation_tables - Setup complete VT-d page table hierar=
chy
> + *
> + * @qts: QTest state handle
> + * @iova: Input Virtual Address to translate
> + * @mode: Translation mode
> + *
> + * This builds the 4-level page table structure for translating
> + * the given IOVA to PA through Intel VT-d. The structure is:
> + * - PML4 (Level 4): IOVA bits [47:39]
> + * - PDPT (Level 3): IOVA bits [38:30]
> + * - PD (Level 2): IOVA bits [29:21]
> + * - PT (Level 1): IOVA bits [20:12]
> + * - Page offset: IOVA bits [11:0]
> + *
> + * The function writes all necessary Page Table Entries (PTEs) to guest
> + * memory using qtest_writeq(), setting up the complete translation path
> + * that the VT-d hardware will traverse during DMA operations.
> + */
> +void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
> +                                   QVTDTransMode mode);
> +
> +/* Calculate expected DMA result */
> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx);
> +
> +/* Build DMA attributes for Intel VT-d */
> +uint32_t qvtd_build_dma_attrs(void);
> +
> +/* High-level test execution helpers */
> +void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
> +                               QPCIBar bar, uint64_t iommu_base,
> +                               const QVTDTestConfig *cfg);
> +
> +#endif /* QTEST_LIBQOS_INTEL_IOMMU_H */

Reviewed-by: Fabiano Rosas <farosas@suse.de>

