Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659A5C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDL2j-0001qJ-Ts; Fri, 09 May 2025 06:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uDL2g-0001q1-KT; Fri, 09 May 2025 06:33:22 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uDL2e-0004uh-CW; Fri, 09 May 2025 06:33:22 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54946CBL015994;
 Fri, 9 May 2025 03:33:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4K3jw2kiu+vyQhz+e+7P3Fd652KvAIyD+YJbAr6E1
 io=; b=Vzq3/bWX5NbYTFuvn8rvqhXRX3ZMAz9PLrAP7RcvohYDK23Mpv1gRIaZx
 5o+K5r/BYzwX/51LX0MxH6iBhoij/ps7p7RkMmrQsHdgQEyDYmPwbSCj+SPqagtg
 CJ5y5ySqYv1rx+GfTHIcriwJxNWkMW4kUICe1QGw5+0DmrvJEZyE7cvtkdIh6+HL
 bA/kZSTY15Td9tIhCWhnbBOgUXyYGcAsnYe3Rfj3iohwAQU3Uxkomsr8ddS5IJiQ
 mDN+poAtnU7xIMXE6JiwEXhrZuXKGmXY3jIWJ2izXl8QzlYfe49w4dexuJGAazTR
 /BEcAa13LRWll9HA1/2qxfkjI6X/w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46hacqgnhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 03:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLpYyJ/8MNkSj0+inOi2HG/Wobu88hna54WmNlSdeqNLLUc05rsx5D1dwVuagRH2gDql2EeVAQIXz4X8ieJR0Jubgw2IESJ3Zz00RNPKP6g/6PuvTwl+gJINdILMfSwV36OUgyk495ayttwrYMsnewhULHt1AnL127VlqtkFarJBL5W6Ev7ZRuOyKyce7Rxge79qOEqrHeQr5/HOjmqCK3y6OnKGXc5yRUTmJSFNLifvVYsV2+WEnntz/cNZeegRWIQSY1ryEHPHtd52XD5uK3LdZnYwJCqjtz2oLULD9YiXFuOWyP0Kom3A+bWEh7tSsvqEkB0cLJZhYcTcAvsGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWhu/VJYUUkncSSOKhL9Jp8WsQm80X6emtsk46/V4do=;
 b=YN/eH63SGuvQKo+6JToMhDjdcEzIk5bOFBxQFUHuDm5aFXp7dTlpgftojupKEVDR5OyCdO+5lSyiuNMDcDaseE/E3xRN57FNJ+W//TxYpRpOcORdfk6Dza225cZ1X1wkWnstg/4f/1ynDvyaF5zPn2olUXkYQ3ScgjKMUAYmhN7EZz+HNy5pj653rmFRIupWIQiQ6RyGk8ywLhnIlBqNOWSCZIU5SGIo4lhs+XTavQ3xw/v8g66oRWL+0D219+GPH/tbao3Y1Ike6IqAjsyD/DI4yBTxc9SsohuM7hCXU1Miqeul9IUojKMVGZfWenmjoaRem5I4Jf6SHAN0fquLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWhu/VJYUUkncSSOKhL9Jp8WsQm80X6emtsk46/V4do=;
 b=weVzZUWDl/6ns2bbWnYb31/zrZpz20jApy2iQjmRikwJYGUoyB/U4/rX2XcMBaUSVAgjiUE3akSIqIxtfEjebRF0baWtttrV0BRVjHLAsXy7xi9BFwzrCdz4h5cQVariJ5z/mU6emhV623Gpz64mFJYHhfK2hqYVTPJWqASh5PDacZMynWLaSiePzmFlYBK7Fl09nWvJsXl+8wmwdHr6xqJycQ3rUr9Rts6C6ZPL1X3MPznS7MRi4qSMVyw2/K4h+D0HCjZb5F2VtHIsrP5dPadWW9V8f8u7b/BLmg0I8obci08dXKmYU5zsspd6/AWFUC6g1sHfz56be6eEpRSBIA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7567.namprd02.prod.outlook.com (2603:10b6:a03:32c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 9 May
 2025 10:33:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 10:33:03 +0000
Date: Fri, 9 May 2025 11:32:59 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>
Subject: Re: [PATCH v3 12/15] vfio: add read/write to device IO ops vector
Message-ID: <aB3Z23QAMm7fo88z@lent>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
 <20250507152020.1254632-13-john.levon@nutanix.com>
 <0fafad9b-d6b6-4316-9012-62808c5f3ef8@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fafad9b-d6b6-4316-9012-62808c5f3ef8@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::37) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f52863-96c2-4fb6-cf76-08dd8ee4e109
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RXaJruFrxw0zBcGVRjGWsq/Lmohm+TZ3RSYQyIQ2hoS3fxUunWX/3spU92?=
 =?iso-8859-1?Q?g7vnFe2NlXDZRdkpU5NnCazVwFRGRo1+n+Vdxo8cFBpgeQG4KvzRuo+CBI?=
 =?iso-8859-1?Q?xnXWdjWnRM1HVSi1XMoHD18yxq6UZ8BIBQtp2lx1KZQPwOuFFZCoRJyPNw?=
 =?iso-8859-1?Q?2LF9mcon228uLZXkyGGyo0Q0wCn0Dq/6WpwbMoTFCE8PAFkZONFtddJD6k?=
 =?iso-8859-1?Q?hQnYn9LbH6jWOPF4Fg6Xrw9MTskXByqIkx/p/ZM7xZqfQI0qiOX7AK3bQd?=
 =?iso-8859-1?Q?0C+QUVM+dkBCjqAs4QEGD+znZhg3xYzfO8e0w1muBr+lp0ZnYyz0REJxlt?=
 =?iso-8859-1?Q?EoVVqm8EyrdCY3OKurFQaXZy8r79xaqZOa+WFRqlMwQsKjIa6ElHeDfbB/?=
 =?iso-8859-1?Q?dI5G8/qPjPXYD8pP2ph5wroli1h78W0IQnSS6zCMllL385oVJtdpE+MR68?=
 =?iso-8859-1?Q?eCz9MIGHRKfYM1Ry1S1ni5Xr8tisExzUw5Jf4+NhtcP4gwWIXDzMwpUd7f?=
 =?iso-8859-1?Q?h737mGdwyTEDUaKB57r9gHog2MK98p81wA7AHs+zwffWCcrrPTWRXR4O+A?=
 =?iso-8859-1?Q?UuYPxRWoscEOoAHVpR10hZG0rS58Xg+h/Sy2dBUwAcsoN0qmh4WhkSvRdu?=
 =?iso-8859-1?Q?+yKCBBPYEBIb6f0U67sBvo5YckywJYpFv7BGSJwwWV7O02iSgRA7FthiLl?=
 =?iso-8859-1?Q?GaV4KpXqw9twE7SLzcvGtI3sFTBRlBi4qrHVqEPkkJvRscTiXlApD5Pk2P?=
 =?iso-8859-1?Q?LaxdlMjjeRHU7HICOTVw+sVo0nIhE58xcxjELSY9HPFbJYcSQq5JRXJhwP?=
 =?iso-8859-1?Q?Kg40hu15cNChXz7o3EFrFFi6pFYY3zhhqYsjyqJ5793Oaz8xwPLiofuRRg?=
 =?iso-8859-1?Q?lQhOnC//nBH8eQCW9joSg3GV7kTUMbqcFI9QKO+AV5b1FkwgDRkZVq32qP?=
 =?iso-8859-1?Q?2e+rBNOAcVfNYLSW5iN0ium9qmMz4ZIoQPRx5EuE6sWYauLw6uHtrrLKXF?=
 =?iso-8859-1?Q?dxRphTs9IDGLHvihbNBPZdFpfu3060k/t6Nt1hsVCu+BN/uGUSFc29cT3J?=
 =?iso-8859-1?Q?N3eTL8LXHfmsuN+xRg8Myo1vhOSOvLXWM8q725Hr4R7e/wCYxe3gV7iJmC?=
 =?iso-8859-1?Q?lhYGpdXTBHPoMutnTanEKDId5VpT6mJE952VDOQ5IsIG4s+TDc+SbLxO06?=
 =?iso-8859-1?Q?imMsHSzIB2y/ZhqiMvPi6hDREJoiH6Asy47ba8zqd4XR+Vuo6lgkE7bB7g?=
 =?iso-8859-1?Q?uLQiBuy5LwmCUEp+Epj2kKG9BtUvnNm7OHYNb7UZsI7K348CLF0nOW94OU?=
 =?iso-8859-1?Q?eqMTVtOwe7wMmKd8ULwsygzmzdYJSoB/blpdGPJWFep/a1tNwRXpCeJwRu?=
 =?iso-8859-1?Q?o2fUdUdfKd0Vn7S9Wge0kIdVOmtgvEpiCk1VG59+onzFdjcd/riyV8whGA?=
 =?iso-8859-1?Q?v+vrCfd8C0Kw4Kcf44QqczokJ7ls3sHO/aqmLghcadAPavBkEVyfuJUQ0D?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?H8ck6O9XbzmzbFFAc1Bn80TT/GRZI5GEXAX50m3I1Ce1nyvmJDyPOOaNqy?=
 =?iso-8859-1?Q?svimXmq6ojYogJQGT31jhb0xGiZ6xTJUCBSAqjt2YgDZMKE4BjUY4fxB55?=
 =?iso-8859-1?Q?RvPelX/Dg80xci9J7ttERUKaFjfsS/e7iYDUCDgpFBr9mouvHXqkP1zViQ?=
 =?iso-8859-1?Q?t08saa0M3YwmedeG63wKcsXIfMKaOAzW8H4ebvEMWhoSym6ABvSZDcq0vO?=
 =?iso-8859-1?Q?ctFKieoHBN6VCuvBmoLmDpGrLx7412FCQs8VP5RjCQV5bAk4soK8LjfjEf?=
 =?iso-8859-1?Q?5tTP79z+MLC6AlF/ooDo4oqYXfHVf/em88UVbZaWQuzL2rUX6kriUhgL6l?=
 =?iso-8859-1?Q?BOJUYoq2ZrjQkZaBeZ4wXA3ETPsZZn5WTlz4E0WIXDmzJeTbU/8KpzGdbo?=
 =?iso-8859-1?Q?qjlcv063rW+R7PmKrC6sqLe2DNEDiTZ6qAR8+Z0tgnIeap80g00C4ErqIy?=
 =?iso-8859-1?Q?PoE4YhgvmhXdCeD4+3yJJwTJBuYtq60qYeGqBUpeyA/WdCkiC2wzUp+kp1?=
 =?iso-8859-1?Q?jZggk4cWYthQ44CyYbt+UZOuY36G8O1otFukl8I6AnYWrUblKPzYT3s8Nq?=
 =?iso-8859-1?Q?SHsF7UTnNnw/Ari3bWN5+cc63CPcuQ1FftuSdaLzd4cvbNxNCQPXqzG8zL?=
 =?iso-8859-1?Q?jrUroQrlNkFxWB89okyWvu8UpY8G/wK3pnTr9yCeRy15v3nkjVoug+S5Fx?=
 =?iso-8859-1?Q?irur/Z4sAqu3Le4LqmPf53YNJdQf0OUN4jv6gaPD48bGM0Bg1Xn5Gmj3Oy?=
 =?iso-8859-1?Q?PZmNL+on5dQ/OVTiqqJFuUymSfBoQ3nzxYWzxVb4JbcmjG7PGHf3WRTr1Z?=
 =?iso-8859-1?Q?vKUAnBIsPIJagmu3yRiRi40DGVAJ/7V3VULzmAlsRjIJDZGYj5Xt9ydzrI?=
 =?iso-8859-1?Q?McDPtp8h7nubQc13x8lPjkcIKXYUNHlShnU41tJZYDsqNmJRaKT2fTTexy?=
 =?iso-8859-1?Q?G2+b1aumxdtbM0k6RIE49SqrIkwyWhFIFewBPU6E1TgdIBVn6umtjqjPH3?=
 =?iso-8859-1?Q?jR8i/TCv6Oh5hUPGQ/XdOJn8N6TREjgQlJ4iotCKt6M1zWiqGOzmzgfh8Z?=
 =?iso-8859-1?Q?0/cUWTpIthgQx9BwCzL8o2SCWYIhYDj4GKj8lURBF5LtC2eow8yHsYnaZQ?=
 =?iso-8859-1?Q?62gAx1XreCBaa6DS20Ga/34eyiWLW57IUbp10gxZ537BWJG2zRVBejSd/W?=
 =?iso-8859-1?Q?uU1mBiqeJQ7Zlxv/MT1aWTjgfZMjAdYGozxdApivfKKkgayv8kfSk4n+gT?=
 =?iso-8859-1?Q?tEzKh64ydGffx6jdQnmwTwS38MXbGN58xtot2NkkMdNZup/l2bO+SsjcRv?=
 =?iso-8859-1?Q?szrIOggi7Q9aWQb7BFH2h/ARDUXBPMtb0T7yQZjlwq69cNACM8GTWKgLQB?=
 =?iso-8859-1?Q?nxxLxgLT2bbgmSWcqAyF2YS9KhDqgyyT23FjLOxbl444srDZI9w4NrKm4w?=
 =?iso-8859-1?Q?3BAq3oJxqXCclSRpJq8Ro6dgWK2k3KkZiaI8N3UD43B7+uQKXkY0aQ6wAC?=
 =?iso-8859-1?Q?jyKCu1eY+FXuKlN8In+8Qc4GBK4wc1o/Hh15QJkBkWwBbbeWB9gbBkffQY?=
 =?iso-8859-1?Q?i8OGqqVU+0dhAdYJy3wsC2SVNFWiNIN8Sv/qwZ33OXeyQYmRw58GiCQ4nv?=
 =?iso-8859-1?Q?rydwbWffSBdfNhKRxwfLiCbd37OfWXAU5c?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f52863-96c2-4fb6-cf76-08dd8ee4e109
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:33:03.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfcbf9/g9uTQQN0o3T7E374erEgrIE74ixBIBkd+9N2CODxzNLWPJ95L+hAkh6C6uVuOf3GVvu/Ql/WBFJ5XFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7567
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMiBTYWx0ZWRfXzK2Wv4FvrZld
 lwdmcrHHrzAabnYKwXgMtfVuVGlytSdC3aaZUhAE1VnHzlb0ukYjWrFS2qeoId/E6PAD6TfWst4
 X33YRrpmq9x/naox7Dk5L6b7huTFFnqIuiaOaUPNsZZ5MfK0mUEN1F7Cmbb6RoTKanKzaULu/W1
 PYAHLKeSS+p4gnI3x3r9BXr58XlUlmlGjuNxNyPECv8i0qtMoSZ3zWlmxfkLAexbigOrTsR5BwS
 TtAWTgErCT8PEEru6SHQ5F1Bv7yE0mTMaknu+DQltTbJWWOfrWmRQcxuvdQMM5mCuMVGaF7gRg6
 ODr6a4qEL0FHhhVVwlJ2epAIE5LEEk7BH54XCDnfc6OCJfglDnIv6sIhWDCgKhKqXfjuewj5kfu
 jWzr36BgrrTSvJaTjfaSO4cC6a0ssq+iBbUEKntMpghlb2EMTrwMYziDhLtqd6alFKo8HJW0
X-Proofpoint-ORIG-GUID: Ecund9ISrCMOy5NVVvxWeh7mAsBox0IW
X-Authority-Analysis: v=2.4 cv=KK1aDEFo c=1 sm=1 tr=0 ts=681dd9e2 cx=c_pps
 a=ybfeQeV9t1qutTZukg5VSg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=uJFSXs1iG0LMZB55D14A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: Ecund9ISrCMOy5NVVvxWeh7mAsBox0IW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 09, 2025 at 12:14:02PM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> On 5/7/25 17:20, John Levon wrote:
> > Now we have the region info cache, add ->region_read/write device I/O
> > operations instead of explicit pread()/pwrite() system calls.
> 
> No S-o-b. Please reply with one.

Apologies.

Signed-off-by: John Levon <john.levon@nutanix.com>

regards
john

