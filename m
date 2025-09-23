Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07560CAC5AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Vq-0003CC-Ki; Tue, 23 Sep 2025 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13V9-0000X2-Rk; Tue, 23 Sep 2025 09:56:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13V7-0004Ka-TI; Tue, 23 Sep 2025 09:56:15 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N5P5px3995713; Tue, 23 Sep 2025 06:55:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=tIDu0REjkJtbaR9KT0JWWW+YbBEJIdbAywpTaYeQU
 Fo=; b=lcy493QEG0ZSCxbhQiFVdq56dIbRQr7RtNTpeqOAYsxvsoxjyCMS/u8ks
 0DIWUYMRlzQ/kNhtz/K2BUc2zIZVCXxrQg+MguGVUS1Iwe05J+23j6ucsKE5WHgw
 lDsSgtuUwpkRT+zKwJXhctOIt64ay2YKK4qG6e86apnowlh1dTgF07Dh7NR3M0Ux
 YMEl2yVy+oFE2rBVIe3k5VeztyWYVNF+YWl1iiBVjo5w0inF/pmyohD3HUDkjkVs
 1Of7wgRSgGi2ADBpy1E7Ea0UFMF61Z3lFWLf1+sHq+nL3xHFPoXnrGBmlf7L71gw
 7oYlOmmQ2Sv7K5tJm1Qn9P4aIc56Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023086.outbound.protection.outlook.com
 [40.93.196.86])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b9pjjfdh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENoVMGKxIHxavXC4zGxbhxonkvcIJC8cRqM6lixb6YkBjtMq6nuaX+BEaGPQgugmpXedCBwEttngG4jarbTucrGdlvzH6n5a9ot7HYHEqr/38BS7SKycGo5C4JugUDCdam5N0j7jxzXA+eOV35R+4VW88GDDtRB1cTOjoMhYgy5Ot9pHkQGm1YOYQOgLsLTXOqXLBIjZH4UdbOw16gXzj/BMB9bOtPS29nBnEVKQw9wYYwSI/oQo7EbMyEhGW9TfxcMPqW6muWvuKs5i6G0+IVd8xQuHpgORNmIXmzYnDMP2s+i/MscY6g1bv7yTyY5WRA7J/MwN/OTu5TwHdy9wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIDu0REjkJtbaR9KT0JWWW+YbBEJIdbAywpTaYeQUFo=;
 b=gf9uTzOn+u+q0GqG7mrxW//V90HSnuQKGO57cCWAfKdmih+rF4uu12AcasC5n5OAMYCCeO1co5frlT3+afA1T3Nlsuod7HJo+LRMUozvihFQ3l1B/y19xDxw9jlIj1/KpKtRgLVPc2Ce7F4eGJ6FijuE6kCIFf4upfllMlrOrKXw7nFT/4BncWNORSTGDzVdVRnXkpuBX16MfGhLFaSLjkOzaYf6V79EzAEmOxMUPyp6sV9g2qZgG4R3zv8FmA5827nsd4oS1b0boGWTmRVpatEQGYUqRTcuR21XmSds11caFsiEFQgJ+TtO2Jz+ecuSFM1P/O5wBhoArRQ1IPhb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIDu0REjkJtbaR9KT0JWWW+YbBEJIdbAywpTaYeQUFo=;
 b=sCWHHIi+qi7ihXnT3FvYj5sElhnPReFVQshdthbEGawgWsGVboiXLGPkE47sQCB45ED0V6fXvnDrNmVWRpdyRsHUd7Lqrh59WI1TAdJCSvMpbn9tVQgpBr0gIBXW1OUA/zkVJRU17SUVZ7SOKSLTYcIn6/q38u8dHLNkYOQJHDyfeqlfqR1arKTaMxpJfR5JcDNfgRi4PIzEzKiZRg/Zg/mxPa5WHENUr1j5s0Z54seQ3d/dI5xgWh+J/29dNd2GAVbU6YryyFYHcHT4ojrFTuQcapFlZi8kEwYc7rzSjauNAgGuvG61v8KCLTyRmP8i73cfgaQMcnSbTzkPKqWHIw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 25/27] vfio-user/pci.c: rename vfio_user_instance_init() to
 vfio_user_pci_init()
