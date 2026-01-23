Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02763D72361
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 09:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjDNC-0002uA-Ht; Fri, 23 Jan 2026 04:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjDNA-0002tZ-Sl
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 04:22:32 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjDN9-000386-7n
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 04:22:32 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7942b9663f8so17690927b3.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 01:22:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769160149; cv=none;
 d=google.com; s=arc-20240605;
 b=SlRkqfazLfPUjPGvZiz7Il0LKCyueaIZZcNwgCt7xL7Etkhsmqo6FVmJEfgibysaW/
 iBV3VqiluTh67xnP0pnPwU1lD9Q1wuFQKPZxuZpdZTkC8g3OynaX7nxLM9zXpFDf5vci
 p4/U67E60iw/rsVkX7PhicENFgDmbD4B1k3SEgrDzl+QQEMflUpBsBokoTXgp0umxcMt
 EVX7YBbnLiKujwd6QdHZsiy5Vl9fswbwm9VP+lSmV0Wiaf1lBFz3j0R3dyxC39TFXaWL
 S57dDntulworQTlrrO1pjMhVKQgSMSDQUd1lwL2Drb9cAi46YpB1o4xYKHphbYRcGw87
 tqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V8ceGnHgpO1C/FjA12ozijrniL6c2Pi6QJRV+I2uJaw=;
 fh=383ZtxZtDitUeQ+idcz++KwLrFTe+TOskAazDcA5bxA=;
 b=NhFtM0u66+kjNiJ8s9un43PeNAWKS5kiox1HNcYKoSTQd/tXo6Jh+U1xvHCqXu/cPT
 lwxYYJYfOWMLLgfNSpENioEv7a0fGqxiPqSTrEZCQJCQLWgeli2PEAaH5OrqZESMbH92
 Tr3AEFjj82BwjmK8JzGTuXnnA2ZyZuLwkoIyIOFXPEDcwDAq3jiZdNhWB2b5jqZeGmB6
 awnLNXFxLttNz6ykgBFoK1MzlXelSJloo9KX5d5GFjgGDaQ2WcXOmseUhaxFqSYyyVsz
 941UgHfAlJjp1wmRipBzuzvZJBz/zq27bfvBm28iN+5IW1NGd0q6a1lMSGb3NZGYsaTU
 4MZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769160149; x=1769764949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8ceGnHgpO1C/FjA12ozijrniL6c2Pi6QJRV+I2uJaw=;
 b=G+hin8Rid1k/dzGOxgivVl+G5Ma8ypmoI09IMZgxjijEeIl2OqCwOVaWfOEooEwsUf
 qR2COM4bY+3TPZmiZF2TmFK/HHedZjxLVB7da2OAwzyU6D1pEiYcq2cTK+QLzKX0JKzr
 uL6x7/g2UcJpfk74Mbsa0BA7M51768qVXg+2Ibbn/UVkgBy4VrsQNfR0FfqqMcX0FiYK
 C/9+bpBndxhuWeISE4LH7jWDhufa+6s0mBB8Ys6Wx0p0Trhwh9zyj4UE1GlcvSMwv1pv
 CDri/vcFnL/mfvnw0a489tj7eJuMuwOcznSen+n/AcNRMKlFKjt3+4yC16PzkAbFYKce
 oqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769160149; x=1769764949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V8ceGnHgpO1C/FjA12ozijrniL6c2Pi6QJRV+I2uJaw=;
 b=Ldn/PnSH1MI0qCXtvaGD0KY2mWMU0NBxHpliAxOWvy8muBrBTctEkvPd5g2h5ElAFu
 Bbxc0S0WoWPI+tPXsQ5hCIVs6/haPexmsv57FiTulT+vuDnRnjUI1Z8BueWkEGIXaZX/
 t/RWVs8yht4X6ZoQ9Js51WtLcxMO3id3CJx6rbT6ptFliw7E4JYovVVKyPl3HFc/T+ja
 kQIY9T5qcwzt/1C4Wvo/hSxn+ZtZcBk7KMNFmlSquMbNR52h8JEg7CE/YbJiWYjKphgq
 KPC8bPH/BDWvrx7KrO4NCjisJ5K38182ewO8Jno57zhIEg5YH/z5npVrDD1uzT96WTOF
 yhmw==
X-Gm-Message-State: AOJu0Ywf7ijnAOHQ/Cvxeny8aXNMxwDAgk+Dqa5Zm/7PJtdkTsp4t1/P
 BWrDc+1H4qYEDmxlJmYVxIRTgmrxdEIeoFby2AQ7947yS8NECIEO5tDAEL8cJ3BSku3Z7wvXC3e
 V6PorG97u7Yile+0ob0kdHt7f1N1VQUajWDhNDR9U9A==
