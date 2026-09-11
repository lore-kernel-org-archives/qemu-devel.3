Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E07C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526q-0006yJ-OG; Fri, 11 Sep 2026 10:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526W-0006jT-8z; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526R-0004Aj-1w; Fri, 11 Sep 2026 10:19:45 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BChKPb4141308; Fri, 11 Sep 2026 07:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kklHRryTG0DxhA46oD4texkkRuG4tORnJOyyQyviu
 k0=; b=BolfADeeYvttbbUmkr1+D+vs7+xybg5BlCGmxMvLaBpUPvh8o60wke2CO
 /IDSM0DNu+q5rzxTyMMkKqaepEoHu+17uq74zqC4U3Sb8Wy+RqEh6Y1iFcpdkqUW
 17lZ2RR2fsHWt8h/arsmVMwrOp/N1/VkuWNQRjG4lhLRxTcjLrPbTdPseWCfe/Z5
 wTK5w0bQKslKIHaDKaCYeRARuTNU124xK/zrvdkxVx1eVQnTq03lKSRzkNfGSOsA
 T1wr81bWBKK1ta9gD3ZrMGzFYv543Q1X31KFSZbvVY3SzHVTsU9d1JJiQfYFIoNi
 k3bZQWDNQYUDASjNVhiBnSkCThm/A==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022127.outbound.protection.outlook.com [52.101.43.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkcyvn7qm-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCw7TyWr8WK9Wy/CBGMLnYJQABC37Hq32/CcIjqcG8jTRdHsGwbJZ+iLTd8KmlHO2R1mqLiOVOOImPQM1iMUob/lCj/NPagkrWY6s7h7QugldbKPfWcZ6v85TLKsMVoFf50nOrUGBvbtOo8GUb+xL51BQ0UwYTMWErDXtY4MESf7Y67BgFzWvkSyYHcH/iVRHAssICAa7Qz8HmVkJA16QcRBBrbb+y/Ir13h4iSArYMUknY+TFL6boKhEX3xk7Abe0bW6dQnD0TsruP1WW6nJipgxotdB/hfqUMRN284dm8XK6wvVnKiYJzgAEGB+DOgAToGIIhOuWVM2rJpc8RqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kklHRryTG0DxhA46oD4texkkRuG4tORnJOyyQyviuk0=;
 b=mkgmbIch0oYXHsB4MNRp5RKfCq9hfgYncTKLQEAt7v5ssMHDNzAv3jwdSscHO2m8b9OY4EHgvp2+60sFJWcxJ0XBRCZ0ZpKsIFCZp0e5yVEqIuiOv/I5XtN4Iy+vWXHwUdooYO4RQlJMDU4g+O0YmeiGmq79uuOAoyhMgEea0Z/RSbTy9qit1Mz72JnI72tiL7tzlsiF3b461XnKfMgv7JiHRoJcIz7ITWeJOY2Pd9y6jvArRt/EM4FdT0LOpn6McRz2lNj8e1zfGU+XPDFBrTubkxE4J1YjvRPO0Xl+dABw72Z9//4FYNWrnDODZRNlRHs/E2Gmnsuk20EtknlZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kklHRryTG0DxhA46oD4texkkRuG4tORnJOyyQyviuk0=;
 b=Qw/hyy70Sutp3oAJkzU2CXEOGQuViSb3/rrBlPV9u4aIDdjnOPdaHrknJuXaWwBNrSlwblmZXfuZNKd9pVxxYT0+I6ZeFShDZh8mbq3+6tW7OsjOJahCo4cxMQ/fieBappDJsYQS+S4/4P7PJeVzIh7LuVCy7lmGjjpUmdVj2pH5izZXv74oAVkTunlXKeEMgum1yHy+dgvSkCiJTRIK4FvIruOuKqQL1JkriIrSRwexjwj3ftLeqpjMHTs9qOHUzwVSCDG15wau6441/J2BFHxA2y2ByuWrboRA7PumWodoTZfEOiX0ExDy40DG8EnvgfNQXacR9QLNbsfouhWSZg==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:35 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:35 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 8/8] vfio-user: enable live migration for pci devices
