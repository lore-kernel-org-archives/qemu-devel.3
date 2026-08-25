Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B325C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymux-0003Z2-LN; Tue, 25 Aug 2026 04:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wymuw-0003Y9-2l
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:54:02 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wymuu-0001kl-L8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:54:01 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-93738ebbffaso218736385a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 01:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787648039; cv=none;
 d=google.com; s=arc-20260327;
 b=YO/iIQSLtAMnT0hFb/vbJXy8t2acVVPSuQ7QGdoHpyARM2XuvP45ZOMM/EeSXMuUgd
 bjLQye4I6sCxmoNL9xtPT3oRPOvZxWWFAdqBKA5UZZ5YlqYyBZ9dMbPdsKigDNTScdlK
 cUu8nmIyBsjPUy8XJouqotU5eXIG92kRvAK1uPMtPtqa8e9q7u/6u+o1yTCpeOq5S+Q6
 KP3TvWowOKRZrutFjARU8QPh3lSnB2VvpOnR2r6kUyBA8Q+lo333adri1qQd7QKMKUTW
 Nbr1T6POSRoOJTTiMN99o7pCI2TQsqnB4dGqDtlQCorPwvQOD4dxxBCtoWLFHCq9pFwP
 hKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IxATitYurc8EbXYI2BSj9Hs3kEcBruMDQ56bb7ZIbcg=;
 fh=SO5jAzDLUwmOKxZceorCybjGZEi7Nk/8zdjNuHLr7ro=;
 b=mctO0rAp9+UjNwdU5WlTuszvGnNGcFldojWcFGImF7NjdiCHSeguhte9AbKNqcHuyz
 lGIrtD6pWcLWRc2OH+bzECzGlthaGmPuLkbzT0PWsPvBLMk51qSqsltHX5Iq/gF29Ck1
 DmFp9fGPt4BrEy5BmEewpUQRPtzktMpKKT0ml3TRyff2i/7OaNNcEVcdp6MFyw5bDt1Z
 AOglZ0xftz+GLLCHTgfHVa0wynxkE5F04y9KEATgEqX7yowZH6pDgDF4XVPAtyR1AcCB
 4Cj4aZMrgKiQUtJY1MEDxZL9jMcMwJnt6p9RdnYaZJvBo48zi2pgGr1Pgrw8Z+qTWfHk
 C5/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787648039; x=1788252839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IxATitYurc8EbXYI2BSj9Hs3kEcBruMDQ56bb7ZIbcg=;
 b=AFyq+X6RZmIcRuxrROboRrqv2KFoTUZWAaDeTnYk7RYWKogNzohIynNze0Howa7oJc
 wdU03bDSRwaESW3iyIorvznlu3DpqmDVLJQX73Q3xAMU2UEkHKNLgk9uJY+L9kQL4w6t
 IBIygnJTv/cfTgdx0b+7mDO1AeJo60J2Efq3cZX+GeovwdxWNKdwiv38WHyfDDnXRPez
 vd9kE7yhvfBUnR1wOW2rY4udSbpurfxkwNoAjV6zLDg0S9rYIksIWzldYegdazMYq3MJ
 7yo8KXSP0gJB7nIqL638sWfU+cUHU5nkCU0UFDfsi+R52smt3CSBPfuCO2PhX2N/98Z8
 QBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787648039; x=1788252839;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IxATitYurc8EbXYI2BSj9Hs3kEcBruMDQ56bb7ZIbcg=;
 b=ZfoSoOZti+114XnkyuM/dBY8pubZgzSRMPo8y1atkQgTut2jDTGgQo3oKBv5Nskz6y
 IZIlY/L1/GICDz1hUj3OZCPkwtcIL6LHzOP+tauSk7t6ubY/pD/BH3sZPM8gEnS8Yvrq
 ep80cHBQyd4DS9/bTpjipKB9WJSqt9RHhLVyz7CC84DvUQsbAOOgvjkR1nD5Rgy4QVVA
 eViU/favAn37RHU1bKP2yw5xoV0Ck9hIhkp9h246i1p03V8RfIwEKWQNWkDK9KKPwwIA
 UuLANjqZebxh120lIaTYEKcY7MsCXacSKJXpMHhn7++99OzLD+EuhNk8ua4cP5tDyKZX
 oVmg==
X-Gm-Message-State: AFuF++kiwqf4lOF1I8cpAe4S/94BjPwA/AgWrzues0OftpR+DdkBB/b4
 jsC5kdvtK7uU+gzgRqokYOuVDDluiSc5aXb4oHg4Fq3Ioi0b1bbgslgUHScaOjNbfMILygU9P++
 9sOdi7kbbZm4rg1IxLEj9hjSCdyxYWmo=
X-Gm-Gg: AR+sD11GQfoYDZhvjzN0J4RFkBi1IJBWaIQI3Vsufmdo9XeaINKPezbdfwEyNFfP5dy
 nZfEeubk2DhwyW9kO21LH1DkUSv2kWrwwK3/VOsu98/P7pKwEqPeHr+BoWhhg3LpCefGZTVA6Xc
 c0rEJEtxa6a4Sx8mD0ZqRh/HxhvknTal9CaXDA+co3UYPeEgj80rLA9LkNxOlvJl0WRsPrUVBbm
 egPSwBU6ZCF3StDndOgJDNFb6qm2TeRSFf+8gUqGfDTYEzFSsdN7fLbAt83igGI4f9L5bJv9qU3
 uoJL07lREOD/EG/rLTkwBepenLafqVyZr8PEO1AisuWcCV2qDo3oflLHL0d3XqkZnyC+FHG6cl8
 JmpOGPXa02ii0oirumIVuDa6PpSUfBNqXTcigjscQztmzmzof1efgYepodoUAJx4=
X-Received: by 2002:a05:620a:1a1d:b0:937:6771:e7e7 with SMTP id
 af79cd13be357-9376771e8damr829132685a.30.1787648039244; Tue, 25 Aug 2026
 01:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
 <20260824111711.26297-19-philmd@oss.qualcomm.com>
In-Reply-To: <20260824111711.26297-19-philmd@oss.qualcomm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 25 Aug 2026 01:53:47 -0700
X-Gm-Features: AcwNN1WEwK2DUZH45Zj_m2ROUpqkMXxheouHHKZZ_3nAzeD16f7z7iGe_QZUvgg
Message-ID: <CAMo8BfL88QP4WCRc_X3AXHZNjXp5L_6W1spUpZg06vQjR_fceg@mail.gmail.com>
Subject: Re: [PATCH v4 18/20] target/xtensa: Constify CPUXtensaState in
 xtensa_replicate_windowstart()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.004, HK_RANDOM_FROM=0.999,
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

On Mon, Aug 24, 2026 at 4:20=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Add the const qualifier to CPUXtensaState when the
> argument is accessed without modification.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  target/xtensa/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 442e98bd1ba..49d6ad9083d 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -708,7 +708,7 @@ void xtensa_set_abi_call0(void);
>  bool xtensa_abi_call0(void);
>  #endif
>
> -static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
> +static inline uint32_t xtensa_replicate_windowstart(const CPUXtensaState=
 *env)
>  {
>      return env->sregs[WINDOW_START] |
>          (env->sregs[WINDOW_START] << env->config->nareg / 4);
> --
> 2.53.0
>

--=20
Thanks.
-- Max

