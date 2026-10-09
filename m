Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C2CA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 04:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF2BP-0007ci-PL; Fri, 09 Oct 2026 00:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xF2AJ-0007Px-4u
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 00:25:09 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xF2AD-0008OW-5Q
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 00:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791519898; x=1823055898;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ykpf6UBm4Ih8KO4kMAc3gS9h7I6qBpnwJ7/Qb7teFdg=;
 b=kE1YzaruYcyUcHJhZD9d2JM2zjmV707PglJIl38dsklliZXNzgOti4kg
 fVvRkCx4N5DqdhtbO3YXIjrV4UAI/mxKHXoYSXnt6Kn4yeLmdUln+5lei
 2JXLQdur+CfsUI8C3jdZBVtnOf/Oz2U4cEaUIoc+UAqI2Uaq9HzFgHTY4
 7nJ0LzBwCsxeBjmjUrwlfgJcYPm58/6oKy2xA05aecyECXgfDpoWE1rlB
 H1yFTnQjBQ2cTSwZXmA8nq4oaY1bgfqCwXyWHNWa14ehk/IgJIWUNBE8e
 nWK3w+4UaHHSAF27gMvsOUIVKNWifwZcC/Lueda+rBz1NuLxb3vHYm9Jl w==;
X-CSE-ConnectionGUID: NqG6YUevTTy8bJmHiWlHHw==
X-CSE-MsgGUID: iJ99NgAATTe7AuZKTzK46g==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="188083"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="188083"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 21:24:50 -0700
X-CSE-ConnectionGUID: FHq0CeJdTWOBxbXQRZS2EA==
X-CSE-MsgGUID: FtgKw3lOS26ONxGPdt3JuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="212219"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 21:24:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 21:24:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 21:24:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 21:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHmHY/gT7nUyrdeojfQAPpCdu6Hz3vqKv23cLKKwQkWBf2J2uM9tWBDZOin7V7770EvlKMlr1/DOY3PC47GcVU9h9k/yGpCGAE9H77HRLlI5MM1TsRa+Jz9Cc0Eu1kPQ2rgShaGYDVqDnU2/d/PrsJ8eHM+RYtRfJrMtTpCRg6FWZcSbhWJrOihUPwqfK0Y9gHNGfBpgWrxxsSv1MYKluYCVsO5+Czw3CpabSMz72rLTnWXJtt/XB1H2KHpNIYyqP69xj2/RdnlKQNWxqWTqGFQeDIxSNHc2V2h1lI+osOxkdeB8Hu4dvyEDaix6EjCVuFpQ0g97tvgsneOijgCHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAavW5mkuaOiOFRXHDtWSZgck1CePUFdsn59rjFo0CY=;
 b=Ci4eP8Hm7/YIxaCdMjXSetBSDg2WyGoBWn9pI52NZ7atTr00MXjSU0f9JcP+yYt80wlA5eieL3XzsQ39d9+w/bgbxzqtyMvhGh3dZ9mamewPsjss6GIJQVwQOAvj7hqte/7He5JPnVzDXeV/De0isBPmdEev+DT1cz/A3fcy42Qg9J4T1//axiQjUZSMobAjpHnM3tSTR8EJYz8HHNMCB0J9PL6JgEJoB/18nKmPDtP5gZi0OaFsr3daQUuelEUmyZw7l0by9n99ABpoo1WEbwgeqGCjkYrg9Cl/hF80Afh7IlFWNhbKW5as98GHHo1TO+kdAPF/F4toXCB90Fs4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH3PPF10E309DEE.namprd11.prod.outlook.com (2603:10b6:518:1::d08)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:24:21 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 04:24:21 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <akihiko.odaki@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
Thread-Topic: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf
 from multiple ranges
