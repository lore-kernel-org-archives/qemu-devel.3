Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1690CC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526r-0006zL-6X; Fri, 11 Sep 2026 10:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526Q-0006j6-SN; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526L-00049p-0k; Fri, 11 Sep 2026 10:19:40 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCh7K6004863; Fri, 11 Sep 2026 07:19:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/dHWypyBeMBGo4jOvIhgHsFRBD+Jqelqw0TFuraLM
 wY=; b=w0boHeE4UgkwPRPCp3oGSwVvqTXHX14y9I3XiK6ZNUXR5gRr9H64/0Hen
 tbdhOeg5oy2sDRipXKOMHR2vHN3wjvLF64kvB3MHJqhpRk6fiL0qZRwvaW+FAIx9
 qSUnOkQjEff5i4HxFvzqCzBkZj2cKSqbUq+kraa5mh7rWl+r6PUE+D7omJMJyiEr
 FmebjxcWajUjxkgrgPJHBqGiVVXcLnkpFkEcNIfCUQ1es5xRvXLcERzx79KfsenN
 D4KEXzotJ8CvON80jBZQ/R5PLx/oCelSG1g/Hjqqf1gdRkVGFEvi+t5CUhKZtLqp
 v6pBhmwxUcaVCzFt58RgOSKQfBtAA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020087.outbound.protection.outlook.com
 [52.101.193.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkd0157rs-5
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBVfoQfyz/hZnsOvjCAWt6rWb05LPwISHj/7bgProm6pQis4m5l0Zb/7IksemfIP2dvsxPht6V8lU3B62SsqlSN/o0DUbvC0in04RtsWYX5urn8KozuE61PnmkFKbVfAsIAgjXstQg/+2hL32H7QcDjA39t2PDc1XW6iBk3307rLvk7mDe1J2K5vKIMqYhfRYK0BCPCOGPi8cPs22tvLAy3ekxpkz9T5kFQhsK0wW9O+QTMQOIAMNtHF3kj2JrPqUkGV2w4GrLish9mwb/zmW1ttlLa2yfRom3X2GZlDe4tAg2vT/c4yhnWKcQwcjiwRKCvHoxUoa6akaJRrUfrJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dHWypyBeMBGo4jOvIhgHsFRBD+Jqelqw0TFuraLMwY=;
 b=A5VkBv4xTEdH+QX4DJfFm6qd6Tu/OT1j60X0hGhDWr+vY9eenkM/lMxhNj33gagfYhFiYnoZ1d2zStN7OjSuruD7NtXUu9dALY7lYwrIqMZwtbh/XIaj6DOh2hKWemmHKIvXViCGfQ1BEmqQpy0U5gK6e6CoDRcy2+h8R+hDgQr8HgP1BRTUommjjJ+1UMO5FioVCTAPJOvbbJpsPj5+Tk2BKTvuCnaycJift+S5JM2nTs8Ru9p1Qc+zRFxtjiFee7l881Bm2tavZZQUqB0hrXAOhiWJX8idCf6zQwHxTmgYKO7LKAIR0Flc3LdOPSmjxkpsAxYmnV+DRKnzxJ4hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dHWypyBeMBGo4jOvIhgHsFRBD+Jqelqw0TFuraLMwY=;
 b=vqVE7sG9rPt6aYWhkBuM2i5dsS1QHz4tINtFTTxzZ0y+sc1UjZEJNR1qtFbyvoCrhXBNl4iMImMjuDNxxHIY+gkMz68KpCeULV5dtRGjCHWfqFBcJTH0oNoOH4njGii8vB/PygwEA7khPozY8yBSLLPdloMZ0zSBBIPi4lFlsunWE/ILjpxQ3xS1ujAN0+xGM7VvpX8lqyaBT07WXF3bTUSqCFQldkk7r48WUq6euZqmD/yG7HmO5YlRTlci2J4F13r6D7NNshRB5xDbcTo5kfkg70YQRYKi1JUOmmvoOYwMJtsCeKa8RRXfY89QvyJbQVl2oS++UcaCwEPhBSBGSQ==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:29 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:29 +0000
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
Subject: [PATCH v2 4/8] vfio: route device_reset through io_ops
Thread-Topic: [PATCH v2 4/8] vfio: route device_reset through io_ops
Thread-Index: AQHdQfiOnJXcGtgOsESZJy0vxBBkxw==
Date: Fri, 11 Sep 2026 14:19:29 +0000
Message-ID: <20260911140710.2348139-5-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: 2cab5522-2860-45ac-97d2-08df100fb110
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|6133799003|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: Z3Zib7HJlr5fOokglDpChmZEAktrL4Pbo02Y+lADhPl8QnB5EZsecYQMek7JOYXlFZyxDt3TAy3PY4Qht8gE8VY0ursrjPVkImu8eBuc7OxN3L8NnyVcx7V8HC1pMSgUyQ5xOEElE05Eg5J8Ah6HCzfxOzaFLIi4HVDS7GgDmcXajJesfFC4PKNt5yaNN1HW5hFP14Ln/TufO1L7sjPiWFqRhRuWht2y20MoCn3QcCPXn5Dwl8RKAjugn9AiVpRwW6Q0a3jPiZUPELBTDjsg9lRktz8bTljUp5MQaX22CX10mSHvSmmc5D31GhFlWkmZx17qK5e9hMx/IoIUevOYpMECI6aGNgFtcErjyEPSA+xie9cUBmcPN8Pq1XhoMqyNU29TvxJWJuFc2HTSkI1obUcwCWYqLrosnPqF1o54MBtqPLzQulGXy7XaG5pTU6xLq8ObHoW4yIbr+lg3X6DeAwL5lC+srhPYSsrbxMykCaMdEVtGA8fYF5hLjVOUwZOtBNiSmiT7KjIGql1l7zWMinli9HH+dGQG1Gkp/y8kcMc9OfBZ7AurySgKNKDKN3YEOf0ITqkW1cVmexuLhJD5hPSmJT/ltcN59CsYmW0m4wG6ZQ034xfuScB3Hw+Li5NdCV8OaMSLSS4oKdpwaQVHq815WbF1lc9BhOo+TUKyux0cdf5rrO1zc7AW+/91bZMC2/dlGKGUM0kuE+wmM7sKdBoQ2g81Kqq1/kZQA5NR+m8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZlwIi0cW6lmMhIsCrp4hnMRLtvhc9rFVuG1Mt6kveM1z77OqttzwkcHBvm?=
 =?iso-8859-1?Q?Qjs5ERVDjDIRvLX7v0cJEBL0ZhHyJ0XfjzBiAkXBBcU5N4Ki/kRGPtz23v?=
 =?iso-8859-1?Q?MocQ3OjvGKIdnHRI0C9liijUKZE+bxjSVDuUCKobFWsS1XRs5XwUb46T1e?=
 =?iso-8859-1?Q?kJICtByoBQ2ivg83Byd5HzikV+q6/3uh/5ZVwVk3ymu1ZVMVSkfATkdBL5?=
 =?iso-8859-1?Q?gB7wFsuZiQkbLrqXzI082iTP7e5kE2SAmV9YKct2ICTqVsAvux8zH/97qG?=
 =?iso-8859-1?Q?6x8UPAz/55LVv+p5fCCWyKy9yE7aPZ4aWzIfj98VqJ8rhkHfDcWw3Yxwvq?=
 =?iso-8859-1?Q?wtqNfx0eOAxc9J+fJkMTkGh2Fkcc9SikYlR79LNY958DcZL7WdDsQ+eebE?=
 =?iso-8859-1?Q?M1/Tp9X5Eo1aALq5ETr3uYT6Lx71yts/UURhjGxeLCV+waFPTjYbOafgII?=
 =?iso-8859-1?Q?bhLHJpPmEyyfvVPViqsmRMybXq2vjg6oemjiGjdWmUNamZvMTGUVTFr0Xt?=
 =?iso-8859-1?Q?CM5+ZzPeViBK8NWhYmNgDoPZFs88JglCLZLf+QIhVl6cteq2MquW95KiBa?=
 =?iso-8859-1?Q?+sCZgCTXgQH5X+vRD0p7N7XtpUOm+Qpsd3GWthOt25KlR3hvEh/Xv+jeme?=
 =?iso-8859-1?Q?8PWExVnM78dd5aH6T5AzXnN0mZJgD3NjhjiS0uRhBdXS0GBW+7c2HDv+c9?=
 =?iso-8859-1?Q?KTtN7sdS/sRN7gq3GOn1UuZ+EhKublsvUuE/Ulg3Ik7XD4oaBHC7UG4qXl?=
 =?iso-8859-1?Q?0PA/4FaVHVXr/86qlo5A/GaLdmLVOxeRSW2NEgI41P1G4RoosE7pc+tyRm?=
 =?iso-8859-1?Q?3HSrLldO6iu3obUDNoxeq5OH1MNaHIaVk/IV7HKZxuFKgo5BLqkToCIK9t?=
 =?iso-8859-1?Q?V7y3pKVo9HAUPVOgSPgiaTg25FSTDHJfUj04/XzSHLDoJ/O3pHRgrgHpqB?=
 =?iso-8859-1?Q?wizj5iExDajb/cF4ouM/ftm/X/xMLsKlfifSlmzTCvdl5UYA1KqnZ8UYvr?=
 =?iso-8859-1?Q?VV/ffUAKwO1E0PTtJdlU6TAJlrG8w7AsNd2MAqLa0ME8t2lsnnBB0ZUxKE?=
 =?iso-8859-1?Q?8l/kZSJpjOs7nVI7B5HutSwGpv187tFsnpT8ic4oiUtngYtLJbqBCuyH2R?=
 =?iso-8859-1?Q?b18swABsLQVZG6TQwj34xA6RXwwvA0Alvan4YxyHc2iG97Kg4WoZxhCfu3?=
 =?iso-8859-1?Q?bjYdvjwOwc6MeyY48DbS/bMyYoOOrTfr3T8JbDY+cwpL3cByyyKjganCZd?=
 =?iso-8859-1?Q?sDYyUqWpCmtP/sGVtSahbCdraD49lFryBq9gZJxV41ZS9Jkh8o019RaC9H?=
 =?iso-8859-1?Q?UTmqLARAjPyjJ9dPbiRNUC+eAs0gRfL8UJTML7nZAgqw4iwWQDpGl6HcGV?=
 =?iso-8859-1?Q?GTHwosgbZwPTklZevJlBPcLmcsUEmFUMLyGwe8ED4HMD7Jzv4nmoaa2vMm?=
 =?iso-8859-1?Q?WseJlSTI8XI8UU9Pp+VB5+d7uP0kxehFWKVf7Z5XUQ0eAqvjiH6SKrJt5c?=
 =?iso-8859-1?Q?AxYamIjjF1n44Qb1x7XGQT46dEy4oIqTGl3BKIP1n4j3iUg127k8PFBnF3?=
 =?iso-8859-1?Q?2JnTAinLr7DQmrgtBDO5hb55axcIYLRXc7yv+JnFlfGaFe0pxzkDbz+Wsm?=
 =?iso-8859-1?Q?ZZMoTqyC72ZbRhpJQ24e1tcnXx86JxzXJ6z+g1W6f1Wqtdhukm3w7CBxFn?=
 =?iso-8859-1?Q?6s6/vyTsClU6OcQN6Tn+QdMKJDq/h7dlA0o7FaL8l/moz4iqz8RiBUO8iV?=
 =?iso-8859-1?Q?mfq29XqKAvKiwFrgfHMguCMGEHHyX7SufUPbLP77nwTlynnhq5rzHw91Zg?=
 =?iso-8859-1?Q?oVt02THGbZ+1lHN8DC1MbFSwVbHthP4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TUPtmM/l2wbrHCVYuNNA63JWOxQobipamKo8rtTpnDi2L2ZVFJhYm3E6ESl9d3ySCW8aiQkAXPEEG+mpUTEwluWapBYPSMCgnEGXmPsKuU3uq2ZlVUR04RiWxkNcjGk2qNvcz3aRw5CmZlrXk6nbZhYlxAZTtmfsYvYR7V/nJr42ERzlg6WT8+EWFj4OCZhQbpR/XVGZIoO92+Qq+P0aFdu/NF3sDKF/pzYPbP87aV5/mt3I8OJxNmQRHXJo2HMr+0vKAvRAPUbCuAbZpP5lf8s8NQauoKg365pQZixaemrq7RxlGijkDn5H89907NzOPLMGYz1vBmlHAWBhLnsjPw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cab5522-2860-45ac-97d2-08df100fb110
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:29.0560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBq+fnKvUIvk8bj3bUI5G10P9I5JAFDz9TNptvIb6U+Gvqq+SfnbVedRuwNCaWqfhwJhhZsqUCrF/zah38pN5FzPavOcm1EU0yUl9RXuCSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX7HG9ixDybIQp
 LK+rFGxhnUVuo2yeQXZ3Qu+WaMXIuzvXKzyLv5RECFB0ZN3PGceVx1+p4YZ/E7vE+5Puit75Q+B
 I+nDRTFgIyKksWZLxlditLpn0kDc9s9Ahu2phlMrxRAJwhkjlYj7Q0P14AyNra/qf9ZB7xj++r2
 8Fe5n8o8LNHk332MjTi+PU465qs7E7FvEciPQ66YJy/fNgUFohzR8gzOZXAeD7dmbVSWaqewy/j
 0IRIdZAJyz5oPX4rWlQFyz2E8XQcqaLI7/37GxON++as2GACTIKhQJdu3+P0J5GfBsmAA9GXZEM
 og5APg1jDgwp1eI0U4t4HZVXQeLbEHyAJKXQktaOf3yDPDlJDF6DmCmyEu/inHULAkhMb4AGpxs
 PvB3PVcjSQn6UVA1+dm3xJExoPnlmoJYXXS3WnDn3JIrqKV8t+PgRFyzbzky/uSlpr1OYNxJLdb
 0HzWl8UBdSmSOnDLpIA==
X-Authority-Analysis: v=2.4 cv=H5hOUOYi c=1 sm=1 tr=0 ts=6aa40df2 cx=c_pps
 a=kBs6TrnBGiNV6zZMgQ8KSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=64Cc0HZtAAAA:8
 a=ECQVcO8gvnFX2F7KducA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 9yeEQhirKK9AwwntJYWOVzQzaxRCfHtO
X-Proofpoint-GUID: 9yeEQhirKK9AwwntJYWOVzQzaxRCfHtO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX5JvjXkrxPw6M
 aW7ExUSu9BtTp/dCIiDh0ahx6Si824K8KOONgkTlDXiVrshOKu4Uc3cacJwH4sl2ZNGmr4ZjF1s
 +Y6/YZ4+vIQ4AnjMKwwUhtf2obV7vIQ=
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

Various subsystems across QEMU issue kernel ioctls directly for=0A=
VFIO_DEVICE_RESET. Add a guarded vfio_device_reset() wrapper and route=0A=
all callers through a new device_reset slot in VFIODeviceIOOps so an=0A=
alternate transport such as vfio-user can supply its own implementation.=0A=
=0A=
Implement the kernel backend as a thin wrapper around the existing=0A=
ioctl() call. This is a pure preparatory refactor: the kernel path is=0A=
unchanged.=0A=
=0A=
Co-authored-by: Rafael Castillo <rafael@trfs.me>=0A=
Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>=0A=
---=0A=
 hw/vfio/ap.c                  |  4 ++--=0A=
 hw/vfio/ccw.c                 |  2 +-=0A=
 hw/vfio/device.c              | 20 +++++++++++++++++++-=0A=
 hw/vfio/migration.c           |  7 ++++---=0A=
 hw/vfio/pci.c                 |  4 ++--=0A=
 include/hw/vfio/vfio-device.h | 12 ++++++++++++=0A=
 6 files changed, 40 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c=0A=
index 6e2a1223ea..52d67a01ee 100644=0A=
--- a/hw/vfio/ap.c=0A=
+++ b/hw/vfio/ap.c=0A=
@@ -288,10 +288,10 @@ static void vfio_ap_reset(DeviceState *dev)=0A=
     int ret;=0A=
     VFIOAPDevice *vapdev =3D VFIO_AP_DEVICE(dev);=0A=
 =0A=
-    ret =3D ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);=0A=
+    ret =3D vfio_device_reset(&vapdev->vdev);=0A=
     if (ret) {=0A=
         error_report("%s: failed to reset %s device: %s", __func__,=0A=
-                     vapdev->vdev.name, strerror(errno));=0A=
+                     vapdev->vdev.name, strerror(-ret));=0A=
     }=0A=
 }=0A=
 =0A=
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c=0A=
index c3dc7c1962..054121b71d 100644=0A=
--- a/hw/vfio/ccw.c=0A=
+++ b/hw/vfio/ccw.c=0A=
@@ -241,7 +241,7 @@ static void vfio_ccw_reset(DeviceState *dev)=0A=
 {=0A=
     VFIOCCWDevice *vcdev =3D VFIO_CCW(dev);=0A=
 =0A=
-    ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);=0A=
+    vfio_device_reset(&vcdev->vdev);=0A=
 }=0A=
 =0A=
 static void vfio_ccw_crw_read(VFIOCCWDevice *vcdev)=0A=
