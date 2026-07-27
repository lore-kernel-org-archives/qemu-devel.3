Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A187FC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKr7-0002ih-BY; Mon, 27 Jul 2026 08:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woKr5-0002hk-6F
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:54:51 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woKr3-00052L-GO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:54:50 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66899fe9077so4022682d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 05:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785156888; cv=none;
 d=google.com; s=arc-20260327;
 b=dLWJbXbKNLPGbiYpSlizRBGcRtqyA0QqzWGblxWOf1d1PFEsLkNIbgh0pQe3nzx3/J
 Zx96opxoo1+WwLrbUpiHb99dtivcTWgEW1nHpuf50zb5YYHKsIrhrIqt3LKSXPbg67el
 H4Akmb5E/L/oUcoEqKj8uUHSLGRXE+4zs87sgfpEQtHAaS+OhEnRsjExI9u9bdEd0z7s
 T/dGDiMHKy/t8GNoumcaV8LXiDGzaRZBfJIXUiBQu9CS08ULwg/PIhkT05dTzXnfIlUa
 4R1gpBn91vwdj9yyO5euSTT8JrNS/aoDpLn4m/6FdqVGlim2OJTyjKplTKq22cSF8Q+v
 jDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ydeIOwbrMZr0Wk/vqe8YciUyuILuxZAAy4kF0Z9zNok=;
 fh=AxrTunfAAC7+Gk14Yr2x4BmNQWlSksoAx60lqQjc7uw=;
 b=AFUMHssngFHVCN1wlessR3bnuhpKN8BRseKCLG1TI9avqVh5viNuPWI/31IwHpV9qi
 HcWzQIrv0hntwHZasUz6p+k1PFuAj/irwnWw6bw+ssqR+UtlJYju7O34PoCFmBswk9TD
 6Zwbf+Q6WO7aEGxV9Q1kieLdWtIDRXVkooK02N6zC3/qNq83J+JrQjPYCfNBXcOeF2gQ
 hkep9soFoUtY0nXflSfD1Q8HfkqpyAmM78BiLZNRy+DIChFZn7x15cA16AKe46dVvarz
 oy8QtbhCf142cPne1+UbkrIgscb7VxAWIE2MyLlOYDzT8S3bt/eXze+wBL/nxN4YqaZG
 qcEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785156888; x=1785761688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ydeIOwbrMZr0Wk/vqe8YciUyuILuxZAAy4kF0Z9zNok=;
 b=CXMw8I/Lw6PXKPjZ8v+nCXM3WZf9faw3W2/Fcww7/zB0X6CaVUslfg5cotNRRL3lsM
 dBOEpQWyQLu8nY5JBszrSrB/zfZ2J6CC9QXvfMUNnJTqOiiYI8g6nn2zRhkx0BjIBJSI
 5yB83spY4/TLce3+283fo9buuMnLAJCnSguR1BPFVJFknq1IRv1DtcEpu8iJhI1NUudd
 VVvz5msLsqDMccg9thSVarFKA/sDEcctDcAI/APpvhCQXU+Hmx19xL+Lm3Ig0MAm8cnt
 vrGu0helL0eTZB+US5UQ6xnQj9x3aA9tfMd7dVhtd4LPtECqvUv3ZJMf3yiESEVm/jmD
 NfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156888; x=1785761688;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ydeIOwbrMZr0Wk/vqe8YciUyuILuxZAAy4kF0Z9zNok=;
 b=XECxghUr1jfP1QPYXTEUHLtsqd7E2FAJDZ8adF9ydAD48ZeYIomLeH+A9jGAd3TWqT
 Iic2mo9jTpQDz91XSOo8yBTsvWhwFgdMogdg1X3F9u1vrp9SI4fp3SuC6P/V8I2urpHJ
 /u1sAbHTMNtxs/tP0WBbQ6GSHCBGR6tAs+MnRPlRLLjLDwB1a3kL0LNiyUPcfjodNu1Q
 8mcPy17u9DJPEiG5ltbmdj/l/HrpVAHMrYVPO6zg8vYUm7vy38+U+RKKQPomichk5GeW
 NR07ebBjDmMOesjiNImo4iLBYt+aIAObCMuWDbTT2sDxJj8wbfmWPksUPqAnFsUJKZ3R
 byuw==
X-Gm-Message-State: AOJu0Yx68RxM2dR5xB9PWwXUg/XAhxmcjC+v8vJIBssll/+Dvs5V3LXu
 oWvyZMNKcS6KWFuTqNT1tHW8p4DdE3BukA8bKsGk65MXaq6l6DmQWqFpGMCndGdrHOKtui7NjTl
 k3QDIi8QcVq/LchiyumFSBNOOt7FueDYICCvB1OwpmQ==
