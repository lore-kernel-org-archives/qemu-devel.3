Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B0C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfyIP-0000gq-LX; Fri, 01 Mar 2024 03:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfyIM-0000ej-Am; Fri, 01 Mar 2024 03:31:06 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfyII-0002Sx-RY; Fri, 01 Mar 2024 03:31:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnMUFo0MXPkyZS8yRNhwLULWc1wwfEMXrpfbzu/S7qJkpejuYTI7EPhvBgIgAOZ549db9Qh9WmpQN5griqM5QOozCvY717Vn1EZrDr7LJJC0XqAKKa9PERQkVc6b4sOqerHMnP4Mjkn0+ofN3qemL2nvTGfjbkse5zwHLUJOg+XMwlaFH5CAKST51uxn4czaCAgb7OWxtX/GqaOTl2g9xCzbZV/Elwj89Lw4WHyykQI41/ADZMMCiO18GFI2cEKhmXffqngn9geAbfEW5RsfTsFCAuboVF+wYC/6joWmTYynNc8WnEixtmqtR2T8wQ812J0p9WFDy/SXd6hBWFP1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq34Xv40KB2/2ci6ZmXXXRbWTdrCQ946er9rvvmAwVE=;
 b=ArP7KrKXnMnLZSek94K7AenZkVsU4zoTnn+bJtQso9hzRi+r6be+yb48koicklcPl57HXC/eFRu0904YB+whJ3blJZhkRj/XCcl5a2gpaUBylXRPDVUtVKahalXjYUx7omfGYei/oG7TxhsVuDT7IC9N8FBlE3vcSBT4D8dUGJYO2wu9VjBw9OtUR4HbBR38zqyBL7jHUc5cf2E1cWFym0VM8OrZi/QtGomQ3WZXzxSOCP+lfn0OENzdnN1JpXypP5PiWM1MwDl7I8SZ/MwNzgu75N8pqZP9UY8QtVyulSpuRU2r3qfjvVEZazNRQRHEyDaK0OV+k1N+Xn0SQhnJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq34Xv40KB2/2ci6ZmXXXRbWTdrCQ946er9rvvmAwVE=;
 b=LC+IHabc+hucoUUj+hXhIMgluGd60nYxNa1y8x1UNCih0ueXSOP+DAqskkqlS5tH/BDTKE8x62q4OFywhCTEDUIgA1qQdRgrxK1Cmoth8OADNV0Ouuyuc7bhUv3bJMBRY2vggumEkDYD5Xxtn2P/vu5FO8IirWLWRnOU/UwWIrS+rHIk0UCZh6JJz5fBa+eqfiu8VvWhwl8MgcSfDsD6sIv58XOKol32zZYydDlEg0SV2AIOfX0D5We5vW6QqtoKxeLm5bAndDDFbiKrpbMdXTv6TTScfBFm2z/FJeszve/lY9AMUokvWoiBUqKLpEbbqE4YIoA5t3HWS04qag6M6A==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 08:30:56 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 08:30:55 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron via
 <qemu-devel@nongnu.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgAEKOgiAAJAlgIAABwOAgAMJgwCAAROj7g==
Date: Fri, 1 Mar 2024 08:30:55 +0000
Message-ID: <SA1PR12MB71994177D7677F77CB55D687B05E2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71992ECFBF9FA3EE3C350EA8B0592@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240227171115.00004c7b@Huawei.com>	<20240227173621.00003694@Huawei.com>
 <20240229155910.00005186@huawei.com>
