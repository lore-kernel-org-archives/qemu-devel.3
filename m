Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559A0FD9E26
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 00:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvlaD-0004Wd-Qv; Thu, 26 Feb 2026 19:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511ad3126=Alistair.Francis@wdc.com>)
 id 1vvlaC-0004WP-Cz; Thu, 26 Feb 2026 19:19:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511ad3126=Alistair.Francis@wdc.com>)
 id 1vvlaA-0006ga-6G; Thu, 26 Feb 2026 19:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1772151589; x=1803687589;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vNsqjQRMS5o7YzAeAGIT2gvslEXwHzD6ZGZOBUIDxKs=;
 b=SnBxhk9y0goqJK69yChI6UYr1p8xlbFdpEcWWUN1T0P6febUYU6gdrvD
 3rdkfulsxeNS5hxBGi380MoBh64n7A9p5kdm2DRbNASB+YgWs9kQvF9LY
 CGqgXxbADBRNgJhWqbCe1NZ8psZIrJYXxGZNSjdkqHs2pDZ9UVNXxMCc/
 wEcMgKXeuAg7nmWVJW5VqUKt3OPKO9JLnaLLC1rIbtux0CRQLGH/N43nc
 pwk6mdyxBdipxlHgujkh0ou2srIA9pS8EpkNBUZX6a9OUj5gLpeIdMNa9
 QLYg/lKmK5+M4wdfhpgtPtraEReDWroQXMtrLOtZQQxyTAhnwRPwdJztl A==;
X-CSE-ConnectionGUID: 3FScc9L+QDiH7CY47Rfq+A==
X-CSE-MsgGUID: KVXOC0cSQoyNDK07mQoMKw==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; d="scan'208";a="140605185"
Received: from mail-westus3azon11012029.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.29])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2026 08:19:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDjAi65vY7po0fTKAz6EgRBsh3Dd25yR8CVJBMyJbKCxUeFpbjvN6tfaMyX8vmpGBBdpwvy1yQoPBqvL3qp/TrPzJRwLPTvmids6wZ18YkKwN9WWnZfLrJ7hiuovubOtFM4BGph5DOsMzfwmVGlrw1/hFJYdS+RmSJvXFuhfnxDnyxOrq8J5jvxsURAI9N0XXCgQeaW9U+YHmWN7ELtptdMXXzY2WEFGHIoPUO+HVQ3cG3YbjKqMiYYjeV3FwM4aGj2jfokWhxb7r9J/D+ws4cIVeokIEoUk124+6sSpPz8jCD/7IeJQV06qdZV6cWLBIr2L6d9ufuZ7WxnApSkBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNsqjQRMS5o7YzAeAGIT2gvslEXwHzD6ZGZOBUIDxKs=;
 b=ushh7iAF4pD5Ba4130RT+k0r/DzuzXHehsbs/F2nbbE3PmhPWbvLht+KFZW4UcEECG23OUUwYAgt0gfGXzWoxhjUYVEwKcjmqAw6QC76r3szJU2ufqxdBGDI+AnXx3alQjV7fyPbXYiIOFQIDSkfHqK26zG+9YqNmvD0k+7m0ARYnfTr9BqwrpHITfS36pTq82MK7/9K3EixD1vrgeN7ovcU1qTYACBd/91oYt53gXpT9SxsFwuuiIRmn+FIp90WwKv/zeu7nWHM6CM/oqe8bRxhtLBDYKSiYTWUoQPo4byTRp/wpNCUexlh4WBvsZC9ldmcL94vXgDYzvhuPUAPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNsqjQRMS5o7YzAeAGIT2gvslEXwHzD6ZGZOBUIDxKs=;
 b=XAAs5etE3iRj9ACjgxeK6I51akO6fIPkY9Cy5n/vT+1LOqQK7b1/yuIcLmNJyAG6KSYryHqqtCBcc7YGuNgOWRsrpSOE9O6dMynkaemWuGbeBAlTKI/AJc0a8Fuwkaj3acVAoVpdbFQMgwKMil6G7vrbTlGoU7oM1jCmHC5mlFM=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by CY3PR04MB9743.namprd04.prod.outlook.com (2603:10b6:930:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 00:19:41 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 00:19:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lex.bailey@lowrisc.org" <lex.bailey@lowrisc.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "amitkh@google.com" <amitkh@google.com>, "qemu-maintainers@lowrisc.org"
 <qemu-maintainers@lowrisc.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "dave@treblig.org"
 <dave@treblig.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH qemu 00/11] Introduce ot-earlgrey machine, and one
 peripheral for it (alert handler)
