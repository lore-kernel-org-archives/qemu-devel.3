Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E454C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOv-0003Qa-Pf; Wed, 19 Feb 2025 09:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOu-0003PH-KF; Wed, 19 Feb 2025 09:50:12 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOr-0007UL-4U; Wed, 19 Feb 2025 09:50:12 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9LnWq011251;
 Wed, 19 Feb 2025 06:50:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Quprxgu3LSS9yb4vT50XBs4xUhFHKnzuYSyIGBjsC
 rM=; b=wp3FyABLlhxoTIy+yjWfE7tzEYcXj5M0Bf352lGQa9eQh+Z6ostx8kzaz
 OOSJA12RHxNrSUIO3L+o/QsQSkZiy2sNAXXm+gXVQtXwdw8R6eyekTEoMBNsSb6b
 PhyNcmu49lMMBV+OHih0k2/G3pc9AgPw7rG4cHo7bR8SkoNVfoYfSSZIMMR7oclj
 ODGFgw0rcIoAYbM5kK7RRT/D51eIHKgJE47uOHE90zK7D+BppeuUW5YdIC9YqQ35
 /54wR7ywyIqJHeRFir/siwwS8G3f/2u65jfBNF9GK+JJVNV12eBs+ExwAh25bsHZ
 bMUjuLPMNq89gDPKc+XjxV+5XivdA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bdhxxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEhWptoVp8XSICQDQlWhb9VXoZ2il7EYxNNve13K8epDOiCRMrI+H7magl+YOtdnQNuaAZNrcYhaj756VeI1uICOg7eECAsWpX/D7iwAOnD1/uRuAunFAKNLTaLzukkrIcD0xOVOR+XQzRFknXhCuaOEptCcuemvt3C19zMwZevctktujxLitfOjbxe3MpZV12aXrMvCHaRgFiOTypxIHfMTACD57eo6adTEdriFWQ35faaTIkCPekN6K08BXlm5T7tN4R3XTHG97IT4rWWNyVab8cUvbFnKasp7GIsV6x6sQaeDDXpWid1saduTdHdKehujJ/sbHwMGwZFEfvBGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Quprxgu3LSS9yb4vT50XBs4xUhFHKnzuYSyIGBjsCrM=;
 b=OUa5EVwGU0UXFiW5wHq91QnHc+UhJNsfM6wRWLp/jrNjXhV/76NR+NpgHy4CLUEkHSgMQXs3OTvhsWzGCzOevnJCf4ESwSbB2ENtxD8c8IH/x/xpSQUdbxuCcwo+9IbKybQV4Pw+s5JJx75edfiVXAowBGhvGjd75aO18+ULnoeKQkrbrSb4p8iY6H1spUUWkKRmzc6fBw/6EVunuD4mkS6274yj1PL5p6fyOCiF629EIsMakiBeAAivCithyflUHd4F5CjlrzKqFIvlv6b1jVlIucm9havRW2lxiRccgfpXptDxBWRLH0p4JIV2RkV8756+kaqm1a42v6FUfuLXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Quprxgu3LSS9yb4vT50XBs4xUhFHKnzuYSyIGBjsCrM=;
 b=mOknv0u91tKyWq8eaKhVKFD2fedzfagTN8ak3jI9g6rCwB4BQuzFndBUsz2U/xN1OXU9QaXx2jVWBuEtYB5FCiq5PEvIBMPWykjlCB5hfFKmMZbncLuZUoJWboOA6FwkTkqJlA2RkPwolQLV5Npr7wxr90IHn94wpOHs0braKmtOcYxohO3oJk68eAyQf6bN3mnLMvhmmcNXUIzeNjWtoNt+rcJKDxzTugxnVUp7xalf6P9hQGLEoCD7tkYjTghJqH9QZLq6tLmEAc4ZfJ7N5rBXNsGYvqy9p83zOV9VN++NI7jpo2KVbGUxEGPgPQvjjLy7zTmaCNx5puUvjpbluA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:49:51 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:51 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 12/28] vfio-user: add vfio-user class and container
