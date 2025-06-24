Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2526FC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTzoS-0005ZF-Fe; Tue, 24 Jun 2025 05:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uTzoL-0005XW-L2
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:19:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uTzoJ-0007Xy-Ca
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:19:25 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O4Zcfe020135;
 Tue, 24 Jun 2025 02:19:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PgbXBIb+++T0ZNMJL8WruanDkNWubquG3PregCYkc
 vA=; b=nb4sQwCqG2K7aMdNY5LSze/nzCG9a74Y4pQbi2753bFjQO169WUFhUY4E
 TqMWkwEbpyyc4/e0V5U6kUrEufCoEmEhcuhhX70K3y6LV9Ps9Wkif465cAKck/bc
 SopSO5CtQ+t0uFyhJiKctfHj0+Kduo/gkx8G5knb6Y6tkH2B4f/6PjkNPVYT6OUS
 jHC6p8RUKcpItLgBPXloFXw49I6IT0WzI4mtwt5JXMr7XMs5PyKy5HwIHxKpwTOR
 hkeGtMYBkBHJSp3B5o0t47MSVSZhnLrDSY2ygoiRcKJMUHYC0tgfnO7LWRzFWi8F
 ET165isvohVVOg6AGFjJeukilufjQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2139.outbound.protection.outlook.com [40.107.244.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0dcuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 02:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLXs+cd/7Za6zqMD7S9a/Wna+xE+BOcaWmVL0oVyLw5ZzzMv++apFUBzG/KQE1Fle73NSF1loi5R8rLBVDJWYeSdi96dxXRvEyiL1UvEo/Ty4rwywb1isMZMg9ZBN3YuRT1OAUvm3hbEf9u6K6ZuvQTYtH8zI4DN/lCAbHZPembp/l9QRGnz+fhhj9mHh125t0fjxn946jT837NIlXavOiwaF04zGzrlhjlnT9Vi/CRZ2AYTAgQh4nsA1Pyc76m0LtbydMOclPp09fls/m7/Wi+9ihNy+neF3rJp7fp2/mlONxrzaWSir60kJR4gYrCWaj3LtRqEtq2wRgzPkx8Khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP5ZCYu5AUTHUq8IlovqFtfPGc3k/XcO+YOtMeugHXs=;
 b=TrnHlqiPNYzqKQH8qw+xwwpK9yCCO6okrBhLvXTN5MM3CYQVOt4QPJ5Sah+TSVokOY5QFUsV85cp8WBzAGp8T6I3r9BQXLG9TPTVHBBqHIxs7DmJ05L61pBE2Z8qg3ba7wKyiFpaaeQ4ERdtHLorHP/OUZYFbS/n8QwKyeYZy7y8AXjF1P79q5SqdiPcl9sSfjaQZHmWt5ypNPQc5LiS7hMc/t88CesYuJyqG2s1hR1gCW7VfVhlMwTtK4k+Y2wF8qlXDn2u1AYDWqYYsMPkuULixRAxYJm4iw6c9DBwjwTpMU2Dh737nkMViSFWZ/Ir0smTi+wwULG6Gh0r80NN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP5ZCYu5AUTHUq8IlovqFtfPGc3k/XcO+YOtMeugHXs=;
 b=tIWlkJBPrMRHiduKo5pqKbWmgYGFPVwXh9QIrDdMIhu3NDINeHWrDj223mY3rVhVv/llRmrpCks3Hhbk8eitln+3AFnDmJ5kgGZd63swlBgJOmQUhk0U8JBt/2ipuxR+FYBOQ3gAsFDac8Gi9f5iH0XzAraGaNVNQFePUbyXOV5BZb5nJMlX5uAASDwUh7Wmwi3K7Lkx6kHNvcgcvSo02Y0EbE8D2ZJZeDrJQmtZtdoo+2179FfirHRnkCbd1OFuwcWJJ1OpksMKwmScn4jz8qtYhwASHewR6CjK+lEokzG99lonJyzUA5+YzLTfxiFODQQAtWtPL0vv8FcQOo8FCA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7573.namprd02.prod.outlook.com (2603:10b6:510:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 09:19:15 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 09:19:15 +0000
Date: Tue, 24 Jun 2025 10:19:11 +0100
From: John Levon <john.levon@nutanix.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: add license tag to some files
Message-ID: <aFptjwzxKjvwYUgP@lent>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
 <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
 <aFpqaC8HGEK5A7dV@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFpqaC8HGEK5A7dV@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: eb639b85-b17c-44e3-f7eb-08ddb3003051
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YuCMgc/3k1USNC1gAS4Y1Fc5EoSc4++08CgYNhsI3bHuuy8c6/tcPVLW7U?=
 =?iso-8859-1?Q?r+H9vrtQKHkQ8DtVDThAqY4h6YtGyK1lP7oa648jbHaTc5N2q4kjbtsng4?=
 =?iso-8859-1?Q?KVnVsVMNHaM0D+uTO8sMTNncsWtMhNXjnRR2hGTWGdfTxHIiRjbbtDAflq?=
 =?iso-8859-1?Q?KKz1V7O8ZF2gYphV3qYO0euBJkxFW2k2WyOBTOuZevZnk+EZlJWazyDxJz?=
 =?iso-8859-1?Q?cxf1VvkuPpIreiBzFyyjbCaHc7gVj0wwGGtu7wKocKLKR3swoEcyh9Kbf3?=
 =?iso-8859-1?Q?2gFv5hA9Bxve4VoNsGbZ9TEfuTmJXAaL1JwvXESVXAdWO8zc4nm3lr8SpS?=
 =?iso-8859-1?Q?8DSPvXnsiZME576vTf/oXd6beUz3KPjKr+94MD5zJc1QBRqnKFql+wycaf?=
 =?iso-8859-1?Q?ZwFDnc62SiQWPrFDwTidLevipJDT3AzrdnOD6t0Yto8YNsgXXV3hNbD72/?=
 =?iso-8859-1?Q?3+Lq2x6Lgv9L4MNuFRiZoKmuwF4vHMAeA3ivNaj2I0aXAhBlFlTb3q0gIP?=
 =?iso-8859-1?Q?R+VwTxNggvb9OVdT1eLILLPiNggr1MxBAq0Tx5UOMYyhw0YXJDGcquvlM5?=
 =?iso-8859-1?Q?YpoJ6trP8NcseKpNT1oOhEye7eukINUlTOv8SJFdRCFZwFGQOwaQD8iyyb?=
 =?iso-8859-1?Q?DOeeI41H1/NldB+UQDRnj+P8tmjn0KYlfNv7msnmeI4vsDuo4HJ3+UDy+E?=
 =?iso-8859-1?Q?ogc8FYjc4fxq8IQoCQOVF+k+ZboyrqAOeNgPtoZUUFqBu1WwT6Pt/T4Lrt?=
 =?iso-8859-1?Q?aQkwqU6UZUt9q2DGvEztHcqlsSaxwVoTTdyx23Vfx//w1hw1eDAgqhrcZr?=
 =?iso-8859-1?Q?yTWsBq67gmlo0jnlk//zCb4Ux6lp0awsnXbWPxgMTttwEmzrPcxJX01XUE?=
 =?iso-8859-1?Q?qVPMTJA9I++Wf2YQaybVjVtJ1H9u7xfriiOt97VOGVUQbbSXYPlsiNzEWi?=
 =?iso-8859-1?Q?okIlRNM0cmEqh0+cISW6nhcRo5FIIDszidC1JJ9pXf9a3ezuYz6ZlbAVdd?=
 =?iso-8859-1?Q?P0KZ9KMydi76fUDbIenkk1oILdZrMCV5VxuqX5N5XZ4Kn5hmXoaqsuGmYw?=
 =?iso-8859-1?Q?+9yk1972AWljwuA8uSanVBpcWVu8s6jsJPBKreprsKwStwIkqpeb8mbTfJ?=
 =?iso-8859-1?Q?1sSC9QkEiwrjIQQGX4ASbO+NGcWp3TLyJb9+tkGs1TE3znwAT5+Y5BRWX1?=
 =?iso-8859-1?Q?Fv+8OhpxqAss0xy+IppWTMgY9trMMBEfLQfvKcyPEGexYhw9DcaR6f0aob?=
 =?iso-8859-1?Q?mQzlxo2tUt5Y1eEHAg3/I+NgpnQjqkzBK6MeZdLg5Yf1Qi1qDKgKZBahaS?=
 =?iso-8859-1?Q?qP2Gi54PS6kEYg1Ix+w1adlCo2ChWw8YAsQiVXIY86i5/au7Ud6CPnwvHS?=
 =?iso-8859-1?Q?X2jzVDcu2rpEhX+59tCRriroxAxEPZI0hfled42dW+4IpZrdecxjUuXt4f?=
 =?iso-8859-1?Q?hfixiaJdHTScJir/7Wtki3QBFf/uNe5SHLh6Eoag2NbTqKWGhKJbkan0A3?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IQOvC+Ofvs66WeR7vzGHGbK0jY88z4CH5+WzAMpLdm7nH+YnL/ji9FA6jy?=
 =?iso-8859-1?Q?qZenuOigvb8YxbZIxv49UV9Upu9/n1fm3PzzxxiISkbNY4yyLo5MBm73EA?=
 =?iso-8859-1?Q?oGXPoQSSlWT/pDzZ5KeT8c/Wyfo3D9xorrABaM62v6m/rrVLXAZafTGEBC?=
 =?iso-8859-1?Q?zwRSUzkbOmGKETeww7NSdIbrfn6wuahbl/rrPETszm3prAwheYU2ExqucK?=
 =?iso-8859-1?Q?n5msaRDGzWeQGlhMOZjLqxWEArabM3v9Rf16ehYNzUOm1Wf6e8SYyP34XB?=
 =?iso-8859-1?Q?oHdThC6X46wXoR2tf0Fppb0khFUKpI17QLnQg4X6eBJnI353vuAAU5BPij?=
 =?iso-8859-1?Q?ytOyKBUo1usSSRsegzbVOS0sz1/rlmJ70KVd4qYUcYnWEGGlXnUGV8bBww?=
 =?iso-8859-1?Q?HI27n3jIBHifHAoPuxf3djFFXqMUdos5/5XNwdWqgjCSJA/QK/5+jF35xp?=
 =?iso-8859-1?Q?eHDlT6QBZR5/ZcqzcX7cySCgQt8D0sHkJrp/jaJNX4j3IQkeL/Qc8h/zcw?=
 =?iso-8859-1?Q?tyiqfqdY0xDInF+DMcaWMyjdR0RgUHdlDi4Ta7VikOhny20h4lFdvx8PDm?=
 =?iso-8859-1?Q?z/YT/2UbciNy+7wqoIneA4r8WHs87BPvTFlbcPgvFHbOjwXP45yDm5fr0R?=
 =?iso-8859-1?Q?VR2dSe+O2uKMEcQcfMmybncSCxiszg948b5xiRmh3802T30vKKJKixLC1H?=
 =?iso-8859-1?Q?k2MZxI8Is0kQfrRNJRYvmUVQQeRRUOpdCFh98egQdjJRCjuuIewfd+cFjn?=
 =?iso-8859-1?Q?qXvuMIXKCGLQ7XYSutxEO/Iwlk3RhySdpxo+AX20Q9ca2jyZaa+X/0rcSZ?=
 =?iso-8859-1?Q?O9iMSCCdYncobTV0XrRnsyBkUDtCRcyvQDE9gO0ft4vgWvObFZFEyKOFLT?=
 =?iso-8859-1?Q?G2Sa3n+JQzkhG238XAsQWfSuWxxbQvmJfULBO9BaB50YEJ3+9gMN7bZghn?=
 =?iso-8859-1?Q?teUbrL/SGNQW5T2cTG7y5GTCXSUsP+L+rIRmdgVwVwZN13ZwYo5cHar4u7?=
 =?iso-8859-1?Q?O+cM1eSz+mrBYnqzjoNJ1O+j39vvotay8V00kq0I2bjwfMMAPbYS/5hK4J?=
 =?iso-8859-1?Q?rpiL6aTNCHhOGlQ7dtEbHiWcTxbfFikz+f0X5zv+yWgu4v+JR8m+iajg11?=
 =?iso-8859-1?Q?x3Mvk+l27IZ+mo6knr0TH2hjaTxGuKY3RVgdgLpdEK58J18tg9+DgVa8+p?=
 =?iso-8859-1?Q?bvrH1gGByQTvkEIF8WGaFqRvic6HcERv0kM65RR1B8DFNwNwwJTS+aw0Ev?=
 =?iso-8859-1?Q?Ylc5uJFIRUkC60jJVhoJHzH3Ta+d4HaMqAK0+9JxpYXV24AqP0fdqkQy7P?=
 =?iso-8859-1?Q?045H44wwZmt1gdELEF+PNukl4QYcBZdLIphQSa/g3oYvE6JITxbZiPTk1b?=
 =?iso-8859-1?Q?rbor1W/assru4RfIqw0bhl2K/WPaUSUSLPk4dsoMIjeZOBSwL7oqd1r/0U?=
 =?iso-8859-1?Q?4FDBrhON9nSnDHcQ7uf2pL6LjHFjk1qC3gdk6PuA9CRVwSVfu6uqEDHqqz?=
 =?iso-8859-1?Q?TSIH6rxXKEBOMPXBjrW/TWseFS4tFGkmJXZ2iyb4ZzW0GRTbBFyFJGTx2G?=
 =?iso-8859-1?Q?a7viwPPW2WwmukL4kUStfcxvfbQIUXJHm8+wVZJN89GH/vTx7b8qNSN2MC?=
 =?iso-8859-1?Q?59pjv7OiVnsL52JsEdY/dZ1KRdc4OrYbuO?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb639b85-b17c-44e3-f7eb-08ddb3003051
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:19:15.1532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNrPNJQ2lvCiuUmpmsj769z0W4FRpUknHxnrcPWZdDlxyUPxPr/piOWSV+9M1P3E+/+D9lZi85aynYg/IlTV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7573
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA3OSBTYWx0ZWRfXzwqUBZE1AjlG
 oz9qm71nQeBIlCGHzmBn7Kjl/1TiK03/oL29GvYsecwyeomoN5ktMC3XRDphtdxr6bE1Z0WBiQA
 WjN8kSJpD1cf1Y5446/6YdzxsH00P/ODhOYW2O2uiIDcjjSiq9Qm4du2j/br/3ShJdCuavmh+Sg
 fAENvkISTrwedry8xGndzw8H0Q7GBXsOFgvA87EtppFkkLBY6R5uxMg89wfsHX6Cy4WapJ/uIE1
 A1BNOiFdeVSX4gQkW3f0Po+cWpf+buo1SsaKPFvJs6LsHP03I+GdMRIBhPAn+4EeM9WD3TjcOud
 pjZlTOUYm51elQWYoojg42wBviL5YAWtf/7G0M5tNm9PcBdbV4feiQI/ElUWwepxh3FYcqAlmK+
 UPpJEappPUl6jU/GlXIUFt/+9rIlrGZolX8CwqXta6UAp4W34xtN/21YrRHm5hnXvgJYNqby
X-Proofpoint-GUID: j6ItHSVZjS9kfAjEK06Ng8H2o9urmJhd
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=685a6d95 cx=c_pps
 a=6qud4lu4mg9qS+0J/69KWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=s5MZ7A6MmFmyC_u5YEcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: j6ItHSVZjS9kfAjEK06Ng8H2o9urmJhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Tue, Jun 24, 2025 at 10:05:44AM +0100, Daniel P. Berrangé wrote:

> On Tue, Jun 24, 2025 at 10:34:40AM +0200, Cédric Le Goater wrote:
> > + Daniel
> > 
> > On 6/23/25 11:30, John Levon wrote:
> > > Add SPDX-License-Identifier to some files missing it in hw/vfio/.
> > > 
> > > Signed-off-by: John Levon <john.levon@nutanix.com>
> > > ---
> > >   hw/vfio/trace.h      | 3 +++
> > >   hw/vfio/Kconfig      | 2 ++
> > >   hw/vfio/meson.build  | 2 ++
> > >   hw/vfio/trace-events | 2 ++
> > >   4 files changed, 9 insertions(+)
> > 
> > Daniel, What would be our position on such files ?

> TL;DR: this patch looks reasonable, and we might as well take it, but
> there is no expectation that people need to extend this work across the
> code tree unless they love doing historical code tracing :-)

I was required to send this patch, as Cédric wanted the same files in
hw/vfio-user/ to have the identifier.

thanks
john

