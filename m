Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4112FD3776
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIze-0002QJ-1H; Wed, 25 Feb 2026 12:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvIzb-0002Ll-Os
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvIzZ-0005pw-GX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772041688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3qMgzf+tQqFe8yZiPRzwAdBY+Apz6CmXSAO6Y19KbI=;
 b=TWmrL0jEkhLNCVZ3Yg+npnmjBqimu718ROGCcE+85E0rrB7Kf6gJ2VoH6bUKnzw4hX36oh
 XK8CAtKpQaojWsittYcUO7FjM6Cy3TFOuKs0UFoxdRmmzM7IEbiF3CwIBOKxyjJfUEhfO/
 sxzKlyewFgUrCpxz+e/T3bnukliT618=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-i1HDsaAJPBSheshMTt8aVg-1; Wed,
 25 Feb 2026 12:48:04 -0500
X-MC-Unique: i1HDsaAJPBSheshMTt8aVg-1
X-Mimecast-MFC-AGG-ID: i1HDsaAJPBSheshMTt8aVg_1772041683
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B23E1955DB8; Wed, 25 Feb 2026 17:48:02 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B9901955D71; Wed, 25 Feb 2026 17:47:56 +0000 (UTC)
Date: Wed, 25 Feb 2026 17:47:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 25/27] util: add support for formatting a program name
 in messages
Message-ID: <aZ81yMdZjwmh1_8g@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-26-berrange@redhat.com>
 <CAFEAcA-6XMp6B-V2X+=25Q7XKwy5JuOpGj9RNpN+mTNxm71wpQ@mail.gmail.com>
 <aZ8lfQ8fqVAYTLAa@redhat.com>
 <CAFEAcA-AgvQESekxEYr_Y85qPzRQAfWvZwbM-WjemEU+tOmBdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-AgvQESekxEYr_Y85qPzRQAfWvZwbM-WjemEU+tOmBdA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

On Wed, Feb 25, 2026 at 05:43:45PM +0000, Peter Maydell wrote:
> On Wed, 25 Feb 2026 at 16:38, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Feb 19, 2026 at 10:23:36AM +0000, Peter Maydell wrote:
> > > Why do we care about the qemu_log output matching the
> > > error-report output? The logs are expected to be
> > > quite frequent, to only be there if you've explicitly
> > > turned them on, and to be usually directed to a log file.
> >
> > Personally I never use the log-to-file facility. Instead typical use
> > case is relying on the trace points 'log' facility as illustrated in
> > the commit message example to dump to stderr for simple debugging,
> > and having consistent formatting between the logs & errors is useful
> > there.
> 
> Do you not find that the tracepoint output is often just too big
> to be manageable via stderr? (To take a random example, the last
> thing I did with tracepoint logging produced a file 196MB large
> for a not very long run of the guest.)

The things I'm debugging tend to be more focused on interactions
around mgmt (QMP)  changes, rather than guest execution, so the
trace output is pretty manageable, but yeah I can see how you can
easily get huge output.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


