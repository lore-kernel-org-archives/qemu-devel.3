Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10135C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNhA4-000365-90; Fri, 06 Jun 2025 20:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNhA2-00035K-Dd
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9z-0006RE-VY
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556N0RtB023133;
 Fri, 6 Jun 2025 17:11:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cy
 uA=; b=mzXqVpK6NozzyFqNGxD8Gre9vWglDRDC8JQeer0EOb3KStirwgwPEa42r
 3Ek7l4Sp+6XWFiCC3wLoegwvq6/g9c9q1OYTmDIC4W0u1qHhgKO+Kwl8063Tef1h
 Uq9J+PUPXchn7sjTYUL6xhWOh5yj6UfcvsoOsc75E4YUm88dQZRpkJKrkUNsu8Jd
 d75cfFFE3i18V++dcsRnqFZCpPFv0MYGjUYfTsqzqMIR1I8ZRcAc8Vzc54vVa5wo
 6EIq8iCa/D4Y/ffv4yqYXrJHsyCK8RMs3PiGrpIsBVxWMJhp2VeC1BYlah1JbvlF
 hsoVbGrx5RVg/lxcCRmCYoedsuGfg==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2126.outbound.protection.outlook.com [40.107.212.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqb2-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTu+34QADzrjUa3+3hS16AHH/3spXpeNlHzx7trZtqPGczd4oR9+kR8FEld7aq/s+tq8dkCMrghSqhLec+KZoyvjezAq4F5JEr01GPwsXn29GgikJasXpOZP7F/pMjK4udbTEfyoYfFDTm+Z96IHh9VeNR557v9EUv/asz8zImDULqCgv/SR6Ol9ve1/gmtKlb0hXhmXCLD1y/ykZYLTTYIIwGXqRBIXbAk/fA9vLvYYN/Wakfr9rKK6GKsnHdVCWJvy3A9WNV1FNu/CzB+5qo4CFmb047IjkTB1Mq6sKcOOcusI2I0Resjo9jGf9TULXRI4WdAnyMkUzcuZjIVacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cyuA=;
 b=a+ThgQOrBpbduCQyapJZuzKaRSpGH0lUwEjG+G4PvPRL2TA99u/PVSVLnaZAuICqMqZU8yy+RADmC3O6uN+bLNJT/uvTGr8t/irgnrBTcAU0v6NcCQii8r2DyKXvvRFruAoZfRgW3Tdl4npobXOizbyqvIjYrSXbyWepglAEFCgCIVZt4vfVbEJe9Sqdc4hCMwfOaXGCjMhtXSzo8wg5XyDl4B4PVkxKTqcaj+sx+A8cogXuKTUIj+BD13D9DDs27ZHgsRoB50+y5ak+uKiQXsB/wHVUvH/vQGYOpYVjgJzBYwQSdLIOBR04DYUArBtvUFgRROMdCGtuqBwF3jU93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXd2NeK/ET6uD8gmkhbk2vh4nYzQVltKbqv/Wx4cyuA=;
 b=g2rZCOLgUR/zS20nGGF2lFpK06cwk+nZmmXOs/raKdOlJlXjt3M/HJ2XAFfLorvAA3dH77aOTw9dvJGJSZRe4OGcuBNiLzzOQshjRsjAHH/bKeyJglllQE9BQUnwKzXRl9TgphZO7SZUXBY0jw95/xHkN3pF+J5LWKb680+SP+oBRPX126AP4T9ydHcRi/ODnUuacuYLqLNY7+HldonZWbbVLmq6Tkcz700ZolrXqeqxaBGDTOw06GXAsQgIvm7Nwp+tD1fRtgKIPKjnn1bPmRzlj6nYVf2arjvi5X6KqHgk+dhLkwPXtZAkdl6AuEDwrKm7TZA0SOlmEa2Wvfg05w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Sat, 7 Jun
 2025 00:11:30 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:30 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 22/23] vfio-user: add coalesced posted writes
