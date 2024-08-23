Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5676C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 10:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shRJK-0003fg-GB; Fri, 23 Aug 2024 06:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shRJI-0003Vo-1o; Fri, 23 Aug 2024 06:14:24 -0400
Received: from mail-mw2nam04on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:240a::62a]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shRJF-0000oy-8a; Fri, 23 Aug 2024 06:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAnE59ZcHZ/M5Bk8ynmTliFqMdh28D+U9PprEw0v8/E6+U5wOqxnjyFLrtaC8vJaLwIlMkLolLOkl8QZtB7QuZ4mA6Ie88TiB1iwlT7oM7DM0ilWiToXTYlsgQVEHyFEp8FA/T7OR3mtBDjV7SlHl5fMHcH1jn4hUp98fdzQ4Qd8w9Wtyz5Y4t/AwA/9UTqMAv7hr3OvJH8m+Cfjzqi/CKboayyh1yKHDUDXRlPIYpgTma1kxEQDXu5p9j1fykJ1x+GKYVoQMPbpdOD2kGfPEtbMMKFQNtVwYBpRSqfxNpCbx9kTu28D+SlOpU4VxR8YmwO/4fti8P1l/Lpdg6lQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xgn8aql8PaMHNb8QlPyY9tfZBwZ7HmW07XT+O3proc=;
 b=uhYvOWL4/mPvupOGm7DGLBoJ0c6HC+EtiDHjm7jF/2ztcJ6NCVAdVhRxhmyzMh2I3GEHmdOZCuk8qw7f7226lVl2i/TrD8Hu3vh817In+KW/kNv+Gkm8gOvNhEGaqtdUPNNhfQy1bp2rNOtmqnpMQAcMYT72Gk1BLR5icvNQKjRkNDAYqu+KKPsoir35KNM+S0hWAsMnhreseffMZoOSKceGv236AVTQLVgfzHmCpkpIXiY9BHMf7wOVFuOEZYWkpfUAG78NNbwm+QLGQ0Xg/uYXt53TagJQvNq00+cBcWVIIsIm1oToFIel7fVTc5iGL6aXvPK/Q+T27ttToqlPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xgn8aql8PaMHNb8QlPyY9tfZBwZ7HmW07XT+O3proc=;
 b=gdwwnAF1MxvDLognu75AfOvIp67C2FYWl6vIRmy66v8PYeGdE0S20SuHhtxwNhUU2RUjWDk4Q6DJDyPK383clfwKHGDyLv0QMXS7LsbvPBGTrryn7xPC8mhRNEm+nSc28PdHcdlqLbrUJ/xbyVcwFF9kcVDQaOk69ZZKKfX4pbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:14:14 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 10:14:14 +0000
Date: Fri, 23 Aug 2024 12:14:07 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH for-9.2 6/6] hm/nvram/xlnx-versal-efuse-ctrl: Call
 register_finalize_block
