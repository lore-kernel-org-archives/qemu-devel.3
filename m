Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D11CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIIh-0007G0-Uu; Fri, 08 May 2026 06:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIIg-0007Fj-H7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wLIIe-0006kR-QA
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:18 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6484dDIt3427581; Fri, 8 May 2026 03:19:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYv
 aY=; b=aX47SLkc2aFcFLC36KrCnEmpPnHMQs/yoFZXNR61IRPjFLqxswMQqyfE9
 ySmKy0tMgKT/VxlfNoaKbkfqam6cfG0PmTIXAIDZghS0uXG0onlzPRHWZbtusrOm
 OLljZgJoG/HXXkC0lWYejs4iZbjVk5RCfnPgaPqtiWD01HJ4l4lusqnxh77q4Yb9
 3aviCclFvaieutVYv6kTYqA+2FB4o+uPlicneeerDkUX9fOr5KTlnxWd068vFWzo
 sun3ecsdE5INSBHtCAKuGThwLGxUYXs9JOIkjTocDm2AWWKJjHLWxMENuM9x1VXB
 rqBJ8KijEI/WXzMdulUf79WxA0gKw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e00aheum4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 03:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFSFgblBhNfX0sq8mXJ0Ny59ejrzRWwYBCyX4JyXzKXLFQU/7efQX00rxv1h4L2FujItivNnmmHJVT4B0mILePJfSdgBrD6iGyi/6/2BLYoOpfQG5UnBRLTa2D1O5ynqn3AN0bbIzspTv+7t0jolGNUCKxVih9xZbxPNIPoev3gQsfSJXvDhPHwSXomCaWy9DVNLBBlP0g00PclbEuHTdqIdfyYJzPz6SRMtzFu2xhra1ApsxUPAlSd143/VYtGo9CRomIWqVeQS/uMqQduhZd0A+0uHqD6nNusEj0oM6JZM+aQ5VRFkZffsxJjMlJjmRfbfYZchX+zWT/AOV90HoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYvaY=;
 b=HpBDQXJ0JNloRGD0BOS4GCk/Kd3aoIAM0jormraKcy0IJuo68V9n+J5jaKJuIDn3st/DQJZYWzWGFT+p/y8TR8U3a3Jl9vfpkF1rF3E5+FU3fFo5OdLpUEvfW/u50cBB0BKESUtdnSekXof/5l6OAjFZDcdmPpep01D6/fLYlPxvyeWC3z95wajAiVBZ34KjjlPJrRJCUI+xGMjw8S95kAb2lha0rc53f2MOyt+CLtb6OVSMJNkTQq16Yx7Js4i153pDVummVzoe9tstq4JCpUCMP6L94jdLixVxewGIFyNT9eVB0C4t115rvOI1ayFDmUOB8MskcT5/yqoBTxhmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYvaY=;
 b=wCX7ZLskoiGqL2peOh898KkrqMjt0vdzk83Kz0vkLPjJ31b6s0RKoqRJX4GqyekzYetpAmUaNpdGRt+gBimQn4Nr3PHo3cTwZfw8p4AQsRM4RG7Yf6HwQysprS0NBxNeiRZKCWXLOtQtCbaW8BGTUJ/F05oomaLBnDBDPlDI2P8Hli8eAIMsU1XqQVVeBDTH3PyOTbymS37oe5b7yZouEU7QnCcaelpirxUkYsPU626AF55z5pGNz0DNe0aCo8Y1iiOrm4+KS+nxnJXRDlVC8KBzh8M3VQOShX1Sh6FQmmi2jRHSJFSwQBA+4fH7qunr2puVXlN7/KDjl4mbOlr6xQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV3PR02MB10763.namprd02.prod.outlook.com (2603:10b6:408:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 10:19:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:19:13 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] tests/acpi: allow DSDT acpi table changes
