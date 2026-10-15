Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5DECC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMs7-0001zx-Fh; Thu, 15 Oct 2026 10:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHMs4-0001zj-S7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:55:53 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHMry-0008U5-CO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:55:52 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c2e69aa07c3so338969066b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792076143; x=1792680943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=noRSiHlaVgNWp5wrlwCc4SFj4riuto5Ddi8kaCFHJuY=;
 b=NiSoYNJhMcSN3fYlxhIrQwYtMPoJh0n38oSyLt4l/zBX/w9kVX3ysmhe8pSDet5b0j
 igX6cYxX9hfAwiv5tX+xgxwwt2tIlmQ8f5obXyB5vpXLlXPkCp6TX3QqR/0a+k1YTcbz
 9wUMm651WJUxK2iESXO9tDSn7MEJw8JINTHEJrj9q0qfOsN0QOdBCht00/JX/meiPXh7
 4B8ckae8b0AOffDyW0NoWNi+PRwGB3lOyIl4ZsI8Se8J7H1TfYYvNyEhWtMyLoW5DQRS
 w+JN2a44W+65Sobuss1kUIXjM//seiXu7QSywPls5553CLjHANzOiKB0PLnQMkxNx4vI
 0VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792076143; x=1792680943;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=noRSiHlaVgNWp5wrlwCc4SFj4riuto5Ddi8kaCFHJuY=;
 b=jN+7UAUyOSajF+TVGmSrvj6JSSfm3BzIs/XaSm9sMUvCEpNptYWLFRnDKR6mX8SNmj
 GWXomwfZ4bWayHIbvQe+hZJJFVdBfLZIW6/J7fk6eGPlFWGvTP/1tgldKdhTQ/HrWmvr
 Rd2hpuZji1az4i6Dz7StpP5Fx+ED5rBR7YgHrIvuiBXh7sinTpiaQqAJNSx+p1+dPiqw
 69Xh9WcF/nvLiQV5bTMZ30mR1uZtDaSLE+xt0fBXEavcXaFSxI2t/EveoMbLzge9oEWl
 1ejguI4pqz+sDmFVfc0jaNxJohsJtXKbTP0KJ49G6ryms+994IGSQrSn3E5Z/EM7pDWD
 eKKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzixCtrU9lO6BycexiwP/8cCLQ5SDt+zpBEscUym2f4KS+yyoIjtyvgkZi0qdAi74bvVOgfbRbbNfu8@nongnu.org
X-Gm-Message-State: AFq9FYLYTxgDiFKOb0TCVtHZjv3vMth4Xl3jjf1peWBb58E4gsFutyjm
 YVhjiu1D3T72qvvOPZrYoIiPnIGRSpIX383p37OpUz7/cjqzNK5c8ogmBbPldI+5RoU=
X-Gm-Gg: AYBFou219o0Hu04l89vS14rGrJ0/qCUrMwFXZDYHYXA4EwFnSGJymlORxTknDNYt+8S
 PcKZ64TXeznWc5rI2SoLkt1HhFXEBTpqZJvKaceCdgIf9gfflh8wT6EO7FBRV25RhoZWr1WOJrX
 R9oPfgEoUJJ4y/FV/L16sV86v6UWzx477FJuWG4x7/2zUlXHsK0lLtpkCE2cIekQTts7TBCKjQy
 UjMHCIIzIGlGTeako93OCzpnr26gdK8PGEMVfIiocnsg3Q8fCD2ZEwF4yEQ2EBgxUnlhaa8coLh
 vepZLB0/Wzn3umPkbuheCDjevLdNJEDp+qgFsE/43MDkcRm+3WX/zBvYMxM86eDtM0wOPHu/8Nx
 /k+B4PqTqai3bvlnc2NSF+CUvoiO5AnVjmT289kqXlQgZjaj0nBEACi90IZJmC+kJIaKG28we28
 WmmQ7LSQcScxvC8wn+GtxmOFYlH85hynke1AcjTYblIFMMqjfAMn1u+6qJZifoHtUoMOEIiWmC3
 wvPh8WN23FKHtX5Di+DbLYLnBCo6aXWcd+y3TZWee4mnbDiVq0LfO5Dj8G4zMP56iKKpM4TmpT/
 k+tIsuHIU1SMq995xp5MtxEtTUmYDchuirHXlwzDKbCXXZqI8ekeFw==
X-Received: by 2002:a17:907:3f8d:b0:c29:6191:44ea with SMTP id
 a640c23a62f3a-c31a9ff4935mr1766463266b.12.1792076141804; 
 Thu, 15 Oct 2026 07:55:41 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860?
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed9b3ec90sm138655066b.41.2026.10.15.07.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 07:55:41 -0700 (PDT)
Message-ID: <a41b0196-cfa3-49e4-84cf-a6d654b916c3@linaro.org>
Date: Thu, 15 Oct 2026 16:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20261015122055.888209-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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

On 10/15/26 14:20, Cédric Le Goater wrote:
> The following changes since commit d5b5083cb783c447001e862c2b525e59f48ad78c:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-15 11:53:41 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20261015
> 
> for you to fetch changes up to 2240c14c16dfc6c3b9840677f0d153165af7d4ee:
> 
>    vfio/migration: Don't reset a device on a declined stop transition (2026-10-15 13:15:24 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fix UBSAN shift error in MTRR mask computation on AMD EPYC with 52
>    physical address bits
> * Add Fixes: tag validation to checkpatch
> * Reject virtio-net failover during vfio-user init
> * Sanitize DBUF_CTL POWER_STATE for iGPU passthrough, fixing display
>    corruption on first boot
> * Thread vf-token through iommufd bind
> * Make MTL/ARL guests fall back to BAR-based framebuffer access in
>    passthrough
> * Update igd-assign.txt for Intel MTL and newer platforms
> * Don't reset a VFIO device on a declined stop transition

Applied, thanks.

r~

