Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9F8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 18:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzguB-0003nC-Cs; Wed, 24 Apr 2024 13:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rzgu8-0003me-H4; Wed, 24 Apr 2024 13:59:36 -0400
Received: from mail-he1eur04on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260f::700]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rzgu6-0000dF-9M; Wed, 24 Apr 2024 13:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeNxEq723MkvVuCi7kPVEfz31P6C3o0FtU+E4A0fvNkYHHhFWdb49Rgk//M7gcUcSzhOoHcZK9SVsQUQnFfW10YrG7oGHurTAb7h8QLVFrN5dgNASQ/mzp/NzDiohrp5PMjfgk5QBW8PqrYfxFgTjUBF3hS2a3rGq57g1t/lx5/Qkzh61EmSRePbv415aDM+vhxmBX+FRWEPVEa9edyYevBZ592k2zP/8Vk2I8A+SPcgsyDZjoKIUf/47CwLu4yLKJb+20xqGTO3HBayE9AqP9JUVzbtqukL3dJUdW5xHNEAYNdUOm5wKgogutR5imFbdrK8IBTOj5gpViDa/APvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wktWiItTd1n3wx5Jo40waU2dpsjXF3Xn/EfWPeEpyZE=;
 b=j9itBgxIR9FRi9JnHqgiS3pulXwSeITU4aOYtPx6Wyz9yj2tJAhcC1XhyLqjfTq1KBj8rSK768TUc4BqiYkcCvM5VAxEXs0WWOTY4+xtlawOJIk02Eeq8R7c/84nsVCHLWUIyMQyKnbaj0y/09l/8cM61idXN6OiYVOjDsDNKBbCve6oFJp3C4+U5sXJMV7N3Wncsu7YIDL3u+T030ZFT0YN9XopW/2sKuDFMdoWqT3g4t9BeN/i1abDx63pCOe0x2f2ISo7KiFt9QsLhIAGuzKDJR14HYfSb6I5qU1rEKuXVo6r44tLwX3cU05xzL1TdG0/gECKdWDR1BJVPaYZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wktWiItTd1n3wx5Jo40waU2dpsjXF3Xn/EfWPeEpyZE=;
 b=N97A6FqcpPhHRv6TjdS57jDFaNLvbvWW1YTv0tmqnYM7f+lnTE+pwymOUaQxVnvhNP92/egop60PW5XGNgk0N4Ei/g0wsfCUq/WgeTXwLO+J5MzzxV7vOvVLAbYUAhPSdLLrfAaMEeWnVwhsPCJ+YZoVl662QbJBcCXYAZ8nzil6OR3qR1v1YoZ3jZ8+j37sl3ssc8XhtVFedeLM1Ac/4LOMfM7vZoUNlobbtO8kTyLBB71AK6RyWu+FcAGfYLWRBwDdsAvdYXhB55RNvPPCBNYozhAsQSQhrFCFBgS7eLke7Lu4FCVtgJv/aOHrSt+6f7GwI0XjouInO57btC1nIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by GV1PR08MB7345.eurprd08.prod.outlook.com (2603:10a6:150:20::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 17:59:27 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::b0a0:bda8:8808:adab]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::b0a0:bda8:8808:adab%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 17:59:27 +0000
