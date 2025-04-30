Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A42C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIN-0007pp-4s; Wed, 30 Apr 2025 15:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIB-0007kf-0b; Wed, 30 Apr 2025 15:40:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADI8-0006AC-9B; Wed, 30 Apr 2025 15:40:25 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJ5kk4022290;
 Wed, 30 Apr 2025 12:40:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=f4C2RMe5Hvw4SKlnQsjx4UtmiBGPZo9d+IGw3JrDY
 hE=; b=urPYSaQFbgx7CNFQYJSzr3c8NIp+r/nvy4oswYcWngTsiTHFi9RvargaF
 hgswb+cCWiJkS19a5mSFXv9SfItYo0+TOVPcl8pomO+VkgDXHcjsGeOEIkuT4X/t
 5B+/kbE1smy/+dlsElMJ3xcwJpP1B8HZN4oTZvv5fvAgZuP65i341lPY/EDouDGL
 E+YtiVZiOCzFOgktC5+5GX2VnvdIB9/UYX8PXxeJELis3L/ZJp9EfSJ7kURbT7Eo
 Ybd8TllbO/x486Fbl59S1k5lupQxI5VvVFt2+RVdSkzt9sKkDxf1vwHcrUS+965h
 ucBBu+vDjc1qEbnRbX7UKL41n4USQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8huef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyUpCMhDGt4HZ8CHTdBWZS+FAlwXofz3HH5s77Xv9vzGm781/xQKTpl15hUlFNQVy62FQthj2Nt4tKW5Bffwh4ucqq77JJWUMiqZfyAm0dB309ZcMUKRLtGhyykk59cyEJNtLVnAOlOXLTrP7QGBb1mjN6BIOf8c8Z7ocgt/i6W961TR8A0sQe7rvFENTJKNvsGjbG+l7Xp40/Qtk1dogeg3PLqVN0iQJJghMOfGD7BVICANmMaTwb3h7t0fmpb5u4qEKmZ+SSEGPlHj/CgIt2h93o7Qcyc5aTEwaBqh9Yi8bXkK0zKL9DQPin+6uKjQPw3G9HpWDCtgiVOtWWhmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4C2RMe5Hvw4SKlnQsjx4UtmiBGPZo9d+IGw3JrDYhE=;
 b=VNgufZVOBiB5LOUkgX1Tom24QPNa2/TsBOy5GHc6eS4FFRnVMXWd0ZkUk/Jk/961S6Ow1qnx2GtzhNpIafD3PNu+FBQMHNqr+TDJ3QbJq1FXAO7CApGYIUpzJYpDw9PHWIyY34Rgsb0vW+bP339dEjRtphAijz0mkWfSY0j8zRd0ftLpt0+6Bd2ZxHJ08RpIUANdMLZy3s7sKEqfUHBTNgVbrxGx6DPzKixB+fgJsQy2eaG0PmhWHjnjSINgvs3w4vc95CroMYcKUCeBGxLLPbxxkUixh+LBTKhQ/lQrlFdox/LpMrnnIoRI3swghI/SccWmBwUAaEPHcvb9xjJm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4C2RMe5Hvw4SKlnQsjx4UtmiBGPZo9d+IGw3JrDYhE=;
 b=VuiIjHg1FUX193tFFFMLvCnAsbjbj3D8Et3EAs97+n5Ro34Hxpi4NLzVt6boCYGf93nxqWm9yZ1zMR/Yar4/GWqvwKobsgdHOQWiA21KXBi7tse87+ZkepmToGt4QGmOllUVBdOVddX5lxqWHlognyqq2bpyZJUytkHQlqrazERW48YuqdaJv/UisjTGnidAUpqFPakLJi2uSOboHT8UAovMbVajDQdibM81OxmkUSfZSbu14YpgrWIWNYNhIlXJeDf0OXSbDBslm1BH5VVJfsBLO7ss9COlD2m4nFVbkHGwoRi8Jo0noeWzO/G0L9iWtz43qwT2n5t2yn8oBzCHPw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV3PR02MB10054.namprd02.prod.outlook.com (2603:10b6:408:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.11; Wed, 30 Apr
 2025 19:40:16 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:16 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 02/15] vfio: add vfio_unprepare_device()
