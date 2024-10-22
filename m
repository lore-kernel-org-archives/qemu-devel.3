Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E935D1CDA2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37KR-0001NM-5C; Tue, 22 Oct 2024 01:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t37KO-0001Mi-Sb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:21:08 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t37KK-0003tQ-6V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1729574464; x=1761110464;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Zq3kdmJd0mdrKCfnhfqARBNIYd0hWlKU/Sm4QnorfgE=;
 b=Up9gHE1b0UgTA4pix65QjSGGQh7ITUYaI08RnBlyRGAXu2Pv6ZNL+iMQ
 IC115mh/6qJP+7sTeCWXgzWb6rKHvoLWr4D1pL7zbF27wg7xQ20XyYmyu
 kRjFIY4SzPAGgvVTdgmKx5axecYsQAqf6PByQxwJA5gpur3Ye1rPH3ZMs
 S0x0pQ3tB0NTo5FfHmtXHdxzAhXYTy7iCMxXi4zJmIEJz+qbeOUnTIyey
 eBj2UIvRx2Rs8QPKIrTnaV5iQOgu9FGi2S9A50rbDais7BwPeXSltpK9U
 wkp830he7w+BaQsewXUUx2BKGatfyqjpLGr9qIVkkwlnS+J9qrXuIwgQu w==;
X-IronPort-AV: E=Sophos;i="6.11,222,1725314400"; d="scan'208";a="22790404"
X-MGA-submission: =?us-ascii?q?MDHvOdPrNCLjl+yalshlRtDhLmmASaqlcwyN1+?=
 =?us-ascii?q?Dm156Y9yMQq5tWGWkPMl0K5dNloHMNL3QdyvmmEB7eyzDYqEo93+hZrZ?=
 =?us-ascii?q?Tbn/gs6KYxpxabitBROAQLexy5XlPo4OqIY/8LfTzaC4JTHk1PHa/C6I?=
 =?us-ascii?q?YOwTPIM1P5sllpUaq+zV7l5g=3D=3D?=
Received: from mail-dbaeur03lp2174.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.174])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 07:21:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0SKgv1/gFIAa4atW41b6qOrLlxQVDrxPXtgfVMfkaHtd/LkppXb5oPUizk7bBY5ovmqu408cN938z8/MPvx1IBqdOWMEr70Ry1P2CnpH1kqfIL0L7aC49Xw+l4xZxmlmjUc7mFRQ0aP8l0V538OKpmvuXQ54NAKKpW5cKiVOmTfTRxaUGUfxKPLtV2052UVki07dcw/F+h1JUA18LYv/QqWqgESN9oww46kl4dbJDqvd0uFNDdrEr39SdTlUxSu4wO6DveYpAGD03rdocjf7D3J1f/M4aNjeVfoeugXsbhKtRkgywxlJ1Lyh11DaSZ1SSRvoQm6Ohl/RtYrX3zR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq3kdmJd0mdrKCfnhfqARBNIYd0hWlKU/Sm4QnorfgE=;
 b=CL8X9KY2bFcWWmyq1xXLkDhZcqArLkcAyqeCp6sq63GJtaWFfsdncWCprNKlO6zoActjDJRkzbOjdpuVjCCaDRjADLmh++/Az2FopWbXRbOe9gKMxXXjxgnhq2mT1n69Zh3DCTyW+qUqNIfOyGdvuMSSbMJ0HMX4JOd/kUL4a9NIdar2olq5nquOEE+0bq0nkjWmJ/y0Q4SeorDkewKbcS+E93jfuGU1G7A099FytWHwwTCGBZ7JOopJjA/GpNBU1nUMLS+sUmS1LtoWh27jG5sZW7fL71Wysjs/VajPRqL+nHtLa4ucnhGqz1UEaRx/xMkhBdnsAAqU1AJsT9avng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq3kdmJd0mdrKCfnhfqARBNIYd0hWlKU/Sm4QnorfgE=;
 b=VD2t39zICN9lCfkJGMv1yOLiUeoLvkp6uI2xzGtLdAEw3vQuJQL/Hmz2lqHBn3G6Eom0qEDzCOCk0HZOtuFjrEHAeVoYNPtgZ2VW+szHlH83sxli9ImsX+iP3Do6YFruRf4TnE+aNlUpIKQ1i2xeEYzs772C/w/zM0LoGhpVtAK9SQ7xIYGyZULmbCumbqYdvnn1X+mDIKuohwx0NpqwKB+wYgyKV/8tj30XmN0pkL+gkVXLJiyVYOSyUpQeRx6b75CFPfQzQULxtrr1f2u17nxZBlMa0+tKmW1IChPNkViPn7LQvnuAv7qdtJlU2V5//2Q3hCO1iMyu27Yujf2Scg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV2PR07MB8986.eurprd07.prod.outlook.com (2603:10a6:150:b1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 05:20:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:20:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Roman Penyaev <r.peniaev@gmail.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 7/8] chardev/mux: implement detach of frontends from mux
