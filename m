Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08F8D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 08:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOXB3-0007V1-3l; Thu, 27 Nov 2025 03:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Owen.Zhang2@amd.com>)
 id 1vOVPM-0007e3-TW
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 01:23:12 -0500
Received: from mail-northcentralusazon11012052.outbound.protection.outlook.com
 ([40.107.200.52] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Owen.Zhang2@amd.com>)
 id 1vOVPK-0005Sr-Gg
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 01:23:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXoG89brWScDDxU7vQMIgq9/9X3RjxXNEk0anVTd7PAM/DOeiKB0i/47pP9h+tFs6lFjzpWov4VaK91InHWUExghIKUmAEkH9rgukdTMoNAh7ZTKzBIapY9W+w7ErLHGDQ0O7yv57vdj5/KlrBtMNEADP/4nu9g+C6yfyeR76KmZy5+MOdD2sg7rvgLdhxPRo9LCzP5LVbRrQgQnGimYg05UqGEujZPRnu48fKFFSOZRMQ8nOng179U7M8Cmq5TgzDLKWh4BJd2aiNiegh34L1oAmN6IgAwzKQIUR0FDyjERQJVu/fAoJCK8jJzUQ4X7IkzBXuzX2REpIofwbcPB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHxpIKvYjMupCobD7Ev3bHUaAzl05RZ1Lr/6jzUxQj4=;
 b=TvXZESM7qjpVnvQhy5CHRza68aTyGkLLCNzfai5YlL4c1fSWZTC74mbCGDCmyNzIDUCY75UzEVL9CPlPl0Wq2hfDlxSM9NQPOApO+Xxw9iJEK1biRPZZlP9m/oQZ0IxhKWzbFyzBnv7XrJU8gu1L1tQcFViR8tNFI31dbkfkv5grCs7dXnYW3g/Wm5DcUd5H2wRFfCLlc1UvUxpUpZ7uxusyqxGGzXv4inHPHcCWqmf+ozBBizSQXnllQMXg2AggF5DpXMFTt7xJ5MTGS+4msFGXK46RZO/PbYS6WmNiFzC1Z+enR3OgBsQfQuzc62lVxGgWhRTLPeMSSa8sU+/iZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHxpIKvYjMupCobD7Ev3bHUaAzl05RZ1Lr/6jzUxQj4=;
 b=H1BcllemlfwI2rvxAZvuac/WIAGCK/OIfZwUcLt8w97zLpLdfTcZIhejkuEOYotcYw48lJMC1Xas0cQ7u6Av6xYjkydrozw/pQyLhpriX84B4EK09dyhJEQDJNTf/mvfTlL7GUWnlBMjVJe0J5KONl/zrnalNnrCh8IT1kgtrS8=
