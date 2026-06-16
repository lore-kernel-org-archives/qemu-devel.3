Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51D4CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZP5-000141-GZ; Tue, 16 Jun 2026 15:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZZP3-00013k-Pf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:24:53 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wZZP2-00076j-4P
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:24:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGpYCydqKYklB1EPDDwMvbjp7padqou9j3P3JnwGrZs3DKL6E9NBAkQMzMutqLiXItPHlvRjQuPuS5rx/SUvkMuJyEeLIaJ6lmpXE/THCrTYzYurkvEemZY6xumqroLu5QR18dj6gYpGlm1LvAJVF1Tihd4/YJ0XJyziyCFhCZWowwYUONP4gb3Efp4oTuXhCS6GVpI1VaIYK7twfvD22rnhiRMiiFJirxdaS0D3jCWTkbc7X3fI+rbo9ynM4YwpJPvAqD6M0xaFB5Y4CFFCuVIIHRsM1zoCOjOcCGH3cIx1ESlO0e3iFmU/dSNytmMtYQVC1xVrwY9HBeBi+H1JJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XzywgF5LPZGoBtnuWghgclqmyuSpoKu4UbWYUIHv38=;
 b=ld62aeK1EELnG88PzKDEbFiyGFv3alYAIFb9N/aJLZwE0LSb0Vtv3IBISYueQ571yIOjznDjtziCJsvUkouzmfcVoWPxSXHTjKKTo+SvZpuMAmkD8ArN6NTkZP4qDO9bcXBn3yLREQ2PcyBSusIJKXlCJaNTqtJROKuEYYRID8ioRTG/VOO8di8vJYRXefY6dFbiI92CwKW2p2D/8lTRFSgXxtqGEdI0qzwiof9LPXxBMdCbOMEU2do65hTWhPSaJCJkpdzKz9NvHuH01nhdlu/DGN+H1fikx3C1w+MRP2+BgjZ8PYRfWr7eeO/URG/sOG2shz7nY3Lw9RT4UtOgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XzywgF5LPZGoBtnuWghgclqmyuSpoKu4UbWYUIHv38=;
 b=KdZSmijeyA9FmLGv8G5YCmmk7rUkTOTpYStWB/j8T8bElUgKal5+vMushTurzgJeuAlw5Z4qVQxq+XgHQyY6jbB+vXqQ5EJPqFYVlfmB+cx/HmLwwC/NlmWtOdKOFxYUEIpk6HMRBEcxmVuS4PZV0Bhii9TTnotKSTrvBWI9rd2TPMFHbe3XjcazKRCGrKQzrip4/5IsOdwaxTczIwvUSoE7qIEIVO/e7BK8A8O+UedPjAy21efBLgORUPK8qNNb7PZt6v7Oo5GsAq+yUjaRnt8kepd1LnQbb/iH7swJrhW5lojyOJk4gFj+rli5SSGaHAFqUcV1RGcr0jmYLsCdHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 19:24:43 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 19:24:43 +0000
