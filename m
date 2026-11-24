Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B67606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JfUIXY7L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxHR-0006RL-S7; Tue, 24 Nov 2026 15:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxHM-0006Py-J8
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:38:16 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxHL-00051P-20
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:38:16 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67da62357acso6798474d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795552693; cv=none;
 d=google.com; s=arc-20260327;
 b=E8eUC/kPyCrybE+WwxaBW/ihcenf5ENHJTNOpZE85CvD4Ba9ZEDBvJYUH8r9yuOqLw
 L2zvqkSZvM5IsKS7Br8v3Vsx5z1pWYZXJrHm+77ix09sJW14Gh7/NTvAw+exnSWG786Y
 hjjBZTmfndXuZyIHfxZ4MmVCzmjVBr74aZTF+nfy9kinQNdz7AyZclWv1E/5UND9ndO6
 BGXjsS1ZR4q82pRZdumyPHBLHOiu8CwTWGZwm7WNzPn96fN89poi1cXukmVAkK35Ew1K
 mMVvSjUDOJv4I1Dqd12DsOWGUYPKFa4kqkUr2sZelUJAhcUZ6gRcdqW61/P2eEqbJVgR
 ez5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fpM/My4/hst2cYjxNBp2Wr0+0Rc/b0LlESxC5QV31Ag=;
 fh=LmUYleC+SX6toDhRXmkANENTiTvxpjMB8NtxMsteiuE=;
 b=E1pffrYyEgIqHNqQJIF8vjhK+wyBLO/hKrOK1sC+oTQAgZDFdrS4Mrc4TlcoDswQo0
 dpd2FoUXyX3O5+2uYfla7uilCE/VXXnMm4gBHi6ResP16CVTWgvezOaVeM1NYtIMbxTJ
 YKRZ3dKpyqoltoA2KE0QkK1Llcn74KwAfxdnwma7fA3w/MoBnC0qvF6wVML2lKO/cmMz
 2LgppIJ1KqBSHsAvFTtmzGjCVx9iagqVvnxhVHYxzz1kWptFNNGTHnR8BXnlooarQ+lW
 +iCdaK5J0W0jbjxjmZ4CI4jR9elfPL65lRFz9xxLQaCKfvHxeLCcyIZulT4q7+npI4gz
 tNYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795552693; x=1796157493; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fpM/My4/hst2cYjxNBp2Wr0+0Rc/b0LlESxC5QV31Ag=;
 b=JfUIXY7LiAWlqdaiNVN7SNY3XMKTb2AMFtH8rhR0371qehmN4Ethp2I8uMQmQZOuvB
 O+xDkkwD79FyJ4drCCxgZpc8QflP+PClIViIh1sY9LstpXNFW0F4jnL3YIJDPvESO0j0
 zsJnl7qXsqGsniIzkK8Y4XE6ns0pt6H0c6dXIpnlowZGcqDOlPqoreOIOzt5zypJJufq
 SiykDJKS9qj6Hd5r/rOB4a1KRecYQnV97ocmHUYjv13XqpeILc2x21yTT9kD91vZAk7i
 fMJ9yfnCbeQkMErYbxpky7Z8Jz+cKIbv8qgrckUGbTfUMtO8KtrDQeSKfChX19quh5tX
 LZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795552693; x=1796157493;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fpM/My4/hst2cYjxNBp2Wr0+0Rc/b0LlESxC5QV31Ag=;
 b=G7330QQYg5f+gDzBdp/HBSo/37U3f07H8alT4JS3AGkvIcutV/MnYEfC0+C/M7C53q
 c0ZqHM2FIj5HTS0neXZObbDYbUM0MRLKSi4vXubFxZODvDvxj07Kg58x9giymiZAnkSI
 dyZ6pwRfZa/6sU/e+db0Vesec9NJ0cEVRr59p9bzEGZ2Cj6qQO8pDK7dNJ1h23dKSZYM
 08yxRV4MJTFshUI40Pf+Dv9fi2JaQi5ynFwpyw++TdQsp/He9YVlrauEqxOsFRGyXdtU
 G4ErCUOZzVUGGesZxsEzHxPZDiJIvc5OvO5+nxotxZ0BjPo3QsUh6l8KlEzjBqava1Tn
 iW/g==
X-Gm-Message-State: APuU4Z/58O8jW5u5lzdsIKGfM2xmkuhzSgSXURIILyWUZjORP0jRZDC2
 NvgeWWy/3nMmYM3X7ZTwuwfkaglJ/X3v7npIY3CPj8soYkOz87HhNFhfFcXwIPu0QzKyiqwaad0
 a2RBKXUd3Z6Et2YfmtH5plkw87SeYfvbiebugXb1tZQ==
X-Gm-Gg: AZFdTZdPvJ3OsCv8u5Z9cAuXTDcU8w8Mu0Ac1DMg4AWi+0TIgYq+xjN3rzVfJLXDQr7
 tT+W1tWw80eWIpu2boB8b5DGTtv3+qrm9uHsH8k0X0CeKRKC/SAj3B2oAk3i33WJ3N2QGjrhbN7
 FtkdgILV5TgpP5LkLfJuCH/tPHM11X/qfU7JRF9WY9ufKCyeU4RWAVGKGR7PiXVwdeeUP4g9f0f
 mRXmaIvPHcnEjfmhDgcBrdl9JifXnA8zcOpls6L0UXIOheSoSl3difs80u04PQI7fYH63A3/QAt
 GUSllaOU+aSPG50BoB4jWdcwhkKsnxy3Hh8Jdjma8ePOkPqdtxdDtzZ1+V9mkvTLR21uz3gHL9M
 9/OzMU1cS/dP2aHrjnC10M3QN6rWjpDxYjxn+tYAJTsoFqTbt2wZcsZ6ny0bBWlP00VOEPoiEzJ
 wzxznT2p8A3AnZXBovOzN7np0QqXRXoryhdthd2Hm4/w==
X-Received: by 2002:a05:690e:484f:b0:67b:ea15:ece8 with SMTP id
 956f58d0204a3-67df450231emr4237764d50.101.1795552693382; Tue, 24 Nov 2026
 12:38:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
 <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
 <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 20:38:02 +0000
X-Gm-Features: Aa3M54ryZ1VMINY7XltF7ls4zeM3OwjtuBPUQyC6iN6aBAvjY9R3YQ90e-XLbTU
Message-ID: <CAFEAcA8-UQPdJ4na2EXfFff+Nw547nYVDfQcK-pjLr6ykW=ThQ@mail.gmail.com>
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less than
 a page
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Michael Rolnik <mrolnik@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 18:42, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Nov 24, 2026 at 05:37:23PM +0000, Peter Maydell wrote:
> > The atmega.c code explicitly calls
> >         vmstate_register_ram(&s->sram_io, dev);
> > which is why #4877 reports that we crash during migration.
>
> Ah...
>
> This seems a hack.  I don't see what we benefit from g_malloc0() rather
> than using memory_region_init_ram(), it's hand-coding how allocation is
> done.  IMO we should switch.

That's what it used to do before commit 9f99072fc08 last year,
though. I should check with RTH why it's doing that so we know
what we need to test to make sure we avoid breaking something.

-- PMM

