Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916BCCE7B0C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 16:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbvq-0007iO-To; Fri, 06 Sep 2024 12:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smbvp-0007gw-If
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 12:35:33 -0400
Received: from mail-dm6nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2415::61c]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smbvm-0004j1-QP
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 12:35:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5LZjErz8umdQBT0Q/eONBr07RxG89T3CauoQyr5MSAWIPwFqspRLnijzy3dyHvJnzUa5Hygry+L9zVqzYBSJ3X0iCaZRnwgChf6exq6VIfpFnkbcWS/t9U0HZo+IMyOWCeCPL1QbetEEjmcih3vX+wtybYs1aq61FahibMF5COA2zIC4zl0/+sokPj0Vn7+U6l339IKCdIL7TqfqSA58OsKYuwaI6FxwGaEhzGLT5z2cXqEBBKIl46/HlOwxo8pEtDwrbEJCPYEDb7vfGtEB7SMV47ACbAnZNUp7fIGzLRZhpfla7Z4bcwZISTBTzVTiGKP89/so+8cG0YOBP4vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AigeoFGfv+H7ojR/wwUhA/3OixKPTFu8TfK6yp9T0Fk=;
 b=tCdp0o4kmgMTUhO0+G2ZvjWGI7/3T/FItwCa5/4wJAkZ1/eRg2BuzxBUZHE5T9wwz4witLNextiSOfZTTga27GVgV5/bEY1hL3ZXA8e4mVtLRshDJxvlSjkvYz0yfsg2tzTAJ6dR3z1onPzIEgIPJCDmuG9PYTX23M83s15jBNpwh4yWI9bl3t38D07/hRLNRy/KDofWttxB2Yw8XIT4m6m/Kcwm6Zak0wlaQgp4d5WhPpn9HclK5r9NgpJiIGFBsEg01WGf7OPdJhelyeNYOsTLjDNiT1vlH5iEukMPZl2mmpbb1ScpNJugcKvBkm6Q2092CSZHVmYS00pJUCP9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AigeoFGfv+H7ojR/wwUhA/3OixKPTFu8TfK6yp9T0Fk=;
 b=nnaOkdQHHVPebiUJow43Ve12eySvd59PE8YI5HHSMn8c/O466fn3sfjvnaAXf6REgIBQLh+8+vnpykZAmNstK3hfiGG0LsbkfdXrwzqZpjZeVfHi/yBPX5/Hgp8KoN0/QYFudWsbt2tN8Oo3EgqYQbDP7NXREzSYHjAx0kolTKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 16:35:22 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 16:35:22 +0000
