Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8965EC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27BX-0004tq-28; Thu, 03 Sep 2026 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BV-0004su-Q8; Thu, 03 Sep 2026 09:08:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BU-0007b6-3Z; Thu, 03 Sep 2026 09:08:53 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AIdQw2645119; Thu, 3 Sep 2026 06:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=szINPjXnQrPxkEiqctBBBW/jQ/FyU5dBfAIpWyla2
 A0=; b=aMynt2XY4cU6WiN4xD5YyZ/3z10Nq/5ynqrJ89FVG7NsUsJj0q0177Ooh
 eDj5/u3sgfVmYYVzCFYSn9pxVtD3ToPBY3eV+G0RCKFedTNKs1Xlo9TXvMM+HhOA
 sGmPNc0Z/PHQc4h3TbofZqnd9jjo4VZf5btCuenv671N3mTg0KRxlrf0Acujn6k3
 4Kfh1HhaetvQV/+Fi0TWb+x8URja0qmlVNZ3z1ZTKj+62KuQoVY9cyB75REO41kS
 Kk1dwumh3MIcxdEatGtD574YCw2Zve8qtwAo0x81TauGwrANcB1egrSdpA1DgqWj
 I+UUMe80yz0vdxQ7okjJUCkEkkh1g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023097.outbound.protection.outlook.com
 [40.107.201.97])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ges3b29g4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 06:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzLUGM4YaGzlaWPjRZIQAS1TTKCG/EMmbo37lW5raEO4DPBnrJ+AMUbWFZdo3rcxnXXRnTH8/mifAhnkO26VAdw1jvyXgGsKUTBaBH7INNUaW4GXXa7crOqB1lpved6xeKYc0b2u30rjhW55ZCyojv93dt88CGiHv3uQr1jCLK0A840lNto2NuFNhrINPTTwOCZKUGf8D7KXbtaK3N0vZSZpkf2NTUZGy1tJwgMmhJDhTJVjMfLEJwMlzII78cX5ZUQYh0HtkjnnbcJkvDrNsdL8vk2pjT6V86IqTZDMrYPLA2qANWeb1BAe4duhX2jbr24SHm9Zu6x3/j6NvZXHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szINPjXnQrPxkEiqctBBBW/jQ/FyU5dBfAIpWyla2A0=;
 b=qTvo5AVI+KeQqaf67mh77ozR+HuRrLzbxp+Ku2U2rOmoHxZX3ytpiM8BaqAGKsBizDGtDxOUZkRT3dyuiwj+5vMpkdv4Kfj5SgcyaJkeOsK/lFSjM0DF2cEaI41LqDIpr+rZhhaidjUcuvBdtFMWSZnLwj7zm1ecJrjMRIRYZenoCbEYZq+B28tvvxKr4lwz7jJNCPy3ve9WH/YOnS+/5tn/STZkvvLyxPV+7l+NEht3ly3BpF0vK1d5DmRtMdrty5VKSQK0sHgxvP4GZuVXGo1JoFushOTlPvStlSmL5zlyYbrk3nFh+wc8AI+UeiuUssaaypzZNwTtMhqO3pjADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szINPjXnQrPxkEiqctBBBW/jQ/FyU5dBfAIpWyla2A0=;
 b=Fldcypgw93Cmge27JMRHpw46TrTUMICUTyPKtlG0n7lhgPEn/UpDd8g34FRtTVwIk+UE/SAnIacOrlVZMJ02T7a7y2ti+v4hTdqu5TC/gBAu3dB1H9TIMpGpqLIB7wxbNHwbBRPPDDE4ygsp6V0tudP2mk2vYf/byqkTlfU6TO1hPGqcJvSZDc0FVvKe1T5cOo04M8d+nhoaN7RwsS48d5o3znYx+ngAZgltIo0ITWxQ87xFwSd8LAaTJ6UQmOxNK7pvNijxGnU42HGNoZcnWO8RkDHS0nqqtAkv1is40xve/ZNM4YCb8Z3hfvzi77RV9AlVXd9eXtDeBkQmEI48JQ==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by PH8PR02MB11926.namprd02.prod.outlook.com (2603:10b6:510:40a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:08:42 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 13:08:42 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 2/8] docs/vfio-user: clarify data_fd and DMA logging behaviors
Thread-Topic: [PATCH 2/8] docs/vfio-user: clarify data_fd and DMA logging
 behaviors
Thread-Index: AQHdO6VXjjTpARMQA0KcCLj8dgYOQQ==
Date: Thu, 3 Sep 2026 13:08:42 +0000
Message-ID: <20260903130833.1437632-3-hugo.komatsu@nutanix.com>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|PH8PR02MB11926:EE_
x-ms-office365-filtering-correlation-id: 72b83278-4bb6-4083-c182-08df09bc7a6c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|56012099006|10067099003|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: CG1zE81/51wQD85h0/uLuWb9hC5vo6r+LTnLpzEEtaGZv5IoAhGmRfqAXScNchx8snuIHpOV5lLloo41eNvUnRfdkxmH9WkSc6LIvHszghpNKrsCJ3ZGGI2F+k86TgPO0NSl7QpRocgeVdtYn4wW6009ZGMD7kHE90XOpH7/T6wYLrPqfGT0QJATkfKHQ1YEF5mMSPUnqJujHaqY9ZgjzF753zERP/Ivv+g9JWNlcmwT8kkkX8HNKzHQIroq4VZfKP8ig5FXj5mxmwfWYKGdxYxPzkj0HwRkne8AM94isjJbZAghf5UaVwavKgSA7EvA5rEJl0X1KJ+F6fnfnDYC+y5AMDUMkTTVPCVDKJOxcbgbuMm0a2CLLaSeaFZS9C7Dm47FQJTbGap9pNXMiKIMbuqba7+y/6AVReoR5Rcj3sFUlFhtjwgvLTz26cjSWODMVPiynEPJyLL6pI/ZHopiOGIqJRgWMdoSzJFw//6WLFaFgaHgobSYiqQhnN+oojnJNlZfjabBcaYffB1OiwIGyxm3Zmaf9ch45z+AK5fdNjoccaw5J2ICf4xGZU+K9In5Dt0kdSLzvQBv1NsQ0r3dB1T2Tv82Yx3V1v7ro3j1F3TlxqIzVTPeRB88XxG6x9cxdk/VQNhvBTykY/xWZHRb55LatT/Uch8hYWzUvcdk9KqLvwCpkKzo1qbtNIXD0+rf6VAPROjbF0axDGfMGOScUDuVOhCneXD9eOGcbJX9NvQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(56012099006)(10067099003)(3023799007)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG4zTjZXRWVIUlBkUFhIOVg1Nlh3a25YWnhJcWtwM01TZ1pGOHY2RFZhekVs?=
 =?utf-8?B?aGtwcUNtVndjMGdQQzRGMkNsS2dzUjdrblA1QnNOK24yREFBVGhCdlc0eUsz?=
 =?utf-8?B?SkcxaGc3dmpnMHg1ZGJnMzZFWUkwak01YmRzNkNGMWJUckZ0b2o2UDFBNlJp?=
 =?utf-8?B?MUtWV3I1U1o3TnJwZlJnRTBKUncvLzkrSGY3Z0labzA4M0EySTl3Z25YeHMv?=
 =?utf-8?B?dDczUFh6Q2tBTGVqU3lYNnozOXNYVE5FKzlrTEcrZElrRUJwQjJoYVE1VkFq?=
 =?utf-8?B?czBPMHhobEpEamxFbUpjb2IycitzQi8vdzMxQWlhMzBSYlVIcmVoOUUrcUxO?=
 =?utf-8?B?Zi8wa1F5d0ZWMG0yYmtlSFg0bnBQTEtVTXlHRWgvSHdSTXUxdG1RYmFYSEQ0?=
 =?utf-8?B?REFpbGRYZ05XRWZBVFFQRFdyQ1dobzc4NFkzYXF6NGJrMGxBNWw0Sld3WDNB?=
 =?utf-8?B?dVRFcjgzcFpnRlM1N3Z6cXhnUkduWGoxWGlHeHZsSllncytBYythK3RqQy80?=
 =?utf-8?B?aHJ2YkFrY2dGcTVRc2xTRVVDMklMakc4SEYvZjRBY1NrUW5LY3IyNXV5VS96?=
 =?utf-8?B?N1B5TUFPYytvVnMxbzJxM2kvVENpNVJVWW05YlJwTkN5a2wySzVISmpLTkdQ?=
 =?utf-8?B?U3dlSWc3UU9kanE5ZFNQS2F6d0NMeUFzRzFlYThUbHh2T29wSmY3YUhBcDh6?=
 =?utf-8?B?TzkxZHBKYTFPZjF0UmhxMkVDOHJ2T21odTJCS2RSUlNMam1meSthMWV1eGFt?=
 =?utf-8?B?dnBqb2NTazJVMVN0VTRSeXdQVlFjUWpud0tqamlSYVFVSGdaRUlsM1ZsUmo3?=
 =?utf-8?B?WDliMjVIc0FJRzE0c2k5eWt5c2w0Rk8zUlRwbGUxYkgvU0lGcFgxeDFianFD?=
 =?utf-8?B?WXFIZnRGT2w3ZFVqQ1BQTzZORmZIdTZHRXI3NG00dU14YlI1MUlyTFVweXZz?=
 =?utf-8?B?SXIyNnhaemRlQjRnNGF2SXFkdlZ5MUNaR21rbzc3bGxyb3pROG1LcDhUR2li?=
 =?utf-8?B?V1BQeEJuazZaMFc1WmkvOFVwS3BGTUkybmlqeTk3TTdnSGxNVTlaclpHMlJu?=
 =?utf-8?B?ZHd3Z2x6bjMweUVMcGlBU3JWSkZmWWFZSms3NlNvSkxtUWVBVFNzOXBlRjlS?=
 =?utf-8?B?R3NUTExEYjIrckxQWk1JaXVNbDN4Ujd0U1R5a2lKaVoxNDRaRXJYTUhZZ0Ir?=
 =?utf-8?B?V01NYXdKblplTlpLWjJTVGZLMTE2aUVzcXBRYVcvdFN4dGJ3MUkvSU1mRUxQ?=
 =?utf-8?B?ekJvRFY5Y3BmNWZkbk81NVIzQkFRZUxZbDRpdzFiQkRVYk9id3hhNjZvWG5C?=
 =?utf-8?B?UCtWMjhPbGw0OEZJZ2hKZHg2VFZ2K240dTEyaTczendBSFZaT1lZTGZoYkdW?=
 =?utf-8?B?Rkd5M3Q4aFFIekZORUt6UHBqaHl4RzEvSWNvcmpYT0hrUm8vZ3NnYjVIT2tY?=
 =?utf-8?B?Wi9KemhaejNPRUtRNWRpZVpqTjVCYmRVZE1WVWVwcmpkY2c3bXl6bmY0RWlX?=
 =?utf-8?B?dy9sYUtHZHdkall1QmpwaFA1WkdJZ1hMS3Zic2F4ZlpWZ2ptK1ExM0pmcFhH?=
 =?utf-8?B?ZUZBQzdmaTRELy9xN2FBMnRyTVFyNVhaS0RGUkkwSFB4cXJQWmh3TldESDJu?=
 =?utf-8?B?UEFpV0wzWFplV1JldUZCUU9EaUFUMkE3NkdhSnptT0NUdUc0a1Q0dkdLUWFa?=
 =?utf-8?B?aEd3QlgvNVZKQUd3amQvTjR4M1lhQUVPZUZZMHpRTzIzRVFXNGsxU05vRnFL?=
 =?utf-8?B?KzYrMjBkY3BrQzZlaXVHZWpGZHpxeHMwNTVxZ0laQmVjeVBkV3BlbDZhZ21M?=
 =?utf-8?B?RWFld0JTbkx0d0JtS0pweTl3N1p3b093MVFlZDA1WnJRa1RnM01xWlZpVTdj?=
 =?utf-8?B?WHM2VzRzcjhGOU1PV2k3cm40dmRwY3FVOWM2SVRGdEpXcGpaSHRibzN2NURT?=
 =?utf-8?B?TElqaUtXekJCeWFtSURveGhlcFBYVE1HN1JXSzQ1ZXdGOXkyUy9BcjJkMk9L?=
 =?utf-8?B?NWpXdWkzdkgyMmhqM1FTZjMvMEx5Qk84aUYwYlRscnJydCtITldaY3BhbjFI?=
 =?utf-8?B?RzZBTHZXS0FwbVd1akxqNXBGVkV3anVlVGc0M1EwMyt1bm5lR0V6OUdqT1dL?=
 =?utf-8?B?Wlpzd3ptc0tEQldlRStZQ0p2Wi9mZGRoeFV6V1U3VGdXUGh4aEtob1dDYTNY?=
 =?utf-8?B?ME1lQ3RaOEJ1T0pvRG1COVF2TFBleFo4NDVGWHBpNnpZQVNhUWZlNHFabTB3?=
 =?utf-8?B?dVU3NExPejNDa1dZRzF5L3h6NDF1M3VqZStCdkxRdmdYNENVb1luemxac0hL?=
 =?utf-8?B?MzV0SlhTTlZYcmdLSTZJS1NDdkhDRHVqUzMyUVJySzE0cjc5SnNlL3ZEUEFK?=
 =?utf-8?Q?67l+iT/5HVwxL394=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rJ+5y26Q22PbP22Ijgqe/gDdWPSVSYuTQWJhLMqRzU7BsACjB2sxZrHvkH/xYKbC1VTObRV8/QLyeh+eZpMzVr+FBJ+2J9Tb9IeJJkIsa6evL3txcvRkspgKJs4eS9b5JEGkYyJuR+E7hw7YLTx8Q76azeL+6yWLrXFkDr02PP92VYdAQV63BPjLCPlO2H5TCiBhs/0OU5DTXK4mHPO7MulaAh9khFy1KHvkFtcdsgMHktyIU1ZZJ9rHO4acOqNYev/VKLY+b0nzEjwXWcfqwjYvUUjKnEbajmygrjVuEW+TIuIgFLIlj9SxnkDBz8f+xhg6iUvz5yahn9sy208BYQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b83278-4bb6-4083-c182-08df09bc7a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:08:42.2252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ko711ryBPpxlm5zAEjIBlwLjMkYPORw0Y8kQZqXAatOihjSb+RSzhFZmgpdNVYfLc4fZvBFICChRBEgexOBnsU/z8Hev7Q/PwTTc74Rnkx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11926
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX1ElKk1JYzKCk
 1WExjjXiLPcsAkIgu2Gzv8Dx8e24hPKhTYbRyLOghjSBl3JaUl2dJ2+itnOG4t02XZK6rVOJsuF
 GGFj5Nmiwvxl+RfopYU+9Y/53FJ0W+4=
