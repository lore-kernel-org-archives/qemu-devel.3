Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34139C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HdM-0008Ko-AE; Fri, 25 Apr 2025 07:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdK-0008KE-7K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdG-0000Nt-A0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:17 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OMD4jC002322;
 Fri, 25 Apr 2025 04:54:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=U2NEKqiSH51uUeN6jrStXnM53WxV4lHYi8lZeFPMW
 aM=; b=mPjGL4a6GL3ROEyQVRJ6jjtXnYTD3M14joUd9XXJnc91LeOlbx0Up1s/x
 GD43vX8PxbCQ8hblmzXAlFWrIDXbM8u32Z0pLZDSJbsBz/z9QMGpqI3uEjwmRDl2
 xs0JNLEuA1Y2wVaKmS3SIqh/J3SI0/k2rvEr12CVOr9KxyNwJLpIdB3hpUIQhEa1
 iRcKXfZuoYZoQ6lEtOY/lSgU0uXm6J40fTbquLKVO/X44vitphSs0OzJ2x3ZY371
 EWTrwNhq889kkktFW/mwr2Aw3dHEFpO5IVFPLYBdEZ9PCDPc2FCt2yJmZA3M4WEZ
 7UMHCqSWocmuk8/NpawpCOKdKBg5Q==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww7s9ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7LmUJ5Fnd3+3+efrziRqdXjN3bl+ywE5Se0S5qcAQwUU0huWLHl8mG6e1KO6seLmyctiJ0LT5nortsOkMO8MxbFMWXM/+Nr44/EnQ/if770hO/0at8rO2gigF/voW4xerFG/J/jioSAy9MgpCDld5CraMRhee6EvRp/WFDRMshQmMYMrjoirutJJe1cPekWFSV0A7QqYnSJv/O1qUe0xSLbNeJsYHukSdEfI89RCJ3CQ7QYFfZzsprvHDkdut+jwzAlLG+523Ur1RRRBNMmT2KMdAreZQ6XHLKkpg4uNPjegy2X7jk0czSb/7GnVoksvhHmPvM77a0qDucJU6PAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2NEKqiSH51uUeN6jrStXnM53WxV4lHYi8lZeFPMWaM=;
 b=jh0vlUUPK3slE1czbIR8JdQC9JzJF22rVbtOCNW4pSYJizL1LYC+hLFxo3Z0QcvTU5A1tJC8LSYwx1BA7XU5Y/1maP4BTBYyzI4/b/MzK+6iZ9fdSTTJCMZZ0RISORjs8d+JtjTuq8wD3vrrROD/SYHreow3quRzeWOF6KcsFlyCuXyEdnsLu/kERGi81XK8baQEB6yoiG8k5uMPjC3FPBrQiULoHg9N1Q95CljFyYE/xFvukyYZp4uBD9Dv3nvbKZcqaRXXV0R8npQo//7M+mwlJ+PY1x8A76okCHednYcT3QeWirD43EkzgBRn90uYwsvkoXZfPJLfnUO8RpAImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2NEKqiSH51uUeN6jrStXnM53WxV4lHYi8lZeFPMWaM=;
 b=ViPDfIt2pONGkMFfepePIwm22hHmp+qXQGWROGUAGx7KVjijgnMhgGimhVboET1JnEngJsA69ggmO2w+wyNlMtVH7uP3nJmiNzPsQ+dqtNyo2oKf5d6jOc+y2vCGOAoVUd4bVtlqNoKxmYHYKVLBLPn/dpiNQFumyAZqSmywJHvbiZJWhaPU9MNgu8+594xw40iS41bd4t2yj5AcPtZ9a4baLQv/4zWNZ7h4oBzXu1TkJ7xXc9mmKS3FtHRaL3NOV2uqZpX5CU0e5kJD6XS5fnsHDeh6p0yje2mPgdqR+Ogq6f2kxT76X/QBVYA0kTGSUcJP67NEN0i6sWj3T6bZAg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:07 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 01/12] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Fri, 25 Apr 2025 12:37:48 +0100
