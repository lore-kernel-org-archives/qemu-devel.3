Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C75C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrsv-00060Q-DU; Thu, 09 Jul 2026 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=64326bbcb=graf@amazon.de>)
 id 1whrst-0005zl-6a; Thu, 09 Jul 2026 12:45:59 -0400
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([18.158.153.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=64326bbcb=graf@amazon.de>)
 id 1whrsr-0004Rm-4y; Thu, 09 Jul 2026 12:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
 t=1783615557; x=1815151557;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AhDCCOpy0JD8eLCxTwXYxfMv7gqB/6cAbgBKtFmkYRk=;
 b=XrueXWLQgnsHhltO/rJfnKIC7bu2TVH98R721GV2lxXgdEgA9SoAr0VT
 bLw9G1/bOIr5noEpACf4tn04dCnFmNht9ocyJWXczO+9ELhTFUkF2OyH9
 Mp538BL5pQr6OcmURSOC5bvCnDfJZcgwcJlHr8igP9QnT8PF1qayfwm2h
 fp5ufnogzt25aThLppV7luLtDCmRnX2QG3dBJRpksrdCucTXkGQI2Y0JA
 db/RoLtSoIl0ztjjdWIcqvI9RIJgZbx106mYWHdf31H99ruAznPhhfClN
 gd1oKGKZ78zB74Uveea670BmPdPOA+w6oFc+FhlL+Pyjh8snvJMcWcrQb w==;
X-CSE-ConnectionGUID: 6nTfgEukT4KfJbCUL90fsQ==
X-CSE-MsgGUID: TJ9EH6sgRuCkYXUja552JA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="16164959"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
 by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 16:45:49 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:5513]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.35.75:2525]
 with esmtp (Farcaster)
 id 922cd0bd-e769-43eb-bed6-ca2f10437d0a; Thu, 9 Jul 2026 16:45:47 +0000 (UTC)
X-Farcaster-Flow-ID: 922cd0bd-e769-43eb-bed6-ca2f10437d0a
Received: from EX19EXOEUC002.ant.amazon.com (10.252.51.145) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 9 Jul 2026 16:45:47 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUC002.ant.amazon.com (10.252.51.145) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Thu, 9 Jul 2026 16:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MteTiRaeHz1uK7rvlKV9EBBkvaWuyhqdgEcKn4Abv+oWnMqNhitsw0v4OUaMVGoBmao9mNeexexl4TpCerjDo9rudHRghD8+UwSbrouToufAgwIfyow7WYW4GUUOzz20NpPpeasxriUsNIocY4gdJRceM25B5mxdRmmece9mPyJ84l7dS0x3IMi7/WwoiaJg/GIZC+npRVjCp32V1JD/+cPUBMKzvbrs2zHmTLwcrxutiuaeUUI39a5IkGPui+NVqPMkgxR9EWLin6myESBfmjjqCclYmZ/AXcmE8DLiU+ZOfmYdPkNZsT/DPqCa5h9cXJ6l8WfWbWECBl325FdKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhDCCOpy0JD8eLCxTwXYxfMv7gqB/6cAbgBKtFmkYRk=;
 b=yQPB1KuMow61N4CCp3BIj3pJ/eU1DXoU4qOWGh522sX815vexVOTdIsKq/vJrwje1MAiZXR7N1hrYC+Pe95k4kvFEN+QOTuI9hf40vDuooFAmBx0VqxAbXewXj4Vv3326Y41KpCIZ1XnQMxD245Obz86G65Xzc/DoE6pFE2heaDe8SijMJZRxy6MKNWgpBXHERMXsOOmsDDspy1ph8Idq7sTCM/HMJLTn/UuL526NAWpLPh5l2CAE4O5ijoEQMSkpGH7kjOwIvvrGVS5gw88EVpQqIoRZ5jAhBQstHsmbnilYcX/fp/m7RyEZ1DLyj/V2r9HMWhncMqv/sESUscalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:54::12)
 by FR5P281MB3988.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 16:45:42 +0000
