Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB91EDF16E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquQN-0007Ey-QT; Fri, 13 Feb 2026 09:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquQL-0007ES-LY
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:45:37 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquQJ-0000Eo-Fg
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:45:37 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DCsC9v070772; Fri, 13 Feb 2026 06:45:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=takHa7heJQPBxHh5iLBLfnHy5bNjYPnH/szgA5OP2
 Fs=; b=QIuUbZvLnwFWqQ9Y+anJUW95qxxs4L6G0LGrLd7pvkKgfXnG2BgSIAJRw
 x8+LxravixRKPQ68GVKrvVbxBJ5XXCNYjOlIbKZzBw+g39ddw4fh+Dd+1+x8S2aM
 EOp9hyBo9nSeufDws6XyJGnYuCNtqINNpKRI2mVhifZJL5yYu1q1xmL8Yyf4eNMc
 NGdWEbVJ4WKJfFwXcJJXQfC6lHyYhcbhDzVr540iCLMl2WJeSS38Uzj5+ssYAwMf
 uWodkqUlpWODY+yn5iSiE7XZo9uBKB4U2CozuQQZEg/7UME3d25VoFdKt+fV1HqM
 4VtMLYYCz9voPR7MQ39RKkdb9hffQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021112.outbound.protection.outlook.com [52.101.52.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9u9f9jw5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:45:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGJ1W+3citBxf1h5sTbyCQGaVwJEp9B0ozRPOGCWw99fKlZvzsacL+KQLGbquZdJJmtMlQ58z+jw2YRfKh/WJVYCTflNxpx/NKXaW8pXhf/wAHd3enZR6FVpguDvxEmiOJmb9008GKKQQv7Is+sJmoPamH7yJa7DafHtqqA14QIUMJidKhXXIimI7imh+FDKxZmVUfCaLibcE8PvQMgLjIdIZ+CicuqxggNiU/3oKRRjVWyDlTprpaiGSdXmOxnu/iqREQg3WKAX8SL4NnDdagnHMsGP5M/xmVsQKvsMqVbG7oiV9pxZPai0ZwjmPsGRuVt10z/MbX3jzFjME7DFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=takHa7heJQPBxHh5iLBLfnHy5bNjYPnH/szgA5OP2Fs=;
 b=EWaEI4kQM2H9H0MwnPh+V/AvQXnKox0eWFZ6+P/1wvFp3MNJee2kwtVy/fJ0j76k3Fqr6h0tJSD9uH8zlBdSIjMRspx6/RJDe2HPUs+ViqsgughxQopwxv4pDJYRNKDcnz0uQkLD0wJsylBZqx8+s//976yxpE90cxslmzrj+gMIXI6Ph159ctYIWksYOr9dGzmRsvd+nrPN/gJ1dsCoCoT9MGStxBI6BTtPFm3+MoMW2Fam+ti/EUWHR2rCPGlu92dyTwKEDl8DKgSzYtnx52TInZhyFFzUy4rHuR3SNRXkC4kuGWX+SR3jypEzJ4s5UXFtzjiQuiNRyKCI3Tueyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=takHa7heJQPBxHh5iLBLfnHy5bNjYPnH/szgA5OP2Fs=;
 b=MNkBvxRMAT0rk6FhQ6e8oSGl2IJg9NAbGm/Ke/on1rUUoT41NiItKghpL42fmckx70Tvnug+OfAEIopWXf8kolGFaT3mJ1ARAkfWRLq6ImlRFZjtfQ+HyTFzVZaJIQJRbBOq9dz4pnEczeXiJi7+Kc+KFP7n5ugG+OXyE5UCRUOhAxbEI01ZaIL1FWCVpNIQB7A49ZVl5lHXSoJw+bxLpjQ07GF7c2qrEU01ESjnCaMSfIdRWPLw6WFbrHLrr8Hrs9LlJ9GAiDzHettwvwpxhgGy1NpSGNT5exok0xntHR8VZufKjrCeeufT1E4QaVhKATy/YXv3l8//leg9LaVchA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6649.namprd02.prod.outlook.com (2603:10b6:5:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 14:45:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:45:27 +0000
Message-ID: <26b6c00b-2fce-4098-a3bc-98ed60de6872@nutanix.com>
Date: Fri, 13 Feb 2026 14:45:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/43] audio/jack: replace custom logging with report &
 trace
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-23-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-23-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:610:118::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: e17e0c06-078a-45c7-ccbf-08de6b0e8701
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEJNM3d5M1J3Zmo1R00zU2tTNFA3YjhkWi9KN2VUSmNMZGxraWZ4dDFMSlhv?=
 =?utf-8?B?OXN1d0Y0SnNuZlJSM1RxUU1QdXJacUJXRExNQ2lYT0dCUjltNnl4dXMzZ05U?=
 =?utf-8?B?S0hoVFdsRjJueG1xVEU5bFpZdzJVaHlUMzBUZE5zR2NabXRRcnZKK1AvZ3lC?=
 =?utf-8?B?VzdYcmYzVkRrK2RsZnhqRFVKN1d5c3dkUWFPTEtMNU9TcGI1UmhNY1N1VHJs?=
 =?utf-8?B?aWxYZk82V1pWUXlNUFRVQUYrb2VqY0hwK2NlM2FsOGRPekgvYWlBOGNQdEIw?=
 =?utf-8?B?RG9TZDgwcUtKaGZhWEtxa3prM21ETVYzemR5NzBlZWFNYlBzblpPeW9WL2VK?=
 =?utf-8?B?Q21aeWJHMmRBd2FxN2lQenJyL2FoU2QzWCs2OFRtQ2d1VUVrMElpM21BTVhY?=
 =?utf-8?B?UEoyNnlGRjNmc1pkMVZiREJFdHNRcXJlbENMSXJYWkM2RWdlL1FkLzcyQjVi?=
 =?utf-8?B?dHpuR0ZOMStFakwxKy9UengzNjhRbzBLMjFsZ1g3Y0xWUWc2UFNSZUJXV3BC?=
 =?utf-8?B?aGxUU0RYeVNIUHlUb2g3bThDcWx2bFN5Q2JYeVc0WEJxTk1OaFN6VFk0SVBx?=
 =?utf-8?B?LzBPWmNvdjFIbWdPVGZkUmFlUmxVRkk2M0dudDhUekkxVnhEMmpEVU4vVDBy?=
 =?utf-8?B?WkcwQUl5WFpDV3lRVTQvaGdsa0g3RU9zOVc4NEptaFZJS3lKWENBdFo4ZVlh?=
 =?utf-8?B?LzNYZDJWeW52QnM5VWM0bkVEK21sajVPSERZMjNYTU90bkxveEFkV2cwQU42?=
 =?utf-8?B?YVJUUVdwRUpRc00zYURiQVVST0RiUXByc2FuRTVNTEt4RFJBR0pGT1NWOTZm?=
 =?utf-8?B?VG13SFNiQU44YzBaWGpQVUJVVGYyaW9KL2wrYnJ6K0dhQTRLL1VaeG9rVEdR?=
 =?utf-8?B?dG82MzNHTXpoOXViSjZxVk1CZ29VbHhOaEhLWk93Znl0Y1hKMHJDV3k1Uit4?=
 =?utf-8?B?VHd0UFhiRE1lU1NvSHZxRjJoVnd3TkJESUx0Zm9GRUxSTDk4V2VaN1V4ZVd0?=
 =?utf-8?B?RmxpTjU2OTRjWXFrYVI1d1V6djgyaDEwYThFaWI5NW8vMnlLbXN5QXdpMVJZ?=
 =?utf-8?B?ekVHaUI0YSs5MkdjeFFXVVdhaERZMzY2TENOSjBYRGx2bmt1em5yZHo4NmFW?=
 =?utf-8?B?ODF1Y0dPVVhNcnRGSmxVY0duY3lFZTg2SWFyT2Z1TGFYRUhDMEhoUG1yNVNC?=
 =?utf-8?B?ZzJzcUZQT3JnYUFyOW11b2U1SXhGbTZOTGVnaGJSb0xIaEhvanduMWhuSW1I?=
 =?utf-8?B?dUh4T0UyYXMvc1A0NVFnL25QQjBXUk5UQ0hHZURsKzJmbytpRnBBVUtCNkZ4?=
 =?utf-8?B?N2R1bVdUbW83WHJoR0crQ2k4a29ldkRldm8rMmFzbjdsbXhIM3haMXVKYVVO?=
 =?utf-8?B?YVR0SUtWeFFVOGJEQytyWjZOa0d0aDlzM3lwTXNuQ0JUZE1TZjRJK29hU2VN?=
 =?utf-8?B?d2Yxd2RpN2JsMDlJcEpyT2NCbFhUSG5vdHVTeEdtaE16VkNwTTltQk4rN2dy?=
 =?utf-8?B?V2hmbFNCN3FKdGpzUlpkcEoycmpKYkdoczI2R1N5cHJHQmppcm5vbkJQMjg0?=
 =?utf-8?B?VEdHUWkwTHh1dVNDdkNZWU5sSDNiRlNmUXkvWEFFbTg2U243ekRHOVl6WlN0?=
 =?utf-8?B?d3dxYi9UTW9ub0hHMU8xV2owMzNqaHRqd01iK3JzRmRmdU1tdEZnVjlyM3Ru?=
 =?utf-8?B?R28xZXgzL1pwejhUWUxRYk80c2dTdURGNGhGaElqUGR6ekhLZEd0ZDgvVUxR?=
 =?utf-8?B?S20yRkM0aFdJWk94TS83dUpqbzlPNUtBZlFEMTlVV0NNMzFpSHlYUk1KRnBj?=
 =?utf-8?B?Z2toeXhvTDRpVkNwcDRSVVN1TCtMRmVobG9EYm4vU3RlUGN0N05qMU9SQVM1?=
 =?utf-8?B?ZkNacVhIMS9HUlliN0IwdlVQRERSMXp1M1ZhY0dNYTFsOUxQR25ZNHNsdW9R?=
 =?utf-8?B?eURuMWpuZnR0YWFURkI2MHFadzZKTStOdmgwRlRHQXJIVzdGMVhHNko4RkIr?=
 =?utf-8?B?NWVCRmE1OVdVOUxiS0VVUS9leGdYLyttaHRGVXMzU1pDTG0vVjJkWGhVV1VJ?=
 =?utf-8?B?aEtRT25SM1YwWXZiNXZTSlUvSzc5Q2pBTHloRy9lYjZMcTlkamlncGY0N3g3?=
 =?utf-8?Q?u2J4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZjWjBITXJQOC9sa3RtYWM4ZUo5bk1IWm50Yk5qNXdsVDBKSk1JRkdzMzVh?=
 =?utf-8?B?eHVsZWh3WGlpeXpKMGptZVhybjIzL3FVdUloMGNRaTNnTnl6UmlUbXlQazhW?=
 =?utf-8?B?WGtlYXJja0xUbE9EYUFTWmtJOS9QOHlCUUR2aHZCYUhmdDQzbFZhbk9IOXRC?=
 =?utf-8?B?NEVsWG1UT2ErWHR0aUs5bmVlQVhDWk80REtGYWxGNWdxUm82Z1U1aFYzcDhu?=
 =?utf-8?B?bzIyaklaMHdDNEFIR01RWVBZbjg5ZURvZ25JNTZuTVpUL1dCbFBodFdjNTJl?=
 =?utf-8?B?TXM0dC8waU1OcTJVS1NvemxyVGIwcW5RMzdRQVZNc01XaWVUNFdHYlVCVUlD?=
 =?utf-8?B?TlZFNGhqSldTRVUxWnZUNi9OYUNhSUNhdG8yMkI5NE1yalpRaHdrbStoQXUw?=
 =?utf-8?B?T3ZEMWw4bW1rbVgwd0hkYXArVDdNVlNkNnlQV2p1cnhTMkNxNTB1QnMrR2Qw?=
 =?utf-8?B?cnNYditqQStIL2ZMTTE5SVhVZkF3Y3pDRkdDM0pkaUt3eHlhY1Y1ZW1oMU10?=
 =?utf-8?B?UFBrQ2JxaGtJcTRDYlNxT3JCVFVsaUFvK3lrTHJiK0VNY2Npc0Q1VzRZSU9M?=
 =?utf-8?B?dHFWc3lDV1U5NjVNL2ZFR3Q2Ym1yMFFyS1M5MjRpWHFjV1Z5UW9OcHJvckNR?=
 =?utf-8?B?REpBanEraTN1VlFtNHdsUjVBZ1c2YjhRbi85aSt1cXFVY0ZVc0lYb1FnU01v?=
 =?utf-8?B?VFBWek1EQmhXQkFpcm1ha0haRUVsRG05MEFhNDBwNzZZbzNwYnppNzBsMmpV?=
 =?utf-8?B?eWxUYjhZYXladStKdHNpSFlXdmxzN2UxNzMvc3czRXloNWZhb1NtTnYzVHVj?=
 =?utf-8?B?cjdFc3VWLzQ2WFZPTVlEdEVMZDBZMk9rZmcxTDdqeStYZ0x3Tnd1MlFqdVhv?=
 =?utf-8?B?UzJoTHhIbjNhbkRNNmpsbVBzbmlKamwwbGhVRVBPeGpZb3g3ekxuMit4N05Z?=
 =?utf-8?B?USs4V1dLdGRab3NrekcvNWNyYkE3TnJEVnAyMCtsTC9aRFdNRXc2UThOU2Zv?=
 =?utf-8?B?dkZlM2xuTGZNOUZaN3kxQmRLWHhUcEQ2ZUhXY3ZrK0pYb0pIQTBTK1JiQzlm?=
 =?utf-8?B?bklXUFdrY3o2aTFkL296YkM4L2JJUjlBbEo5YVNGM3RaQTZiand3TWEwU1NS?=
 =?utf-8?B?ekZLTWVMTGdHdlBZaGxJU3V3VUQvT3BJbjV2THNUM0xhaDU5MDc5Vzl6Y1Yy?=
 =?utf-8?B?WVBKaFF5TzJGVEpUSVBPU3pKanZ5ckdmZDhRd3ZqM0JCbVB3UjFOSXd2TFIv?=
 =?utf-8?B?U21XNzdFTVhOSjB0NXJkWVFobEVieC93VkpaOHg5N09PeGZxODdlcEJlYkZ6?=
 =?utf-8?B?SFgyOTJyTDlPZUhYZ25Wd2pVaE10RGRRM1pEUTZTMWVRU0g2VUZ6Q0ozbk41?=
 =?utf-8?B?OFpPbm5SZW1mZFlFSjdTRTNJeUlqMTljYjhmaEJWTHZDN2d3ZzMyR3FWcGtr?=
 =?utf-8?B?MnVFME9yay9ZRnlLWWZoNlE5dWNlM2FZZkxhVUduNFp0N2xuZlM0MmNoR1BN?=
 =?utf-8?B?NzZkeHdzSmFEKys0Sjgvb3RmL0E3dXp0ZUZ5R0VPMUJEODI2azlkYzZZSy9D?=
 =?utf-8?B?bGRzOUI1R2FRL3ByZXo5eEluck1wcjl1c2Z4K0Q5aFZia0Uxc1QzcU1QckVa?=
 =?utf-8?B?dkt2bDhiRUQ1VFUwVUphTnQzSUJMckRyRGtVQlRpTUlUT3dFS3h4MTZCL3Iy?=
 =?utf-8?B?czJBV1haM2c2L05GZVA3T1kvektnMU80R2pWMVY5TE5VRDBNYUE5ZUEzWVJy?=
 =?utf-8?B?Q20yU0VrREU1all2MW5vMmJGdW1jU2lQSDR3UUdvaW1VbjN0c2JKNGtXQTkw?=
 =?utf-8?B?S1JYWFV5UnVRbG5BcFFqaHF6bDVKN29WajFiUkQ5MUMrQUxvczRHSWJSQURk?=
 =?utf-8?B?UGlMM3E5QngweGJZbjhnRTUwc1YrUTB3VURFbEQzYnh5bWEzNmVMc0pMRDdX?=
 =?utf-8?B?TkdRVktaM3o4bVpCa2VUdmFMM2w0QXQvdFNWUDRBeWxWMkwrTWw0UHpFeE9C?=
 =?utf-8?B?SVBuSGdENEhDTk5rMzRPcUZ5ZzVPajZwaTBvbXBKc3JqZjRGWHk2THVHQlBO?=
 =?utf-8?B?RStLcTZVbGUwdjg3NkdPc3dPbWJVbUkxaGZtakwrZ0VwNjRjTWxyMWhDdWRI?=
 =?utf-8?B?aUJkbGNpb013d2xsRVR6clk5VXVDVkMvRHhRSHZ1OFluZFNmb1pOaGlZOFBW?=
 =?utf-8?B?VjVmdzFjT2F1cjZmMm90UUhNM0xoU2prZzAxRWZvcE95SHluL0EwYUQvTEpw?=
 =?utf-8?B?NVAvc1pKL0hRZ3VHdW05cDJ4WHVTcXpSNlhlUTdCSTFYR2ZJWGVtZVY4aW1M?=
 =?utf-8?B?ZnN6YnJhQ2c1bS96M2ZyS0lDcmh5UkRQUnVRYVVBdDdPelFRNG9OMWFRM1lK?=
 =?utf-8?Q?kfZ2kWrrlza3DXHs=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17e0c06-078a-45c7-ccbf-08de6b0e8701
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:45:27.3217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DogxrQd4r+KNyGZdrwC9HFP9ynA3dkn88AxxYScUrgBhft3xTvJ2W9IeOK5RmDAbc5L0x7IhZSj86u3wtgOTDB3fZESSLRwxspflO2uuPUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6649
X-Authority-Analysis: v=2.4 cv=OuBCCi/t c=1 sm=1 tr=0 ts=698f3909 cx=c_pps
 a=mSR/hpqHDdeL9wXJcf1Q7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=w4nSRAh5H8JBXesLZjsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YjwmySl9vlWrSSE5HT4TsKKdQEFyyece
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfXwrUHH28HqRfy
 TNtBXBiV7SiPCqMi40eYrN/0jIJ/mRQyqGvERUjOLpPNHbRB+il81J/mITbp8AZv2xkiJD1WMA0
 0kjB0WwAHoG2/nW1vmrRCPgTPsuMBwbxP9frMpHgC1v9T+pa8HZpVP9c2zsufiIbakt7dDOdZbu
 J6YrBV36DqrfdaOiudTA4Wg/DeUuU9mda6Gd/JdsHDZ4ZOJMozu1x175/e9riCCWDPO4hbCeQ/E
 m6VIE+o6ss/PEihEagRvxHrhCwwzDmrvCpUStkJr4yXw7lhmdnDLY0hNFvvjhV8Vm+sQ7N/zyKm
 IX1PcKXOR1DTGL5u9PIQk2Q3I7VSCVWxVV84aJnrz47ET5kLmoX/SSqNHwirgUhmGXi/p+zQs4J
 c7DPqsCjvZhxtULzAI9MMZ5FsNMZM5EQcX5BbgoGTJajbrxUMS8B8Dm5dX0EhTsqqwHGoF0eeJH
 PfNOxGFzrjeBlIQKKJA==
