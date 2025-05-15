Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778D3C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanb-0002PN-0M; Thu, 15 May 2025 11:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamL-0008IM-Od
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamG-0006WK-A0
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:48 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBNZKZ014714;
 Thu, 15 May 2025 08:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBU
 gw=; b=t2R3AjEEC8v9QkWWSaLen8A6Rue6k33TTsOmohNp79sNh2LHUVD389HuK
 9qsAyQ/B691m90e4T5wRSIDnIIw8T1Apvhp00AN0OHkTvLTg6UyNVw387FXiv+ir
 i4Jv2KRivEQeVK0syaSZ3Kg9I45kawI8A0VB2s3mqRnFx+NPwkPZ7CORnBvUupPe
 +Fpi3taOTtsDetgN1sLqVLnhjGxeHdvHOR154jOaFH66VXFzbTjT+0TUxpinZmXr
 DmiwzSuvwP1ehcwk+6Vnr6Oo+gVPjtP8+Z6DApM7FHg/bZ7O72Zag1GYQ11bL2vg
 GUU+Ey2Opj0Sy6YXzCQwQMYbvUUcw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbd0we36-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDwfFHVunbCO01BcusS41Rq7waPigY3E1l9uPXFxyjeWxdfCW7X4bCVu8d/OIJmKexCZn4pm+6GF+YtrF23niVjwWhdk9ck0S/jn/v1d4sP9hhG1gPGYlnE+OwNpxSfuPFwcRn0Z6a4oxJmvMOvdTOxhsAbksUnMQi3c7b381326ib8B/S8khNszPsd2iQaXB9RW+iVNRIcHukzpUX6Tv1BpyqFLPhCZesJP06ofpytHQWVWlIXxaxH7QQh3Aj0Y+x6m6IAIV+su4G7NcqDo3JGFHk6PDshvHCT+FexDVgRpxt0z0N2dno9LLlo8sw+/VyvPG28IesTpyaCx5RpxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBUgw=;
 b=GJbdTRYNwN06GMHngUk2q/8QHi4CTCiuhxe3/5z0ATY/eP8XF8dpGQmCYJ040BqZRTalw0jOZHEPRQKepsSZRrZ/X5wGgQTP/d10P6PONMMnGaZausH5hQZVcUIpAYgKeurap0qY3oO8BkY0+p2fEcTuzRAa4FBDY8luas1qmE6iseOjEh0Lj7XTSrFO31nUwdouDBVWG35GAnnS0nVH8nmYTs8ICaCGwkZ1KwJW57B6O5EmULRx7zg+rXZJUN/s4PoRTIerXJMnWPlzaa4exWRKzQRJJGr5pvdTtARSC2ysFdPN7N0VZflQu2X0uiddLs4K3v8s2Iql7pe4D90bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYHfEYolJYtB7ztdkTtSBJXJfFu8OJVZtPxqxjVBUgw=;
 b=g8t8DKnIGmNeJGlGvRz2PxzsEwCPK2R2hG0pebESY0hx0d2MYvlccFUxFtPlrHs2CE1DTnLkiVPDImitzIPrJf/75lIe9WIaqzFxCK69PZwixZHjVniyNrGTS7hYXuLrk5Tr5RM17hzLi/66WRZGdgvw7TDr5lZV/isqEyOPFfo8xhz8ls43XKEd+/0z5FlvkKuyu+hL5wlKzwx0fUabyBQjdPtIppKppO1EPMvrlewb7jhw1evJleU6BIbSLnugixSFUZvRn+oyz7/Fe/qS8xzl3DJAOtysYdItXZTIIPSH7QBgOFykWFk0F4YYXAho/SN7OHwOkgKo4Jt88pv2Bw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:45:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:26 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 27/27] docs: add vfio-user documentation