Date: Wed, 19 Feb 2025 15:48:42 +0100
Message-Id: <20250219144858.266455-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8991fc39-ff7c-4d1d-1e53-08dd50f4a9f7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVVYTHVkaUxTMEYvTytoQWc0cEFCUTFIUHV4bW4zWkdWd2FTVm9KVEtTalFQ?=
 =?utf-8?B?bzh4cmdNUWdnQnk4ckgxMk1rQzF3MmlnQjVYM2RTWVQzdVlzYmRMMVVUdU9m?=
 =?utf-8?B?VzQwTHhDb3RCN0xMb0JmWkhwWjJMcDVWQUJiQlNHM3Qrd0d3bkpQeEVvL2lw?=
 =?utf-8?B?cDR3Z2g3N09yUldOeDhHaHZMQjNNMnVzcnVyKytyV05laXZrS0EvQlNaVWUr?=
 =?utf-8?B?ZUZnbHhpUjZJVUNGNUJ2aUpaRHZGV1UxemcxZUcwaHViMUNaYk90MzhGQnh5?=
 =?utf-8?B?dnZFV1FZbndRdEtjdGQ3ZTI1SWtFdzZtUEFydDlVQzZCQmtwVkZYanFaZy9F?=
 =?utf-8?B?NzYxNVdENzlVYmVtRGYvRFRFRktRMDlkWlBMaTNCL0JTTHAvWVU5QzJEOVln?=
 =?utf-8?B?RVdCekMwNUdnWjRLRzJnZUkyQzFZcU15cmpYV3h3ejVvQllWQzVuK0RHUFpJ?=
 =?utf-8?B?MU5yVFYxMTRuMUJ2UCtzV1JCRkN6a1pKN1VaYmFjOXRIZjRpRCt5dkgrb1dl?=
 =?utf-8?B?cytIQ3BSYUZNSEIzeXRQeHoxYzFqY01zVUI2emwyeTJLZHozaW1uVWd0Y2J2?=
 =?utf-8?B?NFBhRC9YVVBCeWtkZ1JnbWthZmN3M3hPaUZQMm9KSVFBbzlsUVFOZ1lRL0M1?=
 =?utf-8?B?NHJhZ3VsYUVXSk9Zdjl2VW1MMkJSN0I3RzcrUjNPZ0oyY200bEtxUDB3MDRQ?=
 =?utf-8?B?eEZucXdwVUo0NVJwNTYzUzZOWVZ0eDU0a0VWeEpJRnludnlTYmhtRmFOTGE5?=
 =?utf-8?B?NGtpQVlSZEFodE5ZTnJDOW1JbzdrelNMZmJSc3NYaFZiK3JvMkQvTEZlUnhG?=
 =?utf-8?B?eUZzN1ExWmFXY0tqQU5wMDI3NmFGek85S2RRaUpyNWsvYktGKzg2UWgxaFhN?=
 =?utf-8?B?QXh3di8xWUQwMXh5bnZtM1ZOOGxVby9vUlVpOXhEazRzK0tTTTd1bDNJdHFp?=
 =?utf-8?B?MUI5UWgvdExVK2xkeXVkTkVybjFjbytySHd1ZkJMZjRKaWE1N0xYUGZUSTN2?=
 =?utf-8?B?MWdnS3RQSXZJakJ4bG5XNldMbGFnNStqL2ljYWFIZ2t2bFJwdk9pYVRzQjNy?=
 =?utf-8?B?WVlxZEVabnhBTy9tRDVyamRDVHBYQ2trK0RueUZhd2pRZ2JwT3U3dkRjMzFP?=
 =?utf-8?B?TXJmWUp4T2FLa2lGZUFValpzdENVQlpCRGVNNG92S0NzdWd2R0syckFIUXp1?=
 =?utf-8?B?eFdyaDFySEhmc0l0TGJLVXBkZXNWMzdrL2djK1Z0QWp3V0E1VDUrUmxFaGNt?=
 =?utf-8?B?TjIrck5qMEVIbm9WY3JpeFhnMkdMT0g1Nkd1ZG1lQkU1R3dOdjlDeXNnRE9k?=
 =?utf-8?B?NmFvRWROWlZLYitkQWNnZVZQMkc1MkJPTFJkdTZjSTNna2dTQnQ5OVNqSDhw?=
 =?utf-8?B?MktGQzFhblE2VTUxOUZtSzBwM3VXL2Uzb2p5UEhSZGxkcGNaR3BkMHFDaW11?=
 =?utf-8?B?dzB6MTBzQXh6azVJSVFEaXdpcitIaURGeVd4dHVqZkpjVFZYYkF4ak5kU3FL?=
 =?utf-8?B?WjFmb2Q1MHlKdFA0ZFVEM2liSHExaUhqcGlGOURORFpGekZUMVBycFlEeGQw?=
 =?utf-8?B?RG9XSmJZWXVVa3YrZ25CT0x2bkhNNEdNM0pDQUJsU0hYcFF3aEZqWTYyMjB5?=
 =?utf-8?B?aXozTzdaMnBtVEMzU2ZTS1RETGZhYjQ2VVBZdzE2VUpROU1xeHNMcTdsSlZ3?=
 =?utf-8?B?Mnhzdi9uVHRjUTAxSDUvS0dVRHFBT0g0YmhQN1JBczN4dS9wem0vOURVbnRK?=
 =?utf-8?B?Wm9LUEJMVkdCak5TVEJ4TENtRU9yTVR6YU1HbzYrSEJmMWFTSmtaRjcrSVBX?=
 =?utf-8?B?SllCLzl5ckwrQThhaEhveEJ5TDFUWVljVGNScFNJWXFISGVJZEE4WVk3Qzg1?=
 =?utf-8?Q?apn8p/FYLe+Vk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytDcFhkNGIvUkI2UlgvVHJXbU1jcFFSbitUQXovaGVsdG1WMDNPMSs4UEdM?=
 =?utf-8?B?VlZ0Vy9KazFyZlhHVzVjYjd3OGxZVmR6Skw0bS9hOTdGYTc5Zzd4dXk4RzJ1?=
 =?utf-8?B?OFpqQ2tpOXpIcmlFL3BaTGIrMHBDYjB2ZHcxN25mYUoyZ09jRVc3QzVPd3Rw?=
 =?utf-8?B?WFVGK3pEOGNjWXVXUDlVOFlWS3lLNHM5azUvT09ad2xwc0JqeXBkd21WVm9j?=
 =?utf-8?B?Mkp5Nnhad3N1bmFXMWZ0MEo4NUV1SHpPREJudmpoU0kzTVFyT3Bia0J0alFB?=
 =?utf-8?B?NXpCQks2REFRZE52ek9MVjJ3SVIvalRhc1hJMFNua3FSZjZ4Nm1WVS9MQm9s?=
 =?utf-8?B?MDBIREFubkFNc09qQjd1NTJNaGVOZ2dib1kwN1h2NGJ4OGM2VExQMURodkU5?=
 =?utf-8?B?ZStvRzRlRHFNU21MeGJCbUlzeUxJSUF6YjI3eE1vV2tUU2ltdlZpMWRLa0h1?=
 =?utf-8?B?SmZ3UnJac3NMR0J0NG1ub3BoaDVwOGIyTDlOM2kyWVpWMWEyTzU4YVZCWUZ2?=
 =?utf-8?B?SmtMTUJReUo2RkZHRTVvKzAwbm5sZzRKUXcralJEUDBUUW91a0lFaVYvRDYz?=
 =?utf-8?B?Y29HQ05TLzNYaEJVL1pHYWdFWFh6bERtL29qUm9xbFl0eU5QRVFVekV5TmFs?=
 =?utf-8?B?cHM0bzR3RnRsbS9iTm1aK2NIQnpHUkFEdnpRelV0SXZuVjd5a0RWNVpsZ24z?=
 =?utf-8?B?eWc2YWpUWEt3UWd5ZnRWRWhXWXpZbzAyYlZyaDNIQlFXWHhZYmptaXBWTHpQ?=
 =?utf-8?B?R0kvaVN6dnlXS1EvK2pLa3hDQkl6STlOTnVVWWFqbUZhTWJ1MTBuazJTN0Jy?=
 =?utf-8?B?OXRNZEZHZjlHWWUxMVpnbkdUSWdxVXpablRtbmxBNnFIVDZQSEFaNW1PeFZz?=
 =?utf-8?B?d0VnMTRFWEc5YXFKQXRYenBIOTVVeUlIVk4xNjlwd0o1aXhvUmkyb2JLQlN3?=
 =?utf-8?B?d0FlbGtkellodGIwRzJzbVA0RURjdnlNS0gvOFo5VERHMno0YnpOTjF5NTlD?=
 =?utf-8?B?cUdoNmFEb2tTOEpRNTg0ZnBEWGxwTDBOd0pIWUgvRXRZUU9PdXcwZ0wwcy9E?=
 =?utf-8?B?ZHFqSCtkaitRUlhYVDVxOWdnaDFnM0t1RVpxL1NWWUNHdXNDaEYwOXFpSGt3?=
 =?utf-8?B?UVF2M25VMS9aV25XU3NPbVdBZmVpVnhTc0t6c01vWHVhbDhobHpsUWdWTHNW?=
 =?utf-8?B?MDlsb0RNOU9TdjF5RGFZTVNjSGhRTnBJQ1lYRDN6akhSWXdWSXdvZ1VvMCtL?=
 =?utf-8?B?K2Y2TWs5cU1IV3FDdUlMNHRIbmhINU5jNU5mczJqQ1VCTkJNYjFoZ2VGeUZ4?=
 =?utf-8?B?MHVJaW5VNjhTZGIrbXI5a2N5UVJieUwvYXMzYTBEdER4V00xcjQ1dmNKNXlY?=
 =?utf-8?B?TWpYRjQrK1B3ZlU5K0pJOU0xWWNnaDQwL2hjc3JUT0FyRDk4ejNoa3dVcHB2?=
 =?utf-8?B?eVhNVGt5OHAwbFU5bkV2VjlPUXJHVHhkQmVxSGxLb2Rsa241WngzNEQ3UytN?=
 =?utf-8?B?ckx4UUxLTFFOb3p4YTJQWlpIMjdmNHNLWFM0UkVjdGc4Nk14VzJnNkFTcG5u?=
 =?utf-8?B?TFNiSldVVkU3VzFudzVmUlY5Ums0dTRoQXRaUGxNR0VkYnY1SmFITE5yZGM5?=
 =?utf-8?B?VG5mT0JDZjZTYzVpQ056MU9Wc3JHMEdVbi80YURFbUZUZVZsM0VzZ2xFTUw0?=
 =?utf-8?B?QXIvUmRZOUhjbXV6Z1lGSGlvQk5FNUVHbTJBRlAzUDlMUENjSkc3dDV4bjJJ?=
 =?utf-8?B?ZEdmeUQyaU5BQzJUUVNibmsyM2xydDRPY29MVmREOTEwOEJacEN3MXdmdWlh?=
 =?utf-8?B?V05GU1d3VjhEWGE1amM2ZmRRT3N4eSsrUGpReDJsV2Q0ditpTE94VEdGQi9Q?=
 =?utf-8?B?QzZ4NjFqTURYL0wrUFdqUm40aW56ckgvZHg2WW1jMFo3NTVTMnd5dUtaUDU2?=
 =?utf-8?B?Z3lrRCtuRG1pM0lQcXZPTldjbldmSlJiRk1pYzhDOGNUTi9YY2hORTdEWHc3?=
 =?utf-8?B?NFJuc0dJejY0dURNU3NPV0x5WTI3MW5GcjY2dndOb2JXekROeHQ0SXY2ck1P?=
 =?utf-8?B?VUdjejNMSnVwRHFQUkEweU14UmRYeTFkM0JNYTY1TzV2UlpzVmtBZ1dTSkNR?=
 =?utf-8?Q?lRPDHkzkL+ZbUh4j7c1c+KEYE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8991fc39-ff7c-4d1d-1e53-08dd50f4a9f7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:51.2679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQIB9mKY+3hemLTvKmhTbB1yL3bGBJw3dKpiQoARw305r/U9AduDYZy/J0JTGQSt83cIpOUwTtcbrnqFGWR9nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-ORIG-GUID: qW7vURIXtAZYPl_5bC-JZ-zBziikqm0C
