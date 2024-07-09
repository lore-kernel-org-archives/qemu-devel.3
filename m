Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED9AC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 12:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9no-0004W4-Po; Tue, 09 Jul 2024 08:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sR9nm-0004S1-LI
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sR9nj-0003W1-PJ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720527507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOKMXc8fzw70bOFUonbpwlQ39HIu24e4Qt2EoEul5lc=;
 b=CKrhxLrYmStMnxwgDNa3q2RvCBR0RInURRHgAlHAdJnPkp9TydS0kDO4zMeKpHzI3Ulhe0
 4AHq5UmtTlrn4dm/kCd1TEChRqeaWVNfFQsVsVknRW615Gukgw2XA376i+2VIlt4BCD9au
 hWV6hqdeNfW8qP+1+TBnYryImqCzSfU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-3zwa2izZN3SxelmJ2_X9yg-1; Tue,
 09 Jul 2024 08:18:25 -0400
X-MC-Unique: 3zwa2izZN3SxelmJ2_X9yg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5407E196E09B; Tue,  9 Jul 2024 12:18:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D50B51955F40; Tue,  9 Jul 2024 12:18:18 +0000 (UTC)
Date: Tue, 9 Jul 2024 13:18:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
Message-ID: <Zo0qh51MPlmfFVUP@redhat.com>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
 <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
 <CABgObfa8KQOu6RPs1aqKww8qPeOjHppbH15aBCN+KvaOL=_W9A@mail.gmail.com>
 <CAAjaMXZ+Sx_+4sNFs=zy+bP0d5gbyf_Buh9JS-ixsRCfxsdN4w@mail.gmail.com>
 <CABgObfb3mmxZy_cEeUTbuGCN-3Nqs8x8dkGy7Ehyowd9LNbktg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb3mmxZy_cEeUTbuGCN-3Nqs8x8dkGy7Ehyowd9LNbktg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 09, 2024 at 09:54:43AM +0200, Paolo Bonzini wrote:
> On Tue, Jul 9, 2024 at 9:38 AM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> > Ah, alright. That wasn't obvious because that e-mail was not directed
> > to me nor did it mention my name :)
> 
> Oh, ok. Sorry about that. Generally when I say "we" I include as large
> a part of the community as applicable.
> 
> > I do not want to do that, in any case. I do not think it's the right approach.
> 
> No problem with that (and in fact I agree, as I'd prefer a speedy
> merge and doing the work on the QEMU master branch); however, we need
> to reach an agreement on that and everybody (including Daniel) needs
> to explain the reason for their position.
> 
> Daniel's proposed criteria for merging include:
> - CI integration
> - CI passing for all supported targets (thus lowering the MSRV to 1.63.0)
> - plus any the code changes that were or will be requested during review
> 
> That seems to be a pretty high amount of work, and until it's done
> everyone else is unable to contribute, not even in directions
> orthogonal to the above (cross compilation support, less unsafe code,
> porting more devices).

My thought is that the initial merge focuses only on the build system
integration. So that's basically patches 1 + 2 in this series.

IMHO that is small enough that we should be able to demonstrate that
we detect Rust, run bindgen & compile its result, on all our supported
platforms without an unreasonable amount of effort.

>                         So something has to give: either we decide for
> an early merge, where the code is marked as experimental and disabled
> by default. Personally I think it's fine, the contingency plan is
> simply to "git rm -rf rust/". Or we can keep the above stringent
> requirements for merging, but then I don't see it as a one-person job.

Patch 3, the high level APIs is where I see most of the work and
collaboration being needed, but that doesn't need to be rushed into
the first merge. We would have a "rust" subsystem + maintainer who
would presumably have a staging tree, etc in the normal way we work
and collaborate

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


