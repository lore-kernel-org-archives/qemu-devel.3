Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3095ECCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkJS-000366-ER; Mon, 19 Oct 2026 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIkJ6-0002wL-CD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:09:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIkJ4-0007LN-6o
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:09:28 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QP1p3199051; Mon, 19 Oct 2026 03:09:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FgYtZhBrsAbcBpuNy4ju99GSZE6ECTVKtIgcep0SZ
 zU=; b=USCfJXIZkM7CvpWY6Q9yJ8THqmvN9bNOa/84B116fQkD5IbRin+lyTMKD
 33eJFhfj2i3NFWFKdPeXZeLs0q5G0Gs989nLbgguy0JtBpjNbA+5BbfUA5geY7J5
 knzV3wIWE8Gs5EMI4J47JT3PibG3Y22tFNmRT2HxjS8iI7gH04jSmkSGdwDlEUGc
 BMpLlpS4A9sRK1A+i/gTC75J/UhiTsFqUUw6UIXD0qjrufso9L2zJZlLt0m5x4fQ
 fyPACGAK7+l06tdasao7LgFOxrgbtf0XigjjgYpE8oN1l9H4ppazmG0V+Exhlg+X
 lZpkDAsE4wq7NbUIMhTYN/shPCRxQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021125.outbound.protection.outlook.com
 [40.93.194.125])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc83eu6n9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 03:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV/B0J+Pfgpr4r8b/fLUN5lvHRKSLxk7xl+SBTwtfBIsU2nFuGTLJNob+uCvlaDlqcrgvVCkApdOj9Noy3HSLBHKP+LeUQE6ZKfT9qoY43SYXKRMwa9LrnhUBQEcIaEKje+M1WPPOyI2OLnfUcIDWT1kKuJuzVj3rcbjY6iSDVv0r8RDpwuZkX4/+cPZvApoRxqBAsXEc1G0qz48F0zWubhH9Q46EDRNmPXTRRjCU9S893B5+s8JzJwA3QNfhDCoVqNugiWixi/0zt5Q2jafaQUqxVSfv4v01vYP8nY21ufBQ2O6DLJunIP94bFErvzRjfKBfMHuYI/I4Pe1rXPjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgYtZhBrsAbcBpuNy4ju99GSZE6ECTVKtIgcep0SZzU=;
 b=ivR6L14AAODLOlZ4Awla68f8/4/d2HTG5/mAfeBwkHr3QAEqWC/+seRprIfEZr2SjHe7pRcHUWTClfn0IrHW4GjYXFP3E9U7jPQGNXlwYtiKASREpDpgCAWl9sopEOF1PKtDRXc6INyZQTWcFmRSvbHuTUIxoICRup+FysdDw/izU4Y4u/cUdybHTklIVDgZfGPOK4/AcVLh9s5qLj0L7Fhqr2s1oYuxySFLc6frNpp8Bckf5IJU77vHNE/JyemgTDpH2n3mC7GQ9rjW6g7L+3JvR/7oySrwf2iijqvlFbPuTdkTl2mrpyGkT37EklvnYhfANA2Ns1TzGqFZaQLZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgYtZhBrsAbcBpuNy4ju99GSZE6ECTVKtIgcep0SZzU=;
 b=epmYaQGqf8F0ALVO6ZzQEYhUA7a1Gf/ThxWN6am4lzS16g+2Oe4FOEI7QwEWW5nPGjEozQLHp3dd2BltIPBtzuqX0b+LLJ6P3GXw6VuB2GwxPYQVgcFNi35GCpCB3PhRN5G6oUWkBDia46r1HbzM+zJDla/t+3tiUVo7wOQJHoBWzt0AndtXHSnWFABlbCzRbFzbL9QE0/qkK55voUFggGhq/ayrRLYL/WWRYfL+PRxl2GBiMym/TrhwkeZYLHNMtjF5Yay6xFK7ZtfHeYWwDm1GSNSWIff2+L7G9ihSrId3z+qfaZCFH6h05fqqOnhkQbcLPn4CmbWMV6fgmpcBCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYYPR02MB9885.namprd02.prod.outlook.com (2603:10b6:930:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:09:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:09:10 +0000
Message-ID: <98c6bd43-6dcf-4af8-ba20-c6fa8a349db6@nutanix.com>
Date: Mon, 19 Oct 2026 11:09:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/27] i8259.c: properly cascade secondary i8259 from
 primary i8259
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-20-mark.caveayland@nutanix.com>
 <CAFEAcA-JxCnmwSnMoEu2UWGX_wmoynMK7nC8OX85thxV=Dq-sg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-JxCnmwSnMoEu2UWGX_wmoynMK7nC8OX85thxV=Dq-sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYYPR02MB9885:EE_
