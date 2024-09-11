Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFE0EE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soHFV-0001R0-Qg; Wed, 11 Sep 2024 02:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soHFK-0000rL-Ra
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:54:35 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soHFH-0005Cu-VQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1726037672; x=1757573672;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=j7kw+dln+kzQ0l8HuuzUWu6+l1nDoLvQO7rFTFDpI0A=;
 b=dkt1JYsZP1KRK0k3zIaNJhk2t0BuoExQLVZXMw+FBRqGoQKfwsQ5K2fA
 K1A3WRBRWr+zG2O2S5fIJjxt63eubSECxLu6bFzxPGWoepPQ970YkXayO
 6CrQl1Wsj3AJfGiZpxUrePIZ1ASvZsHOn/16KpuZbVLB4eFMrp0r5uuZz
 moEIUxxys0XyllHVXKI2Rdd8pdF9JDMSRAI3MYF35Hb+a1Sks2Rfz+G2n
 CbW+TWpcfCdxLRIhNfrH2RiCliznOrRc+snuebzdmdV4QxmPDwBR76svA
 XgSq621Q8OXQhSc9CHnoxE6esNl7p7Y26Mpw/whDwx50veBM2LQnfeCJg w==;
X-IronPort-AV: E=Sophos;i="6.10,219,1719871200"; d="scan'208";a="20329502"
X-MGA-submission: =?us-ascii?q?MDEV+Ywv7CKf0pVA8bI64GqV6RTWCMqVnjSIJk?=
 =?us-ascii?q?Dk/rj94Rs7jpsvgj1tnYbM6bXSgDk3c19AdNotHcoPf3sONtEBrIagZe?=
 =?us-ascii?q?j3YM7f0ZPR5ANI6w+c92GCcIfci1JwuEC/PM7t2N0XKNhWwU1CGtLNrM?=
 =?us-ascii?q?IHQpHH3suGqpzRtBIfKtJV6Q=3D=3D?=
