Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EAACCFA05
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 19:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMyz-0000sP-27; Tue, 04 Nov 2025 14:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGMyj-0000l4-QA; Tue, 04 Nov 2025 14:46:07 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGMyg-0007Gk-Qd; Tue, 04 Nov 2025 14:46:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XorKxPX1qH756D6laGVqsX03QiNd+O6fDqz0/z18vkfVAl7GUHpZ8ukAX8N7N3x6FAnkzSYg4+YHLc7sheTcY+X9cRLCBONGRnwNHoLoBT4VmqTy8xb+LD81T472epD598HOs7srMJiXiqpxyq2CMXCeRBFC6qhB6m8kg20hKkSUtn9uqmOJRRzPgwVpp7w9Cs4p/YBjzOMdRhbXjSUqfw+A5BcHFIxipjNwAU+aFL5fhZMarWI9PD/jtb9hWWlqvjE4XB2/UZ4OEGl7XJJHwbVbY6+i0SqU0YudKN1MiSLdCCNWlWVBvJzIIeigNOuXq8HcLe4kkInD30T6CSq91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BimhIIskIB3zKGtSmid9rzumK2iWPpoP4dqKGArge3k=;
 b=PIkj54mN5gKDNXPSHtD3IpifZG/QQ9jBUunsSZj9b1cggjBCS7zZjkGDys+G5MH64bYXWac8Lv1h9J/eLZjOeF9fDhpFh9l9c6OG03O0+Pmd6i5KZF9qdOxTmNTBlsQ3z6P0B/GJcwjBSpPPXP3I4A6gUhN0YzvJnNW4iBQ6Skkw6DE1TYfgdNvIwnP5cc1wa1PZWdlw/05H5ItfzUGcRffeytkUyZ09QjcOPbEYM1QzOTHzSx6VQnNKwA3kd/4SraGq4LEvjAbo2uRq15Bx2FqH1Fch8+pk5i/nJ8CS4xd2jBD95/LMzeiaoYzsxEnVZ5OcKhWBEjfkf1SRm9C3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BimhIIskIB3zKGtSmid9rzumK2iWPpoP4dqKGArge3k=;
 b=BVQX8oqUNnR4cN9S5n2GORu5VtCqdV10Sxh6uJ7VOGXh0KP41AEZmAC2jxwFqrd/DeDXZmfAePVwSuDpp44Vxsl+TEXu5u4BxLu0A89qLXB/ukJJOsTzPfwgk7ztw1zEhpEERi3k18Ial/f7dnuj9QAZZq8tE+yUWcrXhVXqpbMLC45+3E0j4/PnpbwbFSmT6ZTGrJY/F9PwrKP0Ah/DR0B/dLI0knWaNdN87/dKbXYQj8xbwi9N5IDzGLa8bk688QVUL3JAmTOdoKqNWPhfGcCb8ZcBQ/TmDDaKg4y+MGr2CeP9BR5WpgPQvRDreG6/VDKQsZQueWGiOqBhsgkgcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 19:45:53 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 19:45:53 +0000
