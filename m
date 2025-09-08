Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6895CCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 18:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvgQX-0003Eg-6O; Mon, 08 Sep 2025 14:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvgQ6-000393-I0
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvgPo-0007jX-Df
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757355386;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7BhYZLA73vmDnayhmg99fvTYebwVpwehkNxbY5c8LE=;
 b=ES2AMOE7bv4y6jLCe+7p8nSUBaiUKKcGr9CX7tz18yTWH2Ei4Nu973+uvdBKxpOvybI9rT
 NuzGTb5sSfbyM/XE3+FELQlU8XI6gh5lBugN27I8al/onW0SVH3HRQHFeX05Y1jiymv4bf
 AQiNxwseoQGLkaiLYAt6U0Ar8CBMyFk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255--QapRdTmM96psyKneJGLrg-1; Mon,
 08 Sep 2025 14:16:22 -0400
X-MC-Unique: -QapRdTmM96psyKneJGLrg-1
X-Mimecast-MFC-AGG-ID: -QapRdTmM96psyKneJGLrg_1757355381
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13C2D1800451; Mon,  8 Sep 2025 18:16:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA67219560A2; Mon,  8 Sep 2025 18:16:18 +0000 (UTC)
Date: Mon, 8 Sep 2025 19:16:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 06/18] python: backport 'qmp-shell: add common_parser()'
Message-ID: <aL8db__GHtsd7Tup@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-7-jsnow@redhat.com>
 <aL8IsV55wwhSxSeu@redhat.com>
 <CAFn=p-aTVUng3s7zU1Kpy4-jCsrXkKAbVPKw-ZACKmvL1Sy0eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-aTVUng3s7zU1Kpy4-jCsrXkKAbVPKw-ZACKmvL1Sy0eA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 08, 2025 at 01:39:58PM -0400, John Snow wrote:
> On Mon, Sep 8, 2025 at 12:47 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Sep 03, 2025 at 01:11:12AM -0400, John Snow wrote:
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > cherry picked from commit 20a88c2471f37d10520b2409046d59e1d0f1e905
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >
> > Duplicate s-o-b
> 
> One is from the original commit, the other is from the backport.
> Wasn't sure if that was truly needed, but figured it wouldn't hurt
> anything.

Yes, I realized when looking at later commits, that's fine.

> 
> >
> > > ---
> > >  python/qemu/qmp/qmp_shell.py | 35 ++++++++++++++++-------------------
> > >  1 file changed, 16 insertions(+), 19 deletions(-)
> >
> > Wierdly the diffstat when I looked qmp_shell.py is very different
> > from what your patch here shows, but the end result appears the
> > same. Perhaps one of us has different settings for $HOME/.gitconfig
> > that affects diff display
> 
> Possible. I didn't exactly take care to preserve the commits
> themselves exactly as they were ...



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


