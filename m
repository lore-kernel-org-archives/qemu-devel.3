Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC48C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526s-00070G-4T; Fri, 11 Sep 2026 10:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526W-0006jO-9P; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526L-00049a-0w; Fri, 11 Sep 2026 10:19:41 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCh7K5004863; Fri, 11 Sep 2026 07:19:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=B7/oK5SypP4K2LUCITRbeb1EuhtJKTRykLemu+G8b
 DY=; b=255hbVsRbKXhhVc/+NMQG6T0E3t6TPVfGi5a6QF6xryIN6fr8AgCJI+eV
 XxY6FemcJ8H/R+RKPvY17DZllRi8ZpRcBqzFP7XJGIJZyocpzG2g8QOkrlrfSVr1
 dR1/5CFbtRRxc1Lt+WPKK+hj3RaZUO1WWlJNyX/HD4nnIeoEY9tCotUahJlor8QK
 VGtHJs1i7nnFbTVbV+yNGzL0oAJ5+EOVeahmid8XyMNsEVk1UqrysId0Y1460AN5
 GCwOtdIsxeJmQuBILDXWb0QiS/8CvUA5F8mRUuxUst3U+NS+pqn9f05vATnqRJJC
 qXPah4KUeT45EeZKRqwhxNUUQKtzw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020087.outbound.protection.outlook.com
 [52.101.193.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkd0157rs-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCt3Z4/UHl5lbVfzsdR2CNsvSv+cLOlu32RkyLQwtkSKpz99sK3ZM0DhdipJI6DY7dR03XMEZzqimazVArdo2jgtuWHrPxA+PrNz+dtv7XWW9W/UswpjajPbEEpvlpEK4LkZ+expW3uvX8TYOxsMNW6jvRPAYiORLwPJFZWLwsIDjWPulA4+zLCLSEYCs5PCTh6xYv/kUR7dlTg5WcN501Jr1YoMzYbC03tI8AYRDetNJ3WH5CovFN9CV32XsHYEVVjlplkOMmjLtU1tDhbyk+XuDAu6ijK96RItbwW8UXsCVrS9zm3QquHBE90uvMjfKrtlGjXC752aQoNOYlFevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7/oK5SypP4K2LUCITRbeb1EuhtJKTRykLemu+G8bDY=;
 b=hBNjOx//Qt3/J1EZ+cZ/PI1TkgdzsNB5FjQCCi1B16jNxeyjkQLQABiVV1Z98tSGrguMYLiku7QsanZcHwY7FAiFUc7OyTIc6zEUZwCjZs1vmI7KO7mjMkWu+TDP1tDyR7J6t9Q2t2fYAVMYHSDCAZiTmfZI62g9ywDeszRwYQsfJuZZZEBpHZoc046Pw6njtpaWpJym1Xks6TGzTBuxHT6c148hCuOxSQO2wAwxpNZhw2HVZlOQ7qShPb9T5zsnL9VGsY6O1BT+gmXXcKaD/vVt1rdxmnZcxGTPeJSAp33tLR90rksV3KPkctLjFNRGJsqcnppv2amhh7QdcZLq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7/oK5SypP4K2LUCITRbeb1EuhtJKTRykLemu+G8bDY=;
 b=SSsJqxD6xEKaqKtMGOYXc8JpEaOKLTUWCuUlTdDPVXH/6Oqv9RLlPRcy4OpLeVSDReWnldV5CV9PNmpdKEXlKtDww3pG2Wu7YuNnb2qU29sMWTLX2yYuDb9IQanBjSxEvpK3iteq04YmP9tEaay1rSMCDMvJ4Y3HOJCPpNROu0572ivG6WbFPeipO7XAib47E6Idw0mfHNkWRL5hpxDDMITCZkoyUrP2lQyFyXW+oICLTDDfRxyNXdOp/UgRnasRkpxQukXDMKCg4GNwkop+8cu7ZkgPt6HhQxdrmb+yXhMVZ9AXapaTByoV1h6GzR5uXFZ3EJaYg2DOge7zaJTJ8g==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:27 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:27 +0000
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
Subject: [PATCH v2 3/8] vfio: route device_feature through io_ops
Thread-Topic: [PATCH v2 3/8] vfio: route device_feature through io_ops
Thread-Index: AQHdQfiNYDbBgtkelEiha6b1E0hOsQ==
Date: Fri, 11 Sep 2026 14:19:27 +0000
Message-ID: <20260911140710.2348139-4-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: 33a7a50b-9e97-4062-190a-08df100fb014
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: Ig0hH5u7kUVzM50SKqFajp0cQ9ec0rUsRg5+KaoMpTy0phTowCt0oQ56+Qg8QO/duBx1c0JrF9yIyzYxttMirLt/AYrPtGGa+xcAxlTxF7jkW4kWsMLrKTtp3sQBq9R1gosKEV0bQYmez33hE3XHFEtprmRNLdU5TVdRdibro8BO+0ihWeSjwBSfN0qjg9H9OJsW32aU+08OEOl9OIhu8RAA7U3UugkfAYtEHznFhnmB2BhiZ4SLMRY5uatou/DtjlNUpHugMWtq3ABGACI3eVh2skrHOAE3ZMKDW7+5rGVFCNtBKh/w3mlVDbUUv70JmvjoG1chSHgFyX9gsXre3OlhFxCCOHoesOvvAJ9lfoZkWda/7BjDNM+2KSlteazVGyGOEMM825a3d9RmMcdtBwn6Nr0NeQQyWu7gODyGfuwwAhKfaewEMYCnlRedd9XqY3S+SxKUAm4Hcq+6v6u5wKeSEDqjKrfNY325mjGPH9QD5bJXce/aBUwtNdUaekp5pshhg3EOtBUpkNukjReL2uXKBTEVNbPDvZ6PLLKRBD2E7iqqw7t36EaorWElgQqPK94OZ0JEeM6tuc1MtvRULx7aKqYbd5ZvnGcir9oGXl3XdFpXha7syhCsWb1KyeOzAGXXJqulGC7yGwtqRcyO10YZB7HeEpvBodAaeX3pMLBRvTL9OAzWjkFd6jCWySz3w7GL3zJPwqHCGp/fPT0INt2dmmT2lIlY1xLHQ0pr+u8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IpGvHvMYtdml9VeeANpw4UvaA5e9vJr896NIi5/K2bgZyYhdRRG4IZqojK?=
 =?iso-8859-1?Q?JG7W1u8MOTpgezB+mEtnmyVDDWdOMywtYB17s8p+725DNRhL6/SzEYvOFk?=
 =?iso-8859-1?Q?06YsSEK/I7oQsOfegbXXYVFSPtqVNySAbdh9lJ1DKsKHAp8ykDPB7OUZ5y?=
 =?iso-8859-1?Q?5e4j3/TjL2/+6YmFikRBVBXB79ZzQSdCL++mtTNlvHe14Y8djJFDeiT2BB?=
 =?iso-8859-1?Q?RdFG/gwMY6Nzabg6a0mp9qr/ttSDI5T3yhSdW74SG9jJZsapgpFAcuiB8u?=
 =?iso-8859-1?Q?cb0SjGeEgwzXocbj44JLkci8YvmNMO8m8XQBHimwQPmt75lyDlQTKnqS+Q?=
 =?iso-8859-1?Q?PQZqmnvOzO8iyJCO0OSKWjBQ46DzDF9lS6YazhjvFjzhxzKIs1n3ResSf+?=
 =?iso-8859-1?Q?nqwBMNoXkpLvTsSSW/rQFAG4/rugR+pAsBbfum688MKYPsNyn1ZY8DhRlL?=
 =?iso-8859-1?Q?8eIir6gRfmXgIDXj07H4dNtVEEat2LRTrTO2u1/cRu9Zd/0uDK+ObB+HZz?=
 =?iso-8859-1?Q?JTJDKi3ZfXqpqzMqosQHG4gh/4cRiz/gFXp5bPk4za5/aWwtyt9BgWIT+c?=
 =?iso-8859-1?Q?GZxgvNEAuIgkOFRKnReXbtc49dMa5TGitGhUlHysn1dpo1pX3j9C8TV2Ir?=
 =?iso-8859-1?Q?4U1+MNxns3SYWPrZvNU5Kx6AUesL3ZGcoQRtshNJjqlWRnibLPikjFpddO?=
 =?iso-8859-1?Q?XsPlCITZiOXGFrewR9Obg27fNZcO3NDEraDKUYm9x65TWCWLU5Ki2bmG1L?=
 =?iso-8859-1?Q?z7Qr3Os1Oq9s4jJX2lp6n+Ms6Zv/NJ9wZCHD8JS0zpffSMELL+a5d3i6bz?=
 =?iso-8859-1?Q?MtcycvJTEECxjPWAgAl4dS6YofkVbqiNclv/abPrHt7MGgid+jfLIbPWUw?=
 =?iso-8859-1?Q?WTfNHP4L7samS5t2RZwaIEuJe57Oezg3lG9/GiCDxEJHulkVjqSpOZJlzJ?=
 =?iso-8859-1?Q?73C5mHenzOwc1NtS84jFsTuZVliutuAfYxxLcdfphJHbIiuFUh/gDlJNGy?=
 =?iso-8859-1?Q?jZpIugm+EB7Fk+xaTQcpb4vSeZQJzJtOP+ObE3nCjndqzanoWpGe19wBrr?=
 =?iso-8859-1?Q?4d3LAbc0gsh9PniFegrDAJ1UKk3LsVJCm86KcZN2Le5BQmXuJzKfIQ6tGJ?=
 =?iso-8859-1?Q?1z22wGjg0n/k5QhT+Oq6KQDSwTdrwLzQ4QpjKAndIBoVvKmyLJWZzsqzmS?=
 =?iso-8859-1?Q?fQBwOyypuLeia7dTWpgpFaG7W4vJc8rJOU3Bb7v0tfetxk7QPpCPpf8K1y?=
 =?iso-8859-1?Q?fAMh8LZVfgtphLL9owI57VsuH8ojXtStSJrykipjqoONj4iFqnWc3lqUHk?=
 =?iso-8859-1?Q?60wJlhCVcdyIziatiHhgBt2vWTh0ZAsF+XHi+09dZur9PqZda8ghgDih/4?=
 =?iso-8859-1?Q?vUAXrT6KojoZWY0lAjmruQvEMjlg/P9ll9cRqHrRplO7JQ37U3JkWcAnk7?=
 =?iso-8859-1?Q?zkSaJWEc5v8zXrGPYP8ySK7toF2BqGxF7lWA0hrPBAyISZtJPYu6jJ3xap?=
 =?iso-8859-1?Q?fOQAuj8XeNLQ3qvSnTIuJauYP1erWxFnRbhu1LW9DFRn8vkTG8Ed6E4yoI?=
 =?iso-8859-1?Q?kwR2vRJZoMh9XWZy1GT3sV4T53HnWBN3y7AhmqdoCnXZrtSElxQNOZGiDH?=
 =?iso-8859-1?Q?vewiq45X8gaMHjhe8MhRMYWHw/LrrPklj1gQFYH3PjRA3DfUx6+hOB0BIi?=
 =?iso-8859-1?Q?mO5F1hrFZBgYPRg7fBff9BFmdaifSv2ntykV19f62D4ismuJyveTtoWvt9?=
 =?iso-8859-1?Q?Okl6gRteT6r5fKwdglHTFKj8nK5K1fx+5LM0w1Hn+kSbJXtj1lS6ANnJXN?=
 =?iso-8859-1?Q?CQ0rYp5p3c8How3BuAGAwOUbbbsvFdc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iD5QUTpxLxEMgMWOP9Tt2r/KlP3FNhTplr94Ka93lTyjoc2Dse36X5OyKS3DO6oqi/R+OjFpvZIE0YsI1B0zTfkkxfDG+tTEDZRfOxCKj1coa1sRmB8gkTvR9dY6sLfZxTC6I9iGE7VCN5eE+PeGhXeSjdXQUYBdXfTNcj5TQKPO/yvpqVFjWstJsGc+aN67oH+MfwdZG/rTGU9p3t+dvvwKVTFeJsMByZTe6P39DB1IswlSa3sq2TL57BzaMTijmHpG8uTXsWYfzAjAT6YKjT787w4i7AKJBub+O+opCJvRhhoP6O3IPDEVEGdKWPLtf0wYcr10cMxAk1omBh1ixg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a7a50b-9e97-4062-190a-08df100fb014
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:27.4010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1PKX5VfHJz/1wyaiMxTA+tf6VcY1D1bL2DGpAlhADmx1dyMV2grbcq+9L1VYpevHH+hcsYqdtbKExlShD4iraHUouTmz6thSIFpIRmGayM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX16dMWhHSvoIR
 het/LE8xajr80SE8KclBO2gn7y7mOAHHKgWhnNLfw6nPpaDJKlphBWXCzIvmKmY2fS45tNX9HyN
 tVWGwfkT+Qg9WSr41/p6/Sxt8jSprzUY//F87OVGi9FUigzjVMmYZ0T/gyS7/bXRzVrhXq0sQpZ
 KuP6salrvJNZfueQXvY5rD9JD3d54XXykKhMsbtmyLgQ2XniC2Wl68nFot8uhgiwtcW+pMJXoUp
 UfMrtYMgI6b9G1RV9N+mhxUWmF+B9lDduP/9E7ylxxl0GWatiMXlshOS4r1i7JrieSKkWMQSDrm
 l/g+1jUutkdNylooi4f4cEM/kXmmasp3/WzSsCQmlkQ0TAgWBo8SFIs6hATw8KtCqMVJJhjHKk4
 F0Ztzdn0sCYfxu9jdzPlgvgGtgS5nvIoHG9zl77edaNYOiSlQZLOMjKmpmFMGkna3d9ueyKNUeh
 4AtZRWr4zsHz0VPUdXg==
X-Authority-Analysis: v=2.4 cv=H5hOUOYi c=1 sm=1 tr=0 ts=6aa40df2 cx=c_pps
 a=kBs6TrnBGiNV6zZMgQ8KSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=64Cc0HZtAAAA:8
 a=MNwCuWaDSvqgPoS32scA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 3hsBb0S_ZfRpRTP_nG9DWW3Kzq3n0fbt
X-Proofpoint-GUID: 3hsBb0S_ZfRpRTP_nG9DWW3Kzq3n0fbt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX6NlsoIubFza9
 QGqKttddblPyB31e8TrbGbc69YajgJJWCtHZND7WMmUa3AWJDPVRDymRO5H89a2gt8IiTD1Ku5a
 aJJ7T0TzI1mz2zmJ0z531CKW/tIiMOE=
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

The generic VFIO migration code in hw/vfio/migration.c issues kernel=0A=
ioctls directly for VFIO_DEVICE_FEATURE. Route these through the=0A=
existing vfio_device_get_feature() wrapper, which dispatches through=0A=
VFIODeviceIOOps so alternate transports such as vfio-user can supply=0A=
their own implementation.=0A=
=0A=
This is a pure preparatory refactor: the kernel path is unchanged.=0A=
=0A=
Co-authored-by: Rafael Castillo <rafael@trfs.me>=0A=
Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>=0A=
---=0A=
 hw/vfio/migration.c | 29 ++++++++++++++---------------=0A=
 1 file changed, 14 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c=0A=
index 73c49d8c24..6db4c2a216 100644=0A=
--- a/hw/vfio/migration.c=0A=
+++ b/hw/vfio/migration.c=0A=
@@ -168,33 +168,30 @@ int vfio_migration_set_state(VFIODevice *vbasedev,=0A=
     feature->flags =3D=0A=
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;=0A=
     mig_state->device_state =3D new_state;=0A=
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {=0A=
+    ret =3D vfio_device_get_feature(vbasedev, feature);=0A=
+    if (ret) {=0A=
         /* Try to set the device in some good state */=0A=
-        ret =3D -errno;=0A=
-=0A=
         if (recover_state =3D=3D VFIO_DEVICE_STATE_ERROR) {=0A=
-            error_setg_errno(errp, errno,=0A=
+            error_setg_errno(errp, -ret,=0A=
                              "%s Recover state is ERROR. Resetting device"=
,=0A=
                              error_prefix);=0A=
-=0A=
             goto reset_device;=0A=
         }=0A=
 =0A=
-        error_setg_errno(errp, errno,=0A=
+        error_setg_errno(errp, -ret,=0A=
                          "%s Setting device in recover state %s",=0A=
                          error_prefix, mig_state_to_str(recover_state));=
=0A=
 =0A=
         mig_state->device_state =3D recover_state;=0A=
-        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {=0A=
-            ret =3D -errno;=0A=
+        int recover_ret =3D vfio_device_get_feature(vbasedev, feature);=0A=
+        if (recover_ret) {=0A=
             /*=0A=
              * If setting the device in recover state fails, report=0A=
              * the error here and propagate the first error.=0A=
              */=0A=
             error_report(=0A=
                 "%s: Failed setting device in recover state, err: %s. Rese=
tting device",=0A=
-                         vbasedev->name, strerror(errno));=0A=
-=0A=
+                         vbasedev->name, strerror(-recover_ret));=0A=
             goto reset_device;=0A=
         }=0A=
 =0A=
@@ -347,13 +344,13 @@ static int vfio_query_stop_copy_size(VFIODevice *vbas=
edev)=0A=
     feature->flags =3D=0A=
         VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIG_DATA_SIZE;=0A=
 =0A=
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {=0A=
+    ret =3D vfio_device_get_feature(vbasedev, feature);=0A=
+    if (ret) {=0A=
         /*=0A=
          * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZ=
E=0A=
          * is reported so downtime limit won't be violated.=0A=
          */=0A=
         migration->stopcopy_size =3D VFIO_MIG_STOP_COPY_SIZE;=0A=
-        ret =3D -errno;=0A=
         warn_report_once("VFIO device %s ioctl(VFIO_DEVICE_FEATURE) on "=
=0A=
                          "VFIO_DEVICE_FEATURE_MIG_DATA_SIZE failed (%d)",=
=0A=
                          vbasedev->name, ret);=0A=
@@ -1094,11 +1091,13 @@ static int vfio_migration_query_flags(VFIODevice *v=
basedev, uint64_t *mig_flags)=0A=
     struct vfio_device_feature *feature =3D (struct vfio_device_feature *)=
buf;=0A=
     struct vfio_device_feature_migration *mig =3D=0A=
         (struct vfio_device_feature_migration *)feature->data;=0A=
+    int ret;=0A=
 =0A=
     feature->argsz =3D sizeof(buf);=0A=
     feature->flags =3D VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRA=
TION;=0A=
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {=0A=
-        return -errno;=0A=
+    ret =3D vfio_device_get_feature(vbasedev, feature);=0A=
+    if (ret) {=0A=
+        return ret;=0A=
     }=0A=
 =0A=
     *mig_flags =3D mig->flags;=0A=
@@ -1137,7 +1136,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vb=
asedev)=0A=
     feature->flags =3D VFIO_DEVICE_FEATURE_PROBE |=0A=
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_START;=0A=
 =0A=
-    return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);=0A=
+    return !vfio_device_get_feature(vbasedev, feature);=0A=
 }=0A=
 =0A=
 static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)=0A=
-- =0A=
2.39.3=0A=
=0A=

