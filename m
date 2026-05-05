Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5160FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIA3-0003WZ-0a; Tue, 05 May 2026 11:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wKI9z-0003WL-Lh
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:58:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wKI9w-0008Iv-LS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 11:58:11 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645EDFmY3184288; Tue, 5 May 2026 08:58:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dT185VDf+lGaovpvemlZa7ni9LwdbZUsq5r9qCXMA
 Ww=; b=LAs97lNNYzl8Q4LH6fPBkP9E/Lc3J11DGwSxDsKZu1DjYlURsr/t059Hq
 f9KY3YU8t51nCk6NEBGHcnesOI/eSQgpSEN2WyKzWmR4OM3ho+AQn+SELHp9/Tj5
 qStzCSOx78zJF7jABqIh3ygOQliSEF99EapKVYKRWsnFJvCpGWSvK3iqL6VNk3rP
 hptJI0+7YwA1u3+mQjaX15SuJKTKz355ovyIp+yfjtPLg1PRFPheoOjd0UoVwddw
 CCn/Tigk/sAZ+YDlXiawCKP6xQ/bRaNXS8GYB4kqTJz+tNLQDRzlcaXQkReSf4C8
 XPbA75Vn1xqIs9ODXOcr44trytBZQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020123.outbound.protection.outlook.com [52.101.46.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dwfch6wrd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 08:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaphzwdalh+2+mD0DLPsXHqMrkt/wL1Hmtmf234NeMvc0OMhShDdppNhzf4n5FC/PPue9Y+nVYMuf0eH1ckCwrYvoHNiA4X63wnK8QmHV4f2lR/0Hl94v6YW2EmL0cRDUDjRKePAMEgmv/htblNEl6vtFMrysNxAf0mL5WVUPidu/5kzY3OitQzvU/kc4TJ2jOnbXFXUL/QHKqzfVz6dUi0759ngQlkTivv20TObb2vh0qukRT0Z3rRJSJWUoY2/ep1wbe/fHnt9XEQ6+HyOrIHb/iQF/w1CrTCUdn/+xq33O602yd/lfIoSs4I2dnAL1BOUUzEt/rsBChYv42z4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT185VDf+lGaovpvemlZa7ni9LwdbZUsq5r9qCXMAWw=;
 b=oZ/eIkKDG4Dg7c6gPHRm/Sk7cqKSNlWKgpShof0edNpb/SdXxceONxcaG4O4GbylvfLDA+8VQOAk+56ZtIQ2uQfMaE6OLc491k7mOeAFE+BImuDg5cciN9noTrFITjP0nFJGtD6l0LWjbRl2V+6pLERhxQzMhFH8nC2z3DCwrjiYWUBVnSRJF5z7Li3RHiSd6jr6FOmmEsAL/7iLm+zmxRXbSshxdaX0E2hg61pmAtOz5on2teeIzY808jXo4kqPaecCsHqVthnwt8mED1yTV6YtE9sfQ0jsxwQWMwFN2bBBDSGj/fx8A0sBd6xkGQV3dWZYI5ecmTF3A8V5MbscPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT185VDf+lGaovpvemlZa7ni9LwdbZUsq5r9qCXMAWw=;
 b=NjOFVH4CUfZj3fAweui4wUUWUmZjGODu7Ime6DGsYLL1eTQXP0H3GMjUo4Q4q+60A5IZpp/Caxq8pIQJ432+x/hESDNAFbKh9G9dRoQW3laOOC2LHM2HQX5k2yb3tmqmrSvip5La+zT3PNPV+4Dnq4FRMZ3lTjbXVjeh8Pb6tWuYboZzNixkm2m1dADg+NTqjec/xUVoFHtI1aFmn4M4JjB2p+h5QWJoaVgGuNOZ+SmxRbmRaWA/IJMakjQMY6Puf8av6otZXdjuIYk+DEiouP8emgyKuDnJr363myUmANeAkBSP13vtvgsgQ+QF1Q1KxKWjriu2viTUHrYkFjvGDg==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by SJ0PR02MB7134.namprd02.prod.outlook.com (2603:10b6:a03:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 15:58:00 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:58:00 +0000
Message-ID: <288c9ea2-6299-4a9b-83df-bb43c957eed2@nutanix.com>
Date: Tue, 5 May 2026 16:57:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Content-Language: en-GB
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
 <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
 <CABgObfYYt0CuLzj4kdD13J3+bUqAxNpmKTc4g=LtbojvKAatyQ@mail.gmail.com>
 <0ec397c4-5ec9-46c5-a081-a6b380320755@nutanix.com>
 <CABgObfbwVAgai6cKfxoFFXBfPJcR8riZmWCNi6k+ckzTcjuh_A@mail.gmail.com>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <CABgObfbwVAgai6cKfxoFFXBfPJcR8riZmWCNi6k+ckzTcjuh_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|SJ0PR02MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5923d8ae-c5e6-411b-07c1-08deaabf14f3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 7zoEPQRiwR21Tof0JuJ90BM1Hh2mWOlCSX7TfltZEHrus7+H15VV4/7x/1vfIZMQ8JqFExwxgE2OEvURxcbjIzFy4Um1xaUbb5dQNOcSljtkwwFUaIMo3VYAaNNPjigsMAUFzfgCYhb4EQToU8T3keyWs68e2PdTB6yD4McDpWzUw/WS8qGyI+CiaIOWsLovlPSv9azwTlElYgPr2DIgtUm1uRjEvQeKFq/IDgN9YmnvYSSEuaOXyEuqjopRrEq5wkP5ZJlLW2bet6L4aRtw3fDDLQ+m5WY6vtBUlmua+4DYJW9Ot16679Ov4TVXer6ABxkQMCDuC7Ar+OejRO98g7nZLTK2NGLERi1UTQ1V6LEUh35xe3H08MBtHgzMLoMX/j/fVQgFugjODzfu9RDIitL40j9VhyJ/N1kIMraaKbuMcWgnbmKSLR5/BciziGkdJEOZLWptlapquOebqPI/9/bO9OOwPo+fk7xIPw2atQoJAn7YiSt2oANbQ55TxMKl6ryMz3l5EZEbUeya6LzPKO/GJWzbt1LG9KY+7tWSt/A1TOA9MUG+GB9IO4Mm0svNojV6Ptl/snSUlyzV4FiSPjnaBfHdglO2QrjpjFh/HtdgssHo+UsPZ1OsBIMHx4iBPBDQfCSIt7JrC3jTWtunKmftZ2eG4Eg4WBCLYIgqgskn4mY1FVDiPVl5JQD9vKju
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjcvRXJHYXM4OXFHalgzb2NiUkdWV21FMWhxMnMwNGg1NkptUjAxQ0V5VCtF?=
 =?utf-8?B?VjdHdzZHMDRTd08zUzB0bksvZU9BRjNqUU9rdkdaV21LV2ovZkRPc0dFVXlZ?=
 =?utf-8?B?NjNmdG0xQXMxbXZSMjdFaE5jM0R4T0UwQ3VaRzcxM0NvRTZmU0FGUkJkb1NV?=
 =?utf-8?B?UzhONW1JaE5CWFZMT1pqZWxWK2VEcHk3b3d4M3RFVW03K3dGd2NKNXgwak9a?=
 =?utf-8?B?NE1LUEx4RmhUYWxMYmYrTDF2R2RuckNLanA3cnVBYTFYY0hZTWtpZFdaY1pK?=
 =?utf-8?B?RkZSeDBzZnFydE1rNXpVdTlMcGUwbE9ORTU2eGtMYlhNZW43c0lPN3IzNndZ?=
 =?utf-8?B?cXp2RmtPdmppQXd5SS9rSXAyOXlGVFUwdXU5T0NVb0xKMmROdS9GRkhhZlNx?=
 =?utf-8?B?L0J0ekpGVGdsZ2FXUWVHZXpiZDh6cllYa3JZVmFmZVUydFNoMW5FUkhCTHpT?=
 =?utf-8?B?cEV5MDNrMHFIUEdkNjVtMU1TbWpXbHFRV2kyQlZYUHB6VmgyREJFSFNmamJ0?=
 =?utf-8?B?b0xCYy9Zb2JocWVnRGNJRk9QL0p6N0hkczJjZWE3dUNST1FsNjRtT1JTRjZu?=
 =?utf-8?B?QnFKcTdKN1BxRUVHWWVBQzQ3VHBmRGZMTzJWT2dvN213Y1luT2kvelBqS3Zs?=
 =?utf-8?B?R1gweCtOODAzTFpzRGUrYWU4R0xRV1U2SGVpdE42elVvcDg3ZGRHTVJrQ1dt?=
 =?utf-8?B?dmplQnI4N01WU3RaQ0FOOWM5Ri85MEhSM2xvUkdYNFRYQ3I5Z3lpcmlmeXRo?=
 =?utf-8?B?SEdQYUFsVytNNmJEOWlDMlZWR3hyRmFLRFAzMkxseFBHL2hrWDV5VllIamMr?=
 =?utf-8?B?MWc2U3h2MUVjYzdObEpDSERlc3JsZHY3clliVngvR3dxOEZzYmV6eHFIeHUy?=
 =?utf-8?B?QTNWUG0wSnZ1bTFwakVOdXkwNG5qS3dhcDlESGFXcytQSUFnN0U2dlg5YURh?=
 =?utf-8?B?WHNwcXViK09mSjU1MlBrWmNhU1VaWm54MVU5Z0VuNFZybmJiUzRlZCtvR21S?=
 =?utf-8?B?aEpkVEFIc1ZYRTBUcmlKZElNOFViZS9yd3N0b1VTMHkvREoxNUZxVlYxU3BS?=
 =?utf-8?B?TVFTbjBGSUtIQnBNTGI2T1VwMHpWcTZvS2tESEo0Y0NtWDcxWWpCUlBuUnhL?=
 =?utf-8?B?NFR2NDJxYkNJcE1ST0hJRUp1clpycjcxUXFBWisxQUIyRjNnRDBjcDZSazlN?=
 =?utf-8?B?UzA0VzMyc3RMbkJaNjNDdVdCeTZqZkQ5bmozbnhMZGwzWDZFaU5qaVdhN1Mx?=
 =?utf-8?B?SEg2Vkk4eGVRelVvdTBIbEFZcXhMZmRZdzl2QlNOV3poMVhMRXRqa3I5STVi?=
 =?utf-8?B?bmxvbUJyVThtbk1OTlo1YWhoemlJakRndEZMdkJRelVsaUxvNHJDSzZpZWNV?=
 =?utf-8?B?UFB5T01yaE50UjNuRTgrWXZGRFI2RzlueE9hYjVEYWRhK01oL1BlWldic2Nr?=
 =?utf-8?B?cWwxdXgxMlBXanJRekRtWUtxUERUN0V0OHI1eE9kWXNmWWtpV3dlUktvS3g4?=
 =?utf-8?B?VW9sVjQ2aWZ6cjBMcG9DZlQ0M05zaWdCaGhtZUtRVnF4NjVwU0RkRm1jMnFP?=
 =?utf-8?B?NzBTOVlHRFMrMUxNeS83TWp0clQvK0Noa29xajhTSHUrS2tSUEQ5NHpBdnIz?=
 =?utf-8?B?OXBqR1JYWG41NEtiSWx6Z1ZUL0ErR2lyRW0wdVZPVTZPaitvWDA1TG1NWG9Z?=
 =?utf-8?B?b2ROaUNzNDc5WHM4WjBwWHpTWnlqK01NUFhvU3VOTGtOanl4clpJc1NNTXZZ?=
 =?utf-8?B?b3RSRGl0V3hEQStKZk1qRllXUzB0THJhZS9ZOVdoYi93RXVvR1hDTDAyakpX?=
 =?utf-8?B?TTJ5RHJ0SzNBcy9kQVVFYUxNSUNWZEVLVlFpc00weE1rOG1pREhRMUFvR3g1?=
 =?utf-8?B?UlZRYm1BZjQ0OVNIZHh2VVBYVTl3bGRMSXNueUZpVW5CeTFiZ2lxKzRyZWdx?=
 =?utf-8?B?VE1QMDNkV2NKelFRZ3oxK1JIdlRPMnkwUlQvMVozUmdTUnFhejJmYWVTOHRN?=
 =?utf-8?B?MkVVbm0yMGlEbHZ2S3pqdTluMWZWQ0VwdG9mMHAxWUs0a053ekErRGs5TDVX?=
 =?utf-8?B?WjI2TEE1U1g5MDEvQlErVVNpMzdPVytYc1hLTXdqb1FNRzBiZk05dGZyY0FY?=
 =?utf-8?B?aU9rR2ljMFVhd2pIYlFqbHltRVZPNmdPNW5HTWEydmVPUkg4L2d6cW9GSS9F?=
 =?utf-8?B?OTlvdTNkWWJTRG1NK3dnTGVWSEhMeHhMSnhpajdWNXBzY1pKRTRtVjhKTFJu?=
 =?utf-8?B?Q0lIWjgrMG0ybXBwS0x0aHg5N01iN3JBaVNoalR4RUhjY1JkeHJ3OHNsTGFT?=
 =?utf-8?B?Mm95aTI5MnBCTEpBclh1VFF3cWdFSW9MUlhVazA4aUhPaW1sNXp5aFdlSU9J?=
 =?utf-8?Q?2uJHHadXlbwMn0ew=3D?=
X-Exchange-RoutingPolicyChecked: sXLD5vGtk8FEu5t9O5Vbj1uVfZ69Dnwk2Z/HUJUsfo4SY54xoTWRRkKNubOKkkrRufcmVmn4LDbD1voInV79bo/cw70GhGf/SQYPlIO4axqHc/U0Fw6YAw7kgt778RdkTbugbefA0oGV9kSRG8nnymCvW/YoYOTZrR9Rxq36+KxiNzY4ntHhZjeNQHy0df2Xm5MeNZSo0SJhjMoExIzd68DKm6yFUXp9x8laVGXMREfaSSLb87ct6uED1t6PnLeuHiU9wyw2RZCnv4Afjtumn2kW7UbcLSgyQgRyC0KYf93gMwuv7bmYAYuUp84veK18oOcA3dscETg9jYyg/IfkvQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5923d8ae-c5e6-411b-07c1-08deaabf14f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:58:00.3181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yHsT+2lF+OUdB1QPUjHlQ0dc3NOvXkRz+eckadouOeEoB268WB9mdTOQMU5EF2IPiUH4gml8H9oDk5CkXZ9ZjNg1I18GUfILG9bisf1WZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7134
X-Authority-Analysis: v=2.4 cv=IrMutr/g c=1 sm=1 tr=0 ts=69fa138b cx=c_pps
 a=n2zBTagloklpXwQiE9xBQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=EqmJ7DWz-kYQF2itRRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vCTx5NrFturVzjKB_nbJ0wJqbi3Huuzn
X-Proofpoint-ORIG-GUID: vCTx5NrFturVzjKB_nbJ0wJqbi3Huuzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE1NCBTYWx0ZWRfXzYb0UVRsU+8U
 mzTKsA7WCrul0P426f+I4D+FJ9xkSpCeOwkndQUcSClzjSnR46bh6CU4KsfL9xcvEUl1b8szS6J
 RRJjwwPjdLvjj7YEEDZtwog/Pu8qV61YgcTdwxSf8Em+9H8wxu9kw6dFzZ2DUogbBX6Z3U+hW53
 d3LYfXeN6otj7cXmGgBTBYcQ4NR5Bx2OIcXCZGGmlCbDbAi+F5iQiNgDg5HG3kFpaFoGG5YIQcr
 Vopb9ewa8UBXu6m+9WVsFeVl7G2xtSIHAT8vaiCY73faUpWuwPdPH9/JzGp6Yy94AI5HHARjc5a
 tjP8hlCuoH7ATcddNwaeUpb/QXM1mbyTimPv9FTzZvTGzsPjstFSNvfVPVI/A9ruBBtFbBj2Ni1
 1nETBbgjDIxJ/O6YsXh1YWOVQK72/WZDw8mSsSO1drDO4xSPUahTchPIsVZF8/4ClhnNdutMzz8
 rMb8sY02Fov2ZmHuecQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=flosch@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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



On 2026-04-21 23:46, Paolo Bonzini wrote:
> On Mon, Apr 20, 2026 at 11:52 AM Florian Schmidt <flosch@nutanix.com> wrote:
>> Here's another option, though I'm not sure you'll like it: We can get
>> the same information from /proc/<pid>/pagemap, right? We just have to
>> check whether bits 62 and 63 are both 0 or not for every page.
>> It's less efficient, because we have to read 8 bytes per page
> 
> It's also completely useless for the very common case of pre-allocated
> hugepages. That's the case where you can get the largest benefit,
> because when pre-allocating you use threads on the host and do the
> zeroing before the VM starts. For non-pre-allocated pages you still
> pay the price of double zeroing, but guest and host do it one after
> another while the VM is already running.

Yes, that's fair. There's another reason this is dodgy that I had 
totally forgotten about and only remembered the other week: shared 
memory's swap state is not tracked properly in /proc/<pid>/pagemap at 
all, so that's another situation where this won't work correctly. So I 
agree, that approach is useless.


> So I don't think there is any option other than the ioctl. I would
> suggest experimenting to understand how Windows uses the hypercall;
> and possibly looking at the QEMU write tracking part. The KVM changes
> are relatively simple and for quick experimentation you can operate as
> if the KVM bitmap is always entirely zero, not unlike this patch.

I will look a bit more at Windows, but I think generally speaking, we 
can probably not make final and never-changing assertions about when or 
how often a guest would use this hypercall.


Regarding the QEMU write tracking: I'm not very familiar with this code, 
so I'm still working my way through it wrapping my mind around it all. 
But at this point, I wonder whether there are advantages to not using 
the current dirty tracking wholesale by adding a fourth option (vs 
implementing something separate). What we care about is slightly 
different from dirty tracking: we only care about memory that QEMU 
touched, not about dirty-tracking guest pages via KVM, which is quite 
tightly coupled with the other dirty tracking approaches.

It means we have to support another tracking mode outside the existing 
DIRTY_MEMORY_* ones, but on the plus side: it allows us to easily set a 
different granularity; to not allocate that memory unconditionally at 
start even if the feature isn't enabled (though once we have the 
different granularity, the overhead is much smaller); and we could skip 
any hotplug support logic (having to extend the bitmap) since Windows 
never enquires for hotplugged memory anyway (though maybe that will 
change at some point in the future and could be neat to have eventually).

For migration, I'm still thinking through the implications, but one 
option would be to just say "after a migration, nothing is pre-zeroed 
anymore".

I'd be interested to hear your opinions on that.

Cheers,
Florian

