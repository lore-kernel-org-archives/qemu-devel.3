Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05684CF9C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 14:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stTQG-00047R-Ml; Wed, 25 Sep 2024 10:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1stTQB-00046k-3i
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 10:55:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1stTQ7-000736-Tj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 10:55:14 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PE0WXx028408;
 Wed, 25 Sep 2024 14:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=XS5KzdiLyYka0DURkzeET1mHBISJ4YrUXFP47F4p/P0=; b=
 S3bXSE5ZSSwE8N5+au6XN5j9ET9Aurv21tXF26HDBDg9S4EP71wC6sofvh5v10nc
 a96iBauC7R4hw6eLdEvzFUso2EaoX9J5GFLiI6otigC2dslEsTUbpJ2y+klErJ3Z
 0KpGmYoiji/zi3uKLEzDa3dlVGMCwu4NTAjZmx22CUgQFwmj3vfDDi5eilYzPbNS
 nVPvOUSSeKgGTp5TjFzG9KFDnaoSBc3wO5DBqswXwvlaFG1KKTiCancUdBdllNf+
 H/9HV2aPQQC7eIIOa1m6fDVrYAnMT4L76if5jQTDpxS/nCPwuZSwVTuMxIzUs3GM
 o265zLJ2VsYsn7ZqtEUukA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx384ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Sep 2024 14:55:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48PDYF9W025246; Wed, 25 Sep 2024 14:55:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkatea5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Sep 2024 14:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI5NX80I4UuQw2s6MV9zmUUmlhZ2o8VCFIPb7r2iqLOKb/kI5w9sKphskSKQ59BItzH210E0S1dFvzCHV8NB0JfNIr/+gkopDe5/Kjykp5Y+j1DHt2a7TiKfDz0qMLO9TtOrh7bAlCu5yij8s4bLK4OX2iXApPG5mlX1FCiiiXOYd4hA3m1MDl2g3zyxJuG0PG/ymm3FZ3ehvF3Uzuu/PEXkvf6YQ6b6WQMYQnyG9xa6J64gF5HIobarihozn0ZI0Ak/pOEaJMZEmj7jzLPa9ixc4BuiQZFUMVDvyoeT6JC4IFt+2adBqI36T5JINCv6Sb8F+nCFzBL29sSkQwa+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS5KzdiLyYka0DURkzeET1mHBISJ4YrUXFP47F4p/P0=;
 b=dKIJu4KbeHpx0nVGQzAXoV6F3pptbSpjZqHWct7hCDb8b68bAGr0o7FJFPEvw4M30lqEBO5UkQoMhcXX/QES96YhtIljiRm9GOPDe6HZVdz6II/hdF2Xt7tQPmtZoQv+C/HUg2wWukWBvX0+ktprVsYXBcb3LZZLXi1/S7lXqMxHHk/sKJGpUvRj0gWfvLTU8m3xlrbNCDAsiRuo6OqNUGH4QSayFPtPF2QS/7VzcwBotVxZDvRkNqg9QDg6sfUripKYPeL0R4+Pq3EK/DnoAlXdBhwMHVO9yYM8HAGtXZdAqnBWUekG6XeGZHEloEWreTp5dciffn5Pt3dThh3xBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS5KzdiLyYka0DURkzeET1mHBISJ4YrUXFP47F4p/P0=;
 b=c+Yfy6zxabsjjye7snpf/uSw3gu00HRXW8uXweZqCMrJuOyKdSq+2ysp6QV9S1ASonakzvMCr/hXtuxzYCXS4XcRBgq2rDGI3n80gkMBUAPDEE8yVGE4mMy50BduOoVlWxyn5xAB5dgfnzbodzdwi5qWvRUnxCVHOfJGJVc+lPA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB5796.namprd10.prod.outlook.com (2603:10b6:510:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 14:54:51 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 14:54:51 +0000
Message-ID: <6ad69b50-7c5c-4519-b6d1-745621459ee1@oracle.com>
Date: Wed, 25 Sep 2024 07:54:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, boris.ostrovsky@oracle.com
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
 <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
 <CAJaqyWcFBxF4+LzC7EDXgFsp+dUNaWmzOqY5x8dav88LM6LhCw@mail.gmail.com>
 <febc124c-dd19-4ae8-ad84-b77dc4e399a7@oracle.com>
 <CAJaqyWcLqHe_+K=DRXxkVqh3bpa9yS5P9sLgLOXUXTHcJ4fMLQ@mail.gmail.com>
 <93efb6c5-0985-4db7-bde0-11e1d9f692c8@oracle.com>
 <CAJaqyWeDvA4HejwEUL=1teSv34=ZQLWZuXKB5vRRv80p-QUMEA@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeDvA4HejwEUL=1teSv34=ZQLWZuXKB5vRRv80p-QUMEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf7e33b-9922-47f6-7dd9-08dcdd7201e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGxTVUtsTzgwNzRienlJQmpUdm8yWEJJSE11Z1MwckZwTHpnVUI5MVpkSG9B?=
 =?utf-8?B?TTY2SGRWd0JEcWtoREIxRXNVeG9GZmVNWHNnOTVhM1VSM0VXSDhFelMwaUJv?=
 =?utf-8?B?VEk0QlRtY1d3UVVwcTFjdTh3OGlYc1pPdTR6ZEM5aXFmcmNnS3pvSnk2VVJZ?=
 =?utf-8?B?dDU4MnhKN2crU0RNRWtzS3Q3QzcyLys0VnBKeERNeVZFS09PYkkzWDg0bUU4?=
 =?utf-8?B?Z0dHL1p4Z0hjaldnOXF0c3RLSVRjZUhPdllxSmRLM3dWRzNIZkJVNXphTXlU?=
 =?utf-8?B?MEFCSnZLM0lzc2JQck1DZkJuQVlqY0hLU2c5NEFoWWxjMFpVRm1pVjVJaEZh?=
 =?utf-8?B?MFB1WmdUaTB1QTY4bUk3SzRUZjh0M25nS2JnR0dZcXJYUmVGT1hIa2JmaXhY?=
 =?utf-8?B?UDAxeDczV2VKVVhCQnB5bjdyUFRON0NGY1ZyaEE0UHhBd1VuRmhncnFieTda?=
 =?utf-8?B?TW8vNTRvNEpENU1YaldsU29SbHlWRmpFSFlURk80WWFETU53aXhacjB1dGRo?=
 =?utf-8?B?cjJ5TUNtcitwdmtEbWppMHQrZG1CYzZRKzNqU092Q1RpYit4Smt1VEwrUUR4?=
 =?utf-8?B?SGlHSTZPbDY1NnlIRDBjMUxscHlUaWZmT2Jtc2pwcFdsYkNYc0hSL2NDTjFW?=
 =?utf-8?B?aG5iSEhsTHViYUNKUDBuN28rT21sdE9XVVBqUGJDOFhLTVNzUllFZzhqbnhC?=
 =?utf-8?B?UXc1SnloOUhFVHNzR2ZFNEJSQUFpTWloeHg5dW9OQ01kTk5ScDR4OTBwUHFj?=
 =?utf-8?B?SGUyVWwxV1dac2xVbmRMMDgydTIxNEdjZ2dkajZnT3lYbzdJUWtxaTNxMkZP?=
 =?utf-8?B?RWJCdGNZZFRmWWozUDdxTzRZWVNVUU12VWlKT3ZXMG9pcWtXNll4MHdiQVpV?=
 =?utf-8?B?UFA5MkNHTnB0T01hUUFmKzhSejF5ckh0b0pndGYxNis5d2pqbUhyeXhzTTV2?=
 =?utf-8?B?QW1TTmYxVytGNnZvM0lDbWQyQVY4Ulk5WFBNMFRlOWNCZE5vNkJoZjRob2NG?=
 =?utf-8?B?TzY3bmN3Zlk1TEF5OHJYKzZycmUrc1B3TjdQTmw4QXZtNmtUOTBiN0FVSnFG?=
 =?utf-8?B?bnBTdEF4enFXd3JxNmt1WXNlM2RVMTV4dms0d0ZTcnVlem5BZzQ5Y21HMHhG?=
 =?utf-8?B?VHhiWWR5WnV1NklYTmk5SURBVWFwMFF4VGs3T0tyN0Q0Smc0MlRDUWdMZ1BW?=
 =?utf-8?B?cU52RDVUS3NzL1huSzc2VHM5dWtuQUplVmVUbWFwZktsNmlOc3ZSLzNIbkJY?=
 =?utf-8?B?VDRISEZqcyt5Snl3NitJUk1ncHVlTUd6bXJYUXNmMloxT2gxeHUwT243OTBI?=
 =?utf-8?B?NkVmOU50SkZsSW1lNExhZE5Sa2psS2hqbFZFK1VabldVVFMvTjNRSmdCYXBi?=
 =?utf-8?B?UVZRU1NtRGx2THRrQ3NUdTNtd2Flbk4zQjRGb2NDYzlrNTliTi9ibTdKYjNq?=
 =?utf-8?B?MTRNdDBlTUljT1VVZ3E3d0FJSmN1T004N3BRdkJlZWkrNFFzTmFVR042dFRC?=
 =?utf-8?B?cGFnY00yTWNYUmplVWEwTmdicUFybzRQNTZiSlFNUmVCUStwanVxcEVDMXda?=
 =?utf-8?B?blRrcGg4QlIxK1R5dlg2WmFveWFkK1J3R3VrN2psVklEYkQwMEl6M2dpYkJx?=
 =?utf-8?B?NXQ3cDZ4RXAwSlJ6S29jbHg3VlhRUHZEbm5LWDRZN3NaRDlVeWZMemV0cWlu?=
 =?utf-8?B?ZmZLQkhQTjFybk5KM01aWTE5T29EbFk2SDgxMzdQVEIwbFJMa0FDcnlIN0pI?=
 =?utf-8?B?d0dSRjdneTJzTVlzZjFMQkdYSzRtK3U4NHlDa0l6V0QrOVArVEVhWEpsMHc4?=
 =?utf-8?Q?Zxc8iy6rsgcBCfqo6EpOnHPvey7oSvf5yhXSI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZpTm9pbENacXB0NjB6emtkRVJPbVhMV2lVVXNmM2FNUUQvY3F5VTB3ZVBH?=
 =?utf-8?B?UG1hcGk5Zitzd0RyZy8rTmY0SU1IcGROaUxuRm5sYndxMVM0YUY1TGVpK1dM?=
 =?utf-8?B?aDhZQmF0am45dUFHMW8yODFzdnNyQy8zcWUrODZoMlRHUGU4OGNZV0NFVGd6?=
 =?utf-8?B?R2VRbnFlSHNSbit5NWlzc2Y0N2IycS9wdjJvWEEwNHlrMkV0WWp5dmNueThB?=
 =?utf-8?B?eHpaelJLak9ObGJOa3RLQzFsSzlPRk9GcmJQSG9LVnFWUzFnSnRPcDVuVkJR?=
 =?utf-8?B?bUI4bWx5NHh0Yld0QWVrcHhrQVZ2S05nZDBqOEx1aTZXalFhQW9DbmtMMlRR?=
 =?utf-8?B?aUxHR1FIeGtNYTNhOTIyOThBeVJDbVJHYm1BWVBlTDUzOEM0R1kybmpwZVNO?=
 =?utf-8?B?M0pCaEowakNaQUxpblQ3YXJqbEhZb21TZjZvQnVOd0NUTFdUaEUwd05sc3Zk?=
 =?utf-8?B?S3c3d3B0dHprMWRWKzlkNUtVSDM5cWJuM3pDRXBLRlFLcHBBNDUzT1pud2NR?=
 =?utf-8?B?ZzNUL1BQbHFjcFZaMjRNSlM4TkZaUzBwQW5KcnFhSGRZSnBuWWdrU0FWRy9r?=
 =?utf-8?B?MkEyWHhtSEJUR2VsZEFkdzNvMjEvT2VSeTZPKzZOUTFMSGd4dW5WTU1oVzVW?=
 =?utf-8?B?Y0tHNThhSTN5QXYzSjQ4VUxwNVpDQWhYYWthZFp2R01td3AyZ05PYWVVTHF2?=
 =?utf-8?B?Z1lKc2psZzBlS0loWTJ3NWRTaVY3SzR5SzlJaUJMNjA0ZHNGN3R2NXhZdU14?=
 =?utf-8?B?Y3h2Y3daODZ0dEF1MlVUZlBHdW9nYXEvRDNnNVRwYVVVNkFwZ3pjdHhIY0VJ?=
 =?utf-8?B?VCtPM3ZVSVRsKzVsbXNjTHdQOW9VOTZuN01XRzE5TC80VzdVT2s3ZmpDWDg1?=
 =?utf-8?B?d3EvcFRPUDBrRXgxT0Z2d25zY2JlK0tOQytMaVJTMllETTdEcXhCZmtHYVc4?=
 =?utf-8?B?TG5nREsxWng3ekhSZ3pBQzZDTnk5KzBIYWMyRmI3VWREZkxZeFpYRDRpZjJj?=
 =?utf-8?B?MGFDSHZKb0MwNWFhV1B6bEFWb0VvcWtuYU4wbXBGUUpQZGIvSlNQUjlEZWdX?=
 =?utf-8?B?RmJPY3dsd0h3R2g1ZFhhSTcrZzdheWZ5eFZab2RndzQ0dDROdTBGL1V3YWV1?=
 =?utf-8?B?TFc3VS9wODdJT2lBaitTZ3orekhsWXlHMVA0SDh5TUo4Sm9uQVFiSEd0R3Iz?=
 =?utf-8?B?ZGFGYWJRSWl0bFRodnJwVTRDUGNiSHZqTDNPbTdDUVhkQnh3MmxNWitlSlFZ?=
 =?utf-8?B?WGxXYnI0bU0zQm5PSkRuVkxyd3dBSWVaT2VNZE9VUHBMNU1ySVcxenJuYXVX?=
 =?utf-8?B?SVgvbCtZTEtKUGl6cXVidjU2UE05bDlpN3RSN2ZpTXd5cklYTEFGSHBYc2s5?=
 =?utf-8?B?TEtnUFBvcnM4ZXg2ZjZua0hlbGVVOHI5WFN5NjYvcnVVZHdoT1NYUjFxSHpJ?=
 =?utf-8?B?ZnNUME1maXpMUEllSzh2a2FLVUoxZEo0QlM1WjNiUDlSbXl5VGxvOElaZUZH?=
 =?utf-8?B?V01VOVJnRm9YclpBUlY2UXVLT0U2dWZzVzZUV2ZENlBkaEVNcFVUMmNmZGJK?=
 =?utf-8?B?WTN0cnViVU1EaVJxQ20xZDY4TWlabk9aUXZhZVB2QldabjRBeXZucVcvN3lq?=
 =?utf-8?B?L0pqOWw5SXMzeEFJbHJZV1YxVUZnM1F4aTBiS2s1UmVDQTR5bjRieHBBTUNJ?=
 =?utf-8?B?REpqd1hiSzhIbnhDRDdiMVoyOGVRV2xjcnpYbkUzMG15Q1dndFEyL1hiUy8y?=
 =?utf-8?B?c0FzZlhjeTlMWlJLeFdWMUpmY2paclFaNTRJYWg1WFdib3ZYemo3QjBqZ0RH?=
 =?utf-8?B?N0pORGZWRlBIT2xDdm1uUWo4L043dG40ekR0cGcwZlVpVmYwbG9ya2l4cFdS?=
 =?utf-8?B?SHVDRzgrQU1LdVljODVrbFBHZitHbmFGc1FUekJZWW42UmhVUEhMWVowWUNI?=
 =?utf-8?B?UW1ReEpUNjBBc25iYkFUTHlyYVhnb0FDS2Uyd091WkFGMGtjSWcyWllZdjhL?=
 =?utf-8?B?eWRZTGFRaVkrbFZTbStTM2FTMzkxUVozVy9GZjBNeDJmSzdLSDZhL3RHYVFL?=
 =?utf-8?B?eHB1U2grTkpwZG42WDhUeXZmd3B0d2xKdHB1YytURVREWUVpRVN4Mi94cHJM?=
 =?utf-8?Q?YV0IcJR9O2A8nXaWf3hy3mHoU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HUDLn+mU0CiNF+VREqXH/WfGVKxcucGgmjUkVeh1v3TiJoxZJZuCzYAGAN4tW0HLtPhrnBCMTRq50uTp4auQ+8GpKX5LcTf2RCY+/8kChuJ72CbiMsf1KSgcGg8IWV1dCBBESjnvSz7Zi0er0YBV5ken6MEoty5m7CKKUYzNuXBj3WFHCucnBwcqwRunL54/NVBnyLVl8+aT8Wlv+oXz9pni6Gyiklv5MUveKn8p5zupx3q6fHIjnCIOUAjjArlnITgtc6mZzLvoipFBLGM079kav1XQoKnu+dheO9TNO7fNbNiObgzeoE807WkCpWfsqgPj9KKhsciriwJKC3Wi+/t8tyRZFl0QD430z1W9gbuLwSLcyO4nCAPsYpBxPZGe3HBHhJduYQEXCEuqn0Mn9L8DAPq8OTdwW+jAwvF6aeAhF9cIOLhTp5lHIyUa32mNf7lJzbSxISKa/fBWrT2VAL8Z1z4C1ewVN+bPls4flpXLbzDbP6lgxSPmS3u173o72N6U9hS3pFkSgJ66VMpKlEaFhDskFhQV7V/RR+7/wVnExWkXV0zNKQYaWVSu4xQHDKgguMl1EejDJDPAMwsrj9U6jm1+MBNfzkbrsntwiY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf7e33b-9922-47f6-7dd9-08dcdd7201e9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 14:54:51.3337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuzan5FL4INUNGV1TC9FV1PXbM3jQpFEm7NBYyjkGVFoL1mYipAPnjl4L8IjsZAQBBC5AzU7D4wryVnmGi2sDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_10,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250106
X-Proofpoint-ORIG-GUID: sXga2KlU84hAU67NRtXn_rN1uB1vJT-F
X-Proofpoint-GUID: sXga2KlU84hAU67NRtXn_rN1uB1vJT-F
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 9/11/2024 3:45 AM, Eugenio Perez Martin wrote:
> On Wed, Sep 11, 2024 at 11:06 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 9/9/2024 11:22 PM, Eugenio Perez Martin wrote:
>>> On Tue, Sep 10, 2024 at 7:30 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Sorry for the delayed response, it seems I missed the email reply for
>>>> some reason during the long weekend.
>>>>
>>>> On 9/2/2024 4:09 AM, Eugenio Perez Martin wrote:
>>>>> On Fri, Aug 30, 2024 at 11:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 8/30/2024 1:05 AM, Eugenio Perez Martin wrote:
>>>>>>> On Fri, Aug 30, 2024 at 6:20 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
>>>>>>>>> On Wed, Aug 21, 2024 at 2:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>>>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
>>>>>>>>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
>>>>>>>>>> will hold all IOVA ranges that have been allocated (e.g. in the
>>>>>>>>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
>>>>>>>>>>
>>>>>>>>>> A new API function vhost_iova_tree_insert() is also created to add a
>>>>>>>>>> IOVA->HVA mapping into the IOVA->HVA tree.
>>>>>>>>>>
>>>>>>>>> I think this is a good first iteration but we can take steps to
>>>>>>>>> simplify it. Also, it is great to be able to make points on real code
>>>>>>>>> instead of designs on the air :).
>>>>>>>>>
>>>>>>>>> I expected a split of vhost_iova_tree_map_alloc between the current
>>>>>>>>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
>>>>>>>>> similar. Similarly, a vhost_iova_tree_remove and
>>>>>>>>> vhost_iova_tree_remove_gpa would be needed.
>>>>>>>>>
>>>>>>>>> The first one is used for regions that don't exist in the guest, like
>>>>>>>>> SVQ vrings or CVQ buffers. The second one is the one used by the
>>>>>>>>> memory listener to map the guest regions into the vdpa device.
>>>>>>>>>
>>>>>>>>> Implementation wise, only two trees are actually needed:
>>>>>>>>> * Current iova_taddr_map that contains all IOVA->vaddr translations as
>>>>>>>>> seen by the device, so both allocation functions can work on a single
>>>>>>>>> tree. The function iova_tree_find_iova keeps using this one, so the
>>>>>>>> I thought we had thorough discussion about this and agreed upon the
>>>>>>>> decoupled IOVA allocator solution.
>>>>>>> My interpretation of it is to leave the allocator as the current one,
>>>>>>> and create a new tree with GPA which is guaranteed to be unique. But
>>>>>>> we can talk over it of course.
>>>>>>>
>>>>>>>> But maybe I missed something earlier,
>>>>>>>> I am not clear how come this iova_tree_find_iova function could still
>>>>>>>> work with the full IOVA-> HVA tree when it comes to aliased memory or
>>>>>>>> overlapped HVAs? Granted, for the memory map removal in the
>>>>>>>> .region_del() path, we could rely on the GPA tree to locate the
>>>>>>>> corresponding IOVA, but how come the translation path could figure out
>>>>>>>> which IOVA range to return when the vaddr happens to fall in an
>>>>>>>> overlapped HVA range?
>>>>>>> That is not a problem, as they both translate to the same address at the device.
>>>>>> Not sure I followed, it might return a wrong IOVA (range) which the host
>>>>>> kernel may have conflict or unmatched attribute i.e. permission, size et
>>>>>> al in the map.
>>>>>>
>>>>> Let's leave out the permissions at the moment. I'm going to use the
>>>>> example you found, but I'll reorder (1) and (3) insertions so it picks
>>>>> the "wrong" IOVA range intentionally:
>>>>>
>>>>> (1)
>>>>> HVA: [0x7f7903ea0000, 0x7f7903ec0000)
>>>>> GPA: [0xfeda0000, 0xfedc0000)
>>>>> IOVA: [0x1000, 0x21000)
>>>>>
>>>>> (2)
>>>>> HVA: [0x7f7983e00000, 0x7f9903e00000)
>>>>> GPA: [0x100000000, 0x2080000000)
>>>>> IOVA: [0x80001000, 0x2000001000)
>>>>>
>>>>> (3)
>>>>> HVA: [0x7f7903e00000, 0x7f7983e00000)
>>>>> GPA: [0x0, 0x80000000)
>>>>> IOVA: [0x2000001000, 0x2080000000)
>>>>>
>>>>> Let's say that SVQ wants to translate the HVA range
>>>>> 0xfeda0000-0xfedd0000. So it makes available for the device two
>>>>> chained buffers: One with addr=0x1000 len=0x20000 and the other one
>>>>> with addr=(0x20000c1000 len=0x10000).
>>>>>
>>>>> The VirtIO device should be able to translate these two buffers in
>>>>> isolation and chain them. Not optimal but it helps to keep QEMU source
>>>>> clean, as the device already must support it. I don't foresee lots of
>>>>> cases like this anyway :).
>>>> Hmmm, this scheme will only work if the aliased map doesn't go away
>>>> immediately. If the BQL is not held or an unmap is to be done out of RCU
>>>> critical section, it's pretty dangerous to assume we can be always fine
>>>> to work with the other overlapped regions.
>>> But all the updates and reads are done in the critical sections, and
>>> will be that way in the future too. That's the reason why the iova
>>> tree does not have any mutex or equivalent.
>> Right. That's the way how the SVQ translation API is currently being
>> used for sure. It's always protected in the critical section under BQL
>> in the synchronized context. But if we want to support a future use
>> caselike cache the translation result somewhere and get it used in an
>> async context, this will be problematic. There's no way to correct the
>> cached IOVA once the associated aliased map goes away, regardless of
>> protection using mutex, BQL or something similar.
> Sorry, I still don't follow this point :(. I still fail to see how
> this series solves that problem, or how it is different from just
> using two trees instead of three. Some questions trying to understand
> it:
>
> This series still uses vaddr -> gpa translation through the function
> qemu_ram_block_from_host. It uses RCU for synchronization. How does
> this series work if it gets updated out of the RCU?
>
> The function qemu_ram_block_from_host could also pick the small region
> contained in the big region, as it is the same linear search as we do
> in the current case. There is no code to select the big region at the
> moment. How do we avoid the consequences of that small region
> vanishing in that case?
>
> Is that cache just in the SVQ? How is the coherency handled
> differently in the HVA -> IOVA case than IOVA -> HVA?
Sorry I was busy in the last couple of weeks, didn't get a chance to 
reply. I thought I got this answered in the last sync call, and here 
just to get a recap back on list. I think the core point is not about 
supporting those various future edge case, but that the HVA tree itself 
is problematic in identifying the exact memory object (right now it 
could easily track the wrong IOVA address and we have to maintain a lot 
of duplicative code like permission checks in SVQ layer) and also hard 
for future optimization (imagine how hard it would be to build a reverse 
tree for exact HVA->IOVA fast translation). And as you know, this is 
just an RFC series and we knew the qemu_ram_block_from_host call in the 
SVQ translation path can't be any performant, but the key motivation was 
to drive to using the decoupled GPA tree against the full HVA tree. 
There could be further optimizations in the virtio queue upper layer to 
percolate the needed information down to the SVQ, such as GPA, or offset 
in MemoryRegionSection, or offset in the ramblock, such that it works in 
a natural way that can to work directly *with* the memory system APIs 
rather than build a HVA tree that has to work *around* various 
limitations and has to track or synchronize with the life cycle of 
different objects (change on guess physical address, memory region, etc) 
in the memory subsystem. Theoretically this way we could work with the 
lower level object e.g. MemoryRegionSection or RAMBlock, though I don't 
think that the need is imminent so I guess GPA is sufficient between the 
virtio device layer and SVQ without the loss in translation (to HVA, as 
the aliasing/overlapping case shows). With the abstraction and use of 
GPA in SVQ, we just have to take care of the various memory listener 
events without having to synchronize a lot of other changes in the 
memory system. On the other hand, it won't have to do extra check on 
permission, or having to sync with the vIOMMU address translation path 
as exposed by the HVA tree solution.

