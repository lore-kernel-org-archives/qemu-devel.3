Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD15C79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcmxK-0003EN-5I; Mon, 05 Jan 2026 10:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vcmxH-0003D6-Uj
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:57:15 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vcmxF-0000J8-HH
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:57:15 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 605EpWYg3489983; Mon, 5 Jan 2026 07:56:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=utqGPlEuoWhHGwuxU1Np4qoYuZedznQrM9hwMY4QJ
 NU=; b=pw8e7wBR/si1s6zt40tCWli35FFqe0II3nqJ9v0Oo94JpwuNt3t/u+eOT
 3ZP4Z4+AxuXeK2b4qUgFIyYhSKZax+RF0eCCO8JY3ejKViw+FJop0duC37gnbGOD
 ZBbKbMlQJJixiyO2+0KZKSeUTe+PvFWq18aEsbfCezbHB+b/9pQroQDV1SbmWqox
 ndfY1otu3IvZbBMelJmyr6DIcSNwSfANKhVnZWvoYgeeit6wLKPagoJOLhAJbqAD
 1c9hRmDo+/uNtHXJCpIwQrTIT8IeXYx6SqRRwRB1UeHbR9eEstDjs7DMJn/3s6QF
 NmzrTr6L6jgGuGw6TcDtqvLofD7Gw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020108.outbound.protection.outlook.com [52.101.46.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4bf3h1kcds-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 07:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dac9c/JqugYjR8e3K6B93nX7RY8lLWlyv9+noJuH3Jz9+FkuiZrQXJ6ER5xHwp9HKvn1oWHgytjcbHrGyz/WYmX3gxs2lNCg4/2LMdOUhuh/IXbuZWAMQTUf9f+WqvDa2b8SEkftoNarDfqwocZq9hkVvPuMdnoEOzQ15t1G3Plv1Fy+srnObeSXMEwwmeFhbpOXiqAMHg3bisU1Y6onatLma0ovOoUx8Kz02zYhW2ugg2a3/HJHlbsOkUHNdH3/Q7P6Ow8PZDu09uR7n9Cu+3jPUzGvTn7zMFObGQ5m1qz5eKyhcHc4nhe051VP5IkKNNgOTO1q59UeJ+GLRFBzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utqGPlEuoWhHGwuxU1Np4qoYuZedznQrM9hwMY4QJNU=;
 b=YnG4Ga1lxpWTixwsav+CscsjBzvnp+DI1NA1B7aI1ntI/z0hVo9P8kJaOMy7Wi4V3UMFRHKSfvLi8H5miFK1MISJiY5O8XmVzv57aDNHuLMbUMZ7UxF47LvrWRkx3BX+KUn67ZSq/xq7bIHv/ouBIlLJZsyL3In13YBdb1A7SROFZhpc7uUYMLaQ2llJaN2uKIJlKgNtWIiqy+bmNVQ82JB+Sb5G02AFjLVaW2T9yI0exze+hTbaFyeGYEWdzBT0KveUa+E3rIUkQMTW9nnIHo+r80u6djXMRS3LDsr8KNll0xjJmk3yxMgW+WDSpQ+em/wdZOjvSGCsMGu8C5hivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utqGPlEuoWhHGwuxU1Np4qoYuZedznQrM9hwMY4QJNU=;
 b=LvYWT23RLcQ/s360lyGS4nD21B+VNWBUXStVsA8UP3NOXZKeFm8RI8eBJpgmq6uXBqd8E9BY932tmzfd+UpCxH4irOl0gnuCTCUK3m79njqejVpWmxZ6EDAzj5329M0o3QvLLhEScur0x/XYgCUE4GKAtK5ROTzZlsOCWcedCDVmypL9Kw9lfIMRKiDZslXuoUY6RNx6Gl3JE+8sBPu1X/uHYS4CCpu1b+y9UxbZTY9G9MXau8K7TEr9e7XXfhv18xlFf/FYip4K42FAtv3F0Y0xNwFeyY5z1JeqkiQI3T4nGtUurWm/5LzZ/wmNvCt4JiTt1SHzcrD8ZEgoO+de8A==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by CH8PR02MB11020.namprd02.prod.outlook.com (2603:10b6:610:2bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 15:56:55 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 15:56:55 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "philmd@linaro.org" <philmd@linaro.org>
CC: "minyard@acm.org" <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>, 
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, "corey@minyard.net"
 <corey@minyard.net>, Jonathan Davies <jond@nutanix.com>
Subject: [PATCH v2 2/2] hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel
 config
Thread-Topic: [PATCH v2 2/2] hw/ipmi/ipmi_bmc_sim: Support setting fake LAN
 channel config
Thread-Index: AQHcflvqo3unXIH890y8e8vh4T4Oog==
Date: Mon, 5 Jan 2026 15:56:55 +0000
Message-ID: <20260105155648.1037077-3-yunpeng.yang@nutanix.com>
References: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
In-Reply-To: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|CH8PR02MB11020:EE_
x-ms-office365-filtering-correlation-id: d5e8d8ce-c827-4ff8-4c53-08de4c730ce9
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?i0vYbPli+gtDcrvfUTRNUKrV9zUTIiYPnSsvloJl+mlVmRQNeCZsSMeuig?=
 =?iso-8859-1?Q?+ljDxNe7HPe3tZjAk5fFK8KNCQFNQIJgxiclWAnn2FNALD3f0531STopwe?=
 =?iso-8859-1?Q?I+3pStFctcBvPUZfJXyli6his4yRwA3N55u19/0n9WJ96SHynp8aMALDsi?=
 =?iso-8859-1?Q?NNN4xco3KQa4Y5iV6mgWPcb0UqLY8XDJoOtJbQZWNedM5XjJXSEFqAFhDS?=
 =?iso-8859-1?Q?aanlQ7z2M3wDnGNjN6Nm9pQ9ksc/RuEc3cpAQtOoU1lL7DdE3qH2nlzbHq?=
 =?iso-8859-1?Q?FWmNdnc8nr7C6ZSBMGZnwsYedGtIcoGVs00aArM55CpnI4RD/ayMWCJukZ?=
 =?iso-8859-1?Q?I0p9h0unQOhjN9BpWDcZniYSCeG9j6QLdy2OOkUfW660QApkt2xOPOnhlk?=
 =?iso-8859-1?Q?6IGbOgwezAc0devUMJhmWeNFC1AnmJt74GaLw5+Fj0UjtPF5mJIsrD5HcZ?=
 =?iso-8859-1?Q?CK5rGgZnzQ38SNHF++N3iwdFIJB/dxCUVkvRlc+ZGKdnZkqElWry7IWkxq?=
 =?iso-8859-1?Q?pNRmBT+4YzKnQM96vyqrZsXd880II5rJHsXRGkU2SxI2xUqQIwdpbYMeHQ?=
 =?iso-8859-1?Q?Fu7CrdZUJhuEqoqmyVHLVDAtNpWGhqhg99ER2QIx1uMSvypXt9Et4sqhbi?=
 =?iso-8859-1?Q?R3yjbEaKF7XgQhiV3D+Jvrxk6ZNmV8dnicu6StPg4wr3wngw/Z8Qq4D0wf?=
 =?iso-8859-1?Q?TXLGjdbJTBfQzXCT3LtoIXliv1J4iewCWPFEtVVLDO1QMbrVHKTgTu/JIJ?=
 =?iso-8859-1?Q?9ztan4N2DR8sxkyhe9JLc5ufsEsS5JOkIxTlcDd7Zr96/Snic97UIWXkst?=
 =?iso-8859-1?Q?zCvx1CFWIu/LCGnvt/0x16wZEJXW5jib2IhGwa2/H/wVYUjq4uWjrCBsHt?=
 =?iso-8859-1?Q?sHsAYMzPIOiQLMA6y8Dxbg2ol5zAyNre+U0S/yvKT4rxgb46CDiXYOsjh1?=
 =?iso-8859-1?Q?QBvTXpSGBw3kA+wrrqhG9ujVhn/v6LWfWyuHIWNclVQ60QJdxE0UwTwoHM?=
 =?iso-8859-1?Q?nOwbptT0cTMSSKcfSbebiWNKUuCmRMReciU4qGTnzK3C+dA6SVnG+mqyad?=
 =?iso-8859-1?Q?6Q/eusUIhDnmZve+HHMfEzITgPYF1lOJsV0VVwho0bS3q+xHwKHxETiWY0?=
 =?iso-8859-1?Q?hcq/sOfP0FoSGz6IiBkN2E0BhZz/R5Uz8tOZrlSsvW2paZJJ84+WBJN4d2?=
 =?iso-8859-1?Q?cRlS9wXLLXVMQCC60RtKz9NPDLgsifqSZM/W2uPjwlw+iQjivsyynnWk51?=
 =?iso-8859-1?Q?PZ9ExLAfxfFFlBFWd1rHrwOTIJ6pkAgVDYMISmJkV31ruoRwunUQyOu8ZL?=
 =?iso-8859-1?Q?5A0cwT3b6ibn2L49ygHD8QFz2NZerhLa1/6JdDPBlCN9Lit8d0RfnA0nhS?=
 =?iso-8859-1?Q?1WinC38xAGIh54ObL8iyKVtQqKpsL3vcE7w+lQvkzYX9NA8pXHIvZ3xhZm?=
 =?iso-8859-1?Q?GMIVlcFG4aF2W+OWtrnKZjeOM7jud1WgzycDy7lztYG/M0PjByhWdUiWdl?=
 =?iso-8859-1?Q?RCA8hm+9IgBxuMPreAHT7j/NtdTRkuy5TETE/qijA7Qpg4LiXIxxrg/627?=
 =?iso-8859-1?Q?HU9uodkfPnLPgLY7egRdTIp1QFck?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v+Xcslm8GPkD6PCPI1HJ3ULNtry6lNFMk/n1puaoRrup0qb3JJWCWeKFB5?=
 =?iso-8859-1?Q?AXi4kDdu3F+xmnmhQyE8s4v/4NY1m0EK1onGpluzRO6Bgn9eu4C5vfTjTm?=
 =?iso-8859-1?Q?D1pxAEdATfXzj+wzqRxI0hjpmbEIT1q2Dxdkgcy/o7+RXZhNpc3J9wlA52?=
 =?iso-8859-1?Q?EstlyyNIbTemRm/BLP+zrwrdjs9xl34R8czd51jNbPSN3fRB5oVSbFZ2uv?=
 =?iso-8859-1?Q?leZwB2jPy0F/4i0uZumPsx0jfraC12BYmGXsMRoNbCqgQqPiVhqcPsOa+I?=
 =?iso-8859-1?Q?Pn62XRJAmpM0U8aavQRECGOkzGqv6dHt13phOe1iiB2ZmWYIM7m4IY4aj9?=
 =?iso-8859-1?Q?WK5mfBrBlGrZd1p+46JarhVfsJE0IIu59lxqUCR63OBMEWwehilo8QkSwo?=
 =?iso-8859-1?Q?/RASSZeRbeWPKM0k284gW3Q66IbZArmEvHCJlpLfrVKEW0hjW7QUDR+KoU?=
 =?iso-8859-1?Q?F2Ct5d8aGkRf7rtVFJouJePPYm+/ZYvFNQn1cdOs28Ek9hTffiCsXblwtD?=
 =?iso-8859-1?Q?kn3a0zVN60Ziz9R2/w3Nr2I+TCE6PYepQAf7LLnW4QDisx1xCHeBIzt13c?=
 =?iso-8859-1?Q?xLbarPStTfIG0FvuMs8gZRENvzw1nP90hvc/oBlvCpIHJN2w/w870g69PD?=
 =?iso-8859-1?Q?js2dXNS5ewk2BPHgRmWdKzftVyxDEyF67ctnk8Kv0G9nw3H32CkNN7zVU2?=
 =?iso-8859-1?Q?99vcrnOpyVzLlJcvkKc25DzWQYnHlss2YM3w82HMWJ0NI2LrQBydsfZfoL?=
 =?iso-8859-1?Q?KZJBUszJX5eLzQLGpx7ADpf8URhQ8Nd5KJfQgk5XEFhB670WTmvqwgzAUm?=
 =?iso-8859-1?Q?jfBa2B4ZwVcqiNHaMV4zEFhjCGVx6fl3Gps0jQlKKDsbHGRJbOvekx4Pyc?=
 =?iso-8859-1?Q?YYiMLWBTdhLGVbPMSvIr9FYoYi4N3yuGcVQc1odgQYa0R2mtESX5Wl5CuG?=
 =?iso-8859-1?Q?YOj5lMZxp0fZJ5cS0XFPr50JM4W8y07Lx8A/J/G9CffXEgQwt3/z6Wyxdx?=
 =?iso-8859-1?Q?JOmKE0Gp70GJeDvRyRdF8nd0JHxp+C9tGc3kARLH+8olwBXLrD6RX4gdS9?=
 =?iso-8859-1?Q?Yl/0VVe0P2hcViPWK6hQWaMgW3Ye5TCxKbZk/+UDWsb9PiPiMaq5VLKBwo?=
 =?iso-8859-1?Q?5NBVelQDYVCGhhjY3Bi2f5ZmLLFGmg29VcjnUMko5yCV4CUQXwchtDXJOa?=
 =?iso-8859-1?Q?sZwVmezIvsBHyVJqHhWAI5gfY1zNZYC84RQWQDx1PScj52s159WOrOnTkE?=
 =?iso-8859-1?Q?T8AqU1MpqI2z5GTxHWnPTHMocDD/brIMdRq2NGE2mtkcbdr1iSgAi7BjcV?=
 =?iso-8859-1?Q?1O0MWMaVN/uVKd2OsnCPOaJJ4Lqeipqk5JhblWyUuaEHsTXnWD1rdxNmDK?=
 =?iso-8859-1?Q?BdrwVkMywJ7lKBjDORzUVOR0QdZTu/mNGP1b55xn5F2hs0rT0tj3fc34ea?=
 =?iso-8859-1?Q?clnJXkjfSunKyFvIsvsaPz3lB3XslVsdS/bXx5eRFzMYYoGGmvJ0WcAL5M?=
 =?iso-8859-1?Q?hmN/9coKEWR3tgdl2bQZ80RBB6snoZMldIJCxXWMXiPK/xiXoDl1laeSpe?=
 =?iso-8859-1?Q?EmcFTacO0hNHrWLWGjGSJo5eFzFkfhqKLJw90fLKtwbHhJkLKMv8RfTqF1?=
 =?iso-8859-1?Q?symDjxgYdY4QPPT9LZrmuYX0CPgLufcMWMAVhQ8wm36OiLomVq5Huz8/Sa?=
 =?iso-8859-1?Q?A6Ed1zZDqTyCJCU8JpghVlzt86onBYnLTtHjp90bsFoQ8dluticK3+lFj5?=
 =?iso-8859-1?Q?QfoqByk3eAJyFanYHirHzObIgK5ME+29BLOvbt/ViKAvydJzpbQb3n4t5p?=
 =?iso-8859-1?Q?KYZYgpt4SrHQIJf6nRiaxBg0+hh7nKM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e8d8ce-c827-4ff8-4c53-08de4c730ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 15:56:55.4405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGGFvFDVh9gEnjOolQu+lf8WX6LFcvfh3RSKhr4US/k2fcShOHQniqI0tSS07kpSTN+YFUr2HR/23qOBc7dB/845hZkEVc6JICLXecsD8Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB11020
X-Proofpoint-ORIG-GUID: qFo9Fx9W-ARA7GaFc9BNq2BH4AVm37uO
X-Authority-Analysis: v=2.4 cv=QcBrf8bv c=1 sm=1 tr=0 ts=695bdf49 cx=c_pps
 a=wnlGNIUL0AhmB29u2vspYA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=XT8gEEquJfDF-nft9kEA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOSBTYWx0ZWRfXxXlus3ondhd3
 N6PNtfwsMhxtlqHw/msVhKPyQ/4wdrMLt5lqQACb96h1zYpF4XtSaSAxng9iEDjt4Gjhm8l8BvA
 eqU0FLmcBSA6Gxm0Q4+SgxkkBdaqjKCLWnKsfJDYfiDvHUH7Sr+5Pl3L1kiaSG2YA0bjlPueSxR
 0+vREg/0arB7UTEh9JGztmYPatTHs0iX3vDAkTHGRU98ELyS1wio0lfvn7X3OBPAyWrwX/GFUsp
 o90rywnkD4Cxd2XONy5dETNQKHCP7T58vGNFeI+VJI6NSZlP4sPQb9DW1s2Shi9QSIaIwMoSivE
 aFMw7Pen76JmtNoMOjGAqRW6pQOMH52W1kSUgQkwpu+IohcYYPhNL9LWa8J9Mf1mCNQaGPgaF+P
 +xMEFyE/X3V8Fi7Tjl5mueYLOkHEvqFJC/oCNWU3mSQ7KEa39rQ0lAgkfIqOpt1B1cLjKEdoOI6
 rOE2UNc3nthCxXtaKLw==
X-Proofpoint-GUID: qFo9Fx9W-ARA7GaFc9BNq2BH4AVm37uO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The "Set LAN Configuration Parameters" IPMI command is added to the=0A=
`ipmi_bmc_sim` device to support dynamically setting fake LAN channel=0A=
configurations. With the fake LAN channel enabled, inside the guest OS,=0A=
tools such as `ipmitool` can be used to modify the configurations.=0A=
=0A=
Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>=0A=
---=0A=
 hw/ipmi/ipmi_bmc_sim.c      | 110 ++++++++++++++++++++++++++++++++++++=0A=
 tests/qtest/ipmi-kcs-test.c |  83 +++++++++++++++++++++++++++=0A=
 2 files changed, 193 insertions(+)=0A=
=0A=
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c=0A=
index d88aa22b72..012e2ee4fe 100644=0A=
--- a/hw/ipmi/ipmi_bmc_sim.c=0A=
+++ b/hw/ipmi/ipmi_bmc_sim.c=0A=
@@ -106,6 +106,7 @@=0A=
 =0A=
 #define IPMI_NETFN_TRANSPORT          0x0c=0A=
 =0A=
+#define IPMI_CMD_SET_LAN_CONFIG           0x01=0A=
 #define IPMI_CMD_GET_LAN_CONFIG           0x02=0A=
 =0A=
 =0A=
@@ -300,6 +301,7 @@ struct IPMIBmcSim {=0A=
     ((ibs)->lan.channel !=3D 0 && (ibs)->lan.channel =3D=3D (c))=0A=
 =0A=
 #define IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED    0x80=0A=
+#define IPMI_BMC_LAN_CFG_CC_PARAM_READONLY         0x82=0A=
 =0A=
 #define IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS        0x00=0A=
 #define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT      0x01=0A=
@@ -2126,6 +2128,113 @@ static inline bool is_ipv4_netmask_valid(const void=
 *buf)=0A=
     return netmask !=3D 0 && clo32(netmask) + ctz32(netmask) =3D=3D 32;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Request data (from cmd[2] on):=0A=
+ * bytes   meaning=0A=
+ *    1    [bits 3:0] channel number=0A=
+ *    2    parameter selector=0A=
+ * [3:N]   configuration parameter data (from cmd[4] on)=0A=
+ */=0A=
+static void set_lan_config(IPMIBmcSim *ibs,=0A=
+                           uint8_t *cmd, unsigned int cmd_len,=0A=
+                           RspBuffer *rsp)=0A=
+{=0A=
+    uint8_t channel;=0A=
+    uint8_t *param;  /* pointer to configuration parameter data */=0A=
+    unsigned int param_len;=0A=
+=0A=
+    if (ibs->lan.channel =3D=3D 0) {=0A=
+        /* LAN channel disabled. Fail as if this command were not defined.=
 */=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);=0A=
+        return;=0A=
+    }=0A=
+    if (cmd_len < 5) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);=0A=
+        return;=0A=
+    }=0A=
+    channel =3D cmd[2] & 0xf;=0A=
+    param =3D cmd + 4;=0A=
+    param_len =3D cmd_len - 4;=0A=
+=0A=
+    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (cmd[3]) {=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:=0A=
+        if (param_len < NBYTES_IP) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.ipaddr, param, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:=0A=
+        if (param_len < 1) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(*param)) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+            return;=0A=
+        }=0A=
+        ibs->lan.ipsrc =3D *param;=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR:=0A=
+        if (param_len < NBYTES_MAC) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.macaddr.a, param, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK:=0A=
+        if (param_len < NBYTES_IP) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        if (!is_ipv4_netmask_valid(param)) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.netmask, param, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR:=0A=
+        if (param_len < NBYTES_IP) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.defgw_ipaddr, param, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR:=0A=
+        if (param_len < NBYTES_MAC) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.defgw_macaddr.a, param, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS:=0A=
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_READONLY);=0A=
+        return;=0A=
+=0A=
+    default:=0A=
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED)=
;=0A=
+        return;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Request data (from cmd[2] to cmd[5] inclusive):=0A=
  * bytes   meaning=0A=
