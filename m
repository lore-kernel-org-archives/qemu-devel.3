Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D9CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfXk-0003Nn-TJ; Wed, 03 Jun 2026 02:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wUfXj-0003NV-8U; Wed, 03 Jun 2026 02:57:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wUfXh-0005M5-Di; Wed, 03 Jun 2026 02:57:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652NqeGS3717409; Wed, 3 Jun 2026 06:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=GJc1mhyrvjSX4Pjyw7X2uVEJodBfjE
 FeEiHnuFDRX1c=; b=F33dQrAzzPBkREEYyn0JhVWzRVFBE5X00uj+fr6gTaDAqW
 KUdHbo9JVtb/XtDUVovb6zKb/Ye4PEDH0ciup1BOBaLnb+OlkcwxjiT36c8p3fUZ
 wfFxXQaYHI15cnvdxCMS8Im7xKxREbJbwCgwcEcbClbwUSbpdQHaAAjPX32ow1m9
 TTtqZx9CwOxkXdin5R+Zqt/bgGG4z+V5ZGtOx5n8vd3BDjTHMcBK1Xvuz+KeI13F
 kUGRWfCKl/363iyywQQXeZYfm5FZtepRSY7DCmiu1FJOYXv2rGZyHzZDoDYHzBmJ
 mv54B7HlrcZJ7f2HjL9UvSH6GZFa+1zyhNG9rJvw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahs9rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 06:57:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536d5ps003040;
 Wed, 3 Jun 2026 06:57:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k70nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 06:57:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6536vSIp28312224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jun 2026 06:57:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CD6858055;
 Wed,  3 Jun 2026 06:57:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A73A5804E;
 Wed,  3 Jun 2026 06:57:25 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with SMTP;
 Wed,  3 Jun 2026 06:57:24 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation);
 Wed, 03 Jun 2026 12:27:23 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/3] hw/ppc/spapr: Do not fallback to raw mode when
 KVM rejects compat
In-Reply-To: <20260502140021.69712-2-amachhiw@linux.ibm.com>
References: <20260502140021.69712-2-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 12:27:23 +0530
Message-ID: <87h5nkyuuk.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2MSBTYWx0ZWRfX8h+QY09DUj5v
 pxBb2UOzm03jOGrdZfR6hhABAFtyRyhGjxoCba/3Nds/8hHOUZ2RwQsfHThTODWI9kFc5+DURzt
 gz5pYGX/gTZPL00wiOjTsxSNqDGMC6bSirMnImX498U9dtrKoB4ZrkuB6XFxx6YN/+bUWFLKSVv
 2TpOeQRX14d5jD7k/8xS/k4/ZfAgL+BpLm5ADKP6XE7FOC10UDcn6ENUHazVIUrJzZ7wN4tfacl
 moQv6VgzUZMb3DWYnHgH3iAgIAXDuAzxvBr+h6eEWdWTVrdanSNu/YT7zRpViLYu6x+O0gPQr6o
 L9+BhMQQuOc9/6TY2KGVKaK7aTSTwnGrmWru5CNC7jW8tebw3xpBMvmf/9Gpw4DOFhsTcGOms2G
 QIDqAXMxUeTRdDHCh6luzysUmfkiDjb2dJ6vC3X2iL9pyAaoeTOyPtGKSpfqXqoqW6wL9zX+ZIu
 HxIyFySuSApYREYhT8g==
X-Proofpoint-ORIG-GUID: gqYaQuh-rY_oDD0nqXyFlQGw2eQbRYrh
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1fd05a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=g2RU9dtdpAGrWBBcRgkA:9
X-Proofpoint-GUID: aOxK6qr9nQOE_3xUWBci4HIREgER9xE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vaibhav@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi Amit,

Thanks for the patch. My review comments inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> During H_CLIENT_ARCHITECTURE_SUPPORT, QEMU attempts to set the requested
> CPU compatibility mode via ppc_set_compat_all(). If this fails, the
> existing code may fall back to raw mode when supported by the guest.
>
> The current logic treats all failures uniformly and tried to fall back
> to raw mode whenever possible. As a result, errors from KVM (e.g.
> kvmppc_set_compat() returning -EINVAL) are silently masked, making
> debugging difficult and allowing the guest to proceed with an
> unsupported or incompatible configuration.
>
> When running with KVM, such failures indicate that the requested
> compatibility level is not supported by the host. Do not fallback in
> this case; instead, report the error and fail the CAS negotiation.
>
> This makes the failure visible to the user and ensures that invalid
> compatibility requests are rejected early rather than being hidden by
> fallback behavior. For example, the following error is now reported:
>
>   qemu-system-ppc64: Unable to set CPU compatibility mode in KVM: Invalid argument
>
> Fixes: cc7b35b169e9 ("spapr: fallback to raw mode if best compat mode cannot be set during CAS")
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> ---
>  hw/ppc/spapr_hcall.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 032805a8d0db..de2ea6f5e579 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1204,6 +1204,15 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
>          Error *local_err = NULL;
>  
>          if (ppc_set_compat_all(cas_pvr, &local_err) < 0) {
> +            /*
> +             * If KVM rejected the compat mode, do not fallback. This indicates
> +             * the host cannot support the requested level.
> +             */
> +            if (kvm_enabled()) {
> +                error_report_err(local_err);
> +                return H_HARDWARE;
> +            }
> +

NAK on this change.

As per PAPR whether the guest can run in RAW mode needs to be negotiated
between Guest and VMM. The existing code path via cas_check_pvr() and
'raw_mode_supported' already handles this case.

So I dont see a reason for this KVM specific changes needed. Can you
please elaborate a bit more on the issue that gets fixed by this change.

If this change is related to your Linux kernel patch series titled
"KVM: PPC: Handle CPU compatibility mode for nested guests" then the
ideal place to put compat check would be in ppc_check_compat() and not in
do_client_architecture_support()

>              /* We fail to set compat mode (likely because running with KVM PR),
>               * but maybe we can fallback to raw mode if the guest supports it.
>               */
> -- 
> 2.50.1 (Apple Git-155)
>

-- 
Cheers
~ Vaibhav

