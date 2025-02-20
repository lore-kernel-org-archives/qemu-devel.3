Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B985AC021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1hj-0003L5-JS; Thu, 20 Feb 2025 03:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1hh-0003Kn-JG; Thu, 20 Feb 2025 03:14:41 -0500
Received: from mail-mw2nam10on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1hf-0006nC-3D; Thu, 20 Feb 2025 03:14:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8RtnnVcnUPRsFcctcVN++rcG/91OTo0Hv+r6QImnNhE8KcRDyEwjDFC5uG+8Pbz/t8+a13PfpIIqe411TTX6aNMFQMnt9f6o12tx1pYIcYo9rUyB3CHXK5g6MNZMaVSJnlfv0GEh2NJ0MfaK5rhExqsEc0yAeH4HDiEF9UED0gpyo0JOie3TbYiP2HmCp/gCd5TIy3K5AaG5Mhhy+kZTf7MFd9PuUaw/K7MJlMc+z0LYzYoVMkPd6286f0ZCqA24ysCRcuqYg8cge0B/8C04uX+FXaz7OAyTOmLMjvCNZi1JFvmH3Af5x9sGUs2H5GPfKReVYNiEj95Rk6ffcoLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS0pL0v0emiaKQR2kYzAXIkYnSUyTviRmAvaQv39LgU=;
 b=Zt6DhUATparWE6YIzZFazQOY6seNzU1riF2yfOor5mGrSq3N6xM9rexsGkh5f5laTngLkxb4TcVfqSSNY2+TtCubvI09Q0+us0Kah3AtYIryWCIK8sMQbVQIXng5mRKsO8kLl7qY+pL14zKPXjvKRWAFSXaO5vY8jaGmgehwWcIkzHj17SMvCUoX4DUHjJ4ph2xOfxM/FxzEFxahDKVzrKAso6dVNqumiT5pMEH2eXr8VVlR518wztSQf7sCt225IWkZE4qmdYtgDFGBhtD6y6IckGWkkr/pHlkROpi3lYRt4QerM+ViUkT3WffavRKAfElU6eQjb4aMxTS8mAKJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS0pL0v0emiaKQR2kYzAXIkYnSUyTviRmAvaQv39LgU=;
 b=ZXwCseD7HvVQUcfp/xSMzT/6APRwc67ARRE70Y1xXi/kvnhEyUbyxbjdho521rnw6gGCctntYhfjM82lBV937f6gRTVm7wiOMPLrYN0WUEEm6KuvRJnX5oyFOsKvts1F/OO+mF48v/MhGdG+AD20MipDGd0CmkDKDYikvRdewF0=
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:14:33 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::d1) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 08:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:14:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:14:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:14:31 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 02:14:29 -0600
Date: Thu, 20 Feb 2025 09:14:28 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 <qemu-devel@nongnu.org>, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Magnus Damm
 <magnus.damm@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth
 <huth@tuxfamily.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 3/9] hw/char/pl011: Improve RX flow tracing events
