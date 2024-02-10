Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83998C4829A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 06:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYhB3-0005ie-8P; Sat, 10 Feb 2024 01:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYhB1-0005iW-J2
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:49:27 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYhB0-0008EJ-2z
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707547766; x=1739083766;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mRaHO43ilsGthUjEIuCVcpGY5DfjBpstRhoP+6zzgxI=;
 b=IgEesVWB+2R5xGwlFL5UtAQQj9LI/VTaF9EkOsLg9mpezKjXqeo+7jvc
 pL9bQZfdZnwwCcZET89cZrTSai7Og+Esq6ey6vdtEq4sVh5SUrVT5ZIL4
 39POt3Coz1bwlU9BVMYrK78G99lk55FbvtVeSnnaMJKr4DykW84PzYsXx
 XiidTezSWZU4hsALnHQxnClM3qWG996QBNJir+rAnTjbtlX1cf0iCXVmf
 X5qYisM/MG7am3KOoMr9TaIwLVCUm7wN+/3BTUAmbK3ioi479AVtS9eiU
 oq9w5c6C0AGq5uTKMVJfKE2KezKve61JWwJsx5VY4EKwkFVsOdlaExP7e g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12631898"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; d="scan'208";a="12631898"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 22:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; d="scan'208";a="25348399"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Feb 2024 22:49:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:49:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:49:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 22:49:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 22:49:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRpq53bmuBWZng6S7Si/f/nkn1CHCzij+DMGEjMXND0j3ybxMgaVaSx6nAeCTTKXBJmjznmQpJl9ovYTST/EivzRIr3DTm6EGEjHQrJvmRZtevpesTozNtGHDlkgVLuLJlC5RHcV9+lsleNwTJ8DYYx4KDfkbi7c4vP1qB4PfqnA5KKFeMVGazrJ+wbc94IKlg72+ICjqRHkaamMmwBlPXh25IFfTPo063KmM3x33IBRWL5ylx5szZhf7jEK5yIMkrtSvUXybUr1X5qgIIjovj6fg+SvwaX4bUhUU5jBdeRIRBTu+a/b1/WzTJk6U3JNoLePQiXJ8NxPQMNjmog/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDOlQovwp8FLVNK+NIwLufq8pXM+wwqqHIvEh3cVWfU=;
 b=ZajTv3PO94AVxEoJDtFiuWHKB5H5eFXYCw4AG+LyZKMJ7zdQ6qdVpvwCZV+NxZoC1ShpEy+mfJkwagBfoEH56eIVwDXlGgJXJuHsYyYmF62HYUtAFR4Z5Zckz0xtEgRfvfKeobNBlTleRHWK+abQayVb3GbX/5sEFDpSmdvp6FsiZUVHQ091w6oKbpI3BCYYyWU7Edf14GBI1AQdpQ9LfgFU0TB593AhUJqD3O2YdyYrlaToJC1DfhFUUYJ6U3oFKU9wNiumcIMsDIY8PtGr9oFym4duRryvLBWfLclM+jeqzNxrWAD7DQMeEpWf6WmqIAFRa1qD7DBtYBiIuURhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.24; Sat, 10 Feb 2024 06:49:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 06:49:20 +0000
Date: Fri, 9 Feb 2024 22:49:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH 4/5] cxl/core: add report option for
 cxl_mem_get_poison()
