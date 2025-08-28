Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440BAC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXS-00089K-Lx; Thu, 28 Aug 2025 07:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXQ-00087O-Nc
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXO-00056D-60
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:28 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S7WhbK2893431; Thu, 28 Aug 2025 04:11:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+B25GMUTHHEBM5QT7HQgM4UJYcL7SI8/Cf5f3sh7y
 F0=; b=trv8y9nNosCWAxlWV0QIE/rbXfw2havTt/+7oBC2GlhuX4v23gmtF11Gf
 sWkdr8lThoME8L++WdgKcCzPE1ciScgKi3r9RHTmoT0g3Gl/V7S96Hec8wYp+eIb
 umAf/APffGzCwgG4Fnst2nIEExuYc+Xej2+YV7MNJfv5rKg4AOtzdGoOaOE6Pgkk
 zYI6Zt9QKFBFlSsvYxqUWDCcFI9SwZm+wbE3fgTfy7fUMJVFelQCAD63prPyz/WE
 j+I9hU6PW4wbD0f9OZcCtfG7LVCaLrqwIMR49PrXyOzWGj5W40EIytqr91whguuI
 TnsDUDFbNcbBYWcbFWtbhXJFnKqYg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022080.outbound.protection.outlook.com [52.101.43.80])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48t7sy1pg1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTjTGZuj+e/9PRsYTwoV9/7l1KH1t4taZrsEpLB1LVPN9jBAAjVOzXQ9bVHu+/NmSucuRmyQFDrEVaQSeLIjG6m4vhJYxsfRFWndAqGdJbqeEnJYYV3ek5WmAGSyYvUhWkD17CRbF80mZ8VjZqkjCoC9VJZg4YO7PtcQnSuGYuOBfXLKn8fyXCvDp0VljCSt0DgIMNwxFubLG4iTEdHUXDto0xBEzddWOHG3W4AL4xeG1AL3xXjEtmQfsk6xfanvm5ME4FbYTie5qUmF042RfcNEwf54cltSi/Fb7Rfp+Nj5rB5NOI/wwOx6nVIXFv3aEoeSw+SpsFfG2ZLfObdFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B25GMUTHHEBM5QT7HQgM4UJYcL7SI8/Cf5f3sh7yF0=;
 b=AkVXHzeECvfkhvBy6KtWXMeFAC2zpm5Mb5fpTCLgKEe6cacs9aWpTn3vWOf8IE3LzQtD4ZbMqSm8Gpyt2B/mQdk1gRpbW/V+JP7/CVj/AbPK7lDX07oijbzr6ayYu+X+mmaPYkHr7z8Oohy7jJvnye0Il9YhKvbOXXvWF6Ys+3teMIrkBuCnqLcw6q1DlrSdvfSYPoeSRl0/jmuqvEt+2FEzeXHVR9WpTFkkPzwnTnCziogVyJ/WG4aA0tBrr2Eh2wKMYvqdSxnfNviCJrxb53x7OYBiGnJHGW1XkhLCej6kKuGnCO38nYjT0K+te48aGtkeVAZAgFnGTZg+9kU2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B25GMUTHHEBM5QT7HQgM4UJYcL7SI8/Cf5f3sh7yF0=;
 b=p0mqvV4uzEu3p8LwlbxXl+o77VZujqOQaxWbyxeGBtZMqH6JjocCdFqpcYKMWff6alUWN+ZJ37j1HU1Ou86hsxCdGzg+as5/XLiUvddL4rDuX7XEsdvBnUGrJNVj5o8AbprV5SYvFLTyJBjULw8doj7wFSyIFYEOd9aTAS3PqJE1IuONGExDbbJIdwpViv0F9RL4OQjnp3nawVyZVQ+dFyi8cpvCaRdr8j3RJeDXL0UowQ9cHCyR/O1ooTOzXiS6qDLDmrOA7aigbhWMRsOV72ANL4XeBuBQjdxxDQTaudmM9rCk397kRwXJ0KaoJevCsUufLme5/VhRUgrDmHUPkQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 06/19] hw/i386/pc_piix.c: remove pcmc->pci_enabled
 dependent initialisation from pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:49 +0100