Message-ID: <20250425115401.59417-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::35) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c45f65-fd5f-44f5-0c3c-08dd83efe20e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dLJUik4IReCfivINTFpfxUiMq4DUCoh3ZBiiuVCm4FJwaKLdpzAWHwFiN5jL?=
 =?us-ascii?Q?fKHzv4v5NqxJa/Ek6bMbDuREsGBbwihmbqvZr5s9SUbYhSBbQpdnfIr5fVSP?=
 =?us-ascii?Q?QDvilhVy/sa0wkrW1rc4kjO5n2HnqGXTW09ZbWY6BtzmvlD0bRUv94mY7SVx?=
 =?us-ascii?Q?7tg6eFxs7rq2TexyQTSkDZJT9bJkJswcPzBrn1/PW/ECTxedG0pca6T1YEAq?=
 =?us-ascii?Q?OyTOCml8tkvdwKbivurTajKUqabSbiPaOgxUpkVzIgaNGewoLroBvQtb0nCT?=
 =?us-ascii?Q?9uz7+wsDBTT7hFX+elbb9k/gXtaQxomOzyBGCCOXDjDQqGI/qBSQnJUVpGl/?=
 =?us-ascii?Q?BmDf606+9O3cvenCWvGwC3v9d/a+iRFkJwvFHEdqwn4bW3Ijr4yZbaIRVs5z?=
 =?us-ascii?Q?IqLStyOHSk4dm1nk81Kef7veOetQp8rynFv4ktqce13m+cd/vxlJQiD9gqkB?=
 =?us-ascii?Q?jbtNw4ehMxVfWhDEavQkbfjuKWFFbdHIJFgIumOErBYocsJOuEIULLokOLfr?=
 =?us-ascii?Q?PNbI9gmqA8MhnbATKDHgUCdDCSl9SMj4ka5/C9P/I4bl7vQZ4YIk0oQUso95?=
 =?us-ascii?Q?I685xLJgZEdTcJUcNX5XBRa3PERDBGqVM6qbzlimQ7nULNPPd9Ln6qXVcy55?=
 =?us-ascii?Q?2aVCM9Y91UphUFgoQ2AvrNnR20gMfqh78He5odOL+U80rXrj9At9XoGYAptA?=
 =?us-ascii?Q?kunjn9eNmPXz2iqYsjPEHWkMgoDv2QIzY+K0wP6x+L0vak/dFJfG8oYbOP70?=
 =?us-ascii?Q?hUsw085ciahGoq1ugPc4LiIthG6CFsf6Bp3UR4bV+NBpZfBZEGhTVDbuckYX?=
 =?us-ascii?Q?zPXgYGl5WD7gdOG1qZlFajqxHkdtsFX5JmlCg5iFhNCITy7dLkug2mmsRHaD?=
 =?us-ascii?Q?eRnKP9lPRk7KnaPjUegAcjOGIteoS/iscx3aFCiUMdBQKoz4YHzleMxTDMBE?=
 =?us-ascii?Q?6OuhvCqHdGIJyLqLq+Rjepz9iBlh8mEPBQy3Czs8FeSNp33dPr+hHGGTCorC?=
 =?us-ascii?Q?ykKh83EQvmXmxQyPMzgqK6tXwmnbX42DRbxebN+MvAQXoafYdC7JF0GT6duJ?=
 =?us-ascii?Q?pDkrlFvlVOLZHVC5RkPQwcDlZUtwQ5ddH+rCjgfnnFinr2Wc0G43R7GFCPOE?=
 =?us-ascii?Q?pntBGL0UiVZ1zCBL9LcvnefrQMp58H/JOMlSVXh10pr5txUrD9OlEgoXyi/J?=
 =?us-ascii?Q?vhXQQc8inPAu+PA1lBtCRg0WGlUNrvn67vMAYXGokh5uMEJI6Bs+I4DxO8O4?=
 =?us-ascii?Q?ohYWc+20M5nNyEyV8fhoQveTuSxJ7AGBbWrfHOkJND9Iq7+EgQgrkAzjxM4z?=
 =?us-ascii?Q?Wj9rXERscf18XkTvGzqp5NuC7/iAfZJkCAYLZn+kpY6I5B4jkGx5BeZznQBp?=
 =?us-ascii?Q?sS7r0qbtyFDmKQ8o9eZ7g8EOSfhuhOFP0z0HjLQIOZy9kZnH5KR5xWYh6TUN?=
 =?us-ascii?Q?yJTGe4I+MBY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdSl9qYcnLWSh4SikxJFlsBBUHcsw3LxO1L1m/qsZVpd1zc8KAQollLvrePL?=
 =?us-ascii?Q?Q3qvnyFgkXUiUD9T/X9yrbwUUxW4CRd1E6lt+Q/hizRbqOOzwJvdZlyOdU0Q?=
 =?us-ascii?Q?HfYG8UtyXFjg1cN/xTSMQaLVvIF5qk/E3DdQE5zFzdSY4PzWoiKMHBR+QobQ?=
 =?us-ascii?Q?E6RtnBK97k0WRf75nsABVpT5wE43geRsHrOeDNoITczmo+1v2i+F/P0q9Yki?=
 =?us-ascii?Q?ywizMXI8ejMwC18nE916Qk58ynCKil7G121jWJpzwxtFVtcmut6jHFBr4ZJ+?=
 =?us-ascii?Q?vFw+47gXsmx59BRbTcOe9fUdafWnp4YPsA5GfTFfVrUmH6Oka43MaZCbIFwZ?=
 =?us-ascii?Q?9Cqw6rQXXMriSEPoizvoJ3cXZoGRIMxjM4OJFUFyCZEBYi8Iqy4e/GWSUQLy?=
 =?us-ascii?Q?Nqx38mkvpQwUOfbcx7QsUSha3xlTfhdksMPAEccWUpvMENdHynpGFxYF2idJ?=
 =?us-ascii?Q?NClkmlM/yxMErmFYoBDI9TXkRxc7xrgAKd0OLxb5dKjwXk70vLga+NcwBGad?=
 =?us-ascii?Q?/q7dyJjbLYh2kmmRF+1DZkmZmf6yF7Jt5HCnZ1aRsa6tzDyPGVnBawAxy8/t?=
 =?us-ascii?Q?pc07beak1srmTmdpEkVlK4FD3b/kAcdKMyqukXAC05Po+tSD74jqAmlp+Rcy?=
 =?us-ascii?Q?w3s+6xZuVEMqIg3PX6td1YF7rHydDLR/FNF+APxLqtdqO88onq2u8+kZhGAc?=
 =?us-ascii?Q?jXWDyOMR8N9GdUZbyrrAoLF+n8LrUorvnDCk3X71kK8FbaryOfFX5bAlGAvD?=
 =?us-ascii?Q?iP3WjDKZU7Dg+utL9lun8xl8dZasnN8pkJtGlbStBMBMDppK+d0r3uXOgJU0?=
 =?us-ascii?Q?AQCASaAOFE5QNZQScmKOcK971TKOokFSuxznTRBxOBIXGrcor5DytPE+gwjK?=
 =?us-ascii?Q?e/vfipU3e/uf1WnuWkR5ss8dGVB0JGzFsPwe9SS/6W4eS+6/Vbdi0db2k/Qd?=
 =?us-ascii?Q?M+PUVHujK3NAq1hOmLMaMyGVmcDz/g2dY8pW6uabtOYmlnL5vpxjhafv2Mmb?=
 =?us-ascii?Q?Qf+lFfxfIAAMkP9+JnE6ouhGiW/GSxQKctMhd6DKu8uh7HYYbr31ynYIb8pk?=
 =?us-ascii?Q?4hi4/TH8LPIhxZ7knc07V2MMrEIXvwwN3TbXRxFocr6kdqGNRcULO8kfVrw5?=
 =?us-ascii?Q?ridcwmcVfOZw4QPXIZ/86gljePH/W1vq7pnERC20Rn2UaBMoNbKkhNviD59+?=
 =?us-ascii?Q?gYIcn2srwhulrJAkUdSQY98sCgtzXFxpsZP6Q4cCt+/4BgIvvyzUbwumhQbf?=
 =?us-ascii?Q?oKFO+PDhINdzXCyD7esOj+K3UuRkzxXaTNslGg3bClOqxZhBzVma1u/XfhMA?=
 =?us-ascii?Q?Jy+YuXeVUYl4noBuzgXiQiAUnlHSIZp7fQb9MMpuX3goifqgFboX7Y2Ss4qx?=
 =?us-ascii?Q?QqfG4ouYaM5gzrjvbB1szrMMNZr9Um5SXUocp694Pf104mg3pVM+A9sAQYdy?=
 =?us-ascii?Q?sgHDdj6Pd/ri3s3EBIS1TuaNZfpy7e3A1v/PpwTgR6r1W090z3knvc76CC+u?=
 =?us-ascii?Q?BmJI5IIDNQ5b0W3U/wFht53gvea0XBrNh+tnJjP5WI2qo7gD8z/lQmRIMXKo?=
 =?us-ascii?Q?0vAz83SYioKcdCMcYKHTsV8BDKln2QaBKkYHYrQ0Uu8QdgvBPnNgprprXR4p?=
 =?us-ascii?Q?uLHm8qJj+A9IS2gWHL5kXRy0Vtk28GrS8rgkiJExpE/Y2s1Ejo1Pi4KJwz7W?=
 =?us-ascii?Q?Mce+Ag=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c45f65-fd5f-44f5-0c3c-08dd83efe20e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:07.1622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+XptDXmksYTjhnQvixNOFTLPWjgh1uVn9kX0ULfCWAdGTLy860EvI4aQ84Sj7iOp50GsvnpYHc32I3o3hEyQi4SulHSzArAiPh3oT2cxHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfXzUYSRen2SIQn
 eCfLoRHAfMiiL+65JsGdsCEbZBwOlvD6iYuwvkTszWCD9kc1NeCtYfNAA1Fqly3lQVIwD1MCORf
 JPprcYUe9B0kcwAS2zcIClUcbIamqsqvdD4oCx3OjCAJ2r5d2A0UwpnKtOdGXtsYsghRrXCawgN
 LjtxXOD1ZUFIkGYWG8Nyq2k8xJBDgWWVD7Fx6CUJwa+plt3zErTkmQ2E+jOLVW+RprCOF2V3ckB
 4x9OGOSNxTRmJSfu1todztgaAKbxnZiRd7NdIP89IfbjWBdfNdnMxc0TNl3skF9PYvYuOmycEJF
 U1pA6pjfqkqv/cbP6M6KhQ7IiGvOu/s89PVDo64cLnA7ouH2Ron0Mm/HlEmdkhxQkkqbvViFdBV
 4dpoBrleWUPZhi+ad1x/wabku7aD9mJnCbq46Bkt+oSk/XMni53q7sgbk6HxYt+zbQaO3E4y
