Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D2CC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ynm-0007AZ-Fl; Thu, 03 Sep 2026 00:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1ynk-00079t-AT; Thu, 03 Sep 2026 00:11:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1yni-0002Lo-8M; Thu, 03 Sep 2026 00:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788408710; x=1819944710;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TXNWFfpbflsdcL0WvwClu9XYpqW1mSC/MS7WNc/n9DU=;
 b=KFhqM4B8uSciQAQHKxM6WQESWivMiiNDVf8Ik2JhyoBlQPZToljc0bUP
 5jOIrL2CHwjCPEzdRL2ZT3tLpqokoqzaxpkHCUsOplyo12e2yPwh+bygi
 +1WOHhBKfr9NqlJPiMemq6AhHucGVnKUZlcksrl+kmcUf3VdrPZa62HW+
 efZSP7IdVYjJvn2H0omQwKC6vYWYhR4Y4yiAji2jHTe+SijBJfIVY1zz0
 YHJr7rvX6HufFhXM506H82+qrwB4A4eNGw0XgaP04YhUwEc98URp2A9cR
 DolyByhBUcksNo+HeqQ9b6LLHlvuff0i964TYcNkngeraT2IgRMKFcikb w==;
X-CSE-ConnectionGUID: fFMQKOU1R4SjP8+XxYJw9Q==
X-CSE-MsgGUID: tQRwDOvcS3WmxarBhJ33KA==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="154844401"
Received: from mail-westusazon11012063.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.63])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 12:11:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2R5gEED0LVO0Bx5ovXD7INdO2lOPE0VFJ4+/Xd7r1/HTGOUUYfTtmeUIna8eNuEU2Xgb5wRcykCylM5aC4Eo+XBUz7gEsq4Qs3hHR2bVh7L10+nAA5sB0YwpMGE1KitkC+koYpd2kCQS68zmw2Q3KTfnnO2AFi75qDMZg9m/YPzD/vG+adVSPBR+GwKa5Bk9jSrZdA1f0TPxl2qV5k8pUYtSyGbGqsRtFUQEZSpqvJr92WfspMnYQhI2JHlHBI/BPP8HdC15OlkSHde6mluyagF6mb8Dv7rsanswXPvdeqXCMKoWu9aiIQz4rVmWoAdXIbtmPL/UGw94je8Mnageg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXNWFfpbflsdcL0WvwClu9XYpqW1mSC/MS7WNc/n9DU=;
 b=ACDSf41rs/8rQ6U1ni1y+uiatrYZKUSNjLx8j3Rme8KT+sAAt5hyJRQ7rXo1tcW0LhMRhCLOhKMBIjCVmNqnZ+YYjpjl7Sa+aX8I9kxpJfVl66YdJnhtApDcDJtuiTQ1dC/oZnE2pzU7+0dizBzRQfhFmZEwfue0rZnGEbFEOfv8vePUKgt1UD1tyzaem9A0rVny12ptdgeIKU5eIKNXfw4Ts1DmtP5MbTTsMW1dTjttxuA6vhbwVCCaGkowEdVu17yRwnnC5XrVs+7c7/DR83A2j8jhMaCXWRxiXuea5Z7M5/d9R/vXbz2o7bymiggW19xnRqoa361a4z44WCp/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXNWFfpbflsdcL0WvwClu9XYpqW1mSC/MS7WNc/n9DU=;
 b=wfsbGIhXhhSl00PphH0HgK3xwpQEzc0yl9hIFoDOR4IZzm3yEzIwSWmWTXFyN9YHfcSwLRFxGkXvXFpEH1vCnHuQjq8oWkfPdxBB1gWlPl1fsJGwCL3655JZVlBbcg4tQSdCH2FyGr5DGWOco0Lc/wzqIAQMyIwkvGF9BfxbDZA=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY5PR04MB6325.namprd04.prod.outlook.com (2603:10b6:a03:1e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Thu, 3 Sep 2026
 04:11:41 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 04:11:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 00/16] hw/riscv: Socify Atlantis
