Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3238DC48BEC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raigZ-0002Oh-1r; Thu, 15 Feb 2024 15:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=77757e4ce7=lesikigor@meta.com>)
 id 1raigY-0002OX-2F
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:50:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=77757e4ce7=lesikigor@meta.com>)
 id 1raigU-0003q2-1i
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:50:20 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41FJrNHv009243
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:50:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=69YVHR1jUFdRew/Xo2JlohtGAkTEOSl3qApNfDtFV1o=;
 b=grgcrPnF/W7Y5cRmOkCRRFzIkypUoWRb7wyLbKMKTInC8lsS4MU//jE6Sm54cxgNfUFW
 ua1b71FKZzxqaDuqm8xY051956vtJVq0cKmAGckY/RzkV31VdI0hcApEZkRNNgW6Wfwv
 lrHF/MXyTNJAhdy47Xe6TkzJt/06s/exSuLobgeetw4Aqm/84kS8YitCHJwDydp7S959
 L/W05a7TXy69Fk2j+y8MPv4vltQdRPYCxaOB2FuhggcwdbMOS3lcfiDuu9eGLNGeo1CS
 +GyjPeK+MOvP32wjpNaWZSjRPoOrDDXFba2uIKCmxCc5oKTg8hXomARkX4ef1JIb7b3A uQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3w900rsw7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:49:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbIgNLlcEQv1IjZwjBEd3ESvZSiuQkU4tTJoBRJeNENOFC/VBIZUWuo+TipmMD5hIq/WmuITTDu07RNQ/LaEZVgtYOLmcKqIJ41A/29NRoHypbkMEHXEZR0EwqMjaFIQQvqhCKqDaFXwxJnDdgpAWaRboaYZXhpEKIE4LtsjCoabxOvfyuezsOA/h1WpTzMYnrTqWeivDX3H/TKXcglM8sN2IQGAqGCdljOH/1IQ5cx0xuNHyxrrUhB6jo+q3iQJtQs/8XeoM3azU0ZZqQBLNJ0zraiPYpkcD1ooL8OkCBvvSd+Ujsl3DjZ78Q9S3ff1hCOMFFCS8QHiZEcMnugZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69YVHR1jUFdRew/Xo2JlohtGAkTEOSl3qApNfDtFV1o=;
 b=JAvkv7SOwWdAv4AqbLRoYnUM/EObyyTNLQgH4z6tj9WUdaakZr8jtonwt6i8eH24V02ahxjdQSH1eKtzgu6Mz+PPlOr7mPWo1+oZNQLhwRKiOizqA1t1LmA1v9SELk3xQuFvTVZDFdWRLkm1WDg5Vy+y89AQo3T/XuTsfDEm2I+KSlEVi6615mUpUktmBYFZ1gy7/JcI50Nj1GKRkSeiAvORHyNkhCaUQFLciqoM7UXkmjUOQtBcr8pXEEyRhQKxeMYV7us362JGmwOFUn10lm99f+qwztyVaIsWi3yAiH5J2WY0bKBreYE9/d1ML6zalyleuObkAj1e0mW859o+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BYAPR15MB2680.namprd15.prod.outlook.com (2603:10b6:a03:155::13)
 by DS7PR15MB6361.namprd15.prod.outlook.com (2603:10b6:8:da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Thu, 15 Feb
 2024 20:49:57 +0000
Received: from BYAPR15MB2680.namprd15.prod.outlook.com
 ([fe80::c7a:1dbe:8e98:668d]) by BYAPR15MB2680.namprd15.prod.outlook.com
 ([fe80::c7a:1dbe:8e98:668d%4]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 20:49:57 +0000
From: Igor Lesik <lesikigor@meta.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: support for having both 32 and 64 bit RISC-V CPUs in one QEMU machine
Thread-Topic: support for having both 32 and 64 bit RISC-V CPUs in one QEMU
 machine
Thread-Index: AdpgT6rPHa9M3Oi4SQCRPZcE8WkCVA==
Date: Thu, 15 Feb 2024 20:49:57 +0000
Message-ID: <BYAPR15MB268082AF727B0C775A4BA7E1C34D2@BYAPR15MB2680.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR15MB2680:EE_|DS7PR15MB6361:EE_
x-ms-office365-filtering-correlation-id: 7a6a7fe8-5a85-44a9-0009-08dc2e67ab68
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: puFZpL4bICzNJKXfaQ28zDkH7fYoOqu5H2+9qXNCyic6WMTd9KQcQfwhIWcitCT/ZTTGshkePYBGGFhQkr3YN9AVKrBZ6b9SL84qfH7+cZBOBr91fHvPC+0INKh2OEwtCk8PnWe4YQ6iqUdkm+l7fIexclSI08hw20q4K5p+TUIExkMou/GbhvnL+UMqJeMtP5cf63o35Vyq6heMTFU/8As6aNK31D6bYXGJ7/cwXVBdmELTARpu2abDgw3hxJP2hp8q7QP8WuOHICTKcGUZIwfBraWkNTRiAAypsKxAfisEWpf3yuYUC4KYrjK3MweLHE4zc9Z4O2HAv5QeLCwqvrDJED7vUZDPUgIj6ZBo//gT/4wpghS4h3UOGR42r0EBQaNFY22ONMn7MF/QsgP7NQItgdR0yN+WJDNFBovAqMZEbDizYZPLj0mTdATpOKewn/cJSQVqE6rlpdVmKQmcHi4fO890xhEB3UOrZqb7j8HLKbksABINJg4PuB2rebjk/9l4NJdIk5Ug8kf++qta5luMHvkpgeF44COlBbqoqTkI+0zsO7CeAYHMoMpsKDNb0NWiWSEZf2m2rdVtKT47h9Wu7TB5o7zF+7OEHIWOJ9Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2680.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(478600001)(64756008)(122000001)(6916009)(76116006)(66446008)(8936002)(9686003)(66476007)(66556008)(66946007)(52536014)(4744005)(7696005)(6506007)(71200400001)(41300700001)(38070700009)(5660300002)(2906002)(8676002)(316002)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DXb1JV8AFdVurcUvhSl4sa5Sd1LzIqgXtkvvPszV6ln2kQbry3tvnZM612RM?=
 =?us-ascii?Q?QprakanfV5UYxRk1UpGBRBcQcPSclrM3f1cU8WgbjI1Bi8DnWRNmzLwgQIrM?=
 =?us-ascii?Q?0RoS5v9DYf2e/axKxcH+7kwCNsD2sJ1fXdLE1PGiwcN6CWO/WG8zQapBZg8K?=
 =?us-ascii?Q?0OeAiARZaDFq8GOIHvAKqPSAGNZASsdgwLiNeQ3U+/3qiSc9Z2RsHWDxah8b?=
 =?us-ascii?Q?6nQs6zX/ddCPxm/4XPAmK96AoS4a2aU4QGhOILoF5D5s/xMxZccYZpB/TK9+?=
 =?us-ascii?Q?qOU1yHXJIpyW8vt8/fowVDjWt443mhRrJYWURGJv9d3aHv6OwKCwcQAeRNoB?=
 =?us-ascii?Q?dwg3mecS9x+d6vJH7zYIdumMPF/z6Id3x21+bhMIh9ZzUWPKM3MSbLNhjhig?=
 =?us-ascii?Q?HBamo1HEA8caEbxIYue29F0V7YCKZE6TfsLai4rbNm3ffNMgiIC1t7ycpzms?=
 =?us-ascii?Q?MScrPJK2dMKx2Cq/x8gj3ZF42AcIBtpCz9FWuxbT0eV2RBVjsbg+lcjHqc/Y?=
 =?us-ascii?Q?O+1xIoDGx+koSPzyCIqKr0RM5sExYr/TpAV36bm6rJ6l9drDKhu+wi2BpyLt?=
 =?us-ascii?Q?lVlcUMtz25ZTcUAkOGUGFZef0iLTQh11MqkvWWukYnmKr3npMHrjdW60e4LZ?=
 =?us-ascii?Q?UeK7W+CKA+yONs+RX4x6lqOgvmBKTrXQs54v0/IaDuy2OD400jHtKpzMheSK?=
 =?us-ascii?Q?tno3VovAAVS1rKf0o5kZPzsm0gwD6ayji9uA+mCkQ85dJ5duQG/W0KmexLOO?=
 =?us-ascii?Q?pzUQOJpsZldiqlKcponvCojIGuwgJhkG5pagsFJbPT6qGfjYVJaC+CMC869O?=
 =?us-ascii?Q?ki5DwJJbXsXZmUbTQQ+bqSAfrHdC3kyvzyf9gSvtRGIs6Oj59zYIyGjk3w4y?=
 =?us-ascii?Q?/fl0ZsYdAqdIbsFv5/vZwmrC2H+FlTHCSFmx5i81dIIVeyc+LPbHzgykICXl?=
 =?us-ascii?Q?iBoFscH4fkITo8cthDQJ1WgGynNF2bE1DdaxWKWOusA5uawR4lzUXRhSKaE3?=
 =?us-ascii?Q?vMWvIiiwsTwKvwPzyZzPXgtYFbX4LW0hqvyxJVoyaWVx2lRFjfaTqHQd7J0p?=
 =?us-ascii?Q?fjL9Q9tpHTf5OnZa7vN7SCrRLoO2U3Mn1v1mMQ0CqNNUEYY1or2tySxMEjyg?=
 =?us-ascii?Q?2XholFUM917j6BM7AGUHCZD+7RTwGucIv+UiC/qCp+m4NTrxybfRdKCa1Rz4?=
 =?us-ascii?Q?M3MYHm16igTBghBtYNVU2xWlWWaM4wn7eohDs59YkSy4+s5+X8HfLdHRY1gq?=
 =?us-ascii?Q?0xcX34X9UjmnC8YmIn5f+VbTif56GuIZLQztspasKjPZgIReap/9FUiFvZjV?=
 =?us-ascii?Q?Uug/lPhvaWsiKFW/TQA3kOeLuLy9TOqDNGItI58M0rDiFzOyjjrv577+XmL2?=
 =?us-ascii?Q?cNvvycpmj3iwjZ0fX/yWS3jMeTMzMU4lfz4d5tsxKpDSTPlluRAHIKji6OzC?=
 =?us-ascii?Q?LEshOjQ1chdVkbv9OtZH4d+eurPgJGz6CPEnauRvHGbjN6jOtC+eocYqRQ5m?=
 =?us-ascii?Q?Gsf7CUvJ7xwLqSRcB+eBDasXWHcFMtlF8JKhVUBjJOrBscOZ1xK4N67zqcw9?=
 =?us-ascii?Q?Z3feqAp6CXVyBAbBXnB4mEn8Skg6kACvZ8qjv3jtUWJg7j9acTiDT9CQ8/l0?=
 =?us-ascii?Q?RmHwdT4zI/qb/7V1NwndmYg=3D?=
Content-Type: text/plain; charset="us-ascii"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2680.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6a7fe8-5a85-44a9-0009-08dc2e67ab68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 20:49:57.1664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cBISpL6n41u5jBM0m9lCs4OF+tSUyFs2303GbYDuqdH+uE+QalDIsRDA7g+1VYOmBZksq7upFFzPhuL9EfEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB6361
X-Proofpoint-ORIG-GUID: J-gbhu67wLKnkEA0IgWzRtXnGKlUx1ed
X-Proofpoint-GUID: J-gbhu67wLKnkEA0IgWzRtXnGKlUx1ed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=77757e4ce7=lesikigor@meta.com;
 helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

I have a situation when I need to use third-party 32-bit RISC-V CPU when re=
st is all 64-bit RISC-V CPUs. I have seen that some steps were already made=
 in the direction to enable such configuration (https://riscv.org/blog/2023=
/01/run-32-bit-applications-on-64-bit-linux-kernel-liu-zhiwei-guo-ren-t-hea=
d-division-of-alibaba-cloud/), I am wondering if someone can shed more ligh=
t on it.

Thanks,
Igor

