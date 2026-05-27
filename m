Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3211CD6E43
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS2Ks-0005lX-DH; Tue, 26 May 2026 20:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2Kp-0005gj-SL; Tue, 26 May 2026 20:41:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2Kl-0003Zi-Ja; Tue, 26 May 2026 20:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779842479; x=1811378479;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ql0aS2kMOdGTD/CAZXob/tTHSo/u6CxDTKuFCuit5cU=;
 b=UMlqneDfFOBeQIKXsFReq4OSkNPq7XG2t2l1mzwdgVKQ7zjd7k0RFu7w
 /tnTz/Tbt5CQSIOOsnlED0i3vSJiU0cVcO9AwjfX3mT0oR7oEzM6aLr7R
 jA5B+V4p2Us/XRXqwi/4Qetu6FCHYkYRXI2S6QK0VX+VqLoBUP/wG+uRd
 nGfMogryRmty3+U20OTMvJpfU1CLi9+Yl0d7+IBrUBgPUaYWW/Hdjxl4o
 zw2uS3+RRo2Tf88dTy6CT6HoENw7uxq9vAvA+YuQAnMPQiYDLLmIGZzB0
 KKPRDf7yqOs+kAc30f1Crne9NA1P7vQC6xRn9BMhP+1mAFL//+XAQqNB8 w==;
X-CSE-ConnectionGUID: OXJXeDM3SoC6tWl7RtUgVQ==
X-CSE-MsgGUID: W7E258IrRgKO2ymfQmFydQ==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="148681702"
Received: from mail-eastus2azon11010033.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.33])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:41:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwMOCCt/r7zlBEdcR8Cw76+SVJ/R9Me7GXZw50M0JsoFPXmrYg3CK+T2rQj115mGkwSXpFD4RDkAumeOfeX9mTvT+OTHxVcXQuwYmtfnXN2qQ2CURqD306r3tJ1VJ5aSunJHNaNFIaZThnHIR46UYlMwgOiyVJX8S54OslRDC81/bo4iMEOZHFmhk7s+3K+JAo9LOcnSlILp0iSIa9XNmhZQlv3Nv2XeNCkREDB+PRBwQu71X7UYzXwgQDjpE9qZd9TUeY1qFdSfq7MH5TmKDz5Ub4IaFl+9LO1nE6yFijAIzihtDmh5HZ2eVWFXIXCMjt2dBIigYtLALRErmMxUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql0aS2kMOdGTD/CAZXob/tTHSo/u6CxDTKuFCuit5cU=;
 b=qSfmY+YKylWNsnIQVH1BITdq/p7enC927Y+XnrrbEa5THjpxU1hzzlfMVLEMC66m1WpXvDaBu/Ii/1Azpjqrev1djil6OjD6HruzcE5eMOFgqSYSrzfMVeADT9Jh3xL8na0RgweHTaO2R3S1Alt5yjkkdzVSKkRLpbAb2uVe0zOj4sLbafJEuhmLZ2xss0v37ltmS0jS2YMxIWj81Rq8Gs3SYAVoKYk2riBV4XwnMEI3r7nVoYkB47J7UV9QoRRQCw7NSNTqIigwX00+QLdsoiCSTA/v8jfoCALW0RwAhm7eQHf5tkj96GchdQrd9roinqkwvBjTmBcO6dPvfqNl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql0aS2kMOdGTD/CAZXob/tTHSo/u6CxDTKuFCuit5cU=;
 b=M/ikPyHFN+AdkFcqLGgPCvYMrFTSr3FhkZDjEdtb3FbHsKazREfwBAftelv+uhkvm+bLl5oj91T+GosIi5l3RqFLQ81psj87d2xKh3RiS5BpKsNZdEwfLHdh+Fyr4oQPoLCVjCX4mIAQJ9es/14mzlMuyTHL11E4IHHgnz86H+0=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9088.namprd04.prod.outlook.com (2603:10b6:208:525::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 00:41:14 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:41:14 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "philmd@linaro.org" <philmd@linaro.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 04/39] MAINTAINERS: Drop stale F: in "RISC-V TCG CPUs"