X-MS-Office365-Filtering-Correlation-Id: 386e0e4f-db7a-46d2-156a-08df2dc904a0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: UpHjh+CkQzJrMaYbtK/vVaDwZxr3WrUPv7OzevoYnHgkMt8Uoi3ftuyEei1eC/QqtI8Spsda+0I22mblQpWwkjI9Ge4Mt390eI5erKgHNZfFoCKSv/sl42FZqZDy6gYH4nYTrnR2+NEUefmMI5u74/uXAag72Jp/GtLM4wX+17rZyj2I5N0QOmkDIC5Q2gxGd2X931kuvNLTnP4HVehcz54OpXXkB1Jfa/bXxzZHl79ku1ecyXnF0Dds3EdAuf1a26ws08fj7Si+8MktF0MWAR40jcEuRZJNLQRILopgH0WgS0GIxwIaGudsU4rNc6bHEzfSngY8L9X1E8Y1jJucL7DUPDEJuVF8OyRr0RlieabkkljA0VTWxcsjOLyIqhEHifJun4GPaNedGEVETH567LgZZbMKcPTb0YkMCNzLkxRSwaVjCv8/z27hzwTwYdsVzbndvSI0wYtBKjIhuqXtq50tI7V7YLBoPv7SYQIyRzLKZjqRgjVO01EgelHrLD9fvRQKNnA5VLSEgjx6LBDQXJs7Qd5fHlkse9uo/9Ed1VOJrB3IluTS5L09dO+Hd4un0gizjl5kRK7XXT2NVq/qfnwCx1VYVwZ7jtfHMoRLFCkGyLpizpzjsrR44YQi24/38ZJ6sKrelbSFz/ayuzxvPmeXjM2f6kVn5HAyBZYYzNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1mcFg3STZlcXZLVC9MU291M2VXWUlPdzlHbUFiM0dzL2phR29tbTJYS01z?=
 =?utf-8?B?aWRjbEUxNlFOUEo3VU5sZVJaMFBBMm95aGxFRWpwUEU3SHoxdjFSclQyakE1?=
 =?utf-8?B?U0NYZkkwWlJiZC9nZ0F0Mm5adWJOY1MvTzE0d3F4cSs3UHN5UlR2bUFHK1dC?=
 =?utf-8?B?YnF2VGdnaVlRK0c0enp4Q1dJRGJndkRSV3ZjU0JxRVpiR2NiZlR6VzN2UWYv?=
 =?utf-8?B?N3JXUnpBQWF4T1RQSm9KdnFOQ25YUldtUmVXYmRETTdZSnpnSlZIbXhvNUth?=
 =?utf-8?B?dWxQV1B0UmUrVVFpQThkNGdGM2JRcHBoSDUvcDFueUZDUm43WnRkd0ZBeS8z?=
 =?utf-8?B?QUFJbWdKSUdBK3F0b1RUYkRkaVpnK1JHVEd0bGI5QmNYNHhWMUZNcHlFMTNJ?=
 =?utf-8?B?c2RxczBOdHhhLy8wbitxZGFORDBMUmF4TTAxZk9CZklSVzJZckJSN0U0eEZ1?=
 =?utf-8?B?eGZqQlgxYlRJajBOM0VocDc5Q0NlNmtBQUYvSUl5VjVzV2JhTEpJRGtyZW9E?=
 =?utf-8?B?cW1xOG1aUUJRN1hCUHFIb28xMkJSUklSWk5WaTVpY0pJZGRXVUJSKzNENDd6?=
 =?utf-8?B?QXlUYWJldit5ajBkYXFGM3VSay9iVWV4bnFneDZpVUYvejVrWnFmVTRFdGM5?=
 =?utf-8?B?bmRSb2hJdStLa01DQ1Vjb2ZtY25qT3B3ZmFMeVd6Vmo0WUs5ejdYTklVNlRu?=
 =?utf-8?B?bjBJdGJpaDl2aVY0Mld2S09lY1dlbGVPU1IxdVNmaUVBQ1ZwSHZTTUVCR3Bt?=
 =?utf-8?B?MFdoTllNYnRHMloyZDJFNGJJeXVST1g0TVR3Nzh2MklGMGhqekhtVUlOZlly?=
 =?utf-8?B?cUE5b3FPRWVRMGMxRUNQS2FaU25QdEZsb0xtdXQ5U3RpYW5ZVzhuM3BDQ2Ni?=
 =?utf-8?B?TFhqV3lGQ2Y4UEJVOUJEbXNDZEIyVy9zNDRuVlNkc1Rtc3RHUlVTVFd6dzJk?=
 =?utf-8?B?V2huWHFWdk1zRXFkbm5yU3pISno3OW9QTHRRSGVYcmdUNkVOMm5PVEFFdE5x?=
 =?utf-8?B?RGlMV213RVdka2tyd3hvbUp5VUdoa0s2eEt0Unc5c2JEaCt0Szl0WTM5cFEz?=
 =?utf-8?B?MXJWZmkwS21CZnE3bnE4bjhXZVk0OHp3dUJzWU1mcmNYVUZiR2xmZXg1cXda?=
 =?utf-8?B?b0JaN0ZJemlXclVkaGwvWDZmZFZFdklCNXdEeUV5d2ZTbmFzN2tRUldCQ1FQ?=
 =?utf-8?B?TmVrYzlidkVtYkJnMGVtdTNGS05LbTNnaUtyNERVYk11UlhTb2dOV0l1RWpV?=
 =?utf-8?B?RXc5R1RFeTJYcEs0eWVKVmNUTzRHTnVyQWlZVjFXZkdvUFdMb202VEYxMzRV?=
 =?utf-8?B?YXZJZnFURHNxWDVKUWEwRUt3dVZnSVVoWFRVZFd3U0w0aHByVW5xR01ld2I0?=
 =?utf-8?B?L29STTk5MDZTVXM5cytnTFZrcmcveHVkUTl2bkQ4S1hvcHVtM1JzdEhJaFV2?=
 =?utf-8?B?SzBNUFg0ZVlDN0U3eCtBTk9rb011bi9UMWtUNWYwN1hva0ZFdTdhT1RYTjkz?=
 =?utf-8?B?QW0vUlNiam9nY0p5K0toZmpXclRXTG1RT01RVXRUUUpDQkFUV2kxL0c3aFZt?=
 =?utf-8?B?Q2J5YU4zL3o4b05kc3Y3Mm9wUkRRb1dVallDdUd4MDB0c3MxRis1SUdEcURK?=
 =?utf-8?B?dVRpNWc5QjFQQ05SeDhJQVI5enJYVzRHWlhSS1drazRnK0ZaR2paMmg5NlZH?=
 =?utf-8?B?WkpEOW5nSGY2VEdvQ2Q5TEthQkFXZVhEbG4rQTYwQjVDellNWnVuMXpyTk03?=
 =?utf-8?B?aWp6RVFGSmgxS1d0MzhKemVmb0hjMTVKMnZqUVpHdEdta2dTdys1ZktGWFBz?=
 =?utf-8?B?OXF4SWxQcldmcFZhNlI0QTE2RkJoMFVpcWMvbUtBbldiM1hMeW9EaWJwR25R?=
 =?utf-8?B?ckZteFhBUmNTWHJraURCa0RwdEx3bExwcVNDN2N2bTgvZHZGZGR2aUpmRnRs?=
 =?utf-8?B?OVpDb3dPZmtMRTNIaXdRMjNaWndGVFRCOEtCUklscVExOEsxZ0NHSVlkT2lV?=
 =?utf-8?B?VWdVeWk1OHlDRmpKY05DQ2ZNdE1JUE40dU81bkpDTlJsZWRFZ1l3QnhhSFVE?=
 =?utf-8?B?MjBPZCtRRzJVZ3d0VGNSN2hFbDRUSTR0emxoWHVpaVppR3FvMXZlNDJpYmJE?=
 =?utf-8?B?T3ZoOTRMVlhodVZZRXQ0TXpPY2w5Ynd4WGtJWlVLQVo3ajUwOWtaa05peVor?=
 =?utf-8?B?bWZ3UG9Qc0w5d1dOR3FXUkh5MDZyRUN1eUI0YXdvTEhNaXdpaGMwUW1rN1Fj?=
 =?utf-8?B?Q211UHpWZWVUQmluL21JVXhCRDlqdTZkK1JBazB4eUNWWURHYlhpdDFDL1dF?=
 =?utf-8?B?cUF6eW5pZVdTd2RuRzlKbEZHd0E1Vm13cjBxbmZxLzVKSXBibHp0bm9EcVgz?=
 =?utf-8?Q?A6sVRwr+Vn8Fpz9Y=3D?=
