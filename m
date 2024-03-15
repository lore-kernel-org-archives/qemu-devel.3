Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44155C54E69
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 09:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl3rM-0007U4-Ca; Fri, 15 Mar 2024 05:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rl3rH-0007TQ-Hn
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:28:11 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rl3rF-00030X-3Q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710494889; x=1742030889;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UEBQ3DRLJ8YzOIqu09tLcfJUo6i30Aw3AXWSmtnky30=;
 b=fn9k2JT7NRjtAibD9iJ3/0YsgFCa6XKVyq5QBNvFeHZi7G5DpfXs3nhV
 eVU1DvS3FUvknm/BLVz7/UfZoshzfczryiDG2cMeEV8Lc9FWJzT9DjZcB
 tGMwnyK9Pb8SWKjqUEXtqXIqWGS7y169hXE5CXCLvHYnpzDVXxQBPlm5r
 4XVM3pwZRIq3+rZ4E/ZbyYGsQQMrapT8Wjh+h5CFHaW4/qPHB6NLXfsdl
 /0gaSx7MeivH9gJO3ieAhOzI3ZEPFAT9o8YcH7z25QJYS8jY91rSOLkxt
 8iWZ0JkcI2B85Lb76fa3uAcmVFYpBPR52oRRyP0CW4+4jIOlddYko+j06 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="30798028"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; d="scan'208";a="30798028"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 02:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; d="scan'208";a="12503486"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Mar 2024 02:28:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 02:28:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 02:28:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 02:28:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 02:28:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgXgQ0JB5K/eJQfX641rbJBG2H+IAFQEIf1tbLuv+tT73RUBSpKLtfOrp62+YFXmKEBfOBH5CHh+v/CnXIKzac2eyDVKnYezo5UzsNZJ71T7W9d4SZ1+ceQMyZV6dc+Nn+OW65kd8aoqXGF4gplXT9XRnXFgmAcziGbELm7N75/KaTpm/44D0rNf6e/M4J17drzOgysZksYETpi+AJ8I2KMABIKkhqalWpmVVdLOFatzaeoanEETuyP1jDGMXQO831oG5lDZjn8/TKUtMfMI4jI+MXQeRsbXp7tjxThkqYrHp+R/THyiTVG2WZGl92HFDMye31PeP60bRyYWW9ynuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTnl5qmRdKIH3GkEw/HbsSI8jyAWPt8XlCqugWn13rg=;
 b=eDMt/cF397RutlKBbC8nQjpP7nVQ4xh1Xj5nIOjU52CMSxoDNIAxM9i/WXDR02T/UJdP6T5/sZGi7vq3z3L5qWutUBdRijELbi6RYg8uqLmOr6Jg23ahyjzrO889wBULoQQAErxzxls43vNwNYRwOYs3BcdoVzAMyQHKBfpXfm1DxNLn2Vv/wCHczFNdADB8hOqskjTFHzRy5e4kuuUtYWZ+fRodQkAl/lwMFFPmElIaK1VaWm/66M+L7Ni7Zt4mucg3x+5LfRpGMgNSGy81h9iIgB9nmWoowVykijbrgdk8RW5PSu70JR3pyH2GG1/hgVqkEwHQ98eSqOX3to69zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 09:27:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 09:27:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Zhao1" <zhao1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH 1/2] qom/object_interfaces: Remove unnecessary local_err
 check
Thread-Topic: [PATCH 1/2] qom/object_interfaces: Remove unnecessary local_err
 check
Thread-Index: AQHaasD3QoQO1ellvEOPph6TbbKS1rE4jauAgAASs4A=
Date: Fri, 15 Mar 2024 09:27:58 +0000
Message-ID: <SJ0PR11MB6744C24AC80AB7F15A12D6B092282@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240229033739.1123076-1-zhenzhong.duan@intel.com>
 <20240229033739.1123076-2-zhenzhong.duan@intel.com>
 <ZfQEt45kBG218Vs+@intel.com>