Thread-Topic: [PATCH v2 00/16] hw/riscv: Socify Atlantis
Thread-Index: AQHdOO6clUIti2It30OBAR1jP5km67a8QsWA
Date: Thu, 3 Sep 2026 04:11:41 +0000
Message-ID: <b4605e538d7a49decef273b314e2c74dbaba9476.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY5PR04MB6325:EE_
x-ms-office365-filtering-correlation-id: d77437ac-ceed-4738-fe6d-08df0971754c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|19092799006|10070799003|38070700021|11063799006|10067099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: ueQN9SC8x+JIWXE5aLTthVQaBNQUEXlKvK/QBHaG/yJ9d7w5r3TD9OPz0hQGRTHyGrz87Mo4E74fYPw5P9wytHxiB36yoGIILkTpfSIyb3tUpIspfIY38x5y+6WX1gHGrAniWSw41ogDl5t7E0U/8PWGNM+qLYRaqQpriK/0sIc68sYbY4LW6TaQfUwQkUtJ9jhB91HRrOAr+cLI6SwX88BdTtwaH+B71s+XnSi1MOIlY4HybVohEIaQ/dKHLCT9sDP3jj4ZhA19dPwVq/715zz64OicQ+flrJLZ6XBUzO7BBOVnlk3n+q9tz1RXLA/+noERyGO1sYX+Cs5Sm/Nv2e/ubNIm6KK+ijiq0Ap0mNm6ScG8HI/5HVsqKDF+u7RcXGxhKKck823i0ULVH8fWP37c8XIF1ASwV6nA5he5ilWx3IXLWioBVZ5HM2LdA8bLe1c9/1x+sw+Djpbhynw/VNyyZ7vP6bxqUebeEYrqmxxiOoVT1AFbh4c3MTsOOWZdnUFHmTJFJV3UW5DPsfeOZFyjcoV1I3acp7YaZ+0NpsC576P9jjUeq5c5yHvrs8YZfYGpNeMdlDS7J7795b3yK3aLTmGfp9n4c/xDcvusM/NdfPdyibftdpExp9x9f3wB2OcAm6ilg+4wBa2WcZETLDhk17pPF3BuXZwPuqn/c3ElKIIc462QR8VmdtrMs1uPSF4FPx4EHx9gLedgs0XI+4+yQongQqnUmrUZ5TSnpzU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(19092799006)(10070799003)(38070700021)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em9zN01wSmlsbVdaN014bmc1SXRrOU5TSjArZHlSenpEMDFNTXF1YnRJaitR?=
 =?utf-8?B?ZTZOeG5RUms1cU1yY1hCU1JybG14TWM2YjZLYVd4ZXRISXhXRUlUSk1UZU8x?=
 =?utf-8?B?NmV1QkczY1IzZmIvMzFPUjdPL3FPUitORXlXNzFDeXNjKzhrM2N3NUF6ZlhM?=
 =?utf-8?B?L2NlQjk3QnZqNTZFMVRCWnJRdXNQYlNMRVNOQlVLL3dnajM1K0tlK3pKS0k4?=
 =?utf-8?B?TmozckZpcmZZbFBhMXJmaWoxWldBNXM2TWJpdit4RjFpbTQzckhXaURXOHVO?=
 =?utf-8?B?aFR1ZThQRjdLTUNzOW1jMHN6UnFrRWlyZlNUbWkzTS9sbzRhbE1vNVJJdzAw?=
 =?utf-8?B?dVdZazUyZ0tYYnl3WmE3cFduREZwN21uV290OUNFYmRCWElFUzNwdHEwTTNZ?=
 =?utf-8?B?UC8rVzRXbnhVL090dUFLdTkzcjd3Q1JBN0MrZzI0YkZnL1BmTHFVZHUrMVdK?=
 =?utf-8?B?bzgycXdGZTJ5Yzd1Q0NYWVlGZlpHclZHUWllbGdOV09COU9lclhLcE15WUFT?=
 =?utf-8?B?NFg0UVdyTHZwaTl1V0gxcFo3RU5BOXdQOVFxd0R0MTVvc3ppOWQ4bmV3eTVr?=
 =?utf-8?B?UUtuaXVpZUpZUWdHQktNRllxb0E3UmxDRzExVXA2Q29TalFGRFpzN2tLOHF5?=
 =?utf-8?B?TGhleHVMaHlXWThLR3UzZDlQK3k5ODl1ckdZck1IaWdPK1U2dzZ5MG1jWTJO?=
 =?utf-8?B?SEpaVk5PSzJSWFF6SkV4OXFaVHJTZlMwelAyNVZJVjQ1aEkxNkRNTCt6SnZJ?=
 =?utf-8?B?UjM5cVZWa1FzanBMbG9NQ2p2Z1pBMEdldDhJS040UEd1djhNSkpzQXp0bW9W?=
 =?utf-8?B?c0YweVVFOHlaa1VOK1B1ZXdhbnFoUUpNdlBaVXV4WG1wOHJxMDhDMll4T3Bu?=
 =?utf-8?B?NkpSZnQ0MDdJN0hVUXhzY3J3NzhxNXBFSzQvelNkWUFMMTFhblRoN2FWVjU2?=
 =?utf-8?B?TllER2pPa2hZZmZFcmtGcm1EVk85cEhGaWpkd2RJRzcyTUxOV0QvSWljTTVX?=
 =?utf-8?B?WWRINkdHV1NBSmpZcDZ3cnR2M0p2ajhMT28zSHBTb2FUbWtvQ1plaVdLb0cx?=
 =?utf-8?B?b2poTlN4SDhtWWpyczluZ2hmVkJUajdSd0h0R1NZMExNRTNHYjZ0M0VhUVZw?=
 =?utf-8?B?SkZTbEF6Ui82RnI0cmlGbjVBRlFyRC8xKy9ZYVdydnZRMzlWY2F5SE85d2RL?=
 =?utf-8?B?UVhraVowL3g2YjJQQmhEcUNZUEVSS2E5TTZ1U0I5c0FyTGo1bE1xUVljQlU3?=
 =?utf-8?B?TjBXMVp6c3d5MUNWd3dtZHBESUw2bWFsZDYzYmY5UHNEWE5wMndoUkQ0NTA5?=
 =?utf-8?B?ejBSY2ZqcHovWWRUbFhMaXlvR0tDdXBvMlN5djBUS3BKZ0hkRGJ3NG5xVWxa?=
 =?utf-8?B?T0xiVENyeFdNWi9BaXdmTkpRb2ZML2l5a3dxQ01sTHlwcnc0ZEYvM0laYWJt?=
 =?utf-8?B?M1V6WUs5ZG91RytwZEp6bzhIMzNFYTQ1aGpDcmorek00YUt3eGR2bmJCTjds?=
 =?utf-8?B?emFvdmIxbmpKTzFTdGhQRDBTVXVtejZiUHduS3BZbDgyYU5wQW9jNFNVdW9a?=
 =?utf-8?B?dEpOYWJJQlhZK0RVMEREZlBuaUpFQ2paOWNhR3UrZUc2OEZKZHg5a3l1VVZn?=
 =?utf-8?B?anc1QkNuWGY3ZmZrd0xOYTVHOSt6cks3NVoyMDFlVEl1ck51UVFhazB3N3VP?=
 =?utf-8?B?TkJOYjltQTlTZ2I0M0QycEtpL1IwTnducWpBY2dNUmtwNEYyeTh4aFhpc21s?=
 =?utf-8?B?TlRuVC9FWEF2b1NYUnNtb0FkT0M1SW5QTFpWK3RZUUgwZ0NPYW4reGxXcTg0?=
 =?utf-8?B?T0tJTVhVMUoxREVBRVB4WjA3WjRjc0xUc3hTd0RQWUppck1qSlU3TTd6bU1E?=
 =?utf-8?B?dlpCN0VQL1Yrd292dS8wUlRRR29TcE5GMGh0am1NUGVRdTFoK3N6UXFYNjVX?=
 =?utf-8?B?VXBQb2IrUGZ1Q2RXSENBekRLL08zZFBnNFNodWRJYzlZSEh1UjJlQzgwL1Nh?=
 =?utf-8?B?cSt0M25pbG1XM00vNVlTV1NXY3B1T2RFd1RRTllJNXkyTU9wZWtBMjJBeEJJ?=
 =?utf-8?B?Q1JEVnkrcGhEaWRVZHNyT2ZwZGpUQ0dhYVAvYnpidzJBSzBiMUJ1Nit3aXdK?=
 =?utf-8?B?b2hXekZJLzZJMG95MHBWdEliWWNZdzFGTTBJd2tZT2RiV3BpRkpvM1lPWVIz?=
 =?utf-8?B?dHVWaStVazIwUU5SUlRxeXlqTEZYWVRBVkE5Wkd0aStuNTlpSDdQQXFkVkxq?=
 =?utf-8?B?bVBXaFlMeFY3czcra05mZnZLVDFqVU4wUTJPSFY5RlNHUlc2K1NpbGw3Z3N1?=
 =?utf-8?B?Z04wcW8zK3BhQ29QaGRwd1BzTmlKNDVHdnIzNklVaDNjN2liTjBPZzE4TWpX?=
 =?utf-8?Q?7exh8yc7oQf2WffWxTOFhSEfsSiTgAx5mtSo4EsESpT5L?=
