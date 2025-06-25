Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FAAC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpk-00084G-0T; Wed, 25 Jun 2025 15:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpY-00081Z-SX
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpV-0003kn-IG
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:47 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEoMMb018767;
 Wed, 25 Jun 2025 12:30:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h3H3fxLIImpA3+uMFRcbHSmeNviC4QoeybtFHFgYg
 qI=; b=xTs7e7MOrWHUaLhqIY/ReFOnSncEcTOcyvD6jGs9J6K6ijHYu7P6niXR/
 j2jEuSuMzq3dXmd9fHZh9jf6S1P6q97u4xdbOw6J7RFfdihs94r2ZMbpI5b/T2Kz
 yWd3tIA66+9pHOqKF3OVkZZvzwrSCdiP0k3b8TSG9Sd+89X+rWOfigdnsSYLIays
 oiyzqxSDj3de3A6hDVJtVdV/AoOB3tNm4agcFiHH4OxksjU3MXERzjdREG9BcWRN
 zFBgs1luXe+/9ElB5hq6EWcaXK0oo1D6kVZVnEz0VOHQTxCK3wpA3/tATuhTmbjZ
 ly2Fw3AQoWOak9GkhjEqGAJ8tyltA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2124.outbound.protection.outlook.com [40.107.100.124])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0hhty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO+XTAh92NPA+acYK34I8KaHTSIoFx+Kba7hGjG921INJ6iXm56YGpe1WvfFAwnCvH2gWCz7zt+Mv9u3QOqAwGB+sFDNBcAkQ7Tc8GNrcvs7Hdmmz6LHojroCb4iNf8S0adALL1GCEBP64GuBamrZr+AhV6J89GyteuIMyBfROUMkX8QWvSv/Cz2QGETaykpbiw1cNs2f3KHJ/c84/GXqijB/zxdgP9st5GwPnKpsx7TpvALf66KCnBR28LNnDMlJ6BMgFliyFeoX0ethJwAHPNwgJaH8W8ttW7CvwugNjlSLdsG3BJs90142yeKe/9ashnKhAK1BgwGN0nCnMpInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3H3fxLIImpA3+uMFRcbHSmeNviC4QoeybtFHFgYgqI=;
 b=IwSe+Y7N68xDtF7OFVllVsFUVFeea30ksfIpCUv4YyUcM/eGl0KhHxTXgxnuZj9QHgh9tfqHCzPiUPrPEXdBto7xR5JT1NwgJX/VTGLPznecjPwsqGktu3m9E5PyuH1fUyxlgG0iLvSUfNXoP3c/LTMz2cIVp95ZuCOB+41FaW45312K1APvDv5gpF+YaVY88WHACYQalFFDrxyjJLYbozuU5r+kAK65gZ9Kf5uycF6tvJhWf1IrP60yBlQuFb3TKc2xiV+kr+NxxgqroLL9qEBIufl0i6npQ1H01GUX5Xk73cOVlPVvVWQSyOBAAZhaxI6VSvgrzYVN3/4+CRfMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3H3fxLIImpA3+uMFRcbHSmeNviC4QoeybtFHFgYgqI=;
 b=YTXxOAhKz71LBQH34yNdxBfUZKyfLdQDOhrVCDa6/AJC7NcuaOBVEIm2XMuveJOgn1UVrCo0J25yyCb0hFLTG3yQxnZnMIvJUsu43tT5pxHN4NNQXwR1eZ8KLtWzM+TG/51OltUrAqPHrHCUH6sdHybm4A+/9QK+CbC2rc4ekC//W/LpUoW14frynqVLeHG6NAEY9dcDCjsWKIqo1fRQqqsT64HdgkizBKF9aIcMK4ZOD2bh/VGEkqrYM0ATzvqNq9Uuj4R1dGwiSq84/o8gwqqLFpFYTkM7W6gh2U5+uVkF/euHzMvkALe4F9zV8B03KCdGKw+N79VC1DDOQMYiug==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:39 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:39 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 08/19] vfio-user: set up PCI in vfio_user_pci_realize()
