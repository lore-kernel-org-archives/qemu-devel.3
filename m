Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0E6CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszoT-0006Qa-10; Mon, 01 Sep 2025 04:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszoD-0006NA-2a; Mon, 01 Sep 2025 04:22:40 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszo8-0008NZ-Ho; Mon, 01 Sep 2025 04:22:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xdf8sbWnWFYNMksilqPRiw5z5rWgBsne7IgCBpeaklUHctY3LvONTGS/kUelSzD66M1su2F+dN05uGcdWRNu0gCf/CaN+HjJsV6vBskPqCE6/X2zxYKsJvJaCfKzdyb7mZHNWJ3/unlSb8vFLJ8oUc7F0+khzqntrOx6wzmfirIvJ+rCBdjLdBsyoJ+2KmPa377/eD4SYWjoYXj3yZ/667hyYfOXRjoqdHWVYueeeu5ttEItfwa4QSenON6QEHxNnW1SWo79pJLnHCZHKgNEA6e2KAkiZEcFd4XNlU1x/mWhql50VKdbbaSeaUB4JfgjQfn43gx8zIG4lI6R1P44xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPOj05o7rM5JEwBUldIGe7164ubJHE3iKlDYM8rxCFY=;
 b=MZpr2XfhFBReOHAbUqJe72vOYEg+AUFscHmY7VOd587IfbFwU3zE5ujIEfCe52h0IaR1Bqm2dnNH+hDABHNML982aukf2LOv/iHv9bs3LWtUrmG0tTQahJRS+rPwAmSAHBRrRC9XR13zJUZcAY9pKkCXkFvPNm6/q8QTgPHUpKx6uZ2YKKDgrC98aAAKhNVojAJ98eglZabGRAy+NqiS2ToFqEPIDRgnpOEO/Yp0haHz/HdNC3DE2k9BvRyXfLIPtUz7af9Aam8ka+uIO6ruC4ev6Shoo4yangbzBkqOzD2bWArpxSGnw7y3TsVtjQb0roXQpGPNh8RCNwRJP0zOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPOj05o7rM5JEwBUldIGe7164ubJHE3iKlDYM8rxCFY=;
 b=PHJvADxGMKBoVkUBFLKN6RbMsiZcNmfXBzOjLra3Uef2TSAVUT2C8Tuf2CDzOKIiJizOidyYEzqo4nPIzZrCuKGuLPd4a+haDhlRLZyYXmzcI7xdGqsnd9tELCWRZpNtP/x8ske5PitZo2qVozae6UuTZ9ZVh2i9S/YKEZmOrHhakohPx9M8wdNAFc1qqqjiofxRZ95cXr7+ATZstjE5pThCmOKFGHS2P75mPFaRXAt5WfhF8vKun8nyoSQFVdPzAQ8pyyGEMxXu85eiQem/GmJY/JC8BPc7/piQBzQmhb4hTt3AmTvzSYnZBJQcZ8OHlx8IyWPhmVZylG3UkoafaA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4154.eurprd09.prod.outlook.com (2603:10a6:10:128::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 08:22:28 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:22:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHb9v6Wv13ajPXjLkiShog0d4iGHbRZDn6AgCU2n4A=
Date: Mon, 1 Sep 2025 08:22:28 +0000
Message-ID: <32d8f439-8d6a-4754-a54f-a03843914d10@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
 <ed6b452e-87d6-48ee-b060-aa62eda7c4a9@linaro.org>
In-Reply-To: <ed6b452e-87d6-48ee-b060-aa62eda7c4a9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4154:EE_
x-ms-office365-filtering-correlation-id: f5c02a85-4ec1-4dab-503d-08dde930b07d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bkcwRDdoaTVHamlOdEM3T1c2QzRXV0UyNFc3ZThLTFV5UVhIVGYyOHlZM2dv?=
 =?utf-8?B?eHdMWGFxOE95K2tvU1NOak1jMWpybnFrc08xbmhtS08wUitBNUZOeVFnZldo?=
 =?utf-8?B?L2U4aE5uNXJ2ZUhjYUpZZ25HM0UzUGhrY1l5YTVCRkVSUkx6V29QY2h2aWdE?=
 =?utf-8?B?aE1QNUcwbVdvaENibU1yT3ZTT0tyYTdpVUVGT2dodW04dEhmbjgxYnQ0UFBD?=
 =?utf-8?B?YXcxcnNyT256WlBpN0s1bnlDQXFBTFVyNUpwS256TWQyUzhSNVlaTHF0WlNK?=
 =?utf-8?B?Vzgya2pXN2dpUEhMaG1GdU1vSlJWUVp6U05lWnpaSThUdy9aaVFRaXh3VkJN?=
 =?utf-8?B?ZzY5SHlRMGg3MWZYdnB3R1NRbUVJTEZ2NDJPZGxRNnNwdkFBTXpLQWhCVzRw?=
 =?utf-8?B?UXJZT3EwekYyem95bWhNQ3FXZmlLZ3RCSXkwWEhnZXhTQ3BhQ3oybXFGeVgz?=
 =?utf-8?B?Y1pZcC91NWFmdUlJL3VZNFdvZXJ1b05Ga2R1eUFQQTVCY2krMDNEaytJcktx?=
 =?utf-8?B?b2ppWFFoU2hmYzNRaWNjSEVjaEVDOUtTelRoR0RVcW5TUDVXcVFJaEdISWhr?=
 =?utf-8?B?dzFqT2pGTlRoYyt3M1lhMncxcGxEQVMzTC9vZTd4YnJiejJMU0NTMjNHWGZW?=
 =?utf-8?B?T2pWblFtZ0Q3NUIvM0FlNWg3WGsyYzhOUmYzbm15WjMwU1FZVUc1Q0xMcUJH?=
 =?utf-8?B?V2xvSzN1MC9pNzNZOUR5TElSQzhKMXJMK3hYNURlVlh0Wjl2bGZhTzBpOXE5?=
 =?utf-8?B?a3hUdjNqYmZyaFl2K1BJKzZGUHh3c1Jhb0NFdXJLSnNGcDVjTmprM3JBK2JH?=
 =?utf-8?B?UTdLaWUyTnFJM2xzRDJVOW5QeTBNcnVxaTRwZFArY3Y4cmhKL1dmcVdDV1Qv?=
 =?utf-8?B?R0dQY0hsNk1TV2ZQUlF2L21HNVpPRXZHTE1wblArRkxmMC9RaG9iR3lyU3BB?=
 =?utf-8?B?S0RWMUdERkFMWHRMazdJUXpxZzJvYWpkV1BDb1owUXlzU0UyUUZySjY5RUtF?=
 =?utf-8?B?RnpZYjZma3hmK3d1QWFkdml3N1A1SGcrazNvME1ORzhReWtEZWRoN05aOUlQ?=
 =?utf-8?B?N2dmUHhVQzlFT3NPM09YeFBhUzdLRU9aTCtOa1RlOGQ2MGJNNFRkaU9nOWd3?=
 =?utf-8?B?Uk1QT0RIeTA2QWppWmFDUHZTSGg3a3k5eHdMczY5SkYvYzJhMHMvSTBzVy8w?=
 =?utf-8?B?N3FseVQ4ZWpSTmlHZlBmOEhkUzN3YVJsTmlmQU00Z0xIWmRUWGllWVVlSXRv?=
 =?utf-8?B?cmpJcm1GTU90NTVzVEVsUlNYc29VMHpzMGcwSTlRLytjdkdrSTVKbUVmZDdj?=
 =?utf-8?B?L25yTDhhWGs2M3Q2am5rakprTkZ3WUpaYWdMTWMzbjdISStWVm9lc3cyZjYy?=
 =?utf-8?B?UDZiVGZ4VUJndy9sSkZUS1lTQnorOWs1MVlvYlRNYkZibUdxTDV5UEptOEF0?=
 =?utf-8?B?M203aFRialgwMFdJdHAxWDBoMjFxRDJYRzJHbHR4TFBtNjd2VnZVb1RtTm4w?=
 =?utf-8?B?eStoQnVKVlNwemd3WkdLb0ZaUjhPNWhpL3ZFTW5jcWppZVRMZWh3alU0cVdJ?=
 =?utf-8?B?SHZzMjloMkErOG14ZXlBT2lGWVhZWHhWbDEwTVRVNDFKSllpMTZWbGwvZ3ky?=
 =?utf-8?B?akZabGRYOVB4b3hJOWN4SUs2NFJLTmR4czRJdSt4ZjZoNXBud0dlbkFrQlRv?=
 =?utf-8?B?Q2ZxMEZjVytxaWg0MTA4MHBEZ1RZWlZQejdBbTVBbHlJRjlCZDhWRDVMYXgz?=
 =?utf-8?B?UTAwQXRFTnkwRGlDbk5Dd215VU8weXhnMHBoWGNWc2Rkemg2b0xPVXpJL3BF?=
 =?utf-8?B?bHUxN1lGMSs0V1N2V1ZZbXpxbVUzekVhVWI1NGFPTG9WSnplaVR0dXNOQThP?=
 =?utf-8?B?K3I1T1ZMNkp6ZmJCVE9KOG9uVUw3KytOUUdkWFJuUHRJemc3U3Uybm5BL0xS?=
 =?utf-8?B?YTRUUzgzSG9YWUhadWxObUpIV1JzR0d2Nm15ZyszOGlsUm1qSXRDcS9hS2VT?=
 =?utf-8?B?MDBLS0d2ald3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0ZpK3FnREczVnVrUDBrbzFEbTlITDRPTU1PTWhmUTk0c2tPSzNLZnBSQ3pm?=
 =?utf-8?B?Rnp3ZHhvM0ZISzBYV0x4eWJpN2RqaTNQK3cvOGpCZGpvbEwxOExYejBEZEhv?=
 =?utf-8?B?ZkRwM0dHeTA3alFXSEZ3QkNBSWErZFJ2bVg1VkhOQ1JEc0ZaTEJ3citaL3Zu?=
 =?utf-8?B?Ni9yaitCOG1qRXFkY3g5elh6OXp0S0srUW1HRncwaE9LRm82Zk41Q0puZW9D?=
 =?utf-8?B?S25Wb0xYUThhNjY2SjhJMlZQcjVURnpOYTV6QU96N0l5SEFneERUVStLb05l?=
 =?utf-8?B?b0JvV0hYYWFJemZhMXBFMzV4ZFgzMDNkbWJTRTNZZ25WNE5nV1Q3WG9oZmNw?=
 =?utf-8?B?VFhHRnFJUjBmWTdZc1QrNWtPcmNncEJCbWFSaHgrR0JIYTJCUFRuTzZyamRs?=
 =?utf-8?B?NXdyamdkcDFKZmhDU2o2cGdMMTRpeldOVjNtcFRxQ3lZbkRMK0dubjRTN3h0?=
 =?utf-8?B?RGlyMTUyaWFBWUZDQXN0R3BHZEtZR1pqYWhrdkc5VmhzVGhodFFLekxGb1U2?=
 =?utf-8?B?ZExaMVFKeEJUOUU5eGlGOEZmTllRRFpFOGV4TTVSaVVoMWJaU0NWVDBvVWto?=
 =?utf-8?B?M1kyaTdyNElwOWxZQlpYaVplQjFMeTNZYU5JQ3licW5EcGI1aGNjQnFRcVNh?=
 =?utf-8?B?S05rbS9IY2ZEWndBY2Fnd00ycmszTXMvOEVJYmk5cWxZU2I1K3V2aWdHVlNN?=
 =?utf-8?B?NTlYUEp0Z1RRRTVQdVVyMlVCbXBlMmQySENrb1lsMnF1SjUrYng4WWhiRC9v?=
 =?utf-8?B?NTBqa0sxMEZoNUcxczFUUlpvMGJZZ0NQak5HSG1EMVJsQ2UwRmt2cG5IY0xy?=
 =?utf-8?B?TzZMNk9vUUJVY1U1MTJCZlVxZkYvQzU2YlNaS0JlT1poNFF1S2c4L1VvTFFI?=
 =?utf-8?B?bGRjRDZrUHRaV1ZsOElqVGtoMGJuY0Fia3dBYkZQN1gxQWdZdURoVHY0b0NU?=
 =?utf-8?B?aEVmdnlMT3VQU3ZXOUJqeDB1WXdnMFdOeVVBT01nY055SkcyTGhOQXZteHlo?=
 =?utf-8?B?YXJsNHhyb1lsTU9pU25ERWFPcWhTUFUrV2NJWjBUaEF1R3dIcXE3UUdGUUNj?=
 =?utf-8?B?bTdsS3VobGVPd1lJOHJjNkp0aUFPUTdZWkQrRnV5Q0tiRU83Y29PREp5c0ty?=
 =?utf-8?B?d3l2NnRRZXd3RTI3VVk5Y2lUYjVmdk5Yb1JSYjRjWmduMGdyNFFkQTVNUUFo?=
 =?utf-8?B?UGJSVE5YRitXaWJwYjF3ZTNjNGE1QjlyYUVvNGlPM0kwNXg4K3crUjFjbTlt?=
 =?utf-8?B?RWxGR1JLL0lOWnZHOUxPUWhSTVk0eG9hVXhiaVlzYTY2NTV1YTZ0cXlLMjBz?=
 =?utf-8?B?WXZ5azJiMU4rWXVYNE1rTVlTV1J5RlVkTEZzMVlUazdjSlFHNFNuc3ptdmRr?=
 =?utf-8?B?UFVYOGU5YktaSjdIS2xWMjZMbW5mOEFBKytydGN2REFJYXlHWG5Pd1Zma0F3?=
 =?utf-8?B?TmVNSnhMOGQ4eDBGWVFlWUlpbk4yU1hMSENxeTlSNlIwYjcxY2N4SmYvSVMr?=
 =?utf-8?B?QjhjeWtaWXcyUkIyTTNBOVVDUFluRVh1c2diZ2MzekgwZ1Nxd2piRDJQTnp3?=
 =?utf-8?B?bWRuakRtTGtVb3JueC82eGRyeE1SNmVTbGJYUlkySGlpK05TbkRCeGhnbjZI?=
 =?utf-8?B?YU81Y2g3cnoxV0hlV2gvNWExdDQzQWtkTWhGQ1R1YThkclJWRjIxNTRVVlJW?=
 =?utf-8?B?S2tKdVhhSHZLOFJVQm1NOFpId3g0bkdDVFEvd1pZdEsybW9jUmErVzFkaUJ4?=
 =?utf-8?B?MENaYjU1SHVSRnNjUDBBeEszY3NYa2c4VmVZd3paSzJtZmN2Z0psU2s1Q0M0?=
 =?utf-8?B?WnkzNXFPY2RXS2l6aG04NzdBSTNVUTNUdkVXL3ZqeUpqWlltNElqQWJURW0w?=
 =?utf-8?B?TndCQk12SlJlSTFiRGxoTU9RM09PdXl0N1N1K1Fjc01BMEVlOEJmVjRIMXVS?=
 =?utf-8?B?NjdqaTMrV0NYV1YzY2RtKzJIVkM1c3UrMWZ1SjhlelMvKzVzVGlESXNBb0hw?=
 =?utf-8?B?SDE1NDc2ZDlwZEt0RWVsWkhDYXJ5aXIzS2R6OWpHcmxyQzhEc3M4SUw1ekx0?=
 =?utf-8?B?d3RuVktOVUNOWmtYNWJ3TGswYU53U3ZFcnEwUUEwcDBXelRGT2JXeWpXb1N2?=
 =?utf-8?B?OU1aWkNDOWxreTVTellrZmNoeExtY05CcmFZMUM3SkR2SksxTUt0RzlHL25X?=
 =?utf-8?Q?1++vfr3wk8th3wiOvTFmJlw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F107280CBFA20B4AB191882ED261DB60@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c02a85-4ec1-4dab-503d-08dde930b07d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:22:28.4597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGHXPs3SO1O8FZjimrSyLLxfN2FAFFVsWSSeK8UG6J3Pth5gdeXYJkWCpsoz7mlB8f53kWmn3R4k0XjNLBKmD87IY0xQgydsvB8cB5rSLGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4154
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

DQpPbiA4LiA4LiAyNS4gMTg6MDUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiAxNy83LzI1IDExOjM4LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
IEFkZCBSSVNDLVYgaW1wbGVtZW50YXRpb24gb2YgdGhlIENvaGVyZW50IE1hbmFnZXIgR2xvYmFs
IENvbnRyb2wNCj4+IFJlZ2lzdGVyIChDTUdDUikgZGV2aWNlLiBJdCBpcyBiYXNlZCBvbiB0aGUg
ZXhpc3RpbmcgTUlQUyBDTUdDUg0KPj4gaW1wbGVtZW50YXRpb24gYnV0IGFkYXB0ZWQgZm9yIFJJ
U0MtViBzeXN0ZW1zLg0KPj4NCj4+IFRoZSBDTUdDUiBkZXZpY2UgcHJvdmlkZXMgZ2xvYmFsIHN5
c3RlbSBjb250cm9sIGZvciBtdWx0aS1jb3JlDQo+PiBjb25maWd1cmF0aW9ucyBpbiBSSVNDLVYg
c3lzdGVtcy4NCj4+DQo+PiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhlIE1JUFMgQk9TVE9OIEFJQSBi
b2FyZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvLXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3ZpY0Bo
dGVjZ3JvdXAuY29tPg0KPj4gLS0tDQo+PiDCoCBody9taXNjL0tjb25maWfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArKw0KPj4gwqAgaHcvbWlzYy9tZXNvbi5idWlsZMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKw0KPj4gwqAgaHcvbWlzYy9yaXNjdl9jbWdjci5jwqDC
oMKgwqDCoMKgwqDCoCB8IDIzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiDCoCBpbmNsdWRlL2h3L21pc2MvcmlzY3ZfY21nY3IuaCB8wqAgNDkgKysrKysrKw0KPj4gwqAg
NCBmaWxlcyBjaGFuZ2VkLCAyOTUgaW5zZXJ0aW9ucygrKQ0KPj4gwqAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L21pc2MvcmlzY3ZfY21nY3IuYw0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvaHcvbWlzYy9yaXNjdl9jbWdjci5oDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L21pc2MvS2Nv
bmZpZyBiL2h3L21pc2MvS2NvbmZpZw0KPj4gaW5kZXggZWMwZmE1YWE5Zi4uZTNmY2UzN2MwMSAx
MDA2NDQNCj4+IC0tLSBhL2h3L21pc2MvS2NvbmZpZw0KPj4gKysrIGIvaHcvbWlzYy9LY29uZmln
DQo+PiBAQCAtMTA4LDYgKzEwOCwxNiBAQCBjb25maWcgU1RNMzJMNFg1X1JDQw0KPj4gwqAgY29u
ZmlnIE1JUFNfSVRVDQo+PiDCoMKgwqDCoMKgIGJvb2wNCj4+DQo+PiArY29uZmlnIFJJU0NWX0NN
R0NSDQo+PiArwqDCoMKgIGJvb2wNCj4+ICvCoMKgwqAgZGVmYXVsdCBuDQo+DQo+ICQgZ2l0IGdy
ZXAgJ2RlZmF1bHQgbicgJChnaXQgbHMtZmlsZXN8ZmdyZXAgS2NvbmZpZykgfCB3YyAtbA0KPiDC
oMKgwqDCoMKgwqAgMA0KPg0KPiBJIHJlbWVtYmVyIGFza2luZyB0aGF0IGFscmVhZHkgYnV0IG1h
eWJlIGl0IHdhcyBhIGRpZmZlcmVudA0KPiBzZXJpZXMuLi4gV2h5IGRvbid0IHlvdSB3YW50IHRo
aXMgYXV0b21hdGljYWxseSBzZWxlY3RlZCBieQ0KPiBkZWZhdWx0PyBBbGwgb3VyIGNvZGViYXNl
IGRvZXMgaXQsIHdoeSBjaGFuZ2Ugc3VkZGVubHk/DQoNCkkgYWdyZWUsIHdpbGwgYXBwbHkgdGhp
cyBpbiB2NyBhcyB3ZWxsLiBUaGFua3MhDQoNCg==

