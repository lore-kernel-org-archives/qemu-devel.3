Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F74BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRc-0007yK-4b; Tue, 02 Jul 2024 01:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRY-0007vD-Lj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:44 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRW-0006V4-OR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899563; x=1751435563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xT1iq8H2X9LjoI1WXr5hydii1xUTqbqC9xfPC6Rzqcw=;
 b=kLabdy3jWzF+oHzSQsX5ubBDqka+h7GXewSRIL7+wLzTHV8uKiiDhgOG
 MXMMKJrRfbbyUt6YG5g95PYwdIPmfyXgKkbW2uPAowHbDHzS2YV4VtAQl
 D/k+CCkyldslvJzvLhm7MUljkpQcOQb55bqrK0wmnw8QkRmomYmmqOhAq
 yYg/vGxq9Di/3JCsa/yaJl3gy6MNUFIkslocqw78Qdygn/IG/oP1vFz9C
 we7b5I0UVdPlSag/m93EhdIksheDV2F5PuSOEJH9HGsvPPMOcLZoYui7E
 GtTyVD+ue9qlMrWbSZw5DJS3a8Z4iZhsX/mMh2gT365YK8MzKk1h+5PdM A==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721582"
X-MGA-submission: =?us-ascii?q?MDH+rzUsov1EpOQpXUHmoB8GQuOMoQSVXsL/tN?=
 =?us-ascii?q?D9FjATf7jLcAnYlT1wbn1nKa3gOxg2wcdx5wNuEhEPDCc4vjM/10pXwo?=
 =?us-ascii?q?Jo8m23zNEzWa4l3ST+bjzlZpLXk8HwHD8jvAFH2PhFrUMctM40e7gm7L?=
 =?us-ascii?q?z5lnf8JXdz+dpM1qCiC9qEqw=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzjB3CIrSp80mMorSbqE7Ds9DwkHIOHU5dHflRnFD3/8QhecrN6CIlRP6m6JU/u+xmAn8HRJdV+ieMHy0IDw+4Y/3I4VzzJTQU9qH3WZspCHzEGTZt4LY29EVhVIK8vwa3yMUSRvKNd7JZsvkaGIJdm8IspEUsqWYxA+1MTKTjeGBd2zm4n5a1TiCcqp5GBC4f7V1r9av2dMhJUMsEqSwzeVR7QPDeDXSfE37isrzbxMeGTF78vDHPWZFDN1ytG1o1EoYSq0fVSbj7/SwGfrUWz6VoeoP4d7eGr0CSQWJjfx7zBoBzi0LhZvLEhmF3CcnT3brl6CzfLoQmEGsuwkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT1iq8H2X9LjoI1WXr5hydii1xUTqbqC9xfPC6Rzqcw=;
 b=cYCVxIu38mP87LE4p8gA2b5kl4mAVmcGJYG2oRN8XFquf+B2J8kmZuQvl9nbGkR54b6YeG659Ak9kTsuNN+JtzrkK8v8OVGxiVlwy5Z0sU1VrwseDmWgZ7apZb6lCzlLDRXxkj9Oygj/iGVekpn07ZkZEkVDrUxwuFFlOKh/Ji+XWHSsPC8/bk9N0mQQWN+G6Q49tPZjmTNkMnjB9sOXwSCfXlkGSlbKe8H1+2ZtYK0BNuXBlSeXJqSx/eSe6GKBsvfTAbqkfOkxEuIGKLg0CpCTtxVB879T8pXAvSe3ZBxxG3p7H4CJIu2OMOCHAhrM1CtGGIQ2XF6pyLC8mSx84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT1iq8H2X9LjoI1WXr5hydii1xUTqbqC9xfPC6Rzqcw=;
 b=O1MIF+bwmgZLGAMFPKgfdqpG/GHtBQi3jZS2DQrnnew5B1Zn6jEaKag7pwWZQtNXQHBwOLLjE7K5Dyt8TpjL02TNX+BNOpxRUvSGVTYIN2sKLQdAftVdOQttSoz/9F9JK6hVyC09gLSgnk/SN8nF7h5CyMReA/tRnbWwdhnTc6Ylz0xMyKHRlA8Q5/qZfsR9/F+K7I3CpoGoNUcd6fkuaYliMB3M0YWQPhIFH4qBZvpjeYtb5KR8wKdPOQ2G5WWBVPEbUZKiZ5YtrSYKjpvb/WcwT1NilwXNDdlzaYdOiCgn0OyLDdxsTgGwCVNqysAzg0MlQ5PWyKEYhwfJicNFbA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:34 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 05/22] memory: add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH ats_vtd v5 05/22] memory: add permissions in
 IOMMUAccessFlags
