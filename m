Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3349C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 06:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpjBm-0004kZ-3q; Thu, 28 Mar 2024 02:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rpjBj-0004kI-W9
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:24:36 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rpjBh-0001Lr-Ju
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1711607074; x=1743143074;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L6Zde+7j5fkueqRV4rKCRNZTEcIuabRaoV4+hFjTi9A=;
 b=S4me5Firg/l8IcSgOk2L1hA2V+KlNGLFIp2g1qRaEsQ6E9KQG35OSlwb
 M7KAqycpaQd+bj+hoBLj0aNx62HzQYUWhI1x7Yuw9Wj2M1jSdCjX9yUWr
 WyK+KdDgczbY9GLTmt/e0Uh159Y2tP9jIuxVlSiPU/6NNzuBLUEo2Yjv/
 L7XZKWZT3QQaV1B6HYkYlB4SARIn5cbAp1s33Ar46DmZXFxAbYAyznlAK
 Zit7MYKvec9RpKtPj9NA16HsLw7akfVDDVstoDVTifmBOhSgTPIakXEkA
 SO4iD5r+S8LhDLWrXRdYyZvpt+QG4QKioi3H2mrik3SqMZhcnqjEWc1n8 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="26357739"
X-IronPort-AV: E=Sophos;i="6.07,161,1708354800"; d="scan'208";a="26357739"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 15:24:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVoG3h2iSUuMEly1rWkJdZGYBAQPgPiPucYzulNyvs6bnnLwdc50vp7+/0lAZH9mYx9UiK+nHWUa3yIDfuk9zjHrH3/Kb1qkih182ZSu8ov9Nyc53x/t2cqt05VoFLKZKF050OjdLNllFQVcxMnIgxRDQjzdnx8ZSXyMKGvh0v88XSZVddkqNMqE3hB+UGITNULbOgLS53nPuFKmOqPV7XDCvPkgj3/BQ0ki2pAcTz1wirbMbFucGbGNnOEodvfxMYpsW2yM8177MHEfvX4lJxYs4YD9rltTE3jSVgOkzrrW6wsctvzaplbemy/ktcrQ3HULb+ALYdFgXfl7i4BHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuVdIPds0IkU8I1/mKTbxss+8+r2KAVPMObMk19I17o=;
 b=KYhdAfVzgVO8jFw0OFtJOHSMcjUyn2M8k4XL5lo0aoRHXwzh60RW1fxOkjTfOh+wCwVPvMiQaFt0an3tr4pWyTUwL6qp33g6fWqbnZqsMsQqeuM8dW0rkjfsOyVpXtjO/NRfErugyp7Bx6T8YY+SyCgI4oElBuK/H5xS8b8iRPneOrioyQR+O+dyhgckMq8jLSOuRHmT0uxMzFVJYLih6oliv9qk47zUHdwQDj+a+lBc3GDQ9AwFzV4bt7G405ax0S0k66YYAeAOwW/SlnojcpcHBagZdH4kqyTOMDPsZYgm/4oFmw5mhuAG0Bh+PzOraCZif3heQqDKEqWkW89HEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TY1PR01MB10787.jpnprd01.prod.outlook.com (2603:1096:400:325::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:24:24 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 06:24:24 +0000
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Quanquan Cao (Fujitsu)" <caoqq@fujitsu.com>
Subject: RE: [PATCH] mem/cxl_type3: fix hpa to dpa logic
Thread-Topic: [PATCH] mem/cxl_type3: fix hpa to dpa logic
Thread-Index: AQHaf+jv8Of5xYfdY0OlS5LMTSu6ObFLlWsAgAEVArA=
Date: Thu, 28 Mar 2024 06:24:24 +0000
Message-ID: <OSZPR01MB64531A2AA07AF4C7C8C800F68D3B2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240327014653.26623-1-yaoxt.fnst@fujitsu.com>
 <20240327132814.000057c7@Huawei.com>
In-Reply-To: <20240327132814.000057c7@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=f63a06ab-6f7e-40c3-9f75-7325dbeade0a;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-28T05:59:47Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TY1PR01MB10787:EE_
x-ms-office365-filtering-correlation-id: 03f91128-923e-4d99-145a-08dc4eefb695
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdWeZ5KT2lHtCFBMz8NB6PhBHhN/GJzMM9gsGIXNmiSK2qSrvTypZwSQMWBteQmCCY6CZQLRVL2+/D0TFtftiL8w2cyIMnINIvn4Er/tKVYZwdU4ZrfZqQ4WnB0kRPttKwyGYkb5V6cCj6bB3zoTaPU00oq/MnNIAY5fzgEKWlujgd2flv8XrCMj7YShl+arXGZPy9pVlrMA5+LL5iiQjJingVzllZsqyzMqWZFjYDnFFXow84wIoXOW7mkJt9/lm3jzrhQ/00faFFDLL/bx/MLKf60m5dqtqYzziyvp1UYSw1+zNKdxozNAmw/hafRSORkWU3v0tP8ALYs5jPPHHh8U+umTAOkSdODqsxqpEwDSlLa4/y90Sw6KFIIzfEVc+bjxvSDP0DCYlaDHkkN4pzlganu0vi5+qBP+3LiqaUdeRMV755Mv9DWX9csJMf7X/u4LW5A07XSTD8GQG+y7UaEv0n5YN+4OZqwjBO2cXGWLN+wbfYDC+lUBVD0mFIqrCepSOJOoN87bFPVw1LcP3QylJ+5r/5D3F2c7FWxHMhdKXqKUrVL/Mbx21a5cOQh9WVnI/WlrGEQ4mzask24PMS0xQTmvOBizjX3Uddy0DnDdBcRIMyVS9cqTcEtrdx7Gxr2IyfpCx53hDIBGZEsoR2CtqWD7PZvtdeYgoDmSCa6yHQIMF6m34yrKlTDHZnha
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(1580799018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NmNCdkhWdk5kaFNvM3lVdWZPUGdEY2NLa2luLy9XWGNocXNBL0NVK3NG?=
 =?iso-2022-jp?B?dUFHS1d1bVkxUktRQ0lPT0E5Z09xbkh2NjhmRTBZOXVVT2RrRVNHbWs1?=
 =?iso-2022-jp?B?TmpvMnVaaHh5KzlOVS9YY09WdVZLNUlwN09jSU5FRGpnLzN5UllDcG81?=
 =?iso-2022-jp?B?U1RwWDNJZ0dGdDV0d0dWaUpHU3dZSXBxbENoSGJheGNxeEQxSDlwYkVS?=
 =?iso-2022-jp?B?ZkhicytXSTNydG5BV1VwVjlYR01EbVFIUlZucVlvRnhBWHA3ODRBUFZ0?=
 =?iso-2022-jp?B?N3VRMkJqK2xxeWN5OXV2aXUzSHhkODFLMGxsc05aUko5NVhGem50Z2dW?=
 =?iso-2022-jp?B?NFRqQ3lXbXI1S2V0WkJJRzRwOEYrS0RYcjhLcWtsRTYyOWJyU29nNi9s?=
 =?iso-2022-jp?B?NzZILy9aMTViRGtFSkRTOWxleHJNVFNsWjRIWUxMUGhnbGppaVZPaTNn?=
 =?iso-2022-jp?B?U3R6OUt5NnFGbzVlenp6WUl0cS9wb3R1ZENPVzVkTW5OWjVrNEs0cnph?=
 =?iso-2022-jp?B?a3pjRDlPNWdyMExRdG80ajF2YUlTQ3hYQ0dScGorc2wwcEovempYVXk2?=
 =?iso-2022-jp?B?RHhxZlZkNXBsQ2QvVnBsay9IaGM5U0VPQUJyc0drVHBOa3dvS1JPL2g4?=
 =?iso-2022-jp?B?VXdObVY0NEhXUDhTT2NtVzJQUlp5RVBrd2RvaEFXamJwUFRKSE5iaG53?=
 =?iso-2022-jp?B?MDhPY1Y4a016V29wRTlHcW1DNm5KOHROUUdpZGkxeUh4b0k4VDQwL2xC?=
 =?iso-2022-jp?B?MzE2WEhOUU5pc3BoWk02a3JQRlpZcWp4Nlk5bWN3Z2NRRnIrTDk0WkJG?=
 =?iso-2022-jp?B?UG9tRVZONnZwMDQ0dVlmODJVdjZXenlUZWRjcGNTQlJJUjZWWEZlUXda?=
 =?iso-2022-jp?B?WUhIS2JUa1AydXNJOHJrT0lTZ1EwQjlGTEdhWGk2YWNVejRPTXRsMExj?=
 =?iso-2022-jp?B?QTFkK3ZiYm5xUlJFQW9EY2ErWnVLZkdObS9QZnhHalNIbDhmZkxlMU1W?=
 =?iso-2022-jp?B?RGZ4SUV3a3lYRXYrcncyUXFBNlk1Mno2TUtpRFlURVU1NFN6NFBWMkF6?=
 =?iso-2022-jp?B?TnUrUS9yQTdrQStyRDM4WHZoS25JTHVwQ1lRZ0V3WHBJZEhqZmM5K0Ny?=
 =?iso-2022-jp?B?Rk5ZKzNBQTNScWZNcmpYVGxoZFlGRkk1Unk0eDBLUnBTSS9tNzRua3dN?=
 =?iso-2022-jp?B?bHVrM0Zsb2VJMWJWL3FSV3orelJBMFAweGJaTlAzeno1ZDk1eThMNVNM?=
 =?iso-2022-jp?B?TDVyOUppeXRQeUVlc29LTEhmQVpDVkg3a0NHZ1ZHYVJzOWxzY045eU9F?=
 =?iso-2022-jp?B?THM2S2RVUjFnb2l1N0dFRUprSU1WYmlLcERtUlhOUUtJQk0zd0pndlQx?=
 =?iso-2022-jp?B?dmxCaXNYMnc3UUNablVZd2RXaDBCY081Ui9uMVBHUkpSTVQ0WTFEcTdO?=
 =?iso-2022-jp?B?L24xeUVoRE5JcEFVNXo3azBwZUdPNUZIYlBid2krNmNQUnJ4c2VqMTNL?=
 =?iso-2022-jp?B?d1NMNWtCdENCdk9YUGUvQTRjcUZKYWZkQ1hBeTh4ZStkRGtDZzhhTDhn?=
 =?iso-2022-jp?B?Y3Z4MEIxRGhBcDVhWW51UHl2ZVVWVnUramFqY2JsYlRnY01xZzBZa3E2?=
 =?iso-2022-jp?B?Znhha2xHRjRpQmNQLytVcExja3RRVEhCb1ZoUmlOWitwWW1jS0Q3QzVY?=
 =?iso-2022-jp?B?WkV1L0d4WndTUXBnK21Vb3dvUEd0bUcxaFNhWlYveDF3NjhGd0VWL00z?=
 =?iso-2022-jp?B?ZXJ4SEFSV3NQV1gwN1ZTOWtqemFMaUZIZUFCbGJ6VUZkQkp6ZFJRQlBQ?=
 =?iso-2022-jp?B?SXRERkZUU0VmSFJqaWtFVnBJcGlKLzFxbDhkTXVqaWwzcXBJT1dTc3JF?=
 =?iso-2022-jp?B?K2RKOU4yTzhLd3ZlL1BKd3YzR1kyMlZnaW9Zbm9yREhyWnVWY1ZrWUdP?=
 =?iso-2022-jp?B?SHhydUpIR3BmSkY5cFhncWFlRUw5bnBkWjcwaDlWTUo5TWwrZ1JSYjVE?=
 =?iso-2022-jp?B?SUlCZ0QvcWZHK3hQN2NSNzQxOGVOQWpNNStCajNYMk53Z0JMSEgxakFN?=
 =?iso-2022-jp?B?KzJvdXBsR1d0bnZFVW9xejMweHNDcHBjQ1FMTmhTQ3Z1a1FlY0Mxckhz?=
 =?iso-2022-jp?B?WTY3WEQ4dzBPNlByUHR5aTErczQ1YWhaRjdhMTg4QXZjMGtLcGdoUE04?=
 =?iso-2022-jp?B?THJGb2NvQlE1Q1Y0R0JOTUdPTVVkemEvZzdIOHFJZ3FQbHJWdzEvQXc3?=
 =?iso-2022-jp?B?VE5rVTBtOG93Q2wzOG5ZVnJXakhLVGg1bU1DeFk0L3lqWWh1Zjd3anNF?=
 =?iso-2022-jp?B?UElaWg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nsu0ppCHBmkwoefGp+fXL4i8LcEhdQSKjRsXPQdU0ccHbAduyag6GNe3Sq2SnsD99lDnWi1V+7b4E+PPa+9DLupdOeSfznRHjwxRfwMmL4ZlStena+p39vCIXQ7Ns9b0Ji3dbNocLHeK6M2SBuXwhVcLFl3W1RTK4kjkfR6zohGbVU1/TILvEuHE0NbsUE5t3aDM8sxhAiXnNiBYtgKDxJv/ix0+rocHD5mcmS81CeZtPEyNEv9ZBlh2Kg3puAZP7rxXtAbi7wQXcnF40aID0KE+UA2eOUOinciqdRWNnffn7ob3n6V3wokFHdKuP4HDDY3ZockTBvGR/f/BcHc5xDXdnhXwGon9K2FGePaW0aZlMWVDhZnFD6tGyX7sOAXW85YdrQicQ29fYES9EuuemKyGoIuO+5eOxGv02xqbMlbKyU+LkhkYd59jXRBsTCJM3z2fFxP6ct91NVLv4mQD0hpY/lGnNFls/gFL28mdcZpiokP5DAF0PJv5TCtwtEnpkxM1xHIs/42D9tP/5BzE9ySfEIVB7iuFoC5EqSdNwAGy2VtJkjHKe6e2XlCtU0W2jCtUC1dxQdylefvOM5XEstjC/WkbvbwEUdGt8eBJBS9hCyWrNcNQmpn81Ai9GIkN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f91128-923e-4d99-145a-08dc4eefb695
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 06:24:24.6575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKVwuXpvYR3jM8XHSBlnMH5uB93kWGNr6OZg5sh2/jNR3reyVpcjFRmWEzI12tBvHy7LaRFu1brFb6cPS1jHZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10787
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Jonathan

thanks for your reply!

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, March 27, 2024 9:28 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: fan.ni@samsung.com; qemu-devel@nongnu.org; Cao, Quanquan/=1B$BAb=1B(B=
 =1B$BA4A4=1B(B
> <caoqq@fujitsu.com>
> Subject: Re: [PATCH] mem/cxl_type3: fix hpa to dpa logic
>=20
> On Tue, 26 Mar 2024 21:46:53 -0400
> Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > In 3, 6, 12 interleave ways, we could not access cxl memory properly,
> > and when the process is running on it, a 'segmentation fault' error wil=
l
> > occur.
> >
> > According to the CXL specification '8.2.4.20.13 Decoder Protection',
> > there are two branches to convert HPA to DPA:
> > b1: Decoder[m].IW < 8 (for 1, 2, 4, 8, 16 interleave ways)
> > b2: Decoder[m].IW >=3D 8 (for 3, 6, 12 interleave ways)
> >
> > but only b1 has been implemented.
> >
> > To solve this issue, we should implement b2:
> >   DPAOffset[51:IG+8]=3DHPAOffset[51:IG+IW] / 3
> >   DPAOffset[IG+7:0]=3DHPAOffset[IG+7:0]
> >   DPA=3DDPAOffset + Decoder[n].DPABase
> >
> > Links:
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> u.com/
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>=20
> Not implementing this was intentional (shouldn't seg fault obviously) but
> I thought we were not advertising EP support for 3, 6, 12?  The HDM Decod=
er
> configuration checking is currently terrible so we don't prevent
> the bits being set (adding device side sanity checks for those decoders
> has been on the todo list for a long time).  There are a lot of ways of
> programming those that will blow up.
>=20
> Can you confirm that the emulation reports they are supported.
> https://elixir.bootlin.com/qemu/v9.0.0-rc1/source/hw/cxl/cxl-component-ut=
ils.c
> #L246
> implies it shouldn't and so any software using them is broken.
yes, the feature is not supported by QEMU, but I can still create a 6-inter=
leave-ways region on kernel layer.

I checked the source code of kernel, and found that the kernel did not chec=
k this bit when committing decoder.
we may add some check on kernel side.

>=20
> The non power of 2 decodes always made me nervous as the maths is more
> complex and any changes to that decode will need careful checking.
> For the power of 2 cases it was a bunch of writes to edge conditions etc
> and checking the right data landed in the backing stores.
after applying this modification, I tested some command by using these memo=
ry, like 'ls', 'top'..
and they can be executed normally, maybe there are some other problems I ha=
ven't met yet.

>=20
> Joanthan
>=20
>=20
> > ---
> >  hw/mem/cxl_type3.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index b0a7e9f11b..2c1218fb12 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwad=
dr
> host_addr, uint64_t *dpa)
> >              continue;
> >          }
> >
> > -        *dpa =3D dpa_base +
> > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_of=
fset)
> > -              >> iw));
> > +        if (iw < 8) {
> > +            *dpa =3D dpa_base +
> > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &
> hpa_offset)
> > +                  >> iw));
> > +        } else {
> > +            *dpa =3D dpa_base +
> > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offs=
et)
> > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > +        }
> >
> >          return true;
> >      }


