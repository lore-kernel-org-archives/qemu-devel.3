Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059B4C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYTT-0002hS-RF; Fri, 23 Aug 2024 13:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shYTR-0002Zj-NI
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:53:21 -0400
Received: from mail-dm6nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2415::625]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shYTD-0002XZ-3p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:53:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZjD0qWQ4SAWcRbEu45DVDfbXjy7l4CMkgkLzzGZU9OGd5wCTWzo390WoAObyqwlmz37miKiB8vA8B+V2RW36aJOAsMdF5Hmq+ngLVcOqdOZzYGtoPcEiXh/n2r+08F5936sQi8FBV1sVrXXLNsam7+/KFKW4cDb+i6a4JTt2e6855epwSHDZZv7lnFxQ5ZUM/gGdJPYFCLX37Tmfeun/CL5ypaJDLv8SBpPEFUXwC25rFKpZubWYK0kzkTovHz7iawk4KJYloLTV4VOC3n4H/u8QPZ0M2DDkuHFJN+lIZoyunwn5WdRIhAsObVoBeTbaHP8gwP1wz6X5OmLjAMB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/GlPiU/QtSW0sEqOig3CIQntRFjHPJpg+dKtgxrj9s=;
 b=guEfMwOEK4KlMxovSygSe07jDCR4MHyuIJPUAtC5gFmFCCs5zwRSzw1U8cuShREfFeKphYrHHAQ2rMIrMpug7T1B6dVMqB2Mb55b8INTlKVuzzsMnw/4gN5UzsZE6dsdDRfXV4X9gIlkJUWwgiAKGqiSCG0Rd+lrOD4mKFmaoxfUlowkUQzNEobZGciiwd6++dW10lQBqh9iZIqHdKPwTzUqNKmOY706oETO/bpHyHgFd6BugaB/ouELIvFP+LAwch6iXG6uP833/FVB+lnq16YfPmdi5kj4OcpFfsDvoX+jEbWr/TBLwqpVrTD3qU2Da8J38hrVRdq6Vakdf7F4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/GlPiU/QtSW0sEqOig3CIQntRFjHPJpg+dKtgxrj9s=;
 b=SgXOAF+v8RwnONgBO7Lbs1zkmE4DQxcJCpegXmom87dIVaUynEZm7d2VAe8/4fJQOdYx/sEAMqA8YppMYmETKOFF6bfDDsmadtkzodCodFTBb3+p+d7bmsc/CBzWF8R57z1xRKlweUboHTddZhNSvc8fSgYupXlwL8n3fFnVeQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 17:53:01 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 17:52:59 +0000
