Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63EDE8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 14:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ8gP-00021H-7M; Fri, 26 Dec 2025 09:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vZ8gO-000219-AU
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 09:20:44 -0500
Received: from mail-westusazon11010070.outbound.protection.outlook.com
 ([52.101.85.70] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vZ8gL-0000oj-SZ
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 09:20:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8m/7/KR7zFVepv78vqu/5Y6MJbzyVASumOy8LNNnDie7ycRrT5D/jFSVA/wkVvv/WnLNaQrlIKrgjYjN/nvC1pteBi4up0erMeBM7NHor0tb9R2vrqtVcBNmSsCiZCYK0rUAiXuyKOngRIDJyvw0KffumQBfOSutCodfO/eLkQIyAEBewcW9nPxqrIY6zB/FnkWBtl6EVkpXHOfYlhE1kn2OxFB+LlvyJ7kVViiVxOw/LxFJnJVciCCQb0DphYo46fMJ+LxFKvvSpVviGMs2WGCCfpyzIadFQPh3VxAOzKA5M7Z+qTrk+kgGBShLS/4tKX6rMqwh4eM7+pmfNz8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIwCOGy0YYCAqUmEfMhH8DfkOrsMjhzIrAA6cjqYQM4=;
 b=q44vgPyDJ+t9gedw7VtC0zVPQv///MoZr3njihStbkOhZN148l3RpxHnIdTCW0TWy8qO48ACb8HUh5lQHqtzequ5aNF9O6SWAHjAJ2GErDDXr6NfUzq+RbYdN6TLzHCoKrPWf5LMAZ5g6bcpMmGoASwKcDr9q7675pu0skGODPwW1WOeUkrY+oIDVVX69Jid1neFad3uVTRwumIsBXkii9CDUfIoUI4+Wm1EmtVRPOTbGccNGu6BfyJMxPRUAnV1gtwTp5a83PIDqfVBjZkj13q4yZKPmc0gDo3pO9/I9yL8q58dKbdvsZc28+Cch06APsTSKmPXAJdOTXhXJ70wYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIwCOGy0YYCAqUmEfMhH8DfkOrsMjhzIrAA6cjqYQM4=;
 b=NKE9la+rzB2KSXImQga0dT1YCj3ZSKaN0zTjWXyHmNQ3VCNqpj1oe4SRM9gILoa2yhaRskcHkKshdKm9VhGC8X581QnwhLK9usIQyxIWomBZN0v3HYV/bRsnSa/kHHkkDGIHsZE16YXXZm5OwvSKPhGz+9mh39n6Z+ctZhU0kRs=
Received: from CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.11; Fri, 26 Dec 2025 14:15:35 +0000
Received: from CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d]) by CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d%3]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 14:15:35 +0000
From: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
To: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Prica, Nikola" <Nikola.Prica@amd.com>,
 "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Topic: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Index: AQHcaRi2j570A1RdCkK75QZWVlfQIbU0EcKw
