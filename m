Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73226103E2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Tdz-0005PF-GF; Wed, 11 Mar 2026 20:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Tdx-0005Nv-7v
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:11:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Tdt-0004su-V4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:11:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-660dcafc85aso689161a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773274264; cv=none;
 d=google.com; s=arc-20240605;
 b=Mfj6PB12gQq9av6muV0OMDjbHyzDupfZPFGxSkwd2wjSqGk0gJS7Enug/QREfzV26e
 lsp4/s0XARKEDMmuzbXxT6X5PAuOawXKFIUN87NaNTRTjtodusYs7g50UzifCGt2hoL7
 HjauWvatP/2mwKvpVhQRfQ8+b9lkToTy/6e6Uo4O/AWTSS0nha6ZPCfWzvJw1FbBfd0Z
 L1ocPwmz5YR/Ars8vn3JtqSI+Bw7XUWvL8PCt04FaRDmis0FTryflDjzIa0qX5OfkzLe
 C4eZocJfhawRLnyoK8N2Te2oYXSHDan7+p/+Z3NTSqILcob4EwoPELPps2viwuCYDmqO
 NOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RyBZIvi2roCswENSeuAcdbWNi0LvlrH1oIcE1hKGhDc=;
 fh=wJKQ9etEysIyMramQhK8ClQRKxxM7VWzpBl+awXU4II=;
 b=A9L3Y0ym7V5Um+sunoSLpPKsm6IyH85d0YLwYuudQ94nKoHazVFJ++AclhYDpDOhup
 3ku+w2SYrZa//fDYO8eDP1+e0nBNNBxVke18B68tNdyvSIan2ldrdupY7JkjpIQMyrnm
 S/0cSPu1ehG24VBTiv1ERc4SbaDqs6vaiD2TCyPD63BuZA53W7nsbwkTlmHOCSWWuZ/o
 vYZPLRjJGj0DpBojBlfqzWU3dlHghPfA/OLOMrybXzFiKsUlUoNmesjjp7QMRzgiDzOQ
 5cUGwd5wis1mFc14a51xCw+QENr/te/LADKoHtW+nU+dCVr51rolpVIptKm15+AAe97K
 jQKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773274264; x=1773879064; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyBZIvi2roCswENSeuAcdbWNi0LvlrH1oIcE1hKGhDc=;
 b=mlgy4famjPLMYggrZaRgI3JOzrrAPXctMfiCMp7N/AVQx9O95qZvMJoPz06jUmJH5a
 kj9W1kVB5hYa2t/B7zLDeSBF89YQSbA2rUf2CKKFUxPXDGXQZqVUn10inb8x2VVoRwSj
 X1yinmKp3zifR0nJH8dJ9A5Ys4M0bHPBCyatex57T74ziX7/7JYM7G7E4AojBEfNgRKA
 br6pGBNrCzrlhkiKNPQJvGeRde/BPQFJIS3FOcwwz/TWVFo6ZEKkzEAraCmnFacFadfJ
 E7rctkHb4AVkzUfPHB9VAr83CcFo69Sco38G0ew7pZ96JPsmjzLaqYPlGBoJhu4yBgKp
 BqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773274264; x=1773879064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RyBZIvi2roCswENSeuAcdbWNi0LvlrH1oIcE1hKGhDc=;
 b=YaP1uN1kpl+5lHA7hPBNPlG6cuc2+pt2X5gElh8RLwG4hjjoCTOzuQLkJhmMhMtoHv
 OxG+YxoFi3PPtDmkVvlEmsSi/n1vNwlHKCfsPuFalNiweVxZSz/Y4716aWXoP+1bBVS2
 7bCcW8QEe2JBZ4SNy3w3j1h+dGyyFajqy7uOsTdb/B3WY+hP3t7ZJOWNV8087Zw+cEWS
 ALnS4P2VxI7KHqXaBVQDfOx84ZBCM8qzE4103d5UJfHJ5Urp1oV0iQZ9iegtWvzk4KpD
 KFcWh+wRVuU0eUjtF2RZhj+NEmtukLSt3dzuN9z3Jj09d2eISFleaaEEx3LBtOEjuoLX
 d9Mw==
X-Gm-Message-State: AOJu0YzfH5HSae76a+zbcZswO3T9Gze6AhQ0HoaiDCgy1132+HiEXiv5
 9TrcBqQVTkioO8aKm0QVutbSK1rDKeTa9rUkYsFKA5LZL+TuNj9NlpFWMvp9jK4vnAGqf4eekiC
 BDMv8VkEUrXhR4pqhFula24IbvKfKUmA=