Date: Thu, 15 May 2025 16:44:12 +0100
Message-ID: <20250515154413.210315-28-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 826a0cc4-7c6b-474b-ae11-08dd93c7834b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m2th6gPUpYxLwy5k5fssUB9hPilmwxGiuryDSPo2TOHxDUmlUQ395knAFvgw?=
 =?us-ascii?Q?g6T9yIqTqE48b+I0VLqvCibl9/2mAgY+Ua5Nbuv7KBjbyo2N1FDphXpEHlkr?=
 =?us-ascii?Q?opZnV9v12Yi8FHJvcgzAMjX7OLHxCQWoABsDaTGnrg8bDD+UtRoq6yI7J+KL?=
 =?us-ascii?Q?tZ0nVhMfqEXYpvr3bNwnm9wvs9le84huu3lmisoJTbnJZKFFvmCVeOOkl3tZ?=
 =?us-ascii?Q?P79LWUjS8AcIwWj9ETMfMvd+Tmm50PTarXYezuPGf/OAh+vnpJAEQUUV6/xu?=
 =?us-ascii?Q?DJjzh+CcvPz0f+h0ACV1KMRJ2ij0i/TCB8nXts3K5rgt3BSp0V/hGWk1eqCe?=
 =?us-ascii?Q?Thg9ZSB9DbJreOotpYOXSbC5FHmdGW2HCAGeSnfEAltxoHepsSqm+g0cViip?=
 =?us-ascii?Q?SGFC3ko1ct9VKatgnQmH8FpNUEqA85SAyHDOOqr4lxq4PxAoTqDlVutJwnRM?=
 =?us-ascii?Q?GIDZ6V0W/T8wBVSLMrDHvWgRmF/iy1iktULFt+0+bMrRhF5zK3pmz+NkZvYr?=
 =?us-ascii?Q?2N3zJ3Ao74hM9HnIixCKStsoLkLxVoAnGfDom9B/O260p99AjRb+tOoHpfhl?=
 =?us-ascii?Q?flpSb9+rYVJN9L0GpgjJTogzQpNSQPfQyeJ4eKA6Evj96lTJ34zA2wJvzjLh?=
 =?us-ascii?Q?d2wu6aJimqmsSm6l8veFrCqNU8CG5OnKREt2t6HwI357WWnRk8Ydv9RQA13l?=
 =?us-ascii?Q?EW9S3dsxhWm2WG+4sCxprHk+sKRUdnCGaF/JmbVRNdzysGtzIive2/ULKZYU?=
 =?us-ascii?Q?sF38aaKdSmT8r09YVXoM/TEvmP2/7jqRDjfdhzAFGXL6xCzcJsXuz9at3BhQ?=
 =?us-ascii?Q?SzculxO7jE4uf//ZsvX9sBxkEincbDbTPEn472CgBQWpAZq0toou1UpBgNX/?=
 =?us-ascii?Q?w+P/6hMFHafdarNR7C3o5h3cxPI7vO5FSwDlWadDQlSoVd9f3FjprMpHTZSe?=
 =?us-ascii?Q?90anAGXrBv8nP6qjLjR+39gMRY4Qe8aJGRTDZRvLM/ivCvx/WJTzeheNcMqo?=
 =?us-ascii?Q?QoLNONQc76QTu9j1krIA1bqGXXNDbiI0o0kZXbJy5pVeUjcXzqgXO3MjhL1E?=
 =?us-ascii?Q?4zrIYFaF989lEAgu7uPQ1Hm1JPXjCrV2MbgUtFL73apTAgIxb/gUeBS3imEQ?=
 =?us-ascii?Q?L3W6jfYSNhwZHYB8GuIRefN9ZkXDbUpB1y278OnwbT3N40OahrjS2KoS6Yf7?=
 =?us-ascii?Q?5O77dpwa4UZKlclt4Ucd2jPJ9weEjeByIEwrXxtzAP3q6WmpPv8bKpywC2nK?=
 =?us-ascii?Q?i0sQTkAue8s5pZ/DbW0QclZ+cCw8BbWXjm+031NGWVvs+BBJlfgzZyVZdD/d?=
 =?us-ascii?Q?wkjtm9BszbT3gnv/b0DFndQcnGFeNl6IcMi6Ou+WRlIwvPHXq+eKb1KVzjIu?=
 =?us-ascii?Q?AjqZPMo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTpTpAEgWTGqv2V6bc/sdKT7YsCv+B6IoOWEMswcnTzk00NzOf91mYXcwRS0?=
 =?us-ascii?Q?jgMWNhtPGGW4rRQ523dFi5jxcexrL4IZdS4LtTanEzak+/32WrnJPCIkJHnV?=
 =?us-ascii?Q?e3r/oy+JS0T/hEGX2VrLRKrYIkyJWw16vjJegXRYyVHNOC9RSvO5V2O60aAO?=
 =?us-ascii?Q?J4aHPj8mpZVDOenBjIf0oMfwKuRu2IjwBeoSxmV+jJmVkWwHZkJXhHID3gOt?=
 =?us-ascii?Q?FdMP7n1+65EW2zHLBJQ4RRY0aO2gZZAIw6PVfFkjqF0mnSwow9reOfb7aEAC?=
 =?us-ascii?Q?ek0r/6YipUoSLDx8xx0zSKxpP3rWp9gTbMPbzl0GxwGDWS72MuHYKgni1Sxz?=
 =?us-ascii?Q?3RiiJabKIDmym4w3HbHDENuLaBlHfmSHvNZ+tdRI2QwfN98EFlrJx+qYWtH2?=
 =?us-ascii?Q?b6tkFzVOxEehkzW6gG3wtmsE3zy7xGVgzBo41DIbKvoH32xu4fT7MPfJgP36?=
 =?us-ascii?Q?o2y0Ojz0pdp3leAuS4cMlp873tjMsglOgXAcMwZUXPJqpgDH5RPab4p4kSy2?=
 =?us-ascii?Q?JrYjebrtsHMcYCx3/tBcbfVKyGVdAS28lePw1mAIzOar3rb5lYYF3yx8i1h/?=
 =?us-ascii?Q?WavgpchOlKFZdLQa9LyW/13K4WDn6h2jWH5AKPOBAXxxwE0+mO6dswrn+FO4?=
 =?us-ascii?Q?bOh75v8RRQiE4CG9U2yDKI00lPSSHGdD+lyOTtNhA77dOPObx+eFWxsp0saC?=
 =?us-ascii?Q?AuRSd2IOjw/STrAUwNpANR1oQqcGrO0C5SP0K8ByDTuOkl0oaQgbBiG5z5ej?=
 =?us-ascii?Q?5e+WbbW6O7YEQzk4WS36OjXSQQCsOeLgVZhPmCH99tOj9BCEA9snCQ4cHVVW?=
 =?us-ascii?Q?Q/FC+OR8m3em60k2gGiUfI8EY3CCBNp5d3mFtUKO4FJzRgEFKem2vKFbcjV0?=
 =?us-ascii?Q?Hr9HLXaFcg7syXz9cg7QmY/F/Isv3o7wlAHgTvxYwNjpBEsx0R669lsYN4Lm?=
 =?us-ascii?Q?AEpsFAqcxtIMkYPjyUzNxOcZWLMz49m7n0B59xRk1wCtnt9xWNQAzO2x0XT9?=
 =?us-ascii?Q?4SNidzeZM2KD41vl4GWFp19fHCVl/DNRCD3P9HqH5YL8JbbhGJvHzo/Ev5/J?=
 =?us-ascii?Q?n4E8/k8CEkzoTPdW37YBTUQJ069QsTOtBac8vLgnYFDSF53beMK5wUcauxM5?=
 =?us-ascii?Q?WD5geYydAFeiUDfKzt6SLGNHQsNNyxC5t5XR6bAuws6Csj13j7G9kQNJSYgG?=
 =?us-ascii?Q?mm2HKx9RKTiv7jZ21weIsH70cgmcWIosD33eDF4SIsiNkLkiL6GmUpmY9qTd?=
 =?us-ascii?Q?Gsa3d/Dx5fVeedGKwGSOqtlVebPEnMg8tFayBhW51XuIpu6HcG/fZSoj8798?=
 =?us-ascii?Q?MhBArQGZiNjDJKmSGqYoab6Q/w2g1QjvmEpLE87RqAkYo6uLhs4xwQEKT27J?=
 =?us-ascii?Q?aJOdf/vhiKJ6noMIOITPd/DrUZOAOwDBiT0G1wK3cr/dEsnAeBJtAqqi466+?=
 =?us-ascii?Q?6xaOyLWr2/W2ISWn1+QJ5HQSDmwj6W+Xb8CyTmzpf8GoxUfFR+FJugLin1B8?=
 =?us-ascii?Q?Rh0D/uKR37Y8L0MdcMaNFw7Z0cG8T/psEHM4m+mxrShNPBApsxDr1bKLUaVm?=
 =?us-ascii?Q?1VSpJaIDBBz1CosM4HxB5KnrXhzUvEZbQjkGx0vu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826a0cc4-7c6b-474b-ae11-08dd93c7834b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:26.8295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMxh93cdX6HWsoutKqUzpxgqF0Fc0LkVmZOiUnyI1wD4dukkDZRgQlVqZe0PxIh+hDtch5VHq5H8h48fIXbWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-ORIG-GUID: 8TRk3EHgkDYTqoEJwI4fxfAqi3KiF3Ho
