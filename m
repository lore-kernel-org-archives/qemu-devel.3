Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E4FC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpL-00080K-57; Wed, 25 Jun 2025 15:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpJ-0007zj-5Y
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpF-0003Nd-2I
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:32 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PHZeam021791;
 Wed, 25 Jun 2025 12:30:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3VtVkOj29BrAPqtXIVFu08O9WpDLdbR+Xej4jNDew
 wI=; b=BPwKQyW2EBPLVIRSMeo7TZBleO9w674KHEIZLcTPPEgLNrmiqJOmcQohU
 eoObcVDEnJOktas4obpIMc3P56ikVD+yK1NC1OC2syhet6bKVy2PvgmS50qwRWQi
 iWT0oqZng7B6dPXAFc3mCbAR/R1x93fvwVgbdOIeQgtNesZO0PTgQ8Rwf1aAMP/P
 Hi5cIzsdpis+0c42rtwezMcPasDNLz8LRVLs+R5AR5hWOD2r9P9h51H0rkKjWgW1
 3/CmoWG+fNBlZaxrRHjRn1RaP+Xv9K3UmxSpeaX8jiDhE+c+xlLqjKfcpfB/gNDX
 bM43ubrdeBRkW6tbP+w7dC8EwI4kw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2116.outbound.protection.outlook.com [40.107.101.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47geghhf81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSRy2YNcRlT99JJ2UFWoroXVlOC+pCJr1msjXxxLXCr9q9P3R3r2IgJ6sBOGeLZ37/8oSN4b9p5nk0JbD5nndTL2N2pNkaOD9McnDxqjJO4nPl2rn2khXPHqW7Qhuq6mhIk/8sby4iI3DlQPOrbhUWCgWoYBkDXWaVW5ObUoG5TRPfQBDcKI9QCqT3AGkdg0yfKkz3hXalECSEFG5lAP9i0RS0VPprXYbucoEzrDw8JrsYVEjgsdDOwNnR/1BnkE+Do/xC0wztXYu+sPHnBBpgSMIIESG9/zfaLdHAKj/Ryckmfm1YaLSuZM0icI8Dk7lsdrnQfyNvjxWnaqxcmQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VtVkOj29BrAPqtXIVFu08O9WpDLdbR+Xej4jNDewwI=;
 b=KRgTvCWsZc99Bx05Mp7uh3Z9ehKMhPd4gWo+6+5UQjpTM5ri2eQuHkoNFVfPPlt9ZGnMwt4gyNm8mgUglXSemWa1ZEeK/Y4VWaBySH+qO6fd20+mzVqrobX2Tio3r4vyvGbi6rCtm2orukimaWhhRqkqR0IfbazhYeG2L1XA+PoWzKwmCpH19latACZZpoAcCvI4qBOQyQw7xrJDcWKeZcjvwjTr2AeWz/drigvRprx19npdbmrhrtXtvvftL+qphfQxcFg1Khp7nHotrzVywjv8HxtlWqhsMHO7WSfLNtRZ+ZrUBFMLOYNnYYS/jAFW9z/OOB4B+tqWw6s83fx8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VtVkOj29BrAPqtXIVFu08O9WpDLdbR+Xej4jNDewwI=;
 b=s1BIfsJgirOU/mR/XAf1DwDxBnnzvmRYE/L0iXzcUxENDBgv9FYDbofoI5zcE/lW0uCz4d0BbJxZymQB/AkKy4MXirstFis9cy06sFAa9uiXzFG0yjzfOZrWRFJlIndLJcqBMCL3g73viaVCoUXquvcb/tUSTNXwDUNIGuyGc4FOWH4P8QoqHMXnZS4jRynotUMm6/0SKoe/oQBWl26rXQ7uLB/wKM9T9wkxWh1LT6tIXJukHXat6L7p4lD/6fqJSP0pOIUHHNAmsc14qjbSmscysQohCo6VweKk2bis0NR7ib89QlJAuXwV0AQlxgzgTjn99Xs1z/a4KQBKd25GkQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:25 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 03/19] vfio-user: implement message receive infrastructure
