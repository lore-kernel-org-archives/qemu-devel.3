Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB16DC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWiH-0003Bt-Qn; Wed, 28 Feb 2024 22:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfWiF-0003Bc-Uh; Wed, 28 Feb 2024 22:04:00 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfWiE-0007jx-7D; Wed, 28 Feb 2024 22:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709175838; x=1740711838;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LwVxtyBYd/Thaq3aM5ADuJft62xbTSsfuDBhW2iwqXw=;
 b=L8VYbifM1+ugHTwcvjSeMO/4Vae2jeI5vLY8hD9fqY1t9bTJegG6LUQc
 imURu6PfNwtkUaI4aQSYorp3BcMGxEvwNqDJpdKEk8Qv8DkuzNGMpHRak
 Flh79QLuukqlC7k5k2P8/mX5qHZWrylJdcZrfBEfwnS5AS272nr9Hao3M
 JTR5x8J/qg4dOp945Zrfx+Gx1IIQUotMDvrIaAnv+oirD73a+yviVFiLD
 MGh2jqs5Z17KJTctpYdPR3sSVAbkGX7jiUG7amyb9pXvVMbIco+b13vZp
 eNt3dnpTpQ5Cl/OHhLXcVVGAPCsUrIx7omUNbkfkCE3tj7b6+LiOudKTc w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3786289"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3786289"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 19:03:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7782823"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Feb 2024 19:03:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 19:03:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 19:03:49 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 19:03:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pda9Wqg9cvlXH56YF/pbBP3PXRJK+GARHXw43BPPzRZAQH765yTlGJ0JpIvd3G/g0kY2dlimE2pZ7sTvOp6t2rTvXbUGyBnF0H97y+nAIBJsYWdzfR2qHQPye9LYwMB/HSy24UGHQHR7Qvvu/HaobLKrC+2C9ZZvYF9GUadrE9KmZbX1B55idkbCEdeSEuXwAP8SVjHQ7vJcHWobBYjUrCsdED84/n1ImYzyIIp7Ol4l8N4XIyHGAbVfRalnbDLwwEaYQxzvOdUCb1UgeIuog5aZv8TwYiryztieFVP4FpTw/k8WgEJhASoRGrToNbsaOxSO7wQy4W4Fe0/4pEtyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAooqfFkXOdmliO1FE/KImM3IEs/mlGdtHFe6GJY5jY=;
 b=aNIalUVamBGWKd4NWdWsM+RtBb/1/W88XJ3uXPDYuTQNq0GcdOeFf0eO3eJ4oXDzXjB5UoYCrV2QgNVT6v3z5Up0+wk7Q9bv5JUM8KIRmW9f2om3zOUODS44Kc6gS+9VgxoVgJEc1YRxTcZhRUFhDUx+jQa7XqsJcPpTiTS4m6vH+euSuk+0Xocfn449VO6AWelPQkPOC0pC9QyNOF/qd13ZpkmHKEFHuM5gla7FNTvUZsuZ4nUIal/2Qn0gNvKh68ohuCJTgWx4H0adAoRHtjTyjHUvqE8FCgdMD6V3R5Xz6yrMvwRKjHw7d24dnxfDnvyA9lII0OFW0T4DYYPe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Thu, 29 Feb
 2024 03:03:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Thu, 29 Feb 2024
 03:03:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Michael Tokarev
 <mjt@tls.msk.ru>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "Liu, Zhao1"
 <zhao1.liu@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>
Subject: RE: [PATCH 02/16] backends/iommufd: Fix missing ERRP_GUARD() for
 error_prepend()
Thread-Topic: [PATCH 02/16] backends/iommufd: Fix missing ERRP_GUARD() for
 error_prepend()