X-Proofpoint-GUID: 8TRk3EHgkDYTqoEJwI4fxfAqi3KiF3Ho
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfXwuG9cq9jwLn3
 aKqKyokS6vlSlHZSimrNQsmse/INlahRw9vIAl2f9HedGnbpjVblAX9CzqWA9gn5N220RLNsRJ2
 anQlcRdwApozfs57BBhwdRHb3yyZctYF59W3r5joNIWLW8y2d3WwEc3LMqWJNtDXiFOR+//YpJU
 dcUDuFHI158MahQTyDJg3JBs8KwbPlbrl4Rrg+zEUAvKcqyS3ih5WocBC2IeKqQqXwYR4lqKND2
 sK47r7FUJYBbq0xMbJTX6kB1e/NzcJ++k+1VoryE5yzqoXsdfZi+yuL8h49r9kbXrEUqj9ah58M
 mBGocaIA8rLaFXvYHvVSKWiS65l3oo5pp2q4OGpADH2PspEtUifaEVVLF30jiSyXV1vhWQ5sa/c
 Lq+aWi12kfCZFPPAWeYtUd+5K0EtK4j4P17n2Zp08XBeFYUgLBs8b3cjzDs6faDcQwxtt8hb
X-Authority-Analysis: v=2.4 cv=KKlaDEFo c=1 sm=1 tr=0 ts=68260c25 cx=c_pps
 a=tQsPtMi3p37jOgXbkrwZvw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8 a=64Cc0HZtAAAA:8 a=LOSiUy74ef7l4vre4JwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Add some basic documentation on vfio-user usage.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/system/device-emulation.rst  |  1 +
 docs/system/devices/vfio-user.rst | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 docs/system/devices/vfio-user.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index a1b0d7997e..911381643f 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -85,6 +85,7 @@ Emulated Devices
    devices/can.rst
    devices/ccid.rst
    devices/cxl.rst
