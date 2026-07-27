Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77584C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woH9E-0007g4-RN; Mon, 27 Jul 2026 04:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woH93-0007Uh-8F
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woH90-0007JD-Db
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785142625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crxFD0P0ZXGIhrd1TmHl2rpW636As26zHe98SmFQUmc=;
 b=itpfYgWpkCig/3ccaxr6FGDoVld4cl3jsdKl5t2BBzHSfVUGF/0aET60+lwOkrFhoGR8LX
 866N7znyju3g56FYTbMu4j26so1DFFf1LJfTPm1ppup0ADqEzppiBZswQYHz7kdqDOyBRj
 SDDSvU6m84P34/i6sd/dut/A+BbEDas=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-Pk-VpThcNqe9xDUpAPDNsQ-1; Mon,
 27 Jul 2026 04:57:01 -0400
X-MC-Unique: Pk-VpThcNqe9xDUpAPDNsQ-1
X-Mimecast-MFC-AGG-ID: Pk-VpThcNqe9xDUpAPDNsQ_1785142619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C68651955DAC; Mon, 27 Jul 2026 08:56:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91CBE3000F15; Mon, 27 Jul 2026 08:56:49 +0000 (UTC)
Date: Mon, 27 Jul 2026 09:56:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
Message-ID: <amcdTq2T2y-N1pmO@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
 <20260726165049-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
 <d9c4321c-ed39-4da6-926b-bae4b1491a52@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9c4321c-ed39-4da6-926b-bae4b1491a52@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 27, 2026 at 02:25:39PM +0900, Akihiko Odaki wrote:
> On 2026/07/27 6:07, Marc-André Lureau wrote:
> > Hi
> > 
> > On Mon, Jul 27, 2026 at 12:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-André Lureau wrote:
> > > > When compiled with -Og, gcc produces many false-positives
> > > > gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
> > > 
> > > it hurts if you do it? so don't do it then?
> > 
> > We are not far from getting it working, we can accommodate a bit of
> > code while making it a bit clearer for the reader too.
> > 
> > > 
> > > > We already use auto-var-init=zero, but better be explicit.
> > > 
> > > explicit about false positives?
> > 
> > Explicit initialization
> 
> These are the same concerns I raised in my previous review:
> 
> https://lore.kernel.org/qemu-devel/f919e684-93ed-4eca-8ddc-785e69dd8add@rsg.ci.i.u-tokyo.ac.jp/
> 
> I do not think this patch make the code clearer. They add values that are
> never consumed, which obscures rather than clarifies the data flow. Leaving
> a variable uninitialized until its actual value is assigned makes that flow
> more explicit.

We've seen time & again that human reviewers fail to reliably identify
when variables are initialized vs uninitialized, leading to countless
CVEs over the years.

We want everything initialized to reduce our security risk profile.

We added auto-var-init=zero as a backstop to have implicit initialization
on the basis that zero-init is the right thing to do 95% of the time.

None the less, we should be adding explicit initialization to everywhere
so that we're clear about when we want zero vs non-zero initialization,
plus a few places we explicitly mark & disable initialization for
performance reasons.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


