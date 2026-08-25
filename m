Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71916C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRh-0003mL-Ig; Tue, 25 Aug 2026 09:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRf-0003k4-Ko; Tue, 25 Aug 2026 09:44:07 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRd-0002Vw-Ow; Tue, 25 Aug 2026 09:44:07 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB0dUS1670234; Tue, 25 Aug 2026 06:43:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QL3O9tMGIA7E+kKUqPV2LhvWmTpnMvib9fjdbK6IW
 +Y=; b=JfqHpQq+hJtw/hDSZfgwS9PVuHZiDCo5FDYB7N0sEbsMa5UsZwtjj/EEA
 cfge6+6JbgGVV4AxD/KYBU7xf0/neqxcmhoK+3H2UQ5ohCLHdiQ5Jft2leq3gxGO
 pTcE1UgV29+14WaSSbkqap+7Xoem4EsVi8wtvK2inatz3NcmxtG1PP60E4EoLBhR
 i7kBt7YQXosdAMEIP4kq9LWsRMhkJflF1Dil3kHc+K+hEZRU1631HQdjpCuc+2Hx
 trCHZQn0IF7FfT5VwiJbxfk5vIzTIxUaDdjj2pn05l7ba6/WDrLTXcUH72id8OCy
 /C6l5ArmqUcQXaOSxtceGAHaxwlxw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022095.outbound.protection.outlook.com
 [40.93.195.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sya2fwh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otGv4Ls9IXq8ZIQET17cpb6ShlNIYDLS7jhdWYz19V86dQ15Z+54faIOdRAi0aFwojOWWQDwk5DIj92xgtInNu5ltX/jAthgQKQm/vR+N2I2rguz5Lb6QCbgH8yp31jstcbYiQCp1CIAv+0JLmTEkENYmwLiJTQgNlTXWfV8sSVUfaeYvpo9E/piMDmsGSj62EHkE/+q9V3+xRnWtvLvV/7fhxUxEk3VmVsQMIQRLBNgw29uBC80X2FV6mNDzo066Qu+bWWe+BIhwJ2z3i8awGLkPuDaT5RbvhyoSMI1wiTp5ND60A2F+7uxIpT0+ie85C4qoWTdTvIbnxCg4Nq9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL3O9tMGIA7E+kKUqPV2LhvWmTpnMvib9fjdbK6IW+Y=;
 b=sUzC1Zgu3Bnboenxeb3IjJr3KUr3KTfa439pEK53Fr6gg6P0yl9VK638qy+hYFZAQNPfI4EJxNYht0OglQ6zGhN0fWIBdKBX59UXzp7ySsAeNIE/UrlEz4DWST40RIioSWMOUQohkunCS4T5AV+ArYXvv6L5IQE1xli9Uj0M4Ws4LW5Dg6/uYyUMTjKtcv50LDntUw2f4APJnCgeHjqHfa2LFeLtHuzJreWK+KyQ0RCYCGZJrRg5JPcTSnAO2ZDaU4UHvLpD9jOgKW0N7h/VsG6Ks0uoAGKtkMYewpELdD3TNY2qwSV/VlwSCNid2mqvbkkBhWHglaL9r1UP3MiaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL3O9tMGIA7E+kKUqPV2LhvWmTpnMvib9fjdbK6IW+Y=;
 b=Tm7fmIZ3hK6A9j/XoWQAghld4bOLa+D7LxSDSbYd7u8jDLwSK9JJUQv18r0pq2qBNjbn8kfdLs54VZPkHnXJfHnncMts8VNacc2T/+++m476vcVSYGYSHStR3DfZ4yXf4GZ6yWGkIPV1D7fC/tKIYi9qQPFzkTrGAt9NgONYJu+1kxfo1/c3UiFO2559Y5DXO3c0PJ/YW2AWVCVKdPb+zVsyLV53Z01fYsLccoAErFrw90HG+c4a9OeV+LkUK1XQH4ZIZVUzw8g7L3Ii+DRNDKA4hXtZxVfdS1mVwAUqmptWFwrwH6WNAL7I/OJOvAORDvSm0cuKdxJrL4LSsnh5TQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 08/16] qom/object.c: add
 object_class_property_add_uint32_ptr()