X-Gm-Gg: AR+sD13Qp2uo+SUUkppttoeMijy8gBwsx6dlz3uAL0M4iUXKl0pLRVMNyQ4bALQlC3+
 s7lmwpCjA4n1rq/ah8jnWbZp6BJq5okcXTfsnM2+sAMbJRIfNCILzyCKDm+8j4P3WWBPTd/dRsX
 dvEs3tTUmqT7m5EDssY/WDqVU4+gmPP4r9IW1HLTmYxSCrrcpBVC+0hWEaso8hdvUCig0/G+Jq2
 IjH9aC+b0oSoF8GCYdGwtmrEdIWa4MtoOHssgewjQay1QEzxb5C73C8NIaDrvsbzNuQvvgTrKGn
 wFf9hPOfQengVSMz87c/GRzgvDQ5vlGBX3ZhmPHY/5tcgA==
X-Received: by 2002:a05:690e:43c6:b0:667:c064:ebcd with SMTP id
 956f58d0204a3-668c7b6498cmr1587069d50.75.1785156888032; Mon, 27 Jul 2026
 05:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-fix-sign-extended-32-bit-addresses-v2-0-6d6a01efed8a@maquefel.me>
 <20260727-fix-sign-extended-32-bit-addresses-v2-1-6d6a01efed8a@maquefel.me>
 <CAFEAcA-hKu_C9MULJ=8_jktDgujveQRBkGXvgnczPNrTWZfeQA@mail.gmail.com>
 <9e4f3fc272c854f496d7c3ce8355df6d3248063f.camel@maquefel.me>
In-Reply-To: <9e4f3fc272c854f496d7c3ce8355df6d3248063f.camel@maquefel.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 13:54:36 +0100
X-Gm-Features: AUfX_mxLzvdktWkC5yXFSzctS-grvjMmfMJP-YZeoMoQy0Fr6y1RLpsMQ3Ae7PE
Message-ID: <CAFEAcA-3ugXDNUncKuv6=GC9b4dkWmDpY6xRRFM5uHGRFPzk6Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_1=2F2=5D_semihosting=2Farm=2Dcompat=2Dsemi=3A_Fix_?=
 =?UTF-8?Q?auto=E2=80=91strlen_detection_for_32=E2=80=91bit_targets?=
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 27 Jul 2026 at 13:13, Nikita Shubin <nikita.shubin@maquefel.me> wro=
te:
>
> On Mon, 2026-07-27 at 11:36 +0100, Peter Maydell wrote:
> > On Mon, 27 Jul 2026 at 08:46, Nikita Shubin
> > <nikita.shubin@maquefel.me> wrote:
> > >
> > > The switch from target_ulong to uint64_t broke the mechanism of
> > > passing -1
> > > (0xffffffff) in arg2 to signal validate_strlen() to compute the
> > > string
> > > length automatically. For 32=E2=80=91bit semihosting, detect when arg=
2 is
> > > 0xffffffff and replace it with 0xffffffffffffffff. This causes an
> > > overflow
> > > to zero, restoring the original behavior of automatic length
> > > calculation.
> >
> > Why do you think this is a valid thing for the guest to do? The
> > change
> > in this patch is to the SYS_OPEN semihosting call. The spec for that
> > is here:
> > https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihostin=
g.rst#612sys_open-0x01
> >
> > arg2 is the 3rd word in the argument block, which is documented as:
> >
> > # An integer that gives the length of the string pointed to by field
> > 1.
> > # The length does not include the terminating null character that
> > must
> > be present.
> >
> > There's nothing there about -1 being a valid value.
> >
> > I think this is a bug introduced in commit 5b3f39cb04: it
> > added "allow length parameter to be 0" to a helper function
> > because presumably we need that in some cases where the semihosting
> > ABI passes a pointer to a string without a length. But because it
> > doesn't separate out "length is 0 because ABI doesn't provide one"
> > from "length is provided by guest", that incorrectly allowed the
> > guest to not specify a valid length and QEMU to accept it.
>
> Seems not a bug but intended behavior. Commit 5b3f39cb04 deliberately
> added support for a zero length as a signal to invoke strlen(), as
> documented in both the code comments and the commit message.
>
> Citation:
>
> ```
>     Add helpers to validate the length of the filename string.
>     Prepare for usage by other semihosting by allowing the
>     filename length parameter to be 0, and calling strlen.
> ```

I take that "by other semihosting" bit to mean that we have other
semihosting functions where the guest passes a string pointer
with no associated length, and we're going to implement those
by calling this function with length =3D=3D 0. I don't think it was
intended to make that behaviour visible to the guest.

> So it seems like a regression bug introduced by 6dfbf9b6cfe.
>
> Before that, open() simply ignored the length argument, so the current
> logic is a conscious improvement, not an error.

Semihosting has to implement the specification; we don't
get to "improve" on it.

> Still in 64=E2=80=91bit mode, passing -1 as arg2 still yields the expecte=
d
> result, so there is a bug somewhere =E2=80=94 either in the 32=E2=80=91bi=
t handling or
> in the common logic.

The bug is that for both 64-bit and 32-bit passing -1 is an error,
and we shouldn't be making it work on 64-bit.

thanks
-- PMM

