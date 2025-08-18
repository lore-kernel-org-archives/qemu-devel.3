Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F702CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 13:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unzx8-00016Q-9I; Mon, 18 Aug 2025 09:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1unzx5-00015m-KI; Mon, 18 Aug 2025 09:31:07 -0400
Received: from mail-dm6nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2413::601]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1unzx1-0006T6-CG; Mon, 18 Aug 2025 09:31:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AomcuJT3jaepRckkz5+wxyyGRv8NBQ80K34P+vHxXSvdy3dxF1GhwLflrCfZD/geXopiehoD71dvKWw6FdWPteNSuShOtjU/WetEdG6gUwixTQRi9WXOnOaczDKw/grpnZ8A6UPgKjREBKiQqx71OfNOKybHjVVzQSf1KC/OW9bHUQWyXPYr921aUK1TdDWB6wsmjZCjWUvt+/mRYCqHeM2JnxVDvHQ32TB8IoES/8vakHQjtnjmt8WFgGn68vIX/gRKSt8neNwXBn4OEK/0MeMk7im50ztPxeuZDwfBwi5Y339UggZJmkH55erGHOJOzlEmuBVQxJKlxzHhNp3U/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf9iS+v7NjtsqxjSGzjgXwCWNlhgDBVnsy5NpEPon6g=;
 b=wyFWFobKZYZ6my62W8tMndAFSjl9J932SuCl36R4vHL6fdMgVmKr4FmAnWsDy9AJU3IQ4TYa8IMV2b0jmUx7kixMH2+ljkQFIimuriPia7GlMBiHy5ILZ9D7baF+3ZBcIrg2+AU117HDQdvGbEV/NIZ5eoNPIggb5w923EBUBRMqUuuU5Lv5pb3/kyj7AAfhOS77aU98cDkWHx48+cDeYiT7vZ2NJdo5ewrecSYTZEqEllt106u1J1n+cQfsbzXBCXAo79RiND7noRQUMFxsZcewB47nd9UEM6jezuvZWwwkKQesmE0axXGbSuamN+lfQzqjxdTLBLlEaRCouHTN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf9iS+v7NjtsqxjSGzjgXwCWNlhgDBVnsy5NpEPon6g=;
 b=sgbu/3KWt++YmdQZjzRAaYLcptm73lAmJ5+UQyx0PUb4Ir1EvfZzXdE9JCKuV3WA9/bvpHpt030cUvvouRd1XQ84W6gfo6GTnmyGbQC8SSewuWw1fCnM2+kZrEExbXjMOwJ7gQ5GneA8wzPeZE1OG4qDmn0qw62jx31DSHhtBD8=
