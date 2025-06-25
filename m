Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E678C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 09:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUM2k-0004tF-4c; Wed, 25 Jun 2025 05:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUM2c-0004sI-Bn
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:03:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUM2V-0008PC-Td
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:03:37 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P7lIIe007024;
 Wed, 25 Jun 2025 02:03:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hAGB8B7hLVcf7skqfAbSVT7ntr2nmUuQy0wQnK0VO
 ZY=; b=RAOsylV6mKArSkJSsGQMq+m9TMG912ootybFzA2EHlMznakIRPh3ZvHSj
 Uz1q8OQ6KfFUtIMlMKmWqB6Q8obiG761AMIWEULKCB/p1hJxKWp8xbDcC07In2TF
 orzCRcPe24MQsjfHyKBRjQ3EpZUbLSQUG62FHeVh8s/xtmpRCua7mkFJiwx1Ik3m
 WBgj49gjHJEelHUTKje8HuyVUz6KmrsHW07sWsJPV5bw+Un29EOM+LNyoXfBPGQi
 5EYceVVVUKt0/RERa5oy098I0aVoJ5Ld62vRRJ7wbXxRnEGWXwtzrZGo3wGzdWt/
 yPxrzq75Cy0goy58bi96tB3M9mQTQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2117.outbound.protection.outlook.com [40.107.92.117])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0g9e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 02:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gtus+UkTwRchEdsMI4eb1ImTgNBI5HNe/DXJs3y4uef8SuERsZ4baB7osvD9sydn4sI1r5Mzj+rJNTnUiChf6L7UmRW6A9L1bapq248vLeh1juxR6TMVLHWDdYOcqd624tLZQay9uDKKJgjBzGdg7EV2UA2mBGescPuq6WSKrnb1LAfxhr/qfAyExHhpB66RaM9dBI8Yc8G7VBgftIhSyQwaKRxpmT8RbgoGkUcgDb5lz04m7FaH7WR25r4KMJMg93rrlnrORnRY8/J5QbYDASmkjKv48QZiC/who300seUQ/V6V0MdaquehpstrIbqiaQZrBdGKl9/nAnEnqOvXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUrmudRg4wMG4ktgDMNV00sLBv+NIxQpMz7byS9XJEM=;
 b=A4Df0MMQeuQS5nadMt30UHXAa0Wb+Ud0o36/K+wahyStcwATEbiwv34PkD3gL+agm0dDjG1dAxUo3rX74e+AUQPGpWF0hBsEkUy0BWyS5fqnynk2HF06GHsX0i9x8idXjDNwpMiE1vGJIyTn89DSGt0BGkbtAbWhegp+ZwoTOYPjg4hqTfefb3fNKlQ4Ocf7vSJ88Ps84tUClX0zslKueCEps80UHQ+K3RN0IgW97ldvAlIaiTKeBqVvRacm7145rWrN+StQsCy+BNjz+nzfp5Nf1oHFiJLVyhywzicmILh3NzMK7D3qYRvJpY/R1jSuEZsrtuN/13a2wuYIW30VRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUrmudRg4wMG4ktgDMNV00sLBv+NIxQpMz7byS9XJEM=;
 b=Grt2x8TxgBlzz94Iomq4UzwahD5CV7FFVi3lzp0LulAVp0XrOvKqXa+UJHUM9oe/Ze78tVJA2yOaarbdWnJAiPemjl7E0HuPB9H9CY6TlammKvEVnWBkJhcKvFJW5gSxZdID4LU/oJft08AgD6LnT6Gy3URafKGdWerYInnLFkkV6FmYLcOEumUsKNgybL3gz+ik/ztTPW7oMC3yE5QA71wljHjAdqxmuPKNDzNjzkfpZ4X9Muk/13kEgDfePk4I9x3qQ3+V2GhRbCHr73l2p0TkYQUK3cDwLxaYAfxL/FgTGco/Rur7RP13umvz2Ix9Op023BRjz5dlhGo5LDZRNw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7455.namprd02.prod.outlook.com (2603:10b6:a03:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 09:03:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 09:03:24 +0000
Date: Wed, 25 Jun 2025 10:03:20 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 00/19] vfio-user client
Message-ID: <aFu7WFPrIhh55qBO@lent>
References: <20250619133154.264786-1-john.levon@nutanix.com>
 <3757d761-db62-4d22-b16e-c634f504bcb3@redhat.com>
 <aFabYdacLpv3RHu8@lent>
 <84170782-ba25-4f9f-b0fd-3b77c3a98edc@redhat.com>
 <aFbGqm7n-xCFQdV8@lent>
 <3a0b3dd9-af16-42dc-9be9-41445dd302a3@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a0b3dd9-af16-42dc-9be9-41445dd302a3@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM4PR0302CA0006.eurprd03.prod.outlook.com
 (2603:10a6:205:2::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4ecbde-8fd2-4ccc-d9b5-08ddb3c72415
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?TkKTiLDItX1maZlXx2P7asL1S9lD2oBcTFHOHTguWO2Les3N+vzkz6TEil?=
 =?iso-8859-1?Q?QNt5LYGWOvQav7RwymbVjYT3U/bb3XyHUKtgMzkiZ6fiwy0tCHJzXxpwjQ?=
 =?iso-8859-1?Q?htEGaLBcxfTkJZGSHcEU1cs0y3hzNuhwNVgRRGNf7I06Geau8jNL9dc2YI?=
 =?iso-8859-1?Q?oPQr5hFnsIQ//M9QufZUOAu6ffFPtRUEBRakDPM7w84+a93F3NG3rVtpsg?=
 =?iso-8859-1?Q?fxVyh1rkm+533aWnPBvSqte3rkKde5U/7geDIoRkEWmBWY3aV8NTEsa28i?=
 =?iso-8859-1?Q?iJtKgLmT+mMFmx37COqWa/5tR1mlUNQDgy6ljiKmZL0kHh3HNxWBvkvsu2?=
 =?iso-8859-1?Q?aWbTTzXhB5yMY2zG9HqnyMHfRsPfFPMju58itnGNMjPLURsgAvTX6qt2vo?=
 =?iso-8859-1?Q?CLR3cxYzOT7PfwcbVaWHgAzEXsE6mF/7MNW1JrH0A1MQW3SqGXKW62/ETZ?=
 =?iso-8859-1?Q?RxlB+sh56uvoYKw/qYAV3/EBPVrbtXzQxQ9zDrw2Z/SHLyYfxTCg3XqeWv?=
 =?iso-8859-1?Q?apcuJ2SwQ9UmUa/uTZxH2RQY979FolW/eUAbsfaIPbj8o27CvC0HGpmrgW?=
 =?iso-8859-1?Q?M7fMRCtu3Nw/+xhnQSr/zsTzjxY3LQfYJOAz0vNj/i5F0kLe1PYARyfv4L?=
 =?iso-8859-1?Q?Izmda/4xiP7m0wVeCrqVzcCfBY3UTYBCDf6CIGio1No/mxGj63Hfgmn5Ac?=
 =?iso-8859-1?Q?mM47jITkmVpySLrKRb0KwcZ2a5WAEcHRXItVzdVXRC1ibxvAboi5LDqt/H?=
 =?iso-8859-1?Q?Lri/5lRRana3CTrb2ixt3pHezu++5x9Mj55CpUg9UeeoSlS1Av/FZ70hl5?=
 =?iso-8859-1?Q?6/oFVBUIfZivxdT9zU8U8J3FTy5GDhOiVR2Cxwgnx0qSq/maT76N98XhjP?=
 =?iso-8859-1?Q?/OVpZmohzaewCyxFfA1c/pdllaBlj56/8rHqliCE/VK5fWrI4WCf5kZun2?=
 =?iso-8859-1?Q?L9r2u1MowXjVhXtW3kgKnBo648ZwPdb7P0SbIBgjEAigWh75D6lIjBrxj7?=
 =?iso-8859-1?Q?whvKSgY1wU1qpWmUBONOdqn7R94xwx09VXp/T11JK7CPQcRRuFS5EBRIjO?=
 =?iso-8859-1?Q?Vzitsmgpkl46oRdMiZvp1Ghhwx9o8jd8NBM7aNyp/sa7NT/EAcm125YE84?=
 =?iso-8859-1?Q?8Bl62GUAcf5FXfrrFONIVOOzn9t8/lKDBzQmWZzGQVYOnzmMtwEg0IrPPm?=
 =?iso-8859-1?Q?jPieieCHZbHKSdpVFq9dJKhzfuykz/gIxhv/b5GxziJbJF7wv+14qKQsnS?=
 =?iso-8859-1?Q?OrUTNY5BnnASG3z2QlzuqB/iqpeKf3YeC69sBlBS2mK+wZRDXOcryd4t8r?=
 =?iso-8859-1?Q?HD3DD2VgHgJ09cPrSs+FoHRGcrlGtkuSpC4HgGrvpnQ1DpAUsUxqkmqxfW?=
 =?iso-8859-1?Q?CTF9rrz7fo5Ayd6WkCnXkyqBAOyox023mMO7xy64Ge5+n6WcQvOY1IKDML?=
 =?iso-8859-1?Q?qqrnhbkal9hO0ac78e//t17z64GyVb+lVjzjQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZD26I+5db5Ytjce9fszvexVCubUr1f7nC5hpczmLnwB26OocbDcigd78Fu?=
 =?iso-8859-1?Q?3InYtFvinkgJ9Wjjz10cRdWk47dtRsTUpHTjidRfBw4ZIq0rfw2cqxcXqe?=
 =?iso-8859-1?Q?5QDW0PdfNMO10Px96QW4BLuKtPo151ZRpSU4P3CH665D/7Fs4+5a7HJFOv?=
 =?iso-8859-1?Q?1HzHdjGH4c6SHki9dAlQ0rztuM59hC74g1pmdZc2oIRpUBaUSfzdljg1wS?=
 =?iso-8859-1?Q?9AZH3TjctTU7q41gvZxj4Y0Ew0R8ZPQk4QXdXKWgfUC3Pm0/dAzi3hi1uF?=
 =?iso-8859-1?Q?YfosFIXxuo6afr6xd3wFuvoNKMpyR7wguJAX7Bg7vVxlk6AgDdPrAQTyxk?=
 =?iso-8859-1?Q?Nc/OPwzfNW41vasNraUXZst9wYnsMcvJ8VrYQuuEF/UkPKRjaX2rMFDjRe?=
 =?iso-8859-1?Q?ClMkikpmuEZghg9DOwFPITIl6Blx4ma9ZO7EJJqiVJ1HPXIXcWk7/7sfad?=
 =?iso-8859-1?Q?bnbQvYPNiWt6UhM63mSAqWCB69nMfg/otDsbHnJWZePfHZxPyJGTQQFNUW?=
 =?iso-8859-1?Q?RQJculQL1qEgxZCf3sB7VrLeqNe4RDxqly4mhPlhYfbQpBR/vgAjIwhYSl?=
 =?iso-8859-1?Q?JeM9+Y/3QRtQHEvS4IWzPPIAv+HujlTL3OSB7O53D9mOxxfTjwfVZqdw8r?=
 =?iso-8859-1?Q?yftq5Ok0xcK83wbcoV1223YRYYf70Ng1HglRjL5WSuGX/Q8nyvHcJ6kg24?=
 =?iso-8859-1?Q?TTaIFolvOhb8vTrzoDcBVwkGv9TgBZkxL+eHXoxpDzmlP3ViEJokKQlKPy?=
 =?iso-8859-1?Q?BEQLb+TQKEjwXeeSiv55jbM/yEvUjQAH3pxPkaz4pog5hfFzfhbGQ1e7RJ?=
 =?iso-8859-1?Q?KH4osihWuj6dSX1DR1Df3wUKgr6k4xeXjFGJa8RhCZEUBXBvsYy0JkEzuq?=
 =?iso-8859-1?Q?eYb538oKZ6keFofbslZuOmCg6KjsMNIpmBkySkmBVdeDeLWGCcxI1vNqMN?=
 =?iso-8859-1?Q?3soM9dwYN23RuNkajTjHBjAqO8/PsA8P5gIAEbPy4md22rIT88Re7zKxHp?=
 =?iso-8859-1?Q?vYvGVRqs5wJSAqrGA/GHGtjV/b82PRD/P2o3zNRSroXqFVXCE+MB8His2n?=
 =?iso-8859-1?Q?s6ZMsMYJPAv6nf3VKAntTVIWWVC00lbLeWrnf5aEvf/Z9aZ91Xf8w3UIGf?=
 =?iso-8859-1?Q?BZibYwAwQcdxp757PO5sMpcu7wD50pcVwPXzXc4pFJljRJWl+NeRXl54Zn?=
 =?iso-8859-1?Q?j0H5tdaK7mO5vB4kUzthqXEBHC3xCtiTWT73Z3Dj/qsXdS2aJhS9Muu81E?=
 =?iso-8859-1?Q?8+48W7OWXbx26AyOyocWr8jub8EwioczmWwaMhMqVDbOOMG1VOq2KDwweJ?=
 =?iso-8859-1?Q?mZCoQ9hXVSu3VRFCPDmjeZygDxNf7HBPW+IA3qMgI72yHRo1mJKffZ8/zO?=
 =?iso-8859-1?Q?XZIVZM0Qx8Doap04vCUsSf3J02HV+NT7L9WQtYxXkn54YJ6OX8QxeQtIZm?=
 =?iso-8859-1?Q?oHQxOxHQLj7Vo4PljTworh+FkGqFm064QvXSZeF+7bOXHJ3jx1QJ/3Lke0?=
 =?iso-8859-1?Q?9e1j1QNVEs1aD+O2Ctt4mmQcFwvA3JhjBqPO4azPz5NjKweUWFcTZfscQU?=
 =?iso-8859-1?Q?VBBOM9xm19pYDNgFzS9dV1bKKVxkxa2/B/I1bqBx9F9ikz7tQ0XYsGKvus?=
 =?iso-8859-1?Q?zimm24/vqkcBQJlu6JfysSsunYNFbfk2MX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4ecbde-8fd2-4ccc-d9b5-08ddb3c72415
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 09:03:24.7824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9w6YAYkIJAsF9YdxOwIinZKjJjYjMCjmSnG8VK3BIAq4oRgyDNTKdUIJpqIyjlalZXBNEhDqAz8oWJkcgyyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7455
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NyBTYWx0ZWRfXxoDoL1h8/9wN
 MsAsoVhXshsoDouMBBHLWeVuxBLuSoEeW/OL+9uuHnhivZLqOH4S1qGv5Hcm8jYY0vc6ggRhKW2
 IX3EuXEBXAv/xGziNWcDbGwLpUbNwvSRjNONjVctwmxi9JgpCzfwhVwnNVCGjyzFu8HEFlEtj/a
 R5hTIDLyvRopZyEzIbP/dsAolbe3m8hmJNLodQL+TS3FhR9zqB/y+c4cgox5Oe0IBPK4bonOFcR
 vpkYkwzb4wQcgt8/S0Mk5QuSDkFGsfBmwcRKzwiVi3ZHq+a+F/oJx4+Btlhs2Qg9yNpk3mCYONv
 4fpeCrTtoO3zQlvKccQHp1DKo12+J5tdmdNptjo7yKuuNALcuoUf2hCl33cM/hcCIeDk2yWo1TG
 g3hXOXND0H7l2rF3xSMnDUgATkAwrNLfXWgSJBprfZUwK+dL4V6pwILkhZt5rStGTvFjZFEc
X-Proofpoint-GUID: -NiLMSQ7XtJFtU5H0RIM7OS1ISzVM7sP
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685bbb5f cx=c_pps
 a=+lxWXwMwNJ/f83Cu03xQUw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=f2IJcS-8hfAtnvjfiH0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: -NiLMSQ7XtJFtU5H0RIM7OS1ISzVM7sP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 25, 2025 at 10:56:44AM +0200, Cédric Le Goater wrote:

> Could you please send v5 this week ? I plan to merge it first as other
> proposals are knocking at the VFIO door and I am OOO on week 28.

Will take care of your Error comments then send out

thanks
john