Message-ID: <fa7a3d64-aa65-444b-8e65-87a64e47684a@virtuozzo.com>
Date: Wed, 24 Apr 2024 21:00:08 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>,
 andrey.drobyshev@virtuozzo.com
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [BUG, RFC] Base node is in RW after making external snapshot
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|GV1PR08MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ccf682-2963-4ba5-393d-08dc6488487b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTMvYytyRzJ4aGZ4Y2RXdkVoUG5vdEhjaWVOTms5aUJIcG91bUZ5cEZhdkl6?=
 =?utf-8?B?bDdJMGduOUJ2RTNycmptZXE1UXA0Zm42ZzRpeG94MlQ4bVMyb1V2OXBPQjlU?=
 =?utf-8?B?N1dVQ1EydVo5NTg2N0NCWmFjWk9aU0RmdmVhQitBL0UvcWVQODRHdEVWTkJN?=
 =?utf-8?B?d21KRG02M3pmWGh6N3plL2hCWjVwZThBUXYvSGppT0JyWlNSaXBYeEgvUW50?=
 =?utf-8?B?TVcxZ0xTT3RjNjRFVk1OcXoyMGRlNi9aZFE4S283eUZPSXFGM2NVQnpNbXAw?=
 =?utf-8?B?bVlxN2d4M05SdmhYbVpCWkU2YldIbkQ3S1JWME5NZGFIOGw0dEp6V1BnSVV6?=
 =?utf-8?B?SkZtQ2FiTmpkVmpuQTlBcDN3VDhHaDljQmJ0SWNkWE5sRmZ5YlN2UHNqRHpS?=
 =?utf-8?B?TW92TWlZZWZST21YTHJUV05qYzVZOTllc2J5YTlodURvUjNSdzRNb0hrVE5O?=
 =?utf-8?B?QUVHdGxzR2JyRTRqNlVCTXVPYmd1UjQxVDU5Yy9JbUgyRHJET0Zoa3pxVHNG?=
 =?utf-8?B?dUlvdjI3WjhSWjh4aldvYUhPVk40cVRNZkFZcWYzcnRXRC9GQzVhOHY4MW1T?=
 =?utf-8?B?eFNMQkI4azhiL2xUbldrYXRPZ0hPeGlzS0syME9TajMyTGIxejdYT0VSK0th?=
 =?utf-8?B?ci85YmxpZ2pXbzNMaks3NHdKQys5WklXNVRnMTEzcGd5UmVWN0tubHFSZ1U2?=
 =?utf-8?B?eXRJTDN1QjdoVzFLK3ZTeWxic0ptUWdWL0krSHpKSEVEU0ZjUmorUDdsVDdJ?=
 =?utf-8?B?ZmREeXlmTGNtQzFiOXl3cG9LZ3owR2JZcjVHMUdyU25XTWNSRkMrcXZRUm5I?=
 =?utf-8?B?RGYxSkRyNUFHVFBIbzlhYVo3S2pGajRxRjh3TVRZM2NadkQyTHlObmxRQWx3?=
 =?utf-8?B?R1BMaDNxVXE1U3ppQmtoOUZBME9lWVkwU3VHK0tPNzRUZ0dwOU5qVFVPNWlv?=
 =?utf-8?B?ZnhvM2lyWFpkdlUzM1EwaXRaUWVCWnVOUmQxU3lSdW9BMVN2THZXSURDRTFS?=
 =?utf-8?B?akY1YlMrWGw0VTB5NlZQeXZwTmNsc2F2dzRvcFFPZVh5c21ST3M3VlBWMVda?=
 =?utf-8?B?RlhKZExkTGRPeWtoOGNYS2JCalJWR0doZUpPWCtOWXpyNjd3cXNpY1VJV3hV?=
 =?utf-8?B?a1JhSFBkclZqSGdFb2k2QjBNaVBIbHBkL0g3ZDN2SGFqWjZ2RVpBelp6SFdl?=
 =?utf-8?B?eCszbHZtakpqMGtjYjlyWHhSTTB6Zk4xM0Y0c1JIRXZvVzhwNnIrUTNacktW?=
 =?utf-8?B?MThNVE5TMVoyQ3NHL1NlSzVCVlV5UklCY0lNWkFURHYwdTRuNlhhamZrbjlS?=
 =?utf-8?B?RElTKy9jL1FZemNYS2RzaTlHZ2g1UjZuMDRoRVlhS0lFRmZiWS8ybGozY1Q4?=
 =?utf-8?B?czlNOEl0cWpZNG85b1dnSUowQWpNNGpzSDEyZkVUNnFTSEhVQ05HekZ0RHVj?=
 =?utf-8?B?Q0haYVpZcVJubTBNUGRIUy9rRjRZSytRNm83MXVEU3NKem5GRnhKSEUxbHAz?=
 =?utf-8?B?TEJ2SzFtN2xESXBtRjBEV0J0ZnAxQmVKNDlxekdDTkZNdlZpdEtPaGhiNGxC?=
 =?utf-8?B?dk9iK1dWRjBtQ3NEUTRxcnNscjhUS2cwRkhTNG1zcVlEREFWcnVBVlZ0MGxO?=
 =?utf-8?B?cDY2cFdnKzdqMzB3ejdpakhiZ0kzRVpDSTlabCtUR0QvdjlxMjFCd1lLbVVE?=
 =?utf-8?B?aXlneFI2Mk85RCsvbjlRc0F5bGNsYkU4OTN3b05FSGhoQ0RJUHEwZFJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVdYbWFOZ0hHaG9LSW5ZQjJnMkVMTVJsb0R0YzE2WU80QUhXMkZlZTZDYTlE?=
 =?utf-8?B?WEZKaVRkcmtUSTY3OW1OT3RCdktEOEpNL0doQTd4TVF6M2JiVlVlQ29sRktW?=
 =?utf-8?B?M1licnNlR0JGNmpDVytUd0lnMCtFMm4raXEvaHRIa0cvM0hMRWVSbXN4cEUr?=
 =?utf-8?B?Zzl5endoVmZnc3ZXNWJmUGxTMDIwV3RwcEhKNWRzazhpZitxaVJlU0NLNFY1?=
 =?utf-8?B?eEZkN2FJckpyNXU4RnBPTEdiekZ2aUhZY0puWHJJR1pDM3A4ZkhoREprWjJ4?=
 =?utf-8?B?eGQwa0tnWjNnQXk4MktvbkpPMnFqRWRFRkJXRGZjOHRsUVd4TEpNVk5yT282?=
 =?utf-8?B?WjNMMllkL2hkeTkwdFJTSWJVTUxOWEdaaWdOUHNScVk4SDVaYkp5OS9lSVZz?=
 =?utf-8?B?aTZMMEFOTGJ4bmhjWG5LUC92S291cHZXZ0w4c3I2cXB6bFg2SXY0NzVDM25G?=
 =?utf-8?B?R2Z4TXdhRkxtUUVDa2pqRUprbHVPcmdOZmlNZGhQSXJRN3FrS3hKcmU2QlBp?=
 =?utf-8?B?MG1XT28rZnBLZFZoRlFLS0l0OU9rMU1Nb0c2dmlRWEU1b0RwajF5VW9RVWdH?=
 =?utf-8?B?VFJ0R29PU1RuVjdMSTRJM3ovVXlUbEdUczZKYUx0QkV6VzdGVzhTMU1iOG4x?=
 =?utf-8?B?b204U1dzQ2pOdVY1OFd5UGx3bDNpcCswZU1zb2VBaEpuQzdoL1AxdUdTOWQ2?=
 =?utf-8?B?V0JpVDlZU3puKzF0ZjdvbmlnZVNKRXpuU2lWWU5zUW1ZeVpYYWJhUVUzTC93?=
 =?utf-8?B?NWlBQ3AwbzVTVTlpRGhzMko2N3NRNWp4VXphanh5dUNuVEZob1RKUEY1bm1a?=
 =?utf-8?B?M3NoMUFodDJrUnFMRUdTcnBlaXVTZGJITFp6emNaZVUvdERhdjhjaytBN3dj?=
 =?utf-8?B?Ly9QZHhzQ2owVUhEUTlNUVpuV3ZWQmU2a2dlbGRrS1hBQU1UOC90b1ZVREoy?=
 =?utf-8?B?b2hDUXlPdXhiRS9PY0lNUTFidEcwMStwenQvaGlwY2ZZMktDK1Y2WUdJUmFP?=
 =?utf-8?B?dzJLVWhDRG5sVkcvdTZDa1RBaldvMzBEamt3Y3oxRzZLemhuaEVRSDdWMTdm?=
 =?utf-8?B?T2cxUXNvY2doQVlLN2NlejZ2bUhsYisrbTE5S01LQnh1MHBWdjNnMTAzZEs4?=
 =?utf-8?B?RW5kdkZyK0lWZVFEaUVXMlBjSTRmeS9hR0xONjl4Tzg3NkpqK1A1RnA4Y2dV?=
 =?utf-8?B?dVIrcUJOTkdwZEhEREVDU0pycGFhRmxZL2lnN2NndE1HWmpBQnNGUm82Nlo5?=
 =?utf-8?B?SXV2bkl2UGxSTkVaVlJJNllsbCt1WVorWFdKUmVudFc5TGVuTjBFOVdxNDlv?=
 =?utf-8?B?dmlmY3FReVlDcGFWK0JkNk1BRG44Y2pIMUd1S1RqWldsbUVURkMwL09mMXRp?=
 =?utf-8?B?SGRtUFEwK3ZpNkNGNDlPSUl3bnNONFAyKzhRYUllcXRORmZuWHJIL280RzJH?=
 =?utf-8?B?amtoRUJxMEhGYVpVWW9ENUVEZk5BTG44WkNXakpIbG56ajhCdlVlRHJZb0dG?=
 =?utf-8?B?YS92ZEJBWnJnc0lLMThlWVFZSFM5N0p2RkFVTkppdWh6VFV6d1pkSG1jTTNq?=
 =?utf-8?B?RG1VOXlYS0w2V2ZhbHJnWEZ2MVZhdUVienJ3aXZzeG9USG5OWmJZVkpTamdq?=
 =?utf-8?B?czlUTEFMa1E0b2MwWWdDZ2pmTEcxUG1mcC9hUnRYSitrMEVybnJHOS8vYURW?=
 =?utf-8?B?bnJoSlhqSGcvMm5aZkJKZGtkSTVGaWcxZTViL0dHTFp5bWdSd3JpSlNSMzhz?=
 =?utf-8?B?L29sZlVmNkJTLzMvbnpMR3EzMTVxRk9ZU0N4N3dFQkVsQm9iZTlCKytyMC9v?=
 =?utf-8?B?WjdQTTcvbXcxRkZjVDlBNkVCek9YWFJhSDE5V2NybmdZQnM2ZVpDZ3RrMzQx?=
 =?utf-8?B?Z29QY25VdytHS29NUks5WkpFODlUcUZxaDB0dmZmS1VENnh0NG1PM0V6UktV?=
 =?utf-8?B?WEhTVndKQ0RnVmhUczhoYUVaM05kREMzK0N3eW8xYkpoWkxRMHhuRk80ZDJh?=
 =?utf-8?B?UU5vd1FSRk5IU1BmRmRXYTJST3o0YUl5VlZIVktTTTkyY2dTb2VGa0JBSjVL?=
 =?utf-8?B?WXN3SGVwa3lMRFlDQlFmcnUwRWRHa2pITzNIT1puUGQ2SUxXSE92VXBMRmVO?=
 =?utf-8?B?ZHBBc0YwVkdiVEE1T0V6L1lha2JURHcrbEVvNkFLamd5Nnc5Z1VkOExaMFha?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ccf682-2963-4ba5-393d-08dc6488487b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 17:59:27.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOBW/t2jbNskG23jYVMpDlh7LgM+XyvDGHiGxntw/Sq4hugI4ZiAXmYvpr5xvkSJ3b//8YoK6RXgJ/2EUiTiL0nt1OJPNaqTJSh8wgSrLj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7345
