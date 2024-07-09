Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200CFC3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4BI-00017z-A4; Tue, 09 Jul 2024 02:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4BG-00011P-HT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:26 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4BE-00083R-OT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720505903; x=1752041903;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=2WVDF4rjnfmvDZBc7FLb5eC/asqs5NQ1qYPmmPWrRRU=;
 b=FjROojVewS7WpLtox6AXIVfe11vvo+/m8WCyD2CNzYlaeR5ZlDxVcSlx
 ya/GE3KyQnxJpXfv4Yd0QMow3Mg8B+k0VufaMVi4VFl5S9BTCrgn1cMBG
 p1wijwnlUk7Nm7oTR5ukZNZpuVrjEl8PvZfh8I39aTt0csCcINe52Ywfe
 7j8fqFnZ8By6X/HsBatgHAfnh8+xiDYuqZvhVA2XfSpNvjql/QzHc7sxN
 UEg37Pitp+SIfZu/1ElF5WKvM4Wr8WQ5r4CniMjkp5gaVyckjdr9GDD/D
 1UMtUvx4mM2oqU3nAEavtg7anbbV+LtqvaM+aCX8G8/x8dxtVkJAecZbV w==;
X-IronPort-AV: E=Sophos;i="6.09,194,1716242400"; d="scan'208";a="16131804"
X-MGA-submission: =?us-ascii?q?MDEQ2BdnYKmD3uwXoH2lnNfIyU6D9TCZlgH++I?=
 =?us-ascii?q?WRcTQFyOmYXOFkyVhPAdOVr4i4sZjOCrrmI2Oycayx9ibDWn86zullzZ?=
 =?us-ascii?q?QiylaRUvm1a7m+FrNHzc+cf9VDouumpYW5yl2GZBBJZVw6ZuhXRVNvbJ?=
 =?us-ascii?q?NVKsVF3K2vFb9jgMUjPWQgPg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 08:18:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+FCulyJXVfjEQ0BtRmtPSIfMyWiVR5XMkfafufUnehsN1Rd0hs5Gd7XLepCiUml0ZrYFlfE3mLV3b3tM2BOmByvkJowxcQRaYz6+AaPWp/x1zvru4AMDNlNZB7eSQO01aoytopiudSV0psD4EKLf4u+DC1ZbAoz9DlanRkyvuBONQGWbf+JnfbILkXrmeMduH52QOnBxeIQsi9MY6oSOSmX0imsp348BzDXXs2lc0JXyhSlMqnJQwHfT5PRvB5uhisD/dWGQcoCX4bjeEG0qKg7BFiQ48uQPllZXPZjS89G1F2injoTMWytz8awtegYeceOuss6evB9Kpenz25CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WVDF4rjnfmvDZBc7FLb5eC/asqs5NQ1qYPmmPWrRRU=;
 b=sFt0znU2h8QZANE4EcJNUrUIwtEqdu6JGPfuHn/lT+4K+ks3qva4oZclMEgds8DHrEJiySCPgk4DOal7MKwQMHeb27+nGXhP37ivV2Wj+tbLZ97t7hhuuUOdGkz4kId8WNQgAQvRSZiVgC9luwN+Wrm63SJvS0WLCG3FG98a+MX12YasxeZC2MewwTZvmzvrHjoHIxk/9eK2ivcp0Rwaqi4/O12uD2joHQN8YCvZ0sbSrBrEetkLh1WTyHk8RqaB73/hR3ShssSTDUoW8WyKEl/aLzuRBvimXXo9fxC8qzsgAvphshUYEnZwrh5W4tUOHaWlldd4vxAhs0j+2DmC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WVDF4rjnfmvDZBc7FLb5eC/asqs5NQ1qYPmmPWrRRU=;
 b=c+se8I3lDlHKcsoEG7EWCkvMRgOHU7yjiOznPx0paWBALD357u2nrl/P1eFlXRvXbx4LGzPvNMjBPDjFIr2GoL/4nFxxsFOkdA9WnaSg4mKYyMmhiwcVwiPn6WrRiKIah5sxr62CmfoJKoZwnPcqjOdWb0P25T6Ex2tK7BXWEhPzqHGcIjed+VLZ6EqhhekuwR0eB8r/MJdKfmuYNxgZhB1J4Sbd37/mi5T8ijDyRoHWeH0M5+4Qo6UMjPHRk01C1cEzBFgprC2hpGeheIynz9zFocGD8Ny9XRj69d+siofEVpNQkW3AHfW36by5czfKz62+oQ0N0aWVKSmEiULIrg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8466.eurprd07.prod.outlook.com (2603:10a6:10:355::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 06:18:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 06:18:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v6 0/4] VT-d minor fixes
