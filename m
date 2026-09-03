Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00FCC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27BS-0004sU-Hp; Thu, 03 Sep 2026 09:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BQ-0004sI-Sc; Thu, 03 Sep 2026 09:08:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BO-0007an-OH; Thu, 03 Sep 2026 09:08:48 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AIfdA2645144; Thu, 3 Sep 2026 06:08:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=cI0bzIQaZWbjU
 ZU+DBEbF11q8Vx6IYWMleiZ/tEisoo=; b=ypoNHMJeYq0rVJhqA/9gjrU4ca0Or
 msfky7c+ibpsfkSdcFE4xaQJR8HwTF6yyb/Pewq3YKONtUe5vt1IjjpuS9rnwRiV
 GUJgA/hnBRXJ/tUxtt96yBshIfzBrPw4z63mZOKxkjjZkFD3HI7R/E7jM3h+j9Ht
 f/Hh3q9MmNkswCZCM3Lgd5gZwNW6SK+9oyW0pP/Qz3jxJxO8qCkbutO8rSrjJlAj
 RLOrOy0T5Kwc74AWG9q42OIaqIM/m1UuPDOA86pErwklvIegNjACposHEih0k4eW
 f/Ezp7jrXRM3fSnVUsMJm+PUpzaif3LD0mqCbG6JBAiwROlVH+UXqrjlw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023080.outbound.protection.outlook.com
 [40.107.201.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ges3b29g2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 06:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2C+n5S9AyQrJ3OpygQ4unzQqtfK3zMsgMN/VYSeLKqth6M+ohL1a4uc2P7lQta+7ubZsM34FzD3Pybo4u8UlwXWVQER+eP8z1mkHPhQ49NziR9dYekTIvRYWGzzJicy0fBZON7AI+0NlWUflhxlek8eAzWHrXvLs0wnCx4HyEYFlyVta5rjYethDiymSy1Mf6+dKqumTAx/gUvaBlZLiiDyi9zdLdLHNkUlr75VKcTQnukE0o0m5J3BjZDBZfCI7/OWDksQcZOu6t1juKIKLw64JFF3zd9fOcxIMuoExCWDz8mw3eA9NOb1plPbpLnP8UvxbQdO/yMnmSTSpVAkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI0bzIQaZWbjUZU+DBEbF11q8Vx6IYWMleiZ/tEisoo=;
 b=G8XgyEGXOtK0DV+U9atNYS2Y6+ccgZ+S13XQ98GXQrVyatq2gWSv67Iz3RFNcE9C5UliLZeb+TjLX0eUanobH26QPkSKy51Nb2JMgwG94ed59g86j0yc88Y2PiUIdkFet0ea+6b3r6N6lJBtJSedHc56xdsGZhZMUpWVrB05Ul0gNSQV6r1QDNCuBw+Hcu/6oSheh0td4bByU8qZIDrARvlWz5YVQWntGT8NouOpOYFX5A0mFxMV0Eye2bqj2EB4/5trNyfvj4W9mhS9x9ncH33NQJbNcIQGcSpY1iTYq98JgbOaoh8Bknim4nuw92HLM2LPKqorgt0PajlnyrHRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI0bzIQaZWbjUZU+DBEbF11q8Vx6IYWMleiZ/tEisoo=;
 b=ceNJX8GJMSEKyS1ClIPF7td7l4cAH1Ery2Aj5Y/qWi+79VwuBwvHXhQEcCUChbDDOQYHXL4Egh5vw9pCbQZcvIEjGHeCf2MVShGGc5QTaTR2JsRf9Q5OPySV0YYMEs9JquR9UJR3o0tN+OX0sFu9WmL1Ivp40N81ec4k3lPLaxMS3SxmUm5F8ZS4hTA6/eNE8jtkgM7eGwlfe5MfmijdAiFHuvPEMeQtjWvu/zrW13/Jv0WKdg81VNWExguFaKxHnueKyGKRMKuxjLguOUR7DZtznssn0jXtV9i7P+FsIUsx+ydptuaAGVdE4o+anKbooJldtxPk4tlox+bWFCvL3w==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by PH8PR02MB11926.namprd02.prod.outlook.com (2603:10b6:510:40a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:08:37 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 13:08:36 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 0/8] vfio-user: live migration support
Thread-Topic: [PATCH 0/8] vfio-user: live migration support
Thread-Index: AQHdO6VUw0bceWEKj0WJC+q9Rq4pJg==
Date: Thu, 3 Sep 2026 13:08:36 +0000
Message-ID: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|PH8PR02MB11926:EE_
x-ms-office365-filtering-correlation-id: 3b1f6647-17d3-4693-57bd-08df09bc76ed
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|10067099003|6133799003|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: OD/bTYZoHwEquEW0Hra8Fj6YqEvV7NHVzp+SQQVuCbsXd1qf5Nda0Zx/K9wVXesnMJMGIqnPU6d7IZAHBZp9y0SRv0jvRIr51p6CEUINWtzftrAOuHSTSeIkMHUGcV1Ktm1zRQ8e9aUE/kUVBDnnFyD8Zl9NZeUPnUNrYWgNN5BTMc5MJuMhpi0f0lRatpqeE8pMgSIjXn4uuS0zi/0M0Srbv1llUwT+E6fH6n759y6mRPvB5NG2VF/wjnElArPCsiLTfhzXhDluOlsagJsAJKg8jijkef6iEYrlJtOTuFrY5xXlQHvZKO4Rm8UqsITVwepaLtUqHKHP7NW/STENy8T6bTTtNfqB6i2pBCHQPoYXeLtkJVemACrirCS8Ylq0oPKYZPkVfboVIgkhWjmKaedeQcQoKngdBOiAaJFd7A+wHgVk16u7mSoBnbghG0+lY79f+4uQTFs3b3we2ziW7XBX6Rw7MU7WBCM8/zchhJT21UzzmAwGkAyzGSz00ROZquxaD6M87HAL//ZYxRPQR0U/W07D6Iu8eu9iJp225XWR0F9joPKTws4CYg06rEwKcNmg+iIDPFAyyPuyY4+aKlVnvolYnblhVAJN3HKGsxMPW9cVnG9jjy89UC9B974yCBIk1CrAMs/GzEB3NpL3nfF6Dhhb9w4kvEEt6d+z0HM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1hRNzF3K3NPWGtFdHphWXliQW5LRFM2U25EbThjM0YxaVltSzBUUWVieGh1?=
 =?utf-8?B?V2ZRSS8wRzNDdksweEkzSngrV0VXK0V5TmtDNUpIa1gva2tSMlYvOVQ2SG1z?=
 =?utf-8?B?Ym9RZU9FUytueWdibEhiVWw3dHB3YzdublZKQzEyTXFiQVVPUTRFZ0NxQ1pX?=
 =?utf-8?B?SWRGVmRTTEhHNDhBSFEzaUhjcDhrOTRwUVI1QmVqQkpoQkdRMHZ5WUVtUXBC?=
 =?utf-8?B?OEUyQjJlcnd1b3lBcTFXZHZFVlVqUFlBUDF5R3BWdGY1WHd1cFk5MDVKN2Mv?=
 =?utf-8?B?bDRRTEJEcTAvREdyM3ozTkRTWTEvaXFmdHI0MTFXdFZKa1dsL2JqTHU1YmFq?=
 =?utf-8?B?cG9pOUlXdWpSanJCK1RyN3NuUmZwbjBUbDVNbW5nT2VzbHpvUGFaK3lYeHRF?=
 =?utf-8?B?cXgvcHpXQm0zcVZ0VjJ5V3JXVkRNQktRTytHR2hPcXN3N0VJVUxEMWZSRG1T?=
 =?utf-8?B?ampOVU9QRi8wVzB3V2FkNXRDVnFyd3Q1TDZFcmliZlNudEFCM1pYTitvZVpN?=
 =?utf-8?B?NmI3S29rRkJyNlhtZjU2L3VuVHRCaVZtY1BKSk16THhkc21nZTlkSW5yZ05M?=
 =?utf-8?B?NlVJaTRlVGhhdDRhWXMyQndpM2padWJMWmlNTGJ1eTZURTlHVURqbFEwUCs2?=
 =?utf-8?B?dWVhdXZPcEM3S1hPZW4rRHpkeHNxdE5nNk9aTi91dUkwWkhlUVJBd2wzN3hP?=
 =?utf-8?B?ODlxMjl4bXVQSzd3b28xaXY2cFRjSW9GQmwxWG05UTFHRTNwM253ajFha0sy?=
 =?utf-8?B?UGU3c0VYMXlmTmt3azFyUTRSMzhNQlhGSFJDSXdjUkJJbnQ1cTdXdDViV20z?=
 =?utf-8?B?Vi9BTnVoTWc5SGdiSVF4VTllTXhPeHU5SjVxT28zU2w5Mmo5bW1KcWtDMy93?=
 =?utf-8?B?a1ZWNHUya3FpdFBjdnp4Y2Nhd1VGMVRNM0JYUVBqcXQ3WVVndnYvSFNydGVZ?=
 =?utf-8?B?STIzU3NOVFJ6dGRrcy9MbDNmR3VZbWNRQkFGblExbW9SUzZnSkYzVTVHMkk1?=
 =?utf-8?B?SHZ2dWp1TndHNndqaXEwYXQ4R3JNb3VzQ3l6eVpHVWM2b1lOR2FHK2hRa0l4?=
 =?utf-8?B?VGVCSnBncTNKMzNJTmxZb1B3S01saHdFTDV4a1ZpTGZYOEQ0OTkwRXkwcjJN?=
 =?utf-8?B?ck5LQThCNnF1UmcxQnVqdkQrT0c5Mm1oRHZScWtNaTIwbHhXc29LSzdNMlY4?=
 =?utf-8?B?cVdVdXBKMTB1eVpjNkNrYzRxVE9qNWFTaVc5NE1uV1dnRnlUcVZ6cGtIU3hU?=
 =?utf-8?B?RTk5MmtwYngyazZNa1RJd0EzUEZ2d0FaVUNyaHFPZjgvSkYvdXRRVUdrUE1l?=
 =?utf-8?B?N1YzNUtuVDlUcm9PejhOUjBWc2xBTkpOWVpiU2RpVnhma2VUOXMrK2J2R3h0?=
 =?utf-8?B?dVBNd0J5Y1NhOTlHL0lSUzEvWFFpdXlObTlqemxmNjhjMzhkUGROWFNpczYv?=
 =?utf-8?B?U1JYeElwTFZySzh3czJEdnhzQTR0d3hzSXRXbXFLMDdjbEtTQzlxcnFKcTJX?=
 =?utf-8?B?Y1hpanBhSXp3eE1xRzFGazdKWFBnSzNrUFp3aGpUQmMrY0QvNXVEMnhaVXho?=
 =?utf-8?B?OVlFYzZRVHFRSUxUcWNzc0doYUl6WWgvdUlrV3BIS1FvYnoxT1RaaUtxZFhn?=
 =?utf-8?B?bEhkUGlBVHhTU09wM04rM2RiOVBub3hac2xPOUdNWUZQa0FLaDlnTjFlb2d3?=
 =?utf-8?B?ZEt1MDZVM1RueDF0NlBTVVBiUTNvYVhqZGdaUVFjUnlwZjN3MW1XMVllR2Rt?=
 =?utf-8?B?YXZENGRHNkFSU0FRMFpCMVlGcDhmOWFwZkFrNDVJRjI3RlkrUmdJcmZsZCtv?=
 =?utf-8?B?MXcweHlycVdMMEJVcXRYaStVL3lPa2luV01KdncrOG1JVlZCUFh5UURyOFdt?=
 =?utf-8?B?bi8wVEF1emQwWFFDckZaVEJBYno4UWdtWEtjZC9KdnJWMnJqUFlTVDY4cWxs?=
 =?utf-8?B?TlBxMWFjL2hPbzFMbnplK2tqeThJTmdLNUxYTmgvakZQTXBKQW5WUmZyS3RB?=
 =?utf-8?B?RmFIRFFsZ3o0a2xrbytmNEN3UWk3ek95dzgyd3NiT083RGpBOFo4Q0UrKy85?=
 =?utf-8?B?bVRieVRJTUNDbHY0VFZucUhONDFOVXRnTTAzcWIwRGtGV25sZDJVQXZ3U3BK?=
 =?utf-8?B?TERBbEUwcWpEUzZ5VmdrdTk0b0pZemVKeGtPZitvWXhxSkNpeC9LZDhhWUM1?=
 =?utf-8?B?NXl5TjN4cDRVYStLdU1pdGV6LzV6b2laazk2TGVabnBqUTBZeUkvd29KWWc2?=
 =?utf-8?B?bVJIaDNoWElUMWVXQmJaaCsxa3FGSU1xYUJiTjRCVDh3ZERVbDhIOGJLc1BD?=
 =?utf-8?B?NS95T2o0VFk1QlFQM3BRd1BmcHJ3SkhCTnRJVDBoSWdNbTkzYUxFdm5pZkps?=
 =?utf-8?Q?2rgbMbinygaeGEIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i5iRwN+jn55jkJhV+Bm0wtHdF8mH1C3ywEEw7Wi3vzDi130wrNmGs2TldzweAi7XbQaPEMUAvDW4+xMuELgerjZ/6BkzMxcOCYjyQKrnCpWmiDiVD2Dje4np2v/c6ojlvEwfDDVk2ayiaPmfJgUp7p/7mW1GJUFri1N6cqZ1RahHet8+7OgPx4kwyc5Zroa8Z5poWeEB6xOwMdgFLO4VugRVrTA4/UqY0m6wQZYjxv1rsAyQsBRYI1HwKraUyGbGiRdYCmbQ/mYlh8jeIWCqaMOCGxlbqcWiTAtRfq523nWqURosCi+vnYcpJBm9tTK8C6VzGufXVpXxUr8IfnGhkg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1f6647-17d3-4693-57bd-08df09bc76ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:08:36.3497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QM+wdoHgDB7ZRx/xRMXUdbl3qDyCXW8Mlwuv2QZiauyqwtfhsFnsv420bxXsebZUxgOGLNZJA8t8/4+ghxyaA4hYtqhTnelJAT5T3KierBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11926
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX/9/trsrUPzH+
 cBe1T1EdhLYZZXycwMY958Oq8cA9MPpRbtyXht+jMIU7ebF5LKPVFfJdz3QtVTqfrjuoh3dyvrm
 ySPA8N446a154CB4W883hg50BWk5Cnc=
X-Proofpoint-GUID: yG0piKOALUDTjrGrAZbsj3Bms2xA8cuj
X-Authority-Analysis: v=2.4 cv=V8NNF+ni c=1 sm=1 tr=0 ts=6a997157 cx=c_pps
 a=cfv+jupdUrUvkxZLjajzrw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=yLxAKQgpAAAA:8
 a=F6zgZBJto0R1HZ2lA6AA:9 a=QEXdDO2ut3YA:10 a=pu3MsO4jS0LNTy4EJMSl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX4esxOwnllhOj
 SgTMv/iA3mUN2+ybizG/25gDDulnZNNgjSWjP3HyKwkzioyaHAgdqdHxRMta9N+U9BT1NHutBLC
 YJ2qSjEuXlaVS9hPGBCp18fqgv1Jcpty9uKPFAr6DiABfN2JK2zor2qyX6UTITZ4K8hgd9ycwvc
 bATCKtJ1VE/X3fnMetzI96SjdFTUa7ctQXqvFTvgnF8JXMKWlVUsiicP3xST8y6+br2xsC5pvpb
 rUqeJl0J14G6AcwLOi0e3VaFG1zLvfJ5UcIsLhA7cl0zdht/XHbuM2+djQ0J/NN0zf+WP0zP4vL
 aLRjMlPkiLh8ooz1sPGNGJKgM6dRENJSUn+2hDWosFUz1TVk4h5O/uguJ9CUaICuTpOhKoNRdlu
 2uJgisuK3qZ6+5AepNTxJZiG1A+Dd5xMR2IEmGu6cCcfWScs1Sll1bEX9VDyrImZQkvH3exI4b3
 eWxEhecu4LZ8KTlltyg==
X-Proofpoint-ORIG-GUID: yG0piKOALUDTjrGrAZbsj3Bms2xA8cuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

VGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBsaXZlIG1pZ3JhdGlvbiBzdXBwb3J0IGZvciB2
ZmlvLXVzZXIgUENJCmRldmljZXMsIGJ1aWx0IG9uIHRvcCBvZiB0aGUgVkZJTyB2MiBtaWdyYXRp
b24gaW50ZXJmYWNlLgoKVG8gYXZvaWQgZHVwbGljYXRpbmcgdGhlIGV4dGVuc2l2ZSBtaWdyYXRp
b24gbG9naWMgYWxyZWFkeSBwcmVzZW50IGluClFFTVUsIHRoaXMgc2VyaWVzIHJldXNlcyB0aGUg
Z2VuZXJpYyBWRklPIG1pZ3JhdGlvbiBpbmZyYXN0cnVjdHVyZQooaHcvdmZpby9taWdyYXRpb24u
YykuIFdlIGFjaGlldmUgdGhpcyBieSBhYnN0cmFjdGluZyB0aGUgaGFyZGNvZGVkCmtlcm5lbCBp
b2N0bCgpIGFuZCByZWFkKCkvd3JpdGUoKSBjYWxscyBiZWhpbmQgdGhlIGV4aXN0aW5nClZGSU9E
ZXZpY2VJT09wcyB0YWJsZSwgYWxsb3dpbmcgdGhlIHZmaW8tdXNlciB0cmFuc3BvcnQgdG8gc3Vw
cGx5IGl0cwpvd24gc29ja2V0LWJhc2VkIGltcGxlbWVudGF0aW9ucy4KCktlcm5lbCBWRklPIHRy
YW5zZmVycyBkZXZpY2UgbWlncmF0aW9uIGRhdGEgdGhyb3VnaCBhIGRlZGljYXRlZCBkYXRhX2Zk
Lgp2ZmlvLXVzZXIgaW5zdGVhZCB1c2VzIGl0cyBhbHJlYWR5LWVzdGFibGlzaGVkIFVOSVggc29j
a2V0LiBXZSBpbnRyb2R1Y2UKdGhyZWUgbmV3IHdpcmUgY29tbWFuZHMgKFZGSU9fVVNFUl9NSUdf
REFUQV9SRUFELCBWRklPX1VTRVJfTUlHX0RBVEFfV1JJVEUsCmFuZCBWRklPX1VTRVJfR0VUX1BS
RUNPUFlfSU5GTykgZm9yIHN0cmVhbWluZyBtaWdyYXRpb24gZGF0YSBhbmQgcXVlcnlpbmcKcHJl
LWNvcHkgaW5mb3JtYXRpb24uIFRoZSBwcm90b2NvbCBkb2N1bWVudGF0aW9uIGFuZCBkaXJ0eS1w
YWdlIGxvZ2dpbmcKYmVoYXZpb3JzIGFyZSB1cGRhdGVkIGFjY29yZGluZ2x5LgoKVGhlIGNvcnJl
c3BvbmRpbmcgU1BESyBkZXZpY2Utc2lkZSBpbXBsZW1lbnRhdGlvbiBpcyBhdmFpbGFibGUgYXMg
YSBXSVAKc2VyaWVzOgoKaHR0cHM6Ly9yZXZpZXcuc3Bkay5pby9xL3RvcGljOnZmaW8tdXNlci1s
aXZlLW1pZ3JhdGlvbi12MgoKQ3VycmVudCBsaW1pdGF0aW9uczoKMS4gUGVlci10by1QZWVyIChQ
MlApIG1pZ3JhdGlvbiBzdGF0ZXMgYXJlIG5vdCBjdXJyZW50bHkgc3VwcG9ydGVkIGJ5CiAgIHRo
ZSBsaWJ2ZmlvLXVzZXIgc2VydmVyLCBzbyBQMlAgc3VwcG9ydCBpcyBub3QgaW5jbHVkZWQuCjIu
IERldmljZSBzdGF0ZSBwcmUtY29weSBpcyBub3QgeWV0IHN1cHBvcnRlZCBvdmVyIHZmaW8tdXNl
ci4gVGhpcwogICBzZXJpZXMgZXhwbGljaXRseSBzdHJpcHMgdGhlIFBSRV9DT1BZIGJpdCBmcm9t
IHRoZSBhZHZlcnRpc2VkCiAgIG1pZ3JhdGlvbiBmbGFncywgZm9yY2luZyB0aGUgZ2VuZXJpYyBt
aWdyYXRpb24gY29kZSB0byBleGVjdXRlIGEKICAgc3RhbmRhcmQgc3RvcC1hbmQtY29weSBtaWdy
YXRpb24uCjMuIEJhY2t3YXJkIG1pZ3JhdGlvbiB0byBvbGRlciBRRU1VIHZlcnNpb25zIGlzIG5v
dCBleHBsaWNpdGx5IGhhbmRsZWQgd2l0aAogICBjb21wYXQgcHJvcGVydGllcyBpbiB0aGlzIHNl
cmllcywgYXMgb2xkZXIgZGVzdGluYXRpb24gYmluYXJpZXMgbGFjayB0aGUKICAgdW5kZXJseWlu
ZyBjYXBhYmlsaXR5IHRvIHJlY2VpdmUgdGhlIHZmaW8tdXNlciBtaWdyYXRpb24gc3RhdGUuCgpI
dWdvIEtvbWF0c3UgKDcpOgogIGRvY3MvdmZpby11c2VyOiBjbGFyaWZ5IGRhdGFfZmQgYW5kIERN
QSBsb2dnaW5nIGJlaGF2aW9ycwogIHZmaW86IHJvdXRlIGRldmljZV9mZWF0dXJlIHRocm91Z2gg
aW9fb3BzCiAgdmZpbzogcm91dGUgZGV2aWNlX3Jlc2V0IHRocm91Z2ggaW9fb3BzCiAgdmZpbzog
dXNlIGlvX29wcyBhYnN0cmFjdGlvbiBmb3IgbWlncmF0aW9uIHJlbGF0ZWQgaW9jdGxzCiAgdmZp
by11c2VyOiBlbmFibGUgRE1BIGxvZ2dpbmcgZm9yIGRpcnR5IHBhZ2UgdHJhY2tpbmcKICB2Zmlv
LXVzZXI6IGltcGxlbWVudCBtaWdfZGF0YSByZWFkL3dyaXRlIHNvY2tldCBvcGVyYXRpb25zCiAg
dmZpby11c2VyOiBlbmFibGUgbGl2ZSBtaWdyYXRpb24gZm9yIHBjaSBkZXZpY2VzCgpXaWxsaWFt
IEhlbmRlcnNvbiAoMSk6CiAgdmZpby11c2VyOiBhZGQgbGl2ZSBtaWdyYXRpb24gdG8gdmZpby11
c2VyIHByb3RvY29sIHNwZWNpZmljYXRpb24KCiBkb2NzL2ludGVyb3AvdmZpby11c2VyLnJzdCAg
ICB8IDEzMiArKysrKysrKysrKysrLS0tLS0tLS0tCiBody92ZmlvLXVzZXIvZGV2aWNlLmMgICAg
ICAgICB8IDIwNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiBody92ZmlvLXVz
ZXIvcGNpLmMgICAgICAgICAgICB8ICAxMyArKy0KIGh3L3ZmaW8tdXNlci9wcm90b2NvbC5oICAg
ICAgIHwgIDE5ICsrKysKIGh3L3ZmaW8tdXNlci90cmFjZS1ldmVudHMgICAgIHwgICAzICsKIGh3
L3ZmaW8vYXAuYyAgICAgICAgICAgICAgICAgIHwgICA0ICstCiBody92ZmlvL2Njdy5jICAgICAg
ICAgICAgICAgICB8ICAgMiArLQogaHcvdmZpby9kZXZpY2UuYyAgICAgICAgICAgICAgfCAgNDkg
KysrKysrKy0KIGh3L3ZmaW8vbWlncmF0aW9uLmMgICAgICAgICAgIHwgIDc5ICsrKysrKy0tLS0t
LS0KIGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAgIHwgIDMxICsrKy0tCiBody92ZmlvL3Bj
aS5oICAgICAgICAgICAgICAgICB8ICAgMyArCiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2Uu
aCB8ICA1MCArKysrKysrKysKIDEyIGZpbGVzIGNoYW5nZWQsIDQ3OSBpbnNlcnRpb25zKCspLCAx
MTIgZGVsZXRpb25zKC0pCgoKYmFzZS1jb21taXQ6IGVmMWU4NjY4YjlmM2FiNmQ2ZTc4MjY4MDZk
YjFkZTUzMjZmOWRmN2QKLS0gCjIuMzkuMwoK