Date: Wed, 25 Jun 2025 20:29:55 +0100
Message-ID: <20250625193012.2316242-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: c48ba999-3f96-41cb-4919-08ddb41ebbf3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFdnVG50Rmp2TGRSR2xNQnA1MGtOYnBSWVRrVFFJeDM5QWdXcC9YU29aeE83?=
 =?utf-8?B?b1NwdTVSbjh0bks1YlFQSXoxUHZNYVlmVTVRV01iOE1udkNYL0dLMWtydHJq?=
 =?utf-8?B?RWp4dFRNR1R3SGhHRU13VVJVMHQ3OEJ5V1E2WS9rUytGZ2lULzNMY21acE0v?=
 =?utf-8?B?bklEM3JjSXVtL3VYRW9KYWxwdks2Y1BYSDhscVZGSnJna1RKSzN1ekJuVEkr?=
 =?utf-8?B?MXVuWHp4MW5KNVZNL0JQT0hjMUI0bFkzVk1qalJCaEFTbFVaVmNGRHVhMUhF?=
 =?utf-8?B?RXNUM3p0d3ZZa2luRTRsTmRaYnpYZUcybEV5L25xaUNpVm80aFZEWTFwT0pq?=
 =?utf-8?B?alFUVFF1RUZCdEQydHdXN0dyU0xlb0wycjdZM2ZaYXpBZmtJNVJLSFNBZmJh?=
 =?utf-8?B?U3o5aW43UGk1YTJEY3E2aXJ0Qk42Q2VSVXJqdjV3L3d4Zmo2ZndrbW91S2tP?=
 =?utf-8?B?QlE2a05wSzJkWkNaMUorbDFlTUFhYy8xY3ptZldhU2M3SnMzcE54b1ptZEY4?=
 =?utf-8?B?TE9tUHZoQlhVOVcrSkh0bTRXdFA3emxZamJhY3J6eHVrUlRTUjJES2kyR0Ew?=
 =?utf-8?B?b0Ziajk4aTZtR1VXcjAvMWsvWFlyU0JUSGI0OUVuL1o0NU9VUmpsNkFldWZQ?=
 =?utf-8?B?cFJIbmlpNmVPbFhVamVzZEZZYTI0YnpJVVAwbWU3a045Wjg3NXhNMzFvL0Y5?=
 =?utf-8?B?NkprczA5WE5qWGZTMnVHZWhDazljMGUrODRiSGhnaGFPcGNzOVRDcDN4RWNu?=
 =?utf-8?B?UVE2RWhQSisvQ0Z2ZUY3b2xCVzdMcDRBQUNFdkVoUThQNnp2NHV5bGNtVjNz?=
 =?utf-8?B?MlZuWnlPSGg1OG1FaG5aeWZLMjFuSVlPL1ZNZmFUOXFSYVFKVkNyRjJIZExZ?=
 =?utf-8?B?TkRnL2RtcHg0dVhqdTdEMDRFdDBGSUo0cElQdGViUlpVdThvaW1VYXR5azVF?=
 =?utf-8?B?QlZKNlJsc0I2QUp1QzllRnhacC9rQ3hmMDhOckZnZ2d5RWp3YSs2dENGaHU2?=
 =?utf-8?B?RXdXOVNNWTAwVDd3R0hzbEZKQk8xSTdvdit3bXpjTUNaRndUdVFVQnkwcVRW?=
 =?utf-8?B?YzlwREV6WVBWQy8rUEl2TkJJS0xjNGdHSzdkN0h0T2t1WFhsVW1LdFVuQk9B?=
 =?utf-8?B?amhzaXhTdUcwVitEcGZiWVAwM0xjRUUyS3B5blNkNFdBbFBxUjhPSVBRNjFG?=
 =?utf-8?B?NEY1NWhZRzFqTzdCdzBNVEZjamNreUdIejZEc3EzOC81WDF2RU8vWHBOaHFu?=
 =?utf-8?B?MHY5SjlRMzRMKytBbHREeEw2LyttMDE5T1dxOWVSdDhQT1lMV3NPRkIrRXNj?=
 =?utf-8?B?MXo5RFgxY3JLQkU5WFd6Ty9CSXRNcnZVR0UxTURqUjZ1eU5SOWJJeUViNVdk?=
 =?utf-8?B?ckMrSG02VlVHVGh3dlBJOStpSjZPbFlNZ1Q5ZVo2YkdTbUg5ak9vVkROc1hU?=
 =?utf-8?B?UFJqWHJRazB0aUM0N2pPNG5yWU5MWnNyWCtpSnBnOVdHa1NZVXpwcDh6bkVq?=
 =?utf-8?B?dE1DWkN6MEh3TlkyNWtUTDFhSllEbVhQQk1ZQ2RMaHdVK1NhY2xEMDRRS0xr?=
 =?utf-8?B?dUhXM1lzMDZUTmpLR3RNc2o2OVZJYjVJU2FZYm5xRGNjU0txdFl1SVdOaW5C?=
 =?utf-8?B?ZEo2N1VIK3QzT2pMWEZ3RUpmR2RVQ3VsMU0xZERObk5CSHNJUEFCSzBiTHVL?=
 =?utf-8?B?Sm92SEhSVm9nSmtwZHdwRFlkeXRyVGFwN0NNeEh5TUtUWlJCNGk5elpSR1pj?=
 =?utf-8?B?b3ljU3JTeEd0eTdNYk1JdjlDdFJEMTVFdmxvc21sZG1vV3dseFRCVmpLWDNZ?=
 =?utf-8?B?Z0FJZEVSaFlldkJSWlFBNU9ZeWtBUXJMMVBGMERVbE1EbjY1WktXazVPa054?=
 =?utf-8?B?UFRLbGJEa2w0TldNWTFCR0pRcG1DdEhrY29ISFBtOUZ3VXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVocVdBaTFxTmgrMmk5WDcvMDk1cmdPSm1aYW5DZWZzSVFsbjFLeXVmNllO?=
 =?utf-8?B?Q010VEFTbWx1b2pBM0ZKNWFrMVlaYjVmbnRlQWdDdEdRMlAzUWVIY0lWbXI0?=
 =?utf-8?B?eEFuVWdUbFFibnBhaU90eEQwbWR4UFhCN0tNdzhaRC8wYlo0bW9jcytHSTQ5?=
 =?utf-8?B?UC83QVBxR0R1bkQ0Y004Wk1UZTNMbDJTc3RzYnJKSkVLcW1xQnJpOXhBSzI2?=
 =?utf-8?B?c09FVVdFNE5USER3ZHJlTXJITEhvVloyck96RElxUm1MT0l4YTlOVk9wdXAy?=
 =?utf-8?B?bUlHbnFzdmdZY0FHM3BqNlFNeFY1c01PaFd2USs5ZzMwY3R1cVJVN0VRT0Nm?=
 =?utf-8?B?YUk3M3g1YVBzNi82VEZJVGN3Y1NzMk5meXQ3MWFGd2NaaDdRRy9tMjY0Qlc3?=
 =?utf-8?B?UWJJb3EzZWJYRkJvTnArMmp4MzRTODVuWlVGTkNXaEtwbTVNcllkSG13Z1M4?=
 =?utf-8?B?eTdEeDNtcU83U3ErOG1zcU1Ec3Jmc1MxVm1mdUFuaDRUU1J1NStIWTFVKzJT?=
 =?utf-8?B?T1VYdkJEY1dZUUFrQnhVSUpzN0ZGRjhjZnc2cHFnbkhTekUxdWxEbGxNSXZk?=
 =?utf-8?B?ZHFpd2RWL1gzMnBsRkNwcmZSMm1PTmRPMy9XOEt2eGVsTWx1cGdGQyt4cG5H?=
 =?utf-8?B?K0k2ODIxaDZPcjBEYW9PWG5qcmZTSExSVFZ4ek9pdzRneDRQYTJhbzJCWFpF?=
 =?utf-8?B?K2hoZHA0OWtvYWJmbDVOUjUvNnh2SThVMkNuRUlDWDlPd1k5K2wrTEJ3ZXRV?=
 =?utf-8?B?N1hVazUvTEdhd1kzSXhIZ2prdjZNZTd3UDZQNU00SnMrbFFmR2xvcjNndU1L?=
 =?utf-8?B?YnMwKzhwNEJLRnNJd0NUODlyUHdOb0VrZEdzQjVmMWVFYkV6R2g2RERqb3Ez?=
 =?utf-8?B?eHhjeTYyaEI0eDM0Y2g1RUxlNjR1bXMzbUwvWHJNTWx0enFBYWR2eDNhTVQ1?=
 =?utf-8?B?SmQvSXdHRElZS1lMOE1OckluTEd5aC96QXZOTUJUZG9GaHlqeERDOTc4M3VE?=
 =?utf-8?B?UVVxcjUxNEtwaTQwT1p4TDZQTkJYMnBLcmlXQTVhekJBdDZSZTUxM253UFVZ?=
 =?utf-8?B?K25GU2Z5SFNmR00wSi9oNHBUQW8wRWgwdmRxdU1laWJ6SXVheUhHZ3VpRVp6?=
 =?utf-8?B?M0lGdmRpWkZnYU8zZTUxMEI3eWZjTXJFSGkvZHlQRWZnMmJ2VmVpNVIzY3FE?=
 =?utf-8?B?bXdlR3doYWRJNDFRL0FjbVFwLytJa1l5cDNzSEZqOFlPcTdPSkJVUzRsbnA5?=
 =?utf-8?B?ckxQYitsL0czM1hTS1hRWkEvRGxHVkxWR2xJYXBZUk1oT1JFUXhzZk5VWTNH?=
 =?utf-8?B?UmN5QkFidllWSHZFaVJTQzhLb2hDbGFMTVZHTWdubmpKUEZ4WTNVdlQ4TFVw?=
 =?utf-8?B?K2YwNTJFZnk3M2FuSDZOVjZHYjlUdEkwY01wWjZCR1VoOEl2SnM3RFlqYTdE?=
 =?utf-8?B?Umk2Nm1aQWx3a2VvRWx4UlJrT1daUUFDWUt0L1drTlhhOWxoWTFkU1VqOE5i?=
 =?utf-8?B?Z3lCS1JWVkJSM0FGVnNRN0JKM3dZUEJPQ2oraUZpek9rMDlRR3AvMVhQVSt5?=
 =?utf-8?B?ZmRzMkFIcmFBY0xyZXl6Tmc4cWtZNUtHRW40QjRBcVNUbVF4NCtzM1pZWlNB?=
 =?utf-8?B?c0NDRTRrOVZnYTI1Zy9UY0ZQbGZrM3pFb0RiaU04MThvSEdxd3BiU3ViajYz?=
 =?utf-8?B?WVhjYkhITktkRlVxdE4vSzFZZEpzZGw2cmdPcEc0RnlhZEsxc2NGelYxeXp3?=
 =?utf-8?B?bnRyZ2ROeXBkVkFLMTBRQUpRUmRmdG1TUSt6SWxzMkZJSkgwMWJDQ3ZXWlBU?=
 =?utf-8?B?Y2FqZk04NVoxMm1BSWRIOXRSdUZkcGtsbURlZHJzNFBFOVZ4ekRERmxRclVl?=
 =?utf-8?B?KzI5TERpWW1ER1VTM09vVzd1M2YwcUhKR08yeWFkTHBRKzkzZUFSNXNpNlB4?=
 =?utf-8?B?QnBqT3NxbkpSZGxVWU0zbE1KSi9ZV2s5eDZOUWdBRFcwZnRQUHcva0s2dDU4?=
 =?utf-8?B?UjRzY09Sb01xeU1DcnFESnR2SWpjS1h6YTE5VGMySkxxeWZPNERXa1czMjJ4?=
 =?utf-8?B?aEVFT2lRQXNRc0w4VDBaZy9sUzBwNVJmWkE1YTVNbDZXRy9XaXB0WnhLZ2dV?=
 =?utf-8?Q?4VnVQJhG5YwVuY3liSqM//Y65?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48ba999-3f96-41cb-4919-08ddb41ebbf3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:25.5047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8fQONLugRwqjKXGjISb59biW/6ENmCINQcMKpeK02EaGqMDdJokFgXWM0u6qr8PmA/fYZBi1KOHP/m+9hisvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=fPo53Yae c=1 sm=1 tr=0 ts=685c4e53 cx=c_pps
 a=5QP2e45hYM+ySLztt10wLA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=vXCtUE0a-urccVGwgxAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hKfbrgoDFGcNo9hNAd1RJdG_HFGQDYX2
