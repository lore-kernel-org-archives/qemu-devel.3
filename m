Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43774CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcT2-0008K7-3K; Thu, 14 May 2026 16:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNcSS-00088X-VV; Thu, 14 May 2026 16:15:01 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNcSI-0002LE-NI; Thu, 14 May 2026 16:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD4Nc8aH7NSRzLtEaoMsgcG6GBzZENOshjXsF2LlmZpYEH3hby6G0ywJB39XPAHgcLSUtNgtvAqMZ8WID+HXNsBVk26xiBPqp1MkTOnc2/mUcDyG4r4C7hMoKmLhGS8NLwmWjmXj/2qkcLwUgYEKXFG96Mqqms2EbnHgpnrhMz9ZwXtxBe76rz/CK2FXHxmcJkuDhGUxOmI4u0GzosHpFrkmdttIQUG81PCbODooEnHsge48ypHM/rlT/N4TWUzCXkALucoIQU+7uIOqSz5S2QS19GJ+TBITpLYqXQrGVqeWhHfUrqjOLf6+vQgpHi/ThpN82rZUxgTuN6q/LbZ2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDP0h3w8SspvDYzLhXOdXmcGDfNeVf1vWBxZsgDw+78=;
 b=XoOL8IKF1GIEWgFXYCe6mJzbCvBrmzMeIWWGqlsdEdk8jU3hSzWKplU86HVNkTtmaVGxg4ywtxBzAOsWIwof6rTceOzQOrk6v/YMXVzJpERI5P5uHz+ysYXwBUJ/Pc8IXX5JB75w1OxcWIkYfrLCyPSNOB3I+9oPYThcb+avqiUkW20Gr9BWOK4gEN4UJiAnAd0M0VnPYz8NSjkGayLCj9l8q4PsNrdCDGrWOyO+yromPj6Rkx8tdaHgSktI/lXhmOzRsM1YDxR6xpZKcv1b71Op8dhqRY7PXqtlamadTTcn6GcPaqdmzDQXPH6Lh/XXtyMqgs7aL8vhXNef7RjLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDP0h3w8SspvDYzLhXOdXmcGDfNeVf1vWBxZsgDw+78=;
 b=BWGx2tS9y4hLM/Wh8t6WP+Inslp959GDEFPAFb+07tbSAWWljEjZPdm3qPiV4qsluCRw0ILSJ3v4ebipriTXwHMvf7k9i3Dzn7afoH6k2GKEOh/BV9RyC0P48RYCJlI2ttbIpYQqlI6e5PTYH/pwOHxVs7FLSb1ohIRwlyoHufVzi4Y6jI1LR3W5YVe95DGfHAIXb6kMeIfKUWX4ENSAN5ar52naFM7uM0exRFgQZ41T6AI/RjWDVRaB4/Ln1SydJd12Jv96RG3p4IgqkeBDOYh5z8mQhpAzTEqx9eqZTHwbHkmX72L5ScHh5/klve1f+om91Oj4qtHQcEk6Fd+Eww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Thu, 14 May
 2026 20:14:41 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 20:14:41 +0000