Date: Tue, 4 Nov 2025 15:45:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251104194552.GN1537560@nvidia.com>
References: <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
 <aQpJi37XslsYV+Ez@Asurada-Nvidia>
 <20251104185651.GL1537560@nvidia.com>
 <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
 <20251104193521.GM1537560@nvidia.com>
 <aQpXSymujCs9l+MQ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQpXSymujCs9l+MQ@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0414.namprd03.prod.outlook.com
 (2603:10b6:408:111::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 87446110-302d-4adc-cfd7-08de1bdac3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x3U3gMMob2kQSVTRsQGeLsOe7pkF7W9dK61S2+/jhobQe0lgi2mNwXN9zJJG?=
 =?us-ascii?Q?RkfakaXeJEblzcbIlMMMJcv/OmFFCHQvIqiitG2jVVf3NDT2pEM0jDNIifpQ?=
 =?us-ascii?Q?etSACkYDKgdJXg26wXlf6xjjE7unGPce3n8oTK8ahHjcuiqjX7w74DtJO6oQ?=
 =?us-ascii?Q?cASOK6OvACMV26JYtmZUdC4WJUl3RBaGphkTW50ST+4Edp8BwLNzcDMJM0mn?=
 =?us-ascii?Q?7kp0deZHjlpPq8jEHySeNRolK2nk7f1ChEVBfA5TV4qAW+U6W+GJpjIIIHyQ?=
 =?us-ascii?Q?y3tPkxW2eb5Zv1qrBGwrEBiE3jUZvBHQYF7wXuQbmS4Y1lwhBz5A1sMVrqNS?=
 =?us-ascii?Q?2IfrHH9qxfM32TnJxlNqDwTCKaaALOC3SkaqHFbLwCFul8cdt6a3AdTcaxjV?=
 =?us-ascii?Q?NPXZdWDyaPGFh9Ga4dttt3CFXbdkaW9EBz4j1GNxyVsWNJ9FjMXhkJtSQrIG?=
 =?us-ascii?Q?KUqo41jDv51thk7l8XW1kVBt8U8+C2U5/6om3IMKZJ7BHLJEPyy0xOhKbK//?=
 =?us-ascii?Q?KM/ClsMlXTEJf1POzxV4O/CiCfBGG28L5Ysm3ZJ1PreaukvVo9Q3TCmet5nH?=
 =?us-ascii?Q?9JdyqKEZAH/IAHTCouJa1ZFg4yCOkYqytV0mYDBx/528MXHxpA+kzL9sIv4Y?=
 =?us-ascii?Q?nd/H3kfelZjE2E94wiqI6nb77dStviTceWgxdEGaO/oVQFT+W9Mkoc64gbHb?=
 =?us-ascii?Q?yir+aH1DYD0dlOEGso7udp/UhCPNAmFCGCTzzXCjaYtEmjtHyKQh9DZI4VZ0?=
 =?us-ascii?Q?6I1ucOxsMnKpakARpSjsqUjoDo2/ET5x4LLyH/6bsrWHZokfIA4jhZQk7ZDq?=
 =?us-ascii?Q?+6LxqGJazx8tRlDRxgchZrbYqnmb3kYmKGUt8GwnAKRxdNyi5kQcZE55SvX9?=
 =?us-ascii?Q?JJQ2BLk31RUd2DOeBqMWtPSKgFEZ24nF/oHo7O/271bki7TOTVC5FJXCLuR7?=
 =?us-ascii?Q?pVapFkaFmsN3wso33IAzZW2Ye/0FNUdD0nGjIP919TA5kxSfsDNAQnez7AoD?=
 =?us-ascii?Q?yMt0f+nBLeh/Sia2m6pJbTXpIAtG9aZmbKiInKAjciu67wcounzrg3gJaunL?=
 =?us-ascii?Q?E1VS6dFz3Id93ksU8zwjmQdqsDps0l+oRIUSfxiRjR/JbaRO4w5kFdJepi07?=
 =?us-ascii?Q?AynOGrl3YsJbOVie78t6zTxS/YpzLU8g5F8DG5IzL3edSVIPe36ZXd+Hcn+e?=
 =?us-ascii?Q?6AKFKs1+WIo3HPJHnzRaWXJrWb/0glFoY1xbdq9wQATQt7120dE3wm66/Km/?=
 =?us-ascii?Q?IwnLvTNYz1pdk1IBwiBTfnDU7LkPF7F1Woy+r+0JeLX/J1czV10g5vvJyUEe?=
 =?us-ascii?Q?MB7K0SOb2SAxf1QtASjsvJg8rgu9NWkoPiYXcq9kLAvoEqhSjc5tdcZKysf7?=
 =?us-ascii?Q?teAo6NPdYxn0bjj3Js1ivrfZdPnLMgOL4EfYBjnwjAI+ooU4/rDR6YVBPYxA?=
 =?us-ascii?Q?S1xH+5cU9kuDVs35xBUWFdM4qx3pUWHK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zz7bH/V3DsL1uWjEsQjWu+TTjcR4j5OR69QxD/aK302wQTF6YpE1Vo86EQEo?=
 =?us-ascii?Q?/urOwvfISzhd9GQu69bFphQ9a9LGIC7izA89mTNB1I+JHmEXR7VP93ba5gmX?=
 =?us-ascii?Q?leN57q3Os6+NDoB73NYfSxcjD9N5K3Tuq6NZyVOH9SypANHik0ph+jqKZKOL?=
 =?us-ascii?Q?mA+lglHslrcj0pS5sFrBAkAUJXQlaqFApYaAZ0BY+zSBAMhI9yxTYcxyAzSo?=
 =?us-ascii?Q?gmQHHHMF6g2DOWboX3AKlug021VOe0CDJ5H85tm3990EbnkiHuis0fpAwNPl?=
 =?us-ascii?Q?WEB6FJiy9YcSW9Em6UkGMmKPyQiuWno+8WD8RPa8Zr5FHjZwaq70MV+mGgE4?=
 =?us-ascii?Q?lBRmAmi5IN+UnzkjgC+2aUY5kRRmfC0HrlIBID3jVx3nmUEWJsl0gl8f6zVb?=
 =?us-ascii?Q?dH5dgiTu9Gza3IlBkPOxi3D9yIcB/hE16urDWSNYIdUbMvOy0R2R1KHlWUD9?=
 =?us-ascii?Q?Zy80jCFl4dZi0Ub85Aniz3irtRrOli1uCF9xyKsGDcb5AUAA9wUm4OliNjtm?=
 =?us-ascii?Q?I49YcV0jBPGpJU0FM2HVGHTmiMkOC3HcRd/e1H6RbMT/nwtV0E4L5p10CZOT?=
 =?us-ascii?Q?Vn9UvNiu/+zOsMU/GrEM43na0fDEoCfLhPWUHbYjoyyOFnetyN01SP6EGFe6?=
 =?us-ascii?Q?TlOo9CrgvshSz98ulGVeGEE8xcNNn2l9dP4waGel22DDbx8fvYPSZD3FsYxK?=
 =?us-ascii?Q?QNK3MnAshD/xytxUv0Ou3KvCCKVNDxHuBj65t4OqK5fWeP2c0TQWJALf2Dv3?=
 =?us-ascii?Q?ZoyboiNR961SN6eNQJOwvOf3VWWDfl7bcNFKirW9LZeWywv8FDg4eUHzYupq?=
 =?us-ascii?Q?T39q1QKtIk48LkT21K5XMg8dm5+TA2fahnOnw8K7OOMejmtJSKd7kQMw/4PN?=
 =?us-ascii?Q?zjyAjk5PoR7aIyFWEcsb8ontQ7hoqJ6BYqD9PsuxPvZCqZ3wqslcB0WTV5rM?=
 =?us-ascii?Q?IP6xaTxQQFaf/4Vnz6mVITp08PgADbollTstPXXcFnntTYo34DmTnLrZLFfo?=
 =?us-ascii?Q?IGt8Ex9j/4f1Pc8tCPlwIrWGWajH4a51HLoIu5axgBMoAgo7xUQA0LV3saen?=
 =?us-ascii?Q?GuROK2uSFT51/BCRQSoDEcGKh3DOrUu3Fnx7iz/ZHYCpF84H9hJ1Iv866x9C?=
 =?us-ascii?Q?jP+2oaEdFSEoTts9qFZJrGiYDFAcX3Z93fC1jjgbvyOCehiHfap+0zg4MlFV?=
 =?us-ascii?Q?M6Fpf+qtYBkE3eqte6ULVoKNIUxWIegG5Y2a2+EYyibPWfCFREU7sTWLw6hV?=
 =?us-ascii?Q?sF218RzEjdRah/Y4cumz1YAGaz8r6d0WffxCuGKsqaddGp62VmJS6QEfHhSV?=
 =?us-ascii?Q?AP3gxfe29AostE8XmVD99XJOE/IsVG7ysRaO6NF1ZsfZVKs/bG3pOY3EiHb7?=
 =?us-ascii?Q?3wkxA0VaL2bph7gzYwi8m9ZeCGGf8DJmBTfDfdbykPDKaLExAFHALpQD830P?=
 =?us-ascii?Q?dOCW2gZmrQUfPNS2HG9e7EaSZOMit8vehO+usdZZewWrBTWcju5vMhr05AS3?=
 =?us-ascii?Q?pmltBE7hvuKvP1BqS05guPtLNFqWSMzP8mcXtb0b1qWLwbKVTCdQ2JTw0W5b?=
 =?us-ascii?Q?y1t9Otd1RKisqXL1G2o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87446110-302d-4adc-cfd7-08de1bdac3ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:45:53.8325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImNAg/LAsEKkkUZuc1DLV/qs7bGoOB8SHx0kQIANku9fB1R8GviCgHkITtvCXozZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=jgg@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 11:43:07AM -0800, Nicolin Chen wrote:
> > Right, but qemu has no way to duplicate that behavior unless it walks
> > the full s1 and s2 page tables, which we have said it isn't going to
> > do.
> 
> I think it could.
> 
> The stage-1 page table is in the guest RAM. And vSMMU has already
> implemented the logic to walk through a guest page table. What KVM
> has already been doing today is to ask vSMMU to translate that.

No, we can't. The existing vsmmu code could do it because it mediated
the invalidation path. As soon as you have something like vcmdq the
hypervisor cannot walk the page tables.

> > So it should probably just ignore this check and assume the IOVA is
> > set properly, exactly the same as if it was HW injected using the RMR.
> 
> Hmm, I am not sure about that, especially considering our plan to
> support the true 2-stage mapping: gIOVA->vITS->pITS :-/

In true mode the HW path will work perfectly and the SW path will
remain deficient in not checking for invalid configuration

I don't see another sensible choice.

Jason

