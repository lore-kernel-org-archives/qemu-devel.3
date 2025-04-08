Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B67C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u24Cp-0002ji-91; Tue, 08 Apr 2025 04:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1u24Cj-0002jE-OM
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:21:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1u24Cb-0008Kq-63
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:21:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GN1i000952;
 Tue, 8 Apr 2025 08:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=N8fd8BU9Q/1RdvH2NXXlv+XR1r7WIsdNP/5Ua2bST04=; b=nl
 lkcuHs+8Yxc175lcGNrY6sn22WfgH/3b45VM055/NGBs3JHxUYI3x2lwzngLMHPn
 vY+i+xzRkhpcFzPfeVIwZeW5qfIcwnthIBBrSUwIHTeZ2PXA2G/eUv/355ZVLWuP
 Wh8u9R5eLiZdKKqiiDsdzbDvafMxo353yq8XkEdDw/eM1af1mdVL0h5oXztJ/Wrq
 CQWIK8YeraT2b9HN5eWbtvFeI+XA59xDxJu62AwfH0BA49uMdsdqIIYQ6hyoM5D5
 hzz72XpqCKADUw0PK2OXRNIl/cXyGZPUj2/pGk7f3zVo9KH/fdJwMoTvsDARWeMc
 6b2ziLo02h8iM3u/lWYw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe72b5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 08:20:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILiiWHLfNiqHgstR1OxWcxYpRPWkkw2JkaxnQBVUZj9R3nKIZzJ0LCR/+7+Gm1MRZZNrnz7kF2ZvVhOexk4mYT6hwyidUwpwRwOki6Mxcm6B3wPfQIufdzmsby4diG3MQ5L/jQyWj734/ixmoJVFAVcCFXxlTlisMuzBz0GHbT7HXh/RzGJZbvI9gK0QY5uHphuUQ17+Dzw17TJpsAXDHdeXml0/Ob18/+YX8zM+wHlzo9JaVr7+3DpJivckSYE1Icq1EiFoUxw4NHBQtdiHj1QbHvnSttfLCGmn2xNrgcg2M35Bgule/+5fnTa4JOmR5OpQZHVne9vmjKOOgw9qwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8fd8BU9Q/1RdvH2NXXlv+XR1r7WIsdNP/5Ua2bST04=;
 b=uxZ18TwYcpf5jfg+aeb2+PBJQdTEuZPwGIQQQadQG4Apyxw9M1Pska6Gfj5RpXm7Iq/n5aVVFuO6yYGGRPIqe4HDc8cJDjkNKTHjnOwjhL1jT8jAUiUhmgImvOgkgytrWR5CtLJGii4evPZ8suuUC+mPqd4IyvbxbW37CwvaM0Jh+o79AsIzNfRClig3eh2w2OWDmPrqpFqBYxoCbzMFXPGFunzUzdTir5lGHGwjx3EYflJ1gRDGi40MWLT7fXoVsb3WxN8evRCiLoHTGgqjroLqjBP4HNcqBqKMtp+K8RPcE7OG+A1YfGQNjekU8Od44+LCWjB5baK0a/B42LVxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY4PR02MB3174.namprd02.prod.outlook.com (2603:10b6:910:77::26)
 by SN7PR02MB10177.namprd02.prod.outlook.com (2603:10b6:806:2a5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 08:20:41 +0000
Received: from CY4PR02MB3174.namprd02.prod.outlook.com
 ([fe80::6071:b74:af7f:ba09]) by CY4PR02MB3174.namprd02.prod.outlook.com
 ([fe80::6071:b74:af7f:ba09%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 08:20:40 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Alwalid Salama
 <asalama@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 1/2] accel/tcg: add get_virtual_clock for TCG
Thread-Topic: [PATCH 1/2] accel/tcg: add get_virtual_clock for TCG
Thread-Index: AQHbpIz+PwnmGEbrzUqamrIv2DpbtLOZdRKA
Date: Tue, 8 Apr 2025 08:20:40 +0000
Message-ID: <84ECF705-6BC3-42C7-9F37-D0C81DFCAF7D@qti.qualcomm.com>
References: <20250403113851.4182190-1-alex.bennee@linaro.org>
 <20250403113851.4182190-2-alex.bennee@linaro.org>
In-Reply-To: <20250403113851.4182190-2-alex.bennee@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR02MB3174:EE_|SN7PR02MB10177:EE_
x-ms-office365-filtering-correlation-id: 616c36dc-770d-450c-f500-08dd76763f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V243WStRUHZvT3d5QTJKeUhLUTYycXhTcUdXaUM5WjdhanZZWXAvN3Z4clR0?=
 =?utf-8?B?RjhJNitlYUtrTEN5NEwzNG5oZVU2MWRrYlMzVmp4c2ZFUlRHMzJ3K1BhVWUz?=
 =?utf-8?B?c01vMGcyaDJ0cHBHTDRiTkhBY2Z0cHNDTk5sS0dLaWhpV2R4Z1lMNzd5cEpX?=
 =?utf-8?B?ZjZPSXRCVGpYYjh2TnVvOVRnS1dSZTdSaTkrZm5kNnpaQ3QwVzFpbkZjd1pM?=
 =?utf-8?B?Qi9tZFUvenZnMGkrWDlNTmlCOUJCSmV0dStOQlB4dU1UUzFkVUVxWkEyWVZv?=
 =?utf-8?B?NHYrVzlLRENPUUJsRzh4Q09EZEl3enNLWkc1R29FRWV4SG5ZYXpmR2ZsblJF?=
 =?utf-8?B?Mzc2OTdYTW4vYy8zUzZhbUFIdnFoSTRxb2tHVlY5aVlrKzdQeUVtZ3FiUVgx?=
 =?utf-8?B?Umo0S212bUErNTkrWTN6R0lmQllzMjJlRHIyb0x6TkFNTEVaRnNtdXl5d1NO?=
 =?utf-8?B?b0cwVTF5SFRHVGlxRDI4WVN5WU5sZXZLY0RSRHpsN2xqdFUvWmdxRWRWZ0NY?=
 =?utf-8?B?L0o2OXlnNGFxcHh5dFVqLzFncmtnTmVkRzFOYjh5dVlPekxDS3daN0taLzgx?=
 =?utf-8?B?aUlsRHkveVB4akw1ZHBXZGhoV0N2TTd0dThwRXUwS1RKOUJHL1h1MDNLRFFP?=
 =?utf-8?B?bWNsaUVpNDlRMmJyZzd2U2hJTWliMElvaDhySExVOXFsdXRYK0lDRXlZd1Nh?=
 =?utf-8?B?Z3RrTzd1anRXVFRoM2kyOGtTWEJVSjA3VW5FRFJTNnVWT3pUQkN3dUIwV1d5?=
 =?utf-8?B?SS9RWFIzeitMNnQ2OElpci84SU1KU1dhQWZneDJ6MExEc0EyOUVQZVhUUyth?=
 =?utf-8?B?R1FLRkNjekZCU2p1OXhHc1MwVWFaWjNrdEpFM2ZiTGp4U1hQQ1h1U0xMcXFV?=
 =?utf-8?B?YzU3eDY4V1JlWkVOUFZISWFubkJjNVFlUGpZSGVocGFsQnpLRjRnaGJIY1dH?=
 =?utf-8?B?WXQ1SWFrZ1RHdGRYRGcwWW5wZW9GMG5yUjczZ1liY0ZraDgwMTRLNC9DWDl2?=
 =?utf-8?B?WXl6TEZqU2JiWC9pVURRaGNZRnNOYitkK3RTU21QSVpJaCttQTFZaGJKSHJk?=
 =?utf-8?B?ZUlRaWU0NVlUWW1KTjJRRVdlK1U2ejB3OXdnbGFsMmVJQkdKNmV1YkI1YUpl?=
 =?utf-8?B?UnRJcnpUNjZ6cXU1TCt6U0NLRjBkKzY5ZURCcTRmL09MSlpZOFBoR1BrYm55?=
 =?utf-8?B?VkZyU2daZjR2TW5sZDlCZWN4eHFCUUxMMnFaVGZKQmJyZVMxWHFzakV5YjlE?=
 =?utf-8?B?R3paZGhydWplWXQrRmZEQTNxOGZvRllkOWh3R1BGeWVDbGN0SEhQL0xJd24y?=
 =?utf-8?B?ZEhSR1ZDcFpBUGYrREpReVZqOE5wRE9EZGJRd0hCeEMvajVwQWNQcml2YmFu?=
 =?utf-8?B?MGZvY0JZdmFkOEZ5NW9lZlNFMGtQT1hENjZLUnR3Qmd4MEJ5Z2czR2tPb2lQ?=
 =?utf-8?B?Qm5KTWNUTFMrakZVTnVrbVlYR1JpcjFBb0xodGNkMC8wSEVTQ1JjVmVZK0hQ?=
 =?utf-8?B?NkFLbzlIMVh3MWxZWm9mdm9FYjJCYnhleDhiSE1vRDQxd1ZSMnc1WGRUZm80?=
 =?utf-8?B?WHB2c1B6eFpCNm81cXhXcE1mVHBFa3dna1hhSEF1Tk95cEpnVEZxRW9sYzNl?=
 =?utf-8?B?MmdvSVBWcXJQSWtaaUphYm5wbU13ZnBxY01hNVNOZzRabGJIVUVoMmhLaDdI?=
 =?utf-8?B?L1Q3RUtlNnk0MDZmVEgzajMrWmpPaVRDeUs4SHk0aWVJb2lwenlKeG5UZ3lN?=
 =?utf-8?B?RXlFVmxNdE5XMEExZkE3WE4vVFdmWEZ1ODU3NHlSMUdQVkcrRGRTNDZDRGJ0?=
 =?utf-8?B?MFFSWWNXbldhYkNKa20xZW9uNGpnUXJrT0xGQUFMbzRuZVJsbFAxdGxzU2VS?=
 =?utf-8?B?VVpBY3VSRTVmd3c4bEJ2QkxiNTR1WEpON0lLcS94SkY0am1JVi9LaTZvR3Rq?=
 =?utf-8?B?MUZTd0ZIU1hseEg3QS9hNE1hRE0rL2ZiN3BTZktuRVhOY2tBTFdaSmNFMUZT?=
 =?utf-8?B?QnlYenkvdVNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR02MB3174.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGVGRzZSdnVGNjVhdkVsNU9iYVMyUW9xK2hsVTdsNlpiTVV6N0JVenJkK2xs?=
 =?utf-8?B?Ry85aHFPTmN1Ky9selF0alRER1hIYTBVaFYybVVDNXJlVWRhRWhDakIvNTdJ?=
 =?utf-8?B?S0VUVVV0MFVHdklZQmNIR3UrU2FkbEpnMHE0cFZiWHlQNXBJNkNHb2FXNlFD?=
 =?utf-8?B?M3JtKzl1MWlBNHk1RDYrMGV2QWpkdm14TmtDQjBIZGpaNGREUWoxaXFua29V?=
 =?utf-8?B?K251M1pFWVVTTkJLYjkxbFFZMXJ6eEF5dVM3VVZHZy9MMWtaMEQzeklTQlN1?=
 =?utf-8?B?c1liUG0wTzBreXVsRE5yMnlTdWVuTG9mLzdCUk1SbG13ZWRhNGJQa2NLblNG?=
 =?utf-8?B?RmU4RXNmL2VlOHVtNmZlK1JvNEZTbkxFdFpMa29TNnJtbDhMUHhjVW1aYkhn?=
 =?utf-8?B?UEZ2dWpjK1VRbFpXczZiR0hJT3lqNU9YWkptdnFPblhlT2tXRjJUWUZYd3hF?=
 =?utf-8?B?NnFtb3JpMGo3WkV1Unh2U09jNld5VzFvaE1mNStOQTFlN3FFMU50UWw1Slpa?=
 =?utf-8?B?OXRkSHhKS0lPZG9CWlpLMGtLdXl5bE9CYWFyaU1lZUZad1BxY1B2TDFSYkRx?=
 =?utf-8?B?bzJHMFE2dUNIQTJMTEtlYWVwTWY3WXlxc0lKVnRaNVBhbW1zeWMvanNablMx?=
 =?utf-8?B?MFZFVm5GaXNSWHJmUjV4U0hxTDdNWUh2Tno4RmNRdEF2a243S3BlMjByRlVn?=
 =?utf-8?B?Z3dSVWFZYkdxNlUrT1c4UzlpRlptbzZuV2dVL1BuSjkrSGFSQmxxWHJwR0lF?=
 =?utf-8?B?WXMzRWk4ZVgvUEh6QmhkMU5SYUx5WjRDaGVuYzc1YjR6dXVjNVdXWU9iNFpo?=
 =?utf-8?B?WU1SVWRZYUJJc0dSQnYwbUVEc3VzdTB3a25hNENGb25ybXJWWUl0MElBUWpn?=
 =?utf-8?B?NGJ4d3hVWXg0Y1dQcnhoWklXcytVRG5aTHRDcVNJR3hpVjI3UjdqZmVIZ2t3?=
 =?utf-8?B?bEpFQkZTTzR0bWdYdlJTWDVrVTgwUmZQUm5sVG9zaHIvMysrRGVqMmpZSkxn?=
 =?utf-8?B?b3UwRGJzZjkrY0dLa1RkdVdpalBzMEMrcXE1d3JNNXlVY0o3cDZqMnBjeWFr?=
 =?utf-8?B?ZENUV1I2b0t1NXVNaDA1YTlpNDY2TmhtUXVKYll0SVNkQjFEVVc0K0o2K09Z?=
 =?utf-8?B?V2NTQTZiRlNVSG9IQm9NUUxNR2gwOEg0Zjk1Q2xLOFRybDh4OVNSSlZiTldq?=
 =?utf-8?B?SUZPVEhMOWFzZEhSZTdFa1oxWkxsbnBZVHBEL3NjcjlKeHYrSUxqdU9kem84?=
 =?utf-8?B?R0Y2YkQ1RFNVRlNWVkhaSW1YMEVxOFlXcXQvZGFtbWl5aklrQnRuUGpoQXpD?=
 =?utf-8?B?MXJDQWVOR0t1SUlOOFJBMm9jK0FOSytqMGZoL2pHZElWdXE3Ni9rMmZSSm84?=
 =?utf-8?B?SjEvS0Nwa3pkbDl3cmxlaGRZRGVodVBhMk8vRTk3Z0V0c3k2alJKcWFhRktL?=
 =?utf-8?B?YW1ucWFQdHd1RmY5dEdQc2hiMVZ6RUQyNGRSUm1GeXBUR0VRUk0vT0hWNHph?=
 =?utf-8?B?QlBYcUpMUkdxY0ovR2R6UXFUMUFkZ2lmcm1EOXZZa3UwaFRCY25yeWpWMzB6?=
 =?utf-8?B?VGxhbW5zd1R1andoa2FjZVhYUlFHdWpKUHRkRDI2N1hpeXlEejEvSlpydmV4?=
 =?utf-8?B?V1NZS0duRERPV1hDc0l5bGc2VzB0UDRpZG5USzVLb1g3NDJSYjM5cVdpNVQv?=
 =?utf-8?B?SG5Pbi9HcG5lOWdzK1FtYTVJRXpoY2I4eTFFUENRZTBBYmR4bnJCN0hobCt2?=
 =?utf-8?B?VzI0MWhhMDJhdlRabWw3MUx6MEZ2ZjhyWDRCRFM1R21JWWlSbDNVQ3M1d2Iz?=
 =?utf-8?B?cTdraUdRcDVNSmRmTFUreE9lSVdpNmRMUnFVdE5Td05aZjdQZGtoSlBSUEIv?=
 =?utf-8?B?ektPbmxqbGE4QXhDTlBQQllkOEM0Unl6WVdWT0hKOWppQlhGVE1aTzJyN3Ju?=
 =?utf-8?B?UHFFYnNRK3JxS3JqRlNhMVJVZkE5Tkdhb29SMEYrb1VFQkMyZTBNWTI0dkVE?=
 =?utf-8?B?cWxmQ1ZEdHVyNWVZYTNIY04yb2JZck1IWmc2bXFsUUppR1VvMTVoVm4yVThv?=
 =?utf-8?B?R0I5T3c5a0hobW0vUGtnOER2OXNNYUpBeHpVT3pJVXZLc0hqNU16UUZ5YS9P?=
 =?utf-8?B?Wmx2c3lHa3VUeTdwUHZjM1RITzR1NWVFYmgrTUpaVW8xNjZMTXhVZWRVSUtO?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65549B1837BC974AB7B111557222A9C5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TvFD21ZyzaIezWDVYk+XoCOZpfMtClSRFCPjVNwNSLMII470vd274pHeZMiijcDDvn6T59fnIhZHbUBlYYjhzQaN2tGCyp2PBQ/AonYgconbsQA9cresgVTV6HuVtUEOuTnoIVtglY4NkVmeoMMa+/CP+vLOT+lyhPXjMZsTVSlORnRBq8mRqsN+m7xO9VYXo1l//jYkgOPwZnqFeZNkBKEpSeZcE6erMkrhjgtddzLLouWkrhyOKFmVitLQhdJ21THBrxuUpSG+TOabOY4+Mfshmqsv4gyjFx3TPa3r/iMfRu7PCKj0kxiLt0LTdJrXaWikdtCST81JxRNoBRPdQvO5IaPJ4ij94RuWetBSllBQT5doXT7j1McHCxZ/uTHCW2i53DKO0Nxlhv8AVi8eAkE9URzKDaWhoy0vtXrOpn4ZUFHm1tDsogufRl6GF17Oyo74P7Ne7PYs0A5j6uEZHbnZcpLMKfcnudYQVQuKRn8WzIBM+2SSCpxzRvBohTAPsFpLzZWiElppC4a2YJIXfnxG79sSw+RgQWd52eTtK8j6XJioUF4RO9BOyvATyO0qHEPGppbibEfLU86N/yjQ/8570cibWrUoRYyW2udBAO0dyhLVCxWkHptJ01HsNE8b
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR02MB3174.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616c36dc-770d-450c-f500-08dd76763f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 08:20:40.0306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiCjXrVN3fDUBoHwYnOJwWm2Oopw5CbahuRkMFeHdohZiwipktzMGA/L+8wEhM7ykVUKcAkDf2zKdwlE79xaniaYs4rjFI/Vs8ClBOltLEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB10177
X-Proofpoint-GUID: LYXkjqlVgfz5iUsudcP8ijvCjYzJP2Yl
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f4dc5c cx=c_pps
 a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=WkX3GdREhGOG8gmOEYsA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=vUsbdJjsiYsWhgVz2Rkt:22
X-Proofpoint-ORIG-GUID: LYXkjqlVgfz5iUsudcP8ijvCjYzJP2Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SW4gcHJpbmNpcGxlIEkgbGlrZSB0aGlzLCBidXQgDQoxLyB0aHJvdWdob3V0IHRoZSBBUEkgY2Fu
IHdlIHBsZWFzZSBtYWtlIGV2ZXJ5dGhpbmcgY29uc2lzdGVudCBzdXJlIHRoYXQgYWxsIHJlZ2lz
dHJhdGlvbnMgdGFrZSBhIGhhbmRsZSAodm9pZCAqKSBhbmQgYWxsIGNhbGxiYWNrcyBmdW5jdGlv
bnMgcGFzcyB0aGF0IGhhbmRsZSAoYW5kIHRoZSBJRCkNCiAtIHJpZ2h0IG5vdywgc29tZSB0aGlu
Z3MgZG8sIHNvbWUgdGhpbmdzIGRvbnQsIGFuZCB0aGlzIHNwZWNpZmljIGNhc2Ugc2VlbXMgdG8g
dGFrZSBhIGhhbmRsZSBvbiByZWdpc3RyYXRpb24sIGJ1dCBkb2VzIG5vdCBwcm92aWRlIGl0IG9u
IGNhbGxiYWNrICghKQ0KDQooVGhpcyBpcyB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiA6DQp0
eXBlZGVmIGludDY0X3QgKCpxZW11X3BsdWdpbl90aW1lX2NiX3QpICh2b2lkKTsNCi4uLg0KUUVN
VV9QTFVHSU5fQVBJIHZvaWQgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdGltZV9jYihxZW11X3BsdWdp
bl9pZF90IGlkLCBjb25zdCB2b2lkICpoYW5kbGUsIHFlbXVfcGx1Z2luX3RpbWVfY2JfdCBjYik7
DQopDQoNCjIvIFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG1ha2VzIHVzZSBvZiB0aGUgY2Fs
bGJhY2sgX09OTFlfIGluIHRoZSBjYXNlIG9mIHNpbmdsZSBUQ0cg4oCUIGl04oCZcyBtb3N0IGlu
dGVyZXN0aW5nIHdoZW4gd2UgaGF2ZSBNVFRDRyBlbmFibGVkIChhbmQgSSBzZWUgbm8gcmVhc29u
IG5vdCB0byBwcm92aWRlIHRoZSBzYW1lIG1lY2hhbmlzbSBmb3IgYW55IG90aGVyIGFjY2VsZXJh
dG9yIGlmL3doZW4gYW55dGhpbmcgaW4gUUVNVSByZXF1ZXN0cyDigJl0aGUgdGltZeKAmS4NCg0K
DQpDaGVlcnMNCk1hcmsuDQoNCg0KPiBPbiAzIEFwciAyMDI1LCBhdCAxMzozOCwgQWxleCBCZW5u
w6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+IFdBUk5JTkc6IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5
IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0K
PiANCj4gUmF0aGVyIHRoYW4gYWxsb3dpbmcgY3B1c19nZXRfdmlydHVhbF9jbG9jaygpIHRvIGZh
bGwgdGhyb3VnaCB0bw0KPiBjcHVfZ2V0X2Nsb2NrKCkgaW50cm9kdWNlIGEgVENHIGhhbmRsZXIg
c28gaXQgY2FuIG1ha2UgYSBkZWNpc2lvbg0KPiBhYm91dCB3aGF0IHRpbWUgaXQgaXMuDQo+IA0K
PiBJbml0aWFsbHkgdGhpcyBqdXN0IGNhbGxzIGNwdV9nZXRfY2xvY2soKSBhcyBiZWZvcmUgYnV0
IHRoaXMgd2lsbA0KPiBjaGFuZ2UgaW4gbGF0ZXIgY29tbWl0cy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gLS0tDQo+IGFjY2Vs
L3RjZy90Y2ctYWNjZWwtb3BzLmMgfCA2ICsrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL3RjZy1hY2NlbC1vcHMuYyBi
L2FjY2VsL3RjZy90Y2ctYWNjZWwtb3BzLmMNCj4gaW5kZXggZDliNjYyZWZlMy4uMTQzMmQxYzVi
MSAxMDA2NDQNCj4gLS0tIGEvYWNjZWwvdGNnL3RjZy1hY2NlbC1vcHMuYw0KPiArKysgYi9hY2Nl
bC90Y2cvdGNnLWFjY2VsLW9wcy5jDQo+IEBAIC0xOTcsNiArMTk3LDExIEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCB0Y2dfcmVtb3ZlX2FsbF9icmVha3BvaW50cyhDUFVTdGF0ZSAqY3B1KQ0KPiAgICAg
Y3B1X3dhdGNocG9pbnRfcmVtb3ZlX2FsbChjcHUsIEJQX0dEQik7DQo+IH0NCj4gDQo+ICtzdGF0
aWMgaW50NjRfdCB0Y2dfZ2V0X3ZpcnR1YWxfY2xvY2sodm9pZCkNCj4gK3sNCj4gKyAgICByZXR1
cm4gY3B1X2dldF9jbG9jaygpOw0KPiArfQ0KPiArDQo+IHN0YXRpYyB2b2lkIHRjZ19hY2NlbF9v
cHNfaW5pdChBY2NlbE9wc0NsYXNzICpvcHMpDQo+IHsNCj4gICAgIGlmIChxZW11X3RjZ19tdHRj
Z19lbmFibGVkKCkpIHsNCj4gQEAgLTIxMiw2ICsyMTcsNyBAQCBzdGF0aWMgdm9pZCB0Y2dfYWNj
ZWxfb3BzX2luaXQoQWNjZWxPcHNDbGFzcyAqb3BzKQ0KPiAgICAgICAgICAgICBvcHMtPmdldF92
aXJ0dWFsX2Nsb2NrID0gaWNvdW50X2dldDsNCj4gICAgICAgICAgICAgb3BzLT5nZXRfZWxhcHNl
ZF90aWNrcyA9IGljb3VudF9nZXQ7DQo+ICAgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAg
IG9wcy0+Z2V0X3ZpcnR1YWxfY2xvY2sgPSB0Y2dfZ2V0X3ZpcnR1YWxfY2xvY2s7DQo+ICAgICAg
ICAgICAgIG9wcy0+aGFuZGxlX2ludGVycnVwdCA9IHRjZ19oYW5kbGVfaW50ZXJydXB0Ow0KPiAg
ICAgICAgIH0NCj4gICAgIH0NCj4gLS0NCj4gMi4zOS41DQo+IA0KDQo=

