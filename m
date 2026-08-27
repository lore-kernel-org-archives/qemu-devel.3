Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C179C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBu-0008Fz-WA; Thu, 27 Aug 2026 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBt-0008FX-D4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBr-00021k-Af
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:53 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE9u9f3909837
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LkGd6yJ5Q4yneURiDanrNYekBmyfQ6tZO3oIVk5Qi
 qc=; b=iZD2EJNshL1K1h2TlaSPdMxQS7Rq7RE1ToV3fBCmhUgfGtHEcgLUHRTKN
 fQ97PEEDi2lqNHfjRynz9eIeB4he5yigUPKJNbDbErpmIjDHxA9nrwHeZxl8wwk7
 DteZbOqyYXPCbBH4SfyZz7q17nvKbsANjBhFxjauogJhzgEeQH1fu18XQw9XULoO
 AdEfhvMv69c3/P6A8C76lZVwWUKNvnJoNx7ge4fBTSlYtQfgf8ULrHxNGlJBl2Zf
 FUK4hHD9ofAa+jQAH8XbUjNuXvpcTQIAhx1Waaa3Uu9egTSXT42b7lIL3iGgKW4r
 L33I4/RqOydmwchLhvekzrVuWlrtg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021094.outbound.protection.outlook.com [52.101.52.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g9fmmwkg2-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4Qq7XGI1lKJfu8MvsNwArNmOLSOaICiOTP2o+o9LGTw00keK09q22F5ZfqGrfSEKbcfXVz+ELyjMPW3DPvr7BiKLPVIfUDusPAMM4MvFIxvlXasxksH7GpMOh78nRb8MJLRBhjXl33HQOb8FkciADAAZpIVOtqWIB5vYm1J3JrFRmKoM5KjKfonhFfylKHDXHVcLg+lB6OwfOxgCLvf1Xu/xsCu+EcZApcONItYxRimBn0rYL1mWUhnmTD4gPkT06i93I3cGDhLXJabiRvZfGvssL5hiuk1qUVAmr/E/GrkKewcffOlliAzTY94SAeDlsb/da5CY3GqcMNFnroKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkGd6yJ5Q4yneURiDanrNYekBmyfQ6tZO3oIVk5Qiqc=;
 b=bTD0kgWbZDLiByGP+yhzqNW1k/wsPhrYhdwVtnpSXTBkrOKcj/ybKeqPjZeagIDvyrcLTDfDuS8q98XebNSW5+jVmkqkSfaToscRGTlbpkPFpu6QFhf+5VZdSuqODMcc3iOK7UIjeAJCuTCDhPhRloH8mccBOHS6g2TbQ4eD0wsE7cIihgMW7T+K5XTAUKZNkai5Op/hW7Dzx8IgW4/Xw0vk7FkuILwwnagJpdRxH0WhlhKQz6fjiH/2lj/eADwQSiI6SIpGRvGMQsz0L8yo0l0y1RxxZxLIwcmrdd0KDkfnAmHSi4L4c0qQUQ66WSMgpBvRUCIx40sEk7O9UOsiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkGd6yJ5Q4yneURiDanrNYekBmyfQ6tZO3oIVk5Qiqc=;
 b=ikVUArPOIsERepDLTdMlKtjAQO9Wy3vuhTvsl711/MOgsy79GRSfsixWykmEEd5veRw+6tiaGBgWtqCHNqiqQXVo8P3YUDbX0ZqUa7nWZfVW8IW0lziEMWn0EJvCdbFFseMHmP5vclOWbHNA9JQ8Vh/WZiEPSfWx7yiZcGH1vUlNS2Rt09KVAlSfRfEYHoM8bJs49G/SPG9Z5NiMiPth/mDBJBcSEEfnqTJDaeueu6uObGJznZ+/pwQqVSZxEJlA2JplvJo2BTZsfdfR5Rf9aE33hOhcKbNZ/hoCPpoGpgKsqfSlX8a3ZMX+8I6feRyNVWUu8c41WloBqQs1gfcWwA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9251.namprd02.prod.outlook.com (2603:10b6:930:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 14:34:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE
 to class props
Date: Thu, 27 Aug 2026 15:33:32 +0100
Message-ID: <20260827143404.1393166-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:806:6f::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: eddcc968-c954-4571-3b91-08df04485613
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yQF+/9Wc1x2dIL814WkVcAyzpZAGEsIi/6Ssp916b+z/4dIZ48m1UpJNkBeiZNRK1OIKQq34F/H/yEWSyAYN209xo5y8RNIH9l7Nlo3N/OgDEMqincAJ+pPjgR7nqi+ynYiutpd4agmLz3ZejrxgjruvPGCo6KXmKAvHC5rF/qeiB5X1178l1WIhrSAqyz3XRElNXm4iLCFEZ8BgL/q+KaCNr0JQCQVF9YkX214y97XwVuZizvpifxwhUPVJny03DLjmGRboH4oey7G5gUxrpSSvEHwkWUaekwr35SRrTsaFs+y5KJMJii1ZzKk3wd4J6hsC97Bw6bq6FzFxUGxnFmhzccxltdJYtwYHSZT9RqcV3f+Yb9Rlz251lKEZ+mU5PiZYNjLk8XBcuw4CQKxKV/QvAYnLfnEfhsSn6xswzQsuB0vCVTZPBuYNdn0LLz4ly3cztf0ErZpaFXdhVGIFYywiYa0UA2tK1e6noj+tBtPFfFDN39y0xsW1SNMMywtcIxMIVLllP7nfJ3GZagc6D1GrT4TwMYdn4k3Unz52PM9GIqjfV67Y/rk4g4AjMpRKF8RONWYSGxYSWXgTASPYSy7yxtQ0Fua3X8PEimSPlww5a//hlzNo+gqW2V/R0p/K7hzX2JsWCEEF5hVXPYZgSOrLa+bsLdizJbI4m+/UKVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnJoQTlPMkR6dmc0YTFIWjhFdlRLUnJPb2FRMEgwQjYvNjRnaHVORlFuLzhD?=
 =?utf-8?B?dkQyeE0vNTUrTklrMHhXY1gyTEw4eTJqRE5zcDFKU3JxdW9ONVZCaHdZQnYx?=
 =?utf-8?B?TFpsdFlzdFE0cHN1R1lGRGJHM01Oelcyei9yaWp4RDErcVJrSkpBd3lTREVn?=
 =?utf-8?B?NW9SMUhTaUl5TDlCaVhYSlVTVHkwNWVZUFBWOUwrZENkUTkvdzFUb0xDMDRv?=
 =?utf-8?B?YjJjR0F6aVUwMHVkdmExV1J4dmhkOVlqdmlpM0tuQkpweTNpTGQwbUNyMkt4?=
 =?utf-8?B?M1psaEZEY0FnaERMa0taK2RGdEp3R1IyQlU4QkNrYzFXNmJvTkxFQXZrSU1n?=
 =?utf-8?B?a2RLaUU2NmhyUWtYSWdubHM2azlQdlRQVTdMSmx1S1VGb08yL2FhZW9PTzB1?=
 =?utf-8?B?S0VSK2ZxejFtTU9rVU9HSzhoQkNWTU5aOTd6OGt4NmdZeEJRM1haYmhqcjVE?=
 =?utf-8?B?bG9HdG5NTUlWMENVTDVBYVB6U0o5N283WnNhdWp1cENWM2lSNmVTa3V4SnpM?=
 =?utf-8?B?UU1TMXljNnVFTHhhWDh1cDlJV1V0QWNrYlhZN2NzdU4ybjdXR2NVZXhsNXNa?=
 =?utf-8?B?YVprclJCV2VwT3NWMGFseW5WaWpUQ055WjYxOGhrRC9EMG9BVDRTQWdIQ3U5?=
 =?utf-8?B?NkROQysxYnFwRDZOZGxRQWxVN2NOUy9ldFhpTjJZQ1ZMUU9yeW5TSktsYTNN?=
 =?utf-8?B?MzdMa1ovRkQ2RVErRzZaT2VpWHh5OGV5aFdsZENrZHpZV2pQUS9ZUXZiM2tn?=
 =?utf-8?B?eG9JZnZTQWN6SklJTXZHU2J4bkU2RDB3cElCREdFSHRKbmQ0WG1kdVIzTS8y?=
 =?utf-8?B?OVhIck4wYmhiYVdSeVhFUWZEM2Y4RXBEc2liVGtvUUx4NGtLUHZlZkl4NmZN?=
 =?utf-8?B?VENXUFcvRERZVmM4YnQ2aEhyTS9wTW5IV2J4MTNabm1QWHN3bmJDTXFOdHQ2?=
 =?utf-8?B?VEZkbGU2V1QxdUlnR25XdEtNREIrdEl0UE1UTVM1azlTbnFRVU9FVno0eDlJ?=
 =?utf-8?B?WTFhcHZMRTFUTTdFMmdHSzJpZWFEZVcwcjJTKzFFVE4wRGdIRE1ZU0EyNGZy?=
 =?utf-8?B?bTB3UEhPdmxyaTRSWnkrcU1xUFhtRTJFSUxTMS81STI0ZlVFYjcxbE5Qd1Ex?=
 =?utf-8?B?Sy8xU0k0UGxIWUE3NHA0b3EvT0hlUzJPSXh2bnkybmhDWDY1S1N5KzFldkFC?=
 =?utf-8?B?N3Jyb011ZTVNa1ZVNU5CSmY0MXJVT0V0M3kxUDhMMG1jeUxmbVQ5R0tXVjUv?=
 =?utf-8?B?MXNPSjN6ZUR2K0pydEpQWkw5RjBKb3Eraityc3dXdW4wTkVFc1U3VjBWT2R0?=
 =?utf-8?B?cDZYNlQzdU9xVmtnRXYydE52OEZQTjlIbG1HeVM1WCtYenNSOHl6TDR6QTJS?=
 =?utf-8?B?dEhkL05PVlRYNHFyMmFXcFhHMEJsT2dIRW43T0t2S2UxczUxMkVYMWdlK0Ft?=
 =?utf-8?B?TDV1N0V0VjJtd2M4QTQvUktLOXplZnhqNldjNHN5d1B4a2lyK0VIZnJ4Vk5W?=
 =?utf-8?B?L21wZTlZYnU2N0Z5QUVNZWZZMExQUlo1eGlJU1Y3OHNsU3VPWmZoa3dpZXY5?=
 =?utf-8?B?bWtWYXJKU2l0QTZ1YUk0RDhEN1RseDdKZ0g4N2dTb2F6T3lyUE1walVDNnJW?=
 =?utf-8?B?Nm9QbGRKZEpMbGVzUkU0SjViQXJua0RlbGRYelJHYUhKUFMvZThnVEVtRGxv?=
 =?utf-8?B?b1ZLcXc3WGx5WW5LcHFqMVZMU05jMjVHVXk3TzFDbVFXR3drb2pML2hWcXhv?=
 =?utf-8?B?QStLdmFrS0xpTXBvam40d0M0VldiS0VkbmQ5b2V2Rll1SjM1SzY2VnY2dTlX?=
 =?utf-8?B?ZWhQbDR5Y0cwTkJtZnNlTEtOWjcxOGdSZ3BnWmhaM0NCeTZ6YXRqdWMzcE1C?=
 =?utf-8?B?SkpuNGc3Z3RRQnk5Q0F3M3o0ZGRUcDNHbmoxUGx2S1Bva0ZjNWwrWTRQVlgx?=
 =?utf-8?B?K0xlK3NnUXE0VlhyMzkvL0h0TlMzM21IenpBZlVGQ01NR1ZaSGlYWWpZVWVn?=
 =?utf-8?B?THp5WFhubUM4NVh6SlNmVkxGbU9EN0RnYmVxTGV4UkJnZEx1UjZ4QVhodUNw?=
 =?utf-8?B?Vjg0STh1a2ZiR0RGSnZ3Q3pSU3V3WTRMMk10VnYzbENBaG5ZdDFUTFVsN29a?=
 =?utf-8?B?dFBWY0hLRFFoZEJYK0N3a1FBUXlHWm4weTE5blV0M29PV2pvekViM0oxbjdn?=
 =?utf-8?B?YUh2aUtBcUwwc0libzFoZXl6R1d0clZyYWFTODJidk84U3RFZ3hzMStQU1ht?=
 =?utf-8?B?aWxDKzFBZEs5Qm5wRzV0QjRrYklqNXJsZlpnejJZeWMrNTJvRGR0UnVtNUVU?=
 =?utf-8?B?Q2lIcnVTbkFxR1NEY2VON2Z1L2NJczJpNk54NFpBTVBvaDNHT1lSb2p6Zzlv?=
 =?utf-8?Q?iTVmaHsadaqH91MA=3D?=
X-Exchange-RoutingPolicyChecked: 1CPhAinf5Hiag+nSyrtA60r8eXv8UknO0fK7V7z/zhfy1wTp0hZR1L7GhSCof1X3WmPXB5eQTSzPP5KNEK/GbfZtEZjBwLH3MYxGqb+NjpH8XrS9jHEuobYHXi+CHy0wYl20lN0Y5Zs1tmcskZ/SnA2vNbhXf/CsATzPvl9mgfYCNgadzES6oCz9ti5YG504U8KWtyp/gDOIi2JV57pB+HmYXPcwTP3pjMkXgWHbvL3qNLGLohS3n6CtRq0uZJ1T9iHCegPcLfM00J2XK2CIQVxG+jMfUfeVEq91biwVaQMjKWw1pUFJApDRgQrbwVsi/8NaQ2NJaz4p6llEjFJO2g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddcc968-c954-4571-3b91-08df04485613
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:43.9413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHeVwT/bSBskC/HESZ1Q31F7vd0bozGlMnFlx4bn6o7IaRN31nmrP4mrbbaU0WURaVS5trgX7N0UIdPQKMNiI4V/3R1DGwOPZbS/TcACXGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9251
X-Authority-Analysis: v=2.4 cv=GagnWwXL c=1 sm=1 tr=0 ts=6a904b09 cx=c_pps
 a=8OTw2qS5QgwVLUZ+0dTndg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=GxT0t2d6BVzUPgZ-n0MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX/xPiPv96znRL
 xF0nfAr0Mis0uQ9LdH+4P+SjEyLPw5KKVJvoGq4ZuTHswJ+7ji879AeuSUALUngn9rkB0H/MIdn
 WM8vRKYmqIWQmjSCbENS7q8RHtbqhS0=
X-Proofpoint-ORIG-GUID: HvJywa40pn0Nq4YWWdpFrRx5AztjSBwH
X-Proofpoint-GUID: HvJywa40pn0Nq4YWWdpFrRx5AztjSBwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXxvdaSjmiOcC+
 KT1LAQnZNpOjx1JSzd4IG16YIeCvK80GWil8lNz7nL6nnnd3uP8OnKcHVnjA9K1F1XBo0iaQEE0
 C/H8v4Osr4eD6RCCiOhsyErhcydP8eMkxrvYoNFfupWc209dw9eGCk0t468ExiJqe9y/8AcdhI0
 qzk0DKideTnfh4d90a88lCwl/P7kXEw2LTZRieEa1StEIenfTWrHrh8sps7e96XZuBCbbI/Aik5
 tqdxcqMCPG7UKp88l81MrcUo0dCHdS08yUmhHRuryBKUG7/VVRP98v2WRXid77h62FjbJwZQSno
 NSseJiGzE/XtcGwMkT0/ZfqTaQKjPAlm6oz79MPcO8P/FJIVOne2lBHRda13lfJo4hS+7VlM1Cy
 +zLPHerPxqPSUBTVVlJHz0loxAc8qae9M1MVSPvPK+CFI9AcvAXbHl3rEzDHhibf5aRwgmC/vj4
 O7/6eQsB1O0iLXd/nBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

ACPI_PM_PROP_TCO_ENABLED, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE and x-keep-pci-slot-hpc
properties can be converted to use object_class_property_add_bool_ptr(). Remove
the now unused ich9_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260825134320.1039012-12-mark.caveayland@nutanix.com>
---
 include/hw/acpi/ich9.h |   3 +-
 hw/acpi/ich9.c         | 102 ++++++++++++++---------------------------
 hw/isa/lpc_ich9.c      |   3 +-
 3 files changed, 36 insertions(+), 72 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 3fb993bb9e..6d14544751 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -83,8 +83,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
-void ich9_pm_add_class_properties(ObjectClass *oc);
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 774b34195f..d6df8db21f 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -349,46 +349,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    return s->pm.enable_tco;
-}
-
-static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    s->pm.enable_tco = value;
-}
-
-static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge;
-}
-
-static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge = value;
-}
-
-static bool ich9_pm_get_keep_pci_slot_hpc(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.keep_pci_slot_hpc;
-}
-
-static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.keep_pci_slot_hpc = value;
-}
-
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
     pm->acpi_memory_hotplug.is_enabled = true;
