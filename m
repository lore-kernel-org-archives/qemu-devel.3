Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78268C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 07:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Kzm-0003k5-HZ; Fri, 10 May 2024 03:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s5Kzi-0003e0-AG
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:48:44 -0400
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com
 ([40.107.93.47] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s5Kzc-0002Aw-EV
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:48:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjkHg/9Gr4Q6NVHoa0Aai/J6pYNhx5LA45hScY0yGGlThdoewWeYiT9ktI20B1IkzaWo7T88V06VlEj4vLEkTmJxebUyVWfECVd/b8jbcgF1Ymymoj8W2A/sm+pr5D+mp2Rj6V7bv2grPPaSCSgPjWxaknlqQsJHsGlRFtAXee5AgUIp6sOO/8yZZkUhPTMT3y0NSLyYn2aHwoGu0ZbPFVjc5OKKSXJs0iNUn9r1OWCTYq2+97gFt6Xgy+4sG4wlZ7bOw1Rr1e6C6UXodtTJ174wDdep2aYz6bwRQfG0zopQHHfGVFFgbBPmOFYGO2svz3szOqBJCdnF3b6K3ewD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbvfuOg/07msl8z7fzw0cfslVXJWfuNdMc2jm+qNLTU=;
 b=gV/xoaVYEDhaz9aPEzkra+CR/7kGUwZxXPpesILekUsaNml3PAH/vyZFKUTWwSDIoK+6jP2VyYsGIQXeS5RD+Fw6ughlXl/yue7Q2rvmUfGZ/qaotXOoUaOwXlrpidHi8oNg+H7o1GUVVwQipi8KB+f6qzMaLGHHhZCpCP/If6yDqipEZm1/D09p6Va4UcN/EiqmPDUrY3tcTcOc7G2V6oC0x3PGf5vxRsv6fxSWIpFSvZCdDhFSAeWdWJNykTRxCu1+PlBFt+Yh2q4y7s8NuTkPBR7f8/J3C3GPVw3VUsLAtUsfIAikmhtp1HaF4y4+jDXSxwI1ogbctb+yKEngrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbvfuOg/07msl8z7fzw0cfslVXJWfuNdMc2jm+qNLTU=;
 b=JcWvQcSqg98HRf+5e/W83tyJSWS12lUp5pdfcgJQ9eDxzxWaNhK5JSHo1YovS07Jly1kWv1lXiQOaeeZTVEAVY6BnQY8nJQyfkYqsr8Ys0zG+PQMQSXHgUw6znIYIuDz9hQAMV57o6pWHBvfoZC6YkL2idRpWphx+buN6cPdb/Y=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:43:29 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:43:29 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v9 1/2] virtio-pci: only reset pm state during
 resetting
Thread-Topic: [RFC QEMU PATCH v9 1/2] virtio-pci: only reset pm state during
 resetting
Thread-Index: AQHaj8v0Xjj81CQhgEuf0xJ+4L63FLGQwSiA
Date: Fri, 10 May 2024 07:43:29 +0000
Message-ID: <BL1PR12MB5849A6EAA55099A47AD0070BE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
 <20240416070127.116922-2-Jiqian.Chen@amd.com>