X-Gm-Gg: AZuq6aLWkQhExYVJO7+TG5YYpekWfZ1w6GCxeJ6TSLb6CM4KyBFX6fgi6ZExonAOqQh
 mp/MWWPFOCy5KbfGVHH0N2VzUZGuH+wU1Yw5aihGyCtA01hKBQqKyGU/V/5ZgMjiRMlpRLa5ynY
 FPrqaeLvV0SK34bOrfVQqf9JyvTgTzzZ/Sb9uxlJn9yon0giQbPDpk7Pkpfn7PwSsdTvhWn9vcO
 94TYlz6az3myKThkfxhjnZDDYVerWEDgNJQZO/noUTnKjmZQmXFloNg3ZVaRcVt+aoZ8w==
X-Received: by 2002:a05:690c:2613:b0:794:2fed:5369 with SMTP id
 00721157ae682-7943990364fmr21400117b3.24.1769160149219; Fri, 23 Jan 2026
 01:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20260116060315.65723-1-zhenzhong.duan@intel.com>
 <CAFEAcA_LnfF-TqF2yKcPJOK4WHJnbt1RECk9svdRkRrvgRqqSQ@mail.gmail.com>
 <IA3PR11MB913691468156580EB53424129294A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB913691468156580EB53424129294A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jan 2026 09:22:17 +0000
X-Gm-Features: AZwV_QjpgJlB3yPF1S6sQehAMmXmz79RbI-iCRncvUPlF688sFKy3Wr2kFu-d-Y
Message-ID: <CAFEAcA9v8L41Sm22jy+cmOSzVhxD5mKfsCpLvqWpCfKq=5SuBA@mail.gmail.com>
Subject: Re: [PATCH] vfio/migration: Fix page size calculation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 23 Jan 2026 at 03:38, Duan, Zhenzhong <zhenzhong.duan@intel.com> wr=
ote:
>
>
>
> >-----Original Message-----
> >From: Peter Maydell <peter.maydell@linaro.org>
> >Subject: Re: [PATCH] vfio/migration: Fix page size calculation
> >
> >On Fri, 16 Jan 2026 at 06:03, Zhenzhong Duan <zhenzhong.duan@intel.com>
> >wrote:
> >>
> >> Coverity detected an issue of left shifting int by more than 31 bits l=
eading
> >> to undefined behavior.
> >>
> >> In practice bcontainer->dirty_pgsizes always have some common page siz=
es
> >> when dirty tracking is supported.
> >>
> >> Resolves: Coverity CID 1644186
> >> Resolves: Coverity CID 1644187
> >> Resolves: Coverity CID 1644188
> >> Fixes: 46c763311419 ("vfio/migration: Add migration blocker if VM memo=
ry
> >is too large to cause unmap_bitmap failure").
> >> Suggested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>  hw/vfio/migration.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index f857dc25ed..b4695030c7 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -1173,7 +1173,7 @@ static bool
> >vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
> >>       * can also switch to use IOMMUFD backend if there is a need to
> >migrate
> >>       * large VM.
> >>       */
> >> -    page_size =3D 1 << ctz64(bcontainer->dirty_pgsizes);
> >> +    page_size =3D 1ULL << ctz64(bcontainer->dirty_pgsizes);
> >>      max_size =3D bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE *
> >page_size;
> >
> >This doesn't strictly speaking resolve CID 1644186, because
> >what Coverity sees is that ctz64() returns 64 when dirty_pgsizes
> >is zero. That is still UB even with the ULL suffix.
>
> Hmm, maybe, I didn't find easy way to verify it with Coverity test.
> In fact, this code is guarded by below check:
>
>     if (!bcontainer->dirty_pages_supported) {
>         return false;
>     }
>
> If the check pass, we are sure dirty_pgsizes has host page size bit set a=
t least:
>
>     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
>         bcontainer->dirty_pages_supported =3D true;
>         bcontainer->max_dirty_bitmap_size =3D cap_mig->max_dirty_bitmap_s=
ize;
>         bcontainer->dirty_pgsizes =3D cap_mig->pgsize_bitmap;
>     }
>
> >
> >But if we are enforcing somewhere that dirty_pgsizes is
> >never zero, then this is fine and we can mark that Coverity
> >issue as a false-positive.
>
> May I ask how to mark it?
> Maybe Coverity test is smart enough to not report in this case=F0=9F=98=
=8A

It's usually not that clever. I'll mark the relevant issues
as false-positive in the web UI.

Thanks for confirming that there's a "definitely at least
one bit set" check already.

-- PMM

