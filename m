Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE416C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWG-0002z5-Et; Tue, 20 May 2025 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWE-0002yj-VE
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWB-0002Ju-W5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:38 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBfwAL026470;
 Tue, 20 May 2025 08:04:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=ByB5wUM/N+/cm
 kRkBDVKT7c3ymfqDxiGwCvcJzCkurU=; b=2Rjs5wn0UUSz+fK2rMwqNpIDvNW7n
 4d3GEgdK9SAWwrrFO4gnUI087n1KSAyxSCcuXNP6KgID4IHa4tjOc3qJZAhncU/2
 m2YWAJymuMq55SeMGAl9ya24uyM1+bPp+k0KNH6rG/mrcEgty8JwVkFFBT5aHFRX
 RiJNMP4cZAMsYEggma1ZzKwoiRVqBh59yhq+zHIv83smTv09X3bu+fFxcLiVD36x
 0E3fjlPprBcWgeQDqtcSBr6Fykh3rwFNR6fsXOAlM+uubCc2yeTkjBpaxwyJzwyP
 LUglIx5iCoajcllV6V2ey6cOWJadhFROX+U8FV39ZVvLvWJLuggdrzCDQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheabe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suP46U/6XSxPOoQtGJcgUu3cEZRiQxTaUYDz4Y/fllg313Fvqjvh6IUTkYulelJjC2ry8F84pER7XLwHKleBNkadG0C8d/f4rcu/QRD95vaICDci9ETTjUbzlOnPg8vTldSztAzt+47lBMPkSagVzQipewAxkcsLsIDkLrAZLdBqFZguhB340fi/IoDDstPICa9DsXKWQxbci25uOi1J8Vzs8HKsXNXrzVUL4Sp4Ebhe1QX50WIIah9IREz95lvt7RiX6ZbKEVGNVAO+B5yEz4zaOUUqy+AuADE6sk8RgtbuGCkIw235+SNsbki50A6fCLHcxsTyDAKgGoV9WBkcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByB5wUM/N+/cmkRkBDVKT7c3ymfqDxiGwCvcJzCkurU=;
 b=F8+af1wy5/3pSDF+xQZyZfKr0hjWUqpwRdsvhoLk/lbWmuTGDqVMRqHVm5zGjpHwMldkdQlRjVs4dsv/pmCpTLFFg68mA2A8W1U2lfIAGOiN/nHebLertD1LAunzF50CXcQ2xPGalvhU0EGyPtdTmeKh6OqiKh3H1jGSp/yS6sbYMY8OE1PWTXJ8bPxva2/VcBBAWCOtNtpbHjVwhzLP78rCTS5yPelebwLdNyt9mefcNJLjltHdPEhB599acEqCaeTrKRl7GhD3PCQE0QS7+1ZzhbXaEDtAgMDk1Z+EW29PVlII/WvUM4Kk3eulnmE/FnIITZdRaeKsdkvwi1zMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByB5wUM/N+/cmkRkBDVKT7c3ymfqDxiGwCvcJzCkurU=;
 b=ak8GKm14usGm28rCRcVt7pa6JPmQRxwc7vVh1V8qGaL0lsGRbglS7WaSTiVBiYD/OUE3gV5HUI0UVpi2hMzN/BsaLMUEo0Kk91jQTQQSRT1AJx/uAKR+e9Em3sMQTIL/jyotSEwPcWzi9gwyqcbhF10nTUREFK5yfSCJvi8ByRgdojZjkbaKkUoRBaapP+ZOkvA4gZwhzihIljsBgCMdXvMpsUZnXHfTGJom3gjy4ONOAG3hgKRRXNZ3GFcWYVP+bJnnYMmDIkvuq75nil834fKkjPzbUmYSEa6XM/uR5SeTxRyzvUwGl7A9fe+OdB9cc6QRa9NN6++lVqAnFXwmeg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH4PR02MB10612.namprd02.prod.outlook.com (2603:10b6:610:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 15:04:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:26 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 00/29] vfio-user client