Thread-Index: AQHdVphlAJLtaSnr1k+pnx5j3pf8VLbzXAaAgACgtBA=
Date: Fri, 9 Oct 2026 04:24:20 +0000
Message-ID: <IA0PR11MB71856195189075740DB23934F8922@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <f8c86fc0-9c29-4fd5-a7af-e20289da9f4b@gmail.com>
In-Reply-To: <f8c86fc0-9c29-4fd5-a7af-e20289da9f4b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH3PPF10E309DEE:EE_
x-ms-office365-filtering-correlation-id: e209f405-d0a3-4720-88cc-08df25bd30ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|10067099003|18002099003|4143699003|260925021911599003|260925022911599003|260925021311599003|11063799006|38070700021|5023799004|56012099006;
x-microsoft-antispam-message-info: ACM7WnSeb3RQ9+NUlR5Mrj3ysoh4Qq26ACtgz9Yzca7mIYoyjMRnDDz2VoGryBiLx1OXkizyUUtnhZ3nfut0ZSb5LmGX75INzlOPQwbUmmiZUit+GLzrVyIqxvMQ5pc+dJEtktNM+uVuG3gULkUubZLTWJVxhu9d8Sj7d61ILn1uHAZF6/JvP9p6uxHNg7aVo8Z/wSIX8rDgZqU01Tu+01fd6zfSKulfb3+Zwo6K69QylyfmFTkw87PRvJXvRZ2PQHfUI0TVc+21CcS6HapvmikKa6Qg9Ivv5jx8Xa1jIpKxcgcPhPeWGpGI9qjRwZpyMXH63fre8shvqk4GraDmH76Y9o6VqHwYeT/8UY4kV7q23c188tVrwtahLtfFITfKan+U7LlhWbKr0YA1mrJQjJdx52jx0hWt+h+/NQnDBVEmTlFVFdtCU/KCKpB9nbQEXfVv4zDlN/0Npq7ukV9icV/47hFBXWFxxuwYt7QfTlBfggERyBSSTExliV2cjBtwbkJHSsR6H7fX4Kv93Z/SSoPV8pzpTZy4r5Oqwj3qvpJNNzuhcW47XRsnk5Nn2uk7QHCQBTq3wY5sXHvnqMxYgKS0zWwvpRwCSinyVvziHTG2N9EkJVkotDhcE8kVBi5pYYB8Do/tWxnOZIsT1Ck7QLY3kN9jKQA+5TdS90c8wYdPkS6paPcXnTDRQoZgcIdE5+XwC4zxPVa5pZNjzKnGvOZwZlX8e11uF9h5FiiXoAY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(38070700021)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8rO+pNTkbTaHht9GOMyxnkCNBtWfaDwSAThWZZgr1AMpHJ4zGPpjT700TN?=
 =?iso-8859-1?Q?YfdAHpaFVR1fLYjJsg765k7uQjkh6Yut+kRBbe78kK6SYsZqf4zCmVxJKj?=
 =?iso-8859-1?Q?3prHlVaxzQoS2W+WCoxIBRlwx8qKL/B1u1bdOQEFe6h52BK9Kz+N6TJS/8?=
 =?iso-8859-1?Q?PXbklLRDreRJsuFCtr1tLjO5Vvmpgmmyg4i9R97Fw/ifmRVHG8Wj8jJIrQ?=
 =?iso-8859-1?Q?w8tIgwZAsFuf3f6GBxGVgCtFLRgEyVkmcbIDDiW9RlOS2sYTd77NcbIJLV?=
 =?iso-8859-1?Q?wkdLllgqaOubjHyyypfJx/p7Q3MI57NaM8BYI6p6valznClXpL+8Zbf66x?=
 =?iso-8859-1?Q?01fLCCGWXiYJJEOb4yEuIajRxhJHHsTUxwlbBKgIBzEQpy7IfB9ZnTC1Pr?=
 =?iso-8859-1?Q?SAzOVtBGdij8lgXuXxoSmh7UbKE70CEvY0wqWJ4oXLNJYlrSVKZTOj9wIr?=
 =?iso-8859-1?Q?Q+8XAIJP4A8k42vWVyhnnY9ir2dhmdLbdZ1/G5U4rj6kGQZ9CfwIC3Aw+H?=
 =?iso-8859-1?Q?VlKLpwH3mLZjq91U6HqqaQctospWmSovGF6/woFJUdjstqTrg9aOZGvAQi?=
 =?iso-8859-1?Q?GRs1/c8WxtdtF7Hi15/vUWqi5woqEJOr055D3/awDxIPXgCyNeoUnB8ESb?=
 =?iso-8859-1?Q?YW/io4mh9UyDn4X+dL6ala6kYnTn63Jm4eouMIB9b4fgWg2pqL/VD7H7y3?=
 =?iso-8859-1?Q?woLyvkZmju9G3J4jfXONAB3YmacTAAFroyFAxkj1Ht0Z/W/bEwEZpIMFiZ?=
 =?iso-8859-1?Q?C275b5lctow390IQNNAe2QqHMWxXMWYqUqctC45RsJ5q08CpaozyygbnD7?=
 =?iso-8859-1?Q?4Nmy6+ABLcas4EDUHptpabGaUaWpGTsqOeqqRjLHinwTROp6gpYTHa9EDI?=
 =?iso-8859-1?Q?O4RLhV7SSbsxb/DV7A//UTyQH3PI2Jx5h0o7Pzaz0tsyY/y4BRraPNc0u+?=
 =?iso-8859-1?Q?FqOtPqIw+/Re6RKwqou9WsEiMXF0P5COPHsMfxS/IQSou9nwzXXcIT9jRV?=
 =?iso-8859-1?Q?puaQzbpI3ICu8r/dt9+vdz9Cjo3N7TQ67rrppA5/w/RUUOT7RdvSHfUnbS?=
 =?iso-8859-1?Q?nkmFWx2Whr2LAm4sniFhPZhEx3xzAv6MBZn6vRlbN17KvshRMSGNxAfeeb?=
 =?iso-8859-1?Q?CMEs/wXgy9QRptykOHPaK5dofWlUB0RroZ5EdoZr4s/L9h1EfEs+XoyxWD?=
 =?iso-8859-1?Q?4T4HOQ2CAjbLTmDbyV/BhVUiSci5fDcizh++ojdql7GEFNdccF9gck4376?=
 =?iso-8859-1?Q?yqGIK/qg9gFNdmdnDgJ1Izelftl210dvFW1zxJhZpvO2Uhnl6NDD3TUYU+?=
 =?iso-8859-1?Q?tJvhV2Br4QazYXudm0Scb36Auu+G2zSKE4FWW0UDe5RPEA6xur1ysxZQZV?=
 =?iso-8859-1?Q?6dB1t9ndOStjpADF4NHNxgKv5zElY4JVo4HQlLrHvt6s7cFzMKNWcuzLNG?=
 =?iso-8859-1?Q?k/HVJgXzXe5aXFyQqgqnY7UpfseXF4v1SqYbi0KQHHC8cRGIjLAjytBPBa?=
 =?iso-8859-1?Q?328ISvo6af9GVWikehXIDc2HVUaq1u4UHNwGGw2KQfMk5RWoS78Hkelpte?=
 =?iso-8859-1?Q?6+bRYCRLkBNRG/p7EJElq0yZLRh4P6uZJ9CMoeYbu5+J7Dck5GxX7/KLpo?=
 =?iso-8859-1?Q?oZO4Ov0pov8VEfrEv/KjJDTQswEcYnERHW2XPZmCN4Z3RhEzGKar49yBTS?=
 =?iso-8859-1?Q?xbOpQvMGSLzRKHyGHmDZpuqKCl7QgwjpyefbLF3jTYwzig3UqS05TfwptL?=
 =?iso-8859-1?Q?5l2EZq7/0FW+I3ofINYzC+aGs9z2nTpUNe6WY8YDPyFMBCiZvoDwrgCVUg?=
 =?iso-8859-1?Q?zGHV/Fnllg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 50sofkXnWzG4xXn12eBc8PakzcXmPz7AELTkUOHNzJRZ+BUgg3vwEfJR5Oaq84FNBUuR/byFjjCPk0c4ZNVhCdZFRZwjeH4sK8HP00eTyaMFMV39xnu5CDELkdhjgRXwYfzVNaFAnzzPbXb5RuJFi/pL+KE+z/9RraEWGDDKPpGqaOXD+yJIzjzPvsk8HuaGYGBlO7Ui6GvyfOGhk01mPGSrUSiCGVO72KKsY/QhY9MuKoExTi8FQ2cA5lKC/4wXNQjjWkcTo7+xeE67shH6N9q7dC1QXK1hF1H1+QVwv/IjXkeePHarCoxZS15NNZl5PoSFRWVS+CTZtRyntCLguQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e209f405-d0a3-4720-88cc-08df25bd30ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 04:24:20.9222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDuYEmq82GxevoN62TIw5gM1EAHS4xI84ZSkzujz1gEk8jWwvyHwie9u0e7ZMED1qxsU4rMTIjzn6GOHLmvxUpOjMGwKw742IVvIZersxcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF10E309DEE
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Akihiko,

> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating
> dmabuf from multiple ranges
>=20
> On 2026/10/08 5:09, Vivek Kasireddy wrote:
> > In order to create a dmabuf associated with a buffer that spans
> > multiple ranges, we first need to identify the VFIO region and
> > index the buffer (represented by iovec) belongs to and then
> > translate its addresses to offsets within that region.
> >
> > The qemu_ram_block_from_host() API gives us both the region and
> > the offset info we need to populate the dma ranges so that we can
> > invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
> dmabuf.
> >
> > Also, instead of iterating over all QOM devices to find the
> > VFIODevice associated with a memory region, introduce a helper
> > to just use the vfio_device_list to lookup the VFIODevice.
> > And, introduce another helper to lookup the VFIO region given an
> > address.
> >
> > Lastly, introduce an enum to return the type of error encountered
> > while creating the dmabuf fd.
> >
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   include/hw/vfio/vfio-device.h |  22 +++++++
> >   hw/vfio/device.c              | 109
> ++++++++++++++++++++++++++++++++++
> >   hw/vfio/dmabuf-stubs.c        |  17 ++++++
> >   hw/vfio/meson.build           |   1 +
> >   4 files changed, 149 insertions(+)
> >   create mode 100644 hw/vfio/dmabuf-stubs.c
> >
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
> device.h
> > index 8472420d3f..c05430be8a 100644
> > --- a/include/hw/vfio/vfio-device.h
> > +++ b/include/hw/vfio/vfio-device.h
> > @@ -41,6 +41,13 @@ enum {
> >       VFIO_DEVICE_TYPE_AP =3D 3,
> >   };
> >
> > +enum {
> > +    /* The Guest passed addresses stored in IOV are invalid */
> > +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV =3D -1,
> > +    /* Guest or Host may be at fault for this type of error */
> > +    VFIO_DMABUF_CREATE_ERR_UNSPEC =3D -2,
> > +};
> > +
> >   typedef struct VFIODeviceOps VFIODeviceOps;
> >   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> >   typedef struct VFIOMigration VFIOMigration;
> > @@ -323,6 +330,21 @@ bool vfio_device_has_region_cap(VFIODevice
> *vbasedev, int region, uint16_t cap_t
> >
> >   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> >                                   struct vfio_irq_info *info);
> > +
> > +/**
> > + * Create a dmabuf fd by first translating the addresses in the
> > + * iovec array into VFIO region offsets and then invoking the
> > + * VFIO_DEVICE_FEATURE_DMA_BUF feature.
> > + *
> > + * @iov: array of iovec entries associated with a buffer
> > + * @iov_cnt: number of entries in the iovec array
> > + * @errp: pointer to Error*, to store an error if it happens.
> > + *
> > + * Returns the created dmabuf fd or either
> VFIO_DMABUF_CREATE_ERR_UNSPEC
> > + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
> > + */
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp);
> >   #endif
> >
> >   /* Returns 0 on success, or a negative errno. */
> > diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> > index 4f11959633..d95503a5f1 100644
> > --- a/hw/vfio/device.c
> > +++ b/hw/vfio/device.c
> > @@ -21,7 +21,9 @@
> >   #include "qemu/osdep.h"
> >   #include <sys/ioctl.h>
> >
> > +#include "system/ramblock.h"
> >   #include "hw/vfio/vfio-device.h"
> > +#include "hw/vfio/vfio-region.h"
> >   #include "hw/vfio/pci.h"
> >   #include "hw/core/iommu.h"
> >   #include "trace.h"
> > @@ -667,3 +669,110 @@ static VFIODeviceIOOps
> vfio_device_io_ops_ioctl =3D {
> >       .region_read =3D vfio_device_io_region_read,
> >       .region_write =3D vfio_device_io_region_write,
> >   };
> > +
> > +/*
> > + * This helper looks up the VFIODevice corresponding to the given
> iov. It
> > + * can be useful to determinine if a buffer (represented by the iov)
> belongs
> > + * to a VFIO device or not. This is mainly invoked when external
> components
> > + * such as virtio-gpu request creation of dmabuf fds for buffers that
> may
> > + * belong to a VFIO device.
> > + */
> > +static bool vfio_device_lookup(struct iovec *iov, VFIODevice
> **vbasedevp,
> > +                               RAMBlock **first_rbp, Error **errp)
> > +{
> > +    VFIODevice *vbasedev;
> > +    RAMBlock *first_rb;
> > +    ram_addr_t offset;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        error_setg(errp, "Could not find first ramblock\n");
> > +        return false;
> > +    }
> > +
> > +    *first_rbp =3D first_rb;
> > +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>=20
> This traverses vfio_device_list using next. next belongs to the legacy
> IOMMU-group list. With devices in separate groups, or multiple devices
> using iommufd, buffers belonging to devices beyond the global head are
> missed and DMA-BUF creation fails. Please use global_next.
Ok, will replace next with global_next.

