Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D1AD6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTSX-0005YI-QL; Thu, 29 Jan 2026 09:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlTSW-0005Y2-Ak
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:57:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlTSU-00086X-TT
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:57:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so9094135e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769698641; x=1770303441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXcITGy9w0W3fyqFhyVbdgg7cvIr1bgdc45oKr7ecw0=;
 b=rh4TFy62SOxCRsSKgTIhNLby3TMTg7vKE9UDWLJbrEU2NOW6eMVy2E47Poh0Uk5Zq0
 m27zoPeVR6PguQfgduObjiSca+iYGW0dfHVP4+560/0djn7B/NPhao1XimTU4g8oDfLe
 /Lfqznh9IVZSJ0IleRDwWpHGup7lNtceG2k5tLyw/e2Bf9ODxrZrYqhpdlCey7KPtGLm
 3YcYtQWcXosb5hANPUc54IKfMhzfXd1AD6AlWWr0TGQaDqWz4Aznj6E7YhAddSDf3kcF
 xq4N1sNt07nm4R35FOXEn+eT4B641/B7q8XVB8WAq76aybdR3Oy1iCkYcoM8uKW5k/lz
 DrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698641; x=1770303441;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXcITGy9w0W3fyqFhyVbdgg7cvIr1bgdc45oKr7ecw0=;
 b=w1R9S9SBEYIfC4GsHLsygWM4LbYsUXJGaA0/Jwx8gz3xyavN05Duazx2Y41wDP7G/U
 xKurpOMkQbjK3/XOK+sl2/Q+R1bYaHf0OWTH6kGqutsSVnbB/cDB0NGxfRvG/VZFoeJv
 bjCKjOkky77wk5ibV6I4ybOmN7aMDts4Ptay2+CFHEfBoyAssaiDJL/xREumbwugFKgz
 qRavU+kJ2d8rzkGTmBCIQYdF5jshmnoRVAjYRlPvyiwcU3VFrek7Ht5NBWpxcNsKAkFr
 dFug+2xDaRbijBHTiiwbgyrBFSMr6O505t7AGh8JFQOHQVhPZHG5hfO4V7Eq3suCuVU/
 SI+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5UmUrfmMc0eWXGV6ILsfw0z5QBkOOH5K4ZKCQ2QW8speCf/kS6XE5RWT2tp8PV3rp6PHWOAQtCFv1@nongnu.org
X-Gm-Message-State: AOJu0YxxmVzK5uZ6xaoBtCkiKoyB5QeZ4lTCrJA98AeaY7soyusgPl3+
 KeE0l55SEtC6h8x0kjgIgFe/0B8v2Khp5P1c22gNS2Fep/n1ltA3HPnbLxKdNfmb+/I=
X-Gm-Gg: AZuq6aJGOuUXBU1AVJUD0P+3sxphR5p9SU1ErpRRP6BWK9f8pK6pnZBpGLBQocJJBfS
 emnaJKFvSKFsBBvNHcCp4tB+abAMR9gVO8OrBaabe+G9fg/PNsFVyF4B/9SeXTZjgQvhlYcUBoT
 98DVNH9wLqOJIEodhvCecHvc7t//sWJbX+go+L20tzvFXPIBZCeFHt/2wujharjjrozKtmn4fgJ
 3fg3TXfxwPA5BlRnWWmvDYlXvxKK9cmeifOxxaQcULURqfLEAmHALTRnKrUX6192wwp9+dIs6rY
 Jz1HGYn2q/7PjNQB3hMBK02HyHFAOjqItBgSoxHjzjJiFV4f0iFGGSlU9nqf3hmrQcfa5tzn4Im
 uT83K8fbNG45lZuPeZmbyG4iLAuxcDfdM1yotFtCdcy5MCkM3+L4q11eThk9EFsz0HW/NAPgdmP
 o9nq50TjsXllE=
X-Received: by 2002:a05:600c:6092:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-48069c3a7abmr113593505e9.15.1769698641399; 
 Thu, 29 Jan 2026 06:57:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm132828375e9.11.2026.01.29.06.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 06:57:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BED8C5F878;
 Thu, 29 Jan 2026 14:57:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 4/6] target/arm: Handle SME-without-SVE on change of EL
In-Reply-To: <20260129113455.1283266-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 29 Jan 2026 11:34:53 +0000")
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
 <20260129113455.1283266-5-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 29 Jan 2026 14:57:19 +0000
Message-ID: <87cy2s8o1c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> aarch64_sve_change_el() currently assumes that SME implies
> SVE, and will return without doing anything if SVE is not
> implemented, skipping a possible requirement to change
> the vector register state because the SME vector length
> has changed. Update it to handle SME also.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

