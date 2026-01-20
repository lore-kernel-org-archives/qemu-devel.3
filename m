Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D609D2ED1E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDdz-0001VK-In; Tue, 20 Jan 2026 10:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdj-0001R8-3P
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:32 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdf-0006ub-Qc
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVeRN2+UYlEVTTDp9qlgb4HgYgcRIELw4y7ArqUkp1n7J6spFZz+Vl7wSE5xx6LPVkg/jeQ39mUYbDsY3de0sLGgtYKgy2Rs9rT65wJxIdd67tAu5ga+8lunToFiub8ySJnRzC0U6Fw5xb5aiVMfgnBA0al9bNOZVc6g+ET/BcRZB4eeprpYmrFwjiSxjj6rTcbDaoHDIntwgot4vja0J1D2BHFiu05FPaF7Gqy/LIbt+8CVN0r00SSR9AshQoKBzqKCqFh1I+Bb40JNpIP3YC/NYCbEp3VHhp387D7b8OieHUX6xxboO0pks3ZcE0bSYWqy0jRSo7cwpsGCfjbfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIdXQ61j5EHog4aUau3dMhnx7bm3MLoh6l6Tx/mMp90=;
 b=SlWLqAd9BA9qxhnfOoEKaYIVC/bmLG1Do8ey5w3AHg4n5v9b1IB/l0DlmOS0OEvOYzgmfVVLOYbP27Fsk1tJTiZe2ppmafI2+ZfheDmJSNcJGcg0T4F5QHI0t8PssvyOXbDQJWrLnhIOhIUmNqpi49el9SwY1qr4XYw5GUAEXpqyEQYuXiHWKm9P5VQ3lX9KTVqS1ddhuwFVGkwb5Nhp0Y8Y91T56I8b33lmx5h3pM2LjBNVfWix3B6Ckyxc3ayiDgbyStZDW4kuhFTrUia9vgu1tANAPKtnDf9Tb9zIoe2TF2H9EJWBFbwnT8KBJuOH+3iKkbyAcs0QO/Iiy/lmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIdXQ61j5EHog4aUau3dMhnx7bm3MLoh6l6Tx/mMp90=;
 b=NG6+6a8bSPRuvq3ryYjy7mDVYQNnsISh/cV86cKYG/5E23DeWXhsCxwBYK5N8yH56z0vgyx+JJRMB1wt8k8UraZJwX1egAGjDoBTJXDbmYJMX4LOA33fMB+b3NGibblZJ6oT9Jd7bCvFrLnT8X8Uqvf6f3fUZPX45dtmHF1OMv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1PPFBC9E76CBE.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:27:09 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:27:08 +0000
Message-ID: <019586c9-94a0-4bcb-8a8b-4605c32754ed@epfl.ch>
Date: Tue, 20 Jan 2026 16:22:00 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/5] plugins: add PC diversion API function
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 xsFNBFw7TEkBEADaJzHcW02rDYHgS2X2kjyXLs99tnNpww/r3MlWEkrKxgfgIRbtVQTJ2vNw
 mxIhJnAo/Ltu2VoEXU1WGwoMGv8wxquIuE1RBnYghnYPFd4SOMX8fXz5JylHpl+vPCWiP8U0
 fFWfVL1vyldQG4aVtufaJ1VEOU8zsw6YeXzxWJJ7ppUag4teMKuFya69tEEN74KLkDMJRxGk
 pj7rHW8Y+xBdNW9hQ2vAXhWAtm64NtCtJcJYP8RNl/jqlqYTP1Voj7byXym9HUM7NGEbGtrw
 4KKi9ws1yZv9BkW3ECBg5Q1w3WYmHfwqSa+8vrD2ahNieDYNu7veYP0oMaohumRgVhiaMscD
 IY8wqyt6K93RiwXDQjDAqwE44xrZDr4jjCUAm1D/7WYZWtzhsiDq80JasMbXd8SLKGr96zX5
 6vJGxa6OvyavRO7Y7DGK/dNPWdZqAC4QlluibdRsbkFLtBg8d60sVxYW8A9o46rrQB8qzglc
 joPhDebr8/NsI0gnzjgpgmNbresqne4/JIylUuJEwYcOWZqKqDw9U03uTFk/Vp6AxmRquWpy
 XZJVBsMNbunclgSelZIt2nzCa2nXR5MYyV2Y8ays+gSAPeHFOc6a8JWNLhgVKUed12XVrMUQ
 bmMmTFWWqfrx89Up4a+jW7uGIzexOeXUXKeE1j0uGsRLk6CF7QARAQABzTRGbG9yaWFuIEhv
 ZmhhbW1lciAoRVBGTCkgPGZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2g+wsGUBBMBCAA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEqCB8P0q+u+2bTfhJlusnujFfx3wFAmfOq/AF
 CQ10kyEACgkQlusnujFfx3wl9Q//cNbHsBz6YvTzzi3fddVVYnEn7YBPMAw0r4vxtYpLCvpD
 sKOfMaGYYoV3AbVton2w53qTFcmTC/7J0/UxIi/cH1sWgVipZuVNrtESZFhkKAKpqJvHamPl
 uDD0kmINzztgNZOz44iUdGkSvqQW6ou5WpSEk9YEks4KPs/EH00l7hQ8YkfR/8oN63OxpYri
 W4+obeU45fBPPgOO1U1eMtWp/QBvo2qw+GiRQkq8kjKDTt9AYYPfcA+AdnhocgrQ2SdtcBuZ
 bb1BQnKEqWM2gVpvk/ujyZZktgBvqtoubAwaMpAGNgCoDju/zPf8wtbc/yo+AT+iiRQKuilm
 mQ7U0THfk3+DewN9CTZUiL1X6NdoUuLMqdSI4HCpo/d/N59wMkRKXHG2h/pKmTLbrHGFA4ZY
 a4zNN98yyPcq6OeAqurWbotXm7yxraXKkFD5dbBJcZYc5gJx+rZg2pIy+rYtQKqZWJTZhl2s
 ZrHNl1b8cEyS8vuiSZPjFnzgzVoBS1QE136ke/6P3rFPR4zPLyhZqKbCsGHR/BDfSCzeRwoE
 zJ3aV/8kmuyAfx1iTWVBLKJsPkiNS08jf+Nb+leo8Vab7AnolDTIr0o06bWas1AsIRG31/Zs
 wBRDlfjmKZ08f+B6a1SpkhdltGozljNt1PLEposY19aw5Ou3bqFQkYtooTfnZPnOwU0EXgiz
 6wEQAM8iX+Y1mi1l3h876YmnuP8JSO1s6k0lABDO42pZaSp6Q9mFOabB7To80q1qEXCznlcR
 nExrN29WwXkfL2tcV4t/JFb0o4+6J9MmMUR3kdvRu55b/AGncNj0oggZDP8e5cLikv8v1ReV
 c//RPKSHVKnlmC9gtM0UHWpwHyyoplHi4sMJ8WyzGKfnN1eg7HlSx0xJAE7wKQP59mIMMj7n
 IXnk7bnGO7oaqy+i2vAxcdJPN6jvFgFCsKECL4NJCw6ifrY05paYRXza8JVwAcCzw0Sx4gZi
 JXC+gE4p80qNRrwR5AQuyLQNO9EfKLdnKg/85ag7xjB3ZWYMZNbj7HwCB+T16jOS+6lgGONf
 vctIp+hTFxXoCEnMx96FydDkqaBBjAU0JkbxhpMWFhzKzEILa60fxDxOSYHSs6h3bLk3D+gO
 i8j1SUPC4Olj9od7VIZDKGLd/nLw5qSt2c0H69cW1M/KS5zVARZQPb8Cqa9SAWdjmGw6MHvc
 WoYK4mT1arhwUlmrqUMcNqA+foGjDGPsxCQxqqIU2rB590n2wafu65UuyPUmzxOGdcb31I4E
 kkoBnM6G5nN4uZUCQPXl/DFlq/cfFI7LmIL2aZt6idehfvd+iOND4HDjRzrYDhz1FQn2Ihoi
 qHNMO4zSpWv35fl5kHfo1iYojwcd/aiyu4V8wo7TABEBAAHCwXwEGAEIACYCGwwWIQSoIHw/
 Sr677ZtN+EmW6ye6MV/HfAUCZ86rzQUJC6crYgAKCRCW6ye6MV/HfK3jEACTixlDX+Xa53/f
 RS4AgdiLLcPnp63HYSe58cul/U8mGfcP8/wZXkPFzpsQZRONmj0vNHFAlTlQHpBnMmqxUvVx
 SosHPMrSwukjV/zDgTeYe8iZbqDjUEFIJvEU4mQd1O2/bfBCi0N0GuleN+oyu4cHhgJIN/Ym
 3yJks/Aeprt4k3YwTZsGRCQ4fVyfmnHyYGLNKjtR/ubibG1I4hDVhf1IwrvsAcpHw1UKf/5+
 ZA3O6ZANAwVG2iAidR2LhFPiBAFWtPmI0dX5i8+Hu5CmXlHkYK2TV8ys9zDuOEiWEcMR/9tA
 agcgw3orjj0lvFiSGYI9+w1NxO76T/by09nWsLXr8Mas+pFaKUP0Wk9vZjj+8TqPTkoKOMJS
 /+vsAGjFLM1ZfFyLRvVVJH4gaWs5zie533zYlArVA1db36+YGTBWzuHEawITPaLq/FngWb+e
 bxL9a5LkhEdTCnQVhBaC0yBbplRQcGwsc8IRK0sdWiRIGtlr6NMt1yw+3TwVsBPaYvLM/qfm
 pBZkz7hBNr2qTLcl1xeP4MMdMO2ubBUGTR5B+sOzaT1qIBe5XNFkhffLTR+YmkW1PXWz7tcO
 yQcudEYHvYhKegsw0Zjv8iQIQw3yeV0WbQAs+LGQAfwpVURhZgBk3DH9gQBFkZYi8YWX/zEc
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR1PPFBC9E76CBE:EE_
X-MS-Office365-Filtering-Correlation-Id: 31afd30a-6c7f-4b23-5d4d-08de58385fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|786006|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEFrbTNRRmFmZS9mWHo4VXVUc3c3Y3hEcG1vcnVMakdraFNGR3dJUkxySnVN?=
 =?utf-8?B?Nm1qRHBnV1gyTitDU0ZBazVuM1Y1VTEyck1CZGE4QjRkK3QzOGI4MFgwNDh3?=
 =?utf-8?B?cGZZdG5ZMVIzdjhSNEQzMEUyczBBVzVuY1ZnQVNTbm9lWXY5VXd4SFRiZ0NB?=
 =?utf-8?B?alZYcDI3Mk4yNGpsYkgwL3dobFI5SXk0cWxucFNscW1jN0U4VTYrYjlQazAr?=
 =?utf-8?B?WFNKS3E1UlEyY05ZTVdBVTRhdWF4czFDRlVYcE1nb0xJSHBNYmpRUEUxNHlP?=
 =?utf-8?B?TmhJWHJZSzR2VCticmV3OEZncXJoMHhyVmtEZkhLOEsxSTNac2psYjlOa2J4?=
 =?utf-8?B?K29Fc1VHUm9WUUcwcFgwTjRZMm9RTWY2MktXd1JEL01WYlRMT2lOYWRzcmVn?=
 =?utf-8?B?S2orTS8zQys0NEh5MFd3dmhtWExXUm1Zb1ZmMnhrLzZoUGNNa3JWSUhPdUR3?=
 =?utf-8?B?d1pkdG1Vb3ZBcEhwWjhwODZjTzVCSVAvdzdGQVBIdXR1NEg5Zko0MTI2bXNm?=
 =?utf-8?B?Z1kvS2Z4OEJaODBWNjZHS0FkZjYrRHVxcDVRdUphZ0ZtSmJxaWF6ekcyamRn?=
 =?utf-8?B?Nm9JZy9WeHBHeVdDeWxzWWRoK040Vm44OTdNQmFndFpoZXNDeXJWOGkwSXJQ?=
 =?utf-8?B?OC9lemRnNCtuMTVua2tIbWtOc3ZmZ2RmM0ZqcC9ZcXV3TjA4ZnJOOE5xQTBD?=
 =?utf-8?B?c0ZveG9JbVpnbVFLNk0wZmM0cHlmcXFTNXVQVmxWNTNWZW5DT3FoTWg3bFFK?=
 =?utf-8?B?RlBpczRYaWRKdThaVEVFWmpYOHRrSTREcTVxYTFJWnZ0SWNjaGlaK296Y0Jp?=
 =?utf-8?B?bjVYOWdHWjNIcnk1NWNNMEtNNHExMS9Qa0F4YXhxVDJwcS9GRnJmbEZ3WEhr?=
 =?utf-8?B?SE8xc0Z0QlltYlNtc2Z2Rkc1NGxYWVhNZmJ2a3JKSTNabUhoQ3hDVFpKb1N2?=
 =?utf-8?B?dHhkSHRVeHFnd3RWZDNLTWRMRGpjREdFTDVSdHZub25OejhrWkFLdVRPbWlM?=
 =?utf-8?B?U2R0Q0FjZ1l1L09JUTVnSU5zSDI5clpDRFJyd0tkc2dXYXlqNUV3ZlI5VkJC?=
 =?utf-8?B?VGNSeStRT0xPTzVlVmNzaXNaZXpDMmpCbVJ0SVhweVl4azFuYU9CNHhZY2t2?=
 =?utf-8?B?MDdYZXBRNWFKUG55dzJtemhXYWFPQVYzSldadU03VnJad1UzdUtIK1RvazJN?=
 =?utf-8?B?Q2dnZGptckxaNFY1RHJLaVZOVWtiREFVK09uMVRienppRDRoS3BMd3h4WWtu?=
 =?utf-8?B?Vnp0L2RrUkNrbEI0ODdMZXF6QVIrZS9menlQVUZOZG1CSzdFcGZUanhobUR2?=
 =?utf-8?B?Z2FzWnNOQ0RjS3hCajFXSVN6aXU2eVd1azFzblIwYVI1N3Q3MkZnd011Zktx?=
 =?utf-8?B?VmxyaTFPbU9aZERmeUFWOUw0OVd2S2dpbjRtb1hpYlBiSk1Qall2R2lnRWJW?=
 =?utf-8?B?SmsxVENQZGUrcGljajBZMWJFREFPMFZMbUtIWm5GZ1VXSUhrVUQ0SGZXQXVt?=
 =?utf-8?B?WDN3Y0N6RXkraVRaODRkTTI4NitOY2FBam4zN2pKcnA0RmQrc2VCOXE0NFZ6?=
 =?utf-8?B?REJsczVFSG5zR0haeEtpNkFLeVFPK3lGSnBMemRrcDVlR05mM0Jvc3VvUGc1?=
 =?utf-8?B?eTczakNOKzExM1MydDExRlhrUEYvV0JQb3VHbjA1cHhaMUJiblFVbkZLSG9q?=
 =?utf-8?B?azdkZmpBQklVN1BEZ21JOEIyY2Q3UStaa1FxdDdvUHVuSk9BazVjb2JCZlJI?=
 =?utf-8?B?R1NOOEhBN3U2YlZuOWpFR0N6cStXZ1lLSk5tWEtYaDRiekFIaDJuYW8rMVND?=
 =?utf-8?B?MklGeWZVRHRhamR1cVpxaC9LUkhKL2tuTnVvSGU4S09yVnhYRXMwRzJJeU9r?=
 =?utf-8?B?RHdScVA0TmZRTkN2R3FDV20rSlgwVSs3TkVZRTlURVFwc2UyTkVtYU81c01S?=
 =?utf-8?B?b0JVZmJyUXB3dEc2cGVXdVQwemc4djdxT2lIOGtSNlhoSitRZ0p6d3ZYbmlI?=
 =?utf-8?B?RXhib25uRlFrYkt0YmdtOXN0MWJXS2VXQVVINUE3S1NwQU52blZBbzNtMXhw?=
 =?utf-8?B?VWpRVmhmQ2wwYnpvMm56L0YxZkJ3eU1oSlpwamN5NTZSenIvUFRPNWNMU3dh?=
 =?utf-8?Q?ELL0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(786006)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjhWbVVhVlRJR1VsR3h5WFFrdi8rMEwrK1R4T01HL2hRSEt4WXJjK0EzQXJO?=
 =?utf-8?B?QkdYUDBYL3hncDdxOTc1c2l6anJzZElnUW96T2MwNjFrK29UL3MwUFJYdHh0?=
 =?utf-8?B?ODJwTTNzaGI3blhCa0UwdzE2ZnE2TTZ4d1liUisvRHlCNHAzWDdhYnhNdGhK?=
 =?utf-8?B?NGR3VlltQ3dqTm1zUm1FTkRsNitTWEFxWXFEMG1oVE9PUnpUL0NBOFhtQnhW?=
 =?utf-8?B?NTJDUWRhTVpxN09VUlFpSG16N3BUbkc3QTV2YS9lVWFOME9HSUtmS0NtV3Nu?=
 =?utf-8?B?Z0RwL2lzcHZhbC8zY3dkYTRFN2VCNmhsT3pjdmcxS3VWZkNKcytBejZ0UFhT?=
 =?utf-8?B?MzdzRUJUZ2FFNm9oTU9UaHdwSWhIWFlWY25lUHlXVVRsSzJlWkF2UWR6cG8z?=
 =?utf-8?B?YzVFU3dDRGtNaUErTUJXc2ZlWGhLL0ViYkVRQUlZSUk3MDRpd3VDRlhoTkJ3?=
 =?utf-8?B?S3k3TXUrUGNSUnBna09lWnBVNDdLTjV6dUdTRGRlQnN5Ynp2VmlPNlc3ZWY0?=
 =?utf-8?B?cjhRN05ZUDliODlubzhLNDNueWJ4NmhiUkViWDd4VGdjeVFieDdUUU5EYXZm?=
 =?utf-8?B?RnYwWEtRelF6Qm5Id3VValEyRTdvcmE5MzErSjE3Y2pGTGlsNTMxM25lWEZz?=
 =?utf-8?B?WHVZYWpUU01QSDFGdmQxR0tUMG1OQUI4UnRXazBTdWoxMkZUQnFsMHFldE1h?=
 =?utf-8?B?cDM3Q08rZW9MWlJoT0FkKzBYRHJ5RC84Y1RBeVhobXJKdFRSaEVRMTBiVnFH?=
 =?utf-8?B?ZDNtaWcrVE9JajVjL01EQXBWcU9vNDh3V29BR2ZYK0tKTFVPeE9WRFRWSGFh?=
 =?utf-8?B?NStwN3VFOEErZXlNREhTNnBkenlOY3VsY0g5bm5ncEdLMER2aXVLT2JKNk9V?=
 =?utf-8?B?YkhFMnJSTU5QZEhXQi9vYTkrNUtiWDErZ29VUW9HTTdPMFFvRGF0Z0xqMWJy?=
 =?utf-8?B?ZkkxZDU4dEJNMzJtWEU4alNGRjhBQXZsU2hiWmVKUkk3R0tnZUY3RFhXNzd5?=
 =?utf-8?B?bkRSbC9YTFYxS1d4eXR6R09iUlNySjRORFJUZlMxaVUwbnJpUk5NV1Y2VVNl?=
 =?utf-8?B?dElieGNTYStBbERlSW53TnlJWXZzU0FVVXZoM2VRd1lLL29qU1p6UkNQZkxM?=
 =?utf-8?B?YnlteE1xQmp2Z3R6VGdIekUrcVN2Mm90S2tpbzJuUHFjNnZyNWhWbDRpaGFE?=
 =?utf-8?B?QlJWWkpmY0Y1YnljSVdTSnBGaXZOTGVrQ1hzOFplMEJsRUUyT1Nyc3d5M3E0?=
 =?utf-8?B?bHpTaHIxYSttZ3l5THhLeVpSc2YzQ3NNSHRGQ2ZiczZlUUJnNjJBYkE0TU5v?=
 =?utf-8?B?djFlVkU3eUNGREg0VWNRdThHbyt0aTZESGtILzlVcWxpZ1EvMm9UVVY2OVFF?=
 =?utf-8?B?K09FNGRWaDBzQUphRGdINHoxcFZFb1JFVW82NVRsT0dGZlNZR3c4d1k4UnRB?=
 =?utf-8?B?QVYzN2ppc29Galp4dXkzNTZXZU1PbHJFTUJjVTZDZVJhRG1ubG1FNCtiSVoy?=
 =?utf-8?B?NEk5b0NMR05hOWFjWmgzeDhNQ2pRb3R2dS9vVUdpeXFJdk9tdXBYeWpKVlhv?=
 =?utf-8?B?bXJFeThNTDd2b0drdVFSbUo0R2g1c1BUb0t5bmdaL3JqcFJEWWpSbFhxR1ZJ?=
 =?utf-8?B?NHUxQXM5LzJEMExVcFUvM2xlUThKYzMyQUUwc21hYnRHMjNma3NjTDgrUXVZ?=
 =?utf-8?B?SUZ1NDNJbnZuUWdWUHoyV1U2STl6eG9YMk5SdDhUUHE3aEIzMjJhSjRidVhK?=
 =?utf-8?B?NnEyVGdhLzd0NHpUcWZUdUp4KzdNUWxaYzVOMFJlVVpRbjBkWDBoYzl2RG5q?=
 =?utf-8?B?TkNLb2lrNVJwZDhnNlFTUGJIbXIwTlV1OTJOT1VwQkJlTjRPKzlHYTBMQVhx?=
 =?utf-8?B?djhqYlE2eEVBUk5BdXhJZTlnUDhkSkdYYmFqVGhQQkZOVldUKzZ6NnlwLy90?=
 =?utf-8?B?UEVUbFY3dXQzLy9OWEdybVlFYnBvb284cVRrVm92T2VmWlpZM1lJUEFPaHBZ?=
 =?utf-8?B?c0k1L1BxeDJmUTI4b0trU1V1N0szNUFHTW5LcTdNZy84RC9rUmlucTF2bnB2?=
 =?utf-8?B?bElxeWhpZk5kRm1pUHJpK2FyT3BSYXZKeEg2dU4zTXA4Y2dpRVZxTnpTR2dv?=
 =?utf-8?B?cUxLVCtPbkFpSUlhSC81S04yKzBiMFNWTmtPanRmM2N0K2RkWjdEL2hYSW5R?=
 =?utf-8?B?SDFOczZ3ZDlERlJycFMyZlhjbnRQcXZaYkxRKytnT3VscTF5QllvVnVJMVFO?=
 =?utf-8?B?ckU2enJaYVFGeFYxc2lYVHloQXVFY002UWJTVW1Vb1ZJUXRSVVFESkFlUWtP?=
 =?utf-8?B?cGtQTGRZS2VxSldUUmJGMVBIbWVxZk5DeUx5K2c4cXB6UU9qNmZwc21NV0dF?=
 =?utf-8?Q?kyTypvs+DJCnli+I=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 31afd30a-6c7f-4b23-5d4d-08de58385fab
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:27:08.1193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAt8U5lmsEVVhBkfYqfxO64G1IUHp8JorktbzaU1vvODYf+tiHaG11Ov99P50yZKp6E5tbvDCX4R1FWm1QXDeFwzonByBscXbJ5nJsPKdQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPFBC9E76CBE
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This patch adds a plugin API function that allows diverting the program
counter during execution. A potential use case for this functionality is
to skip over parts of the code, e.g., by hooking into a specific
instruction and setting the PC to the next instruction in the callback.

Redirecting control flow via cpu_loop_exit() works fine in callbacks
that are triggered during code execution due to cpu_exec_setjmp() still
being part of the call stack. If we want to use the new API in syscall
callbacks, cpu_exec_setjmp() already returned and the longjmp()
triggered by cpu_loop_exit() is undefined behavior. For this reason, we
introduce a new return constant QEMU_ESETPC and do another setjmp()
before executing syscall plugin callbacks and potentially the syscall
itself.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/qemu/qemu-plugin.h         | 15 +++++++++++++++
 linux-user/aarch64/cpu_loop.c      |  2 +-
 linux-user/alpha/cpu_loop.c        |  2 +-
 linux-user/arm/cpu_loop.c          |  2 +-
 linux-user/hexagon/cpu_loop.c      |  2 +-
 linux-user/hppa/cpu_loop.c         |  4 ++++
 linux-user/i386/cpu_loop.c         |  8 +++++---
 linux-user/include/special-errno.h |  8 ++++++++
 linux-user/loongarch64/cpu_loop.c  |  5 +++--
 linux-user/m68k/cpu_loop.c         |  2 +-
 linux-user/microblaze/cpu_loop.c   |  2 +-
 linux-user/mips/cpu_loop.c         |  5 +++--
 linux-user/openrisc/cpu_loop.c     |  2 +-
 linux-user/ppc/cpu_loop.c          |  6 ++++--
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 linux-user/sh4/cpu_loop.c          |  2 +-
 linux-user/sparc/cpu_loop.c        |  4 +++-
 linux-user/syscall.c               |  8 ++++++++
 linux-user/xtensa/cpu_loop.c       |  3 +++
 plugins/api.c                      | 17 ++++++++++++++++-
 plugins/core.c                     | 25 ++++++++++++++-----------
 22 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3f..f976b62030 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -321,11 +321,14 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
+ * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
+ *                             regs and updates the PC
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
     QEMU_PLUGIN_CB_R_REGS,
     QEMU_PLUGIN_CB_RW_REGS,
+    QEMU_PLUGIN_CB_RW_REGS_PC,
 };
 
 enum qemu_plugin_mem_rw {
@@ -1003,6 +1006,18 @@ QEMU_PLUGIN_API
 int qemu_plugin_write_register(struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function only returns in case of
+ * errors.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7f66a879ea..e7f643d69d 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->xregs[0] = ret;
             }
             break;
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index f93597c400..bef196b1f5 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
                     env->pc -= 4;
                     break;
                 }
-                if (sysret == -QEMU_ESIGRETURN) {
+                if (sysret == -QEMU_ESIGRETURN || sysret == -QEMU_ESETPC) {
                     break;
                 }
                 /* Syscall writes 0 to V0 to bypass error check, similar
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 40aefc4c1d..19874f4c72 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)
                                      0, 0);
                     if (ret == -QEMU_ERESTARTSYS) {
                         env->regs[15] -= env->thumb ? 2 : 4;
-                    } else if (ret != -QEMU_ESIGRETURN) {
+                    } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                         env->regs[0] = ret;
                     }
                 }
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 1941f4c9c1..9adb3ec4c6 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->gpr[HEX_REG_PC] -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[0] = ret;
             }
             break;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 972e85c487..bd3b67059b 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/compiler.h"
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
@@ -123,7 +124,10 @@ void cpu_loop(CPUHPPAState *env)
                 env->iaoq_b = env->iaoq_f + 4;
                 break;
             case -QEMU_ERESTARTSYS:
+                QEMU_FALLTHROUGH;
             case -QEMU_ESIGRETURN:
+                QEMU_FALLTHROUGH;
+            case -QEMU_ESETPC:
                 break;
             }
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index f3f58576af..fe922fceb5 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
     if (ret == -TARGET_EFAULT) {
         goto sigsegv;
     }
-    env->regs[R_EAX] = ret;
+    if (ret != -QEMU_ESETPC) {
+        env->regs[R_EAX] = ret;
+    }
 
     /* Emulate a ret instruction to leave the vsyscall page.  */
     env->eip = caller;
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
diff --git a/linux-user/include/special-errno.h b/linux-user/include/special-errno.h
index 4120455baa..1db757241a 100644
--- a/linux-user/include/special-errno.h
+++ b/linux-user/include/special-errno.h
@@ -29,4 +29,12 @@
  */
 #define QEMU_ESIGRETURN   513
 
+/*
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to
+ * indicate that the plugin deliberately changed the PC and potentially
+ * modified the register values. The main loop should not touch the guest
+ * registers for this reason.
+ */
+#define QEMU_ESETPC       514
+
 #endif /* SPECIAL_ERRNO_H */
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 26a5ce3a93..603fcc39c7 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
                 env->pc -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
                 /*
-                 * Returning from a successful sigreturn syscall.
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
                  * Avoid clobbering register state.
                  */
                 break;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 2c9f628241..b98ca8ff7b 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
                                  0, 0);
                 if (ret == -QEMU_ERESTARTSYS) {
                     env->pc -= 2;
-                } else if (ret != -QEMU_ESIGRETURN) {
+                } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                     env->dregs[0] = ret;
                 }
             }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 78506ab23d..06d92c0b90 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
             if (ret == -QEMU_ERESTARTSYS) {
                 /* Wind back to before the syscall. */
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[3] = ret;
             }
             /* All syscall exits result in guest r14 being equal to the
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 2365de1de1..af98138eb2 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -140,8 +140,9 @@ done_syscall:
                 env->active_tc.PC -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
-                /* Returning from a successful sigreturn syscall.
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.
                    Avoid clobbering register state.  */
                 break;
             }
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 2167d880d5..e7e9929e6f 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
                              cpu_get_gpr(env, 8), 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 cpu_set_gpr(env, 11, ret);
             }
             break;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index b0b0cb14b4..1f8aae14bb 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -340,8 +340,10 @@ void cpu_loop(CPUPPCState *env)
                 env->nip -= 4;
                 break;
             }
-            if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
-                /* Returning from a successful sigreturn syscall.
+            if (ret == (target_ulong)(-QEMU_ESIGRETURN)
+                    || ret == (target_ulong)(-QEMU_ESETPC)) {
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.
                    Avoid corrupting register state.  */
                 break;
             }
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index ce542540c2..eecc8d1517 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
             }
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
             if (cs->singlestep_enabled) {
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 4929b32e1f..67d2a803fb 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
                              env->regs[6], env->regs[7], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->psw.addr -= env->int_svc_ilen;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[2] = ret;
             }
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 0c9d7e9c46..ee2958d0d9 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gregs[0] = ret;
             }
             break;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7391e2add8..f054316dce 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
                               env->regwptr[2], env->regwptr[3],
                               env->regwptr[4], env->regwptr[5],
                               0, 0);
-            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ERESTARTSYS
+                    || ret == -QEMU_ESIGRETURN
+                    || ret == -QEMU_ESETPC) {
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3601715769..b48ea6debd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -43,6 +43,7 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
+#include <setjmp.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <sys/un.h>
@@ -584,6 +585,9 @@ const char *target_strerror(int err)
     if (err == QEMU_ESIGRETURN) {
         return "Successful exit from sigreturn";
     }
+    if (err == QEMU_ESETPC) {
+        return "Successfully redirected control flow via qemu_plugin_set_pc";
+    }
 
     return strerror(target_to_host_errno(err));
 }