X-Gm-Gg: ATEYQzwI28uHrogpHdID3pAI5rjB7obORYHIP53YBvwqI3CqbjSvi44HhCcioxlWCkZ
 BXEfYOt0jMpY7DmVN07Rkn1MUjUmfmW/txupefNfyi6hGRPLY3OJnc1zbi6fI4Lmau/8D7AUY+p
 k37IhvSjVjBoyoQgJxosnrNv+O6sXtoEGXKwnupK1Kl7yHyIdqCam3V313hQ6pfATB5LY4P1bUF
 VO/SckVOLByyyC/iLxZRt528QwbkdISCWzpZTlvZlHU9L6E3TdqnMBJc6C8296XKFlyjn+8i8Gw
 e6kwOMNwAyiyVcM9h2rd3ihFiPrk9qQk94BUoc5yUTFkD44T
X-Received: by 2002:a05:6402:4312:b0:662:e097:6a0d with SMTP id
 4fb4d7f45d1cf-66319ab512dmr2087587a12.14.1773274264073; Wed, 11 Mar 2026
 17:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251209160117.1239596-1-frank.chang@sifive.com>
 <CAE_xrPjvVPqamRqsaqtuvPj930endqTcxRwknY-0_L8FQ_O9bQ@mail.gmail.com>
 <CAE_xrPiutr4Px6yTvf51Rn19-jSFnpBs4sQiKG0OjG+72Xj4qg@mail.gmail.com>
In-Reply-To: <CAE_xrPiutr4Px6yTvf51Rn19-jSFnpBs4sQiKG0OjG+72Xj4qg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 10:10:36 +1000
X-Gm-Features: AaiRm50fSUGqzC8bfkVpshxdE4X7Yo485BCeM9M_ZeE5bM6LdO_MBEqRtIBFpHs
Message-ID: <CAKmqyKM2++LhEGV9BAsnqzmQOipbR3AD-M1qApPAj5AZRcc51w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix SiFive UART spurious IRQ issue and misc updates
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Mar 11, 2026 at 12:30=E2=80=AFPM Frank Chang <frank.chang@sifive.co=
m> wrote:
>
> Gentle ping.

Hey,

Sorry about this but I lost these patches and the ones from the other
series you sent that I haven't responded to. Do you mind sending a new
version?

Alistair

>
> Thanks~
>
> On Mon, Jan 19, 2026 at 4:13=E2=80=AFPM Frank Chang <frank.chang@sifive.c=
om> wrote:
>>
>> Sorry, the title should be: "[PATCH v2 0/4] Fix SiFive UART spurious IRQ=
 issue and misc updates" instead.
>>
>> ping
>>
>> Regards,
>> Frank Chang
>>
>> On Wed, Dec 10, 2025 at 12:01=E2=80=AFAM <frank.chang@sifive.com> wrote:
>>>
>>> From: Frank Chang <frank.chang@sifive.com>
>>>
>>> This patch series fixes the spurious IRQ issue in the SiFive UART on Li=
nux
>>> introduced after commit [1], which changed character transmission from
>>> synchronous to asynchronous.
>>>
>>> Currently, the txwm interrupt pending status is only updated when the
>>> asynchronous transmit handler runs. This can cause the txwm interrupt
>>> state to become unsynchronized between the SiFive UART and the interrup=
t
>>> controller.
>>>
>>> This issue has been observed on resource-constrained systems, where
>>> Linux reports spurious IRQ errors. In these cases, the asynchronous
>>> transmit handler is unable to drain the TX FIFO quickly enough to updat=
e
>>> the txwm pending status before software reads the IP register, which
>>> derives the txwm pending state directly from the actual number of
>>> characters in the TX FIFO.
>>>
>>> The remaining patches contain miscellaneous updates, including
>>> implementing txctrl.txen and rxctrl.rxen, update IRQ when rxctrl is
>>> written and remove the unused ip variable.
>>>
>>> [1] 53c1557b230986ab6320a58e1b2c26216ecd86d5
>>>
>>> Frank Chang (4):
>>>   hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
>>>   hw/char: sifive_uart: Sync txwm interrupt pending status after TX FIF=
O
>>>     enqueue
>>>   hw/char: sifive_uart: Update IRQ when rxctrl is written
>>>   hw/char: sifive_uart: Remove ip variable
>>>
>>>  hw/char/sifive_uart.c         | 46 ++++++++++++++++++++++++++++-------
>>>  include/hw/char/sifive_uart.h |  3 ++-
>>>  2 files changed, 39 insertions(+), 10 deletions(-)
>>>
>>> --
>>> 2.43.0
>>>

