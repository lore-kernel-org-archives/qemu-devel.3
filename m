Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E97FD8748
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2V0k-00047L-TZ; Tue, 17 Mar 2026 10:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w2V0j-00047B-9s
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w2V0h-0001dP-Cn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773756181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIvIZTANtu+riDq13dsBOdoNW+ERNVMTKDPk2TiOFts=;
 b=RNIBA4rbF0OKqDUnhhYgFmlFkJAY4BwIBiGiv5bjpfFnvsBcbbzVo/xXD0L27YWN8h8exP
 CUIoxH0I5evmE3V4ViT0Hyx44Yw+1/zeSr80IyCeq9mQKqOdMMi1hfeMENnWkujUDz9wfi
 DKDuBGwD9FmdMa8XrDUjPvg+pc51Orw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-2Rh5k955M5C_zWIo9mSYVg-1; Tue, 17 Mar 2026 10:02:57 -0400
X-MC-Unique: 2Rh5k955M5C_zWIo9mSYVg-1
X-Mimecast-MFC-AGG-ID: 2Rh5k955M5C_zWIo9mSYVg_1773756176
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b059ab124dso25100835ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756176; cv=none;
 d=google.com; s=arc-20240605;
 b=LvFYau0qt8VrBs+4dCcoiWS/xbkoHkr90e978cTUYjjC90zKEZHxp5rME3Ta0fnGZ2
 tOwqZ6IMl4t0n0NGLjWA+D8rCMoMwByGqOeT0Waw8dImVIPfAI55avVXwlXLECEnpMkP
 5wEGhuiYJz4aPvbtZIaT/KQb7zPiwoJjzGgDIZI1N+7gni58S7KKohwDve7vHva9gfRo
 xmQHKxTb7lgjsIouCPFqt8jg42B9kywIg6KftwcZSxf18+R/VzOsy/mL+Ymqw0IGYuHp
 lDIZl4Z54I5dUqeymR3zabPqSjaBn7gOsKoX75IDaVkyAb/cpx6bC3gmmrByEiS1bgND
 IS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uIvIZTANtu+riDq13dsBOdoNW+ERNVMTKDPk2TiOFts=;
 fh=aqe76e6o1psThcCoGkp9aSvIKfmKPA1puBemdj6/k+A=;
 b=ak5CAJq76+bEZD99J2K4McZdoLUrxLhF+ulhabJVbmFB9urJlI58+23/v7KyDnehTQ
 nwBufrJfSj5VwM/XJ+UfEVzj9o+8RNCzi15J+xwuZrJFQxeM4Hc6njX35Uo/2RSPoOy6
 EGrUCh4gJCq6ujuLyPFhaJD8tdze6+pmpAvg0z+vCbECKongkunKD4R/dmepd/uRyPWA
 s4rR0xmHrKUj1T8xRKt4ManaLwE/R1YD8aS82g3a1UfasWuRGurGYsBONqHmxvxjwyLN
 8cWwcKzVHyZyx4doqL82NRvMiO91nxbX0EqmslizYQihUKeNz43IMjiZJvXsSd8gFe0a
 nKBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773756176; x=1774360976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIvIZTANtu+riDq13dsBOdoNW+ERNVMTKDPk2TiOFts=;
 b=QNjwk/LKrw/sqhk/yvM9fXKQXMd76wpZT30LsllC7H2qQc8Dlm6/zSUUWnalr1oONi
 Zx3MButhEsSSQn5sD4cObJBl4mFdZo4d3mRZl7RepqMWpV9Yq4779zzgBqKDYJWLINkw
 kqqBpRJqCkvX7iE52zE8cNDQYq8twJtXpKj77dFdCVqSbL4rhp/EtvbiYeEJe+UsGeZ4
 6Ct6bbEHf4w64+NxI+Vp8DianXELMptHuiTH7S2x3lOmUF627TFp+je/NsNSY8ii8off
 BPYGpPFv6w/HdBjs/Hq8YZf+qz/7J65ars5W2KAi/YYaAfPaqAMsgdo0uvV9etO+PLLB
 yavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756176; x=1774360976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uIvIZTANtu+riDq13dsBOdoNW+ERNVMTKDPk2TiOFts=;
 b=qY6ZGEzuml7a8CT/YJmckQzyYffK4CeDjbo7oNhK/RDBOCPvXkan72KrmQKqi+h6Ud
 EDD04WEtnZ0JGuYNZrFlY4pI2VrXYkxR9921rPqC0AcYT4M6JNfZIAMIhJ6E6GQUGxPK
 mOmihwxYPAf/KYXNg4dX9WmmX8eH9U9WIsyFvzHQUUnsi9effk3qUpeWn/mcrFpfA+ML
 2GuEMCO1aO2JSMz2PXrpJCGVOsuZZ+DCe/YqoFIPIK3h45Ak/hu6oFOD1jcYB2/Mf+2E
 WVY7pGo+nA/k/ZUx3uybGYKpmm5WVFgchzvST7LEcWGLi9rVa6fsdERon4ef3DjRzn1t
 /ZBw==
