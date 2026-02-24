Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8524CF3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuqC-0000Ul-K2; Tue, 24 Feb 2026 11:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuq8-0000Ty-MA
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:00:49 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuq6-0001WE-NR
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:00:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcFxxAKP45f+0aLN6ppptCFVdBIW0pdbJ9nwtoOIrBh21QnKUKD2V+7+DA1GnBLv0xsIhfn6aKn6SARR5QwGr613cuiUMofZ8AOnabdbqKlsypTlIXZrYlSOCJR8yyzWaYryhk7l4Vrlurn8SAILRtA0HfIiMCb8Xjvlv9MetZPPaCA/3ADQaLST6YRvDYDZdkZVCrUpveqaOxdUsjhWlGFl4RgRojydDa/PY9cLh0JdvmlRyiRrmaR3GC7DtDeAIjhND5doa2W8Kyg8Sed7S8iQOpSONSr+6dugjBRtyLI1R5ujNBQvHjStDl0KzJOpSqk98fpDSu2c8TTVBlKFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMGgn67vpmDE3hQFLmuZunfBNX341dCYj7VQhrcwqj8=;
 b=WL4ZFAfia1r3LjLsz3gqRc3LlWi10QenjJHJ5muSCaj7ADDIndWYVtqaghtejVEE9UbsImo4kqfZLSChKUvlXOn46ySVU9E2XTLFLWM2JSFUeH0bJuz484piIM//Mbz088Tuww/a8P2+k10NLanSabbAmkLuc8KL8gDy69iOBdPm5AYhOGEg2K8ynohFvx/23LHaxdCI/mM26u4Q3e6KIznksWN5S0XNVnZLohTZMqmKzxu9z8f8OkW9ULgTnN7dD1FJbMQCb6+z5loCVSdQpH48x/gR+COt9a37hii1xX5/H3p0CEutJ82b31DKQoTFD0g1vwfaXoByx24SrMA2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMGgn67vpmDE3hQFLmuZunfBNX341dCYj7VQhrcwqj8=;
 b=nen/zGB3/2oy3fbj+yqH+XnbktvZX8gY+vSuQ7H9raC7Kmt89IXCzh6sWxBSjKC+6QatP1DLOzAeUX52l2WxDM/9m+aHp1Zx8tt2NiYAV7FRxnbk+OGzaQGrAGxNFhDg/sbDzSgSTE0twDvRAoujeiGEIvKBqxFcnqM3hIeSJTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:29 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:28 +0000
