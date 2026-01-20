Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF43CCA5FA2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viEAX-0007UE-Ux; Tue, 20 Jan 2026 11:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1viEAR-0007Os-Qe
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:01:21 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1viEAN-0004wt-HU
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:01:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcWfhmUa1+tIpdZDNMno7EnIPA/nI0X4zy+FxTsFQZ/rfKKAKWmobJXP2wD7Rv1cu9HvD+3o8WwVr2aeCvEZfctv+ftdRwxco6d+AyQZ+mYf9SnZ356TrDJcjl3ccyChxdgP82uI8wacnPAITRjZnjdSw7n+wRuny8LNTYEs85Xg7XNjrR9meKG9bXGhJCEcSlZKW218Kg/FuSm6A9L9f1amU7YmdrvChE1zI1vqg5tcp/gIGyZph0gm6s3x1HJXeNDet5ZJnG5NKHR6FHBHdQ5tzUbU02IpXgV9+Ohsfrpqm5vFshb1dxLp8pC+jDsyarX4xfQ9ikYamB2f/VhNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyuf0xGY5LALjOcw4DQPTZmdoA9C2X2CPnEozuvjGzU=;
 b=KZbGHtmoOU0Klqg/enjs2CWnskeVoUHkZe+v9QYUy0rdZOOE+nPAOIYBTTgj6pL4sP4xR2WKEpDY06CRjgwtjzK7eJLw1D8UJvy24nlkXaGUccysxoZwmjyP5GZVaD8XkgBfo5r0H+GJyV3L0bzGrWeG6Y2uTkYE/o+kTgvnkENQB9sR/T35wdCoNzz4NsfAV1iLRNPjgY999OB0b4zGlcKZHSBNAuqgK2mbcQhgjjusdJwt3pM2jAx1yLvDCO+wJssXrWzPtApQmYNrnTab+8g33j7+5NGmISssb+9AULNIdyoXWPpinnEii02Tb2R0/LnG7xYn+EObLQgfCFQ3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyuf0xGY5LALjOcw4DQPTZmdoA9C2X2CPnEozuvjGzU=;
 b=dp3U6srPPKrE0fAAhQzbZc97aMlhA5Dp/FbJziOzq2l06qjAGCx66cTcs4m+zpG5P5olIdVysT7qc6/G6D7R76oTOBukHMpV0opt/ybsEMqqXgN2wOBzMOBChAO2j88J9VEzJ4cLl9y1PaaEWQ0jWe+pytame1tuMe1hCCga1CY=
Received: from CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 16:01:12 +0000
Received: from CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d]) by CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 16:01:12 +0000
From: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
To: Alex Williamson <alex@shazbot.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Prica, Nikola" <Nikola.Prica@amd.com>, "Andjelkovic, Dejan"
 <Dejan.Andjelkovic@amd.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Topic: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Index: AQHcaRi2j570A1RdCkK75QZWVlfQIbVO63qAgAyNN7CAAACt0IAAACSg
Date: Tue, 20 Jan 2026 16:01:12 +0000
Message-ID: <CH0PR12MB52839D25259B76151B3002ABFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
 <20260112091641.4d86d8e5@shazbot.org>
 <CH0PR12MB5283B2F97D090DA29776370FFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB52830768E66CE6734381065EFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB52830768E66CE6734381065EFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T15:57:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5283:EE_|SA5PPF7F0CA3746:EE_
