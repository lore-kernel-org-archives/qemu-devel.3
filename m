Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A50C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVph-00083H-2v; Wed, 25 Jun 2025 15:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpM-00080b-AI
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpK-0003VK-14
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PH0WY9021654;
 Wed, 25 Jun 2025 12:30:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=55dXXLexKx7Msp6EBd1yEeV9hv07K06mca0WBr2LH
 f4=; b=mqjk+Lvh23CgSCgQnbe9FpGMUTjKkIJkFIHXGoo04xgTcgr04L4t9OzV4
 SB/lo1RbNTiLPMBsySqyO3Pn+TX9HZjHzkk1HKVVkxzuzVNcYsiJo/LQtSFpNZqd
 9ImtxWO5Ssu86zJVrw68o4NXpj6CaSL8d41vMt8yUvgFhZtUNRizlS+aKvnTNfw0
 H4xeZ3/h0Q9gJYtChj+ibkeK0axlhg4WOEXimY7ovmeycdpKaq+kFBSLjgQmsbbI
 gMAAdR3XtIsn0eaDNMONMYqy383lIaAPZ5peSgTrzTqzuOulU0jkwMx+fsZkzAPd
 7ro0lZcubmFOXCIMYLHXej82JcMNA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2112.outbound.protection.outlook.com [40.107.102.112])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47geghhf88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThL9iRnc9o9mclDbdBU6NWfVn+I3cgmcFJBWa2on0wVrAFOFWMq5iMWqXlbVxOXfU3ad5B7COh02HwN0QyzCJgtzt4ynhP1VywgG0nqdWC94nQtQk8qAeCkKNZNx2X8sdISV7Gxc5cbMBDVJc+02Iia1l9MTu2lCv15AfQK7MEPBLiCwNcV71tuC6kYpgMLP4Fb75sfkRmIA7XW6sBWuIdczXgqRy7Y1lFwVU7NyxckF/1MwqZxeAgt3nZ4OOxKiC+QX3tz9tVpl3UkXE+M5Rdoph5bgMBU6z1B4Qj849z4eIfxvM/LSkRtnUNKKiUkbLmtc4xYfSt5CoWrsF0GqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55dXXLexKx7Msp6EBd1yEeV9hv07K06mca0WBr2LHf4=;
 b=maKzDB1VlAMaER1xM9N38AoD52FRle13Efr8G8RE3saZYYXIk+PfYjUW3DkLnuMonHCynLcPdxw3n9rFXrG8iX7ciY74jX9ueGqeaWHeLOQ82J+06Rdu+MmQgw/komhfDQ3cL7Ly3B5uynVydl5214sOt8uoUIc/oK5aNcescOl5U562aaPu/AJl1ty25ShgS7wj3wkpWeS+MdYE76XbMKp56TDoNfhM1flc6I7o1NR0mbsaC+nRVyUpYL2BMrFjRDs/qCGlMRD+fZ83BEjTS6FOZHps3UvGX/NbrlAkaCocBs3ynTN2P7IZ7+mHn+z04sGzI3nFkA2vnP8v0Bmp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55dXXLexKx7Msp6EBd1yEeV9hv07K06mca0WBr2LHf4=;
 b=wHERLLjV/5ddXedZDqi9vbg+MV5lvl3iHVI1uNhn3eCX1qkjkJv5cM9tbT/7fpiWaj/4uu63aALcUAztswMvleM2wCs9ucKpOEmvTboqDHVpd9SVC7wIfUlD9g2JT7armOt5JwOOOyBMDQF7GbT5cucyBJ7Mmnr+Agft69RsgeIsiJmxFTdbKXiez6egPDIlBOXXobUn7VqrCuxnA6uE4IQv6aPXzA/bLTSVKVWq0OWWHemKB7DNeu/qzn8X4WYNRm5L75Kaq828xK6l4K/UW1tbnltt8fzYOgFFjqD0MBIKAZrtT3qmmOIaoUQ1ljCvbOGDyaEHpPDNbQxQLewSEA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:30 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:30 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 05/19] vfio-user: implement VFIO_USER_DEVICE_GET_INFO
