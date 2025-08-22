Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4061CA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfB-0001g5-TA; Fri, 22 Aug 2025 08:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQf9-0001fL-Kv
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQf7-0000iF-JS
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:31 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7YANe668459; Fri, 22 Aug 2025 05:14:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9PhzxtRu0oEj7RLfe6zCAOyBXC5fSfW3FCO2c0/L4
 bU=; b=TFAYP1bumP8D3G+VcaRRA+Zh7vRNrJBScHATN6E6EQa5E4B9su/jFXRTn
 kVVuRw/oILV/tFyM1YonuaH9UgnVdtmVdqXNTsC6UvuIQn8AdbdHbBjrRvgN3TMa
 jFgvrCPvWBKnvU9x5w/v9Zxi8w5ciMq2zgqWHNgTXUcq3vwH6atZQveKA6QUzu7T
 vGBTEClBhFkW0eaRfOJ0Vy6E2XGwoOIic3aGqBz5CCysXJn4m2pkleuqUX3cqGP8
 YZ6ZzcuryC7R5IntnOmwviDqGS6MeJX3QLcUtSG9T+C54uHqLf5+cABFTBsme1b9
 cyZkSOwQDUfXIlDxIyE9DnxKUKOVA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye8qdwd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be4vDOPeDt7Danm7EqJ0pehDYRk2qkhlnxTcY7ZXTYL/vCbpu42JruVr7RHv17bi8oWzktIXdybVLKhSob2jmrTX85JO0lBm2nZiCcx81AEo5Wm0BLYNDcAKXw+u/6ebb9JgZtTrjgYrdMiQvU8JzSjzcUlxhmuV/DZQ4LbVIU8y5R8+nuDVxwyUYM4R8+/A+TeYydNPrm8thqpaGPMJIH/PJDXH8EZek5PFY8s2kkbQTo2aIzEzd7rbNbncEOH/Vph4SDhvydCoe3TqABQRUG1zIYXLrk4mz3ZUYrKSM1I7mZgqj72S0Ft0iwHYaM+T32HRkgJTjX2zIK9KFkWQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PhzxtRu0oEj7RLfe6zCAOyBXC5fSfW3FCO2c0/L4bU=;
 b=cn+zklnrovVSaPe+hLnLj15j7h1yte1iQDD6jndtyFNI+6PBZeONDaVbNK67ehizZ/DXzPqPL72fhaYj6puqDXQhOP+bU5yv6RGC2hkul8QeDX29UdTECjR8T/D7fT0jgSJ4Bp8wqP/1ui2cKIXp/M3C5Sb8uUqXWrXz0L8DmDKqyl5Kq0T7q9veyIChCoB1j5wk5nGHnLbed3bxKn7x4FoJcsCOOqlBfj0CwxBuqMaTTa/Yv189Ys0vmgYQsAHw0hlSdDDf2KgtPAGfDglPiMrJZD6IX3zIIYMKTJMWENwgOSBhJme8Ph0qRtEu0IUMSiJw9PcGNoYY79yTCtbq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PhzxtRu0oEj7RLfe6zCAOyBXC5fSfW3FCO2c0/L4bU=;
 b=yqJ6SkBcsYOV3NkAj21n2+rvbzxuaHAEEWPwf4nNj0/yHZ+tVG7qiJIJDuH5Wq65QH1kfRKjVP5IuM36oTcbTehF605NiuWXNg5YoJ6ikIrSFpA34fP+liIabHy5Qja7/91lnwK8LLylKUhpUPI7xs7IJ1K02PF1x2IvbMUK11ANL1+BHm4SabeXJ6hIzxqegywb229fJ07cRJITZlqrb2M5VAjLK7gsSYqLvHDXHoQmm7DkcPp07fUWfDfD/AiPlSrRop+fc8uo/mjxc7AG+dKO2mSbwAPBlbB5fmv6fDAj2JyNGkn5dCwge6DeL4OXe2CTN4Xh1jbQFnRcv4fJSA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 11/19] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:57 +0100
