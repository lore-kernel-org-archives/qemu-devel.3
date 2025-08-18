Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBEACA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 11:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unxgk-0008Rb-Dj; Mon, 18 Aug 2025 07:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxge-0008Q1-UE
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:06:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxga-0001Px-L0
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:06:00 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57IASZuH334811; Mon, 18 Aug 2025 04:05:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=n/gIgXK1uivQMg1Yf/R3taOx4d+4xYandkIg1fsRk
 Uk=; b=PYt4paWZ+SJ45UaGSB2g+3DuzPgw9W2G1Il45Lvwn8PnaWuVYWyXiYBdH
 x2LNOB3K0fvja9Fz3UDcFoEkpKzLaYXB4eoY+pHKN3rXbY9tN0535tHKgaJHc3Wr
 wRrWXw0sOueQnJwFFEvWi0H78M9HWtAC9pIPUK6fBFksaI4tYqIb6PdduDUEpxSz
 0iYmpCvk3DNrGbwhQqsZG0z8LcsYBqFByCecSPvmZCAcQ4B3okEhugpV3StgGHc7
 SvWO2K5+gGnyxesoB6rYDijBXajixrDvFqhfxXhfzRxO8dNyfQAnZWJWZ0A0BiBo
 NL3xhCOnJl6OzrKuowSt81MM4SYYA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48jsabtwd2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 04:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6p0bNb0bi3xIx1xZBUjnuNQ/txJQThS/lEkqLNuj8nLm59VfqFlo7yFjySQ2odr7pSzK8XX8F3XT1dCy4p5bB5qzdU/XbEROvgW0lB508GhvKeLJlhUJSS3mBPWzjLfhNY8lRpXio5/apE6R1XJwtgrZ4Y9o6S3Qa+97kgKLGLaEOpdXlvxjTkyJsjrRzm/Blaxp30cb3P+gy6rmMY4fWV5amaqk+ru8twabmqjLsr1rX2fb35R0waR6hjc+QzgMf/M+vin/AMNQMupn1s/U5jrgc4Rnt0sjBkOGxpJDTewCvgy9Ab0jfjzX4+pjBx6F3lPuV9/59NxiMKdp7Bp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/gIgXK1uivQMg1Yf/R3taOx4d+4xYandkIg1fsRkUk=;
 b=sSTWEyo9+WPG7+6SiioiQTcMO2EmEz8vpGk9Ywg57aYZZog61zW9RUAQi5xbqqzo/XJ2tQqe5V9CjHKuOhGWRe6/5b40ZSAUN3zl6tDVV6C/dP9699nSyje2TSNM3BKSJN7NLLWFzJQMB3KE/T1ZF8Fm9CeS4yKE7tGgsCzxiSScijapsb+IxRwgsH/1+GDOrSfkhn8qXnZVeOuwhVnRGDfE2CKB2cAS6eEFcDy4kVRwmkyjmOXSrBBMdh5NJg/yz6EaKD8nYa8+q31MmtQhGKQ/jsLJCcZ+43yB01fqRqQwMJ+YHyFV+4jrkCMf7RW5Kiz3zj5g2VmQPNTOD6OTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/gIgXK1uivQMg1Yf/R3taOx4d+4xYandkIg1fsRkUk=;
 b=DCAJA2vZNO9rNB9FL0SGZ1xjVUjfxawYAA40GPBRyktQNnEE21DunFGQB0KXyJRB0uKsSB9GdMYFPuWT1GqyMs7bYVXrXfI4XItMllnU89ptIQXaZ/m7dGn+JMg2KU7LSWeDN1xkYypzNDSeZZna7cn4qknP3ZRsAIO1wQIdpnUpNKyF4bSNTI9WT6WLwIVbSfOXXLeAaGRX5VbVBkZ5DaClR50t4/cPlZECAzD0MsXSaS/gA2Y9hgP/hYSxiIhK628ErSxVnRHxRPA+LSIbccpq5hR9Mu7Yxlf0IJpMkiRJW7L699yzat1yYfGRGp4j2zbb/LjsIGDQkunHTRkXtw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MN2PR02MB6814.namprd02.prod.outlook.com (2603:10b6:208:199::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:05:53 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:05:52 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] tests/functional: add vm param to console routines
