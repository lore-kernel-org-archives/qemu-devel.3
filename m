Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F50C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtJwl-0007wh-4p; Mon, 10 Aug 2026 02:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wtJwi-0007wP-4M
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 02:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wtJwg-0007Et-Ft
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 02:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786345032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMrKbJEmDOeIwA5y7xnPv80Kr/FmW+udgISbTRBD8c8=;
 b=Vkeuv03dUEHgHF1r+aN7/b8U6C/dd5JvzVvhcaSpacYpKLdnCMu5cr3wckrbjJ/URSA0qn
 Or4Eg7XVk4+RLCxhNa6WCzamPCjOCr00Mid6IKOkv+6F+83hk6J8ZTFV7lXfSHX8NkuDLp
 k/ChMwoXda19nZluvI2tXm/gWVHTn5A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-uwIG8g-yPCGQ6TcnwOFymg-1; Mon, 10 Aug 2026 02:57:11 -0400
X-MC-Unique: uwIG8g-yPCGQ6TcnwOFymg-1
X-Mimecast-MFC-AGG-ID: uwIG8g-yPCGQ6TcnwOFymg_1786345030
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47feac2021eso937359f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786345030; x=1786949830; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eMrKbJEmDOeIwA5y7xnPv80Kr/FmW+udgISbTRBD8c8=;
 b=qifqnOlmlVsbb5Hqj241vuUKXYI8cPcHIjXrPjwrh7d1eFhmW2wIwmuSPutB6eMZKJ
 HhZwvKt8xDmxao8JFiSy1rQybIcSb3Wt73r/MMAgwoN12OrWfLjG6ND6ylnZXrn2FwfA
 a1A+lfRaxOuL6azxp+SHLDRmfYgPaV/NvZOUorZizEbOH91ThBIQ9MlogAVAcMu8DrFT
 op78pTivzV5+Wl8MLCZ4LnF7y3UIkWBV1IM/C4Tz8vc1m4Ym6cHSEMWAPiIO4YmOrqn0
 EcLo6WckLYlANxpUIOVUeKPCINBBM3lZ8We9Hk4cmnkJYlmOZv9QU3Z73tLy6SJ0CgIn
 ZsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786345030; x=1786949830;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eMrKbJEmDOeIwA5y7xnPv80Kr/FmW+udgISbTRBD8c8=;
 b=CfNdo8zwOlqw5LoGnWleUh8pD6NDIrrdPGU1OXKpl3NT7Jvji6+MA09vy6vg9Cu9j8
 q3jk+Yn3vLf+fzQHYkVEYk+RktJVSwB60dn5AIGzo4DP8Wr5nxGYg5RrDWK08+vYMSaX
 cMf1XkvSca36sViulYG5dWM5He9c1fgudjD4tPLqx8mnH5nsiY8st7tYd1M+iEZYqru6
 rJO1zYooHl0iVDbHKlM7dYLM0TkzBSggT72/MtH+bPCgMlX+c22UgjvAG4Hvo38zPklC
 2+aD8oJ+uPFFiiNrKgGjGzLCDuXNpb2IdX5IG+SooT9VyhOg8Nd39nRjSnq5CxRHuxxK
 dmgw==
X-Gm-Message-State: AOJu0Yyd1VxHtyjImqR0F26dw5oZd+ogk6u7L6mSx8k0+aug09P90qNT
 5XB2KjICuOVdjfFJz8J+jj3qBBl84sv8xlOlQT1e7pD8XpAGVODPThWEegvSeCSBqBhYedZfgXx
 e7eYm1JLXCkY8aDB48duK+RQr5Tay3W53fICsVBR/TCIIyyZU/wdbvAAgi0Q4yWWNVU6Xo56GSN
 Z3SqRgRZ81BB6nSm+iQoXxy+YGrcG4iCwpug==
X-Gm-Gg: AR+sD13BOBfszvRgMb+JXFSD/mP3rsemmUNfIjRySTdnZYxD+l+nrB3b4szifXZv9NY
 Fqn6j2gWJ37hzGcA5QVYMumSkAOZ/Hqv0+MENmtE5pzj+vWypK2QYdO824jaHHSPG2twiEptV0e
 +i7j7cTHh4AfzE56JmtCTYVug9ISv51kpSB6ynZ0osmr6Gb2lOUwlcIlT4lMMSttYowbLQoL99N
 rP0/eQDNQBQWJ7qbqI6klgoYIGxjgzIXxSp2dyofjwDZdUo8wgc8IaxLcSffClBHdJZc0BQThvY
 s9DCZDySo1Gr8I/QjOJfsM7NMGf2P7BN9Yp2/t9+tl7VJ3aAeJmdFUnHTcRBkpMQ8u1g3Ra2V0f
 qhybhN+zQcQkld3geLc54Dg==
X-Received: by 2002:a5d:68c9:0:b0:474:18d9:8371 with SMTP id
 ffacd0b85a97d-47fec6359c1mr42177350f8f.28.1786345029829; 
 Sun, 09 Aug 2026 23:57:09 -0700 (PDT)
X-Received: by 2002:a5d:68c9:0:b0:474:18d9:8371 with SMTP id
 ffacd0b85a97d-47fec6359c1mr42177285f8f.28.1786345029316; 
 Sun, 09 Aug 2026 23:57:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220a6d9sm35260971f8f.34.2026.08.09.23.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 23:57:08 -0700 (PDT)
Date: Mon, 10 Aug 2026 02:57:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] meson: disable "maybe uninitilized" errors with -Og
Message-ID: <20260810025526-mutt-send-email-mst@kernel.org>
References: <f559b622eb2d1a384b4f30583a8af10531f4b032.1785144729.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f559b622eb2d1a384b4f30583a8af10531f4b032.1785144729.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 27, 2026 at 09:30:54AM -0400, Michael S. Tsirkin wrote:
> GCC's "maybe uninitilized" warnings depend on optimizations
> for code flow analysis, and produce false positive errors
> with -Og. Default build gives us coverage with that,
> so let's just disable with -Og.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

ping, comments on this?

As an alternative, I can see us doing this for everyone
and only adding -Werror=maybe-uninitialized in CI for
known good compiler/flag combos which do not produce
too many false positives.


> ---
>  meson.build | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 164328ded8..a119dae6ac 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -742,6 +742,10 @@ warn_flags = [
>    '-Wno-typedef-redefinition',
>  ]
>  
> +if get_option('optimization') == 'g'
> +  warn_flags += ['-Wno-error=maybe-uninitialized']
> +endif
> +
>  if host_os != 'darwin'
>    tsa_has_cleanup = cc.compiles('''
>      struct __attribute__((capability("mutex"))) mutex {};
> -- 
> MST