Date: Fri,  6 Jun 2025 17:10:54 -0700
Message-ID: <20250607001056.335310-23-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0127dd35-a6c5-4c23-5030-08dda557da69
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4S0Un5bbLljfBOLw6Q3BrwigCWqpkrrWDr67oXFzyK2Ufi209QitUx30cWhf?=
 =?us-ascii?Q?ijtrngGKg2bTyGvXcmnplsWGSV5hTmlqakKu2B2ihkunRJTIcQnquVQEspt1?=
 =?us-ascii?Q?pYp0s8jUX6ToCJEm1uB9SEWAndVMll1nyxMACarNSsaL5YQ1UU91JZs+YJpy?=
 =?us-ascii?Q?pEy5KQgvGuZMgWjOp9+0AOABDeKMgdF91oWvetY8WP61Hrrl+w/EccwOHkAy?=
 =?us-ascii?Q?UZa3YUZqAKkDl8RPE9a+PpbLbioJL+7rRsAX8hNd0oo50AFbSgjkHKkC53pE?=
 =?us-ascii?Q?VWFGwvZj66p3vMrq3JS/8Cp7yb8+TwoIh+s9h6tR5+og0YQd4GR9dBSBQ2YY?=
 =?us-ascii?Q?5nxCgQSpTiOap2X2zKVUZq97h6Kono+kbJDePgGVNDM4lrjLO/i0+HnTGp4r?=
 =?us-ascii?Q?qkx/yAt6fgf+PcABaX68Nr8u5gjg+24J8RXKQUEWqgzWOX/u01Fh1laVLLbd?=
 =?us-ascii?Q?Zsh5MvwjHKL3HUCDKt0gsw6+tbZUqi+vJIgOLORV4PXlY6V9pdM+7m6RIdfb?=
 =?us-ascii?Q?2foKFoWOo8/XPj+XtBSDD1hTVP/z5y8qrPuFlc2V97M9fS5cqkat+hTeSWGD?=
 =?us-ascii?Q?dA8/wOuI05EAEWfNEmszkmhOVvSeBt1kSnMnMW/cIfpkHtgw36dELtfHEiMl?=
 =?us-ascii?Q?TKHJdheo1CPt3jf6Ynj/LRSaPrXewB8qWDOqck9sutAmLXlxZ5mj/yVpZ7AP?=
 =?us-ascii?Q?OPcSZnnfqRNkkXCoLld4wXU6uzwihlsZM1UBBEOABl7dxxuC+fwEnTJvK+u8?=
 =?us-ascii?Q?75ASvxi6FQ6wrj2JU7RJqdx62glgLGHZYjVJM1mgstNRydncvlz4gaXZOrgf?=
 =?us-ascii?Q?TcWgm9XR8lNiO1PU3KSxW/qoUQXgTnW5Wx1HQqjRb+icheHOTm4R38h9b6Nm?=
 =?us-ascii?Q?Ppe8NgLKT3kjIjw3V1PNfqYazCl0EAFyxkrRb1xtSr3VuNSTPrINw6RJPBUR?=
 =?us-ascii?Q?IlZjY8QYTy2qCVM5G6arcXsn9pTv4v5crPqTsXiaRJCghBVU1SPh91uqmF6E?=
 =?us-ascii?Q?Gvl1s6lcsHY7eG7yFcVBkdmAoJ/XaoduXTdwJ6U0w2WI5NQV65WtoV52spzf?=
 =?us-ascii?Q?6GPNtyeKN515fp0fhbD5eE6TIJVcqn5KkIA5GMBRl82thHONXZICHfwl3HyT?=
 =?us-ascii?Q?1S3FMRqzlsVv5qxX3Ixu/G2GRpTUBhJ7u516Teog/6pyEUcRG3K3k9mNjv3q?=
 =?us-ascii?Q?nGe6lQPe9RjeCSiz+RYTojAWYO228BeelPA4PCcYnHVmJ/GsEyZZifURrKdQ?=
 =?us-ascii?Q?peSyahpyn6fxzVCxBkaxNgmh8lRR9AL5j3EZfRTcgWrD0qIEsNZvrGNYEIOE?=
 =?us-ascii?Q?2H+mPBjMhbYwdVxle9oS06mMB1I/unpEwx/+tlvSsjfwZX8CRc3fRE2RhIDo?=
 =?us-ascii?Q?X9gsVZUSDUHvUX63zRmbakkD58H+dLs0w8Z6JlP2kZ82nKvacw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTvnWGz4HhWroV03B84BQFp2SfDbgyFVB4PpzfZLRBkMbPx7VCSFMgYJ1YQ0?=
 =?us-ascii?Q?ORvgvOsSoVhieV4zRZrqA9AahlF8UXXzxZ18CXGWWFYuvV5igIuS7oYmL+C7?=
 =?us-ascii?Q?j5WY51HM3FIIAOEtpsNzsd9WNq/VKasWzz8Qb6xA9axBwgiXN80sQ+e6WCy1?=
 =?us-ascii?Q?9jh0lTcHBh9DD1Q/uf0KCClgvDqIxQsAKKRhEahFepFIyARit4nuZrnUHCf0?=
 =?us-ascii?Q?iJ2+V66SL8y6pPv188oh82UBvkUsn+IeVitggrTMZn83KQtRTn7VELtFDSdk?=
 =?us-ascii?Q?ScOu1IpTY7fBRYwPS2w0ydp6FD3VkqDS2Zg2Rfe+yYsVFlT2G0LMoSLxPefm?=
 =?us-ascii?Q?togwWqFbQQyti5ZApsp9RxI6TTTJrxMpumYVKNjfT75K2uNycyZvWYvjXdFj?=
 =?us-ascii?Q?MQcvZQEeWeIwjPZrg0D7IdND8S/ILtRXwihs5zNxYhqtliGKUf9dsWbYxZjz?=
 =?us-ascii?Q?NDmWhHtwdVUAHebhYsrgS7/XH9uz98ZgqAKYJcjXP9MLU1HoxYldw5pX5zw2?=
 =?us-ascii?Q?BkrWopqXLTZC4FcBMsBKqLcu0/EfnuC2SFP0MNlGRAE0qJBGVJ/SledHKUSW?=
 =?us-ascii?Q?jzRh+9g/mEOShG90PjTzjmOVfEaFBWb6R18uLCQ9XFU9vxlxYXlgAacqOFGp?=
 =?us-ascii?Q?rzIz4d26Id0DQ4nGtmx5Nvy69mk7cm7lSleDdgQYctXgqgoXfytze1/kfcrs?=
 =?us-ascii?Q?8yza/rXq/Yx3LXi/gpqCPcv9U5VN/9WLl6RUtztB5/On8F9MBCV0YT5dORed?=
 =?us-ascii?Q?JRzCDLpgy5T30OrZRAvni8En2cZK+CGRZ98lUJlHqkMVl3e+lju/xz+tF4k9?=
 =?us-ascii?Q?PUeU/HD2et9WZ6/GLayZ+93NfMs/k62yYsitJRdDqppTuO2JcMsqR7VbVi6j?=
 =?us-ascii?Q?2DmIRN11XcrcGb/9RkronacrbOJf6zQKGm7qbGIwVM7UHanrUZ0jZ6sJHCtu?=
 =?us-ascii?Q?zjKmUPO7vnvfP5Zf5rn0N7xCiryvhgW50IauncTIkbrl24WHYxTtKLXWH6Ix?=
 =?us-ascii?Q?qqisvvSfvR47yLTdlIkvj3X326y8ZGpAyXX2XKYzJ0XgPMs3veZ2X/vFpAiz?=
 =?us-ascii?Q?4TI6AuH0hlGWLIlSw4YO//q6lWqeDrMMSodeG2VKpzD+/gyvvb7vNhBaxiBe?=
 =?us-ascii?Q?4Ykwb4KgLUi5jmPnC5P2f/aJrM3zEid6w2nG9l/0a5gOUfsGX/5EmsuN2x+i?=
 =?us-ascii?Q?3h6UOr6tHO4PId9PXJPsZ6PokOUvwJyNbnfrwKotL4J2pdn9diMO/13Si8Km?=
 =?us-ascii?Q?o1wOcWGFFyXNTXqUI2zpJF+8KxSqmoj2omtiQfrmy4uKY6Iao8JXeeKoOf68?=
 =?us-ascii?Q?RyU1LNNU/ygzs8cncG+ErZ4sC1aJNkhFbZaGS7PCcOs2b1OSC6nLYDmuEJux?=
 =?us-ascii?Q?sv8eKO+muqv73t0/kyNKtyxZBTVGpl/hVALxLKvPTzVdhO1w+sDKsZDXydk8?=
 =?us-ascii?Q?LyBoZpqDxBG7ABii895gf0sOR8mLQfI45KxxjSXE1Xt7gIkX7qOq535GmAiz?=
 =?us-ascii?Q?M/khvV9i17S/xgGKjLLTNEHiPo008oklNXt9dhDo3lRw3XRTDVdVhx/bPfcx?=
 =?us-ascii?Q?t4hKXVpwjRJk4yK8gAnbGgzhPc+lN0vPGg2+XuyU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0127dd35-a6c5-4c23-5030-08dda557da69
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:30.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNZcYoQy6JHPjHG3GCMYBak4/63oeG7gF7YNfHsZzxh0/4ft+zyXZlENmX2JMvsduboPUEgAWvP3Mom+oYtwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383b3 cx=c_pps
 a=JomqzcHDjT5Ni/tnCvtrfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=pwxC0n7aooic8zlvp-IA:9
