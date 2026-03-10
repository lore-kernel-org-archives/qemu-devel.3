Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91065FD4F16
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01VO-0005Tt-35; Tue, 10 Mar 2026 14:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w01VI-0005T2-F4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:08:26 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w01VG-00030X-44
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:08:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E4E65BCF6;
 Tue, 10 Mar 2026 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773166098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ko7l95wt6cDByTsyJBvxSN266v6WsHSfE35zflJN3yw=;
 b=BAF15NrSjt6R9wxd29I0YrxyJsmfWr99nSpY8o4KBpaIyjwl/1ZHs667NGVQjrzbmI877k
 wOCAKjvH31Z9z3/+KsbifpeCOMTI9NvSIdCF254RfgTntaREYUslUMatPo46g7DpFrI2a3
 Ko4Q3fYZP09QN2XtkDqRohMqsNSE/o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773166098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ko7l95wt6cDByTsyJBvxSN266v6WsHSfE35zflJN3yw=;
 b=pLPHMA57oGarbJjYzw1G+15jx/PoPICekHi9ayZofA+E6UYUlSGafw0VWx5P9dR8m0FHRA
 Xh5XJZQm1nYkfPAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BAF15NrS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pLPHMA57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773166098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ko7l95wt6cDByTsyJBvxSN266v6WsHSfE35zflJN3yw=;
 b=BAF15NrSjt6R9wxd29I0YrxyJsmfWr99nSpY8o4KBpaIyjwl/1ZHs667NGVQjrzbmI877k
 wOCAKjvH31Z9z3/+KsbifpeCOMTI9NvSIdCF254RfgTntaREYUslUMatPo46g7DpFrI2a3
 Ko4Q3fYZP09QN2XtkDqRohMqsNSE/o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773166098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ko7l95wt6cDByTsyJBvxSN266v6WsHSfE35zflJN3yw=;
 b=pLPHMA57oGarbJjYzw1G+15jx/PoPICekHi9ayZofA+E6UYUlSGafw0VWx5P9dR8m0FHRA
 Xh5XJZQm1nYkfPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5B273F5B0;
 Tue, 10 Mar 2026 18:08:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WccSGxFesGnefAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 18:08:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Nia Alarie <nia@netbsd.org>, Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH] meson.build: Bump the minimum GCC version to v10.4
In-Reply-To: <20260310155331.320066-1-thuth@redhat.com>
References: <20260310155331.320066-1-thuth@redhat.com>
Date: Tue, 10 Mar 2026 15:08:15 -0300
Message-ID: <8734271rsg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,meson.build:url,gitlab.com:url,repology.org:url,netbsd.org:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, meson.build:url, suse.de:mid,
 suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2E4E65BCF6
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> Our minimum supported version of GCC used to be v7.4 since we still
> wanted to support NetBSD 9.x in the past:
>
>  https://gitlab.com/qemu-project/qemu/-/issues/614
>  https://gitlab.com/qemu-project/qemu/-/commit/3830df5f83b9b52d949676
>
> However, NetBSD 10 has already been released since two years ago
> (see https://www.netbsd.org/releases/formal-10/NetBSD-10.0.html),
> so according to our support policy, starting with QEMU v11.0, we
> don't have to take care of the previous major release of NetBSD
> anymore.
>
> Looking at the various distros that we take care of (see e.g.
> https://repology.org/project/gcc/versions), and the NetBSD 10.0
> 3rd party package information:
>
>  https://cvsweb.netbsd.org/bsdweb.cgi/src/doc/3RDPARTY?rev=1.1905.2.14;content-type=text%2Fplain;only_with_tag=netbsd-10-0-RELEASE
>
> ... it seems like NetBSD 10 has the lowest version of GCC again,
> but at least it's GCC 10.4 now. Thus bump our GCC requirement to
> this version now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index f45885f05a1..6ccca2325a7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -325,7 +325,7 @@ endif
>  
>  foreach lang : all_languages
>    compiler = meson.get_compiler(lang)
> -  if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=7.4')
> +  if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=10.4')
>      # ok
>    elif compiler.get_id() == 'clang' and compiler.compiles('''
>        #ifdef __apple_build_version__
> @@ -341,7 +341,7 @@ foreach lang : all_languages
>    elif compiler.get_id() == 'emscripten'
>      # ok
>    else
> -    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
> +    error('You either need GCC v10.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
>    endif
>  endforeach

Acked-by: Fabiano Rosas <farosas@suse.de>

