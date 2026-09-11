Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2692C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526p-0006wO-Ny; Fri, 11 Sep 2026 10:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526W-0006jP-9K; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526K-00049V-U7; Fri, 11 Sep 2026 10:19:40 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCh7K2004863; Fri, 11 Sep 2026 07:19:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jbMg9+mfMGyNTrYhy48QqyEvMitoxObC7z0elyEr8
 qo=; b=JCclvhNiuC5JkphwJPcd4KsbChO8fw0zes/Nibe3RVfu1Nazr5g6KsMXJ
 pvCkjKhYqvHzdmphGx4nNcAGooiL3pKALiT10oyKZCRwNq+LKNoWYw9oOTLwVmph
 HFPlRNbNkNl4xZUCeGbOnfpJw88EtOhPlCmJQaO45CZ5uQD3KYmSi/L+PztD2iZP
 ULQhdlqwHUNyzDlYavanTMkJWLInQh/yGDczU9o9gjkCMc0LaVu6gLkAWIGygtRV
 l3g3Sz14oL4mQhUY6io3bNyye7ODsWbWQjSCm54bA8HAKTu6ynD+Vgorfr0CaIcu
 e9GGltvh0BucAxgor3yLzv4sLxI5A==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020087.outbound.protection.outlook.com
 [52.101.193.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkd0157rs-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7mnY/3/QAL8xQ7ECQqf+o+ZA+JuW4PLCUdI/EoXq3Upr8SKx8RmTjDyucEcj23jsnh+nVo9pKZYFuEXVBMPjDXeVSLYaPkSOVTQQYenR+TsnVB1oQ3vhrmo9kqovg3D/HtKDxgFNpQl4PrSaZQE9WhPQQVQ6VwmyAFNReVo+LDK7oQ9cgzapHZ21V7ElOTZYc0zkBowLziN39rlpIGWzC3FKr0lvNqK1ECDPZCOh29ByUy4E+d4z1XDsJ7gmTs7aWg0PCr91KgvpA43p5hGqcXyGnjNjLk8xU6C6JJ7Ib7DYABPnVCtldSxGJ0hkUYnhVA3d3GNXM/bWJgKu0uBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbMg9+mfMGyNTrYhy48QqyEvMitoxObC7z0elyEr8qo=;
 b=AEwFN9FSlL4PQDMdyAqbMcUjBc/32qvPOoGkDShIMb13A70uNfoHVuOM/sOv43YDfmfSbX2aU2m2XtJladm6nDzTvXmqF3khzZGHk2haU7D5vzzDKlb3tqnbuCFz3gPp6F+heHaSDg2BS4wb9T9AGblEnlkvFKFG8qGVFpfwiG+VvyeLdnJXC+hQeUbB4EA4HUbWbSXueCyWvOGYG7Vd0XqqoSyeVazCt5GWlHBeuxFvud2QHejPdxLACJkT/fMQmmz1X99CjnU+RMjsebUW6b4VyEt+HNFUosPIZ3MgUhKIOQoN/AjtdzzuHS0B4OVFGK/NpKFLlCsSt+KOz8qLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbMg9+mfMGyNTrYhy48QqyEvMitoxObC7z0elyEr8qo=;
 b=aGpXPNz+jyo/HybVShACmpw+zFLSRIBKh7cJPTtt9VvQB3MAbM0d2FO3IKbbI2Kny3+j3PIoy+ox0WcDwJoyriTSZIv4L/ucjssVQ7y/qsfMf2xdy3dlNqp4EPG+2nb1WZ924EI1V0RPV2s4OsNEyMjH4n3n0zHToGC14SYAzKHVbT0SYgl1G1sa0PnN1BkoFACgEgBuo/kZjCWp1JukNo0k2eX+JGkYaPxtmYWT8oPAifjPsa3YZS/V3o56zdXvxNQnqdnLGfqyMt04lCb0npfzpNpinFevZ9huVqPlDkm6AWdwdoT0Uso+Sez4coDQHLyLHyl1WbFMQaOVRn9gTw==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:25 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:24 +0000
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
Subject: [PATCH v2 1/8] vfio-user: add live migration to vfio-user protocol
 specification
Thread-Topic: [PATCH v2 1/8] vfio-user: add live migration to vfio-user
 protocol specification
Thread-Index: AQHdQfiL/Y4Kz4asc0yhxJe8cqu/8g==
Date: Fri, 11 Sep 2026 14:19:24 +0000
Message-ID: <20260911140710.2348139-2-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: 60503bf5-55ce-4797-f014-08df100fae0a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|6133799003|3023799007|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: JWxZ7EW7NvO2NWutmrcCmgBcMnjY4DxVe2/7aQku3gybVBHVyndvBn9bJEBET+8g7YfRq67jE2ImjINbn+U0guEMaUL6ZqnQZl2byrfMaBGJLSma6SU8yRjdkBbd755EEL+lSR46rnE28ggUr7VQYYPoG9gbydVbShJB3gt6xK/aztGI63qn1LmKpVAjxtcIzFPNgIEpivWYL/eXCTbxcaTOW1vzx1EcsNY1ILr9jfg2L6+KrW9TPZw8FvrZDQ5EhUby3ZpYcx1GPujx5d0tFL8sQMR9ypIGNDByE6NzNpaGmEPVhNjPlG4/1cYk4lZZDtGTHPpCljiVScuRbMnMcp5z/PwhIh5BNwlf2whTi+OZSNcFH+ySy/E2weOhzyLlSswZZ0Al/iVHvO75AqfplgwzcW+5yhjiz5PLP7wOmc5Avbsq0uRHtNkSIWqOV99pg6vo5k+UqT4xnpq/MYe0uyeuq5R2k11c+axDb+X81nkYnzySbiDWbSSXdV3/42gAe/LWD/RRYVObhOMna8muapGSF6thtHb51VIkWhC2ZMDrHHFkT8Lk+n80P855IOL4E2annA1ghFhVTzdQ+ra6lXK69FzmAfQdJARsTk/i24FXTh/nniLiz9zGJ9SrYwdUmCyXkZIv8BsmsLAuFQfjBupV4ThXHayWt64qfzV9qcqO6wKnHVryi7qLl/SdDK2itCvvfOweT7y5at3pAYRmWibY9OUsxzrAcY7mt+Q63ns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yaCBPMVSJOp+a6himCmOzl9UWnFPRzjF1u2ZEmquD4JhnetpPio/HiBPIn?=
 =?iso-8859-1?Q?7FHPonLmO3Bgq0ALP0QDbzsyFqyXmQWAsb8fL7ltJ6J0eHE+IeAqngeDik?=
 =?iso-8859-1?Q?7bsDfruDjoC8SEbyhyYy8SP0bepBCcP0xoahT2mKBK01EVjg+0K2o+2cNO?=
 =?iso-8859-1?Q?xzZewLRNteVwft1YiSF7Xg94LWnQqWRz/S2yl8sueAnGlERI5/v/ZXZb8h?=
 =?iso-8859-1?Q?rlaqQBsEeJzdzvEgeqEqQpQ4F54pDODl2SVgSo3YfiZuJ/nhkbt8fxveeV?=
 =?iso-8859-1?Q?QZSXrwViXKtAdUw4UvYfjxiby9gjzVClqvGRMmsLOh63EuhAO1ul09osBF?=
 =?iso-8859-1?Q?wdANrwTxAEtnugkhf3wvznO/9S2fNmreaXEFzadHjrGBEjVQnUPiJ79wZs?=
 =?iso-8859-1?Q?qh0DMVJpYO77IFWyEROrUUWquVMexmxBoPLVD+UDvn19WWq17hHMJF7x91?=
 =?iso-8859-1?Q?hW+7rzvN2sRGEZLHe9L5bVf3J9slJn9j6fiR0u/hJVv5HAECGswJUVu8dp?=
 =?iso-8859-1?Q?1tKGmlLUGhDQdG3t/HbuMyVIBYldPplPENDMMACBORFrE5HeB6RNscDLth?=
 =?iso-8859-1?Q?8JEAJ5c4G2HdjA31PgpCYlYWHIejeyovkSRtXfV8gqAIQZsnjg2RgQ7O18?=
 =?iso-8859-1?Q?8bpYH3CSZsaxcszNy2C+6mPE1inkx35NLH5Jlepj6Vp37noDSOfdrCmuq2?=
 =?iso-8859-1?Q?Kl+cDHtRYw6sHbKL+j4bDwA7XUh+sx6sMFFNwzZIZCgbbJmyoysxgceaZr?=
 =?iso-8859-1?Q?EllTOsFqka565fmesOZ91rvRunn4C6M1RYNU2bh8OkvFtgwNOzRNi2nYjI?=
 =?iso-8859-1?Q?cxFS/dMHzi4j47um8dgBfpwwikJWcctPM8ue+SjKuGKddsYqFQiOaHPlGE?=
 =?iso-8859-1?Q?I320V30z5Ue5on+1cLmNhuy/SNAMK3dZ3F7TLE5K0X+QpNl+T1VbvEIvYw?=
 =?iso-8859-1?Q?yZ0NxDuWqOFMBeWa9VcM2qVA5JY0s3rgV87F9kRtJpl+qQCVJkN8lw+UEh?=
 =?iso-8859-1?Q?GoZfaYAjXpYvOZ+vcLhkwdHlUuygNf7rX3rtQFEHPD1IBk2MbPzhMSpncE?=
 =?iso-8859-1?Q?Lnk9Tra+7AcQ5QfH19dk7R9iYrKjkHgbEybTfU3dqp/b+GgoAYoMR2TkZl?=
 =?iso-8859-1?Q?PzyIAPIqBwXTyd53EM6CaBgKCbIVWkloXsNumjCxUFBhRwn/ObJV6GeaIU?=
 =?iso-8859-1?Q?O92l2o0iNWSwbV7oqIk8EtGsFv5WFP4OSdlsDo9GKVtBib3b9uItKSz9Gs?=
 =?iso-8859-1?Q?TJPBUPehZKAEzVdsf84WfaIT8ChCIaLoS3vd4UiRCBzVrzRGYaEFCbIlM1?=
 =?iso-8859-1?Q?EFRIcPVVd2IaQb21PvBwCc57WnWseGmDu+Ck/moumjXmWkCKi9fjaLixjF?=
 =?iso-8859-1?Q?CZtsXF/XU7Wmbz9dlXuOx0Lb5lO9WFpg8hd3OZHEnb8ERfl6jDFVXDE/pz?=
 =?iso-8859-1?Q?pmuWbi/rzSTuvhvenu5hQ91jdgDPaqG39zzugMR7VJg8zCkFd0aaCcXF7G?=
 =?iso-8859-1?Q?GeNrdWe/Rn0TE4iGJrLJMg7+5/LXDdPXIrVEm7rGPnWH2q5E6IbiFwwQpT?=
 =?iso-8859-1?Q?JesAw5HjnHmbHsSTRaGRWQSxawMJIihdzk+pBgjboacUFvKtQ7LZm2bQ34?=
 =?iso-8859-1?Q?CBm5/iNKFTZ+JT6nauGXyZunjVnZ0M2+eEemvg+b5NrxrjrlmYi/+PWWY5?=
 =?iso-8859-1?Q?kJ7NIoLfen3CncN3p0WMoUe3PgCmO3aV84W2ujsc6ennuezEzCPqinjWIt?=
 =?iso-8859-1?Q?9pwy79Z/6ui8vIKtbyTh3msJD6OHO+8Z5a1mPX29r20BfqR8mgGwK2iBe7?=
 =?iso-8859-1?Q?A0gZSjajLZhkV8z9IMX8RZd8yHZYEhU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gOnFQ6r/oo/wfY/ZVqVDz9SSLDWkd404ZlaAA5dprU5apLW5oKan2LLtsSN4oMfiCoLs7vbaFYe58wMcCw9GKqAndHGKN9Nq5SY/QBq95ySIzKv0dYyEOVBtiDjqBnOBB9pAaco2KdrmgbhOEGn+/zvaSr6CIeYitOFB/Bqk6A7NbW2QH8Bg6bLZgxpGRdK4FMfVp1Ytv44PHQ5MoIkjowoevD1Vc+/zlfOamw3JynbKAhBz727zH04j+VFXjcnOo38UroSKzhjrDmreViXDx2YpI1og3Dire6mwicDpDNkIQFPJgqkk51K/d3bTvjEhRH80WpqkFi4YcAhVee1n8g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60503bf5-55ce-4797-f014-08df100fae0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:24.0297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usnbRd30hNk+w9uaQi98whNU2goch7moxDN/YaAIdQ+rY3/KXrES3yJC1DG6xeRM90rsK6g7a60c+1UXEdXRX8AF1scqnPbQiDq8ASBaphs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX9fGTLJ2/AyIt
 D8Vi8f0a+xNtQ/6pXrsDhuyh3wXIwFHGiBDaqio7tn3p/WMgISnryg7OFqXJHzOP/at5MgWQutV
 hj2tk9u/NvQ0gJuQcflIMFZ22f167WYza78uyMAIkNdqrjagxFn6SO8EQ+APZpBx1DgFhonHpnT
 bMv3n9haej2fNLolt4bis5LbQkIHasq5TGuL7uP9/R0kQ6iqP8bBz0Ui8KdOLI57+PV3sIn73RL
 sUvU5bnjRqCzONX84Uf/Rj8zLJxA1QFUpFJmjtU9kQql4ec3B5yNbuZHUa3NMb8uCQlQP0jvkaQ
 R4TzvkreO2rfiL6xj7iMbvT7b0lt4JRDsjJEsH4cd/eYYjZfxvJxnc+Rm8dgrwuTnhSuhq8HML6
 J9UXfkIDyB78x2Pgtjh/NtVUpIT8NVQhmSTU/ummcQApwqilQkW4Cf/QaGhAZL7hiwZtUQ2znp9
 DAF1aj9MMlMAPG4fp9w==
X-Authority-Analysis: v=2.4 cv=H5hOUOYi c=1 sm=1 tr=0 ts=6aa40df0 cx=c_pps
 a=kBs6TrnBGiNV6zZMgQ8KSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=64Cc0HZtAAAA:8 a=Q4nSUP2Q8riKaZGk9DwA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: jq0nuPH18Y4rVvssQwtIZ7eJ6Bzh-IU8
X-Proofpoint-GUID: jq0nuPH18Y4rVvssQwtIZ7eJ6Bzh-IU8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfX4+zqiBB9nqwX
 EPtmWEfJYAMejfeWNX7x9ueZKcrYqec2boIcH8pvcbiIAnvccsU6v3fwm57FxEjrHsgWyRblZXG
 Wf9KTh+LQWLe0JpEvtOjt5aMXiDe484=
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

From: William Henderson <william.henderson@nutanix.com>=0A=
=0A=
This patch adds live migration to the vfio-user specification, based=0A=
on the new VFIO migration interface introduced in the kernel here:=0A=
https://lore.kernel.org/all/20220224142024.147653-10-yishaih@nvidia.com/=0A=
=0A=
We differ from the VFIO protocol in that, while VFIO transfers=0A=
migration data using a file descriptor, we simply use the already=0A=
established vfio-user socket with three additional commands:=0A=
VFIO_USER_MIG_DATA_READ, VFIO_USER_MIG_DATA_WRITE, and=0A=
VFIO_USER_GET_PRECOPY_INFO, which have stream semantics. We also=0A=
don't use P2P states as we don't yet have a use-case for them,=0A=
although this may change in the future.=0A=
=0A=
Signed-off-by: William Henderson <william.henderson@nutanix.com>=0A=
Reviewed-by: John Levon <john.levon@nutanix.com>=0A=
---=0A=
 docs/interop/vfio-user.rst | 120 ++++++++++++++++++++++---------------=0A=
 1 file changed, 73 insertions(+), 47 deletions(-)=0A=
=0A=
diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst=0A=
index 1c92f442d2..73282cd2dd 100644=0A=
--- a/docs/interop/vfio-user.rst=0A=
+++ b/docs/interop/vfio-user.rst=0A=
@@ -387,6 +387,7 @@ Name                                    Command    Requ=
est Direction=0A=
 ``VFIO_USER_DEVICE_FEATURE``            16         client -> server=0A=
 ``VFIO_USER_MIG_DATA_READ``             17         client -> server=0A=
 ``VFIO_USER_MIG_DATA_WRITE``            18         client -> server=0A=
+``VFIO_USER_GET_PRECOPY_INFO``          19         client -> server=0A=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 =0A=
 Header=0A=
@@ -1588,26 +1589,22 @@ The request payload for this message is a structure=
 of the following format.=0A=
 +-------+--------+--------------------------------+=0A=
 =0A=
 * *argsz* is the maximum size of the reply payload.=0A=
-=0A=
 * *flags* defines the action to be performed by the server and upon which=
=0A=
   feature:=0A=
 =0A=
   * The feature index consists of the least significant 16 bits of the fla=
gs=0A=
     field, and can be accessed using the ``VFIO_DEVICE_FEATURE_MASK`` bit =
mask.=0A=
-=0A=
   * ``VFIO_DEVICE_FEATURE_GET`` instructs the server to get the data for t=
he=0A=
     given feature.=0A=
-=0A=
   * ``VFIO_DEVICE_FEATURE_SET`` instructs the server to set the feature da=
ta to=0A=
-    that given in the ``data`` field of the payload.=0A=
-=0A=
+    that given in the data field of the payload.=0A=
   * ``VFIO_DEVICE_FEATURE_PROBE`` instructs the server to probe for featur=
e=0A=
     support. If ``VFIO_DEVICE_FEATURE_GET`` and/or ``VFIO_DEVICE_FEATURE_S=
ET``=0A=
     are also set, the probe will only return success if all of the indicat=
ed=0A=
     methods are supported.=0A=
 =0A=
-  ``VFIO_DEVICE_FEATURE_GET`` and ``VFIO_DEVICE_FEATURE_SET`` are mutually=
=0A=
-  exclusive, except for use with ``VFIO_DEVICE_FEATURE_PROBE``.=0A=
+``VFIO_DEVICE_FEATURE_GET`` and ``VFIO_DEVICE_FEATURE_SET`` are mutually=
=0A=
+exclusive, except for use with ``VFIO_DEVICE_FEATURE_PROBE``.=0A=
 =0A=
 * *data* is specific to the particular feature. It is not used for probing=
.=0A=
 =0A=
@@ -1729,25 +1726,19 @@ server, a subset of those defined in ``<linux/vfio.=
h>``=0A=
 =0A=
 * ``RUNNING -> STOP``, ``STOP_COPY -> STOP``: Stop the operation of the de=
vice.=0A=
   The ``STOP_COPY`` arc terminates the data transfer session.=0A=
-=0A=
 * ``RESUMING -> STOP``: Terminate the data transfer session. Complete proc=
essing=0A=
   of the migration data. Stop the operation of the device. If the delivere=
d data=0A=
   is found to be incomplete, inconsistent, or otherwise invalid, fail the=
=0A=
   ``SET`` command and optionally transition to the ``ERROR`` state.=0A=
-=0A=
 * ``PRE_COPY -> RUNNING``: Terminate the data transfer session. The device=
 is=0A=
   now fully operational.=0A=
-=0A=
 * ``STOP -> RUNNING``: Start the operation of the device.=0A=
-=0A=
 * ``RUNNING -> PRE_COPY``, ``STOP -> STOP_COPY``: Begin the process of sav=
ing=0A=
   the device state. The device operation is unchanged, but data transfer b=
egins.=0A=
   ``PRE_COPY`` and ``STOP_COPY`` are referred to as the "saving group" of=
=0A=
   states.=0A=
-=0A=
 * ``PRE_COPY -> STOP_COPY``: Continue to transfer migration data, but stop=
=0A=
   device operation.=0A=
-=0A=
 * ``STOP -> RESUMING``: Start the process of restoring the device state. T=
he=0A=
   internal device state may be changed to prepare the device to receive th=
e=0A=
   migration data.=0A=
@@ -1771,7 +1762,6 @@ above FSM arcs. As there are multiple paths, the path=
 should be selected based=0A=
 on the following rules:=0A=
 =0A=
 * Select the shortest path.=0A=
-=0A=
 * The path cannot have saving group states as interior arcs, only start/en=
d=0A=
   states.=0A=
 =0A=
@@ -1803,10 +1793,8 @@ The data field of the ``SET`` request is structured =
as follows:=0A=
   If the device cannot do the hinted page size then it's the driver's choi=
ce=0A=
   which page size to pick based on its support. On output the device will =
return=0A=
   the page size it selected.=0A=
-=0A=
 * *num_ranges* is the number of IOVA ranges to monitor. A value of zero=0A=
   indicates that all writes should be logged.=0A=
-=0A=
 * *ranges* is an array of ``vfio_user_device_feature_dma_logging_range``=
=0A=
   entries:=0A=
 =0A=
@@ -1818,8 +1806,8 @@ The data field of the ``SET`` request is structured a=
s follows:=0A=
 | length | 8      | 8    |=0A=
 +--------+--------+------+=0A=
 =0A=
-  * *iova* is the base IO virtual address=0A=
-  * *length* is the length of the range to log=0A=
+* *iova* is the base IO virtual address=0A=
+* *length* is the length of the range to log=0A=
 =0A=
 Upon success, the response data field will be the same as the request, unl=
ess=0A=
 the page size was changed, in which case this will be reflected in the res=
ponse.=0A=
@@ -1844,14 +1832,12 @@ The data field of the request is structured as foll=
ows:=0A=
 +-----------+--------+------+=0A=
 =0A=
 * *iova* is the base IO virtual address=0A=
-=0A=
 * *length* is the length of the range=0A=
-=0A=
 * *page_size* is the unit of granularity of the bitmap, and must be a powe=
r of=0A=
   two. It doesn't have to match the value given to=0A=
   ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` because the driver will format=
 its=0A=
   internal logging to match the reporting page size possibly by replicatin=
g bits=0A=
-  if the internal page size is lower than requested=0A=
+  if the internal page size is lower than requested.=0A=
 =0A=
 The data field of the response is identical, except with the bitmap added =
on=0A=
 the end at offset 24.=0A=
@@ -1861,21 +1847,16 @@ reporting a *page_size* unit of IOVA. The bits outs=
ide of the requested range=0A=
 must be zero.=0A=
 =0A=
 The mapping of IOVA to bits is given by:=0A=
-=0A=
 ``bitmap[(addr - iova)/page_size] & (1ULL << (addr % 64))``=0A=
 =0A=
 ``VFIO_USER_MIG_DATA_READ``=0A=
 ---------------------------=0A=
 =0A=
-This command is used to read data from the source migration server while i=
t is=0A=
-in a saving group state (``PRE_COPY`` or ``STOP_COPY``).=0A=
+This command is used to read data from the device while it is in a=0A=
+saving-related migration state.=0A=
 =0A=
-This command, and ``VFIO_USER_MIG_DATA_WRITE``, are used in place of the=
=0A=
-``data_fd`` file descriptor in ``<linux/vfio.h>``=0A=
-(``struct vfio_device_feature_mig_state``) to enable all data transport to=
 use=0A=
-the single already-established UNIX socket. Hence, the migration data is=
=0A=
-treated like a stream, so the client must continue reading until no more=
=0A=
-migration data remains.=0A=
+This command is analogous to reading from the ``VFIO_MIG_GET_PRECOPY_INFO`=
`=0A=
+data_fd.=0A=
 =0A=
 Request=0A=
 ^^^^^^^=0A=
@@ -1890,9 +1871,8 @@ The request payload for this message is a structure o=
f the following format.=0A=
 | size  | 4      | 4    |=0A=
 +-------+--------+------+=0A=
 =0A=
-* *argsz* is the maximum size of the reply payload.=0A=
-=0A=
-* *size* is the size of the migration data to read.=0A=
+* *argsz* is the size of the above structure.=0A=
+* *size* is the amount of data to read.=0A=
 =0A=
 Reply=0A=
 ^^^^^=0A=
@@ -1909,21 +1889,18 @@ The reply payload for this message is a structure o=
f the following format.=0A=
 | data  | 8      | variable |=0A=
 +-------+--------+----------+=0A=
 =0A=
-* *argsz* is the size of the above structure, including the size of the da=
ta.=0A=
-=0A=
-* *size* indicates the size of returned migration data. If this is less th=
an the=0A=
-  requested size, there is no more migration data to read.=0A=
-=0A=
-* *data* contains the migration data.=0A=
+* *argsz* is the size of the above structure.=0A=
+* *size* is the amount of data read.=0A=
+* *data* is the data read.=0A=
 =0A=
 ``VFIO_USER_MIG_DATA_WRITE``=0A=
 ----------------------------=0A=
 =0A=
-This command is used to write data to the destination migration server whi=
le it=0A=
-is in the ``RESUMING`` state.=0A=
+This command is used to write data to the device while it is in a=0A=
+resuming-related migration state.=0A=
 =0A=
-As above, this replaces the ``data_fd`` file descriptor for transport of=
=0A=
-migration data, and as such, the migration data is treated like a stream.=
=0A=
+This command is analogous to writing to the ``VFIO_MIG_GET_PRECOPY_INFO``=
=0A=
+data_fd.=0A=
 =0A=
 Request=0A=
 ^^^^^^^=0A=
@@ -1940,16 +1917,65 @@ The request payload for this message is a structure=
 of the following format.=0A=
 | data  | 8      | variable |=0A=
 +-------+--------+----------+=0A=
 =0A=
-* *argsz* is the maximum size of the reply payload.=0A=
+* *argsz* is the size of the above structure.=0A=
+* *size* is the amount of data to write.=0A=
+* *data* is the data to write.=0A=
+=0A=
+Reply=0A=
+^^^^^=0A=
 =0A=
-* *size* is the size of the migration data to be written.=0A=
+The reply payload for this message is a structure of the following format.=
=0A=
 =0A=
-* *data* contains the migration data.=0A=
++-------+--------+----------+=0A=
+| Name  | Offset | Size     |=0A=
++=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=0A=
+| argsz | 0      | 4        |=0A=
++-------+--------+----------+=0A=
+| size  | 4      | 4        |=0A=
++-------+--------+----------+=0A=
+=0A=
+* *argsz* is the size of the above structure.=0A=
+* *size* is the amount of data written.=0A=
+=0A=
+``VFIO_USER_GET_PRECOPY_INFO``=0A=
+------------------------------=0A=
+=0A=
+This command is used to query the migration data transfer progress during =
the=0A=
+``PRE_COPY`` state.=0A=
+=0A=
+This command is analogous to the ``VFIO_MIG_GET_PRECOPY_INFO`` ioctl.=0A=
+=0A=
+Request=0A=
+^^^^^^^=0A=
+=0A=
+The request payload for this message is a structure of the following forma=
t.=0A=
+=0A=
++---------------+--------+------+=0A=
+| Name          | Offset | Size |=0A=
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D+=0A=
+| argsz         | 0      | 4    |=0A=
++---------------+--------+------+=0A=
+| flags         | 4      | 4    |=0A=
++---------------+--------+------+=0A=
+| initial_bytes | 8      | 8    |=0A=
++---------------+--------+------+=0A=
+| dirty_bytes   | 16     | 8    |=0A=
++---------------+--------+------+=0A=
+=0A=
+* *argsz* is the size of the above structure.=0A=
+* *flags* is unused.=0A=
+* *initial_bytes* is unused in the request.=0A=
+* *dirty_bytes* is unused in the request.=0A=
 =0A=
 Reply=0A=
 ^^^^^=0A=
 =0A=
-There is no reply payload for this message.=0A=
+The reply payload has the exact same structure as the request payload.=0A=
+=0A=
+* *argsz* is the size of the above structure.=0A=
+* *flags* is unused.=0A=
+* *initial_bytes* contains the amount of initial data available for transf=
er.=0A=
+* *dirty_bytes* contains the amount of dirty data available for transfer.=
=0A=
 =0A=
 Appendices=0A=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
-- =0A=
2.39.3=0A=
=0A=

