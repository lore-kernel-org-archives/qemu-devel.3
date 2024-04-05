Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3DDCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 03:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsaXh-0005RK-DM; Thu, 04 Apr 2024 23:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsaXe-0005Qv-Ca
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 23:47:03 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsaXb-00035D-6Q
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 23:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712288819; x=1743824819;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DTsnlskmDJd2Y8pZ719KTixu1G+LaJPUHi4/ZF8b4V8=;
 b=kyvIivuRmGW8vxBEZFbnSvgNENytC103sAGoUvMk+qbDijJXz0nWU+8r
 /A4sbdjF4gxqMl2KVlo5yVeNyfy6m869I9Ar8mhMaxsCLAoPwjb6/6W8w
 +nhzRQkiFebuSqZtj+Wgxu819CNxcRfQueWK/eyhyfpFKfAW5juicPVUA
 OTQMzJnlE43PKrt3dHpOiVH8WS+TBvHNNp58w9VSzDqOOSFQn4sEwFvUv
 X9w5F+UVdWoG4visKW64z5EjfCINo2Cpgia/Xg0/REIwm+DEmZWIxOwju
 w43RUW+OgOF9L2cBjpIBUqhNYvToNSlb/imtKNdr8yNi7vRs4Dl/dqWuv A==;
X-CSE-ConnectionGUID: XPssAWsuQKy4IbhTJZtOog==
X-CSE-MsgGUID: OLnPPzn8Qguo1a8+ijqf7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7508433"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7508433"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 20:46:57 -0700
X-CSE-ConnectionGUID: ktAJD16MSX2IdgfjNDTx5w==
X-CSE-MsgGUID: qxilt1SiQamGBED+luDe9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; d="scan'208";a="18976563"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Apr 2024 20:46:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 20:46:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 20:46:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 20:46:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 20:46:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U21bUXAuLyDvryYLfoL4tLQ+gChZIrg4OudH2uK95ADY03PsplSY9CQvnaVI/5yBBbUhohgdTVlNj1QD+IiPRytW46DPFNZt2InmlXI5aU1+iDl0sj3SH71BbtCZDOaYF7vtU24r87qMHZDfrJkzorAV2IB8dyt8CNTGV0ArLoWrRhSPm9FCtYzZZbfVLDMXB9kQC+KNVHV7w7unME1sI77EVya0Znod5leJ6ITcL+6sMRhKr19Dwif/YmrETVF7eYpSi/e0+UL3lKm/inKOzY7oshkfaT2jBu3G9Eg2fJyxU3evjOU+Ntpktr5UrY0lzO8/XJ5dxEzfnKm9I6IJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mE91bK7XAdaGXyx/4TVCVh9hT7ck0gB7NnQcmjNWqj0=;
 b=Yd+5rD4QxbNaUpUflvPF6Nstq0QtRv06eKUjKGknynXi46+zrDsamkF8GBOia9mGCLRM5chJUo2ow/Ftn3WpFmsL9vXTJeWFBvgJ9j9FM9fjpW6w+Xc9uy50Y3z2dBpvXnym9s1e615zmXapBMPra/e9FdnK7RaQXTnFerVY9y8/axPuRXXdVgExP4Z88mN9SA1094vsIpaL9EUuMHf7p+kiwo5RyiJEDWqEi1YypqoEu0WgCFmjUNBXoqORiBj/fQx0kVDNpkAdUHOOMhc4vfGtR4meEp4sq5uA1ijUx3kufWh5gUTRevwxRpqUERG2KESPE32P2WE9ynC1WIM9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Fri, 5 Apr 2024 03:46:52 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 03:46:52 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Topic: [PATCH v2] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Index: AQHahwsYyrUJC7Z4qUW64CcM1lLIZbFZCEzA
