Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8762CCD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 06:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRl5q-0004wL-3i; Tue, 26 May 2026 02:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wRl5j-0004tK-Hd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wRl5e-0004Wu-PS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779776193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tz+KrfrJxeTwS3lYGFCW2aSfMt4aO/IqSxiV6pbGlwA=;
 b=YV/TBl0uzV62+FHyxHUE8NEBMULHTWgJO78Vhzb/Fxkr4vvCp+wyMTE472FevzeXT4GJtB
 vsRXJ9pqs2k2x+Zta3HP5QLMv/afIl8Heg6KO9VdPb/YAHMkYpymjXeXUM71WSv9Ygc2T6
 sPQKDVhk7H+bxCbmvU+fHHSvk9w+iAA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-nF53uU22O3OAUZBpdUQ6AA-1; Tue,
 26 May 2026 02:16:31 -0400
X-MC-Unique: nF53uU22O3OAUZBpdUQ6AA-1
X-Mimecast-MFC-AGG-ID: nF53uU22O3OAUZBpdUQ6AA_1779776190
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A363C18005B6
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 06:16:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B25119560A3; Tue, 26 May 2026 06:16:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 053E91800385; Tue, 26 May 2026 08:16:29 +0200 (CEST)
Date: Tue, 26 May 2026 08:16:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] igvm: fix handling of optional variable header types
Message-ID: <ahU45pjlamnTs9ow@sirius.home.kraxel.org>
References: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
 <4ED1F4C8-B56E-4997-99CB-C509629F13C7@redhat.com>
 <ahRZH2bUbuQnirr_@leonardi-redhat>
 <8AFE933D-028C-44FC-802A-604298107627@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8AFE933D-028C-44FC-802A-604298107627@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> >> I think this check should be at the top of the loop. If the bit is set, simply return with that warning message. No further processing is needed.
> > 
> > IIUC, in this way we would always skip optional parameter, right? My idea is to
> > always process optional parameters if we support it.
> 
> The spec says:
> 
> "The top bit of this type may be set to indicate a loader may safely ignore that structure.”
> 
> So if the bit is set, the way I understand it, there is no need for further processing.

I read that as "If that directive is unsupported (by the hypervisor) it
safe to skip it (instead of throwing an fatal error)", so In think the
patch is correct in looking at the flag in the error handling code path.

Never processing the directive also doesn't make much sense, why would
one write such a directive into the igvm file in the first place?

take care,
  Gerd