Date: Wed, 25 Jun 2025 20:29:57 +0100
Message-ID: <20250625193012.2316242-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: e04ce7e6-f495-47aa-5582-08ddb41ebef8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2lqVWdVSUsweERYSUhOaVpNQ09KRHFUN1VpVVNGYnE4YlRtNjdMOXQyVi9P?=
 =?utf-8?B?ZHFHdHZMOHozdDl6emFDckU4b0grYWxRLzJ3NXpBZ3JhMThja2p2bHNKSTI0?=
 =?utf-8?B?Ujc5cmJPTDBCN3RMWWkxOUhPMHBSSTRlV0J4NXlpOGZCaHA4bDNURWRpaWVX?=
 =?utf-8?B?V2Q1ZCtTNjIzWHc1OWJBc3B6T2txLzZvbHJCbHp6OThnTldFTXlpRGRENnhH?=
 =?utf-8?B?d3BRWDhVendKN216QkRCdTJaR2R3VXpSUWJsUjFoOFFMVzFCRzlUQnU4M20r?=
 =?utf-8?B?L2JZb2tDNy9XRkdkVWR0Sjg3NGg2dVZvd0tPU1dRN3NsQUs4NnhHWjgvWWFu?=
 =?utf-8?B?TXV0Ty81TkNJZnNHNGlwTFQ0NHQydG4xRjJRM05PQkh2UWgyRCtZWm5CcFk5?=
 =?utf-8?B?bGxwek9abjNWdlc1M25YY2wvZXl1d1R5ckE4M3NUUWQyOUp5VWdqN3VrSlFx?=
 =?utf-8?B?K212UG5rVDczeGcrSFQzd0hUZW95UndQK0pVVmZUcVRkZURZbytJSHYzTUZX?=
 =?utf-8?B?Y3pnYWdJR0tjK3RVeENsaDJmUzRZQ0lYWnBJeTVMNXc1bGNaL3UxU0NWaWMr?=
 =?utf-8?B?c0gxbW1mMWFNMHZPN2Y3U2NFcW5kSGUyOStmZkhoOHpTUjVXL1NLV3R3d3o4?=
 =?utf-8?B?UFdNcnVENFRuVjl4dGJYZ1B0dTlIUXJRQnVnSDdVSEd4bE9TNlB3K2xjci9i?=
 =?utf-8?B?UG1reHRLQnRhR2ZNdDNhbmtCazlURXMxT1dqN0xjVWV2ZlROUCt3ZlhXaHk5?=
 =?utf-8?B?NmZPcXF6ZTAvM0piUTlLb3ZWRHdEcUVpZ2tvSFpPbnZmQVRva2lOajRaS01O?=
 =?utf-8?B?QnZEdzh4K2NaU241V3BzZUltUDlCNm01K1NEa05odnZxZi9VOHMyRG1qWHlz?=
 =?utf-8?B?dHNFcVFtMFl4cXpaQ3JlWlpHUjlZNzNrU1RIZ3hJWEJlelJXdXp6VEVrOHhD?=
 =?utf-8?B?TUJkVWdHNnF0ZU5NN2Zhd0ZUbG96WjdZejNkQnZJR1dwVmxTcnc5TC9VcTdx?=
 =?utf-8?B?a0Y1SkxIUm4xVnZwMi9FWVFGU3dVRGJWUm1VMWJ2TWk5NE1hSitUWGRrWWhU?=
 =?utf-8?B?ZzRsNTBwSEZKM21FNnVwSkVhTzAwa2ZtK0lVUmlwUXB2aG9YZi9sRnBpYzBM?=
 =?utf-8?B?WmNWSmNOdkpQTEM3Z2VhOUJpVytxUjN6ZmZ5bHR5UkJaYk9WdFlDSGtJYjRC?=
 =?utf-8?B?WkQ0b3h6TWNRNWVGNGo3NUZvMUlOZzVkdlI1UURrUStiZjNKWW1DTDA5V203?=
 =?utf-8?B?bms5QVFjY0ZhbWFuVUpmSHY0aXZsY2Q0RFFrcm1oQ1dCZGJFSFlyUEo0Yk5Z?=
 =?utf-8?B?ZTZkZnR5QW5sdDNPRXNVbjBRYmNXa0ZIWGxjMDNDdW40SE5yb2ZNeXdLbVJY?=
 =?utf-8?B?NWNRTS9lNE1TTkhLWFVuNllORE1yaW13UzBjcEVZL21KVlpRRlJsMWMzWFIz?=
 =?utf-8?B?VVkxWnRRYzFVaXcvejV2eFVBNGlyK1pXNkdYTExCMHJVVWNyaEp1OCt6VHVo?=
 =?utf-8?B?Y2p4ZVAwcktibXAxNFcvd0JFNWRIQnRPYTJDTkZhbGdsd2pPL0k1ZmRKRDkv?=
 =?utf-8?B?WHZidWxnV25ZTm51U1U1enBYeXl4bk1DZkF1eWxHSS9MczJjc2V0d1MwM2g0?=
 =?utf-8?B?Ylg5VkZmeWZGc0NDMHFpUjZxRWZmNklxSFZLOTUzUGRXNXZ5UDRlblBZT3dQ?=
 =?utf-8?B?ZTk1bEdrTzljdGNUUG12YnFiZzgwLzErWTVaWnFBQk5xQ2xwaDVTaXNSZUQx?=
 =?utf-8?B?aENPc1ozYkF5TjZFU21VMjVHTG9laE9KRGhaNG15bm1iVmVxRTdaQ2tNcmFj?=
 =?utf-8?B?dyswU0JkR3dVOVFTOWd2VDdmZWZsa20rSmh1ZUVuNjhEWExvVEZWL3FvR0du?=
 =?utf-8?B?c1pSdW4yd3Yra0lPVjNDNVVZbzFCYmE3NWNoL0tBL2hSVlUrd1l5Y0lwc2xx?=
 =?utf-8?Q?Jlo5XqxsEqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktMNzQyUDhhUStuZUc0QXhKWkNnRFVoTDBOV2srdzFiQ29KNUJZWmhlVUxq?=
 =?utf-8?B?cmRrWDMvU1NWUngvWFFRK3NDUXU0R1gvSStyZWJFKys3NVZCYWEwWE01eDRV?=
 =?utf-8?B?REZnT3gvdmhxVWJaY1hFcFVtaW42a3gvV0NrYzRqWkFlSHRCT05RWVA4WGlN?=
 =?utf-8?B?b21jNEpLSU14dzNkMjdnaDZraWwwcnpwdHJsYUI3NUt1YTVJeU9JWVFHV0FE?=
 =?utf-8?B?eHNGRWJlUk81Mk1UbHBSZkVvYXg3Sk5yVEVHMVNmbmFsUnM1TGlFdTlic3lJ?=
 =?utf-8?B?ak5Vb1dJLy93eXRQUE9uRkIzbjVHL2RQSjF4dTNTbUJyc29EUGFHdzZwNEZh?=
 =?utf-8?B?NWYzRVB3Y3JqUiszQ3U2QlR5VWppY0xKT3A5eGx3bTYzUVNlRnhHbDJQa1Vz?=
 =?utf-8?B?Q2FXTzM5OXpRck11NGt0bjZvV2RZSTFDRXRrRmNxTUYvTHAwU21CaDM1U2w0?=
 =?utf-8?B?Qjd4TzRscENrV0h6eUJMOGFqUWhNN29rem80WmV6L0JtN0hSUDYyT2JKSkFx?=
 =?utf-8?B?TGMxdzVoK0xOWWlodkRNT1pxTkhocks3a080QU9OdE5CWGNaWEpPcWpEcjV5?=
 =?utf-8?B?K2R1OFRQajlkWTNUdzdHK3VRZ0RXUlIvY0FyNHVEeDAxR0ZNUHZqSnljNzd3?=
 =?utf-8?B?MEp2TEJUSkE3bkpNSXZuWHZuMWZud0FUbjZsbE9keHVrRGRFOURZVlhrUVJE?=
 =?utf-8?B?cUVseDZZb0JIYndPaFBqdldxaDVHUGpMUmFPRnAyTWhNeHJkTmxUaTlGWlZ4?=
 =?utf-8?B?V0t3a0F0TEpIOVpBTmpON2YzemNjeXdMdjZUSjVvbnEwc1FmY09RYS9VOUt3?=
 =?utf-8?B?dXNpb0NUK1ZtVGxLSjZiSmlEUGl3Um05eG8vVDF0SE1XUERkV0JsQ1ZvZ1o0?=
 =?utf-8?B?cUtKNElDMytKTFdXQUR3dFlUTmJONWt3NHZvWWFzcGk5eXdVRnpEeGM0Sjdw?=
 =?utf-8?B?K29Pa0h2MW9tZG85bERmNEMvbGdlcGE4dHRvT1lBQk5Wc21XNjdpRkFqR05k?=
 =?utf-8?B?TG5GcUdyMUdmMzVUa2NRTUdSSFk3bUJmVzI2eWVwbnZyc3BBS3llcjIyM21W?=
 =?utf-8?B?VDJzY1lHeWw4aW9FK1M0bEkvUm1WcVcvV3VranhydE12SWVDU2xlNnZONkNL?=
 =?utf-8?B?U0ZOcWxGMTJoWWNwZHkzQ0IvellWVEptOHhQekphVlVqVC93dnNoeEVwMjNL?=
 =?utf-8?B?bTNNNkRzcTg0QWJTb09qOWVuZlhnc0xTQlBQM0M4RGlCWUZnbE10ajFNMjRO?=
 =?utf-8?B?cXoyeW04TTBHdzFHWEIyYzk1WWFmZm5CdWF2Unp1S1doOWJEOGk3UnpFL3Fp?=
 =?utf-8?B?Rm5hcUhuWndIVXFwVEJVWU00WHROaDFVbTJzYjI2eHlvQ0MzWCtocWtGUGpY?=
 =?utf-8?B?UVhRRENGWWdHM3JhSGNvbFZNaHRqZmYxUGhMUjN0Z3Uxdk0ydExVTmJudmdk?=
 =?utf-8?B?VloxWWZRbzJ4WHRoRWJPR2JsZ0Q5QU01WldmUERYWC9wbkNsd2tkbG14R1Rh?=
 =?utf-8?B?WVNKSXJKd1JMVHJoclNwdFFjaDVWWDc0Mk9Fc2dsQjF0MXkxeHpUWUNGTWlm?=
 =?utf-8?B?STlCdy9FMnZSYjhlWUFEdTFJQ2tGMHJRa3VxYThJQmdWUWdtVzEwcERZaXA5?=
 =?utf-8?B?TVFMWkVjOFJJMXJLYVdPWWl1ZS9uUS9QNGcxSzJ0RjRGYjIycThCUFNHOFE5?=
 =?utf-8?B?MVZJdkVnMzdTUEZ5TmF4UEJJL2VxWmRwQzM0YmwvQkxSK2hiVkp1SHJGMWJq?=
 =?utf-8?B?aktKOHQ3a1JEZXRJaytwUHA1aGgyUkgyU2pReW5WMXVpaGJXTllQQjQ3eGdp?=
 =?utf-8?B?NDJUUVIvRThjcGU2MFZHbis5V3c3UzBqM2xnVytQSzNOZENtamY0SFhNM3A4?=
 =?utf-8?B?OVVpOHJqaUtXNnI1alplR09aczZ4aE5RVzRKN3FqaXFsVldIOWk2eWNaVmZ6?=
 =?utf-8?B?bXM0a3lnSUZSUHV1bklKNXRHc1RtSHhVejZkUzRDaGR0UmlMcGFEempyTENP?=
 =?utf-8?B?YW9BMnZZQzd0Z0lUb00xY0ZneXpRNEx3eUhhRWd2R0hzUmNXQk9UejdLbHE2?=
 =?utf-8?B?OTRxdVhNYVBtRUMvTDdVd01yMFp2Sld2cEpvMnBGb0RtOERxdGJwR1c3YXdE?=
 =?utf-8?Q?gVQGWr+mWROhHN55flbpd11DI?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04ce7e6-f495-47aa-5582-08ddb41ebef8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:30.5548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4wuI3N5YSCVDOJoNugyTFDsXOaSSz0Hr5SxE4HWv+THIHtJW1t7W0E3otruhknpHqIV7fkV6+5f3Du27N0vBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=fPo53Yae c=1 sm=1 tr=0 ts=685c4e58 cx=c_pps
 a=d88lBm4WbpKxCRKYgJm9OQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=CKY9KQTx7O4RNs4pBzQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5lmy8PYUoPFp2h79xXj2BhCbKN3aJ4IG
