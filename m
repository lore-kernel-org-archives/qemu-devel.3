Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCB9CF6C00
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOnM-0006q6-Ai; Wed, 07 Jan 2026 03:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOnE-0006pX-In
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:21:26 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOnB-0002Nx-Ep
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:21:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lms0aFH6hJ8LDAJgEwHBsWFG/nwb4Vr5xmLxDO6CgCwwKGVK3iWJGZAP2KxNt+D8A2JNZKcsUQt9JCfDVdtHVJ3ghiZs/MqhZS4oc7r90V9RuaA7awUYlaEDQ8gjjPgCi/vLlSByfGIlld/XfbtkW2LAgq63c7mlO9I6R42ab3VEnnMFdl9sewhBLN0JbwFIlsfgolew8tj/BgmrvdjVGt27su2YJQ8QUdtqXp6ooHQcPrerJ1kkP0+tgzY/Xiss/P6QBMAJlqU37XWb8OMCEm6C9BQmEDr70QAf7o93DCnGJVSqzHAS3VMeaqSBAcTkxlIsCuNhKmlsHjMB0LsyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5Xx883rPNUghjqyORtC3GWCOx1nI8NNHFNZ8ewfXUY=;
 b=nfTSbl6GjedWceDv1lT4251XV5fWfaxIsElaqDjncTema0iYxASkYn1av0gGVlOqndjP1qFglmixafiDlBwMJu4m+0854C6qWHm5MF9UWwjmciecGK5xheFevBE+zqAbY6tKaCH3ag0qHsXxwk6tXSArxe4xngzDsddSKwTWa/eu+m9zBvw7ngapsp6h1de3894Gp4Dw1WHdF4lJyqRtdpZCGVMbQJ1ZLpiy2r64w843nZ5mVN+8g4u+p9LWx95OH/rEBerwLf4fGzVyrSR2k5VzRPWwH0peZjJSAPzmKMg1SyKSabFee8BI146/g47anXdlnl2bAyze1pBe/mk47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5Xx883rPNUghjqyORtC3GWCOx1nI8NNHFNZ8ewfXUY=;
 b=xp2dvKHqMFnhCHd0SPxXkTVMZ1gWOAemcJPrPi/bR7naB44oOWTE4hfzK93Zt9hSN4DR24EKhGBDco7ml1fTXaIh61SQKT2CuVDGLMD+XX7Fdp0BdZZh2jndQl3idAtp+z2LCN11NsbQ5p74hnQP/Me+r6wnJB4iE3tUgUAOZDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 08:21:13 +0000
