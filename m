Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBEDC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 20:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiJ3J-0001Jw-Kv; Wed, 12 Feb 2025 15:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gil.barash@hpe.com>)
 id 1tiJ3H-0001JT-Bu
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 15:09:43 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gil.barash@hpe.com>)
 id 1tiJ3E-0005ZI-4C
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 15:09:43 -0500
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CH2IFd006379
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 20:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps0720; bh=W72MqTy+EoEWjQoZBh+0Pwk5
 gUO3EkW0BcWScRuPiZQ=; b=ONfUBvQ6tdcqal2bPa5azxZ5ndOI/QbB9uTGxSkw
 /roSTzbucbpe7Ton4y8grbHD4I5HCuxblLCZtCs2ZNqTZG5ghM1xjvDiVffyF642
 PSVuhPR37PMDb4wrqZQg7h2cbIeWhOJ6TTpIc31gj9gTvzNChlx30A9p8amh2LeK
 +JSUc/9gZOxrHsOGfAT+RtL0Ux4lDTqB7gNf6fK/BbuqO+9opjOI4Dq0BZDCcyx3
 IqvGPIEDB7Oh4JfLh7GB0sB4XZBXg0XEBArWqllpPxsS5658zGGtKtUOZhT66q2f
 d33BMvR6l7T8bJrp9m7N0IwjTlwtTL0pE6rDrGDBN7LodQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 44rup1kme6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 20:09:35 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A9F41804789
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 20:09:33 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 08:09:22 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Wed, 12 Feb 2025 08:09:22 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 08:09:24 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNtGfXSX8tqbaAk0+vzQBhmyY0biu4WacrnNua5+y8BcQhwgI4UU2qT9YWZNf8gUNxwiDiTumqK7daDvnfdPzy6560IvdwPe0fEuX37rm17Vmjw4yDdZnJijY65T1GRgKDzPr2I48PxBFbFXTNcSlU5V8KuV24PDSceZt2rTsumTR55e/Y4VkwQYlPUdXLhAeO41a73zw28jeOMjM/8fYxK7Dm5hRAud/7xOGU4qZo+spkKsSC6fi5KhjtKMqXbBSPNisDr6PY+AUgYklzwRMztpvRPj5gF361OdeS0CzUoKniJJ+LfsugVBTPweoO31nBrG9yy8LCiVqHWcBsyzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W72MqTy+EoEWjQoZBh+0Pwk5gUO3EkW0BcWScRuPiZQ=;
 b=miqCmW6vfpcWFWaJ4YHByUdZn8mwB3baIRPhkYNN3DAUgQKR6ZfwvgEm72HesCF2w8a3AymgNOHQ8SW2KtDzW7q7IyBnJgV62BmfTxm9qpd4CmGsqo4I5RpPsSuHul4GLH9qBMlqC2B59VoiKNxWtG3opn7MMviFXV+CZEVN/lNR7/fWcc7kZJBiCgLNCV2x7hwPi231nBK7DrBVBCtAEUzUhr2UPj1NoS8ukwY+wQWdgFjHSFrpm0dOL8lQfjg6AvjV0sfSByPsrrf99sWisXDhokho78ct2yrJtxuObcrWeBFs0uwEFMByUM0DZqNkP5+LLedTBegRs/GarpdObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::8)
 by DM4PR84MB2094.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 20:09:22 +0000
