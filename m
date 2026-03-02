Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEA8EB362B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx8BD-0002yb-He; Mon, 02 Mar 2026 13:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx7mi-0005Ss-Op; Mon, 02 Mar 2026 13:14:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@qti.qualcomm.com>)
 id 1vx7mh-0007gp-3W; Mon, 02 Mar 2026 13:14:24 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622DoDBW2612430; Mon, 2 Mar 2026 18:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=Y+OboHBJRNAM5mHwPepOXMbYof2smkPnSzLQYVbkdGk=; b=VB
 imYO1kWKNQQYZ+n2c0NIDSSI2gp5k/+EHxc11HVedMbWcPHnWNdkBFLvcNjaWp67
 pfUAStD67NMqdeCqXreMJPh3sheSx9DdvCDE3J08UXPvFS7wcOshjnagJFyHWQBW
 MKJZRB5z5YjW8vxNob/tByDNDvqqJyWdXhjDjQbRrjhBmgYLvDHvLdyicQVFI0Nx
 djUOQehgNWLsYU/CDhqWgGQw1g60hWl7WpSVwKr57Gq4tLAgnsElueifMb0f/Ge4
 3c094FXdLdJr974WJuzmNEPq46v2GKmZyzN2S7NV+TTf0Ry7crcLF+/tcXSejfQp
 /vUgryg104CrpuBtdHUw==