x-ms-office365-filtering-correlation-id: 4fa30ea7-55cc-4001-1d64-08de583d2232
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0fhFaPxPZBSSO53UV8fr/zbrqZLXIv/okz7LFj5kFGEB/ouRlMwgN/Wnk7?=
 =?iso-8859-1?Q?xHsW3WBIfiLrJq/fZbtTybjdI+KJqgkDkZYXVUKaOXpoS8MlV3de6u8oU8?=
 =?iso-8859-1?Q?V5Wpxl6lqfC9EBwLKQfUgtv5gKH7PvXcF5NeBLHtqdQdoFHIKznxDFK4AG?=
 =?iso-8859-1?Q?IpRo09rfNzTBmkyY76DPevn1IbZqYpEerh2eLz/FcohY0TCu4gbhXKqD4U?=
 =?iso-8859-1?Q?IiP+oouXIyfWRkGyFjmkaGFdqDufM5Dz+PDXUvfd9xMxs1pjjRKBK5Woal?=
 =?iso-8859-1?Q?djAamEDWfuULVmvrD/5vm/j+jA8f9F9zrekebxSqrOfb3IGVFgwCn9+LsN?=
 =?iso-8859-1?Q?0PAbMMLjjTK83RjqlBFOTZ8pW0HJ9iWoXdohFSb9kHu8pMi1Iz9K718/33?=
 =?iso-8859-1?Q?7NAed6JNOiRl70ASznwylnPiUsQNB3co6kjiogDpIbEG+JJFaJNj0e6VKI?=
 =?iso-8859-1?Q?84nvwcxz+I3Q9HRKHyMEOPO/z0Jcc7RMMHpYIY6/UJcd5E+EudFg0+9Rm2?=
 =?iso-8859-1?Q?acQxEgpe8++0seyPd7Fz4phY9W144zjrxQ2IgQQYNkT+R6FaUJIk2MpaoH?=
 =?iso-8859-1?Q?69Ms4aNWrgHeQP+GxEUWC1onBto+dFgsWyFvnxTGheJjO9soZES+QMAJcR?=
 =?iso-8859-1?Q?R+YAiucKkKuLf6UZjdclUZxcoetMaXQNw7r+GvRyJNjeqnpGmGaxtKA4VC?=
 =?iso-8859-1?Q?fnUaT9c1aXfAEP7uXms04BbJYOxdOinE0yVGe6M7iauDi7sB7WcjId1clr?=
 =?iso-8859-1?Q?e18SmhMEjNyMp5Y6m4E2EuaKxtG5ewpLWBBZzOXEz+p9jlBRnB5SS/anYO?=
 =?iso-8859-1?Q?YkB2VA+xFmZ0UkvXUAZ68iz7HBT0zZ/lrF5iZbtGhmMDxzdsfg/A711wF2?=
 =?iso-8859-1?Q?G/Vl1wVrG5oPr0kmEzKN3gBbfQOAvUqmNnt/5nFadb1dl1PkWq9jmxRsQ6?=
 =?iso-8859-1?Q?h7A2+Uhnod3HF/jjY2/d9iCkJzRebC4q9Iaffigg/WwzQD0BazGR0kYGJ9?=
 =?iso-8859-1?Q?NRChWoxphdfTHe8vzOAG6lrb7rSjbq30igbP8Qh//noUHzere2yDophcGB?=
 =?iso-8859-1?Q?o2j2sv5sqqA13DOnQzOKoHsPmWbmh9tiadHps6JCyprT7PoaaLKqTYd+Zd?=
 =?iso-8859-1?Q?SByWaXoxLYM/RLOoTuy+xqrpmipv2g0Xhz1yA9ko+Gk0wI5Sd4cJ2C4RPL?=
 =?iso-8859-1?Q?umsSBgO3Ib1P0tG5GcYcsB83bK+AZc5G3rGUaRYJ59he501gcAVvdSzpVq?=
 =?iso-8859-1?Q?3mIbM0HKI/O1sslgVMWu7smpBe4QLoc4s1D29uS9XuB9GzLvYXK/hij2E+?=
 =?iso-8859-1?Q?1l/5uhjuctZ2uEHX1rnHJ2OX8jFASC/FFdA41i4tEHkXKxUI2AIBqJWuQy?=
 =?iso-8859-1?Q?YG8LzjB0nUkBlCC4OlYfwfo+rXfNu0sBQfljLi/vVxewWQ4zc2bvIFdCGR?=
 =?iso-8859-1?Q?embAoRXqIWWdv+DhqjjyY8nNlPUE5imENbzTkV5EAmxWtPAPgVj66Bh6db?=
 =?iso-8859-1?Q?7bENkBkOocK+6utIvbYS6YlRW9f2PfYU09bdlRJBoYQS2oqAHs5DYb/3aW?=
 =?iso-8859-1?Q?p5/4do+CX/Qtp5+W9ge1vuK0/YBqeud6EKohWU78+t13aoRK7mTwYUbFzC?=
 =?iso-8859-1?Q?iTs9pMkzs9ADMtE2YcCRtcKmUixRNYVCz64obKsP/ZZDJpuF8y9T9faAs6?=
 =?iso-8859-1?Q?zI7k4eWlXyFtnyKLQ0w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mjsccBdX28Y6GBCCuklmJokiip9vM/WwxwBDYAGJbNnZFKDDFw9LZNXq5j?=
 =?iso-8859-1?Q?zx3BLuGZpuFj+v4hLs+gPGPNQhijWBmqvnjAb/XEl0rvdWbFncz5JMi4+8?=
 =?iso-8859-1?Q?Y0Uvcvpe3CnJzpz30lrAPZDVA8lp3ui7xZCcQiyzW4TofOaphOpyZcfgct?=
 =?iso-8859-1?Q?uKGj6ZF/TS0kIBn1pOZv5LqbAhDePAFZ7wLf0qcWmVpCdVQENGxQZ1Smpx?=
 =?iso-8859-1?Q?afklTICcdSDGWbcqO2da+orvPTr2iXutKLknOVG3lpEGKJ+GIRfnbMQ9/X?=
 =?iso-8859-1?Q?eg6uIs/Ht0hVyhjqV1b8d+2QT97wrC4DsJxoIJuaDSetbNKz9tXK0XMm5s?=
 =?iso-8859-1?Q?lbloOCDwrEOOaLH/1GVBNP8jsM91MxxJ2E4UIjEHiF5FNtZYcORbzmrKLQ?=
 =?iso-8859-1?Q?72NoiWzkxEBmu2OlT7K7yFMZqHI/soIPhwO/F788zFyWvsFMsbT6xoUOtf?=
 =?iso-8859-1?Q?CEB7QRxh4FLWucsg45dQ8zsmiQBeZeETv7UFm10KmcqI4y4Zcp4km4/jQb?=
 =?iso-8859-1?Q?KTeVfIlZuE96yW/QMRx8NKWMkLUkFX1MHmNNS6qYSfGNr+GZ+kEjLGI5OE?=
 =?iso-8859-1?Q?8uNqXMh8p7/J12yMp/qVZtNMyv5QE9DSifzPEBLW75tJQ1/ht0hm3rypzb?=
 =?iso-8859-1?Q?8UZlzoLdsfD5OWtHXZxv0+murIIQTTvwkEGOUSi0SGqsm0d0Wi2Y+DPPGd?=
 =?iso-8859-1?Q?2LnjrTMWKzOhZRz7pnifsg3Z5WyxHXWI1MVcZCUttKnrqth+mnAGoEcN0I?=
 =?iso-8859-1?Q?3AcVEdGDUKhhWjfdFcWmTeuRj+Hkc3Gb3LGBP9+spuMhgWDoNM3C8KmhN0?=
 =?iso-8859-1?Q?jpm/fHhYVqPH6ah3ktHMUdwtigK6WAwlcVrnR7PNWJtkXvg3/MQPx0CAxe?=
 =?iso-8859-1?Q?YXKE82XXuUwijH4vg1vd1TwvDUlwatsqnVhXauJoTFecDQRzMHCaa+1PkA?=
 =?iso-8859-1?Q?F3CQDxjrkTu3DJtGPkLl6wRS1BpVC/GTCylH92IfPKY8yA9HOt2ID8oyK9?=
 =?iso-8859-1?Q?GxmzId5wvgGKCkr9UXDhZE8Y+4gKYdKdaamAb2Y1Dk5hMfP5GbYBS+Hv3h?=
 =?iso-8859-1?Q?33TfAJNDgKT4p+o8/1vOnpMOqFTfDc6tQGETjxvAp2vPsg+4zlANAnWKtR?=
 =?iso-8859-1?Q?s4OO42Z/8FsDOFXrDCEmvAe0pykWGOTqVstG+nRmF71lPEjZ/Uq8sT4HyG?=
 =?iso-8859-1?Q?HJ7F3UChLLoku5fdDguANpoxzRc2Fm6erxuEeOzMdziavwZGMeCoYA4co+?=
 =?iso-8859-1?Q?30Xzgwe7ZI4+vXwGRXpFd8067Dlp0i6tybw1c31sJLYBlGvQ+E6XvHRKCw?=
 =?iso-8859-1?Q?UaYr/FiWmXhj2FyCd3aLnILlvomCQirI0yCNRu3O/Wi73jdiLg29Dyb2mx?=
 =?iso-8859-1?Q?AUqts0VEgBpIskAiG6qDWFVDRzjZQPdqcI4M1NjBFo3o1DS7fF6KJwX2uC?=
 =?iso-8859-1?Q?6zMX+CkGt7hCsGGNRS/lkug8RnXoa0Fpb3hk4dXMfulFN+FAWf5lD+Smr/?=
 =?iso-8859-1?Q?GRnwnQ/ES7NEjOcyjcuPweCRmwaAZG8JTcXQmxAu8s1fu0Q0KJqgWRaCHT?=
 =?iso-8859-1?Q?PPQUpuXNoLn3Rm0osLWdIqVcFrNwUc5L7W4et5Ql9pgiWyTvficbdMkjFh?=
 =?iso-8859-1?Q?Q0+6+cIham20nOjnBs+WfvpbtV/we/VeGaQl4cAr/7rt6tX2EU0MOfnFHx?=
 =?iso-8859-1?Q?BiqJP54W6R5aZ2SteIdpOv7iPoWfiVAaMaoMdeQ6f1DKwsYii3kZ5Azw86?=
 =?iso-8859-1?Q?7dPNxbzt2xD6GNVMXgozQRczX7VPOmxwSduDv+RWVfeSyI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa30ea7-55cc-4001-1d64-08de583d2232
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 16:01:12.2631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHoSFdoUpyafRQdUbULcS38NWbGHYppAv/YGDV8omAgSDHvCuOfaQt9R+rGtZX1Vsom85Qh8WrVpK5AVHU+gcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Alex,

