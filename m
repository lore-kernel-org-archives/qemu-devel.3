Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B66C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 09:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl3tC-0008OF-Ch; Fri, 15 Mar 2024 05:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rl3t9-0008ME-2t
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:30:07 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rl3t7-0003FQ-CL
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710495005; x=1742031005;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W568H3pNQE2kH3MgvpmnutiuuueR3BTlwMUZKgsnUKE=;
 b=daLKZH6DzKlXgblQeqhPWC2jz7knEk1KUEIbP2U02SKWqeLGLozcKl45
 kW1qNB/mlX6j9rWxCQ/QKP8qqDSbkCqScLgbEuuOJ3wYKPkGirt8wyTFZ
 UyA9HcBtnXnH40NP8ZodbMldPA/HmFYsJPrGJcJBdupEKF/I3mpsZOiC4
 UwgXxp+ofTb931Nk1zr/Gdr3IJ8jrVDkauf8H4XIj3YkRYmkexlDPzPry
 v110spa8TGpKL3yfROzIFdrwtGrZr7nMQKx5kxzbtC8XyRtu+p1tpTlg2
 AL2p7Gs8+32rE3oynzxFpjg09gaJwcSdHUHtMkRcaKFYOqZK+bv3SfgBz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="8291863"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="8291863"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 02:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; d="scan'208";a="43630494"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Mar 2024 02:30:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 02:30:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 02:30:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 02:30:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 02:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jELODqcZKUL0LhujMoSIj1qgQwVzr8kGjVFhbluXTbaXnSn8QgBKcTbUK/bqjEQNRGewLrGtNR6ng/DoYWnQdVEUNAac3Fk4Ipjjukg9hEcJHwhLBnkDiNzJB5iuFwmCfMa2SkN3+mCHMCscqaYkKTzom/1oeDTUnRpH97VzdMW0aYe4KBSJ9xn4h/rojE1TzP2O3boKjfVsD6XkTqwBxkGJ6nGvgzkb4uuHkyfUrmBU5iqoAdX9WGaZ5NfDQv6oQaQ85ED8SewMQ9Vffo0s8iu0UYYCIYZYJiosYwxUG7/fTbqAdSqyCFH2UWlcjThEYYaV4A0o91OLvLz+fzdzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THTiolLslZIGW5UTQZuDJC0ZjTrSUWqPhUIynUW8CMA=;
 b=hRqPBnrlaKbUMQTexZrBdUmTVlyWhwesn6AS51Z1qfTgWD8+BZsXQKnTUZ1a72tLZF1WAIc90v0Bhj8nAUIy/cvMWPV51abX2QoTBaeVpuH+G8y7A9x4ErgtQFpTt2ejfJxBDuWjpWsI9Yw2qZsJe+5JIsOBJ35Z3WXvUiK38TpyEY4xiEbALW6hdFZA1rZc1zuIF8bmmd+nE11yOqqdJz81vzEOsX6usvaON9o2EaXVAD9Bx8OjpaULAP34IA1Fhd61XCbOvR7H3h+mLV7Gy4RRd/ppZw6suxZyyZlFi65bHIocQsYjC8PgO1POMDLT1bnRwr359uU3BgDBoXzlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 09:29:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 09:29:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Zhao1" <zhao1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH 2/2] qom/object_interfaces: Remove local_err in
 user_creatable_add_type
Thread-Topic: [PATCH 2/2] qom/object_interfaces: Remove local_err in
 user_creatable_add_type
Thread-Index: AQHaasDzEVwy/VV2I0+ViYmzhuirxrE4kKaAgAAQFcA=
Date: Fri, 15 Mar 2024 09:29:58 +0000
Message-ID: <SJ0PR11MB674424E953BC3CC84889544692282@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240229033739.1123076-1-zhenzhong.duan@intel.com>
 <20240229033739.1123076-3-zhenzhong.duan@intel.com>
 <ZfQHNxkzem2/cZbT@intel.com>
