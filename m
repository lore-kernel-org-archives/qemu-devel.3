Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659A6C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 02:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMfDw-0003Q2-Ax; Wed, 26 Jun 2024 22:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMfDu-0003Ph-Au; Wed, 26 Jun 2024 22:50:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMfDp-0001Bw-G5; Wed, 26 Jun 2024 22:50:58 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R2oK0a026752;
 Thu, 27 Jun 2024 02:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=pp1; bh=Tr0ru7ezxE7XPmK2Q/RQ7Hald6
 P+5XT/NX+iqyqao10=; b=d30whuQEtkgj2isWIn04cSWwdCmZ3zF9zCvrSNSICT
 nN4vOMzBqG74wSJA5feI+5/34u8s4cRI7EPCE+oznX4VpDg+ndMElTKmjCRpXFI5
 8ShPc4gbWVlqnlx7qkSBwuyp7bIEScRjSqdPUGle49WeBIDACXjUyfd8ckButM8h
 IiSoTPtXJufSwO2KCPehXxjEPSlB9yut26n+Ggv/IFdrr+pZR4I5TRn1MbIwp1UX
 8Yzp45izbBze5lmD8IhuDHHiO2xAhYEBFE9iVQGWdCLza9jkDKB55EmgKrUr7h6S
 xL/Ao7i5vXMwf0w2W+fUFKJCQ9T/qDcKCEc+am3onJbA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yax012q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 02:50:49 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45R2oJb6026587;
 Thu, 27 Jun 2024 02:50:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yax012n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jun 2024 02:50:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9z+GiLf+Xt+HIddwq/G/3L2ruNY2VQkgvH8tEc1hpF64xczfNELYL4V8CT7tmwv6CJT2jZFBn3JUNgIxWytqWD0o+jX/Be3H4+cm6PVCTe28HUo7S9jd+V6qmRvYLt6494Oz0FBO46VV35/psG/tRDArvnXqbdsNd+GIjlE3eXf2FTllLGRuWFUtiQ2at8ZnnP2SYv8dAmpS1NrOMtCYgjfs7GLfVj1nvaXiDUxxvWv0oC6DyEHLnC9o723igSl1GtgyAYcGwjST6CmgIWz1OhNyMhMSPwpgBE8mbbfQUeVahEHH5l3YLm5oT9SmILSa2kxpVQa9lUKNu/9TSEodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr0ru7ezxE7XPmK2Q/RQ7Hald6P+5XT/NX+iqyqao10=;
 b=QHpmvs61MdNY7uh6+L/ELEjNhb4mKLflMATPAIKMYZvm7cXxr1sd5wGu0dDPLJ4hr7RWL+oxtaqYVBGWbei1/on8uMnPKiDVI1Lte4GZOqxokyzfGaUq0uVw5wJMbBpXArb2nrYAjQYQWz7NACb/ZaprZZwXuj7yP5WFsgO4YLzbkRC3Ehmmj9mFXRPbL9w0x+zwNziSh8W8gYE/gk4y8dPR1zpT/jmTO0YIY5jQkTQI9O0+KVUkQ3qw6UXSbD17StDgOCRgsCbApSRZ7EEC+ONGgO/koCEN23lCbKxXnCSV0JVqcUHrcLuXckKled70UexGIJLKaTWuTsPBErvfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from PH0PR15MB4720.namprd15.prod.outlook.com (2603:10b6:510:9a::6)
 by CH0PR15MB6293.namprd15.prod.outlook.com (2603:10b6:610:185::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 02:50:46 +0000
Received: from PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4]) by PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:50:46 +0000
From: CALEB SCHLOSSIN <calebs@us.ibm.com>
To: Chalapathi V <chalapathi.v@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "fbarrat@linux.ibm.com"
 <fbarrat@linux.ibm.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 Chalapathi V <Chalapathi.V@ibm.com>,
 "saif.abrar@linux.ibm.com" <saif.abrar@linux.ibm.com>, Dan Tan
 <dantan@us.ibm.com>, "milesg@linux.ibm.com" <milesg@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] hw/ssi: Add SPI model
Thread-Topic: [PATCH v5 2/6] hw/ssi: Add SPI model
Thread-Index: AQHax6gNvKr1XferIk2cpVTHMk5FpbHa6X5Y
Date: Thu, 27 Jun 2024 02:50:46 +0000
Message-ID: <PH0PR15MB4720578A5C8CAA066CB9838AE1D72@PH0PR15MB4720.namprd15.prod.outlook.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
 <20240626090528.812-3-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240626090528.812-3-chalapathi.v@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB4720:EE_|CH0PR15MB6293:EE_
