Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E42C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn1s-0004cb-P1; Mon, 22 Jul 2024 03:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVn1q-0004c1-EN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:00:14 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVn1m-0006AT-ST
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721631611; x=1753167611;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=QaJZRr7C7Q4m3HU9MKzOenWcfZm4pUvFNOhzJ9Gz+xU=;
 b=QCMXE7APlDqXbvUjJEnJEGSwxSM/VhN7EzH2k0QDugVpOkcls383g/Gz
 ma/IfVMaBHeqO7L4+z8rwI2/sXMG0tVfYyAWveNRtHVqRCQ0XWtWNRvYn
 YTxvIwU4mlRMAi0CFK3PQwHVula32a8frQKokBZhIOarv/K99ICMRQnah
 VprGE640tIaCr7u6i7hCcwh1wXdlCN5BniHlIjpwpcRDJcMjgk3VzHORV
 w8xBo1xnmRLsr/ADBewhyIi9EedTG+VFKVEi7yEBbt1pFHVEJdmpvxq5F
 fGoCrQ0NpC/MSnpUKrgO9Ssce96Da/4yFIz8obuzWx/vqgq4R/DKYyeZ9 w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="125928189"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="125928189"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 15:59:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeSIIsvN/7DbkCTlvyTDzOlHyknkRRnDacp26Ydtcv7833tW80ze8geYQwtYDjxATjn/jAi0Uqvcql745CL6s+F4O0yKNBhuw3dHqIbxwabHseXXMbAoN7Big6kddHAaxBMtnkPvTrv8EKWyzDihP0rTo0SbyskU5Two+jKb0AuXHl8JDD/zDiszebA2XrPRVi1ivmIhBIzXL6oumf8GUNxgOmC4WjZlduG4phFVAFmc02dkFkoD21js0VEy6u8tKZfC1t/er/myYart28AVJ9CQXZqo7fdnqCPz/mdvlkKlsQuAX8GpkWzHJFinPswOuY6KxgjHPe78BnJdmB/uHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaJZRr7C7Q4m3HU9MKzOenWcfZm4pUvFNOhzJ9Gz+xU=;
 b=Lzf3FX8Tv4YeVLZVzPAtQhsyjJV9KLs9jFhSf9r88B1n2LCPFJwX3LMqukypEqMs641/+kxdAvHIo1GeZpsNDgg8UySBxt8vk47aYwEX3LBernkFgYKuZR3dyeIPhSSoLBcF+wGuudQdtAcJRx62zryh5u8XwQJ3jhPUTpgfqfTXNs7i+LiQOt1JPptRV+JzpUpd8DnTmbMFA0O0R8rp2ufn4HdIQifRROG6XCdiVomi7VUrmgq2wtAhVoRBj0Tgq1G9vvyb8VP3YPxOzUHDKL1NknZ9nWrG5/CuLkR3ga91z8VLsPZknf4oKsStDp+A1TLvxYKS/OBcl/Gz2AT+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYBPR01MB5341.jpnprd01.prod.outlook.com (2603:1096:404:8028::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 06:59:41 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:59:41 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 00/13] make range overlap check more readable
Thread-Topic: [PATCH 00/13] make range overlap check more readable
Thread-Index: AQHa2+y+M3hJ4iUEQk2slUBuC3LfYrICTOWAgAAAX9A=
Date: Mon, 22 Jul 2024 06:59:41 +0000
Message-ID: <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
In-Reply-To: <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZjI3ZmQxNmMtNTM4MC00M2M2LWIwNzItZDRmYmE3M2Jh?=
 =?utf-8?B?MzZmO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTIyVDA2OjQ0OjE2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYBPR01MB5341:EE_