Thread-Topic: [PATCH v2 8/8] vfio-user: enable live migration for pci devices
Thread-Index: AQHdQfiSDyvys3vGwEeie0u9swkSEA==
Date: Fri, 11 Sep 2026 14:19:34 +0000
Message-ID: <20260911140710.2348139-9-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: d2eb7bcd-5fed-4127-3f52-08df100fb4dc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|6133799003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 8d7QFj+tAFTdIf642xyymzFpkf6qae+EIob3H1m0d69elagwBVoKw+fxWHXGNQ7TKt2+6fRZAZvBIpR5YvivqymKhQbAPswV3sWSnPMcKLoM4vXhAmHhpuSPy5H43syzCqmJHifQ/HUtvNIpYqdrYAeVdVEsQT5FzC40l3ATzbfbwQTONLYd+W9ee+zYaSD3HveB5MuE7XQrAWlemf9DGWzTPWg6nJgyHAwfe1j2kr6Lo7QsCItGMaxG53sVw/TuKD4sMwsggN84HMQ2ZVGrv1modSjukktSd4269sP0ZT5O3mT7QVJXl5cEmyNIYYLykHPsdZ7Yp8FZgUjPxSg9yWu1u9F/ktoU6Xo4y6xUHpDbNqgXxMaiHDq7HayvGGvv7HXhK6I76Yi4Fil0UONE517bSPfeUbAvaz02e7iEnWg1gk8VcqgvpPlsH6iZYXc+gRP2+XhEDVmikV3tOZuccSPLSFMRZJtJ5r0l2UMSt1CMNs+rBMmAlLwQLalTNjT0vFasKXuGBw/HFuDtNjRyrRd+VkjAceE25xlAEXeLorxKn7LU/6bvFG4G103XhkUTsEBB7Gk20ezH1xpQQdA5ZPLLzAgL4a3pZGXznm2qrFtf++d/QG8LMoTj1ufdfvpdOGJoE33rtu017/RuUPSzm7sWHYw/P4nVqmqzBSzLMjC6Rj+0soIjV9cqqGHdfhyllCjvtG40lTkHxPM4qTv+Sj8hVwS6RBdXc4Dr0zlzEtE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?et115KZsFO7yaK1N39y5/5XTFn1kxr5YJQ0fb5qq7+X0mJSikVJkgZ5deE?=
 =?iso-8859-1?Q?38mHC0Hncz+lFKVwJ9AW7k68s3YCZ5pJ0wVcxU9GFU9KJ/TwRRll6qmG8W?=
 =?iso-8859-1?Q?NPK00G+lFQTYVeXp2oJ0RCtYIFaTc3F6nKYPZe1oX5UlAmIHSekYMxCcqS?=
 =?iso-8859-1?Q?WzNhBuHuz7t54CusIEbNpa2Eat1WDtD66AHWP6ET6JqIeFGrLh+I/wOk0b?=
 =?iso-8859-1?Q?X9AwuhkpyDdIlu+s8cAMAJLdL77yOX1Q5Y5b+Sbt68ulxRp2oyrrATlQ8g?=
 =?iso-8859-1?Q?HP8ot9QbqjovmLAfFgzTBCZ2uVejwE3DAO4jhmxVWhK6wV+0k3/Ci6Cfur?=
 =?iso-8859-1?Q?XeZ8DgjdQvZgcm1uJzajH7bjj2UhGPXEFpGNaxZ7z7TaZJOXgH7YnW+9H0?=
 =?iso-8859-1?Q?qfy5g3oyy0G9+jKsBXTa6LUyGOeT3r9n/iyudurLFQmgI5f6qz4PM2shHH?=
 =?iso-8859-1?Q?p3BPu6pxn6X0PzsyOG67KLeZLIRmTxwAYXA6nyFaPr+uAwGA02BBI2dJon?=
 =?iso-8859-1?Q?vbHdMwRsL2kvOX+qto0XfIiT/zFMk3GLuO0kAN5HfHpKqW4sOWsDnUnWYV?=
 =?iso-8859-1?Q?WRh/bikwu/ZMc21L8gu38lQv+uKXsw567aqMY3OsGj0PMw3FOoksLGzQlN?=
 =?iso-8859-1?Q?GJLjWrPTCSYf9WksXEJgJGbqoOQOSdqZ9v7aZwe4Ym9lw1P9gA8vkeHUDp?=
 =?iso-8859-1?Q?YRLe5TYEbYxxGa06gTayJOcp1k5QU0/MLEfjZAtwnpQ+EdhQPxfLUwJywG?=
 =?iso-8859-1?Q?jcUONRIZqeT3B6WqXj6UcNwzJR4W52oUxFb2+339/V8fAzUxTZaUl2JySI?=
 =?iso-8859-1?Q?Ho56rMzWLlZEHulVK0sgdDKZsCzMYxPxUygGq1zGwhNTh6pCFEq2PEEi49?=
 =?iso-8859-1?Q?FXdr3uOzB2HBKPmAb7wdpjBTrGO2k18KqokvH8VX0EDrucoT4BygtN8qvL?=
 =?iso-8859-1?Q?I951wnTGYqcUHk+Z1CTwPpcXrl4xAtoZFz5cFaM7tSzaIL/nS0jeLOpQTl?=
 =?iso-8859-1?Q?lth2TLneq6OW98KwUb4UmdEzAQkXvdsfzwxpgoA24U4zguX8r/loywcLOB?=
 =?iso-8859-1?Q?GTQCi0w0fP65uGNddeneabi/Ru2FJM2m4YQebrd5oUK/LYEkan7Lt1kIfj?=
 =?iso-8859-1?Q?so+8l6613nNKmf80vfcwQ8RQY9v9YCWiUBwIqR6Q4DZYRWhWkgFnsSdFQe?=
 =?iso-8859-1?Q?bJxqPO9HM9JoDfxTQIdCamQg3RCzDbP/NIIu9LRhJ940bW4/ssGjf/i2lX?=
 =?iso-8859-1?Q?vMXDUIpq+zQGMJ/V+62zl0re8FNqRSksWBWiV0+dQvzQxOH4BSX8Ya59/F?=
 =?iso-8859-1?Q?gREsP3sK9m5xk5VCNSREuC6D1DXPreIiDhmvvcSSnGDg3VieNPqSTCKU4H?=
 =?iso-8859-1?Q?J0NuR2hR75yFO0zyqXR+Fn2UXUSS6URIHlYBk9IU/0l0Avf3rutvQVVsqN?=
 =?iso-8859-1?Q?T4qxBb6HvPK2r48VZp6mDJvlvYyGr96tFnRbGNG1T6svRjS9rfTUpvMBsD?=
 =?iso-8859-1?Q?HPRkTw4OXwI6Gx4P10kDm8Upcd6tRvuSFBO1jk15KXkvrI92IyV8tUOMrm?=
 =?iso-8859-1?Q?LkGkwmXYRjco1+IUkMXftAvMYNoqOBrsV6klXO8D1MCchG+qPsglpqn4v0?=
 =?iso-8859-1?Q?VEtlBBJZ780soL/kewL1sq1/4SCz3lXyxL/7YAzMeXKVMd44Epf49mWYrV?=
 =?iso-8859-1?Q?Y+EEX4Q6PGeaAq3aHy83K+/aBdooUYCdbP4+6RwoO3EUwUiiRy+woPKpTH?=
 =?iso-8859-1?Q?RCSW6HPE+cop2+rBzl3oRzbd5xTCR5VAISPZzUeEYuZco7Aftb9rep6h7C?=
 =?iso-8859-1?Q?6zLrBdp5/fHz3e8iC1/wq4sCn5gTD+Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YcVpcrL8M3cPs+pkIzyPyHtCIGIyKZEhUXvySDX7sxLxs8wXiHJ3Cuq5TsTTAcqH6y0pH/P7C7zFg+z74waKf901x4bPZedCLVi9xcSDlx8S7+8keYWkMiwFHm6eoy4kyJ6ZUoK8WMPXlEOuBGqddv6AxmboL5GgXeRG1dd0eczdd16l6ZNWK7z9s9Um2qwht5B5Rli9R/acolnG5QRV8C2b/x+YQjNafVU4ys61VdOMrqt7T5wT80wgIBe0oLW1ltrErC3ZQ22PJMwXe5d/NZQsbiHUlN2pMVHYhEcqz8/ancTvUO3b1Uex4YDjRrbelC4dBp5uyOIo7iV45hib+w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eb7bcd-5fed-4127-3f52-08df100fb4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:34.9925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kcn37w3yJ5EOC1Nj4ZzDU8U8Z6ZjkljkZeLsJVtLjdnAtaAzmOVS5v/HCVrvECmvrigRCO5XpPxtlQofqXFvyXpdhrVT5JFyoRhG1SXaXeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfXyGhOvhcJiTSt
 ddd1j1ep6a3W238L4RyqZqjMY1+LWFW+pzFIdPFuXNzU4R47iCPdlv+ybJ75IjFCVmX2fo/mkya
 6e37S5RboXpu/FDcDsEx5ccbBHThOOo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX8S+UcqJyzUV+
 4Ur0yvHHdRB9vFQP3573vLMGW26sEOupHJm4aFo5UK4KvLgGxzvmVGzJzh2balmmylz3UC74M9v
 +jkGpI7klJd78rEXHGj7g8/PLBoO3xm9PjIjD9dMt0R60JgYrtXgv09AADiBI3rxGo8TtIX1bPb
 bhFj0vIz6iSP8SowoGlsIz4vAc6sDlN3mNhov9xMSG47e0x8mhg6ecgrgS0ruzrkUf+KqDRuGTY
 zBrQvUOTQBAq3bpx90uhlHN/H6F7RbkshcTcw4UQaaXLauHyvuTtcNNnGf5ej1vDcJlfhMv1E/I
 0F5eA5zme4bKWbVSPBSq5x05KUxBbEeeIdZpzlden6PIC1lzImQLh8kvPONZZAn1uKSBPmftAl+
 BR4ebDgNZywki4NGThLJKSPvGa9aLg9QR+IQSD5LemvL9wEsxVYsYDb553CLPBqNqQfPrhg899H
 n8EtHIN32eiEcwWI2aA==
