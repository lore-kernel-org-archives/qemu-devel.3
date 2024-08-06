Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EC8C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 19:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbPl8-0005zv-7E; Tue, 06 Aug 2024 15:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sbPl6-0005zR-T8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:22:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sbPl4-00059e-Pl
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:22:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 942B91FB68;
 Tue,  6 Aug 2024 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722972128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jopCgNtyJBbEFPi7gYIBt2VxywPmASrlTkcSCUwaZV8=;
 b=osVqAtSODw0aszc5z9GyXmESLfl4anMS2PrODDzneO+aGZwbVKj600G5TSmvQFM3AbgiSY
 4FG2oyh0+3RuX6v3KAFwekA6GFdE9tEGLO5MqpmYhKHFva3hRdwhFDMSP79gCHERU6Iyss
 nbui48o0L3k0aoXbu6kDQ0/eL9rxQqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722972128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jopCgNtyJBbEFPi7gYIBt2VxywPmASrlTkcSCUwaZV8=;
 b=J2HpWz0UaiiKohO3BVq1ton+apvgiKtxLVK6Zo90d3BdK8S410a4pOJzE0BVUFKJRu3sxp
 wariRM70Zi8cYHDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722972128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jopCgNtyJBbEFPi7gYIBt2VxywPmASrlTkcSCUwaZV8=;
 b=osVqAtSODw0aszc5z9GyXmESLfl4anMS2PrODDzneO+aGZwbVKj600G5TSmvQFM3AbgiSY
 4FG2oyh0+3RuX6v3KAFwekA6GFdE9tEGLO5MqpmYhKHFva3hRdwhFDMSP79gCHERU6Iyss
 nbui48o0L3k0aoXbu6kDQ0/eL9rxQqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722972128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jopCgNtyJBbEFPi7gYIBt2VxywPmASrlTkcSCUwaZV8=;
 b=J2HpWz0UaiiKohO3BVq1ton+apvgiKtxLVK6Zo90d3BdK8S410a4pOJzE0BVUFKJRu3sxp
 wariRM70Zi8cYHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FF8113929;
 Tue,  6 Aug 2024 19:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iFvaNd93smaILgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Aug 2024 19:22:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH 2/2] tests/migration: Introduce multifd compression into
 guestperf
In-Reply-To: <8af3ae48cd4c3116b9f0f478bd5cf6df64198d66.1722957352.git.yong.huang@smartx.com>
References: <cover.1722957352.git.yong.huang@smartx.com>
 <8af3ae48cd4c3116b9f0f478bd5cf6df64198d66.1722957352.git.yong.huang@smartx.com>
Date: Tue, 06 Aug 2024 16:22:05 -0300
Message-ID: <875xsdh2xu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> Guestperf tool does not cover the multifd compression option
> currently, it is worth supporting so that developers can
> analysis the migration performance with different
> compression algorithms.
>
> Multifd support 4 compression algorithms currently:
> zlib, zstd, qpl, uadk
>
> To request that multifd with the specified compression
> algorithm such as zlib:
> $ ./tests/migration/guestperf.py \
>     --multifd --multifd-channels 4 --multifd-compression zlib \
>     --output output.json

Aren't you hitting this bug?

/init (00001): INFO: 1722970659523ms copied 1 GB in 00382ms                                                                                                                                    
/init (00001): INFO: 1722970659896ms copied 1 GB in 00372ms                                                                                                                                    
/init (00001): INFO: 1722970660279ms copied 1 GB in 00382ms                                                                                                                                    
qemu-system-x86_64: multifd_send_pages: channel 0 has already quit!                                                                                                                            
qemu-system-x86_64: Unable to write to socket: Broken pipe                                                                                                                                     
                                                                                                                                                                                               
qemu-system-x86_64: check_section_footer: Read section footer failed: -5                       
qemu-system-x86_64: load of migration failed: Invalid argument

>
> To run the entire standardized set of multifd compression
> comparisons, with unix migration:
> $ ./tests/migration/guestperf-batch.py \
>     --dst-host localhost --transport unix \
>     --filter compr-multifd-compression* --output outputdir
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  tests/migration/guestperf/comparison.py | 13 +++++++++++++
>  tests/migration/guestperf/engine.py     | 12 ++++++++++++
>  tests/migration/guestperf/scenario.py   |  7 +++++--
>  tests/migration/guestperf/shell.py      |  3 +++

While here, if you'd like to move the whole guestperf into
scripts/migration and make initrd-stress.img built by default I'd
appreciate it.

>  4 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestperf/comparison.py
> index 40e9d2eb1d..71208e8540 100644
> --- a/tests/migration/guestperf/comparison.py
> +++ b/tests/migration/guestperf/comparison.py
> @@ -158,4 +158,17 @@ def __init__(self, name, scenarios):
>          Scenario("compr-dirty-limit-50MB",
>                   dirty_limit=True, vcpu_dirty_limit=50),
>      ]),
> +
> +    # Looking at effect of multifd with
> +    # different compression algorithm