Received: from CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 06:18:04 +0000
Received: from CY3PR12MB9678.namprd12.prod.outlook.com
 ([fe80::adb7:c64c:4990:49c4]) by CY3PR12MB9678.namprd12.prod.outlook.com
 ([fe80::adb7:c64c:4990:49c4%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 06:18:03 +0000
From: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>
Subject: RE: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Topic: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Index: AQHcWfouWB64eMRQxket8nQadjUeibUBY3cwgASzQmA=
Date: Thu, 27 Nov 2025 06:18:03 +0000
Message-ID: <CY3PR12MB96789D2D5B5999338A25CA02A8DFA@CY3PR12MB9678.namprd12.prod.outlook.com>
References: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
 <SA1PR12MB8598FCFEBB257592A51C7D35F8D0A@SA1PR12MB8598.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8598FCFEBB257592A51C7D35F8D0A@SA1PR12MB8598.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org
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
x-ms-traffictypediagnostic: CY3PR12MB9678:EE_|IA1PR12MB6236:EE_
x-ms-office365-filtering-correlation-id: cc4b675a-1990-4899-2527-08de2d7cb931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ohNh1WYJbySzsufsCeZatkdFpcr9W8hzHFGF7vsvdzCClAX0GDbJ2TEuX+Cd?=
 =?us-ascii?Q?KCOyQTySi73Dx+KFDlSYgC5exfHeprU1JmPrSZx0hZ4OYcINGBiaTpknQSOa?=
 =?us-ascii?Q?7rPftQhb4i9CTzNSdvsZgpEQumHb3ZjIlZa5t5y16nrRhcwtES2vyp4VRpXJ?=
 =?us-ascii?Q?d94Nt1YLI6m7N8jE+hFTdwaUjFLFP6SAxQpKUbQahADYs8odClkZgl8IulfS?=
 =?us-ascii?Q?PLIDvQD87WLPO+ja+p3BQCUNldY/k6es3uBKF22n8uoyRJS0kziWQ07TAH+x?=
 =?us-ascii?Q?xT6TQt1c6qExsUH0vyJCb85Czb/TKiP3TIWJY1je48EcNzSA6eF9bOE7uwIm?=
 =?us-ascii?Q?refbuf72JmsCi0cpHolPhnlG/gTJ2oph4Kh8Ap5XT9goz64J2b7umYPVgXs+?=
 =?us-ascii?Q?g6VCBhhXeYtpWOaA1ih7n0aM5QsnBDyOsmGepzCxwUyTDtbKSKvtZlFq+VWn?=
 =?us-ascii?Q?gEyI5hT59NyxxoSaQBUyRagl3q5TK0eNUbwFAYVrt2JGdj9bUwVpJzOY1HSG?=
 =?us-ascii?Q?CJ0pCKrYj/mKQ4lgg+DqFe47o977N0efjk57nhiewDSy3v+FIi2Wd7SXVWIc?=
 =?us-ascii?Q?Ew8xC9UxJIFQ0I2zDqRAk7RRsLCnhffYCHigxGkoINuJbc3fBK2oyefNZ+kR?=
 =?us-ascii?Q?PQI6+rnh9pQ6WPxSdOVnqaKUbZ2d/GtQs5r3SR4rt+Jh4D+5kZq7QqjWv1s9?=
 =?us-ascii?Q?2/wEXDfNrAaueGbG8Ef84htkgXMNsLJSwfF5R9gpGemnRRGIwOgDz8ha0bvp?=
 =?us-ascii?Q?uQRSv0azhOWPwvrSW5fQLObS9HCswcbnwmLpj1C+9AOV8DvgRk8wnA7beXSl?=
 =?us-ascii?Q?/CpkKM5r6HILOzM2sScn2UquAVVE4aZbsfTMsKXbWgBdQ9fpyprsiUvGAKaj?=
 =?us-ascii?Q?Khpgwpn9oLLdHXEnRhnXPFlu83mSixr059Wj0X1Gfd14bRV07XchcrVQYmsG?=
 =?us-ascii?Q?ViQxovpwu6DSSFIy/yTHZl6oNUiYq73kaKvSIJIW0JYS0V8GjHaGr1s7qIGF?=
 =?us-ascii?Q?NHdLor3zTLeE6o7WJQdzQWJYa8aiJn7OnEO7V0H9lOOWxguyzSKRuY5Qo7it?=
 =?us-ascii?Q?HpU67G42ahjtpdeGE5e/tZVmFPud0a9ju6SPoLUBM/JEcEcbw76TH12dlWtZ?=
 =?us-ascii?Q?cYowUJESQqtzIknUAdojBGCQjUysoGCyEeZkIZ9fNLDg6N+pTR1hTLMdx/wi?=
 =?us-ascii?Q?UVt8XqVLcrvyOWn/TLYAa7ohsS5mrouTll+8Rd3IFRzweeOo0AEmIuSY6R5W?=
 =?us-ascii?Q?2QUsFAhYzbPARd8O48juZvFMmgjXho6Tzu9MkWKPezMs7CX0NFikj+Ggp2ju?=
 =?us-ascii?Q?BdvLzEIv0LosXHPiPMbzeHn1ByEjsSPyenSDqfFQpQNSt8fIr4Pty2/pw9mM?=
 =?us-ascii?Q?sfZSMaLTL7gn4fuXpbNPJPypSeY+SToSn0D7pgq1llTZAd/R6A8T+GVNY1g4?=
 =?us-ascii?Q?fRkHBVk4IEJvo4XkoW7yLkXvFijt20LcK5gnlA4YmMRJn4AkF5JYGe+I3Hwc?=
 =?us-ascii?Q?m3MKVxlLzuvMy8GtVlJFDKwFMrNF7Re280nu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9678.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DpyrSZWy4uJMXHVz5VQUggPoGgHnpwWKCVsSIiXd8v5mfR0r7wx+eUiaeGuh?=
 =?us-ascii?Q?LbY3UW5ybRMLkPqWXfR8eofCT/ZEsLvHf1OSUDTYCN2nHBdaFR/HH7VMR6WK?=
 =?us-ascii?Q?52Fw8hyvS5i0A3nUGNRaWJQ8tbvA65/Tj9QQvX48ZICJxs2d+mupvnSUV/cv?=
 =?us-ascii?Q?dsPUbdWRrnwr5sF094WNTCt1gTNHUFFxZ/lPS4t3oEjZ/XficAHw4aREl5Ho?=
 =?us-ascii?Q?ryVBaQHeJPsOnS6+yFh1xdhwVmVx7cWWJGPzoxdpezjdpLFhPLVRaLeaM5Xg?=
 =?us-ascii?Q?HBumozOQDJ3gj+LkJet6UHP3oUJ9RcnbKKvYPJw9N2PPABPcvN2+UR0pDaJo?=
 =?us-ascii?Q?/IJd3wGotVODlFLp5KWcE7vpvVkWWiMCrMRBr/VxHoqFk4mJx6LyYeajD3iP?=
 =?us-ascii?Q?xj7gV5TcRsixrMsdbuw841P52ELdWSXv7UvBfSeu+lQLBvyEioLASNJx8x3j?=
 =?us-ascii?Q?gHY+5TvMoRD8MFNccpO/X47x3k5Pk6zmOxm8iIUE5pDftkavQB7SGWXQvdNT?=
 =?us-ascii?Q?R531ozPjQ94YLNOFD1Q+lxZGxYv42EPDlgQaauzAD3Vo6EVWV11fvyWr1mSQ?=
 =?us-ascii?Q?nGrgEeXpdUshSjjXru34DojkanhIBX6QaSLvj/vwt5+3ztiqLgam4sIrKMdu?=
 =?us-ascii?Q?S83tGMcpUIiDq5FfftkG6cheEc55jXyEN7NsWOMlYAnGAP9B9bIpGkhZ9exn?=
 =?us-ascii?Q?I2KT600bYiigFePrQvbvLa3UhPgG55NUXkTL6L616IGX2LX5Ik65NmUyMOee?=
 =?us-ascii?Q?zbneGmqxXWnJbaxy8R06aNQZCeQQykgGKjVpoCu3x7GHhETOOV7Yqi0wvU/o?=
 =?us-ascii?Q?sO09hqOwoPxEmORd9Q1rS51xT8V2JwYrMIefNjpvsifMHr70GreQXUXrKGQr?=
 =?us-ascii?Q?JYyuCGKV4m5MU8MahreTnjAhQB4QRjXSiVkE+crtzHSeZ+ILeR8NxN2S5rmk?=
 =?us-ascii?Q?CoFX7dEh9jQGJpKySZRqO3T1aTrA5TzPoVpKw2D/BJS5Q+NskgEuC6Xe4ohw?=
 =?us-ascii?Q?W7qVpuYqm2+A2zdtH30ewhUneYanq2l5gTn9pjFUmVD4eHZqOzfmhf3pliJD?=
 =?us-ascii?Q?8i8scUprThaIifFx45y+1//XBE9CXiYqa3KYZiwPg3dn88qMivqO8H38yA9F?=
 =?us-ascii?Q?h3VB0loSzLV0wY/mDPdsRNB/iuAA46gb5jHQnyPZVbEJEOMHRuvokFsqFYW6?=
 =?us-ascii?Q?2P1whpaDoo7cNaerYWNQqLwTAyccrej98gQaGzaLKaBI2l+PlCG6q3aQ426j?=
 =?us-ascii?Q?IuSd2JTw+fz7ZJCTQVPuagTIZ2gNvOYAnXa0PQopWxwLbAHbsC7U+HXDL0PL?=
 =?us-ascii?Q?HaIMYtvDuD7YA1SkX1nW8PqPzdR4/i2BQBydvB5mfQJY6MpEOdD9JJe9TCOV?=
 =?us-ascii?Q?rviRZpVokx5/Pes/fRCofmpwwBb2kDOdTwMc+Cdb4wN3xhNYu+/mFC54rpTJ?=
 =?us-ascii?Q?xxRP3M9VFeMcNswWEeyk6Q3QsU17aZc7oZqDDDwHjjcpySK14RyX9CsbZM4o?=
 =?us-ascii?Q?6EjlKLbf9xQ/PKJgb7av45YCA1p2oA1yeTrhO78j3Of9BaA6sykXQ5vQvvTS?=
 =?us-ascii?Q?xWbeeWR0FTWI8Wo+jNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9678.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4b675a-1990-4899-2527-08de2d7cb931
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 06:18:03.9375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkeLkcvVOtSkgASRa/9irTcD8t9VyG63sYnjIXNHaf7JD25RR3/z/fD1LVMDWq3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
Received-SPF: permerror client-ip=40.107.200.52;
 envelope-from=Owen.Zhang2@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Nov 2025 03:16:14 -0500
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

Ping... @mst@redhat.com, @marcel.apfelbaum@gmail.com, @pbonzini@redhat.com,=
 @richard.henderson@linaro.org, @eduardo@habkost.net, @qemu-devel@nongnu.or=
g

Team, kindly pls review and provide your expertise... Thanks for the suppor=
t.=20

Rgds/Owen

-----Original Message-----
From: Zhou, Peng Ju <PengJu.Zhou@amd.com>=20
Sent: Monday, November 24, 2025 2:37 PM
To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; mst@redhat.com; marcel.apfelbaum@g=
mail.com; pbonzini@redhat.com; richard.henderson@linaro.org; eduardo@habkos=
t.net; qemu-devel@nongnu.org
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>=
; Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
Subject: RE: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after =
live migration

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


