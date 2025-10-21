Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45212CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9FO-0004F5-Kb; Tue, 21 Oct 2025 06:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vB9FL-0004Dv-Cb
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:05:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vB9FI-0003oi-I2
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:05:39 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59KJu7AD191170; Tue, 21 Oct 2025 03:05:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ksim63C1UgNGRcZETbwakjQjfB5lW/umbE6RzM8Fi
 oc=; b=IWiUSGmKvjNcsTJouNMrGVYZp2pxY1ii0buMNzw/orJ1zQw1/a/3pB9wT
 18U6E6LeCf6MXP3orTAXclA5kuPjegfLle4aXTTuv3jOlJj0nvNHW4ltirVMR+58
 bJHxh3ctury2kvYzRAiFsJBXPJlHhebOCL5u0itvnBF/ts4StgN+1tUpVwEHSl0S
 rt89QkY11tJdCkGM2/5/M85MM3fJN6/Sb5/tFzN0ylL7NpHz2Vy8OOrVRNvEHlnY
 dayJ6epLh7T46BSI3u/L7lFEkx8aQqQyHAyrtizdqq0g9Qj4DItrwEesAZdClGma
 7kq0a7kW8f53twfo1he2Rd01ZbI5w==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022080.outbound.protection.outlook.com [52.101.53.80])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49wup4h71d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 03:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sROdM9kHdnHSv9OH2P8XNv32gRGhGdjVoa3L/2p3VZx1eE/pFMnjnXs8rlBjtcujsSZTnDDea8Vie5yads5qBgQLpEP2+NhWkxpgfHfLvz42wvCmgPLUyFocmmqDuH7LwwiH6p6xhpNEKEhBXd3PW4TTVaMFxh70k0in+6M2r/If87wAv6q4gvL+hBUxkLc2D78r16h9Cinx+pcKg0Y9tDWFmthUredlI8VzNnF3748FMPqRQ+nSF45f8xRxOw7ihBhDIT2Ado39O7glKBZePtFoEvmXneXyhsghHTSIQBfIOnAU1ZjJv4ELgqYWf6bQdbFek0KzU0ANHqUd8zo8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6UAW04CklJxqTzjZcTADGjJ0RGHTDrXaoBMoSiTU7k=;
 b=dcEGCfPbL3Jq8sd/b1zCzfgmEuM5TvjSzGFtyZxZHy6cPE1BYdJRKZ0C7FjXht7mm7q3ddv2jJ4x9mSNd5giotbztWDiozJryJpMkOjkEIBvG5jKuY2vdRWTqliIphIr6dpGDH42BJVkwnHQBzGSja8l+PzmT5ANDcG4WKmt1nFo0egGfSeuhqMIiZXJbqjfTJ9JNmYQVf3q19xLyfBlQVg/sAz37KdpCxIEbw9cvCPUlN3A/OQYCeqE+16N1+q2pwx07s7l+9e4EjJnMXtUUuVTC6/rKVtkylJK5KyjqXcir5LsXGRtTR9CwH9xLag3CEWg46rKj6SDcP6TA29aIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6UAW04CklJxqTzjZcTADGjJ0RGHTDrXaoBMoSiTU7k=;
 b=KDn6CgJTDkPYOTYzayvB4eNNaqwdyJdSVpb34KgoDrc4pXcl4Rnt0udi3FVoa+c6fjMLMLwkwosOqVD2wK+5DMkiX7WXxBbwH5nU1f84otpDW9BBv8QMeXVQ1wYEVh4lze9e6wcqK/fv4ZceokI8QEspjpxMyyuxr+h4VwCYNAyu4oukzohn3/RKdRpJ3kQY3dZLVLtSOJERK9SV3eIK+BsitTauW9vva2laRY77yd3dgzOx9DT6vKI59UQFQ8lMNoIR6YWsESJHror6ZdVscM0/70/dn5WeBpO/70G2fvh/F9P3lHr+Dx08QrR80rgHeuxT1D/I+RMKUboFqVp2SA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ2PR02MB10003.namprd02.prod.outlook.com (2603:10b6:a03:55c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 10:05:28 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 10:05:28 +0000
Date: Tue, 21 Oct 2025 12:05:21 +0200
From: John Levon <john.levon@nutanix.com>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] docs/system: fix vfio-user console example format
Message-ID: <aPda4Ri6qHXWA3sj@lent>
References: <20251021093550.766872-2-clopez@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021093550.766872-2-clopez@suse.de>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0481.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ2PR02MB10003:EE_
X-MS-Office365-Filtering-Correlation-Id: f763ab68-2752-411b-0dab-08de10895c53
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?1e7dktHlILCaO74bhxRoMC7erdcL2ET3tW77bhzYgJlXP4bHDMRmnCl6Sh?=
 =?iso-8859-1?Q?C5GSnRe6zQ5daOiH3iKBGadpqrypJUi9pOrMeMydt8m4Xl4ogFd5kclPGL?=
 =?iso-8859-1?Q?t1cWLes6vN1gnI9av/qBwiO5PyCxOI70YOPoSiXINkntSDnBzJFJyvNVqv?=
 =?iso-8859-1?Q?bPpzIYda/p/CW938spfxWrM9qHAe9vgoP3qVCSTYZU+A/rGxYI6AG2mTqE?=
 =?iso-8859-1?Q?gI7Yhiuu/VEpGDv/Bj/1ekFk5B3u59u4cEtdnw0yE+dumiVztAS2KR4nzk?=
 =?iso-8859-1?Q?L7Ln1TBNyX9hmMwP4PAI0JprZX5ibqz6knb7UcRjMpM+9tx+O4C9QBOoms?=
 =?iso-8859-1?Q?E+ZXS3LVTSwm/mjCdVyxrynX3abCd4Upn8rPydPoCAAtiX+3AkP/HojNOd?=
 =?iso-8859-1?Q?yUhyLE3DH0Pi6xsLtPgYwfOjI14JMv4SVK1TbTK2I0P/Xq/+VCmIH0n2xw?=
 =?iso-8859-1?Q?zJstupub+Tf6nLGKyYwGLxIyxN5RnaSgQ6k40BpQRqXpUHrRENrWjYgLSx?=
 =?iso-8859-1?Q?U9Fw1AptcXN6AmbkdnXGgqAfVjv4W3Gtb9lmMlJEPz3WPYV6rFzB+5KQUs?=
 =?iso-8859-1?Q?8/XVluz5nNZoMcMowF8dwAJ4BgOUSAGAhjIwCCyNpzXORSbH94U1psePV4?=
 =?iso-8859-1?Q?tjctpVK2hIjAEOzw6wYL6NZgHEs8CnAQj8Er7PSk98hW1512mcYy8m2442?=
 =?iso-8859-1?Q?uJ/FqrygfgPHZrFQHo0WafBmJxlJKJInSz3xWEx77ZxfNqVuuP4Elioo7Z?=
 =?iso-8859-1?Q?4f1TcKrPmLwBtbZ1DE5M+QiPXdXI+24+vVsprB21cRADuXVYXdJj4H9LZO?=
 =?iso-8859-1?Q?zPFBOxm1He6oMQRHhcOHLvmiobgei3sbIY6bUz4VfPGXWyKZ4RpyiTfQYC?=
 =?iso-8859-1?Q?0w3RyQZH0UpXecYUv/4w9+D7fh8G/7CmooulTHoo3uFnloSFGESAtKsrgX?=
 =?iso-8859-1?Q?cnYDFo4Q0tgsUmnABZoDe3wlQ0YS8d7R/hMhV3b5J1IJX8j8rjHFXEVBD7?=
 =?iso-8859-1?Q?Q+lrXMGdyPNk753vdkv8xucX8dPSc31VkUmkV0VGV3eNTnizmzfokl79Ji?=
 =?iso-8859-1?Q?eEGugm12CDBGTGD4+OWctA2WfJZ70ml/UAbtgwNyzA3cH6RBnZP34FNaiT?=
 =?iso-8859-1?Q?Xy5UQbybzDkc4o9ttPmo0jh0fDPfccAZjam/bsnNzITgk9mlowe8xmPa7C?=
 =?iso-8859-1?Q?uJt63WnQ2Kvitl2DmmA2Tce+CTBXqPZdVtV1xw7Z2Tq6o58MQrLu/xrENO?=
 =?iso-8859-1?Q?mpjZS5dFx3kI5U2rVkf67EABhyno0Jwe8uu620m65vC3zlVaa34E232D9S?=
 =?iso-8859-1?Q?9Yd8OT31wlSqmyc+UL8XBjbgDfcpIZaWnM4+KCFnsyFnQdfUJKSpq2g4kZ?=
 =?iso-8859-1?Q?+wqAYreg6MxmbyjIoMGXv6uXJ1KoF7c7nsPwdlAaYxOncM0sGVeX1g3v3y?=
 =?iso-8859-1?Q?hKNh5xx9yp45QpnV8Uq4GNB33S+WP7psT3kZMnZbIBeQKGLxRsfHIXLQBe?=
 =?iso-8859-1?Q?XSnhoNIZGGoKUK4U65vPaA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kEv4sPxth0+xIcKTAwDwHA8S3E5x7Q2eR72L9gs5gQBsd4szcO6xZd0nxK?=
 =?iso-8859-1?Q?oJm2ta+4HoaXqjjCXti5C9ztqwJt+ad+EPqLae9OLFFoEy/T8KohS6mKfp?=
 =?iso-8859-1?Q?z/UaSuvf6k2z3wsI2S5S/MARp8Lw/U/yKko2+DwWf8PNNAnXl354ltlMtR?=
 =?iso-8859-1?Q?ZxdjhDAt7ORBiuWgBl8HjwlTgshlHGddxR48m6YeR16C5xxlT8gMP2raaC?=
 =?iso-8859-1?Q?ywk/Gr/DhjVWcEH66LN9u2VVwYqZSa/iiCBiWFyKhLaK+3JaCtFY3Tygyi?=
 =?iso-8859-1?Q?Yb2y1ewinT2PeTuiMkk1huNdWDOYQoR9VjNrlTwB3Bk4sP7uaa0KV+1FOw?=
 =?iso-8859-1?Q?5E9SliFFupCKu8zbb+/K1zDe26rWF7du3nPJq5bAGF3ZeyAJv0sMuxTeS5?=
 =?iso-8859-1?Q?NXvGk4spSUheYtxqUJeIabsZQaexXiGSk5JW6b3UHt85WXlkm6SKKP7fLa?=
 =?iso-8859-1?Q?eUOHdY4t4Qr1bTTo/UyFLMt1rwE8EX9xMosBmjzSKe8TIlPUcXEum7fRnB?=
 =?iso-8859-1?Q?b4geRMfgZjD6md9+S8BjUjKJQgn34juxXJR90/CfVg6VHnWafw2IsLmZoA?=
 =?iso-8859-1?Q?Dt1Rmyuq2sYfiGKhS4luxRTECVDpVcuUN1q8yt6x+8JbOkFt/vBwyscAdq?=
 =?iso-8859-1?Q?G254W6kWavp5RA1jMLOpfqKzqJt6tbBufldBWihdgpEcfF7hR0fD8UBfvM?=
 =?iso-8859-1?Q?tXcMFU1KZPuCobHMSWj+MoNBujWYEqgwlPLlqSoNuC+ZUYjOBjrUMA/8bt?=
 =?iso-8859-1?Q?vOvC79GZRfTWEr7vFIb8OAWyYawDOQ1XruGzTJQXvYVub1cPPGmyHPUWjJ?=
 =?iso-8859-1?Q?eq1qyZAHTfekg0s0o3iJkvQ0BFs3PKG+yPCY1UU2F07Vnrqarb98j6s4Hl?=
 =?iso-8859-1?Q?j8q2v1VhPQMPJO8hNa+dydgcN9aKEMI1n6v80eUAZBOUwiIrGJJG3ob35o?=
 =?iso-8859-1?Q?6YwXkbUNLuIBh5h3qf80Dq9VSjQJrKFiBP7Adwr01T/bLRy4EgFdDDu01C?=
 =?iso-8859-1?Q?Bw29c1KNz0rUZmkoJeI6EdCtXp6sgK+ZHy22M/KsoP4/K9zZ606p4YuwWc?=
 =?iso-8859-1?Q?rzt8A0G5frXoEebYcckIW+HRy/qBWyPf+qYa5F7SayhJlc8yuuv2sZiomG?=
 =?iso-8859-1?Q?qqGQjxLOOMIl5albBlM/Prf7rGtOMrKaVXD7DfGEKfqhZ7+oqaES6rdZQa?=
 =?iso-8859-1?Q?vA2jzFFeqQZAfPv56Mna9RJZVjtOGE/EhpQN8mNsqOmqOhAyypSWVx0e9y?=
 =?iso-8859-1?Q?MTbEIOgYv3PTtf+j7fkRf9Ox0TjovXfNyoAsrpZcWG96WM1sUoYMjMFCV3?=
 =?iso-8859-1?Q?ptCuSSH3of9GxcApEijbUPa4+YP54cJG7zf509kCOZ/N+T2snmLOjg6Jvo?=
 =?iso-8859-1?Q?EFegUWBnCVu/EuhAdL3twfYxIiWGyRpQZix9Ty8ABKxfk9BawrkOTXaGpP?=
 =?iso-8859-1?Q?Buis9Cd7NkeHTCmjigF1Eir7+9h9DweVKZdt5blu2IaLCdwoNbyW3naERJ?=
 =?iso-8859-1?Q?i8mSa94G6cxcbJ76/41XEUIFds0z8++w4wZbdfegHnnraEpDfEHGzGhvN7?=
 =?iso-8859-1?Q?s4f10cBApuuiXUjPaQs0mgXL1UpOs37huP7LhROAXXhBCqC/t45zKlMd9p?=
 =?iso-8859-1?Q?fRN258h2lBcW2R+IjCYX3OcQiIxtgDxjvl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f763ab68-2752-411b-0dab-08de10895c53
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:05:28.2844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Klrzs4M1jX0c9fjLbfOH9lsRwqm1pjULIpmsuB53dg4CeyJ26Y3Os6bGg3ohEmF8RgNuBLaAyDRZd9/XD8IUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA3OSBTYWx0ZWRfX2gllYIL4vVvG
 iMjpNtwebo7elQUtd9AXKQbor8c3vs6uRyosjHn/aWP1ZQiRwknXAWQuldryEstwROlj8kT3Ga4
 TJj7AIAZjvThoHlqSrmYmZLYu6p1/VaCG/ShwX7AJ2gTUo4rL5EnJOjxwI4LKP+f4ay7uRV3zvN
 9+FdJENj/1NJyLPs6T9jrbueYFgjB4CVZCQJtvkjI/isbfoiJZ8X7Wk4q/E3dHTIjLAfuluQy0I
 LbKMw9naZg+bkKqBws+tsMPxQuJ3xJJ1fvSmvWBEaVNGTlsl1z0QpeHIab1oAWR1KxmnoAGvJcM
 /auSJ8QSrA0fY8mVec2zzd+Mmo7bPc/vmLbjl7mitJv4r5PrplMQ2MLBphNwyUhZigZJ+PbYY7x
 aPTno3VPZnYCMFQVWOIcDcHdwuvU5w==
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=68f75aeb cx=c_pps
 a=kZfhTMRA2IuZrtsc375NMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=4LDq2OSDIuzDFmjWTbkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: W7CeCyjbv1J6vD8K0gtf3I4e25pKxl2L
X-Proofpoint-ORIG-GUID: W7CeCyjbv1J6vD8K0gtf3I4e25pKxl2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Oct 21, 2025 at 11:35:51AM +0200, Carlos López wrote:

> The rendering for the console example for vfio-user is displayed
> incorrectly because of a missing indentation, causing the example to be
> shown as regular text. Fix this by adding the required indentation.

Thanks but this is a duplicate of:

https://lore.kernel.org/qemu-devel/20251009140206.386249-1-john.levon@nutanix.com/

regards
john

