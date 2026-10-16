Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9FACC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHir5-0005po-1z; Fri, 16 Oct 2026 10:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipz-00043M-0F
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipw-0006oK-RB
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:10 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE58vb1681992; Fri, 16 Oct 2026 07:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jAxNlriqZfbJNNZh+y/GFC7hgEb92Xvhe6az2crKp
 S0=; b=ZnUCfq5+A2Iq4n1KdTCb2rO/6hcXxvWJgoTuC3RQFuPOLMtUSSF3NDKFa
 qb2PM+l0wABic5Mv4xnN9FTsFLG4a9teuW9SIcKeisU4zdADEsXaiT2mUELLlqCI
 gNJ2zAA32tRhZcKyXB40LPqOtnU3S4U0cViKRqxZgoUQ6uIY51IArJ9CBAD2FX1v
 36eYzuLna3R9JF+028TzIjjbK5ZPolRFefc6l+UEUbSTO0fQXoxTwBzMYqH/nFGO
 ILboWvDQc3wPzkusueuaQAHHa0uXIox20kP9KynJ6lg2qKYf4qFYCG7o5+5qQG7p
 D9a4gvQiQbQyhqrz61ZEoODcHWuGw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hberu10kd-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKSUcP18zu/1uGyjB9EKXuVoZ2ybVXS+Mnh9rDoSFyeZNsJ3yJvELHbWgF51IHntKXmMmW4l6H7goAL7w0QldzBKbwdbWXzKPLg8LaiePrtFz+BNnnNxhrnO+PF/4lKbk+kvJcNdCMVamoXSFmZ4N56IIsLyVMRdkXbpBOeuMcuK5N3kgj9Ed0OaghpjAsV0mGGSX0O6tbbAutyOqxRY3190Jtnrmmr28Lc015TnXTmpMD3NecUASQCCtyFuLpvjEZF7lx2ZWmMON3qs8UbEQiDu45YCGRxF/g7yYO0N/y4/WfzUe+n7gNysifKDchzE9S7ZWp7dLH7NKucbBtxFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAxNlriqZfbJNNZh+y/GFC7hgEb92Xvhe6az2crKpS0=;
 b=t4sP95qA/MXB9AmHP66jy/q0trOYclSaTn8YeCZ9BdoxoWMC2KV/z2NAxzqX74RnZshKhWNUO2xACVibvCqtU5Qbr2UXCiKn3vG8AhGfkrqQsLAOwZ+onUFRdGXuHJHWrScSwWKUqxWHV1sW8RDVmQh8owZSJtk7xojEuOxuZ40EGY5OqV7JY68SUH9BqGuUeqfntJVzlwVi5z/rboEcYcFkH6+oWArD/WLu1onTIS6lklY62nm06gdf4GY+P/TI39vsV7wc3JrOgo+j8T44dDFS0nOPytWX3noqtRUzuutd6w6TfvBR0THzXqiUT+KLj6lh0sVLW7P/IZwA6j72xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAxNlriqZfbJNNZh+y/GFC7hgEb92Xvhe6az2crKpS0=;
 b=Xs6djbaPq4b430cIxciznJ9mkcsBy1bcpvFF8fekM2a/CktKADtBRFMXb/n3BqfUYYqIe5yipVuiCBdWrRMiNjt9gbmdfMtSqI2zaXIM1qzskxOkVNNv34QYAZFN8+/rDDJk6f/q5jLOpoiXf0R1FxLFw3ohZUCaJg4VGeNU/uYDyBzGs0PtDj/eRRWbl2j5FHca1Mu07NWtlaQM95xXZSTC2ER/c1xaGvWyQXXEiCZVRO+COW66bm2LL7MDrASLT4/SRXMpdE4DXmgW7iCC1lfq2r/dZzvuvDcJR+2vgE+ITL9V8RZQi8kpdE0rRYAjX1ieztz2ZDwsLPuVc/j6TQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9592.namprd02.prod.outlook.com (2603:10b6:208:3f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:22:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:22:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 25/27] i8259.c: switch isa_pic from I8259State to
 I8259PICState