Here is the second part of the patch.
I didn't take into consideration the non-vfio-device in my first patch.
I fixed it by using standard that I saw in the code for getting vdev in thi=
s scenario, hope that it is satisfactory now

Previously, PCIe Atomic Ops support was only enabled for single function de=
vices due to potential conflicting capabilities between functions.
This patch enables atomic ops for multifunction devices by finding the comm=
on subset of atomic capabilities supported by
all functions.

The implementation checks all functions on the same slot and
advertises only the atomic operations supported by all of them, ensuring co=
mpatibility across the multifunction device.

Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
---
 hw/vfio/pci.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6a6c8f1807..a6723063ab 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1931,6 +1931,34 @@ static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *v=
dev)
     return mask;
 }

+/* Returns biggest subset of supported atomic ops of multifunction device =
*/
+static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
+                                                    PCIBus *bus)
+{
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
+
+        if (!func_dev) {
+            continue;
+        }
+
+        func_vdev =3D VFIO_PCI(func_dev);
+
+        common_mask &=3D vfio_get_atomic_cap(func_vdev);;
+    }
+
+    return common_mask;
+}
+
 static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
 {
     PCIBus *bus =3D pci_get_bus(&vdev->pdev);
@@ -1941,15 +1969,12 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevic=
e *vdev)
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