Received-SPF: pass client-ip=2a01:111:f403:260f::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi everyone,

When making an external snapshot, we end up in a situation when 2 block
graph nodes related to the same image file (format and storage nodes)
have different RO flags set on them.

E.g.

# ls -la /proc/PID/fd
lrwx------ 1 root qemu 64 Apr 24 20:14 12 -> /path/to/harddisk.hdd

# virsh qemu-monitor-command VM '{"execute": "query-named-block-nodes"}'
--pretty | egrep '"node-name"|"ro"'
      "ro": false,
      "node-name": "libvirt-1-format",
      "ro": false,
      "node-name": "libvirt-1-storage",

# virsh snapshot-create-as VM --name snap --disk-only
Domain snapshot snap created

# ls -la /proc/PID/fd
lr-x------ 1 root qemu 64 Apr 24 20:14 134 -> /path/to/harddisk.hdd
lrwx------ 1 root qemu 64 Apr 24 20:14 135 -> /path/to/harddisk.snap

# virsh qemu-monitor-command VM '{"execute": "query-named-block-nodes"}'
--pretty | egrep '"node-name"|"ro"'
      "ro": false,
      "node-name": "libvirt-2-format",
      "ro": false,
      "node-name": "libvirt-2-storage",
      "ro": true,
      "node-name": "libvirt-1-format",
      "ro": false,                        <--------------
      "node-name": "libvirt-1-storage",