Message-ID: <65c71c6e47244_d2d4294f0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 148c8eb4-4cdc-4ea5-8369-08dc2a04686c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdpoeGosxqJ1MnmjAGPsBY+OCDf9jisENRyACPy1IdDfRmgTIoWW4wHLoV21Y425rQGD0pJe5pwaE70rpWAO4uSEYCng8frPioJbfISCP6xMnwEyXsRxg+Wcnlaf2TKqLHxXlok0Z491CY8rl6bxeGOMF/JnmUEOV+lpXca5ptqBuVVi82Xu8E5bYm6LsmV+pCZi5HPma51UIipdKf21iPFq51vI5ZQtQVulAWd2iHJNgJnymjuVSTU2IAqjoiBOsT2Y0Lv/ANNfy6gjGwfRG6VDWF04U9BNWx5N8yysUl/sYHSwQIMtXLPEZUfIBKx6CA1fP9N8vlZ6OVIM5kiG4rUQs8bOquJrpP11TYypIvph93fmP5cfKRVhGUBVUHOa+y5YWZkVRu3b6Y3JPS9OR9xgzqqGIOPOfXBi66whMoi4gjgy5phJECssn9xzjzAVDi9lEx4XShw8DfnzY05OViOtHZJmot6wkdFCHGgwsYCvDeJ/7TZwtEEMY+okeeEBTL/ENOdC3lCwY3R9nlSDwHjZf4n5y/jlF5TbMexgrAryJ0+wmZso2DBtg0bpE521
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(107886003)(9686003)(26005)(8676002)(2906002)(4744005)(8936002)(5660300002)(38100700002)(316002)(82960400001)(6506007)(66946007)(66556008)(86362001)(4326008)(6512007)(41300700001)(66476007)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IN4Zag4ieah3zPEII1+mcTUdOUIf4jS+bdJLAQtCLna2oR7WTL2jAIK+oqd/?=
 =?us-ascii?Q?/aM/X5E2T6i1QXS+lqYzuZIup2GzfxaxS62ESk34XQptcRZ9/RVFJ712Or50?=
 =?us-ascii?Q?7wFFxlm86T/LYMQYU+jaLQCEVPsrRp8bmd9tUcj5Nb3cGkUQT6twdKg9BxeP?=
 =?us-ascii?Q?x7AJJmkg922AOOLnhcJF338XjKop2hYWEcQhv8epL43Wbpjl+NPA6B+q03pv?=
 =?us-ascii?Q?sWwIiOoRRhZ86f6iQpoId9Xdhwtjjl4ZCMLS0hWuTrKr7oAdenOPtiZeR0pv?=
 =?us-ascii?Q?7i1s2ftorwGjcaOmXknog+QLq2WyiowcpKVWWNl4WsVQx8z3P93imIBZ+djZ?=
 =?us-ascii?Q?DJNgbuaTq+jUeQ4Ox+v2rFFnX5p5EZuPJko+MGCOLlUqUKNrLWVpVXTfV1nx?=
 =?us-ascii?Q?gBimGnbH9X8rZo68eWF37meo1o3o0DEog81R3vLTSHIg5tqOEeeby2qug1v2?=
 =?us-ascii?Q?muptjGE0EMJOc1u36TnSH/vP2607iSzVi/2Z13jCQxv6UeEyaJdbC4zRghWo?=
 =?us-ascii?Q?cOp0dJhz2ven2xcBGo3cQ/2WKOmEe8/wG3+akOOkHeIQ27DkWYyNim4KbY78?=
 =?us-ascii?Q?1oU4l0eDFUsmNxl+g4phb3xkbQsbyOVfJdi6Q0u1votaE+z0Wvld4txpXDWz?=
 =?us-ascii?Q?7dIO+COdyDLj0imRNMzAz2YRGkARu2ws7uQGgtbycXlHUXoki6l/xOKtxFYi?=
 =?us-ascii?Q?kKVj9y7kLl1PW0iwM536V5v3lybUWGBPKWaJgMCCKr7Tvh/bVqIQlyojhShe?=
 =?us-ascii?Q?vcc2s/r5xb0NHkeEqJh6imjzGnoSL5Zd+EAwjPt/GmTLdcqYxQQpchcm506e?=
 =?us-ascii?Q?pQ+4gIoRomD5nhYGRdHYyJZIvlBQNc48KFm3Ht+vqZAp+DCf7LVoIyOJvRi2?=
 =?us-ascii?Q?tvHNbtomMk9EruwFWwc+1zATBFmoOE2dcPNSO+P0U1H22Ohb1oD+7U2Kab7K?=
 =?us-ascii?Q?tatBJ7zbPuSxLxCk3TGIcu3MVH0WFpP1MGmmW4FGLDIiFdd8rJ/biN4cwSD+?=
 =?us-ascii?Q?XDv1LrabQ2CAW1Z0wkkn2yMPFdslyl1fFnZrosq9RNbSm1+RmTPkN3g0gC/B?=
 =?us-ascii?Q?0bfb7JZUMojEcLQDhBi4b1fOJaVwjRRIVGZo8sJ4UH15F5uBqvrJONimIuKK?=
 =?us-ascii?Q?jEGT0n0QXSEaXBjKkGeiAc0qAkn1XQldGQ7armsICvvxIfyUyceXskM8/7S1?=
 =?us-ascii?Q?76yXiUDdrVhEQ36183BAHZ6gnIFg5E8c2CtmriQ30D00Ar/nNGzAedJXaAvr?=
 =?us-ascii?Q?qAE6XrG6lsA/D4WfGDHYtAcEfprcx3Hxwbi/e4SkXyy25hqwyHeSTdR6wxZE?=
 =?us-ascii?Q?oJrqJcOFEe8+Q79q1eeAXlFlOdN0yLA1OdImqe3D5cgcaIcRX9tvx3aES95e?=
 =?us-ascii?Q?nMuBwWZXup/3UJbMxc2rEuoaYnO62ylIkCBXCoe1YlnOjaSB8F2JqMcxeNEl?=
 =?us-ascii?Q?AGbpoVed6UvXh1ZRX4XL0Z/c5ACN229qMn3KI7C0VHHOS0oFpd+A/lZEnj8j?=
 =?us-ascii?Q?W3Dtl/Aqp9Y9C6laOsAuuHZ++wDdZRybx2M7Q0DSEz0AVDagDOa8QU/Swtrh?=
 =?us-ascii?Q?++3YASfsVTyritX7665Un3VdOWyda3zvckuGa/TkF/7D9SQz5B5See/oisC2?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 148c8eb4-4cdc-4ea5-8369-08dc2a04686c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 06:49:20.0909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOsdVmEJ5P2m9IwiY18uIfAQhY6E3FoORGoNcFaDMy67XRCEvi9hIyJlAZwUt/MZGSxF/4rnRtv2briocFlyJOMtmRbVrMQ3qu5c5u/QixM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Shiyang Ruan wrote:
> When a poison event is received, driver uses GET_POISON_LIST command
> to get the poison list.  Now driver has cxl_mem_get_poison(), so
> reuse it and add a parameter 'bool report', report poison record to MCE
> if set true.

If the memory error record has the poison event, why does the poison
list need to be retrieved by the kernel? I would expect it is sufficient
to just report the single poison event and leave it to userspace to
react to that event and retrieve more data if it wants.