Date: Fri, 6 Sep 2024 18:35:11 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Doug Brown <doug@schmorgal.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <bonzini@gnu.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 7/7] hw/net/can/xlnx-versal-canfd: Fix FIFO issues
Message-ID: <ZtsvPyyaCFAS5+NU@xse-figlesia-l2.amd.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <20240827034927.66659-8-doug@schmorgal.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827034927.66659-8-doug@schmorgal.com>
X-ClientProxiedBy: LO4P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::20) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 830ff261-8880-4453-7d26-08dcce91e706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzIxL3lPc3lZTjVEOVRzaHdiQ29GUE1teDVKTWRaaGxYWjBNVTMwMndCUENM?=
 =?utf-8?B?NlE2ZG1vcVFnWDFFaHB0MUVjaUxLVklIMkV0YnUwQzN4WkZYblowaGRRcEds?=
 =?utf-8?B?LzYwWDArOFpUU3VLNGpuaTFjRFhkWEFlU3psSjErL0ZHVVBUdWQ2Tzk1ZDA1?=
 =?utf-8?B?enRkUWpHSklyZi9NWnBMeUxQYk1nN1UvNlVaWTJ2OTZxcjZQeGlCS1lUWU92?=
 =?utf-8?B?TkY1dFRFd2thRUtmNU9TZmI2UkNUM1BlRWhzZXJDWTVQTWdVN2RyK3lja3RC?=
 =?utf-8?B?T29UOThnVHpUdUoyc3ZnL0RqalJhdXQ0eDloNDdMTll2Skw0TWJyWDdjeGlG?=
 =?utf-8?B?Nm1yOThsR053K0FOWHhMVk45aURHR2VMNzY5cWRNdTA0T05Nc2FObi9FdStX?=
 =?utf-8?B?VmxoOS9QSU94NENqV3dIV3dNSDhvblpjYlpyeTFYbHJWWmZJbVFVTXMxSmlW?=
 =?utf-8?B?Q0VuUW8zcGFFMVY5VlF4eUc1NWJWTWZXVHdOeGlVWlBOUzQ0cTBpQWpvbG5n?=
 =?utf-8?B?TFRHdWJrS0Y3TWVRUjRJTzI3SGhlNHRiYVI1WktEb3VsMGc0VFAwbXhBbDJl?=
 =?utf-8?B?andWMlRzU1lMaVkvOWF3Z0EreWx3ekNXRzZqNVg5UmdxaHlVSDVFNWRlajQ5?=
 =?utf-8?B?U1UzZCtUWWR4b1BLeER1R0llaXVnQ1BMdTJDR0ZQMXBvZC9GV0RjTXNMOWFH?=
 =?utf-8?B?cWJQaDhSbFZvYmhvV0FaVytISzBFQ1JmVC85R1FIM1pubmJhMzNvN1JvS0hs?=
 =?utf-8?B?bmZrQ2J5MlA1S09VcjQxVUp5S0N4TDJEUFZSRkl1QVlBeHdlRE9IQldjS09i?=
 =?utf-8?B?aXlYdkZ1SlQ4a0VvcDI4TWJ4bnBZSzltSTRuYkZDN0MrK3Y0ejRtVHpBMTd5?=
 =?utf-8?B?RGd3NTRjUHozTTU4Y2E2NUJNZjhRbHljVkFSTHNJMlBkOGlWV3MyL0k1WUNU?=
 =?utf-8?B?VDk4VWhCdGQ5eTZlWUxlM1U1c0JTcHZEZUpNaGhMNDNVNlhoQlVVVHNIUkxN?=
 =?utf-8?B?Tk5BMnlwY25QTkJqTk8rU01OL1k1K1dXMFpnL2k4NGwrU2R0VnVNMlZSVkhn?=
 =?utf-8?B?Tk1BTFc3b0tsb3B3cWE4MVJCKzZwaFJJVjM3R2E1NXA1NUdkL05WTUx2cGRE?=
 =?utf-8?B?MEJMRFA3VHpaM016a00ydjlDaGZOdmF4WWsrYmR2eGpmSVQyVEJkczZNUW9H?=
 =?utf-8?B?TmFYTG1Fczc1WHM0RU96QVRRVjdLZFVoV1BJRlhYcWtsSTBTWHA2R1N2M0Ft?=
 =?utf-8?B?R2RhRGd5dmpFSDQrSjE4TldMUUdEb01JT3ZGMkw2MTdNaFprUlpFbjhBRjZI?=
 =?utf-8?B?ZFZZS05HNmRmNVFmL3RHUE5Vb3R1ZlNLUWNxQzlYRGhOc0tTYk1NbVhlSmZ4?=
 =?utf-8?B?S21Gc1pmWGMwRlFmZWE1SmNEUWtpUThUenpwbVdZbkQrWENIemJqbW9lWEhI?=
 =?utf-8?B?TUV4YSszKzJrWHNrK2U0MUo5TklBZUlSYmtXRFc0MGwyQU44all1eTkxTzZS?=
 =?utf-8?B?eXlXTjdiemxUTWJaWi9xME8yYVRJekF5VU12ZmFwZlloV3dTVnFidVJiMXdv?=
 =?utf-8?B?d2pRMFRLaG1JQzlhaXN1ZjNRTFh6MlA5TmRISzNGMXY5MEppOXVGR3BoM1Nm?=
 =?utf-8?B?dVk4cisyd0JDc0daMStPZjFDdVpvRSt6ZXJ6MnhwVHl1TG9pRUZaYUhDVkRa?=
 =?utf-8?B?VE5uSjZYbmFnVG8rbVVwNE1jbndmMkpaanlPRE4yL25Oamh1SW1zSzJwYXAv?=
 =?utf-8?B?NWlZcFBuWXRuVW03K1RFMGJPMVdISmVscUVzZUlLMlRhNStvSWY2RWJzZ3Bs?=
 =?utf-8?B?OXg0eDVnWVBhMzRDaWtqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHRTM2pPOGNUaFM0Y2dCNnBXOVBRd2Z0bUZWbHZvSWlmaks0T2NMTS8yeVRX?=
 =?utf-8?B?NnJmTU9sNWxjckF2aXNpWlRsTDlUZVpUa2lsVHhFNXhodGhlRFBDcnFHZ0pV?=
 =?utf-8?B?RXJadSsrcnJ0RDFEN1BKczBqaTZRTEw0YUNnVnZCeFlQYUlTa2poV2V1eU9z?=
 =?utf-8?B?amtvOSsyZXFKOUplMS9jZUwwMFRNVlRzOWdaK2k2OVVTTHJ6YjB5WnIrN3pB?=
 =?utf-8?B?aUJFQWNPdjlrUFFuNzIzSTgzT2FnSmRjUGZJWldtSi9yZjJsSjlYT1ZRR0ZH?=
 =?utf-8?B?V0l6L3FpVVkxUEVzSnNWR0ZBOFplMmRUN0N2RmN3Q3VLdVBnYklLU2MwVkEw?=
 =?utf-8?B?RTArSk1JZ1RONitpR2ZmOXdURk1KbEVwYUhPVHdpVW5vZm9ZTUxTMGxPYXhE?=
 =?utf-8?B?VXlodE9NQUdSOHpQQ2FYaEhTWitnWTdKMnZHOFh6RE16TGtNQ1NWcUFPU09I?=
 =?utf-8?B?RXduMloxTDJvQjkvUm02VTlzYzM0UTlTdkkxSnUyVFFSVEJoRm00YWtsNFk0?=
 =?utf-8?B?NjM4dUdsVDJNalFHYldBVzhCNWpxL2xwVzZiUjRCU3k4NmtvZGtZTUM0ZjAv?=
 =?utf-8?B?eFFJUFVndVZhVkwyNWpvMWI5WVBDOHpFYXdCQkYzeUpzVzZZN0xua0ZxdnJJ?=
 =?utf-8?B?MEhIQXRRdTRlZzljSVdiTUFBZmVSMUE3YXFUMEU3WW5EdjhHOUE4VXdpTXlE?=
 =?utf-8?B?Zm5yckU1TGNLbTBQK3QwZmJjc3ZSV3ErNzVEQjhlL2RuWWQrVUNzZy9VK1Zp?=
 =?utf-8?B?cXJMeEpxZTdvSnltY3dnUERmNTRmckNjb1VtQUZFbjVHY28vSTBnRHJZZFNE?=
 =?utf-8?B?c2tzdFRtZklxajYxRjlhb3FvVUd5Y21zQU5XVnlROEZTOEw4ajljVWxtWHhn?=
 =?utf-8?B?MUFjMElBYmM0cURsc1lpTDE1cWlNcHZabHc3TmZPdTJjUnFhYzNPUHdXT2NU?=
 =?utf-8?B?ZTBGZ1JnWU9IcjE5b0xOZ3ptWjNGY0dkVTM0NTZUUk53SUpLMHdtbGlBTjFW?=
 =?utf-8?B?TFN4OUE1S25BVXd0THpMSEFBZW5PWnJLekpsTXRBcTlXcDVJRk5YY3kxdktV?=
 =?utf-8?B?cy9xYmN3WDZhNzRDSGcwUVZ4MWw5ZUhxUXp2cFVpN0E5TzNha3lKN2VoWjNm?=
 =?utf-8?B?ZXg5bmhwMWo0M1FwcXBXaDBZT1MzaDlqZmczQ2NLUGdjWTNHZ0JDWmZHMXR6?=
 =?utf-8?B?SDJtM1RjTkQ5bXloOFdwd2lCQnM3ZHBzVG1LQWNJYXd4d2luQVlXZnVhTDEz?=
 =?utf-8?B?K1NxREpQL0RxTktUbkxaMDk2RG15NkVSSUNaVFBIUGZjakRSUWozcWU2emRX?=
 =?utf-8?B?My9UODdSTGFJVEU0Y3c2Q25DUjhUbDJJWXZDdDNTWGtQR3hLWmNFeTBkSTdM?=
 =?utf-8?B?UEt3SGYzUVhjUlRtQzF6aklzUElnMEdjS3FWdzhSRXdkYTdzNGEwRHlBQU5E?=
 =?utf-8?B?ZEd2L3hDdHRaeDNwVlZ3SFpSVE9BSDVqTEhoTzB5bkZsb2FMMFNFTEM5Z0V4?=
 =?utf-8?B?b0tqc2d0OVhWSmYwRmdKb2xMcWhlTjBqWW9oWDVBcUVadE5vOStvN0tXVUZy?=
 =?utf-8?B?K3R3c3ZGL2ZONlZKdWhiZDNQWURNb1QxWW9YdGNhelFxbzdTZThsbWNRNEVs?=
 =?utf-8?B?NnN4anhnY0c3WjZNQTdvN0tVbk9OSkFZb2ZOenl3ZGlWSnBvMllKd29yN3Vm?=
 =?utf-8?B?S0Y4U1NsVHJHUktZaFNhalNWYVQ0VUI1TzNpbHlmRkVmbnVoSElNV1F0QjhK?=
 =?utf-8?B?ZDdvRWRCUDY0MzVFSy9YNWV1S3lvSHBhTk9McFhhRjBlanpveGoyK0E0Vzdw?=
 =?utf-8?B?LzQ0YWE3U1ZRdHp3SW4yRHIzWG13d0c5OEJ5dnVSNC9sK2hTalI3VmoxbGpP?=
 =?utf-8?B?V29DWUFPSFBCUVF0UVZDcmNTdkJhS3EwSy9KV3NnV2x3SHJmZGNBNVQ2cGw0?=
 =?utf-8?B?dFZYZTFsUGxLWmZpRTlhUGxGTnJlZWkwMzFiajBNT2hFc2lHdkpBaHNFV0xP?=
 =?utf-8?B?TzRDYks0RGdndTdGZ0lpZGlHdWNpblMwNnc1WGVvM09oOUdvMUJWRE5HRFRT?=
 =?utf-8?B?NkVHNk1TQk9GM2xVZkErNTNTWDFPTGdpd29JaEI3TXJYOU9DTjNwU2tjczhk?=
 =?utf-8?Q?fcO3znjx2FW/sTpYR3yAoMgQ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830ff261-8880-4453-7d26-08dcce91e706
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:35:22.4259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DSsH0P77Pjhxrbd7fzLJSFHNN73+2Giiinfzt0BAxI/Femo2EaG0i0TBF24imEq1lh/6cviDB4Z1YiMFHkRug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
Received-SPF: permerror client-ip=2a01:111:f403:2415::61c;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Hi Doug,

