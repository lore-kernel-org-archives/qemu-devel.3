Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910B0C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 22:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn4Yr-0004lX-D9; Wed, 20 Mar 2024 18:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rn4Yl-0004iv-1L
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:37:23 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rn4Yj-00078f-2S
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ0sRL8wMJzpZ2YCRJ/H37HxRbe9bW88dZNyq+A6i8aHUWYSKQflaV71v7MPL20iMcHH0XGG3q7V3DTWBUyPVUU4cPVtGYlKKsv9iNu5tl6qXpp1n8+/Y4v5gewQUUgVCvQAU4QBDr0dtwmwmpqk+UO49mXw8r/Bpks78HX7Oh5509BzakyDuTa03Xsmi22DnZoUkMJCZSBc1iSV7z3JTsy419qFNS2JMwBMrPUEdmEzXsd0N0gmpYNXjQmYnkECel58muTzmIj/2AOz/Q95qdG9f44ageSXnBNVtlCm/sWUO/xiBwtuRXTYTe+aMZhv83aPdcDSQCToD73RDnOuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAgkw2lDwUQFUmAsDYTj7fITv+GAJ5DtAlbGggYq0UI=;
 b=CB9ZEui19KW4Sog2HBLxb7DJZSyBVvAOtvy5litfX7pwGspShW+6OoP5YBbIpVih6GeWaLW9wv7xE8wmI/FYt4NCLd3algTMvP9iOwJuUKYUDp+4JZbYaTY8qnzTv4WIbHG26oaR5nZzNEVD/0jWHlVTG/AAOfm7uWEfXjqHmjDqy4iW7eIFI4b9KDjWpw4YBw4lWic4LDs5wl23LxPWDxv4/4OVwHV5g5i/DQc4RJQVg702cnEgWLkIjQfn2rDBOpFx1menNg9W6e4Orgyemxxs4INldaTs+VWB8ODzSi2e/6UTN6GL5QIK2bQ0E/Ye2X9aPjjZq1KDA9KddrlQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAgkw2lDwUQFUmAsDYTj7fITv+GAJ5DtAlbGggYq0UI=;
 b=aiFhvLxp0Ya7VQPp3t5Tel7nJWnFNFxEx4hq1AChECYMpQl8pnIgeJmVeMmoutNsyyoJuDftbMklYfiDPmh7OixGu3do8dG/dh5sIyveeGvpG1nH8+gHxUnmH6BU7DK9Yp1tuCI8FHFOAiJLAKzA/4MjlhDbKPVJpV7Y5PJuOSo=
Received: from CH2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:610:57::18)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 22:37:16 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::78) by CH2PR12CA0008.outlook.office365.com
 (2603:10b6:610:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 20 Mar 2024 22:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 22:37:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 17:37:15 -0500
Date: Wed, 20 Mar 2024 17:35:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: Isaku Yamahata <isaku.yamahata@intel.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Tom Lendacky
 <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel P
 =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v3 40/49] hw/i386/sev: Add function to get SEV metadata
 from OVMF header
Message-ID: <20240320223534.7pfvv365dtv3nr4u@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-41-michael.roth@amd.com>
 <20240320175535.GF1994522@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240320175535.GF1994522@ls.amr.corp.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a171387-64c2-4ba8-b2e0-08dc492e4b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdF5P8hgEzTbIhMcPFAqZHR0r3oWVyCS9EX2l7Ee5atjX5WMB6RCPpxibO2RfoFOi79i/jJwZvz+Dng8FTqnUsTvOK5NiX6ECsYGNGVlAdXWDXC8mDJeujjvMVSbbcVEukIg6X6kYQESqBijxh6tGDd/BbVzT1+iQDWnJ7kogmdwFdVEcuU/ic/+njCDUaIgeCqJ1J4yiN9/xdysSqQkrWB834j33q51+PEub8RrRboKumeHjGm38HUXQhfyxOhp8UjMZUTwgVJq9C+uk/gQopcpRNU7b0dmr08fotqY/QdnBk7KXqetD4dOTqF889grlGOK057NsPLADLPpW+7junIF8NTYK958vJk3DqJHZxY18OEj+U8gN97pkAt5334i2asjnuHdOcghMQ9mLK5jSX5hU0wc2XM4Gq+47Nyz5WPb7Crt+41144TKnC3Zy3dW4GFz5dw4gOnrUVDEodv2s5yyWZ7B/LkAxkjyh+3c5nMVyUSS3EKss7j5mMtHuL/ipLbJ6UEzUidYakN592VINotelYvJI7vOZYL+YESVDEprxzd7KUrslTkM1C7qSGvo9lYR9C8J0zDL8THKaWZdPGaOM6eeHBEYi2ScC2zGKP+ovH7oM0TsgUam3Utp00gRyalMZPHHaprIj40tZavLTYP4aSnFa1TKNa9rHcMyTFrvX/syJJ74h3SWkwRMVZepGayCmSjjNXo2UwUSNWsjzgKMoHetghPaDGGQ/iTrMVDgZDwd8k0AHI+60ww6ACwD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 22:37:15.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a171387-64c2-4ba8-b2e0-08dc492e4b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805