Thread-Topic: [PATCH v2 7/8] chardev/mux: implement detach of frontends from
 mux
Thread-Index: AQHbHk2itACba4QhS0qcZ0gmQLi/6LKSR7uA
Date: Tue, 22 Oct 2024 05:20:57 +0000
Message-ID: <6c2ed8a5-685e-4efb-b8d6-beba7f4e4dce@eviden.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
 <20241014152408.427700-8-r.peniaev@gmail.com>
In-Reply-To: <20241014152408.427700-8-r.peniaev@gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV2PR07MB8986:EE_
x-ms-office365-filtering-correlation-id: 364173e6-c235-45a5-12ee-08dcf2594f8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SU0vOTcwSWg1WnRGTzlZZmkwSGdaNlMzaTRoYVRvbXFCUng1aE4yU3B5YnFl?=
 =?utf-8?B?VWRWRFl5VzBBb1BoUy9IRVkyeFowWFlUbkpxQ0pYVEVnM2JOM0JzQmwxcWJz?=
 =?utf-8?B?bFpQcm8xNE51NGtaeGhtL3lkUHdlcTVDcFdUaFNIbjR2cVA1R0dlZ1hxMkJs?=
 =?utf-8?B?NkVJZ294MjNscFpxVmhVbEpkZk5VQ1oybnpCY0UyYVg2eGx5Mi9XUGZqUG5H?=
 =?utf-8?B?UWNEcW9VTkxLdUZDTDFiUWNDN1YxZkNZTnQxUEFWaW5xOHQ2dnh0SmwwTnJD?=
 =?utf-8?B?R1REWTVySGh2NFl2QWF6c014a1Jyd280V0QyTkdOWUdLNUkxNjR3SUNZK2Jh?=
 =?utf-8?B?S2I3WHJSZEhJanl6UWtQbzdzV1Z1UVFhZUNXOVRDYkpHRGNOTTFrY3YrYUc1?=
 =?utf-8?B?NUFmaVd2RERoMW5sRVdVSTVlVmlQdllQK1Q1M1pra3k4dnFSUEFYdk9sTlRO?=
 =?utf-8?B?S28vNmRoa2NsZlhaaEJEaUhGV1pwQnF1cHBkdmNGb2MzNGZPR2FjSk84akNJ?=
 =?utf-8?B?RlVvQjJ3S3RqSXJYRlp4OXpneGdWazJEeTFsNmpnYXhieGt1VUpQYnAvWlM1?=
 =?utf-8?B?RXZLcnpQdy9ocXczRVlDRnEwNkIyRHlGdDZDWXBzUVM3N0dkeVlrY0RQUUVj?=
 =?utf-8?B?di9OQXRXS05nOW5KSTFoK1VnV1lMVERCaHNvaU9HdStMKzFNY0o3UDAzSWw4?=
 =?utf-8?B?NFpsWmxycXVrbkJacmNkamEwTW1kNkI2QnI3bzRyRUVyV2UvRXZBLzhvcjNI?=
 =?utf-8?B?a2JFZ21WNi9HV3JaRFBLdHlaTDkwZ29CNXk1ZGF2NXF3VDlQcTQzRzlOTkxK?=
 =?utf-8?B?b3I3dTVpY1A0cGpwOGp4Znp1OXl0RXFSdzV5L2crYTlkdTloNW51dW1HT3h0?=
 =?utf-8?B?ZVk3QmJVb1oxOHBIMGVtTDA4UmlrQmdjQmw4VzYrRWdlK094T3duRm5lOEZW?=
 =?utf-8?B?ajdmSEIwWlc3S3UxcWdOc1JKcFdGTmJxNjlHTDBPQ2o0UkorQk9rU3V5MW52?=
 =?utf-8?B?TlhDeTVibzZpak04WmFOanN2TWNFRm1WNGxWYm9oWkQ1Z3Z5elNtK3lGamhp?=
 =?utf-8?B?R3RxSGhuT2t2Q1NnUkJiUFBWcXYzTW1XVEl5RCt4UEJXUnR4cW5Va2h4WWdm?=
 =?utf-8?B?dWc2RzJQaE9lN2VRY29XeXJLUlplakRDWDA1UFljcHZYZm5NUFFMVnB5WTJj?=
 =?utf-8?B?SlhYVDN2WEVETWdXczhpS0xjQUNabHhnRmtJZm1lTGhXd1FRcGh1c3dHcDQ3?=
 =?utf-8?B?VzRxbVI5VHBTbTBMSWNmUkxXT1EwVGw4S3Q1Sm9EbFA2UTRRblB3cUdlVjlu?=
 =?utf-8?B?bXZLZ1dkckUrNWZackxLaUpSQjdyQWZDdlk5MFd5ZnBkakdJQ216ZmRHZHV1?=
 =?utf-8?B?dE9mSmhTUDdLT3YzRUtKeGZMS3V4MDdpdTBKQTNrRkpKeWtXT1EveUZDd3R6?=
 =?utf-8?B?Wjk3Y0o4bmkzblpIZDBFdGcwcGwvb3grdTRrcFQwVENQM01OV05ZaFNZcXgz?=
 =?utf-8?B?TVQ0M3lGemNEa0FmZW96Si9uSnZETmhoNVRkd010UmxUVUZUeHFoejFXYlFK?=
 =?utf-8?B?cXg5NmIrc2p0eFdKdWd6alQyV3lkT1UzeEk3dXNLRFhZNE1lbzMrMjErZ2ho?=
 =?utf-8?B?VlF0TWtjdVFuVWZtazlsSTNFR2VGeE1KYkdVajFydTRpbG5BdmRSRktFbXM5?=
 =?utf-8?B?RVd6aHYzRXNuZFBXd3o4bjBrdkl5ZFZ6eFFIUUwyN0FTT0tJVzNDRHRWZXJH?=
 =?utf-8?B?UW5qUWU5WTVySlBFRzdFUGZSeVNGMDgydHRtTzJRVzY1QURQazVCZ1VZQ2VW?=
 =?utf-8?Q?4DYdyfoWX+7othnVjDjKdfBOTNEcc+QVDtWwI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXY4YkgxWnc5aDdNMGs4RVlMY1dSTEhoakFLVTRiNjdtb2RsTitaT3UzYmI5?=
 =?utf-8?B?OWVveUlGOXBCby9Dd3dhME91MDcvZi80QjU0WW9BRk9UTG9YaGlBd3VhQmF1?=
 =?utf-8?B?b2VkNmVSM1dYOWU3R2tidmgySDhwN01WVU1sZDJEZ1lXVzlPSjRjMTcxcDVT?=
 =?utf-8?B?TGtYWCtWSXQ3UEk2UitueE9SdThlZzA0eVN1V0hocjh6b3htYnZ2WGlFZWUw?=
 =?utf-8?B?ZjJmeWxPNDNEbmxwQ1N0MS80OW41TXRrbGFWRjBzRjhyTTlXOXZGR2QrYWhp?=
 =?utf-8?B?b09UQ0lPY243SUdJd2dPN2czciszdUxrNXhDRDZ1ZWF1M0dycDhxZ0NyVlgv?=
 =?utf-8?B?TzNlQ240TVlXblFZV1l6YUlKb3JrVXNMdldGbFBxaXVmcDJERGJYTmEvd2xN?=
 =?utf-8?B?bStuMG8ycDViZ3pzUGY2QzNOTzhCZkp2OFFPb0h2d0lWZHUrOTlobVlzMDR6?=
 =?utf-8?B?QVZZTXd5V1p3bHdId0ZTMGk2TVJYem1hU0ZJRmExUTdHOUtjTDMxVXkyQjE0?=
 =?utf-8?B?Y3ltbWN5eEdYQkoyMmw1WjFpRldMdUVjQ2NteUNEalEwVlZpL3UxSFZvN0NF?=
 =?utf-8?B?ekl1WXhNR0paZjZhdmQ3T2YxbXl4SiszUTc2YnlVYXJ1WkdvQjBUWFNkNEVU?=
 =?utf-8?B?QkRoaktFWm5vaDBkeGhtTEpzb2RudGpnY0xRbUJTOU1SeTMrOVdDeWFmeGFv?=
 =?utf-8?B?RUhnRk0rZklTdG1TMk8veFA2ekRjUXU4dEpWRHBYaThYVFlCWjl6Z2t0cDQ4?=
 =?utf-8?B?cGc4WGtUV3FqR01mbXNVdDNqSmdjbitFQW02cmVJNmlCYWR1aGtkUTh4YTEr?=
 =?utf-8?B?aGxCdzd0RjJOZ0d3UXhQSGt0NFY5YzEyM0xINVlvZzh3SlZyT28xcVdtaUk3?=
 =?utf-8?B?aUJwQTVtNVdoelRuREFHMG5vb05LL1JZY0tHL1kzQTBRTEtkS0Zvb3BBZGR6?=
 =?utf-8?B?MTY0SkJ6ODFlREtrMzZTOGttYWRJUDZHRnJrNHYxZHNyMVVqMGhiTDZHOFd4?=
 =?utf-8?B?enZPRExvVlB6aCs5bWc0eXJQVlBsd0RLU2ExVFhxaytmQmN5NVVYQVNveEZu?=
 =?utf-8?B?aU5UQjJ6eUpoTzRLejBJUGxSZVppRG5kYjR1SXZrMXVXK01IZmwxaU1tRHlt?=
 =?utf-8?B?SGxReFhkMXFrbVVJdURPMnpua2JiRUJ3dUM3MGF1MHhpV0xCdW5hYUVKYThZ?=
 =?utf-8?B?cTdQR2p2TytoeTBQUXkzdzZuOXlUaks1bTM1OS9zTXg5ZHEyU1pnTkZTdHFp?=
 =?utf-8?B?TXRKYWtWeXBRclM0eVZ3ckNacEFEbEVqQmw0WUNicm9tZjFDb2o0b1V2TGo1?=
 =?utf-8?B?SDFXTU9SNUFGWjZocXk1eFhWbjh2T3BiMG45akpMTWlaZ3h4azhVMDNMNDB3?=
 =?utf-8?B?LzVHS3IrWnA2bUV5dFpvTjhJeWJxVkVBQ1MyZkZiTmpnWXQxRHBFYU9kK3NH?=
 =?utf-8?B?U3NKTVh1UjhIck5yYnVYL1JZQWttSE9ZcFN4OGhaVGFWeFFLbTVnNzh3YWp3?=
 =?utf-8?B?Tnljc2FXVVlmMjIwQXY2aE44Vy9qRnA3OEZmUkNTWDZpNURqTE9XcHBUTWpO?=
 =?utf-8?B?djc4Q3NIVU10dFRUNjUrVzZmSjBhSmJWcjFwSkxCQVorNFc4MmJ3QnJHTjFk?=
 =?utf-8?B?L2lFL2lCYW9ZV3NLZVZHWTNuTjBkcldqRkoyTGVMckU2NnFpa3pXdm9zdTVU?=
 =?utf-8?B?bHF5U3RHWDJuc3gyaTNZa2N6cE13cEJrc3hUaDNFQ01IQ2VOVFpZY0tMb09R?=
 =?utf-8?B?SWJNaWJYTm5qS3lOZVFoVmFrelVlYkJKYjMzdjVaYkNhWWRiNjlJUFMrR2FS?=
 =?utf-8?B?MHI0NnE4NUgvTkk5WXNXak1xNkJORXdKRC9Cb1I2Rit4UFdMSWJWdCtBQU9j?=
 =?utf-8?B?QWxQbDdyc1Jic0VCMVAzWGR0T2M3VkpvaC8wU3hGL1c4d0dQc1p5UDJtRW45?=
 =?utf-8?B?bXNSUm5tT0RaWEZZTnY3bGo4Z1VYRkVUQ3p1TC82R2g5aDdoYTJYYWt3ckkv?=
 =?utf-8?B?Rm1WZ08rZ3lhcHdXWDRVeEhnbFdqY3Z3ZFdzNS9KZHBiREtoalRKWmlpZWkw?=
 =?utf-8?B?V0p4cTNzZTdhU09VbFdnQ2VwSzV6ZW9RVW05Q1dRaEpCRWN1dFRZWjhVR0Q5?=
 =?utf-8?B?TCtyT0ErUVlocG5ETWlPQlp2WnpGRk5vRTJodnZURmY2N0lGYmh1dHJXclJq?=
 =?utf-8?Q?dijDpE+vJlJoOuOUL0i6bWA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1481F1AED7FEAF4E8F46ED16859F36A8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364173e6-c235-45a5-12ee-08dcf2594f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 05:20:58.0123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE6NCCozvaig25D0AHyarzCdUDvX6vQVOsY44635OhaJ7NtY/aSsMjDhFMqjsy0Bcky/kRhWVjXafQ1U0FdDujh2ghQWdRkmNN8qU8rMnTcj9OUGOG6r8u4B/0p5aVDN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB8986
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE0LzEwLzIwMjQgMTc6MjQsIFJvbWFuIFBlbnlhZXYgd3JvdGU6DQo+IENhdXRpb246
IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywg
dW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBXaXRoIGJpdHNldCBtYW5hZ2VtZW50IG5v
dyBpdCBiZWNvbWVzIGZlYXNpYmxlIHRvIGltcGxlbWVudA0KPiB0aGUgbG9naWMgb2YgZGV0YWNo
aW5nIGZyb250ZW5kcyBmcm9tIG11bHRpcGxleGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9t
YW4gUGVueWFldiA8ci5wZW5pYWV2QGdtYWlsLmNvbT4NCj4gQ2M6ICJNYXJjLUFuZHLDqSBMdXJl
YXUiIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdu
dS5vcmcNCj4gLS0tDQo+ICAgY2hhcmRldi9jaGFyLWZlLmMgICAgICAgICAgfCAgMiArLQ0KPiAg
IGNoYXJkZXYvY2hhci1tdXguYyAgICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrLS0tDQo+
ICAgY2hhcmRldi9jaGFyZGV2LWludGVybmFsLmggfCAgMSArDQo+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCAyMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2No
YXJkZXYvY2hhci1mZS5jIGIvY2hhcmRldi9jaGFyLWZlLmMNCj4gaW5kZXggM2I4NzcxY2EyYWM0
Li44YWM2YmViYjZmNzQgMTAwNjQ0DQo+IC0tLSBhL2NoYXJkZXYvY2hhci1mZS5jDQo+ICsrKyBi
L2NoYXJkZXYvY2hhci1mZS5jDQo+IEBAIC0yMjUsNyArMjI1LDcgQEAgdm9pZCBxZW11X2Nocl9m
ZV9kZWluaXQoQ2hhckJhY2tlbmQgKmIsIGJvb2wgZGVsKQ0KPiAgICAgICAgICAgfQ0KPiAgICAg
ICAgICAgaWYgKENIQVJERVZfSVNfTVVYKGItPmNocikpIHsNCj4gICAgICAgICAgICAgICBNdXhD
aGFyZGV2ICpkID0gTVVYX0NIQVJERVYoYi0+Y2hyKTsNCj4gLSAgICAgICAgICAgIGQtPmJhY2tl
bmRzW2ItPnRhZ10gPSBOVUxMOw0KPiArICAgICAgICAgICAgbXV4X2Nocl9kZXRhY2hfZnJvbnRl
bmQoZCwgYi0+dGFnKTsNCj4gICAgICAgICAgIH0NCj4gICAgICAgICAgIGlmIChkZWwpIHsNCj4g
ICAgICAgICAgICAgICBPYmplY3QgKm9iaiA9IE9CSkVDVChiLT5jaHIpOw0KPiBkaWZmIC0tZ2l0
IGEvY2hhcmRldi9jaGFyLW11eC5jIGIvY2hhcmRldi9jaGFyLW11eC5jDQo+IGluZGV4IDRmYzYx
OWIyZGE3MC4uYmRhNWM0NWU2MDU4IDEwMDY0NA0KPiAtLS0gYS9jaGFyZGV2L2NoYXItbXV4LmMN
Cj4gKysrIGIvY2hhcmRldi9jaGFyLW11eC5jDQo+IEBAIC0yOTAsMTAgKzI5MCwxMCBAQCBzdGF0
aWMgdm9pZCBjaGFyX211eF9maW5hbGl6ZShPYmplY3QgKm9iaikNCj4gICAgICAgYml0ID0gLTE7
DQo+ICAgICAgIHdoaWxlICgoYml0ID0gZmluZF9uZXh0X2JpdCgmZC0+bXV4X2JpdHNldCwgTUFY
X01VWCwgYml0ICsgMSkpIDwgTUFYX01VWCkgew0KPiAgICAgICAgICAgQ2hhckJhY2tlbmQgKmJl
ID0gZC0+YmFja2VuZHNbYml0XTsNCj4gLSAgICAgICAgaWYgKGJlKSB7DQo+IC0gICAgICAgICAg
ICBiZS0+Y2hyID0gTlVMTDsNCj4gLSAgICAgICAgfQ0KPiArICAgICAgICBiZS0+Y2hyID0gTlVM
TDsNCj4gKyAgICAgICAgZC0+YmFja2VuZHNbYml0XSA9IE5VTEw7DQo+ICAgICAgIH0NCj4gKyAg
ICBkLT5tdXhfYml0c2V0ID0gMDsNCj4gICAgICAgcWVtdV9jaHJfZmVfZGVpbml0KCZkLT5jaHIs
IGZhbHNlKTsNCj4gICB9DQo+IA0KPiBAQCAtMzMyLDYgKzMzMiwyMSBAQCBib29sIG11eF9jaHJf
YXR0YWNoX2Zyb250ZW5kKE11eENoYXJkZXYgKmQsIENoYXJCYWNrZW5kICpiLA0KPiAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4gICB9DQo+IA0KPiArYm9vbCBtdXhfY2hyX2RldGFjaF9mcm9udGVuZChN
dXhDaGFyZGV2ICpkLCB1bnNpZ25lZCBpbnQgdGFnKQ0KPiArew0KPiArICAgIHVuc2lnbmVkIGlu
dCBiaXQ7DQo+ICsNCj4gKyAgICBiaXQgPSBmaW5kX25leHRfYml0KCZkLT5tdXhfYml0c2V0LCBN
QVhfTVVYLCB0YWcpOw0KPiArICAgIGlmIChiaXQgIT0gdGFnKSB7DQo+ICsgICAgICAgIHJldHVy
biBmYWxzZTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBkLT5tdXhfYml0c2V0ICY9IH4oMSA8PCBi
aXQpOw0KDQptdXhfYml0c2V0IGlzIHVuc2lnbmVkIGxvbmcsIEkgdGhpbmsgd2Ugc2hvdWxkIHVz
ZSAxdWwgaGVyZSBldmVuIGlkIA0KTUFYX01VWCBpcyBhIGxvdyB2YWx1ZQ0KDQo+ICsgICAgZC0+
YmFja2VuZHNbYml0XSA9IE5VTEw7DQo+ICsNCj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gK30NCj4g
Kw0KPiAgIHZvaWQgbXV4X3NldF9mb2N1cyhDaGFyZGV2ICpjaHIsIHVuc2lnbmVkIGludCBmb2N1
cykNCj4gICB7DQo+ICAgICAgIE11eENoYXJkZXYgKmQgPSBNVVhfQ0hBUkRFVihjaHIpOw0KPiBk
aWZmIC0tZ2l0IGEvY2hhcmRldi9jaGFyZGV2LWludGVybmFsLmggYi9jaGFyZGV2L2NoYXJkZXYt
aW50ZXJuYWwuaA0KPiBpbmRleCBiODlhYWRhNTQxM2IuLjg1MzgwN2YzY2I4OCAxMDA2NDQNCj4g
LS0tIGEvY2hhcmRldi9jaGFyZGV2LWludGVybmFsLmgNCj4gKysrIGIvY2hhcmRldi9jaGFyZGV2
LWludGVybmFsLmgNCj4gQEAgLTYxLDYgKzYxLDcgQEAgREVDTEFSRV9JTlNUQU5DRV9DSEVDS0VS
KE11eENoYXJkZXYsIE1VWF9DSEFSREVWLA0KPiANCj4gICBib29sIG11eF9jaHJfYXR0YWNoX2Zy
b250ZW5kKE11eENoYXJkZXYgKmQsIENoYXJCYWNrZW5kICpiLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICp0YWcsIEVycm9yICoqZXJycCk7DQo+ICtib29s
IG11eF9jaHJfZGV0YWNoX2Zyb250ZW5kKE11eENoYXJkZXYgKmQsIHVuc2lnbmVkIGludCB0YWcp
Ow0KPiAgIHZvaWQgbXV4X3NldF9mb2N1cyhDaGFyZGV2ICpjaHIsIHVuc2lnbmVkIGludCBmb2N1
cyk7DQo+ICAgdm9pZCBtdXhfY2hyX3NlbmRfYWxsX2V2ZW50KENoYXJkZXYgKmNociwgUUVNVUNo
ckV2ZW50IGV2ZW50KTsNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQo=

