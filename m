Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EA0D43343
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 20:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTnWj-0008H1-9N; Thu, 11 Dec 2025 15:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vTnWg-0008GW-Rw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:44:39 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vTnWe-00014I-Cr
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:44:38 -0500
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
 by m0050102.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5BBIjIBV377053; Thu, 11 Dec 2025 20:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=BqZXM27XwOWIfqZRVs8sZq88Sn6D63Jp0avGbTml9tI=; b=
 laBYXP83cefgXx6OQRUs/lM8twYCDkKZVBIX6NMkI3eEP2/pqJMwACoE9/PFgcUH
 J9CCIG+0XP48tgfxbfscH6rfVaM+CfTO8OMGWCr9eS0S69jb2tk8yQ23vf5G6jpr
 twHbhYtRCRYe4nzYT6Fmq3Cgzm/zGLEvP9wnz0UTsAUczMSJCzZswxj1aaCC6luA
 MTnP7/quRPV8azSKw1ymzB5M3NjyOmiYHYMAn0I7QwMRTi6DsAK5cwFsALnHyl72
 uh1RQuTxSBovFqvxP8+RY9uhsU1RsOPiBGu1VDPjPir9W4031O8kUJr64740wn3Y
 wr2HfoZNwrs4DiOW9MBOzg==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
 by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 4ayq1mjguv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 20:44:33 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5BBJ78NK006658; Thu, 11 Dec 2025 15:44:32 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.40])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 4avgq1eaxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 15:44:32 -0500
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 12:44:31 -0800
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 11 Dec 2025 15:44:31 -0500
Received: from SN1PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft
 SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 11 Dec 2025 15:44:31 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by PH8PR17MB6888.namprd17.prod.outlook.com (2603:10b6:510:257::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 20:44:29 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 20:44:27 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>
CC: "berrange@redhat.com" <berrange@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "armbru@redhat.com" <armbru@redhat.com>,
 "mark.kanda@oracle.com" <mark.kanda@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hudson, Nick" <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Thread-Topic: [PATCH] migration: cpr socket permissions fix
Thread-Index: AQHcWk+Ww41l0upbvEuzSutbKZyWdrT9TVYAgBRdCACAAZRjgIAEq6SAgAHbjgCAAs1MAIAAXG8A///FwoA=
Date: Thu, 11 Dec 2025 20:44:27 +0000
Message-ID: <C8ABA8F2-C459-4911-8DAA-C5FC6489EEB2@akamai.com>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local> <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
 <aTL2j7PB4--w68ir@x1.local> <85437E51-DEC6-4B79-8E5E-93B5D64D4CB2@akamai.com>
 <aThwdthSF30NygY4@x1.local> <3DC0D610-FDC3-47CC-83F0-BC9CD470E972@akamai.com>
 <aTsXtmUVP1TfRZaS@x1.local>
In-Reply-To: <aTsXtmUVP1TfRZaS@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|PH8PR17MB6888:EE_
x-ms-office365-filtering-correlation-id: 847f0c26-38c3-4511-2b43-08de38f613a2
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?a3dSRElNYUVvQldtQlIvcTQrVGZ0cDVXTGdvWmx5Ynp1MkJFZThEYTdCYWNT?=
 =?utf-8?B?NnloS2x2ek5PK205c25BN1ZzK0NDdStnKy94UFpkRHA5ZzJiU3JwWFhYQXdX?=
 =?utf-8?B?R1RIZFlXbnN1VEQ1TUtoclpWTWZ0Q0VCUTFJcTd4YkxmbWJ6aTlxalppN0l1?=
 =?utf-8?B?cVdGckVJRjVZMmxkZTJYRVNRTHZVRmNxQ0xMNUh0QmJCYTJQbXllOFVianVV?=
 =?utf-8?B?U0xyZEJtRHptOXgzYVo2YXNJejJReVhIcEtKSWRtekkxVXFSc1Z4dUVRWGU0?=
 =?utf-8?B?dUkxd3NoaDB4ZWVjNENWZzNCeFhnNVh2WWp1WDd6bjlJMHNOMUNsUHhVdGlG?=
 =?utf-8?B?a3JoL1BHZkI5cUdMaUxsbDV2Q1N5SnNHRTlXOTNNK1REZ0l4ckNNV29UOG5q?=
 =?utf-8?B?M0hEd1ZXUEdWNGY1c2NRVExQTTNneSs2KzhUeXh4UFFHM1E3RkwwbXFubEZE?=
 =?utf-8?B?M3Zsc2wzeHM1WStoWWhOd0NOYnYxSDIweGkrOTFHYlJiWW0yR3NtY0V5ZlJ5?=
 =?utf-8?B?a0phMkpBTG1HdTEzVEt3YkFMVU85dCtmYTVJZWc4Z2xXQzBpeHpzeVVRWE94?=
 =?utf-8?B?ZGQxcUcwU0lOWjYyMk9LOE9sZWpnajJ3dDBCbmt3NkNVSHkrNW4vK0ZDM2lV?=
 =?utf-8?B?VWNpVTRva0lVSmRvZkFaV1lGRTJhMGVXdHdzOWh2Sk8rSFlKbm5FZGxtR0ZF?=
 =?utf-8?B?aG9Vb0t1MEFkUzlMTEVtRnREbXRDWk9vcU04VUdNTGxaeGlvVjhYbHVqU3lk?=
 =?utf-8?B?WWhOWjc4eEp1UWs1VWRsbEN1SU4zckZRNklYWHpETXNaVGIvN1g4TUZ5cFpK?=
 =?utf-8?B?MDhxbFdBeEFzbXJPdWJyLzIwakZNT0RWNXZwZWRZVUFONm1pUER6dUtYeEpp?=
 =?utf-8?B?UlRHL2tCenBoVlpWd0h3c1B1THZEWnlqQ1BiQkNNWmh6TWtMZ0MrL1RoMU51?=
 =?utf-8?B?cEJsbGhwRnlGRkpYVHd3M0x3UG1RRllkSkdFSnhkdjJmNjNNQms1M0w5ZkFq?=
 =?utf-8?B?OUJxVTZYa3R3Tjc4MTJySU5acmNERUI2VW1QTXNFb3V5MENTUlZkLzcxVFQ3?=
 =?utf-8?B?Qk85WGtRMC83dCtlMTBiV0xlbXZPRVYxVThleURvNUUrNWcwOVRza0Jta2V5?=
 =?utf-8?B?ekRLU0dxN2lTSlhOVkNGanVtdHNyMEhDeDJOS25NTVhINzlZWHo5L3lVcHBB?=
 =?utf-8?B?WXExckVJbU1kZW52V3Y0T21mR3dUdDZzRDJXSDlHYWREaExUSHJONVQ1NTFX?=
 =?utf-8?B?NFBLSFE0dXpLZHl6MXZPdkJidXlyU2ZqbHF0eTcyQWxsQUZ4L055cFFNemxG?=
 =?utf-8?B?bXprM3FxZy94TGNlQTltTHlzejNHZzRhdzg1eUpFOW9IcDM3VENWLzJrSTFh?=
 =?utf-8?B?NEdjSmZhNS85dVZwTXlkQUFFUThZNWs2dUJOMklZbFEwVXZObjhMSjc3cmx4?=
 =?utf-8?B?ZmVtVm9FSGs5UEgvQmtab0Y1elNiWURjUUVxVGM2N281cHJrcC9ZblJ5R0sy?=
 =?utf-8?B?RGNhZm9XQmo1cVEwVUM1NjFQS3Q1UnY4NGRkbi9iVEFidFBsUEtLdkp3ZWhq?=
 =?utf-8?B?WTNlSTJLckRoaHU2cmpEdzFaSTlONkViYnlDTHdTQWNJY29lRFhIVXhCdThs?=
 =?utf-8?B?b2RxRC9tWTdVK0Vmb0pXZW5vcFJFdit5U1dYT2d2a0w3Ulp6Z3ZzZThjR2tk?=
 =?utf-8?B?M2FYTVR5T2VkNVNqN3pnRUUwU08wZkhtVkNjTXFSdW9Wbm9VVVZyS3NVS05v?=
 =?utf-8?B?VWcxNzJqWlNlbStQWmtOdTdhQSsyWFE1ZjhjaHU4eGlqY1hFbkZ5YVEwclRH?=
 =?utf-8?B?eHVEVStheDZvS3NndDg2MWhadkpYN0JtVkhtZnR3OTV3ek1ZS2EyOGVkaHBX?=
 =?utf-8?B?bmpxL3Nta2NiVkZaakdSQ0NoWDR6TFRsOC9mbE5YbDZ2eUUwdlJ0TExIS2Zz?=
 =?utf-8?B?ODU5UU96a2lVVm9FS1c3N2tpQUsxcGhiSVFsaG02OXpGNmNOcEtRMWMzbWZN?=
 =?utf-8?B?OEEvUFZGMENwSzFyK3VpRFllUUU4c0JWNU42RWtkVUVSRitxZDFoMlJiRitG?=
 =?utf-8?Q?FMIK3a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2RocnhsUWg3SE5YVTE1U3NsNE4raUl3TUZDN1VOdTM3UUo3QTBhTXNaL08z?=
 =?utf-8?B?c0tqaTRYZFRidWRDQXJvdG53MFVVMmdTTTBKQyszcVF3Mzg3OWtZWEhTNzZZ?=
 =?utf-8?B?MHJ5WUsyajBUaDVadkR5ekVTWHlSQnB2N2RmM3RjcG1xbTBmcGdyZTRVYXFo?=
 =?utf-8?B?b05PQTg1Vm15dGZDNVNMVVRIZEtrUGR5Myt6eE9BYkluY3U2YlR6TjhLY3NO?=
 =?utf-8?B?SWJYazlyek1oZVhyVG83ZEVlN0wxa0xIblYya1VFa3YzR04xdjdwSTdIdlpp?=
 =?utf-8?B?UWEyS0p1Yi8rcFM2NnhpaDBLOEo4RHpGZnlJc0ZESU1vdElJTVJ3VTkyeTZT?=
 =?utf-8?B?STJGa3FscnFOQVRkbGlKaURPdm5lRDdlSGNNaDcwenZtYllhdUlrdk1US2RI?=
 =?utf-8?B?S1RhRkVzTmRqKzZTemFuRFZFcjZiTExrZTJOYUY5S3VoRytIRTdSTnMyaXB5?=
 =?utf-8?B?ZzVFYk1DaEZYOEtXRDJrUy83ay9Na3hqaloxb3dWZ0RpaEkvZi95bDFuZmVl?=
 =?utf-8?B?TG9XNHBwMWJyWlhTdno4UDJNR01XR2JmOFp0VnJrdjBBeXFrS0xhOGpYNFls?=
 =?utf-8?B?OExOUDZNbmltYnFzcTdxdEx6N2J6eXVDRjlaVlRPN3kvOUEyanJrQlMvVGI5?=
 =?utf-8?B?SC9SOG51TDJGZTZwcnhDQmR6Q0plaStKbloxQUFkeS9nUkhlNzB6QVlyVVky?=
 =?utf-8?B?Sjk5aFJpRXd1RnBad29YQVdyWTIrc29QWWppRkVqNlZDMVRPbm1Tc21hZEsx?=
 =?utf-8?B?eEFwQ2x2ZWVWRTFRbk5iRVYxVzY2NHllVjFFekhFMHlWOXBPbG8wOWRab3RD?=
 =?utf-8?B?MjJPQjlQUDBEY2R1dzhXQ2tHQUpxb0FQL0IwbkYrbExQSnRKZkFicThGU3ZX?=
 =?utf-8?B?RXF2TjlzeC9Kc09heHZHMm8ySGFmcUthL0tIK1lHN3VXL2Jsa1hvZDRMOWs2?=
 =?utf-8?B?dXFORm1pcDZsRklPUXc0cmdudEZzSElmd3Fha3pTZnZ1dEtKaWI5c0Iva210?=
 =?utf-8?B?WlNUODhWM3FBdXM0djlvOENzSFIxUkhvelJLUlFIazUrTjZqYkFteEFNS09q?=
 =?utf-8?B?NTFFN3JnaDdDb2gzb0I0aThPMEplN1l2N3R3dzZwQ0xaWFd6bnBmR3J5eGM3?=
 =?utf-8?B?M0ZUcWlvNkZFZzZCcnQ0Um9US2ZtMHRVMlpYWGxDamJ3MUtDWHl4OW5CejN6?=
 =?utf-8?B?SmxrR3BzUlJ4bjNCcjdGVktZMzZpdHNaNEJPOWxTSFRzT01PZWNkR0pUcGVw?=
 =?utf-8?B?bVNQTnVEUXF0Ty9kbUpISmN3bG13YlJDZm4zdU5YM2lvbkh6V3N6YWFwK3Rk?=
 =?utf-8?B?UW4yd2xQK3djQjVDQzIxQUluSFdkUVdubElZRysxSGdMcXNpdVhIYnlhZjFu?=
 =?utf-8?B?R2VvTjN0bEJJKzRUWmZUSjVmS094WEZkVG90S0x6MWlkc0tFbXFmWWhJNzVi?=
 =?utf-8?B?eDA3amdmcTJTRE9IVk1IOXNuTDJvcXhqenNUVEQyYVNHTWEzTkJJSjdtK2xz?=
 =?utf-8?B?b2NFdVYzK2p2dVZTby9ncTFrK3pCUGFQYXp5a3F2MjZpNjk5MWJGN0ZrbDMy?=
 =?utf-8?B?NGVFS3Fsc284TWR4RjFBSktTTUZ1VzZyaDY3YTljYXc4c21UR1dPeWpWT0dx?=
 =?utf-8?B?U1MwYWp4QmJaMjA1Z2wrZU9lN2EwK3huUnAwa1ZSUUwyV1B2NzdUNTZLUmx6?=
 =?utf-8?B?QVFUbElNbk0xbjh5bS9Zbm9sUDZOeHJYRkJVeEZjcG50NWVpWWNtdUk4ZXBJ?=
 =?utf-8?B?TWVWbkk1dDM1eW5yWUl6WGVjWmpCRG5BVndFZXJrM3paZmpFbTg0YmRPMTho?=
 =?utf-8?B?WDlRNEJiVlNCZ2NWRTQ0UlFCVVJIaEQwcTVkakdzWjRBU1pJK0NzcXFuUWVE?=
 =?utf-8?B?YXc2NGJEaDhTbWxUTGlGNERuQzkvNUxmYTUwRHUyMjVIaWRvVDdnOVIwUE5y?=
 =?utf-8?B?L1JoVGMwakFJRG11R2NlQS9QOWE3NmxaUG1mTGZGT1VsTStoaEF3NHhoVldz?=
 =?utf-8?B?R1crZjZVSS8wd0J0OVFlbVEwZlZKNlI1dE9kZXhicGlmS2pYQS9BQTl5Vmd2?=
 =?utf-8?B?SHErdDkzUEx5dE5od2VjTXJjZHY5ZDN1bW5yWWhybXkxSDkzV0lWT0phemQv?=
 =?utf-8?Q?xpj5po6rY6qJPAZomuTEUGc8G?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1GqyeT4I8zmvn3BgbFbyzK5e/zFZLzKaMyVdv1UY5gC0/eJm3e2Dv8nz00DQPzqpHWTAPW2Ngv78noo38T5NLrLUnzwKZ5hMZhd35DbV/3OR3vBE1haFe7odqvrqwL7E8BAAMXqiBXAF6jyyoC8I29fm4Z0ZtqbYtsBFuViLXFq+Z1dV0p8kP35r+DLqE0HWLrru4SNOUwzJQDKkWw+G3sNV+Kl8m8DsxHiULVF4LpEd6ykG7HFWVn//RRXkM2xZgf7y5QyJceyo/qaigpMKD/m3HXQItoXa7YxN5ntoS3QGoSHKcz1k6+Z/kli3uIChaUGmEjdswe+PCTtzib7hA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5LmIsxB4I6xrdYXJTRFd7YbPYn3KcPnOV+6+7aTmSM=;
 b=Lcq8bRGyvie1W4acA4H4iklDFRjR7BxEIu3KLbXSTe0IGok5FKnKJegIa9upP5kyYxv2ZCwy8BieKwzSwDhXHJ9PQjyfzGgKH1VPhwsu5a6WZGDIQsAPubbAF5RubfPFp47umQKUEEmkEUDqYkZ1XEwRv6M+FyKPNSRjdTt1qG+zWiJD+5dLCTqHvxLb6awqn4ebm+HdaxcmuDPPAoF1RIb/ur30hvtd9wzhU87WUn/I0XFpYFVUPAEnHEfvRvmHUQeIHy74CyFAxp5R/o1xXnREjOAYwHyFa0Eyb9SBXDGmgDV+yeU6505F9erlxJi35FHKLHeGluKSdfDc+uDppQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5LmIsxB4I6xrdYXJTRFd7YbPYn3KcPnOV+6+7aTmSM=;
 b=em8MYMdHqLKrKhl56ijVdlJqodJtYFC6kphIxhMvukfmMLo8Hmh2zYVK1GqHHdVTvVRQTGtTY76QZwQsgaqKDCZ/uzoo9vUtEOHvc8smTlO48MPFitcvSVj9oYZiCOnyB8c4r83Njc7961E1SAPy8VkB7Vpp9nEr3N7V8gY8Ql4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 847f0c26-38c3-4511-2b43-08de38f613a2
x-ms-exchange-crosstenant-originalarrivaltime: 11 Dec 2025 20:44:27.5634 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: H8OrYnf92wvwcn3JAd5M2jPCC3I4k6wgNIrufS6UWXJyfbNzi+rXUMKbCwgI2ifxebzIB5UX6hWz9VLevg8tRA==
x-ms-exchange-transport-crosstenantheadersstamped: PH8PR17MB6888
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BA28A115F7CE1409226E4194A5EF4C3@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDE2NiBTYWx0ZWRfX9zX2WjbZcGJG
 6iPs2QcAlmchpVlwrLCM0wxGW3rTYD7QY/40qNLzJwH7wyng/CHWQpat8LTuQ4qd6+/PkzoCa/M
 WU86IAxZaRKe2op+SZovHFZ4YeY8WoGsyTxV3SmU9EhVDBc5ZkdR79JDoBfcXcUXHT+pQkOSnwT
 +m/h0gA4RtGOhUXLEoEwflP+WneyepVz+JA78PeqLwL4nPGLnqfbGy/I7MwI/j5AqsfSIBWKZKu
 8c2Xqm4N9gHsFwFnx2+F4N3FNjeFClHv4MnyQzXMEDj9C/vTkCaEP7KFDjSyAxCQta4WFKxI8NO
 Sef8C6SZkDP4cfPbd6jatZ2W0TTy2cmX5Qb6PKy5il0oRSYKtQuy7LbcAwGZwIKD4gwreT58Jv2
 VAzdm1FAAeBQ3sja9Zi+rSH78mTw0Q==
X-Proofpoint-ORIG-GUID: E0uxjkuYMF-SMyARAqz2ZNwWZSOnjiPS
X-Authority-Analysis: v=2.4 cv=ArPjHe9P c=1 sm=1 tr=0 ts=693b2d31 cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=jzTnmWxQxNNee32x-4kA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: E0uxjkuYMF-SMyARAqz2ZNwWZSOnjiPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110166
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCu+7vz4gT24gMTIvMTEvMjUsIDI6MTMgUE0sICJQZXRlciBYdSIgPHBldGVyeEByZWRoYXQu
Y29tIDxtYWlsdG86cGV0ZXJ4QHJlZGhhdC5jb20+PiB3cm90ZToNCg0KPiBPbiBUaHUsIERlYyAx
MSwgMjAyNSBhdCAwNjo0MjowNVBNICswMDAwLCBDaGFuZXksIEJlbiB3cm90ZToNCj4gPg0KPiA+
DQo+ID4gT24gMTIvOS8yNSwgMTo1NSBQTSwgIlBldGVyIFh1IiA8cGV0ZXJ4QHJlZGhhdC5jb20g
PG1haWx0bzpwZXRlcnhAcmVkaGF0LmNvbT4gPG1haWx0bzpwZXRlcnhAcmVkaGF0LmNvbSA8bWFp
bHRvOnBldGVyeEByZWRoYXQuY29tPj4+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgRGVj
IDA4LCAyMDI1IGF0IDA3OjMyOjQxUE0gKzAwMDAsIENoYW5leSwgQmVuIHdyb3RlOg0KPiA+ID4N
Cj4gPiA+ID4gT24gMTIvNS8yNSwgMTA6MTMgQU0sICJQZXRlciBYdSIgPHBldGVyeEByZWRoYXQu
Y29tIDxtYWlsdG86cGV0ZXJ4QHJlZGhhdC5jb20+IDxtYWlsdG86cGV0ZXJ4QHJlZGhhdC5jb20g
PG1haWx0bzpwZXRlcnhAcmVkaGF0LmNvbT4+IDxtYWlsdG86cGV0ZXJ4QHJlZGhhdC5jb20gPG1h
aWx0bzpwZXRlcnhAcmVkaGF0LmNvbT4gPG1haWx0bzpwZXRlcnhAcmVkaGF0LmNvbSA8bWFpbHRv
OnBldGVyeEByZWRoYXQuY29tPj4+PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4g
PiBNYXliZSB5b3UgY2FuIHN0aWNrIHdpdGggLWluY29taW5nIGRlZmVyLCB0aGVuIGl0J2xsIGJl
IGFmdGVyIHN0ZXAgWzNdLA0KPiA+ID4gPiA+IHdoaWNoIHdpbGwgaW5oZXJpdCB0aGUgbW9kaWZp
ZWQgdWlkLCBhbmQgbWdtdCBkb2Vzbid0IG5lZWQgdG8gYm90aGVyDQo+ID4gPiA+ID4gbW9uaXRv
cmluZy4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0cmllZCB0aGlzIGFwcHJvYWNoLCBidXQgSXQgZG9l
c24ndCBsb29rIGxpa2UgaXQgaXMgcG9zc2libGUgdG8gY3JlYXRlIHRoZQ0KPiA+ID4gPiBjcHJz
b2NrZXQgbGF0ZXIgd2l0aCAtaW5jb21pbmcgZGVmZXIuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IFlv
dSdsbCBzdGlsbCBuZWVkIHRvIGNobW9kIGZvciB0aGUgY3ByIHNvY2tldC4gImRlZmVyIiB3aWxs
IHN0aWxsIGhlbHAgdGhlDQo+ID4gPiBtYWluIGNoYW5uZWwgdG8gYmUgY3JlYXRlZCB3aXRoIHRo
ZSB1aWQgcHJvdmlkZWQuDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBwb2ludGVycy4gSSB3YXMg
YWJsZSB0byBnZXQgdGhlIGluY29taW5nIGRlZmVyIG1ldGhvZA0KPiA+IHdvcmtpbmcsIGJ1dCBp
dCBoYXMgbXVjaCB3b3JzZSBwZXJmb3JtYW5jZSB0aGFuIHRoZSBvdGhlciBtZXRob2QuDQo+ID4N
Cj4gPiBXb3VsZCB5b3UgYmUgb3BlbiB0byBhIHNvbHV0aW9uIHdoZXJlIHdlIGNob3duIG9ubHkg
dGhlIG1pZ3JhdGlvbg0KPiA+IHNvY2tldHMsIG9yIHdvdWxkIHRoYXQgcnVuIGludG8gc2ltaWxh
ciBjb25jZXJucz8NCj4NCj4NCj4gV2UgY2FuIGV2YWx1YXRlLCBidXQgYmVmb3JlIHRoYXQsIGNv
dWxkIHlvdSBleHBsYWluIHlvdXIgY3VycmVudCBzb2x1dGlvbg0KPiBmaXJzdD8NCj4NCj4NCj4g
QW5kLCB3aGF0IGlzIHRoZSBwZXJmb3JtYW5jZSB5b3UgbWVudGlvbmVkIGhlcmUgdGhhdCBpcyB3
b3JzZT8NCj4NCj4NCj4gSSBhdCBsZWFzdCBkaWRuJ3QgZXhwZWN0IGl0IHRvIGJlIGRvd250aW1l
LCBiZWNhdXNlIElJVUMgd2hhdCB5b3VyIG1nbXQNCj4gbmVlZHMgdG8gZG8gaXMgdG8gY2htb2Qg
b24gdGhlIGNwciBjaGFubmVsIGZpcnN0IChkdXJpbmcgd2hpY2ggbWlncmF0aW9uDQo+IGhhc24n
dCBzdGFydGVkKSwgdGhlbiBjaG1vZCBvbmNlIG1vcmUgb24gdGhlIG1haW4gY2hhbm5lbCBhZnRl
ciBDUFIgY2hhbm5lbA0KPiBtaWdyYXRlZCBhbmQgYmVmb3JlIG1haW4gY2hhbm5lbCBtaWdyYXRp
b24gaGFwcGVucyAoZHVyaW5nIHdoaWNoIFZNIHNob3VsZA0KPiBiZSBydW5uaW5nIG9uIHNyYyks
IGhlbmNlIGl0IHNob3VsZCBoYXZlIG5vdGhpbmcgdG8gZG8gd2l0aCBkb3dudGltZS4NCg0KSSB3
b3VsZG4ndCBoYXZlIGV4cGVjdGVkIHRoaXMgdG8gYWZmZWN0IGRvd250aW1lIGVpdGhlciwgYnV0
IGl0IGRvZXMgaW5jcmVhc2UgdGhlDQpkb3dudGltZSBieSBhYm91dCAzLjUgc2Vjb25kcyAoNzAw
LTgwMG1zIHRvIGp1c3Qgb3ZlciA0cykuIEkgYW0gdXNpbmcgdGhlDQpmb2xsb3dpbmcgc2V0dXAg
dG8gZGVmZXIgdGhlIGNyZWF0aW9uIG9mIHRoZSBtYWluIHNvY2tldDoNCg0KcWVtdS1zeXN0ZW0t
eDg2XzY0IC4uLiAtaW5jb21pbmcgZGVmZXIgLWluY29taW5nIFwNCid7ImNoYW5uZWwtdHlwZSI6
ICJjcHIiLCAiYWRkciI6IHsgInRyYW5zcG9ydCI6ICJzb2NrZXQiLCAidHlwZSI6ICJ1bml4Iiwg
InBhdGgiOiAiY3ByLnNvY2sifX0nDQoNCmNob3duICRVSUQ6JEdJRCBjcHIuc29jaw0KDQogICAg
ICAgIGVjaG8gJ3siZXhlY3V0ZSI6InFtcF9jYXBhYmlsaXRpZXMifQ0KeyJleGVjdXRlIjogInF1
ZXJ5LXN0YXR1cyJ9DQp7ImV4ZWN1dGUiOiJtaWdyYXRlLXNldC1wYXJhbWV0ZXJzIiwNCiAgICJh
cmd1bWVudHMiOnsibW9kZSI6ImNwci10cmFuc2ZlciJ9fQ0KeyJleGVjdXRlIjogIm1pZ3JhdGUi
LCAiYXJndW1lbnRzIjogeyAiY2hhbm5lbHMiOiBbDQogICAgeyJjaGFubmVsLXR5cGUiOiAibWFp
biIsICJhZGRyIjogeyAidHJhbnNwb3J0IjogInNvY2tldCIsICJ0eXBlIjogInVuaXgiLA0KICAg
ICAgICAgICAgICAgInBhdGgiOiAibWFpbi5zb2NrIn19LA0KeyJjaGFubmVsLXR5cGUiOiAiY3By
IiwNCiAgICAgImFkZHIiOiB7ICJ0cmFuc3BvcnQiOiAic29ja2V0IiwgInR5cGUiOiAidW5peCIs
DQogICAgICAgICAgICAgICAicGF0aCI6ICJjcHIuc29jayJ9fV19fQ0KDQp7ImV4ZWN1dGUiOiAi
cXVlcnktc3RhdHVzIn0NCg0KeyJleGVjdXRlIjogInF1ZXJ5LW1pZ3JhdGUifQ0KJyB8ICRTU0hf
Q09NTUFORCBzb2NhdCBTVERJTyB1bml4LWNvbm5lY3Q6cWVtdV9zcmMubW9uaXRvcg0KDQplY2hv
ICd7ImV4ZWN1dGUiOiJxbXBfY2FwYWJpbGl0aWVzIn0NCnsiZXhlY3V0ZSI6ICJtaWdyYXRlLWlu
Y29taW5nIiwgImFyZ3VtZW50cyI6IHsgImNoYW5uZWxzIjogWw0KICAgIHsiY2hhbm5lbC10eXBl
IjogIm1haW4iLCAiYWRkciI6IHsgInRyYW5zcG9ydCI6ICJzb2NrZXQiLCAidHlwZSI6ICJ1bml4
IiwNCiAgICAgICAgICAgICAgICJwYXRoIjogIm1haW4uc29jayJ9fV19fQ0KeyJleGVjdXRlIjog
InF1ZXJ5LXN0YXR1cyJ9DQp7ImV4ZWN1dGUiOiAicXVlcnktbWlncmF0ZSJ9DQonIHwgJFNTSF9D
T01NQU5EIHNvY2F0IFNURElPIHVuaXgtY29ubmVjdDpxZW11X2RzdC5tb25pdG9yDQoNClRoZSBt
aWdyYXRpb24gZmluaXNoZXMgYXMgc29vbiBhcyB0aGUgbWlncmF0ZS1pbmNvbWluZyBjb21tYW5k
IGlzIGlzc3VlZC4NClRoZXJlIGlzIG5vIG9wcG9ydHVuaXR5IHRvIGNob3duIHRoZSBtYWluIHNv
Y2tldCwgYnV0IGJlY2F1c2UgaXQgaXMgYmVpbmcNCmhvdCBwbHVnZ2VkIGl0IGdldHMgY3JlYXRl
ZCB3aXRoIHRoZSBhcHByb3ByaWF0ZSBwZXJtaXNzaW9ucy4NCg0KSSBzaG91bGQgYWxzbyBub3Rl
IHRoYXQgSSBhbSB0ZXN0aW5nIHRoaXMgaW4gY29tYmluYXRpb24gd2l0aCB0aGUgcGF0Y2ggc2V0
IGZvcg0KIGNwciB0cmFuc2ZlciBmb3IgdGFwIGRldmljZXMsIHdoaWNoIG1ha2VzIHRoZSBpc3N1
ZSBtb3JlIHByb25vdW5jZWQgaW4gdGVybXMNCm9mIG5ldHdvcmsgaW50ZXJydXB0aW9uLCBob3dl
dmVyIHRoZSByZXBvcnRlZCBkb3dudGltZSBpbmNyZWFzZXMgYnkgMy41cw0KcmVnYXJkbGVzcyBv
ZiBpZiB0aGF0IHBhdGNoIHNldCBpcyBhcHBsaWVkIG9yIG5vdC4NCg0KDQoNCg0KDQoNCg==