Date: Fri,  8 May 2026 11:17:41 +0100
Message-ID: <20260508101901.930781-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508101901.930781-1-mark.caveayland@nutanix.com>
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV3PR02MB10763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9456664a-80b6-42f4-d3dc-08deaceb40b2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 24d32JyEveJSdP5a6z7ffheidTZyEJqkXsrOZSHA0FpxIW6815DVAg4WwyqMnfU7F3IRTQ6IlFkdXIwftSTLw9GGV6o9G2zWmIUhWlKEVqbpr77oXy4QBiqUCHKctprhLyxJA3meco/eE4Pf3ok0CltAjZPMWL5BieMewa33OdLo2knTaPia766hkDRbT8lCokloRkWSd8RKzlrJiALGLq03yp4DsfK6T9flBFZ9HOCOaY69tuhk1Nctb2iXxau37eAn8D2603mjVdE8bkIVhbshPZ5iwPC++2SiKMlTeatRvNYHIfWJsgBWO9gVIAjsbpHP8KN0/EJbLeV2lzmaSoopGe3ltNGbtKY407wPx4o0BPrGD7v+t9nKh0dk0SwTEoKoAjtEsZ2ydVV7LwzDOJWBDIe7n7ZOewOs0d20Qqao1IjJ7XGD8YCLojOiRmaLRBinsMeYuFur5F3AVuwH34V9QE2/Tiz15ZABp5YrtADgb9s9IDuGvAPLJiZX1Calvtitg5mwMNDMedjl8KxF/5EiLxWThno/n31FkxKZo1jOaXLvxgmiQqO6NDJ/MbzRPN02DKZSwkm6fgubJo+aHsYEk/FLAGHKRuvnA8n3zg5eczRgpk7dXoxEW4tum65V72cLspI/KmOE6UvbDBKrMMcDWYp3eH4Jw+A6ilrjJacpxMXYc5Vkf8nxDx83HlVg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTZ9rpn+OpXOoo1AmKabIFnZrNl0KOZ85Tde0EXhoGrxMNTyUDRh2sBNtsoS?=
 =?us-ascii?Q?4PkyiXQqYJ4jQ25pacFV083goY6CvNQ7E04VaN9/gkYByVdpjhUdonFzeRE7?=
 =?us-ascii?Q?6/CuXQU5pGZdHswxpu8HRk8NlO5LFit2J/HPrAVmqZlumOxSCK1tLFDrEISo?=
 =?us-ascii?Q?x8gnmIsYM1abB3i+60yDBTxVmrEskUMtetFNvjdbwmJZ0yHFOKfvdkzRqXGn?=
 =?us-ascii?Q?84Cu+pKnoO6JGpTcarL39xPEORO5G8kZhaEXYC4gPqfeDhzg+cHIFY+sHR9I?=
 =?us-ascii?Q?atYQokMVj01iDg+N/lHDW7rnrY6ur/Wbg8zuWE2GdbtdPnQPxlYHhFjHD0BC?=
 =?us-ascii?Q?mu4Y9JgtmPcPVfE3PVw6p8l/ovl5RerS4BRfypxw5fKgynxjtXMJ8VcDzPbh?=
 =?us-ascii?Q?vjOLLFm+Rm0TLOBcTYMtPTSHiXqA7SVvLee12AtvznrTJgKn4r8hqOpMTikB?=
 =?us-ascii?Q?VBWDXf7Gc+OQnra3IaOjXFPcHLymQC/4DXCf2d09Eslsk3UarPYTf4VC/UFY?=
 =?us-ascii?Q?KL2zKGLQ1UPhHekDfwskggFylvP559x8uAZZmxFDYFMpq2CwW+J1gwDZ+RbV?=
 =?us-ascii?Q?jGJo2Ofw2FiFVkWlB4R0hvk1thLW/LCs31RvTyO9fUS/Hx7CtpFaitlq6P3U?=
 =?us-ascii?Q?+jbZLqfs2kYZJ7wiO2H2hHuL7D4xe9gSkTrmBET4KHDFvcGGQcktZx8zCmpg?=
 =?us-ascii?Q?EHK4O/m7dJdq5kH9Ig/aTadHylOItKn+Gjfl0lPZbFUqFk6I0oEvGz2W+Kgi?=
 =?us-ascii?Q?W07PomOVAaZXLhsF6Y0TEj3k4BcQqHzmvu58hEbQ7tmy1ZR4969/Ua1+6cHy?=
 =?us-ascii?Q?K8GnFPVzVGKyYZozL+tDSnsP1KCHSijXcc9gkryu8NorMko1EX1RmcDPFyK4?=
 =?us-ascii?Q?XyoI7m/Lc/dv/p0UNWMHsemFeZMOBSKRxd6wtWPze4ww7eVGnSwZ02Muw/HL?=
 =?us-ascii?Q?fbpxSq7x/K72VbXemrRNEqHjkqozBGhWr9Fd4NBr5cu21ssMI8S5pDQTx9Ko?=
 =?us-ascii?Q?FkZDTKkK9LJslOMaXjqiNQ+XkmMyAyTvBAWpcMzEysYlZcarHeoR9HDOa9Ns?=
 =?us-ascii?Q?diRp/X/Mfnylhaxr6pcotPNI8UvdPgeEb35ibGN3a0bWBeht677UdfsOaFI9?=
 =?us-ascii?Q?qPFRVWJm3brEiQjIec/LkxASbuuc74RvnUiImWB1WkxuPVXMahComnq3dgqG?=
 =?us-ascii?Q?ImSHpHxzzF6zHUaZXx2vzjmSzv5XSzh4KiqWdBAGQkf/PknhXHkcP4gLr8AQ?=
 =?us-ascii?Q?wMsyuyJzFnHwUggVsMtPzCQS2HEn3r4e6DNSShlPYAnaxNiB6pty16FG3zaJ?=
 =?us-ascii?Q?+LVJ0FqHcF9X6IHOEkwlEnkISbYgGOPTculoapSs3CNlcjG2DCj8ke9EgoqZ?=
 =?us-ascii?Q?QJBhWFNv35Ziuf4bwLdNbbTWEezEmjVqH0beNoPXdtlMl/TTPwPWwBvlWQEo?=
 =?us-ascii?Q?e3mJYZMWHeBoDP1UJQj+DmqfydcTH7LLuxIttI0sllvwkgZuIrm2KBLhILhz?=
 =?us-ascii?Q?brCPybMnUEA82HxvWu6dslLAdE1G4E3vNp/gtWmb0Lc2Zc6QHdBzhCLsDYmX?=
 =?us-ascii?Q?Kbm4ZzmZY7qJGyTXnvFkeeijDqT/BgowmKwwXu01tBnWeN6C35RIUU9LSFgU?=
 =?us-ascii?Q?8TBQfYO71R8dXOlJiwV7fjMejlcEgRVVacDutDqou3z+GCiMqQmQ8CY7CreP?=
 =?us-ascii?Q?LqRPmlQ6YFuYvOshMVDOJfOdi6yOuz+P6HnG4dM17AdfdrR6xA5zpGTz6Z3m?=
 =?us-ascii?Q?5lxZWQPX/06CTVuNaRWwZT5f1+rptbI=3D?=
