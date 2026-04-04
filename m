Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00378E88D9F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 13:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w91QX-0007Ot-Fs; Sat, 04 Apr 2026 09:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w91QV-0007Og-7u
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 09:52:39 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w91QT-0008Af-RY
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 09:52:39 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c5b3d8eab1so2188141eec.1
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 06:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775310756; cv=none;
 d=google.com; s=arc-20240605;
 b=hFLiYepOqsTPwXzNKPVOBdS6ZIlAHnLEXLW4aMOaT7VpGrvSYAsVkJculGtWxF5PKz
 pf4ncobkBmto3GS0IT/HbMYtz2keQ1Hwz+xLllg3XC3mGk27ObIu0HnPmK+5SnxIHZIF
 ytoFV6QAWu5ndYZno5nxMusWKzzuKaLVNimStvTHmGpiFR+/OPfll1nZKjO9sfmnAvD0
 he+1pMm33KItwyf8Stmllonq6Z9ry3myICGKaoBwxUQ9Ug1gOooKsbd9D8DwyVDGC6fv
 SCGf5cF1na+2Fror2rtWFX9YWtjP8Au5Jd+id2EvBXwz6OQf9/6aKXQPE2Xsx5tdRFRG
 Epvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HVh3K+CzS5DUSjBGSZfVUUpsOiNMgScir2zr3NtEnCU=;
 fh=URsNzYaecmycJlyyPLK2ccIN3A5wmsT17HlyMjpCJCY=;
 b=X+KdsJP9SZb7y7J5oIwH+iMDkKYpcY1QaNUmlHZqGhed3qRSe8h1VYjX/om9TYxU95
 0CXHiJpSdEUUQyxXfBUoBz2uEZzJXg7Yuj/uqHTqluw3uKpWtDvhS+Y7wjup+i7Sr92L
 ONp94QJVNPspOAEJ15PQzzozb8U8Db4botdC/Pz3osvs4z+ga6u8JFbQykYNxLjoLhxQ
 WOazLbXDfXI9EUi3CCzACcYeJUwBuIBjMzfN4TWRV6UvbFrTir9yx20XyKuMW/GXaBoS
 zp6fEOxlXskf39rP8ye4HKq1ieJS4IztCqOBCiOLY8T8ExVgBXCBNeO55bY9vNSYouOE
 sUCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775310756; x=1775915556; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVh3K+CzS5DUSjBGSZfVUUpsOiNMgScir2zr3NtEnCU=;
 b=OnKhdP7n+9D3CYWwncOjiqE8oJpnUc5vJt9Tp4C9q2ZrtujrDG7NPsoEiJWbWlAQKk
 9Y2AG6LZbuzOesJ0dPbJJbC2C+okY6yg3QdV8xH/IIdeIyNAbQW8ZTrwpWuehXjq+a6p
 4gv7VIVXHzR2mv95Nd9Q9nA+JywJDlRaPFjKxrDWQBFQ2S7WsZ/3YGDMErTefwl2xwMZ
 yJHvt+rE8stupt6+FNfYV4YRr1QAW6homSjGxXQeCF3HMkcRilrR5aKqbrYzMFMw3fch
 Xq7SItzjDfILniJZyl9ylRaJujQHAKAzdol7Xv45ogoD6sixsG3pVCIIRkDE/fa/Vd2h
 BK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775310756; x=1775915556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVh3K+CzS5DUSjBGSZfVUUpsOiNMgScir2zr3NtEnCU=;
 b=ScbrlHR2Dr0mD0+5OJojA3BiBuj0Zqm7xLwyVVbwjhvwrWTHaB4F/aO3oWcuZ5TwIV
 IaEcdZgpCeBRa6Ru8nWSSshI8wgIfmG3CHvgTh8Wh2IBDeEGFFYAmKLaWVxG/mRtoTMA
 G5TI7wYMPANqh8jmp8fCa5z+xB0QomxvHmC/jK2+5aGE41RISnyKtzH0rWortt85pbD7
 4cCC8m5yplIjolDLFgdEvZhjC4W7A1clWCamFnjCkhBl83ZJliDgfpvjkRQ6Y6TERJc7
 D7r0OV0O9u+Hbu2QJ9OUaEJRs4t1ZlqYH+5yvKVlTjkBHpWed/k1wEEkND616RjLMR9g
 Uvzg==
X-Gm-Message-State: AOJu0YwJYU2u5szIFGdmC0yUUmgmEdeCxvIPM7DZu3/2VGr+gZSQeMkj
 V107phgLRV9HyCt1ZxyfgOlysBlWBE6/Mcjl5IZyQNh3xHZfjcrD2Jnr49dd2bqiNn4+YSFCMyd
 PIMS6VF4O8t4608VsMNhKj+2dooD3IAw=
X-Gm-Gg: AeBDievlVUPRBxzZxWjAuCU34TsVzRKmjwmDVkBwr9RUBpk04eSOCGXaXrH62c31jCy
 jKqAUhdkcDLWsVuk1+5tGy0cOxgLDPI3/rMTYQlQFtIUdZl6jQX2CE2240u4OCpmtIODec0zuFz
 PMfVIdPa0lrfDYxOweqhewqBt1J0SoRQY9DmYrEEMbXx+ucnrt45nSjmd8fW8ZfQJEDmS9Gnrbs
 v2GKdWeT6V1mzK9LVln7QiMEcYHQNma6wBv/mdvpx8ni2/aouGNR39U10pYCpwuDTRlD/ZEYTRE
 +G8vkFrsnq/cuxCFkLeNvIZhtoI4ezQGGFZ9zBs=
X-Received: by 2002:a05:7300:80d6:b0:2c6:7f49:a876 with SMTP id
 5a478bee46e88-2cbfc85e1d5mr3633704eec.31.1775310755828; Sat, 04 Apr 2026
 06:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260402105150.274595-1-phind.uet@gmail.com>
 <CAJ+F1C+JxRRmaD+GZ_=F=kh3sjjr_f+Us8LQoGVPSn5Ue_MzLg@mail.gmail.com>
 <bce0d2e8-c06d-4158-bee1-476293458f59@gmail.com>
In-Reply-To: <bce0d2e8-c06d-4158-bee1-476293458f59@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 4 Apr 2026 17:52:24 +0400
X-Gm-Features: AQROBzCTYu4PlM7cK0bYbDAAlUNWz7fPfxst1dUTirU_DWMhgaW_eLEDE4BI29I
Message-ID: <CAJ+F1C+kJ_jS1J8e9+ZOc-ENofusJ2kAifGzz1hwg1ob=D=hdQ@mail.gmail.com>
Subject: Re: [PATCH] util/readline: Fix out-of-bounds access in
 readline_insert_char().
To: Phi Nguyen <phind.uet@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1332.google.com
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

Hi

On Sat, Apr 4, 2026 at 11:32=E2=80=AFAM Phi Nguyen <phind.uet@gmail.com> wr=
ote:
>
> On 4/4/2026 2:41 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Why change rs->cmd_buf_index < READLINE_CMD_BUF_SIZE to
> > rs->cmd_buf_index <=3D READLINE_CMD_BUF_SIZE ?
> Hi,
> my patch is actually change from
>      if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)
>
> to
>      if (rs->cmd_buf_index <=3D rs->cmd_buf_size &&
>              rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {
>

Right, my bad. Wouldn't it be a programming error if "cmd_buf_index >
rs->cmd_buf_size" ?

Maybe make this an assert() ?

--=20
Marc-Andr=C3=A9 Lureau