@@ -1961,8 +1986,18 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice=
 *vdev)
                              PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
         return;
     }
+

-    mask =3D vfio_get_atomic_cap(vdev);
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Only process the through the root function
+         * We get through here only on function 0,
+         * through check vdev->pdev.devfn
+         */
+        mask =3D vfio_get_multifunction_atomic_cap(vdev, bus);
+    } else {
+        mask =3D vfio_get_atomic_cap(vdev);
+    }

     if (!mask) {
         return;
--
2.43.0


Thanks and Best Regards,
Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Pekovic, Manojlo
Sent: Tuesday, January 20, 2026 5:00 PM
To: 'Alex Williamson' <alex@shazbot.org>; qemu-devel@nongnu.org
Cc: Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelk=
ovic@amd.com>; C=E9dric Le Goater <clg@redhat.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

+ others, on accident


Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Pekovic, Manojlo
Sent: Tuesday, January 20, 2026 4:59 PM
To: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

Hi Alex,
Hope you are good. Sorry for such a late response.

Appreciate the comments

I have split up the fix into two patches as you said, and will be sending t=
hem into two emails so it's easier for you to check them In this mail, I am=
 sending the helper patch and in the next one the multifunction

Extract the code that reads and converts VFIO atomic capabilities into a se=
parate helper function. This is a preparatory refactor with no functional c=
hange, making the code easier to extend for multifunction device support.

Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
---
 hw/vfio/pci.c | 53 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 14bcc725c3..6a6c8f1807 100=
644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1900,13 +1900,41 @@ static void vfio_add_emulated_long(VFIOPCIDevice *v=
dev, int pos,
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);  }

