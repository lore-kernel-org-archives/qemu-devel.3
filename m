Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFFCC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKKA-0006F8-6H; Tue, 18 Aug 2026 09:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKK7-00064n-UU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKK6-0004jt-38
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:51 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDujiC1717638; Tue, 18 Aug 2026 06:57:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TJmoe7HwbNztbvr2ieYhyltvTL+pcg23G3gsmv5Od
 0s=; b=XVx6qfnrp5/yo+Cj3nQle435niVQwZG6BzamT/3eDNgiocDxVXglHAhy1
 ODL3iNcr2YEkqUdsg4DM/jPg4/RacEvjrBPAyJqrrUJySOu6JSkshJT7yOt/CQsB
 MWKpubgI1YLFDFgluhGv5XgGWWPoovqqEdf5kc7Gmq9nJntr+ObLha80dedU8iAg
 JPSUeg5tf3yniozVn5yZGAFlddN2NCDE29mQA6fq2XsLtDjdx19jIXjq0KKKGAa8
 ba679wL1AHvVOo9vki9V+QLtmDH8f/wznA3r1bhpNZ/0HOcst0hYlUkair551nDa
 KY9suyWmtY9KhwIrGa/BSEuDybPzQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020142.outbound.protection.outlook.com
 [52.101.193.142])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2qnt6n2g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1fr3igH5ADp6PcL2n7TBmgwRfjJlfnBTS3K0M7dZpY7VXtqUOoPHvRKXe/ESjBSBPWC3VN+54aZlrN023dvbP4roQe2uSimPGYY8YQ5JVQuMeCOiIYtZYyZ9nzgbw4zGf8UxKHm+6s1UU3QwHaBfg7FTbCdxgQ3QAIgZO4FOIWVdtXt4Bnkkk3jLz2HZMIyEBIUhOK2451jQ8Nk5sFW5MINGigrdLV4oUNJ1dTHJlAkjibOk6AS/R9HxPySwOdEFBvzpA7lQltiQupxX1nDaXv//Db684u7qYSZ4hsr8E+quyEeZczQW5Jy+hqaYKIGVChRZCmlR1Stpeko/Krm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJmoe7HwbNztbvr2ieYhyltvTL+pcg23G3gsmv5Od0s=;
 b=h1ZT8VH47vECnZErFbaZX+uGG/0aCg4qeGnrlDFpaPdb46rgvSTY1Khtz3HBI/Tlljxw8m/pPzDNo0dypyknMlHxCizvDARiND/kUIHVV4SMTPb320zSEySqYa1c2KsBK4IeE6ub1ptp+BB8gKA3zyhtOb98ZI7tEM3m4rJN5fxNrojQ/CEWK402F30HZFwPE5N1PLr8Hp4tbEH+ECsDhsInm54iNzLJJNLfEeigyX6+AEl+sD0RXZq58MCIm+H4Q82w15j2zI/G1aiuKlwofCldus2OZPQ7iKEZB+TVnjNeYnBSy/wWAc+NiuBOyP7rwR/jSU+EInHGxQ67FiE7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJmoe7HwbNztbvr2ieYhyltvTL+pcg23G3gsmv5Od0s=;
 b=vGR5M1byJoMEXmIUgaPc7KEFov4sVKNox1Qu8JKN1LkLfml0OMXig1Hb8ruJHF/qnCRnOQb8vinMwek0cgHDP/J3+6Lh4BoWylMQyKiLN/XLWG2ZyyTzsEcJ4/PuRy8d/iyliTtGv03WwVGHNSM68OGe7xwjIEE3+lUTunvUF+Auplfb1XvRZ6Tw4/wq0if52KWRMlmi0JZrwVPw2gTq2sfUNWzhU0rVmZ5X6B5mLb3m+uRW6uw0w07PDCfuznQ8LNg9Rv8Ew/SAPF8xOJnvRcm2dtEOxdj2XGgc3NQ48FEdaFHWfSyfQPwrS3vkx/NtGD4cKyEjMbzhrcKQIEJqdw==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by DS0PR02MB9103.namprd02.prod.outlook.com (2603:10b6:8:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:57:47 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:57:47 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 2/4] ui/clipboard: keep track of clipboard peer side
