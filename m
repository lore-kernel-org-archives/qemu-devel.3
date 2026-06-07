Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727EFCD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 20:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWKOD-0005uL-ON; Sun, 07 Jun 2026 16:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wWKOB-0005tM-Dt
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 16:46:35 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wWKOA-0001GM-4d
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 16:46:35 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-9159477c893so473507885a.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 13:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780865193; cv=none;
 d=google.com; s=arc-20240605;
 b=aWD7buvKSmcbmc0TJGnbzLQsZBh/FUQpWOMVE9mToaIIlwUFwTRvNMRM3vg2BafPYy
 w7FZ1VtgS32oeTVPKFn92gH+D0nnOswxeOqVA/Djf7WJt/qhRy05ukAii+frqb6Nyklo
 KAI01nvCDfjsGIlyrpmEfQNPQzbzfnmGoNeXESCc0jc8DHe6BwQINWTRke+t5Dmztoxk
 u3Joq1XGF33Ogl2pIusEuPWZNFFwQNLGYHf21RIrJR08hL8h/xv5zPBy+AYsaf45eXnl
 n0qQCQXlJgZMf28CnhTIbcFLSwLTCo0KuWYeiQo77rAcPBApS9lQdxkWsSpT7gCxDH18
 fdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eQnjQoXnP+z8OYaeZT+X+pfOXJDNjEgiA1wJQR1dN90=;
 fh=2NkPUOH/T6obL5oX5qBYKhCWscG9yjQJvLJ7uC9v4/s=;
 b=XFNDG3ZyTx2CzEIdgtVgNbZ0W6eyrjYzlyr4TxwTpmVXGeL0lOHma9I8Eh1x3KaNOC
 UlzfMXB9N+F134r7Fnq2IgJlS5WTZx4YELZDwy71maSEVhmKRj1JmX+HAliNdGcuvQwU
 FdRG1RZA6AWQJc8OWZOp2ks/jlhsx7EadVBwgZYw1ijDuAViLVpXfng7n0ULTj9petlI
 k+/kZ4rkwe1EdSBYpEU8LbVBayijFe0pqqMWU+B7Cb8Bn7AEWVCzoDembPwOV/n3884j
 k3Eu7ZTtTf2TKcfAQSS/R/bRG0Nd+9FK4PblbTkSJze6pIBJXBW9/p3lrVpbnAoTyZiM
 pBwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780865193; x=1781469993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQnjQoXnP+z8OYaeZT+X+pfOXJDNjEgiA1wJQR1dN90=;
 b=ozJibbQPBn3tPFH7b6n/cNVlM5zTZsIfSZvU8WrwY0YMLDjmR/mTF//BnInDh3GHnA
 aHO9cly/OJG/hhj2triv6b+lULnUp6OoVR7V+EjODUPkxeLHxfnCoHRf/ISbXf2GSDc7
 jf6c7yAbtZ58+Hp0UCl4G8QeQoZKHufgeuXDEIN3kQ02HEclFDa0qRxL/qwhXEdEgB7W
 jxMlmgYgnCnuxaQprt8Vi2fOVf6cU6y4mpoDpfM6BJUvePXcRK6P867i6VoImzsiGy3u
 FRHQg/DF2jOOIFIOvJ+7rJ7AWBA+Oo37H1GmD2n6N4zGC9Kecz0y3mnyjX4zwnxHcxCS
 YVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780865193; x=1781469993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eQnjQoXnP+z8OYaeZT+X+pfOXJDNjEgiA1wJQR1dN90=;
 b=tH+qHkYpRZRTQXM6I3Vs1C4uPYQfkhsUkRchWkT2yVwcXluNIA2NkRulKMifdx1eAf
 MrLTa9T3KsmpyUMTX+MFVoUS80BBKV8y6fdDpT6yXnjf/Oc325FFoMFUtzMHXYOj9pOv
 17UoPJ/h7eiW/0OfpV0qGp6kcjWIkUFoZzDntNLrRk6RDpneFsVbBdVwmKzvdk9ggL7a
 hIXVYc8df0a9Ue4HHT0BXflyVqpYWkrUCDmWhca4HCEjdgKehFsquNgWBYJBYyIxECC2
 qO3UUWV8j7EIDiPfyA+vuXQ74J/7OoGHapVSW5RgskXW1wQAVt9KxfwzVTf7iuiY88UH
 7EZg==
X-Gm-Message-State: AOJu0YzeRs1jx9WG8g2iJDslQEtCBm22sRzXFp2mEJUfslOSByxoupPa
 Ma/dSvyy/dEKt49QINGQa9d+XjNxC/Gv/oE6z15LqyoSuBuOZjoDg4hFW6sfwBN7ZXTYqyO8fgz
 zeyrf/Aq+ZdZBBjBoYd5MSCSv84OdXXc=
X-Gm-Gg: Acq92OGWfLT5yX4lnQHGJGfJbwgTZxqa3AHMStADZh0k1lTuU9Oj3TH6tIKawjXPCxY
 t/acg8axrfZkmjmTNFbDAVmSlkGJ8Ah3SIDNQLPDsln63Z9hRtk2ppxPXe7wFqBC+QlRjAFQug0
 19g3NYpLdwrogsvFXcelPcJaJ+hks0wzm7FTr95Drz+53Ez2z1QuePphNdB3CBgf9/qo4Jj8NsS
 Uq0NOIyrp419Xp73yL+z51v054tU/ANbyUOK0o8dt6NN4ZDYcBSFRFWzFfIn9h60N1JW6mI6ndL
 d2Bmu0Aqk9Pc0rx/4vE+uCMYmbINwiDz91yYDt/SWLZmarIft/p7MCno/P6TnlsAG5fBPTKjYtL
 xEKjk6YfG/9djbeJZNlEbwYLXjIHw0LVbzTn7
X-Received: by 2002:a05:620a:690d:b0:915:8865:dc01 with SMTP id
 af79cd13be357-915a9da7f30mr2206249685a.46.1780865193005; Sun, 07 Jun 2026
 13:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260604162849.199541-1-audgirka@redhat.com>
In-Reply-To: <20260604162849.199541-1-audgirka@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 7 Jun 2026 13:46:22 -0700
X-Gm-Features: AVVi8CffGr15_uQqnuTCg7lcEdGwrLM44w81uonYMbDbRlfta-OX6aH8XidhXjM
Message-ID: <CAMo8BfJMJ+hf5MBptz-sFojCLAYdEsiduR1xbMhJs2kN1Ju-yQ@mail.gmail.com>
Subject: Re: [PATCH] hw/xtensa: replace calloc with g_new0 in mx_pic
To: Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Ajinkya Udgirkar <audgirka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jun 4, 2026 at 9:29=E2=80=AFAM Ajinkya Udgirkar
<ajinkyaudgirkar@gmail.com> wrote:
>
> Replace libc calloc() with GLib g_new0() for consistency with the
> rest of the QEMU codebase. g_new0() aborts on allocation failure
> rather than returning NULL, which matches QEMU's allocation policy.
>
> Signed-off-by: Ajinkya Udgirkar <audgirka@redhat.com>
> ---
>  hw/xtensa/mx_pic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