Message-ID: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Date: Tue, 24 Feb 2026 16:46:35 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: [PATCH v4 0/7] Enable PC diversion via the plugin API
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms040605000509000708040008"
X-ClientProxiedBy: GV0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::26) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 123c28dc-23c0-4bca-681d-08de73bdd465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ti92ZGFNSjdpbmFkamszU05rdXFMR1UzdzlFNXpDVnpBZUg2T3lySEJVWXM3?=
 =?utf-8?B?N3FJZXNPWmRadzdINDNwN3ZEWUJJRXZ0cjBqM3MwZVNtVEZ2SmI3dUc5WGtJ?=
 =?utf-8?B?MENHeWw4ckNhbUE3SE5uSXY4b1Z0SFM1d3J2Njd0VFhwa0dQOFZhU0xvT2hP?=
 =?utf-8?B?RmFOdUM1R2pSeHVZMUQzU1hWSmVaYmFxZ3NYK2NpVDlHVW56MFdjTCtYYjhV?=
 =?utf-8?B?UWpkQ0hteWRXRXc3eXVLTlkrWVRFTFFTUUlEWEdPcThBeGlmdDZUTk1TRUdP?=
 =?utf-8?B?dEo1WDZUYkY4Sy9qWjYwcVFLa1hNbUJ2c0lQYkhvMGhSQUpKUkdhSWU5MkZQ?=
 =?utf-8?B?eUdvSnQvajhXK0Z4N0ZvYVl4cUROR0JvZjF5dUwzRXlOSG9GaTN1cFNnTFdE?=
 =?utf-8?B?U3R6WkcvekFSSmNKdmlhalVDNHJwL3IvNzd1bW1FK0hLTXVlNGpWT0o2TnBG?=
 =?utf-8?B?WlE0bWxKMkdnYlArNitMWXBOd0UxUVhRRzg3blhyUDh1ZEVvczJWTmZvS2lj?=
 =?utf-8?B?MHRQeFBhU0dhUWdWeFFHZUhvTDN2SVYzWExpdklLd0NMdWMwdkpRRk8vWlFy?=
 =?utf-8?B?NHFrSk12dENxaTdpRHovSHNnWWk3VWJhVEkxWWIrMTl5ZjNmdmxwdFRsSG1B?=
 =?utf-8?B?SHc3UHlEOGF2ditQVE52a01uNk5qN1hLalhoeHBUd0cvUk0rbEMzQ09CeExr?=
 =?utf-8?B?aEpMcGFwbVJBM0tWZTRjcFJIUkFDWU91MnB5QzY0YmovOGswK3hFZ1VLMzJ0?=
 =?utf-8?B?VnNmNDA5TXBWS2Rid3hyc0ZCUnpjTFdjYUdxV2FhNS9XbS9qaSs2NjQwNFVH?=
 =?utf-8?B?WUpVc0hRRTRkYkxyYW9GQmdibjFXZzNzVnlIQS9sd0V0RzUxbWoxR1BuOXBk?=
 =?utf-8?B?NmZXOEthRTg1OEROL3V0QVd0MDhxNXU5RVBnYlg1andGMUVKYWRraHVQQUlX?=
 =?utf-8?B?WWlHWngzdlRjU1VLRGtiYjE3Z0hMYkdLc1phdmhYNzVMczNiNWNkVmxFUWlY?=
 =?utf-8?B?dnQ3MzBBWDcrdjRKWHFBQUF4TUhrVG9wVUt0bzRzSnhwbm8rVERKRDJHRGM4?=
 =?utf-8?B?YUhCMUxGb2J4ZGFyMVJjblJtUW9lcVdxUnN5MGZiRmIzUGVaSU1HNFBzbXFa?=
 =?utf-8?B?d3lIZjk3dGJsVVJxM1JscHU2UzZ0VlNSY0ROSU4vMzVEb1ZVV29rblJJMVFy?=
 =?utf-8?B?aFk2UjdCMUhmeUpjREU2QWNySjZSZkwzR1BLcEdtN0ZUUjFPcU1SbGVBR0x1?=
 =?utf-8?B?NU9ZRVFWUkx4V1VmZ3RpWWFwRGN5MEZHU21tR1lPSEJ5WEd6U2U4OEFvbUNC?=
 =?utf-8?B?WXk2U01BMVdjWGZpc3FoNXJnNXV3K3lSamhCamh6SXhGdXQyNVFLWFdoM2hk?=
 =?utf-8?B?QXIzaGcvZG1iNHdqVTBMeDlHU21IVUtIbEoweUs4WUh4UWQ5OW5jcGFaZ04y?=
 =?utf-8?B?TU1kMXlURW4xWkxYekZiakl3REgxUWRuTHEzdE5NWk8raHRheUhGa0k1ODFX?=
 =?utf-8?B?SVFSMU1aWVo2ejBQQm1YeGgxaGJiVmgxYUFETmg3NzhvMG41SlA1ckxCcElh?=
 =?utf-8?B?WndjQm0yMERXcFk5RGdxcVlab0JQY0J5VURWTm5LbXRWSlYwOGEzdVA2RTdI?=
 =?utf-8?B?WWY5TkwxTG04VTM1NkwwbmpLMmJadDVndTlMZEExTTNTdE9WOUpJMlV0UXRk?=
 =?utf-8?B?dzZiUTM5cmNMMnBjUVBXVEp6M3dRZWtFQWd3bW4xckIrYXgvZHBzTzgxYmcx?=
 =?utf-8?B?ajAzOTI5bTN1OUl5NVk4WmRWZ0d5V2V1SGxNQ0VINlA0Qi81TS95NFhCL0I2?=
 =?utf-8?B?clJUbndWUWJ2djZiYlBwclRldllYZ3BleDRtRWcyS3Q0WCs1SzVoODkyYSsx?=
 =?utf-8?B?M0ErempYVXdyL1NTQkpaT1E1Qy9VamVZbGN4dUtIelBqa0xNZXBvaGZWUjFk?=
 =?utf-8?B?NDlJUzBmN1UwRUZqMXhtTkZ2c0l5dEN1MFFQMlNFTEhVdE1KQ1ppUkJpZHor?=
 =?utf-8?B?eXgrUGVDWWRYZnlpeVJUOHNrVGtzMVZHTjljOEl6ejRUak5JN3Vvelg5QkRN?=
 =?utf-8?B?S1NYQXp6Slk2M2pNY25ybkM4WGpWUklITGhsN0Q5UnZQdC8rUzJoc1ZQOTNa?=
 =?utf-8?Q?Mkl8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c013UldNMmFyVmQzOHg4UUdrUk9TYW9lTjhzMEpCdEkrREQxdzExRjhlQlJk?=
 =?utf-8?B?Q0NxWmtOaHNIbWNVQVZMRXZacG0rcStqTk5rNVNMN0N1ZThBQUlUNG1GM1Fw?=
 =?utf-8?B?ODBqT1JSTGN5Z1oybnBkbmNJY1o5eHlFQW9BR3hhQ0RrdzkwTy9jQVc1VDFF?=
 =?utf-8?B?K0xRYU4wK2hQeEpzRmJIT29pam1uaDF3MUNTVlliZDgvMTZNcHVqazh1WVhO?=
 =?utf-8?B?NHpFNEhQUGwxbEFoeHBRTjhTRnd2K0J6eG1nSy9EcmVUZldlcXFnMGxIdS8y?=
 =?utf-8?B?eDlDeG9oZWFtMnUySWhyNEN1ODJLQUUvYjRRMjUxUjU2eksyQ3k0M1ViRVRt?=
 =?utf-8?B?YnNrSEc2UFcxS0FML3hZeXFCM3F2S2xmRUNtbUlXajZZSURNVWFlZzN1US9L?=
 =?utf-8?B?WVlCdCtWWS9yWmo4REZJOHRQaE0va3lxYTUyQk42bnVlTW5IRzg2clc5MHVM?=
 =?utf-8?B?LzZ0ems2Y0tHbEtjcFV1YVdNUUFKNzNKTFBFQldxVlpHR1BPS3J4UmxTMmcz?=
 =?utf-8?B?Y0x2cDUzdmoxbnZTYzdjVDVuRGVPOTJoUjk4Z255dmw0ZDRUa0RiSU9TZ2dr?=
 =?utf-8?B?ZG1xTyt6cE04b0FwZEtCSmREVWpNdERxbDBxWnc5bXE4bWxlZG92YlAwYUtH?=
 =?utf-8?B?TUNQbmdXUTVSc0RaS2ZRaGpWb05DcEFMUVdaeXZhRUYwcHFHcU56dkJUR0Zr?=
 =?utf-8?B?Q3dTUnpKRXRSNnJDUkhLSkJFTEcxMy9ablcyNjNScmFJNXVCdFpyWVA2QjZw?=
 =?utf-8?B?akl4a3llK3ZaWG5acUIxQ1RBSkpKS3ZEZDVvUm91bGhBVzlpREYzRDFHazlk?=
 =?utf-8?B?R2hrSG9nMjVGTmpGYkZ6b3pES0FMTWdzdE9CaXBhYWpxSDRReC9CSStlRGJE?=
 =?utf-8?B?MmRkWXZXYjNPcWd3WE9GSWh2b1RpOGtIemQvQzBBRlF5SEVaaEJodmpMdDBy?=
 =?utf-8?B?aUprZ1EweXNSZnAzQ2VBSG8zNFk3RHE2OWc0eFBTd2hLYlZzb1J2SlU1R3ZL?=
 =?utf-8?B?MlhhY1BGL0x0aVNTcjlsUC96a280TXNCRlkzWXJqQWQ1cHhQYUxHeWNROEdZ?=
 =?utf-8?B?OEZ1K053VnhBTGcxaXRQTXpTY3VocG5sWDJEbWhoN1lVRG5HQUZiYXIyY0N2?=
 =?utf-8?B?bGhIRnhkdXRoU08yM09sM0hSRjlwdmpNUFg4WElnSFZEM3J5ckQ2clZCanNw?=
 =?utf-8?B?ZHppZkNTRlN3bWt6NHNhMG5aZXlyZzNYc0NidDNPUE9YSUNSclhMZ0RHYWhU?=
 =?utf-8?B?dE1iY1VkaVErQzRtT0QwNkVEZjhwelRUa2xkVk9YdnNSUWJkdk1WcU85c3hR?=
 =?utf-8?B?L0dHb3hENGlHVGYrSUlNYUZlZlQrRjFFRnBvTVFPMVpGTkE0VEQxQTY1Qm9S?=
 =?utf-8?B?aEk2S015ajZrRnhya1NsUk1kZ21CTGxobktMOU1aOWNoLytuUnRDa09CcHl6?=
 =?utf-8?B?MHdSYVkxSS84QUpwd3N0cHpNZkJna0NQRGkySUo0ZkpLaTFLUHlOUEd3c0ZK?=
 =?utf-8?B?MW9icUdYckt5d3hWejdWaUdJcHV6YzNaN0JWTEc3Z0dsM3VlcHJZRFlJcUFl?=
 =?utf-8?B?dnNWT3Vqb1JQYVlTTnBFSGlJYnFkTnFrTlZpZTI3SUxVUTdXSXVzMTNjcHlx?=
 =?utf-8?B?bnVacTM3SEdsRXBrY3IwcklPWWJxSHNjMFM5OGZiSWcwYSs1U1FETVNCMTJx?=
 =?utf-8?B?b1hwUGMvMCtMTUxDMU12Snc2VXphRFpqWkpvSXVlZVJnNGhSV3FBdnBhaXd1?=
 =?utf-8?B?c3FNTi9hY0E3QXQxSVo4cHVYNHRnUkNHU2RvbW1NeEhuSXpHR2FDeU43RklD?=
 =?utf-8?B?aFlER1FET1VtYWpGeWJhbm5mRUVFMFVBUTUzMFUvNE4wYW9GS0RhSDYzM3l3?=
 =?utf-8?B?ZzVBdmEzUXkvZ0tsdjZBRDN6VFl6ZlBxZllyTkZBUHVWcjBwd2Z0TUdkVnR1?=
 =?utf-8?B?dHdEczRYODlxWFhTNkg3NTc1eEo5QmYxaktoTFp6Zzh4czFyeXZuRExjWTJ0?=
 =?utf-8?B?T2tiQkEwdFZhZllZWVMzbjhCNlFSVHBtd0xkWndTblByNyswaHhBeDBtQ3ZG?=
 =?utf-8?B?SkdRUm1neGcrWFdPdkRsSHVVVE00K2tWMWVoMnBuL3ZMU0RMK2wwbmFHVEVu?=
 =?utf-8?B?di9pSzR2TlFHVWxDOE5NWmwzeHJIbG1MU0paS2NHVG56RzJsclhQck11emVI?=
 =?utf-8?B?YmlTYXpVU3NWMW9PLzZ4ckNzRHdpLzFzMVRkeGlVdlV1QjNzc0d0TEE4aTlw?=
 =?utf-8?B?anlxMjZEbjdXNUNSbElSUk5waThNNGxjODNmMENVOTBjQ1M2ZnFIWm1Ma3pL?=
 =?utf-8?B?VUZveGtCSGdFUnYrSWtrQS9GYUpzUFdFZ1B5VWR0VFZ2aDc0SStMdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 123c28dc-23c0-4bca-681d-08de73bdd465
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:28.5652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLVIWxxOXoi7MkcBSht3aqcSEqIqsPRYJphSRNsBzXdMmP8P93qERbOXlJYS8uWqIFUZFlp45wfB9Fy/nGAJmtGszZ0tF/Qbl+N5bQkdtWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