In-Reply-To: <ZfQHNxkzem2/cZbT@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7255:EE_
x-ms-office365-filtering-correlation-id: 7fa6408b-cd69-41d2-ee07-08dc44d27b95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVEnX7AaojTkHz+hAG3NhTKHDOMmRPKesiW3JS2uqQ3cGRvZh+ic7bKNwz82XBW7EtQIp7YDhleAwD5FIjxpQYkq1Co17HZyL11FZ8Pb40fLxsAv8QX/wep+dbMmRRzQNNr/LiU4gukjmh0D77i/PiW1vApoMEUo028rNfya4QM7oCnWlPkKbvXcKPyrZ2BNAZk68j/p99c6HH2r9m0w7IrqwCMY4cYrf4vHdsCtiJ2LyCeUZe3u4k2zszzs7/FnXcps5NbSSjGlN2t3o7jQFmhM+3+9s8dAc3Iv0FAj+P45MfqVD3rKEkaDS+4js3SSinbEZ+rKSAYvAzoCl9RoKo/1MRhdk7kfqBe7PhGXkcYSX0vd65gh5xGEN4WJamUquP4GsHs8LCpZrVAbYLynOz9+PGCwA0uBKSkNXn4U8wzVpCMlJkWFvjAJPcCIYJ17Vf3+GeM3oMQau6Ie7ew/zoVREnO1+ha+WaViWgZn4uwxkfreXF2b6AMMcEDfqc5q6O+gn1G/uK1ObDTl4QSDDxJOjtS63FBPHzTCCM0pwShGnwYv40AsNXBuagcoRAa24ZRU3TH9cjoX8WiuGu+1PcBNZWh4HfMQW20x9cHk29/RwCrFOOFvbtUraRkjKWRg7v4crEH4elXLuScUhJwoOp4FOICRsqYcd36/FylqviABQGw2pxghi61khCUJC/Ve/Byqdnb9+Z3jRNmnD8vbf7s9ut86A6qP0jcW6p+CD6U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CsRjJ888eaOfY2/vfoy5i6MqAvmnewDGOs2l9lwJWqQqbTXmevPdgOX+xmSU?=
 =?us-ascii?Q?7r2QmXtd1v5ipxSX3OYKYP1/eyIOpXLSQ18vi02fkQ/g3wL6ECZRbFpND1y3?=
 =?us-ascii?Q?sRMVI4aFIj6Kc6JeocXgVAYyduwgH/aWVIOpWoYNGFsyPDTQ3+4XNLZ077Nh?=
 =?us-ascii?Q?QqCDjOnA8WQtsJxFoUYXYLI+/a9sBvkmHSSo4u+iwqvHeXqc137Ef4g6HeCZ?=
 =?us-ascii?Q?+fo4dzEDZDWqqiXZhqn5rMLm2o61ToM4lexRa3BZWnIU145Y0XFEWVQDcOpb?=
 =?us-ascii?Q?0ZZnqz6cSDdQugzOIkv1lFACStQPlMM/XfsJV4PzvrhICgDoHuuoCNqd4pfC?=
 =?us-ascii?Q?YxNiIIpN3zBkavdM1t+wuleQ24s3aJu/YE79KbjCGPz3kH8epnF/wNcKxJtH?=
 =?us-ascii?Q?110NjScRlFl5wm9Ln1wVAHxd3yrEcezbEXwxeYKVqx4/5U8CXUDq/il6nTFF?=
 =?us-ascii?Q?vBo2GiC5kDXQY1qgHBDdIvWffKpmPHPHevGPRse4hrrgFKr4VuhjHy8o5Bv6?=
 =?us-ascii?Q?XO0kj1k4xsmZ/2KKBK3yjsf+tpI7OkjrxN7JcobpiGNAYZII70szcdn0VoP4?=
 =?us-ascii?Q?soTEOd6NQQVFB5btu0l1LRrd45Hm42AXFnjNA5dUTPP+tKMS6t/xoUH5r9tY?=
 =?us-ascii?Q?vYWevtl2c9SkydDuwcmNpWx21ifvfg6uizkxqyVnvW3go+Y/IOuBf84LOJ3r?=
 =?us-ascii?Q?LKCMpKCdIfhU2jyOBjKkay/QkYk6eQxz0aVP/dVv8+mXpf1YnmmuXXGdizps?=
 =?us-ascii?Q?McvTrArsx8wx68ds6IaI4jeyoizJVV2NQWI+rXqQiljhFuZhCnITNeChgCRV?=
 =?us-ascii?Q?MBTinb2D2d4PxA7niFEcZhljRpXNkX2Rq2tkaAAl3qcWwYlyWiB8A7J7ddPg?=
 =?us-ascii?Q?ZZpuUErkRp9RcCxHiuM9aGdl501e/blDVtp2K7kdmJMM1R6uwf/Ly/cZv4pz?=
 =?us-ascii?Q?JGcTfwa9pkxRMjl/5MMHlhXWHvVtcevavyXoz0spUHLYbacv5aLXXi7Jl/wp?=
 =?us-ascii?Q?ZRUm5MesM4Fiqaom8O6DJ5EbxG5gsEFQUBcehe1CAnQKfr5jfULgV/JETbfL?=
 =?us-ascii?Q?UVp75KlcXqn3P7Fj/6B200RIHHj3IuSvt7gZkjpzE4NtEDTiWYIkXUKru6gw?=
 =?us-ascii?Q?X7Upkp9bgQgc1aAlh3lM6WxB777z4L12MI4TF1Xls25ZOTl193XBvQaQv6kj?=
 =?us-ascii?Q?oC3SP0d7d7TT7481Tz6sShVAsbWpYjx2qf/eqnJt/BfLBldS8jBQ33cI0uzN?=
 =?us-ascii?Q?19PLc5VE1wzXAiuolXDoOsZeBXpRpZDCgV399osVCMLaTE9XSkRgRv+WKUL0?=
 =?us-ascii?Q?twldwbCgMSzeEMqmClh1muxMqEP9qXVWvTRmE5axLB3SsBM7lXV3pzLeHc2G?=
 =?us-ascii?Q?jfUlmJsvrIGCCer8QpDSfJefBkBnNpHnFksvMNGi/kIgfiFRUwI+G0rxpqqM?=
 =?us-ascii?Q?Msq73gGBH1qpIbbS7go2nr+Z8f0bOGENOBFlh8qs8oppPFkdOnSu2BUh9oKf?=
 =?us-ascii?Q?UJ77wpuK89V3qyMTXYoUJrRlHWhgkAwOfN547zKdeTzuW6M08e4F/m8lhb2o?=
 =?us-ascii?Q?1aK4kgA+mNs6WdTkvOQ5aaDiuolHkrwgMpe7TUv3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa6408b-cd69-41d2-ee07-08dc44d27b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 09:29:58.6579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13Iv/pH0tNS5yy+xyKSFIrlbBCgc4ooOddnHykIwaJ26j6gubmMJ22zbBlgD84j3hpeQfGw+uKvJOfBm2OJFZpTHoXyrG8UfZCPrwM4wfEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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
