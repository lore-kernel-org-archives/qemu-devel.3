Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3F5D0BB7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3u8P-0000cg-08; Thu, 24 Oct 2024 05:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3u8N-0000cT-Ep
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:27:59 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3u8L-0000LN-EP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:27:59 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so6587301fa.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729762074; x=1730366874; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Vw44/IGDHGVtbRZSIkwW6dgCJnRfKhP9Fg+fqXK0gU=;
 b=ECs+4OS1bhsy8H1jVTHm2tCwOkqAMAqE+GkDRBYbBIJthQQSdKhPvqObrpYCg6HMv1
 n+kZ/nJCfVGOwEC0LGwFMF6BYx66tfR8iEArOF0VTAVeCymoMdBkmWmhuZ93YKcSRTY5
 +4G9gAA4bohwkp2wgxgq5jPsUSmvZNV78vzuqPKd56heeLrnqG7+Hom3nTLTf/JrLsh2
 DCKZ85PqdwM4uo1ekJY+6yGMNu5RurvnvE6yEH9MKTO6Ca6KaUaSg6qHeuvngh7+itEX
 J5qMgIolk344q/JtUSj4bOz3fwmoUFrDhqjjIuQCCVRr/HBLsVQxi0N7Yxi7efuR35xN
 uQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729762074; x=1730366874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Vw44/IGDHGVtbRZSIkwW6dgCJnRfKhP9Fg+fqXK0gU=;
 b=qmvruwAEIh/ndEWAM1Md44qvu2lA6ZkR9TrIvguLVa71v0sQa/o3wg257xwj78Bm1n
 B6iTGpRo1HXO7Pa/ZH9LiMVJDifAioSRerlYKeoY3LrTKa6tDu+U6CtOB8M6tpD41K7K
 RCReafPAEQs9Wa9bW3bQJ22kF3BBMG99RGkAgU2Q//nqKLYzBRqDITaR5oCjsCLhnh8R
 PTNGkh0N7Nzt2AwAD0eL+8KXWLmeZHsn0E6fyh/rvkSCmcXrAEa7HRoA0qpDzA7DmMbV
 RHtG1ZECjkElC7bhz6fCp6wPpM5XCqHMjZ+9f9ikwOonjP/1MehcNJrI73VV/b1RJqKM
 HidQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9T42xZPKINxzsJxPxzfZKoDTz1P+XBiEt+n+CNqOwRk7AdUNpp5VK2Qm3WKXnSIbGQEOTesSsIqAH@nongnu.org
X-Gm-Message-State: AOJu0YwDHCABHS236ZbVo+ChxJmC/R+bWox7/73xLGucF96sXuCZc7vx
 ilRYi3PAwOgkP4SnhaBa+uD0fLULaNDoBC2V27kqJKoB+ubZkpLTvVCsenwFBQK5cZckUiZXLHv
 TineSZe7VmJEDkWATwcwMdSlvj/lANwwqSMgwlw==
X-Google-Smtp-Source: AGHT+IHetJOx2pidhQpRaDpIjNHeL/hydkQIWL3Z96hrsPJKCCIgS3TJEmBSK/+jaQfDgZHeC3TUOPN5XVLUK3SwxLs=
X-Received: by 2002:a2e:6112:0:b0:2fb:5ac6:90f0 with SMTP id
 38308e7fff4ca-2fca8264708mr7213521fa.34.1729762074061; Thu, 24 Oct 2024
 02:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
 <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com>
 <87bjzalhzc.fsf@draig.linaro.org>
In-Reply-To: <87bjzalhzc.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2024 10:27:43 +0100
Message-ID: <CAFEAcA_+9gA3AqJseY5=5hHOA3OjuGS8bjbGMbpkzFyy7Ggzyw@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, qemu-devel@nongnu.org, 
 Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Aishwarya TCV <Aishwarya.TCV@arm.com>, Anders Roxell <anders.roxell@linaro.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Wed, 23 Oct 2024 at 20:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Agreed. However I think we were masking a calling issue that:
>
>     /* Actual RAM size depends on initial RAM and device memory settings =
*/
>     [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },
>
> And:
>
>   -m 4G
>
> make no sense with no ARM_LPAE (which the kernel didn't have)

QEMU can't tell if the guest the user wants to boot
understands LPAE or not; it just provides the 4GB
of RAM, PCIe window above 4GB, etc, and describes them
in the dtb. It's up to the guest kernel to correctly
handle the >32bit addresses in the dtb, i.e. if it is
non-LPAE to ignore those resources it can't access
because they're out of range.

-- PMM