Date: Wed, 30 Apr 2025 20:39:50 +0100
Message-ID: <20250430194003.2793823-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV3PR02MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d55b22-fc86-4d27-475a-08dd881ed53b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qD1iTHRxQgjknu0h7VLLBavHGvlxYbT5hunCQGqlKARkg7P9c4vUUeEssAVh?=
 =?us-ascii?Q?RJ0wRwGOli/zxGWFS94M6rJzaaque5Yfsp8pFcW5kdQ8rghdtrr1Rgwff7Pm?=
 =?us-ascii?Q?rcfRGjmgrf5fZU9a7bP/RgR4TthYVvTiBpInKMlJsEYV2ziTrVL0yalwraqa?=
 =?us-ascii?Q?HRvvWxb/SbaU05ufJYedkH24eVuBKz4yulmXcAAXLgda85CkHekGVQROrpuR?=
 =?us-ascii?Q?RKytAs+qqGw9S/d/k0g6s6EyPam48Rz2ww7hAJvbrRrt2/PnJQS0L+vHfyxD?=
 =?us-ascii?Q?N/KiEPRifRGhD00GlG8DUnbBP3S7A15/ID6buzu5RIQuBzsLOhcpowdGd2L7?=
 =?us-ascii?Q?mzHvJja3DHx7uLq65t3SarGOUF+7cdifo8fv0vdh/AcR86hHKxU5pWlaGE07?=
 =?us-ascii?Q?t6/LSaEdGAkNCkVNOWzKAWn/teEkSwYk2CKx4n4BpNekTnZ+UtA9lY9g7F3x?=
 =?us-ascii?Q?dML05Gqwyup1nO7UgPmyTxlaxpg27/9ce9HRZqV6xV/K8oYvnjeV/WVh0okU?=
 =?us-ascii?Q?BTVnS28r8GdlTI/UhswM3XrYnGNGPGkrSIWLfA66jnqU2kQbOxwc4ssT4Gd2?=
 =?us-ascii?Q?8w8e6rAYZcsVVLmNPWC9of9w7xJQD6400MCaruYrg0DPSSMctvX2guMqoRqQ?=
 =?us-ascii?Q?RG/d8/KcilE/NvoMk5AKfN39kuklqpuONLNYO4jxMgkoMb8h/ms5VYmsExUT?=
 =?us-ascii?Q?vfAYk19BOsAHJt1O/wUCLx+OeAjnn5hm5C4c2hQKaejkVZaYbt26OIet33+R?=
 =?us-ascii?Q?KXIq2yOxMDyxSuB67lCa1xC9N/EzsWMMevja2kg6aHBRyBb2jTZacOiPAgX1?=
 =?us-ascii?Q?ZgdMGwF9KjBDIW10YGnu9rThwLC2gP2pwWsEl0st/ge7O/3oskU6IZtMHr1B?=
 =?us-ascii?Q?X2wxL84krlW4lv05tPmGQwP0mnGVbrlPcU6AdEaVfVWpp1ot2VWd4jEOKFQm?=
 =?us-ascii?Q?nozUbWLARQ26dFER+kzVDCLxFiLy/1NP0y0ZMYbHYINdPksPZTiDqZkgs1gq?=
 =?us-ascii?Q?IEpiQBzoBHfZidqt/3AJN1INQ47T3DOgFyG/OoHcrIogTTX61Uw7oX3VKfFN?=
 =?us-ascii?Q?ER0ZDOzxpwFW8gXP7SruwFLqWf79g/swYG2bFJQIliLMNnG1onL8tMYJ6yBn?=
 =?us-ascii?Q?iJd8dD5btAOyrU1SYbkgUW2mPyzb6gkLwadc5MHx+svN8V8pbCWNMk0u5xzw?=
 =?us-ascii?Q?jKt3SyQ3o7RcJbXTRY6mcPcod+cf0cpJaUTzQZppXVw+DQsp2d+6E/Imnjeg?=
 =?us-ascii?Q?4U1fz+XJ0ElYkvEeI8lYtZaiHeZzOc9nsdmFFsOsYd/MRQg2FEX60i2oqdpe?=
 =?us-ascii?Q?YM/YdlZ/XnURnX2NubmT4KH3FNYPMlrC3aV3NIcdwnmgaSRN/GXRNygN8yDj?=
 =?us-ascii?Q?ez8mpSJLDowm86RJL52X0BSFA3Y5e/lI6+1Ha/47wsx535/0+nVUZSgPtog0?=
 =?us-ascii?Q?tdaucexcWkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wlf0D8lifopZICkb4HPJU97gTF6/LejY7+Gd4boN/jh293qPSsBsCrxl3I0?=
 =?us-ascii?Q?8q/MVDdei96vjtKHbfHDT9frfSCnRGtWqnWl1ZLckirjEa11+KRw4dVyera9?=
 =?us-ascii?Q?wZ6eGA8seVRJod3MKeMxX4IGlHWcnrG3EntjU20gu7NSc13QLl7HoGk/dbzj?=
 =?us-ascii?Q?zdb0q63GpdKouljo2mOiWb73v9VbadGRBY8xvaD0O5XhaV9o75PMhTQnIRww?=
 =?us-ascii?Q?hBMjvbWK+ToWP9Gj8HZAqCQT+b53swM1fM2YFWIBZITaGYk1cFTShpMcEjP5?=
 =?us-ascii?Q?Vwedkssl1G1vEemJWB+jM+EOuA3V3PqHmqH8VATfYRLXoCk2DkQT540XgoZC?=
 =?us-ascii?Q?Y0PUfumu/52SmM3KCdqrkqZ3mMarV4O7P4Fk1GYe1jytcOEL/YHlfO5W/jYK?=
 =?us-ascii?Q?6q+1j1g15Zuo0caT6OgtZSX3rQLA59UyROwB7kLewo2hnMJtHNgilQKxLRnd?=
 =?us-ascii?Q?ewg1irXSJwyS/j/7bYqx6PHh/VnwTQYYI35+8QvC0f3Hi3TCE05iCmGZKIu9?=
 =?us-ascii?Q?omyP8adlnOpjdtM5Xjd8QC4As9hEmgn4z9fviGsW3XiYpl1515ArqjZWHRko?=
 =?us-ascii?Q?BjNlg/rTcOwscgfr0svwFNDN3yros6jGCdvR9c+pXb9SXrdNAW1m6Eek4XP8?=
 =?us-ascii?Q?C/2eR+2Oz4sWhe92GqF3qwwd9drw0qrn/NwvFdxZyb7ntOIEjdB/eOLcQbp9?=
 =?us-ascii?Q?0nP+TcREzz4X5pcsNz3u3Px8p5us8vxUmagVZeVw2NEUgQprynbZg2qvzkbw?=
 =?us-ascii?Q?mricDZTksWP4fYQNKheFshSS+noUYP4sOXcq8vT4n+2oAGEG8qS9u5tO61oy?=
 =?us-ascii?Q?2vxSi8zzP5ZTscGYXY0nL/cMV80hzRlPK6j58YDZjm8IH0qIb6yNODEzrlCL?=
 =?us-ascii?Q?qhvO1h7zOK8hDiqakyziXWvu5RIIgD1I/rxpeTH6c0kdx62dM0CS14/3lBAv?=
 =?us-ascii?Q?TBOUAeMpavdJb4aCg5kJFoGg6z9uP1ETXW+J2x1s0tU3adOgz44ey69ZxYmW?=
 =?us-ascii?Q?FzwmtLNiLI1irYvsPOvLXk+ttF9Z6gyZ54qFtxPpZMpj6FZJqX4e6fWJIfR0?=
 =?us-ascii?Q?IR7ilLQV2N6CVyMhljA/y9Iv0cokRMyg50ZOGLUFLTUjWL4n+SxRlf6l0XwQ?=
 =?us-ascii?Q?AhKpzo+X4j+a9LVl2i0D5oEEYLIs5PsF7pzHt3yU5fTsUUrF6oqZP5sXKPzR?=
 =?us-ascii?Q?10CSZ2ynaCH8/o2gs1QGNZF93cRX3dKr7Mx1AE2E0GxuHQtEGrR/rDlKNH7P?=
 =?us-ascii?Q?SDQ8SdwnhMMiMqFcgfEyBgz3m27c9LTR3YvWT3gfqSrp+0beJvLYAg30ZEqj?=
 =?us-ascii?Q?ZuECdB7w0G1uthTtQoPnp3Ui5lTHTKQLHYcytlhxObjswCuer6LT0dGTRAX5?=
 =?us-ascii?Q?lsAnsYfCx7RlpAvHhg/wmSeCybEWhUI801RSPZZ6185oU1+uxkCa7igx5n6z?=
 =?us-ascii?Q?thimTIAUnaoyFGKamIygk+LgU5bIWRi1uuchYvkiMQqUYRhFqK0EurnfkiE+?=
 =?us-ascii?Q?6945maaE2xq3F7RkxegAugavUVgKjG+oTX7qFnKP4EvZ2NLpSEFKUuIVH8CP?=
 =?us-ascii?Q?GeRX/q+G0bP5h1pigcb7ExdJGPokpvJwT2u2goDh?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d55b22-fc86-4d27-475a-08dd881ed53b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:16.6319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54s84FOXZDJjtow1G2gCPZyGUJYbI5RvJ3sQZGVpnd5fsOj83P+rhfJr8bzTZ+DM1yr0ByaDF4Sfm0y4QuznNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10054
