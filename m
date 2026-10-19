Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37CBCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIlIF-0007iT-PF; Mon, 19 Oct 2026 07:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIlIC-0007i5-OO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:12:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIlIA-00069E-LG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:12:36 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QT5G3199248; Mon, 19 Oct 2026 04:12:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=LWqo4vu2Fg3/F
 WqYAXVyT0K7RwagwASf7xvte1oCHLw=; b=ueRxoakK/QJDy7w6zxsVE5/2QsFCG
 KgHcYWDJ6O4peuVoF1XTXUPRCDIHz5wBJ0TRmStJO7FKxdAks3BQRonHeVODbEnH
 AAduOGEk8ekTW9/gH5wMnH4IbQxE1fOyoZDMu7usgg6ZHnU04NECVQvFcmxM72Df
 GpTTJVhj2fXdjGdY0q+6JGzA75DRxqKd2zhlpAEL1Ap1s8r3ofYUp4OQxqxIR8oE
 MxIRt99jvtNrpW88o7p/dl8Vby1fHYRyCwqmGQfgtB0tZkybS5aUrVZCyuM5hSgG
 mOltQR5+A6yfPIyKYQhO6x46bIUYKDTi+AT0bg4Fs+TON52fOV/QBUXJg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020103.outbound.protection.outlook.com [52.101.46.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc83eucb5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 04:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNAUSGxcUnMeQNIZmFFzx1+f1udOuKwmJIuzz+qv3TCa7+xA4B1HusjAIsGQotuw+x/z/vNMJVUmoCmN0R5zyZgumlh88H5BqV8H/W2zM+YBdy6D8YoX4/Ef304rUVe3eSEE0PfbhbMGmqS05QQgjeBUvogSll9v+MU7R1aJ1jXM/t42K/HbNpYUaqoR4QKPvbW7auVPGqwJetpRqMr49lMAQHAYux9hjBpyAy9On7yPhO+OjY/wScxd2JlFf41OLg8LWDwpN1a4EfACx5F57idJU7dlDLzXbqTmLNFSbiR3piYmYllU6mbCVzEvSMDjKxI401TG4LYvcqUPdqWZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWqo4vu2Fg3/FWqYAXVyT0K7RwagwASf7xvte1oCHLw=;
 b=FS7y3P0qhXOXX5apTNAFFCa4D/tp+rsgVWZ+StfZ5qXmi2Piq+0l3rNaH9MgvNCFlDylsLJbSN631WMFuog/2zOWIfOKEl2uEASVwkq2Ja2BKkbmMRwZqQK6MmumGRFst/ROk0JWxrIJyd3Odp//F9lLNzVc/g4mtO1Bbk4omKenUO7Rru7A/v079C5+wWwmzg2TiyPvlgcNJH4/mK9g4llfm2vaL5w8LH84o5+/9KPbFHcZKrOs2G91oiEMYzDw83ewZW0d3waj8nrTldA2i4xtykEvwouVJ5bXVEQDi9sVBdEHe3GPJuov8cOo6B6TUuV9/L2cexuB6EKINvCJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWqo4vu2Fg3/FWqYAXVyT0K7RwagwASf7xvte1oCHLw=;
 b=gg/nJMnp6ptd+Sv8aGjKXF9rZMI5LfstWO6ZzUe4TcqoPnU2tVU891da80NCWEGmUCU8mEcgnSnCKLQWHJ/wXVffy8Y/tgYnhAB/6IbMIKyIK0oCuH351OIHYU6RoVoWtNNzB8/690TYeGlWoy1unchiFons7oQDfrCRjWX75zhsZVBeavrmZKJFbJipFpFalF7I0fmKr8FeqDfHE7FCk/gDavdlTYA0DULOcuEmYKKFAK9rv2gVHoQlVfHdIgPSV1UH/Zn8dh0q0wH/soR1OuXKCi94fdUXyliRG4VEBqAmuK4YwGIFJCD4ihjei/xV9GNRzFJ4SC0TL4x3NfoooQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM8PR02MB8005.namprd02.prod.outlook.com (2603:10b6:8:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:12:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:12:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 00/28] i8259: improve qdev PIC modelling (and misc fixes)
Date: Mon, 19 Oct 2026 12:10:00 +0100
Message-ID: <20261019111218.1429468-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM8PR02MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 17602d04-1b08-4c5c-d891-08df2dd1d875
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|10067099003|56012099006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: R9uoGoMANpvP88Yw44WjqOdlG4YyRZxSmkmvoJSk9wdUSCnNwIerOoHM5ZTIrOBZaDjp0cLfckdYPaMa9Hk+QPwU/Y0Nz2nb/T/j8BrHy+4z2TndC7rK8hfOR+gu96gn1QP6Gis9P8wnstuq0dLZoULOucZDfrrcO0fbZibrHg4e+5AdWHjCGX45p7osWy8t0wVdDlxn2nOhDIb9AO5E6QT8rCL6KjBZSYFxCyx9VdBibPh5JDfx7uKEFIU6xXv/a9FIthETofzH7USfmmTcDufyfzJkswASycuHny6ElalNU2B9MlvIBCX8dfLmeCx7F84rjMCvPf/UWl2a9F0AXS7A03lOhB8ML7Ex6R6/Y4oHGLr7noKxNJInqvmqu+/W+QCkMOJKeb90s7/vL6h9X3fL5XsfdKdMqCMqbr9Q/Y6Edf79W9l+kVEZe4HomEEfKsqR4WLXPczHKhXFnOBVXjtEYMKZuZIibxf2SrlUZ282DHDxJdKflvr521QTZSp14qOrCM9a0fTX3sc9mD8NYYB3mQckkLYWifRB6K0SQO13zGyOfg6fP8gGpsylnOxQs2MLd5CitXPVmDrc1oF50SvIyERjdJX8r8AmAPgWkl4eDDhQgcZbRFsB0I7Kf5tb6kvD2cpmjDm2s/tsMxA0QaaQNPe6GSyX+9sxpvoVcP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D63ybuBuexVMfTGeSK96d8sST/NPVFrzFjZCZZBsI22kCt7FqVBIvWTT09at?=
 =?us-ascii?Q?OMAj/HxEbnFvAvCQhmAqCH1TU/5S8ZC5d8GYaL3YdR9EYUULLftYfm9h66La?=
 =?us-ascii?Q?2YXI79z3WC53FSiiSwL3O1WsTDJV97u4Uc7BxxbxQ8/qxM/d9yRWvo8EXeDc?=
 =?us-ascii?Q?OVfmR131ws0+1tIPMQYXu1cqGx2cKQn3iysfJRiXrl1a9BRKKnOCR5921CH9?=
 =?us-ascii?Q?jI35lgyG1htCBUPuCOk20fundTNbvzqwODEokDNJCNzbvetff0vnQiR8ytGr?=
 =?us-ascii?Q?fxUTKZKesT6iY9uhleWXqZHe6BV9PS0wXj0yJoelzHoj5gURxh7WNKOlLR/+?=
 =?us-ascii?Q?l9B8XXFKyMifrU31lMN3P2KicVeq4NxKJ4vIfqdAhh4dIeR9QXA/Xo3euwPl?=
 =?us-ascii?Q?P39pZwzIVxOVMFkHuRi/E5pM9P7azVVqtxvvGvUC0gRLKpKZ6Z8VQfbKWZgT?=
 =?us-ascii?Q?tTt5PPc4mCX/WSs6+sTpBgNbz7GXqnRM5jJ/2UMCGzGKuY3WH+r+nLEMJ1Ad?=
 =?us-ascii?Q?g3FzCZptsiVgckI8pq1tTuMsmhCOrSxnJfLiMA/mjOCt5m7PU4Lj5k7sVGMU?=
 =?us-ascii?Q?HCnv/wqGkv8Uxsklxr5Adlxb4B2vgna9SCEzPrximtW0/wi3M53znFbUE41g?=
 =?us-ascii?Q?kefj+vN64B9wLr3xjgkGflcbCbZYK9EBFguiC3KdhkHNlXhVmiMvi1I3hS6/?=
 =?us-ascii?Q?yZt7GCsOqY/UWurK5nu5ghee4zXi2Obk9kWyL6nMRqqU7T5NHee9JQUpug9M?=
 =?us-ascii?Q?b2c25TaG0Otgu8IuRU07N1dfvRRGi9vR9Uec/W+oFNTRcs76fKSNfYHU0R4t?=
 =?us-ascii?Q?4/+DXUMRaXQVJaM5MEoAoUeWMqj1lPh2jlTNDcLULwuFRFeX6gqC/07RppdU?=
 =?us-ascii?Q?sVCLIUxsvQmNnhD3IYmsIOMmrH4dSiuoI8JmLRG39nCtLpQoWl4CR9aKVj5U?=
 =?us-ascii?Q?sOnTGqOeRN6HJB4aXl4k67NiMKUYMK9r8lt37MLCCt/9yZthfCazDEQYDV/W?=
 =?us-ascii?Q?PMLlc9jBxYWCqKYLWfUBqCdoQwygyOaAGTC0lqZpHrUnmusSMW3R0+MGw95C?=
 =?us-ascii?Q?ZZlXldhP/iQkdErNZxU3jWMbUDU1d5VQugD5ZOcC6zd99/sDVhGw9owJ24Ie?=
 =?us-ascii?Q?9gq1kUhX+wPe7o2XQO/A0PzUoIwVMuq6c8XEyip9nUXwxqOg0sgK5WSo2shh?=
 =?us-ascii?Q?WzyK9aJBa0Ys3WKF32xwZd2ByezwxnlevbA4Qf5eqm/5Iiif0tbn6AGPkOSh?=
 =?us-ascii?Q?8nUSWZFdRv43oAU/LOt7zWGG5znltlWZAJmjoqhI1u6k5HpmTLLViss1SWSx?=
 =?us-ascii?Q?EM3ow4CJyoBPyPWt8yyoIwnlq7yRggycS+IcX+XMi50JJEt++MeB8qY+hOud?=
 =?us-ascii?Q?8Qx/Doaw3mEV1hdtrQ/o+Z1T8GLqDPWoBgxc6RLbBrYums0BOkJ10eTQiwH3?=
 =?us-ascii?Q?t2TDvDhiPi9hkAs2MYVAOhnQ1KJWnw4Tw+9Yf81z6m3aoDeoZ8P/3+/5OnbG?=
 =?us-ascii?Q?LxGHEMbLFK3tLUXu54Dud+Yg+4YoDyHLoEndrKOV3oSDzT/bk1G9alBDjlRm?=
 =?us-ascii?Q?+5sCaI9rx4cqJqVZIksUhPl1bqiSpD7RdermPqXrGzbpQYMzscD+4RQpABTH?=
 =?us-ascii?Q?yXC/vnAANdiroooN+XwC68kgSd8UfbtLTYCBmECAN6dQY08ebNBgOVmCCCJn?=
 =?us-ascii?Q?i/cZFls+yrd7XPmJ5XrKXQemaT1fcli6Do0GtRW4lsKMvuhTNXf51oB774iQ?=
 =?us-ascii?Q?pi1PnwyhMlms5l7ds1wnEpRmHKHUFXU=3D?=
X-Exchange-RoutingPolicyChecked: HXZ0m9kjkrNJ+1wObIAcZ+1qNYWYDwYx5X4hUAPvMa4lwRz/wQb+Ql/7HOl0uaHbw0WZhcY7V1RReu348r+n0wLEqUWaoDHqgUqg0r4tc1s3P/+76bmxKq0HfXNSMuY88wtRX4uDVWb6yGDYS1k02S1qZGv5jqtqV1YZKZXuaUauDhZJgqeQ/JDGU0UZYCz2MMmBaE1HnIFF5S1ko0XbCr6Ksg8y5uucizJFXASKynLNjtjpCCvGXA4WYIu7ALS0XsTv2C1L4CQ/MyMTNtowMD6Ve4mh+aTXB8DiewRsTXO2eayIKyoS901wp75Hx26+OpvGbsrmrNDMYr8sxx6Jlg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17602d04-1b08-4c5c-d891-08df2dd1d875
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:12:21.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV0pZLRcNU00UrhDMjss/dtKuNg8127Xrmq6N15BumnfmJEpn8s7dDtVSfnzX/CdvPCMcwL20PkVKMza8pSIVUWVHFwgePYi/Yn0owFSw1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX8oxvd8A3BYJ3
 HzswaH8CXvxsGfOKdF09PzyEvExiHNFjQp/FFlDfhBOll7ri/ZFei84vkrZSeF4QqC9pIiPM1pB
 H5VDsB8iSePNyaA2nHVDZ6pMAh4dvBsrA/wXL1tdanIHmPC2J1HfAGXK+wAcht302qcfoRzbIV0
 TDHCuYGo2JFLwETf6/cffzefAnVSzcJcpl/SLVMa6o6azznUftEZUAQOHt0TwIKEL668lQFmZlA
 OKe5Ibb3EHnzepL6g+drv78mZI/dOkg+nhKxGOwojk0Nf7mWXx/1dpoePoSRGU72HJDCyFD+6s8
 IKNLDyLIjQdJYUpHHLH5Iujreg2lfeBpATqpW1N6yzFtqWcM3UAfTqA0oWw9ei9/dtO9ja7G90l
 GHsWZ6lz0U64g/8jdmaQv1rXdLCxbWpWBqMuM6WFfbE6fDEWG0oFst7hAh2YN7QdwdmrdG3E98+
 mUCgdbz/MJY+c0u4ldg==
X-Proofpoint-ORIG-GUID: UAYemdk3Ep7gHFtP9oUin9-mwWlaPQam
X-Authority-Analysis: v=2.4 cv=RI8mjIi+ c=1 sm=1 tr=0 ts=6ad5fb19 cx=c_pps
 a=85R27yqqIDOPhBwKPsrjTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=BA409LxbDWUx7DgykJgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX4t+qBHc3TPLo
 oeV+fNn8xka8PX+lElxZ4HeWGprI235IEp7Of23zPqkKZPb8n+lnekm83ptzV5zvicbFlcV+ecT
 GEeRCsM5TWQjDWrwZBGHrNdI2S1uH8U=
X-Proofpoint-GUID: UAYemdk3Ep7gHFtP9oUin9-mwWlaPQam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

This series attempts to improve the modelling of legacy x86 PICs within
QEMU. The initial aim was to have a qdev device with one output gpio, and
16 input gpios representing the legacy IRQ lines, however as I went about
trying to model this, I found a number of other inconsistencies/bugs: in
particular there seemed to be some fuzziness around the functionality that
belongs to an individual i8259 chip, and a cascaded i8259 configuration.

For the purposes of this patch an i8259 device is considered to be a single
i8259 chip whilst a PIC device is considered to be either a cascaded i8259
configuration (emulated/KVM) or standalone device (Xen) representing the set
of 16 legacy IRQs and a single output IRQ.

Due to the updated device names, there is currently one visible change in
the HMP monitor output for "info irq" where the isa-i8259 device now appears
as isa-i8259-pic and the kvm-i8259 device appears as kvm-i8259-pic (see
patch 25).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[Patches still requiring review: 18-21, 23]

v3:
- Rebase onto master

- Add R-B tags from Peter

- Introduce isa_realize() function in patch 18 and use it in patches 19 and
  21 to fix refcounting for ISA devices within the PIC container device

- Don't pass input IRQ 2 from the primary PIC when implementing the cascaded
  PIC configuration in patch 20

v2:
- Rebase onto master

- Add R-B tags from Peter

- Remove FIXME from commit message and rename trace event in patch 13

- Introduce a separate I8259State for TYPE_I8259 and KVMI8259State for
  TYPE_KVM_I8259 as suggested by Peter

- Keep but rename the associated classes for TYPE_I8259 and TYPE_KVM_I8259
  and move the DeviceRealize function into each one, instead of keeping it
  in the parent class

- Add patches to make variable names consistent when accessing
  I8259CommonState from child objects

- Update the comment on patch 19 to reflect that implementing the
  cascaded secondary is actually a bugfix


Mark Cave-Ayland (28):
  i8259_internal.h: rename PIC_COMMON to I8259_COMMON
  i8259_internal.h: rename TYPE_I8259_COMMON to i8259-common
  i8259_internal.h: rename PICCommonState to I8259CommonState
  i8259_internal.h: rename PICCommonClass to I8259CommonClass
  i8259.c: rename PICClass to I8259Class
  i8259.c: introduce TYPE_I8259 device
  i8259.c: always use cs for I8259CommonState variables
  kvm/i8259.c: rename KVMPICClass to KVMI8259Class
  kvm/i8259.c: introduce TYPE_KVM_I8259 device
  kvm/i8259.c: always use cs for I8259CommonState variables
  i8259_common.c: always use cs for I8259CommonState variables
  i8259_common.c: use i8259/i8259_common prefix for functions
  i8259.c: use i8259 prefix for functions
  kvm/i8259.c: use kvm_i8259 prefix for functions
  i8259_common.c: convert to use DEFINE_TYPES() macro
  i8259.c: convert to use DEFINE_TYPES() macro
  kvm/i8259.c: convert to use DEFINE_TYPES() macro
  isa-bus.c: introduce isa_realize() function
  i8259.c: introduce TYPE_I8259_PIC device
  i8259.c: properly cascade secondary i8259 from primary i8259
  kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
  xen-hvm.c: rename xen_interrupt_controller_init() to xen_i8259_init()
  xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
  i8259_common.c: remove unused i8259_init_chip() function
  i8259: move InterruptStatsProviderClass get_statistics() from i8259 to
    PIC
  i8259.c: switch isa_pic from I8259State to I8259PICState
  i8259_common.c: remove static irq_count and irq_level variables
  i8259_common.c: add missing 0x prefixes to "info pic" output

 include/hw/intc/i8259.h         |  11 +-
 include/hw/isa/i8259_internal.h |  19 +-
 include/hw/isa/isa.h            |   1 +
 include/hw/xen/xen.h            |   2 +-
 hw/i386/kvm/i8259.c             | 250 ++++++++++++-----
 hw/i386/pc.c                    |   2 +-
 hw/i386/xen/xen-hvm.c           |  40 ++-
 hw/intc/i8259.c                 | 470 ++++++++++++++++++++------------
 hw/intc/i8259_common.c          | 225 +++++++--------
 hw/isa/isa-bus.c                |   5 +
 stubs/xen-hw-stub.c             |   2 +-
 hw/intc/trace-events            |   8 +-
 12 files changed, 648 insertions(+), 387 deletions(-)

-- 
2.43.0


