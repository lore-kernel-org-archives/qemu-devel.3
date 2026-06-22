Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24775CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfL3-0005zy-LZ; Mon, 22 Jun 2026 10:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbfKw-0005xv-5X
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbfKq-0003yT-Uj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782137351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/pk/8Zbpm6QjgreHVkCJvzVo51Jy9V+4ysvz2J3N68=;
 b=VvHXWetAtoefw8mskwL9T9HN57ZYsD6zDKne/a/m6m5QF+SjI/K0BN3cJiRBHNNnz5gEjH
 b1WHrYZzNya4COLE96mVtRU3n6cY3iiEOWXdrnN5jlz8LNPbQSacvdpVP+NJY/On44OPVY
 1apAgN9/qN2rSnbVEJl2dmHf29VJmXg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-O8jpn0H8PuySKOVrkIrrRg-1; Mon, 22 Jun 2026 10:09:09 -0400
X-MC-Unique: O8jpn0H8PuySKOVrkIrrRg-1
X-Mimecast-MFC-AGG-ID: O8jpn0H8PuySKOVrkIrrRg_1782137348
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso40648215e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782137348; x=1782742148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/pk/8Zbpm6QjgreHVkCJvzVo51Jy9V+4ysvz2J3N68=;
 b=icbx5/6D8ekhlfRs6MHno7gtsDRBeVbXlWmp3gFcY4xhMoJo5N1gshlYhZ0lGpE2Hw
 C7TvvYEcAqhaHnMfCWDRplVU0Gq4ABlcZD/Rz/6SVQDy9lmvwM2xyYkFj7/dJoADFr9A
 ez7apvtZggCo+lK3YuMmxqDkRfk364X3JltfZ1vWoPhZcu8phIN3Rkbog+p+CRRS+QIx
 UdrypVS+Bh5V5eTnJUlvU1qWrOkq6rO7JybYzhAzMLjPn08jn2zzd1h90rBXeSAIwjGm
 DT8hldNDOHvFNzQ1TQcS3R1SN1F12J+cZ/GUW9mKBL/LsI/tx9/VdEyzejOXwPnMEXr0
 rBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782137348; x=1782742148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/pk/8Zbpm6QjgreHVkCJvzVo51Jy9V+4ysvz2J3N68=;
 b=Nf5Rev4IUyp4Uxh8v2oyF5+lc/pdIJJpmfa3wXVauiEPnRTV2vtkFnOk7q02MIYxBZ
 uqQ7K0Ocp1JmTfvOXcZbqXXXZWidErcQj2ltpJHSiYFgZJQ9rR+1Sf7ZhBO0XCA/I+rX
 QrtJVAUjrygGCAyM8jfN0/79DRjbd0H5Tg0WRDSuu2pYdbI7xX/ChZpC7AzP3PEO9Wz8
 byjC5N3NM2xCunPCglXqs/koh2Gwz6kkCcKnbPtXw562810zmr2QYSkeARDeM3AZGeaM
 5AFzO8t/lg9gqAg5oXVdACT9FjGJYUWMGNLu8bbvTzCNtrJiikWm/F9ZWN8N1rYQky5a
 wk+w==
X-Gm-Message-State: AOJu0YxDTNgS+MEBaszEPGGFjLgLs7cEHD7/0XLjvXsItjOSFp26uB8I
 2njBvoKIFaOQU++/oR9WwxdxvSW/Pfr/CyWTqD7gv55T4vj7uZcpgNuUkdFfmcCC3laD5gRvaij
 mFj8vZAg1Mdt6dOGhRZYt1no6qCEbivlukelW757/fSjsaiKXmhiFDA6r
X-Gm-Gg: AfdE7cn5Vl9+JZmrwywnj1zlx3Nke5oP5IeXY6AYBJQ/r4jR7cP536qEqzbSurg6K17
 w+DObYvZkvdTQsDljU6cTw7hhA0cJNEnfJrrs218nW/EofcPC+TICLvRdqnNS9cisKcq+aIK+ax
 at6R1fNHQHK1EQfARcClTGAyAhQLLIMLs+5OVBSvl8c5ZRdRgXhTCmIsAwQy2qf6DERFFwerFmZ
 Fj2N41Mvw24UZuJwUl/mfrJzPh8yZlfVbsG0vCVOUzJNSWqAJfSwna3l/NbxSZkDrkXkFzIqjmk
 VxsNWmvV2gR4L8RTBFTSectHnvjzKndF6iXtzvuaXIMscrfAAaaV02kI2BVMmkqbKUr5vMM=
