Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E33C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh9C-00028k-Hp; Fri, 04 Jul 2025 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8C-0000tw-Fr
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh88-0004nO-Gs
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:11 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BVMZG009055;
 Fri, 4 Jul 2025 07:11:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=A0b/3vt0mwI+1nONBoXxMotx62P0BHSk+Vg8qHQR7
 LQ=; b=qIOrglv52HGxd56se/f1LunAxbIYijcS4Xz9MprYmKq23iv4mpPNhNcK7
 Vo+3zB3tc5d91LGRnhczWA6sta7+UEGHieOxGcnGHzFI9k6IqRFmanEmZwKXpWaF
 rkUyTiWgv6CruEEF7zx/H0zUfe7BzYGISFu60EFM2dmXbOf127maHmFeQOx7jBdb
 ImZLhqefRUChZtcqBW3ltB2O+Hxw+IqV/k+HZ44rnPGYqT6t+Wxdp6pLuNVp23Zk
 MmDQVWjlIr6knEyhS3eDo4phmByYDquhII24k7PULgT8nMf7IAALb9VEZkmHIND+
 4wwHC+aAy9r19MlA6LgK6mWTwUmmA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020122.outbound.protection.outlook.com [52.101.85.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47nqmnuesj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDXHW93xeY8DXIf3WeNJhO7Z+IRGaObRGTKGAwD0nF3Ph6OtTft+i9rA8CqYm9jrpByi0lgc9wF/HUPnIMHehPtobDNdBRghEKrrPUmCFdYbjyOtR+AjwIU3YZ+kynsNXZ6a2vrLjl2FUmNqHLxF69CddADzHVTHyT+LxTANxuBBBRRoDkM6saldie1rfk2SaUbafYZK5/8TERX9DHoMaV/GDzJ8iTw05UDzaQOYkS1Hp2HE9CRaOhuMVDd0qH9pjK0xDTNHlDnRbvbWpi81WqQZlZy2tB4oMcC5KyLx2LurI4EeypEO5qm0esRAdAMa3nHv59rDVsS5K9WwIr0pnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0b/3vt0mwI+1nONBoXxMotx62P0BHSk+Vg8qHQR7LQ=;
 b=nc7ZfoUDxM2wxxTT6ThKiokk0Ozm+3FKFeY8zPuJJFcwNtH7sH2nVe6vePk0gUnl3NNR8RSfvKviQnUQmFEAXegAu87O+Yu12X+c/IYqQayHlLFosfJXDEbm+8l3MRldnOMRmpCbh564xgS/k4Q/gyTN+8vvl4AFbJs3E32z4qpsotfFqZUfXHlGdLMPjNuYzcV81LjrE2IBYqi83Z9a8jm2tzr1EK1vk2j6Psa3zGD+y8DBfjmc1BSFmkMLTUO83WpNtaZGT5+6vM0VAFvq6aazKb1Stbjui43ssRMnX0LsaW1ebGnnv2nUDFhwy/sKb+/3xQI817KUQcDia36rDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0b/3vt0mwI+1nONBoXxMotx62P0BHSk+Vg8qHQR7LQ=;
 b=JUQhiI7PQCY5br8Ewao/xyKoEJiVooG80RiABAj3aThB9XGHMMX7QISSd6SmKDWb+NGBTSWeZuQKVp3yI0uLa8bnOiKDQqjdItbdltsfRC5Pr4g/11HU+B70HaoOqYzIhFUcXRkf3xWeNT1C1SYqakVKB0xtsk6M9cvHvq03UcHxjQ6xmdCkvYE6sE3s+JBhZrZJPQRdGrPR8pkUIUmbIu91LmQiI589cbdmSXSQhNrZeDzguCxaizxGWYev3l63++ESQyZ4DnKqfMLOp1FariMd1fVbl6bFpowkwwau/wWYv95BvSI21qlM6uaXZw7yGukdYNtRNF/vgvn2tOZC/w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:11:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:11:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 11/14] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:38 +0100
