Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BE4CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXQ-00087X-SN; Thu, 28 Aug 2025 07:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXP-00086j-CK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXJ-00053Z-Cn
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:27 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S7oJr32962933; Thu, 28 Aug 2025 04:11:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9IUNwb32XH3GteQUpu13jX4m0ui3n4TCwBDbkEqdf
 4M=; b=mnZH6NAkU8tY9eTTiB3oApqKqZr+bav/x1Q+tjKhfvxAdsFM8Hw6sZACL
 OYOEVHlP3TT6stNyHfF8NpMbdvawH6kacJJoxIW+j8sJxkyasTvc9p9eI+6vSKeM
 2lU2e8vbYTCGe7RDuSt2UbNmyO24+lGvfWx24mKY+jMZKaZwzk0JFwao6umZ/f+C
 RtBv+qNn31o37plJUid2pNtg8/mJmcdUfX1OiqOot4NcKWEpXxpdfKAF62j2ZssM
 QeC2RKLvGljJ9JL2zBGAiX4E1jIcgUS5fpDdO3/eCg3ldSNjiq9XcOY9i//kYkNG
 ubVrPj7Eibq9JZIQI3CewpHGOnsyg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022109.outbound.protection.outlook.com [52.101.43.109])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48t7xvhnnn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNbnaTOwk0AsLXQi3nOsqIz5sFco0spOssXBZCQ5ZrHtt3ZrMA+BtkSnBZXv/mZTyH971Jv1rRzgyl9SigHGD2tIYWUJValOlu+1MarNcCOIIHEXxR0SDOS0KIYiLLV9R2OydjHSO05nSpNUGI+y1RfzKVORr9S5BxsZMBQaU2lBK5IwE1xW1KjQ2UCiP3A5wrLfLtds+jX0uJDn0mzYPtxopeC5wGI0PP1dIEMs4HeWlHMYtw3TRw0IuZRHCKgMYK9T884NLVYQ71rjUQVZJ3NnZSNY383xbsY5ctun2Sm9Y3UlnK144Gf+QmBh0EWmLdX7XSnQERonYPKG3jjbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IUNwb32XH3GteQUpu13jX4m0ui3n4TCwBDbkEqdf4M=;
 b=KfYAjDw+gPeOtI5lZMr50PI9z/htlLVYmssl1EmWOSENm+InAsPjVJFw7z7PGzBKtRB4TbG1+cPrEw3a0ofFUhiUifTUArxz+k6CqxZIiZ2T1CW/VCyWDnWFRgHpqU8yNdZaf6baw0/smXAbI3PKO2RX9Lagw6Hlk8FyJnOwi4c63cYfPhSdVIWFoxgc+aaRFjRR4H8Cu51SYa5/jMLrjA87zKUzt/sKgLeXG235xqvaoHXFe7TZd6vJOE/cUW4GXIgYtFXq57GRn//SwIYfb8oY0TuY+vY8UMlt5EuKGloECw7lRIQkDjZSs13wmecDjvYAwqiFsCBQ6ZmHufyqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IUNwb32XH3GteQUpu13jX4m0ui3n4TCwBDbkEqdf4M=;
 b=O5D1JUW4VS36p5ZIXicDvaLBLHkn7Jw4b1ojTHvBz4oe07CUI27eEnPu2AAe7j24lGUk2bPOPMHsw+p5+pncrBtWbC+IBl4qBQ5EUELAz2n09oCyYi66Nm+qmf1IfmnKE6stF6ZH3eG9+tnzQLbg1RS6DlzKuju0dZOxaWdbMnGCMAUo6hB2zcZfd9LQBgLQ6Ggt3PUl40sDR6UGcGLZQdaJcHf/m88zcVGa0l3gdxw40SXVczrfDCfmKbTghg0h2NoHb0ZPViEFy8X61ZWrAQ4cmgi7EpLa9KSBCKZOi3i5lLZf7iCyFPmNDX4OFJ76NZKkl5JYsMKjqldrv5eTLQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 04/19] hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into
 pc_xen_hvm_init()