Date: Mon, 18 Aug 2025 12:05:45 +0100
Message-ID: <20250818110546.2159622-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818110546.2159622-1-john.levon@nutanix.com>
References: <20250818110546.2159622-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MN2PR02MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2400623b-444b-44df-ac9d-08ddde47327d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vSfkDSaCabXwTv5Nwav0ALNsmqYAU7XdZv5sTbhN/rpDbXlpDlPGwm/RoYKF?=
 =?us-ascii?Q?OyFATXTmXSiBAPxdoX9njpcPHIZYOaLYQbjdXZA/gcC5XNGXba3RcPw9cKdJ?=
 =?us-ascii?Q?xbvbGs3Qk/wIvelwuosEJp+Vj+mCzVN5eEBUhuGCMyjJLbvAW43bLW4kHjnE?=
 =?us-ascii?Q?O53WuPgvcwlSKO2qfx2PcLr2pYFNlD8uJeNdDOyviSXJM2FA6ShbZb+A69DY?=
 =?us-ascii?Q?SEDyQG6a/MvEGXI6L9iy4WLYcVvVSSLMGRB6EEI/Ho8N9PSoW3YAysR+ajca?=
 =?us-ascii?Q?zFJdUjp48YxhyNSGxxbUT3zCrnIm75WxD1Gkt0rSzypl5Wj6bASXDCaaZ+0W?=
 =?us-ascii?Q?MBhiOaybwCGeUwP0wPb/sUnz1XIhK26wtkWHz9i2DlKQJwUBUgHziFrNknsO?=
 =?us-ascii?Q?+pd1uufLcsbLPNXPxHfIwzCH4DV5y6AT+yvAa6MrrEG8qHK8YlqVmaM4wQ0b?=
 =?us-ascii?Q?IdVZqqf6db7xa0yeFyMLUowcJuQNiFl+ZJgbHF3Mi4/DdUYlnWQJ2iQbxAPU?=
 =?us-ascii?Q?lT/g3qnbjMgcXkNSNyImV5ES2Dox4gnc7g1PvvZiNhNN/fEAD9lGo+MJZQq0?=
 =?us-ascii?Q?e471j8NMoDp6lWcWaMcGpRWRvco5qVatcVDvskH1iSHZKKnKlZhzfstTPSR8?=
 =?us-ascii?Q?fmGFTUrMhVnX8ZiJPIBYoUWxQZLiKsPQT4XhXxwjEVkzkIs+hS6atXYa2omX?=
 =?us-ascii?Q?BfucoiNT6iGlgcwZJhm928vXz/Z5GHFbL60w5ATNOLXEIGBg0ybEVyNoKVls?=
 =?us-ascii?Q?9Q6UMaTddTZJUHiXnlFST3eYiPk/6ccq62jwzTFTKtoVnKQWQ4M7TcTuV4PY?=
 =?us-ascii?Q?Z6KW8+g3izZrGWOfbTgxuO/I0vrhmA0zZlpGhu5mUuiNA41BaiabRR/6J2Da?=
 =?us-ascii?Q?XhTkgPx3nIUcLPC/USUfUv3vdHRCW7Us5OfkoLGeuFjSiZQ806b50X5XSjTz?=
 =?us-ascii?Q?ZDDFLkJKC+zfNG2m2fX8cN/oqfSwpf5WRvCo2OCB+a0OzXA+2ckuodlRkPFE?=
 =?us-ascii?Q?TEhr8QFvyhRxsXNT1Z42O9/kK5oilFfavbhXOQ67+Z/om7oR/7NlF90eqSQv?=
 =?us-ascii?Q?+KhE1UjPffzLi3Djo9qN/aF7s4icaoQ2S3iKPgjV7LlwPLYc1zEzAPU7rDQI?=
 =?us-ascii?Q?o6ZWD5ol9O2YMHDAMl7sVUa/zocg47f0x0Ky47+fSUiqgiGeiSO5uOjLSOmn?=
 =?us-ascii?Q?m7E2G9pH5VNPcWJ48oHGg4ZAIUN6rG+UdCLKGiHpmbHeNlDH4XOMuketB/Bp?=
 =?us-ascii?Q?Uc63D4BD66dtra7h4Y0IhhBGBImYx4F0LreBnsXKgzA3O8IKYC0SErnXvnhZ?=
 =?us-ascii?Q?3X3+81L4rYtCioSQpu095SzJrlMl9z8iYUZG65sgoQqUrzg5k9VfXuPBQkj/?=
 =?us-ascii?Q?C8FGZfbV6CBfaOt8LHTAF0wtAZ3dt/BYqEmgb9M+2cRwj1YPhHVdwXewAswH?=
 =?us-ascii?Q?has6tJi7FEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uy7zbusYgnFp3OKtfq5T9EzI0zWf56XgxxXOr/aHDeiQ7U37cd2GpjDng2jY?=
 =?us-ascii?Q?7RjfldraCP2uUCl/daK6x/RfJxth/klUpnEdHy+/0daP18KlWT529BRQEH8I?=
 =?us-ascii?Q?EJUI/JIFg8Qq+hRtWBmEwWsefh85LxmMuKauJ0LLbqYi0CKHyTmF1cun4GYV?=
 =?us-ascii?Q?uttsib7ZS4nK41aHnGjoQWurmbWoDBaCm6qdM0b/gnxQPdyACmi7DkEciVNu?=
 =?us-ascii?Q?MqA1rinXUu/buJcGFkWRliyxUCenPPhVtFpWeV0FayKyF20ZuFFaDumcP3kT?=
 =?us-ascii?Q?L1XdwTGTToyL16jqUSjOpMGIOqSyFkK2MRDF7q3fcfI0B2LjNyplikzizoaB?=
 =?us-ascii?Q?YxOAzX6H+HXABz3TVh6f1ovW6DULC+ViHzHUOZdGEGTD3vLn1CX4zkpnWZh9?=
 =?us-ascii?Q?X/z7xcR9zBO+B54UyUZAjNrUtswq9lRW7AXxzugIItqVkeUfrTkvfD2aoXWP?=
 =?us-ascii?Q?jybL7zYT8QDY/qkRVhaFSaWt0wCiaBtAw7RNzvN6KAuxaKwJCD1bM+o7ErNC?=
 =?us-ascii?Q?1VZHWcY3kJCrOZ/tkAYS1QS96viVYdjZ5ZmtVvrCeurEATAiK/dGrhi6eBDY?=
 =?us-ascii?Q?NZ8bLOxBY1O3HUU42+Stta1cq/codq/0VGaRNoxcrKgx43ZcL9flkvobGQpB?=
 =?us-ascii?Q?kv7oRuee/tJFsPs13CcA9NBZbIIayGOrKeRUZDs/e3eFP/U475rdaqzCUqTE?=
 =?us-ascii?Q?xKLTnge/E5UM79io7UpJgvHH/mY6tm7m4bcsMIyLKcz7FHdhNRu+wPNItkMx?=
 =?us-ascii?Q?RUXhbwtSlaUbAOj9B8uJfVcqj06+tVBjKKg+TSwa8ZXfsvOCHFaMthceZxIk?=
 =?us-ascii?Q?o6XXkax3IUKBH1Dj1CpVCK9yV+JTW6KteVl6HEGCBmphlP2K6RU6NuQwyvxh?=
 =?us-ascii?Q?B6I2SAxklIz2dc7t8+OEX8boIwhTu39z3dchECPuUDKr28N9F5w3aTtYL5gB?=
 =?us-ascii?Q?Mkd1/92ytVjCv7Lwv7kNZLkBcJlrlvxCxNgMSlTLnnb4VRTaFGmJpIO/9ZC3?=
 =?us-ascii?Q?RKsuMe3R8UpaedeQiqmK2RceOToF07YUu/+TURBgz7I37gzPiM6E5xUNtk6P?=
 =?us-ascii?Q?qdgypdiEEBRa8HQYdt27SPrCKYUTk6lcDtJMWjsPxAE97/HGTngZXetJFLC2?=
 =?us-ascii?Q?LQjlB0n/3MPzZ92zvlcYxMGavw1Tdn1b3a9MFc5UT33NvtGXAhHhxzNCYbhF?=
 =?us-ascii?Q?3V1n+GCI9qx3G+4H816jTplOCxXqSCb1kQRheZtEQmjJTbgYBEiXtNwAJEji?=
 =?us-ascii?Q?K80lnnIxUC1Co8UP3Jzd6lISPUaEURVBgMaLbewBfEqxBpxPrqJkxyGrdkqx?=
 =?us-ascii?Q?34cRJM8PzvhLzU6cgAICANdlyMPFHeqJQvWn1Umsx4+vVN0JI8ibFhzCCLKB?=
 =?us-ascii?Q?qpWDVBkHKT6bVeOGge9ekXw3N3jBJeTO6Fz2KwMexymnUpqESj9aWdJGXWLK?=
 =?us-ascii?Q?/05+BlqBJoC7OPsoiO11+5/ZUH0vKkzCJpjKQL2D83mS4zTSiJGq0panUUhg?=
 =?us-ascii?Q?69y5YVhJyi4INUxr7jEEtvFoqHnyQnP8kB9wcQWe2YKKpOf+uJKwUvIuqpOR?=
 =?us-ascii?Q?uR4GQURM5uDhL+FJlLYQ+wpc5IUJnAM833+nTC09?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2400623b-444b-44df-ac9d-08ddde47327d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:05:52.8910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ocYQS8JJmdjp9YbFcio3uhUz4VS3Woek64jG0xNbGRF7oa1ez4GD0xJq/35//UNAHRA6Yv0nCmq3DJrwcoMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6814
