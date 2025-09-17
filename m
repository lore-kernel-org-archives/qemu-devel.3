Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11783CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqgP-0000pu-Fm; Wed, 17 Sep 2025 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqb6-0002h3-D3; Wed, 17 Sep 2025 07:45:33 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyqb2-0001oY-Mg; Wed, 17 Sep 2025 07:45:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMttAjlCOih0MooXKoVOaGz1NRQzq8TG4oKWZU1UDE9brhYbFcrmXydD7vnqcQmcuSHWcCgCYXg3rrdT5vxDTMvz/il24UEDojLwpDUPn1dCF+qIn9PdPYiy7DXC0mgXpV7jWMTO/Sxw04SU8VrKsvvtdCOgAaYqINmh53+lCciI6JGUfagAmT0LPK8qh+4QpU6tWGO/6OnBTP+WAlBJy77lCHZHf7O+fZWsOE01/wJXeGxHHtX/SJWYnGdFwCWV6MKyiNPrdYRhJ76CeR3XiCzFHV17VxaYWueAjewaRAEj9DqEusyEiH7YUFcZomgmo6Rwz8foqi4l2y5gkcVKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZkQZlMCSrtalZnMLTWodkMBy2kNwprk7L1GCuCdUGI=;
 b=lkS1QR6ejeFYPg4CtVg4gu6y2LFIYB97dOFUBmzj7CWYzlfQnIkXci7qT3Mjj3L2IF1Xylty/y0G8XhGX771rM1V+WvLx2GMf29BPmFFldWjT5SpZwCk/kpolJQwGXpSLvs2LB7Q9xVj4mkII6TIBh2UnX8KEAaf4Ih+/1v94d4AeqiMm9aJOK4QgMTitY441mGNyJSCmuQ6DbTqSuS+wdqr9UM0A1PDTKNj7E/CiCMziL3grIOMmGoHcALmVfZOYZbn0GgL0se1YjJikfsWI4ruWiYj2pEoM+A9c0znqoOQ7MqAxQCmqYN//Eev+6fxUaFsO17zgzs9JnwRKs93TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZkQZlMCSrtalZnMLTWodkMBy2kNwprk7L1GCuCdUGI=;
 b=Szwtdq7FWr8W2bkk7ObHnfwivoVzi7ln2fJNTds5XDm394Ug362f2du6jabpkX02fnGTQ+9z+KQyeRTZYx8mQIWYDqpsajfvSIOx/hxTzmVC3mOWQMv0PDWjEpSLZmzMtwojztxuTmNPhIBl251AX7ZwyX+EXzVaKu+bSAq8aZM=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Wed, 17 Sep
 2025 11:45:04 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::c5) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 11:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 11:45:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 04:45:01 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 06:45:01 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 04:44:59 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>
Subject: [PATCH 0/7] Register API leaks fixes
Date: Wed, 17 Sep 2025 13:44:41 +0200
Message-ID: <20250917114450.175892-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: fc147924-8308-46d9-99ae-08ddf5dfa402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJY2wibL3Lhw3CFs2QHn36rD7xNpJAzDferM9El3mT0l+Mr0zWIo7mC2ucTG?=
 =?us-ascii?Q?wFqLTiS5XP2tjCoZdvazzxbtX/90EQXNSTMSCQCwSRLWfTgj00ZuP0oW7zjN?=
 =?us-ascii?Q?azCmuuMbASXdgx6+aF/oBhqsuNnw2ZMjNJSh1F5e6pafWlKxLHrwC3kZLcZJ?=
 =?us-ascii?Q?PMKo07vvUaxLr+A2YwrqQjn7/L0+FeuKHupMGJ2xTk9QnJG+HhxEWx6gKLe0?=
 =?us-ascii?Q?HyIT604nAHCzEPMjwdDyAqmJo+Io9UcyFnVAe1zRoIsBH49OY8ck5mXfg9LA?=
 =?us-ascii?Q?SNQ70GZia4w8V9rEV89FZ0jEQo6oX1OTwxKJf/Q/4deWD26fGPQqXC+JnL+R?=
 =?us-ascii?Q?tQMx9guEnJqFKr5TnmONqaRApbr3/1HXcyn0n6ZkYAmAsAKjqqB5lzxP6HIM?=
 =?us-ascii?Q?I4ICvk1mK0OpPLgbS0DlPpGZpwfj+z9dUaiSVJVZgJzhwRLk455DdpnPf5j5?=
 =?us-ascii?Q?Adtwge5sMtZyimS+fAGsM4NGFa4N8pXkw5XIAgGTHjheUgA9a9ikrqCezSbZ?=
 =?us-ascii?Q?BNYb6DdW6BntbK5G8nFZtTMm4A5LiLNQQKqzy9h9644n7QLEBQcaBHKv5Ycr?=
 =?us-ascii?Q?6D+2ALF0dCnJCQIIM9XQmM7wuAXlXz1gcQsE6L7geYlDZxB6LF3KrhJGd3/H?=
 =?us-ascii?Q?VyCUnIXFXSzbXuiuj+5rgHJv3v+TVK2Ap0ah2leDj9HeyQ1dEkq3L13GWmzL?=
 =?us-ascii?Q?hNmiB9aVLzINRmLMeOwJvYDKKmRu4Vr7h6Wri09y/TfeZuwb3RqbRonLpAaK?=
 =?us-ascii?Q?q3phRr2gIiSH697PIcpzJkTSecIhAPJgcih/c7NQkv23ePeeJ26tjhPm6M5H?=
 =?us-ascii?Q?4kil80JIksjdAwKrrnrdhsiYQKSRxrNHBVJ59f6MXNnmSxKtDObvXdfN120N?=
 =?us-ascii?Q?wYikCeizefWnvKgo+Y63bjxI0CnLqIaGNi86e0seHUB66Nbrwir3gRtSBYby?=
 =?us-ascii?Q?1xaa/qB+35AjWnDm+kgRSLAvSfRw2bOr/V0TdP40lQ/1w93BN064kiBnA1kx?=
 =?us-ascii?Q?Gr2M+UtRwwYJ11tnFTFjJuKPUcBpy2cWvqJ7qtgUaew5UBOikP6yJxsVr8FZ?=
 =?us-ascii?Q?0KswvoKg1AnX88i09j58DJq+AxHzDIjbrVmvVEY1wwLF8cwKsXWIRvN9+Fhx?=
 =?us-ascii?Q?jk+Bqbp+2ay7Ebk/QlLIopto0h4Hwc1jJbpOwPtZOXeQml64CHUCyY4ar4AM?=
 =?us-ascii?Q?WnD4Voh7rggubaT9YETFfLbE/8K3iItvKgOZcMFL8o4tar54I/60RPYLEkeH?=
 =?us-ascii?Q?GBFwToaS3W8vGaqXqzyWme5ONDu4HYBAJnsT/KvZSXNCXlkspo/pl7V//Fir?=
 =?us-ascii?Q?YQR8w8VDeOw6s64K0kUXmuH57f1dOcLZXVAipxk7Gz7idXSk9gqmip2zIKOI?=
 =?us-ascii?Q?uQyGMfcJIC7bsDls/wJvzRp/BWco/UySuu0cN6g9BIHcljHKI6oM7ovM6L5o?=
 =?us-ascii?Q?p8kFzZbMRDn9T727p2WRMf+h8rQ6rMwkvx/osGh4jnIcTEvfYA3RqzWzaUeO?=
 =?us-ascii?Q?STapa19cZUdOo0itx1y0IIWpJ+2vNSqKPn64?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:45:03.3282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc147924-8308-46d9-99ae-08ddf5dfa402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Luc.Michel@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Based-on: 20250912100059.103997-1-luc.michel@amd.com ([PATCH v5 00/47] AMD Versal Gen 2 support)

