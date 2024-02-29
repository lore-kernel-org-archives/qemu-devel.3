Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAA2C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfepT-0007Ib-Ex; Thu, 29 Feb 2024 06:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfepO-0007Hg-1E; Thu, 29 Feb 2024 06:43:55 -0500
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfepL-0002ZQ-KK; Thu, 29 Feb 2024 06:43:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzc0ypc8dWQgXsYWzRmdUNsaTOASN0LlQc7UVGHU1yGduCeBQA2hwweMhhjkvM2ifie1aD7tBsxhEtheEaowDVRS5vqtB+9ZvBLHu5/aWEElo3usJkYW2TPkgxCwQn2vhMpE9ZGC0xq5yeFxg4ILhVuY6HHJW5Z7pfs77Dpx6VzU5x4Luw1jv1UTfEvQ/Fao/nNm3CS1dt1wT4k1rXbOcaOdTyWoVyBG+mKMSxFyWZK1B8aC8Ez7E3E5Je8UgblxBkZfVyS+niyrD/9y75xRGqVX3/sOz/n70/IiuCLFQvR/NDYeE8uUL81BHc/t+VWz0LVZiwL9jmqFoiii9RTx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaIlKOFUay9tPTF9j+mNvghlSx1MmGw8SQmOmlDnnt4=;
 b=DFeqkHYXSz+kVZ9HIvD7Vs5ugUARmdSr8ezreX/BcKYv2SXh8KqB9RLompC7hx9Ub9PmqBgxP0oDfOtAUh4jt+ZGkLLa//l0kMm3Oi7091zTJLXrQ3YPCZ1sQUg3f7EBZu7J15ygFekf3aVF00r7gScn9EcTUN6BzJPLGlegqhNQUF/rIXu+xuuwF8yoSpMzIa8lWg36T8AQbrSgkIfiMacl4P/8GaO1G4L1Pk9fahSpnUTvM2xkTxI92cWpgqKt3LQQGMhfAQPCYEBQryjznQHPK9lifXggr5WKRs5eXq6IGwgIe8CgGALGhqW/Gb/rlsgUHwBfXpvC/rQwIId3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaIlKOFUay9tPTF9j+mNvghlSx1MmGw8SQmOmlDnnt4=;
 b=WLIEUBwoVP13TSnwK+XSB/cQS79N+rLgYscUc4mZee6WorzEf2lYkCJfu8cxh/q2ZMgkFQNtbmCLjoongJrbl6Ix5RKu0+SfJaGI0g92HXinLBbYAJJ9vcMHTolg10Pdu8vxScHHSNTUL5LYWVnBd4tUcJ14ds5LpTna5N9R6NjF47uyc9VU/yZZsMtNgPmpnHT9p/GEZGUi3Daxc0t7KldALcGmLjJv48hCcdHr9ytZHBPHMfXTM56bPmqK2UwlQJ3MFsyHEM0t0k1XhVUpfvu+GhEBf7TpUE4i35/Y1dQvj3HGGj1F4UMBSUDyXj+G1W0B5nFN16G+HAxi1FRBYA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:43:44 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 11:43:44 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgARh1QA=
