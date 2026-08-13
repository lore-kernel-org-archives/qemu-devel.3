Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30A9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRm7-0006Md-Tg; Thu, 13 Aug 2026 05:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1wuRm5-0006JP-Nw
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:30:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1wuRm3-0007Jj-BS
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:30:57 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D903uM2505348; Thu, 13 Aug 2026 02:30:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=sfk3WGDWAQLWB
 hOHEw8s8vPtccVscqkEECa5N4sGv8U=; b=WSQnFfMP9YtFKGtTo9L2fMZFyBgRj
 RvvtCYEj2VToISdmZKr+IqZdb6SJi9Vt8ncd7PwnpAP58SNV073LRDgFOgiAVRiG
 B7oYXJ21EGK39NYB3WiqFHg3UFZgh2rLZQjeZk3AURD/uBFJikm6pFPMPmLw5oza
 REGGkrw/+DaPp4iWJWHedeROSKxk9WG280J0pAyq7RUdQeJENrOQS4me3FTdQM8F
 TINpqJuLwXdTdo3cVNbPeEC4cjDCg2ChChuiJtWISVBq/D/ad+5Aiw/HEFX+CESI
 z8Bj+kQqGgs2Pnym23e3IwahI6lRgeu1WrMpXZOcHDaXRJJXfYiv6izMQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022116.outbound.protection.outlook.com
 [40.107.200.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g0nj4b3nc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 02:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi9jlYtraMEv/6EFrS8AgJ2+QjXU+3kiD2Kdy+N+zoV7eQ/2mW/XltZDFMxQhT07LKX2IwRomuJaItgvx+sOiAGPfsKzxFaC+FjNmNz5Q3MSWh47+wy56Wdx/TSk6RYjA0Ci5CZZc7fXThNOGJQZ2K/r6Aak2mf9JFxhQVBrWo9HjUkLjYzBmwG8LxhR9zmqnoctR7TEZQuvxrnhtJoU1ncEPKfNeQIbXZxZ5WYYgvhOXq5MxM1xA6JtFaKZ4sq66vARbcyMDQBhL78jwPb3QbriwYJ/6ffHtH6Oef/qRrSZSl3NYI5s2Z/Bn9PZcgJau49ag0qQGoYk+GdrwIYIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfk3WGDWAQLWBhOHEw8s8vPtccVscqkEECa5N4sGv8U=;
 b=gf37vdnlC6ccmykOwtVvtS7lyh8i+O2oGceAVdnzauQAr17gnl0KEfgcTKzlg8ihDcXwNIP0q9oX6Nh1yjMBQVhA8IvQD5YaGY3xWZVVBXNSQq7zllvrWIVaRpfgBTa3GI3ph20iSfUKwTqlpbwaJU0ugTjBfk8e4z9MhAoiyQumEMpLVjxN4JwOlnD3/UrtC8Nv7IfVMEi8VvRejHdwT9Zhzc4nOCk42Mkd6AR3yd07FcuQcin9w4/WByT3V2f2TZ/96xivIHx0rJZB0f8inW5erU5Bs9BViqfiX8FkXk0NtEZXUKxATX8DlQc+AOOJ+f1Du2nLjolpnAZc6b2/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfk3WGDWAQLWBhOHEw8s8vPtccVscqkEECa5N4sGv8U=;
 b=WNihunxrKuPLJyf8HWRRwpzoYbd0feVQ0UP43JyoaDBZWPzjMFdCfDktb5pcFfP6MPeEGu4vsKhL38GIgER6cK4BbjUNlRDHggp6nc3sGcqwz0n+WfmY12iCEUf8Fo2W8dxx6k9kafsDSyUrYUClEeve4yWO5MzSWV3C9fMpGI6tXegZW1gqVez36Nh/7izlr9WtprPAq2VvMymvFPs7EHTvQS7EpPFlLYhL25rIzI22h1SPtRHGIXyMvy+POHf+7kWAkyP77qkZiYKmiRuMGotuhQrIHeqGUQfCghErUyK+g95EMV1rMs9SWd2/61oHoZ3L6qywWSwl46843Q2jVA==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by CH3PR02MB9860.namprd02.prod.outlook.com (2603:10b6:610:17a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:30:45 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 09:30:45 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: John Levon <john.levon@nutanix.com>, Thanos Makatos
 <thanos.makatos@nutanix.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hugo Komatsu <hugo.komatsu@nutanix.com>
Subject: [PATCH] vfio-user: reject failover during init
Thread-Topic: [PATCH] vfio-user: reject failover during init
Thread-Index: AQHdKwZq3QjQg49MDUmMavF3ugimoQ==
Date: Thu, 13 Aug 2026 09:30:44 +0000
Message-ID: <20260813092959.76-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|CH3PR02MB9860:EE_
x-ms-office365-filtering-correlation-id: 8b97546a-c294-4314-9921-08def91d8d18
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: XIQZOdQ4C1nXJoZO5kfm4wVtABlorlitFOO2OBaSeVtCJMChoIJ42Qzfs0i5dBD6UBB5DXw0eKFhIzmQTjB+BISjMwraKYbq9w9bKP3CCsG2LyRPm735OqTpkbfZ63dkM86oWF0h+fzWOvWS8sY1esbaYxE005DAaT4YjDzicvMZ+LJCYJo00L/UYaXScaVmO3P/7I64HGWDH/+ZjXC+q+yofi9wrzbnhJrYIkQJHxk+dsTF9FhEuOSV/8NVrGfjyDJmzmFpAOv1p9+vtsfeWw3tqZ5zaDeJfAOzvI08P4GyXHd34UFkOfwRxk5XdknlH3VNG6TGD2cPBJT+bOtoDwc5OYfQWDZykVbjHV5KMNMsw0s1InFcXEaX3pAMsNN/thChShA5b5ISYghEcotpClN/kJLqJf5zw0wQ48Efl1vYirz0dPG+sZBnWMmz+6VI+PRWz6UHK4XqxghKttyknyHTgHddHMHf25KpGa5Olj1jKGW+aKAqJQuL2+L7rlcE3yzbr/1ttp/5UaAht3wYzK+k6z6H/21OatC+JBfDGFqkmwG6dmaauTlak3ZTP5RxrLDCEl8UeIMqcOuu+DN9se0uKfd/Komq/5W41V6Ks7fbA09H6grRVoYbkNvnj/8gOdb5r10DQ7TPF1eJHEcqhBZx3KP6BlJrEQYZUzBzw4FynHlapv6KKlLL9UQUPuam5A1UwHG9zHo40bCnrqEjuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(56012099006)(38070700021)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk05T0dkdkUrNDNpZW9yTXA4VWFCZUozWDVyQWdQS2UzTmZIZlhBSjkyS3Ay?=
 =?utf-8?B?bnQ2QTk3SG9VTW5Pcm9PeFhpZFFEd3k4dElZcml4UkpUaGd0TXd0bHgrZmRl?=
 =?utf-8?B?K1lrcmFOUVFVbXBmRi9ieHdqeC9QK3EzNWZUeG9zcTFxUDZlcU1ycm91SFc0?=
 =?utf-8?B?cUhyZmU4R25UR2prekFsclREK0piU3pSdy9wcC9zUmpBYnAxcVdvWGcrTUJG?=
 =?utf-8?B?OVREODJ0bVJIeWpHNURHSzFrM1JjaWgxcTlUSllET1hrakN0ZEI0aFNvazJv?=
 =?utf-8?B?VEVUaG40aWZ4U2s3YzMvRmhLOHRManBCM3BleHhIRENLdTJMbmxydTYwazNi?=
 =?utf-8?B?SjFBVW9KQW96OFZFbFI1allDck5NY04xSkgrSGNYN1Vxamw3N3FaT2Q5cGZ0?=
 =?utf-8?B?Mi9LRmVmeUhFVUtOc0h4dlNTeGtmN0wwOXZKZjYxYUhYa0NzV2JBQXc4RDQy?=
 =?utf-8?B?RGFzOUNpa2U2NThmRythODE0MVU3Zmt4REt1cUtWZUpOL0JiZTFaRGxmcDNq?=
 =?utf-8?B?WFhpaHFoVCtSZThrbFRGeVd0YW8xRXEzd0VmSTAxZ0tvbmhRdlI2dmY2NFRz?=
 =?utf-8?B?Ri9pMU1WY0d3TW5LZEJUTWtWUVZ5cTR6SDVVbmltZnVEbzJkWU1idzQzbWZ0?=
 =?utf-8?B?dktzc1owZE5lWHBvNWd1Skp5aThSQXg2MFQ2cUpwZWd3dXZSNWtWa3Y4eURl?=
 =?utf-8?B?d0hHZDJjTmswVDFaRll1SGxlZjRkc3dTNHA4KzZmK1NSS2gxblBTbDVXRUtK?=
 =?utf-8?B?Zjc4c1ViejV6b2hzWWJVR0FBQzNYbG9FZWxIN0xnTHRzcitud00veXZTTWVY?=
 =?utf-8?B?bkx4dEkvT25kZkpCbmsyYU1jR0dCS0JuUDJQWnRmRFE0S1Q2ck1wR1E3eUp6?=
 =?utf-8?B?d05UZ0RFTjVHWjhCNk9oSjc2QXQ0TEFvTHNBcmxLN05lVVMzVmt2MnpGSHpD?=
 =?utf-8?B?bXlkYXJJb2Z1SXhqbTJ5TE1NSC9rOFRZaTNKeXhKd1F6d1ZWT0pDaGp6Q1ZK?=
 =?utf-8?B?b3VTejA2QkxEaWNXSWNhQW9YZ21NVWc4d0hyQTMwMTNjd0d5KzNRRmdIZ2dt?=
 =?utf-8?B?WmJiNlU3L1VQYjVsTnVoMUEwclJyUDRxZzk4TWFaeVptaStpdXozMTF0Nyty?=
 =?utf-8?B?cThpSGNZZ0JWUkVzMEI5R1VXZHh2aGJlQkl0ZytaNFFwU1oyQmJTY3lkTGFi?=
 =?utf-8?B?R2RFUjR2TUhjZGZiM2hxeEUrTzU4K3JPQW4rRUhXODlZMmRnUXZEMFNxSHZG?=
 =?utf-8?B?dUhjWno1Njk5NmhyZmRzbDBDYzYveURMWnc3NjZ4eHlCN0E1bUMzQklUdlVO?=
 =?utf-8?B?OXdEK3oyVTR1SUJaMituNEtFUU5KaUNjV0JHc2pLK2wyUExEUW1RcHlqUkJC?=
 =?utf-8?B?RUVqakc5MnZBdFN2bXZNdVE4QWt2ZExRYnFNMi9XM2FORStsRGl4V1ZwY0Jz?=
 =?utf-8?B?c0ZObDlZUGgyeURMTXdqdm1aTUdGcUdXQ1JOcWxMU05GdDZHWS9RZkdXdXFh?=
 =?utf-8?B?ZnJSdll3SmdzSUdrN2xSdmt5YUxIb28vbmJwcmtVOXBkUno1a09aUTczWnQ2?=
 =?utf-8?B?cktrV0E1YjJHTjBXRVRFNGkwNjJKaG5oc2Z0U3Z2VHFjaE00VFdTaE1iSm9r?=
 =?utf-8?B?c0dtUzZIUTdUM1NMeWVZdG1WV2dCQkRsOXRSeVhaR0FxK1lmUWFGYlQzRDFD?=
 =?utf-8?B?U3BQSXFZZ21GMWFXTSs4Nmg5aUNaTERVVHZFSWNNWUZhR0pDQllrMmh1NTJT?=
 =?utf-8?B?Z3FHR1NUSG4zcldiaVNIVnJHRlYxWTQxQ3F2MWNFNjVrTGhTd2ZsRmdTZHA3?=
 =?utf-8?B?SDY0VnQxMlNoanRRTG1wdXVlRmRRcVkxd2F3NTdqbXFKV0hwM1FMN09nT0VZ?=
 =?utf-8?B?NmFBemdHUHg1WElwQ2JQanpuSlR6RFd0c3BMQ3I3M1U1MlFVcXYxbk8yZ0ZE?=
 =?utf-8?B?N2hBdmdqWmZxNDFVbHhkOUpkVHA0SlBhV3hMTmNDWHBUa0RMYUs4WTRIOUdx?=
 =?utf-8?B?UGpCWjZIMEI4b2hzY3luNG5wbHhiNldxNUVpWEMrYzVzZmNMVWhkLzRYS2pB?=
 =?utf-8?B?WkpmekM1cnFKSVpMMThVdkgxbEFZUHRMTlFDSE9wOFNLT0xFYms2L3pWQ3Nj?=
 =?utf-8?B?eWFXamc1b2xTMEEzbW1HTEFiWmZhODVKZzBEQ1J3d044NEF5U3hId2pITW4r?=
 =?utf-8?B?VWdKU3cvVjk2MmZGVW9VeUw1TTIyRE5Rc244WEVJQjc4OTN3MjJOTUNMUFdT?=
 =?utf-8?B?d3lydWlKMlVUVC9HdlpIZVpBV3hzWFN2djNtZFk4QkVaLzBBQnk0UFBpYlVa?=
 =?utf-8?B?OTlDNVlHUytHbFpoRlREaitnOEhWWUlxWE8raXB4THpXZWhxd2JiMWF6U2JD?=
 =?utf-8?Q?Zl26mw47bYyTmFDU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mk5MCy6GT7xjes+/eRc07bm/393ETUQ5qSWQqp/tM7SVWvS7+wW6X/RrFxpkdjt/BWyQlbJZfJyaak2HyXoC5qqImjbndpik4GknDOk0cKUNN1RuVXZUcDuZi5lHKEk9kdsO9Ql/oJT8xct1IxIshI4iIs+bhurWru3gDkvfLPDAL94DRS9up8YhG5Ah55548BgBMHrzJoswWa9JZZtIZ5D+67eoew5ljY+O7vgK+zJ3F2te1s/GA2UoOaReuTqeXkGvVd60eLSFjPNUt0R+T0asTa4SlLV+QPZLy7UKmRndmj2boyGmDUzHGeAoUSulryOvbHTIjWAGyHU2bThQVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b97546a-c294-4314-9921-08def91d8d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 09:30:44.9375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnsFyBNo2rO/LS0SsYNCBPXsd+gHkCwBozezQ+80S07kn8UyyQobWPf5dKYhyz0bFVZEMlkIcaZ3r5XITZzOqH7DWZ7IrV7jFES3jxu0SXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9860
X-Proofpoint-ORIG-GUID: H04Xa0Rbe7OVCaAlVypptPYxfv9CwiDY
X-Authority-Analysis: v=2.4 cv=McVcfZ/f c=1 sm=1 tr=0 ts=6a7d8ecb cx=c_pps
 a=iaCbk/XvQ83LTQeyZmlihA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=64Cc0HZtAAAA:8
 a=54_dsVa9enMDYGn8iIcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NSBTYWx0ZWRfXzzyrIy8HQzSm
 x0110sQyR/1KOcG3k/JK46GojqcYcXlvSE9qCeybV44j5xS+WQkXYixvJrNz043b/ZaklHXAq+2
 5YXUeAd8FtjhDO1CSBaoAZ2NFrjtEXf4nXSQOyGwLRj+kNrAlK1uW9D3og+0vm7uWhIzOpTKbuF
 oA5keqWgtlEchVyzXiRMc/q4DNRjFuI6huJZCPTD3E5nB1kPSk0hhRgiweHn71DyAcJ+aVMjpic
 4kbENIL99BO056CR9SePST/EkEEYIAdrkGw0oGpYH+CfvGiwNwy/Oi1QkKOwTTm79jPBgn5zsru
 KOUaHSKoPuRToO8CqTK1+DA69499oAmzMTX5WFcrlpaT/C8rfRadby7UhWuXCMrR/AIG3lM7LNB
 nWXtMl3Yg6Pa4eP9TeTi8mUEnLkQe/NvcJcs7cGau9RdlShccFs0uFghTJu+1vNezeeOdpJIDGV
 Y4LL1q9xm3VruF1tLyA==
X-Proofpoint-GUID: H04Xa0Rbe7OVCaAlVypptPYxfv9CwiDY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NSBTYWx0ZWRfX7EHU3HDxPRIZ
 YR1RLwJ/Tx0+f0CP8yOQrvi8Ji938SZ39EULEp5gp4KlnIhVm3Ewz2+NTA1lugQpxGLMzld7eJY
 tzoDv2CkZWjppfOFTXLMthZveB6KgmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

VmlydGlvLW5ldCBmYWlsb3ZlciBpcyBhIG5ldHdvcmtpbmcgZmVhdHVyZSB0aGF0IHJlbGllcyBv
biBhIHByaW1hcnkKYW5kIHN0YW5kYnkgZGV2aWNlIHBhaXIuIFRoaXMgaXMgbm90IGN1cnJlbnRs
eSBzdXBwb3J0ZWQgZm9yIHZmaW8tdXNlci4KUmVmdXNlIGluaXRpYWxpemF0aW9uIGlmIHRoaXMg
cHJvcGVydHkgaXMgc2V0LgoKQ2hhbmdlLUlkOiBJODA5ODlkZGIwOGExY2QzZWJhODRiY2Y5YjBl
ZGMyNmNiNGE2NTY2OQpTaWduZWQtb2ZmLWJ5OiBIdWdvIEtvbWF0c3UgPGh1Z28ua29tYXRzdUBu
dXRhbml4LmNvbT4KLS0tCiBody92ZmlvLXVzZXIvcGNpLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaHcvdmZpby11c2VyL3BjaS5jIGIv
aHcvdmZpby11c2VyL3BjaS5jCmluZGV4IGVjYzU5YTk2NDIuLjM0ZmEyZjIyYjMgMTAwNjQ0Ci0t
LSBhL2h3L3ZmaW8tdXNlci9wY2kuYworKysgYi9ody92ZmlvLXVzZXIvcGNpLmMKQEAgLTI1MSw2
ICsyNTEsMTEgQEAgc3RhdGljIHZvaWQgdmZpb191c2VyX3BjaV9yZWFsaXplKFBDSURldmljZSAq
cGRldiwgRXJyb3IgKiplcnJwKQogICAgICAgICByZXR1cm47CiAgICAgfQogCisgICAgaWYgKHBk
ZXYtPmZhaWxvdmVyX3BhaXJfaWQpIHsKKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmZpby11
c2VyOiBmYWlsb3ZlciBpcyBub3Qgc3VwcG9ydGVkIik7CisgICAgICAgIHJldHVybjsKKyAgICB9
CisKICAgICBzb2NrX25hbWUgPSB1ZGV2LT5zb2NrZXQtPnUucV91bml4LnBhdGg7CiAKICAgICB2
YmFzZWRldi0+bmFtZSA9IGdfc3RyZHVwX3ByaW50ZigidmZpby11c2VyOiVzIiwgc29ja19uYW1l
KTsKLS0gCjIuMzkuMwoK

