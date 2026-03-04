Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28547EFCE21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqKU-0002BU-5D; Wed, 04 Mar 2026 12:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqKS-0002BB-ED
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:48:12 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqKP-0007Ov-93
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:48:11 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65f980cea07so10647888a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772646487; x=1773251287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssWhNSFQfpSwFf4nPzCWQLKPBwntGdz23x0wSFtr1E0=;
 b=xG7yxDbe6jTfF3qGP5P6XHGUd82SbPfaE1HlczxwdrmYtO1jhzv8JodIf8Mrg8nB/t
 DTctPpdgCoyhy7TN2zRFV7VoiLeciJqy51CgrQlmrhWtPBPZCh3mnj4YNPF/uUFuhdDu
 wUyamfq4LPcbvVx4vywHKYwdY413uYPmSZ15eE3Q/z0BRM/Jv0rKcAJdBaz8/8PHLYkC
 qtFIotX19SJC+bIXq6xlP0+mlXsXlYaAWHNYkwTrwxYrXbEDd6+7iSaEUVlFnb/pBiMx
 TngCwpEV0ssNPd0eGVTtO++dmbqrRFGPckso9no6a30vM2gu1Ch3rbmODFAuKSmR2TnH
 X7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772646487; x=1773251287;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssWhNSFQfpSwFf4nPzCWQLKPBwntGdz23x0wSFtr1E0=;
 b=my9b217F7GbqkTrCedKZlnop/FJDDoRyVi9mz+h+LKE2rDFL2oWw4f+mZHSsQj8PXW
 PGAnKiGK719g9YHnhn9BUenjOeXeYE2JYGJ09ItgNbpODB5ZEhc2BpD6bn2QNUokaoDk
 pWJvLmfC+VygcSD9TAYahTVa268Sd8ISoMbVhP4QW2prKUMRuhohSiyZk47dP2cZLnWU
 UbTrE2betaSqTPjUBi9qUhDTtuQ4zl0Jgf+ngB9BIdfRCKaydMXzTxZtbvkEmDqpInpi
 c/4rGeDQ5hQ5AAEXC0bgU4zO7FAW1tmKDKmOLNbcRQI9xs+G35Zu1sPGzxG2UzKdjNa5
 26Uw==
X-Gm-Message-State: AOJu0Yyz8aBQOXeiiN9Aq/UvJRJ1RJ9I5nNEvwTZgnKJWzN9PpSHpFSQ
 xCsvzKxbKMgCW4v5wrWRW4iIdzvbOtz85wPM6VsUTxvbgh39teBTro8pz1wXb4/qirp1+9vD9gv
 H0FJA
X-Gm-Gg: ATEYQzwDwYG3RN4iYrGwsKwg7X4xiOCyNMKfYVysWr+6BneCrAdKXewVNtAbNh5EhCa
 bmnQCthqvMWNbUhdwOigZ+CjB39Ljxt/disNe1KYF+NhcQvyp//fT6jIKq/ZmaqVrOEkYmqRJ8V
 iBX9yRYGwbtjt5TzO7AyunHdpu6Lt1m4IxM2e7kSRyAjqSXYqGd6cYn8d+ygHQh0o0YK5fFxUf+
 eGIATfBHJq/rQxe0kTuIHTvYQdakX1nBAV1IZ568SoIziBwBDUWvGjl5vWOVy/Q3TfU7wQnaXJD
 NYHhGdjN8ZQXveS0ShkeK0btM3NSH3L1E+tc5DhFYOl13Y3YyIXS0FOEtWCjqzekZav62jHstaR
 iHkrl9nzlDxLpsxyg4QX87xkxDlSLE+GPHjFMzpApYyqVttFbjR6T6htLg74CZFtT2t4wZToiKp
 SCtUV6pVuFqHt03Ds/Ljejn5k=
X-Received: by 2002:a17:907:3ea8:b0:b86:f999:15ba with SMTP id
 a640c23a62f3a-b93f11a5676mr202811366b.18.1772646487026; 
 Wed, 04 Mar 2026 09:48:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-660eafe7051sm1014974a12.21.2026.03.04.09.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:48:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D7A7C5F832;
 Wed, 04 Mar 2026 17:48:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  laurent@vivier.eu,  brian.cain@oss.qualcomm.com
Subject: Re: [PATCH] tests/tcg/multiarch/linux-test: use portable
 alternative for dirent64
In-Reply-To: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
 (Matheus Tavares Bernardino's message of "Thu, 26 Feb 2026 04:08:18
 -0800")
References: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 17:48:03 +0000
Message-ID: <875x7bpju4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com> writes:

> dirent64 and readdir64 are glibc-specific and not portable to other
> C libraries such as musl. Define _FILE_OFFSET_BITS=3D64 instead, which
> portably instructs all libc implementations to use 64-bit file offsets,
> making readdir() and struct dirent equivalent to their 64-bit variants.
>
> Signed-off-by: Matheus Tavares Bernardino
> <matheus.bernardino@oss.qualcomm.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