Date: Thu, 29 Feb 2024 11:43:44 +0000
Message-ID: <SA1PR12MB7199C32D46CF39363F38D2E7B05F2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
In-Reply-To: <20240226164229.00001536@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MW3PR12MB4491:EE_
x-ms-office365-filtering-correlation-id: 730030ec-638c-4485-fa3f-08dc391baefb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJ5PJqO95bT3ANoRes+MbUiICe2qcXPFBl8qcaKWvdkk4sEMhrlQVi2dCs3yY+NVwQoLG+LnvOJBs57LJfR1yqlNKaNceZUmKNhuG7FZt8RuhSaxW3Vq0sSS7gyWsyPBGi9eRgXB0GeedSoHTxfyph16ZDkcd8rVRUek3NNp3PyhYPv4K/h+ldm6rnnJNv9Q3b1sxp3mV7PMY3zrhBwv98YS6xVLi3sQwo+ZOZnht2RZZrNCAnhcJlKceIgeL0T++gOL3eJi1F5KhSBtA8pXL7vdm5NYHOYrVQRV3G/z6PDEXLkNx/hquVgHb/cU/gcgoVt7CbCab2qxPSFHXvfp+rlG9C42yh+NFxmN71naeJ5Dw2rcEb0J7YgFRXEgdg88nhiEUJnVw80baZKbmESi1e+5wBPcU0JQ38vuhoyckVneX8m0RL1v3HUuM5HnNmI9n6YnnUhO9l54hHkc6ME6bzbtV5BXt1NbHqkkBBVRU05BPK4EkISDCneWivUUHzRmOPqX2HWKcYFp2cvxJBMlixIib69uJNmr43gZ0KSrRnvwf/xWo5XAxfMbHaEaNCh1fgA6VXqJrmYL15mI0s/TqwErxKRv5QHDuRzVvD7IDp6i9DsMhrk3HaSuJn7zCspeMINMrfEzYss33UjOj0WwjbAm09PBG/hqfjLezQnF2z04uEOkoixmxXWfsgXa2ByrAw3HKKVG6RDOXqxwIbB+c5uQYqJP2EUGpMCLj9U4yXE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NDmGiQmCFcAL5/eaIKZWj3Gwe/x/vQ9Tkan/T//AEEghJvvnCOW90MEH6s?=
 =?iso-8859-1?Q?jKQHgv536tiaxhxyvkb7248uCHwTX3g5khixlYdSJ9ybYpwhLmlueIAQp5?=
 =?iso-8859-1?Q?vCecCqdohLqkmTAfXMNNyikeHkRV0EEt4+fmp/XTlsf+Tx3XpjBxqM4ePq?=
 =?iso-8859-1?Q?J/xcU3BkcTm3ZpVlEiz+Kw4OlV6oeiQO6l9brbdDCrG7S8MuyfZD7xVCTy?=
 =?iso-8859-1?Q?tHeUEBwcvoYqDFoHKhE32nseuc8MsqYkbwaMPa8+Kg5QWG1WxVsTa26Vmp?=
 =?iso-8859-1?Q?6wv3jgY8bGI7BYHsNiLlfOhZhhN1uwQw2w/7OKGRhYCE50Px5TmoCjrW2E?=
 =?iso-8859-1?Q?zerEEy1I/bib43GL7eplnjj0jqHPo8wVWbX6vmnIxcL3Vl+aP1hiFkvdP2?=
 =?iso-8859-1?Q?ivhK4KDVbS+zK/4nuzlvUdCDB1d/qEuJA9ehp5JbVrNNX8UQT+CPZ+sMjZ?=
 =?iso-8859-1?Q?4KRqqaFB8g34YS9SPrh5TUMQ5RyomHE6EhzYxG8VSBCFSrtNm3kFn4p6lv?=
 =?iso-8859-1?Q?oXCB97o9VjsR+qV6jEZwfrBW7suj1MVso7aGudc+Z90mrsw4+Gfj7b7VWv?=
 =?iso-8859-1?Q?iupEVlwB5jWQwDifcDx/ysYvvjq/I6EJ69OF4BiLpVPXVE+N2tf4TPoaEh?=
 =?iso-8859-1?Q?9TDqMi8g8sWvlLlmmas6GuOENC7n5nsmMBpd0XNgMkuHNqjI5zC+DVhmnF?=
 =?iso-8859-1?Q?8hvBgFsxx0IdWPeE9CIXi2TnjoXAWqfVUHmnopQnbGOkPvg9LcF2quMWZD?=
 =?iso-8859-1?Q?AU0sLgWyiznvq4DqSHiHH2Jfucaq8BpS+9NWs7RzNlB9t4Dw9dchg5SkUx?=
 =?iso-8859-1?Q?mLUYUC/VghrGdlbwnxGoace3HS8O00wxo9L+JNrIAVDHAQtQIamSqFlBXT?=
 =?iso-8859-1?Q?0/4dmX8YW96R12Ke5lWcuCngJ+Toi8++WwOoTAf/XkxJSUMJ78WL6svDz2?=
 =?iso-8859-1?Q?u1QEq77Ly8Bj0PLuUZF7DvmPNYTaH+gJGz9l2MiS1mI9qFkFC9XVavXaEN?=
 =?iso-8859-1?Q?oLJoCNG/NAh6E1ZmXJ0+QoCxBS4j082svbYV9cj+lPKUjJioo3Nb8D52UE?=
 =?iso-8859-1?Q?k+ZW6cyK4bxv0mu0tgRe0J+dp122k9ohg/OnEgjYHR8Q1w6v4p5wgw80Jc?=
 =?iso-8859-1?Q?YZX1UY7BJ0jkGMGwo9SNMcdmWy/Ewis8314btAzJyeV8r6i+MNNm72/mjJ?=
 =?iso-8859-1?Q?fDOiqxZgooeqjsoUia+u3VOq6+QltkMeUuIxTEsDifLYBetfFZJdn41cjw?=
 =?iso-8859-1?Q?f1DzdrfgiDEuNXRpQU+YpK6OymrONt+np5M2ZteaAGkgmBGDzQtG7/z8E1?=
 =?iso-8859-1?Q?GHd3aOna6g2BRpiXWNxxEb/3j+rPKb6IaRRCKAeQ69Msvd8HvdbgmeEPWr?=
 =?iso-8859-1?Q?O0hbyO+ZElpmePaMeMYHE2OFRVifQiehOloTniegyD8hAloPFqo/nJe26c?=
 =?iso-8859-1?Q?XMDZHUfhFU0n6djCgh6ByoPEy/WnLrKiDp6md5lACA8XgC8Q3g7OwCgb0M?=
 =?iso-8859-1?Q?/8L9tTeGbtzo8Y2A+rNSYHugsGKt6GwbUamm4XOt5LjXzPI5yqFAFWnkwH?=
 =?iso-8859-1?Q?TZ7FHjkVk4/yZLBWVvarh1/qRcdklnti6Y3HeWYjPotPq4CUjxcblKOLh1?=
 =?iso-8859-1?Q?25KbI6fvbJW3Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730030ec-638c-4485-fa3f-08dc391baefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 11:43:44.1791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ba6MzlbhPBwsxA0BmfNOyDCo/NFx35dehVuTt62nLfPhnR+D3VD9XWnT0yjW7eZK87CcJOjgDXyhMGZLGYp9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
Received-SPF: softfail client-ip=2a01:111:f403:2415::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

> One thing I forgot.=0A=
>=0A=
> Please add a test.=A0 tests/qtest/bios-tables-test.c=0A=
=0A=
IIUC, we need to add a test for aarch64 to test the interface with the=0A=
acpi-generic-initiator object.=0A=
=0A=
> + relevant table dumps.=0A=
=0A=
Sorry it isn't clear where do you want me to add this. In the git commit=0A=
message?=0A=

