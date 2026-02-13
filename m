Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D96EDF172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquaf-0001yl-3x; Fri, 13 Feb 2026 09:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquac-0001yR-S9
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:56:14 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquab-0002M2-3R
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:56:14 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DA6B7K3534639; Fri, 13 Feb 2026 06:56:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OSYIVxyieF47oEGxAzk1FjkRpxIOaSQLgSuEknLgU
 ys=; b=u2QHp/AMoHRlw80EHOV09w1GYwW1XoKVZK5ZTsM1mRa4NRvke8953/8PO
 BVJ5RNW560IT/7Sc13+UP7rxbALBNiNJQ6rmPjKLHu1MXOCczHR866B8pHtALa5X
 9IFtp8vylbsSQpee/V/4qJq3YKH+F8Rcs+fBXiuDl+eTAOKRjJ8dM9S17vOJ1ZP9
 p1AInDOKe4+iYB6oTGATkCv+X/+dc2WnfnQulXcD3KDjq4tqZztOcjnUcmO7lJy0
 4AcImD3gIPjWwICO+57PqLSPatAL62mEWktZXn1JTcPvuEWLjw/alr+ttWebDUAi
 ir+eWGZt8esxh9DQLukKGi9It555A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021078.outbound.protection.outlook.com
 [40.93.194.78])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d7mp2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:56:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksqAIaDAFxZZ9vIMq42lROpjT7LKfOfBPDXfGXRXo2yF0t6FANxDIL0OH41Tu1rYP3VlKC4oLURQI6HcDHXKE+28Y1fFKCZP2kibESpCBe2ehG+lMecV3WpKjlBF3qqTFv5t9RlxwqTIyATcMXYJg+hjwsmU8BDnXoi5o9ZP2HvzurdLRN4TTEo0hM08HZfumI9JlhIOqWus44b4FhaJn2m42iGZ5PapDPhmoDX4EXO/TSjoxLS/YGbcCaMu9PGhfwRayKqB8ZeiXtUHtag3cGPJcmcjN7Gu27wju22HrHnBjoE/N9t7DDEqoqtviFL7kgT/GgOWbLTnX2ve8Jf8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSYIVxyieF47oEGxAzk1FjkRpxIOaSQLgSuEknLgUys=;
 b=nT13XaFnpyfpZFdxrAWFYD2Nvjfk+m0AUX+hWAqQTtD1DVN8EgvhjQ2VjaE0vxtnlaEjFOKJcxB+iMl0ASKEJ8db/CSMtw3IqnZnrKP+n1/QPwj9WmJqLf3KMyFHZl9vpJllxVsMKbZuilZfhAd/5VIqnefRHIYcN5+LH2nPDLPCegsI0D13DJugAtEl47p3gpQnbFbHawl98uTifTa8lTHM4k419j2q/oKcPXmii7Hk1fHwPVPdCXtxIzyRD86OfQVjYmGHL0jUQyWfAnmcyESFladhIiEcebpIoQ9nnrJrypP+ttHwrahoxFXyjTOERbRFArGCs1zvba243x/9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSYIVxyieF47oEGxAzk1FjkRpxIOaSQLgSuEknLgUys=;
 b=Z/CK3OJqpFQMDDm1OmYhWwv69o7Zsn1w1weq/bmaFCPIPxOExcgRZ+ZRL9bV3paTokPdAoN3B8dol/YQ31xCP/i05k4Bu3p/qpdij3wy8NN48uMClKXN3cFgNclEJIydhRxans7FF/SyRmNJxtPOAOgixxjfNxM6yQIQGayeep8JmkV+ndSo4MsDnqvJ4PJucLNzm1gghEEMZ7CpMhcBWlXydolN6HB+JGZydsrFVOjUMjTil52xO2OjMdSXn3xbRQ1JatqG6jFPO+S0knGrkY3kzaewWoXdw4XiaOSokZ/NhHVQQ0BNJy/S4oRYzpWJPVLfBPwCndVosR6k2oqvHA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB9340.namprd02.prod.outlook.com (2603:10b6:510:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 14:56:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:56:08 +0000
Message-ID: <9eb9775d-9c1f-4b5a-a1ff-5cb8678466e8@nutanix.com>
Date: Fri, 13 Feb 2026 14:56:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/43] audio/pw: replace custom logging with error_report
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-27-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-27-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: a9809d38-b9eb-4e55-fd74-08de6b1004d7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3JhN0JpLzBVMnRHMld3QmwyUGcyekd0VThTRXhJc0xWY1FMdC85R3Y3cS9P?=
 =?utf-8?B?UmV0djI2TG5OSCt2MGo0UWIxVCt1NjBUQWxvME81ZG9xRlhpOXQxUEhBUnpX?=
 =?utf-8?B?b3NUMXZUa1k3ODhmRUxvM2syNWNVWTVTN1k0SWpPZVFDQkVKTE9jcjFiZDlO?=
 =?utf-8?B?Z1cxeDZOUXZRMHpsQndWTUZaMm9sRjNKeDRpejl1ZVRXd0w1Vy81RU9sZ1Uv?=
 =?utf-8?B?azZieDdTZHV2RW9xbFM4aFFpSEtkWjlXY1l0cVdjZjdjd2VGK1FCS0M0dTZQ?=
 =?utf-8?B?MnlrekZrc3RIQUxGSi9URWVqT2R2dUVRc0RBS1o1eGFQNFpLbldsalZHMzNU?=
 =?utf-8?B?VEVCVld5UlpRYlVLUTBEaHh0ellCOTQvbjNNMFlGa2FUN0Rld2NJNHZLaXg0?=
 =?utf-8?B?ck5YU244ditXTmxnclhaU1JoQm0rNlNWMmRxa0xQN2hGOTJkYnNKZVI2MFNh?=
 =?utf-8?B?S2lwRkRSdkxZNXNydG9SVkE0NGNzUDJKM3l1WVNYcmZMdW9ITHRsNUVoekZU?=
 =?utf-8?B?dFNkRzBUSm5WOUdwcTRXZ0R3alMvT3VTWXZlYnFDa2ZBZmYrd1ovS2Vjcmx1?=
 =?utf-8?B?UmN5Y0gzdXpMMFE3bFhzaGoraDhyZVhFaGhYRXY2TWRNcnRwZVNTS2FnZjNz?=
 =?utf-8?B?K3p1cytwY0RxWlAxa0xqbWRlN3JFNkJWVWNiOFFYckhoU2w3RjBWNStya0hm?=
 =?utf-8?B?aWlNck9nMGZSL3phRm5ESWM4TDBoVi9rSSttU2ltU3FBSjJ4ck5YU1ZBeUxT?=
 =?utf-8?B?TzJzWlZ5V2llWkI2cHdOcGJNclpablNGcE5TWmtFNlZmSVlZZWdyZEM1MElk?=
 =?utf-8?B?RjYxNE04ei9WdER6OGZXVlAyNUl5c0VBWVB0VTEzR1pmZTA4Qys5MXFXNm85?=
 =?utf-8?B?bU1nQ2pMRlZ1cG1lakpwdlFjdHplVFliRnVqeHFBWDUrU1VIVW1hSDhuVHVB?=
 =?utf-8?B?dzRmRlFHUE9PT1pJUjMyd2ptbVlzdnBiWkZ1bm5rTzAvYnRsM2xtZDg2UzY1?=
 =?utf-8?B?MjBRYTh3d20wdGFEaXNxMFQrY0tBTDJVTERrZ0FkVm12dGdQRlE4aGVBKzBz?=
 =?utf-8?B?UWRqUksvSG5seW5EVkl6R2hJQnBnZ3FnZXhuVjFrTDNyQkVsSmc1SXFNbUsx?=
 =?utf-8?B?NlpxUUxHTFNwLzRCeVUwYXVIdUFCRHV1UldRRVJqdFIwZUg5Y0R2U1Y2dTVC?=
 =?utf-8?B?RU82bUZlU0tFRFpPeEtzL2wyTnY2bE9FbHNCWExKTVBjMEwyZkFmOW5ELzNa?=
 =?utf-8?B?NXlQQi91Y3Q5c3hINTZhVlpDS2VadWNyaGRSWXJ2ZmhaNmxaakoxRjZLNENH?=
 =?utf-8?B?M2Fwc2ZPQ1BoT21lYmdGbUhhdldMOCtlZHdMOERvK3VRWXNtVktTWmEvT1hD?=
 =?utf-8?B?Y01EZE1OQ24xdTVRdVVvY3dRVk9tNHg4eFJCS28xZys3SHRnTnBtOUhsK1F1?=
 =?utf-8?B?Q0tvaE1iWm1HK2w5a3ZDL1E1R3p5YlNEaUNEMWkvK2pHVGNLOUpUSXNwWTRk?=
 =?utf-8?B?bFVibUE1SXFPclAyV1grSUt6a3FqWlVuUEhzdC9GZ094SGR2Vzl6Rm1WUmp1?=
 =?utf-8?B?Nm1RUDhpMGwvdjN2djJ3aUdzaHZDYWFLUlRzNnJzemRObVZ2UWZYZEJ5UStx?=
 =?utf-8?B?RHVHVmdVRnhXM1BGV3JrNStHMzJ0UFBBN2REUU8wclZLRHVOb1pwSWlHbzZQ?=
 =?utf-8?B?WEI1Z0lvZ2dXbncvWjZMNzhocjRBR3VIcW1pMUp1L1ZqK01NS0hBMVpPOGov?=
 =?utf-8?B?bVphbHhsSTMwaGY4b09pYjNWU25scGR6NDVkU3JoclhZNTFCVGpvSkd3TTQz?=
 =?utf-8?B?RTZxUWxWV0lYVXZ4RzZ1VnZtQmQxS1JUS1JPb1VPUGl4aUQrQ2RQdlN4aXVp?=
 =?utf-8?B?ZGlwOVY5bnNjY3NRSG9XTkZQSDgrVHVMVGpQWUM3YlVPZnBUVU4rNng0eFBC?=
 =?utf-8?B?Rk91cC9KdVcrNDVvT2NtMjNCNDc4Tlp4MzBUb3BKb0pHVGFTUldiWmxFcDZw?=
 =?utf-8?B?ck9rUWFnQlhNL2VjT1NCaGpMVzNlbGVZRENJUjlxRVRPVDdxUTRoaWJqWU5M?=
 =?utf-8?B?YmZyMU5iYUVMR3dNbTJyaUcvRnQycHI2UWlwT1ZLQ3poTDFBQ1N3Z2lhQlNj?=
 =?utf-8?Q?uIN8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rml2R1pSY3VmWitGYlpucis4YUdidVFERFdiNzd2T1ZXcnZUNy90cFFYL3Jm?=
 =?utf-8?B?YllyTFpTeWhRajgyeVZtS3lYUHhaNkQwZmtUQ2FqY2JpK0EySDBCWGFJL3kw?=
 =?utf-8?B?TmdDWmdkdGNKSTRRbWZBK1lzNjhsS0haSlZCNStHYUsveGNZT3FRcTJjU0dC?=
 =?utf-8?B?a2h3dWlYMVQ2akkvMDU1WlNJMVBaWGdtbkdDbm9JRGI3cVlTVng0SHc4dDBE?=
 =?utf-8?B?SitNKzdSN0ozSFZGT0F3MFZnWTVCQ3BlUWp5bkVLckxQUjlnRGJ2YzZER3pX?=
 =?utf-8?B?cTdISlNPL0VVZVUvYnl6dDFSV01tYWxpWGEwVW8vbkFia1U4VWIzcDZCOTJT?=
 =?utf-8?B?aTN1Rm5YeWh0S1hwV214djhLcU1OaVVPbFl5Q1dVTTJvQXJnbTJSVWxpM29M?=
 =?utf-8?B?bXdtOW9CWnB6bm1SWit6NUF0OU9lTWwwNm9NTmcvT1JWQnVWcjBaMzNQZk82?=
 =?utf-8?B?dENlUUp5dzVvSjRVL0szNVFrOTRpMmU4VE5YM21jVzI5emNrZ2prWTRVQ3J5?=
 =?utf-8?B?QzFobU0wWGMvUkg3dWQwd1pwcmJEdFp6NW5VdlJLdGVubkdPY2NaT0RLdnBR?=
 =?utf-8?B?N3U3MTZUcE1ZK09nNEkxZjJCV0kwRmFTczh6SktkaHJpeVR4RENjUjBWZUFh?=
 =?utf-8?B?MEd4ZmJ2TTBiN2x4a3RKems1MkhmWjZiRmE5SmkwTWtpSnJkejhvWXROcW12?=
 =?utf-8?B?VFZuTkdBRWpNM2lvTit3Rk04cHRTT2Juc05FZFNGbVZuc1hjVzluOEJQZnNr?=
 =?utf-8?B?UExrcTV3WEN4K1hZaEZIemxOQnBHbXh0b2liMlJXWHh5TlNPQllMVWFEQ0Zh?=
 =?utf-8?B?dG1rTjEvcG80MVg4RXhTQTUycEc5Rm9RS29abTBJWmJiQkx1QTdkcDZKd2Zj?=
 =?utf-8?B?YUtpS3pIVWxueko2TU90QS9GZTQ5ZXh5MFpvNFVrSWo5UExzNXllWEN0L0FG?=
 =?utf-8?B?ZHI5d3d4eW5oWUQwNUY3ckpKbUg2WWpnNnIxdzJERWRURUkxTkdOSDEwbUps?=
 =?utf-8?B?YVRyemwwWFZMR1BRUGdIbS9Ed1M3M3RIZDcxNld1UitNSXFDazZzaGVBcVVv?=
 =?utf-8?B?b0RMMWQrMHFzYTdHYjBYUE8xRVlVc2U2OUhHd0xCQ1BNcEZWVXdncFZBSjYy?=
 =?utf-8?B?Tys3eE9vNUlKOEcyL2FkQ1dRVWZFa3VLS2lnSUwwUjI0NHQ1SW55SG1sQUJo?=
 =?utf-8?B?TU1aUlZIVkVlNWt1UjNCaHY0Q25aNWIvWG9ucjNuMEVia0lkQ1h4eXZXZHRP?=
 =?utf-8?B?Q3lNL1Q5SW5idTJmY3ZyT1ZyQU5yME5YeEloeGtleHJCVmpEa0NwMlZ0WkZI?=
 =?utf-8?B?bEZuYmF2VUUvd3hvYjBJUExsQldqdE1ORFdRL29ScVlVK3hsU0JNb3JFZjNv?=
 =?utf-8?B?WHBxVU9VNU9ab3gvY1ZZZ3pEd0FYc3VtbEFQTGdyUWZ0SzFOTWNnUEVPVk1Z?=
 =?utf-8?B?a0tybGVSZlpKdDJwOUxucENvUktxS1QyTy9mWjdSVWZYMm1VN3ljL2RwTFJr?=
 =?utf-8?B?MWM4Y0V0dW9VMGJmYU5XakxFYVFpTThkTFc5Q09mNXJJSDc0Yk9oMysrbThr?=
 =?utf-8?B?cGlSeG9GMVFiWFo2UkNLRWYrakRmd2VaZmgvQVQyN1Z5WHNSQmZuSmpVUzJG?=
 =?utf-8?B?YUs4Qmo1TXlxZWt1bXNJZ1VGSmxnVXI2QWs0VnRWdTdTdFZPYWxtSEMvd29P?=
 =?utf-8?B?ZTlKUkNRc2FXT1FyZWlaRlBFTm9RcjNtT0dSVG5xTDZ5akx2VDlyVnc1djQr?=
 =?utf-8?B?eVZBZ3VBcVlVYUZDZzdBOWhyZW4xaHRtV2JBMXhVbkpSdkdiaUtEYzQxVFZ1?=
 =?utf-8?B?cWFoYTFtdlBwdVFuZmxia1pSQVZ1enFDdEtUTmJlNFVaODZtQWw0ZnBnTkE4?=
 =?utf-8?B?Q0VtbXVmRlVocHp2L0U5VjE0V0s0bXBFZnZRSkQzQ1JlOU5pMGlJMWVaclVs?=
 =?utf-8?B?U3JzWVVWUVlTY3dyRGRtcDZIWlVjQUZodlloM3dCSmVXTDhCNTNSdGd6dExC?=
 =?utf-8?B?UFZsTFZ3dnp0V2xodmsxTERYNjRKSEhuME5NdVN3ZXdYYXhESVhkYkNGdXZk?=
 =?utf-8?B?RldsSzZHZFh6YVpOazdJMVhEejh5Z2ZPNFIrM1QxTEpXcW9IbDEzblRVeTlZ?=
 =?utf-8?B?QVh5aXl2ZkYzMVBaTVFrVitBU05hVVZLRFFRRUMyZVpodlFuMC94ei9tRWRk?=
 =?utf-8?B?a3JCc2Ztai93dVJFR3pONG12WERHRFFxaTI3QWZJOW5tUnR0N0pqQWlteGNI?=
 =?utf-8?B?YlB6ZmwxRE9sbEQ3Z20yYmloSjNvZnZQQWN1VTFLSVB2SEdxcU04bE5HL3I5?=
 =?utf-8?B?TEVndm5ISm9zOXJrbTRqcVpFMDQxMHdIeHpYNjVHK1RCS0RYOXRpMHN5aFQz?=
 =?utf-8?Q?TCgzle29f6hmII1s=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9809d38-b9eb-4e55-fd74-08de6b1004d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:56:07.9649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DP4QPVNl0bilqD9/LRhRnvs6bAYG2aRZwt45y4sYwGyOoG7lernT/hNNvsWU/f9NY1Od8Bj/Rf5cqOUMBdauHKEpmJCqh2ZIiLDftC7myU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9340
