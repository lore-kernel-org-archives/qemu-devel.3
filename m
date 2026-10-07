Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892F7CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWQD-0006Mq-O3; Wed, 07 Oct 2026 14:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEWQ3-0006Kv-IE; Wed, 07 Oct 2026 14:31:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEWQ1-0000v8-LM; Wed, 07 Oct 2026 14:31:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B6820583224;
 Wed, 07 Oct 2026 20:31:05 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id XZOXHZFS_Jya; Wed,  7 Oct 2026 20:31:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9BC545831F1; Wed, 07 Oct 2026 20:31:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 99CE25831F0;
 Wed, 07 Oct 2026 20:31:03 +0200 (CEST)
Date: Wed, 7 Oct 2026 20:31:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Utkarsh Verma <uverma@linux.ibm.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com, 
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com, pbonzini@redhat.com, 
 th.huth@posteo.eu, sbhat@linux.ibm.com, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, rathc@linux.ibm.com, philmd@linaro.org, 
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net, 
 alex.bennee@linaro.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH v2 8/8] ppc/spapr: implement vscsi-report-luns
 call-method for PAPR vSCSI
In-Reply-To: <20261002052605.605858-9-uverma@linux.ibm.com>
Message-ID: <242e1462-9256-b115-e68c-f20aeb25dda4@eik.bme.hu>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
 <20261002052605.605858-9-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Fri, 2 Oct 2026, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
>
> GRUB (grub-core/disk/ieee1275/ofdisk.c) calls "vscsi-report-luns" on
> any PAPR virtual SCSI controller ihandle to enumerate attached LUNs
> before attempting to boot from disk. Without this method VOF returns
> PROM_ERROR and GRUB cannot find vSCSI disks.
>
> Add vof_vscsi_report_luns() to build the LUN response table in guest
> memory and wire it into vof_call_method().

These should go to spapr_vof.c too as they are spapr specific.

Regards,
BALATON Zoltan