On Mon, Aug 26, 2024 at 08:49:27PM -0700, Doug Brown wrote:
> The read index should not be changed when storing a new message into the
> RX or TX FIFO. Changing it at this point will cause the reader to get
> out of sync. The wrapping of the read index is already handled by the
> pre-write functions for the FIFO status registers anyway.
> 
> Additionally, the calculation for wrapping the store index was off by
> one, which caused new messages to be written to the wrong location in
> the FIFO. This caused incorrect messages to be delivered.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

Thanks a lot for the fixes and sorry for the delayed review!

Best regards,
Francisco


> ---
>  hw/net/can/xlnx-versal-canfd.c | 36 +++-------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 589c21db69..c291a0272b 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1144,18 +1144,8 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
>              read_index = ARRAY_FIELD_EX32(s->regs, RX_FIFO_STATUS_REGISTER, RI);
>              store_index = read_index + fill_level;
>  
> -            if (read_index == s->cfg.rx0_fifo - 1) {
> -                /*
> -                 * When ri is s->cfg.rx0_fifo - 1 i.e. max, it goes cyclic that
> -                 * means we reset the ri to 0x0.
> -                 */
> -                read_index = 0;
> -                ARRAY_FIELD_DP32(s->regs, RX_FIFO_STATUS_REGISTER, RI,
> -                                 read_index);
> -            }
> -
>              if (store_index > s->cfg.rx0_fifo - 1) {
> -                store_index -= s->cfg.rx0_fifo - 1;
> +                store_index -= s->cfg.rx0_fifo;
>              }
>  
>              store_location = R_RB_ID_REGISTER +
> @@ -1172,18 +1162,8 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
>                                            RI_1);
>              store_index = read_index + fill_level;
>  
> -            if (read_index == s->cfg.rx1_fifo - 1) {
> -                /*
> -                 * When ri is s->cfg.rx1_fifo - 1 i.e. max, it goes cyclic that
> -                 * means we reset the ri to 0x0.
> -                 */
> -                read_index = 0;
> -                ARRAY_FIELD_DP32(s->regs, RX_FIFO_STATUS_REGISTER, RI_1,
> -                                 read_index);
> -            }
> -
>              if (store_index > s->cfg.rx1_fifo - 1) {
> -                store_index -= s->cfg.rx1_fifo - 1;
> +                store_index -= s->cfg.rx1_fifo;
>              }
>  
>              store_location = R_RB_ID_REGISTER_1 +
> @@ -1265,18 +1245,8 @@ static void tx_fifo_stamp(XlnxVersalCANFDState *s, uint32_t tb0_regid)
>                            " Discarding the message\n");
>              ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXEOFLW, 1);
>          } else {
> -            if (read_index == s->cfg.tx_fifo - 1) {
> -                /*
> -                 * When ri is s->cfg.tx_fifo - 1 i.e. max, it goes cyclic that
> -                 * means we reset the ri to 0x0.
> -                 */
> -                read_index = 0;
> -                ARRAY_FIELD_DP32(s->regs, TX_EVENT_FIFO_STATUS_REGISTER, TXE_RI,
> -                                 read_index);
> -            }
> -
>              if (store_index > s->cfg.tx_fifo - 1) {
> -                store_index -= s->cfg.tx_fifo - 1;
> +                store_index -= s->cfg.tx_fifo;
>              }
>  
>              assert(store_index < s->cfg.tx_fifo);
> -- 
> 2.34.1
> 