Received: from CH2PR07CA0025.namprd07.prod.outlook.com (2603:10b6:610:20::38)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 13:30:54 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::58) by CH2PR07CA0025.outlook.office365.com
 (2603:10b6:610:20::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 13:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 13:30:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 08:30:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 08:30:53 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 08:30:52 -0500
Date: Mon, 18 Aug 2025 15:30:45 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
Message-ID: <aKMrBdNhtqHVHRYw@XFR-LUMICHEL-L2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
 <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: d299f6ad-356a-475d-e1dd-08ddde5b7531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfdl82WSSFdzaNDYzV4XwJvk0adAJY0xuR8Z5IJsM3BbWX+mxREiEm346HlI?=
 =?us-ascii?Q?eHlqP8mmDIfelRsmBE4WdmHmGVNNH1M1ByjSJJuXt1PrMvxn7w7TtlnkuGGj?=
 =?us-ascii?Q?z4Sayq49dkLp4lisKbC4n+OIOiaGazC8dneVa1L++q3AUAIu11vIjxs6X2Qj?=
 =?us-ascii?Q?lCzyoHeHduOYdeqtt+EwwQFIFzwPXo2QGMZ5PXC3RcEfJ7mRos2Ss9t+uRgr?=
 =?us-ascii?Q?O0rG+0W1h54Lo7FkBk50/uyzApmejPOg6+TVps2FRUHK4npTheN4WwrVURjI?=
 =?us-ascii?Q?PgygfCFYfvy39XaPbJadChBcQK6WcJGf2kg+d+FcX75q8/XI+UbEF4e0DJZm?=
 =?us-ascii?Q?JsrA19J7+daxfoek+eO9wdMu0No3cF2401goR2vYEZrNQ4bqvRkIanLyFJ4r?=
 =?us-ascii?Q?IbRpLWituo+k+uthgNbzADesnaOCaUWzgmAE1pWHaWx8h5NbJZNlJjSE0fJI?=
 =?us-ascii?Q?vic46GbK3lvc60yw10GgT75kiS4XUwn6N79Hn9AyFl1xedQKaAInwJDx/RHA?=
 =?us-ascii?Q?/mBwVWbLK63QMG6EDaUuaTXRtCakOM73YfI+xwzAEB1ztN2IfRqxY0hq6pIJ?=
 =?us-ascii?Q?r0ptDNmObkZeyx7zEGD0Vmu44nq0aEglAa/9uOALJrawnl8JbixdLXKU0DuY?=
 =?us-ascii?Q?lBrOt+aqRUJenc7o+YVYXKELM+Pcv1tSO6wnWauFY61UqEXU2XAnkqEf9til?=
 =?us-ascii?Q?jWBeGB6w37HMMCofBRSWIoOuzEmsAaxv/UzxluH411fTjyyU1jIyA4Mjy5x+?=
 =?us-ascii?Q?LO4O3INgMeIz7wDgL8CJHAqWS5ODm+aB4OyozKxcvUFjlJ7y2fleNpXVrDTv?=
 =?us-ascii?Q?0BrrembghBsnfH1ctK7KemLlOZYvswT0EgVnyCR6QAxrdgJsa+3PZW+odaaP?=
 =?us-ascii?Q?qTCkTg9JIS2NhDDn9xBcpGA6kGou9ssgxu3/y+NheQPwpkLikjEK4hDtfxcl?=
 =?us-ascii?Q?y6ltZAN5xFOibU5R/tshpAptC0FI8P4D28Z8eRqpOqhIQqShPWe+ZkoOc5ej?=
 =?us-ascii?Q?2EsAoyyrgWQPLpJoOLfSo3Czf0E4Az5MVH02sdzNt7S6EmQUssWiVyzqDn/N?=
 =?us-ascii?Q?xoKP/mUM+cFmNc9qXFVB9H+9/mLxwYe22ljlhSL9v7wGj7nYnwfeWf1LFPdP?=
 =?us-ascii?Q?rLHiM1P8DbVPaseEZLYNKHP+CoTVpApXLdhx1lNKs8j3Vmiud9DqwwfpRpiC?=
 =?us-ascii?Q?sc4/Y8YT/kUU35+ExPgQm394YxZ4rEKZ44ZV1KQXPG3F4w4Db9BMxQi7wUlj?=
 =?us-ascii?Q?H4y378rnkQjZ7gygzjanPxh4UZh56NhFTIfp+6ruWHrwhaKpC7iPFTK2iGRk?=
 =?us-ascii?Q?o/F4aFoCIyxooTwKZe4G4spxDGA6SfPwf7MkQ6qaZNU12a5q1gVv5MdvUEqw?=
 =?us-ascii?Q?8b5Pv7X7Mp5qsXxv9DtmN/iUv1hdHcJaDPnP/JG8PDbQBZHMz+hoKwqy2IDW?=
 =?us-ascii?Q?2sHHI33auiUkda8caeVPQbI9p8Q5xv4lXFxf+HIc0WvDPLZNIkwQwKY9TrFQ?=
 =?us-ascii?Q?yQdOdelFWlZ2NPNB7Uya1MBmVR7tFd4Zv1Wb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:30:54.5512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d299f6ad-356a-475d-e1dd-08ddde5b7531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
Received-SPF: permerror client-ip=2a01:111:f403:2413::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

On 13:24 Mon 04 Aug     , Peter Maydell wrote:
> On Wed, 16 Jul 2025 at 10:55, Luc Michel <luc.michel@amd.com> wrote:
> >
> > Improve the IRQ index in the VersalMap structure to turn it into a
> > descriptor:
> >    - the lower 16 bits still represent the IRQ index
> >    - bit 18 is used to indicate a shared IRQ connected to a OR gate
> >    - bits 19 to 22 indicate the index on the OR gate.
> >
> > This allows to share an IRQ among multiple devices. An OR gate is
> > created to connect the devices to the actual IRQ pin.
> 
> 
> > +/*
> > + * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
> > + * used to return the corresponding or gate input IRQ. The or gate is created if
> > + * not already existant.
> > + *
> > + * Or gates are placed under the /soc/irq-or-gates QOM container.
> > + */
> > +static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
> > +                                          qemu_irq target_irq)
> > +{
> > +    Object *container = versal_get_child(s, "irq-or-gates");
> > +    DeviceState *dev;
> > +    g_autofree char *name;
> > +    int idx, or_idx;
> > +
> > +    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
> > +    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> > +
> > +    name = g_strdup_printf("irq[%d]", idx);
> > +    dev = DEVICE(object_resolve_path_at(container, name));
> > +
> > +    if (dev == NULL) {
> > +        dev = qdev_new(TYPE_OR_IRQ);
> 
> Here we create a device...
> 
> > +        object_property_add_child(container, name, OBJECT(dev));
> > +        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
> > +        qdev_realize_and_unref(dev, NULL, &error_abort);
> > +        qdev_connect_gpio_out(dev, 0, target_irq);
> > +    }
> > +
> > +    return qdev_get_gpio_in(dev, or_idx);
> 
> ...but then we don't save the pointer to it, so the only
> thing still hanging onto it is the QOM tree.
> 
> If you want to change "embedded device struct" into
> "allocate memory to create devices" that's fine, but the
> SoC should still keep track of everything it's creating,
> so that (at least in theory) it could clean it up on
> unrealize.

I'm not sure I fully understand your point:

   - The OR gate device is parented to the "irq-or-gates" container,
     which is itself parented to the SoC. So finalizing (freeing) the
     SoC would trigger a cascade of free calls to the children,
     including those objects right?
   - Are you talking specifically about an unrealize call on the SoC
     object, without a subsequent free? I guess we don't expect to see
     such thing to happen in QEMU. The warning in the qdev_unrealize()
     documentation seems to go in that direction.

For reference, the QOM tree is as follows:

/machine (amd-versal-virt-machine)
  [...]
  /xlnx-versal (xlnx-versal)
    [...]
    /irq-or-gates (container)
      /gic-irq[121] (or-irq)
        /unnamed-gpio-in[0] (irq)
        /unnamed-gpio-in[10] (irq)
        /unnamed-gpio-in[11] (irq) 
        /unnamed-gpio-in[12] (irq)
        /unnamed-gpio-in[13] (irq) 
        /unnamed-gpio-in[14] (irq)
        /unnamed-gpio-in[15] (irq) 
        /unnamed-gpio-in[1] (irq)
        /unnamed-gpio-in[2] (irq)  
        /unnamed-gpio-in[3] (irq)
        /unnamed-gpio-in[4] (irq)
        /unnamed-gpio-in[5] (irq)
        /unnamed-gpio-in[6] (irq)
        /unnamed-gpio-in[7] (irq)
        /unnamed-gpio-in[8] (irq)
        /unnamed-gpio-in[9] (irq)
    [...]

Thanks

Luc

