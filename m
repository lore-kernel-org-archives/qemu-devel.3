Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9A3C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyw8-0005BD-QK; Fri, 31 May 2024 05:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sCyw6-0005B0-Pv
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:52:34 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com
 ([40.107.236.64] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sCyw4-00040a-KE
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:52:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkJ9VX9vuLrP3rSNX9t3y1boUPu7qpiVBA4AzhxUcJFmcZ5wjvjlQ+GC4EmMlQ4QqUVP5fbked7adAarZ3qlzmg8e5QT0+nXBcuj0gsduIOIQyXPIE20IpogFpRM06eIU23EBeyYjIixubtTRrtjw5QGsowsfzbcDaLnmtY5dnZYkJ62OOQBwiFehrtDReM5iOFmL0smPre3NY4B3DJJxiOSD8SpDYajfpmoVe29StIEzWT7ArMPnSTf5udxQ4j+VZaMtf/BSCkpJ7mECGKpa1ktFnXPhBrQK/JUdAWs1Nc5PbhbXnZX8Pf5+bBxcJX4xvF/x9pxLA45buxeHHhX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1eLaqqjEFxsig1vYkLz9M1IvOiNKjkMfbbUayZk9Rs=;
 b=Km5iZhQch6AnSOICZYN1hDmxap66pv3T2UJXljR3UQcxkxdJvP9UoIacFdh8fqw1Wf373JOJim3R48LosdY02esGh3TIkHOxlpc+MZy6HTnEW2vyhi2o5doRsdn1ypdEaCzK1PMRTSFA+HD0Z6pIF76ZgcAf5cZtjQIUJDuKRRUnJ1Xbb26hZEBBpyCBoortiMXowIjKN0I4XqkvGnPlueyuJDTzYMVhi8bt44bWdql/Q2GVoRtym2zbbft0M/Vs0ExxmJ+f59+roPvUGoCpyooQFKw0J/+E4j2OtJO+xhUhZS4/6VgS/Tn/aUqTL9o+OUerBiAaSF8qF9ODVpL9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1eLaqqjEFxsig1vYkLz9M1IvOiNKjkMfbbUayZk9Rs=;
 b=IYnftLuQG0Bg27Ev/+pTjLzv8WdSDFpCHO58Y8c36CCq0HeUE2ErIhhZwdLcWM4rKBawqUZQsuRsuyriY+7rbpT7gNyz+nz0fx35hF+9XmJE++ZCm5Y0KisU6Fl6o5QkXiOaaC4qMkHS0QMrJkO2YjS3LViAa+BbfqN/7+06r6c=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 09:47:25 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39%4]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 09:47:25 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "Myana, Shivasagar" <Shivasagar.Myana@amd.com>, "Iglesias, Francisco"
 <francisco.iglesias@amd.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pisa@cmp.felk.cvut.cz"
 <pisa@cmp.felk.cvut.cz>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Myana, Shivasagar"
 <Shivasagar.Myana@amd.com>
Subject: RE: [QEMU][master][PATCH v2 1/1] hw/net/can/xlnx-versal-canfd: Fix
 sorting of the tx queue
Thread-Topic: [QEMU][master][PATCH v2 1/1] hw/net/can/xlnx-versal-canfd: Fix
 sorting of the tx queue
