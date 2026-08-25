Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FDFC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysm2-0006fo-O9; Tue, 25 Aug 2026 11:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysm0-0006fJ-BF; Tue, 25 Aug 2026 11:09:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysly-0005nK-Hv; Tue, 25 Aug 2026 11:09:12 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEcIbq1958554; Tue, 25 Aug 2026 08:09:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=e7EgjQdGkyUvDbTCHJqjJ2CPSv7gthxdkzazjhhA8
 Mg=; b=mW1AUBzgS1NaJsN24z5ufeT8mvSNNWneKvfcDrc6d2uivdkC28scZoSoB
 +P9Hk0gBZChTaE92dgoNn2A2Vd6algNGmHWy7S3c3YkzYCe+xII5AHbpJc/IzXVo
 BIri8y/NqO62R9qNhhY6VzJ7E20nVzyX35WzqXQdlaQF9ZugvRbYFer/vd9Nv19f
 OgqQFmA1hSq69mrfpnvb6F9yteEklWLE32GqfRheVfew3eEM7gh6DfeIjk8moNaQ
 1QB7qDXDmC536QLIM08pxxC6+Z6EPPRVviCi5MHo4sFi/bdEaoajGD2uTYvEVYdx
 iNoYm7SRR1TDTB2vSCBaysaGKAGFg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022101.outbound.protection.outlook.com [52.101.53.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g783qxst9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO20gr8Hyp+s4T1ZXm30mg8nZFE00T2cAqBriXnEDJ6v9y1P4JJr9L4+Op0I0wTg7tyt84gGYOhgdRawhyauTKHRRYdC/uMvVkuQSajDZUvr+A9kC7cSCEBivxxDVmS9LAld0j5MxFDthks74OZBhluD3mBplABgqZnSt1K4mDRUjOpzFvVm6tXQ4LHS1nkh8nXTSA9cSq84qnoJS/6EJ39WAG7O8+0T/sL6wzrl/Axb87EuelNhPYz9L9why1vY9Lb4royUhFz7OVeHpjxVNhvp+fmWiDv0nUJWUqKHE0AK+HB1SN2GgCc3fr3iGBNsaKLoIsFSPoxiC+zYYpvVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7EgjQdGkyUvDbTCHJqjJ2CPSv7gthxdkzazjhhA8Mg=;
 b=XzSu58FpHZzzeIQNiZgzBir+G3cUdmMAinWJwt4m7rPgMA+HHS3SB1zy60xZoQOdxJkCKImH1jzYr7z+pF6j/IPfBMlNL3eS36AUk2Fwze1OA5Y3SUnZcZUT3cUftxR4gljeW5ouahGQO9DCN7sam0La6+gWj81hB+BLF+1auSa8CQ8GyGa08ZZy4Y/bDrq9tzfKE4gfU0ilgBAdXLsYXgh2GvWpz2B+pyHLXcwyztJQQJGi2Hb5bn91znv3uwt+IJlvLEm5vUP3LJlL1sJCy5gbVVZScZx8ogLaXDSIRuBhv8bzKnTzCDlLWW/VHbK1zbfQvzL/A+xSTVDgDiOK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7EgjQdGkyUvDbTCHJqjJ2CPSv7gthxdkzazjhhA8Mg=;
 b=GAtXbB3eCiucKbvOm6nYUzbJUMSXGLef5DWIFVF+pa7ZmmYReLaXgZbR8/w1E7sO0OPRWpoq+itHfl4jA6U21ABITwq2faO8l/awLjI76alTyZSZiuDt3jvPXf5xg6xT1aIv7OgDcPUFeUAGd+C29p6DICsZIadJzjhO0nY6z+0ty7gjl4yEySPg8lskGQp5SJpwvTOcQ41leoSL1Iw1bYYH2/OnhF/ocu9kK9RSFwGWd9DUK2XvLyIfqk/78BMQL2YX2xyis2cYxtPhhiU7VXLbaw30k3aQ3FzTPPKB39YEu8l6jlQNS96vIlDEQkdVfzGFYjRNyY43tSUskq585w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8855.namprd02.prod.outlook.com (2603:10b6:303:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:08:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:08:55 +0000
Message-ID: <ff6c0b74-d73c-4a53-b77d-dd904771bef5@nutanix.com>
Date: Tue, 25 Aug 2026 16:08:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 34/74] block/throttle-groups: fix throttle properties
 typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-34-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-34-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4d6174-6465-4afa-e089-08df02bac7e8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wUDZJPS/SVsmIvWn3qWBb2nluV/nA2D5VAjj2gAZZaxdbSEw44F7bskMVpgdPjghbag/VUrnYYGpsbEumgJrYvrTrBZWR1kzTH+yGOVuU1gBlmhPslM6oNbAfY7Z3dBqsdJMDTn7Gtvqq0k8wjoahpDDySWxIUgKlslwbML15CCaJw3sYrpZSTO3KnYRbUPQ1xpDGdAVmY7SuxkS49n9bDPkrM37IJQ2mImbgUeEebBazJ8T8fKVlosxD6tZYIt+942EjIAjr+GtMqyQ5xfeASqz6tvq/vdJ1TVKxBxwwODQfnJL+ugmfkfvnu+EeI3fk3ecFieNNz/158ZO4uf/ZpHjY9JBE5zjenv88BHXDHBowICWnfrN4lhKdZNAEjUvsVvUKv4z0oNs/lTep/DN5AmVwzSGmRgg1MgsPCUiZuAB+82YUcyNRf4zIiixZkf+pTNuzxMzZsoLs55XGoGBCIvvboarHZAPpedVepSQc8ueL8rakyhpXXW3CyQE8jw/DJhdFQpSsiNIPlhpcwlYcTYY+eazEy4Esgj3RC1P1q8UrKqUElmGz8j0KDW0buyng+Pcvy4xNU6kgWDzaaUd8Fk9Hf+2+G+y3buVyiHLcdvx973W3/+Nw8EgBiw+CbCk67p30otyT2WOvi1tErX/d1JWHGNB6DZ7HQ9nNcXi16c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJoZGd3VFk5N2dwdEhBRisrRUFLYkliVlprKzVFcmxIQmtaMG9lbHVTeUdo?=
 =?utf-8?B?MDZrTHlrUHJqenR6eFNsZzJxNDNoTVRTRDFMZHlEaHJ4MVc3Z095eDREVUU1?=
 =?utf-8?B?NU5YM3BwZ1pTbGVBalBZd1VQN3RzcDNoNW9LUWZYY1k0RVVRY05CejM3S2hJ?=
 =?utf-8?B?NklLdTA2OE8wMUNFQ25kM21ITDN5SHQvLzZjejVHcklMUForMC9jZGk1aHpj?=
 =?utf-8?B?S01LOTgrdmJ0QkZsN3JrMHBTK2dZVk5DeXRVZ3pkRjE3Wkk5Z0puUURhMFZN?=
 =?utf-8?B?YlhYZWZTWUVzVVlpQXhGZW5UNytyQXJtVVNJRVF4eU5XdVNaVzBOLytzcGFP?=
 =?utf-8?B?aFdxQUZiNXpUTUtWcVBxSjYrcjNhQzNOdjA5blhrZjBpQnkrZjE0RGpXMFlI?=
 =?utf-8?B?SWRNMlA4My94V1dueFY3am9Qd1dyNUVTM1lBRDNXdjBJaVlNZ0daOXo0TGhP?=
 =?utf-8?B?OG5HZU9OR0doaVdJM05hK1dMaE1kcFY5MUdSd3d4ckE2Q2FqTFRXWnBSYUlU?=
 =?utf-8?B?NndhN0YyVjRQQlpUZjFEYjZPcEJxeTlYaWI3N0o5NGlDYkpGeHo4eThrQkw5?=
 =?utf-8?B?S3FmUmQwRitzQjVpZUZJcFd3UU1GYzhZMXF5cTRTTVlQNXN0KzdvUVhOaHM3?=
 =?utf-8?B?ZE9jOWU1TGZHYTNjeVQrQWNISVFRd0hEV1RxRzRlUmtMUTN6VW5CQlZCeDBW?=
 =?utf-8?B?N0hGWjNoUVBHQTNHdWRHVjEzdlE0eEgxZVVHWm9XclhzSkJReUV4RkdxSTdD?=
 =?utf-8?B?M29mVlIvR1VOQmZoM01xZDIwK1kvR3RtOHBpa1RDR09OMlJBdkoxYlNUNmUy?=
 =?utf-8?B?UlNYZCs4ZnY0aU9mQzlKdDR1aXhETmYrMmZWUVhkUE41UWl4NEsrQ2lzLzVI?=
 =?utf-8?B?V3hvTDRjNk4xTnNwUlRLSStkTW5nN2JXRzN4cUR4UlBFQWQrTzJVQWtrOGVa?=
 =?utf-8?B?c3VzRXpKTFdyY2ZmbjNKMXZqazU4bUdhWkJEWENaODc1Z0lyb1VDbUJudFZt?=
 =?utf-8?B?cEJLc1ljMTIvN3VGTmVlREVpblVXaW4wQ1EvUXp2WHlGNUVTZzZUcmZ0VmFy?=
 =?utf-8?B?Z2ZIdGRVUzVQVlRnOGNncEFYNGdGTlhwWk5YNlh6MS9SWDMwTE1ibm9IZjBV?=
 =?utf-8?B?aHVoUkhtVTZzaWRVc2ZnWHl6aTR5V2t1elErbFdvUEtEY2s1c3UxYWpyaXMy?=
 =?utf-8?B?cmZJSU03anVoY3JuTUdwaTBHOEFCZ1psenIxbGYwcHczanp0bGE0T1Q4TEhn?=
 =?utf-8?B?dFBqeXI5ellxcEtSTnFWMExmNUR0V0RlMDZNVkl4NzZCN3gvZnJvVlg3RGIr?=
 =?utf-8?B?bzN5L3duQXIvMHF2bFlRTm9UN3pkalFKOTBHZUx2ekpwd1FXbWJLMTlrNk5F?=
 =?utf-8?B?MWlvWXJGOWJCRGhvR3ZlOXZnM2RUalJDVS90ZTdwVGQ2alU2NzFPTm92Unhu?=
 =?utf-8?B?UnpaOTlkeVdXcjFDV0lBVDZkaHNxREdDSGJjNG9BcmgwQlBCYVNoOE5HOEZn?=
 =?utf-8?B?ZEhPMmhyYllKcTRRN1FidFFlbDVUYnJrUUJmMzhNSFlhUGtmemtaVE1xendu?=
 =?utf-8?B?VVJ3NUIzNEIyS0UxUmtLdG5zMElZdVpyQ1dvaVJBZU1KcUtublFmQWtKZXpv?=
 =?utf-8?B?cTdKSkdyU2svT1BlQWZwK0M2TmNaM2N1bWpML0FLMGNhSEVESjh6VGJsclF5?=
 =?utf-8?B?eFp3d01CR1lkYzc0bTRNNVVEeXlmYXJ4M05zbS8wVFNRS2xYYk5qY0NPdVd3?=
 =?utf-8?B?V3pWdGpmR1p4MlNGRXQ3bTFuVk1zdDM4MDR0SGRMUXl6WWtvM2dBUmk1di9Y?=
 =?utf-8?B?eXNqSkxIRHRySm9STFgwcCtiVXhrUjRreWFYaCs3NzRpU0FCYUVDL3ZZSVNk?=
 =?utf-8?B?WllGZHZtbkNrMXk4enI4OS9ydXhsVVZZWjI0WWpRV3lsRG8xbS9BTDJJbklO?=
 =?utf-8?B?V3YwZ2tmZ3FzVitneFJNQ0FXTmR6RFhWVzVDNjN2QVl6RHVSUWFxT1lZclk4?=
 =?utf-8?B?aHZ0WWlOTnBadmtZK0M3MkF4bXYvS25BcDZCMlNQbGpIREdzUTRiNEFHMnJh?=
 =?utf-8?B?NzhHUUk3TDFldktCVnZRMHc3RWNGWlNacGMvbmZxRmZXMWQ3dVRPVm9QWENq?=
 =?utf-8?B?MTJwSzVJd2EvRGFFWUxONmlTZ3hoYmN0TGpQZHVLMjFXbitVUm11SjRSQjlM?=
 =?utf-8?B?b3I4T1gxdy8wWUxnb0FuYnlZMkJyM0dEU0xkcUVEOUdxR0FITC9QUitPNjgx?=
 =?utf-8?B?S0xyd2lCL1h1LytvczhWSEF2Mk9hV2d2a21hOVczRWRaL2FlSkx6RlhGOGlQ?=
 =?utf-8?B?RTlYdXNxM2R5d09ISmJlY2ZDM0xIN1FjZjFvcXIwb0tTRy9zd0Nsd2NyRmFs?=
 =?utf-8?Q?4EvhAB1+l+QYk3gg=3D?=
X-Exchange-RoutingPolicyChecked: W2+EgK0BAKQcQfKUEl0t6JnwC/USI3k2EQ95yOZ5dkVh6+WELdNHilGPc6VePLBscMCzfYF7WA0pHlzM7B5Gnu3mAQfsyXj+HbaH/UD4HjM05K3rgfURWiCjVAr6Q4VaqU7NreghWoFUPWw5cOK3eOPA0cc1ZUz+6fuCEI5xDj2VyMTcv30+OaU9aqurFC5rKp/JZ+EPwjUgYCeLZnKIXAlIxnIC8UgUpodD4DI9h7iaILjcBaTC+i2j3KoEvSN8slIROtrR/YTxDeedP19syktaxbrE9Osqpe8TtyCzjgFYCBegjODwxWvSf5FPQB6Jss57mycp67/gQNGIayq65g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4d6174-6465-4afa-e089-08df02bac7e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:08:55.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dC9meLLuJ0oe3l0rhkXZd8sHGty4LBVituTXiPkLOr39djGqpUpySsXUDc8Ka4Qv3UTvyI8Bo8WSrILaF93J3IujIJ2dYN2LoJlesmICt5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8855
X-Proofpoint-GUID: YzOh7TDK0uOFZZXojknh36Q_a4JnTWQy
X-Authority-Analysis: v=2.4 cv=KdfidwYD c=1 sm=1 tr=0 ts=6a8db00c cx=c_pps
 a=ZOOYKzJuauqLjokEqQd8dQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=_BW-VI6-JU7XRo9WEPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX45NRvjWYGW2i
 6TkQcsqR3fifE0EMBwds4R/2A/0mFs+BNC3old++8IsPG9AYAcRyFdQbImZeAi4+eULw2ATwMjU
 f2epz6rn6MiL7F/MozoAcyd0hbpKmWE=
X-Proofpoint-ORIG-GUID: YzOh7TDK0uOFZZXojknh36Q_a4JnTWQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX6jfbHWKc7Ajl
 wYa+kA5IDOV0WK9S0ERvCAe5l+bE4Qm/n//mKnSpa8Ak1SDPGkInimpqy1RjTKp5sHTMTucJUxA
 gaygJn5lF9r08hUlm3lWklyyYMm2Z3fFcGW0J1jvr5dLXdHstPzLfUeyIzwLKhlMW7qXBiQOLM8
 K12/q0y2cq2BNtIWsUvTxPU3Ptproxf6jonwnIWQJ192MD8w/3rqR+qyVQZuzRp7JZkpzVGzuCu
 f1SSGYx7VCxVw1H5xeXDCQtYFp8rY09Cb9wT0INmceJIfAO4+N+uQfzo0NL8b4HPPu5uGsUFzeK
 RrdUXVRJPZwbo6o3asK+P8l9C6Y/k5SeyRmsfJNOSAXQh6HKoqeDhCqyYU4I+ihg1uRtGlyQDmq
 gTr545XI3yaKma2JjL6PIVJfr5Km825Mu8LTwhADKWPZcN0z8GecCPnETelpFSep0HJ/frCEm4l
 Pi5SUxXgfsz0qu26Mgw==
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The getter and setter use visit_type_int64, not visit_type_int.
> 
> Fixes: 432d889e55e2 ("block: convert ThrottleGroup to object with QOM")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/throttle-groups.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index a9d3aea3b54e..6312157802da 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -985,7 +985,7 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
>       for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
>           object_class_property_add(klass,
>                                     properties[i].name,
> -                                  "int",
> +                                  "int64",
>                                     throttle_group_get,
>                                     throttle_group_set,
>                                     NULL, &properties[i]);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