Thread-Index: AQHazEQJr4vF14tba02zG7kBavDB/g==
Date: Tue, 2 Jul 2024 05:52:34 +0000
Message-ID: <20240702055221.1337035-6-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 1c3be23f-6469-4c11-57e9-08dc9a5b2bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qzlzd3RwSmVMOUs0bG05RUs2akN6cTJJLzA0RHVOcTl0QUI3TEEvNWVKcVZ1?=
 =?utf-8?B?enJWM2ZrLytnUUo1S01Wb1ozT3p4YnVWcTNtaU1jN2x4Um54SjB2ditIZVh4?=
 =?utf-8?B?NmhoM05KQ092SW1NcGR6dHNVZTFwM3RaekJKd1YxZ0NZMTk0SEJmTXh5STIw?=
 =?utf-8?B?Si9NZzFQRTRkajhJQ1g5WnJlOVBZdCtCYmpvTTExKzZOWEx1SDJDT09YVXVS?=
 =?utf-8?B?OXNRRndsd1dLMkF6RlBNTm9vNlJabEFDRjEySEEveWdjWWlYc242cDZXeFlK?=
 =?utf-8?B?RFQyc3prR1czRVk4ZGpKcFR6elZFRXVrNGMwbm4vRVVTemk3K3BIYmpmVWVk?=
 =?utf-8?B?a0FwdDVlSEVlTG1uUlB5UFRwM0gxSmtkaE0rQ2NqNmRhUVdyMC9zZ0Q2cDJq?=
 =?utf-8?B?TklxdjhYaEJDR2lsNWU0cmtSMm9yNzBiZmNmd2ZwMnZFNTFhTmw2VWpldTdy?=
 =?utf-8?B?bFpFNy81Szk2ZndTb2lSTjJ3MnRjSG95M1RnTXdiTzBTY0JUeURGREhOMUNU?=
 =?utf-8?B?dHZQNGlqRlBTSmcwQjQxT2Z5TExJNWJwck5MdUxnQ3BCS2NOaTVyZ0E4NmNy?=
 =?utf-8?B?VVNrLzVZbjYvN3RZb1JMWkZNeXY5Mmo3OGg5OStoVHJVaGMyME9UOVh4MTBZ?=
 =?utf-8?B?UTZjOU9QNGhPOXpvREdZdHYvc1VpREZYUllZNDlOZWxIdTFiWStjWnRpc0dz?=
 =?utf-8?B?aVd0ZnpLWmh0YWh0RGFqTEpMTm00aS9zZS9Samd0V3hnS09nQUVONUIxMVFr?=
 =?utf-8?B?QmlDNWVvR3YyOTNwVzc4U0lkcWczZHRKMnBDaGZFN2xNWGVOOGNmZ3dmaWkx?=
 =?utf-8?B?Mk1INzk1K0pqSFp5UU9VT1NaVitRc3BtWHMwREtmZFBBbzBQZTVjUTVCVFhL?=
 =?utf-8?B?SlNJUjh6ZGxyc1B4QnpQcEpSQmNtdVc3cFpvSHBXNEhwRk1VRDhGYTV1SzFQ?=
 =?utf-8?B?aTdlcTBlS3BCb2NSN214amdTN0JQNDhFMDgxL2JYaUx3QlhkS0tUTHB4LzJH?=
 =?utf-8?B?bVZmUXY2eEZMVEVGRFZKbUk3VFBMemF5MzNhYklOeVNWMGtVRFpDZCtIOHQv?=
 =?utf-8?B?bjBGZU5WSWErRGRCaWY0aktlaW02WU9DV1ExMGxkK05KZHRzSTkydGUzYXJo?=
 =?utf-8?B?VXpTdWlQNXRBQWV4eHIxRG5DYkVQaDVxRkZ6S1NUOWJyRU9hTVB0MFV3ZjRT?=
 =?utf-8?B?QUZiOTBZSXo4V0RqMVVmUitNMkQwd2ZjTVMzZjJ0UUJTSEUyVTVRZ0NLWlZR?=
 =?utf-8?B?K1c2L1BBRDhKKzBvWlRGeTNnWVJsSng4SHNvcFMya3l2SWxIRGVHb1RGRVhz?=
 =?utf-8?B?dGZtdTdlblBqRmlLdC9ORWttRFhnWTQrcFIrOEgrVkFabEgxZ05BaTZkRW13?=
 =?utf-8?B?VHQyUk1OcncrUXVvUkprR2FkdlZpYUo3TnY4OFlMZ0pKVEJoOUR5ZzYyTmtY?=
 =?utf-8?B?amU2ZmlWT0hTSmZUL2Jka0kyU2wvNUJVaUc0dzRyakh2d1VOMENkc2FnNGpz?=
 =?utf-8?B?NlNjQTd3c1FsSTdWN1VZSnhweU94ZXJyYnBTRmg5YlFMRkdDOTZFNWlIcnVH?=
 =?utf-8?B?THllRVNXdDNrVGFXY2ZkbFJkY1oweHlUaTc4a2Z2azVzc09ETllPNjZBdGlI?=
 =?utf-8?B?bGg5RTBraFVKSVBvSmpSRjR5a3FKcHp5WkwrV2lmY05wSmV3c21vZU5leXQ3?=
 =?utf-8?B?Y0ZWU3VpL0dSdVk4bHdTQ1AzLzNybVN3cWVPT2ZkYTBPTFB0RlI1bXMvdEZG?=
 =?utf-8?B?REtWaEdOTUxiVC9iM0FTWlJacEZXalNnWDJGL1VuTmxDandnZ3BoS0FKc0RT?=
 =?utf-8?B?a1g1WVBsSm5zeEg3ejNCZWxZZzQrdnFoWlEzckRPSkg4QUZJaERoMnBGS2dX?=
 =?utf-8?B?NVFwM0lNaWJSNE13dzdRMkFSNXE5Z1NOM3BHN29rQzNnT3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3lpNXlhMUZjdHhZUHlMcWJDcC9TMTZNZU1QcjcrRGhVb1Yxb0thVFRBWDZ6?=
 =?utf-8?B?T2Yxb2o0WkY1aVdPRzRSc2tVNXloSVRqeTVXNFVDQzZiWHRoUTQ0VVQwakNx?=
 =?utf-8?B?T09sR2dtUW5YdTlUVlVDRDJxakRjdU5obzRaZEsrQWFOWEFmMlFHK0NtOGEw?=
 =?utf-8?B?UU9RUUJINkVkZkZVVWZRVkNjRXlkRHhxZlp1aGNBdDQ3M3RseHIxZ1J0ajAx?=
 =?utf-8?B?ajhON1U1QThlZmxOMWhRcUNibWRqT3VodU1RUVR1NDlSN25wSmMrRHBYM2o0?=
 =?utf-8?B?b0UxdEdDQ1ZDMTV5eW1XMHZ4eFFZUThqd0xrSDlkY2piUEIyU0NIQU5QMmsx?=
 =?utf-8?B?eVBtd0ZuSVJIOGxBZ29CSUIrWFR6K3F0dnpQbnpLczEvQ2J5bDh2ZU1CdWti?=
 =?utf-8?B?YyswRW92TERDc0ZPcmZVQkxNMWxXTEM2Vmk4bU95R0lIRG5UOHdOdmxxY3ht?=
 =?utf-8?B?dE51dDIwS0l6bTZtUTZrZm9NZVlESWtFcFF1WVd3R3IzbnFYVUZkNVJQaEl5?=
 =?utf-8?B?cWRVdUsxbnRpQUxLVVdXQnFDcTJZOUhlZXRNWVUxOUtPd2VWbGduQ0Rnc094?=
 =?utf-8?B?cjRHbmxhcXdzdktheDlvVjVEcmRubnJONDBIZmhPK3dvbDg3QisxWWprYlNC?=
 =?utf-8?B?RUw3QklXOG1vQjE5RDZGM0IybWRRdDQ5Q0dTaTZ1Y2ZYbkE0TXlRVC9CMC9L?=
 =?utf-8?B?VFlGbGNkUGsxNDk1aC9Tak80ZjNRbi9qaGlUV0dTSXBIODl2SWZIUWVMZzR0?=
 =?utf-8?B?eEZ3czRpUnlZSUdkS1NoMWd4L08rTnhVYkRVdmlTaWFyK082VGU1NUg5b1R6?=
 =?utf-8?B?YzdNS0U4N2FBNVdtdzlKVVVkZWpnRmx5K3JjOFdua0JMRUpqTHovZEFEUENs?=
 =?utf-8?B?SzdhRXVSWExoakxETUN2SFhYQWgzWUJLdXVYR2JJeWFkN2xONHRlWVZOWm9j?=
 =?utf-8?B?akRJQjFMK1JKM3JuOTZTUVV5MVcvWUFNbXJ5SjI1QTZ1MzFPcXhDQi9vd3Y4?=
 =?utf-8?B?ZEtnOVdja1diYnpSL24vRFYrak5CK1FpdUhDU05VQ1FKS3Z6SGNNV1RMWXNZ?=
 =?utf-8?B?dHlFeENUUit3anR1VitLMkR1ZWZLU3V6NVRYVXhWdjg1MnlHU2VIYWptQjZu?=
 =?utf-8?B?WUZXTU1FMlNOMThlSkdpRHpWd1Joc0JubUhLSlFjenZFNWxHemU1aUx1WVQ3?=
 =?utf-8?B?cVNodkxCcmNUemVKNmswQkRTY0F4VlFsbWlZaDBiWDFXNktuSzdIVXNtSUw5?=
 =?utf-8?B?QTFzdHRoR1VrMC9MWEd3OFJnK2h4S0QzUEhXRm4zOXJqRGdOMWlTeEQyZGVn?=
 =?utf-8?B?eTVYYWJSMHJNSGJLY3ZrV2NKQlNmZGphVHAvRytiYXM0ejNiNEtkZzFPZXU4?=
 =?utf-8?B?SjNPVkhoYWhnOE5YdnJtV2Vpd1g2M1I4blpvR05vU1drSWNGVUhWREIwR2ZJ?=
 =?utf-8?B?SDJEMmVhZDh3QytpREN5ajNnRHVWNldlR1hrUkdybzhITGZDRGliMkdxVHRi?=
 =?utf-8?B?eVJjSGNuUEdKTkcvZVVBbkFlczZ1MkN6Z3dGbHRZbCtYRGtxOTFwYm9NZ1Ri?=
 =?utf-8?B?SEo0MnhuenZRYjlHL2t0K2NEM3o3S3BQWGF3b2x0aFFlZElndk9VVmNnaFdZ?=
 =?utf-8?B?RE93V3B3YVRqOGI3c3pCR3R1OEkrc0R2QUsxMmFBdExjeVhmYTZqMTZwSkFl?=
 =?utf-8?B?cHJFbk5Jd1p1emFnejd1bkk2eDVRbTBQeXpoS1MyalNKOHhpcmY5UFppcnRn?=
 =?utf-8?B?UDcyN3BoakE4SGpzUFFLa1JuN2I5SVhCLzhwYzd1M1l1MEFVSVNzMkQwK0s5?=
 =?utf-8?B?VkFON0RyM2FKcEtGRFVMeldzS3k1dkpWdlVKYXVnaGkvRE92dlhNS21kOTln?=
 =?utf-8?B?TjdyaHhpZ2xkbWZrOHhDN3BSSHZqeHRaNndiRW82aWN6RTg2aDJzQVJpUS9x?=
 =?utf-8?B?dXBGemQvOUUxb3FFYW1qMkxUVUZXd2l1SCtwMkpsak1CcGxtUnhKMkFyaWkz?=
 =?utf-8?B?V2E2RkdGOTZZTUMyZzlMQXF4dGplRFlyUFMrSXB2aEhCanZOK29VcG1TTnlU?=
 =?utf-8?B?dzVnQlgyeE14NGE2QVdaRjR1KzN0V3pOYTJyUC9ZTzU1MkVoek9ZMEFFM282?=
 =?utf-8?B?UkpqbmhqRklBcm9Ta1BsN2ZKdVhhN29lUXM3RVBqcHBJVWY0cEhuaENQNXQr?=
 =?utf-8?Q?gGKoC4BoL48dkje9ni6AN6A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B613EF274F61E94EBC9841C4BF9ED18A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3be23f-6469-4c11-57e9-08dc9a5b2bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:34.7748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHmkaJzkvYgjswybdygVxkJjQzxU+uaePNscyMy1wy1CMzknH2+8qoC8CMdlC6zL98Wgek/Gx/nFbceR/jRuohsaapygXOrZS3GRzmvb/QOgrODcjwueMNfDtYZvsWzL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoaXMgd2lsbCBiZSBuZWNlc3NhcnkgZm9yIGRldmljZXMgaW1wbGVtZW50aW5n
