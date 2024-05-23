Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E51C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2iE-0007VA-KZ; Thu, 23 May 2024 03:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1sA2iD-0007Ul-17
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:18:05 -0400
Received: from mail-vi1eur03on2110.outbound.protection.outlook.com
 ([40.107.103.110] helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1sA2iA-0006rV-LS
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:18:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA9MHMiHLCvpbgOZ4pQzwwYRkFIkYdKbDYkCk3vxbM5qBakOoXdbgrz6KPDNzV5cwRLlfXLjC5/bia6kh3ezqjIo2ov7NNC5s6Tl0Kq/b+e/NfJy/ErnoAd3BliFocSgXH7pXoxUiHO18u1AWt5PAABvAnf9vBC0eNAoUPNDfBrOWRNP/gcOKHaDegjaHdwzK+CQnhstvXrxVlGiF7wt9DBR7rbPE/q/JtiI0AIEx75/0xB2LEaJKVfI9XGYgShm5XvaQx40gdZNMZ2Gfp4olL0zXOlp3RJpEh3AImNj9sGZ8EpgJCew+0dnqngCQ2qyMu/niTHJVF0XSgRM3O4olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZvuxMW+yGr2gdyFiO94tjUH7dGqZrPfRQw+CnNPV44=;
 b=lz60B7vZmIJ/oZXd8Iws0Hd24CXoq3/5SfhZ8Cc43Fe0dKaNiXdDhDa51BI+kEGQ/ApYv+JUTVAl83r/CRLbBX8uwYfzytCXV9VF9ZUxF5QLUCW+HMLfqYVe1CjuKX9XL4ldjN5wXEoT+/pzN9128/uayQgK3LnN8j17AisEiu/IyxZYZbRk4rCuJsd8IaUcv3MBnNMga/7AyFYYIvV6rq8ymoF41sZWJCrRH+ahW+NALdTleJoVetc7Lb1unuVGAhECOVzSAiX6+jEsZOaU+2in795fZkMs5y8ow8b7OUZw3ppa7u9TjerHoLDgzEXcVz6V/xbXHPJztdvDwqpgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZvuxMW+yGr2gdyFiO94tjUH7dGqZrPfRQw+CnNPV44=;
 b=hFe26vJUnTQOLwjobW9SPVGVQwLshHCYVtRna9q31GZqkaWPmO7r0M8xG0xyeB2KIA3intjPQfna+0aEwJr305fgrToGof5X0HxtsxoTI9XCpG2L/FhbyCqiDgAKXGHdtxKs/pAHJuI5KcJq/nxwgQGFSJGesXS64zcY+9ZKGa/ktSJXxx8M1kBEiTCSsWfMVxpEaZUXL+Yq14rHl2tGdLnV1yV4n0lSwLWaAlwr7btt31Pk8t/d28GOO9SMfXZAR0hNdblnLWdGgJ6Ml1hcKfUTAMrmz4OaAdEEqfs4glv42A0BDPvGbaq+s1/pxaLnJIBJAzlbL2tQbYW8OhIcpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS4PR08MB7408.eurprd08.prod.outlook.com (2603:10a6:20b:4e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 07:12:54 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 07:12:54 +0000
Message-ID: <3438f0db-120b-493d-ab61-71311699797f@virtuozzo.com>
Date: Thu, 23 May 2024 09:12:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: Add an interactive mode to guest-exec via VSOCK for
 Linux
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
References: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
 <Zk4Y3mw2DU1KKeGV@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <Zk4Y3mw2DU1KKeGV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0164.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::21) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS4PR08MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c793da7-9fc2-4d35-bd8e-08dc7af7c34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkY3cnFjalAwdXZyQ3BDcGZnTEwrTlgvZENzVlhrSlIzNlhGSmFrL3hzKytE?=
 =?utf-8?B?ei9JTDd3bEtxZFRIWUpWZFd0Qk1mSDB1Yi9xVVFXRFFLSnM2N0p0OWJOZTZ1?=
 =?utf-8?B?Ukg0YlJRVnlVRWpDN0dOUHlYME5qeHZCTnlFNFIwN2FFTnhBeDZ5MnRlN2J0?=
 =?utf-8?B?ZWU5NzEvK3Y5Nlh0K1JwM2tZZ1pGa2U5dVJOSm16c3l0aUlFZG1iQUtuTUFD?=
 =?utf-8?B?VVIvZnR6enV0cmtTd3NtcGt2ZzBNV2FGTE9YSUx5N0RpbjRJQ01SdkNLSlRK?=
 =?utf-8?B?RC9TRTErZFA3Q0NneEJnTlU1N3hDSU1VakNlNGowaVRxRENINWVJcFBkWFp5?=
 =?utf-8?B?V3kzSDVnalMvQ0F2ckhOTHhDUXNQZGo4NWpQU3BKZ1BoYS92NUZMdUxnUXBH?=
 =?utf-8?B?UG10WWQxczRSbFRSQzBmbGVYMmdrcnF6bVBJdSt5REQwVHZaaCtaVHRTaFNq?=
 =?utf-8?B?V3pveEY0bEVnbWtBTzNUNUtYRWIyWGJuV0dZUW9JVitHL2FzQ3pLVVhwYkFC?=
 =?utf-8?B?NUJmTEJzV3NJNjI5U0NlOXhObTEya1RwTXo2bmdOOW9YZmM2eWVpYVc2Mk94?=
 =?utf-8?B?ZjBtd3NRa292VER1T3JVN3UwUXl6K01GemFpRkQyTHN5dnpFaUtEdjBxbHNh?=
 =?utf-8?B?Q1N5VUR1Nml5MU5PYkhwWXVaRjNlcVFLRXF6OTVsL01JcXlXUXZmRERMelU1?=
 =?utf-8?B?OUMzVERmNFdTeTNsclFyaXJGNFF5RHI3MzVsQkJsakE3ZElsYkRIYnpWY3ov?=
 =?utf-8?B?L0lpdWRXMVVnQmlsRTdhcFVDR1BBM0pxUXBMUTk0MXpqUDBJbUl3SGV4a0Z4?=
 =?utf-8?B?c3k1U2c3OTdrRmJrQ21sdW5PS0FVaHRpQzVlTUlFeDlKYXVWL3VON0JMbDF4?=
 =?utf-8?B?L1FzSHhXUDZSNHZTRzlPVm9xRFZSZlYyYStDKzdGY3JkM0k2d1BIYjEwbCsw?=
 =?utf-8?B?OXpFOGduTkRic2tWUGlUemR4NVBPRHdIbVdFV1M3OEVSRjYvN3djc0FKTFpr?=
 =?utf-8?B?T2IwQzdFMkw5Yzlwa3JHL2NWQzA3T0svQXI5QTF4Y0dMS3I0QjhOR2xXNXlX?=
 =?utf-8?B?NWE3YVJqa0wvdklHZFRnRG5qUnZ1alFOMkYxcG1hRTV6S2xoWlhVUEtJRm9Z?=
 =?utf-8?B?dUZlWjdnT2xSdnB1TzU3VFVBTUZQTWx1cldUWjdiZWdsMHpxcnBCWTVXSk5B?=
 =?utf-8?B?cDVFbzVNdXhONndWTCt2bFBzeDlSWTRCYmtzbGQrbFphM1B1VXFzSHdwUUVp?=
 =?utf-8?B?azlrbkFQSWpnWEhZUGxuTXhZTXBTR0dzd3Y4R3hQSGxJWTJwTnU2ZUg4Ulov?=
 =?utf-8?B?OTRQNUNtYUxEMXhJRkxoL2ppdkVHRFE2bG9vUVZrU05FS0c4aU5EMnhuQUpZ?=
 =?utf-8?B?cjg2OUVtOWhmdzluRTFHRzdwWmthbExsb1BjdW1tZmFiU2RSQ0czYWhnVTlG?=
 =?utf-8?B?K3doZitUd01LMEpYK2YxN2NHSFIzK0VUdTBzTk1DWTBQODdKdHdPZWRyTEd4?=
 =?utf-8?B?SzE2WloxbGFVNnFKdFRJeDMzRVNwdzFMaEFGOGxqQUdYOEdWWSs3MVRkMmJG?=
 =?utf-8?B?VVp6R0NxeitZTWxsbWYxdFd5NkpvZ1RhVnZ3NDFGb0czSVJ0K0FYTVptUjUv?=
 =?utf-8?B?dS9SdERIcXhJdURNWDdueWdFYXpJUGlMTmFPaXJ2REl3czBRNDVWY3FON3ph?=
 =?utf-8?B?aUkyUGFsUFRpSnhxMUVud3FCSXRPdkdQK0ZMVUU4ckU1bUJjWUM1SGdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmxoczFERmJ0eDJ1TTlqbGV0NkdXQW1NbWNabFcwTjJMd29OL2lKN1pCSzla?=
 =?utf-8?B?N2E2a0Q4L3h5ZjJMdkhMU3VMTUZxR3ZkeFRzVEM3aG9vdi9kSXZuMjdRNkhI?=
 =?utf-8?B?eWhhUXdpSFB5bktvUCtWdzdQaGVkblVPR1JuSnptSUpBQTdJNndwRURnZitJ?=
 =?utf-8?B?M29pT1RtM0ZJNWk5SVUreHBreVg3dVJrZjlXc20xc1JDaHFRTnFZRURJYzZ3?=
 =?utf-8?B?THBKVGl0Nzk4ei9Lbm9vL0ZINGs5cEErQmY5amVQMGZUQk5ROWU4V3ZCVjNF?=
 =?utf-8?B?ODlUdzB1UDQwT0I1citNbEpHU3F3NFZZdVRaMytOVzVVd2FDclJjSXNQS2Zk?=
 =?utf-8?B?eVdJWUl0TGM1cTVTUHhnYTY1V2ZrbGlrUUs0RFN2V29MSzBXR0swS3ZlL05M?=
 =?utf-8?B?ZHdzbDIvdUt2VUtoSTRKOGxrTVE4R1JWMENORW9rNkpPdUQzUjNRSDFKK1Jh?=
 =?utf-8?B?Mis5elcxTm4xWlQ2VGJMdTV5alZLcnFTYWd6MTdQcVhmbk12eGlDYmNITzRk?=
 =?utf-8?B?SjZTK2tTdmIrWVE5dGV5QVZCYjJqRXB3QXJBMGJ4V3BCUGc3bUsyMjEwL2w0?=
 =?utf-8?B?REVtM3RxZDh4RngzUXR0bEhWeHEyRVU0N3JCbVdVdG4vR1BYejhJcXkvM2Zi?=
 =?utf-8?B?MDEvSVRCZ0M5dUVnVXBIbzFFR3JtQ2tpcXkxeTJtVjJzVytNVWV4QXNJVW1G?=
 =?utf-8?B?QjNIbEd3RFM2RjFIWVFkYTd2RHd0VlBHbDJDUkxscDJrek85REFFNDZIUmY2?=
 =?utf-8?B?OXlnZEJIaHllbXRwUElMZlRXL0ZwYkNqb3FtVjAzdWU5WnpHUXNpbzZ4YXBn?=
 =?utf-8?B?TnltNU1nb2lJd0NBcW5tQ2w4QTBIb2MzTlV6azZaRzBTbzZibFNBQ1RrU0dV?=
 =?utf-8?B?RG5DVDFIblVaMVdVVENqRGN0czhRSW93OXE0OWZNM2NYWEc1RU9pWi8xajhK?=
 =?utf-8?B?eW93U2Q0czBvaElHWkxseDl6RkZwc2orVjRVNmxwRVBXMWFUeUoycnhzMzdW?=
 =?utf-8?B?bkhpbUxpaDlPL2NGYnBCUEwyNURjWVJpdlBpRS9iL05zVmpsZHJ6em5FWGxR?=
 =?utf-8?B?emNUYWFDRVRmcFVxZm0wYjVEbURVakFpUVdpM2dKY09acTBQMHBCQTRKbGVi?=
 =?utf-8?B?OUYvdmNNeWdhRzd0RzdSRzNacUpSWWwwQXNmRkZvSUhnUzFtMzU2ZHQrMzg1?=
 =?utf-8?B?QURxRDA5bW52OHdmUG8rV1M0YkpIK0xWY0VBTlVGVm1sd0ZoTXcxei9FbEta?=
 =?utf-8?B?WmlEbjNBMEo4VUIvdWNqb0NGRFExelloemFQeS95MFo3RUNsZ2hCOVJaM090?=
 =?utf-8?B?TDlYczJBR283Y0RaWno1MTBNZG5nSm9jZ0ljcGZiN0ZPZUl0WmNQejRlYXZT?=
 =?utf-8?B?aFFCRGp0TFNpS2ZBcHdhNWEzRk1BVUtOaW03c3VBUEtlM1d1dTlmclc0Vmdr?=
 =?utf-8?B?alNBZEpUNnFVbWg5aHdyMGNyMG0ycUZ4QUM1SjFrMFF2L1l5WEZDZTQycWI1?=
 =?utf-8?B?SVAvQlBreUlrRHpFREFlKzRuRm9vVjJGTk9rRHJtdUIrNlc4OHFjQ3JsaTdO?=
 =?utf-8?B?dXNRRG0vcTBvTXArUkZ5dmN3Zy9LZmpteGRQa0IzclpEUVdxN1ZiT2ZGZFYw?=
 =?utf-8?B?R1VwenJXUm8zL3JUUGxwd2R4SWllVmFGdTlBWFdqeXgrYUx3TSs4d3l3QkUw?=
 =?utf-8?B?NXZOZy8yMTI2QW1FSWNsekcyb29McXZUSzYzUUVxbWl6amZSbmdBYy9nb0R4?=
 =?utf-8?B?eUMvZXA3bFRnZ2oybUJnOVZ5UDlZNUJkakluZHRkZHVzNHBKWHJBWmVNblVD?=
 =?utf-8?B?Qk9VN1BDSmhVV1VoUXVKVWIyWVN5bTU2RDY3dHpDVmVtb2pLM212OHZpNlp5?=
 =?utf-8?B?cU9PaVdLOW9hOHNFTFFUeEl4N25XM1Q5eUdjWEpYYlYxMVgzdnMwNzlQQVVI?=
 =?utf-8?B?QmZoV0sxVk1pZVlxOWJ1Z0prU2R6Y2l2Q1NKYVlhVDhEbVBDU29ycmFxVEZW?=
 =?utf-8?B?VFdxZ2lpWVJzMmNLbEw3bVdUendzWjZxY21RVWE2U3BUNVE5SWg0SzhYc1Ay?=
 =?utf-8?B?WlRyVFBqbXhJZjJpU1ZyUXJLZGRYcmp6Y0MwQXE1UHZoSlBrSnFRQUJJdzJP?=
 =?utf-8?Q?GmL/m6G+0gsiGgum5awLBT5l+?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c793da7-9fc2-4d35-bd8e-08dc7af7c34b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:12:54.6233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hk+Wx+BYKTiOgxCCpW23LfC+0uGlqjTV03iSWanf9KbB/X/5y2W6hhgsPikcRyVPND3HGiTIQQZhh5KB+rIZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7408
Received-SPF: pass client-ip=40.107.103.110; envelope-from=den@virtuozzo.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 5/22/24 18:10, Daniel P. Berrangé wrote:
> On Wed, May 22, 2024 at 05:06:57PM +0200, Alexander Ivanov wrote:
>> Add an interactive mode to the guest-exec command in the QEMU Guest Agent
>> using the VSOCK communication mechanism. It enables interactive sessions
>> with the executed command in the guest, allowing real-time input/output.
>>
>> Introduce "interactive" mode in the GuestExecCaptureOutputMode enumeration
>> and add optional "cid" and "port" fields to the guest-exec response. In
>> such a way user can execute guest-exec command, get CID and port number
>> from the response and connect to the guest server. After connection user
>> can communicate with the started process. All the data transmitted to the
>> server is redirected to stdin. Data from stdout and stderr is redirected
>> to the client. All data blocks are preceded by 32-bit headers (network
>> byte order): most significant bit contains a sign of stream (stdout - 0,
>> stderr - 1), all the other bits contain the payload size.
> Every patch to 'guest-exec' takes us torwards re-inventing yet more
> SSH/telnet functionality, but a poor simulation of it. For exmaple
> this still lacks any separation of stdout/stderr streams, just
> interleaving all their data back to the host. There is also zero
> access control facilities beyond turning off the 'guest-exec'
> command entirely.
>
> IMHO we should really consider "arbitrary command execution" to be
> something to be handled by a separate process. Let the guest OS admin
> decide separately from running QEMU GA, whether they want to enable
> arbitrary host processes to have a trival privileged backdoor into
> their guest.
>
> systemd now supports exposing SSH over VSOCK, and provides an SSH
> proxy in the host to connect to VMs, while libvirt also has added
> its own host SSH proxy to allow SSH based on libvirt VM name.
>
> For windows guests, there is something called PowerShell Direct
> which exposes PowerShell over vmbus under HyperV. Possibly that
> can be enabled in QEMU too if someone understands windows & vmbus
> enough... ?
>
> With regards,
> Daniel
That makes a lot of sense. Why to support something that is
already written. Though I have a note about Windows. The
approach could be exactly the same - OpenSSH port for Windows
is already known and on top of that VirtIO VSock driver is
available too. Why not?

Den