X-Proofpoint-GUID: qW7vURIXtAZYPl_5bC-JZ-zBziikqm0C
X-Authority-Analysis: v=2.4 cv=Fo7//3rq c=1 sm=1 tr=0 ts=67b5ef9d cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=_S1ogib_BAg1t8ieMRMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Introduce basic plumbing for vfio-user behind a new
--enable-vfio-user-client option.

We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
container type for the "IOMMU" type "vfio-iommu-user", and share some
common container code from hw/vfio/container.c.

Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
sharing some common code from hw/vfio/pci.c.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   2 +
 hw/meson.build                        |   1 +
 hw/vfio-user/container.c              | 222 ++++++++++++++++++++++++++
 hw/vfio-user/container.h              |  23 +++
 hw/vfio-user/meson.build              |   9 ++
 hw/vfio-user/pci.c                    | 154 ++++++++++++++++++
 hw/vfio/container.c                   |   2 +-
 hw/vfio/pci.c                         |  12 +-
 hw/vfio/pci.h                         |   7 +
 include/hw/vfio/vfio-common.h         |   3 +
 include/hw/vfio/vfio-container-base.h |   1 +
 meson_options.txt                     |   2 +
 scripts/meson-buildoptions.sh         |   4 +
 13 files changed, 435 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/meson.build
 create mode 100644 hw/vfio-user/pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7e6743cc..c403742c27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4158,6 +4158,8 @@ M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
 S: Supported
 F: docs/devel/vfio-user.rst
