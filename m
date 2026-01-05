Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F593C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 14:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vclTL-0006i7-HP; Mon, 05 Jan 2026 09:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vclSj-0006OE-Ex
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:21:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vclSf-0005ZT-MZ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767622889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXUFGKTdFzvtnE3PpjcRLL7BiKJAGPCVKgtAni3qKss=;
 b=PmrzjNqnYwWBaoFquauhFMNqh4frJm5SjFh8hq2VnHwtboShtCYrJr4MgZcjpIwY/k+y+d
 0r9AExcJV9UKGukoowqWwV+V7BnsX64rY2pEHxJKiuWZ8vPSptVZQTZvdwRvGXmoQbe1W6
 yH9hxo1u6CqALRWFAASJbThALzAYLug=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-yjjQXNQMMh-LxtBeVXglRg-1; Mon,
 05 Jan 2026 09:21:26 -0500
X-MC-Unique: yjjQXNQMMh-LxtBeVXglRg-1
X-Mimecast-MFC-AGG-ID: yjjQXNQMMh-LxtBeVXglRg_1767622885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06E601955DC2; Mon,  5 Jan 2026 14:21:25 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.33.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D0DE19560AB; Mon,  5 Jan 2026 14:21:23 +0000 (UTC)
Date: Mon, 5 Jan 2026 15:21:20 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Pavel Hrdina <phrdina@redhat.com>
Subject: Re: [PATCH v2 0/3] scripts: render_block_graph: Fix with new python
 and improve argument parsing
Message-ID: <aVvI4Ai7zBXubkVb@angien.pipo.sk>
References: <cover.1742401551.git.pkrempa@redhat.com>
 <aEgnsqTpcX0Fp3vx@angien.pipo.sk>
 <CAFn=p-aYMQb-StChaph_m-2qXY_1AW4PTx_ZkAOE1bTLchq=Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-aYMQb-StChaph_m-2qXY_1AW4PTx_ZkAOE1bTLchq=Hw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 15:54:54 -0400, John Snow wrote:
> On Tue, Jun 10, 2025 at 8:40 AM Peter Krempa <pkrempa@redhat.com> wrote:
> 
> > On Wed, Mar 19, 2025 at 17:28:06 +0100, Peter Krempa wrote:
> > > New python doesn't like '\l' escapes from the 'dot' language.
> > >
> > > While at it improve usability of the script by employing proper argument
> > > parsing.
> > >
> > > v2:
> > >  - use mutually exclusive group instead of hardcoding it (Pavel)
> > >
> > > Peter Krempa (3):
> > >   scripts: render_block_graph: Fix invalid escape sequence warning with
> > >     python 3.12
> > >   scripts: render_block_graph: Implement proper argument parser
> > >   scripts: render_block_graph: Avoid backtrace on error from virsh
> >
> > Ping :)
> 
> 
> Ah darn, guess that's me.
> 
> Tempted to just say "LGTM!" but lemme give it the once over here ... If you
> don't hear back within a day or two just ping my email box directly to nag
> me, please-and-thank-you.

I guess I forgot to ping you :)