Message-ID: <20250828111057.468712-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbe6300-f268-4212-64f1-08dde6239e65
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3RUSzY0RUJvaEJOQTcwQWR3KzQvZTRqSGs5RGpXeEh4Q0hhZFdWbDF5YTlV?=
 =?utf-8?B?Z0oybmZNeXNGWU9vVWJvYTZqU0Z5NnBtQ25ZQ3VQcnl5bkE3WnRLcTdVZmhh?=
 =?utf-8?B?VG5rcXI5N25pZTVJVksrU3NaMXZmNmNneURxRXhTWk5XM05qRXR5L01ybGIr?=
 =?utf-8?B?UWtqZnlVT1ZadndXajBiZ2VlYlc5eGlZL2V0SVphc1RYcjFMdGZaQjZENGYx?=
 =?utf-8?B?NHRDSmNSZjBwQ29taTdORlBtSHJxbFdVSDhEVG9oYmNIK3VGc0N6TzR3UlNz?=
 =?utf-8?B?L09NZFpmcTgrTjhPUnFNejVVN0crbkpxenlkbmRxRjF2Z3VyZWt3R1QzMngw?=
 =?utf-8?B?M21NRVRPWmRudVBlVXNkYkZkRExIM1huWjU5V2QrR2p5VnErZXlRcDY2QXZi?=
 =?utf-8?B?VXF4VWFjQjRPaXA2NVV4WDVVTG1qcEpaQVRabDZHazlHWEtOWGdzbTRzNnhm?=
 =?utf-8?B?QWN1MEo5eDh3TFBFSmFJOUZWaisyTUdWSkZFZ28zYThlMkVhL0NRalJpY3pt?=
 =?utf-8?B?dnorOWpiMVFldCtPaCsrZkQvYzhzSWQxRUFtcFdUMEtqbjlrTUZaUGVPNGRz?=
 =?utf-8?B?TUlSK25wNmd5S1poQmkyci96TUp1SHJZdWdaaE5IcFBlUzJhRVc5VU9aUVhI?=
 =?utf-8?B?SFZUdXhWeEtUQlUyb2JsWDZsVEdVenFnUFU2bzQrRHZTWlp4NlNrSnBBSkhB?=
 =?utf-8?B?ajZ0ZlFFUW5ITFBDNVp6d0pQWWxYMHRJTExTR0swd3VERVpxSStZRVY2V201?=
 =?utf-8?B?bnJMTzdmNlQ1bTBCOTRnK1M4aXlMR3ZGa1Q1YTdvdW00d1ZRaWo5TlU3VE1w?=
 =?utf-8?B?ZHhQcXJzS25jNWpOcnNZa0tQL2lWQXVVVHdTb2dIcnhmbVY0cFBmWHlKNTR6?=
 =?utf-8?B?eVJIYTArc2s5dHN0QUJWT0NkRHNaWlIrajZvcVVReUZjaGo1RkM3QjgzYWtk?=
 =?utf-8?B?TTZKQVpUcGhZdjJ2L0k3QUZDdDNyQzVVR2Z2VmcwYUhZcWhHZFNSNkZkRTd6?=
 =?utf-8?B?K3R2azZoTjNpeUVneFc0ZjZBVkxUSURQOFQwN1NJWkNEbHRKMXA4THFOQy91?=
 =?utf-8?B?ZzFHVjRHM0dpT2hMRFJYWWcyUEkxUktRMUpRZUM1bVQxR1l5aUw2bXFIclNj?=
 =?utf-8?B?Z1Z3WVRRNko3NXY3dEpscXJCUzM3S3pHdEtIamVQMzZ2dHV5QldMWEZFTUVs?=
 =?utf-8?B?SGJqMzNUNmdhRFVSVFIrWlFsNStNOXltQUkyWGkzSUhVTUU4b21wa3hXNUNU?=
 =?utf-8?B?aWdONUJVTjRuU0tqZko3R3lqNjJ6Rk5EVjkzNllIRFNFK0tnRVRWQUJjdDNo?=
 =?utf-8?B?cEJVM09VN3ltOWtRcm5ZWUdTR3V2WkR5c2ptYlBhL0xxd0pKZFNvMnJVLzNK?=
 =?utf-8?B?U3UwS2xCQzlnM0Zlb09ibFBpVy9jWHVMaGFVRU1IMkhRS05uYmtBWW9KeHJ1?=
 =?utf-8?B?UGxoaktMUDlIUytBNjFabnhTdnpMR0ZwWDlidlNBTmJtQTJqaEREdTNwUGoz?=
 =?utf-8?B?RGF5M21LNGYxVmpYaE45LzQ0ZXhLZExiRVoyQ1VFclI2d25MVmRIZHQ4eDVV?=
 =?utf-8?B?N1RVbHdiSU5CU3dzcGlnT0ZtTEdmTmpiaERHL1IwS1paS2JLVkNUUFk0YUVK?=
 =?utf-8?B?SWtIRzhJdUZVMzd0ay9kejJZaTRTWU5RNjZHYmp4TjFLQ1JiYnVkZmprL2hl?=
 =?utf-8?B?V3FpYmdvcUxsVEljeUJubG1FL3IyYnJiYVVMQVV4RXZmSGJVVVRjRnJVQ015?=
 =?utf-8?B?Rndhc2U3VXRHaEFXL3RUanE4Z2hTdjk1b09LN0ZNSkRpd0hUYTR0NjhTOTdI?=
 =?utf-8?B?eWpFZEk4UVNNMk0vcEVyK1BNMHVmOUVFSEh1YjcvNThPWlErbFIzMnc1cFdO?=
 =?utf-8?B?WUVrbllBekFWRTk2YjRjTC9BMzNsK1VjYm1vM0YwU3dhd2RXNHdlM2w4blkr?=
 =?utf-8?Q?D5XID+alI9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RyRnA5Tng4YTNLcVpWZGE2T0duTkJ1TWZSR2lqaDJIb3d5UnRvVDNSM3lq?=
 =?utf-8?B?c1k4ZzI2dGgrbEZXU1hoWWJzN254aTNRaEdqL3ZDU1dycUFnUm9ISTdLYzFX?=
 =?utf-8?B?VDNGRXByZlFjRk14ZnZKNVhtbzg4YU5MQWkzSVo4MldpQzZqdVRobUE0TG9l?=
 =?utf-8?B?NExDWUt5dUlNdGpMeHNyTkZGWVhYWTJHZ05heTBEcW1UMVljbGpvTjB4STlV?=
 =?utf-8?B?Y0ZXTnRYcGlEU3NlZkZVSWVXQ05aOS83dDNmdE1LclNxc3F4Q0dEZFB4R1A4?=
 =?utf-8?B?L1NueFpHKzNPRFExcnd0UHczNFR4cmVJcmtjcGt6Vyszblp1ajBCcHJQMW1I?=
 =?utf-8?B?STl0akZrckVVL1d2dHJYTGhRNzZtRm9KbXBmS2EwbWxOK0NialFSVlRHVGdG?=
 =?utf-8?B?dFE1ZDVnV054YitLdS9HT3QyQzVGS0J2dFBlQUdoZ3JrWExpaTUvbEJCWVZt?=
 =?utf-8?B?WXRCUFpHdFROWVJHUXpxMlpBLzBJSDJqeDVCd3RySHFTYXBDdFI4YkNpbFFN?=
 =?utf-8?B?aUpJeWNXdHZPbkpQWUlxWGxZUE5RR1FkK2d1SXRNT2REc2JMNWFLM3dHU2FY?=
 =?utf-8?B?K05CbjBYUmE1LzBFajd3TncxK1dwT1o1SzRwaXpuTlNXVXIrUGRxR2dTV3hn?=
 =?utf-8?B?elRZT1hNSTQrK3J4RUpIbTJiUGRzaGh4RkNiTldyZW5kY3NtWG1JTFh2b0p2?=
 =?utf-8?B?Vys0Sm50akdIaDEwQ3AyYU9lcUNoUjZON1pjOTJHeWlBT29WVlYvQjJWYnAy?=
 =?utf-8?B?R1lQN3RObEhHMWFZcS9rd0cwWlRYMEhSTHlqRDlTZVVEanh2Y1V0ZkFsZHRQ?=
 =?utf-8?B?TTNUUmJ1N2c0VUt4SStGRTFkalJaaVo5aFR1TUlFMW5iQUNYb0JlSGgwaGov?=
 =?utf-8?B?V0xQVGYwUXRJNkZMU1B5cmJLMStaM0pNVTRDRXpGbm5IZEtUYk5ySi9tT1Jx?=
 =?utf-8?B?YlZTMWgyVlE0SGFDaXRLajkvcUdzVS85Zi9oN21USnNkeFVqS3NwY2lTU3FJ?=
 =?utf-8?B?amNtR3N4aEwxS2NPbW9ZMTlCMnhwbEc1RzU3bVAzaWtVMFpCeUVqZDNKZGJ4?=
 =?utf-8?B?NXpNaWp3Uis4RnRyY0J3cGV0RUx5WnBKOC9abGJzbWkxWjd0T1Rjb01FQXEr?=
 =?utf-8?B?cCs3c3VONWVIQnB0SGx6U2ZVK2V2QldhWHRxTzRRdTAvRzEvK3RDVjFYNkk1?=
 =?utf-8?B?UnRRcEZodXVLQVE2Q29DOS9UcG8xVm1aREwzV0F1dTRQTUZoNFNaRWQyQ2RT?=
 =?utf-8?B?bjJkbUkyUXZiQmdFdTM4Qk1DbTZ0UXNldFBEUEhhTzllMjNqbUVOZzd3bGNP?=
 =?utf-8?B?M1J0RVh2NGo3MU4rMkF0TDFuMUYxQnF1eDB4RjFpR2ZPZUdzWmJKelZvVEtN?=
 =?utf-8?B?Ym56SnhpN0tLNC9BNE1zazcwbldrQ0tTb3V2N1hyWGU2bXhoQ0JudERSYVda?=
 =?utf-8?B?akNnS2p5NlZKK0xCNjZHQm9tUkpQVkt0VlIvU3djZDhZUmc5RVN3NGZreUdJ?=
 =?utf-8?B?aWhHeUd6VXZkUGZDQVJRN2pFczk0SUhuZTErV1ZsK29xaFZZeDNlRlF4TVIw?=
 =?utf-8?B?RkJmRnlxcjdBb3VxUzlYNWxnQmhjclc1eHZGRTZlaVZFb1JaeUdOYksxTlBu?=
 =?utf-8?B?WmxjMHBVTlpla1ZHWWlCMkh0UUJuSHRYV1FqR2FLWWpzM09KV09PeTJReHh3?=
 =?utf-8?B?RU5xOGFzWE1WRndXWjRVRDJTUUV3Y3llQURobVFxdk1CWVRpb1ZaTmN1ek1a?=
 =?utf-8?B?azlSbkJtcHJlQVpxLzl2dmxnbnNNVjNQUnlQNStXclQ4Z3ZCSXhtTCtrSkpP?=
 =?utf-8?B?Qy9TVEZudENIOU9TTndPOThWYUNGRHdUVHlvSnRMT3NnRkxiV3J4QWVYVlFW?=
 =?utf-8?B?VXpkZDVQUUhzOEFKMWhrT1MreFM0Mlhob09maXQxMGhmdEg1VlczU1UzTWFB?=
 =?utf-8?B?bEtOLzQ3Z21HeW1RbkVDeTByazB2TzNHNkx2RHlzVk1vN2RNSEJOL1hZR25m?=
 =?utf-8?B?U3pUaUoxZXNCL3FPRmlIRG1kc2dlVmdsb0dZVTM1OGhSdDRuYVR3Wm1DT3VU?=
 =?utf-8?B?Yjc0WkpDOFRrOWhZNTJ3Q2xueFpXb3lWaFRBNkZPYndRMmh1UlRaYUl6azI0?=
 =?utf-8?B?RUYyYldHVzBoZThUTTJoOVdPZ1ArV3YvTmYwdDlXVWpPUVUyZDU4MjZOd3JP?=
 =?utf-8?B?cnZIT0l1a2RMMlRRWFJQN2ttbzNzTGFOTFBpUzZIMFpWQXBwNTJGbXl0OGs5?=
 =?utf-8?B?NWFsbkI5NEVlMkhiUWhsbkVwRDh3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbe6300-f268-4212-64f1-08dde6239e65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:21.4068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zset4J2x/ED170J5IBQUC3JWmhVxFEtJoQjstdGXCLV7gKbJz36WZcchTX5U7p76CTal/kvzrXYbBdVRMMerQD3Ce8AIRdxzNKlYfd0lC8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX2nlchwPX0OmX
 TezGRUX0hxJ/kiQw2apiHJwaLoYdNGSlgVTaxNZtkfFh8AERAXL/hvxxEhZUdNaKHgHBI3AqM6S
 OUAMYqW3fr2U37BCjeDDrUYU0gNP9MjCNIaS0aH61vobo0x4TQRHIeHZI7PirFrHQC3BlqqrsiT
 Ct6jF9MpswwR7LSrTx8HHbj88q4cKfLxdzQJywvVtAnt7F8oRNlJUm2RNuKPdJuhGMDqcnC2/4I
 k82KnXWsre/Bkn8vuJoBdiFV298Hh5HIcpB+K1z0rPqFhNAVK7cwUdZKi0v+/AScanTV5olTzEN
 MzOs59K8k9A4H+Ik6rlK6MmKLO+BwLH1AOaF/Q9SH/oI1GYw4jd/JbWsUDcNMQ=
X-Proofpoint-GUID: CgzlKvj0KETOPOVL5uYTQx_N3JCRimWA
X-Authority-Analysis: v=2.4 cv=M/VNKzws c=1 sm=1 tr=0 ts=68b0395a cx=c_pps
 a=hSYwUsMu3dPAZ0NekjkltQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=hgPnCYdh90dhvLNmeTIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CgzlKvj0KETOPOVL5uYTQx_N3JCRimWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

PCI code will never be used for an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 120 ++++++----------------------------------------
 1 file changed, 15 insertions(+), 105 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 60bf18c680..f1b4468d0a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,19 +435,17 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    const char *pci_type = NULL;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
+    uint32_t irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
@@ -552,39 +550,6 @@ static void pc_init_isa(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
@@ -599,92 +564,37 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        uint32_t irq;
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                          &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                       &error_fatal);
-        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                   &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
-
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, NULL);
 
 #ifdef CONFIG_IDE_ISA
     if (!pcmc->pci_enabled) {
-- 
2.43.0