+F: hw/vfio-user/*
+F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
 
 EBPF:
diff --git a/hw/meson.build b/hw/meson.build
index b827c82c5d..91e8d2bdc0 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -38,6 +38,7 @@ subdir('tpm')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
+subdir('vfio-user')
 subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
new file mode 100644
index 0000000000..7b1c202517
--- /dev/null
+++ b/hw/vfio-user/container.c
@@ -0,0 +1,222 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ram_addr.h"
+#include "hw/hw.h"
+#include "hw/vfio/pci.h"
+#include "hw/vfio-user/container.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, int flags)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_create_user_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_connect_container() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_connect_user_container(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_get_address_space(as);
+
+    container = vfio_create_user_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+
+    if (bcontainer->error) {
+        errno = EINVAL;
+        error_propagate_prepend(errp, bcontainer->error,
+            "memory listener initialization failed: ");
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    memory_listener_unregister(&bcontainer->listener);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_put_address_space(space);
+
+    return NULL;
+}
+
+static void vfio_disconnect_user_container(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    memory_listener_unregister(&bcontainer->listener);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_put_address_space(space);
+}
+
+static bool vfio_user_get_device(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_prepare_device(vbasedev, &container->bcontainer, NULL, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_attach_device: attach a device to a new container.
+ */
+static bool vfio_user_attach_device(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_connect_user_container(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_get_device(container, vbasedev, errp);
+}
+
+static void vfio_user_detach_device(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    QLIST_REMOVE(vbasedev, global_next);
+    QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->bcontainer = NULL;
+    vfio_put_base_device(vbasedev);
+    vfio_disconnect_user_container(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_attach_device;
+    vioc->detach_device = vfio_user_detach_device;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
new file mode 100644
index 0000000000..24ce13bc2d
--- /dev/null
+++ b/hw/vfio-user/container.h
@@ -0,0 +1,23 @@
+/*
+ * vfio-user specific definitions.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VFIO_USER_CONTAINER_H
+#define HW_VFIO_USER_CONTAINER_H
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include "hw/vfio/vfio-common.h"
+
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
+#endif /* HW_VFIO_USER_CONTAINER_H */
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
new file mode 100644
index 0000000000..f1fee70c85
--- /dev/null
+++ b/hw/vfio-user/meson.build
@@ -0,0 +1,9 @@
+vfio_user_ss = ss.source_set()
+vfio_user_ss.add(files(
+  'container.c',
+  'pci.c',
+))
+
+if get_option('vfio_user_client').enabled()
+  specific_ss.add_all(vfio_user_ss)
+endif
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
new file mode 100644
index 0000000000..6c85c60179
--- /dev/null
+++ b/hw/vfio-user/pci.c
@@ -0,0 +1,154 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+
+#include "hw/hw.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/vfio/pci.h"
+#include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qemu/range.h"
+#include "qemu/units.h"
+#include "system/kvm.h"
+#include "trace.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    char *sock_name;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_intx_eoi,
+    .vfio_get_object = vfio_pci_get_object,
+    .vfio_save_config = vfio_pci_save_config,
+    .vfio_load_config = vfio_pci_load_config,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    AddressSpace *as;
+
+    /*
+     * TODO: make option parser understand SocketAddress
+     * and use that instead of having scalar options
+     * for each socket type.
+     */
+    if (!udev->sock_name) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
+        return;
+    }
+
+    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
+    vbasedev->ops = &vfio_user_pci_ops;
+    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
+    vbasedev->dev = DEVICE(vdev);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_attach_device_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+};
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+ type_init(register_vfio_user_dev_type)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 36cd245c92..0e1af34ce4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -884,7 +884,7 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     return true;
 }
 
