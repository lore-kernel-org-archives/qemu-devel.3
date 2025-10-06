Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCD8CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lJ1-0004DY-3i; Mon, 06 Oct 2025 09:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v5lIy-0004DK-GD
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:31:08 -0400
Received: from
 mail-switzerlandnorthazon11022091.outbound.protection.outlook.com
 ([40.107.168.91] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v5lIn-00057v-Kh
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:31:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqwozIexeWGlho2y4SKCUyDBsVdjwFzyVikGzU+hGE8Lj2FJ1Jb9rouUPdN4WMs56B2adfkLYff6fcHbrktQzCJ7JAcdNX6Zki8+RBv8jEC+U4bHrVEVPUOAkdZUJLVjBG1EmKtDyGwEKjrfQqBsaKr+Gutvq4JvIn+faOm3OZLXnL+NIZ63NDzKnTqwDpX8XDC6k4r81pAxYJ7Ql82ZF0cs2pYttjHS2aKNayhkp1mzToHQnI3OBAybsCXLsqj8t5bWrCSvXkcsIegRHjjFVK0sMLs6PrLc2Eju0HxKfWn5eFfx2dhFjechjlucXFmmjw+d/JkpV4kkAsY/UY9n6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HWaI5qN7b1Ii0bEOirfH2LLdHkxFYjpRvEGCU2lJbw=;
 b=J+jv88HkmENAsKmmBgnzyC7cNe31mTNUd7DEUBJgX4xftTN7+uG9pPibkllHuI/6Y+7+7FqYKAxgBBC8u3OaHXKdyNXtg3N+pzK8M2prnINe/sF/qU2sGyfCHQ1r01wWT7F/ZF9kWGbz79DZSswWYWIdleTnnCt/3lEelvrwnrNfoY27MyXneZRqka6aiRaSk6UYxvwVhD3BGwkIWjwstDSXVin7C+bg+3jLOpOw8fNEAWuhQviKcY0FuWCZhhKSyU+q/l2/qyLizd9k0LVTvojOZQ1yJOmvm8YnC/SSExKNG6JN55zxOl+dZIonJakRUO+HQxHtouPyCFPhpEC6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HWaI5qN7b1Ii0bEOirfH2LLdHkxFYjpRvEGCU2lJbw=;
 b=ZBjBojk12M7+U4D58ijXtLBms2Gw2Ru45lP3tO4IJnhGtVbLTSBdPC6bI5g+i2dJ79LnU6qon9z0uHIwIrItJgZE4Efu4+iA9W2DPzx/JE7DNwwZ1VbyiFnjRQw1CrwumNAUwIax17etGCT6HaAueVQ0YyfKeiayfM36iEViYdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1185.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 13:25:43 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69%7]) with mapi id 15.20.9137.012; Mon, 6 Oct 2025
 13:25:43 +0000
