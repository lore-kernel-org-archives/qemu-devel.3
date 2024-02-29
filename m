Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D5FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfes4-0000zs-QV; Thu, 29 Feb 2024 06:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfes0-0000z3-TN; Thu, 29 Feb 2024 06:46:36 -0500
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfery-0004HN-Aw; Thu, 29 Feb 2024 06:46:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB0VB4qpRfFdDKU+sHlqBN6iMEqz/HxsAQ/iQOtwLG5Gb1r+sLaX0xhnbRyqr2E6PqIu7pbo2NcsHnRIoICWUdJGqpCND29IDqoG8UOmLSVGHiGLaSnHu7UVxpQsNpQT2jZbXVVKCLqDNz2rmaTpmY8f6a7ZISEqGDuf+9kySw3sKZUlnZPdspn0hgg5UPhcG4yTp+o4UTOxgx7fOjAUk9iMn69KcI9yviqQYL4O2Gr81LS8OXXve+4pTGrk9d4tv274/Z1FVSmG3JFhMhmylVv9uxoyIpCHgc20sufXuYLtlRveEBc0UFFP6YHc+vildRDWsnQaJFZCXSXQXoFEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eelsRJ35b1gaoNBLw3+vIsW5sZ/DUJFQLwKA8pRWLAI=;
 b=I/XE0gsn6FDSC7J62Jx4MDf6NmFUmDdvbTGpA56KXVNJT4FozVlZaDXxOm3sKfiPF3puVb6wcj6OY7DULryWzy1RxBtGnj55hTb0ojh8qBRUoHDEkAb7ulEvz5c10jMCB4+Jo6E54SCcObrW1Y5SfxQ5l1JAYB5qTK2vDhY8DHjhnx2u5WeGT0kbXP4Yg9dTQOZIJIts1O6AjLnym7kz4BSxM8IaY3ilgm5yBPUygxtUf1pQls5oktrF89pirkf4BdvPPEpN8W2WtmgNhjhxcG4FqwL3+/Md77vKnGyZ5itPAQ3fJNOecnX3HJ4cXtF1U/5g8nRoPBv456sowLguZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eelsRJ35b1gaoNBLw3+vIsW5sZ/DUJFQLwKA8pRWLAI=;
 b=RPoTLT75VUAuvEW2hccCMDtuAO69d29Tvmj1UjxK7zSgFS3uLyuuezzhHlLjKbkN56yU1B7cq0zcwTqJvpUZE02+dAPtPvDpTfvlrexqp0lDm3sKROgUW27KoxroOoNmxbwJOhok9yMNW22vixYFqSGj8DoR+/KT0KX7l1XcU65lG8iDq5YLS5HS3x0GQQA84ZPnMsRmq+XL91wXBr8shV/04RlGB1qjdgWKiEgbUXfgSc19gLamk3+mb8WSsk+hBG1+byAeshcCe18EcwR0wHkYktuobuhIlNEfDToq/c0yaJXMbxs2Dch3A9HF05qStLfgh+nZimvSnkOfHxuWtA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:46:27 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 11:46:27 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEeKzKAgAMRmmE=
Date: Thu, 29 Feb 2024 11:46:27 +0000
Message-ID: <SA1PR12MB719937D09D2DE7C2ABBF78E8B05F2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240227125317.00001cf8@Huawei.com>
In-Reply-To: <20240227125317.00001cf8@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MW3PR12MB4491:EE_
x-ms-office365-filtering-correlation-id: 51bc3939-b833-49d7-7db3-08dc391c1077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vhz1xvirxLpAU/j1tN9FjeZm8RMwh8yjioUC2zD3NC5U/K3THltYfHSPXttbsRohekhnlITptCIXhYokrbXUP1nDunfMaM58/uXpzH5YtfXuJIilTSc8ep6g4MadutAZvL8H+DYuRPnhXRMouxIGqOw/CNcfo0kamny7T36h1/OhZme7Wad++sSVWJjhq/UyUwePQn1t2B9PNO9opdTYl49zxSIyb3soX5u9tmQmB4vxpLoK87azU3wiNhdeWnYKEo0oYanvghh2p5OEwzvZOX9QVMw1EvY3XjRbiGli5n7BKi2JI4n38DSsXyU3bYW+LUp/d2YCE0j7uvEkbXGrisxGqcuCZsT9TD2nP8NEPuneHtxN15D3ZGeYSR2VWp4VtzEJJYFBSCWePBbuHPao3gfSxw02HFnxXB0BsNptnCCUpjvJBvpw7HdQndoHeuX9bs0TWVmOy8T3+AlQxFq30X3PdoYuHG4tqIftjWNryy/Vhqs7Coh5iJ0BQSIJdTrQBr8+6th18mo+2/o8WspH9SUJAIZOXS15qLeAitr3pPXiUaFd9VL9gY+q5XaMJMM3ly7cM/XUD4anxsfvkuFlgK1RDKlvmvfG7HTluD25+NwsuGyDdfiYIYf2vRyU3QApbfC8n/zgZA2/xAFoeJtV4z+FWzJnUKkoWPsQ+GovR6ZU5m8qOnKpefsehz86pNBon5eySd603xL8o1gjwfGwBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2Bry/rz4BAVQg+LTpWJHvzHE2Ax1V82hODDMQnTJyyGCq7WbN1YAMNzcgH?=
 =?iso-8859-1?Q?AFPhhqngCTR3TL4JJ++BDWG4KGCfwZnDKAVKYEQFrZQPMhtVgndHFzfnWx?=
 =?iso-8859-1?Q?xV1GjpTZUjK+J3Y6qLo/Feb4fHUTwn/kHSkTuxKG+Okf5s9oJgzayVsQqL?=
 =?iso-8859-1?Q?aVaSFn+P1I2owhGXIVgeLq2o9RgZ4ghV6DAnWxveC/tGePsudnlDKC3awR?=
 =?iso-8859-1?Q?J+WDN8iNjXNSMwyKbd1xnpHNy64C7ZoBwvcH2lFqTIodSVvbhPb5Kz7Wp4?=
 =?iso-8859-1?Q?V4MxhYeaOkHrFkCQ03wp9yts5oKeKuIrdRlJp/7HPvRRxGInEPs80gIMr4?=
 =?iso-8859-1?Q?p7mwlu1ziwC9jxXkbmiZq1GbbVJdZej+DRzX7CnDblwkyJLqw7inmyjcWS?=
 =?iso-8859-1?Q?T64VvyE5C3b0u2C6BA0pY6nP8GK0L5RT4pR4vgWXbcfFhe6ctlwBuRiSE2?=
 =?iso-8859-1?Q?RlGAa6w1NkSUL6HWWjfDwZ6ipDwThRhRrUfKBymBER+nfNj/5SL1wYHWcF?=
 =?iso-8859-1?Q?DJQtqhNV7rQPaQ6C8Cjp7HWc+0GLezNKglVXUjaW7Ls0GlgWkJxM13h08Y?=
 =?iso-8859-1?Q?HQ71C1W6bl68cODAD8yvhGy2xkQNYDVYo+EiTSZJzZzlo18KqHFuMTnr4y?=
 =?iso-8859-1?Q?trHg7IQp1IlSequsWt8U+jQpQRd85um3yD7Cp8rY7G5BA4aONF2jqhOztq?=
 =?iso-8859-1?Q?N0U8Y97KhtYVH843xy8AkcCVdoz2Ui0D57P4jQ1Ga8Dj6VdK8ItWrMOBcd?=
 =?iso-8859-1?Q?snvgz4kypOXiS2Cu+UO6WrwJLFhtmN7ja2YtUfffWvS2Vj9lVCOKvFT+OJ?=
 =?iso-8859-1?Q?Mr/KfexYWYYP6uHbqygnnlUmIzp5QQl72sNKJzvA/btapc+Zc9G8ufXp/f?=
 =?iso-8859-1?Q?dN+6h8keRUqPX5/vn89n8ZtnVAPO4vOoJxZet1c/OA7ZsXm+GVmBiJsXdO?=
 =?iso-8859-1?Q?bg22p7EKJBrGL+to49ImPe9vA2XCIsGvxAqGU7IGzAzsGVNZJyzf0uNWJG?=
 =?iso-8859-1?Q?7diDIGDqqnH7mjFDUDrfUordGapm1z4mW53bYavn6fJIAhVr+Bu7NM+FDM?=
 =?iso-8859-1?Q?11c05WzDjIYnjelkDyRHy/bMBRNBEadrhwtk1AqjlxOZ6PNpPtG60L92of?=
 =?iso-8859-1?Q?0TYxEueUqwUGzm14YqQks1Y0bK0ZaPokFpHsgEJd0LUKjRMCvYvcz9HPLT?=
 =?iso-8859-1?Q?+3TUJ5c4FkzBrnIJtyxDupQc0SyjHN3QPplS3/zG59NYm3QzKK8k++0Arp?=
 =?iso-8859-1?Q?LwSL1TOOEKYBVP7N2b7ciJIAX9vGNLN0y+7US2vaHzVDO8BXbcdq58mmSq?=
 =?iso-8859-1?Q?7HZE/50WG8kiU4qXMa5dNM/9xjSzpOyg72DYw8vA2FWzAze2biBvQGZe/R?=
 =?iso-8859-1?Q?NSen2iXUAeTCuNsQXC01h3axWa5rG/gpdeoMcii8L26+oapCvdms3sjkh9?=
 =?iso-8859-1?Q?H+y7Nemv1rsLth/AuBkvnPdHHAR8Zk9a8zKas8GoqITmEJ/Ad6qXT+uBAQ?=
 =?iso-8859-1?Q?oGkS4zUFvdU/+6TQPqb1E25Xb0PJ1TqUBRo5OWY1eXwiXmhuNrzqVvD/WX?=
 =?iso-8859-1?Q?143kbrki0AojEDqtynFIIZLDju4xpdGbc7gs3qPal92KIAO69/uTPjyQpR?=
 =?iso-8859-1?Q?IEQFI1zylxDlE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bc3939-b833-49d7-7db3-08dc391c1077
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 11:46:27.7701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqFTAdJ/bebmpjXUwqINO32YL2lqj8Od2V/fSdiiUlQsjYgVgAJR8fLw3ZDYW2Y6DuHuG9GhCUoaRQXm/uA6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
Received-SPF: softfail client-ip=2a01:111:f403:2418::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>> ---=0A=
>>=A0 hw/acpi/acpi-generic-initiator.c=A0=A0=A0=A0=A0=A0=A0=A0 | 84 +++++++=
+++++++++++++++++=0A=
>>=A0 hw/arm/virt-acpi-build.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 3 +=0A=
>>=A0 include/hw/acpi/acpi-generic-initiator.h | 26 ++++++++=0A=
> A few more comments.=0A=
>=0A=
> Maybe _ rather than - as more common for acpi include naming.=0A=
=0A=
Ack. will change the name.=0A=
=0A=
> I also wonder if we need the acpi prefix for file names given context?=0A=
=0A=
I tried to keep it to match the object name. If you have preference for=0A=
not having it, I can change that too.=

