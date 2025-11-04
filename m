Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECE4CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHu5-0003hh-Du; Tue, 04 Nov 2025 09:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pierre-eric.Pelloux-prayer@amd.com>)
 id 1vGDxD-0007Vi-MU
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:07:55 -0500
Received: from mail-westusazon11010007.outbound.protection.outlook.com
 ([52.101.85.7] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pierre-eric.Pelloux-prayer@amd.com>)
 id 1vGDx9-0008BC-1H
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:07:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfurlIqnetLwgVCDYK3HWqfyTqaICoPSofQzf/D1HEPDVdd1as0Ey248xDkR1Ca1zEc7FwgBpvHtzGT98wZHWYntSY54VfQ4VQiFjsxhLipMUNfmufU+/8QQegXCTFgF4gyH0IqIMfR/VPGBWQUKjL/v0S+YgIXEmOxC51ldFbS/IEMaycEOPOwQ1U5iW5aib4XrUl68j+uJudprP+oPq/zGC5e0uogKME/E9WRyrwhZfRefIexCnjOBmpxnZswu5HxI+DDLA5NvdMZTuxLiw0xAUTfnDChG1dsacBRzT8R+GB1oFCAEHuY3tfLGJKwOR13HQj+nubesB0IZs5bA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rb9BioZj1WwKTdxWrGUSeB9JIUWWS8rZI808tgHmwI=;
 b=mqg8zG8tZGcb65PmREZj+SrA62l5o7udC1WSSTf4R7tKhL9JyNM8f2LYmNvnMnjRKkEjwSNnnCgMyX/9LLv4cnpldF+xN3jZLoCucpF/W0BmWnog5iAakLN9k0ByMx204u/t8ZDZ7BePMxAzVu901XKcrk/d6WTs1SBNzKr4ZklyM2I1db42fuxPNB0OllK2vgODq4qrINPx3cKgefmF1arACwfqxtk1B6Q1ALa7pO+/xTHlLt3FfcGw5IwU43rpND//16zy51xO9cKkGasPgxXoQyLcHW0mMQMVEsEm+T3CFWhkuDR03C8elMGEq7HfrHLwiXS55BCGg/VuF7D1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rb9BioZj1WwKTdxWrGUSeB9JIUWWS8rZI808tgHmwI=;
 b=SG4nsIJ+Yy/Rn7XeG28j7C2pgGAXcVG8F2K+UBLK/jSb0PCPxrbmkcROXFy0PKDipeO9+1XntOl4nnt6x8bp0c6vyeuYsEL+UR0aupunBpovbWAFndaF35zEGH+bJE/ri9alxMlj1YATeDPgb+zyL23Z7J0/3EuZ2xpi27cqbLA=
Received: from DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) by
 SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 10:02:43 +0000
Received: from DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::6cd6:bbdf:298b:7d20]) by DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::6cd6:bbdf:298b:7d20%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 10:02:37 +0000
From: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Gerd Hoffmann
 <kraxel@redhat.com>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: Gert Wollny <gert.wollny@collabora.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>, =?iso-8859-1?Q?Roger_Pau_Monn=E9?=
 <roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
 <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>, Rob Clark
 <robdclark@gmail.com>, Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual
 <slp@redhat.com>