>Subject: Re: [PATCH 2/2] qom/object_interfaces: Remove local_err in
>user_creatable_add_type
>
>On Thu, Feb 29, 2024 at 11:37:39AM +0800, Zhenzhong Duan wrote:
>> Date: Thu, 29 Feb 2024 11:37:39 +0800
>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Subject: [PATCH 2/2] qom/object_interfaces: Remove local_err in
>>  user_creatable_add_type
>> X-Mailer: git-send-email 2.34.1
>>
>> In user_creatable_add_type, there is mixed usage of ERRP_GUARD and
>> local_err. This makes error_abort not taking effect in those callee
>> functions with local_err passed.
>>
>> Now that we already has ERRP_GUARD, remove local_err and use *errp
>> instead.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  qom/object_interfaces.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> index 255a7bf659..165cd433e7 100644
>> --- a/qom/object_interfaces.c
>> +++ b/qom/object_interfaces.c
>> @@ -81,7 +81,6 @@ Object *user_creatable_add_type(const char *type,
>const char *id,
>>      ERRP_GUARD();
>>      Object *obj;
>>      ObjectClass *klass;
>> -    Error *local_err =3D NULL;
>>
>>      if (id !=3D NULL && !id_wellformed(id)) {
>>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an
>identifier");
>> @@ -109,20 +108,20 @@ Object *user_creatable_add_type(const char
>*type, const char *id,
>>
>>      assert(qdict);
>>      obj =3D object_new(type);
>> -    object_set_properties_from_qdict(obj, qdict, v, &local_err);
>> -    if (local_err) {
>> +    object_set_properties_from_qdict(obj, qdict, v, errp);
>
>It's better to make object_set_properties_from_qdict someting (e.g.,
>boolean). Maybe an extra cleanup?

OK, will do.

>
>> +    if (*errp) {
>>          goto out;
>>      }
>>
>>      if (id !=3D NULL) {
>>          object_property_try_add_child(object_get_objects_root(),
>> -                                      id, obj, &local_err);
>> -        if (local_err) {
>> +                                      id, obj, errp);
>> +        if (*errp) {
>>              goto out;
>>          }
>>      }
>
>Here we could check whether the returned ObjectProperty* is NULL instaed
>of dereferencing errp.

Indeed, that's better, will do.

Thanks
Zhenzhong