Received: from bl0pr07cu001.outbound.protection.outlook.com
 (mail-bl0pr07cu00100.outbound.protection.outlook.com [40.93.4.0])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmgbavh3c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 18:14:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMBtPBH97f/8OPdg0fN2UFwyREFLYPXtpq6hQHFVtyI407y6pL6xILe1hkdV6uiMTCJ/S8yPVwExySmCdPmDPCWXhdVUwn/u0qrU+aGofGcehR3Uba/kpEhfAhpGROlr0enxq+JpC4v5WPk6ygO0L6K8swqmKxFH0LJzHuPNGeA8C2LAgPPDINsoRha4+lZk4TSYDq2sbIN9n8WmdzL9SOwJlUBqYn9ioKB34WLntOS7WQ/O6AaKo7dtobWT2zllsjaZz3Oq5K9oL6Ar24NAeQ2sycOxesMecsVD4Fxgv+PDCGB9CgqC3J6tptT14wIpubTJDssumOLQBVbdJucWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+OboHBJRNAM5mHwPepOXMbYof2smkPnSzLQYVbkdGk=;
 b=JmqymMiUJgfkPsZxeW8qQ3q7cokqYrA0kjBiyzPT8lW+DpYCd0DeOWFXBGARNwxraXkuJZic8G02sBH1mfFCYCrWphOyyLk9L/vQlFocmMcCjX7DQ6zwG8FPERwAmLkB4euY+Fb6bKmgB0KtAHM/UdbDMKqwxjfb/UfvURx4SgnL9ECxr/3jJ/9CiZppqo2o24SfBFEj9J4AQcPE7HzpaVcTYY+CQb5fgCFjfY3Eaj9ZQs7TXwlUr3q5PliVtTMM65/+BA90Qq7KxSpl5iWrQjOjEiz/kM+eXcZJErb9lErZjxIzvNMRwFoGPgxJ7xE0uwQpVjM2BUpQs3AQbUOgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL0PR02MB4435.namprd02.prod.outlook.com (2603:10b6:208:4a::23)
 by DS0PR02MB9299.namprd02.prod.outlook.com (2603:10b6:8:14d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Mon, 2 Mar
 2026 18:14:01 +0000
Received: from BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0]) by BL0PR02MB4435.namprd02.prod.outlook.com
 ([fe80::5818:27e:c1c8:7aa0%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 18:14:01 +0000
From: Radim Krcmar <rkrcmar@qti.qualcomm.com>
To: Drew Fustini <fustini@kernel.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?utf-8?B?S29ybmVsIER1bMSZYmE=?= <mindal@semihalf.com>, Atish Kumar Patra
 <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Vasudevan
 Srinivasan <vasu@rivosinc.com>, "rkrcmar@ventanamicro.com"
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>, Chen Pei
 <cp0613@linux.alibaba.com>, "guo.wenjia23@zte.com.cn"
 <guo.wenjia23@zte.com.cn>, "liu.qingtao2@zte.com.cn"
 <liu.qingtao2@zte.com.cn>,
 "qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH v5 1/6] riscv: implement Ssqosid extension and srmcfg CSR
Thread-Topic: [PATCH v5 1/6] riscv: implement Ssqosid extension and srmcfg CSR
Thread-Index: AQHcqnBYsvWY5we1kUOuH9QU5X8dAw==
Date: Mon, 2 Mar 2026 18:14:01 +0000
Message-ID: <DGSI18AIUOMN.1KLE2KDS6KG4D@qti.qualcomm.com>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
 <20260201-riscv-ssqosid-cbqri-v5-1-273ea4a21703@kernel.org>
In-Reply-To: <20260201-riscv-ssqosid-cbqri-v5-1-273ea4a21703@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4435:EE_|DS0PR02MB9299:EE_
x-ms-office365-filtering-correlation-id: 61fabb0e-4bd8-4446-719d-08de78877b48
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: +PF3XoONBRzwJxU+dfKxoPH6pYP7NZHA8Xs47RymxHkQZfn++I1b68+QEspj2LYOkCn6hQCYIv8adMuWZWf/LyAX0tE+sUZOtWoh7x/RrZT0kn+h58wLfxqLsE55gMF/dvqewQ46LoJlSPgDqyIhwUV0r7EX0EfojMP5pxSpkKPFCUzXmssyEJTlq8041megNdioFm8zY2NaWeeDawj0CZy1D1ovtE0k053KBB3DSbUUayfIW+xYdIm60QRAVyVX9LPkDB3Hjr2ByFCepH4x8R3J6r8pf6BxCwUuUlZCBmcmnRcIwZpS1g066tP9mXCoEevUlLl3qNWhD7LcJs94rcINVoAFfXgHN+2pOBvW/KYJxdbFnAa+rPbCWdP6mnApgWvsu85tU63RjwLzuVz06oGSgl1VWNqnxOsHO2xXjPWb1okuPzp6lp8S/WwKnn4dU3ol8FzCpdLr28P9VWAeiA60+wvuHV2jrV0FPQdSTJawrWekwCzJvcTyhXhhkHoQhq46PeBJgG4IYBXgeh3JGJ38hkjdtLHbHJV9ekuzqdO00aF8jgACnMF8az46tPV10sMLYi7+Vnq/nL8RMCqUtMzJousRQMM/2+LZTMz4Pghjg9JlC9jEve0i6uTj+6YMZSFA+Dz5ZBwxyVivZ3T75ZaqkgYxxRJUxV5MMb6LffHnz7KFsek2yYzAjS5/93jUQjuj/wz8H0YzDiO2WWL0867xPG/redFfvUZQOCWJ2Kw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB4435.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXByOFZPNXU0NmQyRzFmUG02OHRnbHpXTmlzQnpZbXk4d3pyYmhaUm0zZFJY?=
 =?utf-8?B?YjY3bVAvOS9lQlRMVGhvdjRJS01DdExwak8vMkloOXJFUmlVeEs0UldWU0JU?=
 =?utf-8?B?TFFlYWNHQSt6c0FPM1ZRVEl1TGNMazVwQVhYN0tsNGNMM3ZzbHZGV1RVRVRQ?=
 =?utf-8?B?TGtZZDNvZEFmeTl6ZWQwN1N5UjFHLzZzbmpUcHI4Ky8xYUI0MytUSlZTWGgv?=
 =?utf-8?B?SVZZRmFORnZ5TldML1gzTitQVUExZmEvWDNUM0Zjc1RwVDJ0TE5Uc3U1L2dn?=
 =?utf-8?B?c2xtQlc3SjhoZjQzVFpuTmgxN2dCbDFkcE9zL1BhQlVZQ0k5Q1BPMk1sb2pw?=
 =?utf-8?B?eWNPZVRubGpkNzFWdUxLT2xGZGhIbkNMQkgrYWkvOFV6ZENXb3VXMFVGWHFw?=
 =?utf-8?B?amNrRWMwcVU0UUVNMVU2a3dwRGZiblZwRWx1ckEwMHJRZm9raWpDUXFYbzE3?=
 =?utf-8?B?cmlTY3BOQVNXc2ZYeHdvNkxBRWdTUlhpSXA5R0RnaUg3RkI5OGF1UTBNL091?=
 =?utf-8?B?SWlaMElYNkk5OGhobHdoTmRqRFJuRzBuMlh5VlUxVExaS3I5OTc4SE5lMlIr?=
 =?utf-8?B?RHJpYmtuSTliSTZ5a20xcHdId1ZJamNlZzZ3MkhXR0Z5b3hFSVlqNk1GY0pr?=
 =?utf-8?B?d1VKV252RmxsVk1NZnFKc210cnh5aGw1OFVzR1NYWVNsSXlxS2xQTUk5RlR1?=
 =?utf-8?B?SHpWSnJZdjllWERqUElqNHZldStHRjVxTFg2emRvSVZkWS9pVHkvc0N5d3Zy?=
 =?utf-8?B?VWkrWHNLQ1BXVU95TG93Zk56MGhwMlNxWTdjeVRJSjVsTzBzcENrTDBvVGVJ?=
 =?utf-8?B?bWNRWis3b1Y0NDZGdEtrU1YyMWQ0ZzZ5bk01eFFvMGVrR0w1VHZNbWduT0RH?=
 =?utf-8?B?N2VzbWE0eStEUFppaDErcGlHdCtqbyt3dTZyQnlSTDVsNzkrZkt4Um9rcXpN?=
 =?utf-8?B?TERyVkNSTDdMZGNnenBTZC9jR2llSGZPY3VDY05oRDQydHlRL3ZtdW9KeEdH?=
 =?utf-8?B?MjVjUzJFUmdub2V6dFhiU1c5Nm00NjJHNTlhMmR1Y1Z5WFN1VnZRUHF4T2x5?=
 =?utf-8?B?eVU5ZXVMeE5pRE5FSHV4WEQyTGJQb0tqNTdxUi91MUlVQmxyVkxUeWNMblI5?=
 =?utf-8?B?UmNrS3FqMDVwSHEvdnhOMkhjM3BaeG4xd2YxSVpSWmZvY3JLUUpyalRrSk8v?=
 =?utf-8?B?NEl2UFdtemJ4dHkvNVd2QkpQTjlvVXRLejJ6S2ZDZVhaaGZIV1EvMm5kOCtF?=
 =?utf-8?B?OVBGK1VYMXYyN2ZBSVJuRzhIckNjd1BOcCtQdHl3d0wxT0x0VXhpTnBOZkVH?=
 =?utf-8?B?Z3BoRzAxT2VSZFI3cjlYcEhGNjNzeVFWSmdlblptQkFIZDNFODBNNFp3NDRW?=
 =?utf-8?B?K05QcExYWWQ5SDYyaEpUbjBObU1lVjR0WXZadlYxSkxPUWJ6aUVRQXlQd1hY?=
 =?utf-8?B?dG41RWUvbXAzMTNQZTFvMlo1cG85OEhTa1MrZXVGa25wOWNvSDBCVWVNcXlS?=
 =?utf-8?B?VlZ5Ymg1TnhPenN3QVpaNXZQbExDbk9YWkdwZG9DRVhvRm9xcnBYWElTcGlF?=
 =?utf-8?B?eFptZUw4eTc0SFhoaWNQcDlsOXU4UCtkOHl5Q3JSUENsRk5vUzhOc1NRa0l1?=
 =?utf-8?B?bmc0UDhsVSt1dVlmRDYyRk5aQjloa2tvdUN0cEhTaXA0c20veFYwRzJtcStx?=
 =?utf-8?B?KytTN1pJMERVa2dWWjg4azVZcS9lTlhKeG5Ub2dmeGNsL2laQlQ2VWRqZmlC?=
 =?utf-8?B?RlYvaEs5UjhtSk4yME1JZTgxYXhCdERRY0pYMCt2czUyTjNObDZERTNwdmZa?=
 =?utf-8?B?VXBzYmlSblNCaXNwMG1yb1Z5NmF0di8rc3g2V1BaSWI3UVlPeVUxblVwaHgz?=
 =?utf-8?B?QjV1ZjYrVkMyUEptYjY2c2NWY0Y0YW1VamVKbnBHKzZhclR0U3NLUnJENFlw?=
 =?utf-8?B?c3FjZUVhQmlBSkdNMGZwMTlxTm1NcWJHYTVVY0RocXFwejNibGdBL1dkYXBq?=
 =?utf-8?B?V2EyVmtQbER2YlUraWFTWmJxTDFhbmd2SGorS1dFdG5Bd05VcHYyS3liS2lH?=
 =?utf-8?B?eUZmQ3RmMys4S0Z6QitsUUVuMXFKbWtmeGptcW05RDlBT3o3OFdTSTlwU1ZL?=
 =?utf-8?B?RHhYaFpocGNyWDMvdS9ISURyb0FtdisveXdQeVphUXVmbEpHK3lGRHJ5TkJ1?=
 =?utf-8?B?UkZ0V0lzeUpjWVMzSEtRaVZDbHJ4RnF5WWFqcnoxQjVNUEhSRENHOEovV1cr?=
 =?utf-8?B?VkZHYXRDRnI1QWduUThUQTRGU25Dd21IRERaaTFGSDlXZm12UzM3TmtlTitQ?=
 =?utf-8?B?ZG9nOVYzREVNSkZtUUNvbzhWa0FPbTR0WklqVEN2cHdzYk55RktlQ0dQK3F5?=
 =?utf-8?Q?l8ImNkeHZDRwHsck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7ECAC8B27961D42AFA9CD3E5BA95883@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o0y9Se11ok8Q9VGPS8mEgcdDoW5TA0WMI7M2amizqSTauRPN2hKWLrtrlUKDJrzolEQPV9SNubcQTJuoJTxR70GV8uGAzPlXcolAX/apVJoyHjr6AKVUh2Q1fmcAd7qAzP/NkXqRB7YlfFmJM0q0qv6wVWckmfZd45f2kkTuzENIRaPKfEjarXg/jaR3UJ9L3HQcJe4E2ibdq6m/gUunxLYNUwvjxT78STf/MjOj+mryZGmUtqQszJe3R2Ro44Z6F2gpMhdbrOA1ZCgqpOZsYQbjID28yNKUKaeYeVrWumCgGRxE2FErWXqJ0RXmnFtTM39btVl6FH76XWfQKx+df5U5vUzeAlPgrH51xXRKcoGcnJ4iAZpfqRmI6HSG6fxwcdq8YMzHdKyPzcbwLjR2LgaAGw/R0SrcaQdxFJ88GmCS51qeBr1iDjMrhDBT5o9blSjGFoqLcXuCra0Imoqd78JKLpTHgKIv6j8PGRGleJis/T62vsO+SBbOA/yDGtzmlZGNeSPV1X0ZUH9XxkQgrnLoP5eVAwd8ZWhp24qNE/vK5YjzFsobaz5j0K/74+q7ssKYAZ0r1FD7iwvuB8aGXkIjZ39sybOv/X4HMthVvWU6XNAHi//ZJL8fEbMy0lP0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4435.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fabb0e-4bd8-4446-719d-08de78877b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 18:14:01.7437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agmEIL+YsmEhzTWkQXGW8dElTbf4x/79hjwki0l7QKQzjSDprUqRhd7j0xh8ruxzSOQjO4d+KNwqjuoXYtk4XKzSTCWDwiJNovmzDzAesLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9299
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0NSBTYWx0ZWRfX1FyJUujP6mw0
 HW1qB9J67jGbfHizEUJl6my5sfiPg9wu4LUnRur3FBth1kFZH36CJt6VU6D2xYej7H9NzHbPMb4
 ak9C8ftgT4H9TlJnLMS5ffcgzYbWPZ3e6/JCPMukxD9clN55o8s+OuhlHIJh1YRMINs4DwlpJE1
 AZePEcJ17CIgEsCQ7VsHL07nOCcKr+7pCv26hLlCS+CAh8YX5YDMpmwSbNkK3pzQg9F/ZnprJ1K
 GnjPqr1eBtkkOPEasnyejZTdOQvMC5x5PJAWGLCbEgJTZLFdvDYv8O6kIgqOR+utRMVSkyNMR1F
 IxMCx/h0UPPsm9LUaSxqax8menySULKoybzkY+WrWbJDxj65h5LF5PiChiwHxCt3hd5I+Karu2w
 op7j4KgE/TUfpwouN7Mw5E569vFCW8G3ek7JVnL5CoVkqkoxpktGJ7CxBJXEpqweD4qTPYWTzxA
 lgxjwSjPsKrRrdvnVEQ==
X-Authority-Analysis: v=2.4 cv=QfVrf8bv c=1 sm=1 tr=0 ts=69a5d36f cx=c_pps
 a=R7I9PRAlQjBSNlIBhwzs+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=V1jnuoLLAAAA:20
 a=HwFc7jivAAAA:8 a=VwQbUJbxAAAA:8 a=oCJs8q-oAAAA:8 a=EUspDBNiAAAA:8
 a=sIBLlZgNAvny2aHwhmQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kr7TZk85JJIQSqC0cl8G:22 a=qUF70SbvcHBaGhGVny9j:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: jJK84QbB0ZcBDWo21A-WbWjc3nBsqKmK
X-Proofpoint-GUID: jJK84QbB0ZcBDWo21A-WbWjc3nBsqKmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=rkrcmar@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Mar 2026 13:39:39 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

MjAyNi0wMi0wMVQxNTo1ODowNy0wODowMCwgRHJldyBGdXN0aW5pIDxmdXN0aW5pQGtlcm5lbC5v
cmc+Og0KPiBGcm9tOiBLb3JuZWwgRHVsxJliYSA8bWluZGFsQHNlbWloYWxmLmNvbT4NCj4NCj4g
SW1wbGVtZW50IHRoZSBzcm1jZmcgQ1NSIGRlZmluZWQgYnkgdGhlIFNzcW9zaWQgSVNBIGV4dGVu
c2lvbg0KPiAoU3VwZXJ2aXNvci1tb2RlIFF1YWxpdHkgb2YgU2VydmljZSBJRCkuIFRoZSBDU1Ig
Y29udGFpbnMgdHdvIGZpZWxkczoNCj4NCj4gICAtIFJlc291cmNlIENvbnRyb2wgSUQgKFJDSUQp
IHVzZWQgZGV0ZXJtaW5lIHJlc291cmNlIGFsbG9jYXRpb24NCj4gICAtIE1vbml0b3JpbmcgQ291
bnRlciBJRCAoTUNJRCkgdXNlZCB0byB0cmFjayByZXNvdXJjZSB1c2FnZQ0KPg0KPiBUaGUgQ1NS
IGlzIGRlZmluZWQgZm9yIFMtbW9kZSwgc28gY2hlY2sgbXN0YXRlZW4wLnNybWNmZyB0byBkZXRl
cm1pbmUNCj4gaWYgcy1tb2RlIGlzIGFsbG93ZWQgdG8gYWNjZXNzIGl0LiBJbiBhZGRpdGlvbiwg
YWNjZXNzaW5nIGl0IHdoZW4gVj0xDQo+IHNoYWxsIGNhdXNlIGEgdmlydHVhbCBpbnN0cnVjdGlv
biBleGNlcHRpb24uDQo+DQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi1ub24taXNh
L3Jpc2N2LWNicXJpL3JlbGVhc2VzL2Rvd25sb2FkL3YxLjAvcmlzY3YtY2JxcmkucGRmDQo+IExp
bms6IGh0dHBzOi8vZG9jcy5yaXNjdi5vcmcvcmVmZXJlbmNlL2lzYS9wcml2L3Ntc3RhdGVlbi5o
dG1sDQo+IFNpZ25lZC1vZmYtYnk6IEtvcm5lbCBEdWzEmWJhIDxtaW5kYWxAc2VtaWhhbGYuY29t
Pg0KPiBbZnVzdGluaTogcmViYXNlIG9uIHYxMC4xLjUwLCBmaXggY2hlY2tfc3JtY2ZnXQ0KPiBT
aWduZWQtb2ZmLWJ5OiBEcmV3IEZ1c3RpbmkgPGZ1c3RpbmlAa2VybmVsLm9yZz4NCj4gLS0tDQoN
ClJldmlld2VkLWJ5OiBSYWRpbSBLcsSNbcOhxZkgPHJhZGltLmtyY21hckBvc3MucXVhbGNvbW0u
Y29tPg==

