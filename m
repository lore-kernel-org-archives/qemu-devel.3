Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7237FC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 02:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOTSU-0000Vx-RZ; Mon, 01 Jul 2024 22:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sOTST-0000Um-Kk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 22:41:29 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com
 ([40.107.244.54] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sOTSM-0001cZ-VT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 22:41:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9SF/DupDk2A+9XlC8vFBrmwsNS8B+rQBmHKZ7e+jWaTM397fkxEWAox5nxu1FbvGVb2p9ba9UCzbrpcriBZktM+0zYlA1MRlpot4ikHK8AexQccGDZ53UNlO2VSly0hbtUpJp3ho6XgUjd4dSxooN+lIk0NGv9pzHy7gSDpAjB9AEkp5XE/0ykhLTsNW6xNXhQli2CW+OXxrNPPyM9VhrWMETJ4TklnyjUsphR1/FCUmWEQW/zOFx2Cb/sURRyoHzvcAlNTMrt9npDI+kGPpJBMgwuCYynRb//mNSeZ+VXC/FpQmtswqKeX3dJTLu+zU/9Qs1FnQvq45y6YhoF3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD+ANfX+MOkL52SiQX5h20CPIEksl97cOCu7tfA2kOM=;
 b=b9RaZdbcH7q4Dwvc3zS47VraZVufRqQfuEo59RgSzZvxVTK8CAYJB5BVyCXgAzfWyE9OquMKmA9YRoqzK59f8UdJVB11wyH9eShBC8fpb4QgqCwC3nRcCtSlT+7w8RdC5RisEgdb+OG6h7u7/t5U+7cvMJnx3GaRv0/WlDo9zslquNTxXkyxLCqWCC46YWFtXukxmeYrE5ON9XjxRbWbq/Clh3WdGfoCnjaONZbp2AjC7SHu90QutDU4z4hCK1xzojE6iMa58x3d+3OX9zM90U8qv2IsnJO5Vaf+67X6NOW+mKea/eMZPBciFnhJ53s9AgZwQ2eM5vuJVN7lIjh42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD+ANfX+MOkL52SiQX5h20CPIEksl97cOCu7tfA2kOM=;
 b=aiq3PdKFbQhl1Pd0wpPpmZ+YGeXyCkr9OVNFWQvGuLP8+18HN7/Y/XOyL4NZFb80wq6dCcFT5l4qqvdCtqLcNW9rNBEQSajDO9K+QBq9wDGxDXMDEYECsKTQQUCkkAg+Jba6uvbELAtqMUxDeCskPQtyjURQ6DxVWY+YzN13VYE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 02:36:14 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%3]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 02:36:14 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v11 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [PATCH v11 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHat/uAOJPhkM3GuE+d22ucqa0ePbHSjlqAgBDYcYA=
Date: Tue, 2 Jul 2024 02:36:14 +0000
Message-ID: <BL1PR12MB5849B84143E04A429E23AB81E7DC2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240606102205.114671-1-Jiqian.Chen@amd.com>
 <20240606102205.114671-3-Jiqian.Chen@amd.com>
 <BL1PR12MB5849BFAF241DE61E6F166861E7C92@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849BFAF241DE61E6F166861E7C92@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.7719.007)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CY5PR12MB6648:EE_
