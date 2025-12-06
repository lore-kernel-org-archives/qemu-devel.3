Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0039ED339BC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 13:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRsT1-0002Vz-75; Sat, 06 Dec 2025 08:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vRsSy-0002VT-S4
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 08:36:52 -0500
Received: from mail-westcentralusazon11010024.outbound.protection.outlook.com
 ([40.93.198.24] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vRsSw-0008WT-Hl
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 08:36:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0cOQRxpiLVeKVq66Xd0Gwlbs9A37jkgQLbEyDxbkxgSZkTTLbEVSXRZNmda/9Hm20a5sBOB7pAy1U9IHx1MTClWvKffEzAM3XZJe4rHBm3Td6yCnihYOKfbh2c1MxXZosQZa+ZWroKKjjUbIOzSGmVutD1rpiBVcpNZ3Omd5GavW005y6ugH+PhZqalo9oUOLsyGYG3z3dlf4frSJQ9klTuKARG4q1URc6jbtYvRx42frMjXFErtcLj4kNbrK366mRcn/9mjDlBOnUMVJ3uv6UZBd5Rkgons/nP07bFWtaXjDX7ep7QjEPCpg4nBYDX6KLjj2+7G9Hg0wvDB/Nl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+UcTAVZ8BZVQScZQeXXIlwAvKBYF+VVhsnIegkMSG4=;
 b=jtF9wpYuLXyuDNzv4CC4I/eO03K9wOY8mZXxt1qEhjkslLv95CtqBJETcy1vNPW1oNc4zZ3QHSb/zoXoQ4+/Jv4N3oYUAwi5xg53MFqp1MNSItjSUCPyFXSlptsPsjhgB/kqw0+VRQMNeQRJwji46Qil9FhB5bGT7YXc8Tt0BCJDc8Vr6hUO3ijQzQs6JJfROYpdGwtIkAcl4fU52aMlnU8wJnK6LRdqSXR7WmNgr4MfP8Bi3qzI7u5Nag5W1v/O77Hw6bJF+XrUNZeGHJTWKHlwfEp4NqJC8gYPcFb4lCVMtjWjyvS9G/v3TISM1nx6uMl3EiNZdUh+QipNTV3Y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+UcTAVZ8BZVQScZQeXXIlwAvKBYF+VVhsnIegkMSG4=;
 b=Zk7wLmmaoEcPeRcBL2QuaSjLrPQ00HkpQf0YU0izyY/rLN1XMCy0ePH/e8KZfXdxe/8VFfNqw4nm59qggimVqrgmu3EC7N+jTbj2jJZvtKQK1Mhs52e5aXYzP5L39Yr2CRcVKTIZP4ODYMgpuePXItbtRKtmkDVhKcPObc0yILk=
Received: from PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::7)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 13:31:41 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::e5) by PH7P220CA0164.outlook.office365.com
 (2603:10b6:510:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 13:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 13:31:40 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 6 Dec
 2025 07:31:39 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aTAOLP0m8HN_Iw84@redhat.com>
References: <176359557511.1845377.6752982148248088074@amd.com>
 <aTAOLP0m8HN_Iw84@redhat.com>
Subject: Re: [ANNOUNCE] QEMU 10.2.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>
To: "Daniel P.Berrangé" <berrange@redhat.com>
Date: Sat, 6 Dec 2025 07:27:03 -0600
Message-ID: <176502762303.2988673.7534268946968218180@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: f9489313-685f-4092-e557-08de34cbc9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXV0MmtyM2VFR29sZWx2dkkybjN2c3R3NE5EUFZXRFZ6aUt2WGx1VW5EUlI1?=
 =?utf-8?B?YURaU21NNjNtbFNPa2w3SzV1NU9BOU82ek12VEUvTzFhSTd3Njg4ZG5xYmZZ?=
 =?utf-8?B?am5yZ3hEUUVqb3pDcmxNNFg1TEVlYmd0MmNmeEhoVDZNOFJKaHhUbkY4bXpO?=
 =?utf-8?B?dklCK2ZkcVRUaHFoaE9TUG1XeXJuR2EvenhuRVh1WVA1cnZURmlOY05FbWpW?=
 =?utf-8?B?dUZhckxSNXU1ZGY2OW5PRzdCTmtxTDhGdlhiSnkwSEg4bHdKS2ErSzh4bWdZ?=
 =?utf-8?B?VU5vYkhqUWlxbzYzcUdzNU15aHJyeittNG50dWRGOXZsOEQzUU5FWHo0SW1k?=
 =?utf-8?B?TWxMS3F2bk9DaGcrblc5MW1RdDZ6YmIvL2kxMUNHZzcyaWprMXpFRDNjWjZ6?=
 =?utf-8?B?a1RidnJJM3R0TmJPY2tsaDB3Q3FjalZGMVlLMXpGVkZ6c1V5Q09Yb0lidW9H?=
 =?utf-8?B?S2pTdVZtdFZJRU02M3JvaElqY1l2bm03MDg4bEMyNitUWVYzMlZ6czIrQThW?=
 =?utf-8?B?MCs0d3V1MmFBRWUvUW9yWEt1bXlidUR1L09VOFo5T0hDeXFHZGhRM2doVXRD?=
 =?utf-8?B?RTQzZkRBQ0c0ZVhzR3RobFBiK1hMS2g2eHNUTXhyVzh5QzVEUWZadE1HS3R5?=
 =?utf-8?B?dmxDQ1M5Nm9wdTM4Qk83anduVWhBK2IyWUZaQjhJc0NKQXF2eDBxaG1xODkx?=
 =?utf-8?B?UDMzdFdlRUJ1VzhEcVN5VW1keVZVZWJhTTllRFJwZ1I4RnJmMHlZc1NVb3Ns?=
 =?utf-8?B?ZnB3UUJhakVBQmJhaVVUSlZhNjBIdVBUZUEzSy8rU0RrUElPaGNNZGg3bVls?=
 =?utf-8?B?TlJSaVMwR1AvMGZtSG9ZeU5zaXhMM3h0RGpQTG1sQkY5emxidTNSNUtkSzdB?=
 =?utf-8?B?UHhTdDNJSkRuZkNRWUwrVWg1NkdaUXNwSzFpYmJUQTBJeDhyVFJwWVh3c2xT?=
 =?utf-8?B?L0lZVlhCU3VSUkM4OU9TbEFrSWQxdFZpdmNDbDFwMWt4YmtWTndvdHorNVRT?=
 =?utf-8?B?bWl1MlNYdGY0Mlk4aGxkNWcvbUhzaDBEbnFwTVRVTjZVMlJ5NE1NbVhvaVU3?=
 =?utf-8?B?MmdKcmltcjdFd0x1WjFPbWxHVEpTUi92YTR1VG1pYWM0SFhodVVWT3U3TTVZ?=
 =?utf-8?B?NjZFU2VUSnZydXlPblYxNnVrMTkrUjdVV2xQZWZCTitIaThDR3Q1UHlCQkZ2?=
 =?utf-8?B?MXhKSnVndDkwczZkS0xzS1puRkxZV29RMUdqc0FYeVZKREFJbFhFLzVnd2RH?=
 =?utf-8?B?U3RLLzREb2FXOGFHK3E4UmRXd2s2bW9mQjUrNGQ3TW0zK1Rmdzh6c1VoTjYy?=
 =?utf-8?B?aTZMSElNeHJJUExDTFYwZVg3Y3cxOUlDejBDQXBJWitXYWlqdHBtUVZ5bXdK?=
 =?utf-8?B?TVpCN01JTVFPaXJldGxielBJMXh2VFdQd2xzcDJZbmNYa2FWMEpoMDBjV3Bt?=
 =?utf-8?B?SUNKKytrUmo4WXc1TkNoMDJUaG00Y1JKditNcHByQ1I1WUJ5bmoxRGZxY050?=
 =?utf-8?B?aWwvL2twaTNoNXZrWEtwUVBWajNOSU9RTndzMEgxMkZ6ejVla1dpb2podkpE?=
 =?utf-8?B?aXYvRlRZRXpyM0ZYbUxRb1E1eGM0TndESk1nSzFvQVJHUyt3MVM5ZjlMb3FM?=
 =?utf-8?B?MlYrREhTbXdPc1pidGJlREY5LzNEb0NIWW93RTlxYVlQOUYvdlNqV01RY09v?=
 =?utf-8?B?QjdoMEd5dHZnd3hRekFUbHMvbm1vTnFYQktucU9Zam4yb0orLzBzMy9JZ2pW?=
 =?utf-8?B?Ukswd2ZPb3poOWxZeCtacDI1QmJXQlJnRC9GdDlTcUVpOTRkL1hkMWhGTUl6?=
 =?utf-8?B?TUpGSjhFeC9GbkYwUWpoRzlDWUJPdFcvN2tmN25pMEkzeEZQVjdMQzBkMmxP?=
 =?utf-8?B?aEJ3bDBDd2xOQWJmU3Uzb1p1RjFOQjRRK2NyY2d2bEkySm5IZ0RxT0FVeTlt?=
 =?utf-8?B?dWl5VG8zN1Y3Rk9rNUZCbHIrZkkwQTdxZlVOdHVPNmRDTXNkcjh5cUJZbncr?=
 =?utf-8?B?cmkyWGIvdWZoRVhZWlBPa3Z3WFNFZzRvYlpOdlhWMmM1cWREMUVVUUkzckRY?=
 =?utf-8?Q?PqsznR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 13:31:40.2771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9489313-685f-4092-e557-08de34cbc9e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
Received-SPF: permerror client-ip=40.93.198.24;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Quoting Daniel P. Berrang=C3=A9 (2025-12-03 04:17:16)
> On Wed, Nov 19, 2025 at 05:39:35PM -0600, Michael Roth wrote:
> > Hello,
> >=20
> > On behalf of the QEMU Team, I'd like to announce the availability of the
> > first+second release candidate for the QEMU 10.2 release (there was no
> > rc0 published this time around). This release is meant for testing purp=
oses
> > and should not be used in a production environment.
> >=20
> >   http://download.qemu.org/qemu-10.2.0-rc1.tar.xz
> >   http://download.qemu.org/qemu-10.2.0-rc1.tar.xz.sig
> >=20
> > You can help improve the quality of the QEMU 10.2 release by testing th=
is
> > release and reporting bugs using our GitLab issue tracker:
> >=20
> >   https://gitlab.com/qemu-project/qemu/-/milestones/17
> >=20
> > The release plan, as well a documented known issues for release
> > candidates, are available at:
> >=20
> >   http://wiki.qemu.org/Planning/10.2
>=20
> Is our release schedule still accurate ?
>=20
> rc2 was targetted at Nov 25th, but in git I see rc2 tagged yesterday
> which is when rc3 was scheduled for tagging.
>=20
> Are we going to go for another -rc next Tuesday, or straight from
> rc2 to the release ?

I got the impression from Richard that this was a delay rather than a
skipped tag.

I was also late on processing the delayed rc2 tag.

So I think shifting the release schedule by 1 week to account for the
delays would be best, if that's not already the plan.

But I'll let Richard confirm.

Thanks,

Mike

>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

