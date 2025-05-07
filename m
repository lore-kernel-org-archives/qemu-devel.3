Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05CAC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgaM-0004y3-Rh; Wed, 07 May 2025 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaG-0004oT-BZ; Wed, 07 May 2025 11:21:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaE-0005up-8Y; Wed, 07 May 2025 11:21:20 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ALmx0025335;
 Wed, 7 May 2025 08:21:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iis9JJwcNdXFsc+VN2eOMafFnj07Lv5Y1m2yfLVVS
 BQ=; b=mI/qX1A7NpeJYMzkkx84PN9PwnhRlv3vIi5riAa8B4abApT//bCSNTaC4
 4S4MHcZVmvSXGZyKCfmmt1AFNit43WY8Z0UTrXBUeAgO8gvM2rA4/Xn5Fxp7WhCT
 ZQC3XrOTcAb1JW73+wK8Hwn6UJP7lns0jWIZswP4/bEw33jTb5RViozCT/0EyWYc
 1GIIeuXqUHAbfFj3eB23dyzND5P9/XFhKz789puwHkZ/xhY8iPP9fzTKgYPrL0pV
 nvKG9XkPY76Iaw5ku0yuK4gVElathQoX9zzRuFCz/sFdmNabxmUpgszfCCidNXNE
 PSzO4MM7a2kuH4Z2wI2Xyq1PRLA5w==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp91ekp-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr8GVZj3zWQvHmJyc2JzyysM9AokQ2osTsiPLH3LzYVSr9kZqfyR4ykf1hw0paogDPEYBHU1b3gFzj3RcJ0hsN1E1XYfftI3RBnGxWDAS8YVDZR/vPE7+4D+/u+OXN3OrK+QT+znDZkJapHzDyKlu8epBkms4dBZY27FWpSUHW3/efFDJjgAoabfn3FAwr1u1hV9j3jlTNvn9SkcrQX7AVrDRxfagNkbri8IYEeQ1mDwlHm0yicQ7kV6jcQS6niy/lDWPRoyw3euRF8Oyye0MfB8EknyeKttcqHYqZTEUhtd+L468Qs2xuhIjYJSaFfBB4QKgIO+CvaiDAlrTJRwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iis9JJwcNdXFsc+VN2eOMafFnj07Lv5Y1m2yfLVVSBQ=;
 b=EECVcNQPzpGDXyKVYwbL1cP/1Joef8nT2r0QPZVeWP8XQVFXV0vnCausMkU96sGVbX5W4/OMCDXhnKRBce7h2KPmYKqlF1NvguXa+v4RW/M3iypU/D8yOxKs/VCTTUe+77keAhdE1MP4xxVscFqP/uz9Fzbxu1IS+n765TWkQ8oU2xEPDiOF4fXKjKKRCH0claRgLu+9BMzYMAOb3yj6Q46fZ4a7YPUkXZIZz/MlIPx22hvB3bQqytBznTjX9NflcokNjE6LZJ+kipFrdGr/ZJDkMjwneESKDAp205EbLelgIwq9wmaSni4VQV/Ayg9ppF4F+xsjXiqB1K2IIbfepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iis9JJwcNdXFsc+VN2eOMafFnj07Lv5Y1m2yfLVVSBQ=;
 b=fo0fVv4/Jhmykh6BIYzm4mG2Du8VD9EWFXrSsG9cHb/OZn/OYsyYxQz4lqIgZrw3rWQVTkG7ova7/DRk5gX0+Tf3IZAvaJOUtTPSxOuliRt9XscZn5Muom6zzn8+cNAhpCTKphpML8AtCeeSdVasuVDgaRlNITmyJwPsFBXwdRah/GoAhtudKY9Gv3lxoeR5JZiY8di1lazcc3oorkoNHooF7j4s6ldGrVRCKtcSR6SZKJorkYIRlti+SfabAG2TA0QUnUXJw5fgXc2BsHTdE8wjifQFRMXR5dYRZQ6/2rpbgjITHnzIXlf9cXr39hJCfPSnLSuVk6pbr7AMj/xnIw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:21:05 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:21:05 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 13/15] vfio: add vfio-pci-base class
