Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF332EDF143
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvpp-0003ik-NE; Fri, 13 Feb 2026 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvpn-0003iF-QC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:15:59 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvpl-0008Qp-I7
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:15:59 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DEvv063415852; Fri, 13 Feb 2026 08:15:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PTDxK4A7HoVT2bXPQoOUZDf0xJgaOj1wdH0Gq8V3G
 bM=; b=02iNExrWFAldP1u6POPidPFAqymeg43341uKn8xkbIoi9Ibze/hBPpNi+
 5vjIUdmY0hyHzPTxhZkUdWrRmY0VQ5e+WlglfB8RX+Ox84BELGW9AnJin+ki+Trw
 BWkM8ApIO/ttBIvv1y2DImttXB5QsA0+/V1DOYHzFanDn4bGfI5ZoPMdcuJUlZhL
 JajGEBvILMkRthwQony20S3VVUg1lHKxc9d6tTsVgmdwNFJf5pLKpYIQqw5/m4mT
 FP2e3ULfsj4KzlGchVlKI7eZ6iHtLbRIxGgqwapvDUq31cPJ+gl+fe13AM2kku4g
 Yt+flFtdc+9oKULZ8vioPwlYMPW4A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021078.outbound.protection.outlook.com
 [40.93.194.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9jp9u1se-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 08:15:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeWRrIaDxIgh2+oGLm0PWlD4JcRy+4vgeQBwebnTOBrN5mWjTpfLewLhhcRbHRpDu3/BxoMi4ZbQ2fVvdHfZbdF7sEBq87c4++sSgboxVGrSYg3Tu4TCE4kHmd28dIR4QhB/aMR10gYehZ/u9XZ3ESGQT+AAmDSzIBIzZtHtOzj/bQScMXugYf7C0pmK8Ssb5cKkEongDF9nKp1q05/+52jr5euInXB5VvsssIG1X5fcclVwD78jPfPAgs+dQDVr9MERktj5T6sBhn0abm9XBmbUuQ86Uc9PfNhLos33qqSBYRLqKYlOcUMjvITe0zpVeY9s2SQw8qaFFzbSOGh/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTDxK4A7HoVT2bXPQoOUZDf0xJgaOj1wdH0Gq8V3GbM=;
 b=koGwLw1OmeRHJgbuvvjNrOHZVdyVmHQj6e0L4FbshN/E+PTeamI7hUQarM/iKGsgirik/Dr0Z9/LRuqeXMw/VdG8s99m0K30spfOdwFnLivfPWc/ndURXea3bxLtCEWJncuUCYCjoFKbEwOj3xLQw8J1dEUYk2KO7mTGzk3tfQZAAudT3KUW6WfvqVvjp7UodQvwTD7ETuqc0jxn4IAmdo8m3Nut+pKSYP7jE6AVd6TClaWxDaBJ5F7TlvO28xLFpoRqdT71VB74ohicX3QrJa3/g+ti1emiS7l2ZiA0rjXKesp/rjpn8RGF/Kf3f6KAqVNiH6xLCuBxtc8EHT4cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTDxK4A7HoVT2bXPQoOUZDf0xJgaOj1wdH0Gq8V3GbM=;
 b=D9k+rvvlAv0Dh7bm8pQPnhehFKbRW0el7JQ6O7OW3wtjcZhrtgtPDdExQvlgt3d/xQLFn349enakgO9Pu+vKjSYHYjOLADlibxmZnKBPRWRkA50MJ8J9PTdOr3iLYEgNh3kAcbvQi5tkpl3TlpPEWZL1rH41ISeGWw/iDPWe9kde3mz8MqKsTuCyce1F4uSphKbXU0knlltoBhdqi+ob0NxHrwovyPr3PyXGiKyuQr/4kD/etD7YJa/RvkfvXl6jCyqrJGL/tKpvqephb/0r96f2Kpd4gZLf13jdXgnve6NtAZa19sWVS0Bv+Sp7sg1q3RlzNizz3OL5+qdJfRd5tg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:15:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:15:47 +0000
Message-ID: <cc5669a9-2c17-41c2-bd5a-c4da18269bbe@nutanix.com>
Date: Fri, 13 Feb 2026 16:15:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/43] audio: remove AudioMixengBackendClass.name
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-44-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-44-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:610:38::46) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10249:EE_
X-MS-Office365-Filtering-Correlation-Id: a7306921-8186-4455-8b71-08de6b1b2599
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REhwaHVTMVJ0V3pVTDhMZjRQSGNBQnF0RitZY0F2cUpoN2VvVWdJbmIwbW1V?=
 =?utf-8?B?VU1oYTZnVm9LOTNWMUtkWCt0SnN6d1owV3JLL0lIY2ljRlZLSmw4anJ6RUp0?=
 =?utf-8?B?a3ZIRE1CNkp0dUZTTEdoM2VyMWF6emQzUXYxaU83ZldSR2RtaExHTis3S3pn?=
 =?utf-8?B?aWE1QmQ4QTZqQTRvamtsTjVmY0piZXJEbTZmcVJLakMxb3ZNclNITFo0bkZz?=
 =?utf-8?B?NUd6ZjF5dzhFdHdvQjlycWxUQ1FlYUtoak9jZ2N0UklIcWV3Mm1RSnhzdmxq?=
 =?utf-8?B?V0t6dll5aUx0NHVLQVBNTzdnYVE5ZW9nSTJDaHBTdWhObElQS2pTNks1TktJ?=
 =?utf-8?B?SDFNa3VSb05TOEI3cm5mYisvSFVXY0M1bklJMkcrK2RYZWxSeFRvVEVWaVJW?=
 =?utf-8?B?N0x4QkNwUDl3NjAyMnE3WC9aeEQzSnh0bmZuQ09mL3M4ZzViWlF0UXpSL3Rm?=
 =?utf-8?B?UVRPQmVGUTY5eXE3bEwwK1R3YzlNUENTemdkYzA5dk9lVTlSa1ZhUks2MDFN?=
 =?utf-8?B?SmdmenBDRWtyS3dMTlhzZ2FVVXA3QmZRWjN2UWRhcUdFeElpOWxDdk9yM3k2?=
 =?utf-8?B?WDhOd045TzJYVlJESzduRkpqMVoxOHl3eUUybzl5VkNZZTJ5bmFTVUNZZWxx?=
 =?utf-8?B?Y3R3a1NZUG92VmdGVlI5UUZRcFJHVlRqbHFkNWVKOUlBZmRuenR6OWFPbUxS?=
 =?utf-8?B?cnpqMDA1VEg2YzF0TDl3aWFiWFpCaHNqLzlNQ05LTURrM0hmQ1owTStpWHBE?=
 =?utf-8?B?Rm0yZVJxNXUvcE15Zmk2UzZZaGovcDVTWHFlcWhKQlJSYlVQT0k0TGtjODV0?=
 =?utf-8?B?aXFuQkVETGl2VnEzTC9MVkFCR3RYQm90eWFXcUg2Q2p4S1A1MWUyMWR2RmxX?=
 =?utf-8?B?LzYzVXZLTXZkUnpWWFE5ZzdCUTNaeElJMlhvQVA4bGREQU8yZVhMU0YrMXAz?=
 =?utf-8?B?dnJzY3BzaE9KSkh3QVFEbCtUU1ZZY1dHRXk3NnhsVWJpbUZMWWplZlhzNVJX?=
 =?utf-8?B?QmNmVGY0MEl6dWplM2hiaUJmTHNnVkp5cThybE1BeHR4NElidkd5bDBMK2dT?=
 =?utf-8?B?eHNNWENvMis3c011MHJCbWd4K2VFMkRLNXVJZi9ta0RKNTlLVGhzRGVLbjcx?=
 =?utf-8?B?cjR3UkptdHBRQmpiQ0xGb3pWMnVZVUtVeTI3OXBRVGxzRlh6OHk5SVBDeTgy?=
 =?utf-8?B?TURTQzBVSHhOMHdMZTcrTzhpMGxTcTNHeWVEZi9tR2Ryd0VTR3pBZGYzRzFp?=
 =?utf-8?B?ZTFVY3ozbFc5T0JKR2dOYWwrakpCL0VPQ1JraVhHMmgwSWI3NnNTY21JVG5K?=
 =?utf-8?B?N25mQTNWek92N0tuNXlybU5reGlPZEdrS29Ea0NkT1cwZXBpbHRUVnVubnAw?=
 =?utf-8?B?bW12N3l0cGJ6NVdiNURvbGlHNGJaN0hiRWJUc213V1ByTm4xMGpWVk56NEMr?=
 =?utf-8?B?N1QwSm82WHM3YUF0TkN4UEhZK2dwTjZqUGJjYzVkZjljdDBrOEJ1QzFpWmVQ?=
 =?utf-8?B?SjVGWFo0M3RNSXZGcnJubFU2UUNFNU9lOGh1U1k5WUU0T2JkSXNPRWM5UUNm?=
 =?utf-8?B?bUhHeGpJSU80NXhEMzU4Y3BFZzkwcHIxSnMwTndYcy8yM3o0VXlmTVg1UjMw?=
 =?utf-8?B?d2EzR0pJNExXVi85V2ZsVDMyTDRubHhzaDU3bjI0bHpUdXhXODhZK1hQOStv?=
 =?utf-8?B?b1NsK2JxanFLR2lncjV4QTJqSHQ3ZFRBVjVNeVBUTi9mNVBTcGxteEVaemQv?=
 =?utf-8?B?SjZNTTVZS2xnRnpaa0pnelhYNHVCS3RIakVxWnZoYU9NeVFUeG5RUUFuQVMy?=
 =?utf-8?B?SXRnWVNnTkg2Ym1OeE5mMHlUbGdDejdJL0I2UE5aVEVGWUtCNWRUc0ZQZ0Zn?=
 =?utf-8?B?eFZWbzV1UERCOGw2Qy9tTFA5R1lnTHZuMnhiYlVLR2VablAzU3VGTkgxV3Iy?=
 =?utf-8?B?SWM4RFZyWjNTV2xLbmZPNERaa0crTnB1NDZMeDVZZlJ6TEhiYzI2dERUbUx3?=
 =?utf-8?B?V1cxTkNvWjFRTzRJUjUzSUo1NEdKd0FnNUc5aWhGbXp2dEoraTBtR2ZaSHgx?=
 =?utf-8?B?S1Q1SHUrMkxQTkdwajVpOWtLbnBCdk9ZM1F4TlM0S0NjVDd0SXhGY1ZkZVFL?=
 =?utf-8?Q?rsyg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3RvMzNmRWVTaGU3NnFxWTFwbFd1OUtLLzYvaUhiTitTNDc5TW4ram1HaGpq?=
 =?utf-8?B?L0FnWlBEZjRzNFJ4ZFBvZSsra1dWUXllbnNkTkZjeFUvUmtGaDY1SndyTWhj?=
 =?utf-8?B?QmgvWk1HUjV1RmloS3JEOXJrRkczWjc5eXg1NUZsZjZpNitiQ3lxV090SDFy?=
 =?utf-8?B?dlc0d090WDFhWXpVbmszK0dId3NSRUhKWHdUVmZ6VXljaFVmWHZScGJJOGlT?=
 =?utf-8?B?UCtiZ2ZVN24zcUo1R1Z1aGoxaStIdTZFSDBNS1pwQVpmTnFSUjNiRnU5U1F3?=
 =?utf-8?B?U2NRZ1dvUEpYSWU3Z3FLV2NCd1ZMcGprWmtMNG1Xdk9zVUwxM2tGYm52Wkwx?=
 =?utf-8?B?Z1M0UTE2aC9QSG5lZ3YvTTd2dE0xZXRwNFJLcFQwaHRBOXN2ZmxtRXhDaFdU?=
 =?utf-8?B?eU1OSFFXeE1zRGxXTXJsbHNhQXdWUXBhbS9HUDJrR3FreFZCL0Y5Mkh1VUtD?=
 =?utf-8?B?UUphYm5QSEI1NXJQWitaNG85L3FJTVVzb2VYTHBtbHkwMncwVStlT0dkdzhl?=
 =?utf-8?B?NXdaSXR5bHNlRjNYQnp1NW42dW9YWHZmNHY3TWZ0TUlqbzdwaERKd1dCelNu?=
 =?utf-8?B?cnpENVZRT2h5SW52T2NaT281eU9jbEZyNFdKeDZoYitJRlVlSlNRN2Z2SmVY?=
 =?utf-8?B?WFB5dlZWc0dMSVI4QmFDTEtKMHdkeE54RnBDN0dpNlpQYWRHd1BQaUVFcVVm?=
 =?utf-8?B?M1lpSzdTaUdZeDVsWXNXRFlzNlVqZThWOFl6N1IrakJORkNTem1LeStxSWxD?=
 =?utf-8?B?eEFwUmt0SXNDejZEUWxvM1cycitydHFObitaMVhXem84OHcwWmpPVzVMRGQ2?=
 =?utf-8?B?bjk4cVNSeENYVFpNblpmUUhGRWcvdFVFb3lyUEZVaExOQWJ1Mmdvb2tBZG5T?=
 =?utf-8?B?dnVZZW9ZK0o3bTJQYTdiOG00b1pYcmdpRjR3b1AyUFExMzhFM3NNZkVQTTFu?=
 =?utf-8?B?ekE4c0VvajRSQjVvM09CTGtueHRFWE5XR0dwSk1rSFg0NGwrNkM1K25CTmFv?=
 =?utf-8?B?Nkc2d0RLc1dBWWhUanZ6QklKajJTVHBvSE0zVUpJT05ZSFg1WGlRUDZpUnoy?=
 =?utf-8?B?YlJhSEUvTzJ6bXQvWjdUa0ZQV0M1Y1FNWEpwYlpnM2kyelYyVGc1clFUeHln?=
 =?utf-8?B?aHJEZmljajhqcmVrTnFoNVZzSEh3VzRLd1VvcVFtUlNJbjJEVWFOVEs3T0lx?=
 =?utf-8?B?OUtwRE1RMnlIQlFmdkNVdFVtK1ZiT2VuVHhVVGwzeGFSMVRVRENYUXpXTkly?=
 =?utf-8?B?S01sZGQzL3F0Wjd3eGgrazV3bkVueWVVK1FlUFk0R3hISlh5aEMrdHlBelFq?=
 =?utf-8?B?Y08vdi9QM0Iybm9zSExDUkllUzAvZUVrTGJSdFVmSEJoWDN4UVYyWXNMSy9D?=
 =?utf-8?B?WkluaVlWQ2tuclhNSjBnMGJYN0FxSzF5UDN4Q0dZSzU1WEJza2Q5ajVKSGpp?=
 =?utf-8?B?RWY0Uzl4S0tPZFhKaWxYTjBDb2JmMVNiUzRROEkwQk1sV1N1bVJ3MWR1bFhQ?=
 =?utf-8?B?eTFsR3NoMWN6eWpweGhYTkFrZlRSL3E5L09uNCt2bkJTREl5OC85SEtTU3Uz?=
 =?utf-8?B?SVhOV3h3dkNOTU5UWGY1VlpYb1dGVTVxMEtXYUtvTnBxT2xNdDdFMER1WjJ1?=
 =?utf-8?B?ZlVSbWcwNHo4Wkx2alAzVHY4YUZCZHBhRy82cmdEd25wNHZ6REV4ZFkrVjgx?=
 =?utf-8?B?Qms1Q3pod1FKcGdBc1N6dm1KQkxVdE9DMHJPZmlQcUl0Y0VFcDJLZVhOTmZu?=
 =?utf-8?B?bGlyckZHREN4U1UydkxxU2FWTlVkQlB5eUhVTUVBV3VwM05iUHlvUE9QMlVu?=
 =?utf-8?B?V3R2akxnZnJGbGk2UG5NcTN1bjY5dGVCQ2NrOUZ0elRoVDJxQ0dPK3UwTElS?=
 =?utf-8?B?MERmak9RV3FQaGpaeU5CWXBBNUo4M200blE3R0p4elV2aFphQXJFbFhDL3E0?=
 =?utf-8?B?ZzhlKy8xTFJJTHZMa01rME9KU1NqUG84WTlXc0VqYW4xV2pWWGIyemdGdGRs?=
 =?utf-8?B?a08vMnJlNFB1ZHBnSnFsanpISlQzZVRQQm5aQ0h6RWZZUGVYdlBZNS9FVkRE?=
 =?utf-8?B?UDU1UTRuSGZkNGd1b1QwNFIzTjN3ZTV4cVNzTEJmVmhYK0lWMVV0WmhhMW9w?=
 =?utf-8?B?SnAyQWc3eVJITkxNNWdwWkVwWTI2WVVnekxISnIrUGxPSytHVklkdFo2UjV1?=
 =?utf-8?B?NWNadGQyZ1NMOWtoeGxDVGhrcjlZNVNYU1dtR3hSRVJCUnBVM3dYbVBwSFBO?=
 =?utf-8?B?dm41UVVNelJvcU5hUjZlaTltV3NXOVN2UzVDN2VTTFlYcnNaNWV2MktXb0V0?=
 =?utf-8?B?U3lTc2tmaFFRK3l6UmpKU2hCRzhzVHgwejdlZklZWVVtZFk5c1VMaDBOSFlq?=
 =?utf-8?Q?F22o0hcbjQt/WvC8=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7306921-8186-4455-8b71-08de6b1b2599
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:15:47.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T70px7VLo9sp/OkjhTO/bu8y2eq3pxSF5KS9DlhR6o7+XnceECOyBZ77nU+IEXcSXTeQXgJ9y09IjtNb2RmP/4h+T/ArV8vmhdAOoQSeHc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-ORIG-GUID: SUte5vFT0cB2jFr5bH-isT9Ba5ogEc7t
X-Proofpoint-GUID: SUte5vFT0cB2jFr5bH-isT9Ba5ogEc7t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyNSBTYWx0ZWRfX6oAH9ruJcrDu
 NrKvmvn9aKjPIMggtUqmRBgg9NdZU/1RXLOobY/Xpv8jVDvpJt3I54WNI2bZ50GJ0vAV8dddeby
 lMr17nW0ax7FpP40CZ0KEQLQ6E+CtVpJRomRfrxJOmczxzQMJH4AAsIdSIqaBGJ4WuBFYRywHZr
 5mQx48/x0fcz3ebsRjegRoWJcwoTwA3NcnWtDGqBozNXqcSg+O6EWFSGmYvXgV0o7iuww8qHn2O
 ryGkh46ctSV916sF2WrqOSJ6PvjVzv6dBGk9FvFsWRIa9DIz6VKdqc1kJ2JbnIyPFF+Gh6Bs6LZ
 ssFhIWVLy1LU8kcPX+osMqSDciwO2Gt5PiWM8QQpvpXqsyvBVKJeQVJpfEKl8bJMZ5K5MHVWEwy
 0TqSo4BlSRQWRArEgmXXVJpQKxnMZgh7jn7b9FfFJJf6W/K3OtaDxlB01iYcJ5OKZxNGAR6kITo
 mpXuPwnf6OF0Py0Xe+Q==