+   devices/vfio-user.rst
    devices/ivshmem.rst
    devices/ivshmem-flat.rst
    devices/keyboard.rst
diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
new file mode 100644
index 0000000000..e33e49d283
--- /dev/null
+++ b/docs/system/devices/vfio-user.rst
@@ -0,0 +1,24 @@
+=========
+vfio-user
+=========
+
+QEMU includes a ``vfio-user`` client. The ``vfio-user`` specification allows for
+implementing (PCI) devices in userspace outside of QEMU; it is similar to
+``vhost-user`` in this respect (see :doc:`vhost-user`), but can emulate arbitrary
+PCI devices, not just ``virtio``. Whereas ``vfio`` is handled by the host
+kernel, ``vfio-user``, while similar in implementation, is handled entirely in
+userspace.
+
+For example, SPDK includes a virtual PCI NVMe controller implementation; by
+setting up a ``vfio-user`` UNIX socket between QEMU and SPDK, a VM can send NVMe
+I/O to the SPDK process.
+
+Presuming a suitable ``vfio-user`` server has opened a socket at
+``/tmp/vfio-user.sock``, a device can be configured with for example:
+
+.. code-block:: console
+
+-device vfio-user-pci,socket=/tmp/vfio-user.sock,bus=pcie.0,addr=0x9
+
+See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
+information.
-- 
2.43.0


