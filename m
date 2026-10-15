Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE68CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMen-0000Kd-Ep; Thu, 15 Oct 2026 10:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHMeS-0000K3-VT
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHMeQ-000731-8w
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792075304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWOGpW3lPcCzBqgxlGsBNivYIJL9m62lQWPPhHCkk38=;
 b=QYelqCC0/rq86vU8PUiaTaDSkavOL7DFPLPnGpy7LIt5aydHIoUpn1NrvBHapl194GC4Ce
 QJyvgg+NgiWHMndG1H8rQsKMoelei6jB/8zXEOLZ+YYxmbrB2EABV6AHUMJPeUNRXA7qx9
 e6Vgkxx2LwjWtGKIH7hFwW3U1FbZCYQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-hwmsojaANFum0lgPdQ-VZg-1; Thu,
 15 Oct 2026 14:41:40 +0000
X-MC-Unique: hwmsojaANFum0lgPdQ-VZg-1
X-Mimecast-MFC-AGG-ID: hwmsojaANFum0lgPdQ-VZg_1792075298
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2445180049D; Thu, 15 Oct 2026 14:41:38 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74A681800257; Thu, 15 Oct 2026 14:41:37 +0000 (UTC)
Date: Thu, 15 Oct 2026 09:41:34 -0500
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Subject: Re: [PULL v3 00/15] NBD patches through 2026-10-08
Message-ID: <atDlexx5t7UXUqZ6@redhat.com>
References: <20261014184309.664714-17-eblake@redhat.com>
 <CAFXwXrnm0aNhfwfMXLe6DnM31Z7MKX7h=6UiVNusyVkZC8nGDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXwXrnm0aNhfwfMXLe6DnM31Z7MKX7h=6UiVNusyVkZC8nGDw@mail.gmail.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 15, 2026 at 10:53:39AM +0200, Richard Henderson wrote:
> https://gitlab.com/qemu-project/qemu/-/pipelines/2949515618
> 
> Still 8 job failures, and this time they're clearly nbd related. Did you
> not see these when testing yourself? Or is it a quirk of our k8s ci setup
> for merge testing?

Both 'make check' and 'cd build/tests/qemu-iotests; ./check -nbd' are
passing for me, but since k8s seems to be tickling something I didn't
see locally, I'll continue investigating.

Is there an easier way for me to run the CI tests on my own branch
without sending a pull request, so that I can see the same job
failures without having to cost your time first?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