x-ms-office365-filtering-correlation-id: 9084a9dc-4ebb-40c5-6c00-08dcaa1bdc63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YnlLK0NWczJaSDlob2RRcWVxaFBMRGMxNVNtZVZOaUdlRjlPaFdxUnlwRVdi?=
 =?utf-8?B?Nk56WDlxOHQwRDVIZ3BidDliUXl2L1NienE4N2RGQTZqRUlPVTFhZlMxTGVW?=
 =?utf-8?B?bFVLOW50d2VZSE1TSVBsa1VlTzFMWk9IRFk0cTJsYnkraWZpQUhsdVE3UEFD?=
 =?utf-8?B?NGxhN0ErUk8xeXB3UldmY1Z5SXJlQTNEbmVIUDV1aTZSVkVnOVZUcXU2VVlK?=
 =?utf-8?B?cVJjNms1YzJmb3Vad0VMSnFsdmFSMGl6T3NlYnQwNWY1ZFhCbVA3N0JrS3Iz?=
 =?utf-8?B?NXdSNUM5MzJoUFdqRXpHMUpzSng2OG1sQm9XeWU2cytlbDF3NWlETUxCWDNK?=
 =?utf-8?B?WkRlUFNGUFM5VjYzVHFYb2lqUFU0SytEYnJBSXNHOXlWUmIrWUpFb0lqYkFW?=
 =?utf-8?B?WFp3T2E0WkZraEhzNEhyL1BubDdkNkJNZUo0ZGJMekNoS1pCSlhYWXVNQVQr?=
 =?utf-8?B?dTBjUFkxZThRQkFQWmxYRFBOYy84UzE5KzFzRzlsK2w1QzVnczJQUlRjUllM?=
 =?utf-8?B?UWY1cXVaWkFPcFNXOFFpaDVJdDdNdW0yY3NkQ2x0Z2NQZHJXZ004dGFmcUpX?=
 =?utf-8?B?TUxqOVNadU02VjZ6VU5kR0pCM0tSUVN2MVc4azZWOFA3bE9wRXdXWDBLQXFO?=
 =?utf-8?B?M3JDUUh0alRuOGdtbUJDeTV3ZUszRTdQd2xPTXhqT05BVktDY0QxMmFEaEsw?=
 =?utf-8?B?czRhV0k1dzlXcHlrdlRLdUFiL1NpQXRNWHVOaHB0V013Qm0yZVhsTjc1Y0lO?=
 =?utf-8?B?V3NWV004bTJ4UGtYcWRZVm9wOHVydHMxZjlRUnpYRldjeXZnNnFJdFhKK2Zs?=
 =?utf-8?B?TlVNN1hwKzlwdFhYV2hvKzJFbUZQVTJaUitaYnNwMnNBaUo5UkJKT3BPOEZE?=
 =?utf-8?B?dFRjaDhFc3R2U3ZPVUNjYzk5aURpWVlnVmFtVjlKcWRXZG9qYlZwSEppbkI3?=
 =?utf-8?B?UWp3Mm84VU9DK3djVHBlclRDUUdMTklLUFAzN295dFR0ZEVSNXptZzhodFo2?=
 =?utf-8?B?NS9sRGNpYUtUbGVMelE1MU1hWG1YVWdZMUEzdXdSNkZ6Ris4OCtyVVJzR2dn?=
 =?utf-8?B?Q1FvaFNtNlV3YnNVelhYaEtBR2pOQWdDS1ZLcFRjaUlKam1xeENJeFJjc1NL?=
 =?utf-8?B?c0pxbS8zeENPQXZ0VVpCWnFLTllvWk5BV2lDTHdFa2wwVVVlZ1k1cE9qWHl5?=
 =?utf-8?B?QWorbUIzT1p2MWc0Rm5yRFordGd5TmxjV3o0bWtFTmV4Lys3d0hCTlBPWmt3?=
 =?utf-8?B?ai91c0xJbTZoNExuaHpOMmJpQ3JhRlRiYU1OeWlSeVJocUU3cDk5UnY0ZnJE?=
 =?utf-8?B?N2VPRUNVdXZmR0xDQ0g5aUhRWGQyNkcvbEk5VUo2ckhoSFAzMmNvOUp1bmd6?=
 =?utf-8?B?SU9ITkpZYlhHZWdCZzRRc1FLZW8wWnFkMzM0aGVwczJRNTJXUkdlWjJPTGwz?=
 =?utf-8?B?VlBwRHYrUEIzalRzaEkwZXRZMGN2OXR3VExUUEh1R0VpOWs5QVdDakhObzlH?=
 =?utf-8?B?Mk1rN1VlVm9DSVlkcWpKbzBOYmRmcE8rUHI1TGswZm4rOGhsL1NpRWZKSk15?=
 =?utf-8?B?YURVR2JyRzEyQ1JvRnB5d0pmQjdKdGpPSFlMRTJsRkR4eDU1Mjg4encwNTV0?=
 =?utf-8?B?ajVjaExlcGMyR3RBZCs5bVc4dFl5dldDbUZnTDBmczkvSmcwMlpSVUpMVXRW?=
 =?utf-8?B?KzZFNklZV3JzZEtiRW9WS3ZZdWsvdlRROFFpKzNJRTZpTW44UFVIcnRkQlFF?=
 =?utf-8?B?THlIRXdCRElpM3BBdWJzK0xmL1VaNDk2VVlnVVRVam5wTFF0eTBJeDN3dlQr?=
 =?utf-8?B?dWptb2RLcTBzWUZOWWhsUFJoKzVBYUhGVlR5MFFJT0w3SjlaSVEzYkxrS0Rm?=
 =?utf-8?B?TnE2QTc0cVdqYzR0aHBUaE42OUd6UEErUkNwaG1EU3FJUmtEL21nZ1RQRlNP?=
 =?utf-8?Q?CCnlXJ4jJug=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHpQRmJDOGdsOXpwL0wrT0RCMUMrR2c4dlBjYkEvQ0JYS3VLNVJnYXN3VzZF?=
 =?utf-8?B?OVVRdjBmNGt4Z043Q1ByQThmeHZZQUhERzlLUFZjWXE1YTZ3TVVkMExIYjNI?=
 =?utf-8?B?aUxVTlpUSWY0RDJoeDYxcloySEtKMnBwQ0NuVUQ5QVR4eXJVMUtKQnA4VHhm?=
 =?utf-8?B?NzQzTGtTdFVYYnA4NHkwd2x0TjhlUXRTRlpxOXVWWE1qRmtLNlBVeVFXMmM5?=
 =?utf-8?B?cGxuK1h6VEEybSt3b2V4NFZDSkxIUlBDbmo2NHZ3OHNzYlZDRlRCbnRsbG9s?=
 =?utf-8?B?SGVmNGJocVBKdjZuSWpnWG0vM21xQm52cG84MVRyODJid1R4bUpBVnZLbHNU?=
 =?utf-8?B?V1I1OWxDaytURm0rZCs2MTZEb05naDBUQ1VTUzNYZzY1NDU1bE51ZDBrM3J2?=
 =?utf-8?B?dFBtaldNb2VObWVYbFgxM3Bid1VUTmtpRXRJbkx2TVl0MmFVMEZhUmFYbGsy?=
 =?utf-8?B?WHN4TTZOc2dvZVdWeG04ZlAzdHh4R21PVEs3eC94M2xHUldud3piTmtpMXl1?=
 =?utf-8?B?T2MwRUlWOGwxejZvN05iU0UzQURqdGJYS0tpaS9OckIxZndsS1BiU3RjTG1U?=
 =?utf-8?B?ZVNlMHZBdFZ2S1hjVXVDWERlUTZmTThFd1poTGFpWGR2TW5TZ2xVa1ZKbm1P?=
 =?utf-8?B?SEYyZTZsaTlycWlqYU1KYS9pTWpNdGxDZEpzenJoNWFDeU5iTGVLZXJVTVJw?=
 =?utf-8?B?VTd2Zkh1aysxd2o1Zkh1TGdkMUE0RWo0NXNONUtETVNiRDFKL1RSSlBtQ1Bw?=
 =?utf-8?B?ampXcnVEd2FzNGJ4MjhpSjZFYksxQ1d6VEZaUTZpdXRRMXcxTCtXOW9GY2E5?=
 =?utf-8?B?Zk9hK3ZCb2I2bWEwb2pGbzN5bWtwR0FBbm1DcnBTQ0VBZ3ZMaG16VjU3eUsx?=
 =?utf-8?B?Q0VOQTFGVVNtUzc4ZUpTMEIvRWU0YWQzRy9JYXBrQ1k3ZTdVS0FadkIveEpj?=
 =?utf-8?B?VGNOdFNkdTFRS0ViT2F3MG8xTjVuQk5YK0JNMjZuVy82Tm1wL0NQU2EyNlor?=
 =?utf-8?B?cTdONDFXMHkzSm5qSERqamdLK3J3R0F3T3c2djlwdWEySEVYMUc5SmdkT0Ix?=
 =?utf-8?B?NGVpZDFwRUVMemcydTdsVEVZSUdlTHFQMVFraTcwOURvKzM3NGxJK2pZMjM3?=
 =?utf-8?B?djdsRVNEWndiNUpRcEJFaDZpdnJmUmNrZVFMcW5IMzNGd2t3ZnNldFBJdjNL?=
 =?utf-8?B?Q3p4RXFQK1Q5RW1NSXpIaXhqbWdaRjI3cVhzR3dxOENvZHArNmZzZVRYb0Vt?=
 =?utf-8?B?U2N4MVhWOVRvbGpTYjBWV1RLLzgrYkNkNU1ORVRCcHBMZVgxV0RHVzMvajVU?=
 =?utf-8?B?MGtWYWxOeHNzSUtuZzF1akI5TEt3UDV1d09XdjdlN2tGWnJleUw1M0JSRm14?=
 =?utf-8?B?Uy9rU1U5RjFiWE45cFVXdXFaRmpqYXJSbDhCUGhJUTZFVTZjK25Jby9EVDhy?=
 =?utf-8?B?ME9DRGcwYXFnbG53VFVNNmhWeFFhakxyRDZ6MUtGd1kzSU8vWjc0Skhka001?=
 =?utf-8?B?Q2lrbm5vNDEzWkI3WmMxaW9hQXBaTmtScERDb1pmNFNIN2RmUE11bTRhSnV6?=
 =?utf-8?B?TTFWczF1WlJ3aGNQRHBrRU1ZTjcyYjZRckQvWVRndHJWSTlIM0MxbU1vYVdt?=
 =?utf-8?B?UERmKys0c3pYUnhFVTQ5cTRtbk14M0NaRncyYUJleWpRYlJHb0ZaQUVOSmtY?=
 =?utf-8?B?Skk2aU5rdExFbXY2YlcyNkpoS3YvcXp4MTdaUVVLQU51bkx6OVBib05qREQ5?=
 =?utf-8?B?b29vS0ZlemJvbkQ1RlZpdzJEaGtWVEkvRDYrV05OV2tMS2FKVVFyT0xUellj?=
 =?utf-8?B?bnVNTTU3QjExUGpmNG5zVmdKb0JzRUVmTm8ycDJiZFB0K0UwM0VTSm1Yallk?=
 =?utf-8?B?bFFlQTArNVBibE9IY2dLaW9QL3o4MHlrR1NrblozMUsrNlVud2YweTU5R1FV?=
 =?utf-8?B?dnpMRWdLbk5oaTFPM3FQRlB4WnNOUStJbDFLWG16NFliRUYxM2Y1Ni8zV0ZV?=
 =?utf-8?B?VXNRRU9Jbno0RjhQTzNxUytGMlAzbHJRNGE0VWpScjYrRFFzcDM4U2NLY2Jo?=
 =?utf-8?B?cFBKblRUNU1hRFRLRi9BRnhUYmpyQ0lVdmdSWjRaZGEyODZadXc2ckN0NkRv?=
 =?utf-8?Q?jK+geiFVpm75jamFHg2QdElYG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LO4eCDLEn2MkTXb43WSFJ8I0X5OMpp62SkPLsWk2DuIfXURt+EMgKraOy0e1jaoYHLGF/19FccZPjKJ1kUsF/4btJwxP7+KOwHFUozcN/aVY23RTVxsKDXhmJxlAP5FqpH69LgjzlZwtKo+yVd9B0IcBt9AxAYwk2oKKAxEJGf3NdyXWoaTvq3O1NrwQkYMCAk9YoXcRdnQ/Jg2S2UJFp4vF8u6MH7OXPvOowvcYgZXMtpWKe3GiUoVgdSm1wjPg26r+8yNzXcPCSoWMcsvIgi3bcVN+wjOVEQayIINoyUf7Vgli2Bbbs9oUloITls47HZz3HbcksTzsRHLQyyNHfqfiXpMYca72Shsl9s6FU20cqTQeUNCKyyg59HCTB4ncZuorK2gsyEwfBuCDerSVGIsHpzfw6nseNCu9QnS7JTtxCchWegBML7ayybCH+BZETOS2KLRJd+E2eskTBff6bqH7g2C34QRI33nKrfwBFhdNLk5PpisxicO5n7ijovBzlZzUu+khwCov/OLvVQnmL8vOa6+MuN1eHtnkWMQ7JTTyHQxlmcxqajTj07pCdkywAWYjIRr+6PgNti7TinSPiGcy9lkFg9a7qliLJFrFvwCNsMaZm63cxz9oECuGL6fN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9084a9dc-4ebb-40c5-6c00-08dcaa1bdc63
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 06:59:41.7576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lm0iL9/xJCY4ns4w/bHZZPrjjvWjOfr/TjZ2KSX+pO+zEOZSOVun0dW+XYX2iwt0Ms6/ASwbA+7cYst786S6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5341
Received-SPF: pass client-ip=68.232.159.90;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMjIsIDIw
MjQgMjo0MyBQTQ0KPiBUbzogWWFvLCBYaW5ndGFvL+WnmiDlubjmtpsgPHlhb3h0LmZuc3RAZnVq
aXRzdS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
MC8xM10gbWFrZSByYW5nZSBvdmVybGFwIGNoZWNrIG1vcmUgcmVhZGFibGUNCj4gDQo+IEhpIFlh
bywNCj4gDQo+IE9uIDIyLzcvMjQgMDY6MDcsIFlhbyBYaW5ndGFvIHZpYSB3cm90ZToNCj4gPiBD
dXJyZW50bHksIHNvbWUgY29tcG9uZW50cyBzdGlsbCBvcGVuLWNvZGluZyB0aGUgcmFuZ2Ugb3Zl
cmxhcCBjaGVjay4NCj4gPiBTb21ldGltZXMgdGhpcyBjaGVjayBtYXkgYmUgZmFpbCBiZWNhdXNl
IHNvbWUgcGF0dGVybnMgYXJlIG1pc3NlZC4NCj4gDQo+IEhvdyBkaWQgeW91IGNhdGNoIGFsbCB0
aGVzZSB1c2UgY2FzZXM/DQpJIHVzZWQgdGhlIENvY2NpbmVsbGUgdG8gbWF0Y2ggdGhlc2UgdXNl
IGNhc2VzLCB0aGUgcGF0dGVybiBpcyBiZWxvdw0KcmFuZ2Vfb3ZlcmxhcC5jb2NjaToNCg0KLy8g
dXNlIHJhbmdlc19vdmVybGFwKCkgaW5zdGVhZCBvZiBvcGVuLWNvZGluZyB0aGUgb3ZlcmxhcCBj
aGVjaw0KQEANCmV4cHJlc3Npb24gRTEsIEUyLCBFMywgRTQ7DQpAQA0KKA0KLSBFMiA8PSBFMyB8
fCBFMSA+PSBFNA0KKyAhcmFuZ2VzX292ZXJsYXAoRTEsIEUyLCBFMywgRTQpDQp8DQoNCi0gKEUy
IDw9IEUzKSB8fCAoRTEgPj0gRTQpDQorICFyYW5nZXNfb3ZlcmxhcChFMSwgRTIsIEUzLCBFNCkN
CnwNCg0KLSBFMSA8IEU0ICYmIEUyID4gRTMNCisgcmFuZ2VzX292ZXJsYXAoRTEsIEUyLCBFMywg
RTQpDQp8DQoNCi0gKEUxIDwgRTQpICYmIChFMiA+IEUzKQ0KKyByYW5nZXNfb3ZlcmxhcChFMSwg
RTIsIEUzLCBFNCkNCnwNCg0KLSAoRTEgPj0gRTMgJiYgRTEgPCBFNCkgfHwgKEUyID4gRTMgJiYg
RTIgPD0gRTQpDQorIHJhbmdlc19vdmVybGFwKEUxLCBFMiwgRTMsIEU0KQ0KDQp8DQotICgoRTEg
Pj0gRTMpICYmIChFMSA8IEU0KSkgfHwgKChFMiA+IEUzKSAmJiAoRTIgPD0gRTQpKQ0KKyByYW5n
ZXNfb3ZlcmxhcChFMSwgRTIsIEUzLCBFNCkNCikNCg0KdGhlbiBleGVjdXRlIHRoZSBjb21tYW5k
Og0KIyBzcGF0Y2ggLS1tYWNyby1maWxlIHNjcmlwdHMvY29jY2ktbWFjcm8tZmlsZS5oIC0tc3At
ZmlsZSByYW5nZV9vdmVybGFwLmNvY2NpIC0ta2VlcC1jb21tZW50cyAtLWluLXBsYWNlIC0tdXNl
LWdpdGdyZXAgLS1kaXIgLg0KDQpidXQgc29tZSBvZiB0aGUgbWF0Y2hlZCBjYXNlcyBhcmUgbm90
IHZhbGlkIGFuZCBuZWVkIHRvIGJlIA0KbWFudWFsbHkganVkZ2VkLg0KDQp0aGVyZSBtYXkgYmUg
Y2FzZXMgdGhhdCBoYXZlIG5vdCBiZWVuIG1hdGNoZWQgeWV0Lg0KDQo+IA0KPiA+IFRvIGF2b2lk
IHRoZSBhYm92ZSBwcm9ibGVtcyBhbmQgaW1wcm92ZSB0aGUgcmVhZGFiaWxpdHkgb2YgdGhlIGNv
ZGUsDQo+ID4gaXQgaXMgYmV0dGVyIHRvIHVzZSB0aGUgcmFuZ2VzX292ZXJsYXAoKSB0byBkbyB0
aGlzIGNoZWNrLg0KPiA+DQo+ID4gWWFvIFhpbmd0YW8gKDEzKToNCj4gPiAgICByYW5nZTogTWFr
ZSByYW5nZXNfb3ZlcmxhcCgpIHJldHVybiBib29sDQo+ID4gICAgYXJtL2Jvb3Q6IG1ha2UgcmFu
Z2Ugb3ZlcmxhcCBjaGVjayBtb3JlIHJlYWRhYmxlDQo+ID4gICAgY29yZS9sb2FkZXI6IG1ha2Ug
cmFuZ2Ugb3ZlcmxhcCBjaGVjayBtb3JlIHJlYWRhYmxlDQo+ID4gICAgY3hsL21haWxib3g6IG1h
a2UgcmFuZ2Ugb3ZlcmxhcCBjaGVjayBtb3JlIHJlYWRhYmxlDQo+ID4gICAgZGlzcGxheS9zbTUw
MTogbWFrZSByYW5nZSBvdmVybGFwIGNoZWNrIG1vcmUgcmVhZGFibGUNCj4gPiAgICBhc3BlZWRf
c21jOiBtYWtlIHJhbmdlIG92ZXJsYXAgY2hlY2sgbW9yZSByZWFkYWJsZQ0KPiA+ICAgIHF0ZXN0
L2Z1eno6IG1ha2UgcmFuZ2Ugb3ZlcmxhcCBjaGVjayBtb3JlIHJlYWRhYmxlDQo+ID4gICAgc3Bh
cmMvbGRzdF9oZWxwZXI6IG1ha2UgcmFuZ2Ugb3ZlcmxhcCBjaGVjayBtb3JlIHJlYWRhYmxlDQo+
ID4gICAgc3lzdGVtL21lbW9yeV9tYXBwaW5nOiBtYWtlIHJhbmdlIG92ZXJsYXAgY2hlY2sgbW9y
ZSByZWFkYWJsZQ0KPiA+ICAgIGJsb2NrL3ZoZHg6IG1ha2UgcmFuZ2Ugb3ZlcmxhcCBjaGVjayBt
b3JlIHJlYWRhYmxlDQo+ID4gICAgY3J5cHRvL2Jsb2NrLWx1a3M6IG1ha2UgcmFuZ2Ugb3Zlcmxh
cCBjaGVjayBtb3JlIHJlYWRhYmxlDQo+ID4gICAgZHVtcDogbWFrZSByYW5nZSBvdmVybGFwIGNo
ZWNrIG1vcmUgcmVhZGFibGUNCj4gPiAgICBibG9jay9xY293Mi1jbHVzdGVyOiBtYWtlIHJhbmdl
IG92ZXJsYXAgY2hlY2sgbW9yZSByZWFkYWJsZQ0KDQo=