Date: Fri, 26 Dec 2025 14:15:34 +0000
Message-ID: <CH0PR12MB5283E6E62B87088662E8C71AFAB0A@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
In-Reply-To: <20251209143250.714546-1-manojlo.pekovic@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-26T14:14:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5283:EE_|DM4PR12MB6446:EE_
x-ms-office365-filtering-correlation-id: 09bbbfcf-91b1-46ff-09b2-08de44893c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?l1QMlvrGOVO1cODVdroTPBwPa2KLzhe87gUUifsyu3PDzAarLE+2MfvzstkH?=
 =?us-ascii?Q?GiM1/VlHuA/YVtHGwevjWrr9eVdB27wN82dyHWVHgao4SDBr2o7rW+0FI1/T?=
 =?us-ascii?Q?/zQNdbKF35rPpuLGgbjOL0yOUc/gxc3V3yHYZVMvXfei5sOQ5uj6cpNOiumm?=
 =?us-ascii?Q?z14EYp8LrijKyeetsVzrbRpfj9sj3SjAzosf70357YEQ3vYKN9v/FhiMBccx?=
 =?us-ascii?Q?DuQo4F6wmOeA0Nh5iPaRvpk4n9hNceXORMSvbfAJbNCHK9R0veEVBgU4L56t?=
 =?us-ascii?Q?MJLcycryc40+5o812wtVvU2fWNE0qBLL+1ZqRcYWW/qw85grILjkI3V+g//U?=
 =?us-ascii?Q?3P1or5HvIATIfpOchMw0lfDvNwmJrlnaE3UMovjHOTfAIhxJ8jl0N6NSjvz/?=
 =?us-ascii?Q?XljJOIGiKR9wtWNzJ1B9lvPwoXgwEC8hP8HzPQlbxndWJYMwhNmtL1UsXKB6?=
 =?us-ascii?Q?HNsxX9wt6/alINTzSQQsMvDcYsrSFpLmNTZgwe3ic5a4slgcUg2ISpM0ubuV?=
 =?us-ascii?Q?v7N2xU+xczahVvf0+PznpWAgv8Mu8T9skU4wVuQ1WMrQWn0jY8HAczE2M7aB?=
 =?us-ascii?Q?L9Viv2NfcPWlYPU/I1mpFGuW2qcjGuGgHD+C/CLJ7R0yZrZKK7aLCDuhyjQk?=
 =?us-ascii?Q?rkiZmU3i4wJY31UTsRPMIwvKjsQOgAr39hZxMuAjYqKx4UQfGTeKF6f5uTt1?=
 =?us-ascii?Q?DlA1JOYdX22fKfc+nWhvXiCgAlT9nxCyQZx1Ol1kZFDt1cK5Q6VCc8gELjRk?=
 =?us-ascii?Q?ZADwDGzXNnkRaxqwfWEUAE7CyVSvPcUSInigrHwYqTxvdWl06UQV0avXa6XV?=
 =?us-ascii?Q?qkxB1v8QYyecinJ1sqwY9Fjp9iOuCBX18Seiv08CYexVu4DjurY5IDrfurNi?=
 =?us-ascii?Q?eSNOO9XX+tb/uJRlu7hmsjvHJ3vuLgKGYhFzjCQbwXf4i8XpXLGLBBKknMI0?=
 =?us-ascii?Q?hgoSB2jMYecdcpsGkC3J6+MzeTVPLIjNPabD2lLcZ1X8PxnDkpl3VxdMsQ4G?=
 =?us-ascii?Q?8e+8X4+R7Q1AAHzUby7RekVQVpXCpb+vK2JLP7ZXOh0OssYI3rdJ9Qyu7vYA?=
 =?us-ascii?Q?Z10V902CweDSvwvx8ABRbJoMkgLn15k1PGYu6XJziHoslGJPbsjO3c8vphwv?=
 =?us-ascii?Q?jzrAKUduB00x/D6YRt9laLMg4TrEbfOaLZ2TdONu3HVZzoESW2n4pPlWDKv4?=
 =?us-ascii?Q?PV89HLwyAzqv7dHoku0EJaqfKdi2gZBbiH2WI4YpdyMM+eLKSaXmIs+cBkGH?=
 =?us-ascii?Q?p2r6sqlOi+Gyo6p7v0PJkdTR/DL9HJ78MQowFo/Vfa6U+ODhy4I3SAduefPL?=
 =?us-ascii?Q?pgu7Cq47tE9G4C6OSPQDWUAt2byI35SHiJhnILcONdtJcxeWKiMdeugCgrBe?=
 =?us-ascii?Q?t1pb4ODufMoC0wfHGkc0/yGNRzEC9+htvkJQyONv/Pqy9D1riG6n9MIf3ywJ?=
 =?us-ascii?Q?e6DWevjnLRciJxYb1LRnbCRa6c1om5O3/Z4zvZRw0k4gZIrCeMQNGQ4q6ceB?=
 =?us-ascii?Q?p1i+lmuyiz8psdm0wFOgS6N7+uyp5+hJJcW0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NsLLZFe8y1/sdFMI/m5pTZVpJvaksubvc6UsWp0u4e9do3vZW/G6j5HTj36L?=
 =?us-ascii?Q?fvcRu4MaZidsPJ4RSSlNeA36kFFwpsDo0RhpAQM9SQEr/pWUYm73ks1FK73V?=
 =?us-ascii?Q?SP8PKcrfJL/bpLREfMoxS7X+38fGgTK7ZkGpt/Q3Ypk8w+od/p8sikHs9Drr?=
 =?us-ascii?Q?EkViAIv5mqMP4q7DLVnv5n39vnkPQw5OH8wFgpuRSPCOVVPQR4zQzj9Ateww?=
 =?us-ascii?Q?QSjFUy6ZFT+xDVZ8SItktF6Mkq01V4X8aeBAvEB17O6dn36Ij44vXx0GG+YS?=
 =?us-ascii?Q?C937P5j0eSjO3Gr7CLvnyQcxafYFg9odqMdVYv/qGsW4XMGQTwd0u90jJZHM?=
 =?us-ascii?Q?IBdBCxQlDsO9g5NyLkr073taH0/Puv2T7IIG63+PPH6i0i507a4F/XyTGJpY?=
 =?us-ascii?Q?sNi/0iJY5IO+eCb72pmoBfrvYmcoYexGBSQmovGTkSWcw62b8YJXEtX7fTAq?=
 =?us-ascii?Q?HjW4dXV4hFf3avWdQIcrzP8L09kjk0k4rtvdb52cIJR9zBKyHdHkDRbMiJua?=
 =?us-ascii?Q?KIsyOg40AR5Faly1c4bUFYvLghEmbWH3HghNUBvLuUGKqvfUopDNdjwszEqy?=
 =?us-ascii?Q?xFkfohhUeLNhe8gWZkJpejoKmuZW02m5EFNV0gFsY0e44JcE8hdrO91t2Jjw?=
 =?us-ascii?Q?RRY6RKt1F3sbxk4bK0y6PgDCmhXgU1HeAZM0HjCmKJm06OJxRIsxyhpQ1oDf?=
 =?us-ascii?Q?KeHihT3YjiBDDbwY/Ht3GgG3lbuk+or1BjiNAk/LWu4Rz09bclu9L9hAusEM?=
 =?us-ascii?Q?vqBor5hOOnB7yAcOg3/oW9ksVcYi8shtXsoRb9JDrQfCPADWAClvxrJUJmy5?=
 =?us-ascii?Q?iDN5NDAAu78DbkH890C1lUus8GrW0xfIoXIWbnCHwgapz9NBjZgcgSfQAfQH?=
 =?us-ascii?Q?zWvynt+2XbN2zbyluNEBBhasqY1zXo86rxZl3DbllUD7RjE/V7wYNCNP1QEi?=
 =?us-ascii?Q?VoJI5U0pd9WMfSkocKpTrb3CPvAqQj39aPI3+n/7VkEgdf7SMYhNaGWa84+M?=
 =?us-ascii?Q?HOv9c3A2uUMylhBZeByL7UIYAdz0ptJ9HzmsYSM2xpj2uDJAw5JYdszVVzId?=
 =?us-ascii?Q?SUra2GOUlTIkhq12tldIEWBi3ayWzHQQK0BpRiFD9g3/ZyVS/OtWdITSsO1u?=
 =?us-ascii?Q?Grdu/eaJ9GSoT0ZBM4pHxl7xhBsOGhWPneTOEyvEoHALBE4kPgwP1rpWfYLk?=
 =?us-ascii?Q?7Uf2M4s+fGhUtswQaWWmz+NfZjFWQa+F1DVw/INNT3tAqBilNdh4vDcoDTMy?=
 =?us-ascii?Q?zTkAd4YvE/LlqcWYbNZiWHkeDfYhX9BP9v7rpcvJRnp2bxuClcyWwt0Ya5fd?=
 =?us-ascii?Q?nKSPOrwkVd4D/W4vX4lusLk9YmhIBdZqD/FtO24AdPK/BFUeEnILQHpd1bJy?=
 =?us-ascii?Q?PFq5+sfaJjt9PJ09xhnb35N7A5APRN+0FBPJjOVTO+gPuQxtBZClxLejpCTy?=
 =?us-ascii?Q?mc2Pj4ry3cy6W5jqbjKNuzowPmkSVVa+cS9GKSY1E+4XYXICnooXLhuwFAxs?=
 =?us-ascii?Q?4+FlNZsOrQtgB8v3Sds7beGYFSXvFCBtpPKA4H54M+iYPTkC98Wq+yOexvmX?=
 =?us-ascii?Q?o/wrer2DZJOdTqmSANGCXVUWuX3QZE5pek0gmBHFZe9KDkpRFHBt6hLntVAy?=
 =?us-ascii?Q?BaLNb03R4MxrJ9YPo99gCmSXqNngyj4A1oNhfkmOC41Ntgxvpio/E9RUmA4e?=
 =?us-ascii?Q?dYn4bY+FJoA5PB+6rk5hQTU/JwxuB0Hz2qZcfBczCcDpBNY6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bbbfcf-91b1-46ff-09b2-08de44893c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2025 14:15:34.7945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4HKkO9Bi/xbOSHoF0M1AvSLbuhH3fT2gVQSffpNHHEev+U2Ci7dyQ6twpA248CLFkSXD+akcwsHwXzqUc/FgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
