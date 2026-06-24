Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9016ECDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOMG-0000vM-KZ; Wed, 24 Jun 2026 10:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wcOM6-0000tb-Rw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wcOM3-0006Z8-Ln
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782310398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HoTLy72hsjzaCW4u8adniCfvGR5Gay/W66gkz1kuIZQ=;
 b=W0OvjqA/6HDrJiCqbhAmWaByCCjnsDnNfwsjfTwXcliCDSDFqzuPu9qcT+EUmDWcfktfxm
 aQ5AuljpGwYyycBx4fIj5udSAryPhNrIocgrft+XoJeW1qsgM0F0LunwZqfcqy5fujziUY
 eb3THHLwmRpAhGnCBh9puZZ474YSpLg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-0TRKS9XKP7ueho4zIMiBjg-1; Wed,
 24 Jun 2026 10:13:10 -0400
X-MC-Unique: 0TRKS9XKP7ueho4zIMiBjg-1
X-Mimecast-MFC-AGG-ID: 0TRKS9XKP7ueho4zIMiBjg_1782310389
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3FE91953995; Wed, 24 Jun 2026 14:13:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C1423000B55; Wed, 24 Jun 2026 14:13:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 36D84180078A; Wed, 24 Jun 2026 16:13:07 +0200 (CEST)
Date: Wed, 24 Jun 2026 16:13:07 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alex Graf <graf@amazon.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
Message-ID: <ajvkMcvEaIcWtT6M@sirius.home.kraxel.org>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
 <ajudPOcejMvGTTJB@sirius.home.kraxel.org>
 <602FAB73-36A1-41A0-97AA-7541102F23A4@redhat.com>
 <ajvDMzTGk91aJl9d@sirius.home.kraxel.org>
 <129574FC-96A4-4E0C-81E8-338E68DD3675@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <129574FC-96A4-4E0C-81E8-338E68DD3675@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> >> Where would you put the api header file?
> > 
> > standard-headers/misc/ looks good to me.
> 
> Hmm, checkpatch is not happy
> 
> ERROR: headers imported from Linux should be self-contained in a patch with no other changes
> #89: FILE: include/standard-headers/misc/vmlaunchupdate.h:1:
> +/*

Make adding include/standard-headers/misc/vmlaunchupdate.h a
separate patch then?

checkpatch doesn't complain about the location but about the patch
doing other stuff too.

take care,
  Gerd