Received: from FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6924:1313:12cd:49a9]) by FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6924:1313:12cd:49a9%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 16:45:42 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexandre Iooss <erdnaxe@crans.org>, "Alexey
 Kardashevskiy" <aik@ozlabs.ru>, Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, Antony Pavlov
 <antonynpavlov@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, "Bernhard
 Beschow" <shentey@gmail.com>, Bibo Mao <maobibo@loongson.cn>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Chao Liu <chao.liu@processmission.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?utf-8?B?Q2zDqW1lbnQgQ2hpZ290?= <chigot@adacore.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, "Felipe
 Balbi" <balbi@kernel.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Gaurav Sharma
 <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, Glenn Miles
 <milesg@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Hao Wu
 <wuhaotsh@google.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, "Helge
 Deller" <deller@gmx.de>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 =?utf-8?B?SGVydsOpIFBvdXNzaW5lYXU=?= <hpoussin@reactos.org>, Huacai Chen
 <chenhuacai@kernel.org>, Jan Kiszka <jan.kiszka@web.de>, Jared Rossi
 <jrossi@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, Laurent Vivier
 <laurent@vivier.eu>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Rolnik
 <mrolnik@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, "Pierrick
 Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Ran Wang <wangran@bosc.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Sergio Lopez
 <slp@redhat.com>, Song Gao <17746591750@163.com>, Stafford Horne
 <shorne@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, Tyrone Ting <kfting@nuvoton.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
Subject: Re: Call to clean up QOM onboard devices lacking a parent
Thread-Topic: Call to clean up QOM onboard devices lacking a parent
Thread-Index: AQHdD8JhSVKZiWJsd0GKL0MjbKwr7Q==
Date: Thu, 9 Jul 2026 16:45:42 +0000
Message-ID: <fee18020-dcfe-4d91-8384-5cc5f8321ff7@amazon.com>
References: <87se5scipx.fsf@pond.sub.org>
 <17c7f91b-8935-8ebf-a982-f91df755af81@eik.bme.hu>
