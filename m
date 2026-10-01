Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AD8CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQBD-0001ww-8j; Thu, 01 Oct 2026 19:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCQBC-0001wf-Cx; Thu, 01 Oct 2026 19:27:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCQB9-0001VA-Qn; Thu, 01 Oct 2026 19:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790897233; x=1822433233;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UN6g+3tB0Ve2aDVh5bZJt8TrKudd+LpXQrwWpAuK1CU=;
 b=lLlDp+a19T+rzePRtaV1qsg5n8r/NNj3L2bdMEOeluvMbvoR9+Kxlduj
 cinbtp/tJAoMlzFSSfKmcfY7WeXaAwqUFXIWLsSL8uinD1ySj2SDQUb/e
 OaXQQ1+CDoD5Abb9SCok92NaW9qfBsI3dr9dIGBletO9U+Ezozpb3KL4k
 JrnJEMcSV4lnyP6ARxtk2xbEVVCq3VQxJpiNcYpnsv+T3hb4Y1M4om/9J
 pIcKdvVh2y2Um5WEE09FdO70Rn2ZpmVSOu6LMyNyEFlHfHS4DlpfgC5A3
 KkWAuYpd+SCD6PUbGUJ3vdFLUlmsi2cukBPMUqgHx2c6uV9GwCDdCvpYx A==;
X-CSE-ConnectionGUID: aW/eliYKRIuAnqwyP12oLQ==
X-CSE-MsgGUID: egKyD7f9QCWk3DYE7gdP1g==
X-IronPort-AV: E=Sophos;i="6.27,135,1786982400"; d="scan'208";a="158020820"
Received: from mail-southcentralusazon11012007.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.7])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Oct 2026 07:27:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkvOCtGmFQvC1I2dprdKL4gjabc5qEGaPdgfUeAvZVVAR2hRdGO0u7+UGRjSUYeThFLQJE4tOiPEgvOna49iqZWTaqDqMYAjOwmB1IrDVtkMOfYRBNp3H7LavdOzX65rqXjWi/izzkqJp/NVC8OBVfgW+sOdTWeHk/A61qNhafnYBp21qfotVRg8Cu8zD/Mj12gknSiw70FO+KWqAuuUhAKk+s2Nb9tALmUvmh7XbMd+J+aOTG2CpAjsGeTJtxEV1VLNb7949RG6sOfTBq4c3zpNbx5AUi3Pj/A8M6yeRiWB0iXTZramZcXYKe9FFbjjrV5vnMmAlbsVL40UGbZYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN6g+3tB0Ve2aDVh5bZJt8TrKudd+LpXQrwWpAuK1CU=;
 b=wYIPjP8AeUdLMjMx+szlLDnPgfocX0M1dr6+jU8VDmg6/0r2C95G//436TlNIa95+r90goyaHfzFoWX2nJ9LEDz55d/HozSGw7gvLC0D5bP1/Uu2VXjRjGIlSfX0XVyZXIzmjyctsrwr8wbf3MGOiDMw7vfFQq1RKAOb9BhQGEd/QJIFHUwqTIiFUj7iAjIU3VBYEIsrblwHX8SeG2GxEsh9Lc7CNHqGUuB0dkCiD9nBzDIpzTqRuKPwGzYV8DInF4MN10JipB7HFYSellScjhjlOLwUFvqyg3l/MCvEqELTdXKap6ilvU2LO1Ylgc70V/CdfSpRhTxEA8lxg4LJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN6g+3tB0Ve2aDVh5bZJt8TrKudd+LpXQrwWpAuK1CU=;
 b=hCbCbVWLjWqn2sregZD0PgczQHtEo13lp+Mi4KzMjeOCqZw3EShLoBgJoMkw5NbdCWQcqWC3yN845m9NzlWBojksbHlUDvv2Ip5fTH43NLjvoXTueDh/wbOATgoanbMYlCZYtOxZ5d/BZjjbFgTM+2oe7ep+AS3Rb3d+CB1AJCM=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH4PR04MB9313.namprd04.prod.outlook.com (2603:10b6:610:23d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 23:27:01 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 23:27:01 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH 1/3] hw/misc: fix k230_decomp_gzip integer handling issues
