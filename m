Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC349FD3773
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHh6-0002tJ-J7; Wed, 25 Feb 2026 11:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHh4-0002sV-Jo
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:24:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHh3-0006VT-03
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772036695;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tj7mQ49vF3sZ50kGFP88AfTQhATZIE2QoV8UHgd8ggk=;
 b=R2pIYeBdzv7K2HbDHwLK6gO/rXUwQZzOujHKXPu4TXnVpyYuQG/e603Yfu8mzWYOUmJ+l9
 krdzCCHVz6xWcUFFLHzm93fLNMLRC3ikfjTdqBKI4L0RjHrGwi4bHeyerty9bDYLpfxcuF
 /r6Ej30F26mL8t+VV6PO9+1++1j/uJo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-lrxX5sH3OUqQajUaXQA99A-1; Wed,
 25 Feb 2026 11:24:52 -0500
X-MC-Unique: lrxX5sH3OUqQajUaXQA99A-1
X-Mimecast-MFC-AGG-ID: lrxX5sH3OUqQajUaXQA99A_1772036690
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51F17195609F; Wed, 25 Feb 2026 16:24:50 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E9331800465; Wed, 25 Feb 2026 16:24:44 +0000 (UTC)
Date: Wed, 25 Feb 2026 16:24:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 25/27] util: add support for formatting a program name
 in messages
Message-ID: <aZ8iSclFzGgPEH1t@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-26-berrange@redhat.com>
 <87ikbt3v0y.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikbt3v0y.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 19, 2026 at 11:08:45AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The error_report function can include the program name in any
> > messages it prints. The qemu_log function has no equivalent
> > behaviour.
> >
> > This introduces support for a "program name" in the new
> > messages API, which will be included by default for all
> > binaries.
> >
> > This change tweaks the output of the error_report function,
> > adding a space between the program name and the location
> > info.
> 
> Why?

Looking again, arguably that is fixing a pre-existing bug

The current code is:

    if (!monitor_cur() && g_get_prgname()) {
        error_printf("%s:", g_get_prgname());
        sep = " ";
    }
    switch (cur_loc->kind) {
    case LOC_CMDLINE:
        argp = cur_loc->ptr;
        for (i = 0; i < cur_loc->num; i++) {
            error_printf("%s%s", sep, argp[i]);
            sep = " ";
        }
        error_printf(": ");
        break;
    case LOC_FILE:
        error_printf("%s:", (const char *)cur_loc->ptr);
        if (cur_loc->num) {
            error_printf("%d:", cur_loc->num);
        }
        error_printf(" ");
        break;
    default:
        error_printf("%s", sep);
    }


Notice how we honour "sep" for LOC_CMDLINE but ignore
it for LOC_FILE.

With the program name printing moved out into a separate
function, the space is always printed. No change for
LOC_CMDLINE, but new whitespace for LOC_FILE.

Should have changed this in a separate patch.

> >       The qemu_log function will gain the program name. This
> > can be easily seen with the 'log' trace backend, and how it
> > is now more closely matching error_report output.
> >
> > Before:
> >
> >   # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
> >   qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5584e13937f0 dir=fish
> >   qcrypto_tls_creds_get_path TLS creds path creds=0x5584e13937f0 filename=ca-cert.pem path=<none>
> >   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> >
> > After:
> >
> >   # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
> >   qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5584e13937f0 dir=fish
> >   qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=0x5584e13937f0 filename=ca-cert.pem path=<none>
> >   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> >
> > When adding this the '-msg program-name=on|off' option is
> > introduced, so that the program name (which is enabled by
> > default) can be supressed if desired. This could be useful
> > if '-msg guest-name=on' is being used as a more informative
> > identifier.
> 
> Separate patch?

It is a bit of a borderline decision, but I felt the knob to turn it
off should be in the same patch that force enables it.

> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