X-Authority-Analysis: v=2.4 cv=BIizrEQG c=1 sm=1 tr=0 ts=68a30912 cx=c_pps
 a=mNDmJ1XC7hJeB1Yk8AIX0A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=boAznzkDS1D7gNr825kA:9
X-Proofpoint-GUID: _S5c1vk_6SxW7wbCdIHlEvQA8e9wkb9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEwNiBTYWx0ZWRfXxKeeEJKuX3Qs
 Iw4jZ1LRYa0OViVXE4iZE2B7gLUmzwbPxR+LqwAeamy4/ju4CFFAy/wWvvywbgBjAa05IwcFmh1
 N+F80TYVDfvc6gEpAWJj4AjH7WVk1bJgsLk2NfsFR+uX9P6BPG+bjGtuHdFYXw6WfY5+CBqZwT0
 ZC1sgvydDQFUSWzv/y9LZ+V1lNl6kqdSecX4m6woxveOQNZevbYtMXZy6U/hvksKh3z5CrjVIuf
 3OWkyeoPT1KV4oss32DhnLfi4vnk32Z0xq2T7hH/cDEnbPW5cpKS2oROCP7bFuT1Vz8Av3OWgn9
 c00lcOWkEd1PhkeBKkrJmDU4TQCMTP27agz5jFcGwqonFZH/40zL2mceY47VIE=