>=20
> > +        if (vbasedev->dev =3D=3D first_rb->mr->dev) {
> > +            *vbasedevp =3D vbasedev;
> > +            return true;
> > +        }
> > +    }
> > +    error_setg(errp, "No VFIO device found to create dmabuf from\n");
> > +    return false;
> > +}
> > +
> > +/*
> > + * This helper looks up the VFIORegion corresponding to the given
> address.
> > + * It also verifies that the RAMBlock associated with the address is
> the
> > + * same as the first_rb passed in. This is to ensure that all addresse=
s
> > + * in the iov belong to the same region.
> > + */
> > +static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
> > +                               RAMBlock *first_rb, ram_addr_t *offsetp=
,
> > +                               Error **errp)
> > +{
> > +    VFIORegion *region;
> > +    RAMBlock *rb;
> > +
> > +    rb =3D qemu_ram_block_from_host(addr, false, offsetp);
> > +    if (!rb || rb !=3D first_rb) {
> > +        error_setg(errp, "Dmabuf segments must belong to the same
> region\n");
> > +        return false;
> > +    }
> > +
> > +    region =3D vfio_get_region_from_mr(rb->mr);
> > +    if (region) {
> > +        *regionp =3D region;
> > +        return true;
> > +    }
> > +    error_setg(errp, "Could not find valid region for dmabuf
> segment\n");
> > +    return false;
> > +}
> > +
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp)
> > +{
> > +    g_autofree struct vfio_device_feature *feature =3D NULL;
> > +    struct vfio_device_feature_dma_buf *dma_buf;
> > +    RAMBlock *first_rb =3D NULL;
> > +    VFIODevice *vbasedev;
> > +    VFIORegion *region;
> > +    ram_addr_t offset;
> > +    size_t argsz;
> > +    int i, ret;
> > +
> > +    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
> > +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +    }
> > +
> > +    argsz =3D sizeof(*feature) + sizeof (*dma_buf) +
> > +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> > +    feature =3D g_malloc0(argsz);
> > +    *feature =3D (struct vfio_device_feature) {
> > +        .argsz =3D argsz,
> > +        .flags =3D VFIO_DEVICE_FEATURE_GET |
> VFIO_DEVICE_FEATURE_DMA_BUF,
> > +    };
> > +    dma_buf =3D (struct vfio_device_feature_dma_buf *)feature->data;
> > +
> > +    for (i =3D 0; i < iov_cnt; i++) {
> > +        if (!vfio_region_lookup(iov[i].iov_base, &region,
> > +                                first_rb, &offset, errp)) {
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +        }
> > +
> > +        dma_buf->region_index =3D region->nr;
> > +        dma_buf->dma_ranges[i].offset =3D offset;
> > +        dma_buf->dma_ranges[i].length =3D iov[i].iov_len;
> > +    }
> > +
> > +    dma_buf->nr_ranges =3D iov_cnt;
> > +    dma_buf->open_flags =3D O_RDONLY | O_CLOEXEC;
> > +
> > +    ret =3D vfio_device_get_feature(vbasedev, feature);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret,
> > +                         "Could not create dmabuf fd via VFIO device")=
;
> > +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> > +    }
> > +    return ret;
> > +}
> > diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> > new file mode 100644
> > index 0000000000..fb5318e929
> > --- /dev/null
> > +++ b/hw/vfio/dmabuf-stubs.c
> > @@ -0,0 +1,17 @@
> > +/*
> > + * Copyright (c) 2026 Intel and/or its affiliates.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/iov.h"
> > +#include "hw/vfio/vfio-device.h"
> > +
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp)
> > +{
> > +    error_setg(errp, "VFIO dmabuf support is not enabled");
> > +    return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> > +}
>=20
> The new stub builds when VFIO is disabled, but its declaration is inside
> #ifdef CONFIG_LINUX. Consequently, -Wmissing-prototypes fails builds
> such as macOS CI.
Thanks for checking non-linux builds. I guess I'll need to move the declara=
tion
out of the #ifdef CONFIG_LINUX block in vfio-device.h to fix this issue.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> > index c7c31b78f6..aa6f4bc1b4 100644
> > --- a/hw/vfio/meson.build
> > +++ b/hw/vfio/meson.build
> > @@ -38,3 +38,4 @@ stub_ss.add(files('iommufd-stubs.c'))
> >   system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> >     'display.c',
> >   ))
> > +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))


