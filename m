Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944E1C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc13-0000bP-QU; Tue, 15 Jul 2025 05:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0f-0000Aj-Hv; Tue, 15 Jul 2025 05:31:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0b-0005i1-DS; Tue, 15 Jul 2025 05:31:37 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F82SQ0012288;
 Tue, 15 Jul 2025 02:31:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mSVLSU6ea+Cp3MinP9glWV82tvyA8npx3zB60ZnZt
 Ok=; b=Ysmyjvy+ryNHLFnKFYyq7ztsNCABz3U/adTajWMuXw/UuRx1vzVJwzDrM
 LNcVC+LL5a9K5Kv9BTNMCJOGA4issDhgyzhMy8JdqhrNxmD4R1/P/LICTleXng31
 t8PN0WNGvLEPQeiMswngy1Lz5Z8wHgWiSQxyZVR8DRpMEOuy16//fRaVLYX7PCYq
 TVlnXKwsYf0WVDGyV/AstmQjyK5NqiYSAVpFfdCRKnK4pwTYwzkt/0RHdF7Xi/J5
 xmkwxSicWgJXg0N8ZIiYe4A86+Wk+YRBLo5Di+68TpjdrVXQE00ehuNwmmDwX794
 A7Fi/d6iNlY8wDXXLu5jpvM7/2jyg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47upsh5p0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6LZyoNMMQWiBkriV9GZ+TAx0U59O0jYW3oPzU7dZ6AQNmiPWu3E42U9QwXI5TKz7lTceRWhgUpiCC7dlHgBmn+M/bASFpaqrsJ+AG3mPt4FAz+gxOk37azN/1Oujo9qwVR9EKuA06EJLbfEosgLCxqzwzp+OfACHR1OG03GSu0Y5E1PSqNtLa9+PcFXj+IB56Qvhm1Ao+XnzIC9Niwx5uhMd1v5Rp4gP4kbFTIvNIJZY7fryM2v+xKgdD2N2lxAbcZB8j2pWJ2a1UUubAze6/2d+IHf/3xAmfIKNxbncIoQfx5AeaCTBL4ArsNNY1rPUbxSpjg0vFXU8svVn5MHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSVLSU6ea+Cp3MinP9glWV82tvyA8npx3zB60ZnZtOk=;
 b=YUPqBAdsw70txit/Uu2Ajwhs5GwAINCq7qTjQG+uuZBM+UG9n3HPyr24fFScYw8dghbLr/FsDN1JvoeYoSfNj6q0+89/TmwYw9bTQU+pfRYOECltemJudEs6qZ64VxtBdnhTWiS+L3ZkvDUTVQIlqAl4l/FMuWA/RKas+vQLNTZi5s3la3N7YxWfTCxKO2vdafR9NrfmrbDI2cLLLEthD7KwVCHdoiSbEl9CQk+IldsUsltjvzAlsh/xF8MYi/lygrjPHQl4/zNRPP47F2S3v3HbDVuKOi9yPHYNnU8TstO5h4oJ4P9A+UBYJE7zUD0KU+ODbWqxRS5xhowe3Pf05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSVLSU6ea+Cp3MinP9glWV82tvyA8npx3zB60ZnZtOk=;
 b=fzOfF4PLC+zyPW6V6f7mOrYakvO0Iu20+uTWut92/n61XhoRN6MCXUTVGr0yq5JPrVdPNjtC+bhXPt9OeaHcU/8b1SY51QI7K167VoD+EkwiGtpW7YTuvRKc9i5nQnFCINZpCoUyJPrb4iLMhGsRiyE9QvIY1g7vA6mqr7xS/x6bSg6J1aYbBVI/T3i8QQ+zYASixU3xLTEFtYnkZ9IdU18AjewZPTusieCmDNWPmrGsJZwpAPmHgneruMeYOvoVoSOZGvybzfBclIyhAbQr+TMDyvxcrcX5SjAL0PhF8KIW6t2hhYvJ1IFCcVRPXqOeCBV1ldu3Q8GYiceg7ZMjNQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB9386.namprd02.prod.outlook.com (2603:10b6:510:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:31:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 02/22] vfio/vfio-container.h: update VFIOContainer declaration
