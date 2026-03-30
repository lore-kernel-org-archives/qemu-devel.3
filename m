Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E93F1061B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7JMF-0001eJ-Ac; Mon, 30 Mar 2026 16:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7JM9-0001aq-Am
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:37:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7JM2-0005Ee-Px
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:37:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9CFFD596A1D;
 Mon, 30 Mar 2026 22:36:57 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id qd5mw02QE4xV; Mon, 30 Mar 2026 22:36:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 917A8596A2E; Mon, 30 Mar 2026 22:36:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8FD8D596A2C;
 Mon, 30 Mar 2026 22:36:55 +0200 (CEST)
Date: Mon, 30 Mar 2026 22:36:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Fabiano Rosas <farosas@suse.de>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, Thomas Huth <thuth@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] cirrus-vga: Add property to set frame buffer
 endianness and make it default to little endian
In-Reply-To: <87mrzpgucz.fsf@suse.de>
Message-ID: <f171f722-5580-c267-800d-925761ec79e8@eik.bme.hu>
References: <20260330140655.31EC55968DE@zero.eik.bme.hu>
 <87mrzpgucz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 30 Mar 2026, Fabiano Rosas wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>
>> I've tried this but it does not seem to work and leaves default to
>> auto. Could somebody tell how this should work?
>>
>
> This patch sets the hw_compat to "off" so when new code migrates to/from
> an old machine type, it will set the endianness to LE due to the
> conditional you added.
>
>  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2
>  s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0
>
> overriding works:
>
>  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2 -global cirrus-vga.x-big-endian-fb=on
>  s->big_endian_fb: 1 --> s->vga.big_endian_fb: 1
>
>  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2 -global cirrus-vga.x-big-endian-fb=off
>  s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0
>
> The default value is a separate thing, this patch sets it to "auto" so
> unless the hw_compat or the user overrides it, that's what you get.
>
>  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus
>  s->big_endian_fb: 0
>  (s->vga.big_endian_fb: 0, unchanged)
>
>  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -global cirrus-vga.x-big-endian-fb=on
>  s->big_endian_fb: 1 --> s->vga.big_endian_fb: 1
>
>  ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -global cirrus-vga.x-big-endian-fb=off
>  s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0
>
> Maybe what you want is to say the old behavior is auto? Then set the
> default to off.

Indeed. I was confused about what the compat property should set. Thanks, 
send a corrected patch.

>>      DEFINE_PROP_BOOL("global-vmstate", struct ISACirrusVGAState,
>>                       cirrus_vga.vga.global_vmstate, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct PCICirrusVGAState,
>
> s/PCICirrusVGAState/ISACirrusVGAState/

but missed this so will send a v2.

Regards,
BALATON Zoltan

