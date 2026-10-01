Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB63CA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC6D8-0003la-T2; Wed, 30 Sep 2026 22:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xC6D7-0003kj-5m
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:07:49 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xC6D3-0000v1-Vd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:07:48 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa1d00daaaso10608572a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 19:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790820464; cv=none;
 d=google.com; s=arc-20260327;
 b=Y5/baxgoKSNewEm86OrjsSrwC0wdS+d4ETC2iWVvoDrBn6sn5nPB9AEpJ5yM0ppgst
 bqlwD7XHw58xZWkDCogsOh+CQ+78y+4GXbc9twEDD36aA0DLc5imoniIsvRcTo8V/5wz
 by/F1zABoVA8cu6op7KLaOPS7SdKk/CF1sq/dLihcOskkICjHzHT9wFrvmPeVPYFuAFO
 Y3LIbH6wNqV5sXSnwsjBgaGt3XnxmeeOr5uJQZZJDdAm8kLXJCBKQEMeRxizLUoCY4qV
 qz4JbYRlCdmddVgkPYYh0GJM1JpSJ8vZdR9YEaE71msLPzipglJoj74iUspT7VaMsiP4
 76Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=iq3esjhG4aVafagvf/oWSo/6s5umcwYrzfq6e+nN6YA=;
 fh=pS42xvTpIuaUSSfWP0KHETKPUIOchqwI7/2RYG7wagY=;
 b=SmX7CAe1plL1tF030FVgJfkBd9g0OAHd25yt8FyFMIAb8Odnv9fP4G2MWktt2xJjUW
 VkG1udUWPAJSJKa98B4T5muUe7eHrqrkyG4jVVdcCCMVht4GejEuDDH3xv5fFwISzh4x
 iUbuC8oBlssxF2HWt/jPMDdmETRMJvcawl8MG0H62v4dbqKs6pIMW8qNojzoitdwCCtE
 3+fJ97063TpEqvhceaChQ1LuOZn+y9EI8K4etxiVHgiiqHcJymyiWqX6fQVg8q3HdhJh
 TD75lMSyuBzRQNQkQPWy5xXbUKA8kNhrsT2IJol2FrYWnhHNEf2jha8+kXVYQAOQscG/
 ImCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790820464; x=1791425264; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iq3esjhG4aVafagvf/oWSo/6s5umcwYrzfq6e+nN6YA=;
 b=sw8rGU/dctpdLbvA9r3I0SFbZ7DP6XrxOy9WvsMEgrkVynGVYGvBOgUU36nmpjYnz1
 GVD82vpxDNYOr75gN/ovWsJ2pOKtW8EDSVdAD7g5aaj2OSM2sAWvLAeit6yHAFL29b3E
 2ld2B/kD4DeTDRfXAAycflndXJyn67mTxBVQ1i5bniOumRoVsi/HEAPpB7fYWKAK0Na1
 6RbM7ffYdbnkIoRPbN09UhB84Sd9YmNgSZzpGMSguiE0OmndOS98wZFAsK6x1UK/3SW2
 eyEaqCUireWt8gj/y5Ve5P2gH8q7ZpdIimgdtWzay7X2ssZEQgmnCA0TAZAoUIAkTPod
 5OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790820464; x=1791425264;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iq3esjhG4aVafagvf/oWSo/6s5umcwYrzfq6e+nN6YA=;
 b=npcdk/a4R78yKyQnRn6W5J40cqflMYti1DBiMoadR8KD1zBfPuhhINLqMNRkvbH9+d
 O02NizThvT9ma10RJayTjtZuHv9XecnEcR95/N7UUfwriCtZ13h9Teq8fHdpQ81REyQo
 LniGWjX0Lan6q7z1pQCrpuSrKsvC4NjZ/SPzOlSZvr1SnKmbiiDG6BWXkQmuAj6APYCS
 8wADGQH5G2jkt7brBuolfihrWh4ranwJffuAz8rxC4YMv+cFQM5hVXVlQYuPYfoVcTPm
 m1TTNgCn/FDz7WZnJkCJFhSpFLH71Zdmdrzvvbw/h/pYazGACxVWelar0BnvjmpQdDAO
 oxLw==