X-Proofpoint-GUID: 8rZo5teVQRLoszLzSTIQlTXrS9KqCpDq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX/EP+BRcMYpMw
 lwtDhph20WPzjtfmhyWg+qUkePP0tKxycqVLesNJfpfc9sM0f0yAdFtJ1B+2LCsJGqqBTiOzGQ+
 gUvmOezpWUPvc2UDiPf5/A3upgV9Erz8bCA6CUGdwUUdbOLJW4nYrzFtybigpZmgwAmDZr/NgNc
 trQhduNRPBTPQo4uyXrc0k0RG1bNGfkPamCLgDGnRyBB5oFEUItuJ+/YSvPXp809mRGOGoIMvTg
 JRS493aTk3HbA16XeQ+VSL0gLqOLqiFDXf7iox8inX3ucqsLzyVAHICgfzvpWxNWAHs6XWpEVDT
 DfI423fLYbwM6WSRQVoSk/ftYxDbFGGhc44HWZunOXxE+DXTdAM7/KXOOWFWKb58qWOBy5XDtrB
 tv0jh6An0xjNPwJjOkCS5HM+jn8AYJZpickfk5uGMmSd+ZcL/dOjF2T15UoQD+UtQXTYL0rA
X-Proofpoint-ORIG-GUID: 8rZo5teVQRLoszLzSTIQlTXrS9KqCpDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Add new message to send multiple writes to server in a single message.
Prevents the outgoing queue from overflowing when a long latency
operation is followed by a series of posted writes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 21 ++++++++++
 hw/vfio-user/proxy.h      | 12 ++++++
 hw/vfio-user/device.c     | 40 +++++++++++++++++++
 hw/vfio-user/proxy.c      | 84 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 5 files changed, 158 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 8f589faef4..f747e70e50 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -42,6 +42,7 @@ enum vfio_user_command {
     VFIO_USER_DMA_WRITE                 = 12,
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_REGION_WRITE_MULTI        = 15,
     VFIO_USER_MAX,
 };
 