File descriptor has been reopened in RO, but "libvirt-1-storage" node
still has RW permissions set.

I'm wondering it this a bug or this is intended?  Looks like a bug to
me, although I see that some iotests (e.g. 273) expect 2 nodes related
to the same image file to have different RO flags.

bdrv_reopen_set_read_only()
  bdrv_reopen()
    bdrv_reopen_queue()
      bdrv_reopen_queue_child()
    bdrv_reopen_multiple()
      bdrv_list_refresh_perms()
        bdrv_topological_dfs()
        bdrv_do_refresh_perms()
      bdrv_reopen_commit()

In the stack above bdrv_reopen_set_read_only() is only being called for
the parent (libvirt-1-format) node.  There're 2 lists: BDSs from
refresh_list are used by bdrv_drv_set_perm and this leads to actual
reopen with RO of the file descriptor.  And then there's reopen queue
bs_queue -- BDSs from this queue get their parameters updated.  While
refresh_list ends up having the whole subtree (including children, this
is done in bdrv_topological_dfs()) bs_queue only has the parent.  And
that is because storage (child) node's (bs->inherits_from == NULL), so
bdrv_reopen_queue_child() never adds it to the queue.  Could it be the
source of this bug?

Anyway, would greatly appreciate a clarification.

Andrey

