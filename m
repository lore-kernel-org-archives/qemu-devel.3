Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6738FEE4CB
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 06:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwDno-0005zF-7y; Sat, 28 Feb 2026 01:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vwDnm-0005tL-9U; Sat, 28 Feb 2026 01:27:46 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vwDnj-0002e4-At; Sat, 28 Feb 2026 01:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772260063; x=1803796063;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eKGUr/xYN0OJSJOAzfOT4UaXcNkxp/pgVA1cbWQ98R0=;
 b=jeFNdXSowoA+VKGjQazHkx04fUdwkdvyzicjEQrk5/WPq/1vK9rF2ouu
 mQKtJDUGS/SYiUcjOBMHKAq55sYkVo6atyBRVJaP5nQQebZf1xfAF7Loo
 zAMo73y1jG3vBaKuOr0cTUwn61ExNS1SWdWRVtBjO3qEFHd83tLyTfGNk
 zK7COl5zWTYZQiImBqn1FrMS6LodZkH7UdwM/8V2LE3KGLOB2l9QSXreC
 6mbYMd2oTubDmusn4HWnbDMHeSJxnoOiOo1TFGWOE6qDB2OBbSDBp74r+
 0AqEYkSc/XqivOR9bqDmGRVkPE3jf/LZs0RMkW3Q4T2+ABPD+K4bLBbQQ A==;