x-ms-office365-filtering-correlation-id: a63f7b33-0e82-42d8-ebd9-08dc9653f1ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kZ93YpKVJSMZSOoqkIyU/5Fb/DSwmGXj3s0w95/hlSgLdB1U15ToCjFc7Z?=
 =?iso-8859-1?Q?ayHtnGfY6PZyoZzHDoeFkcUtFj58HUitNxKKAp0CuE3McRm1ES1lbkj1Fa?=
 =?iso-8859-1?Q?oC5u9RW7zoClWBuyQiw+pY8tL6aL/xZ49h3cqMQYxoJXa106nFididpnbw?=
 =?iso-8859-1?Q?JUK9Q1h75fXXam4ntu2dC/ioBVZM+mVr+QxpalWAzC1UOldDmuqGTpRY64?=
 =?iso-8859-1?Q?4G+zL21ShLO97Mq7BrOSt3zjHTIfigjDJHMiF+rB6i8iDrnff8Z/c8YUhq?=
 =?iso-8859-1?Q?yWt+nGI/vf2Nzu+bU7OfD1qZeJr4A5cCpLGA8h+dwbqQZTrOwAH4WqZgNy?=
 =?iso-8859-1?Q?BXwftFCXbZ2F1VmTRk8peJaa6C9bycAhh9223ADeuzPZdnoIF9iqQ+85mH?=
 =?iso-8859-1?Q?l4n4aG83+1aeUb3C9dvatnvtY9/46ySs/7n7HRc9TPS2ex1uPd/U1X+IVZ?=
 =?iso-8859-1?Q?WISqt8/LtS8eyCgipOFxJSjTxRizJsxNHg7dyJrrbJXoIIeY4x/CGeumIe?=
 =?iso-8859-1?Q?YALaa0FA/kTYkKsB6ZKdQ7NmBMy6GDFMDK20yhsdRA/RAenW9vWB5ZIKBP?=
 =?iso-8859-1?Q?cSdGQ1GFHCvU60dw8Lsq08eeHQOPO4fg1Y+FiB6IaF0BJKQUWlMZB4QvF3?=
 =?iso-8859-1?Q?aknVF3h/XO7LIhNA+FnvWSdc797J4f5RUVWt7y7Gg80Uw0E30fKELQVnnV?=
 =?iso-8859-1?Q?Gkcq2iav7dsv3IyF3R53XLvyFuT+dViPhCN0UHbK+7Kecs4Vp//eFMw2zd?=
 =?iso-8859-1?Q?KEpxFT8qFDp/jkqU5pjNO6mETiwlqAwHpan0QsFFBCBUrZwKrU15wdJ6kH?=
 =?iso-8859-1?Q?haWqFFBJrtL3zQU6/mV2qOny4sLY4x1ByRy0izVsOthw3MwLssbuUq2vM1?=
 =?iso-8859-1?Q?dWz90cdCGvh6L8d3N60Po4+iyQfxkcPknN+rLhB9EGWFH6gU1gMyqq6qQA?=
 =?iso-8859-1?Q?JtC27k9HyLX8nrK8IVlcPkIk5oyzETbp6PhSgkr/1FwNJ1lwRx8OvYUJUF?=
 =?iso-8859-1?Q?WEecEfSZjXPneSS5tSkUqdPr2iuPExdNriQBBLPhZYBXC5pmFaFB5UtjTj?=
 =?iso-8859-1?Q?y1SxtwH2AsePvP26oLBJDhKlXjiYv66LzrD5PMiEIRlL0t/d+nbomA8gPN?=
 =?iso-8859-1?Q?VVqj4NQnA77OpbJSIV1eq1UG9nMFPKhB7g0g5UiiOoYupEuFwGizuDn+Ad?=
 =?iso-8859-1?Q?X+xMjfGQQiHSa51KJySI++QJwPPu6McMppw3jjn37UfQw2IykXjn3SydQ6?=
 =?iso-8859-1?Q?lkEMYV8zSnvHU2Zu0MayzKWNVQav2mVxmfhZTieqwsDDz8+iBjiEoVIxj6?=
 =?iso-8859-1?Q?Uxo1NJT7S+VZ28+zj+P0MIxQZZrpyc+MoEbWJ0ABpCiLzAcGsPto5cVltq?=
 =?iso-8859-1?Q?ZVPp99uojCcpzA6yPPVDCH2MFZ/vkaYX8Gb9jqlJ72ectaWNZF1ng48yRg?=
 =?iso-8859-1?Q?2W5sIF6zHc8vHwR0hO81P62LQZ0/EriOZaYsJQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR15MB4720.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NKzeNruOG3EKccDvfe6PGrcyeqt58o4v/40kCFBFoM5zy6mtFO8akmTdUm?=
 =?iso-8859-1?Q?bgy7379HjRkZoQYc1rOU4PDpzkyGtxQCTjsthAuvZNj/ZoT+NylbZpf6fe?=
 =?iso-8859-1?Q?b3P1KoOJU+oIzYBKzWr7ixPUbr/8ygukdymMW75WgIyBUBkLf7Gt/8QKEr?=
 =?iso-8859-1?Q?2OK57pGCj+dTB1MB5zV4rP/kSwCBAdZUWEGBKfDyxAo+J+bucX9EQ4gBy4?=
 =?iso-8859-1?Q?69aeXRxJ6xTTDy7o24nfmK+owbeVf5rCDPUHbJEhWARHDBxAcR6sd/6QiV?=
 =?iso-8859-1?Q?0tJwhacapx8nimNvrlK8cz8/GiOxV483P1jhuW0OrMbHXXQTQwOY22Dv1w?=
 =?iso-8859-1?Q?4govgt4Zq7fA2XmLd+PdtBq3AVDNMk9nBNs+X3B3B7TjGjfWUAeedKYPYr?=
 =?iso-8859-1?Q?TkscPuZEFkp2XCgQYqsf8MOk95ptNYfUNLxWM+W194WNBMzJcEdjkI4awZ?=
 =?iso-8859-1?Q?sxPrLOUQ+bK+M7SBhrPd/sG3D68aVk5ZHCqp6HnDH2Rs0p+CiLxz5q4XfJ?=
 =?iso-8859-1?Q?+ex3sARWxFIGGUZMvSzZIaWJnOxzuxPZii5k+DmtVJHhAKMUvZgrHE8jBf?=
 =?iso-8859-1?Q?vY3hV+emNufsjhOyyiNJDMaYHyJqtUTuxNSCDyeySKaG//QjEzcuudDrJd?=
 =?iso-8859-1?Q?VrZtrOtsaWn3dan6EVIeKShibKMVTZi0cOrx4A6tZ8pKCR84v2hJmoKMvy?=
 =?iso-8859-1?Q?gsBj3pNc2DllDcmaga3cYdOzm6V1M93lFwyEjvcpqvG5+2hh14YDcYcSce?=
 =?iso-8859-1?Q?x/Qe3Ee5T0aqFINuQTZhbMa0fbRE7mv4kihttjR50xkR8jpcI9f99Cm6Wh?=
 =?iso-8859-1?Q?IrBtAXpW2kwuwbzi5DQ142e+ntKzk7yJi+NaNfnV9rHXy+2wHmqIR9cWAJ?=
 =?iso-8859-1?Q?QurrQrfOMVZ8DNafV3rOgXlEUyGq9SSA8kU6iPDcU0GV/7mD/ZduTaY2Qx?=
 =?iso-8859-1?Q?UVKbYRI0gDj4GDSveIgysbV7nyol2Cql+kLhVmW4nFvBBajYq+4tE2zzZT?=
 =?iso-8859-1?Q?8EIvYocwa1F1d634+gbbUGVvpdz3MxbeuIhifgMHLK3c8l2hWcu4qvlrt/?=
 =?iso-8859-1?Q?r3YRzBPNlq5UtJYtsS2Mi9HpkaIhmQJfN75I1Ew/GO449G8cIlPlX81yYn?=
 =?iso-8859-1?Q?piYNv8bMEnZ4ut8HBGIYB2px3bJM9b2TpOO+JgV4VUDN7Lvm7GoIaONXnj?=
 =?iso-8859-1?Q?xBV/9VQvsuh0P2hClUwrTy+33ucAQ2F5ycPX0Jt5+Mm3JHDD+AeRqEo+v3?=
 =?iso-8859-1?Q?XRjwkcHeW5vkz3OTNyH/uG1lGpmJ9cvDom/LktjT6AXgwktj4HT1LyGG/f?=
 =?iso-8859-1?Q?Z/rFIUiwLivFcJnuNuBOyBLAksiwjH/ZHkMNkfP/mo0QJ6ygtlEQKXH7ND?=
 =?iso-8859-1?Q?xxOrUnMKixDfSx9X3X+uAKTTR+oa0WMt2V23vxu6/5hb6qIsuuDslgEVLw?=
 =?iso-8859-1?Q?3lvbzsLGTz9XLeE0sAbGY0WIgMyiavk6sAIUtDqWqLyOte78K4/X/OIgxK?=
 =?iso-8859-1?Q?SEPcXU1WkLPp+OrZr2JbbaAiu8RapKp315W5extldbj27ccjssnGwzgwU/?=
 =?iso-8859-1?Q?yzy3HhBV+tkfcBO9vUGWBU6fWoAXWdWOInLSRAlQ1wo3x+p7lbqVHlmoxJ?=
 =?iso-8859-1?Q?oHtsrcnr9t5Fs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR15MB4720578A5C8CAA066CB9838AE1D72PH0PR15MB4720namp_"
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4720.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63f7b33-0e82-42d8-ebd9-08dc9653f1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 02:50:46.5118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8YiLBzDbWYqQIRLEOFmUGsnRPZQKkop4H9ZV6Cj3d8DJGn+5mO1YDt13RMLAuawV9ETpoBfybuq9F+hNxPWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6293
X-Proofpoint-GUID: yPCF8JJPPom8UhBmBGGba8TKDILHRUv-
X-Proofpoint-ORIG-GUID: 3n7aGprsyWhHaItC0arjfvX9t_sRb4V8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270016
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@us.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--_000_PH0PR15MB4720578A5C8CAA066CB9838AE1D72PH0PR15MB4720namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> An existing QEMU SSI framework is used and SSI_BUS is created.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>

Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>