Received-SPF: permerror client-ip=52.101.85.70;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

Do you have any updates on this topic?

Thanks in advace,
Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
Sent: Tuesday, December 9, 2025 3:33 PM
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com; clg@redhat.com; Prica, Nikola <Nikola.Prica=
@amd.com>; Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; Pekovic, Manojlo=
 <Manojlo.Pekovic@amd.com>
Subject: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

Previously, PCIe Atomic Ops support was only enabled for single function de=
vices due to potential conflicting capabilities between functions. This pat=
ch enables atomic ops for multifunction devices by finding the common subse=
t of atomic capabilities supported by all functions.

The implementation checks all functions on the same slot and advertises onl=
y the atomic operations supported by all of them, ensuring compatibility ac=
ross the multifunction device.

Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
---
 hw/vfio/pci.c | 104 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 14bcc725c3..9d1faeabff 100=
644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1900,28 +1900,88 @@ static void vfio_add_emulated_long(VFIOPCIDevice *v=
dev, int pos,
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);  }

-static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
 {
-    struct vfio_device_info_cap_pci_atomic_comp *cap;
     g_autofree struct vfio_device_info *info =3D NULL;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_device_info_cap_pci_atomic_comp *cap;
+    uint32_t mask =3D 0;
+
+    info =3D vfio_get_device_info(vdev->vbasedev.fd);
+    if (!info) {
+        return mask;
+    }
+
+    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC=
_COMP);
+    if (!hdr) {
+        return mask;
+    }
+
+    cap =3D (void *)hdr;
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
+        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
+        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
+        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+    }
+
+    return mask;
+}
+
+/* Returns biggest subset of supported atomic ops of multifunction
+device */ static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice =
*vdev,
+                                                    PCIBus *bus) {
+    PCIDevice *func_dev;
+    VFIOPCIDevice *func_vdev;
+    int slot =3D PCI_SLOT(vdev->pdev.devfn);
+    int target_devfn;
+    uint32_t common_mask =3D PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+
+    for (int fn =3D 0; fn < PCI_FUNC_MAX; fn++) {
+        target_devfn =3D PCI_DEVFN(slot, fn);
+        func_dev =3D pci_find_device(bus, pci_bus_num(bus), target_devfn);
+        uint32_t func_mask =3D 0;
+
+        if (!func_dev) {
+            continue;
+        }
+
+        func_vdev =3D (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_dev=
),
+                                                            TYPE_VFIO_PCI)=
;
+        if (!func_vdev) {
+            continue;
+        }
+
+        func_mask =3D vfio_get_atomic_cap(func_vdev);
+
+        common_mask &=3D func_mask;
+    }
+
+    return common_mask;
+}
+
+static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev) {
     PCIBus *bus =3D pci_get_bus(&vdev->pdev);
     PCIDevice *parent =3D bus->parent_dev;
-    struct vfio_info_cap_header *hdr;
     uint32_t mask =3D 0;
     uint8_t *pos;

     /*
      * PCIe Atomic Ops completer support is only added automatically for s=
ingle
      * function devices downstream of a root port supporting DEVCAP2.  Sup=
port
-     * is added during realize and, if added, removed during device exit. =
 The
-     * single function requirement avoids conflicting requirements should =
a
-     * slot be composed of multiple devices with differing capabilities.
+     * is added during realize and, if added, removed during device exit.
      */
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) !=3D PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) !=3D PCI_EXP_FLAGS_VER2 ||
-        vdev->pdev.devfn ||
-        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.devfn) {
         return;
     }

@@ -1934,25 +1994,15 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevic=
e *vdev)
         return;
     }

-    info =3D vfio_get_device_info(vdev->vbasedev.fd);
-    if (!info) {
-        return;
-    }
-
-    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC=
_COMP);
-    if (!hdr) {
-        return;
-    }
-
-    cap =3D (void *)hdr;
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
-        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
-        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
-        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Only process the through the root function
+         * We get through here only on function 0,
+         * through check vdev->pdev.devfn
+         */
+        mask =3D vfio_get_multifunction_atomic_cap(vdev, bus);
+    } else {
+        mask =3D vfio_get_atomic_cap(vdev);
     }

     if (!mask) {
--
2.43.0


