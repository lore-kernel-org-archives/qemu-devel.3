Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC707C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpn-00085R-TZ; Wed, 25 Jun 2025 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpd-00082K-Au
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpZ-0003rB-NT
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:52 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAkUhQ006957;
 Wed, 25 Jun 2025 12:30:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YxMHKKbdXd8YZJD0Iy1oIU3OITBXEu/+2TxCD9ow/
 fM=; b=nGZJkVzjINpoaNL/pnlJwAqYc+Xln5wT4e+UpyqLtoPOKha+XPqKyquRE
 plfhx5qieJ6EDbmDSps7Wi6kvpuc/y0Lo1Z4X9/TNBnwjaWinO2vhozWnOgzkPLE
 ANPoc/aeGHURQ1A9FlOEKG8RnjVjgx2IT6AbNOSJ7WPaAW/fSJriPn5FXNWt27O6
 Wtwpbde94oJHLKmENBGjvwvp7bM+Ux9IC0F+qfqqTwL1iWIpm1HvQlbpBKdP7z6W
 naJ0uhy2KBzi3hyxhzv4y+Cdx3z184uAQZ0ubbCb79MyTjt5o6s9Wpfp+QM5m5Hz
 b+tzJkb41PTm0LRemxfyshdWlL4aw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2120.outbound.protection.outlook.com [40.107.100.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0hhu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD0v6xQIKi2r14CDxOeeBssUAVLsHEuEJB0/RbemAQIcrRIXFT2QBDwr1jqS5ZvstUOLmg/0/3X3eyni/2SrX4GmLcqQrlJWN+PxDEMPRrFg+SRBZLmp2JuKpUYHsVSYEbc+oGoB7QVN5RcUAFz0aV1St26w3AYe8KIiBPNyqfJt58x6ss8j1rGnY+VoXwz+YVys60Nh6YbaQ2mO/LZGAw2uhxo6AwuoeKZGPMiuwDvGRmHSJF/XUA318EewjIR0n3tm0QC3d8O3SVqtbYZPsw3FDhG8NIjMSnRyg6RJ7KFXSpGPG8+wG6/S3H5Eu82+iUTdombAWAY1zCZe1lQMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxMHKKbdXd8YZJD0Iy1oIU3OITBXEu/+2TxCD9ow/fM=;
 b=GG1zbmL+3pFMwcZhM32n+HN5pa8UxtVJhGC3wZrb7+M+UaIQAlvcAKovScZ2ffl9GTICRO+YMd++kHP8DGhUTJ1G2+xWw9SvzRObOAhpkHO2sucMa09l1Hykzrp5yb+/8vfJbgcZOameDtss2K2tDVCZc3/zgu/GqciSFCz75oo9lG0mZ91ezwrJxIQp2AW+EMKiTGP8jvHI9yuUoAH+oHs0EHhsA+rI+RWKRMI2Il9PSVM9/gpASiT/2Xq2LxPciyjq9yhv/WEP5lKZhVEx0O/k74WSQ2I+ljqXqtHtYB0yzMxLJxvhabVy46ZbzAG37cfWMRm/UDNQtKNNRHZ30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxMHKKbdXd8YZJD0Iy1oIU3OITBXEu/+2TxCD9ow/fM=;
 b=onHIJK6PVTh5gPUWZCPP9T20RZeNhNE0HxmXCXf6bJo3BTe0sn31h2L4bgy1dGV98idZ6t7C1JRd0jbA3vgU2Vjg6FiqtFMlugyrxHA7/YhDsMZ8HpEfNgE9sk6oWxUHTpdUpd02WzUt5JDWI4nJzlF1p4ygGTLsUyRXB5o3ccDZHdf1mnv663rbC6lnRxVWh+xdWor+7/P+QRDhQMZmibK9+BQBX7GdpzrFDOkHybtIJ9CX0PTeYbOI/wFfCkDsRt4+mLO73H3iVYfHKxYDG3XmdVZQkCr2/HUy6UA6aLgGzYl+STr80qRblhbqXexPFyabOyGGucLi6CIWSVN/HA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:44 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:44 +0000
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
Subject: [PATCH v5 10/19] vfio-user: forward MSI-X PBA BAR accesses to server
Date: Wed, 25 Jun 2025 20:30:02 +0100
Message-ID: <20250625193012.2316242-11-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17a05c8b-e86f-476c-eaf7-08ddb41ec748
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+d29s85mU2N2/w3NauQe30qfA5FzTiDdtCXniBJp8+QRm9vI4Pb13TQ8iNoJ?=
 =?us-ascii?Q?2ezKzGcMY9AC2TghGTQaE+0sv404Hb45nJDbEeDibcPiMX/BPQ93kZFCwvHP?=
 =?us-ascii?Q?OHIQeyCSBTJU7thiZrU7F3NXEsjSF/9q3Y9UPrnBEV2b0vx/X6njPYCUlhQw?=
 =?us-ascii?Q?U9Y+6V2KzE+fvA9pXe8M/1zSk5Vs1aZ/v69m9aYwoKd5OBhjKXFTxy44+iay?=
 =?us-ascii?Q?Ezkii2hKCtiw7nG14rKDqkeHtqlhkQs9SIyIAgo9UQuT56s+GG/S51PTnkFQ?=
 =?us-ascii?Q?WaDzl3yVRkXThiUiImX9KwYSuFDX7j54X+I8VyRECzAohkjiIiBex4amBeir?=
 =?us-ascii?Q?Ez92k2bv479O+i/oE3n6dONgyk8CcUZErMmVfppdxCW3X0Fc97EzBNPrQu7F?=
 =?us-ascii?Q?TmDOFOgnv1kwn4J2I/ikmJIYoVd+yWQeDg2V8zPJbctJZAYjDPFVugEgqltM?=
 =?us-ascii?Q?JmJn5ydEOD4SvtcKh4uUTrHcZz+wWLlw4Rdn73RVNJeE2b1ulMqydqttvtns?=
 =?us-ascii?Q?lyP7MUDYYpYtkKBl4wwKGlKc24PiVm/1y26Z2jMIg6H1xvc83wogKPoz4lW0?=
 =?us-ascii?Q?6s5YmQZ1yPOIFWDTej/UNlMiiy/JioNsayYtSyeaYiQigcMuohEnKTFbcXz5?=
 =?us-ascii?Q?XEA5aY+VZiYarLYYaJWCGvCVdBxGg8tG7PJ0TyrSIBOANIU94hZXBYdtYr0z?=
 =?us-ascii?Q?FUf4VMwu76tviXo1Ad+t6A31dfMTDM7onucOWZ136qc+bGG0AsHKJNIse1UM?=
 =?us-ascii?Q?AMyCWasG/wZ2jJE5tkuoE8xjxreJ1ho8u4wZQsLugFTkOhWJcd8xgQ9PxXcW?=
 =?us-ascii?Q?q0UwQiH5j5OL6xPgPHTxVQpFPlJqd7vys+kI4owjFGHw97s72gbIwmmNG7fO?=
 =?us-ascii?Q?YzL8cITxVJCjlbXmD8xYx7H/ylIlEVoXHua8YCumkCdMkT7eEPEbFa13C4i7?=
 =?us-ascii?Q?/RzZD+FLt3dPLtBnnjv0hAdGZLOX63sVAwIiQQMeOV+APGqhDRgKMDsQSv1o?=
 =?us-ascii?Q?5GKRfYxyp66ti4enw49n84rrGoYuC80o2Xtrh7yWrBmP7XkNPDP+6eb1Xv5U?=
 =?us-ascii?Q?X5qMCPh6qTqre0kC2knGwo6IXP4L5QImFd96rD/czAHTQMgM8/eQ2NUl7RTQ?=
 =?us-ascii?Q?eGEDhftluvGxNz8t+T7/ZlZOYhFVBN0Eg76+j7HEJRxJURz5/p6tRioMQyP/?=
 =?us-ascii?Q?sjDn4zYJEAC1f7bg+nmmalhSYkEWgD3lv4OvlziMpthULwNv1Ol9aSUTKmN6?=
 =?us-ascii?Q?oI85W9hLua2KAPd2pN4pbtKMNFfLApWCXAVEXzA4B5myBa4UjyzmuBwAd6OJ?=
 =?us-ascii?Q?JZT9ZxArtX/b2BYUkkJWGGNVKQDJuLa9cODP34Y6XKcJ1OsH5M4uelezWD+t?=
 =?us-ascii?Q?udNWOeEb5LcHGiCp8sa1ZIWkXWKoWGwawIAVVMpYlS0Isbpold6uqer6w5QW?=
 =?us-ascii?Q?vAemgKmVO9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0YpjTUbtpGTQ/xtAfEoEI8J2jpnm0a2u6m37vEPVD1eE/wo2BdXozpM6+rnx?=
 =?us-ascii?Q?yrToWORWlVmhNYGs4+jn3LfR6M1Gffcm45c/jC4HCIzQFJZ9tJknGnYHEjcM?=
 =?us-ascii?Q?5ED45Cfh1ptTlz0VNAoCNDfRQiNrAYUBypuoCR4bViqMomqL6QC0uEfZU1UL?=
 =?us-ascii?Q?fo+8Hf8URNwtLUPkdWos1zbvfpjZOlb/EDDwojtlnurXb/utOBYvdf5aX6P3?=
 =?us-ascii?Q?2E0ZqVO0RbtJBt9ygw+cyKcLEZRxYjiALsWVYh44C1g3tMtVl7lG+kELuGDb?=
 =?us-ascii?Q?QA7k1FzjLwSmqR4F68ej/2o3+U8YeCCrB3T6TYbxL6Wsj0nh2fMxTIutjP/1?=
 =?us-ascii?Q?xGDKpbbeGm8XTwj7yh8ryc5KTujK1GJUwPJtbZ9Xp8tCDjg11v9uKI/0+v+Y?=
 =?us-ascii?Q?Rep5QH1c4jk3J9UQPMA64hwc/tDLxSViMP1f8i3fVDwGI2oRf9zZXfbXkJJV?=
 =?us-ascii?Q?B5p2BDkp8ZjcWW/Q9m+2u5n+/58gY+D1U6LdcjFn77WUbMG6aZ5SBhkoYmeE?=
 =?us-ascii?Q?YaosIOPFtoprvCOQr4UmkZvpk2A2MuRsELAzlGphbUI/dDo5EpT20Bs1YHuG?=
 =?us-ascii?Q?whGobbLDIjgtG2nLq2XFTU3MVSELIBrNjs/H0czNN35EToFCQKZdBzlR52ro?=
 =?us-ascii?Q?FsYtIcclG8qtnb9W4da63tR/bFqUZRf3ABSM3RdGoubMCbDe78rcHiQYLyx8?=
 =?us-ascii?Q?ym2iqrMI3rr00imMX5KV6WvHiFyVKbOd5swb/FVKS/oGBvEfKRwiYzbHy6TY?=
 =?us-ascii?Q?ZSrQYgeTcy1f7mPzP2fdy3kOhYgfzK0eMarwsPI5Oz3SIY/2usXT4pkOYEkR?=
 =?us-ascii?Q?VlURdR8rkfwf7tMdEENiQ41vANr/HxdGuDHlw4GE+9T1my/+Xq75BkUX7PHA?=
 =?us-ascii?Q?X5SqHsGxTW/c0Lrh8PQCsMNhoNrol65SJiwsEeNifAPK2QBhXO4voJNyqSxN?=
 =?us-ascii?Q?rlGIr6k1ZHSmSPZjStVsOhPWBvTCeXmOQRjJpYKKNtjJdUTB4F+5t6YX+pdk?=
 =?us-ascii?Q?GI9Gp2mXMPTA1851nJMC6ZQ+ZYoVzj4Cjq644yV28WKBC3bWtIf8IqNd0rUE?=
 =?us-ascii?Q?7V55y8n6nPddL3i6407aJ0JXWTbiRNP+wFoZSmI7kvDqRK/oXxOQ0/YSFw6p?=
 =?us-ascii?Q?PcP49Vwx/c9Af4Wp44PHNKi9BnLlS3psdNnDa4CyZ1mdCNUXjMgkekCPqRHR?=
 =?us-ascii?Q?bFBR8lS/7NwdLjk1c2uJht1ASZJv5ucTlV9E+IyeYi29sjc7TDSzXMCSUSBQ?=
 =?us-ascii?Q?IJWa90Ixduz6PyiPC005iAQk7VTljr/vSzt06MTrM5jqxKCtc4zJZXu56PNY?=
 =?us-ascii?Q?lS1/aVR5X1NAg3b64nzEm5A4wYyhFKtELIeODJTp9Xm6YvjyMEfdaOuePyyI?=
 =?us-ascii?Q?8++Czt1BGE7MZWa6cGW0+Be5eFgdiLt6Ap2Gb7cGjKa23T+JKYPOm/4awgJz?=
 =?us-ascii?Q?zO1R0qVErv65t2NAsX91YGUYcs6MzVC1j+lx812IdH7mFCtwCwVs7A5ACfZr?=
 =?us-ascii?Q?LJbNf8w+dfnSGu1zLWr40QPYByMe6zk9+oQxTpmNKCNlnCUWEGR4wrw+9FQa?=
 =?us-ascii?Q?lUUXdr9rOWP5Wxxy7tZ42wd9Vft/XGR6gPo1M0E4?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a05c8b-e86f-476c-eaf7-08ddb41ec748
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:44.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8UiAGfDoQbIC+GGh4DxPukMjnjtaUSV3OcW9VxxH/YuwwsbFAuGp938LcQNZjldeEUhkOVnlKMTJFaWdDJ5LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX8XI1IdF2Haf/
 dJfMc0NQvwEAq15M7LdZBxRyojX7iBrhlx5bhDSRtU6v1Wbbjo1PCnPUoEgFmpDJYfc4xlCCOXf
 fE1JW86EQ0uKiQVUCNTj2OEtZ2D5FXR47pJWEB1xWigo8ieTH9pVJGaxMWWuwDR/N5UgYzzy7Xj
 iyASEJHOid5RvNIXRt3rrz3u91TsTYEgNAHfSZEynf0COVK2oEFAnBlOwpyDJiAMcldG4H/QaJ0
 7CurMGJu0XGGfCMtEALUuYRtPdPLRzAntqcnod/hBgZYtfDxdt8BK8e7mOB2Y1pIYluTeIiA7Nl
 w8EasPACZ0Joov1+JqNA4D+bp6hBM+oM/aomEFBvffPUVaPPKDLzY1gP5oDxTpnr6NJBWp/pDaq
 MLuYFtQMbCyO3NtSgNGbO0cy1rKOIZwFeBF0n9EVbatWA7b/URtmfjntEIvpCx7LiauhqKD+
X-Proofpoint-GUID: w0zcnjbSueyfCAX1_cVor1apbEXy3C-f
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685c4e66 cx=c_pps
 a=Jz6HH7vbUFBwcxwfI/vS/g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=P96-NN1LHiVJMZ2xip4A:9
X-Proofpoint-ORIG-GUID: w0zcnjbSueyfCAX1_cVor1apbEXy3C-f
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

For vfio-user, the server holds the pending IRQ state; set up an I/O
region for the MSI-X PBA so we can ask the server for this state on a
PBA read.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h      |  1 +
 hw/vfio-user/pci.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d3dc2274a9..5ba7330b27 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index b49f42b980..c0f00f15b1 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,62 @@ struct VFIOUserPCIDevice {
     bool send_queued;   /* all sends are queued */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these accesses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -144,6 +200,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
+
     if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_teardown;
     }
@@ -192,6 +252,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
-- 
2.43.0


