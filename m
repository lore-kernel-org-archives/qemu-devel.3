Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837CAD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 19:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSgye-0000FI-1t; Mon, 08 Dec 2025 14:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vSgya-0000DR-DH
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 14:32:52 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vSgyY-00081o-A9
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 14:32:51 -0500
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B8JF1Ut3528585; Mon, 8 Dec 2025 19:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=LWG5GA5D0nN7+SiEseunLvmpyV3JHDvoyAjb85imYM0=; b=
 Svq2BUUEHflb/z58GzeJ7EB7HNIutO14bH1qCMa/EM3/vLqROx/SfN0L+6w7oCDE
 77iFWhIsclClz6Dr02IT8m9TiFsi7ouhY2KOqbkUjCA+3Gd6+R6N8WabjaAnmq2D
 S3cXgc5Oa7CroNOJzBp68wz2Ohdo5EpTeuZKVc/pNsxYbQdMsJV8BI5vdkabG9qQ
 ziE2rkmJJAw8nzgpX3N4cQr7dmLkW5fycJHzlXhSkesBBHLoHHd/k6X5eDkTgeUB
 dM3BC+Pmup/cbbBx6c6NSrGbij37egWWxkbzhO+9w/m1A7L0qVrIKWhOensGtqyQ
 3hC9pA4mmpImBoswvcPshg==
Received: from prod-mail-ppoint7
 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be
 forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4aw09dqe6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 19:32:47 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
 by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B8IJ79t027449; Mon, 8 Dec 2025 14:32:46 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4avgq11pau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 14:32:46 -0500
Received: from ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 11:32:46 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 8 Dec 2025 13:32:46 -0600
Received: from PH0PR07CU006.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 8 Dec 2025 11:32:46 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by MN6PR17MB6851.namprd17.prod.outlook.com (2603:10b6:208:46e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.4; Mon, 8 Dec
 2025 19:32:42 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%5]) with mapi id 15.20.9388.009; Mon, 8 Dec 2025
 19:32:42 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>
CC: "berrange@redhat.com" <berrange@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "armbru@redhat.com" <armbru@redhat.com>,
 "mark.kanda@oracle.com" <mark.kanda@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hudson, Nick" <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Thread-Topic: [PATCH] migration: cpr socket permissions fix
Thread-Index: AQHcWk+Ww41l0upbvEuzSutbKZyWdrT9TVYAgBRdCACAAZRjgIAEq6SA
Date: Mon, 8 Dec 2025 19:32:41 +0000
Message-ID: <85437E51-DEC6-4B79-8E5E-93B5D64D4CB2@akamai.com>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local> <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
 <aTL2j7PB4--w68ir@x1.local>