Date: Fri, 16 Oct 2026 15:19:31 +0100
Message-ID: <20261016142031.1204281-26-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8507fdd8-39eb-45af-25d8-08df2b90e3da
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: HA2YL7ronoArge5V8opli96wjP/ydTmWh3Pgzl89+DW+zbPYFMPh+7FKyRrsUD6HOLHRCi2GyksEL3kD5cVFG/7UDtT8sXHUJKb0Dh8xuybAXIUE0iBm4nWjQBR41hCZOkiw4AN6293dIeGHNiAP/IARitV6utsg986S23+FckICqKV1+ear7jQs7amm+qvHa11VkkacfHftB0WnkFJAqhKTQwbOnKR8T+ZGZn0sjAAb3YfXu7mjmt3FHVhJlwI9MM1xmStjNbCCwagH8bXx66dXQvUzxfOviS7VmCd6d0CAuTraGjC29gVUkZ2oVzhN5TaWM5VeqtRc6M0HsDk0euMXjGucwWIh48yxRNIkBH9kaKo5gEw5NyKi4hR+FIgis/zzZudhIDC3J9PQvhHbvZYpwrBA/isXzjlzR/9Xb3wtBdcOKojBsGBojB+tuLof281Pc+gFaej9YpijnIh/asy3PqkbQY1V+q4ry2oQkQq7aQlFWNCGxH5v6x/wTOtHlUEDq6VAQ5rw+/KEbrnDjcRKQskeegCbijXYHmzOvGsu2TTTPBzSy9YlPtSA37JoegQW1uZDxPAox0dZ/77zEHgtEkUV6Sf6cjWfiJfQeFHVw3hUNdMSKdZXp65JsfYrLY4gTmgt+9vKiW+e/FBZ6qOLorTXtXwBz3woxogL7yw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jm7+nK+wXs2sRRra+e7vT3OGXJKkB7WpayiL0I8uIQ4exuEIJaKbTjZFPe1?=
 =?us-ascii?Q?WhJQNSOjjs/luUxCWTlRcvIQ/R+EZUTD7cqSJGlZ+JzNCW6CnWNBo3wd/Cn/?=
 =?us-ascii?Q?ruTh9Xq5pHkYMil2B96OJprSnafwHCKkmjCk5Dz25cvfQTvo8DtAziBGMn4e?=
 =?us-ascii?Q?It/He7KVB7P/P/pRrZ+cm/aZVvIzixksQpQ+2yubPDOPcjJAseZRNS3K76S9?=
 =?us-ascii?Q?jCiNovvYMoZiVYI9UT/OAHGHTq4tkaf8/27F93FWpHZgq7tk+1bhzz6pz+g5?=
 =?us-ascii?Q?tgTCWsg8465v22HmQzjDYYJZguRfsg2BAJpEfZnVV08hqNt1a9tHI7BDu0Yc?=
 =?us-ascii?Q?M5jAmODoPa7OLCNj7jreghrb/sJQe/L0aIzh7puFHqJNWgbev2moAj0fuoz9?=
 =?us-ascii?Q?oE7Up63L4KQicuOM/9G0n7sTwZUNnDYWfzIbqxNyI6ah2JJPZyrdjmGI15tu?=
 =?us-ascii?Q?ORSeC+lcuN00n9lxwYmxdUqUDJtAM9YQ8zYj2VbJpZLKmbJ+7kUd/M7OwjLE?=
 =?us-ascii?Q?1e6C3nk/de2PoNOEIrrtUvjf/GrBs2Q5mKjpnrbH2TGE6u8dnga7bmBdEpSL?=
 =?us-ascii?Q?nfTfnlwr9x9yK17jVEiLu6OgApwse4T3zz4yTVYFDWBEh27/nIjhjj+rO2Lz?=
 =?us-ascii?Q?iysDOMWFTCYKf8Xb876tWHZv5AMK/u22m74rLwjEo0+C/5oG5sGoLceXc0tv?=
 =?us-ascii?Q?f1iCfDvmLtquXDA9KKv1jB3YTLoMkJECGDaXVZDLbYGjN/GeXuFbr9DElLnz?=
 =?us-ascii?Q?zwu8t56PyAHH+C0v72Y8Uy7hIxZyxMuzet+93jLCWlhkldo2t3sFvfqPxAbk?=
 =?us-ascii?Q?/55uHUQ3+iwZBaM2H7IoGboQFmBbcKbdrjMUu4mZb5n4oLZ1HqzKyBZtXuLW?=
 =?us-ascii?Q?qHRgTmPBKuRCWD0Sl2CLQvx6twgD/5hkbjz4SUec9OgWzx4Y4es1dI49jGOv?=
 =?us-ascii?Q?Y1QjuLmkYd7OgroSmWZQQhlB6e8XSu+DaQYOTjKSNs9RkraDtzng447K3V+I?=
 =?us-ascii?Q?Qo2FeTvbVHEWgKuk1w2BoeCLqWFNoJipFcNtnHwfqwLwkjlncDzeQEJ9mDbv?=
 =?us-ascii?Q?7M+cIqVtOX1PpxAwq3E6U2NSwUOwPK4CeFVamdPh4MvW9UjAsnzq+pF2Aw2y?=
 =?us-ascii?Q?HGj1OREj/x0JuWXI2Sv95QdzfV0XvCXo0blMRNUf2FXvCPZvY1gjBLQYUsia?=
 =?us-ascii?Q?wfsV0t/PPsqY/6mc7iB+soMgEv+mauk82DNPkjg27Wr+AZkfKC1GnFzWk0kC?=
 =?us-ascii?Q?7LRKdB/bOl2cAFS2CrzKu3B7HzXWAixLE8p54rtRhP+Whzx+HNv6YTJuvGuO?=
 =?us-ascii?Q?DMpeZwx8P2hOA/7HsoDCyGR8IX0HdbG1yFdjDbx67/yaB/Pp6EfRunW5pj3B?=
 =?us-ascii?Q?Y8X0iQvuDcfhS8SdRBBSbhE6Dd85nusw/AmOR9GxWwLfN80fadv8p+HvzK9A?=
 =?us-ascii?Q?UAqDH5iv66eYMQLsPyr4z8n7H0PxOxcEdoCN21MsELXseT9hqoeuwC9gUzHU?=
 =?us-ascii?Q?MIust7z9eEOP5snOvi2FzUPdqp1ce7GQkwfmaDCHBcUELO2Ze12C/5q7vkF3?=
 =?us-ascii?Q?asz+KxszXW0y7PKZ68QVsmwCK2IFCMpKmoQkqsvpa0diLgN7260ya9Q4oIW4?=
 =?us-ascii?Q?j7iFOW+9UydEQGCblrydigpugi5pxT1mW4wH2VkaoM0OM7GP5TAvGJ4eU60Z?=
 =?us-ascii?Q?Gi6b+cZe8Cga91hA2CATac23XtjFseEMRKDuYwpuJ6VO/4HHxITbT+e4wusk?=
 =?us-ascii?Q?xUL0GIWWJZIUbDWMG8z9EtsEyJjEOPM=3D?=