X-Proofpoint-GUID: 5lmy8PYUoPFp2h79xXj2BhCbKN3aJ4IG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfXx0LVoOxb3e9w
 +dvvBo2ySC7cpk6TOIy0HX7Pgp4m/naEexQTOxT7N8YpCBKQWXJOtT7JIu4Kl0dFjnqqmwf2ZWL
 cqW4XIKGWx6w/mP1oCHohvu3CHNInhvMlO0cBV85j+uT24ysykd6xvsKGncoVRGfA0W1+rdKJbN
 Ro4/5z15s0aH1dCXi+0Ggr0CQyYgA1FwMS+D5d+pbQBbpQlkQub9fGs3V30TTRgwG010s10UfgM
 zlzaLiYJo/Kx+Y3cgpf1YUkZeucVbuS47YMu9o4QhvWCZZZ1LUCsuZmj2UaoS3UwrNiyPcBWdSj
 WLPMD+3z6bjlzBoTbdjRKm130SmYziaaj6onZ//YwWdRZkraRBwPPb4/7BOPmpR3qcpnNwJB7vc
 UFudkiP8Pf8pYTkWoN/S/2uOqSsB2ocv9hqMucZzNkahDGrQ3xoIvy/UKftUfZq2EhCCh/v2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Add support for getting basic device information.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     | 20 ++++++++++++++
 hw/vfio-user/protocol.h   | 12 +++++++++
 hw/vfio-user/proxy.h      |  7 +++++
 hw/vfio-user/container.c  |  8 +++++-
 hw/vfio-user/device.c     | 55 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c      | 10 +++----
 hw/vfio-user/meson.build  |  1 +
 hw/vfio-user/trace-events |  1 +
 8 files changed, 107 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/device.c

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
new file mode 100644
index 0000000000..ef3f71ee69
--- /dev/null
+++ b/hw/vfio-user/device.h
@@ -0,0 +1,20 @@
+#ifndef VFIO_USER_DEVICE_H
+#define VFIO_USER_DEVICE_H
+
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "linux/vfio.h"
+
+#include "hw/vfio-user/proxy.h"
+
+bool vfio_user_get_device_info(VFIOUserProxy *proxy,
+                               struct vfio_device_info *info, Error **errp);
+
+#endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 2d52d0fb10..e0bba68739 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -112,4 +112,16 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DEVICE_GET_INFO
+ * imported from struct vfio_device_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t num_regions;
+    uint32_t num_irqs;
+} VFIOUserDeviceInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 5bc890a0f5..837b02a8c4 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -12,7 +12,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/queue.h"
 #include "qemu/sockets.h"
