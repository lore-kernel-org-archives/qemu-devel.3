Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E2DC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53aE-00009N-Eq; Fri, 11 Sep 2026 11:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x53a9-00009B-KN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x53a7-000429-8g
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789142059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqFdjDZDSL4KFrLZvXicREIlIhrSfJCxxjgHKaNpYvg=;
 b=Sv9XnEhAGbPpCAHrFS+IFc3SdPYUfiDqBEzhHvvyImkcFkZOK1GRfJqgVScGdXRNH7TSGY
 WVB1KuUAc1/dZidWLAeGq1F2R2WaMe1TDl2G15ZY6qcw3rq9TFgRBJO0IFEnu3uhMIjY6+
 /JYOYgRJ5hSB4ZbgyHVOK7JgSy7cNyI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-dk6J6WxINLu-Ma5BynTPmg-1; Fri,
 11 Sep 2026 11:54:17 -0400
X-MC-Unique: dk6J6WxINLu-Ma5BynTPmg-1
X-Mimecast-MFC-AGG-ID: dk6J6WxINLu-Ma5BynTPmg_1789142056
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F05818009E2; Fri, 11 Sep 2026 15:54:15 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44965195608F; Fri, 11 Sep 2026 15:54:12 +0000 (UTC)
Date: Fri, 11 Sep 2026 16:54:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Woodhouse <dwmw2@infradead.org>, mark.syms@citrix.com,
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com
Subject: Re: [BUG] hw/xen: features published after InitWait since 240cc11369fc
Message-ID: <aqQkIa-l0MyAoUmt@redhat.com>
References: <30ec634b6072ac23c38a6a05bf3f90de4b383632.camel@infradead.org>
 <c9a719c9a67c9a32ad566a0255d24722e760a622.camel@infradead.org>
 <CAFEAcA9WAARKjyim9HkYWQA9L45L27NNhxvCVw6CkH5d9pgiYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9WAARKjyim9HkYWQA9L45L27NNhxvCVw6CkH5d9pgiYw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 11, 2026 at 03:56:22PM +0100, Peter Maydell wrote:
> On Fri, 11 Sept 2026 at 15:39, David Woodhouse <dwmw2@infradead.org> wrote:
> > I wasn't *actually* setting out to comment on the AI policy today  — in
> > fact I didn't really have a strong opinion on it. I spend enough of my
> > life tilting at windmills *intentionally*; this wasn't meant to be one
> > of them.

snip

> Yes. I view that email as pretty strong data for 'even a policy
> shift which says "we're OK with accepting some kinds of AI
> generated code" should still be pretty strong on "text intended
> for humans to read (docs, commit messages, mailing list posts, etc)
> should be written by humans"'. I think that review commentary on
> Paolo's RFC about a less strict policy tended to be in that direction,
> so I don't think I'm completely out on a limb here.

The latest proposed policy explicitly forbids sending AI text
to people:

  https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg00260.html

[quote]
### No AI-written text must reach maintainers

These rules apply when publishing AI-assisted work to GitLab or the mailing 
list:

- **AI-written cover letters and commit messages are banned**.  These are
  easy to recognize and waste reviewers' time.
- **AI-generated responses to reviewer comments are banned**. This undermines
  the human-to-human interaction fundamental to code review.
- **AI-written issue ("work item") descriptions or comments are banned**. These
  are verbose and waste triagers' time.
[/quote]

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