@@ -2324,6 +2433,7 @@ static const IPMINetfn storage_netfn =3D {=0A=
 };=0A=
 =0A=
 static const IPMICmdHandler transport_cmds[] =3D {=0A=
+    [IPMI_CMD_SET_LAN_CONFIG] =3D { set_lan_config },=0A=
     [IPMI_CMD_GET_LAN_CONFIG] =3D { get_lan_config },=0A=
 };=0A=
 static const IPMINetfn transport_netfn =3D {=0A=
diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c=0A=
index d0a207477e..9bab0d84ad 100644=0A=
--- a/tests/qtest/ipmi-kcs-test.c=0A=
+++ b/tests/qtest/ipmi-kcs-test.c=0A=
@@ -318,6 +318,88 @@ static void test_kcs_lan_get(void)=0A=
 }=0A=
 =0A=
 =0A=
+/* set/get ip address: 192.0.2.2 */=0A=
+static uint8_t lan_set_ipaddr_cmd[] =3D { 0x30, 0x01, 0x01, 0x03,=0A=
+                                        0xc0, 0x00, 0x02, 0x02 };=0A=
+static uint8_t lan_set_ipaddr_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+static uint8_t lan_get_ipaddr_cmd[] =3D { 0x30, 0x02, 0x01, 0x03, 0x00, 0x=
00 };=0A=
+static uint8_t lan_get_ipaddr_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                        0xc0, 0x00, 0x02, 0x02 };=0A=
+/* set ip address source: static */=0A=
+static uint8_t lan_set_ipsrc_cmd[] =3D { 0x30, 0x01, 0x01, 0x04, 0x01 };=
=0A=
+static uint8_t lan_set_ipsrc_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+=0A=
+/* set/get subnet mask: 255.255.255.0 */=0A=
+static uint8_t lan_set_netmask_cmd[] =3D { 0x30, 0x01, 0x01, 0x06,=0A=
+                                         0xff, 0xff, 0xff, 0x00 };=0A=
+static uint8_t lan_set_netmask_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+static uint8_t lan_get_netmask_cmd[] =3D { 0x30, 0x02, 0x01, 0x06, 0x00, 0=
x00 };=0A=
+static uint8_t lan_get_netmask_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                         0xff, 0xff, 0xff, 0x00 };=0A=
+=0A=
+/* set/get default gateway ip address: 192.0.2.1 */=0A=
+static uint8_t lan_set_defgw_ipaddr_cmd[] =3D { 0x30, 0x01, 0x01, 0x0c,=0A=
+                                              0xc0, 0x00, 0x02, 0x01 };=0A=
+static uint8_t lan_set_defgw_ipaddr_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+static uint8_t lan_get_defgw_ipaddr_cmd[] =3D { 0x30, 0x02, 0x01, 0x0c,=0A=
+                                              0x00, 0x00 };=0A=
+static uint8_t lan_get_defgw_ipaddr_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                              0xc0, 0x00, 0x02, 0x01 };=0A=
+=0A=
+/*=0A=
+ * Set and then get LAN configurations=0A=
+ */=0A=
+static void test_kcs_lan_set_get(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D 0;=0A=
+=0A=
+    /* set ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_ipaddr_cmd, sizeof(lan_set_ipaddr_cmd), rsp, &rsplen);=
=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_set_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* get ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_get_ipaddr_cmd, sizeof(lan_get_ipaddr_cmd), rsp, &rsplen);=
=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_get_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_get_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* set ip address source */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_ipsrc_cmd, sizeof(lan_set_ipsrc_cmd), rsp, &rsplen);=
=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_ipsrc_rsp));=0A=
+    g_assert(memcmp(lan_set_ipsrc_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* set subnet mask */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_netmask_cmd, sizeof(lan_set_netmask_cmd), rsp, &rsplen=
);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_netmask_rsp));=0A=
+    g_assert(memcmp(lan_set_netmask_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* get subnet mask */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_get_netmask_cmd, sizeof(lan_get_netmask_cmd), rsp, &rsplen=
);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_get_netmask_rsp));=0A=
+    g_assert(memcmp(lan_get_netmask_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* set default gateway ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_defgw_ipaddr_cmd, sizeof(lan_set_defgw_ipaddr_cmd),=0A=
+            rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_defgw_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_set_defgw_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* get default gateway ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_get_defgw_ipaddr_cmd, sizeof(lan_get_defgw_ipaddr_cmd),=0A=
+            rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_get_defgw_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_get_defgw_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     char *cmdline;=0A=
@@ -340,6 +422,7 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("/ipmi/local/kcs_channel_access", test_kcs_channel_acce=
ss);=0A=
     qtest_add_func("/ipmi/local/kcs_channel_info", test_kcs_channel_info);=
=0A=
     qtest_add_func("/ipmi/local/kcs_lan_get", test_kcs_lan_get);=0A=
+    qtest_add_func("/ipmi/local/kcs_lan_set_get", test_kcs_lan_set_get);=
=0A=
     ret =3D g_test_run();=0A=
     qtest_quit(global_qtest);=0A=
 =0A=
-- =0A=
2.43.7=0A=
=0A=

