Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0D6CAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KVi-0007NB-64; Wed, 24 Sep 2025 04:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1KVf-0007KS-69
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:05:55 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1KVU-0001sR-EJ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758701145; x=1790237145;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5/8eIibOMha4SI+dpNuhWkztTaiSzowE+R5VeHXu68Q=;
 b=lnoX48xfyTYPbyEYOwS69ByLQfs4PubWcRpziTOohpY4JkVgfWv1Xhc9
 goCvoD0r/yCHF96S4cZtedx8I121c+NrEfl89P6wStkm+RfzNmlASe9rI
 c7U9Y0BbkPqn015K+bHUiT6ydNe82Yd92/lql6TR2IacXURyTcG5TUuuQ
 Tttsw42irFEtxS3gKIJo6evxlcnW3fFosJjO1CSIjqK/qElVszwwhQwA4
 zZ9xDg29nBLDJ6EEZsL0GUdMvFEACo/LMUtaJaDzEPCEZnMBSCAWzB8rh
 WgVfhviKIAldn6nBEqeOO4yF4mn9hvxxPZrUHCfgTUCcgzC2nfvWNtqMG w==;
X-CSE-ConnectionGUID: itNoTcD/Qb+Yu4njHifgOw==
X-CSE-MsgGUID: RW1L5JvqTj6rAWAo2MtXNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72416162"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="72416162"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 01:05:40 -0700
X-CSE-ConnectionGUID: ySkNPnxYSXiuxw033Q4PCg==
X-CSE-MsgGUID: XFw7kiOzQUi5jML+8DhXdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="177369512"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 01:05:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 01:05:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 01:05:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 01:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQDuajp1OVsAAvyfzV4DVsjFMdS/0wfyXqyVHg0FALRWYxl0ZCD//3q6qBjy8pjnpy/ZJyz0aPpSTNmUi/ZVqLt7g6c0V2CwXzjjeqlEVrzpSZLOQaIYAZUlsGxxcdtB5qBzHyGYAVLcqc+pKI0AhDda1v46rwi0KuZFLGSeljBXwMEKg3wLl7SpomkjY5mNj8+lb7VDPPeX0Ot0ytKGZq1XMZEkgDnt/EigpfP/milKeRw0eCXL7/DyRNZpRcBuX9CaJAe5ITjG+D7vWvo9Qant2W8zXJOZwmP27lB2loKaGb4zZnNtbVd8hEqrlbBDOOzklbdxFeqC/lOiHIjtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm47g8luwBrqBCe6YXP6VD/WlDYbZODJT75XN3KNnvw=;
 b=EuJHKY7yjEbCTfvWTgInpLZX4MUHyfJUXak4p7Ca+6+wifSGija4wfBsDbfdvUNB3AYq8AGf84MqXUKlN6f+IlBmZk0FXbIiB4QtJPOSIEsVgPlbt3rN2WQ4fwnoN0/dnvjz440/B0t71Yp3Dus948eKmDMgpQvj8QnFtPLaunlOgTWsLBDnIkZ5lREvT6He/p3WX7ASGMEHS/+PalvM0ZbOOnDDbawR25ByVDs7VCWYpv/+IM6BlrsCQqE5eWXmpqqdBea93MmQdO4sqj0g8u0nkwV4B61kbDLcUztbOOKMUHNi00W375iH6gNONt4Kg5LPUnrqczSk/rsXUv0kCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:05:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Wed, 24 Sep 2025
 08:05:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 18/22] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Topic: [PATCH v6 18/22] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Index: AQHcKHqbGlodRerImUCRhKTrW5zabrShNDgAgABuqOA=
Date: Wed, 24 Sep 2025 08:05:36 +0000
Message-ID: <IA3PR11MB9136B5015A5396E5FC782B8C921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-19-zhenzhong.duan@intel.com>
 <aNL4zruHP8P8ExrM@Asurada-Nvidia>
