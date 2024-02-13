Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D6BC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 03:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZjWt-0003hU-2t; Mon, 12 Feb 2024 22:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rZjWo-0003gf-I7; Mon, 12 Feb 2024 22:32:14 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rZjWm-0003HO-MH; Mon, 12 Feb 2024 22:32:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrX7G9v4ZY7uAE/2akVOD7AX9br45zz5umcpc71PISDw1HUzFq9t8qXNAG1pmLLbb6FqAXxl8lrLwmbCLitQnUM4UafgNv37CofDvZ5OaYjZ0Pq9bNKcv8Dht3oizFmIY4Kbuc0PAn8nAoIWFfQmmg/Xn+F0bDlZjPkonJOz+4ECNJDsIwQDwZCTdX/XkAVhco57rAGQu2KcoBGpntkk+I/1gbw0eWRTby+JHJcLkghWWXI7FmcX9m72yZkdR2bBrwtnDirQ0kD66ejMCUBREp6Pk9xkKIS2cWIBL9lYYwEFijvJXAGQnDHtRTKCw7EjOGRxfljhM6s/rhsc2u06pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCqf0s7oUQoWcdN8l6JIENB2DO8QqWdZCukbBlRWUWY=;
 b=NEX/wGMM8YgYF/S+gnpPFrwG74T7YnUEcdlh65yPR+LduHxgbaDhAJKoNrTK9b7a09HEUgdECebO/qN7LIqv3O3q2sDFyeQNC8EPJePcdAOXjxpR9EGJJatNywwu+fCFFyU6GRILcbM+bNMrXvFJWnyhzyL7ANCV0rAdiO7iizsPnAHfwSvWT00G5jnmJoR4IZcw8xZPBeVx0dSM9QpRHngmGrIjtRXfqKceoLAMyFqB6g40QlNJQZx+bCoQ5xEULaOZ9MZDNBswS4GL336GDphb/ffln0ChOpY259HY+23AfmmQhU+MsQqpBC0kJNsWimIg1FHXxpvia7BQ60N2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCqf0s7oUQoWcdN8l6JIENB2DO8QqWdZCukbBlRWUWY=;
 b=Qd/AeEhs5U1gn3G2q9PLL0DOUzCjqb6n1zU0pMOOcC0DaFaA1+4e96tXCXL8+fzvKSj4W/BxblwhqsdErFLAK97XXbUdf9q0DwI80xfDWVrf9HLYsjtcG3Cku0yQJSi5RO1cm4IrFFnCzLGzUm3oRvmylk8surv40iEz8+W7qUI5vWs0mPgkQh1Q32ynEwNc8Kew0GDSXKPrfvXgC36RmbDGZ13TQSkiL+pdkgFN80uLimTF722WAK53ppBxTM0oy1BCed7e9mls1iasZKQGzGBAgjpTyYDhf5vHjei/cB+jpzEn3ejv8SyuDsyIY1x/oIh5+NxRnmcaVK+oxNARhA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 03:32:07 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7292.013; Tue, 13 Feb 2024
 03:32:07 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>, "eduardo@habkost.net"
 <eduardo@habkost.net>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Aniket Agashe <aniketa@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun
 Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 0/2] acpi: report numa nodes for device memory using GI
Thread-Topic: [PATCH v6 0/2] acpi: report numa nodes for device memory using GI
Thread-Index: AQHaNu672iZ2n2fqDk6q3KiBRYyGcbDGgWuAgAKGIYSAPiVFAIAAvv24
Date: Tue, 13 Feb 2024 03:32:07 +0000
Message-ID: <SA1PR12MB71995CE9AE5C9DEBA899CE0BB04F2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20240102123143.00006486@Huawei.com>
 <SA1PR12MB71990557668BDE5878845A8AB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240212110526-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240212110526-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|CY8PR12MB7195:EE_