+#include "qemu/thread.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
@@ -96,4 +98,9 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags);
+bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize, Error **errp);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 2367332177..f5bfd54316 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/vfio-user/container.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
@@ -140,7 +141,12 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 static bool vfio_user_device_get(VFIOUserContainer *container,
                                  VFIODevice *vbasedev, Error **errp)
 {
-    struct vfio_device_info info = { 0 };
+    struct vfio_device_info info = { .argsz = sizeof(info) };
+
+
+    if (!vfio_user_get_device_info(vbasedev->proxy, &info, errp)) {
+        return false;
+    }
 
     vbasedev->fd = -1;
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
new file mode 100644
index 0000000000..4212fefd44
--- /dev/null
+++ b/hw/vfio-user/device.c
@@ -0,0 +1,55 @@
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+#include "hw/vfio-user/device.h"
+#include "hw/vfio-user/trace.h"
+
+/*
+ * These are to defend against a malign server trying
+ * to force us to run out of memory.
+ */
+#define VFIO_USER_MAX_REGIONS   100
+#define VFIO_USER_MAX_IRQS      50
+
+bool vfio_user_get_device_info(VFIOUserProxy *proxy,
+                               struct vfio_device_info *info, Error **errp)
+{
+    VFIOUserDeviceInfo msg;
+    uint32_t argsz = sizeof(msg) - sizeof(msg.hdr);
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_INFO, sizeof(msg), 0);
+    msg.argsz = argsz;
+
+    if (!vfio_user_send_wait(proxy, &msg.hdr, NULL, 0, errp)) {
+        return false;
+    }
+
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        error_setg_errno(errp, -msg.hdr.error_reply,
+                         "VFIO_USER_DEVICE_GET_INFO failed");
+        return false;
+    }
+
+    trace_vfio_user_get_info(msg.num_regions, msg.num_irqs);
+
+    memcpy(info, &msg.argsz, argsz);
+
+    /* defend against a malicious server */
+    if (info->num_regions > VFIO_USER_MAX_REGIONS ||
+        info->num_irqs > VFIO_USER_MAX_IRQS) {
+        error_setg_errno(errp, EINVAL, "invalid reply");
+        return false;
+    }
+
+    return true;
+}
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 874142e9e5..aed7b22e2a 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -35,8 +35,6 @@ static void vfio_user_send(void *opaque);
 static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -626,8 +624,8 @@ static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
  *
  * In either case, the caller must free @hdr and @fds if needed.
  */
-static bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize, Error **errp)
+bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize, Error **errp)
 {
     VFIOUserMsg *msg;
     bool ok = false;
@@ -802,8 +800,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy);
 }
 
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags)
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags)
 {
     static uint16_t next_id;
 
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index 9e85a8ea51..2ed0ae5b1d 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -3,6 +3,7 @@
 vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
+  'device.c',
   'pci.c',
   'proxy.c',
 ))
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index a965c7b1f2..b7312d6d59 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -8,3 +8,4 @@ vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-- 
2.43.0


