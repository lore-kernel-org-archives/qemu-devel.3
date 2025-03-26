Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AD7C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNE5-0005Zp-IS; Wed, 26 Mar 2025 05:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txNDP-0005VD-HY
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txNDN-0003tD-Co
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742981900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieSNi769iE2kZGsTm0qucrKRl7/I35INrEONTRk73Po=;
 b=F3iaIfoQ1nk+haXFn4Qhwh2bnoc2V5v5fTQJ2+nsAxSAJBtTjsUpjER3gYG1aLNPEHLSbc
 Gq/1Of1gprnPyly9tUvjSMSd27bSFGs6/4km+Ss4Pl1dL83RfnvxVNdlseKbp+fnbYJ8G1
 NOlphG2D/MRH4G0aRwn5U3NEQAnZsjw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-IQrS3UVUNFCmM-66woQlvw-1; Wed,
 26 Mar 2025 05:38:17 -0400
X-MC-Unique: IQrS3UVUNFCmM-66woQlvw-1
X-Mimecast-MFC-AGG-ID: IQrS3UVUNFCmM-66woQlvw_1742981896
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66800180025C; Wed, 26 Mar 2025 09:38:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D017D19541A5; Wed, 26 Mar 2025 09:38:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6EC021E66C7; Wed, 26 Mar 2025 10:38:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: vitalif@yourcmc.ru
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Can I contribute Vitastor block driver? Or maybe introduce a
 QAPI plugin system?
In-Reply-To: <bd5c6126f8c345b1eeac617d4023fa58@yourcmc.ru>
 (vitalif@yourcmc.ru's message of "Sat, 22 Mar 2025 17:13:00 +0000")
References: <bd5c6126f8c345b1eeac617d4023fa58@yourcmc.ru>
Date: Wed, 26 Mar 2025 10:38:11 +0100
Message-ID: <871pukb08s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I'm not speaking for the QEMU project.  I hope to be helpful anyway.  I
am the QAPI maintainer, so my thoughts carry a bit more weight there.

I understand your block driver depends on your libvitastor_client
library.

Dependencies that aren't available on at least one supported build
platform (and thus covered by CI) are problematic.  For Linux,
"available" generally means "provided by the distribution".  I doubt
there's a way around getting your library packaged by distributions.

The QAPI schema is (for better or worse) fixed at compile time by
design.  Changing that would be a major undertaking.  Whether the
benefits could justify the costs and risks seems rather doubtful to me.

In my experience, the project invites contributions, not out-of-tree
extensions.  The latter require external interfaces, which can only be
harder to maintain than internal ones.  There's also the risk of abuse
to circumvent the GPL (I have absolutely no reason to assume you'd try
that!).