X-Proofpoint-ORIG-GUID: ONE_J1_kFmX9avLALDfAQLVpiP_iT5kj
X-Proofpoint-GUID: ONE_J1_kFmX9avLALDfAQLVpiP_iT5kj
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698f3b8a cx=c_pps
 a=XqXlOjMxTw5Mth5+b1Cu5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=vzgNiq7ZYT22dxlD2mcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNSBTYWx0ZWRfX3jhmjag6If3s
 +Xcbq/ONPHNeNh9Baj1/dbyuK1f0XRixN3pPdtrFTIIiS8lkPZvdSJ4bB1OxBORDpFoXP2i2Xlx
 w8nGFVwJ8fxX+gOFwReLs3u4xtSi43NEsZ64x6yLaxwwcH+qBFCtKHStC1p2CHhxydKPyxnxzNt
 x0nAWkAvSg+LHFJPMhON805hbsYq2fQSBT+6CY5Hyyd5/yl2o8EIcxo0fRve7ezgyJfNXpI+lf/
 Su3mqRmy4xahdXdr00r3awkEG3JoDOvsx9ZtNU9fhI4TDEbjVG3NwPcwOe3qjTjVCYIRgxlPlls
 jGjPO6VV/bszc8Zx3dgZjEom/P3sKjXaRNFVC7+GeK/V3Pir+K/QwgOZYbJ1lLFdkP6/aJXxA2A
 Fg6YwtswI7kD2AeP7CSlpiG50MtJ66imKoA0x1BuzE74RATsiB/JP9uv2sgbnT7bhq/DIQYZ5rA
 fNVblRwi27HnaHhXs9w==
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
>   audio/pwaudio.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 39b2b8f0a0d..c30738c16ef 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -20,14 +20,13 @@
>   #include <spa/param/props.h>
>   
>   #include <pipewire/pipewire.h>
> +
> +#include "audio_int.h"
>   #include "trace.h"
>   
> -#define AUDIO_CAP "pipewire"
>   #define RINGBUFFER_SIZE    (1u << 22)
>   #define RINGBUFFER_MASK    (RINGBUFFER_SIZE - 1)
>   
> -#include "audio_int.h"
> -
>   #define TYPE_AUDIO_PW "audio-pipewire"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
>   
> @@ -358,7 +357,7 @@ audfmt_to_pw(AudioFormat fmt, bool big_endian)
>           format = big_endian ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORMAT_F32_LE;
>           break;
>       default:
> -        dolog("Internal logic error: Bad audio format %d\n", fmt);
> +        error_report("pipewire: internal logic error: bad audio format %d", fmt);
>           format = SPA_AUDIO_FORMAT_U8;
>           break;
>       }
> @@ -418,7 +417,7 @@ pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
>           return AUDIO_FORMAT_F32;
>       default:
>           *sample_size = 1;
> -        dolog("Internal logic error: Bad spa_audio_format %d\n", fmt);
> +        error_report("pipewire: internal logic error: bad spa_audio_format %d", fmt);
>           return AUDIO_FORMAT_U8;
>       }
>   }
> @@ -518,7 +517,7 @@ qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
>           position[0] = SPA_AUDIO_CHANNEL_MONO;
>           break;
>       default:
> -        dolog("Internal error: unsupported channel count %d\n", channels);
> +        error_report("pipewire: unsupported channel count %d", channels);
>       }
>   }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


