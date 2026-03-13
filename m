Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F330105F789
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0zCN-0003L3-JF; Fri, 13 Mar 2026 05:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w0zCL-0003Iv-Je
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 05:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w0zCJ-0000tD-IM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 05:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773395564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPyYjRMH6JRA7gjow27xtw2ayb9JUSXtIpXL73QkzOg=;
 b=SRznCjYUqNlMywSMynjt96KawWCp8SnRasR2l4jigpWA0+Feds4WJKLWsrRxbxMkLgrliz
 b38hOzCDau2a102mXExWQ8LhlE/PKYQElo11xjbSyDXV+Utu/RoM+mQbU+3Cei/8NtHflz
 BVzZ2PpPB6A9ZtZVrDKirNZWg/fW4Eg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-uEYAaYCwMFKq30eZlqIU8Q-1; Fri,
 13 Mar 2026 05:52:40 -0400
X-MC-Unique: uEYAaYCwMFKq30eZlqIU8Q-1
X-Mimecast-MFC-AGG-ID: uEYAaYCwMFKq30eZlqIU8Q_1773395559
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 223561800345; Fri, 13 Mar 2026 09:52:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94E271800761; Fri, 13 Mar 2026 09:52:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 567D51800381; Fri, 13 Mar 2026 10:52:36 +0100 (CET)
Date: Fri, 13 Mar 2026 10:52:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org, 
 joe.jin@oracle.com
Subject: Re: [PATCH v2 0/2] hw/nvram/fw_cfg: update bootorder to fix SeaBIOS
 bootup failure
Message-ID: <abPdfr7sx55TCnD8@sirius.home.kraxel.org>
References: <20260310170712.46336-1-dongli.zhang@oracle.com>
 <abFSF_Mt6xbMEzXz@sirius.home.kraxel.org>
 <8702e349-bbe6-403b-b58f-d4e33a83b271@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8702e349-bbe6-403b-b58f-d4e33a83b271@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Hi,

> Regarding "Neither seabios nor ovmf have hotplug support", we are not using
> hotplug with SeaBIOS or OVMF in this scenario.
> 
> This is a cold-plug operation performed during QEMU prelaunch state, before any
> system software starts running.
> 
> (1) Create QEMU with "-S" at prelaunch.
> (2) Attach disks.
> (3) "cont" for QEMU.
> 
> In other words, we cold-plug the new disks before SeaBIOS starts.
> 
> However, because the "bootorder" data from QEMU is stale, SeaBIOS cannot
> construct the correct boot order once it begins executing.

system_reset will fix that.

> Therefore, would you mind helping confirm if to issue a system_reset manually is
> still the best option so far?

Yes, I think so.  Specifically it has the advantage to work just fine
with already released qemu versions, and sending one extra command
between (2) + (3) should not be much of a problem for the management.

take care,
  Gerd