X-Proofpoint-GUID: mN-6CiFRCze3rCQ0Yhq3US7xIZj7AQga
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=68127ca2 cx=c_pps
 a=vIBLTX18KUGM0ea88UIWow==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=C_v9gYMq6tuos7APg4EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfXwO6NOM23QRov
 Q7sUyOWqJ4jcz6cTPxLPTfFBqaGFhfRDiVAdRiZSNAOYMUZwkgTqmpon1qFZqJvXHJsL/5CwDi2
 G7t0FSI53kZoK1am8IzBqL4AMXwAeaGMTPuGu+5aw781N7z4kP6yUW8xKARbIXU8BXr9Ode2EYs
 1/6H9qsTcS+r0wErhJ5Qn/s5yLnXXhYJHnVVVW4zMpX+FxV1jY3LUbFF5QvwRdIZyBZewIDDo5q
 bii0EA0qYTm484hlE/r7riio9VVFIUDpF9p2Vx7H+Q2Z9ZE4Nt4LMZun61emWWcN/mI+1+BqIYC
 wIIIzOVyylWAiLwqw/Cx4UP8R0x3UA5/6kbOSbrQ2qa8gDUdj2ZIrhBQPkBAEFT+VuSZyyQasmh
 EAWG+FyFsIozSctpCH4WhZXg4RYmAdzoqVxlIWAXHfb1iw3gr1INjKuM0wm46CCTEb/6L+F9