X-Authority-Analysis: v=2.4 cv=Ae8kjHXG c=1 sm=1 tr=0 ts=6aa40df9 cx=c_pps
 a=/+kXZUEK7Fsqfsk0sF7w8w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=64Cc0HZtAAAA:8
 a=p7XhHSwCDMY6iawtdMMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: IXqqC4EIPRAVJ8ioMIuGOQbKbSmbNJSi
X-Proofpoint-ORIG-GUID: IXqqC4EIPRAVJ8ioMIuGOQbKbSmbNJSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Enroll vfio-user PCI devices in QEMU's migration machinery. Export the=0A=
kernel vfio-pci config save/load helpers (vfio_pci_save_config and=0A=
vfio_pci_load_config) and reuse them for vfio-user instead of=0A=
duplicating the logic. Call vfio_migration_realize() from=0A=
vfio_user_pci_realize() so the device registers its save/load handlers.=0A=
=0A=
Expose the enable-migration on/off/auto property, mirroring kernel=0A=
vfio-pci, so migration can be explicitly opted into. Peer-to-Peer (P2P)=0A=
migration states are not supported by the libvfio-user server, so P2P=0A=
migration support is not included.=0A=
=0A=
Device state pre-copy is not supported over vfio-user yet. Strip the=0A=
PRE_COPY bit from the advertised migration flags so the generic=0A=
migration code never enters the pre-copy path, forcing a plain=0A=
stop-and-copy migration.=0A=
=0A=
Co-authored-by: Rafael Castillo <rafael@trfs.me>=0A=
Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>=0A=
Reviewed-by: John Levon <john.levon@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 11 +++++++++++=0A=
 hw/vfio-user/pci.c    | 13 ++++++++++---=0A=
 hw/vfio/pci.c         | 27 +++++++++++++++++----------=0A=
 hw/vfio/pci.h         |  3 +++=0A=
 4 files changed, 41 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 6b767e94d3..a0c23e1a68 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -197,6 +197,17 @@ vfio_user_device_io_device_feature(VFIODevice *vbasede=
v,=0A=
 =0A=
     memcpy(feature, &msgp->argsz, feature->argsz);=0A=
 =0A=
+    /*=0A=
+     * Pre-copy is not supported over vfio-user yet. Strip the PRE_COPY bi=
t=0A=
+     * from the advertised migration flags so the generic migration code n=
ever=0A=
+     * enters the pre-copy path, forcing a plain stop-and-copy migration.=
=0A=
+     */=0A=
+    if (feat =3D=3D VFIO_DEVICE_FEATURE_MIGRATION) {=0A=
+        struct vfio_device_feature_migration *mig =3D=0A=
+            (struct vfio_device_feature_migration *)feature->data;=0A=
+        mig->flags &=3D ~VFIO_MIGRATION_PRE_COPY;=0A=
+    }=0A=
+=0A=
     trace_vfio_user_device_io_device_feature(msgp->argsz, msgp->flags);=0A=
 =0A=
     return 0;=0A=
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c=0A=
index e7573d4a9f..b9f65e78ce 100644=0A=
--- a/hw/vfio-user/pci.c=0A=
+++ b/hw/vfio-user/pci.c=0A=
@@ -13,6 +13,7 @@=0A=
 =0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/vfio/pci.h"=0A=
+#include "hw/vfio/vfio-migration-internal.h"=0A=
 #include "hw/vfio-user/device.h"=0A=
 #include "hw/vfio-user/proxy.h"=0A=
 =0A=
@@ -239,9 +240,8 @@ static VFIODeviceOps vfio_user_pci_ops =3D {=0A=
     .vfio_compute_needs_reset =3D vfio_user_compute_needs_reset,=0A=
     .vfio_eoi =3D vfio_pci_intx_eoi,=0A=
     .vfio_get_object =3D vfio_user_pci_get_object,=0A=
-    /* No live migration support yet. */=0A=
-    .vfio_save_config =3D NULL,=0A=
-    .vfio_load_config =3D NULL,=0A=
+    .vfio_save_config =3D vfio_pci_save_config,=0A=
+    .vfio_load_config =3D vfio_pci_load_config,=0A=
 };=0A=
 =0A=
 static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)=0A=
