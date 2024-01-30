Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48FDC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 18:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUsRg-0006XA-Dr; Tue, 30 Jan 2024 13:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rUsRV-0006Uw-Qu
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:02:42 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rUsRT-00050u-NF
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:02:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMuo++f7mLfcx8sg2N5a02VjTePQfvQh1ln1DmkdYMdzP0E3dNC04jhqJSPuKOgA816dwEBRHEAbLOKZyq1U+AYx/96qTS06ihYNUKxGEz/S+02J1fWMhtO8d3+8BQAWGPKkaHLRuRIlG2dTJB90izlMwxeB1gIhEjFxuREcuWJSrjG+39DdGdh3mrNwsFRRbkefm/QdC3NzpBOgXNrKl1XVzEkWi/u03cHBHZ45kiCEw6g+/zEW8gam8TLt5Cobijuix7wh5erlWiNmP/xnorQ8c5T0tgcZPLXJc3Of9MdAZR0uG+t48x1s90BMUZMiwHyNIyZdeedqVktsM3vA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1GugQhmVelVGkqVbDXlq5XFxPhn9cyuzo4DpNf0nTs=;
 b=AYk9qf9e9QLkPOYuA5oPOXDMlEf/vSSjhLc5QbcPxUafpxs7sb8yVb9xpNyGarY+Ql9rQG1yQihxTFMRHGORlctCc9avgTqD8n/LihAWnDlDIdCj51Ot0IKYba+Vbu6i8RiUhKpaI8li5LsLExQ45EQ+8tK2oFGYY1vaFMZhb454ESBdVcgEWuaKoL6GlDHw/Se9+h9gOzw4iZAgzdYJOM9RptrTaBt+oZCNNc+kooRZTqIgHB5sCJv+3s8dso+rhA1oaAqkRwvrJtQrPrgVVJt3xrFTOtDWSBrnm6sx+6J+9NnxzhJGCWWDnYYZlKFtCvVNKREl1JGq+A21xvquWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1GugQhmVelVGkqVbDXlq5XFxPhn9cyuzo4DpNf0nTs=;
 b=k4/ZZfEogZqA86GuQ/uX83E8Ki/6upCFowSd81hwflzAx7uDxcq3gxeDu8LL94Yy+h2/h4SsJghgss/m1T0Gk6IOFNwFpvzSw/EkxfdQ8wecK8VbGy1h0Z2iR5vuJeSgh8ryiuKbISRkwwdHy1Rev5HTk2wdJFY8A52cwXt5vuqyFVwWyLeJGjmr76Q7eiDXXVuUA1LHpTYJScQJ291R7811d12jhzlDRfQxZBNCLgkoBWCB5GRrqPKJQfXcanQfaD3PNhEueCnKEMhpbwJ4VYDF26S1VA6Sj62x8b+j9QdB+dPWldbskkRoCDh5imT+rgN74ly5627a4jfOxF/9zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Tue, 30 Jan
 2024 18:02:34 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6%6]) with mapi id 15.20.7228.035; Tue, 30 Jan 2024
 18:02:34 +0000
Message-ID: <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
Date: Tue, 30 Jan 2024 23:32:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: targupta@nvidia.com, cjia@nvidia.com, acurrid@nvidia.com,
 zhiw@nvidia.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 avihaih@nvidia.com, alex.williamson@redhat.com