@@ -400,35 +360,10 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
     pm->enable_tco = true;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
-{
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ);
-    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
-                             (Object **)&pm->acpi_pci_hotplug.root,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
-                        ich9_pm_get_gpe0_blk,
-                        NULL, NULL, NULL);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
-                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
-                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
-                             ich9_pm_get_enable_tco,
-                             ich9_pm_set_enable_tco);
-    object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
-                             ich9_pm_get_acpi_pci_hotplug,
-                             ich9_pm_set_acpi_pci_hotplug);
-    object_property_add_bool(obj, "x-keep-pci-slot-hpc",
-                             ich9_pm_get_keep_pci_slot_hpc,
-                             ich9_pm_set_keep_pci_slot_hpc);
-}
+#define PM_REG_FIELD(n) \
+    (pm_offset + offsetof(ICH9LPCPMRegs, n))
 
-void ich9_pm_add_class_properties(ObjectClass *oc)
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
@@ -436,8 +371,39 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_GPE0_BLK_LEN,
                                                 &gpe0_len,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
+                                         PM_REG_FIELD(pm_io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_link(oc, "bus",
+                                   TYPE_PCI_BUS,
+                                   PM_REG_FIELD(acpi_pci_hotplug.root),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
+                              ich9_pm_get_gpe0_blk,
+                              NULL, NULL, NULL);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
+                                        PM_REG_FIELD(disable_s3),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_DISABLED,
+                                        PM_REG_FIELD(disable_s4),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_VAL,
+                                        PM_REG_FIELD(s4_val),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_TCO_ENABLED,
+                                       PM_REG_FIELD(enable_tco),
+                                       OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                       PM_REG_FIELD(acpi_pci_hotplug.use_acpi_hotplug_bridge),
+                       OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
+                                       PM_REG_FIELD(keep_pci_slot_hpc),
+                                       OBJ_PROP_FLAG_READWRITE);
 }
 
+#undef PM_REG_FIELD
+
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index d3f1358887..b55b5136a3 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
                              IOAPIC_NUM_PINS);
 
     ich9_pm_reset_properties(&lpc->pm);
-    ich9_pm_add_properties(obj, &lpc->pm);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
@@ -920,7 +919,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
 
-    ich9_pm_add_class_properties(klass);
+    ich9_pm_add_class_properties(klass, offsetof(ICH9LPCState, pm));
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


