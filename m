Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2199CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZTh-0002gx-71; Tue, 13 Oct 2026 06:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGZTf-0002ge-NK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:11:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGZTd-0000pD-OX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:11:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c411d6615so1973096f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791886280; x=1792491080; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pJdElpKWlFhUrwKPkmVz5oeKledBx1uB7YTI4ZaysUE=;
 b=ixs6bNuTvxcH5hUuOp2uGUIszjvU6FH/1jiG+Zhbmxk0QheF9xf/QljYmMFzKh7Stg
 gHrELPLZzXXZYddAP4oHsNENZsKK714JbIF6X967irRH5M4xTNZgFcQNFXtepXnm1OTt
 JJgT5SR5h4hMtSsiP6K81KkdNtaGjgti9qKjTuBzMH9qz3kT4n6Gr4179f96XmAueHmC
 xwYh/PUb6T5muAKCgLFNvLEJRRDB9qgeBg3Ddl93YgNuSx6Qv0fIkATvQ66VnNg86vOW
 c0V86kqbNnx55D2R2+xrodcQckNLa3Yos7HTPi1p86b/uDqML6WWKXvaQRExuAEhpf5t
 XbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886280; x=1792491080;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pJdElpKWlFhUrwKPkmVz5oeKledBx1uB7YTI4ZaysUE=;
 b=1L66a1HTgnhetoCdluCDlpbRUXYJ90jfL80qSh38hRaGpPxwRSDbI/J+biJPpI0JZo
 XAXl+xAVZFKKtEOhIDg2tO7uSKqNRiESO1TEXvQWPmdwUXbBpAp4aH9w2r6pHj1l/QEL
 YiSInEAHSJK6GjwWZZKwPzjApQTOVNwSmV0li5M8/uLP3cA1GAilTqdWPYWgil3JXvn4
 j5cU9kFLB9bmfQr6jyIhz1l54y1bkPRHsTLrTh02n0ImcC+AYD9NxEBUxxs6gSYTY+/+
 zSxTYypioJFy1lozzPYL0Dr+ospmIH8nkU3BtSwPCFvqYsA+xV6nYnlQ2ka8S/C4/8F9
 l6/w==
X-Gm-Message-State: AFq9FYLp6gVW86ZVbZ+PX4p/7ebJcNPdvhOnp2fr8c7k86Gc2PAzbYQJ
 j+J/32eUKbwcEMnc9dfbAlOvexqpwLQmohJPRkpENYaUfXBSfP1Q311QfvkD/70xXcg=
X-Gm-Gg: AYBFou05xRr96vN09kHjQjg8w/hkzJklpILq9M3Wi8IzZu3rmoIyMwZ2Y8pDUsqNS1C
 rxxKCm4GyJYFmdTIx99NWDcs5lF0sVXwvCHnQRTMmvVBairua6RK8kab1WiA8aLW3gcO53disrB
 XMIEPi5zLho7NXC+m5twwz7OWdEDW8uMS+A2uolcYOnTWD9K5oxpE6GeJioj+DRfaAOwKf2pD2q
 Dmba9BrdCzJYjujuCt/bH3pmB1yxaaAlFHIXlteOtgket4JfrQw1wGIRQ+TB98mWC4eJID+2QwO
 CTOjIMhU8dZTdP/8A+4LO1gUXJRRrOrKaJF8fiDatWJpxYDpsuasohxEDazYalUedJeKEmZJCfS
 7EGz2EXDxzAUSnypxj3BVLxmlhyxNXKT2uu6znYDJCpHy+cXV7htsukJg9a3rCCDuQjB7+mz4LK
 4rIKambVy4KJOfQxZvPVNIO3HqbGGG0klEWfZe8X21oF2VNrRylyVeUeTG/i5BM8H197CMNHLso
 7pcyoHb
