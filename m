Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6159BCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPG4I-0002Fd-Oh; Tue, 19 May 2026 04:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1wPG49-0002Ev-NS
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:44:42 -0400
Received: from mail-northcentralusazon11013066.outbound.protection.outlook.com
 ([40.107.201.66] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1wPG47-0003tI-Mb
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:44:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoyJvM7WElRFbGSjWB7BysTebHEBAmynBrmuTW0rzRTQnq7q61fVGsXA4ByCdpRQ0qg4ZCtHzdbibnFOFpb7gL5gI+3M8JMv2lpTf863m2bImF8dvOtqhX4YaIpT3p9fWJLPg8h5d3bip1tRc+omdaqmxta7C3gQiYG6wOpCBiJR0BXl7+batORlPF+/CQtZei5OWNKnFu9l9oF1aJvtbxQXirYQp/GnOT2Gvgs+uc6M0E+GTOL/iZeA0nypXOvAXvFvlw1i+gosde/ZLvqkji0sf9ES+a7HtUgspEkx9XCMOJpZysPvX7xB6EIfWYQzmgDz/1EaC/351rE7gHjktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGQ1qr25uWRB+HWYVcKeDjEVarM4AS9mCZymFywNnaI=;
 b=KGOzYsm0IhWpSghlpVK2j99s+QEh7sls9AEkHR+gu71Ms/ZSQdwXWQE6TcnV6cZCJbouePWCZnon2Eu4YbXWHhmCeiKw5JNtAF5qUahKE9ct5MmzG/nN4/GDVTvGD9a6PfTzrr9vevG2Tq4L8X9N+1xPfPoZJcIDWmyGDOdMhnzb5bZE4j7Rjj1CPkqvcO0JgmzmbRpY/X+sX5DT+SGx3LT/OJIehxMa9hxv1kXBDAXpyczp2/vJoWZ8/DGyymhDYrhe6fyAgSkUNEH2/IzgbF82m5vzymXTQJ2Lt4CqtdwkbNsa1sYIYYo7VFrRQdfNHRZFivdKyNax9Ut50xMzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGQ1qr25uWRB+HWYVcKeDjEVarM4AS9mCZymFywNnaI=;
 b=rze2i6T0fSLC62IBrM5kPwANbCDRcxC46sChJ/EplnaC0a26WtlQi9V86cb3Bo2Ce9QaQ+oieygKrNJg9PH0+t1KazHiF9JuuV6UqseUeHdg7sFA4nKUkB43pW2NcriFG19a7UjtH4E4NUOZYTnPgUrO0VxSRdwze6s7wgmcPK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 08:39:32 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 08:39:32 +0000
Message-ID: <fd118597-ec7a-448b-9d34-ffa99d93f43e@amd.com>
Date: Tue, 19 May 2026 14:09:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] amd_iommu: update PA, GVA and VA size macros
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-3-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260511123937.32743-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::9) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2a2c6d-f66f-4962-45ba-08deb582262b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|11063799006|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: WTtEd8bFTqP78kR7us1CfhA7lF7thzAvLw8eta3cEh2/dy79LIw4XgHHzOP7ak0Vr+LFOQ6ksLlKr+rzi2Q2fG1DpNtyVBbV/Bpqrd2A4u/qGgVPqypbok7RzPHErRauCwLZDMBFgnAlOLdKP8GRY9SsYma5CM20arFxhFtZxQvTCHfTvcrJyOhRaKZrSEGMy314rab6yQ8lwflQ/b38waP17TNjd7HCMYJnQFPD+08amJ5ZCOEXVjO8lG4nMB8VMQ9CzQy2BgQaAizOr8Dw3dn3Hh+lvfqHHUTk9nC/X9k/BD4UCeHLMTp/e1cS0r+2A7ieH4arY0bzAusMucaZXEzZ5YEgZklWWd2yUGifG73ok53DWQFCKVYhfEtZiIpzflaQhQDdEPoO/a5uajIhxIutSiFX5hQk0/mPBk2XWrN4N/BcaYwcB9+DNv6k3/rFwKLUeoRgXOHzFEQzrPHyyMYV0dGr2aPMeKxqG4fCfN9cNFzwmT8nYIA5D6Y7MDFaTcRXYu3L+QxHAGOZszFTHzYSBqqCRSCPqblMAuPWta31wKEDCLGOwxfMwbn8pfgbox5Jg3iM2acoGp2t9JJ4qxF32YfGPEU3nCJFUvhdFhculvTuu1b55QlWVP/KN3zaGJg/8T20kQ3uASKwhudBAa16igQ6CqeQULWoqDMPPR8A2cBFfz4BTW/TCjSmhzpghW+iYlovpCCCXFmMjSTO+zj7o5U4B7PvUwlYLSXB46Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5766.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(11063799006)(22082099003)(56012099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU4rWVM2bVlPYVh5OGJlandJM3UvU0I4NjZvV09EZ0dRZGROQlRyYkVxNFc0?=
 =?utf-8?B?YzZZbHFOZm9XK3lFTzBlZ1FaaEZLcTN6YWRKTFZsK3FBNnlBRVBIWnpkRGFr?=
 =?utf-8?B?YW43cnB0MWpFcXNqNUtOaE1tMW9rWHprM0tVLzJmeXI2SUp5UEJ5azJPdFFP?=
 =?utf-8?B?dElyYmNxV2llUm9hZXJHMWRzMit1L25pMzJBV21ZcWJyQm05Vy8xOFl4OXkv?=
 =?utf-8?B?cXlzVjl3TnRkQnh2dEZBa2RTKzNldlR2WEowRXU0S1BIb1dINWIyT09JNW50?=
 =?utf-8?B?MmtQZW1hOEtKQ2JiWGxEK0J4S2t5K1NyaUpMWUFvUUVKdTFiclNUVUlrKzE0?=
 =?utf-8?B?QzRNMVpndHRIdmlHTE95WjRBOUdVckFIOVpJTjR5T1lIZU9rWVorNXk4S2cy?=
 =?utf-8?B?Qk54a3dHem5uVDZBWUZrSHJRKy9PbDVlRzlxMzVGOUVVdGM1WWRhNGh0c2xr?=
 =?utf-8?B?RmFVMEFkeCtHclJ3anAvVVhHaDY2d0RZVzlZNHFwb2d4V01MSEZRdGhlNndP?=
 =?utf-8?B?czZOa2V0cUdnNmxDblJFMDZ0ZHVlMDFWM3hndUl6a09sTjREczZuNFRGeHQy?=
 =?utf-8?B?bXBBd3FBVXprTUZrVlNxVjA5Q3RTVURmN2t6di81MjlRQkZHc0pUMFlqZG9s?=
 =?utf-8?B?NGN3Y0FnZlVJeEVLeitDUjhmN3NpRUQzWktIVzBvVUZlcFNxV3dXeERwWnkr?=
 =?utf-8?B?WXpVejU2a3FCQXRyLzRzaUpsV3ZqVEFCaTdDREpiZlNSWTBzdCt2dVNraHRo?=
 =?utf-8?B?eVE4WkFta05ydWIrY0JnNVBBMWRVQ1ByN0xPK2YyWnFTVzVkSU9CZW1RODJi?=
 =?utf-8?B?ZFAzK0EvNUd4VHpvekM1bll1ZmZ6SFZXNXRVelIxZ1BRc2VqeHozeWZ6UzFU?=
 =?utf-8?B?aUtCMk5KaW5rcnFxRXpJLzR2N2g3c1ljRWU0RzBCNzNKb3lQdVlyTFZNS29m?=
 =?utf-8?B?NzJhb2FHbmtjOFp2NFBTQWdNT0ZjdmZxbElhVGZMQWw4UXlreHJRTXMxdWNN?=
 =?utf-8?B?MXRuQmtwVlJZVVdPWTZ1WlA0M2xPSDE2NFN6MUJWTXpoeFlmaFFnQ1RoMWQy?=
 =?utf-8?B?cXFFQ0FRYWE1b25UUjZFdllUL044MGxPTWFOYXliczNDWXBsNFA2aG95N01U?=
 =?utf-8?B?R2pWdjlISXkzZUZSSkRHYmJFcnR4bDZKYlU4SFdUbkk4OWdmR3Q3QkZSNXIv?=
 =?utf-8?B?b0dWQWpaczJVZU1QS3h1R056b1FYSVBkQW1KUUFrOTk0ZlpjcTdBTzI4QTZq?=
 =?utf-8?B?L21nMllieVM0WjV2ZDROSStvanQ0dldQZTdYMEQ3emtnT0orZHB2KzgrUDZt?=
 =?utf-8?B?MDRrK3FJTHc0ZC9teVh6NG8wQU5kYnRpMFh1dDQrWkN0MElzaTFJbjBGVzJq?=
 =?utf-8?B?bHRUQ2JNM0xzcFpDMWIwY2ZFNThwTUprK2RLYWEyVVlWdU03cWRKT2QzOUdh?=
 =?utf-8?B?anFCZ1M5ZE9XTjk2eEREam9ybEVLS2RERUNVb2oyWFkzQUdUdXJHTWRhNXpD?=
 =?utf-8?B?dDZ4ays4UDd0ZTdpV2FyRFB6WlhmbHdyREJMY2NjUzFpbk1zTTZYWXo5NHFm?=
 =?utf-8?B?UW9uZ21CS3dDbXVoREVBRlVzY3o1THRvOWg2em04U1dtM0JHVXdPSkpFcW91?=
 =?utf-8?B?SkVoc2d2SW53NTRYZWdFaCtXWjkybzVGVkFOMElLSDNkeXJZbFYzTGxaVmNP?=
 =?utf-8?B?S245Mis4TituK0QyVndQcitwQ0o3RzhweGNvZUtOdnYzYVQrVU50MlZEOHFk?=
 =?utf-8?B?ZTh0aFJzNGFvOUloQ3p2TTRTdDJnRjRmMzdRaWloS1RCOEM5UmpLQjdBRWNV?=
 =?utf-8?B?Y2RwSXdNUnB2M1hnRk1uMTF6YUdmMU9iOUltbnJ1aVNHUm9yaDRMNGpSakM2?=
 =?utf-8?B?cDJJODB5emcrZkwrN216MEtpNnVVZ2x2cEQ5Unh1dm9RbERhY2N1bkdCd3lw?=
 =?utf-8?B?YmtkUzU3Q3A5MFpHc1Z1a0g3c1FOSVFwQ3VMcEJZVUhQS1FTYm5Ua05IK0xR?=
 =?utf-8?B?UUdHN3MydE5wVnUxK1RjVncyTGVmZ09sTmxUV1ErVjRNUzdaQUNOQ0k1TUMy?=
 =?utf-8?B?K0tSRGZHdlI4djd4VmhCdituLzlFcDc4aHBTZ04zcXhpZVpxOEpaM1pJUG42?=
 =?utf-8?B?aWZUb2ljS08wcm5IZHh5WHFibVNwWnNLUUdlNDFSSmNuNnhPMnlyT3RaR1A2?=
 =?utf-8?B?YlA5K3BseVkrTk55WUgvQjJIMWNDcitjOTBsckQ3eVVvYUhaMndQMThHZmFO?=
 =?utf-8?B?MFVKYmI5N0tyZzdKS2E3TUJlZi9xVUJPYzl0UlhmNzd5bW96dCs2U09VRFBI?=
 =?utf-8?B?S1JpaWc4TGxPbktLa2tSaEVxYkNMYms5RDhPSUlaVU9SM284NDU3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2a2c6d-f66f-4962-45ba-08deb582262b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:39:32.5389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elOQRcGMimQ9KYpSRkcmRjdXFbV8huJ1nAsrWoInwb4nTObpctO/CJ3lPeZ2Qo5wUn8XGRsSxhXELU1543887w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
Received-SPF: permerror client-ip=40.107.201.66;
 envelope-from=Vasant.Hegde@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On 5/11/2026 6:09 PM, Sairaj Kodilkar wrote:
> Current implemenation supports upto 64 bit IOVA and upto 52 bit PA.
> Modify related macros so that guest can see right size.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