Date: Tue, 18 Aug 2026 15:57:35 +0200
Message-ID: <20260818135737.2679311-3-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
References: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::12) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|DS0PR02MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 62074a21-d62b-4fcd-39d5-08defd30af0c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: NY4p11Cp1S/Qo3iDAsGUqYbU81guesR1OLvA7tidUWgzcwumqNX0FfoFZY1TNcNjbG3a3HHf0K2v7BfDUPr1zOjaFtornexwoo6nFxPYHACSkMaMJRqDB906+/XPv/WnFIAvBkFgEZPCOOeqQ9YGvfF8b4oD/JB5QETfbpORA4E87xbaO6JfSDj8VtNBg1I6HX2+jGXFBZXlWobNwXP5FkmVleNeAq0dqlpWYtIqxFVQbP/PmXFYSqpUT5FHTXTgtiDUL6EDum3ZEoYUtofRg7LFI6vc/aKaf7R5WG2FX4l9tI4LxBLZ0sHRe3dHS1yErKpY/WY2KJ5aPYcevaYsnH9kGsgeRg9IRQT4/OgoJNQ5CJpTBr6o5sUVnHcFlhqNr08bOz1CLV1Mpi9RGyjx5qCJH2m59XqqraILEE5VAdtAX5/YFqijvvIHnRn/icBPycdqDy0E1qe31CISljX+lq4I14xnt9NmoO0stc4FDeuzVB5HS2zYbTr+Fki58l8VjrMj1ialD4KAUK6V/mP23hYJl8RsFpxTDYIl5p3X/PjPDrKkAizfxTqw+AEldtsgVOvFW/iopi7Fm6mcKKMuM7khe/6LgqvJCG5+vxFI1/4G1K3qRfn7pyRq6Nk2rUsRQG4sGA51tmeMztNuLaXSzTz68jMCrWwqu1e2h4XcLy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYedcIzuherwWK2nYbdtwGJ2Y5rsRdi5Aei46dRiIzbFIN87quMi/fhIZ9IY?=
 =?us-ascii?Q?1TzcsD1uejFlPGiy8KH1T9crAeNCxr8P6eHWvhqWw/1ROJgdFu2ke8iJpqE3?=
 =?us-ascii?Q?8Yqruz1sbqNY/6UKU57nn/s+e+oSl+vvz4r9Avxa3/wuvLL4WcJJnndRu0qC?=
 =?us-ascii?Q?GBC7yFHyHOGIBLnI2GCtAwCajFefAZdqhyUjPTfc1/aNFEbJSGnq6wksoo9+?=
 =?us-ascii?Q?4i2/SrAsrzfch2xNYSPLJQCNx+DFW183fuF5YTvsDKGtzfrWjVTMcPjsIF7b?=
 =?us-ascii?Q?jatWkfDaV619h6klSrz+9zUbRKee65bvgqEFGhPzy5e4LlX2eAJHxiysth9K?=
 =?us-ascii?Q?QqyShwU6y955990K3ywWjnuQhgypMOeEsFzOJ5gW/T9x0/k8QvNI3gHusU/l?=
 =?us-ascii?Q?iIQJlYdirG7Apv/nPSk1zhoWjpHc5lWmYIrxwqOj8daVsIFr9N9ZhoUEDyYt?=
 =?us-ascii?Q?l7YxmWPdyLsRQUA358ugE2zT97JY6cTpgwThfk2J09vSuuMpqMQ14Mo/zYA5?=
 =?us-ascii?Q?WUSAUo93H6BzxdNdMC1GYn/UB1s1BNyNYG0mune38Ez3VRELTqIuno+lPbKg?=
 =?us-ascii?Q?TByjRs5rx/CMK2k9baBOjFsU+QOdgAGhg0eFlpc3Vz6ZxBp5/pJaybLE9zYZ?=
 =?us-ascii?Q?78xNrWS63h0HkLJWt6WCuqd++hRCYBTyzaiXiYRI3AA+q0a1Z/VI/+suCfYl?=
 =?us-ascii?Q?dHypM1H9bsVcAOKT/PVh1fwZesrt8y3XYCHJQqzVM4GvDmnP8YLOUoiR5XJ5?=
 =?us-ascii?Q?XGJxY2F+lfL43ZVAJGe4/4QDBmBqyJTbj+7YZ+bWmPgMdtRPYlJalMaJqjnr?=
 =?us-ascii?Q?/v6a5HIhzY8Hi3KxvtsHEY85+6uvD1cR03jE/zXCznhfThkYmFVewq8C6+f3?=
 =?us-ascii?Q?R7td8RR6Uy5vOuvJoSLSD7LLYI7GNYSqq+llCzGBdX+Gtm8fWdiHMtDYJiph?=
 =?us-ascii?Q?Kqk4eKT4mFHHWYkCeI/MiI3LRdlabscYNwFHXCN95WgSlXQLklYelp5sdqXB?=
 =?us-ascii?Q?liIX4lsxvRnJr262I1ooWzKjRQ9pd/y3GRj+Vi3Ae7TtCvyN6URLzkZCWOcm?=
 =?us-ascii?Q?8VxBeH2q+1ZR6DTk87aJICnP8YX6X+i2YUWFMqr2aO2a9bLdgM9IqNRVhB4D?=
 =?us-ascii?Q?X5R79z+MzSMtatp4BIv7Yeez81tvc60Jg2IAAvz23oIeCijoMdHduOYkdvt8?=
 =?us-ascii?Q?2vP0j5QZU9mHZxU+3hm4Ozt0tL64Qd3RRjoFil7b6CZD7vtYfZlan/J29YAH?=
 =?us-ascii?Q?RUfVEkJFaL0lw1Nrx6XfxDyuIXXcRu3blk8CKZYNYUTZ085e8XhL4wv1GEIP?=
 =?us-ascii?Q?t2uPFrhSPBWcK4jkGmdQH96mQGTM6bGC741RR6HwyxAtr/Fer4K6loQwvq1O?=
 =?us-ascii?Q?nb6iZqoRsQOVRyPkeoL4yrjI5+RdVQkThBiIXBVmL5up8Zc8kojF1Tmy9ZWZ?=
 =?us-ascii?Q?oS5T4pW252DMBZQvBd+w1FB6HarBeo3CMixcRdqJ3J5DtPucQtMCvYpiSix+?=
 =?us-ascii?Q?rFguq0my1frAw9/0qMvymSoJXkGQYMiqzXegQJxVv52Cc3Ey2XsAEa8iIZZs?=
 =?us-ascii?Q?VmVB7/XF77MRFUSsPwft/7kjxDJ/ngCn/q7uc5QXk1W4/ZsdQzJ57NxIxj3o?=
 =?us-ascii?Q?/rQFYhbfTmbaWdfFeKUe+fiFOnzm+g46KGOFXm2Xkcjsdx51eYVYvJ5Av7E+?=
 =?us-ascii?Q?6bNoJG5dSNmH2h4nIlEEl9eWfaAem/a49Ol7WlspQLqzVeT0WmoiTauEiaBh?=
 =?us-ascii?Q?wnjeai6Opg=3D=3D?=
