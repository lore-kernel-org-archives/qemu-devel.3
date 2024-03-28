Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF3EC47DD9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 02:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfZR-00008t-2L; Wed, 27 Mar 2024 22:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpfZO-00008K-QT
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:32:47 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpfZM-0001UP-7S
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711593164; x=1743129164;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HZ8U3+yzhSoBeG8jwDqDY2/90l4anBdU1sSyL1ZW6Uo=;
 b=huItwQrg552yJYWza6mm/K3v70lO0Kk3dJSWou/DsDwLptumiezYMIpu
 5A9FjH1/HGWjs23NRDl5a6J02LTg8XDrkRWGlapnFgHQ56ctYPo3HOqlc
 o9Z25IhuiFeIOPeqPNGeJvcC76hazbX25Meg9FCuxHKsfaBrJ9DeuMy/L
 y4gyHFPQwqBz8U9yeM1PjxxIvbOOjUynO92qpl8owlrRA6U/adP0ArSET
 oIJib4bvhZCJ0sc+uMM47KDqRgRxJ+UbGJT1vrmZSVkrYXEHjbbM4Tcko
 3jCBIL6PIxXsAhtr5sg8ak2/02fFUq4YlAvRfl05PXw0qk1VQnuX4pgtj A==;
X-CSE-ConnectionGUID: /8/tPsGNSfuHO5L+567tPw==
X-CSE-MsgGUID: EVsxIVUUQG2JDUd+XWn+ZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9690569"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="9690569"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 19:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="21218034"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2024 19:32:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 19:32:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 19:32:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 19:32:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6mRkx8DvBYsPvAjRoAaQIxoD411iN4zSH8yj+xlkMQxUrcRYCUWxOsBdnhrZXZRY7UYIl/5IzGiRgRrh7iFJyJRIF3FAv5vGroS0oVleZD6jvqCL00Dz+hgshOzgi9Qbg43cwZ3mxNWiRZct0RkGU0E6mhkLvICBggavebhe+FhxAV0yklKvQix6+HkasCuszWAgyF8p0E/WSORoLrKDLXiDZo6AxDji5xWvonkNTpXOdDUspawa9k3ye4UkBLP+AueooC8fsl51SHbvjkiMOprQQnRh1GcJsobHQo180EAb5GiTpMAYxdk0fOkeJqTheqmfoquR1FUJ/PkSX2k5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ8U3+yzhSoBeG8jwDqDY2/90l4anBdU1sSyL1ZW6Uo=;
 b=f7ObSo5QICO2oQNCk4l76efzT0mIdKWDIOUU0h6cDYmamZsqCmcWJAO/eSqZddtb5KfdEIkRuPsLf7IUscqsfqiWQYoW8gARKi9mdBYjOrDJkE2GS+QM1i1Vg12l25I7FrPiL7QuVYTAYsS0kHuUtIF8xXBmFEmpNbGtFj4FuMJPEpZM61HSQieRNxPWKvBjL5SrNrPl2QVA6bYLR9zaSl7IuJJ1/ae/RtVY2AxI2c+OGECEngP75V0sDC8sIkYa2TBxrpPMYOPeOjrY41EEeS7ce/TN0cPRg7rYA09ocIaT7NCfdOkv1YVs20CdemcK43OJK3/W2Es82up34dCmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Thu, 28 Mar
 2024 02:32:37 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Thu, 28 Mar 2024
 02:32:37 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHaeqFFcriI4s02jkWbmxh5d6Bh27FAcVgAgABDk6CAAA4OAIAACKEggABKaQCAAFH34IAA63wAgACmUnCAANqGYIAAJb8AgAgJ4oCAAGvF4A==
Date: Thu, 28 Mar 2024 02:32:37 +0000
Message-ID: <PH7PR11MB59417CED1514B574523D6B1CA33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfxSAgJECCOqtGRh@x1n>
 <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <PH7PR11MB5941B5EB0C21FBFB6C8FFA16A3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zf20gJbSavpp93_b@x1n> <ZgRyxy3MhFp7PiH9@x1n>