Date: Wed,  7 May 2025 16:20:18 +0100
Message-ID: <20250507152020.1254632-14-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4c1d8b-2beb-4e15-5af9-08dd8d7ac8fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Xtn0EJa0aULL4wvWhmJ6S23hnn3zZUPiTol8wpZeGr3aoHYWnPkHpv3wcRN?=
 =?us-ascii?Q?oF/plUl4CmfNFIbkIciGtJw+gXXl8SRtD0H+nZf1jkn9T4y/YjI58sPOsmcS?=
 =?us-ascii?Q?PQDx3u25z4Apulrb1703itTmx97n3ozeteBWGx6yA8LlopjKhJh9D68mw+Jl?=
 =?us-ascii?Q?i6eUqtuElF+USvPndLqFHOwfhA46jfAzM3IarUxILv/Hn8VFOVI6BuMXcTPX?=
 =?us-ascii?Q?Mr+RyEHhoT1u1czo1aYatrLGz/z6hrQI3jwJ6REql38F8TeQ20++SAA4LRbl?=
 =?us-ascii?Q?iNRIl5E/XvV62oc8l/VHtPWO4jMe5VbqUJqzUVgpv3fPKtMNhQfr8Jo+mtDI?=
 =?us-ascii?Q?CxGLQDWg7HTKUCgeba2ZVFABB7+LRYeAVrx97IHMCddnshwhJDYa7rDJBxss?=
 =?us-ascii?Q?GGQ6wWknkwZnAUo+AbHHYEabvYVXJQ4s1UzQsLhqU7cmmKA/3qkJYO0rt+ew?=
 =?us-ascii?Q?4PjpndOTaOcDyF4r0wiJ8uMIcaBDd19Ll2Nhe1BAH4UkZfmGDPvuot8cKDSe?=
 =?us-ascii?Q?+y7Iy9ThBNm1aMz7gxTX4f2RyILE2I+Ys/Os9VjIt7mqFsxrOKnK+2ac8RQF?=
 =?us-ascii?Q?bPgSsGJCkzAD4CA2pQtdzyDCTIhQlCqo0F25KP63m3ayctTaY3QE2ZCgEgnb?=
 =?us-ascii?Q?kXMRGAxzM8R0eY3RGVsrbHvIJTgKDO+UW4pB/XNmwi5JK3hmmshpG7bfIfZh?=
 =?us-ascii?Q?HFpJDr/9alBXMnQ50RDq72oupJ2x82oIPLTrumePzwtPJICthSgHSegW0u7N?=
 =?us-ascii?Q?rAvFn6YL19oMb1aRB59sKD93Q0wBZ37wKs9JtUzAIxxbH5b6VhJJZkfyoW/t?=
 =?us-ascii?Q?XzK9FIpJrRZdzHSoxxENutfRPODMkwy92aBZbHwzfL4UvGwq7gGnWJwp4aAA?=
 =?us-ascii?Q?ggCCnnkcQ//cf8wxkpCQzDe1aVwMdFHud7BtdXPFS+DN4TW9w3G8V1fJskKH?=
 =?us-ascii?Q?mu5bnLvP+wHiWTsnR2xApPJU0N02Fk0gXHvztBeO+4m7vKopWg+aKZ1JZs+v?=
 =?us-ascii?Q?8OoOX9JxPO+qDOkCaDw4afxUVd36P8rJzpA9BPdPKs3lu6MqqYgEXFAcVW4P?=
 =?us-ascii?Q?qkOwoRM2dHODQhaI7JCk9EAwPOAGjfXifivaA8Fzbxu2Sz9mBg9hS+/vGWu4?=
 =?us-ascii?Q?pxE03j72DNeSowcdyFdstSJ6+UqvkuhA20ONm6q/5cSWu05jEzwdnVfdEUR9?=
 =?us-ascii?Q?pgGGtG3gDEhOx95NwNIx4D3AsjlskE+Jq7vnDsygMeU7ITClVUVcBSoSWEsv?=
 =?us-ascii?Q?sigmCTFyXntEZRbXQkYMpt6tfwMuC8eAKfUIQ6JtKyQzU5Er+wC95VVmd2Dc?=
 =?us-ascii?Q?T5ORLmyS5hY5xgmxEKrf8N+rWAU9g7IIP/KQvbWyGh/9uXYUitcArW2YWSbN?=
 =?us-ascii?Q?HzkINFLCk1BoyiTZcPHNKoZjmsiMBUE/TJMdJcGreRKiv6Qoc/qvcaz2018T?=
 =?us-ascii?Q?IqW3xtRpi5Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUQYJ4bGKpyXufA4nl5/60yNGMTSbyi/HyPrOvL3nz9SKrcjM73mX6HnAgxG?=
 =?us-ascii?Q?Jtg1MzNp2PEMDywBVaQGVQ2Lpl0SG2LTuOloTIAmplVidvz/y13AHokIT70h?=
 =?us-ascii?Q?2Z8SrwoERSEXZvCE3RploLfHXAUkWkG5pbZlcEUk9F6/d0Jai1c98GDqFaef?=
 =?us-ascii?Q?kY2wdNdw/q3ROzmlT2EoYe0GUMkYn1ItXzhHWyZtHJEa8+zBhnzZkeffrLSW?=
 =?us-ascii?Q?P+YXW2+dz41rZn2Lr+DsmFMOMaAhEH2zVWxJXYSUCTgnheWN9nws0r3oFaSO?=
 =?us-ascii?Q?F7O5cc8R4TJW4bpAyZDZbXQgSFTe7lq46qog3ktVc/c91Dm08QJxpjhbfmmY?=
 =?us-ascii?Q?YgBFrttJU435nS+yxFzqYbG3XHw4FQNyAfDncAJLhjHmarZ4LMY3VSl4nJIa?=
 =?us-ascii?Q?YHMW6HFOPiJ/NlixoIaDwnv5cuGXne4rmqlqT77QaVet3EB52PeF3NldvYXn?=
 =?us-ascii?Q?fLql41soyd55PXwTVNa4UyYS0kCS1cILCynOt3v2yvzpsgZuQtwWB+qacyh+?=
 =?us-ascii?Q?/SpkhaTenI+VGYlNUq4wUTcwMIeFXH1TCw8ZdMqsTOP2hezuJFCLA+Esfra7?=
 =?us-ascii?Q?YIVFTIwIX1OJgGcWy94KAXigvOFZz/XoUNqcJqZi5EoSRdk218d1bEBEppNT?=
 =?us-ascii?Q?ljpkzw/bJc84p/FnPoEnTcnZr0x35XX4RZerOvX56ObywhnkSlaxix+Y+6eV?=
 =?us-ascii?Q?cmq0PqQTVVSEBlAtCv1wy+mO3bUSkVlpXnseKTCkK7dUQbSuWSF4gt8Qq0lF?=
 =?us-ascii?Q?n3P81NLKoe+gudNLxvVp0IkKD9Wugxpjdzv7xgT1iIWI+EfZ47XtrHuvOkDq?=
 =?us-ascii?Q?+OwPUqf54j9S7kFxt60ymFlAJckKj91by9TDoq7/ehdPLGD+bR8fqsUSBNsv?=
 =?us-ascii?Q?xm+Tb2EbB+yr/OpV7UPWsJJNGlDcKVKnSiA3cPDgjOF+vXazHLpna5QL5mO/?=
 =?us-ascii?Q?YssGUQECO4O3LzYTuVtx3mmxV7j0it8yQn7j7lRvwdaU98jdh6X5gTn3FELR?=
 =?us-ascii?Q?zro5ezVJjC/dVRc2pPPrMbkWcQRuspdOzfryJDjGWqcrurf0Q2Smc3x/BpTA?=
 =?us-ascii?Q?hkliJxhhIGmztjKsxD/JwcBY/5B6ZWSglcFXccSh0+xAL95zPYJDDka+idKM?=
 =?us-ascii?Q?igWXoj3EsPqXbjQiN42NOvFsY7FCZnDVQTICFQjTTkNWPRH+zpzlVG7zLlmk?=
 =?us-ascii?Q?pHX26YJ3GnFAcpYM5P3fYuFTH/SNXee2iH39YdquNAzVeP2tgDahU+C9R4vs?=
 =?us-ascii?Q?F/i5yAsJswOhy1A6AeyaPdGDF60DW76B9QO96D1v+gZCHFWgR+LeIvbeZeSo?=
 =?us-ascii?Q?hvaoAvsIWkWDDqoAGybCCl6YYMQlPRUPpXqENzRsCVFyFHMJlTyXnvsf5c16?=
 =?us-ascii?Q?jZF1T23xlRG20Y3Px6a/poXI/vs32CuYwRCCGnzEXSkYZwKHNtMtELTYXoK2?=
 =?us-ascii?Q?8DWqYbMs7EaAMoGjBb8VjvapEerpjOg7A2Hvs3BUcW/O2ZlAA4STKY95+JC2?=
 =?us-ascii?Q?G6oH4SHeHT2b8ug5eEjdTAtufvfUkQdyG/0civ+QIwPtesYBCfOBgZtSK6Op?=
 =?us-ascii?Q?Ns/Xvjo2sh39qcdMcTgsOJEPMB+ioEmWC2Yzy4Vw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4c1d8b-2beb-4e15-5af9-08dd8d7ac8fc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:21:05.5213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHadqEDbVyPLldQFr22qibTBomoRCYwK5ijIm+rHgfsLiqYaq7j+RZ+/MUuNHmAN6OY7mpg46b3m/n6Wks2/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=681b7a6b cx=c_pps
 a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=4KTYh4CsxjRY1Y8snwgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX29n8qbXQMWk/
 zEOORTfMMOrPllSoOSKyls4hUly50ZYKUt4FtpIkDRnFx5/muswUUrKXBUhr2O03H4Nul8nuItZ
 T9JM/eTBFziHQZUWHHsLEIkHN3tA3QSMsTV8HVjVGxxUZaI4dNG0abD/edL6MDlz6iuQE7HOsCO
 FdyenhzhWmwHeOxGldFLL+dpFOj4vf8EociS8b6ikm5vMDxnumT1W4f+rvWg8bHgKi2FlK+6ibw
 msQ2oGpSA3zjmAzY7ZLSNJ+lypB6k2E9XnYJPPhJNQafToSUlVz1tnKehpNUUw+kAoLVHBVF96w
 trWagBBF8GfYXQL81DRdaJgEZRTD3Jb0ONP7E2DfPlRa9T6NvKrQUihb7xHS9TYbclnn3CMu9nM
 G3nHsBeO3EOggnn6gDvz9Dg2/FKHARqpi0Mpjjs2jF3OxiGGTYP9K/uEw87LGYeGiuFV1bue