In-Reply-To: <aTL2j7PB4--w68ir@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|MN6PR17MB6851:EE_
x-ms-office365-filtering-correlation-id: fb62b810-111f-439e-f924-08de36908e0e
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?U0JzWnFrZ0RVT3VwS2dvVUpZRHk4ZWh6b1ArcUg4K29wcHlXSFJ3SmlzVm1J?=
 =?utf-8?B?Qmh0NmJrbktQS3F3MnJEazdWY1YzQzRseStFaFB0QWZ0RXRzUzl2Q25RQ2FJ?=
 =?utf-8?B?czMrMlpWSUQ1SVRONyt4clN1bUtoUlRjb2laT2l5a3hFblFVMWMza1NmK291?=
 =?utf-8?B?dm5HTzVwclYxU0FhSTZkck94VktMV2FoMERvYzVhSllyQXhkL1AyckcvSGd2?=
 =?utf-8?B?YlBOK2YzMXA1N25FNURlek85N3Y2cjJ5SHJQT0Nsd0pyNWYyaGZqVVE5TGZJ?=
 =?utf-8?B?ZXJrZTJ3QmVjN1M1Vkwrdmp3RkFqTnMxVk1lRXJ4ZXpDQmJCVHlvQVFoQWlq?=
 =?utf-8?B?RXVQWC80cWQ0bmFXamJSTDM5NmZDZUgra24xUUZ4dmE3VlNVQ1lpeTN0dVlT?=
 =?utf-8?B?VElmSEZuN1pxVFlVc0huL0YwTVF4eGR2WitQRjZiSnBTdDUxZ3M4SWkzaUJF?=
 =?utf-8?B?Y1pkVkRaYmVNbHhPb1FNbS84OUw3Vy9rcG1OS0prbkt1cEVGYzMzQXM2SmNP?=
 =?utf-8?B?SFhraEUyVGxXQjJzZ1F2akxOUzJUemUrL0xZb1YvazFHOUtpYmROK1FhK05s?=
 =?utf-8?B?cjU2NGh3azgrb0EweHgwZEdzcGZzd0VnRjQwWmJwUnMwWE9wQ1FoYWtvSWQz?=
 =?utf-8?B?OTJXakNaeDJ0S0RSSEhqTkFMVXh1NU5Wb1pJTlNPZWlsZTFGalZseUZhVThx?=
 =?utf-8?B?WmJXWm9iMktadk1IcEZtS3JxZ3dJa2JDMVAzSmhOL09NNnhGWitTdEpKd3Qv?=
 =?utf-8?B?T2k2bWxqZGE2MWRkbk15KzdHNm1FZWVNenc1SEFicDNkbVVKUVFSRWtFbW1m?=
 =?utf-8?B?b25TTFgxWlBBR2F6bVZrVCtEZ2lwSkdXc0xoUHJpMUdjSmJOU3llNFRZV2Zq?=
 =?utf-8?B?c1RMVnlkS1hGczBPS0ZjaDZUQ0tMRjdoTXhPM0JpRmRjUzBCWTB2N3RFMlpz?=
 =?utf-8?B?L2FzUjBhYzZFU3RlMU95anVKWXlyV0MrNXRLK3FmNmRaWDBIVUZtQ255S0xH?=
 =?utf-8?B?eVBkakhFcEU1OTUxaUU5T3hCRC9IcjJMU2JYMk1BTURyZHNHbTV4NkNkc0xs?=
 =?utf-8?B?K0tUaGJkYTAvVDRqM280eWYvbFBTcERISCtUWjd4bUtjd0kvelNiWWpuMm1X?=
 =?utf-8?B?ZHdHVnBhcCt2U25ITTFRRWhrOUhNb0hYbTh1NGdnczk3TEdldnBHVUtvM1ZH?=
 =?utf-8?B?Y0lweWZaNzJnSDJtRXRQZEZPVTZsVDFtcjh2Q0dkbklla3N6RU5jTUpydXlC?=
 =?utf-8?B?VE9TRk5FSkFTTDYwOFVsR1pTSjNHVEpKT1hYOG9oNTJkb2taVGQyRG41ZmFq?=
 =?utf-8?B?TWxxd2U1NXVxRVBIMnV6cGxQSzAzMStJL3NvTUQ5UWorWTBqMERxYzhRUEVl?=
 =?utf-8?B?SGVVaHRVT3pKeGYvdUJJLzBWMUtFQVFtSVFocVdVcjhhQlcyeGZjZXVOUFJv?=
 =?utf-8?B?SHpNRkI0L2xhWjZmOFc2SGRVcjlYU2EzajhXeURwbEhpS0pYWnFwZVNHT1Vk?=
 =?utf-8?B?OGNKQTBBZzhVU2dvSm15eDE2U2hqZm1SdlhTSHhBTmpZeGoxTXUzOWZGMWZ6?=
 =?utf-8?B?YjVyWU5GKzdHSWwvdTVFeTF1Q3hJOEZkblJxR0xNemlvQ3lrR1lwTHFpRW4y?=
 =?utf-8?B?M0ZEaXdxQ1l3WU5yOG9FOS84Y3N4UGlaMjJYSXU2SmRCQ3Z5TjFDRCt2eXJM?=
 =?utf-8?B?YjFYc0tmZzBMYStiZ1VNdTc0azB2VDNibmd4NytLSTlEY2RRcFNUSnJEYWlr?=
 =?utf-8?B?Ui9Tdy9SR3M0a1IvSkl0TmFPL0dUVzd5L0dXZEdjeVVKWlNMWXduOTJHQmtL?=
 =?utf-8?B?V0psbnowTm1TZng3cUpiTUpwYVlxbWxPcllyT09XK08vczJIYTBOZWdyZFlO?=
 =?utf-8?B?NEpianpScFlhOFJDQi9NZUxkR2c5UTFlc205V3cycFVjU1dMeWpUTWJlWmE5?=
 =?utf-8?B?RTk5ZHN2cGdRbEJYRzBRaDIzMldUbUR3Mk1NSGxORGRBa3NjWDk1VVdjRS9N?=
 =?utf-8?B?ajZ5aDlRaTd2VzEwV0ZlSEdScXlrV0VreSsrQ1VmMXdvVFlZUWNNWFNHMjlY?=
 =?utf-8?Q?N7sgIv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1dqWkhlVjVkNUJETDcyTUtLSFdwcjYxT0ovWU5VMUFTK0xseW5OL2VMSDE3?=
 =?utf-8?B?OEVBbmJPY2Zzc2dSUTR0azExbXRkWjR6bWw5a2d5YktuOEVRdEdtQXcwUmUx?=
 =?utf-8?B?TG4zQ2tQL1NBNnJ0UVNiQU5rdTlWbzd2dEV4MWpmamVwNlFVT0xRQyswWDZv?=
 =?utf-8?B?SWxaTHVMMmF5TkFjV1JOVXFaSG5EN2dCb1h2bnFKQUorblJkWVNXR0hrMDZt?=
 =?utf-8?B?SjdXRVN2QkJ2WGFDSWM0UDdKRFhLc1lLTGJJRFFSN3lmR0ZwYkw1alJuelRT?=
 =?utf-8?B?ZTFyYkNpM3VMSVVOcVVtT0xxZTJoSzZ0LzYybk0wSWxQaUlKbGlzc1JGTXRj?=
 =?utf-8?B?U0RnbjE5KzRUZ3NCQnVGM1NVdENtSmVxeW9VMW03UXBPWS9GTG5vbmtoTHRa?=
 =?utf-8?B?QkNsS2JSUG9RNGhaQmxyNHZERC9VTmtZbFE4aHo0TGdkck5oZURPdURVMWxX?=
 =?utf-8?B?VE9WeTY4OTJ2aTBpYWEraUpmNTBFUVQ3TDg2OVpVaFcvMGpyRk42VnNxd3c2?=
 =?utf-8?B?ckZxcnBoajIya2FJcStZSFAwMDFOUGgrR3kvcTFsRVJyTGdLVUIrNUc4bGti?=
 =?utf-8?B?RmtvbkNyTXV1dWpqZUxZSllFK0E1SXdzWTlYbFpCRW5yeHJUM1M0Rnp6cWxx?=
 =?utf-8?B?STk3SnlPVHcwK1lIcGwrVFZWcFZNOFNlM2ZNNVRUZFhJZjZWUUE3ODVLTklm?=
 =?utf-8?B?WVErY0Z3VVlrR1FSY2p5Nk1qTm1oT1ByMHFFMS9vQ2NUWWNSMnVzUW91eEkx?=
 =?utf-8?B?dzN3S2k2MVk1YTArQjlWUHQvTHJSZ2JxaWI1NDUwMzdIWVZUZ0pxN3c3MFJs?=
 =?utf-8?B?R3R3WGVoMTRwTkt1Q3doMjZ3MWdiZnNEZWxHWVBmMUdWOTgweVN1VFBmamNU?=
 =?utf-8?B?TVFxUkgxQnQ3dUo3dDQ1cldoRFh0ck42Z21MWEpMT29PQzRteTM1d2hsYnhY?=
 =?utf-8?B?QldWLzRKNUsyT1JrUm5pT0JEbW02WXMyZmpDOStpbXVDSlhnVTlBU1pkbHEy?=
 =?utf-8?B?T3FodzNoUFFDdDNBcDJFWTRJOHluaU5zZXRPV0NQSlc2ZEZDWFdKY2Zqc1NO?=
 =?utf-8?B?ZjRNSlE2SkNtQnE4bzMxcWpYcDQ1b29VU2VNWXBWMDBHRTV1Q1JuaVZRcENC?=
 =?utf-8?B?NkZmWVcyUDFPRHk2eHBCR2x1Y0NoUzJzVzlBNlBPK1ZjTWVZc1hBdGhvRFpT?=
 =?utf-8?B?Rmd4ZnFESjcxWnVOS2FnV3QwbElyYVIwbm5hQjdHa1k4eHl6em54RFd5bXpw?=
 =?utf-8?B?ei82Z25DUnc2SWl5MHpva3BMVUxQWDI0d3lQSXJoTUlEOTQ3NXA5M0tmZzE4?=
 =?utf-8?B?aHQydDZzQmx3V0wwNEVLeUVyYnJMZEt1T3A1ejN1aFdocmYzeXZ6cGZURk1X?=
 =?utf-8?B?aEhQZ2I5WFQ5YW9iZVBhVWJxR3I0YTdlYVRNQk95NVlRWmd6QVc4N3lXZEov?=
 =?utf-8?B?ZWFpQUpQTnF0WlZRclBOZ05tUmpDQzQvbkcweUdjT25pbVd3UUZVSmF6NU5t?=
 =?utf-8?B?dDRNbEc0dFBiVWpCb0RzaTB2SGVGenlEOG1IUEdvN3RhUXBKZ2Y1NWkra0x0?=
 =?utf-8?B?S3Nya2E2b1krTzZMRDd6aDdTU2xYMHd0dlpVZGd1dTAreDhLNlZDREpad2ho?=
 =?utf-8?B?UEF6Rk8vK2J1eHJqSWtLK3NoWmExcUVtMjlybHdzcGFDc0EvTGFYaUFPR0FU?=
 =?utf-8?B?R2l6Z3Q4a2NFUHBKd1pUOWNVdTRrNXE1amhZalhRZllHTW5DUzlqRVp2dy94?=
 =?utf-8?B?b091ZUlIMExTaUl6K3VHRnVDNW1aVDEra2tNZERma0REeXVMZ0VsdXZuSys3?=
 =?utf-8?B?RzlYU2ZIK0tvTEFCNmE4eUNUU0l5Q2RYckx4L0NGOHFNL3hQRmxUQXl1T0tv?=
 =?utf-8?B?SkxIekxVUlFmYmJZT2M1b2lrVWRvYXkwYWU3aS9KcmlwY3NFY0RPVEVuR0RJ?=
 =?utf-8?B?aTcrYkV6T1diRkJteFNtSlRyWFZ6ZjNoQTYvTHpkVW1oQ08xL0lXYmFiaVVo?=
 =?utf-8?B?NlV2MG5ZTVd2WVZITHhYUW5hRnQzSVFqcW5BYUZXSU5oWEpHWUJHN0FvZDQ3?=
 =?utf-8?B?aHVPdkl3bnVjS01LczZLU3hwb3RQQnFZVlFHTTRpbHV4bHlQcERVTWtGeDRh?=
 =?utf-8?B?QVFIMTJLUFJSUTc3cEh5VHJ0ZHJ3bXpjNzN1SDRzZVpqejhYRTVGRHljdGRi?=
 =?utf-8?Q?+0SNst7/U3MaKG4b+hdXJFmHptMvXOxEf/Y+MaV5y/Es?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXsTaKHfCdAgy6QYvMI5ZQrBT4RrwMylM/Bdl2osV6DAS/LLRn5sjDuGEmpTtUQHGjXvrJiMD/+LbpcOwQonM5H7h79TI9k+Ha1C9EC77rqal2dPBx2MWJFnKKuqFV40bCNjkFzehoT+rl3ITJ6nXQOME5a3PCTBf3rjx5MPSiNQ/q9A78Onyy7RSD6Zxhp2wVU6m4dIuUuUNnLAmUDKLoNPpb5LA9jPeNgVOoyIcZQ71u10ZHU2mBwQAAL46nsaGvgpWkyJkz9Ju1GP1ArDDolKU/1cPRN9Wc8oiPVWXxaksiWtkXNhCHHChe4iN2WDtMmW+/lI39I3kMfuahysUQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyLNNOZ6r0blsncF9oiSs3VhuCvEkFx8AC2n1p7AXOk=;
 b=AvVouJvqCJh+2Pmv25vQMmlh07zYVYS9uAzwqIsVeyXMSm+ARaYUwqRwrSRsg3lXBYKHj8snviR8OzS4VoveFpttTAQzgAS58k0IPxxXOl2sC0NNwPPhHVx1LgbC5uo6S1lMrFcLKyhFhzAeMF2cJZUEqbaBxSlY+q4qCYxxwW5k43TQ1kpeFVnVjRXatwP+ibS6+mU/1QnPE4CFF7XzRaQa3ZWRoZrpjDi1oCrFK33cXdCsidtlt7Qb6qhfIK2MDxIVVw2Eq6zq6t3kF38pGyBkk9CLmjhRo5wXBG6ipy/jD+WkjXWo/olwDd2gGa3sRxZFBgxZJ99EQoROo83DSw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyLNNOZ6r0blsncF9oiSs3VhuCvEkFx8AC2n1p7AXOk=;
 b=gRswiPX7sYNiCrkcUAi6d8fla4x/njYFlDqbstyGTclQF5QtBItGCCxT4z4LuBmw2S02FunRzbhkXemRuy9P5bV6e5K1ozv1HVg2j5arLn6jmoNnQMYD3MD9Ud/2ogSHVIF7SxbnljfisGB9G5cN5r8elLeoKv8l7CKVE/ij5bo=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: fb62b810-111f-439e-f924-08de36908e0e