X-Gm-Message-State: AOJu0YyZu5Z0aCkUmtwCXcdUONyUd+DvSySLWgRvlhHY5mAzis4x8X35
 0582CxkVK0kP7yUel48Q3m33xdh/q1/i4MPat8kKQ+rBG+CEM/3opmx9FwyCkRb3NOXHoyKdbj3
 /MH8FtTPoETyv2FZmEREIt7JQXGMHGmJZdFgzhBOW13yHgwY9Hm2ae3WNGwHL+Rv+qdKQt6wGeg
 VpPPLKsIaV0MxXLOHlFdc9fEPL7ALvqL0=
X-Gm-Gg: ATEYQzyDfW+g0EXMFywg3DMHR436d4g6dPImfGmQmVEkL8lel5g4nBuiC4Lr0HreWqh
 TL4JT9ittFl+fiCxgFZkIQxVGiACyTBL5h9ALpCwHwApW50FeOIqxjE28LQ+yi1V8Rswy7s7oU7
 E82roHIgaaOd80Sj6BMLD4z/DSl9VDK73vDsqQYXiU7syHce3YzLNWTtEE9VITBd8NO8UgvSMax
 iLXPertl8c9lZ7UniCGhpMuCL+gXvE3IWrwdaXXQyqErPnu9HH0ZftGCZw3u3zUJWQY
X-Received: by 2002:a05:6a21:2c11:b0:398:80dd:5705 with SMTP id
 adf61e73a8af0-398eccf385amr15789731637.46.1773756176081; 
 Tue, 17 Mar 2026 07:02:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:2c11:b0:398:80dd:5705 with SMTP id
 adf61e73a8af0-398eccf385amr15789692637.46.1773756175662; Tue, 17 Mar 2026
 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-73-marcandre.lureau@redhat.com>
 <9a0eda08-0474-4283-8060-e8b31193ed59@collabora.com>
In-Reply-To: <9a0eda08-0474-4283-8060-e8b31193ed59@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 18:02:43 +0400
X-Gm-Features: AaiRm53-3rL1E683xjbufj1aKGMX25XfSGHNoVkgBgbZs11LloHzECAn-sXhebI
Message-ID: <CAMxuvazuUAzB7gU1RzAgf12WEQHTiF86Z1R8+dZ8CE7noEvRgQ@mail.gmail.com>
Subject: Re: [PULL v3 72/85] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Dmitry

On Thu, Mar 5, 2026 at 7:55=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> Audio (driver=3Dpipewire,model=3Dvirtio) is broken/distorted on staging t=
ree
> and I bisected it to this patch. Can't see anything obviously wrong in
> the code, any ideas where the problem could be?

I can reproduce this. I'll look into it for rc1 and let you know.
Thanks for the report.


