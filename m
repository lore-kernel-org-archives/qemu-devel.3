Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117B9EB362E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx8Qp-0000I9-8v; Mon, 02 Mar 2026 13:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx8QX-0000Es-Fw; Mon, 02 Mar 2026 13:55:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx8QU-0005Bj-0m; Mon, 02 Mar 2026 13:55:31 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622ETJYx249402; Mon, 2 Mar 2026 18:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=SfZiCDBY0+MfU1d9sO3vjg+1yhlrjJvjAhBXhA5cWQA=; b=RS
 bCY0EQ6ps3QajNbNM05y21I8ZumN/f/jr0cxYetztyR0Cj+Xqtnrqao9KlADNcyy
 2m05ygMg5k5ACUfLe6vG9X+voDjANRmRV3Qg14YFUdjBsvGHTUwALqs1uQ2whQ5G
 TLfwVGBbbeOFtCCuCqoKqAmFHLfls5bNLQ2//20CFjHPhpGZm+x0mvGj+Oq1hSdq
 Ps3dmXLRtLG6Ml6ripVcZSU+DpEct6Q33nxlcdA1Bnmqv9iwlpAQBemUHm1VMglp
 udeFFCU20omDi+Rb2+GRC3BXFaRaZaPpHn8L2crAczuN0MtxASW+voaCga2FqIc8
 INZLFy+io+Kn8wcxDoBg==
