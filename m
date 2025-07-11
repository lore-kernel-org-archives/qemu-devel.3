Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B6DC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWl-0005nB-A5; Fri, 11 Jul 2025 05:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWh-0005gU-Fl
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWf-0004o8-KF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:43 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7OZam032420;
 Fri, 11 Jul 2025 02:58:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=m9SioZEJ23wHkdXdCcphUIyW1mjn7g1ujJHrWIC01
 rc=; b=MggjHN2/2GGqVTxOOJdfjyKfrnZfOsmT95tTwjJwjgatHItjO1f9C/2sq
 qxPi5DP6SLyV/RCTL1u7nfgx8sGWpocv6DUUNqsbUcD97NMO/rxvr4AHZ2Ufpkkv
 KfsgDvfyKmIopZObN/Qw3uccdRqBsHGz9xMLid5uhNABS1cT8r0eJ+rnNaNz9cNN
 x4MoqqOOHQDyVQz4c6kYjwXJMa0iPew44U/hKekcllLhfVwhukceAsdD15HvE0At
 9lX6bepiEppbWzA9jpDGX/vhH3q2OhUdt095zW37RXXu/i7vKLl+aZlifDqleG4+
 yMTFhtwgk6xqjdJk4h4NSUlvdmbRQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022073.outbound.protection.outlook.com
 [40.107.200.73])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k38m2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z49baKJchPh4xCvm5zyePDpkc7op//+KrJaRK4cvpJCBqHEpodi2v/l1GD2xsnYJMsSKvFxReTvKgFb4Enpx6OprmjbZKqze1dxJvLnEPRwTtn0beNP3bqrrbYEIU2V4L5UsEvt/PPjYZs0g1DCjaqz0u6fJdTytqME+4fryxERjB9zWaB6YY/r3gXyB/mLY1ATmMBbTr4w8VaJ22XsGIX8Yme4o5gq0scyUjtwuwnETeJLPG4tQREcc71B9Cd4mhRLM2uFKAxjnWRXnWEVGo0VOB+10Fjl5pu/dwztGiQlah9023Bf5Eq/aSfT9CNXB26TZ3jsihnmj7sGAKOpNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9SioZEJ23wHkdXdCcphUIyW1mjn7g1ujJHrWIC01rc=;
 b=HoWu1Cy3ve2rq1uCeMQghU0hMtwC2rwF3oAVXinrVk86aWTTVdzrYE8VpFA9VB2PfhpTk149MkjuxIml7zgMar/b7N5frucaoBojkdaMatSbieLZrjO6RwN7Mdz7kV/BbrmnelAENMEX3MkojcjqElJYmcRGxH3s3C0tutTfYZQkVz/z5SCzh1TmZPnBkqhL/+V4s3/p13R/bgA1o6JmP7bVjWzvhwmfCLG1BN3J0A6Ba2aR75wIhCIgpZewhBJa7fzZmbgMimebMTZdHNPprN6grkjv8QfhgbqQE+WM8tAhF08K88RDMRU3wc2k1FwyiWA0IOrwVZdR1aCBlaG3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9SioZEJ23wHkdXdCcphUIyW1mjn7g1ujJHrWIC01rc=;
 b=j9GfyBu0g9PUZEVm3nEqSqIDzNPLLzYQIKkb0AVswE3v+uVU+VdmRPXuRxGj/eqYU2sb68xcHCTak6L1rnz7lZuQi4LeO/91o1sn1NR7VH9F4PAAFcLszm4H74R7bmjbw5Nnww8zzP5oqayqx8+Qdj2iIIEZ1eUI2M9K4petBn59AaXo/qXAhzPvmHoFGkE4jEiJvaPXCypZt23isZQHpqBv84ub8RShqstskLJtG4IrbEzTylTdFBPRE8B0pg98Lhb2jVsgfunxNB/XkNP5KQI9hKZreby+5bJ6Foh+yiQPeU9TxCSVjn+Glo8bG//Pg+4qrTpIG524+ymXUQHzFQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 06/19] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:08 +0100
