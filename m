Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C2AC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 02:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wz3-0003Sb-9N; Wed, 02 Sep 2026 22:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wz2-0003QG-AA; Wed, 02 Sep 2026 22:15:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wyz-0005yL-5Z; Wed, 02 Sep 2026 22:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788401717; x=1819937717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fX64w0Nx9pYMfBsQFUbZtKTwW8XCpdFZpf9kamx8Gek=;
 b=Eg005bkeZRBGIC2U4Zec27/jcVtGFxe4AHITMMarn/VDaIHgA3UcI2ju
 NaZ8moI/a0ZRQIJfL5lp4Oc3DqezxKMEhezT3/qHHEFtt6pp4eUnbMJyJ
 MLTO8YtSEcfcwC2oz42izPPL7fKWQ8dieFR9iydbF8/NNIfUsAbWqKVwG
 zrStkYxrwYd/GHGbKtVDjZIohYkMJ+oSxUTDM+4tUO32cRO1SDPCjyuIs
 YztsxrtYGf2+a5/85wqI4QpVfLJCRXFtDSQplI3Zaf3/HBqMf6upSMsV+
 wBqicLSMdLq0ofKB7OdkDVHo7y0a9t14jMGBZUdic0FmpnvFAvBEh7O2R A==;
X-CSE-ConnectionGUID: AF61QAdLQ/O9FvzMoF6f2w==
X-CSE-MsgGUID: VN/ZnnFQS9KPcA6FgLhS0w==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="154837698"
Received: from mail-eastus2azon11010019.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.19])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 10:15:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0NFOgmqhmVnPMIdnHhTmylh9w0lW+f9uOgSTN+Gj2gkYDvGgafDvc/v0g1jWzThPAC9LiS67ipHwdgCrenkO/9hV0JV3aXX4G80AQ17Qgj4xR3tRYfWq/gMMZr8u+PlmTnKptAk2cQavY4c2b6yCBaICoAEGgJCM5fFasx4CkWA3ZLg057mP0dl65IWwTSoWUi+tX26VhEAUTf7eSmQZ3YeABdxcENsfsyieZCsS09R5GBLdpqo9msCUwsaxnajd3DLE9bFDL7U2QczYUeQGvQkDNJAi7O54xLTSpalDdVH9KpqISM/q0afaL4mJuRfaq9HVinPMMG6xekNrwZ5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX64w0Nx9pYMfBsQFUbZtKTwW8XCpdFZpf9kamx8Gek=;
 b=shxNiybDiE4UTPmv6lwSsj95+2FcmAoG6QLSdUJMRLplIAagLf8WALMUd3qrHVUK46GHX4TT4Akr1lPfyvNT3CnXf0hMGskJX72AU3WiKmVu4QALALiiXHe9yaJkpK+WJDz+QGyPWrf4W0DxMv301+bXxj0MuO9Y/Y2Eqr1eYtrFy9mOhhOi9X+UMZ+dG9rSpqFzY2Hz7tygIpiZUshIdlALRl24Re2NotzpHJRxWWXPvzYKXaRs8nDjaOHHMwbjOLMQn/+AUqd43gjXc7snTZSgCXwRDnv4G0HejQ6Xkc4A2gw10dFg8B357Q2KLt44Nb0hrGpCmjhsSLAfba/hYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX64w0Nx9pYMfBsQFUbZtKTwW8XCpdFZpf9kamx8Gek=;
 b=qvc9XOz2QLKqprIf3vFBEsHZTURWfX/0ZIx1rHuD5UlundFlesDG8sZ/UKVr9EmP7PEcs/z60EqIkUp+B7hTx3tD+mi90Fbnncbsg03N+cu3y8T8LOoRiGnIoQB5Fndt7siyem+Oo9roCrshh/pKDhqXFab0woCZTGHFgfNToYU=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY5PR04MB6422.namprd04.prod.outlook.com (2603:10b6:a03:1ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:15:00 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 02:15:00 +0000
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
Subject: Re: [PATCH v2 16/16] hw/riscv/atlantis: Map the SoC through a memory
 container
Thread-Topic: [PATCH v2 16/16] hw/riscv/atlantis: Map the SoC through a memory
 container
Thread-Index: AQHdOO7NEhCXZEEphE6zac2Xrjkwa7a8IisA
Date: Thu, 3 Sep 2026 02:14:59 +0000
Message-ID: <fd3549281eee64c2d1d10d5d94f1b1ef34a3ead4.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-17-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-17-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY5PR04MB6422:EE_
x-ms-office365-filtering-correlation-id: 84309c15-1279-4e40-cac4-08df09612824
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|366016|376014|7416014|10070799003|38070700021|10067099003|11063799006|22082099003|18002099003|4143699003|56012099006;
x-microsoft-antispam-message-info: pTB18z7+xnRKtZijVCutfgKFG9iE90uCjUo/+7nOMir4+AkF1AWwTJFC2uQS1TZ8uRyugi2H4+fEhb7yhmETIqv+RtW+wQXSFSQmSbHavqAZ6n9EphyFwhEn4OIxU9tOhPPqVVPKA+dMXr66IK9oHU88ZuyGUnNIhfWOX2DHFBzFfxob8xo9Q4n7NeQwAtOVPhKpGJJCV+4OruoNHQ0QJzKpcrqSQmf2UwE1Aeks0ye0L/IhBL70z9ssxBr60467h6Hy6vspIBSnu1M8HLlWjqthOJKuutP4ngKn/HVhBKUNVy9vivPCdRjR5aufHShl+qCLGuRFCtTFVOYOu2p9rncmpRqnKOgJoBGyYHzypADzTvErjQXPt8f+6SWFSV+HDGDRBKziAt3fJPMzybjDjfR8eZdkj32A3H/CDYsqn1b8zZxoiXckLO4oBCO5djpwjkSnArf/n+XaCxyhPVKzPtKSqd/DaeEyMBJzYdBAtjLwFMNbAPtEt8Xos6uxWHrVCNCU1qYDr0hbnChaEDnVIVoOJltpMjZjaXJFiHLDJVP7beHtFfoULqUBGrRB5aD7oggtlHEpdMGf/36OZVNulWR+2XHu8Y0FAz1+KpG9RxtXWnuFPvB038ntzNgHeP6rkyZvPqsBX3MRiK5HXE7EDI+BpbAfjJWdILaSItDdsoRf6/afPzv1B+3DOSXA4MyWSXZzZv7sZUtmnTj0YDoNMb5OAoIUgoV2X9On7K4rtIQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(366016)(376014)(7416014)(10070799003)(38070700021)(10067099003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJFa0tTVUNIWVNhNUszS1F5MnB4NVAwVzNVQTAxY2p3SUZPd0NVUUlmbnNp?=
 =?utf-8?B?ZWJKTTMrR2RSYWE2d25xZUZza0hyOVA1UEJLaFZVNXErZGZjRzRmc2YvYkdS?=
 =?utf-8?B?SUZoM2QxeDRWUnAvRG1sdXNlQnlsSU9EV1o5VWswZVRmczU3Q0ttVCtvVytz?=
 =?utf-8?B?eERwUndDOUFsRi9mM3l2TFJ0TG9oVjVKNmduWnRvOG5LdDNadGxiRTJmZGx4?=
 =?utf-8?B?ZnJPWitzVmRzVDFLY1lWMksvWkRZS2haWmdvSmFPZUJ6cFEvTGZ4aGtHSVV6?=
 =?utf-8?B?MStLTVdDa0kySHRMV1c5STFENWpwZ2JBV0hhK3IrU01uTWtrNUJhSys2ektp?=
 =?utf-8?B?dkFvdTNJbUUvWC9vMW9WNXZzMnpjYSs4Yjk0dklNVk9SczdIUWRMeXdNY3g5?=
 =?utf-8?B?MXVOaUo2dWx4eWIxVlFaMXdXdG9wUS91eVhRaUo2RWZpcEFVU0ZsOEs5VUdK?=
 =?utf-8?B?SzhCVnlTcnp5eUhEeVIxT1ovZ2hSYkRhNitqbHBNWlRCdnpRaTVYN1ZydkxJ?=
 =?utf-8?B?dU9kZjdjcE0wbXJmalkrcXJzQlV1dlZpai93aUFiMXJUQ0JVL2ZObWZhTnMv?=
 =?utf-8?B?OFUzZnlhVzlHQjZRbXlOKzFBQ0tsWGlidFk0L0NUa3pSMndQRFRZYzlNejBB?=
 =?utf-8?B?QmlPQ283WVZPKzJDOHE4VXlrM21JYkRzSDhmS3VtVTBMYjFxbnY2QytXZ044?=
 =?utf-8?B?Z0lCcXRPMU1BbFEwWXJ0SFRTUG1peHl5WXVWZU5WYUYyNDV1WGlGVU9YVXdO?=
 =?utf-8?B?UnJ5Vm02SUVwOGRuNU5ha1NhaWY1ZHZqaTVLTElUSzNycUY1T1AzckdVSWJm?=
 =?utf-8?B?TGVrMG02WkNNQjR0THFxbGQ2azg0K0I3dEp0Z092aTFWUXlqNTQ3NXR3Zy8x?=
 =?utf-8?B?eHVCMVE2RnVDS0crK0tJTUQrYVQxamRpcEM5bXdJNFUvVXp1RXRndUh1d0VY?=
 =?utf-8?B?bnA3RW5sakNQNlE0Z2h2dGVqbXRPT3N3SmZpMmVWdTNKZWFFNUd6Wjlsb21i?=
 =?utf-8?B?UzhlSG03bU1DQytwd2ljUGhDcVZ0MlErOXpvQmZUaEhGWFRuTUkxcFZudWc3?=
 =?utf-8?B?cjVVVHZMS0kyeVpFL29WQjFpWWJJbWNTczdqZ0lyMjhlcENuT0pUUVVicE1h?=
 =?utf-8?B?aE1aVUx2V3FpRU5oLzlUUk94RWFVOURQRkp5YWN4NkU3amkxWUh0amIvTlM5?=
 =?utf-8?B?bWFHM3B5QndybzdVOEpkZU4rU2dmQndia2xwczdiSS9VT2FxK1FYV2JaRkNm?=
 =?utf-8?B?Z3liNUk1aHNMVU1WZlBsWVlYV0pFOElkbFp2MnJZY09JUEtaM0RGdUtneDgw?=
 =?utf-8?B?SDFmWjNKaThYempaTitrOWhaMzk0UFhrbThQTGMrZ0M3TzZydkw4QXhpU1Fs?=
 =?utf-8?B?bGM2VHF1djM4SG9hYlNiYkZHWVpRT0ljQXBFYzhSbVdEWitaQml4RjVpVTNt?=
 =?utf-8?B?RHdIS0l2bVhmazhoVlJkS0VteFBpT3gwNHFRMHI2bEZhV1NPdEpzdExVdnY2?=
 =?utf-8?B?SDZEVW5zRloxYVlmTHlJdG8wOFBzVGVpMXk0OGx1Z3pYV2Z1VzlOQ1NDYUVF?=
 =?utf-8?B?cWlTVzd5aExLUFdJRkQxY0ErRkFxVjNDdm16SjhyaFlTWDYrejEwZHdpcHVk?=
 =?utf-8?B?dVh5VG9NSE56aitUVFR4b3VvOVd5ek5UVHlhRkZ2dTBNTlNMdWdYUkFQMktI?=
 =?utf-8?B?enNCZE1jRndnd2hMc0REcFBNdm85eWxBclZRRFZMbkZyNVpJVDI1NXQ0eitB?=
 =?utf-8?B?SmFSYTBoOS8rZzYvdGkrbzBDV2JpQVRKVWNrM0RwcFNLSUYvVUpPVU1EV1l3?=
 =?utf-8?B?am84YlRuRlcyMmpncU1IaXU5NnpsZ3duSlJaN3dqcTFITFZEa05xcHlBd1pa?=
 =?utf-8?B?UHRWOUNISmFHZ0FGNWFJVlJZbzZuek40K1d0WGdKV1pNN2l3clRBSi9zNEZH?=
 =?utf-8?B?cDhCTFJaZ0ZpaE90MDRNZFAvSDZnTFB2MmxDUDZzMUdMRS9KU2hqMTgxVUxC?=
 =?utf-8?B?NC9UVUlwclR3eEQ0WSt3eEpobGdRdFN4WVFuaXF5VHNPdmFuaVBQZFZheTdx?=
 =?utf-8?B?dEpJU0VSZTJWK0FyS0lUWUdpOWRDaEo2b1RXQlRUTXMvM2hHby9UeW5SRWI2?=
 =?utf-8?B?TVZmRHJWMmw2NUVkM0VlNVB1YzdrdHRJRW5vWElMdUtMTDVGMkxpQnc3bTF6?=
 =?utf-8?B?a3BnbTNPblc3dDVHWFlLYXBZdlNTNkhRWlJUYm1rUmQ3NzltM0NCeTFINWVh?=
 =?utf-8?B?WHdRMzY5NXppV1ZsMDRCRU4ycW1DTjcveUtXc3FEQ2hzYXBYRW1manNlcmJW?=
 =?utf-8?B?bDh5ZTlQYlRtNGhZRmFRc2paVGswcWVIR3o1ZzNlZkQvYzUvMXhXWGhXUDF3?=
 =?utf-8?Q?uhMupyBeKQ8YbkGW/jFzqouv3g0C9j4DqbB7tDBWLl5Rl?=
x-ms-exchange-antispam-messagedata-1: oBO4Y63pwVj+6QEzmAz/8sEAiA2L28ct0tQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D87D612E0BAE548AA1BAA172AE803F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JAmDL1Z/QimLQ/05Ozf4AFGGNqRnOuAysSMEPitC7wFNc0bQkEkw5GM2UEm7FyPJAvi0KZIOLNwWFlY1UOI6MZktuOnzst+YMEWR1Oufe0lLRlEzTnO6dcEni+91Uec8fhHZHYEhkZw3bOD7VgibFf/juEI3CiDIYVjfcp8HTAfcM9iWIkKkEfKkxCy4YszbaIUl/bG0bFHtSwnAOMpf9HfOnIJPkuk78KxpDK0q4FvZY4dPjO/K/Pkg1I+LGb+ViguS/ZhMLRFoSeD+28kV7ZmndW2ML0HaI93IlrowKoHir3m1jfvQtuRHTUHiAZxEClkUfCmFq4BOLfc5QwcdmA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YpH3CfQHldqBH3GaP+mlORNhA8cDOQJdB/h+MXLbJFzKM+1ISj6QMje6yC1cU/PkAyFSCmyImbbb/fF3TQ56vtgOMHJEQME81wBidSW+8WpwWDqBQuRIGdF6e2LWg6fZgh7Ntq5K7OyiUpKKNf10yqWbN8gOQBVd+HCy+ZVSecAFA9DjQJAynAYjF+BvSETvQMGndXmFA0jCgYrMEHQwOGTAC7wwaSAhBBHqJPqll+8M3ht3sCeW3EBAqHy+DVW2zy3isqRhsX60iO8Z2VN6w3lBTRFARbt+clpbVJR4L/vz8oiKA8h4Df/dX3YnFu8M6XDnR/VLKfrS82cbt+HB6bOZz2lI/VVzdoMvUXXJgsqPIvPeGMVoSiNMbClWdsx0OyxFYue4N9aAsEc1rCnwN54jCdVpow7sUOc1UM2TVHst10hJJtd3TTTn6ATILzQ7/YCloTYuRSY58XPIh0Y69OBTtafYABoSyPPlqJZ5DMEL+pn7GbVXQxXSc79hZdXuFPO/LYrFphA6sX9HQvl0cWYH4BdeGdHMh1t1D8trKcxVCuKd6QC/xENpx/5JmL2Ab/tgkNrup6Y5cy+6IysVerWC49wHV5cczqD3IJWnn3oIBX2tNVrhmN3GPTKu7Hd5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84309c15-1279-4e40-cac4-08df09612824
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 02:14:59.9514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mj/nwTJHtF26S+ywVt8+HYOB/LV+vsqtcnq2j3SW3wBy7mLOLqaHIhfn6ELvdmMkPT2pN8/jHctIJ0S9cyD3o/mFW9zHD7GFCmRgB9LLjn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6422
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
R2l2ZSB0aGUgQXRsYW50aXMgU29DIGEgJ21lbW9yeScgbGluayBwcm9wZXJ0eS4gVGhlIG1hY2hp
bmUgY3JlYXRlcyBhCj4gY29udGFpbmVyIE1lbW9yeVJlZ2lvbiwgbWFwcyBpdCBhdCBhZGRyZXNz
IDAgb2Ygc3lzdGVtIG1lbW9yeSwgYW5kCj4gcGFzc2VzIGl0IHRvIHRoZSBTb0MgdG9nZXRoZXIg
d2l0aCB0aGUgbWFjaGluZSBSQU0uIFRoZSBTb0MgbWFwcwo+IGRldmljZXMKPiBpbnRvIHRoZSAn
bWVtb3J5JyBjb250YWluZXIgaW5zdGVhZCBvZiBzeXN0ZW0gbWVtb3J5LCBhbGxvd2luZwo+IFRU
QXRsYW50aXNTb0NTdGF0ZSB0byBiZSBjb21wb3NlZCB0b2dldGhlciB3aXRoIG90aGVyIFNvQ3Mg
aW4gdGhlCj4gZnV0dXJlLgo+IAo+IFRoaXMgcHJlcGFyZXMgdGhlIG1hY2hpbmUgZm9yIGFkZGlu
ZyBvdGhlciBtaWNyb2NvbnRyb2xsZXJzIHRoYXQKPiBzaGFyZQo+IHRoZSBtZW1vcnkgYnVzIHdp
dGggdGhlIEFzY2Fsb24gY29tcGxleCAoYWthIHRoZSBBdGxhbnRpcyBTb0MpLCBidXQKPiB3aXRo
Cj4gdGhlaXIgb3duIHZpZXcgb2YgdGhlIGFkZHJlc3MgbWFwLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBpbmNs
dWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmggfMKgIDEgKwo+IMKgaHcvcmlzY3YvdHRfYXRsYW50
aXMuY8KgwqDCoMKgwqDCoMKgwqAgfCAxNyArKysrKysrKysrKysrKystLQo+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgKPiBiL2luY2x1ZGUvaHcvcmlzY3YvdHRf
YXRsYW50aXMuaAo+IGluZGV4IDVkNGU0ZDEzM2JkOS4uMzkyMzMwOGI3Yzg5IDEwMDY0NAo+IC0t
LSBhL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+ICsrKyBiL2luY2x1ZGUvaHcvcmlz
Y3YvdHRfYXRsYW50aXMuaAo+IEBAIC01Myw2ICs1Myw3IEBAIHN0cnVjdCBUVEF0bGFudGlzU3Rh
dGUgewo+IMKgwqDCoMKgIC8qPCBwdWJsaWMgPiovCj4gwqDCoMKgwqAgTm90aWZpZXIgbWFjaGlu
ZV9kb25lOwo+IMKgCj4gK8KgwqDCoCBNZW1vcnlSZWdpb24gc29jX21lbW9yeTsKPiDCoMKgwqDC
oCBUVEF0bGFudGlzU29DU3RhdGUgc29jOwo+IMKgfTsKPiDCoAo+IGRpZmYgLS1naXQgYS9ody9y
aXNjdi90dF9hdGxhbnRpcy5jIGIvaHcvcmlzY3YvdHRfYXRsYW50aXMuYwo+IGluZGV4IGQyYjI5
ZmYxYTQ3Ny4uYjc4YjRhNWVhMzFlIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3R0X2F0bGFudGlz
LmMKPiArKysgYi9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gQEAgLTUwMyw4ICs1MDMsMTAgQEAg
c3RhdGljIHZvaWQgdHRfYXRsYW50aXNfc29jX3JlYWxpemUoRGV2aWNlU3RhdGUKPiAqZGV2LCBF
cnJvciAqKmVycnApCj4gwqDCoMKgwqAgcmFtX2FkZHJfdCBsb19yYW1fc2l6ZSwgcmFtX3NpemU7
Cj4gwqDCoMKgwqAgaW50IGhhcnRfY291bnQgPSBzLT5udW1faGFydHM7Cj4gwqAKPiAtwqDCoMKg
IHMtPm1lbW9yeSA9IGdldF9zeXN0ZW1fbWVtb3J5KCk7Cj4gLQo+ICvCoMKgwqAgaWYgKCFzLT5t
ZW1vcnkpIHsKPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiJ21lbW9yeScgbGlu
ayBpcyBub3Qgc2V0Iik7Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPiArwqDCoMKgIH0KPiDC
oMKgwqDCoCBpZiAoIXMtPmRyYW0pIHsKPiDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJy
cCwgIidkcmFtJyBsaW5rIGlzIG5vdCBzZXQiKTsKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsK
PiBAQCAtNTIzLDYgKzUyNSw4IEBAIHN0YXRpYyB2b2lkIHR0X2F0bGFudGlzX3NvY19yZWFsaXpl
KERldmljZVN0YXRlCj4gKmRldiwgRXJyb3IgKiplcnJwKQo+IMKgwqDCoMKgIG9iamVjdF9wcm9w
ZXJ0eV9zZXRfaW50KE9CSkVDVCgmcy0+Y3B1cyksICJyZXNldHZlYyIsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVtbWFwW1RU
X0FUTF9CT09UUk9NXS5iYXNlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICZlcnJvcl9hYm9ydCk7Cj4gK8KgwqDCoCBvYmplY3RfcHJv
cGVydHlfc2V0X2xpbmsoT0JKRUNUKCZzLT5jcHVzKSwgIm1lbW9yeSIsIE9CSkVDVChzLQo+ID5t
ZW1vcnkpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAmZXJyb3JfYWJvcnQpOwo+IMKgwqDCoMKgIGlmICghc3lzYnVzX3JlYWxpemUo
U1lTX0JVU19ERVZJQ0UoJnMtPmNwdXMpLCBlcnJwKSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+IMKgwqDCoMKgIH0KPiBAQCAtNjE0LDYgKzYxOCw4IEBAIHN0YXRpYyB2b2lkIHR0X2F0
bGFudGlzX3NvY19yZWFsaXplKERldmljZVN0YXRlCj4gKmRldiwgRXJyb3IgKiplcnJwKQo+IMKg
c3RhdGljIGNvbnN0IFByb3BlcnR5IHR0X2F0bGFudGlzX3NvY19wcm9wc1tdID0gewo+IMKgwqDC
oMKgIERFRklORV9QUk9QX1NUUklORygiY3B1LXR5cGUiLCBUVEF0bGFudGlzU29DU3RhdGUsIGNw
dV90eXBlKSwKPiDCoMKgwqDCoCBERUZJTkVfUFJPUF9VSU5UMzIoIm51bS1oYXJ0cyIsIFRUQXRs
YW50aXNTb0NTdGF0ZSwgbnVtX2hhcnRzLAo+IDgpLAo+ICvCoMKgwqAgREVGSU5FX1BST1BfTElO
SygibWVtb3J5IiwgVFRBdGxhbnRpc1NvQ1N0YXRlLCBtZW1vcnksCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9NRU1PUllfUkVHSU9OLCBNZW1vcnlSZWdp
b24gKiksCj4gwqDCoMKgwqAgREVGSU5FX1BST1BfTElOSygiZHJhbSIsIFRUQXRsYW50aXNTb0NT
dGF0ZSwgZHJhbSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
VFlQRV9NRU1PUllfUkVHSU9OLCBNZW1vcnlSZWdpb24gKiksCj4gwqB9Owo+IEBAIC02MzMsMTIg
KzYzOSwxOSBAQCBzdGF0aWMgdm9pZAo+IHR0X2F0bGFudGlzX21hY2hpbmVfaW5pdChNYWNoaW5l
U3RhdGUgKm1hY2hpbmUpCj4gwqDCoMKgwqAgVFRBdGxhbnRpc1N0YXRlICphbXMgPSBUVF9BVExB
TlRJU19NQUNISU5FKG1hY2hpbmUpOwo+IMKgwqDCoMKgIFRUQXRsYW50aXNTb0NTdGF0ZSAqcyA9
ICZhbXMtPnNvYzsKPiDCoAo+ICvCoMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0KCZhbXMtPnNvY19t
ZW1vcnksIE9CSkVDVChtYWNoaW5lKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgInR0LWF0bGFudGlzLnNvYy1tZW1vcnkiLCBVSU5UNjRfTUFYKTsKPiAr
wqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihnZXRfc3lzdGVtX21lbW9yeSgpLCAw
LCAmYW1zLQo+ID5zb2NfbWVtb3J5KTsKPiArCj4gwqDCoMKgwqAgb2JqZWN0X2luaXRpYWxpemVf
Y2hpbGQoT0JKRUNUKG1hY2hpbmUpLCAic29jIiwgJmFtcy0+c29jLAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRZUEVfVFRfQVRMQU5U
SVNfU09DKTsKPiDCoMKgwqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X3N0cihPQkpFQ1QoJmFtcy0+
c29jKSwgImNwdS10eXBlIiwgbWFjaGluZS0KPiA+Y3B1X3R5cGUsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2Fib3J0KTsK
PiDCoMKgwqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X2ludChPQkpFQ1QoJmFtcy0+c29jKSwgIm51
bS1oYXJ0cyIsIG1hY2hpbmUtCj4gPnNtcC5jcHVzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZlcnJvcl9hYm9ydCk7Cj4gKwo+ICvC
oMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVCgmYW1zLT5zb2MpLCAibWVtb3J5
IiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgT0JKRUNUKCZhbXMtPnNvY19tZW1vcnkpLAo+ICZlcnJvcl9hYm9ydCk7Cj4gwqDCoMKg
wqAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVCgmYW1zLT5zb2MpLCAiZHJhbSIsCj4g
T0JKRUNUKG1hY2hpbmUtPnJhbSksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZXJyb3JfYWJvcnQpOwo+IMKgwqDCoMKgIHFkZXZf
cmVhbGl6ZShERVZJQ0UoJmFtcy0+c29jKSwgTlVMTCwgJmVycm9yX2ZhdGFsKTsK

