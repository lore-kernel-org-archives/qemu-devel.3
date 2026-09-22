Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389FCC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x90nt-00013k-8M; Tue, 22 Sep 2026 09:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1x90nq-00013V-O0; Tue, 22 Sep 2026 09:44:58 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1x90no-0000Gs-90; Tue, 22 Sep 2026 09:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
 From:Reply-To; bh=5taSLr7GIX4fPK9H2FQq9GvoXAHyNlp/SCEFOVb/Xk8=; b=YbFFYc4CYIj
 dkLHIfl0KADZ+jFGLo0X57tTDDCVBaV4s5+tI90BCtt2hvo7Nn6bMNkT0gy2VOLtDTLv/pv+W6z63
 RJRZ7pdnHjTQj3DAprhk7LcVYNsnGdIFZ3oZ4Vqn/uUnUjOqICEmBm0/TpwRL8sHvz+KL4Fk8HBcE
 JZDEhJlaSqCfyqy/ZcA6+YrK+/MqbB9eyfZJI92ppUchPfEfB0BojtWOQCq0M/paLgDpv85ps2IPP
 WgHMfcr54r85gJh3IYQlZGyDgfHIJpw8DsgtycYpNQaN8+BHfZsD3rJoC3+GM5RBfbyZG8+MOZxpk
 jVYkqfAeL0DJazn9qT1zzsw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x90nf-005ebq-1P; Tue, 22 Sep 2026 15:44:46 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1x90ne-006fag-1E; Tue, 22 Sep 2026 15:44:46 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1x90nd-004VXl-2o;
 Tue, 22 Sep 2026 13:44:45 +0000
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH 8/9] block/accounting: Move latency_ns override down
In-Reply-To: <arJ8tNgp9tDtKkfO@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-9-hreitz@redhat.com>
 <20260903150842.GF825275@fedora>
 <292ff2f9-b3fe-423b-9b36-ada26904a617@redhat.com>
 <20260921204237.GD115897@fedora> <arJ8tNgp9tDtKkfO@redhat.com>
Date: Tue, 22 Sep 2026 15:44:45 +0200
Message-ID: <w51mrt9tn76.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue 22 Sep 2026 03:03:56 PM +02, Kevin Wolf wrote:
> Am 21.09.2026 um 22:42 hat Stefan Hajnoczi geschrieben:
>> On Wed, Sep 16, 2026 at 10:21:22AM +0200, Hanna Czenczek wrote:
> What's even stranger is that both things were introduced in the same
> commit. But it seems clearly related to 136 because the change was made
> right before the test was added.
>
> Berto, do you remember why you didn't rely just on clock_step?

No, sorry, I don't remember :-/ I guess I wasn't familiar with that
function? 136 was one of the first tests that I wrote.

Berto

