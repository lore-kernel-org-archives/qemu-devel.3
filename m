Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D76BC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riJlT-0000sl-UK; Thu, 07 Mar 2024 14:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riJlS-0000sc-Tj
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:50:50 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riJlP-0005OB-Hw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709841048; x=1741377048;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NtI+KsQi184Y0C/jzp1uVUUyHusKIksOFBLxFpr2t2I=;
 b=aH8mVk+HMV9ANo/pAITEc0YVmyAJYyFvSKB9qYSY8nLzrVA0hamB/H+M
 yQ3RPC9jeLYk2TSwKNIlwfmr2I7DgrlfLju/Yg+Pa17iNQ6fp4pGXiEXI
 WhLYgQ28JgANvvhASmqZQowei7ruhvsEnkVuTtd/8SPJEvFs7QX2aRx8w
 +eK1xt7tPO1E4G3/I+jnhyhIDbcg0ge4E7up61cbXeimghPszh9mZms+L
 NOiZh5m8EhZD//+HEJs58uPhpnYyRja8WeokKnE/cwQUJo6YU17m86WGy
 Liug4DoyLu7YpdVYiTnUzqYUwnaXb+WF1lTQBWQM79eAQ66ikkg/XUpPl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15680433"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; d="scan'208";a="15680433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 11:50:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; d="scan'208";a="14790166"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Mar 2024 11:50:44 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 11:50:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 11:50:43 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 11:50:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK3SOPqk4TJlLamppXJs0fSo7jTPrYGMam2q+MgbFnAukfsPLLW7m481vA8b8sl8iepOUwr4gEKK702Rk6FOnCTjKLhlhcsgYzkDeAUawhJLHbIGhzWsoH/m7DEGQX8Mjq2Rr8Pl6OMIjNLGPbC1m+/PZeH1yntZ4aromBXsItB1Lh0MUVLAFBvd1AEeO9GfdAGXK88Thasi+6vc90XPFupXaPp2u4dsTGDaxKTikz98ku5HaYtb1kPRo+66s7ocr5B0c9R5tqx7xsNYLYWfBpA64vR3+FAn1woIJHt1eXry/e2+hrqVIrpe6s21TJuprklT5xijb3zRd0TxaO0Psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtI+KsQi184Y0C/jzp1uVUUyHusKIksOFBLxFpr2t2I=;
 b=X5oCHFoxGkL5legRjRclklka51GXH9u6vq5BZ7qL8Az6t1jbBkTZYry57+ON0G5XEQtblpPQS1P4NWWIVP1g80bU7MCLevL8VpDmqQl/b3us420Ee8vpHDHjquBGz837EidfnrOuUbBjFN62i7Rbgz5+3rw5J1vGbladOnlq/FaVd8uPbryDBX84dKLGxv/Nk+ypaNOHFjVZb2xlFV2jZ5Fx1J+Kads6gPCVdsAq4T+4qqrlUHiSCbxl496L/FPw9lH9qu06MR0P0xyv7eHyLSJAuPdRYL/1W/56Yn7KrbQ7D7xuWbm2sfjNFZtoIoFbhiYLdmjQFbhP7TaKcwgu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:50:35 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 19:50:35 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
Thread-Topic: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
 VC is invisible
Thread-Index: AQHaU9fcRg8sk5PypUazkJHR2gMsqbDzgQeAgADEP6CAAMa/gIAAyKaAgDZsN4CAAILtEIAAB2qAgAAd1KA=
Date: Thu, 7 Mar 2024 19:50:35 +0000
Message-ID: <PH8PR11MB6879B1C5AC3224722D8542E6FA202@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
 <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
 <PH8PR11MB6879524941306A7B3FB17EE2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+4f7=GAa8gOhH+=Qv5WAQrypa=83R-+RVEAo4JjknLSw@mail.gmail.com>
 <PH8PR11MB6879AF46B1B0A31E68D146F9FA432@PH8PR11MB6879.namprd11.prod.outlook.com>
 <ZemM45aJdtzx9LH2@redhat.com>
 <PH8PR11MB6879A43FEDABBD1307861429FA202@PH8PR11MB6879.namprd11.prod.outlook.com>
 <ZeoA78gWLSuntQ1V@redhat.com>
