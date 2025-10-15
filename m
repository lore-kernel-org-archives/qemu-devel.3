Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EFACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91cf-000249-Em; Wed, 15 Oct 2025 09:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v91cc-00023x-RZ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:32:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v91cW-0004qT-1z
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:32:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so5406692f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760535160; x=1761139960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOM2eVJZjQZKlN3i2I+tgOY18zUvgC6fqXgvQaGlFhE=;
 b=S5HSZzR05VVy1CikpCmdb1ZaDIv0bQ/PzCrsh91NDDYRZ8sbvPG2CacZUytC0oVqCb
 9vGmqADTeGLmaiqjLJDIy7l2jboZpBxObTXnUZFKenXBvfF46K8G/ZqL/VstZyZK3r5z
 FURiCfLwDNqxsm+7Ru00AAMasJloK2mx5maD+0jO5PLtBXSChNPUB5e0cdrqeQq1pOfm
 MPT/vW9Z0ZO+jHTaHAaN2LfBJCwuEkRGc3yGAlxC/lRuHph3yTvaLY8Rn/VeYUXyl8lR
 Wo09jZ5cDcxW2/7xAoY4h34cg8HYDAE5VzfSuFa5A0HaJJBHkZbxDCDSemZD6h4WGOvV
 Onng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760535160; x=1761139960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOM2eVJZjQZKlN3i2I+tgOY18zUvgC6fqXgvQaGlFhE=;
 b=q22oo7Zxotz4SCxwNfSVXNCXQnbABYVnPI6hJB9nldGoO71irGpajauN9eU15JixLI
 qYsgMiJngNDdMUwW6q1q6oSHOxqxFzX1SxwICXBQmmZHh8M1EJWI8rPguQMAyfC41z1O
 su6ia/O+FgYqf4KmTp8plihh8hX7KThWnsSa6kcmFGKzf4xbPg7HRJlxT8ulj5zei/3u
 lWtnNgUioPmd9DCogwfH6tK+HlYsaoSzixiGTsmfQ3uxVCH6tFg2F5iwMAxkj5fS53NN
 W4zId+W7ybo/4CCkMP5bUymccD5BQjiqRqXW+vM/43lXd5l5sp2cPXoKYVqD/yuvHPF6
 m/uA==
X-Gm-Message-State: AOJu0YwgjT39P5yQ26akMbQn+TLlsUhVyfzFW33lFpuTmIOENhkSRkE/
 awG6mYJAtls8/0u5rvoOrZ3fxojndfBGY7aMqPIfzwY15u9t8vkm7reP4oXxtJ7QmbActyNwjvU
 orb1Z6ndp5C+aZruqZ5hU6+Br8ar6q9g=
X-Gm-Gg: ASbGnctC7YkSN1Zv9FMJCBAPM59RZDRLQWJKM1EkgpN4r9jZYY8Vhb5hNsnaaqlxhqS
 2ChTBVJsG3wbmCsdkImGtpmhNlMs/JruZRXGqeJnNfooI+5mQO74phQ7ZLDGMvuvs5Hi8dIQgTB
 ICT445fd32Nduak15v3dQBU1J/rUgWaUXG9OhnHKg9i6D7PVbQvRm70+AOSIjqQM5kaER5jJPfd
 wbI6vt2+Ymit6xEnhItIW0jZIRFxfBLzHtLPw==
X-Google-Smtp-Source: AGHT+IHZDNLy7UzY9ve+imEQUjWiUgP8RXCDiiGSBXnM5erwMBXEyAYCYzFpR/tWPFjA7tSc0qaV8gBbZm8tXZJRj7Y=
X-Received: by 2002:a05:6000:2003:b0:3ee:13ba:e133 with SMTP id
 ffacd0b85a97d-42666ac466amr17205706f8f.1.1760535159441; Wed, 15 Oct 2025
 06:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251014132907.3268743-1-brian.cain@oss.qualcomm.com>
 <20251014132907.3268743-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20251014132907.3268743-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 15 Oct 2025 09:32:28 -0400
X-Gm-Features: AS18NWCq_8TKssVH6PO3C8B3qYQ-sCwn7dJ5rbeRzMTIEoU9jmF4oIDqvvGQkEE
Message-ID: <CAATN3NoF5HvmrWBAUFRu0AH6tYXdEys-mHgXa5PmaWFr9-q_5w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tests/tcg/hexagon: Add cs{0,1} coverage
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 9:29=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Cover cs0,1 register corruption in the signal_context test case.
>
> lc0, sa0 registers previously omitted from the clobbers list
> are now captured.
>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/signal_context.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tests/tcg/hexagon/signal_context.c b/tests/tcg/hexagon/signa=
l_context.c
> index 7202fa64b6..12b78f1790 100644
> --- a/tests/tcg/hexagon/signal_context.c
> +++ b/tests/tcg/hexagon/signal_context.c
> @@ -26,7 +26,11 @@ void sig_user(int sig, siginfo_t *info, void *puc)
>          "p1 =3D r7\n\t"
>          "p2 =3D r7\n\t"
>          "p3 =3D r7\n\t"
> -        : : : "r7", "p0", "p1", "p2", "p3");
> +        "r6 =3D #0x12345678\n\t"
> +        "cs0 =3D r6\n\t"
> +        "r6 =3D #0x87654321\n\t"
> +        "cs1 =3D r6\n\t"
> +        : : : "r6", "r7", "p0", "p1", "p2", "p3");

You missed cs[0,1] here.
Otherwise,
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