X-Proofpoint-GUID: q1Xibusb9KltLvONHcypOO4LhIKRTYPS
X-Authority-Analysis: v=2.4 cv=V8NNF+ni c=1 sm=1 tr=0 ts=6a99715c cx=c_pps
 a=XVr+MSEQQxWnM56OsALW2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=64Cc0HZtAAAA:8
 a=4vskkdsKVMauzmvqB8UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX1ZZ5iJQCpDXQ
 Tuw7wJanH28y5yfuSptQQFXsO6LTMdlMRs/UhobR5M6bshghKSwTpACVglMNUP2LKCT+1x7baOg
 YxzIBCV9QztiGcPF9r6bR+CMTbq3Knj9gIlFA/JjujtNwppk6VKm+d0AzpeLm+O6ICNSxBxH71z
 oGzWjtmZBDXoad98RhpCWErsCjxAU+YsZVkajX43BkgMkdM5VNQszHgjblEWKBOBqVhfkGM33mW
 a+6e5nAuV3mqaqmKcQnOtE0K1CtRv9hI4ujKxjOF+DIMIHw8VtaqMk7o5CxNcRv+5qeVXFamVgL
 bQ3jyWy2B+NAU9brU+VHLuN9DvTzA9HncCYEj/1zjA/IILb4cx5HfAik+faGSeYj5h81euch13Y
 rCfazh5/TrnXzNkTTeFNDjIznQ6uNSlS64mShxFtkIBb4jtmycFk+dGiLSYve2EpaQsMlrhLohO
 KRxlkrHMMB52H4EhqoQ==
