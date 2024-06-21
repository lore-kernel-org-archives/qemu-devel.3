Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36DAC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKaSj-0002r9-6v; Fri, 21 Jun 2024 05:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sKaSi-0002qy-0U
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:21:40 -0400
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2405::601]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sKaSf-0005g7-9O
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:21:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5jlXyEvYo9hDsL40nBmosrK3urEFypHXQpp21Sy9jbi824ZFc00dS+N/y4hBC9WvZrZJx8N/HdlznhpEP3gNrDwEAdtR8q1gI4grzUezG01acRIfKEvOO0xIvvSEN7HSQ1AC3qF1hqliK7sYdcaRsSQJEWqVRYMuLEjDEwVRIP9vLw9B89Q/TZ2OI8s0KcXgibU1OIpdkXWQwzQD7c5DYGZCOdGgXcSyNLOC1g0NyaWkUAfLg6TPG6oSwp8jQRKRp7Xje400Tcn/58knXDd0y7O5HdDJnmWLoHGkC9LjyyC6Xqep291UgHQqPeVTNirpKZb/3WE2CpToF1FTCUVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNKI8No9B+mVsqsWDnGm64LlSS2QVQdpgZDOApnar7Q=;
 b=Iy0gyg+dZqqwa3SINeNeIRE+75kHHqzEuoEOmBDlqtbqhAih8/G80RJJ33SdMkJvpjgjOYzMCLhmBVJCwmaWGi+wp3bW1tLFNGQcyMjdrY3q8iLtrkqPkBQ1UdmguVIhJFPIW3Y026jW7y8h77Rl1L1wsGrnD7BIVO9VyDqJ7lDFujKb2G5WYNAAoMzoQukAETdgi1FmUOHIWQMgqpH+zHYu1cJ1QXzlP8stniSy7+q1xeXl4KzXx8SLrMY6aVzwxmpJsm5vgCr1A6E3hFQv05t5xRaF+7XnV3xNUHM0OPkk0zPyqoDz74dgMRtPgVtkHkh3lQngbR5xE/D8TGcQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNKI8No9B+mVsqsWDnGm64LlSS2QVQdpgZDOApnar7Q=;
 b=hhqo3vzw9rO34FtJDtNVC71tYMGayFj7Qa+X3GophKy9KKfAt9Ibu2S+IVAbg6QHqwtoLGa4zv8DfalMArNRoWE1Zn0qNg3a58EE32k1SbLpV6gx4CUivv3cBONL9sPkyAnHWoV4T4LYu23giLS1y8o6YSoQJLFhRd+5YiyGBYE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 09:20:57 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:20:57 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v11 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [PATCH v11 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHat/uAOJPhkM3GuE+d22ucqa0ePbHSjlqA
Date: Fri, 21 Jun 2024 09:20:57 +0000
Message-ID: <BL1PR12MB5849BFAF241DE61E6F166861E7C92@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240606102205.114671-1-Jiqian.Chen@amd.com>
 <20240606102205.114671-3-Jiqian.Chen@amd.com>
In-Reply-To: <20240606102205.114671-3-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.7698.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH7PR12MB7332:EE_
x-ms-office365-filtering-correlation-id: 8572c39c-9796-4c46-f0b6-08dc91d3755c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?ZUlDVU9lZ3Jwa1ZVSkRocHIxYnJjeDMzbmhqTDVTYjdtL1N6ZTR4ei9nZC9Z?=
 =?utf-8?B?MFlLb2hmTlFRTjNBU1JBYXFKUkF3REF5c3JVYmdtWkJFN21CajU2Z091WDdW?=
 =?utf-8?B?Zk0yRG92bDBBQXZHME9Ddm92RWpMVkorOUNJRml6R1FKS1FmKytSYm1ndFQz?=
 =?utf-8?B?SnF1elE2SWI5cEpNYjA3Zk1iT3ZSNVpiaGpycUIzaWxLVjBVd1RRWm13TEtm?=
 =?utf-8?B?anJnSzQ2SllES2gzbm1wNXI4TGs0Q0F3OElHV2VTelh0dXAycDJFUW1mSjNq?=
 =?utf-8?B?dW5WOWJpTkJDZnNVM2g5eVFndkFZT0hIRCtZb0xhczdtUUZlQldrcy9KdXNp?=
 =?utf-8?B?STE5SjgwcS9zdXQ4TVBSdHZpNS96bUJHWkpJUElKUyttME1sN09yQkZKREZK?=
 =?utf-8?B?ZndPM1UvYUpWcmdLZ3NXbUMvYkF2SEE3cjJ6V1JVRFduNWl4QzVqbFZwWHBT?=
 =?utf-8?B?MFpNQ3ovc21NbXpqQVJML0pGaWNKcnFDcko2RUVaZHRodjJCZkM4KzVnZGw1?=
 =?utf-8?B?Nkg4TEh2dkFFZlBVSWk0Z21SUmJnU0JQRG44K1QxMFRSRTdQRU5sU0xYSXdv?=
 =?utf-8?B?Sk1sblZzc2lkZ2tuOTg4WkhURU9lZ2Yzakc5WVlCd05JL3lVckRRRVdmYkJu?=
 =?utf-8?B?ZlRUWkR6UjZibXRPV2djVlZ0VU5ndi9rNW9aVm5uM2R0UE1hRnZoSGY1OFdN?=
 =?utf-8?B?UDBRTnUvS00zQ3FsSWRxQ0UxTGxDRCtFc1dPTDFMZURBeXllSE5lcEcyMFVZ?=
 =?utf-8?B?TDg2Nkh1Y3BJUnJpajdaU3YyR0gxZFc1ZEltNklSMExuNlNMOFdiZnc1eEsy?=
 =?utf-8?B?dGtLd1dhRmllVlFaQjUzaUZrVmFCQlZWWmhmeXpCL0xZaXZjYkxqd3ZaN00v?=
 =?utf-8?B?MG1TQiswSmg4Z1pOeDdVRDdrOUorNDB4d3cxWlV2VVRMd1RDaiszczQzRVNZ?=
 =?utf-8?B?WExIOHdVU0FZbnFzYmw5d2Q4K09XeURNaVRUc1hPTmlSSFBYaFQreUNRM054?=
 =?utf-8?B?YUNrVDVpTHdlQmp2c3dMcjdnd3QrK2h6WkhiNFpRdWNVcld6b0ExSVJpRlYv?=
 =?utf-8?B?VGp3SGVCS3pJS0h6eUl1eFJ0WUVxeVZNakZ5M25JY2RFTVQvdTBteU8zaHl5?=
 =?utf-8?B?WGFVeVIyQVhBdkkxeHQ5b1JHNTVQN04wQjRYRkRPbDhpOFRpSUhwaWkzZW1I?=
 =?utf-8?B?Ykoya0ZYSHI1QnpsQXRYQ3MySW9FcUZhRlhsTzE1Y3lidHVxL2x4SWR1UllT?=
 =?utf-8?B?azQ4STUwQlFDQXhTRDVsbkluN0FsS01sQzl4bFRvVVBKZGlpU3puWS9sTm9N?=
 =?utf-8?B?TUtkVGI0SnNidUdKVlZBOW9oUnAvUmJRU29nOS90eTFKU1RSMEhBUU5ZOFA2?=
 =?utf-8?B?QUx1OXhxQk0zdTcweTFCdjlrRmRCY2drby8wdGJ0blBSYkxKRHF2QklzQ0xo?=
 =?utf-8?B?WnhBeVh1SVorUG1jZXYwNDhJbjJXVit6V3lyMXNUc3FLSE13OUI5N2ViOFJZ?=
 =?utf-8?B?UFBRZUt5QzczU09jOFBRNngwRHUyUnNJUmM4Tm44Yzc2QVpYTjBwUlc1L3ho?=
 =?utf-8?B?L1VzT0NiRGpMNFFJc3drSDZDcEpHbEQ0ZlJhYmNVam5LWkFON3VXbjFjNXBv?=
 =?utf-8?B?UlZOM3VONDBxd1pDbEFyM0hrd0dVZVl5QUtyQkxSMldDd2JyY3dSelYzVHM1?=
 =?utf-8?B?SWRZNFJGOFBxT0FmeFUvaUgzKzJxMXRWdDZTbXhrM29KMmtEMFRwOWVvN2p6?=
 =?utf-8?B?Y0FFbmhEN24wTVBmaTArMmRpV1k1WUw2OHlJdlo3UjBiejNtMDNLcjVrRzlq?=
 =?utf-8?Q?529CDXuOpZvl5mmSp/FL1jsXzh/f6jpwwPxHQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVVDb0ZzVjREWStGSnRNUXdsSC9sTTRla1lSb2M3d0VxbWVaNnJVOXJSQUN1?=
 =?utf-8?B?MlcvdUczR2QxQWRkVGdBZ2l1Sk55QUxsMnhZWU9zWCtuckZLdkI5ekxOWnZM?=
 =?utf-8?B?SXd6QW9raGVIU2c4RWl5NkhnNzNMRTJuQnJOY2MxL1VkN1ppV1RvUDlPblNV?=
 =?utf-8?B?em5XcDJTS0F2OE5vNlVSRnZiTElIYlVqcWxzdi9qS0FSQzF1dUZCMWdZbm9V?=
 =?utf-8?B?NFFiSkJVTE5lSEtHSVRmSjNVTFVHdmdDQ2hRVm1KWGFNWXZZcEduczV2dDFk?=
 =?utf-8?B?b2VBWTkzVWRZUWlnVmNGbHkzT0JrZkpoS0tHNjJERnVuTXVhNVNxdm1CUkpQ?=
 =?utf-8?B?OTJzZC9EMVdhejVVekhud0ZjdHlGa3ZJZ1RKUlg4U0YwM2FRYWVJSHlNT0tV?=
 =?utf-8?B?YkdTWWxEOVhLbHNlTkhVS2o5a0diZXhITnNmZEkzSXZob0hlOG1PSXlqN0Rn?=
 =?utf-8?B?b0kxUWZ2aHRaVUx4anpjRU9pWEFtdlFFVzJPcWV0UmwwOTBkRFN2WWFDdUsv?=
 =?utf-8?B?bmtCUjFXa2lURHk2ZkFzdU1CdVRBYldGdW0ydk1UbE5iUUdGbThiYWE0Zmdo?=
 =?utf-8?B?aFhHanF0cWhjREo5N0VqU0xuMkpYeG1vbm5vUzJwTmloUUQrS1RtSWhOYzdp?=
 =?utf-8?B?azNOcHkwTHdwYzU0ZWpaWjJqQmkxZU9tZWh5WGJmYkFwR05lS1dHOWx2bXBY?=
 =?utf-8?B?TWJSS1c5cm1BTGc1S1U2N2w4QWFjVnh4dml0TjgrS2ljcHBiYVBmN3JpOFVn?=
 =?utf-8?B?TmFjVUZhNUVhdFc0VjBscU5NajZpdStacUgxK1ViT1JjYWFMcmRpK01sVEpX?=
 =?utf-8?B?VHI2UXZkbXFMK1RIZGtNMTBWR2swa2wzcnEwRzM3QTZSSHVUSWxRbXRhZnU2?=
 =?utf-8?B?bUVJN0xzWWtTMHNYUyt6MEZoM0Y0Yzk0L2RucW15M1JFN2NtWlNESzU3bDJa?=
 =?utf-8?B?MjdlQVBWS1dYR2FjeitrSEdhWjhhcFM3RDhEcE5FR3VMS3g0d1dOa2NlZVNH?=
 =?utf-8?B?UkExVkdpSndGMThWODYvUzJoUFFuQy9JZzFNYnA0cjRWZnF3bHR4NThVVWtU?=
 =?utf-8?B?cWFiU2E4VjAzaFZEbkh4QmdIM3pnRlJHL01sSExYV2hOYVFmRW95VmwxZnl3?=
 =?utf-8?B?YTI1Yis0Yyt5djg5cXNPWm9VeUdDaUN6S1FjMDhtaDUwMU9vdTI4VThMUUJk?=
 =?utf-8?B?bCtudWFvOE5senpWNWwzRUxndnVueUVzVnRUN3RPTnNwTDNjS1RwcGpVRi9m?=
 =?utf-8?B?S3NRaFcxYnlmK2tub01Walc1eTBoaXlra3FyWVZIZjQ4S2lTYTlzQWN4enNi?=
 =?utf-8?B?aEdxaXg1Yldoa0JEa05BQ0xjcjM0bi9yalg4MW9KdnJwQkg4NjZjUFBGUTFT?=
 =?utf-8?B?QktVeVJxRDNSV2s2MUJPZFhUdWtjeGVCT3ovU0FTY0FtRXNoVEtUcCtrZWZq?=
 =?utf-8?B?RjFSRDNuTUN2VHNDdnU4VnFPbkNNaTJxYkJUb0JFQWFpNVBwMGdNRXk3Ym5C?=
 =?utf-8?B?U1ZYbWZTdklWQjBodHROQzVaeEI4L016WW02UkoycEVKT2JHMFJTcGhaMTc4?=
 =?utf-8?B?YjhnaGx2bENMekZIREFmWTNBRVBsNkVHU0JaZENHM1JVYndPS3dRMzdDWjVN?=
 =?utf-8?B?ZGZmUDhJcUxJUWlCOEo5MVArV1poZWpOQlozbkNyVEY0WnpyM2JLd25XR0hk?=
 =?utf-8?B?R1JYbVBibWRTYmpyZG0wdlVPamlkc3Zib2Z5bThJR2V3UERqenRnL2h0Y2ww?=
 =?utf-8?B?Q2JBQzJiTkV2amVrbFlNdXRDWVdWVldJK0xGL3k1SWY5dGVLamY5MnZPVGEw?=
 =?utf-8?B?S0IrakdxZnd4VFdnVmZRdE5JY2plQmpnZkVGWkhJNmY0WFZUa1VxUW93M1FV?=
 =?utf-8?B?QTBmelR2VzJGOGU4dmhNYnBtcmVVMFJPdldHUTVWQlhXZStQd08vMEl1eEFh?=
 =?utf-8?B?dE9pZHNsUVNzY3VhWkh4VlJ5UHZvVjd6TCtSSEY0UEFlUG40a05iZjJSV3Rv?=
 =?utf-8?B?RnNDc0VxRzRqdG03d285VWpoRWFjTjF5NStzaCtCS1VQQ0FmWTduUWdtZUFW?=
 =?utf-8?B?NWFVTmNtSk5NelhZSW1wa3p0cXBHQjVQTTdMTWFCN3UyMU11dmk3a28yTVhT?=
 =?utf-8?Q?NE/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A9D9D9903514A46A4CB0A8075AFBD07@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8572c39c-9796-4c46-f0b6-08dc91d3755c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 09:20:57.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zx0EaVxT4dcqYcJE1PLg265INowrTvTxbgZNvd0gsvzcKNfTjSincjxbB8gRHtQ9ILRDPxvTB9JZPDGli7V6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
Received-SPF: permerror client-ip=2a01:111:f403:2405::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

SGkgTVNULA0KDQpPbiAyMDI0LzYvNiAxODoyMiwgSmlxaWFuIENoZW4gd3JvdGU6DQo+IEluIGN1
cnJlbnQgY29kZSwgd2hlbiBndWVzdCBkb2VzIFMzLCB2aXJ0aW8tZ3B1IGFyZSByZXNldCBkdWUg
dG8gdGhlDQo+IGJpdCBOb19Tb2Z0X1Jlc2V0IGlzIG5vdCBzZXQuIEFmdGVyIHJlc2V0dGluZywg
dGhlIGRpc3BsYXkgcmVzb3VyY2VzDQo+IG9mIHZpcnRpby1ncHUgYXJlIGRlc3Ryb3llZCwgdGhl
biB0aGUgZGlzcGxheSBjYW4ndCBjb21lIGJhY2sgYW5kIG9ubHkNCj4gc2hvdyBibGFuayBhZnRl
ciByZXN1bWluZy4NCj4gDQo+IEltcGxlbWVudCBOb19Tb2Z0X1Jlc2V0IGJpdCBvZiBQQ0lfUE1f
Q1RSTCByZWdpc3RlciwgdGhlbiBndWVzdCBjYW4gY2hlY2sNCj4gdGhpcyBiaXQsIGlmIHRoaXMg
Yml0IGlzIHNldCwgdGhlIGRldmljZXMgcmVzZXR0aW5nIHdpbGwgbm90IGJlIGRvbmUsIGFuZA0K
PiB0aGVuIHRoZSBkaXNwbGF5IGNhbiB3b3JrIGFmdGVyIHJlc3VtaW5nLg0KPiANCj4gTm9fU29m
dF9SZXNldCBiaXQgaXMgaW1wbGVtZW50ZWQgZm9yIGFsbCB2aXJ0aW8gZGV2aWNlcywgYW5kIHdh
cyB0ZXN0ZWQNCj4gb25seSBvbiB2aXJ0aW8tZ3B1IGRldmljZS4gU2V0IGl0IGZhbHNlIGJ5IGRl
ZmF1bHQgZm9yIHNhZmV0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFp
YW4uQ2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gIGh3L2NvcmUvbWFjaGluZS5jICAgICAgICAgICAg
ICB8ICAxICsNCj4gIGh3L3ZpcnRpby92aXJ0aW8tcGNpLmMgICAgICAgICB8IDI5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmgg
fCAgNSArKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYw0KPiBpbmRl
eCA3N2EzNTZmMjMyZjUuLmI2YWY5NGVkY2QwYSAxMDA2NDQNCj4gLS0tIGEvaHcvY29yZS9tYWNo
aW5lLmMNCj4gKysrIGIvaHcvY29yZS9tYWNoaW5lLmMNCj4gQEAgLTM2LDYgKzM2LDcgQEANCj4g
IEdsb2JhbFByb3BlcnR5IGh3X2NvbXBhdF85XzBbXSA9IHsNCj4gICAgICB7ImFybS1jcHUiLCAi
YmFja2NvbXBhdC1jbnRmcnEiLCAidHJ1ZSIgfSwNCj4gICAgICB7InZmaW8tcGNpIiwgInNraXAt
dnNjLWNoZWNrIiwgImZhbHNlIiB9LA0KPiArICAgIHsgInZpcnRpby1wY2kiLCAieC1wY2llLXBt
LW5vLXNvZnQtcmVzZXQiLCAib2ZmIiB9LA0KPiAgfTsNCj4gIGNvbnN0IHNpemVfdCBod19jb21w
YXRfOV8wX2xlbiA9IEdfTl9FTEVNRU5UUyhod19jb21wYXRfOV8wKTsNCj4gIA0KPiBkaWZmIC0t
Z2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMNCj4g
aW5kZXggMWI2M2JjYjNmMTVjLi5jODgxZjg1MzI1M2MgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZpcnRp
by92aXJ0aW8tcGNpLmMNCj4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPiBAQCAtMjIz
MCw2ICsyMjMwLDExIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfcmVhbGl6ZShQQ0lEZXZpY2Ug
KnBjaV9kZXYsIEVycm9yICoqZXJycCkNCj4gICAgICAgICAgICAgIHBjaWVfY2FwX2xua2N0bF9p
bml0KHBjaV9kZXYpOw0KPiAgICAgICAgICB9DQo+ICANCj4gKyAgICAgICAgaWYgKHByb3h5LT5m
bGFncyAmIFZJUlRJT19QQ0lfRkxBR19QTV9OT19TT0ZUX1JFU0VUKSB7DQo+ICsgICAgICAgICAg
ICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+Y29uZmlnICsgcG9zICsgUENJX1BNX0NUUkwsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgUENJX1BNX0NUUkxfTk9fU09GVF9SRVNFVCk7DQo+ICsg
ICAgICAgIH0NCj4gKw0KPiAgICAgICAgICBpZiAocHJveHktPmZsYWdzICYgVklSVElPX1BDSV9G
TEFHX0lOSVRfUE0pIHsNCj4gICAgICAgICAgICAgIC8qIEluaXQgUG93ZXIgTWFuYWdlbWVudCBD
b250cm9sIFJlZ2lzdGVyICovDQo+ICAgICAgICAgICAgICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+
d21hc2sgKyBwb3MgKyBQQ0lfUE1fQ1RSTCwNCj4gQEAgLTIyOTIsMTEgKzIyOTcsMzMgQEAgc3Rh
dGljIHZvaWQgdmlydGlvX3BjaV9yZXNldChEZXZpY2VTdGF0ZSAqcWRldikNCj4gICAgICB9DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyBib29sIHZpcnRpb19wY2lfbm9fc29mdF9yZXNldChQQ0lEZXZp
Y2UgKmRldikNCj4gK3sNCj4gKyAgICB1aW50MTZfdCBwbWNzcjsNCj4gKw0KPiArICAgIGlmICgh
cGNpX2lzX2V4cHJlc3MoZGV2KSB8fCAhZGV2LT5leHAucG1fY2FwKSB7DQo+ICsgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBwbWNzciA9IHBjaV9nZXRfd29yZChk
ZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBtX2NhcCArIFBDSV9QTV9DVFJMKTsNCj4gKw0KPiArICAg
IC8qDQo+ICsgICAgICogV2hlbiBOb19Tb2Z0X1Jlc2V0IGJpdCBpcyBzZXQgYW5kIHRoZSBkZXZp
Y2UNCj4gKyAgICAgKiBpcyBpbiBEM2hvdCBzdGF0ZSwgZG9uJ3QgcmVzZXQgZGV2aWNlDQo+ICsg
ICAgICovDQo+ICsgICAgcmV0dXJuIChwbWNzciAmIFBDSV9QTV9DVFJMX05PX1NPRlRfUkVTRVQp
ICYmDQo+ICsgICAgICAgICAgIChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRFX01BU0spID09IDM7
DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfYnVzX3Jlc2V0X2hvbGQoT2Jq
ZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQ0KPiAgew0KPiAgICAgIFBDSURldmljZSAqZGV2ID0g
UENJX0RFVklDRShvYmopOw0KPiAgICAgIERldmljZVN0YXRlICpxZGV2ID0gREVWSUNFKG9iaik7
DQo+ICANCj4gKyAgICBpZiAodmlydGlvX3BjaV9ub19zb2Z0X3Jlc2V0KGRldikpIHsNCj4gKyAg
ICAgICAgcmV0dXJuOw0KPiArICAgIH0NCj4gKw0KPiAgICAgIHZpcnRpb19wY2lfcmVzZXQocWRl
dik7DQo+ICANCj4gICAgICBpZiAocGNpX2lzX2V4cHJlc3MoZGV2KSkgew0KPiBAQCAtMjMzNiw2
ICsyMzYzLDggQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19wY2lfcHJvcGVydGllc1tdID0gew0K
PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9MTktDVExfQklULCB0
cnVlKSwNCj4gICAgICBERUZJTkVfUFJPUF9CSVQoIngtcGNpZS1wbS1pbml0IiwgVmlydElPUENJ
UHJveHksIGZsYWdzLA0KPiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5J
VF9QTV9CSVQsIHRydWUpLA0KPiArICAgIERFRklORV9QUk9QX0JJVCgieC1wY2llLXBtLW5vLXNv
ZnQtcmVzZXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+ICsgICAgICAgICAgICAgICAgICAg
IFZJUlRJT19QQ0lfRkxBR19QTV9OT19TT0ZUX1JFU0VUX0JJVCwgZmFsc2UpLA0KPiAgICAgIERF
RklORV9QUk9QX0JJVCgieC1wY2llLWZsci1pbml0IiwgVmlydElPUENJUHJveHksIGZsYWdzLA0K
PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9GTFJfQklULCB0cnVl
KSwNCj4gICAgICBERUZJTkVfUFJPUF9CSVQoImFlciIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaCBiL2luY2x1ZGUv
aHcvdmlydGlvL3ZpcnRpby1wY2kuaA0KPiBpbmRleCA1OWQ4ODAxOGMxNmEuLjllNjdiYTM4Yzc0
OCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oDQo+ICsrKyBi
L2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaA0KPiBAQCAtNDMsNiArNDMsNyBAQCBlbnVt
IHsNCj4gICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9GTFJfQklULA0KPiAgICAgIFZJUlRJT19Q
Q0lfRkxBR19BRVJfQklULA0KPiAgICAgIFZJUlRJT19QQ0lfRkxBR19BVFNfUEFHRV9BTElHTkVE
X0JJVCwNCj4gKyAgICBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVF9CSVQsDQo+ICB9
Ow0KPiAgDQo+ICAvKiBOZWVkIHRvIGFjdGl2YXRlIHdvcmstYXJvdW5kcyBmb3IgYnVnZ3kgZ3Vl
c3RzIGF0IHZtc3RhdGUgbG9hZC4gKi8NCj4gQEAgLTc5LDYgKzgwLDEwIEBAIGVudW0gew0KPiAg
LyogSW5pdCBQb3dlciBNYW5hZ2VtZW50ICovDQo+ICAjZGVmaW5lIFZJUlRJT19QQ0lfRkxBR19J
TklUX1BNICgxIDw8IFZJUlRJT19QQ0lfRkxBR19JTklUX1BNX0JJVCkNCj4gIA0KPiArLyogSW5p
dCBUaGUgTm9fU29mdF9SZXNldCBiaXQgb2YgUG93ZXIgTWFuYWdlbWVudCAqLw0KPiArI2RlZmlu
ZSBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVCBcDQo+ICsgICgxIDw8IFZJUlRJT19Q
Q0lfRkxBR19QTV9OT19TT0ZUX1JFU0VUX0JJVCkNCj4gKw0KPiAgLyogSW5pdCBGdW5jdGlvbiBM
ZXZlbCBSZXNldCBjYXBhYmlsaXR5ICovDQo+ICAjZGVmaW5lIFZJUlRJT19QQ0lfRkxBR19JTklU
X0ZMUiAoMSA8PCBWSVJUSU9fUENJX0ZMQUdfSU5JVF9GTFJfQklUKQ0KPiAgDQpJIGhhdmUgYWRk
ZWQgY29tcGF0aWJpbGl0eSBmb3Igb2xkIG1hY2hpbmUuDQpEbyB5b3UgaGF2ZSBhbnkgb3RoZXIg
Y29uY2VybnMgYWJvdXQgdGhpcyBwYXRjaD8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4g
Q2hlbi4NCg==

