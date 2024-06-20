Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA9AC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKETi-0001cv-8m; Thu, 20 Jun 2024 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKETe-0001cB-4e
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:53:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKETc-0005JQ-EK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:53:09 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57cfe600cbeso726631a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718877181; x=1719481981; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TsBQ3rcHz6afeqtu9RFubAOc02bqXltcu1rcXcLBnk=;
 b=F1apOnTjfpYtDRLJx8YaM9xX/PC5PFuMdm99VviGDBsZOPeQD4U6v+PTOc16jejdWs
 Pn0hHjxZVA5i393ma+RVvSyopzvtHbpT5f3pWaP406ZDnROnldGrsDvkAcWW0DwpnPoq
 ayIt1KY80qCqLd7O4Ah2hVDUVVwCLUKOjc7IW0tzNhoArJ1QU6tc6z1seLpfk+mT4krT
 pfYcH8dfPdzmS1OR/aqREuQawQKbSZS1ZQsIig9sLk2EP844BNr0uIMJ50ZltpV8bYG7
 mewKuVw/Mt7f6piqHupZjzQBy9dem6d9t9x0aKgXU3XDiVTreejUt6oiYWO6SRwKRbPV
 bRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877181; x=1719481981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TsBQ3rcHz6afeqtu9RFubAOc02bqXltcu1rcXcLBnk=;
 b=X2PGcKsA/ZzDaLUqB9qXxVTmSSxdmi6RWN0t5ym1t5pjoXD9eEvJxRs2QMcMiw6k8S
 dtbwIlNKimWtfWH5BWWnU/do30tuIcv8xzMS1Ya/TE6kH9Umre/GQhXXaZauRIiKzNCp
 HMVfbw8t1MJNBG7OBuVSfpsGLg/DUvqpjnDnUGC5i87NMG/dELhFzvl7Vn9At8Vi/97o
 uJydNYP2LnOl3Mu6/vphhsIJzCJ4fkVVA1QrZRNUZx3nDq+CY6JHbXHsu5KyLgt9UNUp
 +WwtKGOs05Ij0Y6xZIodSBbza8nPzRMZP4GtMCeBFihRz6H4Lo0vW4WObHSTFIQlvdkx
 4Beg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB8EalhkQ/ATYI0m+EGpIEwJtUYo4PtdSPisviN8LRRTKwI/ciPLZkmjXXAztz73531ptmCvbYtp+2LNx5VGeqIRr8jbI=
X-Gm-Message-State: AOJu0YzJabHGQXxVwoUJNfITcvBlxz1iFyAf6MsuSTkBwizUgutHmvlB
 Xc1OyxPXKoACnMwYVv+2N5Hcz3hcrIP6dVNaJW/qo6kJrnCfATNqD8yeOMhdfCNS2hVvWEkZLSo
 agjVaMcgg18WiecZNa3FAFwctJPPOnEz4TeRvaQ==
X-Google-Smtp-Source: AGHT+IFLsiV2zhuLgF9KIUJT8YGCCwqazH7DUGuXB8h7b1yM9RhI7l8JZ4BpO9eedEifWm1rDCw+mFFafRheliS8W2A=
X-Received: by 2002:a50:baa5:0:b0:57c:ff70:5429 with SMTP id
 4fb4d7f45d1cf-57d07e670a2mr2476238a12.8.1718877180797; Thu, 20 Jun 2024
 02:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240618172527.3450098-1-nabihestefan@google.com>
 <87o77xcn2g.fsf@draig.linaro.org>
In-Reply-To: <87o77xcn2g.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 10:52:49 +0100
Message-ID: <CAFEAcA8Jx=CrXCSzOtjtEky5ikvtatk8N2gz=nKccpwEwO13+w@mail.gmail.com>
Subject: Re: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Nabih Estefan <nabihestefan@google.com>, qemu-devel@nongnu.org,
 kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 19 Jun 2024 at 10:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Nabih Estefan <nabihestefan@google.com> writes:
>
> > There is an extra `buf=3D` set that is not used by npcm-gmac. Remove it
> > for coverity to be happy.

By the way, Nabih, it looks like the mailing list received five copies
of this patch email. You might want to look at what happened on your
end that resulted in all the duplicates.

> Have you go the coverity reference to include in the commit message?

This is CID 1534027.

> > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > ---
> >  hw/net/npcm_gmac.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> > index 1b71e2526e..b397fd5064 100644
> > --- a/hw/net/npcm_gmac.c
> > +++ b/hw/net/npcm_gmac.c
> > @@ -614,7 +614,6 @@ static void gmac_try_send_next_packet(NPCMGMACState=
 *gmac)
> >              net_checksum_calculate(tx_send_buffer, length, csum);
> >              qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer=
, length);
> >              trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, =
length);
> > -            buf =3D tx_send_buffer;
>
> So coverity is saying that buf starts at tx_send_buffer and none of the
> other legs that can mess with it are possible for the tx_desc.tdes1 &
> TX_DESC_TDES1_LAST_SEG_MASK leg?

Coverity is saying that in the loop body, we unconditionally
(in "step 4") set "buf =3D &tx_send_buffer[prev_buf_size]" before
we ever try to use "buf". This assignment "buf =3D tx_send_buffer"
happens later in the loop body, but there is no further reference
to buf either inside the loop body or after the loop ends. So we
will never look at the value we assign to "buf" here (either we
finish the loop and the function, or else we loop back around
again and overwrite this value), and this assignment is dead code.

What I'm wondering is whether this code for "last segment,
send the packet" should be setting "prev_buf_size =3D 0" instead
of "buf =3D tx_send_buffer" (meaning, I think "we've sent this packet,
there is nothing currently in the tx_send_buffer, the next descriptor
can start filling tx_send_buffer from byte 0".) Otherwise I think
we will continue to accumulate data from the following descriptor
into tx_send_buffer after the data from this packet, but when we
send that second packet we will do it from the start of
tx_send_buffer and so we will send the wrong data.

thanks
-- PMM

