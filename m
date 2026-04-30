Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296ACCD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIN1d-0003mz-IW; Thu, 30 Apr 2026 04:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIN1Z-0003mJ-1O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:45:35 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIN1X-0007Un-81
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:45:32 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64e87a81639so586080d50.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777538730; cv=none;
 d=google.com; s=arc-20240605;
 b=Y1/IYn2QeTxYusioHEfHYBcEtG0EvAaDT0tdppic2aetBgfVc+rZBiGWmxRAV1s25W
 W+Ea1aGmUIyHeIsDsSXpsEuPR9YxQw4AnoeKqshoKG5UTbnEGktgGXsGdGRUlLUSIGf3
 bUJHqUQZ+bNXTs6mTJsGbURP0Djxdx/T6VbYz8EBVZjPWVwzdhJXL+kjF9BKHM/uHqKM
 3tzmkqkgcSh+7UUUiZ1Wz9SVTuwBamM7DkxAXwrINqXTC0oPrGL7WJbcNbOeJAUp6IfQ
 GWDTHLKb2Esy/B6n1hz3hZ5aUY05vNyoj2gXBrOFbY9JNybwdt7ZhPWEOBUUCSGDB2M+
 ewtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CMEf52uglyiYHqZr1cDPKczbvu/oVf/r6eASVF3S1B0=;
 fh=dLMPHEaQJd4N8lz75/C9IVeRhSUfJQz+zvbklNoD4o8=;
 b=icb32FPN/Ub9CipD488l5T+wK7XCbWb8ylRQMvciIyt2C6hrYqqNFLYLBYAD2eSctY
 ePVuZs/gczqA/COBY2304cP4EKunURqiB6+z2yIzdgje1UBa6WL0aMQ42Ft47PG2wVeQ
 jFFsZSlczfSu/s3cxS2tPAE+d1Z1q9QjWxNCnPdNOk1hko5QrrmsjXae6ZNt3+preWyP
 SVbeQ51052aBuEXYhpXhjxMiL/L1mNpZc5tRUl15d1cIpaGhvXARDGeg2LWBR6RFfdFy
 tjSqxjdAlluN/zV1HJEeL13CdY1xjAb2takekCcp6BQEgBvlp5xFN36FXTPu0MPOBEYr
 ft6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777538730; x=1778143530; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMEf52uglyiYHqZr1cDPKczbvu/oVf/r6eASVF3S1B0=;
 b=NlBjVnxHVs9jKgLTwUdJv53HTKT5S2efK8nh3gyKu12/Z5vrMbf/NQOW8AZ2yBrw3s
 wPdqHiojAlSAnEstXrUgd1auE8M9qC4oLiaSWDyj+SWMKHIa4fT3uvc0nv/d/i3DEFiR
 e+S7RjL+jQI7mGB6mHq9ruCzkI4cLI1O5AeZveJbU4XXoy+H3nkGTKg4R2JMa+XiGvDy
 U8N8VU8iof0z2Wfl8ppArhijdrWGYFpswUCNhRttJBV2nn5sZEyQ10hqGtQkxIs+JmZI
 Gfgjn4qCf8lNR0gp096yjIassW+xIksYYphd1Jt59CQfDp0Ja5/na/uQSrPopr2otDjx
 lVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777538730; x=1778143530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMEf52uglyiYHqZr1cDPKczbvu/oVf/r6eASVF3S1B0=;
 b=LwJPjg0dnDApoZdDDhD8XfSRlXaoQAq4aucX7HqZnPfXgs3aFyAlLceuR6SG5UCbPc
 DPFRlLbwvkXcGllxw8XBL4xTiRzZ7e507f4rvJkBtZp5ALG5WyqbJq+S1Cc87NMuRtxG
 Av8QKicWpmjTxBvJVggbYCuAQQcWHVKVNyTA/xxw3iFfs5FealqHTbw5VaIMmECHEE8o
 LD1chjQkN9dNpB5Bu3KOujjEXH3SYxSQqREu00cvWr1tYfVrDYU1+58foK5EadPwRBsO
 qOI7X0/cU6xcohhpTAW2kaoRwGreiNHeYO+rSRH3v6S4bYK9Ez+MSTA9Eb+E2YS5/Ed/
 jP8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rNyaStkrFMipoaqIXarFziO0JCd9bhjNCMCj+F1CZXyjPB/9AP4rNlkq/HaB3nPtEMoBJhvRLg4ZX@nongnu.org