X-Proofpoint-GUID: hKfbrgoDFGcNo9hNAd1RJdG_HFGQDYX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfXzPiSSi1p9WQD
 bb4a/pWbvjWmy9Rs9GtP50PonMd1s970oVTIveV5SCrJlDYqZS2BorpATE+fhNvFGENrlxP1Mfv
 RnGI6y1Nas9AzPIkcNZk1kFS8LqUoetcAFA8nhA2ipdMF7knkNHa25UnKxxVIJNEFMxlLDjaml6
 8+3yKT7SsN8ghg6ImAEPAuuVdnCmfn9MHOfR9ETh9NXWXD1cKfAD1bcDNecamyeBP3js44UxKLB
 MDRKOtBfBO0tkPekkk2+tZbO2dkKJE8aiovQhNJEoZFwGvT0Qcxpm0rHHHcfHfBNNZ4C0paXWRW
 0XOwmkmq7/L1l1BbZq3CFORCcnF4JIvjx5Rqwdq3G+qgFZQHHQo2YQSW07Jbk5BSz7oQS7PQy9S
 1vL56v6duKEFLzTaQ1xgQIYtkJvTXynAAnQIuFg5gx7nMYWoiPi6ZKVQkHAEjP7ZzkjgJ5ix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
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

Add the basic implementation for receiving vfio-user messages from the
control socket.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 meson.build               |   1 +
 hw/vfio-user/protocol.h   |  53 +++++
 hw/vfio-user/proxy.h      |  11 +
 hw/vfio-user/trace.h      |   4 +
 hw/vfio-user/pci.c        |  11 +
 hw/vfio-user/proxy.c      | 411 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   8 +
 7 files changed, 499 insertions(+)
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/trace-events