Thread-Index: AQHaszQ0skDL1mcz4EKsXV7gyu/dOLGxF4dQ
Date: Fri, 31 May 2024 09:47:25 +0000
Message-ID: <DS7PR12MB5741F5CCA0422697F6329785B6FC2@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20240531082605.2306976-1-Shivasagar.Myana@amd.com>
In-Reply-To: <20240531082605.2306976-1-Shivasagar.Myana@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|BY5PR12MB4225:EE_
x-ms-office365-filtering-correlation-id: ea6b8283-b733-401f-1103-08dc8156ad60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ySY9yYjCN6R53r0SHptQ9hZfOOrXjau7BvJxuOBeBKXuSXQTCkpVPz6r/h5d?=
 =?us-ascii?Q?dK9g9nQucp4oTGA9R2w0xOy6vf8XISVsn//qKLxPjQjGK8AVCMEaxR61KnM4?=
 =?us-ascii?Q?X75Yq9ZeOM0sqyuQKUgspayD/QqXDzh+NyJlrLbvdTTCeU6GAc3XQKik81XK?=
 =?us-ascii?Q?LgcVdld7FM7ZTKyzIDa2C1mkeLlbUzSHtX/XrBnIf/fG5w7RiaEt8QaLETkr?=
 =?us-ascii?Q?sLmTOoh4XymAYbv/+nAPHmQ1SIh1rS3FNHTfcK9I/ePhgtn6CUKVvlJ0g+Xz?=
 =?us-ascii?Q?GO7Z5xp59vboUhObt6myJnwccgUAMxuNTsXnBNDwW35nGv85a6X2xkywG+Xr?=
 =?us-ascii?Q?84BBsL+xVxCiOnVnwOVKgf6eh1KYM00PxTXdzp0B4dkAjcsodUsGNnLCUASY?=
 =?us-ascii?Q?8Luz5MnMj69/N3Hcx9+S9E/mLXI3ErQ3ofNF71f2+FBgwBCBa0L6Uc+e63r/?=
 =?us-ascii?Q?X0DS/vh/1m0MrNE2VwQQU6l2cVthm2eWBrTnYrcZLbkAv57yCc4b8XhGJz/0?=
 =?us-ascii?Q?TpzeLJfWbMZOq91wIQ3aelv2gAC+GWo0SHegw5ZhMBSAVyaBRVwcYz/ATsGM?=
 =?us-ascii?Q?ep1g28LaLsTelpCYM86I03z3gTycKpoWm4KfGLxhP9GpuglgKpq2J0yglk9j?=
 =?us-ascii?Q?pS4fHUHtF+8/SSvcYtEPczhORu3JAmKvnC1Pet7DkScTbHJ5MoZdCQE2nAPU?=
 =?us-ascii?Q?PrpWws4jREQzVFnQLWMSea/uqkDM1MLpX3KKXSfC+2kI7Dt4MNSIK/e8lpZ5?=
 =?us-ascii?Q?b+OAgLDKETX9mXKUicsEQ7J2FUJWgqJlcxux6E9lMRU4pim5XJ6l5sgmQFqt?=
 =?us-ascii?Q?SshNaWHPoQH+gRWKdl4tbZg874TJWgtq1QAw/ucryrPfaxNhE6YVw924huSm?=
 =?us-ascii?Q?vl29iKrCx0kBc/JDwPENP1rVh7q7RgBV3/KQ8gE6tu6ArZjfcPnt2X9ERYtN?=
 =?us-ascii?Q?HWAKdw1hNfELjV6kkCXPatTgZ6Z6pYIMpbGWPv9UfHNDOQxa3OIMlxmXBx/0?=
 =?us-ascii?Q?JzDbDjusxEiIZJ5NfLAOyQM/liTqWMKHbbsXi5MBWyrcTfLVbazKC2oChv8+?=
 =?us-ascii?Q?rvXMwvfRxU/6ZIZwYSNiB/zkBZH4Dz3nW/WttF9f2bu5KM0IRjGnCBa2mtNb?=
 =?us-ascii?Q?tQC9ITTyNXOtovb5F4UZ6dSSDapKE2OMk+RSJZsOylU19Dxc43MLbKgphMRK?=
 =?us-ascii?Q?K7Wu87IP0R4VWFmsyWp+jJS1NCJwfIz9IMILn3nF1Wl5KQJA1pkqfPzB4K7r?=
 =?us-ascii?Q?7JUt6VBhqVwUWN+B8SwR8J3q9ruJneWP9Mqbnqz71Cf8NXPue24yO6A6bqQq?=
 =?us-ascii?Q?PTerRbUxwBfqibGiKlPU53MhvJB3ef+ip0P+d2inYFzsxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wLNmJPuAf9q500C44ypJkgP756N9LheR81o/f/SYmtLG9f4bX3SU120E9fOM?=
 =?us-ascii?Q?QiK4TBsH7PjEcd/RWDmva+IWLRDBYMsXuxT1Qnbru4MygMII93IBiocSnnHq?=
 =?us-ascii?Q?lmoD0VrUmpTPQjkK/HFlq/iUggqpzebahPRy5iJJVYCuFEhMeLvQn3BcdE3h?=
 =?us-ascii?Q?KDpo7g3W/Vl6QBwdfn1N8RdPlSo9ZZdsXThvTTytpBBfxqU+i01rXdcNJW7D?=
 =?us-ascii?Q?T1R51GFx/tPRtmVdPMSAmItEhZRMzlkf1Koqvdzn8vrKQXqQ259KT19YTzJd?=
 =?us-ascii?Q?JM4yb1LIp/cHgE+TynKdrCEm8wsOcsX7W86oS04eoKqK7W2oJJ5UFEBziYQv?=
 =?us-ascii?Q?KuaVu+kk5U8I155s7IGi48eo4sz+shUEY3QqthBT/N3YmfEDK8dAgvVF1nPr?=
 =?us-ascii?Q?BE5VuTqwNOKvyJOV/FJjfLIZrjqM4Zq0EXWPyTGSXaf0yYcas5IYigerP8vF?=
 =?us-ascii?Q?R1lp0gtURQo0wuysz2Ip4hud92MCI1r526K7wKu0Rr/V+DNrAJnNKtbdnd8A?=
 =?us-ascii?Q?Hgjal6K6f4GYKSBtO5DIXy8DK/W8bRPCVAOH7CqwETl0+9nleqztxZkCLbdK?=
 =?us-ascii?Q?vw1ZtAaA/tc2LTjyoPWzIs7LL4u3SYqVxwlAr6hEG6MmglLP0InUyPdZrhRJ?=
 =?us-ascii?Q?GvkcnL/jWYycltSsBp6Q4Exh0xOGyZFzRjUpE1tkajO5NYvz50tcrfElFU0U?=
 =?us-ascii?Q?9YtCfzyDkIkHQprhqlKsbJbinX7RTi7tDkuCOW2Sr42DB0XMJ2mTbzr500G2?=
 =?us-ascii?Q?2GtdhFNqLraFRMkWZqjSaVVJMHULtR/lQHIKki6bj3Gs9GCfBzQ5ei+vNvvA?=
 =?us-ascii?Q?nbgsKYaZwc93XKQ16OcqFSXCc30LcCcxw8iV23ZMbL1caUVfwUb/uu+HadRw?=
 =?us-ascii?Q?RIee1aWRFLuG/r3EKVfCo6JIOQk+3+g0Bw3PC8w4rEOnOeSb83gl3XDMlOrG?=
 =?us-ascii?Q?WnR2bFRt9cP5VZwRXjWr9qbT8jWxIGRtdn7RvOJ4VctOvXtMK1NaW14A9wMG?=
 =?us-ascii?Q?FhLWD/M7a3VWk/30BmJDNZtMJbVQeVzNrb+G3BO4Zv1BBGtD6RnL5QdtFuMW?=
 =?us-ascii?Q?gAM1+nNJul29JaIY8uTfh6VQwbyHSJ2+KXUqELQVQCbJG10ROaTa3T98U5IR?=
 =?us-ascii?Q?hkxX2R45JtlvR3tS2L8l1U7+8BU9z9r9fvcuzh6YcKkOTGmCVWOJi3+nOnib?=
 =?us-ascii?Q?E2EmeB7nDYtoWUUdfzpRPgGVA6TELGJs+Po5WzWkIhoRafs7C6d2q53eSUtx?=
 =?us-ascii?Q?bR2hMPYKgdhDd4k3Vv/Fq5vAt8OomE3Nyeo7poPpjv5zi7M0OEjnQUkLjb2V?=
 =?us-ascii?Q?8OxkODihYu12/dIHZWam53KpJXvrPKkZ2lOVZQj8Wo4PF2z3/BM/vFryVA6R?=
 =?us-ascii?Q?KWn1sa1jAHKCNrlaW1jsz2H0GW85tXRrDE/+wK0lbXIyzM1diynb8AoDe8u3?=
 =?us-ascii?Q?EhYB8/1TC414S6FBgj6sU7C68WPhSqw4nWbOLjv3ayRHMPX8gjiyJ05FlkVZ?=
 =?us-ascii?Q?r/HtUwX2mtYWvBUlro+6KTedQj0yGNVFNxCTUbv+MRql1Vsp/VcpRlIHxVWs?=
 =?us-ascii?Q?ypBL2fHNVoR6VwUyUio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6b8283-b733-401f-1103-08dc8156ad60
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 09:47:25.5446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qe0MmJ0G0mCRqKox5gAvZOqWtBhBahSw841FnaByea3IYEwQSybWaZ5lDNcZcxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
Received-SPF: permerror client-ip=40.107.236.64;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Shiva,

