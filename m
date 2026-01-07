Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42BECF6C1F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQ2C-0006Dp-Sx; Wed, 07 Jan 2026 04:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vdQ2A-0006B1-MH
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:40:55 -0500
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1vdQ28-0004NT-3g
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1767778831; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=kYSUVZIE46z3x5l35MgLCd8cxsJeQVmII4C9Tok+Zn0=;
 b=nLWMkA66aK8ZEzXXTICnCJksEwuN8LA9iYAC+8lo4+lL3Bq4QPMGusmxl9cxKhSPka6yAGvK5pDKEiYm9u2F4TPJwgKU5O/J1GTeLxSV38n+EsFy4V7EcByvv+dATfl2+1AH8/Rsi2Y0w0oW04brpg6Gq6jj9nv/71L3SAS1B0g=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0WwYRKKh_1767778820 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 07 Jan 2026 17:40:30 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: Re: Re: [PATCH] monitor: disable "info kvm" if !KVM
Date: Wed,  7 Jan 2026 17:40:20 +0800
Message-ID: <20260107094020.21819-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aVuUXHT9dt9-ytkG@redhat.com>
References: <aVuUXHT9dt9-ytkG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Daniel P. Berrangé wrote on Mon, 5 Jan 2026 10:37:16 +0000:

> Missing commit message explaining why we should do this ?

The reason for submitting this patch is that the newly supported 
'info accelerators' command can provide a more comprehensive view
of the accelerator's status.

> 
> The 'hmp_info_kvm' implementation is unconditionally built and this patch
> isn't changing that, so this result in building unused code.
> 
> Conceptually even if KVM is not built, it makes sense to have an
> 'info kvm' command to tell the user that KVM is not available.

I agree with you, we can skip this patch.

With regards,
Bin Guo