x-ms-office365-filtering-correlation-id: 57f79332-4184-4430-2c58-08dc9a3fbe6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ekpkVkN2RE9WdzlvK05jcE1uLytINFduaXhySXh2Z3VzdFJtUVU3dGNacGRn?=
 =?utf-8?B?V3NGNGJaa3pJNzA4eXBUaVF1OHp1bkZkRGx5OXRlamNEeURmS3Zuc2pFbHQ0?=
 =?utf-8?B?bnVkQXBqVnlGQW41TE5hY2M3YTg1Z3RxODZZMmhyL2VqbXhnRVpEQXc4NURu?=
 =?utf-8?B?Z3pTakdNWE5oaEZiWTZQejVFcEFrS2pVVFZwZWJLZ1Q4cFFhL0FSZ1BkWm1Y?=
 =?utf-8?B?aCtyd1l0TUlYSURSU3NCWUNzcjZuR2VWeGFPejJtRlBaUlhZTHdpajV2ZVhm?=
 =?utf-8?B?dHZCWmIweVREa3NrYkJma0tFSUpHZWwxeGVqOFRsaFRRRHl4aTEyWjM1VnhB?=
 =?utf-8?B?aDJDbjBvM2Y5R0NwN0I0N2tISTZySDR6M1ZyRm5BMG5WT1lLWnBHajdxamJz?=
 =?utf-8?B?RExWcUVOc2hKeWZsL0dIcHE3NGxIbjhHMC9MVjZFY0w2QllZZXBkd0JPQkpl?=
 =?utf-8?B?K1lFcEl5VzlyVWZrTnN4TUJ2SHU5M2psSUw5b1o4WENPWTdqb3FZeDU0NlNh?=
 =?utf-8?B?K25zclpod0ZtS0xLRi9hMngyVmpacEpaZlFNMDg4ZnZvZFAzcHNuSzhtbVNu?=
 =?utf-8?B?QXpCTG55b3B3eExXVzh4NEdWRjhyRVNwdVp6WExTWTRGaURZMmoxZzlLQzln?=
 =?utf-8?B?NG9QN1ZNdVhZbEJrWVJSNXl3a3dHSmhubGV3dUR6UmM5VVBVdmJvQjN5OXhV?=
 =?utf-8?B?ejB2WkFleXNRbmMvRU9ka081WjhHS09qdVFFUnNZV3hVWkxDQ0pReVJRank4?=
 =?utf-8?B?Wm1ZZTFENFBkRkcxVG02Zm1oWS9oVEowajQ2ZEVJa1NvbzhFOFNhdlpNTnhM?=
 =?utf-8?B?Tys2SlQ4LzBWNXpzSVdVVVFBQUFGZVlyWWRRV3BzNFo4RW5DVWxYRXNvU20v?=
 =?utf-8?B?TTMrU29ES0djVnBCKytveEtzaTJHK0JhbDFCNmcybDI4d0IzenQzMFE3a05N?=
 =?utf-8?B?TEI0dkEvMTRZLy9aUjVWNXdCbkxkU2V0dG05a1ZFaDZFTnBNOW51ZDgyUnBQ?=
 =?utf-8?B?R0ZEWnZoYnVZZ2FSUU93K1hTNTBVdXpuN3JJdHVnL3pDa2wzeDdnSXdwLzNE?=
 =?utf-8?B?RWFlMkc2MEhQcG1JSytWbDVqRU1iRkxBaUNudDUzaFgrSkVCUTNiSzNHYjlG?=
 =?utf-8?B?cnZzanBoNlVlK1BVUjFISy9yaVpUQ1pFekxqWUN6UmZhVEtpaEplZmdQbXlw?=
 =?utf-8?B?WWdlNVNCMklqMWpHNUNlKy9NRzFPaElPaWRhYThLdGZmTHh3NkNuWnF6S1NF?=
 =?utf-8?B?NXE1bEhrc0EveVlxcHZoV3pyVysyZXlBUGZhQnpjeXY1aFAzZVY5N1d2aC9S?=
 =?utf-8?B?RWNqK01ZUWdibkRRK3BZL1Q3QUNOT3pSV2ZKMGwvTmFiTzFmbGxjdzhLd3Nn?=
 =?utf-8?B?eVlLNEhFcnY4RWRoTzA5N253OUpvOW0zSk41aWlJVlAvUE9PWEZqMFhaNmF5?=
 =?utf-8?B?VVcvUCsweWV0RkhhcGlvTXAvR1FSZXdVQWEweEdERytvZmFuNmVwZFpMSmFp?=
 =?utf-8?B?Z0dtY2luV0FxbDl0MTd0Rks3U3BlYkhZWERlVmJPVGtEWXpacTBtMmRtZlBr?=
 =?utf-8?B?QUVtaE5FWXArSkoxVExsNm5DSVI5c3paZktId2dMNDlnNEtod050TTNMaUxW?=
 =?utf-8?B?azdVSHF3WUM0OUg4bTdiV2ZUc3hINklTaG5YUUE5NXBheDlsNmZRMWg1VGRh?=
 =?utf-8?B?ZGlxN1NiaWdUQWQ2SUoyRmQ0SFp2ZFh3dUFOc1lueHBpUjNrRVRKMDRkQm5Y?=
 =?utf-8?B?UVE5Y3RaUWx4Z2w3RFQzNytZQll6cXVRc1k4dTJFcU1nLzIvWmRlbytmMWg5?=
 =?utf-8?B?d2YzVnlyeEpuMzNGcmM4RXZjd0UwWE5yRWRydFJLSFNNRUN6UzZNcEVCVTNt?=
 =?utf-8?B?T1lBVXFIa0V3WnlsMWRjSWZxVlFqMndUWmFDNVZ2Q0hmdHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFdYdUlNaDZvc2VSSUNKWE5JeldaN25nNXBCcUdab0oyVzZ5cGFjclY2UEw5?=
 =?utf-8?B?MGIwdVJhTTZHdlA3UkloSE5DRngrQmtYdnJ1bkVzbnI1eTlQUHRzaitIdUVy?=
 =?utf-8?B?NUtQaGZtd0JUTGRydEE3TWZ0Y3BSTVVqY1dESWM4SGFORlhXUHVndFdwakdF?=
 =?utf-8?B?SC9rcGRLdWxWWTlvK3ZFZDdvd1VrMmxNN3MzdzUzNE5FUWJieDBBb0ZDY1VJ?=
 =?utf-8?B?cEhFOG4vdENRcEp4QVI1ZCswK2ZZc1pSM1Q0YmJsMlBNRUtNL3kwNENzWHp3?=
 =?utf-8?B?d1UxajFUeGloS0NpTzAwMnUyU1dQbWt2bFp6dFFOTTJKRS9Ca044dlpKeDNT?=
 =?utf-8?B?OTg2eEI4dW82MEFmbjMveW1XMEdmVHRzQ1lyaUNqb1huRUtXTVlSaFNjc2Jx?=
 =?utf-8?B?N0hFemZSSit4OU5WeGk4U3Y5bVpVcjZPYUpLaWE1K25UZkF0NllJblVRTDcr?=
 =?utf-8?B?ZlBDUmw2NUFacWpsbHQ0eStSRmlhdHZDQWdyQnVKc2JxbGVEcWo4Slc5dWdJ?=
 =?utf-8?B?ZExMQ0JscTkvbmZPN0FUUXFiME9WbmZDeXl4RU5RZ1B4b1ZacjZQYlE0SnZl?=
 =?utf-8?B?WGJLbmxaUUIxcmh5VVk3MGN3djRkUHFlVFMvT1EzUTduUEFCeHlDeWpMMC9x?=
 =?utf-8?B?RGVBbjcrb2tpSkduZm5hVGs5S0s1T05ETWtVOGVzN0NpTTdTZjhRaFd5WHA4?=
 =?utf-8?B?N2JzTEtJc0d5OXc1L09LNU13QTI4Nnd0QjVSTjd4L3lGanFJMGt5VWpGZlpp?=
 =?utf-8?B?ZmFqRlRRVzAvYTk2aTNWaXJpc0tSelVaek03SWppZXFQSHBaL2RlejQzenRK?=
 =?utf-8?B?WkZmdWorQ283YUxsNEZicTZqd2VQVzQ1L0o1eVdOcTYyQ1JlUlh1VHVmMEo2?=
 =?utf-8?B?bWJROEpSbHlPNTZDa0Vkc24zQmZjcSt3T1c4cENLclpNc2xRUWlxanNwU3Vh?=
 =?utf-8?B?YXl6YlhFSGpQS2o3aEprRXBjU2tZQk1FL2JnSXVhUUd0Rk9URkxmYnl4R2JS?=
 =?utf-8?B?NEJ3UythcXkwaXRBZ3FrVGhEUUUzbWNsR05kdXJIVXlsSmFUcVNNWGJJV1li?=
 =?utf-8?B?R0ZGdjlXeDdDSExlUTNuZUpGcVhuOENSRCtBdjdmYkVZTDZFRG9QRU5Waks5?=
 =?utf-8?B?NlprTnFiajFGaXhzcVNPVVh3MU81dlJDVlZTOVJ2KzNIbE9HczZPTmp0WGZn?=
 =?utf-8?B?YlZIcE9NU1JOTitNWjh6QXVTeFYxT3Nia1FCTlkvWi9vckF0bXZ4bkpUVzJ5?=
 =?utf-8?B?NURKSE9wUVhGZVZJaStyYkgxZndYSmJZMnkwNlF4NDA4dElYS1Y2c3h2TWly?=
 =?utf-8?B?RFE0dUpaRWgxdkpmb0tFSkJKRjV4YVVkRDAwYkYwUmxGT1J6b2ZkeUJTd0gy?=
 =?utf-8?B?UVc2U1J6UEN5cHZWcVBzS24zWW1CSjlmQ0dCSHF4am9LRFk1Q0NDSmxJVThU?=
 =?utf-8?B?L0pSenkvVnRRRFl6ejBkV3JDUEdtZjNMNHZDTC9Ta0I4NGZUUXVGZWxDSWEz?=
 =?utf-8?B?R0ovQ204UHllRjFXelB5SVp4RDVMNkxtN0tyZ2h3cTF0eVlVYndtVzBneGJJ?=
 =?utf-8?B?Sy9NVFJVRWZjemp0UzNuY0ltUVFoUFlCa0Rsa3ZiTHVUQ3FjOS9ldjk1T2Nl?=
 =?utf-8?B?dngwUy96NkdPQWZRSGVZSnhGakFjUitZdjJ2cUl6dWFQU1MvOFl3dENYbFVS?=
 =?utf-8?B?OEFSOFBvcVdtVDhHVi9MSktRZlJwQlNCeEZqL2czNDFUZlE0MWE1TXp5Qk5o?=
 =?utf-8?B?UVFJaGR1R3FNRXJTbGZ2V3JYdTk3b1VydTU1VlVnQkJ5dEQ0M01Zd1R2TkhG?=
 =?utf-8?B?bHFYc1BRS1BobUtkeDVKSWlFd2dHVCtOZlNOam1jM3h5L2pDQ0RaVUVhL1ox?=
 =?utf-8?B?VW5laDcrL1I5TXU4SEtKN0xzQ0dMTk9UZHhLTmZ5Y1hya1ZwSkdGTGZVV3RK?=
 =?utf-8?B?V3locFpkUEpJYWxJQmI3WFREbHJhRnI2UkU2RVJQWVdvSEVGdEdORHQ3NjNw?=
 =?utf-8?B?MjNialRXaEc4RmRIbGJ3d2lwVGtjbHM4STE1WGQ2ZXZIa0FUaWd1K0FmZzZK?=
 =?utf-8?B?QnJvNFhFTjMxRkhpWmpvYitUYkhyNW42bGRqaldQQUNvWklCZm91OUgyS3Jl?=
 =?utf-8?Q?WsGo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64FA64B9D8EA0F4CAB051D8835E07FB9@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f79332-4184-4430-2c58-08dc9a3fbe6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 02:36:14.7989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DINBAHVp9QR2kKQgDB+nP9qK6JLlWQ609QdpBSsQVJOyX+535vTDcf8JNVYoO2z5MQXRfAbutoOAVRAAxeRJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