Thread-Topic: [PATCH 1/3] hw/misc: fix k230_decomp_gzip integer handling issues
Thread-Index: AQHdUUvR86nsKRfHmUOJTVWNqPKs17bpVh8A
Date: Thu, 1 Oct 2026 23:27:01 +0000
Message-ID: <35b8af2703f942f608f419fef23be6f6429d342b.camel@wdc.com>
References: <20261001022223.8633-1-dingtao0430@163.com>
 <20261001022223.8633-2-dingtao0430@163.com>
In-Reply-To: <20261001022223.8633-2-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH4PR04MB9313:EE_
x-ms-office365-filtering-correlation-id: cd3af324-6910-41e9-4ac1-08df20137eec
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|19092799006|366016|10070799003|3023799007|38070700021|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: yOT4vf3wxuiMua6nqp5riDsZJkuO3zLTU129a7sitmJv4kXPi2nLg2Df6oQE0KGSANTJBxH462DDa20y8zbA9J47RuQmEhDnXVS7+xEljROefRRTf4ZCBtmtVRrQJGbO4SSJP0Lz88dDD48+/Id4rerd8pskqHh+wgQWo5FvietcpmobiohEhfMed+9mZSPa2uhN5J79IV/7pL5ZiPhXPEdsg7gbGpuN0pxysZTs06JF1pdr1q6lugHbID2w6SCPa9DhbUITE0gihY7R5SWbwLJRWuM4EsZgJszKyXRn6O3AhnvR8NiWYBCihAv6Vr47i8HWkgbLrSgwJrSfMZXT8MsVH/O/Zh8dPtBD0MUL7e3cL7L7XZQisFxQLJXBSFN8Q26d9l7NTRKrobktP4SrmUIXDkynB8BidMfid7iir3c/79lrUoVe+WQHjYIZqutY3apGFqf3a5deosmzJj8TOOZ8JEpRYBIJScTB6yw/pGDW1t02xunK9JBPL8DARxND1/7S0yoHCQKaBubjog6tGnKoPjJa+yhrmn+AO+KD4R80swm2Qp88P+tTbKYYdrZn/+L1UlIh5MArNBiZzdvDj/Ojk7/o6NOEzpsRs+L7FYBK64wB46lPOIV7vTur3zolgT3jOZ//F6xEHcJirLqdoZGBzNnJAPCbUAmhk/fnVPHePSXFoP0sUawOvYkzv7kr+hDKNXP56G1j2bv6BmxCBGA23IiUuK6GNeOitv0+P5E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(19092799006)(366016)(10070799003)(3023799007)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJ2UEk0RlN3WnBsWG9PcDRIQmhzVkc2eUhBdzU4QWl2eitDUzcvVms4QkVC?=
 =?utf-8?B?UkVZNXdpa1U0WGd4aUZlQzRUTy9JWkJGZDh2Q2lpcldMVHl4MW54QmVtdFNN?=
 =?utf-8?B?QUgrb0IyclFidUhTaWY4KzdtOExDWTVrTWNXZEgya010VjV6VzhFa29MZkhn?=
 =?utf-8?B?SmU5U3h5WmlheTJaUWM4Z1hJRzJwanNBU0REaEZMWVg4NmhxKzd0V1E4eU5N?=
 =?utf-8?B?bi9xd3p3TDg0UGliRllKUEljTkprUGRQOE5FekxuZVdpclV6WGx4UkgzODFE?=
 =?utf-8?B?eEVTR1NOV2pQSGpYdzMzNkpidFdtWVRtTFpyYVQ1cjhodlVoYmhxVUNScFd4?=
 =?utf-8?B?WVZEOHZ1aGFaK3hxSUx4enVaUWNTWUZlOU84NzNsQkpIUzFMaFZOVHFnYXZS?=
 =?utf-8?B?eERzbXM3OWREZmNNWE9aV3MvZDJ6YXBwUkw1aXlMTExnTXB4T2FJakMwSStL?=
 =?utf-8?B?Ym1aMzA3SUhQN2xUd0tLbTJzYTFScU45emQ1NkhneWlqSE9QT2JPQmpLV0pS?=
 =?utf-8?B?UTZnejc1S1RwcFYweEFSMVEzMldLdVlZSjZPQ3V2OHpKTmdnMDRTRElhQ2ZI?=
 =?utf-8?B?Z2kwVDA5U001RHkvbWJ2VFkrb1FWS3ByM2ZBZlF5dXV4ZmpxTkJxNnFla3dL?=
 =?utf-8?B?UjBGdFlkYVUzcXBKc0I3ZEszQnZhTFRLWUlwRE5mYWwxaHhkb3JvcHZQWEFJ?=
 =?utf-8?B?L3gxK3U0amJSV2JlS3p1bFp1OFpKd2JWQVBQc0dsa1FOSlVkZTZzTUFCaTBQ?=
 =?utf-8?B?eTFpeERTZ0IrZk5wTDNwLzdMeXA4NXJQTXVzeUFKRWZIMjI5Nlkyb2xDakc0?=
 =?utf-8?B?LzlPL2ZsMHN1SXBFM2FHVjFQRFh1RGlTYzEyWWIvR2xqVHVGVFBVZEh4T2xF?=
 =?utf-8?B?MFkvY2l0MytXN3laVUZyUEJSUnhBazhwYlo1cUlkcXFWTWc5NDZMSlJtRXpU?=
 =?utf-8?B?U2FjeFpEVU02L28vZVFGcXFtZTRiRGJIQXhacEV4bUlUYjA1UkZOSzhjQmRa?=
 =?utf-8?B?c0h4TWhaKytsUjNBK0VCVEorTy9HSzg4b1JTT1doanA3K2RSWDRHRXU2Skp6?=
 =?utf-8?B?Y2NQb09iWE11Y2liblJZeXRYN0dFNFpBdFRPSDI3ZFkwZDI3K1JpV3pSRXN5?=
 =?utf-8?B?bFUxSURiL1BSeDhpbld4NWZROTQwVEh0d1IwcmVhUktaU2tkM0dWQjF6SzBQ?=
 =?utf-8?B?OGpQL0xkank2VVp2TWxjYzA5Y1RPZ2J1Z3FNNmJQSjdnVkwrZ2t2czZsdTF5?=
 =?utf-8?B?alJuN1RLajBIY1Y4Tm0rbFBlY2lrL2o4aXZ4MW8veWdhQ21KUTdNNkhzQ1p3?=
 =?utf-8?B?NlByMmRUMnhPMEk3WU9GNjdPbzZuRE4zNytvdmN5VHRzYU5VN2ZnWHBjWnBV?=
 =?utf-8?B?UDU0K3dESEh1bm8wR3ZLVElqanV6SW82Z1hpVFlxZWpzRWMrQmI5SUFXdmMr?=
 =?utf-8?B?T0tXazQxMkdONXNtakZ1amZ5Slk2dTMzZk5GL1lQdFBoQnB6aVQySDFHRVVJ?=
 =?utf-8?B?eDdDbkVjV09RT3Q2QWtUSFhFd2QvU0RTRk9EeG53RFJjeVpTSmxzQmNYZll1?=
 =?utf-8?B?d2F6dzA5dzNaajE1NVJHRk8vbmI1Nm0zZk9pVjBTRUNTTWwvSWRnQ0JtZnlX?=
 =?utf-8?B?UWYveGZzOEVJeHRQSWNvdjNtN0orMHdpQjZwYU5hY1QzVVNKcmJtVVUyOE5L?=
 =?utf-8?B?N2pRbTFIbzlvSWVGeE82ajcvRFVPZzhsUjJ3MTIxb2FtSmVmNXZJbFdoN09n?=
 =?utf-8?B?Wm1YM0NZRXRVd1IvMFY1WjFkRW4wc1c5VEhUODhxNURJcmZWRlg1dko0WTJD?=
 =?utf-8?B?cHZaenVrYlRFNlRIeUlrQjFNS21mZmV4eXRUb2ViNk8weGpTUXQrSFFPWXJk?=
 =?utf-8?B?OHRCdVc3bVUwN2Z4VDRaeUp4RmVyZWRiQW00MFI0VmY4M3B3YklDdDA5MEda?=
 =?utf-8?B?NU5lRnp3YndCSE1JK1JheWtHbHlzTzJ4eU9yNDR4Q1NXVTIwYUtjSXBzSS9X?=
 =?utf-8?B?MndIdTEzMnN2SjZvMEtNdWducTdzYkg4cENQdEhLV0cxMnNkTlNLd0RReS9O?=
 =?utf-8?B?a2crQW95YmU1MFJ0emxyQjVLNDFZWDc3NDlOSGJjaDloVFFoOGxEdHhjblJJ?=
 =?utf-8?B?L29QUzVRYVBxUHhEV1RjWThHdnBzdE43dXd6enM3a1RBVWxSOUU3NjY3TElt?=
 =?utf-8?B?a3dENFlvWnprWkpBSkp3TFJ4cUJpNkUxYXRQS2pyNmovNkUveHBYdzZ6RUZL?=
 =?utf-8?B?OEFSbmlZMnFOV2w0bUZiWk16Z1hWcTU1MVNOZTJTRm1hY1k0cVFOVndNWmF6?=
 =?utf-8?B?YnV1YmVKVlRDOEFycWx6WkFFMTBYMFhTcGkrazVrNnc2bW81OEpaTWJNbVVt?=
 =?utf-8?Q?BIB5s58X7uL2SrioRFc08sNZdxJ1kOCitmF3TEAFzwoKp?=