IEFUUy4NCldlIGFsc28gZGVmaW5lIGEgbmV3IG1hY3JvIElPTU1VX0FDQ0VTU19GTEFHX0ZVTEwg
aW4gYWRkaXRpb24gdG8NCklPTU1VX0FDQ0VTU19GTEFHIHRvIHN1cHBvcnQgbW9yZSBhY2Nlc3Mg
ZmxhZ3MuDQpJT01NVV9BQ0NFU1NfRkxBRyBpcyBrZXB0IGZvciBjb252ZW5pZW5jZSBhbmQgYmFj
a3dhcmQgY29tcGF0aWJpbGl0eS4NCg0KSGVyZSBhcmUgdGhlIGZsYWdzIGFkZGVkIChkZWZpbmVk
IGJ5IHRoZSBQQ0llIDUgc3BlY2lmaWNhdGlvbikgOg0KICAgIC0gRXhlY3V0ZSBSZXF1ZXN0ZWQN
CiAgICAtIFByaXZpbGVnZWQgTW9kZSBSZXF1ZXN0ZWQNCiAgICAtIEdsb2JhbA0KICAgIC0gVW50
cmFuc2xhdGVkIE9ubHkNCg0KSU9NTVVfQUNDRVNTX0ZMQUcgc2V0cyB0aGUgYWRkaXRpb25hbCBm
bGFncyB0byAwDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5o
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1v
cnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggMWJlNThmNjk0Yy4uYWE4ZTExNGU3
NyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVkZS9leGVj
L21lbW9yeS5oDQpAQCAtMTEwLDE1ICsxMTAsMzQgQEAgc3RydWN0IE1lbW9yeVJlZ2lvblNlY3Rp
b24gew0KIA0KIHR5cGVkZWYgc3RydWN0IElPTU1VVExCRW50cnkgSU9NTVVUTEJFbnRyeTsNCiAN
Ci0vKiBTZWUgYWRkcmVzc19zcGFjZV90cmFuc2xhdGU6IGJpdCAwIGlzIHJlYWQsIGJpdCAxIGlz
IHdyaXRlLiAgKi8NCisvKg0KKyAqIFNlZSBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZToNCisgKiAg
ICAgIC0gYml0IDAgOiByZWFkDQorICogICAgICAtIGJpdCAxIDogd3JpdGUNCisgKiAgICAgIC0g
Yml0IDIgOiBleGVjDQorICogICAgICAtIGJpdCAzIDogcHJpdg0KKyAqICAgICAgLSBiaXQgNCA6
IGdsb2JhbA0KKyAqICAgICAgLSBiaXQgNSA6IHVudHJhbnNsYXRlZCBvbmx5DQorICovDQogdHlw
ZWRlZiBlbnVtIHsNCiAgICAgSU9NTVVfTk9ORSA9IDAsDQogICAgIElPTU1VX1JPICAgPSAxLA0K
ICAgICBJT01NVV9XTyAgID0gMiwNCiAgICAgSU9NTVVfUlcgICA9IDMsDQorICAgIElPTU1VX0VY
RUMgPSA0LA0KKyAgICBJT01NVV9QUklWID0gOCwNCisgICAgSU9NTVVfR0xPQkFMID0gMTYsDQor
ICAgIElPTU1VX1VOVFJBTlNMQVRFRF9PTkxZID0gMzIsDQogfSBJT01NVUFjY2Vzc0ZsYWdzOw0K
IA0KLSNkZWZpbmUgSU9NTVVfQUNDRVNTX0ZMQUcociwgdykgKCgocikgPyBJT01NVV9STyA6IDAp
IHwgKCh3KSA/IElPTU1VX1dPIDogMCkpDQorI2RlZmluZSBJT01NVV9BQ0NFU1NfRkxBRyhyLCB3
KSAgICAgKCgocikgPyBJT01NVV9STyA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgodykgPyBJT01NVV9XTyA6IDApKQ0KKyNkZWZpbmUgSU9NTVVfQUNDRVNT
X0ZMQUdfRlVMTChyLCB3LCB4LCBwLCBnLCB1bykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIChJT01NVV9BQ0NFU1NfRkxBRyhyLCB3KSB8IFwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoKHgpID8gSU9NTVVfRVhFQyA6IDApIHwgXA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgocCkgPyBJT01NVV9QUklWIDogMCkgfCBc
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChnKSA/IElPTU1VX0dMT0JB
TCA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodW8pID8g
SU9NTVVfVU5UUkFOU0xBVEVEX09OTFkgOiAwKSkNCiANCiBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7
DQogICAgIEFkZHJlc3NTcGFjZSAgICAqdGFyZ2V0X2FzOw0KLS0gDQoyLjQ1LjI=

