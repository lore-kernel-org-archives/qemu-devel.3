Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F981C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQOn-0004P3-4N; Mon, 27 Jan 2025 09:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1tcQOc-0004OC-OH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:47:27 -0500
Received: from mail-japanwestazon11020072.outbound.protection.outlook.com
 ([52.101.228.72] helo=OS0P286CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1tcQOa-0006xy-Hd
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:47:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnlvIvwOLcYCrsiCvzJkQx89Pb2ZNg9M5GEXAg6NhsNMMb1WNCzVp1NX4i4QrA8abJ5w0Zm3wQTSGYsJBdpM6eByvt4GcI9Vocz8wpSbao8WWKJsz/LRrUVdCKlw62jnbBkz/1gjhv1X75fcD2U1C1KdalTRapnBheaU9D8Wla/UeEC3jp8RrgwUPg+/cJoQCF8pMxpzeQlXYTjqrFu96uaePFrw9GrnP8NXk67GI0Uy0p3DR8+IlI8pKh9rzKRZbvjXV96gK0lOG0KpAynKJmI8SoGIBQeudl3QpBiQ1mr/TULX9178tqOGCq6WOH14TgToFZ56zRlK0HEVuML3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtWxs7FtHzCbAy1nW6dLcpbGfh9EtdwZme8bhHyqZHo=;
 b=yJ0HngMj+ZkxBzoQYHrjh4IBQ/aqQPxmyjXFxFaABUguLRgUeYQj0HLqwPkTpClw/xxjsA9dEB2rEtQPXA7HT9hvHfm50Hsp3Eu8I05hWaRcB63b2f/CwWhuPueUYQU7URinG3VLiAzhS4lbQmDsGXW2FrXoYDUnLyUME55WS962iGSwjDXK1pojxex7XrigY0ryZwqxIUammck8aNS1TAm0HZoXkA/8uPjkBdMoH5kj3DTTwOUoBDWrSsc0hk5BkJdnn7ok4KMqQBAjFsMP3A9cFtApuuHdxGbdzMftgwJGS/XuFaGlS8CpKr6Qhdx0oPp0tGKpCHnnLR2N89lSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtWxs7FtHzCbAy1nW6dLcpbGfh9EtdwZme8bhHyqZHo=;
 b=WK/E9VKkMfw2RL2gNqZ76uptbpMLdnYKVbeiLK1aNiINqLr9P9kPlTVhU4scn8Plyuw1rnAXE8255Bg4Cgoxd6Ec6x0P+LG4fmRRDaHVjwB8BmNZLICfhMg9gs3b0F4Jqr0B6L1o7LUl5spCmlLP+WYLvDe+oFvR+D1oiNArc2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 TYYP286MB5171.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:166::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.21; Mon, 27 Jan 2025 14:42:11 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::aec6:565d:1b37:c3ad]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::aec6:565d:1b37:c3ad%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:42:11 +0000
