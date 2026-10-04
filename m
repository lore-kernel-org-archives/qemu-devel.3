Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6D5CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOvp-0003TU-OB; Sun, 04 Oct 2026 12:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOvo-0003Sr-SD
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:19:20 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOvn-0001Oz-Fx
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:19:20 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8871ada1a26so6370197b3.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130758; cv=none;
 d=google.com; s=arc-20260327;
 b=PwOpmVkU1QuVvJtAMimZJW6+FOfrOGBNJPN/t0nxVFyVzYqCnbWqRc+b/PQbiN+J/p
 BAJ0VbbDXK8WkYAPFdhK8Sn92dHlJaRNENrI7AFoPJGr4vaSTw70jQfh8hitv5r34upW
 NhrKSVewa24+rvVPDy/i39ExLPG2E3viWU4pJLDNVy+GMcyYUYHR09gawullEXbxPH1A
 55STlFQdckAQOM0g+QHbGtsPCnun32/WW2vV+bg8toyhIT5qwnG7tZ+qzqC1n+gT5J2/
 8dAJ/Sy7xm2EbZY8CE1l08VrQIc0D5ZIRDD7LJpzzq1MFnLJBRjE5UEfg34lorlx2yIX
 fCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z2HZ+S2vidBmnG20BYhRJcN1NWxOOInvW9Vq3G95Kvw=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=FEC8NSDG+VikDK4oDCd6LT2Fc913xIkA531TxJWxAVSoTWLXVjiYOVPbyeJLCsRIyB
 pz7NR7AD5Jru/H1cnLLx9ZqNEi2mql+ObIKbbeGCgrul5TnAKOrx/4OdBuxPF8JPXLqO
 G607j9uwbOFiUSv0ryAGc3m0O0eSLKK0Cx0mqVkfVLXrFvIGRsZQfeJaoMlBCCB9Wo7D
 pNDRc68U3LmGIySvvTHjWP6vwYY4vGEBxnlQZjw6D1ECD4G31M4QPbTzlf+GtZEsPGrp
 u+MDTkIf9Wb9iifMunvnaG1OwDAqSmrYZ9r/yjAD/tSiVA6saSeQ3LoZ8buaEzqAOgMw
 0b/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130758; x=1791735558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z2HZ+S2vidBmnG20BYhRJcN1NWxOOInvW9Vq3G95Kvw=;
 b=kqLH5xFgJSBDzKCrIEk3n9T3pe8/DxGAkj7FgtC+mrquvQGnu7+nLBUtjAQIFpZIka
 jw4w46FiBB7lnUwvWGuwlbj2IjJK91QnRKpb0gbctGB4mxD6NL7ukm9OHIOFHf6paj5j
 rFz/biF5iepyexls9TSP6lagBzxUBwo5nG+N5TR1RiSjZjA9gDaew20EcKjIuwWZWFNe
 oMosLo4xqXNqe09tiuruUgHlBp2Bnh1p4gNlQQEIlDQb4Yh0BdVnnWn+xKcGH/jQQaF8
 Wz9PLX/1bYKcaRwpbHrpuBG6I/jPWXCuf6YmXIP1/NUEfg6TGymqbKtKO++mC24sx9xO
 ggjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130758; x=1791735558;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z2HZ+S2vidBmnG20BYhRJcN1NWxOOInvW9Vq3G95Kvw=;
 b=tG4njTorqrO00ClCXrfKHQHRKVE/bdjLUn69kk3StI5sKunNQU36tu1uMRQnizYvZZ
 jYYXMl0P7aO/iNz6ekuuI9uwH/lscCrKCp+MWayZWeIGCX4FSasNph2SmNITv6ODMD/C
 nQjnXDZ5kfGhF4Svogjbj6DDjr3Rbt8rF1XAibjv7s3sgaZsKTp8HQQerCgV1ARkba8n
 jBVglFi/ITB0Z3yLqAdQJoBMqXXgdrfLCfY0+KuL3VCPlKB+Ei0cdeP7iAKXu6gm0SLv
 MMaAkZVai9/kvsZup01SmPMZE4QHHVUFTFGMZZQPgPdG8woN1iuJteJU8B7oNIk/KEQD
 /Egw==
X-Gm-Message-State: AFq9FYJ7Tvy95XmOX8GzThH6cUBKwvZY33dw2aOxHX/xfa073+YBW/D/
 f+g1WHgH69FFH+uinZq8oYWaRiwq47Q+0QI3+a7nxySkxebr4pRRyhGDCW7Ct2dfvZijOswSJ5e
 DPePIQylntma2nYtL2JDpcPQxmkMxqWg=
X-Gm-Gg: AYBFou0M0urFIQy1QjGKlg44XgPtt6IhstmTRCfII2BhKk0poA/7ngBLjXYNpByL6DC
 IhkD9KdH7xS1IXWdmcfraNVhdgZfXT2DIp9o3qj+MJldNO60RBN0E82u+Bvys6zmoThBBcaeqig
 iJWe7NDMqxuvT+0CR9eqv5/q6C/9QJo7o+YV64pmDiAZaxIWMC296ITBRZeFKgMxG+6u+bpBEmD
 xTxi7asycppnrqhjIOez+BwxaWWp8cDPeXa1fwz8AYlMNVUTyWa2u6WiuQFwCZunSVqjwzNnQPB
 jh2bWvie9M4D0OziQkuRIAu6XapyKJXweWdh12i2dctyNXNYv1/NwEMcO0HrhQA78iRJUuYCIfc
 2Cescx9/ZYbF0LrI=
X-Received: by 2002:a05:690c:f13:b0:896:5874:6d0a with SMTP id
 00721157ae682-8ae94cdc320mr17071447b3.40.1791130758418; Sun, 04 Oct 2026
 09:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-18-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-18-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:19:06 +0800
X-Gm-Features: AclHuK9w3j5zSHmHvwUqjUZvrxzOSXZD8B2EwEDpu8qYbPL5_2y0VcrVvZXozv0
Message-ID: <CAEUhbmXB2K7B=W5C-MyCCZQr-Cb3s1C0wM5NUBVtSCd5ZphaMw@mail.gmail.com>
Subject: Re: [PATCH v2 17/30] Kconfig: Extract config IMX_AVIC from config IMX
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Oct 4, 2026 at 8:37=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_AVIC to eventually eliminate config IMX.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 2 ++
>  hw/intc/Kconfig     | 3 +++
>  hw/intc/meson.build | 3 ++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