Message-ID: <Zshg7zVxuB7kb2me@xse-figlesia-l2.amd.com>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822162127.705879-7-peter.maydell@linaro.org>
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5f5807-ea50-4099-d303-08dcc35c56dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVdtbFpCc3QybThRejJxd1BXMXhDZEszVE5sREJlVUs4RVFRb2dXQmZ1MFhp?=
 =?utf-8?B?c1dodFhVbExJWHcyRWxYeXRvT3hKSEtQdVZ3OEtBS2ZWaUJycTVrOHR4U3FB?=
 =?utf-8?B?akpSMnR0dFlrQ3VQL3NsNGFSaEk2VzdGL1hidGcwSVNuRWtJcVJ5OHpSR0lK?=
 =?utf-8?B?Q1NJMmZKa08xdkdaektidjYyN0xDUmtoRmNveUV4V2hLV3F4cVhsTU9FMDM5?=
 =?utf-8?B?OWZYQmZ6eVFMZlJ3aFl4N1lVYkkwc3AzbjNWbGViV1NUZkp6YkV2REtQdmhk?=
 =?utf-8?B?V2xPclFkaVp6L2ozZUxrL083NXZJTFhhcWdxMTdkeElxN09kVXNGSWpQQUtk?=
 =?utf-8?B?MTljaDlad0ZhYU1ZVE1hTmRpTFljenl6aHhMb1hyb3R2QVFDYThyUjZES2dY?=
 =?utf-8?B?NVh1cU5JUTZoclE2SzIzWENpb3g2R1Z6MlBLLy9XZUdxVzUvdDQ4YjBHV2g0?=
 =?utf-8?B?UE5YU2FTZHlBc0JmUlZwdENSTGtmYWNVT3BCOW5wbHl3Z3VpL0lXM0ZzOUtq?=
 =?utf-8?B?Y1NMNms0V0lHeVhFK0ZCZjlYY0Fqa2J4bEZ2TlBoVFRITVpxblJPNnErQ1d1?=
 =?utf-8?B?QytUOFRicitNTWQwYjdNekdOVFBtUnhKL1VlU016QTZkNE8yNjBoMjJhRE1a?=
 =?utf-8?B?d2xHWUdPUEp3WTdjOFhkY29TSDJ6SHUzK1FlVWNVV2VRd3crYVBOajdiRlUw?=
 =?utf-8?B?d1lDWVZNVTAxOFdaT1JZNlJ4M0Q2UWIvaUUwR1J4N1QxSmduaHNYMngrMk5S?=
 =?utf-8?B?ZWdvS2hwTGxrcDJ5cGc1SDA3Z3ZzMW9KU0F2VUhmVm5iYkxLMDVhakpwZlhu?=
 =?utf-8?B?OU8zQ0dob1FHS1cvdm1aalFEUndQS2VwblMvUFNYZTI5ZXVlbjQvOW02cUtt?=
 =?utf-8?B?NGo0aXhjTUd1SXkreGFTREp4R2xLK28vZ25pbWtGRmFXS3JIWUJQVVlNVjhE?=
 =?utf-8?B?cW13OVdUMC8zUjVCNVFjRVdvQ2tlaE54WlhQUy8yMmFZaUdWMU8rZXN1Tmcw?=
 =?utf-8?B?TVNIN0RSRjVVK1lZMjQvVDdVOXltU3ZLWFJxbTlMazNpMFZxUDRaNnpIT2hP?=
 =?utf-8?B?ZXhBTDF0bWZuaVJaNjBNZk1ZdVBPMTY4bmJiTWFuMTBYd0gxSVZMWVRaOFRL?=
 =?utf-8?B?TWkwdHdzK3E5ZnpWUWxZNkpoVXlzZko3NlcvZ2hkMWMzeXczajJZcE1BWW50?=
 =?utf-8?B?bWVmYXdaL1BvU2V0ZjRHaTN2Um9idURUTjRTSm8wc3JSc0JMSDlkYjVSM0dn?=
 =?utf-8?B?d2ViNDBBQWtCZGdaN3JBOWFDdmY4OFJIL1ZDdFFQSDhtQ3RCbS8wNGNGOHMz?=
 =?utf-8?B?L3VMZlFFek9mekRJN2dWOUtwUWl3QWpPbUJRb00xb3ZGT1R6QlFPUDNKbVhQ?=
 =?utf-8?B?ZTRSYkhFWTZlbkVIdzRia1FMRFh2cW9GN3BnT0xlcjVZR0d0UzdZZUFaWCt0?=
 =?utf-8?B?ckR2bExpL1lSNWF1cnkwZzBVaGFNWnJ2dzRjOVdNVDFmV2hoRld0dGpmaW5X?=
 =?utf-8?B?QVRrWTBROUFTZDZ1NFhTNFU1c29yUEVTZEJnanBOQVd6VGxKbFMzNXh1amJh?=
 =?utf-8?B?TnoyZVBKdEdqMHhlRVo1ZmpDaUxjS1dYWXhXZEtzOHRuTUwxVTdJazkySjU2?=
 =?utf-8?B?NVVCZFFiT0x6QU9QNWg5aTIzWXJmTEFKUzZ0RVgxOExhUGtST0xZb1VUVFVy?=
 =?utf-8?B?cU9BZHVaN1BxbEJmaUNSMmd2ckYwa3JOZXFISDJEcGhqWGZZYU9DTVoyTUxG?=
 =?utf-8?B?OXNqOFdBRWluVHVta3cvSFVBZW4yQmU0K21OOCsvUWxmekNiMXAxZ0VCbVlu?=
 =?utf-8?B?dGxsUUt0TzVqK25Rc093UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCtFK1pUcDBHWXZPT0p3a2pvcENFUklVVjFUdlVrSTR3eWh3WWdCbDlMWG83?=
 =?utf-8?B?WUM3ZXUrYXFvVzE0V1oyWWdBQTJ6dEMwaUxFa2VpWlhqTWNGc0pyYndHQWFL?=
 =?utf-8?B?Nlp1Y3ZpWFFXNDd5TXZrSTA3amw1QktzbnZJTDRxME9oSWp5akZwNHdmalRQ?=
 =?utf-8?B?WXdBcFhrdkpsTW5uOGtpWHdKU2ZJY0YxWWlrWGNVd21hV0ZUMk0waFlrcjYz?=
 =?utf-8?B?ck5NdTdMWE56K1RHc3lTTVlJWHFkbURxZTFhOEVxRGczTXFjZ015TC9uNnF6?=
 =?utf-8?B?aFBZem8vTXFSZnBxdHlHMUk5NW94WGE0M2JYUDg5dXpNcFZwTTZNbmNNUGFz?=
 =?utf-8?B?bmVEcDk0RWVRNWpzL0lMY0psSGRWRXlXa2UwYTJycUtpZ3Y0bzNuZ1hOeVBU?=
 =?utf-8?B?bkR2VFF0Q3FaV0hCVVVWQVBvSWF5YlJ0bVRod0tQSFB5TUVxVVA0cTFDamVW?=
 =?utf-8?B?NFVrTCtXbVVRTDloTnNnNHJycWFPWnQyOWdYYlAxTDA4QWJyOHJsbGd3UnZl?=
 =?utf-8?B?VWlDQnlwTUUrVXZRZGlFVHM1czhhM2gySEhkRjFrd1FMYWxjNE9OTkRnVkl6?=
 =?utf-8?B?RVdvc09RaG11K3lFSkNlQVRHTVhzb2NEc2tkSTEraWdzZ0pwWGxiZW5Nc2N1?=
 =?utf-8?B?N0lKbHV1WHpCTVVDUjk5T2RwTHdTb1BtNituL3B2VERlcGpnU0NEdGQ2eVZU?=
 =?utf-8?B?MkdyWUFZTnVVR2NlM2RESEc1ZjBrUkdncEFOZ1NQNTkwWHBKZzVtUUNiN29y?=
 =?utf-8?B?elk4blZxWVByUEdUczcyRkF6Y202U2tqdnFJMk13RUdnc0poZjdvSHlSNHlw?=
 =?utf-8?B?TjhOVDhWdWFvZlFpSkRUbCtzVnRsNmZvOUFiRWsvQUwvaFdqdXVLTzN5YUFU?=
 =?utf-8?B?WURBWHQrSWJBeTQ0bytzT3ppelUxTnBzRldSaS9QeXpjSm9lNkY3ZHZXeUx4?=
 =?utf-8?B?eStXbnNlNUZGcGV1VHZvcS9qcVQ2YSswcnMwTXl5U3RERW5OQXd3MGExZ0Y5?=
 =?utf-8?B?WjZaYUhkU2hUVnhOcHJDRTVTOThnNFB1aG1VV1pmWlFGYTJMSVdGU3VLbzhv?=
 =?utf-8?B?bk50L2U2STk3QXdxZ2tNTmZyUkZuVm5HQldzVHh0bmx1RHY2UzhFbllVVzhC?=
 =?utf-8?B?SCtMNEpXZmxzTmdOQ2NzcDVkTTE2eGs5NmxYaVB2aDk3NkhlU3VGV0hJMGhn?=
 =?utf-8?B?b3hValMvZXVnUlJ1d2U0WllqcVYwbC9yTFlpNTRMRFFwWFhWdGhOeXZvYTVK?=
 =?utf-8?B?UkFSUDh5dWpqU2FhUU0zMVVFSTJyRmpwaS9iSHJCN2lQbC9TNVZlZjRLVDRB?=
 =?utf-8?B?NXlVNW5wTnFUSStIMGorNFRyUUhQZENvSnlkcFNuc1czazhlb1lEYUpEbHpF?=
 =?utf-8?B?V2NsWkxHTFNReHpzWHFNaXBFZW8xZmI4eDRkeTIvRGlKTVc1TEIzUGdxTTFL?=
 =?utf-8?B?K1gwWTVnQlNjUEk4UEFlN0piOGMvOUJlV1FkRlJoRVg5OWFMT1NhOHJJR01K?=
 =?utf-8?B?SzMvV0FjTmZzSjU0L3p2SS9Wd0VjMEhFODIxL1lsckJQMERjTU5BT3hlV3Bm?=
 =?utf-8?B?bjY2YVNlbURxOTZZK3N6TElUcml6ZmZNQ0hiQnh1S1hSL2MrSVcyMUdmbkp4?=
 =?utf-8?B?WmFJSHYvVXRuM1B5UytNY0JuNStvczRMNUU1RFFCb2c2TjlmN0xlUnNDT2tL?=
 =?utf-8?B?d2U4akRidE8va3o5MTYrWDlLTVdUZFZrZmpKSnZ2Zk94eUc0bFRIbHlUUjk0?=
 =?utf-8?B?QVN2UTJpSnp0SHZramVJTHB1VTJTUXp5TVByYXBwTlU0SDByYVd3ZWJzZk5z?=
 =?utf-8?B?S1RWSXJNL0lkbVVMR0Y3dWM2SGVSRm1tL0dObmdwemhrS3JkYUVwQlFHbTdW?=
 =?utf-8?B?cTU0WUNXVXFmMDNzOWNBRy8rRnRtNUd6MWpNZkVEczRJTVlrSTY0OWswYTVH?=
 =?utf-8?B?VVlNbmhCRXYxU2FEUTBNTTZoWVQ1cnFDVWpKNStUYzArLzN1MkVxTnFpR1Fi?=
 =?utf-8?B?c2pTVUEvaEhMdG1xYnhKcEE0V2d3VklNNSt3TG1WejBDQmEzQW9KdnI4aWpq?=
 =?utf-8?B?RHhmQTBsM3FLY2RBRDUwOC9Ddk44RXo2ZUVpNHdXaE1JejZZVlJTSDYrL3ZM?=
 =?utf-8?Q?GcPHR7O6w3onwj5WEZO7xxs8g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5f5807-ea50-4099-d303-08dcc35c56dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:14:14.3779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p2lEtyJyQOTj0XBb87iwshT2SyqHYSZgbkl1sHO3yzfjd28t5Xt7qAHrmgRxqcP4x4Vn9aTfRB68Pu/yUKtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
