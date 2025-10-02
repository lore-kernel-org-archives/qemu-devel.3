Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9412DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4JNM-00046r-Mg; Thu, 02 Oct 2025 09:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4JND-00046d-6y
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4JN1-0003Lo-Sf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759411748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bF5fWc1fclT13hLdnAfzAqIbK49bN/PxtTrFN4Ytt3s=;
 b=J8aMcIkBQkt3m6Yt94f8jkOfn+ag6VLX1kc85q97MWSyNq8Jj77rvzlh2rQsx807SzNtTK
 ZZhtCsAWtmMQ8bvVWoBtHKuWDSLs34rX7EMFtdBcIzVSVjFUzCh5nOl7ZmB8ibQ38M0vbE
 1f3F0wBFbRvLyHwMGOHu9g9q+Y+HrjY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-fvTcIZBCN0KPNMw1AXqxRg-1; Thu,
 02 Oct 2025 09:29:04 -0400
X-MC-Unique: fvTcIZBCN0KPNMw1AXqxRg-1
X-Mimecast-MFC-AGG-ID: fvTcIZBCN0KPNMw1AXqxRg_1759411744
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B93431955D5B; Thu,  2 Oct 2025 13:29:03 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.182])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F125730002C8; Thu,  2 Oct 2025 13:29:01 +0000 (UTC)
Date: Thu, 2 Oct 2025 15:28:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] block/monitor: Use hmp_handle_error to report error
Message-ID: <aN5-Cm_2HFZ4wn2Q@redhat.com>
References: <20250916054850.40963-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916054850.40963-1-guobin@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 16.09.2025 um 07:48 hat Bin Guo geschrieben:
> According to writing-monitor-commands.rst, best practice is to
> use the 'hmp_handle_error' function, which ensures that the
> message gets an 'Error: ' prefix.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

>      if (!blk_legacy_dinfo(blk)) {
> -        error_report("Deleting device added with blockdev-add"
> +        error_setg(&err, "Deleting device added with blockdev-add"
>                       " is not supported");
>          goto unlock;
>      }

Thanks, fixed up the indentation here and applied to the block branch.

Kevin