Date: Tue, 25 Aug 2026 14:41:29 +0100
Message-ID: <20260825134320.1039012-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 702dbf7d-4338-4075-79f6-08df02aee3b7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: gO9d5BZ2avScS+ETBpVdY3YKmsFa5TLd4J/IZHcPXectqWFWZa+T2yMTFu30xsInVE7oyoOy0lx3VWnjwMmjXv4PwGIkY+vYHMYpWuNCfSQKrvC9OT63eirduGkj82UHMGE4TeyfzbaQhzdpKvUA0csI/uMxoOkRfGh1BQTdd1ctgH6KberIijR45h/2hIw4knmBAqQSK8H6GVnnwxYptyWWyXW/dBvfmUlYqwrMD7DvDIwACquvSRzVDUqoc1UB+Kmbv0r5P3p1RZhAd/PB6x1zhXzWtCQlySvYWBr+xECirlu/N7EDE/lX3XdzTySTvcIpZzCDLS/4vhMLwBK6DbXgJXjw5jFESFJZs6WPDbaGtiDRKjYqitesD6jnPqP71TA10cyhQ+xER1R7IcIUTZ8D9Jay8nGN7UxM44E7hjMHZyDgJH7Vwr6xkZNTmE6hGe0Bct1o+82xjMe6EE7z3bx1vs+0YUthKx1MzuuIKJWwwwyupLuwZ61Oy9J7pRlJHBz1YmRJRqx+eh2pyRgXJqayOvPXwLx6Bc+O9zUPfh3t1PFTYK1QYjzBZ2FASEOdAb7Z97uTnYy07Kif8zZFJ32uR+/Tx4/gqTYHp8YAIfdy3IENqsCnDnMDFNf24L3QIyIQTOKCJp9EMYWtOf/HisuPdkdigrOMGqqA6p4GSLlCRe6G7bkLe7K1R35XPUFXlbziO4rqAJb7K2kec9PLsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3dmcm5YRkllbENGdm5sZnhCQm9pQjlZSDdwamxmTnFDbHRocnZoWkhCWFE2?=
 =?utf-8?B?T0lWQ2tNQzJGQkowRlBTRHBZeDdXV3Rzb0x4cnpzQWdkdXlDMGl2bk5qdmdZ?=
 =?utf-8?B?STczVFhDWDdoKzBXMnJaWDBNQ0tMUFRmT2tOaEJjUHZ2TDhpSURUZE9DZ2hl?=
 =?utf-8?B?WFYrc3lPZkIyYmI0MFZKT25lWDFCRmR2d3pIWVJFTEdrMlU0VGxWN3JEN0dl?=
 =?utf-8?B?RFYyKzQ4WTlBcy9OVjJNSThraEhLZWNXN0RwaHNDa2tQNlpvSFhMcTRvMWI0?=
 =?utf-8?B?TzVDY1VPTUFaa1QxSC9xc0xMeEkzR2QyTVdycjB5c2J5bUQzQVI0Tnljb0RO?=
 =?utf-8?B?dTNHNzJyRHJrMUFBUWV1YmNwYXlZbUtZZ1A5eXFlejcyTDl4OE5Md3plU01z?=
 =?utf-8?B?d3lPemU2UnJtQWg5S3pFTjNvc2d5RGFJK2orczk2Z2MrNjJibCtQOW51TVp0?=
 =?utf-8?B?RUxNNUQrSHIraXZCK2ZVWDR2ZGNMVUM0Tk5kYktjSUh2Z1R6THdTZjdIRnRr?=
 =?utf-8?B?VDdGczgzQXdUS1RyMnV0NGYwTUtaeW9vVnFMVlZIR091dXVTZGV1bkdla0Vr?=
 =?utf-8?B?cnVCREhIRVkzanRGOVdZeldKWlIwNWF5Ymk1cFRHRmphVFlJbkdrM3gwRDkz?=
 =?utf-8?B?ZWtJdjAxcnNOcGl1c1loNzg4MEU1MmRYeVpPVXFyNXorQ1ZPOVpVcC9MWnJZ?=
 =?utf-8?B?bVV6UVhGVGQ4eDdxMHp0Z0pxSG1VYU9PUEJWMjlGNVRLaWEvdGNPeFRYdk5D?=
 =?utf-8?B?RTBwNXBEZEpSSytiTmQvSEdlbnZ4M2NUSFBTN29sMmFpV0NoWTJFdi9RQndj?=
 =?utf-8?B?aGI2UFNuRnVOMlpBRVVBVHRRV3dDQWhTa3czMzFiQUdSVGxUMmgweWNZUkJK?=
 =?utf-8?B?c3NTWEJSa1V0ZjZacHNIRkxtNzZYaXZQRWp0d0IvOFQwcjdiRGFLdE9YY1Er?=
 =?utf-8?B?UjlQQ3ZVMnNSdWNZeHFVTmJDKzNPU2FjRUI1eVZzMFp2NUpEVzd1SzZycGd4?=
 =?utf-8?B?NjVGbW0vYXpiWFB2K3l3eko2V1VQR2xXNzN0QTRyK0hNdCthTkROUXo1UnRW?=
 =?utf-8?B?ODhaZjJ3c05uc0Yza0pzYmFJQ0ppM1BHc1c2bHNJS2lxamNJNmF6THpSaVhK?=
 =?utf-8?B?bG9KaFJnTmoyMHNOQkZnUC9vbG9KWnlxRnl4UXF0V0krSkNmb0VSWjhhQ1hp?=
 =?utf-8?B?djBaeGtGR2RWMTJJcDRaTjdneEh5Z0hMWG5mREEyQnc1RDJ1MlRzYlNPSnNO?=
 =?utf-8?B?aDRFdjZHVHozU2xOQklUM0xIdVZhdXRvcnNGYVVuRVFyMGNxYTZENXJ1eFh6?=
 =?utf-8?B?UzI1eWhIcFcvaCswSlRydXkxSHBTVERVUWFwTU9GQlVuZHUzWG12UzFENDJx?=
 =?utf-8?B?WHJNUFR5U21ER2VOZjRpV0ZDNnVtR25LMjYrUlV1b3BmU3JjNlh2TDh1V0pl?=
 =?utf-8?B?R2o3Mk5OSldtRUlhZ0ZoNGxDM2NKZlcrRFYzUkRlZ3hYQllvTnlZU1JqcTFn?=
 =?utf-8?B?L0poY0dTQzE4UlkwVkhVbnpEc0VDRm1qYUd2ejMrcmcrRzhmQXdMRGV5aHRI?=
 =?utf-8?B?ZlFyS3hzQXd6U21ueU00QnF4Tjg5eW4yZENBZXlaNEQySGw0SmliRDFRckxU?=
 =?utf-8?B?WEJ3WFNtcEEyV3MrMlJxZWd0cUliYUd3R3NLMDNzdGp4RlpwOVNJZ3BERW95?=
 =?utf-8?B?WENRMTh4STlkSzFMZWFwa21VWWpQb1pxOFQrV1VtUXA3cU9IYlJRYjcvWnhM?=
 =?utf-8?B?cWZ3U2JvcUw2bkh5WFRyLy93dFpESTl3YloxVjNET1ZUMitRQThBbW84ZkVi?=
 =?utf-8?B?YVBRV3JtM3F2SFp5ejNvNVMvR2FpVGhtdmloMFZ2U0daNW1GRXlBV1F0Z1F5?=
 =?utf-8?B?ZHdMWVc1K1ZTeFZhb0FqamYwL3p6eVBsUXJLSjBWUjloWUxqcDJnU2hWSkky?=
 =?utf-8?B?cjdKWUlGSTNqSUVnWDY2aE41VXJJWmJIdWtjdTBMU2JDcHBWZmFCS2xuVUlu?=
 =?utf-8?B?M2J0Sjc3Y2kyQnRyc3ZsM2tjam9Oc251cktpWENxNExSZFduVlFBUGhwRE1h?=
 =?utf-8?B?N0s2d2tucDVYUDZZQ1ZtYS8xZ0RnVGtiZUFOenF0RmsveG5JbWZBSitFeXhE?=
 =?utf-8?B?d3J2WmlJL2syRC9TWkl6Z2JZZDAwN0hITzhNV1dRZTk5Z2xCZ2pFOGNWQ1NT?=
 =?utf-8?B?QndkVHhsSVlyNm1WNFN0TkpiTVF2SDJDNEJnM0NYVjF1NFpzbWNjdkFZWHhK?=
 =?utf-8?B?eHdYU054dGtGWmlzRzY3Z0IzSXIyMi9aZG1uMlEvSHVwazcyM3RvTnJNOWdM?=
 =?utf-8?B?SW11KzR6dTNTejN1OEhJWVVvWFBwZTNUbkpnT29FVnpCQXFmVVlEK3lPbytO?=
 =?utf-8?Q?o38jaFSQ1qlBdfmE=3D?=
