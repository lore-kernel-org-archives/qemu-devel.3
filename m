Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D31C25B10
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 02:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5cKv-0002nJ-1P; Fri, 10 May 2024 22:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s5cKu-0002n6-50
 for qemu-devel@nongnu.org; Fri, 10 May 2024 22:19:44 -0400
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s5cKr-0001z3-T6
 for qemu-devel@nongnu.org; Fri, 10 May 2024 22:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGrFsLnBTOXOI4nIa1tnOzN+ZLgDn9KKH96EeCnC5KD4xOqkx9ApI6WjWiRxKTV6PoTHJ9/5zwM/cf0QSwgVUiUyVTWtVKzpQZekUf+bQfwQZUkqg7UalMXZneycLgfQuKfCTi/zShLSv9E/I4snZtuZjvetrf+i22WAzCRXiwzKzxJ9SZI5bfu9k9k4YyhCFFtI9pA+DK3SyMvd/nLNRmuSYjrfbtVDTBI9DNaqkMa2nHHYFL4S1uKjYv3m2JTOk9t4lWcTAV28Oo0iizaC/AjvRG9jkAHS3ApMSMdVtrYkLu6QRccxEa9N85ct9L6wQJIPb0kdpV078RXFbuMTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIVsXvQ67zoycGE7lpeKtNNNrTCC14U18kjLpNwYjNY=;
 b=OeGuT/u5jwjlJdxbi39zHQXbD/GtXvS0NXuXU7Q5rR7OlpqSWpg36nsCRzdZ+osq6eHbqVR4392ihtIGqhfHShWEKWqPeMyCGrgxxr7VU32/MRLGCnL4sINAPZAedhqjR6jKRArrbLdk4jGYsxROEBxZUIktO3u7rcfwWpdNEvv5zZmW0d5ggm7ws+BeoIF6AwsPJMBiYo368LUiUottpYQxsr66hU54bAZ3TBNDuYIbGgiQNQeacTtZgwh+Kmm+hzCHTb6nBT3HRWMjvQcBet4dMBHQhr4hudEguuoG637Dv8YXErw4W/GAC4kNjncXUFxQbthFAOt2u0RstuWq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIVsXvQ67zoycGE7lpeKtNNNrTCC14U18kjLpNwYjNY=;
 b=BUldYqT1WktUn6ogIOYhxm8NTDVbwSeMB0uFhnJYaJp1GG/SXchfEl0Q7OxnYlyDWf4zGUgp/t0oa/2mSBitaVJ2Vf2CWVnI7TdSeNhArzGYNY0ZocUTvenfh/OW+tAmtGSLqFgJZXD2ffOQdn4R33cys+E4MtLFzo3RHXpjito=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Sat, 11 May
 2024 02:19:34 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7544.047; Sat, 11 May 2024
 02:19:34 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Wang
 <jasowang@redhat.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v9 1/2] virtio-pci: only reset pm state during
 resetting
Thread-Topic: [RFC QEMU PATCH v9 1/2] virtio-pci: only reset pm state during
 resetting