Message-ID: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
Date: Mon, 6 Oct 2025 15:21:21 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
Subject: [RFC PATCH v2 0/2] Enable PC diversion via the plugin API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1185:EE_
X-MS-Office365-Filtering-Correlation-Id: e64f4a1f-ac43-487b-f0af-08de04dbd9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEJGZkQ3dmJ2cDJZbTVqN1ljckJaRU1lbVFvdGRiSjNCbWVRN2lzVWFKeUYw?=
 =?utf-8?B?RkcwK0doTCtlNTA2LzdkeDAvbEpiekNTYUE2eDMrVnplaTVOeFZhM20zOUlV?=
 =?utf-8?B?eE5XeXJ5MGhGTDlWV0MvNkNhcFc2TWhmcC9FalBkN2ZUV2dwV3BHM0E5YjAz?=
 =?utf-8?B?eGt4bmh5QTFhaUtia0Q2KytJRGx5ZktGbCtNNUVrSFBIRFdxdkNhYVBLYlFj?=
 =?utf-8?B?ck9wZnJ3TitCM3k3OGFPYWtvUmhWaVNNUWtqcGpsb2IzQTNIODI2OWNva0tW?=
 =?utf-8?B?a2FLV21xbmIxSk4vdVBWVVlRL2M3ZENwZktudHhuTW5sRi83YTVuY1J1TkZN?=
 =?utf-8?B?QU1IWXA2Nno5a25LLzhkbFd1QWdGaS9peGp1KzRQaVdsYVFuZEtnQTdOODc5?=
 =?utf-8?B?ZmNpczQxVWV2b0hzTW9yZ3lWTzUrbGJPamVSWUUzVXZ0aS9LVkdrMFYxeXgx?=
 =?utf-8?B?akNCT001WkdyQUNVcUgxdkQzd3ZyMGEwWGRmQzkvS1g5OTYvZlpnTzhLWG5q?=
 =?utf-8?B?TWNwdUdoTHl3MU1PM0NBNjNvd3VvS3ZpdVluV2xHMHZJb01TZU91OTQ2dXBy?=
 =?utf-8?B?VFhqNUY5K2VXb0gyTExLZUcwajBNbDF2VURDMzVGa2lnNkIzNmVnUXpVZFho?=
 =?utf-8?B?SjUyQ1RnU0xWRW1UYzU5R1dLckNWenBjbm03UnBXSkMxdW9VOEN5SXlWbTJ5?=
 =?utf-8?B?ZEhreDg2QUYxWWE4K2ZPc0IzaSs3bFRxa2YwYlZLdTVDLzNRSGJBYitRcVNz?=
 =?utf-8?B?eGxicWl2aXloRHJra29nYWo2ZloxSnhOdlcxOGJOdFMvSGNYQUg4MlRpWWVP?=
 =?utf-8?B?bGxrZTB5akJvUjQ4amdZWHUrS1FaWkU1c0Y0TzFuZVNXUnRCcnJYY0lNWVVo?=
 =?utf-8?B?WGpLdkh6QkJmeXNra0x6ZWk4SmgvRmVDckE4OG9ybjdGQThqVUI4V0hLMnlp?=
 =?utf-8?B?VkZxQllZS01JMmdpNStLcXNPOEI5UXJWU25LNDFFWHhSOElRdU81d29HZXBC?=
 =?utf-8?B?WmxuNnFoU0ljL0hRZy9ZMGVVLzZnbGM4Y24wTlNEbzFYOTVWSjB3WjN6cVcw?=
 =?utf-8?B?d2hySXF0Z3VSTkZ1WGcvYlRYVHR0YjN4eWgwSHJyZ3dnR3BZWE1UWmFVQmJJ?=
 =?utf-8?B?VWpXMmNKYTR6c0M1RjdoaVdySXA1ZnVUdmpiQVdyV1VueDFYbXd0dVduUWs2?=
 =?utf-8?B?TVZYdG8xSmRaVTU1cWlIZTRqQVR5R2NJa2E1T1A0Y1E0YXNaZGh3aUxsMmJU?=
 =?utf-8?B?Z2FNL1J5NDFGQkhWRFl0UjY3ZnI4MGJBRi9jY3drVVREejJmUE4rblpFM1lV?=
 =?utf-8?B?elFzK2pKbFFUc2J4NGt6Z3MzbU1XUE1BVnBpNi9OL0FBOTBsV3kraEhPRTk5?=
 =?utf-8?B?QzBFRVdqVjdCNGtENHE2YlNjbXduNXp2SWhkY2VEbDRzNi9ybnY0cWhtcEhW?=
 =?utf-8?B?eExIeWNzTnYrTWMzMk9zMnFCaVJtRXNXajBVNXo4T1Y1YnQvSlZKbGR4c0ZE?=
 =?utf-8?B?Mno1d2I3M09xTWIvQVRMOHFONlViZFE1dVg1em5NWFcxbHNuazJaLzE4bzBS?=
 =?utf-8?B?M2twQVRoWmpzQ0o2UjZ4UG5RY1RtZ2VqejNhSng2VkltOWEyODJoQnI2RW44?=
 =?utf-8?B?dXd1QUxLa0puTjdqUmdGMUw2Ly9kKzllbHUxSW9ieDcxNk0rRzV0djBKQTZy?=
 =?utf-8?B?enVHWTE0MzV2MDlqbkFCcUZSZzhYdkxKMzgwNzR2Z0R6RnhWSVZubUJGdkVW?=
 =?utf-8?B?NTZMd2dqSnovdkNpTnp0UG16YjJFUWs4YXd3Vnl0U200WkJDaS96WmNvS3dw?=
 =?utf-8?B?QzNoaE5jZmxJNGI5WU1yZUNSNGpIdmprSVlGQXAxbjhUcXNpVXd3Z1lWckdW?=
 =?utf-8?B?YXFOUEhJaEEvVUtQOUhKcHZSVjBIdXgvK3V4QXp3WGFDREE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVozS2VPdjlqNURTMCtVSzVlaWY2cGJGY1JJWHFjckVkQWNEd0Fpd3lsc1hY?=
 =?utf-8?B?alc4K2xOWWVBdXdYVHgrL1ZmMHhMaW1yS1B6aWwzQVlUSVluTlM0b21VTHJG?=
 =?utf-8?B?Z0xpOFNWMGZVQUQ1UjJSZDhsTnEybUZ2TlhreTZWOU5DazR0RTRVa1lTOWc4?=
 =?utf-8?B?a3picE96UUlIWkgySVZXS1d4amtSMWdZQ2lCM1NOVGQxMFRjK1JpMjA0NFUy?=
 =?utf-8?B?dVpTL3dPZU1tVjNKUCtDRTVWcUdiS1RhNmRZMWQ0cXl4cE5QZlBjOVJXczRl?=
 =?utf-8?B?cU5veEExb3lHM1JOaXNGRmJkb0dlZUpOZGNJZ3FEZnNGT1BhaG1wbk9nb053?=
 =?utf-8?B?blJ2VE9EQ3c5VnVYT1BZck9QUFNRTnkyN0xZQm9QTGlqeWJ5NkprTWRZUkVM?=
 =?utf-8?B?S21KNzNzR250eHdkTlE4clpCR2FQQnFidFhUakcyckJoRnFrY3pobmNOa3dN?=
 =?utf-8?B?WGVpMDNVYUtldmVmb1lOZ2YwM3V6R0VERTd6MVR3eDBVYWIrYzhGOGNmQVhU?=
 =?utf-8?B?K241RUhOd2x5cWdwVngxSVhvdnpNeUdCZ1ZPSGJZalRjNnRSdE84Rm9rcEd1?=
 =?utf-8?B?ZVVjeUJJZi8rQ1JvL0dIYzRaNVJQVmp2aWpTOE5wQTljSGU1YTF1Zk91cnoy?=
 =?utf-8?B?UndidmpIeVRUTElZMjFTSnpzdTcwV2ZoVml1Zk9HeHc5TlhmWFRnU3k4SlB5?=
 =?utf-8?B?V0lyems4cXZWcVVjc2pLNWQydE9STzY4bHRuN2RreW8wWlAwR0VWOWRuaDZE?=
 =?utf-8?B?ZExuR09QU0hwdXpPUnduWUpuQ25tLzIxeDZ6RldBTnVWZ3V4UksxY3pjSGJW?=
 =?utf-8?B?RFpObis1bDBkdm03ZWt5cXpiYWU5b0N2V1pRajM4Mjc3bWV5TEswb1QzV0dj?=
 =?utf-8?B?S3czQ0pTV1RoVW4zRU9NYTlEbzVtUzNMbDFCU0Ewb2Q2bmd2MHVIeUJ0ZnNO?=
 =?utf-8?B?bkg0YUF2M1VEZmhtOVhwbHVJNE5MTXlNdjZxaC9WWUgydlVtK21LdUF1U1d1?=
 =?utf-8?B?NGxyemF0dU0rNDZOWnFYbGZicVB0VEJiTVRySnIyaFc0bWgxbFYrYUF3VmQ2?=
 =?utf-8?B?UkE0V0VJV3d6VGE0eG45azdVSFBlWnlaQUJjb09STTI4Q2c4ZVVDdkppSk1o?=
 =?utf-8?B?UE5aMTZocXJhR01JUjlndjRxQlhPNE9Rc2hnQTEyVGN1dGRmM1Zjank4blZa?=
 =?utf-8?B?ZE1OR3RxRmhqaDNqVlVGUUNORmIvZStGYXpkWUF0UG5CSG4xTWZ1SVBqeitR?=
 =?utf-8?B?WXhzWjk2K3dHenc4VjlPTXNwVExRZmh5ZFFiZUlxZ2g0YWoxbnpLc2NybVlo?=
 =?utf-8?B?aFBOMEhrd2kxVDFqc0dNbWk0SnNoalErcmxMNHV6NGZoenpuYmpUYmkvWXFo?=
 =?utf-8?B?SFRZOTRTRXVGSlZ0U2ZEeDVpZHZNT2JDNGloTzZyNmZwZllsUE5EeGdmYlRm?=
 =?utf-8?B?ODJYNVlIQjFBaGRuWE5TOURDbEpQdU9kZmRoamNIWlcvZEhBSDlPd3lvOXBI?=
 =?utf-8?B?aW5mT05CNzIwZ2JRdXdwR044eHRCaGZoWnlqK0lMY2NsSnQ4UHM4a0lqTnhw?=
 =?utf-8?B?UXp2RncxaFdzbWtBOGhYTTZnZytoeDAvY3A3N3hGTXAycHRsV0ZZMzNrakln?=
 =?utf-8?B?VStFY2dTUmV3ZDF1M2hYME9qM3IvUkFERHYwVDl3NXFycVppRlMveCtONUk5?=
 =?utf-8?B?RUhVN3R3SDlNanZlaDhoenJvdzY3Q0UvN2pHQlppUk5GbDlvaVMvZVQ2SzVL?=
 =?utf-8?B?Rno5dTltdDBpQ0FEOHBhdXgxWjUxYVdTazhBQm9FN2tsbVVkNmFTaS8xK01k?=
 =?utf-8?B?SWc0aUs3ZndPbkpNbk5HQ1NVOU0rNmMzbytURDdFbzB3OVNrMmxaWW1sRE9i?=
 =?utf-8?B?MWxWbmZzY3hta3c3ckFLMVFaQVFzRmVBQVErTkF1U3Q4Qy9tWXRIb1piUFdh?=
 =?utf-8?B?RVVFM0ZjODY5bW1ocnhHSEY2R3EyVm5xN2wxS0lOZkNrVVpwaEw3WkV5ZElH?=
 =?utf-8?B?cVZ6TDZ3UXlrQTZGUkswM1VFTjdGN20vRTRybStlNHFaODVORzEwbDA4MVI0?=
 =?utf-8?B?ekRFZ2s1M0x2aFVwaXREMk12VGdMenpnRGxubEZ1OG9FUEc1a0JBNnA2cHdW?=
 =?utf-8?B?VmxyaE85YjlEb0lwWXJuNytsaWRjNWNOSEpvK2xDVHIyY0RuQmpmWjBPeEUz?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e64f4a1f-ac43-487b-f0af-08de04dbd9f1
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 13:25:43.6827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/HPLLDbFqWlOHXiJTGK3Kf0KQCwFVQZwVruoPqLQp17swH7F1ouFhU9ablKngn64M4sweU3ggZjg9Jbi/Ejy4PLlh67l5InCu0h+G1e2bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1185
Received-SPF: pass client-ip=40.107.168.91;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi,

