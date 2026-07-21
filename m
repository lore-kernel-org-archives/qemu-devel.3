Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED5BC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7Tv-0000Fq-DQ; Tue, 21 Jul 2026 06:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wm7Tr-0000BQ-Jg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:13:43 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wm7Tq-0007yI-4p
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:13:43 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81ed000b507so56631257b3.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784628821; cv=none;
 d=google.com; s=arc-20260327;
 b=gfsxM+IaW40t/2EIE4dgs7/V7UXs844ZKce6sm9PlNpSZasnm928L/B50A0ldUVdIR
 hvPkpNc4mhH7l8+FIEnISNcExw+nJLv4uv4pGB3YXcl9Wb8t6Qs91Cm+G3Bplov6OFtp
 ce85RfBJyH3GIfPeVxBs35k1VwQJu6vwA5aQLocUaquUI8J/YDREDhrkpo7cr1mZlrSi
 F5jjEo4Dnl6HAFCWhSRM0FKQE4jTSJ7k5wxFLIF8VN7PdaHIJCJHGxzuEB5sxwXFSEib
 bd3U7KCtF+IQjP88H/REG7HkVZjZJS0JiraHlmPJp7+rgmfsfoJbz4jvcX1BuePBOazf
 psKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qqYjmG4WWnGOhUvP2s0HwiQhV9Cnji2/zb3hwXU7AJE=;
 fh=t6oU8loY5+4tD9gUMRPpIizcPAlSu/znrRtKpXlGi34=;
 b=fyZYTKW7MwXopPbVYmB9k+jC9t3fubjBOnLk1BA8VkdHGJFlqhsFq5MK30YPg7tri+
 qWX5wJf9iFPJAojcKJn055bpusyPZcZN33G/dv4KRdTAO6ciJQTFlLYbzQUp+AqRn0jZ
 NXmVopGSs/IlpDDag6j3C4N1eF3mfM8sRRWVtn1lTZTq0bxMVYkQ8X6X+iXvL2a/WK+J
 ZJUM/b4f/BHNn1YhMy2fDH0dx/xgSmyIgJINmTtOcJMFIQhV/hKRsjwI+AhRVF+rMhOJ
 dgpZmLVKq0rs8zAIe+alxeDvPfVfvYcYaiakkQ6Kieaots6YOVTeV+FR23V9m16csx0O
 XcKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784628821; x=1785233621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qqYjmG4WWnGOhUvP2s0HwiQhV9Cnji2/zb3hwXU7AJE=;
 b=ooC/BTXGpxDhTf0PDt1o6rmRqM3zzzdy2h/Kp2oxmol+OqjaskuUZAjQixKIczPcLw
 ah5qHeLhloLlNVB48q8MrQdAY7plx3VjMpsd6Erh0zFoJe/H/Gtr14sHG7gbcCpg46tB
 OyVvPPa9lP65v8XhAoM0tc3z7SOyEZQQCyJMqrDcK2UdLUaorCdnBQ5zh0aWxNqB0EyY
 OmMH53/og7wdDXgE1GJua4tJVTPuVstZpEkl4QuEjp4ao7ZYLoGX4v/S5YzClfiOh1zN
 cuh2mnq7956C9sw8318cZWuKCuMnzR+HpIH44kT1JDQhcu3joEL47o3IBv5VHCywXikv
 19mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628821; x=1785233621;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qqYjmG4WWnGOhUvP2s0HwiQhV9Cnji2/zb3hwXU7AJE=;
 b=Y5yNncrg9zBBe6CXU4gLp/5OwyRYjrqj5/Cy/QJnSM3LAArZK5OXgpAsoIsVS7TWQZ
 MQfXXwe/2O+TPogdexmADeQ9leCeUZrg1qAqJPZJCLfWucSZshq1R0LFC8E9b53qb35F
 wkoxPKyJnhgBshj/lifyVM3TCtfC0mXCC6DmaBLTPKo3N3p9SmvwvgTcsJ1FmkB0Jtnl
 4NrfHb23DqfYSIKwUM2cyepP3YYFVyklEPRsrgWCne4K0F2iA3+j8JMWDuCVOvpeqXJw
 oRs9RU1BHH/FsSYRhuzP026MGVkCPl/xcFiTeBYjswQ11vHx+bZx2QQfim0sSAPKlJ0N
 JNng==
X-Gm-Message-State: AOJu0YyC7JWdfI5VzKLbwsUIu5Ft/0a5pV5JcnwU8DM7v/+mnvQUHWj6
 ZIY739tX/gZlHej5VQ8Vz9kEtzlUVdpk8OOdFw/wg37b08bkDOcprRLHYfQR3w5nsCrc5JH+Q4O
 IRXnfSbVRumLHqZuL4ywUZw1dKfCVNCg=
X-Gm-Gg: AR+sD13iOeX1VSJS+Nf2OLWy46f3DFTCudTfOhDOXPOSi0jb/yZdBxX9GHQxXEJlXu7
 Vjr0+iIgHZGTtJk/9f+Ty44SW5ajzAu2IGdd/+yKxGN6F8yZAVhB4Lr/x9EpxDO0QNxWFYxeX46
 MkG9TksRQbmFRLxJauZ6ygu3KsByyj9fWTtjbtAse7wUvLDbOBUOoTS/RTc8REskifjPkEZr7Il
 sDJjr5ZodekFnroYfKW+55QVoNXzAuZu/hJ65rb+mJY441Go9KTHoc5RNHBRkA=
X-Received: by 2002:a05:690c:6308:b0:81e:776b:ba51 with SMTP id
 00721157ae682-81ef260cf30mr54475507b3.58.1784628820889; Tue, 21 Jul 2026
 03:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260629164246.2028947-1-peter.maydell@linaro.org>
In-Reply-To: <20260629164246.2028947-1-peter.maydell@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 21 Jul 2026 18:13:28 +0800
X-Gm-Features: AUfX_mxHn4FJx_4A85k39dwNdy1Wk9WxmxEVzhRDo7pAz8XcqzxV26lvM2LT7xQ
Message-ID: <CAEUhbmWkhLNCpmsjPnazL-tR+oF3jUO709wqs5HzPAwOd9fWhg@mail.gmail.com>
Subject: Re: [PATCH] net: Correct padding check in qemu_receive_packet()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jun 30, 2026 at 12:42=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> In qemu_receive_packet() we check to see if we should pad a short
> packet.  This is doing the wrong test: because this function is used
> when the device adds a packet to its own incoming queue (i.e.  for
> loopback), we should be checking the NetClientState's own do_not_pad
> flag, not that for its peer.
>
> We didn't notice this earlier, because at the moment all the real
> peers of a network device (i.e.  the network backends) do not set
> do_not_pad, so net_peer_needs_padding() always returns true except in
> the corner case where the network device has no peer at all.
>
> The effect of this is that if a network device has no peer (e.g.
> because QEMU was started with -net none or with -nodefaults) then we
> can still let through the kind of "guest misprograms the network
> device to loopback-transmit a short packet and then we mishandle it
> in the receive path" bug like #3043 which commit a01344d9d78 was
> trying to fix.
>
> Since the distinction between "we should check nc->do_not_pad"
> and "we should check nc->peer->do_not_pad" is a bit subtle, add
> enough documentation commentary to make it more obvious.
>
> Cc: qemu-stable@nongnu.org
> Fixes: a01344d9d78 ("net: pad packets to minimum length in qemu_receive_p=
acket()")
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/net/net.h | 23 +++++++++++++++++++++++
>  net/net.c         |  2 +-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

