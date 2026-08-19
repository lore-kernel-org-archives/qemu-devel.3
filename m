Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB109C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhKw-0003im-HI; Wed, 19 Aug 2026 10:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwhKq-0003gX-54
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwhKn-0003Gc-GN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4998590d392so10324425e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787149924; x=1787754724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vP12b1JUnjE5mle3gGAYQ66wrN1+b9sfD5fxFTIW9Do=;
 b=y7TMEWfWdUIVMe5hy1wdV1KdBKw4FObLriQaqRBuT5YJIcJzuUXiJzSVAuDCYmMWyk
 5EqtYv3j5TA245QxIUABDUao1ddI/F1CGmX1Q/QWeC+G3BrBYHgKhQBZHbrnU9o6fpV0
 IAwIbNHQAbeP8Pax+OnBAqP0GqhrTsHiHJJRhBRmtAyMje6M2FIKQoM0dSXCS8zwgrfH
 zJLoqMrq2dLoNMOazVL86yGzxy5CCHqo6zaZjhBGGqy3WzgG8DuWTaFemBIA4fp0V5MR
 gYwYrhl+TfFDlaJLpjTkATlB/oiUSkaiZp8zD2Df1n3/51gnUqg18b3z9asKwm1LCkyN
 bwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787149924; x=1787754724;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vP12b1JUnjE5mle3gGAYQ66wrN1+b9sfD5fxFTIW9Do=;
 b=DcnQP5UcynzPu8vUx+NCs/EcWSuIoVt9eyWsaJgOCnvBPRS8FeDpQwYKYolx2mMWSy
 8q9rJ84JZZsxy/p/VPCNzBksR8Cs4vm64fRdnjbAaRquFd52r5Vozjv8royTbfZVhuQx
 pvu47pKFyqEjnNTdGt3vSBpdzEKu2Nxq0S0VS1jIslkqVomsCdakuYVHjKNVGQHdsKZi
 1GHvVXLaUoA0r0IariDFMkvQMs2CkFQh3eZNEPDIf+8/x5cEUnlMwwNxp+jUIfG9v+Rw
 zuUKBOrJdFr5BScekLXaorkTFZ2qzqZuPWVdP08wbg+iu4BygwQ1p/D2rJkIegA2SO6t
 7jXA==
X-Gm-Message-State: AOJu0Yx0bONt/ULKkXMC9bAMVT81uleaerXsCrPiU0qRggr/G/IKHy/Q
 oenbDy6R/SOp4kayQ46Baya3+HOeTg4keQlW65xIk3Ikbqb8q4kd0zqR79+YeAykQsA=
X-Gm-Gg: AR+sD13wHKIQntUpLzLEjSXi2UxTZn0GTDhY4ZpEXnhjHy4KFXcFXWWViWICP8AFgAR
 OYhcNBQ7FKVB2GC2sk8gOtTiaT89YyadIrRUj6Du195j9Tw8Z3Hv2K4SeA8Su9FiL0H/qsGu3wx
 mBRrhjaCG0531Pd4gOG8Nq/bD/zlspIj8tBeUztsdRWYrhnb0FMT5GWEkDZDh4PbktC8+UK/HRI
 meB0KHlaq0jPRBoyAggzhuP2FC2+Va5lZUaMjpc8q3tlSEgdQc0Zw0hkJNCVQy+Yt45unyInd6f
 ajL28hV6lRDcsrQ/sM08jG2BS3hL1t7ASZexDVnrnIq3czdD2rc1g4p6RlOm58yEjPG7sJgqSeu
 W3sFufUlNhx2VUcckPBK3sZVc/rx9kKZ6t1HgOtR0vb2EpMQpockIUJND8djXkRoemyqABqa7LW
 zBEWH2isohvKtC3mwhjWVJvmrEGquY4L0GYbinwQ/l7SDnACkRq2KN+5L6ggry
X-Received: by 2002:a05:600c:8b6e:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-499aa1a8bbcmr103182975e9.7.1787149923911; 
 Wed, 19 Aug 2026 07:32:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm87948755e9.5.2026.08.19.07.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:32:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AAC55F805;
 Wed, 19 Aug 2026 15:32:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 034/104] tests/tcg/multiarch/gdbstub/prot-none.py:
 deactivate on gitlab CI
In-Reply-To: <20260818192309.22169-35-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:21:58 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-35-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Wed, 19 Aug 2026 15:32:01 +0100
Message-ID: <87se4ap4f2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> This test was disabled on Gitlab CI.
> Tracked in https://gitlab.com/qemu-project/qemu/-/issues/3329.
>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