In-Reply-To: <aNL4zruHP8P8ExrM@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA0PR11MB4767:EE_
x-ms-office365-filtering-correlation-id: 6f1db1fd-cf5e-4063-da80-08ddfb412516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Sks9AJ5ZU/n6J2hritRSuO+jg6CrPuXYwaSOx79a9JhhRsObb+Qm8rnla7eR?=
 =?us-ascii?Q?vdNiIKbtPo2+tzC1oCP45ZK62AVXQntJYUvIsVgYPSsAYFWewR1rU7W5iBFi?=
 =?us-ascii?Q?wgH//wOLgLy6miaPkKTvmtpCgmyjzSvYa1FbmEfviufUZu2UiF+s2idDhWln?=
 =?us-ascii?Q?GjveOjV8rsvsjppYuH0hMchrcIGxrdPyLfl/OJnRWvCUaaEOygQt/FMQHDH3?=
 =?us-ascii?Q?Gybvn5pF3TyAjTAwEj4C0fYifCseoMMbFGSczbe38Hzly9M8W3ZSnsmBMG0L?=
 =?us-ascii?Q?RUGo/JtFIWKX7MYfa04WIgRI1IojS0Je4KI54jyg0i+yRPytOXXRpY1myCh+?=
 =?us-ascii?Q?Boev7hMwfh3FNuc1KHTtyMpwxzCNdiyPpYo9IUMaje+TPsTgJIqiAm4mvbJf?=
 =?us-ascii?Q?rd0q/iBCpayK9vRM1xVVw+Xf5KdsLvA6K9vRG6l/bn+ld0OwcB4GNXV6IoTN?=
 =?us-ascii?Q?CMEytKFN30EnfAusc3LRCD6fbEH7XU9VYuEqOqBeOt7k53o/LDXN/bGjr05k?=
 =?us-ascii?Q?qrHmD9MUGJuhOfywfaJHAh5Lw9noVUqXJa94erFPBHOW2tmjilxWMV0NoCS7?=
 =?us-ascii?Q?LK0/1CEO86p0JtxKK8oaVM/LsFKA/L/ASJawoXMed5F6dtb+pjW/JDT84w7+?=
 =?us-ascii?Q?JpmZ37lNZeERBLYpceo5HqlJ1p6szzhLy4aPEaEq+AmAqVwu9zz7zMBfv6cA?=
 =?us-ascii?Q?DICHlSsOpEOnDYtj/P14ezbuKEeD4nrquf9W6dO50U1Q6Sd4AgoiuC6EX98H?=
 =?us-ascii?Q?pClaeEMfZOfNpd8ma03W/+B29qUf1rtvRt9/ZlktpGo9Cjw7NHmRO2YXEF59?=
 =?us-ascii?Q?u3mrUJgt0cqB+AWSdGLJIHTaHJY+/gRrcG0T8EwNg0C+0veVGycQ2qjj5pt4?=
 =?us-ascii?Q?BBrcjYF8MfM23f809yyfsXtclXbRA0Rc4IexFO/kbYlgWlxZtmYlKz7c3yz/?=
 =?us-ascii?Q?aZ3OUpOaeR7vBe3gmgwSD4GD2d+kKQW5Yi1m/Yt63zVeN/h34MAIyXHHsruS?=
 =?us-ascii?Q?YLaEu7y1ovWfcdyQO+LKCvoIdi0i1VH2TD21wjUcdrBKgiOl5H8mFc/k9AwQ?=
 =?us-ascii?Q?8FUEPTOTggxnpi3K1s8iFoN5BqtwECrx8vD5YFbUo3L0Q5rz8s8C0jop9WPQ?=
 =?us-ascii?Q?79KahtlfgIejfGgNMF07yCtzVuFWRiwWCDRM3gu0rktyPgnUQu/cNBe9NQKY?=
 =?us-ascii?Q?s6w7x7+1nsWiR2ePuF+bNC+/AhtSELq40b2kmqAOxe5kDeWfrEiQUYZY4z0p?=
 =?us-ascii?Q?ev1Mzg8J0unlxiYxf/JZO33xwR06BOsmYpCyYns76AORquQoskh9vDEt28TA?=
 =?us-ascii?Q?CgRHdrBtK+lLwv0FQouLJzLg1zY3/QWqudckoEEUFBPVSKrFta+UAqXEPPx8?=
 =?us-ascii?Q?xkzkiz4OEV1zJnFpqNrL8j5oQ2x85uNwODIpnUnp+8MvAIZ9L0/5sNLnuPew?=
 =?us-ascii?Q?/CNJlQFTUv0lBNtNQuAzNCiNXevES43npPcsWfZN/oQLsk9bWMfVOmwyq4wn?=
 =?us-ascii?Q?vVwUvWXBs0nFiNM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5gGgkX0H8QRUBToGthoej5H8M67INazidjjFA8BdTEe2qX87D1tAJEEs2+0?=
 =?us-ascii?Q?9HFcxPUHYU6RVDlv0ad09rSjJivz4f1s/yddL36Q4PaDYZnByI3y4V87LZm3?=
 =?us-ascii?Q?DQHgbzzYmLbbmzlLHkHucCI0SWuFoVOiGAe1Io/5UT8y96+zf0B8qALZQQ6C?=
 =?us-ascii?Q?SGQnEX8IyN7YbcyiCutWfvPcYnR5KOIsHRQ8+6i3IZFWZNyX6F6pXK8D0FTW?=
 =?us-ascii?Q?Ls7MOT6h+Wd+ivCFUluZA9U2mkCOgD/6ekqRwyKINFCzofPY/+ddNH0CtBv+?=
 =?us-ascii?Q?FmPOPFBXUGuvAJKXQiX7ArdZJ8HVtbCMnQ0vfQMF7ENhirzxWfxXF7ze1WUV?=
 =?us-ascii?Q?gG+WU39ZQuuqLVfnoxqdSiBe2aimAsR2qmEgNRa8sRZpCzeTJ9S6qtVETVsI?=
 =?us-ascii?Q?tjnkHleQW2+M7dQTKHS1TEsQwKtbK5d9to9vKX+c0UmgjEdligvtqdSRFZQQ?=
 =?us-ascii?Q?TN5RQRBYhOq902I2Zamgjy5+hfipJk0v7L9NDCzKNWWH4bA37NRhVDrvCqxI?=
 =?us-ascii?Q?AoFFtwzINlzZPc31tlwlewDqdvHMPPYn3ss7imQ/9zCmc6jHoQWUV9awQCg3?=
 =?us-ascii?Q?epznKBFubUoqA5t7WsLpQ6oKPfMPnIOz4kdIuNrhSg9xvaPZR8NYnTln6amo?=
 =?us-ascii?Q?Q4dFJrItfrMdyBEdCwpDaKZIyyoEqqhucPqJ04/R28zmqQSSs+4mfgP7DX5i?=
 =?us-ascii?Q?l8irat/7HOFLGRH7ev8HbOhEGV9a70a6a7YKkdPy4tjwMhkVay81aM3OCnYk?=
 =?us-ascii?Q?VFwMq2+0HMVuqbeV0UNDEYCo5mqz75ImvqdIq6kr774hSRuBs3tuiYmi7Xdb?=
 =?us-ascii?Q?DSGIauPfUWjgabLcxsQV9gIjDEHRF+iBJ7yOAna6mC9sVL4N79n5TnbBmDU5?=
 =?us-ascii?Q?JDUEzNkeb8XL1jHrGi6QQUk+4EItZ+Tr5rj6Niqt9z4kTH/nzTj9rVxJbGNC?=
 =?us-ascii?Q?TdpQTV4e0jVKfrUSnXmA98bQW2e9GvvBFHEGuqclB/kUS07BaNagkuUBmW9U?=
 =?us-ascii?Q?b1cl2817FlmlMh1bfpEpbX8aXeVAHPPtcfDUHcnJn491Ni6b2n2V3dgI+FVf?=
 =?us-ascii?Q?NWJWE0PScggX3GOvvM2torOdrYPWMPWkT1+1+BrCTn35hnGeRO9EZEvXcE/z?=
 =?us-ascii?Q?NrsjpyQw1oI45jKNAe8rQCXPFTfXarGB/OR0lk4NC1R3IVzrhKFEM2mbskYz?=
 =?us-ascii?Q?6M3DCrZ+EoMVnZILhyIYJeiGYfQ6BCyJgMhoLwenSl5ScQ0H1LbkR39PEe3L?=
 =?us-ascii?Q?xNXhKilj2/QqWko86kFABFmmmFB1xxovAG2G23gCXUvXhsk2MhqkZmiyH6qG?=
 =?us-ascii?Q?Vf2ZeTsbDlXOaWPDcoPOq9BpQjyjL914XO0PaKJA9/i6CX9UvUi60ovy2BDw?=
 =?us-ascii?Q?Mx3qMUnJtBt+IFHJzLgPQTqaF60a1o15xm34Lq4zZieBywBFlbAsm+7CfPlI?=
 =?us-ascii?Q?zONaOxJl44a8HUM32VFBcIjs6K1sF/KUqaWBPDMXBoZx5y42WTifvDAYymuE?=
 =?us-ascii?Q?MB23nfX5E9vE1dNudwVWLNg43eObhU0KrxaizYD2MbSMiUnT/p/+59Aye3XK?=
 =?us-ascii?Q?Eglebo/PTtow2JMys01rS0hndyggxYn90S3z/DZh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1db1fd-cf5e-4063-da80-08ddfb412516
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 08:05:37.0074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: in9YzfZ1HlxCw+MqkswxTaz4Oxzbsl60GkNsNDZdhlUmfkVCfDbIfL/GtG6F7KGH/uJMQ/5uy+odz8xydrmkXdYeXVU9m6P7neNfV+calig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v6 18/22] iommufd: Introduce a helper function to
>extract vendor capabilities
>
>On Thu, Sep 18, 2025 at 04:57:57AM -0400, Zhenzhong Duan wrote:
>> In VFIO core, we call iommufd_backend_get_device_info() to return vendor
>> specific hardware information data, but it's not good to extract this ra=
w
>> data in VFIO core.
>>
>> Introduce host_iommu_extract_vendor_caps() to help extracting the raw
>> data and return a bitmap in iommufd.c because it's the place defining
>> iommufd_backend_get_device_info().
>>
>> The other choice is to put vendor data extracting code in vendor vIOMMU
>> emulation file, but that will make those files mixed with vIOMMU
>> emulation and host IOMMU extracting code, also need a new callback in
>> PCIIOMMUOps. So we choose a simpler way as above.
>>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
>With some nits:
>
>> +enum {
>> +    /* Nesting parent HWPT shouldn't have readonly mapping, due to
>errata */
>> +     IOMMU_HW_NESTING_PARENT_BYPASS_RO =3D BIT_ULL(0),
>> +};
>
>I would put a name here too. And given this is defined generically:
>
>/* Host IOMMU quirks. Extracted from host IOMMU capabilities */
>enum host_iommu_quirks {
>	HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO =3D BIT_ULL(0),
>};
>
>> +/**
>> + * host_iommu_extract_vendor_caps: Extract vendor capabilities
>
>Then:
>
> * host_iommu_extract_quirks: Extract host IOMMU quirks
>
>> + * This function converts @type specific hardware information data
>> + * into a standard bitmap format.
>> + *
>> + * @type: IOMMU Hardware Info Types
>> + *
>> + * @VendorCaps: IOMMU @type specific hardware information data
>> + *
>> + * Returns: 64bit bitmap with each bit represents a capability of host
>> + * IOMMU that we want to expose. See IOMMU_HW_* in
>include/hw/iommu.h
>> + * for all possible capabilities currently exposed.
>
>And simplify this:
>
> * Returns: bitmap with each representing a host IOMMU quirk defined in
> * enum host_iommu_quirks
>
>> +uint64_t host_iommu_extract_vendor_caps(uint32_t type, VendorCaps
>*caps)
>> +{
>> +    uint64_t vendor_caps =3D 0;
>> +
>> +    if (type =3D=3D IOMMU_HW_INFO_TYPE_INTEL_VTD &&
>> +        caps->vtd.flags &
>IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>> +        vendor_caps |=3D IOMMU_HW_NESTING_PARENT_BYPASS_RO;
>> +    }
>> +
>> +    return vendor_caps;
>> +}
>
>uint64_t host_iommu_extract_quirks(enum iommu_hw_info_type,
>VendorCaps *caps)
>{
>    uint64_t quirks =3D 0;
>
>#if defined(CONFIG_VTD)

I have applied all suggested change except CONFIG_VTD here as it's a device=
 config and iommufd.c is device agnostic, it doesn't recognize CONFIG_VTD.

../backends/iommufd.c:419:13: error: attempt to use poisoned "CONFIG_VTD"

I thought this is trivial and OK for not having CONFIG_VTD?

Thanks
Zhenzhong

>    if (type =3D=3D IOMMU_HW_INFO_TYPE_INTEL_VTD) {
>        if (caps->vtd.flags &
>IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>            quirks |=3D
>HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
>        }
>    }
>#endif
>
>    return quirks;
>}
>
>Thanks
>Nicolin