X-Authority-Analysis: v=2.4 cv=SKJPlevH c=1 sm=1 tr=0 ts=698f4e37 cx=c_pps
 a=XqXlOjMxTw5Mth5+b1Cu5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=s_ds23V74E7dMFfK-aAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Simply use the class name instead.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h      |  1 -
>   audio/audio_template.h | 15 ++++++++-------
>   audio/alsaaudio.c      |  1 -
>   audio/dbusaudio.c      |  1 -
>   audio/dsoundaudio.c    |  1 -
>   audio/jackaudio.c      |  1 -
>   audio/noaudio.c        |  1 -
>   audio/ossaudio.c       |  1 -
>   audio/paaudio.c        |  1 -
>   audio/pwaudio.c        |  1 -
>   audio/sdlaudio.c       |  1 -
>   audio/sndioaudio.c     |  1 -
>   audio/spiceaudio.c     |  1 -
>   audio/wavaudio.c       |  1 -
>   audio/coreaudio.m      |  1 -
>   15 files changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 3fc4b516878..06f79ade6b0 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -173,7 +173,6 @@ struct SWVoiceCap {
>   struct AudioMixengBackendClass {
>       AudioBackendClass parent_class;
>   
> -    const char *name;
>       int max_voices_out;
>       int max_voices_in;
>       size_t voice_size_out;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 85a128e2f47..228369cf9a1 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -40,6 +40,7 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
>                                                 AudioMixengBackendClass *k,
>                                                 int min_voices)
>   {
> +    const char *be_name = object_class_get_name(OBJECT_CLASS(k));
>       int max_voices = glue(k->max_voices_, TYPE);
>       size_t voice_size = glue(k->voice_size_, TYPE);
>   
> @@ -47,11 +48,11 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
>       if (glue(s->nb_hw_voices_, TYPE) > max_voices) {
>           if (!max_voices) {
>   #ifdef DAC
> -            warn_report("audio: Driver '%s' does not support " NAME, k->name);
> +            warn_report("audio: '%s' backend does not support " NAME, be_name);
>   #endif
>           } else {
> -            warn_report("audio: Driver '%s' does not support %d " NAME " voices, max %d",
> -                        k->name, glue(s->nb_hw_voices_, TYPE), max_voices);
> +            warn_report("audio: '%s' backend does not support %d " NAME " voices, max %d",
> +                        be_name, glue(s->nb_hw_voices_, TYPE), max_voices);
>           }
>           glue(s->nb_hw_voices_, TYPE) = max_voices;
>       }
> @@ -63,14 +64,14 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
>       }
>   
>       if (!voice_size && max_voices) {
> -        audio_bug("drv=`%s' voice_size=0 max_voices=%d",
> -                  k->name, max_voices);
> +        audio_bug("backend=`%s' voice_size=0 max_voices=%d",
> +                  be_name, max_voices);
>           glue(s->nb_hw_voices_, TYPE) = 0;
>       }
>   
>       if (voice_size && !max_voices) {
> -        audio_bug("drv=`%s' voice_size=%zu max_voices=0",
> -                  k->name, voice_size);
> +        audio_bug("backend=`%s' voice_size=%zu max_voices=0",
> +                  be_name, voice_size);
>       }
>   }
>   
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index a606ce0d4cd..7acbc4d9831 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -895,7 +895,6 @@ static void audio_alsa_class_init(ObjectClass *klass, const void *data)
>       audio_alsa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_alsa_realize;
> -    k->name = "alsa";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(ALSAVoiceOut);
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 72d6194033b..5fc85ae8f5e 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -699,7 +699,6 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
>   
>       b->realize = audio_dbus_realize;
>       b->set_dbus_server = dbus_audio_set_server;
> -    k->name = "dbus";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(DBusVoiceOut);
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index 2f17ab49730..ece7b4acf9c 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -649,7 +649,6 @@ static void audio_dsound_class_init(ObjectClass *klass, const void *data)
>       audio_dsound_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_dsound_realize;
> -    k->name = "dsound";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = 1;
>       k->voice_size_out = sizeof(DSoundVoiceOut);
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 58b9d2f04e2..ae04acf04fc 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -663,7 +663,6 @@ static void audio_jack_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> -    k->name = "jack";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(QJackOut);
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index 20208c71069..f636ab09b08 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -113,7 +113,6 @@ static void audio_none_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> -    k->name = "none";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(NoVoiceOut);
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 0f1c097a666..7e992cee1c6 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -739,7 +739,6 @@ static void audio_oss_class_init(ObjectClass *klass, const void *data)
>       audio_oss_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_oss_realize;
> -    k->name = "oss";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(OSSVoiceOut);
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 2a745ae38f9..0f17df38da1 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -920,7 +920,6 @@ static void audio_pa_class_init(ObjectClass *klass, const void *data)
>       audio_pa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_pa_realize;
> -    k->name = "pa";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(PAVoiceOut);
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 66ca1231541..9bae4eaecc8 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -829,7 +829,6 @@ static void audio_pw_class_init(ObjectClass *klass, const void *data)
>       audio_pw_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_pw_realize;
> -    k->name = "pipewire";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(PWVoiceOut);
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index b404adbc1e9..07b2b2ecf6d 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -469,7 +469,6 @@ static void audio_sdl_class_init(ObjectClass *klass, const void *data)
>       audio_sdl_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = audio_sdl_realize;
> -    k->name = "sdl";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(SDLVoiceOut);
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index 69fa9d8ba54..7c4875247dc 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -531,7 +531,6 @@ static void audio_sndio_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> -    k->name = "sndio";
>       k->max_voices_out = INT_MAX;
>       k->max_voices_in = INT_MAX;
>       k->voice_size_out = sizeof(SndioVoice);
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index 1b67fe2a540..9ce2a612ed5 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -303,7 +303,6 @@ static void audio_spice_class_init(ObjectClass *klass, const void *data)
>       audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
>   
>       b->realize = spice_audio_realize;
> -    k->name = "spice";
>       k->max_voices_out = 1;
>       k->max_voices_in = 1;
>       k->voice_size_out = sizeof(SpiceVoiceOut);
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 217fb9937f8..afe09e27c78 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -188,7 +188,6 @@ static void audio_wav_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> -    k->name = "wav";
>       k->max_voices_out = 1;
>       k->max_voices_in = 0;
>       k->voice_size_out = sizeof(WAVVoiceOut);
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 08bab353831..145c0da1b71 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -646,7 +646,6 @@ static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> -    k->name = "coreaudio";
>       k->max_voices_out = 1;
>       k->max_voices_in = 0;
>       k->voice_size_out = sizeof(coreaudioVoiceOut);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