Date: Fri, 23 Aug 2024 19:52:47 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Doug Brown <doug@schmorgal.com>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] hw/net/can/xlnx-versal-canfd: Fix byte ordering
Message-ID: <ZsjMbwu4TDNrzWJc@xse-figlesia-l2.amd.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
 <20240816163504.789393-5-doug@schmorgal.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816163504.789393-5-doug@schmorgal.com>
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd3db3f-8a3b-4af4-eaa4-08dcc39c6d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFI3WEpXdk5sbHUzbWtVNllPK1FCMHNtVDRVRmVqTVZXZnIwRmpOUlhRRExQ?=
 =?utf-8?B?TWJ4aDh5SkJrc3hLaDRISHRKUk5OeFhYMnRHS0x0c1NvUnQ5aGN6QlVlLzQ1?=
 =?utf-8?B?MU9aMkpmYnpYV3A1UnR3djRLcTBUTm1Ga1Y1ZmhwUWVLSEVMZzVZY2I4Y2ZV?=
 =?utf-8?B?bmhNVU0xS01RSGJhWnE0Uzk0ZWNxSnVHRkZQcFBXaXY0eDNvNldHaG41am9U?=
 =?utf-8?B?ZC9UWTRWRFFuV1IzeTdVRVRYUmo3MWs4WjdQWmNuL1JrcTlTUjdQTHgwZmg2?=
 =?utf-8?B?Z25Waytmd2x2dUdVR3c5V0FnQ3Q0Vk9zOU50dTl6eStRODdIQWR4UjNPVWNE?=
 =?utf-8?B?SXRDMHNMTUdkQXZsdFhZNENBd1RlT3RPMlhLMlp2K1hCaDV5M0tRVHRicWZ6?=
 =?utf-8?B?M1RXQUZVMWx5Y095L052YTRsaVgxQ29KcXRiU3I3bG1YYXJiaUlBTUZPZ2Fy?=
 =?utf-8?B?dFlZSkptUDRrRzlicVQxY0lPYlhXNXkxNlBXZ3UzSUduTVVFRHIyQS9GRUFs?=
 =?utf-8?B?WWFFUkxKZTE1ODlVZzFRa3dzMTI2eXFXRDk4Q1NTU09tblFPUGFuTzYzOU5o?=
 =?utf-8?B?TEdWVmJEeVpiTnNVUG9OaVY2WndLWlk1dE5JK1lqelZWbCtXU2k3dGFKenpZ?=
 =?utf-8?B?aHZHMTdiRHhDM0RGTTB4UTNzN3dYb0NqYThoekJ1K1g4c2lKSGFsNkg5VnR0?=
 =?utf-8?B?UmF6WHdsY3c1WTVaNDNmbkFPdTNqNlJheWladHovTzBFK0h6UE9BZUUvelJH?=
 =?utf-8?B?SHdsTDZ3WU9Mb3ZzdkE3dzNYbFhJK3VIamdMRDc5a2d0ekozTlNXRXczSDN5?=
 =?utf-8?B?L3lDOC9UelJTQnVlUWYzUzlvNDBpcW4xbmMrUU1NRmo5M0ZXT053OGsvTnNn?=
 =?utf-8?B?d1AxNXl1RzlKd0FqaG41cEtqRzVtMm54cnZmVDF6bHZ4OUhtWExDc3JOMDd0?=
 =?utf-8?B?bHdTZEYwTTZiaDJmSnNzdjZxNDNrV0JJNDFmbE5xYmFUNmxaanBGTWxwUHNs?=
 =?utf-8?B?MmJJUGdBS25qSzFjcmNpZVBwU2pDR1VncWIrSkhkeXV0TFdaRjZNS1dsS1FD?=
 =?utf-8?B?SmlYZGxDeEJRTkZRU29lTjhqREJPYklhQk85em10OHM1bzRnWVREVExxWm52?=
 =?utf-8?B?eThCRmJrcjFDL09FL3NwVWIwSU9EMlUvUWx2Y3pvcFN3T1RqQlNCUFd4Mkdq?=
 =?utf-8?B?ZloxaEc0eW5EOVdPazNZM0R6RnJncDg0bTVkZGFyRytzVEhwSXdSQ09TaXBS?=
 =?utf-8?B?emVHckVaUVBGdkxyTnRkckx5Tmh4MFcvckJnV2VEcUZMVHAwd09KRG1VZnlU?=
 =?utf-8?B?MXNxUHJIUEEwekZQZG4wYzRxOTY0OUdwdVloRmJXNGJlZVVVdEVUaG5QR0JG?=
 =?utf-8?B?R1ZPSWtSQzJ0M0pLeGRWaDBUK3lxS2JnV1VsaituM09HUHFWNHQ4MU1wRi9h?=
 =?utf-8?B?cnVtNzRFRmJENnFMK0o4ajA1QmxBUFFtRitxdk5DdXArbng3NnVhajRLZzNW?=
 =?utf-8?B?ZTA4SVFGWEFJOVAybGZ4eG1VaXI0VDVFMjlaOVl2VnBIQWo4Y2R1V3kxTWt5?=
 =?utf-8?B?OVF6djJaQm9ydTR6UllIVmp2UlVTbFFVTmpCQUNsajQ4UkdHZ3FEYlVnZHA4?=
 =?utf-8?B?SUhQdHNIZ3d0K0NkUnU3NGErVFEzMHlFZytlVmh6MUNadE1sL1RsYWFFZXpM?=
 =?utf-8?B?WFFEZFYvQXlDZnNLeWZucXZ1ZTF1dlRDTThlSjZvYkFLbFowZXM0UUhwblB2?=
 =?utf-8?B?cWs2N2FpbVdtSW1PdVRJVVlaSXRRVGV2a1ZJcDRWczZtem5mN3J6TDhUUjRZ?=
 =?utf-8?B?bktHM2gxMldzYURHNVE2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNHMnRwaE9KY2srQVBKNi9wOVdJZUJVU2ZTVHQrN3NxT2NHLzFNY3l2Qm15?=
 =?utf-8?B?Sk9vUTNQOXR4WHlCL3hud3ZQd1gxaGhYa0IxQzNxSjNaeitYQXlaUG8yZnRx?=
 =?utf-8?B?dDJ0ejVodU9IZ0JUcE5sZDhtNDMyYWpMYis0R3Y0cEppTDVTNnhKanI3OW92?=
 =?utf-8?B?MkxobTdLRCs1NG1kZ2RoNkJDWWNaZ3JWa2lVSDZ4ZlpJenVqamZrRnd2aGtq?=
 =?utf-8?B?TDA1QlVOVWVuRXhjSkZ3ckZxOW1YTmRoeDN6MEtJOWR1d3cydG9Ic2NlN1pi?=
 =?utf-8?B?OGdnUmFoY29LakdmZE9jaWtFM0RZT1A4blc2eEpISk45MFJSME55MU10bmhB?=
 =?utf-8?B?SEJJS0t5RzNRQ3R5YnhudUpjWTRid0ZLdkZYK09mb1Y0K3I3L1BYYjNTWnd3?=
 =?utf-8?B?VWJwWTk1LzhVRzUxaGlFQzdPSGszOEZDMFQ4Q0dNSGR6RUVveHRrNDlubldV?=
 =?utf-8?B?c1BKdU9vV0Vmc2I1L09uMHJhaXNEVnZpNHBNdHgyUkJHT2lHYTNEL3BVWjNi?=
 =?utf-8?B?TlMyS0ptYzdzTXYzUmFnN0lLdzJ0OGhnMU02MlVoN3ZBMklrblBvd0V5Y3RI?=
 =?utf-8?B?NHMxczV5eDl2eFVwZzRRdm41a01lR1F3MWxHNUJORlVKNXIzcXVURzZwYkhU?=
 =?utf-8?B?Lzh4OEx0bzNjZUd0a3VKMHBOTGJ5S2FvNEo2QkNNUVNuK0lNMTd2WkJkTEov?=
 =?utf-8?B?blRQWDBzMFVUSk1pNG5HVXhTLzhXVmJFdG1obWYrdENSYU1LK25yNjQvMjNY?=
 =?utf-8?B?MklORTRxUDEvMEhoaDZFWWFsYmxReWRkMzR1OTR4dFlNRkdpUVNWNzNYLzRY?=
 =?utf-8?B?U0RYdCtsam1nMFFUUDZxYVdnQlZEU1VuS1VCOTlwSkZaYzJHTHhvTjFSdmRs?=
 =?utf-8?B?OE5jTUxjZm0rbUsvRnBDSmVDME51RzdpUzg2SlVidkptK0hJTTNueUlCcnM1?=
 =?utf-8?B?OHpPMElFZ0w0Y3NhRnJPZTdna0hvWGlmbldsTHZjS2hwL3NhYlNoWWxQdVBQ?=
 =?utf-8?B?ODk0NWgydURWSnZzUzNwWjU2YTQ0a05MRXRpZnJHOFdZK24xU00rZm85M3Bn?=
 =?utf-8?B?MXlkWWxDU2h1VHRaQlZhNEw5Wm01cGx4a1hjRmlIeDI3aHNXcytlTmdvajNE?=
 =?utf-8?B?V0xoTjlwL1BhKzU2bDVSa2grM1B4RFpsYktOd0pkK1gzajZwNUhUdGRXU2FF?=
 =?utf-8?B?NlJ6Y3J1NjFIQ1ZWdlBNSW1jNVRxQWU4WDdWblN3Q3ZiU3U4aEU1bEdXYjlX?=
 =?utf-8?B?OHIzWkhUZEtOWG1YQlBBNjR1WFozaVJlcW1BSm9OWXdSNWQ1QmJ0eVVXMTZl?=
 =?utf-8?B?dzJxSlMrMnhxbUlzZmppV2crWUFsN2FVNWRpNTJ6OGYvOXEvY2RDcWFHdXhY?=
 =?utf-8?B?VUp2d01JQ21wN25xY3crNUQzQmEvTm5OaUF5R3JjMjdGOVFueitVRUt2ZDI1?=
 =?utf-8?B?RGczRWJaemZkZXpIL3RQZklFUis3OTJXWGFKRjRuSXZOdFNnQjVkNElTSG5H?=
 =?utf-8?B?Q0J4K0pOM255NDVRTmRDb2Rha3ducjB6eHBmYW9ad0ZCdHdaUjFpQkJYMEo2?=
 =?utf-8?B?Q3d3RU9xNHRPVTkrSklsb1M1VmVoQnJnMW5ZSXllRHhxYVRSbGxPWlVtUEFU?=
 =?utf-8?B?RmxjYlpPa3ZmK2U1K2srQ1FPMS9lQ25nT3Y2Tms1eVRDbEVCa1hKZGkvZGxa?=
 =?utf-8?B?eTNWNmNZelg4Wll1bmhCNitxYmZMNWFtWW4rWHlUcHJrRG90azhRSDVVSlNu?=
 =?utf-8?B?a2oyZCsrOUxsdGoyOWsyN3pBS1hYamlCZ1NLdFoyNkI1aW5vMzZKcWczMkFM?=
 =?utf-8?B?UksvekdmaHAvNkFXaGY4S200QTE2cXhTR2xHNkNWT0tMSFM5U1FHTXYwN2J0?=
 =?utf-8?B?OThnTkVCdUFNVmZZcjAyWkM1Nzd4VGlrenRXZ2tDMjhWWUNTT0VaaCtTUkRX?=
 =?utf-8?B?RjVVekE2czdyYk15TWpaNTNWNE5DZU1paTVTejZacjVGTlNlMG12NzdaRlFr?=
 =?utf-8?B?UDU1anBZOFdacG1UazZsYkhyRkdHREJwRHBya29mZ3U4UWlPRDltNXRtRXV5?=
 =?utf-8?B?WklzRGRmVVBYeU91L0gydWJrMmJYelVSZmJoTzlrR0wxYVJBZEFYTkpVblN1?=
 =?utf-8?Q?fFFH6vB8bzT0PCt3RgzW+Sz5d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd3db3f-8a3b-4af4-eaa4-08dcc39c6d57
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 17:52:59.8802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BkJuZY6qnQWd6bwGFh2gE2/zNcyZsNdlRk304xIJDRiTmLKbJDHbk5Ji7AdItlEql4IP4qtuQf/Ebcb3gNEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
Received-SPF: permerror client-ip=2a01:111:f403:2415::625;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Fri, Aug 16, 2024 at 09:35:04AM -0700, Doug Brown wrote:
> The endianness of the CAN data was backwards in each group of 4 bytes.
> For example, the following data:
> 
> 00 11 22 33 44 55 66 77
> 
> was showing up like this:
> 
> 33 22 11 00 77 66 55 44
> 
> Fix both the TX and RX code to put the data in the correct order.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/xlnx-versal-canfd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 1704b558d0..fda1e7016a 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -945,7 +945,7 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
>      }
>  
>      for (j = 0; j < frame->can_dlc; j++) {
> -        val = 8 * i;
> +        val = 8 * (3 - i);
>  
>          frame->data[j] = extract32(s->regs[reg_num + 2 + (j / 4)], val, 8);
>          i++;
> @@ -1080,19 +1080,19 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
>              case 0:
>                  rx_reg_num = i / 4;
>  
> -                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
> +                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
>                                            frame->data[i]);
>                  break;
>              case 1:
> -                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
> +                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES1,
>                                             frame->data[i]);
>                  break;
>              case 2:
> -                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES1,
> +                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
>                                             frame->data[i]);
>                  break;
>              case 3:
> -                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
> +                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
>                                             frame->data[i]);
>                  /*
>                   * Last Bytes data which means we have all 4 bytes ready to
> -- 
> 2.34.1
> 