Received-SPF: permerror client-ip=2a01:111:f403:2412::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 10:55:35AM -0700, Isaku Yamahata wrote:
> On Wed, Mar 20, 2024 at 03:39:36AM -0500,
> Michael Roth <michael.roth@amd.com> wrote:
> 
> > From: Brijesh Singh <brijesh.singh@amd.com>
> > 
> > A recent version of OVMF expanded the reset vector GUID list to add
> > SEV-specific metadata GUID. The SEV metadata describes the reserved
> > memory regions such as the secrets and CPUID page used during the SEV-SNP
> > guest launch.
> > 
> > The pc_system_get_ovmf_sev_metadata_ptr() is used to retieve the SEV
> > metadata pointer from the OVMF GUID list.
> > 
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  hw/i386/pc_sysfw_ovmf.c | 33 +++++++++++++++++++++++++++++++++
> >  include/hw/i386/pc.h    | 26 ++++++++++++++++++++++++++
> >  2 files changed, 59 insertions(+)
> > 
> > diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
> > index 07a4c267fa..32efa34614 100644
> > --- a/hw/i386/pc_sysfw_ovmf.c
> > +++ b/hw/i386/pc_sysfw_ovmf.c
> > @@ -35,6 +35,31 @@ static const int bytes_after_table_footer = 32;
> >  static bool ovmf_flash_parsed;
> >  static uint8_t *ovmf_table;
> >  static int ovmf_table_len;
> > +static OvmfSevMetadata *ovmf_sev_metadata_table;
> > +
> > +#define OVMF_SEV_META_DATA_GUID "dc886566-984a-4798-A75e-5585a7bf67cc"
> > +typedef struct __attribute__((__packed__)) OvmfSevMetadataOffset {
> > +    uint32_t offset;
> > +} OvmfSevMetadataOffset;
> > +
> > +static void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
> > +{
> > +    OvmfSevMetadata     *metadata;
> > +    OvmfSevMetadataOffset  *data;
> > +
> > +    if (!pc_system_ovmf_table_find(OVMF_SEV_META_DATA_GUID, (uint8_t **)&data,
> > +                                   NULL)) {
> > +        return;
> > +    }
> > +
> > +    metadata = (OvmfSevMetadata *)(flash_ptr + flash_size - data->offset);
> > +    if (memcmp(metadata->signature, "ASEV", 4) != 0) {
> > +        return;
> > +    }
> > +
> > +    ovmf_sev_metadata_table = g_malloc(metadata->len);
> > +    memcpy(ovmf_sev_metadata_table, metadata, metadata->len);
> > +}
> >  
> >  void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
> >  {
> > @@ -90,6 +115,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
> >       */
> >      memcpy(ovmf_table, ptr - tot_len, tot_len);
> >      ovmf_table += tot_len;
> > +
> > +    /* Copy the SEV metadata table (if exist) */
> > +    pc_system_parse_sev_metadata(flash_ptr, flash_size);
> >  }
> 
> Can we move this call to x86_firmware_configure() @ pc_sysfw.c, and move sev
> specific bits to somewhere to sev specific file?  We don't have to parse sev
> metadata for non-SEV case, right?
> 
> We don't have to touch common ovmf file. It also will be consistent with tdx
> case.  TDX patch series adds tdx_parse_tdvf() to x86_firmware_configure().

Yep, makes sense to handle it similarly for SNP.

Thanks,

Mike

> 
> thanks,
> 
> >  
> >  /**
> > @@ -159,3 +187,8 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
> >      }
> >      return false;
> >  }
> > +
> > +OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void)
> > +{
> > +    return ovmf_sev_metadata_table;
> > +}
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index fb1d4106e5..df9a61540d 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -163,6 +163,32 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
> >  #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
> >  #define PCI_HOST_PROP_SMM_RANGES       "smm-ranges"
> >  
> > +typedef enum {
> > +    SEV_DESC_TYPE_UNDEF,
> > +    /* The section contains the region that must be validated by the VMM. */
> > +    SEV_DESC_TYPE_SNP_SEC_MEM,
> > +    /* The section contains the SNP secrets page */
> > +    SEV_DESC_TYPE_SNP_SECRETS,
> > +    /* The section contains address that can be used as a CPUID page */
> > +    SEV_DESC_TYPE_CPUID,
> > +
> > +} ovmf_sev_metadata_desc_type;
> > +
> > +typedef struct __attribute__((__packed__)) OvmfSevMetadataDesc {
> > +    uint32_t base;
> > +    uint32_t len;
> > +    ovmf_sev_metadata_desc_type type;
> > +} OvmfSevMetadataDesc;
> > +
> > +typedef struct __attribute__((__packed__)) OvmfSevMetadata {
> > +    uint8_t signature[4];
> > +    uint32_t len;
> > +    uint32_t version;
> > +    uint32_t num_desc;
> > +    OvmfSevMetadataDesc descs[];
> > +} OvmfSevMetadata;
> > +
> > +OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void);
> >  
> >  void pc_pci_as_mapping_init(MemoryRegion *system_memory,
> >                              MemoryRegion *pci_address_space);
> > -- 
> > 2.25.1
> > 
> > 
> 
> -- 
> Isaku Yamahata <isaku.yamahata@intel.com>