x-ms-exchange-crosstenant-originalarrivaltime: 08 Dec 2025 19:32:41.9136 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: UaQIYh30PCMfWu+fJ6cqw6ekRH5uSk+/9yi2aadgb4RwtJNyHDO9Tx0SqUxWJBn+qduFGysCanvFGAQitdq4aw==
x-ms-exchange-transport-crosstenantheadersstamped: MN6PR17MB6851
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FF32C61B56D124E8EA230651566415B@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=850 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512080166
X-Proofpoint-ORIG-GUID: 8tMzEFib6N6_yKCtVzKNcDb1uBBhn3yv
X-Authority-Analysis: v=2.4 cv=e84LiKp/ c=1 sm=1 tr=0 ts=693727df cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=q3_VMtobxgQ33NqRd-8A:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=M91JV_wKSCcA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDE2NSBTYWx0ZWRfX9AXxfVXmKaY9
 BMlpeW4d9hbSLVEg78r7D5tlVlcYntRmFWlaH/zzN7es3Mb1kYkuq9a4eUrlR1eqA+KIBYOgF2Y
 aRy4tr2pXELT5MJeBPwFAANcHuMc2suzj/2/o9OqvfKyuXF5NZ8Hq8udkysFNnnJ4uY4FelqIXe
 PEpOCpAsv0aSDdvQDY/Y1g1m62Rv0P5J+pKskNHL5WLyg91mCAd4DcI2H2JTyMZlqA0lfbsbUyo
 T3mvwcku8LLNQeMhU17d/U8a9y+hCtMgPD01DoYke/NTfO+1ISPSNoj9DmOWo6Y2Woy1KZYewPS
 ha4BW5IONVmMOhPSboiL+82XdrwpTCPLZFP/cOp3CJjBKrZzjCKbtuNrDsNH1SdkMtm5bHqXUwl
 Pr/AhZ83jF2uPPNzyNtjksQe37JXkw==