Message-ID: <Z7bkZMhF9mMRzThC@XFR-LUMICHEL-L2.amd.com>
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219210841.94797-4-philmd@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e72816b-d377-4b4f-d523-08dd51869b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bERyZHZNQUhEdW43eFVSM29EM2F3RVJORGkwZWR5L0RBVjdwaE9hRGtBUjNr?=
 =?utf-8?B?WC9TdEI5NTFtTDRURTBEbDVOelV2K0ZFUUdqc2FsYlZXdkd2U1ZYTzMwNDBS?=
 =?utf-8?B?L1hzOHVjNW1SUDhFRTk3SWxmcUlsbjk1UkV0Z1ZMdU1PRk8weDh5ek1SakJv?=
 =?utf-8?B?a2x1R1RTc3FKMHZMV0Q2QWgvaldORmFnd1RKMkVSQWROVWVGWFVzaG9abzhw?=
 =?utf-8?B?M3NMUWxvWUxDejZBazRiVHhnVW9iMUdIWU9vSTluc0x6WGVCbmNkUkdlSndQ?=
 =?utf-8?B?SXlnM0ZYejJwWHJjV2Y4NWdjNmZ5RllLb0tOSW9nRSsxbmZlaW1yTTFWWW9S?=
 =?utf-8?B?dEFrVjIzM3JHYXFuRWFUejJNZVp1UnJwSllhdWpGQlhWOCszSVJSSFR3Z2xz?=
 =?utf-8?B?QithTXpDRVY4Z0VocElKYU9MbmNjZ0FKY1Y0R1JiMkJUdVoyYzREaWlZKzFk?=
 =?utf-8?B?L2N0S0VLbU1aQmZXek44OWhPRXkvRUdIZ2hUaWhWK2xlVjN5Yi9tNHlsOXFj?=
 =?utf-8?B?Y2RhNCt2THJ2eTVldlI4S1kzK3VUbXc3ZDVZSGlBTWdyUW5FMWRFVVhEaDVX?=
 =?utf-8?B?ektGdTRsZm15ZWlWdXFWaHRxd1I2Q1dJYkVYQ1ZMVXlRYlRSR25UQnhSeTMw?=
 =?utf-8?B?cERrOFpGYUpQTlg4RHhPL3VvUm9PZFd5NjhGeC9MUEVjVnB0WU9LbC9FMWM0?=
 =?utf-8?B?VklmL2xVTHUxbTBCZDVaS2Rkb291N0gyckpXRUhWUUk4cndzcWlUVG4ydW5S?=
 =?utf-8?B?ZzlSUTFoUFU5bFhVZTc4cW9GanV4Vzl0VDgyY29CNGpnanBDdTBkdEFIZkdK?=
 =?utf-8?B?YVlqOGJCekMrZEJ5NHZBRjc1WXJlb1BPMlFzWldxdkJ6emMrTndCSnUvTW9G?=
 =?utf-8?B?eGppNWsrVWZuQklMNjZ4U095QkNCcHh2aHRBbTRhcW5COVZ3OWNiQ3YwenVJ?=
 =?utf-8?B?elBLWEtlVUtGclQzc2pvOWJyUG4xMEJ2eWNRMEtyRUZpNUpsc0JqZVUvSGdl?=
 =?utf-8?B?L1VaSlFqd0w2Y3ZseEs0VXlielJWNzRCb2dEZ0oyRHhHcG5CZVlidDN6MUV5?=
 =?utf-8?B?U1N1NGU3S05IMFZxeFE3THRlRkN4UXpKYnhyRENabkdDRi9DS3k1cjI3SURh?=
 =?utf-8?B?ME5zdzdpSDU3Y1VML21oT0tiL3FpMlRNUzJ1UStMVkN5NXFISjZIYXlwUmhi?=
 =?utf-8?B?amU2Nk4xSFlGT0grWENaYVptQXlHN21lMjVuOGZpbW5pbjFaL1ZId0hha21V?=
 =?utf-8?B?bkNoYlc1YUFjTXRKaHlQb2FuWUhjMWRlY2MwYVA3UUhWSW1kU1VPbk84b29m?=
 =?utf-8?B?S1VRTU41c1Z3YWY5bzNQZmlIV2lkZ08rZVJndGE4TzdRZDlOelNRaElSd2Q1?=
 =?utf-8?B?dWZLSmpXV0FMbG9YNmJ1dFdLMDhQeHJCenhLbUdSRUxjQUNwTVptS0hPVEt1?=
 =?utf-8?B?NmlHa2ZNeXdobkpHWk54b1dJWElsQzVqN0xUdFhHNS9BdkFSVFB1UWs0U290?=
 =?utf-8?B?c0p2Q2JvVTFUUTlXc2FtK25LeXlJc29qYTQ3Z1htU1ZmZ0VqbFVwWHpNQVlI?=
 =?utf-8?B?ZDlvSGRCYlk2SW90V21xQXQwc2lFR2pQUFVuZERCVGFMamNvQStxUXUyR2NB?=
 =?utf-8?B?b0FkenpOMVUxdWJOM0ZzTUVMV2NnNE1NTGVxZ3NJYThBZkJHNUE4YUpyUXhF?=
 =?utf-8?B?MzA5cjZXUE14b3JLNHQ5d05vbDBveFdwdzd3blp2bmtjVDZKWm8yVmNEZzlE?=
 =?utf-8?B?bWxpYW1QbllGZ2FST2dMRnJUdVpaQWQzNml1c1J0amMrZnppdHdreWUvUTdP?=
 =?utf-8?B?ZkY2ZERLSW03aDNBOWt6KzVya3VlSkxoOHRPcS9GajFZaldZdlBES1R1VG9C?=
 =?utf-8?B?TjlHNEpQcmxJblVMMi9nYzlVelN2b1A4Mythd1hab09kblFpelJJdkZUYWhh?=
 =?utf-8?B?M2IzaTdoOXB0MzBzVlFWeUJSTlhDa1BMUDhMYi9UcllKNk0vSnFjckJMT0tU?=
 =?utf-8?Q?A4UvdV/KvjY/C1JnV9I4oImiWEi2js=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:14:32.9984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e72816b-d377-4b4f-d523-08dd51869b6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
