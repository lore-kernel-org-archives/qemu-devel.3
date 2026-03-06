Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CE1F0182B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyU6G-0007N5-B4; Fri, 06 Mar 2026 07:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyU69-0007Lr-UD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:16:06 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyU66-0008PE-EZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:16:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZZ/sxas5nuHvXVA/uxqXekzao+IZWLMXoCxVvYkFZ+BtYfTHMyH7l0hapoVX9yOtHz4in98EfyE4zNZJvFjQuflCHjc1XsLd2meQ02cZpjOkWWeb5hlWopc8XUDcvJfPYviHMrhFlbb7XsciaqJNjXiQ2iCa1kgMYrDRgZZLnxU+MMONKRsyR8tx1rEXkP0MEP8UjyYJu6oe5f82As+S1rtRj6PW4BVLlQG5nYoXS9tb7TkjqOPip/vFKiwUcIuSk6k1ESY8ZKD6AfNJqCpnNTO2ABwi+LZ9mNt9Tx/E00jaul3rUXlIoIJ9KAbTdpyGqqsyDa4BChUnaBb5pxkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYqO0yqOp89fE2T95zN8iKcr1m/hDguVdSid0dDELWw=;
 b=JQK/0Tphnt+JHSlF12vUiVCLfihLMJAGwydKQ3FiFRMBpSkDFDtg7B4uXmTQ7I7gq0/q8vh1LiUAho3Wb+Ek06kdCRlljBGU1yTub4JdpdDK4rElY4mzUAsgVuWEdLnEX8k3BnWDxWHuQsneKtPU9ZaxICxkKnzWNMTT1NalEuMBvl0DcIUvIVKxnKTLhTzuhWkERcx1cfbhFWt80fOY3B1eYjM5wF9Bbve6EEvaNKX2drSRdoiJfBh9JQfYYrjkoX+EMqF3GBrYNWEq//Myh6vW/wvmFXzgWI2AWtgvqueRgIZ2eMoUvJ9t6vAPzNsiLzACDZKtThYSrH17SPezyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYqO0yqOp89fE2T95zN8iKcr1m/hDguVdSid0dDELWw=;
 b=siETfB7lLTYWgeukCTisF2Wy02DG+WUPF7/nV9/CPDOKqNRJtz5p+QTf/N4MyFyiUKkpDNeQW+sFh8ajWnL2tTFNCg2z6xhadGMBZDcy710lhuoEQO9lnEkdkbv1WiF6pDBiG4XnQspa0FtGsSM5+YN4EdUXTaPFz+1cuPZYh5joyEx4/1d5cU5VYH5DF88t6XwmDUeWpq1jVoL2BMfTFq8OOFZxBKhcK9aH2S0mhwG7dZrLDvVaaI65Y2fztWr/JHEGW9V5gn6JMscDP32Z44spgl/z4oemdYw5C6BT5anVrllgKXCAYDX71KhKI5gdlJW4PnCsekze1RWbkBYMpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by IA2PR18MB5977.namprd18.prod.outlook.com (2603:10b6:208:4ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 12:15:26 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 12:15:26 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 0/2] Add Axiado SoC AX3000 and EVK board
