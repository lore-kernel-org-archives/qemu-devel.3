Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF923C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0pu-0006Er-Ap; Mon, 19 May 2025 09:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uH0pr-0006DE-70
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:47:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uH0pp-0000GI-2D
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:47:18 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JAGQNn009757;
 Mon, 19 May 2025 06:47:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=+V7zX7mvHj/nbwG
 E7ELrtgPZLMyez3S9wCyk6zQbbsE=; b=q7gbKKGrYhugo6S5Vk5jEpVncVYgpN9
 wHatVP4T5Q5wX9OhOEYUA5JAkJnu+XhArDhUDAzVe1+j3bG1/dGOb5n8sD8otSGd
 ulXLrwJahFzeo89DczwqAw6/PbpbL5hHBJNDsmnuSwsA/yfuec6LtdtP9EFSXHue
 RTu+Tws/NsRLDL0bfqIczcPDoxjwn2CKPVBV2HwJnQ+dwLOtZHy5WRnZCGbHBBpM
 3Q1TCChNpSzUYeLK08AxKn7d7YZNcHij6VgBFJIHPHNsV8qFXfw+NRZMNoA6AT5L
 QXuHltn3EVdPwcp3wG3fYlX1k1HCmaB/kG8lRRVCh68+ro+Bvefx7iA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjhbbpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 06:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTEW3vPYP4iBnkQBNQMf83dRgtipR0And8TH6n69b/0cTunahRh9kjsOBoyE9AZzts88Iv3hpGkZ66Hjl7YTnd50VUF41Cx0uCaXozM4q0CFsDPUjDazn7Q3mR+C5KyAuMCGEQz0MxQ7UBbTg2lWa3h936UKlRQazYK+8ooK3gO/5BRNxPQhAN9idtw2Z/8rc5YKaTIeE1+q070hMCvACiJlxHno89jB+pJyOdIOqwS1Se36G17B/Vu2pxlnatU/QJzDDNVhQBd0v9ajY3S8YBHDcL3FtvUmf9TEElOk3NfzJkkaZZPmyBV07IvnUxrbcBgYbWJqrtHWw+tK+VxtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V7zX7mvHj/nbwGE7ELrtgPZLMyez3S9wCyk6zQbbsE=;
 b=EHkBWJciEREo1awIvSBYYYQ048CxGijOpCFXdo87239J9fqIIo1T8qIcty1s2JyRZw7mPthujGywEO1MElR0nafCvvRwWAsEPEZFAPg8wf8+yMPh0VBgsF2SR06uFg27BKuHY25CGZZ+DIj12EVvGFnI7QluMyLSk7mERIwXmTTwfnNi674pRsUAEcxichK6y28LAurCUBoHg9+BK8wiLYuaYX7GQGrDiHX38ayvGHraPeSoyUh+Z3cZikmroV5JUQICrqCOUGDMkPP9nQYcm4ezag5K5308TtUDVfCxUZI8HzVBKpSTRO0wNyVTX6Et5sdt8Stv/WirC7EFufpJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V7zX7mvHj/nbwGE7ELrtgPZLMyez3S9wCyk6zQbbsE=;
 b=tfrZQoWTEoRZJ15nZTcMVakjc5W6xisiTY2UhwGCwC/oDb0Fcu0bWfG/5YFOeMw8IUthtGo9QkieJrElXLTP17BMDVeeqNw4bJ5dCpYO/usQmL8GvxHzv5+qzo2pxMn7PLPevbxzZDOgBotsLxpTQnRh5X72qj8EZSOjrJOj8gaMy+6m2d+2vGnmNwcaf9Xc2Ma+sXXAldyhA+oyyU5Yz1yADi8jtNgpzRuY3cRV1chg95f+/M64N2Ek+FouTk8kybTwW7bYNmFuYMuHeUoyvYgLEJmiYIfvSo9gQoDaQjnyqNBIIMmPwLUbyXZwQ6G8MnVQgox06cmlY3wQHUvLnQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA1PR02MB8922.namprd02.prod.outlook.com (2603:10b6:208:3ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.13; Mon, 19 May
 2025 13:46:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.015; Mon, 19 May 2025
 13:46:56 +0000
Date: Mon, 19 May 2025 14:46:52 +0100
From: John Levon <john.levon@nutanix.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
Subject: Re: [PATCH V5] vfio: return mr from vfio_get_xlat_addr
Message-ID: <aCs2TBEXfUAr2ZLm@lent>
References: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA1PR02MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f4faca-0ae2-4e40-21de-08dd96db9f00
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?adSz1OMkdba6dvMKVqKtTQIaFkXMw+Le0sqjpWASgzBf01lL2H+IVGuzie6p?=
 =?us-ascii?Q?G95W6cCeOk/19PEVU7lrG+B85a8lN53hAoP+OfJW4ZDCRpPYBlMSNOSQn9Uy?=
 =?us-ascii?Q?OCWz7HUkdpIGZ9zG6fDyWaPrgbrxcVYm8lsr3O7+zgjU9zO5Nq8Krd+xrSXM?=
 =?us-ascii?Q?Ipuaq5a3CrbxV582xRDU/Y2KxuG0RmdDdrI4ZwkM2XOEXbCSdh/E4/pxHKQ2?=
 =?us-ascii?Q?yelIXdfkHrp6VdXcYuz2nGgCIDHa2d6+2nMAyDeAmn0gagir9YtsOWZ1kDUZ?=
 =?us-ascii?Q?flPrUewYZUNkU20nSCyUPBleespVEQ4w0MJ0Erg29G6sxnKj9nLFKr+LqX63?=
 =?us-ascii?Q?nGhs4sUeXA4IWKVdnICKpguyWCZIDDMcJL3guAeBLqk+MsD6Mf8rM8x286K9?=
 =?us-ascii?Q?Enepr23JIlv3HqC/y+YrXUHV7wveINaOIDJNQtaCg6nmJ2Ia0yU/8G8/LCy8?=
 =?us-ascii?Q?nnZhXFmaN50nVZVn25hIpPuiMYgxL0ONRpmOB+9qFd1qlRImK/sZV5xO5kdY?=
 =?us-ascii?Q?U2SGEYF2u8k3QrULmlF8YR1iCC8+Q86lMiaRJQBEHF1fBI+Uh1UzlBLXOkRk?=
 =?us-ascii?Q?BB13jivF7fYIku8Zte30Owfax5g+MhCrxl92t0SIQuzzVO28+/oIxnQNgMH3?=
 =?us-ascii?Q?OCxkfJL2KL0c4pyH1F6mJM77n1EVjdoSLj6j2zSILiXuaVFhR85aZ4lsUZA4?=
 =?us-ascii?Q?ZaVJtfjSMgGd7qgn72gn6jMys6wh/yA1QEh/ZQgoyHnibdnetiISDcfsP2g5?=
 =?us-ascii?Q?nAftnSCxiufcFvVB81/0I/tBGGfcMgKu4FhPuxLkbSfCIpYbc2nXB57aIpqW?=
 =?us-ascii?Q?5MtHEpttvp6Sv3cnxlDxLF/x4TNVMST9Atvh7Du+YQNtl73rAyikFlVs4gVD?=
 =?us-ascii?Q?u6VMf+82UbA067d6qMnc6/WxaNuntB/lgtJJuZzJBx8uAodIa6JSauw2sHsE?=
 =?us-ascii?Q?gGJNJubRBkKdKsdeBrdIdt79At1P+iYoErOhZP0xWK22RR3Zu123T9kQ3voW?=
 =?us-ascii?Q?mwyCNFpKqVLlPX84Ra//8VoB5UR5hKFdDwtuojE8aw5baqpHz/bSGUz9RTpc?=
 =?us-ascii?Q?RO8cjjuT/ZSoA4MPpTJjArNVPQ4qoIIj137RqzFdhI0VOb3309sfYi0VSf1G?=
 =?us-ascii?Q?UvUnZyygVqR701pQWo4OFSX/mDO6fFNgdJEXrbaNjz/rCXMHHnDSEJ1br2zD?=
 =?us-ascii?Q?vrDmNIbMdNDO5RuNlZ+QPXv6T6AIlXYzvvFrkdr0dchEgl6pMyPAPJOgVieV?=
 =?us-ascii?Q?lhkQ/xv/1capbtqQzoRQcix6zjdVToimleM/ZfDEIYiGUX6kYOSIIj7Vgh8E?=
 =?us-ascii?Q?4jGgTUzaFbRHd2inObtV7R9crdQDXvtKMg+yRmcnNCyxmdYYn5g9TcfcDf6U?=
 =?us-ascii?Q?tMGsuRW6zYw+YfrYMumLUCPwB0Qct70uEieEqNVm4OW9EBsTrUZp/EMv0TSn?=
 =?us-ascii?Q?xC4eEQmGhqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YN+Mzw3d5vOpL9FBHidFPrhc/lGwv+hd/np6j1dL3R1oe17xs0KBe0RBqcAk?=
 =?us-ascii?Q?oJsmDoAi3VnsKbtsT8F1fXsHGP4wULk48+BOtSYurSLDVkBxmP8n29VFy/mN?=
 =?us-ascii?Q?l5QtULYqthaDCHrGLY2YJDSKU73nYA2/8mobljVHAukJPiNrr/hAR/atoXnd?=
 =?us-ascii?Q?FVLxkFY+guCb8/yRh5fbtjMTSwlU4f6mC0lzwdwJIfLyIlKOGQgCqSsG/Jvg?=
 =?us-ascii?Q?Fyy3vh3LKUh/M/x3n+mousTVjuYhIKCAjEIp4eLCNDn5OAo0tgDRCk8xydFX?=
 =?us-ascii?Q?/Dij0ZQimSMtI4Abzfm8WPsg//YIcTO/UtOxwXQL0YxYlN1XelSkn2FWp6tr?=
 =?us-ascii?Q?+pckOqCbRqTb2UcdFmqnvKj77Ub/vLGEKlVRgHQsNZ90yCo+i9Tyua88jttS?=
 =?us-ascii?Q?X1HCFsHnR+pXDgSLGaO+swaRcwJrI+oVGukx7JwQk3X/GR6EPhBJX3WsskCK?=
 =?us-ascii?Q?ghUPoM14OfsWfOkw8OB189kzUWz2SmnjDgJir6xHTxGrtSZoeb3xiDuV9CuT?=
 =?us-ascii?Q?A0AASbzjDvBpA4m+FWyjJLBtvTWpKRAgKa3BbPQYwGR3w5YZB9qDQEAD+HRa?=
 =?us-ascii?Q?uhan58cfVTlW31z0EcFHLoGTn2kQ3KZ0/FSgHEioXdXcsr6nqaiMw3y9x1rm?=
 =?us-ascii?Q?gRdDJNr+8zmeQRrJtCFxKZeMFaVqco6U41GvgxIKZodGc8Dnmi4TW6ICxHXx?=
 =?us-ascii?Q?H9wwtYOJiuhr99AVkgzh6Xmtfc0ypdSwDYlQ9LqVc5QPtfGZlam0PT7kV14T?=
 =?us-ascii?Q?lpkmVwm5KZsIm5y3uwjTYklQp+Jp17tL+VK3ZM1MSIs4/4MVN5ZRrvMmLEJ1?=
 =?us-ascii?Q?0GzfPytjoeJKIU0KJAy/ogtietR7MjmXDIC43Yd0hTu4PU3rXFXTZbdpD6p1?=
 =?us-ascii?Q?NFSA1kD8NPONFfTHky2O/JTZcvljtOJYoos2SHM7eTrB8z4IKxL724pEPHBK?=
 =?us-ascii?Q?/GNUuDarg0DTXYGLC4ohsdO4KEoWhSFnF5Rg2uOQNJNYu7PsGU6Yk9EmVnCL?=
 =?us-ascii?Q?+COno5hPPiJGuFf/NzsZJBa7n9pJR6HDI+D1VeWFCE9j9ikuJEIUlrG7wK50?=
 =?us-ascii?Q?Ua6xrrPsr8wsU0tEE6a4YLIXFcaz47ABqo8UcwKQR0ddA8zPayUDARN9uScS?=
 =?us-ascii?Q?SCbP3hkgQyQip6TuecspQkk8azhOh/guMQATwlMlqcUbSl+TEBHi9gGj60hq?=
 =?us-ascii?Q?tgFP9P+z3bDw7XVQzXWFOyR8bBZeXl5cAKH7SCIPdJK3vRNI521tZ9HgHbFt?=
 =?us-ascii?Q?Hfl4WPh7pOA1JEpsGjIMBfiiekH3oI7WrIUklu4++sx+xMD2cbzR2x2Ig4Az?=
 =?us-ascii?Q?20TQYEcMu+FMOWC0zTgABQIEkmW/EWdpt+zpoP46FrpwVw9p5XXaEowB9G8T?=
 =?us-ascii?Q?xhoGWuPRwlxzQbf0wzqW4suwlKgABjZguPQ+rqn/MBMKW6MMm5cAfWwNVYAt?=
 =?us-ascii?Q?5HH7h5nR/wLuvA4GxettJFkc3/8PIaopPpAdYKNeboHpv368Zb1u9cn8wcmz?=
 =?us-ascii?Q?3qMwthWhTGCwLM7rPu3340H1VrGls+sTuojAbSCeYi8P/5Bq58NaNN+CEvuh?=
 =?us-ascii?Q?fpD6TTNIdLoD+cm2v8PHBdViXhU3WhHVopsEY6eA?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f4faca-0ae2-4e40-21de-08dd96db9f00
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:46:56.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuqHuPC372VC9oVBgFe5e83OuYSFL5PmIEozTZrtlZ3qhift0hSzu7oQ8/+0uM/Dajac0hfBJhCABbRsv+Y7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8922
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyOCBTYWx0ZWRfXwxpgCjkUzU1U
 cKQ+GBrfkOiueKWMmzKenkhWa3JQK/4OeseGIFcoWmLfgQcQThxPl+4buVifBGpdwPEWtxt4Gjn
 8gsSSVEM2av1u/fsPS1i8Hxz0kK5EJNUdDXU+VMJKA7mZ7qhZqRvDZvRpm7aqs/i77skkWLw3G4
 AMnc/6mBV6jRzDiArmMYxVkppiDYfEgbIfo2wmHMJ80Q23vp6BqoB6jbKPhJn5bzZ1+uIa5H3Ew
 AcHuV0uwTlVW8w9jkzRp/DcsE7GkygorN3a6moZDtkXJZwt9ak7rrkZlojak0VV4UbdG2vkMKLE
 OO3xQvuui6joVCZnFaSfQDRbYBeSUmirXyMhVUvJHV2VgG1EME4GLfZ/0Rt6XR1MT0nMTnhpqug
 Yk8hwZb9N1jkJbnZkB628T1wGX9L0oJrdsKxLMve5tuuyT83XxS+k4jRi4UEmfWCmReeLSUc
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682b3661 cx=c_pps
 a=ztkV8ooph0rfw1Th5QLTnw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=21BobM-6YruDbiFqeHkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: riwEmCING_98te11DSeaWvA4eP9ie2m_
X-Proofpoint-ORIG-GUID: riwEmCING_98te11DSeaWvA4eP9ie2m_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

On Mon, May 19, 2025 at 06:26:43AM -0700, Steve Sistare wrote:

> !-------------------------------------------------------------------|
>   CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
> region that the translated address is found in.  This will be needed by
> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
> 
> Also return the xlat offset, so we can simplify the interface by removing
> the out parameters that can be trivially derived from mr and xlat.
> 
> Lastly, rename the functions to  to memory_translate_iotlb() and
> vfio_translate_iotlb().
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