Date: Tue, 20 May 2025 16:03:49 +0100
Message-ID: <20250520150419.2172078-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH4PR02MB10612:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d1e1a3-c94d-4c6b-c24e-08dd97af9c9b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmZ2WFFmdHpXRlBuc1ljU0prY0lBeXd5OEJMaEVHUFBKTGwva3YxRWlrTFlr?=
 =?utf-8?B?ejdCRnFyTnlLcGh6N2tRYUFXTFUvdTkrMUFsTVdYWHpvdXhuazJ5em9abkN1?=
 =?utf-8?B?TUhlaHZVbjBuTFpCZHQ3TmErMnB1TnpsS3owS0lTL094eU52OG1TaFFhbXl3?=
 =?utf-8?B?UVRrdG9qRkxYWFlTeHc1Z0pjWG5xYXNBS3dRR3RzOGlRVnQ0b0VzenhsZURN?=
 =?utf-8?B?UWpIQXFFTEpiaWZ5SjBORkJJZ01DRTZud2tNZXZ5UEYzMnJOUUc1bjZrbkJ6?=
 =?utf-8?B?YUVmVHFWZUMwZ1V5Vk5LTUJBRTZUVmlBOS8rVE1NYnFmRFlQa3hjc1Jobkdv?=
 =?utf-8?B?UnNlc2JuZjk1ZDM3N2JlY2lJMlhhU3RzMTlFMVVxSnRuZjZjdjRPVFVycnlC?=
 =?utf-8?B?UXF5SUZlcWt4UUJweTZLUGhoUElHV3ViaHhUYUplNDJ1ZTNYMHFlNWd1eFVG?=
 =?utf-8?B?bGtDV0NMbXIyVWhSY0JlNEVEWTVucVI1dFZicnpJd09DeEx2WUdnNEx5N0pF?=
 =?utf-8?B?U1F1LzA0ZGZJS3pDTXhMekM5dHFkamhac0ptUFZnbFR5UHo4ZUtBTnQ1cS9X?=
 =?utf-8?B?MFgxa3BlVzdsck1EOFkvVFZsMG1PYUJEck9OalB0a1pJZDlOUEdYd3pscjZO?=
 =?utf-8?B?Yjl2aVVYQWs3VlRvYmhhWTZvTFl6TTduUWZpQStJVE9kR1hKRmc1SGg3WVFV?=
 =?utf-8?B?RzZ5UnRGS1NuVEJ5VmN3cWljM1BsWmxJblkrTk1GZUlNZVBBWDRjelNqN3Rj?=
 =?utf-8?B?TVZrTnFWcHByQ1ZoWFMrZE5SRHIrMGtvM3B4QzRBMksrYjVrY0tuaCtLdzAr?=
 =?utf-8?B?YnBJeThBUEI4OTNoYkVTY1FCeG9TMS9HSG53V3l1aStqV2JtckN4WTJVdWh5?=
 =?utf-8?B?TkoybVdPZEJqWHB4VlA3a0xaQVZxdEV0TDY2WUowQ1hTWm1YSSs4b0U3Uitx?=
 =?utf-8?B?bTBveVZoTkFzSnUwaFJPR0lnTUR4Wld1V21hbnN2dmVJcXlFM0ZqK00rb3FL?=
 =?utf-8?B?VTNYaU5qaVY3RXBxOHNmc2hOcEJpVzRaaFFFaDhHWktFSy9wK2JGVjhLcUh6?=
 =?utf-8?B?UDBhS1JBYS9Mc0xMaHdHbzFVblZHcW5zQXZiV3B2RWlPT0FXaFE5VVpRSFBI?=
 =?utf-8?B?ZFd0ZmdwTVh0UzBWUEhia053dHZTdDFQM3pBMmtaMmR2NTQyRldMb2IzQS9M?=
 =?utf-8?B?amExUzBvTTBpbkxST1BEV0hwTSsvZ0J6NU1RQXg3cndzbG1NU1NBaGt3Z0la?=
 =?utf-8?B?RG9aWGpmbjZEeUF3VGxSNm95ay9LTjB4b0lrMURPRmlzNnR4N2N1YzZaUlJ3?=
 =?utf-8?B?NjZVbnhkNFZVUE1LMjlVaXYwbXJxTjd4S05GNEZSVG1mdXVOSVd6cnE0emNQ?=
 =?utf-8?B?cHdKYUoxNVJ4Y0pFZ0tVeW1zb0srK3pQMGtGUFFHaVdqSTlyL2ZLUFdHelZC?=
 =?utf-8?B?UUFaNHd5YUdRdStad1J2UHBVcHBqTThueUpSRnVvWGtWbEZ4aXFNeE9iQUpL?=
 =?utf-8?B?WG1MYnZRN3dMT0lLVGJaMTFud3N2SDVVSDFUZVRmYndPUVBsTnlnVnJsYm9Q?=
 =?utf-8?B?cDJBc01KRjNlbThJOC9PcGc5d2t6RzVBRk8yNXpDY0I5cUc5TzdESXJZWmw2?=
 =?utf-8?B?TjhjYmlGaGtsWGZLREI3WTYrZFFCLzhoWWdUMUtWQ1JSN2pCU1E3amVkd0hz?=
 =?utf-8?B?YVdmT2lLU2NsZmRmMnMwNHBhcVJCNmEvQ0xlTU80T1dZUXRJcklYVUIzQjNU?=
 =?utf-8?B?dE9meDYzRzlaSlVrMUErVVlEdTRQVHRuMU5idnJkL0loZkhNdW9FVjBtL0FR?=
 =?utf-8?Q?VgP49QYg7TGNcaRLkup9XFt7NK0PQczDrhvDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZ2amIzRzRBZ3hCOXozVGtXblRnQXFzWkR3ZmgveThIc0plQlNTUGNmc1NJ?=
 =?utf-8?B?UkRPR08wNWxNN2RFWjE3WlJXQTc2NVN3QzB1bS93ZWd2bzFQcXpGajZGQTN0?=
 =?utf-8?B?VFJSTFlSRXhNdUdXZ25wbEcwdTNsdXl1Y1hrRUhtMkpZWlRleEhla0R5Nkk5?=
 =?utf-8?B?Ly8rd0s0QTlyRjY0ZndLV3ZRTkFQYi9tTnBRVDFWbXhjQWd2WjU0WGJqR2hs?=
 =?utf-8?B?Y240ZTdOVXFnMzNxZjJjaUhmVlNnSFdxRDN6WjVoQ3BaY05vQjI3N0tNekRD?=
 =?utf-8?B?b3JoOGZhd1BlckxSU2ltbldSWVdKZXFRRzROZUg5cWZMNkgrY0oyeEpDNERX?=
 =?utf-8?B?S2ZZbXlQVjNGemxVVHloV3V0Vzd3TU5oK3c0T1ZialAwbWNOZDZhcDROMEtK?=
 =?utf-8?B?akh5NTNHRzFrbytzVk51SHZlNDR6MDZ6TmZGTmVKdlR4Q1J0eDdsUUhEd1VV?=
 =?utf-8?B?Y2p0K0U0aVpKTXVOajAvNkZoVHA0Uk9QY1dGeURVUElYdlM3bXFhTDlOT0Y4?=
 =?utf-8?B?SmNwV21BbXFnSmNOcnUya2d6dVNZbUZqMHRhdkR5eHhsREVHYnRaQUN5MXhX?=
 =?utf-8?B?aTVtUGtaaFNjRVJ4NUh0S3Y3Yk1XUkd2SGdVRkdJUmJGUEFvWU5LMDFJQkFl?=
 =?utf-8?B?OWw2Um9VRjkxd3JBbFpCeEVLenNPY0JIRGRMcGxvSlBIZ3JlOFBselkzMmww?=
 =?utf-8?B?QWlGTUJncGFOQWU4ejBRZlhJNHhmbEJweGdjNVdOUGFBQ3dmbjd1YVpETkFW?=
 =?utf-8?B?SkZTZXBqWlJuOFB0OFhjNFQzNzdTd3RpZFRUaU5BNlhYa01QV3RIN1RZOVNz?=
 =?utf-8?B?czhoM3VvSjZ1czc3MU9VY0xYQlpJbWNVU3FoUjJqbGNaLzZIR015M1MxM3h0?=
 =?utf-8?B?UUt2emhneEQ5ZE1nUkVBSkVEVkhrckhPYTlmclBtd0VKQzRWMjN2aWxoNms4?=
 =?utf-8?B?NkF3RzdTMnBSNGUwaGpxeDBYSThKSk45WDk1OEJBazcxZUZrV2FCOWNYeFdv?=
 =?utf-8?B?ZzVpd0lvOXhlRklMSHd6eWFMSWFVRGEvc1VHMWZVQlF2a2Z5amJFcmxDV29v?=
 =?utf-8?B?Wms1c3lqV1E1ZVhHUG1rNzU2Ni9KUzJuMzNFM05hd2RFNERBUjV2enlRZEhL?=
 =?utf-8?B?dnR5TFlza2dBeDkwZkhHa0EyTnZ5SUNHT2VVQjNvV3JrVkg3Q1pkUTdoYml2?=
 =?utf-8?B?SkdoWC9IWTVGQy91ZWF3NUpxamRxWENQOUtia2NMMGlPWlRHYUlSWVRaSmFU?=
 =?utf-8?B?ZWlnRm01WmNLSWt4RkVCL2d0dmhhdDJ1Z0hFTEJhNlBCbGtKakdDTXkzSElQ?=
 =?utf-8?B?WEhmOTIvNUU0MHBRanpCd052NitkU3IyRXJYYTUxSCtMaVVHM1JVWG9BOUo0?=
 =?utf-8?B?UmpyeHl2eXFrUUVsNmI2a1FPUkQyM3dpVVBHY3NmZFZqK01FbWVWNlZWdjhu?=
 =?utf-8?B?MFNuemMyck4xOVlTK1ROdm0vbmwvVnZYQnloVHlFOTg3cDQ0SWRrMGhDbzc0?=
 =?utf-8?B?WGhlM2NPRk5RUUZpNThKL2pDR0E5czQrSWxjaUVYR1BlaG8rOTFqRFE1bUZ5?=
 =?utf-8?B?Z0lMZnRUZE02aWVYU3psTmUrRmpVOERNeHpFL3I2TFdNTDIxcmFpSVQ5UkVa?=
 =?utf-8?B?RWJIcG9uRDUyNUdKOXVwbk1XRGJrYkdsNG5pZm92aHUrUHE4Ulh6T2ppai9G?=
 =?utf-8?B?QlJqOTA4Z1JibUxrVmI4S2ZaYStWS1VIQW5HUko4VXF4Nk1TQ291QTN5M2Z3?=
 =?utf-8?B?NlFjdU5rREZFUk16RURYOGZOeW5yenJXeHBLMmdiVTFPVEpYUE12Sk14UUJV?=
 =?utf-8?B?OHlSQldnZlFyM1RhL3grNFJWUXN3aHJDNXhPQW1RdytyL3UxcHJhRkphVElx?=
 =?utf-8?B?RjNxYitQcDlQNnJ2QzR4R0UxdDhDQTJZN2NzaExEZU95UGdhTUVqVzN4ZDh4?=
 =?utf-8?B?alVwRXhoNjBzRUY1SXJlZ2NuREFwenp2c0ZpaFJQMHBuYTd4SGVqeURGaGRj?=
 =?utf-8?B?d3phSWszSnlYekhVQ2FHVmlmbFJOaFNVTmxVbW45dGNkVXZBYTczM2FzaW12?=
 =?utf-8?B?L1IzSE9Za0czMVBoSGNoWEtHY3A1bnlaTnJDQzlnWUpubDJza1Q2NE1YeS8z?=
 =?utf-8?Q?cHKFn6jTcQzbVmMSpDDi1Edw3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d1e1a3-c94d-4c6b-c24e-08dd97af9c9b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:26.1400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvdsUfCuVAElAOfKH0xC2/gyY5a6hG3FhX5dEsmi2dD2UzNcRRTgV6LatnxdtMBlYmD3pmF//FiYF3qWmomCLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10612
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX4cjz1fJKnNgc
 p/g/3kYIEYo89XEgLa4opisQ1jlEjU7nZbhMlxC+7Zq5+a2sJ3y6JbrfKKV20JoTbN1dVPOUYCw
 Lp1deFVa0+qntZf6IuyCQDR1HejRKB1hYh62YbxBaXxm60b1IlgGMDTWh7mLT6JCjjkZBqEyzBw
 PxVRKE6sRTeL5szAlgsdr1pcwSpCUqj1O3yTzr/7oFGegq4q78fSuapFHW4KPSJMmRaTmtqUgvl
 tprZJE14oQFXuHYq2/8b+lqne0OHk/OBTmjMSTnr8a8ljAdV9m0feH7lOdaoOa50iQaFfC7tA01
 CrwmiEYwuiMAmuyu46KM+BdWy4Lh+73YdK3reKaHmbCy8OQx2aPwqLtNrbuQU537VdxudX4qtur
 TUZN1U1MQ80f1nsXGri1/x4um6L8rFI/8baGE0K21nivmO1sAitqVsomS+O+GHz/hVXxPvra
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c99fe cx=c_pps
 a=zbudaZmfUx0dwwhLSrpPog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=hmw1MBtjsp0sKPK5uPoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HRuAxy6aIZN-G0wab5YDeZRof8IkDbRA
