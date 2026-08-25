Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D096AC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysUR-0007Ae-5I; Tue, 25 Aug 2026 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysUO-0007AF-Q5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:51:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysUM-0000xG-EV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:51:00 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEcNn52145703; Tue, 25 Aug 2026 07:50:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NLOQPUG7xB3yb2Zintcsc1LKkogVTk7X2bfJq23XU
 +w=; b=rpBzqp89aHgIuda5ZEeww8xCt4N678LY15ezvk7S3ht8DDVHNZ8M5khUn
 m9la25WFYsM/6VqyEKI+40MspuOPMSQ6sgVFMc6zTWhtvmwiE5iy+Rd3YN9VtsPn
 FJfCLXfHPHrWiVxZPL/Z37o7rkEqVIZNTjZnzteHIhZO6nIS7/y2MY5h2in0k1ff
 THpeQqilj08YEAay5hzKzpzCwKf/rNkj5MfBM9ufpX7og1fElNCduO7//YxKU4ya
 TTnj2SuEGf3fOUafufM1pYMURmyXs+AzZ0Lq1rTlrK39/T2O47BB5GvS5Z+Zib7r
 MehhNmaKVRL69KulaPJl0fGHgaX2A==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020139.outbound.protection.outlook.com [52.101.56.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sya2nxw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 07:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTq+qOurcaojLqBJcs59x6zIiJqbv875F8fzcqdK+cVzlsBFZQHPuBwqcEnpjiuczCFlcWHfoRSDTvfftFeWVeYAkkArMyvFH75huLs9MHXZCUiBBngkXrfhcIwJkZw38v2cNUeMRd0kUR83fuJmCe9b8K3MrOObLk1B65zeXgiuyymcxOv9N5Ph+D9dzJxDKjs5mp2qcY9tkqAxeItv6pOEvRsNRTmrej4VWPlhsLo8nbiRMBUO+QsSk9jT/AgNDqXBIsH4X23iSmqrzMnzFVeQ0+Lc2GE46qi/EA1WU72IYuxIy123GG2TeNDxlVKaESVvKRLmVQaCi52nT83J/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLOQPUG7xB3yb2Zintcsc1LKkogVTk7X2bfJq23XU+w=;
 b=Z3baPHvEF0XoQtTjPuwlA10rDbD7UpM8MdAa2za39oCD/wYu0fYpGl76MegyNYsy+2hIENgGKAL1x61Nrvt/IC6JwpD3SJMJLf3QiVznILmmfOb0dD61fM8814znw72N9JXcAL2oxDUk1ZNiDUHB5pErrtveMnTPsf8j3Xt0UFt61yIr9aVxmyjdolVU3+a3nGXgXN7MVYo6mwqHuyjGaQ+eGDtGSTaSWXC5wfXzkHTaP1aOJPxWVJutob/M/OW2g12sJ5bTdfrXPznHPYH7nD1lnJHSnwb1GFg/Ig6KEDyen4rtlm3q+mviiU9sVS1TYVjqIbroz+DUvKPZMJBYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLOQPUG7xB3yb2Zintcsc1LKkogVTk7X2bfJq23XU+w=;
 b=EzgA11faeg9A9ypBQt/ti6tgS415K2Rvuj39Uhjw3W96E1nmsOrvMPc6Id5csl7zmyveW+j+LVzlOa+38V8TDEE+tAzp4Ptl14P9ruq1AV23Ww9C8ykxUTIzp81n6Iy81G1c7dgYJ5V6EuZw+dwy7LTGSm6AyWhO2TALmu3juAIiQC7GjNfKBEavopWNMWjPMMBn4gyo8wTfBJt0Wxp4jAQzJlqFFuLDDylWzfP1VhCjhOZAO9iu6PMyJwpj1YEH5vI6zE/BT3qiVNFTDZp5s/ExnMVXdwBi/YC4rGPe+ZB7gdz+ngbpfb+g7VYqiL6oN974j5Js7GYdFKqD520lBg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA6PR02MB10743.namprd02.prod.outlook.com (2603:10b6:806:43e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Tue, 25 Aug
 2026 14:50:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 14:50:37 +0000
Message-ID: <19eda5fb-1cd6-48c3-bd7e-c121708d8cec@nutanix.com>
Date: Tue, 25 Aug 2026 15:50:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/74] qom/qmp: populate qapi-type in QMP handlers
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-9-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-9-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:806:28::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA6PR02MB10743:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e6d39a-c83e-4917-78ee-08df02b8392e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|3023799007|56012099006|10067099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: w7bf8qqHGjgAkz8+bWGOp6G9hPWzjhqrBlkYVTAIV0apXSipgPD5SAUNEHsMmKVNnAMeCYvkN6ciNXKdyx/PYw8JI4CBXQWGv1W4jJ6dN5xdLPaRQHcFE4darFOxpM7W5gPuJ4ghJWKNAVV9ZhwSu94dEQ+icMkK0pMPwKDHL8DhIKHblfZgORz7tJj5iGoeR7AjVZ1jiXnvTHgiwWpRveQOVCEihdKCHKEhP5E9/uR824ZHwRIPO3O425Wm5WgnlJL1O3nMNYZ2l6/m3qN40KRrg6b+ro9EKjcGMEBzR2ze0teCVr5qdTpC2ITUDiAMYr8oaepbyj3v1aR/spgpohyAiC2txqpB3lJfQweMbzhkNuYHsHTLwVid93v99TKQIwZspwLAPjdDAhMwrdYVdLUOYtwL5n1r4FpkaGmpwuVHEdLg8HaAYT+ceyLp1yetdGrVwFl188aQnnC1Igmyb4aVMGOT6nB5A7R8nNzpHy5Y2xc2SYzkDaKwRp+eFEhCBjDY1kBVW3ufC44EcTqHhcWgPpERhRcKB3tyokJ6hzkl3EOA4JBcl0VJ52h3yVd6EwMLnjd3PuAKQIL+lCQq1WCG2hu169QmXVWBpTXaxvRFajvj5RH6LJvhjrW8LTgxU8bH+Fjr4Aon3K0aSZeYyqTMXPnWgoPE0cnb+VVacAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(3023799007)(56012099006)(10067099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVza3ZnK3V2UjNWZk1JVE1SN0lPVGM2Uk91ZjB6T05UbXVXak1yV24vSzdR?=
 =?utf-8?B?MmhDSzNFQUh2SXZXbU4rUlJYSkcxZnZRZjFxcXE5SFE3UTVXZmdiMVZadUVQ?=
 =?utf-8?B?TFI2eGpEbXpxTCs4bThmc1lmTmlOUFhNaFNsejhwakY3Z2J6YXlyL1k0TnVD?=
 =?utf-8?B?QjQ3ZnpHaEhBZFlrNXROM3F4aXVzTGtzaDN2YkxBbFBmZTVaMC9xclFjZGlh?=
 =?utf-8?B?UU9Vb2N6Y1NtbWtXK2pqWHU4R2c0OVRDYkJQcUFTZTF6NTlwbHVrVXloNVJr?=
 =?utf-8?B?ODF0bEt4RURhQWwvMVV2MXVETVlrU29KM29OTVVmRDFoUW1zRG9qdElVSVJP?=
 =?utf-8?B?MG81ZFhvQmU0dVE4VmJHeGFZb1dCRUtEbDZnaFRGb2pxaXhKZGtsSGlOT1Jm?=
 =?utf-8?B?dnRmcmpsSWpMK0RDRmpLeko5Mlo0QTRPTmhFM1U0Sk10Y3F2djV3Z0dSN3VF?=
 =?utf-8?B?R2NFZHRJMFRNcUdiK3lBNFppQk56RTFnMkJMZnRIdlVUMzlYVFF1a2lNanFt?=
 =?utf-8?B?VDIwYXo0VDRyWlpyQ0VBSWVQN0FkdVNIdlgyR1FhcHJWQVZKSmVodXpxVW5K?=
 =?utf-8?B?NE5hbWxmMDNmejY5LzRmNHBJWEdTUGoyLzBFZmlMZmg0TndUWFVXRlV1TWRI?=
 =?utf-8?B?bk10bFp5OXZ3NzNPQitSZ2Zyb1RJUlJyZlBuaGErNXBJb3RqT2kzL00xZnJl?=
 =?utf-8?B?YjAvTytLOUdYTFhScngrRjB2ZVhUVFJFZ1phQUR3R1cxci92WDlkRFB5SlhK?=
 =?utf-8?B?R3hITWtyV1NUUG1QWW4yM3F3dk5uelN5RHpremRESm90ek0yL1FIU1N6SjRI?=
 =?utf-8?B?ZGNzSU1ZL3ZmMU1GQm40NDFoZ01OTlg1UzEvWVczcXNKSG80YWhQbFRaeW5z?=
 =?utf-8?B?V1ljbERkOEQyRTVjaFFJUjB6U3I2Qjk3L0FwV0FUY3o0a29lWVRvRU83bW5q?=
 =?utf-8?B?K1dRL040OWV1L3VKZ1NnemlsVTYzdDJTcUM0a1kxcUxQQW9vYy9NNkdaR3RV?=
 =?utf-8?B?L05GSnVSQXNzS3hzcThmT0pGRWJUbUlqckpvdUp1KzdJRXZ5SzJWWllDRWVG?=
 =?utf-8?B?MWJzTWpKYSt2RThNSnBlelpwK1hNYVFlWWp6QjZzUHJwN05zUWtLbkJZcERH?=
 =?utf-8?B?NTR2STJsS0xWbFpHdU55Y2dRMGdOWTVnYm9GUkdod21YSG9tQTBLb3hxQjNC?=
 =?utf-8?B?TGxBVkVDcmdzcmxkWGx3Ri9PajRHUE1Id1FTU0ZBNTE0Z1JBOFVSY1FyNURr?=
 =?utf-8?B?bVNUMDMwZ3dObEdJY3lKWUgvWWNoekR6S3FNMnQ3YkxDemVDci8zY0tGVW41?=
 =?utf-8?B?WUg3UlJkb0t0eUQvdU12NUtabnJIMnl4L052dklIWFFVTE1rOTB4NndkVndP?=
 =?utf-8?B?MDgxdW5mc2YrbTJmZGFDSGpFTkZ6aFZ3eWdJOVFncERRZjc3eXdwUDJnT0NJ?=
 =?utf-8?B?c1hTN3ZickJzekJ0bk9NZnRSTmxWeXhWakwzN0ZLeTZ4Zk5HZXk1MWYwakcy?=
 =?utf-8?B?QkZ1ZURIZ2xMdE4zZ1ArblhhNm5SQjlrdDVDNi9LQ0xRUTlBL0luT3JQWUdI?=
 =?utf-8?B?cFFOWGdGMVR3d2VUb3EyL2xtcytEZy9HNUdsK1huLzNnbTI4QlZ2dEYwTmE4?=
 =?utf-8?B?YVRjVzdHM240VE9yWXRnRUdMbkFnaFIxVk82eHJyVk5yVnlaTGc5UTVFaUZj?=
 =?utf-8?B?ZHFJU3piQThSSjVBL1hnQ29zR1F3TXNySkRLZU5rNkRGVXdyaFNVZzQvYmNz?=
 =?utf-8?B?SFZuRXQ3MU9VdHQzMVZadXJJWWFCMmVOSzRDeThpNUxMU2FUVXdzUjJOVnFF?=
 =?utf-8?B?bUpPamk0MXhlS3dOcjBrUENBZUQwMlo4WGRHcG9ielk5SnpwREF3aVI0dUpk?=
 =?utf-8?B?VEwwRlF5QVhmNllhekk4bXJWZVAxSFU5YUNyaC9lcklGRTYzUkJ3VVd1Zld1?=
 =?utf-8?B?eE9nYVE5WkZYV29BeTE0ellDRGt1bjJhMHB3TE5GSUhPQWI3Q1prZlZLVlFs?=
 =?utf-8?B?RUVWdk0vS3NSR2srRml4YXIrODhlLzdrUi9yZVk5N3BSa05peE5Ed2JYZ3Jo?=
 =?utf-8?B?cDhzVnYwWmlMSGVIOFBWU1hJMWRxUHN2NXVOWFhBczd5UXFSdkw4SmxBcE5t?=
 =?utf-8?B?dmNSV1V5S3NIRzB6N1VnczZKZld1NFljcVcvL0xzR0xZZFJ3MG5IYlhuZU9a?=
 =?utf-8?B?MjBuelc3ZFd0NG1BRVU0VURSKzlqZ203NjZOc0I0Q3k3bEh4RERHWC9VQUNu?=
 =?utf-8?B?S21ldlFaQ1AzeC9wU1Z1RnJWanZiS0htdTk1RTZ4a2FQN2R1RXJGOGRZaWIr?=
 =?utf-8?B?WnppMjZKbXVFTEs0ZFlkc0g5TWhaUmRvTW1GRERuV3VIVDJpaTU1dDJPTWdI?=
 =?utf-8?Q?jSadcQ2y45sxwwxI=3D?=
X-Exchange-RoutingPolicyChecked: Flrhy+BdBffP77xKlLUhzuTQ1ldahsjpCWEBgvq5nFgUJfR72TQwpIQa4iVf3Z1tvCSzSXSu07D5JYM6hRf+AVihrlsNdReH9HZEg8Wz3OdTY2Vbm5V4fDPu64tfipfb73+8ih/P+b/uQb669WGy/FPOF92ZeA6FCRbZ1nsdYdcSnQIcuqPJDDyoRAsCy7H7wHnzOJAFrsU1B7mcdpCiLODuROQrmSLjLGYQrcP0UUDGBzuQ/abec4Ij+ZeGTKpXTxK0GqMKqt8v9UnEJ0GT9asJ0fjRIjTSphTdrQrObbBuJBh6G22onGWa2HRQanFf/QueBfphFm41SN90Lst4cg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e6d39a-c83e-4917-78ee-08df02b8392e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:50:36.7562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkNWx6dxf0KuFeiCGfrz/3BYqW1eQK8Ttwyt4+pE6ODOpozXr3kU39hWJuKeu55EY/cgAl/M7Npu8C1Q9Xz1qU7GLqM5SWodMId5Z6I2hdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10743
X-Proofpoint-ORIG-GUID: ZAE-QkWxM6xRDRNjaFmQYH6zj-Tqlbv5
X-Proofpoint-GUID: ZAE-QkWxM6xRDRNjaFmQYH6zj-Tqlbv5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfX5zGBkwsyIZIg
 cpg19FeiJtIFOWuulhafGmB8maUM2AreDWImYxtzPQF4OL9m+fUZaQLAOtrbNb0GxAEZ5PDPo31
 shVOWhOhOwtvFxJgLoNcEioGTnAa6W0XrwkmagyHn56stSvodhx5zIviWst/zvJUpDku0h/M6Jg
 Jod27tQ5ihdjOYbVfR1bRJyEZ41aG/wRtR0HXP3tTw4w/MDoIrO2NiqAKPaKtLYrQ46TeRawH9p
 DRXhI6atq8FQPczR5g9UNppcP/q3/RVy6AhnWFcr2WQEE65FEAq7Ygjxy0cLfyt2LjsHttirTaq
 Zm7Ed8N5Z5A1HTRBSAnjs/O+rqd0fU8ioFWLM1S1grVMip/G1SE8I+jRveDYhG7kkOEkLE3NUn+
 zcI98NX97ikY/ClxlO4KNHFyZePN/yRUhjT7TwAsP/JaH1gfLx4A77dtPXwmN2Ynz8EnUlkUM7p
 kY9MW9t1iUU0Q74+Fjg==
X-Authority-Analysis: v=2.4 cv=YOqvDxGx c=1 sm=1 tr=0 ts=6a8dabc6 cx=c_pps
 a=HngsKjkEkW2FdqPxnP33Yg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=8m0zEsn3on-s4NE-JtoA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfXzgZINh4soe1Y
 A43Yc6XbB9S9CC4J8sHgmcUi99HU5iLMFS2Gd4L3GjJfvhIDOxOJcnOSW2EVCIg49M/OFuxMbNC
 RUTHLwhygV4LeO6p7LodrpIt0YxHu9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 18/08/2026 12:10, Marc-André Lureau wrote:

> Wire up the new qapi-type field in all four QMP handlers that return
> ObjectPropertyInfo or ObjectPropertyValue: qom-list, qom-list-get,
> device-list-properties, and qom-list-properties.
> 
> When an ObjectProperty has a qapi_type set, the masked QAPI type name
> is copied into the response, allowing clients to cross-reference with
> query-qmp-schema.
> 
> No property has it yet, the following changes will populate it.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   qom/qom-qmp-cmds.c | 32 +++++++++++++++++++-------------
>   1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 330895361d47..f9e6d4371cc5 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -25,9 +25,22 @@
>   #include "qapi/qobject-input-visitor.h"
>   #include "qapi/qobject-output-visitor.h"
>   #include "qemu/cutils.h"
> +#include "qapi/qapi-type-info.h"
>   #include "qom/object_interfaces.h"
>   #include "qom/qom-qobject.h"
>   
> +static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
> +{
> +    ObjectPropertyInfo *info = g_new0(ObjectPropertyInfo, 1);
> +
> +    info->name = g_strdup(prop->name);
> +    info->type = g_strdup(prop->type);
> +    if (prop->qapi_type) {
> +        info->qapi_type = g_strdup(prop->qapi_type->masked_name);
> +    }
> +    return info;
> +}

Any reason not to add info->description here? It seems to be set the 
same way in both cases below.

> +
>   static Object *qom_resolve_path(const char *path, Error **errp)
>   {
>       bool ambiguous = false;
> @@ -58,12 +71,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
>   
>       object_property_iter_init(&iter, obj);
>       while ((prop = object_property_iter_next(&iter))) {
> -        ObjectPropertyInfo *value = g_new0(ObjectPropertyInfo, 1);
> -
> -        QAPI_LIST_PREPEND(props, value);
> -
> -        value->name = g_strdup(prop->name);
> -        value->type = g_strdup(prop->type);
> +        QAPI_LIST_PREPEND(props, qom_property_info(prop));
>       }
>   
>       return props;
> @@ -78,6 +86,9 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
>   
>       item->name = g_strdup(prop->name);
>       item->type = g_strdup(prop->type);
> +    if (prop->qapi_type) {
> +        item->qapi_type = g_strdup(prop->qapi_type->masked_name);
> +    }
>       item->value = object_property_get_qobject(obj, prop->name, NULL);
>   }
>   
> @@ -218,9 +229,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>               continue;
>           }
>   
> -        info = g_new0(ObjectPropertyInfo, 1);
> -        info->name = g_strdup(prop->name);
> -        info->type = g_strdup(prop->type);
> +        info = qom_property_info(prop);
>           info->description = g_strdup(prop->description);
>           info->default_value = qobject_ref(prop->defval);
>   
> @@ -261,11 +270,8 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
>           object_property_iter_init(&iter, obj);
>       }
>       while ((prop = object_property_iter_next(&iter))) {
> -        ObjectPropertyInfo *info;
> +        ObjectPropertyInfo *info = qom_property_info(prop);
>   
> -        info = g_malloc0(sizeof(*info));
> -        info->name = g_strdup(prop->name);
> -        info->type = g_strdup(prop->type);
>           info->description = g_strdup(prop->description);
>           info->default_value = qobject_ref(prop->defval);

ATB,

Mark.