Date: Tue, 23 Sep 2025 14:53:31 +0100
Message-ID: <20250923135352.1157250-26-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: a3547193-c975-432a-e779-08ddfaa8de12
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CeOG4Oblp08qBWyH9+ol3saMN6w7qZzLBVdsAiLtbxacTC6Ep4UV1GLdAfoA?=
 =?us-ascii?Q?SDDXBtQAoYG0WuHBQzk6vvU9G4F51SKmptotsKr0b7iTK+wcaKdtkwKGBqLp?=
 =?us-ascii?Q?LKZk4wWeMROr2JuGPfdFFRBJfg4QM04iBouBCF5R62A7YKZwtjmtbCULSVqa?=
 =?us-ascii?Q?JCRHM9Fn6eKO1D6ngfp29oi9XofCRyje2TH3HMZ1UBWb0K6qV3d5O3+BME4o?=
 =?us-ascii?Q?VDoFvw9e15TcehrR7M8W4X1C+lUAJ4nzJuhYdtiXKwVvrqJKiuJr23xnUOP8?=
 =?us-ascii?Q?+SrN6546q7RSi22DJU5Lxa/MDXedBQKZmSKBMIIv8U146RkJH5wnA/2+1WDm?=
 =?us-ascii?Q?U44KNuil1yJCuTqlhHvzUNZl8WBsKsYdJ/QPpNGSVH9ujN+gJHejltWRsi/3?=
 =?us-ascii?Q?AB35rRlWKWJu3xe+2ctxpMS7dFBxRh4dz5c0dEWfm8DwuOQClf57eCuswSDP?=
 =?us-ascii?Q?ifNVF1HhQfGKIk5MIOeyD+6Lq7iuIZ1UuHeEH3uY7uikBrKjgJtda6jTWss7?=
 =?us-ascii?Q?NT2FgRBs4tisYVAEC5VX5XTJwlYxvVVJruz+NSkI6Qxz/3ZAhEG2eH208MPB?=
 =?us-ascii?Q?haOO2dYEqacC/IdNt8yRGzhG2ENyFwvCF+6y1YkU0cNUvmuZchs+YJl/sU61?=
 =?us-ascii?Q?IWdYmXnHSCPWuWxymbjsaduBkUtqb7pPI2AE+WGvruZCIT4gaQKtooyY4LwD?=
 =?us-ascii?Q?/eZzdFxAhqzNNRutxNLKxPNAWqYHlkx7DPchLnaHIbrSZluEHDX4XxU2GZv/?=
 =?us-ascii?Q?2A6G8oLG2Yh/SHI3OKT+OFmTAq8itAiTAAQDty77MvUn5dTpw3cY9qgwc7yo?=
 =?us-ascii?Q?cg1gaDHXinrOYi81AwS3zRWFFRAsSHi/U3ia/zAKcGh7lMtEk1pHebgujMvx?=
 =?us-ascii?Q?hQd37gb7q3rDwoa/Ee10pNmBo8UB/kF1StcliPAhEolevP6fGhoDbcPJUMXH?=
 =?us-ascii?Q?0X0TLIFmVlsBdCfQD9MoOo0ZqQMJNiTZj5TGYG2ymJSJSYRyW230EShN30Lo?=
 =?us-ascii?Q?F0ZJeG2L3Efmu7KBQDPRnh15RI76Q07dJSn/1kK/U/rvbVbAGRJgnyNg6TSm?=
 =?us-ascii?Q?8RhchEek2tFAtBoboOUgTABEdi7ZNmXl2esVNdzjcyOQRJPXOrVCL0lLO7kS?=
 =?us-ascii?Q?E/+AVgWcXyPgi1ucGsHHmS6Dcsuie9Bl6imHQjr/7QbUhBXKCVq9Ra6+mfwN?=
 =?us-ascii?Q?HCHONixwUW8/e2RYORC1PWxKjxbgbd3wXJaagSMr0OGVvpUNfPDHxr/jTDvv?=
 =?us-ascii?Q?2seuFwbUeCOG7cdzDzmnR2g4AN3lwAiHraXTannH1yMnlYSjkr2QPo5bb4HZ?=
 =?us-ascii?Q?68WGfb/S770bLKgWVxero6V0u2e+U3rBmFu8mD/Pc2Hn3sPlQ6hYkj0uvy7X?=
 =?us-ascii?Q?M6OCiUVIbrEFrzXQ9+K3Ce9aeWEZgPoQ85y3RcfE3tRtrdumOM49T/dZ+Ahs?=
 =?us-ascii?Q?/Y6NeNOIIw+vLzWZoHFD1JCMxwM/9ENrlmMlA+3uDqnjfdYZJ3W4Ag=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GCvQ4SxcpuhYm9hRgJKTIed4Y4MN/6uJzUr/IrjdZALvzubJePAh9cAQXX8t?=
 =?us-ascii?Q?7g0soPAAoTvDtB4uXOJEo6mLBmFNoBBYqygkfkgms43RXZdkBmkRf2c0/Tn4?=
 =?us-ascii?Q?SeLDXAhGOSn3lHzoARBocxaOneZ9mmBeCbSTdxZuscaqvAdBfALTfgMhUriS?=
 =?us-ascii?Q?OPraUjlD5q6obcMAC8bHd2N8Y0c8ZnFflBo2o/igP7C/qP8dR2FjYmYbS9hO?=
 =?us-ascii?Q?jRWUFopaBu1eNBmR+J7y4R4HeJKfaYyJZC7V8YtsFsNBmBIsjEXMKcJ94MD2?=
 =?us-ascii?Q?FkyaMj+Duona7w1HkNI0nOhKaJCGl/8xqzOP9ifquChHOPFuK5JGDMTFkd/N?=
 =?us-ascii?Q?hemCqUoIAROPsJf2QFhb0LnyOXz7i6lwaEYiatnv1Ss6+DI4lEsqX1GNKb+a?=
 =?us-ascii?Q?rY/DHe3TVrmkdYsCjCEiBXTBjA0DU0WxLMNnj42H9NRpvnTK/Gf3bb4iLEAb?=
 =?us-ascii?Q?kA4buD8h5QXiw7NlaPF1u9O/gvOuWcqsunosQmxOklVnyPGuuGFcz/wgJZOv?=
 =?us-ascii?Q?FZCWhyU7eSFG0Sy/02+Q5lWgEvL6RHROevogNwI3iqbQY7ekE9Oc6sncwUCH?=
 =?us-ascii?Q?WEnf3hNacixsDI5i2N9GhqXVbyohMyTUEyf1y1o91mGT7qkYqoXKVtQN6bSw?=
 =?us-ascii?Q?StnbBOLevtuGPzBqMiHEEZ90mmjQuLO8Gx/v90sk7sRtTeqDuWWbZRmWDtky?=
 =?us-ascii?Q?RMMKZYoAe2HpGyijvoKtQv7Si02V7LIHEIur/lXoh2S42RgMivcGfSmHI0ep?=
 =?us-ascii?Q?WKk2vR3MHdMXVN/AMUO2FsQF8h5z8haOZAU63yJNkFtZe6hecau6tMPT5anb?=
 =?us-ascii?Q?9bV0UYxuNeZFDHqQyC/oJIXp5Mtv8P97MGATBRy3DU3j0y9og4O8Uhc10eWt?=
 =?us-ascii?Q?Ymxk9orZWN9XyO6hJ/LWu7yX6eP9jeIB1u/M+fm1iWqvjijlcTSaLl7FNV6h?=
 =?us-ascii?Q?2ay4Oq6PGAr8QKzVM+fqWu64nFaK/YpszaE5N9FVOdS3018qQ95iwjNG/jMC?=
 =?us-ascii?Q?7ZZCR1tfte/RyrlXrtad4nEIflsvZLTrg2xDJvg6HCMVdF1MogB7u43g8F4k?=
 =?us-ascii?Q?rSJKK2EN0liJDZLzekWG4p0lyJnaEzJ1ZNwaK5I88frhKrN5wwCvzwTd98yp?=
 =?us-ascii?Q?/LwWxNW7CHZ/hmwO1u0//kGIt/mItrDE2PjSo7J65eq2I7hukM+oDX6/0rMT?=
 =?us-ascii?Q?8nulCNO4H/OsKVm75e1oPHGfz3sldiGWj68B/hHxUy0ggRsJvW8hp5xZmwld?=
 =?us-ascii?Q?Qp6ZcmrLp6NuWHWtuRLBl8QBY7DD2Vs793XnUY0RhTXlTTNnOB7z6v6Pg/I7?=
 =?us-ascii?Q?t77riqnMuAfjce6M50UlS84Pud7Q24iwCsG5gvA2nzJZI8OdFjg5TuI8iDet?=
 =?us-ascii?Q?n/0E88lpigAubEZlobxAiej21f2aDM9HZZs4sWpm1zT7PhzHPysQf5bLyuOU?=
 =?us-ascii?Q?Z8mtWiNs2TizjDl5ndo0P7cQfarnopq95rMVP3QZAPIcEF6ifxQqujMYgTNH?=
 =?us-ascii?Q?REtRkKM0Bhz1qdTtNUTAoMOVPc1yKDKGWRKZ15O5sIx3htVM9TPwjSQZx0aT?=
 =?us-ascii?Q?TYlgO9a4lzM/1SApav7ko21pFRkmtnAngwbzenR31yPgUhs9ptAYkOYcbdjR?=
 =?us-ascii?Q?D+jC+o0pzLSHJ5kd0n/++agZZF4fbQc5/85zOsgQZR1gqOK8FeXh7K+uzjQ5?=
 =?us-ascii?Q?gvyuNg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3547193-c975-432a-e779-08ddfaa8de12
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:34.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS29m05wgS/DvxBGSnaqyiKdW8B1WiPYaKwnPxdruTPBC0Wj6L/oE2lUF2T8Om2Rg//yGKJTmNYhxxJt4gp1PsyQ0EgMGJAL8vQAiAVbpq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfXyQIIfy4xPtBz
 WkqTd0tDAy8VMCz/p/0GIplnToftDvO+RUMcYMSBmfy0/fNb9G59DzRHh2IFw3o36jHcgBK/z6+
 aDuLWB2pKOPdUdMbBL1AoTItzqzR8gwWu0n6SFoBSYXB+QAuKxGbyjWmsCUNWM+2TNuT8O5XH33
 YfQfXtWglrFIE0pT5QvFK92Bqov0v1Q35TE6iwu7Ec15zlDoHiHdq3rgGfQGs+3tgJdUYmJBOXp
 2Uw7hzKW45Z7s1v1YQ+j2MnshPywvGMNknEzjDqTT/53JQsawxTUf5YjHZ/FL4HeFYx7I7Yukjh
 dJBh+SMcDxKUSPUdfnCnrTDJ6oZu6XfyF++PfI+DZzvXpqARM/nsxA48kMcpIk=
X-Proofpoint-GUID: xH30Mnr7zpVP0d__qdlmAchJ05E809Nm
X-Proofpoint-ORIG-GUID: xH30Mnr7zpVP0d__qdlmAchJ05E809Nm
X-Authority-Analysis: v=2.4 cv=LOBmQIW9 c=1 sm=1 tr=0 ts=68d2a6d8 cx=c_pps
 a=0ygdBYYpfQySzMJeDTx3GQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=VO-VGI-_H-TUAJbT1awA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is the more typical naming convention for QOM init() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 30f485fdbb..52561900fd 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -344,7 +344,7 @@ error:
     vfio_pci_put_device(vdev);
 }
 
-static void vfio_user_instance_init(Object *obj)
+static void vfio_user_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
@@ -468,7 +468,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
     .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
     .class_init = vfio_user_pci_class_init,
-    .instance_init = vfio_user_instance_init,
+    .instance_init = vfio_user_pci_init,
     .instance_finalize = vfio_user_instance_finalize,
 };
 
-- 
2.43.0


