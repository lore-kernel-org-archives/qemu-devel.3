Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A51DC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 06:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS9bO-0007EK-Gk; Fri, 12 Jul 2024 02:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Ecin=OM=kaod.org=clg@ozlabs.org>)
 id 1sS9bJ-0006uy-DM; Fri, 12 Jul 2024 02:17:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Ecin=OM=kaod.org=clg@ozlabs.org>)
 id 1sS9bH-00011S-C4; Fri, 12 Jul 2024 02:17:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WL1bj2hByz4x3J;
 Fri, 12 Jul 2024 16:17:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WL1bf4hZLz4w2R;
 Fri, 12 Jul 2024 16:17:34 +1000 (AEST)
Message-ID: <4b48cb7b-22e1-4378-8482-0cf25bf28919@kaod.org>
Date: Fri, 12 Jul 2024 08:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync
 Injection support
To: Mike Kowal <kowal@linux.ibm.com>, Michael Kowal
 <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
 <20240617204302.12323-2-kowal@linux.vnet.ibm.com>
 <12c2313d-0c7f-4063-85f6-768f5d657ae5@kaod.org>
 <b7d5e3cb-f6e2-431c-aa96-b728f94f637d@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <b7d5e3cb-f6e2-431c-aa96-b728f94f637d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ecin=OM=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Mike,

On 7/11/24 22:57, Mike Kowal wrote:
> Hello Cedric,
> 
> This patch will be split into 5 patches to ease the review.  I also acknowledge most of your other comments.
> 
> Can you elaborate on the gic_get_current_cpu() comment?  
> Did you want me to use that method name to get a the current CPU?  

I meant introducing a similar routine for XIVE to hide the qtest
environment differences from the model. Something like :

static inline int pnv_xive2_get_current_pir(PnvXive2 *xive)
{
     if (!qtest_enabled()) {
         return ppc_cpu_pir(POWERPC_CPU(current_cpu));
     }
     return 0;
}

> Also, is this something that you think needs to done at this current time since there are many other existing uses to get the CPU,

The other uses of current_cpu are in the TIMA memops. They should be
immune to this problem since the ops should always be done from a CPU.

> or can we delay this and an issue for for this to be done at a later time?

It is minor. That said, it is not a big change compared to the split.

Thanks,

C.