In-Reply-To: <20240416070127.116922-2-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5046.namprd12.prod.outlook.com
 (15.20.7587.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB7511:EE_
x-ms-office365-filtering-correlation-id: 3c6ed916-40b9-470b-4b26-08dc70c4e24f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RU5PWFZ5ajZ6eEh4eXV2UnRtU1Z2ZHpZaUc1aGEveFhJTjlUZGVZV0dib3ZL?=
 =?utf-8?B?UmY1QkZQem9XMHIyTmdmZUllWWlMS0tISTl2Y3UvMzVoVU9TRUhkY0R1Z2Mx?=
 =?utf-8?B?Z29BUFEvZWZrR1hWVDlleEh5MHl1YkladTN0NThCVVd0V0FnK3VpYnFsWlZ1?=
 =?utf-8?B?RjFmbURDUEdHcndsWk1XSW03YUErVTZUNklmZEZEOVRPWWQrRkJwMnJ6cEVy?=
 =?utf-8?B?a2hRd29yK3Z0cFByYUdmeEduVjJaWnhkaEl0ODdZcForbFR4b0Y5cmYwczFm?=
 =?utf-8?B?VlhtdTdHdjhrRU9FOForbGNGVnBBZ0k5YUtYSzg3RmExNUZYYlI3UFRjVlRT?=
 =?utf-8?B?WWp2Y3FTMXNrQXAxMGRJZTdmdGVpakNkVmxNemN2dklDU09oZUZFQWlNV3do?=
 =?utf-8?B?S0tCL2gxOTl3OSszbit4MXNQZVVTa21JNGxPbnZkNXB4WlNkZnJjZmtwUEY5?=
 =?utf-8?B?SDdzSVMzcm9xYVRRSkxjeWZ3SWFDYkFGRmtyMGg2dEUzT3lOY3dwQWdWSGE0?=
 =?utf-8?B?TGFFdWx3QkFIVjJDRGtJRkZPT0xUT01LaFRIQ1piK2NpQkpCeXJMQ09ZZ01U?=
 =?utf-8?B?WFBpeFRrVkU0LzdGTVZ5VmVmeHBNWC9WSlZQdGFuTmVOTjNWSlN2UUNzSzcx?=
 =?utf-8?B?YTVkazVjTmRUMDk1cHhNWlNEekhhMzE4ZFlGeEtQc0dGck5YRitWK3VLbU9H?=
 =?utf-8?B?aXY1N0s2Tlk5SUEwTVdrdGh3U1daL3pWY01zUklpQzg1TVRuZ3Z3UHphVGVR?=
 =?utf-8?B?YmlBZVMvQXA4b0lqc0dHWmRxTjVjQVhRTTV1SkdMcGdaNWh2amNlbGNLSlBz?=
 =?utf-8?B?eDY1RlY2TGQ1STkxemFMcnNRTTZGYnVFbkFielFWRnFXSzl0ZDZGMDJsUFlj?=
 =?utf-8?B?Q0M5VlhsaTl0Z01vUy9Fbk8yYkx5TjAvQVVJcklINER3L3JrYWFsbTc2cmRi?=
 =?utf-8?B?dktqVSs4blNmcklJa3NhTDFsdlpxS1FETzd1M2Q3TTkxV1BYRHRaMEIzQjEz?=
 =?utf-8?B?cXFMU1JLTkFtVmQxMjRQczMySjUyRkpSU0VGcjMzNktsNThKVE5vc0hiTlZv?=
 =?utf-8?B?a3o5NmdYeENLcmZNOXJPRm5mZWNLVHFWUFhJODVIU1Y2Szk2ZlRSOG1OOHlx?=
 =?utf-8?B?ZGc4cllRQlNYQTJMSXdLM29vU3FPWnBoYXkzekcra3BVSGdaclRPY0JMMnI0?=
 =?utf-8?B?RTdIOFdML0NkdUZLNHZKYXZGaTkxWkxNL0drMEEvZUlmbFZ6KzZ2cjNhRjJE?=
 =?utf-8?B?UzNXYUJTekV4UEhtOU9GZlZPWXdjZjdrOW5nRlkzR3VmVEhOOHFjWDJ0Vzg0?=
 =?utf-8?B?QlpvOHNDeUJjUC8wVm5Xa0tIbURKMG1hbS9FbGFnVzRobnFmWEdTU2NtR25G?=
 =?utf-8?B?N3krNitUR0FBSXFMcHV3QzZYc1VvWS94Q0R6c1hrcFhiRm5GNTYyVVZqcDJv?=
 =?utf-8?B?bXA2WW5Rb05VRXNVSjFSRkJoVkhmcnc3SkNVMTBjZEk0d0RDblFNQUFIbGN5?=
 =?utf-8?B?c2NSWFg5eUlObGdML3NmRDNXQnZWc0ZWcVJkazZVVHVCUmMzNjZBc1JpRlM3?=
 =?utf-8?B?Q3JxNDFaa0Y0c0VQUjZmL3MvTHJrMEYvdjVQd2ZERzczYmVPLzZzMHBYV2tv?=
 =?utf-8?B?SkYzQ1VYV0dmSmR0bU53QXVWUEt4dE9VYk5xS1I0M2RtRXk5am1wRUQzcU90?=
 =?utf-8?B?V21TMmh2aVl0ZXlnaWErMkcrMnBoRTIvNTU2TlQxQWFlc0czMUxJODhQelV1?=
 =?utf-8?B?Z0s4dHhsZ1pYZStzOGJqaWVLREJtbnM2NjN3VW16N1FueXFLUFBHUUlKMlE1?=
 =?utf-8?B?TklZMjU3RVZMR2tSd3ZIQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xuQzhyWUVuOS9ZdXhCYXBSZmpreFVVYmJCVVJLUlJXRVN3aVpBNGdMSERI?=
 =?utf-8?B?Q3hJYXR4OWxoMGtXZUtIOS9tdFRtK3RRUmR3eUVRL0NpRDJGYVpwRW5ld1R0?=
 =?utf-8?B?NisrOWZ6eDhjRTZGbkN5aCtYOEtkZWRMOUFmcExvWmJRQTlTTUdPL0FtZkk5?=
 =?utf-8?B?c1RTeXgvSkZ3RGpwckRVZ2gweU94VWw4RnFvK2lhVXkxZmVUN0JvNmJwaWVW?=
 =?utf-8?B?cEZtdTJTNkExb2phTWFIRUM4UWFaU2EyVnJYdXZhaTZaOFk5MkpncUlsRXpt?=
 =?utf-8?B?T2cyYmlJQjVyTHE0MnRUTGJtb2k2RTlGMktCbEpVbnQwMitLWFVsRTZ1OW5O?=
 =?utf-8?B?ME1SNU8xYTRyUkJXU1RoQWtKZVFOcWZRVkJDOGhUWUJzeHFJOUtRbnZIQytU?=
 =?utf-8?B?K0d6TDMvamNDdCsrYlh5Ym44bnBLZDZvaHVYbDdNazZDaU1OdFZQazYwTmlk?=
 =?utf-8?B?UXo5LzhwRHNhZCtRT2hieHdxL1BzYmowdDlDWTVKaWlZUkp5YWFiNGJQK2Fm?=
 =?utf-8?B?ODlqaXI4V290bk5hMVBEb0tBMXJ1eDlGVGhkdkZoSjVPVFhSRm5nd3Y2T2Ez?=
 =?utf-8?B?cjBwNkZ5VzRKZHB1UDBrWUdQU29oUzhaeXpLTWFiR0h5SEpwR2YzWjhFZlJM?=
 =?utf-8?B?eDQxT0wrT0t3Zk5waXVFV0ZuVHRJdUVROVRScWZMeGd6VDZ4VG9YMCtlZEpR?=
 =?utf-8?B?Wm85VmhNRUpnbUV5SnRHdlN5SE4wUVZnbmdTT3NtK2FKYnk2eFhMMWJIY1lS?=
 =?utf-8?B?U0JuZWt3dlhLK3hqaTdBS3h5NkNFci9HOUc0VzhoenlvaUlSbUF6aVZHdW5U?=
 =?utf-8?B?L3RNVEJma2lPUVVFMHRDV0RKSEJrWFc0UE9HdVVON291RUNocXczRm9la2lt?=
 =?utf-8?B?SDRXUTFERThFNEV1bU4zSzBSLzZWTjVpcm5GQmwrWS9Bdit2K28xMUdscGF2?=
 =?utf-8?B?NWZFODZuQmVINnUxRUlRbGF1Uk8vamNhVWVrcFZFTXZyblcydFBSNXR6T3NT?=
 =?utf-8?B?a0c1WnVGaHlDOHhZb2tJY0JSZkhGaVR6bUVQeUpYNWJKbHl6RTJzb3JVdXNt?=
 =?utf-8?B?T3JHNHFuMmJ4cWQ0dVFpaENWaFJxWldFOFVQL25wd2Rxck5hajFmRlNOQTV3?=
 =?utf-8?B?Ky81SjBhZ3dJSVpLTklwN2VtSlo0ckxmOEZVTGt1aC9iU3l1WXhZMWxpUEtw?=
 =?utf-8?B?ODlxekRLWnZrdVpnZkt3ZzFGWldsa25jc1FnRDBzZjQ3OHZORTRVU2Vyd1dy?=
 =?utf-8?B?VmtXOGEyU1pramlUWGlMSDZZejZ6a2YyTm1hdi9ERVF5dmVlSjdhaWNPQnNx?=
 =?utf-8?B?WnVYRTZ3L2xtMlplL0RveGExMHpYNWpXSG40OUsvTlJjUHFaU3pRQ0dnN2dK?=
 =?utf-8?B?TVpob3d6b0hhWnh0Z0tLUVRFNWwrUmRYVHZKZndGV2dHVm9kcUVLT3FEZUtD?=
 =?utf-8?B?YUJ5aXhJT2NrcEdCRzFxckk3cnpSUHhPYUV5M2phMXBxM2JOQy9JWHNXRmF2?=
 =?utf-8?B?bFZCV1hydThVVmlCN01OY3JNS1ZPZmY1YnBmNTJRNzcvVmFJdDNuR3k5MG5X?=
 =?utf-8?B?anFOc0ZiTW9qYTNlWTJYcytIU2xvc1dsMDJ1ZzZvaTJmaEttaDZyejhEd1VT?=
 =?utf-8?B?S1JhWDlOSXI2aGhWT3JXTHNCNVdPODJ1Rm5haTJBb0RwZWpFMkJhYzUranl1?=
 =?utf-8?B?M2pIbGora0JBWEErN2pGQkdRVzZUMkdaN0FUd3hGcTlKbCs0aFR4U3pOMjBP?=
 =?utf-8?B?S2FtNjdDeWtkcnlYOFRUaEVHN0RHQlBGR2xuTEVtYUIvUzdTcVFITWplMjNY?=
 =?utf-8?B?cElPM3o1dkxKc1dNS0RmdUE5WGhBRFg3Q2xWYXNrektwT3hpWFNpNmFpNUJF?=
 =?utf-8?B?VVQ4bEwwTkNwcW5LdmVoNkllMzhMTlh4RjlydTVvZ0JDd2g3U3NseXJvdi95?=
 =?utf-8?B?RWtEc2ZzTXYzVk1xQkd0bVVzaUJOS3ZtOTB2Mis2NXdBV1c2YnFHNEJPblVH?=
 =?utf-8?B?cnJ1bVZmMFZNQ1ZkaWdVUDk5dEpRWXllNTVNYzY3WW9CWVUwQWgveUV4Vys2?=
 =?utf-8?B?dUNOQTE1VnVVZ09FdUdidTYzT29ETWU4bjQ2NWJ3c09hbDJ5Z3dKMlJaL3Iv?=
 =?utf-8?Q?sVy0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5B12A37F869E741B1ACCD5670CF8D40@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6ed916-40b9-470b-4b26-08dc70c4e24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 07:43:29.1999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROuwM47mhZKHSWPS46D4UPhc7PZFJFU9Mc1K8Xegw9GhOG+5YIybxiT1616LpHh7OCro296vWx+ZU4Q5lyVVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
Received-SPF: permerror client-ip=40.107.93.47;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

SGksDQoNCk9uIDIwMjQvNC8xNiAxNTowMSwgSmlxaWFuIENoZW4gd3JvdGU6DQo+IEZpeCBidWcg
aW1wb3J0ZWQgYnkgMjdjZTBmM2FmYzlkZDI1ZDIxYjQzYmJjZTUwNTE1N2FmZDkzZDExMQ0KPiAo
Zml4IFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbCBSZWdpc3RlciBmb3IgUENJIEV4cHJlc3Mgdmly
dGlvIGRldmljZXMpDQo+IA0KPiBPbmx5IHN0YXRlIG9mIFBNX0NUUkwgaXMgd3JpdGFibGUuDQo+
IE9ubHkgd2hlbiBmbGFnIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNIGlzIHNldCwgbmVlZCB0byBy
ZXNldCBzdGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hl
bkBhbWQuY29tPg0KPiAtLS0NCj4gIGh3L3ZpcnRpby92aXJ0aW8tcGNpLmMgfCA4ICsrKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRpby92aXJ0aW8t
cGNpLmMNCj4gaW5kZXggY2IxNTlmZDA3ODVjLi5hMWI2MTMwOGU3YTAgMTAwNjQ0DQo+IC0tLSBh
L2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMNCj4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0K
PiBAQCAtMjMwMCwxMCArMjMwMCwxNiBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fcGNpX2J1c19yZXNl
dF9ob2xkKE9iamVjdCAqb2JqKQ0KPiAgICAgIHZpcnRpb19wY2lfcmVzZXQocWRldik7DQo+ICAN
Cj4gICAgICBpZiAocGNpX2lzX2V4cHJlc3MoZGV2KSkgew0KPiArICAgICAgICBWaXJ0SU9QQ0lQ
cm94eSAqcHJveHkgPSBWSVJUSU9fUENJKGRldik7DQo+ICsNCj4gICAgICAgICAgcGNpZV9jYXBf
ZGV2ZXJyX3Jlc2V0KGRldik7DQo+ICAgICAgICAgIHBjaWVfY2FwX2xua2N0bF9yZXNldChkZXYp
Ow0KPiAgDQo+IC0gICAgICAgIHBjaV9zZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBt
X2NhcCArIFBDSV9QTV9DVFJMLCAwKTsNCj4gKyAgICAgICAgaWYgKHByb3h5LT5mbGFncyAmIFZJ
UlRJT19QQ0lfRkxBR19JTklUX1BNKSB7DQo+ICsgICAgICAgICAgICBwY2lfd29yZF90ZXN0X2Fu
ZF9jbGVhcl9tYXNrKA0KPiArICAgICAgICAgICAgICAgIGRldi0+Y29uZmlnICsgZGV2LT5leHAu
cG1fY2FwICsgUENJX1BNX0NUUkwsDQo+ICsgICAgICAgICAgICAgICAgUENJX1BNX0NUUkxfU1RB
VEVfTUFTSyk7DQo+ICsgICAgICAgIH0NCj4gICAgICB9DQo+ICB9DQo+ICANCg0KRG8geW91IGhh
dmUgYW55IG90aGVyIGRvdWJ0cyBhYm91dCB0aGlzIHBhdGNoPw0KQW5kIGFub3RoZXIgcGF0Y2gg
b2YgdGhpcyBzZXJpZXM/DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

