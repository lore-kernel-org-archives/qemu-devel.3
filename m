Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBBAC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jp-0006p8-BI; Mon, 03 Jun 2024 02:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jh-0006kO-Vv
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:03 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-00072k-Io
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394398; x=1748930398;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=W33qgJlj8867w6c1KTEAjJW0x8cQ2o+WdwuKiyAF9N8=;
 b=v8q7SbZ3+WkDuoa03x9MHm80ssyPn2MFwGjujP7HY1ji5up7HEdGZkph
 Nrjc+PcYzBLUp+A+hhFHUqJi7z/lkVPCR88MrR4zaQvFA9JbDkG0433SV
 OL2BBD60DiOOWcG8c8baTq1e1IkqAedYoQKYJbnI5vG51M+WBcveWvgy6
 QnC+InYDC9rxULSPpjZ0nLeM2//yAtiLgzDTU4oPfLgyu/dckwG0UeM62
 aLhNAv9zunymU1fULX552NsuL7y8BlOXxb+DUbvtiiglhhA9XfZF2K9t6
 ncUTgtFgYfn3zaFaZsjV+NtbkwWfAEWbUqflxVX4r6bdFbvNtMdzRcnAf w==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13756562"
X-MGA-submission: =?us-ascii?q?MDEQtAu0EWTMmskPRTfUuDFJb2evkVjPw1FlVz?=
 =?us-ascii?q?hIiyNFP7TFTPJ/AI0bFHI5XCyKps3UgXvMN2HNiE/2Ju1dN5nAvh/3OG?=
 =?us-ascii?q?7CvTxbqJTuxowuxuyO1T6wnbd+90TLXjKI+Mxl3t9Fi3txKg7LKkul0t?=
 =?us-ascii?q?fi7FiZV7p47+Dzgb9TAP1p5w=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWg6OAHQ2ZAh56+HtLikYtObw0dqWaFUmmr4D7AKQ6qdvNGmmgi61GmVz+CnvgXYua6DdTlqT4mKVmW5XaXodHAbeDFdzidvNJ3/BN0Is4/+uIBJZQ43CpfSwThbD7K00WzJFi+g/PvtRFMMblvNJyMB6CSnd/EG9Fv45ZCMTd6vYX8xgg1hIFNSE4jq480zvrdUn2btJYzcZJtnEMVjMP+Qy6uxIdvztwa3M7+vgXv6dONWubOdAFDDyVWCLMLaiqEtJKHHJdmIF+igasqxmcWO+FHE9ueWiptLelBkTlcxliNFT6veC/uSvMuIbtjOrzKPrRSFMnCP0XVyBNATmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W33qgJlj8867w6c1KTEAjJW0x8cQ2o+WdwuKiyAF9N8=;
 b=eVEAD5R27b35OwYkX16RxdjInOl7VXJtW5Fm6tcgaNWuuw3uMlRcUC3qhNNli1n0a6LuzRT4EK+MLAA0jtDNDtdw/puAirfzMHtK5xm79Nx1PBpg87zZV+h2ISACgrikpEhJC0JHe3mv3AW7g3V841NZ77iEGzymHte3L4j74H4lLLAV0LBHnwx6KqPnucjPs14r+wxFahtXGH6L6GlCI5Au+EfUCRQmBPGmNMLO2tHjxeSmOZsMcjdXiq84x4EyXZJCazuS37yMCh2LI/vvfwCI/NoRpvSRY6OAbm/+2DNG7rstoMG8K1oVJT9cS5sIdS98I9KRin9wpO4T5MPG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W33qgJlj8867w6c1KTEAjJW0x8cQ2o+WdwuKiyAF9N8=;
 b=MkzGHw5cl8GfghcwP+BhhGVq64dgBY3U9zpkfVimpf4Oo8dPdZndcSIxmpJo2Yg4mTO6SP65pgHR3L8DMhUcu5/BfnThHGqVNggsukMC0oSpF91BWKbekG7gQsMU9+rk/1XvDCGBXqjbtf/auIkWkkDDDIUU9hmuClbLqCUH2HohBbHkwYIr7csxlBcsofCY6O1DPaYOoO9GpCU1YjWXkK6/r5CtnYj04goQmWQb8cH3sHZwWq5rY7jMBXpMaqlnBgk/UDkOzji3kzWG41tkBneSKrBQkAgLVwd045DiGEW62nAlt9RAmj6zeftM0oC3ZakKKsteFfbnWKi1pYI5kw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:50 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 15/22] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v5 15/22] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHatXs+/LPVl7uy7UyWTgdb2IXfNg==