X-Gm-Message-State: AFq9FYKY7uw7N3TVlTA5fcoYCxVNLfrN2ANyXdH/VSzD4vYpkVO1yx1f
 lhOLJg/08BZ+BcEJP+wVy/uj3I4tS+yWHqz7g1TdDv1/xHIQoBouKVuZqSOPQPwUd7mU8AzptxQ
 +nwk9J+ClojvR9uItNoO7gPJOW/oXooY=
X-Gm-Gg: AYBFou3S8YPkpH1XOQ24ALKk6xcRIrSVr8ZmeDI4IYeoHwmTkuHHod1L7OqPGNrRW/I
 NFCurorNVZxtrgTi5ynkflD0r7NvAVQoMpQQdqE4rCiKespCfhXgNqqgCY5W0uxP8TuZu75WyED
 CEVX3mLuYyahx1Yyxwq9ZOpTxaD6KKyk8z8xO+EWHpB05olsc87W9WNosj/t8k1UnCx7NuWiJJg
 7mjvPnm6ggWQ5ukb8ue+d/Ulh/PR+H1c8tv6bvTqaa1Z7HTSElJMTCb1MtJgdP9gIbj5p7eDYMD
 +u+/b/nasF5YbMUlmsfmDpDmH4lbw//Qll1QA+KJwn0RA/ZQ0TO8Eu8=
X-Received: by 2002:a05:6402:4442:b0:6ab:373:54f9 with SMTP id
 4fb4d7f45d1cf-6ae1996cf19mr2256379a12.40.1790820463967; Wed, 30 Sep 2026
 19:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
In-Reply-To: <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 1 Oct 2026 10:07:31 +0800
X-Gm-Features: AclHuK_YhTQfAsWte1TerVMP62F1spamOd33K7zgFzLJQ-ObHmTnnRtITObfAsQ
Message-ID: <CAE2XoE8FM0JG4YWkNo=vLfTAfCHe0U56vYjG8FSJb6XhhJGhhg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Stafford Horne <shorne@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Song Gao <17746591750@163.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 1, 2026 at 2:19=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 9/26/26 1:15 AM, Yonggang Luo wrote:
> > - Add machine_class_set_name() so boards can keep a stable -M name
> >    when the QOM type is uniquified. machine_class_base_init still
> >    defaults the name to the QOM type without -machine.
> > - Document that MachineClass::name is the -M name, not the QOM type.
> > - Sort -M help by MachineClass::name so order matches the printed names
> >    when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   hw/core/machine.c        |  6 ++++++
> >   include/hw/core/boards.h | 12 +++++++++++-
> >   system/vl.c              |  8 +++-----
> >   3 files changed, 20 insertions(+), 6 deletions(-)
> >
>
> First, I'm not opposed to this series, and if anyone wants to pull this,
> I'm ok with that decision. It's just unclear for me what will be
> direction after this step.
>
> If I understand correctly, the goal here is to allow to register
> multiple "virt" machines, while still having distinct QOM types behind
> the hood, which does no affect behavior of current binaries who have
> only a single "virt" type at most.



>
> That said, if we project in the future where we have a binary with
> multiple of those "virt" machines, how will the current series help? The
> situation we'll have is distinct QOM types, that all answer to the name
> "virt", so we have no way to select them individually.

https://gitlab.com/lygstate-qemu/qemu/-/blob/combined-binary-multi-targets/=
tests/qtest/machine-option-test.c?ref_type=3Dheads#L393

This is the tests example to demo this, and all tests are already passed
that in combine of a

multi_target_supported_targets =3D [
  'none-softmmu',

  'aarch64-softmmu',
  'arm-softmmu',
  'i386-softmmu',
  'microblaze-softmmu',
  'riscv32-softmmu',
  'riscv64-softmmu',
  'x86_64-softmmu',
]

I tried hard to get 'i386-softmmu' 'x86_64-softmmu' to work. As they are th=
e
most complicated targets. And now it works. so this patch series is fine.

>
> Slightly worse, find_machine() will just pick the first machine name
> virt, which is a non-deterministic order at the moment.
> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=
=3Dheads#L846
>
> A possible alternative could be to use ".is_available =3D target_X" on
> those virt types, which will ensure only one is effectively registered
> at runtime, thus, there is no ambiguity on name or who is the "virt"
> machine.
>
> Again, I'm ok if anyone wants to pull this.
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