s/algorithm/algorithms/

> +    Comparison("compr-multifd-compression", scenarios = [
> +        Scenario("compr-multifd-compression-zlib",
> +                 multifd=True, multifd_channels=4, multifd_compression="zlib"),
> +        Scenario("compr-multifd-compression-zstd",
> +                 multifd=True, multifd_channels=4, multifd_compression="zstd"),
> +        Scenario("compr-multifd-compression-qpl",
> +                 multifd=True, multifd_channels=4, multifd_compression="qpl"),
> +        Scenario("compr-multifd-compression-uadk",
> +                 multifd=True, multifd_channels=4, multifd_compression="uadk"),
> +    ]),
>  ]
> diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
> index 608d7270f6..883a7b8ab6 100644
> --- a/tests/migration/guestperf/engine.py
> +++ b/tests/migration/guestperf/engine.py
> @@ -31,6 +31,8 @@
>                               '..', '..', '..', 'python'))
>  from qemu.machine import QEMUMachine
>  
> +# multifd supported compressoin algorithms

compression

> +MULTIFD_CMP_ALGS = ("zlib", "zstd", "qpl", "uadk")
>  
>  class Engine(object):
>  
> @@ -205,6 +207,16 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
>              resp = dst.cmd("migrate-set-parameters",
>                             multifd_channels=scenario._multifd_channels)
>  
> +            if scenario._multifd_compression:
> +                if scenario._multifd_compression not in MULTIFD_CMP_ALGS:
> +                    raise Exception("unsupported multifd compression "
> +                                    "algorithm: %s" %
> +                                    scenario._multifd_compression)
> +                resp = src.command("migrate-set-parameters",
> +                    multifd_compression=scenario._multifd_compression)
> +                resp = dst.command("migrate-set-parameters",
> +                    multifd_compression=scenario._multifd_compression)

Should these be src.cmd() and dst.cmd()?

> +
>          if scenario._dirty_limit:
>              if not hardware._dirty_ring_size:
>                  raise Exception("dirty ring size must be configured when "
> diff --git a/tests/migration/guestperf/scenario.py b/tests/migration/guestperf/scenario.py
> index 154c4f5d5f..4be7fafebf 100644
> --- a/tests/migration/guestperf/scenario.py
> +++ b/tests/migration/guestperf/scenario.py
> @@ -30,7 +30,7 @@ def __init__(self, name,
>                   auto_converge=False, auto_converge_step=10,
>                   compression_mt=False, compression_mt_threads=1,
>                   compression_xbzrle=False, compression_xbzrle_cache=10,
> -                 multifd=False, multifd_channels=2,
> +                 multifd=False, multifd_channels=2, multifd_compression="",
>                   dirty_limit=False, x_vcpu_dirty_limit_period=500,
>                   vcpu_dirty_limit=1):
>  
> @@ -61,6 +61,7 @@ def __init__(self, name,
>  
>          self._multifd = multifd
>          self._multifd_channels = multifd_channels
> +        self._multifd_compression = multifd_compression
>  
>          self._dirty_limit = dirty_limit
>          self._x_vcpu_dirty_limit_period = x_vcpu_dirty_limit_period
> @@ -85,6 +86,7 @@ def serialize(self):
>              "compression_xbzrle_cache": self._compression_xbzrle_cache,
>              "multifd": self._multifd,
>              "multifd_channels": self._multifd_channels,
> +            "multifd_compression": self._multifd_compression,
>              "dirty_limit": self._dirty_limit,
>              "x_vcpu_dirty_limit_period": self._x_vcpu_dirty_limit_period,
>              "vcpu_dirty_limit": self._vcpu_dirty_limit,
> @@ -109,4 +111,5 @@ def deserialize(cls, data):
>              data["compression_xbzrle"],
>              data["compression_xbzrle_cache"],
>              data["multifd"],
> -            data["multifd_channels"])
> +            data["multifd_channels"],
> +            data["multifd_compression"])
> diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
> index c85d89efec..1452eb8a33 100644
> --- a/tests/migration/guestperf/shell.py
> +++ b/tests/migration/guestperf/shell.py
> @@ -130,6 +130,8 @@ def __init__(self):
>                              action="store_true")
>          parser.add_argument("--multifd-channels", dest="multifd_channels",
>                              default=2, type=int)
> +        parser.add_argument("--multifd-compression", dest="multifd_compression",
> +                            default="")
>  
>          parser.add_argument("--dirty-limit", dest="dirty_limit", default=False,
>                              action="store_true")
> @@ -166,6 +168,7 @@ def get_scenario(self, args):
>  
>                          multifd=args.multifd,
>                          multifd_channels=args.multifd_channels,
> +                        multifd_compression=args.multifd_compression,
>  
>                          dirty_limit=args.dirty_limit,
>                          x_vcpu_dirty_limit_period=\