-static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
 {
     struct vfio_device_info_cap_pci_atomic_comp *cap;
     g_autofree struct vfio_device_info *info =3D NULL;
+    struct vfio_info_cap_header *hdr;
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
+static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev) {
     PCIBus *bus =3D pci_get_bus(&vdev->pdev);
     PCIDevice *parent =3D bus->parent_dev;
-    struct vfio_info_cap_header *hdr;
     uint32_t mask =3D 0;
     uint8_t *pos;

@@ -1934,26 +1962,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice=
 *vdev)
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
-    }
+    mask =3D vfio_get_atomic_cap(vdev);

     if (!mask) {
         return;
--
2.43.0



Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Alex Williamson <alex@shazbot.org>
Sent: Monday, January 12, 2026 5:17 PM
To: Pekovic, Manojlo <Manojlo.Pekovic@amd.com>
Cc: qemu-devel@nongnu.org; alex.williamson@redhat.com; clg@redhat.com; Pric=
a, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelkovic@amd=
.com>
Subject: Re: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

On Tue, 9 Dec 2025 14:32:50 +0000
Manojlo Pekovic <manojlo.pekovic@amd.com> wrote:

> Previously, PCIe Atomic Ops support was only enabled for single
> function devices due to potential conflicting capabilities between
> functions. This patch enables atomic ops for multifunction devices by
> finding the common subset of atomic capabilities supported by all
> functions.
>
> The implementation checks all functions on the same slot and
> advertises only the atomic operations supported by all of them,
> ensuring compatibility across the multifunction device.
>
> Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
> ---
>  hw/vfio/pci.c | 104
> +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 77 insertions(+), 27 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> 14bcc725c3..9d1faeabff 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1900,28 +1900,88 @@ static void vfio_add_emulated_long(VFIOPCIDevice =
*vdev, int pos,
>      vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
> }
>
> -static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
> +static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
>  {
> -    struct vfio_device_info_cap_pci_atomic_comp *cap;
>      g_autofree struct vfio_device_info *info =3D NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_device_info_cap_pci_atomic_comp *cap;
> +    uint32_t mask =3D 0;
> +
> +    info =3D vfio_get_device_info(vdev->vbasedev.fd);
> +    if (!info) {
> +        return mask;
> +    }
> +
> +    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOM=
IC_COMP);
> +    if (!hdr) {
> +        return mask;
> +    }
> +
> +    cap =3D (void *)hdr;
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> +        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> +        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> +        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +    }
> +
> +    return mask;
> +}
> +
> +/* Returns biggest subset of supported atomic ops of multifunction
> +device */ static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevic=
e *vdev,
> +                                                    PCIBus *bus) {
> +    PCIDevice *func_dev;
> +    VFIOPCIDevice *func_vdev;
> +    int slot =3D PCI_SLOT(vdev->pdev.devfn);
> +    int target_devfn;
> +    uint32_t common_mask =3D PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +
> +    for (int fn =3D 0; fn < PCI_FUNC_MAX; fn++) {
> +        target_devfn =3D PCI_DEVFN(slot, fn);
> +        func_dev =3D pci_find_device(bus, pci_bus_num(bus), target_devfn=
);
> +        uint32_t func_mask =3D 0;
> +
> +        if (!func_dev) {
> +            continue;
> +        }
> +
> +        func_vdev =3D (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_d=
ev),
> +                                                            TYPE_VFIO_PC=
I);
> +        if (!func_vdev) {
> +            continue;
> +        }

Why is it justified to continue here?  It at least seems worthy of a commen=
t why we can ignore non-vfio-pci devices relative to the advertised atomic =
op support.

> +
> +        func_mask =3D vfio_get_atomic_cap(func_vdev);
> +
> +        common_mask &=3D func_mask;

Factor out func_mask.

> +    }
> +
> +    return common_mask;
> +}
> +
> +static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev) {
>      PCIBus *bus =3D pci_get_bus(&vdev->pdev);
>      PCIDevice *parent =3D bus->parent_dev;
> -    struct vfio_info_cap_header *hdr;
>      uint32_t mask =3D 0;
>      uint8_t *pos;
>
>      /*
>       * PCIe Atomic Ops completer support is only added automatically for=
 single
>       * function devices downstream of a root port supporting DEVCAP2.  S=
upport
> -     * is added during realize and, if added, removed during device exit=
.  The
> -     * single function requirement avoids conflicting requirements shoul=
d a
> -     * slot be composed of multiple devices with differing capabilities.
> +     * is added during realize and, if added, removed during device exit=
.
>       */
>      if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>          pcie_cap_get_type(parent) !=3D PCI_EXP_TYPE_ROOT_PORT ||
>          pcie_cap_get_version(parent) !=3D PCI_EXP_FLAGS_VER2 ||
> -        vdev->pdev.devfn ||
> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        vdev->pdev.devfn) {
>          return;
>      }
>
> @@ -1934,25 +1994,15 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDev=
ice *vdev)
>          return;
>      }
>
> -    info =3D vfio_get_device_info(vdev->vbasedev.fd);
> -    if (!info) {
> -        return;
> -    }
> -
> -    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOM=
IC_COMP);
> -    if (!hdr) {
> -        return;
> -    }
> -
> -    cap =3D (void *)hdr;
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> -        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> -        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> -        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;

Nit, it would have been cleaner to factor out this helper as a precursor to=
 multifunction support.  Thanks,

Alex

> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        /*
> +         * Only process the through the root function
> +         * We get through here only on function 0,
> +         * through check vdev->pdev.devfn
> +         */
> +        mask =3D vfio_get_multifunction_atomic_cap(vdev, bus);
> +    } else {
> +        mask =3D vfio_get_atomic_cap(vdev);
>      }
>
>      if (!mask) {


