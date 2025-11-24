Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4270BCFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 06:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQCa-0006Xp-DI; Mon, 24 Nov 2025 01:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNQCV-0006VQ-Lg
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 01:37:28 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNQCT-00064F-OS
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 01:37:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gucX367VhWFSsS8qb9NRAaDbLPYyc5+786gnADG4V2/j12uQ+LlLwrNfZXcNWLJ3BE5QIb0ZDj+yktPlhluaKDjelgPM8Ua4LHflrWc2ISy+k5Mj0fCgWSYLhOKGlb15+M50i4qzVJCOnAY6RzrM2Z4/MgXN4jeAKABDA6aYsxyvCpybbUY2g+IueXe3DBRMs7NF7bOS2BrplPPBBDWS2khLvHbmbi0iVIgqtCovNHDzVHKxYEfHTn8N6XeS9veYr/PkiZ5oiwkZYqtWbWA2Uxmbe6sMhfQ1Crujk5dpOFfFN2wLyck8nFrYdpJBdjXz88BbAZMGaFUwiEMnS0QgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCNMExJhdEFtHJpS2zp1XceaPfCmfIRCeWG10Ey2xtI=;
 b=oqzPiAXJ/kX1aj7WxzJi/VW62riJSQeuimq1pGsPOzgayzvc5MJdPlZD/9AZkRqrXR9cVjxpVAJMhC8VW9osHngxTm2mhsDfHdFfL1T7kAjdJojkI6HI368Q3zQH9mO5Rf0WhMiFBNVO85PmNXCx508sDOqLywb8xDyL8HaSRdKuIcIyjRQPqSB7UFbxUdeV0PuQg6ZxZjhhRV+WNBFnG7R/Lc9uJ1J6ekY8zSPOgFnuZ/Yqgwm9XDO/hwFR4HbtE2J/8q4HpTozmOW7Ptrk2HyXRpLZH+woDCKuEU2Mau5DN4jiwgIIOUL5peZ6AGJn2AO6qHDGq5p9xK1rDmnCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCNMExJhdEFtHJpS2zp1XceaPfCmfIRCeWG10Ey2xtI=;
 b=avj8L+R8iPRkcfCWRHgRxtjClBXcX/2Q/PE5859QghDHgInk8haUdLheUB6RRaa3mq9yE7XUz4xsljpaLv6gKabiFCdh4ABwflTNYU3g3ZSLvpHoWFVyXpohXUyRZFtB9SPmhjbcwPf4Xaz7Bp6SNsdQwZfTk4aIlXKULxFxv8A=