In-Reply-To: <ZfQEt45kBG218Vs+@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7255:EE_
x-ms-office365-filtering-correlation-id: 7a306fca-34c7-43c3-03d6-08dc44d233be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3n+mc84rqm/ZlqRDaq/piZQFg6aRjuKVW/trc3WG+87HEM+ZB1DsddkuyVFUVRWJztfv5+mm6O8UZoBU6mnrcO+o1TFP5r1l9sxDaKK5H7HeLBd6vbEXfOpGQhAkNDOnM7VUK2pVlI20vGi98xuwnVhYo6byEYR2ScT7mIkLDKb4VOhjiLaqQY3pfVSioPYdBRoNqW11u97U/wyT7ChucRuhqIN+OAi5LcpZ0DUnj9VQKIaHz9eKee1LSq8RhOWdvfr4CY2Tu2pQPq3EU0BOix1tO0iO6bndBJ1fjSK3fwlYn+Cv8B2IJGzK7kB4hpaDsCcbPxOy9fVWgkF2A5pRASwRctbLR3LbTbpfqX4PpIdij+hVQudK0tboC3Rh7R/T6FBCr/j62Zt/AYBAqZVGZTddDuk9hMqPsEKaT7mfDIAjUgzbNLSOpP+Bp9xh4ngyfFnRjJbgKGQC9Uzy7Nl14pYIwkZtq4dylAFEL3PYuN7j10bg52P7xJa1XKW2oBsScdzc55vVCzyZRnoek7pccy3kwJKfhUND4ZcM9CTvKPGYjgAhLyz8WwQno6tYir9v4wHyoYLsSydXDcwr2kehibOGSEkc8+jpZQPBvkuH7WKzCGOU7UvbZ+UOb/DIwn4DYMEEYDPMrIYZ/GFpFOrrXyz9VmbiBx+iN4immiErOKiI77JbvTmE57Gqi3MBfKyhCcltIMhExqnX+K3Vo04lojJhSrMmKXkBwRyJD7g04U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8JyKOLl1Ik6IKUd9TPpZ+hhyKTUaMCSlAMCBcIEKAIUr5JGqjgisT3vew+ue?=
 =?us-ascii?Q?HzaPoD6CMaQnX7xzMjL6zw46ptf3pX+t3UOm+4kuhqTR5dVRV3hMSkrTh/Lm?=
 =?us-ascii?Q?LroPuXvetTwUk/pG3VSPAD9kOexguLIrkwheL4dPTjVhTaHRp8iC47Jgx4TT?=
 =?us-ascii?Q?ybHHRvJylWZUWUbb5TmAYPKg0oplIhTCv1cHHgqk0Qkx1Eklbz3mPaRSNTey?=
 =?us-ascii?Q?HFRXBRK98BooZrmWP5uYYmyu2rWJtzDtHB9sDAfCKTfByAEGsJWbR3xv3T86?=
 =?us-ascii?Q?5pqmSlQN2GeniECDikOdNNt5dZNB5xrAMzB0RrPCahm1gJI5ocUH7ahSFqpe?=
 =?us-ascii?Q?j855YLjwkAXzUI8VrN8riZw9x20MZhMJoRY9mpQX/QsL9x5qsWhDEu9QKlZz?=
 =?us-ascii?Q?eTN16/wm5ySuzTkyZwSIoguOakA37/zXp0edganMxPPfOSor/2T01HhHSF5v?=
 =?us-ascii?Q?GKTuP/T8AUcLZoxFWYdIRKNxmE2eTea+ct6hCiZxq1LXyPI/kqfgrEUfDkU0?=
 =?us-ascii?Q?wVSKZfIz+PuFYdLQtXFPm4LoEZqwftsZyElx04Efywjxh2b+m2+U+RV9pxg4?=
 =?us-ascii?Q?PfjZ0CHFUspOpv7q7OK42eaZv+ntkte1/whHxcJYbh8omxOsgPej61d2LVfM?=
 =?us-ascii?Q?f/la18PSbr8zKjIjZK/CJf+LMav9wxUa3ziLTIobAxiype1e0h+yZ8/iqU4m?=
 =?us-ascii?Q?3Z+IG6Dld8EUjz3XVrwBN4b5aXX6xbDqxBNHi0MLHG3nZYbHIp0Ig/8ra4Mp?=
 =?us-ascii?Q?1Xpf1kAPwqXomAk3hb786pau5kPX4NeBhjEYtMb/SdmcfNx8WykwPgAQKXgt?=
 =?us-ascii?Q?K5Eo55enPfW94KwCcHWjq80eN+6rerYS8wRVvlmw0GQxkiXTFK/tNk/j4DT2?=
 =?us-ascii?Q?Qjhhwl2TV8PSdSAjEROBMRB/pEqISO6nbPRii0wBJYHFndh7ZNgA2qJFQdKy?=
 =?us-ascii?Q?hcUvRfZ7aGsFlkulMeCPZHP461hC4uvR9S6lWbzYKIPYsmxLKyX5rTV+sGND?=
 =?us-ascii?Q?7/raTcbxkWrll9w+baHotriTduHcWvIjWaSuRVMi7W80YkQ8wfnYGpFR+eIC?=
 =?us-ascii?Q?LE2DWt/4nsHGdxRUSxHu5sM8yEZbCT3DmiJCTCb+OdWPfIFHTVP6dtI1SDk1?=
 =?us-ascii?Q?7giiMnrI25CdGHU8vXwRdFo+xyqrqrtUTwn+1Whx1imfjfxnmbhpwDmieEzj?=
 =?us-ascii?Q?UKalUu28g4kp9/NycGhKTD4lcwl6f+6ny8uYzuWKnGcfm0pLVXhZvkw4DHf9?=
 =?us-ascii?Q?6xiGmKWb5LaTfeBB4nhr9FKHkIQnOb0ADJ8Ix2yFJMPA8Umu4jt+j+dspdQ6?=
 =?us-ascii?Q?2GkOoh81ZsV7RMLVM3vVwfCjr5Dn76uIcS/Js56P77dmP3fwmN1WuzDFbAoD?=
 =?us-ascii?Q?eZoshb5HexwVVvOzjMBZVc6dBZHJtt9s0ap2PFBnv9RBFDNo8uo2eTeuzarz?=
 =?us-ascii?Q?z2nKecCg278nZfIAD9WSSCjycPCOW0TUf6xjy+7Z+EjXV3nj0mH9cCrxyXR5?=
 =?us-ascii?Q?DESGDcNS3qpuP5L+wkbO5BPtup5Vi4omPNTL8eqkyZdhAghkSgOcVAZ39K8N?=
 =?us-ascii?Q?FYboJ59u/9aHcMhhdF2pdI/Fq4x4jihK+u+Nonot?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a306fca-34c7-43c3-03d6-08dc44d233be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 09:27:58.1617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZFcd1v/Jxjf99Q4xphbFXWmrVgQI2ric7urdtRDQF3p7jWgWGRUb6PlIr0cGmaaLbziDP32dnqn1Vu/7K2u8GEeMo4BhAQ7bsg3rpLdVbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



