Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEEDE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 17:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMWLr-0005ST-MH; Sat, 14 Dec 2024 12:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason.Andryuk@amd.com>)
 id 1tMWLo-0005S6-AB
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 12:54:48 -0500
Received: from mail-bn7nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2009::61c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason.Andryuk@amd.com>)
 id 1tMWLi-000444-38
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 12:54:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY3ew6M64TBE0L3g4xq8PczDQyR3+AAdI2R4RkNQRQ5dHC/P67XJv2i5jWab8sWv2GsYRnRysE8LzgcoczGLmUNvpjbTz3qTOwlNaSRQS2QAroorOoHjjWwwXQdnHdrNVHcm1sH6jWRQ6IlkHhaKjJyuEAir/M2WVWR/trfiRVCdUasXDnrKEIgJhTdGD5KEU6+woKsLa3bFZ/BJC6+EsuG5UayAsJ0QN7kB68oQ9AmraF+G7BMVI1T6yelLf7Nystk4l7bP9j8Opx5esUrLO00rEMvAlHVscDhrXznPE8NDbaLp3qfvhND5IbeycTdUeo8ef7MS6TCF7q1OkIC1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GnafECtgxI2eDydWJ5XeykP2Zok967VY/jGtFS4mds=;
 b=WTh6sNikz7H2Yt8j1j2plFqQ19J7e9dzbgd4Ovi2pM8Pg6M1BPPfHSz2iZaq3p11n+N6Lgp/XvowH3Jn69a0Qtn16YlgRjk1EL5rbwHQQuKnw9y1M8+UbOYQ9d89fx3LCo+zTeGujLZo0VCXBVUZ1BsFWTy42ctDxb8VDw7GKtJtU0xX24MA2z/FY39agAvcNTFeIn9KTR83BkiPNe131wBLFFSiv57giNMzrW2lHLjkLXiLDYNk0vPztjs184Im6TIefX80dYlrYIgmSWANuNwweWktVHz066W4BlHff1bfiPjCC6x6eUJkS/QuCaoA/EhXGpeiglBvP7m1+3q54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GnafECtgxI2eDydWJ5XeykP2Zok967VY/jGtFS4mds=;
 b=HEeuj9e7v6W5qv15kO5QmQ0TYt6Q1feE3AQNTmXhlv4b/FYEJVyjGnTeHLU+ZRiwzCCXJEXW4N+WF+NslHBU3K+eTPQDmQexEuYajo9z32JccNH03V02pRXv7wm6ePgh0bQUjk89x7PTpFeNz4c8tbksAM5okKKJtyxgDh6G1nM=
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Sat, 14 Dec
 2024 17:54:37 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::4f) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Sat,
 14 Dec 2024 17:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Sat, 14 Dec 2024 17:54:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Dec
 2024 11:54:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Dec
 2024 11:54:37 -0600
