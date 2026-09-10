Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE33C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4llR-0001iH-Gu; Thu, 10 Sep 2026 16:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x4l1j-0006fR-EZ; Thu, 10 Sep 2026 16:06:08 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x4l1S-0004gC-Vb; Thu, 10 Sep 2026 16:05:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE00321EB2;
 Thu, 10 Sep 2026 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789070640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=af4+pug7jZrQ4eJQasgXRuxDAbUDR/tumtPiVNiRvRk=;
 b=PLynM9jIYTtkk3UYKIEcWs7bjhrrTzg0wlunAfXhSmaumgqtAO0KVNsmeWxDJVc04XkOYY
 4SNA3YBWDnGrggDax6zj9XetgrwEMns2mbgV7zMA42Vg/SrM1wGpkLPc57RvEMWLRIzZtv
 jmPLzyyEFe7XXOfkQVJcPzeuq6wYXBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789070640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=af4+pug7jZrQ4eJQasgXRuxDAbUDR/tumtPiVNiRvRk=;
 b=RtDq2yiZ6Jq7IClThxQyP5Sw8sPTMyPVqQUmGZvn6vyLRFDa9HHxb4Jcw96ZUCJVtqqzKt
 iLgMw3ZeIU0J3XBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=srN2GjWr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Z4/dac2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789070635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=af4+pug7jZrQ4eJQasgXRuxDAbUDR/tumtPiVNiRvRk=;
 b=srN2GjWr2JAo/too763dxndVQsajbdJnUd57oIJHPCu4I/3Bd/VVsPtNoF5fuhUd+Y4Tiw
 45cvObms1fes57EMaeMrk+ARyqAXJJpyAiTJ0yBzE200JMVl/M78BZyBO9z2ITNA7jlIXd
 LSnON/ygXB8keytRjx2JE2bWF4g8I2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789070635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=af4+pug7jZrQ4eJQasgXRuxDAbUDR/tumtPiVNiRvRk=;
 b=Z4/dac2uGiRUg9XnQjl99wQnJ24jd0p3PGyhbLD2I/0FTJ86y8/oS2OfX3eTgk/kdPSMhR
 J1JBu1Fxtihq4hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2050A1326D;
 Thu, 10 Sep 2026 20:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6raNNyoNo2poKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:03:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, John Snow <jsnow@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Thomas Huth <th.huth+qemu@posteo.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Kyle Evans <kevans@freebsd.org>, Richard
 Henderson <richard.henderson@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 1/9] scripts/meson-buildoptions.sh: update missing options
In-Reply-To: <20260910181504.1010916-2-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-2-alex.bennee@linaro.org>
Date: Thu, 10 Sep 2026 17:03:44 -0300
Message-ID: <87jyosub4v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CE00321EB2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TAGGED_RCPT(0.00)[qemu]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[21]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email,suse.de:dkim,suse.de:mid,gitlab.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This should have been updated when the meson check-tcg changes where
> made. Include it now.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

There's this previous change by Daniel doing this already:

https://lore.kernel.org/r/20260908074016.2143292-1-berrange@redhat.com