Date: Mon, 3 Jun 2024 05:59:50 +0000
Message-ID: <20240603055917.18735-16-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 186f3082-8130-4d64-3765-08dc83926175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Q3pXRkQrREE5Qmo5SmhLZzhEYVZLRUtxRVNweVJpd2E2RUZXOGV0NXkyaUlm?=
 =?utf-8?B?T2hBeVhmOVRyMmVLWVlPd0xaV3NXZEdLdHRhZE1GTEpTa2wzS3hBYTJIMzdB?=
 =?utf-8?B?Nk9GQU1JVHRtNXJRZ1kxRnlVeStLTDBEeHdrMytoV1hPeGplR1FIejBZbEdO?=
 =?utf-8?B?ejJWZ3d3TzZnVTFYTWpCVUxWVjlMK0ltQlFuT280eWxOTkZwNVpuY0JlN1BE?=
 =?utf-8?B?L0dIZlpVeDE5TXlmOUszbHJvbTgraS8xRmdEakJqemtwRTBETWJxeEZiQ0Fm?=
 =?utf-8?B?RDVMY2M3SEE2aUkyNEI2SlBKVHRZcGxROHBKSzdwUUZIUWpGVXh4TjFWMVli?=
 =?utf-8?B?VitGZitTVkFyNUFjWXJYMTRVYkwzOEpuMkZ2RXEyZ1liemUwVERlL2Z0R3dJ?=
 =?utf-8?B?dXNXcDhrbWQ0aEhpK1FVMzZXQ0tVaHEvZ05IYlp6YS9zYzRQY3UzdmdyVHFl?=
 =?utf-8?B?emJoM3RobHYvaFkwSGRnWThIblRZSUQ0aXRXbTY3MjUrSENvSjNEb2h4dDhr?=
 =?utf-8?B?dWs2cllvODMxZktMcHp6M3hWNjhMaXkwY2E2NDBWYkQvQ050UEh1aHZIa25W?=
 =?utf-8?B?SlhJM0NkNzB3VEJjeGhSNEd2b3Ztb2Z6bUhwRHY2b2ppemZha0VSeUNDdm90?=
 =?utf-8?B?Q0tjWWFSVnBLa2NlRmJ5WSs3a3BkYjlSUHVjTVJHc29taUoxcHJDUjJNMk9T?=
 =?utf-8?B?OWpkRm1lNVFFc056VUhreUlvMC9sMkUxSTB2QnlCRDdoMC85MDllSFJoaU1K?=
 =?utf-8?B?a2MwSy9sSnA1VWhmQ2xTcGgzcmNUU3ZkSm9zbVRHWERYVHlnME1nejRXUSs1?=
 =?utf-8?B?QThmUVZsVTQrbGdvN0E2UDQrc3pxZUJWTEpwN05JTmkxOTlwaTg3RGVZK0tX?=
 =?utf-8?B?MkhaeUVrWVM4TFhBbmJuNHJyOFAreDlUK0xBNUZUbjltdEJXUk11TzBPTWkz?=
 =?utf-8?B?b0QvSkZvNkRKWmpYY1ZJWUhTUU55TzRZN2xuQ0ZQNlVXT2lzK2xZcm1tRXB3?=
 =?utf-8?B?MUJQeDlwRXpoZ1hxS25KK1NEWnpSYStnaUVxRW9sMXJkY0Z1djBwZExUeElN?=
 =?utf-8?B?b1dydXlYd0hmMStzTEcxL3BFZFlMc1BleVFNeDJFalZxUnNzZXpzZThCK0VM?=
 =?utf-8?B?Q0V4bVdWN0VpbktNK1VmNzBpV2lTWk05RUhaMzdxU2NXNWJ4cys3NDRjZDRJ?=
 =?utf-8?B?VW1nYVJ1ZWNwam9pWEdCcXByOGxCcVFoalFUVkErUWROb2xva3ZPNXI1aCt6?=
 =?utf-8?B?cWlmQmFpZVlvRThhc2dpUm1kSUxCSWM0YUFCM0hmcUJyaGRyQVRnRGR4czhP?=
 =?utf-8?B?Q3ZqR25sRFJVL2d5bTFIUjNhWUdLeEFwVTVSYU9od0oreHk3VEl1ZkQ3TnZ1?=
 =?utf-8?B?bVdHTGJFR2I4ZEVHZVZoODhqRmoxaW9IZUFkWElmNytnTk1LaGQ0UGJZbDhs?=
 =?utf-8?B?SHBhOWx0TlgxWURqeGlwY1doVDZWd2tUL1Erd1lEZXR1ODdhbE9xNFFXT0pF?=
 =?utf-8?B?U1VBOUJWemgzWEVUU2FlYkxsaXNrZUdKWTJDMG5ZT1NBWEpKSTVoRVFxdWhj?=
 =?utf-8?B?NDNVRFY0VWJXajluRVUyWFJ6RjZpTFIxWXhqUHNyMnpqWGtmNnRyM0dQNUNJ?=
 =?utf-8?B?elFrUENCcm1OSGpnL0lLN2tqT3hMcTNKdTY1TWRvdWdXbTI3WHk3clRFVURB?=
 =?utf-8?B?L2R2UE1hbXpBZ1NTUDR1K3BPK21mTlVGWkhDUnJCRVB5RWtTNk1EYXoxcmI5?=
 =?utf-8?B?VVh6M0JPbWVlYWRSM1FSOWU0Q3plVFNzM21iZzJ0MmZ5REUrSTRsbWM0djN4?=
 =?utf-8?B?UEM1REJSZGluUGZuR1FiZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzlJdy8xYUdJUlJvMXIxUG5jSFBUZjhvSzk5OWZBaEdhSUZkODJ2MmNQSjNo?=
 =?utf-8?B?YXhwME1EZEFvdFIyOU00ZUdQUVFxb282WlU1bC8zYk9PR1dNek10akVIWTFt?=
 =?utf-8?B?RTJ4SGRDMFBzN25ycm5kMzFLbjgxbFdXNkV3cTZMVUdNeXdyODUvSnFaTWsr?=
 =?utf-8?B?MkhPMHAyaWx5bEVlSzgwZjR3UWFxSDJQZkY2Z0VpVG9MYy9ZRzUrK0dpWEdU?=
 =?utf-8?B?b2hZY2Y2bG9FMjgxclpkR2lWZExsWFViMFJYMjU0cDhoNjdFT252czJBT1lJ?=
 =?utf-8?B?R1hoZmpNemYxL2VmSjl0b29JTjVua3hER2hyZFdpMThwL1JnVEtBRjQ1YnB6?=
 =?utf-8?B?R0FqU0JVQ2x0RlppdDBsQ1VvQ0gvMzAwU3NBZnNzK1hiSWFDYkQwNm9DOEVk?=
 =?utf-8?B?ZTQyUmpERHQ2UXg1dFZ5U3NlbEVwazNzSmk2UGt2MGJFRXYxS2VLWGFSK1pQ?=
 =?utf-8?B?Q1AzMHFRTlJTLzJQM29PUzZVcTBqUGplR2lpSkFhTnlJdlVvcDlJVWZIQ25R?=
 =?utf-8?B?Y2pjM3h2ek5Jd1ZVWTNRZEJSYnEya0FNZG5CM2lTOGNvL1ZNN3VPUkV4a1F0?=
 =?utf-8?B?bTU5Sk0yYzZZYWljemtUbzFvalE1ekhoOHp6ZUNWaEZDdEZldEorUkZPRTBZ?=
 =?utf-8?B?emUwU0lPYWdKOFpxa2tTaitHUE1Vb1loQzc1eTJROVRqYUswOHNFK1NncU9o?=
 =?utf-8?B?d2NITkhSR0FXTGRQSFNidmpQRTR4czAveFZobTlDbmNDdUpXV2xGeVJwNitp?=
 =?utf-8?B?RHJhanRYRVMrNHVBM250MnY5d1gvVWRDZHNabkNxbFpGM0FBam82Q3FKRXFT?=
 =?utf-8?B?c0xoZmVtWUZzeG1ZdkgxcC9CWTl0QVpPeDlVbC9FRzdsczNIWVA2NEdDUi9y?=
 =?utf-8?B?RzlRMUY3TXQyZWpYQ3QzczFyTkYvQzJSczdBZUx1WFNYMHgwNVlJbGpXSVl4?=
 =?utf-8?B?ajVaYVpHTWZ3UGZIbG9tSW9hcGFpYTBkdmo0VVh2N0VXOHdaaGJ3ZVNUZlgv?=
 =?utf-8?B?S2RXcGh5NWE0SGNFQnJsSVlGZ3dHVEdOakRQWXhzSjdXakw2S1I4NVczRkE5?=
 =?utf-8?B?V1htZDdWdmczbXozRktveTk2STJONkJuZWVLS3RTVGJvc3E5VmExQkZQTDVK?=
 =?utf-8?B?UXpnVmh4RWpZU3BIaGcwR05ydVorWWsySTZ4T1VqcUU5THlGOTlEWmxMalpx?=
 =?utf-8?B?Y0hicUFoTk8xM0JHZVYvMER6RmtKRGR2cjNnaHdpdnV2THcxVzd2RTJFdXNG?=
 =?utf-8?B?bjNpcU9aV3BLS2NzMXZWcjBhK3l1MlZXVWNxdUhrbmNqRDJpM0QvQUQyaENl?=
 =?utf-8?B?MjB0QmVINlM4MEl6QTNDVDN6UmI1VXphdVlRUHc4M1VxblQ2eERkWjlNeFp6?=
 =?utf-8?B?RkV4VEZHQ0RPbitQb2sxbFlRZTV2eUN4MTExbkNCcVZ2bzdRNVJKcFc3bUtV?=
 =?utf-8?B?ZmV0TXlpVE1NcFNGTGlWK1Y1VTdXTDAwUmlBeCtacjJ2Q3JiOElsRkF0cElJ?=
 =?utf-8?B?eVJPdmVnQzZ1NFNQdG9BNHFieHdXMHE0TWNRdDdhRWdWZVBHcTZiVE5lZUQ3?=
 =?utf-8?B?d2hLcU5vSWZoOERWUEhKcERybis2dmpqM3Rlc2JOV2lGLzRwSktMR21TMFBY?=
 =?utf-8?B?cU9mTXpTUTdhcFZkZndHZFpCdnFKMGg1RTBQQlhoeHNhaldQM2hlWU9adVpt?=
 =?utf-8?B?YkNrNmZQK3BiR2NNTlVPaTM2R0I0Z1R3dG9mT2prK3JqbUUzQks4ajFwbFZz?=
 =?utf-8?B?ZlNNR3JUdXdCMm1qS0pYM2xaTThuUmprRDFYM3NGcVB3eVlrb2JIOTRlUVFl?=
 =?utf-8?B?QmJPZlh6R2ZoS1UwNElBNS9UbmFPQWRrTElHMS9lOGxVT2tSbTFIaEpyQ2U3?=
 =?utf-8?B?dHZGU3hveDREMTVFbWdlUGpVZG0wb0tOaS9TN3QrMHhoZWs1SFJ3a0R0YnZ5?=
 =?utf-8?B?SG42MGY0S3ovYllxcXBrUzd4bWtUNlJqeFllYXY3L040b2YzTU1sVy9maE1P?=
 =?utf-8?B?NHpsZXJLRTQ5Y01TRTdJYUpRM3lhVnArdEIrWWJKd290dFJSK0MrVUU1WGpR?=
 =?utf-8?B?Tm9jSlhWNmtLanZ0WFZxRnptYXpPZk5KZVY1a1dzcW5zbVc1dTlLNU4wWVJV?=
 =?utf-8?B?SjJDQThwNjd6MkRPL0N0NUxvU01nL1crZ3dTejJVSDQxVWV2RDgzeXRKK0g2?=
 =?utf-8?Q?TkLbfubleKUnisWMjl2194c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE7206E687848D459375B80FD9107BE2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186f3082-8130-4d64-3765-08dc83926175
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:50.2894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5A6JQRibUCuaCvsdXAIni/wtgTkAXrEJE0g3Ii/H2cwdkfJNGJKGl8kdYo7N3NCLw3bjWzpRyS09gKq5MwCLWzKnaMt6PKgPiKU/tkIw3XV92y/1FITZWQrFOAUnC39a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClRoaXMgd2lsbCBiZSB1c2VmdWwgZm9yIGRldmljZXMgdGhhdCBzdXBwb3J0IEFU
Uw0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhp
ZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCB8IDEgKw0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9l
eGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQppbmRleCAzNTliY2EyYWUyLi41
NmVmNDg3ODBmIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQorKysgYi9pbmNs
dWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0xNDUsNiArMTQ1LDcgQEAgc3RydWN0IElPTU1VVExCRW50
cnkgew0KICAgICBod2FkZHIgICAgICAgICAgIHRyYW5zbGF0ZWRfYWRkcjsNCiAgICAgaHdhZGRy
ICAgICAgICAgICBhZGRyX21hc2s7ICAvKiAweGZmZiA9IDRrIHRyYW5zbGF0aW9uICovDQogICAg
IElPTU1VQWNjZXNzRmxhZ3MgcGVybTsNCisgICAgdWludDMyX3QgICAgICAgICBwYXNpZDsNCiB9
Ow0KIA0KIC8qDQotLSANCjIuNDUuMQ0K

