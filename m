Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5733C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKaVK-0004DA-TL; Fri, 21 Jun 2024 05:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sKaVI-0004Cj-Pc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:24:20 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com
 ([40.107.223.59] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sKaVG-00063b-Jx
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:24:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkABwrOnGekj9+gGLM2pV7sLmkg43fk7YaaJW7EHY+ktpBsF0EpWDfO84moz4SdoCGpTcpTCkFWTBJcDMzaTMpVmu7luc7DYdxlWmx3qsuhrV4bygpd80GBtg1I7QNQGJFLWiO25zg7zXLBBlAwSGfLdgyvljdzFAR74AuOxiGrbpgR7jo4VhCa1ED/6/GcbrPw2b+c1RpzdVH8bmohDPJ1sYBmqLTlSFsw1B7owLOe9YKb4os3Id21aMCQYgnGTVwLDanUXl2he4ufZwXmBjR2g6f5ebvdOG0mxTxBkml9yjaBQVqPxe7oinFln5xyp6Di0ahQJLQ9cDSNuVDuNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwTN6RfQlZdFrACKAeYIptLZOTTWZnHxdVxLsqbQnB4=;
 b=mPFxLCmr9Zk+mDBA4h1UWwwQbhhlQNAigWGAm1V0VzHpgCMFLzmXpXSMswsYoYztROj+Jx/iQQT4jAe8Fr1HAjpMVkct+sMiJ0PWhTe7pdpBrx9BGQWIjskMRyRhp6WdHBtN8kMBU0fcvkpA1/sI4QtN8omKBRBi8+68Hz0yK4kTvUCMRjxpPAhycixEqWIxpB1TaUer8tVKEbCa6eKxDbsfmXnPRjf/t92KdyUUc7WPbQGWT+gFMs91HkyBDizMXVgYVJbnAkeQukyisl1B7g8LNlRIgc+egw/QeGpfP9hBUtT68baxwyLdPcDMjtqmBWyLZMlNaz3wsRGzH6YwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwTN6RfQlZdFrACKAeYIptLZOTTWZnHxdVxLsqbQnB4=;
 b=f33fbV+7hVtLklHnIF43137M4V+AMjSN3aEE25W8PMNDcAoN2BAo42duB8BgxZXC2YWtZT2+N12jNhOU435Kzh3yCoPzxaTwdLjLdvZ21EbW3Xl0vsi74CbcJoZ+wt/Loaaz2HrgFaB/v5IJWUrKPGQHSbYXcmx1ZMwO6yoaOyc=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 09:19:11 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:19:11 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v11 1/2] virtio-pci: only reset pm state during resetting
Thread-Topic: [PATCH v11 1/2] virtio-pci: only reset pm state during resetting
Thread-Index: AQHat/uA61UUI4otcU6F/JE4cAT22bHSjXWA
Date: Fri, 21 Jun 2024 09:19:11 +0000
Message-ID: <BL1PR12MB58491ED83770E67AC98633D7E7C92@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240606102205.114671-1-Jiqian.Chen@amd.com>
 <20240606102205.114671-2-Jiqian.Chen@amd.com>