>-----Original Message-----
>From: Liu, Zhao1 <zhao1.liu@intel.com>
>Subject: Re: [PATCH 1/2] qom/object_interfaces: Remove unnecessary
>local_err check
>
>On Thu, Feb 29, 2024 at 11:37:38AM +0800, Zhenzhong Duan wrote:
>> Date: Thu, 29 Feb 2024 11:37:38 +0800
>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Subject: [PATCH 1/2] qom/object_interfaces: Remove unnecessary
>local_err
>>  check
>> X-Mailer: git-send-email 2.34.1
>>
>> In the error return path, local_err is always set, no need to check it.
>
>The original error handling code indicates "local_err is always set",
>and error_propagate() can handle the case that local_err is NULL.

Will do.

>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  qom/object_interfaces.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> index e0833c8bfe..255a7bf659 100644
>> --- a/qom/object_interfaces.c
>> +++ b/qom/object_interfaces.c
>> @@ -128,13 +128,11 @@ Object *user_creatable_add_type(const char
>*type, const char *id,
>>          }
>>          goto out;
>>      }
>> -out:
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        object_unref(obj);
>> -        return NULL;
>> -    }
>>      return obj;
>> +out:
>
>Maybe rename this to "err:"? Since now it's just used to handle error,
>and "goto err" seems more clear.

Good suggestion, will do.

Thanks
Zhenzhong

>
>> +    error_propagate(errp, local_err);
>> +    object_unref(obj);
>> +    return NULL;
>>  }
>>
>>  void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
>> --
>> 2.34.1
>>
>
>Otherwise,
>
>Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>


