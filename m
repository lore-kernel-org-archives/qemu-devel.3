Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EABCD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ552-0006HX-V3; Mon, 15 Jun 2026 07:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ551-0006H2-Du
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:02:11 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ54z-0006hk-SZ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:02:11 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7e8833c99fcso32971967b3.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781521328; cv=none;
 d=google.com; s=arc-20240605;
 b=g3iz4fBvpxzgZeJso+4d0LaCi9CYEt4omVENgpdlz1YKhloiy+ouxhIO2SOOJ+ZoVu
 4ElxgOEv77cw0bYNmOHA6RP3jnDrs2BLFsT+pYlHBT9UgkrxKmm+MBF9m0lV1rqyG6zb
 fbGY5zq8UEJswASrUVpd/7HP/tPIM9O/5Bh5l6P287r7hVNDscp6GCum23ihp6M2O6Lx
 /GqJQJ73mZrm8YpXpXtZoz1myhhOpq5loZ/mY8phpboW0jnIj3x/1YK0QRobehXGnhdJ
 cL7JMT3OJeXkRQ75+tq35LCLVwuI+wblef9cK5qNAd1Zg10uXUl4+m7IXHDX0xut+UxP
 B/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jNfQreTErrv2hEpql/5UQFkOkdcHpUgBEKbRJ+ec8rc=;
 fh=0rHSq3ueJB9m76HtRwk2RJEWDps4JZB4/EJOcuFp00U=;
 b=hgsMMRA0HXB7HqqdhDRHd8nIYRsMfNvroLiJFQ0CVGjrO5M2bEg8M5+AuSEI+5qM08
 EBgk6/rLvCU4j0WwF6qYHqYTv89B0YjpKhjcKcdIth4AND+s8M0D6z3woQ5xMol76MTj
 O7MHl+/o0cn2r2n2e6SVRyHFEOYv+3MIn63fsJBfMZWzJfueGTaKy6xZ/nAsVLqxk+Y/
 sWAbfO/OngV4cCil2CbBBVE6ipsmuzjEvLHklcpLEcSIw7sWIxb8kL0Ti+/5nkLeyhr1
 dLfPcd2S7FT49XUf7mO7nmII13AcGcnH7tnf72HRD1OMiMmYCdpqzbLP92kfI4sXbtT0
 Vcug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781521328; x=1782126128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNfQreTErrv2hEpql/5UQFkOkdcHpUgBEKbRJ+ec8rc=;
 b=CNVHqE+OgP6OOSpVoueszODsVOpNFe/PQqRtPdkpiZ1BDUFofbmYyk3Yp+L6/KK/G1
 t7Z1dHT67kt78Eu7KsaplaeoaEjfSq4HmVhDMaobM7Y/I9v7K4JHBB2au8cQT9wsANWA
 SL05DA1krCJPO6t0Xc42Wur9FjqIMhyJM6IgmJjbciIvTvtBrNf77hLeiG0Ryl8Lh55y
 ihSaKj1BaBfT470D+skkA3XUefTO3mqvUjuJY3tC6z2CsmQjwnKwui1SaOf10w8CHy2s
 35a5GtKFIEfmFf0/YcUNNP1BmNmnmCOTuKWD8k8bCyXrBL+sK2N46Nz2xqP3gofhhjnN
 5FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781521328; x=1782126128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jNfQreTErrv2hEpql/5UQFkOkdcHpUgBEKbRJ+ec8rc=;
 b=l271N62I/IQDZSKEcUlMytle60RIg6x8jgCONXqduI3sKT/dXvGWU8Yh1HK/xi3OkV
 vmxcgdjpeE+Balulj3BcM2ljlZiTzmUm0LaLIetR2MxSJccZTFffn6LhtNKF8NGmZaSK
 iGK1QNQPZdp542+d03dbsYfa2BoppFCT8+hEjqyL4PaGHx4svrh3IPWpnwxVyNIEgr+6
 +MqVvPecOdcHRqeKjkBsNTg4ghgYVGFyQSEaNXRtfWl3imk/xVHEGQ87fisHiYfuv9VJ
 bk8uAW/wLi37zRvIiYer9BeTa3cvCroZovKiJwZmieZSDCn0ztyfjsWdLUCIAgmaiX6V
 u3UA==
X-Gm-Message-State: AOJu0Yz5JMxI0YE6QSHWKwAf1UOej+7JMi8+pdbPc24luHqD2cEfmRBA
 1uUapo4evu+dp0XJOoYxhPThMvxc8Ca4kO5c5aBQf4XCmgIv148rMSd+56I3nmZ1nVj7RW0lhYi
 6XpsTRL6U39WNh6uWsLmDYDVESMGSHLKTN1dReUHAgA==
X-Gm-Gg: Acq92OH7+u6SMR9oiPCb4L0b6ExP9RdvrA8cfSnmMf8XFqyZ71A3ttSAm07FQg/sgBx
 Se+1WMdUGqW6RpwaAyOr7kr5ZsJDIg2eeqJPSgIdd22SBOnIigcbYvAX5lp6Yo79sQGaex32fBm
 9sW0VszWZ7IZFbzzJOaN4Ui4ABxTZ9X948nuhSGEHgfN7vqxkgkhakbuzhoRvBvlPaHrkLw6U01
 QFTMkGq8NXzdvUhkh/hJtY7wz251GLEaSROCPq6YAh7XJdzySo0RIH4XanWmakTMVbqFJ7I10wI
 MgVf1UyAngqsFiQCgakF0eqiQL1gUW8zVx8Asgs49b0WD0FEDQFsHKwBFEvpqvgOqYo=
X-Received: by 2002:a05:690e:1c20:b0:660:5df1:f23f with SMTP id
 956f58d0204a3-6627834a0dfmr11152146d50.57.1781521328563; Mon, 15 Jun 2026
 04:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <20260529082948.363931-8-alex.bennee@linaro.org>
 <CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
 <878q8gjcms.fsf@draig.linaro.org>
In-Reply-To: <878q8gjcms.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2026 12:01:56 +0100
X-Gm-Features: AVVi8CetPPb2pY0cel9IN6dR-6aJAbVnjHAtVmBC5Df3VBbHh0Upbt0eeYxUK3I
Message-ID: <CAFEAcA86_a3GfXCDOo2G-R6v3ALwUwNFRkspyTCR0umGiAB2Hw@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] target/arm: handle the WFE trap case
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 15 Jun 2026 at 11:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> Now WFE can actually suspend on A-profile we also need to handle when
> >> its trapped. To do this we need to pass the instruction size so we can
> >> deal with the is_16bit syndrome encoding.
> >>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > Doesn't this need to go earlier in the patchset? Otherwise there's
> > a point where WFE can go to sleep but doesn't honour the trap bit.
>
> Hmm - the way I read the description was we would only trap if we were
> going to sleep. Pre 6/8 we never sleep so we can't trap.

Yes, that's the point. The guarantee we have to uphold with
the trap bits is "if the WFE would actually go to sleep, then
we need to take the trap".

- before this patchset: we never sleep, so never need to trap
- after patch 6: we can sleep, but we incorrectly won't trap
- after this patch: we can sleep and will trap

So there's a window in this patchseries (after 6 but before 7)
where we don't do the right thing.

-- PMM