Date: Fri,  6 Mar 2026 04:15:09 -0800
Message-Id: <20260306121511.1781020-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|IA2PR18MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: b352103b-3153-4b79-e155-08de7b7a0cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: v2MPoXa7DeXHO1NcRvRELIf9QRYWR+ggNn9YHaNmMHRi1H1nMX8C7s16LUsj+fiJItXsJ2lUiHknGR5wupvQbxjvmbII5f8t6n3crm3zmIIEBTov2Jf5u2ToKLPA7Pq+xZ9MqDTyO0tVmofP3q2MmOZtNVv4sIIjPm7uMrejzYJcxd7GoTEU8Jgy7CVkchq7+P9VxUas8teOzQoitdpH42SSeeuXaMHBcoqfXefhj7bYyPfwIIZXiALV31R2Za84s9Z4DwdH9eSlyutau21dmA0f6wWGSym/eHxp5kG60HAAsxQRZTrRiA8l2+ufr2LoUyEMLFJhJkCGzqRbdpkHa3TY2G2BgEt0ki0qB1dsiEsWZX/q143Kda7LZZMlUUzwJiC8GXzdo5nHGcbR8LuOrq5GzM/KMRwSPYHK2su9Ud/yRSrYv3lMaLEc2HiRogTgCiJRER28rdJAr7w1/+Gn60+BAyXnXKLWcWKbrfJL3DjwB0pVyfJdkqo0Pnm2wm2gkjNRgfljxnk60B8nYCsG0wEIFNDHASbc7I6ROuHGYK4neEqgv99B7hPbogWDMz0RFPCLBZOrHbgmKPQJe5qR5OWCWWlxGp6GROr9e0zFeNquo5F9gAOORd4mY3QMUrsVGDHJXyAuMxM7Tg0ucJheiuY09XMWwzz9fYZpdmDcSKxhPnsVIjX5oXTGEVzfiVO13G2hmda3MCxRHQx+Cgmxp/unbd9ESljUt+YPydl/gNzTNk0h1nvwN0k9KHipYuOEYzRQR7CibVhQOOqYBDb+7xrOqyFZvGtAJHkYAhR0yxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y//Y3iy7K2LdKGc0RHUqU3iIzSIrJPEZutunrv89QtFyFYC3kU80ZjFa2WoE?=
 =?us-ascii?Q?GT+spAnVpPwg0XRNWa52SqSKEAqzAeDLkaWomLz7eezzFJuKw5x8gEgRPqYm?=
 =?us-ascii?Q?d2cNJ5V6Ju/sn6TbYspDcKNiBqjYrcNaITrhRczfsF4K2nCDxBoN4fCl5McG?=
 =?us-ascii?Q?A12LO2utlrkg9LQS7xsVARzPWhYpT7bDDxUvZwLLWDTPa6TNzBY2OFZWvBc7?=
 =?us-ascii?Q?nZt8MVuKLUw7/lpGTu2yFE9GSPgjsw2dbKv+w/fqZjPjhqirGpUmKfVE14ZF?=
 =?us-ascii?Q?CZ8rSy9+E2i0UoqoAQY+cLl+OH1YEYvtxjXV3k/TG7XpSbJt4s7wHiliboP3?=
 =?us-ascii?Q?+wsZQE9bh5azsp+UVovo9bRmrMmMeauo8d6gqntukVMXnTejPHUMYVWPkfkj?=
 =?us-ascii?Q?+5iyZA5bt36jQRN6mWzpmQ7/44ZntvFTJo1EYBqwSabmFNRMweaewLWx6Bnt?=
 =?us-ascii?Q?ETPcSJva/eXeyH/nGjthzSmHDBMJ30x0nSSM9ijCz/sULdOVF1FN6b8ErgRT?=
 =?us-ascii?Q?dT2KfpvckxtWB2B2jastrjRJ/IY71pwM6ri+OTI0rrkd/Sq0K3L2EBQUSa/3?=
 =?us-ascii?Q?wbF22VVXdKKzIFxEGjQt1nOdl8MogcVBl6pgBnmPDHQYm/4PiSCOKmC0y++F?=
 =?us-ascii?Q?bnlTDk5MWHybaMsbf6c8egtuZ+QM3InEW4G4l92YMmflvXphIrYfxDpEpx5j?=
 =?us-ascii?Q?TCHrj2VgoyECdGNbxyQyqic5+LVmllQZhSAPttGyKsbHcbCR2qR10Bgbl1Dr?=
 =?us-ascii?Q?gbZ6bkRjrqCBqsQiYZS1izHskEHsM7zjCT54msjd0yrb9X9E6t3oj6qR5E61?=
 =?us-ascii?Q?2lXriG4RzgjA25IOL2Dy2toEfB6mNphJdosg9ery8/uqopoVlwTohhUrAvrZ?=
 =?us-ascii?Q?tuQvRNMrVGPjG6pQ1JjbhGuQmbMd68cc81EsrcnJ1+uqs/mLJ/EizD7CrE5V?=
 =?us-ascii?Q?ZCMriTVil81onfDvJrRfvuYfuhCfPIRoB0ZV2DaDCBOpeka0uoGOy7YiMy/8?=
 =?us-ascii?Q?6RjPB1Rbv5jiDCDBLowDs1h1afXIWuN92t4e27W/g/k7wtmpht3NVlQISnL9?=
 =?us-ascii?Q?PrCzi2nK/CGLwPJWv9cv5dMKpLc73ZXxqfpdx0hpxi787Iu0UZUZ4jqs8xIp?=
 =?us-ascii?Q?qKHkOq3f1Rd8SFW+6b6rox23zuwvTLQXPh0OaKxCgYHmfXCRxxFPTVsGlddO?=
 =?us-ascii?Q?ipN5vQmirBju4djGM3Trx5vtO8QDSBfKJdqLb9HUzrQxjqU938Pr0eYkQn/O?=
 =?us-ascii?Q?WX9TzJmvkzIe8sscE0kbkciqgz947TfYcXD6weQNFGjmgWc4pXScXi987/M0?=
 =?us-ascii?Q?Yv8+tgGz24PbwN0hmEw41ALjlnjq86060Ue17JbB6+qxJxBfhUAtB+IdCGZz?=
 =?us-ascii?Q?H9RFAOElzow4blr5XwwuZ0OyQ5alpJ4JwdlSgGP9p8HWjapNbe5hmVom/mgr?=
 =?us-ascii?Q?t9GmGUlyN/jySMuvvhmfHwx6zhJbVQt9hWQz8INAivfsHgsjzbD+zSzSMBTh?=
 =?us-ascii?Q?IkwR4DFSTplGFmBk3GxFBwECijMXzTObhG9D9FGUsEZodG7OEqGiJasLYePF?=
 =?us-ascii?Q?fXuEpf/SIVXyyDiTOze2yPo9rRmw+f+YpZRRiYsh3ecq3CdfTbYBGFwDIAvG?=
 =?us-ascii?Q?DD16ByxcoUunR5gVUZTLwb5gKWySt7qU9eDGEX3OK0Te6C/PUxb8MYQ0kNAy?=
 =?us-ascii?Q?EpJOghvXIzZrGEzqBJJd84szL5cXVKWxCUQHps9NctndcdeN54EmBpD4prO4?=
 =?us-ascii?Q?Fyr34nYIzg=3D=3D?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b352103b-3153-4b79-e155-08de7b7a0cbb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:15:26.4946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnE4XMjNeRsJsHvwnCV2Q7/jozPFo16ivQBRAeGuN1nsKT+YZW6E4GUBsuuQ8Z/0EkQ4w2HHMJt59Lm2XtEQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5977
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
The model for Axiado SoC AX3000 supports
  4 Cortex-A53 CPUs
  Arm Generic Interrupt Controller v3
  4 Cadence UARTs
  1 SDHCI controller with PHY

Verified the machine "axiado-scm3003" with following command

qemu-system-aarch64 \
    -m 4G \
    -machine axiado-scm3003 \
    -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
    -nographic \
    -serial null \
    -serial null \
    -serial null \
    -serial mon:stdio \
    -drive if=sd,file=obmc-phosphor-image-evk-axiado-github.wic,format=raw

Kuan-Jui Chiu (2):
  hw/arm: Add Axiado SoC AX3000
  hw/arm: Add Axiado EVK board

 hw/arm/Kconfig                 |   8 +
 hw/arm/axiado-boards.c         |  78 +++++++++
 hw/arm/axiado-evk.c            |  38 +++++
 hw/arm/axiado-soc.c            | 287 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build             |   4 +
 include/hw/arm/axiado-boards.h |  41 +++++
 include/hw/arm/axiado-soc.h    | 152 +++++++++++++++++
 7 files changed, 608 insertions(+)
 create mode 100644 hw/arm/axiado-boards.c
 create mode 100644 hw/arm/axiado-evk.c
 create mode 100644 hw/arm/axiado-soc.c
 create mode 100644 include/hw/arm/axiado-boards.h
 create mode 100644 include/hw/arm/axiado-soc.h

-- 
2.34.1