Date: Wed, 25 Jun 2025 20:30:00 +0100
Message-ID: <20250625193012.2316242-9-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ded493e-54bb-4121-572b-08ddb41ec452
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OHUggPP6jKOuKt3bZ2eFa9UX1pFkQbu3+4rTLM4dMS8iOVYsssIC5lRckuGO?=
 =?us-ascii?Q?r8JoTFaSi3C2H/2gWW0BpIZBOWJw4LLe32dPrej7aDx8R2YlUQOMiZzJ0a2O?=
 =?us-ascii?Q?Xa/nsCTk73ZOK1d+foYczYmSEJIHB5Jo8bHtD7xwlNMYyOfK8dkj2OrCzTYA?=
 =?us-ascii?Q?Nv9Zpse7FxsVtGuPrcHySMXEFqh3sMzNo67GGKEfEoqk+3gq4tASqq8Elrfp?=
 =?us-ascii?Q?+2xalmtTpKzTDtphR0vm7XbE5h977scZFQwNVL0m9BxQ4gyApH/YqTWhDtV1?=
 =?us-ascii?Q?WWrHirJ2zge6r81uJhP5GOYnNT0Sq3t9VBxO27GOoGiWFNGCT6CMTRaKCkB7?=
 =?us-ascii?Q?++cwNCkbvYIe2GGSIILxSirJzM4srBd4kFAXd3dIY9BiCpN01qI+u4Nbd8u6?=
 =?us-ascii?Q?rdov4asnUAzHaGoowaIY8frbVQqpyi5nRTXwtmGvF1+m3uWBxOsz5KZYxt8N?=
 =?us-ascii?Q?US9hjIKjxR3laWDEMpBhC4mhZRq0zlN7q8lKNrEOlpptOxgGcPDR4knuZNIt?=
 =?us-ascii?Q?FMyVgR0jvq1bgDA0upQ8s+LeAyTR/lqHWicd72iic5iUlEdbKlSgptj8Xxma?=
 =?us-ascii?Q?lvs6Dfa0JxvqrWaCR/lJBtQ3zT+VXfZiy/uuCAvRqUj+UFYMV9zDrop7vbfK?=
 =?us-ascii?Q?Fe6FIuHzDUMmaC8Wuj9i05KyL8RIp78ahy7bnIT2hnqQk2z8+mJd+Kredaaa?=
 =?us-ascii?Q?fwMdvklIaumsXG+8nz4pxx317xJZyeCvFEBQ87XWWNfiWgPhw2qt2K7qSOFD?=
 =?us-ascii?Q?b6l/JNZfJxHe+oTzR+TYXf904re1ZT0gv0n/ZXT2ixd5HvO5mDazTT9DTnV2?=
 =?us-ascii?Q?9qJFeanL1gr5bRy4BA9walWio1RiOrCf8arJ+gpc6AZHp78V5OgFDC7yR+dR?=
 =?us-ascii?Q?uOF3WGEuYE3BcyXSmEbhPp0vBgC4dhUa3JEQzR9kNcCFUIZj8p7B1Alivqa4?=
 =?us-ascii?Q?3M9gf8owcW5Qt4WmQ1VS+PgmRn8tFkNGAPuA/UM1gyL6b5tH3LTICO8v+YNy?=
 =?us-ascii?Q?yao52HnB/Y9qIppAm1iHGlpwsJebFQRU4WnE1RfnBq8oZgOaZ5G9Cs35Hsw9?=
 =?us-ascii?Q?dLOIOziURxT4QfIrvcWQFmqqgaITtvY8dTmj3zSEuwixl6R4IBVp1EUnlUYW?=
 =?us-ascii?Q?02pQqHgkdcK6X4gO0DVQw2IXvE/79LfbE6heS1xI1PxuMeOVEdB5OdJcDkkO?=
 =?us-ascii?Q?A+PgnJKSD9PBkMelKwiUC+JoiMFqMbKvu4Tyfs0DNK4ezKBqzBp69Of48dVf?=
 =?us-ascii?Q?pF+0vIgJ5IWBSb0rRGmiWuJwFCkw9ruJ2SE1JgCPs3LgdXG0GMh9pt4bFJNh?=
 =?us-ascii?Q?Clk50sVtHmEexjQmDDnP591zu5Vfi3WMCeXBjeDZPqHDj1cusOLlaa0Y0WgK?=
 =?us-ascii?Q?Z7pOEQJs+EiFOiuWqvv7n+99/wYkEqDIhuzZ5ajXxXOvdlx1rGozniVhs6VH?=
 =?us-ascii?Q?qPcg3pMEhSY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0oXjO3A8lqHA+xuTqpbZgeVrumOUkiDNB+7jRajPhvtVUhGy0pTpe3HB62L?=
 =?us-ascii?Q?y91Q8SV2bGNuSsw275Frh/+thKaZlC3NJ4DyxZ6RjvYTurhfipuv8Vstyk5e?=
 =?us-ascii?Q?eBBx8zt5BurfxP8D7fN8hH/eiwOymUBSdwrOum6ft041pHP0tz4rVRqmh8z6?=
 =?us-ascii?Q?C9SAkk/FA2X5vdoQ54kDW7Icl1UQ/WioLKkLnUdsDQmHSwJPojMQrF07+2WD?=
 =?us-ascii?Q?iFesATxjnrdDtSZ73dig6sPrriCctRDRwqUIvyEpx9pF30hP1/rIQPpO2+yb?=
 =?us-ascii?Q?EMzTtO8kzGE5sNh3f+M+SjVkOUaCmaki87tagUl8U1C5Ysw/synFqdMSDQKp?=
 =?us-ascii?Q?mmP531sXzPnxbQJdmT/M95+kFAkj7wSAazXZ9dc6KgfNq0KUUUJuiZPy6hPb?=
 =?us-ascii?Q?CkWp6yzq8DTIsKJbjJhgfOCtAxJ+NiXcLsri/jb3paQLEyqDUjtmrzT4KvqV?=
 =?us-ascii?Q?8IOQeLYLkRvqt3/pP3A5sjnLft7McdAOXsbEdXDrXT75bTDysKkAD8HkrD6F?=
 =?us-ascii?Q?+ACNJG+/yp6Ew+ZXql8F+1htzB5xh9EfckDqPnR+LYX5a9r28sO7anJHcg5X?=
 =?us-ascii?Q?P+3DHm2sW+k8szzyRpjASMe1ePLKHiragO3aYCsrJKaTJ6CyXas3xvlzdFJG?=
 =?us-ascii?Q?mdQvqUi73O4QX1gpv64Xf3aewDoR3jjBl1MvMkhJ3031e4P+2lyZkw5jy5Jx?=
 =?us-ascii?Q?k8v0QGM6kPzPOrwgRfdZMBjZbIbYTCp6B6q6vv1RwCW1FZcLAoT0MaKcfE/5?=
 =?us-ascii?Q?rFn6knbO57C8nfqge6dgfvxUH0IJ589uzrwv9EeKpxYGRYY5hshK/zlUdxy6?=
 =?us-ascii?Q?XgKeAd5qawPvCW/5r0PvPidp2gYk1f1fePxcntKDnqk1jBaohss8C0ZjNwpm?=
 =?us-ascii?Q?nlbAV4UXU0xM5bOGJs17rI/u5wZ4BezstrS1a+llQgS0hfWAe76npuUEEw3C?=
 =?us-ascii?Q?AjE14bF1oYPCVBD31jSLfFzNWo1FqW4IkHLoGz3keeI9fUZ4C33G8xg2wuQa?=
 =?us-ascii?Q?ER8RekM0q5VElbzzwF7LtCrleGGil/T+yrQLnfZ7NjlgVMUfG/h/cyzmQt6B?=
 =?us-ascii?Q?ro4mGc9YLANK2/65qO7Nh34B0Y33xVnbeV9Kz9s6SyRFjgV+OhcXEZlkG3aN?=
 =?us-ascii?Q?CsdhOHfFga08dVj9vPwtBMLNF4g+AC/pACGJ0j43LbzdnQuIWuDVTBACt6t1?=
 =?us-ascii?Q?51k/WebQ0xeRFdU+4si82ME/vU3/HPOQbINqtOYFuox+OHYF4Pq1amTVyMlo?=
 =?us-ascii?Q?O+BYUs5b546nVcSoVdIZfp2mhbXUMlW2RD4AVTQYwMWOF5dD14RnM3cud2Zx?=
 =?us-ascii?Q?NGu4mGMYgn2FE2Lr517xVujUimPFcR8DVkYJZN/wFH0dniCRqeqWBPiM9XFL?=
 =?us-ascii?Q?/WwmVXZTEHLLe0pbKp0ToDnqTbsbw1zbEcLY+G7Z81go19hKEuZ+5Tw4tiEm?=
 =?us-ascii?Q?syAhCaA0kBxXSrbHwMeH4bDKQrzOteRJC1AFhpQRO5H2N4DO3HMavbsC3tAV?=
 =?us-ascii?Q?GB/OxeOZw+kvB5us+wTTQHYly2JxhqzHEjqKr2KT4zitrmZ8oPB9fmfC9X8X?=
 =?us-ascii?Q?mgzUFgl0LWidKumfQS/noJ4Nof3k+zxgyQSpr0/J?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ded493e-54bb-4121-572b-08ddb41ec452
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:39.5061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQLgiozq/cm+Q5QxfxUS+IkBTFZbZWduYmGDqdMb1sqL3wByZIA6+biFWYLDqLrS9jpsjUX6GFb/lR0Is0ze9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX7uFldzq7Uuiq
 Jwa9Cv8S5tcOK2LAgupeBGlnz42+dcBy7M7y3jEugoQSqZCDnKTqytwkyEO2wFI73UrY7XM+As5
 Ja4ERuLNtu9mRCdlvOcAQGMTCOZc/mQU17s8fCbHxiAS8Dfp5r7/gNcRS5onhP1Cyk5gjGsroQX
 Lar5X379j0dKkakPV5FMZw3nF5b+9Nbne4GKYsFcUHgSdVqcyuZG2OU0dIYw1CMQwt58z7i7JGo
 Vvtxpu9TyWlaxrn9fMLt/JnpFxtTfafqh1YPwmJdSGeHh/NvBNqgxiSlr+2BT5xPUio+nohLK0Q
 wQqBKcxgu95YdMCOTOt/krVunvf/IxLvGwimfVLkM+b74NkgOT2yy3HwpKlqODHUBeVlybqZBet
 Evpaac00xiJC4hrcaJjw18EYNAfWyrFpEyovaMWcz8+jgv+WpphY2YsyrLCfIUnhLgGSTQSM
X-Proofpoint-GUID: Qqr34IU7pjD4diV3ltgKn_mq4wsGCQ7d
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685c4e62 cx=c_pps
 a=U37v7hwCbtcZYjemgGMOTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=uN1uQ0dK97G9gywtELIA:9
X-Proofpoint-ORIG-GUID: Qqr34IU7pjD4diV3ltgKn_mq4wsGCQ7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Re-use PCI setup functions from hw/vfio/pci.c to realize the vfio-user
PCI device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index d704e3d390..b49f42b980 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -126,10 +126,39 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_pci_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
+    if (!vfio_pci_add_capabilities(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    if (!vfio_pci_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    vfio_pci_register_err_notifier(vdev);
+    vfio_pci_register_req_notifier(vdev);
+
     return;
 
+out_teardown:
+    vfio_pci_teardown_msi(vdev);
+    vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    vfio_pci_put_device(vdev);
 }
 
 static void vfio_user_instance_init(Object *obj)
-- 
2.43.0


