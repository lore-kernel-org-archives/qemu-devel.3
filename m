Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40670EDF143
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvod-0002pd-3z; Fri, 13 Feb 2026 11:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvoc-0002pP-IH
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:14:46 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvoa-00087z-Qr
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:14:46 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7m6Cp169814; Fri, 13 Feb 2026 08:14:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=g4iQs8fO6nD1nBphmEJKc18kPClzKK4uR1mkxbDt9
 J0=; b=oKmv5HOQaPXqANeExfdLzfWFddUhZNUTcX+21OQWkFJDM4ha/QGc7dsJ+
 8NPE3OLotcIAs84Ue8JYuaVwz/AzAL4S3djZnTpzW794RHl+m2BpNt0M5F9Odqhg
 WZqgZPKaLGprebfBprzr/M9jOMHUyMTiLx/nxfpkPsdpTg5SNyvI8nadKA9v8Ic8
 od7O0MhVcruH7UIViIbICSAo0LXeWy9d5yXvxczjQcYEHlHEFzzgydXtPvInjScR
 K+aMZKWs3aAZirXEs51rEG2p/7fTteSnE3gqytgG4KSstEx/dvJHcLilhscjmzVA
 JFhKEKIiqVKN6nT26eBN9EGL8b/bQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021081.outbound.protection.outlook.com
 [40.93.194.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9yvvs5kr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 08:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMV/LJ1vZPGT8Qd3mgxNPFIyn2k4gztEWVdlCH8xfotHRzCKKchAauHkirqRAZiHqlUZkAtEEuo1b30MN8WwMtlt7STAG4rHWe4xFo9p5AT+KzujLkChGkr/N27ceN1K2kiRmBN8yebom9agX8foA4TXlEAUo23x3tDlcvjE6cpF0kQriFsY6w/HiGjEREVJav4ejRQhMUVxAaJ7+NPefcOVj45PlMHSapnMoELeQBmYUvxq+bTLG73fFPh9Tn3uBIKDixtrp392vt/m+DSHEcRgvAFmvKuHDkLrPKZR5G6zh3XA3tw2TGMTQmzo3iS3f+a/0OiHBrvcMMOEi+DtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4iQs8fO6nD1nBphmEJKc18kPClzKK4uR1mkxbDt9J0=;
 b=cHA7I6CxRYZz0E4GTEiPAGbJ7NDbjcrSWwSlgMWl6TUwhN3mN3pWaO/QysMTCDZzl/W4yR8CR+tCktpgSncGB1QGFIOCAWGLdmRYpRaQHUyfkvRjvICWFY5gGTYhW4RzuQdRvH7hBezQHU/EllfnOVkgkgcjeJmKtWDUSHeXrZmFymiN8VcEG1choEdFskBTtQb9ClaxYsFBoJLh4VvV71bCZKyYthqKAbceEqIntK0nCNxq/DmQBGO+NbAZUxmgENmUbZERga5U0+QSuwrl29R55gMwrJns7A19YANk8R9aM0AlA7veee/09VyWdslKCjVlU8wPnW9iTNoVcNtAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4iQs8fO6nD1nBphmEJKc18kPClzKK4uR1mkxbDt9J0=;
 b=GUr/uOv8cafWjzqpl20kCJYAH+EQY+5RkyMzXUTVkgF4N9s2n+Dm5qwZaNYvQmA7+zkFGU02UJlnULS5+R3XR3TVgd2MFAI4u/vk+i0BQG3GnF2+8xFMP7GE0bD94jcklfjvGSQ3Tx6yNxWC572B42DUjYD0Ya8fTOGACrcpJfQt7KSBFp4iv7WmY+C9+W13Xf2JZisE+ysTEaf72nYp9lcrk5cvc9wBZw4f5HAflRK+wksufsnADDaoEGmNTCjJ9WEL5cqQnkHU22H9b/3fnl9ZJtWfMqJXggVaq7ZDGCH+VVkgs1O9TgFpOHNT5l5nn7MXy6k8SpIx5Rk3zA+REA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:14:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:14:41 +0000
Message-ID: <d7db1893-ff73-4d71-873d-ba98e0a59abe@nutanix.com>
Date: Fri, 13 Feb 2026 16:14:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/43] audio: remove AUD_log/ldebug
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-43-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-43-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:610:38::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10249:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d38484-1054-48d1-4fc9-08de6b1afe7c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUdQSFUrY2RLMHR1dnRmNkdCYzFuTGJnRkJacy9wL1JVaDNoN3Q1ZGZqbm5J?=
 =?utf-8?B?Y25JYzlHcHpkOStQS2k4MkpxNmx6RTYwcnlUd0dkamxoUzJSb3Rha3cvYVlG?=
 =?utf-8?B?aCtURXIra2xCZUdlVWU4emxMMlNzQzJadURrSHNRb2s3dFhwM3ltQ21ySGhJ?=
 =?utf-8?B?dU1VTVhIM080WlFKb1FzdWxYTElySld5YkxBNTR0bTM3RWxoN3pVTUc3RkUy?=
 =?utf-8?B?VjV2SUl6WExOL0xEWjhOR0N3ek5yckQ1VEo0Q3VTZEordFJQM1N5ZmlPdy9C?=
 =?utf-8?B?U01EUXZvMDdWWHlXaTh4aDNlMGhwM0FyNzRaODRmNkJ3Z3ViUUJWb2VPUnhS?=
 =?utf-8?B?TUUzVUpEeHV2SS9NTy9Zck9IRmI2YjNWRStZS3o5Qit0Qk1mL2owUDlMN0pp?=
 =?utf-8?B?RTRtc0tmR2NPcEhCVFhZVWdhbTd2Smt2ODczVUZkeWtNekFSWmtGcklqRnJX?=
 =?utf-8?B?VW9lS1JIMmpNRzkwMy9KcEw3U1FNbUdyWjRpTElKLzdMdGpGUFpFeDVZYXNk?=
 =?utf-8?B?WWRiSTcyTGd2Sk5LUzhLSUpJcUk4NGVpa2RjWHljYTdWV3RFOW4yazQwd3dy?=
 =?utf-8?B?S2x5U3FjMVl0L2pFV1l0aTk2OGU2aTZNNWUzbFA0K0xtRXRFaVZnb2x2MlVB?=
 =?utf-8?B?VFZra0xUZ2ZTZkhlYXNZRnI3RnRjZ0t5b2V0dTlVL25lM05zTVZOZ0QyWWVV?=
 =?utf-8?B?bXdzWG9ZazNQS0wzUzNSWCtaWU03RVA1UlV0aHBGakM2bkdIL2pyYmd1K0RX?=
 =?utf-8?B?NmVjUUVOcFdLekhhTWY0YkdQVXQzRFlISkNCSk1mazZJVjZPdWkvM0xZRjE4?=
 =?utf-8?B?b1dkY1BDUmJQU3lzbm40TlZ1d1FvSVFiS0wyTG9tZElydy9paXNaUVNUM1pI?=
 =?utf-8?B?UGRKdWtkR1lwcGxkMk1aQWlBSmttN3hJejNOWmE0M3krUlBOY0Rub284aVBj?=
 =?utf-8?B?VFdWTWNFMEh2VS9iWlRDQzNVTStlWS8vYXJXZGFaY28ycFBHbnJSRlhTRnlL?=
 =?utf-8?B?dEFXWWhmN1MrbDZTc1JKVnBHRDFXQ2tvMWRMSERUWWZhWVVZZ3pLQjcrbzQz?=
 =?utf-8?B?UGROOGg5aHdENjhLWlhoWkdtMC9CQm0xanVIZTEyb2I0cCtWR0RleHhGbHdy?=
 =?utf-8?B?VXZKRGwzVEE0bnlRTER6SFBQQzhueHdiM2VyVGZOZHVwdlgyT0xVcDZhRHpL?=
 =?utf-8?B?VU5HdVRXR0RMZFdhNm02dGxYdjNyUlZyaTZLNFBQd1drb2xMaTNXYVd0K3Ur?=
 =?utf-8?B?eld2MTh2OHg4Qkx5VXppV21YUHI0RGdXWC9yNStXbngyVjhMUDkwTG5KMVdl?=
 =?utf-8?B?WUd5RnZGLzlaRHpYMjYyT0lNaU5DYmxrV1Uva0xUOXJZTzNyekdQMjdMR3dr?=
 =?utf-8?B?dGs5cUxiaE01N2ZYY2pBaDhhMzcvb2dCcHhLTlNYRXVPRWMvOXUvK1NwUGNE?=
 =?utf-8?B?RkZad3gxZmcwVEdpZkg2MmIwT0FoNkh3V3pBUU1UcGhFblhXb0xPMEltYVpJ?=
 =?utf-8?B?TXFiUk1SbXFHcTJCdnJBSU9Hb3REaEdnRG00TzZvVXFqZjAzWjdMQVNsaGZH?=
 =?utf-8?B?T0pDYS8rbWIzTVNGcGNGNWNDcVpYWlJvWHV5aHBEdFI5dC83YTdyVkkwSXRX?=
 =?utf-8?B?N2s3N0lUM0YvSHR1ODIwSUpMOURBTjEvMUtoNERBalZoMVdObWFpZkdaZys5?=
 =?utf-8?B?WWlWRGlXSlNRdUs4OHZic2YwbUJYOWN1R3Y3cElGbFRSb1BjY3ZxQU01VWd4?=
 =?utf-8?B?NDl1b3J4dWp1anVlVDc0dDdnNW9PaURZb0poY250YUE0S2NOekppZlpqREp4?=
 =?utf-8?B?VXBZUkM5bms1WmlRQ01zajZabmVsNEF6R0MxYWtLaTlUb2J6LzA1UmE1Zmx2?=
 =?utf-8?B?VjZCbjNIeVVpSHdCUnpoYWptemhla3VSM3lnMXBubzhlSnZXcHRPRDFQZTMz?=
 =?utf-8?B?ODd6US9WRXk2aHVNRUplUk1tVXl3ZmI3VWtHVE9PaENXL3RkN1NLbVBZZ1cz?=
 =?utf-8?B?WithSVQwaVEzVFZIRjhIVjVSVmNHTXh5T3A5eHp2UjI5QS9KQVBjcytURnoz?=
 =?utf-8?B?NWs1eXNod1hIZ0RnTFVLc1lXdUk3dWJrT2V0QkhFdVVoM1BRTXcwdFBSeW5l?=
 =?utf-8?Q?PYAA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0tTY2R6US9BODk4TStHL0piaVVlWjE2NXJVeXlkNVdEVWlQRkN1UUR0UWVu?=
 =?utf-8?B?RHlFcnE4VzdPWWlrZHpHQjdpc2tpT0hWbzRpaHRDNmRQNjdwMmw5MG9hanE5?=
 =?utf-8?B?T3ZNMzlweGx1U05KNUpwWFdtZHJhaHNpaFZ6SDNsMkUzV2x4MDBhczJ1YnRZ?=
 =?utf-8?B?T3h0cjl0V0JDL1VnRnJtVlpjQkNmSmhkWWVvN0RXNEsydERGZmNjNDM5L0ta?=
 =?utf-8?B?YkxBcUJHVVJKWjJ1UnRjc2dwK3Q3bjlJSnRZMlhxT2xZSlBmaGM4dHZYVk5p?=
 =?utf-8?B?YzM0NnZMdzVMWmxTam16SFNWd09pMG9MekpzbTRPb294UHQwK3lYS3NnaFJ3?=
 =?utf-8?B?eUpOZDE0VHBybXhsY3c4UHNVYU9vek5SWTRDNGlyUXBCT2dEQzUzYkdrTCtD?=
 =?utf-8?B?bVNuNzU1SjROMTFzL0o5UzZXL2FONytmT0dEMUkvaTNLcEJTbll0T2lmZFJk?=
 =?utf-8?B?MCt5OEhGdVY2Ykd3ZmltWG1SdUpQdGoveHNqSm1UMDlDU3pzQzV2cU9tR1RM?=
 =?utf-8?B?dmJFV0NQSTlQUE9Vc0s2SmFhVXF3SHpuS1JaTEtkWHBqU1VBV0JzZ1E3c0ww?=
 =?utf-8?B?OUtsZEVLVDBCZCtYaStOckMvUjZpbnJ0bGJNL3RzcVJqNEpHaGN0dGRNRFlT?=
 =?utf-8?B?SVZJS0IvcDN6OTBiSnQ0SzYwUVA2Yk5SWm41RHduOW5ZU29McGNJU1laaVVL?=
 =?utf-8?B?VkZSQmxSbmtzbzAwTzBQZ1FIc3dKR0sxV0lhckNSMmJkZE90VEI4RWNMUjJB?=
 =?utf-8?B?YjUzbmFOYm94RUJyQTlaZnlUUEVMN3VEOFNKNGVWVFNtRnJML2d0SGZWZnRr?=
 =?utf-8?B?cm55ZE10eFZ5OWhaN2tHekFnQkxvMERkSS94S1NMNGtBbjhIeUszZUozdmRo?=
 =?utf-8?B?UFdBWnJkbnlLeTJOWDgzOENQWGVWb1dJVjlLSnM1NnF2VHdwVm5oMmVGVldR?=
 =?utf-8?B?cFFibXNnRjRKZkFXTzNkb2d2RlNSMkNnT2RWTDBQWThsTlE4R0Q3ZkJ1S2pz?=
 =?utf-8?B?M3JwL2J3SlZRQjI3Tk9JdlZFd1JnelE5T1ZHSTlPYStORkltaW5CdlI3SGNW?=
 =?utf-8?B?UjdPRVBWaUh2cXhhQTVkVHdKSHdtWmFMV2tyRktFR01TaE1kSUUyVm1lY2wz?=
 =?utf-8?B?SWlNOUFFU2Z1NENTZ1VaQ04vbXRnWk5rQmd0RjFTOTRPUnYweVhIaGxtdmY0?=
 =?utf-8?B?ZVVCbzZNU2wzd1M3VEJCVUVmQldocnNCZ21tUmVNYVNKeVN1cjZOV2pTSElj?=
 =?utf-8?B?SlcvVHFFTlNUU0Q4cFMzVFQxR3lSczVnY2R3Yy9VK2VOU21rRlpkdUxjeWs3?=
 =?utf-8?B?dWtidXpYd1VUeWdtcmhGS1VIRTR6Nll4ZExyWDJZZHhiR2N2R0VBMzFzcnBS?=
 =?utf-8?B?K1Bvd3E3U2UvVGp2ME9RSVJ4OWhpLy8rc01ET0lrUkYxZlBZSWFScnM3dHhQ?=
 =?utf-8?B?VnloMEZCVldsNlZIczFYWVUxZUM3SGUzb0dvVHdTdDVnd2VHTlZSNldsOUY0?=
 =?utf-8?B?ZjluWGdOMkVuNGdiem5CSVpYdmxIMFJtNUFOSWNMamkvY1F1czRzNXd0ZDU4?=
 =?utf-8?B?SUVKOWJrUDc0NEVaMnFSMlhXaEZwUHdMeWRrRFhkM2ZVRFBzSExmUlNQLzNw?=
 =?utf-8?B?TE1WWFNMV1NpdHJkeGI0UTlXellXdXR1NTRIZk1pTVVjYWcvQ2xvZVBteHhC?=
 =?utf-8?B?OUczUkdPWHk1MEQ3TnlQT1hJUkhKVGNybmZFTnI4ZG9NL0xlaXJ0KzJWRVdJ?=
 =?utf-8?B?VzNLRnUrQ3ErS1Y1aUZ2S3V3WFhYdnVJNWRURmFGckxoZzRJRUtPbFV3bk51?=
 =?utf-8?B?dG9Vb2RmOXRadm5ub1had1BOWlFZR0xoTWhkTkxwc0p0SUlTbnBrQ3pMN3JE?=
 =?utf-8?B?VEJWTGlpWWl4VE5HOVA2S1JuM0xLQWZIYis3S1BUSjR4ZjQ1NkN5TVhVTTdV?=
 =?utf-8?B?UCt5VlR2VlBSVFo4VEN1RytUVU1WUGxyZmRDbldtdllkK3dVQ0hNU0Z3VHBJ?=
 =?utf-8?B?aVhsc0dNcU5Ydk9ZazJlaUFBS0ozbTlxeUswajV0ZFg1UjdJYzVLL0U3WDNv?=
 =?utf-8?B?cXg4RUlEN2hVcTcwVkhuclBDNTJISE5CYU0zanFicG1kbUdRMzZNU2Z4RUh6?=
 =?utf-8?B?QWlaVEEzc1pHVTFHRU54NEIwN0JUQmt2ZGNSUkRxL0hDRzZHTGRtc2FUTVh3?=
 =?utf-8?B?SU9rakhVaTRvS0hFRUdNd294dEc0V0k4LzVxMHB0ZFBxYWphaXlIaGVwbEF5?=
 =?utf-8?B?T3F6d2JNeGhtU2dNZTcrQ1BQaHI3bUNLQjVQS2hnRGM2ZzNTQlducmMzaDVN?=
 =?utf-8?B?SkdjT0VjYWlkOHA2TjIyekhjQ1ZhdzluMWNIWnBPQkZaeEl4OHlxUlNiNzlQ?=
 =?utf-8?Q?u+081UhAPfn33sds=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d38484-1054-48d1-4fc9-08de6b1afe7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:14:41.7174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nMfhn94bwKCza7SCbWmealVP9k/IIaglZEpyvHgVHvW7igphWj8Bli75INWjPNTVqnOZqeXuInVOaRQJuTHX5otClWY/b3I4ZBSC8wfgUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-GUID: FMl5ZLKDXS3-sFYqauQ8F8bn8yCrOB2H
