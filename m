Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA18EDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqudU-0003Ox-4o; Fri, 13 Feb 2026 09:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqudS-0003O6-Gz
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:59:10 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqudQ-0003Th-IS
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:59:10 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9ttf9752490; Fri, 13 Feb 2026 06:59:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=siN0PcY5u+1U2QaommKa7TGYI4McIBGCQP7TIstvo
 Qs=; b=W9MWDKXWl1ki+Ej0dID/CkF9tcwc0aVEk4owY+zys7zEptFZrNxEv49tO
 lXlNkCeB+fKVuvz5eNzTsh324bHUcgc+mT/MlOmlKcqDq61RTSGhsp6H2hsDb1v0
 CZejs4gAG/TAUs9hzTWsJWp0CPfaYr3FzmLoVniEJxmnKfUzApgr3vMNJp3Z6eOh
 ovVac9RO5tbGGYMGr+WnRhxiA681+gbUauULiXqWqOy7nskbzoEvWQqtYrHRZjxi
 E0pu/q2hQwV2v80jjqzq7B9I+DhxwneFHHvHbDUyLtAJMzQxfPC5PZOZXrKbDm7Z
 syEZNufWjbJ6GtBY58207Rf7BvIoA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc991f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4eOBN74ulhYbnncW8k46OXFc3FqznpAvG5J9zDQHkfnSLxGDukrAscANW7B2ew30fvC1laeX4zujyXksBihvNyXJEEbXo2vE6ACvm9e2N7Lui6GHq7jh02dVhqKbnlNG9DEKg9YbPVx28CA/hm5jfwUzvTvgygFyldFhXJouEPvyAtPKSvxP7T4ReCz7q0mHpZERZSZDuxEiDJJkxBfTWRS//VADP0z9PhW9It7xSLj1qB++qclMg/ydEEuXKJwdXGoxUouR0GTeudMg0onAhyPNCLY0+e33kEQn5Mhgr1yL4x/UDUHUjF3JaJDbx8P69vxxlyxoLL664D/PQokYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siN0PcY5u+1U2QaommKa7TGYI4McIBGCQP7TIstvoQs=;
 b=dNJoOfbsnCJZ89GFNE+QsRBYWHw10FmjFtLLPBQMD4EncvxUGZPjXaeWSQIJ6rKYyocdlsCZpB7NBYTALAJjNhqaPoI+NkXWB5s1jt7LLqeXKcAk4O8WPf+cdNSD5h8d2sjUL6XS5AagdWc6YP6NgAP2vXS674OVWBG41/CgB4wgbA6Uu36i3iKiRd3OWbYe562UzaRMs2+RBmrMfATwldcCQBUiyvapE+/+V3Dkon3MI0cx+q0xKIIzL/5MxgTSgrdvVNi9vFHqjdfDnllRLAntM+Ya9HuryfkVDc5WT/SblNmQ1o5ek8vEL5dIB0+c6ebib+SdPHBRRj3TpKW8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siN0PcY5u+1U2QaommKa7TGYI4McIBGCQP7TIstvoQs=;
 b=Q9aNoHrPuiYMYkP9mj1PEANV51AtjQrizJ8cKzvrC4mH/zk1v7K9TPnhvAIfjllwM0+xcK/+3llcK0n2kT6uhGVkiz+VvWa/XYgAV7jeb98dmS02pBrbcr2n1aNnR2bfQp5UmkpwCzhohcxHNj7+1yQFKP2zSnC3/riz5P3xB+wR/VjB6bnl4zD/k4D24QzLf6YkhA68X+xYaLSg9ZFVFtH0QzMs6v7ERRXXqskYpefANrHmJj6ox+CUqshjfMRWIk6gph9xgS78TapPeVNazdia390NRVIPWKT7TvivzDddcEDrLGnOl1ZYAPmR4EdBVr9ZM51dviKftVPlQZ7aaA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10985.namprd02.prod.outlook.com (2603:10b6:8:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 14:59:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:59:00 +0000
Message-ID: <1fd3bf86-47b7-4caa-8cb9-012e97eac65c@nutanix.com>
Date: Fri, 13 Feb 2026 14:58:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/43] audio/sndio: replace custom logging with
 error_report
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Ratchov <alex@caoua.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-29-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:610:59::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10985:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e8bd9c-9e73-43d1-59d1-08de6b106bd6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXV4dTBxVGh1V3VVYlB3c0paSmFMVUtlbVlRYmdQNWd0blRrQ0JVWG5YWWpZ?=
 =?utf-8?B?ZjR4aS8rb2ZSWGx6b2xMeVJYZVJIVWM3aGJoOUMyNmhuVnlhdGVDZ0NuMHkv?=
 =?utf-8?B?bFBwNnVFZyt5NGQzMHVZeGdKOHhhR2QyNk90Z3NKT3lZRjROVUwwOVB4VXZI?=
 =?utf-8?B?d2dlOFJ1WnVOL0J1MTEzMWxLMkdxVTdKdk4wOEppTW5EclM1blluWitrb2xx?=
 =?utf-8?B?K2RWQmlRalN1ZHluZExDalRYSVpaNUxsNkFXdlpzcHRhMGZGMm01OWIwSCtv?=
 =?utf-8?B?QmdZb0twdFlMSys0aUUvNEJCdHd3VFdDQWpEZEZPR1hZaDhadjB3VmNDZkVw?=
 =?utf-8?B?VXQ3K1ppTnZraFc3c2xEQTVHZWJ0bXVHZ25sVnh6MXlKMTVrUitlUEJ2aU1v?=
 =?utf-8?B?R3NRS2tzZjZUazZBV0JvL2tXd1M3ZWFqUXhKUUZRTWVLVTBQekQ3YUxJdldz?=
 =?utf-8?B?V0ZnM24vYW01VUYzd1dxbnpsdms1M1A5djNtMkJjK2JYRDRaZ2RtMURpOHpF?=
 =?utf-8?B?eXFTcmR4Z0JISFgxbFpoWHltdnFDNHFqbjJ5ZTdFTDRTOVEweDA1b3pwVUU2?=
 =?utf-8?B?ZXRpSEhwSkF4UTV6N0dwVy9tbWJhOXlhWG1LMjNFUTBlOFBlZ3RTYWFscDlp?=
 =?utf-8?B?Vitwd3Qzc25WYkFyVE9uZmNHWDIwSk51RjcrY0MxTndYTlpuNlNYWUswZU1z?=
 =?utf-8?B?NklmRUVTYjN0elZKM09uWkFZRFM5TThVaGRNMHI0QXltQTNwSmxpajVvWDBY?=
 =?utf-8?B?dHpXNHIvR2U3c3V6ekZrbFJvSGhsVk94dmx0SFdERWVuZHZWNUtBTWwrcHpD?=
 =?utf-8?B?cWxiSm52T3RKZEM3ci9IaU82YTVKZ2Y3OEZNVEk5Q3YwSXcvL2lQVFdMRVN0?=
 =?utf-8?B?N1lGQmxKTTV3eUJIVFRsRW9JblhHSGxRT1hQMHJoekdjck1PcVRuSTdZL1BZ?=
 =?utf-8?B?eUc4R0VTNFJabXV4R1MwRWpQQjFtdlhORTMvV3ZLU1hmOVRlcVlkOERKOGJO?=
 =?utf-8?B?TEtEeEw4RENVMnR6TG1ReUxXZTlRdWhFT0xreDdDOVdiV093MUdLUHloM0hh?=
 =?utf-8?B?SzRIVWx4OThpUUdXQXkraVdPSmhYSXNTREt1aU4yTlRaYmtuMWxjWjhLQWtx?=
 =?utf-8?B?MDVZSWI4dlRKWTlHVE9EZ3Y3ZjN3Z1ROVXBhYTk1emhnNVdNQkVYMzcxK252?=
 =?utf-8?B?all4bVJaM1RMNFlpb1p5bU5ISklOVFdZOEhING9uYjJRaURYblRrQlcrcUd1?=
 =?utf-8?B?YUZDUjBzcTFxTGwydmFHaUlSbjJuaWRucnduOG9EMTVBUFZ5NXc1NElLSUp0?=
 =?utf-8?B?b1FQdjkxWHZFdkhESVJ3OHFlVExDa0JreU5idDVEb0x1bkRVa3pLL0xOQnhv?=
 =?utf-8?B?VHByaElyamc1RmE1bXlXcVh6bHFmZGRadWJteXY3aE9Ecm5IZGxLODJSTVYz?=
 =?utf-8?B?Yjk2b0RuY2VWRis3ZVZLamZxRVVOVzlBUmpTUndrcjJVU04wZytKSExrMGxs?=
 =?utf-8?B?dldtSU1aSlRYdHYwUlJsOFBpSERDaFJoSE12RzROcWNXeERVTDdJWHk4SzZk?=
 =?utf-8?B?UXExVURaQ0tpeHYyZjBIWnFZR2p4STNTUVZuczA4dXppdmMybk1ucXhNZHBm?=
 =?utf-8?B?bUoxSHcxbEI4WFhNUjBOYmRROWpXMlF5SVkySy8yZ25KTTNiNi9XNkJCSm11?=
 =?utf-8?B?SWV5TVlQcUM3Ym5qK2N1SXVxMk1iN2pvTmppMlZyYWVsTjdyVDdxb0svMG1N?=
 =?utf-8?B?VWF1U05ST2VNMjMwMlNzVElpQXdLMDBVd0o3MDZ4VlhuR2FoY3NFREIwR0dS?=
 =?utf-8?B?TVBpdkhuZmlndzNYK3FRMENCVEN4QUpqUTdua2pZZU1kRUpPb3NTM29SMldM?=
 =?utf-8?B?N1hIL0VOa1VvOXBDZXlSQjA3ckNLbVVvN2d2ZW53czg4MFlaUXN1YlF3MEJH?=
 =?utf-8?B?ZjNFSUk5Z2pSbVJhN1A2NHhHeFRYRUw4SGlaazFjdnNqczFBTFlhQUt2ak1a?=
 =?utf-8?B?dlY3MzF1N3Z0V28wZzhzKzcwaGUyQ0hDSFNzZjU1UU1DdDRqUHZsbWJTZ3pt?=
 =?utf-8?B?TkZyYTloZXI4bU5iT0YvcHZxYURpYUczVDdsczk2THNsemdQTVFVQ2NETVR1?=
 =?utf-8?Q?t8LI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFkbDJaTUwrZ3dlRWFFazdGVFVtcTF3eTR6c2dnd3RQVGQ5cXZ6TVRBcG1N?=
 =?utf-8?B?b1BGSHVTVC96ME9aSnVSYkNjMzF6NVFkQnNydldRUW8xcU5iaERZaHJnalFr?=
 =?utf-8?B?Q2hvUWhkZFRwTStwQ0lZOXBOaHo4SFdSUWdLdTEyR2F1T21pd2hWYWdXRndG?=
 =?utf-8?B?OEl0ZFVwRGZMS3Q3RG4wOUhkUjJTTTRzTG43RjRqdTcrRUpyNDBxbVpRTmhk?=
 =?utf-8?B?d29aOXl6UWdiYTM3VE9sVkxQUUZWRGVDck90QW9Db0JST0U3VkR0NUxqR3Na?=
 =?utf-8?B?K255WGY3aUNMZHE4Uk04NG1CMmFuZU5jMXp5WlUvdDk4ejFWUGM1NDNYekF2?=
 =?utf-8?B?NTVtR1RrTVVoZzc3b2VxcUlvbEVoKyszSUhQcXE4eUlUckRRQ2l3OU5LN0lJ?=
 =?utf-8?B?ZHBzcHNIdENJR3BEd2NuQ21za3NtWXVxbm04STVzdUIzQU5rc2lMZWpvQkR2?=
 =?utf-8?B?aDVXMGRwL21qR1I3blU5VkpSOWkxSWNvT1JhaDJBTlBxYkFYN0QwQmFHd1VY?=
 =?utf-8?B?Mlh5YjRzdUJrcVhlOWRSY2Q5ODZJemx5WVlrS2tOSVZReit6SUFKZ25tNGF3?=
 =?utf-8?B?dDFxQ2xhVXJQT1ZoSnFTdUg2S3BzZjhKSzZzejRqNlNrNlJSRC9SUVFCK29M?=
 =?utf-8?B?WEZqSlJXeFFyVktoQWZEaXMzb1FFQi9EdUFVSkNMSHBOU2pKZHNNZ0lOUUU5?=
 =?utf-8?B?NTZmL3EvY1czTjVpYmxmMmxGcCtXc3R4ZUluUVRxQWhhVHZkaDhrYzRyMlpy?=
 =?utf-8?B?WHFZZGVVRlFGS0dEMlZ5TGhhMlRLUGxNcDR4YzZremFMQjN4bGRIaVBaTzE3?=
 =?utf-8?B?S0VDWnJVR3E1K2MxbmRTYmlHMmxEQ0ZHbTVwK3pMYTYxL1plN1hiR0QwbkV5?=
 =?utf-8?B?OXFDZXhhbXRYeExwbmFhOFJSaXc0RU1rbE5ucUZra2hJakdKNTZQWnY1QW5a?=
 =?utf-8?B?UnNIYW0xK21JZC9nTTYrWmxSUWY1bkRuc3hTdzV2U1pWZE5IaEJVbWUzUUd6?=
 =?utf-8?B?MGlrZDVHSkt4d2ZnQ0N4eFdLVmNLRThxNW5HRDk0WW5yNmYrc0lGMWpPbnV3?=
 =?utf-8?B?TkRCUC9wNUFwWUdsd0hrK09LenoyUzRIeXk5a0NVczFsT0ltbGhPNytLWTYr?=
 =?utf-8?B?TXp0UXdPZGY1VDJDTFFqT0w4cjBQbmtzanlCT0d2YTdYbVIzUDJ3a0JYT0Ri?=
 =?utf-8?B?VFZEWjg1eVlDNzZVbzZpdkxTMnhUYjFkVVkxRElOUnhDc05CYmJDOTZhaHNH?=
 =?utf-8?B?Vkc1czBNU0wwaytORU90MEJUa2JLWUNoaE53NVh2UlZYYTM0eFVxWnR5a0RN?=
 =?utf-8?B?dDU0T0tJWTg3QkVQWitsL2xaN3hZNyt2b05iNTNJYzBKODhsaTFXa0ZueFc4?=
 =?utf-8?B?QStJdkhZeW50MThmbmtBL3JxL1VBTm55aGFzMmdvb2U0MS9wTjVxOVNTSlZu?=
 =?utf-8?B?eEFGYUROUlVhdHRVZDkrOHlsaEJtZm5SSnVJbnJwT1FQSTZxSHU5MjFUUW9l?=
 =?utf-8?B?NWZ4OEs1Wk5VYjFWbDJzZXZwaUU5RytPMVV2Nm12SXd2bmFCMjc5UXN2Y0xP?=
 =?utf-8?B?Q1VFV2dlM00yYVFnc0hFaDlHZkNrUHAxTmNuVkViZ01qelphQVNaQTBiUDk2?=
 =?utf-8?B?WHlIN2JnUHltZTR5WDdVZUYzSHdINTJvRDlUME8xWHVVaTUzcWdsWUVOZ1Bs?=
 =?utf-8?B?amZNVW9lTHk4ZUdLdW9DL0pjS2hOTHBHZDdzUUdXb0RNc055WWVJUU04cFR2?=
 =?utf-8?B?L2J1N1RuMHdIZFBDQ3pMaGVRbVpWcURzSCtJd3k5LzJPVVN1OGxkNDlhWjdZ?=
 =?utf-8?B?S0xGU3YxeFVZZWZibXdBUDZtTXVlQ1B6R0xyKzF1eTV6OHRQYjhCbDNCaXUr?=
 =?utf-8?B?clVkeFdybWtHR0x5L2ZISU5xRkI2RVlCV2tBQ2xSZ3RrS3VHd1F6UGJ3RmRG?=
 =?utf-8?B?TTN1VEJvQVIwK0hqSzJFZTMvajJmcmtTYVh1R0JVdExTWVZ3T0x1MVU5Ykxl?=
 =?utf-8?B?UnZ2TXlXM2wzZzc0TG9qczdPZHY0U1hwWWRXVnR5Z3RjT0haWDRvVnlGaHpI?=
 =?utf-8?B?dVl5WFBYOW5NT2pNT3B6YlNiVWhIUGJHV0psQmh2MnVTZGN1Q2o0U1N5WFI2?=
 =?utf-8?B?Zkt4NEhvL1lKL050UDBKbmltNGQzd01QSkJ5ZXhwNkVndmU1OVNEVW4wRjVu?=
 =?utf-8?B?dXg5b0htcTJ3RUxleUVPbDZpWFA2eXFCai9Vc3Y2SlFFUm1SSlBwaERYQVhV?=
 =?utf-8?B?UWN1RDJKTER6YmJFc3VWQXVCMDR2MVZNU3Q0VGRvMlVpMDBlT1N3dkdldFVP?=
 =?utf-8?B?aG90TXI4bW85M0RSOERERnEzbW5LWU1xWmg1RXFROFNvQklPNmt1eXRFNmpP?=
 =?utf-8?Q?NEUtyy7JvkbQPhE0=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e8bd9c-9e73-43d1-59d1-08de6b106bd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:59:00.7591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+Rv+arPqLbqFnKLV4YlP+mCZydQi8C9gqzrtSDr3Q/Fo/SQlte4S9Jm23NeGWde3SMN2+nVpbrM9OE6/PrTKySQXirR7kvDaULoZmdd04o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10985
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698f3c36 cx=c_pps
 a=67drJv3h0MZitt89ot57dA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=RK9GIwf9gibkvMpgJKYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: F2BFR0e6KEdTfEDu3KkNvOd9XAAfdJ3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNiBTYWx0ZWRfX4AABBxLnY0O5
 03UAiuTppJvLaBvdJ6CuWmo4xLiCAFOJ0i86gU7k0qix49JzMVG+/f7AxIBfEzyet6gUzrLGJDj
 3KFP+ibquFvr+5sqBJ88NMOjbP7nDR0X8lHq18qsOP5VP4qzlvQ+LjxsoNaZ5KIr9JySi4Ee0k3
 FEZEkyXOXOvMegngcSBERxbnBdCu6WDh4pPDiLCJadLXYrZ7KJYvvSek9j21w590lESQplOrGgL
 PVT5BNjK/fDOHk4eJvVzi+tpy2opRyGeYITdnImtanMHcKmMtDe53FBGDaZUMwfaJamQZxl6dEK
 IzSP+qS33mN/U9lWrFXZNhQV22RcNziZndjARFYCGNPkpu+OWEfLOhIyWFWIJcwp1KgIyil6Eje
 9JjtNLYxYVtKARKVibaQpg0+7bqUqKGcUXZ6id4hdoOmEkqnI80sYA0zdqhNHD0LQWflTsudgoz
 GcWaUmJPxMMYG2ZIsbQ==