Received: from sj0pr08cu001.outbound.protection.outlook.com
 (mail-sj0pr08cu00100.outbound.protection.outlook.com [40.93.1.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmw64bmxf-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 18:55:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCagoSviod7no8GU+nWRILvP3cWpqzb/a1cxN/oX206LQSMm3KTOgqlvAxnFPZq7a87IVq1kQGnX+q6VxrTtu5EbaItMAKwBz6w3skha+XSe+wt27dlLBv6DIRLulkobPUXhzsecOm8bsfOcAuYiZcXSdUUauQzs3qBFFrVYFAtxfEARDdI1JVSncy/YEz0CtcSH0aKzHeV8Hk5ACYkbx5jBiyfymeWsPOoItS/tR2Q5rAYQfgqjS049CcNRKsIRMyaIBrIHFImXG8iTJOmzjCpMSCPqQQ7uuISZi5q4u/R4YFVceHFOZTqG9nNl9W5n4bKwhxxnVA9njo57vw/Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfZiCDBY0+MfU1d9sO3vjg+1yhlrjJvjAhBXhA5cWQA=;
 b=vrxc9peQv3ajdWrbFwdrCuMyv46ASE/qCSriaHrK6x5JuGBQPorYXZ0rWAaIAZEMS1RCKzK/Gr0aDoQsyV59IrC85oZCZU6ndh399VnJMzPqEmoIXaDwpju0LN/5tI/yr1/vt1qsesjJjQHbzDCtITVc6KY8fENW2axvDpFnWKEaOKbreljD4EdCTTSNxxtxkWdfPZjsZFrvHhEQZfWr+bbaTqehfmWgSlev8xlhzTtfSPrDBnUipxmoU3IJCfEEA75WFcIWrNFxD7im8RmeR+EZnKpSLn5GF//5Ilqqw+PbnvAoW/3spNrMmuVDMGUDDHeeZzcP4Wj64wPsUAISUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL0PR02MB4435.namprd02.prod.outlook.com (2603:10b6:208:4a::23)
 by SJ0PR02MB7149.namprd02.prod.outlook.com (2603:10b6:a03:2a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 2 Mar
 2026 18:55:11 +0000
Received: from BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0]) by BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 18:55:10 +0000
From: Radim Krcmar <rkrcmar@qti.qualcomm.com>
To: Drew Fustini <fustini@kernel.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?utf-8?B?S29ybmVsIER1bMSZYmE=?= <mindal@semihalf.com>, Atish Kumar Patra
 <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Vasudevan
 Srinivasan <vasu@rivosinc.com>, "rkrcmar@ventanamicro.com"
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>, Chen Pei
 <cp0613@linux.alibaba.com>, "guo.wenjia23@zte.com.cn"
 <guo.wenjia23@zte.com.cn>, "liu.qingtao2@zte.com.cn"
 <liu.qingtao2@zte.com.cn>,
 "qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH v5 4/6] hw/riscv: implement CBQRI bandwidth controller
Thread-Topic: [PATCH v5 4/6] hw/riscv: implement CBQRI bandwidth controller
Thread-Index: AQHcqnYYk6Q2lyE/sku4nQKT+eSi8w==
Date: Mon, 2 Mar 2026 18:55:10 +0000
Message-ID: <DGSIWQJG3RDB.I5PHN8YZ2953@qti.qualcomm.com>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
 <20260201-riscv-ssqosid-cbqri-v5-4-273ea4a21703@kernel.org>
In-Reply-To: <20260201-riscv-ssqosid-cbqri-v5-4-273ea4a21703@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4435:EE_|SJ0PR02MB7149:EE_
x-ms-office365-filtering-correlation-id: ca26aa94-2910-4cc7-94ac-08de788d3a84
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: dk1dqf5YlOtvtbjubol8tGcH1ow4sbx0BtHRLR52YKuDWx23p8NNrjxR5gLeXejkgmWJXU805w4CTvortQ3jM7p17O3DJJpiY+2J6EVncadeTBk3HKwrHYu25HXJ6AIit/vmO2cWNJChO1bYaTCiFlIngQ98E8O9tVjTl5miTwcgmDKRb6eOA8y8MHUvJEowc5ZxwVZTigR0ddUgEuvzv16bx6Qsjp1NTDIPkU1O3fnXh5AKpJlyI7aZEByUDC98aQb3pRVAqtlWdIs2mF2fQ5zPtj7XAidLa6iDUAjTPiYefo0LfpegllS8sL27jWs41ni2vHIqmtjoauff9E/utXaNcisrWQO8aX0ZQM+akYDcOpB6zY+IfkomCib2Ud2rrnt6/2sKX228R8UE/5bMwkvkcXWhDsn2UZt9gmXooXWb9VaZxVwbVYLyWhc6BhHok/DWNMuyTXqJG3RMRjmGtgGXuc5c13yGQfDavP56WqNOD8kzBmt/d+o/jjV1i84vppYxfYAdqorKeq/sb3yPl2DazDNO6F6E8yVVgiyljvbSlQfQTXngg91ef2X/CHv5W/BA/B3lq2Jir4zRLnGuLqHIhjPpyd1arJtjeJicgr7Ik7NQAeMJ/pbHsmfKfHhoRfJJmttv47rd1ovTf5di91gVZX44+mztXFWdFQk++1r60Q38nhlWGvUFlZrHmo9yU9ChPZ0nn66KKh1J3CvsEH9cRnDEW5NuoUAPqN+2SJF9xM6IAc4MCWqYEGEnZt2M1gQuwPxnpOxwpdAnN8wJo/H5BdsAKJnAEKeLWRc4oaU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB4435.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXlIYUlxL2RFWG4xcDNjM1U1ZVhrejZ4ZTM2VU85bFE5SU9keGFvY1U4U0l0?=
 =?utf-8?B?VEpTZ2d0OFJpcHFGVHVMTTEzZHA3ZE8vWmptVlA4SWdnN0xOMEgwajk1aTl6?=
 =?utf-8?B?VGtTSWdwUC9rZVcxWjlSdjZ3endyeGh5YVZqTjNxeXZKVmRrNHZCU2M5N1BX?=
 =?utf-8?B?WDR4THNENTg2SWg3QkFPb3Fzd1NyU25LVmtUQmRzYXVoRHhHcnZZQ3N4Z1dZ?=
 =?utf-8?B?akpObmloWXl6MW1BRWd2Vk5Ld3p0MEJKTDRRdG43Q2ZZWkdKbXJkZEJnNjM1?=
 =?utf-8?B?UWM5bW9hRzJDbHN2V2xhTzNWVmJMckdCUVZ5VUZhYVY0ZHo2UG5oRUlVdk1Y?=
 =?utf-8?B?by80L0l0SWdMeGpHZ2lKanpyMEZNN0dvSGVuMTRwTmMrbEtSNFZTRnhXajcz?=
 =?utf-8?B?NjFpeS9tV3FIOUlKM0Z0bG1tZmErRE5neExoRzRsSmZneWQxcU1QS2kvcE0x?=
 =?utf-8?B?eUtBWXo0cXJJaVVBNm01ckNaMlhxMmpXdlBjcXdzSjU1Um9uWGVwQnRLWkJZ?=
 =?utf-8?B?MVNDdGIyVFo2RHNMaitrbjVVZGdaSXNWUGl0T1EreHFWV2pUL0V6S2QxYXpD?=
 =?utf-8?B?ejg0TE9HYXpDUitLdnRMY3pYK3dLK0dsQmhzeTJ5ZjZjQm5IUWEwbEtVWkRo?=
 =?utf-8?B?Q3Z1bERXSklNVWNzSGkrNkh0NlpuMS9VYVFXMi9zdkRITDVNUXMyaGwvSCsz?=
 =?utf-8?B?QWxkWG51aWh2Wk8zMERZdGcvL085bG9OWmp1Zm1sWlVPc3RPZTNaNkVLZUZQ?=
 =?utf-8?B?VFRWM0JOUEhya1hQT0NZaXBrdjYwakdoL3NoMldMcFVTN0JmRS9Oa0ttT09X?=
 =?utf-8?B?a2ZxNHhQclJPT29GZjhSMGkyK241eEtGV21oaUcraGFDRHNnRzhKTlhFM0U0?=
 =?utf-8?B?aUl1ZWVXV0hqZ3pXZ0Nid2lZb0FWSzA5QkhBRTVneXcvNFk2TFVtL21lRkF0?=
 =?utf-8?B?a2ZmTllZNU5DRTl6NUVYOCtxNkh0aXBmSFdqSmdVZE9ybzBxOWwxMGRKVlpn?=
 =?utf-8?B?bDY1MVpXVm1zQVZhOERWL1dhdlpSUkJueDI2ajdXN2FoOXI5MTB1K3V3MzJi?=
 =?utf-8?B?UFRqeWxROGlNMnhwRzJsRzg2cDRYOWpDMjQwSUlibitnbFRydWJJWXFOTGow?=
 =?utf-8?B?d0FrUXFaOXpRYytTd3k5SWN1WjdkSjJaUjRMbTlSV01BalN0UjZHNHdNSkhQ?=
 =?utf-8?B?aURQSzMrNEZ1Uk9PZS9VaUdoaC8vMTF5TUl1bGRMZkZXbnM0dWpoZkxNYUdW?=
 =?utf-8?B?YUZHYVJXZGVLWVo1cXBnL0ZJNW1NTUlPdHE0amhad2VmY25VaHptaFFSTVZQ?=
 =?utf-8?B?ME5ybmNULytIc3BEMUU5Q1JNWXpJV1lQWDNnK3FOV3ovNzg2QXFMeTFtZ3VK?=
 =?utf-8?B?M0hZdjY2MzMvdnN5aGhxMU1SL1V0M0dvMzAvd2xNdWVsWmZwQkJ0cTdpSFls?=
 =?utf-8?B?NXNacHRZOGdWcUVnVzFWUkM0TGpENmpKZklrNEZRVWxabktwb2ltS0ZpM01K?=
 =?utf-8?B?a3pWYjZXQlVnMXNkS0dXb2dSVGZFdko1d29adzdxV2oraTcxWHZwNlA5NWF0?=
 =?utf-8?B?WVRoZkhKT3dXN1E1MmIvdWhObzNMams4L2J2aHFnY3AvNFNlbSt4RVRybWc1?=
 =?utf-8?B?dmV2T3FUeDVNK2JvR0NQNFNBaFFJbDB3elZsd0F5SVlnWStYSlFzeklBNXVQ?=
 =?utf-8?B?alQ2dUZibll2aGhHTWZFaW5FQXN0enN2K1hCdXM0NVI1ZndZS1N2UkN4RHFy?=
 =?utf-8?B?czg5bzNuWXJTZU9wZ2NBQWhJNXdJWG02T2lDOWhJeGpmUWlCTVAwYkxBRHA4?=
 =?utf-8?B?NngrWlo1enJLeCs4aXFuZ0U2TE5aV2YzQ3BDdlBGMExjcUsrSm00UjNUNTJ6?=
 =?utf-8?B?T0tVT0J4SndtNGxDR2dRdnlTZm4reUczNVpSWkw1TDFBSWZNTmY0RVVVUWl5?=
 =?utf-8?B?ZFJpd2VvTHpyOVdYUy9kVXEwMCs0QThkZUlwNnBrTmQxWkFDc0lDZ1ZEOUxj?=
 =?utf-8?B?cUtiSEg0cDE3UDZmdkxOdHMxWHZMendqbzFiNUFDbDFsK1NqeE96M0krN05K?=
 =?utf-8?B?UEM2UW53aVkxakJoL2FmaGtuYVlOSGlxR0VsaFJuNUNncWJMc1Q3VHYvL3F1?=
 =?utf-8?B?L2tqbnRFbW9FTlFKaHpvRm1kQ0EwcS9PMXB2ZStGT1Y3M21Pc2VtSTg5R3dq?=
 =?utf-8?B?UkdzUzRTQmk2Q0RyYkNtTkp5bHBSamE0OFZ5dzZRaDBqT3NHU1E5R0VXM2pC?=
 =?utf-8?B?U2VLZUpwNExEVldwVU5PNU51OXdpQUMzZTlGUG8ydzhMZktGdU1YWk9aS0Nt?=
 =?utf-8?B?eHFwRmZjR0poM2hYL0xyY3I1L2ZvblYwTis1ZjdWRldxdTB2ZjErMzBROU93?=
 =?utf-8?Q?IhG0eNwqbtlN5yM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D1ADD83F1A2E0439A2A9C8549FF6F77@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: twYehb6cG2nFT0RM14P3Yy98w2VkfRrz3zql23dE6bjN5prkiOVhT5qRqyYSTo4BJSVouauRo2EZlCpEuLqr7q2VmbdSzIr435mUNdVMb6Pmf9zEYgACfaxonLLYjaJ/WpHAEO0ndTRHVhCJDu7U869zNOyO9fABKIZR71PQ9452Z3RSH4FgYWGizfvaQGJ6D9XhP5PEG6JItfX+DqnZv5pu4l14KBfUZgPA7q0SKHhRmftPI5KbG+T4wWAbzIueCrrCzik3QLe1vhETMADhGmtv4cpTBosc1SerzuMmS9Eb0jMojv7tBzq2x8Hi0BZujufb/1Mlx9H7w4gN6M/INdqxRaf3PniTlxP3vT5QWvNtOE0VxZLgQ1DLWdtlmXTN4fnlmasoRj6IfsdJGefco5nIsI546UXCBDG6nXx19H4AdmULLvHJiN3KDkB5WsvBP/kP91x5u7tnP6OG824tarYkI0dE3BvZ0YGNfjpzpV6TUknT/q2FkUCfB2lpWQu94nerrs+DoQCaaEg2rohMyhQ8cj3pxhBfrJTne07iWXRu+La62qRo6cOMatCd9xer4G6HW1b0FTXjV5BLEFhgbDw2ca+Kzz7M0Dx4bcwM1+3kLQxi39vbUFUVeyjeYTv6
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4435.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca26aa94-2910-4cc7-94ac-08de788d3a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 18:55:10.0413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfrytbQ69wwkfGBWELLdN7IMRyTEhqO+TFYighKMChx/+L0bxmtxyrt7VnC2NcxPJww8ek8cSO349PuptzzCAVHN0FRz4AuN6SeRULY92y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7149
X-Proofpoint-GUID: g8hH3jcVv1U8cVg8bZ7olwUVwOXvtxK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0OCBTYWx0ZWRfX82bdS08voaNJ
 pzYOfRR7Nxz5l4wDJ16dWTaXUTEqORM66jtQjbfl0lFH5z1LuFyShTBlLwOvETnKWwSyh4sGKl9
 x+cYx1Lh9a3MAHFEzz/MSA+8CZ3ExkPlPJQA6MzknLAUjLLMxaGtROxheZpNoisZ4CFF3y0D/qo
 mxAkmBZ2FvA9oB5EAazT7Q5qglwzseHeXotgzD1jkx4DYjWZAYKMMvjaibB6UAsfC4gkhQWLZ77
 Lg/MW39G9HihrLUGOfuofFNnaP9bLmu/W8swWAqNhz4q+UwsQgfl08egbOAQqddlDufMqrxlLyh
 ZzVjf9KucP+O4tjIrtG9PfRK6goOPXciryTmPs7puOKuZnQy1OU6wmjKy0VgCJb2hquky9zrk94
 B88drW91ljYFlghV7Com6+zu9GS29MOU3f9pHr/wLommkmaPnZeFAcvFS7HG+VEJaA5E9dSjSZK
 N+opyGUJSxfbb7nOvkw==
X-Proofpoint-ORIG-GUID: g8hH3jcVv1U8cVg8bZ7olwUVwOXvtxK2
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=69a5dd13 cx=c_pps
 a=uKiHT0CEEWUIj7nPKFokmA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=V1jnuoLLAAAA:20
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=jg29CeQtiupYPoQmQn4A:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020148
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=rkrcmar@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

MjAyNi0wMi0wMVQxNTo1ODoxMC0wODowMCwgRHJldyBGdXN0aW5pIDxmdXN0aW5pQGtlcm5lbC5v
cmc+Og0KPiBGcm9tOiBOaWNvbGFzIFBpdHJlIDxucGl0cmVAYmF5bGlicmUuY29tPg0KPg0KPiBJ
bXBsZW1lbnQgYSBiYW5kd2lkdGggY29udHJvbGxlciBhY2NvcmRpbmcgdG8gdGhlIENhcGFjaXR5
IGFuZCBCYW5kd2lkdGgNCj4gUW9TIFJlZ2lzdGVyIEludGVyZmFjZSAoQ0JRUkkpIHdoaWNoIHN1
cHBvcnRzIHRoZXNlIGNhcGFiaWxpdGllczoNCj4NCj4gICAtIE51bWJlciBvZiBhY2Nlc3MgdHlw
ZXM6IDIgKGNvZGUgYW5kIGRhdGEpDQo+ICAgLSBVc2FnZSBtb25pdG9yaW5nIG9wZXJhdGlvbnM6
IENPTkZJR19FVkVOVCwgUkVBRF9DT1VOVEVSDQo+ICAgLSBFdmVudCBJRHMgc3VwcG9ydGVkOiBO
b25lLCBUb3RhbCByZWFkL3dyaXRlIGJ5dGUgY291bnQsIFRvdGFsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICByZWFkIGJ5dGUgY291bnQsIFRvdGFsIHdyaXRlIGJ5dGUgY291bnQNCj4gICAt
IEJhbmR3aWR0aCBhbGxvY2F0aW9uIG9wZXJhdGlvbnM6IENPTkZJR19MSU1JVCwgUkVBRF9MSU1J
VA0KPg0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vcmlzY3Ytbm9uLWlzYS9yaXNjdi1jYnFy
aS9yZWxlYXNlcy90YWcvdjEuMA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGFzIFBpdHJlIDxucGl0
cmVAYmF5bGlicmUuY29tPg0KPiBbZnVzdGluaTogYWRkIGZpZWxkcyBpbnRyb2R1Y2VkIGluIHRo
ZSByYXRpZmllZCBzcGVjOiBycGZ4IGFuZCBwXQ0KPiBTaWduZWQtb2ZmLWJ5OiBEcmV3IEZ1c3Rp
bmkgPGZ1c3RpbmlAa2VybmVsLm9yZz4NCj4gLS0tDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9j
YnFyaV9iYW5kd2lkdGguYyBiL2h3L3Jpc2N2L2NicXJpX2JhbmR3aWR0aC5jDQo+IFsuLi5dDQo+
ICtzdGF0aWMgdWludDMyX3QgYmFuZHdpZHRoX2NvbmZpZyhSaXNjdkNicXJpQmFuZHdpZHRoU3Rh
dGUgKmJjLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcmNp
ZCwgdWludDMyX3QgYXQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29s
ICpidXN5KQ0KPiArew0KPiArICAgIEJhbmR3aWR0aEFsbG9jYXRpb24gKmJ3X2FsbG9jID0gZ2V0
X2J3X2FsbG9jKGJjLCByY2lkLCBhdCk7DQo+ICsNCj4gKyAgICAvKg0KPiArICAgICAqIEJhbmR3
aWR0aCBpcyBhbGxvY2F0ZWQgaW4gbXVsdGlwbGVzIG9mIGJhbmR3aWR0aCBibG9ja3MsIGFuZCB0
aGUNCj4gKyAgICAgKiB2YWx1ZSBpbiBSYndiIG11c3QgYmUgYXQgbGVhc3QgMSBhbmQgbXVzdCBu
b3QgZXhjZWVkIE1SQldCIHZhbHVlLg0KPiArICAgICAqLw0KPiArICAgIGlmIChiYy0+YndfYWxs
b2NhdGlvbnNbMF0uUmJ3YiA8IDEpIHsNCj4gKyAgICAgICAgcmV0dXJuIEJDX0FMTE9DX1NUQVRV
U19JTlZBTF9PUDsNCj4gKyAgICB9IGVsc2UgaWYgKGJjLT5id19hbGxvY2F0aW9uc1swXS5SYndi
ID4gYmMtPm1yYndiKSB7DQo+ICsgICAgICAgIHJldHVybiBCQ19BTExPQ19TVEFUVVNfSU5WQUxf
T1A7DQo+ICsgICAgfQ0KDQoidGhlIHN1bSBvZiBSYndiIGFsbG9jYXRlZCBhY3Jvc3MgYWxsIFJD
SURzIG11c3Qgbm90IGV4Y2VlZCBNUkJXQiIuDQoNCj4gWy4uLl0NCj4gK3N0YXRpYyB2b2lkIHJp
c2N2X2NicXJpX2JjX3dyaXRlX21vbl9jdGwoUmlzY3ZDYnFyaUJhbmR3aWR0aFN0YXRlICpiYywN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgdmFs
dWUpDQo+ICt7DQo+IFsuLi5dDQo+ICsgICAgaWYgKG1jaWQgPj0gYmMtPm5iX21jaWRzKSB7DQo+
ICsgICAgICAgIHN0YXR1cyA9IEJDX01PTl9DVExfU1RBVFVTX0lOVkFMX01DSUQ7DQo+ICsgICAg
fSBlbHNlIGlmIChvcCA9PSBCQ19NT05fT1BfQ09ORklHX0VWRU5UICYmDQo+ICsgICAgICAgICAg
ICAgICBiYy0+c3VwcG9ydHNfbW9uX29wX2NvbmZpZ19ldmVudCkgew0KPiArICAgICAgICBpZiAo
ZXZ0X2lkID09IEJDX0VWVF9JRF9Ob25lICYmDQo+ICsgICAgICAgICAgICBiYy0+c3VwcG9ydHNf
bW9uX2V2dF9pZF9ub25lKSB7DQo+ICsgICAgICAgICAgICBiYy0+bW9uX2NvdW50ZXJzW21jaWRd
LmFjdGl2ZSA9IGZhbHNlOw0KPiArICAgICAgICAgICAgc3RhdHVzID0gQkNfTU9OX0NUTF9TVEFU
VVNfU1VDQ0VTUzsNCj4gKyAgICAgICAgfSBlbHNlIGlmICgoZXZ0X2lkID09IEJDX0VWVF9JRF9S
RFdSX2NvdW50ICYmDQo+ICsgICAgICAgICAgICAgICAgICAgIGJjLT5zdXBwb3J0c19tb25fZXZ0
X2lkX3Jkd3JfY291bnQpIHx8DQo+ICsgICAgICAgICAgICAgICAgICAgKGV2dF9pZCA9PSBCQ19F
VlRfSURfUkRPTkxZX2NvdW50ICYmDQo+ICsgICAgICAgICAgICAgICAgICAgIGJjLT5zdXBwb3J0
c19tb25fZXZ0X2lkX3Jkb25seV9jb3VudCkgfHwNCj4gKyAgICAgICAgICAgICAgICAgICAoZXZ0
X2lkID09IEJDX0VWVF9JRF9XUk9OTFlfY291bnQgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAg
YmMtPnN1cHBvcnRzX21vbl9ldnRfaWRfd3Jvbmx5X2NvdW50KSkgew0KPiArICAgICAgICAgICAg
aWYgKGF0diAmJiAhaXNfdmFsaWRfYXQoYmMsIGF0KSkgew0KPiArICAgICAgICAgICAgICAgIHN0
YXR1cyA9IEJDX01PTl9DVExfU1RBVFVTX0lOVkFMX0FUOw0KPiArICAgICAgICAgICAgfSBlbHNl
IHsNCj4gKyAgICAgICAgICAgICAgICBiYy0+bW9uX2NvdW50ZXJzW21jaWRdLmN0cl92YWwgPQ0K
PiArICAgICAgICAgICAgICAgICAgICBGSUVMRF9EUDY0KDAsIEJDX01PTl9DVFJfVkFMLCBJTlZB
TElELCAxKTsNCg0KVGhpcyBjYXVnaHQgbXkgYXR0ZW50aW9uIGV2ZW4gaW4gdGhlIGNhcGFjaXR5
IGNvbnRyb2xsZXIuDQpNYXliZSBhIGl0J3Mgd29ydGggYSBzaG9ydCBjb21tZW50IHRoYXQgd2Ug
c2V0IElOVkFMSUQsIGJlY2F1c2Ugd2UgZG9uJ3QNCmFjdHVhbGx5IGRvIGFueSBib29ra2VlcGlu
Zz8NCg0KPiBbLi4uXQ0KPiArRGV2aWNlU3RhdGUgKnJpc2N2X2NicXJpX2JjX2NyZWF0ZShod2Fk
ZHIgYWRkciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgUmlz
Y3ZDYnFyaUJhbmR3aWR0aENhcHMgKmNhcHMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IGNoYXIgKnRhcmdldF9uYW1lKQ0KPiArew0KPiArICAgIERldmljZVN0
YXRlICpkZXYgPSBxZGV2X25ldyhUWVBFX1JJU0NWX0NCUVJJX0JDKTsNCj4gKw0KPiArICAgIHFk
ZXZfcHJvcF9zZXRfdWludDY0KGRldiwgIm1taW9fYmFzZSIsIGFkZHIpOw0KPiArICAgIHFkZXZf
cHJvcF9zZXRfc3RyaW5nKGRldiwgInRhcmdldCIsIHRhcmdldF9uYW1lKTsNCj4gKyAgICBxZGV2
X3Byb3Bfc2V0X3VpbnQxNihkZXYsICJtYXhfbWNpZHMiLCBjYXBzLT5uYl9tY2lkcyk7DQo+ICsg
ICAgcWRldl9wcm9wX3NldF91aW50MTYoZGV2LCAibWF4X3JjaWRzIiwgY2Fwcy0+bmJfcmNpZHMp
Ow0KPiArICAgIHFkZXZfcHJvcF9zZXRfdWludDE2KGRldiwgIm5id2Jsa3MiLCBjYXBzLT5uYndi
bGtzKTsNCg0KTWlzc2luZyBtcmJ3Yi4NCg0KVGhhbmtzLg==