Received: from SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 06:37:21 +0000
Received: from SA1PR12MB8598.namprd12.prod.outlook.com
 ([fe80::5ebe:aded:34db:24e4]) by SA1PR12MB8598.namprd12.prod.outlook.com
 ([fe80::5ebe:aded:34db:24e4%2]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 06:37:21 +0000
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
Thread-Index: AQHcWfouWB64eMRQxket8nQadjUeibUBY3cw
Date: Mon, 24 Nov 2025 06:37:21 +0000
Message-ID: <SA1PR12MB8598FCFEBB257592A51C7D35F8D0A@SA1PR12MB8598.namprd12.prod.outlook.com>
References: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
In-Reply-To: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=d0cafed0-2458-4bf0-909b-ead8addd00e1;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-11-24T06:32:05Z;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8598:EE_|MW4PR12MB6705:EE_
x-ms-office365-filtering-correlation-id: 27642a1d-2371-4af7-f8f8-08de2b23ec02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5C/LHoaGQMq8zwHsmMsjmUwt8XHCN/YmeElahVcedl3s08p7Ya7RJZ0SJOyL?=
 =?us-ascii?Q?3tjZ+PFMBnb0KegO1chn8TMejj2zDXJqZXs4hHY/3NBGFfTkNoD34bZdTSRN?=
 =?us-ascii?Q?K+sm8s2R3Cj0qgNe0sucq7L1kahBVxsbQ7I2Znq0O75qd/6HvFW8Kf/yhYlm?=
 =?us-ascii?Q?F/JxtqZdckHR/dHgCte/c2JQTfm4ZDWITne84z1/JOYgL5w/9ed8fEauLUhz?=
 =?us-ascii?Q?K1YXLEuVBbZ4CbvOPmoQZCVwdSow418JZGlDd8+xEIfSaNX67W67Oe4Xzscq?=
 =?us-ascii?Q?sYPx1vc1D8LFd+LUNoiI1oPIlvnKA3fDxipAb3btKbEKAA6qBWjICLlcVJdd?=
 =?us-ascii?Q?UuzL3szqDu2zk555rTQji3GD8U65KVWGq+4WoxHlLajuzIYLj9nh1NgzFKRQ?=
 =?us-ascii?Q?6ak0xYK4gGpro6Eoh31pfX8SNn5xOiGJNkSEflkGRVnZ1HCQWI3PK3EGDIN5?=
 =?us-ascii?Q?OXPmB3l3SFPvmRVMdDiVyKOXxKuvmxzd0ohZC/bequ0OatBwtagWljzC3DYt?=
 =?us-ascii?Q?v1KTnw9z9VT/zUzA9w4/qJv4HnKdHQQlb87/AUmEsZ7ymeNh7oNUiLclh+Q5?=
 =?us-ascii?Q?mD+R5g5wOSXGbyLV5mAxhgLZp5FC2CdGXwweIlCy0l22H2A8rrNoUTigLYZX?=
 =?us-ascii?Q?SmZZEY8+cJQM+0huM6Vy+bE+nZVBCzfcJ5XuUrMQjIxkzQlK2pSJcLICKIR7?=
 =?us-ascii?Q?6gsmCXELGuzz4bifIh3tMXdKvHTZ++NSiFu0eliyTjwJN5cqrKAtgPPZn3A3?=
 =?us-ascii?Q?NrpP31hs1vvsyu9kHPGGTv9EiZjLM2ZAbqak4JuHhbOM26eEZ8TP3daS+2YR?=
 =?us-ascii?Q?ZgxB+UcerU3c24XV6uXWmt7MhfpRNZQ4H4q8tmMzsmcuguk1ud39fhOwiwU6?=
 =?us-ascii?Q?PnMxn3sPWO6DIuE2JXUVRtQIYRO+iJJk2+QHKPq95kIISXgx/sXHjNuf45n9?=
 =?us-ascii?Q?PIqZPyg+s/u5EBPCGEFIiPfGzXWMqRMSJv7jeRyuc+42kQplFH1EUbPD40S7?=
 =?us-ascii?Q?4w87wlmSSqYBcpl9+BXIMHAZQxwBCwhRPJYmouij91WmRPQus2zIVGk8p63p?=
 =?us-ascii?Q?bg3YzBE8pvuJlLZZs646p/n9pmrJX9C4yNV1OjWnzzU/9XXQ/tMyQeI5t3Mr?=
 =?us-ascii?Q?+cd8rVRIkA99kyRzGRXUOvcQEaQTbUq596QZsl44+uc0eK5sdHwjep+xABEL?=
 =?us-ascii?Q?LaFrON3bdr81O1s+pnps7tm39AHY2S44NNtWatLFRdEmhjHP/FI57J/V21pq?=
 =?us-ascii?Q?uyuO/cg1uy5/rIfiFv/tq/Qv+nsZRThfalI2DcHGvxtEtkOjzsL0NYkNdKem?=
 =?us-ascii?Q?qSR5sKtKicsKEald4YV7wjqU7unrlhzlPEyLNhveNIQLNySnW5D8+UjEJhZb?=
 =?us-ascii?Q?M1U0lKdO1QqX1mKdHTL/j5qkah+NOBday1K0/aw+hmP8LGUQlWXGbYwrTfj+?=
 =?us-ascii?Q?c6DkEPtfh7kOZJOUpBlFAs2iPdsRn032Trudqs7QH5kydW6J7+va+UvEPQ4C?=
 =?us-ascii?Q?oDlwDEuWgTEfge7iiqcxVe+wiHuVIKb4nyCz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyofq/f1zPNFoXnDzNGGTNb6hmZYHvym3mdSJxtxNkzVjyX2vNZAdbbOXaqp?=
 =?us-ascii?Q?YQoHiyX/BBMthwzGJ9svTN/zHtU5F6KuVqhAWMjz1FQ+oKecZO3CrGto1EJq?=
 =?us-ascii?Q?nWfnYhrQEkEMuIV7YMHMci0VDjfQJAgQ9cqNKbg5Qfrsl/X9GRKaiHfC7EPv?=
 =?us-ascii?Q?wa214f4eslOm8tGxj1Zmy+uACx+1031tfHTpPHV+fephLvAhqf3f4LTdrmvL?=
 =?us-ascii?Q?MG0m3XNgN1EXREjEZgsC3CWeVoAgsDEyEKuzULenXA2/P5KRamAaqEfq7V3Z?=
 =?us-ascii?Q?Z68nJxY5jY60bbAWZM+Jw7KXXZkgqfv85ln9Uctv7L0NYkWSNCZtjdulPcr0?=
 =?us-ascii?Q?fXzF4ponPhziVjUFcnrW6uhafsqgQ9Fki1qD6d7P3K45hFcxldfLLS+cBhO9?=
 =?us-ascii?Q?F3shsMngqxIiFWGQ3VpOLEIQDoLb0Ddyj2QN9nLGBITvhwAgX4V0shQAG1IN?=
 =?us-ascii?Q?oifDB9GQix2AMrP3QBgJOV1RCcRVGOhenuVbTEJI95RA/c1VVegoQ0kygNuQ?=
 =?us-ascii?Q?OHhIaPZu5c+LzYhQaFkXj6XCeXQdcrro/r7iQn9G0L/OcXJQtmGGzijh5e7K?=
 =?us-ascii?Q?jOGuaGo69nKSm/uGlWwMPHmstPLLK0nssjFnV8TS9u44hqxgxyxpM1UuwBft?=
 =?us-ascii?Q?mV6Oy2ihk21Jz07msNsVAbVVoUpos+6nwq+OdwJvHKMZ0apFpCy+X0j/XdaB?=
 =?us-ascii?Q?TGzbyMpUt2FkooANkfdaHHxtNpfVfccYP2APcQ94jLAOwJ910SSL8TiZbEy4?=
 =?us-ascii?Q?tF6K20rqKKQm/Mx84B161EZ8hfPBkKqlWJ4UfG6ilzEG1/ydC1KAFIGcNl1Q?=
 =?us-ascii?Q?k5JUwZGKm4r0hmBjemKRFMzte/gtQpGgBUSZdUqiMA+X93CmjdYe6BZIOiVn?=
 =?us-ascii?Q?akxmxFTxyQkuQftqnJXJEuqr1ubyTU2BtwmGafG5g2RVcxXTAMmbgJ/yheZJ?=
 =?us-ascii?Q?W9W016c4rhwANtFeMCwmLABH0mb8gIFI+FUycQVmC1uii/nKYRX33XNUpR8G?=
 =?us-ascii?Q?6UYGhjJ0YnKlFBcM3QLeXdt1FWYLb8UyzhoNK0fwdgELgUzGmRmVi7BH97Pq?=
 =?us-ascii?Q?Ysj+HlsdGdqqwymTAZXamhw4/QM9DeBPGjVfMiztS4nflthpwTzThghjvhds?=
 =?us-ascii?Q?nlBiem7P7CcTqg/YsdjBfhIn6LNy40sWU8A5ZI9xGSbulO+KnwA6I7I3orPe?=
 =?us-ascii?Q?Wpszchhz5hugpv9b1s54Orrz4ViWD2MPLTK0hOVpDiEUVXCvsmXv0wS7EDke?=
 =?us-ascii?Q?ukUARVyY6CjtwMsnaGlQrtqFcDS4bPEtvEV/JnaiThOPO1Bqo3C2gK7TN6Ew?=
 =?us-ascii?Q?7kgS/6qtNwPejz1LtCLoqd3jjRDcMYRB9bY7Ud90rEt2ZAi00pXmZwZcdcH6?=
 =?us-ascii?Q?WFp8ENmSVzf7rO6I4DH8blD1g/+SGY+pEzoHLjR9IS/YiW/4MLWx4hW0h/aF?=
 =?us-ascii?Q?dezm3UOea2/tqYhcmh1WpR+phoNXUYUmOKsWIXdCcD8Qr3S4Olj4oAw6QTI/?=
 =?us-ascii?Q?3MtvaQKtPJmPMGhUuJTRJAbdUhA1TbEVm9bEEs4UOQK5g0pEB7hOdo3HFLU0?=
 =?us-ascii?Q?LZBupta5xiD3sq5bCPA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8598.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27642a1d-2371-4af7-f8f8-08de2b23ec02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 06:37:21.6345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azMsgkNNRBjg6ZdXNLDS83tZFBlRSiND3Sm3SQzlTKNrqH4LJ8S8urjka49PQnSshT4Dn4TvMlmOZurncw7O4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=PengJu.Zhou@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi QEMU team,

Any update for this kvmclock issue?

Thanks in advance.



----------------------------------------------------------------------=20
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
>=20
> Problem
> After live migration, the guest monotonic clock may jump forward on the t=
arget.
>=20
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
>=20
> Fix
> Migrate the kvmclock value captured at pause time (the first read) so the=
 target
> restores from the actual pause point.
>=20
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  hw/i386/kvm/clock.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c index 40aa9a32c3..=
cd6f7e1315
> 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -43,6 +43,7 @@ struct KVMClockState {
>=20
>      /* whether the 'clock' value was obtained in the 'paused' state */
>      bool runstate_paused;
> +    RunState state;
>=20
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
>=20
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
>=20
>  static void kvmclock_realize(DeviceState *dev, Error **errp)
> --
> 2.33.1