X-CSE-ConnectionGUID: vijvqAXxQcKzzUO4WFqehw==
X-CSE-MsgGUID: jTHhfhQTQE+JRuEog1YTVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73245538"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; d="scan'208";a="73245538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 22:27:37 -0800
X-CSE-ConnectionGUID: yIjZ536kS3+BovVt0mKFnw==
X-CSE-MsgGUID: bPVHD5PhQ5u7Dvs7g1K+Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; d="scan'208";a="216243896"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 22:27:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 22:27:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 22:27:36 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 22:27:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm4a9kbD6WB5acHOc2Qb7lKjyCvnYJHwr+hEYXLKXAbS1tzbWkIR6UEE+5fMr49OAcw0JP4lftIRmnNWMap0GJGEO4qAYgAt+zSeL79ZKF12wNW5235VWnr6NYIKyhuzvVkTPVI7uGWvoY0sZN/MZjJQOJN/6m9VJ5bComvZHRSPsKf/zTIGntB62SsDzdIU5DdB8yDtppnLo8iCwkEa6KHeF22CChqw6tv1r/azV02xyO6kA5HqRbDbXFjATYv3aUxZagp/fkXS0WsF3IWPEIMK7AbhIZu9hzyaSOuuLsKtlqFhFIqCRBJnH8uEWMdPV/0JUzMtBQ1rAF/jXQlGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDaWnN0msJhozZaxxh/Vm8EKV+sYFdDvzsorK9HdBHk=;
 b=WDEySZ63jqL5dGce07oq/OfpwGO3VO9Qpjc6xahwe5wl2QeMrq46dWy1RcFeUMgISngtMeUPWFf0GRRx1rF73y1b/H3IvKNoMW68hSJDqCFaFjIf507p9uZQKUdJgmccp1SR8SjFfdmAeUg7OLCtkvqOfL9P6ocPzD+WXdYp39pNe+GshLTODjnNgWMF41eH/vQTTg3GtTMzALmIh2BPYfGggLDd/9aM0psYbHfALCcow/jU+mnjaibS/uah7pH5AqVcPMkThej04etqcVqXMIl8mrzoTlI6RhRQ5DU29upKSlxa3i7KxdiB76luZ6MdE0ESQRhcBzM1sexiA6Hv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA3PR11MB9512.namprd11.prod.outlook.com (2603:10b6:806:47e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sat, 28 Feb
 2026 06:27:35 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 06:27:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "jan@nvidia.com" <jan@nvidia.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "kjaju@nvidia.com" <kjaju@nvidia.com>
Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcpvxrPWY0EIaO2EyyMmxqBreJU7WXd1wA
Date: Sat, 28 Feb 2026 06:27:35 +0000
Message-ID: <IA3PR11MB913652049863E1F32BE9C1319270A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
 <20260226084456.112142-6-skolothumtho@nvidia.com>
In-Reply-To: <20260226084456.112142-6-skolothumtho@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA3PR11MB9512:EE_
x-ms-office365-filtering-correlation-id: 45632415-7f95-472e-78e7-08de7692761a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: pi+Pv/82wVtK+1VbkeClkEy8apQojsylO5t/3Kx1TNk/BY2FFp0MExOhhx5rndpYYiQhm8zlfA5O1pmt3aQbL+mwgtI9XPyc+Jw/BjLnkBPXUace3s6tYMHmd/YOmnTPaYQrGNhq1x221ZNzan+USO69F+XMo8cRfUT1e8fI73b53z0JFr978Zp7cLXAcfuqq5rAjbbj/szZ9oGx1XSsLmwxWbMDMTvlT4WFa8Iwb7SpI47/ZIICit4WcV2RHqX/2CMNS/GdGuQt47/MWmSGzjlROP/qLA/L03TecQcHZaWNDMpqrxFI6ouw6JvB3GkIyOW0Ta/moAt8/EZAqeVF+AaZzumhYyQtbCzvUrh2h7HwgNMOZVONx/0xpRO21LCXafuxGvDYcxZSIV09u6HDhl1mVjuzw+hGWm80AFbt7WJLP+rNXiiHj2gG3FKMSC1AR2eoQz68C8usQtS65gI/OmxHRnoADOqVT5WAoHm0aq08kcXcAoHSMLov8f9UHxKCqfN/4R4VBStYBqpzB2P6rLZvrsHJBFTQj4ciN4/OOocGsFhIrMUajUEUo0NDWiJ8hhMwICsedqzPrxW4AJDTujLzK05pWGUVo2IG3egt+eT5EzqnlIHblaDfYWwP9kjkFW5T4RCFgfoOUpKy62GsRsY9+WYtkOqrb6F/Yv3Ze4S0rENM9+LuwEEKTbyPTzPYqD7Fw3mUl6CPt5sQNHsAp4hx6fVPa0njdYFoyFImi2kSTZOwU4G1Voj0TuzaAR/gzhYvt0MtVlZcfrngYtZh12ZKNDUA8JzeRc1B8A2WWFA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U21sM5nxclIS3/qKUfP+s64y6JvzLewLMGXLVJrycun/fxA9ytgnYD3AwvzL?=
 =?us-ascii?Q?qu/XUoJlp6dC5+wAh4r7dvBHcE8235qiY+LZTahbp3V4l1V7PU0TXVsnvllB?=
 =?us-ascii?Q?7cw7PQJFtt/QBMmKz45gmkozUMvVCQnBArX1z53RzwNs6/MOJq2jWbXD6JWO?=
 =?us-ascii?Q?vmmUPnf93UX/LeceXdMy+Qy0lx9lSsNruvFAITkV18Ap2rWWzdqFgABrSHWQ?=
 =?us-ascii?Q?L3yiFhT0Ud/59UGkV70B/nfo+ISYnYu8E/nt7g7WWBRQ9j1lJKyx+1SGY4VX?=
 =?us-ascii?Q?PTBje4Ri+jey7Sof8w1jCIlS+3OLk65wVl0gNijaBv4Qu4zs+wCua0fCXJMs?=
 =?us-ascii?Q?M3bQB8WV3fS1wUENmflX7kWsvLMP8TN6KRNH0daIbj3PSOj/1hpGDOxfEMcI?=
 =?us-ascii?Q?T6gtHwwQKRTf/S0ch/n2eNO8DJpPIpZmX2wopGHA+JasHv+4N6x77RgO7Dy6?=
 =?us-ascii?Q?oASJGXWRfNnO3DWmibBPrtJIjmLllBXG5tB4FfWvAiZtxwQADTBHai7ctIGM?=
 =?us-ascii?Q?lZAjoPNIsp7IJ+3f+WarnGUlt93LBqOm5z6rL+8QD2Dg4bVJ7ydy+6sqnIHF?=
 =?us-ascii?Q?GdR0bkxqjRevXiG961N3JAQtKuEFEUD/N3oQpl0JRXt8IqXQD20oPemB7A4D?=
 =?us-ascii?Q?6BiPCjKzvqzRNE0lYkfOwQYlqc3TiDJfhbK4KzT1E60kSu6es4Z1KWfxlCAb?=
 =?us-ascii?Q?dd8AI8+db8kxQWcrQ3ghKyyX5TvzdnIKsMF/cDu9IFlacemGcSnfqwSLwVCh?=
 =?us-ascii?Q?Vmuy1vafH18iQnPSvgGXVdGmCo5NhzbFuuda6B2LYQKzASpcA25s3klMXJP5?=
 =?us-ascii?Q?HSP9hgznkceS17C5Y286Z14ytwbeQpca1j9mybrCkqHnmTlnAIOPhnTb+b92?=
 =?us-ascii?Q?1HScgq/5swpT+Y2VWxJbSmX8dIC5yM/BSoqFhtiSGKMpb7D5rsXTEvTdaTvj?=
 =?us-ascii?Q?4n0b692WkRO9eiuHyEYOIcej5inK1VGu4nMt/56WiaWbglUaIUZqzxRjTP+q?=
 =?us-ascii?Q?sWmrQN4zsbIBkzv6vbwtQOnlBGpO32MOaG3nBbXFFkDhrweIvGUyZHao+lfo?=
 =?us-ascii?Q?JIyi99kQTJE4fjfDqTl/9lMT1oP3DT/IyHJtMxB9ORf1ZZ439b13was4nLho?=
 =?us-ascii?Q?6/5lJRXbGNjV8iWz02qAqTXT4HhObQXRtXgjixn6LlZOeUWY/liNqtc0B6MV?=
 =?us-ascii?Q?UU8eX9qxV8n6brygXcfygNO7TSvN4ZyxBtc1N5hOfQwqqs+8ljsY7MN5enHN?=
 =?us-ascii?Q?b6RcfbxMWNqTURpJBIALp8eDqBcsgaOhevAyvOpsPopZVzf6M32S+m2H7E2A?=
 =?us-ascii?Q?kWs/l7MGn5bRA0LSV/f+QNUtLw1r5m0enTZnx7KtqJ/tp/umBatrkEzkYlG8?=
 =?us-ascii?Q?Z+ycXLvfAZkVLe2orkyngB9ZEQHcpnyOWvlhOx6jLYeMMh1//BFzR95Vh9Ee?=
 =?us-ascii?Q?7NCa3adnF2Lw2JjIP3F0HDb35YRSPA/5u9fGXjYZurP5OKTiRGYOMGVk0N/F?=
 =?us-ascii?Q?lYd9wyOAdLYQoDYHjrU2sK15Q+97SRNzZjP+dVFxY8L5VlZCluemdoP076AR?=
 =?us-ascii?Q?RNq3C5ZLBLIMeIvCHtwBhe8BxUJe2hXQrE6+WChf/KarnnrhqvAw2mqJ2Puj?=
 =?us-ascii?Q?HPTvOABLteGs2IUux4adniY8ARJwobwxteHqTCgrPLsGKykV559yMtUEJHZN?=
 =?us-ascii?Q?klK7QcXnP8L98thJDeH15tBqHuU43NIk8PiNE6IGlHkqjLE4lLbQJ7d4Yg3P?=
 =?us-ascii?Q?xWFQnnIvxA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45632415-7f95-472e-78e7-08de7692761a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 06:27:35.1349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yt49Tz/HmB6k/GmuKrDaXfAR2B/SwjnadtXc181gwstR8DhRU6K+2kNTP+oWwoNvONgkm0USecN/xSyKdjSE+usHpRRQwjIGKw+D7CTFizw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9512
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

>-----Original Message-----
>From: Shameer Kolothum <skolothumtho@nvidia.com>
>Subject: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
>vIOMMU events
>
>Install an event handler on the vEVENTQ fd to read and propagate host
>generated vIOMMU events to the guest.
>
>The handler runs in QEMU's main loop, using a non-blocking fd registered
>via qemu_set_fd_handler().
>
>Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>Reviewed-by: Eric Auger <eric.auger@redhat.com>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>Tested-by: Eric Auger <eric.auger@redhat.com>
>Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>---
> hw/arm/smmuv3-accel.c | 64
>+++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 64 insertions(+)
>
>diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>index f703ea1aac..17306cd04b 100644
>--- a/hw/arm/smmuv3-accel.c
>+++ b/hw/arm/smmuv3-accel.c
>@@ -390,6 +390,50 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs,
>void *cmd, SMMUDevice *sdev,
>                    sizeof(Cmd), &entry_num, cmd, errp);
> }
>
>+static void smmuv3_accel_event_read(void *opaque)
>+{
>+    SMMUv3State *s =3D opaque;
>+    IOMMUFDVeventq *veventq =3D s->s_accel->veventq;
>+    struct {
>+        struct iommufd_vevent_header hdr;
>+        struct iommu_vevent_arm_smmuv3 vevent;
>+    } buf;
>+    enum iommu_veventq_type type =3D IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
>+    uint32_t id =3D veventq->veventq_id;
>+    uint32_t last_seq =3D veventq->last_event_seq;
>+    ssize_t bytes;
>+
>+    bytes =3D read(veventq->veventq_fd, &buf, sizeof(buf));
>+    if (bytes <=3D 0) {
>+        if (errno =3D=3D EAGAIN || errno =3D=3D EINTR) {
>+            return;
>+        }
>+        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", typ=
e, id);
>+        return;
>+    }
>+
>+    if (bytes =3D=3D sizeof(buf.hdr) &&
>+        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
>+        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id)=
;
>+        veventq->event_start =3D false;
>+        return;
>+    }
>+    if (bytes < sizeof(buf)) {
>+        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd byt=
es)",
>+                          type, id, bytes, sizeof(buf));
>+        return;
>+    }
>+
>+    /* Check sequence in hdr for lost events if any */
>+    if (veventq->event_start && (buf.hdr.sequence - last_seq !=3D 1)) {
>+        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
>+                          type, id, buf.hdr.sequence - last_seq - 1);
>+    }
>+    veventq->last_event_seq =3D buf.hdr.sequence;
>+    veventq->event_start =3D true;
>+    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
>+}
>+
> static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
> {
>     IOMMUFDVeventq *veventq =3D accel->veventq;
>@@ -397,6 +441,7 @@ static void
>smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>     if (!veventq) {
>         return;
>     }
>+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
>     close(veventq->veventq_fd);
>     iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);