Message-ID: <20250822121342.894223-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd1c9ac-f717-4629-4d99-08dde1756efe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG5zWTNaSHdVRjYvby9CMjQ0RUhSRGZBQ1BDenV1bFdWYWNyOVFYd3dhU2Mv?=
 =?utf-8?B?ZGx3YlNFYVhRWHBKaWsycVNyek83eEJxZnJvRTY4RS9waHltZ1ZtbWh2eUQy?=
 =?utf-8?B?NDV2M1dZSmUwOEYxMVdIaVExdjVPYVlvRUJUZDVDaVpyUDM1RHlNMkF6TXZC?=
 =?utf-8?B?ZjVJMXlpenVVS3FtQ29ONUlhaGZsWnMrN3hvd3U3UTdoaWZYSWNmSjd0RHJL?=
 =?utf-8?B?ZVVueXFaREliN2Z4QjM3VVpnbFFKRXAzZ25uWk9Eb0dCQWhLMEdDQmRNWkJw?=
 =?utf-8?B?UzkrRzFTcExFcjhON2huc2pscmYvWkVEVnZPS1FiT2JRd2FtNnIwZVErNzFr?=
 =?utf-8?B?bk1ycUVxOHIzYzIrbzFNeWRPTEpybjFjOWJZUWpDWFBQMWJ1U3VFU0lYV1M5?=
 =?utf-8?B?L0tuSnRralBGZ3hlWEVxblJEZ3V0RE02djQwYUJXWDlCU204WnJNOERaVnV3?=
 =?utf-8?B?Q2FxTnJ2SFlwbUNSMmcwUmNKRThLeDBwV1R3blU3WlRKZWdQWTNmQWVJU1R5?=
 =?utf-8?B?TzhER085YXo3d2w4SG12UHNGVlU4TWI4a2FGUlRtWWU5bTBlYXlzNUp0UHJO?=
 =?utf-8?B?YWRlSm9HNnNRVm01SGpvcDcrV25QdjF6ZkhwSEN5bkRFMmZvOFByYk1IYzQv?=
 =?utf-8?B?NlVGdTZJR1pPVkhpKzJyRXh6Sk5BODQrNDJYWnk4eWg2blZ2aWlDS0VmS29s?=
 =?utf-8?B?WE5hSXdKRkRhMjNHd1RhY3FDeTRoNE1ZczMzQzJLUGEwSzNqN2pHNGo3UWVr?=
 =?utf-8?B?YTlkcU93SzN0SU9RU28rOUlGVHA5SFVrSXdFSzAwZ1ExdXdvZWVXUEd1NnR5?=
 =?utf-8?B?RzdKYkRsQ1R2MGJHN0x6WGVBOEtRRTg1VEFTRStKTUYwRWRyVlVoNDZOaHF5?=
 =?utf-8?B?MllvMVpETTFsRkZ6eXdjLzJQOUtlWmZwbDdRZXV1ck5pZXg3cmg5WVk5dk5T?=
 =?utf-8?B?YWpiUGV4UnR3dS9CMTB1TzY5QmgweVAvVmJyZGU5enNEeWczYnVSeFljYVVx?=
 =?utf-8?B?bmZST0MyUkg3NVd1ZnZ6Ujd3UldMT1diUkYrK3pVZm1Ed1oyL2llejM5ZUMr?=
 =?utf-8?B?MzlKdlJVa2pFYTJPdDJUVmJNWWZzT0g1bEsvWDg5YWg1U1JtVUhkN0p4ckpN?=
 =?utf-8?B?ejN0aXBlNklHUVB6b01wQnBsOUQwZDRhQ1QzV3J5NGdtMFloRjdLaGpMd1l3?=
 =?utf-8?B?ZUlzanNoL3RyUEpYOFEvMWNNSmhvSllkWnd4RUdQbyt0Z0hIVzh0VERHLzFC?=
 =?utf-8?B?UENJSGsrcVp2UTlCNGVBeW5UT0xjeUNMNDlhSG16UFBZUENTU1RKdWd2T3pJ?=
 =?utf-8?B?RVVsbjlSSVQzdFVpOU5LNG1PNlFyeExTOFp0cW11OVlvcHc1c1BqekJBSHRu?=
 =?utf-8?B?bERKRW5ZY2xLMU5BY1ZWNHk3R2xYTE8zenZybnpaVjJKUStacWNlQXlzQUlU?=
 =?utf-8?B?Tk5lUXBCa2pmT09OaWpqLzcwTzdCVDFvVTRkZ0d2U0x6WXRmRW0rZmg1Ulp5?=
 =?utf-8?B?ZFBKbmpnRFZYbTR4dzhzN3p3YnVSVURVcUFlSzh0RGVvSDFjM2lZb3VRdUdx?=
 =?utf-8?B?cXh1V1BUSG1wcHNKZVUzS2d3WWo2RUYwVDF1Y0lHZmN0ODBMVC9QSGdKR3RV?=
 =?utf-8?B?clpSQURsL05WQmdUaCtuYlpBMVRlU3VwUHJtQ3lBYmpGeTY2ZUNYd01sQnlI?=
 =?utf-8?B?VE1RZnEycFNVT2wvcXAzaUNVR2k0MXcrWVNIaHBBSVkvQ2t2L1RpQWgybWd4?=
 =?utf-8?B?YWVGMGlCWkF3NkdCdTZrekdMMUtlODBhWGNnaEp3aWgzNC9scWdrV2xJSnh1?=
 =?utf-8?B?QTJCekVQV202QnI4M3Z2cGhsdGVCSzYrcjA4ZzFBMkgvbXZGMmNjczdSQzlr?=
 =?utf-8?B?OXRiUjc3ZExsZWlnSFdzVDVsRUtaQVF1cUVnOU1BWEp6clJFTkdqS2wxaGZR?=
 =?utf-8?Q?bBs/Z8mWjbI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5BSHd0RVJsMFBsRVdyQWUyeXB2TDd4WHFMZWpDWjQvOTBBQWVDQkMyRVJH?=
 =?utf-8?B?ZXd4eUtIVmQ2M2lMZVdpdkQwWkZZMWFVYVJ4RWdISDhCOXZqaDhvZHVHWmtN?=
 =?utf-8?B?RDN0SlprUE9ON1ZZWnBaUUQyV1pucE9wb1RsU3Y3VWNTYTVaOWJ2NjJlR2RY?=
 =?utf-8?B?VXhzaWZ0cmdQVjZsNDNSQU44ME8yNERMOVZNWk50WjNiRlFZY2YxU0JPWVd5?=
 =?utf-8?B?V0FkNXVaOVg0RUltN2xQVTZYR1k0b3cvaURRQWJNWTdvS2JhTlpteXFLblly?=
 =?utf-8?B?ak5CYXlJRTJHNTFVY2IvUkVacDlnZmRXZy9COEp6MFZKYUh1WVpUN3lRRGpl?=
 =?utf-8?B?a3hpR3lCYUpLY01veis3bjZRWEduWnVDcmdvZ3ZtOElUZUtvdXJ0UDJrd0Y1?=
 =?utf-8?B?YmZ3eGhTWG1jTWNwWDZiekE1NDVqaGlmQUc4cmN3bkhKanhyQVFHYlVINXBu?=
 =?utf-8?B?WVVFY1RBNnJyamRVY1FWMmU0Z2lsM2xrQllRVEVudXpjZW9oYTV2enEwTzVz?=
 =?utf-8?B?VFl3dkUwdXF1eG93ZlhpOXRwTlVTSWp0N1VrRHdZUUV5R2pHQWhhVzNDQkh3?=
 =?utf-8?B?eFVyUXB6RFIvdXE2MGZ2SUVBYWppYk01dmcvWDJqbjY2d3BOQXp0OHNwYWIr?=
 =?utf-8?B?OWNYU0NsL3pjMUNBZG93TzQ1cFNmSk1MN2NGMXd3d0ZlOXFRMFQ0WHZ2YUZo?=
 =?utf-8?B?NjdRQks2Rk8vNi8vc1BEQjVJTEJTejlUYXNYT1BoaEZmRXNzdGdiR3pLT0tM?=
 =?utf-8?B?MGtQNTBQQ2pjZURFQUVmNXNhaGJCOVo2ZDZpTVhjdG1vNjYrVEtJMGtNdGU1?=
 =?utf-8?B?MktmUzZoOVNaV1kvMkU0N0puYWphWVpqYk5GeUM5OG91UnVJQVdMM2tCb0cr?=
 =?utf-8?B?VjFYZEtGZWRUM09vU2RTbDFYZUhwemRwWUM4SXR0WHJjMnJPN1JhbGFxbjJh?=
 =?utf-8?B?RXpDTStjajZLNmhNTnhsckc3cGlqd1pUWmdHWGRXVkpnVGZXZ0F5MWl5NHdO?=
 =?utf-8?B?Zlo4dkhSbi95SURmby9nOHJlMVN6THpCQTgwbHZIS21FQUxPUVBlZjlYSnhv?=
 =?utf-8?B?V1lnUmUvK3ByS0pZWXBKaGtJZU1IZ2JIdXg4eFFBeTZlYkU5WStrVHV2cWpK?=
 =?utf-8?B?NStyQ2c1dW9IOVk3TVA2dGJVZFJEVUc4b010L1cydGFOa0g3WTByUGxlYlhZ?=
 =?utf-8?B?T0hWRVNtZ1hTSFR4QmkrN0lLNnNmR3hlQURmWnhZTzRLZ3lnUWxkNTFNUDdZ?=
 =?utf-8?B?QlBDZ2VrdVVlOGE3M09aejlSRTA4K2lXZUJNTEdOU2tiV0hGS1NmY3ZLbnFt?=
 =?utf-8?B?cGE4YnRQVXlBelIrYmVUL0hSSUNiZUMzNFRxQkpDdXZqY24zZG1GS2xvL2FJ?=
 =?utf-8?B?RUdoZFNyVDI1R2RMYVdGN1VhS3p2K2NJdEljM1ltY0pwTXFvcGpEcjh5K3k1?=
 =?utf-8?B?ZzVIUkQ0U2dudEU5S3NubG8wZXM5Y3RUell3REQyYkoxYkFkbzlLMmVJc1VS?=
 =?utf-8?B?OExlckRQb01XY1pXc1I0M0NpU0xneENOeVY3eXFlUEZjRnl3T1JvQ3B4cWo4?=
 =?utf-8?B?THVmUGJNV2hJTVpoKzhNUjNMbVZkL1BwbllVeHR3TnFGZkxoSGxEV05zMzV1?=
 =?utf-8?B?djZYd0txa0VEcit6NE1oTGkrMGthTVR5cG9Eb1BlbE5hTVFRVDRNNjd3akZ5?=
 =?utf-8?B?L2pjSFZsYjA5QkRIdXU4cjNBS2VTZzhqSVdYZ0JvY1NEZDNyOFFLcTFKZHlq?=
 =?utf-8?B?bnZiSGVneW1IQkVWeU01SGUrb2EwVENyWWluaVpBWmM3U2dxenpDRkRGbFho?=
 =?utf-8?B?UUZ0bTdsRE1udWk2MEt2ZVdEN2tDUXdVeTBLNFVqNEJ5Qm1pUG9NVG1GdExq?=
 =?utf-8?B?Ymw5V29VSVdwK2h6QmZERU5ORDNtK3JHYlJVVWhsTEs1c0VhR2Z0N2ptK2du?=
 =?utf-8?B?aFJqYk1sUzh0azd5aitveTRZK1FFVWxZaktCSTE5Y1F6RSs1K1JKZUJtbjVZ?=
 =?utf-8?B?U0dtbHgxeTBEWDJ2WVJQWWd3bk10YnpWcFV1eEUwdDNuejhsWXNVWDZBLzVt?=
 =?utf-8?B?ZlN1UmVLdVA1bFNlUlV1VkM1K1JyOExDMDgwZHNCTEgyU3g5R3YzMHk3LzJP?=
 =?utf-8?B?UVlSb01iNEcxb0hqOFZwbC9lSGtvdlJjRFJoUXhMaGJLbTRTMkVjVStNQmFr?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd1c9ac-f717-4629-4d99-08dde1756efe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:24.7341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjnTIMslyx38Tie1BwNK7M5oJ1RvMNSl8UpFt0p/DdwsFhKUpqA/iMl19bZiey016qNwnfRfBfJtaY2wJHWXWuTtqBgcKDJd7g+ouotDBEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX41mIRRiIh7Et
 eBPIzsTZ6ySMe3DXBiJ26znV8w/fkH+i2LVsWh2SbGVCsHO6Sdr4Cu+W58hMd5ufZ81bRk8COvE
 IPc9jRhcmV3yAFjO7qA9D61u+ttlwdWe00AhYj42o91lZhbGSx9HhgLI6BGb6w66OcErE4KKuqb
 3CuKk6Woj4ScBeTFq77xWscpOOSQaPR/Ws6zNeFz1ajHgEyUZyr2HcI5foGnrhk1w/PqJI+qX1v
 3qiHEY8nWIzyjzKc1CeN6mb75JgunVy7Eym+2Z31Yn51pEzEqVZvd8drQJ/A23mb93ENseFCrMW
 rAWDBP3mq1dyU26KqXruGwIWvtOTnfTTFHOrh6GeWLbqdUbiRwlOc0HnBtwqlLS9nnQpHgn5APM
 mijywoPCndIiCnfP8ovKgUm0wrdaaw==
X-Proofpoint-GUID: uAj6Izd2e4HXSEug6CfkDpVv1cNBWIAt
X-Proofpoint-ORIG-GUID: uAj6Izd2e4HXSEug6CfkDpVv1cNBWIAt
X-Authority-Analysis: v=2.4 cv=A7Y1/6WG c=1 sm=1 tr=0 ts=68a85f22 cx=c_pps
 a=SfKpAED18FmY9QLmYdbp3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=_jvWDQGc8cL8bECqUo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
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

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7c9f4b78b0..bbd5f9d17f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -484,7 +484,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.43.0