Date: Fri, 5 Apr 2024 03:46:52 +0000
Message-ID: <DS0PR11MB63734EB5830B5CFDEA9117FFDC032@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240405034056.23933-1-wei.w.wang@intel.com>
In-Reply-To: <20240405034056.23933-1-wei.w.wang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SA0PR11MB4701:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twrMFQf9+vzaeyQjoHMt3LVZ/4SQX1rBx08ygRGtXdJMIzDn/oTbGkNbw+fYFmIAa4I/XHVAmDlSEAaRpYAnLFwMQW/kbYiworqOQAmiF5qF0BGNKKQXtSzctMcBLIxxZTkNuZR/6m6kw1y+RKrwoRYAl40zTzNynOE480VP6dL95gphhRQweiDgU6AwoGDKEeAMgM8cBFo8r4g9qamEjS6nCBvLQhk9nqw9VKxN6mrVP3WpRW8+M25wV1RoFajg4unKkKbG+uSuEXdu5aXiKS/TLZShPUwCxmQ/Y01vX/nUsZnZjN8UKvp9lbdGO3OtWjAqo7nbEhPIgqgNrUXJ6LlJVLLRZEe0bOpi60Rdu6PPzSc8LwJ9XB++WMktP1w3mSNqq2wL4Jvrio67tMbRmZE6JfvynQSYicluJmj56XqQKJ6Z9Ont4+GeD32mQ/DEyF0hymHyPGSLOCk4CQDd7eGIMpCACopHQDtzMGSwJCuVXjYabB0cdgTSS6H3Oa/LN6oHIIOiUlfXOw7/1SWFj/v6b+JW2n4ccCt/8k/ojq72rbvT1/tbRyYf+VnHXGByxl1B5M2xZkIDIlv3oWC4/KmGnESnI/+6NytN2MjvXH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T3C70/DXR1k9zsDqiHqkFSnl4W+BP90CK13kC/8Bw5xYnKSOdCycYlxSKeiH?=
 =?us-ascii?Q?7Yv/KvFVtYVnoipl7fECtzXealxCm5b1fopB+ga6IEt4Spyhy2tfitmAOOZK?=
 =?us-ascii?Q?dnlTp14ArwBOfN99Cpy0XJelQQcmWg74k6Sdbt+SfKzIrD/ahtOdraCitJtR?=
 =?us-ascii?Q?6jbibHUayqXCfTE5jBNj5SLhsfELnOVeprxEWQerpvAohruq9q6szuX5SoYU?=
 =?us-ascii?Q?nbQ8cojulQ69CktiK4nc7o3l72Ldg5MXra+x+ZLWtg5wHi0XXl1EjX1jgAQu?=
 =?us-ascii?Q?//8cv4dsyEpwxCcvBeWojxiliQ3scUxzXD3wD8b9H2bLoPFTIoukc1mutNDx?=
 =?us-ascii?Q?SN3Xa8vGZqA/AMNetpqYiy53Unn3I9OjHiahml70Isa9TRrsU4q1lS+fRhIX?=
 =?us-ascii?Q?eigJYouNyB4m9br2CkBR7KlQj6VJYyH/WkVq7ZCngCyZd3KaZSuAixpMAj69?=
 =?us-ascii?Q?keEeEbTJ+5r/wJUXN+gv9ZqjOLN8YZOCo5ub/tpkLWWul1n2YafdQaIjWP/R?=
 =?us-ascii?Q?0ADgTnUqQm33EiS+WDoZJM3zmGSC6N6nEY5VBzRLVHql8+jvROjopp98WMRk?=
 =?us-ascii?Q?OeQHogk5D79AdfbIJ84N9DkQc5Lwrtw0sP3sCRwB0Iw8c0Gqb0jVEopFcTG7?=
 =?us-ascii?Q?u2vGEYzOZT7IcXqlMDSXpH+zQZa5X1xKgTzXFnn99hvzgoWALffAyAEOHv+8?=
 =?us-ascii?Q?z34cbv2EkbzRW4aDuHpQTjXKtOmQv8mK+fKRojyiqiSM1dUUTD2Wu41VWfh9?=
 =?us-ascii?Q?TDFtAtWAlc9lOE89xtF1I9BMKO7RUROs3ENkxj9p/6HVNwUzXHNFhTiLuwrk?=
 =?us-ascii?Q?4xTCCo2K31O5H5ZhjA38qfN+9dWUEVvZSzVEZMrVUCSraQ3+IXJd+KXmt9RV?=
 =?us-ascii?Q?+CBSbSSGinh5HScyNbZ14v/OLl3heCgOevAWfZRNopWJy6ywLYwLDyrUASBe?=
 =?us-ascii?Q?AAxcub3ZTY+g4RUeDE8lxfVoKY03+HoeeClNIDi9E8vFwGXUWGZDr5VBOkM5?=
 =?us-ascii?Q?XSeKz6Cx23AVn13ZU87yG3M1j2DNiR0slGyZbJXkG+GZxQcWsvr6CX2htesL?=
 =?us-ascii?Q?xRodJsb2KFBTN89ObpmJaaZYpC+kzQQRZWb97ByVQFHX2q6IBvM0x9wbkS5y?=
 =?us-ascii?Q?HgH9tZCNLm6GEzLAK1Acn0MzTTG9AyfK4eWum9IUhV82Py2QvSYsDLb5vD2S?=
 =?us-ascii?Q?jSsQacvX1zHXyTkD9EjPW1UeHbg9qhpX138JirfVbnlz2uD+C8Ft69AjqBzC?=
 =?us-ascii?Q?UqfL8IluSgKYbtC/KVLtrV8vhShJAStB7fWbOsdS2p9N4if/kmZ4/varFNUz?=
 =?us-ascii?Q?OkryId47ZsJ6PsG+HY2xiDRrRDXYAg5ZoM8cDkF3v1m6qnbUd/8ti+Fca+Gv?=
 =?us-ascii?Q?BM3Kemgg7cwOwPCiTp/fOcqBLmlSoevssHTN1hW2WQOl2toJAsCFLF6HMCLa?=
 =?us-ascii?Q?dOFjPCeMPocroh/OXBS/3I6+AbYPewP3mcoyeImujUdLToyMLhyQIv6oxNqk?=
 =?us-ascii?Q?kDK72tISDUDn5B8AZxdGYZVtupNncOgSO6cvexEEuePIgfIqGPGUI+ZPccrG?=
 =?us-ascii?Q?xz0VLITeGpbL5MkqBpHG8ySlNFb5edNq3WgTpE8W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a2de2c-e291-4049-ec71-08dc552307ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 03:46:52.0352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QEkogiiyfhEmDn0ZQ5rxPPA/KOSmopw9u5dWI7xQEg8HimUlHfi3ddRMTf5lbFIDEVqN+qnTLt7bRUGbvsleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, April 5, 2024 11:41 AM, Wang, Wei W wrote:
>=20
> Before loading the guest states, ensure that the preempt channel has been
> ready to use, as some of the states (e.g. via virtio_load) might trigger =
page
> faults that will be handled through the preempt channel. So yield to the =
main
> thread in the case that the channel create event hasn't been dispatched.
>=20
> Originally-by: Lei Wang <lei4.wang@intel.com>
> Link: https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-
> f7e041ced249@intel.com/T/
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/savevm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c index
> 388d7af7cd..63f9991a8a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2342,6 +2342,23 @@ static int
> loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
>=20
>      QEMUFile *packf =3D qemu_file_new_input(QIO_CHANNEL(bioc));
>=20
> +    /*
> +     * Before loading the guest states, ensure that the preempt channel =
has
> +     * been ready to use, as some of the states (e.g. via virtio_load) m=
ight
> +     * trigger page faults that will be handled through the preempt chan=
nel.
> +     * So yield to the main thread in the case that the channel create e=
vent
> +     * hasn't been dispatched.
> +     */
> +    do {
> +        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
> +            mis->postcopy_qemufile_dst) {
> +            break;
> +        }
> +
> +        aio_co_schedule(qemu_get_current_aio_context(),
> qemu_coroutine_self());
> +        qemu_coroutine_yield();
> +    } while (1);
> +
>      ret =3D qemu_loadvm_state_main(packf, mis);
>      trace_loadvm_handle_cmd_packaged_main(ret);
>      qemu_fclose(packf);
> --
> 2.27.0

Main change from v1 is the drop of the wait on sem.
It's still patched to loadvm_handle_cmd_packaged, as the sem issue
(possible twice wait) isn't there now.

