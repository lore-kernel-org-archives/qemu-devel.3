Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E1BE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDIE-00048T-4A; Mon, 16 Dec 2024 10:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tNDIC-000487-SE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:45:56 -0500
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com
 ([40.107.236.86] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tNDI9-0003U2-Au
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:45:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrk2FXL94a0CtlND4bOD42P6oAieFj8nGi/Qw+6MPPNhD54Y3ZdMbewBC07kKJip1Yx41kdQW95ifs+4x9RN/JqN5JASKywf9/ZgPu9iLDk3q1EFzkf6YpFviAhmXB3bMViNsJSaRD6yukriSAxg+rgoFHyw0xPuXJ5IbdwtEcOR9FKP1xyHaJhkwMTabOQSEeKOwk/42hQC1yn8hB3Cg/2YNNeKlGoX6JXQyjC5K1ICIF52umRDOKu9tBHkU1VgUl6zyhGBPeROnuoQaqNMehxKzKTo1nNn6HesLRiIQa3KV8z+FLjtQGMYS/p0SwVbAL+IaddO4vijqAzmKRRaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKHA5QYCUoirfz0yFOw7mt9s6lrHSzXJJNVKspVx+GM=;
 b=W4LJVUbYZNnwYx4IB08WR1FJxKYiqbX+27EQmV3CKz8cLGjgK+1lA+UmWEq4facO5ic3vPue7kvG+incg9n8OcxFM9SSsaeu4amQ74JJjgfYlAOcof/hr+bf5vvl/J2+vv+3arL454iBQDO+kH1mKPZCWO5GzrHvdmbkZck+PeWKbnvXyT2yJXOZ9Bdc5M4KT8cWql4ewH6QhE14bP5BkrYdl+8yPJSBEFk38Qxi3+ZEV+7dW+UxfH2dNIIRvFO9YRjQ7y9gR1B27st+YOyrDYdhnVxAhxY61jXAO2940wopnLXsN+9TxO3eRTkY+x8jBRpidEkHTv5oQb7Jo+6Row==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKHA5QYCUoirfz0yFOw7mt9s6lrHSzXJJNVKspVx+GM=;
 b=14XWsYqDfen2DSXPJ3tOYenaOzICoaAJPOL39TStpktzwtcMPWxluKGD6TOnSvsH93xaoLDl8AgBZ5Cp9Xxn/x7r0WUh43UH+bryMWOUHZnjaIOTlG3bjrbYreeyXkJDM7reXoFFSZKXoW0KXvGKN8cmhOds2FTD2Bc0NNAvbqY=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 15:40:46 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:40:46 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>
Subject: RE: [PATCH] hostmem-file: add the 'hmem' option
Thread-Topic: [PATCH] hostmem-file: add the 'hmem' option
Thread-Index: AQHbRm+T08edT93tD0m94+3Dx5+wM7LZAIAAgAB6QhCABPYygIABblGQgAAOkYCAABsxEIAI+uSAgAAOZGA=
Date: Mon, 16 Dec 2024 15:40:46 +0000
Message-ID: <BL1PR12MB53173E34667640A2342B8C64F13B2@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
 <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ab889035-afa2-4a32-8a13-b8bd21b69fc7@redhat.com>
 <BL1PR12MB5317B47F9AF0068760239C8BF13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
 <cbe5a04e-caac-4ddc-a7a4-6c6bf5b0fac8@redhat.com>
 <BL1PR12MB5317EAF52CFCABB96E05D538F13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
 <20241216154005.080389f3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241216154005.080389f3@imammedo.users.ipa.redhat.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=33781a78-a06b-4f00-b7bf-318d5619b1e7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-16T15:31:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|DM4PR12MB6302:EE_
x-ms-office365-filtering-correlation-id: f6806ae6-729b-422d-1ece-08dd1de80218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZaO91NUQXWqqLchwKYbHRBqmE3jodHtDjuA4P9NAKeJnX/vwb0inyTMd1DTS?=
 =?us-ascii?Q?wiTyVY5TD5Pl1FAld0JKfzKIPxaZEXlxuJnrYtzVHCd4rdmIWrzpkJX9lpR1?=
 =?us-ascii?Q?O06QZ5g0uSLneU9wKql5SozAiHHLou/3qkRjIDw55LvoSrewVrqsKiSdFg8t?=
 =?us-ascii?Q?YwUaRoxn6x+Mwi0RzMBQlLXYo1szQP2EdVpXfSrQod71ui/sPV9pRsOylzfn?=
 =?us-ascii?Q?Q1xq7/hGhPAOS9RdWy9XQKrdmFvSdKnlPffcMGxnpKM0DppbzJC3zeajNIm3?=
 =?us-ascii?Q?vjKrDLdWv62E8f5kZymeUr/lSa3VEdoZAzN0PnVv0M/lPoUlJGkfLuIOqdM+?=
 =?us-ascii?Q?cuY9sVwkEYMrvKpvBDHM1CAE89EUhlSzR5w0DWwhzAEGoPjjjah8gwqUsebM?=
 =?us-ascii?Q?ngPjph/9k261rF+VGWE5EzAPQj1b3K7uQHN4gFY2PZGFjCcjlTUJJxBf7/ac?=
 =?us-ascii?Q?IMSAOuEHzGTSc6GoNqW2/+xWgy/6y3X8pJV/SSmpwPSPX+tWwQUiZClH6nfJ?=
 =?us-ascii?Q?B1ITg40MNnTYyC4Cvx2Gr1u2BEkjKLe5A9/c9lT13H5k6cOHuv43orAzllfb?=
 =?us-ascii?Q?mQpN+CWg2mHwXg1ugSQqyKyewQ8VKW7W9TE9eCL49tE92c5mglcphHR3Wqcs?=
 =?us-ascii?Q?ss68IF8pMKTz7HB1dIr9lT+iLs/jq+PWHtVpqlXHPweIXlnHd3i9rvoHvLh0?=
 =?us-ascii?Q?zjUPR1PJatsyIzFGcqLhq7a+RiXCvRW69JiOXa6A0nvY9gIvxMc527qiHcS5?=
 =?us-ascii?Q?InSTYReUYBOVIUJiIRlgYrhAn3iailnb1PkyFwSNtCXcNaAS382FV67h2wdk?=
 =?us-ascii?Q?H7Xs98GB98qKKY+gbw2dYo9/ozt6n9ZAtaJEn3HME3Y+lys73UREo2Ubm/rf?=
 =?us-ascii?Q?b839bxGrHZwMAml510+OTQH5nk4XDuECaS7mtHEFtmaz0A060RPAdzrrc5Q0?=
 =?us-ascii?Q?vWRXg/siJKX3xinr+DJelHAvJ0YaIabarBE6QCjRL9v4JDMSQ29JKThq3FAH?=
 =?us-ascii?Q?75kBf0ptia52FBkK2liALz9hFxUFisuH3AffX3WelPdBAV4iHkB9zEmO/Otd?=
 =?us-ascii?Q?CLkjRiG9MwniyFfQxK+NXmT7HvqdVcyDuUNeIv76FjhzA2shyJBDol4+CzYN?=
 =?us-ascii?Q?8xq2KvH2CODvN1GT0dZIwkjZmqPDONJcWwZylxCeROtNd2ZvrvGGOo0NQPrq?=
 =?us-ascii?Q?Qzj0kuZ5b/oJOzEgjUnDChdmosaLRzsKNlN5aFYe+22WEZvfamPVDSw1BGwP?=
 =?us-ascii?Q?1928SHnckYikTcHa9cdFl1gzknnK8zSdD2J9jpy3OgxycFm5ehKERlxVUzyq?=
 =?us-ascii?Q?+xceUGDzX6brMYa3kLBW6n8ZIZgschTQ5/87aeAoYoTFYbfjvwF8j9kRBSik?=
 =?us-ascii?Q?XPfBqOspMQ+9K1ggXgbkExaG2lP8CI9OLCHQ6H2OXAU/0xiMXAXEfPIPOwg/?=
 =?us-ascii?Q?3bBzwIdNPUiYqBSi9zjJz7O19iAUMcmH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e3tb7r4NswSQeeWSfLZWpx6BDFgL4i8QheY8Wq5uqciRvcPX83mbw+Ow19jL?=
 =?us-ascii?Q?gBIPNSxHLHBJ4RfFH46wx3MAOpnJM07rqaWhl67KOjcY9v+pTpDk1uv5C/pA?=
 =?us-ascii?Q?DAh3Gesid5t4ZBDjEsUSvW4r1UmPfSok5DHc6QA79O00PqIIQK7TpnG5ik+Y?=
 =?us-ascii?Q?URrPpdC8jwC2NLX/RFpCILM7QAyJ/CJWaf+8r/X2db2QaBnS336/OmqFiEID?=
 =?us-ascii?Q?3zBnhkDzVbTor92QrkJH4WlxZwSGuTqslj0AVuiuplvZruJlUENv0EFEvXp2?=
 =?us-ascii?Q?WP6ZTjqtRjJ1EisbWtgiA9RVpcemNQGMrHkgWt76QoYVMC2nf8kQtmOFmCAv?=
 =?us-ascii?Q?Q44WkHVu9YDBqNqcCkQ8mVhoiQM2AoWToc2cRG8Vpbv0r5LrW1DT//EDflo0?=
 =?us-ascii?Q?7DB2OUV2Txlt7M8LTueztQKE4ni6bA+Yg70raRI+4fREe6WzVePwbcdw43s1?=
 =?us-ascii?Q?7EC3uHD34Flv5eQrZzHAIBwNbeUi2Igb2pqqYKoy5JA0W/CJ6fXYIHThx8p/?=
 =?us-ascii?Q?qfr5VTHxf8RJXBASikwCIbz5q1lKQTrFQcze967OHQzA5JYw8sKmOUG1kZxy?=
 =?us-ascii?Q?Xfr8U5pVO5rMpA6mHJ3FdmYxFLl6oLuOIJS17tPuhCnb/iWJlBQWHwvvB7oJ?=
 =?us-ascii?Q?/TDykMXGWQ28EGuu0jHQPI0lBUT14Lzn9yPyUY/aX8ELN7ET7YthaQzNkz3e?=
 =?us-ascii?Q?K7g2BA6X1/vidvkgGuIjrPCmVsiYmgRv8vi13EYoFqa2W+LLBocq3tECgHFE?=
 =?us-ascii?Q?nqgdMG/CygYR/5fc3zybb8E56+fsSGDeL7fMZUPwVy8JRWW9HR7YhA5IRkpQ?=
 =?us-ascii?Q?ugxy4vff2np/a7jfxb5VzfpiWENYVFW3Cc78QJAypfKiV6rGMIIlsgtzNYOV?=
 =?us-ascii?Q?NWkg/I190Btjwex3VTmMNQi97pp9oQxenB02s4ba92YfT5g4bpFSY3I63nnu?=
 =?us-ascii?Q?c0uOtZ4K9EN6Ax+wOYZJuXfwzGydRohxW2WbwrhJoW0FQ1m4SjOTHtnxakOz?=
 =?us-ascii?Q?ZWX7ViikuKi5462c6zbPQXnMf59QwkH/LKi3n3ZgAtTRDkz8RmCjuuNFTnA0?=
 =?us-ascii?Q?rdFvjNB+GQi/YaCOxeByff2wnNuSDjipekCBseL06adHaholJu+KLCrFEg+f?=
 =?us-ascii?Q?uN/Z7PiB4HAqDVRjq5u+3wiLAsGTNXVyqgtoOk7p0LKxA1VZAIhAY6jvmb3/?=
 =?us-ascii?Q?LCLVV18VS6npIudPtm/M96p3Hs6Uq/CyqilrlY442KyPBwtfH9bWQsNS8crE?=
 =?us-ascii?Q?cAs7L42sZkmEEWtOMv9EvSJptHyLm1ebEitrPq+xKCFZmZQkfWW19S5TqX/K?=
 =?us-ascii?Q?XoxYGHua8XR8uHNyZbdzaZBGbOhOW5i533F/UPWSmakSggc85h096lOgl4Yy?=
 =?us-ascii?Q?P3RGW2CA60xNUzoYkAd2td2LEhlwaAT+MtAo5rW1qQHPGD+6wjy3Set7a76y?=
 =?us-ascii?Q?9zYrXTwrs921I6T/j7Af6FcrOI/kbTK/ECQWrRS+UriBvIyA7tGGus8gwuKX?=
 =?us-ascii?Q?X0GgAOkA4Sa6hH12W8xfOls4Wz+hZBdYIN43xybJv33EbhlGwBdg5KCb7sak?=
 =?us-ascii?Q?nZSax8z4E0QvK9OeeIo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6806ae6-729b-422d-1ece-08dd1de80218
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 15:40:46.1021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5qluO7F8dqM3QbDfIMD6iKJJbYNAgrJ+uEqPqRE5gy5kFVg+C3Y3gnMF3LtOia5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
Received-SPF: permerror client-ip=40.107.236.86;
 envelope-from=Zhigang.Luo@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Monday, December 16, 2024 9:40 AM
> To: Luo, Zhigang <Zhigang.Luo@amd.com>
> Cc: David Hildenbrand <david@redhat.com>; qemu-devel@nongnu.org;
> kraxel@redhat.com
> Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
>
> On Tue, 10 Dec 2024 21:51:40 +0000
> "Luo, Zhigang" <Zhigang.Luo@amd.com> wrote:
>
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: David Hildenbrand <david@redhat.com>
> > > Sent: Tuesday, December 10, 2024 2:55 PM
> > > To: Luo, Zhigang <Zhigang.Luo@amd.com>; qemu-devel@nongnu.org
> > > Cc: kraxel@redhat.com; Igor Mammedov <imammedo@redhat.com>
> > > Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
> > >
> > > On 10.12.24 20:32, Luo, Zhigang wrote:
> > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > >
> > > > Hi David,
> > > >
> > >
> > > Hi,
> > >
> > > >>>
> > > >>> Thanks for your comments.
> > > >>> Let me give you some background for this patch.
> > > >>> I am currently engaged in a project that requires to pass the
> > > >>> EFI_MEMORY_SP
> > > >> (Special Purpose Memory) type memory from host to a virtual
> > > >> machine within QEMU. This memory needs to be EFI_MEMORY_SP type
> > > >> in the virtual machine as well.
> > > >>> This particular memory type is essential for the functionality of=
 my project.
> > > >>
> > > >> Which exact guest memory will be backed by this memory? All guest-
> memory?
> > > > [Luo, Zhigang] not all guest-memory. Only the memory reserved for
> > > > specific
> > > device.
> > >
> > > Can you show me an example QEMU cmdline, and how you would pass that
> > > hostmem-file object to the device?
> > >
> > [Luo, Zhigang] the following is an example. m1 is the reserved memory f=
or pci
> device "0000:03:00.0". both the memory and pci device are set to same num=
a node.
> >
> > -object memory-backend-ram,size=3D8G,id=3Dm0 \ -object
> > memory-backend-file,size=3D16G,id=3Dm1,mem-path=3D/dev/dax0.0,prealloc=
=3Don,al
> > ign=3D1G,hmem=3Don \ -numa node,nodeid=3D0,memdev=3Dm0 -numa
> > node,nodeid=3D1,memdev=3Dm1 \ -device
> > pxb-pcie,id=3Dpcie.1,numa_node=3D1,bus_nr=3D2,bus=3Dpcie.0 \ -device
> > ioh3420,id=3Dpcie_port1,bus=3Dpcie.1,chassis=3D1 \ -device
> > vfio-pci,host=3D0000:03:00.0,id=3Dhostdev0,bus=3Dpcie_port1
>
> Is /dev/dax0.0 a part of host device 0000:03:00.0 that you pass-through t=
o guest
> using vfio?
>
[Luo, Zhigang] from ACPI view, they are in same proximity domain and host d=
evice 0000:03:00.0 has closest distance to access /dev/dax0.0.

>
>
> >
> > > >
> > > >>
> > > >> And, what is the guest OS going to do with this memory?
> > > > [Luo, Zhigang] the device driver in guest will use this reserved me=
mory.
> > >
> > > Okay, so just like CXL memory.
> > >
> > > >
> > > >>
> > > >> Usually, this SP memory (dax, cxl, ...) is not used as boot memory=
.
> > > >> Like on a bare metal system, one would expect that only CXL
> > > >> memory will be marked as special and put aside to the cxl driver,
> > > >> such that the OS can boot on ordinary DIMMs, such that cxl can onl=
ine it etc.
> > > >>
> > > >> So maybe you would want to expose this memory using CXL-mem
> > > >> device to the VM? Or a DIMM?
> > > >>
> > > >> I assume the alternative is to tell the VM on the Linux kernel
> > > >> cmdline to set EFI_MEMORY_SP on this memory. I recall that there
> > > >> is a way to
> > > achieve that.
> > > >>
> > > > [Luo, Zhigang] I know this option. but it requires the end user to
> > > > know where is the
> > > memory location in guest side(start address, size).
> > >
> > > Right.
> > >
> > > >
> > > >
> > > >>> In Linux, the SPM memory will be claimed by hmem-dax driver by
> > > >>> default. With
> > > >> this patch I can use the following config to pass the SPM memory t=
o guest
> VM.
> > > >>> -object
> > > >>> memory-backend-file,size=3D30G,id=3Dm1,mem-path=3D/dev/dax0.0,pre=
alloc
> > > >>> =3Don,
> > > >>> al
> > > >>> ign=3D1G,hmem=3Don
> > > >>>
> > > >>> I was thinking to change the option name from "hmem" to "spm" to
> > > >>> avoid
> > > >> confusion.
> > > >>
> > > >> Likely it should be specified elsewhere, that you want specific
> > > >> guest RAM ranges to be EFI_MEMORY_SP. For a DIMM, it could be a
> > > >> property, similarly maybe for CXL- mem devices (no expert on that)=
.
> > > >>
> > > >> For boot memory / machine memory it could be a machine property.
> > > >> But I'll first have to learn which ranges you actually want to
> > > >> expose that way, and what the VM will do with that information.
> > > > [Luo, Zhigang] we want to expose the SPM memory reserved for specif=
ic
> device.
> > > And we will pass the SPM memory and the device to guest. Then the
> > > device driver can use the SPM memory in guest side.
> > >
> > > Then the device driver should likely have a way to configure that,
> > > not the memory backend.
> > >
> > > After all, the device driver will map it somehow into guest physical
> > > address space (how?).
> > >
> > [Luo, Zhigang] from guest view, it's still system memory, but marked as=
 SPM. So,
> qemu will map the memory to guest physical address space.
> > The device driver just claims to use the SPM memory in guest side.
> >
> > > >
> > > >>
> > > >>>
> > > >>> Do you have any suggestions to achieve this more reasonable?
> > > >>
> > > >> The problem with qemu_ram_foreach_block() is that you would
> > > >> indicate also DIMMs, virtio-mem, ... and even RAMBlocks that are
> > > >> not even used for backing anything to the VM as EFI_MEMORY_SP, whi=
ch is
> wrong.
> > > > [Luo, Zhigang] qemu_ram_foreach_block() will list all memory
> > > > block, but in
> > > pc_update_hmem_memory(), only the memory block with "hmem" flag will
> > > be updated to SPM memory.
> > >
> > > Yes, but imagine a user passing such a memory backend to a
> > > DIMM/virtio-mem/boot memory etc. It will have very undesired side eff=
ects.
> > >
> > [Luo, Zhigang] the user should know what he/she is doing when he/she se=
t the flag
> for the memory region.
> >
> >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> >