X-Exchange-RoutingPolicyChecked: ESObuInn0NK0VEDBdGYgRwzeU9OooSd5a+DQ+oy1mRZWRlQKnWACvwZjafxVbLkKw44ne9Astam/klak4i4PtzQyq8RsTUQaW4bQSIn4NTdX8B4ODyVTi+SJmpY69UbAaS6lmfh2q80uhv3sNtr/YaZsE3rpWA/6ycEEpfZoVt/BHmMhWmLOKuHqUHWTGBh4cwhBWjfkNYTyvxpCSqqcAAI/au0vukPWnEa5XRG/0majNJzd1H5YBKcPWxdjMsz0vO4hAiw4PUxpJVAp0VaRYXceDPoDNiVdm0Ci6/bZ5X8P6ElR+rNZn8yW64SHIL+RPF0MASmbwo0CvFxfpsxBJA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9456664a-80b6-42f4-d3dc-08deaceb40b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:19:13.9152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rxqzjmn4oyPMkFq15I3nKN/VWifLxjZpV1vUJy4ZTVDQEf5BWmzsS7b9bA5z5hd8oaYNk4Q6bxy37LLtUYXxi7DYNAXy2dA3ZtWcB3njaBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10763
X-Authority-Analysis: v=2.4 cv=PcHPQChd c=1 sm=1 tr=0 ts=69fdb8a3 cx=c_pps
 a=0TjXLQglyxsLlDBGQ9rQow==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=w1bZv0MCpcxBmq4Jr4kA:9
X-Proofpoint-ORIG-GUID: E4i6bdmpWxtqXm0H9DOCZiMiUgGWJ2p0
X-Proofpoint-GUID: E4i6bdmpWxtqXm0H9DOCZiMiUgGWJ2p0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNiBTYWx0ZWRfXzwnB057CzAiI
 EA7Y1boffQnY3T96Ih/hRZiIy6jmoxsHkN5TwNG2l9GRVeF8yHFGVkx2F11JbOQ3WItddi4yOYp
 gxNJWoBE55ZzAjzp3FdrXIECdo2fJgTzOQduysxPcM+7Lm28yMwcADYR0rianPFIsUyfs4BNwWp
 F5Tj1wLg1IuhL6WgbT7IeV1Jk7+Zqbmxz+hwKhJpfVh5VG+C/BVnXHrNl/anQ8OaE9pfaAPF4/r
 0drpTiBBiFCwBCGAXaS8cwCZ6yNBEqJ7WdZ9MreSQ/GOR8tZmg0jVtvnyr3zrHRqo+hHUiZ1iYu
 h4fVkkU3bU9oU6OuOZJpBZdB60xgzf0i4rJaBmP2SnFYIZfOBfluHF+T/As9KkuvNAWqAQ4uN1c
 oapazixsrI1WPlUMxTiBNH/WHWzWNrIET4pZzq0FgHV+LgfjcRREPoP5Cu69IdoHTZ0CTMK7oqR
 JvsHw6xdCiUvbKE3Ycg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..cef44135bc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,48 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.xapic",
+"tests/data/acpi/x86/microvm/DSDT",
+"tests/data/acpi/x86/microvm/DSDT.usb",
+"tests/data/acpi/x86/microvm/DSDT.rtc",
+"tests/data/acpi/x86/microvm/DSDT.ioapic2",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