In-Reply-To: <20240606102205.114671-2-Jiqian.Chen@amd.com>
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
x-ms-office365-filtering-correlation-id: a0d2b217-d41c-46d5-ee3b-08dc91d33662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?SUFBRjdaaFRLUmtTRm9GMGp6VDRvUlNhdnNsWWdVZUNhbEdRVFVMc2dtOUJs?=
 =?utf-8?B?TDlPUjNIS2dzVG9oYnEyLzNNUXRvdTRZTkxSRTZSSHFRZG1FT0NlK1lYR3RO?=
 =?utf-8?B?WWlYQ3hSaUNrblFJdlRFTUlzRDJkU3QyWFJBODhLQkpGeUNXSnV2eVltK0lO?=
 =?utf-8?B?UWQrWFl0Q0xlVUM5dEwrSjdkSjF5bTRHdVV6TENBMVJPOVI0b3NtczlvUGlK?=
 =?utf-8?B?REJTK2R4cThIdWMvbkJPMDZSTGZSV25JMFR6eU93K2lVM0FKbHdHRWNOYVZr?=
 =?utf-8?B?ejNsSDJObmo4aUdXVGcyMGZSTk1MNzhKUEhhQ2JjSHY4dzlYbHBjZUZvbldJ?=
 =?utf-8?B?bXk2QnV2TU51elJXSi9MQURJN0d1SXpLRkpyRUtZS1lMekt2azNNL09tRWkv?=
 =?utf-8?B?QmdWN2hGenplZ3JmUjZUS0hvOFNMeGwwZjljNzJtWGplRkx3Y2JWMlpyYjdX?=
 =?utf-8?B?dFQyakh6UVhHclZ1eUl4Q1ZTNFBvVmZwcEVSWUROK0V1Zmxwd0MxRU1QZlEy?=
 =?utf-8?B?bDFDaFBNYy9ub0NzUmFlcmI0K00vQnlnUVpKRWp0V2dGZGF6N0VaQ01TMkdj?=
 =?utf-8?B?ZUhPNnl0K0U5RlRDcmF0WGRWUUh1UXdpdUdCK0tmcEJ6TmEyRGs1UlBKK0My?=
 =?utf-8?B?YmpydkRDN3RvdVg3V1dGT0M3SmFyT0xFd0E1RzlXSTRsYnltS3NmMkRndTEr?=
 =?utf-8?B?TFF2RHNWaHdJUlJTL1hFRWRWdG5wcmlxM2dFU1pDK0ZrSFlOMUY1cmNoZ3Nx?=
 =?utf-8?B?TVFJUHpTSXNBdFAreVljRzFYVzVrNVBTT1pvREcralNaMUxkeXV1TlRLRjBW?=
 =?utf-8?B?ZnpvMEhRSTZnQjRZQXlIQ0VZWXdlWlJncDUwb0k4L1c2NVo2UkNoQ0pyejNT?=
 =?utf-8?B?ekNjeitwSVZzYjYrOXV6YkFGaDBUdkZpRnYrbWdMMzAwMCtldTVSeVAweGRk?=
 =?utf-8?B?T04zREt6VkU2Q3c3U25jKzBqTjg3SSt2NmpFcWhNQjlQeEFraDFOUFpMelFh?=
 =?utf-8?B?TmFCc2liTzcyRU42dmFoM3BsZEVtaGZVTytyZ3cvUmkwTlJTT09GZDQ3UFUy?=
 =?utf-8?B?YzdTVXQrT0Z2NHdCWHB6QlFhblBWaWtLQUk3aHc2STFjcHRXWW1lM2xTcDVw?=
 =?utf-8?B?MGM4WHhaeStybStWZnZ1MEhIeUd5OUZQWTJNOGlOVG5aVWw3Rm1TUkxQSDRG?=
 =?utf-8?B?c2dKRFQvL1k5b1pDMDNaRXFnTUVYRVV1dWZYRnR4aFFMcWVCVkJCaFBwakN4?=
 =?utf-8?B?V3ZKZ3lZMlBkb1p2QzkrQUFYV1dVL1VHcEFsSVUyRlQrR0hmcmdPTUFkUHhG?=
 =?utf-8?B?SlZqN3BrZHpyLy9ZOUxLcmFWMk9YVFBCR3NkODVqZGJ4elkydXVMMGFOZDhQ?=
 =?utf-8?B?TWFVYVV4V0Q1Y3d3MitaeTNENDJvQXNFckJGUVdyMXkzdnkreW8rM1IrWW9S?=
 =?utf-8?B?b25BVCtDKy9lSHVJMWFJb2xyaitKanVZb1RaYllJNDNnWUl2QXBYaGRRZ0Ji?=
 =?utf-8?B?NHY4RFFOdmxaNEdZS1pqOWFNWjdqZmNzZ1Z2SGlmTzhlTUZ5ekpDTUVBTWVk?=
 =?utf-8?B?SW83c2ZOL3h0S3dWY3dZeXIwTGNlN1FOZndJaUVNQVdsWlVkZEpTcFdWU1kv?=
 =?utf-8?B?a2YvZUFkK0FKR1FSbW84M3AwaGZHWk9BM1VTa2RuT2x6ckJSbDdXVE5LZEVo?=
 =?utf-8?B?YXQrZjN2MzZNRFlyU0sxY25FeVU3ZW54MmF4Ri9kUGNpNU5wd21CV1Bpa1R0?=
 =?utf-8?B?SVIybEJTRVNVZlhRbmNtc1M2ckpMZFVkRjUrK0liV1ozZUlzSE5vYmJ4dWh1?=
 =?utf-8?Q?zbewbE1pLFmYUWOJ2WwPlJ3P5XSbL8ymMtMLo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhOUzI1ekozcFVsamhLdFZNVlZQZWN5MGFjVExQQklWZUNLQWRoVXdzZFJh?=
 =?utf-8?B?cWhYVlphcisvaVhPWCs2WUVYdzJLbklXZE41U3hvcFVjYzJOc0x1S05kelJX?=
 =?utf-8?B?RTk4Szlzc1dBb3ZwSUV1ZVVWTFhHbG1wdjFETnBQQU1BcElncFFMTCtWOFFz?=
 =?utf-8?B?c1dTRFUxdHBzY0lSSjVOUFlQNHNoMXAvcDZDalB2WDhnSnA0MWw4R1hwenY0?=
 =?utf-8?B?Vk1HR0wzYmowalg4MUtaZFo0ZWwxR3VpZSs0dnFjSEY1dU1GeEZ6TjdvSkNG?=
 =?utf-8?B?NnJDMVlEQnhTTkx1NXgyVUcrYkpKTElxOE5TbFBHUEJGTFR4M0FtZ2owTmJw?=
 =?utf-8?B?U2h1dzhPdEhmTjZGNlRlT3ZoOENZMzhzVTBXdC9IWXRHNXR5OUhGOGsrZjdi?=
 =?utf-8?B?MTErQytta2lFeEdvWXd5MmlobEpNM0dkZ1VyMEF5NjU2VGNDRXIzLzFCWUlW?=
 =?utf-8?B?NTN5YXh5cytRUXRmUVJ1QmVkbWF6QVJxYXB2L21ncFE2b1NDUFhpK3FzbE5L?=
 =?utf-8?B?UWFpQ1dud0JuSDI1NERJYmZ0QzJLcGl6TWZ6dmdFTW80YUZrajFaTmRMMlB0?=
 =?utf-8?B?bm1ibEFzdno4d0pCbzVjQWFMYVY4MkNxY05WVjhrZVlJMjZ2K2tjanBNNy9Z?=
 =?utf-8?B?VGJ2Si9nRzA4d3FyVG9vMlpSZFcrc2dHU0h6dEYxa2xXU250N0tKQXZXcXgr?=
 =?utf-8?B?SVl2VHpWVlR0OU8zaFk4QjFLRjd2K0FBMW5Wd01aOHU0NEJGNURYS0pOa082?=
 =?utf-8?B?QmVBbE5sQlMzRzY5WjdwODdWaUxYSXBhZFN4aDZZWG1MNUhlN0VSNlAwZmJs?=
 =?utf-8?B?eEI1bTB2TkYxYktiQnVJcTVBS3MvSWozMTZmbytWK0hicnJkZkFNVVhqajFw?=
 =?utf-8?B?NEVaTHQ3Vm9aUnhSMEVzWENYL2luQjFqejZqV0ZkaDlZYkVKM1FFSWpueS85?=
 =?utf-8?B?WTZ5cmRrQmRZdXhpTGlHT21tUG13bDFpNE1UUjlGOXFRWlYybnM3UGhaOWIx?=
 =?utf-8?B?TFNSekQrYVVlUTllNzl5Slg3WXlqa3lVM2ZUb3JTZ2RzbEdKMVo4cklhL1JJ?=
 =?utf-8?B?aVh0VEQrTW9Sc2dObXNlR0J3QnJ2WkhodTNjKzVaMXNvbnU5YlkwK2dKMU9h?=
 =?utf-8?B?eUV4YnN6azVaQ1hFWVFNcXZTNnhZdFhsbVMxZ0pmZVpFSTNtcFRFSXBUV05a?=
 =?utf-8?B?UC9zSjhhdnpNZE82VHh4aXVqMUVRWWNTMzY2bU8va3pkcjIrU1FBalhPY2pj?=
 =?utf-8?B?MXJPU0RxVVovTFFFWVpHTmVpTmMyeWc2b1FXWE80MnZOTnJYNmNyK1dLTWd6?=
 =?utf-8?B?RlBQcmdHVnRmY0lKT2JoaVIzYlF4MGZvWXNxQkVsTk5iRmVWVU93MXNvZmtB?=
 =?utf-8?B?MTV1N3E5b0VualNqd0t3NVRxd29EYy9iK01jODcwajkzK3ZjMmdoWlJxaXBC?=
 =?utf-8?B?RGRHcFNKVmQzeVVzVXRKUk5PZmIzbjl0RTQ1RjJxeXk3Tm0vamVEbnpDN2k1?=
 =?utf-8?B?OEpwRUcxWHcwL2ZxbDE1Nnh1ME9PR1hhN2xRcFJYTkVlSmZkVUgxOGcxUldm?=
 =?utf-8?B?cTFRNXQxaUs4ZkpPYzZYZmhVNkhzcVRNeDhYVjVCYjBUaU16SGh6Z2l2WjBY?=
 =?utf-8?B?R2hQSUpYbVNENkt4MjFiR2poeGhJK3JacDRjYkhCakVUNWJFbm8wVEsxcGRp?=
 =?utf-8?B?dUtSdVFVa24xclp1cHJZOUwzQWgxRUlabmpSZS9mbkU1Wm9UbVdIc0hNaktu?=
 =?utf-8?B?MmtwZ0R2Smh3cDg2SytnVS9kc2ZVb2hjejNlOFVTQmk3Q3owZ25xYW81WFVC?=
 =?utf-8?B?RW9FMU9jQzRWUlIvdnlXenEvVzVFVkNTVWxpQjRsSURnUitVTldBZVAwcDcz?=
 =?utf-8?B?Y3pHOGErWWJaYlVycUVRTTYzYnNPUk5RU3Y4dXV5ZWc4L1U5WmlwWnRDeVdB?=
 =?utf-8?B?ZmxqZHY3RVhUWlRIbC9nb1Z2a1NXT3ZqVnllOWZLZWcxQ1dzdU1QZEJSdnZj?=
 =?utf-8?B?QVE0Sk45OTJLZmwwejMvMitiTW5JRE15TFloYjl5U0hQZWpqbVNMUmNueDFx?=
 =?utf-8?B?OVRPTkE5Ym5mNE9SQVRQRzJjeURBcWU5NldKeHZINURzSlRBZS9qcloyUm16?=
 =?utf-8?Q?sBzQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6150399791A2514B9DEE9F42BA7BC067@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d2b217-d41c-46d5-ee3b-08dc91d33662
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 09:19:11.6279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tG7Xa2D2wSUBP+EPSRQFYchCRtMf9osObWnzQiXDD387HGEye+6HKEqkz3+BwdfVi5c8wOHbzcnEnb6sDlHbLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
Received-SPF: permerror client-ip=40.107.223.59;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

