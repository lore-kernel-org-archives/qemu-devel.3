Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAFBC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 03:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHwTU-0000qM-9O; Wed, 21 May 2025 23:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHwTR-0000pG-Md
 for qemu-devel@nongnu.org; Wed, 21 May 2025 23:20:02 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHwTO-0000kl-Qi
 for qemu-devel@nongnu.org; Wed, 21 May 2025 23:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747883999; x=1779419999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M0tKlEbJ23g+0yAXlMoHei3ZCMD8D2SMiVuMYKdanPc=;
 b=Tbh0fS2JOkwIjpiqZT0ucenwM9Ew1XdcbSA390pza7OEeqc8tTCMuiHa
 IR8SIzoFmhXeTktglE3d/XyxsSpwSptAApcBKBjzyTspmw6A/AVDfLZ9Y
 aN09qnaArqzS4rNA8atlXNd4e1HEznHYSIbPehQpXz7sfB2ocoocF6rVM
 Fwurh3a+CEY7bkI5hX07EA1Z/wKf5/1/WVWpGk2uJkfxMK7VyEDmjyRfE
 Si1/hJYr8ncr9XZmxNoe201e08knpTHnwWkRFo3jCl/A2nXJ8mAoE962u
 LbbP8rDp0X8lxI+7ItkHYnOexIka1X1LGNY97k+vCQueiZ9Xx5kyJcCdg Q==;
X-CSE-ConnectionGUID: xtKIWbjAQeKMgLM4ot+zBg==
X-CSE-MsgGUID: GalGxD3YRQmTOq2h29Tw7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="37509294"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="37509294"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 20:19:54 -0700
X-CSE-ConnectionGUID: K2UqcGylTcunzsIO7/L5ag==
X-CSE-MsgGUID: jTuatqwtQVSaVDeSTYqS1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="145528331"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 20:19:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 20:19:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 20:19:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 20:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBCWbo7HvaXH2C0Oc63FvmxlJ6gDhgMT5ukQ4AshmPyUx/ODo+dph3E/m7nwl6lpJ0X/A4k1RIyhhrZViTzn5XO1WcRbaQksaYsC+wPC+jl6aswELVZTIPdIiKrhh9Ma8mUDPzObEJ9rnNdPVZpKz1Oe36gqDa5SqCmlIzIEfyZOc3Yf9DwNulj0oA14vgcJLYgdXxxMEfvNPcbMlwiNUMy2PvpdL5gmEbNTZGhovUECvVCgfvXbYLF0BPsJdNRyouXTl+6Jm5jPCvxOB9IkmBTkyLuZa+M0hjLVm5QCk7ojsBqXLmKct8Ekubo2oeNKNbJBx2GG7F9h1fK4DfY0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM47TQYUfwc+OHyaXiImZrfGlPYmPvyyUalIG4/FmJc=;
 b=JTDSnzfJF3/elyph2ywS7OG/NBQ8OQgIWWSUfkPZfu97otEey9RDQplcg83dyKrdgEzcsXAQRrXs06UmhDNu3bDdSom/PfHn0GJvYlfeMLSJRlaulJ98Xk8sQiajBnPNnEV6mSB3R/RO3t1QzBnHuwr52e90RkcbYZejgQ+G46JCR/VhKtH6jHbqUwOfMyYjRnVcZ8HyxK+K3i/gbqSFOrEWxsAfcnyYqsUbs6qeupvRtDoVuYipnftD1DwxnG6c2B2oQIJz+o9HKh+3Q073YzJv22bEu1NrKODWV4rxQ2k7B34t24wQzmtnwfcUy6jsu85w0HpI8gZWtAIZU0k0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 03:19:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 03:19:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Index: AQHbw1yUpeYjtdu/DU2o3xTJaAJiQbPU9flwgAUvL4CAAdBwAIAAb8tQgAC02wCAAOjXUA==
