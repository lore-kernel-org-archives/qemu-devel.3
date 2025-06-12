Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E3C71151
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPiVv-0004b0-Cn; Thu, 12 Jun 2025 10:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPiVs-0004Y7-BF
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:02:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPiVp-00039B-Vl
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:02:39 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CBqrob005196;
 Thu, 12 Jun 2025 07:02:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=d9nl1wQpkxD/xJ2Savl7c1Qb/duj0zQcdtXuFFm5H
 IU=; b=l2xCPCXo+NnrAHcYQx8PVUkunp1wopJLc5U8TnWZicIHD92derRVzLG25
 FKXx9SvKjJ26y2uDzSyVDmWWQpwb7gSZjd3sOQbBWIbX7jGCmD9Cn2fr0A6Oh3q2
 /V9tNh7F3x2l2Y4ZX9NBvJ47+wYrwDb/CbH6jJg8R3eNAmsuvDVKe/311BldfGO2
 uAo3pHQmVLkh13xpnESQybOv8wjLhf5xevr4xJmsvSlafVlXMJF74gHCiNjnqlc7
 EhwrzGI4coWtxnYfU5flSuPsHezg4X/HTYhdug2eQtxrODtABAj9JONwqx44jzAO
 oY+TE92Ahes0/IyiwlDRa/JLlIrrA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022077.outbound.protection.outlook.com [52.101.43.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 477xdm88au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 07:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u30jGkH4P4V3UGEmeLt1WwfsCQCd4DHXUaxrHTJ4JlVdZ3VX38zewUYJgWqH5cA9sPLFYJVQeVmYf4qR6FxfIBKgNhi5fTCIHCLIjV9J1uHlaCaodtpUx4KzHUVPm8vScfsK3D6V50cpsyjndv/tSmFsUIyptzda/ztJsu/ZFybIXrKiBdvoZKyovN7qC1RNIBqQP7LLMzvj/Zj/ElOqbuSlIDY513NlAC7JpniBrKiEHlwaWnTVvpPFMOj8DMvNPPXc8HAP7rV493D8quEiLC/PpMLt7q7Xw1vtLeLXv/WjPjUybNhxl4Lh7348UUa3aPajwgSF+VGZ5y43plL75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiW4iTaZpEKkh5tYX9xpu+f0zFaGG2vYVvVeASmnaWQ=;
 b=Snu+buP58cBrQUI7aMcMxC07rf3wbaCpvPKiStfAxHWogghwVeR+/zh88o1ZjcNeFuV8quB5hCckEBc5j+AK8Ig3O/isWB5cT1Ncn7PT8daMgAGmV9CiAyN9AmVYFuyATQdLXMofwVXE6tuYEO66cu93tNd4O8Jp+K447bn1bhUQosKQ/kVZnB6CK/aItmcB8fvcPRjxBCCO6SGRSxSfWCXKLBqY2/5CQoyH0ictyTwpgD4iSPXSN2jwKt2CyQvSXJZIgoKB1aQ4hP/sVvfAhwkWZIvXxNNkJS4AFG8C88n3fmRSZOauS7AoaubDgJxPirw2vv+8vxn7Ae+MgpFvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiW4iTaZpEKkh5tYX9xpu+f0zFaGG2vYVvVeASmnaWQ=;
 b=m6NxG01G81TFivaLhzvou3SVeTNK3YZqv2I50XpFvN5VA3gbeKLEk5r5CI6iCUWgn+Tv4t774QoO7VfzfecYBzZ/kXPZBoDIM5W7sIQ7gYAQWhPi1XNaGXR4bUco5mt6uQ3pC0xAETxvQfFlhGsKvkEHsGGasaGTy5b/zw2mkx9iT3O6qOszpEZsTM7orqtd10paSdh17Ux9k0EB/R/7YhFBReknunI29lQ2y0IduDFDJNnMhjoWPX+x3b4UEykJ2I91TXcrY+9rjuVAGD7NwvscC5Ir5v8Z4ctf+VoX7+7Yo3mPayaHVu1LDIZnmDeEXk5snosCnuD0tt4bUWMk6Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 14:02:30 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 14:02:30 +0000
Date: Thu, 12 Jun 2025 07:02:26 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v3 06/23] vfio-user: add vfio-user class and container
Message-ID: <aErd8loXHLZB-2kR@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-7-john.levon@nutanix.com>
 <daaf6576-abf8-4c0f-9070-8dfb0234d6db@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daaf6576-abf8-4c0f-9070-8dfb0234d6db@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR02CA0192.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f120864-984a-4875-0ebb-08dda9b9c53f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?f5LsXPYN1umUdojEwdR6d+LYIkWHacRaVlA8VICgYKRMfMvaYUXzNSQUNB?=
 =?iso-8859-1?Q?20HHlrG3nGak+GNZLN5d/ZfI5pHaKkBsAiXd1CZYlWIvlxFzG8yBQsQsUl?=
 =?iso-8859-1?Q?R9g244nXJqKASUAtehUdhF0J1QDHDJNpUhpmAZgOM/D6Onq0KDItUrKNHP?=
 =?iso-8859-1?Q?7Xuxz5clKfai4tXlDfNMWJo/RAzYhrtlvdHheFrPhIwAclPHLJQjoVdvzg?=
 =?iso-8859-1?Q?zgnc6jYgEr/vqR/snnj2UUYw5eIGjLXjnYksVE6P9NDjG3Ooxh/+v8HA4m?=
 =?iso-8859-1?Q?Lipi/KnrBZLCdz26pJBmqhZ+lDFAyvU7Qxm2cwcrl/SgC7AzIm2/SgYN4j?=
 =?iso-8859-1?Q?MtPkzGcheUxdIgiwhQ+qLXyk71en9bBU1Euc9DhrYDxcHDxh+GCeuHtI+e?=
 =?iso-8859-1?Q?Whm9QCDmy9MrQ+AjpfAQtEw6Z7LFz96FedWaLjDMLg9DPjbbR3G91vTupo?=
 =?iso-8859-1?Q?j6KQ551SBJS4VuuS0MnGTCPKkQp3SJO6JHkVslkinMvRTSLtghfZEz0k7s?=
 =?iso-8859-1?Q?1RgUNs3MTIT5fff4yryrbSV6i+tffTnf8jYbZzJArpTuDPlghARLTJ71r5?=
 =?iso-8859-1?Q?6vN7XdKOLZfkJ8faRNP3xNNOIQliuTMz29WI2XcPx0zLpL1+/C4Fu2UW+n?=
 =?iso-8859-1?Q?DMEln5FMuxgk9BronuCo0/2pT+z7vlbXKB9toVHFtqmyrF8DQNTXnuVlEq?=
 =?iso-8859-1?Q?2jWHoW21pBZqDT1SGTt4OMo8U/ycMOGduW/hii4OOKOnwclKsEWCGRnrIM?=
 =?iso-8859-1?Q?jfICivbUAcXnH8Po854plKSJ2A4AKw0e8G8kqrEYkp02ol8ZOAO3ugGio2?=
 =?iso-8859-1?Q?qN6lDyInjXhaO8iTEE1lkFdq5tLJF5C78zDC9jWs3/YZghV+IkKYZytalX?=
 =?iso-8859-1?Q?jx/Mfgtd+PvbKjzdr7lWsmjarKGdGKa9FoSVY7zmOy24aMuaxFkCltL3LO?=
 =?iso-8859-1?Q?XGF/3HwA9dXwwLOem3ltQiztji28YjZ4GIe3amXETD4D0MV3yYJ1X+fbO0?=
 =?iso-8859-1?Q?iK0vgBRaxdh36ltiCTnm/WwW+CPYs4FUh0z8iNxMmBWASo22s8J4SaADD/?=
 =?iso-8859-1?Q?BBfpYFQ0oQgQS1HmCGepQCKhtmtnR4McNyDEDW+rGuVnGLRgvpEuIbJhEd?=
 =?iso-8859-1?Q?sEkd6L1qBiY7T3Oe/nUJq90jxnBkSU45N9H6sI/Lt6fwaGx3GnVX2Sru/G?=
 =?iso-8859-1?Q?tpKyyLq1XN67IVU21bu7NBsjAZKCgJ0WloI51iWNE6xeDoafYJBcGk27R4?=
 =?iso-8859-1?Q?FvNSCf3WEei46nDGh24+Wx6LhrrxWAOHR+7md8riL2ITy0kd6vnY2+1OSK?=
 =?iso-8859-1?Q?gjMb9oM5K+cSzQW8/ztNcde4UvROPL0f9I/OAwbfqkw2FAvAGDF2PjWpcS?=
 =?iso-8859-1?Q?f9destbQtdeujznsoeEmkWEbgTIw0PdswdLpThm2yYeQMhAiZcHIZplVyO?=
 =?iso-8859-1?Q?Kz7IInShu040xmJ2iBaPfGbhFJh/SXTNZTl9C1ZkkwudFcnSx3dvMai3B9?=
 =?iso-8859-1?Q?U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NXplg0yboGmEuvT4KKJ202rz4Lr9A5IDHlVges6lsuvsBysCjMwbCLiunT?=
 =?iso-8859-1?Q?pX95LTPahG313XLNHnnSmFIt7oRbL/2BThdDqvhgKUjbiOYQHVAE2qRGCv?=
 =?iso-8859-1?Q?5zqpdtyBxJVRk2RbSu9K99ksxer8Im5sblF6gkkNbs/1EJodFWo1Mgh+U4?=
 =?iso-8859-1?Q?ySL/rVRCss/9gem+hDE1w1CoLmmzNmrXL7OAENPwdFXMfPyeaTEJcteKXk?=
 =?iso-8859-1?Q?pTpu+8vwYEX4PUGVwDvnPnhO/6/VhPdETNYwNJ26v1A0mDRB6HpfXs2N1F?=
 =?iso-8859-1?Q?2RM54pj4yiPMItPGvyXTcAhSE7TM2z8F3doaSNxDTyBkLy+GCK01PNaxeM?=
 =?iso-8859-1?Q?UqyqUoOweuBQ6R51YVdkFE56EpwQg1nPny9iVb6cX5l0/PucYYe9RsvmJz?=
 =?iso-8859-1?Q?rjic1wRL1FH+dCmUVl68/DjqHb7fDHbNVH0ZNmkge1o/Fxj7bhSEHb4tiE?=
 =?iso-8859-1?Q?5duno860X5J5atOWEqB3MlMMep7kWfuJ+kChMsJeKG/nj+X88cJrCAduc9?=
 =?iso-8859-1?Q?m38q4/vfLHCihB++F5GHpnUqs0U2ouFDKYURxKn3zJN+93qXaA/LRYadf4?=
 =?iso-8859-1?Q?A4/CvbcYJGceqgVvjKkv5WWg8hV9pPhurf5EoOwFZwQ2hxQjN4hBzY6hjF?=
 =?iso-8859-1?Q?gXTqPRTZ5W1zscXI75qDNVCuhhd90y9iBocmvLMs+aLQZ+iWgJk+KQY5Ac?=
 =?iso-8859-1?Q?35I7S/noVncbEaSDSzFDhCiYSeUxKB0nUfZYx4zjTdpFY15ZGr7WoUTM3A?=
 =?iso-8859-1?Q?sEbiiZ+zUspvJZ0AC7k94nWnbB/UXRPba7n8Z5aNzBC+3+RAjTLENSI0Zh?=
 =?iso-8859-1?Q?aK8aKcZXBecn5d1lBN4745wseYdgkTyWwwM6ZB7D1h2ml9nkXIS9fbBbu5?=
 =?iso-8859-1?Q?naG3BRCXIB1lXOlKyMJCllkV40f89isKpqGwpzOuGf7WPb9zs81QtcT4yy?=
 =?iso-8859-1?Q?/nw4ghxTEeNA97BF2Z8RXWfrFXJ1OzwqZO/lsUoByEF5S+IiPLhPa5ArmX?=
 =?iso-8859-1?Q?pYR+H+gNGkz5zSeI2EONKu3F6qLx4qfzjhGuJnNBNMRWQQiR8f8RYjLf4p?=
 =?iso-8859-1?Q?2ppGnmuoevJBrOiMpNt2tp4ssJCQkiyNKmtd5kU20s0TbhxtDLtSArJSQj?=
 =?iso-8859-1?Q?Y58zaoEtwhaqeqhiizXe8vgvjNC/ZYEiVaBWuarttmBWR6cSM3kR/GqYDk?=
 =?iso-8859-1?Q?YmqK8QU1jHK9PGZpCKsQtKlrJSdCoIxImIQRpPVcWb8QtHPyuJ40fWxqxo?=
 =?iso-8859-1?Q?nQKcE5LELRulzBebvBrtr55WvFUu+qG4FBW2tASaabkMgAtVDtWQitZHNh?=
 =?iso-8859-1?Q?VjhmfdieZ+i+/HfapMu6PYo/Fv/fMAriJOwOe29Z6rCK3Nxo75r5v4vGPi?=
 =?iso-8859-1?Q?m0gjelzzCzkyeOHVAez1lFBTF1eWm2JcLQaJ3XicReHlYHQOUO1mH3cy2B?=
 =?iso-8859-1?Q?6gbEz7VNT8USLOJ94r5VtsdmaChyGp/QzFd4EPrlF5xL3VgsOlOJjAtvqz?=
 =?iso-8859-1?Q?5YVvNg/ezOJlb1frxUAuss8UUE0/SGe9eJbxRmBosoaO7wQGA7cOYfDFOQ?=
 =?iso-8859-1?Q?Pr6lrIwnhT7y/np+nu40JkC8d0s3ncXTRM5Xi10ub5jCeo8KXtLWY++Uem?=
 =?iso-8859-1?Q?FUBLvQPcTMjIcG+WwWlq3usKRzdnOQ/yLc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f120864-984a-4875-0ebb-08dda9b9c53f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:02:30.5477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufTkE1wlRD5EZGNgrB7QPJ7qt4cb/5th7fLd28+hQDT2M9x+nm3ayoe89D6ioEqWktQT0cIajEwt/YLuOo6wtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
