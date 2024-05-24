Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F0C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVQf-0008Sw-Ur; Fri, 24 May 2024 09:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sAVQa-0008KN-H9
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:57:52 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sAVQW-0004k7-OH
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716559064; x=1748095064;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MfAY12CzHlVa8KGjJwG1jZNTT6Q9w7Mxhel3TL9fP+o=;
 b=mqGh4nU3eoS+FsDa6jmiN/Jys5Er/7D5T7F9ZbcaPWgfoUVG4JfLpT8n
 uIH0WM4nH9X/VT9z/G38a3x8d3A9dKdt3odopBZtFNdBS36HABD6dKNhd
 xBThNcGu71oQYHXmnWeu1+RGOLfF9MX2OWzOh4ozro/UftwvDEtwj1+HO
 7R7RAKv1LQNwaSn0LO9Swm4hq9r6GbLARpnJcB/ixVOd0OyLT71OlNwJt
 lOthPXbkdnmjLGENQtWeCUT4qd9NmNcWubJYJUIni/n4OG23Ye0+YKa+F
 suXpCQ3f372Sykht3ztMaeAOHEU4K2p9qjWTbD0UkikxmnGMw+/waXV/5 w==;
X-IronPort-AV: E=Sophos;i="6.08,185,1712613600"; d="scan'208";a="13230694"
X-MGA-submission: =?us-ascii?q?MDGW4g9l3kyNAwyXI16qTV4eFDbaTzmQQ/txcA?=
 =?us-ascii?q?MY95C+lDDZQwf3PHDtscI8dam90WnG0udbvN+a95QRIht3L9FaBbJzub?=
 =?us-ascii?q?PuIgkJaiRBzH4Pp7Vk8fZTWvcqeMe/CzDMnYzB4L7E+yhYc+sUjeW6P/?=
 =?us-ascii?q?jjmQE9LjAGaeRO470VDKxBGg=3D=3D?=
Received: from mail-he1eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-HE1-obe.outbound.protection.outlook.com) ([104.47.13.51])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 15:57:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVp/upzYOMnX14MY+8/pmHAi53WyT+ZPcbPojda0l8grDWczMKWNyKM24jDJ7pJxk6KqiuZCkODBX4J3snS3S5IBykklf80sRHs4w5BwaNBTw90zKVvkD36Y/5/Q6WhKCpcGYJwFJd4VnonjJ+/EfCCLI6tcQCyyF/PIJ2mTYdcUte96bp9P90pW+sb8VgaOVXAbhbm3xtfVOfRH8mrX/j/TjS5p4C5NyeOmTptYftfoJyrnluj/wMEDcOEGRHAI2CeQRuEVvRCvr7FRlXWhqfeXBhbVQRhkmHDcYn7cqRfK7dmLzmDtJk7Tjuqcy0msFW79N3RhvjE+aF05p3aspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfAY12CzHlVa8KGjJwG1jZNTT6Q9w7Mxhel3TL9fP+o=;
 b=A+c5iX9P6SdBY9e0wlBeN3z5iBEP4UDQ0VSyTykQxg1mY0chOxY5ACXTypZ0bYDI4KtByTZGIsbMmsfR9DtYN+LbsPUzWzMYgVd8evqQ1n/BJAzgmt+/yu7gIuNk2pki3IJTZ1x4KgJL3sEb/YFoay5G+pVRvfizchMfCh669B4y65GupKiTzy7DA8HRfXO1g275njpP7qAZUBtjnvcQPO6S21f+JuXVYVRZdZcF43LVij+3HvNvIN42sD7tc9ce5PZx8y63a2qEm6itdJxoCyY35t6ggGyR+9m98V+Muiw7PL0lQx6PG2t3MuOdCBFsglJumIGejMZZ9voC7/xbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9680.eurprd07.prod.outlook.com (2603:10a6:150:110::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 13:57:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:57:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH rfcv2 06/17] intel_iommu: Implement stage-1 translation