In-Reply-To: <20240229155910.00005186@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|CH3PR12MB7546:EE_
x-ms-office365-filtering-correlation-id: 827f6f5b-ae86-4dd7-0273-08dc39c9ea1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6CLJgrB2Xl3W8kvwDJ7kTYFqkB+6k145UZW9aVMFLk58r9Qug8Yifkjnur7+CEmE/qUTR+4+x86rp2K8DEaib/SBbU7eEvz3RUu3nIZwb6dmyEexlrBr8E3IfvV1ErXKIL7oGOLa+555T0X68N+VJ84oyBG/GP0BSeyKrqjtQlQzBD0tSulSrqPaszGICO0sJSPhcgzPtGx++X6YX6GlVV1bLvHdHS4br0YBXmqHSsumqGVr/yExY2uuZ/OyNK9e0PSnyKCr6EyBQJMrJB5XKb91pgE762BtDHNokbblv95/NNFvXblA4zlBgew9WQct3BbHG1h5qODuNU6JjSDIgg/SG0S1sNIUAqTPxUtF3Byg48Vg13dmQFLgfeSPycrfkHeoC1Wp5GRaKrKTtQ9d5BCv+MoPH480SlmUnGGcac+HA7fQBwRoGvPzaMAGbMsfHGdhVhaVqGYGFRZesbppHliAa2aBFL36i1pF8rHChZkTubE+NNG72TJ38TpdlQ/0IYRijx5VnrK0Ox50MSLkrEAwKsEF69jdUXVcmw52ZWQ/pcaASX33CV1n5YsKIswWPmjAaq9Hqj8AmXn2dwX9+vOx3MofKZ/2Edmg59i1XxzeR/6WU7vtNbAFatYeooCXdoa8LK/GzGFzVkFb86XSm0ndIy6XzNUbbQpGDolKNli2IQt5+Zz2aWZLqrMLRKqaoHn+ddGw9kqRnY6oeZmHxe9tID9stj+m3LbNNgyy24=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aowC/JOZMcKDnuVHQqZ/g4J0L7sXQCKtqq3Rv9CtDrgY/AQH/rkFPtOvSG?=
 =?iso-8859-1?Q?RbEoCpFuIoBn/mt1R9GlMx1b0BXCYIviSobOESXhT909c76aDnbdroefA6?=
 =?iso-8859-1?Q?bqbKPPntrdbzu0k18++lCzplu3zm7aqxLpmCy1hPu/F5lsyDvFimkNCu/q?=
 =?iso-8859-1?Q?IcrfTkfAU6eQf0BS0To5c1TyYgB9Ntzruik0eyoi71ykQABZZfX0LJwEVf?=
 =?iso-8859-1?Q?ySyDQewEHZ/vgTMm5Z3aT7925p9lL3haF9zcP+8pX0Cp9nXC7i5RdytDXh?=
 =?iso-8859-1?Q?XSdJE6eXsLUrYKAQD0jRBKE9zFlIOYVLwWhKmMAnBeZEBq2eqY/joeDKsl?=
 =?iso-8859-1?Q?ey/oyo5eg4yC0681dpLBwkWFpJT8SteUlzPL/0xvuNYLDGtfezeV19D900?=
 =?iso-8859-1?Q?C9aaJEy+IC13UkFRuI/nwKnKTazn/ERCm1vntSb3M/GZgRjywUlQC4IbMp?=
 =?iso-8859-1?Q?ha6gWJ4YDStAxXl2sAA62Ha7sx1m+3enJx1Vk5U9oD3cLeiL5gBHJAJsFn?=
 =?iso-8859-1?Q?W9fTWWW54J3dKbmikPmk+T2CVw0VFXQA8vDw04ZmUcX/2E3Ar7a1MCsUAO?=
 =?iso-8859-1?Q?z1GjoNOHutwuNwfgEnnQj68maKnMRxtw84iVXS/dZe79SvJrDDAKCdZChl?=
 =?iso-8859-1?Q?LRAEQ6kgSrXH4hSoRCtCsLUWrgxtrAsuCqgP2gNDgk5mfTTIXmQb2j6L0d?=
 =?iso-8859-1?Q?dUE/qq9EGg9L93ASoCPjhT0mGhQQZfR/FdG72vHzxmjoF7ugCdMLZlHkG3?=
 =?iso-8859-1?Q?0ZqcRKgRbtRmRBZVPM/Wz2r5S8d9sxb/gyqa1W0xI46ax148IUy1D8pn/U?=
 =?iso-8859-1?Q?JZcVEkDiTHD/EqtCzF6Mq00y3HNAB2Y7i41VqVX04hGgQuB5EIOWQAtBTS?=
 =?iso-8859-1?Q?WA0mYoJL+FZ08ey82U6+jFFJQwKKqLt2zpibWGU4cEoJzkUCo39Ce+BCVM?=
 =?iso-8859-1?Q?uKNopPwxbSsfYcCapbafyuN6C4yypOQmVgvhbKEK9me0gDh8sdC3AM26Xt?=
 =?iso-8859-1?Q?SjB+o6QEoEoCSXLkVYIeH0S7GrIA6mwI9CyzcRJ43LyaorRxJjNGwiW83R?=
 =?iso-8859-1?Q?AhYF43lyP8TuIZJFOA1k3K+krfqg6qY79IdmxcovGdIUbnkNpgBeuQsz6m?=
 =?iso-8859-1?Q?8kV/2OMPq72RGOdb31SMGfVIx8lncpPbohuliJXb9CNsLydRK6IwDMferB?=
 =?iso-8859-1?Q?jXrK/n2jw76ZNjflu451Pm6h2MvEH2s3hF6L9kbfo3r2sK8J+OyDqKuKZW?=
 =?iso-8859-1?Q?aHkH88ht0O/MQOmMaE/26euLrpUTDo1wZLoiy7bFjDZOrfAnvhCUQ+f4Ip?=
 =?iso-8859-1?Q?JXSa0boeVKHBKJ5Bkburhw0H5svODk0jWtvU4r1YSX2I4mZF93Y5JjNuPu?=
 =?iso-8859-1?Q?hO9M0u2KyaMcOVWjyKba3YtxtYQUECY6xiXlSmOSYL4EOc4Nmvl6m+O+Ch?=
 =?iso-8859-1?Q?CjvK11qz49J8/aovRviPjGFKQnCuuw3EMvz8jZv4zJfKnv/02HNDjEPa0y?=
 =?iso-8859-1?Q?bDVAo8rBEh3jR0ALDc/RJERzLdjgvPCFsdqVVpCSa3Np67F3ckIHLwTJfK?=
 =?iso-8859-1?Q?j2H4MYdOLHmA7p3sabTBXxtXwpHeEzPy6U+cZhCtdkKrb5bMcEeAvwHDh9?=
 =?iso-8859-1?Q?bYR7pUy5+qkyE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827f6f5b-ae86-4dd7-0273-08dc39c9ea1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 08:30:55.8690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5epae83bCxtNeV40JndfIc0GXuLO4k7jVUBeISFBA5KLtzpyqw1LXMV04FqkDJjKqaMFJ/Q91EST2gJX36LLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>>=0A=
