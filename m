Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A05C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3x7G-0004Yp-CL; Tue, 08 Sep 2026 10:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3x7E-0004YJ-N4; Tue, 08 Sep 2026 10:48:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3x7C-0004ig-Nf; Tue, 08 Sep 2026 10:48:04 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688EglSJ3445685; Tue, 8 Sep 2026 07:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mhcGHoQy6oR0tjiOnhu1f/XZ5HVfw0hOZPn+54vMS
 9M=; b=MsNsZ/G5wTXoetR7nLdS0NPx4QpF/2PKiAiFkXkcppnf6WbfVbV0+TTdA
 B1ziUyMt5oQ/2CwW2LaLAHScdi3T6IuMdPKjxbFoGMLbMzLBtEHnb+cxzElNHyX4
 73YSBclZ4HUAziTDZ7G+6u6m/jnMfdteivON3MxQjsqVmIr8TtnkVmItpwnRQksU
 2nAmm5RwbCnXI0jhxmHgeNM0oTY5Dx16jjChsGnDK321tv6RKB9Y7MIjUyT9oSs0
 Raqj+07DxvfkBdOi+Snn5vEPDVj+m0DabYurA83OWq2IDZlZLOF/BN9iHj1zO+fL
 Yj9CzUySvNw+T8pRhrDt2phFJ0g9w==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022086.outbound.protection.outlook.com
 [40.107.200.86])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggf05dxq5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 07:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjNN0PxoQmq3E9D47mhQFyKQk/boklrIfOSX7i49BQjmlwA3PxRIRbqsovp4H/Hi+gAHtX04IZ8UQosxowahrryyltcgxGaT1zWWhayit/bIqMyRkSiHoAU1p+89wmU9ijWwgW3wHSqGHQ2fvKsroFAdLLQXNNsgSETukVAZYxKR7jbNny0HDNRmgdJUNyEPfZLL0jffZIbEA5nbmaG16wW3/sVPLGi4bj8H2NgATXxNrv/zUI8b9L5T8XL+F8BCW/ztr417HX+pCQqC4URMUUIYwm36n4U8p+wXBfjXZO6B2rVnKKB+CcgvPlEbLrTm8I1wXNKWhOW+WaNjCiYCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsmYfoyzhP1wNsJnoeyH6T8Hlnb2dHP2qwJUNCKLncQ=;
 b=JZ7ia5aXF0Y+gdKYdECdfTTyJ/bxeYzL82E063n1Fgit4612htLlnh8461uGmmC4VK/BwsQZKaIQFMNfAB9J/qMgiI2+GYLQcr/6n0yVnuM3c1in3BOzK6/naqjpLKMIkBcCSC4ZnHuFLAoPJ/Xul2GXQKzuQC80KTzTNruafCb+SrbSGHO7ZznQ0FhLCDFMbKaQelekaDyxxjGACBMJKVuzwaDvJ1EhLgmDcQkNvgJabPZprPrr6kZtYiRpkG7R9ekkkibU7xqB/OMcIFMiVKY/YiTXw5ZkZCWqvweOPz5JBh0eCYqLZEPQiq10BZxh2JQXrvWleLGXoIkisiX7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsmYfoyzhP1wNsJnoeyH6T8Hlnb2dHP2qwJUNCKLncQ=;
 b=yFDheOn5YHkd/1UTJJ1cRJ9PCE8IQjX7cF/ul3QbCNwQMgoQtC9BSlJ9gqInQ7zhdwla+BjCJaqtFw+FdBej1y0FvZQzsYL6p5Xt14MyzpyfwbyxWQNsGHPkDdspTNPpitqRhklX809G/vRzXHvPSh+Z3JKjMDn9D21FkAUfPoVKPdGksGYR9kqTJXlBdE9aUhtYfFndLxdeIILdsS2UuwnrvTlyW5bYpnnhiJcZwCtplAtDjHzdPc1IfQ9CzILMiF9oAuu6Gd2tDmfZ+cqpYtiq30cPt3q5GrHt9n6GtnOnWlshsacSdBrECjXMVtkGCFs+zmxMmHViMTord5zCQQ==
