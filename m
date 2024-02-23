Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60636C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTOJ-0007CY-EB; Fri, 23 Feb 2024 06:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1rdTOF-0007Bg-4v; Fri, 23 Feb 2024 06:06:51 -0500
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1rdTOC-0000Z4-NO; Fri, 23 Feb 2024 06:06:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLKAlwEfmkLbDrD9JATtK9QTePcYezgHf0YhCiWv96syLJQVdJNoePPdwAbaLHjUVee/w2FFleOgLtk0jRMG/02RjQaqaZyoXKYbG5daxWi7b6/nYFtGYAwe/hJ2ygNlZbmQiQm0vh9b7lqRoO6xcZERc+3anvfsO0J/vs9o8/wXERnBob+5DVJS0TxJKc7jRStdqp4/A3bHp8xkedZu/xZdBgBAE4SdsX23GzpgXihdscDT8Z53tcyhJDwWcIMlfvzAK+RTXUSQy8DzsKviVMG8M43cE4jWjcpIJ5UYRn5ozLoboT9bXddAwS5LtO+vg9qc19E3o/OiZQM2+pr2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rueK3qSYXx+kwXMYcz2qOXHTRXBvaTSchHBbTF8txNg=;
 b=nKkC22mudkhPIwFh7StDuy0UcJDmbYWh3cjoZloIGoZauj/cu0G40L+eFINH6WF9iuMfZkcbar+LOVhnyI6rWN/71s9dtHzIJz0BR47jFH6XuSuHq7x3fVri8atLSb2GqMrCEquNRilMhoE/4DHflKLUiPh4t3rCu/hxr6VPahmYqLX+ovxWuxylVTAAiaOBptt3pLrOKTh/DxLmBAQaSARnPcqXFTjid9wIz1csMCoSirsAfzxL2y6/Dc/p/404O1HmqXs6l3IHlBu3pFr8gYfpFYa7IQVqbU1nVmc3sxYASjq6P/u2o0R7TSPpzt5cAJg626x6v1NXTKWzH2G+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rueK3qSYXx+kwXMYcz2qOXHTRXBvaTSchHBbTF8txNg=;
 b=OICPySvzG0A9Wd52NapDXBoWJ3WgE5N4pq0iser8IZ9krmm3YB21U8IPkbgCgFL2qK8oQJ4dDag4F2KFbB4+Q3tmhD0RmDdsXyzw7pq4joLZuo6zL0MFamMgJBVdsoE935gs9LWZQqDzkslrq+t/HB4seikEYA0jqBDi7HgRS2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 11:06:41 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::9ec4:e176:2c3e:6dc0]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::9ec4:e176:2c3e:6dc0%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 11:06:40 +0000