Thread-Index: AQHaj8v0Xjj81CQhgEuf0xJ+4L63FLGQZ0oAgAGR14A=
Date: Sat, 11 May 2024 02:19:34 +0000
Message-ID: <BL1PR12MB5849F49145F0C99329AE0446E7E02@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
 <20240416070127.116922-2-Jiqian.Chen@amd.com>
 <20240510061603-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240510061603-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5754.namprd12.prod.outlook.com
 (15.20.7587.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SN7PR12MB7449:EE_
x-ms-office365-filtering-correlation-id: 7d3ce13b-44d5-4c3c-3cd4-08dc7160cce3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZUxIQnhZUjVMMkcxaVNIR3ZScjhBSXFhajZTVUVCQlFOSmkzbFY2Nmk5Vmx4?=
 =?utf-8?B?b0Q3cEFaYkdkYml4RU1hS0JpYUd3ZzR1MkJvQnlpSDU4endwTTVsdGdnbEtV?=
 =?utf-8?B?aG05OFJHQjFTMlZuUTNGL0hSakk1TGUxWjZaWktTU1hMZXRRZzh0VUFTRzR1?=
 =?utf-8?B?ZUtKcDdEaFh2SGhxSEE0MTdpQnFaMHJteGU1Y0NOUlVudVEzR3cwTjlXbGho?=
 =?utf-8?B?WTBYVXM1RG40aFFSQ21SS0FyR0VsYnY4TmxDN09oczhoZDRUNXlHYUZFVGYv?=
 =?utf-8?B?Mmt6bW40L1JNQmgwTDFlNlRsWmsrbElJcmZFeTJURVRWZGhxU3N6Tk40UW5V?=
 =?utf-8?B?WlgwUm9ma0N6ekd0NGlubkhlOHFmd0Nleks3UzY2bFphWDJqSEliQXNicUtD?=
 =?utf-8?B?aU9hYzBSYy8wRWRsQ0FMbEZ3UGltaGtWbUloTW0renlaQWVEOHZldXVwbGlr?=
 =?utf-8?B?eWM4MzdpVkc1WXZFMnhKekpXeWd0QW1ES2JxSFV4M0NZWnhrM1d1MUNMbjFL?=
 =?utf-8?B?UGx6aVdBQVZkcmE4Z0ZndW82VkxkVzQycTVwcHM3VkpmTkR4M1lHSkZ6T2lt?=
 =?utf-8?B?aUF6d3Z3NWdObFFYZWNsTUllNStqaFhsL1pkbW5GQkVYeWg4T1F1SGxDZWlZ?=
 =?utf-8?B?cnhRMFdJRFF4Qno3a1drRVdKem5ldk5oTC8vbmNPSWlnN0tjd3Q0K3l3NW1q?=
 =?utf-8?B?SkZLVGVNa1d2dWxweXNrMWowRTA4cDBhcEZKOElZblJsUkFnQXA2U2xYaHZF?=
 =?utf-8?B?VzY5VlBtSmpKdEJaOTl5ZUZCREU5ZHdaMmNaN0hIV0R4bjhwMk1HaUEvT0k3?=
 =?utf-8?B?ZUc0d1ZGU0lPc3VBd25XZmo4dXgxK2JqeTQ2RTFPR2hHNGEveDgvSnpWTzRn?=
 =?utf-8?B?WERNTEFlZ25XbWhxNFBxZzMvK3BEK2MvWVFlTkZVUDZ2SUJJa0UweTFpTWpl?=
 =?utf-8?B?QWZsUnl6bFJ3Q1h1SmNFM0Y3NnE5MjJNUzIwejNBVEprc24yUk9aaEFnSHR1?=
 =?utf-8?B?ZVdBTEw4WHBOQWpWUm8wS1k2M0tsdWkwQ1dCb2xSUU8vanl0UzR1NzBpKzRD?=
 =?utf-8?B?VXVieEdFMnQ1Zk52RjIxeG1zcUtsRS9WTG5zcUdoWWhRYmhLb1RiT3FYZWlG?=
 =?utf-8?B?aENuZHh4eUFOZ2dvc1g5Zlg4TGE5Smt0bCtKeDdnbmpOSkk3eVJXM3lGVHdz?=
 =?utf-8?B?aTFEdGh0dTN4bk0vSXpTQVFkOFlVdm0xSHVjQkJOU21qTWlzeTJnRTF5MlN5?=
 =?utf-8?B?V3ZJQmxhbmdIaWp1L3RQeU5UMkRFanY5YVc1MWwvbzhiR0lxdlJ3UjhjcjBS?=
 =?utf-8?B?VnFjbzhiY09zWktPV0tZR3F1V1dMK1ZmdWhQRVBuRWVzQSs2OHdPV3Y4MEgv?=
 =?utf-8?B?ODZPWG9XOTJ2QmZXdWdVSlhUNXNyS3o2RzBDam05UDFmVWpYUUxSRkswaXY1?=
 =?utf-8?B?SUxpMFk3MVJKb1h5S1RLcFc1TmdNcVRsbWFxRGd3MEtray9uVks0WUFOTXdC?=
 =?utf-8?B?RlREZnZVelBwWEFhVFl3ei9CWWpncE9VZ0s4NEZWN1duNnZRczcrcW43RSs5?=
 =?utf-8?B?Q081ZVNWamJKSEVmb2FVWUx0T3owb0hCODFLK0tDT1Y3b3RRRHV3elhkY1Br?=
 =?utf-8?B?cCtrbGNWRE5wc3JjTXp1ZStKcHBaTmdQY0tlR2FnK2JaQVJaNkhGQlRHTkFp?=
 =?utf-8?B?b1hvQU1iSG1zYWNBQzkzamE2dUxPRWJEYjVxZVg0VkwyRnFYbWg4YXllZ2dx?=
 =?utf-8?B?NUJ2VkRqNThkWVNVbUJtVkNmYWdQRThPMTBOOHpxeWpvYW8wbXBrYUF3RWhR?=
 =?utf-8?B?NDFRTjhjN2RpanhueDJQdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1RZTEZMa0FoWEZuTThtWGUzUStsM0NYOVN0NmJCQWNJVUZVdUNMZytVR2Vy?=
 =?utf-8?B?K0RvZXoyeEc5MTVLWjVKKzNqQTlnMTl6YXdETTZGUUhTb2I1OWFDZ1ptcHN3?=
 =?utf-8?B?aTdxdUdCekhhbUpLQVVCQVorWjlXa29kblZpbXN6dWNhaGpiaDJub0JZOHBj?=
 =?utf-8?B?Zk0xclIzR0ZNRFpaZytSMVJxZzVmNm5sS09UUzdVanRUcXFlN1hycFlxZDRD?=
 =?utf-8?B?dWt5eTFZdm1MNWdVM2g5a0VtRmxubjVPMGJHWG1laCtRS3o0MzQ3andPWDRu?=
 =?utf-8?B?ci83dlBrQnFUbnd5WHFFNmRnQUcrcE10R2pWbTRFY0UvTEx3cVY1cGdtb2hC?=
 =?utf-8?B?SU1VUWswaXdlVkc2U2xtL284NDRjOFdSUHNyUzFtUFNKVjlnUWU2blY2Ulpx?=
 =?utf-8?B?RDBRalIwUXFjNytGVklab3pnUHh5c1pWM2Z1ekowZ2FRVjlkMHBPSFFUOTM2?=
 =?utf-8?B?Y2NUbVg0aDkycys4NzFWMW0vTEhzRWw3akpLTEVidWN4b1VJeFZEMFl4RUg2?=
 =?utf-8?B?eU40aFI2UDJhQk52V1NrR21JYjlmT05DN0p1aXhjM3VES3I2WFJqZExvZVh3?=
 =?utf-8?B?c1RHam41TnZweUpwdzVDNWdjbklXS0RhZ2tvYUZCV1J0QXorYmpxZkJheTRF?=
 =?utf-8?B?c2kvVUFwWnAxNFU5NHZqZk5UbUdQWWhiVnlVZ2RKekd4WkIzMXQrT2srSHhJ?=
 =?utf-8?B?eEFmMjc0cHRua1BFY0xkY3NkRFFXRStDZC90K1RObm83emhESUVESXc2UWtN?=
 =?utf-8?B?aEVKdkdrZm5idktNVXFUVTgwZnFHMExDRHlPaWxxYWpPMGVyWVlBVE81aklu?=
 =?utf-8?B?VnNJeUdoaTE3R29RbjRQMGU0c0FESmhadGRjWXZKVnhSN0tYLzZncWgwbENq?=
 =?utf-8?B?ZVM2c0lPa09HU013T1pKWXpxc1Z2bWRzRTFQb3NRNEJzMmdXUEpNOVVOMjc1?=
 =?utf-8?B?QUlTNllGTVZoeDFieEtVbU5DY2NSOVp6VC9LcHpoTTdrYkpkMzlxRlNSUHdJ?=
 =?utf-8?B?RllEZi8zQS95K1V5Tm1UUTB3QWJYc0p2RktjME9nblpweHpoS1g1Ukc1ZFdz?=
 =?utf-8?B?R1BDOUxaNXNkSHpvdldmTlY0bDVqdWszUTFVTmZ2WldDb1pnWjVDSEpXSHBJ?=
 =?utf-8?B?QlJBTXpTbCt3SzV1azNtL2RLM2RFOU0wcTZUcEhsU3dGNzhwSGRONUxaR3VS?=
 =?utf-8?B?S1lyalh0NmdpZ0JMczZ4cFo2QXdCemxacXZqVExxQjBjWTQvci80TXp2MU1j?=
 =?utf-8?B?TWZWa3FlRCtuNlkyTDNaT2txWFl2c1p6MElIV2pXdGxJaTIxZUtxS1dYc3V3?=
 =?utf-8?B?ZzVSd2dDTk9vTlFBZzNIWFh3K0hCd3Z2R0hLTlVvTVJHcyswUnlUdXZtVGVp?=
 =?utf-8?B?SnNUb1FKMytOdTNUUnJHeXczWXh4MTdBMzBHejNQcUxicGliVXNkR0plMDlv?=
 =?utf-8?B?MktBVG55ZVBCdWZsdTRvY3Q3dFpTNHlvZjRNQ2RpTnc3eXFVdVFuYThCd0s1?=
 =?utf-8?B?SDBLZGtFNDAyRkU1azFtN1lhMUpsUE5vRWlzWUpYNWJ3ZFRBMVdDak5JMGcy?=
 =?utf-8?B?bG5sVFMrQVNhZHlqQ0lKMlFrMnJYbnFKL0FoMlEzNTlTZVk2Zjh1VFBqcXAw?=
 =?utf-8?B?eVcveTBvZE1GUnlDRWozaTRuVFQ0RFIvSEhuYkp5UVNaSnhBTU9yWkZrZnI2?=
 =?utf-8?B?TXkzN29wMDdkemREYkpoUEFpUGo4Q0RabDRoSE9ySnIyN3hXNCtreDBkWlAr?=
 =?utf-8?B?KzFtUkU0U2UxMWpuRkJoaGUvNWtHSGFTWTRNU1lRQ3dDYTJzVmlmTzJXNUxT?=
 =?utf-8?B?OUlUMEkwdVFIRTM5NklmaDBETXhhWE9lc1FZREQ1cTBsWU1xaW92RDMzTFg0?=
 =?utf-8?B?NmxiU2VFRk9INFJtVUtMWjRpbDZjczhSaG9MRHg3M1cwc2dqSDYzK1o5VE5G?=
 =?utf-8?B?bWpDMHUxdjFPRGMvUUxMWkZXK0tQZjhIaUk3cE9TNk9mWGxnNXFURFZzRjN1?=
 =?utf-8?B?UUpRZ3BDb3JENmJwZTJBcXlPQ1NIeU9QSVB0YjFKSm5PMEJnTldLbVcxaU85?=
 =?utf-8?B?ajR6VElHczZXZzRSdEhLSytEK3hHbEJIU2hLa0pZYXlxNTZhTk5pZ3daVGRF?=
 =?utf-8?Q?EZnE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC1BA15D6E69344D9998A0B1036830FA@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3ce13b-44d5-4c3c-3cd4-08dc7160cce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 02:19:34.7570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RqRGOx0kHpHyffs5CyB/5EJodynnRQ2cnPqozz2XgFqUHMh6KRR7fkntD1k+CFiOgxTJ/uOpmnbOP53LSjUHBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
Received-SPF: permerror client-ip=2a01:111:f403:2418::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

T24gMjAyNC81LzEwIDE4OjE4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IE9uIFR1ZSwg
QXByIDE2LCAyMDI0IGF0IDAzOjAxOjI2UE0gKzA4MDAsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4g
Rml4IGJ1ZyBpbXBvcnRlZCBieSAyN2NlMGYzYWZjOWRkMjVkMjFiNDNiYmNlNTA1MTU3YWZkOTNk
MTExDQo+PiAoZml4IFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbCBSZWdpc3RlciBmb3IgUENJIEV4
cHJlc3MgdmlydGlvIGRldmljZXMpDQo+IA0KPiANCj4gc2hvdWxkIGJlOg0KPiANCj4gMjdjZTBm
M2FmYzlkZCAoImZpeCBQb3dlciBNYW5hZ2VtZW50IENvbnRyb2wgUmVnaXN0ZXIgZm9yIFBDSSBF
eHByZXNzIHZpcnRpbyBkZXZpY2VzIg0KPiANCj4gUGxzIGluY2x1ZGUgYSBiaXQgbW9yZSBpbmZv
IGFib3V0IHRoZSBidWc6IGFmdGVyIHRoaXMgY2hhbmdlLCB3ZSBvYnNlcnZlIC4uLi4uLiAuDQpP
SywgSSB3aWxsIG1vZGlmeSBpbiBuZXh0IHZlcnNpb24uDQpIb3cgYWJvdXQgdGhlIG90aGVyIHBh
dGNoIG9mIHRoaXMgc2VyaWVzPw0KRG8geW91IGhhdmUgYW55IGRvdWJ0cz8NCg0KPiANCj4+IE9u
bHkgc3RhdGUgb2YgUE1fQ1RSTCBpcyB3cml0YWJsZS4NCj4+IE9ubHkgd2hlbiBmbGFnIFZJUlRJ
T19QQ0lfRkxBR19JTklUX1BNIGlzIHNldCwgbmVlZCB0byByZXNldCBzdGF0ZS4NCj4gDQo+IA0K
PiANCj4gYW5kIGhlcmUsIGFkZDoNCj4gDQo+IEZpeGVzOiAyN2NlMGYzYWZjOWRkICgiZml4IFBv
d2VyIE1hbmFnZW1lbnQgQ29udHJvbCBSZWdpc3RlciBmb3IgUENJIEV4cHJlc3MgdmlydGlvIGRl
dmljZXMiDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFt
ZC5jb20+DQo+PiAtLS0NCj4+ICBody92aXJ0aW8vdmlydGlvLXBjaS5jIHwgOCArKysrKysrLQ0K
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRpby92aXJ0aW8t
cGNpLmMNCj4+IGluZGV4IGNiMTU5ZmQwNzg1Yy4uYTFiNjEzMDhlN2EwIDEwMDY0NA0KPj4gLS0t
IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPj4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby1wY2ku
Yw0KPj4gQEAgLTIzMDAsMTAgKzIzMDAsMTYgQEAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9idXNf
cmVzZXRfaG9sZChPYmplY3QgKm9iaikNCj4+ICAgICAgdmlydGlvX3BjaV9yZXNldChxZGV2KTsN
Cj4+ICANCj4+ICAgICAgaWYgKHBjaV9pc19leHByZXNzKGRldikpIHsNCj4+ICsgICAgICAgIFZp
cnRJT1BDSVByb3h5ICpwcm94eSA9IFZJUlRJT19QQ0koZGV2KTsNCj4+ICsNCj4+ICAgICAgICAg
IHBjaWVfY2FwX2RldmVycl9yZXNldChkZXYpOw0KPj4gICAgICAgICAgcGNpZV9jYXBfbG5rY3Rs
X3Jlc2V0KGRldik7DQo+PiAgDQo+PiAtICAgICAgICBwY2lfc2V0X3dvcmQoZGV2LT5jb25maWcg
KyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCwgMCk7DQo+PiArICAgICAgICBpZiAocHJv
eHktPmZsYWdzICYgVklSVElPX1BDSV9GTEFHX0lOSVRfUE0pIHsNCj4+ICsgICAgICAgICAgICBw
Y2lfd29yZF90ZXN0X2FuZF9jbGVhcl9tYXNrKA0KPj4gKyAgICAgICAgICAgICAgICBkZXYtPmNv
bmZpZyArIGRldi0+ZXhwLnBtX2NhcCArIFBDSV9QTV9DVFJMLA0KPj4gKyAgICAgICAgICAgICAg
ICBQQ0lfUE1fQ1RSTF9TVEFURV9NQVNLKTsNCj4+ICsgICAgICAgIH0NCj4+ICAgICAgfQ0KPj4g
IH0NCj4+ICANCj4+IC0tIA0KPj4gMi4zNC4xDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkpp
cWlhbiBDaGVuLg0K