Subject: Re: [PATCH v14 00/10] Support virtio-gpu DRM native context
Thread-Topic: [PATCH v14 00/10] Support virtio-gpu DRM native context
Thread-Index: AQHcQhswOZdBVBrevEu00HlSpOFP5LTiX89q
Date: Tue, 4 Nov 2025 10:02:36 +0000
Message-ID: <DM8PR12MB543171EE8DB9CD0272C7A99D8DC4A@DM8PR12MB5431.namprd12.prod.outlook.com>
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-04T10:02:36.045Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5431:EE_|SN7PR12MB6984:EE_
x-ms-office365-filtering-correlation-id: 6def047f-0313-4704-00bb-08de1b894845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|13003099007|7053199007|8096899003|921020;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?o/eVh1O0yiDVtRxwfv4E+Orz6qRXpraA29u3mrRLHKPZsiD6TTI64HDMbu?=
 =?iso-8859-1?Q?ork4MO5e1hxd59+0vQupukKh9fBnbQfyYq9Up2lYwK4zJ+hrwKjEJT/SZ7?=
 =?iso-8859-1?Q?I9UycYSXJHm3KJQVo62zOQgS/SVF9+FjicHjdd/p1mv96A3LrsJgklAs1H?=
 =?iso-8859-1?Q?TblKG/XKwZwv8qAB2Xx4neFsvFKK82Scvk1qiFAsx52Qnwp0lhkLHrTO5p?=
 =?iso-8859-1?Q?T/ec/OcmEXuas33jRZVT14s4ocJPCmHsrqXivSFvfghdJt01CMnLZHj0oc?=
 =?iso-8859-1?Q?fquAudeTdr+gYlEjx+K7BneKnWzJRx0fHc5VwfjU+8WgUIZ0/ZA02sD29/?=
 =?iso-8859-1?Q?sF9rrX2yOYFgrByU1aUg4pTW+c9LakIm+qeYTyCoBrt8ReePwtLbNkopAU?=
 =?iso-8859-1?Q?I2ME0Mc83m8XU88NyFanfsEl2Ve34sOKT3jn4tNst5CbaP3mT6NQ/ZSTAi?=
 =?iso-8859-1?Q?GSCrhMBCcSN+RdolGU7QKUAsZ38h84NZxRgboCIY/C/NmWXm70I8OsmMuf?=
 =?iso-8859-1?Q?FIs0rqwen6wy6qMICTXZHQlnYDSvKzOcLj8W1ypZ3D1M5j//oK3xkKrXPD?=
 =?iso-8859-1?Q?6Hh4/1eRnf4D1kEIEsTtqQL6NRwbxDyqTHucqJKEJc5C5/iEja/BPZ91uK?=
 =?iso-8859-1?Q?EfIU2lHCYUgcz0ncH5uNOMrr6x2OCvLuKGbRMRylTMXXKetZy5/IWdpQkb?=
 =?iso-8859-1?Q?jXTQHUnWVINPUJ9Ea149jsj6ahAXyQNlxGVYwOca5DZw5+OUL7qIa4rfsI?=
 =?iso-8859-1?Q?IEToBuOJO1WUp2banfXn7291rtlbgfGc6ccXfZg/YyXHBr0/zMWTs/nmKw?=
 =?iso-8859-1?Q?YANUAsTjGMS2yDfJD96/T6feFpQp5M1FYxrKr8wiYwe/aI01Gl6vjCOVtV?=
 =?iso-8859-1?Q?77Wh6nQQVmxqDrVtjyWvzmIgGlN0jJqNZiYmzRdjlEvVXvUl887AsFo8Rm?=
 =?iso-8859-1?Q?f+L1WOcVlDqa7+IfPoKIl8IMoBXuL0MUs8eYOEn+jVZAFtq7gE2l3Mk56G?=
 =?iso-8859-1?Q?tyuyTvVIjXl3oYwL4LiqwJ7rge4wimFDdnb7A2ptpsCRYot//JEUAzJod4?=
 =?iso-8859-1?Q?3NEE4Fcp3G/aqtCeC7fplePKV7RxwctqC63Wezgf/jU9qqCNvMjA/+l5js?=
 =?iso-8859-1?Q?Sh0BeujxnIBpNVSYEsrpZyXhFwCeFBauhMubppG8x2XirH9ZdkPV0IDHFa?=
 =?iso-8859-1?Q?ZfQP6u5V4trnjCtixZHqru4HiizzYvA705cZJ6vw+NuqBast9aykoZHayx?=
 =?iso-8859-1?Q?urqbXZw/3OWGRDUHhRg+5zWjbVe2EoT8ni/t7CZ/css7V2tcbBWfYgjj7T?=
 =?iso-8859-1?Q?nU4/0bf+QmQ3qUManKLh3UC7yuRFRIWjfSYmqRKP3rT45BnMRCla6xEyOe?=
 =?iso-8859-1?Q?B3koiAdByQpwyRBFJlZXoIlBeIfnVEd25iCmsZ1A/4g7ks3/d1Q+5WdpAG?=
 =?iso-8859-1?Q?wDomZNzBDQ+OF+nxgFopkLjlldN2XxPhctb7kiKd8IEyjvwhDsK6gXugtR?=
 =?iso-8859-1?Q?sLGwGCSKCVKy5KHIZPjkyGtCmZ9LteLXTak8seOBHF/wglDgr9oNd1KhQ9?=
 =?iso-8859-1?Q?hS1vELQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5431.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(13003099007)(7053199007)(8096899003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WAUl1+lTpgah4eTmem295BpvbSkkYOU5V9Gc7pnve4EyGnkAheUbrKJMzR?=
 =?iso-8859-1?Q?rSQ2/l9sY2CXN0bAnQggcXUxe0FJOrLxibUCz45wGjGQ0AeqIOa+8j2Bl2?=
 =?iso-8859-1?Q?1A5izSUK7spxjUqj7Y0s7LIjPqzeLUPYag60i2N+/t81hvm4v0jLaZVIh0?=
 =?iso-8859-1?Q?KiG8iVfQPiyEK1ADV3jvQq+ciRRV24xzKAw74t1kXp9nH+KohFO35i3z4O?=
 =?iso-8859-1?Q?5Ch8Crz3Z56Jfo+wPBh5Wq4+h+8jzokWMdLHLKDTlqTFRzxU8PV6J9EMqK?=
 =?iso-8859-1?Q?nWfHgqdiVWnfpzvlSsptjzs+VjhQLZS/eKoZvekXDuCYIMdQySup7/6RMA?=
 =?iso-8859-1?Q?Kc3cnx+zpunDY5E8JUt9V5qOZAAIcdz1Z4fObyaICqTgZfNUQHcYzPAvy/?=
 =?iso-8859-1?Q?OaUfJlmx6cKP54iG6YXuON3r8YkKCtePGccRE/119MOe8Mc+XdWVTMJBv2?=
 =?iso-8859-1?Q?u92ukDChPexn/31V7i2tRcIBQGSRKkcn9XuK4tZY8az0iIgjMEq807lMIR?=
 =?iso-8859-1?Q?axpsKhWGqpUSe834svrET1El406W2JIkL0dDGn4SCksQhNRaKXVml91c+Q?=
 =?iso-8859-1?Q?U/TEheshd8uhMbex5GNajXQPXxgY9rTgSgkCLx042qfBirvOc4vChxhnnc?=
 =?iso-8859-1?Q?wTyxTkgqy5K/MTuVt2LPz0irIK9x5V/nZ8+hh41qBmCu+b7ZdHtU/BUhg4?=
 =?iso-8859-1?Q?+gPx/lj9OCenZ8MRS3RWgy0WsG9KF1+Dovr6P9ZJomxvA9HVxhqoO6svuN?=
 =?iso-8859-1?Q?NYL2t4ff58hv5y6M96gOPGHK2VcwhqQESggyz+wmURGcODKWj5ToKzszn6?=
 =?iso-8859-1?Q?0TsOXC9V7jMkPizlXe8nSglQFViqucr0OM2iDSjcZsHJ0je3F8ZPD5s5+q?=
 =?iso-8859-1?Q?+B6YDYRDLXiQUQoRK6TKKelBEs2xHb1ALmj3ik4h/Eu1i/Oznct/tHH8Lt?=
 =?iso-8859-1?Q?n+W89m6OUERJ6QFDS9BY/Zha7KwcNgUoXxz/YucRolM8cs0F3TddhejIDw?=
 =?iso-8859-1?Q?LHwo0/1/rBbyGCJ+WVwm8BpqAjxuXkjOzTZPY7aqJxOZkD5WCfnUAATirn?=
 =?iso-8859-1?Q?bRJGfPJHGqqwwFMpwFl7ZrsmuP7Zzbiq0ukOUXSozsNsx0x/Nr2yHOgr00?=
 =?iso-8859-1?Q?WVBH6KHDcm6RwTZOfVhHuHcXbBosc+FFf3hKdUzCuXvbxZ1V8ModxRwcS2?=
 =?iso-8859-1?Q?6jJ55IYp8ylxcvzjubABbpAzCpZYwaH99VBz3DX1PruMPrDZEV6CEjEQiS?=
 =?iso-8859-1?Q?2ZcWqUOUKZsbH7QcUTV59L/+VFV4c5Ckh1vB458Q6l6VH83iC2kxUVQfEJ?=
 =?iso-8859-1?Q?/5CESaakH60OLPMOnofKlMwEdsXqMo6E1mCZxI6wuPG9vijNwnfdyAiFcc?=
 =?iso-8859-1?Q?QJPtiT/tK0H8xjC/0eYzjIsv55NTU7tqptvGRgd3fqegBYI9BadJluPs7j?=
 =?iso-8859-1?Q?lxGshaGqCYciPN3kNG5IUoYAkOJ3k7tYMe8jz7TVqkc1s5/yMvCa0NGcfF?=
 =?iso-8859-1?Q?yl30bB/K1o1T98w9msG6E7px8sBTLof1tDafxaXbZKaqyqZbaQMNt/OP9M?=
 =?iso-8859-1?Q?4ub/dbbfpj8zxjD+dwQaFD/jDBZOC8OEGSY7yb7UA0BJ52PEJ5pFhnGaHf?=
 =?iso-8859-1?Q?1rNErrm8n5erQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR12MB543171EE8DB9CD0272C7A99D8DC4ADM8PR12MB5431namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6def047f-0313-4704-00bb-08de1b894845
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 10:02:37.0092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Rh7pXesXM+Xd8sxO3DQVxmLA8iA0FQXzcHB7wWAswXFzT57cJd69sAcIKkiJ5JipGMzNjGZowO48Tl+OornDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
Received-SPF: permerror client-ip=52.101.85.7;
 envelope-from=Pierre-eric.Pelloux-prayer@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Nov 2025 09:20:53 -0500
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

--_000_DM8PR12MB543171EE8DB9CD0272C7A99D8DC4ADM8PR12MB5431namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi,

The whole series is Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pello=
ux-prayer@amd.com>

Thanks a lot Dmitry!

Pierre-Eric

________________________________
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Sent: Tuesday, October 21, 2025 1:39 AM
To: Akihiko Odaki <akihiko.odaki@daynix.com>; Huang, Ray <Ray.Huang@amd.com=
>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>; Philippe Mathieu-Daud=
=E9 <philmd@linaro.org>; Gerd Hoffmann <kraxel@redhat.com>; Alex Benn=E9e <=
alex.bennee@linaro.org>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-p=
rayer@amd.com>; Michael S . Tsirkin <mst@redhat.com>; Paolo Bonzini <pbonzi=
ni@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>; qemu-devel@nongnu.org <qemu-de=
vel@nongnu.org>; Gurchetan Singh <gurchetansingh@chromium.org>; Alyssa Ross=
 <hi@alyssa.is>; Roger Pau Monn=E9 <roger.pau@citrix.com>; Deucher, Alexand=
er <Alexander.Deucher@amd.com>; Stabellini, Stefano <stefano.stabellini@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ragiadakou, Xenia <Xen=
ia.Ragiadakou@amd.com>; Huang, Honglei1 <Honglei1.Huang@amd.com>; Zhang, Ju=
lia <Julia.Zhang@amd.com>; Chen, Jiqian <Jiqian.Chen@amd.com>; Rob Clark <r=
obdclark@gmail.com>; Yiwei Zhang <zzyiwei@gmail.com>; Sergio Lopez Pascual =
<slp@redhat.com>
Subject: [PATCH v14 00/10] Support virtio-gpu DRM native context

This patchset adds DRM native context support to VirtIO-GPU on QEMU.

Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
DRM native context [1] mediates lower level kernel driver UAPI, which
reflects in a less CPU overhead and less/simpler code needed to support it.
DRM context consists of a host and guest parts that have to be implemented
for each GPU driver. On a guest side, DRM context presents a virtual GPU as
a real/native host GPU device for GL/VK applications.

[1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ

Today there are four DRM native context drivers existing in a wild:

  - Freedreno (Qualcomm SoC GPUs), completely upstreamed
  - AMDGPU, completely upstreamed
  - Intel (i915), merge requests are opened
  - Asahi (Apple SoC GPUs), partially merged upstream

# How to try out DRM context:

1. DRM context uses host blobs and on host requires v6.13 or newer version
of Linux kernel that contains necessary KVM fixes.

2. Use latest available Mesa (both guest and host) and libvirglrenderer
versions. On guest, build Mesa with enabled virtio native context support.

3. On guest, use latest Linux kernel v6.14 or newer.

Example QEMU cmdline that enables DRM context:

  qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Don,drm_nativ=
e_context=3Don \
      -machine q35,accel=3Dkvm -m 8G

# Notes about known problems:

1. DRM contexts are mapping host blobs extensively and these mapping
operations work slowly in QEMU. We will need to optimize hostmem
unmapping that currently happens in a deffered RCU work, blocking
GPU for a substantial time. WIP fixes available at [2][3].

[2] https://lore.kernel.org/qemu-devel/20251016-force-v1-1-919a82112498@rsg=
.ci.i.u-tokyo.ac.jp/
[3] https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-alex.bennee=
@linaro.org/

2. Linux kernel virtio-gpu driver doesn't limit display refresh rate,
causing poor performance. Fix availalble in drm-misc-next tree [4]
and should land upstream with v6.19+ kernel.

[4] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a036f5fceedb9fb=
d715565fef7b824a121503de7

3. Xorg on guest creates initial dumb buffer that is a vrend buffer, which
   can't be re-used by native contexts. This may cause drawing artifacts.
   Boot kernel with disabled fbdev using drm_client_lib.active=3D"" kernel
   cmdline parameter to work around the issue.

   Wayland on guest isn't affected by this issue.

Changelog:

v14:- Rebased on top of recent QEMU staging tree.

    - DRM native context in QEMU now requires virglrenderer v1.2.0+
      containing fix for async-fencing not working after guest reboot.

    - Updated doc patch with new Asahi nctx rquirements info. Asahi
      support landed to virglrenderer v1.2.0.

v13:- Updated Asahi nctx MR link in the doc patch. Old MR was closed
      and new opened.

    - Fixed compiler warning about unused variable when using older
      virglrenderer version.

v12:- Rebased on top of recent QEMU/staging and a fix from Yiwei Zhang:

        https://lore.kernel.org/qemu-devel/20250518152651.334115-1-zzyiwei@=
gmail.com/

    - Async-fence and native context features now require virglrenderer > 1=
.1.1
      that contains fix needed for resetting virtio-gpu-gl properly on QEMU
      reboot:

        https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/6f4681f=
f09cb17aa2d6715dbc6034eb3abe5711d

    - Added r-b from Akihiko Odaki to the doc patch.

    - Corrected resetting of async fences list that was done on scanout
      reset in v11 instead of virtio-gpu reset.

v11:- Added column for libvirglrenderer host requrements versions and
      corrected Asahi kernel link. Suggested by Akihiko Odaki.

v10:- Added links to Asahi and i915 virglrenderer MRs, link to Asahi host
      kernel. Suggested by Akihiko Odaki.

    - Renamed gfxstream guest requrements table's colum to match the host
      requirements table. Suggested by Akihiko Odaki.

v9: - Updated doc patch by addresing review comments from Akihiko Odaki.
      Made kernel requirements section specific to guest kernel and
      removed reference to host requirements. Removed examples of
      external projects' build flags.

    - Added guest kernel minimum versions to the guest requirements table.

v8: - Addressed review comments from Akihiko Odaki on the doc patch.

    - Added r-bs from Akihiko Odaki on the doc patches.

    - Extended vrend doc with info about hostmem requirement for GL 4.6

v7: - Added r-b from Alex Benn=E9e to the async fencing patch.

    - Updated virtio-gpu doc patch with addressed review comments
      from Akihiko Odaki.

v6: - Fixed compilation warning using older version of virglrenderer,
      which wasn't fixed properly in v5.

    - Added t-bs from Alex Benn=E9e.

    - Added patches to improve virgl/venus doc by adding links
      to the Mesa doc as was suggested by Akihiko Odaki.

    - Updated patch that documents guest/host requirements. Added
      links to Asahi nctx and reworked the doc structure by adding
      requirements to each context-type section instead of having
      one big blob or requirements, which was objected by Akihiko Odaki.

v5: - Added r-bs from Akihiko Odaki.

    - Added acks from Michael Tsirkin.

    - Fixed compilation warning using older version of virglrenderer that
      was reported by Alex Benn=E9e. Noticed that I need to keep old
      virgl_write_fence() code around for the older virglrenderer in
      "Support  asynchronous fencing" patch, so added it back and verified
      that old virglrenderer works properly.

    - Added new patch from Alex Benn=E9e that adds more virtio-gpu
      documentation with a couple corrections and additions to it from me.

    - Rebased patches on top of latest staging tree.

v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config
      option, better handling EGL error and extending comment telling
      that it's safe to enable SDL2 EGL preference hint. As was suggested
      by Akihiko Odaki.

    - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY+FIRST in
      the async-fencing patch for more consistency of the code. As was
      suggested by Akihiko Odaki.

    - Added missing braces around if-statement that was spotted by
      Alex Benn=E9e.

    - Renamed 'drm=3Don' option of virtio-gpu-gl device to
      'drm_native_context=3Don' for more clarity as was suggested by
      Alex Benn=E9e. Haven't added added new context-type option that
      was also proposed by Alex, might do it with a separate patch.
      This context-type option will duplicate and depecate existing
      options, but in a longer run likely will be worthwhile adding
      it.

    - Dropped Linux headers-update patch as headers has been updated
      in the staging tree.

v3: - Improved EGL presence-check code on X11 systems for the SDL2
      hint that prefers EGL over GLX by using better ifdefs and checking
      Xlib presence at a build time to avoid build failure if lib SDL2
      and system are configured with a disabled X11 support. Also added
      clarifying comment telling that X11 hint doesn't affect Wayland
      systems. Suggested by Akihiko Odaki.

    - Corrected strerror(err) that used negative error where it should
      be positive and vice versa that was caught by Akihiko Odaki. Added
      clarifying comment for the case where we get positive error code
      from virglrenderer that differs from other virglrenderer API function=
s.

    - Improved QSLIST usage by dropping mutex protecting the async fence
      list and using atomic variant of QSLIST helpers instead. Switched awa=
y
      from using FOREACH helper to improve readability of the code, showing
      that we don't precess list in unoptimal way. Like was suggested by
      Akihiko Odaki.

    - Updated patchset base to Venus v18.

v2: - Updated SDL2-dmabuf patch by making use of error_report() and
      checking presense of X11+EGL in the system before making SDL2
      to prefer EGL backend over GLX, suggested by Akihiko Odaki.

    - Improved SDL2's dmabuf-presence check that wasn't done properly
      in v1, where EGL was set up only after first console was fully
      inited, and thus, SDL's display .has_dmabuf callback didn't work
      for the first console. Now dmabuf support status is pre-checked
      before console is registered.

    - Updated commit description of the patch that fixes SDL2's context
      switching logic with a more detailed explanation of the problem.
      Suggested by Akihiko Odaki.

    - Corrected rebase typo in the async-fencing patch and switched
      async-fencing to use a sigle-linked list instead of the double,
      as was suggested by Akihiko Odaki.

    - Replaced "=3Dtrue" with "=3Don" in the DRM native context documentati=
on
      example and made virtio_gpu_virgl_init() to fail with a error message
      if DRM context can't be initialized instead of giving a warning
      message, as was suggested by Akihiko Odaki.

    - Added patchew's dependecy tag to the cover letter as was suggested by
      Akihiko Odaki.

Alex Benn=E9e (1):
  docs/system: virtio-gpu: Document host/guest requirements

Dmitry Osipenko (8):
  ui/sdl2: Restore original context after new context creation
  virtio-gpu: Handle virgl fence creation errors
  virtio-gpu: Support asynchronous fencing
  virtio-gpu: Support DRM native context
  ui/sdl2: Don't disable scanout when display is refreshed
  ui/gtk: Don't disable scanout when display is refreshed
  docs/system: virtio-gpu: Add link to Mesa VirGL doc
  docs/system: virtio-gpu: Update Venus link

Pierre-Eric Pelloux-Prayer (1):
  ui/sdl2: Implement dpy dmabuf functions

 docs/system/devices/virtio-gpu.rst | 116 +++++++++++++++++-
 hw/display/virtio-gpu-gl.c         |   7 ++
 hw/display/virtio-gpu-virgl.c      | 185 ++++++++++++++++++++++++++++-
 hw/display/virtio-gpu.c            |  15 +++
 include/hw/virtio/virtio-gpu.h     |  14 +++
 include/ui/sdl2.h                  |   7 ++
 meson.build                        |   8 +-
 ui/gtk-egl.c                       |   1 -
 ui/gtk-gl-area.c                   |   1 -
 ui/sdl2-gl.c                       |  70 ++++++++++-
 ui/sdl2.c                          |  42 +++++++
 11 files changed, 449 insertions(+), 17 deletions(-)

--
2.51.0


--_000_DM8PR12MB543171EE8DB9CD0272C7A99D8DC4ADM8PR12MB5431namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
The whole series is Acked-by: Pierre-Eric Pelloux-Prayer &lt;pierre-eric.pe=
lloux-prayer@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks a lot Dmitry!</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Pierre-Eric</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dmitry Osipenko &lt;d=
mitry.osipenko@collabora.com&gt;<br>
<b>Sent:</b> Tuesday, October 21, 2025 1:39 AM<br>
<b>To:</b> Akihiko Odaki &lt;akihiko.odaki@daynix.com&gt;; Huang, Ray &lt;R=
ay.Huang@amd.com&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&g=
t;; Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;; Gerd Hoffmann &lt;k=
raxel@redhat.com&gt;; Alex Benn=E9e &lt;alex.bennee@linaro.org&gt;; Pelloux=
-Prayer,
 Pierre-Eric &lt;Pierre-eric.Pelloux-prayer@amd.com&gt;; Michael S . Tsirki=
n &lt;mst@redhat.com&gt;; Paolo Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>Cc:</b> Gert Wollny &lt;gert.wollny@collabora.com&gt;; qemu-devel@nongnu=
.org &lt;qemu-devel@nongnu.org&gt;; Gurchetan Singh &lt;gurchetansingh@chro=
mium.org&gt;; Alyssa Ross &lt;hi@alyssa.is&gt;; Roger Pau Monn=E9 &lt;roger=
.pau@citrix.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Stabellini, Stefano &lt;stefano.stabellini@amd.com&gt;; Koenig, Christian =
&lt;Christian.Koenig@amd.com&gt;; Ragiadakou, Xenia &lt;Xenia.Ragiadakou@am=
d.com&gt;; Huang, Honglei1 &lt;Honglei1.Huang@amd.com&gt;; Zhang, Julia &lt=
;Julia.Zhang@amd.com&gt;; Chen, Jiqian &lt;Jiqian.Chen@amd.com&gt;;
 Rob Clark &lt;robdclark@gmail.com&gt;; Yiwei Zhang &lt;zzyiwei@gmail.com&g=
t;; Sergio Lopez Pascual &lt;slp@redhat.com&gt;<br>
<b>Subject:</b> [PATCH v14 00/10] Support virtio-gpu DRM native context</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patchset adds DRM native context support to V=
irtIO-GPU on QEMU.<br>
<br>
Contarary to Virgl and Venus contexts that mediates high level GFX APIs,<br=
>
DRM native context [1] mediates lower level kernel driver UAPI, which<br>
reflects in a less CPU overhead and less/simpler code needed to support it.=
<br>
DRM context consists of a host and guest parts that have to be implemented<=
br>
for each GPU driver. On a guest side, DRM context presents a virtual GPU as=
<br>
a real/native host GPU device for GL/VK applications.<br>
<br>
[1] <a href=3D"https://www.youtube.com/watch?v=3D9sFP_yddLLQ">https://www.y=
outube.com/watch?v=3D9sFP_yddLLQ</a><br>
<br>
Today there are four DRM native context drivers existing in a wild:<br>
<br>
&nbsp; - Freedreno (Qualcomm SoC GPUs), completely upstreamed<br>
&nbsp; - AMDGPU, completely upstreamed<br>
&nbsp; - Intel (i915), merge requests are opened<br>
&nbsp; - Asahi (Apple SoC GPUs), partially merged upstream<br>
<br>
# How to try out DRM context:<br>
<br>
1. DRM context uses host blobs and on host requires v6.13 or newer version<=
br>
of Linux kernel that contains necessary KVM fixes.<br>
<br>
2. Use latest available Mesa (both guest and host) and libvirglrenderer <br=
>
versions. On guest, build Mesa with enabled virtio native context support.<=
br>
<br>
3. On guest, use latest Linux kernel v6.14 or newer.<br>
<br>
Example QEMU cmdline that enables DRM context:<br>
<br>
&nbsp; qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Don,drm_=
native_context=3Don \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -machine q35,accel=3Dkvm -m 8G<br>
<br>
# Notes about known problems:<br>
<br>
1. DRM contexts are mapping host blobs extensively and these mapping<br>
operations work slowly in QEMU. We will need to optimize hostmem<br>
unmapping that currently happens in a deffered RCU work, blocking<br>
GPU for a substantial time. WIP fixes available at [2][3].<br>
<br>
[2] <a href=3D"https://lore.kernel.org/qemu-devel/20251016-force-v1-1-919a8=
2112498@rsg.ci.i.u-tokyo.ac.jp/">
https://lore.kernel.org/qemu-devel/20251016-force-v1-1-919a82112498@rsg.ci.=
i.u-tokyo.ac.jp/</a><br>
[3] <a href=3D"https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-=
alex.bennee@linaro.org/">
https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-alex.bennee@lin=
aro.org/</a><br>
<br>
2. Linux kernel virtio-gpu driver doesn't limit display refresh rate,<br>
causing poor performance. Fix availalble in drm-misc-next tree [4]<br>
and should land upstream with v6.19+ kernel.<br>
<br>
[4] <a href=3D"https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a036=
f5fceedb9fbd715565fef7b824a121503de7">
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a036f5fceedb9fbd715=
565fef7b824a121503de7</a><br>
<br>
3. Xorg on guest creates initial dumb buffer that is a vrend buffer, which<=
br>
&nbsp;&nbsp; can't be re-used by native contexts. This may cause drawing ar=
tifacts.<br>
&nbsp;&nbsp; Boot kernel with disabled fbdev using drm_client_lib.active=3D=
&quot;&quot; kernel<br>
&nbsp;&nbsp; cmdline parameter to work around the issue.<br>
<br>
&nbsp;&nbsp; Wayland on guest isn't affected by this issue.<br>
<br>
Changelog:<br>
<br>
v14:- Rebased on top of recent QEMU staging tree.<br>
<br>
&nbsp;&nbsp;&nbsp; - DRM native context in QEMU now requires virglrenderer =
v1.2.0+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; containing fix for async-fencing not working=
 after guest reboot.<br>
<br>
&nbsp;&nbsp;&nbsp; - Updated doc patch with new Asahi nctx rquirements info=
. Asahi<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; support landed to virglrenderer v1.2.0.<br>
<br>
v13:- Updated Asahi nctx MR link in the doc patch. Old MR was closed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and new opened.<br>
<br>
&nbsp;&nbsp;&nbsp; - Fixed compiler warning about unused variable when usin=
g older<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virglrenderer version.<br>
<br>
v12:- Rebased on top of recent QEMU/staging and a fix from Yiwei Zhang:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lore.kernel.o=
rg/qemu-devel/20250518152651.334115-1-zzyiwei@gmail.com/">
https://lore.kernel.org/qemu-devel/20250518152651.334115-1-zzyiwei@gmail.co=
m/</a><br>
<br>
&nbsp;&nbsp;&nbsp; - Async-fence and native context features now require vi=
rglrenderer &gt; 1.1.1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; that contains fix needed for resetting virti=
o-gpu-gl properly on QEMU<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reboot:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://gitlab.freede=
sktop.org/virgl/virglrenderer/-/commit/6f4681ff09cb17aa2d6715dbc6034eb3abe5=
711d">
https://gitlab.freedesktop.org/virgl/virglrenderer/-/commit/6f4681ff09cb17a=
a2d6715dbc6034eb3abe5711d</a><br>
<br>
&nbsp;&nbsp;&nbsp; - Added r-b from Akihiko Odaki to the doc patch.<br>
<br>
&nbsp;&nbsp;&nbsp; - Corrected resetting of async fences list that was done=
 on scanout<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset in v11 instead of virtio-gpu reset.<br=
>
<br>
v11:- Added column for libvirglrenderer host requrements versions and <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; corrected Asahi kernel link. Suggested by Ak=
ihiko Odaki.<br>
<br>
v10:- Added links to Asahi and i915 virglrenderer MRs, link to Asahi host<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel. Suggested by Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Renamed gfxstream guest requrements table's colum to m=
atch the host<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; requirements table. Suggested by Akihiko Oda=
ki.<br>
<br>
v9: - Updated doc patch by addresing review comments from Akihiko Odaki.<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Made kernel requirements section specific to=
 guest kernel and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; removed reference to host requirements. Remo=
ved examples of<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; external projects' build flags.<br>
<br>
&nbsp;&nbsp;&nbsp; - Added guest kernel minimum versions to the guest requi=
rements table.<br>
<br>
v8: - Addressed review comments from Akihiko Odaki on the doc patch.<br>
<br>
&nbsp;&nbsp;&nbsp; - Added r-bs from Akihiko Odaki on the doc patches.<br>
<br>
&nbsp;&nbsp;&nbsp; - Extended vrend doc with info about hostmem requirement=
 for GL 4.6<br>
<br>
v7: - Added r-b from Alex Benn=E9e to the async fencing patch.<br>
<br>
&nbsp;&nbsp;&nbsp; - Updated virtio-gpu doc patch with addressed review com=
ments<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from Akihiko Odaki.<br>
<br>
v6: - Fixed compilation warning using older version of virglrenderer,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; which wasn't fixed properly in v5.<br>
<br>
&nbsp;&nbsp;&nbsp; - Added t-bs from Alex Benn=E9e.<br>
<br>
&nbsp;&nbsp;&nbsp; - Added patches to improve virgl/venus doc by adding lin=
ks<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to the Mesa doc as was suggested by Akihiko =
Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Updated patch that documents guest/host requirements. =
Added<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; links to Asahi nctx and reworked the doc str=
ucture by adding<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; requirements to each context-type section in=
stead of having<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; one big blob or requirements, which was obje=
cted by Akihiko Odaki.<br>
<br>
v5: - Added r-bs from Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Added acks from Michael Tsirkin.<br>
<br>
&nbsp;&nbsp;&nbsp; - Fixed compilation warning using older version of virgl=
renderer that<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; was reported by Alex Benn=E9e. Noticed that =
I need to keep old<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virgl_write_fence() code around for the olde=
r virglrenderer in<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Support&nbsp; asynchronous fencing&quo=
t; patch, so added it back and verified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; that old virglrenderer works properly.<br>
<br>
&nbsp;&nbsp;&nbsp; - Added new patch from Alex Benn=E9e that adds more virt=
io-gpu <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; documentation with a couple corrections and =
additions to it from me.<br>
<br>
&nbsp;&nbsp;&nbsp; - Rebased patches on top of latest staging tree.<br>
<br>
v4: - Improved SDL2/dmabuf patch by reusing existing Meson X11 config <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; option, better handling EGL error and extend=
ing comment telling<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; that it's safe to enable SDL2 EGL preference=
 hint. As was suggested<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Replaced another QSLIST_FOREACH_SAFE with QSLIST_EMPTY=
+FIRST in<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the async-fencing patch for more consistency=
 of the code. As was<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suggested by Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Added missing braces around if-statement that was spot=
ted by<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Alex Benn=E9e.<br>
<br>
&nbsp;&nbsp;&nbsp; - Renamed 'drm=3Don' option of virtio-gpu-gl device to <=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'drm_native_context=3Don' for more clarity a=
s was suggested by <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Alex Benn=E9e. Haven't added added new conte=
xt-type option that <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; was also proposed by Alex, might do it with =
a separate patch.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This context-type option will duplicate and =
depecate existing<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; options, but in a longer run likely will be =
worthwhile adding<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; it.<br>
<br>
&nbsp;&nbsp;&nbsp; - Dropped Linux headers-update patch as headers has been=
 updated<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in the staging tree.<br>
<br>
v3: - Improved EGL presence-check code on X11 systems for the SDL2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hint that prefers EGL over GLX by using bett=
er ifdefs and checking<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Xlib presence at a build time to avoid build=
 failure if lib SDL2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and system are configured with a disabled X1=
1 support. Also added<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clarifying comment telling that X11 hint doe=
sn't affect Wayland<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; systems. Suggested by Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Corrected strerror(err) that used negative error where=
 it should<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be positive and vice versa that was caught b=
y Akihiko Odaki. Added<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clarifying comment for the case where we get=
 positive error code<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from virglrenderer that differs from other v=
irglrenderer API functions.<br>
<br>
&nbsp;&nbsp;&nbsp; - Improved QSLIST usage by dropping mutex protecting the=
 async fence<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list and using atomic variant of QSLIST help=
ers instead. Switched away<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from using FOREACH helper to improve readabi=
lity of the code, showing<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; that we don't precess list in unoptimal way.=
 Like was suggested by<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Updated patchset base to Venus v18.<br>
<br>
v2: - Updated SDL2-dmabuf patch by making use of error_report() and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checking presense of X11+EGL in the system b=
efore making SDL2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to prefer EGL backend over GLX, suggested by=
 Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Improved SDL2's dmabuf-presence check that wasn't done=
 properly<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in v1, where EGL was set up only after first=
 console was fully<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inited, and thus, SDL's display .has_dmabuf =
callback didn't work<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for the first console. Now dmabuf support st=
atus is pre-checked<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; before console is registered.<br>
<br>
&nbsp;&nbsp;&nbsp; - Updated commit description of the patch that fixes SDL=
2's context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switching logic with a more detailed explana=
tion of the problem.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Suggested by Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Corrected rebase typo in the async-fencing patch and s=
witched<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; async-fencing to use a sigle-linked list ins=
tead of the double,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; as was suggested by Akihiko Odaki.<br>
<br>
&nbsp;&nbsp;&nbsp; - Replaced &quot;=3Dtrue&quot; with &quot;=3Don&quot; in=
 the DRM native context documentation<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; example and made virtio_gpu_virgl_init() to =
fail with a error message<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if DRM context can't be initialized instead =
of giving a warning<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message, as was suggested by Akihiko Odaki.<=
br>
<br>
&nbsp;&nbsp;&nbsp; - Added patchew's dependecy tag to the cover letter as w=
as suggested by<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Akihiko Odaki.<br>
<br>
Alex Benn=E9e (1):<br>
&nbsp; docs/system: virtio-gpu: Document host/guest requirements<br>
<br>
Dmitry Osipenko (8):<br>
&nbsp; ui/sdl2: Restore original context after new context creation<br>
&nbsp; virtio-gpu: Handle virgl fence creation errors<br>
&nbsp; virtio-gpu: Support asynchronous fencing<br>
&nbsp; virtio-gpu: Support DRM native context<br>
&nbsp; ui/sdl2: Don't disable scanout when display is refreshed<br>
&nbsp; ui/gtk: Don't disable scanout when display is refreshed<br>
&nbsp; docs/system: virtio-gpu: Add link to Mesa VirGL doc<br>
&nbsp; docs/system: virtio-gpu: Update Venus link<br>
<br>
Pierre-Eric Pelloux-Prayer (1):<br>
&nbsp; ui/sdl2: Implement dpy dmabuf functions<br>
<br>
&nbsp;docs/system/devices/virtio-gpu.rst | 116 +++++++++++++++++-<br>
&nbsp;hw/display/virtio-gpu-gl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp; 7 ++<br>
&nbsp;hw/display/virtio-gpu-virgl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 185 +++=
+++++++++++++++++++++++++-<br>
&nbsp;hw/display/virtio-gpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp; 15 +++<br>
&nbsp;include/hw/virtio/virtio-gpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +++=
<br>
&nbsp;include/ui/sdl2.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 ++<br>
&nbsp;meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp; 8 +-<br>
&nbsp;ui/gtk-egl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp;&nbsp; 1 -<br>
&nbsp;ui/gtk-gl-area.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 -<b=
r>
&nbsp;ui/sdl2-gl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp; 70 ++++++++++-<br>
&nbsp;ui/sdl2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 42 +++++++<br>
&nbsp;11 files changed, 449 insertions(+), 17 deletions(-)<br>
<br>
-- <br>
2.51.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM8PR12MB543171EE8DB9CD0272C7A99D8DC4ADM8PR12MB5431namp_--