X-Proofpoint-ORIG-GUID: HRuAxy6aIZN-G0wab5YDeZRof8IkDbRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

The series contains an implement of a vfio-user client in QEMU, along with a few
more preparatory patches.

The vfio-user protocol allows for implementing (PCI) devices in another
userspace process; SPDK is one example, which includes a virtual NVMe
implementation.

The vfio-user framework consists of 3 parts:
 1) The VFIO user protocol specification.
 2) A client - the VFIO device in QEMU that encapsulates VFIO messages
    and sends them to the server.
 3) A server - a remote process that emulates a device.

This patchset implements parts 1 and 2.

It has been tested against libvfio-user test servers as well as SPDK.

A previous version of this series can be found at
https://lore.kernel.org/qemu-devel/047d7d93-3fa5-41db-bdbf-3c14c8b47455@redhat.com/T/#t

Changes since last series:

 - rebased on v5 of vfio: return mr from vfio_get_xlat_addr
 - added docs for VFIOIOMMUClass
 - separated out vfio pci exports and renamed to vfio_pci namespace

John Levon (27):
  vfio: add more VFIOIOMMUClass docs
  vfio: move more cleanup into vfio_pci_put_device()
  vfio: move config space read into vfio_pci_config_setup()
  vfio: refactor out IRQ signalling setup
  vfio: export PCI helpers needed for vfio-user
  vfio: enable per-IRQ MSI-X masking
  vfio: add per-region fd support
  vfio: mark posted writes in region write callbacks
  vfio/container: pass MemoryRegion to DMA operations
  vfio-user: add vfio-user class and container
  vfio-user: connect vfio proxy to remote server
  vfio-user: implement message receive infrastructure
  vfio-user: implement message send infrastructure
  vfio-user: implement VFIO_USER_DEVICE_GET_INFO
  vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
  vfio-user: implement VFIO_USER_REGION_READ/WRITE
  vfio-user: set up PCI in vfio_user_pci_realize()
  vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
  vfio-user: forward MSI-X PBA BAR accesses to server
  vfio-user: set up container access to the proxy
  vfio-user: implement VFIO_USER_DEVICE_RESET
  vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
  vfio-user: implement VFIO_USER_DMA_READ/WRITE
  vfio-user: add 'x-msg-timeout' option
  vfio-user: support posted writes
  vfio-user: add coalesced posted writes
  docs: add vfio-user documentation

