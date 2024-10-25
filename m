Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C97D149C5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4N6l-0006vR-82; Fri, 25 Oct 2024 12:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4N6k-0006vJ-AZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4N6i-0007a1-PF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729873451;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htuntEKJ84Pi1IcVEYSsFNh54E5EXmLgaahQ440DmJk=;
 b=HJ/h/tDPIvUz7mNUK10N0tz3fvhRir4q+CgQxupzZzUQ5yVy20WL3ulKsrtwmcd1Nb81dr
 2cWVfmINDwVruespst7rjHPQ27k+W8MTaenf2598wgjw0zpwUz0fAdjQaQWAR+MvGhZ0wj
 uJQ+6Ci8LFA/kTUp2Ffhbugk/rLolZQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-VngtK0g1MHObaHsCaWdYCQ-1; Fri,
 25 Oct 2024 12:24:08 -0400
X-MC-Unique: VngtK0g1MHObaHsCaWdYCQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CC691956096; Fri, 25 Oct 2024 16:24:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 620071956056; Fri, 25 Oct 2024 16:24:00 +0000 (UTC)
Date: Fri, 25 Oct 2024 17:23:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: qemu-devel@nongnu.org, alejandro.zeise@seagate.com, clg@redhat.com,
 qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, bcain@quicinc.com, sidneym@quicinc.com
Subject: Re: qcrypto_ivgen mem leak and possible issue?
Message-ID: <ZxvGHesrhPlQri__@redhat.com>
References: <60849a6166bba234230bc1761835cc188a9f765f.1729858348.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60849a6166bba234230bc1761835cc188a9f765f.1729858348.git.quic_mathbern@quicinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 25, 2024 at 01:06:01PM -0300, Matheus Tavares Bernardino wrote:
> Hi,
> 
> Since e3c07527f3 (crypto/hash: Implement and use new hash API,
> 2024-10-08), we've been seeing a memory leak in two check-unit tests:
> test-crypto-hash and test-crypto-ivgen. Looking a bit further to try and
> plug the leak, I got a bit confused regarding how the result crypto
> buffer is handled. Looks like we are allocating different sizes at two
> different places, and I'm unsure if these places follow the same
> convention or could be breaking expectations from one another...

There was a screwup in the commit you mention causing a memory leak. Can
you check whether it reproduces after

commit dde538c9a76f328a92c532893e97e18785d57364
Author: Daniel P. Berrangé <berrange@redhat.com>
Date:   Tue Oct 15 13:25:36 2024 +0100

    crypto/hash: avoid overwriting user supplied result pointer


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