Message-ID: <9f3cb497-d49c-4a35-b365-847ae1b60b08@amd.com>
Date: Fri, 23 Feb 2024 12:06:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] hw/net/can/versal: Prefer object_initialize_child
 over object_initialize
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jason Wang <jasowang@redhat.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-17-philmd@linaro.org>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <20240216110313.17039-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::11) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DM8PR12MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: a59258dc-bd69-440c-37ea-08dc345f8307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTIv8xP2zlI0CVehJb3Iv8SLnZHu/lSq9G5ir7VxkKEZ1jYBXo3+9dWSHnVBedhICxByOxisF16kWxx9H2i1D+aa8u/NeTbHhGkjwUVG6hOenaxGWmtfSteBQcIwT0alEbsoLy2mvlovC9+dFcDoZIU/7rSWwZAIhLQo0Ji2ZLRjwEzOvJoU5wVqrA2QZY2UoPBg2CDXiIovo9bzQZa+b6/TdmnytH1UlASYlXElWYuTIslUIZIuu9gIg7eaucrkYtZgCkOsy3+d4oht0K+tBC4MgVJHlBD/KSW2GnNkiRR5Ja6fR4/AxHz4hEfVrni6/6mbW7ehFXjs791oAUjn9dPa1/568YjuHIa1ySjthSaRQ1SM6qLObERTVZ5w1lXRHWrK/8soPwzo1rhjHle1m/NDwEuIKhnJ2gOMbOnEHuqMepXlgMesLYmRnm9/qoiDO/lWyNnimuBHFNm0GqKa0GEDZY38eSsZ0FFdgAdkBC6GB8hi1v2L/1AhgGgUZESRUvdGTINw76v0oa85LhiwhqL4nCuj6EwmaJSMzLanwc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXF6cDYzNSswWHBMVGgxR0UvcHg1alRzR3d5eXp4UVYyUUwzT3V6cGtKWDJ4?=
 =?utf-8?B?SERpOXpScU5QcGU3a25MVnQzbHlHUklRNVA2TTVuY0g5cHBTK08wNVFvWVU0?=
 =?utf-8?B?aEEycmR2NWNpWTV0Tk5pNXdTWDRWK0t3YmlUT2YxNzhuQjlVN2lJTUdKZkNC?=
 =?utf-8?B?bysrZ1FKTEhUNnJjRGNVZ1RGTnI2dXMweVE5cHJMUXI1UHpqT3g1aWpCNkox?=
 =?utf-8?B?NWM0dzBiM1dMUFA5ZWdYeng4bEZuTWQ3c0xwNUJpb0YyZFQ0QU0zQmNSUUdU?=
 =?utf-8?B?enJsN3BSeHF4bG9mOVNibUhRUS9LOTd1RHd0ekZBK1VxSC9RTkRlWjhwSHJn?=
 =?utf-8?B?dGdycTNHR0FXRFJNVTlOZUlVblNtYytXTFhLMkFRTG5KaE9wV1BwOVF6YW9L?=
 =?utf-8?B?T2daQkt2OXpndGU0R2xaZjlXZWdqYTZ3eUJnRlRRQ0pubTUzaFNmMmV4N01F?=
 =?utf-8?B?b1l6dnhBRWRkWkM5dFVWRG4yN3RMS1gzbXgvdVh1Nmc2UlptdzFDdDhXNXNx?=
 =?utf-8?B?UWE1RUlIVTlVeEJnTWVFSGFkQnVSc05WNE02QlJpYjFjS0hnKytRNVdZUFRB?=
 =?utf-8?B?aW14Q2dVcU9XMTJrTGNZVUI4K3JwTHk4NUJnUXNuVzRSUjk1TkhYV1QyMXBZ?=
 =?utf-8?B?eGtFV09tenhtalhoVEFDUXhRM0pBdUJUajhKcjBtSTFqclQ2M3U2WTdwUEdS?=
 =?utf-8?B?cEZGL1REeFdNOVZlMXg1cUVWNHNZNTNYN1lVcnE2YkM5WXB3SGNJa2lOM0RV?=
 =?utf-8?B?aHNqaEJoOXVLam9ucUhSTkdEc3RMUmt0SzJDVFNOVThEMFQ1WURxK1Eyb3B1?=
 =?utf-8?B?NytZYm9aaDZ3bDM0UEZrQ3BqM2dkcWoyNVc2Y0ZRcVRFRDU2dlF0OTlGa3BB?=
 =?utf-8?B?Y2pWUkducFY0a0Q2RlFiK0FYbnU0eHQ4dDZMdUZpOUdsMDR0aHJ6VlRqcWgy?=
 =?utf-8?B?R2FNcDVKOU5ER2N5OGFqNmxselRyekNLdXNBRW14V2ozNnBiUTlzR3BSMC9m?=
 =?utf-8?B?dENRb3NsbWNnVjNiSnRtOUVkeXpCcTNGWjRnNGhXdjhHZGlCZ3JZNGo0T2VI?=
 =?utf-8?B?STVwQ3RYUzlWRmNubGQwTVViUFI2cWdpU2t3K3FqK0w5cDFWV0J5ZG84WndN?=
 =?utf-8?B?L2FPS0NBTlp6QjY3ajVXT2F3clFCV3IxMEpxS2YvQWFGWXFlODVFcjRVK0hp?=
 =?utf-8?B?NFA0RzJ6RzhOUy9WSEJEaXlKRytWWmZvUldCY3ExZTdUTkc0MmZ6OSt4L1g2?=
 =?utf-8?B?azFHMU0xbDI1eUlGd2ZzenpHakY0MHJzWFlCa3dYME1KN0RobEZLMlFqME9J?=
 =?utf-8?B?UXV1L2pnOXVCZ0xQcnoyQlRad21WY1llUFdiWnpJS3hUc3dUeVp6MitrZkhD?=
 =?utf-8?B?UWp6UjNSd0YxeGRVTmtqNllTZTkxU001M1kyeDhqZjVzVVNPM05FUURtb1hC?=
 =?utf-8?B?NjJlRWQwY1UwMzgvc1FTZjZmV21yUVdBaWN3ajBqUmZzNnpNZjRiUUxQWU1q?=
 =?utf-8?B?NEM3VE9qVGNBRTBjU1VlNnNKdlBlQ1M5YTU4ay9jTlBZTXFqQWdralJwSXdP?=
 =?utf-8?B?OGV0bGJFeU5BaS9rTy9LQUdOL3BESXU3cGtua3JBWHVsR1NpQ3Z2bTRtbnJJ?=
 =?utf-8?B?VnVBUjJtMHZMU0FMam4xd2JjZVAzY2dwUVdnZzZqU0FJWXR6T204YnJPTW1k?=
 =?utf-8?B?cG1jb3JoRjliN2pwUzErS09zcnlHZC95RnNyUCtiaTc1OEtXbUpDVDlmUWdp?=
 =?utf-8?B?N1FpTXhrU1ZwYXVGVGlYR3R3U0o3MWQ4MDJtMEwrY3ZwYmV2OGdmTDk0ZnZ1?=
 =?utf-8?B?VnFQdzZIYjk0eUMzaDh3M2dZaTlCWExqTWZIQm5xNysyOVR1T1g1ZUxlSUFw?=
 =?utf-8?B?dC9LSUxHN0xmZFIvWUNHVnZoaGQ1bllrL1B2eG1XVU1mQkNSMDJGQVJwSUpa?=
 =?utf-8?B?UDJ3UXQ0ZEFYN3hzMnQ1dUdqVmlSRkpZY1pxRkQzam5DWXpVaWV5SzlrVHdS?=
 =?utf-8?B?eld4Ty9kbFBOS2QrWkNBNkNmV040bE9GZE5RN1JvNFJQM25VOWRNSldpaTVR?=
 =?utf-8?B?c2V6U3lDYVZ4WUkzNmtOVlBYY3hoUmJiMVkwQnhreFdpZVdUdW16Ty9Cb3Z2?=
 =?utf-8?Q?Pv0rKiuPSTISAE/jvq1LchBpT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59258dc-bd69-440c-37ea-08dc345f8307
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 11:06:40.6981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yh2LJpyK0/DTGXGOuTH9yYOKRZC26wt2TJ0Gon6PsLzaN9dbyEADICqULoDSC7AOdSrvKMamy0gboNX19q3lKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 2024-02-16 12:03, Philippe Mathieu-Daudé wrote:
> When the QOM parent is available, prefer object_initialize_child()
> over object_initialize(), since it create the parent relationship.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>   hw/net/can/xlnx-versal-canfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 47a14cfe63..f8e4bd75e4 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1900,7 +1900,7 @@ static int canfd_populate_regarray(XlnxVersalCANFDState *s,
>           int index = rae[i].addr / 4;
>           RegisterInfo *r = &s->reg_info[index];
>   
> -        object_initialize(r, sizeof(*r), TYPE_REGISTER);
> +        object_initialize_child(OBJECT(s), "reg[*]", r, TYPE_REGISTER);
>   
>           *r = (RegisterInfo) {
>               .data = &s->regs[index],