Thread-Topic: [PATCH qemu 00/11] Introduce ot-earlgrey machine, and one
 peripheral for it (alert handler)
Thread-Index: AQHconoDPOsvMe8AFE6n2iDOk8P7brWVuJOA
Date: Fri, 27 Feb 2026 00:19:41 +0000
Message-ID: <36bd4a3d40459f183e6768313c790434e0240f4d.camel@wdc.com>
References: <177159976712.8279.7732381632410882915-0@git.sr.ht>
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|CY3PR04MB9743:EE_
x-ms-office365-filtering-correlation-id: 1c6948cb-74d0-4be1-b9cb-08de7595e6f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: YdynygxrVhrdVQ11dFuKA50Hi1j5HYjO4tXqhWnkQNKkMh+QlZx8sD5i/5hzPHhMaLIB81jI4vEE9gOcbNOar0yN4lJ0aJlMK6CRHfb3hVXpAQGzdozH/qQFrGzEXYirSTcftynLVZud5VhAu56yYZv4u9N/X022Fr3U2vvBXXyCt6NNqU2qK1agjrfDEOTEypgqPH4zquQ+pSuL449sjIIzRvk1VhLMWJW76UPj6ZxvyIG1y4P5GbGhJm4Vvt6fqpwDMUczHmOoTAlVw6uPLpFpQ3RaCwAkJVUFL6MvDTndS/gQx6xGn3Mi2X2AXieD3cPmb6PaMNOS5djLZFBt5w2VckK+RL+7MxwzGSEFJiORqryEBIkwPiy07rDdjqHONhE1Xlz6lKjoXaOBFzdniytPbeYERrPzJpTUGs7c6jzPVlYs+nGrAevsWWNHe9TaYn85zdU8cjDP6z+4KjjqyprvmuO9QKI+dHP/afBjPq36bvGmAFBmPVjHO51fZnXNrGKPQs1N5R2pm9zgGQMljCFdlM3B1LXAIYLgLafzgcViHKss6lPlZZnrI+g0vhKELQyA5zco7yuyAZPBIqbRaW9+OdVoaC1lwDo12Vf9ZNbJdQkkMmiF7o1NNI7SRqA+silFOhoHKntIXbE8CiwBnw+E+7sC9WFCNZMPxzji4iJtJH0F6B5PxfyOMWE9aMdkLKyYPOQNwiZl/mzn0hn038L8yAysoaCOffrO/3/8EmDmwmseBexfW1P7ueth3IV/4YOiviC++w75ZDIezn4d/dmkKB5wGdC6ikHmZ9DqFV4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB9849.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0hJV2Rpck9hU28vM3NVNFJGOERLTmFnOXVaODV5S3JTdTRHWHdQYjBpWWlU?=
 =?utf-8?B?cDJ5TWJpQWJydHkzNk5meWszaGNPQXFheEJMWFVrSXRUU045M2R5ejMyYVg0?=
 =?utf-8?B?aGliMG1EY0dseWdoN2FIQ3FjeTIwRGN3dWtOdDJBazM0clhsYWc2TlFOWThX?=
 =?utf-8?B?ZlJ5QjBkV0RSREtUMkRGcmlXMGNrZ0xqMVA4eG9CUUdyMXJZR3MzTS9zMXl4?=
 =?utf-8?B?Ly9IcWNONzBCN2ZUQko1MUdpajhBTzZQZzE1NFZTdUpFS01vZ21lazgybUUr?=
 =?utf-8?B?V1E4dWpuYS9JOVQ2eXNML2swWnhvTzBCQlRiRkZnL1VlQlBhVXUvYUVWV0JO?=
 =?utf-8?B?b29peE8xbEJVbGZCdWhNVXpzRll4SkRVemh4OHZWQStVeWRTdm5JVzN3ZjFr?=
 =?utf-8?B?QmVIOEdkT3VxQmtkSElac0p3QzJnKzdRdWl6bHJybTFJaHlpTUV2QU9oWEpx?=
 =?utf-8?B?ZDBvK1N4NDRjbnlrL3lmSEp1bjFyaS82RlJBdzlyWW5VcUI5SXFlUFFBNHRl?=
 =?utf-8?B?aE1FbVZad0xMYkJ6WVBsWTh4V0pyRkhoMVl3MmExaWVwOGIvY0Jwa0Ezc3hm?=
 =?utf-8?B?cythRTdKRzJEWEI4eG5NZFJpcGFpeXFxSXMrdGx1WlV2ZHNabXN5OXJ6WmZW?=
 =?utf-8?B?dDhBeWRJZlJzLzlKa01XYmd5cVBkSHZxc0VxSUp0TkF2b0xnRlBaSElzd3c0?=
 =?utf-8?B?ZmVnb1AzVFlEcHJpTk5iajFvaEJxSE9uL1NvYzFCcm1oVHlhRk8yeHc5MEFj?=
 =?utf-8?B?Rmo4aUhsaVdxUGxucEo0TXUxbEtLcEJWUkwvWFBmcVR2TXp3VzhGY0VyMGxL?=
 =?utf-8?B?NnJWbEw1M0ZZOE51aU1mSGc3Y1B6bExpWTJJSXVyeHNxMDU4NFJGbUh3aWw5?=
 =?utf-8?B?YTNFbWpkOWh0RzM4ZG1QdHYzOVRCZGZ5bnpKM01GOFZQblRWazdFZVVybVU5?=
 =?utf-8?B?N01IZU5lMzRYYlgwT1kyMDViV3ZFRHlab1VlT3JMNGx5bEpDd3R5N2JYVzF1?=
 =?utf-8?B?NHcrSDEvTzdSRzd2aUFNeHBHUi9jVXhUNXh5UVZ3Mkd4WWJhek9GUkp2WHR3?=
 =?utf-8?B?b1lHSEkzQ1FjZGJTWm5DYjBCWCtJRkZtT2FnaS9FeUI3ckF3NGNwemRNVnpO?=
 =?utf-8?B?dG9nSDRHMWJhSXBNU2ZQVjBDUjNEUXd3MTRDd29XMjlXR1VqOWlSYUtmN3M0?=
 =?utf-8?B?aldOU2ZqMUNJdUVkNFE3V1puQXJFZURmUm51RmFyODdwNlFoc3c4ckVIbFU0?=
 =?utf-8?B?ME9HLzR4RERsQ1NRUkk3OFVhMVRUUlNKR0IyR1UwK2NVRjFQSllsTHgyWE5j?=
 =?utf-8?B?M3VNNDM1NUJCSlFtY0grYjVTSHdUTitxQnoxR2YwYUlDU0NyZ3lFMkVpbDMv?=
 =?utf-8?B?cXU2ampmREVwREtiODBMRHlOWWlpRlFUQzFsYnJ6VC9LR1k2UGdsUE5ucllV?=
 =?utf-8?B?amhNTndKSy80VEhEV2VYQUZ4ZFI0VVM4dDB1OGk5dUFwWHRoeTVxY3gwWHg5?=
 =?utf-8?B?bitzVEovZnZKNDBVakxObURLdm5uMDFVU25RSFZIYWdDSmZMWnM1NUVESy8w?=
 =?utf-8?B?Z0Nmd1U4R216ZUYrT21GdERvV3gzSFQ5L3czTmlha0oyVytURmdHRzJEZHA4?=
 =?utf-8?B?enFndFprWkIyelBVRjk5bGNHSUMvV0Z3QTBrT2NQOG9JRG9tWG1yR0JTa3A2?=
 =?utf-8?B?Tk9ZeVFNaDczNlZ6SHp2Nkw5eG82eXhQM0U2V1YwUkRxZjFSRGtYbVIzUlU5?=
 =?utf-8?B?ZVM1bWVJTTRpUEN0dXVyR0NTNkQ5Q2VDR3owMC9sYU83ZGNndnkvVWtDai8w?=
 =?utf-8?B?WUp4VDVtMHYzUWN1UXBhSWx5Y0E2NnVWK3R1bis5aWdFTTVsM0VrY0w3enc1?=
 =?utf-8?B?OG4wU1lVelUxdG1nRkIyNWZ6Z21LVEZZVEgyOVRWRUtVMCs3NWVUWUQzWDVV?=
 =?utf-8?B?WkNjRmZKSWFxT3dOa0o4Ni9uODdkcitySDNQcVIxeHdUNmJGSFBKMlJEcFg5?=
 =?utf-8?B?ZkVXMERocUpNZldPRmRsNjZMNkhLd2ZjdEUyNGVoQk5rdlZYQjU3TUNIRGc5?=
 =?utf-8?B?NGhHZVExTDhLbGhqcm9qSXNBdU1BTVFFc0NkTlNVWmY4MXpZRUpVMERYTmQ2?=
 =?utf-8?B?NjdQZk44Q0RneWRzTWIvSmRyTkd0bVhrcVdXSkczeXk3bWdSSVBnc0s4d0pu?=
 =?utf-8?B?alNEZE5ZdEIxR0xJVURSSGVSOUFtV1AxNWozSlEwdE9LdXpkb2l0alZSQ2gy?=
 =?utf-8?B?VzBkejFyYjBDZUdSakZTRTVndFlPMG1SVktvNDVOdnRiazF3bU9rUUR6SXVC?=
 =?utf-8?B?ZXp5N0VtMlI4THhpOGpPaXdzRHJvL3h6Q3JYTkM1SjRsSUFXempKbWNWUnd2?=
 =?utf-8?Q?IIzurbzjFAcrVabJKv7dQYSXUKVrGs+lvvG/27E+Vi6AH?=