In-Reply-To: <17c7f91b-8935-8ebf-a982-f91df755af81@eik.bme.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB3020:EE_|FR5P281MB3988:EE_
x-ms-office365-filtering-correlation-id: 876f0bee-a6d8-49ed-bc1f-08deddd983ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: diof0lgJmpoQEB9+MxLeDyt1o4whISHGnTQ73PzlVwlSkFAQ5ZUcQLbTfRROJOGx06Gytoa59cb3WUVaJ1LQVt/CYlpwv9p2wLcweOq48dwn+NSsmI9BQl+TqG7Xk9f4oyZtK30O5kT/jq+bdcy2dn9LUIQDFJdFs1G3oAqQZgsp//6/ivT9BtRPySYOchwDOckmoFh9btAv+bndYYsLJ3mlogFMxjtXAoLqfmdjhfuPzwCu2MHx8UZXG6SMG9cBxmyp1/QAtIo0VoCzgv6FWN7SEf9yfX1fDZdwOY0YkDVmg46Ki9cqsbS8u27/0iC70EwDNTfOOMQV0jAV3nKCAobtfF2qjtb0ffjFK5r0MqN15PqbDYNn9xx8BHUAdx+FQTKb/Rk1lmCQsN6azy/HMbdb1V2BOcgGOxcYDhwV+tZOfN2A8pvFNExDOk002rcu6tYFgVCAkBKZFsbzD3AP5LlOcLG3MdiFOkSux+jUlZOmFSyrnx6j+Nl2yAFYaQtqAtBMtS6st9xIgXzlG9KZfMlduSsNq3H6YxgPzd0u2hw9qEnuZH+weEO+jl5KbwgKWye6+JHrEBL6x4C8ZgDeYv6NGEQe2GC5tm9/Epjm3Z7CgHy+OlJ1A8AsjOnGxC1m4uhSqfk5o2U5oX4km4cIH8L52rzilqfjVNu8WdviD1vfwBwKw37pPlfZ1Ah6JMu3xCCbrfXtSU0ixpQUd1LSaCnYiqPZv+CgK+3yEjK3LTk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFlwRmc3eUhidkErRGJERVl3T2o0WDJMcXNuY1c3dUdHWEZrczgyL295aHMy?=
 =?utf-8?B?R01pT3dHZ1N4eE1XdnNuZWY1VWFTMmdZY25xWlQrbHo0eEV3cFU0T3FTYURK?=
 =?utf-8?B?UWY5UUwyZEZwaDRZVlpVTElmNVRmcVVsUkxRajAwSGR4SjA4em5ObGRNL1JN?=
 =?utf-8?B?SnA1cGRXdkZwTW1XSWFnV2FJdHdFczlvNnhNNDJaQ0dRRjQ3cS9KYWozN3Mx?=
 =?utf-8?B?THRTQUVYK2hSSkJRRGNaZFZwRWFLR3ErTWZvRUVDT3pob1JYa3Fnemt5aUZJ?=
 =?utf-8?B?Mnk1aXpwR1djeWU0UWFjSEJTNTdpL3RXY2ZuZkdmUFBQZDJvYzVtNFpVZFlq?=
 =?utf-8?B?U2o4SnZzZDVMWEF6LytHMGhmNnZpaWRzbVRveHNrb3VmOGlsNVhxUjJBZ0Ni?=
 =?utf-8?B?R21TcURHM0RlV1d1cGxzT0VpVDZvQW0xcUdudWp2Ym5aTVJDdFYycmlERVhY?=
 =?utf-8?B?OFlwcGhWTlZYMVhjMTVHWGdvZURoNEdNellBK1kxc25qaW9VcUU1MUZnZitX?=
 =?utf-8?B?Ny9GZmhaWWxXbE1YQXRCSERhVXE1Q3NZMHhoNHpPNTd5dFVtblFLWnoxb0Qw?=
 =?utf-8?B?UDlkMVI1TWNldVhBWDhwM2NOUjJkeGJDSTYwc1h3cjh5OVhmRVFCcTVvK3k0?=
 =?utf-8?B?TExmeGN3N1oyaGJQcmV3ZU5kanhvc1JqY3ptNktIN0wrQVAzZ0F2U29lUGFT?=
 =?utf-8?B?SXVad0dWZHZKajd0VFJ6UEJQbkZHOWlQSmJrQ1kwMGxrc1pWcFV0VGRiTXJo?=
 =?utf-8?B?NEpBSnREa0wyMTFxQVVVMFJGQ1lCZm1VYldkQUo4T3oxKzBuT1BKdXNpeXla?=
 =?utf-8?B?YUJnRXl5RlJuNHdkSGJ6YlVMcXFxTFNCYXJaaHFLVFY1bzVyYjFOUXRpcFI0?=
 =?utf-8?B?TzYrZ2ZuMGoyY3ZVUThSQy9XMHBOU2hGV1BPTkNWbDhzR2xadC9nS3RjQ1hq?=
 =?utf-8?B?Zys2dTB1NXJFOWNKdk9CdGJTY211Tjd6eGFzbThSWWJpMW9jVHY2SXBscXdj?=
 =?utf-8?B?bE9CT3MxbzE0MTdqREhqdTBMR1dzWWRHQzNzWlNDRU5vZVo1ZlFLNDVWNWZG?=
 =?utf-8?B?TTk0b0Fhd0tmeHZ4MkF3S3JqYlVMb2hLSlVLSXFyWGlMM1c3MzFIeGEvN2o2?=
 =?utf-8?B?YlRjMUd3MHJlZ1dGODlmeXllTFA5SVhWdGd5Q2x6V3NWNWcwYnBFby9EMjlW?=
 =?utf-8?B?NFlkWVc5blhMQUxEYjJuekVDZVMrbXl4S2JjdUFZN1FtMmRjc245MlJYaU5C?=
 =?utf-8?B?Y3BGemIwdmxzYVVMcXd0QlF3SkdXVkxHcXlBVDVLeExpVHNmMk9hN3lPbXZh?=
 =?utf-8?B?STY2Njh6MXJxaFpUeU4rNVZSN3dsZUYxMEVTSjdVMG9rYWh3V0NNNVZjWHl6?=
 =?utf-8?B?MFVhWmM1VzJ5QTF5Wk52NDhWTHp6RGJCc2dlODhpelRFNElsanFkRWhwUkZD?=
 =?utf-8?B?aDZnWFVUWTQzMGhsVElacFVmUHFmTWQ4bmQ1QjFwb2YvSktKajdSVnZSckdZ?=
 =?utf-8?B?bHZ4WGxBcWVlVDVRTWFkUUk0bGp2SEdhcElZT0JVS3ZTZ0F1UlVMbmVqSEdv?=
 =?utf-8?B?MjBxV2dDTmtJMXRHM21sM2RrcXNscEdrZVFqUjNITXRESjR4bEpvNnF3eDc5?=
 =?utf-8?B?OWp3dWdpTERqb2tCYlVsdXJsWnRoNTg2SGZtWnRiMGdjN29NWmZhUC9KOVdx?=
 =?utf-8?B?RVNiYlN3YUI3R0hBQWpOVlpob2dDTFJaNjU5R0hlWW1TMWtPeGQyNDF6NU1I?=
 =?utf-8?B?ZXlNOGZPNVAzeVB5VVpEeVpBV1Nna3FuWnpidnh2VmNlVWlQV3ZQem5BcW5C?=
 =?utf-8?B?YVFKWVZzeExrQXZhS1ZpTncvcVczaVgzbW44UTc2QzY1YjRlOVBFWVZNZitk?=
 =?utf-8?B?bEpoVlVhcGpHSS9oN0xpRjd2M1FRT003SkdzZHZsUU1XRGF3Tzg0akpFeVVS?=
 =?utf-8?B?TXhqVjNLK0czOUxWNnRJVDhOWlBRdXViSEdMUWJzR0E1Z0dVK1ZpRm1ka25k?=
 =?utf-8?B?R09zUDVUdzdGamxxclIxWUMrR2QrSFRhZ3JOdGRaWUJDWHBpTFBBeVlMV3ow?=
 =?utf-8?B?VjdXYnNKWXZWN3lBaXN2ejFsNlRuRGNDdVJ5WVJwcXQvUW5iOEZPdnFkRC9o?=
 =?utf-8?B?VFZHSWNuVXUvRmhOc2gwQnlaN1NsRGJrSDVsUXlja2NvL3JLMGlwVXk1S1BP?=
 =?utf-8?B?VDN3MEFpYURER3pZemZ4ZGRzeldNdDQ1c0h3V1RPNy84Umdzc0VSZ0hxcHV2?=
 =?utf-8?B?L0cwUWhoV1dCTEZIbG1YV1lwcm1NdklqeGpkSFE5R2Q2YlJYdVd3b0M0VFRE?=
 =?utf-8?Q?VenV+RcJMRTUAUmvKj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A4CF3D86B11E045A06F29391FB3691A@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oNKLxMW4iN1S+dzPTIbzgg32WqsJwO5eFoXO97JJ8Wx8O0EZQWmuHV93Pu2405lULTHZdG72YnRoGBkhyEtKLrlTBkimEG8FcMFPfrNZgcEgS4ho9MVVmGzMlssk4Tln3UHvl82axU5afugVxejkXAbU+IwcF/RkKoL7zjSMYhOk/qHyIxx5DE7ereDpcXP45Yb1/Yu8EKS0WiBYSLjOTD3KQmB7BTK+DjgQaePkFmRm+pVDF9SO6rbTa/nZi4OZ2jo/DYELmLF2stedIUXR6ZbaWgZeXnXhdlUyIhtuFDpZkxPksrA2Te0/e3s0zUK2knF+E6baUXHh/DUElY0syg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 876f0bee-a6d8-49ed-bc1f-08deddd983ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 16:45:42.3789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1o8fO0esUtsHQlgE24eE+XnSzOjQrhdY3m/QDAm2HMSpCQM/B5ebs74Fzb3ssro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB3988