Received: from CY5PR12MB6430.namprd12.prod.outlook.com
 ([fe80::2f12:4575:25ab:c44b]) by CY5PR12MB6430.namprd12.prod.outlook.com
 ([fe80::2f12:4575:25ab:c44b%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 08:21:13 +0000
Message-ID: <6cdbcacc-84de-4710-b85f-c877be6ca243@amd.com>
Date: Wed, 7 Jan 2026 16:21:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] virtio-gpu: Add ROCm capability support
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: alex.bennee@linaro.org, Ray.Huang@amd.com, dmitry.osipenko@collabora.com, 
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260107071858.3452614-1-honghuan@amd.com>
 <20260107071858.3452614-4-honghuan@amd.com>
 <aab424e2-a763-4d4a-ab73-62dd9b570b7f@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <aab424e2-a763-4d4a-ab73-62dd9b570b7f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6430:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 1890b8c9-fa3a-4dea-305d-08de4dc5b746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnlDdTgzQmJ1c3R6dStMSlBLL0dMSGc3RUt0YTM0SUV2VHFhazJaZHBmMnRt?=
 =?utf-8?B?Nytmc0M3UC92cHBWNzBMdzZiM0hCTVA3b1dhMVhIZi9IM05sT0tZZEZFQ3o0?=
 =?utf-8?B?c1NBQlNrSEZPdm5sa2pTUXUwa0ovTFhWbEZvRVJOUTY0VmJLTjM4N21LWC82?=
 =?utf-8?B?eFgrNUtCdHN2ZW80ZVJocmw0azRwMWhJaVlEYzUxQytWMDVmOXNIcjhieXh4?=
 =?utf-8?B?U2lZQmN3dmpJUk1vcG5zeHRGU2ZlSTRuSGVYaUlmN3BObFp1Nkx0NDdON3Nh?=
 =?utf-8?B?eEJmMTFWN1lkNFZmdE5UUGYzVTdhK2k2eDM0NTJCL2hsMC9ZREw3ckFVL1Rn?=
 =?utf-8?B?RlhxNlo1NDVrNzJNTEdCWjd6Nis2eVYwZ0czZ2JJSFdUU1ZCMVFtbVVpdVpL?=
 =?utf-8?B?YzRoR2p6N3RQby9tVldpSytaaDBWNWxNK3dSeVovZnZ3ZEkvRk12alNjRmZF?=
 =?utf-8?B?SmtWd2NWam9ZQ3k4L2R4REl2TzErWlJYMUoyUm8zU3lEYmR6QkEzRThzMjhB?=
 =?utf-8?B?THFocEF4bW9BbUhDRHpnS0hYODZ1QXl2czBaNWU5YVJIRkYwNVJPMXh6YXhL?=
 =?utf-8?B?bXZ1M1B1cXRRU1JlU1hGQ1oySFpsbTZ4Uk9YOStJeFlHUm56N0U5aHVxc2lh?=
 =?utf-8?B?bllTTHhyN1kxTGlyYkJjUzJDTTI4bHpleUVaNjBrMjgyY3lMMS9lbUc4eXR0?=
 =?utf-8?B?c25IQlBXbmtOZ2VWbVR0R01ITWYxK3NlQktjSlFFb1BkQVp5VDY4RlVtM0Vo?=
 =?utf-8?B?RGVPV3l6WWVydDVjaHpvK2VDT1JucWhRcHRHZEw0WVZvbWdQejRpY2xzRTh2?=
 =?utf-8?B?cWljUk82R3RrQm1TaXN6UFZCRWhnMUdGYStKU3Z5OFVRcUpvVFpHL3YzYkJW?=
 =?utf-8?B?NVhaSmR4dHM2YUhoT2RIUUp2WlZDWHNsSFR5MmQrTHBTdDQyU1JrRFlkTnJI?=
 =?utf-8?B?VWJlTSt0WW42UE04QUpldElRWVdCeXlJSlAvTGQrSVJkcVI5K2VHMXZGNUQ0?=
 =?utf-8?B?RVBoWDBMOXRZOFgyVFIxMmY1UkNzb2NIbE15TXMrUWgrVndkVDFYRmNoZVlY?=
 =?utf-8?B?eUZNTjIzNExGYlVlMnlCRTRFMHZNa0h6K2NaS09GRG8xK2YvbUpUaVVhcHZu?=
 =?utf-8?B?QjJUV2VvN1JObzNMTUtGNE9lRWJFUW5VejgzS0ZPVFU5Q0xxMU9rU1ZYSU13?=
 =?utf-8?B?alcvcnU4WHovYzI5V2V4YTAzY0dYcE4vMktWM0g0cEVsMy9rNDBudGgvbjRw?=
 =?utf-8?B?NHVrbUdjekI4ajZnVjRvNUdtT2JSZGcwMXpHUm5rajUvUnBIN0p6MHdEMHln?=
 =?utf-8?B?Uy94SzVmMitBOTlTT0ZwZEIxYm9BRk9UWWJ6OUZURmtESDBhblAwNlRTSkFQ?=
 =?utf-8?B?eG02dnBHTkNlV2pvb3F3MGgza0I0OFNXRzQxaUE4eGQ4OHppc3pZV2NlVEV6?=
 =?utf-8?B?T0NXSEU3WVRxVHZlT0QzNklONlJLcTdBMzJRMHplM3RtMmpjdzBZL1lVUXdN?=
 =?utf-8?B?cE52VHVGVCtBMVNjSTM5UTl5NjhlcldyM2lhNk1TbjlNZkFWaVdqN3QzTDNk?=
 =?utf-8?B?NCtNZFo1N3Y4KzFsMkJ6U2tlbkgwdjBTMko3eXM0M3ZJSDlNcXE3OTNrQk1N?=
 =?utf-8?B?TE1KdmRDTVVoblFOYkN4UFIxUEg3QjR5T0dVR2pYUmRnTXZsaG5sOU1vM2Ev?=
 =?utf-8?B?TlFhV1gyZmRzdVJDeW5wRlM5QllZMm5TeENUYzk0OVpkZmhWU1NtR1Q1bzhh?=
 =?utf-8?B?WU5VRG9rZzdMVFhSdjhpTFJuMktxTFFtd0JnVVllU1A4U2pUR1ZwN0FNMms2?=
 =?utf-8?B?dmw1eCtQL0NWVzd5QVNNaUp0TThJNnJhdjg5c1BMVEJYRWdiclRQSDluSUo4?=
 =?utf-8?B?eXUrblNhQ1BSaVZkdjR4M3c3WGNKMk52cGljc2NBV1NldTErdlRSTUVha2Y1?=
 =?utf-8?Q?cg2llFwor5+cdaZFo/zx3Ir04J35VtW+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hFcW1tZ0pmOGFDWnJVZVJDdWpEN09wTk1XRVJheVo3NHVMclRpc1Q3RVVq?=
 =?utf-8?B?TnpCT0RMYWVlNi9MVTkwUHNldnZxTVlWaFhjN25KWkx1ZHBNUG9CZ2pBMlpY?=
 =?utf-8?B?RmRrbXB1Rzg2enRSdGlFNlJMRk9SWWxINmM1M0pzVW5raC9sZ2tJU2M1clJ2?=
 =?utf-8?B?YmczcnE2YWsySnVKT1dnVmRqSjk5Z0F4UjE0YkdTTEorVHFZU0tpcTJsMFN5?=
 =?utf-8?B?c0dEY1VHS2pxWTFYbzJTK0xIc1dxbXBZMVdLcTZYOS9WY0kxaU4xcCtQOE1Y?=
 =?utf-8?B?TW8rSHdEZkxvYktsRUU3RmROZ1dhU3B3NEZxMWFNdlp3SXJZaHMwanlUeDh3?=
 =?utf-8?B?M2dBT0NNYjZ6YU5pVFhPN0M5OW5VOWNHVG9wSFhWNXN5THZmS3BvajVaamll?=
 =?utf-8?B?TXdyMkkyR2JEN2lFczBLQmtsVklUNkE3QWV4ZmozQjlTN0QxYXJxUHNnSGcy?=
 =?utf-8?B?dnkwNnpNaGZyTnNNYlpLc2tsVTY3bStMd1lZc3FBWlJlUGFWaVFvYlVyc29T?=
 =?utf-8?B?STZITGZyeGF0eTVVbndneFJ1ZkVTa0FSOElTTXlYcWM0NW1KNmRsM1FjRG9m?=
 =?utf-8?B?VzR0ZXR3b2xpZWljOUJaRG0zYzV3N2V3NWlRNTM2cXRIU1lsL2QwQWFuZUpv?=
 =?utf-8?B?ZUJTVG9VNkVaVitSK2RWMjh1NHhrR3g2bzg2TWFNUlgxTk9OWGpkbWFmWndC?=
 =?utf-8?B?UWZ3QmhlaWYxNGFrSTBVWHEzUkpnTTJCenR5RERRYUFzRW1jRkIwVDkzaFNK?=
 =?utf-8?B?ekpTbDdvZTZsT2FrcXExSmFOemNMN2c4L0hXVm8rSUhFTjgzM21NUG1xQkk1?=
 =?utf-8?B?YWVoazhQUW1MQzNuNStsZytDYmNXQlZYMVdUNjJzWnFmSDMxR0RUVGl4QzYr?=
 =?utf-8?B?TVNoUHQ2NWcyRE5pZERSLzA1ZFBCV3JiZkFOYVhKZVBhakFIK3dyamFiMHdG?=
 =?utf-8?B?akVIdnJjOHd2VDh0UVNSSlp5Q1FXZkExdWp6U0FWc3MwSEJYZzN0NkNvb3po?=
 =?utf-8?B?T2tFOVltSy9RVU5LZDFLdGk0QzRMNTZCMVMydE5NeVJNNkFMUHBBaDI1OFRP?=
 =?utf-8?B?aDFyalcrV1RQTzFqNG40SGg3cHFKckkySG5BNUJOWGJFV3loQ29OaWVDYU1y?=
 =?utf-8?B?MzhDNmozeHM3VWRuZUdwLzV4NlNKck0ybytKZW1tTnJyaFBFWDM2blVvcFZV?=
 =?utf-8?B?RXp3ZExUNXNiUkhBVnR5WkxTYXBPMW5FcWdGSDFwMFVrbHJscCtmUFA4bXdG?=
 =?utf-8?B?cTNiYk5GUStYZVJoQzI1QnUrMkxHa0t0KzQ1bDlLcWpEM3BIN1VPRStUZmo4?=
 =?utf-8?B?aTlZa3BEVHlYWlhML21lTzUyMVkyeSsyVmtKSm1NMnlIL1VrbEp0eFVZY1hv?=
 =?utf-8?B?WTdVeFVFaktkSGpJVUpVZ3dJLzZadEg4YnZROTROMGZCS2RJM3BzZVpBcU1S?=
 =?utf-8?B?b25DQTcyVHBEQndYVk1qaEJUbkZFTmpPOWNQRndCdTNHV2VlMnNDb1hLYXEv?=
 =?utf-8?B?RTNZNHVxZElPaS9JUXZuekh2czF6bXJYM0V5Q0pZLzk0bkVFM0MweG5NRmhi?=
 =?utf-8?B?VnlrTFoxd3VEeHNSU2ZqKzdaSDA4Z1RkRHRObXkrNGpMWldmR1NVQWVBdEFr?=
 =?utf-8?B?c1ZJamZrZzhaVVlJTEpnQVNlZzE1Y3ZqdW1HVW1WdEZpT0dGWWlwOTVLTWEr?=
 =?utf-8?B?d3U2cUc2aVFDdVBhYmV6WlhBMnhOSVlBVjg2UkVCazhpMitwNCs2bE5hY0Jn?=
 =?utf-8?B?M1NUcVkrWnlnYm1hK1poVGtpakltemdPRFQyZ2FILy9nZHUxNHlXa0pBd09H?=
 =?utf-8?B?Z2VLNWllZ2h5YjltdEFXbkM5eXdTempWVmxXWUFVTmhVZjN2UXFuRm5ESHF6?=
 =?utf-8?B?YzNnQjNWdlN0blo4U1QwQlFsVWZrV3VyV3FidnRxQlU5L0p6VXRmN0RIcXkx?=
 =?utf-8?B?Z3k1bkhlQlNEQzQ1RGE2Wnh6andJbHBGTFZiRzlCaWpIQ2hNeVp0QXNtQ3k0?=
 =?utf-8?B?U2R2eVY5T3FvQ3ZFeFFzL0N1Nm9Nc09HSXFJZWxOT0NHYjJ1akc3WjI0UFpa?=
 =?utf-8?B?NEtFY053N2dOT01Yc3lUK1JOMWVaNnYzT2pIaTZYVDlpMGVXdko4bUxUUXBS?=
 =?utf-8?B?K2Y5N1pyV0d1eFNUTTJGVjNVSzc3YXpJRUVoSWdCQm1BRkJrYUlDSzRoSDdx?=
 =?utf-8?B?OE1yTmh6V2VxUll3dlg3aTFqd2d1anFMWXp0NWpkQWpzczZNZDJiVG5WdHRV?=
 =?utf-8?B?d1BySEVpOXdoN05mY2JBbE1hK1J3Tko3ZWVGQ2g1WlJlMjBwdW42L1RIRXBF?=
 =?utf-8?B?M1dJS0JGMGhoTWkyTnRzWU9aRzlFUHlxRlE2ekcvMVBxVEVDeGRkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1890b8c9-fa3a-4dea-305d-08de4dc5b746
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 08:21:13.0400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVMCAnphmM49x1QyKFu4KbB6m5cD7o8FBrWR+GQB+1Hx7DceYj8p7jZYdulOVhe0eC+1c0yc+ISF6YunqetvXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Honglei1.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/1/7 15:44, Akihiko Odaki wrote:
> On 2026/01/07 16:18, Honglei Huang wrote:
>> Add support for ROCm (Radeon Open Compute) capability in virtio-gpu.
>> This enables GPU compute workloads using AMD's ROCm platform through
>> the virtio-gpu interface.
>>
>> Changes include:
>> - Add "rocm" property to virtio-gpu-gl device
>> - Define VIRTIO_GPU_FLAG_ROCM_ENABLED flag
>> - Enable VIRGL_RENDERER_USE_ROCM flag when ROCm is enabled
>> - Register VIRTIO_GPU_CAPSET_ROCM (capset 8) capability
>> - Add virtio_gpu_rocm_enabled() helper macro
>>
>> This allows guests to detect and utilize ROCm capabilities through
>> the virtio-gpu device when the feature is enabled.
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Really thanks for the review!
Will add RB in next version.

Regards,
Honglei