In-Reply-To: <ZeoA78gWLSuntQ1V@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SJ2PR11MB8369:EE_
x-ms-office365-filtering-correlation-id: 38ebdaf2-20d0-46aa-bcf2-08dc3edfdb41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYJCX1VUU0B+P8RTlhAeg3YbCOGxzPVPAAtN0P50BiP7O98p6Ndoqe3ARlDRSfDRhIXzaztqKRJehydCXfOHo6lGz4Y8cWnCkvxLYMeMz1cPXMIP0wY75wnDFhbe6uSusAUfEC3ajs0decatiqkQhXq5v6UQuRIfRRo5uFjHffKEo3mk5NKJUhP3zAgzfgCNr7jCQIm4z/EbKC1PlpOYo/XvDzNNqaj8z0gMuU0U/dRwUZ62CBP5qPcyz63RAcpbCBPMB6G1JC5+pOSeQOHRDc49FzP3YnSd3e8dbUvN07ACibaSW1b3tvTjZilx+Wb+++Y6u+cO4ov3u5WYaOWyZEMmhMSWwmVWtKi59kmAU6lQZ4Ff71KgV9Df8d+r97l10OW/sIH36JTOK49IAQq7cPGDew4lscWDAAHd2NGEmfaGj8S/eUSXswHHuqChspUY9pupODqSH5JwpdOo2LWW1DVV9rJSyPBGeeaF0+oxZNYtR66FY9SGfkMhYwNYReP44aw59YL1qwUUH7fnQPqSNQn8oyUCKhbuUTDu0S1yriF+OZzNxVWK3WYvYblov9+G/xYpHZ02AFHWOwbHsAu+SwYUXqObLmY5xj1jeSytsx1oXudhr3eOkJ8pSPNFrGOViZcFP51KorhgO8lhctnxCFhVFzHBQib7ojQDtz8g+CRnwBuLI7buk+BRovlLv5fF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlUzQWVJYjNtSjc1aEhHRkM5d1NHTjBSK3hxQlNDUTJIM0hHYU5TTFU5Q21G?=
 =?utf-8?B?TlR0cnA1OHBJa0JFUGtYL0Nua2ZrUzZvYkNzK1laUEhVcTFzQ3hGNE1scC9X?=
 =?utf-8?B?RXRQNXYzTTAxcjZBclM5Q1U5SUlwMlBYVjRkSDlGQXFuTG5mZUc3d3ZJNUxv?=
 =?utf-8?B?MWErM1ZVY2RodjV2cU1lSkNjKzN1c2pCWWcrT3BKNisvZVI5MDJjNFJnc2Zv?=
 =?utf-8?B?WUoxZVBvRUF4M2libVE4T0FsZm1hcStWMkpXUnZNYVhOa3djdC9MTzNVeEk3?=
 =?utf-8?B?S1plNDhIWVZJclA5d3NPT0tQZE9MZHFHU0J0Nk1TME5aWWlmdVFTOWF4Q1Bt?=
 =?utf-8?B?b2VOK3dhV29aM0xiU0s4bk04NE1kV1dFZEtvVk01bnNSWXpDWWFPVnJKbjlT?=
 =?utf-8?B?aDVTc2dtbTdlaXFQS2FlN2hMai9qWnV2UWZ0NE1razEzVWp1cTNSRFlMV2ZS?=
 =?utf-8?B?QUtvUVF4RjVIT1VGb1dvL0ZZUlNXSE1zQWw3ektudnFVYjhTeUc4Sis0VE8r?=
 =?utf-8?B?NTdmNW9Wa3J5b0pBVEx3Nmk2YzVCWkpJY0hkUnVkdUE4ckJrbjNhUU8yaDRQ?=
 =?utf-8?B?NENxeSs0RXF6cEtqUStZbUFGNVFabVByWVdsRStJRFJJYnZPSzhUajVsb0RN?=
 =?utf-8?B?UTd3V0p4aUtGdnIyWUxoQkRaZ29rNi9LdmNxN21FNzRmbG1lN3hUZXRYTzZr?=
 =?utf-8?B?K2UzR0NaR3kyNDUzcUtoZ2dQMGR5dzZrVG5RVjBKRkt2d2RnMGtUeUphZml3?=
 =?utf-8?B?cmhhenZzTnl4MUdNcytIQlgyY3VDN21OS2JyQmZvaTNUMkp1aHRWWEJySU41?=
 =?utf-8?B?bm1vQkVNOSt3LzdwdzFCRnRGVXlWTEtoTGNGRmtrdmxHTHdTOUtOdXFZMkNH?=
 =?utf-8?B?enFZN3ZLT2VqaFFrMzB6TXkyRU5mNDZWR0ROTEhQNE9EWW5BOGZKUUZTVTJi?=
 =?utf-8?B?c2l4aDlWR2YyN1RHRTZiQUlTZGcwY2lDUkZ3eTRzcXBUZmFMTDNieFJ0Smo3?=
 =?utf-8?B?SmQ3VWxEcExCaDFLNUJJN0hldjZqeWNVWmEwVmhvNE4yeXJvY1lYQUp0WXlR?=
 =?utf-8?B?L2lWQTI0eW5ucks2RThWNDRPNEtBcU8vOHRKQXBVQ2FTR2dZWWpkSXVsQlly?=
 =?utf-8?B?bFlzQTBhU2xJalJEK25HTlJXQnl5VTRCQ0kwQ21uOVU3aGFqUm5GaFYrVFIr?=
 =?utf-8?B?MEhwMkoycVJTMDFOM1FTV2xaeWN4aVVUcEE4RlRTNlNPbGUwd1FyeXY5UDBy?=
 =?utf-8?B?UjMzT0NGUG5rMUMxUmNIVlZKOU5MVVZWVW00TTdwMzhvMFp4dXZKRHpDWFU5?=
 =?utf-8?B?NWtuRzlySUM3WFE2QnVjWDJQcmtNdVlHakpCN0FTUGx3M3NjQ1RKdGJiQ3Nq?=
 =?utf-8?B?MGNKT2ZXM0QwcXVzbk1ISnJoem5pUDRBR1FyTGJHanRJOUMxQWFXOGdqUUtJ?=
 =?utf-8?B?b3FBK1kwU0N2R0xlczNEZkI5NlJHYnJrTFZIdW12TnREUW9hNlN3N3g3angy?=
 =?utf-8?B?VFlqYS94cDZQMHBzQ1pWd2p3a1pxNmZXQzZQYTBEczZ2Ym5sZGxSb3FYSlJj?=
 =?utf-8?B?L1RmMlFaSGQ3RXZvc3pPekhPNUJpVHU1NFFTaE5SVXlUNGZMTVB4TVFoMk1p?=
 =?utf-8?B?TWx1WWF2b2hIMzNXU1RvTTNPZ1hEbnRjbXI5cC9UNE0xZkNGTmpnbDVJZXkz?=
 =?utf-8?B?WXNnRGxydGwyYzAwT0pDNEtEUllSWUpZaXRoWVJicW1wMlg1S0JrRWNNMTZ1?=
 =?utf-8?B?RVM1ak9RYVI2SUdNNzBMaitySDJQOWlUZ3hJenFyWXhTU1krUHFQSFJsK2lC?=
 =?utf-8?B?azBaZlJxVlVxRDBFaWt1RGNmVllzYlQrR2ZhOGwyNy9ndHFYaWdDNStxeXVw?=
 =?utf-8?B?OUYxYy9MN3oxNGF1YkJxZFFLdFkxYXJmTEl1amlPMGYzbUNpVEd3bkdGUkpy?=
 =?utf-8?B?azA2NUZITzdrL1ErbGk3NE9QSlFRMjlaRDZPcG5GRTF5Rk5IbWxhaWRqcEJy?=
 =?utf-8?B?OWRPUmNGQ1Z0QTNUa1pOYytHb0pnbDc0Y09FQmZTZ3drQkhabkFMMkE0WjBE?=
 =?utf-8?B?R1BYUGhkQkcrV3Nydi9UTEQ5cjN1SXBrbEdiVnZ6bHJqNlBHL084cThqYytX?=
 =?utf-8?Q?pGzGcDEuxhfea/SEpDqvuJmH7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ebdaf2-20d0-46aa-bcf2-08dc3edfdb41
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 19:50:35.6534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRG5aKsxK6sRs2MCTtQoa8wZi+nByf/WK1XOqu6YQ+BZq0hOWknbjH07VvA3v5MLMaWTC4QnFGrK7sibxL+Rcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCA3LCAyMDI0IDEwOjAxIEFNDQo+IFRvOiBLaW0sIERvbmd3b24gPGRvbmd3b24ua2ltQGlu
dGVsLmNvbT4NCj4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUBnbWFp
bC5jb20+OyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8zXSB1aS9ndGs6IHNraXAgZHJhd2luZyBndWVzdCBzY2Fub3V0IHdoZW4gYXNzb2NpYXRlZA0K
PiBWQyBpcyBpbnZpc2libGUNCj4gDQo+IE9uIFRodSwgTWFyIDA3LCAyMDI0IGF0IDA1OjUzOjI0
UE0gKzAwMDAsIEtpbSwgRG9uZ3dvbiB3cm90ZToNCj4gPiBIaSBEYW5pZWwsDQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFu
Z8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIE1hcmNoIDcs
IDIwMjQgMTo0NiBBTQ0KPiA+ID4gVG86IEtpbSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50ZWwu
Y29tPg0KPiA+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUBnbWFp
bC5jb20+OyBxZW11LQ0KPiA+ID4gZGV2ZWxAbm9uZ251Lm9yZw0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzNdIHVpL2d0azogc2tpcCBkcmF3aW5nIGd1ZXN0IHNjYW5vdXQgd2hlbg0KPiA+
ID4gYXNzb2NpYXRlZCBWQyBpcyBpbnZpc2libGUNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEZlYiAw
MSwgMjAyNCBhdCAwNjo0ODo1OFBNICswMDAwLCBLaW0sIERvbmd3b24gd3JvdGU6DQo+ID4gPiA+
IEhpIE1hcmMtQW5kcsOpLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgZmVlZGJh
Y2suIFllcywgeW91IGFyZSByaWdodCwgcmVuZGVyaW5nIGRvZXNuJ3QNCj4gPiA+ID4gc3RvcCBv
biBVYnVudHUgc3lzdGVtIGFzIGl0IGhhcyBwcmV2aWV3IGV2ZW4gYWZ0ZXIgdGhlIHdpbmRvdyBp
cw0KPiA+ID4gPiBtaW5pbWl6ZWQuIEJ1dA0KPiA+ID4gdGhpcyBpcyBub3QgYWx3YXlzIHRoZSBj
YXNlLg0KPiA+ID4gPiBTb21lIHNpbXBsZSB3aW5kb3dzIG1hbmFnZXJzIGRvbid0IGhhdmUgdGhp
cyBwcmV2aWV3ICh0aHVtYm5haWwpDQo+ID4gPiA+IGZlYXR1cmUgYW5kIHRoaXMgdmlzaWJsZSBm
bGFnIGlzIG5vdCB0b2dnbGVkLiBBbmQgdGhlIHJlbmRlcmluZw0KPiA+ID4gPiBzdG9wcyByaWdo
dCBhd2F5IHRoZXJlIHdoZW4gdGhlIHdpbmRvdyBpcyBtaW5pbWl6ZWQuDQo+ID4gPg0KPiA+ID4g
VGhpcyBtYWtlcyBtZSBwcmV0dHkgdW5jb21mb3J0YWJsZS4gVGhpcyBpcyBwcm9wb3NpbmcgY2hh
bmdpbmcgUUVNVQ0KPiA+ID4gYmVoYXZpb3VyIHRvIHdvcmthcm91bmQgYSBwcm9ibGVtIHdob3Nl
IGJlaGF2aW91ciB2YXJpZXMgYmFzZWQgb24NCj4gPiA+IHdoYXQgM3JkIHBhcnR5IHNvZnR3YXJl
IFFFTVUgaXMgcnVubmluZyBvbg0KPiA+ID4NCj4gPiA+IFdoYXQgeW91IHNheSAid2luZG93IG1h
bmFnZXJzIiBhcmUgeW91IHJlZmVycmluZyB0byBhIHRyYWRpdGlvbmFsDQo+ID4gPiBYMTEgYmFz
ZWQgaG9zdCBkaXNwbGF5IG9ubHksIG9yIGRvZXMgdGhlIHByb2JsZW0gYWxzbyBleGlzdCBvbg0K
PiA+ID4gbW9kZXJuIFdheWxhbmQgaG9zdCBkaXNwbGF5ID8NCj4gPg0KPiA+IFtLaW0sIERvbmd3
b25dICBJIGRpZG4ndCBtZWFuIGFueXRoaW5nIGFib3V0IHRoZSBjb21wb3NpdG9yL2Rpc3BsYXkN
Cj4gPiBzZXJ2ZXIgaXRzZWxmLiBBbmQgSSBhbSBub3Qgc3VyZSBhYm91dCB0aGUgZ2VuZXJhbCBi
ZWhhdmlvciBvZiBXYXlsYW5kDQo+ID4gY29tcG9zaXRvcnMgYnV0IHRoZSBwb2ludCBoZXJlIGlz
IHRoZSByZW5kZXJpbmcgd2hpbGUgdGhlIGFwcCBpcyBiZWluZw0KPiA+IGljb25pemVkIChtaW5p
bWl6ZWQpIGlzIG5vdCBhbHdheXMgdGhlIGNhc2UuIEZvciBleGFtcGxlLCBJQ0UtV00gb24NCj4g
PiBZb2N0byBMaW51eCBkb2Vzbid0IGhhdmUgYW55IHByZXZpZXcgZm9yIHRoZSBpY29uaXplZCBv
ciBtaW5pbWl6ZWQNCj4gPiBhcHBsaWNhdGlvbnMsIHdoaWNoIG1lYW5zIGFsbCBkcmF3aW5nIGFj
dGl2aXRpZXMgb24gdGhlIG1pbmltaXplZCBhcHANCj4gPiBhcmUgcGF1c2VkLiBUaGlzIGlzIHRo
ZSBwcm9ibGVtIGluIGNhc2UgYmxvYiBzY2Fub3V0IGlzIHVzZWQgd2l0aA0KPiA+IHZpcnRpby1n
cHUgb24gdGhlIGd1ZXN0IGJlY2F1c2UgdGhlIGd1ZXN0IHdvbid0IHJlY2VpdmUgdGhlIHJlc3Bv
bnNlDQo+ID4gZm9yIHRoZSBmcmFtZSBzdWJtaXNzaW9uIHVudGlsIHRoZSBmcmFtZSBpcyBmdWxs
eSByZW5kZXJlZCBvbiB0aGUNCj4gPiBob3N0LiBUaGlzIGlzIGNhdXNpbmcgdGltZW91dCBhbmQg
ZnVydGhlciBpc3N1ZSBvbiB0aGUgZGlzcGxheQ0KPiA+IHBpcGVsaW5lIGluIHZpcnRpby1ncHUg
ZHJpdmVyIGluIHRoZSBndWVzdC4NCj4gDQo+IEkgZ3Vlc3MgSSdtIHdvbmRlcmluZyB3aHkgd2Ug
c2hvdWxkIGNvbnNpZGVyIHRoaXMgYSBidWcgaW4gUUVNVSByYXRoZXIgdGhhbg0KPiBhIGJ1ZyBp
biBlaXRoZXIgdGhlIHRvb2xraXQgb3IgaG9zdCByZW5kZXJpbmcgc3RhY2sgPw0KPiANCj4gTGV0
cyBzYXkgdGhlcmUgd2FzIG5vIGd1ZXN0IE9TIGhlcmUsIGp1c3QgYSByZWd1bGFyIGhvc3QgYXBw
IGlzc3VpbmcgZHJhd2luZw0KPiByZXF1ZXN0cyB0aGF0IHdlcmUgZXF1aXZhbGVudCB0byB0aGUg
d29ya2xvYWQgdGhlIGd1ZXN0IGlzIGlzc3VpbmcuICBJZiB0aGF0DQo+IGFwcGxpY2F0aW9ucycg
ZXhlY3V0aW9uIGdvdCBibG9ja2VkIGJlY2F1c2UgaXRzIGRyYXdpbmcgcmVxdWVzdHMgYXJlIG5v
dA0KPiBnZXR0aW5nIHByb2Nlc3NlZCB3aGVuIGljb25pZmllZCwgSSdkIGJlIGluY2xpbmVkIHRv
IGNhbGwgaXQgYSBidWcuDQo+IA0KPiBPciBhcmUgd2UgcGVyaGFwcyBoYW5kbGluZyBkcmF3aW5n
IGluIHRoZSB3cm9uZyB3YXkgaW4gUUVNVSA/DQpbS2ltLCBEb25nd29uXSBIbW0uLiBZZWFoIHRo
YXQgaXMgYSBnb29kIHBvaW50Li4gSWYgbm9uLXJlbmRlcmluZyB3b3JrbG9hZCBpcyBibG9ja2Vk
IGluIHRoZSBzYW1lIHdheSwgdGhhdCB3b3VsZCBiZSBhIHByb2JsZW0uIA0KPiANCj4gSWYgdGhl
IHByb2JsZW0gaXMgd2l0aCBkcmF3aW5nIHRvIGEgaWNvbmlmaWVkIHdpbmRvd3MsIGlzIHRoZXJl
IGFuIGludGVybWVkaWF0ZQ0KPiB0YXJnZXQgYnVmZmVyIHdlIHNob3VsZCBiZSBkcmF3aW5nIHRv
LCBpbnN0ZWFkIG9mIGRpcmVjdGx5IHRvIHRoZSB3aW5kb3cuIFRoZXJlDQo+IG11c3QgYmUgc29t
ZSBzdXBwb3J0ZWQgd2F5IHRvIGhhdmUgZHJhd2luZyByZXF1ZXN0cyBmdWxseSBwcm9jZXNzZWQg
aW4gdGhlDQo+IGJhY2tncm91bmQgaW5kZXBlbnQgb2YgaGF2aW5nIGEgdmlzaWJsZSB3aW5kb3cs
IHN1cmVseSA/DQpbS2ltLCBEb25nd29uXSAgSSB3aWxsIGNoZWNrIHdoYXQgb3RoZXIgb3B0aW9u
cyB0aGF0IGRvbid0IGxvb2sgbGlrZSBXQXMgYXJlIGF2YWlsYWJsZS4NCg0KPiANCj4gV2l0aCBy
ZWdhcmRzLA0KPiBEYW5pZWwNCj4gLS0NCj4gfDogaHR0cHM6Ly9iZXJyYW5nZS5jb20gICAgICAt
by0gICAgaHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9waG90b3MvZGJlcnJhbmdlIDp8DQo+IHw6IGh0
dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAtby0gICAgICAgICAgICBodHRwczovL2ZzdG9wMTM4
LmJlcnJhbmdlLmNvbSA6fA0KPiB8OiBodHRwczovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0g
ICAgaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2UgOnwNCg0K

