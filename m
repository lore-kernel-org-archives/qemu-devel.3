Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84641C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 21:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1v1z-00061T-9q; Tue, 30 Apr 2024 17:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s1v1x-00061J-H9
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:28:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s1v1v-0008EC-1Q
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:28:53 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UKviHo010125; Tue, 30 Apr 2024 21:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WQ0fGuz1V77JvFff2Di9C9Rc/joON5eNRhThx/SAMMI=;
 b=PWDd8wfLD4POAHt/sqeocOGzpXNPfXhgZ2a6TXa8JA+QS1e7+SWIIRIhQP7G54W9O3P0
 zVW35HIv3NX6U10Zyjl4Z7XdLVlWkwijyx69EoMXJCrocGb+RboBeWxBb3Ugbr3Tbthg
 ta8FoaMyonSwJe44k5A6YSkHOaBxiMDuRKPte/yuqUV5lgrPJDKOrcHmpE2/TcTh7I0r
 xITHiTM1B1kmPjMW//Hu0g4/xNw35StEv2dnguB2z3rKE5wfxfJDyT80cKWPpgQ3A2ZO
 1MgQFzbKWcTxX9yxxgGTxZjNxo3VKW4abmSxJOcqvzm7qv1eAc1YEt8/k67UkJZlPU3m ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu84kr2fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:28:47 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43ULSla4028568;
 Tue, 30 Apr 2024 21:28:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu84kr2f9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:28:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UKfTMh022258; Tue, 30 Apr 2024 21:02:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6mq2b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:02:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43UL2DNN26346174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 21:02:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65DD58066;
 Tue, 30 Apr 2024 21:02:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C31558064;
 Tue, 30 Apr 2024 21:02:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Apr 2024 21:02:11 +0000 (GMT)
Message-ID: <72bc9ea8-5492-425e-a797-f0139f369a4a@linux.ibm.com>
Date: Tue, 30 Apr 2024 17:02:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] tpm: add mssim backend
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bhD7AVzEdOHivaVuRoHMYZqWMjJYGHKH
X-Proofpoint-GUID: u_iLqNXLNfjffm8F9D7maPSTy4kpAYQR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_13,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=816 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 4/30/24 15:08, James Bottomley wrote:
> The requested feedback was to convert the tpmdev handler to being json
> based, which requires rethreading all the backends.  The good news is
> this reduced quite a bit of code (especially as I converted it to
> error_fatal handling as well, which removes the return status
> threading).  The bad news is I can't test any of the conversions.
> swtpm still isn't building on opensuse and, apparently, passthrough

It does build and packages are available:
- 
https://app.travis-ci.com/github/stefanberger/swtpm-distro-compile/jobs/621150390
- https://software.opensuse.org/package/swtpm

> doesn't like my native TPM because it doesn't allow cancellation.
> 
> v3 pulls out more unneeded code in the visitor conversion, makes
> migration work on external state preservation of the simulator and
> adds documentation
> 
> v4 puts back the wrapper options (but doesn't add any for mssim since
> it post dates the necessity)
> 
> v5 rebases to the latest master branch and adjusts for removed use_FOO ptrs
> 
> v5 updates help to exit zero; does some checkpatch tidying
> 
> v7 merge review feedback and add acks.
> 
> v8 adds better error handling, more code tidies and adds command
>     socket disconnection/reconnection (instead of trying to keep the
>     socket open the whole time).  This adds overhead, but makes
>     debugging guest kernel TPM issues much easier.
> 
> v9 Fix merge conflict with optarg->optstr conversion
> 
> v10 Fix more merge conflicts and update API versions
> 
> James
> 
> ---
> 
> James Bottomley (2):
>    tpm: convert tpmdev options processing to new visitor format
>    tpm: add backend for mssim
> 
>   MAINTAINERS                    |   6 +
>   backends/tpm/Kconfig           |   5 +
>   backends/tpm/meson.build       |   1 +
>   backends/tpm/tpm_emulator.c    |  25 ++-
>   backends/tpm/tpm_mssim.c       | 319 +++++++++++++++++++++++++++++++++
>   backends/tpm/tpm_mssim.h       |  44 +++++
>   backends/tpm/tpm_passthrough.c |  23 +--
>   docs/specs/tpm.rst             |  39 ++++
>   include/sysemu/tpm.h           |   5 +-
>   include/sysemu/tpm_backend.h   |   2 +-
>   qapi/tpm.json                  |  50 +++++-
>   system/tpm-hmp-cmds.c          |   9 +
>   system/tpm.c                   |  91 ++++------
>   system/vl.c                    |  19 +-
>   14 files changed, 530 insertions(+), 108 deletions(-)
>   create mode 100644 backends/tpm/tpm_mssim.c
>   create mode 100644 backends/tpm/tpm_mssim.h
> 