Message-ID: <b04586fa-51e9-4b8d-a683-8026d075f0e1@nvidia.com>
Date: Thu, 14 May 2026 13:14:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-5-nathanc@nvidia.com>
 <CH3PR12MB7548125AB6137EF2D9954810AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB7548125AB6137EF2D9954810AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f09ebc9-c0e5-4ba6-4aa1-08deb1f56e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: 1YiQWHUrmXzQ8e93bh09VMJs6aAUN+5juAWsiP0PMm5hDhv670wf66hXXrLMWpu5arfv2pHPDTT0E5nTyEPznYEE4bnihoUWkvnYEpv4CNwSiJG1Jwljy8BeYfwhu+zUqOTxMwsCvb68XexnrWfNtzbFhx8dRi7++4NXs3iDU9hZx8URZdM2pl9dxk72gKhxIBCDBIFmJardNaZsoTV8D/eCV4bDw1oEGYj6SzdPjGHJmkI2v9FOgcyxz5bIJOtmaT2QH06vEzD+ZOGJRX2/PGBSK9FfCoTy7jO4jIHRjb/Tic9mXmsLMmTELw0mdw8GaBhE7z8SWejYhM83Uqz+f3FhyDqIEd9A6ofYOTMy+V0iJUjMOk+s/MkOcKnEEuzWQiaOjpZMttUyuHZww/zkS3mhDZY3mwOoyNN1LuCQzpYI02ss0c7P6izW7ucqpH9dFn1UzWvH/Ad3S/+7f68RXyZmSQuLoDO57GsRwK7c0qkntOZzX/ns2+HyK/65dXc6BTjgCBIlPcGVM5aXWdT98/BE+TNxrU9GiIx6dxQbO37GZViYHkd/EZdGZD+3u+jEV4R9THi9ZxRnqIMbuLpJLl5REaqytoozTcapYgDvXEzaqJUJkasYkGGEN952UNkOSM6r3uXdoh3bUGvtEhZGL4ixiChTC1Kb8bAByhGdXSHS8FkwApIhdP09bcINrHSL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aURCdjhaSlE1Y2VxNUpGQTZTYjd2Wnp5bVZRTkJ2T2FPSWVkQmRlT3plbTA1?=
 =?utf-8?B?cVJEcDFoZlBpL3FsZ3JXU241SjhRa0pYVDZzcUhEK3IvdmR2RW0rUVpWNHVX?=
 =?utf-8?B?MkV1eUYvWmFpREdCdGtyOFcxNWtLdncwejBpbGpHczhIOHgrbE4ycURQQzBU?=
 =?utf-8?B?ZWpMczlJUjd3SGMwQXdySUI1K1h2UC9oMFl5N1hrQUx4V293bmJKbTBNQVRR?=
 =?utf-8?B?N3M5SlIyTG4yZ2JGZVlZdlZRUnFnY08rZ0tabHVqOWZQeXN6aEpqZzk4U3ow?=
 =?utf-8?B?UTV3djRWNjdlMnhFNkM5dy8yUjk1TWQ5VVdsMU8yYnNZQmcrU0lzQ3R0UzRC?=
 =?utf-8?B?b0FVZW1LdzNlMjF2WUJlaExWZmNqbGFTVHAvMVdYUHZCeDhSY25aRUs5bTF0?=
 =?utf-8?B?QTdPNWVqaTMzQ2krdk92Zld6SEVCWU9CUTBWZE5FZGh4MUsxL09ON1pZTHRS?=
 =?utf-8?B?T290Zko4SldMTHY1am5VempYU3FmaXN2MEtJaVBLYVRYbHRPZExFZ2d6SXR2?=
 =?utf-8?B?MHgrQ2ZoRk9pVmJ3OWV1MTF4WFRBbDA2VEhkaGY3M2pPNnR2SHlUbTB2MHA5?=
 =?utf-8?B?NW5EVXFEa2dXbnJWRkQwcEdJWHgyTStKMkZVQmZmSlc1YkRFWGNGdXRJUHVt?=
 =?utf-8?B?bVFqOFoyb3U2UzNSWXlZMk4ydUZ2N1J4aWkyL1FQamdyYWU0anR1QVhlY2M5?=
 =?utf-8?B?by9FM0s3djhHTzJjS200WTI4TVd5Wm1EQkNzREJGa2syRU5HY0NqbVJORUg5?=
 =?utf-8?B?eWxFcVhFWDFYM1J4YWJWUnRUZDRsVzJ3Y3F2UUlEL1hhYjFCRzgyTlFEU0hn?=
 =?utf-8?B?emVTdVFFd0JBZnp3cHJ6SDVneXFyZjQwdTBaQ0V1VXZ1ZENkVTRhTHlSNUJo?=
 =?utf-8?B?TFJKZmF6c0lHR3FnekZmRG80MGM2NGU4b0FVaXF6U1FlNkI1bFBGbElxazdV?=
 =?utf-8?B?cVoxZ0lXYm5HN3RETmJXeHZPRU1hbUNDaEdXbDZ1cXJ1QmxxcTh2SDIzYmJP?=
 =?utf-8?B?b3V6THVURDFpQXFtOW0rRWlXMHNTci9wU2FCV0dBeXpTSGg1QkV6RVRpQk1a?=
 =?utf-8?B?dDJwL0FqcFZpQ3dDM09qaUc5N1FBU1BzV2lEdmMrVm5WbzRCWG92OXU1UHJp?=
 =?utf-8?B?K3dtYmdIR2NnbmRaSnd3d1JSUCtwQUE3d0xFamRFTzVjRmNwWjdPTUR5czhX?=
 =?utf-8?B?WG1venFvSDh6dk5XUnV4YkhPVis4WXhDbFhCcW1kZDRhSnh5eWNnSTUzRVg4?=
 =?utf-8?B?Z0RqMDI2enBRNHIwMU9FSHg5QVR0bktGYktxRmpWS2VFeDFIK2liRXRwdHFh?=
 =?utf-8?B?b21DNkdUTGV4bWZCR0xyV3R3K2l3QzlCM0JXN0xGTFB5U24zd0VMR3l5aE82?=
 =?utf-8?B?NnJ3Mnh3WnVlTlc5STBHeGlsSmFUL0h6a2pham1BSElxMm12NmlMY2VLUEpw?=
 =?utf-8?B?S2M5ZGM2S1pVcVRabVNJc1R6VVVaQk0xTHEyVmdUclgrYXRjVWNWUUlxK3k2?=
 =?utf-8?B?Y0lZRHhXaXgxM1VYZXNFcXB4VS9wd2pkNElJeXhEVEg2NE04L2pjRzZWY3o3?=
 =?utf-8?B?aWc3RXNlV3NXWTBjZlJ0c3RkYTNadlFZYkhidGhtVXhYNU05bHBEb09vNVFl?=
 =?utf-8?B?RmNERzFyMmt4ZUlSTVpKOGR6TkluSGsyVXUzV2lRMnI3Y0JBM1NYVGgvZUJK?=
 =?utf-8?B?T2NlbUc2UEpsSjIwYUkrNGs2b2p1bGVlUzBFamFwNTRaYlpObG5xZ0dkRnJr?=
 =?utf-8?B?MjgrM1JrZHdkRzg3NDlWUWxlNG93TUdJQVNMWUVwWXlrR0g4UXNKakt6RHZw?=
 =?utf-8?B?bDFCWitjeXFYWFB5dU94U3BKSnBFV0ZvVVV6SkRheUp0V2R3WmtWMVN5ZS9J?=
 =?utf-8?B?RDVuTmEwMmFCOUkvaFNlRGQwOXRqNXZ6WUdDNW5kdU5LMnl4MHZOa05xMVhu?=
 =?utf-8?B?SHZ6bkpDUGFDV25pR3lHTVk1ZXVYbVJLajRRQi9RT21ieU9zZTB2R3ZJampT?=
 =?utf-8?B?K0E3NnpKMjA3MS95eFoxZjNzdFZObWVlREFFYjhNR2t3YUtySmJoVDNyRmRI?=
 =?utf-8?B?bkJaWnNiaUNiSlVFbzlrOENYazhIZjBtVTJ4cTV2VDRPZXFRM1hWQlNrd3Nm?=
 =?utf-8?B?S1NOTmdseEYzbHA5Ky9GTDNvYzEyTjhjdHI4YzFjOXA5Rmc3TGJEOUE5a0dy?=
 =?utf-8?B?cHJnWmpwYnNtU05YdEZOUG9xNitWbkhnMnU2MDJlMlBRNVhUTTlDTnp6cGlT?=
 =?utf-8?B?V245WGRGZVlkQlptSks5cmdYS0FuS2ZJTnNMUGoweWt1MDdkRTF4UGx4VGlF?=
 =?utf-8?B?MHZ0T0p1TUVrV052WTR0a2xPYmx2VWhyTUIyUS9vd2tpSVExUS9Ydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f09ebc9-c0e5-4ba6-4aa1-08deb1f56e7b
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 20:14:41.4802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhcpwe8oXP88FikRNZbXrFCiC9Q9DVNuwTKTBCitEjgHL2yF2iCf4/3QtVaBs81jFqD7VaicFGLOaoWOF3XD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 5/14/2026 7:24 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 12 May 2026 20:35
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Philippe Mathieu-Daudé<philmd@linaro.org>;
>> Zhao Liu<zhao1.liu@intel.com>; Matt Ochs<mochs@nvidia.com>; Nicolin
>> Chen<nicolinc@nvidia.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH v3 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
>> "ssidsize"
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 SSID size property to be derived from host
>> IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
>> retrieving SSID size from IDR1. When the auto SSID size is resolved
>> to a non-zero value, PASID capability is advertised to the vIOMMU
>> and accelerated use cases such as Shared Virtual Addressing (SVA)
>> are supported.
>>
>> Reviewed-by: Eric Auger<eric.auger@redhat.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 18 ++++++++++++++++--
>>   hw/arm/smmuv3.c       | 20 ++++++++++----------
>>   2 files changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index a5973bd499..5b1af062ee 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -62,6 +62,12 @@ static void
>> smmuv3_accel_auto_finalise(SMMUv3State *s,
>>                                  FIELD_EX32(info->idr[3], IDR3, RIL));
>>       }
>>
>> +    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
>> +        /* Store for get_viommu_flags() to determine PASID support */
>> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
>> +                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
> Nit: Not sure that comment makes sense. We need to update it
> anyway, right?
After ssidsize is stored in s->idr[1], smmuv3_accel_get_viommu_flags() 
will call smmuv3_pasid_supported() and enable the 
VIOMMU_FLAG_PASID_SUPPORTED flag if AUTO is specified for ssidsize and 
s->idr[1] is non-zero. Maybe we can remove the comment or come up with a 
better wording such as:

/* PASID support will be enabled if ssidsize is non-zero */

But this is already documented in qemu-options.hx. I think it would be 
cleaner to omit the comment here. What do you think?

Thanks,
Nathan

> 
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>
>> @@ -822,6 +828,13 @@ static AddressSpace
>> *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>>       }
>>   }
>>
>> +static inline bool smmuv3_pasid_supported(SMMUv3State *s)
>> +{
>> +    return s->ssidsize > SSID_SIZE_MODE_0 ||
>> +           (s->ssidsize == SSID_SIZE_MODE_AUTO &&
>> +            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
>> +}
>> +
>>   static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>>   {
>>       /*
>> @@ -834,7 +847,7 @@ static uint64_t
>> smmuv3_accel_get_viommu_flags(void *opaque)
>>       SMMUState *bs = opaque;
>>       SMMUv3State *s = ARM_SMMUV3(bs);
>>
>> -    if (s->ssidsize > SSID_SIZE_MODE_0) {
>> +    if (smmuv3_pasid_supported(s)) {
>>           flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>>       }
>>       return flags;
>> @@ -975,7 +988,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error
>> **errp)
>>       smmuv3_accel_as_init(s);
>>
>>       if (s->ats == ON_OFF_AUTO_AUTO ||
>> -        s->ril == ON_OFF_AUTO_AUTO) {
>> +        s->ril == ON_OFF_AUTO_AUTO ||
>> +        s->ssidsize == SSID_SIZE_MODE_AUTO) {
>>           s->s_accel->auto_mode = true;
>>       }
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 7ec4241ecf..cd30275717 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -626,7 +626,10 @@ static int decode_ste(SMMUv3State *s,
>> SMMUTransCfg *cfg,
>>       }
>>
>>       /* Multiple context descriptors require SubstreamID support */
>> -    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
>> +    if ((s->ssidsize == SSID_SIZE_MODE_0 ||
>> +         (s->ssidsize == SSID_SIZE_MODE_AUTO &&
>> +          !FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) &&
>> +        STE_S1CDMAX(ste) != 0) {
>>           qemu_log_mask(LOG_UNIMP,
>>                   "SMMUv3: multiple S1 context descriptors require SubstreamID
>> support. "
>>                   "Configure ssidsize > 0 (requires accel=on)\n");
>> @@ -1965,10 +1968,6 @@ static void smmu_reset_exit(Object *obj,
>> ResetType type)
>>
>>   static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>   {
>> -    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
>> -        error_setg(errp, "ssidsize auto mode is not supported");
>> -        return false;
>> -    }
>>       if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
>>           error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
>>                      "OAS; other OasMode values are not supported");
>> @@ -1989,7 +1988,8 @@ static bool
>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>               return false;
>>           }
>>           if (s->ssidsize > SSID_SIZE_MODE_0) {
>> -            error_setg(errp, "ssidsize can only be set if accel=on");
>> +            error_setg(errp, "ssidsize can only be greater than 0 "
>> +                       "bits if accel=on");
>>               return false;
>>           }
>>           return true;
>> @@ -2173,11 +2173,11 @@ static void smmuv3_class_init(ObjectClass
>> *klass, const void *data)
>>           "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
>>           "supported.");
>>       object_class_property_set_description(klass, "ssidsize",
>> -        "Number of bits used to represent SubstreamIDs (SSIDs). "
>> +        "Set number of bits used to represent SubstreamIDs (SSIDs). "
>> +        "Valid values are 0-20 and auto. Defaults to 0. "
>>           "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>> -        "Valid range is 0-20, where 0 disables SubstreamID support. "
>> -        "Defaults to 0. A value greater than 0 is required to enable "
>> -        "PASID support. ssidsize=auto is not supported.");
>> +        "A value of 0 disables SubstreamID support. A value greater "
>> +        "than 0 is required to enable PASID support.");
>>   }
>>
>>   static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,