@@ -343,6 +343,11 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Err=
or **errp)=0A=
         goto out_teardown;=0A=
     }=0A=
 =0A=
+    if (!vfio_migration_realize(vbasedev, errp)) {=0A=
+        vfio_pci_interrupt_teardown(vdev);=0A=
+        goto out_teardown;=0A=
+    }=0A=
+=0A=
     vfio_pci_register_err_notifier(vdev);=0A=
     vfio_pci_register_req_notifier(vdev);=0A=
 =0A=
@@ -426,6 +431,8 @@ static const Property vfio_user_pci_properties[] =3D {=
=0A=
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, fals=
e),=0A=
     DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000=
),=0A=
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, fal=
se),=0A=
+    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,=0A=
+                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),=
=0A=
 };=0A=
 =0A=
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *=
name,=0A=
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c=0A=
index 73b4a93fca..838bdeb0c8 100644=0A=
--- a/hw/vfio/pci.c=0A=
+++ b/hw/vfio/pci.c=0A=
@@ -2996,7 +2996,7 @@ static const VMStateDescription vmstate_vfio_pci_conf=
ig =3D {=0A=
     }=0A=
 };=0A=
 =0A=
-static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error *=
*errp)=0A=
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)=
=0A=
 {=0A=
     VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice, vbasedev=
);=0A=
 =0A=