X-Exchange-RoutingPolicyChecked: KiDb/WLZGaAtSo6bEZ7aLm2SfoB1n89qbGxuaRIO62PUieXOC7DIuGlSvZR/CG2evlmge+B6OqSE+SqU1Q/7b71xTyda1oTs/LK0ljBdMadBuYlrXo9wGPW/YGHD/BzGnxl5ZPc0rH+NgJB7zebaeX2iZFOT5ZkH9ll4rAxboheqz5ShmEoFSKP9OEJ+apTNrqm86VLuuEtmpXAAsKEvBDGkFb7LZAC4VU0ZKevBA3vuwAQH4EjP3dGThVYVnvwQU302qldXp9r4GyrpeKuJ+OuRjcTOGMW4I4VTzn7YyGsJRXtbPBIUsmYKKN5qhoaSizfvqa4Vz64zwbDSFa1o9Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386e0e4f-db7a-46d2-156a-08df2dc904a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:09:10.0223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhYMxIV1KLrzKUNXl3hhp9r/25sj6vEua1rSuQnQ5vxrrd8u08UdyA+lJTjO2/UPzHA3A5/HNvxJtpjelr56a8Y1YqMQHZUM88xEGvWlMhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9885
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX2rQ0dojWcXc0
 ztUMvPTCo67pV8cPD2ZwjYq8qCWWnnWAmoWcP6q/f440ZTze6b0H/F1Or8yzOD54IigqSLjDf5Q
 rU+4QVPpNnfuD0+x3IbE+xFN8XpcOkvjHC9gOemEmXVBp1U5UbiYt67nv3scSga0xzZ3tCr5TPf
 gcY3+dWCV29l9WP0UCmAFC/U+4nxQUW4teH+rW4iW3z84TvFFWn/WgvVqxG8iDokZsMAmc+mPuh
 BCrzXTXSmDjdRl/n+yP0fDCFdlaT5LSvJI9F0WF0+VCgrL8alOolkCQtvwnbgjcolGLG72NmH01
 ulTCByH2YR9U0/7mwPx31J3SXk+3Q2JUIukb1bkSDe4pm69P0RUs9CDt0wP0F2TW+YaHo7xT3zR
 mlV7NVuVxJxPyHSCGs3HJ8V/n4w+tCBdEFJZAcQyuBD1VlkQZkwTQd7bwzn0DSqEtBiPV5JuX+w
 OD4TmMVtIF9N4FqlKIA==
