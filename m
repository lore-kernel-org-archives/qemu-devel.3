Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BF6C3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQMP-0003HL-BR; Wed, 26 Mar 2025 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txQMM-0003GN-IE
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:59:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txQMK-0003gw-Jv
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:59:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5ed1ac116e3so3307105a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742993991; x=1743598791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLWThP5RJlI8Sp2zxUy02RozxFdYqn8OMQLJqsK60xU=;
 b=D7nc5Ntepkt64M/NdibYg5E0q6+4R45Z0oHcFDRmF1eu+IHhxar9c1Tzm5zTo6WlOD
 wbr3VGduCXZq+OjfWiSrAAyUo9Lj0TBKvqOlloJ9AGlE+ThOcg6t6If8956Z3nUfQngl
 3s5NHvb1Kto1nf8FIXJmIjOEJR8xg6Kh1/po5g1gPWQsN5LCxCkKHwtp8XS2iyiW76gJ
 T8tqrljQq6neK5vemka2KRUXcKhploiDIPZlaxThb5f0qc6zNcnKjkX4VX45sTiTdLVZ
 rhFtMP89yu4hU4FA4ZW2sWZWz/Dz4mph/svjANHsNj17A3Jh+1P5QAC13mZsb7Gku4h4
 ZmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742993991; x=1743598791;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bLWThP5RJlI8Sp2zxUy02RozxFdYqn8OMQLJqsK60xU=;
 b=fpMT1SuE8DCS7ofKg3q2zey813PJrvtJSaDo8escUq5yGu4QBEx1p/SLVsw4RpVwp4
 PGBdKr3m5B6poN7gdkx8MJU44124++KL4tsCz1gvld1DfmxUJlhl2MT5c5DcokqSKqht
 2kkGoMk2DFHNZNZqsQKcLOpNozlBOLpsr7+xyIcpCr8IuP52JK4zkcuZIL6z56i+rZc+
 mziV5SXKBxMH1PlNGzllM6B2sSfB8RFdVYHZrRNyOlW41YimJnAz1nYPRnt8hFRRiXGS
 MY4HOBF/w0VkRvDtmaGGyNYNggDMldiViUcoayRgYTbos0JSU/ZxNGjwZVSDTl2vFph6
 jUSQ==
X-Gm-Message-State: AOJu0YwRF9/evzQ/Y5+sPmP/LZB46ygo+yU5CELLtOhwTdt8AuxAXfe5
 4e2XjKc3/PszUz45TyidrgRprKdupCkSdWD1Rb/bFNIhdZYh288KTRVCt0aveyA=
X-Gm-Gg: ASbGncuS2Lu9a4W5UVcMlsYFvqUlxp93XCO130VpKUSptjj+T+Z7KuZxJlhrYJVzCmi
 34WWfbXgiM4gFQq0aRtMpsXlIMT3nm975LibK2yRpRdorGCJkDbFiosvdtpXIllu0k+tmxoZ/PF
 qcBsZYLeGPAp46SxatODAR8L9h7h6FzrQh6MnHTEFZkjcxRUEUv7EpsX53xIdH0MQKF9mluYEzx
 QDW6XO8PePTp4H0CNkU3DPt7OYgem+ayDHX9CYsItr6jLxHBWIB+5thy+QITyNyTckdx43s7mrC
 w8n7JAi3zOnnXGbNzWt3m0DWKEq0+ElpusrZ//eNF0PwhdM=
X-Google-Smtp-Source: AGHT+IE4Ze165SClKZyPuYnYyy9nSco7MxgJMth8q3FPIMzRWwvq6xJaFnG1bd09WfPKXNPW2hXjgg==
X-Received: by 2002:a05:6402:51ce:b0:5e5:c847:1a56 with SMTP id
 4fb4d7f45d1cf-5ebcd4337a5mr17874692a12.10.1742993990656; 
 Wed, 26 Mar 2025 05:59:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccfae4casm9203023a12.34.2025.03.26.05.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:59:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9F405F90B;
 Wed, 26 Mar 2025 12:59:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Anton Johansson
 <anjo@rev.ng>,  Riku Voipio <riku.voipio@iki.fi>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Nicholas Piggin <npiggin@gmail.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  qemu-ppc@nongnu.org
Subject: Re: [PATCH-for-10.1 2/5] gdbstub: Remove ldtul_be_p() and
 ldtul_le_p() macros
In-Reply-To: <20250325130221.76116-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 25 Mar 2025 14:02:17
 +0100")
References: <20250325130221.76116-1-philmd@linaro.org>
 <20250325130221.76116-3-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 26 Mar 2025 12:59:46 +0000
Message-ID: <87cye40wxp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Last uses of ldtul_be_p() were removed in commit 78920b4ff2b
> ("target/sparc: Use explicit big-endian LD/ST API"), and of
> ldtul_le_p() in 39631d57d7c ("target/riscv: Use explicit
> little-endian LD/ST API"). Remove these legacy macros.

I'm guessing these are commits in your tree because I can't see them in
origin.


>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/gdbstub/helpers.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
> index 6f7cc48adcb..26140ef1ac0 100644
> --- a/include/gdbstub/helpers.h
> +++ b/include/gdbstub/helpers.h
> @@ -95,13 +95,9 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf=
, int len)
>  #if TARGET_LONG_BITS =3D=3D 64
>  #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
>  #define ldtul_p(addr) ldq_p(addr)
> -#define ldtul_le_p(addr) ldq_le_p(addr)
> -#define ldtul_be_p(addr) ldq_be_p(addr)
>  #else
>  #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
>  #define ldtul_p(addr) ldl_p(addr)
> -#define ldtul_le_p(addr) ldl_le_p(addr)
> -#define ldtul_be_p(addr) ldl_be_p(addr)
>  #endif
>=20=20
>  #endif /* _GDBSTUB_HELPERS_H_ */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

