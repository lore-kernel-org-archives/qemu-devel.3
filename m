Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E54EC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 04:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKUuD-0007kC-M5; Thu, 29 May 2025 00:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKUuB-0007jm-K8
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:30:11 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com
 ([40.107.223.60] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKUu9-0003Bk-6C
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:30:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpXBd6N6QfLl9R4EE+pRtLbyG60OYe41vLiv7AmouFyo2VmnItsaXaoFz9PO7kazVJy/oImFZMr9EVNjxNBd61A8n3289uIZDwsXX0hv/afFXJH0X7W+07l3EwQs90BJYSX4+kxBmIQTrEy9vcwkRN5YbzThsdTWrdCgokvz6FUGAq07rz3gmuFoazhkHBi0EbkYSgcMo+Sq5JIeWCHW3Af6S97OUNLcTGWGGA1LDuGMMVce2QE3EFlkagYCHHf/q/Do7+1vX6dSl/9r0tncFAI8vKxS1L3Gh5l3UPDiq7qAmz+lwwCgBb+gxK0ZiUI42MawQ0SM4LV7bMEjy5PSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYTQFtRLU234XndVsrKr+pu8hjNxR7e7UgutcBX/oGw=;
 b=uWeUiG/V+94Me5EV9AMdunCfmGR46naNv+x5e4Sd0RKll/j1yELRp18TRlekKeiSbBN+T1hBelVU8FheLTiaqOqgk3vYV6axM8ccp3vWObNFyrgcuTtBKTH9ZQ/2G70ZN1fvTwybUZq0V+ovj1s2xw8dItpbTnFs22n0PgdZdOPpCEHRuIbpy4uOFf/jIdsj4ydCN6NMcFK+SZlU/6cirLi77dWeldz3+OBXlV66dHNioXF4bDmHa4iwlg9kuueM/wKdsy3kmSuzB+PZmeG15RXgagPNeyTuMGMUrWbn8vdRPaPg2o4ZNCURoeazDsJCCm3O3IbXCx4f/SqwfihHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYTQFtRLU234XndVsrKr+pu8hjNxR7e7UgutcBX/oGw=;
 b=gXbJmrxzJ/BvQqKunJ83YHVp5p79C7wzTwB+Dv9Zw7vpDkm0SsB6WcG/3e+5tvWZb8GFnX8BgWIgFnFk79eqQN5ZfJrX5Qiz0GDhqa1utP0ZDvnLJSXEXSWPxn6nQuUJ10SWyJh5pW4g8DUKgKgjG2FE63jLFrLRCeOukSs/tEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.24; Thu, 29 May 2025 04:24:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 04:24:58 +0000
Message-ID: <886f429d-2a47-463f-9927-26a9f9eb423d@amd.com>
Date: Thu, 29 May 2025 09:54:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] amd_iommu: Remove duplicated definitions
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
 <20250528221725.3554040-9-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250528221725.3554040-9-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4c983d-2cb0-42eb-c8b1-08dd9e68c577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OElJeExGS0dzbzc2R09LMnhYNk5GbTNoajR2Nll3TGMyODY0OXlEMkdmUUFF?=
 =?utf-8?B?ODQ2WUdXa1JaYlg1SERKemlnVmY4WDRKOEFJWHpEWUMxOTh3ZW5MMU02Qmw0?=
 =?utf-8?B?QktrR1N0STUwdGsrb2Y1NmlvOVVSY1ZsVHcwbFNqUWNOK2hKYktFeXdyZUhw?=
 =?utf-8?B?YlJmaVlTZ1g3MFByTmNaRHA5ZU0rMTIzRm5BUXdDKzRlWWtuWnNVY2JRT3lC?=
 =?utf-8?B?WjVNb1hTRjFBb3o1N08wYWhQNkdPWmNVNC9QSC9yWEN3ZU41U2JaZjNIUTBz?=
 =?utf-8?B?a3ZQaWFUSDQzUEpUc28vUG9US1p2WEt2RGxwNEFJSXhLb0JoSXdhRDlTd2lP?=
 =?utf-8?B?a1BUd3hjNkF1OTJFUXh6djFjSzJhZ2hMd0EyK3F5ZUt1K3FIckFMOU1BbVJo?=
 =?utf-8?B?ZXJXM1B5VTl6a3FaVFlRUmpNUVpwY2VGT2VnUVBuVjBNanlZbnZ4WkNzZjJ1?=
 =?utf-8?B?K1VYSG1XSmNGVlpjdU1pZTNsTS9peUJsTkNmRlJpWUUrb3JuUTRlcDNWOHR1?=
 =?utf-8?B?TDZNdnJUeTNHU1VMa3ZQTFRxcU5aV2Z6L3dLenhkN0JTaVZRYlpaWlBUS2ZY?=
 =?utf-8?B?K0d5WFVYWjArMWpxaWJ0M0tsNDNoMjhjM0V3V2tPOWZkc1kzZzg2REpvakJS?=
 =?utf-8?B?TUNXdnN5WStqNDBQYjhBcVpzaEdJU0VaRWgrVXhQQkc1N25VeklOUnUwUCt4?=
 =?utf-8?B?dkhrVTFXVnpQd2xKc1VERjh3eTJxQ1k2b3E4UzRwT2RjVkg0ZDJvclI0VlQw?=
 =?utf-8?B?NENYSzBpYVpFd1dDVjhpVCtGcXZLa3FDbml2akZmcnozVExORHhtUURsK1hv?=
 =?utf-8?B?NnpUbEVkalg1aEdCWGRFUFJseUxnVEFvTHRFL1YrQmo0ZHN3dkpVN3FCSVla?=
 =?utf-8?B?NE1ZL3I5bm9FeVBuS0dnakZTckUwY3pEQ0tZMGU2NjRzWStEOXV2RDk5b2Qx?=
 =?utf-8?B?eFY5WEFkZHBhanIwMTdOVWVHdUgwQ3FZc0tHWUt6dll5UWw3eElENHhpWU5M?=
 =?utf-8?B?NzZkVDdGT2ErK3N2Wmc3aHNabnpUdXdrLzIvMk9IQXM3bGYraGFNVi9wNlNF?=
 =?utf-8?B?Q0pibU9XUHVKVTNhTEpZY3JjWUtMd2ROQ1kxdnFwQmJiQUtJa3lHV0p1dGlS?=
 =?utf-8?B?bjNVRkRMSXo3eVlFZi9INzZ4eFIrWEZYSHgxQ2Y4UlRwWnRKdlR1VC9pY2Jr?=
 =?utf-8?B?Z2s1cjBIaExVRlJZYnVFdkN4dGp4SDZmOUcrcEpPQVFXV3lYRmxsdkJ1U3BT?=
 =?utf-8?B?TVk0V2tMK3hQbFYyaTBPZTloN3dqbXQya0oreVpRN1NwV0F5QW9GZXFPaDBn?=
 =?utf-8?B?SDdDOHpoUE1oNVBONzhmSlhXSHQ4WDBIM3R1TXlsTFFVcG13SDR5dDhYaG5z?=
 =?utf-8?B?cEdjWlVQY1BPR3JBSmk1SWljSWQ5dFRXczl6NXIvc0VkbWxKci83SzhPL1lK?=
 =?utf-8?B?bGJtNlFZWUFham1tcml3ZERISndZZVBCV0NnZW82Nm45TzZoWW9YRm1NVWZw?=
 =?utf-8?B?cy9GS3NWVFpCSHNYd0dhdzV0a2dMN2l3enV3SHU5SlZVeC9IWGlGOTlSbjc2?=
 =?utf-8?B?UDF3bGVYMStSazNkWGU0SHUrRUlPMTk2M2lDeFVkZDM0TE9ZRnZiNVdpOHVO?=
 =?utf-8?B?QllVVEZqRGRoK050NEFLQXp1Wlp2bUtlV3pNN2hOOHg0Q3Z3aHhYMkh6WHBD?=
 =?utf-8?B?OUtpb2hEWU9YRmZuWFY1QmVlMUdnR2M1eFNBcW4rc1JCNHUwVit0bGFxZ1da?=
 =?utf-8?B?Q3lablR1SDNOdVBXQTRIbUF6d0pybndjaFk2U3dXb2g5U0Y1QnFsM1pUc1hF?=
 =?utf-8?B?RENZVUlkblRCN0NORVpWb25YcUZLYUFEVjBUYmNZQnQrQ21UQUlZcC9OanBn?=
 =?utf-8?B?MUdpLzdMejgva0FoU0JKeC9ST3NsVEdUZjdWZ2phb1AxMnBLNVJkYURGbkZz?=
 =?utf-8?Q?URGPJnqY0JQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWkrVnFJSU0wNGlYUFFuQU1CQ2wwQWRmSDJ1aE9PdDVtUE9BT0FYbWQyUHU5?=
 =?utf-8?B?NWpTVDh5d2lvb3d2d0R1TUY2aW5ydUZkWGFoMWZ1WVN6U0lVQU5KVmtVSjNZ?=
 =?utf-8?B?anNsblUwMUFpMGxDa1ZGUERBM2NFNko0cjIxREI5aVpKc2V1Q2RRMFkrcjFE?=
 =?utf-8?B?eU04YjRvakhXaGJwTVYyZHlGamY3dExFK0NYc0o5Y3dobnphSFdtUTAzQy8y?=
 =?utf-8?B?L29xbzd4VEtiYUZ6WENUZjdGYjN3bUxvdm1iWEY2OTEwSnpaSVhBMzZJZkVx?=
 =?utf-8?B?UStiU0d4RExtdzNMaHZ4M3U3cUEvclBBZVIvUXJnci9PUGNXeHlRK0g5YWZq?=
 =?utf-8?B?WnJENkloWHMxRk5qaVVPck9UbUxMQjNKVkRicFNzcC9GdlJvYzhYTHBIdS9N?=
 =?utf-8?B?aXRTa1p5b2x0NXhFUGcza2xZZmlKeFFPUEJMcjczcVcwTTc1MitqcXdOMjhT?=
 =?utf-8?B?dmpWdy81UWp1b1RKNXRDZzRQYVZ1bGdOck5aRnlrNXhqZXB6TDNaazZoTmxT?=
 =?utf-8?B?UEROVzlyUkxBLy90a09ob1hlOWZRTWpaS2RlMVh5Qzg5eDZNWXpua3I1YVRY?=
 =?utf-8?B?eG91OXZ5NGFYTE0xRzE0bVp4Wkd3MlRYd0VONnE1OXRsZ0lpOWJ4MnlRS0x5?=
 =?utf-8?B?b3Y4bW9wdE9XOHNJZ1BXY1JCMlZyUXFVd1lkNDBiSzlvS0RjV2dsVEt2SUth?=
 =?utf-8?B?MENodGZiMm1WbDNVOXRyR1pkREVSQlk5MWNIZGJnQmNyVm1EaHZXNWQ0VW9l?=
 =?utf-8?B?ZzdrVHRzb250cDVFeFRjaTNCTU0vcnlRY1ZHOGhLMFJOMzFKV0swa0VsMGxQ?=
 =?utf-8?B?cWlqN2pTS2JhWlhMNXhldG1FL2hETElsZFhYM1FhdHdYVHl2Z0RYZm9PVnZN?=
 =?utf-8?B?eVVVUGFQWWlrNVBBNTV2Rk5kd21MZEVoQmEzeDZESzNsN3d0R0s0MTVlOVpI?=
 =?utf-8?B?RWs3NTkrY2F3U3NqUDRPWjhIMVJzWWJLNk9MNS9yN0NmWHpOSiswQXFnQU1i?=
 =?utf-8?B?YzhEQWdmSHBmcEdtWXlRMytWMzBXRmF0Y2lLV0dXTUJVNGpObGdRcm1PZkRG?=
 =?utf-8?B?ZDlnbDQ2T0Eyb1pqajg4aDlGTTV4OGp1aysvUGVTZHhmY2xGbGJ1dFNPam1p?=
 =?utf-8?B?Z0V4RnRRS3BYeVZ5R1J5RkF0SEpyUit3OFlaY0NiQjBYdkZlenlhMDhvZFNO?=
 =?utf-8?B?MHJxRG84WFVzbFhVWU5HTlJLcllZeW9kN1BOeFZsdUpxYWV3SGhKbGl4TmUy?=
 =?utf-8?B?M1IxVXJEaERQTFdJdkE0YUM2dC81VlY3aFBVNnRKUlE2RjM2Z3V2c01xNW5i?=
 =?utf-8?B?dC8yQjZjTVV6Njc0aUlqb0wzVWhFYXpLRXhIdGFTdWx5M2ZlbmViQUFkcWhp?=
 =?utf-8?B?cjRMR3pjS3JuaWdXSmlJQi9KbkFJSktwRlAvSmpNUTdIZlp6YUhMaDhiRnpF?=
 =?utf-8?B?V1hHVllVeUN1dWFiOXY0WjMxa1FJQU9ZaTB5RldzcmMyU3QxdXo0dmFSbzN5?=
 =?utf-8?B?TmJ4eWJER2JtRkdOdnQ0eDNkdGxsSXlKa3NsdE1vQjhHSUNBdXlMRmRDbVZx?=
 =?utf-8?B?SzVGNFIreHhJQkFWSitFS3lpVGFvK0ZRM3pUZFY3N0ovdXh3SC9uOFB1cG5I?=
 =?utf-8?B?b2VqWFRUK3B3OTg0V0RwMExVUlFVZk50K2I0U3hsdDdXZkw4b3dvR2lqQkJx?=
 =?utf-8?B?b3J3amJXWW9GcXAyWm9oRS9UZ3hmaXp4bWFNM2JKb0ZJSVNjRXpjb2kzV2Np?=
 =?utf-8?B?Z3VLckQ2dUdZZW9NWjJnWnhGRzQ5anNUT0RsbElyTlQ4QkJYSzVWOWgxc0VG?=
 =?utf-8?B?Yy84eG9ZNk8vNko4cWlwbVlKdlpMYys2UGF1cE0vcEd1SFhDL01vU2dWaG9q?=
 =?utf-8?B?L1ArVEQ5ejNiK25sLzduRVFBNWhMdzdLL05NSzc3eUJydDFmT0dVQ2dLZzMy?=
 =?utf-8?B?bDkvckovSjhhYjM4akkxNHh0bk5ieHIxSjEzUkFDdUF3NWpuZ1N3Q2RqaHRU?=
 =?utf-8?B?U2RsRTMxQ0JpTGVTamVJNm45WVFqNWZDWmYxVkJMUHFZTnA2K093UGNhMllR?=
 =?utf-8?B?eW5ibitvY0thSmhtYklTWFRjQ1lBKzNSVVVTbW0yWDdxNndaRVZXbUpxT0N2?=
 =?utf-8?Q?8kUNnCumQ127cxfvp2LUfRD97?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4c983d-2cb0-42eb-c8b1-08dd9e68c577
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 04:24:58.6969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a2hZYKlpDHu5M0SuJ4qLx84J3C4qKwgNz7ECTXlMm4sShdz20Zjtqfs7RUw1Hm2wIUrqUJe3IvbLihmBwC0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
Received-SPF: permerror client-ip=40.107.223.60;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/29/2025 3:47 AM, Alejandro Jimenez wrote:
> No functional change.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

I had similar fix locally :-) Thanks for fixing it.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


