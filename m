Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AA3CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfnI-0000bK-DV; Thu, 27 Nov 2025 12:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vOfnH-0000ZG-5E
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:28:35 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vOfnE-0000aT-H1
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:28:34 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ARFQCG71609276; Thu, 27 Nov 2025 09:28:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=r33ua3sgx4EvE0q
 Gaqsx1O306g7Cpz+ms6uI1Wk+aH4=; b=0Dg9XWYyWVs4OcsMzrMFbu9OOI5RWav
 hmdu3nFS/1fCXjeiTsv77HItnebi5yt0jJ5Bh1ft5hVWt4q8Ff4zzF7MukJGAMfq
 Kec8ZlPCeHSMBNofupRi9lRt78JXv0gP0d7w37MNfis2MY9tqlqZYd3FeN0EHUbX
 A4iIudpjtUIgQBfzC0bZAxMeSjqAPShLg9EcHIAyD7YWtbml0rjhRAw6Qj/jzkjX
 hyZ0E/MiZGHpD4SiNjfPpVifkIUXW97cHxgQ976eGxOgx8XE4whyysZ1KtotDu0B
 x9YC2dy2LeP2iFH5bXDDSQM/lFgq6jZH1Lwx0bG3avENvGFWSlX7wmg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023083.outbound.protection.outlook.com
 [40.107.201.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap3q2jpkb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 09:28:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sq2D9LQG0/82o1KX2V+uZEBDR5Qq0UVPsb/cEXCGgID4D8xHZ5I7lYL3y1vJ7wsTo7wf7TWLORpUq4sWEFebvQmtRWzk0WgiXWTanoCHnBpxp6oTiX5pirKIaxqfXeFGPrvFTDGsnAxMS/dj0BcxBVmeyL3qzZnwIyd+pRMKzhX40jlI8JkleEtRIWdxfijePwZAoh8R3O6XTqKqLImXlRRB7qX6AKMI+tTABOXqyp2rmcHvFWLX8OE7VXrrPt0D2sXomnfodqEdtHp6/qM7I25U0NeVu++mpONOgvrKtZTFTiIkUdkG9oJldVcGdqDdOmHWWFTPsWl8yODTLG/+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r33ua3sgx4EvE0qGaqsx1O306g7Cpz+ms6uI1Wk+aH4=;
 b=m4uQWDax3GCX0MpAA2Ej/78AtQWQtf1m1d+z36j4gbdU4yZ7CDRA0K7NzQirkhIjCxTYUYnUz5Z4ym7QrFi+xy2ylePSiZvkSpTQmt9E1Gf9NsYxGPuAYbxJUPK3tVe7JsgkOvVZBP7JyICMIh8yA8tU1Z+cEZ+w08GzY1DbT1bSICx4kn1xQPvMRSvkTjuzaWJNIa0ZwMkj7MncRHjZJf6fDcsbZRqaeBHcR12hZ9OcUZCIHrK8+Abdzy1ritjMvqN1HwOjBdoNvSIMuScItKlNOUmOJ1m7W+fmshU+fUjU179oi8m6Tg8TEid39rt8xoF0lPsRt8DwFqbY1OtPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r33ua3sgx4EvE0qGaqsx1O306g7Cpz+ms6uI1Wk+aH4=;
 b=lzlN2635emuPSn9KFnI1rjZN121zrrFzyCkho+z2BMol1Z0QVSjqgeASADJM/iXJkE/bz+M+WxQ5fSNYoHU956GRsvCEsvsAW0cbpap00zFJSofrHVi7XGAUwyRrpEG8R1Jn8AQrkYJdsFXyRStBwX4h676FtRhx7B4A0leJOFnJMFCG1Dn0Uqvej0z5Zx4y5Bml1P4FY028G2uBj8PP9NWJuTMli98vKw3OgsnhhuNTli5H1rnJk/pzb8oyxUPT5yzSWuRmag4uVGbJIzPxokzv2H/OfgsnDfiweai8zsiPR0Gq1f83yl2vAhytXvvMbRVFTmnVF0lIBq0/AnArHQ==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by SJ2PR02MB9365.namprd02.prod.outlook.com (2603:10b6:a03:4c0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 17:28:20 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 17:28:19 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "corey@minyard.net" <corey@minyard.net>
CC: "minyard@acm.org" <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>, 
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Jonathan Davies
 <jond@nutanix.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Topic: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Index: AQHcSDTcGtSWPs7JF02v94olU9TuQ7UCeIaAgALzN0KAAYZESA==
Date: Thu, 27 Nov 2025 17:28:19 +0000
Message-ID: <BYAPR02MB50299142D5928BF994E3702685DFA@BYAPR02MB5029.namprd02.prod.outlook.com>
References: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
 <aSTF7QFuXGhNzGce@mail.minyard.net>
 <SN6PR02MB50384A7A5B522A5F58C444FF85DEA@SN6PR02MB5038.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB50384A7A5B522A5F58C444FF85DEA@SN6PR02MB5038.namprd02.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|SJ2PR02MB9365:EE_
x-ms-office365-filtering-correlation-id: 320ea499-6b81-46b5-8757-08de2dda5b73
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gz305E/3JM15guTjNqjKoHlmxLpTFzWyHDJ1Q7pLkUXa52hqQaNedFypM8?=
 =?iso-8859-1?Q?ckCbmryy+Q927YzoBzWbaed3HCi0BKhjUAW+y2ZAM6gNTczLxLBneDgcoD?=
 =?iso-8859-1?Q?qK6orHmF+DCVQzD6Ftw7zQTXflp8+5M+/rvkqPLFKqIHec0kLjYZJ41QLu?=
 =?iso-8859-1?Q?7urgTRNRZMoJJfwokSiq8pzcRLYKLlEeHXJX3Dwo7q+NNtfcueiDrxReAr?=
 =?iso-8859-1?Q?nSii4LVXcNSv+gEZKtYGUUdQ2d9A2yzt2ydqvhUHOt3EOPnYv3v8a861uv?=
 =?iso-8859-1?Q?ud27K9x1jUj5WofbwVuNsQEry9vim1oDJJ7Y6WrSe9RjHMVKorLjfXZSZw?=
 =?iso-8859-1?Q?cdAbVaYGFKDgiMeGGch4c+eZ8UtPW67JW03OYfY5+0sRRNOJYnznwaI9VI?=
 =?iso-8859-1?Q?j1+XjRURzRwBYBptyT5WOdOHhUyA3GCWnf/5TvzrGQR6HPxDrwgs2Bvujh?=
 =?iso-8859-1?Q?Nhfz1lCH1CB2oaDKVwV9uLpAtmmcxfaaaT9VES7I2TFazYWJenlXNi5ryY?=
 =?iso-8859-1?Q?30QiF4j88v0pTSSgiu0GxuXW0+f3J8WiXRRhykPu+YuavgLc2ucd/NbnNG?=
 =?iso-8859-1?Q?WvREwzXhsARao5YuYrBYEqdechgg52Lhxjq75djoMJKCOfHC6wfkWsV3+B?=
 =?iso-8859-1?Q?xlP1vIfY1C/obW3O29qxPdtK+qaPDCR2hgoJtPRG2NWsA1VQIeaa15MJMU?=
 =?iso-8859-1?Q?hlq2uCraJIaPaEOpjJyyxwj79ThxYmf9YuMr4ESRhgWfZ6UmuXTd49hT2Q?=
 =?iso-8859-1?Q?vcTfkLBMbHm/c638dlJRq0FiRWdof1bhfK3njBRfkAKj6jGyZ7t/fg4S9w?=
 =?iso-8859-1?Q?KxHHl7ZqUgLVWzx33nN3MAaAf5DiEmF3FpYwA380b0igq3dZNRtiQ97whI?=
 =?iso-8859-1?Q?q6vL0cEmlN1DT7DUSWB0PSeSV3RZ1H8kn7WMYSnAlaOO6HC5+IpZH9yAKu?=
 =?iso-8859-1?Q?n3cBdAcN4OizdFI93XGErwdiJZRgb9D+yqvuN9s6CcA3pOM52hElD9wenB?=
 =?iso-8859-1?Q?NU/rGPOTG1JgKyznpUtb2DI7Krei8BgG7N3/FD9lPn4ew3d+E80zqcmttV?=
 =?iso-8859-1?Q?MCNFYDlM6ADTL0M/lohkzJDW5iojCCJ9F1t5i1K9aOpu6l5l7Ag4BfBGTk?=
 =?iso-8859-1?Q?m68BV24j8JGD5EWmYDL2/DyXb2QSv5IH0JJ7mvqaP2uMzqARWaSNGw2GCl?=
 =?iso-8859-1?Q?cJV0N+jHDKDXHeFoXwzlZWrA5IxCa7hOme6kH3eXhL8xSg4MepSWi9F+aU?=
 =?iso-8859-1?Q?XtgdH7aL+lLmWoRU3Mr5h769EPsSeYNG4DTonyIhWGD4KASWXTruERr8vx?=
 =?iso-8859-1?Q?XFYzsQwwmLWpA3fvJ4UUTKUW+4SdS5krFzKD7iXouwHpyqxuy7FVAZNVPg?=
 =?iso-8859-1?Q?7U6oW6oqUeOTA6NYw6ILt2xfbtHVhzX0lOIUfAa2C5w8sM915Splpy53Es?=
 =?iso-8859-1?Q?S/4wQKNJtG7uc74u8iJp+BcL58bBrPpN9RUHfisb/2+llARZpI5NbTHJKr?=
 =?iso-8859-1?Q?7ttAXy7QCxQbHuesltHH656+3x5faYxalbi+ox9zvtc+NvAQm2qdhLcHMX?=
 =?iso-8859-1?Q?UhW3PJAGusFTYeTrRLWFMpI+d/v6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WvIZiRFFJU094Lw0gAgUup0vikjkksnzqazDNeCCbFYo+rU+4bB4015xxB?=
 =?iso-8859-1?Q?+Nz9OmRkoXc1ZDSYNWxiPiJrkRfEZTD3Wx1pXLb+WMXKSCixadc2uMr0T3?=
 =?iso-8859-1?Q?acPmeXCukjxuqKZTOCyCh5p56EHxqw+RKLebHD6mJ9V5/M9xrhpNrPDPtE?=
 =?iso-8859-1?Q?n/njCaKkch82Ms7bcUhnI3CIo1vcVAaRvePWohOmo06qifPAqvS5+CLSRW?=
 =?iso-8859-1?Q?+WNIIFyORzAh85pGp5N5Ykdmv+pLHhsuZf72WygFIEfr78fR+BBUP1AHzw?=
 =?iso-8859-1?Q?JiLPIPmHfulvY+bKSiM/4Ex9B8I/0YIKrPzPLGOhc1V4nt0L4pWkqZ/WPn?=
 =?iso-8859-1?Q?Oomdy9jojbbJey7wCex8gjFAVd3wIR1rNByOs7R6BnQ98fOiFyKhMXVrfL?=
 =?iso-8859-1?Q?nf1yXNrZKiW000saBZ/esOSA9RKXT3aaaBIESAv2s44vHqjzG4bsI1AqsX?=
 =?iso-8859-1?Q?7adTmCIz2P218g//u6AppexEBeIwipZe0EKKAb4nF+pwO/CZHvfVCQtXc0?=
 =?iso-8859-1?Q?S0jms8XVsyfpet5kONiYuRRBEJdGb0S21Y9mhtLSMqA9muhT4auXemqH+e?=
 =?iso-8859-1?Q?t/+ulhv2ZvDpcU18SGtsrLjTfXXoble+X+KE+ULwfs1fqBLCI01kQzbTLa?=
 =?iso-8859-1?Q?DrcRVfjATbNZVnEKigko/xXNKATLpBFqQtxU6A/85eJ3gTGVeyyFXLSv0Z?=
 =?iso-8859-1?Q?lKjV0ci233AFvSTsIZfsR2BILe3FjZiucKo8XKMXUvMmW6uIRZ2RZw7dtR?=
 =?iso-8859-1?Q?7R/VAUj3eQLeo0xbOObhaxP6ApV6i0R2MiAKPkcAEQ7s9hHQpZ3h84gJI8?=
 =?iso-8859-1?Q?s7REAmej4Jwbg6HYhEpgr72j/jXvqgKHZ2UEXNI/+2sS/F8IpXq3/0pIXD?=
 =?iso-8859-1?Q?/mMIsGdnlxtEE9uz2o1YE3olJdoKdB//c3xNwUgIDdGdl1uh3PeMJm/nYq?=
 =?iso-8859-1?Q?BBTDEGibdICMEPtqHxg+u6pFPW89LhhRlLVOyH/FYx1/fHVdy0NUE8p0wp?=
 =?iso-8859-1?Q?te49C5j75HRXjX68n/9mjhvnw1v62zWz1BaE/nxQhUnxGOXAjIVCJXd4ew?=
 =?iso-8859-1?Q?wVcMKtTtnkpFyFY7pBKWi2UvvAwVaIm91G+psPny4mzZTIWbDS2lRMdg7C?=
 =?iso-8859-1?Q?LbM9bWkv0L3sPv8xe8QQJj6MfaEo0acPCLVqXEvVLEBCGS02rxAxiRLYcy?=
 =?iso-8859-1?Q?//Iz8t9NgLdJOsgP2N9Q5bVMojwz/qZZdWPpQQp0vhh9QUQ3bIYyvcyWi4?=
 =?iso-8859-1?Q?zfM3/MBk5XzA4mtnJPAJpI/hVfuubg2l1FWNUSo3J/r65WyG48ILqnGJZN?=
 =?iso-8859-1?Q?J2jDz7ThuD4WH+b7A4Dh//diWcFZwgJa/apB7UqWX2ygk6FcrP5iIxYOWS?=
 =?iso-8859-1?Q?rJJwN2VImzUF89mZhR+tSyDz1YqAcC/WEAjs4ULnQLW4I5B/8Ow11wqnWD?=
 =?iso-8859-1?Q?28OPlmG8xLE/GOwpMNPbNiT7zuPkT4mvINmsamJFUcVede53UoCsZIbzW5?=
 =?iso-8859-1?Q?4i7Cy22itqTG7pNbCCq3TsNoSdU5SxAr+acLzwXl71YDFLTYf3F/muuXcH?=
 =?iso-8859-1?Q?Mo+tIm3c78/FD37gsKLtQuoscObis7Xq3aa22dVNkJXIy6FbrnNSeYrxJ5?=
 =?iso-8859-1?Q?qwB8gw7PgBH3cig8AIjTVkP/MYZlUZJtqw?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB50299142D5928BF994E3702685DFABYAPR02MB5029namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320ea499-6b81-46b5-8757-08de2dda5b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 17:28:19.3361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BygJOaDbp3ZFmVJUcj60jVU73tMEP+OTEaY347oXRPfcDLSR43T66aZzjd4RoxXifh2mqWCRLpjv17flfd8SVLpWU39EUlFqupybbceguNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9365
X-Proofpoint-ORIG-GUID: Q4Klr4Bx5XJnpkScwAvVT8Lqw5tHEglw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEzMSBTYWx0ZWRfXzDKMKDsd2EcV
 MJxbhRUIytd1mKnq2vNXkMfY40tLcCVsZngQ13tlljSKgkVxcWqXEiF0PjRsWSZwY2Gwx8Z6LMc
 SVZ+PGcLoAvdL7OuzR07yCi/Y9rTs09nlLaWpKY6+H61i3WuVtXP0bm5EEtB0Nym+HaNg8w4cET
 Jib4fsKYQBORGl5+L1sQOqDH2WXyGxN/XrwrneWxSgZpia3ewVwuZLfVGzMJddggYCa/Ft/Pj/R
 KHLnF06klQuuch1Uvcse+ywlht2rEffQdzJ69Omp+ogi+FSaPC3YNq5xq7QSWm+/panAUQteHPM
 8HtQNusMAGhbTs5WeKIZfZsbehIeRoJc9caOKgmIQqofp+FgLyI7fGhRoMB7WgiN78OXwXxK9FO
 OtjnUH5rIeqGEzN4sR/VmzbO0CA/cQ==
X-Proofpoint-GUID: Q4Klr4Bx5XJnpkScwAvVT8Lqw5tHEglw
X-Authority-Analysis: v=2.4 cv=aoW/yCZV c=1 sm=1 tr=0 ts=69288a37 cx=c_pps
 a=+R+biVznOuC0gx6e1UCQpA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=HL3alpDKAAAA:8
 a=N54-gffFAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=xan5N2qwiaAnmOUqP14A:9 a=wPNLvfGTeEIA:10 a=pYkBiS2NMQA_SSsszWkA:9
 a=lEx4nUQZvcvb9mYe:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=KRX0AkppOCwXZa-dNZoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_BYAPR02MB50299142D5928BF994E3702685DFABYAPR02MB5029namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Corey,

I have done a VM migration test from a v1 `ipmi_bmc_sim` qemu to a v2 `ipmi=
_bmc_sim` qemu. The migration was successful. The VM had `ipmi_bmc_sim` con=
figured but with no LAN channel.
A v2 to v2 migration with LAN channel was also successful.

Kind regards,
Yunpeng

________________________________
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
Sent: Wednesday, November 26, 2025 18:04
To: corey@minyard.net <corey@minyard.net>
Cc: minyard@acm.org <minyard@acm.org>; farosas@suse.de <farosas@suse.de>; l=
vivier@redhat.com <lvivier@redhat.com>; pbonzini@redhat.com <pbonzini@redha=
t.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Mark Cave-Ayland <ma=
rk.caveayland@nutanix.com>; Jonathan Davies <jond@nutanix.com>; cornelia.hu=
ck@de.ibm.com <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config

Hello Corey,

Thank you for your reply.

Please add tags or take the patches into your tree at your discretion.
I'm not bringing the patches in any place else.

I haven't tested migration between a version 1 and a version 2 device.
I'll do a test and tell you the result. Thank you for your suggestion.

Kind regards,
Yunpeng



________________________________
From: Corey Minyard <corey@minyard.net>
Sent: Monday, November 24, 2025 20:54
To: Yunpeng Yang <yunpeng.yang@nutanix.com>
Cc: minyard@acm.org <minyard@acm.org>; farosas@suse.de <farosas@suse.de>; l=
vivier@redhat.com <lvivier@redhat.com>; pbonzini@redhat.com <pbonzini@redha=
t.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Mark Cave-Ayland <ma=
rk.caveayland@nutanix.com>; Jonathan Davies <jond@nutanix.com>; cornelia.hu=
ck@de.ibm.com <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config

!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

On Tue, Oct 28, 2025 at 06:01:18PM +0000, Yunpeng Yang wrote:
> Support for a fake LAN channel is added to the device `ipmi_bmc_sim`.
> Although there is no real LAN channel, some testing processes which
> require interactions with BMC LAN channel will become easier.
>
> There's another device `ipmi_bmc_extern` which works together with some
> external BMC simulator, e.g., `ipmi_sim`. More comprehensive BMC
> simulation can be achieved with `ipmi_bmc_extern`. However,
> `ipmi_bmc_sim` is more light-weight and is built into QEMU.

I apologize for the time on this, it slipped between the cracks.

These both look good.  I can give a:

Reviewed-by: Corey Minyard <corey@minyard.net>

or

Acked-by: Corey Minyard <corey@minyard.net>

or I can take it into my tree if you aren't bringing it in any place
else.

One thing you should try is doing a migration between a version 1 and
version 2 device, and between two version 2 devices, just to be sure
migration still works.  Assuming you haven't done this already.

-corey

>
> Yunpeng Yang (2):
>   hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
>   hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config
>
>  hw/ipmi/ipmi_bmc_sim.c      | 407 +++++++++++++++++++++++++++++++++++-
>  include/hw/ipmi/ipmi.h      |   1 +
>  qemu-options.hx             |  26 +++
>  tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++
>  4 files changed, 567 insertions(+), 10 deletions(-)
>
> --
> 2.43.7
>

--_000_BYAPR02MB50299142D5928BF994E3702685DFABYAPR02MB5029namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello Corey,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I have done a VM migration test from a v1 `ipmi_bmc_sim` qemu to a v2 `ipmi=
_bmc_sim` qemu. The migration was successful. The VM had `ipmi_bmc_sim` con=
figured but with no LAN channel.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
A v2 to v2 migration with LAN channel was also successful.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Kind regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yunpeng</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Yunpeng Yang &lt;yunpeng.yang@nutanix.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, November 26, 2025 18:04<br>
<b>To:</b>&nbsp;corey@minyard.net &lt;corey@minyard.net&gt;<br>
<b>Cc:</b>&nbsp;minyard@acm.org &lt;minyard@acm.org&gt;; farosas@suse.de &l=
t;farosas@suse.de&gt;; lvivier@redhat.com &lt;lvivier@redhat.com&gt;; pbonz=
ini@redhat.com &lt;pbonzini@redhat.com&gt;; qemu-devel@nongnu.org &lt;qemu-=
devel@nongnu.org&gt;; Mark Cave-Ayland &lt;mark.caveayland@nutanix.com&gt;;
 Jonathan Davies &lt;jond@nutanix.com&gt;; cornelia.huck@de.ibm.com &lt;cor=
nelia.huck@de.ibm.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN=
 config </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Hello Corey,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Thank you for your reply.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Please add tags or take the patches into your tree at your discretion.</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I'm not bringing the patches in any place else.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I haven't tested migration between a version 1 and a version 2 device.</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I'll do a test and tell you the result. Thank you for your suggestion.</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Kind regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Yunpeng</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Corey Minyard &lt;corey@minyard.net&gt;<br>
<b>Sent:</b>&nbsp;Monday, November 24, 2025 20:54<br>
<b>To:</b>&nbsp;Yunpeng Yang &lt;yunpeng.yang@nutanix.com&gt;<br>
<b>Cc:</b>&nbsp;minyard@acm.org &lt;minyard@acm.org&gt;; farosas@suse.de &l=
t;farosas@suse.de&gt;; lvivier@redhat.com &lt;lvivier@redhat.com&gt;; pbonz=
ini@redhat.com &lt;pbonzini@redhat.com&gt;; qemu-devel@nongnu.org &lt;qemu-=
devel@nongnu.org&gt;; Mark Cave-Ayland &lt;mark.caveayland@nutanix.com&gt;;
 Jonathan Davies &lt;jond@nutanix.com&gt;; cornelia.huck@de.ibm.com &lt;cor=
nelia.huck@de.ibm.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN=
 config</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">!--------------------------=
-----------------------------------------|<br>
&nbsp; CAUTION: External Email<br>
<br>
|-------------------------------------------------------------------!<br>
<br>
On Tue, Oct 28, 2025 at 06:01:18PM +0000, Yunpeng Yang wrote:<br>
&gt; Support for a fake LAN channel is added to the device `ipmi_bmc_sim`.<=
br>
&gt; Although there is no real LAN channel, some testing processes which<br=
>
&gt; require interactions with BMC LAN channel will become easier.<br>
&gt;<br>
&gt; There's another device `ipmi_bmc_extern` which works together with som=
e<br>
&gt; external BMC simulator, e.g., `ipmi_sim`. More comprehensive BMC<br>
&gt; simulation can be achieved with `ipmi_bmc_extern`. However,<br>
&gt; `ipmi_bmc_sim` is more light-weight and is built into QEMU.<br>
<br>
I apologize for the time on this, it slipped between the cracks.<br>
<br>
These both look good.&nbsp; I can give a:<br>
<br>
Reviewed-by: Corey Minyard &lt;corey@minyard.net&gt;<br>
<br>
or<br>
<br>
Acked-by: Corey Minyard &lt;corey@minyard.net&gt;<br>
<br>
or I can take it into my tree if you aren't bringing it in any place<br>
else.<br>
<br>
One thing you should try is doing a migration between a version 1 and<br>
version 2 device, and between two version 2 devices, just to be sure<br>
migration still works.&nbsp; Assuming you haven't done this already.<br>
<br>
-corey<br>
<br>
&gt;<br>
&gt; Yunpeng Yang (2):<br>
&gt;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel con=
fig<br>
&gt;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel con=
fig<br>
&gt;<br>
&gt;&nbsp; hw/ipmi/ipmi_bmc_sim.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 407 +++++=
++++++++++++++++++++++++++++++-<br>
&gt;&nbsp; include/hw/ipmi/ipmi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 1 +<br>
&gt;&nbsp; qemu-options.hx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 26 +++<br>
&gt;&nbsp; tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++<br>
&gt;&nbsp; 4 files changed, 567 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.43.7<br>
&gt;</div>
</body>
</html>

--_000_BYAPR02MB50299142D5928BF994E3702685DFABYAPR02MB5029namp_--

