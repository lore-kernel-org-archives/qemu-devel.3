Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CA6C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJUL-0000OR-Tx; Thu, 16 Jul 2026 06:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wkJU9-0000NZ-KB
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:38:35 -0400
Received: from mail-northeuropeazon11021107.outbound.protection.outlook.com
 ([52.101.65.107] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wkJU7-0007QE-KI
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5/My7JMFOxHsit32gUV09O5QU4ol4tWtK1HogZ28o8IzqlRPQ5bSf2lhpkw3h/9/TJDenwetBbxKwQb7P4G0+pq7NH+3HIs61qkoJ7Uy18uQJMOUhjdLDRbQlIT7gPsJmuxgfXMoiy+kKi5V5LGaie5jwqppOTnNaGP6TJJmfqDEHEo9JuZ8NzwjXlNT+7WXWFPlHl7GTXcdO6Yy2r0VimaQ5itk4JaIrWuUfyBXg4WYTJEqwDHMgb5vXN9Xrjb/zL0Fb9p0B1xYeys189wF9VFsarmPndB29W3UbWCWG5JOzUQteo3MT8Voo+TgOWjrBOb+wDEAZ1kTPh9uy2jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh9I8XqBjvxk3aDxn4jta+HDJiPzKW7bR/jNN2st2Nk=;
 b=wH2Du8XCaswudz2GDVNPH0a2TG/MDn/DZkEtdVghVpQtEIhBJWQCcP+bmXbj1Bqsh2ewppdB/mXepZdrPWd9Pp4GT8VfMf8h0DKZJX3UMlRNfGP1Tib/+2CDHgo85scLJl/ywfaPSmvvhGjXbk8JsH2Us9ZxdJ+Lk/f86Z9/zPZS8X3woBkPHkWqtkcYOZ9jxKTQvh/UUl4qPeFCVyI3bgtd0rTrm585prWdNdQGNbxhiaQQ/6R4gVgnwH1FmZCKfXQGGDaHo1DHU67BhX96oa9zdVVswqWSq3C1NbgfCIsz20q39nJdlWwB/IIn/q3ldlZyNi5qB/RJXfnE8ojXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh9I8XqBjvxk3aDxn4jta+HDJiPzKW7bR/jNN2st2Nk=;
 b=KKw4lMMGZNgFp7w0H2XM1EyaLFbybE83YuUTaJavv4JQzlHGhzfdHrTwUssSSrG+ZHsW8+NJaLaNUl9kE7yFAF9xzyQdzfuOvL6dSVx6rt/DBqyQHDIhvrHQ3W9bFIhafxsBE6oGnbKXXebeBV7T9Gmz6/UHQs6fXE9v2kjTWMHZ8QtDIf03llQl86c3CSfB5eYrgILsPwzIio9//zA2sYuB5tqK1iMhhPWRvGJV3JOlxqcA+VJS+VUkf3dhRrAOpba9FBBVoMUK1s3gQzdIZoKOWOng2Is2EWD1aaxvkUKck5Qp2N5MOjWR6fiHHq4P0/YlS8ZV/pd3q9AcgLg+FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA6PR08MB10766.eurprd08.prod.outlook.com (2603:10a6:102:3cd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 10:33:24 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 10:33:24 +0000
Message-ID: <f00b67c8-b871-4064-bea4-5d49c66a83d9@virtuozzo.com>
Date: Thu, 16 Jul 2026 12:33:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vfio/pci: Reject invalid PCI interrupt pin values
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Cedric Le Goater <clg@redhat.com>
References: <20260715191735.2454719-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260715191735.2454719-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA6PR08MB10766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b498c71-0eaf-4a11-4ced-08dee325aa31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pdqF0D2Qsjarm2SmoCPJlGREa3vjw+2m3P0r7Dlx5QxRJhYNjrVnEruNL6qI32ZCUZxzn6g6bxwxLCXZHysNEq2qOSeh92yC5IrK8yfj2CZKl3GvAPCk44LHOD91l52OpHGyRf30/CrMZDpwvMh8GLHb4MZS/xBtddJJ3sN+j+0JR39lMKLsxNHkIQ4fu5NujGYJ0doGCwUeRzbA7arxSmNiz2LEE8PJuq0S5q1kvh8hMr/OMmKOg6bCYuU3J6dJtia1acLOt4zN6W9InLg7tiAY3+wFBDYT5bgRiiOyiq3QPC8vwlrG8cWJ4QCN09QLd5dxifpKqj6V+WmuXteEJQ+qa0p0RjK63G+7i8VQDTdI7mo+5whzQPpild0F6e/mEQSPd/PNWS0Bb+4m9lTJio/b/BGew9S+Tudbm14qUYIqBCHlE2eZLAwtQ6EWBmbEu3YQjatwAmDR5Pq7Jld5N7NeR9Xg1fhsJfj67EVu0puXeW9vIwgGEgB9RPCFEJJ64ImF1J/V7Y13MF3hY76m1RDVos/m/TGIBNurIOwXtyrbEcReRqZOopxFS3cQYaWlMxSusMsvqHnaPZ0LWoRN5yQNSrsTvA9X//ye8Us+ZrEFQpHNor88vp+ZqZRhAob+b7i4rO0dYHrXWxbPNQV14RzOZgDKgxyDO/pFx6B1B5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdST2RGNmluUEdaZDJvMEI3dlMwUHFwWlZyZEtLeDYxWTdLWE5HOTZ4T05G?=
 =?utf-8?B?T2FlNGd0TE5YQzNtcDdUZHNRNEsrejNNTUJtTHBNK3MvOVdTc3lOaHFDZks5?=
 =?utf-8?B?UW43V2JYNlIzWWVReGVuVlhsY2txOGl2dDlGdVZTbTdFUTErTXpnaTI3T0tk?=
 =?utf-8?B?WkdPQzZTQmhVOVJBdXVESGZWNytMSlVQK05XdUk0RURlaXRQUlE1UGNUb2hZ?=
 =?utf-8?B?dEg4NW5vSERsQVNRdDd0R1ZYQ1dlQ3NROHNqQ3pNSDVnQmtPQmtNT1RnbWRQ?=
 =?utf-8?B?eitYRG82SWw2emx0TTVKUFE5UmkvS1JmTGM0WmJ3eW11RWp0MUtNY0JvOUFr?=
 =?utf-8?B?L0J6SDdNbUhKSkljN24wczFUUDdRcytOdzlranViNGROQWZ5UisyL2tZL2pq?=
 =?utf-8?B?L0JHRGZVOTE3dG94bW9PNXZDT0VoUnlCNktlS28wc0JlV0tIQktpRCtyTURG?=
 =?utf-8?B?TExIRUFienU2RkRoRVZTcGE2MEVkMUF4WTh4OXFONldvcVlvT2lOTlVwVjhm?=
 =?utf-8?B?emFQenJKcFNFekcyREk4TU15WWpJenNZRWxrNUd2NkN2S1VwQjg4cTZ0dm56?=
 =?utf-8?B?RW5BTjVoanlraFFxR0Vrbk5lSnUwcWR2emtHd3RRdUFjNHM5T1pBbHdvaEs4?=
 =?utf-8?B?VC9tcDVodlhuekFiWjVYSCttekZUS1R4bzJlS0hSYkpjelZBQ1NoN1ZpSEdz?=
 =?utf-8?B?N3R2REw3WlJiNGxHWnprM1NuVHUxSUVHdVZvOW92Ni9yUWdSakZ5U25lODNY?=
 =?utf-8?B?ZUYwbm5lTUYxM0czdkpZZVB4S3ZZdXFJOUhEVHVnaUlLeFNKUzlmRDZQb0JF?=
 =?utf-8?B?ZmZDckNDRmE1ZHdWVmQ5L2R2RkZLTUlFMytLb200T0tpMitVcHl5L3l0ZVkw?=
 =?utf-8?B?NVdTTG9XUW5ZME80RlVOQWYzM1VVWTE4THVKL2tlWS8yZXVLS0E5TkdJSU5E?=
 =?utf-8?B?Ti8wQ0J1YjE0a2RxVDVkdkVkMHR5WHdONWUycGdRMm16ajJWamxhcHdzTTUv?=
 =?utf-8?B?N0hJeHlEcjIrbEp1Yk5aRE9GL1ZnYmJUMjVSbW44NnRaY3YxdXVWU0JTaVNh?=
 =?utf-8?B?RXlFQlA5RWhDb0JyTDFKekRJL3J6aGFBRkx1UjZ1Q08yTTd6NFhubkVVeWx1?=
 =?utf-8?B?OTgrNzgxZmJKSTJWUFJPZy9mU2lyOXBMM1BONGxwM1R4QjREaW0xaFh6SHZM?=
 =?utf-8?B?L3FYLzl3UVdWemVNWGJGT3hrN05LSXFaUTVRRlk3VlZMaWFSL2JHZVd3UGxY?=
 =?utf-8?B?WHJBU0M1SzhraUNIdnV2RU5OYlRaN0t4Y0IxbDhJb0lTdG9sM2RQZ3ZBbmNM?=
 =?utf-8?B?Uk9EYVZ3S3Y5RjNmbmcrZ2l1d2E2emhrVkgzd0pJTmRjMUdJai9ncXA3cWQv?=
 =?utf-8?B?aGhEMXdNT1RCeE9ZV0IwUVRnQ2h0bEhrVUYyNjRHV0tpd3dMdXBwOHZqMjhY?=
 =?utf-8?B?Um9tNEt0UW01c0JBdGxHcGhEdURDYVA2cG5wYTl0Y0RTNEt0V0FNbFJPNzF2?=
 =?utf-8?B?TU5jTk1QNGZGb2dJMWJGQTlqVjlFdnlUK0tCdUJNYmxPdHdWQzY2czN0Vlp6?=
 =?utf-8?B?bHVpMG4weXJRWmZ0WjRlN3BaWVRPSWdpY0xCNHZkSExoRnhzWkQxNUtsVHpT?=
 =?utf-8?B?ZEZyNmRGYzNUZTRLbUtBbDhSYWFIR3EvbSsvSGtJZDIycnhFYi83dFVrQjA5?=
 =?utf-8?B?Vkx2WGI5NXVTeHlQeGJDeWc1UXBILzgzWlpiTUx0QTFTN2JIbllqazJtRnps?=
 =?utf-8?B?RU5WNnJZR1pHK3lScXV2RnJXTGdHcnFPeG9IeU5CeVN4Mm9SUTJWdjJlUzlJ?=
 =?utf-8?B?Tk5sZmJ5emF6NDhQdWhEVEtqRWk4YWxPQXZFZjRSeDE0bDdtWGtoeTRHRk1R?=
 =?utf-8?B?YmVURDZkaDlKZGdjbmpPTGtLMHVoV3NUZW85Q2UxbDJYdDhYeDBNWHNRUktn?=
 =?utf-8?B?dlZzM0tPR3l5VDdsUldlOHM1azQyTjBDeklRWUd5UVIrYm4yclZXeUpRMm1z?=
 =?utf-8?B?NmZ2Q1RENW1IUWRtUnJJbFhRS1htR1IwUkZaRmR3Y1BpMEpDUFRLV3Z6OFhF?=
 =?utf-8?B?NDdoUVFoN0hsTlYrZnJ4cU45RDVxcU9QanBad3doU1lkdk9uV0dDSDQ0VnRR?=
 =?utf-8?B?blh6dkZaUUw0bm5RUXBHNDZrcnVZNXlqOG9KOGJodFQvYU4zSFdpQVF2WUFR?=
 =?utf-8?B?UVVOWHZjZzEzZ05NN3ZCVlhPN2kwOU9aWXhCV3I5dDI2citsNXg2RmlUdnVn?=
 =?utf-8?B?QVVhU09JZ3BOdm9pZEk0VitPeWlNNUUvTzV3R0lRSldoN3A5RW80VDlRSnEz?=
 =?utf-8?B?S1lCMmtRTGI5eFZxVHRQVlVRMWIyOEh3WkwrUlkyK0J2dytrbENqM25SaWk2?=
 =?utf-8?Q?MjOt1mOWUYONRuddB28bZN7todkpGbnqLlu/7DlEafMTY?=
X-MS-Exchange-AntiSpam-MessageData-1: jM/Jtzzn8Emexw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b498c71-0eaf-4a11-4ced-08dee325aa31
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 10:33:24.4026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3VqVOnSKdxS5OxYbbBZoLur75EIhRIb42w2XUYTcDKbpFdk4igVckEy0XUzBsvcym1/o+A7gpKUNaMiTVJ1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10766
Received-SPF: pass client-ip=52.101.65.107; envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 7/15/26 21:17, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> If a passthrough device's config space is unreadable at realize
> time (wedged link, surprise removal, powered-off GPU, etc.), the
> read of PCI_INTERRUPT_PIN comes back as 0xff. That value is
> non-zero, so it passes the "!pin" early-return check, and
> vfio_intx_enable() turns it into an out-of-range intx.pin (254).
> That value survives into pci_irq_deassert() -> pci_set_irq() ->
> pci_irq_handler(), which asserts 0 <= irq_num < PCI_NUM_PINS and
> aborts, killing the whole qemu-kvm process with SIGABRT instead
> of just failing the device.
>
> Reject pin values outside the legal PCI_INTERRUPT_PIN range so
> this now surfaces as an ordinary device realize failure.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Alex Williamson <alex@shazbot.org>
> CC: "Cedric Le Goater" <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c204706e63..612ee4a0db 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -812,6 +812,12 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>      PCIDevice *pdev = PCI_DEVICE(vdev);
>      int ret;
>  
> +    /* pin reads back as 0xff if the device is unresponsive */
> +    if (pin > PCI_NUM_PINS) {
> +        error_setg(errp, "Invalid PCI interrupt pin %d", pin);
> +        return -EINVAL;
> +    }
> +
>      vfio_disable_interrupts(vdev);
>  
>      vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->msix->entries);
pls disregard. Completely wrong port from downstream.

Sorry,
    Den

