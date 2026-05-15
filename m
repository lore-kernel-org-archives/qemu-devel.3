Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252C5CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNuVC-0005sw-Kp; Fri, 15 May 2026 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wNuUg-0005gv-1c; Fri, 15 May 2026 11:30:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wNuUd-0007ds-8a; Fri, 15 May 2026 11:30:29 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64F9nxgV1810078; Fri, 15 May 2026 08:29:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=AB88VGimU95FgMD
 HIvHajTRyUv160uxlKoktja43Mz4=; b=pJHgF64WUz2GRHUjB6um68XANA1OhQY
 Zwvhag0k+KSiKrsBS/fDjluYl2IwBk0zXwaqg72EJAhXbmooNE9YuRf8Yi/JdQZt
 tbvWQmVA+5875n07+oHZPMzo2jt0QEIDXkXoxecShpXb619OsP4Lsno6OBfyvrfm
 /Uo/U2VHdPzRm+SvNRzD/pjAXVoYqejzTfISqYEg8orieAboXjaFpbAinVhV/MQq
 RGpQGica9aG65VLjSKIuqnap0jLkbLC7Oc9M6JE3jDroXQ7fGON1BYUtxBaMCV6m
 tkSwwz815hR42EHO3MxTF/Ui7MZveZ/30zQ29O4a4dAtPOpvRXCttHA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020094.outbound.protection.outlook.com [52.101.56.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e5m20aceh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 15 May 2026 08:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQk4Gup8X0qtF3H4R8irB4hucH2YHmTseoAnE/XMRUjS90torNEn7Z0xNj2LMRZKItuvr5hI1iB1xGkP9Th8eMCknEjO8Ax+SH2TR9v/lj3/IJ84uzXGmyX4ATH6MM+p0lh6R8jLlGhsagr++P9Sas3iAWbad2Bq+vEdOivJoUCfSFh7w1FZrmi9a30LpurlJKEx6qeqZUzNpoocd+yaClnoAz3HW4MAIWtyZwDpmIsD+lQMfYRxCAKrAHCGSFdVFTTZvai2gcNYG8c2JuYdNncbYYucjt8ppQvIvGjmLCOLtwwAKd5h4fVqsz6BRN6I7oikPCvR9GHsAcBw32WWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB88VGimU95FgMDHIvHajTRyUv160uxlKoktja43Mz4=;
 b=H9WWrAK9BsYnD4FB9NDpEETcU77bL7wRN/YTecH4rrXoxG0HQKb42MlTLeOHHR4uIxgOE5OKS90kJQ7pVinNmH5pnDVSmNkfSKyZ/QxQcfhvtV6GbOIE4kfx7TyAONNfVwkBwhGo1MvU2w6Q71Lhh/LahzCYVfNjJg3OfwBACkqCl5yOeK9qyBB23o4aXVK4pw/RUTXWOje6ZTQO/kASUtZvPaqhrMfUcZfP0/6fdze4mKzBDcQ8Xs0smPxcCYEMehOwwWPagMJLBLd0gxW73/1RqLAu+5H5ziOgfIN5uWSP8xk044hBKElrbvvtnD3hZpqXaw/lF1hI7R4WfpwAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB88VGimU95FgMDHIvHajTRyUv160uxlKoktja43Mz4=;
 b=W2icc4nyrdp84wE+Bpy7FUDgFvCu22ad99G7/BQyuW0NBjUM+JwCtqPuzsXIO8mLqrQRJJbKKvY2yjghYn+On/PNbNGVMts5h45ZxMqFOsp94ljlE90Q0hbdK8M0CxzVbflifOJLVnsr1R8Q4m+kSGy8mUo0Zpudy9sebOoUcEOG9P8IgLFc5CyqSSZUQJZhcoAZq0eLuTl5wnGRjU0GW8+UwUt4hBN3AJbHRAFR3TQu91gjvaHy2u9eXa6TH4opEiFUqC8p2Jymu+dMJDz5rlFRL0mhsCdvabBuBLLe5gI8hbz9yvYvE1NCTEOx8kaHC/A5a1tQfjrXieflm0rO8g==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by DM6PR02MB6940.namprd02.prod.outlook.com (2603:10b6:5:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 15:29:40 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%6]) with mapi id 15.21.0025.019; Fri, 15 May 2026
 15:29:40 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>
CC: Shaju Abraham <shaju.abraham@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sebott@redhat.com" <sebott@redhat.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 Jon Kohler <jon@nutanix.com>, Jonathan Davies <jond@nutanix.com>
Subject: Re: [RFC PATCH v1 02/13] target/arm: named_cpu_model: Add ID Register
 Fields
Thread-Topic: [RFC PATCH v1 02/13] target/arm: named_cpu_model: Add ID
 Register Fields
Thread-Index: AQHc4vZUSy91MSEtGEqhLU61tmz+/LYPOD6AgAABEQA=
Date: Fri, 15 May 2026 15:29:40 +0000
Message-ID: <9F50742F-932F-4DFC-949F-33C6483653D9@nutanix.com>
References: <20260513163356.3033159-1-shaju.abraham@nutanix.com>
 <20260513163356.3033159-3-shaju.abraham@nutanix.com>
 <2c4741a4-e37e-48bc-8fe5-cab2b9e67793@redhat.com>
In-Reply-To: <2c4741a4-e37e-48bc-8fe5-cab2b9e67793@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|DM6PR02MB6940:EE_
x-ms-office365-filtering-correlation-id: 9d360dad-c978-41bb-c1c0-08deb296c7d9
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|8096899003|56012099003|22082099003|38070700021|18002099003|4143699003;
x-microsoft-antispam-message-info: EkTj6JRq4uCHWuvGAKXJVBe2HMiwYMrxOGO+lulyobi1McLsRu74xxQzPHjQNKdvYSPZYdtr0KANKTckivkRoMpjguYAJCQfOcy565wI1YfBJ5fAgKYGSQ0UFb1ewMjrsm7DteWc7Q2/8mwDszjfNCCwhP0CgA6xoVbLyox9uVbuWUxGdh1OLLOWHyo9AzzMJfto6AsBIIkthlQvvnAfZHtcJka2mXv8QKwlTCyZRkqWIe2AoBp27G8AONfGZ9mzI/gzSYKqo4DOKucc6/YdkF0jHVB2pA2QfTmtP3+uGv0Ub59DlIEDDptZfzIJ4/jyB3+h2b/g7Ip57OZRu4XFCinwm719yEXuVy3cbWvrQS5ORJ7E+qhbwQa7OLjckqxh8uEr00EcL3iueWpYQe7r2dD7zUWZ9GHJJcI7xqDKkaBiSV2Q8tUxLil7o6cATFJL2xlz50OruYXeZF+kAdJxEaS/okX80A5kv3SItJCtw+Fxo6yqeZRedh3UkmKMmgdKLBoxIVoGpobLgGl6qiVZo7pjcFwkt5n9xokfrq3euafb4/VrEtVeSJWn6Fw1rDBFZcDgQHbpLd427zsu9E0MLRRYGbNKmaj6QuU9aYZCwDf2GNTJKwnkIyYYISf6Kx66gnw7vp4vaqBAtq3pZV9D3ep1YGLDlJl5Cf5nlNCpbhyY6EmGm+v8iF6jXuhNgKNLp/mTK/nzElAd6/CqYd/rqxwosF7uw4cAgbEgCH3SaB5ttraRevdROyuHgqgobvsW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(8096899003)(56012099003)(22082099003)(38070700021)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzRVVnpIZG1WangvakFCelMxRFZ0cWUvbTNXWG9Dd3RuZnNabFpvdVVMYWI5?=
 =?utf-8?B?TGNLWWRCcFYyaDY0R2RyQk5tQ0tZeTcwNERib1plZ0dib0JaM3ZYNDl2T0xn?=
 =?utf-8?B?SHRHVFhwSnZsd0ZVdVhyOEo3V05VOU1mdUt1OUU3bFZkMDNRdHA0ajFSZlZZ?=
 =?utf-8?B?V1d5V2lwek5UN1pMem9XeGIyVFB2Q05SeEZ1djdnaGJmcTRIYVBMakdpOFdL?=
 =?utf-8?B?MW9SNWhPNW1XU21nUmsvNUk2YnNXcFdXcjRGbHQwTWYzK21SL1ZnN1JJWnNs?=
 =?utf-8?B?VEV5OHpERkh5dXJ2bithRUNPR3dRelVFeXYxUEoyZW5uYWhLdWNYalg0K0d2?=
 =?utf-8?B?YjZqU0I5Q1I5UmlZR2lqSkIrQTllekhmemRjOVNsdnR3VHFZTFdVTmhKanUr?=
 =?utf-8?B?cWhyNzBRRExiQ0ZQSUNvcTBtNkViOUtvTVNXbjg1eTR2b2Y3emlUczhpQXV5?=
 =?utf-8?B?czIrRWdlYy9scUovQU9aZVFESUM5L3BlOEhkVjhyajVFRDZ3MFpzR1BKaU5G?=
 =?utf-8?B?Z09QL0lQL2cvcXI4M0dIcFR2ZGtZc2xXUWpqdVFnQXZtV2RiUWFmS0duSWlM?=
 =?utf-8?B?WGxNUkpOMzBWMGJJV0tJTW1DUk5lSjd6eDZzOVJ3Q2dVTWNaRVBvcUZJSmhU?=
 =?utf-8?B?bFU2cWNRdmIrbkxEVys0dWgzMlBYMjVpQTNtVThsY2F3OWtHMjBoOWZjVWRr?=
 =?utf-8?B?cjRHWlEwVEF4ZEl4M3JabnJMN3JXQk5KdzNSMmdDS0xENEJwWFA0aXk3MEhk?=
 =?utf-8?B?MkM2eFAzR0phZ2ZIYUhjNEduckU1akFEWkh1K2lvZ3Q1dnpDdk00dEEvaTJT?=
 =?utf-8?B?VWsra282d2xDNDRJS1pjSW9naUxVSU5XNVFHSzVzTENYa21zSHVaK3BJRW55?=
 =?utf-8?B?ejZ1elNBSzdqYWYxOE5RWEg4VFNyYVVoeWZWNEdxY1k0ckJIcGtRQm1ncGpo?=
 =?utf-8?B?SHBKbThhdXZDZkpyZFRFSGFoWFV3azRPdG00d0UvYmdNK2FodS90U0xMeml6?=
 =?utf-8?B?WFB3aStWQXBzaFZnT25lN2l2dnh2UEJqa3RtbUg4WVV0d1YrVGo3cFhOVFFy?=
 =?utf-8?B?NmdvY20yOFhtUDJLTGlDbklJcXFhaVgzbmR6dGowN3JEUm54RnJ2b2VEMGtX?=
 =?utf-8?B?emtFK3Q4bzdhSFl6SUtCTzJUbS83cU94dW5QQlZ3M2xXdXBteWFyZGlQWnBF?=
 =?utf-8?B?STREQkE0U0VoYUdVRTNxS2J2MmpVNkI1azg1eXU5cWVmWldSV2ppWVJQV05x?=
 =?utf-8?B?azl5dk1ENTF0NnYvWE9KZDVkLzR1TkpBakR4VmlZYmdNdmw5NjVhUEVwdUtI?=
 =?utf-8?B?OWVvU29QYWxLT0RoSGpHMFNsc3V0b1pPOFFSeUsvd0JjdXc0TWEwN3V6em53?=
 =?utf-8?B?K3lVd21iWnpSTEYrdzVscGhFUDNldDdmdncxL2RNRzFweDRnVUFyakJCY1ZK?=
 =?utf-8?B?ZU91aTVFYjFmSjc3M2Y5L1d6anllcmpWemprSGZ1dm5EYWZwemw4cDdJbDRU?=
 =?utf-8?B?aFdsb256RlRrUGdCdWJNWEFMT3FhVWN1Y092QS9WUkR3ZWZQZnRzU050VUVI?=
 =?utf-8?B?eHpOdUNrVGhhQVJJV1JRUVhZUjRGM0dWOHBmSndEMFAxK1RGTmtvK21iMUZ4?=
 =?utf-8?B?bnA2QzErNEwwZTdrV3diTXpWSUFWVlZZeGkyc2NwaTl6Q1JmUUE0T3VKalRy?=
 =?utf-8?B?M0syUVV6THRWU2NKZjE5TlFscGxVY0lqcDUyVTRySVJ1eTRtbDlZMVRvNlI1?=
 =?utf-8?B?c0FCcTFvbHh0YUhyUXR1TUFWZHJjSHdZVFhYTnVHQ2loTWw5ak5LU2p3Ukpn?=
 =?utf-8?B?Y0FVQmxaY0g0VTI2aHJXYnc1UkFOQit4d1ZxL1FyQXgyRFNnSWp6ZlVramNK?=
 =?utf-8?B?ZUp1cWtKQkpTL1NHWlJOSnBqc213SUtjY0hSRFhDR3FYWXc5dWNIemlBa2Iv?=
 =?utf-8?B?YWtCQmxweUgxaFlUbXFScXlQalFzSUVOYU5SV2h0VHE0MlVQZ3RhOUhUaysy?=
 =?utf-8?B?NTAyaFRMZFBOczZhZXl1QTQrbXFHQVZFeWpoNjd6RngyNTZFWWNFVktxU0ZQ?=
 =?utf-8?B?RjZRTUt2VVp3Y003Q3NFQmZsNFdjZWlCZElycVFGQ3FHQjU1dVJZdUovQTVq?=
 =?utf-8?B?YXdISStiNXVxRyt6QU5BU3N1OFV3bHAyNWlqWjRnRHhseGpGNW9qUFJaeTY0?=
 =?utf-8?B?N0ZWM2xDeTJ1TGlWVlRaOUJWOC96dS9USjRKazMydHNFU0E3eU55dG1kYjVJ?=
 =?utf-8?B?ZmlpYUJ3ek9QMnhlMW54TSt5YWhNSEF4MlBTU0M4OFMwaU11YzBNQVI2UWlm?=
 =?utf-8?B?Yit6Y2lvUUtsc3Fmd1A4VVU2cmlzZml1YjFGM3JUM09iVldhRzd4MkxsQ1Vm?=
 =?utf-8?Q?2w81hjn5YM6ESTvp2cmEQVLGcjDs48MpcLvhGbz2W08Tc?=
x-ms-exchange-antispam-messagedata-1: ml8ihOcpE1mazbI2XysWq8Qz+KtbXZy3Uzs=
Content-Type: multipart/alternative;
 boundary="_000_9F50742F932F4DFC949F33C6483653D9nutanixcom_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dBe1MMUgvwlS8uJsbyw3HwJ7r3FN2mpu+YdwX/qAAYIBn/ecXVUGSEahTSZ/PRY+UGE7pgZqi7TpqJjY4x+sgMZ7b3YIqBO2zQF0XGFnLi5IevGmd7oKjFxNH3Gm/30smPa8lRVMdImt1BRTfBiDmH5ahm/Bq4v2aaOm9Rv7zVH72CN+B8xVFf2amlCZdqQXaGJIUjyfzkzvggxbuy/GCflZbIVU+fBNgeYJ9V/guIdukO7jUdNEWDZWT131hLtY0RyEEgAE/Zhl8FFDglZ+2VlUT/L+Da6iDVVkQ2KaCE9rcxnbndW6XsdBeFRcP6x1XcrzsGtEPOgZJ63ZHs/4fA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d360dad-c978-41bb-c1c0-08deb296c7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 15:29:40.0362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhM6YOS2yXIZomkUBge+p/eTrFqq3K66y43F8dKSE+KZorMdBZ/IIOYQoRGbikGOh9vcsC6wBDnV1vKz04peX24ZvSq8sjXmPQer8hKVOUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6940
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1NyBTYWx0ZWRfX0P96p/0oZSUB
 qzD1VPJcMTEwo6uWOSbhqu71Kd+JQ0IpuY7156mNGvX7kod6C6TOetci7ztlhnAfohaEwrMZ57f
 qnFXFuVyYL8fjFq+zYxqfCvJU/v3HTvOfROnB3mWzHflCvm3tKq5WdNb3jyH5RRXpCMuxuN9VR2
 sbcsUP4YbmNR1yt/RAYbvfg3SQHqyOer/jeflkEF+kDXLFKxQw6ac+5D4pxuIVW7aVggMc0ak94
 GM57OIvHcu0YEbYKGO3jUv4guafn711VX7ct4CtjhNi78pB/xo6MgAIo3VzQ3V0jdIpBCr9vn/t
 ItrpJW9mmU/Epa+EEGbJiqPv1PgaMKwcY2cLcpA97gHxWxr+kjQBpj3B3jckP7J4ldboFLMqaGS
 Bge8qolH5oaTlV6esB3vR6gz/1RXXJA9ssg2J0MGhqpqJb2bvZVCrTBe3ML8iHgD6/PQG+pQub/
 ybzKWbLCb+yzNU2yCjg==
X-Proofpoint-GUID: frTvYNCY6ugQn0qULAgtcxisOn222rxD
X-Proofpoint-ORIG-GUID: frTvYNCY6ugQn0qULAgtcxisOn222rxD
X-Authority-Analysis: v=2.4 cv=Ed34hvmC c=1 sm=1 tr=0 ts=6a073be8 cx=c_pps
 a=VRpCj/H3b9lxb5zSmaw64g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22
 a=VUi8bpU7OL1Oj2-RSIOF:22 a=20KFwNOVAAAA:8 a=tIOw6SRf8iM2cIvvtFMA:9
 a=QEXdDO2ut3YA:10 a=ERt-L-QtZeGL-JZ6:21 a=_W_S_7VecoQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

--_000_9F50742F932F4DFC949F33C6483653D9nutanixcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCk9uIDE1IE1heSAyMDI2LCBhdCA4OjU14oCvUE0sIEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJA
cmVkaGF0LmNvbT4gd3JvdGU6DQoNCkkgZG9uJ3Qgc2VlIENMSURSX0VMMSBmb3IgaW5zdGFuY2Ug
d2hpbGUgc29tZSBmaWVsZHMgYXJlIHdyaXRhYmxlLg0KDQpBcyBhIHJlY29yZCBoZXJlIGlzIHRo
ZSBsaXN0IG9mIHdyaXRhYmxlIGZpZWxkcyBJIGNhbiBjb2xsZWN0IG9uIGENCkdyYWNlLUhvcHBl
ciBtYWNoaW5lLg0KDQpZZXMsIENMSURSX0VMMSBpcyBtaXNzaW5nIGlzIGtub3duLiBXaWxsIGJl
IGFkZGVkIGluIHYyLCB3aXRoIHByb3BlciBoYW5kbGluZyBmb3IgQ0NTSURSX0VMMS4NCg0KDQpX
YXJtIFJlZ2FyZHMsDQpLaHVzaGl0DQo=

--_000_9F50742F932F4DFC949F33C6483653D9nutanixcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <7F7B43D869C6CB4DBC509A7302C7E70C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWwgYXJpYS1sYWJlbD0ibWVzc2FnZSBib2R5Ij4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPC9o
ZWFkPg0KPGJvZHkgc3R5bGU9Im92ZXJmbG93LXdyYXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJz
cC1tb2RlOiBzcGFjZTsgbGluZS1icmVhazogYWZ0ZXItd2hpdGUtc3BhY2U7Ij4NCjxiciBpZD0i
bGluZUJyZWFrQXRCZWdpbm5pbmdPZk1lc3NhZ2UiPg0KPGRpdj48YnI+DQo8YmxvY2txdW90ZSB0
eXBlPSJjaXRlIj4NCjxkaXY+T24gMTUgTWF5IDIwMjYsIGF0IDg6NTXigK9QTSwgRXJpYyBBdWdl
ciAmbHQ7ZXJpYy5hdWdlckByZWRoYXQuY29tJmd0OyB3cm90ZTo8L2Rpdj4NCjxiciBjbGFzcz0i
QXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+DQo8ZGl2PjxzcGFuIHN0eWxlPSJjYXJldC1jb2xv
cjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEycHg7
IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWln
aHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgb3JwaGFuczogMjsgdGV4dC1hbGlnbjog
c3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFj
ZTogbm9ybWFsOyB3aWRvd3M6IDI7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ry
b2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsgZmxvYXQ6IG5vbmU7IGRpc3Bs
YXk6IGlubGluZSAhaW1wb3J0YW50OyI+SQ0KIGRvbid0IHNlZSBDTElEUl9FTDEgZm9yIGluc3Rh
bmNlIHdoaWxlIHNvbWUgZmllbGRzIGFyZSB3cml0YWJsZS48L3NwYW4+PGJyIHN0eWxlPSJjYXJl
dC1jb2xvcjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6
IDEycHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9u
dC13ZWlnaHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgb3JwaGFuczogMjsgdGV4dC1h
bGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0
ZS1zcGFjZTogbm9ybWFsOyB3aWRvd3M6IDI7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRl
eHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbi1saW5lOiBub25lOyB0ZXh0LWRl
Y29yYXRpb24tdGhpY2tuZXNzOiBhdXRvOyB0ZXh0LWRlY29yYXRpb24tc3R5bGU6IHNvbGlkOyI+
DQo8YnIgc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBIZWx2
ZXRpY2E7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQt
Y2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogNDAwOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyBv
cnBoYW5zOiAyOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFu
c2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdpZG93czogMjsgd29yZC1zcGFjaW5n
OiAwcHg7IC13ZWJraXQtdGV4dC1zdHJva2Utd2lkdGg6IDBweDsgdGV4dC1kZWNvcmF0aW9uLWxp
bmU6IG5vbmU7IHRleHQtZGVjb3JhdGlvbi10aGlja25lc3M6IGF1dG87IHRleHQtZGVjb3JhdGlv
bi1zdHlsZTogc29saWQ7Ij4NCjxzcGFuIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAsIDAp
OyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEycHg7IGZvbnQtc3R5bGU6IG5v
cm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IDQwMDsgbGV0dGVy
LXNwYWNpbmc6IG5vcm1hbDsgb3JwaGFuczogMjsgdGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5k
ZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3aWRv
d3M6IDI7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7
IHRleHQtZGVjb3JhdGlvbjogbm9uZTsgZmxvYXQ6IG5vbmU7IGRpc3BsYXk6IGlubGluZSAhaW1w
b3J0YW50OyI+QXMNCiBhIHJlY29yZCBoZXJlIGlzIHRoZSBsaXN0IG9mIHdyaXRhYmxlIGZpZWxk
cyBJIGNhbiBjb2xsZWN0IG9uIGE8L3NwYW4+PGJyIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAs
IDAsIDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEycHg7IGZvbnQtc3R5
bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IDQwMDsg
bGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgb3JwaGFuczogMjsgdGV4dC1hbGlnbjogc3RhcnQ7IHRl
eHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFs
OyB3aWRvd3M6IDI7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRo
OiAwcHg7IHRleHQtZGVjb3JhdGlvbi1saW5lOiBub25lOyB0ZXh0LWRlY29yYXRpb24tdGhpY2tu
ZXNzOiBhdXRvOyB0ZXh0LWRlY29yYXRpb24tc3R5bGU6IHNvbGlkOyI+DQo8c3BhbiBzdHlsZT0i
Y2FyZXQtY29sb3I6IHJnYigwLCAwLCAwKTsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgZm9udC1z
aXplOiAxMnB4OyBmb250LXN0eWxlOiBub3JtYWw7IGZvbnQtdmFyaWFudC1jYXBzOiBub3JtYWw7
IGZvbnQtd2VpZ2h0OiA0MDA7IGxldHRlci1zcGFjaW5nOiBub3JtYWw7IG9ycGhhbnM6IDI7IHRl
eHQtYWxpZ246IHN0YXJ0OyB0ZXh0LWluZGVudDogMHB4OyB0ZXh0LXRyYW5zZm9ybTogbm9uZTsg
d2hpdGUtc3BhY2U6IG5vcm1hbDsgd2lkb3dzOiAyOyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtp
dC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGZsb2F0OiBu
b25lOyBkaXNwbGF5OiBpbmxpbmUgIWltcG9ydGFudDsiPkdyYWNlLUhvcHBlcg0KIG1hY2hpbmUu
PC9zcGFuPjxiciBzdHlsZT0iY2FyZXQtY29sb3I6IHJnYigwLCAwLCAwKTsgZm9udC1mYW1pbHk6
IEhlbHZldGljYTsgZm9udC1zaXplOiAxMnB4OyBmb250LXN0eWxlOiBub3JtYWw7IGZvbnQtdmFy
aWFudC1jYXBzOiBub3JtYWw7IGZvbnQtd2VpZ2h0OiA0MDA7IGxldHRlci1zcGFjaW5nOiBub3Jt
YWw7IG9ycGhhbnM6IDI7IHRleHQtYWxpZ246IHN0YXJ0OyB0ZXh0LWluZGVudDogMHB4OyB0ZXh0
LXRyYW5zZm9ybTogbm9uZTsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgd2lkb3dzOiAyOyB3b3JkLXNw
YWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRp
b24tbGluZTogbm9uZTsgdGV4dC1kZWNvcmF0aW9uLXRoaWNrbmVzczogYXV0bzsgdGV4dC1kZWNv
cmF0aW9uLXN0eWxlOiBzb2xpZDsiPg0KPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8L2Rpdj4NCjxi
cj4NCjxkaXY+WWVzLCBDTElEUl9FTDEgaXMgbWlzc2luZyBpcyBrbm93bi4gV2lsbCBiZSBhZGRl
ZCBpbiB2Miwgd2l0aCBwcm9wZXIgaGFuZGxpbmcgZm9yIENDU0lEUl9FTDEuPC9kaXY+DQo8ZGl2
Pjxicj4NCjwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+V2FybSBSZWdhcmRzLDwvZGl2
Pg0KPGRpdj5LaHVzaGl0PC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_9F50742F932F4DFC949F33C6483653D9nutanixcom_--