X-Exchange-RoutingPolicyChecked: AjEYvecGe2wk6awGLi7oLU7Q4d3Uq4qJkyrASgxdsx5pMC2NR1oIgGlPXxMct8IDW1p7ASPwyLLvMkUMUTyRKUCMwSYPeGTkjJcJL5LGV0PWybyrB19xAtLmoN0Vf2l0diUW4qvugpsDGIOr1z8UtOD/kyG9EvPFLE0zpLCh3d0vmo5WhzHkZ4VQrFrxDFIwkv1AQXblxMaByEctvlxlLNWIgLhu1wYATlVw+BjkPpTp37PCtn34XB9mzNlUI7D6DaRO8XRjwJ5mjr1dw7CwYeUV+iv9zVVd0ZoNTL7M6MCYhqhlcjonaEynrMBdR0qFrEoiKc409Kzyh+zX0qdxlw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62074a21-d62b-4fcd-39d5-08defd30af0c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:57:47.2348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFlDfodQh71Nx0wu+abtiQGJA9VNOi387MvWbAHe6pTbq8oTSMcitXsnZlse/Vbj6pMfcxxkq5G0KMY0dAnYYyfw4UKRVoNyqx+Pd0GWvmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9103
X-Proofpoint-ORIG-GUID: 50IZEySR-cH5ZTiEIQxmmkkdjRqLYr22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfXxVyuvudEru3h
 p6CXrRM1O1UGmHf1QUS2OMk6EmKXHt5pjDHN3VIqTrvOcTio7xdG0ynptRgHRn7rHWvbq2Z/Tzu
 6e/NL8h7WO0EN3cjcGbRMWbxnQ1V/L4=
