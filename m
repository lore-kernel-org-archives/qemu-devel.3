Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606AFC44506
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDa1-0000hO-La; Mon, 13 Jul 2026 06:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjDZy-0000gm-9I
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjDZu-0006l2-53
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783937276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzmqswxmBb5euHwr1t3hKHm1YKJaitdYsaG92hlpL18=;
 b=VZEHNMcOaOn+WNkfNhk3S1DRa46Qs3c7AmHdTyYkmGZ0uLGCefZhV0ZbcTR084ITS6cVbS
 zK0KYrc5GrZWznahWN6dzi4TF7C9JisiZz2EHNnHZWxtRl9+K0C1ddh/Z9k0zIgEwQCFBL
 J08ChuxiZyKZ4FCp3QHwfcPZ76tnEb4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-gYKW8HeYMyazJGCsdeBXBA-1; Mon,
 13 Jul 2026 06:07:54 -0400
X-MC-Unique: gYKW8HeYMyazJGCsdeBXBA-1
X-Mimecast-MFC-AGG-ID: gYKW8HeYMyazJGCsdeBXBA_1783937273
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D5C318002C3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:07:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53987180059F; Mon, 13 Jul 2026 10:07:51 +0000 (UTC)
Date: Mon, 13 Jul 2026 11:07:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/vnc: validate SetPixelFormat field ranges
Message-ID: <alS49FlxfpXVgheR@redhat.com>
References: <20260713100056.4104383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713100056.4104383-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13, 2026 at 02:00:56PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The VNC SetPixelFormat message carries red/green/blue_max as 16-bit
> values, but PixelFormat stores them as uint8_t. A client sending a
> max value above 255 (e.g. 0x0100) passes the existing non-zero check
> but silently truncates to 0 on assignment, leading to a division by
> zero in the Tight PNG palette path.
> 
> Similarly, the shift values are read as uint8_t from the wire but
> used in left-shift expressions (red_max << red_shift). Shifts >= 32
> are undefined behavior in C for 32-bit operands.
> 
> Add explicit range checks for both: reject the connection if any
> channel max exceeds UINT8_MAX, or any shift is >= 32.
> 
> Fixes: CVE-2026-15578
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3976
> Reported-by: dong ling
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index dfc8262d42a..c4ee4738b28 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2276,6 +2276,16 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
>          return;
>      }
>  
> +    if (red_max > UINT8_MAX || green_max > UINT8_MAX || blue_max > UINT8_MAX) {
> +        vnc_client_error(vs);
> +        return;
> +    }
> +
> +    if (red_shift >= 32 || green_shift >= 32 || blue_shift >= 32) {
> +        vnc_client_error(vs);
> +        return;
> +    }
> +
>      vs->client_pf.rmax = red_max ? red_max : 0xFF;
>      vs->client_pf.rbits = ctpopl(red_max);
>      vs->client_pf.rshift = red_shift;

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


