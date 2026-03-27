Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D2A10ED67F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68Tt-0006AT-DP; Fri, 27 Mar 2026 10:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w68Ts-0006AK-FW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:48:12 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w68Tq-0004dQ-Oy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:48:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 584784D3F8;
 Fri, 27 Mar 2026 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774622889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99c8Hf+vQeCpKET0TlzdwOnrQbH/mLtOk/BJpsVdtxQ=;
 b=ShimSI1Rv6P4MFUExY/DN/z8Nv5NM8DfDsTt4hJyOa4vnuthFJTylMpdwADa9ixAtcC23k
 JfCdNH2CM81E1ifRNR8KubRlgFfDOk/vO6J4ks3R65f+ED0mVkP05+/Tfw7a8SR4X3w0xs
 WnzRCI1nEV7N96sR7Aa/NNzGdybszGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774622889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99c8Hf+vQeCpKET0TlzdwOnrQbH/mLtOk/BJpsVdtxQ=;
 b=p6CzIuKcJ3JkyehkT9XteZJPrUx2GAryji0bxCtPy1UpSOiUB/xAt+BY0F041DnzgUOWjD
 zvi0zI2kUzu93xDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774622889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99c8Hf+vQeCpKET0TlzdwOnrQbH/mLtOk/BJpsVdtxQ=;
 b=ShimSI1Rv6P4MFUExY/DN/z8Nv5NM8DfDsTt4hJyOa4vnuthFJTylMpdwADa9ixAtcC23k
 JfCdNH2CM81E1ifRNR8KubRlgFfDOk/vO6J4ks3R65f+ED0mVkP05+/Tfw7a8SR4X3w0xs
 WnzRCI1nEV7N96sR7Aa/NNzGdybszGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774622889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99c8Hf+vQeCpKET0TlzdwOnrQbH/mLtOk/BJpsVdtxQ=;
 b=p6CzIuKcJ3JkyehkT9XteZJPrUx2GAryji0bxCtPy1UpSOiUB/xAt+BY0F041DnzgUOWjD
 zvi0zI2kUzu93xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E682E4A0A2;
 Fri, 27 Mar 2026 14:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VY3jLKiYxmmGZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 14:48:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Xu
 <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] hw/display/cirrus_vga_isa: Disable global_vmstate by
 default for new machines
In-Reply-To: <20260326154850.301609-1-thuth@redhat.com>
References: <20260326154850.301609-1-thuth@redhat.com>
Date: Fri, 27 Mar 2026 11:48:06 -0300
Message-ID: <871ph5ib15.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
> In the long run, we would like to get rid of the code that allows to
> register migration state globally, so set global_vmstate to false when
> using the isa-cirrus-vga device with new machines, and only enable it
> for older machines to avoid breaking the migration there.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/machine.c           | 1 +
>  hw/display/cirrus_vga_isa.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6cf0e2f404e..0aa77a57e95 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@
>  
>  GlobalProperty hw_compat_10_2[] = {
>      { "scsi-block", "migrate-pr", "off" },
> +    { "isa-cirrus-vga", "global-vmstate", "true" },
>  };
>  const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
>  
> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> index bad9ec7599c..76034a88605 100644
> --- a/hw/display/cirrus_vga_isa.c
> +++ b/hw/display/cirrus_vga_isa.c
> @@ -56,7 +56,6 @@ static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
>                     s->vram_size_mb);
>          return;
>      }
> -    s->global_vmstate = true;
>      if (!vga_common_init(s, OBJECT(dev), errp)) {
>          return;
>      }
> @@ -74,6 +73,8 @@ static const Property isa_cirrus_vga_properties[] = {
>                         cirrus_vga.vga.vram_size_mb, 4),
>      DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
>                       cirrus_vga.enable_blitter, true),
> +    DEFINE_PROP_BOOL("global-vmstate", struct ISACirrusVGAState,
> +                     cirrus_vga.vga.global_vmstate, false),
>  };
>  
>  static void isa_cirrus_vga_class_init(ObjectClass *klass, const void *data)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