x-ms-exchange-antispam-messagedata-1: Ml3JunC0Tpu9zstozNoJDxHZsR7ZBD9M81U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76ECD94BA2678945A7D69788759910CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xVYTOUUg9FEH5ohOTvhmpLhd8EGOUpRcCpC/dgFeosopksKHknebuf7gEnjs8VIcDU6i+4AeaUwKVkwwuW9dHSTQAJsUoPtAJ2Ezz08z1oNuSqAJjwBvEQwsF+qLqneouKn0ChI35v1Y8okDvkYAa3H0jAMLd5qqTbm8AHe+b11PtFpBqqXUZSIbVH9GQu80z9oROtj+29uYYohbtOxxytvplQEMYgX3trr3OW5ZwzgvgTxbCKOoH1ebbl1xcM/qwtbZHHFWEY3UpkMsEJDO34+j4ZZ3x0INXcmpQ7bInzSRE87wswOoTkCHDdEqlQdTAGI317xD3uEJ3zdfYTCRFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: laDCMMQ46fwyipHe+/wjHbIjvJHM4KDnMpjaJi97Hhls/0jXokkpcHdacwYevrVQy/Cf657WIMIJhRAwn/h9ztCgk99e3X3D1/BncRCBLFagqj8zDa54J056hzuthFpZ2et1Zx7YWGsPMuMMRQSTg6nBXe7+kmkZw54essfW9nvIx17Kr3suUHgxh61M2er7DSgslp4tvnWdIV44Cld/bQHpf+49Z0fthYybeBH2ARPlaqfsEqdFZ39pSkXDfarhJNDfE3QJh4zMCMRseFcqOMsbupEJUUs87S1+oNTQvdOtWbfoKTcJ3mdVaekFLtqdqUw741PXiT/ayOSMVe/xJSfraExMg+Ya9fsACoWoHNuNPx2EI++JhKwBeQyXJnHHqOe6GeMeTB4LJyjZbDrjlp7cXjFdtNCKhRzUOj8xvbRHik8s3qVIn2nEVT99MxMnsrWuNdxcMwKpsN0Z7Mx+rMZ/ojUW0Psxxz1+hDtDayjXovDEjXiP+2KomSkZQoPYx9jmzXEOryivqr5kegjfBtDq0wSqR4v+eRMtfKlJ06pU7lKrhgi9J4HQ0NlC0BFnTHKLgdPU2BSXizEOjE9Eo3iOCyKL7QmrN6n83qu0NlepZOlImPvJgiZZLbCKA4FX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3af324-6910-41e9-4ac1-08df20137eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 23:27:01.5674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg2aFqhCuTol/LvfZlKSFm/xPgl2O5lFb0w0r38pH0pGVsPRSQosEkJkBoHLJb0sslmi1ytVj+e6tTAlKQGkka8sTRRcAj7/PsFiWhOLwr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9313
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDEwOjIyICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gVXNl
IGh3YWRkciBmb3IgYWRkcmVzcyBjYWxjdWxhdGlvbnMgdG8gYXZvaWQgMzItYml0IG92ZXJmbG93
IGFuZA0KPiBhZGRyZXNzIHRydW5jYXRpb24uDQo+IA0KPiBSZXNvbHZlczogQ292ZXJpdHkgQ0lE
IDE2ODU1MTUsIDE2ODU1MTcNCj4gDQo+IFJlcG9ydGVkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxB
bGlzdGFpci5GcmFuY2lzQHdkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRhbyBEaW5nIDxkaW5n
dGFvMDQzMEAxNjMuY29tPg0KPiAtLS0NCj4gwqBody9taXNjL2syMzBfZGVjb21wX2d6aXAuYyB8
IDYgKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9taXNjL2syMzBfZGVjb21wX2d6aXAuYyBiL2h3
L21pc2MvazIzMF9kZWNvbXBfZ3ppcC5jDQo+IGluZGV4IDBkOGEzYjJkMmUuLjU0MzAzYzBlN2Yg
MTAwNjQ0DQo+IC0tLSBhL2h3L21pc2MvazIzMF9kZWNvbXBfZ3ppcC5jDQo+ICsrKyBiL2h3L21p
c2MvazIzMF9kZWNvbXBfZ3ppcC5jDQo+IEBAIC01MywxMyArNTMsMTMgQEAgc3RhdGljIGJvb2wN
Cj4gazIzMF9kZWNvbXBfZ3ppcF93cml0ZV9tZW0oSzIzMERlY29tcEd6aXBTdGF0ZSAqcywgaHdh
ZGRyIGFkZHIsDQo+IMKgc3RhdGljIGh3YWRkciBrMjMwX2RlY29tcF9nemlwX291dHB1dF9hZGRy
KEsyMzBEZWNvbXBHemlwU3RhdGUgKnMpDQo+IMKgew0KPiDCoMKgwqDCoCByZXR1cm4gSzIzMF9E
RUNPTVBfR1pJUF9TUkFNX09VVF9CQVNFICsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPm91
dHB1dC5zbG90ICogSzIzMF9ERUNPTVBfR1pJUF9CTE9DS19TSVpFICsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgIChod2FkZHIpIHMtPm91dHB1dC5zbG90ICogSzIzMF9ERUNPTVBfR1pJUF9CTE9D
S19TSVpFICsNCg0KSXNuJ3QgSzIzMF9ERUNPTVBfR1pJUF9CTE9DS19TSVpFIHN0aWxsIGEgMzIt
Yml0IHZhbHVlLCBzaG91bGQgaXQgYmUgYQ0KVUxMPw0KDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcy0+b3V0cHV0LmN1cnJlbnRfb2Zmc2V0Ow0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgaHdh
ZGRyIGsyMzBfZGVjb21wX2d6aXBfaW5wdXRfYWRkcihLMjMwRGVjb21wR3ppcFN0YXRlICpzKQ0K
PiDCoHsNCj4gLcKgwqDCoCByZXR1cm4gcy0+aW5wdXQuc2xvdCAqIEsyMzBfREVDT01QX0daSVBf
QkxPQ0tfU0laRSArDQo+ICvCoMKgwqAgcmV0dXJuIChod2FkZHIpIHMtPmlucHV0LnNsb3QgKiBL
MjMwX0RFQ09NUF9HWklQX0JMT0NLX1NJWkUgKw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEsy
MzBfREVDT01QX0daSVBfU1JBTV9JTl9CQVNFOw0KPiDCoH0NCj4gwqANCj4gQEAgLTEwMiw3ICsx
MDIsNyBAQCBzdGF0aWMgdm9pZA0KPiBrMjMwX2RlY29tcF9nemlwX2ZpbmlzaChLMjMwRGVjb21w
R3ppcFN0YXRlICpzLCBib29sIGNyY19vaykNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIGJvb2wg
azIzMF9kZWNvbXBfZ3ppcF9sb2FkX2lucHV0KEsyMzBEZWNvbXBHemlwU3RhdGUgKnMsDQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgYWRkciwgdWludDMyX3QNCj4gc2l6ZSkNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBod2FkZHIgYWRkciwgdWludDMyX3Qgc2l6ZSkNCg0KVGhp
cyBzaG91bGQgcHJvYmFibHkgYmUgaXQncyBvd24gcGF0Y2gNCg0KQWxpc3RhaXINCg0KPiDCoHsN
Cj4gwqDCoMKgwqAgcy0+aW5wdXQuY3VycmVudF9vZmZzZXQgPSAwOw0KPiDCoA0K