X-OriginatorOrg: amazon.de
Received-SPF: pass client-ip=18.158.153.154;
 envelope-from=prvs=64326bbcb=graf@amazon.de;
 helo=fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

SGkgTWFya3VzLA0KDQpPbiAwOS4wNy4yNiAxODowMiwgQkFMQVRPTiBab2x0YW4gd3JvdGU6DQo+
DQo+IE9uIFRodSwgOSBKdWwgMjAyNiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+PiBBIFFP
TSBvYmplY3QgbXVzdCBiZSB0aGUgY2hpbGQgb2YgZXhhY3RseSBvbmUgcGFyZW50LsKgIFRoaXMg
ZGVmaW5lcyB0aGUNCj4+IFFPTSBjb21wb3NpdGlvbiB0cmVlLsKgIFRoZSBsaW5rIGZyb20gcGFy
ZW50IHRvIGNoaWxkIGlzIGEgcHJvcGVydHkgb2YNCj4+IHRoZSBwYXJlbnQsIGFuZCB0aGVyZWZv
cmUgaGFzIGEgbmFtZSB0aGF0IGlzIHVuaXF1ZSB3aXRoaW4gaXRzIHBhcmVudC4NCj4+IEFuIG9i
amVjdCdzIGNhbm9uaWNhbCBRT00gcGF0aCBpcyB0aGVzZSBuYW1lcyBvbiB0aGUgcGF0aCBmcm9t
IHJvb3QgdG8NCj4+IG9iamVjdCBpbiB0aGUgUU9NIGNvbXBvc2l0aW9uIHRyZWUgc2VwYXJhdGVk
IGJ5ICcvJy4NCj4+DQo+PiBGb3IgZGV2aWNlczoNCj4+DQo+PiAqIElmIGEgZGV2aWNlIGlzIHBs
dWdnZWQgaW4gd2l0aCAtZGV2aWNlIC8gZGV2aWNlX2FkZCwgYW5kIGl0IGhhcyBhbiBJRCwNCj4+
IMKgd2UgbWFrZSBpdCBhIGNoaWxkIG9mIC9tYWNoaW5lL3BlcmlwaGVyYWwvIHdpdGggbmFtZSBJ
RC7CoCBJZiBpdA0KPj4gwqBkb2Vzbid0IGhhdmUgYW4gSUQsIHdlIG1ha2UgaXQgYSBjaGlsZCBv
ZiAvbWFjaGluZS9wZXJpcGhlcmFsLWFub24vDQo+PiDCoHdpdGggbmFtZSBkZXZpY2VbTl0sIHdo
ZXJlIE4gY291bnRzIHVwIGZyb20gemVyby7CoCBUaGUgY2Fub25pY2FsIFFPTQ0KPj4gwqBwYXRo
IC9tYWNoaW5lL3BlcmlwaGVyYWwvSUQgaXMgc3RhYmxlLsKgIFRoZSBjYW5vbmljYWwgUU9NIHBh
dGgNCj4+IMKgL21hY2hpbmUvcGVyaXBoZXJhbC1hbm9uL2RldmljZVtOXSBpc24ndDogaXQgZGVw
ZW5kcyBvbiB0aGUgbnVtYmVyIG9mDQo+PiDCoGRldmljZXMgYWxyZWFkeSB0aGVyZS4NCj4+DQo+
PiAqIElmIGEgZGV2aWNlIGlzIHBhcnQgb2YgYW5vdGhlciBkZXZpY2UsIGl0IHNob3VsZCBiZSBp
dHMgY2hpbGQuwqAgVGhlDQo+PiDCoGNoaWxkJ3MgY2Fub25pY2FsIFFPTSBwYXRoIGlzIHRoZSBw
YXJlbnQncyBwbHVzICcvQ0hJTEQtTkFNRScuIFN0YWJsZQ0KPj4gwqBhcyBsb25nIGFzIHRoZSBw
YXJlbnQncyBwYXRoIGFuZCB0aGUgY2hpbGQgbmFtZSBhcmUuDQo+Pg0KPj4gKiAiU2hvdWxkIiBi
ZWNhdXNlIHdlIGhhdmUgYSBsb3Qgb2YgY29kZSB0aGF0IGZhaWxzIHRvIHBpY2sgdGhlIHBhcmVu
dC4NCj4+IMKgV2hlbiBzdWNoIGEgZGV2aWNlIGdldHMgcmVhbGl6ZWQsIHdlIG1ha2UgaXQgYSBj
aGlsZCBvZg0KPj4gwqAvbWFjaGluZS91bmF0dGFjaGVkLyBvcnBoYW5hZ2Ugd2l0aCBuYW1lIGRl
dmljZVtOXSwgd2hlcmUgTiBjb3VudHMgdXANCj4+IMKgZnJvbSB6ZXJvLsKgIFRoZSBjYW5vbmlj
YWwgUU9NIHBhdGggL21hY2hpbmUvdW5hdHRhY2hlZC9kZXZpY2VbTl0NCj4+IMKgZGVwZW5kcyBv
biB0aGUgbnVtYmVyIG9mIGNoaWxkcmVuIGFscmVhZHkgaW4gdGhlIG9ycGhhbmFnZSwgd2hpY2gN
Cj4+IMKgbWFrZXMgaXQgdW5zdGFibGUuDQo+Pg0KPj4gwqBMZXR0aW5nIGNvZGUgZ2V0IGF3YXkg
d2l0aCBub3QgcGlja2luZyBhIHBhcmVudCB3YXMgYSBtaXN0YWtlLiBJDQo+PiDCoGd1ZXNzIGl0
ICJzYXZlZCIgdXMgc29tZSB0aGlua2luZyBhYm91dCB3aGF0J3MgcGFydCBvZiB3aGF0IHdoZW4N
Cj4+IMKgY29udmVydGluZyBleGlzdGluZyBkZXZpY2VzIHRvIFFPTS7CoCBJbiBvdGhlciB3b3Jk
cywgaXQgZW5hYmxlZCBzbG9wcHkNCj4+IMKgaGFyZHdhcmUgbW9kZWxpbmcuwqAgV2UndmUgYmVl
biAic2F2aW5nIiB0aGlua2luZyBldmVyIHNpbmNlLg0KPj4NCj4+IMKgSSB3YW50IC9tYWNoaW5l
L3VuYXR0YWNoZWQvIHRvIGJlIGVtcHR5LsKgIElmIGFuIG9uYm9hcmQgZGV2aWNlIGlzbid0DQo+
PiDCoHBhcnQgb2YgYW5vdGhlciBkZXZpY2UsIHB1dCBpdCBpbnRvIC9tYWNoaW5lLyB3aXRoIGEg
c2Vuc2libGUgbmFtZS4NCj4NCj4gVGhlIGxhc3QgdGltZSB0aGlzIGNhbWUgdXAgSSd2ZSBhc2tl
ZCBhIGZldyBxdWVzdGlvbnMgYnV0IGRpZCBub3QgZ2V0IGFuDQo+IGFuc3dlcjoNCj4NCj4gMS4g
V2hhdCdzIHRoZSB1c2Ugb2YgdGhlIFFPTSBjb21wb3NpdGlvbiB0cmVlPyBJIG5ldmVyIG5lZWRl
ZCBpdCBhbmQgDQo+IGFwYXJ0DQo+IGZyb20gYmVpbmcgYWJsZSB0byBhZG1pcmUgaXQgaW4gaW5m
byBxb20tdHJlZSBJIGRvbid0IGtub3cgaWYgaXQncyB1c2VkDQo+IGZvciBhbnl0aGluZy4gRm9y
IGEgbG9uZyB0aW1lIEkgZGlkIG5vdCBldmVuIGtub3cgYWJvdXQgaW5mbyBxb20tdHJlZQ0KPiBi
ZWNhdXNlIEkgb25seSBuZWVkZWQgaW5mbyBxdHJlZSBhbmQgaW5mbyBtdHJlZSBhbmQgcmFyZWx5
IGlmIGV2ZXIgDQo+IG5lZWQgdG8NCj4gbG9vayBhdCB0aGUgcW9tLXRyZWUuIElmIGl0IGhhcyBu
byByZWFsIHVzZSBJJ20gaGFwcHkgdG8gbm90IHRoaW5rIGFib3V0DQo+IGl0Lg0KPg0KPiAyLiBX
aGF0IGlzIGEgUU9NIHBhcmVudD8gVGhlcmUgd2VyZSBwcm9wb3NhbHMgdG8gcGFyZW50IGRldmlj
ZXMgdG8gdGhlaXINCj4gYnVzIGlmIHRoZXkgaGF2ZSBhbnksIHRoYXQncyB3aGF0IHF0cmVlIHNo
b3dzIGFueXdheS4gSWYgaXQncyBzb21ldGhpbmcNCj4gZWxzZSBpdCBzaG91bGQgYmUgYmV0dGVy
IGRlZmluZWQgc29tZXdoZXJlLg0KPg0KPiBXaXRob3V0IGdldHRpbmcgYW5zd2VycyBmb3IgdGhl
c2UgcXVlc3Rpb25zIEkgZG9uJ3QgdGhpbmsgSSdtIGFibGUgdG8gZml4DQo+IHRoZSBtYWNoaW5l
cyBJIG1haW50YWluLg0KDQoNCkknbSBhbHNvIGN1cmlvdXMgb24gd2hldGhlciB0aGVyZSBpcyBh
bnl0aGluZyB0aGF0IG1ha2VzIHN5c2J1cyBkZXZpY2UgDQpzcGF3bnMgYm90aCBlYXN5IChhcyB0
aGV5IGFyZSB0b2RheSkgYW5kIGF0IHRoZSBzYW1lIHRpbWUgZnVsbHkgUU9NIA0KcGFyZW50IGNv
bXBsaWFudC4NCg0KSSBoYWQgYSBxdWljayBsb29rIGF0IHRoZSB2bWFwcGxlIG1hY2hpbmUgYW5k
IG1vc3Qgb2YgdGhlIG9mZmVuZGVycyBhcmUgDQpzeXNidXMgZGV2aWNlcyBJIHNwYXduIHZpYSBx
ZGV2X25ldygpLiBXb3VsZCB5b3Ugd2FudCBhbGwgb2YgdGhlc2UgdG8gDQpnZXQgdGhlaXIgcGFy
ZW50IGRlY2xhcmVkIHZpYSBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKCk/IElmIHRoYXQncyB0
aGUgDQpjYXNlLCB3aHkgZG9uJ3Qgd2UgaW50cm9kdWNlIGEgbmV3IHFkZXZfbmV3X2NoaWxkKCkg
d2hpY2ggZG9lcyB0aGF0IA0KYXV0b21hdGljYWxseT8NCg0KQWxleA0K