Thread-Topic: [PATCH 04/39] MAINTAINERS: Drop stale F: in "RISC-V TCG CPUs"
Thread-Index: AQHc6PiUaRN/nw+uIUiVnJkbHosz67YhERiA
Date: Wed, 27 May 2026 00:41:14 +0000
Message-ID: <a0dee2ba5c0ba1366e8df7ba7b6b77b11532da92.camel@wdc.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-5-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-5-armbru@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9088:EE_
x-ms-office365-filtering-correlation-id: 95b0a0e8-4700-4e86-ed0a-08debb88a7ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|7416014|10070799003|22082099003|18002099003|56012099006|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: OThXBh08SWiPBdH3O1L467IxX7LFZCc1GRhz+sfeCBw4+JWrKjNTsMg2iVzNb5VU+XoluuZ7DMxKXJzOGf89RdsPXtUkp3LmbKdAXTtMrvQAmk/0gDYsP3hNNnmbkwfeFcS86TtteAIfTwnJsQBKdvQzsMlrJPpvuONsL7n0ImG25ugmiGSgh0/2F3vWxCmF05vxtiosdRySVrQ2ICppBUMIe8g5O9wItyy3Q1edNTYl8SMAGicMhRCE1+CO7sabaXIKVBkJfT6/pyWTYxxwcNUgb1W3m7RiM9a/J7CxAykL8jNO9NhW5NqMBnC9/uquH3k5WnrkMXr2VErQ8sZBcciXFlmYTRpgsck7OrxWKv4KxYBtXAPPx9sCAlLg3zijb6R7eoAw2/N+lXcd+k2vk7PMpP8S6kVDDK9ZNeKsPUjWwt4JxzfF9KwPXMH/ZQAmC8JMGKxVceU9dz9T3tmULez4UPyu6r+JooDO/4p2hpqncYsKl5dRDrH5uSLQ6GOT2TgjwQbtYnz/j+zU/azxGs5VnDkAjFUdoJtFSHz92qama9B4Wta8MAJ7UrWYNZklLqIL8olzB3r/2ELVSdb3FP4FKsfX/NJDWoI7kBSca+/hsy7BwQf4FLHOX98gb/kkP3L40EI+2h++DWFVIUK87y7NzIssE+IVVGE6bDN453l+gw/v2/YhcRprQszjMxKuPXv+xq0S0HimefdPfzM4th3KWlqfG86ciycwTfZU/McToS3X70VtFl3CxwOFmAbC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(10070799003)(22082099003)(18002099003)(56012099006)(38070700021)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWd2eG9WK00xeTFjQXpLOUNBZGxwL3JBVDdleTdoUFV1TVBYbUN2R2xRVEYv?=
 =?utf-8?B?MEhqd01hbTRxbS9SYVE3V3ZlamZDYXQxalBGbjJiTSt2ZXNqcUIvVlQyR2RH?=
 =?utf-8?B?K2JVZGhrRXJxa1QyczBkNjE1L2lQamJwcGZZVldhQ1VXbWpVeDRZK2RPMmZo?=
 =?utf-8?B?WWZvYjRNcmZDMDdDYXNSM1FuWEs3am9RMzdMZGlObUFTM0NvSjNOblJKZEor?=
 =?utf-8?B?YTVESm5RdTJ2RnlHK3h6ajIyUFFuajdxU3l0N1BPVDBkUWY4aTBWeGZWUnFz?=
 =?utf-8?B?S29seVZZN2lkdk16dldvTCsrbHEvSUt2R2xDS1FMaWhkd3AyV2piZ2VVakNx?=
 =?utf-8?B?SFQ0L3BUNzBhK2pCaG1CRkQ3a282YXF5MnlrSHhHbDhQUVJ4YmxrVUZ4S2Ew?=
 =?utf-8?B?aWNmV2t1U0hyYXZPUi9yVXp4S2ZrTlYvd3ozN3NPcjlXVUpTWWZZOWlqeGQ1?=
 =?utf-8?B?bDZjNGxNWFVsTnZZNnNydkhsVncrS1ErSFlwQXpDbnRhbFdLZk1FOStsNjJ0?=
 =?utf-8?B?R0hra3FOSVh6ZVRFVXNac3VjNHdlQXA4N1pQWTkxemRWOVE0SDNmTnVveW1m?=
 =?utf-8?B?bFFna3VXbXRDS0ZScm13aG5oYXB2WkNzUkM2ZnNUNytFcEZVTkdOVTdCNFJF?=
 =?utf-8?B?Nk1KQnpPRmwyNXpFKzlDdlE4YUlPTWNQZmRnMmJscFpYVVZVb0J6S3cwc0FH?=
 =?utf-8?B?d0UxdngyUG5rc3BDdlUxdTVxVkdqaERvVDBEcGFQMStMZFNuVnErQXdvbkpH?=
 =?utf-8?B?bGhUcFRoRDlLa1djNTg3NjA0QUhVNExDdXg4MFRsbWR0TkRRRnZPVDNxMzVn?=
 =?utf-8?B?V3AwUkFCdUhlKzZUZDBIaEF4em1pamlPZUxCaTY3aUtHL25FQmtOSlRCYUxK?=
 =?utf-8?B?aEs5Umo0WlRxQ1FQaGpldG5DVXdneGdrSS9zYk1IUTgyTmRqNTIrTStqMExV?=
 =?utf-8?B?VEowd2ZxU25JbmMxSHFhTU8xWmE4QjBJSVdtWEVZSFp2QTFocEhJQWVoUk9R?=
 =?utf-8?B?T1hoOXY3T1lQbXFKQTdaYlNnRGtEbmh3cnkyQXNsd2Rhd0JQVXh4QitKYmds?=
 =?utf-8?B?Rk90TGJXdUV6djhIRFhoalc2SyszWTZISkpaNzMwQVlYaGZyeEtoZGsveEla?=
 =?utf-8?B?b0RhdEZkdlljQmhmOVVRRVJ6cE5tNVlHdTU3bmpVamtjSkFEU0N4YStSN282?=
 =?utf-8?B?Nm9sRjFpYklqNlQwaFdJMmZVbndUbEsrRmtYMjJUdXJQWnRVWXBYSldGblk5?=
 =?utf-8?B?YkNKUEFGQUhVQTBwVHlSSmpzMlp3VjRId2lJLzd4emJQaDc1UmRaaU1QWW9V?=
 =?utf-8?B?NTUrcGk0aU5jRis1RkNtVDVYRXoxSk9JK2JMMWVROUpqNEw1aEoxd2pnd2hs?=
 =?utf-8?B?ckZPYkpvQ2dzbVNqUWxZN21JY2ZPL3NCV05obGJyMTNlVmNYUzk3RE1zOFZ4?=
 =?utf-8?B?dmRrZVJVMzFDRHpqR0RTZytnZXRQZlVPU1VvUDdlMzYxYytGQzYwR3ByUnd4?=
 =?utf-8?B?cFFNMlU1cndYaFNQT2lIM3dJMTFrY09WZThPNUswRFRRUWdNbHVwejV3YlVz?=
 =?utf-8?B?enY5QStDMXQ0aXhoSW9aSVE2YnVweXJic3V3Q1NZd0F2SUFLUXdCekNSVGhH?=
 =?utf-8?B?U2xZUlZ0b3dKYmFScnBzbU5UUjk1T2lRNWtVL1JGNFFvMzhuTS9rYWp4SHp6?=
 =?utf-8?B?UHByODNBc3gyTDBOeHhhTmE3bUQxR3BPNm5wSGViZW1HZkRjK1FKZFZYT3ZW?=
 =?utf-8?B?WmhlVFUyNWFvVGRNZmNYekVWRkF2S0lrdHVkU2lpQlJwdGdWRm9FaTUxREJ5?=
 =?utf-8?B?Uk1EMHBJbmJHY2k2K2xuTUpESVY5dnd4dzNacG9PWnhTQ0x6UWMydVllQ3Vv?=
 =?utf-8?B?dXhhaGNOb2ptb3Z6eTJXdVJ4amdWTVdsMVVTajI0WWRuRHVnMElEb1BVV25n?=
 =?utf-8?B?b0lIY09YSFBWZUhmTnpMQm5YeVNKY0FuYXpCS3pTTHBwakNoVXVteEZ3Rlhz?=
 =?utf-8?B?aTdWdWNHT3lNbElyd2xaOGFxMGF6SVVtbFBHMjZ1a1dBcUdsNEVNRDJHaVk5?=
 =?utf-8?B?eDdSSHFmanhPVTJ0bUM1bmx1dUN0SkZ3YWJ4aDR3dGZ3aUhaeHRwamNSQ2Zz?=
 =?utf-8?B?MU5GMzF0WGhZU2pqNnVDM1F0NkoyZ0cveFZRYWdkWUxUKzIwZlZnSmNrcjAr?=
 =?utf-8?B?dzBEeUtaWTcvRy9NRFlKWjFMcm1KY3hvTHEreGNKWWpuSFFsWEVKdGF4dlN6?=
 =?utf-8?B?SDdIVXVkdkNqM1lyWTN1UnRKLzhtTTJsc3BXTGFYY1duZlcvUjM5RHp3Vzla?=
 =?utf-8?B?ckhHQXBjL0U0dm9kbGZVVG5jbTAwVmwyUzFLaXIxTU1BeWNlMDBvampOc3RY?=
 =?utf-8?Q?Uu01Bz0dNEJ6F+QAx/fBtksmvtI0sWySpqa9Ih/qZ1vZL?=