Date: Thu, 28 Aug 2025 12:09:47 +0100
Message-ID: <20250828111057.468712-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:208:be::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: ada94e50-634b-4af0-7842-08dde6239a09
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnpiZUNsL2pnakRZNXpPRjB2MDFEQW9lUTVDSFJ6b1JidVJoSWJacXRHM0h2?=
 =?utf-8?B?WllLdy82M3c1cmh6TzdHMHRSMmRKZGN5RUEvQU9rMWRqWWVrSWpuS001U2lB?=
 =?utf-8?B?MlhmSDBJUEgyOFByUEpGcEpJVS9NemVjMUVWenUrRExUbUhlV1RJbnhNUWxQ?=
 =?utf-8?B?NTFIODRRakNWKythcmFOR1VYQThQVUdaTnYvVjdQdm9uUHJVbit2aERiZExD?=
 =?utf-8?B?a2gwVkxFME5Ld09xZHdkZ09XTDZ3Rm52Tm1wQm9WVnVnSDdLTGwvMk1JNExK?=
 =?utf-8?B?ZmRrRXFmSnRIcWdjbzBIY3JqVlZNSkRhK2JhNXlsL09mcUtPcVVURXF6UWg0?=
 =?utf-8?B?M05OcUNKUWxESE1pV29YTDg1c0taZHFxZVI2K3IzVnBxL1JaTHNGWWdRN0di?=
 =?utf-8?B?QzZXek5ZejA1QXNqM1Vsa09xOEg4NzNvcnZueUZZb2lXeVFOZy9WYTlzZVV1?=
 =?utf-8?B?YlRLTytzVmV6Snd1MDBpbWZsNWFuZGV5bTFzOXZnWlkzS0hGTzJNc05CVTNz?=
 =?utf-8?B?V041N051VGtOa2hORzlqMG5aL2dVR2RmZ1FpNWFVRFJqb1p5aEVvNksvTERI?=
 =?utf-8?B?clJuR04wdW5iT1VQK3FXYUNXOUg3TkhwL3ExYzR0YkRIYzZOaVE2eTNlYW15?=
 =?utf-8?B?UzVEMVh0OW42UDF1U1pISU16SjRZVHVUejdnV2lGd1dxZkQrRVhqSnNQTitE?=
 =?utf-8?B?MTVzdThpZjNFMmIwdmlrSG9UTE8rRm5abG9jVFJQdGlRYUNtM2tCRFJ5VThR?=
 =?utf-8?B?TEdwakJ4UUNqamJXYTgxM2pjbVlqUDZQaDRNS3RvL3QzRG1HSjJ3ZFM0c3p0?=
 =?utf-8?B?K1pBNmNjYWsrR1ZIZE54U2duTEhvZmNrcHc0OUhBVlFVRVVFc3R0ZEtQQnY3?=
 =?utf-8?B?OTAwSDBaUUZxUGxNbEY0TG0yaGlmTGVFdjdtWk1hanhtSnYxcWdpN2l2QzJW?=
 =?utf-8?B?WGFNdUxqa3VuZXRhZGh2aDVhcFdrL0lJVXRvVGppbUo5UXMrSTBWUjJHNys2?=
 =?utf-8?B?NTZkcXoyVWpidUVwWktBSWIyZEw4TWdOdlhvS1pBL3NLUmxWVElOZjhDV3Rt?=
 =?utf-8?B?ZjE4WnFRbkFCejZOa2FwTDIxTjVEOVpnM3B3Qzh4VWNVdUpORkM3M0JnTFow?=
 =?utf-8?B?dXFwejF2cnBZN2FmS0c4Myt2eVc3T0lhc00rZnY2eFo2SUx5Vm1DTDErUjhy?=
 =?utf-8?B?NmVRNjZMSm5yeUZLNHR3RXdWMmpHUmdYRzhZdi9HSDZlc0lFQVNvVTNQY1Y2?=
 =?utf-8?B?am93UWZrd0J0UWZacVErdXdrT2dKVVlDdXlPRlp3ckFTUWlCQlBSNytaMUk2?=
 =?utf-8?B?MlZVdU5saXp1ZDhRRFlBb0M2bnhHMjRnclhFSjNqNVBmaEtIMTVUSjM3RDN1?=
 =?utf-8?B?aW5aMmdmMnJBSjNlR1FvNFVocUpuQmRQR0h1aWsyOXlHczZJcUd4QmgxUUtG?=
 =?utf-8?B?R3A0VEJKSFAxQjBrck1ac1lmZ1FoVGFmK1pMRm14SlEzbGxzNVM0NGpWVkZD?=
 =?utf-8?B?WkROT2lnTTBTUzAzaTA2MVRsTTNNRU44SUNPbGNBaTdKem8zK2R1N2JZdUdX?=
 =?utf-8?B?aFRXV3RhZ0VRUlk5RVVjWDREWjVxYXlnVW9xcUNWallVaW1iOTVOQnIya1ll?=
 =?utf-8?B?UnBpSFdjczNKQURrWmU5cHlCbXFDVHMyRFFybjRaSzFiNkZ2S3dqa2daTlFM?=
 =?utf-8?B?OGhPdC84S3dNYjVlYUVib3B0SDZyQzluQUQ0ZW5VbGlDVHpDcFgwSWFwZzRq?=
 =?utf-8?B?VFE4bVZNcE5Eay9EajRWZjE3T09XaXphNGV3dWZ0L0pSMmVkMzJ0cVEvT3JS?=
 =?utf-8?B?UEhaOVF2c1h1ZVp1T04xMHBZSnhxdFh3UW4zOWcvL2M1eVZXUWxYR0hDTFVP?=
 =?utf-8?B?QW1YWmRuNTZjKyswb3ExMzI4cG5JbzA1VzZaQ1JIVU9SbnpjMEI0dUtrb1Zq?=
 =?utf-8?Q?UVUPLx0dG2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODBjUS9FSDAySk5CcWYxTFcxVUgzSlo3Y2QxdU8xZ3h2UCtxdnVheDYzM29X?=
 =?utf-8?B?Ujgyck9IMFlkZDNJbjJtUmFqemFzZy9qdVBXT0M3bEF5YTJwU2NnelpEMXA4?=
 =?utf-8?B?OW5pTGhjaitvUE8wWU93YTk5UlB4UXF6a1dFMnRFTU1xNmptYXprZkNnWVpz?=
 =?utf-8?B?WDVKK1NoNEIvU0ZXOTVQSTFyZ091L0sxZ1c5enZBUXhGdjhSeUlaQmRjYzNo?=
 =?utf-8?B?VGVoVkNxcU5rTDArR3pLU0Y1VlIwelZDZWNsSU9kMEpSVjFWV3BkZFNoOXNO?=
 =?utf-8?B?YU5TNmtFelhOdUVGanh3VDFuT0x6RG9ucVBJZUE4NlRGQzc3N1Nodys2NXNm?=
 =?utf-8?B?cStCL3MyTCtzUkt1OWgvelNtelpMWkRoNFI0WXk2WHA5Ym5xVnVkYjF3eFBr?=
 =?utf-8?B?YWlXNWo0bTUwQWMvVDVkN2VIcnJZVnk0aGY0VXdQdzBkbTd5NkExWUxaeE81?=
 =?utf-8?B?R2hHTVlvT2FJQWlBcVBoKzBoNG5iYVdyQUk5UDA2RXp2Q1cycHpEb0ErSHRi?=
 =?utf-8?B?cmVsUkM2bW51d3c3K2xJV1kzS08xRnAzb0YvTC9Td2g3Q3I5eXFsQU9xM3FI?=
 =?utf-8?B?VDlIQndHc2VJOFVTdWYvekQzUFp4TFBTdE04YUEyaGFKVXNvQjFrYmtJSldt?=
 =?utf-8?B?K2cwZlF5WndPOS8vVkt4aFFUWW9FUHZXdExKNHNid1VMbnVEYmxvV1NxbDVu?=
 =?utf-8?B?dVJCNS9jOWtYazNjZTVRY3llZlltcDFqYWJwUW9kbENOeDd4UVNCc29NNFZj?=
 =?utf-8?B?WDlaOWJDRThRS0hObEtERG1tcFcwOXM3ZXFOMWRSRGxRMW5vZ055Z2UrbWlJ?=
 =?utf-8?B?MXRHWWFhTldXVzE0VVlReUI4MHZFV0xxNjludmJSTldEaDZ6dXU4NU00cUF6?=
 =?utf-8?B?R3VqMnhmMlJWT1JQcEk5cmI2OGF6QXV6UkRTRWdtdGhVMVVHUVp4MnBiRC81?=
 =?utf-8?B?bzB2STZDUEhKYlJUbHY4YXExWlF1eXNXYjBYK2pJeEtDUlI1U1lXL2hpRmto?=
 =?utf-8?B?bmZFRFZNUnptRmpKMHRIMTNwL1Jod0p6bll0VGJmRzNZdWFSOUYyc0lVZ0pB?=
 =?utf-8?B?YzBSSHlkRGc0Tm9BbG9OZmhSejN3SnJXU1EweTgvSExUL0VwZy95R201UXY3?=
 =?utf-8?B?MkpEL1NGR2NrRHQrSWdvRWRPTjJFRXpUcldvVldNZWxTNk9FUHBEdnlieTVX?=
 =?utf-8?B?TmVPZGlGcGREZG13M0JJUG5XeDFrRXBnVC9qMFp0Yk1rSDM0RG53OEZ0UGxV?=
 =?utf-8?B?U3Q2ZFljQ2xrWENmSDMyV21uVGF3bGdIeU96UVhXdzdjWlNmVHh5Zloycjg1?=
 =?utf-8?B?YmozZGNYY0dKNWd4ZHdwRXBwY2l5QVhEaHByZy8wOUh0bzhoZkNvNnZLZkJM?=
 =?utf-8?B?UUlVQ2UzYzdOc3FqN3p5SkQ4ZzdQajdkc1JwbUdUTWh1V1Nicmw0Y1VTTFhi?=
 =?utf-8?B?bktXcG9OYllJakZwWEhTcG5oU1hmV0lBNEo0N21XTFI3L0srZmpxZ3FWbFVu?=
 =?utf-8?B?R3gyekRCWFNWbUdxMnNmeGNFVStBM2ZSSWxLYUpFR2p5dnRBRzBzeitqOHgv?=
 =?utf-8?B?eHJjcTRrdkRXV3M3dzA4ZHd1eTIwbThyb0VvY3JLa09WVVhkYzI1MlVMZFZN?=
 =?utf-8?B?R2Z3RUk3NUUrYzN5RW85VUFwYmhDMk5lUno1aGpXT1JudTEwQy9DUldQS3FJ?=
 =?utf-8?B?R1I1M1ZaRWUwOVVYZkpUL01Ub1ZUZFJzbUVCTUhTclJLV0lHWjVlaE52OG01?=
 =?utf-8?B?U0NaRFh4eDhHY3Z5VnA1NFhOOVVoclpjV2k3K20wTGYwMHp3Y1FGRHNDV1d5?=
 =?utf-8?B?a21SMnlON0NjWU9qRmNkQ1Zka0ltTXczREUyTjYzSkhQU0xnOTRLTmpIR3Jp?=
 =?utf-8?B?YTZzbW56cERoblNyOUoxR09lYUFsWVcyamZmOTdVZ29GczRKUkRSS2ltcHFF?=
 =?utf-8?B?c2xyQzdzbzFWb1huYzdKRUZrT3ZZRWVpL085Mk9UeU8wcHlqU01Fc0picFRC?=
 =?utf-8?B?ZERTWFJaQ2VwaGRMQkZFZzdFSzNKRk45RjBjSENwcEVKZE5LSWtZdmFXZFNV?=
 =?utf-8?B?QVVpYnlTMVFXOEdsbDBZRTFRQmdLZHpER2U3UEVKdCtUY0ZzeWE4cXBIRWMy?=
 =?utf-8?B?bC9sZExQOGN0ODhkZ0I3dDZiOWlBQzNoQ1BKbzg2dys0a2Y5alJzZ052R0JI?=
 =?utf-8?B?SWNweTNDMVlsb094SVZxaVh0YThGbWlqTzRyakJmbFFjZWtFbmpNNjZlblhn?=
 =?utf-8?B?MEN1RGFWZi9mbDBJalIvaUpjZ0xBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada94e50-634b-4af0-7842-08dde6239a09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:13.9739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06B70qFmgpLDRsmcjZGLl7zs11wnm14TcPPaak2ZF2g8ue4K1vN4bDnRJAfzQZky0ovnOe3oLFg5VsP+dEEX0u+jNmg9aj+tInRo332Rq00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX5kPpk3MNAzHZ
 KvOM+nAMWx0ass1pz1fd+rmRyEU5yeBc4cjG/jkTT2ztR/QgU17HbRPsHznFwO0FBbceevXOq6C
 /1CXq8cIpW/OkehfJZqH25r/QJ3f+vQRlvpsHEbm92Y9R2/ivUMQ1lMXZZ08nTev3i1OSpynrcP
 jiGAMgyAQX+W8ikTCFHWwt9dnDd7qKqA/dq/dPkCsfV0DllKNocPRGax2scs9szir5Qo1X6f83u
 ijyOWVCbtoC+YNKJ7pQSpk8OiQYfY5TaIDzxAWz9PkRVRV/uG28+NUWdqTpCgl5VnGY3K3Vgf75
 c/MlMoIQVU0uQtbMRs6VVSlide1r8NSVQir3d/8ZUAw0sS3C0aZTNY/h+infgA=