Message-ID: <79eb3ee7-67f5-4f9e-aec7-c1233cff9ea8@nvidia.com>
Date: Tue, 16 Jun 2026 12:24:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vfio/pci: Warn when ats=on but host device lacks
 ATS cap
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-4-nathanc@nvidia.com>
 <SJ0PR12MB8614F625B742312E8A830FDFABE52@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <SJ0PR12MB8614F625B742312E8A830FDFABE52@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:805:f2::20) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 346b47a2-572c-4dc2-e593-08decbdceb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 23NiOOhY+C0PUs+e2fPlnF/REBRtaqbZy61YDGktOVLXB09RzmtW4F2NX1zlr0XkF4SZmIr1lnMx/mFrkET8gewj4lISsrjhOibB0HQTHMq33ODah1prsznZY9vn0c4nSB1wNed7sflwyd3xM8+SNzm4e8gu/LMlCboVrgK/sKxsjetl2uKcIi6V8jRk0OrwPdcl2st2wfSKAlNbod+Xh63qrYoXK7v0T1mamHxk3s0AxHoMAYwZAI5ZmKxj+MqwLZpEBB6KZUIhEqwaA7Y4si+KZAkfjEMTtSc/OTffuR1dSafMr49cULY6PZ8nlWpnu06eS6SIf8fOlZ6mckH0M2+hzGk860ICuD4hqShyWS3lJGgh+kCYjod1czwvA6NiqQGt+ec+6lGNDl3vrWfDE+11ywzwEJNmMdLy/Jg4mg43w9dRCWtYpcD7e3QQBRZ2PgONJBqbmehRViwtA4sFX0xejbYhKLyWmK2587gVZ5qKJWDSIWlmwF0OwMdozL43YxX9im+pkzPBkOIJ8FzkfpEnHvZE/yoDDZVqzT39zWcN5SX4YQHSMjkcCkpb1IvPNGmqwjW25xv0Oju6PVvuvgf2voMppJQENxDJqXiTck3QQRykLyym/84DkG8vsB/1YRN+FZE+tUFHHDcDL7jdi526Q9qrjcWjt/6kxfjRAia5foUcO241biXAClWBXbQI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUc0NTBqWURtMTlNUElGY092Z2JucW4zRElpT3Bxd0hNcnd1SHprbzlZSjlz?=
 =?utf-8?B?THBSMFYzL3phMzVVWjRuMWdXRTNtQWhPUDJ6Zk4wR0hpRi9adXVtR1dNZWhQ?=
 =?utf-8?B?MHR0Sm4yRVFKVnNKUS94NjROMnZoU3MyVTZ3ekZEbVdpTEQ4cjJGMERXbUgw?=
 =?utf-8?B?VVZHa1kyb25xZ3R1VmlScVQ4SE44Z3Ruclc2eWhLODhjS0Y3ang1ekl5QXFo?=
 =?utf-8?B?NmRMeEQ1dEZWV1puRHUvTVBFRXd4eG1ReFZ4WFNoRGlMNkRVOWJTQm8wcjBX?=
 =?utf-8?B?dDB5OWFYU2lQSENqUy9sQm03OTBhUXRuem5nRk4vRFYxOThvOVZndVIrbE5r?=
 =?utf-8?B?aHBpOFkvUDRGQkIwQlpSMzd6NndJVTV2TnRvaFRvUUJ2RkE1YnB2K01qRXdY?=
 =?utf-8?B?WUU0VWFRcDR2R1FHNU5ld2RFWDdBMkxQL1NBWVpLa0hnMzJ0MTFScUV0MHpL?=
 =?utf-8?B?U3R6OUhoUlJwNHN6MnNhZ3lYUlJwZkIrZEVVc0taNTRkY3ptOW9wNHhZTVBa?=
 =?utf-8?B?OVAvTXcwRzFXODlrc045YTlxVnRFdFdkb1FmOWtNR1E5VzRvQVdGVnljNGdk?=
 =?utf-8?B?OCtVcTcva2wyOWJMZGNOc0IxV0JRSmZZUW1QdVJPcFluaHBBVlBJL0RTeEl0?=
 =?utf-8?B?NG1ES0hWTnU3SGw2N3Q2dGlXZTJpSGlzSW5oT3pmOXR3Zk55MThpckZWczgz?=
 =?utf-8?B?cW1hWkVoYVNxallIZGdQZWoyNVFMRWEyTzJSRXFkL2VsYUpJTFlDRHRyOWhO?=
 =?utf-8?B?YzNvN09nVXBLMUdnTUFLWmk3WTkyU1BTME5LclRBYUNDaC9xcm8xSzNHQVJw?=
 =?utf-8?B?d2VPVEZMTHF5UUVQbWRENExjTXBiYWp6M0p0aTFVZ29hSG9TZGpRMEpUVGtt?=
 =?utf-8?B?RVRpc1NRcUJXT1dCd3ppemlNQm1DcXFkeUNDa1lDeWRiclZGNEFjS2JSTWNZ?=
 =?utf-8?B?QWtCMzJFS0JtckU2eFFPR2dyWUN2VjlIbFVrb2h6K3puVlZEQVZSNnY2ZDlR?=
 =?utf-8?B?ZkR3TDNqTEwrZWhmcCtvSlZzeHc4Y2NIQVdGbFNTMXVFOGRmSHQ2ZkFPK2k4?=
 =?utf-8?B?QVRBMWNZdjZzK3V5blIvWFE0SDhwSnBRb21vTXc5TGp2V1JMNmJoVXMxWmRu?=
 =?utf-8?B?SCtqcU8vVjBUUGNSbU1lMXNybEJBQlpiVnVSLyt6QTdpWThIemRQYTJ6OEJN?=
 =?utf-8?B?SjdFbHY2R0lBVVBEMW1jY3NkdXVUQXhjQ3NyZEZMRnMxMnJvV3poai9XWTdQ?=
 =?utf-8?B?UVV5MVRjQ1hQNXFHUllXaFNKb3pjamVqc2xrWlhPUVVlVmtJTVRMUXRHTnh6?=
 =?utf-8?B?cHl1Z1kwUWhoWXVlQVFZSlFRWTd6VCtMNFF5K2tRNXNOSjdaaGpQODlkQWtr?=
 =?utf-8?B?WGp0OFd3cUVHV3Z4aVoya2x5OXl2Y1JCNmMzaFAvYzVtWXJvUC9SaUcyWUJr?=
 =?utf-8?B?UlFSajV5andIamh4eU5RRU1LeXBCekVNSEJNRHdIMnJFb05VbXBSWEZaOTcz?=
 =?utf-8?B?VnRxRnBIVTN5ai8xbllYY21xeW9jT2EwTUIrd0pBSVNKK0hybVNkUDZlVDdR?=
 =?utf-8?B?eUVxdDNxZ3d3dzlhc3FwRlcxVE1jK2h1dDNlSkwxWHJkTGh3VldqLy84ZkVz?=
 =?utf-8?B?TElSdVRlTTZBdmRwT3NucTI1Q3dMTVkreW41MjZoQVBDbkNTK01TRGxBdnlH?=
 =?utf-8?B?VHpidVBlRlFZcGlYOTdlTGlpUmdDNGR3ZUJmTk1Gc01ndHdDYVJLS2JZL0V1?=
 =?utf-8?B?Z29PdzZUbEhlaUxmNXFDUWFiN1J4b3ducW1URHpyek5FMU5ZenhMRE9xcjZT?=
 =?utf-8?B?djFUSnBwL1dSMkt1eSsyMnkvMGlNbnJVVzh2SnM4c3dPaXdkRHpJbnkwM05P?=
 =?utf-8?B?OGpJVlBObnJUaUkwcGxZWmROQ2V5OUd1Z0tHUkRzeGs0OFpDRzNuU29iWjEr?=
 =?utf-8?B?UVpxbzJ4QkpxQU4xSjR6YUJmOERJWXd6V0h4RC9pL2dGWFRldXh2b05jOEhk?=
 =?utf-8?B?RWZqOG0rbU0vcmYvbU9MYVFWRWFaV2t3dDQvYXhuNEJSOFNUOFBWNFNGbXd5?=
 =?utf-8?B?cHdyS0pyWmt2T3ppQVpjS2tKTi95bUFEbEo5bkFiam5TWER1ZzNmVERjejBa?=
 =?utf-8?B?ZWJyRlZKUGQ4cGNwUUY3dXQrK3AxaGZ4cUxTWk1tOFpsQjNYSGxKWmx0ckVH?=
 =?utf-8?B?VUpFaldURld5a1FZNmhsdnptS0JsUUJlTjQxdXkyYmdOV0gzY1pUVGIzbVYv?=
 =?utf-8?B?TG4zRWRhemtYR2NFNGI0SlFkZkJSQ3NkQzg5RXZ1c0Y2TmhpSjZPaTN6TW4z?=
 =?utf-8?B?bEp6MzFXazAvUUVWYkU5VFllMEJ6NnpXSXoySjY3NUViTCtPZ2FIZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346b47a2-572c-4dc2-e593-08decbdceb7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 19:24:43.8236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZJMuIusz/+ZyascqHBcrA/pl6AwN4oIU+jPazzqtvMlDX+EVOhMHYR2Q3d4K9V3vqYxebyw4AJOq/Hsgs6FFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 6/16/2026 8:13 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 15 June 2026 21:49