--------------ms040605000509000708040008
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

This patch series builds on top of the discussion from the thread at
https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@e=
pfl.ch/
and adds a plugin API function to set the program counter of the guest,
as just writing to it via qemu_plugin_write_register() has no direct
effect.

Based on the discussion in the above thread, the series also introduces
a means to declare registers as read-only from the plugin side, which
prevents plugins from writing to them via qemu_plugin_write_register().
This for now is only applied to the PC, and finding the PC register is
done via some rather hacky strcmp()s. In the above thread, we also
discussed encoding the read-only property in a custom attribute in the
GDB XMLs, but that would (1) make syncing with GDB harder, (2) not cover
all architectures, as there's not an XML description of all
architectures available in the gdb-xml/ directory, and (3) require quite
some changes to the whole GDB infrastructure in gdbstub/ to even encode
the attribute in the correct structs and pass them on over the different
layers up into the plugin API.

This version v4 of the patch series is more about small refactorings and
cleanups than changes in functionality.

Best regards,
Florian=20

Changes:
v4:
- switch strcmp out in favor of g_strcmp0=20
- split the patch introducing the qemu_plugin_set_pc() API into three
  patches, two for preparing the plugin infrastructure and the syscall
  handling code and a third introducing the actual plugin API
v3:
- make PC registers read-only across architectures
- add tests for read-only registers
- adjust test structure for qemu_plugin_set_pc() by moving
   architecture-specific tests into corresponding directories