X-Proofpoint-GUID: 8tMzEFib6N6_yKCtVzKNcDb1uBBhn3yv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080165
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQrvu79PbiAxMi81LzI1LCAxMDoxMyBBTSwgIlBldGVyIFh1IiA8cGV0ZXJ4QHJlZGhhdC5jb20g
PG1haWx0bzpwZXRlcnhAcmVkaGF0LmNvbT4+IHdyb3RlOg0KDQoNCj4gTWF5YmUgeW91IGNhbiBz
dGljayB3aXRoIC1pbmNvbWluZyBkZWZlciwgdGhlbiBpdCdsbCBiZSBhZnRlciBzdGVwIFszXSwN
Cj4gd2hpY2ggd2lsbCBpbmhlcml0IHRoZSBtb2RpZmllZCB1aWQsIGFuZCBtZ210IGRvZXNuJ3Qg
bmVlZCB0byBib3RoZXINCj4gbW9uaXRvcmluZy4NCg0KSSB0cmllZCB0aGlzIGFwcHJvYWNoLCBi
dXQgSXQgZG9lc24ndCBsb29rIGxpa2UgaXQgaXMgcG9zc2libGUgdG8gY3JlYXRlIHRoZQ0KY3By
c29ja2V0IGxhdGVyIHdpdGggLWluY29taW5nIGRlZmVyLg0KDQoNCg0KDQoNCg==