X-Proofpoint-GUID: EgTCdF0JkpErkjMU5hgQbsBnKd-9rUK_
X-Authority-Analysis: v=2.4 cv=Coq/cm4D c=1 sm=1 tr=0 ts=68b03956 cx=c_pps
 a=lEAIQdlJR7AYAfTETB4wFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=QyXUC8HyAAAA:8 a=Nl9WzMjVwZFxynAfEmwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EgTCdF0JkpErkjMU5hgQbsBnKd-9rUK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
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

This helps to simplify the initialisation of the Xen hvm machine.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 351986232d..8e302dc013 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -471,14 +471,6 @@ static void pc_init_isa(MachineState *machine)
 #endif
 
 #ifdef CONFIG_XEN
-static void pc_xen_hvm_init_pci(MachineState *machine)
-{
-    const char *pci_type = xen_igd_gfx_pt_enabled() ?
-                TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
-
-    pc_init1(machine, pci_type);
-}
-
 static void pc_xen_hvm_init(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
@@ -488,7 +480,10 @@ static void pc_xen_hvm_init(MachineState *machine)
         exit(1);
     }
 
-    pc_xen_hvm_init_pci(machine);
+    pc_init1(machine, xen_igd_gfx_pt_enabled()
+                      ? TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
+                      : TYPE_I440FX_PCI_DEVICE);
+
     xen_igd_reserve_slot(pcms->pcibus);
     pci_create_simple(pcms->pcibus, -1, "xen-platform");
 }
-- 
2.43.0