Message-ID: <20250711095812.543857-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 524c71e2-216b-4d9c-3dbf-08ddc0618201
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTE0NE5oVWhKdWU3ZWxoSy9zYU1FaGVrajg1dEp4WGJjMzNkTEZWMTJyWDl3?=
 =?utf-8?B?TFJNNEdQZk1YcVM0Q202QlJtZkU5aW9xK2s0SmliZFlhajY0SnorNHZ5MkNy?=
 =?utf-8?B?ek5EdlBDZ2VwS2VPOVZoU3dmam9qUjBCYnUwOVAzZXFla3hKMnNLcEpMSEhF?=
 =?utf-8?B?STVsbXZ4djg2RGZsN2JJVGk3c2F0R1BvOXd5SmFUcGVISE9ZallQMXBxN0FB?=
 =?utf-8?B?SXRnWkxOeVQ4bWF6OUhhdXlTcmNlUks4WGRMVkRSU3N0azFpWkZreVYrdWxQ?=
 =?utf-8?B?ejhqSHZOVW9PVkxiZXNPR3dRQUVCa2w0TE1sK3liVHlmb1VIenI3WUhEVzNQ?=
 =?utf-8?B?Q0U3T1grcWgwT3M3Ni9Vam0zZDljTTlFSDE4a01lZzNCZU9zdlNReC9pbHhJ?=
 =?utf-8?B?MCtzUFdxY0QzSjlJSDJ1Njg1ejR5cDdCcjl4RmhMclRrM3luNEpQdVFQS3NF?=
 =?utf-8?B?dk1IbFlOdER6bmExc3RBTVRXOERWc0krYnJYVjBiSEd3ZTNBTEFaak5RMlhP?=
 =?utf-8?B?UitKRjJzbjNKSGhMbnE1ZUxJajlCMWM3MVVOdjZ4OFpkZ1QzeGF1L21RVTZw?=
 =?utf-8?B?dmg0UmptNHRGVzZaZUNHVzZBVmpUNTBRU1V0bWFQeEJ0Rk5LUHhVNW1ETHVL?=
 =?utf-8?B?TGJPclF4cVlBaHFHZlZjZzI5S2ZmTHBBN2x5aUNxdFY5RWhCZzF5QnJsWXVH?=
 =?utf-8?B?Q1VWOVJZbTZvK2l2VCtQNXVqdzRpeGxmRzU5OWNYMzVjcHJJM1R6ZmNZbmtZ?=
 =?utf-8?B?bnFRNktjRFdKeUtrdlczNkNFRFF5VDNzMjNqcHhGQllhM0VnNnQ3WVpPZ0di?=
 =?utf-8?B?OWpRaEJHZ01xdkV5d0xzSWUzQW5GSjRkUDlzeE1CUXdob29vMVJmUGpnaXFW?=
 =?utf-8?B?SWNjWW9yaHpvZXI4RFhhY2wwS1JqdFZtZG40VlZmK2pvNnJZWmpQdlNVRnRG?=
 =?utf-8?B?UGtjdjVsdFR6ODNBdE0rS3pLcVJnd1EvQlFNOUM5RG94dmJDeFNaSlN2NlVj?=
 =?utf-8?B?Tk13VGZuS09EZHlOSTVlNlZ6b3prNGlQbnBhekszL3RKZGpMYVhaSDllRmRy?=
 =?utf-8?B?dkpuTTJUK0NOS1o5bGN0OEcyWWlEc2pwbmdPbGVWdmZPTElWMU5RakJPdE1y?=
 =?utf-8?B?Si9TTlJMTVNwNGVpZXhCQ2hQSW8vaWkrODcrM0QzSndRK3lxcUxLY3BxNU9P?=
 =?utf-8?B?WlhpSnErQjJxYzVJVUtKcEVSeHNOaUVTTkhyZlZTWXZ2ZmpvckY1TE9aN1lk?=
 =?utf-8?B?OGZyaE5DKzhpT3U2OE53NlYvRnpMODY3TEo1VDY0UmdxYUJsUGlwY05TZ3Bo?=
 =?utf-8?B?MUc3cTQwZnNjakV1WEdRbWVpa0xCLyszNlNHdlRBMUc3MHRST2ppbmhlYVpH?=
 =?utf-8?B?QWlTN2hsQ3FTcGFubUNzWFJFUlkzWjhTQ0tscjdUUGtUMHByNEhzU1BPUk1i?=
 =?utf-8?B?RXdQek40MVkrSzk0eHVNTzlaajdWOWNBZ08xRGRmemo3VjFXK3E0ZEZRaEc4?=
 =?utf-8?B?eXNiQXJWS1BiYS9iMnlqTEIraW5jWDAxbTFjZmhsZ2RtZDZITkhFZDY2MEgz?=
 =?utf-8?B?ZFZnRVFYL2h3TCtWRWZKblBpYkkyTWhwU2VSa3BlMEJNWWRPaGNVbE9iNXdG?=
 =?utf-8?B?L1ZBazYxRk5qMmJVdlZtekdBRkhHeUtVVVQ4SWF3aGlZSXkzaUxFMjZOZjh4?=
 =?utf-8?B?NFFEb3BKRlJubDFtZmM5U0dHSVZmOHgxeHE5c29DYnArYmZwTk1yWVM1MTZ3?=
 =?utf-8?B?Y0dSb3h5NTAwS3lQeUtRdkRSak5zV2lSWVBKWm1pTm9KdnhBbDVUa05uR2JW?=
 =?utf-8?B?R2Z6MWZ5MXpHRHI2cVMwL3VVWWVwZllOM2RiSGx6RVEvbnh3My8rNUp0R2Q4?=
 =?utf-8?B?UnQzcndDWkRnQlltWXFHWVhxY2lkYWJBZjdDUGZCYTNIZjBFV2ZMeHZBL1d4?=
 =?utf-8?Q?karsCGvPggo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U213Tmw4TzF4VUlhcUU3R3RneDBsNXBmT1VWNUNpNDFtNWFxYUNLUDZWbTZY?=
 =?utf-8?B?RFJySmJ3NTdqY2x2eURMWDIwbVFvZm1KL0x6UkFlclVXL0MyaW5SdzV2eWY0?=
 =?utf-8?B?R1E4SmtXN0o2N3pHdXF1UnRMR2doOGFSSlFoNWhUbUJBTnRJTWI1UC90UFN1?=
 =?utf-8?B?cjM2d25QZnZBS0xidVJCdXF2bmZhN3VZRVVyOEFCeHJESDZrU2IxeXVJa3Q5?=
 =?utf-8?B?YkxMekdKaFlaMFVRL2V1bUN3SmpnZlRUWjA0VGRJZDY3NlJ6ZnBYOEZJRmZB?=
 =?utf-8?B?UnZqQ3cyQ0NLUHhuU2xXbGtWelR4c29ybDhFbEpycnN5OGNnQkRKWnE2OStI?=
 =?utf-8?B?cW9kRUpKZzlKZFZkVVAxU1dUYkxjYjB4bklRR0FaZnBBRDBVYzBCMGwwdGIv?=
 =?utf-8?B?TUxZaGFtdnZyVG4vS0xYRXdVYTNwVnc2aWpCaTFxRWdhdUFrUUJieDNNREk5?=
 =?utf-8?B?cEdIR3lpaG5CRG1kT1hUV1c2ODNEcy9zcWxrVmZTSnZGcDlKTnZoamJrV21Y?=
 =?utf-8?B?ay9KTzlsSUJSeFlHa3Fad3B3d3BQcWVSQUN0U014QmkzeW5rL3BEN0xCYUxO?=
 =?utf-8?B?Q2FxbHRydW5LZlBFOFNiaVlJcHJIRWRab3lqSUE5U3h3dHQxN1EyWTVJQlhs?=
 =?utf-8?B?RHZnNC9rRllpL2FOUzVrTmVCdVd2SGJoYWJvNzFpVVZ0NUs4Z0RLdyt0VmR4?=
 =?utf-8?B?MDB1NjV0U0tQaW4rREQxWllVVWpqQlI3c2xHWWNZbDdFdXF2YmszdW9mOHpQ?=
 =?utf-8?B?RlNHRkEzaXBWQzJIcHhPYnBROWpKYklZN0RYUUcrd2JCcWx2eHdhS2lSekZw?=
 =?utf-8?B?SG9Pd1FaKzdFdEN5Zm5zQWhvK0ZTajBKK0pwYWViUTllbUdvbUJxR3d0cnBX?=
 =?utf-8?B?QjN1TDNQNDhlMUVZQi9BODdhUzcvSGlHSkliV3o2bnJScHdzbG02eFptTnFt?=
 =?utf-8?B?NEJQRlRZbzNPYUtJc2NLNUdiQUZxbGJCc1ovcldCQ3ZWMWdQcjJSMzBNNndV?=
 =?utf-8?B?YnRqZlA2QnhFTUhsNlVRUDhXYmc4Z3JNcmd2c1ZtOWJ6Rm0rWlUyczA2eDZM?=
 =?utf-8?B?ZzRwcUJzWnhmSU9qZjE2cjdLRGJyaDNwaloycWVvOUVXRThUT0FWT1FiWjd2?=
 =?utf-8?B?VG1yYUZWZEt6OVB4amQ1eWlGSWFUOVlvbjFjRzRJRVVMa3cwbmpBMTZqVjdM?=
 =?utf-8?B?OHZ2VjdEb1hPcXJueTJaa240bGxEZ01yV1owVlFDVGNkQmtpYU0rcFpaaHZD?=
 =?utf-8?B?bE9Vc0p4ZVVUK2JtT3d6alU5SUJnSXMvbWR1OUZUbGRteEoyUUtmQnJ1Q1k4?=
 =?utf-8?B?NW9qbWkzeTliUnYrWmt5T3gyZmV3R05zeGlwV1grUFV0dnQ1WVFsSE5KeXRs?=
 =?utf-8?B?L0U4YXlFVzU3TDdVeER4R1BQbmg3ZGJxVXVTa21pY2ZaZzJrVWM4UHhJaVcz?=
 =?utf-8?B?RlJnOWkwVHA4OXlkcWRwK2xIajkyQVcydEpVdnpiMkpWRkFkaTdKNEtkVEts?=
 =?utf-8?B?UWo1N3FxSDJCNmsxUzNRTzhyRE5XWmhxMXUxTnhkbjJ0K05FT3Zoc3N0NW5t?=
 =?utf-8?B?TlFwZ2RUcERpSFJwOWF0NE9YY0JDQVhFY3NSb3hybzloOUFVbElzOE4zTk9S?=
 =?utf-8?B?MVlnU1RMREdMRWl5YURLNmNWQkd2NjAwMmhYKzVYT254UGg3enhuZW45OWty?=
 =?utf-8?B?alJLY3F4TmFKbnFRL2tWb3RGUVhyTG5Oa21TbTdwSzV4RzQ0RitNckNseUwz?=
 =?utf-8?B?SzFpL0hrYUlFSDRzS2pFcG1ndmNHWVYyNjV1eUlGcWV6aXZ4ZGlpVnVmUzI0?=
 =?utf-8?B?YStKaFBJL0pkZ1BXZ09ySWtveXN2WGN0d3A2T0k3aXpjYmtmVGVRdHJQWGFD?=
 =?utf-8?B?MndLWm5ZaHY0Uzh3L2xmK0pVYzE4KzZ1TGgzK3RpeXVKWGxlTlZIUUFETkUx?=
 =?utf-8?B?NnhPMzQ4b1lkOHh2WjExeWt6SjlhU3hxN1hUZmlaSkxGVWdHVVlFTjk0WHdi?=
 =?utf-8?B?UStVdEVUZHkwN0JpQVV6ajk4NzlZaXZSY2h0ZnRUcUxIKzR1dDdxWFlKYzNi?=
 =?utf-8?B?L1lNVi9TcGhRQTMyVlQ3U0ZaRU9IVDd5RWM5Y0tERDJxYlpEVTlNdWZYYnNR?=
 =?utf-8?B?NGFWVWNFRUZYSjk3ZFFFalFnemtBV1U5SUdyQUVHb2VOY2JKQ0FqTG1SMXRv?=
 =?utf-8?B?MG40TTdqdWZSMFlzSDVLdTI0dStjRm9BeTE3VlJDejM4bERpSFdnUU0wQ3pZ?=
 =?utf-8?B?cHBteFlWWlp0UUg4M2JLd3R1VTN3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524c71e2-216b-4d9c-3dbf-08ddc0618201
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:38.2640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtvLSZhWTy1gbNKKiVBVU/JupNiweHJokCc3aPRqNknwk7j2c8mj7izt5GsjEgpeh97CEn220t3doo9++ybL8bw/eZygnF0yX4M4/22VfM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6870e04f cx=c_pps
 a=mhBramkM2YKFwkQI7AGxcA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=F9lpminiuFHZMRiaUDYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2Lxp3t54aOgFWlvjTHVF-dQjaR-GDT20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX8wA3id2cdPDS
 NCPqk8AtXLKfD899o+lOeeXvqILN9cdTquvSOIQemriEh8cvbenBiQpcanlbnSvG+EjdPto1ne9
 RqwCK044aniIVWu+0AY/qLRrIEQrJS8lxZQDgzOKHOaXHiGTSTag7rt5kL4QHTAIYQARA3kqJHe
 ATYTat5lHnzZPTxv2SC+b5PKj1CVNTn/zHro1Eb/SLXF0pK579fyJtSHkL14MO92rdFP6m0oovS
 UgfYN9V5irQwYeGsjGkPVXc5AiiuarhWMOXmPwLAkWpPm4AH28tTR5GLZDIykJNbwJuzmtCH2lf
 NnBlnApUgDd1kTv14R1wPds9sy3h5nnfxuaxoS9o1G2uW26gUWVc8BWMGlTSKCbh6SE9MfQNKaG
 jmE9ALgx6Hb/Xu5XFrZLfabKn/EUaWiZf7UrqPXeQIko0zc4W54TnVMYyHi9hrB3cci04uyp
X-Proofpoint-GUID: 2Lxp3t54aOgFWlvjTHVF-dQjaR-GDT20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1a4b14ba0b..16d666f97e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -423,8 +423,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
@@ -579,23 +577,6 @@ static void pc_init_isa(MachineState *machine)
     }
 #endif
 
-    if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
-        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
-        /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 piix4_pm, &error_abort);
-    }
-
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                x86_nvdimm_acpi_dsmio,
-- 
2.43.0


