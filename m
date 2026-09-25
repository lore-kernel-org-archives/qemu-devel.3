Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD0CC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABJF-0000GE-47; Fri, 25 Sep 2026 15:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xABJC-0000ED-Tm
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 15:10:10 -0400
Received: from mail-qv2-x10.google.com ([2607:f8b0:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xABJB-0007tF-DB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 15:10:10 -0400
Received: by mail-qv2-x10.google.com with SMTP id
 6a1803df08f44-9105d241693so11613766d6.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 12:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363408; cv=none;
 d=google.com; s=arc-20260327;
 b=SLErPJaOgGCVT0kupme7brU/FovYEK6hqSy32kD0pesUfTVeh7X8v+HnXrV1Wxr1vX
 OEO5JFnQ2pan06ulFhSr/q0CXKXZp4fuTMQfme4GQh6joJpK8+AiLLgdE0Q737TG+WOf
 Pt0obweMFUK+GpjqWRyDat2xpCVg4QLrrCfkqigbfzervSWLRkQ8F38gzAzS3EtxILPw
 yEIR0xz9t/eubvCsMJTwVM66kXNGrADZNH1RZFDCYCZZURe94d2nIPtC/qXjACmJE8jB
 WDG97dGWrAa4jcsgfkvzi2RR/aQAiEWzkIwgM9agQST7w+fgxvTqu4+W6zhBUMk9Z3tI
 atuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wtU+ZaLDEIDKS7hT/fbTpfXBDLsgDjKP8P2eakUKL+Q=;
 fh=UvdJxE32w4n1nSbEM7/JH9yMfvpEOu9KLbhKto333J4=;
 b=szFo+O9MxoAnF5tYibSoAah7z34fwAlt/BZfS1N61mxMI3uLwlf0Gvu73d4Zf9ww8D
 7O5WnK1jEk+TDqE2Ug8d2qENxRwkut3Zn/PItBT2K7etYkZNDTx5VhezRvlXejqJDX0+
 kGauXPEUIVZxv+15swJ/OUraruMU8nw+wNYB0QcmR8QEAeiq7bUpmDDGOrs78H6lKnts
 k9XXqNf4rpkuIYZk1LRRdmL71zXIcV92UaXntodDr33DwzBLN64oM2C6nkQ+k6IDOfsw
 vkaJGNywN/26gse9mu9dw5SMcNmLNyQqI49YxZa4tiYwaiOZkGD8ftOxOs8/GBi6Z1PD
 MLAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790363408; x=1790968208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wtU+ZaLDEIDKS7hT/fbTpfXBDLsgDjKP8P2eakUKL+Q=;
 b=c2sOZ0a/Djgd9H3YEO/3qDeeV6SQ6Nc+v7YKeaQGpeO72GQ/0TtbIl7xBuLgIBUCLT
 kCordJZ1zYl5BbAzPeBAWAPfnJEPYKy9mf/9vEbH6xl5rHvS836de7rYlY8DNlyKy3Fo
 c82/20Q9KBokmRjL8NHSt4fkW+9BN7jG4OxloQp2eTXUsdWeVYgt4ESBFWEddy/jb3oN
 jolk8L0JNIQnlIUn8j62Q1zk5TFWs59N5IHpltrTFh7iJ+8WvMjr1KA4/aZQCq6+MFDV
 6pH4qULzoSzFE6WXKja1nddqFYHMeMNW7f0Z0Eg/KGaiI0BP4B43MrLGzyVrDGQwYjV6
 P5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790363408; x=1790968208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wtU+ZaLDEIDKS7hT/fbTpfXBDLsgDjKP8P2eakUKL+Q=;
 b=LKiTha7hrdqJpe/tJtSiuPmhRfq9BXM55tzfJ87B56Pvf36a6wIsBJmuRaXPhPGPvz
 K+oxpDMStE0FR6fxWbNaaMWR+kACRVLmsu4Z+8NZD6IqutDa+frG4tIZG03yZABKP2Tz
 yVxxwaF18U6ZTYY8GhskGjumeUOtm6kUXsv7Tfy2sJuYRKgNMW7mdtamno7KW0IyAC7D
 TSYl3BOeutqOyXxUCRrPZ9Ul5OjbYPy8sFFO0XRPui7XXK7iJwVq49m9w50crkZJV+dE
 94gzx51AvnYdemnl/kDJ72AVXEQIV6pnOOHZa9+fBtecWkFZaMK5OFa6Sz4/Nnk1QSRB
 oerw==
X-Gm-Message-State: AFuF++mAR//y3MC6mKSZ39DVDXuIW4hIQkH+WH7gOsRpc0gA7wqZqy5L
 e1i4qKxRm//AWrXs/9YzMGwgBH/fAgmdYGGIGyLrpqUpxjGQMkD3D/kkJKQ5YGCYTBrNsjYcwfo
 u0K7GI9VS6H868+EaojB46gCWQ/3/I12g1g==
X-Gm-Gg: AYBFou2lkqHyPLBnx9mERDFinyR0OJZBjd6EIMa2id2EHcDUGLLDdM0hdH78rGr+8y5
 St8P+OIDes9rgBf+FvnqES/uI/Im1b+pRIvaK7Im6ng5kNBIImH/k+jHczI22NyDAwYoavhrDHe
 q/h+PEL8LC7YsoU6FxsGBJaelinDv2YTxqZqXkbB1YhU23d7Dm4HJJVC3+teuN8MEFUIlswdw5N
 hpOnB8+cDCJPBtxvLdOF87IcYR1aVbakkYoTeSaila30Xui3BQI9taMKaDnGBFiaPFMzLLdRjnA
 VRIszAaDtrQ5ShAJurFrMKVmOwwjgKJJX8pkJa7aSilZKbOLPYZOX4t7pIacXLke6kc6Y1LI3Gm
 9YkUw/9VjxRu3zTihHsuF4xJm
X-Received: by 2002:a05:6214:848a:b0:914:34d3:e465 with SMTP id
 6a1803df08f44-91434d3e8e7mr38451916d6.20.1790363407838; Fri, 25 Sep 2026
 12:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260923013700.1505113-1-mattst88@gmail.com>
 <20260923013700.1505113-4-mattst88@gmail.com>
 <89182116-b7e2-4d3a-b1a7-95939de5866c@tls.msk.ru>
In-Reply-To: <89182116-b7e2-4d3a-b1a7-95939de5866c@tls.msk.ru>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 25 Sep 2026 15:09:52 -0400
X-Gm-Features: AclHuK_SbtoDaKJZ6agGOLyR6mJ6PxmkieT9KAjXLcrKtkzB6mAveVLZ5RODYDk
Message-ID: <CAEdQ38GQB6vc7HhUPrcf8r=nqJc8pnWJ=nANbLTyAtRbGqnwrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-user/sh4: align the vdso sigreturn trampolines
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:33::10;
 envelope-from=mattst88@gmail.com; helo=mail-qv2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Sep 25, 2026 at 2:55=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 9/23/26 04:37, Matt Turner wrote:
> > libunwind's unw_is_signal_frame() reads the trampoline as 32-bit words,
> > but __kernel_sigreturn is only 2-byte aligned. Align both trampolines
> > to 4 bytes, as the kernel's vsyscall-sigreturn.S does (with .balign 32)=
.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> >   linux-user/sh4/vdso-be.so | Bin 2720 -> 2724 bytes
> >   linux-user/sh4/vdso-le.so | Bin 2720 -> 2724 bytes
> >   linux-user/sh4/vdso.S     |   2 ++
> >   3 files changed, 2 insertions(+)
>
> Shouldn't this one be picked up for 11.1.x stable branch too,
> like the other 2 in this series?

Yes please (and thanks!)

