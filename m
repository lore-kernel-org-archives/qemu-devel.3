Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B8BCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOWk-0003zH-DJ; Sun, 04 Oct 2026 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOWi-0003yS-Gx
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:53:24 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOWg-0007uf-Qi
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:53:23 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso5835607b3.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791129201; cv=none;
 d=google.com; s=arc-20260327;
 b=htP8bnIvRM0DajVcByKw7dkNClH5FW0PCQu+L8OIM6PpRPyhrY/5MaKQ8Qg0R8mzRO
 /WHh+sWkDvNp5hK7SYAK0rDlf50PMk2rOBcX1WNQsJR+Q1s//Nm7fOBgDn83+Gm/uLCv
 vwwfGbOmtNHaxRKroi1nYx7l+coYkau3CAIt6KavblQRqYsZn3Izi4mhgdcE5FR0rFGH
 Y5KXRiaemw7mtRuovkC+Islz+PiTllB4nNYiHkjMarkR6TbkXVEKjQQMiD+kySJByPXz
 d4afwaYy6jNNkbBEVjaRT8hxqfc5geK2jyJJ6+VcwAZ2f94gE2srCYbPIWKpmCRHFwp/
 KozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FeEbyMHkwmXzDovflUJ+i0Q0NQy/p4VCmcG47ied77o=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=UFAEX7LaFr4j3RlHDJwR+ey30jHAT3ZWfUHc+UikIYey6pmvl21g4DmkHbNMLIb/Lo
 VluFPef6AHl0QMTO+IPvHnFPDzzPCUC73C0DlVkQp+UNrIMfxplHlto2rBRQh+DV401J
 W//p1F3iSDI6eGquSTYZOvP1nSI6rp8vUp7UyhFQ0NTRmwHvuWabwDQwR+y6l/03G5xs
 v+d0ZlhB0iqtMgbpTUAOp6JJEIv42xWJU/mpZdTKhyAe1+nYhOGgPWeJmvqe3EHt5P1+
 hRYj8SvCub9U8LNH+7VaeqBwfRelHyfcqozZ1J6B80TCQeiMh9+uFzFaQj6epReHXJJD
 K0yA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791129201; x=1791734001; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FeEbyMHkwmXzDovflUJ+i0Q0NQy/p4VCmcG47ied77o=;
 b=FQHDVXiUg73HUj6+t2PiGX2S+7cUnY82/j0M0MnCKfUpvBR3g4iDso7LiYz2TSnm4C
 GDL0hBm1yknzcnTcBAqO88wlThU34LGZ3THaNspHBw2g29K5rp1/45+zwUhN+Ur5fYjK
 LQx6wqHEL074QSbfl9GPJCd+sXjOr35ruV650hkEyw8CcGoVGuBWwubKbzamcAGAAs7H
 E0d14yb9ky8p4QA/oh2sFfKdFio5iUAGRY/r9su1Xgv69yLlBPYRRgDJgKPuZkiELGo7
 i9f9EizlrN86ghikCX0+5II/NMw+ovhWI71i3EcUiVi/5n1dRR4ht4Z/6BcPFSM0FJHd
 yAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791129201; x=1791734001;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FeEbyMHkwmXzDovflUJ+i0Q0NQy/p4VCmcG47ied77o=;
 b=mujBgQLSfjoutPCsm1EUMmGidfPHEUsm04ZM7JHio5zuQK2ok31uzZ4Sv+xctFYcxr
 CDPAIMcXYLIIZQOnRj3FZz37r6kpF4lScmLjbPjl+pZeAX5N0moQF1Cm1rIcpZwlUsyh
 O+8edV7/dddpvXZFxjWr0yrdVqqIwTSelfV13W4R2SpFXRq/L5A/qCMtPwSsAxb73DNu
 GmALZPlCje4Jzvw8+34+Ugrb7+IsY+yjfZAC9KDu7ggZ8r3Zbb8IIIZWOJmbumNtAsns
 Jt9kMmy+Zf+nkY3KAw6aJLXXDUAQX3TTkd9JViaFmnlO3OJFSvmZIoMftP7v8vl1mv7V
 1Njg==
X-Gm-Message-State: AFq9FYI93BZE0+vktm0y0kdbBtb6dLbZ0PGXUG/ylrVYLBAYt+O+mQBF
 qvfyiMAzXzXG5T6zxIyQmi9a215Zh26ZWYyPI6JmEYgy4pb0P9BDaDuNa+ZQQ8YNIFExlhdmtvF
 SvRsFywr7dmErhluiH5nIsQAOh7tbTxs=
X-Gm-Gg: AYBFou0gUynQkyZ7fnW+kUm9Sc8RTg0VUoQH7pp3skbh0SIMQEv3YoymJF2mMKElITX
 o5UD6cXJ03GNm9U6JuOOGZFNrauAezWCa3nvxvLpmY5ekffWsX3Bxeb2xKRowS+qdALVu0lZfPN
 SavuOnMIfUQ5NjElC2o2Da1UvuOyvSjaxfGhZh4edTtmje7lfF0dCawXTPIkkxHr+mQhqd9hq59
 2QguvQW257tCo33rqRxJWa0lb5VfoXlskHHCDIvlGaMxo68xgKjmTVgQmjd6uQrPJFDuV2Ujyg8
 MwPgCeGvlmtsRY23j3r+AKCYKXJoeJKtXd39aVOgKMiGpI8bpiIvBa+b+jsmyAxlLtfGpwFeE3Q
 Asqh8Ye8mLPOauelCg2j8wghF5g==
X-Received: by 2002:a05:690c:6d84:b0:8ab:3b98:5a30 with SMTP id
 00721157ae682-8acdaf466f2mr36731357b3.33.1791129201582; Sun, 04 Oct 2026
 08:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-10-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-10-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:53:08 +0800
X-Gm-Features: AclHuK8Rz-PMMKlpHymm_QudP_fkSO9zoG5lHPFwvuZ7eI-crbglCO8rQClc9dY
Message-ID: <CAEUhbmWdOG6Zf2Qwyr=wdp+X8PepMWP4ZdveR8DCcSb_KE9W_w@mail.gmail.com>
Subject: Re: [PATCH v2 09/30] hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of
 RAM by default
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112a.google.com
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

On Sun, Oct 4, 2026 at 8:28=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Having two CPUs and 1 GiB of RAM matches real hardware. Fix the machine
> defaults to make its use more ergonomic and less error-prone.
>
> To reproduce the old default behavior for e.g. migration purposes,
> `-smp 1 -m 128M` needs to be passed on the command line.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/mcimx7d-sabre.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