Steve Sistare (1):
  vfio: return mr from vfio_get_xlat_addr

Thanos Makatos (1):
  vfio-user: introduce vfio-user protocol specification

 MAINTAINERS                           |   10 +-
 docs/devel/index-internals.rst        |    1 +
 docs/devel/vfio-user.rst              | 1522 +++++++++++++++++++++++++
 docs/system/device-emulation.rst      |    1 +
 docs/system/devices/vfio-user.rst     |   24 +
 meson.build                           |    1 +
 hw/vfio-user/container.h              |   27 +
 hw/vfio-user/device.h                 |   27 +
 hw/vfio-user/protocol.h               |  245 ++++
 hw/vfio-user/proxy.h                  |  137 +++
 hw/vfio-user/trace.h                  |    1 +
 hw/vfio/pci.h                         |   16 +
 include/hw/vfio/vfio-container-base.h |   70 +-
 include/hw/vfio/vfio-device.h         |   15 +-
 include/hw/vfio/vfio-region.h         |    2 +
 include/system/memory.h               |   19 +-
 hw/vfio-user/container.c              |  348 ++++++
 hw/vfio-user/device.c                 |  389 +++++++
 hw/vfio-user/pci.c                    |  428 +++++++
 hw/vfio-user/proxy.c                  | 1314 +++++++++++++++++++++
 hw/vfio/container-base.c              |    4 +-
 hw/vfio/container.c                   |    3 +-
 hw/vfio/device.c                      |   57 +-
 hw/vfio/iommufd.c                     |    3 +-
 hw/vfio/listener.c                    |   39 +-
 hw/vfio/pci.c                         |  195 ++--
 hw/vfio/region.c                      |   10 +-
 hw/virtio/vhost-vdpa.c                |    9 +-
 system/memory.c                       |   32 +-
 hw/meson.build                        |    1 +
 hw/vfio-user/meson.build              |   11 +
 hw/vfio-user/trace-events             |   18 +
 hw/vfio/trace-events                  |    6 +-
 meson_options.txt                     |    2 +
 scripts/meson-buildoptions.sh         |    4 +
 35 files changed, 4845 insertions(+), 146 deletions(-)
 create mode 100644 docs/devel/vfio-user.rst
 create mode 100644 docs/system/devices/vfio-user.rst
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/device.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/proxy.c
 create mode 100644 hw/vfio-user/meson.build
 create mode 100644 hw/vfio-user/trace-events

-- 
2.43.0


