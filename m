Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1792DCA5FE2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCptB-0005bD-Mb; Fri, 02 Oct 2026 22:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yzhou.dev@outlook.com>)
 id 1xCpt7-0005ar-OL; Fri, 02 Oct 2026 22:54:13 -0400
Received: from
 mail-southcentralusazolkn190110001.outbound.protection.outlook.com
 ([2a01:111:f403:d10c::1] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yzhou.dev@outlook.com>)
 id 1xCpt6-000283-0m; Fri, 02 Oct 2026 22:54:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krrnznsK33pg9L2SckOgUkL9enKQIFRZVpNNeNyvgjPB1w6gXvP6WOrIOQUIy0d4IZGdWDBqLd5X59j9QuJ/R0QCg1ZteTu/lAcA4OcMeWKwExBVIwGAovwRSD5ygs7lZK74W6gu5/JOwWUKW1PLKKhH+IH61gZ0IEGFHevm8lcONslRnSJY33eiI6hWQ2ER9Ctqu3KxXaDBsRelC+VLi5zOkMJFq8h4Fzii1B92YNu3uCkMMTnnmhYPOQmAOo1N83fxNAe7CNyy1EcnQ+e1J0LHw2bCJVyTL+Yzb5En/ki1jglGHsAnXO0duJQwWZKX9JfbHwehH2hWN9A1tCPJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix1OxXRcME02veUO4mMZ2vHovKqUv86vnlH1gBC/J6w=;
 b=Nl3nQcFvXG3zCQ59LhueJnq7/MP67dPcG3zKvlB73AKH2A8ArmT35UOIuh9iX9C4RRtqUIxOZMx3zpNCSQXHnKST8D7h+Utc6bIazWUNIoBBnlRu4tG/L/ypEmupyWIGsbULNaD5g1b4X+YCdgB504wmy60JhN/y4fpJz/DduSiBaU57xTQrDq/9X4PtZmBPmfMTbfEFNRa7yUmzRAh6HzRzH7VAmZW18UFcQ7gMleqwg9N1cVoAvqK3F4U/VjKJbINoXJ2vyYddf/2Ke0vd+sRNjz7WV2czQ3bLRc732OgEIqfQCHHPnWyVDa1Rknl26KY6pkYlcyhKqWzsucr95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix1OxXRcME02veUO4mMZ2vHovKqUv86vnlH1gBC/J6w=;
 b=pKWRkwEr3s0qtuMfZXqfgBxArtpIg6zQyw0aQWrCxiYaan/EqL6pPgyJA5mvMNBE5cRH5j9k3pB0oE3qeYf07SsPRa7R9O+oqEJ261yQOySKNT5HVE42LCSHlVeJVWrpoGV1cZpBgZ/R5mrnXlswwBXBy+tZ1zRymIVn5oAnJpHBWUHXGrng7vSIN0KJl/ZcsjPt/WJM2Sio4omcrgxJWX6fojcNGDoROD6H0wGM/WWUi9ug2xZNsDL8dVYf7doRFAMKByUvaSyL1jCwcXE/qWPJQTcY4akFC8YuJVy7Rip42cjI8dqUceLpsK9+ugAm2pbxDAmY2quz/oguPdZZuA==