X-Proofpoint-ORIG-GUID: FMl5ZLKDXS3-sFYqauQ8F8bn8yCrOB2H
X-Authority-Analysis: v=2.4 cv=CegFJbrl c=1 sm=1 tr=0 ts=698f4df3 cx=c_pps
 a=wECes94ijx38THdfaO2CEA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=2TNIsThMEEGYEH-xHa0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyNSBTYWx0ZWRfXzLt+KPk/NFRD
 nadsTRNB1FgXJDnZTc7GsuplOEgywt+l8VH6OIcSAo5oDV/KZ1pc7wYE7RJfM3JfZNGOP0BDiip
 vNhUSIFbasW4040qmhRJIyACiDrz93+hxWVWLO5ZwgTj22SZA22TyOCguLJ+dABaVWMw5Vat/iA
 hzL+S1Vrq5Bk8wcl247nDOY8WuyYsO5ER/jx3wDJ0K3rSnn2B3uYiz7OOjRVxlhBtzQbJcrQiaV
 JufUfufGu7qp2NNicWSOSLmYdKXZdbmVhEPA4AKvtVDC9C4mNegsbauUYWiR+YptyQt0NnnXUcp
 QElNsMK+1BcjJUWLpo3nfVgsquvIFQ4dQQSGZ7nwaB0FmQg5JjL5M23WYXpcRmxl8EX9FU7QfYO
 ZzI9y4mkzzns/CHjQmTlmBaUSB/KaGNij5iPAx/yCdIj4TGQpC2GSSzJHoDwHVjeGYNkUOLB19K
 eA41vo2LnK53oYE0iVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> audio/ is now converted to use QEMU standard trace & error reporting.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h       | 14 --------------
