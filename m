Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9CCC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGDA-0007h8-Ft; Tue, 18 Aug 2026 05:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wwGD9-0007gu-8Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:34:23 -0400
Received: from mail-northeuropeazon11021084.outbound.protection.outlook.com
 ([52.101.65.84] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wwGD7-0003lX-I1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:34:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/5c36zC/zorHxc3+4a+qvWHVLRAuw+FnDr5OZhBIxE20eRFrQhsrhmLNz3t4qRIVL0Dgenx2T/aELZDo/Za5K8jygJhhGgMYdzi3z+ZNehEQ0lcGxz3F2B5n7mLRYl0RKVfbpB1yD0BTspwCeN1CVjwHpGoeY3LPmrq6aRTrFfr+A1TwAOvWWD/krYbO9HYytPnZtbNq5mrMZ2peb6Y9DI/JDGBz65sylQK3ReIdv1pn1ArnhlipuQtZWVtpGiIZ9zPSY/agoXAMWaZXKtCMuITUHwz4uuk3OX10nHmSqOrzL335pUOFnCu5nwia9PCf94XGKrJ8RHf+z0Djv0Y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcoWAgLaQj+8UxzDcTUpvpMqGZxz9vRG3KOsOecGFR4=;
 b=dh9v8/XmTRc+AD89sHOwMisC9M3/S/DyYnncKDZm77vLvPKMEl+f+bnuYSpxvdr7s7XYDZV2xsRDRdYNN/y+3u1/cD2oOHLZsWbQTGEE0N0HfpGXAcKRY0kDzKOVdqC3jO3OoXG8+wbMfOZIlgNHFjLXugL8sc7tX0lxJIxyDtxHTsSZiuVTENGITkD9yl9QjfHjWGvRPDHvmtS+WcPMxUhmbUtFWEv65KV85vNREygqggqup3Mnoq72ODLzhc781mNi62fS0Jp4qPQTOhopJs+2N/rN2tD5WN8MCMBIYRFVrmwTGcUES+lbdGJcvUblLX8tImUPeNCHucz7UNtHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcoWAgLaQj+8UxzDcTUpvpMqGZxz9vRG3KOsOecGFR4=;
 b=lcI0pacglfzA4+FOV7JNMW3P6gAAEbfTRM82g/vVBPCX1uThp9qw0sXb4lhVNIoiuz8MhGh1g26s+1J7qUYiXiDgjK0Ww0BuXHTUL2uy/GZLF1B2Du97Y2++kAhJJ/OkOKgNhUiqLHQl3fnCUngEccUWZ4l+1S2PVh6AQ2zPJLgaunRJ27/ba+ftAUf3wtKBuTAHPNsyx+GBGOQKewUHs22bp02ZIWuZu0EomfVCOFR3QyB4BwPqubCTdB7Epbez7F1UUWYMOc0LehRaNxTsx1Df0TdLgzqPageVJCsMUX2ZhLhm+R3hbu9F0YcwL4W6EhQvj3NpwNhNgTksyEIXIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DBBPR08MB6233.eurprd08.prod.outlook.com (2603:10a6:10:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:29:17 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:29:16 +0000
Message-ID: <299fa07a-9a40-4473-bfe7-38aab7248a79@virtuozzo.com>
Date: Tue, 18 Aug 2026 11:29:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: warn about hunks which only add blank lines
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20260731134046.1015479-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260731134046.1015479-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0032.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::15) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DBBPR08MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 38eeec72-33a2-44a2-77b9-08defd0b2c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|23010399003|18002099003|22082099003|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: +7vi+aYb7mKUxeimK3jzMCxogl2yEpwsWgfuOUbHZo61FLZQ+UA5dvdF3ZR0WyoTOwAVGpjys4yzlHdTX5JWpdw+qX4fbOjt0HBGji6VkI7N/gC+2j5GYygukti4xRyw9GDOujCmJoVgyjE7APsMK4P2VE8J+K2j9Qa99R2iEPsOA4hapYU2QI5c7c3Lrez64e0JYOcImVK/XMU4o3I/qQHKlkiaWgEzqUuskgcEdkWnE3dQvt0oCvibB2H5TvWQcgtKtRr/PdJPBzK3M7xpcAHE+eDK+osGxS607SSyda68uLYqOwFawnC0GdMi9Sfc4rGCVAZsN/yA4IQoRDAOm9Z/hdM73TTcXSC+r2Ao93L2IQqlIj9d1MauilXfkhtFWRqP1J9vkrj8OoVom5nbtVkYV8XYdNnm8/UnPxXoPS/qvlfvL71xa4972bC8+K9sY8W2I02Q42yh/O9Q/PoZkbc1v8ZVUsvm38tQrGYnMgbAsQSW50JZ4kEdqMaM4geGXRNSWPZkYdGoa6+NQhAngXBSKDjLIYQ+zDeYxU62ZjR+EJJLGvf72BEzxrevvfQYvl19QCANv3xWPsXaW4eDdwYxo2WlIsaBtqp9BJ+B9ZIVjAz5xzUrLv2NBdoW02XGYabyDSZGQ74TF+lTHtGKnjB3VanU3UJ8ZldQ224Rxq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3J2K2N1RlFsQVdKM3lQTE5sUVJKTXpYT01ueEJoY1paemhHK0t2aXNGZ1Aw?=
 =?utf-8?B?c3NIbFJqM2RuRXR3MmRHYi9UU0JnN1Vrc1pseW4rOEdVZDQ5REliVWtyY0Jj?=
 =?utf-8?B?blFhWVhuUXdQK3JLM0lQN2hYSXpMZFpmWkptRi9aM3lUcW43Q2pOTEJ4RHpm?=
 =?utf-8?B?MGJEZnByTWpxVmx5dzdnRzFjV2VSdlJhQ1J0cWtGc2lpQ3lYQkYxRUI5RkYv?=
 =?utf-8?B?bHpNTHhjaWhiNiswZGtTUGx6QUhXTmF0VHZMOXNWTVNOcXVNWStFT045UWxQ?=
 =?utf-8?B?UHJhcERRVDcrSFJLUkFqREw0TFZ4QWl3ejNQUjlBeFZ5K2w1ZTY3WGoxTm9B?=
 =?utf-8?B?ZEE0dThzcDRXZW44cFlpUWg5SS94OHVrWTk2elBFamY1d0FZQ3kwWFVxei9p?=
 =?utf-8?B?Qy9OblNwVHBOK2g4S25xS1ZQUG9xNDMxeEpSTm5OTEVFVkZycER4NCtQTHBu?=
 =?utf-8?B?NW04c0xSRFUxUGhDQUprMURtaXcxSmdjaklNVktXZkRPTldibXRNVyt2VWZ4?=
 =?utf-8?B?WHg3ei9qVTdRWmpaOFdGS2lrRWlOaE92R0lHd3lnTzM0dTMzSm9xRXFEc3Y0?=
 =?utf-8?B?b2hUVVV4OCtUNG8xdGlVWnN0WTdmaCtZNzdTajN0Q0pLWDMyUGh3T1Q2cGZr?=
 =?utf-8?B?SzJhUzJuOGhxT0pOZEh4a1h2ZjBRR2FOSTRueXJDNGh0M0ZCaUtzYlJhWmlN?=
 =?utf-8?B?ZHZBQWNSYUxYRDJpUWdTS3lzYWVZUUc4ZENXRFNzbGFkWTJQZFJNZytMSTlp?=
 =?utf-8?B?ZzVJVDdrV2FtQlNyUXd3SndLYUlTcDM1SG9iSE94OER1Y0loYThnWG96bFVn?=
 =?utf-8?B?MExOd3dYTk5aWXQ2a3ljR3dNWHIzQ0pNVlVqcTh1WVkrT2NaNjdPN2kxSzBh?=
 =?utf-8?B?MHJLY29qY1ltNVM1eWhUWmpySG90WVhhcG5Ic2Q0WTR1Tzk1M3pkYjcwZ3JM?=
 =?utf-8?B?Q01rYzk0N0hucVJoOEVRemU2VXpkV2o4cEE2dU9VK0hYMDVFanRKeUttdTBq?=
 =?utf-8?B?L3NaV2dOT0tIQ2d5S1NheGhJVkVUT214WGtxb3JZNW1uR01rRTVTU0QxaVJ2?=
 =?utf-8?B?ekhjNHU3TlhINHVxcGp1MllxcHAvTGZ5OUh2ZFp6ckNWUnVxUXMrOHVxRFJs?=
 =?utf-8?B?c2pTbmNnMEpqbHFsdW9pd2tYMGMzQmphbFVhcGFEc0JxdHN5THd6eVlaNDNE?=
 =?utf-8?B?eUc2ZGlSZWdUc3dXWk80SUxWWnVxUHUxRmdIb2VBc01yYUNrUGpMYVMvT0xk?=
 =?utf-8?B?YUE2aXh5TEcrU1FKZFR4ZmRzWVNiVHBGTWJOdFlOeHZESVk3NjZkSHBBeExJ?=
 =?utf-8?B?VW5aNXF1ZTQ0Rm9Sbi9XMS9BV1hhVHpxVk9wRDlScmxacDI0R1ZodGhMd2hM?=
 =?utf-8?B?NjBlKzZqejRSRUlDQkhwMVRUYm1DSnNZeWJxc1ByN2xITFBVMENaeFlSbEVz?=
 =?utf-8?B?T0dWSGt4T0tobHQ4c292eGxXSDZiSjEwTjFMcmpCM3VsbDZBR083RGxKdHVB?=
 =?utf-8?B?Q2pKMUpDMDRzdmlNKzRlQVcwdUZpYW5sOGdtd0NNL0RsRjZ6S2tkbThYY2pG?=
 =?utf-8?B?RUxSR0dSbCtkRktpQVhkeDREYnBvNk1NN1hnNWxhY1F6TTM5Vyt1TlQzRWFM?=
 =?utf-8?B?NlA1Zk9UTXBjQTFlMzY5T0kvUkFFVDJjZTFrQ2l2N2RGQ2IvWFVKcTgxQytx?=
 =?utf-8?B?NmNlSm1kYkJHVDBSaVBWZ2lndFVJSnJTZGM0VGUrOUFESHMzNGw3a1Qvc2RU?=
 =?utf-8?B?cUFvRDdyaHY4bVNjL3BHL093cTZwUXFvaExjQzdaamNOTkZ6d2VpTWFMbTNJ?=
 =?utf-8?B?WDZYY0poNktQVGR3SUQvMnFUSmlkSTBRTEF3bCt2ZE04NWZMQVEyMVlyNHJk?=
 =?utf-8?B?Y0JWN1J1YnQwNGR2cDhBeERNRUZWbWdZVEkvdU9QV2N2ODNyNndzaTR2WXFT?=
 =?utf-8?B?MnA0NG5IYm5EZlRqM09BSHY0bTlxdHZVaUpzWkxMdEt0K2traHB6MW1velRM?=
 =?utf-8?B?aDhpeTF6TnRFUStvaHNydnlzYTRIN3NLcFBXVUI3S1o3Qmtwc0QrSGdCb0ZF?=
 =?utf-8?B?Z2lkc1NrS3QwbXp0QWFibldpNFBqL09jMDdKbG5tWmZKemV0WEJWenZXUWsr?=
 =?utf-8?B?eFNTY0lCUmp2Ykp6UVh0VzlkcHJLWGx5ZjdnbnlQMytsU1I4WUJ2ZG5kZk1X?=
 =?utf-8?B?aXlZVWNsNlFucm5HVkVEMk1HYjgvbGZGYVFTZlZZVDZHd0Y1ZXVjempqNnll?=
 =?utf-8?B?ZHdSWjJwWGJ5WnF1WW5LRTZHRkZCQmdTTU5CT1lBWWtTL1huOWYvMnRZdC8y?=
 =?utf-8?B?TktPUlR3TDdQa2VuUzFnckZFT0JZK01Ic1AvSTFRY3h6Sys2ZVgxZ1RoeXhn?=
 =?utf-8?Q?QUJz/QIBFXtLBndQTLxDrkBBHxgdDt3b6eRJQepkeQ47c?=
X-MS-Exchange-AntiSpam-MessageData-1: cVA+2zK5Ls66eA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38eeec72-33a2-44a2-77b9-08defd0b2c91
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:29:16.9063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znK/OTQUW6I0dr5ikCQMmyDUiv95Mmxo8ik6bcrLBrD4oOpg7RzmKOoual7P7F2WEu2z9m+silkxBW2p7CkIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6233
Received-SPF: pass client-ip=52.101.65.84; envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/31/26 15:40, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Patches sometimes carry a hunk whose entire content is one or two
> added blank lines. It changes nothing, it makes the diff longer and
> it survives review because nobody looks twice at a blank line. The
> blank line itself is perfectly fine, the gratuitous hunk is not.
>
> Tally the added blank lines and the other changes of every hunk in
> the pre-scan loop which already walks the raw patch, and record the
> hunks which only add blanks. Such a hunk is then reported at the
> first blank line it adds, so the warning carries the usual file and
> line context.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Chao Liu <chao.liu@processmission.com>
> CC: "Daniel P. Berrange" <berrange@redhat.com>
> CC: "Philippe Mathieu-Daude" <philmd@oss.qualcomm.com>
> CC: Thomas Huth <thuth@redhat.com>
> ---
> Note: this patch is sent on behalf of the yesterday finding inside IDE
>       pull request. This should be found with a checkpatch.
>
>  scripts/checkpatch.pl | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e7501..dfa9878006 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1567,6 +1567,10 @@ sub process {
>  	my $first_line = 0;
>  	my $p1_prefix = '';
>  
> +	my %blank_only_hunk;
> +	my $hunk_first_blank = 0;
> +	my $hunk_has_change = 0;
> +
>  	my $prev_values = 'E';
>  
>  	# suppression flags
> @@ -1583,6 +1587,10 @@ sub process {
>  		$line = $rawline;
>  
>  		if ($rawline=~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
> +			$blank_only_hunk{$hunk_first_blank} = 1
> +				if ($hunk_first_blank && !$hunk_has_change);
> +			($hunk_first_blank, $hunk_has_change) = (0, 0);
> +
>  			$realline=$1-1;
>  			if (defined $2) {
>  				$realcnt=$3+1;
> @@ -1633,6 +1641,13 @@ sub process {
>  		push(@lines, $line);
>  
>  		if ($realcnt > 1) {
> +			if ($rawline =~ /^\+\s*$/) {
> +				$hunk_first_blank = $linenr
> +					if (!$hunk_first_blank);
> +			} elsif ($rawline =~ /^[-+]/) {
> +				$hunk_has_change = 1;
> +			}
> +
>  			$realcnt-- if ($line =~ /^(?:\+| |$)/);
>  		} else {
>  			$realcnt = 0;
> @@ -1641,6 +1656,8 @@ sub process {
>  		#print "==>$rawline\n";
>  		#print "-->$line\n";
>  	}
> +	$blank_only_hunk{$hunk_first_blank} = 1
> +		if ($hunk_first_blank && !$hunk_has_change);
>  
>  	$prefix = '';
>  
> @@ -1780,6 +1797,10 @@ sub process {
>  
>  		$cnt_lines++ if ($realcnt != 0);
>  
> +		if ($blank_only_hunk{$linenr}) {
> +			WARN("this hunk only adds blank lines\n" . $herecurr);
> +		}
> +
>  # Only allow Python 3 interpreter
>  		if ($realline == 1 &&
>  			$line =~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {
>
> base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
Guys,

does it make sense to continue discussion or this patch
goes to /dev/null as nobody is interested in?

Den

