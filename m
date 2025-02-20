Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452F3C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1jw-0004nY-6J; Thu, 20 Feb 2025 03:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1jj-0004mu-FO; Thu, 20 Feb 2025 03:16:52 -0500
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com
 ([40.107.93.85] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1jg-0007LF-VO; Thu, 20 Feb 2025 03:16:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XovuxFiQ/RN81g4JkmrbIz4ZdOmSw9sVahDUG6VjjQ3hV3IXcSWclVOSbcUISV5rbwgmaOwkcWTglecSSpjEDvTa3Mqgad1dVKolm1LhxEvPoh/Q1z99A246sXmGL9B5u1rHjZsxHkrk717gebvZNDcu3YWjJTVBF9ia36uDeknn1+yOKQO/ef0b6oqnhpjF82LC25Va/ymeLIDTS7s3mAI195z417iof0sZshKdBuR3dGnOudfamjt9KMYbvjDB7rrTRhHj0+bXfcJPRszmsnbJqesbLBdm0djsl6nf++nuaS4QmQkjITs6gtasWcUL97J5iudt4wCK48vgGaESMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=583z+xDgp8oYOhmRpUyVGjt8g/Ky4Y7IP/W2ME6Va7k=;
 b=fWmmYHX5GdF51M2bykXwcI4vzHL0Y8jRMFS9Vku4AYRj01JmCcx/hpCBMQMYI4ideAbfaiukBUAZk3SeAsTYckKXihrSz1VkVgHvnMLV+VO+qR8cJEvy/l1K8zb+sFV0jxrlnYqP2HBL3FgI5ge0mURyinCxw0DXSOyaxXF98NtrhtsyRUS4aakHfh2w5x8p7X6CXNLg3HhcDY0Jif4VoJHNEjrPR+oqSu9tT5jhjAWCEv1rVsky3Z3NuzSBKQhJsh3c0c+kKVXaJKaW8q2vvtrUHj73o/M4VBaW05VQes+ZJTBE41LiYQM7nDL1O/ohw/PBkENjW1s+POzYgRPnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=583z+xDgp8oYOhmRpUyVGjt8g/Ky4Y7IP/W2ME6Va7k=;
 b=LFH9gKbLa3Ge6NW5Cn68NOhOzjh9RU27Jbpe+0IygenbC8+lbUQz16D9FFe0aEJ8sR7hQPu+cham6maZ0SiSO40kcppw5yfeWmTUvl0B6ZjD4x59S+F/CkdWJVUS/69YhRlwM8aoY66AAFLtbyzHHnh8Owu9z8jJ6+axw26HmgY=
Received: from BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35) by
 CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Thu, 20 Feb 2025 08:11:35 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::b3) by BYAPR01CA0058.outlook.office365.com
 (2603:10b6:a03:94::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:11:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:11:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:11:33 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 02:11:31 -0600
Date: Thu, 20 Feb 2025 09:11:30 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 <qemu-devel@nongnu.org>, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Magnus Damm
 <magnus.damm@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth
 <huth@tuxfamily.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/9] hw/char/pl011: Warn when using disabled receiver
