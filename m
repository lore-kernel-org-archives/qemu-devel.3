Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA39CCFA05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbt4-00043q-SF; Wed, 05 Nov 2025 06:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGbt2-0003zy-Me; Wed, 05 Nov 2025 06:41:12 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGbsy-00022C-70; Wed, 05 Nov 2025 06:41:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQmBsRYKdar6UeuMiO5hy8KeX1Q+gZC53tlkF4dvodU0To2zzSCRIKkoVynQh73VftLI8TVE/O4/IHSej/Prc/oC0MQljegopVCE7oR3vAxAccBljk/juG4MC4zEKqgqeeMCmltSzDQsfxnuVlG0fmsTpyaovZamXiZSHUS5YfCePd9rREol+d0fu8dkBgP1eKfd4BX/IbpvWWrUE6TnZkxRxMsvtkODV7jAr/ubRMjoX9WVnIfE9ovRtcLx5yJMXn5R5Y9ilaus9OeG0ScWvHskBGxo3HWJ4aQyVI5wGmUIFW1lmalMfwHyZX3f2ofkcJJJNQZWF/UITCXESnTXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDJH8BKA6eg20er49vkabHWAQg6e/lVJ2B/8DvlX9Rw=;
 b=MkptGugSQm3DZoGc2iJv2LG7anuixfPNoVi6ugu5eEGkRhZRFEERI3hnfoQ9g/T/bNlT6TV7NascZUVwit2GzeatCr7XFJYisgCU/brcO9Zj7wOtW6GsPqfhSgd4PHvGLP8SJGGi/RiWItFPGXhXMF0E69Mva+3rHVnDfi/NoZAeSmd8Iu9vpaGeA+Q/ENJpfNI7iTzFSCXYGoN/IrLg7lNZQCLyZ/04GagrrxUhISof+NDyXYntelq4l5zSevrqEgPbD9MuJfUCAojQShpEMcXZF1GpaWjwsU2vdPv4HyWYDHj2hwVFN2kG65Q0DpJg6xQ3eraobMrxsoOe6Y59Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDJH8BKA6eg20er49vkabHWAQg6e/lVJ2B/8DvlX9Rw=;
 b=svqyBkFWvfXR6VpfE3vStpz3OXTIli3FsDMVyCpzkmyb6Gs10BQXTQu9B9f+mc02JOlL/D5RxGXLlWI7jL5fjgQLQxhmZK5ugnuIkDeV03AuCy67F0ghtjafz9VSuxxZH6ms396Ee9Yu7An2r5fYbX6taG33mCf0t3KrXI4YfugWpjfWmeiJjquo8mdyNEuR7TiCyexwRT+rzG7GMkn8wQ3fPsGwOphl7WaJe3cvy3P1zfRUE+dTSx+lMREH5E3T73B5+jegSBUuzKWKbO3ZZ9RJCXYQaNj+GCzX7QRSkufjXMAZa/q5x97LN0A+VQaHTD0WErDgfMy9N0fCkv0ejw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 11:41:01 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 11:41:01 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTik/BQgAAD6QCAAAbV8IABKlWAgAArhdA=
