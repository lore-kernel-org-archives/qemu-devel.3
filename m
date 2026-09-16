Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F796C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lxL-0001vM-AJ; Wed, 16 Sep 2026 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.syms@citrix.com>)
 id 1x6lxJ-0001uv-7m; Wed, 16 Sep 2026 05:29:30 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.syms@citrix.com>)
 id 1x6lxG-0001WF-Ol; Wed, 16 Sep 2026 05:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVKZySrl2wXQU16m79sBlNxVb3a0Yq436qWDY4cIq+RclPmxMOZvTWAPNkC83OGyIdi/dL3eBbBKyngqq66IZ1LHUW9y+CwVmH8xRE870DI6cOEfcG+RCvmwKzhBnPbTY2TIHfxYdkMh8Zk3auKdSo3jTcN48CkWBWous1OLGlKyQKR6Xsp+hcNipuOmbhqF6k3mJBwEEjejfspA2sxyKW9VxWf8tu0+zwML1KwC7Ho6CXDVXQcM85sxjXVePPtF745UOK7g8ZzAlqeTC/XK6zNWkX4Eh/JBVVoaMVs4KB0puMqYc3CT7asK1hqfrXheyQj5jtLheWQDdMaSUaxPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+bVW6awHFUI9dFXxsOrceZQwHB+1lgluMYbgslDmYs=;
 b=kyMwodk6uIJI0chjcM0MDVJyR3a8GFwTbnbgPrAzD87fjB3QkpJJaguabv4BhFRPkMkRVseha/1Nzjh3PQ8TOG+1lUih7VwsHxniFPFLVXwJxGDRM4hiU9acurCVw5YV6Fb3P+9EpPhlFc0GB3hYdiJAXIExKGMyxvfr7gevkhEgbz0s8WrGQNLYgG5UsSO3It+W330dVtCSQxLlrnKDJ71QQ/8oVeLcsvb6pYtdZWjjy8f8+D6UfqU5lyghLh/sU8jHzX6jm7ANZf0JapwCgVK019s4w2VwGV+bfHRYBEBuvWn/aPh03WQFJgYtM5LjhLWHs459zHP51fVCpe84QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+bVW6awHFUI9dFXxsOrceZQwHB+1lgluMYbgslDmYs=;
 b=NZ/nq9SMHOPsL8qTgZxSiTlI4isnsw8hSsd8ZjgMU1jKUAmbugR6gfaRKX5hdbpmM/o+RBdYtCzoWWgIRlbxEagxE6yM5Ki5ZYG3xkzrZhhl8SwAsGrboHfTMgoSxRCgzypfPpyUxG6/LvLua7ut0gPkk/vymiNsV5/HQGNMWzs=