diff --git a/hw/vfio/device.c b/hw/vfio/device.c=0A=
index 4f11959633..b2123a0443 100644=0A=
--- a/hw/vfio/device.c=0A=
+++ b/hw/vfio/device.c=0A=
@@ -568,6 +568,14 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODe=
vice *vbasedev,=0A=
     return false;=0A=
 }=0A=
 =0A=
+int vfio_device_reset(VFIODevice *vbasedev)=0A=
+{=0A=
+    if (!vbasedev->io_ops || !vbasedev->io_ops->device_reset) {=0A=
+        return -EINVAL;=0A=
+    }=0A=
+    return vbasedev->io_ops->device_reset(vbasedev);=0A=
+}=0A=
+=0A=
 int vfio_device_get_feature(VFIODevice *vbasedev,=0A=
                             struct vfio_device_feature *feature)=0A=
 {=0A=
@@ -578,9 +586,18 @@ int vfio_device_get_feature(VFIODevice *vbasedev,=0A=
 }=0A=
 =0A=
 /*=0A=
- * Traditional ioctl() based io=0A=
+ * VFIODeviceIOOps implementation for the kernel VFIO backend.=0A=
  */=0A=
 =0A=
+static int vfio_device_io_device_reset(VFIODevice *vbasedev)=0A=
+{=0A=
+    int ret;=0A=
+=0A=
+    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_RESET);=0A=
+=0A=
+    return ret < 0 ? -errno : ret;=0A=
+}=0A=
+=0A=
 static int vfio_device_io_device_feature(VFIODevice *vbasedev,=0A=
                                          struct vfio_device_feature *featu=
re)=0A=
 {=0A=
@@ -660,6 +677,7 @@ static int vfio_device_io_region_write(VFIODevice *vbas=
edev, uint8_t index,=0A=
 static VFIODeviceIOOps vfio_device_io_ops_ioctl =3D {=0A=
     .capabilities =3D VFIO_IO_CAP_DMA_BUF,=0A=
 =0A=
+    .device_reset =3D vfio_device_io_device_reset,=0A=
     .device_feature =3D vfio_device_io_device_feature,=0A=
     .get_region_info =3D vfio_device_io_get_region_info,=0A=
     .get_irq_info =3D vfio_device_io_get_irq_info,=0A=
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c=0A=
index 6db4c2a216..25acb6dca4 100644=0A=
--- a/hw/vfio/migration.c=0A=
+++ b/hw/vfio/migration.c=0A=
@@ -142,7 +142,7 @@ int vfio_migration_set_state(VFIODevice *vbasedev,=0A=
     struct vfio_device_feature *feature =3D (struct vfio_device_feature *)=
buf;=0A=
     struct vfio_device_feature_mig_state *mig_state =3D=0A=
         (struct vfio_device_feature_mig_state *)feature->data;=0A=
-    int ret;=0A=
+    int ret, reset_ret;=0A=
     g_autofree char *error_prefix =3D=0A=
         g_strdup_printf("%s: Failed setting device state to %s.",=0A=
                         vbasedev->name, mig_state_to_str(new_state));=0A=
@@ -219,9 +219,10 @@ int vfio_migration_set_state(VFIODevice *vbasedev,=0A=
     return 0;=0A=
 =0A=
 reset_device:=0A=
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_RESET)) {=0A=
+    reset_ret =3D vfio_device_reset(vbasedev);=0A=
+    if (reset_ret) {=0A=
         hw_error("%s: Failed resetting device, err: %s", vbasedev->name,=
=0A=
-                 strerror(errno));=0A=
+                 strerror(-reset_ret));=0A=
     }=0A=
 =0A=
     vfio_migration_set_device_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);=
=0A=
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c=0A=
index 428ab2f069..73b4a93fca 100644=0A=
--- a/hw/vfio/pci.c=0A=
+++ b/hw/vfio/pci.c=0A=
@@ -3785,7 +3785,7 @@ static void vfio_pci_reset(DeviceState *dev)=0A=
 =0A=
     if (vdev->vbasedev.reset_works &&=0A=
         (vdev->has_flr || !vdev->has_pm_reset) &&=0A=
-        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {=0A=
+        !vfio_device_reset(&vdev->vbasedev)) {=0A=
         trace_vfio_pci_reset_flr(vdev->vbasedev.name);=0A=
         goto post_reset;=0A=
     }=0A=
@@ -3797,7 +3797,7 @@ static void vfio_pci_reset(DeviceState *dev)=0A=
 =0A=
     /* If nothing else works and the device supports PM reset, use it */=
=0A=
     if (vdev->vbasedev.reset_works && vdev->has_pm_reset &&=0A=
-        !ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)) {=0A=
+        !vfio_device_reset(&vdev->vbasedev)) {=0A=
         trace_vfio_pci_reset_pm(vdev->vbasedev.name);=0A=
         goto post_reset;=0A=
     }=0A=
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h=
=0A=
index 8472420d3f..6dc596c9fc 100644=0A=
--- a/include/hw/vfio/vfio-device.h=0A=
+++ b/include/hw/vfio/vfio-device.h=0A=
@@ -191,6 +191,17 @@ struct VFIODeviceIOOps {=0A=
      */=0A=
     uint64_t capabilities;=0A=
 =0A=
+    /**=0A=
+     * @device_reset=0A=
+     *=0A=
+     * Perform a device reset.=0A=
+     *=0A=
+     * @vdev: #VFIODevice to use=0A=
+     *=0A=
+     * Returns 0 on success or -errno.=0A=
+     */=0A=
+    int (*device_reset)(VFIODevice *vdev);=0A=
+=0A=
     /**=0A=
      * @device_feature=0A=
      *=0A=
@@ -287,6 +298,7 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODev=
ice *vbasedev,=0A=
                                                 uint32_t type, void *caps,=
=0A=
                                                 uint32_t size);=0A=
 =0A=
+int vfio_device_reset(VFIODevice *vbasedev);=0A=
 int vfio_device_get_feature(VFIODevice *vbasedev,=0A=
                             struct vfio_device_feature *feature);=0A=
 =0A=
-- =0A=
2.39.3=0A=
=0A=