I think one of the immediate step Jonah can make is to make the 
virtqueue_map_desc() API return the real GPA in addition to HVA (current 
code return bus address but this could be GIOVA if virtio device behind 
a vIOMMU), so we can get rid of the qemu_ram_block_from_host API from 
the translation path. This could even work when we have vIOMMU support 
added to SVQ, you can see that within the virtqueue_map_desc() the 
vIOMMU .translate() is naturally done only in the hot datapath without 
having to do translation twice in SVQ again (which I don't see how the 
full HVA tree can get translation efficiently done when working with the 
vIOMMU). Though at earlier point I thought the qemu_ram_block_from_host 
() would be easier for Jonah to pick up and get the key notion of it 
without going too many details immediately, that's why I had to get your 
confirmation it'd be okay for Jonah to go with using the 
qemu_ram_block_from_host API as RFC.


Thanks,
-Siwei


>>> If we take out SVQ from BQL, we will need to protect the update of it
>>> with something, either a mutex or similar. But that's already part of
>>> the plan, even without my proposal or if we implement this RFC the way
>>> it is.
>> Yep, I know currently we don't have such use case, or we don't even
>> actually have to support or get any chance to trip over those edge use
>> cases in the future. The point I wanted to make is that, this full HVA
>> tree based translation path is tightly coupled with how SVQ is now
>> supposed to work, while departing too much from the rest of memory
>> subsystem. Not saying it is not okay to go this way, though you may be
>> aware already that with this abstraction, there'll be loss of generality
>> and consistency with memory system's view,  which would need duplicative
>> work like the permission check to satisfy those well established
>> functionalities already built in memory system itself; get it compared
>> to the other IOTLB implementation or similar memory translation API in
>> QEMU, limitation applies to where and how the API should be used.
>>
> I think we cannot compare, as other IOTLB implementations in QEMU are
> acting as devices, not drivers. As SVQ is the only one acting as
> drivers, it makes sense the code is very different from the rest of
> the code.
>
>>>> In my opinion if we have to
>>>> work with the HVA tree, it'd be ideal for the caller(s) to get more aid
>>>> in helping figure out the right IOVA range in match rather than for SVQ
>>>> or vhost-iova-tree to blindly pick a random one or break up contiguous
>>>> range into pieces (in an inconsistent and unnecessary way).
>>> The point is that SVQ already needs to work like that, as it needs to
>>> support that a contiguous GPA range is splitted between different HVA.
>>> Moreover, this is not a part of SVQ, but of VirtQueue. Both should be
>>> extremely rare cases. Is it worth it to complicate / penalize the
>>> general case solution to benefit this weird case, which is supported?
>> Sure, not saying SVQ shouldn't support split GPA range between
>> difference HVA. I guess what I meant was the returned IOVA will likely
>> not match the the memory system's view, which is kinda weird. For
>> example, the IOVA returned from the translation API can't be used to
>> infer the GPA via internal tree lookup, we still have to resort to
>> another external lookup via the memory system API.
> That will never be possible for the whole IOVA range here as SVQ also
> needs to map QEMU's only memory.
>
> But if that is a limitation, the second tree I propose can be the GPA
> -> IOVA tree proposed in the patch 2/2 of this series for sure [1].
>
>>  From the looks the
>> abstraction layer appears to be self-contained, but actually there are
>> quite some odd assumptions here or there that may in turn prohibit
>> possible future use case.
>>
>> Given this vhost-iova-tree abstraction can only work with the current
>> assumption or the current limited usage in the SVQ code, I feel the
>> abstraction might need a bit more time to evolve to a point, where with
>> a feature-rich SVQ implementation we can gain more confidence to
>> conclude it's the right time to abstract something up. For now I just
>> mentally equalize SVQ with vhost-iova-tree both in concept and layering,
>> so I have to admit I favored more on Jonah's sparse implementation with
>> decoupled GPA tree plus partial HVA tree for the SVQ - it doesn't seem
>> lose any generality for future extension. Do you feel if ever possible
>> to start from this intuitive implementation and gradually get it evolved
>> with future use cases?
>>
> Sorry if it sounded that way, but what I'm proposing is not too far
> away from this RFC :). Let me summarize it here again,
>
> 1) Why not remove the iova allocator tree? (iova_map). We can just
> follow all the allocations with the IOVA->HVA tree as we're doing now,
> so we save the memory, the code needed to keep them both synchronized,
> and the potential errors of these. If we implement the more optimized
> HVA -> IOVA tree, we can reevaluate its inclusion of course, but I'd
> start simple.
>
> Pending: synchronization issues if we want to remove memory chunks out
> of the RCU.
>
> 2) This series adds a conditional & a potentially expensive call to
> qemu_ram_block_from_host in the translation path, which is a hot spot.
> This is done so IOVATree knows if it needs to look in one tree or
> another.
>
> Instead of that, I propose to make this distinction at insertion /
> removal time. This is both a way colder spot, and they don't need to
> call qemu_ram_block_from_host or similar as the caller always knows if
> it is being called from QEMU memory (via the listener) or adding SVQ
> vrings / net specific code.
>
> The first item is a prerequisite of this.
>
> Does it make more sense?
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg04262.html
>
>>>> This would
>>>> require a bit extensive changes to all the callers to pass in more
>>>> information though, like the GPA, or the RAMBlock/MemoryRegionSection
>>>> backing the relevant guest memory, along with the offset.
>>>>
>>>>> About the permissions, maybe we can make the permissions to be part of
>>>>> the lookup? Instead of returning them at iova_tree_find_iova, make
>>>>> them match at iova_tree_find_address_iterator.
>>>> Yes, if there's no easy way out we have to add this extra info to the
>>>> HVA tree and make the lookup routine even complex (or duplicative).
>>>>
>>> Right.
>>>
>>>>>>> The most complicated situation is where we have a region contained in
>>>>>>> another region, and the requested buffer crosses them. If the IOVA
>>>>>>> tree returns the inner region, it will return the buffer chained with
>>>>>>> the rest of the content in the outer region. Not optimal, but solved
>>>>>>> either way.
>>>>>> Don't quite understand what it means... So in this overlapping case,
>>>>>> speaking of the expectation of the translation API, you would like to
>>>>>> have all IOVA ranges that match the overlapped HVA to be returned? And
>>>>>> then to rely on the user (caller) to figure out which one is correct?
>>>>>> Wouldn't it be easier for the user (SVQ) to use the memory system API
>>>>>> directly to figure out?
>>>>>>
>>>>> All of them are correct in the translation path. The device should be
>>>>> able to work with a buffer that spans over different IOTLB too. You
>>>>> can see how QEMU handles it at hw/virtio/virtio.c:virtqueue_map_desc.
>>>>> If the region is not big enough to contain the whole buffer, the
>>>>> device must keep looking for the rest of it.
>>>> Yeah I see why you prefer working with HVA tree even with overlapping
>>>> ranges, as the current API virtqueue_map_desc() that returns the HVA
>>>> already wraps up the translation internals well for e.g. when span over
>>>> different IOMMU.  Are you worry with the vIOMMU case where the GPA is no
>>>> longer cached in the virtqueue elem? Maybe we can add also that
>>>> information to the elem even for vIOMMU (we can defer doing it until we
>>>> add the vIOMMU support to SVQ), so that SVQ can just look up the GPA
>>>> tree directly in the translation path?
>>> I think that IOVA should just replace GPA in the tree, isn't it? Or am
>>> I missing something?
>> Yeah, I mean that's the advantage for the full HVA tree solution, given
>> the virtio device model that uses the virtqueue API virtqueue_map_desc()
>> would return HVA rather than GPA, so when vIOMMU support is going to be
>> added, SVQ translation code can still work with the returned HVA to
>> translate back to IOVA as is. All the vIOMMU translation will be
>> transparently handled in virtqueue_map_desc() itself.
>>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg04262.html
>
>> Thanks,
>> -Siwei
>>> So the user of the IOVA tree (vhost-vdpa.c) should be slightly changed
>>> but there is no change required for SVQ or IOVATree as far as I know.
>>>
>>>>>> As we are talking about API we may want to build it in a way generic
>>>>>> enough to address all possible needs (which goes with what memory
>>>>>> subsystem is capable of), rather than just look on the current usage
>>>>>> which has kind of narrow scope. Although virtio-net device doesn't work
>>>>>> with aliased region now, some other virtio device may do, or maybe some
>>>>>> day virtio-net would need to use aliased region than the API and the
>>>>>> users (SVQ) would have to go with another round of significant
>>>>>> refactoring due to the iova-tree internal working. I feel it's just too
>>>>>> early or too tight to abstract the iova-tree layer and get the API
>>>>>> customized for the current use case with a lot of limitations on how
>>>>>> user should expect to use it. We need some more flexibility and ease on
>>>>>> extensibility if we want to take the chance to get it rewritten, given
>>>>>> it is not a lot of code that Jonah had showed here ..
>>>>>>
>>>>> Let me know if they are addressed here. Sorry if I didn't explain it
>>>>> well, but I'm not trying to limit the alias or to handle just a subset
>>>>> of them. I'm trying to delegate the handling of these to the device as
>>>>> much as possible, as the device already needs to handle them and the
>>>>> less we complicate the QEMU solution, the better. Of course, the IOVA
>>>>> tree is a very self-contained area easy to rewrite in theory, but with
>>>>> potential future users it might get complicated.
>>>> Sure, understood. I just want to compare the Pros and Cons for each
>>>> candidate, so that Jonah won't spend quite a lot of time to come up with
>>>> complicated code, then soon find out all or most of them have to be
>>>> thrown away, due to short sighted design which is unable to cope with
>>>> foreseeable future use cases.
>>>>


