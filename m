Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA46CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENvv-0002NF-MG; Wed, 07 Oct 2026 05:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEMzd-0007iN-S0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:27:18 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEMzb-0005KW-Uy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:27:17 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso2172284a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 01:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791361634; cv=none;
 d=google.com; s=arc-20260327;
 b=YkrUp+ukZ1QaYmhHbz0hHvMfXYYwAtXUuP8HVULuQ+GW3Q7OXol1Pwv8SKLq9H3AGv
 zMCx9FrUsADqaussvyQ0ZJ59FRb9fJbvKZiC4vXgaSQUu648b0nG/5q4ILknL+yJ8Jz0
 JRBKHss1NClAPYcxXHiQW3nkQjZnE6vrpyLAY7MyojsTNU/q9L8zlj6LBT1rcqBz8rNY
 +caYIUuE//1Mqlf1ekEzQtmdsiXv3VPSxJ7XGu/iQuz1Re54f8IEFDMGKIfbwpi4VoLY
 I10nLork3izGvnn44ak5gN7uk35N8GL3KYewa0WYNi2/0ExyzxXU3hXgzWGh3sD2POY4
 1dIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=d+Phj2rLV4OT+kPa9XTYfLJEDEhfmCf+5gXEqNscdr8=;
 fh=IAW3643XnMCkjaN5gMOCrmSBLGGaHPDUX4Kc74d0a9o=;
 b=VoinF3KnfgezVg3+HjTBUaF7HARi/2nOMQy4XcVQKwCYNOKr74dXEr+7Zjf/8gEHLK
 TgJ4a6K+d/5velA0utp9/b55I7vLTQZM1sPapZLdxNxPBAvWP6DvoSkwnguPUIcNFOfL
 r7hT1ZFDllbCesuxeqMd294yHIoLtC+R73MEeeGgkbDCRR2wXFW3+Gv3s1aKaAbGZJmD
 ZhUySqdh7iUlZwlhlHLMGVoWQpvxRbVkSJpunU/LjiMfN+Cx1AdczItNIXSjH56usDRz
 V+RcXA2ouBWP2exxOAbsJR+FWR63Uu+RxzhnYl2pZoJTTa3kRNJTZlpCLEctY3LwkBGq
 onyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791361634; x=1791966434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d+Phj2rLV4OT+kPa9XTYfLJEDEhfmCf+5gXEqNscdr8=;
 b=LjoYCetSLK/xiTC00UeybCD9rLMmkxh4CvQpRk03GIPhR2CZ5UMSwcnGYFCnGh4zSK
 lGYWmUV6m4zCjfKUuofeJKVX1coXREhSY5xmsVtmbcKROsASJ5IeAKYKvIrNPRtr8xi6
 iTg2WW6uCcm5ZK+8Uxaz/79GAg2mFYmTcm95YB1E1zZHe+Tf/0tuKVLzdjDWQbjxyhY5
 7BYfLmN+pDQq3lIpWCZY0Fk6J81e5sflzERqtAR9GW8ig61+NbpYRq0R+eZf5AqtLYl1
 +HhAc9prI6WMPdqwCFCuJ0Ca5fHziYlJo0p9945scQ5Rzik/9bKglsYxpkubkHifzNHE
 oPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791361634; x=1791966434;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d+Phj2rLV4OT+kPa9XTYfLJEDEhfmCf+5gXEqNscdr8=;
 b=1UaP9YAlkJkFf6s/NW4KThGolcu7N9LmQVtaRtOmoMxFUGUxdPUZgIuKP2gtKA1lYb
 hyVDahLWEQ1rdoH7/rqIDYGMVNGlYHCC4M5f1MkAqz8BTsIubwLdIM2+ikNBp+tFJ/TP
 sHQYbC7GYjFgM6PtXP3I6VALQXEOpVYduCGEhPTGoEl5btG8VG8VD8URHfONeGQYt373
 tGeQ0ujKS3FuxLY6XnhNxpyRS9Rz0aHXiG9N48iJjMTh3wNrIspV+l4+VtrDPVfGSBuy
 u4A1/2ery9QaOKVMHlDBujQ+1/r1afLYTslyehn0kcOngLpq0jo/n/yyEoqE9SIAqtzW
 mcMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOcSw3gUTJswF7hvQ2RrJRYhgfg4CYRrvw2S7tzQFs0rEeC8Clgg7b0KSGIR4tin0e31i46hfwigY7@nongnu.org
X-Gm-Message-State: AFq9FYKaPSP1gv3UI6QBAwDtTTMgo4oY5tdETcmLCGSs5oiqUyu/ylQ1
 d591kzFWUKEhPCnG4oqZThf1rV+n33mYaPItByabyKyzuU3t/zzfsAov7lMmQAP2Mcl8FUBZkSK
 hSvcg78vS8qop37CIm0sdTKwProlaebc=
X-Gm-Gg: AYBFou2+X+J8usroMNKSaXqbwQBhZBrmPpiURqCRIg8wZ7omBC5czCni8TXxE0zy/rV
 wsxWRZKX5d3rfvbaantWMCRUcBKB/jNCuIB2bJcvLHn1ZQnVHAepbVCmYVTY0oImEVB7mciu/Ue
 nR3+72QMR9vx83wtP/TVS8VA6/NQNjrpFiAgiySV1WkRVcrsU25UW8A6NOEjVtz6+dXTtD6U1V4
 tzRk7TWzS19EAikZFhcDkcQvFXX4GiG2VU02woIxT9pbD/QH4xxuM13Ao5NijeV7l37fWK+uqiv
 vAPnsl29NMED69rlgKiqlSfvPpWRb7BXzFxyE3fwAbTsmSuboFNtbgc=
X-Received: by 2002:a05:6402:2747:b0:6aa:f77e:594e with SMTP id
 4fb4d7f45d1cf-6aff4563400mr1422715a12.23.1791361633298; Wed, 07 Oct 2026
 01:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
 <95c99cac-ae83-4bd2-ab09-51c2ef9f1259@oss.qualcomm.com>
In-Reply-To: <95c99cac-ae83-4bd2-ab09-51c2ef9f1259@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 16:26:59 +0800
X-Gm-Features: AclHuK_oKPvbrFOVVOJHpNiZhRFg4bDCV-AkeBUr_sDF344e5oSdT5_Ohovb520
Message-ID: <CAE2XoE8JH6r-e6TQDJtsUJZN+yFf9j+xmfzuNjbVkXRGoAyvVg@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x531.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 7, 2026 at 3:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 6/10/26 15:56, Daniel P. Berrang=C3=A9 wrote:
>
> > Current git master is exhibiting a regression compared to previous
> > releases.
> >
> > For example on 10.1.0:
> >
> > $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"exec=
ute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"=
}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v nu=
ll ; done
>
> > /usr/bin/qemu-system-xtensa: "xtensa"
> > /usr/bin/qemu-system-xtensaeb: "xtensaeb"
> >
> >
> > but on git master:
> >
> > $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "=
$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target=
"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .r=
eturn.arch | grep -v null ; done
>
>
> > ./build/qemu-system-xtensa: "xtensa"
> > ./build/qemu-system-xtensaeb: "xtensa"
>
> > so we need to fix that behaviour change for query-target.
> On a side note it would be helpful to have such test in CI :)

I have post it, the fourth patch


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