Thread-Topic: [PATCH rfcv2 06/17] intel_iommu: Implement stage-1 translation
Thread-Index: AQHarBD2QDNyBW26xkCSSW+ub5GaGbGmbH2A
Date: Fri, 24 May 2024 13:57:39 +0000
Message-ID: <b6260c3f-0710-44ad-90e3-eb7931e751fa@eviden.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-7-zhenzhong.duan@intel.com>
In-Reply-To: <20240522062313.453317-7-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9680:EE_
x-ms-office365-filtering-correlation-id: 057cc732-a510-4613-83a7-08dc7bf97946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?ZDBvMGt0aHpua3NaNm9jZ1pxQmhIOVV1RHMwVW5VdmdIWXpnaTdVODJBMlNk?=
 =?utf-8?B?Q1pkcVN2NGlTdjBQZ2VqNWw2MTg0RUJCaUN5cVBNSGozVWZ5U0N3MGEwZ29E?=
 =?utf-8?B?c1VqZUljZ2dyYVZWU1JwRTNTNU1BaVJ6RWRucE5uaHA1eTNON29IS3ErVzcw?=
 =?utf-8?B?THV2LzI5QkVPT2thMHZ6L2RVMWMrQVh4RTBhUnY3eTQ3eHcvV2t0eXRjWXFi?=
 =?utf-8?B?eXp6WGdnU3ZucTQvamsxYXRWc0wzU2h3MityeWJaQktJd2ZvQjVoYUhEdXZo?=
 =?utf-8?B?ellWR0syUFl6RHRNMEpaV0dSNlZiR0lvUEwza1AzeklyUDJxMnZLRDBIMnQy?=
 =?utf-8?B?N05YSjIrUVIybHE4YUZhbzIyellhSEtLeUFLVGRCUEE1aGNHUTY5TERNRktE?=
 =?utf-8?B?cWxlclQ0TGxGWTNDTFBzcDdlNndWU2xQbkNVQ3pSeG0rb1ZPR0NLNHFpa29W?=
 =?utf-8?B?V2tNTlRPVUtCUk5PUzNJbldMNkl6LzVQTkZmU1JwUmZXOGlrQnJnZjlFNWdj?=
 =?utf-8?B?V0swUVFrWXg0dmNuWEJPSDk2cEgrckF2MGd3L1NmYWpWL3JlNG9NOTNOWVNG?=
 =?utf-8?B?QXBnd1Mwbmo1RWtheS9SSnVYc0Jmb0VsV1RxUmwyczNTTzZkWmg3U1FKMWRS?=
 =?utf-8?B?SDJhQXBXWExjOVVjWGFMMDhKS2FoQ0xYY0wyTUJ0ZHJVRW1VY0tmSkRzQjVZ?=
 =?utf-8?B?MUQ4QlQ3Z0Z5QU9vaE1ZZ09FcklVNXg2YTExcit2KzZoKzZubGxpeFhoOEpv?=
 =?utf-8?B?VG9HTExBN3lURzdGZkRqejZaY0RDTEJxbWdXSE1zTDNoMzdkancrZU9XRmx3?=
 =?utf-8?B?aEpycU9Ka2R3c25uR0RVZ2lrakxTVWhkbmZEeU1NR2xVb0dwVFNHbGJCTlBU?=
 =?utf-8?B?SkFmWHcycUdWNmZFaU5oeDJHc0lNU2pCdThzem9CUHpxOGJjeXpDd2xsMzdZ?=
 =?utf-8?B?R0FtZTFUR3hrYVNyZ3Q1d0V4S2ZPdzUyY3pXR241SVlKLytvRlNCbzhhcjNH?=
 =?utf-8?B?Q3dqSnR5ZUlBQ0IyUkw2MEtrVkM0RjlLVFFkcjJNdDRzeVRoMllwUjJHSkIz?=
 =?utf-8?B?cXpYdk1vMGhra1hGM1U0OHBubWZ2UnpIQVY4bDFhSEpkWXVyMGJrZUpUSU9z?=
 =?utf-8?B?S21XeXlzaEtVTzBtcmY0U21oampPRy9mcG5sMDhKb1VISnJCRUEyd0dJQzJm?=
 =?utf-8?B?dTZGTjZ2emYvWDdKSXZPbEc2VDNoM3pzZUFiWnRRMTUycFg4dnVqclAzcmJZ?=
 =?utf-8?B?SzR5VmhBdDNScHVNcVU1SHNpL2F6WDhxVmZ0a0NDbEJObFd6N2NPM0lMaTkw?=
 =?utf-8?B?S2ZBTXdJbDlWaDFqMGZUeG1YL3psdm5SMXg2ZEdKSS9idUZJL0dCTytQNGFq?=
 =?utf-8?B?K1hlQS9Ud0NmMXdxQTg0aXdVWG5qT01TRVoyNUhIU2ZEQUt1VVVhV2NPeXhS?=
 =?utf-8?B?WndhWlBsKzB6a1Nud3J1UXNsYzczNFV4SkNCU21WZzVVek9hM0swTUk0RHpn?=
 =?utf-8?B?MXpRNDU5czU0UXcvRE5Wbk1SMzNxcVVmbTlaYXJlNFRTdzhYbzVvb0J4cHY3?=
 =?utf-8?B?YzJlYUdFZCtib3ZDUDIzV2F3WUIyY2tramhqa0h0T3FJTnFiY2dDeXl1NTVw?=
 =?utf-8?B?dUI5Q1RpK2IrcFV3UDg1RWtheEMvVHhJN2hHMzhNN3FBZlI3WGticWpVaXJ3?=
 =?utf-8?B?alFXck1GT01HQTgyM21LOWJaUzhMRXpFUW1DeHhJdzlqd09PdTRZSndhMy9N?=
 =?utf-8?B?OE11MWFaZ2NHMU44RXJIZ29nTXZwTFRMaGxCOU8yVWdiUXpGVjZVeUoxY3Fx?=
 =?utf-8?B?UHVyV3dacFQ4MUNLK2tlUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGk2N0F5d3o0ZnJLckJYRDEzU1NYNlczZmFtdUVneUd4Uk5ZZndWbUo0NVU1?=
 =?utf-8?B?Y01LS2lEMnpGd25NMjFBYlpUcTk5ODNxSnlCNW9TTTAzdDZ5a1FENnhIWGc0?=
 =?utf-8?B?MG9PQy9TSEYzMW9pdHhGVDV4RUkyL0x0R29VWWVZNHRIek5HZGdQMXlLWUR1?=
 =?utf-8?B?bm9GRTlKaHJXa21rQzA0b1BpQkRGQ2F6dzVXTFBzaG54V1pVaUkrZldnM3g0?=
 =?utf-8?B?WXl1Y1lsMGJ2LzRQRVRhcU15Sk5HZkVqY2pYTlQwaW5tcXI3ZnQ2NFp5Q081?=
 =?utf-8?B?OENzNW1MUWxnQ3RVNzV6NWFPcUtFckZrRGg1M0F2NEVxaGZsSmJSbGpLUVdX?=
 =?utf-8?B?TlZqaU01ZmphemZwc3NrQkhnQW8vVHRoV09qYVlqSzA5aHQzL2Rwd1dqQnJW?=
 =?utf-8?B?Q0lJN3lRWkFQYkFWbDY2ZzdLZXl1YUMrNEhGbmJ4SUtFT3p4UVJFMkc4VWR1?=
 =?utf-8?B?MjJKN1FvZEhEODBsZGdldUpVN3JDL2JzNEcvNzRtbGJZSjVLei95Qnd3dVZi?=
 =?utf-8?B?akU3THRaWnlkUlNXZnVtYUNjbHNLSFZUdC9LZnQrWFVrYlQ4eWZ5eTUrQ2dx?=
 =?utf-8?B?cUp4dE5IYTV5czBhRSs0bFVBVUh3QjMzWmt5NWVOTnlLa1Z5SHMxRVdHWDJD?=
 =?utf-8?B?QTZLMEtsK0dNa0JUem15eG8rVFZ1dm0xSGFyU1pYWDNsSFBmVWhTeSsrZ2Jz?=
 =?utf-8?B?V01LTHV6Y2t2ZXcva2lBMXR4YlR4aVVEYTYxcVkzbHR5NE9oQWx5V1p4eGhs?=
 =?utf-8?B?Lzd6VndxLy9HcUxsRHd2M3UxQW5xSERKRnA3UngyZmJzb2c3ck9mWmNqbTJM?=
 =?utf-8?B?TVhQb1djYjY3bnVhYlE1bE4yUm9id1NicU83TzZ2ZjdMc2ViVWFTWGdVUHdY?=
 =?utf-8?B?SHJCaW9jZVIyWTQrakhrNHVRSXNKTzA2dit3NjlEbmFaczNYQThobmhlckN5?=
 =?utf-8?B?Vmd5WU9tTkM5bHRadGs2UUZkTkVEK2VRUHl3N0RCTWJvRFJJSktrUWRxdGZT?=
 =?utf-8?B?MU1CWi9Hb0hDV1EycVlDbG9QYncwVEZkRjljRXdFL000dFduZUgybXB4UXo2?=
 =?utf-8?B?ZjFUR2lmRzJTeUU0aEsyaGFVTnlPd1BWeVZpa1MzYjc2WXB3eEhUd2wzVUxS?=
 =?utf-8?B?Tnc0RXJpRVlFSzVxSWo4UXh1MnNWRVZkdzRCcnhoQzVENVY3TDVCaTBpc0Rr?=
 =?utf-8?B?c0pTVkp0ZFIzbHo4Yk85eVEzL1paOFRxUTA2Q2o1M2RNOWpUcXZvbHlMamV0?=
 =?utf-8?B?bzlxRzgyelNSSU1tQmVqSFVxeDlhbU5aRnJmb21tREs0Tkw3WHdnYWlsUXF0?=
 =?utf-8?B?SXl5TjdzYmVaU1o0Y094anZJZ3FWZDVJb0tiYitFeEJJcmVxODRSMnQzUnFC?=
 =?utf-8?B?WlJINENyTW9JWk1GSUZ6WkErOCtuNGdTdmRDNitIQkhYSmlOY3UvbjhuREVt?=
 =?utf-8?B?M2Fka012czhlS2JsL2F4bDhXKzkyMEd3VENnVHU1ZFV6aFRQdHAvZ3Vob09y?=
 =?utf-8?B?Y250ZVZaMVpUTGNUWGZBc2FHOW43Snd5bzFEVXhXNGxmeWwzSWFEYmgyVEJu?=
 =?utf-8?B?dUNIbTBqbHFCdVUyYnc0VnJYWHYxUUFLZFJLRzRka0g4MzBBOTArU1JPM0Zl?=
 =?utf-8?B?eE9mS1B2V2lRVnhsR0tDWndzWDRkRVhuZGZsS0RjN3pzMUsvWnVrMzBBclpR?=
 =?utf-8?B?bmlteGw5K0JSVnVDME41dkxqYVJ3Z1hJS2FVRUZTSHpoZi9tdFd4NGxoSnFS?=
 =?utf-8?B?akVBTGNmd1pRRjBzQjZaTW5pd0U1ZVNLZFVGRVEyTytORjhZLyswQWxDSmxm?=
 =?utf-8?B?MmdFS2hEU2NoQktRNndkNFAvNW56dEswTmtrY0FIY2xvcDg3WGFFOWF0WUNF?=
 =?utf-8?B?ejFSUW4xNGg2Mno3b0NWWkwwUzhiOEJGOEpYRlEvTnJSNFlLT0d4OG1KVHhh?=
 =?utf-8?B?b0VnZFAvdWdobUFFVi93dXJNaXdHRzJUT1JuWUtwZkZrRjVldXZ6RWFhV0wy?=
 =?utf-8?B?aTFxQW1NSGhhY3lOUFUyOU9objJ2Ry92V3FTUy9TZWh4Ym5lRXZXWUIrd0Zq?=
 =?utf-8?B?WG0yeTcvY1I3Y1MycFJqcjIzREljb2lmK3NJR0xHd2VRbTFUVm1iSEkrVS9U?=
 =?utf-8?B?VUlFVUNZaE41MVg1VVlmMnVQQzFFdGtEU3gvL2FjYjNwRCtIZ00zUlpHRkxD?=
 =?utf-8?Q?AFF4ufrdgGUFJ5r86fWQyGw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66305B17D4F67C498143A62D50A3ADE4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057cc732-a510-4613-83a7-08dc7bf97946
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 13:57:39.1454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdEDVlWYv0mYm2O/pH0e7zNytp5DMXJqyeJM9FSLU4UETev3x0YZcNKiv8PkJ8iJ5MJkpt7d8DJFKNfEk46rZhkTBgPifB7mCI/Ty++O6TytXbzyN1lgo59UP1KFAyNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9680
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgWmhlbnpob25nLA0KDQpJIGFscmVhZHkgc2VudCB5b3UgbXkgY29tbWVudHMgYWJvdXQgdGhp
cyBwYXRjaCBlYXJsaWVyIChxdWVzdGlvbiBhYm91dCANCmNoZWNraW5nIHBndHQpIGJ1dCBoZXJl
IGlzIGEgc3R5bGUgcmV2aWV3DQoNCk9uIDIyLzA1LzIwMjQgMDg6MjMsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVu
dHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBz
ZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEZyb206IFlp
IExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPg0KPiBUaGlzIGFkZHMgc3RhZ2UtMSBwYWdlIHRh
YmxlIHdhbGtpbmcgdG8gc3VwcG9ydCBzdGFnZS0xIG9ubHkNCj4gdHJhbnNsdGlvbiBpbiBzY2Fs
YWJsZSBtb2Rlcm4gbW9kZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPiAtLS0NCj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMTcg
KysrKysNCj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAxMjggKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNDEgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiBpbmRl
eCAwZTI0MGQ2ZDU0Li5hYmZkYmQ1ZjY1IDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
IEBAIC01MzQsNiArNTM0LDIzIEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290
RW50cnk7DQo+ICAgI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfQVcgICAgICAgICAgN1VMTCAv
KiBBZGp1c3RlZCBndWVzdC1hZGRyZXNzLXdpZHRoICovDQo+ICAgI2RlZmluZSBWVERfU01fUEFT
SURfRU5UUllfRElEKHZhbCkgICAgKCh2YWwpICYgVlREX0RPTUFJTl9JRF9NQVNLKQ0KPg0KPiAr
I2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfRkxQTSAgICAgICAgICAzVUxMDQo+ICsjZGVmaW5l
IFZURF9TTV9QQVNJRF9FTlRSWV9GTFBUUFRSICAgICAgICh+MHhmZmZVTEwpDQo+ICsNCj4gKy8q
IFBhZ2luZyBTdHJ1Y3R1cmUgY29tbW9uICovDQo+ICsjZGVmaW5lIFZURF9GTF9QVF9QQUdFX1NJ
WkVfTUFTSyAgICAoMVVMTCA8PCA3KQ0KPiArLyogQml0cyB0byBkZWNpZGUgdGhlIG9mZnNldCBm
b3IgZWFjaCBsZXZlbCAqLw0KPiArI2RlZmluZSBWVERfRkxfTEVWRUxfQklUUyAgICAgICAgICAg
OQ0KPiArDQo+ICsvKiBGaXJzdCBMZXZlbCBQYWdpbmcgU3RydWN0dXJlICovDQo+ICsjZGVmaW5l
IFZURF9GTF9QVF9MRVZFTCAgICAgICAgICAgICAxDQo+ICsjZGVmaW5lIFZURF9GTF9QVF9FTlRS
WV9OUiAgICAgICAgICA1MTINCj4gKw0KPiArLyogTWFza3MgZm9yIEZpcnN0IExldmVsIFBhZ2lu
ZyBFbnRyeSAqLw0KPiArI2RlZmluZSBWVERfRkxfUldfTUFTSyAgICAgICAgICAgICAgKDFVTEwg
PDwgMSkNCj4gKyNkZWZpbmUgVlREX0ZMX1BUX0JBU0VfQUREUl9NQVNLKGF3KSAofihWVERfUEFH
RV9TSVpFIC0gMSkgJiBWVERfSEFXX01BU0soYXcpKQ0KPiArI2RlZmluZSBWVERfUEFTSURfRU5U
UllfRlBEICAgICAgICAgKDFVTEwgPDwgMSkgLyogRmF1bHQgUHJvY2Vzc2luZyBEaXNhYmxlICov
DQo+ICsNCj4gICAvKiBTZWNvbmQgTGV2ZWwgUGFnZSBUcmFuc2xhdGlvbiBQb2ludGVyKi8NCj4g
ICAjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9TTFBUUFRSICAgICAofjB4ZmZmVUxMKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+IGluZGV4IDU0NGU4ZjBlNDAuLmNmMjk4MDliYzEgMTAwNjQ0DQo+IC0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gQEAgLTUw
LDYgKzUwLDggQEANCj4gICAvKiBwZSBvcGVyYXRpb25zICovDQo+ICAgI2RlZmluZSBWVERfUEVf
R0VUX1RZUEUocGUpICgocGUpLT52YWxbMF0gJiBWVERfU01fUEFTSURfRU5UUllfUEdUVCkNCj4g
ICAjZGVmaW5lIFZURF9QRV9HRVRfTEVWRUwocGUpICgyICsgKCgocGUpLT52YWxbMF0gPj4gMikg
JiBWVERfU01fUEFTSURfRU5UUllfQVcpKQ0KPiArI2RlZmluZSBWVERfUEVfR0VUX0ZMUFRfTEVW
RUwocGUpIFwNCj4gKyAgICAoNCArICgoKHBlKS0+dmFsWzJdID4+IDIpICYgVlREX1NNX1BBU0lE
X0VOVFJZX0ZMUE0pKQ0KPg0KPiAgIC8qDQo+ICAgICogUENJIGJ1cyBudW1iZXIgKG9yIFNJRCkg
aXMgbm90IHJlbGlhYmxlIHNpbmNlIHRoZSBkZXZpY2UgaXMgdXNhdWxseQ0KPiBAQCAtODIzLDYg
KzgyNSwxMSBAQCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRl
bElPTU1VU3RhdGUgKnMsDQo+ICAgICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFC
TEVfRU5UUllfSU5WOw0KPiAgICAgICB9DQo+DQo+ICsgICAgaWYgKHBndHQgPT0gVlREX1NNX1BB
U0lEX0VOVFJZX0ZMVCAmJg0KPiArICAgICAgICBWVERfUEVfR0VUX0ZMUFRfTEVWRUwocGUpICE9
IDQpIHsNCk1heWJlIHlvdSBjb3VsZCBhZGQgYSBmdW5jdGlvbiB0byBjaGVjayBpZiB0aGUgbGV2
ZWwgaXMgc3VwcG9ydGVkLg0KQW5kIGl0IHdvdWxkIGFsc28gYmUgbmljZSB0byByZW5hbWUgdnRk
X2lzX2xldmVsX3N1cHBvcnRlZCAodXNlZCBqdXN0IA0KYWJvdmUgdGhlc2UgbGluZXMpIHRvIG1h
a2UgaXQgY2xlYXIgdGhhdCBpdCdzIG9ubHkgcmVsZXZhbnQgZm9yIHNlY29uZCANCmxldmVsIHRy
YW5zbGF0aW9ucyBhbmQgYXZvaWQgbWlzdGFrZXMNCj4gKyAgICAgICAgICAgIHJldHVybiAtVlRE
X0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVjsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgcmV0dXJu
IDA7DQo+ICAgfQ0KPg0KPiBAQCAtOTU4LDcgKzk2NSwxMSBAQCBzdGF0aWMgdWludDMyX3QgdnRk
X2dldF9pb3ZhX2xldmVsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4NCj4gICAgICAgaWYgKHMtPnJv
b3Rfc2NhbGFibGUpIHsNCj4gICAgICAgICAgIHZ0ZF9jZV9nZXRfcmlkMnBhc2lkX2VudHJ5KHMs
IGNlLCAmcGUsIHBhc2lkKTsNCj4gLSAgICAgICAgcmV0dXJuIFZURF9QRV9HRVRfTEVWRUwoJnBl
KTsNCj4gKyAgICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPiArICAgICAgICAgICAg
cmV0dXJuIFZURF9QRV9HRVRfRkxQVF9MRVZFTCgmcGUpOw0KPiArICAgICAgICB9IGVsc2Ugew0K
PiArICAgICAgICAgICAgcmV0dXJuIFZURF9QRV9HRVRfTEVWRUwoJnBlKTsNCnNhbWUsIGNvdWxk
IGJlIHJlbmFtZWQNCj4gKyAgICAgICAgfQ0KPiAgICAgICB9DQo+DQo+ICAgICAgIHJldHVybiB2
dGRfY2VfZ2V0X2xldmVsKGNlKTsNCj4gQEAgLTEwNDUsNyArMTA1NiwxMSBAQCBzdGF0aWMgZG1h
X2FkZHJfdCB2dGRfZ2V0X2lvdmFfcGd0YmxfYmFzZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+DQo+
ICAgICAgIGlmIChzLT5yb290X3NjYWxhYmxlKSB7DQo+ICAgICAgICAgICB2dGRfY2VfZ2V0X3Jp
ZDJwYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBwYXNpZCk7DQo+IC0gICAgICAgIHJldHVybiBwZS52
YWxbMF0gJiBWVERfU01fUEFTSURfRU5UUllfU0xQVFBUUjsNCj4gKyAgICAgICAgaWYgKHMtPnNj
YWxhYmxlX21vZGVybikgew0KPiArICAgICAgICAgICAgcmV0dXJuIHBlLnZhbFsyXSAmIFZURF9T
TV9QQVNJRF9FTlRSWV9GTFBUUFRSOw0KPiArICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAg
ICAgcmV0dXJuIHBlLnZhbFswXSAmIFZURF9TTV9QQVNJRF9FTlRSWV9TTFBUUFRSOw0KPiArICAg
ICAgICB9DQo+ICAgICAgIH0NCj4NCj4gICAgICAgcmV0dXJuIHZ0ZF9jZV9nZXRfc2xwdF9iYXNl
KGNlKTsNCj4gQEAgLTE4NDcsNiArMTg2MiwxMDYgQEAgb3V0Og0KPiAgICAgICB0cmFjZV92dGRf
cHRfZW5hYmxlX2Zhc3RfcGF0aChzb3VyY2VfaWQsIHN1Y2Nlc3MpOw0KPiAgIH0NCj4NCj4gKy8q
IFRoZSBzaGlmdCBvZiBhbiBhZGRyIGZvciBhIGNlcnRhaW4gbGV2ZWwgb2YgcGFnaW5nIHN0cnVj
dHVyZSAqLw0KPiArc3RhdGljIGlubGluZSB1aW50MzJfdCB2dGRfZmxwdF9sZXZlbF9zaGlmdCh1
aW50MzJfdCBsZXZlbCkNCj4gK3sNCj4gKyAgICBhc3NlcnQobGV2ZWwgIT0gMCk7DQo+ICsgICAg
cmV0dXJuIFZURF9QQUdFX1NISUZUXzRLICsgKGxldmVsIC0gMSkgKiBWVERfRkxfTEVWRUxfQklU
UzsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIEdpdmVuIGFuIGlvdmEgYW5kIHRoZSBsZXZlbCBv
ZiBwYWdpbmcgc3RydWN0dXJlLCByZXR1cm4gdGhlIG9mZnNldA0KPiArICogb2YgY3VycmVudCBs
ZXZlbC4NCj4gKyAqLw0KPiArc3RhdGljIGlubGluZSB1aW50MzJfdCB2dGRfaW92YV9mbF9sZXZl
bF9vZmZzZXQodWludDY0X3QgaW92YSwgdWludDMyX3QgbGV2ZWwpDQo+ICt7DQo+ICsgICAgcmV0
dXJuIChpb3ZhID4+IHZ0ZF9mbHB0X2xldmVsX3NoaWZ0KGxldmVsKSkgJg0KPiArICAgICAgICAg
ICAgKCgxVUxMIDw8IFZURF9GTF9MRVZFTF9CSVRTKSAtIDEpOw0KPiArfQ0KPiArDQo+ICsvKiBH
ZXQgdGhlIGNvbnRlbnQgb2YgYSBmbHB0ZSBsb2NhdGVkIGluIEBiYXNlX2FkZHJbQGluZGV4XSAq
Lw0KPiArc3RhdGljIHVpbnQ2NF90IHZ0ZF9nZXRfZmxwdGUoZG1hX2FkZHJfdCBiYXNlX2FkZHIs
IHVpbnQzMl90IGluZGV4KQ0KPiArew0KPiArICAgIHVpbnQ2NF90IGZscHRlOw0KPiArDQo+ICsg
ICAgYXNzZXJ0KGluZGV4IDwgVlREX0ZMX1BUX0VOVFJZX05SKTsNCj4gKw0KPiArICAgIGlmIChk
bWFfbWVtb3J5X3JlYWQoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgYmFzZV9hZGRyICsgaW5kZXggKiBzaXplb2YoZmxwdGUpLCAmZmxwdGUsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoZmxwdGUpLCBNRU1UWEFUVFJTX1VOU1BFQ0lG
SUVEKSkgew0KPiArICAgICAgICBmbHB0ZSA9ICh1aW50NjRfdCktMTsNCj4gKyAgICAgICAgcmV0
dXJuIGZscHRlOw0KPiArICAgIH0NCj4gKyAgICBmbHB0ZSA9IGxlNjRfdG9fY3B1KGZscHRlKTsN
Cj4gKyAgICByZXR1cm4gZmxwdGU7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB2
dGRfZmxwdGVfcHJlc2VudCh1aW50NjRfdCBmbHB0ZSkNCj4gK3sNCj4gKyAgICByZXR1cm4gISEo
ZmxwdGUgJiAweDEpOw0KU2hvdWxkbid0IHdlIHVzZSBhICNkZWZpbmUgaW5zdGVhZCBvZiBoYXJk
Y29kaW5nIHRoZSBtYXNrPw0KPiArfQ0KPiArDQo+ICsvKiBXaGV0aGVyIHRoZSBwdGUgaW5kaWNh
dGVzIHRoZSBhZGRyZXNzIG9mIHRoZSBwYWdlIGZyYW1lICovDQo+ICtzdGF0aWMgaW5saW5lIGJv
b2wgdnRkX2lzX2xhc3RfZmxwdGUodWludDY0X3QgZmxwdGUsIHVpbnQzMl90IGxldmVsKQ0KPiAr
ew0KPiArICAgIHJldHVybiBsZXZlbCA9PSBWVERfRkxfUFRfTEVWRUwgfHwgKGZscHRlICYgVlRE
X0ZMX1BUX1BBR0VfU0laRV9NQVNLKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSB1aW50
NjRfdCB2dGRfZ2V0X2ZscHRlX2FkZHIodWludDY0X3QgZmxwdGUsIHVpbnQ4X3QgYXcpDQo+ICt7
DQo+ICsgICAgcmV0dXJuIGZscHRlICYgVlREX0ZMX1BUX0JBU0VfQUREUl9NQVNLKGF3KTsNCj4g
K30NCj4gKw0KPiArLyoNCj4gKyAqIEdpdmVuIHRoZSBAaW92YSwgZ2V0IHJlbGV2YW50IEBmbHB0
ZXAuIEBmbHB0ZV9sZXZlbCB3aWxsIGJlIHRoZSBsYXN0IGxldmVsDQo+ICsgKiBvZiB0aGUgdHJh
bnNsYXRpb24sIGNhbiBiZSB1c2VkIGZvciBkZWNpZGluZyB0aGUgc2l6ZSBvZiBsYXJnZSBwYWdl
Lg0KPiArICovDQo+ICtzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0
ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3QgaW92YSwgYm9vbCBpc193cml0ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDY0X3QgKmZscHRlcCwgdWludDMyX3QgKmZscHRlX2xldmVsLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBib29sICpyZWFkcywgYm9vbCAqd3JpdGVzLCB1aW50
OF90IGF3X2JpdHMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBh
c2lkKQ0KPiArew0KPiArICAgIGRtYV9hZGRyX3QgYWRkciA9IHZ0ZF9nZXRfaW92YV9wZ3RibF9i
YXNlKHMsIGNlLCBwYXNpZCk7DQo+ICsgICAgdWludDMyX3QgbGV2ZWwgPSB2dGRfZ2V0X2lvdmFf
bGV2ZWwocywgY2UsIHBhc2lkKTsNCj4gKyAgICB1aW50MzJfdCBvZmZzZXQ7DQo+ICsgICAgdWlu
dDY0X3QgZmxwdGU7DQo+ICsNCj4gKyAgICB3aGlsZSAodHJ1ZSkgew0KPiArICAgICAgICBvZmZz
ZXQgPSB2dGRfaW92YV9mbF9sZXZlbF9vZmZzZXQoaW92YSwgbGV2ZWwpOw0KPiArICAgICAgICBm
bHB0ZSA9IHZ0ZF9nZXRfZmxwdGUoYWRkciwgb2Zmc2V0KTsNCj4gKyAgICAgICAgaWYgKGZscHRl
ID09ICh1aW50NjRfdCktMSkgew0KPiArICAgICAgICAgICAgaWYgKGxldmVsID09IHZ0ZF9nZXRf
aW92YV9sZXZlbChzLCBjZSwgcGFzaWQpKSB7DQo+ICsgICAgICAgICAgICAgICAgLyogSW52YWxp
ZCBwcm9ncmFtbWluZyBvZiBjb250ZXh0LWVudHJ5ICovDQo+ICsgICAgICAgICAgICAgICAgcmV0
dXJuIC1WVERfRlJfQ09OVEVYVF9FTlRSWV9JTlY7DQo+ICsgICAgICAgICAgICB9IGVsc2Ugew0K
PiArICAgICAgICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBR0lOR19FTlRSWV9JTlY7DQo+ICsg
ICAgICAgICAgICB9DQo+ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICBpZiAoIXZ0ZF9mbHB0
ZV9wcmVzZW50KGZscHRlKSkgew0KPiArICAgICAgICAgICAgKnJlYWRzID0gZmFsc2U7DQo+ICsg
ICAgICAgICAgICAqd3JpdGVzID0gZmFsc2U7DQo+ICsgICAgICAgICAgICByZXR1cm4gLVZURF9G
Ul9QQUdJTkdfRU5UUllfSU5WOw0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgKnJlYWRz
ID0gdHJ1ZTsNCj4gKyAgICAgICAgKndyaXRlcyA9ICgqd3JpdGVzKSAmJiAoZmxwdGUgJiBWVERf
RkxfUldfTUFTSyk7DQo+ICsgICAgICAgIGlmIChpc193cml0ZSAmJiAhKGZscHRlICYgVlREX0ZM
X1JXX01BU0spKSB7DQo+ICsgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9XUklURTsNCj4gKyAg
ICAgICAgfQ0KPiArDQo+ICsgICAgICAgIGlmICh2dGRfaXNfbGFzdF9mbHB0ZShmbHB0ZSwgbGV2
ZWwpKSB7DQo+ICsgICAgICAgICAgICAqZmxwdGVwID0gZmxwdGU7DQo+ICsgICAgICAgICAgICAq
ZmxwdGVfbGV2ZWwgPSBsZXZlbDsNCj4gKyAgICAgICAgICAgIHJldHVybiAwOw0KPiArICAgICAg
ICB9DQo+ICsNCj4gKyAgICAgICAgYWRkciA9IHZ0ZF9nZXRfZmxwdGVfYWRkcihmbHB0ZSwgYXdf
Yml0cyk7DQo+ICsgICAgICAgIGxldmVsLS07DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICAgc3Rh
dGljIHZvaWQgdnRkX3JlcG9ydF9mYXVsdChJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQgZXJyLCBib29sIGlzX2ZwZF9zZXQsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBzb3VyY2VfaWQsDQo+IEBAIC0xOTk1
LDggKzIxMTAsMTMgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRy
ZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0N
Cj4NCj4gLSAgICByZXRfZnIgPSB2dGRfaW92YV90b19zbHB0ZShzLCAmY2UsIGFkZHIsIGlzX3dy
aXRlLCAmcHRlLCAmbGV2ZWwsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJl
YWRzLCAmd3JpdGVzLCBzLT5hd19iaXRzLCBwYXNpZCk7DQo+ICsgICAgaWYgKHMtPnNjYWxhYmxl
X21vZGVybikgew0KPiArICAgICAgICByZXRfZnIgPSB2dGRfaW92YV90b19mbHB0ZShzLCAmY2Us
IGFkZHIsIGlzX3dyaXRlLCAmcHRlLCAmbGV2ZWwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZyZWFkcywgJndyaXRlcywgcy0+YXdfYml0cywgcGFzaWQpOw0KPiArICAg
IH0gZWxzZSB7DQo+ICsgICAgICAgIHJldF9mciA9IHZ0ZF9pb3ZhX3RvX3NscHRlKHMsICZjZSwg
YWRkciwgaXNfd3JpdGUsICZwdGUsICZsZXZlbCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnJlYWRzLCAmd3JpdGVzLCBzLT5hd19iaXRzLCBwYXNpZCk7DQo+ICsgICAg
fQ0KPg0KPiAgICAgICBpZiAocmV0X2ZyKSB7DQo+ICAgICAgICAgICB2dGRfcmVwb3J0X2ZhdWx0
KHMsIC1yZXRfZnIsIGlzX2ZwZF9zZXQsIHNvdXJjZV9pZCwNCj4gLS0NCj4gMi4zNC4xDQo+DQoj
Y21k

