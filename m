Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A4DC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3pg-0007dz-UG; Mon, 03 Mar 2025 06:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tp3pX-0007bp-BH; Mon, 03 Mar 2025 06:19:27 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tp3pT-0006DO-81; Mon, 03 Mar 2025 06:19:26 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5239guTN024751;
 Mon, 3 Mar 2025 03:19:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=dDgry0dgdnOnZ3h
 P5w9XIZW/NeB/4/PWrBLVbpKMBfc=; b=SFfQ+8VUlg7yzW73o0jRKZ2ONpVdotP
 SpCFBjbkgciuzknZpZgQdLHyDq8I1W2x+IUym+crhP8cwaiolPkyrSFeSVps/JNy
 1sFYj9QMC50Jr31boB192AVhM2/CjodRdon2l2aT9SBDBfSyEVME7K963ANk5wvn
 +vCJNqOYLOka0rtpIFqJ3UKeZzTAIo7qDwklykMZzW5aAsH6DKhpubsJyd8b0+PC
 /G8hlIYcl/L205HeSMeGwo9GQqwkhJJ/qiflkn3L4aFi1I1F0v0PSsT4DaWOD3aY
 wFb3+KGQ7qWWLwGC0mK53QPykoju/tmYKv7Nrg96LbDBZ38znDX+Geg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012010.outbound.protection.outlook.com
 [40.93.14.10])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 453yexx2bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 03:19:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxq7bd6auNP1Ok6NtkD6kBf65waJ0cuvhdsHhxONSO3u0BjJIUJShvr0SoAoLGC4nGTW81ndwBbPV2GcsB6tdd4ccliUddToa+Q1dkoo924Igrwk/q/ildSEk+unbG4f52CyHShoHdBNzcjA6QJQsI3kpcBVQVK0FCCAfCjsBs39KRK37Ril7oA0SquP+OoGIPr1Gy7doQ8x+ghdAUrPbH+bWF6X+N4duGW7chUQp+eoLAS5ObTurKaHCvWrFnPF4hmjAndGMXRxgbxgFcUZhYmcJ6zk9XGOhU8qPezunPeN0Evqq17pdNAk7T12SCCDPOm7KfTOdYKLkus8bg6yNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDgry0dgdnOnZ3hP5w9XIZW/NeB/4/PWrBLVbpKMBfc=;
 b=gBfH9+MBHzDy/rm13YiW31CoN3Do68ZD5HC95plU8GqhbuPullmrwHN+CM22axCeSuXoSTHJZQpQln11de+sxFlgTeaf2ldN+4OoeikjHR3gaNNyYv1ZVaAPdkCefe/Tsi8QBzE/jsrEUOivsAxbNByXCJQl7DpzVIdDzebW6HR8YJ/qOOMJcuX5O/qmGxJd0opKzp5f334upXx+V/x/GRfHF+BJaqJ7/erZ9i84MRACgwywPz1hqr9BytvVnPZF6FasiCT3q3HxLRgvH371PxYZcbeG0wZeE09G4Vcuv9u//UY+uBwkG4mnFPSvFmoxqULjcwkgycPJYfZVX3hitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDgry0dgdnOnZ3hP5w9XIZW/NeB/4/PWrBLVbpKMBfc=;
 b=HNawwi/eFaJR8NnyX9f1Tcwa55aaH9tnrWbl5hsBNdeetzEij/wRCYbq3P1Ium3V/8AmAHTJDzoit93+kaZ1fVpIm7uxLKQuVw87gJ85MoWKMB0/kSL8uMvnNZEc9FYSkAIVHoXwyXmi6R60yA0plDlo6LfN4IAftts9iW0gdGfxVnU6I3V3ZBZ9gJFalM9qKSGXHtoQUoWSUJ5gEBNd063SwfFdogedGDQYxGo3AkmsPGGPn9JJkvIxBKVALHF25fw/IyaVk4g60u2cJLGu0Q0q7iAIYCOCTHa/LkbLA/1LFy6nsdtoGOIeM6s6t5r79rGo8CDsF3QTJsEVMep5EQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB9198.namprd02.prod.outlook.com (2603:10b6:8:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 11:19:11 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:19:11 +0000
Date: Mon, 3 Mar 2025 12:19:03 +0100
From: John Levon <john.levon@nutanix.com>
To: Jag Raman <jag.raman@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 00/28] vfio-user client
Message-ID: <Z8WQJ3SlIui4aUdl@lent>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <C8153041-CC4A-4C3A-A11B-8F8F6401857E@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8153041-CC4A-4C3A-A11B-8F8F6401857E@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0061.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::10) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 588bcd39-36b5-49e4-6305-08dd5a4538c0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6azy+rG1/tn9O6anxi2kxUtNmdEzmZ8mEmfzjeLuJd7NW91CbaCKpzwzunkz?=
 =?us-ascii?Q?sehSx97fk4NBmGQgSMCSmCo8wla70x/nq2inhwK4t8Kbyy4wSRJtekC7qjOd?=
 =?us-ascii?Q?aAUUnjN7AlZJQ+vAJnue4w2K2bTT5AD+FA3G91+8msNKukJh68pQyB+VoREQ?=
 =?us-ascii?Q?ZPSXC9Xv2WMkVuD5AT0fY0RhCzJKXovSRmXrPLx4LPl62Q9B/QDMnts3BCzs?=
 =?us-ascii?Q?8wIPHF1qPj5AbNnKEffjI/sifsMXbSST3Ti8q3T4zlnq0b58DK0//nPQS9VZ?=
 =?us-ascii?Q?ikcCmQdtZdzX5pe1XEhL6ROtfrstG9VKSAcERUpi7UxxVAnco8SghKQAXzjA?=
 =?us-ascii?Q?i0n6hpCklV+LfAjPWR9iXjJugdVgC06zIMyQX959VuLLkxUfpAZYQnM1gwlD?=
 =?us-ascii?Q?8gHDRwVYqxgrgqmTqPo+S6F3KsSe35meFkKci0zx6OTbsDElwEWASaCIHate?=
 =?us-ascii?Q?F0++8P8ztRKlbqnAzmPbGyiUOJ2s7jyL6WU2YzAGlXPHRQr9Iza5QoWMZZtp?=
 =?us-ascii?Q?UCpgChwaPnGF3YZ2xPlh4HI/TihEWcqBPMlBn9gZCpyFurXAFjkdqIZB19wn?=
 =?us-ascii?Q?fN7K2nC6wmh1OQ2m3G25XiUYnXydQSTEmWJNAa4FuYJmK4TkeIjJjzICCKvv?=
 =?us-ascii?Q?LO3W/xTME5xJnZcmtZ0Be95yg224b7nxc+2C1RjFAJhVT3/ZwjWcf7rN6QoT?=
 =?us-ascii?Q?0orsQah9H10iM+rzj2Z/vWxHC18pQ5HvqY1AuBnjQy5ZUbXWozdZz6MR6IMO?=
 =?us-ascii?Q?1Wr9VPXMGh5ycBbO9EGPCZtOxsrw2QYBhgHa7Bd+KWeLgqgnoFTmsCcsZ774?=
 =?us-ascii?Q?vkUm0p77U3+B4ny6SqQglIcpyLHbeGrkqgSTcnvUs2SIwh9Ao9oIhLaYDXbN?=
 =?us-ascii?Q?dw8xHqVWqqiXnet/Y8hcf6qK8xAR4tADC9r75W5e8xYgZJr2LQcbTjju5BOy?=
 =?us-ascii?Q?yqmC/iwMHKQLAC+FMayzk5SMzbWgm6RRNUD5WOIIC1HMxU0DTZyb7Yjq0r4g?=
 =?us-ascii?Q?fD+GeNLh/0L9mt71ZYUQkCof1+x9PNHhNzU7aQUc0ri0KBMObG9tsryBXZAu?=
 =?us-ascii?Q?ZvUk/D1WmQqr/RZc7Y31+rl16UTWzIoxK8qv8yPjevS/RbZE0kHUnnpZiQvq?=
 =?us-ascii?Q?DQh4OSeVzX3FCOd23ef7uTV0wAtWt+Rjj0ms1CIiSnNuyqBLtIMvVa1eebfv?=
 =?us-ascii?Q?UXttLH2fbUSnYIHF2x/DWz3bsLDQgpGsgtTgfN772M7oMsYHTc6MyuGNThEG?=
 =?us-ascii?Q?3ChFgvesDNIxb5I+neqq/08CWIR5oso2WeIgjZ9OSXUMIU4OxNrmzHEjqm9E?=
 =?us-ascii?Q?j9GR8fOuBNTKQf8OU3DBOTdLPd48mfVh8+bgOhjdKyC5wRXIEs5eDRYa5KzF?=
 =?us-ascii?Q?wDD9vPzp8cGxqFSTxVcanMr4u+Qm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlkxisCdXqs5B1wJqX+xCQmwxgAbQhDe6zz8ujd7obVHgRhKvCzvKgnv8zWA?=
 =?us-ascii?Q?bsAILO+yqoUWZrEdX5jzst/iZDfa07miizElxv1Qns8dLgaMrH6Zje/wlR0w?=
 =?us-ascii?Q?O0b+DjAANFc9agPl9mDuQY95FG5YDEpOKFh+ddFUvvt1eluaCf054OqvMVX8?=
 =?us-ascii?Q?qoG7w+BZpkuRdw+522lUHgms8B3gTzE0m8ZfFylmj2EOs31FOdrARPe6d19O?=
 =?us-ascii?Q?7N/Kyz9nNV8zwOvfHDeGpwLrbLqduaN2xDiX5sXQluZJgMZs7SzdUgjlj0Un?=
 =?us-ascii?Q?dXXFSAYV9Cn+07vU/Qlfemr9N5/e7p2xkE+EKArNWHUvzODA9Q4/iRg3sqmd?=
 =?us-ascii?Q?vKkCWhSmiXg5HRQX0btWw0gHL9t98f22YXF8jTyi5g5B9v00oou1b7sxWOtC?=
 =?us-ascii?Q?Lfj9ycK9J+F8jIYnc4fIVQSZ41f6bLV8npmUp8BPhON6Yr3G2jPXoftLDeX6?=
 =?us-ascii?Q?TaTmXUejPv0nohAUkWiTvERxKE8Hx5xUAXxP3HjDeuwwbNdqGoB+cbrIl++M?=
 =?us-ascii?Q?IqdINDQQ+jkYJNTCs2N2CxdL0Kd965FujC9Ltw8SUVRQeMmJgo9/mN6EZDf7?=
 =?us-ascii?Q?XzjYPH4U3h0igkvcP/OI2H5MF/QZeU4y0QR8ge1wICvkimAsvN1MSdCg98rD?=
 =?us-ascii?Q?lKcQO1cZWR7ztlIY8al6dfBz6aZ+/18Anpk3dhcwUJZJspfccWUEyLkZsnvH?=
 =?us-ascii?Q?/eKH+9QVCzhuH06mdN7eGyXZtZv9znYIcAV96cSJQm3rKc0SNRr5Mcx5HprX?=
 =?us-ascii?Q?Oljjl7X6SXO04+TAo4gKnqLBt5sg047xmykIffG0htbYmCg6jbRkfr/poLCT?=
 =?us-ascii?Q?priNQLEYolj/5vGOpEi8yiQO86KfXwyH83TPG61u5rKM4bq4oI+jzyd+oPMU?=
 =?us-ascii?Q?O7DXzt9Zt7jN7AuG4hZozNiQbcw7JdxeXU1LNQ+rxuVuhMoZOwWlzTav5uzN?=
 =?us-ascii?Q?3mG7ulBUL3b85hVrEVfxmZHQyW0kb3wvQBx5MnT3a+QLYu3mtdddQSZ9xNmp?=
 =?us-ascii?Q?ef4KHG9hOyxsPaJmXP5b3RSV0j2xvIRBvyFiNUe3Ak9PrlnJUKxTGDoE/ez1?=
 =?us-ascii?Q?MlOVPYNbkUsEvpCGg5KbD9nDHEwVaybdvOquzHmHAJKevPHnK1tkM+a6OpgM?=
 =?us-ascii?Q?VWRy8gKPdxyEvyyqoolEJ8i+SLp8XrJLFdLWP0LxSxEA9I8DkQ99aUwNR+ic?=
 =?us-ascii?Q?odqIU2K73sBfsBBSJR0j4MDrmOraJIoIHo5WPnDqAD4jM+b2PVydEI0sBVfX?=
 =?us-ascii?Q?GbA+xpJrrxAtumK5DRLNeFcEUqHFfGujPYo1cmpVL0DlOKNh38tFP0OU4exs?=
 =?us-ascii?Q?s625ibN0K+CIl2aXiDe3MHig+VB0HBgSAV7CDvJooXLMYe35u1SRYkYY/qJ6?=
 =?us-ascii?Q?1/GnRShqrg7A/goqf+2ObjWCPZQFF1f+34L68qM70bh2OKHOi3aimbwvNkUi?=
 =?us-ascii?Q?2k3190+gyciypClHbvcD7IoR/HyvcUJGj+UpvPiVeWZVgBKBiov6GEWTyhd4?=
 =?us-ascii?Q?uH0ScjkEWVNsjsYU0X1K1R6LuGPvyDyZrVcQ9hglop4m29z/Ua1m0L7G8Y/q?=
 =?us-ascii?Q?Ca5kfqCXE9XDCn9/OIzURH91fxrb+g0tG0p5smpd?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588bcd39-36b5-49e4-6305-08dd5a4538c0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:19:11.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cySME9urlbQtjhqXekyEw6vOPATLD4ZCrjVim+37M54+RiH1TALieXv8y+/FlVpv5a2BfEEYCm2tPAdc9lEIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9198
X-Proofpoint-ORIG-GUID: ZSyKf4VPkrWcvrVMlbvtuiQ2jYwqC7vt
X-Proofpoint-GUID: ZSyKf4VPkrWcvrVMlbvtuiQ2jYwqC7vt
X-Authority-Analysis: v=2.4 cv=DbLtqutW c=1 sm=1 tr=0 ts=67c59032 cx=c_pps
 a=5L1ZokDb34JZJib1CqSWiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=J8_XLSkLB7HLWxu0EZIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
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

On Fri, Feb 28, 2025 at 05:09:00PM +0000, Jag Raman wrote:

> I appreciate you posting the patches. I didn't author the patches, actually;
> John Johnson did it.

I'll adjust the Author field and fix up the "Originally-by" tags for the next
round, thanks.

> You could use your name as the author since you should be familiar with it
> now, and I can review the patches.

This doesn't sound like the right thing to do: for most of these patches, I've
at best made small changes and JJ should remain the primary author, I think?

> Please add the following to each patch so it recognizes Oracle's contribution:
> Co-authored-by: John Johnson <john.g.johnson@oracle.com>

I can add these as well as having JJ as author if you'd prefer.

regards
john