@@ -14200,6 +14204,10 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         return -QEMU_ESIGRETURN;
     }
 
+    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+        return -QEMU_ESETPC;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index a0ff10eff8..7680e243bb 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/compiler.h"
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
@@ -185,6 +186,8 @@ void cpu_loop(CPUXtensaState *env)
                     env->pc -= 3;
                     break;
 
+                case -QEMU_ESETPC:
+                    QEMU_FALLTHROUGH;
                 case -QEMU_ESIGRETURN:
                     break;
                 }
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6..fc19bdb40b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "system/memory.h"
 #include "tcg/tcg.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -450,13 +451,27 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
-    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+    if (buf->len == 0 || (
+                qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS
+                && qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return -1;
     }
 
     return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    if (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC) {
+        return;
+    }
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
diff --git a/plugins/core.c b/plugins/core.c
index b4b783008f..9e9a066669 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -395,15 +395,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -425,15 +426,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -464,15 +466,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =
+        [0 ... 3].typemask =
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
@@ -534,7 +537,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -558,7 +561,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -568,7 +571,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -577,7 +580,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -848,6 +851,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
     } else if (flags & TCG_CALL_NO_WG) {
         return QEMU_PLUGIN_CB_R_REGS;
     } else {
-        return QEMU_PLUGIN_CB_RW_REGS;
+        return QEMU_PLUGIN_CB_RW_REGS_PC;
     }
 }
-- 
2.52.0