Received: from mail-am6eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.106])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2024 08:54:28 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCRlQQqYtdY+2LENgqltHVWd2CnLiXtBnkMd2FKZkHu2C4R6pi+cziaGfGmzcBtGV5dbSgHprL83BO6LV40nVAMun/m7UqhZ8EOTiZXjoAwf7fmKxiLZ1KkwpbwYlhgkbELA9m6SH2EShM0550umWjxqpNgmdqzFsuGd++Ldowxy8+SZNu53wMYf9bRb9DkOlhJRjK24H80GL+rtVLyPNF1vv7Z1IJ8KUGeZl7PBh6RHZoq67Wafi31bIg/SVv6oP75qyZvUbvSBgjEz1Ygsy+EUiu7P75gGhuQRjh/ntmKbXisTIGH2/9Kg8/EgYhKARNvo00p+NM7uPGMpuyvvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7kw+dln+kzQ0l8HuuzUWu6+l1nDoLvQO7rFTFDpI0A=;
 b=l8nMVTKBxAsDwzXR/XR83AtuowY9Kg3jE6oNhYWpU3FcVrEg94avUfelZKuZIZyL5fWPRJDSOosQQFIXCYMSPriflcCnPQaMMlcLCGAkT1SNGT1upK+Ygnhx89gFvkQ6UBcLi4fToD8mRWMCuPiS3F8rfQyJliAs/MEkjvtxkfXs92Le8kfRMvjbPQkZJhQiZyTNkfh4r+IoQeeP6h+ve6Mzwz3WC7zGvXMfDH39zX+CYAvLzuNpIaOpSLhSbrMTUkyDl2UJGz8j9WpamEmA42+12IKL4P4Gqp/qCCHTB50bq4kUUAAIbVakL6y4TnC3GtvsRyGzCKhUeoRS8E7ayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7kw+dln+kzQ0l8HuuzUWu6+l1nDoLvQO7rFTFDpI0A=;
 b=GSNo5pRAOYDnXpIgsNXGgn7nLBpreo9YVT4um+A18IOrdV7Jhp8aIHjlu1rPuBC4FXiZPX53Jw5abbp5/yN259ti/+WVGT+dljLUVGPUVxNd0bsQIgxG1Mu5RL4bMsZoW9EjHqrwL7Zjnp9dOtwoz3njYEaocCJPMpIMkNJBNETqFIInOpsYJaHx64NZFzCfpgrV3C3B3XQpobah3EBgoNvzCHkPKisDZphQAnL3TEO/oMY3AhHU9VoewwvmTJmgA5AEw08bGcnuAjjRWUGwi3lcaNZsTCrfyoZvytPyIPBkYyxcKH5f03rP66mhkAvv379NTqpgfMq0t0NIpvGmNA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8373.eurprd07.prod.outlook.com (2603:10a6:20b:444::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 06:54:26 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:54:26 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
Thread-Topic: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be
 string option to expose scalable modern mode
Thread-Index: AQHbBAs//n01sT5+oESCeHmeoqdac7JSJq4A
Date: Wed, 11 Sep 2024 06:54:26 +0000
Message-ID: <d24a00ea-b0a3-48f6-a447-c4745e89b56a@eviden.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-16-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-16-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8373:EE_
x-ms-office365-filtering-correlation-id: d0d53e0a-b84b-48b7-6a02-08dcd22e93c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RHNPV3g4am9vSWVNQnAzS09lNGFPakxhaDU3VVVBekZQTUJLeTR1RTZkU1Rr?=
 =?utf-8?B?eE5RYmJsN2pYTTg5dU41NVJXeEJ1TkNXVm9HblRteGpnbVZ2NElIdndHUi9p?=
 =?utf-8?B?c1JEbVN1QjAyYnp1N1hoZ0x3U3JUL05HUGs1amF0VlQ1ejdBODhRTWRqTEk2?=
 =?utf-8?B?Y0VyM2hYaEhjQ0FaNDJCblhXdnRtQ2dId3hmN1RtY25XMGVuMXZzd3ZURTdh?=
 =?utf-8?B?OHFXSmdyekZDK3hxUkY2S0tHODA0SkI5V1dvS2FYblBnQlQ3aVQ5U0JpQnoy?=
 =?utf-8?B?ZEJvNG14bXRZZEUzSnJCSlN1VmdjcVZmM3JqVEhFbUtXcHBqT29yZ0JlQzhj?=
 =?utf-8?B?M1FPNE5MWkF5Smx2aG8vSnE5dmp4UHVydU1nMVJ5QlprVWllQjdwQ2tZalAr?=
 =?utf-8?B?L0ZHMFdBOHMvRlNxM0hTT3NHdVRFZXI2RE16eVMwbng1TXVobVh6MjBBV09F?=
 =?utf-8?B?Szgxb3dkcGVSNU5IVTYxVzAvOTA5T2ZoN1o3MHJERDBmQjFGclYydG10Zkpr?=
 =?utf-8?B?K3E3ZmY1NlpKZmJBbVovMno5NTFna0I3djRJVmpNUDV5aDVqOVpJY2svM0tl?=
 =?utf-8?B?VzE4ZFQyazR4cWh1b3ZtbDZwR0Q2b0FzQ0xFbGoyYlRaSDZzeHd4T0JKZktX?=
 =?utf-8?B?WVU5bXgvT1Zwcldpb1Z1SWltL1RkbVA4Z1pFT1g3dHdkZExQN3Q4dTI3aEJB?=
 =?utf-8?B?c3EwbjdiZ2tpZ0Z5Tjh0SGdRa0puOHA1NTVEek9XL0VPK2cyMlFRM3YrRCtO?=
 =?utf-8?B?c3V0MHUzaGNiaXhTMnF6OWNCM2JkVFdPUmx4clM4SVArYnRSQkUxem0xMzdp?=
 =?utf-8?B?SDlSMHVnRkpQakluSE96dUVLUlJGemlLL1NPblIwRlhFRWkrLzQrZlhsUHNZ?=
 =?utf-8?B?cWczWnJDU1RmRWgzZlEvbU5vdUY2NkRaNU1aaUx0emhVdUIzTURSMzlXbXBZ?=
 =?utf-8?B?SDZscC9iZFhxQy9DcCt6dTJHSzZIS2kydlRzY2VKN3VCL2c3Skw5azc2R1Fm?=
 =?utf-8?B?UVRaUGRLSFVQNVlyb2c5ZUk4TnZ5dnhOL3pJSEIxL1c5bkR6eEZJRCtwOTJN?=
 =?utf-8?B?MTNiYXFiYVRVSis0b29pZ2l6UHg3SFlGSW9DR1VwcWU4TUUwcWZERGlMMUhD?=
 =?utf-8?B?RG8va3ZOMnk0QzdyTGttK0VKdVhlQ25GeEthSVBtV0pmVXhKNmdvWWgyNit5?=
 =?utf-8?B?R3Npb0pPNWNEd1RNVExRSmVYdmhoOHpIMjFoRE5yVThEYklsWHN3TG8rNDhJ?=
 =?utf-8?B?UGlHbWdDdURJbk11N3dkbmttR3pUc0YyM2tmeEVOZ3lxY0tHSTFiY3k0QkpH?=
 =?utf-8?B?RHJpaG04VXRKRkl0eEZZb29BcXlBZ01wM3lUZTB6bkpBdXFlNUo0c2NjNjJO?=
 =?utf-8?B?OFpqUE1WcExLWXlPbVpnem5PckZaNUkveVlWdEYwSXNVNlZicG90cVB0cGFM?=
 =?utf-8?B?Tk5ZQytNKzJQZHViRThWSmswaHpqSVhCTnF1TzRVZjNBM28waUYvSGlRdmtQ?=
 =?utf-8?B?UjBpRXcrcjh5TmpER0RhazZBZjhDUUtka1NhUDZUdkVNTWRUaWpZZTRyTy8r?=
 =?utf-8?B?Z1RaOWR6TS9NWkFRTGlkU3lnYXR5cW1LM1ZVek5vU1FhcmtuK29rdlZCRHJG?=
 =?utf-8?B?YUNFcEhkNHFISUdHckloTzJPNXp6NTBNR3ZjejFXNkxsSm91Q3drSkRralhP?=
 =?utf-8?B?OEpSTXdITmJKRXB3b2ZvaFdNbjE2eWdzcmRqOVFOKzZGT1lUZW5NaDlaY05B?=
 =?utf-8?B?YlVITWQ2UjExYUVwQXBsNm9id0pFQno2MXRjRmZPMEtWS2RNNittNFJqeFI0?=
 =?utf-8?B?N2hwWGZUQ212RnM3bFVwTW1YdkhZbkRpNnNWeG9iZzZiN1pFd3pCWS9vSFY3?=
 =?utf-8?B?YnpyWWhhUlVzUzVIWVdjMDNJUklTMlBsazZxNFVrdUNFcmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXYrbm0xdnVwQUhSSmVWRTJMUndQQWZ5U0pTbEpudG84aXdxT1BybjhILzlY?=
 =?utf-8?B?MFdHYTRyM0ZBWW45VHVJb014TGI5c3czSzVzNW02MlZydHVjd05qQUMrMkFR?=
 =?utf-8?B?ZnV1WCs5UVFxWHlWdkZnZUloWEFvRWY3YzYxNEg1WUN5MzhlNDM3dG1oRk1T?=
 =?utf-8?B?TUZkNzA1MzhmUi9Gcy9lVUtDalBxZlRMNVRRY2VsZmdZSWVoY2V5YzFBdzVz?=
 =?utf-8?B?RGNOS0FLaVFVTytTeEhIanhsSkhVU3BsU3IrOG1uSFJsVG9SZzN2c0tYSDlL?=
 =?utf-8?B?NFdCSGRxWDZhaEMvTkZ2eUhlR2g2WGw0YTNadGprT29FM1U3OGdqWUt6bE1q?=
 =?utf-8?B?Y0xValpJb2ViU0gxZ3NKK2s4dERDWEJ5OVNhYjNwNE9TVitycERjVHpJcG1x?=
 =?utf-8?B?dHJuRGVNb1VyU293WG1LdC9ub2JJakdaMDd3RTZZejFJZmtMVnloVmpjRkZt?=
 =?utf-8?B?OW1wK2Q3T29VdXhwby9pUFlCU3RIK3d3M3NEeVFVd3pqcTBpdFFQSnZYUmYw?=
 =?utf-8?B?eXBLYytHaHJPYWJIV1VpNHpwWHRiMnpqMTdzb1BOSytNREw4WXVDNjdBNnZS?=
 =?utf-8?B?dXlHN1FRa3hZYUdaOGFmZXNNTkNzeWgxVkw1Mll6eFBmZUx2MHlBRjM4TDVO?=
 =?utf-8?B?a0FiUlRtN1ZEanpmdTV1cDNleWlFeWkzeWxxNndlamd3UW1lMDJ0OWxieFNM?=
 =?utf-8?B?NVQ4dlFyUlQrU1pYcUU1M1c0YzZ3cDZkY3cyVXo5NGNsTGJnRFVkSkF2Mmww?=
 =?utf-8?B?QTIzZFB5Q0R0QWVrUmRzSUY1VVNtWGtlNmE3NEZSWVhYTVNSWXh4dDZ4Mlc5?=
 =?utf-8?B?Q2s5aWljcmJLcno0KytWWk9sWnB3T3QwQjFGUkQ3bWU5RFg0RUNrUlFlRVFV?=
 =?utf-8?B?aStOUXV5VERiU1lJY3lCNjFUVDlCaG94RjZWMk5KdXJMV1l1NnZrMEE4UHNa?=
 =?utf-8?B?WVhId3JIWjJPditaYnpXWXpKUEZzSkJNUDhEUzArRTY2a1lzbVJ1L0R5ajlQ?=
 =?utf-8?B?TGlwQTlVdnVFNXFLWk5ZVjNRZUF1QVVqNWgzYTJ6UkJhZXA5dXp3WjhwT3Rx?=
 =?utf-8?B?cThnS3N5WHNzc0hqbVZuVUxWVTllMDNQNzVDYTViOTR0NUc1Y29MSGlyM0Ft?=
 =?utf-8?B?RWRwdkhGOEtPcEoyM3g5d3o1WDRRSlFyNXF5TGhhUjJwb1ZxS3d4eU8zQXhh?=
 =?utf-8?B?Z1B1NW1CVU5hZUI1VHB4bDZmWnR3ZFBTYnd6ZTQ3dWVEWWR4UEZWWlEyeEVQ?=
 =?utf-8?B?NDFGNWFlVGhQbFYwSFprUm5zZ04rRkFYMFNjckNOTTZTbWhjelg4bGtra2xL?=
 =?utf-8?B?R3ZtV2pwdkxwSUYwRGZ5ZEQzYTRKV09zdXF6YUxRRDBnNUViSm1SSTRJc1gy?=
 =?utf-8?B?OWM0enpDa2FHaXZzQVhreGNuY1BZTlZIYVQ2cTc0WEJlSXJrMnFHa2wxaVhi?=
 =?utf-8?B?VFh0N3NXSVhXQ0l1R1dQNk1QMmN1TFN5cStBSnE2dW02VXdxVXJpbWFSeTE1?=
 =?utf-8?B?V3ZsV2pURHlkTnc3UXRsMFp4cjhHcmU2ZU5DZnZWeExlRCtxQXUwalV2WDRU?=
 =?utf-8?B?SEFsTUhGaXMxb1huT3lRL0h1aTVPOUU2SXVCNkxqeHVBTUNFQUtJeDlmT2d2?=
 =?utf-8?B?T1drMnBBZTQ4VURFeTJ2UFJsbUN6K1dKMWhHZDI4Vitkb29SNXVBeU9wMnUy?=
 =?utf-8?B?SHVsTWUydm9ocFphZ0lDZXhaVDAwTTBYbUttWUs4d0o0L0tuQ0VsMGZjL2F0?=
 =?utf-8?B?NmllaUI5ZnBTU2o4dGdTeTVyWXlEcnVjblFmZ1N0a0loZERIam45MFlBcnhL?=
 =?utf-8?B?RXRKZk1vNXB2U2xpOTZ6MmlJVVYrWC8ya0dFd280c3lmL0IwNW1sQXl6ekRL?=
 =?utf-8?B?am9zOElVWUwwL1VPOStLaEMrbDVEMkp2VnBwQXh0NFdCUjY1QWtuQkRrZjdp?=
 =?utf-8?B?Zm1CU0ZaeHRNVUhWd01zOC9URFZwTFVRVGlkcXNueHBNVjEySjRPTGtORTZ3?=
 =?utf-8?B?TlUzOFFieEtCcjNVU2c3UE5HbWtxaEpYTlhmeDV4K0kvbnhDWmdUdWZpOCtl?=
 =?utf-8?B?MmcxRHNKenExcWs0V0lsdEE4WEFJRmxCN3ZkekZmVHpweS9BZ3ZpRzdEU3hM?=
 =?utf-8?B?Z2Vzbk50MlhDQ0ljVGt6VWpHYjAzSnI1OW81TlhKMkNkdnNnbWdTS3NYcU43?=
 =?utf-8?Q?d/Les8IBDp7uZ0DIVW8o6FQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D1C6C793BD6C0498FEDA3796288E3B4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d53e0a-b84b-48b7-6a02-08dcd22e93c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:54:26.8689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuEnbHB9fn/eEE2zWuhY/rPjwx8vqPUENgol6uQlMn51lo2z9aStJlDcdJNxPp9cI9BSDQcEFaJVee+9Ggf0yM4qmiuXnyTWPMTC/WY6l+rHmsst2VMSRMYjh8SKrUt8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8373
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KDQpPbiAxMS8wOS8yMDI0IDA3OjIyLCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBGcm9tOiBZaSBM
aXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4NCj4gSW50ZWwgVlQtZCAzLjAgaW50cm9kdWNlcyBz
Y2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFzIGEgYnVuY2ggb2YgY2FwYWJpbGl0aWVzDQo+IHJlbGF0
ZWQgdG8gc2NhbGFibGUgbW9kZSB0cmFuc2xhdGlvbiwgdGh1cyB0aGVyZSBhcmUgbXVsdGlwbGUg
Y29tYmluYXRpb25zLg0KPiBXaGlsZSB0aGlzIHZJT01NVSBpbXBsZW1lbnRhdGlvbiB3YW50cyB0
byBzaW1wbGlmeSBpdCBmb3IgdXNlciBieSBwcm92aWRpbmcNCj4gdHlwaWNhbCBjb21iaW5hdGlv
bnMuIFVzZXIgY291bGQgY29uZmlnIGl0IGJ5ICJ4LXNjYWxhYmxlLW1vZGUiIG9wdGlvbi4gVGhl
DQo+IHVzYWdlIGlzIGFzIGJlbG93Og0KPg0KPiAiLWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxh
YmxlLW1vZGU9WyJsZWdhY3kifCJtb2Rlcm4ifCJvZmYiXSINCj4NCj4gICAtICJsZWdhY3kiOiBn
aXZlcyBzdXBwb3J0IGZvciBzdGFnZS0yIHBhZ2UgdGFibGUNCj4gICAtICJtb2Rlcm4iOiBnaXZl
cyBzdXBwb3J0IGZvciBzdGFnZS0xIHBhZ2UgdGFibGUNCj4gICAtICJvZmYiOiBubyBzY2FsYWJs
ZSBtb2RlIHN1cHBvcnQNCj4gICAtIGFueSBvdGhlciBzdHJpbmcsIHdpbGwgdGhyb3cgZXJyb3IN
Cj4NCj4gSWYgeC1zY2FsYWJsZS1tb2RlIGlzIG5vdCBjb25maWd1cmVkLCBpdCBpcyBlcXVpdmFs
ZW50IHRvIHgtc2NhbGFibGUtbW9kZT1vZmYuDQo+DQo+IFdpdGggc2NhbGFibGUgbW9kZXJuIG1v
ZGUgZXhwb3NlZCB0byB1c2VyLCBhbHNvIGFjY3VyYXRlIHRoZSBwYXNpZCBlbnRyeQ0KPiBjaGVj
ayBpbiB2dGRfcGVfdHlwZV9jaGVjaygpLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51
eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aCB8ICAyICsrDQo+ICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgIDEgKw0KPiAg
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDQ2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDEw
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+IGluZGV4IDUyYmRiZjNi
YzUuLmFmOTlkZWI0Y2QgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gQEAgLTE5NSw2
ICsxOTUsNyBAQA0KPiAgICNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAgICgxVUxM
IDw8IDQwKQ0KPiAgICNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAgICAgICgxVUxMIDw8
IDQzKQ0KPiAgICNkZWZpbmUgVlREX0VDQVBfU0xUUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ2
KQ0KPiArI2RlZmluZSBWVERfRUNBUF9GTFRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDcpDQo+
DQo+ICAgLyogQ0FQX1JFRyAqLw0KPiAgIC8qIChvZmZzZXQgPj4gNCkgPDwgMjQgKi8NCj4gQEAg
LTIxMSw2ICsyMTIsNyBAQA0KPiAgICNkZWZpbmUgVlREX0NBUF9TTExQUyAgICAgICAgICAgICAg
ICgoMVVMTCA8PCAzNCkgfCAoMVVMTCA8PCAzNSkpDQo+ICAgI2RlZmluZSBWVERfQ0FQX0RSQUlO
X1dSSVRFICAgICAgICAgKDFVTEwgPDwgNTQpDQo+ICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOX1JF
QUQgICAgICAgICAgKDFVTEwgPDwgNTUpDQo+ICsjZGVmaW5lIFZURF9DQVBfRlMxR1AgICAgICAg
ICAgICAgICAoMVVMTCA8PCA1NikNCj4gICAjZGVmaW5lIFZURF9DQVBfRFJBSU4gICAgICAgICAg
ICAgICAoVlREX0NBUF9EUkFJTl9SRUFEIHwgVlREX0NBUF9EUkFJTl9XUklURSkNCj4gICAjZGVm
aW5lIFZURF9DQVBfQ00gICAgICAgICAgICAgICAgICAoMVVMTCA8PCA3KQ0KPiAgICNkZWZpbmUg
VlREX1BBU0lEX0lEX1NISUZUICAgICAgICAgIDIwDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaCBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IGlu
ZGV4IDQ4MTM0YmRhMTEuLjY1MDY0MTU0NGMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvaTM4
Ni9pbnRlbF9pb21tdS5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+
IEBAIC0yNjMsNiArMjYzLDcgQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+DQo+ICAgICAg
IGJvb2wgY2FjaGluZ19tb2RlOyAgICAgICAgICAgICAgLyogUk8gLSBpcyBjYXAgQ00gZW5hYmxl
ZD8gKi8NCj4gICAgICAgYm9vbCBzY2FsYWJsZV9tb2RlOyAgICAgICAgICAgICAvKiBSTyAtIGlz
IFNjYWxhYmxlIE1vZGUgc3VwcG9ydGVkPyAqLw0KPiArICAgIGNoYXIgKnNjYWxhYmxlX21vZGVf
c3RyOyAgICAgICAgLyogUk8gLSBhZG1pbidzIFNjYWxhYmxlIE1vZGUgY29uZmlnICovDQo+ICAg
ICAgIGJvb2wgc2NhbGFibGVfbW9kZXJuOyAgICAgICAgICAgLyogUk8gLSBpcyBtb2Rlcm4gU00g
c3VwcG9ydGVkPyAqLw0KPiAgICAgICBib29sIHNub29wX2NvbnRyb2w7ICAgICAgICAgICAgIC8q
IFJPIC0gaXMgU05QIGZpbGVkIHN1cHBvcnRlZD8gKi8NCj4NCj4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBpbmRleCA5NDlmMTIw
NDU2Li5iYjNlZDQ4MjgxIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4g
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC04MDMsMTYgKzgwMywxOCBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgdnRkX2lzX2ZsX2xldmVsX3N1cHBvcnRlZChJbnRlbElPTU1VU3RhdGUg
KnMsIHVpbnQzMl90IGxldmVsKQ0KPiAgIH0NCj4NCj4gICAvKiBSZXR1cm4gdHJ1ZSBpZiBjaGVj
ayBwYXNzZWQsIG90aGVyd2lzZSBmYWxzZSAqLw0KPiAtc3RhdGljIGlubGluZSBib29sIHZ0ZF9w
ZV90eXBlX2NoZWNrKFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSwNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWVERQQVNJREVudHJ5ICpwZSkNCj4gK3N0YXRpYyBpbmxp
bmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhJbnRlbElPTU1VU3RhdGUgKnMsIFZURFBBU0lERW50
cnkgKnBlKQ0KPiAgIHsNCj4gICAgICAgc3dpdGNoIChWVERfUEVfR0VUX1RZUEUocGUpKSB7DQo+
IC0gICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfU0xUOg0KPiAtICAgICAgICByZXR1cm4gdHJ1
ZTsNCj4gLSAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9QVDoNCj4gLSAgICAgICAgcmV0dXJu
IHg4Nl9pb21tdS0+cHRfc3VwcG9ydGVkOw0KPiAgICAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRS
WV9GTFQ6DQo+ICsgICAgICAgIHJldHVybiAhIShzLT5lY2FwICYgVlREX0VDQVBfRkxUUyk7DQo+
ICsgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfU0xUOg0KPiArICAgICAgICByZXR1cm4gISEo
cy0+ZWNhcCAmIFZURF9FQ0FQX1NMVFMpOw0KPiAgICAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRS
WV9ORVNURUQ6DQo+ICsgICAgICAgIC8qIE5vdCBzdXBwb3J0IE5FU1RFRCBwYWdlIHRhYmxlIHR5
cGUgeWV0ICovDQo+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKyAgICBjYXNlIFZURF9TTV9Q
QVNJRF9FTlRSWV9QVDoNCj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9Q
VCk7DQo+ICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAvKiBVbmtub3duIHR5cGUgKi8NCj4g
ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gQEAgLTg2MSw3ICs4NjMsNiBAQCBzdGF0aWMgaW50
IHZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAg
ICAgIHVpbnQ4X3QgcGd0dDsNCj4gICAgICAgdWludDMyX3QgaW5kZXg7DQo+ICAgICAgIGRtYV9h
ZGRyX3QgZW50cnlfc2l6ZTsNCj4gLSAgICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUgPSBYODZf
SU9NTVVfREVWSUNFKHMpOw0KPg0KPiAgICAgICBpbmRleCA9IFZURF9QQVNJRF9UQUJMRV9JTkRF
WChwYXNpZCk7DQo+ICAgICAgIGVudHJ5X3NpemUgPSBWVERfUEFTSURfRU5UUllfU0laRTsNCj4g
QEAgLTg3NSw3ICs4NzYsNyBAQCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90
YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgIH0NCj4NCj4gICAgICAgLyogRG8gdHJh
bnNsYXRpb24gdHlwZSBjaGVjayAqLw0KPiAtICAgIGlmICghdnRkX3BlX3R5cGVfY2hlY2soeDg2
X2lvbW11LCBwZSkpIHsNCj4gKyAgICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNrKHMsIHBlKSkgew0K
PiAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WOw0KPiAgICAg
ICB9DQo+DQo+IEBAIC0zNzczLDcgKzM3NzQsNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3Bl
cnRpZXNbXSA9IHsNCj4gICAgICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJpdHMiLCBJbnRlbElP
TU1VU3RhdGUsIGF3X2JpdHMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FX
X0FVVE8pLA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJjYWNoaW5nLW1vZGUiLCBJbnRlbElP
TU1VU3RhdGUsIGNhY2hpbmdfbW9kZSwgRkFMU0UpLA0KPiAtICAgIERFRklORV9QUk9QX0JPT0wo
Ingtc2NhbGFibGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVfbW9kZSwgRkFMU0Up
LA0KPiArICAgIERFRklORV9QUk9QX1NUUklORygieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJT01N
VVN0YXRlLCBzY2FsYWJsZV9tb2RlX3N0ciksDQo+ICAgICAgIERFRklORV9QUk9QX0JPT0woInNu
b29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2wsIGZhbHNlKSwNCj4g
ICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1wYXNpZC1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBw
YXNpZCwgZmFsc2UpLA0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJkbWEtZHJhaW4iLCBJbnRl
bElPTU1VU3RhdGUsIGRtYV9kcmFpbiwgdHJ1ZSksDQo+IEBAIC00NTA0LDcgKzQ1MDUsMTAgQEAg
c3RhdGljIHZvaWQgdnRkX2NhcF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykNCj4gICAgICAgfQ0K
Pg0KPiAgICAgICAvKiBUT0RPOiByZWFkIGNhcC9lY2FwIGZyb20gaG9zdCB0byBkZWNpZGUgd2hp
Y2ggY2FwIHRvIGJlIGV4cG9zZWQuICovDQo+IC0gICAgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsN
Cj4gKyAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+ICsgICAgICAgIHMtPmVjYXAgfD0g
VlREX0VDQVBfU01UUyB8IFZURF9FQ0FQX0ZMVFM7DQo+ICsgICAgICAgIHMtPmNhcCB8PSBWVERf
Q0FQX0ZTMUdQOw0KPiArICAgIH0gZWxzZSBpZiAocy0+c2NhbGFibGVfbW9kZSkgew0KPiAgICAg
ICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9TTVRTIHwgVlREX0VDQVBfU1JTIHwgVlREX0VDQVBf
U0xUUzsNCj4gICAgICAgfQ0KPg0KPiBAQCAtNDY4Niw2ICs0NjkwLDI4IEBAIHN0YXRpYyBib29s
IHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPiAg
ICAgICAgICAgfQ0KPiAgICAgICB9DQo+DQo+ICsgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVfc3Ry
ICYmDQo+ICsgICAgICAgIChzdHJjbXAocy0+c2NhbGFibGVfbW9kZV9zdHIsICJvZmYiKSAmJg0K
PiArICAgICAgICAgc3RyY21wKHMtPnNjYWxhYmxlX21vZGVfc3RyLCAibW9kZXJuIikgJiYNCj4g
KyAgICAgICAgIHN0cmNtcChzLT5zY2FsYWJsZV9tb2RlX3N0ciwgImxlZ2FjeSIpKSkgew0KPiAr
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJJbnZhbGlkIHgtc2NhbGFibGUtbW9kZSBjb25maWcs
Ig0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICJQbGVhc2UgdXNlIFwibW9kZXJuXCIsIFwi
bGVnYWN5XCIgb3IgXCJvZmZcIiIpOw0KPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAg
fQ0KPiArDQo+ICsgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVfc3RyICYmDQo+ICsgICAgICAgICFz
dHJjbXAocy0+c2NhbGFibGVfbW9kZV9zdHIsICJsZWdhY3kiKSkgew0KPiArICAgICAgICBzLT5z
Y2FsYWJsZV9tb2RlID0gdHJ1ZTsNCj4gKyAgICAgICAgcy0+c2NhbGFibGVfbW9kZXJuID0gZmFs
c2U7DQo+ICsgICAgfSBlbHNlIGlmIChzLT5zY2FsYWJsZV9tb2RlX3N0ciAmJg0KPiArICAgICAg
ICAhc3RyY21wKHMtPnNjYWxhYmxlX21vZGVfc3RyLCAibW9kZXJuIikpIHsNCj4gKyAgICAgICAg
cy0+c2NhbGFibGVfbW9kZSA9IHRydWU7DQo+ICsgICAgICAgIHMtPnNjYWxhYmxlX21vZGVybiA9
IHRydWU7DQo+ICsgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgcy0+c2NhbGFibGVfbW9kZSA9IGZh
bHNlOw0KPiArICAgICAgICBzLT5zY2FsYWJsZV9tb2Rlcm4gPSBmYWxzZTsNCj4gKyAgICB9DQo+
ICsNCj4gICAgICAgaWYgKHMtPmF3X2JpdHMgPT0gVlREX0hPU1RfQVdfQVVUTykgew0KPiAgICAg
ICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPiAgICAgICAgICAgICAgIHMtPmF3X2Jp
dHMgPSBWVERfSE9TVF9BV180OEJJVDsNCj4gLS0NCj4gMi4zNC4xDQo+DQo=