Thanks,
Caleb Schlossin

________________________________
From: Chalapathi V <chalapathi.v@linux.ibm.com>
Sent: Wednesday, June 26, 2024 4:05 AM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: qemu-ppc@nongnu.org <qemu-ppc@nongnu.org>; fbarrat@linux.ibm.com <fbarr=
at@linux.ibm.com>; npiggin@gmail.com <npiggin@gmail.com>; clg@kaod.org <clg=
@kaod.org>; CALEB SCHLOSSIN <calebs@us.ibm.com>; Chalapathi V <Chalapathi.V=
@ibm.com>; chalapathi.v@linux.ibm.com <chalapathi.v@linux.ibm.com>; saif.ab=
rar@linux.ibm.com <saif.abrar@linux.ibm.com>; Dan Tan <dantan@us.ibm.com>; =
milesg@linux.ibm.com <milesg@linux.ibm.com>
Subject: [PATCH v5 2/6] hw/ssi: Add SPI model

SPI controller device model supports a connection to a single SPI responder=
.
This provide access to SPI seeproms, TPM, flash device and an ADC controlle=
r.

All SPI function control is mapped into the SPI register space to enable fu=
ll
control by firmware. In this commit SPI configuration component is modelled
which contains all SPI configuration and status registers as well as the ho=
ld
registers for data to be sent or having been received.

An existing QEMU SSI framework is used and SSI_BUS is created.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_xscom.h    |   3 +
 include/hw/ssi/pnv_spi.h      |  40 +++++++
 include/hw/ssi/pnv_spi_regs.h |  67 +++++++++++
 hw/ssi/pnv_spi.c              | 214 ++++++++++++++++++++++++++++++++++
 hw/ppc/Kconfig                |   3 +
 hw/ssi/Kconfig                |   4 +
 hw/ssi/meson.build            |   1 +
 hw/ssi/trace-events           |   6 +
 8 files changed, 338 insertions(+)
 create mode 100644 include/hw/ssi/pnv_spi.h
 create mode 100644 include/hw/ssi/pnv_spi_regs.h
 create mode 100644 hw/ssi/pnv_spi.c

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index c8dd42bffd..0020dd172f 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -194,6 +194,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
 #define PNV10_XSCOM_PEC_PCI_SIZE   0x200

+#define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000
+#define PNV10_XSCOM_PIB_SPIC_SIZE 0x20
+
 void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
                  uint64_t xscom_base, uint64_t xscom_size,
diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
new file mode 100644
index 0000000000..833042b74b
--- /dev/null
+++ b/include/hw/ssi/pnv_spi.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU PowerPC SPI model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This model Supports a connection to a single SPI responder.
+ * Introduced for P10 to provide access to SPI seeproms, TPM, flash device
+ * and an ADC controller.
+ */
+
+#ifndef PPC_PNV_SPI_H
+#define PPC_PNV_SPI_H
+
+#include "hw/ssi/ssi.h"
+#include "hw/sysbus.h"
+
+#define TYPE_PNV_SPI "pnv-spi"
+OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
+
+#define PNV_SPI_REG_SIZE 8
+#define PNV_SPI_REGS 7
+
+#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
+typedef struct PnvSpi {
+    SysBusDevice parent_obj;
+
+    SSIBus *ssi_bus;
+    qemu_irq *cs_line;
+    MemoryRegion    xscom_spic_regs;
+    /* SPI object number */
+    uint32_t        spic_num;
+
+    /* SPI registers */
+    uint64_t        regs[PNV_SPI_REGS];
+    uint8_t         seq_op[PNV_SPI_REG_SIZE];
+    uint64_t        status;
+} PnvSpi;
+#endif /* PPC_PNV_SPI_H */
diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h
new file mode 100644
index 0000000000..5b6ff72d02
--- /dev/null
+++ b/include/hw/ssi/pnv_spi_regs.h
@@ -0,0 +1,67 @@
+/*
+ * QEMU PowerPC SPI model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PNV_SPI_CONTROLLER_REGS_H
+#define PNV_SPI_CONTROLLER_REGS_H
+
+/*
+ * Macros from target/ppc/cpu.h
+ * These macros are copied from ppc target specific file target/ppc/cpu.h
+ * as target/ppc/cpu.h cannot be included here.
+ */
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT8(bit)           (0x80 >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs)=
)
+#define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT8(=
bs))
+#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
+#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
+#define SETFIELD(m, v, val) \
+        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
+
+/* Error Register */
+#define ERROR_REG               0x00
+
+/* counter_config_reg */
+#define SPI_CTR_CFG_REG         0x01
+
+/* config_reg */
+#define CONFIG_REG1             0x02
+
+/* clock_config_reset_control_ecc_enable_reg */
+#define SPI_CLK_CFG_REG         0x03
+#define SPI_CLK_CFG_HARD_RST    0x0084000000000000;
+#define SPI_CLK_CFG_RST_CTRL    PPC_BITMASK(24, 27)
+
+/* memory_mapping_reg */
+#define SPI_MM_REG              0x04
+
+/* transmit_data_reg */
+#define SPI_XMIT_DATA_REG       0x05
+
+/* receive_data_reg */
+#define SPI_RCV_DATA_REG        0x06
+
+/* sequencer_operation_reg */
+#define SPI_SEQ_OP_REG          0x07
+
+/* status_reg */
+#define SPI_STS_REG             0x08
+#define SPI_STS_RDR_FULL        PPC_BIT(0)
+#define SPI_STS_RDR_OVERRUN     PPC_BIT(1)
+#define SPI_STS_RDR_UNDERRUN    PPC_BIT(2)
+#define SPI_STS_TDR_FULL        PPC_BIT(4)
+#define SPI_STS_TDR_OVERRUN     PPC_BIT(5)
+#define SPI_STS_TDR_UNDERRUN    PPC_BIT(6)
+#define SPI_STS_SEQ_FSM         PPC_BITMASK(8, 15)
+#define SPI_STS_SHIFTER_FSM     PPC_BITMASK(16, 27)
+#define SPI_STS_SEQ_INDEX       PPC_BITMASK(28, 31)
+#define SPI_STS_GEN_STATUS      PPC_BITMASK(32, 63)
+#define SPI_STS_RDR             PPC_BITMASK(1, 3)
+#define SPI_STS_TDR             PPC_BITMASK(5, 7)
+
+#endif
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
new file mode 100644
index 0000000000..de3ffc4e56
--- /dev/null
+++ b/hw/ssi/pnv_spi.c
@@ -0,0 +1,214 @@
+/*
+ * QEMU PowerPC SPI model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ssi/pnv_spi.h"
+#include "hw/ssi/pnv_spi_regs.h"
+#include "hw/ssi/ssi.h"
+#include <libfdt.h>
+#include "hw/irq.h"
+#include "trace.h"
+
+/*
+ * Macro from include/hw/ppc/fdt.h
+ * fdt.h cannot be included here as it contain ppc target specific depende=
ncy.
+ */
+#define _FDT(exp)                                                  \
+    do {                                                           \
+        int _ret =3D (exp);                                          \
+        if (_ret < 0) {                                            \
+            error_report("error creating device tree: %s: %s",     \
+                    #exp, fdt_strerror(_ret));                     \
+            exit(1);                                               \
+        }                                                          \
+    } while (0)
+
+static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigned siz=
e)
+{
+    PnvSpi *s =3D PNV_SPI(opaque);
+    uint32_t reg =3D addr >> 3;
+    uint64_t val =3D ~0ull;
+
+    switch (reg) {
+    case ERROR_REG:
+    case SPI_CTR_CFG_REG:
+    case CONFIG_REG1:
+    case SPI_CLK_CFG_REG:
+    case SPI_MM_REG:
+    case SPI_XMIT_DATA_REG:
+        val =3D s->regs[reg];
+        break;
+    case SPI_RCV_DATA_REG:
+        val =3D s->regs[reg];
+        trace_pnv_spi_read_RDR(val);
+        s->status =3D SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
+        break;
+    case SPI_SEQ_OP_REG:
+        val =3D 0;
+        for (int i =3D 0; i < PNV_SPI_REG_SIZE; i++) {
+            val =3D (val << 8) | s->seq_op[i];
+        }
+        break;
+    case SPI_STS_REG:
+        val =3D s->status;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi_regs: Invalid xscom "
+                 "read at 0x%" PRIx32 "\n", reg);
+    }
+
+    trace_pnv_spi_read(addr, val);
+    return val;
+}
+
+static void pnv_spi_xscom_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvSpi *s =3D PNV_SPI(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    trace_pnv_spi_write(addr, val);
+
+    switch (reg) {
+    case ERROR_REG:
+    case SPI_CTR_CFG_REG:
+    case CONFIG_REG1:
+    case SPI_MM_REG:
+    case SPI_RCV_DATA_REG:
+        s->regs[reg] =3D val;
+        break;
+    case SPI_CLK_CFG_REG:
+        /*
+         * To reset the SPI controller write the sequence 0x5 0xA to
+         * reset_control field
+         */
+        if ((GETFIELD(SPI_CLK_CFG_RST_CTRL, s->regs[SPI_CLK_CFG_REG]) =3D=
=3D 0x5)
+             && (GETFIELD(SPI_CLK_CFG_RST_CTRL, val) =3D=3D 0xA)) {
+                /* SPI controller reset sequence completed, resetting */
+            s->regs[reg] =3D SPI_CLK_CFG_HARD_RST;
+        } else {
+            s->regs[reg] =3D val;
+        }
+        break;
+    case SPI_XMIT_DATA_REG:
+        /*
+         * Writing to the transmit data register causes the transmit data
+         * register full status bit in the status register to be set.  Wri=
ting
+         * when the transmit data register full status bit is already set
+         * causes a "Resource Not Available" condition.  This is not possi=
ble
+         * in the model since writes to this register are not asynchronous=
 to
+         * the operation sequence like it would be in hardware.
+         */
+        s->regs[reg] =3D val;
+        trace_pnv_spi_write_TDR(val);
+        s->status =3D SETFIELD(SPI_STS_TDR_FULL, s->status, 1);
+        s->status =3D SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 0);
+        break;
+    case SPI_SEQ_OP_REG:
+        for (int i =3D 0; i < PNV_SPI_REG_SIZE; i++) {
+            s->seq_op[i] =3D (val >> (56 - i * 8)) & 0xFF;
+        }
+        break;
+    case SPI_STS_REG:
+        /* other fields are ignore_write */
+        s->status =3D SETFIELD(SPI_STS_RDR_OVERRUN, s->status,
+                                  GETFIELD(SPI_STS_RDR, val));
+        s->status =3D SETFIELD(SPI_STS_TDR_OVERRUN, s->status,
+                                  GETFIELD(SPI_STS_TDR, val));
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi_regs: Invalid xscom "
+                 "write at 0x%" PRIx32 "\n", reg);
+    }
+    return;
+}
+
+static const MemoryRegionOps pnv_spi_xscom_ops =3D {
+    .read =3D pnv_spi_xscom_read,
+    .write =3D pnv_spi_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static Property pnv_spi_properties[] =3D {
+    DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_spi_realize(DeviceState *dev, Error **errp)
+{
+    PnvSpi *s =3D PNV_SPI(dev);
+    g_autofree char *name =3D g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
+                    s->spic_num);
+    s->ssi_bus =3D ssi_create_bus(dev, name);
+    s->cs_line =3D g_new0(qemu_irq, 1);
+    qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
+
+    /* spi scoms */
+    pnv_xscom_region_init(&s->xscom_spic_regs, OBJECT(s), &pnv_spi_xscom_o=
ps,
+                          s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
+}
+
+static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    PnvSpi *s =3D PNV_SPI(dev);
+    g_autofree char *name;
+    int s_offset;
+    const char compat[] =3D "ibm,power10-spi";
+    uint32_t spic_pcba =3D PNV10_XSCOM_PIB_SPIC_BASE +
+        s->spic_num * PNV10_XSCOM_PIB_SPIC_SIZE;
+    uint32_t reg[] =3D {
+        cpu_to_be32(spic_pcba),
+        cpu_to_be32(PNV10_XSCOM_PIB_SPIC_SIZE)
+    };
+    name =3D g_strdup_printf("pnv_spi@%x", spic_pcba);
+    s_offset =3D fdt_add_subnode(fdt, offset, name);
+    _FDT(s_offset);
+
+    _FDT(fdt_setprop(fdt, s_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, s_offset, "compatible", compat, sizeof(compat)))=
;
+    _FDT((fdt_setprop_cell(fdt, s_offset, "spic_num#", s->spic_num)));
+    return 0;
+}
+
+static void pnv_spi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom =3D pnv_spi_dt_xscom;
+
+    dc->desc =3D "PowerNV SPI";
+    dc->realize =3D pnv_spi_realize;
+    device_class_set_props(dc, pnv_spi_properties);
+}
+
+static const TypeInfo pnv_spi_info =3D {
+    .name          =3D TYPE_PNV_SPI,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(PnvSpi),
+    .class_init    =3D pnv_spi_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_spi_register_types(void)
+{
+    type_register_static(&pnv_spi_info);
+}
+
+type_init(pnv_spi_register_types);
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 78f83e78ce..4668d59eab 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -39,6 +39,9 @@ config POWERNV
     select PCI_POWERNV
     select PCA9552
     select PCA9554
+    select SSI
+    select SSI_M25P80
+    select PNV_SPI

 config PPC405
     bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 83ee53c1d0..8d180de7cf 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -24,3 +24,7 @@ config STM32F2XX_SPI
 config BCM2835_SPI
     bool
     select SSI
+
+config PNV_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index b999aeb027..b7ad7fca3b 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi=
.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
+system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2d5bd2b83d..4388024a05 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -32,3 +32,9 @@ ibex_spi_host_reset(const char *msg) "%s"
 ibex_spi_host_transfer(uint32_t tx_data, uint32_t rx_data) "tx_data: 0x%" =
PRIx32 " rx_data: @0x%" PRIx32
 ibex_spi_host_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PR=
Ix64 " size %u: 0x%" PRIx64
 ibex_spi_host_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size %u:"
+
+#pnv_spi.c
+pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRI=
x64
+pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PR=
Ix64
+pnv_spi_read_RDR(uint64_t val) "data extracted =3D 0x%" PRIx64
+pnv_spi_write_TDR(uint64_t val) "being written, data written =3D 0x%" PRIx=
64
--
2.39.3


--_000_PH0PR15MB4720578A5C8CAA066CB9838AE1D72PH0PR15MB4720namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
&gt; An existing QEMU SSI framework is used and SSI_BUS is created.<br>
&gt;&nbsp;<br>
&gt; Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
Reviewed-by: Caleb Schlossin &lt;calebs@linux.vnet.ibm.com&gt;</div>
<div style=3D"text-align: left; text-indent: 0px; margin: 0px; font-family:=
 Arial, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin: 0px; font-family: Arial, Helvetica, sans-serif; font-=
size: 10pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"margin: 0px; font-family: Arial, Hel=
vetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
Caleb Schlossin</div>
<div id=3D"Signature"></div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Chalap=
athi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, June 26, 2024 4:05 AM<br>
<b>To:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;qemu-ppc@nongnu.org &lt;qemu-ppc@nongnu.org&gt;; fbarrat@li=
nux.ibm.com &lt;fbarrat@linux.ibm.com&gt;; npiggin@gmail.com &lt;npiggin@gm=
ail.com&gt;; clg@kaod.org &lt;clg@kaod.org&gt;; CALEB SCHLOSSIN &lt;calebs@=
us.ibm.com&gt;; Chalapathi V &lt;Chalapathi.V@ibm.com&gt;; chalapathi.v@lin=
ux.ibm.com
 &lt;chalapathi.v@linux.ibm.com&gt;; saif.abrar@linux.ibm.com &lt;saif.abra=
r@linux.ibm.com&gt;; Dan Tan &lt;dantan@us.ibm.com&gt;; milesg@linux.ibm.co=
m &lt;milesg@linux.ibm.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v5 2/6] hw/ssi: Add SPI model</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">SPI controller device model supports a conn=
ection to a single SPI responder.<br>
This provide access to SPI seeproms, TPM, flash device and an ADC controlle=
r.<br>
<br>
All SPI function control is mapped into the SPI register space to enable fu=
ll<br>
control by firmware. In this commit SPI configuration component is modelled=
<br>
which contains all SPI configuration and status registers as well as the ho=
ld<br>
registers for data to be sent or having been received.<br>
<br>
An existing QEMU SSI framework is used and SSI_BUS is created.<br>
<br>
Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
---<br>
&nbsp;include/hw/ppc/pnv_xscom.h&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;include/hw/ssi/pnv_spi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 40 +++=
++++<br>
&nbsp;include/hw/ssi/pnv_spi_regs.h |&nbsp; 67 +++++++++++<br>
&nbsp;hw/ssi/pnv_spi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 214 ++++++++++++++++++++++++++++++++++<br>
&nbsp;hw/ppc/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;hw/ssi/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<br>
&nbsp;hw/ssi/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;hw/ssi/trace-events&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
&nbsp;8 files changed, 338 insertions(+)<br>
&nbsp;create mode 100644 include/hw/ssi/pnv_spi.h<br>
&nbsp;create mode 100644 include/hw/ssi/pnv_spi_regs.h<br>
&nbsp;create mode 100644 hw/ssi/pnv_spi.c<br>
<br>
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h<br>
index c8dd42bffd..0020dd172f 100644<br>
--- a/include/hw/ppc/pnv_xscom.h<br>
+++ b/include/hw/ppc/pnv_xscom.h<br>
@@ -194,6 +194,9 @@ struct PnvXScomInterfaceClass {<br>
&nbsp;#define PNV10_XSCOM_PEC_PCI_BASE&nbsp;&nbsp; 0x8010800 /* index goes =
upwards ... */<br>
&nbsp;#define PNV10_XSCOM_PEC_PCI_SIZE&nbsp;&nbsp; 0x200<br>
&nbsp;<br>
+#define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000<br>
+#define PNV10_XSCOM_PIB_SPIC_SIZE 0x20<br>
+<br>
&nbsp;void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);<br>
&nbsp;int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t xscom_base, uint64_t xscom_size,<br>
diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h<br>
new file mode 100644<br>
index 0000000000..833042b74b<br>
--- /dev/null<br>
+++ b/include/hw/ssi/pnv_spi.h<br>
@@ -0,0 +1,40 @@<br>
+/*<br>
+ * QEMU PowerPC SPI model<br>
+ *<br>
+ * Copyright (c) 2024, IBM Corporation.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ *<br>
+ * This model Supports a connection to a single SPI responder.<br>
+ * Introduced for P10 to provide access to SPI seeproms, TPM, flash device=
<br>
+ * and an ADC controller.<br>
+ */<br>
+<br>
+#ifndef PPC_PNV_SPI_H<br>
+#define PPC_PNV_SPI_H<br>
+<br>
+#include &quot;hw/ssi/ssi.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+<br>
+#define TYPE_PNV_SPI &quot;pnv-spi&quot;<br>
+OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)<br>
+<br>
+#define PNV_SPI_REG_SIZE 8<br>
+#define PNV_SPI_REGS 7<br>
+<br>
+#define TYPE_PNV_SPI_BUS &quot;pnv-spi-bus&quot;<br>
+typedef struct PnvSpi {<br>
+&nbsp;&nbsp;&nbsp; SysBusDevice parent_obj;<br>
+<br>
+&nbsp;&nbsp;&nbsp; SSIBus *ssi_bus;<br>
+&nbsp;&nbsp;&nbsp; qemu_irq *cs_line;<br>
+&nbsp;&nbsp;&nbsp; MemoryRegion&nbsp;&nbsp;&nbsp; xscom_spic_regs;<br>
+&nbsp;&nbsp;&nbsp; /* SPI object number */<br>
+&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spic=
_num;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* SPI registers */<br>
+&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs=
[PNV_SPI_REGS];<br>
+&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 seq_op[PNV_SPI_REG_SIZE];<br>
+&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stat=
us;<br>
+} PnvSpi;<br>
+#endif /* PPC_PNV_SPI_H */<br>
diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h<=
br>
new file mode 100644<br>
index 0000000000..5b6ff72d02<br>
--- /dev/null<br>
+++ b/include/hw/ssi/pnv_spi_regs.h<br>
@@ -0,0 +1,67 @@<br>
+/*<br>
+ * QEMU PowerPC SPI model<br>
+ *<br>
+ * Copyright (c) 2024, IBM Corporation.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef PNV_SPI_CONTROLLER_REGS_H<br>
+#define PNV_SPI_CONTROLLER_REGS_H<br>
+<br>
+/*<br>
+ * Macros from target/ppc/cpu.h<br>
+ * These macros are copied from ppc target specific file target/ppc/cpu.h<=
br>
+ * as target/ppc/cpu.h cannot be included here.<br>
+ */<br>
+#define PPC_BIT(bit)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (0x8000000000000000ULL &gt;&gt; (bit))<br>
+#define PPC_BIT8(bit)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (0x80 &gt;&gt; (bit))<br>
+#define PPC_BITMASK(bs, be)&nbsp;&nbsp;&nbsp;&nbsp; ((PPC_BIT(bs) - PPC_BI=
T(be)) | PPC_BIT(bs))<br>
+#define PPC_BITMASK8(bs, be)&nbsp;&nbsp;&nbsp; ((PPC_BIT8(bs) - PPC_BIT8(b=
e)) | PPC_BIT8(bs))<br>
+#define MASK_TO_LSH(m)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (__builtin_ffsll(m) - 1)<br>
+#define GETFIELD(m, v)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (((v) &amp; (m)) &gt;&gt; MASK_TO_LSH(m))<br>
+#define SETFIELD(m, v, val) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((v) &amp; ~(m)) | ((((typeof(=
v))(val)) &lt;&lt; MASK_TO_LSH(m)) &amp; (m)))<br>
+<br>
+/* Error Register */<br>
+#define ERROR_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<br>
+<br>
+/* counter_config_reg */<br>
+#define SPI_CTR_CFG_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
01<br>
+<br>
+/* config_reg */<br>
+#define CONFIG_REG1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x02<br>
+<br>
+/* clock_config_reset_control_ecc_enable_reg */<br>
+#define SPI_CLK_CFG_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
03<br>
+#define SPI_CLK_CFG_HARD_RST&nbsp;&nbsp;&nbsp; 0x0084000000000000;<br>
+#define SPI_CLK_CFG_RST_CTRL&nbsp;&nbsp;&nbsp; PPC_BITMASK(24, 27)<br>
+<br>
+/* memory_mapping_reg */<br>
+#define SPI_MM_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x04<br>
+<br>
+/* transmit_data_reg */<br>
+#define SPI_XMIT_DATA_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x05<br>
+<br>
+/* receive_data_reg */<br>
+#define SPI_RCV_DATA_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x06<br=
>
+<br>
+/* sequencer_operation_reg */<br>
+#define SPI_SEQ_OP_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x07<br>
+<br>
+/* status_reg */<br>
+#define SPI_STS_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x08<br>
+#define SPI_STS_RDR_FULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT=
(0)<br>
+#define SPI_STS_RDR_OVERRUN&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT(1)<br>
+#define SPI_STS_RDR_UNDERRUN&nbsp;&nbsp;&nbsp; PPC_BIT(2)<br>
+#define SPI_STS_TDR_FULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT=
(4)<br>
+#define SPI_STS_TDR_OVERRUN&nbsp;&nbsp;&nbsp;&nbsp; PPC_BIT(5)<br>
+#define SPI_STS_TDR_UNDERRUN&nbsp;&nbsp;&nbsp; PPC_BIT(6)<br>
+#define SPI_STS_SEQ_FSM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
C_BITMASK(8, 15)<br>
+#define SPI_STS_SHIFTER_FSM&nbsp;&nbsp;&nbsp;&nbsp; PPC_BITMASK(16, 27)<br=
>
+#define SPI_STS_SEQ_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BITMASK(=
28, 31)<br>
+#define SPI_STS_GEN_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPC_BITMASK(32, 6=
3)<br>
+#define SPI_STS_RDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PPC_BITMASK(1, 3)<br>
+#define SPI_STS_TDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PPC_BITMASK(5, 7)<br>
+<br>
+#endif<br>
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c<br>
new file mode 100644<br>
index 0000000000..de3ffc4e56<br>
--- /dev/null<br>
+++ b/hw/ssi/pnv_spi.c<br>
@@ -0,0 +1,214 @@<br>
+/*<br>
+ * QEMU PowerPC SPI model<br>
+ *<br>
+ * Copyright (c) 2024, IBM Corporation.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/ppc/pnv_xscom.h&quot;<br>
+#include &quot;hw/ssi/pnv_spi.h&quot;<br>
+#include &quot;hw/ssi/pnv_spi_regs.h&quot;<br>
+#include &quot;hw/ssi/ssi.h&quot;<br>
+#include &lt;libfdt.h&gt;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;trace.h&quot;<br>
+<br>
+/*<br>
+ * Macro from include/hw/ppc/fdt.h<br>
+ * fdt.h cannot be included here as it contain ppc target specific depende=
ncy.<br>
+ */<br>
+#define _FDT(exp)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int _ret =3D (exp);&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (_ret &lt; 0) {&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_r=
eport(&quot;error creating device tree: %s: %s&quot;,&nbsp;&nbsp;&nbsp;&nbs=
p; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #exp, fdt_strerror(_ret));&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1)=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp; } while (0)<br>
+<br>
+static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigned siz=
e)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; PnvSpi *s =3D PNV_SPI(opaque);<br>
+&nbsp;&nbsp;&nbsp; uint32_t reg =3D addr &gt;&gt; 3;<br>
+&nbsp;&nbsp;&nbsp; uint64_t val =3D ~0ull;<br>
+<br>
+&nbsp;&nbsp;&nbsp; switch (reg) {<br>
+&nbsp;&nbsp;&nbsp; case ERROR_REG:<br>
+&nbsp;&nbsp;&nbsp; case SPI_CTR_CFG_REG:<br>
+&nbsp;&nbsp;&nbsp; case CONFIG_REG1:<br>
+&nbsp;&nbsp;&nbsp; case SPI_CLK_CFG_REG:<br>
+&nbsp;&nbsp;&nbsp; case SPI_MM_REG:<br>
+&nbsp;&nbsp;&nbsp; case SPI_XMIT_DATA_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D s-&gt;regs[reg];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case SPI_RCV_DATA_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D s-&gt;regs[reg];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_read_RDR(val);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_RDR_FULL, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case SPI_SEQ_OP_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; PNV_SP=
I_REG_SIZE; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D=
 (val &lt;&lt; 8) | s-&gt;seq_op[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case SPI_STS_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D s-&gt;status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, =
&quot;pnv_spi_regs: Invalid xscom &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &quot;read at 0x%&quot; PRIx32 &quot;\n&quot;, reg);=
<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; trace_pnv_spi_read(addr, val);<br>
+&nbsp;&nbsp;&nbsp; return val;<br>
+}<br>
+<br>
+static void pnv_spi_xscom_write(void *opaque, hwaddr addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t val, unsigned size)<br=
>
+{<br>
+&nbsp;&nbsp;&nbsp; PnvSpi *s =3D PNV_SPI(opaque);<br>
+&nbsp;&nbsp;&nbsp; uint32_t reg =3D addr &gt;&gt; 3;<br>
+<br>
+&nbsp;&nbsp;&nbsp; trace_pnv_spi_write(addr, val);<br>
+<br>
+&nbsp;&nbsp;&nbsp; switch (reg) {<br>
+&nbsp;&nbsp;&nbsp; case ERROR_REG:<br>
+&nbsp;&nbsp;&nbsp; case SPI_CTR_CFG_REG:<br>
+&nbsp;&nbsp;&nbsp; case CONFIG_REG1:<br>
+&nbsp;&nbsp;&nbsp; case SPI_MM_REG:<br>
+&nbsp;&nbsp;&nbsp; case SPI_RCV_DATA_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[reg] =3D val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case SPI_CLK_CFG_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * To reset the SPI contro=
ller write the sequence 0x5 0xA to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * reset_control field<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((GETFIELD(SPI_CLK_CFG_RST_C=
TRL, s-&gt;regs[SPI_CLK_CFG_REG]) =3D=3D 0x5)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;&amp; (GETFIELD(SPI_CLK_CFG_RST_CTRL, val) =3D=3D 0xA)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* SPI controller reset sequence completed, resetting */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;r=
egs[reg] =3D SPI_CLK_CFG_HARD_RST;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;r=
egs[reg] =3D val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case SPI_XMIT_DATA_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Writing to the transmit=
 data register causes the transmit data<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * register full status bi=
t in the status register to be set.&nbsp; Writing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * when the transmit data =
register full status bit is already set<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * causes a &quot;Resource=
 Not Available&quot; condition.&nbsp; This is not possible<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in the model since writ=
es to this register are not asynchronous to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the operation sequence =
like it would be in hardware.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[reg] =3D val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_pnv_spi_write_TDR(val);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_TDR_FULL, s-&gt;status, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_TDR_UNDERRUN, s-&gt;status, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case SPI_SEQ_OP_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; PNV_SP=
I_REG_SIZE; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;s=
eq_op[i] =3D (val &gt;&gt; (56 - i * 8)) &amp; 0xFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case SPI_STS_REG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* other fields are ignore_writ=
e */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_RDR_OVERRUN, s-&gt;status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GETFIELD(SPI_STS_RDR, val=
));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;status =3D SETFIELD(SPI_S=
TS_TDR_OVERRUN, s-&gt;status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GETFIELD(SPI_STS_TDR, val=
));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, =
&quot;pnv_spi_regs: Invalid xscom &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &quot;write at 0x%&quot; PRIx32 &quot;\n&quot;, reg)=
;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return;<br>
+}<br>
+<br>
+static const MemoryRegionOps pnv_spi_xscom_ops =3D {<br>
+&nbsp;&nbsp;&nbsp; .read =3D pnv_spi_xscom_read,<br>
+&nbsp;&nbsp;&nbsp; .write =3D pnv_spi_xscom_write,<br>
+&nbsp;&nbsp;&nbsp; .valid.min_access_size =3D 8,<br>
+&nbsp;&nbsp;&nbsp; .valid.max_access_size =3D 8,<br>
+&nbsp;&nbsp;&nbsp; .impl.min_access_size =3D 8,<br>
+&nbsp;&nbsp;&nbsp; .impl.max_access_size =3D 8,<br>
+&nbsp;&nbsp;&nbsp; .endianness =3D DEVICE_BIG_ENDIAN,<br>
+};<br>
+<br>
+static Property pnv_spi_properties[] =3D {<br>
+&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT32(&quot;spic_num&quot;, PnvSpi, spic_n=
um, 0),<br>
+&nbsp;&nbsp;&nbsp; DEFINE_PROP_END_OF_LIST(),<br>
+};<br>
+<br>
+static void pnv_spi_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; PnvSpi *s =3D PNV_SPI(dev);<br>
+&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(TYPE_PNV_SPI_=
BUS &quot;.%d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;spic_num);<br>
+&nbsp;&nbsp;&nbsp; s-&gt;ssi_bus =3D ssi_create_bus(dev, name);<br>
+&nbsp;&nbsp;&nbsp; s-&gt;cs_line =3D g_new0(qemu_irq, 1);<br>
+&nbsp;&nbsp;&nbsp; qdev_init_gpio_out_named(DEVICE(s), s-&gt;cs_line, &quo=
t;cs&quot;, 1);<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* spi scoms */<br>
+&nbsp;&nbsp;&nbsp; pnv_xscom_region_init(&amp;s-&gt;xscom_spic_regs, OBJEC=
T(s), &amp;pnv_spi_xscom_ops,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; s, &quot;xscom-spi&quot;, PNV10_XSCOM_PIB_SPIC_SIZE);<br>
+}<br>
+<br>
+static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; int offset)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; PnvSpi *s =3D PNV_SPI(dev);<br>
+&nbsp;&nbsp;&nbsp; g_autofree char *name;<br>
+&nbsp;&nbsp;&nbsp; int s_offset;<br>
+&nbsp;&nbsp;&nbsp; const char compat[] =3D &quot;ibm,power10-spi&quot;;<br=
>
+&nbsp;&nbsp;&nbsp; uint32_t spic_pcba =3D PNV10_XSCOM_PIB_SPIC_BASE +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;spic_num * PNV10_XSCOM_PI=
B_SPIC_SIZE;<br>
+&nbsp;&nbsp;&nbsp; uint32_t reg[] =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_be32(spic_pcba),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_be32(PNV10_XSCOM_PIB_SPI=
C_SIZE)<br>
+&nbsp;&nbsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp; name =3D g_strdup_printf(&quot;pnv_spi@%x&quot;, spic_p=
cba);<br>
+&nbsp;&nbsp;&nbsp; s_offset =3D fdt_add_subnode(fdt, offset, name);<br>
+&nbsp;&nbsp;&nbsp; _FDT(s_offset);<br>
+<br>
+&nbsp;&nbsp;&nbsp; _FDT(fdt_setprop(fdt, s_offset, &quot;reg&quot;, reg, s=
izeof(reg)));<br>
+&nbsp;&nbsp;&nbsp; _FDT(fdt_setprop(fdt, s_offset, &quot;compatible&quot;,=
 compat, sizeof(compat)));<br>