X-Proofpoint-ORIG-GUID: q1Xibusb9KltLvONHcypOO4LhIKRTYPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

U3BlY2lmeSB0aGF0IHRoZSBkYXRhX2ZkIGZpZWxkIG11c3QgYmUgZXhwbGljaXRseSBzZXQgdG8g
LTEgYnkgdGhlCnNlcnZlciwgcmF0aGVyIHRoYW4gcmVseWluZyBvbiBjbGllbnQtc2lkZSBmaXh1
cHMuCgpDbGFyaWZ5IHRoYXQgdGhlIHNlcnZlciBtdXN0IHJldHVybiBhbiBlbXB0eSBiaXRtYXAg
cmF0aGVyIHRoYW4KYW4gZXJyb3Igd2hlbiByZXBvcnRpbmcgZGlydHkgcGFnZXMgZm9yIHVubWFw
cGVkIG9yIG1lc3NhZ2UtYmFzZWQKRE1BIHJlZ2lvbnMsIGFzIHRoZSBjbGllbnQgdHJhY2tzIHRo
ZXNlIG5hdGl2ZWx5LgoKU2lnbmVkLW9mZi1ieTogSHVnbyBLb21hdHN1IDxodWdvLmtvbWF0c3VA
bnV0YW5peC5jb20+Ci0tLQogZG9jcy9pbnRlcm9wL3ZmaW8tdXNlci5yc3QgfCAxMiArKysrKysr
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZG9jcy9pbnRlcm9wL3ZmaW8tdXNlci5yc3QgYi9kb2NzL2ludGVyb3AvdmZp
by11c2VyLnJzdAppbmRleCA3MzI4MmNkMmRkLi4xN2MwZjgyMzU1IDEwMDY0NAotLS0gYS9kb2Nz
L2ludGVyb3AvdmZpby11c2VyLnJzdAorKysgYi9kb2NzL2ludGVyb3AvdmZpby11c2VyLnJzdApA
QCAtMTcxMiw5ICsxNzEyLDEwIEBAIHN0cnVjdHVyZWQgYXMgZm9sbG93czoKIHwgVkZJT19ERVZJ
Q0VfU1RBVEVfUFJFX0NPUFlfUDJQIHwgNyAgICAgfCAobm90IHVzZWQgaW4gdmZpby11c2VyKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKIAotKiAqZGF0YV9m
ZCogaXMgdW51c2VkIGluIHZmaW8tdXNlciwgYXMgdGhlIGBgVkZJT19VU0VSX01JR19EQVRBX1JF
QURgYCBhbmQKLSAgYGBWRklPX1VTRVJfTUlHX0RBVEFfV1JJVEVgYCBtZXNzYWdlcyBhcmUgdXNl
ZCBpbnN0ZWFkIGZvciBtaWdyYXRpb24gZGF0YQotICB0cmFuc3BvcnQuCisqICpkYXRhX2ZkKiBt
dXN0IGJlIHNldCB0byAtMSBpbiBib3RoIHRoZSByZXF1ZXN0IGFuZCB0aGUgcmVzcG9uc2UuIEl0
CisgIGlzIHVudXNlZCBpbiB2ZmlvLXVzZXIsIGFzIHRoZSBgYFZGSU9fVVNFUl9NSUdfREFUQV9S
RUFEYGAgYW5kCisgIGBgVkZJT19VU0VSX01JR19EQVRBX1dSSVRFYGAgbWVzc2FnZXMgYXJlIHVz
ZWQgaW5zdGVhZCBmb3IgbWlncmF0aW9uCisgIGRhdGEgdHJhbnNwb3J0LgogCiBEaXJlY3QgU3Rh
dGUgVHJhbnNpdGlvbnMKICIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIgpAQCAtMTg0Niw2ICsxODQ3
LDExIEBAIFRoZSBiaXRtYXAgaXMgYW4gYXJyYXkgb2YgdTY0cyB0aGF0IGhvbGRzIHRoZSBvdXRw
dXQgYml0bWFwLCB3aXRoIDEgYml0CiByZXBvcnRpbmcgYSAqcGFnZV9zaXplKiB1bml0IG9mIElP
VkEuIFRoZSBiaXRzIG91dHNpZGUgb2YgdGhlIHJlcXVlc3RlZCByYW5nZQogbXVzdCBiZSB6ZXJv
LgogCitJZiB0aGUgc2VydmVyIGNhbm5vdCB0cmFuc2xhdGUgdGhlIHJlcXVlc3RlZCBJT1ZBIHJh
bmdlIChlLmcuIGJlY2F1c2UgaXQKK2lzIHVubWFwcGVkLCBvciBhY2Nlc3NlZCB2aWEgbWVzc2Fn
ZS1iYXNlZCBETUEpLCB0aGUgc2VydmVyIG11c3QgcmV0dXJuCithbiBlbXB0eSAoemVyb2VkKSBi
aXRtYXAgcmF0aGVyIHRoYW4gcmV0dXJuaW5nIGFuIGVycm9yLiBUaGUgY2xpZW50CituYXRpdmVs
eSB0cmFja3MgZGlydHkgcGFnZXMgZm9yIG1lc3NhZ2UtYmFzZWQgRE1BIG9wZXJhdGlvbnMuCisK
IFRoZSBtYXBwaW5nIG9mIElPVkEgdG8gYml0cyBpcyBnaXZlbiBieToKIGBgYml0bWFwWyhhZGRy
IC0gaW92YSkvcGFnZV9zaXplXSAmICgxVUxMIDw8IChhZGRyICUgNjQpKWBgCiAKLS0gCjIuMzku
MwoK