X-Received: by 2002:a05:6000:491c:b0:488:8a5d:ffcc with SMTP id
 ffacd0b85a97d-48dba9e6715mr23366203f8f.13.1791886279366; 
 Tue, 13 Oct 2026 03:11:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc7299sm3577424f8f.53.2026.10.13.03.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:11:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79BA45F8E5;
 Tue, 13 Oct 2026 11:11:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Zhao Liu <zhao1.liu@intel.com>,  Kyle Evans
 <kevans@freebsd.org>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Brad Smith <brad@comstyle.com>,
 Ani Sinha <anisinha@redhat.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Thomas Huth <th.huth+qemu@posteo.eu>,  Keith
 Busch <kbusch@kernel.org>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  John Snow <jsnow@redhat.com>,  Eric
 Farman <farman@linux.ibm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Anders Roxell
 <anders.roxell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Warner Losh <imp@bsdimp.com>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>,  Klaus Jensen <its@irrelevant.dk>,  Song
 Gao <gaosong@loongson.cn>,  qemu-s390x@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 06/16] tests/functional: update x86_64 tuxrun images
In-Reply-To: <as3_pJ-KTtbVMilK@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 13 Oct 2026 10:53:40 +0100")
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-7-alex.bennee@linaro.org>
 <as3mM9XesjzPA0o4@redhat.com> <87cxtegcy6.fsf@draig.linaro.org>
 <as3_pJ-KTtbVMilK@redhat.com>
User-Agent: mu4e 1.14.4-pre6; emacs 30.1
Date: Tue, 13 Oct 2026 11:11:15 +0100
Message-ID: <871p9thpvg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 13, 2026 at 10:35:45AM +0100, Alex Benn=C3=A9e wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Oct 12, 2026 at 06:03:20PM +0100, Alex Benn=C3=A9e wrote:
>> >> We now split the fetching of the buildroot image from the kernel
>> >> itself. This is because we will want to access additional metadata in
>> >> future tests.
>> >
>> > This commit message appears unrelated to the patch content or subject
>> > line.
>>=20
>> The kernel is now coming from: https://storage.tuxboot.com/kernels/6.18.=
54/
>> instead of part of the buildroot build in https://storage.tuxboot.com/bu=
ildroot/20260924/x86_64/
>
> Ah ok, I misunderstood what the commit message was trying to say,
> though I'm still underclear how the before/after  bzImage differ
> from each other ?
>
> Is the  https://storage.tuxboot.com/kernels/6.18.54/ the
> authoritative input for the process that produces
>  https://storage.tuxboot.com/buildroot/20260924/x86_64/  ?

No - they are different builds, but the kernel builds have had the
symbol generation turned on and the buildroot images are generic anyway
which is why they still work together.

>
> I see the later patch is pulling in vmlinuz.xz from the
> former location, so I guess you're trying to just use
> the common location for both kernel images ?=20
>
>>=20
>> >
>> >>=20
>> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> Message-ID: <20260930164649.433573-10-alex.bennee@linaro.org>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> ---
>> >>  tests/functional/x86_64/test_tuxrun.py | 8 ++++----
>> >>  1 file changed, 4 insertions(+), 4 deletions(-)
>> >>=20
>> >> diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functiona=
l/x86_64/test_tuxrun.py
>> >> index 729f6447d05..026b373accb 100755
>> >> --- a/tests/functional/x86_64/test_tuxrun.py
>> >> +++ b/tests/functional/x86_64/test_tuxrun.py
>> >> @@ -17,11 +17,11 @@
>> >>  class TuxRunX86Test(TuxRunBaselineTest):
>> >>=20=20
>> >>      ASSET_X86_64_KERNEL =3D Asset(
>> >> -        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzIma=
ge',
>> >> -        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed=
5aef8')
>> >> +        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
>> >> +        '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac665=
8552b')
>> >>      ASSET_X86_64_ROOTFS =3D Asset(
>> >> -        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootf=
s.ext4.zst',
>> >> -        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb7=
8a751')
>> >> +        'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootf=
s.ext4.zst',
>> >> +        '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e=
3e27c')
>> >>=20=20
>> >>      def test_x86_64(self):
>> >>          self.require_accelerator("tcg")
>> >> --=20
>> >> 2.47.3
>> >>=20
>> >
>> > With regards,
>> > Daniel
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