Date: Thu, 22 May 2025 03:19:44 +0000
Message-ID: <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
In-Reply-To: <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8071:EE_
x-ms-office365-filtering-correlation-id: 66ca3067-ff41-4966-28f4-08dd98df800b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Hf/T+ejROQUoBOMaEOCjeuGvhs+hU9RJ33PTNOuNVb+53rW2ML5v6q5xAb?=
 =?iso-8859-1?Q?BJ/reAy0MYQ8h02nWAXI5r7JksKxzLJbYtQZ785vDpUw/OkkiTF86nKse6?=
 =?iso-8859-1?Q?01tDLLgLk4vzJOaqikpLuCjTAtEB/90fVp+np2YqM4WBdsK4qpgRvqoRAB?=
 =?iso-8859-1?Q?mrBd2ABV5/+39feTUy/uMrBmLAg2VdmUzrJ4gbDRlaTThDd0Z61inVEpNw?=
 =?iso-8859-1?Q?cfuirMjDqdrr0NiJcbzqIe0YyJPJ4y3bsD2FbNrAJTiB600RwALi2yS0ZE?=
 =?iso-8859-1?Q?FWDrm1JLEW+nMrwmvF8wixsgzu71vWmPt1bcrt/ufXZdI4vhAEinor93NU?=
 =?iso-8859-1?Q?mqKlTyDzblcmoxrCyFOrCP39Y84JI7V5pogeA/x8UNuupmGnw6ZPp/rKdB?=
 =?iso-8859-1?Q?tMdD1GKKvPAzoReRUFRG1lvrvqzRgxxQpA80Js32W5MBrr9IqFK83Mo/Hp?=
 =?iso-8859-1?Q?6PSi0Ep7VHsFY59YdkBwgRAM3O3+nHvpP/TEv+qTiq8HQyH01yY7ap5EtE?=
 =?iso-8859-1?Q?BuMvxb16gahuJ1NRW6u56fGzonB9FkbhO1OBRpxLHSpS95hBI5KRTaTMrZ?=
 =?iso-8859-1?Q?zEGlVe6w6yyZdl10kSxeUm+Nth/fnHOBVQHdVOyOdgBaiZoFDkQtBGNDc7?=
 =?iso-8859-1?Q?BMT5dA7MwNlRnRpo8LpwJuVdbU7Xy9JDtxFG98QO0QH9grng6phlV8m+8u?=
 =?iso-8859-1?Q?+au8O8H3wVmHfPeV+hZvkkIN75+MG4lilhUBFI5B11VWBc1achcpO3XnOw?=
 =?iso-8859-1?Q?qPUSobhb9Uejf1IFwkpP1hSh32NTCNM5UHV1Vhr534wDGZ2jkdCVI9Lc/C?=
 =?iso-8859-1?Q?5ctcR974LVxM9ZkjYT9Qb+DzEOZzWxm60zNrKnNYc8au6FuH5vE0d7EFpI?=
 =?iso-8859-1?Q?wRaT9Jgsqq4jAF3wFwZOvPyv8tJsEOvnveDg8QCnO1CqOEVjvvkSn4gpWq?=
 =?iso-8859-1?Q?8vNyv0qvycYYX1sQs/iOYF6fNRYKzbuj0WtfC/b6WB1NufUNR28/A2x2yR?=
 =?iso-8859-1?Q?Ju6u2Rji+56dniyV2D7D3fLF/hdA8zLJPLYpuwdXOaqqOIyb1/AV9LXyJw?=
 =?iso-8859-1?Q?uRBrdzoY8VRfNMDoDzMqMBn+6jvWv2HKZEr+leVPLm34ASatJHnvzPwK30?=
 =?iso-8859-1?Q?bSXkkyvpJjy7IPQM6mWRWkmbchuoF3SNDb98REhKfR2wiHD3YmWsqpdkCe?=
 =?iso-8859-1?Q?GroQ4THPi8VsrScJnV0IRq0VrCZnACSAQ4ALQuK/cy7Obqj3IfQTGEoTnc?=
 =?iso-8859-1?Q?7FGqKOODF9H7q8bA9GI69ab4WSYLAGsEeAlIZBnK6egnVlOwuZCwrYt8M5?=
 =?iso-8859-1?Q?wYEKTCmGu5xKvfGH9iar+ASK5zsqIgaG4o3/5eD2mMlCIz5+hRtRt6V7Kw?=
 =?iso-8859-1?Q?aDidLxDqskeJ4dijnNMC/W5szXZXipNMaMkImEaY6SRf9z3a+NCTfKJtzK?=
 =?iso-8859-1?Q?NuU76yfYe434NOHPIx7zb8WC9/PgiB4xkejQkCqmKNNxzTHh6IkrI5JG9l?=
 =?iso-8859-1?Q?jpPG0Paj0MMzxABEHKxyVA6HtBKeTFK+Q0U8LULxV5uAi34rxDw4iVlp73?=
 =?iso-8859-1?Q?ad29BNg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HaPkPxjKpzTQ6LyWT55iO2IuVjk6wxGbXdbGggaqYL+CGDFief1tMxrpjS?=
 =?iso-8859-1?Q?PkUkUXl2hH2ft099Y2uVLvxu163jMOS5n+zq0tmOEIT51/wbRNM7kBSOeg?=
 =?iso-8859-1?Q?q1gPKvWKWmyeigTlacSnje+58X4YpfpJcbO6NEvJqN+G/dzQSri6Dtiz8B?=
 =?iso-8859-1?Q?6NN6cPwl4As9ThlaGyKDOcb3TcuHlEDONM+H1MeN2x4YE4jabeeIKvBfMP?=
 =?iso-8859-1?Q?oqPgAI1A4dx58x7Ut67+zr2wDt4pVV6wxphMV0YlQOxu6lMYbn8EArFvGo?=
 =?iso-8859-1?Q?smNNlI8nXET8zDzPVIOb1C6hsRK3jRcuqPn5wuOkZDiM3+hAdE6i6a1gEf?=
 =?iso-8859-1?Q?1X1rhzZ/ZtaxKFqlW0Qzx7+kU8kA9XJ8RzMf1Y2776P3REfUb7q6H5DSdL?=
 =?iso-8859-1?Q?OjeMRtpH8LipEz3RkZFg5WBH6gSukqUll1h1WmchpeAwJayuXP/0KTd0xT?=
 =?iso-8859-1?Q?gTAYHAOZtyt+xgYarlBhgUv/Agvh6hYE1wLebfZAdBqpf897GDen30Xj3U?=
 =?iso-8859-1?Q?gUexroKoHCbWMH8LAcJsw+v3RPWns/eYwOfA4tr6YnQsb60XCSv/sZdm5A?=
 =?iso-8859-1?Q?vWRIyGKdKZyjWiRlQFcRNd9RxW8pIYbIdAWuxRnmQ75QJPFxU/d2MSxCQe?=
 =?iso-8859-1?Q?+DvNdwYLNY6Ydssvc3JGXDmW4+ZgXZlXP2IMhc7A1d/C2bjr/43/43jsaE?=
 =?iso-8859-1?Q?+UdB6pvZQSBxhIoiDWNPwfor83mgAlfZCqyoBLe0q7iRWLjFOq2hfhIDEm?=
 =?iso-8859-1?Q?LvQTP62uhz0VCK7ZQr6E6h4FC0jqQkzIpB8je+ds5clBYX7cTS+2Bq65zi?=
 =?iso-8859-1?Q?UdiqeSoWC1hNkczCToyWBynCSSCntXX86S7JIGAMA1zc+9a0RubEBo+Qj3?=
 =?iso-8859-1?Q?lZ2cUCAmqxU/OoGV6AeGDcHPQGcpY1oHekOD4uEWjUVQgPFXnj+o6Ut4CE?=
 =?iso-8859-1?Q?5NciiriuWk/JRKi7tKNabR+r4fFgTaqzrYNL0FjR8I9hJUuudp7lNPU+nI?=
 =?iso-8859-1?Q?E4u7cD79HYFA9P8w5nT/5LyeErfBSdPrhT/X6xUX5XtYoOBfOKbykNsK1K?=
 =?iso-8859-1?Q?QW/iUidj59ufKh///loGXdgo66D0Cr5mIJWhY1gLWU0QoH0dh4vmvbitaW?=
 =?iso-8859-1?Q?huVGP9PTvrdRLRE8Ce725d15RPeeUksvoQcqozjUvP/yRjlHYWz6f7HKLF?=
 =?iso-8859-1?Q?nNVBVgxnlLkCnQnX9PzpvEu1LYeJCKfdHE0oPd451LOFxTaGrbn8Qtgjar?=
 =?iso-8859-1?Q?oZpnXySYb0jvpQrag3Al9pwsQ27zOoaB07n9tlYsaKAQowgIeuflGYAq+q?=
 =?iso-8859-1?Q?WiUCqwT1MujxMVmgzva6egEqRry07gFkJf+mTD1vxXqKWCp2weFUqos3tz?=
 =?iso-8859-1?Q?cTFx9OPl1SZ8j3ZNaQXI1cM21FNkJ3V3RovICHAmzInQCfxEmr83VsCwJJ?=
 =?iso-8859-1?Q?oXmFTS2Qf4APVdtxLwRdChe8Osz/C8R++0nWGcRmQLAhwKg4RqX+J566p9?=
 =?iso-8859-1?Q?5fR0nm0q/PyoOekv0dcxdZZJjN8A1wpBIWRMmr5Kkximq739kVF3vdnKyp?=
 =?iso-8859-1?Q?UpiuuT1iUTnVpZKX0shnK6K8NfpYkADCvX92UfwCGK6HW/LvPD8Kt8A2YV?=
 =?iso-8859-1?Q?5xYI0l6vlOOGQF9V2gjp3KEvwTMV8lBhv6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ca3067-ff41-4966-28f4-08dd98df800b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:19:44.7436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5X1LQ2OXWBJbcYmPyvlnDANhnP59al903Y7H0yKhUPgc1aaAkQwYEmUTpVZ+SJUG7bkBIpY5ZL7jnXt/RIB8fFtNhHGgQg+jZnTjEqVr5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>
