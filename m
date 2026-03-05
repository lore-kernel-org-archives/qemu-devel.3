Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8ECF30930
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Ez-0000Ta-5d; Thu, 05 Mar 2026 05:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy6Er-0000TO-4n
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:47:29 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy6Ep-00051E-NO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:47:28 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so6763866d50.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 02:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772707645; cv=none;
 d=google.com; s=arc-20240605;
 b=SccKdhu8cUybSg5WQifbAj/A3MISTSMSnYjpmqZfB3rC7q4FH50Oxs0vXDQTpavcaQ
 2eXTEddq0co595Sqhebodm6xy/2JjBzf6uLqAeWyaNsEYgYPlbIq4ejot7qa95VGY2M+
 rQyzCxlDTYNt0rlTfBszvFbltcvH1dWWM00EeK0HSkmoqrnIexg8/E5QOr/kSwB9h8Un
 rVGaQ4BBcvOR+ARHc3YAm2+kHdkqcClCT4rohmANzukqxpckiFNd34gjQlOn+P1mSwDg
 ZQjuGieaCO5CO7TRGgqdo8XHBYrRG9xI67sHOp3d9ZoE3QY62XyYePnQjT6XJUG3ZwnM
 lRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ixYMutHNtt0wlXBoPM+K3KsiQ4Mxfk01Woi8htN4Am0=;
 fh=Pe3idRCWburrCj7wv0TXuAlDe/2qe83O6ntiPggUdHQ=;
 b=SfRh38ws8dyLweAD6KBQl/ChYz0K1cIJttu90MajHFZHMXr8l+9sk+7C6kgM3xnyd6
 CmlCSN7ufSQ1jM85zeOHlSFAb31B2C2KS5vwlKFBr73vCM5/1+C2gYDjmKklhjs/b0xn
 BNsqrYwlAKBFkocKOPspG5ye8x8uu2u6LuV1gnOyU10Jh9alGNFm6UjagsflNxvdNnNv
 49PglGQQN2vSrdjbz0KIvVn++mcY7AcjdIau9VMoJ/SFWTutFGp/J7JTOnroVYbi/d6T
 JCWR8USEkXaQlWMDI1+jCMGoqzTQgGkuX4LM7bINuTNA0OBZbd54fpG6/nxxbezQnjTj
 DSwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772707645; x=1773312445; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixYMutHNtt0wlXBoPM+K3KsiQ4Mxfk01Woi8htN4Am0=;
 b=pish8VWugwFEdvMUItENUPZPlriMokHYZgTu5z0t5Xhk+GcAb8/kzie0bTjRFqAVLN
 RinoWaq8g+wM3ZBHELaPEMffxJ3igZE2r8+Xc+UFHDDJokpGeMnMPArpALWFZb2Q3LbV
 Bs3F23AhDoTvJHg3mcMUgxXdisC6xbGodsvCCRtB68BjcZ/hi4t1uNqp48JyI4jnPzMO
 In3645wKgOPvGivPmwHa/NAk1G7B3AsTnwGQx/Ci1Og3hvdsqhGf02Nq4dcY4JImNt20
 OOmoi3736/MXsQ9//dbOip+yZKp1dUci2lmaHQuYzt+2Ki2rYIiZ1hcbXr6Kk95+Ff7I
 pZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772707645; x=1773312445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ixYMutHNtt0wlXBoPM+K3KsiQ4Mxfk01Woi8htN4Am0=;
 b=U/NnNGin+Yncq0hxU8VReY87HzB7ahxFr3hTvPG1FOvs4mSVvUS01h/8G1UTnvicTp
 +rQRLM4OtBSblne/L1WnF0UzfHiOB7NQ8HpAEvtFl+w+MdiByA0cBFeEoaalJAFxbHnS
 VPrwZZ2Lj+0paS0WPV60BSus1Ivyz4XLQIGKO/QTYUOYEY2nmADscasqMwbS+aQ/6o3L
 kcmHFkDQrraMNS5vTtugDPboZCp54u8PP/4SxHsPVS8mYpUrjjLL4VmHK4N6sUu1dVzy
 4nDS8FODX6DZZbXABwrCfX1gkC8yGwF/RxOzEQrSBo97oEKWjVnRbcwgWH4cspjyph1I
 mdZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc4HfwKEwdmX2uYQl+7YXTpD9DlrcSQRYRHFgKW88exozxtTKfhgu136HNxIJ/iqeBNIBP37m9Dugs@nongnu.org