X-Exchange-RoutingPolicyChecked: j+OF2aWL/+J+RiX03l6+Q0ZsbIXPPwPzgsulr564+hLICMARW95YFVpGDkxOGwgAVDTBMt4gChNeH4uZcFcOKJRnUe5SX55QBFI5MhKdgK3SBP+XxZh2+NQGnAhuM2pennA2+09XNShyi9obXxFoVwqg5Ia4OnfT4utob+qIE6N+dA2uXS9O5Orsa8sI++TFlSbo3Wu5ioAAQRv2P9zPA7HAhQEQrKShTo7QGmlIqJrhJ+nIZZMO22uAIIM9DRd4venYCkAMWaIWMCfT6qvWGHv81mtPnUHi2mi2o87CNs/lznrwBaom0s4v46khB0X9w3hHS/qktAIzQccDTIFCOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702dbf7d-4338-4075-79f6-08df02aee3b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:48.3474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng3CkaNE594vzcY6Xr7aslmpHaddMAW2Nq39irMCcMA61pUKPclZVsZ2DVZzPLvYDPFqjmdRNw73NlGGDxJ6eUTnN1sstRzgCqFbEq3Nhv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-ORIG-GUID: C5F4MVnXpxlEi9kMyc60gC8Fgw1UeU0c
X-Proofpoint-GUID: C5F4MVnXpxlEi9kMyc60gC8Fgw1UeU0c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX8GX/YwtiUtaf
 CTp0ST90qWtnbJGKDBuojWyGpeOlNQs2X4Kb7qeux+5DlUW+KybDq55YhfAomazwuvYAtTt3yRf
 u1apsfHo/m1HRVcH4hCI9qdlDu5BTCkBcNMDMDyOD6MsWhKXVjlAeyxBPR0oJcYNJmQj2oukzwT
 njtdUtKZ28wJePwHO0e+rsefwXoBjKA+NrgA+uyOUmPcFl0k2JP0vcYUK/85thaDhKH00+vVygV
 kvCOQP46cBD4gOF5IBb+auG7YWrT4SbBbhNrrNh7z6rhVnvzAezMUS+4yDyPbA3HSQJ9vjI79Fh
 pQd0Sy28bS5ySESWnUkSJTRfg0Yxif9yXkiYMuG8r+jxhPJSvZ8TMhIqcasviK91fV4Cs8UXWxP
 HPM0KKjSi6tM3hGseRXtUkdtfpKKWO47PxA0UlZgywuskAHMdLtk3TTOT3A51vtwPoQSenacbvl
 cmoWXk4N2t9ZHt/vyqw==
X-Authority-Analysis: v=2.4 cv=YOqvDxGx c=1 sm=1 tr=0 ts=6a8d9c17 cx=c_pps
 a=ZO9zLbrfvwitr87ojz3Jng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX2P5fuLiEyC8z
 mp/ZLD64Bz2Mob4OlWWG275c6xcXZ21tCuZAaFLRZWfSqcsF6+pvTQrLwntfxguA3jANI7Cagh6
 AUP2jx3eYSlx5bDFafq+siIXLo72MTE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

This adds a class property that references a uint32_t within the object instance
and is intended to be a replacement for object_property_add_uint32_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 67ccd2b08f..8dead29284 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2129,6 +2129,24 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint32_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint32 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                    const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint32_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 271c2916b7..f91764aaa7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
@@ -2871,6 +2872,26 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint32_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint32",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