>On 5/20/2025 11:11 PM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steven Sistare <steven.sistare@oracle.com>
>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>
>>> On 5/19/2025 11:51 AM, Steven Sistare wrote:
>>>> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>
>>>>>> Define the change process ioctl
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>> backends/iommufd.c=A0=A0=A0=A0=A0=A0 | 20 ++++++++++++++++++++
>>>>>> backends/trace-events=A0=A0=A0 |=A0 1 +
>>>>>> include/system/iommufd.h |=A0 2 ++
>>>>>> 3 files changed, 23 insertions(+)
>>>>>>
>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>> index 5c1958f..6fed1c1 100644
>>>>>> --- a/backends/iommufd.c
>>>>>> +++ b/backends/iommufd.c
>>>>>> @@ -73,6 +73,26 @@ static void
>iommufd_backend_class_init(ObjectClass
>>> *oc,
>>>>>> const void *data)
>>>>>>  =A0=A0=A0=A0 object_class_property_add_str(oc, "fd", NULL,
>iommufd_backend_set_fd);
>>>>>> }
>>>>>>
>>>>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>>> +{
>>>>>> +=A0=A0=A0 struct iommu_ioas_change_process args =3D {.size =3D size=
of(args)};
>>>>>> +
>>>>>> +=A0=A0=A0 return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>> +}
>>>>>> +
>>>>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>>>>>> +{
>>>>>> +=A0=A0=A0 struct iommu_ioas_change_process args =3D {.size =3D size=
of(args)};
>>>>>> +=A0=A0=A0 bool ret =3D !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &a=
rgs);
>>>>>
>>>>> This is same ioctl as above check, could it be called more than once =
for
>same
>>> process?
>>>>
>>>> Yes, and it is a no-op if the process has not changed since the last t=
ime DMA
>>>> was mapped.
>>>
>>> More questions?
>>
>> Looks a bit redundant for me, meanwhile if iommufd_change_process_capabl=
e()
>is called on target qemu, may it do both checking and change?
>>
>> I would suggest to define only iommufd_change_process() and comment that
>it's no-op if process not changed...
>
>We need to check if IOMMU_IOAS_CHANGE_PROCESS is allowed before
>performing
>live update so we can add a blocker and prevent live update cleanly:
>
>vfio_iommufd_cpr_register_container
>     if !vfio_cpr_supported()        // calls iommufd_change_process_capab=
le
>         migrate_add_blocker_modes()

This reminds me of other questions, is this ioctl() suitable for checking i=
f cpr-transfer supported?
If there is vIOMMU, there can be no mapping and process_capable() check wil=
l pass,
but if memory is not file backed...
Does cpr-transfer support vIOMMU or not?

QEMU knows details of all memory backends, why not checking memory backends=
 directly instead of a system call?

>
>How about I just add a comment:
>
>bool iommufd_change_process_capable(IOMMUFDBackend *be)
>{
>     /*
>      * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
>      * This is a no-op if the process has not changed since DMA was mappe=
d.
>      */
>
>- Steve


