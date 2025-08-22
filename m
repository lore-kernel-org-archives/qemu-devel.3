Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EEFCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 10:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upPCx-0002UH-CP; Fri, 22 Aug 2025 06:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upPCv-0002TE-3t
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 06:41:17 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upPCr-0004IU-9n
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 06:41:16 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M9v4Fj1635516; Fri, 22 Aug 2025 03:41:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QM4feLsuqeOZgtrWmwA2fW8Y1qfZF/WHLFR+SYHMZ
 aU=; b=1r+XfvR7Q7hhw/sG6Hz1u5XXLTw9XgQ/cOLP4xLduTLJOkTqkF6PFwvpK
 UAZBB03x/Pgxng+AR5Zq25baSOk0tDacV8Vm8pD0l56zmpvxIIkSrMnS3Q1wmDj3
 2IZoFQ/y+hJnBZe9BOLw65McBr9nwt3+o0CMIXovJ6QgKDPZMNY3TWF+rE1kC1Dp
 js8LU5skXE7P6Z0E5Koqn2EQhl39OZNVMqljIYsCNxmbbYUz4/kBYndEDqfr/LG5
 47T2xOldrohB5WeXCX3/AQBVBdWr5xqKQZEtcL16LaIhFf6klgmmbIFo/PuUh3vt
 np/mIio8Kfl/r49SbIv2k2/oKmb9g==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2091.outbound.protection.outlook.com [40.107.95.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye8q959-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 03:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNjAgVbn0i2UNd4cfFqpI81ng/iFRHMKoMsy74KtR+EpDXcQQERkW3S1O6poIcucmZgv7e/Qr2LhOlpdTos2hcrgJoK38j9DyNNLQCukxwViga/fpTs441QCSrPkbryNB3LxXVd8gZ8ISi3ErhHBr9wkK9A3U/W3hEV28zBpdOR3eVVFZkspTCErXKjoGImDPGArUVkEHuA0s6RIjVk94/dnPNrEqnbZUBGYh+p4hQJ+mpQ4Edmz67P+LkLeg+UX1entx0pDN95Us3Du+ZDVNuU2Yqe3pHcLEYV4TftwBOKY8E31vQTE8NCJ/9HsCTQHuglXRTQdVHsmyRlMfmdN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM4feLsuqeOZgtrWmwA2fW8Y1qfZF/WHLFR+SYHMZaU=;
 b=RvFWv1nc5wqptwuoNRWr7oKZGTUQLycxd6nDSboaiA6ycNQ2AujV08Hly5Vsga7yHpLHDYGZT7TcI+PH0oUk8f9GqP3WYj4r5lHlMK1aVSjfdRNKnQJdlRkV4VA1CZAg0KzQo147e5a3/Dwjb7GZUx46QDYsH5T3Ea21+MlxPvWqyhh4oNazLK99jBEuyVw3NFuSeQ6vOvetHIfMXEteyDK2vWaZ03nvh5jVy0YhvhuO13hljAyqKlzSNvwRyHyX8nyvNPhCHGOxO4BJlc84d4ZJxhQF1koAuYBf8lrBlaFai5NIdgU6AmPXf3rzh456ZORyCN1TyrblhyIdtWnaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM4feLsuqeOZgtrWmwA2fW8Y1qfZF/WHLFR+SYHMZaU=;
 b=XpdmEEQM5YJ7IJ0VAOAF5BonEustQX0Sl583Hy6LPVZNf/p3xtUkJ0GE0qcyRj40wQm12lvTannv0GrZuGpPMRoz+3InkXjoZQFxT6jUEwSaIhPu9tcn4n/nqikMQLvCjRUurbh/ys6lBPzAIW2czMonmJxw+Zsre/KHcJXrUXzoGlWzaPassaPZamfeXzVd8F7MBebhZP3Xp770lTLGI5Pdtaq2QioQFyk92ywNLZRyqI9a9BJ41Rfuzo/6shOvhgIzca07Ggze+Yu135c46PjnbdrwQ5pNhq+JSmsbDmRLBpNUkisbYWhcrJqG347LohEgPW2jMzNgU/NSgqdGUQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM8PR02MB8124.namprd02.prod.outlook.com (2603:10b6:8:1d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 10:41:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:41:02 +0000
Message-ID: <ac0e35e8-82d6-4d31-a399-fae94cc5f7af@nutanix.com>
Date: Fri, 22 Aug 2025 11:40:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
 <20250711095812.543857-10-mark.caveayland@nutanix.com>
 <dc737fa6-7878-40c0-9922-0b2865a95b60@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <dc737fa6-7878-40c0-9922-0b2865a95b60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM8PR02MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4f2268-019e-4b59-8633-08dde16863f8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE1JZGxxNEFwcENvNnFraGlLWVFpYUcwd2pGZDZGaDd2OVFoWHRPN0ZQUStj?=
 =?utf-8?B?ek92QnA0Y2NZb1FRdlZFY01MK1JrOFBFMDdadkJGZS9zTm1IVkIyQWF1R1pM?=
 =?utf-8?B?RmNUdDFBekRRRTdxQ2ZtaVFpeVRDdFB3OHZLRXRYdGVGM3N0MzhxNUVhR3FO?=
 =?utf-8?B?SWpIRDZzTm5WbTU2TnIvZEFuclh6WjVvUzR2THhkUlZvN0ZmVUgyc3NhUVh2?=
 =?utf-8?B?eEpPdDZycmt2YlVKVW80Yk52MzMydVlaR0F2UHRCNjJBQUNYalVYYWhzN1Ay?=
 =?utf-8?B?YStiNytoWUpRY2ZDMEtIbDk3bzQ1ZjJuNjlvbUZudnJ5cnhIZSt5RXg3ODcx?=
 =?utf-8?B?eFVUdFZlbjJkSVBRbUhBNUhvNnlLcEMvNUg2WmVOcHNDKytydGVUMCtTTHd2?=
 =?utf-8?B?anF4bURPcGhoa2FXK1BXYzlVUTBOUHRmemxtRlYxdzA2WXJ3Wm9UVmtGSm96?=
 =?utf-8?B?djFjM1h2MlVrU1lMRklnWEUrbHpWbnZFZEdQYTJZY09OdEpGQURUVW5NMjQ5?=
 =?utf-8?B?cTZ6Mm1ZSkxyZm1nU1VEb0Z5WjFpdmxHZGk4UWtTUTJCb3pHVkcrVVhjRXUv?=
 =?utf-8?B?dHNpc21VWEM2d2c2QnpPZnVrWHBkZ3EvKzJOeWFDdDFXTUlWbDBINEdhaWpr?=
 =?utf-8?B?U2NsRlM1UVQvb1hRRzFhbWxuQWxyZlVWN1p6VWduKy9EaGNYMzZUSEtmcGFh?=
 =?utf-8?B?dE5KbEN4eWNKc09jNVc5MUgvTDR5aVdIOVJkdEVkTjNtYndJcG04bzhZL05K?=
 =?utf-8?B?anZ4UzdmY2RsNmViWWdFUlF1OTU4d2RRaFFQa2xhS0xwVmQ3dGViN0RsUllR?=
 =?utf-8?B?U1RSRCtQaEZiVmJ3V3ZmdkFDaVd3akZJWExGTFVSQVFmeGRhUytTbitndER4?=
 =?utf-8?B?bFh5OXNndnZFSHUxODVNSkNZb1plUG55SzdsQjN6Z0pacW1UaFlaTUlPb29j?=
 =?utf-8?B?OFRxN2VjQ0FtY1h1L2JBTWlKVm5xZ0h5TTZITTFvWXVRbzd1c21FVGo5VHMw?=
 =?utf-8?B?Nmw0NnBOZVMzR2c3SThUSVBoRERXbS8rWWk3QWd6L0xCWUIzZjMyTXdxWmdY?=
 =?utf-8?B?RFBIS05hK3FGNHNXRDBnQzZtOUoxNnA4eGpDOHFnMURRVHQrUUlER1hINlM4?=
 =?utf-8?B?d1g3cW83YTZab3k0d0duZWF2ZWpZa09lSll2S2NpeDhpWWh4cmh1YnBtb1Uv?=
 =?utf-8?B?SjRRSWxaNXpSdW9QM1AyT3lrTE02aXllbHpONkI1dTJ2WFRxNXNZVHZ4bm95?=
 =?utf-8?B?NVdtTTUwSDV0Y28vNkVERXdpbk9aaXpjWDJrM0FMUmZmR0ZqWFNaUTBkaEY0?=
 =?utf-8?B?bFhIM1BnaFJ2VjFKVEpGcU5uanVBRkQ3dUhhQ1A3RlJGRHJaQWk3U2EvK2c0?=
 =?utf-8?B?dVpwVTZTL2xGVHUvVVZLeUx5SGI4Rm96cFR2YW5jQTk1bnZQYldGNDFIQmJw?=
 =?utf-8?B?VWFWMEE2OGZWeDFrcDV1UjIyT3Yza0JhZmlrN2ltN2FlZGtiMnFxaW1mc3pO?=
 =?utf-8?B?dXpQV1VYdjVXRC9BTENwV0x4eTBuY29yQ3YzUFFnYVkvUVVGUjZsRXlEcjFV?=
 =?utf-8?B?OUo2Z0Q1SkpXTVh0VFZsUjVMU2ZYZys1K3ZkWlJHZ011cUhDV3FudXhYVmM2?=
 =?utf-8?B?OEF3aDBFYm5hMzZqbUpEZFQ0OUpXemUrVXNlRVhYSmM3U0trQ1BwSnJ6RFhh?=
 =?utf-8?B?VGo4alI4QndBZmQzSDRKVDNYS0Q0aldXdXh0YnpWTFNhOTUyMDJnUnlTOTFn?=
 =?utf-8?B?NEI0UTYreXlGQUg4YVVSY0RFdDNZRS9PbkhYMWN5UTF1RTBHOERYSUtKS1M2?=
 =?utf-8?B?emZIbEFiR1hWWnZEcHVOQVY0R29EUHpwSjRGTWpPNThjM1ZTNytLRUczZTk1?=
 =?utf-8?B?eEkzOUhYd0hlb2NPbGYzYTlxLzZKOHExeXNhYVNrdW53b3g4RmNTeHA3Z2pK?=
 =?utf-8?Q?v9CWInSBSuQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emp5M0ticU05UUJXb0xQYldxa0tnVzlnekdsMmNUN0JpUy9jOE5jU0s2RHp6?=
 =?utf-8?B?S2JhN3BRU3VoU2hSOVVhelBNSklTSlE0cGdUL0hzZGhYWlFLZ3I2aElsMVQx?=
 =?utf-8?B?ZUttam44ZWNxaXVTWW0xWDh0Nnc2QmpvSGhZdW02MVZUdU5Ocng1VlZucVdE?=
 =?utf-8?B?OVNmak85K2FHK00zMndKWFJFSXI5YkI4ZDRxMW1rdUgvK2wrQTdnUi8yaGtJ?=
 =?utf-8?B?NndndmZHS3ROeENra09EdklrSmp2OUppbjA3UmFPdSs1aVJERWxJeEs1SmVP?=
 =?utf-8?B?eVgvLytmbUszeXRZVjZTUVUwTDFMN0RPaGQ3UXZOa2MyUXB4V3VVczFLRFND?=
 =?utf-8?B?US9SRTRJNWRxUmptZkgrYUcxR0pPaTdNNHQ2cVcyeDFvcHFrQ3ZFU0tXUlhK?=
 =?utf-8?B?Mjl2ODZXdm5PRWsyd1VZM3U2VmluMWFLeENrZ1M3RTlSUFBUakdrb3Bnb28x?=
 =?utf-8?B?ZmkwYzZQMkpJb1dDWEhDOTFjamlpNmN3VlNINzljcEdPbG5RWVNSK0syS3NQ?=
 =?utf-8?B?aUdBczZmbzRIQnJWb2NBZ1VSN0dtNWR1NzRCaVIrUVRaRmtyU21Mc3V2L2JW?=
 =?utf-8?B?RUZXVFJLSVh0UDJROXN6dWJORThoZTRKdHJSUEJDbWIzdUdTWXFteHJYdGZB?=
 =?utf-8?B?NlZhZnVvdzFPZlA2RWppVVF2RVpNd05HMlc4NDRyVTRiQ0RVTHpWSCtBQktY?=
 =?utf-8?B?cWsxREMwa1hpZzUwT0ZNc2JiL3ZBSzJHVDhZS1c0YW16aDZhOGlYRjEwbEJy?=
 =?utf-8?B?RHI2MnlKSzY5Y09kZldOZlFUWlpUVmxZL3dkeEdmS1cyWFltdXBrWmQvUm8x?=
 =?utf-8?B?UitnNUtTVlIyZFNsN0p0TEpobWt4bTJDRHdmZUpCV1NscVJVcHFKSWxQTUp1?=
 =?utf-8?B?ZTMxeXZlS1BXMWJYL3BWWWZPK3h3TXhPVkZ5ZVlGT1ZtZEo1ODRMTFI5dFpS?=
 =?utf-8?B?bGs5NXVaQUJGbTdMOGJsc2hWa1lxK1FWYXFPMjdhNDdLRkNwZ1BmUncwWXhN?=
 =?utf-8?B?OStWcDQvaXcraU1hdmZQQlA2MTl1NldUV1RKRHJqNlpIajJQcVJ3ZytWTVRm?=
 =?utf-8?B?TjRrZjFETjNVRXBHQ0xaOGhDcW94K0RYNlI1WE5pMkM2UUYvN3kvV2JMQTI1?=
 =?utf-8?B?eSszVW9ReVpqTTdPYkpNUWcrb3p3Smh1bHU5TlhsejNJeTV1eExGTFl4S3pO?=
 =?utf-8?B?VFlRQmVQUTdFREdPYUdBeGY3QVN0RVVwUDdBK1E1bGk4NldoRmdKUng4QUcr?=
 =?utf-8?B?MTk3YU4vMEhkVzY5OVQ2UlBuamlJM2luTXJIUHNVcWhUTmlDTDJ1N00vQnh4?=
 =?utf-8?B?N0duQmYyMHo0Vm5ZRHRBVVlXZzFFdUV6LzNkQjVZYW5pVVRpc3d5alV6Slph?=
 =?utf-8?B?clBqaXEwRDJ1L2Z2dStiT2RUSUhHV3ZzMkJFQWJkcnFEMVVkZjFKbDJubFB0?=
 =?utf-8?B?U0pEMitlLzBOQm9FMGUrVCtCb3lUQ0hMSWNOckRCNjlIMHk1ZkJ2Qkh3bGJq?=
 =?utf-8?B?c1ArV2ZRUEp2dWZ5TTBtZTFzK1VxdnBXTFFSUUU3a09wUThWY1NaejZ3Ulo1?=
 =?utf-8?B?WVl0Q1p2Kzl3VE9rUHdaZVI2dWNXaFBGdll3eXFXb05seVh4ZVUxNHh1QUV3?=
 =?utf-8?B?Umk2d241TjlVWEFCOU9Yb1dMc2Z3eTJpd01nS2hDMVd0bC9ndDk4WGUvSzRw?=
 =?utf-8?B?bEh6aW5maXBlOGIrRWRBb2ZJamVPREdDUU54VytObG1FQzlRL1NIUnJ2WFg4?=
 =?utf-8?B?NytJMXBvaUNjS3A1bEJRdjFvb0ZYNzMrU05PQUlXTUNQc3R3VFhkUGp3YWE1?=
 =?utf-8?B?b0dzODM0b2k1NU1IQzJYQ1ZoU213R2FqN3pNYUNDNERQNmhxY0dja0xzZFpa?=
 =?utf-8?B?VmN0ZDdOQ3ZYM29hL2M5VXBqRHpGVFhkUkZjT0VKUXZHeFFYSFBBU25hZDVq?=
 =?utf-8?B?MXZWR0Vhb2YwTFpGQ2VtZ3lLeUJFb0VuTE56V0FMM2ZZelBwZU5GSnE5U1Rl?=
 =?utf-8?B?dnBKRVRFZmJqVytybVBzTjB1RGdCblBrbjRGc2NTUCtYNW0vbUhJS0hreWt1?=
 =?utf-8?B?a1BTNmNMNkZnNzhONnlqS1BIcDlrWkdGZlRFRkowVmcwNWZhKy9vSFNnOWNN?=
 =?utf-8?B?aGp4R3VsNVhUKzFHU3pXbkxGNllMd1BVb0RtdmZpeWFkNzhscnFQMTQxUTJQ?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4f2268-019e-4b59-8633-08dde16863f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:41:02.8119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5BcD4K0jEPJd7nj+Wnjrws7AaCWpznYRdr+JHhnYgkRYOB+vqTMEiS7/YuWhd1f5t/G0wgw36YPqIJsB0N6KIL5bQh1A0+ImIY7jTAxsZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8124
X-Authority-Analysis: v=2.4 cv=TdPPdRQh c=1 sm=1 tr=0 ts=68a84942 cx=c_pps
 a=xRkr3fEBERm1IrZPbeY3rA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=5RuNXcndQiW7TUcz1vYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDEwMSBTYWx0ZWRfX5yhdSSZhsSj7
 6El0QGlDpFyUWKXjM6f8DjMS+YK5VN2RwJu05vv0hp13925mAMUOTAsZQww1CN/RUcb60L/y03u
 8mw0QbQdELv5bdiQ4jvpQPbjF+Spi4dQxywZiomdlDpZW0JEzmFSXnmMltUSHdEGAqSz4bBJVDC
 N7aIT5PQ5pg3m9raoWxC9EVljLL1WbyR83z0nyezW4GfRWJmbpkS2BWJlj+JNYBiyemFF4hs49I
 QJwl/0+YFqaIoT+xoat5I7f4HhrQlLliBvtaWiTO3s0awJJTcSVM69QJT/mwGoXpm2iNiHD8+/t
 2TQPwwoqPmt/0W7TfrRumVcfAFQ90491BWrexL+4WDumFKxjcBV4cdI2eVfm1An9hJYAo0e5OKJ
 HpoBrOKOlIqGXLpfrv4cpRNzDeP9eQ==
X-Proofpoint-GUID: b-GXSJQnnos3n3FjYg19mLyOUDlvsAB3
X-Proofpoint-ORIG-GUID: b-GXSJQnnos3n3FjYg19mLyOUDlvsAB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/07/2025 11:41, Philippe Mathieu-Daudé wrote:

> On 11/7/25 11:57, Mark Cave-Ayland wrote:
>> All isapc machines must have 32-bit CPUs and so the RAM split logic 
>> can be hardcoded
>> accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/i386/pc_piix.c | 58 ++++-------------------------------------------
>>   1 file changed, 4 insertions(+), 54 deletions(-)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 78f50a7893..fbd9500061 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -426,69 +426,19 @@ static void pc_init_isa(MachineState *machine)
>>       GSIState *gsi_state;
>>       MemoryRegion *ram_memory;
>>       MemoryRegion *rom_memory = system_memory;
>> -    ram_addr_t lowmem;
>>       uint64_t hole64_size = 0;
>>       /*
>> -     * Calculate ram split, for memory below and above 4G.  It's a bit
>> -     * complicated for backward compatibility reasons ...
>> -     *
>> -     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
>> -     *    default value for max_ram_below_4g now.
>> -     *
>> -     *  - Then, to gigabyte align the memory, we move the split to 3G
>> -     *    (lowmem = 0xc0000000).  But only in case we have to split in
>> -     *    the first place, i.e. ram_size is larger than (traditional)
>> -     *    lowmem.  And for new machine types (gigabyte_align = true)
>> -     *    only, for live migration compatibility reasons.
>> -     *
>> -     *  - Next the max-ram-below-4g option was added, which allowed to
>> -     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
>> -     *    window below 4G.  qemu doesn't enforce gigabyte alignment 
>> here,
>> -     *    but prints a warning.
>> -     *
>> -     *  - Finally max-ram-below-4g got updated to also allow raising 
>> lowmem,
>> -     *    so legacy non-PAE guests can get as much memory as possible in
>> -     *    the 32bit address space below 4G.
>> -     *
>> -     *  - Note that Xen has its own ram setup code in xen_ram_init(),
>> -     *    called via xen_hvm_init_pc().
>> -     *
>> -     * Examples:
>> -     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  
>> 512M high
>> -     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 
>> 1024M high
>> -     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 
>> 2048M high
>> -     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low 
>> (=4G-128M)
>> +     * There is no RAM split for the isapc machine
>>        */
>>       if (xen_enabled()) {
>>           xen_hvm_init_pc(pcms, &ram_memory);
>>       } else {
>>           ram_memory = machine->ram;
>> -        if (!pcms->max_ram_below_4g) {
>> -            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>> -        }
>> -        lowmem = pcms->max_ram_below_4g;
>> -        if (machine->ram_size >= pcms->max_ram_below_4g) {
>> -            if (pcmc->gigabyte_align) {
>> -                if (lowmem > 0xc0000000) {
>> -                    lowmem = 0xc0000000;
>> -                }
>> -                if (lowmem & (1 * GiB - 1)) {
>> -                    warn_report("Large machine and max_ram_below_4g "
>> -                                "(%" PRIu64 ") not a multiple of 1G; "
>> -                                "possible bad performance.",
>> -                                pcms->max_ram_below_4g);
>> -                }
>> -            }
>> -        }
>> -        if (machine->ram_size >= lowmem) {
>> -            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
>> -            x86ms->below_4g_mem_size = lowmem;
>> -        } else {
>> -            x86ms->above_4g_mem_size = 0;
>> -            x86ms->below_4g_mem_size = machine->ram_size;
>> -        }
>> +        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
> 
> Since nothing to split, I'd expect the whole 4*GiB space here.

That's true: there is some logic in pc_q35_init() that sets it to 4G if 
the property is unset, so I think that makes sense.

>> +        x86ms->above_4g_mem_size = 0;
>> +        x86ms->below_4g_mem_size = machine->ram_size;
>>       }
>>       /*


ATB,

Mark.