References: <20240130095617.31661-1-vkale@nvidia.com>
X-Nvconfidentiality: public
From: Vinayak Kale <vkale@nvidia.com>
In-Reply-To: <20240130095617.31661-1-vkale@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::7) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebbeecf-c5ab-45d3-0c04-08dc21bda292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uA8Ce+818roZWQpYnuyuzlHH4pqn6vNUuxSVS9JOupcSoiEO5Qz4feb07cuZ+ErXgsRh8Y0VgBmv/ISr6JkRMuz/q5dU2c6OcKu16cyYEwYgjbw9k6jjHQ7o8d5maosfNtV0br9xQX2XE5QUQRW4k4/Wn2Zd6heR6cWeMqMbTdAgcy+cOQZK31lBfGvoAWmhGMbjhirP8Y51P+yIK2qI5ebHqUmDLM9cPNocdu9hfULzlML/7KQ8q+rhzuJoS+YppL4GAY5ihYPPtLcMG6t7qnRFpgG2uLqrPukoQmf6rG/0l6K6ZXE3wub4Jjd5rQjBOli8QudyUo/ImeT6U1qW4a9iwfUIa0LFD082CrIKFRB0pveuSsVW80QlpUsmI3/pFk4hJqqrLm5WwitGeIli1a3Esiq+QApRZAjzKfWVUV//sEY1VyUCnBf5VbkkduROGKzXS6NNrXVGFFgDFzev2on8whtQJUbDEZ0LFAj41gCXCNO2GQ6DF37LtiVVlfjqowNpUdvZmkTF14Yh+3aMX8zeP0pS5nid65C0qiAV163ztlMjKFxFTknf8kgECK58usIcmp2AgsqAld7xSpPBxQ0TijgOtjQXXyhbv5djMu131mOinFwb5NFh3wMbom7kidH2Ym+s2MQM6HcONXcwCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66899024)(4326008)(8936002)(8676002)(5660300002)(31696002)(86362001)(2906002)(66946007)(66556008)(66476007)(316002)(6916009)(36756003)(38100700002)(53546011)(6512007)(478600001)(6506007)(6666004)(83380400001)(6486002)(41300700001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmhZTTd3SzZ2bWZROS94SDNqV2JlRFEyRk5xRnNZMzJicjBIdmx3NjN1dDNw?=
 =?utf-8?B?RDNmYzgxNHAyVWphZS9RbHBVZ3BEUkdEL0txcTJMWTI5VG5SY2xPT3VmZlhT?=
 =?utf-8?B?RG9uaml0MlZ5d2ZGVE1RLzdneS9DSFZiNHhqSE94aitkTkRWTWt3ak5UQWxi?=
 =?utf-8?B?cWdDM1ZvWXQ1ZzZWVjEvN2w4NkZkQ0xSL2xsOGErSGdvK3hZejdjeHkvMSsr?=
 =?utf-8?B?cUN5ekdyOXlwS3ZqZ0xpRkNkYWgwZVp6TFpoMmIxTzA3bnFqYW9SREVuQUNJ?=
 =?utf-8?B?RDRteDNycUJrVXFoSU1aa09wV0FMUkp2UU5WbDE5ZFN1TE04QXhIVkl6Y0Yv?=
 =?utf-8?B?RGFoeFdTdStuMDc1WG5ZK1VqZEhZTVpxVEMvMEZzNTBWbWJGL2l5TU1Zb0I1?=
 =?utf-8?B?OVlrSmJOZFFNamxuQUNhU0RGMFhwK09QUmErQ1hIUWZLWlNKTEZVeksveXNB?=
 =?utf-8?B?SFVYc3czbFgrblI0YzA2cjAzL2VGVndwNlhra0hScDJBbWJseDQ1MXh0YzNJ?=
 =?utf-8?B?UUZ5QnpaMXMxOURzbjlYL2cwL3BlNG92MXJCOE9KT09Ma0R2NGNlRDhhZm5i?=
 =?utf-8?B?SW1TcDJDeUc3N2Npc0hvVkRkcXh4anB2SlFsb2Q1TFBnL0FOK1RCaU5aMlZ4?=
 =?utf-8?B?TWwydktsSjBYWm1FRG5rOFhXQnB4K09xQ0RXTHJKYkd4RXM4L01pV0p6dTJw?=
 =?utf-8?B?ZjB5K1hmS2RXNWhWMUh6WHRMM3J2WURxNERud0ZTakIycDR1dXZubkIvR0lJ?=
 =?utf-8?B?M201K0k5WmJEUWVjK0R0NlhNY3FSc084V05nVjBvUm9CMlpVb0xrQnZ5UDBD?=
 =?utf-8?B?VjFSSVcxYXVWd1VMRW45SUtvMU0vMXdSNHVLN2diV0RDZkNrQis0cjBPbzVF?=
 =?utf-8?B?VGVaNlZMSERJVTVFRElkSjJYTnNPVVBIenQ3aWI0SGN2YS8wblZyMTZRTnFy?=
 =?utf-8?B?ZVhSc2hidnFUVER3U21TWldEZllZMVlVSGRDekREV1laNmJsWnBjdjlZa0VT?=
 =?utf-8?B?U3piZnZ2RUJIeW83ZTV5VUtaVFhuS3Nrd0Y4dTY0MW8xMitXUE12UkQwOEti?=
 =?utf-8?B?a3NkRjlPcWd4ZG5FbjhNMklhUDd6bHlWOGI5d2xDUTgyMEFYcmxMTGNGMG9Q?=
 =?utf-8?B?U1dJeFc5MHhKOUgvM2FmTkIzdFBjaWVCTndKMlE0Z2o0VGxxSkxWVTI4M2Z5?=
 =?utf-8?B?SzVpL0tndFNzSml3ZUFEc0tUeVd1UTlDc25wVUFFNzQzRU5haHVHVGZibFYz?=
 =?utf-8?B?UXFzSDdzbHRsMzAzUkkxSEJqTVU5Vlpyb3p2Vkd2YnpGTjl6RDdCa3p1R3BD?=
 =?utf-8?B?WVFiQXBnc3ZtaHduWHFhK0RZaE4rNm5MKzN0NUJsbFZmSFZsK0o1SHhkL05L?=
 =?utf-8?B?K1Y0bUNEL09QRTljdUg3MGVFNUZyQm5lQS9hcHowVXhWWEpuemo2TlVMYUk3?=
 =?utf-8?B?R1FYMHFCQ0hFa2lhakJlVmhUaEJRNE0xN0lHZXJ5S3lZNGg5RCttRmh1cUdV?=
 =?utf-8?B?SzNhSlFXZ1dSNVlCYmV3V1phc2lncDM2dm5hcUg3UTAzYzc0SERRbHZsTm51?=
 =?utf-8?B?OGVVell5K3FqRktHNSt2Z1JPeWhsVnQ3YlYzK29ibUxyVnl3YlU4N09CV0k1?=
 =?utf-8?B?a1ZOV2pQNWFwV0hIWkNyRThwTDRHdnNSZmJ4RWhObG1STGh0bmVSa2F1NDVk?=
 =?utf-8?B?Y25NWENKNnhud3hYTEt0N0ZoWlNvWFJlM2kwOTEreStIdWVNa0NaMXA5WVB0?=
 =?utf-8?B?MUw5bEJnZWtqQStIVWFhV1RiQk1LSDlkRi9TV1NMaFlreE1tbTc3QTgvMGUy?=
 =?utf-8?B?YndHanExV3l1cCtNUGRYSk9WVHl6ZUEzNThzUVVsSVZEN3daQUpWUHJ3YmNZ?=
 =?utf-8?B?U1lzZlVIb0FMTnNhSjg2aVpjblk4MkxsQmJ4U0JadW9TTjFVVk1OZjYvWWt5?=
 =?utf-8?B?di9aVUFTTVp2TU5icVB6OVdnOUVFcGtDL3MwZDlsYlZvUkFsUXZjT25GYW45?=
 =?utf-8?B?MTRWcUJtY2h1bVNUVENidW0wZDRCMmxEMVNsNWJHdHlWOVc0WFJONDBQbHgw?=
 =?utf-8?B?WGEyTmNwemVldHV6YWw4MmM0K3JsM1B1b083YnNKb0d2WVVSR1BTcDUzVjVz?=
 =?utf-8?B?dEI2bFJIQ0I1blZ1bDEyQXF4dnljTC9FRTRGTmRrNGoxQzEwaHhoaDlSZkJB?=
 =?utf-8?Q?3NwmXV8NxYAIAGUeUP0+fbYeBAr81mVwV9hCK5Ax8bP4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebbeecf-c5ab-45d3-0c04-08dc21bda292
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:02:34.3036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeKwMeFZYT0TVO8wzyW6bZ1GqsIiem1vQh7/xkbNv+E10aUqb0856IouhuNyVVCwG4/dqME+D+1QoUJ2qsisaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=vkale@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Missed adding Michael, Marcel, Alex and Avihai earlier, apologies.

Regards,
Vinayak

On 30/01/24 3:26 pm, Vinayak Kale wrote:
> In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
> in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.
> 
> config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.
> 
> Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
> If cmask[] is not set for an offset, then qemu skips config space check for that offset.
> 
> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> ---
>   hw/pci/pci.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 76080af580..32429109df 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>       memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
>       /* Make capability read-only by default */
>       memset(pdev->wmask + offset, 0, size);
> -    /* Check capability by default */
> -    memset(pdev->cmask + offset, 0xFF, size);
> +
> +    if (cap_id != PCI_CAP_ID_VNDR) {
> +        /* Check non-vendor specific capability by default */
> +        memset(pdev->cmask + offset, 0xFF, size);
> +    }
>       return offset;
>   }
>   

