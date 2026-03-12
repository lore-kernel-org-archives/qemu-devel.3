Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AC3FED2F7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ce2-0006uM-6M; Thu, 12 Mar 2026 05:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ce0-0006tv-DR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:47:52 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cdy-0001nH-VY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:47:52 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso1165492d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773308869; cv=none;
 d=google.com; s=arc-20240605;
 b=QKr5RUh5VkCmOjbZtsr7hyVeuRMLZquEKdTCh5u4VNZtEkta5quJCGbMByrmt/ln3V
 iKhtqctyk3M1+m4YDBvCIUCV4PVIXEYQUr02fTo2ihobTx+AaTVTUK1Bn9CC2Fc0Sbw2
 Co3l10R5l/GeH5cSu8e+gpk5hFh+UB8XtQG29Nh7VnnnrE9OyFahR9sHSaJBLofpUtrU
 DoB+RwxWAhT4ohi6fHtFcHHSRA8Lj4N6jpiepnhZDHDhkJzaCTDP9QYFuHy93kqCHhZ6
 8Kmv4QMSZjIUosdTQlVjHZbXPeKMJrLLkHh05ArK0tqVsl5P0LOyMT7NCjwrtZ+0DXHx
 f52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SeiYm0hsHTBKVIxD27bpLm+Dsf8S28/DjpIEOpFWN5c=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=cJOdZ5i70JotKniZv4UzmwdhHKtT4xVrMsHpeJK5uEZFvq74k/nqk9UeP7YskfOIRi
 QiWEVqwVmyjCPgpVimDe1tDKtdgTzjdmjwqLg7bxQsFkoNwiL/Dg/TgGuAvPcLp3Aef1
 SzmjrogRxwXVRAgB09/71TvBoXazS6bjOP01JTSm54R56aFh7CShZYXZdmtKyIr8fmDk
 XT0W6cbwoCebjtQv7d5ATR1WWxSuxIAXCfuxlAdWJM4VccLtYIHHPXpRAksUID0v0EC2
 Rzd70Hpb6zrxXCgoehS07sloYBso0xdLKsdsM0YZoryIcHmBHfWNtXf9xF+cTVmyXENM
 TCUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773308869; x=1773913669; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SeiYm0hsHTBKVIxD27bpLm+Dsf8S28/DjpIEOpFWN5c=;
 b=DoA62Fi7SOQGq38jDuDo+u6jvDJLL4kVX8bpjKZmfqwIYgJkU3EIhejuwbX7t6AgpV
 6f427/tyZgEPltrgoIdcGVBMxOB764p0z4gW3SAkX38zz6l/WBUO52E6mZAKiGsJ59Tk
 kao9SNXYPayzRPuXpD8iSlw1IrY+omPHCNWctDsSYuOodSwfKF6b852Oe2PJWDmISb16
 Iy9SgfCH/7TrIW3znorYmMaZos1TazM9JKnSsjfISUGQlMLhVjsprWNp0JQVTzbg7XPH
 7NxqNdUb0S/LRsOxoj5DK13zg5r/cCMs5HYeXNTwm5w6cnHxoSP/+MrLdVegYGJ90/iG
 SBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773308869; x=1773913669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeiYm0hsHTBKVIxD27bpLm+Dsf8S28/DjpIEOpFWN5c=;
 b=jOHrpmHk7dPs2HGmROmEqkxjnVIBV0paphVCiAsWQnSiV//lIhfcddvEU1Oe1z6eN2
 79P4336SOqUiZytU1pXqUHOzSAr9uRaxLezOFnDZ8sd2lPem51ghd+o0KwnSV4TnJP5R
 oCJ4kqqm3ilp4LvTy0xzL8oNYt+kKKqFvdg0X/a/0jStWGmfrHFGQmFXexsbH7BWaDUr
 guqNIt/BKlQWE2yzbeRIvk17pcrLB38XQvaIZYFBzNs8fWRKljt7PscSWo/dKKTlID2o
 BA5oqw5HVBniijaVTSA2PeaMtlZH/heWGXauGT73aEE9grEFUOdOisPuMAxr1+0BhuTS
 hjkw==
X-Gm-Message-State: AOJu0YyGiswZ1R5kU0IHzcpoXLDBhadxoWP5y/gBpBJAM3jFR4dn75eB
 i3tEYHgzhZ2Roe7ywnikRNrpnzOWiuKwyYoOPWzAJshRg8dq97VSFl5/YJzsKrO5yq8/bmQOKOE
 +xuSNrnqvWjT199XbJkG+PBVVUigzmScPkBqCzFgITA==
X-Gm-Gg: ATEYQzxFijOhjMTIc/FEe+pAUQOnb/nFit+wJRS+lT95ahDbu2jyyF6Kk0fyTnqcfas
 +vXgO2w7o38LFJ0rrK0KBWGCNQzIU6/8mjoG3ADGQOPi2zOb4y+dopexggGiM4R2z3XZKOfx8WQ
 gunK74r2Si0G+Tm2NsbFZY4URqJHFkVLg0ffeYZfXwbLyjztLgW5SDKAO9rnXKxoAb8Xe6sWMn7
 penUSr+YW1hIXD/RaRjkeb2g/jNYoZmxAlDvB426B9dtJEOoDzJIUSkALRGzmclL2/20uLrHiRC
 Haxi9ZzfRr6NWAbCDlHmV2iYSjcIl2nMIVMx3PyIOKJdNwVNX+Pg+xQxIiHToIBhQ+g=
X-Received: by 2002:a05:690e:1a83:b0:64a:d3b2:d394 with SMTP id
 956f58d0204a3-64dc716c5e1mr1738911d50.26.1773308869323; Thu, 12 Mar 2026
 02:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 09:47:38 +0000
X-Gm-Features: AaiRm50v9fjhmA3750Dz5braL4uFNgMYdB2TE_cts6yAPcHWjWNcyIql35ugHY4
Message-ID: <CAFEAcA-FtvvZhgYJVHD+Btxjq4RXVdW88ysPhqTgOJPm7og25Q@mail.gmail.com>
Subject: Re: [PULL 00/16] gdbstub: Always infer base register index from GDB
 XML
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 11 Mar 2026 at 01:38, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce111711:
>
>   Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-03-10 13:32:30 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-gdbstub-20260310
>
> for you to fetch changes up to 6511d4eed79a7e59f03e661f31924277e4d6e600:
>
>   gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[] (2026-03-10 17:12:18 -0700)
>
> ----------------------------------------------------------------
> - [PATCH v4 00/16] gdbstub: Always infer base register index from GDB (=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-1-philmd@linaro.org
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

