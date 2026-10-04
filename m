Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B3DCA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOzH-0007Bp-84; Sun, 04 Oct 2026 12:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOzE-00074a-UV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:22:53 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOzC-0001py-Cf
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:22:52 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-677c9e8ddb2so638957d50.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130969; cv=none;
 d=google.com; s=arc-20260327;
 b=CHWTyB6fdsjk1DpiRlq9qQtuQxucOIapEdcX40Ma5A8VU7zTcJZTB2lHPdVotrCTL8
 DmbXe6ETUXFzIe96BRWKep/ysTxA5lBM4WTEhJZbILM6AEb45aiqivZZmNztgnkHXOVM
 fTG3+mNvfAp1Z2wjbkvxwoaRaw1/nAPl9a1nlGeRpseWRaygYRD6PZ+Gqxy//1sHblDK
 dU/QqUgSMRJlfF45br4o+7cNdg09LazAlWt9KGf1fOeoygHjK1upveaStV9cNYirffn4
 DJ0YAvnkTHBJhPfyOd4GfCImRy1e54uejQDVH5YFX4RkZDslBeVKx9V+n0p/Y7GnhI7o
 kuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L+N1X8BTJKFHlx9caZ3JGGI0FfQyQ9m115DLT2DuTVg=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=DTjwQtFC9Calk+bCltGdCpbmIkopdFdkjpkJn0SdmvO1sqdrkwBtk2s3PVH4K/r5vK
 Tw/vi0XASFtD/Vxu5BjKlLhxWpvI0EhnirskyEqplDyhWSO2Nh2IT9kWLl1A9jilwrht
 odRjwUncU0FYvVMLq5+z0khnKcL7dxjQKHshdmEWcGoW8821dPaRKxiWGQIfn7NL+yMw
 mZNyDJIAkhX2HJdGUhU8sOOxtqAa8A9/lhIPGhWEhzuLYcQebNz8LW7IdCnSNq99dtoj
 GLH9GjPiv+ZgC3MHkFM26t2+GGJtoaX25JKz78gYfPRQSzPVxp3CC00RN/Yh4g4PtM98
 3YAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130969; x=1791735769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L+N1X8BTJKFHlx9caZ3JGGI0FfQyQ9m115DLT2DuTVg=;
 b=bEHam8wQYd/75rZt+BEerahBLHQ8Y8t/b16iQzP7rQfcmZ5s1TLi5KDF15L4XN5+3M
 CZmPF8pxkLaBJs4ud8wExfuKAJGuETEtvwEWdl4NoS+hWiMrV7g2tud/v1lb9KqRv5Gw
 1EJfwsa3wY5gGCtUJbW9XTgKHgTXtvBJmsCfHY6NBPi+qjj+vuVC9K9Jcu38mSEB5vN9
 i3R+gaaqv+gqqXt4jQTqE8bYzZFQHul/wJfsIOsAEZaGla089r+3ngvzLFHe3CWPmXWx
 Vt8JN3xGJQ/pqF6bSe/Zfm1z9KFwmwI8DwHfwpFMDIbRmoHhd42EG5lkP0wFtzAIradr
 Yd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130969; x=1791735769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L+N1X8BTJKFHlx9caZ3JGGI0FfQyQ9m115DLT2DuTVg=;
 b=mFAl60WksSZay+hk3S892iSYNzzOrYaRaMKWXe57lGEwsh88Xts5dNikcTFjs183KP
 jbWBTIb8AmL8PSY1SO/JfRRDA/eHwtqyYvkPXPXrbzOtNnVu1rG46Iq60D0njetpbilB
 Cj+RXC8UownVzMxRkBphAUud0cJHHCez+ooBklp6IH99h9BMDnnw2636DHbnjegK9VTv
 HN060gIbrXZaEk9edyXdidURuvG1b2mqWwyD1jMtcYfx+OzXwypwEuo54HXHzJVvdKnS
 NQ1Jh6g4wlUlGxjUV7o7k64lTQHKERD7RogA858r/2WacEFOtbCCLQLVE8J91GfvamZD
 8uig==
X-Gm-Message-State: AFq9FYLb8IAY9flgfepOnCNKSj9nnuQackka0NNyuN4zlm0PkRv1IL18
 CSa3a6C+P4UQchbmwXyQoH/9t+lWNyMpkOTrYJgNLU6xvxtMO1B0TWHEdSEc0p11PYDSOYL7oK1
 LMWSqInlzrPrxCx0xavtxv5vubVMHwjQ=
X-Gm-Gg: AYBFou3/joFRxrQH2g2CGJy1jdaxvflWyKjDzZblwOE+bduYQolAwsSd7AEdOx6sTKd
 3tu/4/H7rJeSMR5/iBRkdY6AWbKwjzFLK0g8e7P5hVgPyMRvbeiHq4u0QA9p6UlbTiV9Dq/m+VD
 axqzqEP2XJPziGhAGGkX/PFz9Qz8UmyuxClRIp62N2ZHkuuRMsIesAnSPu70rr5dSbUhUS/q2Zw
 ZfWhXmiz9NB3J9ltDyGuajpqXxCzDqOUYQVXNOzsziH8MakcdkNIB+qcQkxmLBRwGxEpYmlPD4l
 /GePZyh1+jnEXFV5ZcfHRCwPbtDeLLEEdv87SY6qBgP5AdIokRNCnvDBI7crrvvaAI/G+Vbh523
 o71kY7HT+DLMaSLs=
X-Received: by 2002:a05:690c:4d49:b0:8ac:46ff:d3a5 with SMTP id
 00721157ae682-8ae959d6dc1mr19927047b3.64.1791130969121; Sun, 04 Oct 2026
 09:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-24-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-24-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:22:37 +0800
X-Gm-Features: AclHuK99SNiRb3d2n1rEYSyq6bhc7zyznBfY4kdJ_uguXYAwQ1A62YwBXE0MTqg
Message-ID: <CAEUhbmXHBbhOBecE_nLkOC+2eREsZ=giafzuH7dNQk=YGFF8VQ@mail.gmail.com>
Subject: Re: [PATCH v2 23/30] Kconfig: Extract dedicated config FSL_IMXx_CCM
 from config IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:33=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> SoC-specific config FSL_IMXx_CCM to eventually eliminate config IMX.
>
> Note that config IMX_CCM represents a base class for i.MX clock
> control modules which is used in i.MX timers and FlexCAN.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      |  5 +++++
>  hw/misc/Kconfig     | 25 +++++++++++++++++++++++++
>  hw/misc/meson.build | 14 ++++++--------
>  hw/net/Kconfig      |  2 +-
>  4 files changed, 37 insertions(+), 9 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