+&nbsp;&nbsp;&nbsp; _FDT((fdt_setprop_cell(fdt, s_offset, &quot;spic_num#&q=
uot;, s-&gt;spic_num)));<br>
+&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static void pnv_spi_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+&nbsp;&nbsp;&nbsp; PnvXScomInterfaceClass *xscomc =3D PNV_XSCOM_INTERFACE_=
CLASS(klass);<br>
+<br>
+&nbsp;&nbsp;&nbsp; xscomc-&gt;dt_xscom =3D pnv_spi_dt_xscom;<br>
+<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;desc =3D &quot;PowerNV SPI&quot;;<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;realize =3D pnv_spi_realize;<br>
+&nbsp;&nbsp;&nbsp; device_class_set_props(dc, pnv_spi_properties);<br>
+}<br>
+<br>
+static const TypeInfo pnv_spi_info =3D {<br>
+&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D TYPE_PNV_SPI,<br>
+&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D T=
YPE_SYS_BUS_DEVICE,<br>
+&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(PnvSpi),<br>
+&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; =3D pnv_spi_class_init,<b=
r>
+&nbsp;&nbsp;&nbsp; .interfaces&nbsp;&nbsp;&nbsp; =3D (InterfaceInfo[]) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { TYPE_PNV_XSCOM_INTERFACE },<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+};<br>
+<br>
+static void pnv_spi_register_types(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; type_register_static(&amp;pnv_spi_info);<br>
+}<br>
+<br>
+type_init(pnv_spi_register_types);<br>
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig<br>
index 78f83e78ce..4668d59eab 100644<br>
--- a/hw/ppc/Kconfig<br>
+++ b/hw/ppc/Kconfig<br>
@@ -39,6 +39,9 @@ config POWERNV<br>
&nbsp;&nbsp;&nbsp;&nbsp; select PCI_POWERNV<br>
&nbsp;&nbsp;&nbsp;&nbsp; select PCA9552<br>
&nbsp;&nbsp;&nbsp;&nbsp; select PCA9554<br>
+&nbsp;&nbsp;&nbsp; select SSI<br>
+&nbsp;&nbsp;&nbsp; select SSI_M25P80<br>
+&nbsp;&nbsp;&nbsp; select PNV_SPI<br>
&nbsp;<br>
&nbsp;config PPC405<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool<br>
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig<br>
index 83ee53c1d0..8d180de7cf 100644<br>
--- a/hw/ssi/Kconfig<br>
+++ b/hw/ssi/Kconfig<br>
@@ -24,3 +24,7 @@ config STM32F2XX_SPI<br>
&nbsp;config BCM2835_SPI<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool<br>
&nbsp;&nbsp;&nbsp;&nbsp; select SSI<br>
+<br>
+config PNV_SPI<br>
+&nbsp;&nbsp;&nbsp; bool<br>
+&nbsp;&nbsp;&nbsp; select SSI<br>
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build<br>
index b999aeb027..b7ad7fca3b 100644<br>
--- a/hw/ssi/meson.build<br>
+++ b/hw/ssi/meson.build<br>
@@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi=
.c'))<br>
&nbsp;system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))<br>
&nbsp;system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))=
<br>
&nbsp;system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi=
.c'))<br>
+system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))<br>
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events<br>
index 2d5bd2b83d..4388024a05 100644<br>
--- a/hw/ssi/trace-events<br>
+++ b/hw/ssi/trace-events<br>
@@ -32,3 +32,9 @@ ibex_spi_host_reset(const char *msg) &quot;%s&quot;<br>
&nbsp;ibex_spi_host_transfer(uint32_t tx_data, uint32_t rx_data) &quot;tx_d=
ata: 0x%&quot; PRIx32 &quot; rx_data: @0x%&quot; PRIx32<br>
&nbsp;ibex_spi_host_write(uint64_t addr, uint32_t size, uint64_t data) &quo=
t;@0x%&quot; PRIx64 &quot; size %u: 0x%&quot; PRIx64<br>
&nbsp;ibex_spi_host_read(uint64_t addr, uint32_t size) &quot;@0x%&quot; PRI=
x64 &quot; size %u:&quot;<br>
+<br>
+#pnv_spi.c<br>
+pnv_spi_read(uint64_t addr, uint64_t val) &quot;addr 0x%&quot; PRIx64 &quo=
t; val 0x%&quot; PRIx64<br>
+pnv_spi_write(uint64_t addr, uint64_t val) &quot;addr 0x%&quot; PRIx64 &qu=
ot; val 0x%&quot; PRIx64<br>
+pnv_spi_read_RDR(uint64_t val) &quot;data extracted =3D 0x%&quot; PRIx64<b=
r>
+pnv_spi_write_TDR(uint64_t val) &quot;being written, data written =3D 0x%&=
quot; PRIx64<br>
--<br>
2.39.3<br>
<br>
</div>
</body>
</html>

--_000_PH0PR15MB4720578A5C8CAA066CB9838AE1D72PH0PR15MB4720namp_--