X-Exchange-RoutingPolicyChecked: zplCb1zP+VSYxU+vOXUkf4ksEwgjwMb3uf90fRFCMxRbeKMGaJRp8/gWMNv4anNfZV806rgSDNx3mgmEdE+oNMfsvBT+0Njj8xtAKaRGjKTlM5YIUfJdMlvaWJi+QgzAGxgOyJZAQbaUF78GQ2ZEp2PddCEhTQ74pOEeOhwSI5aoAwxl9PT8397D93dA3glL7PNVnQN9xnRHQrjNi+vLy0pDON2P/OvcilFXr0iq3rurTeqEXXIVrgUMz/IMYCMX/AmjfbM9a3xDfith1IP4a0xNDludgitA8YY+lzOeafvSBvTEEceeFAYDhNQ/f4O2nW/8FVzEIBJgzdYd6lPtWw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8507fdd8-39eb-45af-25d8-08df2b90e3da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:22:21.1185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 125Qq7YV8ktJ9cm9iMm5PZCfdBsuJQDxii9lAXEqq1Jn5yqDGvBAPIJtV9RK9dwc9A/mCnaG4Wvy2eGrNc6+kGTQls8vgquLojS9zTvqGKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX7EF6kXHjhQAu
 +8jaIHFOl+WsvQn9Orb5l0HJc0zQ5oHS646VaDAn/nFJopzOGsEn8ZgnP13xNB3tIJzc/5rz4xL
 kjueZlIQ/MKnz/mM5h0nm2MzlYIuix034oIzPMRLEAM4Z4/hJBip3cV4jO+WIwuKiy7RfsAu37n
 mEEt2OnqK3e4nPRPa81XEALsOheMKcJtJIxfmdZ5EyK09/7GmUczE5wgSrHANMBIqUjRuAUOeNU
 fkqReeG0IpsQdx1pLHGPhAvYzut4np89/GJ13oo3m0WKz0MXkT19EYINZu46LK5XFGg8lnqMQxx
 jFevMsxAQIi8He5VQ6oPXzMGEIsg4P7yVp7u0XaOqKbQQMTmnyPWxrUupcDo5vyP00GO7MZV3p7
 rvgSPbSBKovcYEvtiEZsU9khhxKx8g5xlId//Q7UC8UTmqCBa2PJBI5wDTu9zwrTpwTCmenGuql
 NB8OI5igpXJ4/kAxzpQ==
