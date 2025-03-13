Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC01C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 22:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsrUm-0002Jj-Vw; Thu, 13 Mar 2025 18:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsrUk-0002Ix-GB
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 18:57:42 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsrUi-00035o-NX
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 18:57:42 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5e34f4e89so2752249a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741906658; x=1742511458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsHQf/65xSZUBKVfcq9Ga2fEKqwVE2VdJKgAHBll4i0=;
 b=PZq5t7aMwETvGA6sPzDLJJ75ML4Iir0Bf9VhWHLaeUxoJR7U39jjLgxK+OD3Cgx6Sm
 fJR/+TtSb1dhvs7VJnv4cEdUJmIncXLzrHhawn0tq642SFrvrg+S9iE+Sq/3nDgJxW4Q
 BbXJ6YOHweEdfflw04vsaM6ztOCFfQSoYG6OezqI+fUW62otJvnKokk7753g0MWx1w1s
 YIdpzWLDeK6jOjFAKJ34+oda748eMUe0rTFYJ+J1q2DGtYwZOgEKdj++aKkEykgOcKWw
 0Gr824TrTtOhrUwuiyUaY7hG/p+6DYZV52HJ7zB1aOe0EuGnrVsNMmn+4m5q8+CKRrz2
 Uwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741906658; x=1742511458;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HsHQf/65xSZUBKVfcq9Ga2fEKqwVE2VdJKgAHBll4i0=;
 b=w/26FhSimyzJILbEz51UpBw0UzMRtCue+2XC3LOMsHtPAFtG3QKHqGDIocQOO6qb5n
 HS8zeU4bBrtREk50Hgp0Ie0L+gT8t8WrNOzp015mnmVI4Bbo41xWu6UQJWMS2BXSaBbm
 zN44DZnxcg7kX0WNH9frkLc/7/o+jBaaSekXCHrgnnJ+2lszJjSEP68o1YpQm8W5DuNO
 2Ml33Z18hJM5HBMGW/kq3iNW5Qqz96QF6GwLsQQAvCTF6G+0ocjiuIoGprJqFtX4Ae/9
 HTW97DaXw5WI6yjr9B1OUVSB5KZ8eznFrZ63omhoxjdQDPDwbl4pjDzhBUsZiiqYKJ/f
 HaKA==
X-Gm-Message-State: AOJu0YwwinqiSNTdhgNCUy1aMBpsI4uYVOvvV97WOfxG28iXah9kaNJk
 SoWxsfgcjKFdIzZExLcWo9he48Knedl/toPxyvOsXRBPyQIxj7MSC5pQoN37ogD5m/8RAPAKnNY
 l
X-Gm-Gg: ASbGncvVTsXYwDvRiKl4vtbt1okAc1neHjnopzGU7zb8bIOyGYDkwtahgxN6aqM9lUW
 QHMpXvaMpwyNnv7JRneapg8LUeTM0wWiSNkrmvUYVGAWan8GEbcqeA4c4XcUfiYv4bcekR7oqaU
 tR4+cPGPIbFL6Mqg/BXTJUvLw+u7hxYTXZ+3vwgjFKd0pTaUvsizGdUJOQ6z8s+4+nZfCJ34on7
 26WAIdj2Iv+5qf0eVxaBKY5wVHHMnhwpLfvBGVOI5yz+eKmg/9huAaSDzImjUfqrNfAx+kG3f5n
 0IAlKqAGaSxI4CqBLOeBZhVZWXICEvcRlpu5vUA1dvqmUtM=
X-Google-Smtp-Source: AGHT+IE8sCDn86YYd6mlV0lZTOmW5P9vi0TR09EHQnjPTew4PHMn66qO8EnIb2FrNEHgBffYGf2LAg==
X-Received: by 2002:a05:6402:27cc:b0:5e0:8937:6ef2 with SMTP id
 4fb4d7f45d1cf-5e89f92db6dmr382518a12.8.1741906658630; 
 Thu, 13 Mar 2025 15:57:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e8169792ebsm1183447a12.31.2025.03.13.15.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:57:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A30E65F873;
 Thu, 13 Mar 2025 22:57:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH 02/37] accel/tcg: Build plugin-gen.c once
In-Reply-To: <20250313034524.3069690-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 12 Mar 2025 20:44:42 -0700")
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 13 Mar 2025 22:57:36 +0000
Message-ID: <87zfho35en.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> We assert that env immediately follows CPUState in cpu-all.h.
> Change the offsetof expressions to be based on CPUState instead
> of ArchCPU.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