X-Gm-Message-State: AOJu0YzLrqsood7hYdwne+dtY5l+TdLAR2Uj+IeulbukKCvvc9PrxsNH
 wUwh6hke3lWkNY4N3FRHokx2GKjuI1cQo3qQ1enRkQ0bwikpaJXnWde585ZiHMy73tpd4L2c29a
 FX2OjYRz5iax5hRvWgTAivEKFP+MwXGWmaYYjZ8hp/w==
X-Gm-Gg: AeBDieud1rL2drAP1v1q6Lc0jORU4RB8joUEBxT+CjPELfKdqXrfTPH2bl4LU8q7KiJ
 HQhHpnQ58bm5PWtmIKUHkEaxvZ4YmoPFwRR9vDl2CvimNiAWzqS5hGZ/SY4RV2QQPMUGVa5cXBJ
 AgWpfKfHTSa+EYOIdBaXx5qlaDZpu95upoblgbDo5JRhAb970yVkVS8L1C3tky2X9OhN1j9Y7rv
 qXCuayfq9NshOBEQOStVjzGfDti5fe6R/H0dXF6QM6CyFyPvf1ezicMktk/C7T4G8L2iWE9DKFP
 M3yuMLVqj/nVSY6J51qRRfdwUji3uivhjp+ymQtx6qFvA9nwzfz+SduYJb1rMNW+xwwd6ZolyR+
 yZAa0x+iJNsjP
X-Received: by 2002:a53:b44d:0:b0:651:c1b7:2761 with SMTP id
 956f58d0204a3-65c18c4c5a5mr1048587d50.16.1777538729696; Thu, 30 Apr 2026
 01:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-aV1EiKRh-Zpb9=77rXYPD2uT7HZmeNfvVW-wAToT+gaVC=A@mail.gmail.com>
 <87v7dvgw58.fsf@pond.sub.org>
 <CAN-aV1ERB-vdvMyRuNo2tog9-EPPyCunXJkk-kC=DkX-kU6VCQ@mail.gmail.com>
 <CAN-aV1HDZfoJv3OCm9_f3epNtvvr5CrvB-1Fi4y7jGLwF3Xx7g@mail.gmail.com>
 <875x59vysu.fsf@pond.sub.org>
In-Reply-To: <875x59vysu.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 09:45:17 +0100
X-Gm-Features: AVHnY4IdWT8BfHE623Hblc_Gi0_tYdEFs2Kr4-nflbjx3I18wB2e5zU2WZW69hw
Message-ID: <CAFEAcA_-7oLAqqmq0buCKtt0sy_22_o3SwOiYrRTjxLug2Sjmw@mail.gmail.com>
Subject: Re: Question on preferred location for QEMU sample projects
To: Markus Armbruster <armbru@redhat.com>
Cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 artem_mygaiev@epam.com, takahiro.nakata.wr@renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 30 Apr 2026 at 05:48, Markus Armbruster <armbru@redhat.com> wrote:
>
> Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:
>
> > On Mon, Apr 13, 2026 at 4:04=E2=80=AFPM Ruslan Ruslichenko
> > <ruslichenko.r@gmail.com> wrote:
> >> Yes, it would be good to include this project within the QEMU source t=
ree.
> >> To build the project, the mentioned SystemC, libsystemctlm-soc and
> >> VCML libraries and their specific dependencies need to be built and
> >> installed separately.
> >> Would this approach be acceptable?
>
> We have a few (small) examples under contrib/.  However, Peter (cc'ed)
> has been trying to clean out that directory.
>
> >>
> >> Alternatively, is there an auxiliary repository within the QEMU
> >> infrastructure that is better suited for these types of sample
> >> projects,
> >> perhaps somewhere under https://gitlab.com/qemu-project?
> >>
> >> --
> >> BR,
> >> Ruslan
> >
> > Hello Markus,
> >
> > Do you have any thoughts on the preferred location for this sample proj=
ect?


> Peter, what about you?

My general feeling is that we should not have sample projects
in the QEMU repo, because I think they tend to degenerate into
"this is old, unmaintained, and probably breaks without anybody
noticing it". We have enough trouble with the code that is
part of QEMU proper. This is why I am hoping we can clean
up "contrib/" -- I don't want unmaintained code that nobody
takes ownership of, and having a "contrib/" directory is like
a big sign saying "dump your garbage here and run away".

If we do have sample projects, we would need to have a
general approach to them which involved, for instance:
 * integrating them into our documentation, so that the
   docs for the associated QEMU feature could refer to them
 * shipping them in 'make install' as part of the docs
 * some kind of automated testing that they still work
   (by analogy with the way e.g. rust documentation code
   snippets can be tested)

That's a lot of work.

thanks
-- PMM