x-ms-office365-filtering-correlation-id: 4dbf9492-f894-4132-fa5b-08dc2c445ad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JX/5zlUo9aIuTDBD7NX8B8cVqkMR6PlP1UmbGVPlGcVM05ql+itrSP5R8Gm7FPIFMltsHCpVhCc/6cJI2DM155bQ4F0dXXQFgxBSHKbNEYFiW+aR15ZhsDzEKR0zJb5rsOhqyTMmqsJjZlRJchxsAm+WCvUY+JDqvR1AHjAsm6JWD9tY1YO958zFfh7cMRRXZ/JGutJR/MECT6wz8uq2QgTXcJ5F5KHD3WjQPPPhDSAc2L0RnIdBtcnJkJlQbSOCL24GCwGl97PoOBLDVb7hIeDVlPtmCSO+yGlumInIarc5cHH7KH/CCfgrJQxF4n9YO6M8Maq+pPn7X+HocTWR3mVLY/qp6qqFBUjllS0HLYQ9ToCk+bC2DDTJZQOkyk7OcEP7nUgzZ9o1Kkq36OE8XV/aDuXl6VDKhmo6K5DWWa+S3c4jS6zoZM5zJCKG+QGjvW+0NqBowD0bRpQ1Qa0TdSaIWo5odUGb1ryOnmMUzL+exp7pSUCOXktWPgplZJgrYMHhD6Ht3otIEZMjKhQ9/3LNh1JXuzqz3vEpmjAx9AyMiQRcB3OEc7ByOM9bv+yScuqAU94CZ6btPOD5ib54yFrJBzD5CGlrrgfmFvNcXJYUHuHqJE94bBMuD6ZATJKE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(478600001)(71200400001)(86362001)(41300700001)(55016003)(52536014)(4744005)(2906002)(5660300002)(7416002)(316002)(91956017)(76116006)(38070700009)(33656002)(54906003)(66476007)(66946007)(6916009)(7696005)(6506007)(4326008)(8936002)(8676002)(66446008)(66556008)(64756008)(38100700002)(9686003)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y+TtkSAyBL4W8v0THtjrcZZWyh7idr9iWZ5+TMMZne8gqrVbze3RA2bf87?=
 =?iso-8859-1?Q?a+nUWtFwhZhwxORHKJ5iBmihNGli2A+fXwpYTVE9UQTAKCw0EYG8Xp9Ox4?=
 =?iso-8859-1?Q?GAgcWHgWFnRpAhZZexfUd7Chnf7OIWteNHNuu5najDGKbE/MpcxdfKbMut?=
 =?iso-8859-1?Q?lc7YPFRDMtkCWZUnc0gW2QQcwodnLrn+Tj1gYJRdbHAEGf5x9Ayo6X9MaG?=
 =?iso-8859-1?Q?Q1qvkW+wLNESDXp9mlul8iT7ZPzPBHlnTciKAo6S5fmlUCc+ml3Ej3Tspz?=
 =?iso-8859-1?Q?EKKa9vT38vSBB4aaz9bc5wI74JUKJKZLXBxKNPB7xZwbZakxt19hPI0mFp?=
 =?iso-8859-1?Q?jGhCx9oJYI1PkQlsnj1LE9OsoS9mcnc4urMT2aqJ1rWViE1tw/jZ7J4Fgz?=
 =?iso-8859-1?Q?Pv+BhiyVHCymxyeq6Mtv74g/IujWTQP0U9bPYu5/ux1ThBTqMM+F7BDMPL?=
 =?iso-8859-1?Q?L1ooEfQjzs0sJW/8oa9xsMZsbpjbk0LQeCxauoyXTD/5zEsRI5A8gpH5k6?=
 =?iso-8859-1?Q?JJmLY4IqrNhmS7tfVQyDMb3e6dlAvTHVy41X/l5AnlMXc6s1fZLEHO++wm?=
 =?iso-8859-1?Q?w6l0FuFW2ZmV3w/mqeWH1+9EuHggmQNgWbff4BMcqEcvgl+u/f8sCWbUyw?=
 =?iso-8859-1?Q?O6JQt2M97Rxvgad9Dp2mIUKPMxDNKh6sc2pr+lpkLwgA7UEcpZ1iPzt3Ok?=
 =?iso-8859-1?Q?K8Tycz3An0ZEjL2r3k46xrS/MJh+nJ8I1dr17HJzIEE1trlqzQE9wn9q2w?=
 =?iso-8859-1?Q?R2/G/rm9Xp/ebG5oi2HqwUKZr2r4Dkxv8ENFsn5tRL7LgnnEpg3ScHvLVe?=
 =?iso-8859-1?Q?WwSZI5sPY3f/Si1SCUq6B07UB15Rd6o4cZGrzGhJEE1yKoVAJaw2QQbkaQ?=
 =?iso-8859-1?Q?wLerH7WqbPlzPIISYd4WfB12O6csliYNTNZKThN30pZdcShbGFfZ1buvK5?=
 =?iso-8859-1?Q?QNV0beoOayplCVl79v119xYbhBgqP/KtuOHHUBfJWfLmuBflJKxhaJOvQO?=
 =?iso-8859-1?Q?LAPu18ZVjwnI51kFO43pRQdu9IGiK3unE5s74XOCxgMMFj37yY8/do4ZSz?=
 =?iso-8859-1?Q?04K/oydIiyVxXefHIF7guvOeEBfJSkICfghTrJozdPJnDt7Yuxs3FOPkbc?=
 =?iso-8859-1?Q?mgNmlGuB0dLYZU3dVv996AbWmFwsSPwnngfTpapYcnpaMCO+Sjc0JEnM05?=
 =?iso-8859-1?Q?CfQ0ry+Fgw2uNVzVwKz9Obl7ds9Y9ux8F6hqoKVfBWL56O/fxUk+uh4s+f?=
 =?iso-8859-1?Q?TiXW5rP/mjR/BG54OdB7n3fn0r31isdopN7ICY4pjF2z70dPme4CiNNqbO?=
 =?iso-8859-1?Q?43curDl6uogUIqOMsua9prbGnP3SfLc1ZQYqDOQXnF1fAcCI4K8IYpC367?=
 =?iso-8859-1?Q?yIb9ky4yT6wrc5tuE3X1pQ9CpEQeUbI2st0NoZu5yKOtrFENUWqDeqEe1k?=
 =?iso-8859-1?Q?dJcMR4n4v1GGvSywPLxDy3Hu7jPBqmCYy/1l9COcoSrT8n0J55FJ7yOtlI?=
 =?iso-8859-1?Q?Pp+C6hpVfAiZI6Fm3wbFj3pNLbQdyivRyfnY3Nh1V1j8KpHH1f+wsdX1/V?=
 =?iso-8859-1?Q?4JRxmuOnsRO/7gFeYA8QaXuwSINjpy/23cDFY90Rm95LrhhyTMXH9IbeC1?=
 =?iso-8859-1?Q?uj3woflt4MKf8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbf9492-f894-4132-fa5b-08dc2c445ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 03:32:07.3017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtOayjKUx8s+jJ7KhUxoZTDYVEdnMVzmPY+DJaBMxLiPfvhrueoWetnnMQyjRjHv6B2q3cDRnN6BVO4tE0wC7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

>> >=0A=
>> > I'd find it helpful to see the resulting chunk of SRAT for these examp=
les=0A=
>> > (disassembled) in this cover letter and the patches (where there are m=
ore examples).=0A=
>>=0A=
>> Ack. I'll document the resulting SRAT table as well.=0A=
>=0A=
> Still didn't happen so this is dropped for now.=0A=
=0A=
Hi Michael, does this mean it is dropped from Qemu v9.0?=0A=
FWIW, I'll post the next version incorporating the feedbacks by next week.=