>> To:qemu-devel@nongnu.org
>> Cc: Yi Liu<yi.l.liu@intel.com>; Eric Auger<eric.auger@redhat.com>;
>> Zhenzhong Duan<zhenzhong.duan@intel.com>; Philippe Mathieu-Daudé
>> <philmd@mailo.com>; Zhao Liu<zhao1.liu@intel.com>; Alex Williamson
>> <alex@shazbot.org>; Cédric Le Goater<clg@redhat.com>; Matt Ochs
>> <mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Shameer
>> Kolothum Thodi<skolothumtho@nvidia.com>; Nathan Chen
>> <nathanc@nvidia.com>
>> Subject: [PATCH v2 3/3] vfio/pci: Warn when ats=on but host device lacks ATS
>> cap
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Emit a warning when ats=on is requested but the physical device does not
>> advertise ATS, since ATS cannot be exposed to the guest in this case.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/vfio/pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 0f592ada89..49ba6813ee
>> 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2592,6 +2592,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev, bool ats_needed)  {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>       bool pasid_cap_added = false;
>> +    bool ats_cap_present = false;
>>       Error *err = NULL;
>>       uint32_t header;
>>       uint16_t cap_id, next, size;
>> @@ -2680,6 +2681,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev, bool ats_needed)
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>               break;
>>           case PCI_EXT_CAP_ID_ATS:
>> +            ats_cap_present = true;
>>               /*
>>                * If ATS is requested and supported according to the kernel, add
>>                * the ATS capability. If not supported according to the kernel or @@ -
>> 2699,6 +2701,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev,
>> bool ats_needed)
>>           error_report_err(err);
>>       }
>>
>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
> Nit: Can we do:
>   If (ats_needed && !ats_cap_present) here?
Yes, I'll revise this in the next refresh.>
>> +        warn_report("vfio-pci: ats=on requested, but host device has no "
>> +                    "ATS extended capability");
>> +    }
>> +
> Also, why this has to be a separate patch? Can't we fold into patch #2?
I'll fold this into patch #2. I had made this separate since it was 
suggested it could be a follow up change to the original series, but I 
agree it can fit with the preceding patch's changes to vfio_add_ext_cap()

Thanks,
Nathan