As originally discussed in the thread at
https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
and later proposed in a patch at
https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg02218.html,
I am sending an updated version of my patch based on the previous
feedback.

Notable changes to v1:
- Added a setjmp() in the syscall handling path to allow redirecting
  the PC via cpu_loop_exit() also in syscall callbacks. The previous
  version would only work in instruction execution / memory access
  callback contexts, as the setjmp() corresponding to the longjmp() in
  cpu_loop_exit() was only live in those contexts.
- Added a flag to make sure the new API function is only called in
  contexts where it makes sense, i.e., during execution of guest code.
- Added a test that checks the new functionality by skipping a
  non-existent sentinel syscall.

I made it an RFC patch this time as I am not entirely sure if my
setting/handling of the new flag makes sense the way it is. I briefly
looked into making the QEMU_PLUGIN_CB_* flags actual flags via a
bitfield instead of enum values, but that would have required touching
a lot of code all over the place, so I'm not sure this is the way to go.

Happy to get feedback and your thoughts on the patches!

Thanks,
Florian


Florian Hofhammer (2):
  plugins: Add PC diversion API function
  tests/tcg: add test for qemu_plugin_set_pc API

 include/qemu/qemu-plugin.h                    | 15 +++++++
 linux-user/aarch64/cpu_loop.c                 |  2 +-
 linux-user/alpha/cpu_loop.c                   |  2 +-
 linux-user/arm/cpu_loop.c                     |  2 +-
 linux-user/hexagon/cpu_loop.c                 |  2 +-
 linux-user/hppa/cpu_loop.c                    |  4 ++
 linux-user/i386/cpu_loop.c                    |  8 ++--
 linux-user/include/special-errno.h            |  8 ++++
 linux-user/loongarch64/cpu_loop.c             |  5 ++-
 linux-user/m68k/cpu_loop.c                    |  2 +-
 linux-user/microblaze/cpu_loop.c              |  2 +-
 linux-user/mips/cpu_loop.c                    |  5 ++-
 linux-user/openrisc/cpu_loop.c                |  2 +-
 linux-user/ppc/cpu_loop.c                     |  6 ++-
 linux-user/riscv/cpu_loop.c                   |  2 +-
 linux-user/s390x/cpu_loop.c                   |  2 +-
 linux-user/sh4/cpu_loop.c                     |  2 +-
 linux-user/sparc/cpu_loop.c                   |  4 +-
 linux-user/syscall.c                          |  8 ++++
 linux-user/xtensa/cpu_loop.c                  |  3 ++
 plugins/api.c                                 | 17 +++++++-
 plugins/core.c                                | 25 ++++++-----
 tests/tcg/multiarch/Makefile.target           | 42 +++++++++++++++++++
 .../tcg/multiarch/test-plugin-skip-syscalls.c | 26 ++++++++++++
 tests/tcg/plugins/syscall.c                   |  6 +++
 25 files changed, 170 insertions(+), 32 deletions(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-skip-syscalls.c

-- 
2.51.0