Message-ID: <20250704141018.674268-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb0e8e1-734f-4369-f3f5-08ddbb049b82
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3ZJTTVVemJhc3cxOTZMUGQwSmthcUlkeVBPY0p3NE8zU29aNjhMbHptOHJi?=
 =?utf-8?B?Zm1hRnNLT3VTUTdOTHFDdUFqZUtwbzg3Y212cnMxZzBhT3pNeFAvUld0eHNU?=
 =?utf-8?B?TE1WRHJURDdjaHVoa2ptend1ek11Kzl6amVzUyttMU9ySWoxSjRteWRmNFBC?=
 =?utf-8?B?WENJL2JlM240S29oL0I4T2tlTmtERDAwTXowSksxSXNrSjA5KzYvNm5xdEJS?=
 =?utf-8?B?K3NEbmFSZE9lMS9IaDRCN2ZGSGpLWWE0Skh5WVBpTnlvSzc1L2Y5bTJSNDBQ?=
 =?utf-8?B?OVBoQUVHSTBITXE3NHAyOUlSdUxkVzJDUGU2WHMyQmthM2MxUmo0dUJSUlN6?=
 =?utf-8?B?ZndqSGlqYWtLK29mSUtTV3R3SmZyejdhZFZQUGhmYWRVS0E2bEo2dlErR2Vz?=
 =?utf-8?B?Vm5EY3g3bnRWalpXZVg4bnY1WDh0RGxvcUxuMmFtYTVvRkN3RWw4b3Y2MU1G?=
 =?utf-8?B?NTJ2aW5paUpCOTRjSXFkYUpyNkZHcDFSTVdCN1EwSEJMbmYvTHRSbzNIUDRJ?=
 =?utf-8?B?Y2xvQzhRZ3pTSklLRlBPSExhODF1ZlV2dXgwZFFPL2FwbGE3R0kyZUNWRHhH?=
 =?utf-8?B?V2VyQkJ6c3lkV05JTzhDaXpsTytjMTNLeE9aaE9meldUeHFNNHYzZVpaRUgy?=
 =?utf-8?B?UHh2MEgwVlliMG56cUtOazh0TThSVmo4RVVuODR6OUlWRVh2UE9hcytqRlhn?=
 =?utf-8?B?SlFlL0Q0YUhmdldyek5VSmx3cDRRN0txdGNEMWRMZzkzOWRQWEpGZjlGUGFp?=
 =?utf-8?B?SVVrdURDdG10YzRscmtoSnh4cWJEZEV4ZVY4eWJlM2Z2V3RYaHVJWk1QNDdr?=
 =?utf-8?B?RjlEMHZFNmVoK2dtUlZaSmtHRmg3V3d0M0VaamVNTHQyYUlhZEtIS21udUdy?=
 =?utf-8?B?NmszNk9FM0I5N1o2Ni85T2RXSlVxVEIxQ1EyNm9vM0NLUEZRczZCZmRKUGhj?=
 =?utf-8?B?OFZaeTNXRXNQU0JobUEyV1FuL2lETGxBazNCb21oMW50ZzlLUXZncEY1di85?=
 =?utf-8?B?S0dOaWFSb2o4eWlQM3o3OVhrcjRMVFFoZXVXV1JHRnBURHI4enJTbE9yZGYx?=
 =?utf-8?B?ZVhKYTY4YjcrRzhDRmVTTmo2UWdPMjlkRGRsWG1UcCtFUGpVdyt4by9vSnln?=
 =?utf-8?B?STFRNTVsaDR2clJGVHpJT1QwVzZ0U25UMXI2dHZxY3RQTUkrQkVmK215OU8y?=
 =?utf-8?B?OUs1VVhHZ1N3RExHT1N2RktqYUFCb0pDT3NEL1oyTVkvN0JUSzBzbWgrdkl5?=
 =?utf-8?B?YTUxZkdYUzM0MTZ2QnJjY1JUOTJoeXBaRVFmangydG9TSTFZSEFncEp4NFFU?=
 =?utf-8?B?SUpXczFXRUZDSUZ4YWNoTm9yK0tHdThtQUxRTm02S3BuMnY1SkM0S2xTRHhu?=
 =?utf-8?B?YUpmVXdQU3AzQVlKNjF3TVA0eW1JUTVDUldvMXhZcDdod1ZKK3hhZUhWaEJX?=
 =?utf-8?B?VXJpdzdIWkd4dnhiZE9WMWd1R0JRK2pBOWxsUUNhcnNDRE5vbUFyWW56V01J?=
 =?utf-8?B?U0NOQmVkdWE5bE9hdkF6U09VQmNUM3NCRUg1alZmTzVqSzBlVFI3UiswazNJ?=
 =?utf-8?B?MnFMWVFVc1AxdlBDRmJycERpZXZzU05ZSFRxYTI0WjVVbGFSenZsYlprTi92?=
 =?utf-8?B?Q2ZtcU9pd2pRK3I2U1Y5WERZQk5ncUkzQzJ3T2p6YlV5MG13RHg0TWNrQm80?=
 =?utf-8?B?L1N5WE80cDRicUpDZlc1WFhIWEZWNzc2UEtJamFIbFpvd3BDdTJvZEpUa1Qx?=
 =?utf-8?B?RFNhS3ZzSFg2dC9LUlA5WFhlQjVGdXBIT1YzSytWOHdXMEp1aUZsUGZoTW41?=
 =?utf-8?B?cVNicFplN1B6VlF6SHVEaFBWUzJZdloycXN5aWdSRm44V2tUdXBPVDVPLzZj?=
 =?utf-8?B?TWtHdVMwUDFYZlhReUcvalAyREo1VGN6aXViMU5MOU9oeXozRmhjeFZpSWgw?=
 =?utf-8?Q?mpS0+G82weg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEp5VHNUOHV0VEdPbjY4Rm1hWHloNElTeXlIUWVSS0ZjRW9SM2N5Zm1oeWto?=
 =?utf-8?B?N2x0M1Yza0x3c3pSOVl2NFc2c2wyMng1dGhNa3dpaHBmcXg1bjVkZTVGNFFR?=
 =?utf-8?B?RGxrNG1wU01xbkFnOFhIbXhYcVVxZ3RWOWxjNWdFc0lFaXZvVjlvUFRFTnRE?=
 =?utf-8?B?SzFnOG9uQnM2a2pwZjg5K2FJSDJoOGpBRjh2bkI2cFFiZkNPQTZLaDdYYmVK?=
 =?utf-8?B?bWtFYk5Od1FuYUI4YUliK0U0ZTE4SjIzLzNCQkl4b2NTWWNmS09qZldTSVdk?=
 =?utf-8?B?VU5MUHd0R1ZXbktvVXVpbTNYYTBXeVJTSktMYWd1clo2VEhLYm5sWU96U0dq?=
 =?utf-8?B?QkVXYWxLd0x4aGp2UDBYTms3VXp5cm42NkJQQ09IaERxckN3RC9qc25ETjJB?=
 =?utf-8?B?OXk0ZUdSM0pTeUFCZkhTYnpIY2FETTZEWUJNZ1NwYURTUlMvRzN3QzYwSDFS?=
 =?utf-8?B?YStSWkVoankvUm5saXVsc1FWRk4vSitBWVR5cDdKTElwYVZLL3BrTGZJeTNU?=
 =?utf-8?B?R0dvRUlGaHl6UG96VmE5MmVjVGNnT2NQQVk2WVBYYXZLc2RnL2NKUUpEQ3Js?=
 =?utf-8?B?Qzlxa1pZMFZGcUo2dVNONWVaaTRsSnQ2OXNzZEdVMW1jNStlNTU1T0hpV2lk?=
 =?utf-8?B?QTlEcG9Nc1I3cVcxT2lwQmxBTlRCaWkwSWk4c3JYZy9EVkMvR0ZoRWxhenlr?=
 =?utf-8?B?YWZxNFhScFVSQzlkeW4rQTROVmNzVFpKd1BUZDRnUWVINjhuMVpOQzFoMW1r?=
 =?utf-8?B?b3l6WEZLWUIzakxZbU1aRU1CNG1tMzVUWVNKa2dVSVJuZm9oNkxwTURsZFly?=
 =?utf-8?B?aUVWL3NVWHBZcFo3Z2tZRnA1OUR0RWZsSmVSQndSSjNjSThhT1BMK1NnTFV3?=
 =?utf-8?B?ZnBoRHlQSWtMeDc1b3J5VGVUWUJINENWcE9wY0VGMWxyREtHWTNPTm92R0Yy?=
 =?utf-8?B?dHJTWWZyMFVOcEM4TklkcTd5RGxxRmVwOFgvQnorbWNRbkRnRHhjRWp2M2dn?=
 =?utf-8?B?bWRGUlVzZi9WUEw4Q0c4bjU2bGRZNm1OVDRTTlVwVE1kNUtjTmdwQTRBelgw?=
 =?utf-8?B?dXZiRWJPM0s0V1lUOVB2RzB5S0VkMkwydDlvbkk2U0NGam01ZzZRNU1NTVdJ?=
 =?utf-8?B?S0hXcTN6bVdTeFpMV1Y3MThFRnZ4TndIWnFEK1ArM01WVUx4amxyRWcrWTda?=
 =?utf-8?B?NE5HTFBPaHVkUDVnMXh1WHM3ODNkcEtqcHBXd0xWN2lIanlUMXJDRDhDSWZy?=
 =?utf-8?B?aVdpMi80MjdseFNzU1N5Smw4SUFwRndjcW5wYVlrT3pDckFpVmJxWnlvbWpU?=
 =?utf-8?B?WGYzZnBmaGhkMnNCS1MrSExVdWRsQUdRYUlXa0kxUE9JMjdxRjJNd3VoTGF1?=
 =?utf-8?B?NjNqNkJ3ejZ5OGtLMGd2MGo3U2FxWVFqT0ZWT2FYUG9mY1VtK2hVK2s3V0Vu?=
 =?utf-8?B?cFpseEVUU2RNd1dWY0NGSk1aRGVYbENDU2FncDNxSFBTdk1ZRVV4bmwyNFQ0?=
 =?utf-8?B?SXlpbEw0MCsvOTB6aHF1SFM5dENDKy84UnQ1VVU0MGtmRkppNG1Ecm14ZFBu?=
 =?utf-8?B?M0dURFB6NkJjanc4dkM4S0NuZjBMVmQ3Vm9sVXF5RHh6am1ZTVNDa2xJQVd5?=
 =?utf-8?B?bUp3RFB3OTU1TXdnZzFmK3pTTjZDZ0ZzazcyV0FSd3hsVWtVQjQzZ1RjSnd3?=
 =?utf-8?B?anRSdlRkRjl1WkY1T1hLSk5WSGtWV09qVEFxWHdnNWdoaE44WUQxWVpKU3BF?=
 =?utf-8?B?eS9neDVFTlA5YmdNWnpVSVVjYS9ScUNKdGJjbGZlY2FuM1J5OVdobjBuN2dq?=
 =?utf-8?B?YkRwSUh2NXFmazhPaVBPTGxSRDZDZ1dSZ2xUL2RPVlN5Um54ODBWS2ZrVjIw?=
 =?utf-8?B?VlFSZno0UGk4REgveWYyMStQQnQ1OTR3NlVlS0gyUmxSblVDYi96Nmc5WWhs?=
 =?utf-8?B?c1lzeFFHNGFBMUhOMXo2ODBHVjRDK0YyQ0crQjNzeTJYZ3ZRTHJlUWxqTjZI?=
 =?utf-8?B?S0tpV2F1STJqeGUvbnlMamg4WTRaNVRtTHhUOUM5MnNnZUcvZWpHYU1Odkdo?=
 =?utf-8?B?TTdFS3BiZHVsK0dwMFR2bjJGWDMyajRjVmxNelNuMjM0TFVzWHd6OUwyYWN4?=
 =?utf-8?B?QW5MenZLL05QWS9OWGVRWDdTSUZFLzV4UDIwRVBKOEprbXhUZmNCUUVvUFdP?=
 =?utf-8?B?MUJ2a2p5VFNWYWllc0tkMTU4MXBYdVpxWjM5Nm1hNzRBZElWb1pZQnlyNHlx?=
 =?utf-8?B?RWVha2g2M281WHY5WnkyRXpKVDlBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb0e8e1-734f-4369-f3f5-08ddbb049b82
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:11:02.0595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ardOPKdG8sLtcXP66zx+NpKXge/iA+fwQfPzXwl1aCK5iEb9E73Nht1ucP9qoVTWOJqJ8xpqLd2vWbqyGi4waywi59aDgg8Muv+fNQJNSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Proofpoint-ORIG-GUID: YG2piIxK5yZ9B6P229ivjogXK39eWxXn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfXy0M180n2WBWP
 nqi9wi9snjml7tMNsPDewl5kBcojTxOEWORdo4dmBgxr01WQW1oMnTGuKNXBbmRhl05uvFCrlj7
 sGwabeSRS1D255TNqcyEWsHlbNJjqmo7UX2Z+OArcjLXJJMs/qcZy16+ZzvqoDG1zX0i2yL7cd0
 6dzc1UoOip7+9Cj08Sslss1bOaumvFlvoNXqZ5OhYY2tvOx/W9hGurou4YPZatH6ushWzoXeCcW
 oKObWF+fe6GlYED7hW/HtxodaHtljt7ilrGMXVom9cbu9um2GkI0e/8Qo6dis+BMe05216Kmr5Z
 wiFI3/kEacBmr5ciYagQ/b6Y0Xihe3uSr3U9IEJEX2Fg91HmuoerIWd2mYJsDFUtCUvFpdhoIcr
 6Wa+eq9EHOerOAu/vAqA65fNzFWq2wknrO3giZ+Db8ueSnCDQDNP3ns36vNTzbMbDhXhBA71
X-Proofpoint-GUID: YG2piIxK5yZ9B6P229ivjogXK39eWxXn
X-Authority-Analysis: v=2.4 cv=aomyCTZV c=1 sm=1 tr=0 ts=6867e0f8 cx=c_pps
 a=Qdo7Ea4lwGWRD8/XiwST5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XqeNvJXGgvzUN9CD1PIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
set via pcmc->pci_enabled.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 571a8d1ca6..4e3fb17506 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -474,7 +474,7 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
     isa_bus = isa_bus_new(NULL, system_memory, system_io,
                             &error_abort);
@@ -495,7 +495,7 @@ static void pc_init_isa(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-- 
2.43.0