SGkgTVNULA0KDQpPbiAyMDI0LzYvNiAxODoyMiwgSmlxaWFuIENoZW4gd3JvdGU6DQo+IEZpeCBi
dWcgaW1wb3J0ZWQgYnkgMjdjZTBmM2FmYzlkZCAoImZpeCBQb3dlciBNYW5hZ2VtZW50IENvbnRy
b2wgUmVnaXN0ZXIgZm9yIFBDSSBFeHByZXNzIHZpcnRpbyBkZXZpY2VzIg0KPiBBZnRlciB0aGlz
IGNoYW5nZSwgb2JzZXJ2ZSB0aGF0IFFFTVUgbWF5IGVycm9uZW91c2x5IGNsZWFyIHRoZSBwb3dl
ciBzdGF0dXMgb2YgdGhlIGRldmljZSwNCj4gb3IgbWF5IGVycm9uZW91c2x5IGNsZWFyIG5vbiB3
cml0YWJsZSByZWdpc3RlcnMsIHN1Y2ggYXMgTk9fU09GVF9SRVNFVCwgZXRjLg0KPiANCj4gT25s
eSBzdGF0ZSBvZiBQTV9DVFJMIGlzIHdyaXRhYmxlLg0KPiBPbmx5IHdoZW4gZmxhZyBWSVJUSU9f
UENJX0ZMQUdfSU5JVF9QTSBpcyBzZXQsIG5lZWQgdG8gcmVzZXQgc3RhdGUuDQo+IA0KPiBGaXhl
czogMjdjZTBmM2FmYzlkZCAoImZpeCBQb3dlciBNYW5hZ2VtZW50IENvbnRyb2wgUmVnaXN0ZXIg
Zm9yIFBDSSBFeHByZXNzIHZpcnRpbyBkZXZpY2VzIg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmlx
aWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+IC0tLQ0KPiAgaHcvdmlydGlvL3ZpcnRp
by1wY2kuYyB8IDggKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5j
IGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPiBpbmRleCBiMWQwMmY0YjNkZTAuLjFiNjNiY2Iz
ZjE1YyAxMDA2NDQNCj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPiArKysgYi9ody92
aXJ0aW8vdmlydGlvLXBjaS5jDQo+IEBAIC0yMzAwLDEwICsyMzAwLDE2IEBAIHN0YXRpYyB2b2lk
IHZpcnRpb19wY2lfYnVzX3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQ0K
PiAgICAgIHZpcnRpb19wY2lfcmVzZXQocWRldik7DQo+ICANCj4gICAgICBpZiAocGNpX2lzX2V4
cHJlc3MoZGV2KSkgew0KPiArICAgICAgICBWaXJ0SU9QQ0lQcm94eSAqcHJveHkgPSBWSVJUSU9f
UENJKGRldik7DQo+ICsNCj4gICAgICAgICAgcGNpZV9jYXBfZGV2ZXJyX3Jlc2V0KGRldik7DQo+
ICAgICAgICAgIHBjaWVfY2FwX2xua2N0bF9yZXNldChkZXYpOw0KPiAgDQo+IC0gICAgICAgIHBj
aV9zZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBtX2NhcCArIFBDSV9QTV9DVFJMLCAw
KTsNCj4gKyAgICAgICAgaWYgKHByb3h5LT5mbGFncyAmIFZJUlRJT19QQ0lfRkxBR19JTklUX1BN
KSB7DQo+ICsgICAgICAgICAgICBwY2lfd29yZF90ZXN0X2FuZF9jbGVhcl9tYXNrKA0KPiArICAg
ICAgICAgICAgICAgIGRldi0+Y29uZmlnICsgZGV2LT5leHAucG1fY2FwICsgUENJX1BNX0NUUkws
DQo+ICsgICAgICAgICAgICAgICAgUENJX1BNX0NUUkxfU1RBVEVfTUFTSyk7DQo+ICsgICAgICAg
IH0NCj4gICAgICB9DQo+ICB9DQo+ICANCkkgbm90aWNlZCB0aGF0IHlvdSBtZXJnZWQgdGhpcyBw
YXRjaCBpbnRvIHRoZSBzdGFnaW5nIGJlZm9yZSwgYnV0IHRoZW4gcmV2ZXJ0ZWQgaXQuIERvIHlv
dSBzdGlsbCBoYXZlIGFueSBjb25jZXJucz8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4g
Q2hlbi4NCg==