X-Authority-Analysis: v=2.4 cv=Sv6gLvO0 c=1 sm=1 tr=0 ts=6a8464dc cx=c_pps
 a=4hwGk4Ee9vGu72pLTFfh5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=utkLoxhBbnJZJfdwENEA:9
X-Proofpoint-GUID: 50IZEySR-cH5ZTiEIQxmmkkdjRqLYr22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfX4WiIksBKCjqC
 LcvFmg+qO+DbdEJ3ogNJq7muTyo6ARLAE+zq5NRMmZXgc8zEmNKc8se3GEGVTASeiO//H3r9jRe
 5ndTDFwBbjxURi8I81MyjsKZmt/5mA3fkasCWjxdyiqkUGuIlBCzXEOatEojRbKi5tS6E0WzyL6
 BKvrUowlJL78zE8853LmGYmGlsKjQuy1VbcTiJ63X07oRY7yQF9EwdL2PMkK536zSx6WRXUMQVe
 AimW3Nt5PNMTl00A+Gt01TP7SpUfanw9V6wKltijJrB853T5UC1+28BODt1AG8NBo4m/M6Hr/q9
 djQrxrcmRU7Wk54RvonbkCHpIBsuTpCbh5lOHVX41MtC/vnMmpyAdtbuFAnA/04L35XRzMoHGIN
 myXrcye/feIrF5nsoTXBRsKItfqMA0sgdmSNSyva/MxRC9uPeNfusKyRpNuyTI6txsZlkHV3xDA
 zaMmaSUqNQVRLWQz+pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Add a "guest" flag to QemuClipboardPeer and set it on vdagent peer.

Use the flag to keep track of number of registered guest peers and
allow to query for their presence with
qemu_clipboard_guest_peer_present().

This change makes it possible for a clipboard peer to determine if
any guest side peers are present so they can tell whether a guest is
actually able to participate in clipboard exchange.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h |  8 ++++++++
 ui/clipboard.c         | 16 ++++++++++++++++
 ui/vdagent.c           |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 6166af5139..df7fa5e491 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -69,6 +69,7 @@ enum QemuClipboardSelection {
  */
 struct QemuClipboardPeer {
     const char *name;
+    bool guest;
     Notifier notifier;
     void (*request)(QemuClipboardInfo *info,
                     QemuClipboardType type);
@@ -179,6 +180,13 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer);
  */
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer);
 
+/**
+ * qemu_clipboard_guest_peer_present
+ *
+ * Return TRUE if a guest side clipboard peer is currently registered.
+ */
+bool qemu_clipboard_guest_peer_present(void);
+
 /**
  * qemu_clipboard_peer_owns
  *
diff --git a/ui/clipboard.c b/ui/clipboard.c
index beecb40e6f..928aa435e0 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -12,6 +12,8 @@ static VMChangeStateEntry *cb_change_state_entry = NULL;
 
 static bool cb_reset_serial_on_resume = false;
 
+static int guest_peer_count;
+
 static const VMStateDescription vmstate_cbcontent = {
     .name = "clipboard/content",
     .version_id = 0,
@@ -80,6 +82,10 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
         cb_change_state_entry = qemu_add_vm_change_state_handler(qemu_clipboard_change_state, NULL);
     }
 
+    if (peer->guest) {
+        guest_peer_count++;
+    }
+
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
     qemu_clipboard_notify_peer_update(peer, true);
 }
@@ -92,9 +98,19 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+
+    if (peer->guest) {
+        guest_peer_count--;
+    }
+
     qemu_clipboard_notify_peer_update(peer, false);
 }
 
+bool qemu_clipboard_guest_peer_present(void)
+{
+    return guest_peer_count > 0;
+}
+
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,
                               QemuClipboardSelection selection)
 {
diff --git a/ui/vdagent.c b/ui/vdagent.c
index cc32a94fb9..cdd4cedad2 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -695,6 +695,7 @@ static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
     }
 
     vd->cbpeer.name = "vdagent";
+    vd->cbpeer.guest = true;
     vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
     vd->cbpeer.request = vdagent_clipboard_request;
     qemu_clipboard_peer_register(&vd->cbpeer);
-- 
2.43.0


