Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD31CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwx-00075P-5g; Thu, 19 Sep 2024 09:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srGwv-0006wU-K1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srGwt-00019u-B2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:57 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8a7903cb7dso56740366b.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751513; x=1727356313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOh3f59vIQEM1sqQ2WN1asCa5iff+GQlUxHH7szOQUY=;
 b=zl765BxXkCM3NSYQVugfDQ4wX55b7amnLHCZB2I7trDOBZzpVUgFt8bD58fykzMFdd
 dggKfcnPmF4JDvjvOLBo1qik5VZtbLrilK7yUNvZnpPFODqsA7S5PftIzF341mXCgsRY
 NxuxCFa1PHLhUwE2D/QbmMN56eZjC3/lQJmafLMutCu8hH6F72GoeCZ0UUZc8taBpq84
 /lE21I+IXStyHnUgeAUT5eE+is7qUHqfNsK03zO/u+p51Wi1M+kKgjQ1VwqTrv4MF5OV
 nFeno+IZe3lL97hCLd8+6k/pcSNw57D2p6SvUO2xf8SN7jpkB4GjuwG0V25OUePrCnom
 uXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751513; x=1727356313;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wOh3f59vIQEM1sqQ2WN1asCa5iff+GQlUxHH7szOQUY=;
 b=V+LTq1XXraXRpvj8LRrPM7xP+Ht6ftmgGT8UKnf2abX5H4piELOSeg1dwc2w3vdDtW
 LmKsROcei+zlU4KjyjcDKNNiN/NeXXjtnfpwnrr8sJWattl6prBbx+Wikk+q5ZvT3YyF
 v6eFyRD/3fG36nhYfl8W04nrEbrH2H/i38OeNjtyQKKs09iP23Yye2miorVHWLYAGptI
 A4ikgJfsv+rTc2VW0h1wqTFCs2oHHfH9sceGvJiXV8y+r6u9m/4scqNvAVfpj4SiUpcH
 LiRoAHrwfYu3lL2cpMNJg2CZ3jzlBcMvqn31Kh1ux8n7WzRFkp7Ig7NuLnJ9zd05dfhI
 7Bmg==
X-Gm-Message-State: AOJu0Yw7ggiL5Rn6relLgzdJEcbkUcznRp2ASgU3poL6XDfuBbC1YpX8
 mfG860gGo9QlgU+O9ToSrBdGUan3V3+VMM8fZkv2PsOf0zUbz2VOtmSkm/pTh78=
X-Google-Smtp-Source: AGHT+IHaOcTgPADUixEc584Qzu0jx2qbwPPYLoELt4yOQUt4al2eST+S8x1+Uw9Q8KigXHh81Hq2yg==
X-Received: by 2002:a05:6402:c4a:b0:5c4:8b7:d93d with SMTP id
 4fb4d7f45d1cf-5c41e193760mr31381511a12.18.1726751513266; 
 Thu, 19 Sep 2024 06:11:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb89cebsm5935169a12.60.2024.09.19.06.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 03E705F8A7;
 Thu, 19 Sep 2024 14:11:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/18] tcg plugins (deprecations, mem apis, contrib plugins)
In-Reply-To: <CAFEAcA8tdyELui0=jYFObZO1=O_isJ-c1e0s4ZCbMVyfsrY=9A@mail.gmail.com>
 (Peter Maydell's message of "Thu, 19 Sep 2024 10:50:50 +0100")
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
 <CAFEAcA8tdyELui0=jYFObZO1=O_isJ-c1e0s4ZCbMVyfsrY=9A@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 19 Sep 2024 14:11:50 +0100
Message-ID: <875xqrg549.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 18 Sept 2024 at 22:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22=
bd5:
>>
>>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu int=
o staging (2024-09-17 14:02:18 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-tcg-plugin-memory-180924=
-2
>>
>> for you to fetch changes up to a33f4871e0a0f4bf1cb037ab29fae7df7f2fc658:
>>
>>   contrib/plugins: avoid hanging program (2024-09-18 21:02:36 +0100)
>>
>> ----------------------------------------------------------------
>> TCG plugin memory instrumentation updates
>>
>>   - deprecate plugins on 32 bit hosts
>>   - deprecate plugins with TCI
>>   - extend memory API to save value
>>   - add check-tcg tests to exercise new memory API
>>   - fix timer deadlock with non-changing timer
>>   - add basic block vector plugin to contrib
>>   - add cflow plugin to contrib
>>   - extend syscall plugin to dump write memory
>>   - validate ips plugin arguments meet minimum slice value
>>
>> ----------------------------------------------------------------
>
> Fails to build on macos:
> https://gitlab.com/qemu-project/qemu/-/jobs/7865151156
>
> ../tests/tcg/plugins/mem.c:12:10: fatal error: 'endian.h' file not found
>
> endian.h is a Linuxism.

Doh - I'd written it off the failure as waiting for the MacOS bump and
didn't see the actual error. I'll see what we can do.

>
> While I'm looking at the code, this caught my eye:
>
>     case QEMU_PLUGIN_MEM_VALUE_U64:
>     {
>         uint64_t *p =3D (uint64_t *) &ri->data[offset];
>         uint64_t val =3D be ? htobe64(value.data.u64) : htole64(value.dat=
a.u64);
>         if (is_store) {
>             *p =3D val;
>         } else if (*p !=3D val) {
>             unseen_data =3D true;
>         }
>         break;
>     }
>
> Casting a random byte pointer to uint64_t* like that
> and dereferencing it isn't valid -- it can fault if
> it's not aligned correctly.

Hmm in the normal case of x86 hosts we will never hit this. I guess we
could do a memcpy step and then the byteswap?

> I suspect the plugin needs to define versions of at least some
> of the functionality in qemu's include/qemu/bswap.h.

Could it be included directly without bringing in the rest of QEMU's
include deps?

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

