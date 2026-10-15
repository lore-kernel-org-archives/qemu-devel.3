Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852CACC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLEB-00013v-Ae; Thu, 15 Oct 2026 09:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHLE5-00011z-RV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:10:30 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHLE4-0003jl-7l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:10:29 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ac4806e210so37498147b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792069827; cv=none;
 d=google.com; s=arc-20260327;
 b=QF9TBloYed4sQnsvwp+BqNM07u13fNGAW1VBtoKEfDmfeUa9ejZ3BksIs7m3b8MG4j
 1/mMO1tzf60rTU5ngicIsJ1ukPO1STuwrBz5gSyM7Ww8EaAhEoJ63Mn1p3LAxJe3TTvw
 H6SF2HTHpfVghCzz0V9Eea8NWBANaBsZvl2k6E04R8EgX/Pua0Fg6k6lo6bhYPpgnJD+
 9AGUsv1pDBlTGSeJgkMpoJYcvzNdhst3rd11effRKYVodRdUUoPvNYy+unuu+Mdy0+Gh
 IuQloDOpxbao13bEOx9dOnDoOFdAC6F86EY51nC4A7lwSznTNy7rTRyqL036FsKpSWdn
 FrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qyZitC/l/N/bC1ZhIb3barLRtVwsOcUSPxwAi3cmdR4=;
 fh=zpl2ivaZaUiZaehzNBODl4resofFbSIiGtt/2SzFP/s=;
 b=r3ZG1EdHt7wvVXOhpdhe21pSZwA6I4xrmQXnb14xg2M+r1qm5oVFzELkNTaIF2Tid5
 d3+E/VLBg3TfexGGz769NrS0jA6u+s7QyI1OxWdSg5zWOpFy0WqDc8dsWeQ2I3MDEalB
 MjSLOy/pQZVVKhQWoB8QMfLRCHm7/YIul/BlWzmU/YtRUNE0U3YkVA4yxZABkFE6V92A
 Ix4EcZwt4CLw37d8RH1PiI5thCCYUVGTEsLeGNywo1bP+5EO5+urJKAXMm/9tKxnUOfq
 WJevX+eyeGpGJoJD9NTlezVYyucPA/oioBjgqVFRA0TIq/Sf2NH13boh4FBEqKe8utct
 /XhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792069827; x=1792674627; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qyZitC/l/N/bC1ZhIb3barLRtVwsOcUSPxwAi3cmdR4=;
 b=TEc9Ibhd+w29pGuJeHoCxuqxhYApgc9XGdSEod9nngv7f+nU7JV8//Ei+0DDzPKQ93
 MhCFkwmUISFuBRQhf/gOJxu3VPVc5YebkN8vS44o2ZjpGwNewwxCS6fIZ+u3lPVN3vJl
 QW0eczkLTwPb7nJZ1gPmqqfpNUBVtOstQA5p9yDV2yyJrqXoBr1RhVjvK/a75CjHa/gg
 H6BEPiZqW8gsp/LICZ32NMPcyxW0csRTL7NFW3Gj9OFCljrSEFfKCoW4b8281f5bfFsm
 GFExinaYI666uVvQMf2pGvvnTTWtO4r2PqqgYIPnV73gZ4gZZPnXvCYXugcAi5vghJnB
 o5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069827; x=1792674627;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qyZitC/l/N/bC1ZhIb3barLRtVwsOcUSPxwAi3cmdR4=;
 b=nwp9nLxALIpY7LYxbWlZ3e2HdhCTJnQrWgyNtj+JI7/5s8hIuCKFUdZAWTaG/R90ma
 Mt0vIhzYnz3CTrDaXsxP87mNPJw84l9JnDvvXIm4At+cybmtUySIvF+dttBa4jhdSWuT
 4XHzAT5wbbEoi1hP/sTbRAwPZdbgcQNHWETQuMYmfkYkQoMZgu7zqCSps9A2ajRUzCBn
 dTpGc9dg4WMiV6RzFoq0fHg7QLzqGTtmpYi0Y5rldm4QQPW3dZo8UuGsPz35+3SPVw02
 VALAex3kzBIgG2169GdzuRuhgwF6KGXYUoHnNlJgs9U3UfXoU8ycN28248Knre7o5nZC
 J6iQ==
X-Gm-Message-State: AFq9FYIQRbpu5MtCX3GT2YiNvhwuuR3MqPU6w9h+JI1j6qrSQBji9wIu
 1j6JZXpdmFBRlIX6R9Wl1BmsbcmueFGUVO23BtzVpUJZz32Ba+NPh734Fel81pdCbILjO/PGWQy
 6DxNi785KY9t3uv3e9SKASyULeLqknjZgyG1+oY1ivA==
X-Gm-Gg: AYBFou2wn94Gaxh0Nbl9RhtjwMADC3tQUtxsRibynTxq+2RcXkxEvEzZAZW+j2eb5aX
 dKtM8DqiLHVh5Xjj1GocRd3sxMOjQ82//dxTBpJ4LD8dMEOrezio1ih6QgLyZYBprhc1bvbmJDi
 hSLd1V5a7yFao8V5dVwnn/vKHO2Cnf2B8RNpDAe1lnV0csUalMOZMcVYFCapIgbvMgOWFJLgHfM
 cebOiowT98Q0eJImGCaAsgQofegfIkUEQ8DGAeOTwEmKrcqkIN++VtzSiHVVIdxdc+0qrAynNCG
 Y+u4rRrZcp8I3zW5yI7ScRFIuWOIQtvTkuZf58IQ+k5yxSw6GQcFLhRq1awFATuwZPIMrBYtM8C
 vl3scMV4qWUX2ZH3/cuJ4TrSHq3ZdNHLkClkyPMY=
X-Received: by 2002:a05:690c:d8c:b0:866:7724:3bcd with SMTP id
 00721157ae682-8b07ed1e667mr84520857b3.16.1792069826503; Thu, 15 Oct 2026
 06:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
 <20260923210956.52940-1-marcelomanzo@gmail.com>
In-Reply-To: <20260923210956.52940-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 14:10:14 +0100
X-Gm-Features: AclHuK-C8YX7MVoxjMcMUKV7nzmKM81fNjgM8uAnDYg3SCmj27FnJswyIckI5zg
Message-ID: <CAFEAcA--SNTzsha0GnKuL47gLy6RS3Df26TdAV7LR3hEiGR6DA@mail.gmail.com>
Subject: Re: [PATCH 0/5] hw/arm/raspi4b: RNG200 and thermal sensor
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 23 Sept 2026 at 22:09, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Hi Peter,
>
> Gentle ping on this one too -- it's been about eight weeks with no
> review yet. Happy to rebase/resend if anything's gone stale in the
> meantime, just let me know.

I'm afraid I have very little time for review of patchseries
which are board/SoC model these days, hence the delay. (If
anybody else cares to review series I'm happy to pick them up.)
Anyway, I reviewed this one; comments all minor, but it doesn't
apply to current head-of-git so will want a rebase I guess.

thanks
-- PMM