-static void vfio_put_base_device(VFIODevice *vbasedev)
+void vfio_put_base_device(VFIODevice *vbasedev)
 {
     if (vbasedev->regions != NULL) {
         int i;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a9cc9366fb..a7084a7690 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -109,7 +109,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2587,7 +2587,7 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
     }
 }
 
-static Object *vfio_pci_get_object(VFIODevice *vbasedev)
+Object *vfio_pci_get_object(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2643,7 +2643,7 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     }
 };
 
-static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2651,7 +2651,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
                                        errp);
 }
 
-static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = &vdev->pdev;
@@ -2847,7 +2847,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_detach_device(&vdev->vbasedev);
 
@@ -3394,7 +3394,7 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }
 
-static void vfio_instance_init(Object *obj)
+void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 8e79740ddb..c0f030f4db 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -213,6 +213,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
 
+void vfio_intx_eoi(VFIODevice *vbasedev);
+Object *vfio_pci_get_object(VFIODevice *vbasedev);
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+void vfio_instance_init(Object *obj);
+
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3512556590..ee8e7f7c0d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -80,6 +80,7 @@ typedef struct VFIOMigration {
 
 struct VFIOGroup;
 
+/* MMU container sub-class for legacy vfio implementation. */
 typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
@@ -106,6 +107,7 @@ typedef struct VFIOIOASHwpt {
     QLIST_ENTRY(VFIOIOASHwpt) next;
 } VFIOIOASHwpt;
 
+/* MMU container sub-class for vfio iommufd implementation. */
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
@@ -285,6 +287,7 @@ bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
                                       Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
+void vfio_put_base_device(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 24e48e3a07..1ce93c5b9b 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -100,6 +100,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/meson_options.txt b/meson_options.txt
index 5eeaf3eee5..ba9bc07fcf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -109,6 +109,8 @@ option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
 option('relocatable', type : 'boolean', value : true,
        description: 'toggle relocatable install')
+option('vfio_user_client', type: 'feature', value: 'disabled',
+       description: 'vfio-user client support')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index a8066aab03..6ee381df8c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -201,6 +201,8 @@ meson_options_help() {
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
   printf "%s\n" '                  VDUSE block export support'
+  printf "%s\n" '  vfio-user-client'
+  printf "%s\n" '                  vfio-user client support'
   printf "%s\n" '  vfio-user-server'
   printf "%s\n" '                  vfio-user server support'
   printf "%s\n" '  vhdx            vhdx image format support'
@@ -529,6 +531,8 @@ _meson_option_parse() {
     --disable-vdi) printf "%s" -Dvdi=disabled ;;
     --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
     --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
+    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
+    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
     --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
     --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
     --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
-- 
2.34.1