X-Proofpoint-ORIG-GUID: ctX6krt1_cT33v2gwht-W-L_17mEgli3
X-Proofpoint-GUID: ctX6krt1_cT33v2gwht-W-L_17mEgli3
X-Authority-Analysis: v=2.4 cv=ZvrtK87G c=1 sm=1 tr=0 ts=680b77e1 cx=c_pps
 a=YCJezUkNvC3bKg1Ra8oh3A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=tUpV8ruPn8K-tSSEYGwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

This is to prepare for splitting the isapc machine into its own separate file.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 260 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0dce512f18..79e5d75e97 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -413,7 +413,265 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    pc_init1(machine, NULL);
+    const char *pci_type = NULL;
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    ram_addr_t lowmem;
+    uint64_t hole64_size = 0;
+
+    /*
+     * Calculate ram split, for memory below and above 4G.  It's a bit
+     * complicated for backward compatibility reasons ...
+     *
+     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
+     *    default value for max_ram_below_4g now.
+     *
+     *  - Then, to gigabyte align the memory, we move the split to 3G
+     *    (lowmem = 0xc0000000).  But only in case we have to split in
+     *    the first place, i.e. ram_size is larger than (traditional)
+     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    only, for live migration compatibility reasons.
+     *
+     *  - Next the max-ram-below-4g option was added, which allowed to
+     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
+     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
+     *    but prints a warning.
+     *
+     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
+     *    so legacy non-PAE guests can get as much memory as possible in
+     *    the 32bit address space below 4G.
+     *
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
+     *
+     * Examples:
+     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
+     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
+     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
+     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        }
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
+            if (pcmc->gigabyte_align) {
+                if (lowmem > 0xc0000000) {
+                    lowmem = 0xc0000000;
+                }
+                if (lowmem & (1 * GiB - 1)) {
+                    warn_report("Large machine and max_ram_below_4g "
+                                "(%" PRIu64 ") not a multiple of 1G; "
+                                "possible bad performance.",
+                                pcms->max_ram_below_4g);
+                }
+            }
+        }
+
+        if (machine->ram_size >= lowmem) {
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
+        } else {
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
+        }
+    }
+
+    pc_machine_init_sgx_epc(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    if (pcmc->pci_enabled) {
+        pci_memory = g_new(MemoryRegion, 1);
+        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+        rom_memory = pci_memory;
+
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+
+        hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
+    if (pcmc->pci_enabled) {
+        PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
+
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+        if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+    } else {
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                              &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
+        pcms->hpet_enabled = false;
+    }
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+
+#ifdef CONFIG_IDE_ISA
+    if (!pcmc->pci_enabled) {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        for (i = 0; i < MAX_IDE_BUS; i++) {
+            ISADevice *dev;
+            char busname[] = "ide.0";
+            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                               ide_irq[i],
+                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+            /*
+             * The ide bus name is ide.0 for the first bus and ide.1 for the
+             * second one.
+             */
+            busname[4] = '0' + i;
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+        }
+    }
+#endif
+
+    if (piix4_pm) {
+        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+
+        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+
+        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 TYPE_HOTPLUG_HANDLER,
+                                 (Object **)&x86ms->acpi_dev,
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 piix4_pm, &error_abort);
+    }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
+                               x86ms->fw_cfg, OBJECT(pcms));
+    }
 }
 #endif
 
-- 
2.43.0