@@ -75,6 +76,7 @@ typedef struct {
 #define VFIO_USER_CAP_PGSIZES   "pgsizes"
 #define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
 #define VFIO_USER_CAP_MIGR      "migration"
+#define VFIO_USER_CAP_MULTI     "write_multiple"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -221,4 +223,23 @@ typedef struct {
     char data[];
 } VFIOUserBitmap;
 
+/*
+ * VFIO_USER_REGION_WRITE_MULTI
+ */
+#define VFIO_USER_MULTI_DATA  8
+#define VFIO_USER_MULTI_MAX   200
+
+typedef struct {
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[VFIO_USER_MULTI_DATA];
+} VFIOUserWROne;
+
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t wr_cnt;
+    VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
+} VFIOUserWRMulti;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 22ed66c54f..ae09b9cc60 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -88,6 +88,8 @@ typedef struct VFIOUserProxy {
     VFIOUserMsg *last_nowait;
     VFIOUserMsg *part_recv;
     size_t recv_left;
+    VFIOUserWRMulti *wr_multi;
+    int num_outgoing;
     enum proxy_state state;
 } VFIOUserProxy;
 
@@ -95,6 +97,11 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
+#define VFIO_PROXY_USE_MULTI     0x16
+
+/* coalescing high and low water marks for VFIOProxy num_outgoing */
+#define VFIO_USER_OUT_HIGH       1024
+#define VFIO_USER_OUT_LOW        128
 
 typedef struct VFIODevice VFIODevice;
 
@@ -122,4 +129,9 @@ void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
+void vfio_user_flush_multi(VFIOUserProxy *proxy);
+void vfio_user_create_multi(VFIOUserProxy *proxy);
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index eb2194c0eb..79375ddc96 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -10,6 +10,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/lockable.h"
+#include "qemu/thread.h"
 
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
@@ -296,6 +298,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    bool can_multi;
     int flags = 0;
     int ret;
 
@@ -311,6 +314,43 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
         flags |= VFIO_USER_NO_REPLY;
     }
 