x-ms-exchange-antispam-messagedata-1: IQGIWc8Kcc2FO/3fBGMYdHQCznmoG5FccHw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0A1166EF140CB449F3B901C24ADBE4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t1wJy9RU/a9yftCUfM1iwCzDZVUY7XE9Mr5inf60AZXjuD7Yx2fBIFFCifNd2aFNA6iIFMvcYqdOpUnpcPenoGkBbgdg+QWTtw+LxU8n4U/Jeyjv7frS12naylRMmaTNLFmE1tXxJ0YZyh02DMT66piH4VSbRs2jEhTDsHiKOUFYxTQyYDYxiq5oti92r5UxTQrAeZYnE93YD80aGT1FSFF5FY9QEYrmsQ9JqFH6VwzkMTgKQjJf7Ml6Qo1vuF3rfj78u3xyf2+F/5dAKNRd/xYj7/MjdgGShGyLc1cBJEu8bGp7L9HsDShcjnQMB8KjtkmYBMrPrUexO3hpXKG6L6a+odwQPx7zZRSuQRBJp4c2ZF8i/3Tetqn+RtjFBXqzGb+Ricr+rwaFRzoAJTn/ktbC2Okh6pyjalNuOe44Sh4ix7/IzWFMmLz/fwMDmKNMENkj2s/al0TtlTcZFltvx/bMgag1jcU5qmt81EdVW5gilPFZsiUjIYwz3+w61jXKroACfCZrylLP1IDR/g3uavXVU5L1fzaZQNhKGz19fxAbufzbPc78npi20D+m+cenpPHvVKoaESIVUZTJZVQpR3pWCaF2naMeWBouhuA9t9kLcuILYacZRr9hZnyIsi5q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6948cb-74d0-4be1-b9cb-08de7595e6f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 00:19:41.8147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g82yaDdZTTZSbNS84iFVNcXlzboE/EVdphqbjmbLGv2W51VjAuItz2Gff5uH+FMBxK/+KSkHFkk6mCh89P5QIamS3crq0o68KpkOth9buyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR04MB9743
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=511ad3126=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTAyLTIwIGF0IDE1OjAyICswMDAwLCB+bGV4YmFpbGV5bG93cmlzYyB3cm90
ZToKPiBUaGlzIGlzIHRoZSBzdGFydCBvZiBlZmZvcnRzIHRvIGNvbnRyaWJ1dGUgY29kZSBmcm9t
IHRoZSBsb3dSSVNDIGZvcmsKPiBvZgo+IFFFTVUgdG8gYnJpbmcgdGhlIFFFTVUgc3VwcG9ydCBm
b3IgT3BlblRpdGFuIG1hY2hpbmVzIGluIGxpbmUgd2l0aAo+IEVhcmwKPiBHcmV5CgpUaGFua3Mg
Zm9yIHRoZSBwYXRjaGVzIQoKPiAxLjAgYnkgYWRkaW5nIGEgbmV3IG1hY2hpbmUgY2FsbGVkIG90
LWVhcmxncmV5LiBUaGlzIHdvcmsgd2FzIGRvbmUgYnkKCkkgdGhpbmsgd2Ugc2hvdWxkIGp1c3Qg
dXNlIHRoZSBleGlzdGluZyBPcGVuVGl0YW4gbWFjaGluZSBpbnN0ZWFkIG9mCmFkZGluZyBhIG5l
dyBvbmUKCj4gRW1tYW51ZWwgQmxvdCBhbmQgTG/Dr2MgTGVmb3J0IGZyb20gUml2b3MsIGFuZCB2
YXJpb3VzIHBlb3BsZSBhdAo+IGxvd1JJU0MuCj4gVGhpcyBwYXRjaCBzZXQgaW4gcGFydGljdWxh
ciBhZGRzIHRoZSBiYXNpYyBtYWNoaW5lIGRlZmluaXRpb24sIEliZXgtCj4gcmVsYXRlZCBjaGFu
Z2VzLCBhbmQgb25lIG9mIHRoZSBwZXJpcGhlcmFscyByZXF1aXJlZCBmb3IgaXQ6IHRoZQo+IGFs
ZXJ0Cj4gaGFuZGxlciBkZXZpY2UuCj4gCj4gSSBwcmV2aW91c2x5IGVtYWlsZWQgYXNraW5nIGZv
ciBhZHZpY2Ugb24gaG93IHRvIHRlc3Qgb3VyIGNoYW5nZXMgaW4KPiBhCj4gd2F5IHRoYXQgaXMg
YWNjZXB0YWJsZSB1cHN0cmVhbSwgYW5kIGhvdyBiZXN0IHRvIHN1Ym1pdCBzdWNoIGEgbGFyZ2UK
PiBzZXQKPiBvZiBjaGFuZ2VzLAo+IGlmIGFueW9uZSBoYXMgbW9yZSB0aG91Z2h0cyBvbiB0aGF0
LCBwbGVhc2UgZG8gcmVwbHkgdG8gdGhhdCBlbWFpbC4KPiAoCj4gaHR0cHM6Ly9saXN0cy5ub25n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LXJpc2N2LzIwMjYtMDIvbXNnMDAxMzkuaHRtbAo+ICkK
PiBUaGVyZSdzIGxvdHMgbW9yZSBjb21taXRzIHRvIGNvbWUsIEkgZG9uJ3Qgd2FudCB0byBkdW1w
IHRvbyBtdWNoIG9uCj4gdGhlCj4gbWFpbGluZyBsaXN0IGFsbCBhdCBvbmNlLiBGb3Igbm93IHRo
aXMgaXMgYSBzbWFsbCBmaXJzdCBzdGVwLgo+IAo+IFRoaXMgcGF0Y2ggc2V0IHNob3VsZCBnaXZl
IGEgZmxhdm91ciBvZiB0aGUgc3R5bGUgb2Ygd2hhdCdzIHRvIGNvbWUsCj4gYW5kCj4gSSdtIGV4
cGVjdGluZyB0aGVyZSB3aWxsIGJlIHNvbWUgY2hhbmdlcyByZXF1aXJlZC4gV2UnZCBqdXN0IGxp
a2UgdG8KPiB1bmRlcnN0YW5kIHdoYXQgd2lsbCBiZSBuZWVkZWQgdG8gbWFrZSB0aGlzIGFjY2Vw
dGFibGUgYXMgc29vbiBhcyB3ZQo+IGNhbgo+IGJlZm9yZSB3ZSB0cnkgdG8gdXBzdHJlYW0gbG90
cyBtb3JlIG9mIHRoZXNlIGNoYW5nZXMuCgpJIGdhdmUgYSBidW5jaCBvZiBjb21tZW50cyBhbmQg
c29tZSBvZiB0aGVtIHdpbGwgYXBwbHkgdG8gdGhlIGVudGlyZQpzZXJpZXMuCgpJbiBnZW5lcmFs
OgogLSBDb21taXRzIG5lZWQgU29CIGxpbmVzIGFuZCBjb21taXQgbWVzc2FnZXMgZGVzY3JpYmlu
ZyB3aGF0IGlzCmhhcHBlbmluZyBhbmQgd2h5IAogLSBUaGUgbmV3IG1hY2hpbmUgY29kZSBlc3Bl
Y2lhbGx5IG5lZWRzIHRvIGJlIGZvcm1hdHRlZCB0byBmb2xsb3cKb3RoZXIgUUVNVSBtYWNoaW5l
cy4gU3RhcnRpbmcgd2l0aCB0aGUgZXhpc3Rpbmcgb3BlbnRpdGFuIG1hY2hpbmUgd2lsbApoZWxw
IHdpdGggdGhpcwogLSBXZSBkb24ndCB3YW50IHRvIGFkZCBhIGxvdCBvZiBkZXZpY2Ugc3BlY2lm
aWMgY3VzdG9tIGhlbHBlcnMgYW5kCmluZnJhc3RydWN0dXJlLiBZb3Ugd2lsbCBuZWVkIHRvIHJl
dXNlIGV4aXN0aW5nIFFFTVUgaGVscGVycy4gQWdhaW4Kc3RhcnRpbmcgd2l0aCB0aGUgZXhpc3Rp
bmcgT1QgbWFjaGluZSB3aWxsIGhlbHAgaGVyZSBhcyBpdCdzIGFscmVhZHkKc2V0dXAgdGhpcyB3
YXkKCj4gCj4gSW4gcGFydGljdWxhciwgbW9zdCBvZiBvdXIgbmV3IHBlcmlwaGVyYWwgYmxvY2tz
IGFyZSBjdXJyZW50bHkgaW4gdGhlCj4gZGlyZWN0b3J5IGNhbGxlZCBody9vcGVudGl0YW4uIElu
IG91ciBmb3JrIHdlIGhhdmUgYWJvdXQgNjAgYmxvY2tzIGluCj4gdGhpcyBkaXJlY3RvcnksIHdl
IGhhdmUgcHV0IHRoZW0gdGhlcmUgdG8ga2VlcCB0aGVtIG9yZ2FuaXNlZCBhcwo+IG9wZW50aXRh
bi1zcGVjaWZpYyBibG9ja3MuIElzIHRoaXMgYSBzdWl0YWJsZSBwbGFjZSBmb3IgdGhlbT8gd291
bGQKPiB5b3UKPiBwcmVmZXIgYSBkaWZmZXJlbnQgc3RydWN0dXJlPwoKRm9sbG93aW5nIHRoZSBn
ZW5lcmFsIFFFTVUgc3RydWN0dXJlIHdvdWxkIGJlIHRoZSB3YXkgdG8gZ28gaGVyZS4gU28KYWRk
IGJsb2NrcyB0byBleGlzdGluZyBkaXJlY3Rvcmllcy4KCkZvciBzb21lIHRoaW5ncyBpdCBtaWdo
dCBtYWtlIHNlbnNlIHRvIGhhdmUgYW4gb3BlbnRpdGFuIGRpcmVjdG9yeQp0aG91Z2gsIGlmIHRo
ZXJlIGlzIG5vIHdoZXJlIGVsc2UgZm9yIHRoZW0uCgpBbGlzdGFpcgoKPiAKPiBUaGFua3MhCj4g
Cj4gRW1tYW51ZWwgQmxvdCAoMTApOgo+IMKgIFtvdF0gdGFyZ2V0L3Jpc2N2OiByZW5hbWUgaWJl
eCBoYXJ0IGFzIGxvd3Jpc2MtaWJleAo+IMKgIFtvdF0gaHcvY2hhciwgaHcvdGltZXIsIGh3L3Nz
aTogZml4IGRldmljZSBkZWZpbml0aW9ucwo+IMKgIFtvdF0gaHcvcmlzY3Y6IGFkZCBoZWxwZXIg
Zm9yIEliZXggcGxhdGZvcm1zCj4gwqAgW290XSB0YXJnZXQvcmlzY3Y6IGltcGxlbWVudCBjdXN0
b20gTG93UmlzYyBJYmV4IENTUnMKPiDCoCBbb3RdIHRhcmdldC9yaXNjdjogYWRkIGN1c3RvbSBt
dHZlYyBDU1IgbWFuYWdlbWVudAo+IMKgIFtvdF0gdGFyZ2V0L3Jpc2N2LCBody9yaXNjdjogYWRk
IGJhc2ljIE9wZW5UaXRhbiBFYXJsR3JleSBtYWNoaW5lCj4gwqAgW290XSB0YXJnZXQvcmlzY3Y6
IGFkZCBzdXBwb3J0IGZvciBpbXBsLWRlZmluZWQgaW5pdGlhbCBQTVAgY29uZmlnCj4gwqAgW290
XSBody9yaXNjdjogb3RfZWFybGdyZXk6IGFkZCBIVyBQTVAgY29uZmlndXJhdGlvbgo+IMKgIFtv
dF0gaHcvcmlzY3Y6IGFkZCBhbiBJUlEgd3JhcHBlcgo+IMKgIFtvdF0gaHcvcmlzY3YsIGh3L29w
ZW50aXRhbjogYWRkIE9wZW50aXRhbiBBbGVydCBoYW5kbGVyIGRldmljZQo+IAo+IExvw69jIExl
Zm9ydCAoMSk6Cj4gwqAgW290XSBody9vcGVudGl0YW46IGFkZCBPcGVuVGl0YW4gc2hhZG93IHJl
Z2lzdGVyIGhlbHBlcnMKPiAKPiDCoE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIxICstCj4gwqBobXAtY29tbWFuZHMtaW5mby5oeMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiArCj4gwqBody9LY29uZmlnwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsKPiDCoGh3L2No
YXIvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsK
PiDCoGh3L2NoYXIvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDIgKy0KPiDCoGh3L21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgMSArCj4gwqBody9vcGVudGl0YW4vS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDQgKwo+IMKgaHcvb3BlbnRpdGFuL21lc29uLmJ1aWxkwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDMgKwo+IMKgaHcvb3BlbnRpdGFuL290X2FsZXJ0LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDY2OCArKysrKysrKysrKysrKysrKysrKysrKwo+IMKgaHcvb3BlbnRpdGFu
L3RyYWNlLWV2ZW50c8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArCj4gwqBody9vcGVudGl0YW4v
dHJhY2UuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+IMKgaHcvcmlzY3Yv
S2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE0ICsKPiDCoGh3
L3Jpc2N2L2liZXhfY29tbW9uLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzE2ICsrKysrKysr
KysrCj4gwqBody9yaXNjdi9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDIgKwo+IMKgaHcvcmlzY3Yvb3BlbnRpdGFuLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMzAgKy0KPiDCoGh3L3Jpc2N2L290X2VhcmxncmV5LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgODUxCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqBody9zc2kvS2Nv
bmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKwo+IMKg
aHcvc3NpL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIg
Ky0KPiDCoGh3L3RpbWVyL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDMgKwo+IMKgaHcvdGltZXIvaWJleF90aW1lci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDIgKy0KPiDCoGh3L3RpbWVyL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgMiArLQo+IMKgaW5jbHVkZS9ody9vcGVudGl0YW4vb3RfYWxlcnQuaMKg
wqAgfMKgIDIzICsKPiDCoGluY2x1ZGUvaHcvb3BlbnRpdGFuL290X2NvbW1vbi5owqAgfMKgIDkz
ICsrKysKPiDCoGluY2x1ZGUvaHcvcmlzY3YvaWJleF9jb21tb24uaMKgwqDCoCB8IDMyMiArKysr
KysrKysrKwo+IMKgaW5jbHVkZS9ody9yaXNjdi9pYmV4X2lycS5owqDCoMKgwqDCoMKgIHzCoCA2
OSArKysKPiDCoGluY2x1ZGUvaHcvcmlzY3Yvb3BlbnRpdGFuLmjCoMKgwqDCoMKgIHzCoMKgIDQg
Ky0KPiDCoGluY2x1ZGUvaHcvcmlzY3Yvb3RfZWFybGdyZXkuaMKgwqDCoCB8wqAgMjcgKwo+IMKg
bWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAxICsKPiDCoHRhcmdldC9yaXNjdi9jcHUtcW9tLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDQgKy0KPiDCoHRhcmdldC9yaXNjdi9jcHUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgNDAgKy0KPiDCoHRhcmdldC9yaXNjdi9jcHUuaMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA3ICsKPiDCoHRhcmdldC9yaXNjdi9jcHVfY2ZnX2ZpZWxkcy5o
LmluYyB8wqDCoCA3ICsKPiDCoHRhcmdldC9yaXNjdi9pYmV4X2Nzci5jwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxMTUgKysrKwo+IMKgdGFyZ2V0L3Jpc2N2L21lc29uLmJ1aWxkwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoMKgIDEgKwo+IMKgMzQgZmlsZXMgY2hhbmdlZCwgMjY0MSBpbnNlcnRpb25zKCsp
LCAyMyBkZWxldGlvbnMoLSkKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBody9vcGVudGl0YW4vS2Nv
bmZpZwo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L29wZW50aXRhbi9tZXNvbi5idWlsZAo+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L29wZW50aXRhbi9vdF9hbGVydC5jCj4gwqBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvb3BlbnRpdGFuL3RyYWNlLWV2ZW50cwo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGh3L29wZW50aXRhbi90cmFjZS5oCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvcmlzY3YvaWJl
eF9jb21tb24uYwo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3Jpc2N2L290X2VhcmxncmV5LmMK
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L29wZW50aXRhbi9vdF9hbGVydC5oCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9vcGVudGl0YW4vb3RfY29tbW9uLmgKPiDC
oGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L3Jpc2N2L2liZXhfY29tbW9uLmgKPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L3Jpc2N2L2liZXhfaXJxLmgKPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2h3L3Jpc2N2L290X2VhcmxncmV5LmgKPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0YXJnZXQvcmlzY3YvaWJleF9jc3IuYwo=