X-Proofpoint-GUID: vRTbztpDPxhynNLAonNftkGjlZ0Hv4Yk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX/Mn5Jy+mzL75
 OeE/ldX0ZM2GmQOFTsapE6TaJjeT4xRQsiEfwUBtHROD4ggthYadkqclClnPpSiMG8QPPvQVs+G
 9s8syAusa1NIiTBfKk7KJIxPWXLswLw=
X-Proofpoint-ORIG-GUID: vRTbztpDPxhynNLAonNftkGjlZ0Hv4Yk
X-Authority-Analysis: v=2.4 cv=KMLPn1Fo c=1 sm=1 tr=0 ts=6ad23340 cx=c_pps
 a=7kgNGXaSmB15KJ6u7rEBag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=Re7Oh-p8VE-n4k5LXTMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The isa_pic variable exists to allow the output to be fetched or read (fetched
and acknowledged) from the x86 PIC. Since this can also contain a cascaded
interrupt from a slave i8259, switch isa_pic from I8259State to I8259PICState
and update both pic_get_output() and pic_read_irq() accordingly.

This has the advantage that a i8259-based PIC device contains its own internal
reference to both the primary and secondary i8259s, and therefore it becomes
possible to completely remove the slave_pic variable.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h |  8 ++++----
 hw/intc/i8259.c         | 34 +++++++++++++++-------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index d51a7fde32..4922f88d5b 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -5,9 +5,9 @@
 
 /* i8259.c */
 
-typedef struct I8259State I8259State;
+typedef struct I8259PICState I8259PICState;
 
-extern I8259State *isa_pic;
+extern I8259PICState *isa_pic;
 
 /*
  * i8259_init()
@@ -18,8 +18,8 @@ extern I8259State *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(I8259State *s);
-int pic_read_irq(I8259State *s);
+int pic_get_output(I8259PICState *s);
+int pic_read_irq(I8259PICState *s);
 bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
                               uint64_t **irq_counts,
                               unsigned int *nb_irqs);
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 842507f9f8..7c9ce2315a 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -72,8 +72,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-I8259State *isa_pic;
-static I8259CommonState *slave_pic;
+I8259PICState *isa_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
@@ -190,34 +189,35 @@ static void i8259_intack(I8259CommonState *cs, int irq)
     i8259_update_irq(cs);
 }
 
-int pic_read_irq(I8259State *s)
+int pic_read_irq(I8259PICState *s)
 {
-    I8259CommonState *cs = I8259_COMMON(s);
+    I8259CommonState *pcs = I8259_COMMON(&s->i8259[0]);
+    I8259CommonState *scs = I8259_COMMON(&s->i8259[1]);
     int irq, intno;
 
-    irq = i8259_get_irq(cs);
+    irq = i8259_get_irq(pcs);
     if (irq >= 0) {
         int irq2;
 
         if (irq == 2) {
-            irq2 = i8259_get_irq(slave_pic);
+            irq2 = i8259_get_irq(scs);
             if (irq2 >= 0) {
-                i8259_intack(slave_pic, irq2);
+                i8259_intack(scs, irq2);
             } else {
                 /* spurious IRQ on slave controller */
                 irq2 = 7;
             }
-            intno = slave_pic->irq_base + irq2;
-            i8259_intack(cs, irq);
+            intno = scs->irq_base + irq2;
+            i8259_intack(pcs, irq);
             irq = irq2 + 8;
         } else {
-            intno = cs->irq_base + irq;
-            i8259_intack(cs, irq);
+            intno = pcs->irq_base + irq;
+            i8259_intack(pcs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
         irq = 7;
-        intno = cs->irq_base + irq;
+        intno = pcs->irq_base + irq;
     }
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -369,9 +369,9 @@ static uint64_t i8259_base_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(I8259State *s)
+int pic_get_output(I8259PICState *s)
 {
-    I8259CommonState *cs = I8259_COMMON(s);
+    I8259CommonState *cs = I8259_COMMON(&s->i8259[0]);
 
     return (i8259_get_irq(cs) >= 0);
 }
@@ -428,7 +428,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
@@ -442,10 +441,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
-    isa_pic = I8259(pic_obj);
-    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
-    slave_pic = I8259_COMMON(pic_obj);
+    isa_pic = I8259_PIC(dev);
 
     return irq_set;
 }
-- 
2.43.0


