Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A65C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 10:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOwge-00006f-1d; Tue, 10 Jun 2025 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOwgb-00006N-Ul
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:58:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOwgY-0002DW-Ky
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:58:33 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A4pXJ3004614;
 Tue, 10 Jun 2025 03:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sp5TbzocV7GSp5AghnAruDOIAxT3RktaaK0pgT9br
 gM=; b=V5y1fnQLqIx4Hu2a3msgWSkqIoeZeyI18ZPJBVnDCjNn7yX3gSNBCSZMS
 8+iQSuzCMDCcxiZyiYI4vhlX6JdQV9duWhJQTdX+dDeA75O+hrMU2XBxYbVhPkjj
 B6TPbF92HY2JnVFl6XzFj347/LXzjg8jd8sBmOUxCGLpFGIRRvoKUwdKLkc7lDpX
 DlJn3HdnGxlYNPpe1FxgfLL/UXZbNDf0o1+3ENofqY/K/3egNXhZYjHhlZQsG4e+
 fW1PNrSG0s0zGsPEZgWQlV7dQb80me0icfTRT78GtJ84453wCNDrRdJGU3VxWlbV
 0p/66Tq+BIWYEKQB/fZpmhjAREd5Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 476e1srrje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 03:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHnF7mKCRDuHWownBuIjC0XJO1LoCtPKpkFe6wNdoJnDCyFUf7oVmcFZ4tyeZ1jCUynu2Qt/LWRaklCG8s1ktix/B2dovnx9ro5GKSma8FiurvRs7Clle+HlUls0hLEYlxYD6qVdH2YaYOXDWebkoWG7/uLMzPYXqbfRd/xmQrqkPQnLT7zmf459VV2tT658NqXL3sFUFyi5H9odN5lLne5CjMIbhPpTYhLJOT6COJW6QGek0KtF6YwZ885ivL3mtdgYvjS2aBDI7Ob+apfSnbTZFais73kYZ7gexmwBN+OC7nvcg7juhC7eXHWbZRD39P4icgX/c4DTYQaXLh17TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp5TbzocV7GSp5AghnAruDOIAxT3RktaaK0pgT9brgM=;
 b=GueFZ5NAQtS83QUu6F2A12KK5DG72pNnP2J4y9Q3ziSL0773HLKP9XCt3WiU9BaH2Qp/lEcTiflLRD85HRF9+tLJQy7ZalmCGw4S41l5FpfLRRp/c5DRsThUIpAIoD/DSeLEMTri0vEykOn6hjjwbsr+z7r7kTy9NYhh2wiqNV1n95aaT0ZYrwThy9VbTD6We7gKQEhnfczIRxwjpJDqt5hIPWC/wSVyMp3drkTHGeZ+ISRw0MBfijJ18ym43FeypxIoqV68oNW3wa5P3x1uXV4dVTTzX+AY1d48gcJ4V5/di1m0718KOabgMwi/MCQjH2wTH2FYEKcwCOjpJhEVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp5TbzocV7GSp5AghnAruDOIAxT3RktaaK0pgT9brgM=;
 b=QfVRHkrtHrpG98RQuNxx51wk//ogUUHhe1y9inG2nVCcMP3EMx35L2n+GyjWcZU//qZYtke+befym3fP441hksUsEqi3J5NiSo8/VF+IioND0Rjl8m6Z4M24VPn2fR+pIYbI+ZfmgTKWKtxCQCPHoDk2UYx2vEK9lJM+bc9S4YAH9F1tMXEUdsuW/XaBLgnV59i6Ostpj6aSI9WsaAxSIwwgbHtRjQWpAVwVZlTwm4Xk7TxvxUfsFz4DmvDotX1ppXqLG41CrU6nei0h+vCJ09hb3zJefFwWDYf3iuhttvxHDk/cZB0eyOSlMBJyXo2H5xcWE3ET/2nitpCLhgZIzw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB9508.namprd02.prod.outlook.com (2603:10b6:8:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.33; Tue, 10 Jun
 2025 10:58:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8813.032; Tue, 10 Jun 2025
 10:58:22 +0000
