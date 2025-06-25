Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD82C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpH-0007zO-Ga; Wed, 25 Jun 2025 15:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpG-0007zG-G3
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpC-0003Gn-RA
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:30 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PHZeal021791;
 Wed, 25 Jun 2025 12:30:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=N4EobuCCtWRuZK8PlH1YWzQe+7zofV6zf3JMiBNLN
 9Y=; b=s1DJYa2DDWCdPdg451S8fDU8CRq/PIvT8mFZBoD7HQVLTGW7ThA0f2wx6
 evRyxOrieCG9qvxLZAWB12TLOnGd+8IN4sp180lS+ClPlYSWAU9TPw5EPoS1gYmb
 Cvqrzc+QcvDAh0/k+ehKydXktJVyRKtVMxHVo9v9+3hIbtoNnKkvVvInXi//69TW
 6h/dpWnhu7u3+kWnVMdQNVmW7nE1r/2eBpgVpC0nwp0+p6zVnUrTxaBKw4BLnc1J
 X8/zRD+G2L2RD+IjRCruV7QZq7eFNSXGQOnaWlZOVgPt0TXrcIdAnE3Ze3pdYtMw
 f5WzUxAZ1fHCSBBizFrGiQ0XxPBKA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2099.outbound.protection.outlook.com [40.107.101.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47geghhf7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpkCWuUILwzDac6FiCBJt85NICz3YlKbBGKuRPRNQmL0BpY+TXVcb5M4j7oyIG3YD38KNJCu5gioXwQFy3Z01F5rOCfHuqafJU49AEGGlP1vdEKBLov5xAcYFEXL87mEyY2wHay61A8nFIQF6YYGT3928+VkLnekU+RK+3RlyQi/nzpndwIsN+McEyQETkM6BdsagPFd0+QyFKa04ifYY4zyVScfzmXB1qKp22/4RIJZ1QOS6bIqxYkXPDiwl0uccJ+z8Buz0iuLRNiYpbScHU6NWfqpVs2vNjoTCsamrYfJmO9PzcoCo3ZMy3MqLxaiU2o9wqkXXtPQva6VwkeYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4EobuCCtWRuZK8PlH1YWzQe+7zofV6zf3JMiBNLN9Y=;
 b=CfEbh96WOo1jXyGKmBnLxuQ5Tp4IikQrJz5sDzmauyKSzV0vFCx3vrX/GyrlLSmk89HgvvEKXz8asCY8HilQ4kTCvCrVZfI6y3nAYeWySSBk/AOa/vtCzhoBZmOhgbvwTdVkB7up2Jl46jyYGGsCexfod81g2wx5RRI4GdFh34mqA4P0A4l+c3vJAe29lFPMz43iUily8v8BkU988bjlQ/ovlRUosKHEwQcMQ+IPFZUu5mLuupfGlHGjPJoK2E7KHXYrK6gaa/cqbhE+oIZSRywUUQDWp1Nkz1/UzbFNUwIDXk37L6QDDWgKHiUeUlHRWRTyDoOxDrbwEL9CD+G1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4EobuCCtWRuZK8PlH1YWzQe+7zofV6zf3JMiBNLN9Y=;
 b=Nq01H6/gos/2TE0lxGO1b7iYYZj1il1/FLNDB+oISAc9/Lbl3MZUXEL8gxLIQNg1v5FC6MH4q/sbB6lEruyz8r8ybvMyGRzON0pWvQWkiYvVze60Xb2zkGTPzXvWfXjf9Tsu/9osbpW1E4PPDtnuj9I4fo7QWcgFPq/7iHY3Db2ZSM/NLxYWgedOa9kHhWIrh7D4VATOXKEyrxOuXX/21n7Kc93/W8uxSkXj6Tk0sT8f4AdczEVjuqoI3GlZzsom58N/OAL0YM0F1s8K2un9FwdatMwh8kf8BBDTw7rVKCJrXFED4pK4BpzWEB8rWL7j71utbsqvUCsrTC49zf9YmA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:22 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:22 +0000
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
Subject: [PATCH v5 02/19] vfio-user: connect vfio proxy to remote server
Date: Wed, 25 Jun 2025 20:29:54 +0100
Message-ID: <20250625193012.2316242-3-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc576bfe-e256-40b4-4859-08ddb41eba4e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEpodlRpbDJpdWFNNlRqc0dMcUZjMTAvdGtrWlREQmI1YW9LUTMxS1pWZVdR?=
 =?utf-8?B?VlJXbFlrR2lvWC9YaGRsdURyYnhNSzBDVG1WOGNnVjVLQkxRZ1dQZGhvYWxr?=
 =?utf-8?B?M3lsWE56aTBFekg5MTZwN0NhdGRHd2hFUW9nMW1iM0dWTExOZE4zMlFGbS9O?=
 =?utf-8?B?TktZS1crUElLRWZVTlZ1MDA4MDRmeXlkRGZpdG1waXQvaDd3TFJTS0swUU40?=
 =?utf-8?B?alQyaHlRME5iL3BCcXZiV0MraUJtbWFNa3psLzVRaCtXOWQ2aFlWdzhYK2JP?=
 =?utf-8?B?WU42QzdCbUVhcG5YbGk5SmpxVEhQNmpHWVhTbnA1aHFkU2pYN2x0c1IzTXRX?=
 =?utf-8?B?WWJhTThYc0xSa0ZJMVZVZFBvSERjVHNYK1B0RjFSZ0EwaXFNTWtxbHdKQmow?=
 =?utf-8?B?bUk0VVRFcEIzd2wyaWliTE1EeXNZNVhTZ3VKTHEzOTlSSThpSjgvZDBESHYr?=
 =?utf-8?B?SmRlQUw1Ty90ZXJ0THBJVkxMQU1zNlk1cm4yV0U3TWt1bDhDRUl4M3NWRVRT?=
 =?utf-8?B?UDZjR0RMYVBrU21MWlhVYjB6NDUxT1hzZGJacnc1c0J0QVI3SHRwRnlxb3lG?=
 =?utf-8?B?c213MHlGSHA0cGRia2t1TDZsWmxYeC9heFFGMWpkcGdQWk56cEpHUHdBemFC?=
 =?utf-8?B?YUJBd0dCeXRKTnRsM0JlS3ZWQnk1dGVYcS80Y1VmTVR1ODF3d2hrN2pRcjhu?=
 =?utf-8?B?a2tKam1DSWk4YVhJNTMzZFBrMHB3S2ZEWEpsNWpjSG5sRTBZQ21EbmFGV21Y?=
 =?utf-8?B?aVZwMmt3MEtFMHZGaUpFQjJ6MkwvMktTbmg5SlJraTFLRE9rcGpJRFovZUV2?=
 =?utf-8?B?OENXVmMzRzQ0c2FwYVpvYVhqbjdjdXNxLytYWE1YTXhFZ3VrMXBQTDNGVmtp?=
 =?utf-8?B?VzVpQWJsZmxBQngwWkkyL1ZmSWZtRkpsYmNpTXY1aWFzbFZaM1g4Nzh2Qjll?=
 =?utf-8?B?RUNKOERteUlWTFhzMURPeURya3pMMXNZb0loUURkNEd4NHBUZEVIYTBCMFEr?=
 =?utf-8?B?K2lYUWxXZVhhcEc2bXRCd1FqUmVVelEzVHRvNllMcUtVNDQ0bmwrcTlCSlFU?=
 =?utf-8?B?Rkwxa3U0RjBlWTdGaUxFNElaWkhnQmdBb2M4SjZaSGtUK2tEY2tBNFNQbm9H?=
 =?utf-8?B?NjRiU1JFZ1hiSkg3VVQ0dE5rS0xKZUJ2Sk8wUE5pVTVHVWV1bGNCa1lJS3Ey?=
 =?utf-8?B?Sk1VbXNldWJDczUzZE95TGQrRkdrVFYwSlVBOWxWb1RVVXBnMmhyWEJ6aUh5?=
 =?utf-8?B?WTRuSnhLSFJzQVhGVVBVSlRpY1hKYUVObEVPZGJsc3gxTzlTZlEyb0R6NmE5?=
 =?utf-8?B?U3kxdjBnRitjUWpmZmQzTmdWM0F0SzdyVFRQdjh5T0NTR09ZV3BZMENmaUxO?=
 =?utf-8?B?V21Pa0NQbEpNdGdFM0l4NGF5MGM4b1FmTlRSWDA5Zmxqd20wRUNPU0Vhd3Rk?=
 =?utf-8?B?ZkhGSDI5dHdabFBzcnF3cG4vVnJUYlNMVUFvRUdiWjZpYy83cFZ3amlHWXRz?=
 =?utf-8?B?RWhuUDZsSFRGOWw3YVBKWWNBTTVwRWRxSGRMMkZ3REJ3UXBHc2xHMzBoVSt3?=
 =?utf-8?B?YTZEK09LTjlRZlE4Z2JVQ3crNGJKUEVlNjRRVVlKK0R5NTYzNGtvc1ZBUk5o?=
 =?utf-8?B?UHhic3J1WmcwWHRMZHhPUGxxS3kvOHhlbVU3cFdVNithZUJYNFlOWVZXZHZT?=
 =?utf-8?B?MDhPaTQzeHpiNy9ta3h6OUxSY3pOeDJUYkJzcnQzY1F6RUVUSGpxN1NvTlc1?=
 =?utf-8?B?QWNVNFF2dWRFd0hrUnoxTTErZUJmM2lpL2toZXBwdk9xcUljL3lXQ2RmUGZk?=
 =?utf-8?B?U0pGbUU3YlZqUVppdUU5Wmdxb1NuZDlrR1RUcmRKdXE0TFRLN2dTdlNNRVhn?=
 =?utf-8?B?Uy9yTXNWU3JHS0tnYk54elc5SEttQjUxUDFuajNXS1lkUjNQajF6SC9hRjZX?=
 =?utf-8?Q?UCfQO/L4lp0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2w3dkJkMTUrOHkyeFczdTgvSGNrZXU2bnR0N05uRGl1TjRvSStjN2tMbzRq?=
 =?utf-8?B?cFJocVF3VjA3blFMeXhKeHFiNWRWKzhxYTFTTTZXK3hqWXdVSVpsTjN2d3Yw?=
 =?utf-8?B?bEQ0RHp0N1hSZDE0eUJ3cU0rcnRtMmx4cEYwZUVURVJVYkxKWStUOVFJRHEr?=
 =?utf-8?B?bTNpQU1DQ0pEUHQvekJWbGtvbldTMU9HZXlSb3I2ZkEwdytnMTdSbm5lRmVE?=
 =?utf-8?B?aVZrWk1NeGkxTHcyVnJkeEYrYVlqMThwOEhwRWJ6VTFmSWVRclF5cFEzcmNW?=
 =?utf-8?B?MVRlWGNsYTN2THo1VDJzbFBzTllUUjJueEREeGxmM3puNTNZVmtKbXFsbjhV?=
 =?utf-8?B?cW1mRlRqb0orOXZmTkxKNlBITElwKzdjeXNNK0VMR0FUdENGMTdaSnU5cjFx?=
 =?utf-8?B?Z3RpdkpOMDZ1Ly9TS3lzbHlkSFVRQVAyOU5RRnE3SHg0Y3diNGdWQVJCNDZN?=
 =?utf-8?B?U3g4enBLU1E3R0tDMnBZYTQydTNkK0h1R3VKakg4bzNkcFJ4Z3I3RkdqYWdV?=
 =?utf-8?B?a2hmelp4UXB0LzFiT21EUWZMU3FUOFl0Rktoa28rUHZCakxBZE5MbHYrVjh3?=
 =?utf-8?B?ZmhjY0RualpLYmZpeXEzUm9iM25TQlRoVXVZdUNxMDdpM0YzUmVrZ0pzcEM2?=
 =?utf-8?B?WFlCcnloOEZHYWV2MitiZ2NCMTRnRVYvQ243eXNaSGx4RlNYVUQxYW1PY2VX?=
 =?utf-8?B?NXRTc1ZjcTBWTmlkWEVFWlYvYVQ3blNnNnhXb29yeFhDV0tLTXVqZnhyUkxV?=
 =?utf-8?B?bm5hMVlDQ2NtbnV3YTZwNnZOblVHNHJzdExNdlZoUnpWQ2JJOE41KzRzTWVY?=
 =?utf-8?B?QU54TG5iL1V4bnhpSzdva3ZtbFY4TmRwcjhXUVlpeGQzSFk5NVZ0elo3OHVa?=
 =?utf-8?B?OS9aeG5GU2RHZWZpbjgydHZhdzJ0RXVIN1RnMWg2QlA4QThJR0ZwRldPdkxk?=
 =?utf-8?B?cVlmdVVBK2RPQ1BnMFpVQ0IxTzY2V1owSWJhQi9tcDRSOHhEc2lTZHJLYWty?=
 =?utf-8?B?S1ppeUpBMk1yd3lOMkRXclg5dnpzQUZqNlBTNjlRbTRaSndQRDEzMGVLZ29U?=
 =?utf-8?B?eHJxbENUcmN4R2RQMkhJWW1qMFlvc2RpSGN2bTFZTEIxdnhVcEx3REQrV2JD?=
 =?utf-8?B?RDN0cTBLUmNCYk1MWGVHREdSMStTYmxRL2crT2hUUmU4SytWSnNueldHMDhq?=
 =?utf-8?B?QzY4b3NCcEY5VEh6YlVsZTFQRHZFays3MUZ6L1VMb2lzb3NFU0VRalJOeURn?=
 =?utf-8?B?a0Rkbk5IOU40aU1SYjhmdE9JRHRhNTRnZVNXMElDK3pOWC9oUFNmUTlNRGc4?=
 =?utf-8?B?NDBVTlVvNHI2a2I3c1gyOXdXSHJlM3g5b2lIcGw0K3o5YyttTW1TNjZ3bjZY?=
 =?utf-8?B?UFZnT3ZycjRYeGF1ZjZQUDBtcVZDU2R6MDhSVWJuL2JseWpHOU56YWt4Q3pw?=
 =?utf-8?B?VWkvRWQ4RVRHTS9Kd21pNFZFbWlWUzNFcE8veVVTUmpEdlpBVkwzOE1nNEtF?=
 =?utf-8?B?cVVTbk5PSTJNb0FheFhNUWpsYUFSakhQVCtrNUkyUSsxdHVXSlAwdC9xZjFY?=
 =?utf-8?B?TTV0OHJuZ0ExRkJySUxBQ1dnWWk0L2QxdEJUblpzdGlhMEZNak5IV0RqVUU2?=
 =?utf-8?B?L3NIdm5jTkdoRm9lUGRWSStKcFZoc1locDg3VW4wclozSW9Ud25vdS9Lc1hn?=
 =?utf-8?B?N081RFdHVDduc2FON1hwMmJmYmY1OVZFNHZzaXkvSG5GVmNiZ3FmZ1B2ZXp4?=
 =?utf-8?B?aTVYMHpvOGFqQ3FINVYzeHVrc0hiYkNuNzBIeDlueDlDSXpia2VWekhIOEpz?=
 =?utf-8?B?TVB6UlFYVXNnbXRzTG9YRVdEK1JJMzk0VHhpVnYzSUx6VU1OUDNhOVd5Ri9w?=
 =?utf-8?B?a2MzTWdPU3lvWEZZL0g0QnVHTTVyakEzV1VDQi9yemJ2cjNMNzdubnpNK3Ry?=
 =?utf-8?B?Z2Vwc0JTSi9wNzlpVGxtaVhIOXdlWUoyWXdXVnZzbThIV3lMdElGandWU1RE?=
 =?utf-8?B?YkJ6ekF5RnNvMHA0Rnk1ZGExenNMeUM3dUFLVmZvcVpyeDd0R0FhS3hMVitx?=
 =?utf-8?B?bEVKb3VTTS9KT242SnlWa2N6Vkg3bFVZeG0zZlNFYkR0TlZudHgzWnV0M3FW?=
 =?utf-8?Q?6j0yqLlMenP5beNPQfiOc4/vK?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc576bfe-e256-40b4-4859-08ddb41eba4e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:22.7908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiIcBFd4Us7n7Nyj1sj8/X+gK3b8a0bDeMhTh3gnaqY5UfqAt5hamY4xLEWdC52RB0i+yGNX1nqyqwuHeEMLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=fPo53Yae c=1 sm=1 tr=0 ts=685c4e50 cx=c_pps
 a=BDhOPDsQvggip5BazaeBNQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Fsi43M_n0QUer9rQu0sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NCX869KavWWMU1PznvFB8fPtf2b7zfQg
X-Proofpoint-GUID: NCX869KavWWMU1PznvFB8fPtf2b7zfQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfXyr/hSlz19Bm/
 TALKAsTUaxhAC+LaOmo2hh0dS/F91KAfXQt2gYuEOQuadwzWr3/XLVqB7lDFqaWqsdQ92+HMf0n
 wjqDeYfB1O5B3XwZzscfGOLypclWJ6ueQ4uSYLTeIdjCgI0A8zg1wRbQjTNA9MDvt7Zl4TuBNXU
 HX3ku1pj7KJ7UIREDBre12NJ0Ipfqh4ptw9peS8s6Gmjs1ba5RW9K19V5UuF0DwttxgCMHSXSUB
 3PWuYHVy2c68x6KXXHZXZtm2mSFERRrGLbgnQMaBhX+l+0Z8J0Gsbql9kQx0TYbRBNx23EyzpfN
 7rNA2wWQ80c8uZGTT6q7yitGFmc9STfsr+UDzd2XFDof6B7AJ82314k7YmYDlev6fNDTP89uMCB
 1/pe3+IRE7wKbSx6hvW6/NqUZDSfaey0tTJTjI6mv3F4gZgAn+KVupNJModcvx4b1B48WX96
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

Introduce the vfio-user "proxy": this is the client code responsible for
sending and receiving vfio-user messages across the control socket.

The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
managing the proxy; initialize the proxy during realization of the
VFIOUserPCIDevice instance.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h          |  79 +++++++++++++++++
 include/hw/vfio/vfio-device.h |   2 +
 hw/vfio-user/pci.c            |  22 +++++
 hw/vfio-user/proxy.c          | 162 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/meson.build      |   1 +
 5 files changed, 266 insertions(+)
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/proxy.c

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
new file mode 100644
index 0000000000..a9bce82239
--- /dev/null
+++ b/hw/vfio-user/proxy.h
@@ -0,0 +1,79 @@
+#ifndef VFIO_USER_PROXY_H
+#define VFIO_USER_PROXY_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "io/channel.h"
+#include "io/channel-socket.h"
+
+typedef struct {
+    int send_fds;
+    int recv_fds;
+    int *fds;
+} VFIOUserFDs;
+
+enum msg_type {
+    VFIO_MSG_NONE,
+    VFIO_MSG_ASYNC,
+    VFIO_MSG_WAIT,
+    VFIO_MSG_NOWAIT,
+    VFIO_MSG_REQ,
+};
+
+typedef struct VFIOUserMsg {
+    QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserFDs *fds;
+    uint32_t rsize;
+    uint32_t id;
+    QemuCond cv;
+    bool complete;
+    enum msg_type type;
+} VFIOUserMsg;
+
+
+enum proxy_state {
+    VFIO_PROXY_CONNECTED = 1,
+    VFIO_PROXY_ERROR = 2,
+    VFIO_PROXY_CLOSING = 3,
+    VFIO_PROXY_CLOSED = 4,
+};
+
+typedef QTAILQ_HEAD(VFIOUserMsgQ, VFIOUserMsg) VFIOUserMsgQ;
+
+typedef struct VFIOUserProxy {
+    QLIST_ENTRY(VFIOUserProxy) next;
+    char *sockname;
+    struct QIOChannel *ioc;
+    void (*request)(void *opaque, VFIOUserMsg *msg);
+    void *req_arg;
+    int flags;
+    QemuCond close_cv;
+    AioContext *ctx;
+    QEMUBH *req_bh;
+
+    /*
+     * above only changed when BQL is held
+     * below are protected by per-proxy lock
+     */
+    QemuMutex lock;
+    VFIOUserMsgQ free;
+    VFIOUserMsgQ pending;
+    VFIOUserMsgQ incoming;
+    VFIOUserMsgQ outgoing;
+    VFIOUserMsg *last_nowait;
+    enum proxy_state state;
+} VFIOUserProxy;
+
+/* VFIOProxy flags */
+#define VFIO_PROXY_CLIENT        0x1
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+void vfio_user_disconnect(VFIOUserProxy *proxy);
+
+#endif /* VFIO_USER_PROXY_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index d45e5a68a2..7c0669de0d 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -47,6 +47,7 @@ typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -88,6 +89,7 @@ typedef struct VFIODevice {
     struct vfio_region_info **reginfo;
     int *region_fds;
     VFIODeviceCPR cpr;
+    VFIOUserProxy *proxy;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 86d7055747..642421e791 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -12,6 +12,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
@@ -54,6 +55,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     const char *sock_name;
     AddressSpace *as;
+    SocketAddress addr;
+    VFIOUserProxy *proxy;
 
     if (!udev->socket) {
         error_setg(errp, "No socket specified");
@@ -69,6 +72,15 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 
     vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
 
+    memset(&addr, 0, sizeof(addr));
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = (char *)sock_name;
+    proxy = vfio_user_connect_dev(&addr, errp);
+    if (!proxy) {
+        return;
+    }
+    vbasedev->proxy = proxy;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
@@ -112,8 +124,13 @@ static void vfio_user_instance_init(Object *obj)
 static void vfio_user_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_put_device(vdev);
+
+    if (vbasedev->proxy != NULL) {
+        vfio_user_disconnect(vbasedev->proxy);
+    }
 }
 
 static const Property vfio_user_pci_dev_properties[] = {
@@ -133,6 +150,11 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
     bool success;
 
+    if (udev->device.vbasedev.proxy) {
+        error_setg(errp, "Proxy is connected");
+        return;
+    }
+
     qapi_free_SocketAddress(udev->socket);
 
     udev->socket = NULL;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
new file mode 100644
index 0000000000..bb436c9db9
--- /dev/null
+++ b/hw/vfio-user/proxy.c
@@ -0,0 +1,162 @@
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio-user/proxy.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "system/iothread.h"
+
+static IOThread *vfio_user_iothread;
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy);
+
+
+/*
+ * Functions called by main, CPU, or iothread threads
+ */
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy)
+{
+    qio_channel_shutdown(proxy->ioc, QIO_CHANNEL_SHUTDOWN_READ, NULL);
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx, NULL,
+                                   proxy->ctx, NULL, NULL);
+}
+
+/*
+ * Functions only called by iothread
+ */
+
+static void vfio_user_cb(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    proxy->state = VFIO_PROXY_CLOSED;
+    qemu_cond_signal(&proxy->close_cv);
+}
+
+
+/*
+ * Functions called by main or CPU threads
+ */
+
+static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
+    QLIST_HEAD_INITIALIZER(vfio_user_sockets);
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+{
+    VFIOUserProxy *proxy;
+    QIOChannelSocket *sioc;
+    QIOChannel *ioc;
+    char *sockname;
+
+    if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "vfio_user_connect - bad address family");
+        return NULL;
+    }
+    sockname = addr->u.q_unix.path;
+
+    sioc = qio_channel_socket_new();
+    ioc = QIO_CHANNEL(sioc);
+    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+        object_unref(OBJECT(ioc));
+        return NULL;
+    }
+    qio_channel_set_blocking(ioc, false, NULL);
+
+    proxy = g_malloc0(sizeof(VFIOUserProxy));
+    proxy->sockname = g_strdup_printf("unix:%s", sockname);
+    proxy->ioc = ioc;
+    proxy->flags = VFIO_PROXY_CLIENT;
+    proxy->state = VFIO_PROXY_CONNECTED;
+
+    qemu_mutex_init(&proxy->lock);
+    qemu_cond_init(&proxy->close_cv);
+
+    if (vfio_user_iothread == NULL) {
+        vfio_user_iothread = iothread_create("VFIO user", errp);
+    }
+
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+
+    QTAILQ_INIT(&proxy->outgoing);
+    QTAILQ_INIT(&proxy->incoming);
+    QTAILQ_INIT(&proxy->free);
+    QTAILQ_INIT(&proxy->pending);
+    QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
+
+    return proxy;
+}
+
+void vfio_user_disconnect(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *r1, *r2;
+
+    qemu_mutex_lock(&proxy->lock);
+
+    /* our side is quitting */
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        vfio_user_shutdown(proxy);
+        if (!QTAILQ_EMPTY(&proxy->pending)) {
+            error_printf("vfio_user_disconnect: outstanding requests\n");
+        }
+    }
+    object_unref(OBJECT(proxy->ioc));
+    proxy->ioc = NULL;
+
+    proxy->state = VFIO_PROXY_CLOSING;
+    QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->outgoing, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->incoming, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->incoming, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->pending, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->pending, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->free, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->free, r1, next);
+        g_free(r1);
+    }
+
+    /*
+     * Make sure the iothread isn't blocking anywhere
+     * with a ref to this proxy by waiting for a BH
+     * handler to run after the proxy fd handlers were
+     * deleted above.
+     */
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
+    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+
+    /* we now hold the only ref to proxy */
+    qemu_mutex_unlock(&proxy->lock);
+    qemu_cond_destroy(&proxy->close_cv);
+    qemu_mutex_destroy(&proxy->lock);
+
+    QLIST_REMOVE(proxy, next);
+    if (QLIST_EMPTY(&vfio_user_sockets)) {
+        iothread_destroy(vfio_user_iothread);
+        vfio_user_iothread = NULL;
+    }
+
+    g_free(proxy->sockname);
+    g_free(proxy);
+}
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index b82c558252..9e85a8ea51 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -4,6 +4,7 @@ vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
   'pci.c',
+  'proxy.c',
 ))
 
 system_ss.add_all(when: 'CONFIG_VFIO_USER', if_true: vfio_user_ss)
-- 
2.43.0