Thread-Topic: [PATCH v6 0/4] VT-d minor fixes
Thread-Index: AQHa0cfClQmKzdX7ME6kH9T0m4xR2g==
Date: Tue, 9 Jul 2024 06:18:05 +0000
Message-ID: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8466:EE_
x-ms-office365-filtering-correlation-id: 7c1dd39b-5582-4d56-66b2-08dc9fdee530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MUg4NkUxYzRHa1hTMXlHTTVPUElOMUNjWmJhYkZ5d0I0NHdrTGtub2ZQS1RB?=
 =?utf-8?B?MHcvWndpcnpObmNZZnd5U2pRekZBS29CTnNuallPendLaDlCbDYvMXdEU29o?=
 =?utf-8?B?YzlDQ056NU5hQ24yc1JwR01WVVNrUlJNbkxZUkVlSlhPMExTdEdnQjdPWmpL?=
 =?utf-8?B?TGx0bC90M3I4T1huTEtjK1cxSkRLWE5MYS96RUp1ZzZ2L01GT0Q0NTB2YVZE?=
 =?utf-8?B?d2dpUnNuWDUxc2lMaUgrT1Z2R1lFdStKdFVlLzgwcVVaRys4dG1iNXUwaWZ3?=
 =?utf-8?B?R3NrQlFWV0pXeWxaRjJzaXNBVW1IeHUvSEZ3OVJJOUllMjJQdzNhb0hjZUVZ?=
 =?utf-8?B?NFRxaW1IaitoVlRqaU5XUzNpaS9Fb2NZR3RQTXZGUXAwYkNkUU51TjVFelhG?=
 =?utf-8?B?Z2FmZUZjTVRaQXhiVEJxcFg2dnUyUGVZdTVBSzRlTEhXeEtTeW1jR2h0VWVZ?=
 =?utf-8?B?N0hBdHJSV0VCSG9POE1pTGFRdGdoc2lZS0ZwQTNkRm9xZm9lVVpyMjJtemxG?=
 =?utf-8?B?UlM3a0JBbFY0NTByQXQ2Zk55ZStlRktHaE5IMWlGaGZZZzQ4aXBvRlNQRDBU?=
 =?utf-8?B?cXhVSXA5MFlhMzcrSU03VGJTT2xLMEdJREowb0dFeXpsL3VqQlUzb2s3Njcz?=
 =?utf-8?B?MEtpZVYyVXBpWVl1RTNJYklxN3F2YkIwWUhONGVDVUNMdUZQOFdtdEs4UVp5?=
 =?utf-8?B?V1JaQlF0L0EvQWQ3SFhOSGQ3dk9RdUg0MGNPVENqVmVtd1c1R2RtdjROZ1l3?=
 =?utf-8?B?dXVpSW1Yckd3bXEyczdZaEJ4YlNYWFovaWp6UFpPTW01RE80enBlUXkvazZx?=
 =?utf-8?B?L0V6b3NrZ3pSQ1Q1TFh0bFRpeTYxWWVwUU9yQlRrMnp4L2VlZERoZllkWFNL?=
 =?utf-8?B?a3FhZ0Fhei9jWG1SSjVlSHpmSjZsYUx1V3lyNElCOEovY0NlK3d0Vk9mVlU5?=
 =?utf-8?B?ejRCZHJUdFVGRWtRUkhNMkVDTXdXTUYvMFlkZG5BRDAybmwwWjFHWWxxdGh5?=
 =?utf-8?B?QnpmNHZJNTVJbU5wQnd3ZXlUK284VVdhNTFSUmZoK0p6SEsyOGtkK1FxeXVB?=
 =?utf-8?B?M2t4SkRQb1ZrK2dnYTdGMVVGT0tRTHBCRVllSWxiN3pRckxCUjNkME4xbXJU?=
 =?utf-8?B?V1FvNlJSVkNZUUV0U2taUlVZcUxWYVI4NElXc1k4bzF1TVd5RW5xMDEvOFdo?=
 =?utf-8?B?eklRcHNTU01jQWVPYncwdXh3cjU1N2M1N1RjdzhUenVyU0ZnOHVvVXpiR3gr?=
 =?utf-8?B?cEdIOWFkWlE1YlBZQ0pydHJSUzdnNjFrT1lUMjl0bEdSY3E3eGtvbDFvd085?=
 =?utf-8?B?b045c1F3V3pvd0lZYWNkZmNsdmh4YjkzYVFPbmRvcXhpOUI1akVCLyszS0Vs?=
 =?utf-8?B?K0RRTjk4aS9YbksvbXhnd01QMFRuR3FQSUVUbEN2OTkxV3dyMjE0am1FdWF2?=
 =?utf-8?B?Y2VlaWlFa1Vvb21DTENCWmZnS0VhaDExRHNZVDgrK1NieTRxLzVLSklidEJB?=
 =?utf-8?B?MmpnY2JuOGdhb2llVVF5ekpPeEVJdmUzTkU3bDNtWEp0R3FTY0RHQi9ZREw0?=
 =?utf-8?B?OG54cE1VUE9CTmhWNVRKMzJHNGZoU1g5bk9RZHNMSlJVMk5OdGdvZDU3Y1RR?=
 =?utf-8?B?M1hmU3kzaGdaUm56cXl6S3F0SktDei82MmVtcHJiQzVUcWNCWDZNUkladGp5?=
 =?utf-8?B?bUdyZWpOMXFiZjRWdlZIc1psQUZRMTBTSjg0QnhOM3ZUMlRJTmVDOU1XNW0r?=
 =?utf-8?B?bWVUV0JZQzVSbGhmOThxMkFCaG92VVhGcGZpWk5VcVpuR2UvOUx2eEw2dis1?=
 =?utf-8?B?SHc3MDlvVW56bnNpSFdXTlRmQkZ5ZUpGOVB1akxzZ05LdDRpMFlGRnNYZGFT?=
 =?utf-8?B?aElqLy8xb1FCcmxTL3JVT1VKL3JiclpOclVFRkd6YnQrNVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zkh4cnoyMGY0SkU1ZW42ajhzeWZtU0paUFMybnRnM2lTSXZwUk1EaEU5Mkty?=
 =?utf-8?B?aWprSC8rWU5VV3hjUUpOWnh2eHNURVNkRVJUZ2dzK1hLQ3NGRXNiMWRtM0M0?=
 =?utf-8?B?alB1c25mSzdPNC9neGd5blg3TzkvWkQ0bytZK1JHa0VFRTdQb015VGUrc2ZM?=
 =?utf-8?B?QW44bFhsVk5uanBpTHNoeXFSa0ozanVOUUlOS3JQV211YW9HZ3dybDhPR1Vm?=
 =?utf-8?B?MVZ4eDFHL25KUFlSQmd0WUVoNndzSzk3ajdlM01HZ25xRFBpa1pZeTk0L3I2?=
 =?utf-8?B?VFMvSUlYRE1wcUk2UFhxRnU1N1ZxVDlTU1pTa1d6UEp5Z0s2ODh6RnV3L2NE?=
 =?utf-8?B?YUMrQWhkNUY3TGw3SHh5TXJUZ21iQWlMOWVaMnNlekN3LyttSWxkQ2hDSnZm?=
 =?utf-8?B?VWo2ZEJmNHBER1FEMXlhSEh4dGhLSWw3S0Qvbngwb2FNVWdrMTJoc1pCSjNr?=
 =?utf-8?B?VUNabml6WmJmSW81RGhTY3lKKzF6VkM1WnQ1RmlIRDRIQkhScTN3Y1ZvOHRm?=
 =?utf-8?B?TWdoQlIzMDBLdWg3RFJTeXIwc1UyTGZQTi91aFFvKzdrbVl4ZkxBMlg1UWVp?=
 =?utf-8?B?NzR4L0prbndlclNnbVNQRktGaXFGY0JCQ0h6UTZuSFIrc3hWeGthZXQ0TWFn?=
 =?utf-8?B?bWpaVkNoaGM2L1Z3eEk1Tmx3SG5pQjhlZ3ZLNFRLcG5OSmJ6NjlQaU9nTDEx?=
 =?utf-8?B?ZEtZRkNmdm9oT2Q1Nm8zajNpMm5iYldNWDB6TWVYQmJRUDM0ZlZsdzErVHAx?=
 =?utf-8?B?OGUveFdQaU9hRVQzYXpTb3ZQc21xNDJGSEFWUTBIM2N6THRpdzd4QXJPMXRh?=
 =?utf-8?B?Mjh0OTRFT3FQVXVNY2tZRWZ4QmZHZWxlcUhKV2VmeStSK1J0RFpteUI1N2JL?=
 =?utf-8?B?dHVzRjJORkhsT2x6UDlmV1pHNVk2Z09TMVBMSUJJbU9ZcFBLWmN2d2lNbHk2?=
 =?utf-8?B?UllzYllKTGp2UUVrMmM1Vk1zZDVWOER5UGlkQTBUVzg5Y3ErN2R3WHBrM1Ez?=
 =?utf-8?B?MzVpTXVoQ3djbTBOMXZCVzYwVWo1VmxpbWZzZzF0eXhZMmlDVmRRUGgzOGcr?=
 =?utf-8?B?TmllZC9xaVprR1d3U2RLa09BQXg3b2RBUVg0NzRPaFpURUhEbm1nOTlQRmhP?=
 =?utf-8?B?SDE3bm1aQWtndFI3Vk1Wb2JyT0Z5U3NDSzhvc2VVM3FWaVd2VmVpUW9JNU5U?=
 =?utf-8?B?cXhDY2xTTVNweHE5R29TZE1jbzVGZDFVMTBQNi8vOE5PK3ZZSVlHbUdyYXJv?=
 =?utf-8?B?QlRlZkF4N3BDQ00vMWNKSy9wSU1lS0llZlRSOXdYeVRZZXNCY2FnTllxUldk?=
 =?utf-8?B?djlOSzhjemwrYVZpYmpBeGVMZkF6dWZYcmJ0UFVhWjhXR01hQW94SGI3WGFk?=
 =?utf-8?B?SFdweDdTOHE4MlFJeXhBSkVNN1VUOTg0b0hhbUlYK2FQMmZCdGtWazdpTXRn?=
 =?utf-8?B?SWxCMi9mQ1BkM28yU1B0b0pkcndPUW5uQ1dxSEFXaC8yQWdhbHpFa3dPRndT?=
 =?utf-8?B?VVZydjVONzI1eVcvdzRNVDVQNVR4NmdSbWswQ1VYTzMraDB4TzRiV2pUYklp?=
 =?utf-8?B?SkJ5WWdkN1VDclFLaFhWd1BkbUF5MVVKaHdObHpmTDRXeUJpSzYzNG54cEFr?=
 =?utf-8?B?emZoMC85OEVLZkV5cjBsT2c1TGxWdVFBNnoyRmRrNnJiRTFiRTlBQkk3dk9u?=
 =?utf-8?B?QVBRSjhhTGZ3cE9GSERXaWtEbWlnNWhtclJjaGRHcitzc2laRTdvRnBNWCs5?=
 =?utf-8?B?SzBRbkpEdVYzM29NS0tDdWc1MEVpNjJ2cENhZ2VjYWx3THFwbWFONURDSHZ0?=
 =?utf-8?B?ZGhrcWxQTkpYY3JBRWUrNXVFNE5xNXViMkhZRmVVOStzRTRoeEVySnVLd3Er?=
 =?utf-8?B?YWJuMzcvaEZqOTRxaDlKcC9zUFZ1NTZCa0hMM1J5Y3A4ekZhTnZXcExNcDBw?=
 =?utf-8?B?SUg1N1JSSmo2VnRKRDNFL1JBeWptamp6bEpVc3lvdGpObUlJQTlKT1dWOGNo?=
 =?utf-8?B?UHM0T2EvSlNzZFN1dGZDZnRIaFZMTkFXT2tHWDd1OFcvak9Kd3BCeVlMYUFs?=
 =?utf-8?B?R09KU3c3ek4vK21tVGttWHNCeXBOL0g4ZWNIQkxWdmtMWVVmYU95eno3OCtQ?=
 =?utf-8?B?cUVKa0ZLVk9GOTlYQ3EvRnozV1pZREVRUmhrOG01czZud2JmUG42U1RYTnp5?=
 =?utf-8?Q?fUrdN9479YyNYit9PgnDaTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C13921358EC0549814BE6F9C66C4444@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1dd39b-5582-4d56-66b2-08dc9fdee530
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:18:05.5840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 573D8WFuFL2y8mllnED+nRoT+yCVeaUBTM8AWrWNPWGpik7xZS0a7scqfZW/4Lzon8HLeNfbZG+48Abiw9HA5jAhztuBWplEvAlRAZIVS2L0kOOmjaSvoW+NdDuYkJmh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8466
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClZhcmlvdXMgZml4ZXMgZm9yIFZULWQNCg0KVGhpcyBzZXJpZXMgY29udGFpbnMg
Zml4ZXMgdGhhdCB3aWxsIGJlIG5lY2Vzc2FyeQ0Kd2hlbiBhZGRpbmcgaW4tZ3Vlc3QgKGZ1bGx5
IGVtdWxhdGVkKSBTVk0gc3VwcG9ydC4NCg0KdjYNCiAgICBpbnRlbF9pb21tdTogZml4IHR5cGUg
b2YgdGhlIG1hc2sgZmllbGQgaW4gVlRESU9UTEJQYWdlSW52SW5mbzoNCiAgICAJLSBBZGQgJ0Zp
eGVzJyB0YWcNCg0KdjUNCiAgICBpbnRlbF9pb21tdTogZml4IEZSQ0QgY29uc3RydWN0aW9uIG1h
Y3JvOg0KICAgIAktIFJlbW92ZSBlbXB0eSBsaW5lIGFmdGVyICdGaXhlcycNCiAgICANCiAgICBp
bnRlbF9pb21tdTogZml4IHR5cGUgb2YgdGhlIG1hc2sgZmllbGQgaW4gVlRESU9UTEJQYWdlSW52
SW5mbzoNCiAgICAJLSBFZGl0IGNvbW1pdCBtZXNzYWdlIGFmdGVyIGNvbW1lbnQgZnJvbSBZaQ0K
ICAgIA0KICAgIGludGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNoOg0KICAgIAktIEVkaXQgY29t
bWl0IG1lc3NhZ2UgKHMvIm1ha2UgdHlwZXMgbWF0Y2giLyJtYWtlIHR5cGUgbWF0Y2giLykNCg0K
djQNCiAgICAtIE1vdmUgZGVjbGFyYXRpb25zIG9mIFZURF9GUkNEX1BWIGFuZCBWVERfRlJDRF9Q
UA0KICAgIC0gaW50ZWxfaW9tbXU6IG1ha2UgdHlwZXMgbWF0Y2g6DQogICAgCS0gZWRpdCBjb21t
aXQgbWVzc2FnZSB0byBleHBsYWluIHRoYXQgd2UgYXJlIG5vdCBmaXhpbmcgYSBidWcNCiAgICAt
IGludGVsX2lvbW11OiBmaXggdHlwZSBvZiB0aGUgbWFzayBmaWVsZCBpbiBWVERJT1RMQlBhZ2VJ
bnZJbmZvDQogICAgCS0gZWRpdCBjb21taXQgbWVzc2FnZQ0KDQp2Mw0KICAgIEZSQ0QgY29uc3Ry
dWN0aW9uIG1hY3JvIDoNCiAgICAJLSBMb25nZXIgc2hhMSBmb3IgdGhlICdGaXhlcycgdGFnDQog
ICAgCS0gQWRkICcuJyBhdCB0aGUgZW5kIG9mIHRoZSBzZW50ZW5jZQ0KICAgIA0KICAgIE1ha2Ug
dHlwZXMgbWF0Y2ggOg0KICAgIAktIFNwbGl0IGludG8gMiBwYXRjaGVzIChvbmUgZm9yIHRoZSBm
aXggYW5kIG9uZSBmb3IgdHlwZSBtYXRjaGluZykNCiAgICANCiAgICBSZW1vdmUgcGF0Y2ggZm9y
IHdhaXQgZGVzY3JpcHRvciBoYW5kbGluZyAod2lsbCBiZSBpbiB0aGUgUFJJIHNlcmllcykNCg0K
djINCiAgICBNYWtlIGNvbW1pdCBhdXRob3IgY29uc2lzdGVudA0KDQoNCg0KQ2zDqW1lbnQgTWF0
aGlldS0tRHJpZiAoNCk6DQogIGludGVsX2lvbW11OiBmaXggRlJDRCBjb25zdHJ1Y3Rpb24gbWFj
cm8NCiAgaW50ZWxfaW9tbXU6IG1vdmUgVlREX0ZSQ0RfUFYgYW5kIFZURF9GUkNEX1BQIGRlY2xh
cmF0aW9ucw0KICBpbnRlbF9pb21tdTogZml4IHR5cGUgb2YgdGhlIG1hc2sgZmllbGQgaW4gVlRE
SU9UTEJQYWdlSW52SW5mbw0KICBpbnRlbF9pb21tdTogbWFrZSB0eXBlIG1hdGNoDQoNCiBody9p
Mzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAyICstDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIHwgNiArKystLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjQ1LjINCg==