Received: from [172.28.102.118] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 14 Dec 2024 11:54:36 -0600
Message-ID: <ac59742b-575f-49b2-8d34-00b8897863b7@amd.com>
Date: Sat, 14 Dec 2024 12:54:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 69/71] hw/xen: Use DEFINE_PROP_END_OF_LIST in
 xen_sysdev_properties
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:X86 Xen CPUs"
 <xen-devel@lists.xenproject.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
 <20241213193004.2515684-7-richard.henderson@linaro.org>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20241213193004.2515684-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0cc2cb-cfae-4cdf-4bb0-08dd1c68608a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEpta0lCZE1YTGlseTBwZGdjM1BmVlBJRXNzUTQ1Rlo0c1JLZnpYQUFDV0xp?=
 =?utf-8?B?TWdWclFDVW5RMEc2MUcwWk5rbU5MbmRKanlNU3UvSWlqVTZ0aEljZjA2V3lD?=
 =?utf-8?B?dlFkUlhtQldTeE1KQTJEdFdBZEc2VHAxaVBaYkNRbkhacElPcEpPNlJxQXZV?=
 =?utf-8?B?WnNTbUpQTVl3QmZ6TDRMZG9wWExqYnFoOW5xYkRrY1BNbDJMNGJMSWpwbHk5?=
 =?utf-8?B?YWdkU0wzSjJTLzJOVnoxd3lkN252ZVpoVWk0VXZhaUxIL0kxVTZoUXVaS3ht?=
 =?utf-8?B?ZTdJdWl5UWpmZ0t3emJreEZXWTlndTVielhUTTVObVpzbmVQN1duL3pBZmdy?=
 =?utf-8?B?VC92N21weXFWQzlWNkdLSENMWlZGb2VBc2pINGp1RkVsMFdsRlZDbzdROTVq?=
 =?utf-8?B?L2xXS2Rad0FDYWtweDQraExtemx0R2FiTzBWbFEzRkJQWkJBNXJ1ZVNEekhW?=
 =?utf-8?B?ZE5SZUN4RWFqak5SbklTS1BXZHFpVTZQVWlXaUw5dk84UVJJUE1BbFpRMTF0?=
 =?utf-8?B?dEtEYzBtbCsrTyswVWUwOXljbitPOTBESktEL015Z3MvQ1hLenQrYm01aHZl?=
 =?utf-8?B?Y1VHaWJqd0NpczV4VzhrN0FJcjA2WWgvRkFSOEtKNUpzaHBxUWZTV3BBWFVM?=
 =?utf-8?B?SVpsdWw3emFMWnUwWFh4dndBbVFIU09WSG11eE50VXNnU2FTd2dFMkcxSTZL?=
 =?utf-8?B?aDdWU0o0a3oxOUc0U0VsRFpYKzVNNVNUSEcvclZPUXgrN0c1NjFyZW5rOWIw?=
 =?utf-8?B?L1QyTVV1KzloV0NyZnBydW16RmVuRklvcVVibElpTllWVHpDVDFSQmZkTGho?=
 =?utf-8?B?RFhLQWptaEd4RE9uSDNBNHVlSkhla1lCYzdybTZPa2Q3Q28rNER6TUJoNFJn?=
 =?utf-8?B?cFpiejVsQUY0S0Fkc1VEWUZTeVNJTm1rTGdONlhOVWthZzBsUkFQNG10SFpQ?=
 =?utf-8?B?Q1FxdllUck9xZVArOXpHeXNNc29JbGtpclc5eVFRdjlrSURMSWUvMlNtZ0Rk?=
 =?utf-8?B?TXBqdW5oKzN3TkZCalRkR1pBUnU0Q05VRWc3WGZ3QzBEWXNLcWh2akUwbmM5?=
 =?utf-8?B?N0FTeFlSeWwwbEwzSXNDN0llZXJXdk1PWUZoOWxZL0pUSkxkTUlTSndGV1Fo?=
 =?utf-8?B?ckkxTHMycTZ3SVZhRHFmdDBCcUVwZCtOaWRDZ1B6Nm5zS05Fb0hrN1ZmeUFr?=
 =?utf-8?B?UkRjeDZ6R3hFRWxkVTlOSWJMcnZLYlpwZFV5eEpmbC9GVDlTTWRZUUcwZDQ2?=
 =?utf-8?B?VDMwRVkybkZ5UU8yTWlvMVBOeE9CZWplKzFTVExVZTFmTXNheEpaMWZGVUh0?=
 =?utf-8?B?dWlrd1BZTW5CTjF3MlNqU056WXN4WEFQSnhxelYwbHJuWnlZbXN3TVpjRXA5?=
 =?utf-8?B?QWJnaHhaQkYzYnVYaVhtWFdGV250UjY4R2JWQzkwdzM3dkJzdlZncUxIeUFG?=
 =?utf-8?B?WkF1TTZ3blJ6Y1Y3bmFxSjh4MG0veVFFWkxYMVNsZllac2tDclB4K0lnbFZU?=
 =?utf-8?B?WDhzWXJzN0g3eFU0bFhqdzlpcWxGejF0UldTUi85cGJJdmpVTVBiYU9vNjV1?=
 =?utf-8?B?NkZmYjBRbE5DcmRsYnZlWnV3aWp0SGYyaWJNY0x3Q1RoVFk5MHRYcExIanRz?=
 =?utf-8?B?ei92UzhCaHpvemk4UFl1QTBaR09YYlRJRzJwV0R5N0NBRzZyVlhNNUg0S3oz?=
 =?utf-8?B?QWpGQ2RrZWNtek5zenRBZFEvWndGTklaR014d20yU2lxMmN6d0dJOXFaY0JL?=
 =?utf-8?B?T01OSXIwRTluQ3JsQ1p3ZzJKSXJWOHNRZGFNVkRpK0YrUm5JYmxWNVZVWkg3?=
 =?utf-8?B?eWpBVm9FcFRHTnRrSTJrTTBDQkhYK0pRU2tyNmNlcG9keDR4OEZTajk2bXdF?=
 =?utf-8?B?YW1xbmgxTXZ5KzBqZjYram1hVGpEQjl2QlJYd2JtdTBQTVI1dHhKNnVDUTVz?=
 =?utf-8?B?eDBKOUZSbXV0TmdySmw0NDRjN2M5cXpzNmRuem93VzNBMmNySmhldVh4WHUy?=
 =?utf-8?Q?8Mw47UrbQdOKlS8snLWTjXWSZVGmE8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 17:54:37.7549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0cc2cb-cfae-4cdf-4bb0-08dd1c68608a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
Received-SPF: permerror client-ip=2a01:111:f403:2009::61c;
 envelope-from=Jason.Andryuk@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

On 2024-12-13 14:30, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>

