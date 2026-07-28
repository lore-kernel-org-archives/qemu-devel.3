Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3075C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wopMz-0001lj-CF; Tue, 28 Jul 2026 17:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wopMy-0001lS-Bf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wopMw-0007xZ-BY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785274184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxDVdIsxN8IKGNvSivF0AG9skCApqvHzO/0VPP4Sr8I=;
 b=dibEKljjHraTHRxILJv5yf/M+wYTsOREEU87KU+PPVV0TnbTKAOkyCxflzvnWp0iT3JC+e
 h2P6L7MXscZfyEFOoytMYoDhzgWGSiSu/+Tkdc4p96AeamHuPsmMOp9gmXmf5m0BxYPkHk
 owhTr9tSMr2sq03wWYhenFych2gF+n0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-UJ-kJYPPNiiBixuxkQ5ctA-1; Tue, 28 Jul 2026 17:29:43 -0400
X-MC-Unique: UJ-kJYPPNiiBixuxkQ5ctA-1
X-Mimecast-MFC-AGG-ID: UJ-kJYPPNiiBixuxkQ5ctA_1785274183
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efad04d884so5394576d6.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785274183; x=1785878983; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OxDVdIsxN8IKGNvSivF0AG9skCApqvHzO/0VPP4Sr8I=;
 b=o9acmI+MtM+Os4SfqUzMUPlbi19k3U2lbY24wHcz2OX8TwH3uZ6yResaDkS5JPUztW
 bh+8oVIpBl214nz2b3lnt8WtSQrYDeh0mbZJXq5QdSa20yCZf2fDUXUKOHWPl/3q3Tfi
 d30PjAO1rvSA7BuOz9V/ZFXZemqx4WIS0GHipxRJqR+emqdSR7VqwRtpp2BR5CgLUMBW
 3EkxHzqQOXwKVFoDcG/KqIlRZVZED7Mq++k5vkBdmmi8pFbWA+TIsAiHf+jW0YxwLKM8
 QK4hHWmmOIRRV8vEL0MdLLt2HnfMVhm4lqAVVf7cnVosgmftTuozCmelpEUuo8WWRHOQ
 6xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274183; x=1785878983;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OxDVdIsxN8IKGNvSivF0AG9skCApqvHzO/0VPP4Sr8I=;
 b=ntyexwEC9OS3kY6jZv989owPL6lbscbppPL7lo2ps+SFYE4FnBZtk8Xji90NFWzny6
 H/Q/FfZgMSWLYs8QPP0OULnjxNtojVuyneWQjf1jzmjzhRP4bosTm/oiinGFbs8SlNRn
 1XRcZCTuOsI4/RAnDTzfC3/0tyan/+BX79cRH9LBM/zgNz2q0ZW3i59jwo/eDI62CaYz
 0nkY+K5BhovDMl3ISvC00GB/Cqrpih91EpV4q7XJs2Pt7P2VmnSgsrNJgpJoy3GyFdHp
 f0zmRQEgDYsxrLUm6ALAGvNmZ1yN8hxQhNmfxlB6FYqkOevhcv3qigBFv5n4sUuCtbT8
 kVVA==
X-Gm-Message-State: AOJu0Yy72xf32qbAoxOwDjhkutEkDp3KWCM9VoZwOfKUm+fUUyQsr4qc
 CUddW6k/yJ+SlskAGcZC6Hzs6Qk69c4H3RPjrDLiBltKwqOwPa/HOueCFp5UNSSpVYlWHxD+6h5
 7/E9TYX5JyU3BhE10TrC5IsysibGovgRc9oi+mJ7Pc+hVJxlYD6qLiNahtgstAjFtnUxxJLS66S
 3INipXhTCV463NQ6dlqbevKE3VXKcmaDRZhjP/Jg==
X-Gm-Gg: AR+sD12wpZK2sUviGr6P+AIYijPOXxTIxpICFMPvxG16SQHRivoj6yUY/LH8LhKJeUm
 AT052MraxyU/Rdg7bdvAmTdyObjsUfd2f2mFLyGmP7PgvW+hpdJy+MpTMRn9GAbMuxWJoMkJTSE
 dcp9qcxdNTyHOEYItL0KynOKE1118/sQgTcZbEjo+QGFFPyokSCgMN7a/zP2IdEp4+xU4qT9UW2
 G/o3Sgm3wKVBltS1HUps0hwj1OCOGaTBZgxvRoTLG7TcuZR0LofJJ/iNqKhveOf/NoUp7Uf6Fml
 fTRizKMdbxwVKu+MZW362pWPgkl7kzsLZV9HDuUD0XBtm+rrwFOMvyWK+YaBMpw8HdC7J4Gy2zH
 XMEGi+mZjiNVjiLdvZAP/TuMDWlS0uM7Uf5ntlwvjKDOHhz8xiZ7abmhP1CM=
X-Received: by 2002:a05:6214:54ca:b0:8fd:6dc5:94c with SMTP id
 6a1803df08f44-90817429239mr47724196d6.65.1785274182725; 
 Tue, 28 Jul 2026 14:29:42 -0700 (PDT)
X-Received: by 2002:a05:6214:54ca:b0:8fd:6dc5:94c with SMTP id
 6a1803df08f44-90817429239mr47723796d6.65.1785274182143; 
 Tue, 28 Jul 2026 14:29:42 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dd3b56esm8685996d6.26.2026.07.28.14.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:29:41 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:29:35 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v2 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amkfP-dtwmxzg_TC@x1.local>
References: <20260728210417.1925078-1-peterx@redhat.com>
 <20260728210417.1925078-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728210417.1925078-5-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Jul 28, 2026 at 05:04:16PM -0400, Peter Xu wrote:
> In an unlikely case, when a migration stream is attached to the destination
> QEMU and only send <4 bytes to the channel as magic, it's possible that
> migration_channel_read_peek() may spin forever.
> 
> Fix it by adding a manual sleep for partial read.
> 
> Since the path isn't attached to a coroutine, it means when partial read
> happens, there's yet not much we can do but hang the main thread, it will
> happen even for len==0 case.  It means monitors can hang due to this,
> either partial read or no data arrived (but connection established).
> 
> Leave this for later, the hope is this is extremely rare in production.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> Reported-by: Feifan Qian <bea1e@proton.me>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 1e2935f926..f446561b59 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -296,9 +296,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
>  
>          if (len == buflen) {
>              break;
> +        } else if (len == 0) {

I think this should be QIO_CHANNEL_ERR_BLOCK, not 0..  I'll fix it when I
post v3, and I'll do some more tests.

> +            qio_channel_wait_cond(ioc, G_IO_IN);
> +        } else {
> +            /*
> +             * When partially ready, we can't use qio_channel_wait_cond()
> +             * because it will return immediately.  Apply a manual wait.
> +             */
> +            assert(!qemu_in_coroutine());
> +            g_usleep(1000);
>          }
> -
> -        qio_channel_wait_cond(ioc, G_IO_IN);
>      }
>  
>      return 0;
> -- 
> 2.54.0
> 

-- 
Peter Xu