X-Proofpoint-ORIG-GUID: rlpxDy7wfvcgY-NBnwhXC9mxnuLbdpnz
X-Authority-Analysis: v=2.4 cv=RI8mjIi+ c=1 sm=1 tr=0 ts=6ad5ec47 cx=c_pps
 a=zgxwnwFdFZm2O07vxbsARg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=8yAsudsQtBc8yLAMONcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfXwXENvl8isCga
 H96EiBioNPr1mmLSM6Cx6SwaW6z1l9X1JsonoExWC5m2tcg8BrrKwdkaFhAVikM1l7zMlSFVGoO
 YWLkJsGG1BMiWePTjPqmhcwdGAqaZiI=
X-Proofpoint-GUID: rlpxDy7wfvcgY-NBnwhXC9mxnuLbdpnz
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

On 16/10/2026 17:04, Peter Maydell wrote:

> On Fri, 16 Oct 2026 at 15:24, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> Currently the cascaded output from the secondary i8259 is returned directly in
>> the pass_irqs[] array, instead of being connected to the relevant input of the
>> primary i8259.
>>
>> This is a bug fix since in a cascaded configuration on real hardware it is
>> possible (although unlikely) that the cascaded input from the secondary i8259
>> can be masked on the primary i8259.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/intc/i8259.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
>> index bfe01067b7..5f90edbe60 100644
>> --- a/hw/intc/i8259.c
>> +++ b/hw/intc/i8259.c
>> @@ -519,7 +519,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
>>       }
>>
>>       /* Wire up secondary cascade */
>> -    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
>> +    qdev_connect_gpio_out(sec_dev, 0,
>> +                          qdev_get_gpio_in(pri_dev, 2));
> 
> Looking at this again, I'm not sure how this is a bugfix.
> Quoting patch 18, this is the code at this point, just
> for context:
> 
> +    for (i = 0; i < 8; i++) {
> +        s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
> +    }
> +
> +    qdev_connect_gpio_out(pri_dev, 0, &s->i8259_primary_out_irq);
> +
> +    /* Secondary */
> +    sec_dev = DEVICE(&s->i8259[1]);
> +    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
> +    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
> +    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
> +    if (!isa_realize_and_unref(ISA_DEVICE(sec_dev), s->isabus, errp)) {
> +        return;
> +    }
> +
> +    /* Wire up secondary cascade */
> +    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
> +
> +    for (i = 8; i < ISA_NUM_IRQS; i++) {
> +        s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
> +    }
> 
> So before this patch, we connect sec_dev's gpio output 0 to
> s->pass_irqs[2]. The loop earlier in the code set that up:
>          s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
> 
> Now we have:
> 
>> +    qdev_connect_gpio_out(sec_dev, 0,
>> +                          qdev_get_gpio_in(pri_dev, 2));
> 
> Isn't that exactly the same thing?
> 
> I think it is indeed a bit clearer to directly grab the
> pri_dev input rather than pulling it back out of
> pass_irqs[2], but I don't think there's any behaviour
> change here.
(goes and looks)

Indeed, you're right. It seems that during the upstream rebase from my 
dev branch I accidentally dropped the following hunk:

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 5fde3731ca..d713795ae0 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -504,6 +504,11 @@ static void i8259_pic_realize(DeviceState *dev, 
Error **errp)
      }

      for (i = 0; i < 8; i++) {
+        /* Cascaded input is not usable */
+        if (i == 2) {
+            continue;
+        }
+
          s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
      }

Along with removing the isa_pic global, my other plan for the future is 
to drop the passing of IRQ arrays around the x86 machine so this logic 
should eventually disappear.


ATB,

Mark.