Received: from DS0PR03MB7557.namprd03.prod.outlook.com (2603:10b6:8:1fc::8) by
 DS0PR03MB7582.namprd03.prod.outlook.com (2603:10b6:8:1f5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 09:29:21 +0000
Received: from DS0PR03MB7557.namprd03.prod.outlook.com
 ([fe80::6884:8bd5:3e4d:fde7]) by DS0PR03MB7557.namprd03.prod.outlook.com
 ([fe80::6884:8bd5:3e4d:fde7%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 09:29:21 +0000
From: Mark Syms <mark.syms@citrix.com>
To: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Xen/QEMU PV Storage backend performance issues
Thread-Topic: Xen/QEMU PV Storage backend performance issues
Thread-Index: AQHdRby6p8WbXIfQiUq6fN2CsBlKNQ==
Date: Wed, 16 Sep 2026 09:29:21 +0000
Message-ID: <DS0PR03MB7557CCE44CDE2BCDB033C7A787B92@DS0PR03MB7557.namprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR03MB7557:EE_|DS0PR03MB7582:EE_
x-ms-office365-filtering-correlation-id: cee1a447-a47c-4c9e-c99a-08df13d4fd6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|3023799007|10067099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: PHnMssEOMcXePAOP+Qw+jbbtMFEDprWcnYOfM7DERqbGfWmLaltgD3Ma0IG7wWnwi2gAWdms1jfyV43ebRhw1VjmcAbQRDCNo/n2n1FY2U2DZtwoHAQK1B9PUE3ca8y088AMB+MeqTP90XkJcgt52Q9FCeVDdS1EQnpKTMIm+lZ3Fh1qSEfehy9zCkbMpwHIvrZXvhli42kK38NzeH9EAXC63w/wAKBcgOzaj4ScMzFxFEiqh2mopUJFARNmdzKDa3a4bfrC3I0QhI0DGKZwavl3XRU/LLxaDSjO2M04yJ0WBpuXWlOOqWHqAFPwLtJ8L4yqCrBugv7IZdDT/6DDXeFjUT/CTfVUvgKMkZyBRSu3OSjZd7Clh5o2f0ngVkgba//dAPvQpzaCjO4uE8UJrAwI/N0zejov3j0w5tCiQg05MO5koMjdfSOWNlJK89KNKA6rkvw8exdf5mlGNZwfEPtoE1iQD6Ja2Quevpw9M+c1/N5onwneDusQ0maodnfz45u+jna3OxFUFrIHrgS+0PDsN6wD8XzZo8gWAm9Da/auiz6JAMVtKmJb+tcdnbyFSmVLeCVLrHtAa3n8QT85DgImr6yJHBbVeXKI585KU0hxvbg4wFhngavcK6UAdGuexz7XtZbLh3i137Is+VyUQu0NVuQ1OJEZvrgZuRsuOCqIeZJ9b8dtixjkaDJr3MdfQArtYLpmQ5cZjHYG8xOobo1ReS+VY1XWxgxraSTxPT8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR03MB7557.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CFYT4X69YayEA+Q6AVdVO6KhOLYJbyuzQBmyfd+CSPqAvhHLpx7bPmLbGL?=
 =?iso-8859-1?Q?YzRbbPdRbNd3Z3TYovQzggB0MV2KDugxz4RhxKAL8MQaucU7+1waHnQLBG?=
 =?iso-8859-1?Q?FO0whe9tbsK+gfIWiufGUC3G8A1vFTGPsR8JKqGwvdp/ebE2vNT+nl5laY?=
 =?iso-8859-1?Q?tN0WpZZBx5e1jPc4eqZUg5eb7qhR9bXlX2ZGmIjUISEPgxYqnI7QwbviWF?=
 =?iso-8859-1?Q?s6fdY+goSKCmwXUtFHMfBi5mty2wnOTZ1D3Gct6XORn+NGzM/W/WY3LbcU?=
 =?iso-8859-1?Q?61u9ZFP1yFJGzbcO/oeLzo31M5B0AKsHLTMEAa789lWIM53wwyBYtutgnA?=
 =?iso-8859-1?Q?sCjMYq5SkyUALRSQtznbQsgFaDjHuKWTkDBXjB2SfCYWJ7yByeSyBvL7YT?=
 =?iso-8859-1?Q?btEK7H1hB1xgpxhQQXFjPyCxOdWEGc113OiOQDeAwh5m9PzHAuYtT+IBb3?=
 =?iso-8859-1?Q?zB0cNOdgL+TMtnwz8aBITq0dylR3rAZ0pusQAbcEU9jcVOIri+qaAbfYOg?=
 =?iso-8859-1?Q?0JgLuavhBPvAr1a525z89HNR7bfkilyBKP3UmNUNvK6Htd3njlMLr07dBF?=
 =?iso-8859-1?Q?uJYM8xd/38xmaXn7N9jUPLOuowrgsvpZb0hwvnQGO7oqciPCGCeJzYYGr/?=
 =?iso-8859-1?Q?5qxucsIuSNqVH1sxXh/PTG5Tb4b9HfCMHqTQkvIkrtwCPTipG11j3EXhz7?=
 =?iso-8859-1?Q?6TgvVq3N8jiWBpI/ddTyFZdAfnlzpHtRxTWqsK67m3kBZHXGtlyicFqrK9?=
 =?iso-8859-1?Q?BEONeyneqkVbyo+gMXe0xqRDtwMdS3gfpBfP2FI7fpYkl9eqOGkogOVDg+?=
 =?iso-8859-1?Q?CLcCq/QNnWM4r7NNmy+q6vAi1Ys3b7+T/0xCS5ak13J5+gELkaH/hOKPYg?=
 =?iso-8859-1?Q?98XaeiZa20vnj1sJeCNk7zquoWg40Gw2kVCyiJjJAY2Wfxa6ofO//QqVBC?=
 =?iso-8859-1?Q?DmySHCG2SH2j3nH/aXZJLZ2vgYRfDg+aOQNIT112cRQX9qXNXqNwphxpdM?=
 =?iso-8859-1?Q?IRCnZ6tENDR3/Drc8tQjA/SlmiOV1Kw4Pp40yh/hdAepS2ME9zS+m9YeA8?=
 =?iso-8859-1?Q?LD+W18D5e+83XlyzkJQrFaNCl5i24yCqGT7v4qWAIwtlLDy/iJwvsQ/m6C?=
 =?iso-8859-1?Q?idVirCTWGhDorbIRWH7mjBeeKDaH7NNczsLIXJlWZViQ3TTVi0MXnLwCvr?=
 =?iso-8859-1?Q?fHiRMWjbkD5vp/OKj7jRxzKHg9GsHDh3fr/1nHW0Q1nMNJdlh+cQKCgAZO?=
 =?iso-8859-1?Q?tGCVaLppr/3R0eTf5twUwLUrwbUnAbGvxSQorztOXpkaqBu6jWMdn7/LKd?=
 =?iso-8859-1?Q?f6w8FfbiawpbMa/xVJnLekQY3R2n8O9vyyuZw5i/Cfk6Erc+QqEQQlKDjL?=
 =?iso-8859-1?Q?7XtpU/DB4i1u2+hBkCdbi0Z9+LkjcB1XN/9R3cQVqN0/qbXBbVOT1QrwL7?=
 =?iso-8859-1?Q?tJFaj8qU55Aj/H/6prLwFhfxomNdCpbu72Em2QwZVk8iTQBpcEtL5kkuZD?=
 =?iso-8859-1?Q?uquMEbTYLbxQ0zYnvrsJvqgyzdBJUoQp+5T3f44F9HEuRV0Yh+gMczh14c?=
 =?iso-8859-1?Q?u5rX5f6buXb+npphxM21ztG62Kq+lypfi3IE1Hkni0K2ttM80DFzZgwqQ1?=
 =?iso-8859-1?Q?deGu2nhVlS8p0NQHs585xPGyO/gwQVQPV+BOgiMnXaeMFpG/CbHu/8L/JC?=
 =?iso-8859-1?Q?NCxuxMHprLpxe5ROh5EDS28IY2lsi+Ov46Ou48+0E8qhrZPKtVkfIwLDs7?=
 =?iso-8859-1?Q?5JaFl2S6JePY3JGyyM/DosA36ro2rYmfonzCfKB1BydBvl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR03MB7557.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee1a447-a47c-4c9e-c99a-08df13d4fd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:29:21.5167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsOjePThIar9NRrPnoith6NwKDmggnjcxgH1AcpgKQiSKhESJmG/m5U+wg/hjoP02pEtqEnxBB8dWa/MHGF5jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7582
Received-SPF: pass client-ip=2a01:111:f403:c107::3;
 envelope-from=mark.syms@citrix.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Stefano, Anthony, Paul,=0A=
=0A=
Hi guys, hope this finds you all well. We, in XenServer, have been=0A=
doing some back to back Xen VM PV storage backend performance=0A=
comparisons between tapdisk + VHD and QEMU + QCOW2. The image=0A=
storage format appears to be largely irrelevant to the rest of this=0A=
conversation. In doing so we have found a few significant issues in=0A=
QEMU, mainly around the xen-block dataplane and adjacent code.=0A=
=0A=
## Testing Environment=0A=
=0A=
Debian 12 VM, 8 vCPUS, 4G Ram on XenServer 9. Three virtual block=0A=
devices, one for the OS on host local storage and two, unformatted,=0A=
20G test devices, one backed by tapdisk and one backed by QEMU. These=0A=
disks themselves are then backed by a BRD based target hosted on a=0A=
native installed Rocky 9.8 host. The two hosts are connected over a=0A=
25G, 9000 MTU, switched storage network whose switch is rated to run=0A=
all ports at wire speed without contention. In the guest=0A=
`xen_blkfront` is configured with `max_ring_page_order=3D3`, which is=0A=
honoured by both tapdisk and QEMU. QEMU supports 4 but tapdisk caps at=0A=
3 so for consistency 3 was used. Performance data was collected by=0A=
`fio` v3.33 from the default Debian 12 repo.=0A=
=0A=
Note: we did find during this that QEMU has a separate problem with=0A=
feature publication when hot plugging a device -=0A=
=0A=
https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg03492.html=0A=
=0A=
This was worked around by always cold booting the VM which then=0A=
negotiates correctly.=0A=
=0A=
## Results=0A=
=0A=
The following table is the full grid from the testing=0A=
performed. Points are expressed as ratios of QEMU/tapdisk so any=0A=
points < 1.0 show QEMU having a performance deficit. Each figure is=0A=
the median of the per-repeat ratio over 12 repeats, the first discarded=0A=
as unstable on a newly booted VM. The tapdisk arm is measured=0A=
seconds away from the QEMU arm in every repeat, so that drift in the=0A=
rig cancels rather than being attributed to either datapath.=0A=
=0A=
| block size | queue depth | read | write |=0A=
|:-----------|------------:|-----:|------:|=0A=
| 4k         |           1 | 0.73 |  0.73 |=0A=
| 64k        |           1 | 0.81 |  0.83 |=0A=
| 256k       |           1 | 0.67 |  0.92 |=0A=
| 1m         |           1 | 0.67 |  0.76 |=0A=
| 4m         |           1 | 0.81 |  1.01 |=0A=
| 4k         |          32 | 1.90 |  1.32 |=0A=
| 64k        |          32 | 0.99 |  1.00 |=0A=
| 256k       |          32 | 1.14 |  0.84 |=0A=
| 1m         |          32 | 0.86 |  0.88 |=0A=
| 4m         |          32 | 0.87 |  0.86 |=0A=
=0A=
Median across the 20 cells is 0.86, with 5 of 20 at or above parity.=0A=
=0A=
The deficit is concentrated at queue depth 1, which is what pointed at=0A=
per-request latency rather than throughput. Note that 1m QD1 read is the=0A=
noisiest cell in the grid at 24% coefficient of variation across=0A=
repeats, so treat 0.67 as "much worse" rather than as a precise figure;=0A=
the 4k and 64k QD1 cells sit at 3-4% and are solid. 1m QD1 is noisy on=0A=
both backends and is probably an artifact of the environment.=0A=
=0A=
## Issues found=0A=
=0A=
1. **Large (4m) blocksize read**. Analysis determined that this was=0A=
   impacted by QEMU being overly keen in notifying the frontend of=0A=
   completion responses being placed into the ring. In turn this=0A=
   results in a Dom0 to DomU context switch and all the associated=0A=
   hypervisor flushes and mitigations. This can also be observed in=0A=
   the `ctx` count tracker in `fio` itself. Tapdisk mitigates this by=0A=
   only sending the notification on the `final` completion, managed by=0A=
   a `bool` flag. For QEMU we can use built in primitives such as=0A=
   `qemu_bh_schedule` so that the notify is sent at the tail of=0A=
   processing the `iothread` events.=0A=
=0A=
2. **Small (4k) Queue Depth 1 read/writes**. Analysis pointed at=0A=
   dataplane wakeup latency of ~57us being the culprit. Tapdisk=0A=
   mitigates this by implementing polling, for a defined time period,=0A=
   after receiving a request from the ring. QEMU contains built in=0A=
   support for equivalent polling which can be set a property on the=0A=
   `iothread`. However there is no plumbing for this in=0A=
   `xen_device_set_event_channel_context` as `io_poll_ready` is passed=0A=
   as NULL to `aio_set_fd_handler` so no polling occurs regardless of=0A=
   the value set for `poll-max-ns`. Adding an implementation for this=0A=
   goes most of the way to addressing this issue. Matching tapdisk we=0A=
   used 8,000,000, i.e. 8ms. This ensures that the poll window exceeds=0A=
   the backend service time. There should be no `evtchn` unmask in the=0A=
   `io_poll_end` as this will introduce a CPU spin in the poller.=0A=
=0A=
3. **Overall performance deficit**. After addressing the above two=0A=
   issues, overall comparative performance was still found to be=0A=
   deficient relative to tapdisk. Analysis found that QEMU was making=0A=
   many more, much smaller, I/O requests to the block layer than=0A=
   tapdisk was for equivalent guest I/O patterns. This I/O pattern=0A=
   difference was traced to tapdisk performing merges of adjacent,=0A=
   same operation, I/O requests at the blkif level before submitting=0A=
   to the lower level format drivers. Equivalent behaviour can be=0A=
   achieved in QEMU using the `qemu_iovec` function family and issuing=0A=
   `blk_aio_pwritev`/`blk_aio_preadv` as necessary. Suitable=0A=
   completion fan-out is then needed to respond appropriately to the=0A=
   associated request IDs.=0A=
=0A=
## Outcomes=0A=
=0A=
After addressing the above items the resulting comparison table is as=0A=
follows, measured the same way on the same rig as the table above,=0A=
again 12 repeats, first discarded.=0A=
=0A=
| block size | queue depth | read | write |=0A=
|:-----------|------------:|-----:|------:|=0A=
| 4k         |           1 | 1.07 |  1.07 |=0A=
| 64k        |           1 | 1.02 |  1.03 |=0A=
| 256k       |           1 | 0.93 |  1.04 |=0A=
| 1m         |           1 | 0.80 |  1.00 |=0A=
| 4m         |           1 | 1.03 |  1.01 |=0A=
| 4k         |          32 | 2.24 |  1.50 |=0A=
| 64k        |          32 | 1.05 |  1.00 |=0A=
| 256k       |          32 | 1.32 |  0.99 |=0A=
| 1m         |          32 | 1.17 |  0.99 |=0A=
| 4m         |          32 | 1.06 |  0.98 |=0A=
=0A=
Median across the 20 cells moves from 0.86 to 1.03, and the number of=0A=
cells at or above parity from 5 of 20 to 13 of 20. The cells still=0A=
well below parity are 1m QD1 read at 0.80, 256k QD1 read at 0.93, the=0A=
other deficient cells are 1-2% down.=0A=
=0A=
4k QD1 operations benefited most from the fixes for issue 2, voluntary=0A=
context switches per I/O went from 1.94 to 0.00, corresponding CPU=0A=
usage went from 26.5% to 96.7% which is a significant increase but it=0A=
was mostly doing useful work.=0A=
=0A=
We believe that the final 3 rows of QD32 operations are probably I/O=0A=
bound on the iSCSI transport.=0A=
=0A=
One cell deserves comment so it is not mistaken for one of our fixes.=0A=
4k QD32 sits well above parity at 2.24 read and 1.50 write, but it was=0A=
already at 1.90 and 1.32 before any of these changes; whatever causes=0A=
it is pre-existing and we have not investigated it.=0A=
=0A=
XenServer has fixes for all of the above issues which are undergoing=0A=
further testing before release to customers. We can't send these to=0A=
qemu-devel as we have made extensive use of Claude Opus 5 in all=0A=
aspects of this work from defining the test environment, the test=0A=
strategy and automation to implement it, post-run analysis and gap=0A=
detection, and finally implementation of the solution fixes. All text=0A=
in this message is mine with the exception of the data tables.=0A=
=0A=
We did feel though that it was only right that we made you aware of=0A=
the issues we have found so that you can make your own decisions about=0A=
them and whether to address them.=0A=
=0A=
I'm happy to have any further conversation on this as you deem=0A=
necessary.=0A=
=0A=
Regards,=0A=
=0A=
Mark=0A=
XenServer Storage Engineering.=0A=