X-Proofpoint-ORIG-GUID: mN-6CiFRCze3rCQ0Yhq3US7xIZj7AQga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Add a helper that's the inverse of vfio_prepare_device().

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c           | 6 +++---
 hw/vfio/device.c              | 7 +++++++
 hw/vfio/iommufd.c             | 4 +---
 include/hw/vfio/vfio-device.h | 1 +
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index aa9d5b731b..1dfdc312bd 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -912,10 +912,10 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
-    QLIST_REMOVE(vbasedev, global_next);
-    QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->bcontainer = NULL;
     trace_vfio_device_detach(vbasedev->name, group->groupid);
+
+    vfio_device_unprepare(vbasedev);
+
     object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index f3b9902d21..31c441a3df 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -412,3 +412,10 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 }
+
+void vfio_device_unprepare(VFIODevice *vbasedev)
+{
+    QLIST_REMOVE(vbasedev, container_next);
+    QLIST_REMOVE(vbasedev, global_next);
+    vbasedev->bcontainer = NULL;
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 83033c352a..62ecb758f1 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -615,9 +615,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     VFIOIOMMUFDContainer *container = container_of(bcontainer,
                                                    VFIOIOMMUFDContainer,
                                                    bcontainer);
-    QLIST_REMOVE(vbasedev, global_next);
-    QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->bcontainer = NULL;
+    vfio_device_unprepare(vbasedev);
 
     if (!vbasedev->ram_block_discard_allowed) {
         iommufd_cdev_ram_block_discard_disable(false);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 9cb5671ab5..6d2a112734 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -132,6 +132,7 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info);
+void vfio_device_unprepare(VFIODevice *vbasedev);
 
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
-- 
2.43.0


