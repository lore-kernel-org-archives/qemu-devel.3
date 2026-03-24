Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB49FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 21:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58vq-0000rG-J1; Tue, 24 Mar 2026 17:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1w58vm-0000qe-JK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 17:04:57 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1w58vl-0007lj-89
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 17:04:54 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50b6c45781aso190181cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 14:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774386291; cv=none;
 d=google.com; s=arc-20240605;
 b=YM0xvjRd1UbIZbNhWZq2IBrnmdof21iS61pJUogM30hD5n18+EeeyTsUArWLBoS6zC
 oxBF3wWxSHFSzb3LOuC0BdDICm4294yWi9Ps6VZ+jhbAzU8QDO02HYXv2GDV+ubBspJ/
 bA6aSPt51vkTIX7HBXE9u1k+YgC7ifgeYs5/VYx+9I+KYZAWL/PAquNJE0rkflYXOo3h
 wpUNuo92LttgcliNDqrQuMf/WT7w8YJ0c+UmVM6n9RDw/WU2B3YtpScGm50e2VzGitPk
 /hecmh0/6X5Mbzi/amthRDNoCaPQyEReS89+LZ3JiwKZEVskwIjStokpuYPgKxlzXS7P
 S9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6RmWdrwQ1QHLLnCBaFsIjIX76EfZ/m7DNlKu/8iTgg0=;
 fh=AdDKvCB2COk0IQjCNRDWO4HzvnkWk8VyvNAQUUtYmaM=;
 b=hRnyaihOcrLdGLZspNNxFW4S4ozCwdAlj+TNaFDkg1UqJl+oj3TU7KfX84KuayjZsq
 27SkJtW5II/mY/JfAcJoCtl3ZaLtzdS6r8MscftGFAS2vLT6yfHoJ9lnVKyiN6Q4h8Zt
 +rW/438jRRTa2DBCBq/VkUaqqUoNJBTscG2eKGmmSjFgT0rjfDE9tON/2ScHLX/6nOVf
 isvZGWI2YczeaCaZRw7cuIMWsOZRre2rgBAX2wyTm1AAFx+LXkpcWN87zo1xh8zzbB3c
 A0S9bgPDK122cmUV9fbhr77AzYcPNO44wFjosshgDKduP8ab7i44VXy7hX4OFO2aSD3G
 GpAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774386291; x=1774991091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RmWdrwQ1QHLLnCBaFsIjIX76EfZ/m7DNlKu/8iTgg0=;
 b=YJdHpVtzyw3RGks+ei39KdXUK6ZhxHQtjkAX69VlQayzuqLsmRRLhrKhBoW4IQyuD4
 gMgPjHJXaKf292X8tiq131oWAqcqXLasa1asKIi/DIOVA7w0BLbm2X/lYlF/M/Jfxi+G
 0BFi2ctTRKfwcRMBkehQ/25Q0cA4GhNefc3Wx2Kd+LE8qQ5H26ksWIohu6jsKD1OWlqF
 YqBquwTTsZGxtzr4iopG0teQQnbBSITAJVk1R2IUkhksGYgFDUlB+/SVREXPV2azUZPd
 epTs22O0BzgvmujzES2LE4Aw8Qj+9mn+52EkOk8yoGVMbd0N6bU6wcWEB/Fr7FrYSsDT
 fjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774386291; x=1774991091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6RmWdrwQ1QHLLnCBaFsIjIX76EfZ/m7DNlKu/8iTgg0=;
 b=mmqINmQdCweWE9Ma+/8xS8q43rEhth3I1g/QxMOQbIpp/5EBjrGYhkF5RLNoYI9ybg
 uw72ZqVTpvFHNMGhWGOK7PLnh1sGThb1adx84TaYpIuc90WqbxKSetBCJx4vmjKWTAhL
 HQ8z4czoEuIpuwUPm3W0ZGc58w2DfUgNgtl45ABYoL6+/xE9L47ScDDjJtPSSC0wuFzq
 NHua+p3sDBmZc51/THofAoliBjNOQWMvWYgKgtO4r38in/EwdzOhihqHU0V+0DmEnGbZ
 ryP4Slx8YNfwQQ6J+jvCyIFjUyDWARnYaao10MA9E49z5Qt3MzRhfnhNPe1h7HZGUuHU
 Z4IA==
X-Gm-Message-State: AOJu0Yz2f0pQaANLIvWrnUuBDPFT8LY2LLwNsoWIX/6LDqHCFw7hmKS7
 B0pX/z9MT/wW1zgltYXvKv3AiRLaYtD1ehGJBwF6XfKDRmGnH3jffAN9msjygNb9i1EyoPqA2ah
 KQnLwgPj2liQgUAmSBpg0WR+jMcRnsbRmclWFZXwA
X-Gm-Gg: ATEYQzyUCcqwlqd2iMErZQHCyJO40M0ePwKMhlHbhr8OghDMsy/B+K9DdNEhs2GjlUU
 zyFf2K/DTg+gKdAK1nSRgpcP2NOaB/83grXj4e883zTh0nns3R0iTumVHntzRHwWp4l/LeFWi6X
 /rB58NglwcATIOClfQhieKShP69wPz/X3FTkNcNdGH6LJmNUnKBAkBSTTlYJEEkvlsGG2/jilKS
 j5728SbTBLs0gB7IVInvhA/84HNgKOaCZ+Wn60RJQwlwuv17UulSJCRNX7qe0klPpDtl9qr2HLB
 e/+Vnv0Jx4Ch35tiAbP/viOU46kWXlYm3lOh
X-Received: by 2002:a05:622a:5147:b0:509:174d:3224 with SMTP id
 d75a77b69052e-50b83cf7c30mr1208171cf.11.1774386290653; Tue, 24 Mar 2026
 14:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260310235632.3987668-1-rkir@google.com>
In-Reply-To: <20260310235632.3987668-1-rkir@google.com>
From: Roman Kiryanov <rkir@google.com>
Date: Tue, 24 Mar 2026 14:04:39 -0700
X-Gm-Features: AQROBzColZX4_4jgk4LYUdDxegfKJ4aXbv-5ZfEnddylfcqk01bRIvoBZrL36bI
Message-ID: <CAOGAQeoFfo6SVew6rQEVUfjYMXXn8B_1TEvwzB44YaM_peZtVQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] virtio-snd: snapshot prep cleanups
To: philmd@linaro.org, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=rkir@google.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Mar 10, 2026 at 4:56=E2=80=AFPM Roman Kiryanov <rkir@google.com> wr=
ote:
> I am currently working on adding snapshot support for the virtio-snd devi=
ce.
>
> This patch series cleans up the internal PCM state ...

Hi everyone, just a quick ping on this cleanup series.

Let me know if anyone has had a chance to look over these patch series
or if there are any concerns.

Thanks, Roman