X-Received: by 2002:a05:600c:3516:b0:490:c2a2:e91c with SMTP id
 5b1f17b1804b1-4924258fbbdmr222390455e9.34.1782137347750; 
 Mon, 22 Jun 2026 07:09:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:490:c2a2:e91c with SMTP id
 5b1f17b1804b1-4924258fbbdmr222389805e9.34.1782137347169; 
 Mon, 22 Jun 2026 07:09:07 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240efc63fsm187039745e9.1.2026.06.22.07.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:09:06 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:09:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 09/10] tests/qtest: add e820 fw_cfg test
Message-ID: <20260622160905.1fecce6f@imammedo>
In-Reply-To: <20260619111136.3481329-10-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-10-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 19 Jun 2026 19:11:35 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add a qtest that reads the "etc/e820" fw_cfg table and checks its
> structural invariants: the file is a whole number of e820 entries and
> every entry has a non-zero length. The baseline q35 case asserts the
> guest sees RAM and, with no sp-mem device, no SOFT_RESERVED range.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/e820-test.c | 95 +++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build |  1 +
>  2 files changed, 96 insertions(+)
>  create mode 100644 tests/qtest/e820-test.c
> 
> diff --git a/tests/qtest/e820-test.c b/tests/qtest/e820-test.c
> new file mode 100644
> index 0000000000..1db0744c08
> --- /dev/null
> +++ b/tests/qtest/e820-test.c
> @@ -0,0 +1,95 @@
> +/*
> + * qtest e820 fw_cfg test case
> + *
> + * Validate the "etc/e820" fw_cfg table that QEMU hands to the firmware.
> + *
> + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> + *
> + * Authors:
> + *  FangSheng Huang <FangSheng.Huang@amd.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "libqtest.h"
> +#include "libqos/fw_cfg.h"
> +#include "qemu/bswap.h"
> +
> +/* e820 entry layout and types (cf. hw/i386/e820_memory_layout.h) */
> +#define E820_RAM            1
> +#define E820_SOFT_RESERVED  0xefffffff
> +
> +struct e820_entry {
> +    uint64_t address;
> +    uint64_t length;
> +    uint32_t type;
> +} QEMU_PACKED;
> +
> +#define E820_MAX_ENTRIES    128
> +
> +/*
> + * Read and structurally validate "etc/e820": the file is a packed array
> + * of struct e820_entry, so its size must be a whole multiple of the entry
> + * size and every entry must have a non-zero length. Returns the entry
> + * count and fills @table.
> + */
> +static size_t get_e820_table(QFWCFG *fw_cfg, struct e820_entry *table)
> +{
> +    size_t filesize, n, i;
> +
> +    filesize = qfw_cfg_get_file(fw_cfg, "etc/e820", table,
> +                                E820_MAX_ENTRIES * sizeof(*table));
> +    g_assert_cmpint(filesize, >, 0);
> +    g_assert_cmpint(filesize % sizeof(struct e820_entry), ==, 0);
> +
> +    n = filesize / sizeof(struct e820_entry);
> +    g_assert_cmpint(n, <=, E820_MAX_ENTRIES);
> +
> +    for (i = 0; i < n; i++) {
> +        g_assert_cmpint(le64_to_cpu(table[i].length), >, 0);
> +    }
> +
> +    return n;
> +}
> +
> +static void test_e820_basic(void)
> +{
> +    struct e820_entry table[E820_MAX_ENTRIES];
> +    QFWCFG *fw_cfg;
> +    QTestState *s;
> +    size_t n, i;
> +    bool found_ram = false, found_soft_reserved = false;
> +
> +    s = qtest_init("-machine q35 -m 256M");
> +    fw_cfg = pc_fw_cfg_init(s);
> +
> +    n = get_e820_table(fw_cfg, table);
> +    for (i = 0; i < n; i++) {
> +        switch (le32_to_cpu(table[i].type)) {
> +        case E820_RAM:
> +            found_ram = true;
> +            break;
> +        case E820_SOFT_RESERVED:
> +            found_soft_reserved = true;
> +            break;
> +        }
> +    }
> +
> +    /* baseline: RAM present, no SOFT_RESERVED range */
> +    g_assert_true(found_ram);
> +    g_assert_false(found_soft_reserved);
> +
> +    pc_fw_cfg_uninit(fw_cfg);
> +    qtest_quit(s);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("e820/basic", test_e820_basic);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 4897325d84..d69ee27fa4 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -58,6 +58,7 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
>    (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
> +  (config_all_devices.has_key('CONFIG_Q35') ? ['e820-test'] : []) +                          \
>    (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
>    (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \


