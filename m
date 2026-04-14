Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD84F9D0D3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfUt-0003zS-Pz; Tue, 14 Apr 2026 11:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wCfUr-0003z9-Pu; Tue, 14 Apr 2026 11:16:14 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wCfUl-0003IV-OG; Tue, 14 Apr 2026 11:16:12 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ED3uvg658424; Tue, 14 Apr 2026 08:15:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1F9kSExJXcbxIYEzE14KFlTHns1oDyZZSY8HeuMs9
 hI=; b=D0I4OKXTcwpidcW9D0XNauzjbCvORI+rPHtklY0C9UDr9xfsjxMU1cohM
 6mkUd/6oSjMSez7oi/cAdFtjI1tW4GZtfJ5Xe/EjakLIVwbVz6Jifz7pdN3cemjg
 y2Aksh4sZNvinUkbnVfXLmzKUbkh5qNAOmRZdQU5cnuuoXHUBHmgC8PBqTN3Yhyk
 ZYk5/sqR0RRC9OFel3uXHLrgBpecLEXiokOdouX+3ST2nsCl496mETXJs+WYlJ0y
 bUr2ZUEqwgVR9S0j0s8XZuY92qArFVNz7oM+cRa59NrnVccldQhiTRaIMxxkGfCe
 EMYQdLp1pdBIVpCXSvhTEjAIigGbA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020133.outbound.protection.outlook.com [52.101.61.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dh84stqxf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Apr 2026 08:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDu9HwN2q+SIDzGLZ9fYgb9uLeX1yZptHd80rKZRYEYGOR3odqvIsFQns1KAH693cPwHouHRJcfVlE9f0Ct4bbN9Sn4MwHwg9JlF/SpigCTlSFebLU1ifdKiqFnVDiRFsJp9U9ysC0z+TXKAwA0M2zb2TvT7B8RryaoXB29S2KW9uSXe1yQRRqS8fLOgBDVBBPu77K4zXpRu7vXUdf6R8OhE6HMENkS2/CGKZrvZASeF88RjvYkz+dLP9AJ1BwdpoPF9yS2GsKByNu+VPoj20lFOFnJsi/Y5PpmZSKBz5LTPo7SV/jkZzwfarpUrq9gN8xkQnSm5xAeYbrlMyAluTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F9kSExJXcbxIYEzE14KFlTHns1oDyZZSY8HeuMs9hI=;
 b=sPJbwuTxgsJ//SU3V/af2byinTWcxJFK5Yu/oLGBFYPbDcUHyDMFFGatkGlcmQA89IRiuCnUQQPZCertSLQTK44AEG+WULyN1tfMCilAiy8aDcil9C18f7RWTRUDaJrPgq0zdNVnoDKcnpsKGnNvHTsdXT4G8MF4xE0UbOdEqRFlO6lswls534Q2Ec0OQk1XALE5SOLYjqr8oniJ5W7YjryyKw+bp39kHJ18k2dJ/63kqtobCLAJaEfryC0XAjExeevwesbg6ZBsXt5QcqvYjdXyXrzLcdzfpKFVcoZy1+c3QewFfqK3Q9X+8OfSQogF5KM1QZ+QN7SFBmN2Umq8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F9kSExJXcbxIYEzE14KFlTHns1oDyZZSY8HeuMs9hI=;
 b=aR9y2x0S9WWkCPITg/Sk4STYqRRlOZ+CQSxT56Kl4/E5THEmxDNIZkXq3UG2NH2m0f/HmzuV/Cy7mkiabmEpdkdUIA4Et/qQ7Uxh0mBS5ear/T/c4ygPBmfOkFA6NgZLRSmwVdZ5lJ5Uo2qjYiz3EkR4qyxuh0RDufd0429KhESYcm4yFXXcXIcYchypn7s8BeCnTIqDK0uT3QreEVk4+O0l9fKY1/7qMWC0v3bCBX5F2YEsMbytzzJTIgrOzhVVs86oiaACjuhAFUqVh/H12Phu+oPtTzmAspAUXay8GQuNWAAgR6av0qcKBfP8YBRVAXQSKBv6HqndTGSAkyBlyw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:15:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:15:50 +0000
Message-ID: <db93e5db-92f7-445d-b1a7-b2be39a9a059@nutanix.com>
Date: Tue, 14 Apr 2026 16:15:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] monitor: replace 'common' with 'parent' in
 MonitorQMP
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-3-berrange@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260410160458.3778874-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:930:1c::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV0PR02MB11111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce04af9-dbde-4b1e-714d-08de9a38b5de
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: br5yU2gL4V2NrQmRr55PUTQGulPl3GqKpGmatdXpamhYCbvOcQcbJ+LiRyLUHOuerrIeSslSS+Y5yFko9B3KORb/6xuUJfhuFX9qWiUatDmdPUD6EsbeEqXKBp2zHR4nSvQ/FzVmIceBmnxRTD9UYl7YJvqNmVxHsExQWTykO/tj2U+9WKlqJG7OFkYX79u9IKd9/baE23yOCgw9zUlZ0u5UJuFjd8kCiz2IhD8gaw35w2+gcWLBRfKyT2ZhzPNZyjIFLM91GBztJnsKqsUMNiQqTiVNI7Fta5SkwBGbgdJDN2fI4oIUfeNMNqnkvS3wN9vOt8Y8Rcz0hj8J9PIzITMO9H69d/CaKYa6JH1wyGvSWRy9rUi4AK/rHqKbVZWSG6mJZgRs4bkFvy8Ioj2/ysnyJcN5MLdnOKZAW+vV/U0b54UZ1lWC5XYQVaApcy+5ZNj7GFCbTl+CdQdA6WWmz185Sbu9+h2SLap7A7VbPC7toU1uhHGvRQFBoKPzy+d7NRSMEmVGOFxT/jEhIORs2//vIFTxEv6W+yqDAcHleZywJ7sOpypj1ZNroZ8AobUIzhbRN3wN3aeqv0SN9YcgRZaIdJ7zeN0e9Qh/9a1zXgDb1Tx7FzsTCJKy/4h4ZjpDKWZpx4MXtyNbItkLLSaYd857NK0Mcki7GuaE9gb+pbXVSrOLu66U+R6+iUytffi/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVVnamNZZHJlekJUNnBjSFViVmtXNkdoZ0VTb1JLdjREOEV5YkNYQ0JSb0dH?=
 =?utf-8?B?RTZVYVRQN2ZUWmt5d1d4STE3d1V6U2NVeGRDK1hzcTBmVElSR3dDaW9ZWHJX?=
 =?utf-8?B?M2pCYXZrOElBY0NVK2xHanl3SWlnZEw3WlVpUXVFbTR1UUtZaVdwcUVmeDBk?=
 =?utf-8?B?MXMvazJMQ1VsSC8zS1R2S2dmK3Rua2FXejRwWXlSZGhWUnp4RlVjYmp1Y2lM?=
 =?utf-8?B?Z1d0dU90RkthY0krNkw0TnFKTm9lTjNDaXJUTENDR3FzSFFYNlFDVFpOTFVV?=
 =?utf-8?B?NjN5cmN5ak9lSytWV2c0ODM4MTdqMmt6Z2tzZGNLN0o5RTNLRDVYVGQ2SUlN?=
 =?utf-8?B?ZEo0K3VQT0pBb0g2cGFva2Fpdm9kMG51NitMLzV6dlQ4RURWSHJZYmJ1V3ZV?=
 =?utf-8?B?S1VRVEJieHNuNUdLYXB6YTFlS2lUS1dRL0NtUTc2VmdpdWlobHhQNzBwb3Jk?=
 =?utf-8?B?OEhwSDBxS051Mi85NW9UWVJDdVdyK0FBNGNFZ0pTZmRKODI0QXZyMjZLb0Ni?=
 =?utf-8?B?dlRjMEFNUFBMclBBSmZBVFNFZ1lIRE5BQVFQbzNlYzBxdlptVEV4WlY0Njl1?=
 =?utf-8?B?NHA2R2lTUVg4RU8waEhRcTVIb0hwNDI0ZHdQaXJMZmpnTTUrWGIvVU1zd2Vx?=
 =?utf-8?B?aFVmdnp5bXdZdnZqaWVBK1ZyMkl0Z0Rhd2JWTU5HQVFuemMzZDF2NklkVHhD?=
 =?utf-8?B?M0VPZGRmWWJrYUlmbVBKVU9uaWZta1FUZ0YwQ2EyWVNYQ2N6TzQ1VGxXRkR2?=
 =?utf-8?B?cmUya084bVRDUXExekd6K2dERko2Qm5yMFE1ekxkTVNvYUtTcHRZbTNmcVkw?=
 =?utf-8?B?bXhheEV1Tm9ZSnR5ZzgzWkd6TlFsR3J2UEw2bTVoNU5JK3lBcVREaE85UnV4?=
 =?utf-8?B?RzNESHRSZzhPL0JCWmtDWkJIdzVNT0c2QURxcGFuQk9tSWlncXBNcTkydWpS?=
 =?utf-8?B?WU9FWXJnUHkzNVJKemRBRk0wU1RIdEEzWXZROUJYL2tmYVAxcFVteUNJR1h5?=
 =?utf-8?B?aWFTWHhjb1pqOUtYcDF0N1ZLelpqZG9BQTVNcGgzNTQ1elFlOVRBTGxKUjR4?=
 =?utf-8?B?d0FhRG81dlluSWJnd29qc05TRDBscXRMeWVDbWNjMDZyMXNYeGtHVHNxSzJL?=
 =?utf-8?B?eDhVa2hpelZ6dlpwZGNjeGV6SFFzNzFDc0lKYi83ZzZJOHdGSzVnVm4rM2pP?=
 =?utf-8?B?ZkZIWDkyblFvaUYvdzJvV0FJcnRvOUpSbzZDeGxBUEN1clVIRkNPYkYzdE5m?=
 =?utf-8?B?MFFkV1VVQTdIdUpyWFlRTVcxMzM3UUx0T0ZhOUNpZXdVNzUycGJDRnF4TGxX?=
 =?utf-8?B?Z0FEbm54Y1JNejFFMTRYWnVZQURueWRlUDNScEFaNEdYQWZjSmU2RytSdHdh?=
 =?utf-8?B?OHI0aDc5ZTdnbFA3SENXRUdUbmpCTXJYSGM1N1pBM0ZLUytnRURWclRWb1hU?=
 =?utf-8?B?Yk1VSGc1eTg3cit5LzZPVjI1ZzAwaG5jZW9MZ0NQTE94dlA5cm5NU0NkT0dI?=
 =?utf-8?B?V0pmbHY2amhQZ1gxVDJxOXNXL0hINDQzZXZpVlZwTVRCclNMV0gyVU1oSmdu?=
 =?utf-8?B?cFJiYWNtc0ppMWhXUm5xYmRIWFFTckRoSUVURHJJSVRDMDQ2c2drL2RRWExV?=
 =?utf-8?B?VjZRWFc0WXpldm9IMGN5eXRWZG55ZDVDTitjZnVTdENjY2hvY0ovYTRPTVJx?=
 =?utf-8?B?YW80aGV6Y256aGljTjZoVW9mSFBNaEIxdXIrcG8zUnBSUjU4WjZZWmQvWnU0?=
 =?utf-8?B?aUNJaFIwSG5ZQk9MeG5TZUc3OUZvSVRzQm85eWlDVHY3aTZ2WWFTaVNxUUhJ?=
 =?utf-8?B?b1liR0NhWi9JMHZYRmhhblNhblkxenhnbTUwWlZUSDZkY3JVY2dVdVZ4RDJD?=
 =?utf-8?B?T2NjVkh5NjlPckdoZTFKeUxyb3AzdDViMnMyWi85Y1U0TjNNbUJMNlgySmtN?=
 =?utf-8?B?NHR5Z2cvem5XUjV5SDFoRlc3V0ZoR2xQVmczaktLeWFMak9JK1BneVdXb29O?=
 =?utf-8?B?ZmNqM01LaFVNQnR2ZU1kaWlZV2h3b1dXYkVkRk8wRkZ0c1B1Z1NkRkdwVUNV?=
 =?utf-8?B?ajZCNlkxdVQwSkNDS0FZemRpdTgzK09VM1I5MWJYNXArOTJGTHFoYkN1aEV2?=
 =?utf-8?B?TVdkMzN6RCtlaVdMRmJGVlNRbTNWSEdOSHl3Y1lKb0tZZjZDVG5Wb3UzWUVr?=
 =?utf-8?B?cXVBb3ZKY2xkc2dJbmJ0OXY2WXc3L1pjTHpaU0wrNklicVpWL3g4OTV5Y1VM?=
 =?utf-8?B?SDJrNFJJMWZYam0ramZPSDAxS0FES0UxTm5CalVmUkFlK1VLVGxvQ1Bscm12?=
 =?utf-8?B?UzhqRm8vWURUL2hVTCtaZDVBQzVhcjNYWnNUVGV4U0g5NllqVmhya2kzM3lo?=
 =?utf-8?Q?uAOjN+dnLBP5eqC8=3D?=
X-Exchange-RoutingPolicyChecked: oDXDHQI0HBzu1DX7yYYq26AaQnk1Ah9il9sNFSd/xw4MeuCnsu7+Qvtd1q3Q/Dn4hGg8F8DhhE+hNuhb+ktTgf8ic5ajDc7mpMXIOaP24sJAx4FaxkY60kx48pxjxwXOmYrbGOztlt13r5WXIELdyoyQxqXbr6h9f1ScTdsezdmXortYMOmhULollfrFGYgNwYUKYfQZmKArsw5Q1qiSnd4ldzuwpQmRsUzW0VapBEsty4QMz+Q/HB6FceEfoaPpBukLBD99jIS4l1nX6HzJjyrnNlpO8d5in7RUEFPk3YS1hdHfME2U/Xa47h7ON84CJSvIeONOCBvh2VJ/1hWFUw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce04af9-dbde-4b1e-714d-08de9a38b5de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:15:49.9434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fNjL/c9aItMb5RrBF3q5ojH8Erp3+zPCmGTuxngcYU64TIjbHLLrkvVJ85iTGxfjE/OSKnyUA/CKaYFzwAwqWSIujaHDpNvnyf7gxynii8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Proofpoint-ORIG-GUID: gh0N4U0tvsqbtO46xKR3s63xLvVyHeNn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0MyBTYWx0ZWRfX8E5ZngK2lTLS
 kzTxMxJkj9++/64ktdRSSerRhaJ9yeRKrIr6erjhkVE4ywzyxAwKbzx6qiiQKe0bAdRH2e2PSxo
 DPNGmcw+WURfGehhX/8pZ/6MnlAnhFrTI3Bw6XN9PXg/AJ1JK5oYVCE2oxZ4u+Ns7HgH9aW9RN1
 pyhvoRYZ2KSpz3KnaIKlZPL5YCsxhV4GljmtNkn4ctiMsmhhDRaJruBzxooHekNFJbvDIZvf6eJ
 SYYxoKt/5JSWiD23cVracZqqBlHW8eLVe66zwQyIC0J3h0kq1qSn6+D/GykYMryEto8JZ86Vmys
 3rL+1IGqh1PDtjl4yh8H2NT+hCmlgpEvLZpsr5VzWgpH+GtTcV0r0duh1k/EhHqeHhrZw6rC/W7
 ZwIF/jaj3pMYVWAHhh+rLcQHyeXACEm4p0AYk7JJ7/lukPTMd9Jh+RIgwH4VfDKa7wQ/iG9hCjk
 5sXoJ666FVObHrsvdxA==