Received: from DM4SPRMB0047.namprd02.prod.outlook.com (2603:10b6:8:6f::16) by
 BY5PR02MB7027.namprd02.prod.outlook.com (2603:10b6:a03:23e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 14:47:54 +0000
Received: from DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73]) by DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:47:54 +0000
Date: Tue, 8 Sep 2026 15:47:48 +0100
From: John Levon <john.levon@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 5/8] vfio: use io_ops abstraction for migration related
 ioctls
Message-ID: <aqAgFCuaJeqkCQ6e@lent>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
 <20260903130833.1437632-6-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903130833.1437632-6-hugo.komatsu@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To BL3PR02MB8988.namprd02.prod.outlook.com
 (2603:10b6:208:3b8::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0047:EE_|BY5PR02MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: e495a712-ead4-4731-7911-08df0db82974
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f1+YMVGgf/lHVIqImJDOpbC+JhQgS9Htq/0JHq/Rm5RkumdxaMmikRTECAz8JxRFq6XhAFW5w46lVtsEqkFgRizNH1tB2qkJK8wVWpvTtSh+1QZYKnhTPrfdKh71+bhCmjJyqfSBiKd+RNKAaczIVEmjS5UL6Z+fJeJ5d629tcXeYrKt1cZBhjqxe9g/jX40Bv9qufEGiUfpGJ9n8tjuFlEqGu3EPKhYYsMLf8ESvYkXcNtJr0rKZOJrgL4oE8fj/EKodlBkmXFpvnK8QMlUxtGrw4QOYeXPZD/AJOBXejBZyjpflUmK9rpQ+olqbz3kyi7g6jK9n94H4YKPwFIixUqLEfgA+5wp7UC9Y5Tx1CIm3ivI+B0r5MFnEoiJqBkJ8YG2id26ot8FfEOuJ+xmMiJeE0/jehq7vKIK4QHKnAzmMvEguZTxwVsrK6eGHwvOSaN+eM1nC+V05dGhe3s0PIbIaOTjzDY5I9BvH2StMutJPsydgoGbNIvE2SoAWI78znP9Pytkwm9BmwCq2Q8KYzxeF9Upm91zrjlrD40m1i3BsGkZ8Kb8o9r66VT11pVmkT4gyzMWZBUsfUNKJrOucf+9cZS8LN6DgxCWym72gLVfg26seDcWwh8cYY2FrABX6vglmUaW0qBnV9VSzTv/ow6dmfmeqT3JfRpl6zQSsKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4SPRMB0047.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0TG7WnL4Ek/6P8fJf+rc9u4hPO1Fzw/GMGoNn1YG5xxtVPv2IEea1X3ACg?=
 =?iso-8859-1?Q?xDtMbsXLxqymaPckkcZySDWdm5W6RrUorR/UEryVERoFjZ7Zscvnu/3ovM?=
 =?iso-8859-1?Q?CfPFCMGP0nM5eMmhG7NHFWv3L8C+YEyW/Si2YpfE2vD5vCUo1FZPU3Q3GA?=
 =?iso-8859-1?Q?rtjS5KjHGXuWOdO/Qr4iRECc6jFzvRu1+p+zZ7pSqt8gM3U9q7U73ARzGj?=
 =?iso-8859-1?Q?X1EPi5YpHnvM4XiOQF6HqncW09toDqSoWlhg24l3tzAfvOtGFed68fzNlH?=
 =?iso-8859-1?Q?JkU2GT2RLJtW3YwCkHhPVlISiieIv2zx4QtIXTwgxJ/dn6gs/uKrY5FH/w?=
 =?iso-8859-1?Q?xJy8BlQftMxkTciPWFZMQnqX1eznWTljbg2UrLFE4+/ov2Z85AAx565Br5?=
 =?iso-8859-1?Q?0PCihvQw0PC1Yb9nWTRDmz5/omTcfpqBU2oIqfkGTsiMblhxS7JvclzsP0?=
 =?iso-8859-1?Q?VcRV+3d8gkhDugNO2W+6I5R4KKj+lj82HpOJAX0BuYbBWqOZ+CARPdXlqJ?=
 =?iso-8859-1?Q?GmRfgqIo9nidCVvlmyey39KK1bfmnHllIr5x8QxXgYvYTfjb9B9Vu2ohs1?=
 =?iso-8859-1?Q?ZsoBtmN/aCadhpOLxwP2CO1oNw6QiTMPrNXHT4bxJqhL7mtZ7ve4FhIkNF?=
 =?iso-8859-1?Q?HgbVn2y0GOWd/wOv6Lyj9LSTsxZMs707JHkjGlDQ/nuDVRVl2WQqnXkn80?=
 =?iso-8859-1?Q?aP0EMJeyaAViKCPDOA+zAdbUUrCgwae4v8uo3R26WE2mq39yHZu/GOBle/?=
 =?iso-8859-1?Q?qJsKZQDDNLL/gtEwE8VwCQaHl6VMxqSnJcrqdYWzqyr9ARlt6slbnCt/rt?=
 =?iso-8859-1?Q?UB79fh+jP0uHt2p1Wn3gbbPU1Yp6B5WBXBWJbBZBczepo9OL4/Bm5Hsq9M?=
 =?iso-8859-1?Q?qU4eYQ5p6r5ouajlupWKGJWx0iouMx4FRDfel4PP8tpJF6+yUgZL5aQGgH?=
 =?iso-8859-1?Q?fa7tD+DZAKx2uGr1HLFl7yJFHLAEwfWXE6//+Crg5QVaN4GZkaF3CYEE3O?=
 =?iso-8859-1?Q?QIs47HhQZjPvPjk+aqHzaSrh45aTbkFr9CzpD1NWc6Zb8q5afN62G0ur8y?=
 =?iso-8859-1?Q?+kVz/5zDRow9DnrrwVQvL6zixnt7690h8aciV9LBLPG3vGAZ0yPJ42K0Dr?=
 =?iso-8859-1?Q?5F/jG9650/KQRZc/5C5z3B02GtEtyYy/9m0TUVxcuvAG0nhTN0B8st3ixU?=
 =?iso-8859-1?Q?nrZkrnDb9bZhW51uZL5WTcIc+kTOMgXZik+m8JeDYWHxd3m4PZ3l2VzWMz?=
 =?iso-8859-1?Q?KjWsV7FJ+wv8Tn0nH6i4hV4g2vfOd2h9zysxolMS2cpAVz9v4AZiK/xoTl?=
 =?iso-8859-1?Q?0lhCCEBNmA1gsm8SjGD9pHADDUeWl5YIQhL7BMkGO7ICyqpwOrwBePwc2I?=
 =?iso-8859-1?Q?w0F+7L7ihmNVPF4a6F3+eafjZMAyrSGQNUTla13Y2uJ/8KK1ZdaHJ11IgB?=
 =?iso-8859-1?Q?BEOxActpSwl52GFsK1YgJreqE+DYh2mvBKoE/JiqBEWtJKbxlE+ghIrELy?=
 =?iso-8859-1?Q?30BQKPmMwnHXspKfW4fpst1Kc5sdYUOQ/0tvPXIur52IqrEqBJGjU+Tp2x?=
 =?iso-8859-1?Q?oUYnnicIyEKC3b1uyRdHQHBoIttc6zVofs6oBVLI7cjPNLtEJgTYOXvXVf?=
 =?iso-8859-1?Q?pfTIgMy4ZILU0XbmQX8iLj3SEXOmYus4P6vWGjHjzjcmA22axvIHplZtFj?=
 =?iso-8859-1?Q?P1ZGBDoXSZOaNF0mjFXI8CaKrr7Bai+hQDNHyLoyj4WI1QKRxuIwxdjASp?=
 =?iso-8859-1?Q?tN02aNA3TGkfB7TrXrrgHI5EJI1MkIyZ9WRHsd9fp+Y+CQYcNBYJVbh6vi?=
 =?iso-8859-1?Q?AynnXyFIGQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ufqbv6vOH7j1Uwzp0WP9UBH8S17/MwAy4du577cFV/7MbaUzJFO1RJVVgmuS9U/jH1IWYh23mSmkeozudSGgFZjDLD4hP0mtmeFuJ+yRgio8GakV4CnMrxTB3JLitZa1aUs4SKK4JGrMFEDu9LSSSWD0ZS45er3slgcNATJVEN9Rxypvou6E3lgFUfaZXMdUOb9Ba2ykQ0uUL0ZPqoixslDhJGQ8HmomAi2l0p92jMIys/lAELQm7U8vLbAaNwxysk5r5ssUsMQMP1X/CRJdXalkqPSE8eA9RLAFHziWLyaEHXCe7JcLDAfGco64MtV5wURTJ7WLg+mFDeDSPY7jPg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e495a712-ead4-4731-7911-08df0db82974
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8988.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:47:54.0564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPtbEhe7TMtX/yeo3GIaT4TKuv4oyByWg2UrDGnBPD8It/7M+eh2xNPhk49tq3pSXLIt9PcBCMSqSxEAn5Fdfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7027
X-Proofpoint-GUID: BlzNSA1saqNsE9m-06W9plxU5N9PpV80
X-Proofpoint-ORIG-GUID: BlzNSA1saqNsE9m-06W9plxU5N9PpV80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX2XqJQAYYX7Li
 iwh0HFFkqn/7lwb4t5oZOu2KXvMy+3OCusD0NcJXOSguYeiIohCTUvwhwyGIkLYyQryBn+LuYen
 FidOebrJg7fAePURnL7DzhK1Q/WmC/W/bJwbeajlaj+YB3cQ1Mi1t+kiE9D4c309R/FNebYEVb4
 rga7p0dEA/ih1jno/1cX0feNhxZs068kgce/P0eCpLVHxKvq/lHYnOYDc7MBQN/ccW91iY3WQAp
 Qp3DZm/5/JxeCJSrerUIvHv04z+BMxNynm/zOvVrC29GK1BOG7DJvihRm3cZ+pb6SNjORKTCoXG
 evccwqPLydx8RZuabQh6kCvpWGL5RzFc5PKKlbFPeLhJiTna2/C8eMXi6bSxAc3tfwV+pn70KFt
 iUc5fYzzg1CITTOlnSqBZOtaX9EVvrNqz0cokEA93dJkYODBQJnxQ677rsynMQbWTJ/+5rtEuqG
 LMVE7hVxD9mMFx0Onrg==
X-Authority-Analysis: v=2.4 cv=PoKjqQM3 c=1 sm=1 tr=0 ts=6aa0201c cx=c_pps
 a=9PhP5jdPzEAvW1dfnTQ6sQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=EsTMC6apF9YMVk7yNpEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX4HKvHWrRa3Te
 X3e2P5cWHXIMRhpRB+kV4TT31XsrYP8beAA9PPmkzqnlrX+9z/JvoVd7UTOUsOHQIk23UUHd/kG
 ryD9URg7vC7+W7wL/A4sdZE0fUUaJsg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 03, 2026 at 02:08:47PM +0100, Hugo Komatsu wrote:

> @@ -247,10 +247,9 @@ vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
>  static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>                              uint64_t data_size)
>  {
> -    VFIOMigration *migration = vbasedev->migration;
>      int ret;
>  
> -    ret = qemu_file_get_to_fd(f, migration->data_fd, data_size);
> +    ret = vbasedev->io_ops->mig_data_write_from_file(vbasedev, f, data_size);

I'm guessing Cédric will want the wrapper functions for all of these too;
otherwise, LGTM.

regards
john

