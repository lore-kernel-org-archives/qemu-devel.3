Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D96C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbSZ-0003n9-LH; Tue, 05 Mar 2024 15:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhbSV-0003n0-Tk
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:32:21 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhbSS-0007eF-3E
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:32:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D136D20B87;
 Tue,  5 Mar 2024 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709670734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbbzrxeBj1mnwJM1QrxlTNkaGun0bTzks9YzZ4HvDe8=;
 b=Iwrlp0jpKeJWitBBNM+OlgJAdim0P4+8+1kbQd67UvduvN2Viv2rVpdxEUptOV3u67aOQ8
 2wQhqDXa/YNwjaIh7PrGhaZQ9Y7z7U6ZuxIPd2pjLZUiKVYZGpZ7Hwa3L8l5P8fTynCY85
 wFZgxCAMZUoh/aaiTuK6zQvZWrX/2lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709670734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbbzrxeBj1mnwJM1QrxlTNkaGun0bTzks9YzZ4HvDe8=;
 b=Sl9y3qeoxtVid0M86+gJOAOqxSzr9Cj4NXI5Ek+B/6BTmuOMI2tpuyRuPE1ynvGpiR5j1a
 8aSb/k7L2s7cDcAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709670732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbbzrxeBj1mnwJM1QrxlTNkaGun0bTzks9YzZ4HvDe8=;
 b=UFxiUVONQv2oLp1ccgU4duFOO+8ySEq6S0O1uxwroIL0tRNDhBPaITdw6r6IFiSzyLsMrR
 XchxhQygt0RvK6J1o/rcuJ2+MbYMW7qES7G4z+mGusFbVpZf8rDoJl+MuXPDVVWVNIcp+l
 jeoTzGv5nMtDYQznPa4A12hGOX9Pyw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709670732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbbzrxeBj1mnwJM1QrxlTNkaGun0bTzks9YzZ4HvDe8=;
 b=2ak7vpmodfPIU/uFu81SojMk3yyu15Be8yzZ021El5GJury1qPzPqGNRtenawsNA3OW2sU
 mIRj5i6daRQdemBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56E96139D0;
 Tue,  5 Mar 2024 20:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q8XeB0yB52V8PwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Mar 2024 20:32:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v4 3/8] configure: add --enable-qpl build option
In-Reply-To: <20240304140028.1590649-4-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
 <20240304140028.1590649-4-yuan1.liu@intel.com>
Date: Tue, 05 Mar 2024 17:32:09 -0300
Message-ID: <874jdkifna.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UFxiUVON;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2ak7vpmo
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.github.io:url,suse.de:dkim,meson.build:url,repology.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D136D20B87
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Yuan Liu <yuan1.liu@intel.com> writes:

> add --enable-qpl and --disable-qpl options to enable and disable
> the QPL compression method for multifd migration.
>
> the Query Processing Library (QPL) is an open-source library
> that supports data compression and decompression features.
>
> The QPL compression is based on the deflate compression algorithm
> and use Intel In-Memory Analytics Accelerator(IAA) hardware for
> compression and decompression acceleration.
>
> Please refer to the following for more information about QPL
> https://intel.github.io/qpl/documentation/introduction_docs/introduction.html
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  meson.build                   | 18 ++++++++++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  3 files changed, 23 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index c1dc83e4c0..2dea1e6834 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1197,6 +1197,22 @@ if not get_option('zstd').auto() or have_block
>                      required: get_option('zstd'),
>                      method: 'pkg-config')
>  endif
> +qpl = not_found
> +if not get_option('qpl').auto()
> +  libqpl = cc.find_library('qpl', required: false)
> +  if not libqpl.found()
> +    error('libqpl not found, please install it from ' +
> +    'https://intel.github.io/qpl/documentation/get_started_docs/installation.html')
> +  endif
> +  libaccel = cc.find_library('accel-config', required: false)
> +  if not libaccel.found()
> +    error('libaccel-config not found, please install it from ' +
> +    'https://github.com/intel/idxd-config')

accel-config seems to be packaged by many distros, I'm not sure we need
to reference the repository here.

https://repology.org/project/accel-config/versions

> +  endif
> +  qpl = declare_dependency(dependencies: [libqpl, libaccel,
> +        cc.find_library('dl', required: get_option('qpl'))],
> +        link_args: ['-lstdc++'])
> +endif
>  virgl = not_found
>  
>  have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
> @@ -2298,6 +2314,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
>  config_host_data.set('CONFIG_STATX', has_statx)
>  config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
>  config_host_data.set('CONFIG_ZSTD', zstd.found())
> +config_host_data.set('CONFIG_QPL', qpl.found())
>  config_host_data.set('CONFIG_FUSE', fuse.found())
>  config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
>  config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
> @@ -4438,6 +4455,7 @@ summary_info += {'snappy support':    snappy}
>  summary_info += {'bzip2 support':     libbzip2}
>  summary_info += {'lzfse support':     liblzfse}
>  summary_info += {'zstd support':      zstd}
> +summary_info += {'Query Processing Library support': qpl}
>  summary_info += {'NUMA host support': numa}
>  summary_info += {'capstone':          capstone}
>  summary_info += {'libpmem support':   libpmem}
> diff --git a/meson_options.txt b/meson_options.txt
> index 0a99a059ec..06cd675572 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -259,6 +259,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
>         description: 'xkbcommon support')
>  option('zstd', type : 'feature', value : 'auto',
>         description: 'zstd compression support')
> +option('qpl', type : 'feature', value : 'auto',
> +       description: 'Query Processing Library support')
>  option('fuse', type: 'feature', value: 'auto',
>         description: 'FUSE block device export')
>  option('fuse_lseek', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 680fa3f581..784f74fde9 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -222,6 +222,7 @@ meson_options_help() {
>    printf "%s\n" '                  Xen PCI passthrough support'
>    printf "%s\n" '  xkbcommon       xkbcommon support'
>    printf "%s\n" '  zstd            zstd compression support'
> +  printf "%s\n" '  qpl             Query Processing Library support'
>  }
>  _meson_option_parse() {
>    case $1 in
> @@ -562,6 +563,8 @@ _meson_option_parse() {
>      --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
>      --enable-zstd) printf "%s" -Dzstd=enabled ;;
>      --disable-zstd) printf "%s" -Dzstd=disabled ;;
> +    --enable-qpl) printf "%s" -Dqpl=enabled ;;
> +    --disable-qpl) printf "%s" -Dqpl=disabled ;;
>      *) return 1 ;;
>    esac
>  }