X-Proofpoint-GUID: F2BFR0e6KEdTfEDu3KkNvOd9XAAfdJ3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace the custom audio logging infrastructure (dolog macro) with
> standard QEMU error reporting (error_report).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/sndioaudio.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index bc62f670a33..be491895532 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -18,12 +18,12 @@
>   #include <poll.h>
>   #include <sndio.h>
>   #include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>   #include "qemu/audio.h"
> -#include "trace.h"
>   #include "qom/object.h"
>   
> -#define AUDIO_CAP "sndio"
>   #include "audio_int.h"
> +#include "trace.h"
>   
>   #define TYPE_AUDIO_SNDIO "audio-sndio"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioSndio, AUDIO_SNDIO)
> @@ -348,7 +348,7 @@ static int sndio_init(SndioVoice *self,
>       /* open the device in non-blocking mode */
>       self->hdl = sio_open(dev_name, mode, 1);
>       if (self->hdl == NULL) {
> -        dolog("failed to open device\n");
> +        error_report("sndio: failed to open device");
>           return -1;
>       }
>   
> @@ -382,7 +382,7 @@ static int sndio_init(SndioVoice *self,
>           req.sig = 0;
>           break;
>       default:
> -        dolog("unknown audio sample format\n");
> +        error_report("sndio: unknown audio sample format");
>           return -1;
>       }
>   
> @@ -401,12 +401,12 @@ static int sndio_init(SndioVoice *self,
>       req.appbufsz = req.rate * latency / 1000000;
>   
>       if (!sio_setpar(self->hdl, &req)) {
> -        dolog("failed set audio params\n");
> +        error_report("sndio: failed to set audio params");
>           goto fail;
>       }
>   
>       if (!sio_getpar(self->hdl, &self->par)) {
> -        dolog("failed get audio params\n");
> +        error_report("sndio: failed to get audio params");
>           goto fail;
>       }
>   
> @@ -419,7 +419,7 @@ static int sndio_init(SndioVoice *self,
>       if (self->par.bits != req.bits || self->par.bps != req.bits / 8 ||
>           self->par.sig != req.sig || (req.bits > 8 && self->par.le != req.le) ||
>           self->par.rate != as->freq || nch != as->nchannels) {
> -        dolog("unsupported audio params\n");
> +        error_report("sndio: unsupported audio params");
>           goto fail;
>       }
>   
> @@ -431,7 +431,7 @@ static int sndio_init(SndioVoice *self,
>   
>       self->buf = g_malloc(self->buf_size);
>       if (self->buf == NULL) {
> -        dolog("failed to allocate audio buffer\n");
> +        error_report("sndio: failed to allocate audio buffer");
>           goto fail;
>       }
>   
> @@ -439,13 +439,13 @@ static int sndio_init(SndioVoice *self,
>   
>       self->pfds = g_malloc_n(nfds, sizeof(struct pollfd));
>       if (self->pfds == NULL) {
> -        dolog("failed to allocate pollfd structures\n");
> +        error_report("sndio: failed to allocate pollfd structures");
>           goto fail;
>       }
>   
>       self->pindexes = g_malloc_n(nfds, sizeof(struct pollindex));
>       if (self->pindexes == NULL) {
> -        dolog("failed to allocate pollindex structures\n");
> +        error_report("sndio: failed to allocate pollindex structures");
>           goto fail;
>       }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


