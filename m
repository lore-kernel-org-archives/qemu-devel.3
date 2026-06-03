Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BAECD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUmPD-0000ml-K5; Wed, 03 Jun 2026 10:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wUmOw-0000kc-VV
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wUmOt-0007qO-AS
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780496211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Htrbo5enuhB/8G/0pFFkTRXqMsQqeS1aNcYcOf+cnHw=;
 b=E9j5Q0gZBAosCS/fY3SyRc4EfjB2DmGBB6xrThY3Uu5BEwikpULEErkgmTrX0g+JMCGgVo
 UhwAbNy08LwH+iO6vv+izEFUM3SQojTQ1c3AihmAvFB0fPNyv1gmMUDIE0qnkbBbFwRqdp
 XeirWE4bOopFhlac5DxNZQxB5Gjyv9o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-p2aqCXRGPAyWpUjpP4NhlQ-1; Wed, 03 Jun 2026 10:16:48 -0400
X-MC-Unique: p2aqCXRGPAyWpUjpP4NhlQ-1
X-Mimecast-MFC-AGG-ID: p2aqCXRGPAyWpUjpP4NhlQ_1780496207
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a2f1d1e5so2478353a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780496207; cv=none;
 d=google.com; s=arc-20240605;
 b=HeaN55UTANAd/JACoQo9Vs2yMyWAYQFZlqxWcf9jYlzJpN0Awmt18BmoNOv9thcqyo
 n9Uw1bXSz6CuXPDsm9ad9DUsxiM7muscu5luq/NTPWK9Stui9VJjncuEfy8neusKPnRE
 6HE85p5Cyhzlb4zfbiPtfx29cJ7l0Jc8wxaetbu1Iwjf+VIkhPoMB4Ei93XpLXW+Hx4x
 5Hj5c1JAkjAKdQ1iYwiYbMH282TQ8EAkqeczXOmBkVus8i367OUlDX+ZUw/iRIqlMpiw
 /2Y3VKhz1kU4XS9dl7miuhrJBu1wP+nZU+7ZX62COt58Em3UKMyr58zeXoXz1uvQGaxS
 wLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Htrbo5enuhB/8G/0pFFkTRXqMsQqeS1aNcYcOf+cnHw=;
 fh=mIOXeRzeGdvQtOcnNRF1rDF60F8mPf4CHSUieHC9aE4=;
 b=UfEfRGq5tr2GGgtSMf+L2BnqmgvP6/IkpoQsSySiY4oz0ukK1dDxfqrdklRs/9+Yzp
 dwqdIHLHspre9C61iJYbJw/rgUV5cJaqWkc4kBcyW17Iv2y/b3Nfv6c/xx/pdjQBkVLZ
 1oddAhTxivXkzsCAzCK4cok+Ams9YC/E8d1jcLdwb7rqwI54d28QuZJGHycGz4gpHvvW
 CfrcY4szm9IKa4tPvsMoTuxz5bp1dl2HJ8qYBQ+PKBQCr1O3FE5FRaylcDCD9wtPlYeH
 Y9Datr/2Pn5x/XC1igOQQFFx+v7rNKoo0JgycpeHAo/jxc876RdQTXzdzaYwDVZLu3Ti
 tCNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780496207; x=1781101007; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Htrbo5enuhB/8G/0pFFkTRXqMsQqeS1aNcYcOf+cnHw=;
 b=AeBCTJVta0+J6MHX63XAwrV+RxZHyE+wnspH5hcfyMWU6hJXmOZPpk+EZm1QGl7vZ2
 yV4hTiqt0vuELKK6ppu5j92iBCxo/+tZo+3X8nkBSX/NGssNnvtL/g7Hn1+kb4+lsAtT
 +g6X/nalZJW8wdS587PIhwZOc9lyWgyNwHYSjfuWEw2Hi0JdBbTe7DraUlL0EeWNa7Da
 Vg1DoPUoOhdRPjmDsHOOECxD7nnInuiOyLD7CLTLDw/WOJ0AY+DpDcgv7vzMd8fvS2QS
 9q+8myAL4UVVxVYAx3KqLflVcb54FCe5FW2y1qpNaWXqALQEXVubzu64VBJaQrDRFW0o
 op+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780496207; x=1781101007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Htrbo5enuhB/8G/0pFFkTRXqMsQqeS1aNcYcOf+cnHw=;
 b=tKhV0fb061JfDHQLnB3yOo2ZWwR1jfVNF4S7Q+6vdAgUUnY7hmd/9sOx2ZLJ+nBYBS
 jDqULeUHBCa+O9gtfAtcXxyYdBbol6n0lcDaRc65cAuBaYlZmt2oQOY0zSTB8feUFZIt
 0UGRy0wurE+wiTZoln52VUrQfrfDYui1vISGQuyV5yvhqUb+LVKDnjI9QSp6B53EEk9H
 w+5+7dbSb4uffZie10OzrZjJauqUyaNnCi3wyhvr0P0DTo76acbEczJIvFvK8MqfxHX2
 upeLw7FeknRQpesDoJffxOPz3n2/xePy1Dg7/Lnl0SN+EzwMyPjtYye/V9kWzzFric5U
 TxiQ==
