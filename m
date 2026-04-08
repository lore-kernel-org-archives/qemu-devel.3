Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB7810F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXpG-00014T-Kk; Wed, 08 Apr 2026 14:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAXpE-0000wE-TX; Wed, 08 Apr 2026 14:40:28 -0400
Received: from mail-106105.protonmail.ch ([79.135.106.105])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAPvy-0006iF-FW; Wed, 08 Apr 2026 06:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775643171; x=1775902371;
 bh=ScnenQow2MkMmMhasrVNk7KokEnYmM6v/8TFcWoOZ+s=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=YswR3W+ZVi5xtOVzidWahvFoaetgml1cdiJ/ajJwG+6zmUZ3ZiZZFHnJdLxILU1vD
 BWdBatvSdI14R45PYzWjUC4K+uPJz3vEOutd2bBTsuGtBkn8jLiMid60WSiZEj6/Vz
 VrQWbhfIJMeZYyvnjoepEhwvLBIF1Em7EEy7InedTwYICVpY03adKnvY2aWT4wEf1C
 gdgbhrYOv1WzI43CXMaZfhz0CZ+qc3e+qXzJocQxb+kliHqbx8MI7fFQZIdcQpHwAp
 muop88PTwTduJapjDGx8wEOlpwtboqw32QyMDoVOnTvK/dUtpYHHu6y5/zIQp5iI4L
 y+7Ah1cg2wK2A==
Date: Wed, 08 Apr 2026 10:12:47 +0000
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
From: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/8] tree-wide: use g_clear_handle_id() for GSource cleanup
Message-ID: <KG5w5GqxVW9a-shN-2-FdpRc1PnooGrcw9gbzS6M_4xiRhHj2SP6SRmu2GZqLEAMtS0-aL5tMkyWozvZEeIiUWVOdMjaH7NeIS31ioG9l_w=@matthewpenney.net>
In-Reply-To: <adYUcqM4py9e_Q-B@redhat.com>
References: <20260408010026.4611-1-matt@matthewpenney.net>
 <adYUcqM4py9e_Q-B@redhat.com>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 940cc0ab72e2f7f24ccdf258d0ec3fc98baa8bf9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.105;
 envelope-from=matt@matthewpenney.net; helo=mail-106105.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

Thanks for the quick response.

I can confirm that I authored the commits in the series - the 'QEMU Token' =
user
just corresponds to the project access token I created and used to push my
work.

The redundant branches (e.g. 'b4/g-source-cleanup') were from previous atte=
mpts
to format and send the series properly.

Hopefully this clears up any confusion around authorship.

Best regards,
Matthew


Sent with Proton Mail secure email.

On Wednesday, 8 April 2026 at 09:40, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:

> On Wed, Apr 08, 2026 at 01:01:42AM +0000, Matthew Penney wrote:
> > This series replaces open-coded uses of g_source_remove() with
> > g_clear_handle_id() across the tree.
> >
> > This is a more modern (GLib >=3D 2.56) approach than directly calling
> > g_source_remove().
> >
> > g_clear_handle_id() simplifies cleanup of GSource IDs since it
> > checks the ID is valid, calls the cleanup function and zeros the ID.
> >
> > This reduces boilerplate and avoids open-coded calls to
> > g_source_remove().
> >
> > This series follows an earlier fix that removed a dangling GSource tag
> > and replaced an explicit call to g_source_remove() with
> > g_clear_handle_id().
> >
> > No functional changes.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/commit/34aad589019c8687fb3=
b19ba79d64d97071a7205
>=20
> Looking at your git repo fork, while the commits are creditted under
> your name, all the activity on the repo appears to have done by a bot
> account:
>=20
>   https://gitlab.com/mj-penney/qemu/activity
>=20
> What's the situation here with authorship ?
>=20
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>=20
> 