x-ms-exchange-antispam-messagedata-1: xMIM1SlP5uFSuyKMLb/eyFZirG5TmNm2/Js=
Content-Type: text/plain; charset="utf-8"
Content-ID: <249FA27E8C35A74F9B13020A0FECDE20@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mhdU056VpTSR+4SvuaBmTN+ZbE5P50vn6hxJM9Yv+0oxC+FlPru+V1fAI9jYT7rVBxVhX9ByNaVigvxu3AkylNMF7CXBrOG0haiAehmhSJCUYnjUFIOm7gnXplUZUckaddJ969trF9fvXJ/CADxjtcM0VxdTuCU8LqNu6UdVjbJBIK1rItElcXe5wXHoCsuK0glvrykpH8qPIrFbEhgEunqEN9dncPr4wCs7DvdB1t2rt1/67UBL3xOBluPD1w6lSBhd9qmwuQ8Vh8CsaNRDIzyCXz/kcroJkPwasO4xq8ergbN8KSOOtsWhD4nLNPlXEFP5rASQonvEXKht5Vz9PQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JmqFYUjUcx6G4tZEj/wTwdARUU0a5L/laPTtejrc/r20n6fnnHoa3ss0jzXviBHk9t1hWVjklFkcQiuxxUsmwr+W7uslmV86i7olB9xYJfkF7qq2h3Zu5zxkCbP0vfnZNpC4rTbCyAx2ZR7Go77VE219GZtRjnhMqNTOLKVsIszMFvpHxhoSlll2irfIttdzc/71hP0Uex5Va2+s0u0VK0PvRkjXV9xZKAn7bEOxC23Lwx3Q61r0qlbukSk1goL5pJgf/RLp0oFEjMGvke76rgUkagUuWajJWTX8fkkE7mpMqGIX1vfsK7Ybcuokuu1tsFRyfzYcZBLyITJFPf5MjK7wpSGU4wuVAcwhtZliqSCVCgQpXejoJvZUkQpa9jDB/r+ig7oNAduaUoMYqzkbDHQI3XJ1++fQrj27wFQztvHOqtsqPgMQZk4+taROUxftDHfIKBrgBTz+t8B1fRNUapaaJASgT66qIESCRhw/Q3/qOn2d/Oann7riWjjQlkuW++7g7YJ22tE59Iasv9yj2Q+rDEuueTzIvqzcCFmOp9tyzWVp3FiY9aNV2yjiyJ/jpCKkjSK9Pf0ULoUbnapKCmo+peuHfn+805sJ5ovxVMcRep9qgayyiue6mliD4dxv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b0a0e8-4700-4e86-ed0a-08debb88a7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:41:14.1557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nRZOQ+9Ab1zRyX5n+N+zh11/RAWD45XQ2IuDSzIRA3JP6QZ5O4ymRsestgH6nqs7NpAEFevxKril3R0FI/6xetrsvNwS1w0xW9vsThLUZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9088
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTA1LTIxIGF0IDEwOjA0ICswMjAwLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90
ZToNCj4gV2UgbmVnbGVjdGVkIHRvIHVwZGF0ZSBNQUlOVEFJTkVSUyB3aGVuIHdlIG1lcmdlZA0K
PiBsaW51eC11c2VyL2hvc3QvcmlzY3YzMi8gYW5kIGxpbnV4LXVzZXIvaG9zdC9yaXNjdjMyLyBp
bnRvDQo+IGxpbnV4LXVzZXIvaG9zdC9yaXNjdi8uwqAgVGhlIGZpbGVzIHNpbmNlIG1vdmVkIHRv
IGxpbnV4DQo+IGxpbnV4LXVzZXIvaW5jbHVkZS9ob3N0L3Jpc2N2NjQvLCB3aGljaCBpcyBjb3Zl
cmVkIGJ5ICJMaW51eCB1c2VyIi4NCj4gR29vZCBlbm91Z2g7IGRyb3AgdGhlIHN0YWxlIGxpbmVz
LsKgIE1hdGNoZXMgdGhlIG90aGVyIHRhcmdldHMuDQo+IA0KPiBGaXhlczogYmEwZTczMzM2MiAo
Y29uZmlndXJlOiBNZXJnZSByaXNjdjMyIGFuZCByaXNjdjY0IGhvc3QNCj4gYXJjaGl0ZWN0dXJl
cywgMjAyMS0wOS0xNykNCj4gQ2M6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+
DQo+IENjOiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQo+IENj
OiBXZWl3ZWkgTGkgPGxpd2VpMTUxOEBnbWFpbC5jb20+DQo+IENjOiBEYW5pZWwgSGVucmlxdWUg
QmFyYm96YSA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCj4gQ2M6IExpdSBaaGl3
ZWkgPHpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20+DQo+IENjOiBDaGFvIExpdSA8Y2hhby5s
aXUuemV2b3JuQGdtYWlsLmNvbT4NCj4gQ2M6IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmll
d2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFs
aXN0YWlyDQoNCj4gLS0tDQo+IMKgTUFJTlRBSU5FUlMgfCAyIC0tDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUw0KPiBpbmRleCBhZjc2ZDk1NDRkLi4zNjZmYzZjMjU3IDEwMDY0NA0KPiAtLS0gYS9N
QUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMzYxLDggKzM2MSw2IEBAIEY6
IGh3L3Jpc2N2Lw0KPiDCoEY6IGh3L2ludGMvcmlzY3YqDQo+IMKgRjogaW5jbHVkZS9ody9jaGFy
L3Jpc2N2X2h0aWYuaA0KPiDCoEY6IGluY2x1ZGUvaHcvcmlzY3YvDQo+IC1GOiBsaW51eC11c2Vy
L2hvc3QvcmlzY3YzMi8NCj4gLUY6IGxpbnV4LXVzZXIvaG9zdC9yaXNjdjY0Lw0KPiDCoEY6IGNv
bW1vbi11c2VyL2hvc3QvcmlzY3YqDQo+IMKgRjogdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjMyDQo+
IMKgRjogdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0DQo=

