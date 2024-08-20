Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA5FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 03:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgFQc-0008Fh-Kv; Mon, 19 Aug 2024 23:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgFQb-0008Eb-He
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 23:21:01 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgFQZ-0000yP-Cf
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 23:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1724124060; x=1755660060;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uNkCaFYoOjZaGfUSJOIYc29bn1PfBKcaia26EF6ft6k=;
 b=IS1xnQy1daU5w89jnCLTsv8h3alQdI/hLf1k5YRwVfnl6ho9pUoTnMuJ
 KoSzd2ChLKO49lN+n5kxjsxQH7vop06+x1T5D5Fe3qvwbjZRCllij1CIi
 uEFOZrznRMbdBoMh7dW47kGd5hqaXc/O9J1hZLA2D/3EEL/zcn+r3BXCc
 R3V/qlNN1X4z8a20l4d9dyUPvZ6B8Q7m++7+B90xxW56r8mrHLlxHknb8
 qMkO2cd1H4scrxXJSnOOS8g98j4NkVvosCbs5W3KFsyKFJnHMgkEJfDP7
 vrljb9qSR195mPAnNkct3PSu4o1Hw0H/iyWF+b47EjSoSrz05DfDVSWCc w==;
X-CSE-ConnectionGUID: JcBU2GzVTBSyLtUJdT/sJQ==
X-CSE-MsgGUID: UupCb/lfSga1TCPoaTF3LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39555172"
X-IronPort-AV: E=Sophos;i="6.10,160,1719846000"; d="scan'208";a="39555172"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 12:20:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGq5szdolv1pF2ldMEd6ABH2TDmwUat4E0wQtJJOM515+bc2w2UxTGOXtpfuWhlIZmLXUg0NHMme3gNJvTJzC+ZqKmUiLoSqpI8ltAot3bDkT0EPZM41AY983dzWiZYkLjVOrz8brcVh+1pvlIGlVYML0uniI4F5bvl87T+c9ig8sDaoLemWFcF6609SkbHPau0sZQXb2UNfJ6Cw8wt7moHUO8kQiIIU81J0X5d3jBR1pR/d4ZZbNiRiL0nXY60x6n6abDF29GR1Cah3QtOxTxGBH5cXSmSLRyCCgrkJlf6gc027ow2DgAxW5cgjIcr7Gl9n4oL96MFt9Kk3TzIWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KhBhV/3NQCMDFLEz4JVqEMQA3HnJwLKwqFpl11e3lI=;
 b=MyRW8uPVjnNfYUPjyzIZfnq/7eYqGHjVq1hqo1JQus5dqXAwHe0nwO+6c6M+omXBNKdjdNHJ3xHGjwEhqEHsVAy8ARXl4p0guXfoPmk4MbvkbuxdLq5UAE2DgoFgbji1bamIOmAVQJneftp1bC9YScDXAexgUCZtk1tGvQApt8BygOo6ZUblb3pp50EU3X1GUK965BR+/0DnPSTFBFjznwjTkBx3pCyhDXUTjmm6xa1IoQ5Zzw0O0cVvyrEkgkhuHVBKYoRgeOprNP88q37OfBa3an130oE3S4R2dtmjtz+QwTT6G+9i1/lTcXRt8hcdiJrObOLekj/nSp1qk/nnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB8684.jpnprd01.prod.outlook.com (2603:1096:604:154::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 03:20:52 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 03:20:52 +0000
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Topic: [PATCH v4] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Index: AQHa3nZ22xYQBEGwKEWqyF7g/GHEEbIvou+w
Date: Tue, 20 Aug 2024 03:20:52 +0000
Message-ID: <OSZPR01MB64537362C8164F54C511DFC48D8D2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240725093819.15549-1-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240725093819.15549-1-yaoxt.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=6195a5ee-a24b-4700-8da8-ae485b7b2c24;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-20T03:20:45Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB8684:EE_
x-ms-office365-filtering-correlation-id: 30bbaa89-085a-4853-7d67-08dcc0c718c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?Mkw0TDNLWlVIZktYNzd1aWxuTXJaeWdZMi9zWHBVRkhiTWVzTlFJcWl2?=
 =?iso-2022-jp?B?Q3kvUzVDSGZsRmQxNGw3dm5XZXdoWnZycExNQjVlZ3dxMzFhWVQyMThv?=
 =?iso-2022-jp?B?UmJHYWdkUFk3aXdyUlBUbm52WjZkYVVjUWJYejNGUjV4OW9QQm5pL1Ex?=
 =?iso-2022-jp?B?TUlxdStCVlpRSnk0YndRd09hbWE2V2dxeUN5bEpmaDZQVnRENGVLc1py?=
 =?iso-2022-jp?B?S0V0OGhLTnBoczNBcW5tWGlMV2xZRmJJSWlicTBQR3VIYVFBUHdHZ2s5?=
 =?iso-2022-jp?B?cGlIV2ZrT2tTVmpKOW82Rjh6WENDNi93bUN4a0VlUHFMMXFlZWp6MGgr?=
 =?iso-2022-jp?B?RDBIYi9UOWtYQnFRcmc0ZkVCdWxZRDlFWDhNWldkMGFIQmZ4K2VpTDE1?=
 =?iso-2022-jp?B?Zk5SMGl3dkVLTTBobnhFS2MvNXJtNGdwZzZGL0NSRGpQQS91YkpSb0tH?=
 =?iso-2022-jp?B?czFPNWhnMU1VMHFGNDc5d1UvczNKTDZEbERVcUlZbk5ZcGloU2xJZXN4?=
 =?iso-2022-jp?B?Q1RSSHFCK0J1bXhXWm9hQ2VjWFI1U0NnM0Y0NC9xSVo4VFZITDVySnY0?=
 =?iso-2022-jp?B?eE0rRC9Ccys2Z1k1YzJWVWR3Y0V4MTdNK0RWeHZORjMySE52VE5aOG5P?=
 =?iso-2022-jp?B?T1RoRk53dS9sOTZEeFlpVFJhTjcwSFhLOEhtNTByVllYRXk1NXJ4NGVq?=
 =?iso-2022-jp?B?QXVtbGRGcWszM2R2amRRMTdzaFdMM2VwR1FiOWRaWTZCd0JvRlU3Zmo4?=
 =?iso-2022-jp?B?WHFlQndhT05Vek4yek1TalpxdklDbVVnRzVhTzZVSUMySnBaOFZLaXV5?=
 =?iso-2022-jp?B?TmpidThwNmJ2OWV2Si9oemcwVWdMSkJiWXFlTVB4eWhkQzBZWUFhUTRH?=
 =?iso-2022-jp?B?R29uN3BkZ3R3WDMvaldIZmRpYUxRRllEbUROM3JNS1JDZTVTYmZlaGxZ?=
 =?iso-2022-jp?B?M09YWFNUc3BPZUZBVmRaWU10cXQyWG9FRjJrRjhUU3haNTkxTzNES0xE?=
 =?iso-2022-jp?B?MjJLT2JQalJDM2R3aEN4RDhwOWZZNkNwOENJOXovRGozSjZsUGk5VDFP?=
 =?iso-2022-jp?B?dXlwSnJyaG5sSzdwMFk5OWxsOWhiRHFMZ0JXV2NEK2ZCVFNIZ1NiVEl6?=
 =?iso-2022-jp?B?WG50Zm8vc3JwVmZKNVlza0FxVUExYmN3R1JmMmlQSXNZVW15NVpnV3E4?=
 =?iso-2022-jp?B?cHVya1dvZGxzRmJEenN3cDJiKzJiMTR3bG1TK2ZYQmg0UDhYclJiZmFK?=
 =?iso-2022-jp?B?YUI0dWlvMkhHbTY5b2RlVGoxenVPcGR2Yi8yZHF0WTQ5OU55c3pKdDhY?=
 =?iso-2022-jp?B?UFZPMmNzY0xXWHFpK1dEVjRlVEV4M3NUZWJ3dGF0aGdwc3E0a2NQdEJ4?=
 =?iso-2022-jp?B?eW5yb29manNOaVk2M2hCanJvYm1GSmIzcFkyYXZvL1FLbXlacDFFMGto?=
 =?iso-2022-jp?B?MXBoaFNKOXpkRkFQNE9zc2NrbUJ6dWtQL3dTaStDdmM0a1hydFl2M3dY?=
 =?iso-2022-jp?B?SitaWDROTEQ1ejZVdFVFMjhFTGN1MXUrZUNkNW1DZHZPUmdaMVpyM0lJ?=
 =?iso-2022-jp?B?SDdNNE9JbkQ4OTFqSTI0emJJR3g2REZhRDAvUVNleC9QalBPc0JKbGVU?=
 =?iso-2022-jp?B?eGhxZzhhN2NrSVAvdUVqUHB6UWx3V2dlSTRsdzcwQzJnSy9tUFJiOFgy?=
 =?iso-2022-jp?B?U2k4VEJQTGxyVk90RjErblIzV2NZNmlWa0p0V2JZTWdjSXc1Q2lJOUM2?=
 =?iso-2022-jp?B?MktuT0pRVkJXd21xVUlSTWkrajRMYjdBcXMyWkNSV0ZTVThEMkJwdDhs?=
 =?iso-2022-jp?B?NVJiVFpjWlBrYUtUMVgwekJ1OWhhTzNhc1kvT09MN0VaNEpDM1lOZFlU?=
 =?iso-2022-jp?B?Q3hGbzAyc1AvYmZHZTd6REVEWTc2RGVjRDNMU01OcWFiZXpZYjFRMk5Y?=
 =?iso-2022-jp?B?am8xVDBvbEpHNnlkL1Q5THdUcTNRZUxKMEtCdkFISGdoTHQ3azl2K3Nu?=
 =?iso-2022-jp?B?OE1Wd2N1eE5VVVlCZUZET3VWbUwxUQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Vld1VzBXZFJ0WE8rZkV1dDFsT3g4Sjk2RzUyVm1OUzVCZVNnNHozekF2?=
 =?iso-2022-jp?B?VFRDNXo3TVJHSzJpM2hMNkZEK0l6TldTVERSRnNWQmVTcG5Eai9admFz?=
 =?iso-2022-jp?B?QmhVL1AyQ3hJbDdZTC9rNzc1MlBDQW9NaFRyUFBkb1M5OS9pc2xTS0tI?=
 =?iso-2022-jp?B?UkhsSHB1VnNOUkZzdG02TW1ZQ1NGY2w5czA0cUg4eG0zM2J2OGhwUjJm?=
 =?iso-2022-jp?B?Vi9sSjlQRCthUTlXdUppdTl4VHQzT2hYZVpwWXh5aVpqb0E5TVphSTdk?=
 =?iso-2022-jp?B?RjRFRXJRc2tRWGNNbC80Z2h0aXhxc0c2OGw1VmhlUjJJdWxnaDNxcW4r?=
 =?iso-2022-jp?B?emFDOUFXUEhETDU5Z3dYa0kxeS9UcWhZUzJLVkYrQTdRRjBhbVFJdmlF?=
 =?iso-2022-jp?B?aUNTNkV1engzNWx5RXFrL0Q3U2tneUQxc0MwMnEwS0NzQkljL2xWcTNX?=
 =?iso-2022-jp?B?emFTcWd6ZEhEVUpnTVdHaWRRS3pvcUpZNFEwS25sVUZQZGpOcmtaRUhm?=
 =?iso-2022-jp?B?V2JZWDVuVDhpVXd4elNWNjNCTXErVHY5WVhGQTg0Q21zblQ4VEM2bEcw?=
 =?iso-2022-jp?B?bXhNL21yZTlrVUZPTlRoRTVoRFFFc3BzaHh6YXF2bUVVQzR5Q0RkRlkx?=
 =?iso-2022-jp?B?Q0JQdmtLclI4ekZxaFRWQU01T1ljSnl6VlBMazVzbk1mTzZ3V3JYMjVX?=
 =?iso-2022-jp?B?WHlSdFdKbTh2ampJTWVIS1p4UG9lMVhhL3JHcnE3cnh0K3hnOWJvSjQ1?=
 =?iso-2022-jp?B?ZURmL0xYQnM3eTh4MkNFeDFjNWVFRHRDYWV2VUlHemZmL2RTTDFXV0RE?=
 =?iso-2022-jp?B?endMSmxuT01sb3BnNnFVWjZHbWZYeGx4NEdBc3IvalljLzJLM2VZQWRQ?=
 =?iso-2022-jp?B?WFlzZDE1cnVsenNDc3BJZkdqUnJTUlNQZVBzMU91VUZLeU1Ia0VnSnEr?=
 =?iso-2022-jp?B?bm5STnJIYU1XTmdHaWgwRm9nZGRVcmo4Q21kVzM5OHVPQ1FIZWxNQ1Zh?=
 =?iso-2022-jp?B?STBlS2UwTE9LS0VxVjZ0eVZIeWhEYUpadE1hMmFzcmV0THp6NHVxUlBK?=
 =?iso-2022-jp?B?ZWdhdXNUT2ZBbU1MeXovY1JUUzYrSENDeTR4eGNNWnhTZmtpTDZVS1Jr?=
 =?iso-2022-jp?B?ZDVUVGxtNWUwVVU1VWFZeHd6MitJQzBNQWZqdFUzcWJGeXNjcStlZHgx?=
 =?iso-2022-jp?B?bzFVbTBYLzRCR3Qrb05tTlZETzQ5ZC9QVVArbGJyQ1lUYTk2ZFpYZDlF?=
 =?iso-2022-jp?B?NkNYZnhIMkxhODhoR0krSFFTZUNjR0pQWVEyTXNmdWFKU2FmR2VrYkYw?=
 =?iso-2022-jp?B?KzFKYkhIZ2ZyaUZSdHNITmpINzJsbWczSHJLL0YxTTQ3MWZnMEp6bmhN?=
 =?iso-2022-jp?B?T2lGTnE0bWQ4Qk5XaExscEZyeGgwNElqNnNGK3JvRTdSQXYxUUFvd3pX?=
 =?iso-2022-jp?B?M3R6UGQzcmk0RHovNUcxMitqTTdaZXIrOWJpL1k3Sm1tbUJxM1o5Slds?=
 =?iso-2022-jp?B?MXBhWjVEc1BPUnJ2SU5qMjMrang2T3Fha3p6NUxuWHladGhBQ0c3bEVO?=
 =?iso-2022-jp?B?ZkJNSmJYazBUZFVQbyszK1RqSnNPaERTUG1MWnZYbWpNeG5McldxU2Rs?=
 =?iso-2022-jp?B?a0hjTEU0SW5odnA2NG44Ry9yNjg3L290N3BLTjRub3lRR1JsTE9SSTRG?=
 =?iso-2022-jp?B?ZXRIY0NpQTBIajMxaHNsa25jb050VVViTmtoWitBbVFXZU1FYVJPeXc4?=
 =?iso-2022-jp?B?MnpyMTM0OVU0OVRnR1RWaVU1bWlzT1JKTHhtOHFhZlg3WEdSODJidDI1?=
 =?iso-2022-jp?B?bm9nZUw1V1BYajI0RHRxTSt5dTR2N1M1TkJKaXlWSDZlQ2FLc1E1a29q?=
 =?iso-2022-jp?B?dHlhTEJHamR2NGZZd0h1VnNRa0NJUzZyTFNKenhsTjRkbjI1NVVEeWs5?=
 =?iso-2022-jp?B?WHk2eXFRSWtlMDdVRTRRVlk3alRveVMwakUyeDdRdlNsMjlwVWROL0VV?=
 =?iso-2022-jp?B?dXZ3bUhDb1RHMnovRkJ1RVpsci9Xa2lQTmtXSkNEM2RwZTB6V3dOQzZn?=
 =?iso-2022-jp?B?emhuc3hxUHdxRldkTksrZUdnblU5a3FOYnNySHBiWDRGY0JZWSs2QUJS?=
 =?iso-2022-jp?B?bkpMaGUvb0gzUWo0UG9WWnVzQVMwdC9MVEdZWEdOMWY1Z2pVajI4SE54?=
 =?iso-2022-jp?B?QkxyaExOODlHOVU2K0ppbmJaNWV2QjNLVmRZaDg2dzJGMGMvOXB1M3Uz?=
 =?iso-2022-jp?B?Vnl0LzZGVmRKeVBFT0xLQlhWWHhMNXJpV2pKSWIyUHk0UC92N2lwU2d1?=
 =?iso-2022-jp?B?RmMvSQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 47GCSbdHYIUfKOGrNc5M8eTty89ZCVsrapasPFn3xVCp/qbb+z9R4U2YW5R8TQpcNEJt/RoA7vp9aknWAlOKN5pQV8tuGRe4tYrWxoC3pED5Gk6sKfjpK/Qg7BCG+Fr3lYmdOxUJifo0Llje6DZzM7awljuJwLoWk/Dn6S1x+iR+s2IGxesRe5bRD1UfXANGQ0dsMmAmFz1dbJ+9M7fHTzp2yz3R5FR68qiOkNGDAJeHrMnJPCR3Yqxu3x+dhiqCScVfSEEBmxUPOYR/xyYBDGlJ/iz8Bv5cfZ6+6hxmfv4vRrLWEw7TfZfaUmxvaGBKV7w3rM5szR61Lu16QTqTH1UddDtduxFdMQv3c1J3TqMn1O7jsyJ7e1Ilc2ZrRMbslsrpcJBjBUzac//GodwJpBmDpxKsrbWXwtdFJndaMkURRQUPla1xHGxGpRThoqCyXj0zLJFt0qxm2UBO0FHs8wkEpvG4YfG0FAXbzFcun0uRA9qEZC1VP42UO9hF0EyJtJIE4CAF0wvwmAQ6muZF7Atuz1i5xly/nurUTMpB88hUw+cwT30bsQaUOS9/rcVptFDM+6Xgns35eM4b855sXsYcvZ+Fho8DRl3dPkGICDv2LXdBx7ScSQorlAMD9I5i
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bbaa89-085a-4853-7d67-08dcc0c718c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 03:20:52.5820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7POrEoDLZP55rk750U+vYlmJ5wVW2fI8V5H0sALIPyMG2RTvXxT+/YygP49W1xFIaXRUXwbQ50PQMA64dH9R9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8684
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping.

> -----Original Message-----
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Sent: Thursday, July 25, 2024 5:38 PM
> To: mst@redhat.com; marcel.apfelbaum@gmail.com
> Cc: qemu-devel@nongnu.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaox=
t.fnst@fujitsu.com>
> Subject: [PATCH v4] pci-bridge: avoid linking a single downstream port mo=
re than
> once
>=20
> Since the downstream port is not checked, two slots can be linked to
> a single port. However, this can prevent the driver from detecting the
> device properly.
>=20
> It is necessary to ensure that a downstream port is not linked more than
> once.
>=20
> Links:
> https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8D
> DC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>=20
> ---
> V3[3] -> V4:
>  - make the error message more readable
>  - fix the downstream port check error
>=20
> V2[2] -> V3:
>  - Move this check into pcie_cap_init()
>=20
> V1[1] -> V2:
>  - Move downstream port check forward
>=20
> [1]
> https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujit=
su.co
> m
> [2]
> https://lore.kernel.org/qemu-devel/20240717085621.55315-1-yaoxt.fnst@fuji=
tsu.c
> om
> [3]
> https://lore.kernel.org/qemu-devel/20240725032731.13032-1-yaoxt.fnst@fuji=
tsu.c
> om
> ---
>  hw/pci/pcie.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4b2f0805c6e0..1e53be1bc7c5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -192,6 +192,13 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
>=20
>      assert(pci_is_express(dev));
>=20
> +    if ((type =3D=3D PCI_EXP_TYPE_DOWNSTREAM || type =3D=3D
> PCI_EXP_TYPE_ROOT_PORT) &&
> +        pcie_find_port_by_pn(pci_get_bus(dev), port)) {
> +        error_setg(errp, "The port %d is already in use, please select "
> +                   "another port", port);
> +        return -EBUSY;
> +    }
> +
>      pos =3D pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
>                               PCI_EXP_VER2_SIZEOF, errp);
>      if (pos < 0) {
> --
> 2.41.0