Received-SPF: permerror client-ip=40.107.244.54;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

T24gMjAyNC82LzIxIDE3OjIwLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+IEhpIE1TVCwNCj4gDQo+
IE9uIDIwMjQvNi82IDE4OjIyLCBKaXFpYW4gQ2hlbiB3cm90ZToNCj4+IEluIGN1cnJlbnQgY29k
ZSwgd2hlbiBndWVzdCBkb2VzIFMzLCB2aXJ0aW8tZ3B1IGFyZSByZXNldCBkdWUgdG8gdGhlDQo+
PiBiaXQgTm9fU29mdF9SZXNldCBpcyBub3Qgc2V0LiBBZnRlciByZXNldHRpbmcsIHRoZSBkaXNw
bGF5IHJlc291cmNlcw0KPj4gb2YgdmlydGlvLWdwdSBhcmUgZGVzdHJveWVkLCB0aGVuIHRoZSBk
aXNwbGF5IGNhbid0IGNvbWUgYmFjayBhbmQgb25seQ0KPj4gc2hvdyBibGFuayBhZnRlciByZXN1
bWluZy4NCj4+DQo+PiBJbXBsZW1lbnQgTm9fU29mdF9SZXNldCBiaXQgb2YgUENJX1BNX0NUUkwg
cmVnaXN0ZXIsIHRoZW4gZ3Vlc3QgY2FuIGNoZWNrDQo+PiB0aGlzIGJpdCwgaWYgdGhpcyBiaXQg
aXMgc2V0LCB0aGUgZGV2aWNlcyByZXNldHRpbmcgd2lsbCBub3QgYmUgZG9uZSwgYW5kDQo+PiB0
aGVuIHRoZSBkaXNwbGF5IGNhbiB3b3JrIGFmdGVyIHJlc3VtaW5nLg0KPj4NCj4+IE5vX1NvZnRf
UmVzZXQgYml0IGlzIGltcGxlbWVudGVkIGZvciBhbGwgdmlydGlvIGRldmljZXMsIGFuZCB3YXMg
dGVzdGVkDQo+PiBvbmx5IG9uIHZpcnRpby1ncHUgZGV2aWNlLiBTZXQgaXQgZmFsc2UgYnkgZGVm
YXVsdCBmb3Igc2FmZXR5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFp
YW4uQ2hlbkBhbWQuY29tPg0KPj4gLS0tDQo+PiAgaHcvY29yZS9tYWNoaW5lLmMgICAgICAgICAg
ICAgIHwgIDEgKw0KPj4gIGh3L3ZpcnRpby92aXJ0aW8tcGNpLmMgICAgICAgICB8IDI5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBj
aS5oIHwgIDUgKysrKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYw0K
Pj4gaW5kZXggNzdhMzU2ZjIzMmY1Li5iNmFmOTRlZGNkMGEgMTAwNjQ0DQo+PiAtLS0gYS9ody9j
b3JlL21hY2hpbmUuYw0KPj4gKysrIGIvaHcvY29yZS9tYWNoaW5lLmMNCj4+IEBAIC0zNiw2ICsz
Niw3IEBADQo+PiAgR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0XzlfMFtdID0gew0KPj4gICAgICB7
ImFybS1jcHUiLCAiYmFja2NvbXBhdC1jbnRmcnEiLCAidHJ1ZSIgfSwNCj4+ICAgICAgeyJ2Zmlv
LXBjaSIsICJza2lwLXZzYy1jaGVjayIsICJmYWxzZSIgfSwNCj4+ICsgICAgeyAidmlydGlvLXBj
aSIsICJ4LXBjaWUtcG0tbm8tc29mdC1yZXNldCIsICJvZmYiIH0sDQo+PiAgfTsNCj4+ICBjb25z
dCBzaXplX3QgaHdfY29tcGF0XzlfMF9sZW4gPSBHX05fRUxFTUVOVFMoaHdfY29tcGF0XzlfMCk7
DQo+PiAgDQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRp
by92aXJ0aW8tcGNpLmMNCj4+IGluZGV4IDFiNjNiY2IzZjE1Yy4uYzg4MWY4NTMyNTNjIDEwMDY0
NA0KPj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPj4gKysrIGIvaHcvdmlydGlvL3Zp
cnRpby1wY2kuYw0KPj4gQEAgLTIyMzAsNiArMjIzMCwxMSBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9f
cGNpX3JlYWxpemUoUENJRGV2aWNlICpwY2lfZGV2LCBFcnJvciAqKmVycnApDQo+PiAgICAgICAg
ICAgICAgcGNpZV9jYXBfbG5rY3RsX2luaXQocGNpX2Rldik7DQo+PiAgICAgICAgICB9DQo+PiAg
DQo+PiArICAgICAgICBpZiAocHJveHktPmZsYWdzICYgVklSVElPX1BDSV9GTEFHX1BNX05PX1NP
RlRfUkVTRVQpIHsNCj4+ICsgICAgICAgICAgICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+Y29uZmln
ICsgcG9zICsgUENJX1BNX0NUUkwsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIFBDSV9Q
TV9DVFJMX05PX1NPRlRfUkVTRVQpOw0KPj4gKyAgICAgICAgfQ0KPj4gKw0KPj4gICAgICAgICAg
aWYgKHByb3h5LT5mbGFncyAmIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNKSB7DQo+PiAgICAgICAg
ICAgICAgLyogSW5pdCBQb3dlciBNYW5hZ2VtZW50IENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4+ICAg
ICAgICAgICAgICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+d21hc2sgKyBwb3MgKyBQQ0lfUE1fQ1RS
TCwNCj4+IEBAIC0yMjkyLDExICsyMjk3LDMzIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfcmVz
ZXQoRGV2aWNlU3RhdGUgKnFkZXYpDQo+PiAgICAgIH0NCj4+ICB9DQo+PiAgDQo+PiArc3RhdGlj
IGJvb2wgdmlydGlvX3BjaV9ub19zb2Z0X3Jlc2V0KFBDSURldmljZSAqZGV2KQ0KPj4gK3sNCj4+
ICsgICAgdWludDE2X3QgcG1jc3I7DQo+PiArDQo+PiArICAgIGlmICghcGNpX2lzX2V4cHJlc3Mo
ZGV2KSB8fCAhZGV2LT5leHAucG1fY2FwKSB7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+
PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcG1jc3IgPSBwY2lfZ2V0X3dvcmQoZGV2LT5jb25maWcg
KyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCk7DQo+PiArDQo+PiArICAgIC8qDQo+PiAr
ICAgICAqIFdoZW4gTm9fU29mdF9SZXNldCBiaXQgaXMgc2V0IGFuZCB0aGUgZGV2aWNlDQo+PiAr
ICAgICAqIGlzIGluIEQzaG90IHN0YXRlLCBkb24ndCByZXNldCBkZXZpY2UNCj4+ICsgICAgICov
DQo+PiArICAgIHJldHVybiAocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSAmJg0K
Pj4gKyAgICAgICAgICAgKHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSykgPT0gMzsNCj4+
ICt9DQo+PiArDQo+PiAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9idXNfcmVzZXRfaG9sZChPYmpl
Y3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpDQo+PiAgew0KPj4gICAgICBQQ0lEZXZpY2UgKmRldiA9
IFBDSV9ERVZJQ0Uob2JqKTsNCj4+ICAgICAgRGV2aWNlU3RhdGUgKnFkZXYgPSBERVZJQ0Uob2Jq
KTsNCj4+ICANCj4+ICsgICAgaWYgKHZpcnRpb19wY2lfbm9fc29mdF9yZXNldChkZXYpKSB7DQo+
PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgICAgdmlydGlvX3BjaV9y
ZXNldChxZGV2KTsNCj4+ICANCj4+ICAgICAgaWYgKHBjaV9pc19leHByZXNzKGRldikpIHsNCj4+
IEBAIC0yMzM2LDYgKzIzNjMsOCBAQCBzdGF0aWMgUHJvcGVydHkgdmlydGlvX3BjaV9wcm9wZXJ0
aWVzW10gPSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9M
TktDVExfQklULCB0cnVlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtcG0taW5p
dCIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywNCj4+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJ
T19QQ0lfRkxBR19JTklUX1BNX0JJVCwgdHJ1ZSksDQo+PiArICAgIERFRklORV9QUk9QX0JJVCgi
eC1wY2llLXBtLW5vLXNvZnQtcmVzZXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiArICAg
ICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVF9CSVQsIGZh
bHNlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtZmxyLWluaXQiLCBWaXJ0SU9Q
Q0lQcm94eSwgZmxhZ3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdf
SU5JVF9GTFJfQklULCB0cnVlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJhZXIiLCBWaXJ0
SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmly
dGlvLXBjaS5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oDQo+PiBpbmRleCA1OWQ4
ODAxOGMxNmEuLjllNjdiYTM4Yzc0OCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlv
L3ZpcnRpby1wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oDQo+
PiBAQCAtNDMsNiArNDMsNyBAQCBlbnVtIHsNCj4+ICAgICAgVklSVElPX1BDSV9GTEFHX0lOSVRf
RkxSX0JJVCwNCj4+ICAgICAgVklSVElPX1BDSV9GTEFHX0FFUl9CSVQsDQo+PiAgICAgIFZJUlRJ
T19QQ0lfRkxBR19BVFNfUEFHRV9BTElHTkVEX0JJVCwNCj4+ICsgICAgVklSVElPX1BDSV9GTEFH
X1BNX05PX1NPRlRfUkVTRVRfQklULA0KPj4gIH07DQo+PiAgDQo+PiAgLyogTmVlZCB0byBhY3Rp
dmF0ZSB3b3JrLWFyb3VuZHMgZm9yIGJ1Z2d5IGd1ZXN0cyBhdCB2bXN0YXRlIGxvYWQuICovDQo+
PiBAQCAtNzksNiArODAsMTAgQEAgZW51bSB7DQo+PiAgLyogSW5pdCBQb3dlciBNYW5hZ2VtZW50
ICovDQo+PiAgI2RlZmluZSBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTSAoMSA8PCBWSVJUSU9fUENJ
X0ZMQUdfSU5JVF9QTV9CSVQpDQo+PiAgDQo+PiArLyogSW5pdCBUaGUgTm9fU29mdF9SZXNldCBi
aXQgb2YgUG93ZXIgTWFuYWdlbWVudCAqLw0KPj4gKyNkZWZpbmUgVklSVElPX1BDSV9GTEFHX1BN
X05PX1NPRlRfUkVTRVQgXA0KPj4gKyAgKDEgPDwgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRf
UkVTRVRfQklUKQ0KPj4gKw0KPj4gIC8qIEluaXQgRnVuY3Rpb24gTGV2ZWwgUmVzZXQgY2FwYWJp
bGl0eSAqLw0KPj4gICNkZWZpbmUgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSICgxIDw8IFZJUlRJ
T19QQ0lfRkxBR19JTklUX0ZMUl9CSVQpDQo+PiAgDQo+IEkgaGF2ZSBhZGRlZCBjb21wYXRpYmls
aXR5IGZvciBvbGQgbWFjaGluZS4NCj4gRG8geW91IGhhdmUgYW55IG90aGVyIGNvbmNlcm5zIGFi
b3V0IHRoaXMgcGF0Y2g/DQo+IA0KSWYgeW91IGRvbid0IGhhdmUgb3RoZXIgY29uY2VybnMuIE1h
eSBJIGdldCB5b3VyIFJldmlldy1ieT8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hl
bi4NCg==

