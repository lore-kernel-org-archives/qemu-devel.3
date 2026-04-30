Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631EDFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIUB9-00072Z-P4; Thu, 30 Apr 2026 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIUB6-00070R-Lb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIUB4-0004rN-CF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777566227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEviTaK3Ke6cazPo4XGrcbzNSjhf0Vk2W3qAkISgyiU=;
 b=eRPCTJp0VZT7oWRx7ZreJdwL6nqytXKatteWRDnp4pK/CUv9e8f7BI4vGPzBRTG33n4aDU
 LbNvbZ+uA3qRc4olS+vkS6FOmU8i7vm02yqHoRWNqr3eW1A3pSp1teUhTsDDaHIwyuj1Y6
 gcSC0tH2KzyH3zgT1CVoHadXHh0p+bk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-xoCbktVUNPOAp6V6ZYHSmA-1; Thu, 30 Apr 2026 12:23:45 -0400
X-MC-Unique: xoCbktVUNPOAp6V6ZYHSmA-1
X-Mimecast-MFC-AGG-ID: xoCbktVUNPOAp6V6ZYHSmA_1777566223
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7d03e1e7so968011f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777566223; cv=none;
 d=google.com; s=arc-20240605;
 b=dkfDifXMQf3h/yVHsU+xhxeY9FNtic6QZB3kboandxtqYER1fKpD6VX+jwoKLdLGDn
 Vc+xGIUlELs1gew0PckQfHdS48c1Hc/+JOO7dSEvfAFJm2E9cfNz8QxpLNBCFHF+7lL6
 3l/kg9Pkev9XG4prKuU0AZdcAEZYvsqa/ULXQArwkJTYgVPim7Moyh9UpOC3ckRuPu2X
 EtQBhBwCRioNmnz7xGr/u0KwzhCv58JLLP2O6GLdB/4beDdnMkXE1HFqG90lCDDTecdk
 ENGm1deZ9FuaMDQDPuu0/fc2ufd4N3J1Bbge2WsAkmdxkvqXF223WAWY2Zzb4brldCqZ
 FzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mEviTaK3Ke6cazPo4XGrcbzNSjhf0Vk2W3qAkISgyiU=;
 fh=02h3fZJNt9AF6qHPQjSllKpyVIbO7JVcC2hFC0TJD/8=;
 b=MZIJtvh1MFs9CKTOtdbdfon5y1ARAPo77YYAWHBn3whU7pabQYLXbx/Yc+QMonJNdO
 d4mn2+A35u6pWQwpZrTPKjDNi4jsVOk0u0PY8okUFUlTe9pslmQxygM4xJzpNjsLJTHW
 CYYZZooVXVay9gR2o3h3uC8MSCszlpuPqDJoguZsMQskxYQSv6G+F/4sl2vFrPfdTUnk
 KcSBo3Gk1ohkZuXeND+KE41XbHyHRLFNaXNi7SLa6CK77B4UjHRfrJSQiFgzclVUAKB/
 wnWwJlsYXPSNL7KkXvq0m3Rehnfu99BD6AN0pBE9rlhspxS39pk8OXTa8tNZrmuLD78d
 hMkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777566223; x=1778171023; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEviTaK3Ke6cazPo4XGrcbzNSjhf0Vk2W3qAkISgyiU=;
 b=LZrDPH633+qcE2Zecx4ELOPzhbdfMQtmF4bN9Ukqzel2keMZdVsOG9Wa8stE2yqCSd
 5diqL4dhi9qnAasl4XEaGQhx26XqBlupaNX8n0htYST8oYk2Et9cnrw9JD2una6oQdX4
 GCufQV3PKlOxnV+xxLWwv2hXljSyOkAKSUkgbmVbT/A8Rq0Nb/sSjs9wsN48mW+QmfRb
 EY82uNx/iNDRrLuy3rQUyp09JiamGdqcB38mpUTTOQ2aPzum4vAt9Gp5v4RxKFjN7izB
 /njnWaNoS9QWrxhTPVJCmbevr/QEY5i/so7GZQj7QcMDMbr6LYRX6GQgpcRDOB5MVHhu
 ULiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777566223; x=1778171023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mEviTaK3Ke6cazPo4XGrcbzNSjhf0Vk2W3qAkISgyiU=;
 b=KVByhfRAyUMlVmmx8wS9NcedTVDOXyl1jx9wK8/tEEDdPy5x6kbd/hn7jRYn/xdCT7
 WiF7/PXTpGanwRvFC1Wd7t4atPgdx6IOQEwpuK0k+47EkUqn0hIS71cwoWvdzr7wYR49
 DN3JWRW/PlQlmbMEWdtItCAiZini1KtFk+s8ls7dEBvfxJF0vsgM4LwOjMa4QkoMSWuo
 rWmCWjVC4jYngudzzvgdXWlLWaDuXBWp0VvXceuMqWweSJvM3cMrpRH9GZvMqfrcr71r
 tV/nvPlCHEFBZjm0rh7JQSkRxYeIun01IDtvzSYNgPBnL452DcLGxkPdhnn+jHFmnYbo
 MsjA==
