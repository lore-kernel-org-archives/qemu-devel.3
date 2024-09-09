Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78622ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngXB-0005vd-2a; Mon, 09 Sep 2024 11:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sngX9-0005n5-WD
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sngX8-000413-95
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725896549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwKEHGp6ByZ7EpqsMvWZHKTnJ5RyEHMaR8tEmjcvLXA=;
 b=FhpphffrDHHiVPasc6X2hmsVnw6gSixIxzBCiP76UsjBgpJaGWHmiWoNz065dYOxJAPf1G
 NuHw+DzDbwbiyzZDDfcEFhV84Ky6mHnZla8ZpKMtVKKE2ugrikjRtcZu/zwiogLDZgmGBO
 8nkT2/0wVjrf8NYn+TJy99qbg9eaGC0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-wHd4IjKwPni36hRlAI0DAA-1; Mon,
 09 Sep 2024 11:42:26 -0400
X-MC-Unique: wHd4IjKwPni36hRlAI0DAA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85EE7195608C; Mon,  9 Sep 2024 15:42:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27B6D300147D; Mon,  9 Sep 2024 15:42:17 +0000 (UTC)
Date: Mon, 9 Sep 2024 17:42:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH] block: support locking on change medium
Message-ID: <Zt8XV5jEgxBWrI7u@redhat.com>
References: <20240909015847.40377-1-j@getutm.app> <Zt7GM1uLzE5Z176u@redhat.com>
 <CA+E+eSCUQp4=9Xb_=E_L8fTyzjQvSScXNfROsUkfCP4TCcg9bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+E+eSCUQp4=9Xb_=E_L8fTyzjQvSScXNfROsUkfCP4TCcg9bg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 09.09.2024 um 16:25 hat Joelle van Dyne geschrieben:
> On Mon, Sep 9, 2024 at 2:56 AM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 09.09.2024 um 03:58 hat Joelle van Dyne geschrieben:
> > > New optional argument for 'blockdev-change-medium' QAPI command to allow
> > > the caller to specify if they wish to enable file locking.
> > >
> > > Signed-off-by: Joelle van Dyne <j@getutm.app>
> >
> > I feel once you need to control such details of the backend, you should
> > really use a separate 'blockdev-add' commannd.
> >
> > If it feels a bit too cumbersome to send explicit commands to open the
> > tray, remove the medium, insert the new medium referencing the node you
> > added with 'blockdev-add' and then close the tray again, I can
> > understand. Maybe what we should do is extend 'blockdev-change-medium'
> > so that it doesn't only accept a filename to specify the new images, but
> > alternatively also a node-name.
> >
> > > +    switch (file_locking_mode) {
> > > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO:
> > > +        break;
> > > +
> > > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_OFF:
> > > +        qdict_put_str(options, "file.locking", "off");
> > > +        break;
> > > +
> > > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_ON:
> > > +        qdict_put_str(options, "file.locking", "on");
> > > +        break;
> > > +
> > > +    default:
> > > +        abort();
> > > +    }
> >
> > Using "file.locking" makes assumptions about what the passed filename
> > string would result in. There is nothing that guarantees that the block
> > driver even has a "file" child, or that the "file" child is referring
> > to a file-posix driver rather than using a different protocol or being a
> > filter driver above yet another node. It also doesn't consider backing
> > files and other non-primary children of the opened node.
> >
> > So this is not correct, and I don't think there is any realistic way of
> > making it correct with this approach.
> 
> The existence of "filename" already makes this assumption that the
> input is a file child.

No. Try using something like "blkdebug::image.iso" or "nbd://localhost".

In the former case, you get another layer and the "file" child would be
a blkdebug node. To turn off locking on the file-posix block driver
you'd need to set "file.file.locking" in this case.

And the latter doesn't have any file-posix involved, it goes straight to
the NBD block driver.

> While I agree with you that there are better ways to solve this
> problem, ultimately "blockdev-change-medium" will have to be
> deprecated when this hypothetical "better" way of referencing a node
> added with blockdev-add is introduced.

This is not a hypothetical better way. It is how you can achieve this
today.

Extending blockdev-change-medium to alternatively accept a node-name
would just introduce a convenience shortcut (as is the whole command)
that doesn't require you to send four QMP commands (blockdev-open-tray,
blockdev-remove-medium, blockdev-insert-medium and blockdev-close-tray).

There is no need to deprecate blockdev-change-medium with a filename any
more than there is a need to deprecate -hda on the command line. We
could do it because there are alternatives that provide a strict
superset of functionality, but we don't have to.

Kevin


