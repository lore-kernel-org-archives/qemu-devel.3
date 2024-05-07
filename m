Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30571C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 23:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4UQB-0002nC-My; Tue, 07 May 2024 19:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s4UQA-0002mL-Ls
 for qemu-devel@nongnu.org; Tue, 07 May 2024 19:40:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s4UQ8-0005f4-4w
 for qemu-devel@nongnu.org; Tue, 07 May 2024 19:40:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447MAEf6015519;
 Tue, 7 May 2024 23:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=/tlrjyz7L1WU/m0uR+5lkMVKh4nNOtDUTwDEwPgzsis=; b=WQ
 E5xuWbzLPwSa7atb9ZKWw0x2gOSZ/fbFCgBA11sEtJGQ0RA4iDliB2PtGjXbf4Ih
 SyDMftUDVFpelfzptV1znrKdI8sFddiOYbi4lP2JkcMfDNihl0wyBvZhByijTqOr
 hnUdeH7wE3kQMVp9hXgmQgIqQQnO0CY/Jfdmym4gTxmrzkAnCcQGc6USivxQ1w1N
 dZXYXGmjNZhpX749iAcD9eHRIZtd+nGo2wjrx4C3CYW2ibBv5olDNRmBGVpHJCjm
 3cWZEai1V1nof36TkdidZOnXViuZrjubOL2qtEa2KimhY5V+ZfEfpSlJVmutUhdD
 9EVhbJ5wOwADwDU5ZQnQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17013022.outbound.protection.outlook.com [40.93.12.22])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysg4rhkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 23:40:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZEmi6u2uBWrsbbNAIUEc9t9Alcfd2lW0p18SAqIiEKb+oTuMWmyYKBlpdgmRgMDhULaXTzppV9wq6R5Xve9oQoC/XxXPRnit5vq8V2qruEh62FMMllnuIWdmm/DjW5coV3B7YcUXBOpqGuvSeCQ+BYpbicc1/kpgtjo84JL9k3aPmogOMAY4GnkpUDOGWui0CJyoGHZ8PGqZzmhoZKKOf3+pq/4r4wk9EuC1epmYRlnF3V1Qgzc9qhn70WeVqbrZS+DF8dvvhObfQuU1CqBgm1vyTPr/LxZgALjaWEQ/cfrrZt+4P7hnoyeM88tVqSY1W5PCHXQYsMI/6+I3jZwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tlrjyz7L1WU/m0uR+5lkMVKh4nNOtDUTwDEwPgzsis=;
 b=CrBFBjurWA8fxFFhU9GOWHmdGr5jwaaUyV3l4CbRqkJa1APeYdHoliKDGLlN1raRnsc+nQGCX5R30duEU2UcnoQ2i4+zrbXouC4FSbJ1YrCXblsB48rhZdzAA34NHXhfW3QqHQPyJGOJG8/bunYHaUrL5PGFJsa+TFmAIARxlRA+R6tVGpi/hs9hBYLDZVD4C5dRJ5JQ+z0THnUT+9BgdJs3vU4qgNCGzeldf328xrXdWY+4BQb4ZCJ8SOwEbWG7X12VmeX5swK5OmHybFLST1zQ3Do5XTjKXArElnXWh/fmJIRiS8PvVgTSTCrACRu59Ar6DBYHCPD94/kjoA4lbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by LV3PR02MB10212.namprd02.prod.outlook.com
 (2603:10b6:408:20d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 23:40:16 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 23:40:15 +0000
From: Brian Cain <bcain@quicinc.com>
To: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Sid Manning <sidneym@quicinc.com>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>, "ltaylorsimpson@gmail.com"
 <ltaylorsimpson@gmail.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Subject: RE: [PATCH v6] Hexagon: add PC alignment check and exception
Thread-Topic: [PATCH v6] Hexagon: add PC alignment check and exception
Thread-Index: AQHanXps2xr/XlV+40egLC78ab8+R7GMdIwg
Date: Tue, 7 May 2024 23:40:15 +0000
Message-ID: <CH3PR02MB10247B931B48C0CE3D3D031AAB8E42@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <277b7aeda2c717a96d4dde936b3ac77707cb6517.1714755107.git.quic_mathbern@quicinc.com>
In-Reply-To: <277b7aeda2c717a96d4dde936b3ac77707cb6517.1714755107.git.quic_mathbern@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|LV3PR02MB10212:EE_
x-ms-office365-filtering-correlation-id: abad69d4-4089-4384-613d-08dc6eef0be4
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?SEbZN9Uli0cXxpjti8DIKJdJkJDrqrjRHE/5rUkE3Sin1zpj4JX2GnIIuFdf?=
 =?us-ascii?Q?cCXmy8jwbkaaaTXEgzlRzjFqDbtY+OxncZgsO0cvZUBwgIVl0ltkNO7H8XT3?=
 =?us-ascii?Q?dKc9NaJFDRlV/JrGyglKm1AgnpcuZNkUG2EL/TvoEAZRoMRYa5bJJONw3vjE?=
 =?us-ascii?Q?cTvi9PVQs9N2qJ4gK5jXXRa5fNkwHh5iy/zOuPzOu2jTWHoe3OhMSac9QE6R?=
 =?us-ascii?Q?7ws452iunSf7r3n/3uuj822wwuS35qau6rtgcdH4iA6FE6L/jg1dj0aOgKyd?=
 =?us-ascii?Q?Zev9/5Pt3AtahMXMaqXVXVZz14Lrd4xeUKnR3+SvkAqhX/2gQuvawHKTM7f7?=
 =?us-ascii?Q?EMYcqOlZwSum7L5PRdxWDkWL/WxtTL1xfxW+IwtLOFK2xXSsDIxJZNUBMUNI?=
 =?us-ascii?Q?9MFzKpqfycgIqct+lE/k8q5XMHNRYT8qzGisWvETNg+xmuRGKm2zJXJVCwLY?=
 =?us-ascii?Q?X8wUhZ1VFPsxxxGLmhacaMDrsyYrukwzVhxdwLR7KPx0YpAjEiN9FM5VtcaF?=
 =?us-ascii?Q?7bFHcAjqcdai9Mi1Vabix8tqlV/NNrkyRvrB98XdJJBErP9rXyqTGQrxF0Ux?=
 =?us-ascii?Q?d1lT0kH2qWcmF3epw8bW8bk6cgZ6dt8MXvot4mkp7Y7twQ92DQPlni3juL1f?=
 =?us-ascii?Q?ntURBBFmVas6LFuB8i4gXjci0dRtZO8r6Vmktes58ZTPNJmQEuO/NVT20AIa?=
 =?us-ascii?Q?a73MzpWR8ldUXHCQvSx646sOGzJ8K6uTswx0coatrAHTBSBv6ny6T3PhHzow?=
 =?us-ascii?Q?clF0WPUkindGN5rVylyITLshft78wa6fp5yX2lq2d+oGVRRbRluCeKJD1Mu0?=
 =?us-ascii?Q?H5Up3l44IHbPtGAs255D4aCFdotkhuWvNSDhpsvo75lCaUbshYpNE4rKpJ78?=
 =?us-ascii?Q?esVzjQi51TeTnPTj/eHtBGxvIl38+4RnDW9MzR5YPQz7xYV+PTFrwL3VecLN?=
 =?us-ascii?Q?x5bnRrrhzEIUVU1Z76KjwR4J3Po8BcnQarEcaGlW7xJqFb4H7+sWahR2KOv8?=
 =?us-ascii?Q?sgG0Kke5qz3Z7wbCx03PuO9+ybRdWpFzT1pXb/pQYI+k+jIxkshNZDuATewS?=
 =?us-ascii?Q?NX82gf7i7JNxuvtezUyo1cehMmLBtXCLovTPOrAtOresM2uEVdhcN2devYlK?=
 =?us-ascii?Q?AY4po/HJRgOKp73iZI0UDUB8CmBqrf4cTrdE9J8yXSBBe9mPcwPQsEG/5bR0?=
 =?us-ascii?Q?7yr+OshtxjQjL5ZPEUdeG6PHu3ychbJvtfLcsfFuNoAW+9cQAQn/90rUTLnX?=
 =?us-ascii?Q?Wrrr2Xxnq7Pl3X/7k0UFHE+WUhIHauq4XzylgZoTz0JpTna/j6LQxoEqHoti?=
 =?us-ascii?Q?nKJJeEDBHbuVMMnPC634wT7e898M5ax+8xizQ3lGhMLNlQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oK7KhQ7MFH9Yx1q1+jhV1xXQI/BbUXtDAAPcsRXbBIFdTSxikHUDWOBsK0hI?=
 =?us-ascii?Q?XUCAuUvy80Y8RITodvzJRH4pelRkt3o2Fs4z81ASBlwjwZ2dL20QUPVOFsz6?=
 =?us-ascii?Q?qzY9hA5/LTtAMsgFDDcj3AyIop2esTO0Jb0BYq8LLWDhG/s15i6EzDRtbrgY?=
 =?us-ascii?Q?mOAUDpuAE5ys4MMnKfVlocf2Yabd7C7an4fwNODZh2e/0gCtLXhDOXO9B2ci?=
 =?us-ascii?Q?MTzQdl8EnIVm0BZffhvqNoagdkzjcc7w9dkd2wS6Wx2xFa3Kts8HeQYrA9X4?=
 =?us-ascii?Q?onvSwh2CL4Zh1Zn0pSuw1AMuDcvDtOU6wzvpwzIm1xIZs/WDdgtmrnKsqw9K?=
 =?us-ascii?Q?AFDlpSQNL9We4o1IxQmPh60X8XBSZlL0jomRzySxsAwsbpexl5vr+3zZo05R?=
 =?us-ascii?Q?0b+HHZERt9MlZu3NWC2YlGv4gOr1XTPVhR58UYvjPWYB3X2IyHFg1zxCFO0C?=
 =?us-ascii?Q?5opgLRufSOplbukVlf7MwSV+0TNCVuGILSPGheDlu/cpDlGUEpsAvuUMLmTx?=
 =?us-ascii?Q?9hcToZNJh/mQ1YhnCh411V5aOQEzrAzA3Hn4CWf916sJa2KKZNlVJ2A8tJs5?=
 =?us-ascii?Q?o3JeOZMVkoBNmvyRpOUV66T8JE6r3in1of+cpsco3D9S/IJGG5HMq9pDInZa?=
 =?us-ascii?Q?LdOwblJDxkaEsP3Kzr3MrM/g5D/CMNO+iU27e4Lg7ZLJ0Li12bCpP96jOaXq?=
 =?us-ascii?Q?MpbketgTDI2MUoIKXAM6CVvrGlkBzInNoijZS5VsgG+FlGJJVmO4KTAsK7a9?=
 =?us-ascii?Q?I8+tH+N9CXLPbkhxy9gjVFv1hMMgk8/VpJ2md5Ikn4Q4Ap/bX6rUpbZq/jdF?=
 =?us-ascii?Q?ewNemMTnS70OnRtLt5XkonOo3SRf6uxX1MFrwlv6rsVhP4UeKRjHMp85m6Vg?=
 =?us-ascii?Q?P2tbuc2LEDGzqg3zr62aUnY/UmdZUM2QULOD9SQycWRJGISoTNhjV7kPoBq7?=
 =?us-ascii?Q?iyrWLmHwIUt9zguoKtxfMVi5yiiBu7PLu4FLFwNcTknkxZn4/GJDQ6I0f6bk?=
 =?us-ascii?Q?fec3DKC90ONRF+F/9AzQ0NUcLbNgOwhr/9QBzWBHRz/kej6fajgNj+jUXJEG?=
 =?us-ascii?Q?4N4M9JvenWXcGeOZgUeuBQJYwXmPcwEQAz9vTbHUCrIBdRI745NCovG+Uc5v?=
 =?us-ascii?Q?i3WT/qTJsx248Tcx3TWTPp9pDxPbq9QWPbNGsS1e77G9nYIbYlIWUEJdXbyX?=
 =?us-ascii?Q?ZXGbsN8AFogTCB9l9s275XHemCckMm6vK1wpNr8gm/ouLxVhrDY/2ISwJK89?=
 =?us-ascii?Q?eZxPvfsp0+woxWfLFjmkysNtgWlEKKfSKBBXiCiSLyOQPNJHwF4o8Ixe03G1?=
 =?us-ascii?Q?FAgYsEgXZeoMScblnzaOw4+ocCSjMBSDmwxn88YXlckJThjOoNnOhh0VzgRX?=
 =?us-ascii?Q?PvPYSBZ8U1F7xtqcHSJw14VvH5s+5a6K0xlCm+ixuSNDs7poWekCRsYV7bVs?=
 =?us-ascii?Q?gfke8A4FOu5jLoQu8tudooPklM266wP//i4zek6WER4UonZgfcqnwEi1hMwy?=
 =?us-ascii?Q?2bo3bH/JywCXxqyF0tiPj8nGp52yMWHWzbmMGEWN3GfzKw1xIsjfxk4KBYzq?=
 =?us-ascii?Q?swBn2v0PO7BNfA8Uj+s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2tWWlsl2xP4/MJOQm5h4rWD/lFq0xS1ly+3RSJxaip/c6Y8hXoWonRU2hBMbx7Y7ucOV5cFMp5jKqQsZcTWYEIvtAHWhp3Xhr16spfM7MixgsAhU+xNkuOlr/vL9uwIiOaEMXTM+JdLjcTqnAXXuDqXN1++9qxOt+b4iFiI5trNJ3pyoUZK2GbnN0w7wR/SOgF7A/aVvNGWEB/7rrtOVndD5GCLT0V6NJhXxEVHs43FIQJUduEj7th1Czr3oGf5ghCm4ENFtHuE2ypJevR+KlU/KSvUUWDRRtDhgW9dDoldHkoAkOzoo6wmzUbmzygZwQiA+2je0XIqUHE3EmubSH/PLwjtS3ecPRsrzf0TVHK7vXkbB2n4f/039qGSG7fTcP7leeCfaNThSzkxkkW0llSH6IrtjEL5hVc7uE5XWCRWNmpv+FaVLmaMwVJpvM05CWH8dtwHVGSZvIkMge8MnZE96pKHZxHcznXxNHELhGQkSvbi3ciUP7e0QV5KT4+d9OHJ9zDft6x40UBPWn8rbZA8dNMpujq8IOxg6/l7dzDDdmWx5Q9nsDdRDDzG8SgebV6eSfxdFA7mxlFULkVlSWm9/Etm294ukAEtSvZ0RhH+bec6nrpCBHdXSCw6nqs9Q
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abad69d4-4089-4384-613d-08dc6eef0be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 23:40:15.5136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lU8esqXpiDduAnorNwNy6LielNKkUBUrS+/01MIf//oH4Jc+c8gS6/j/EcQ48ytXG4Q3HAbbbGURClu/lL9Y3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10212
X-Proofpoint-GUID: eZXB7NRY9HJQLmGorbvBEv2ucjDJS9a-
X-Proofpoint-ORIG-GUID: eZXB7NRY9HJQLmGorbvBEv2ucjDJS9a-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405070167
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>
> Sent: Friday, May 3, 2024 11:53 AM
> To: qemu-devel@nongnu.org
> Cc: Brian Cain <bcain@quicinc.com>; Sid Manning <sidneym@quicinc.com>;
> ale@rev.ng; anjo@rev.ng; ltaylorsimpson@gmail.com;
> richard.henderson@linaro.org; Laurent Vivier <laurent@vivier.eu>
> Subject: [PATCH v6] Hexagon: add PC alignment check and exception
>=20
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add some tests.
>=20
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
> Changes in v6:
> - The multi COF test defines a new section for the unaligned label to
>   make it more robust.
> - Instead of a nop in the undesired test branch, we use a trap for
>   SYS_EXIT
>=20

Reviewed-by: Brian Cain <bcain@quicinc.com>

>  target/hexagon/cpu.h              |   7 ++
>  target/hexagon/cpu_bits.h         |   4 ++
>  target/hexagon/macros.h           |   3 -
>  linux-user/hexagon/cpu_loop.c     |   4 ++
>  target/hexagon/op_helper.c        |   9 ++-
>  tests/tcg/hexagon/unaligned_pc.c  | 107 ++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target |   2 +
>  7 files changed, 128 insertions(+), 8 deletions(-)
>  create mode 100644 tests/tcg/hexagon/unaligned_pc.c
>=20
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 3eef58fe8f..764f3c38cc 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -134,6 +134,10 @@ struct ArchCPU {
>=20
>  FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
>=20
> +G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
> +                                            uint32_t exception,
> +                                            uintptr_t pc);
> +
>  static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> @@ -144,6 +148,9 @@ static inline void
> cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>          hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>      }
>      *flags =3D hex_flags;
> +    if (*pc & PCALIGN_MASK) {
> +        hexagon_raise_exception_err(env, HEX_EXCP_PC_NOT_ALIGNED, 0);
> +    }
>  }
>=20
>  typedef HexagonCPU ArchCPU;
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index 96fef71729..4279281a71 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -20,9 +20,13 @@
>=20
>  #include "qemu/bitops.h"
>=20
> +#define PCALIGN 4
> +#define PCALIGN_MASK (PCALIGN - 1)
> +
>  #define HEX_EXCP_FETCH_NO_UPAGE  0x012
>  #define HEX_EXCP_INVALID_PACKET  0x015
>  #define HEX_EXCP_INVALID_OPCODE  0x015
> +#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
>  #define HEX_EXCP_PRIV_NO_UREAD   0x024
>  #define HEX_EXCP_PRIV_NO_UWRITE  0x025
>=20
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 1376d6ccc1..f375471a98 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -22,9 +22,6 @@
>  #include "hex_regs.h"
>  #include "reg_fields.h"
>=20
> -#define PCALIGN 4
> -#define PCALIGN_MASK (PCALIGN - 1)
> -
>  #define GET_FIELD(FIELD, REGIN) \
>      fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
>                     reg_field_info[FIELD].offset)
> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.=
c
> index 7f1499ed28..d41159e52a 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -60,6 +60,10 @@ void cpu_loop(CPUHexagonState *env)
>                  env->gpr[0] =3D ret;
>              }
>              break;
> +        case HEX_EXCP_PC_NOT_ALIGNED:
> +            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
> +                            env->gpr[HEX_REG_R31]);
> +            break;
>          case EXCP_ATOMIC:
>              cpu_exec_step_atomic(cs);
>              break;
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index da10ac5847..ae5a605513 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -36,10 +36,9 @@
>  #define SF_MANTBITS    23
>=20
>  /* Exceptions processing helpers */
> -static G_NORETURN
> -void do_raise_exception_err(CPUHexagonState *env,
> -                            uint32_t exception,
> -                            uintptr_t pc)
> +G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
> +                                            uint32_t exception,
> +                                            uintptr_t pc)
>  {
>      CPUState *cs =3D env_cpu(env);
>      qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
> @@ -49,7 +48,7 @@ void do_raise_exception_err(CPUHexagonState *env,
>=20
>  G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t
> excp)
>  {
> -    do_raise_exception_err(env, excp, 0);
> +    hexagon_raise_exception_err(env, excp, 0);
>  }
>=20
>  void log_store32(CPUHexagonState *env, target_ulong addr,
> diff --git a/tests/tcg/hexagon/unaligned_pc.c
> b/tests/tcg/hexagon/unaligned_pc.c
> new file mode 100644
> index 0000000000..e9dc7cb8b5
> --- /dev/null
> +++ b/tests/tcg/hexagon/unaligned_pc.c
> @@ -0,0 +1,107 @@
> +#include <stdio.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <stdlib.h>
> +
> +/* will be changed in signal handler */
> +volatile sig_atomic_t completed_tests;
> +static jmp_buf after_test;
> +static int nr_tests;
> +
> +void __attribute__((naked)) test_return(void)
> +{
> +    asm volatile(
> +        "allocframe(#0x8)\n"
> +        "r0 =3D #0xffffffff\n"
> +        "framekey =3D r0\n"
> +        "dealloc_return\n"
> +        :
> +        :
> +        : "r0", "r29", "r30", "r31", "framekey");
> +}
> +
> +void test_endloop(void)
> +{
> +    asm volatile(
> +        "loop0(1f, #2)\n"
> +        "1: r0 =3D #0x3\n"
> +        "sa0 =3D r0\n"
> +        "{ nop }:endloop0\n"
> +        :
> +        :
> +        : "r0", "sa0", "lc0", "usr");
> +}
> +
> +asm(
> +    ".pushsection .text.unaligned\n"
> +    ".org 0x3\n"
> +    ".global test_multi_cof_unaligned\n"
> +    "test_multi_cof_unaligned:\n"
> +    "   jumpr r31\n"
> +    ".popsection\n"
> +);
> +
> +#define SYS_EXIT 94
> +
> +void test_multi_cof(void)
> +{
> +    asm volatile(
> +        "p0 =3D cmp.eq(r0, r0)\n"
> +        "{\n"
> +        "    if (p0) jump test_multi_cof_unaligned\n"
> +        "    if (!p0) jump 1f\n"
> +        "}\n"
> +        "1:"
> +        "  r0 =3D #1\n"
> +        "  r6 =3D #%0\n"
> +        "  trap0(#1)\n"
> +        :
> +        : "i"(SYS_EXIT)
> +        : "p0", "r0", "r6");
> +}
> +
> +void sigbus_handler(int signum)
> +{
> +    /* retore framekey after test_return */
> +    asm volatile(
> +        "r0 =3D #0\n"
> +        "framekey =3D r0\n"
> +        :
> +        :
> +        : "r0", "framekey");
> +    printf("Test %d complete\n", completed_tests);
> +    completed_tests++;
> +    siglongjmp(after_test, 1);
> +}
> +
> +void test_done(void)
> +{
> +    int err =3D (completed_tests !=3D nr_tests);
> +    puts(err ? "FAIL" : "PASS");
> +    exit(err);
> +}
> +
> +typedef void (*test_fn)(void);
> +
> +int main()
> +{
> +    test_fn tests[] =3D { test_return, test_endloop, test_multi_cof, tes=
t_done };
> +    nr_tests =3D (sizeof(tests) / sizeof(tests[0])) - 1;
> +
> +    struct sigaction sa =3D {
> +        .sa_sigaction =3D sigbus_handler,
> +        .sa_flags =3D SA_SIGINFO
> +    };
> +
> +    if (sigaction(SIGBUS, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    sigsetjmp(after_test, 1);
> +    tests[completed_tests]();
> +
> +    /* should never get here */
> +    puts("FAIL");
> +    return 1;
> +}
> diff --git a/tests/tcg/hexagon/Makefile.target
> b/tests/tcg/hexagon/Makefile.target
> index f839b2c0d5..e5182c01d8 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -51,6 +51,7 @@ HEX_TESTS +=3D scatter_gather
>  HEX_TESTS +=3D hvx_misc
>  HEX_TESTS +=3D hvx_histogram
>  HEX_TESTS +=3D invalid-slots
> +HEX_TESTS +=3D unaligned_pc
>=20
>  run-and-check-exception =3D $(call run-test,$2,$3 2>$2.stderr; \
>  	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr)
> @@ -107,6 +108,7 @@ overflow: overflow.c hex_test.h
>  preg_alias: preg_alias.c hex_test.h
>  read_write_overlap: read_write_overlap.c hex_test.h
>  reg_mut: reg_mut.c hex_test.h
> +unaligned_pc: unaligned_pc.c
>=20
>  # This test has to be compiled for the -mv67t target
>  usr: usr.c hex_test.h
> --
> 2.37.2


