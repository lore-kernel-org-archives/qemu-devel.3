Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2953C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 17:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukR9i-0007xm-8O; Fri, 08 Aug 2025 13:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ukR9a-0007jb-1C
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:45:18 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ukR9X-000675-Ui
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:45:17 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 059F6183FFB;
 Fri,  8 Aug 2025 17:45:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com
 (trex-blue-0.trex.outbound.svc.cluster.local [100.127.87.26])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 42B4C1841EA;
 Fri,  8 Aug 2025 17:45:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754675108; a=rsa-sha256;
 cv=none;
 b=goj8JFDjIpmbwL35l7YVIjwSm6Abdrxbpq2vP4eqBCEA6QuCxZqeX4cI0RbGAdKpBKhbPK
 6pHwuCSLq5HxtXQY5Cv1IYkw1qFTYLhUyavFSjrOnpA/p9OHk3YZJhyln6MLZtX7Odkvv1
 SFM23Holp4piAaaiaDIBhE6KWgYYN+n5dV278C/RfaeYZa68zPiWfFtgVx6yrgz0TOTGtj
 hqb48ZLXfcCh4wZ8IuB5HPYT0fwt7z6O+WkQYCY0qqiU/LLBuD9g7O49zLQDoSJSvlaNQX
 zsWhAk1s724dq4TGQFvTaF5BBei2KmDT9RhOhJG2ICuzEM90aFPhhUcXD5jUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1754675108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=L+//x0OiU4vRfdzYpDpIyu3Udi9Pg/D06DDaLgbvwPA=;
 b=hTYFTM6dIz7OTS91+Bo/7Yu8ss66hdsm0oOZYFxB9zxnWAD4fdbI8MobaisdxyW0lBOrn7
 CuxCWx3Nn/CvyDD8gIVtDKbkC5t+juDHLXyyVAmP7e9aBxBcj3r1HtPrtmc2iACYNcGfwa
 4jhGHdxGOm/B2UD82XZ+Qe/XWFfU6dNMZrDmx/0ZMOEOhgAm/39btUNsTEMbGGfKTBKwfd
 rrQKUAT0tBkUuOycLuSMK485Ya+j3Kx42PF5Rgtbu1+tdzUrEMkZVfTbAJicD3+eEUpohW
 ysskGqVMbqHud8NE8w8g0zowKiGLkUoVVRVV94VuOWY5pH9ykO1fAgKLOcsmJg==
ARC-Authentication-Results: i=1; rspamd-698857ffff-qvcsq;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Plucky: 0c3730915e31feb1_1754675109824_984163914
X-MC-Loop-Signature: 1754675109824:3146162050
X-MC-Ingress-Time: 1754675109824
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.127.87.26 (trex/7.1.3); Fri, 08 Aug 2025 17:45:09 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4bzBJ340mSzKn; 
 Fri,  8 Aug 2025 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1754675108;
 bh=L+//x0OiU4vRfdzYpDpIyu3Udi9Pg/D06DDaLgbvwPA=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=iZw1CiiIERXcOPxX7KHVU1IetM4+QcNlR7yE/vPUoVgfXMYObaiyos0qd9zenc4rC
 mnD6tdLgjA/k2xkou/n/EfhvXF+4iOMSihcimWi5gR3ZMaqfE8jZOZW86gCnN/r2PD
 CkmQfts7S8z9JdaobC6aCvAWvfbUOKMD78GpJEEb8X9eSvMstW+Wc2rCdtcERJisVe
 vaiYzYQxuhn14SRnQnWUPcP+MT/iVlhkAtHNf6xn5sFhUqHlby6XRhM0SFdheVOzpK
 6pa+96ilwUHL0z9/YphUt7BrtKZ++XR9Ap43zfrMoyKKlZ/uP1ogbfnC7HX3N9Wm5f
 8F97N1BAuJ/8g==
Date: Fri, 8 Aug 2025 10:45:04 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
Message-ID: <20250808174504.mh2kte35yuglvl2y@offworld>
References: <20250806055708.196851-1-dave@stgolabs.net>
 <20250806055708.196851-2-dave@stgolabs.net>
 <20250808164216.0000196b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250808164216.0000196b@huawei.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.223.164; envelope-from=dave@stgolabs.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 08 Aug 2025, Jonathan Cameron wrote:

>This looks a bit like an interface that evolved, but in the end
>you seem to have something that is a simple boolean property.
>As such you can avoid a fair bit of complexity.

Yeah, I started out having this as a bool property. But the alignment
with the other link training properties felt right, albeit a bit of
an overkill. At one point I considered the automatic training (which
you point out missing here) being an option, so having off/on/auto,
but that also seems like an overkill.

>Look for disable-acs for an example.

Ok, so with a counter example, I think you are right.

>I don't know if it is desirable to make it an explicit type or not,
>but my gut says boolean is fine here.
>
>+CC A few potentially relevant people to answer that question more
>definitively.

Unless someone shouts, I will go with just the bool prop.

Thanks,
Davidlohr