v2:
- add setjmp() in syscall handling path to allow PC redirection from
   syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
   exiting a TB would not be live anymore in syscall handlers)
- add flags to ensure the qemu_plugin_set_pc() API is only called from
   contexts where the CPU is live
- add test for qemu_plugin_set_pc() API
v1:
- initial version=20


Florian Hofhammer (7):
  plugins: add flag to specify whether PC is rw
  linux-user: make syscall emulation interruptible
  plugins: add PC diversion API function
  tests/tcg: add test for qemu_plugin_set_pc API
  plugins: add read-only property for registers
  plugins: prohibit writing to read-only registers
  tests/tcg/plugins: test register readonly feature

 include/plugins/qemu-plugin.h                 | 18 +++++
 linux-user/aarch64/cpu_loop.c                 |  2 +-
 linux-user/alpha/cpu_loop.c                   |  2 +-
 linux-user/arm/cpu_loop.c                     |  2 +-
 linux-user/hexagon/cpu_loop.c                 |  2 +-
 linux-user/hppa/cpu_loop.c                    |  4 ++
 linux-user/i386/cpu_loop.c                    |  8 ++-
 linux-user/include/special-errno.h            |  8 +++
 linux-user/loongarch64/cpu_loop.c             |  5 +-
 linux-user/m68k/cpu_loop.c                    |  2 +-
 linux-user/microblaze/cpu_loop.c              |  2 +-
 linux-user/mips/cpu_loop.c                    |  5 +-
 linux-user/or1k/cpu_loop.c                    |  2 +-
 linux-user/ppc/cpu_loop.c                     |  6 +-
 linux-user/riscv/cpu_loop.c                   |  2 +-
 linux-user/s390x/cpu_loop.c                   |  2 +-
 linux-user/sh4/cpu_loop.c                     |  2 +-
 linux-user/sparc/cpu_loop.c                   |  4 +-
 linux-user/syscall.c                          | 16 +++++
 linux-user/xtensa/cpu_loop.c                  |  3 +
 plugins/api.c                                 | 43 ++++++++++--
 plugins/core.c                                | 29 ++++----
 tests/tcg/arm/Makefile.target                 |  6 ++
 tests/tcg/hexagon/Makefile.target             |  7 ++
 tests/tcg/mips/Makefile.target                |  6 +-
 tests/tcg/mips64/Makefile.target              | 15 ++++
 tests/tcg/mips64el/Makefile.target            | 15 ++++
 tests/tcg/mipsel/Makefile.target              | 15 ++++
 tests/tcg/multiarch/Makefile.target           | 22 +++++-
 .../{ =3D> plugin}/check-plugin-output.sh       |  0
 .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
 .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++
 tests/tcg/plugins/meson.build                 |  1 +
 tests/tcg/plugins/registers.c                 | 68 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   |  6 ++
 tests/tcg/sparc64/Makefile.target             | 16 +++++
 36 files changed, 331 insertions(+), 41 deletions(-)
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mipsel/Makefile.target
 rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (100%)
 rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (100%=
)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.=
c
 create mode 100644 tests/tcg/plugins/registers.c
 create mode 100644 tests/tcg/sparc64/Makefile.target


base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
--=20
2.53.0

--------------ms040605000509000708040008
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNDE1NDYzNVowLwYJKoZI
hvcNAQkEMSIEIF0BmGi0MIxx9qTludL4M5aparGhrHpNkYG8qT+5CoSNMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAImPSQA2aluKWLgl61URXUIfMuYr
2EbZVkfMQ162gb7zLk9OBpmQeTXaNByHuaxUlZHOi6XTb5hgeKVEAXvsQA51/i/PSRl0U0PZ
jCXfKqQ3vtzky7hnvuFcOKFa2gHKk+SO+7w3T1hTB/m9lsLn5aTL1RRCMM3vCGekcAVEYy2Q
axAE1qiQElGKAfXdmrMaSXZKL6WIpbYnKMp+hq+RA1qHgGoFBqvLaprEkAtZRiX80zsuCe47
jnmIOWya8Qw/tv7En0+hOO97kL5ufW1zkgbN01eAKJ3QWOv/wKOy9HJKDggXMCKxlH42yCza
cMSUQkaYVV5B9KXRP7/sDwhMUQEAAAAAAAA=

--------------ms040605000509000708040008--

