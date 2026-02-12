Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FEDEE36AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqarO-00039t-MM; Thu, 12 Feb 2026 12:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqarN-00039W-JA; Thu, 12 Feb 2026 12:52:13 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqarM-0005Qy-16; Thu, 12 Feb 2026 12:52:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRsVbhqVLAGSeDng2+J92arlMqr74+k5nH5nj2qMbpID8FPaU0aqD62l05wGibn+lDKy+oxa952sxO0zcUt2RRNcplZ8hpVKXJqz6ELp5BcWmJ3aFtTD0LIBnFu0b1HNcK98Sbbf6G0sLbkHtZq/nT5KJGOSWXLYa/6gjc2M24czslzlSRTSeCfraJObYIJhXgf0WZeYGkLUKOSZD2oK5WNFInZ7KMZNDWqRiQfyEDtuBXB6ZbFP4OujV8+Zx4CFGp3gHd2P/xQcooxxxBBBwh58h1kyai2OHKaYPv++4YRhrq19vktw7byf7ypUv8FVRNAKamA2qcr+Va7CTfPHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7J2vlIL3o3fW/pOt9cR67wYt6U/qk6524H0243Gj/g=;
 b=zS68KVjc2nlbQNq2cnopaOzWM/VrF5336/ao2xUFaC2oFPag+BZbTzGyA3kxr8vVQg9V/c3PSwBcVGbRn3ET5sGvQBzKsC8zamtV6MBcHvFTedl+uhzV+bL0t18MGP3FUfS6xVsZsbloFIWBYikMl3mYh+6OC9aevnzUG14DG7phm/5sSPjJswsS/q2sLzcLP1SWuTBudOg0/okj4fbdoA9qUnShiozDCpa73RKLUGSWeWXoekzeJUg637u+NPEE5zNCBHehLY4iMdhvltY2c4YlCblat9+Sma0uOFmpKx7fOi58xP+yl0ST9L3Bd1+eA59SKWreJFcz8xbdGhJfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7J2vlIL3o3fW/pOt9cR67wYt6U/qk6524H0243Gj/g=;
 b=HSzLoVSy2SsVYHZI5bFbaiDQXUSNYYUWG1o0ANiOqngLBGMImH76AnThTn8q0iYJSJy55Uwb9UT/UiXnNneB8N5ydo23tz5vpenYWtiKZOUG6y2bMAS4WZUZOXbxCeihed5EJLmXuz98n1um/wR7S3An9sece//U0INC4jESXBQre0z6/Q/j/Vbgu8VNvNjkEDOUvG160Qxox767Sh6plaQVir9sNSjZEH7lygO8rPuVhaXikNq5wmstxDpoxOS7fvIgduF6m/hXLkgLohDLtqCqdO5E+FzH7Dv3PyXVWh6DB4b7Ja8cZXR8mHvyMOlPoK1ZnklOQCFYmG3jQgxjDw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 17:52:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:52:06 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Topic: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Index: AQHcl3fclJVY+/1eUEyrJW1egg4NVbV6yXyAgADQx/CAA5IqgIAAAY3ggAACz4CAAABycIAACieAgAAB29CAABeJAIAABOOAgAAGwCA=
Date: Thu, 12 Feb 2026 17:52:06 +0000
Message-ID: <CH3PR12MB75484A150D6DCD9D3C3C66F3AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
 <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
 <CH3PR12MB7548A87A5BC62C6D90501947AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <ef13c99e-29b3-47cf-a090-811294e723e0@redhat.com>
 <CH3PR12MB75481019FE5FEB62BCE96D58AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7af8156e-4874-4cab-b71a-c39c56aa59c0@redhat.com>
 <aY4Mj5GvO8X+tO51@Asurada-Nvidia>