X-Proofpoint-ORIG-GUID: _S5c1vk_6SxW7wbCdIHlEvQA8e9wkb9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
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

Extend the "vm" parameter of wait_for_console_pattern() to all the other
utility functions; this allows them to be used on a VM other than
test.vm.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index 6355b1a683..ae13de0aea 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -144,7 +144,8 @@ def _console_interaction(test, success_message, failure_message,
 
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
-                                                interrupt_string='\r'):
+                                                interrupt_string='\r',
+                                                vm=None):
     """
     Keep sending a string to interrupt a console prompt, while logging the
     console output. Typical use case is to break a boot loader prompt, such:
@@ -164,10 +165,11 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+    :param vm: VM to use
     """
     assert success_message
     _console_interaction(test, success_message, failure_message,
-                         interrupt_string, True)
+                         interrupt_string, True, vm=vm)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -179,11 +181,12 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
     """
     assert success_message
     _console_interaction(test, success_message, failure_message, None, vm=vm)
 
-def exec_command(test, command):
+def exec_command(test, command, vm=None):
     """
     Send a command to a console (appending CRLF characters), while logging
     the content.
@@ -191,12 +194,14 @@ def exec_command(test, command):
     :param test: a test containing a VM.
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
+    :param vm: VM to use
     :type command: str
     """
-    _console_interaction(test, None, None, command + '\r')
+    _console_interaction(test, None, None, command + '\r', vm=vm)
 
 def exec_command_and_wait_for_pattern(test, command,
-                                      success_message, failure_message=None):
+                                      success_message, failure_message=None,
+                                      vm=None):
     """
     Send a command to a console (appending CRLF characters), then wait
     for success_message to appear on the console, while logging the.
@@ -208,13 +213,14 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: VM to use
 
     :return: The collected output (in bytes form).
     """
     assert success_message
 
     return _console_interaction(test, success_message, failure_message,
-                                command + '\r')
+                                command + '\r', vm=vm)
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