Received-SPF: permerror client-ip=2a01:111:f403:240a::62a;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

On Thu, Aug 22, 2024 at 05:21:27PM +0100, Peter Maydell wrote:
> The TYPE_XLNX_VERSAL_EFUSE_CTRL device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
> 
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x55f222b5b9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 420
> 43d49e1139e3f3071b1f22fac1e3e7249c9a6)
>     #1 0x7fbb10669c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x55f222f90c5d in register_init_block hw/core/register.c:248:34
>     #3 0x55f222f916be in register_init_block32 hw/core/register.c:299:12
>     #4 0x55f223bbdd15 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.c:718:9
>     #5 0x55f225b23391 in object_init_with_type qom/object.c:420:9
>     #6 0x55f225b0a66b in object_initialize_with_type qom/object.c:562:5
>     #7 0x55f225b0bf0d in object_new_with_type qom/object.c:782:5
>     #8 0x55f225b0bfe1 in object_new qom/object.c:797:12
>     #9 0x55f226309e0d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>



> ---
>  include/hw/nvram/xlnx-versal-efuse.h | 1 +
>  hw/nvram/xlnx-versal-efuse-ctrl.c    | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
> index 86e2261b9a3..afa4f4f9960 100644
> --- a/include/hw/nvram/xlnx-versal-efuse.h
> +++ b/include/hw/nvram/xlnx-versal-efuse.h
> @@ -44,6 +44,7 @@ struct XlnxVersalEFuseCtrl {
>      void *extra_pg0_lock_spec;      /* Opaque property */
>      uint32_t extra_pg0_lock_n16;
>  
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
>      RegisterInfo regs_info[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
>  };
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
> index def6fe3302b..8252a5cabe0 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -712,9 +712,8 @@ static void efuse_ctrl_init(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>  
> -    reg_array =
> +    s->reg_array =
>          register_init_block32(DEVICE(obj), efuse_ctrl_regs_info,
>                                ARRAY_SIZE(efuse_ctrl_regs_info),
>                                s->regs_info, s->regs,
> @@ -722,7 +721,7 @@ static void efuse_ctrl_init(Object *obj)
>                                XLNX_VERSAL_EFUSE_CTRL_ERR_DEBUG,
>                                R_MAX * 4);
>  
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_efuse_imr);
>  }
>  
> @@ -730,6 +729,7 @@ static void efuse_ctrl_finalize(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
>  
> +    register_finalize_block(s->reg_array);
>      g_free(s->extra_pg0_lock_spec);
>  }
>  
> -- 
> 2.34.1
> 

