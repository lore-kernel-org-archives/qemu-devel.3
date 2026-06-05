Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F65CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 06:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVO5K-00026k-PV; Fri, 05 Jun 2026 02:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wVO5E-00026a-Tb
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 02:31:09 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wVO5A-0006Px-8X
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 02:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780641044; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=nM9spnwjyr4EwK2pGYOZyZlKUnjA3CTRL1qc6ueb9wA=;
 b=xKtZQh4suj4+PdXFx5W8h0TfDnlbYC4l7dIi292YOROGvMZOae9QDggxney8gXKHHYZNcqc+P6IGu5Dzs1huiCPU7RdSFOMhJ9jwQc5/bTFvPspZfLdouIRmLws1UvtidRO/qiVUIkQzenitRtGjJXlU/9tK8R7Gen0mStXU+EA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X4CO6uC_1780641041; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X4CO6uC_1780641041 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 05 Jun 2026 14:30:42 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: philmd@mailo.com
Cc: armbru@redhat.com, guobin@linux.alibaba.com, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/virtio: propagate vhost_virtqueue_mask() errors from
 start path
Date: Fri,  5 Jun 2026 14:30:40 +0800
Message-ID: <20260605063040.65984-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <5ea46e73-1d5e-430f-b2df-62d6807a60f4@mailo.com>
References: <5ea46e73-1d5e-430f-b2df-62d6807a60f4@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

On Wed, 4 Jun 2026 14:57:41 +0200, Philippe Mathieu-Daudé wrote:
> IIUC the intention behind this TODO is to convert to a function
> returning a boolean and taking Error** as last argument, replacing
> this call with error_setg_errno().
> See in 'Error reporting system loosely patterned after Glib's GError'
> rules in 'qapi/error.h'.

Thanks for the suggestion. I considered changing the signature to
bool + Error **errp, but decided to keep the current int +
error_report() approach. vhost_set_vring_call is unlikely to fail
in practice, so this is defensive programming rather than a regular
error path. Changing the signature would propagate to ~15 call sites
across multiple files for what is a rare edge case, which seems
disproportionate. The patch already resolves the TODO and confines
the change to the start path.