@@ -3004,7 +3004,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev,=
 QEMUFile *f, Error **errp)=0A=
                               errp);=0A=
 }=0A=
 =0A=
-static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)=0A=
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)=0A=
 {=0A=
     VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice, vbasedev=
);=0A=
     PCIDevice *pdev =3D PCI_DEVICE(vdev);=0A=
@@ -3570,6 +3570,20 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, E=
rror **errp)=0A=
     return true;=0A=
 }=0A=
 =0A=
+void vfio_pci_interrupt_teardown(VFIOPCIDevice *vdev)=0A=
+{=0A=
+    pci_device_set_intx_routing_notifier(PCI_DEVICE(vdev), NULL);=0A=
+    if (vdev->irqchip_change_notifier.notify) {=0A=
+        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier)=
;=0A=
+        vdev->irqchip_change_notifier.notify =3D NULL;=0A=
+    }=0A=
+    vfio_disable_interrupts(vdev);=0A=
+    if (vdev->intx.mmap_timer) {=0A=
+        timer_free(vdev->intx.mmap_timer);=0A=
+        vdev->intx.mmap_timer =3D NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)=0A=
 {=0A=
     ERRP_GUARD();=0A=
@@ -3745,14 +3759,7 @@ static void vfio_exitfn(PCIDevice *pdev)=0A=
     vfio_display_exit(vdev);=0A=
     vfio_unregister_req_notifier(vdev);=0A=
     vfio_unregister_err_notifier(vdev);=0A=
-    pci_device_set_intx_routing_notifier(pdev, NULL);=0A=
-    if (vdev->irqchip_change_notifier.notify) {=0A=
-        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier)=
;=0A=
-    }=0A=
-    vfio_disable_interrupts(vdev);=0A=
-    if (vdev->intx.mmap_timer) {=0A=
-        timer_free(vdev->intx.mmap_timer);=0A=
-    }=0A=
+    vfio_pci_interrupt_teardown(vdev);=0A=
     vfio_pci_teardown_msi(vdev);=0A=
     vfio_pci_disable_rp_atomics(vdev);=0A=
     vfio_pci_bars_exit(vdev);=0A=
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h=0A=
index c9ab949870..9298e0e996 100644=0A=
--- a/hw/vfio/pci.h=0A=
+++ b/hw/vfio/pci.h=0A=
@@ -221,6 +221,8 @@ bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **=
errp);=0A=
 void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable);=0A=
 void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);=0A=
 void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable);=
=0A=
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);=
=0A=
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);=0A=
 =0A=
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);=0A=
 void vfio_pci_write_config(PCIDevice *pdev,=0A=
@@ -284,6 +286,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Err=
or **errp);=0A=
 void vfio_pci_config_register_vga(VFIOPCIDevice *vdev);=0A=
 bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);=0A=
 bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);=0A=
+void vfio_pci_interrupt_teardown(VFIOPCIDevice *vdev);=0A=
 void vfio_pci_intx_eoi(VFIODevice *vbasedev);=0A=
 void vfio_pci_put_device(VFIOPCIDevice *vdev);=0A=
 bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);=0A=
-- =0A=
2.39.3=0A=
=0A=