In-Reply-To: <aY4Mj5GvO8X+tO51@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB7733:EE_
x-ms-office365-filtering-correlation-id: b8747143-3c50-4d37-2922-08de6a5f6fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F2+DObc6xyh0km6M1xW61xQvSOrclpY19l72PN3UESt5wQG5mvKSOtY4Ny?=
 =?iso-8859-1?Q?gWhX2vDgeEmVzIPguOBrB91C9nJAzFQJ7gkBHtmorUXkcCVmFTTfa9sv4/?=
 =?iso-8859-1?Q?ewWCaWx78qnLWW24B3lvXi8L00bnDp8I0PLuC2HM7rv+fy3RUixDrUYJh7?=
 =?iso-8859-1?Q?DFT2QV67diVePtvem/fVzFWK0W4OYvyLqjAzOvax6mY6+7d9NVWKUiZsUt?=
 =?iso-8859-1?Q?KXTqOV89PkkTYs8pZ4UOm8kGU5n/3JeTMVILnCeHaK+1U3i8+9+beff1JR?=
 =?iso-8859-1?Q?MdLbXpJz+lXDvZ6mLHK/mRv/Rys4JMKqlb3LAhW6ucuVJ3HFdmkPD3D1RZ?=
 =?iso-8859-1?Q?dnGBH6TTJM8R4kWGfkUj2JA0uOZ4v25e05iTZV1XBeo7CAPoZysnkJJviI?=
 =?iso-8859-1?Q?7rV3lPYmF89thDkl+qotwOFCAm+s2NLmFjP/onj1kzUzOO9AIYSRzbGI+X?=
 =?iso-8859-1?Q?fbxsoHUrdh6xu6fzHPi0+uR7k+A2F6+VjrQxRMe/IYytuKeATnS0nlPGtp?=
 =?iso-8859-1?Q?s6f98JGHS03Dq+xanByiE8pmmQJycTxBfqp+7OdgG8kh8GjgfOUvjEiKMf?=
 =?iso-8859-1?Q?dTAWSC+6cJHA0pppO146xdcNhAnQFiGtZ9JcpnW34pJtjbv5A9vDa/0hIr?=
 =?iso-8859-1?Q?Dhx601lXiT7r2q0FdJPgFJ+whT0HMppCbh87VWEd6zr4g2DAaQQNHHF9pG?=
 =?iso-8859-1?Q?Mkn44k0/1N8tRJ4aeb3lOz6rTe3VWhKuGKIjtr/At++4QyujhkoVRhtM/n?=
 =?iso-8859-1?Q?xOLVKz9ljegFHHdcTFPplmrZefVKZ0LS1A7C/XESCiACulh5UgxliYxXDS?=
 =?iso-8859-1?Q?NdxyL81KkyiSu+Wi8LA57zJl4BwXjSF16zeVFkI17+x+mNXHzzc0E69ryv?=
 =?iso-8859-1?Q?QXJsRyWvFLDL3KH15SlD+ffGz3x5bGxUzRl3UA9PlG0U5C3rZSlr32Zq82?=
 =?iso-8859-1?Q?Q9wTkachBNn8s8cfhqS75ICn++zNQosUq70GesgSZVeydr1wUzMzOA/2W7?=
 =?iso-8859-1?Q?LTrLL7BFVzvZJC8bhdiJvqn7DnhTxUZxzTJTjNF46lLa/Mkyhg8WXWstBk?=
 =?iso-8859-1?Q?1HufbdtCP+NaY1RHvNiT+pG9qHJxNQ6HP/EOapUebF4YLA1hH+ZFxr4wcR?=
 =?iso-8859-1?Q?gOTnvVEnfmquxDNTKw0rzp91kLlLC1FaizLpa5P4MViInn62UTCM5pbT1k?=
 =?iso-8859-1?Q?l837W3tUIlhk0JfjsrUWMI4hHUQoPRI8ADVdGUasp6ORlqJBoRAPPK6ldf?=
 =?iso-8859-1?Q?cHS9+OznrTikogNXviD1+WUEhR+f97Ce3gdo7BWqIXrvB1HVg/O9xLbQh0?=
 =?iso-8859-1?Q?E/FfW1hTYA8/SY8ZUt+zgfpPzIIm3nIjAadLMblUoFfZvcKH8g5xMgCRtm?=
 =?iso-8859-1?Q?zLAo1aA4K7oeYxOyTfxVeWjmYfHqHa2icY+G0ZZwjGpMTHDSVkAOA22qRK?=
 =?iso-8859-1?Q?Ian0o9DP66uUZIMS0Ma3moc6db/k39nNUruxB9r0OEzuM5cSRQpP9TrF97?=
 =?iso-8859-1?Q?bg6dTeUtaMBu71pYM62NnEe10YjBEm5UgQEOSHFU/BWnVpSYZcSfWsbU49?=
 =?iso-8859-1?Q?ntEG98TuNpCUmEhzJXyrVLCYz8wT9udpsY5xu9ElNMQmyMVbSscZUfXbpg?=
 =?iso-8859-1?Q?aNEloQzegs2rDAgDmI9/l1tzrUJfzz/ZllmsSM1Of6d/q0wDhw5BWCoxxG?=
 =?iso-8859-1?Q?YNWSrtrRdpNp1PxICQM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?klekbkiP6OEzBwlItU0M29qdz05XHubzEjdrc3UyAKsUYrr3d7FMuGds3P?=
 =?iso-8859-1?Q?ggRLqeNJRy37LbfryOviU68vRHIv1Lp9uMw2ZDh+k+RYHnFRDuWH9M9rnJ?=
 =?iso-8859-1?Q?h+CnPiWKvpcY5qjiQkWvjRDJ5MVrB9SyokRH9FAKIFbkOUvXT+pcbfJvfm?=
 =?iso-8859-1?Q?WmkwXwkPCrEvCYrD+pzso6nhAlrRPq5KrCPzJKA/DkscFBnFRO1fw57YJm?=
 =?iso-8859-1?Q?NJOPDRmbpAf5Mph1tRuSpI1NtCUA8NVciQauByuzb+qgGs+Myn4REeT0ay?=
 =?iso-8859-1?Q?73iICV49ObKV6KiygppYS/rIBs1zEbX7I/F5dt7SppQolvdyT0sMhBPHSm?=
 =?iso-8859-1?Q?vaN9SwediLwC1EjV+0Lqztkl4aS//ALXXdH3B4yfM7DQ7o0EokOYJu4pCF?=
 =?iso-8859-1?Q?KoJ5VAj9xKnACjIUc/XV+SxiJ4wqb+mY2ILJSNSJus2amjGuZVna+OfuiV?=
 =?iso-8859-1?Q?YcTPwZXQLpqVK9MF/vWe0xFYiar4ZAGaKlMjHnEkT+EPzENK/dZvqSS861?=
 =?iso-8859-1?Q?DxdOt4VHA3Y2SQGYDS5MCZRObCJlH/UuEPi+JSBK0SfcnMgkilxPHUVAuj?=
 =?iso-8859-1?Q?X57dNeH+SfGRtUPsZsJkWdz4n1pzVFJFpIxQ7Fd6Iqfwd9kPw72ZMA5+Nv?=
 =?iso-8859-1?Q?13yoDZHW12rHh54QxS05aGK5MTBjRIh0l+nrbr7Qh0LO3g1kka94jXcqGo?=
 =?iso-8859-1?Q?+EJ9m0UvhmsYU+M9LayLNa3Jh13aBdx5vNf141LwLWKH13viO+hvvH/7B0?=
 =?iso-8859-1?Q?/MdGNfTWZoxIFA+/5fTvT11P/Fml/EbSo0NsApHFjI1eN3nQd4JgtGGhOo?=
 =?iso-8859-1?Q?ptouwyKGS56UEsihlgHMCrRRzpV0IBj0RgI6wZTIHiYLBtQtWq8QObkOow?=
 =?iso-8859-1?Q?CxoYqM+QcBRFKkGS0xxIZMx+y/DwHRDZq/j1eE95DoCqugWCVnGrFjJA8p?=
 =?iso-8859-1?Q?UJT9S1n2QDAuDFq4t11pt0TtzReVwX+CU20oiuYOhEIM2nb2B8N3FpYOwc?=
 =?iso-8859-1?Q?Nkb7UfI8S26mDUUh8+ILgw+xQZjv2YzIFV5NHW3bo8s/JsF9vxBpsIVDaP?=
 =?iso-8859-1?Q?Xr+fhW5q9P9BiQaFyt8noqioeruMlzA+Xq/+DKk8I3QuHIzfTvgxMjFqlv?=
 =?iso-8859-1?Q?mrraUSTlQb4cVMwA22Ae5qhhv6M79pwL3FG4q6XRa/QTtWqIc6wkr4trXt?=
 =?iso-8859-1?Q?gizk7YNfju510l8WrW1II+itJP3yiz2/ZikUiOxFxGInnf3A6l8fyRAtMc?=
 =?iso-8859-1?Q?6leFnk7qcVFlmfAruebFLwOATLvaXW7Rfk/w3/ZNsCCItljuMzzFl/C0yW?=
 =?iso-8859-1?Q?oGQm+tOrA+zxCf7ZX42KqbgmtQzd9DjRXBkc+bfaM0/17Kn24ATTfKDOjy?=
 =?iso-8859-1?Q?K6ydsT4Eil4bXLNgsZXZe6UhZ29f+fRm6nQHb9GqiJ+/qb59gLdoO2jAku?=
 =?iso-8859-1?Q?5vKiK+44v0nFX0eTMFiRbO8QHkbqlT/1yK07+xE8FQ94prQ0PWTbh6gWqZ?=
 =?iso-8859-1?Q?1RJfk4NFlRdybJ4zBuHc1iOanEHu4+nS9LOIGu/oDuWzLA9Fs+6rhxWgo/?=
 =?iso-8859-1?Q?qJUjf2pomf4PQt8RMfN1mmXdAOsDOMFQHhnMx6Yt/ekXnn1zcmB8HFdfRd?=
 =?iso-8859-1?Q?GXU2jKB0LEAeXF9ADdH7AXHAI/AQnYDp+7YhML9DYPDhrERIQbL4zhzdsR?=
 =?iso-8859-1?Q?7+H8GeVsKvzPZUVa7kQwnFHGBdOixHLf6d4qTZfMlZ3jAlLDsppogTnQDM?=
 =?iso-8859-1?Q?ZKwiakXl76s7NYh1nNTI+DTAJMbUzjmsrSo1rf2/jkReeK2uUxHabfKXX3?=
 =?iso-8859-1?Q?5duP1nulxw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8747143-3c50-4d37-2922-08de6a5f6fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 17:52:06.3725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdHT+rRVqdoXBVWghNVRe7F47sfQaf8D8W1YKmWkL3bQ3HR0/497NzwKcHYDZpkVN+uRjCPY/Z1Q84yoC3On8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 12 February 2026 17:23
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
> Matt Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason
> Gunthorpe <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
> interface
>=20
> On Thu, Feb 12, 2026 at 06:05:58PM +0100, Eric Auger wrote:
> > >>> The vCMDQ path does not replace the normal accelerated SMMU
> init/reset.
> > >>> Instead, it requires additional init/reset steps on top of the regu=
lar accel
> flow.
> > >>>
> > >>> if (accel)
> > >>>     accel_init();
> > >>>
> > >>> if (accel && cmdqv)
> > >>>     cmdqv_init();
> > >>>
> > >>> So the vCMDQ logic is an extension of the accelerated mode, not a
> fallback
> > >>> or alternative implementation.
>=20
> Yes. And I think it makes more sense by moving cmdqv_init() into
> accel_init(), completely transparent to the common smmuv3 module
> maybe?

I have attempted that, IIRC. There is a catch there that the pci iommu_ops
needs to be set earlier(before smu_common realize) and we can only call
cmdqv_init() after the base  SMMUv3 sysbus_init_mmio() and smmu_init_irq().=
=20

I need to take another if we can make that work or not.

>=20
> > >>> I think the later patches in the series make this clearer.
> > >>> Please let me know if you still feel the ops necessary.
> > >> do we have any way to introspect from the kernel what cmdq type we
> have,
> > >> so that we could have a cmdqv option with ON/OFF/AUTO value instead
> of
> > >> duplication cmdq option for each vendor?
> > > Looking at it again, I think we can, by calling IOMMU_GET_HW_INFO wit=
h
> all supported
> > > CMDQ types and check which one succeeds.
> >
> > then I think we should endeavour doing that. Regarding the ops, if you
> > feel that reset/init can be managed through a simple add-on code I am
> > fine with it. Maybe C=E9dric or Peter will have another opinion though =
;-)
>=20
> I like that on/off/auto depending on the IOMMU_GET_HW_INFO return.

Yeah. We need to do this.

Thanks,
Shameer

