Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F326C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 06:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1glm-00051g-W2; Tue, 30 Apr 2024 02:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1s1gli-0004vy-GI
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 02:15:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1s1glb-0007Ev-Qd
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 02:15:10 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TI1Ywc021894;
 Mon, 29 Apr 2024 23:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=h6rYS3I62Uf
 hLWltu2ayITwZhNNMHdlrTCXQlhSO1/o=; b=1vQVdlC+316DbscmMlGJT+SOd0w
 Fu8V+3BvP09LcySTk5Ojg5X51KHjNx++koLeREOj97A5aeS2R0ZYJMlul3oXfPrI
 D82e4mf5YqLkdFETy4vBPoeZqG9UimNl6MbXvsm4uPvHU9eNc05FnDj468/FsB2i
 92biEbmgMRW43DNZ2/PrU5fqEF4so+9A/qZKCnuudTTmvDomho+Go1IliR9wpen1
 iTrvx7HgEHcEJnS4nEs9xuTBVEe2LjGc4CmMaVPNK0jMghdCPdRFIeCsA0186BMH
 ZNX+tjvHpfa370VZV3FrGkPptL0reFt4Kt6uBA3n3EMGZxyRhHLS4wW40jw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xrxw7cy53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 23:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNJgkeS7ZOq/fOwwsQ/EgNxW2ofECuLZ0IQiCUqhd8E9l1GMjnWmbJZGnYp5btG4A0zwQrVerJyPfZEP7TgKl5YryPJn6BrvSwQ88HLMMnX3R/kzMEezrDPn6zwXQlb9Ti2p7Pc1Jlk2GD+P8AA/iAgueVLA3bHZCfbo5iCpjkPAbnI+y/ukZiAkYBvzU1mDDAQ6Srl6Rjs8IqzfdLUyqt06YLESlVktdpq2FxzQVwSjFtkPCdfCg7EtTcSavUURV+Ha5XA4aOUKYg5RvMcVqj6D/Q8Rd6GxNfXQMQSX8oaER1M8kMRndwhP0fH5bqYHX/wHYbK7Sq1yMd8uTcEEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6rYS3I62UfhLWltu2ayITwZhNNMHdlrTCXQlhSO1/o=;
 b=BQtxIjfbZNgQbQtTkSXgdNVhBMwsrCBOO1zOq77+kDgsPvV1tYui2+1Oo1aAtp6/9Bi96Ry64mvKsk/OTX/cAmvDCqn39SDYoR1xXsZ0CYztVBGJ/AaOMLFdp/WheOv2vWvByPK42+3/NrnA8lOBt9z31q1FhrX0dUHH/W5nLwgnIdeJVWLJnUT7kYjrGBjqLKGNkVCb0A2CxBxWVHlK6RfiuAwe/OD2ErCmnBWF0TMir5tSoi53HhpTWHcJI7MB40TYLZlr/Ex2MssmeZmPE2+7giAwiouvyMGbLJFatHftl0fG8OYQczWeg+DO5d+rWJ0awr35pFpA5kUf2r9zRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6rYS3I62UfhLWltu2ayITwZhNNMHdlrTCXQlhSO1/o=;
 b=uTQvPT7d/udsHoYTLPjwFTcSdPJSBVxU7R+KXo2Y1soIg1j1lDPaMQYED4dbugr895gayF9NMumHJKjlCYYYOXdiN49g3zuGoyi3Pr8ecNL9YDcV1TUpp8r2e3hTEdktM71Sz+aFOTfoLIprlUZe2SvY+ZqlFBuKXpLOR1tmhLkVhuwj+byhwX93xS3ULvno9PsxcFvj8x+xvZEvakSvLnP+VTwS5sFdTPXI3L//LMJ1gmrZj53jU93rUmhF/gl8Zc9caMIYYCZ4WV35zYALeZp3NUe0/ubdwR/+EtQLvKlxn9MSlhS66RomulT2dlZiRRumt2Sqh2SZ4npmlWPZ2w==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by MW4PR02MB10189.namprd02.prod.outlook.com (2603:10b6:303:22e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 06:14:53 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::f9b8:9236:2b34:c887]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::f9b8:9236:2b34:c887%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 06:14:53 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v11 19/21] i386: Add cache topology info in CPUCacheInfo
Thread-Topic: [PATCH v11 19/21] i386: Add cache topology info in CPUCacheInfo
Thread-Index: AQHall2JAt81Hv8c/Um3aP70QVWaT7GAXqUA
Date: Tue, 30 Apr 2024 06:14:52 +0000
Message-ID: <6766AC1F-96D1-41F0-AAEB-CE4158662A51@nutanix.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
 <20240424154929.1487382-20-zhao1.liu@intel.com>
In-Reply-To: <20240424154929.1487382-20-zhao1.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4806:EE_|MW4PR02MB10189:EE_
x-ms-office365-filtering-correlation-id: 12b4d710-a3ec-41ef-9107-08dc68dcd964
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|366007|1800799015|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0V3TG1BWmpZeHFCU0NLYWFHRjlQZDRHSGpXckNpZ29TRDNJa2RHYlBMUHRH?=
 =?utf-8?B?a0FTVlV5RXhidDFMUDI1bm44V0FaU0tydldLeHNmM1NWbjlhcGxLRmpwblNu?=
 =?utf-8?B?MXFlN2dRWEhPR2JLR0NxakZxVUFQRUxaZStPT3Q3K29xaDRiZzA4cmZTRnRq?=
 =?utf-8?B?dytDMmw4MkVoaXhWWUIyNjVFaXpQTDhyTG85SzNGcTNEbUVOM0JoM1J6STNM?=
 =?utf-8?B?c2ZWM1dubGdvU2FNOUJmLy9HU1Q1Rll1UWJXVFRQN1VFOHB3TDd1QVV0UDN1?=
 =?utf-8?B?YUdmaHBzMjVNd09UcFZrdGhnckh0bURpM1pQdFFBNG5xcmZSem1pemxSUmVi?=
 =?utf-8?B?L3NLTDlFaEUrcHJJMmlranlJeDI0bHJ3SDJZQ2ZOOEwwSS9QNDFGYjU3Zits?=
 =?utf-8?B?QzhSbTlLT0VVR3JXQXpjNVFrNVdNeFk4a2tWTExxRUlscEhVUEZ3NFd3VUdU?=
 =?utf-8?B?QU1FYmJCMmc4aXhKZU8xWWEwMVo2TCsxaWlBSlk0RVRITnUvd2JBRnJDZ1Az?=
 =?utf-8?B?M0NBa21CRWtkNGQ1MktlczNEMW1HS2dBSVZKaXFFaU5XdytFc25KRzhzejJG?=
 =?utf-8?B?WEQvWlhtcjV3clY3dUc3cG5sT2l1dzVLeHdXYjdDbGE4YXljYnNBdU1TUXVB?=
 =?utf-8?B?RWdyOGN0RklUWS84clU0azFkT0Z4UHFRajZjMi82b25KbkxzV0o0NmlXNFVj?=
 =?utf-8?B?OTNqL0NwVkRIaVRiTk9DbExSeUx3ZHNGT1VlVkhTb01SNHVEaWZ4aUgrTWx4?=
 =?utf-8?B?UFNMZDlESXhNVVM0K3BZaEhrWFh5QXl3ZjlzRUxSUmdKdURlRHpEdTUyUlow?=
 =?utf-8?B?cFpSeWJsNmtwTG5jVVBkY0haMXAyRUcvVVc3cDh1SGhxS1hsdTBiRnhmeWll?=
 =?utf-8?B?cXRxdXBYdWhVTlZuTWpGakxIUDhlTEo2dEUwQ1Q5ZGFoc2tTcTBvaGFHbUxi?=
 =?utf-8?B?Vi9hLzl3VW1rWmlXMFpOVjYxVURxY3ppMGpnTnB6T2pqMHhkc3pyYmdZdlBz?=
 =?utf-8?B?bHQ2QzRPUUwycGJDMk5ROGpCTUlxZDY3OTltN0tWVklPLzFUS3VQaFBWY1ZQ?=
 =?utf-8?B?dk1PVUxIWThmcFVnZ3Frc1NIb0VvTUpwRzUvUkRCdlF2Nk5vV0Z4TEhENTlE?=
 =?utf-8?B?cnFWZHQxNFF4dXExSkJTWnhrTXBNTlo1Qy9qV3RNVkVhbitWT2JuVlVCUVVh?=
 =?utf-8?B?MnVWN0dPYmJmcGxrbDVkdklYQ0VlVzRNMzUyZHl2VFZxZkhPL3M4bDR3UWJy?=
 =?utf-8?B?ME5WZlBZMDUxeTdWd1prVGZDQlJTQTFyeWhjdHN0S1E3OEN3NEhrN2VJMjNw?=
 =?utf-8?B?QjVneUxJMVZMMzZPK1lqbGlaN1pOQ3dLSXlScGE2TmVCTGM0cmpBWTVsMU9C?=
 =?utf-8?B?WUxmbE1Yei9EUzE0UTQwOWhjMGxqenlEd29qTkNPREhHNEJMSXo0Y0dpeFVv?=
 =?utf-8?B?WTZJcTgreDZGYTJacmFHUk9hM3h1SWV6Q2hybHZvNGtUWFMyVlBqTmhTalFJ?=
 =?utf-8?B?UHRrcEx4b1NGSWJxOW13NW83UHNpc3VnMzJjYWppcW5qQ2tRVnBxdEtwRU5p?=
 =?utf-8?B?c0wySXBtaldpdFpTMFc3TCtMZ0tDWGN4VUVWbk5aaWNCMmt2YUpuVVFDUHFa?=
 =?utf-8?B?azV2VjNodkpOTmxlcjdjbHhHSnVsbG0xZXk5WDlLVlNPd2xDYkFKSWRrcFQr?=
 =?utf-8?B?SVJOZmpsNWRtQmxtdm1NZkNvaXcvVmtFUnM0N2lJZUFiUDRrNnhuMmN3T0xL?=
 =?utf-8?B?SFk5MDh1OFhPQmZCK2pXZU91S0thWElFZEJxWmkyNHFldlpaQ1VMdGM5bVVw?=
 =?utf-8?B?ZGh2cEdmMWpLWDF3Q284QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEV1ZENxU3M5Q0JTMEgvN2lrU3VjTUtyam1RMUxwMVZPdEFCdEZ3UGRuV0Z3?=
 =?utf-8?B?dGFzODRtemFtVTVsNU8yd3B2TVRKTFNPMktmYnUzYXJRNUZ1RnowbzBJQU94?=
 =?utf-8?B?TUszUjUrbnd1VmdPMTNiUWpXNVhMcHEzUHpyeDROS3dTdnd0dmpFUXZ1SFk2?=
 =?utf-8?B?SHVIRUhuY0ZQSEgxc1lNMmh0OFJacUdSekY2dmFyaHJaZ1NmTDBOYWYrczQy?=
 =?utf-8?B?Mm5xRmU4RVROcHlER2hEUnJIUjYwSVJRUzgyY3BjblBZZzRNOERmelEreGF5?=
 =?utf-8?B?UWlENG1reFIwNGlyZ2NCM3RRYVl2NDhCZHRaaXE4RUdWSlY4NENYRWI1ZzNp?=
 =?utf-8?B?ZnJhbXRPdm43Wlk2YWp1N3JPMm15ZFdzdm1mSUJIelBCNVhWMmtqN0ZoNTFM?=
 =?utf-8?B?RWxuWTY1TGptSmVPZ2IxakM5dHRwVEkrSFlBWnI5cFlPcGVzaUcyajA2MEVz?=
 =?utf-8?B?cW9MZ3phblBqZ2JrbmcvQk5FOGQxQm5FeVpsRmY3dTBjMDJJaGdidkZ4T3lE?=
 =?utf-8?B?YkR1b3JCcHphS3o0ZU9CU1lvMGpmR2ZRMzNYYjBkMHZuYThiMmFieFNyWVds?=
 =?utf-8?B?ZXd5Wi8xcGFnVXh5VjVSU0lud1RSbGhVNmhYQUp4b1dPOFI0VzA0QlgvbDho?=
 =?utf-8?B?Vjl2emRBVjc3QStTTXBXOFl2TmhWSk02Q1dPMTBBTy9UOXBQcVFPZFFWVUps?=
 =?utf-8?B?OEY4RXNhVWpvYlVLVWM1TVVPdEZPVG5XQ04vMnB1MVVVV3lqcTlOaVN6M3p0?=
 =?utf-8?B?andrbWhnRXNiaVdvdXA2d1phMUNVSkZHbmlwcS8zajZYckpoQUxYeVpGcUo3?=
 =?utf-8?B?Q1BEM2FUcm4yQjJEQ1JCcGFCeTlzZlZDVWpEZHpadEYyc0ZwaUFJVXNpdGE5?=
 =?utf-8?B?dTBmK3hlSDV2cngxYkxLU1QvS2VMQXc0UGpGbGJyL0V3T2ozUDQ0Vlg1WE9j?=
 =?utf-8?B?Z2xtak55RmlwbFJKT2NsWitJRU53d0FpWjNWQnFVWmF4TEhLK2g4bG55UDY4?=
 =?utf-8?B?QmpMeVJPUVViKytMM0FmZXVKb2JEYTg0ajZkNjZRV1VPaXBxWFBkRlp4S0F0?=
 =?utf-8?B?QmpkZHpnVnF5aWR1eTVrQkR3WldNUkswaEZ3eVQ4U2dGcElZdXM5V0l5YVY4?=
 =?utf-8?B?MFJTYXBOTkNORm11VDFDaGJOR1VLc28rdk4vVUd2OUJWNnVVVm1hK3FicWFH?=
 =?utf-8?B?bEVFc3c2REpqdzZ3N1VtTS80S3hEN0N5Tm1wNmdQWGVpemNYM1VJTFo1UHJR?=
 =?utf-8?B?dCtZcitjaFJmWUNJZWJ1N1ZoQ1lsT0xXeDdlVGtmbHpGTVl0b21DUkpmbWwy?=
 =?utf-8?B?SmFGTTZUT2NVWStteXh4ZUVtUDNUYmVCVnUrVmZ4MFB3QjVObG4xc3dBeWVC?=
 =?utf-8?B?dkM1REo3YmtSa2FQS1VGR2gyOHB1N2RXZXpHRlBtLzFuSjFjVnFCYU1obG0v?=
 =?utf-8?B?aHZOYTFCWjVyZWowRUt0MFo2Ky9KeElQejd1Z0NWUjg5cHE4Mnc3TWZ0TzBD?=
 =?utf-8?B?ZlB6SGNRU3lQVGFrY2lGYW9HenRKNFc2a080djJmNEREdWF2aFpmRTJiYUs2?=
 =?utf-8?B?T3cyemp3bFlWZHlySy91Vld4VWhxbWVTSzBhWnFCVitONFBINHZQRnZQMERp?=
 =?utf-8?B?Y092NExkUDRGZ1YzY3hQRE9ob0Y1VVh2OFBRR0V5ZHF5ME9uSEtGZ3pPMnYr?=
 =?utf-8?B?TTYyM0NkWWtGVEtNd3dZOWpIL3VhS3FSK0tXNktpa3V6aUdORkJzVmE3dmJF?=
 =?utf-8?B?VlhRd1MxSC9iSzNlNk5IR1kzODdCdGJhMDdXSkhDZkp4eXU5VXNNVk5PRXM0?=
 =?utf-8?B?THNHWkVqZHoxMXFaSzZnTTNFM0o1eFlSblZYT2RuZklNZUhYeWhWVjVvRk1u?=
 =?utf-8?B?djJudTRES21nZFNWeUloVnBWMkMwakZKNnltVUd2Sno5RUZ0eFdncS9EUUU5?=
 =?utf-8?B?RWZ0UGpEVCt4OEpLTUY5OWFueStYVDJnd1ZiREpHT3VZU3V3eVd5UXg0TTRI?=
 =?utf-8?B?VDFCVW5hamszdHdtWGhybmxyMG9aVFpyaEorT0dBSzcyYnpLbDR6OUtZSi95?=
 =?utf-8?B?aDBreEM5MndzR2VIZUtMc1hsNGZsanZtOFBoUnVaTDBjLzZIMTZzdzNYZk5H?=
 =?utf-8?B?SUU5SVJZWGVjRlIrT29ubFVReDFqQnVRamoyd3FLMGY3RUxGMDF2bmFPcTdJ?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: multipart/alternative;
 boundary="_000_6766AC1F96D141F0AAEBCE4158662A51nutanixcom_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b4d710-a3ec-41ef-9107-08dc68dcd964
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 06:14:52.8652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPRG7J4WkhKoqdwo12S2GS1Zj8v29BOaFPultU4YSugdhZXjAMV91p0NMnM4PU8108trUaRcj3nSNFDhG54DrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB10189
X-Proofpoint-ORIG-GUID: EySfu1_lITH1D9DuSUqr7Rr_jZC84PXM
X-Proofpoint-GUID: EySfu1_lITH1D9DuSUqr7Rr_jZC84PXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--_000_6766AC1F96D141F0AAEBCE4158662A51nutanixcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCk9uIDI0IEFwciAyMDI0LCBhdCA5OjE54oCvUE0sIFpoYW8gTGl1IDx6aGFvMS5saXVAaW50
ZWwuY29tPiB3cm90ZToNCg0KQEAgLTIxNDAsNiArMjE2NCw3IEBAIHN0YXRpYyBjb25zdCBDUFVD
YWNoZXMgZXB5Y19taWxhbl9jYWNoZV9pbmZvID0gew0KICAgICAgICAubGluZXNfcGVyX3RhZyA9
IDEsDQogICAgICAgIC5zZWxmX2luaXQgPSAxLA0KICAgICAgICAubm9faW52ZF9zaGFyaW5nID0g
dHJ1ZSwNCisgICAgICAgIC5zaGFyZV9sZXZlbCA9IENQVV9UT1BPX0xFVkVMX0NPUkUsDQogICAg
fSwNCiAgICAubDFpX2NhY2hlID0gJihDUFVDYWNoZUluZm8pIHsNCiAgICAgICAgLnR5cGUgPSBJ
TlNUUlVDVElPTl9DQUNIRSwNCkBAIC0yMTUyLDYgKzIxNzcsNyBAQCBzdGF0aWMgY29uc3QgQ1BV
Q2FjaGVzIGVweWNfbWlsYW5fY2FjaGVfaW5mbyA9IHsNCiAgICAgICAgLmxpbmVzX3Blcl90YWcg
PSAxLA0KICAgICAgICAuc2VsZl9pbml0ID0gMSwNCiAgICAgICAgLm5vX2ludmRfc2hhcmluZyA9
IHRydWUsDQorICAgICAgICAuc2hhcmVfbGV2ZWwgPSBDUFVfVE9QT19MRVZFTF9DT1JFLA0KICAg
IH0sDQogICAgLmwyX2NhY2hlID0gJihDUFVDYWNoZUluZm8pIHsNCiAgICAgICAgLnR5cGUgPSBV
TklGSUVEX0NBQ0hFLA0KQEAgLTIxNjIsNiArMjE4OCw3IEBAIHN0YXRpYyBjb25zdCBDUFVDYWNo
ZXMgZXB5Y19taWxhbl9jYWNoZV9pbmZvID0gew0KICAgICAgICAucGFydGl0aW9ucyA9IDEsDQog
ICAgICAgIC5zZXRzID0gMTAyNCwNCiAgICAgICAgLmxpbmVzX3Blcl90YWcgPSAxLA0KKyAgICAg
ICAgLnNoYXJlX2xldmVsID0gQ1BVX1RPUE9fTEVWRUxfQ09SRSwNCiAgICB9LA0KICAgIC5sM19j
YWNoZSA9ICYoQ1BVQ2FjaGVJbmZvKSB7DQogICAgICAgIC50eXBlID0gVU5JRklFRF9DQUNIRSwN
CkBAIC0yMTc1LDYgKzIyMDIsNyBAQCBzdGF0aWMgY29uc3QgQ1BVQ2FjaGVzIGVweWNfbWlsYW5f
Y2FjaGVfaW5mbyA9IHsNCiAgICAgICAgLnNlbGZfaW5pdCA9IHRydWUsDQogICAgICAgIC5pbmNs
dXNpdmUgPSB0cnVlLA0KICAgICAgICAuY29tcGxleF9pbmRleGluZyA9IHRydWUsDQorICAgICAg
ICAuc2hhcmVfbGV2ZWwgPSBDUFVfVE9QT19MRVZFTF9ESUUsDQogICAgfSwNCn07DQoNCg0KSGkg
WmhhbyBhbmQgQmFidSwgdGhhbmsgeW91IGZvciB0aGlzIHBhdGNoLiBJIGhhdmUgYSBzbGlnaHRs
eSBvZmYtdG9waWMgcXVlc3Rpb24gYWJvdXQgdGhpcyBwYXRjaC4gRmlyc3RseSwgbWFueSBBTUQg
Q1BVIG1vZGVscyBoYXZlIHByZS1kZWZpbmVkIGNhY2hlIHNpemVzIGZvciB0aGUgdmFyaW91cyBj
YWNoZSBsZXZlbHM7IGhvdyBhcmUgdGhlc2UgdmFsdWVzIGRlY2lkZWQ/IEkgY291bGRuJ3QgZmln
dXJlIHRoYXQgb3V0IGZyb20gdGhlIHBhdGNoZXMgdGhhdCBpbnRyb2R1Y2VkIHRob3NlIGNoYW5n
ZXMuIFNlY29uZGx5LCB0aGVyZSBpc24ndCBhbnkgcHJlLWRlZmluZWQgY2FjaGUgc2l6ZSBmb3Ig
SW50ZWwsIGFuZCB0aGUgbGVnYWN5IGNhY2hlIHZhbHVlcyBhcmUgdXNlZC4gVGhpcyB2YWx1ZSBj
YW4gYmUgdmFzdGx5IGRpZmZlcmVudCBmcm9tIHdoYXQgYWN0dWFsIGF2YWlsYWJsZSBjYWNoZXMg
bWlnaHQgYmUuIElzIHRoZXJlIGFueSByZWFzb24gd2h5IHNvbWV0aGluZyBsaWtlIHRoYXQgZm9y
IEludGVsIGhhcyB5ZXQgdG8gYmUgaW50cm9kdWNlZD8NCg0KcmVnYXJkcywNClRlanVzDQoNCg==

--_000_6766AC1F96D141F0AAEBCE4158662A51nutanixcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <0C357D484C4B484EB6EF9A20FDA1E886@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHN0eWxlPSJvdmVyZmxv
dy13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6
IGFmdGVyLXdoaXRlLXNwYWNlOyI+DQo8YnIgaWQ9ImxpbmVCcmVha0F0QmVnaW5uaW5nT2ZNZXNz
YWdlIj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2Pg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+
DQo8ZGl2Pk9uIDI0IEFwciAyMDI0LCBhdCA5OjE54oCvUE0sIFpoYW8gTGl1ICZsdDt6aGFvMS5s
aXVAaW50ZWwuY29tJmd0OyB3cm90ZTo8L2Rpdj4NCjxkaXY+DQo8ZGl2Pjxicj4NCkBAIC0yMTQw
LDYgKzIxNjQsNyBAQCBzdGF0aWMgY29uc3QgQ1BVQ2FjaGVzIGVweWNfbWlsYW5fY2FjaGVfaW5m
byA9IHs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsubGluZXNfcGVyX3RhZyA9IDEsPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7LnNlbGZfaW5pdCA9IDEsPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Lm5vX2ludmRfc2hhcmluZyA9IHRydWUsPGJy
Pg0KKyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuc2hhcmVfbGV2
ZWwgPSBDUFVfVE9QT19MRVZFTF9DT1JFLDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO30s
PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LmwxaV9jYWNoZSA9ICZhbXA7KENQVUNhY2hl
SW5mbykgezxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOy50eXBlID0gSU5TVFJVQ1RJT05fQ0FDSEUsPGJyPg0KQEAgLTIxNTIsNiArMjE3Nyw3IEBA
IHN0YXRpYyBjb25zdCBDUFVDYWNoZXMgZXB5Y19taWxhbl9jYWNoZV9pbmZvID0gezxicj4NCiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5saW5lc19wZXJf
dGFnID0gMSw8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsuc2VsZl9pbml0ID0gMSw8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsubm9faW52ZF9zaGFyaW5nID0gdHJ1ZSw8YnI+DQorICZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5zaGFyZV9sZXZlbCA9IENQVV9UT1BP
X0xFVkVMX0NPUkUsPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fSw8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsubDJfY2FjaGUgPSAmYW1wOyhDUFVDYWNoZUluZm8pIHs8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsudHlwZSA9IFVO
SUZJRURfQ0FDSEUsPGJyPg0KQEAgLTIxNjIsNiArMjE4OCw3IEBAIHN0YXRpYyBjb25zdCBDUFVD
YWNoZXMgZXB5Y19taWxhbl9jYWNoZV9pbmZvID0gezxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5wYXJ0aXRpb25zID0gMSw8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuc2V0cyA9IDEwMjQsPGJy
Pg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LmxpbmVz
X3Blcl90YWcgPSAxLDxicj4NCisgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7LnNoYXJlX2xldmVsID0gQ1BVX1RPUE9fTEVWRUxfQ09SRSw8YnI+DQombmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDt9LDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5sM19jYWNoZSA9
ICZhbXA7KENQVUNhY2hlSW5mbykgezxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOy50eXBlID0gVU5JRklFRF9DQUNIRSw8YnI+DQpAQCAtMjE3NSw2
ICsyMjAyLDcgQEAgc3RhdGljIGNvbnN0IENQVUNhY2hlcyBlcHljX21pbGFuX2NhY2hlX2luZm8g
PSB7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
LnNlbGZfaW5pdCA9IHRydWUsPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7LmluY2x1c2l2ZSA9IHRydWUsPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LmNvbXBsZXhfaW5kZXhpbmcgPSB0cnVlLDxi
cj4NCisgJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnNoYXJlX2xl
dmVsID0gQ1BVX1RPUE9fTEVWRUxfRElFLDxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO30s
PGJyPg0KfTs8YnI+DQo8YnI+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPGJyPg0K
SGkgWmhhbyBhbmQgQmFidSwgdGhhbmsgeW91IGZvciB0aGlzIHBhdGNoLiBJIGhhdmUgYSBzbGln
aHRseSBvZmYtdG9waWMgcXVlc3Rpb24gYWJvdXQgdGhpcyBwYXRjaC4gRmlyc3RseSwgbWFueSBB
TUQgQ1BVIG1vZGVscyBoYXZlIHByZS1kZWZpbmVkIGNhY2hlIHNpemVzIGZvciB0aGUgdmFyaW91
cyBjYWNoZSBsZXZlbHM7IGhvdyBhcmUgdGhlc2UgdmFsdWVzIGRlY2lkZWQ/IEkgY291bGRuJ3Qg
ZmlndXJlIHRoYXQgb3V0IGZyb20gdGhlIHBhdGNoZXMNCiB0aGF0IGludHJvZHVjZWQgdGhvc2Ug
Y2hhbmdlcy4gU2Vjb25kbHksIHRoZXJlIGlzbid0IGFueSBwcmUtZGVmaW5lZCBjYWNoZSBzaXpl
IGZvciBJbnRlbCwgYW5kIHRoZSBsZWdhY3kgY2FjaGUgdmFsdWVzIGFyZSB1c2VkLiBUaGlzIHZh
bHVlIGNhbiBiZSB2YXN0bHkgZGlmZmVyZW50IGZyb20gd2hhdCBhY3R1YWwgYXZhaWxhYmxlIGNh
Y2hlcyBtaWdodCBiZS4gSXMgdGhlcmUgYW55IHJlYXNvbiB3aHkgc29tZXRoaW5nIGxpa2UgdGhh
dCBmb3INCiBJbnRlbCBoYXMgeWV0IHRvIGJlIGludHJvZHVjZWQ/PC9kaXY+DQo8ZGl2Pjxicj4N
CjwvZGl2Pg0KPGRpdj48Zm9udCBjb2xvcj0iIzAwMDAwMCI+PHNwYW4gc3R5bGU9ImNhcmV0LWNv
bG9yOiByZ2IoMCwgMCwgMCk7Ij5yZWdhcmRzLCZuYnNwOzwvc3Bhbj48L2ZvbnQ+PC9kaXY+DQo8
ZGl2Pjxmb250IGNvbG9yPSIjMDAwMDAwIj48c3BhbiBzdHlsZT0iY2FyZXQtY29sb3I6IHJnYigw
LCAwLCAwKTsiPlRlanVzPC9zcGFuPjwvZm9udD48L2Rpdj4NCjxicj4NCjwvYm9keT4NCjwvaHRt
bD4NCg==

--_000_6766AC1F96D141F0AAEBCE4158662A51nutanixcom_--