X-Gm-Message-State: AOJu0YwpLQbW4Zzia8pdO7kQfkNKs3kgcmvu0TLOXAIQEdGVbTxw99u6
 UQ02ywZ52XLTKBwh7EBV0pH//G1SAiQNz/LwTsbx4EI6vg/z/bcUwJzIhDlXv+3DgTwvW3GccgS
 iJWCGr5y3uON2hZnPv2NdN/myuHMLvrS+H/ASLQVUVg==
X-Gm-Gg: ATEYQzzoScRR+HGkP3y4cfgpVvtfkt2XXT5Yc16eoE1u0uT9JxdQPZywi3iQCv0OL7p
 g8uODrjXj9uEe8VKbkMziDRzxauXbWE3s0FHFzNV2JWFWo8BNaLjK2sDPpkm7joW798A8Ktuj25
 LF9vDZADX82iL/wL2p0X4+HQSiLiUMM3bt7CV3PcjezEuSyC4VWwok45BJNw6EatAZsRSlQQp7p
 qxuEMj+Ehcj2WiX9BDutob5iXUkgyWNMPwm07YaJ6LrQKFardUC1nFjEeGoCbl7OCOqbRA0X1eW
 pCMiB2N0wdA/1K9Dj1PWwu8trhsgq36yM3tVBGVv+vZXiS4xfN7Jz2KyyVVwbs9GhvU=
X-Received: by 2002:a05:690e:4488:b0:64c:c616:c349 with SMTP id
 956f58d0204a3-64cf9b6056amr2798900d50.31.1772707645236; Thu, 05 Mar 2026
 02:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
 <8b2855dc-44eb-417f-8a18-f40b1036637a@redhat.com>
 <3a7617d2-ff9d-403c-9733-14f7c1b5ac3d@yodel.dev> <aalYcixE-EwlRZhA@redhat.com>
In-Reply-To: <aalYcixE-EwlRZhA@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 10:47:13 +0000
X-Gm-Features: AaiRm52P4pU9eUfzsJy9tAOXZqt1E4gzwBIdjM380PMoJRKZMFsilAU1uragdqk
Message-ID: <CAFEAcA8A0Cp7Uhs6ndNkJFVgyxBqDCTB8oghJQmB_qhsZ8-55A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 5 Mar 2026 at 10:18, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Wed, Mar 04, 2026 at 05:14:47PM -0600, Yodel Eldar wrote:
> > In that regard, Daniel's substitution method would fare better, but it
> > doesn't prevent build breakage before they occur, it may only apply to
> > stringop-overflow false positives (TBD), and it may come at the cost
> > of code clarity or expressiveness.
>
> This is not at all unique to the sanitizers option. Pretty much every
> single major GCC release introduces new logic that triggers compiler
> warnings in QEMU which break the build with -Werror, for both genuine
> bugs and new false positives.
>
> If you're using -Werror at all, you have to expect frequent breakage
> in the future. We fix the genuine bugs and workaround the false
> positives. We already have a number of examples of using
> "#pragma GCC diagnostic push" for this purpose across the codebase.
> I don't see a strong reason to treat this one sanitizers issue
> differently from other false positives we address.

Mmm. I guess I'm coming around to the idea that we should put in
the workaround you mentiened in the other thread, plus a comment
explaining why and linking to the gcc bugs.

There is a difference here in that here gcc is explicitly
documenting that they're going to produce false positives
(a.k.a "we know our implementation is buggy here"). But as you
say, if there really is just this one place in our code where
we have to work around this, it's probably easiest to just do that.

thanks
-- PMM

