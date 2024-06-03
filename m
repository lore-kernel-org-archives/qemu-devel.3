Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F05C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEALn-0007uj-3h; Mon, 03 Jun 2024 12:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEALc-0007k8-0C
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEALa-00029N-I1
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717431345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOgFuMBurAqOKz9iS6kqAwk42G426JCtUxAH+b4trqg=;
 b=T+pWPPzAi3PPgdlb/jxvjEIGQP9JE8W7XzApqNtaHv9aPGjP0y6iRG7wf/Oeu1EuJPoxUX
 IS/RhuZ6USU3n7sJN7v3DiMoAe7e06XNjPTVisRTbEatf6jwPAZV4F5PxxFXDAsRhpXxVO
 aP1EA96wWtghaPL5PPjcpc2+Lh075Gc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-EK2IStn5O1avenL0eYYlog-1; Mon, 03 Jun 2024 12:15:41 -0400
X-MC-Unique: EK2IStn5O1avenL0eYYlog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8915780028D;
 Mon,  3 Jun 2024 16:15:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67E1F201810E;
 Mon,  3 Jun 2024 16:15:40 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:15:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 2/2] iotests: test NBD+TLS+iothread
Message-ID: <Zl3sK68Y4v0h-1d8@redhat.com>
References: <20240531180639.1392905-4-eblake@redhat.com>
 <20240531180639.1392905-6-eblake@redhat.com>
 <Zl2svHuiX0_t2ctw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl2svHuiX0_t2ctw@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 03.06.2024 um 13:45 hat Daniel P. Berrangé geschrieben:
> On Fri, May 31, 2024 at 01:04:59PM -0500, Eric Blake wrote:
> > Prevent regressions when using NBD with TLS in the presence of
> > iothreads, adding coverage the fix to qio channels made in the
> > previous patch.
> > 
> > The shell function pick_unused_port() was copied from
> > nbdkit.git/tests/functions.sh.in, where it had all authors from Red
> > Hat, agreeing to the resulting relicensing from 2-clause BSD to GPLv2.
> > 
> > CC: qemu-stable@nongnu.org
> > CC: "Richard W.M. Jones" <rjones@redhat.com>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  tests/qemu-iotests/tests/nbd-tls-iothread     | 168 ++++++++++++++++++
> >  tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 ++++++
> >  2 files changed, 222 insertions(+)
> >  create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
> >  create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out
> 
> 
> 
> > +# pick_unused_port
> > +#
> > +# Picks and returns an "unused" port, setting the global variable
> > +# $port.
> > +#
> > +# This is inherently racy, but we need it because qemu does not currently
> > +# permit NBD+TLS over a Unix domain socket
> > +pick_unused_port ()
> > +{
> > +    if ! (ss --version) >/dev/null 2>&1; then
> > +        _notrun "ss utility required, skipped this test"
> > +    fi
> > +
> > +    # Start at a random port to make it less likely that two parallel
> > +    # tests will conflict.
> > +    port=$(( 50000 + (RANDOM%15000) ))
> > +    while ss -ltn | grep -sqE ":$port\b"; do
> > +        ((port++))
> > +        if [ $port -eq 65000 ]; then port=50000; fi
> > +    done
> > +    echo picked unused port
> > +}
> 
> In retrospect I'd probably have suggested putting this into
> common.qemu as its conceptually independant of this test.

If we make it generic, should nbd_server_start_tcp_socket() in
common.nbd use it, too, instead of implementing its own loop trying to
find a free port?

Kevin