>-----Original Message-----
>From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
>Sent: Friday, May 31, 2024 1:56 PM
>To: Iglesias, Francisco <francisco.iglesias@amd.com>; jasowang@redhat.com;
>qemu-devel@nongnu.org; pisa@cmp.felk.cvut.cz
>Cc: peter.maydell@linaro.org; Boddu, Sai Pavan <sai.pavan.boddu@amd.com>;
>Myana, Shivasagar <Shivasagar.Myana@amd.com>
>Subject: [QEMU][master][PATCH v2 1/1] hw/net/can/xlnx-versal-canfd: Fix
>sorting of the tx queue
>
>Returning an uint32_t casted to a gint from g_cmp_ids causes the tx queue =
to
>become wrongly sorted when executing g_slist_sort. Fix this by always
>returning -1 or 1 from g_cmp_ids based on the ID comparison instead.
>Also, if two message IDs are the same, sort them by using their index and
>transmit the message at the lowest index first.
[Boddu, Sai Pavan]=20

Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

FYI, this part of subject-line "[QEMU][master]" is not needed, as we target=
 only one branch here.

Regards,
Sai Pavan
>
>Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
>Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
>---
>ChangeLog:
>v1->v2 : Subject line modified.
>
> hw/net/can/xlnx-versal-canfd.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd=
.c
>index 47a14cfe63..5f083c21e9 100644
>--- a/hw/net/can/xlnx-versal-canfd.c
>+++ b/hw/net/can/xlnx-versal-canfd.c
>@@ -1312,7 +1312,10 @@ static gint g_cmp_ids(gconstpointer data1,
>gconstpointer data2)
>     tx_ready_reg_info *tx_reg_1 =3D (tx_ready_reg_info *) data1;
>     tx_ready_reg_info *tx_reg_2 =3D (tx_ready_reg_info *) data2;
>
>-    return tx_reg_1->can_id - tx_reg_2->can_id;
>+    if (tx_reg_1->can_id =3D=3D tx_reg_2->can_id) {
>+        return (tx_reg_1->reg_num < tx_reg_2->reg_num) ? -1 : 1;
>+    }
>+    return (tx_reg_1->can_id < tx_reg_2->can_id) ? -1 : 1;
> }
>
> static void free_list(GSList *list)
>--
>2.37.6