X-Proofpoint-ORIG-GUID: Cv-r0t_hfj2HKXLT3fDeTZ8-nzTXjBTy
X-Proofpoint-GUID: Cv-r0t_hfj2HKXLT3fDeTZ8-nzTXjBTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Split out parts of TYPE_VFIO_PCI into a base TYPE_VFIO_PCI_BASE,
although we have not yet introduced another subclass, so all the
properties have remained in TYPE_VFIO_PCI.

Note that currently there is no need for additional data for
TYPE_VFIO_PCI, so it shares the same C struct type as
TYPE_VFIO_PCI_BASE, VFIOPCIDevice.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h    | 10 +++++++-
 hw/vfio/device.c |  2 +-
 hw/vfio/pci.c    | 62 +++++++++++++++++++++++++++++++-----------------
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f835b1dbc2..5ce0fb916f 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -118,8 +118,16 @@ typedef struct VFIOMSIXInfo {
     bool noresize;
 } VFIOMSIXInfo;
 
+/*
+ * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * between VFIO implementations that use a kernel driver
+ * with those that use user sockets.
+ */
+#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
+
 #define TYPE_VFIO_PCI "vfio-pci"
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
+/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
 
 struct VFIOPCIDevice {
     PCIDevice pdev;
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 0b2cd90d64..9fba2c7272 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -392,7 +392,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI(obj)->vbasedev;
+        return &VFIO_PCI_BASE(obj)->vbasedev;
     } else {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1236de315d..a1bfdfe375 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -241,7 +241,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -514,7 +514,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -620,7 +620,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1196,7 +1196,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1242,7 +1242,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
@@ -1276,7 +1276,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
     int ret;
@@ -3129,7 +3129,7 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i, ret;
     char uuid[UUID_STR_LEN];
@@ -3300,7 +3300,7 @@ error:
 
 static void vfio_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3318,7 +3318,7 @@ static void vfio_instance_finalize(Object *obj)
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3342,7 +3342,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
@@ -3382,7 +3382,7 @@ post_reset:
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3403,6 +3403,31 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
+static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    dc->desc = "VFIO PCI base device";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pdc->exit = vfio_exitfn;
+    pdc->config_read = vfio_pci_read_config;
+    pdc->config_write = vfio_pci_write_config;
+}
+
+static const TypeInfo vfio_pci_base_dev_info = {
+    .name = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = 0,
+    .abstract = true,
+    .class_init = vfio_pci_base_dev_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
 static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
 
 static const Property vfio_pci_dev_properties[] = {
@@ -3473,7 +3498,8 @@ static const Property vfio_pci_dev_properties[] = {
 #ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
-    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
 #endif
 
@@ -3488,11 +3514,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
     dc->desc = "VFIO-based PCI device assignment";
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
-    pdc->exit = vfio_exitfn;
-    pdc->config_read = vfio_pci_read_config;
-    pdc->config_write = vfio_pci_write_config;
 
     object_class_property_set_description(klass, /* 1.3 */
                                           "host",
@@ -3617,16 +3639,11 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_PCI_DEVICE,
+    .parent = TYPE_VFIO_PCI_BASE,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-    .interfaces = (const InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { }
-    },
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
@@ -3673,6 +3690,7 @@ static void register_vfio_pci_dev_type(void)
     vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
     vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
 
+    type_register_static(&vfio_pci_base_dev_info);
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
-- 
2.43.0