Did you ever see free_id failure here? I'm working on PRQ using FAULTQ in i=
ntel_iommu
and find a race condition, I suspect the same for vEVENTQ because both have=
 similar
implementation in kernel and qemu.

qemu_set_fd_handler() is called to remove veventq_fd from epoll() but it's =
async,
this can lead to releasing of veventq_fd delayed after free_id(veventq_id),
during veventq_fd releasing, it drops reference of veventq_id but it's too =
late
and free_id(veventq_id) already failed.

It's not easy to reproduce, we had a test case in guest to trigger FAULTQ a=
llocation
and freeing sequence in loops.

Thanks
Zhenzhong

>     g_free(veventq);
>@@ -424,6 +469,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s,
>Error **errp)
>     IOMMUFDVeventq *veventq;
>     uint32_t veventq_id;
>     uint32_t veventq_fd;
>+    int flags;
>
>     if (!accel || !accel->viommu) {
>         return true;
>@@ -445,12 +491,30 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s,
>Error **errp)
>         return false;
>     }
>
>+    flags =3D fcntl(veventq_fd, F_GETFL);
>+    if (flags < 0) {
>+        error_setg_errno(errp, errno, "Failed to get flags for vEVENTQ fd=
");
>+        goto free_veventq;
>+    }
>+    if (fcntl(veventq_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
>+        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on vEVENT=
Q fd");
>+        goto free_veventq;
>+    }
>+
>     veventq =3D g_new0(IOMMUFDVeventq, 1);
>     veventq->veventq_id =3D veventq_id;
>     veventq->veventq_fd =3D veventq_fd;
>     veventq->viommu =3D accel->viommu;
>     accel->veventq =3D veventq;
>+
>+    /* Set up event handler for veventq fd */
>+    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
>     return true;
>+
>+free_veventq:
>+    close(veventq_fd);
>+    iommufd_backend_free_id(accel->viommu->iommufd, veventq_id);
>+    return false;
> }
>
> static bool
>--
>2.43.0