Message-ID: <Z7bjssQFOGiRyrM6@XFR-LUMICHEL-L2.amd.com>
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219210841.94797-2-philmd@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: f53923a0-bd7c-4ece-979b-08dd5186316e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Znpab05mYlFoTEM1RFhPb0Z1U0thN0hMaTZ6aDBubituZWhzSUlWRE1oaExP?=
 =?utf-8?B?WnVxVCtYQUFoRW9IWHkzdlpvV09nVWIzZjhIV2xxSjNMelpmYko5TDhwQi9y?=
 =?utf-8?B?NWZxYmxoZWRWRVNLSlVFRm1QSmRFRDRDSmZWR1NteWo4bGswMGo4Y3NJcHha?=
 =?utf-8?B?cTI0VzN4WUR2NnBSNmFtMFhRQm9mNkhCb1l2dFdSQjdKZERpdGdjMUVRMzRS?=
 =?utf-8?B?aUp6NXFlV1NvK1Q0QlViVFZMREZ4U1VSRHNVZjZocWVrR3hrZ0kyYmJwVUFu?=
 =?utf-8?B?T1JsaEJRakZxU0trOEtEV2QxMVdhcWorWStqNXhLZy9BQVBQY3VvZDc1R0lT?=
 =?utf-8?B?SUlYbU4xTFdUdHkwYlJ2OE10ZkRNRzJTL2tVS3MxMWd5STlROWpQdWJrL21n?=
 =?utf-8?B?TzFSQ2JZbjAvNWpuaTJWdXpZQ2dQSHdvVUxnckUrODhqcWFRV2lncmNDaSt2?=
 =?utf-8?B?eVBSTVYwcGRzMTlKTVJ1QmRkaGhCTDFsZnBwaVV6Y2RNbHhVUzJHSmY2dzdn?=
 =?utf-8?B?TEp4dlo5c2hHRENwb1FzcnNwY3lhYTNoNFJzYXNkOTl1TmhvYTZadFVHb0dw?=
 =?utf-8?B?c09ZamJzY05NbzB1cVJqZE5JTHkzQVptdE1maW9UNll0WndqdFQ4NzZ3ajR1?=
 =?utf-8?B?UE5zTXNZVml4SlJEend5c2VXc2hpckV1RUlEanZpQ1R0OE1FL2lWRVRnM0ov?=
 =?utf-8?B?TXp1NVdUSHdQNmNOMDFFM2crelZkdzlMcGJEMGx6clAzdWhQMjZKN21mOTlF?=
 =?utf-8?B?cklBbWdvdHUwamlXdGNaYk9jRFh5R3lia0FvdmdTN0pwMC9VeDMzZnNuSUpl?=
 =?utf-8?B?alJhd3YyN2JGRUtEcUdJa3NVQnJhbU9vd25RVUNDMWRncnRiMlJUSU5EUzZj?=
 =?utf-8?B?WjcvZ09WcWVZbXYzNnozUHBhLy8wVnduT0diNGZJQnhXYUNLRHozUHBmUUFt?=
 =?utf-8?B?ellhelRvdm5Xc05qVjI1a3Boa3kzS2ZKNGdSVWk5VzlHZmEwR1BQVXJubmdP?=
 =?utf-8?B?bGVYaSs1T2h3OStMWHdzRXQxbGMzMG13eXA1ZCtCVWFkbzd5ald1YUVnNXRK?=
 =?utf-8?B?QTRPTmcrWDZneWR6L2tWTGtIcDI3ejVRRis3ampFNkhFVzBoUWM2UUh0YWF4?=
 =?utf-8?B?MjlvNFlYcW9GdjdhMGVEZFdWU05XUzZWYU8yNUs2VktIdVFmRW9Dcmp6V05y?=
 =?utf-8?B?ejA2S0wreGFRYTQxV0dFU1FZVTJjUmU3Z3ArNG1VYktTdCtwQ2VXK2dKcGQ0?=
 =?utf-8?B?RlFJMlNNb0pVaTVHZy8zdEIrcCt0SHJkQ3BDSnQ4cEM5eXRNWThSVUdzVXox?=
 =?utf-8?B?Qlk3VmE0Ny9iRWs3ZzExc0kwdTBmTUtoRCsvendXb0x0QjdGOTJ0NW5lb09V?=
 =?utf-8?B?ZGNRK1JMa2x6OXducU5udEI5MlNXN0NuaGFTdkRyOXBlZ0NRVTlqK2I2OGR5?=
 =?utf-8?B?RDBzZm1oWmxROWlJbjQzRHc2ZU1mVS8xZHRoT0pLYmM3Nnl6aUkzQjlvTCtP?=
 =?utf-8?B?Z2R1ZFdjcTJXWnZWNHpFV3pjSTBQU2hDLzluZXdZVUk3SW8ydE9mUFU1b0hO?=
 =?utf-8?B?UWhRRkYzdWlsWGpvVStEYVBkL015dk5oTXJyZ3JodGJSMWYwblBVdjNTTjhW?=
 =?utf-8?B?NjFDaURVQmE3ckF4cnpZYjQ3N0JmdXZVR0NQTkhNcTUyOFU0OUlRYXhaNmJv?=
 =?utf-8?B?enBsdzVJMEtNa21JczFBQmFZaURxQkI1Ri94UmhBVE1nVnczWnUyL1JuWjRM?=
 =?utf-8?B?aWdFblAwRUtvZWN5UGtsWVBBVUdYQ0ZRM1NsRmlHTmJoS2tlOVdzTVhYdGdn?=
 =?utf-8?B?bGp2Ukg5QUc2RlZoU29zSHVIeitjOFdvL2hZVDY0ZmI4dXVacnRLbXowalAz?=
 =?utf-8?B?RUdYaWFsQXkyV29rUk8vUUMyTlV0TGZBYlNFdTl6WGJJQmlQWHJ1WFBOSTlU?=
 =?utf-8?B?dTE5T1NRYWMvU1NFcUMrN2YweUJZakZmYUFjQThONlZ2L1pLYlo5RW1ER3Er?=
 =?utf-8?Q?Ew4pkGd6w8Xc1YcMdOCB5y/rpvcDsI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:11:35.1714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53923a0-bd7c-4ece-979b-08dd5186316e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
Received-SPF: permerror client-ip=40.107.93.85;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

Hi Phil,

On 22:08 Wed 19 Feb     , Philippe Mathieu-Daudé wrote:
> We shouldn't receive characters when the full UART or its
> receiver is disabled. However we don't want to break the
> possibly incomplete "my first bare metal assembly program"s,
> so we choose to simply display a warning when this occurs.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/char/pl011.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 06ce851044d..60cea1d9a16 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -85,6 +85,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
>  #define CR_OUT1     (1 << 12)
>  #define CR_RTS      (1 << 11)
>  #define CR_DTR      (1 << 10)
> +#define CR_RXE      (1 << 9)
>  #define CR_TXE      (1 << 8)
>  #define CR_LBE      (1 << 7)
>  #define CR_UARTEN   (1 << 0)
> @@ -487,6 +488,12 @@ static int pl011_can_receive(void *opaque)
>      PL011State *s = (PL011State *)opaque;
>      int r;
> 
> +    if (!(s->cr & CR_UARTEN)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled UART\n");
I find "reading" a bit misleading here. The guest is not reading the
data at this time. The chardev backend is trying to push data it
received to the device model. I'd use "receiving" instead.

> +    }
> +    if (!(s->cr & CR_RXE)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled TX UART\n");
s/TX/RX

Thanks,
Luc

> +    }
>      r = s->read_count < pl011_get_fifo_depth(s);
>      trace_pl011_can_receive(s->lcr, s->read_count, r);
>      return r;
> --
> 2.47.1
> 

-- 