Received: from SJ0PR17MB5624.namprd17.prod.outlook.com (2603:10b6:a03:391::12)
 by SA3PR17MB6779.namprd17.prod.outlook.com (2603:10b6:806:2fb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 3 Oct
 2026 02:54:05 +0000
Received: from SJ0PR17MB5624.namprd17.prod.outlook.com
 ([fe80::da38:7f4c:7709:8ab8]) by SJ0PR17MB5624.namprd17.prod.outlook.com
 ([fe80::da38:7f4c:7709:8ab8%6]) with mapi id 15.21.0472.015; Sat, 3 Oct 2026
 02:54:05 +0000
From: zhou y <yzhou.dev@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>
Subject: [PATCH] plugins: fix register handle encoding to reserve NULL as
 invalid
Thread-Topic: [PATCH] plugins: fix register handle encoding to reserve NULL as
 invalid
Thread-Index: AQHdUt+C7d7Ehs9rAUG8yyvrsViI7A==
Date: Sat, 3 Oct 2026 02:54:05 +0000
Message-ID: <SJ0PR17MB56249AFDA9BBD64F8559E1A1F4882@SJ0PR17MB5624.namprd17.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB5624:EE_|SA3PR17MB6779:EE_
x-ms-office365-filtering-correlation-id: bd85b8a6-2c09-4097-5952-08df20f996ba
x-ms-exchange-slblob-mailprops: 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/I6HVaKG8h1jGiYm0QPUB/eX7yNdxB8NQ4ivDRW3ZYgiwuYkZNaWS8PO30mheNs/VDcYD+zDHq6aKJi3l+64VHBONctsCTDxsoW/DqBOnVYajcNiaBEasGoR0fR1eCV5iqiCnSsUdqeEBcsLCn4sX3HrgJ2HYQYMDKvR431vNFsqtPeYE7jwF6KdFEWgIcObxMcNoLOAQ4idZb6uAOP8TnxBMgR4lCWSPMbclGYyPc8mXaSZWYoOsIX+uClBJ1K8LC7mtq7j9g6EQLd6UZcFFS1jkv9CbTC/OZGhXH3rG1D1c/a8bAhfGvGyMP36WDfjRCKgUxGxHE5bGDMpmwygRA9X0sK7mHU9oxgLl5OfpihMilWx06DL4oRlJHOZ8IgpTblWUtNJ4Xox8CoUE6yhlf3TJyyw3zzYNhOzGZtFhqZe+3Oea/v5KNcQbBxwydb2QKsn+/tqLkCc2q/qEEX+UwzdsmX/lTu1+vcCDVywi8OTNif1e8FziRW6V34hacPvE7jLIn7SihEC3LQswAFDwUOu3HFW0dFLOB6PAqF1Spl2cFejhGNbEUHSbC6QYSG2ycPN3tEDYNCAMqM7yzP6lfnpubOfhU70YBwVGJtPtVYg2PNPjE5WM3YKcSmWQaSGeMlvTDjMyVUcZcNz9y5hVp/56MqB9s4tyVF+5eY0TexCuWYcxohnv+wNFoYjUi7gWEiOQp/m9U/YLljs5PTSRKzK44SArOzr6
x-microsoft-antispam: BCL:0;
 ARA:14566002|22091999003|8062599012|12121999013|19110799012|39105399006|2604031081799003|24071999003|15030799006|6140399003|6092099016|4140399003|8060799015|20031999006|15080799012|24121999003|31061999003|41001999006|9112599006|22081999006|102099032|3412199025|440099028|3420499032|40105399003|3430499035|2607281247196008|26121999007;
x-microsoft-antispam-message-info: =?gb2312?B?QU9Ocy9NWHc1UlltNWNpWjlXNXJyaWdWcFVKeVZsanhNZldmcm53RHBXS1JI?=
 =?gb2312?B?ajRLelJIMlRPL3lKSUtKeUQ2eUs4NTFhWHRWVUIxR1JnNE5uR2lIeEphMkdn?=
 =?gb2312?B?MDFZTnZSdjYxWEVnVWtObjFKWFYzYVlyL3N6QzdoUDV3ejc2N2t0VTg3dmNO?=
 =?gb2312?B?WVJ4UkdtdlprVTdnM3dhVlpubEtmcXA5cTNQRlNncVZqYXlwRWF6K2F1OE5k?=
 =?gb2312?B?QTloTkNQdmZvYVpSU1ErbWg0QWhmeUw5N0dhV0xiaXJEZ3JEaXdBM1ByNkpI?=
 =?gb2312?B?ZlVIanpRcW1LNHc1NlVPYS84Ui9SNWdadk4ydU52ZXk0My9uMVgrM3M1MXNM?=
 =?gb2312?B?ajNuMk54d1J5USsyci90bEJ2eUxDdHVtMi9Uelk3YTBBY3ljYzRjUkZackNw?=
 =?gb2312?B?WW9wQzV6SFNzUEEvSy85ak5kSU90czNuZzJkc09qTU5nOVlxT1BtMHA3djM2?=
 =?gb2312?B?NmYyK0FsTHJhM3grQzIwUXVNSy9DTzNSczVWeDZ4UWlsQjlQdHlwUTk0d29o?=
 =?gb2312?B?VTZzdjIxZGhRakIyNmI3Y044Q1N6NysxemtlejRXaXEra2tQMVNiQkpseGFC?=
 =?gb2312?B?b0tITUFPOC9VWE1zYkVnMFB6YU5BRTRZOUI0S2V1NDZuMXBTSEd6YVR0RXF3?=
 =?gb2312?B?OXMwcCtWc2V0L1Bta1ppeHdhVUhaeTlxTlpkRVFYNHZJMmJxaHcrWGd0MDhj?=
 =?gb2312?B?cWlWOXZ4Q2MvNXp2amdDRFR4djBrbVNQakNzNllvZ0ZXRmdaL2JhZUp5SHZE?=
 =?gb2312?B?Yk1ER0RIV0tpRDJTSnArSGNaZkJFV3UxVFVkL2kzVlpibmRFbVI2KzZqSnlT?=
 =?gb2312?B?QlFzSFBDZ29zbWo3cEsrRSsvek1saHpBMUhUTWFLai9HNWF0ZXdUbGdsVExE?=
 =?gb2312?B?QmZDT1prMDJiNUljUHZjRk5TVWVscTR3eDFtNXJSMHBpY0Y0L3MwWXhYOUZY?=
 =?gb2312?B?MkQzNEZwcmZnWUF6L055K0VTYnpxQmxLZ3lrWkxGOVc5VFZZZFpzNXc1akRp?=
 =?gb2312?B?TW9GamhoNDhKbkcyRnBGYUYwU2lGQ3M5cW00NUkrOUUrQlQxc3Nsc0E1UlBE?=
 =?gb2312?B?dW54U09tTGp0L0p4K0xzdVNzTWNZYitLREVoQXNLcDlnUkRCWCs5MzlzK0dh?=
 =?gb2312?B?OHFjNmpBVDJmNS9QQXdseXhYdHJ1cC9ObElIaTBESTc1TkpaNzYzK3NvNzBB?=
 =?gb2312?B?U2tnY2tuTm9kcDgvUWZURG9Bck1jdll3bXhmRW1hblhROG4zU3VTejFuTVVt?=
 =?gb2312?B?Z1hYaXBlQis1S0lUUFZFVHdlMXAyYmRyRXI3UGxGQVl6UkRnODdWb3dOeVo1?=
 =?gb2312?B?TkUvNjRVN2xYRURhTE9BNFM2bERYZ1A5SFE0Uks5WmdDTkdSSVJ2MUhnYi9P?=
 =?gb2312?B?UDhmd005Rmd1eVJhazIzR1NYZTQvZ004dHAzbFVnSkw3c052OEdPMzhKa2JW?=
 =?gb2312?B?T3dRWmpjdGZMeGZzWXc1MHZVMzQwZGJqOEVyQWJGUnNZNkFCZ2RUcFVncmNO?=
 =?gb2312?B?NWV6N2FsRmJONzFWbXJmZkRkK2Y0REdIQXB0a1IrV1BHMEMxL3ZBZVlEak8w?=
 =?gb2312?B?T1E2bmRLWHFRUjlMR1pEd29JZ290QlA3M09SSlRFbk55Qjk2WXZOK0dEbUhu?=
 =?gb2312?B?eE5NM3M4b2ZUQS84VzZhb01mbzUzamhHS09XdjJwOCtXdUcxVHA3VHc4Um1X?=
 =?gb2312?B?TVAzcmFQby9XU085ZW90TmpxTVhwQkx4S3REWEhjMW1GUVdGcTY4L3pPQzJN?=
 =?gb2312?Q?uup0CISj0qPaf2Wx4A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?a1FlUWZtZTdPYXh6ZUtlMHdHdi9RQ3JoTGgyWWNXZVpFd3BxOHRjTVB6dWZE?=
 =?gb2312?B?bmxCZWpkMmVYQ0s1Y29QZ3NvZXBsc1RLcXdlbUVtdU1wMWFRN0NTZ0NFVm9O?=
 =?gb2312?B?QmcrMnRZaURoMllJOHNJUElDZ2plN0hkL2hmWDhuaHJadkhoL0J3SVlsSXM2?=
 =?gb2312?B?eXFiSGdHZUhDMXN5Ujg2MXRpVmY0ZHk0WWlKenQ3eUlsSjFxTERoS3BkaDFV?=
 =?gb2312?B?OTNzU0FJblh0T21pb2E3cUlOd1hHTHVyTjUxTDdUNndKREgyREM1ZEFJdDdY?=
 =?gb2312?B?YWovNHZiU1ZCVnUxVHRzbjFwUmZ4WmtXMmtuTTMyL05OeDFGdC92ZmFnbmFH?=
 =?gb2312?B?eENTbjdEQVNBY1pYN2RiTzl5dktad2N0aXlFd2RyTzRZOGlQZkk4M3pnd3Rn?=
 =?gb2312?B?b1hIRFhjODRQSkhIb0ZUVFEwVkdKYS9haXFpN25hNHdRYVVyQW51M3RvWWIy?=
 =?gb2312?B?dzlFQVVudUtYZU4rb3N5TVdHa21qTkQ5ajY5YTVXTUl4YWtrZmh6NlRiRDZm?=
 =?gb2312?B?ckg5OGV5VkRhSkdqWVlmZFdvNUIrM0J1ZkIvTTllNVNpZ0FFS0N2cG0yTnBa?=
 =?gb2312?B?VTFsbUZ1dW9zSkZWeHVqR1k4dFFPUnRZM2tOK0psaTRESksxb2UvSlExamZV?=
 =?gb2312?B?WXQzODdhaEhqdTNaQTNVWEhDTEkwVzRwNFQwWVZjN0d1OE1vSEl5VFNVZjE5?=
 =?gb2312?B?VHdxV3gvdlU5Y0FXVEI1REJQU0E4UnhVdjh3aS9vQ09lN2NvTUx6TU84d0N5?=
 =?gb2312?B?bDJtYVNrdk5rL2lLZk1CM0hnZE1OUkJKNHpuM3dMOEV4NUQwQWVKS0VwSW1t?=
 =?gb2312?B?ekdSVUd1UFQ5bUJOajdOUXlzQTg5OW9YNVdkbU1QY1FrVjRDaGpxZTYyZXd1?=
 =?gb2312?B?WkdjbmcxUkxMc01RcndjelgzeStlTjhIcUJzT05sNjF6MS9HVk9ZNVZUSW90?=
 =?gb2312?B?SzFuanh4UEUvaFUzVlh2VGxWRkZ6aGRJa3hCclFWN2xKR2FVbHZPVFBqK01W?=
 =?gb2312?B?WlF6Wm1GSEU4WHlEbWZnRUNXTFlJeDhkYjF1aS9vWmliS0dBakpDeitLVDdY?=
 =?gb2312?B?SVJrdHkzQ05OY3diczNKNS9IcDlnNGw4UEFWS3VxS3N1Z0hWc29FVWg4Mk9j?=
 =?gb2312?B?RVdZek4xUTJ2V01nQU0vTmR1UFFKYkVYblBZdnYrV0t2amYzT3RSWDQyOW1D?=
 =?gb2312?B?bGpFcEp2enZkY3NCbmQ5ZU5uOFROcTFGSkJqSko2QTgrVjkvdHE1bGc0WU1s?=
 =?gb2312?B?Rkxha0lBb3VVU2ZUY1NpVXoyTjRnZEVab1QvS3FBckpXSjNnUmFRU1FDK2xK?=
 =?gb2312?B?aWNldDdFQ3huWmxWcnZnMUp2OEM0dlo4N0FHWm5sdHRERTV4L3RpNFp5Nnpj?=
 =?gb2312?B?MG5acDg2akV0N3lpclpYOCszK1YwcGM1N00zbU5xRDBNbDZoNkRkN1VpcG9z?=
 =?gb2312?B?U09BZ1ZUcWVwdzIwS1FUT1BtSmpqL21wY3RoeFJYMzV2UlRheG1XZFlGQ1V5?=
 =?gb2312?B?WnlobEVyT1Q1aWpOUlI2YTVhNlFOejZnZUpiVnE4aHlkLzRRNTE2bTJHTlQ1?=
 =?gb2312?B?aUQ1bXFDbGVVWXJhUkpHc2R4eHViczF6cTJBZHdrcjV3OGxwaUtheWFmTnBi?=
 =?gb2312?B?MThTcDNUd2M3M3F6dmo3QlA2VVFCMlQ0UFF0Q1h6VWIyeGtNYndsZ2VEYVpa?=
 =?gb2312?B?VCt0TTJrZ3Jvclcvei9RcU16ZE0vVjJKSmRHeS9hMDlhcVNqdjgvTmxpL3U4?=
 =?gb2312?B?UmJFMjRtNXg5RHpCV2dOUTRhVEdoOEthTWE2T1BiOW5IeWFWTFhwYU5mZnZu?=
 =?gb2312?B?UHBReWNQYk44bDFoRFhmaVdRcUwyVGx0UkhCdENYZ1RFWnRuNk43QUlDdTFU?=
 =?gb2312?Q?T7yN+flSFhFn1?=
Content-Type: multipart/mixed;
 boundary="_002_SJ0PR17MB56249AFDA9BBD64F8559E1A1F4882SJ0PR17MB5624namp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5624.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd85b8a6-2c09-4097-5952-08df20f996ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2026 02:54:05.7566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR17MB6779
Received-SPF: pass client-ip=2a01:111:f403:d10c::1;
 envelope-from=yzhou.dev@outlook.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--_002_SJ0PR17MB56249AFDA9BBD64F8559E1A1F4882SJ0PR17MB5624namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksCgpSZXNlbmRpbmcgdGhpcyBwYXRjaCBhcyBhbiBhdHRhY2htZW50IC0gb3VyIHdlYm1haWwn
cyBwbGFpbi10ZXh0IGVkaXRvcgpzdHJpcHMgdGhlIHdoaXRlc3BhY2UgZnJvbSBkaWZmIGxpbmVz
LCB3aGljaCBpcyB3aHkgdGhpcyBhcnJpdmVzIGFzIGEKZmlsZSBpbnN0ZWFkIG9mIGlubGluZS4K
ClRoZSBwYXRjaCBmaXhlcyBhIHJlZ3Jlc3Npb24gaW4gdGhlIHBsdWdpbiByZWdpc3RlciBoYW5k
bGUgZW5jb2RpbmcsCmludHJvZHVjZWQgYnkgNTUzMjdiODVjZTMyYyAoInBsdWdpbnM6IHByb2hp
Yml0IHdyaXRpbmcgdG8gcmVhZC1vbmx5CnJlZ2lzdGVycyIpOiB0aGUgZmlyc3QgY29yZSByZWdp
c3RlciBvZiBldmVyeSB0YXJnZXQgKHg4Nl82NCAicmF4IiwKYWFyY2g2NCAieDAiLCBwcGMgInIw
IikgZW5jb2RlcyB0byBhIE5VTEwgaGFuZGxlLCB3aGljaCBwbHVnaW5zIHRoYXQKY2hlY2sgdGhl
aXIgaGFuZGxlcyBjYW5ub3QgcmVhZC4KClRoZSBwYXRjaCBhcHBsaWVzIG9uIHRvcCBvZiBjdXJy
ZW50IG1hc3RlciB3aXRoIGdpdCBhbS4gVGhlIG1haWxib3ggaXMKbm93IHN1YnNjcmliZWQgdG8g
dGhlIGxpc3QsIHNvIGZvbGxvdy11cHMgcmVhY2ggbWUgZGlyZWN0bHkuCgpUaGFua3MhCnkgemhv
dQ==

--_002_SJ0PR17MB56249AFDA9BBD64F8559E1A1F4882SJ0PR17MB5624namp_
Content-Type: application/octet-stream;
	name="0001-plugins-fix-register-handle-encoding-to-reserve-NULL-as-invalid.patch"
Content-Description:  0001-plugins-fix-register-handle-encoding-to-reserve-NULL-as-invalid.patch
Content-Disposition: attachment;
	filename="0001-plugins-fix-register-handle-encoding-to-reserve-NULL-as-invalid.patch";
	size=4341; creation-date="Sat, 03 Oct 2026 02:42:32 GMT";
	modification-date="Sat, 03 Oct 2026 02:42:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzNTljMDc4MDk4NTI1MWY2Y2EzZDE1YTk2Y2QwYTBmZDY5NGZmMmEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB5IHpob3UgPHl6aG91LmRldkBvdXRsb29rLmNvbT4KRGF0ZTog
U2F0LCAzIE9jdCAyMDI2IDEwOjI5OjA1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcGx1Z2luczog
Zml4IHJlZ2lzdGVyIGhhbmRsZSBlbmNvZGluZyB0byByZXNlcnZlIE5VTEwgYXMKIGludmFsaWQK
TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoZSBvcGFxdWUgcmVnaXN0ZXIgaGFu
ZGxlcyByZXR1cm5lZCBieSBxZW11X3BsdWdpbl9nZXRfcmVnaXN0ZXJzKCkKYXJlIGN1cnJlbnRs
eSBlbmNvZGVkIGFzOgoKICAgIGhhbmRsZSA9IChnZGJfcmVnIDw8IDEpIHwgcmVhZF9vbmx5X2Jp
dAoKRm9yIHRoZSBmaXJzdCBjb3JlIHJlZ2lzdGVyIG9mIGV2ZXJ5IHRhcmdldCAtLSBnZGJfcmVn
IDAsIG5vdApyZWFkLW9ubHkgLS0gdGhpcyBlbmNvZGVzIHRvIEdJTlRfVE9fUE9JTlRFUigwKSwg
aS5lLiBOVUxMLiBUaGF0IGlzCng4Nl82NCAicmF4IiwgYWFyY2g2NCAieDAiIGFuZCBwcGMgInIw
IiwgYW1vbmcgb3RoZXJzLgoKQSBOVUxMIGhhbmRsZSBpcyBpbmRpc3Rpbmd1aXNoYWJsZSBmcm9t
IGFuIGludmFsaWQgb25lLCBzbyBhbnkgcGx1Z2luCnRoYXQgZGVmZW5zaXZlbHkgY2hlY2tzIGl0
cyBoYW5kbGVzIHNpbGVudGx5IGxvc2VzIGFjY2VzcyB0byB0aGUKZmlyc3QgY29yZSByZWdpc3Rl
ciAod2hlcmUgdGhlIExpbnV4IHN5c2NhbGwgbnVtYmVyIGxpdmVzIG9uIHg4Nl82NCwKZm9yIGV4
YW1wbGUpLiBQYXNzaW5nIE5VTEwgdG8gcWVtdV9wbHVnaW5fd3JpdGVfcmVnaXN0ZXIoKSBpbnN0
ZWFkIG9mCmJlaW5nIHJlamVjdGVkIHNpbGVudGx5IHdyaXRlcyByZWdpc3RlciAwLgoKUmVzdG9y
ZSB0aGUgaW52YXJpYW50IHRoYXQgTlVMTCBpcyBuZXZlciBhIHZhbGlkIGhhbmRsZSBieSBrZWVw
aW5nIGFuCm9mZnNldCBvbiB0aGUgZ2RiIHJlZ2lzdGVyIG51bWJlciwgYXMgd2FzIGFscmVhZHkg
ZG9uZSBiZWZvcmUgdGhlCnJlYWQtb25seSBwcm9wZXJ0eSB3YXMgcGFja2VkIGludG8gdGhlIGhh
bmRsZSAoc2VlIHYxMC4wLjAsIHdoZXJlCmhhbmRsZXMgd2VyZSBlbmNvZGVkIGFzIEdJTlRfVE9f
UE9JTlRFUihnZGJfcmVnICsgMSkpOgoKICAgIGhhbmRsZSA9ICgoZ2RiX3JlZyArIDEpIDw8IDEp
IHwgcmVhZF9vbmx5X2JpdAoKQWxzbyBhc3NlcnQgaW4gdGVzdHMvdGNnL3BsdWdpbnMvcmVnaXN0
ZXJzLmMgdGhhdCBldmVyeSBkZXNjcmlwdG9yCmNhcnJpZXMgYSBub24tTlVMTCBoYW5kbGU6IHRo
ZSBjdXJyZW50IHRlc3QgcGFzc2VzIHRoZSBoYW5kbGVzCnN0cmFpZ2h0IHRvIHJlYWQvd3JpdGUg
d2l0aG91dCBjaGVja2luZyB0aGVtLCBhbmQgYSBoYW5kbGUgZW5jb2RpbmcKdGhhdCBtYXBzIGEg
dmFsaWQgcmVnaXN0ZXIgdG8gTlVMTCBnb2VzIHVubm90aWNlZCBmb3IgdGhhdCByZWFzb24uCgpG
b3VuZCB3aGlsZSB3cml0aW5nIGEgc3lzdGVtLW1vZGUgc3lzY2FsbCB0cmFjaW5nIHBsdWdpbiwg
d2hpY2ggY291bGQKcmVhZCBuZWl0aGVyIHRoZSBzeXNjYWxsIG51bWJlciBvbiB4ODZfNjQgbm9y
IHRoZSBmaXJzdCBhcmd1bWVudCBvbgphYXJjaDY0IChib3RoIGhhbmRsZXMgY2FtZSBiYWNrIE5V
TEwpLiBBdWRpdGluZyBldmVyeQpHSU5UX1RPX1BPSU5URVIvR1BPSU5URVJfVE9fSU5UIHNpdGUg
aW4gdGhlIHRyZWUgc2hvd3MgdGhpcyBpcyB0aGUKb25seSBwbGFjZSB3aGVyZSBhIHZhbGlkIGVu
dGl0eSBlbmNvZGVzIHRvIE5VTEwuCgpGaXhlczogNTUzMjdiODVjZTMyYyAoInBsdWdpbnM6IHBy
b2hpYml0IHdyaXRpbmcgdG8gcmVhZC1vbmx5IHJlZ2lzdGVycyIpClNpZ25lZC1vZmYtYnk6IHkg
emhvdSA8eXpob3UuZGV2QG91dGxvb2suY29tPgpDYzogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnPgpDYzogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3Mu
cXVhbGNvbW0uY29tPgpDYzogQWxleGFuZHJlIElvb3NzIDxlcmRuYXhlQGNyYW5zLm9yZz4KQ2M6
IHFlbXUtc3RhYmxlQG5vbmdudS5vcmcKLS0tCiBwbHVnaW5zL2FwaS5jICAgICAgICAgICAgICAg
ICB8IDYgKysrLS0tCiB0ZXN0cy90Y2cvcGx1Z2lucy9yZWdpc3RlcnMuYyB8IDggKysrKysrKysK
IDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9wbHVnaW5zL2FwaS5jIGIvcGx1Z2lucy9hcGkuYwppbmRleCAzNTIwYzk2Li45NTBk
ODAxIDEwMDY0NAotLS0gYS9wbHVnaW5zL2FwaS5jCisrKyBiL3BsdWdpbnMvYXBpLmMKQEAgLTQ1
NSw3ICs0NTUsNyBAQCBzdGF0aWMgR0FycmF5ICpjcmVhdGVfcmVnaXN0ZXJfaGFuZGxlcyhHQXJy
YXkgKmdkYnN0dWJfcmVncykKICAgICAgICAgICAgIGRlc2MuaXNfcmVhZG9ubHkgPSB0cnVlOwog
ICAgICAgICAgICAgcGx1Z2luX3JvX2JpdCA9IDE7CiAgICAgICAgIH0KLSAgICAgICAgZGVzYy5o
YW5kbGUgPSBHSU5UX1RPX1BPSU5URVIoKGdyZC0+Z2RiX3JlZyA8PCAxKSB8IHBsdWdpbl9yb19i
aXQpOworICAgICAgICBkZXNjLmhhbmRsZSA9IEdJTlRfVE9fUE9JTlRFUigoKGdyZC0+Z2RiX3Jl
ZyArIDEpIDw8IDEpIHwgcGx1Z2luX3JvX2JpdCk7CiAgICAgICAgIGRlc2MuZmVhdHVyZSA9IGdf
aW50ZXJuX3N0cmluZyhncmQtPmZlYXR1cmVfbmFtZSk7CiAgICAgICAgIGdfYXJyYXlfYXBwZW5k
X3ZhbChmaW5kX2RhdGEsIGRlc2MpOwogICAgIH0KQEAgLTQ4MCw3ICs0ODAsNyBAQCBib29sIHFl
bXVfcGx1Z2luX3JlYWRfcmVnaXN0ZXIoc3RydWN0IHFlbXVfcGx1Z2luX3JlZ2lzdGVyICpyZWcs
CiAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICB9CiAKLSAgICByZXR1cm4gKGdkYl9yZWFkX3Jl
Z2lzdGVyKGN1cnJlbnRfY3B1LCBidWYsIEdQT0lOVEVSX1RPX0lOVChyZWcpID4+IDEpID4gMCk7
CisgICAgcmV0dXJuIChnZGJfcmVhZF9yZWdpc3RlcihjdXJyZW50X2NwdSwgYnVmLCAoR1BPSU5U
RVJfVE9fSU5UKHJlZykgPj4gMSkgLSAxKSA+IDApOwogfQogCiBib29sIHFlbXVfcGx1Z2luX3dy
aXRlX3JlZ2lzdGVyKHN0cnVjdCBxZW11X3BsdWdpbl9yZWdpc3RlciAqcmVnLApAQCAtNDk3LDcg
KzQ5Nyw3IEBAIGJvb2wgcWVtdV9wbHVnaW5fd3JpdGVfcmVnaXN0ZXIoc3RydWN0IHFlbXVfcGx1
Z2luX3JlZ2lzdGVyICpyZWcsCiAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICB9CiAKLSAgICBy
ZXR1cm4gKGdkYl93cml0ZV9yZWdpc3RlcihjdXJyZW50X2NwdSwgYnVmLT5kYXRhLCBHUE9JTlRF
Ul9UT19JTlQocmVnKSA+PiAxKSA+IDApOworICAgIHJldHVybiAoZ2RiX3dyaXRlX3JlZ2lzdGVy
KGN1cnJlbnRfY3B1LCBidWYtPmRhdGEsIChHUE9JTlRFUl9UT19JTlQocmVnKSA+PiAxKSAtIDEp
ID4gMCk7CiB9CiAKIHZvaWQgcWVtdV9wbHVnaW5fc2V0X3BjKHVpbnQ2NF90IHZhZGRyKQpkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL3BsdWdpbnMvcmVnaXN0ZXJzLmMgYi90ZXN0cy90Y2cvcGx1Z2lu
cy9yZWdpc3RlcnMuYwppbmRleCAwZTQxNzM0Li4wMjA1OGZlIDEwMDY0NAotLS0gYS90ZXN0cy90
Y2cvcGx1Z2lucy9yZWdpc3RlcnMuYworKysgYi90ZXN0cy90Y2cvcGx1Z2lucy9yZWdpc3RlcnMu
YwpAQCAtMjksNiArMjksMTQgQEAgc3RhdGljIHZvaWQgdmNwdV9pbml0X2NiKHVuc2lnbmVkIGlu
dCB2Y3B1X2luZGV4LCB2b2lkICp1c2VyZGF0YSkKICAgICBxZW11X3BsdWdpbl9yZWdfZGVzY3Jp
cHRvciAqcmVnX2Rlc2MgPSBOVUxMOwogICAgIGJvb2wgc3VjY2VzcyA9IGZhbHNlOwogCisgICAg
LyogTlVMTCBtdXN0IG5ldmVyIGJlIGEgdmFsaWQgcmVnaXN0ZXIgaGFuZGxlICovCisgICAgZm9y
IChzaXplX3QgaSA9IDA7IGkgPCByZWdzLT5sZW47IGkrKykgeworICAgICAgICBxZW11X3BsdWdp
bl9yZWdfZGVzY3JpcHRvciAqZGVzYyA9CisgICAgICAgICAgICAmZ19hcnJheV9pbmRleChyZWdz
LCBxZW11X3BsdWdpbl9yZWdfZGVzY3JpcHRvciwgaSk7CisKKyAgICAgICAgZ19hc3NlcnQoZGVz
Yy0+aGFuZGxlICE9IE5VTEwpOworICAgIH0KKwogICAgIC8qIE1ha2Ugc3VyZSB3ZSBjYW4gcmVh
ZCBhbmQgd3JpdGUgYSByZWdpc3RlciBub3QgbWFya2VkIGFzIHJlYWRvbmx5ICovCiAgICAgZm9y
IChzaXplX3QgaSA9IDA7IGkgPCByZWdzLT5sZW47IGkrKykgewogICAgICAgICByZWdfZGVzYyA9
ICZnX2FycmF5X2luZGV4KHJlZ3MsIHFlbXVfcGx1Z2luX3JlZ19kZXNjcmlwdG9yLCBpKTsKLS0g
CjIuNDMuMAoK

--_002_SJ0PR17MB56249AFDA9BBD64F8559E1A1F4882SJ0PR17MB5624namp_--