Received-SPF: permerror client-ip=2a01:111:f403:2412::62d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 22:08 Wed 19 Feb     , Philippe Mathieu-Daudé wrote:
> Log FIFO use (availability and depth).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/char/pl011.c      | 10 ++++++----
>  hw/char/trace-events |  7 ++++---
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index bcd516d682d..148a7d0dc60 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -185,7 +185,7 @@ static void pl011_fifo_rx_put(void *opaque, uint32_t value)
>      s->read_fifo[slot] = value;
>      s->read_count++;
>      s->flags &= ~PL011_FLAG_RXFE;
> -    trace_pl011_fifo_rx_put(value, s->read_count);
> +    trace_pl011_fifo_rx_put(value, s->read_count, pipe_depth);
>      if (s->read_count == pipe_depth) {
>          trace_pl011_fifo_rx_full();
>          s->flags |= PL011_FLAG_RXFF;
> @@ -248,12 +248,13 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
>  static uint32_t pl011_read_rxdata(PL011State *s)
>  {
>      uint32_t c;
> +    unsigned fifo_depth = pl011_get_fifo_depth(s);
> 
>      s->flags &= ~PL011_FLAG_RXFF;
>      c = s->read_fifo[s->read_pos];
>      if (s->read_count > 0) {
>          s->read_count--;
> -        s->read_pos = (s->read_pos + 1) & (pl011_get_fifo_depth(s) - 1);
> +        s->read_pos = (s->read_pos + 1) & (fifo_depth - 1);
>      }
>      if (s->read_count == 0) {
>          s->flags |= PL011_FLAG_RXFE;
> @@ -261,7 +262,7 @@ static uint32_t pl011_read_rxdata(PL011State *s)
>      if (s->read_count == s->read_trigger - 1) {
>          s->int_level &= ~INT_RX;
>      }
> -    trace_pl011_read_fifo(s->read_count);
> +    trace_pl011_read_fifo(s->read_count, fifo_depth);
>      s->rsr = c >> 8;
>      pl011_update(s);
>      qemu_chr_fe_accept_input(&s->chr);
> @@ -496,12 +497,13 @@ static int pl011_can_receive(void *opaque)
>      if (!(s->cr & CR_RXE)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled TX UART\n");
>      }
> -    trace_pl011_can_receive(s->lcr, s->read_count, r);
> +    trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
>      return r;
>  }
> 
>  static void pl011_receive(void *opaque, const uint8_t *buf, int size)
>  {
> +    trace_pl011_receive(size);
>      /*
>       * In loopback mode, the RX input signal is internally disconnected
>       * from the entire receiving logics; thus, all inputs are ignored,
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index b2e3d25ae34..05a33036c12 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -60,12 +60,13 @@ imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIx32
>  # pl011.c
>  pl011_irq_state(int level) "irq state %d"
>  pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
> -pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
> +pl011_read_fifo(unsigned rx_fifo_used, size_t rx_fifo_depth) "RX FIFO read, used %u/%zu"
>  pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
> -pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
> -pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_count now %d"
> +pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%zu, can_receive %u chars"
> +pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
>  pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
>  pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
> +pl011_receive(int size) "recv %d chars"
> 
>  # cmsdk-apb-uart.c
>  cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> --
> 2.47.1
> 

-- 