diff --git a/meson.build b/meson.build
index 4676908dbb..dbc97bfdf7 100644
--- a/meson.build
+++ b/meson.build
@@ -3683,6 +3683,7 @@ if have_system
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
+    'hw/vfio-user',
     'hw/virtio',
     'hw/vmapple',
     'hw/watchdog',
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
new file mode 100644
index 0000000000..4ddfb5f222
--- /dev/null
+++ b/hw/vfio-user/protocol.h
@@ -0,0 +1,53 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index a9bce82239..ff553cad9d 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -12,6 +12,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/sockets.h"
+#include "hw/vfio-user/protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -28,6 +31,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -67,13 +71,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
new file mode 100644
index 0000000000..9cf02d9506
--- /dev/null
+++ b/hw/vfio-user/trace.h
@@ -0,0 +1,4 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "trace/trace-hw_vfio_user.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 642421e791..bad2829f5c 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -22,6 +22,16 @@ struct VFIOUserPCIDevice {
     SocketAddress *socket;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -80,6 +90,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index bb436c9db9..349ea2b27c 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -11,15 +11,31 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/proxy.h"
+#include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
+static void vfio_user_recv(void *opaque);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
+
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -32,10 +48,343 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, errp);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 errp);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(errp, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(errp, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(errp, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(errp, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(errp, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(errp, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(errp, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    return -1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        Error *local_err = NULL;
+
+        while (vfio_user_recv_one(proxy, &local_err) == 0) {
+            ;
+        }
+
+        if (local_err != NULL) {
+            error_report_err(local_err);
+        }
+    }
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -51,6 +400,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -89,6 +485,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -99,6 +496,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -114,6 +523,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
new file mode 100644
index 0000000000..ddeb9f4b2f
--- /dev/null
+++ b/hw/vfio-user/trace-events
@@ -0,0 +1,8 @@
+# See docs/devel/tracing.rst for syntax documentation.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# common.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
-- 
2.43.0