Date: Tue, 15 Jul 2025 10:25:42 +0100
Message-ID: <20250715093110.107317-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:205:1::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: b489c0c5-34e5-44ca-3758-08ddc3825c36
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KDkMroDsVsVjHvQtFwgTBXMjpOwW4UY5re3diVz7Kk0A6pvLXyyNAMovX8nI?=
 =?us-ascii?Q?0v7Gx5RuB0SQrTOyoDFllHhh1D4MJLoRH44ehKsQ69VK9//joxjssmsho7AB?=
 =?us-ascii?Q?vqiXGznRRbVRuPSWwgeB26FIpF9LqXY5oWnLe7C6S2j55IaBCSxivjAwZUIn?=
 =?us-ascii?Q?g3mYTW1y8liWHQ0w4X6G0aKBepzN7u6mBhdEMYqWtgu2GUSSL9fvuJIpPlKo?=
 =?us-ascii?Q?sWRRgrppl+uAjzbkvK3LsvnayG/8ta0ZFluiZFmUAmn5Ih223VpQ0Edf4EWT?=
 =?us-ascii?Q?ug3wdPdeI/Vo218INukuuQWylxz/QDkquf2TwIonwFfX5DwW/Lss4zj5Sg4U?=
 =?us-ascii?Q?Lsovr5Dxp0d5lVVggzPCvuFBYxf2L23TNS4WY6E0WT+XyJ+7hsUI8NkX7N8/?=
 =?us-ascii?Q?jAlbWiSCklgjN/tovYcmCGUgONcIl8nNe5Z3dq5UnHKQ8TY6PqBSqxGxmfkX?=
 =?us-ascii?Q?4K048kUgRQ9NMTDrlO/XN/ao8NzGNruxC/IhYBCEWyQmm2EJ+MCJkOqtC7La?=
 =?us-ascii?Q?M9Kjt8kMaMmpt6Cpjw/hTIRK5LNCIecNLDQ98CGZWsmI5kaz8BSyW0lJ1odV?=
 =?us-ascii?Q?MJ1RmfTcyMp6NyqX62wMGJ4rC20rvh0ImWtNJXEdYr0lIgUyV8+XK6i775Ty?=
 =?us-ascii?Q?cn+K0LQpzhPaMAfkOcO7q1/m6Y0toHZh4CZZMiqBQWft95/yN2/AqzOFUgNN?=
 =?us-ascii?Q?3IN140vNhRgDkKdASalJYMu+KwTGvuhv3LJUzt780w+vbnKANle0XFMpP/Z/?=
 =?us-ascii?Q?/WB0jsbyAZFpxBZ/rVeAPRX/pnvgrb4XPxS/sKOw4dhfLuWwUsn9HmQ8SR9h?=
 =?us-ascii?Q?KvUERIheuOJxVaiPDj3wdpjSQmwGZ9SHTQyVLv2PTsGHE927c4DJ7CZM9ct4?=
 =?us-ascii?Q?J3OdjFb3R2TYDhLqwhGpD3YS/m2qccPZaNJHIHrhJHwxd9xaMavEtP+DdRU/?=
 =?us-ascii?Q?xEOKAAGfc1V1hS64lXMhvpf87Oh/U0LxElOUZmfEv0KZCSNjzxBJVOWY5Pre?=
 =?us-ascii?Q?roCUgiAYbOpJzU+d9NnTMnr0hSm8uQ0Fnu2MGpiRUvv8sheGXCHpt9RiHiBv?=
 =?us-ascii?Q?O0Djgiekn9ITjdvYl+JXsEMt/jEKJ/8LgpFSjG1T4EfMNR9Rry+aJwdUgkOn?=
 =?us-ascii?Q?Who66Bn2MIuMEMrJoyYLgFqAwC7icjAiS7/c2V5MsEWNbwMk0yyn9EkfZiHp?=
 =?us-ascii?Q?dbvcDDXSVHIqx/DD52iPkm7GoAGE/Ps/+RO/NfJjrh3Fswo4DdvghaFx/X75?=
 =?us-ascii?Q?gDshaTwtFyIACqSsfj1/eT7oqD+YMHEU46VXUIqVgTbkXwzGRScvXz9ZK0p1?=
 =?us-ascii?Q?ZfeQBwnZft+ZcXpr9tKYpt4HRs/4x7fMA+emea+kn/L7DcrpUZww+sBEvo5n?=
 =?us-ascii?Q?keiLQar21I0TeRtbO/UJHeFs9I4XDRQSbO1pS+tlOa9ZSDC7Dc39rzavSmbo?=
 =?us-ascii?Q?dBidQF09dk8URpvsRNPzC26+pLefUIstV9uuh6TdHwAY+GZfBg3Jng=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJ1UHfqi0+j0J8e3jvYpNKaKLBrW0rMXChY0LHYzXJ1ozPxHJ6BrpqQX4ABu?=
 =?us-ascii?Q?6E21svp5VnXuTfdLc6Iw9zkqHr9JRr6MYlySdkcAVKMEcyQPap3A5LDg/GA5?=
 =?us-ascii?Q?vcgJrzcxzraKoCVDYJgV/0EoE1wxTh0Zf7XhT9lFLoMyBAUUB/sN/hl6ilIg?=
 =?us-ascii?Q?U6vgUMRUdp6AeVSTVYVdL8F7HnVHYHdz+XfJ/6nUboAyz5L+5O6ng+UaXOrr?=
 =?us-ascii?Q?ah2DvaBs3uJjBfLDR2saRk8hoU9qf7nFmXIVapsOthHypXzdFEjCDaG1c4Fh?=
 =?us-ascii?Q?QWYG4HxLfYYrhNS/YBNsWoGsbjqzg3ZoWEc1tC/zWp1tg0OGhrAsm7wT7nqQ?=
 =?us-ascii?Q?P8JNpnjy3wYvHhMLf3VJB2sMFK0uC8MG57SriLrUkHn7u+pZbTRw1OaxEiuj?=
 =?us-ascii?Q?qb7LeuvbYkMhfZuhFzZG0eUukT7Us1AXlHWkq0R798Ym8ZFTJixdznpWXsO0?=
 =?us-ascii?Q?4MsZe4xukgWaBQqddT7f71mpTQHvdtfS3/dWkiU4NKEU7x7y27xzc032PpXa?=
 =?us-ascii?Q?IdcKDXE22sjaglVWNEIUu151Vl7pRoftH3TIrAxecjvw6FGDSwenU/yURIau?=
 =?us-ascii?Q?kPmqx7ckLf7kCBKuBvOxMnr9EGCsSTs6bSKGQUrXdq/vojhKTJ4Zj2mVi8GT?=
 =?us-ascii?Q?1dCD8K6CYCyu8UzsG//7/WEuYFKLbQLJpbGIhya7rGF+1vSWCOW/p1jjY5AE?=
 =?us-ascii?Q?KMvPmGbLY9yz2W0hg3QwRmKSHTDdfJ1Fit+FxfKdtteLetIOOKcVA5i0sBq3?=
 =?us-ascii?Q?6xZNeH/L1/JO002W1xuqIyS1dUz34TVHMlTHohPykYEFkMYX9T8LRJvqxw/D?=
 =?us-ascii?Q?/QQprn0xhp/MYFrN7S+1VSC+TIXEGKArpav/HtAJGpAqo1HQHYvfqnrKb+/m?=
 =?us-ascii?Q?9Mqsp/nvyOkIbHdVn32jOwvGMyn+N1nYfAc9ULlayCxEQN3H+kj4ADTZdAK2?=
 =?us-ascii?Q?2FATXPpv6wQMrg4uzjZWOkJebT452jYgS2RRfg3DDe4QvW5mG4c3bte2IOGV?=
 =?us-ascii?Q?rz7dQ/jyy1F7k2jPvFWvriLOJ2g7cPVyL+e0kimh4Jo/WzqPXBdm0YwFnNI7?=
 =?us-ascii?Q?gWn5lmFRMLTj3w8Mc1CXOwkxueW/F01h88od6psJvRWL78sLMDO65EQF5NV9?=
 =?us-ascii?Q?dZzAgGgyrdX5UjXOJvI46lrugX82rZUvnqCwpws3fpUdbrG6NhJ3jS64fKa+?=
 =?us-ascii?Q?xkFUeu6hHD1Knqd91sQtmFtvu1xon64aL1PV91ZdIl+FOiff1T47x2SYAYxw?=
 =?us-ascii?Q?JuHdSrK2Zh8qtRSsb/XtUvREjhiNZWC4p0YWh2S+Ky6cmccSyv5oDbr3/QKZ?=
 =?us-ascii?Q?NXla4cXHkntufDs8RDDSmwV9S4a+0FB+iVrbvM3r9ktCC4n0aQdQB8XR4pHr?=
 =?us-ascii?Q?c0khBTRooCxFYCXLMU8FSalLwpemaqM4bR0xmWgpp///cmLr9rQUZ2AJUm59?=
 =?us-ascii?Q?i6qUoAgLNxXkYTIjVNDa6yFzOxJ2uJVj4UlartxZWk+MqOvQSzJ3UZf8K5k7?=
 =?us-ascii?Q?Q0q1nviNLEK4oPuYAPchvD0B0DB/VtmhdB3Ba9CvzDUymKCAMyrVMbV1e/H7?=
 =?us-ascii?Q?tjlglVXcR0x2VGT3M4SqSC4w2eMTMA3QpZ8e1IGAp1wgjwosoV5UhwJhZI8R?=
 =?us-ascii?Q?eBsyojdGatT9n4leDeLSBpdvjk/D0CTS5qDnAdUwrpPAtdEgD7s2oAvtK6Cg?=
 =?us-ascii?Q?41Bj0A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b489c0c5-34e5-44ca-3758-08ddc3825c36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:21.7665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1wY3kB5EumTDQ0TPJVHsZygHN4RbsQcFhi5cN6vfO1xGdB+Oo2rAUZfegda4X/nvdQPzw207339SqY5L0+3ZMLcjNsZZ3q5QXZYVMq7tYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9386
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfXykYDR0w0ARN/
 GqOJvlpVRIRJUQV4BWrRYzasjvZnI+SlTRpe0mdJlwKfXRT8iOku888sWXT8LD+N+N0evvNR/j3
 aIGuoOtB/OrMpOwvA0A6F3EBiL7T0t7oxgwftpK8Qj5xAeXtMQhTsg+mkYwgDflkxKBCb3J6R/a
 CROeHlCEb6BHewm1EdKq2OVVDXYdZ2JoY6VOAgT1KYafPBsN1drz1BH9HVWa/iGQ7fnFziNudh5
 cPFVctAvh9M4B3woApAwp50VnZ/MF2LAcJzAGJeh5Wi84Of5BsvrJ+E9AOMnI0eMug+hDK30gks
 AlLs8Hrt3J82iP+Rw76x9sKBQY0eW5EIKHAHg8GvAbX5qYK3rJUMJetZli314+vXg1DtGCIk0Ed
 96oGPENmcWAY3yUQBkT/gXFzg+qrxwPw4yHnr/X9WiEaTbBYPgxA2hUFIzkbFsEdi10ixeTV
X-Proofpoint-ORIG-GUID: wxOth7zojCoz1OZR0af-t0HECfcKXVwV
X-Proofpoint-GUID: wxOth7zojCoz1OZR0af-t0HECfcKXVwV
X-Authority-Analysis: v=2.4 cv=AoTu3P9P c=1 sm=1 tr=0 ts=68761fec cx=c_pps
 a=hEWPytJkew9UMlV5tkGFJQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=AoxHugZx5NFiSaYkUrQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Update the VFIOContainer declaration so that it is closer to our coding
guidelines: emove the explicit typedef (this is already handled by the
OBJECT_DECLARE_TYPE() macro) and add a blank line after the parent object.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/vfio/vfio-container.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 21e5807e48..50c91788d5 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -25,13 +25,14 @@ typedef struct VFIOGroup {
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
-typedef struct VFIOContainer {
+struct VFIOContainer {
     VFIOContainerBase bcontainer;
+
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
     QLIST_HEAD(, VFIOGroup) group_list;
     VFIOContainerCPR cpr;
-} VFIOContainer;
+};
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
 
-- 
2.43.0