X-Proofpoint-ORIG-GUID: YjwmySl9vlWrSSE5HT4TsKKdQEFyyece
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
> Replace the custom audio logging infrastructure with standard QEMU
> error reporting and tracing.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/jackaudio.c  | 29 +++++++++++++----------------
>   audio/trace-events |  9 +++++++++
>   2 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 681eb17df55..547672f6d36 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -26,11 +26,11 @@
>   #include "qemu/module.h"
>   #include "qemu/atomic.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>   #include "qemu/audio.h"
>   #include "qom/object.h"
> -
> -#define AUDIO_CAP "jack"
>   #include "audio_int.h"
> +#include "trace.h"
>   
>   #include <jack/jack.h>
>   #include <jack/thread.h>
> @@ -343,7 +343,7 @@ static void qjack_client_recover(QJackClient *c)
>   
>           /* if enabled then attempt to recover */
>           if (c->enabled) {
> -            dolog("attempting to reconnect to server\n");
> +            trace_jack_client_recover();
>               qjack_client_init(c);
>           }
>       }
> @@ -399,10 +399,10 @@ static void qjack_client_connect_ports(QJackClient *c)
>           }
>   
>           if (c->out) {
> -            dolog("connect %s -> %s\n", p, ports[i]);
> +            trace_jack_connect(p, ports[i]);
>               jack_connect(c->client, p, ports[i]);
>           } else {
> -            dolog("connect %s -> %s\n", ports[i], p);
> +            trace_jack_connect(ports[i], p);
>               jack_connect(c->client, ports[i], p);
>           }
>       }
> @@ -441,9 +441,9 @@ static int qjack_client_init(QJackClient *c)
>         c->opt->server_name);
>   
>       if (c->client == NULL) {
> -        dolog("jack_client_open failed: status = 0x%2.0x\n", status);
> +        error_report("jack: jack_client_open failed: status = 0x%2.0x", status);
>           if (status & JackServerFailed) {
> -            dolog("unable to connect to JACK server\n");
> +            error_report("jack: unable to connect to JACK server");
>           }
>           return -1;
>       }
> @@ -451,12 +451,11 @@ static int qjack_client_init(QJackClient *c)
>       c->freq = jack_get_sample_rate(c->client);
>   
>       if (status & JackServerStarted) {
> -        dolog("JACK server started\n");
> +        trace_jack_server_started();
>       }
>   
>       if (status & JackNameNotUnique) {
> -        dolog("JACK unique name assigned %s\n",
> -          jack_get_client_name(c->client));
> +        trace_jack_unique_name(jack_get_client_name(c->client));
>       }
>   
>       /* Allocate working buffer for process callback */
> @@ -536,8 +535,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as)
>       };
>       audio_pcm_init_info(&hw->info, &os);
>   
> -    dolog("JACK output configured for %dHz (%d samples)\n",
> -        jo->c.freq, jo->c.buffersize);
> +    trace_jack_out_init(jo->c.freq, jo->c.buffersize);
>   
>       return 0;
>   }
> @@ -572,8 +570,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as)
>       };
>       audio_pcm_init_info(&hw->info, &is);
>   
> -    dolog("JACK input configured for %dHz (%d samples)\n",
> -        ji->c.freq, ji->c.buffersize);
> +    trace_jack_in_init(ji->c.freq, ji->c.buffersize);
>   
>       return 0;
>   }
> @@ -654,12 +651,12 @@ static int qjack_thread_creator(jack_native_thread_t *thread,
>   
>   static void qjack_error(const char *msg)
>   {
> -    dolog("E: %s\n", msg);
> +    error_report("jack: %s", msg);
>   }
>   
>   static void qjack_info(const char *msg)
>   {
> -    dolog("I: %s\n", msg);
> +    trace_jack_info(msg);
>   }
>   
>   static void audio_jack_class_init(ObjectClass *klass, const void *data)
> diff --git a/audio/trace-events b/audio/trace-events
> index b2f29666700..79744456cec 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -28,6 +28,15 @@ dsound_clear_sample(void *p1, uint32_t blen1, uint32_t len1, void *p2, uint32_t
>   dsound_wave_format(uint16_t wFormatTag, uint16_t nChannels, uint32_t nSamplesPerSec, uint32_t nAvgBytesPerSec, uint16_t nBlockAlign, uint16_t wBitsPerSample, uint16_t cbSize) "wFormatTag=%u, nChannels=%u, nSamplesPerSec=%u, nAvgBytesPerSec=%u, nBlockAlign=%u, wBitsPerSample=%u, cbSize=%u"
>   dsound_buffer_bytes(uint32_t caps_bytes, uint32_t desc_bytes) "caps_bytes=%u, desc_bytes=%u"
>   
> +# jackaudio.c
> +jack_client_recover(void) "attempting to reconnect to server"
> +jack_connect(const char *src, const char *dst) "connect %s -> %s"
> +jack_server_started(void) "server started"
> +jack_unique_name(const char *name) "unique name assigned %s"
> +jack_out_init(uint32_t freq, int buffersize) "output configured for %uHz (%d samples)"
> +jack_in_init(uint32_t freq, int buffersize) "input configured for %uHz (%d samples)"
> +jack_info(const char *msg) "%s"
> +
>   # pwaudio.c
>   pw_state_changed(int nodeid, const char *s) "node id: %d stream state: %s"
>   pw_read(int32_t avail, uint32_t index, size_t len) "avail=%d index=%u len=%zu"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


