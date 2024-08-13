Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8AAC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlUP-0001Hi-O7; Tue, 13 Aug 2024 02:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdlUH-0001FL-Lt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:58:33 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdlUE-0000zt-Rx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723532311; x=1755068311;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=itUz7T4gZ4o/1r3jaSRsDRBNRVfsQ6GiqsG5H5V44ag=;
 b=SgaF2veTSYWfB7zP50t7a3rjNlZJTCEF8uUoFRe+GnOAOb03Kg0u4IA3
 RybQGS4P5y7+lOlkG5kFNoOBIZEYkevzdiHaSJPIr2zCvQmhZeJtCHdKS
 eyny+a4I0FJ20Wxx0veDSz0LNztBWY4TVEbEB/RbEFen74PvtEsaC9eWR
 BYtuJkUXe5Z+hxI2zKxmwVL2DIru1Onmuims3Gb4PBS+tyUTblVKF0Kkt
 JyyRoccrWC/cEQLkBlXeatd9yyE/+7MLCdfAUDpoDk823qv9qJHwYtXuv
 QJJcsX6nGHpfBVV+9XnLbKUpePQA2uRYJDKPIWkW+mb3xDh/Q6UNaThIv A==;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; d="scan'208";a="18263361"
X-MGA-submission: =?us-ascii?q?MDGaXTTVo79QCktP++bfFCeXlyf3Du/5rklsit?=
 =?us-ascii?q?lEKqjrM6S+8NyG6MWDwkmAnRlmmGYtxh/bGxMsESsgpNCNu7B+x/X4gr?=
 =?us-ascii?q?Mx3cGrVx/ke3Od0hTyjkDeb4oyrCodNnEMfaqqTRAH6sEt0RAjloCwvX?=
 =?us-ascii?q?avhrEfyfPPPvWEFZcM0y2aAQ=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 08:58:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH+8Pc/EvVI39GJKtvbc5F/lUY9Aq2OFHYwZbqjz4jKmHN0CVWvGTzdVM7Uj91ygPCw0s+XKIXLAu+3YKfdGg46f47o32T7N6z+DhNrU+jL9DcxJF7S2fZ8zl3ZMWpDI//BypafmNCcVjIbJILT61+5H+cv8jYcu6cVJRym75YAiQD3Kio01jDZUtwx9ymuXFhd5s9on1gJkXXuaXFqPwwGYykwZJCpUVxMR7J9rkSZyYkG4B/ld6Vxh0V9iSRXj/xu96MpjPl9OrrL1ocHwIvQhqBdKqIDAYQQZrDX55QRQ4f32YJzupcURDRobly6mK0S8IqWje2vnEyxd08y7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itUz7T4gZ4o/1r3jaSRsDRBNRVfsQ6GiqsG5H5V44ag=;
 b=qE7MXvepdwhMxmEO1RnkbMvNvyb+joa78YwHr2rbKId5BRiK9Dm705aWXcE2JEns1h1DUGo88cSzFwPbHfx4NWLjSr3WxN4T5RNB//mHgBssCaESTxK9luRtjab3BGvw9dscWaNLY9HG6moCPrGOm0OoVT5yAabjS69R/uXKQ28e+PyjOjFFqwIbzL28XZHbk6zqBNSa0oYWjJBEeXzfyMmLa/B5wQY0MeDKblZv8f4uw6jKJSoJWON2vlb8qtLSX4Os+2jFFzZUA8jYtMUtoYESuHrUqV6o9abmdR7mc0he4qlqF3v9jaqxXGaovaenLppoSTozJL8b+C/xnUE1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itUz7T4gZ4o/1r3jaSRsDRBNRVfsQ6GiqsG5H5V44ag=;
 b=s/DqmmJx7UsFRu+0IT9HPBsL1tybDoYCPn32xxW5srSFp1q7iEzrgsm20RijrMKZG4cb8+v2K8VBEkai8tMoL3lN6Xr2Ppc0qv6S1s6fN/70/WWy0X5a1L0oukK6r83Q1LmEVi30XgvYaQYh2GyZdWnq8gYBp7G3XE+srlEPudrainuss1KJVghMjl44I7gy5NglmRjRi4h22pf+Q6LRfzVMi/6/lNRmMgv6r+zgTogL2frLO0K/atdEbHlaPqRxYiIiHUxkfKUDtr75mK6NwMyHMJx2VifralG31K5FjxpqkX7bhvz8+yWQuzmUb68SUxEGI2mi67nqLb88jwXKzQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR0701MB6928.eurprd07.prod.outlook.com (2603:10a6:800:193::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 06:58:25 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 06:58:25 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa5wDz+IzscR3Wh02h51iysT4RrLIZx5WAgAOIVYCAACpsgIAHBlKAgAAy14CAABIYAIAACLcA
Date: Tue, 13 Aug 2024 06:58:25 +0000
Message-ID: <2f4c041f-264b-4ed8-8427-7336291aa445@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-4-zhenzhong.duan@intel.com>
 <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
 <9ae22a85-9bf5-3d45-2d19-c3371aecf42e@intel.com>
 <7043464a-7085-4ae1-a07c-06785626b640@eviden.com>
 <SJ0PR11MB674466B036500FF8875889AF92862@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f1bc5d24-06fb-4b4e-b17c-9d21e57f9931@eviden.com>
 <SJ0PR11MB6744A9D527EBEB97A6D4598392862@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744A9D527EBEB97A6D4598392862@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR0701MB6928:EE_
x-ms-office365-filtering-correlation-id: b866138a-2ec3-4a38-04b6-08dcbb6553e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z3BzM2xLUkw0Z01WckRHZnQ0dEh1TWxGOGZGc2ZXaUhCSlkrY0J0L0w3eE5t?=
 =?utf-8?B?c1VrQmhhMXBXRWhxUmlOaU00NU5OaDhvdGwrbXBpRjlZbS9KQ1haeG4rU0lj?=
 =?utf-8?B?aGt0T1JSRnZDOHhDRWZTWXcvNUNUR3Rub1hKRG9neEUyYmhodDFSd1RpaHB4?=
 =?utf-8?B?dUdYTUN2bkFCUVh0SkpaMkZnQm45dkZaNkt2bVI5R3QrTDVOTmtWWjRyUTRM?=
 =?utf-8?B?WHFjaFg1UWtjSTdlUkJibFV4TFFJWnBRRldNYjdsZkxiQytPNkdLT21lOU9E?=
 =?utf-8?B?QlR4SzBlckwveWVUTmhleHVpVU5Dd1k4b3c2NU1kendKaWhFTnE3NklISEV2?=
 =?utf-8?B?Skp1YUo2a2dvMGh2R0ZHbkF5ZmZUd1NvU2Jja3RzK29aZk1iSHNlbXpQZy9q?=
 =?utf-8?B?eENEY0xOUE45LzJpdU94N3lnNmxMSG5mcmRtMERXRHdxZ3dhcktBeExQMTQ5?=
 =?utf-8?B?YVVsVVBXeWxjaitMSVdIMUhoRFVranpuYUo0a0R3a24zajVVOTE0RStnZjcz?=
 =?utf-8?B?UEVJWGIwTWxQQmFINlFTazJsVUpoRXBZWjRCcE04dmpRR2Q0OTQ2VDMra0R1?=
 =?utf-8?B?dlR1STBjaE54dGRHTC8xSWZpYlI1N2VxMTJ5bXVNcmlDZzgrSWh2WEtxQklM?=
 =?utf-8?B?MDhxbFBmc1Y4eVRwbUUxT1dQNHpMYkJnVjRxUGlwc0wrQTJWTWtMUzVES3Rl?=
 =?utf-8?B?SVd2THZ5Rlp5TVA4dHNPMk43S3gybnBkUzM2c01TdzI2VDJjdmg5L0VCZUpZ?=
 =?utf-8?B?Q1h5MkR6ekM4bEExN2xlRHJpNTdBMTBGa0JpYk93WlJmMU5sUnRTalM0RUhs?=
 =?utf-8?B?bGwzekY5dEFJSVduNS9jNmRQTlllcWUvZUMrbEY0WGkzY2VVcE1DYmQ5cTN1?=
 =?utf-8?B?TzVrcWNlUm16bE1nRVFPTmRTdW1DVUhhei9DTGxvUlQzd01aekZKRDcvalJW?=
 =?utf-8?B?aWhJR3lPNC9tVTBpbk9sUmZKUnYrdzBkN1BMZ2p2QnB0V3BWVHp3eHV5U3M1?=
 =?utf-8?B?azVudTd0c25UTkUzRXZDRXpjampSQWlyL0hqS2FiSDNaUEEzYWJtc3AyN3FZ?=
 =?utf-8?B?dGQ4ZXdlb3o3clZXTWloSURLMFpBeXVSL1Q0YVgzeWJFQS8wNFhaNklUZjBq?=
 =?utf-8?B?QlFwU2ovaXZ4UDRZR1AzakY0L3VUa1phQjF5dkJMb05zbHpOVnZ3dWh3bnR5?=
 =?utf-8?B?anZaY3k0bnNCZFBIZG5DTmNQQitIZC9IT002a0RxMU1sTE5GNHhIWCtObnVh?=
 =?utf-8?B?SzUvNi9KbVVpQVIxQ09zaWVPVXdoUW9MQ0UranV4Z1MzaDVSdG14WnRxdFpX?=
 =?utf-8?B?UnpOSGF0SSs0TGxUZm1WVHBRZEJXQ2xHOTREZ2JUbnEyUko2eWNwNUtsMU9G?=
 =?utf-8?B?c0RlMmdnS3pwZWZxTmhRUWRPUkMveko3bWN0cnlmbktPVHhrNEF2bTIwdFlm?=
 =?utf-8?B?ajRzRHBwaUw4dUNSWmJqVEk1cUU0bnJuM1M0QitKRjNIT3lDeWpFZUxkSnJ4?=
 =?utf-8?B?S0tXeGc1MU1RUC9KeFFJRnRPZUkwL0wyMS9ma1labGhEaDFjNkdWYk1vbGt2?=
 =?utf-8?B?d0ZZT3hKSzI2dEpKbkNvc3dmTWRoOHFEa2VaNllKbXFHK3JDWnU3YkRsaEJI?=
 =?utf-8?B?Smp1ZitqNW4xd00vc2JGUWhrU1N6Vk83M2VzOHdMMDNGTm1iYWJ2dVVjeC9L?=
 =?utf-8?B?Tnl0TEEzSDgwN0hmL0JMNW1VMU94czFJOWV3WkM2OUJWTGQ4Nklyd25NNUJm?=
 =?utf-8?B?STNtaEFJS011YTdUT1JCY3RadmRvZVFrMEhPKzkyRnc1bFJ4L1lDbzJUK2xz?=
 =?utf-8?Q?NLS+i82intsxP4puKXUuEJXHpDb5B/1EOjtIY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHpmRnVEdnZDWDRvWndvOHZpeWVxSXZldjQvVnNZNlRFU0VDTHk1WEdxWFQ0?=
 =?utf-8?B?bGdnNGVhM3g3cDZYT1hRYXZDZmV2WHA5UGpobjRaZkpDY0FNNUkyYnR5MFhL?=
 =?utf-8?B?azJYZktGZHlOV0xOeDhzTlJvbVhUNXlydzZnQ0xIVjZwL0dXWDV4K1RHWXk4?=
 =?utf-8?B?YmROS1VhQks0Qm5Md2JrV29IQmt4SG9xeTFsZURvSVlzd3hKZ2E0ckFBSnN0?=
 =?utf-8?B?T1E2Y3M3NmNPdEtNaytTeEU0bnFhemhIdG51aVhlaElQN3JKKzhJZDlqaUJ2?=
 =?utf-8?B?UDdlSmhHd2dUOFRpVWhCdktYZmliZGZScDJEWG9vRm5EYVhpSnk1WHBidjF5?=
 =?utf-8?B?cnZoOWxJREVxRHBTWmlUV2lrdGNWc3BnNldLWEZaSUo2dGlxWmkrRDEvOGti?=
 =?utf-8?B?L0M2eTFUZkFYQy80UTR3T2E3S0w5SGxiNHduMmxyeVBIcC9QdUFma1lpMmVw?=
 =?utf-8?B?emRKK0RqTEliODlYTUxWaE14Zm9DQlBqN05COElXbUxjQ3ZnU3VGZGxxamxJ?=
 =?utf-8?B?YmwvSy9XVEJGejRxdjZ6L3hpY0ozTHJPcUxVTjRNTE5pZVpJYW9hM1BYeUFL?=
 =?utf-8?B?S1YxakN1bjNtendNR3paeE12Rm5kQjFhMEloZGs3Q1VOS3V1Nm1WWFR0bjFw?=
 =?utf-8?B?MEk4N3lyK1dNNGdqSWtHZEdqQ3pqUzhQdFpGWEZmT2Z2ZzhGcUZOMVJRMjQy?=
 =?utf-8?B?VGl0L2FQU28vSXZsSElNZml2cU03UGEyZElTVlBoWUhtR1hKb3hmeGpGQysw?=
 =?utf-8?B?L2k1d2xnUXljS0hyVzY4Yk5IU2Y5Rm1YQWV6Wk1XK3dLRFlXUHdNTlk5a2oy?=
 =?utf-8?B?V1E3Y3B4bTc2clhqZ1hoOVIveDN0TExWVFhjTnN1UktMbzJxejRjeGVWZG9Q?=
 =?utf-8?B?Z1dvZVZENzllVlZLTUdNY3RhY0ZQM0thcGtmMW5aQUFHVW1UeFgrZWVOZkFx?=
 =?utf-8?B?Z2VzYXFwYkJ6KzFMcStJcmdYOTZYZ0ozSk5RYkNadzdsb3JZNlFsS0EyaExp?=
 =?utf-8?B?T3R4cy82VVJvY08xNXR1KzJBL2U3RmVRck00N3ZTcnNoY1ErNkZhNEluSHcw?=
 =?utf-8?B?eFY0cllCOUJGRjI5ZmtwR1FIRGovK0NXMnRJdmlaQVNwRmFZbDBtUzFKU0dx?=
 =?utf-8?B?T0dSMW4wVWxtampsS3FoSEtFSk1hK1J2cG40NDE5N0x6YWZqTFAwTUVONjJL?=
 =?utf-8?B?SlRpbENic0RCaEZyTVpjRDZHbmxTaS85REhISjZBR3dSekpsVkphU2xqbzhR?=
 =?utf-8?B?Q0N4WUVtbHNxbUF6ajAvb1VVUk9pM2M0eG51ZDdmRE5DYmFXK0IzT2RYMXhy?=
 =?utf-8?B?aW1aVFcxTHhlRDNWc1cyQ3BkMzhKWjY1TVVoSkwvQTZ0RkFWR1EzNi9UN2RW?=
 =?utf-8?B?V1RhT2tYOGljT284MWJtM01EME96cGdNWU44cW5ZRktCdHF2M1k1WTh0YUk1?=
 =?utf-8?B?OVVwbzV5TzQ2dEJlMXFtRW9tSWpaS0pLWXdCWk5KR1VOclB5VFFYMHdKNEha?=
 =?utf-8?B?bEdBVlVGYWorRW15Vlcwc2VtNEY0cnV1d05aaGdMdzYzNEFtbGtsalFOUGUw?=
 =?utf-8?B?YkxvUlY3WGJOU203Q21Gb2tCQjlkM2dFcmZvRE1oT0NEeGZVQ0kyM3Z3bWcz?=
 =?utf-8?B?bjlkRFpLeHF0SWFoc2xXbU90MUhudkFGdWZ5WnUrdUsyQkgveS9iV0J5Z0tJ?=
 =?utf-8?B?eHhacjVCcmNkajdxdStMZGY2b0h4dmxzYW9sOGxYNzF4WWlGc2ZIVmExOHFq?=
 =?utf-8?B?VFVQU2d3bTd3REpGR3p2MHRDaDc0ZjlZV3A4ajVzdDUxclZ4T2ZsM1Z5QXpQ?=
 =?utf-8?B?V1pxd01Oc2Zia1FHTldPaFRVZmRLdzFTZjVndjFhcVhSWGVKUkFxY2NxR0ZQ?=
 =?utf-8?B?S29sYkY4dkZuakpiRWtVVVc2ekV6K0lKZXBrYW1CVS9IeHNPMXgyM1VRM2tC?=
 =?utf-8?B?cU9DY1orVnd5bTRVZUppaEE5Y1VMaWNzdGhITkt0Mnd3UzAwdituanVoOXZS?=
 =?utf-8?B?Y3FYSVY3d1BZYlVySzMzTkxrQlM5UDdrZEFUejNab1puU2c3dkJDUG40QTdV?=
 =?utf-8?B?OFZwdllpdUtaSmkrWUFrWS9ZZDJ1eTZXU2EwM3JmNis0ZHdpSHAxbVJ6a2lK?=
 =?utf-8?B?WW9nSW5FUTdrQ2NiRlhwNkZSbktUT01zcW9tOVZHVkh4SCtseGtjSngrY2Zx?=
 =?utf-8?Q?8I5oLuVZ92cKvNHqLNkz5KI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C66294B537E714FABCB6EF023A9D0BE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b866138a-2ec3-4a38-04b6-08dcbb6553e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 06:58:25.3165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZbKN176pCDGb8LRIK2D3H4yHkPNZXsBdOBVsqrgFPSGThKETqIMWQVT2SH1WiFflZZtcNzVKoKwmcHxiXQ2ULA0cWdK1pcmnCyK4x9Dkj2ON0drvzT9vOf+f7lIvb0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6928
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEzLzA4LzIwMjQgMDg6MjYsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAzLzE3XSBpbnRlbF9pb21t
dTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUgZm9yDQo+PiBzY2FsYWJsZSBtb2Rlcm4gbW9k
ZQ0KPj4NCj4+DQo+Pg0KPj4gT24gMTMvMDgvMjAyNCAwNDoyMCwgRHVhbiwgWmhlbnpob25nIHdy
b3RlOg0KPj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50
cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj4+IGVtYWlsIGNvbWVzIGZyb20gYSBrbm93
biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4NCj4+Pj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklG
IDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlhYmxlDQo+
PiBmb3INCj4+Pj4gc2NhbGFibGUgbW9kZXJuIG1vZGUNCj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4g
T24gMDgvMDgvMjAyNCAxNDozMSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LA0KPj4+Pj4gdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQg
eW91IGtub3cgdGhlIGNvbnRlbnQNCj4+Pj4+IGlzIHNhZmUuDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+
IE9uIDgvNi8yMDI0IDI6MzUgUE0sIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+Pj4+
PiBPbiAwNS8wOC8yMDI0IDA4OjI3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+Pj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLA0KPj4+Pj4+PiB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUNCj4+IGNvbnRlbnQNCj4+Pj4+Pj4gaXMgc2FmZS4NCj4+Pj4+Pj4N
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gQWRkIGFuIG5ldyBlbGVtZW50IHNjYWxhYmxlX21vZGUgaW4gSW50
ZWxJT01NVVN0YXRlIHRvIG1hcmsNCj4+Pj4gc2NhbGFibGUNCj4+Pj4+Pj4gbW9kZXJuIG1vZGUs
IHRoaXMgZWxlbWVudCB3aWxsIGJlIGV4cG9zZWQgYXMgYW4gaW50ZWxfaW9tbXUNCj4+IHByb3Bl
cnR5DQo+Pj4+Pj4+IGZpbmFsbHkuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEZvciBub3csIGl0J3Mgb25s
eSBhIHBsYWNlaGhvbGRlciBhbmQgdXNlZCBmb3IgYWRkcmVzcyB3aWR0aA0KPj4+Pj4+PiBjb21w
YXRpYmlsaXR5IGNoZWNrIGFuZCBibG9jayBob3N0IGRldmljZSBwYXNzdGhyb3VnaCB1bnRpbCBu
ZXN0aW5nDQo+Pj4+Pj4+IGlzIHN1cHBvcnRlZC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4+IC0tLQ0K
Pj4+Pj4+PiAgICAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHzCoCAxICsNCj4+Pj4+
Pj4gICAgICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDEyICsrKysrKysrKy0tLQ0K
Pj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oDQo+Pj4+Pj4+IGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+
Pj4gaW5kZXggMWViMDVjMjlmYy4uNzg4ZWQ0MjQ3NyAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2
L2ludGVsX2lvbW11LmgNCj4+Pj4+Pj4gQEAgLTI2Miw2ICsyNjIsNyBAQCBzdHJ1Y3QgSW50ZWxJ
T01NVVN0YXRlIHsNCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgICAgICAgYm9vbCBjYWNoaW5nX21vZGU7
ICAgICAgICAgICAgICAvKiBSTyAtIGlzIGNhcCBDTSBlbmFibGVkPyAqLw0KPj4+Pj4+PiAgICAg
ICAgICBib29sIHNjYWxhYmxlX21vZGU7ICAgICAgICAgICAgIC8qIFJPIC0gaXMgU2NhbGFibGUg
TW9kZQ0KPj4+Pj4+PiBzdXBwb3J0ZWQ/ICovDQo+Pj4+Pj4+ICsgICAgYm9vbCBzY2FsYWJsZV9t
b2Rlcm47ICAgICAgICAgICAvKiBSTyAtIGlzIG1vZGVybiBTTSBzdXBwb3J0ZWQ/ICovDQo+Pj4+
Pj4+ICAgICAgICAgIGJvb2wgc25vb3BfY29udHJvbDsgICAgICAgICAgICAgLyogUk8gLSBpcyBT
TlAgZmlsZWQNCj4+Pj4+Pj4gc3VwcG9ydGVkPyAqLw0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICAg
ICBkbWFfYWRkcl90IHJvb3Q7ICAgICAgICAgICAgICAgIC8qIEN1cnJlbnQgcm9vdCB0YWJsZSBw
b2ludGVyICovDQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+Pj4gaW5kZXggZTM0NjVmYzI3ZC4uYzEzODJhNTY1
MSAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4+ICsr
KyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+PiBAQCAtMzg3Miw3ICszODcyLDEzIEBA
IHN0YXRpYyBib29sDQo+Pj4+IHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZQ0KPj4+Pj4+
PiAqcywgSG9zdElPTU1VRGV2aWNlICpoaW9kLA0KPj4+Pj4+PiAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPj4+Pj4+PiAgICAgICAgICB9DQo+Pj4+Pj4+DQo+Pj4+Pj4+IC0gICAgcmV0dXJu
IHRydWU7DQo+Pj4+Pj4+ICsgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+Pj4+Pj4g
KyAgICAgICAgLyogQWxsIGNoZWNrcyByZXF1ZXN0ZWQgYnkgVlREIG5vbi1tb2Rlcm4gbW9kZSBw
YXNzICovDQo+Pj4+Pj4+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPj4+Pj4+PiArICAgIH0NCj4+
Pj4+Pj4gKw0KPj4+Pj4+PiArICAgIGVycm9yX3NldGcoZXJycCwgImhvc3QgZGV2aWNlIGlzIHVu
c3VwcG9ydGVkIGluIHNjYWxhYmxlIG1vZGVybg0KPj4+Pj4+PiBtb2RlIHlldCIpOw0KPj4+Pj4+
PiArICAgIHJldHVybiBmYWxzZTsNCj4+Pj4+Pj4gICAgICB9DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAg
ICAgc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lk
ICpvcGFxdWUsDQo+Pj4+Pj4+IGludCBkZXZmbiwNCj4+Pj4+Pj4gQEAgLTQyNjIsOSArNDI2OCw5
IEBAIHN0YXRpYyBib29sDQo+Pj4+IHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZQ0K
Pj4+Pj4+PiAqcywgRXJyb3IgKiplcnJwKQ0KPj4+Pj4+PiAgICAgICAgICAgICAgfQ0KPj4+Pj4+
PiAgICAgICAgICB9DQo+Pj4+Pj4+DQo+Pj4+Pj4+IC0gICAgLyogQ3VycmVudGx5IG9ubHkgYWRk
cmVzcyB3aWR0aHMgc3VwcG9ydGVkIGFyZSAzOSBhbmQgNDggYml0cyAqLw0KPj4+Pj4+PiAgICAg
ICAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfMzlCSVQpICYmDQo+Pj4+Pj4+IC0g
ICAgICAgIChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSkgew0KPj4+Pj4+PiArICAg
ICAgICAocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYNCj4+Pj4+Pj4gKyAgICAg
ICAgIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+Pj4+IFdoeSBkb2VzIHNjYWxhYmxlX21vZGVy
biBhbGxvdyB0byB1c2UgYSB2YWx1ZSBvdGhlciB0aGFuIDM5IG9yIDQ4Pw0KPj4+Pj4+IElzIGl0
IHNhZmU/DQo+Pj4+PiBUaGUgY2hlY2sgZm9yIHNjYWxhYmxlX21vZGVybiBpcyBpbiBwYXRjaDE0
Og0KPj4+Pj4NCj4+Pj4+IGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYg
cy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+Pj4+Pg0KPj4+Pj4gZXJyb3Jfc2V0ZyhlcnJwLCAiU3Vw
cG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBhcmU6ICVkIiwNCj4+Pj4+IFZURF9IT1NUX0FXXzQ4
QklUKTsNCj4+Pj4+DQo+Pj4+PiByZXR1cm4gZmFsc2U7DQo+Pj4+Pg0KPj4+Pj4gfQ0KPj4+Pj4N
Cj4+Pj4+IExldCBtZSBrbm93IGlmIHlvdSBwcmVmZXIgdG8gbW92ZSBpdCBpbiB0aGlzIHBhdGNo
Lg0KPj4+PiBZZXMsIHlvdSBhcmUgcmlnaHQsIGl0IHdvdWxkIGJlIGJldHRlciB0byBtb3ZlIHRo
ZSBjaGVjayBoZXJlLg0KPj4+Pg0KPj4+PiBCdXQgSSB0aGluayB0aGUgZmlyc3QgY2hlY2sgc2hv
dWxkIGFsc28gZmFpbCBldmVuIHdoZW4gc2NhbGFibGVfbW9kZXJuDQo+Pj4+IGlzIGVuYWJsZWQg
YmVjYXVzZSB2YWx1ZXMgb3RoZXIgdGhhbiAzOSBhbmQgNDggYXJlIG5vdCBzdXBwb3J0ZWQgYXQg
YWxsLA0KPj4+PiB3aGF0ZXZlciB0aGUgbW9kZS4NCj4+Pj4gVGhlbiwgd2Ugc2hvdWxkIGNoZWNr
IGlmIHRoZSB2YWx1ZSBpcyB2YWxpZCBmb3Igc2NhbGFibGVfbW9kZXJuIG1vZGUuDQo+Pj4gUmln
aHQsIEkgd3JvdGUgdGhhdCB3YXkgd2l0aCBhIHBvc3NpYmxlIHBsYW4gdG8gc3VwcG9ydA0KPj4g
VlREX0hPU1RfQVdfNTJCSVQuDQo+PiA1MiBvciA1Nz8NCj4gU29ycnksIEkgbWVhbiA1Ny4NCj4N
Cj4+PiBXaGF0IGFib3V0IHRoaXM6DQo+Pj4NCj4+IFRoaXMgY29uZGl0aW9uIHRyYXBzIChub24t
c2NhbGFibGUpIGxlZ2FjeSBtb2RlIGFzIHdlbGwuIEkgdGhpbmsgd2UNCj4+IHNob3VsZCBjaGFu
Z2UgdGhlIGVycm9yIG1lc3NhZ2UgdG8gbWFrZSBpdCBjbGVhcg0KPj4gU29tZXRoaW5nIGxpa2Ug
dGhpczogIkxlZ2FjeSBhbmQgbm9uLW1vZGVybiBzY2FsYWJsZSBtb2Rlczogc3VwcG9ydGVkDQo+
PiB2YWx1ZXMgZm9yIGF3LWJpdCBhcmUgLi4uIg0KPj4gT3Igd2UgY291bGQgbWFrZSB0aGUgZXJy
b3IgbWVzc2FnZSBjb25kaXRpb25hbC4NCj4gWWVzLCBJJ2QgbGlrZSB0byBiZSBjb25kaXRpb25h
bCwgbGlrZToNCj4NCj4gICAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfMzlCSVQp
ICYmDQo+ICAgICAgICAgIChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJg0KPiAg
ICAgICAgICAhcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+ICAgICAgICAgIGVycm9yX3NldGcoZXJy
cCwgIiVzIG1vZGU6IHN1cHBvcnRlZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCwgJWQiLA0K
PiAgICAgICAgICAgICAgICAgICAgIHMtPnNjYWxhYmxlX21vZGUgPyAiU2NhbGFibGUgbGVnYWN5
IiA6ICJMZWdhY3kiLA0KPiAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FXXzM5QklULCBW
VERfSE9TVF9BV180OEJJVCk7DQo+ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICB9DQpG
aW5lLA0KbGd0bQ0KDQogPmNtZA0KPj4+ICAgICAgIGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9T
VF9BV18zOUJJVCkgJiYNCj4+PiAgICAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdf
NDhCSVQpICYmDQo+Pj4gICAgICAgICAgICFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiAgICAg
ICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU2NhbGFibGUgbGVnYWN5IG1vZGU6IHN1cHBvcnRlZCB2
YWx1ZXMgZm9yIGF3LWJpdHMNCj4+IGFyZTogJWQsICVkIiwNCj4+PiAgICAgICAgICAgICAgICAg
ICAgICBWVERfSE9TVF9BV18zOUJJVCwgVlREX0hPU1RfQVdfNDhCSVQpOw0KPj4+ICAgICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+Pj4gICAgICAgfQ0KPj4+DQo+Pj4gICAgICAgaWYgKChzLT5hd19i
aXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJiBzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiAg
ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU2NhbGFibGUgbW9kZXJuIG1vZGU6IHN1cHBvcnRl
ZCB2YWx1ZXMgZm9yIGF3LQ0KPj4gYml0cyBpczogJWQiLA0KPj4+ICAgICAgICAgICAgICAgICAg
ICAgIFZURF9IT1NUX0FXXzQ4QklUKTsNCj4+PiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+
ICAgICAgIH0NCj4+DQo+Pj4gVGhhbmtzDQo+Pj4gWmhlbnpob25nDQo=