Hello,

This series addresses the memory leaks caused by the register API. The
first patches fix the API itself while the last ones take care of the
CANFD model.

The leaks in the register API were caused by:
   - the REGISTER device being initialized without being realized nor
     finalized. Those devices were not parented to anything and were
     not using the qdev API. So in the end I chose to drop the REGISTER
     object completely (patch 1).
   - Register API users not calling `register_finalize_block' on the
     RegisterInfoArray returned by `register_init_block'. Instead of
     fixing all the users, I chose to simplify the API by removing the
     need for this call. I turned the RegisterInfoArray struct into a QOM
     object and parented it to the device in `register_init_block'. This
     way it has its own finalize function that gets called when the
     parent device is finalized. This implies a small API change: the
     `register_finalize_block' function is removed (patch 2, 3, 4).

The CANFD model needed special care. It was rolling out its own version
of `register_init_block', including the discrepancies leading to the
memory leaks. This is because the register map of this device is
composed of main registers (from 0x0 to 0xec), followed by several banks
of multiple registers (Tx banks, filter banks, Txe banks, ...). The
register API is not suited for this kind of layout and the resulting
code to handle that is convoluted. However a simple decoding logic is
easily written for this, those registers having basically no side effect
upon access.

Patch 6 introduces this decoding logic for the banked registers, patch 7
removes the register API bits for those, keeping the one for the base
registers.

Note: this series is based on my Versal 2 series. It modifies the CRL
device during the register API refactoring. It can easily be rebased on
master if needed.

Thanks

Luc


Luc Michel (7):
  hw/core/register: remove the REGISTER device type
  hw/core/register: add the REGISTER_ARRAY type
  hw/core/register: remove the calls to `register_finalize_block'
  hw/core/register: remove the `register_finalize_block' function
  hw/net/can/xlnx-versal-canfd: remove unused include directives
  hw/net/can/xlnx-versal-canfd: refactor the banked registers logic
  hw/net/can/xlnx-versal-canfd: remove register API usage for banked
    regs

 include/hw/misc/xlnx-versal-crl.h      |   1 -
 include/hw/misc/xlnx-versal-xramc.h    |   1 -
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h |   1 -
 include/hw/misc/xlnx-zynqmp-crf.h      |   1 -
 include/hw/net/xlnx-versal-canfd.h     |   8 -
 include/hw/nvram/xlnx-bbram.h          |   1 -
 include/hw/register.h                  |  25 +-
 hw/core/register.c                     |  36 +-
 hw/misc/xlnx-versal-crl.c              |  38 +--
 hw/misc/xlnx-versal-trng.c             |   1 -
 hw/misc/xlnx-versal-xramc.c            |  12 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c         |  12 +-
 hw/misc/xlnx-zynqmp-crf.c              |  12 +-
 hw/net/can/xlnx-versal-canfd.c         | 434 +++++++++----------------
 hw/nvram/xlnx-bbram.c                  |  13 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c      |   1 -
 hw/nvram/xlnx-zynqmp-efuse.c           |   8 -
 17 files changed, 196 insertions(+), 409 deletions(-)

-- 
2.50.1


