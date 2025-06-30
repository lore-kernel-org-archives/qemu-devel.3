Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D52C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGNm-0007oK-IL; Mon, 30 Jun 2025 11:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGNl-0007n7-Gj
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:25:21 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGNg-0007xb-Nz
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:25:21 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-714067ecea3so17227347b3.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297112; x=1751901912; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I5h/4tT6uYWyspNT7UisC2lRP7Ask7OpjyLTLtPE4HQ=;
 b=H35zuNXyN6Iwwlljy94N26bQ110Cu4/3GV5otu5gbNs3fYJioy3JJUp85BUNFk6phY
 2PxAiOqamPtPtYNAXWh4AfkC5hUx1nhsX6sJCG4bfs2e8WZVSpvJ20O2j/rZDy2tn39V
 tziRG7b0hhrbxWIpRNEpFB3NB3dzRGkdFsZXHxUgdmTbk2EadSzJzj9q/H8uwHVf2Ahd
 93AzNbmoek+c6RAMfkSquaYq/S7x1j0hJ2cXh4NGS47+nX8rRCiOpajkKvhuhC6EjXdf
 OKQYMjsHsFYp3wOgxyrxO3HT3yBou8k1z6o5oahkZjGnW6vTYEYyYtXtxZjSa6vAw9iC
 Wrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297112; x=1751901912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5h/4tT6uYWyspNT7UisC2lRP7Ask7OpjyLTLtPE4HQ=;
 b=Xz6PjYM/W+2Sc9N33G2T0c0sVB+AeRyliPj/xVqiijtJLIGM6jveLYvn1J5qtfmOsc
 Ca1AiIdOue2JiNkMdITt70/eqMuW8tUArg2qG6hDlOeAcRo3Kmbm75GjrvdTFn5OVwiq
 xlzHvTvMnD1DVjgAStkM0CEAbBkCaMb8bBd4cE8f5y8fM3mMZw0V8bFmlgVrlgdagZFh
 yyGAOyY5mnnAbSTTMu10g8PHKip+ilUBt2sTviaeiEQA0JnCz+gTgAj2HAqAb22BG0gM
 P21ruaY3S0oHkyrztm6aG1gXm94szV0xHCX62XAly1BkyEyMLqePj6dJ1IvsVnNgcgQo
 7CCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVguKrxYhf2kP7AIyN92+xH+7spCroT4nbd8Ai5FlmHl9gfm1C+1kF/hsSH0mLSib2yToGwUN0BgVvl@nongnu.org
X-Gm-Message-State: AOJu0YwpIFIITpUwI+aK703KL5/6xN4AhMCpZaxim7Lk5mO75Y5bopqm
 ZlF/urvFlcFUqFfcdz/WmBhMpQnAwcTjwvp6zJ3PSdMqMNEFrCKeDjBgQVbBbc0pDomAUzLoxbu
 ahPwbaMbCtkruV2dEFc2BK0l8GZvP8eZq/Ktl0I2hMg==
X-Gm-Gg: ASbGncueHqptvoaHCAOoqG9LFBXGN98HNjluw8AB0NBTDeYyJ/ZD8gx0iR2Kv1dljhO
 JIENtRyHncgDdBWjD4vfMSTQc/7kQDm0MpBc+8aXzwxMlQR/gYnWYg9Jk25YXaXfhEzdtOqO081
 nmXsgDowT2+G2RrejGX02tnyzEdMBm+UK1doc63TDRVN5N
X-Google-Smtp-Source: AGHT+IHbDKkB+v2UqZI/qbpQTn8DDgm/V9SQW5oPnLxD8oZI4VSXOLZFRxjLJnIc+/ugHtVSQMvSaqZsLIPCSyZdD+4=
X-Received: by 2002:a05:690c:dc9:b0:70e:142d:9c52 with SMTP id
 00721157ae682-7151719cf61mr215756077b3.22.1751297111869; Mon, 30 Jun 2025
 08:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250617153931.1330449-1-cohuck@redhat.com>
In-Reply-To: <20250617153931.1330449-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 16:25:00 +0100
X-Gm-Features: Ac12FXw50PpiOmK56GCGuI5ZjfhKrVyyA1XeCo2Esd3LtbqKHdL_R1y58yMuILw
Message-ID: <CAFEAcA-Zuqzqg_qUQh+yT4BGqEke3=OhSr0iSY1ztPtVV506sw@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] arm: rework id register storage
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 17 Jun 2025 at 16:39, Cornelia Huck <cohuck@redhat.com> wrote:
>
> Mostly addressed Peter's feedback:
> - make sure every inbetween stage compiles (also fixed some bonus issues)
> - try to make the scripts more robust, add a note the generated file,
>   and make sure to grab only registers we actually want
>   - I did a half-hearted attempt to use python instead of awk, but I'm
>     out of my depth, especially with the script that will be used for
>     the register fields in the cpu models series
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v8

The script seems to be creating array entries for some registers
it should not still; I've left comments on that patch.

I've taken patches 1-11 and 14 into target-arm.next so you don't
have to keep rebasing them.

thanks
-- PMM