X-Gm-Message-State: AOJu0YytvcpSAgmt+V+UvvAclpO9naDv9cIA6VUK9WwOZJ7vBWpB4D++
 EekryRQTlthsdaKBUk8YKQZsPfZnBqBE4F39MGPCZST5VVYyZV2Os/3teOBpmmbHvkpwGaeSn5x
 ArN/0tmEBf6GQT8sdidrRtS/z4A8DzXBdr8EUacMcMIYzTl/sZAlpzC21sA9ulfHA8Bp9zdp5SR
 QyJRxNhbmTvqTv9BCwMlDtfaFzFpWLHJpYBVSnA/M=
X-Gm-Gg: AeBDiesKkHr+iYRvYhlQokqhhGSym/7+2efZhnv229df6E7agyKtR9HC4Phq9juP+qR
 HuaXd7NP0YfjPUl+S6zh6gkqY8EC9DBrNdGsvFEksUuQQ+g0ONYXSqA/66gZN3vIL2rxtqE7swf
 X4hG9XEfm8Oq/JifENlkKjvkdakfCsD291B9GeU51TuWrRX8P5yz3J0+P2w5OBiPhMeVRQs9xAY
 wkrdj7lCxHLjEodlWMIE5D4b2Wri70k2I2tPMrNxsks7VnlCgUvC71KfNTsNSy8f+9AgzXZuOnm
 /4ZyR5cpEougac4=
X-Received: by 2002:a05:6000:2f8a:b0:43f:e266:4c9c with SMTP id
 ffacd0b85a97d-4493cb42f8emr6275805f8f.3.1777566222913; 
 Thu, 30 Apr 2026 09:23:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2f8a:b0:43f:e266:4c9c with SMTP id
 ffacd0b85a97d-4493cb42f8emr6275766f8f.3.1777566222432; Thu, 30 Apr 2026
 09:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260430083411.807762-1-pbonzini@redhat.com>
 <ce92e959-1194-441d-a900-44004bf56d4a@oss.qualcomm.com>
In-Reply-To: <ce92e959-1194-441d-a900-44004bf56d4a@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 Apr 2026 18:23:30 +0200
X-Gm-Features: AVHnY4Lh8PFXERWl5LAS3BTsTDQXpp2Gk7qos8_7ItGwLPv3B9kadx9mPRAHdUs
Message-ID: <CABgObfb0okzA7z6PcCoUZ3LQLN0=zQ6HgqGzXE8EVXn7TTghnA@mail.gmail.com>
Subject: Re: [PATCH] pythondeps: require Meson 1.11.x for Rust support
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 30, 2026 at 6:22=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 4/30/2026 1:34 AM, Paolo Bonzini wrote:
> > This fixes plugin and module support, thanks to improved support for
> > passing linker arguments via rustc.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  pythondeps.toml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index d0e86425313..47d4caefa90 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -24,7 +24,7 @@ pycotap =3D { accepted =3D ">=3D1.1.0", installed =3D=
 "1.3.1" }
> >
> >  [meson-rust]
> >  # The install key should match the version in python/wheels/
> > -meson =3D { accepted =3D ">=3D1.10.0", installed =3D "1.11.1", canary =
=3D "meson" }
> > +meson =3D { accepted =3D ">=3D1.11.0", installed =3D "1.11.1", canary =
=3D "meson" }
> >
> >  [docs]
> >  # Please keep the installed versions in sync with docs/requirements.tx=
t
>
> I sent a patch yesterday but not sure why it didn't reach the mailing
> list. It contained the 1.11.0 wheel.
>
> Should you update configure and the wheel file also?

Yes, I have replied to your patch and I've queued it (currently in
CI). I initially thought of making this a separate patch but in the
end I'm going to squash it with yours.

Paolo