X-Authority-Analysis: v=2.4 cv=TeqWtQQh c=1 sm=1 tr=0 ts=684addf8 cx=c_pps
 a=7Kp79o39qosEjZWU4lqIzQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=rpnsFMIuDBlB5o8icWgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: G4LwGXIVHzqH92W5-a3B9niSbKXIs5IQ
X-Proofpoint-GUID: G4LwGXIVHzqH92W5-a3B9niSbKXIs5IQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwOCBTYWx0ZWRfX8yuA1pv+hZMb
 rbzAKlNPbnQIpGz/XgxUm0ISazjCxtxw+WkRnLt4+R2uvUuvS7wd0anbRv7Ld+a4edBNCvwQwk3
 /R1AVJ/fRvetygKIYPoDVvri3+WqNgXqwGNL+AZ9Sx1E5fWOKKQ/0rTV8uS0VXHR/sd7nQvNwEP
 TLcrvHbx3ypZTdJS5nWwmozwurcryECXCT8gsdZSJJJJCQVkEVMnxGKO+OKLvVu79CP0G58L7vg
 T6ZA29ZMsVNFKW1BGRVPb/Z7VtmK4oxPYbCD+kF+bJH8KmoSQMT6BBvHbyAs/BxD6+mgZsXIScO
 7Kft1ZI06N4u/uVyLu1Q79K+irdKNKbXL1vq1Vs+nstdyerhSu5jfzVle4Rv4lFV2BrE7nuXEv+
 oaJHTO/BJHICs3bvuzY5XGS9c85rKoTvhZBSpMvsveYn5Om/6vmwHE8Ab7DElVljIzhQ7egu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Thu, Jun 12, 2025 at 08:39:17AM +0200, Cédric Le Goater wrote:

> > +static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
> > +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > +    AddressSpace *as;
> > +
> > +    /*
> > +     * TODO: make option parser understand SocketAddress
> > +     * and use that instead of having scalar options
> > +     * for each socket type.
> 
> Please take a look at vfu_object_class_init() to handle the
> "socket" property.

Thanks for the pointer: done. I had to switch to using JSON-style device
specification for this though, so updated docs too.

regards
john