Received: from MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4ddf:9f6c:64d6:5bad]) by MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4ddf:9f6c:64d6:5bad%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 20:09:22 +0000
From: "Barash, Gil" <gil.barash@hpe.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Adding new block device filter for Zerto based replication
Thread-Topic: Adding new block device filter for Zerto based replication
Thread-Index: AQHbfYc98r3aujh/g0ebYf+/NY9SmA==
Date: Wed, 12 Feb 2025 20:09:22 +0000
Message-ID: <MW4PR84MB1706FCAD0C1F322D685B23488FFC2@MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-IL, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB1706:EE_|DM4PR84MB2094:EE_
x-ms-office365-filtering-correlation-id: 01a58677-234f-4305-736f-08dd4ba1244d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?btUtOeQw9rjNegAYSnCNnTwMRFPrYpaclL6KGcpG1AZbZ+IezDiSCiGPfZpM?=
 =?us-ascii?Q?mCQzOiNJlPh1hTMxCfBcgYbbgfE7sErMUQ1bCXPcOx7MWEcZe3GvmUGa9B/r?=
 =?us-ascii?Q?g5/tFRsim92Mcq0TcSUvuC8mWgP1Fk5Nh58X6xH6EmYvOYaWP15pfSw3v1RQ?=
 =?us-ascii?Q?wJ/JGV4FcGanvPWAlPtxneEOzjq6YfZtgQQc0rC/ABCmuNTC82s8zrq24fiG?=
 =?us-ascii?Q?2a/lpXREtjKMWhSJr5NWe0jOQfS0zCIx4B0Av9NsHt3fnH2p7JNzyRvEnUM3?=
 =?us-ascii?Q?i4yDY4gIZQrWFVMcI11dQWB8+4vS4v0YsIEwNQDGDnkPPqzwqqsykwK8sJe5?=
 =?us-ascii?Q?Ga+zZX9ancmClgZdXRpg3OkzveR5MkP8NxSu0aEv14pbKfhhNNF/icH9RaFK?=
 =?us-ascii?Q?c6so3yOaEC1mBJZbcVnl0IPvikRpnotLDKepLUi5HA3uAQps80vzX8dQZmoS?=
 =?us-ascii?Q?4BpWdom9cCePw+L2GntNVWpB2rLclQEdP/hnj+fxKb5BrflhT3NzNN8HfnHi?=
 =?us-ascii?Q?bf0FXqvqh/2c53XSVBblUyCcSb5kWdfF2THywzIlRkWoY1y5Oz7XToYlGud4?=
 =?us-ascii?Q?WTFI/ZJZIkXQG8lhl+clYgjFHvpOljmQUrhRsVtayXeDWrfAI/l4+oCU7A6r?=
 =?us-ascii?Q?5A13CEZnqtYPJ2s/1jiv1XXnqs5fDYF3OqHT8ZN7aaPYq3WEK/PZJJ8yq0xj?=
 =?us-ascii?Q?vspei81fr2bX7nZKpQ6Q4FKhfx6z2LXp/mlsRtTU1pIUp3CAOyBpo+I5v6od?=
 =?us-ascii?Q?JD0tTtf2jcGwI6lTgYUVVUqtGUiCS9l9cMAQ6VDD5wIjh7ylvr0ZHTasHMVJ?=
 =?us-ascii?Q?tNq3K4oW6exPeByBoGjPiT6Zy8bvL5gSQYifWsfYNvsbNGB9nR/QCRqnL3ig?=
 =?us-ascii?Q?l6rKX5LSrL4emsM0gvvSaLmmdEuftRwHcnUpQ9qUghdJHTnGwW9HdwQ0LIJj?=
 =?us-ascii?Q?JbyYKHQ7SmcLc5RFZtHs2jsENvK2+Kium4CW4LYpUlmeePU5m6y8xSVEv15s?=
 =?us-ascii?Q?SlRggJ8ovsRmHJTMk+MDOEGRRTb+Prb4spAzIfhR8z3IWa6MsMQhUPvaN9Ki?=
 =?us-ascii?Q?9cbFj5cHEqSC8W+c2cZoUMMnWh688JvKWzc1NP3/8PWaiaJBKrZ1ThaFzSK0?=
 =?us-ascii?Q?+Mo8SyA+5ACoK+669BBhx+WKopeAzpn3SYfx71hPeaN0yFTY7/t0gUFV2pvv?=
 =?us-ascii?Q?yXvlglw8hbgv+B38jg2QMnF1re1tqHtkrbACQm4aVpYlmvABrAAAsft2sMy3?=
 =?us-ascii?Q?OEAUoUaiuSnKwPUsAk9TaNkfvJSM4H4GSHQJRNee0qqsCdHg7kfA6/UhMvT8?=
 =?us-ascii?Q?8mhBbFuxEvylRzJ+4yNZ7DRQDChNA+N/+oB3UcKReAxR14HilQSJ7fRCJ7nx?=
 =?us-ascii?Q?Y1ZZYL7Y0/paeqYpDBOmTyoo0r/lkY8COxwL1KlgoL9lJTnDaYd7AXPqzXCZ?=
 =?us-ascii?Q?BfEdeAdCitUc79+rS9QiQkNdPj1L8Pvd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yqpud/2LOQ88U0oOHeVJaOmgQQ/0jNDUmPQ+pHZF5v1UHk2R7WZ09DhtxT3x?=
 =?us-ascii?Q?mBbMjzp3I0ztqMV6U2HaOYZ9WPWAfvSLSNC5TNwB3Dx0H9rDT4lU+T77ve9r?=
 =?us-ascii?Q?Sbt9k68DRPFQ9w5wWZwr4TvmRcRrwShNcNsA1GtBONLZRI0BGYGPfvuOjw1p?=
 =?us-ascii?Q?gVmwCxAzJEo0uHeu/0Y4jQg4mVvrtRS3hjQaj+eWsqVgFnoWbyHh0OQ6qa21?=
 =?us-ascii?Q?6IczzWV+1sBlByd4r3qWWm0CjbMC27MRP3dHPT2Mm/9iHhfuOXKsVWAncyL1?=
 =?us-ascii?Q?o5YjmFS225iKnuUGoTl/nFXPIJ9LQozMZIGLQd8ECvlI7O6mMcLy58AnZ/Cv?=
 =?us-ascii?Q?Ve+bFUGQw+DX8fPmN/RqpjK6wUGsHKKkNDYVUiiOlM8cMN19ZUf8dppxYslH?=
 =?us-ascii?Q?/zjJRe9W6SoDX3mjIAwzPoAUjL/JMXh9b0P+3k9gaMWjCkgtjfcrCGkrCoyy?=
 =?us-ascii?Q?Aumjx8hbK42IBaDrjw1veS6tsHZtp6h3budziz0p/bLPM5Bisl6mGFCwGyj0?=
 =?us-ascii?Q?ipwx5rmpVMinSXD+6YvTEuiQAy4uFT3zemnYnBiWvtffbKJQMBh5kZnrG9r1?=
 =?us-ascii?Q?9T1TvyvJYgW0uZEaqyaPW9XINm8zWR7jnjRPEpU0YoKVeEXwWhruI/eWSM5P?=
 =?us-ascii?Q?ao5Wm2RajuSi0v9n13aRgQo6pYaIuds2itWjDHJF2waWWxi7Vge5DhN3jrgj?=
 =?us-ascii?Q?8mi7mXjuabaqzualBkrJ57i1doAAuw33q4vdZvgX5O9MdONAXmpSk21aJcH8?=
 =?us-ascii?Q?XKiskXXT6z/fWs9D56gvE2Y1B92qag24i30Xpe3TI0NwC0ZQAHthNuR8Ks1G?=
 =?us-ascii?Q?TAueFC8VUJzzzRot1lbiC9V8Xjhg7rn7zNxYJ7avoT1IyzbliOIzr2ms8IuD?=
 =?us-ascii?Q?XYeNLL6hfc8iJ9uz7yA58Q0+qdMu2egw6jmMxBGrDQeZ8IQp4FMDYxUtSjCS?=
 =?us-ascii?Q?L9M2uxeen844YMOY6R14SxOkEb0Y6NtUr+yTV0fNQBiTxmHlE9kIEcG1cZdT?=
 =?us-ascii?Q?3VGADVVaGe3QTeZicq7jnOs1fj4ib16Y6c9krhVGQXURiZiSzOvR96tRDTtS?=
 =?us-ascii?Q?mhT12yj1vPEkdU99KGG3CfB4moU34yk65ltYvBTomnTVYmMqAYNiiH9XIpy2?=
 =?us-ascii?Q?Q++IeONb86j1UUgm+VVPYKJtq+Mf2HtlVWSC7WuhkphrK/cBAtZbiH7QWxrH?=
 =?us-ascii?Q?8aQvqAw0iADubm3B8j8N3RY99IQCMTs/7tzBHEgFYbhfmX4DlvVmQfIs59LT?=
 =?us-ascii?Q?/1TtiqbTWKNEaYcPcihP78+UbCqzyqe/FAZlkZ6lD2dS5vD0Q6oxs2QcslBK?=
 =?us-ascii?Q?dSV6KrbBKPzmfWmBjDGQqCdZxH8igHvrTLQMlYyjYIYOGqZmsy/nsJ0ILH0+?=
 =?us-ascii?Q?Ie5PE0cS698oIROgAftqMS6kzJokliqRYglIt3vNx6lpb6NGvIPuXuNOFqg+?=
 =?us-ascii?Q?+WC89J7Ib6OxY+pvC3kHDCFm75RwFR6DJm40696qHNe7D8QwW49nlbswh5hv?=
 =?us-ascii?Q?WPiirm34cIrm00K2NvJp1C3KeTu59whD9+o+jdRhHHtP6b00yvvy/CpgUqiL?=
 =?us-ascii?Q?jAgO85tDeTcNtyZb+Sg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a58677-234f-4305-736f-08dd4ba1244d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 20:09:22.7268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5f6whV5UpW37P/Krl1575PdRkFe3ohvI2n7kncFT4Usql6mItYuQ8rlsyQb0gRE+zBUQM9cD/7LoMmk5lLWv6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB2094
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: b3W7vi5y9l4P_Zmr1tsMJAN4U-lt1ktP
X-Proofpoint-GUID: b3W7vi5y9l4P_Zmr1tsMJAN4U-lt1ktP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=622 bulkscore=0
 impostorscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120143
Received-SPF: pass client-ip=148.163.143.35; envelope-from=gil.barash@hpe.com;
 helo=mx0b-002e3701.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello members of QEMU dev,=0A=
=0A=
My name is Gil, I'm an architect at Zerto (now part of HPE).=0A=
=0A=
Currently Zerto support block device replication, with 5 seconds RPO and RT=
O of minutes, for the VmWare and HyperV platforms.=0A=
=0A=
We would like to support also QEMU based hypervisors. For that, we need to =
create a filter driver in QEMU. This filter would provide the basic "split =
IO" functionality that Zerto uses in order to perform its replication.=0A=
=0A=
From what I've seen, QEMU doesn't allow loading "external modules" (am I ri=
ght?) so we need to embed our filter with the QEMU tree.=0A=
=0A=
We thought of two options:=0A=
1) Write an intermediate filter that would allow us to communicate with our=
 "Zerto splitting" filter. Has the benefit of decoupling the "Zerto dev cyc=
le" from the "QEMU dev cycle" for the "Zerto splitting" filter.=0A=
2) Write the Zerto splitting filter as part of the QEMU tree.=0A=
=0A=
Looking forward to hear your thoughts.=0A=
=0A=
Thanks,=0A=
Gil=