>   audio/audio_template.h  |  2 +-
>   audio/audio-mixeng-be.c | 19 -------------------
>   audio/mixeng.c          |  1 -
>   4 files changed, 1 insertion(+), 35 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 20ec7883aab..3fc4b516878 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -33,12 +33,6 @@
>   #include "qemu/audio-capture.h"
>   #include "mixeng.h"
>   
> -void G_GNUC_PRINTF(2, 0)
> -AUD_vlog(const char *cap, const char *fmt, va_list ap);
> -
> -void G_GNUC_PRINTF(2, 3)
> -AUD_log(const char *cap, const char *fmt, ...);
> -
>   struct audio_callback {
>       void *opaque;
>       audio_callback_fn fn;
> @@ -276,14 +270,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
>       return pos >= dist ? pos - dist : len - dist + pos;
>   }
>   
> -#define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
> -
> -#ifdef DEBUG
> -#define ldebug(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
> -#else
> -#define ldebug(fmt, ...) (void)0
> -#endif
> -
>   AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
>   AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
>   
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 760aaf5f31f..85a128e2f47 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -128,7 +128,7 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
>           /* f_fe_min = ceil(1 [frames] * f_be [Hz] / size_be [frames]) */
>           f_fe_min = (f_be + HWBUF.size - 1) / HWBUF.size;
>           qemu_log_mask(LOG_UNIMP,
> -                      AUDIO_CAP ": The guest selected a " NAME " sample rate"
> +                      "audio: The guest selected a " NAME " sample rate"
>                         " of %d Hz for %s. Only sample rates >= %" PRIu64 " Hz"
>                         " are supported.\n",
>                         sw->info.freq, sw->name, f_fe_min);
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 6799b7664b8..2ee05a18055 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -26,7 +26,6 @@
>   #include "trace.h"
>   #include "trace/control.h"
>   
> -#define AUDIO_CAP "audio"
>   #include "audio_int.h"
>   
>   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
> @@ -68,24 +67,6 @@ static int audio_format_to_index(AudioFormat af)
>       g_assert_not_reached();
>   }
>   
> -void AUD_vlog (const char *cap, const char *fmt, va_list ap)
> -{
> -    if (cap) {
> -        fprintf(stderr, "%s: ", cap);
> -    }
> -
> -    vfprintf(stderr, fmt, ap);
> -}
> -
> -void AUD_log (const char *cap, const char *fmt, ...)
> -{
> -    va_list ap;
> -
> -    va_start (ap, fmt);
> -    AUD_vlog (cap, fmt, ap);
> -    va_end (ap);
> -}
> -
>   static char *audsettings_to_string(const struct audsettings *as)
>   {
>       return g_strdup_printf("frequency=%d nchannels=%d fmt=%s endian=%s",
> diff --git a/audio/mixeng.c b/audio/mixeng.c
> index e63c76e021d..a209737a913 100644
> --- a/audio/mixeng.c
> +++ b/audio/mixeng.c
> @@ -26,7 +26,6 @@
>   #include "qemu/bswap.h"
>   #include "qemu/audio.h"
>   
> -#define AUDIO_CAP "mixeng"
>   #include "audio_int.h"
>   #ifdef FLOAT_MIXENG
>   #include "qemu/error-report.h"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


