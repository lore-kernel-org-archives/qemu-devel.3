Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8CDF5580E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEmEw-0006ww-4K; Mon, 20 Apr 2026 06:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wEmEm-0006wN-UV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:52:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wEmEl-0002sz-31
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:52:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KAg3631074774; Mon, 20 Apr 2026 03:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZRaQFpCNMbtKxVLr4Ze3UYFAT6Iwj/Q9jFcpBD8v2
 0M=; b=bMqCzXrcdTvXwBgumeffqpP+Hv8GMCN3FjCcvlGq24h/z/uWYyU8PTD+2
 C0rytOXhAIETs25/tIoMhxZYQIUXLB2XHTF3b27DEpVeSEIoslt8GijtSmPfeX2/
 mKsIl21tgaduQOqmpjuW0PfDj4YxM7O+PAZUM7LIT5uYosCrn6EowB939Rjlocn7
 WOq7ZhvvZoacXgbxFaXguq3buiewPZAP+YfTfwRv/GdRMHwLQOgcvkoNt/1RM6Qb
 Jq5ntYWf4dGbQPGttRTFK/jgUN5KjmjE1bmQ1Kl0vsG8HEoxAEKf2tz1O85eC4IU
 kwg/i3Qny5l5j2q1fFRbivERij9zA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020089.outbound.protection.outlook.com [52.101.46.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dm5v2u0gg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 03:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CShCW7AZwXuarKrNC4DIzSEnW2pcf3qWepxi5YhS8HBWnUdhqptwj+vZtJlUNSj3ygnL9pcg+wVGD6JxPpziGmhzYe0tTo5uRqjpzb1DEmm+4yHc48GjxJ/XpPusnzrXqiRuBrAlIJjsGZ8ZGmrDMT/KtrDcmePCFOf+Q7UcyOZFyDa/4I1zq+WzSx6rAmSkuEoaDHrZxkN9du6ELBwJ81BHFMMEUcTCnAHsuYD+3kzb/vZjcJ7jT9niJDUuR9gqs5bzoVZYsEH88g+YKHqbZCe4H6okaXZ7oMXAAnE434eG0ggl8XF6SFUhAtXizxh6a7tqmDi0PUTif/AtnGgf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRaQFpCNMbtKxVLr4Ze3UYFAT6Iwj/Q9jFcpBD8v20M=;
 b=pkhtXlqyCbHaDT6zF+Eo8agFoldEnmiF58RERoamT+tq8WIUDNcfkS+smk5IFDWLdWA+lM5hdNtiPIswTOtTmpeBqZbdLUrQctg7YuFmkQwNiJmbMqLXwvPz3eJBPIz6QXJnm5sqFgqulZtDQ35DFzDhfmkMB4WrZHbvYp+n/SksiGWSIQ1XMyVqNH2127eaFYeiYGB8KhDQZiBAjWsr6hEMO7sOp0oKb97xumtSCqpWzzrOCpm/P+TBik2ljj284I0P19vK15vIJ2KiqE6XUWjAlbWfojzF0NOnzrh0nmHc3I8PUaLQK13YPQTflmy21SSvck8c3MgxzwbHimX+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRaQFpCNMbtKxVLr4Ze3UYFAT6Iwj/Q9jFcpBD8v20M=;
 b=n90+53ygnY5HvZZ5pvyvTaf+tq3nsA8/xQWn+Gzbme1lO7VrBeeM6OAj0SD0+VsrwYXf0NHSCY+cEwmqu56GqI61cLc7PgukAjc4uosbDyIFajB/sPXIRNKPmNNVVCs3OuekwtWGJlLtrmdYP2LgViW5B+TuH7hRdW3QvYIl75Ja+HVbxiMQn2WZbxe1GMKUCqmMaCEHDWl0ldOssDUsSE+zXAh6/CcCdH1rwknUMn+UIdQzluZWWgSkWoHD6I2bpIACfj30X4WJKGiXogYGLGxE4H4b8IGrnd0gVaUC3pX6Oy1lWiNTM7CubiNXgS1Tcj9zZdalTnoBqcG1Gk6eiw==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by DM6PR02MB6493.namprd02.prod.outlook.com (2603:10b6:5:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 10:52:14 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%6]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 10:52:02 +0000
Message-ID: <0ec397c4-5ec9-46c5-a081-a6b380320755@nutanix.com>
Date: Mon, 20 Apr 2026 11:51:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Content-Language: en-GB
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
 <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
 <CABgObfYYt0CuLzj4kdD13J3+bUqAxNpmKTc4g=LtbojvKAatyQ@mail.gmail.com>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <CABgObfYYt0CuLzj4kdD13J3+bUqAxNpmKTc4g=LtbojvKAatyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::27) To BY5PR02MB6196.namprd02.prod.outlook.com
 (2603:10b6:a03:1fc::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|DM6PR02MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 084a83e3-daab-4720-6963-08de9ecad350
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: +gGMssAdKfrWGNNhIfk8DL+Kd421uPZO/WZPaZdQ26t2/Iryh1pWH88A22tatsagq+n6ggysY9sCn+NHVcbf6dky7jrb4QzsbYl478agyzFddMSOB8TtHlwfDiuF+BMgDtBb+Apaks5iYTiIboVJITtrHpUtr6O4CfOdRrCeYIy4Sd9dC+bFo4I3EVDtl29MDksf+69nt4vD9kSpFthjBkITJAG8OemsjOdg71fouL10VsirPyNZd3S5G/o7MTbm96/oZhYHrbI9EHKJvUHd+6clDo65Fgn4IQY5MBPHzzrMgZBug1qVA5JguJS4q2zP3NZzZ043aqioJ2ObNqUkyP+GUvGl17xGZ/zLNZBtVAvGGdLta3bIVKvdEiNDE2fJnl1ZT0NdewMaE4ZR7XEzrMZd6QMC8lnVjiYq5sk4eeuIuwoqjBkbkYDm7JhLnUYcHkDUa6LzoKQpXYdPlFeDxbKIwcoL4fLXMoxcoXPYdTGc/X1mGm5mX7/0ApxPJf/GqVnH8VKv4YaK5RtRHdVgLgNaLYVlSr//nnA0b4AEaVeCsLObClpnZulQynNi+NIh+bXYlSeAUF10qIxR+Xvgz6swg71MtR1G2/TsuRlchAHiyfQdTYTD61O98KU1OdYP0PvTWHErd+FhhoVJdZ7NpPDdZs1n0t2pn8Utd4Ad9nQV2O/46Z/ZiWEMSiw6orQ+KVKarznssCw+HEOXlKJ+q2kgFfBp3GeMtW5TvIGRxBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek10NnB4ZEdOcXg5ZlpIQkg1dTZpeGFRd0l0cCsyd0MrS0tSMDRnajlUdFFQ?=
 =?utf-8?B?MmdVSDNQSjRCVUhzZVZVK2I5czJ2WXo4WEwzYjZwV3BQYWhQTVh6Q3NZUmpj?=
 =?utf-8?B?NkdqNEUzOTVoR2p3WlRJVkErZlJkaklyUE9zYS9DTDBxUmhCNFc3UjRPU2Fs?=
 =?utf-8?B?aFJJd3RYZk5OTWFhdktnRkNQMVFGdGdDRHJrQzNIQTBlQnUwWVBmdHR6MDdV?=
 =?utf-8?B?eHlsdEhndndJbTdITjZiSmhLYlRuaGF1dGlLNEVMTU4rVFBTMzNrYWtZTnQx?=
 =?utf-8?B?UmM4VzhXdlBoRDYwM1NEQXBKZDBkbjlsTmVLbUpwTVdubTJNd3RMRVltK1FO?=
 =?utf-8?B?Yi9ORCtrai9QRk9OMVE4VDhpQ2xsdnUzSHU1K25ldHRRdzIwcHNEMTdza25W?=
 =?utf-8?B?U3BlTUFvN0dHaUgzY2JDdG9rSHg1NU5SdDh2WHRXbnNETyt2RXBWSk1YS08x?=
 =?utf-8?B?bUE1cEVMYkFHdG5RRUs3aDQ0U3h2UmM1eFRUblJNL2NIeFFqVkV2UkRmOVNH?=
 =?utf-8?B?TFFPT1YrY2UxTVl5bEZZK3lZdWIyTThpVXkzL1A4bFYwc3htRzIyZHRJRWcz?=
 =?utf-8?B?S1owMDBJYk9UZVBEQU9tUUtFdEJ1Rml4M3h2bFpiNE9FdGVJREpLOW1rRjdl?=
 =?utf-8?B?Snc5WGE1dWxCOXFsTDE2b1o1UmdlYXlrY1RGYStLOVY0ZURld2lZcXB5S2N5?=
 =?utf-8?B?MjVCdTM1S3ViYStDd2dQcERqSUZRa1JMK2JaZUVxUE4rZ1FSVHZOajRJZHJY?=
 =?utf-8?B?aEMrTnh4ZHFBNTBxeW8zajRtc3NDcHl3ckVvY0JKUkpwZ3h1eHBsODI3Z3dz?=
 =?utf-8?B?anVCSXhMZEpJZGhncGo0OFRUWS9QakRONFh0RU91cEtYeUlUajUvQ1ZCY09V?=
 =?utf-8?B?Tm1CL0VwcFQ5MUtQME9CODYxcGhlbHRQaUFmZU1RYkhvM2xzVWlRYUdDU1ph?=
 =?utf-8?B?NUd2UDZsU003S1hFRThoYk9weTFORDFjM0s5VklZR3JMMHN6a2NYU0VUVTRv?=
 =?utf-8?B?MEJqbVBNa0wvS3Axd0h6MnhWaXNaZSt5YjY4VzJZSW55bXIvRXBPRHREMTho?=
 =?utf-8?B?NFBQaXBuUVdRcTRvYldDYkZJWTk3VGNXOGxaTFBZMENCclBhRnd4cGxmRFFH?=
 =?utf-8?B?Y1ROU2NSUXJ6Z1AvM3ZoV2ZDTWNDUEloeWUxYUVHQk9BSFJlMXY1L1kvY2ZI?=
 =?utf-8?B?WldGcHhHTXQvazRIRXZKQXdxcWUydVpTakFTNUlOb05HQjNra0VoeTViMEx3?=
 =?utf-8?B?MEV1SmJVM2xDS0k0bUNPWnE5NWZJeEwyL2NwQW80MzBOWDYvUk1nS09OU2Yz?=
 =?utf-8?B?OC93VzRhTzVtZmRDaGhpcmZOREYyNDFQWDNweW9kdkUxMlo2dWczMDNoTUZQ?=
 =?utf-8?B?ZmRQTUNHekMwYm9wbVB2Tk5HR2NyM1RNL2tjRUFjL3lMSmdEb0ZXeXNvdyto?=
 =?utf-8?B?TlIyaHdmTTdqNGhIajl5MlVqNXlEQm0rTzFaQnI0TjRtYjRaTHJLUzZOWUhO?=
 =?utf-8?B?a3A3RktjS1VuS1FmOS9sSW5iZU91NXJqbjhUMEF4ZkFBNkt3MGZCYzNFRDJq?=
 =?utf-8?B?M3hYTFYyQktsV05UY2orTnhYaXJTZFl6YWlqYkp2Ti8vd1dtUmRTQnJ1eU5m?=
 =?utf-8?B?dm82WWROT09iM1dtY1pubWp5QlVHUDU2YUV6aXpVaW81M3doZ0NUc0JQUFVa?=
 =?utf-8?B?TjZPRHcyejZsTHVmdmJlaGgySVVZdzR5WkhOQUpITUcxM2MxU21GeUNTbC9W?=
 =?utf-8?B?TG9CZmIzNjBqU2p3K3lxSi9uUDJyK2V2Z2U1OE9JVjdyRkpZd3lzdEhlOXpO?=
 =?utf-8?B?T21zYTlYZTNpS1lKVXF1Z3ErZXJtOE9PY1E4bFZ2Um91eGpYM21KK29WL2ZL?=
 =?utf-8?B?Y1B6WCt3K0pnbjRJT1YvY0JoTWYzeXRhdUNxbExiWnJIL3pkTVFPVVAvdmVs?=
 =?utf-8?B?Mjc1VlZodnp0a1VSQ3AyS1JPMzhwQTRjWktjS0wvWU5yWFpTQUJSMXp5a1ZZ?=
 =?utf-8?B?UEFYY0t4aXJXbzNJS04yR3gyVzZuSVF3bUlxeE5ZMThIK21RcmNuUEdkRm1T?=
 =?utf-8?B?U2xDeEE4VkdXZ2NLTVg4SW15V0dtMzlQeUJqbUNiSUtRWWdhY1JQcndPTnp0?=
 =?utf-8?B?R0dmN3ZiWHl0RVoyYlFVOGJaeU9uNnplYkIvWk1nb0ZhcUNQUmJienRrUUo0?=
 =?utf-8?B?Ni92djN3UU05cE5wbVNveGttSlFIVkRyTXhEeWsrYW1EVGdmYklDZXdMZEhm?=
 =?utf-8?B?YTkrSThadlRPU0RmRThCZmF1b0l1eUo1TVRiSTB5YXROMDNMc0tkUlVydkth?=
 =?utf-8?B?c2ZQZHUvQUMyVlZsY0ZvRzZzSTdCckNqOUFTbmVXS3dvOHZwOFhFRXJFTEl3?=
 =?utf-8?Q?DBINyHorKjxIUR5w=3D?=
X-Exchange-RoutingPolicyChecked: Cz1PqwLLWP81D294SgyhcuMTs8UtMLNrdww6QBpOeGhR+tqmCwLrsqGfluo3N8Bq8zMjdoW6j69M4A6WP/42cgPtjB36mP+T+fGWTNSpIlqn9kg1zMflh1RBLb+Q6A0BO4E0jwmWkYrW8M5ULNByrWDXFRDBdoFviGqU0ClZErT7isdNfY9kiNBlc9ylNT4tddzP3vHWCcf1tiaf3xMBxSV8QnIWhuYhx3Tq6eXtFA9mDeY7ue1t2QXPz9GSahxPwYIChtQEusiX97QhBOc3d7UA1r+joeT/btbhMW9cZFBA8HST2gIbtrvzDFg0tr4836QUA7eaQnpHD3CBr74T8w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084a83e3-daab-4720-6963-08de9ecad350
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6196.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 10:51:52.9354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDHdoAbcIv8bC+Qmq2+lnkYfBu3aK5EEcV6f+XGJYlfkKbH+9ljvBchl6mcz2AEAoc7JgfDcoC6F26U6zNeJS8HPGzP3rQFTFS2k/386suI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6493
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNiBTYWx0ZWRfXyOyX9dLg17DR
 w32iyZYJILsDjdPchq/Sho/yUj6I8I2+yL94ZINQ87SVqUfSVn32aIR/F1uapMxoIE1BL6iTPDr
 rGagSdcEdVBiUc+x3hQQmQ+dSKogJGBEvY8iMITh0x51Aqt8Du6zJ8IZmYOZsOd1CVNkx7yBUS7
 x5gx7H0x4vt5KY72EjYxTfE1Ir6J2+xc1hNHJw3a4elbH3Hqqh90ajfxoqJ4wR26xZSi6hAKNmw
 VGiDMEKBVNegyl3miiG4SA2CVhuhqdt5BqpNLejNMYftVcsTnY8qEUwkEv3k0kAgqEcYpEwxVok
 dEebY9WwI+p74ceoi6yRq9R1aDYDLELnRM7OZqAWHKffpDgzkz8OaUE8DIA6EcbXjpkDg3UxHOv
 L4KejGtxradiK++GuWSt3ph3PuzBpaByxp0FooSCE/n4LrtVMWITdOqRnRi/fzlMhebP6VAx2PH
 Vopf6g9LPGkb89yj2hA==
X-Proofpoint-ORIG-GUID: nCaB_OI2wr6D0uKxu_5Dak4KM49H47no
X-Proofpoint-GUID: nCaB_OI2wr6D0uKxu_5Dak4KM49H47no
X-Authority-Analysis: v=2.4 cv=MbtcfZ/f c=1 sm=1 tr=0 ts=69e6055f cx=c_pps
 a=IMEwmUWWSCLuwm+xmU4zLA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=UAhI5BJm3avRXxMP5v8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 2026-04-16 17:04, Paolo Bonzini wrote:
> Yes and no respectively. For example if you use preallocation mincore 
> will return always no, and if you swap it will return yes incorrectly.

Ah yes, of course, forgot about that property of mincore. So the new KVM 
ioctl sounds neat for this. The one thing I'm slighty worried about is 
the time it might take to get that in shape and merged. I guess if 
you're in favour of such an interface, that would go a long way to 
getting it accepted into the kernel at all?

Here's another option, though I'm not sure you'll like it: We can get 
the same information from /proc/<pid>/pagemap, right? We just have to 
check whether bits 62 and 63 are both 0 or not for every page. It's less 
efficient, because we have to read 8 bytes per page, but qemu knows the 
host-virtual addresses of the VM memory, so it can look it up there. I 
feel it beats using dirty page tracking if we can't be sure when Windows 
issues the hypercall. One option would be to have this as a fallback if 
the KVM ioctl does't exist? The other option would be for us to use this 
only internally to get some more experience and measurements in while we 
work on the KVM ioctl.

Going forward, I think what I care about most for now is getting the 
interfaces right. In this case, I guess that just means the names of the 
command-line interfaces, and the question of whether we should have a 
separate one for HvExtCallQueryCapabilities() and then implement 
dependencies between them. Then, I can experiment with the backend 
implementation and we can settle on a proper clean implementation for 
getting this into QEMU, while experimenting with this internally as we 
work on it.

Cheers,
Florian