>> One more thing.=A0 Right now we can't use Generic Initiators as=0A=
>> HMAT initiators.=A0 That also wants fixing given that's their=0A=
>> normal usecase rather than what you are using them for so it=0A=
>> should 'work'.=0A=
>=0A=
> Something along the lines of this will do the job.=0A=
=0A=
Thanks! Will incorporate the patch in the next posting.=0A=
=0A=
>=0A=
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h=0A=
> index 4173ef2afa..825cfe86bc 100644=0A=
> --- a/include/sysemu/numa.h=0A=
> +++ b/include/sysemu/numa.h=0A=
> @@ -41,6 +41,7 @@ struct NodeInfo {=0A=
>=A0=A0=A0=A0 struct HostMemoryBackend *node_memdev;=0A=
>=A0=A0=A0=A0 bool present;=0A=
>=A0=A0=A0=A0 bool has_cpu;=0A=
>+=A0=A0=A0 bool has_gi;=0A=
>=A0=A0=A0=A0 uint8_t lb_info_provided;=0A=
>=A0=A0=A0=A0 uint16_t initiator;=0A=
>=A0=A0=A0=A0 uint8_t distance[MAX_NODES];=0A=
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-init=
iator.c=0A=
> index 9179590a42..8a67300320 100644=0A=
> --- a/hw/acpi/acpi-generic-initiator.c=0A=
> +++ b/hw/acpi/acpi-generic-initiator.c=0A=
> @@ -6,6 +6,7 @@=0A=
>=A0#include "qemu/osdep.h"=0A=
>=A0#include "hw/acpi/acpi-generic-initiator.h"=0A=
>=A0#include "hw/pci/pci_device.h"=0A=
> +#include "hw/boards.h"=0A=
>=A0#include "qapi/error.h"=0A=
>=A0#include "qapi/qapi-builtin-visit.h"=0A=
>=A0#include "qapi/visitor.h"=0A=
> @@ -58,6 +59,7 @@ static void acpi_generic_node_set_node(Object *obj, Vis=
itor *v,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const char *name, void *opaqu=
e,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error **errp)=0A=
>=A0{=0A=
> +=A0=A0=A0 MachineState *ms =3D MACHINE(qdev_get_machine());=0A=
>=A0=A0=A0=A0 AcpiGenericNode *gn =3D ACPI_GENERIC_NODE(obj);=0A=
>=A0=A0=A0=A0 uint32_t value;=0A=
>=0A=
> @@ -72,6 +74,10 @@ static void acpi_generic_node_set_node(Object *obj, Vi=
sitor *v,=0A=
>=A0=A0=A0=A0 }=0A=
>=0A=
>=A0=A0=A0=A0 gn->node =3D value;=0A=
> +=0A=
> +=A0=A0=A0 if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0 ms->numa_state->nodes[gn->node].has_gi =3D true;=
=0A=
> +=A0=A0=A0 }=0A=
>=A0}=0A=
>=0A=
>=A0static void acpi_generic_node_class_init(ObjectClass *oc, void *data)=
=0A=
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c=0A=
> index b933ae3c06..9b1662b6b8 100644=0A=
> --- a/hw/acpi/hmat.c=0A=
> +++ b/hw/acpi/hmat.c=0A=
> @@ -225,7 +225,7 @@ static void hmat_build_table_structs(GArray *table_da=
ta, NumaState *numa_state)=0A=
>=A0=A0=A0=A0 }=0A=
>=0A=
>=A0=A0=A0=A0 for (i =3D 0; i < numa_state->num_nodes; i++) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0 if (numa_state->nodes[i].has_cpu) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0 if (numa_state->nodes[i].has_cpu || numa_state->no=
des[i].has_gi) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 initiator_list[num_initiator++] =3D i=
;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0=A0=A0=A0 }=0A=
> diff --git a/hw/core/numa.c b/hw/core/numa.c=0A=
> index f08956ddb0..58a32f1564 100644=0A=
> --- a/hw/core/numa.c=0A=
> +++ b/hw/core/numa.c=0A=
> @@ -229,7 +229,8 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHm=
atLBOptions *node,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 node->target, nu=
ma_state->num_nodes);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
>=A0=A0=A0=A0 }=0A=
> -=A0=A0=A0 if (!numa_info[node->initiator].has_cpu) {=0A=
> +=A0=A0=A0 if (!numa_info[node->initiator].has_cpu &&=0A=
> +=A0=A0=A0=A0=A0=A0=A0 !numa_info[node->initiator].has_gi) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "Invalid initiator=3D%d, it isn'=
t an "=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "initiator proxi=
mity domain", node->initiator);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
>=0A=
> Jonathan=0A=
>=0A=
> >=0A=
> >=0A=
> >=0A=
>=0A=