In-Reply-To: <ZgRyxy3MhFp7PiH9@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CH3PR11MB8518:EE_
x-ms-office365-filtering-correlation-id: 9b54b0c9-5dc8-4b34-5ce3-08dc4ecf5520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwS/Ok9DR0dykvmeSjLAc9sQd3Yk+Q7+IcjL7bAx4nM2if1ftNgUQYUS8h0BwvFZHC7UAw/LdGFKc58OGYWg0VC0v4PkcvmAxtmNcDnhvBkkWrJqQlfLxjMZTobVXqUoVx2rowasCrEO30UcR/uXB7HR+u3zq7KYvs+zSk4/VIEeGo8bGQNSXI/so4bVtwCY9rlXpZmPfmeEsUNmcq0lcyPEZFiGH08ncjDzPcuWT4yOwnayKSS9SDZyZE07WCMzUzTs9P8HhLlAhFamtmxBRGRYAPpWETM1LVl3XiSTsnHGgEF/35ds9xBR+5/85NMZ+6QrtxaTOafsckdjJT1uSlDdiY/ykqK+Yyr4KKEOfBrPnYQlVrOUZja6e8Xt/tJQ6YSlLH53Dc/uLS9Ntxcum7O9n5OvuHbMlYRII29esMb5vhGHx8E0uNwkqNY8f94iun8G5l5GiAI+C4Vc353OKu9NQXv9flybUBKumo2f2ms9Kdi1Pa46wkA50Pcre5NM9eEXHR0JOeEoN2D8zgKCA7fguVILYBLTBhHwes6/+O4JcgFzhpfSr6LmEB88PduKcR/gKQBOxkzu2wCP8cPd5ArCgrtpsvaWYVQ+QazyzzfUftLVlq6fpyMhk1di4kzwnk9hMUhChdCH/C4XAdfEyFCyemicTj6Q/DDDQAj/bzweL7rJXfzsRKSJGSxZ0PohKKbSt2HMzOcB34fLR6NjmLzw83YNHcWEjumpceHe8GU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmhwVVZ6dThMa2VyL05Sb1pCazRYZ1NTemU4T0RBMFYzWUkzT3pXdEVwajha?=
 =?utf-8?B?UXB2Y1lnRk42UC9oQmJweTVaK040UWhNc1lyQk4xOWlwcFNsQUFoZTFRR2Rp?=
 =?utf-8?B?N2toMzZ4YS9ublJhQ1FSRmNnVCtDdGVwUEdnQ2tDbHM2RXgzOTcrUy9lMVp6?=
 =?utf-8?B?cFY0b1U4cXRFTWJaWGF1VXVQWUxBeThCT2xGcHozQWw1U1pmMG5pZjgwZVh2?=
 =?utf-8?B?OVJBV2ozQnpXd2NnaWNSWWlyNjhlTmphOHNaQ01ucVVCWS9Vb2piQmU0blRY?=
 =?utf-8?B?SSs5dDFvUWYyVCtpOGtRMFRLODFrVmtFcHpLSHpUVGhaRlpDRkpwK2tjREM0?=
 =?utf-8?B?UjZqcnYwNTZsNDhxck4yNE9KNFhZM3JWWS9WR3hoSXBRcjQyMGE2MEd6RG16?=
 =?utf-8?B?RDlkdS9sU3EvcFlqVllTTEpzWGNuU3UzVys3eG5SZmtCWEFPWklvMHRqZEEx?=
 =?utf-8?B?YlpkL2J1NkVNS3h6TlhnamR6SDNKU0RtZlRDRVlRSEZMbkM3SzNEU0dlTnRK?=
 =?utf-8?B?bkxmcElob1lTN2ZVaTRjNHZXUytDWmorSDJ2ZVYvalVucEF2RU1XVmUzNVpL?=
 =?utf-8?B?L2RUMlFqbWRCVVVyd1ZsbzFOeE5pR1RjWUxxbDRkT2VTYjczM0lUc3pkVHNF?=
 =?utf-8?B?U284NnJ2UDMxYWRXKzd6N0Npd1JQY1JoN3NNSUh0WmNib1g5bHFhZzVIOTZZ?=
 =?utf-8?B?ZVJpeFJoL0dqRUhyQUpOZ3Nic2VWRlZoOFAzT0lXc1ZWZHYveWRiS0h0ZTlm?=
 =?utf-8?B?anRvL1FKMlpFMlRWT0lQWG04VThLK05NWCtUQk5iVlhGSlhlb1NkTW9FTzFG?=
 =?utf-8?B?dUoraG9mUGxxcXNIbUZOU1ROMGJ3Z1N4V2pKTmdONG5oajI3OE5ZVThIdXhl?=
 =?utf-8?B?bDA1a050YnRzclB6S0lWRWdmQ0Y0bytRakVyNHYzRE9HeTNibG1IeXJPa3pi?=
 =?utf-8?B?V20yWDhmOVBjMHAzTm41cFNDaDBVTHV0dEplLzZ1RHd3ZFJDM1hNZzdLanFk?=
 =?utf-8?B?TkZidzB2VW1JTHRGMmtXWS80b1lJTEVZZTBzQXNzSkY0OTlaYXZxZ3hzQUIv?=
 =?utf-8?B?WW1GbDFUVGpWZC8rNmFHS2NUYlBlUzBTR1hTTmNtdGhiZmFzajBWdU1WRXFK?=
 =?utf-8?B?cG5qM1RCT2RkdVZ5QzdPd3haNG9kNjhHMnBDZkluT2dTTVBEUWx2RThvTzg4?=
 =?utf-8?B?YkdaTjdiMnhkdU40SDc0cEZEWVFFdjlVNnVwbDZxUkdBTU11VFZsU3g4SUUy?=
 =?utf-8?B?d2o1ZHJReThGTGNyU1k1UC9YTkpGN3RDZXR0Ym9CQXAwYnFFZ1RIOEtVWEFz?=
 =?utf-8?B?aUZpd1dlVTZCcFl5MlUxdzMxUWcrQys2NHBMdHJXZXdRL05IN3pWOFpjcWZB?=
 =?utf-8?B?LzJGdzF2dWR1SWYwVjlTOGVxVWdLM0JrTmg0dVN1c0ZNb3FFQXlHMGw1aEJP?=
 =?utf-8?B?emlqSEZNRytZQ2I0aGRIdko5Wk15NkVJeU9lYStBVFM0a3F0NGJEdWM2YnlR?=
 =?utf-8?B?YmdRNzZMVFowanp5NEF6ODY2R093eVIzSEJQTWVCbjh0OUxlcnZyUUF6NXpR?=
 =?utf-8?B?LzRIcGFvNlEyTVdHVkNLZDZFNnVud01ZbjRxSXExZkpnd05FMTBPRE1xeVV6?=
 =?utf-8?B?ODB4NFc3YnpYMU55MjhHcm51T2Z4dmhaM2pSL08vTkFtRlBHWFZHckxETzVE?=
 =?utf-8?B?TThvS2RRWFNoRlU4VzFKSUsrS3krMURKSC9hQW9rSzVGWDIvN1Aranh0YnNI?=
 =?utf-8?B?NTJqZ2kwZmJoZGlpYjJhaUtZUUhkd1dDZE1TSTRZd09EVUxIUGZBUWY4WG82?=
 =?utf-8?B?aWUySS9saktjTGx4clM1WDFmQkEyTU53YkVmN0dTSXphWSsyZXE3WGkrbWhS?=
 =?utf-8?B?NTczU3Z2SWZaUGM3cXlET1R5VWV0L01GUXRlZzZVazJuelY5blpOanBzZ3VM?=
 =?utf-8?B?WGtDR3BURjQzWU1LY2sxNXpnSXM1SjhuYitUWTRvcGlGTDE4NURiaW81WUJ1?=
 =?utf-8?B?UEwySURvRWhVbkpOZ2huaXJmMXlpQWhSSDlWTWM3Rnl4djZXRVA4TXR0Q1pH?=
 =?utf-8?B?b3NxOXhLaW0vOXh0RWtieXY3ZmFRTHgvTyttRmVXUUhFeXp4R1hueWZGdlJO?=
 =?utf-8?Q?vb94mZLOJnRO1CJ6ft9j9MKwO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b54b0c9-5dc8-4b34-5ce3-08dc4ecf5520
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 02:32:37.2684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oaeaDRTboGtM80oWUThAeBvZDdvHJiBSV5avgwT2khAH4x/5K1Mi7ApQaC2ceoALh0G+htnNoOomNJpA90KaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyOCwgMjAyNCAzOjI2IEFNDQo+IFRv
OiBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IGZhcm9zYXNAc3VzZS5kZTsgcWVtdS0NCj4gZGV2
ZWxAbm9uZ251Lm9yZzsgaGFvLnhpYW5nQGJ5dGVkYW5jZS5jb207IGJyeWFuLnpoYW5nQGJ5dGVk
YW5jZS5jb207IFpvdSwNCj4gTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NSA1LzddIG1pZ3JhdGlvbi9tdWx0aWZkOiBpbXBsZW1lbnQgaW5pdGlh
bGl6YXRpb24gb2YNCj4gcXBsIGNvbXByZXNzaW9uDQo+IA0KPiBPbiBGcmksIE1hciAyMiwgMjAy
NCBhdCAxMjo0MDozMlBNIC0wNDAwLCBQZXRlciBYdSB3cm90ZToNCj4gPiA+ID4gdm9pZCBtdWx0
aWZkX3JlY3ZfemVyb19wYWdlX3Byb2Nlc3MoTXVsdGlGRFJlY3ZQYXJhbXMgKnApDQo+ID4gPiA+
IHsNCj4gPiA+ID4gICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcC0+emVyb19udW07IGkrKykgew0K
PiA+ID4gPiAgICAgICAgIHZvaWQgKnBhZ2UgPSBwLT5ob3N0ICsgcC0+emVyb1tpXTsNCj4gPiA+
ID4gICAgICAgICBpZiAoIWJ1ZmZlcl9pc196ZXJvKHBhZ2UsIHAtPnBhZ2Vfc2l6ZSkpIHsNCj4g
PiA+ID4gICAgICAgICAgICAgbWVtc2V0KHBhZ2UsIDAsIHAtPnBhZ2Vfc2l6ZSk7DQo+ID4gPiA+
ICAgICAgICAgfQ0KPiA+ID4gPiAgICAgfQ0KPiA+ID4gPiB9DQo+ID4NCj4gPiBJdCBtYXkgbm90
IG1hdHRlciBtdWNoICh3aGVyZSBJIGFsc28gc2VlIHlvdXIgYmVsb3cgY29tbWVudHMpLCBidXQg
anVzdA0KPiB0bw0KPiA+IG1lbnRpb24gYW5vdGhlciBzb2x1dGlvbiB0byBhdm9pZCB0aGlzIHJl
YWQgaXMgdGhhdCB3ZSBjYW4gbWFpbnRhaW4NCj4gPiBSQU1CbG9jay0+cmVjZWl2ZWRtYXAgZm9y
IHByZWNvcHkgKGVzcGVjaWFsbHksIG11bHRpZmQsIGFmYWl1IG11bHRpZmQNCj4gPiBkb2Vzbid0
IHlldCB1cGRhdGUgdGhpcyBiaXRtYXAuLiBldmVuIGlmIG5vcm1hbCBwcmVjb3B5IGRvZXMpLCB0
aGVuIGhlcmUNCj4gPiBpbnN0ZWFkIG9mIHNjYW5uaW5nIGV2ZXJ5IHRpbWUsIG1heWJlIHdlIGNh
biBkbzoNCj4gPg0KPiA+ICAgLyoNCj4gPiAgICAqIElmIGl0J3MgdGhlIDFzdCB0aW1lIHJlY2Vp
dmluZyBpdCwgbm8gbmVlZCB0byBjbGVhciBpdCBhcyBpdCBtdXN0DQo+IGJlDQo+ID4gICAgKiBh
bGwgemVyb3Mgbm93Lg0KPiA+ICAgICovDQo+ID4gICBpZiAoYml0bWFwX3Rlc3QocmItPnJlY2Vp
dmVkbWFwLCBwYWdlX29mZnNldCkpIHsNCj4gPiAgICAgICBtZW1zZXQocGFnZSwgMCwgLi4uKTsN
Cj4gPiAgIH0gZWxzZSB7DQo+ID4gICAgICAgYml0bWFwX3NldChyYi0+cmVjZWl2ZWRtYXAsIHBh
Z2Vfb2Zmc2V0KTsNCj4gPiAgIH0NCj4gPg0KPiA+IEFuZCB3ZSBhbHNvIGFsd2F5cyBzZXQgdGhl
IGJpdCB3aGVuICF6ZXJvIHRvby4NCj4gPg0KPiA+IE15IHJhdGlvbmFsIGlzIHRoYXQgaXQncyB1
bmxpa2VseSBhIHplcm8gcGFnZSBpZiBpdCdzIHNlbnQgb25jZSBvciBtb3JlLA0KPiA+IHdoaWxl
IE9UT0ggZm9yIHRoZSAxc3QgdGltZSB3ZSByZWNlaXZlIGl0LCBpdCBtdXN0IGJlIGEgemVybyBw
YWdlLCBzbyBubw0KPiA+IG5lZWQgdG8gc2NhbiBmb3IgdGhlIDFzdCByb3VuZC4NCj4gDQo+IFRo
aW5raW5nIGFib3V0IHRoaXMsIEknbSB3b25kZXJpbmcgd2hldGhlciB3ZSBzaG91bGQgaGF2ZSB0
aGlzIHJlZ2FyZGxlc3MuDQo+IElJVUMgbm93IG11bHRpZmQgd2lsbCBhbHdheXMgcmVxdWlyZSB0
d28gcGFnZSBmYXVsdHMgb24gZGVzdGluYXRpb24gZm9yDQo+IGFub255bW91cyBndWVzdCBtZW1v
cmllcyAoSSBzdXBwb3NlIHNobWVtL2h1Z2V0bGIgaXMgZmluZSBhcyBubyB6ZXJvIHBhZ2UNCj4g
aW4gdGhvc2Ugd29ybGRzKS4gIEV2ZW4gdGhvdWdoIGl0IHNob3VsZCBiZSBmYXN0ZXIgdGhhbiBE
TUEgZmF1bHRzLCBpdA0KPiBzdGlsbCBpcyB1bndhbnRlZC4NCj4gDQo+IEknbGwgdGFrZSBhIG5v
dGUgbXlzZWxmIGFzIHRvZG8gdG8gZG8gc29tZSBtZWFzdXJlbWVudHMgaW4gdGhlIGZ1dHVyZQ0K
PiBmaXJzdC4gIEhvd2V2ZXIgaWYgYW55b25lIHRoaW5rcyB0aGF0IG1ha2VzIHNlbnNlIGFuZCB3
YW50IHRvIGhhdmUgYSBsb29rLA0KPiBwbGVhc2Ugc2F5IHNvLiAgSXQnbGwgYmUgbW9yZSB0aGFu
IHdlbGNvbWVkLg0KDQpZZXMsIEkgdGhpbmsgdGhpcyBpcyBhIGJldHRlciBpbXByb3ZlbWVudCB0
byBhdm9pZCB0d28gcGFnZSBmYXVsdHMuIEkgY2FuIHRlc3QNCnRoZSBwZXJmb3JtYW5jZSBpbXBh
Y3Qgb2YgdGhpcyBjaGFuZ2Ugb24gU1ZNLWNhcGFibGUgZGV2aWNlcyBhbmQgZ2l2ZSBzb21lIGRh
dGENCmxhdGVyLiBBcyB3ZSBzYXcgYmVmb3JlLCB0aGUgSU9UTEIgZmx1c2ggb2NjdXJzIHZpYSBD
T1csIHdpdGggdGhlIGNoYW5nZSwgdGhlIA0KaW1wYWN0IG9mIHRoZSBDT1cgc2hvdWxkIGJlIGdv
bmUuDQoNCklmIHlvdSBuZWVkIG1vcmUgdGVzdGluZyBhbmQgYW5hbHlzaXMgb24gdGhpcywgcGxl
YXNlIGxldCBtZSBrbm93DQoNCg==