+    /* write eligible to be in a WRITE_MULTI msg ? */
+    can_multi = (proxy->flags & VFIO_PROXY_USE_MULTI) && post &&
+        count <= VFIO_USER_MULTI_DATA;
+
+    /*
+     * This should be a rare case, so first check without the lock,
+     * if we're wrong, vfio_send_queued() will flush any posted writes
+     * we missed here
+     */
+    if (proxy->wr_multi != NULL ||
+        (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi)) {
+
+        /*
+         * re-check with lock
+         *
+         * if already building a WRITE_MULTI msg,
+         *  add this one if possible else flush pending before
+         *  sending the current one
+         *
+         * else if outgoing queue is over the highwater,
+         *  start a new WRITE_MULTI message
+         */
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            if (proxy->wr_multi != NULL) {
+                if (can_multi) {
+                    vfio_user_add_multi(proxy, index, off, count, data);
+                    return count;
+                }
+                vfio_user_flush_multi(proxy);
+            } else if (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi) {
+                vfio_user_create_multi(proxy);
+                vfio_user_add_multi(proxy, index, off, count, data);
+                return count;
+            }
+        }
+    }
+
     msgp = g_malloc0(size);
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 13f2407845..dbaa322952 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -16,12 +16,14 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
+#include "qemu/thread.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
@@ -444,6 +446,11 @@ static void vfio_user_send(void *opaque)
         }
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, NULL, NULL, proxy);
+
+        /* queue empty - send any pending multi write msgs */
+        if (proxy->wr_multi != NULL) {
+            vfio_user_flush_multi(proxy);
+        }
     }
 }
 
@@ -464,6 +471,7 @@ static int vfio_user_send_one(VFIOUserProxy *proxy)
     }
 
     QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    proxy->num_outgoing--;
     if (msg->type == VFIO_MSG_ASYNC) {
         vfio_user_recycle(proxy, msg);
     } else {
@@ -571,11 +579,18 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
     int ret;
 
+    /* older coalesced writes go first */
+    if (proxy->wr_multi != NULL &&
+        ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REQUEST)) {
+        vfio_user_flush_multi(proxy);
+    }
+
     /*
      * Unsent outgoing msgs - add to tail
      */
     if (!QTAILQ_EMPTY(&proxy->outgoing)) {
         QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        proxy->num_outgoing++;
         return 0;
     }
 
@@ -589,6 +604,7 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     }
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        proxy->num_outgoing = 1;
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, proxy->ctx,
                                        vfio_user_send, proxy);
@@ -1112,12 +1128,27 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     return caps_parse(proxy, qdict, caps_migr, errp);
 }
 
+static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QBool *qb = qobject_to(QBool, qobj);
+
+    if (qb == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MULTI);
+        return false;
+    }
+    if (qbool_get_bool(qb)) {
+        proxy->flags |= VFIO_PROXY_USE_MULTI;
+    }
+    return true;
+}
+
 static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAX_FDS, check_max_fds },
     { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
     { VFIO_USER_CAP_PGSIZES, check_pgsizes },
     { VFIO_USER_CAP_MAP_MAX, check_max_dma },
     { VFIO_USER_CAP_MIGR, check_migr },
+    { VFIO_USER_CAP_MULTI, check_multi },
     { NULL }
 };
 
@@ -1176,6 +1207,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+    qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
@@ -1228,3 +1260,55 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
     return true;
 }
+
+void vfio_user_flush_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    int ret;
+
+    proxy->wr_multi = NULL;
+
+    /* adjust size for actual # of writes */
+    wm->hdr.size -= (VFIO_USER_MULTI_MAX - wm->wr_cnt) * sizeof(VFIOUserWROne);
+
+    msg = vfio_user_getmsg(proxy, &wm->hdr, NULL);
+    msg->id = wm->hdr.id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+    trace_vfio_user_wrmulti("flush", wm->wr_cnt);
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
+void vfio_user_create_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserWRMulti *wm;
+
+    wm = g_malloc0(sizeof(*wm));
+    vfio_user_request_msg(&wm->hdr, VFIO_USER_REGION_WRITE_MULTI,
+                          sizeof(*wm), VFIO_USER_NO_REPLY);
+    proxy->wr_multi = wm;
+}
+
+void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                         off_t offset, uint32_t count, void *data)
+{
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    VFIOUserWROne *w1 = &wm->wrs[wm->wr_cnt];
+
+    w1->offset = offset;
+    w1->region = index;
+    w1->count = count;
+    memcpy(&w1->data, data, count);
+
+    wm->wr_cnt++;
+    trace_vfio_user_wrmulti("add", wm->wr_cnt);
+    if (wm->wr_cnt == VFIO_USER_MULTI_MAX ||
+        proxy->num_outgoing < VFIO_USER_OUT_LOW) {
+        vfio_user_flush_multi(proxy);
+    }
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7ef98813b3..64fac9137f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,6 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
 
 # container.c
 vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