X-Authority-Analysis: v=2.4 cv=deCwG3Xe c=1 sm=1 tr=0 ts=69de5a29 cx=c_pps
 a=3l++41Tsbfu3Vy6U+n14cA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=UXIAUNObAAAA:8 a=20KFwNOVAAAA:8 a=p7i_hZ2ym6tkgK26glAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-GUID: gh0N4U0tvsqbtO46xKR3s63xLvVyHeNn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/04/2026 17:04, Daniel P. Berrangé wrote:

> The field name 'parent' is standard practice for QOM structs
> so align the QMP monitor.

This is not correct: the first field of a QOM object struct should be 
called parent_obj, followed by an empty line as per our style guidelines 
at 
https://qemu.readthedocs.io/en/master/devel/style.html#qemu-object-model-declarations.

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   monitor/monitor-internal.h |  2 +-
>   monitor/monitor.c          |  4 ++--
>   monitor/qmp-cmds-control.c |  4 ++--
>   monitor/qmp.c              | 40 +++++++++++++++++++-------------------
>   4 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index ae0cf8c1da..0922588ad9 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -132,7 +132,7 @@ struct MonitorHMP {
>   };
>   
>   typedef struct {
> -    Monitor common;
> +    Monitor parent;
>       JSONMessageParser parser;
>       bool pretty;
>       /*
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 6532796edb..6b183edcf5 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -308,7 +308,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
>               continue;
>           }
>   
> -        qmp_mon = container_of(mon, MonitorQMP, common);
> +        qmp_mon = container_of(mon, MonitorQMP, parent);
>           {
>               QEMU_LOCK_GUARD(&mon->mon_lock);
>               if (qmp_mon->commands == &qmp_cap_negotiation_commands) {
> @@ -625,7 +625,7 @@ void monitor_data_destroy(Monitor *mon)
>       g_free(mon->mon_cpu_path);
>       qemu_chr_fe_deinit(&mon->chr, false);
>       if (monitor_is_qmp(mon)) {
> -        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
> +        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, parent));
>       } else {
>           readline_free(container_of(mon, MonitorHMP, parent)->rs);
>       }
> diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
> index 150ca9f5cb..ca471bc1c7 100644
> --- a/monitor/qmp-cmds-control.c
> +++ b/monitor/qmp-cmds-control.c
> @@ -76,7 +76,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
>       MonitorQMP *mon;
>   
>       assert(monitor_is_qmp(cur_mon));
> -    mon = container_of(cur_mon, MonitorQMP, common);
> +    mon = container_of(cur_mon, MonitorQMP, parent);
>   
>       if (mon->commands == &qmp_commands) {
>           error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> @@ -126,7 +126,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
>       MonitorQMP *mon;
>   
>       assert(monitor_is_qmp(cur_mon));
> -    mon = container_of(cur_mon, MonitorQMP, common);
> +    mon = container_of(cur_mon, MonitorQMP, parent);
>   
>       qmp_for_each_command(mon->commands, query_commands_cb, &list);
>   
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 687019811f..69d9e40e32 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -80,7 +80,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
>   {
>       memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
>       memset(mon->capab, 0, sizeof(mon->capab));
> -    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->common.use_io_thread;
> +    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->parent.use_io_thread;
>   }
>   
>   static void qmp_request_free(QMPRequest *req)
> @@ -124,7 +124,7 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
>            * when we get here while the monitor is suspended.  An
>            * unfortunately timed CHR_EVENT_CLOSED can do the trick.
>            */
> -        monitor_resume(&mon->common);
> +        monitor_resume(&mon->parent);
>       }
>   
>   }
> @@ -139,7 +139,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
>       trace_monitor_qmp_respond(mon, json->str);
>   
>       g_string_append_c(json, '\n');
> -    monitor_puts(&mon->common, json->str);
> +    monitor_puts(&mon->parent, json->str);
>   
>       g_string_free(json, true);
>   }
> @@ -166,7 +166,7 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>       QDict *error;
>   
>       rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
> -                       &mon->common);
> +                       &mon->parent);
>   
>       if (mon->commands == &qmp_cap_negotiation_commands) {
>           error = qdict_get_qdict(rsp, "error");
> @@ -207,7 +207,7 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
>               continue;
>           }
>   
> -        qmp_mon = container_of(mon, MonitorQMP, common);
> +        qmp_mon = container_of(mon, MonitorQMP, parent);
>           qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
>           req_obj = g_queue_pop_head(qmp_mon->qmp_requests);
>           if (req_obj) {
> @@ -302,7 +302,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
>           oob_enabled = qmp_oob_enabled(mon);
>           if (oob_enabled
>               && mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
> -            monitor_resume(&mon->common);
> +            monitor_resume(&mon->parent);
>           }
>   
>           /*
> @@ -343,7 +343,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
>           }
>   
>           if (!oob_enabled) {
> -            monitor_resume(&mon->common);
> +            monitor_resume(&mon->parent);
>           }
>   
>           qmp_request_free(req_obj);
> @@ -408,7 +408,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>            */
>           if (!qmp_oob_enabled(mon) ||
>               mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
> -            monitor_suspend(&mon->common);
> +            monitor_suspend(&mon->parent);
>           }
>   
>           /*
> @@ -462,7 +462,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>   
>       switch (event) {
>       case CHR_EVENT_OPENED:
> -        WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
> +        WITH_QEMU_LOCK_GUARD(&mon->parent.mon_lock) {
>               mon->commands = &qmp_cap_negotiation_commands;
>               monitor_qmp_caps_reset(mon);
>           }
> @@ -504,27 +504,27 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>       MonitorQMP *mon = opaque;
>       GMainContext *context;
>   
> -    assert(mon->common.use_io_thread);
> +    assert(mon->parent.use_io_thread);
>       context = iothread_get_g_main_context(mon_iothread);
>       assert(context);
> -    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
> +    qemu_chr_fe_set_handlers(&mon->parent.chr, monitor_can_read,
>                                monitor_qmp_read, monitor_qmp_event,
> -                             NULL, &mon->common, context, true);
> -    monitor_list_append(&mon->common);
> +                             NULL, &mon->parent, context, true);
> +    monitor_list_append(&mon->parent);
>   }
>   
>   void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>   {
>       MonitorQMP *mon = g_new0(MonitorQMP, 1);
>   
> -    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
> +    if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
>           g_free(mon);
>           return;
>       }
> -    qemu_chr_fe_set_echo(&mon->common.chr, true);
> +    qemu_chr_fe_set_echo(&mon->parent.chr, true);
>   
>       /* Note: we run QMP monitor in I/O thread when @chr supports that */
> -    monitor_data_init(&mon->common, true, false,
> +    monitor_data_init(&mon->parent, true, false,
>                         qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
>   
>       mon->pretty = pretty;
> @@ -533,7 +533,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>       mon->qmp_requests = g_queue_new();
>   
>       json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
> -    if (mon->common.use_io_thread) {
> +    if (mon->parent.use_io_thread) {
>           /*
>            * Make sure the old iowatch is gone.  It's possible when
>            * e.g. the chardev is in client mode, with wait=on.
> @@ -553,9 +553,9 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>                                   monitor_qmp_setup_handlers_bh, mon);
>           /* The bottom half will add @mon to @mon_list */
>       } else {
> -        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
> +        qemu_chr_fe_set_handlers(&mon->parent.chr, monitor_can_read,
>                                    monitor_qmp_read, monitor_qmp_event,
> -                                 NULL, &mon->common, NULL, true);
> -        monitor_list_append(&mon->common);
> +                                 NULL, &mon->parent, NULL, true);
> +        monitor_list_append(&mon->parent);
>       }
>   }


ATB,

Mark.