Message-ID: <dfa38212-2f55-4097-b025-beafe11bb3d2@nutanix.com>
Date: Tue, 10 Jun 2025 11:58:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250607001056.335310-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 715ab937-db10-4796-6155-08dda80db794
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzJ4Y3N1YU1hOGV0c1RZbERNWk02NDA4Q2VDeFBzTjhtRHlFd3N5RFhqQ2R5?=
 =?utf-8?B?dXIzWUNSbFhRb3FBQW5SdjJQQytwd3ZNMDdoQUlHN1cwMkJhV1h3WnlPUEJ3?=
 =?utf-8?B?ekM5N1hXVXBBOTlKVTkwYnZYaXhpUld3RUJTQXp0elErcDg4RDhnQmRibCtL?=
 =?utf-8?B?NVpPeUovbFp3N3o1TkR5d21lNmRpUzBTUDhCS1BaZEJZWXNBUGtRSlAwQnRn?=
 =?utf-8?B?aFcyZWpTWnJicU1sWGpKMTlJNEYwaWEwRlg2Z3JWSWMzWTcveHQvaEY1RCs3?=
 =?utf-8?B?ZHVPWUM4LzI1THBVcE9NMHJOZmVvOElXK0paR25QN28wendDVjJIdVRBZ2Mv?=
 =?utf-8?B?bnNxNEtFK3lSSWFRNy9GUUwzSFVZeFJDNElzdzBJTXRhb3h0UE1IWkMvNnZU?=
 =?utf-8?B?LzBLd2ZrSVR3cXFDSUVxNVUwM1RiMDA1MEJlTDdZVG1WaWlkZUlGOThaU3gv?=
 =?utf-8?B?dXZGbXIvV042TlZ0bWUvWUFOQUNoRVRpVlBZb3Z0RHVwQ0E5VnpqbVNKdkhT?=
 =?utf-8?B?bFU1MUQrb2ZHK1kzQXpDbnhMejQ5R0lCSFRaUEE5SE1CdU16cHdMaEJiSlN5?=
 =?utf-8?B?aTM5bC9nYWkxeVlkdVlnNkJqL2RCK2pOc1VqbGkxZ09SMnI4MlV0akNNMk9B?=
 =?utf-8?B?WkYxeG05MnBYdG01L2gxVitrRnpQL0FiTVByNVhFUml4bmV3R1YzZkQ2WWJM?=
 =?utf-8?B?QWIvMHhuNFZ5NXVzZWpOTnpySnQ1UjdJWHB6Z1NqRkxybS9JcTdyRlNka1My?=
 =?utf-8?B?SURVVUJqQkpsMnV2bi9NeDlGRWhuOC8weENNME91Qy9KSDhZOEFSeVBuS0JW?=
 =?utf-8?B?UTRHQlBqTkpGeU53NXhGL2UvaGlYV1o0TTdvb2dET2QzZ211Q0srcWVIZ0JJ?=
 =?utf-8?B?N1dGTENMNWcrSXoyR3pLM3dZOFhZcUZGUWk0ck44WTZLeDRKNy83VVROMDIy?=
 =?utf-8?B?SkMxa1dDWWJLUk5tRUdudXdPeE5xdm9pL0FObnViR05FL0RtSk54Tjl5Qm1T?=
 =?utf-8?B?eTdsS1dmYnAxdS9TeEwxTTNESytaOHN1STBTTGZYNEhvZ1Qxdlo3aEhNVnA4?=
 =?utf-8?B?SHJRd3Z2T2JEa2pqbkZuSmpZYTd3TXhSeEtINWRzSCtvKzVGVUJMeDhHQkFV?=
 =?utf-8?B?aUNzNVpvSCtpTGEyUjRwK3J2ZS9HVFdVZEZuME5WUE0zSy9nd0RwbTlwTUY3?=
 =?utf-8?B?aUtXTGNaYU9PelpPNHJLU01kdDdCS3B0TTFLSm5IcVdRYmpLQ29xbjB3dE9Y?=
 =?utf-8?B?SFpWcVNkUUN5eEZ4WTRiZDFlTTNvZmJudkVJejNybmJ2cGducE9sYStZSU5w?=
 =?utf-8?B?cmlTZW92N3lPbXdrL3NLcXN3K09RNGJ1QmRLdXZMRFIrMlp4TTlHVzlnYldZ?=
 =?utf-8?B?cVdaOFJKMlhSbWVHQUF4UzFmenpBN084T1ZYdVFJc2xnRU9JeU4vVlJTQTFW?=
 =?utf-8?B?NkdMb1p4aUIrck1PWDRGZUFabEhVbFpFTHU1Snd6NmpYT3NmYVBYaGhtVzh2?=
 =?utf-8?B?UXl1SHpERHhycWZDZFFkb0hsa2cwaEtJeEVpZGwxUks4c0RXeUpsZGxBSTF3?=
 =?utf-8?B?dWw3bGc1TEJxY2RnM3Z2TGh2V1JseU5WSGxzNjUrSWlTWnR1ckZMRDBiNXVH?=
 =?utf-8?B?Nm5jakFjSHRvVWxvL2dScTUwMXk4Y0J6WGc0K3hwS1VOcllrVFZheFhjT3gv?=
 =?utf-8?B?cmxjR0tDeVVmZFRzNWtUWDMycTdqR3MxMUVXa2p4R01oZTV4Yk5GVDM3dTl4?=
 =?utf-8?B?Q2VLRmNMclQ0R2FCNFk3M2dCVTFndGtzVTdockZFTCs4eUNiVGEzQ09tOVc4?=
 =?utf-8?B?WjF0M0RZWmhjQmhYTHErYWRRTEdTTVlCN2I4VnlqMTdKR1YyanRlbFFETFMr?=
 =?utf-8?B?Q3hpL2VoRXFtV2pjOWxhMWFDZVM2UW5OZndCek1kUHB4a3J1b1VPcHNWVE5T?=
 =?utf-8?Q?wXwyW0iciC4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckoxMTIrYWhrNm9wTno5T1hVaEJkQWgwMVB1NHNaVTZ6VzBrNmxBWkEzZ3ZC?=
 =?utf-8?B?VWRxNUVXNUtKN2RheVhYeERYT1Q3Q1pXa1JJS3NEN0lvQkJORkRoV2lBMDVG?=
 =?utf-8?B?VFJFU0hLK05yWTFQZm9hT1Y1OXQrSWJKcS9OUG1FcHd6RVZLWnJ4d29kdUxR?=
 =?utf-8?B?K2MzUUt1WkdkTitOcjFERlQ4aDNYNzV6Wm9TVC9QN3ZTRDM5SlBFdG5ZOEpV?=
 =?utf-8?B?L1VMOHRmVFZjdERES0VzMHhsK3dSM29iRm9mUzBJU2dMZ2ZWQ0RCZ1daQzJh?=
 =?utf-8?B?bTJvZDQ4a0kvNmcwQWc4YnFmV0pPdVB6MlFOY2NwTHE2OVpubEZIcDU0OW81?=
 =?utf-8?B?WmJTUXladGpJdndxaWVYY2VlVFU2WmE2ZnoyVks0emVjTTFKdnRVVUdWeEhm?=
 =?utf-8?B?bGhmaU85TGRXQ2FHOWJkRVBid0V1Z2k3dnpsZXRoSlFzd1BpSXUvNkZhWXNu?=
 =?utf-8?B?S2JtNGVrV0lSYWFnN1JPTURSZEs1TzRCb0JHVVRRNW5mYjFBY3ZQdWlnRC82?=
 =?utf-8?B?eXF2UEJnTHZseUNuNzcyUzQ3d1V2YkdUT1ZCbEZTRENyRWRyQjk5STBFVEQ0?=
 =?utf-8?B?WndvS3poejREZFRKNDRONEFhSUJlSXJER1NFVTVoL0xla3BDTXdRTCtuNzhF?=
 =?utf-8?B?R0FiRENVWVFFL0tHM0VBNUtpSGNpUUIwVG5pMkZIcGNJaDFlUDU2N0JISVl6?=
 =?utf-8?B?QSt0SHVWQkxlYmJuNnlmYTFCeSt3cS85RUpycGtnR281dUhzN2pQV1lSNUVp?=
 =?utf-8?B?dzJJSUpUL2ZHckJ5UkpHaXNkTDZtcUMrUVc2c0lQSVpIMTZ5NG9FZnk2UEtD?=
 =?utf-8?B?V0Z3Q25CR0QrN2dRYS9jd2xzU1VVcVppVVhtVGlMSWlLdFBjUGJHMXMyakFO?=
 =?utf-8?B?L1pwVHZsaTh2R1RVa01kN0dXNS9Nb0pGUW5nVlBLOWlBNFVtamJOTUFpTkMw?=
 =?utf-8?B?VldYRHZMZVYwY3E1a2w5dVJialZJcUVzSURTb3Nha1Y1QmprTUZtZFhmYW80?=
 =?utf-8?B?bnAvZ09wZ0ppeGN2TU9USlBJVFNoNmVQNFdFVmRPWk5xd1hpN3U2Ly92c2ov?=
 =?utf-8?B?RUNFVFlkd0QzSnRmcjRpc2VObmgxS3p2LzFtajQ3SW02ckZSQytNY3F2M2Ew?=
 =?utf-8?B?VTJINUJRK3JlREl2ZTkxcWp1aU9oWTRvajAxM0NoV3ZKd3ZybE1JS05ZWHpl?=
 =?utf-8?B?bGRwSy90VUQvRXMzaGVpczg2WmVHOVNpWm9ZdG1TWnkyVEVJKzRpVjZ1UW44?=
 =?utf-8?B?LzFHZDNYbWlvYXlMYkROWTRmVTNFN0o1Zk5iSDJFZVAzZFYxNEl1bW40azc3?=
 =?utf-8?B?MWFTZ0hYbVd3QmpnYWc0aU5pNjdDTVpNTEhtRGsrQ21RREpxUy9pQWlOQ291?=
 =?utf-8?B?REU1VytlVTZtRlVNcDh0Tk9QeGRXb1ZGOU1XWk1DNzB2NFdnNHpRcjl0eUh1?=
 =?utf-8?B?UE9FVW9mM1h0WVlKZ2haQmNUN3BSMTZkcXNHM2JvMldHLzRRZzU4aUJJVDRN?=
 =?utf-8?B?NzRiVDZzY1FJbnVRMGxHVk5tMk5iUUpob0pCWGxYZDRXMG5NNWg0cld5NE13?=
 =?utf-8?B?RFEwWFBEczh0eXJVNzlNcjJtSjZnNUtqbnFJQi93QnBGVStmMTJoWkczZFpl?=
 =?utf-8?B?MEY4aFp3b1RUWjBmWjlaM0hrREJZUllQNUVhRVg5VjVUVHhsbkRWVXltcUla?=
 =?utf-8?B?SC9QdDZRU0FHY2xDQUtuMHZXd3J0WUh1QTRUWDZ5MGhnRll4Uk9mN2VleTB2?=
 =?utf-8?B?OE0ybUJWMzA2U3hzcnErTkgxWEF2R2xpNzJTaXRacUlTQnBxQ3FGdE1hc1g4?=
 =?utf-8?B?Mk9RNzVyWTVxWjZHdHBCUm41VkF3NW1qQ0RPMVBuaDhVZXdYMFRjTnVONklu?=
 =?utf-8?B?WE1Rcmk1YzdaZVV4cjlZYk1NZWl0Z0JNOGhTZkMxQ05yeUZJcHc2WmRVVVhy?=
 =?utf-8?B?S3N1OVhIbElBRU1Kb2tTOTVhQXRSMmp3MWJhbE1UVWM3QTI2VElrRGgwQzZT?=
 =?utf-8?B?OUVzZFFIU2ZKbDdvbjlJVFlwcURnMldYWXhCeHlDeEpCV0dUUzZieVU4VUVP?=
 =?utf-8?B?b21iQzdnVGhjZGd2ZzFkZ1RuYzd3MXZKYytHbER0aWx6NU4weE1TUEkyc2Zz?=
 =?utf-8?B?VU1kSDJtNzY4NHVFaHJYQS9HakVqNzdZQ3JmS2U3a3V5NzlFTEhoMHB1TVo1?=
 =?utf-8?B?UCtZY1JTcDVWemdELytYR25vQmM3ZVd0R0c0R0Y1aHJUVWtaT09TV1dKVmVh?=
 =?utf-8?B?bTdTNlZVdE50RCt2d2wvM1Y4MnVBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715ab937-db10-4796-6155-08dda80db794
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:58:22.5584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0/o518bJTovdjnAXr0aVI5mb0Fc27HqM7fKlJbvt+7azX9dhcgxj6WfwUoQ3L8k6CxWkMJClCiWoiH4xthHeurlCCAf2Ewuo7U8M+XKY6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9508
X-Proofpoint-ORIG-GUID: fQyvSDLpNn-yaTKYn6Ge70xk808a32sE
X-Proofpoint-GUID: fQyvSDLpNn-yaTKYn6Ge70xk808a32sE
X-Authority-Analysis: v=2.4 cv=W9U4VQWk c=1 sm=1 tr=0 ts=68480fd2 cx=c_pps
 a=DmRYdR+pfzj2fdMzxedsIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=skjlAHHf0HfQNnxMCOEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA4NSBTYWx0ZWRfXy7XE4QAt4jpf
 IzhDOm4ac06M83/i5mPjM64daJFtvCHiVju6hGSBlIkEdqkRO32um2r289vP2WYY105MkukJyk0
 QH7Hkv94d6ccJAZ/xuJZIQgJrAiFwUicNqot4XLbDl9BkNj/jN0DzK9E6/LWcLpTJbCSK3U+kll
 Ou372Ucb1BWnEC54U39hrxCXRLa0bDaTEnguOEGPae/YtOO8sVbKocxNkuMpEqDQ5j11415kZLk
 Lj8AhFWb0RuVFj04uv8eBctIZzzKJ99UmJzoGFdidAym92cHjWhX7QJ1KZ1/11aXJNyGRspvX6p
 4XF2dltIDPy4eFKFDLRiZ9II5Cd9eIPGqCdLP8AFp3d2X2X1c8vbzFMJn07TbPnkrQ2ydR/X4Zv
 rbTlYMqLPZpd9heeBeZSpO07XfVpyAXAVzg5eh9u7skwzoiQ0KNwzFSkkwg7GmsBNrtadwYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 07/06/2025 01:10, John Levon wrote:

> For vfio-user, each region has its own fd rather than sharing
> vbasedev's. Add the necessary plumbing to support this, and use the
> correct fd in vfio_region_mmap().
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   include/hw/vfio/vfio-device.h |  7 +++++--
>   hw/vfio/device.c              | 29 +++++++++++++++++++++++++----
>   hw/vfio/region.c              |  9 +++++++--
>   3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 923f9cd116..5cb817fd6a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -66,6 +66,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
> +    bool use_region_fds;
>       VFIODeviceOps *ops;
>       VFIODeviceIOOps *io_ops;
>       unsigned int num_irqs;
> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
>       struct vfio_region_info **reginfo;
> +    int *region_fds;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> @@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
>       /**
>        * @get_region_info
>        *
> -     * Fill in @info with information on the region given by @info->index.
> +     * Fill in @info (and optionally @fd) with information on the region given
> +     * by @info->index.
>        */
>       int (*get_region_info)(VFIODevice *vdev,
> -                           struct vfio_region_info *info);
> +                           struct vfio_region_info *info, int *fd);
>   
>       /**
>        * @get_irq_info
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index d0068086ae..29a8d72deb 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -226,6 +226,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
> +    int fd = -1;
>       int ret;
>   
>       /* check cache */
> @@ -240,7 +241,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   retry:
>       (*info)->argsz = argsz;
>   
> -    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
> +    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
>       if (ret != 0) {
>           g_free(*info);
>           *info = NULL;
> @@ -251,11 +252,19 @@ retry:
>           argsz = (*info)->argsz;
>           *info = g_realloc(*info, argsz);
>   
> +        if (fd != -1) {
> +            close(fd);
> +            fd = -1;
> +        }
> +
>           goto retry;
>       }
>   
>       /* fill cache */
>       vbasedev->reginfo[index] = *info;
> +    if (vbasedev->region_fds != NULL) {
> +        vbasedev->region_fds[index] = fd;
> +    }
>   
>       return 0;
>   }
> @@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>       vbasedev->io_ops = &vfio_device_io_ops_ioctl;
>       vbasedev->dev = dev;
>       vbasedev->fd = -1;
> +    vbasedev->use_region_fds = false;
>   
>       vbasedev->ram_block_discard_allowed = ram_discard;
>   }
> @@ -470,6 +480,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>   
>       vbasedev->reginfo = g_new0(struct vfio_region_info *,
>                                  vbasedev->num_regions);
> +    if (vbasedev->use_region_fds) {
> +        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
> +    }
>   }
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev)
> @@ -478,9 +491,14 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>   
>       for (i = 0; i < vbasedev->num_regions; i++) {
>           g_free(vbasedev->reginfo[i]);
> +        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
> +            close(vbasedev->region_fds[i]);
> +        }
> +
>       }
> -    g_free(vbasedev->reginfo);
> -    vbasedev->reginfo = NULL;
> +
> +    g_clear_pointer(&vbasedev->reginfo, g_free);
> +    g_clear_pointer(&vbasedev->region_fds, g_free);
>   
>       QLIST_REMOVE(vbasedev, container_next);
>       QLIST_REMOVE(vbasedev, global_next);
> @@ -502,10 +520,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
>   }
>   
>   static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
> -                                          struct vfio_region_info *info)
> +                                          struct vfio_region_info *info,
> +                                          int *fd)
>   {
>       int ret;
>   
> +    *fd = -1;
> +
>       ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
>   
>       return ret < 0 ? -errno : ret;
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 34752c3f65..cb172f2136 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -241,6 +241,7 @@ int vfio_region_mmap(VFIORegion *region)
>   {
>       int i, ret, prot = 0;
>       char *name;
> +    int fd;
>   
>       if (!region->mem) {
>           return 0;
> @@ -271,14 +272,18 @@ int vfio_region_mmap(VFIORegion *region)
>               goto no_mmap;
>           }
>   
> +        /* Use the per-region fd if set, or the shared fd. */
> +        fd = region->vbasedev->region_fds ?
> +             region->vbasedev->region_fds[region->nr] :
> +             region->vbasedev->fd,
> +

This feels a bit odd: if you're asking to map a VFIORegion then 
shouldn't that contain all the information required for the mapping, 
including the fd?

(goes and looks)

It appears that there is already a fd field in VFIORegion so is there a 
reason why we can't use this instead of adding region_fds to vbasedev?

>           map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
>           munmap(map_base, map_align - map_base);
>           munmap(map_align + region->mmaps[i].size,
>                  align - (map_align - map_base));
>   
>           region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
> -                                     MAP_SHARED | MAP_FIXED,
> -                                     region->vbasedev->fd,
> +                                     MAP_SHARED | MAP_FIXED, fd,
>                                        region->fd_offset +
>                                        region->mmaps[i].offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {


ATB,

Mark.


