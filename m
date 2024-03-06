Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A88EC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoiU-0003Tl-NK; Wed, 06 Mar 2024 05:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhoiJ-0003Qe-Lj; Wed, 06 Mar 2024 05:41:33 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhoiD-00038i-3N; Wed, 06 Mar 2024 05:41:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU1bDqlORi3T1AdzboNTHHAa5XgcFnrredTr8bnzFosupwEFqqS5M2LwATSBKGa6Nfailmb3pdp5fOX6w2mnhXU2CJDhYNw471S7LclGxEGt4JRnHqDyTHG65q6P9mniWvpHP1/fBgBchfrs6iAEdew/hKqeGBEuhCsJJPsVE4SWuDNcf0QcEoFg2v6qq07T5hogSJQzie1vMgipwMH6pvEWv1FQfpQZ01BArzT+GiABa1FKV91+Wb+bMBOEZHcikTthlV2D4mzbmNUyM/ANkjlAnNWp1lRc6lmyXchVdR3p1W6C5CIBrjjt42/up/3AXhHfEOmgzdaujtxX18FP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7i87Nool1EUVCzbTMyLDVLsg2jIZpJbHjWITx6h1vM=;
 b=FCZANCBts6Z54TyHHeNm9sXQBEoJ0anCYI0Er558t6YepfsDfsYfVgwhSActyKEpALejWV/aoOiWaAhTB8VUaht2mR+ZlznsL9KvbyImPpOhNQqUPUmnlodnHsmnwXNsmFEXxUOtpeI5bor7CjI2yIO56hiMl6E38jfcvuipBn0rGpS6dV2ks1P3l3AdRH4Vxo+MrY+CJE1gg2i+St7llcOrSktdMnl0vVAwcG9jAHNMVc71iU9WjnhzdjF8xNwqFMnNUoO9NQkoDQXo5Vmg5ms+xT6jVpr8PXoMFVDivkkZaMrfOJueX/Bz/ZMf7LNlFKAU3JZG2vzQ983S7zZ4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7i87Nool1EUVCzbTMyLDVLsg2jIZpJbHjWITx6h1vM=;
 b=ItJwecGERNKSwY+Z1jRVUjyfiwph1dFoJNZGxqIhnjcslvjjIz/pkrMgWKLaZ4TZAlfCwdjHv24UEr0rXsptEPkC0Kue5byAOfTaUDSjYoo7HzeqVlDW4VAy3PJMGdE6VWxPlZyt/j1qCaTsrLdSnGd3VvpMat6dTBq01bJTIegmywqFzVgCtwEEHA+xwZn6b15v//kxqB0C1W/wxYYZN48DzXOIt2ykN6FNRV2vyuNKVPFpl2olECOQlhP++SPO/zdunKOtGHm84dNfrT6F4KSA/Fq1EBrPQpbhOI5hv4SLZ/A6OcRFoFAvwLU6YS2FzfObm+IJX/waODmEKlwQYA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 10:41:20 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Wed, 6 Mar 2024
 10:41:20 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jonathan Cameron via
 <qemu-devel@nongnu.org>
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
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgA2nUICAABgHuw==
Date: Wed, 6 Mar 2024 10:41:20 +0000
Message-ID: <SA1PR12MB719962BE5C2D8FADAB0ED958B0212@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com> <20240306091241.0000432b@Huawei.com>
In-Reply-To: <20240306091241.0000432b@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|SJ2PR12MB9189:EE_
x-ms-office365-filtering-correlation-id: 2c61293f-9846-4643-83fa-08dc3dc9f5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kvwf0o1uMHeHeeaRnM00oupHQrimcU2p6VQI0vfiXbe2onIRO61zQjADBla/ZK9yg47XMv/Bp/6P2ScbBQPk9X8+15PfDN+C1DuR36K2T0H9IuYAm0al0rHXzJVuQRMDN3mYyaf8s6DKTQVsd04MRL8DlfLgcC7zmieW3unEqWOCub8HyeSMLebSjzIbbxNGpWhWzPtBGz4YIkIp1g43LRfT2hbieBh38s7Xj9897+FQEuKNTBmbRtQllrziBAfZW97AXDsjUPXtJ83YXkQWbUDcjt2gk+7mWMmCkW/SONmn+TUDMY0Cxd5QuwODQtg8JmD54vx7hZjbRQZlHfO92UfxYhqVPSM+QVejvv7Uv5QB9OK6eXq9FeffB54JtUm6/ZADZ+yKa3LnOtoe9zoIYWc7Db6rKsX+U8MMH8xbU824lOIBAMhQT+rRo11M8jJJEbtcj3jDCRrq6jt7nAxez56uYOdoPeTVjBn/Sr9DHZq0y5KfRM230LTc1cwJj/gOp0MhRH5wEazk+mVPYZb+zWvVbEgVUXpaABDo8pKx8MFfQ49aVK4lKPtcu4h6zSuNDH20Ab1eyh6uqlf/FpEnvPneUZgllv/3uyDk2PUEDStzj9uaNnmtleY4HcZEIJ5fsP+Q1z6w6AG2egtBxM7iepbUbLZ2X90YO9feySl/gQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?phsNBWrT6allLoe1hAEYOQXVO0zFjqBtSATxFCPeoZTuYS+iP1uYzzhkqB?=
 =?iso-8859-1?Q?b1epaaw6z2JtDeuFoo3rY9b6aEZ1XbDJCbhzH15eYOF3aPh7Yyww6MzHRl?=
 =?iso-8859-1?Q?+yAfS6R6sn1pBPzSwwNGVhXuLNQFEnnxFpLpMYhV4w791+1Pf36idw5Eyz?=
 =?iso-8859-1?Q?27vVL5S4yx95H0+M/IOY7Fk4eKDAppV/qpjXkNQOzsWWn/ntSI5JOQKNCF?=
 =?iso-8859-1?Q?YNx0uBET9K63f7fpZ1K2rxrpZXFkoBBpoWZzK9U0SsAoMMWpAKbYzW/vE6?=
 =?iso-8859-1?Q?bmXCZfaTXulQayRqNzF9cxYK65SljDviBV2s/PKxuTAZjG57G1E7prhwxU?=
 =?iso-8859-1?Q?G/k9AC7BVhRFH2swsVSY+zKEv3o29v3CHi7Lx3btMAzLRWQ7LWlSyPtTOa?=
 =?iso-8859-1?Q?UqQ4uO01X02lrT6bUYgLx6T2zd+cAT/F0OS03LKDKlAod07pKzFNoPyvOC?=
 =?iso-8859-1?Q?CC3gkRbJ20+f+XX+gCrXFNJXpysYJZ9rck9ODmTGnIMSO4gacuDeW+oMgM?=
 =?iso-8859-1?Q?iXf/QKcNgOAIjVnNObXmX2LoBYWeT5YI0bm2hbj/hbeVVox/jQk4Hbn5Mr?=
 =?iso-8859-1?Q?QwCA0fgl7vrEJ98bSt7MtvVpNi2hSKyQuk5KFHl7l33UgkpcsM4PfK2CWl?=
 =?iso-8859-1?Q?uT+NMuX5//rN+nZV1Ql2t4+i2G4M8BMRzg7bpKNWzb0ZaTVu2oq7Dxbsc+?=
 =?iso-8859-1?Q?2uUfALc1Z71O+4+9e09B5glMoVQEuxq32nDHYMOy18JgxGXcnVaPGxElrL?=
 =?iso-8859-1?Q?1KKp1ZEP/E2Jba6GAHUVHN0vDkofz7kzFlGL61EnYvfcD6+P6KfuQT2vO1?=
 =?iso-8859-1?Q?gvg4EehfBUQFVLjW8OJmB0FZXn0IvA3jTxLjz9RfVMiVGsI3++prswp3jD?=
 =?iso-8859-1?Q?cDzpfeosgZPz4KRaIatAMnAGtzvPP8yv4ThOMIq2Ua5uYteqq2jy7wYqoj?=
 =?iso-8859-1?Q?i91nSt7fp07v/G8y/wAGgRBRwwiV5rLEBjQS5wPCntOlww3PmizmbepYHM?=
 =?iso-8859-1?Q?QmT/cM0Sbs2tVQGd/KbsgcCIIBxUR3NiAbLm+C/GxbBx272KznMrtd7jwG?=
 =?iso-8859-1?Q?yFANfZNwx27UKXmxA0iPgrOJ6Z0GZZshX98Ep1Js5qGHk8HGrKezg0ykZ/?=
 =?iso-8859-1?Q?IYGjdaWNQA2p4pWKHc7JWkywR7FSUnDlQW5bUF/M/K8msuOYRC4WtrScY1?=
 =?iso-8859-1?Q?01CWs3lmIFFRPxb3ukzIaoQzEsjlDeQWhp5vK4H0AHJRNCopkT6utCwKLg?=
 =?iso-8859-1?Q?e+NkdFu+0y18G/OGN6ZTkGx6jA0ybE+fWozz0k1ai6OBKYtyuUNTGDs/JF?=
 =?iso-8859-1?Q?WzyOTvMzQlYKbr5jostUsVTUwdodZDv2o8Z1u7jlIUYLQqq3Uy74f0IN/Q?=
 =?iso-8859-1?Q?SRYlXxu4vLchPcteG+Ne8quaBc4GGMMIiCcZi7Vu2PoTSoqlrCVpC3GeT4?=
 =?iso-8859-1?Q?UV/zWgYBGIkBC3b8HJcpuQMkuctpzXwiSf6gVkKXb6hGFHiHO6pRYJ7v04?=
 =?iso-8859-1?Q?vEzjokWaRegEXEXZLH/BMW1PgBEZm9Hjht6quLQ77cMUZ0Q9K0eyVL5KSm?=
 =?iso-8859-1?Q?Fana39IW0jXg7RIUj92th3GvKcnGUXY1nf86JK9rHI9gphq11yvBQheLtJ?=
 =?iso-8859-1?Q?7r7XOx1mjsNj8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c61293f-9846-4643-83fa-08dc3dc9f5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 10:41:20.1726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQ4NI0A7Juli6ef22IGkIBZ4bT+JVSih09S/LgEwO1HihrQPsbK76+Q4IrhMwU/FMSKV6MLpxmLlV6atUXsbOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

>> > The structure needs a PCI device handle [2] that consists of the devic=
e BDF.=0A=
>> > The vfio-pci device corresponding to the acpi-generic-initiator object=
 is=0A=
>> > located to determine the BDF.=0A=
>> > =0A=
>> > [1] ACPI Spec 6.3, Section 5.2.16.6=0A=
>> > [2] ACPI Spec 6.3, Table 5.80=0A=
>> > =0A=
>> > Signed-off-by: Ankit Agrawal <ankita@nvidia.com>  =0A=
>> =0A=
>> One thing I forgot.=0A=
> And another :)=0A=
>=0A=
> It might be nice to also support x86 from the start (apparently people st=
ill=0A=
> care about that old architecture)=0A=
>=0A=
> https://gitlab.com/jic23/qemu/-/commit/ccfb4fe22167e035173390cf147d9c2269=
51b9b6=0A=
> is what I'm carrying for this (see below)=0A=
=0A=
Ack.=0A=
=0A=
> We could do this later as part of the generic ports series (which is also=
 on=0A=
> that tree if you are curious).=0A=
=0A=
Yeah, that sounds fine to me.=

