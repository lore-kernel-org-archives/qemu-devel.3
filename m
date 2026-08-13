Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAFCC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuTIB-0002hs-Lk; Thu, 13 Aug 2026 07:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1wuTI8-0002he-Hk
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:08:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1wuTI6-0000FU-RY
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:08:08 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D8xtc52467905; Thu, 13 Aug 2026 04:08:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=DNDKSA7ap6yhE
 zVxBSlVVh+JncPrn87MNwYGpRIjGvY=; b=MzHeFGrxn8qXkhgdse6j3f+s7yYP4
 J6eFB/yzdZr6rObMm0AYZ86AFC4iLyVnz2o9rzYvI/SKfBP30xuoxuMo6WH/HxG/
 KLZg3fQnmBbLzQ+ZGw4J6iKYq769XI61Gt0cmexxgcnihI+U+nA+CPq1YBBr5lk1
 8XP69E3eoTx1xzUMs5xOA843imwjAcg6GqdcerCZsVSMiffadhjGXEmSohQpUXU+
 r7oI+cYFPUa1gzEUIzzLnDebW2hgDu8fUr0DadPO/2pBBKe8Z7Rj5KXG8Pvv6ACh
 1aMBYUMPmM/kQ+GFEfC/iuBuAM9U5az1YprdEF10NYYD3IgG28fKejV1Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020090.outbound.protection.outlook.com
 [40.93.198.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g0m323hxn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 04:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKsyAmwfO8DkC9Yq4Va4M2iuOb6xO4yiUey1/SWZWw8u1Dto7O0hTcsM7691MXaf6P+ULHpBwKCj2HxGhYJGCOsXcrYBUBXkVeLvVMaAObzQUf5p6Et9NWOBOnj3OQ0VNlMgMWBQT+fH2TMNpi8IIDZAn1wCw00SD+HxJslGjtM8QQOfyENh+zsNLhmV8uU4Ajul4Du4TGmOd+Z2kvdmEYotpRfxpvKBpmwvAddEx4FjlCfFkiledxDvU0jJG3w12cEMIPfjX+N+ju2Fbc/dmdJJ6FNQcIT/QqAZqEeJdw2gA1XzMtU0wG7IZjmQwy7mkWZL6xkZC68KwlKEQwRn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNDKSA7ap6yhEzVxBSlVVh+JncPrn87MNwYGpRIjGvY=;
 b=fs8FK0wgr2U9jM6NlEF194g3bkOH0s4GOb3DV6bIm4KwX9o1AtqE64/9u9tBXj4wBQTZ7LDKZuJVEy9nf71hSdKMBr0EFUsX4l14gNzoD9dzi0YpjzQiMlIMqZTN0IECRiJa6NtNTSxSnqZHwAJ4q4Q9QojvEwx1bnBiieirYkMp5znI5siFhnZJ/ltm1Cig7Yj+5RC3FkFxlVgDRRYDKzR3b2zFkLeLxh1kYVeRjNkV8XJUMUOr4G+suPBOUxyDiIF2eLeMrdAiuLezP/kx2gbFpzvS5RxjRTMmJ9ZtWB4ZNqZX1GgrvtbjC1u5GadtGZinDuUGHME4SNgnPfDZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNDKSA7ap6yhEzVxBSlVVh+JncPrn87MNwYGpRIjGvY=;
 b=KgraGBj/bX+ouu6uebg7OUFGYB1gsrkjB43VVLPHx55UdbPhq5hrRA0ib8kZuufuhLvT5ztvk5nZjDmVuUiKSVwTd2hC4D5l6eRKuLcFCQ7vDEIr0H0gGuwkBFQo8PSt2+4rDZsNhc1WXqAGlNly1ccKoVCiRuDEBmpINjl8B5Db4ojUqFN4c/6VO0UW4xgXRnNRCCuf1u4SOGYrzEzhd1HYYxJP4LCUfN3HfkEjjwcZ0Gc9v585YDReyuW+YJWUQlCunez82lGUstCQg3JlKMHvS5hmHVssnRxC/M/aijIwlaSp+MM+UMsC31LbrT9QPISoH+H8x0Ikp+8/tz45kw==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB8641.namprd02.prod.outlook.com (2603:10b6:a03:3fb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 11:08:00 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 11:08:00 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: John Levon <john.levon@nutanix.com>, Thanos Makatos
 <thanos.makatos@nutanix.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hugo Komatsu <hugo.komatsu@nutanix.com>
Subject: [PATCH v2] vfio-user: reject failover during init
Thread-Topic: [PATCH v2] vfio-user: reject failover during init
Thread-Index: AQHdKxQAu84aCZ89mUqccZ3G1AXkiw==
Date: Thu, 13 Aug 2026 11:08:00 +0000
Message-ID: <20260813110731.80-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB8641:EE_
x-ms-office365-filtering-correlation-id: 911ffc5a-bc33-44ed-8ec6-08def92b235b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info: +9g79EeJT/l5a+MTqk4Bbh87KUn+dq96ujuc0Fg63dawGi3AniwDbVVWcM8gsqBunjtM3fm2F2LFgLC8KPRK76odd8mDXzeaXmvCNz5urZpoDJX3AOT4tYxLc/btDq7ZahfkoUuFVfACJzXqGR2/i+qX5V4QtR0YKrG1J13YvdTC9dm9EdN+d/q5B7+5GOCnrd1m3axqTSaUYC927M7YDlNW4JCqaaAuPdGl1lB/JkgBDX59MbbVOrPYZpxgoV3rz5k3tP0RTY+YpRkMsxzlUhcwuckbWqexd5V8MqgrHUlMKvjnKkPM/+70NVTiSVeQMllnZY4Td9qLJPNLF2lMWvC0RdSue78uIiFWlr99yb+MEZG2XYwT2JHwfL8JazD1q90uVI1LKiXDJxZusvBXqfOuZtVp5TONSiNgmbT5VG0SxrnQ/F5z8BkaAyqMDSDsoaBP80g8x8ES8S2Uxt8TBt2rjKy8F/zwhnxdNmZLMxY8cMZhNrMZDgDIgqG4QdlsHvQpXuZTDJ4Ntvyc2v91HjwHhdIr5kxeisATK7iBx9sKff4Wmdea0b5fbFuRRqs5K9omxlrOmHo9nMBK/4Uh360O69Tn7DUgISUxrXkRQo7acwjIrQM8JO5IRNpU2Nb+aZ8g7NtIyH0VlUcB1zi3bk4CsKgIhC3klqbcjyY8HmDSqwSznEEWA5+ncEsYIA8CjSuNTap8clgk7dB6BXQ+kA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFVSOVVZWGYydGZ2VGQxb1V4ekhzMWJuTEF2NlJnQ1RUM0tzcDZaWndETy93?=
 =?utf-8?B?R2xQSDFnMjdVVU9sWEhJamY3T1Y2cEtkdUMyUGhhdW1OWnlKcDlpaXpXK2dG?=
 =?utf-8?B?Yythczk2dk5CSjJxa2RreFYvamI4OWNrUFZhOS9ZL0h2eFFmNHhjUUE0c0JX?=
 =?utf-8?B?cERUSEhBaGNXVlFXSVQ1MlJ6djFTdmppZlpUZi9DekRGVjBmRUpJd2xnOFVL?=
 =?utf-8?B?NmJqbXNvaVZlMW1SKzE2cDNaL2hrNjg3ZDZmVXdudFF1MkdkU3ZaSHJMT21t?=
 =?utf-8?B?NHhFRWJ4WncwZVA2WlFWM2RndVRManVvU0Z4Q1NWNFJIdTh5Ky93Rk9VelBn?=
 =?utf-8?B?T3pDc2oxSFRNZFNGc0pDOFdnaGUreE1xRFdUU1diU012a0xpZUR2M0RWOWlt?=
 =?utf-8?B?REordHB6bml2VnY2WHNaMkVDRmNJYjFEWEZyYS9PNXd6M0JKemFXaDZlMlhC?=
 =?utf-8?B?WnBIaGlWK1d3QXFKdTBCa2hmbFFkZlVQRzZMT2l3Z2FuS0E5UmVPTFNnN2cx?=
 =?utf-8?B?YWJDeXR1ZDNjK3VCbi9ZMFlIUmtPYUc1U3pUU0pkYWRpSHlmVjE2Nk5aWUNS?=
 =?utf-8?B?cHhNQk0wUGdqYmVleVQ1OHNFYlhDanlMQWhpcTFac3VNc2FrbUJjL2FDd0hh?=
 =?utf-8?B?TWhnSDFOR0dka0hSVW5WQVV2Q1lxNFl6dXJBQmtGamYvaHVlVEtwK1JPbyt3?=
 =?utf-8?B?Yk84OGd6VmZZUW1BRWtJdUY3T1hobjJBNnRlY2lyVXI5RldlT3JmNE1MSHRP?=
 =?utf-8?B?REpubi85bENCQUUrTXhPNVJ6RTkvOWNhWFRkUkJqZzZYRmFUbm1pdFIvbW1D?=
 =?utf-8?B?L21oRjNIcjcyRExoL3VGTnZpMFpJQm5MbWE2QUtLeVo1UnFSTUJIVUFoNTNk?=
 =?utf-8?B?WHdzZWd3TXZ3eE4yd2QyWnF3d0U4eUI4QzJJVG9LbnQwdnhPQ1BHbERVWTBB?=
 =?utf-8?B?SnpSSjN5cVA1MndpSmY2TTdHYlhwZG9MUkJ6ck1hUTBPQjdxck1oMjNpTDZ0?=
 =?utf-8?B?VHYxYzZQUEU3TlpGRnV4dEVDajY3SERQOGxXWkgwMTdNb2w4K0ZJNmE4Wmt3?=
 =?utf-8?B?Q3ZMVmljUFd5N2ZNcmp1VDZkcVcrMy9sR05RT2hPMWFzZDhxTlNNNk5wNU1j?=
 =?utf-8?B?dnl0N0RWUkdtU2pvbVJLK3JEYnYzNUxtTnVMTDA1Vk5LT1oxUVFJOWR1enc5?=
 =?utf-8?B?SlhiRU5CczkvRWlKQ0c4TFk5bFQzU0RhRS9xc0NzcFlwL0ZZK0ZDblplR290?=
 =?utf-8?B?c2NUcnliTWdPU29mRllWNDZsZEFYSzhEZmUrTzJTd0RNUmlzUXBNNmMxREN3?=
 =?utf-8?B?d28yejJyRUhqZHc5Snd2ZlZMbGFoVTV5ZnFUcmQ2cVMvYzJmSFM3U21xNitX?=
 =?utf-8?B?U1BWVjIyeE14ZTdSUENyMVB3UFBpRlArSzgyWE1mL3hndkpjeEdhUDNFbE54?=
 =?utf-8?B?SGJIa3M5UXdLR3pLNGNlQVlxd0UxSUNYaHQ1K241RzZNR1Y2N0dPYkt0VXls?=
 =?utf-8?B?bTJnYVV6MXlSZ05TTGZQb3hkVi9lZnlCdi8wa29nNnE1Yi9iZDduc1NtTlZx?=
 =?utf-8?B?TFZBY3ZET05wOHZiUmZMMlU5NGYzYTkzWC9wUzF4WHNhSkd2UTUyZ0lLN0ZX?=
 =?utf-8?B?bUN0UnhaRU5wUGk4MEFzYzFhVjVIMElMbnczZEJ2TUtZbzZURnFJYmtLKy96?=
 =?utf-8?B?MkhsV2RZZmhURzdsYmR2VXRDOGs0L2hOU25EeEVFR2JiTjZvWDY2SzVtc1c3?=
 =?utf-8?B?VlU5c3lXVHF3cXZiUjZxSE85c2tyUWZPMEZjL1RSeUkvUWl0QkdrSG81Z3J4?=
 =?utf-8?B?ekkwT2s0ZWVwbm95MzJmVHV1ZUhhY3ZSZ0NFZldIYzRxd1hHZS9PTXVPQmpT?=
 =?utf-8?B?NHVTUTBZQk5FU2k3T1grV2FlbTZXbngvRkhVelJQREhBc2QyTGlLVm1KNEFp?=
 =?utf-8?B?U05WLzdrVlBBRHBvV241ekxmbnpHczZET0tqTHZad09UbHg5SnliQUcvVFBH?=
 =?utf-8?B?bXl2VWNtWFJPR0VuVHhKRTViZG92S1dKUnZzSW11a3ErZWlna1ZOV1B0Z3pV?=
 =?utf-8?B?bEFab3VRRkhORURMTnRWWktUcXpzcW1IQm1hM0NraFhzWjlPY2JZL0F5NHA3?=
 =?utf-8?B?aWlJWlZOM1lYQkFwTmtyZDNpaThtRENad1RSOXdjajg4b1A1K05NWmlwZG56?=
 =?utf-8?B?dW9WY2ROSVJrZ0VHWGU4TFBjVjBIbmJyTkVKR1NIelplSzZGcHhwb3hKVVMv?=
 =?utf-8?B?L2RqaWphWlVQcDk4T2crN2JIeWVmUENTZzA0eWdQZjN0YTFVZFJiNDFTMDBh?=
 =?utf-8?B?RmR4djVLV1lXbmxRRjFZckx6SU5iV2Nmb3dFR3l2Sm85NjJFUXk5V3ZFTERo?=
 =?utf-8?Q?x1ADgJ9WFJef4L14=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WJ/qu7rM4iVROMoEWiEZiNdi5KcAWoBE5rDpFiNdWX7mZbrSywfKQbMJPVqmFy1JqJvXpV7glK6HfvYxt+UD7Da3oER93qrPFygamazVC9WO+3n3IZAGXeQn3W5j4+MYNYHEC+mq+svJQKoNcCpmeYB14xg67CgHUPGh36nxmNOgOUJ3td7rqDqQl9FD2ajftzkd/xptv5OqcScUsbtaYcuNBAV1lW7fewEW8lil+oto3dlT/croTIuORbNxH4nfIddibsuwXQwQM6hTU49OOnMvmnLUhsgk1pPTIPfkpsIi/XVMtWdoJW3vsO3HR3e0aYlLH5XjX6sjIWGHaVjSbw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911ffc5a-bc33-44ed-8ec6-08def92b235b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 11:08:00.5146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6/6cAzbn+ucXtNYVul1uTrWrMhB+NQmvMf5+AuIEq+ka4yzgD5Dn4Iw1/Vh0FJO8GqJcVyxoXRh07QAYShTZASK5AjCE9EjXxLyVzsGsyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8641
X-Authority-Analysis: v=2.4 cv=KKNqylFo c=1 sm=1 tr=0 ts=6a7da594 cx=c_pps
 a=O2bURPg9OTzncuCi5jyorA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=54_dsVa9enMDYGn8iIcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3OCBTYWx0ZWRfX16FpIVKptzGo
 NLheCSyQiO4keY63P+TpeOkYbrM8kaqQ09lX+3XMJ1Ff/4UdCK4oZRRD0DiKUTiPOAgq3g25UAc
 RTDTOd4R6d8qRNaTz4QZmVWAR1Pc7QvzMHOyqG7UPjjvUiLHLfj+UWXsqgdHbPI/IV9YUApufp1
 xjSBPYB9KzyI/sRiR4uMVTMVmtjsm4hTsiu7vQfkiMhFxqdPKGqyT6FVsq2tIqNvX8x4eHaIq04
 Ti/ImVod41dxy0UI4u5tGWjKPCaPu622fsJZtN56YQsRlo49qv2/7jjaVjFn5C2sS31t40aZSBu
 RXN7PRDc5Bb8C8swgXbMx+IQOxIOxx1oPNlwM3RkKh4/W7lr38dJyMwVTh3tKzQKQlibPQsF/fv
 HAo2XuhmaeIdhKX/jRj9W+ZBZPq2Cw10YFtr/LZ9CIUIuegssLEQ4TXgA+89oI42qYBgeCKMwCs
 Mis7QQCqqQ2KGrAofxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3OCBTYWx0ZWRfX8wo+0Md/+fP5
 3zp4HsbNrqAdpREOUgF508c3B9RIHcs+sOnLkJrXdo9O8qxWJEv0UFoDyozJYCb5H3Z3dPkkFYr
 lOlHj9ZEQP9aNh0vg488CXKdw5e3BeE=
X-Proofpoint-ORIG-GUID: C3nS3ioEg0ll03EZ57SB_Lqcj-8CtzFn
X-Proofpoint-GUID: C3nS3ioEg0ll03EZ57SB_Lqcj-8CtzFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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
cHJvcGVydHkgaXMgc2V0LgoKU2lnbmVkLW9mZi1ieTogSHVnbyBLb21hdHN1IDxodWdvLmtvbWF0
c3VAbnV0YW5peC5jb20+ClJldmlld2VkLWJ5OiBKb2huIExldm9uIDxqb2huLmxldm9uQG51dGFu
aXguY29tPgotLS0KIGh3L3ZmaW8tdXNlci9wY2kuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody92ZmlvLXVzZXIvcGNpLmMgYi9ody92
ZmlvLXVzZXIvcGNpLmMKaW5kZXggOGU3Y2U1YTkyZS4uOTc1ZDc1NDU5NyAxMDA2NDQKLS0tIGEv
aHcvdmZpby11c2VyL3BjaS5jCisrKyBiL2h3L3ZmaW8tdXNlci9wY2kuYwpAQCAtMjUxLDYgKzI1
MSwxMSBAQCBzdGF0aWMgdm9pZCB2ZmlvX3VzZXJfcGNpX3JlYWxpemUoUENJRGV2aWNlICpwZGV2
LCBFcnJvciAqKmVycnApCiAgICAgICAgIHJldHVybjsKICAgICB9CiAKKyAgICBpZiAocGRldi0+
ZmFpbG92ZXJfcGFpcl9pZCkgeworICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ2ZmlvLXVzZXI6
IGZhaWxvdmVyIGlzIG5vdCBzdXBwb3J0ZWQiKTsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKwog
ICAgIHNvY2tfbmFtZSA9IHVkZXYtPnNvY2tldC0+dS5xX3VuaXgucGF0aDsKIAogICAgIHZiYXNl
ZGV2LT5uYW1lID0gZ19zdHJkdXBfcHJpbnRmKCJ2ZmlvLXVzZXI6JXMiLCBzb2NrX25hbWUpOwot
LSAKMi4zOS4zCgo=