> ---
>  scripts/meson-buildoptions.sh | 142 ++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 5a67e59a167..67c5e33b011 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -10,7 +10,13 @@ meson_options_help() {
>    printf "%s\n" '  --block-drv-rw-whitelist=3DVALUE'
>    printf "%s\n" '                           set block driver read-write =
whitelist (by default'
>    printf "%s\n" '                           affects only QEMU, not tools=
 like qemu-img)'
> +  printf "%s\n" '  --container-command=3DVALUE'
> +  printf "%s\n" '                           command to build/run contain=
ers'
> +  printf "%s\n" '  --container-registry=3DVALUE'
> +  printf "%s\n" '                           container registry to cache =
from'
> +  printf "%s\n" '                           [registry.gitlab.com/qemu-pr=
oject/qemu]'
>    printf "%s\n" '  --datadir=3DVALUE          Data file directory [share=
]'
> +  printf "%s\n" '  --disable-containers     use containers to cross comp=
ile tcg tests'
>    printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better p=
erformance)'
>    printf "%s\n" '  --disable-debug-info     Enable debug symbols and oth=
er information'
>    printf "%s\n" '  --disable-hexagon-idef-parser'
> @@ -77,6 +83,94 @@ meson_options_help() {
>    printf "%s\n" '  --rtsig-map=3DVALUE        default value of QEMU_RTSI=
G_MAP [NULL]'
>    printf "%s\n" '  --smbd=3DVALUE             Path to smbd for slirp net=
working'
>    printf "%s\n" '  --sysconfdir=3DVALUE       Sysconf data directory [et=
c]'
> +  printf "%s\n" '  --tcg-tests-cross-cc-aarch64=3DVALUE'
> +  printf "%s\n" '                           cc for aarch64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-aarch64-be=3DVALUE'
> +  printf "%s\n" '                           cc for aarch64_be tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-alpha=3DVALUE'
> +  printf "%s\n" '                           cc for alpha tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-arm=3DVALUE'
> +  printf "%s\n" '                           cc for arm tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-hexagon=3DVALUE'
> +  printf "%s\n" '                           cc for hexagon tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-hppa=3DVALUE'
> +  printf "%s\n" '                           cc for hppa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-i386=3DVALUE'
> +  printf "%s\n" '                           cc for i386 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-loongarch64=3DVALUE'
> +  printf "%s\n" '                           cc for loongarch64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-m68k=3DVALUE'
> +  printf "%s\n" '                           cc for m68k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-mips=3DVALUE'
> +  printf "%s\n" '                           cc for mips tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-mips64=3DVALUE'
> +  printf "%s\n" '                           cc for mips64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-mips64el=3DVALUE'
> +  printf "%s\n" '                           cc for mips64el tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-or1k=3DVALUE'
> +  printf "%s\n" '                           cc for or1k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-ppc64=3DVALUE'
> +  printf "%s\n" '                           cc for ppc64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-ppc64le=3DVALUE'
> +  printf "%s\n" '                           cc for ppc64le tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-riscv64=3DVALUE'
> +  printf "%s\n" '                           cc for riscv64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-s390x=3DVALUE'
> +  printf "%s\n" '                           cc for s390x tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-sh4=3DVALUE'
> +  printf "%s\n" '                           cc for sh4 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-tricore=3DVALUE'
> +  printf "%s\n" '                           cc for tricore tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-x86-64=3DVALUE'
> +  printf "%s\n" '                           cc for x86_64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-xtensa=3DVALUE'
> +  printf "%s\n" '                           cc for xtensa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cc-xtensaeb=3DVALUE'
> +  printf "%s\n" '                           cc for xtensaeb tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64=3DVALUE'
> +  printf "%s\n" '                           cflags for aarch64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-aarch64-be=3DVALUE'
> +  printf "%s\n" '                           cflags for aarch64_be tcg te=
sts'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-alpha=3DVALUE'
> +  printf "%s\n" '                           cflags for alpha tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-arm=3DVALUE'
> +  printf "%s\n" '                           cflags for arm tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-hexagon=3DVALUE'
> +  printf "%s\n" '                           cflags for hexagon tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-hppa=3DVALUE'
> +  printf "%s\n" '                           cflags for hppa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-i386=3DVALUE'
> +  printf "%s\n" '                           cflags for i386 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-loongarch64=3DVALUE'
> +  printf "%s\n" '                           cflags for loongarch64 tcg t=
ests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-m68k=3DVALUE'
> +  printf "%s\n" '                           cflags for m68k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips=3DVALUE'
> +  printf "%s\n" '                           cflags for mips tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips64=3DVALUE'
> +  printf "%s\n" '                           cflags for mips64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-mips64el=3DVALUE'
> +  printf "%s\n" '                           cflags for mips64el tcg test=
s'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-or1k=3DVALUE'
> +  printf "%s\n" '                           cflags for or1k tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64=3DVALUE'
> +  printf "%s\n" '                           cflags for ppc64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-ppc64le=3DVALUE'
> +  printf "%s\n" '                           cflags for ppc64le tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-riscv64=3DVALUE'
> +  printf "%s\n" '                           cflags for riscv64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-s390x=3DVALUE'
> +  printf "%s\n" '                           cflags for s390x tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-sh4=3DVALUE'
> +  printf "%s\n" '                           cflags for sh4 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-tricore=3DVALUE'
> +  printf "%s\n" '                           cflags for tricore tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-x86-64=3DVALUE'
> +  printf "%s\n" '                           cflags for x86_64 tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-xtensa=3DVALUE'
> +  printf "%s\n" '                           cflags for xtensa tcg tests'
> +  printf "%s\n" '  --tcg-tests-cross-cflags-xtensaeb=3DVALUE'
> +  printf "%s\n" '                           cflags for xtensaeb tcg test=
s'
>    printf "%s\n" '  --tls-priority=3DVALUE     Default TLS protocol/ciphe=
r priority string'
>    printf "%s\n" '                           [NORMAL]'
>    printf "%s\n" '  --with-coroutine=3DCHOICE  coroutine backend to use (=
choices:'
> @@ -281,6 +375,10 @@ _meson_option_parse() {
>      --disable-cocoa) printf "%s" -Dcocoa=3Ddisabled ;;
>      --enable-colo-proxy) printf "%s" -Dcolo_proxy=3Denabled ;;
>      --disable-colo-proxy) printf "%s" -Dcolo_proxy=3Ddisabled ;;
> +    --container-command=3D*) quote_sh "-Dcontainer_command=3D$2" ;;
> +    --container-registry=3D*) quote_sh "-Dcontainer_registry=3D$2" ;;
> +    --enable-containers) printf "%s" -Dcontainers=3Dtrue ;;
> +    --disable-containers) printf "%s" -Dcontainers=3Dfalse ;;
>      --enable-coreaudio) printf "%s" -Dcoreaudio=3Denabled ;;
>      --disable-coreaudio) printf "%s" -Dcoreaudio=3Ddisabled ;;
>      --with-coroutine=3D*) quote_sh "-Dcoroutine_backend=3D$2" ;;
> @@ -517,6 +615,50 @@ _meson_option_parse() {
>      --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
>      --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dtrue ;;
>      --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=3Dfalse ;;
> +    --tcg-tests-cross-cc-aarch64=3D*) quote_sh "-Dtcg_tests_cross_cc_aar=
ch64=3D$2" ;;
> +    --tcg-tests-cross-cc-aarch64-be=3D*) quote_sh "-Dtcg_tests_cross_cc_=
aarch64_be=3D$2" ;;
> +    --tcg-tests-cross-cc-alpha=3D*) quote_sh "-Dtcg_tests_cross_cc_alpha=
=3D$2" ;;
> +    --tcg-tests-cross-cc-arm=3D*) quote_sh "-Dtcg_tests_cross_cc_arm=3D$=
2" ;;
> +    --tcg-tests-cross-cc-hexagon=3D*) quote_sh "-Dtcg_tests_cross_cc_hex=
agon=3D$2" ;;
> +    --tcg-tests-cross-cc-hppa=3D*) quote_sh "-Dtcg_tests_cross_cc_hppa=
=3D$2" ;;
> +    --tcg-tests-cross-cc-i386=3D*) quote_sh "-Dtcg_tests_cross_cc_i386=
=3D$2" ;;
> +    --tcg-tests-cross-cc-loongarch64=3D*) quote_sh "-Dtcg_tests_cross_cc=
_loongarch64=3D$2" ;;
> +    --tcg-tests-cross-cc-m68k=3D*) quote_sh "-Dtcg_tests_cross_cc_m68k=
=3D$2" ;;
> +    --tcg-tests-cross-cc-mips=3D*) quote_sh "-Dtcg_tests_cross_cc_mips=
=3D$2" ;;
> +    --tcg-tests-cross-cc-mips64=3D*) quote_sh "-Dtcg_tests_cross_cc_mips=
64=3D$2" ;;
> +    --tcg-tests-cross-cc-mips64el=3D*) quote_sh "-Dtcg_tests_cross_cc_mi=
ps64el=3D$2" ;;
> +    --tcg-tests-cross-cc-or1k=3D*) quote_sh "-Dtcg_tests_cross_cc_or1k=
=3D$2" ;;
> +    --tcg-tests-cross-cc-ppc64=3D*) quote_sh "-Dtcg_tests_cross_cc_ppc64=
=3D$2" ;;
> +    --tcg-tests-cross-cc-ppc64le=3D*) quote_sh "-Dtcg_tests_cross_cc_ppc=
64le=3D$2" ;;
> +    --tcg-tests-cross-cc-riscv64=3D*) quote_sh "-Dtcg_tests_cross_cc_ris=
cv64=3D$2" ;;
> +    --tcg-tests-cross-cc-s390x=3D*) quote_sh "-Dtcg_tests_cross_cc_s390x=
=3D$2" ;;
> +    --tcg-tests-cross-cc-sh4=3D*) quote_sh "-Dtcg_tests_cross_cc_sh4=3D$=
2" ;;
> +    --tcg-tests-cross-cc-tricore=3D*) quote_sh "-Dtcg_tests_cross_cc_tri=
core=3D$2" ;;
> +    --tcg-tests-cross-cc-x86-64=3D*) quote_sh "-Dtcg_tests_cross_cc_x86_=
64=3D$2" ;;
> +    --tcg-tests-cross-cc-xtensa=3D*) quote_sh "-Dtcg_tests_cross_cc_xten=
sa=3D$2" ;;
> +    --tcg-tests-cross-cc-xtensaeb=3D*) quote_sh "-Dtcg_tests_cross_cc_xt=
ensaeb=3D$2" ;;
> +    --tcg-tests-cross-cflags-aarch64=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_aarch64=3D$2" ;;
> +    --tcg-tests-cross-cflags-aarch64-be=3D*) quote_sh "-Dtcg_tests_cross=
_cflags_aarch64_be=3D$2" ;;
> +    --tcg-tests-cross-cflags-alpha=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_alpha=3D$2" ;;
> +    --tcg-tests-cross-cflags-arm=3D*) quote_sh "-Dtcg_tests_cross_cflags=
_arm=3D$2" ;;
> +    --tcg-tests-cross-cflags-hexagon=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_hexagon=3D$2" ;;
> +    --tcg-tests-cross-cflags-hppa=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_hppa=3D$2" ;;
> +    --tcg-tests-cross-cflags-i386=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_i386=3D$2" ;;
> +    --tcg-tests-cross-cflags-loongarch64=3D*) quote_sh "-Dtcg_tests_cros=
s_cflags_loongarch64=3D$2" ;;
> +    --tcg-tests-cross-cflags-m68k=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_m68k=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_mips=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips64=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_mips64=3D$2" ;;
> +    --tcg-tests-cross-cflags-mips64el=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_mips64el=3D$2" ;;
> +    --tcg-tests-cross-cflags-or1k=3D*) quote_sh "-Dtcg_tests_cross_cflag=
s_or1k=3D$2" ;;
> +    --tcg-tests-cross-cflags-ppc64=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_ppc64=3D$2" ;;
> +    --tcg-tests-cross-cflags-ppc64le=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_ppc64le=3D$2" ;;
> +    --tcg-tests-cross-cflags-riscv64=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_riscv64=3D$2" ;;
> +    --tcg-tests-cross-cflags-s390x=3D*) quote_sh "-Dtcg_tests_cross_cfla=
gs_s390x=3D$2" ;;
> +    --tcg-tests-cross-cflags-sh4=3D*) quote_sh "-Dtcg_tests_cross_cflags=
_sh4=3D$2" ;;
> +    --tcg-tests-cross-cflags-tricore=3D*) quote_sh "-Dtcg_tests_cross_cf=
lags_tricore=3D$2" ;;
> +    --tcg-tests-cross-cflags-x86-64=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_x86_64=3D$2" ;;
> +    --tcg-tests-cross-cflags-xtensa=3D*) quote_sh "-Dtcg_tests_cross_cfl=
ags_xtensa=3D$2" ;;
> +    --tcg-tests-cross-cflags-xtensaeb=3D*) quote_sh "-Dtcg_tests_cross_c=
flags_xtensaeb=3D$2" ;;
>      --tls-priority=3D*) quote_sh "-Dtls_priority=3D$2" ;;
>      --enable-tools) printf "%s" -Dtools=3Denabled ;;
>      --disable-tools) printf "%s" -Dtools=3Ddisabled ;;

