Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1904EC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84Ub-0005JC-1i; Thu, 24 Apr 2025 17:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u84UY-0005Ia-Pu; Thu, 24 Apr 2025 17:52:22 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u84UV-00069x-Lu; Thu, 24 Apr 2025 17:52:22 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OCrbuM019733;
 Thu, 24 Apr 2025 14:52:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gN09V7Ruw6U6i+JRUnEzUXa7enztyADoZWR1E/84+
 Ns=; b=qV/1fGQnuDh3UbjWkm+gwufa0PeDSdIYRqOhEFfTwHu5tKDfW1a3KQx59
 mlnboDoVZRBp8MFeOWUxWN4k2LvJiWy+FvpQ+pJp+WZXF4pv1n3dmZkNFf8oT3tb
 X5Eu/vkYyka5BGK40mzar4G+DsuqaAomVucfHg7XjxSBqXVqRuC7QwGAP914WncH
 ptHLysQqUxwOWGYK7LpQf7w/Umrh/PvojNTba3K8rC2QhjA2KZ0rlFThOVDz10Ns
 tlacrFyuyMA4ClQW+lZgijtQGzFro6lQDihvPxcWrehfT1JSJxFXVMgpY8xApRvM
 ulCMTAXzP4uJkUkFCQHOhf7ysCafg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013061.outbound.protection.outlook.com
 [40.93.20.61])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhvnh1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 14:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q45OLTCC3b6x5cSSEs1PWgeosnOARP//YjwTT96JiOyb/lkec9L83xQb25jkv1DHjjWdvQ3Gfr8GeZzwOvvNu1uwfuOGn7xFc37f4OS9F7FlFvTutfVEzvuCKX6H1LbkeaWCMX8LJFBk4lbJ7GgqYGXg9fDBs1VzA3ineAM8G741zT/imKs+axKnT6woNQASfvxt/fX5q0XYoA0qbPWSQaQ91EGmQ7kB4I0/NHv4Q7RgJtY6LeK8GZzqvOWfhdAQ2rxPwjPvC2AFjtzKB+RvjIyqzi0J0KWpvH824fnvtRl2iFY4UGa0avsfPM08LnEMhRay0zE4F4xAUKRQBBiBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XczWgSjyGkyGm3c5OimxokEkqHR6UbcFFak5Bhfc3E0=;
 b=sZ+wtRB49bJZ4Zt7fAcmBGOHuj9cuR/ROFPgUe5ejRaWWgDl2lLZOom5OTjM24NW74ZKwHHB8CovnjE5A+Nx6cuoFOqOTzCZTi9InvMScQk4NPA9OH/0lib3cjOGvQ1on1EPMX0rJX1FaA9C+UvZ5Qm8EiwOQQoBYigFhQe9xweMENTQxiyeDioiOosA0fHkMQQRNbyz+q4+skyRHxf8QJggT53uppHC0NdrrCb0p1f20hB9leT9szRev7dg9wOP2fON2o83lBdzU/1PrWyp+VpbbD9YXPamXL5PeMnyQo7gU5AmtGesSHz0h8dk6rpQY6LMWsosdcPKLr2EReMIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XczWgSjyGkyGm3c5OimxokEkqHR6UbcFFak5Bhfc3E0=;
 b=LZiXwyP1SDZpwOeBCQoqQBpwrzmQwt1/7B+2AyuGHSo624K/9sva+1pCoxDILTmTwIjNZRjuB+O0rwOYwxteUPNJ5o02ABtPIEEs4HmEnPuPNhxPVK1wq+FChI9ZdhmS+iB7NVDgkZHacckPLq8/cLXqirprVT+n77MFkRU5Odd+TqwH/3ROhj6AfmVcOeyP2rdfEmZ3DBAsZZ5P9O7S4SMvIunhsRYKD70/JyUOH0twdYNiEX0Fkn34bbBpV36YF6wn9/jmyyQvHUNhG5C0dkye3f9r8UOO1A/rIuOcHxYp+tLf6+orpgG2o2S3ru5VSTy07L0biJtXJquhWvJgqA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH0PR02MB8149.namprd02.prod.outlook.com (2603:10b6:610:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Thu, 24 Apr
 2025 21:52:10 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.005; Thu, 24 Apr 2025
 21:52:10 +0000
Date: Thu, 24 Apr 2025 22:52:01 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH 08/14] vfio: add vfio-pci-base class
Message-ID: <aAqyga6DrXMBU2S-@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-9-john.levon@nutanix.com>
 <3f53b147-2517-4650-8e87-0b6bc7f36794@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f53b147-2517-4650-8e87-0b6bc7f36794@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::30) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH0PR02MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 567a49d2-8ffa-4b3d-8a30-08dd837a4370
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?S2+bGeT5+Op/Uy4MXdA4A8G1aBu+Ew5vK8Rg7YId6OujKwZO4mdO+6XVnf?=
 =?iso-8859-1?Q?RsD/+tL17+ht8Sst2tIQxJTb30ewHApeCoF7V2aQFR/rQyqehnpDPw1wSe?=
 =?iso-8859-1?Q?G+/iV9SsGnwsMEGrgvuQrVZUAJwPKcD7FXePxCAHdfflLRvl2RttJguYHm?=
 =?iso-8859-1?Q?F0qvCCMm0ITm5OG3eX3VXJrDBSoAFBtfhxJ4qHrEZnzkunacJfdgUpPZxf?=
 =?iso-8859-1?Q?3cLvC7fp3J3CoDwdGSOvBYVKRcXE7xBaKYicRkRyC0075YYVoFQjujxEPW?=
 =?iso-8859-1?Q?K2/Io3tcgcW7iXppiZcMJhSJeLESFYdI8eYQthnVnZUtNrNcbKGguir4vs?=
 =?iso-8859-1?Q?3CRD6nk/jnUxotCziONVrfi0rdnCMZs5tlC5maK6ijzwZ6k3mlXpwlms6C?=
 =?iso-8859-1?Q?LVMME5O6aXSWKl2AycMwxNE40rXtJ11GSQYC1MhbwhIV6uTjE2c4I8b/LZ?=
 =?iso-8859-1?Q?hKMxulSSqyQ5DhBp01X9zwQp5tW4pDDdTQFNzMwzbV6/Q6Zhi2uud+kSJh?=
 =?iso-8859-1?Q?mrmMZ43LL+zvJGM9w6F/qrOtfmAQhNAyxVYO+EmbXn9O+3Kk6UAgRYb3jp?=
 =?iso-8859-1?Q?1E7vtIcktfG6nVhiUkyq8hFpbaRr8lYVeyc/HcDy49p6eHqEfWgT2CbWBm?=
 =?iso-8859-1?Q?g72sL2Jk17iGfk7et4JbQjDrko1PnaAQV0/Ll/NI4xcVsOXV7SfmI6Gn66?=
 =?iso-8859-1?Q?gC0weChfNd1zRHYHftsU3VX79QXS7fmCLAqkgJD/woH4qi+c7bOIt1Jg0c?=
 =?iso-8859-1?Q?u6ChwBIxhTkU4iUl1Ew0CBDraZIPDNQ7mNgAq28nEEZRpcZ6grRsqKwCaZ?=
 =?iso-8859-1?Q?okRk76KMNbGD23B1aFqhFxPFqpqzlhY5nJnfnVlNW3zdEVrXfnSNkVv36G?=
 =?iso-8859-1?Q?W1VOirRwJM9f3p7oC2BnHfJCt27EU03uwlEEdpxBOIP0ntF6cem2hTZIZq?=
 =?iso-8859-1?Q?9Xx2Jdv/giit7GrHMoXTB4BLW5V+HEaonlwK6JDRgot7SWdWaElVff60Q+?=
 =?iso-8859-1?Q?8l8Rnl+nIrc4RKbz4uVDz3orQpK/GbiChBhXt+hQjhTMDGZu6tPoeALhN7?=
 =?iso-8859-1?Q?bJWWRukOzlz2ErZnO3gM2DQW8L5y+QbRhD4BjCH4hhzMYCaJEHbH9FnOlw?=
 =?iso-8859-1?Q?Zjs3J3z+la7e2hsY33v9H7EdkqjjT5CruVu0r2dQvZmqJl9BLrfHRt4BOw?=
 =?iso-8859-1?Q?H5+E5+6IZ85doy0mUQ1aC5UbeC0xksbzwMSQVcWUGlNveQqdtPCgb6fgMP?=
 =?iso-8859-1?Q?5BUYiDDp+5Zz/PvLGBM7ovv09Ht4RTwzdEWY6h2VdVEOAEx+TbnMg3TyJJ?=
 =?iso-8859-1?Q?sWSVI71ssIzLB6JuwgTy2xFsOFyNqPMOOpC7aHbtS7E3vbSSZHCnCr3Kd/?=
 =?iso-8859-1?Q?mMhWOY3jOXB0ak4D5u5wxCjGsGHog9lRbLoCy5OivhbiNoPEKehkifJiLE?=
 =?iso-8859-1?Q?LAr3iu/hvSQKe+kNZgg5O4sUxSA1Cn17ibjsQTlzng4cuN73o6y7/EJx7C?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZK+jLjVlh/xeJt59oJHZkzsh1ZkJmHuuJVuR/olcKmEgpOgo8KInHn+aFt?=
 =?iso-8859-1?Q?ScyYo8brp7FedXzaIlrFGH4zxqlS9rWVq8+f5zvyGu3F43K8SX8rt4EjcP?=
 =?iso-8859-1?Q?GMqnNCbnS11n71h4jot4t46Giym9AdEj1urtNHf27buMox3jwYn4cqY/eK?=
 =?iso-8859-1?Q?CiQpJHFryH0LWVGBhqCH35TrrFzCfP73lLqb78PDj2vmKn+6xyLplzT7+k?=
 =?iso-8859-1?Q?VksGZL84powSd+E0lvShUnaXs0btTfQ6DXujKz4L16Bo1is6xlmGPqOpdZ?=
 =?iso-8859-1?Q?AXOSr5AX5e+ujHzwm02csA6/D6Pixw+Fey1tlNPuLAoLWi8QLYfeKRiqqn?=
 =?iso-8859-1?Q?ZXsm5ENgrzLnDDN00h+ViFWz2hBg9OojaEfF2ELRxvhZMaAKK8+q1aD0HT?=
 =?iso-8859-1?Q?TingX7aUtAUKtu+Y64F5QmPV1694yaGV+NYkPoE7R9N6w8LLBfnAyhtjL9?=
 =?iso-8859-1?Q?ehFcrhB986vdMWkh52iQwpRHEVp+SxxsxB9NqdiiInEuA0ZoDlX3uUWCPD?=
 =?iso-8859-1?Q?1ZWr9lrnOokfhJQB89UjjHS8IwAFMluCDQ0e1rd4g3+09j/HhrjZfxgvYa?=
 =?iso-8859-1?Q?PRLQMx+cgqQHhnRbDDrN9V4/a2lF6rssBLoWvvkwG2sut9X+jFVUaiXhFr?=
 =?iso-8859-1?Q?4iCzuQD85NXOx6VnotijAwoLRocLzcIQM0x4fHBNmMpjXB6mulMzJmcf4V?=
 =?iso-8859-1?Q?5o72SmXi8d3Np19uNyxqu1XDRshdFMCe+bFjZIZTsIoic+J2HJzg9o9k60?=
 =?iso-8859-1?Q?+SH0XH165NCYs60kNEIYRWn6c7FpKTFsJM5DhXW8YTAVSeOF7SbNDYW3PO?=
 =?iso-8859-1?Q?SnLYiANmaahg7j40vmnr7M8a+RW+5jD8v4YwM9q8JmBW/22mgf+IVrrMyE?=
 =?iso-8859-1?Q?WJKb3M0lbCK+Zvp43f67AMbe3wuFgkMM5SM0bt8SZK/zy4Eiup53MJmaM7?=
 =?iso-8859-1?Q?e4Mt1nWxFV3udx/fPt6Y/krtmYnSF19CUw82ikSpO73W+6i3ECmkMjR51p?=
 =?iso-8859-1?Q?+5cd20TM2Iyr92rDDWo+mQfKIxX3jMQaxrh4QVbltiKs2WUhnu/Fox41Mm?=
 =?iso-8859-1?Q?3yyPCZ6r7F7V18fgsIQ8jZO8zvPXSSIcnX91U7p/nCxLsSfYo7FBXFSs3/?=
 =?iso-8859-1?Q?8WKdUe3y2VtNBvhSd+Xrlq5X8cqQgOhHdyvu8IU1+ajfSJEajBsSnvLvbt?=
 =?iso-8859-1?Q?9G3YAsEBJCpeIun+9AsqmAu7aGSyi8ikJV9TDvY2WH0rhqoURzTHqRn/Ou?=
 =?iso-8859-1?Q?LAnuJ9rvJtHeP3AtQeQl03I3xnd3N8kMwxoJEDBFy6jeAkMymCpfJfO2RN?=
 =?iso-8859-1?Q?1DYQpenM39tLVlYG5CK9OFasvZ0NoQzGe0x3RhqI0OPpbTYSrGUHGnVWMf?=
 =?iso-8859-1?Q?akGzNGF0++2CFhUZfD8Jtc+LxSxiP6DjyL1wGPpi1/ako37R1w6oVGmQHZ?=
 =?iso-8859-1?Q?zdmHUiMN1wFCcNJUHw9M/aWSo/L6OSxygaGk+IROWZR2PJa3WRTDf+KaXL?=
 =?iso-8859-1?Q?9+JdIRzHWRM5mdm4HPnxqdf+LJQ/MDqLsaLOQwwNnlYbExWSW/u69Vb2DG?=
 =?iso-8859-1?Q?nrcPRP5jp9DdZ0YidtuNCZwBJB6XD3o2/Gz7tvCCzCecYrMDEQx/fAjxHo?=
 =?iso-8859-1?Q?eDXqX/5x3FSzxDLrlqL/KquyGj0WMAOHMK?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567a49d2-8ffa-4b3d-8a30-08dd837a4370
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:52:09.9215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dU8j6tvM/yV5nyisutyh3jzDSzNZLiyW9i/hd6TjgzSknKzDpT/haEkAkXnAXf4E+BYfBw58GX6qUIP3+bkFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8149
X-Proofpoint-ORIG-GUID: Hl81glCF57H0N7IkuuB3TP2LVpD4Ms6H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE1NCBTYWx0ZWRfX+E0UPuqXwWxB
 roBsT7PYGO70BRZLaA4d/vdMYGbML9HbWFsVDSrYITfmlgCqlO1X5Gio4gvvpLa+vaHC3TkmGpV
 KlGO3pJDbVFgfxW+pCDIxg5HtDka8BKhF+9B8IPFcty99G0oLFyVEvXncX6yC6sz8ZW7EmrzOJy
 WuN0Trr1HB6LaDLXFn1kMa4166QbD/XSThXxEU6fKjdvOTwEYprYhuRSYZD2W7ySzHngGjdC7ll
 oDRyErBL01/ZwsLYTJGCQLgFbaEb2J6dWEMh6wFcS+PRXfWAvJfZeW3Gz6qcfszDpp/17P23FJx
 a2BvrIMTxGNjQ4KVASydDrufUxLt54FpWSjBIvava4hjhaFz+wiY47i2C7l/EzhWunwrmYsF3mD
 +4xXeVGbUjnsPbzwDJ8vyna0qbMg0+9pwWcfMaJov0MuinY/stM+BXElLHQmfSRRzMghNjJg
X-Authority-Analysis: v=2.4 cv=U52SDfru c=1 sm=1 tr=0 ts=680ab28c cx=c_pps
 a=Fcp+KkUxEAj3pI5yN7qTmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=drIhVjQzzTf8kedGdIIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: Hl81glCF57H0N7IkuuB3TP2LVpD4Ms6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 24, 2025 at 05:17:28PM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> On 4/9/25 15:48, John Levon wrote:
> > Split out parts of TYPE_VFIO_PCI into a base TYPE_VFIO_PCI_BASE. The
> > base type contains properties generic to all vfio-pci implementations
> > (although we have not yet introduced another subclass).
> > 
> > Note that currently there is no need for additional data for
> > TYPE_VFIO_PCI, so it shares the same C struct type as
> > TYPE_VFIO_PCI_BASE, VFIOPCIDevice.
> 
> I don't understand how the properties are distributed between the
> abstract vfio-pci base class and the vfio-pci class. What's the
> rationale ?

It's for properties that apply to all vfio pci classes, and those that are
specific to the kernel vfio pci implementation.

> Can you remind me why the vfio-pci class for vfio-user can not
> inherit directly from vfio-pci ?

For the above reason: we'd inherit many properties that don't work for
vfio-user.

regards
john