X-Gm-Message-State: AOJu0YwMsoM8sfWRw4ufEtq+AK9c+SZHr4LBHNyDkMLJ8hP3U0uRpXCT
 Mbw/VQ9GZhQ3K2gq8e6giKjVQeupxwEZdWPCOtv9Arsfv0amb3Q/Tj6oy/kpVbdVg9onatqnXhE
 zc3vdKMGsUibGi2g/QkMHdRT9/jAVX4OCiC5UVDNlTFc0PUbeAh7PYelqctjvTdv2hI050igSNS
 B9V5gqxbWVs3H3rag1y0LN6944fNv9WDU=
X-Gm-Gg: Acq92OHGbtbrtsvGCzHGLWw70+o6/z4BYwZCfWm7iFRiSLM/qjEP3rWzMMK3WI99MlK
 4E2I3U30cDL/K1pEYWH73UQJm0H/gRq3+CBgbdzKClRVPUcyp9qD+wIK182q72T3SB1kEuEBBwB
 yO8yaWWhr+EC8QcR8zzm71PA6wY8t8ZdMx1iuOa+FIbavfLYH3/abFldyErfTBYEqA/x7vNqHrc
 q+FNgYOPTyMKXovFL5IykIZeivGOHGWVga8zF9VZviQQ9qzxwD+ZdRbVORqxJZKTdQrbaSYmXdY
 zKh3w0Dmnjfb1ZbS7154Te2FKKo9H20ppA==
X-Received: by 2002:a05:6a21:46c5:b0:3b4:7bcc:5227 with SMTP id
 adf61e73a8af0-3b4977ff33bmr4157953637.12.1780496207313; 
 Wed, 03 Jun 2026 07:16:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:46c5:b0:3b4:7bcc:5227 with SMTP id
 adf61e73a8af0-3b4977ff33bmr4157915637.12.1780496206793; Wed, 03 Jun 2026
 07:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260603141137.1108963-1-farosas@suse.de>
In-Reply-To: <20260603141137.1108963-1-farosas@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 3 Jun 2026 18:16:35 +0400
X-Gm-Features: AVHnY4JQOQZsXKcSwXWU02XoNkvj9h0kGQBb1fAeAAZxXtWt4sA8kh3QVPDaPxI
Message-ID: <CAMxuvazV+hebpeerp=95K6MnvLuywyzZMnc7TUhZzeYmt7+ZpA@mail.gmail.com>
Subject: Re: [PATCH] chardev: Don't unregister yank upon async path connection
 failure
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 3, 2026 at 6:11=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Commit 5c102ac9 ("chardev: Consolidate yank registration") has moved
> yank registration in the tcp_chr_connect_client_async() path to after
> the connection is successful. If qio_channel_socket_connect_sync()
> fails early, there will be no yank registered to be unregistered in
> the error path, leading to assert.
>
> Remove the now-extraneous unregister.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 5c102ac9 ("chardev: Consolidate yank registration")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3528
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  chardev/char-socket.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index e064b105c5..99e01a4875 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1128,11 +1128,6 @@ static void qemu_chr_socket_connected(QIOTask *tas=
k, void *opaque)
>
>      if (qio_task_propagate_error(task, &err)) {
>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
> -        if (s->registered_yank) {

Is "registered_yank" stalled too? shouldn't be set to false to avoid
that path and possibly others?

> -            yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
> -                                     char_socket_yank_iochannel,
> -                                     QIO_CHANNEL(sioc));
> -        }
>          check_report_connect_error(chr, err);
>          goto cleanup;
>      }
> --
> 2.53.0
>


