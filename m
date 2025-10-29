Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A40FCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE5BN-0006KO-5P; Wed, 29 Oct 2025 08:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vE5Az-0006GI-FZ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vE5Am-0007RP-8M
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761740459;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wBiYoYUIewHJawscgZp5RZFRsr1ejCyVQzSsqUhkuno=;
 b=N74jqZzbO5YFIMzWqN43PHsDbse4azC5VaZJDoMeEfUQ0Zjf5XxdzBQhbc915OwN3hEXB5
 HDfQBEn4rdbERrAAcScBx58L6ljWOTBTtMvzamBtVradUhhy2Hu+UF4ix4+KdA1A1tKjy3
 SqE57PC1EMFeHXF9svi59M0eqoeehqU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-bZJ9JPWDOgmUe9lvQdA7-w-1; Wed,
 29 Oct 2025 08:20:57 -0400
X-MC-Unique: bZJ9JPWDOgmUe9lvQdA7-w-1
X-Mimecast-MFC-AGG-ID: bZJ9JPWDOgmUe9lvQdA7-w_1761740456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 223521869BB8; Wed, 29 Oct 2025 12:20:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5193B195DD80; Wed, 29 Oct 2025 12:20:46 +0000 (UTC)
Date: Wed, 29 Oct 2025 12:20:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH] net: pad packets to minimum length in
 qemu_receive_packet()
Message-ID: <aQIGmodvOc0hTeIH@redhat.com>
References: <20251028160042.3321933-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028160042.3321933-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 28, 2025 at 04:00:42PM +0000, Peter Maydell wrote:
> In commits like 969e50b61a28 ("net: Pad short frames to minimum size
> before sending from SLiRP/TAP") we switched away from requiring
> network devices to handle short frames to instead having the net core
> code do the padding of short frames out to the ETH_ZLEN minimum size.
> We then dropped the code for handling short frames from the network
> devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
> Remove the logic of padding short frames in the receive path").
> 
> This missed one route where the device's receive code can still see a
> short frame: if the device is in loopback mode and it transmits a
> short frame via the qemu_receive_packet() function, this will be fed
> back into its own receive code without being padded.
> 
> Add the padding logic to qemu_receive_packet().
> 
> This fixes a buffer overrun which can be triggered in the
> e1000_receive_iov() logic via the loopback code path.
> 
> Other devices that use qemu_receive_packet() to implement loopback
> are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
> and sungem.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Since it is guest triggerable, this bug has been assigned
CVE-2025-12464

> ---
> I think this is the right fix, but I'm not very familiar
> with the net internals...
> ---
>  net/net.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