x-ms-exchange-antispam-messagedata-1: 5ud7DqFLGrYyLqo+uIsLRZ220JRL+6i1lrM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B3A27056357A24D83BE5FEF3FBC96BF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R9m6jSSG82Qh+fU4z3dGW/pWzw3NugmY60PhUA+wWQPd7KOTf1cMngjSyc3R+UIydDQDEp5xOwK0vTutdTHl5pGfpLSVpWTD8j5wZZi+kiW5+YcDEg0SID/eIhFBgdswzJrGTt1H+BGCLw2yvoKgAhAqAIWx8j21mLeHfEdXmPrbEGQDqF/tUa6cL8yEnTSLNUOIjYx+ohT0VH9m7ln1yQDrPvE0A9WSK/I45ccfMIVZH2czFNEYssTz4MvdTOWlHh4r4s5oBi7y9f5YdXZdKW2Jp1UuxuBYHOhLK0sxznehDXw5WWQmNkPJYK8tkQVMfLmV9tfAEKdpZCdR8YQ0qA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NZ56rRXY6t+6Fh78uLrQLTdJosgfujIpKsW9loi/Bj5N16BqBEZ4sdc/3NzfselYM2Z3toa/2X7D6laNTBq+ZUipqLXXn59hp2/mtQat9dTpee99YZ1jJaxvPQYJVVRfAGW4iCqbE86ZtnCol+PZZm68xFkYXp5z0h4WniaIbtLK3MA4W6zMIUmYxRjORo98cDsEpOFtuw0IGp5J0viOPe7u6mkw1jfyvkP0BVxRykDbVInOuL6UdJ3sxMJKzkTXEkyjurg6grDr2Z11ej5X2r9NAoFKcdkdRYu12EL0wq2fO8+DdtZW+l2mOqz1+uBS8vjlaJGS0HaFyZIRxUh3IeIiHEpSYmQcDVtesQF7oTtLvCJToAaKP0UtyOG8axD15627sMJuNch3jLea7qM5eyV8pjxIjUaYdGEgok1PMO3UDUvwrRRIlwuVd0A++PcUUn5FtCgk9imJu9nPR41z+rXIu66Rp3zbyUrZyM14+kN5Wo844lIWwb2MDfUbhznHwrjG4yF8IbveGyjonCt9I4UD6ZOZsUSIIoS8rOHKbRfTDXKPMhGoYTFNkdy3cILsjVx1UwniWZrYMGog6kOk2FLXnbOVIOkiKCMzeMc9NY+34bRUiC6i+xR8BhWBNxIP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77437ac-ceed-4738-fe6d-08df0971754c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 04:11:41.3521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aikJPIlrqoXT5JT/8xL3z+ky5fUVT58l5yNAppzvIhR8RSBC4YV3Lt63TTPwFFYOf7BgNTONBzkJx7GiG/4IyjRgSUyap8arzz4z7D8YM38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6325
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LXJpc2N2LzIwMjYwODI2MjIwNTI4
LjU0NTE2LTEtam9lbEBqbXMuaWQuYXUvDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiANCj4gwqAt
IFJld29yZCBwYXRjaCAxNCAiaGFydCBwcml2YXRlIG1lbW9yeSIgY29tbWl0IG1lc3NhZ2UgdG8g
Y2xhcmlmeQ0KPiBoYXJ0DQo+IMKgwqAgdnMgaGFydCBhcnJheQ0KPiDCoC0gRml4IGluZGVudGF0
aW9uIGluIHBhdGNoIDQgKHJpc2N2X2FwbGljIE1lbW9yeVJlZ2lvbikNCj4gDQo+IFRoYW5rcyB0
byBEYW5pZWwgYW5kIFBoaWxpcHBlIGZvciB0aGUgcmV2aWV3cy4NCj4gDQo+IE9yaWdpbmFsIGNv
bW1pdCBtZXNzYWdlOg0KPiANCj4gVGhpcyBhZGRyZXNzZXMgdGhlIHJldmlldyBnaXZlbiBieSBD
ZWRyaWMgb24gdjEgb2YgdGhlIEF0bGFudGlzDQo+IHBhdGNoZXMsDQo+IHdoZXJlIGhlIHN1Z2dl
c3RlZCBtYWtpbmcgdGhlIG1hY2hpbmUgYSBTb0MuIFRoaXMgaXMgdGhlIHBhdHRlcm4NCj4gZm9s
bG93ZWQgYnkgdGhlIEFzcGVlZCBBUk0gbWFjaGluZXMsIHdoZXJlIHRoZSBTb0MgcmVwcmVzZW50
cyB0aGUNCj4gbW9kZWxsZWQgaGFyZHdhcmUsIGF0dGFjaGluZyBpdHMgZGV2aWNlcyB0byBhIG1l
bW9yeSBjb250YWluZXIsIHdpdGgNCj4gdGhlDQo+IFNvQyBpbnN0YW50aWF0ZWQgYnkgYSBRRU1V
IG1hY2hpbmUgdGhhdCBwcm92aWRlcyB0aGUgbWVtb3J5IGNvbnRhaW5lcg0KPiBhbmQgdGhlIG1h
Y2hpbmUncyBSQU0uDQo+IA0KPiBBc2lkZSBmcm9tIHRoZSBjbGVhbiBhYnN0cmFjdGlvbiB0aGF0
IHRoaXMgZW5jb3VyYWdlcywgdGhpcyBwYXR0ZXJuDQo+IHdpbGwNCj4gYmUgdXNlZnVsIGluIGFk
ZGluZyBvdGhlciBTb0NzIHRvIHRoZSBBdGxhbnRpcyBtYWNoaW5lLCBzdWNoIGFzIHRoZQ0KPiBS
Q1BVDQo+IChib290IG1pY3JvY29udHJvbGxlcikgYW5kIENQTCAoQ2x1c3RlciBQb3dlciBMb2dp
YyBtaWNyb2NvbnRyb2xsZXIpLg0KPiANCj4gVGhlIHNlcmllcyBjb252ZXJ0cyB0aGUgUklTQy1W
IGludGVycnVwdCBjb250cm9sbGVycyB0byB0YWtlIGENCj4gTWVtb3J5UmVnaW9uIGZvciBtYXBw
aW5nIHRoZW1zZWx2ZXMsIHdpdGggbm8gY2hhbmdlIGluIGJlaGF2aW91ciBmb3INCj4gZXhpc3Rp
bmcgbWFjaGluZXMsIGFuZCB0aGVuIGNsZWFucyB1cCB0aGUgQ1BTIGRldmljZSB0byBwbGFjZSBp
dHMNCj4gZGV2aWNlcyBpbiB0aGUgbWVtb3J5IGNvbnRhaW5lciBwcm92aWRlZC4NCj4gDQo+IFRo
ZSBuZXh0IGZldyBwYXRjaGVzIGNsZWFuIHVwIHRoZSBBdGxhbnRpcyBtYWNoaW5lIHRvIG1ha2Ug
ZXh0cmFjdGluZw0KPiB0aGUgU29DIGRldmljZSBhbmQgbWFwcGluZyBpdCBpbiBhIGNvbnRhaW5l
ciByZWxhdGl2ZWx5DQo+IHN0cmFpZ2h0Zm9yd2FyZC4NCj4gDQo+IEpvZWwgU3RhbmxleSAoMTUp
Og0KPiDCoCBody9yaXNjdi9haWE6IFRha2UgYSBNZW1vcnlSZWdpb24gZm9yIHRoZSBjcmVhdGVk
IGRldmljZXMNCj4gwqAgaHcvaW50Yy9yaXNjdl9hY2xpbnQ6IFRha2UgYSBNZW1vcnlSZWdpb24g
Zm9yIHRoZSBjcmVhdGVkIGRldmljZXMNCj4gwqAgaHcvaW50Yy9yaXNjdl9pbXNpYzogVGFrZSBh
IE1lbW9yeVJlZ2lvbiBmb3IgdGhlIGNyZWF0ZWQgZGV2aWNlDQo+IMKgIGh3L2ludGMvcmlzY3Zf
YXBsaWM6IFRha2UgYSBNZW1vcnlSZWdpb24gZm9yIHRoZSBjcmVhdGVkIGRldmljZQ0KPiDCoCBo
dy9pbnRjL3NpZml2ZV9wbGljOiBUYWtlIGEgTWVtb3J5UmVnaW9uIGZvciB0aGUgY3JlYXRlZCBk
ZXZpY2UNCj4gwqAgaHcvcmlzY3YvY3BzOiBNYXAgaW50ZXJydXB0IGNvbnRyb2xsZXJzIGluIFNv
QyBjb250YWluZXINCj4gwqAgaHcvcmlzY3YvYXRsYW50aXM6IE1ha2UgVUFSVCB1bmltcCByZWdp
b24gYSBTb0MgZGV2aWNlDQo+IMKgIGh3L3Jpc2N2L2F0bGFudGlzOiBSZW1vdmUgdW51c2VkIGZk
dF9zaXplDQo+IMKgIGh3L3Jpc2N2L2F0bGFudGlzOiBSZW5hbWUgaGFydCBhcnJheSAnc29jJyB0
byAnY3B1cycNCj4gwqAgaHcvcmlzY3YvYXRsYW50aXM6IFJld29yayBkZXZpY2UgdHJlZSBjcmVh
dGlvbg0KPiDCoCBody9yaXNjdi9hdGxhbnRpczogVXNlIGxvY2FsIHJlZmVyZW5jZSBmb3Igc3lz
dGVtIG1lbW9yeQ0KPiDCoCBody9yaXNjdi9hdGxhbnRpczogRGVjb3VwbGUgUkFNIHNpemUgZnJv
bSBNYWNoaW5lU3RhdGUNCj4gwqAgaHcvcmlzY3YvYXRsYW50aXM6IE1ha2UgVFRBdGxhbnRpc1N0
YXRlIG93biBtZW1vcnkgY29udGFpbmVycw0KPiDCoCBody9yaXNjdi9hdGxhbnRpczogRXh0cmFj
dCBhbiBBdGxhbnRpcyBTb0MgZGV2aWNlDQo+IMKgIGh3L3Jpc2N2L2F0bGFudGlzOiBNYXAgdGhl
IFNvQyB0aHJvdWdoIGEgbWVtb3J5IGNvbnRhaW5lcg0KDQpUaGFua3MhDQoNClBhcnRpYWxseSBh
cHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQuDQoNCkkgYXBwbGllZCB0aGUgZmlyc3QgZmV3
IHBhdGNoZXMsIGFmdGVyIHRoYXQgSSBoaXQgbWVyZ2UgY29uZmxpY3RzIHdpdGgNCnRoZSByZWNl
bnQgRkRUIGNoYW5nZXMuIFNob3VsZCBiZSBwcmV0dHkgZWFzeSB0byBmaXgsIGJ1dCBJIHB1bGxl
ZCBpbg0KdGhlIGZpcnN0IHBhdGNoZXMgdG8ga2VlcCB0aGUgYmFsbCBtb3ZpbmcuDQoNCkFsaXN0
YWlyDQoNCj4gDQo+IFBvcnRpYSBTdGVwaGVucyAoMSk6DQo+IMKgIGh3L3Jpc2N2OiBBZGQgcHJv
cGVydHkgdG8gaGFydCB0byBhbGxvdyBwcml2YXRlIG1lbW9yeQ0KPiANCj4gwqBody9yaXNjdi9h
aWEuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0NCj4gwqBpbmNs
dWRlL2h3L2ludGMvcmlzY3ZfYWNsaW50LmggfMKgwqAgNyArLQ0KPiDCoGluY2x1ZGUvaHcvaW50
Yy9yaXNjdl9hcGxpYy5owqAgfMKgwqAgMiArLQ0KPiDCoGluY2x1ZGUvaHcvaW50Yy9yaXNjdl9p
bXNpYy5owqAgfMKgwqAgMyArLQ0KPiDCoGluY2x1ZGUvaHcvaW50Yy9zaWZpdmVfcGxpYy5owqAg
fMKgwqAgMyArLQ0KPiDCoGluY2x1ZGUvaHcvcmlzY3YvcmlzY3ZfaGFydC5owqAgfMKgwqAgMiAr
DQo+IMKgaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oIHzCoCAzMiArKystDQo+IMKgaHcv
aW50Yy9yaXNjdl9hY2xpbnQuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDEyICstDQo+IMKgaHcvaW50
Yy9yaXNjdl9hcGxpYy5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKy0NCj4gwqBody9pbnRj
L3Jpc2N2X2ltc2ljLmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArLQ0KPiDCoGh3L2ludGMv
c2lmaXZlX3BsaWMuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICstDQo+IMKgaHcvcmlzY3Yv
YWlhLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTQgKy0NCj4gwqBody9y
aXNjdi9jcHMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiArLQ0KPiDC
oGh3L3Jpc2N2L2syMzAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA5ICst
DQo+IMKgaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmPCoMKgwqDCoCB8wqDCoCA4ICstDQo+IMKg
aHcvcmlzY3YvcmlzY3ZfaGFydC5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDggKw0KPiDCoGh3
L3Jpc2N2L3NoYWt0aV9jLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArLQ0KPiDCoGh3
L3Jpc2N2L3NpZml2ZV9lLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKy0NCj4gwqBo
dy9yaXNjdi9zaWZpdmVfdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTAgKy0NCj4gwqBo
dy9yaXNjdi9zcGlrZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICstDQo+
IMKgaHcvcmlzY3YvdHRfYXRsYW50aXMuY8KgwqDCoMKgwqDCoMKgwqAgfCAyNzcgKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAtLQ0KPiDCoGh3L3Jpc2N2L3ZpcnQuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjEgKystDQo+IMKgaHcvcmlzY3YveGlhbmdzaGFu
X2ttaC5jwqDCoMKgwqDCoMKgIHzCoCAxNyArLQ0KPiDCoDIzIGZpbGVzIGNoYW5nZWQsIDMxNyBp
bnNlcnRpb25zKCspLCAxNTkgZGVsZXRpb25zKC0pDQo=