Date: Mon, 27 Jan 2025 22:42:05 +0800
From: Hongren Zheng <i@zenithal.me>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 contact@canokeys.org, Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
Subject: Re: [PATCH] hw/usb/canokey: Fix buffer overflow for OUT packet
Message-ID: <Z5ebPXTxTbDgGtUl@Sun>
Mail-Followup-To: Mauro Matteo Cascella <mcascell@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 contact@canokeys.org, Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
References: <Z4TfMOrZz6IQYl_h@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4TfMOrZz6IQYl_h@Sun>
X-Operating-System: Linux Sun 6.6.69
X-Mailer: Mutt 2.2.13 (2024-03-09)
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|TYYP286MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bb8898-b231-487d-6f9e-08dd3ee0c81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|41320700013|376014|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O4769mh4e4SUkS+ihyYGKGwBN+vhdyVEqRTM1TR2XfVd3uEZqPuqzAbhBH1Z?=
 =?us-ascii?Q?W+lLfroUal1n0NG+Y8UE+GxqR5nsqV/zQAHNxLmFt4cuOCgP2Dr2ABjkJatl?=
 =?us-ascii?Q?uUbfqo55ku31ibnbYsFgoKvNZRZUKT0dW0NH/LXrdXvUe6lnvy07iV0geXxo?=
 =?us-ascii?Q?4GyUoMBMveogf6/F7OXnk4+DcfFC7z8Q6EvgAvD45LBHxVYiX+kDRdmU+IrD?=
 =?us-ascii?Q?KHCT6UF7zsjHSENWB3+Ea/5UTBkJdBUk5jzs7+f/XRBRmGbk5i6Wy7wntl+G?=
 =?us-ascii?Q?BQZWSK+P96Uag5j9bo79QLK+s5h5kfwt4SeHIixqOVmChqjPp5dKmOXqrGXN?=
 =?us-ascii?Q?qNk/R3EXTwvCX+pYQHJiDk4cEF4wxF0cOdm9V2ZWBgSqgffyOo270H3KHmk/?=
 =?us-ascii?Q?3ryaE1nthVVrsq5FWV4yovnqbEy/naRRRiOtn3uvYBDYE03zHUhHD5PZzrVH?=
 =?us-ascii?Q?h0v/pMgzBVQ+YigZWW7ukNprCpX2E/vivd5yqyBqsIkcvr/m4pcmDPq2/G0z?=
 =?us-ascii?Q?h7CYEphH+Icocehh0Pl1Cw+96FElZ4AzUTDLRsd79WGQFEokuE4287FhqrqX?=
 =?us-ascii?Q?V4d/aFU88ixNYlqynKu2+lTgage+TUplwM32qnWN3ATi2uGVZpxjQF/y48Eg?=
 =?us-ascii?Q?VlucVWilJ7WnAn5Ht/qyj530/dFadoYitoESCs6BsR24UXXY8fQrPdlRl0eX?=
 =?us-ascii?Q?ZA5/GCjoVTQR+iCSsjJ4oMdTkl9EkmFTTyYe/oDk/vhC+z8EvU8Xj5yAIgJK?=
 =?us-ascii?Q?SJFk3YQK6FYJKrMfxQozLmfLeSi3W2p0B7NblHQQHKRCHD+3ktHwsqpNEvKH?=
 =?us-ascii?Q?ASKCvQcmsBTULh5WNewJ+J1Wy9dvav1yQBzxFYGuU1F+XjZHzJWpjEhibQfm?=
 =?us-ascii?Q?oZPioqeeeohoZctK2dAegvmuUlm+vhklONBjBJp7JmYkNqN05SOJ/QM1JQcB?=
 =?us-ascii?Q?sJdQiqiWtizQmlPYYmbn0M9iXaMkb/y19o2fq7d+ydXWMhbr5Re5RTL1TFD1?=
 =?us-ascii?Q?c4/PCNFdC3y3eHb64kp2jk6FmhrpMdzqHhQEIjJk4dFE34yt+/kuJxNHCoIa?=
 =?us-ascii?Q?UY4R9spFeAnPRW9WLkf0oBlWl5oiB7WdjffwXAnOrTqnCSmKGj1kCXQNp1y0?=
 =?us-ascii?Q?33M24j2cNSdcOcJm6JJOvNiy/pe0tc06+gYxW1w1F6yfaF2nFeqx4lVe2XAe?=
 =?us-ascii?Q?OPy4ulfVKiGlLh5GaFdSm3ePqqlNMu4yyDoknXFq1S8GgnsNA96sv2scQZYx?=
 =?us-ascii?Q?MStmOqIqPTUN01uexl+UEJFqAwN+0qqNupei9Lv1HFHZLQcmDhAQY5yBHyPr?=
 =?us-ascii?Q?TcBhcV+rx7+WI0yV8FcMrb1ANVZrmWXaZiCAp0FRP8w4hyL+MO1JRrdM6+Im?=
 =?us-ascii?Q?lrbFunkFoaPLJ12W1vI0IWQPdZKU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(41320700013)(376014)(366016)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Ukz/PxgqizQkbQBunHNssCrvUMDvkHMD8cFHhK0oiAYohgtkIDvIaMBtj2y?=
 =?us-ascii?Q?hqHp7PXrVkTruNRECx82M1NIRvHP4+wchmJQDmmg7JaDudhf+FWFTHqT+SFB?=
 =?us-ascii?Q?9ayCWOIkioNqnLGPl4KxdSQx+Q8BYKjkHXzSwGTj+qi1Td88CtY2GM7v4H6W?=
 =?us-ascii?Q?IW3ofbJHcNaHJOSjSBvEq80Qbp5KH4bxLRPg6uyHTjdqWLaH7uNm34ySliKN?=
 =?us-ascii?Q?Amwwr29/EtK5sQ1m9kXsQe8yLV1H+BA5IRn2qm12uoIIUUH+fvY1OHq0QvB9?=
 =?us-ascii?Q?oPTCf/Oa9qjGgEG/NoZ1aJSGuGN4M0yGSi+AWjVhWy/ttKLw/9kmR4bYW7Qh?=
 =?us-ascii?Q?2NxPxbWN+P5sSLj/wpurxx3dVAWjlGMO7M6hFVtInnyvPtzXrclwTjYAJkUO?=
 =?us-ascii?Q?PxrRNjwyZbkH75aE+p82vQ1u1nVM5WUH7XNRqnzO5Il0vlDG0Sp6x5u1koON?=
 =?us-ascii?Q?RqTN4gV4jgeZH3i34ihZyw5zl+IiGGatLrnrcma/3CdQzAuy4Go9efWh6OGV?=
 =?us-ascii?Q?FrZ/mqFUDooFXUWxGHEbWF+Cg/Yn4Yg7+egTcN1Lid1kSd3XUHKvu0mnqQDX?=
 =?us-ascii?Q?icHE7JRDZ+VQMJb/Xxkg7KyDS0W+ay1jaS8yELuZVbb8+bglCLImV2o7RB6U?=
 =?us-ascii?Q?HhSLS04mKiwPUC/GrJrynpEqi/XNWvrl+COIL+wRwzCsadYXB5OBwwB6tl15?=
 =?us-ascii?Q?IV5KNvCX+DVBfsKlEzRuKM6LrsRfkOTuSs6XUwsfTSrEidnmtfzZnKPAF5UW?=
 =?us-ascii?Q?hI+3xbWQ+GUqlc0fq6A6Cn0ipEGpZca0u9wBFLR6bUk9H5nnojUzGhHJOueR?=
 =?us-ascii?Q?5+HuwsM7o2bvNbxboF7369xdXuyWQlXxtXAo5sGrJWxFNFSdhFU7wg/834bg?=
 =?us-ascii?Q?AzU5lAvVm+PN2LMisLiAMfGk6ZYFqpRKD22idq8xVR1WQrS/qvwpJdTPXG1J?=
 =?us-ascii?Q?5B0dYL2YE7O1ZjexamCFWsJTWbYklYVnD6w6iGqlqneLnjpdmiR0I0VoBEkl?=
 =?us-ascii?Q?I3/iMkuCs0o1HEssKd6Y6fbArsdW3oa7kC3sxcY2dCCDYXXhjKFJtg14veig?=
 =?us-ascii?Q?xbZkJMBxm3P8SfeSuPQD8p+YrELWzEAIJ+c5VGndUM+/JAHVheAfJzELvS9X?=
 =?us-ascii?Q?+jyLtsaUe+yTURms1inUFPqbzmUks8erzFgdScjrPm4iNrWn6UqlpjAYJPen?=
 =?us-ascii?Q?ASNZPHmQrh2l5Qdil14SZQqXtItEKciMAFPFZYxDx92QH7DNLLbaKHNWWUtY?=
 =?us-ascii?Q?OJ3zREwQ8lcjJ7gRdzSsTWNs1yQRNsIGafkOT+HoPWihmPo/wZ/yD4ZXsAET?=
 =?us-ascii?Q?sIzoGnz5yrHL+DJZ5mGtdGkxhcWkRRJUdJ9SnhiZRdFqFZCQtefX7f7uuKvg?=
 =?us-ascii?Q?BIoLwITxHQzOcKWs18Xel9Z/rd/X0vUzMvKF1u9MFrN/1WTFRlheSWUCzNzm?=
 =?us-ascii?Q?ekH+h1dRSLj+r+yQnOlBpAfJzzg5qI3B5xlFhf/p/r2n4aiubxaoBjBwudVU?=
 =?us-ascii?Q?3fEESD3aFliNE32w2WCvRgMLnjvFeSwVq75cZgaoZGEt2SQFCdVLi15gN6di?=
 =?us-ascii?Q?X1xU3sTJ4AszVfX5QIFgqlKRs6kFvStrQBBO/sxW?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bb8898-b231-487d-6f9e-08dd3ee0c81b
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:42:11.0363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpEa1qbf6skJnlftznYtSiUqO2gVJs9XJMq+5ESa65z9Jsb6rW1lFRA4dU0CbB/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5171
Received-SPF: pass client-ip=52.101.228.72; envelope-from=i@zenithal.me;
 helo=OS0P286CU011.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Mon, Jan 13, 2025 at 05:38:56PM +0800, Hongren Zheng wrote:
> When USBPacket in OUT direction has larger payload
> than the ep_out_buffer (of size 512), a buffer overflow
> would occur.
> 
> It could be fixed by limiting the size of usb_packet_copy
> to be at most buffer size. Further optimization gets rid
> of the ep_out_buffer and directly uses ep_out as the target
> buffer.
> 
> This is reported by a security researcher who artificially
> constructed an OUT packet of size 2047. The report has gone
> through the QEMU security process, and as this device is for
> testing purpose and no deployment of it in virtualization
> environment is observed, it is triaged not to be a security bug.
> 
> Reported-by: Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
> Signed-off-by: Hongren Zheng <i@zenithal.me>
> ---
>  hw/usb/canokey.c | 6 +++---
>  hw/usb/canokey.h | 4 ----
>  2 files changed, 3 insertions(+), 7 deletions(-)

Seems that the USB subsystem has been orphaned
and there is no maintainer now.

I used to ask the USB maintainer to pass the patch
because I could not send a PULL, which requires
gpg signature.

I wonder which maintainer I should ask for now.

> 
> diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
> index fae212f053..e2d66179e0 100644
> --- a/hw/usb/canokey.c
> +++ b/hw/usb/canokey.c
> @@ -197,8 +197,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
>      switch (p->pid) {
>      case USB_TOKEN_OUT:
>          trace_canokey_handle_data_out(ep_out, p->iov.size);
> -        usb_packet_copy(p, key->ep_out_buffer[ep_out], p->iov.size);
>          out_pos = 0;
> +        /* segment packet into (possibly multiple) ep_out */
>          while (out_pos != p->iov.size) {
>              /*
>               * key->ep_out[ep_out] set by prepare_receive
> @@ -207,8 +207,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
>               * to be the buffer length
>               */
>              out_len = MIN(p->iov.size - out_pos, key->ep_out_size[ep_out]);
> -            memcpy(key->ep_out[ep_out],
> -                    key->ep_out_buffer[ep_out] + out_pos, out_len);
> +            /* usb_packet_copy would update the pos offset internally */
> +            usb_packet_copy(p, key->ep_out[ep_out], out_len);
>              out_pos += out_len;
>              /* update ep_out_size to actual len */
>              key->ep_out_size[ep_out] = out_len;
> diff --git a/hw/usb/canokey.h b/hw/usb/canokey.h
> index e528889d33..1b60d73485 100644
> --- a/hw/usb/canokey.h
> +++ b/hw/usb/canokey.h
> @@ -24,8 +24,6 @@
>  #define CANOKEY_EP_NUM 3
>  /* BULK/INTR IN can be up to 1352 bytes, e.g. get key info */
>  #define CANOKEY_EP_IN_BUFFER_SIZE 2048
> -/* BULK OUT can be up to 270 bytes, e.g. PIV import cert */
> -#define CANOKEY_EP_OUT_BUFFER_SIZE 512
>  
>  typedef enum {
>      CANOKEY_EP_IN_WAIT,
> @@ -59,8 +57,6 @@ typedef struct CanoKeyState {
>      /* OUT pointer to canokey recv buffer */
>      uint8_t *ep_out[CANOKEY_EP_NUM];
>      uint32_t ep_out_size[CANOKEY_EP_NUM];
> -    /* For large BULK OUT, multiple write to ep_out is needed */
> -    uint8_t ep_out_buffer[CANOKEY_EP_NUM][CANOKEY_EP_OUT_BUFFER_SIZE];
>  
>      /* Properties */
>      char *file; /* canokey-file */
> -- 
> 2.47.1
> 

