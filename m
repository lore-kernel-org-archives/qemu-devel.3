Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB93C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJRM-0007WR-GB; Mon, 13 Jul 2026 12:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjJRF-0007Vk-A9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjJRC-0000nM-Mb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783959800;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63rt5rcDYCJ3Kca5ykIssLH072xpV/XeCugaKiyrjB4=;
 b=F2QIHnLKlxgVn6WMWYlN4IlfdUk4XufRz4MjbMPYQcalo0d4yMfG+yEPLzPC60Hkpudjs0
 /EeHHefWig6MGF7VtCKUN4G1S/ej6RldoJrNK5TctCr91FuxhMq0LZyn7EnfP0/uqogQyr
 TSDd1ukxYheFCBTGMw844SPUhrXP7IA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-DXQCdg2EN8SHtLSq1qZ1ZA-1; Mon,
 13 Jul 2026 12:23:19 -0400
X-MC-Unique: DXQCdg2EN8SHtLSq1qZ1ZA-1
X-Mimecast-MFC-AGG-ID: DXQCdg2EN8SHtLSq1qZ1ZA_1783959798
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE5EB1955F21; Mon, 13 Jul 2026 16:23:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43E621800595; Mon, 13 Jul 2026 16:23:15 +0000 (UTC)
Date: Mon, 13 Jul 2026 17:23:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/usb/hcd-ohci: Make sure that ohci_service_ed_list()
 cannot loop forever
Message-ID: <alUQ71c_k5VehJD-@redhat.com>
References: <20260713160458.343323-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713160458.343323-1-thuth@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 13, 2026 at 06:04:58PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The inner while loop in ohci_service_ed_list() could theoretically
> loop forever if a malicious guest prepares a set of bad descriptors.
> Add a check to the loop to avoid this situation.
> 
> Reported-by: Feifan Qian <bea1e@proton.me>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3781
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-ohci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