Thread-Index: AQHaamKL8RCDLJuu6EKz+iHfraNGPrEgon0w
Date: Thu, 29 Feb 2024 03:03:32 +0000
Message-ID: <SJ0PR11MB67440DE3498CC1916150E1A5925F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-3-zhao1.liu@linux.intel.com>
In-Reply-To: <20240228163723.1775791-3-zhao1.liu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6145:EE_
x-ms-office365-filtering-correlation-id: fda17b9b-9958-4534-0e71-08dc38d30384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jp0zRGIisM8v4iFvgGlhDSICTqB/3dt+fSQ+GZsMXPyS7QZiFoILPsvVJVRvwBUE/IHAa73Qn6I9dQ2E5Aqajs1cRoCheeMOGxobI0MF8BG0Tl+dc/7lUwSJzzQyvOz36+6R4IKya3oon+71tIEZFAgYmkHXUgF3AOYqpQMzxAeLiokJMgaY4M90BdjOhrKBSMYcWMh6RPzvwa3fFW1WxeN/njLDzJoXVv8tLrz5Z45OzGwjcZAZIXxav3UF4GY1rxlr9XPFjsTUYKvKS85pcxICKD/yIl0llB4yvNwyaxmoKDMvgCMs7adrKxBUXwK2XzuAdmztuj936U0+nR7Lj87ry3vE3efOD/Tx7SM3WUYvw/g2U8W8oFIF6/kaHj+A+9QS7/1biDM8f5HRR80v1ZXGatsToiXOfQXlEG3iR5gjjU9ZgOTuF2URklCf9BX5CGI8Xa+Jk3gkZN2ouv+MrR0mGK2e7Z6upDCu8SDgucobTMGwJNGeIZY6oY2g5CHv1e88fv73jkDmgrqus6vRTLT2PD4RzbE0nC04R2Ptbr6bKXsgCzRV5tSPFP7+vJnydIXpb7A/wfyWdChTR+5wqewGO4SFNLtelRHi6CXn1QhEXWpcep1Z+m1cmdACkZ1DCPu8Crr5VkzSiJ3feutnlNZHaV3FnS+HhncMtu3BoOQhJK79YN9fQnW+y3/aYY8nhPCjaSGpTSkoRahcX401uYCqbjHHWi00h81/AMjHP1k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0ImwrKYUJ6DxJR6LrOzITKYCUulFLJKUjov9+91cv2vJVfI9azn/pURt/E?=
 =?iso-8859-1?Q?eDmyn+PbZKFZymCWBpFF0fzlpvVVbHNzVX8gMup9q4hZm0Ze9ch1HtAZqO?=
 =?iso-8859-1?Q?8inPXQRm2hCxRK76SaOUzMTxHnpDQpYgu7YSoGxjRkOqILaOHejFJzd7AR?=
 =?iso-8859-1?Q?hiwFAOyLsrs2zKjM+qbecoSgFt3k1w3w5QkcLxw/FuHj6jlizeXQdfrvdy?=
 =?iso-8859-1?Q?vRsfsAoNxcJCu/ZGBytO2la+fa9i3gt1f75YCdeh+efqjAsR7tyzDi1rd5?=
 =?iso-8859-1?Q?8MjBQAMGtvvFlPRlykd33/o9ldRJzl1T2HG/vxuqQ9fyZZNIc7Q7GcTvQG?=
 =?iso-8859-1?Q?5RSzeAPeDZSAm8QOJd8GyCec6rwHZQWt/fQVVnmu+hWB4QXaIBDfV6MrUZ?=
 =?iso-8859-1?Q?Iejm6kbns2O0yYKdToiqIThnONWKAEuz1UJ2iu40AkGoQpd8HCW3xxpXcq?=
 =?iso-8859-1?Q?8/9XnCzG7yJUfyt+U5UJlx8Feq5/tPbv/+KPbjJdyqqiiXiICOUcCEITAC?=
 =?iso-8859-1?Q?6/u/wKZ+UXN6dptkdcDX95697pqeLUqY+zLlfeTOK6x3EXBpJLHJbkmIvH?=
 =?iso-8859-1?Q?YY8hiLYuaSUnAHsJAMcWq5NA09pCnhEr9IXhnaFW5+aHQHmeUIk0gKMPEf?=
 =?iso-8859-1?Q?1yWKXFI3uCr3RU+hYHeB9n2N5lkaP9Ygd6ZsGAI45oom1r88O41n5bn2+x?=
 =?iso-8859-1?Q?y15rBMD4HA8iI/eW5vKnI+4SCCqbDBfLHsE197FxrE5S+6nPLFGhijmAJ8?=
 =?iso-8859-1?Q?UreVGKAyowHpriVXLUVftkaZc+WlY4vKbJoNIPP3c3lZGpgufPFlHTiMkL?=
 =?iso-8859-1?Q?PWDzz6D/kIywRELemPvL7ta2X+ANNWGh79YKkrLZwbLMQwmtOTwAu8EA6g?=
 =?iso-8859-1?Q?70GxjN0y9ashNhGajqKQlSRJufC8ccPTQtuBvwN8Y5zNpeCfyrjUtCnLoQ?=
 =?iso-8859-1?Q?RIVJOSkUUmVztleyglGbNwpWK/Le/89RS+XNyaYk2GpGDHECB52Ljw2lFi?=
 =?iso-8859-1?Q?bPGv0iOxxzkHTEfOgxvrsR2hMC1fhFt4BrMuxNmSeKp9KUCxT8eulvR2Qd?=
 =?iso-8859-1?Q?TJ1VtPbEP8sYQZYEJP9Ew84IRrS2g2gjYQJgGy1RvWo7XI8V3DBmcoB7EB?=
 =?iso-8859-1?Q?v9AL2qhig0FEuBXU2Klx8adDwvNo5C71H4zKlPkNwAVS8hBJCdxKrcg3do?=
 =?iso-8859-1?Q?5mvfBFioQAII5Y6q1+dvfZtc6CNJ8wn72/4awiGSsfFDEbGhU/gajYjzMS?=
 =?iso-8859-1?Q?39bVuhVgMbvwX0bZmJtu+1vu/wQI0oJp2yCppRpb1SadG/C5NruhBHCoC7?=
 =?iso-8859-1?Q?AMx4Ve1LkhXhGnAn6FA9IXZO5J3eH6gvy8q/RtVQfLTtXOM16fPEDOLNEy?=
 =?iso-8859-1?Q?Y0Nm2xWSRCih95Ki2XG0dLd6CDI6I3UFZEeycG96x8dRsMxPLiSCoQqKr+?=
 =?iso-8859-1?Q?xkp2Yltk4+rzMTuzIt3952pIA2HrtfujHjPJic8+X0rERiKUrJQpEcdYsi?=
 =?iso-8859-1?Q?FQDpxGP0aW+gMKR0TnuqESRpwVMOQzkIjDw5VPVplTjbQD+cxvPgImYlmm?=
 =?iso-8859-1?Q?0YLvZ4x5YgXZgcTwtaDxOjLOC7ohX2oNU/PnADl5dnCQ89yCTm585WPq2M?=
 =?iso-8859-1?Q?oYhg6hgwZjWecd3GTHQZE/MngM9Dr51Uff?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda17b9b-9958-4534-0e71-08dc38d30384
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 03:03:32.7648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lt6el1HSmtothVOPnnKKrbom9+Bz5hShH4E/IQg5NxSkrkXcdGF+wr9pyjjivwTg/1aEXxOz+oXRxO4kV6KLWxAL8ocIUUg+OLaSssj4rBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
>From: Zhao Liu <zhao1.liu@linux.intel.com>
>Subject: [PATCH 02/16] backends/iommufd: Fix missing ERRP_GUARD() for
>error_prepend()
>
>From: Zhao Liu <zhao1.liu@intel.com>
>
>As the comment in qapi/error, passing @errp to error_prepend() requires
>ERRP_GUARD():
>
>* =3D Why, when and how to use ERRP_GUARD() =3D
>*
>* Without ERRP_GUARD(), use of the @errp parameter is restricted:
>...
>* - It should not be passed to error_prepend(), error_vprepend() or
>*   error_append_hint(), because that doesn't work with &error_fatal.
>* ERRP_GUARD() lifts these restrictions.
>*
>* To use ERRP_GUARD(), add it right at the beginning of the function.
>* @errp can then be used without worrying about the argument being
>* NULL or &error_fatal.
>
>ERRP_GUARD() could avoid the case when @errp is the pointer of
>error_fatal, the user can't see this additional information, because
>exit() happens in error_setg earlier than information is added [1].
>
>The iommufd_backend_set_fd() passes @errp to error_prepend(), to avoid
>the above issue, add missing ERRP_GUARD() at the beginning of this
>function.
>
>[1]: Issue description in the commit message of commit ae7c80a7bd73
>     ("error: New macro ERRP_GUARD()").
>
>Cc: Yi Liu <yi.l.liu@intel.com>
>Cc: Eric Auger <eric.auger@redhat.com>
>Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> backends/iommufd.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 1ef683c7b080..62a79fa6b049 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -43,6 +43,7 @@ static void iommufd_backend_finalize(Object *obj)
>
> static void iommufd_backend_set_fd(Object *obj, const char *str, Error
>**errp)
> {
>+    ERRP_GUARD();
>     IOMMUFDBackend *be =3D IOMMUFD_BACKEND(obj);
>     int fd =3D -1;
>
>--
>2.34.1