Date: Wed, 5 Nov 2025 11:41:01 +0000
Message-ID: <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
In-Reply-To: <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN2PR12MB4423:EE_
x-ms-office365-filtering-correlation-id: 281e1946-b7ad-49e7-1f44-08de1c60320c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Qm9vNnVPVWlCYjU4ZHdlSisvWkZtb3FTNzl5OTJjWHdWUXpyUTExay9MTVRC?=
 =?utf-8?B?WU95SHoyc3dXMkZ2T2VIVG0rUEhwdmhEVkx0WVgydEE0NURwTWVNN0FJbjlt?=
 =?utf-8?B?R3NUclNxVThkQlpYVkZ1dDVCZVkvM3ZCQkhwYWtkbEdSRUowMjdyM2JUVWll?=
 =?utf-8?B?N1pXQm1FT0RvVlBvU1IvaUpoOHdwVDBBR3EvZXVwQnlUeHg2ZDlHcUVya1BC?=
 =?utf-8?B?OXBaUzNyM3BLUUtpblc0Wm9VVW1nUEdGWmkwSkRZKzM2YXpTS0I3bExqSmdX?=
 =?utf-8?B?N2ozM0h5MlF4RXpTNHB0RDduQUtyeTJta3dQRzBUSG1KRU93b2ZhZnZScG9P?=
 =?utf-8?B?L29nT1Q3NFR3MENFVjJxU2xFOWlpZG84eVJ3MTdRc0RuZVplYzJVbXVyMzFC?=
 =?utf-8?B?MndCUUxaUi95Q3Q3eVdPWTdXd1NqOHhrdk9ZV29YcjEyYXY5c1dlWUFOcHV2?=
 =?utf-8?B?TVRqUndFK3dZWFlSN3ZUaWZGS3dmQXVmTDRCL0NxeWxDL1djRzZFenNBOGFZ?=
 =?utf-8?B?U29ISUdsU1hFekk5QVlIbXJESzdXbzhtM3pQSzEvcFJrUHJNN1BRanpVTU41?=
 =?utf-8?B?Z09nM2t6YkZVREQ3OWFjSUlWdGhmbnFDdkVmZk9rK1prd1RobXBHOG02bVVn?=
 =?utf-8?B?d1JjZkVMWFNtbHIyUlE4ZHdCZmJKS1JiTHVyZ2gzN0RLT25Nc05NNytXRXdL?=
 =?utf-8?B?QVlZc240WUVQSitHZDNCVWRQWU9zZ3JIVFRLQnJrZGdJMzg4cGtKNG5lOGR1?=
 =?utf-8?B?Q0NSVGIvOUQ3aUdwMEpsNDB1UVE4Ui9YOEU2OWw2TDZmVk1vcHZnQ2tRakk5?=
 =?utf-8?B?VG9WRHlVYlk5dmprTzNOYzlZZWRURmZWbWhHZGxOMW0vbkkyeE1BMHVPR2Mr?=
 =?utf-8?B?OWlIYitqUHg0a2h2QjZUTk5OR3dUUXhZU2RlRlg5VmszaDhKbHk2anZxbGJr?=
 =?utf-8?B?Z1AwME1JMlh3b2ltT0hGSGQ2MU5pUGFZYkZYV2FTRXg2S1NmOWFCNlJhdFpn?=
 =?utf-8?B?eUdjMHVCRVpvaWJhRHpBL05jaGlBUGZNd1VGZGNUcmJGYXo2T01ZT3p3TUNN?=
 =?utf-8?B?VkdPTkhhUU1EUWxFNG1mRENPVXRmbUZJVnpING5BMDVaY2lTa3MrZzRhQzBO?=
 =?utf-8?B?eWxLWWNES3d5cVorNW5vZUk5SWRvc1dLMFBPd2xXQWhtc3h4V2hkRUs1YzBR?=
 =?utf-8?B?bGN5UEE4VCsrNXdxQmt2RTNrY0FKcEdoaW8zR0xKVkdWaFIwRUZVY3MvbWNF?=
 =?utf-8?B?SGpFOTVuZnhiSnJHQTd4VEdzTzdSSEtyTytKRXV4RUlVUUhDZXVMU2EwWE5r?=
 =?utf-8?B?eUgwZUx3V253YjJPdU1TNXpqRzJuYjdRZmF6UkpQS0VCWVN2MEdQdHBBcnB4?=
 =?utf-8?B?ZUo5Rjl3a0cvK3dPTW5lYy95cWtRYXNvMXRjN1NrVk1GSEJIRVV5dExFUnZY?=
 =?utf-8?B?UmErMHdRajlnUWtJNEhqMUNHZndDZjdlUlBKZEpWY21NelF3NTJ3bUkrOXRO?=
 =?utf-8?B?cWtpZTREOWZ6T0RKZnIzUUFacnVYZ1VOc0lvU0Q1RWhZS2xwYTJ4UXVPZDFw?=
 =?utf-8?B?ZlRpTUxvamtqZUsvN0Uydk40cVJwd0RDTEJwYUxXR295UVlIQ3hYR1FPWDFa?=
 =?utf-8?B?T1ZBaWpEUmpwM1UyUUxVOUxUMTVwcnRHL2xpQWZhWG91R2t5eHltOUpYSyt4?=
 =?utf-8?B?NjR1SUdXVXM4ckw3NkZUMHQzMmhnaWdub3hzV0F1UnJPQ2VxUlVWbjg4b1dS?=
 =?utf-8?B?YTFKT3d5SEJ4MUlEcXIzbnJPcDlPWlhWMGNiZU55UThMa1ZJSEJUVjk0RjN3?=
 =?utf-8?B?UTdKUExKN0Y1R0FkL1BzSmtqdm5TZnlscGdIb3haTEVUTkt5dHJ4YWRLOHV2?=
 =?utf-8?B?NHN4Q0xYa1ptTzlJbExxNFZ1akRvNkg4eGRWbnNMQnZ0RjA0T0Z1TTNkZVAr?=
 =?utf-8?B?L0Nkd2JnSkFPNzc3eFlhSkJVS0JGNGZqcTROcmc4VENQam5yczZtQmJxL2lN?=
 =?utf-8?B?YVFOazRSa1VUaFJlV3J3Zk16RU4zY3BtQ0F5dzZMU3Q4VDgvN0FtNEhTai9W?=
 =?utf-8?Q?3sghdp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmJiVmhVZ21GRG5mdm9JSFZPMmhDMVE3WWx6eHQ5WmlXTno0bGM1eEUvV1lm?=
 =?utf-8?B?Y2VLSTMySHpCK3lFYkEzeUFxRDV0UFFoeUpsa3ZRSlNSTHJXVm1NMTYxUXpi?=
 =?utf-8?B?VFRQb2s3TktqT2FQVnZxUHFxQzJpNWVzTHUwaTF0YU1iWUFDUDBscDNUbGt2?=
 =?utf-8?B?MHlIZXBHbkc3QnpKaW02TmJmRk5lRmMvNE0yWWtBMnRXbnFxMWN2SkFYay9n?=
 =?utf-8?B?d3ltUkszNmZCZGNXVTNxSlI3ZzBoNVF6OUE3S1ZwSkhCRkg2TjdIV1JQR2Jx?=
 =?utf-8?B?cTVIeTNzakoxN0ltMldYd1IyaUUyS3cxQytHN3ZabkFXYkNUa3BhVWVTZGVm?=
 =?utf-8?B?OEd1L21BdlZjTmNpRlRrbWlNaGtLT0NDbHhiaTJ4UW5CaW9VSGMvMDRLQTZT?=
 =?utf-8?B?S1J0anZuUHYxaE5KRThzczB5V2poNUNjUlZoaWl4eXF5L1VhaHJMc0djRUhV?=
 =?utf-8?B?N3RtKzJoZTYrL1JGQWx1Q0JVNFVRcGdYZVpXaTlIN0M3SEc0Z3RGRGVKK2da?=
 =?utf-8?B?ZzZ5V001RnZ3UjJDc2hOM2JoN2U3WlU2QUxabWFTM21rOS82bXdwNzhETE1S?=
 =?utf-8?B?bnNXZE9Jc2EreVhMbEF4emlKMUhEK1I0SHVoQ1Vjblk2eHRzRXRNQXF6MHFh?=
 =?utf-8?B?VEw3OVJieXN0RXQxVTN4UGVucmhKdlpSZGdaK255TU9JK29HTmR5dDJrbEN3?=
 =?utf-8?B?OFdmRWUydmlhU2MwRld1UloyU2txZTQ0NkozUU00MWVNZEFSbDY3SWJ6Qkg4?=
 =?utf-8?B?V3VUMkxJU2c1REhwNnZscUE2YjJNK3NLNy9vWnMvVGlWN3lwemZ6NGFpbHlD?=
 =?utf-8?B?aUd4NUI2OXFla2xYYzZ4VytvWitYZGd3d2NEOThxR0VnM21xVE1Sc2pqSmk4?=
 =?utf-8?B?dnBzNStsV2JRc1RJM2ZHcWRQYjN5U1h4OUk4bnQ5dDI1YmM4V2FpeXUzVmZq?=
 =?utf-8?B?Z3ZLVkxNS3BxUmVibU9iRzNWbjh3YmY4bEVXZ3JLZU9pUFNya1phSnNpL0ZL?=
 =?utf-8?B?bUM1dEozMWxDM1BsSFNwSzY0VTQ1S0QvdnVBdVBUVjRaMlpQS0VnY0tLb1RL?=
 =?utf-8?B?UVlrSGJoMWxGS1YyUWgzNjBseU8wSllqdWdCbXNCS2RoSTVtVHhWaFlXdzZa?=
 =?utf-8?B?dmFZSisxeHJSQkc0b1Nyc3FCaHdXOTdpcExaR0NZYis4M2E2TDRVRytRUHdL?=
 =?utf-8?B?RjhjS2MxRmlyOFEvY2JKYnhFWlR3N2lCU0RmRUg1THFsWElJbXdrcVo2L25w?=
 =?utf-8?B?QUlLOEM5U20wbk9YUGRIZy94YWhTSFBFUGJyZXFKbTJtV0lQZ2xhTUJLL1l5?=
 =?utf-8?B?cGtMemU3RkkxQlM1c2VJZ29NWHBHcGZnWFRyWUpkQVJQVUp1TnVxMllYSk93?=
 =?utf-8?B?V1FjV3NmVEMyT3k1K2NJdHlJbXlDVTRuZWJuT3g3TzZueUgrZ1BHZmQxTGhn?=
 =?utf-8?B?Wmw4R0UyMC8valFiNHpvRU8zRldVSkpMcVBqZGQ3RGM1a3FUc0Z6RkppN0I5?=
 =?utf-8?B?dHgwVzY5OHd1dm5QNEdXYXpyUC91Wkx5MmVXL3hDZWMycWRrdS9EbFhOZkJm?=
 =?utf-8?B?TXUxTC9ORVBPV2tjQXI2V1h0TzhncU1HemZKUVBXbjk1ckJZclRNbWN2SE8r?=
 =?utf-8?B?RkVxV3NGQ0I1amlpUjMwY25tU1daaE9YK3pXaDgydlV4eWRqaGpHODRVbFVF?=
 =?utf-8?B?YURKVzJQazF2QlNpamJmRS9ZTGRLeTI5NkJvMHU2TnNqSG9CbXJYN0FET1d1?=
 =?utf-8?B?bG54RDVDZTV0V2k4a0gzcEk5Zitwb0QvdnAyTUhtdFVwVkd3MERyRXhFYzNG?=
 =?utf-8?B?cjdPWG9CZEJZZmRDcWxIS3hxQmM5V1hIK3AxeEhrbmpNeTBLVzYxaGZQVVp1?=
 =?utf-8?B?cnkwcW5pUXZpVFR3ejZEWmNYM3czRldYbXNpSUQxZVYvYTdBWlI3VURVQ0ZX?=
 =?utf-8?B?aDNYTHMvWWxNd3FTRGNZcXAzbHg1OHcxOVp4bjluNzV2bVhIQXRnS2x6NTVB?=
 =?utf-8?B?b0VId3U2TXpJL3JQd2VNMXVtUGlXYlBEYUR0Z3l1VWg5UytxZzdsYnUvTE5Z?=
 =?utf-8?B?UitKMTFENGl0YTdrTmZveHhIMExySHBta05HRzlyVVU1WGJyNG9UNnhycG1I?=
 =?utf-8?Q?EaX1iOUlsL2HkuIrHutm/ZhMg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281e1946-b7ad-49e7-1f44-08de1c60320c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 11:41:01.4663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZoBTvo8PzxFyvPUxtpdaygV7o4zz1OH2kp8rBG9QonNXj3ua2I602vNHILPjm2R0yllPmK42jXFuJ8MWbvLDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQpIaSBFcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVyaWMg
QXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gU2VudDogMDUgTm92ZW1iZXIgMjAyNSAw
ODo1Nw0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBx
ZW11LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBO
aWNvbGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207
IGJlcnJhbmdlQHJlZGhhdC5jb207DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+
OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3
YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRo
YW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpo
b25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IEtyaXNobmFrYW50IEph
anUgPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTUvMzJdIGh3
L3BjaS9wY2k6IEludHJvZHVjZSBvcHRpb25hbA0KPiBnZXRfbXNpX2FkZHJlc3Nfc3BhY2UoKSBj
YWxsYmFjaw0KWy4uLl0NCj4gPiBJSVVDLCB0aGUgcHJlcmVnX2xpc3RlbmVyIG1lY2hhbmlzbSBq
dXN0IGVuYWJsZXMgdXMgdG8gc2V0dXAgdGhlIHMyDQo+ID4gbWFwcGluZ3MuIEZvciBNU0ksIElu
IHlvdXIgdmVyc2lvbiwgSSBzZWUgdGhhdCBzbW11X2ZpbmRfYWRkX2FzKCkNCj4gPiBhbHdheXMg
cmV0dXJucyBJT01NVSBhcy4gSG93IGlzIHRoYXQgc3VwcG9zZWQgdG8gd29yayBpZiB0aGUgR3Vl
c3QNCj4gPiBoYXMgczEgYnlwYXNzIG1vZGUgU1RFIGZvciB0aGUgZGV2aWNlPw0KPiBpbiBrdm1f
YXJjaF9maXh1cF9tc2lfcm91dGUoKSwgYXMgd2UgaGF2ZSBhcyAhPSAmYWRkcmVzc19zcGFjZV9t
ZW1vcnkgaW4NCj4gbXkgY2FzZSwgd2UgcHJvY2VlZCB3aXRoIHRoZSBhY3R1YWwgdHJhbnNsYXRp
b24gZm9yIHRoZSBkb29yYmVsbCBnSU9WQQ0KPiB1c2luZyBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0
ZSgpLiBJICBndWVzcyBpZiB0aGUgUzEgaXMgaW4gYnlwYXNzIG1vZGUNCj4geW91IGdldCB0aGUg
ZmxhdCB0cmFuc2xhdGlvbiwgbm8/DQoNClllcywgSSBub3RlZCB0aGF0IGFuZCByZXBsaWVkIGFz
IHdlbGwuDQoNCkFnYWluLCBjb21pbmcgYmFjayB0byBrdm1fYXJjaF9maXh1cF9tc2lfcm91dGUo
KSwgSSBzZWUgdGhhdCB0aGlzIHdhcyBpbnRyb2R1Y2VkDQphcyBwYXJ0IG9mIHlvdXIgIiBBUk0g
U01NVXYzIEVtdWxhdGlvbiBTdXBwb3J0IiBoZXJlLA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8xNTIzNTE4Njg4LTI2Njc0LTEyLWdpdC1zZW5kLWVtYWlsLWVyaWMuYXVnZXJA
cmVkaGF0LmNvbS8NCg0KVGhlIFZGSU8gc3VwcG9ydCB3YXMgbm90IHRoZXJlIGF0IHRoYXQgdGlt
ZS4gSSBhbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCB3aHkNCndlIG5lZWQgdGhpcyBNU0kgdHJhbnNs
YXRpb24gZm9yIHZmaW8tcGNpIGluIHRoaXMgYWNjZWxlcmF0ZWQgY2FzZS4gTXkgdW5kZXJzdGFu
ZGluZw0Kd2FzIHRoYXQgdGhpcyBpcyB0byBzZXR1cCB0aGUgS1ZNIE1TSSByb3V0aW5ncyB2aWEg
S1ZNX1NFVF9HU0lfUk9VVElORyBpb2N0bC4NCg0KSXMgdGhhdCByaWdodD8NCg0KVGhhbmtzLA0K
U2hhbWVlcg0KDQoNCg0K

