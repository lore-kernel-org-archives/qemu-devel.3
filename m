Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD2CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 06:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQ5s-000282-GE; Mon, 24 Nov 2025 01:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNQ5q-00026x-Cc
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 01:30:34 -0500
Received: from mail-southcentralusazon11013018.outbound.protection.outlook.com
 ([40.93.196.18] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNQ5o-0004wq-8P
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 01:30:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCErjB2zXUD8od8eJuRW1JF8ykWFpoN0oTxMK0BJt6Grp1lIVBSmAG/B4ktoyAJraTg8V9qfxYkajtoPKP4vAMvd3qRPpyVS4q1UJKjq9V0v1uY08YvRBy+hlkbe79bKq1DCt+CaCUJXy86TkhGaYZhT5vxwy2GdMJnyHFKxYCg0R7hroqFxVa6EI+RHFXDtE2IQaDUnht5S1VGYdl9J1qVuVAKoISQ21iUwTDS446fEsJD1fLcfxLuHr7nYx1N4N8bddzEHw4xCXQCfeE9hWFI6DiQ/7VfPo3X/bP+dMBn0wvq42/6rybCbplz5EPd7nWx7Ejc51iWoy9r6a9dL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8JFDJDyJE03Avfgxb16MsHAMf8Nr/o7p3JCtIsONLo=;
 b=cVTjgGK5awVtJrjXGdCNiiifCfDRU4cVT5kk+E3b+Q/mtVbB17sslKTKrPw0etCCGnhwt3NpAMxMsllLSz2PPqXKKSfzdk7QQ3oA+MwKvfcoV90zJ7PjDmDYSJDxmWVyMNHpYT6D2qaDMPcONIxo8/MPWGUr0GQljUXo16/ZXGyQv6oslY6yGt90x/Gk3pgYA+O4Wlam34EAaZ60M11x0XH216QSa1rbObm4KCtdCXkulIoWfZCfmZZNT8zYSO61LsjOBo0nkEX4MPlsASGNwHP5VIqUM2pkigeRIRftCFGruI3mIpvOt19Q9pMlTfY0Y/49YhD/mLy29GGYebR4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8JFDJDyJE03Avfgxb16MsHAMf8Nr/o7p3JCtIsONLo=;
 b=LARESGxf1TEq+kVDMRUCD5NL4wPQfKTiJj851nJljzVxePHZtz1P4Nlmzwshac9JBrJRIcHy6mTQOakwBw/z+RWsx0pZ2x9lqzKbN91mxfdYLOYm3HZCeE14qDgwkGYMHpVVorGw5yCiyZC5cXIqIEE4RQWQBf6SmgST/YD8FIQ=
Received: from SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:223::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 24 Nov
 2025 06:25:26 +0000
Received: from SA1PR12MB8598.namprd12.prod.outlook.com
 ([fe80::5ebe:aded:34db:24e4]) by SA1PR12MB8598.namprd12.prod.outlook.com
 ([fe80::5ebe:aded:34db:24e4%2]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 06:25:26 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Topic: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Index: AQHcWfouWB64eMRQxket8nQadjUeibUBYTZw
Date: Mon, 24 Nov 2025 06:25:26 +0000
Message-ID: <SA1PR12MB859833BB04DB9487ECC82A73F8D0A@SA1PR12MB8598.namprd12.prod.outlook.com>
References: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
In-Reply-To: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-24T06:21:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8598:EE_|MW4PR12MB7381:EE_
x-ms-office365-filtering-correlation-id: c543ad54-b11e-4e56-bc9f-08de2b2241be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?r0HM85COyo+JumtoYe0MiGOeXD6j4CytCSEioll/cM56OTEjLyeFmZOCFNxR?=
 =?us-ascii?Q?qJ5yUWlVvDk4SVeX0hFb4pbBR4F9KzsJHqlpaOxA6Z1yQ+H8T0YoFUm8urDi?=
 =?us-ascii?Q?glq4VFGhq63ZkCmYznLpmYoNbTlxZJbPCPMB7awuzw8MqmBq08Y9eLglpt2z?=
 =?us-ascii?Q?eL4OclDVxsyx/88+1X4T9O43AN5VnHyx2Z4q2x5Uy3KolIcggGt3qwze9s6I?=
 =?us-ascii?Q?nVNeKA8So7HP20QrT8PkO9KgquSBXFozoIle+O9hAEoxeWdzWB3ahM9JyPkI?=
 =?us-ascii?Q?hxzcCOHirJPW4GFWAlPR/Z26jrh9ZC1FGP6lbc4h67FXliyyED5JNklBUTNk?=
 =?us-ascii?Q?zMNaGKBtWI1TQXMVQScnUTXOR2iaW7l5Zeo4tS9WXzsPUA5Uj8AneM1H5CqW?=
 =?us-ascii?Q?b1YPy3D5UyqCdU5a2x743z3ly5QqGipoVRiQ+90tp395Pw+Fm8a9xWtqHafw?=
 =?us-ascii?Q?Y31qYDdjFqsLxR0gaRY+ukSTq2OJmVuf40ybF55z87amLskrSyryRok67BJ5?=
 =?us-ascii?Q?mKWm3mQQh+ksXA0OhLHmsXk14qbzKkVI91q4unWF4StzigmUH5AUfoajXwF4?=
 =?us-ascii?Q?603faZ88Dvlb0VwaueTS0pqQjF8rVZ3zuctTNxFYhv08LbAdodWhWP9BnF8X?=
 =?us-ascii?Q?HHj6bIRxLBrbT2rJJz//Pcc8GlYNSa29b6QBLFubNbdPsmXFYbGgC/H5iG2C?=
 =?us-ascii?Q?t5BY6nBRkVticGOzNnUxXgdeO4xQqOsPDJKOHfmH461MNA22qbUnWChtJcKB?=
 =?us-ascii?Q?/Bfj1URnWv1OweI9O3Wfgs0a/hmZCGFLhH6ZlPwushsztqKBptfCzr5hVv5U?=
 =?us-ascii?Q?SxLtGunwUl917T+gjwZYP0YXvt0OVHtVCjClNFb0BPNWIpb7JGC+E1jOydMf?=
 =?us-ascii?Q?DBLI0DR74H9eeoFolejVNPFSwtFTq3h62w3mbMa3AFi1EWPuQOr/EKkaujaL?=
 =?us-ascii?Q?aK2ysBl/BywH9uxz0g5q4tPMV9gool9pCAaRiyFHxcXERRr4pYqL9H379G7d?=
 =?us-ascii?Q?gwszCkOfBz2xH2gGGvfuCt8j+LdgW4bBTz5V8NHh2JJtQlFvaQS+G15Abmx4?=
 =?us-ascii?Q?q7eWnaEwF9Fg3v0GrRaxXOVwuYYJea3+tQ4EfLhBi/G/DIwYCZs6ZjplDLaQ?=
 =?us-ascii?Q?xz4/uM8m3l8MkBTNDKH+l3I1nYN5DQLQNYevBG+s5jj5x9YeV4WoseT0xiyj?=
 =?us-ascii?Q?akxlwWw6/8jHmetJrh572H5F3+rimVh33QwRAXmMfsqkv/wle+/j1IqCsMop?=
 =?us-ascii?Q?nRI9AGy72Gc5oMmBYFzZuUVotrwLjyLYp3Q7OWPnyNz2f/pyBAe+82xmgyXS?=
 =?us-ascii?Q?6W6+OskMb3qec35oXTIxcgaHFrhK2XI6erGdfVA/p4jRg1a/QAPA0AVJy6sB?=
 =?us-ascii?Q?V/Et18vNbNDHrX6qFmBU/cWOV49zR40admx9CsyTfnNURBm3NmCaf/VxjrOE?=
 =?us-ascii?Q?7ClFZrxv70V2Q40pYe9JXT8yXCASa23hPhRlC5Y3+oYjuQKtUIQOBQTozi0s?=
 =?us-ascii?Q?hVpfAXV3RQEFDM1Sr3hFEXsgGETSjp65rhH2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyuVXV//BBGRUpNOzn15svqYr4FHh0kORS4XkN3ZE1j0B106iLWeTWgQyJTQ?=
 =?us-ascii?Q?lBWyZQIQJprXswepE38Kl07h+S32P2q2V00XtaqFUhtuz0nMLD/Tx+ddDc0u?=
 =?us-ascii?Q?NdO5L90kHalrCd8DzRhXFTJtSqC4/pUpLVhMiMjd1cHWdxQAvNeI8qZmLJQU?=
 =?us-ascii?Q?9iETe94bSLhg9Kz1Yxir0QvO3BEBlE4IBYwZ3eIYISHdcOzeBxH1bVNx9Tt2?=
 =?us-ascii?Q?ifL8hk2kvLTlqHwHrg46au12I4UwVrXuuZa7SZ8nV3n5YN0TXMpDX82v2txt?=
 =?us-ascii?Q?duIMiny9lbhJwDsfsKohG2DYmab7F8a264xS8dwz5BQSD+ytQYRL1+nar7ek?=
 =?us-ascii?Q?7EtN9+p5P5zrT5O5NBF7vO6GO72l8lL47siNIUs3+XQG1aJw0K10PyvNLSbM?=
 =?us-ascii?Q?tNwupZ7vW3qbjTQN74h9Zn8jufbFZgnA0r2n2NAE1tGteyB7F41EYi8/MvJe?=
 =?us-ascii?Q?8cCH4NxhFUFWfSTBr3WTfxXfe2kuskW5/OS4l3xFYDU9O2phOfyTdwo9smOg?=
 =?us-ascii?Q?0Sz0u+T1RBfhclnvJ2CeH4NmbEFT1N8UA4k4vBDmekHIsKUlY0s1EmnhzE+7?=
 =?us-ascii?Q?GmF+Ilmrq7mImxDfo9oae3qYRg/SZ5B6/E+tVOCe2xcqTfRiCFZft3jNGY2x?=
 =?us-ascii?Q?aUEl1r7bsA9ZNzzw6Orjivs9nIjPEBgNqnfSsYOBvqZ3nTaEMGyKy1Q+Mh5M?=
 =?us-ascii?Q?1lRkyFyKpKx6/og1bEhUWyKT1JpHJf+PkMsx3llLXHDEpatSj6a1p35RcU6q?=
 =?us-ascii?Q?Mn1mG/Q+rKnwjebRSsqG6uovcj84e7TDksR2hr1JJ0KMNe052TTE4MkNJDnQ?=
 =?us-ascii?Q?vBJ8yLLvusuUT8zWypRg/RyrTbxFrRM9zgln126+zJ2Z/1wcLvQGWCZnKkb1?=
 =?us-ascii?Q?lEQTccjr9Nzp05SqYJt7UZTbMobMygHDoqaf1IS7RHu0Mdx3QbqHTbzQpUNN?=
 =?us-ascii?Q?ws54PCqDBmyV3R5vfrnyL3AB/kdjjAPS71rTD2r3tK2QOPK3wlwWPUjEgexc?=
 =?us-ascii?Q?BjJPvcFuSvsbZWnkEi6mAN2b8pb+H7jMzayPvotxE1MLXlbd/xHzZO5mvcp/?=
 =?us-ascii?Q?I3QyaJyrSUR2DX5tWMRchr75p17Qb/srj6zphDYd+dUTjlcEO0y+JkeIeoVM?=
 =?us-ascii?Q?HKpPatTa7PwqmZFu/VkGvODI051qCdENaGJ3nIPdVRWStsk3Fsm+3oO91Jj1?=
 =?us-ascii?Q?OlvVaJOhkSUnDz7upCllE7ZQMwJg9Ceo3BGcfPKSyCPmRzjPl2Qs815C2Oww?=
 =?us-ascii?Q?bIfvulSNr5cICGyu7YClw9sSrb6mDB2j/IOqJc8n9uY9stvZtX8BbR5km99N?=
 =?us-ascii?Q?0fVFcCLHQdYyKgWeq0n3O6C3OMF4jbdv1jBPZ2VLQJpOHYJzxaQq4zapKQr7?=
 =?us-ascii?Q?B8HmujjaZNJFlFqyej4k6s6eq6WwhS6n6cwqUHztzjgIvVRjxCNsQYYZrZdv?=
 =?us-ascii?Q?braqYaJgaNgWR0fdsKaI+TFOQoSZJu/B4SltcRwcbvDY8u5sb4XgbQG5Zopa?=
 =?us-ascii?Q?FGos6VwpBONom76OINjtzFFQQOjc6Ij44WeWM1xUzRvMIoaoucPVDNDAGKR8?=
 =?us-ascii?Q?20UrDXySiFwAjXkNklw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c543ad54-b11e-4e56-bc9f-08de2b2241be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 06:25:26.4967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fKxznIBvHezbcEKfwK+GbbxT5vyuY74Z4yUtwE4SKmmTb332mAt7q9mczInM4RALGYKmc0KptS50pNhXow4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
Received-SPF: permerror client-ip=40.93.196.18;
 envelope-from=PengJu.Zhou@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi QEMU team,

Any update for this kvmclock issue?

Thanks in advance.



----------------------------------------------------------------------
BW
Pengju Zhou





> -----Original Message-----
> From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> Sent: Thursday, November 20, 2025 4:44 PM
> To: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> richard.henderson@linaro.org; eduardo@habkost.net
> Cc: qemu-devel@nongnu.org; Chang, HaiJun <HaiJun.Chang@amd.com>; Ma,
> Qing (Mark) <Qing.Ma@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Subject: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after li=
ve
> migration
>
> Problem
> After live migration, the guest monotonic clock may jump forward on the t=
arget.
>
> Cause
> kvmclock (the guest's time base) is derived from host wall time and keeps=
 advancing
> while the VM is paused. During STOP_COPY, QEMU reads kvmclock twice:
> 1) immediately after the VM is paused, and
> 2) when final CPU state is collected.
> Only the second (later) value is migrated. The gap between the two reads =
is roughly
> the downtime, so the target restores from a later time and the guest mono=
tonic clock
> jumps ahead.
>
> Fix
> Migrate the kvmclock value captured at pause time (the first read) so the=
 target
> restores from the actual pause point.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  hw/i386/kvm/clock.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c index 40aa9a32c3..=
cd6f7e1315
> 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -43,6 +43,7 @@ struct KVMClockState {
>
>      /* whether the 'clock' value was obtained in the 'paused' state */
>      bool runstate_paused;
> +    RunState state;
>
>      /* whether machine type supports reliable KVM_GET_CLOCK */
>      bool mach_use_reliable_get_clock;
> @@ -108,7 +109,10 @@ static void kvm_update_clock(KVMClockState *s)
>          fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(-ret));
>                  abort();
>      }
> -    s->clock =3D data.clock;
> +
> +    if (s->state !=3D RUN_STATE_FINISH_MIGRATE) {
> +        s->clock =3D data.clock;
> +    }
>
>      /* If kvm_has_adjust_clock_stable() is false, KVM_GET_CLOCK returns
>       * essentially CLOCK_MONOTONIC plus a guest-specific adjustment.  Th=
is @@ -
> 217,6 +221,8 @@ static void kvmclock_vm_state_change(void *opaque, bool
> running,
>           */
>          s->clock_valid =3D true;
>      }
> +
> +    s->state =3D state;
>  }
>
>  static void kvmclock_realize(DeviceState *dev, Error **errp)
> --
> 2.33.1


