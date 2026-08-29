Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C32C61DCB
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OiQ-0001bP-Aw; Sat, 29 Aug 2026 15:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0OiO-0001bB-KO
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:27:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0OiN-0001rj-7V
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:27:44 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so2295896a91.2
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788031661; x=1788636461; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=68U8H/SyeNi2h5GHYG1tsi+lCsMjzDC5fzQq7a36dAQ=;
 b=WrHCs6rAdQO4l9u5Mi6T1/Q1Oxly8DaOdf2lwplTX7PeaEKByXVIliyZMUCnIDA8dx
 AcXySzOnKZs3F8eKGGfMeXkSv+AOpGgd4FPHTD5C0UOxu4N6DWu3/5yX4i5v8QSiTfnj
 GdqPYie6D6/Mp7eTrBkF2PwE2Sf2CWpikhj3QoCm6RH8UijaUVb0KdrC32say0nox2sU
 T8dMT8pwKJkB1td6+1TBetDrwikUKacEwy+tg0Y7GPsdspPEy3TyQLgjD7vQrbViSXiL
 n6HlVleZy7lzk2OfJ4H1RrukOlM2rfd50DnMy+9fSG+Gkngq3pshcyiZ/1R3fC+SpnYG
 8h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031661; x=1788636461;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68U8H/SyeNi2h5GHYG1tsi+lCsMjzDC5fzQq7a36dAQ=;
 b=rDGL9S/yUbV5kz02g8DAu30T8Bl5vHUC2soq+ALiJFA/7zfAUoyoMMj1xbDzXOPlAB
 RQogksf2lVIcB/8KSCwyZI+D9lZNtGQ7Lkd2YrGCSkYxRyUiZGHwdwzuUEx905iyh9er
 z6XjQ03fp1YSdVrbF91zwVtWAAkT+Tn3ib4zBJWtXqFnm8r9DjB+r334flFVn7qHGYvx
 CvLjWP0Ib8/aYgHry0LBlT6UJ1mZeGYQ9k7byGBY80ylK5O/PakL6n/LwbNYll8yO81q
 CWRvQWJvozg5oFFn3P0tAjA9ItCTpvwa8AlM81hIfD1V5ziOxOPoZxuMxkayvsr1tDu5
 Y9ow==
X-Gm-Message-State: AFuF++kUb5jDxeNOmiLxRXmZMCqmk8JDl/4pSK9GW8eK0uv70QO+J+4B
 PpLizMt8gbmc1y4xmHty5ur0vV96ldcbCJUxEd6kME6NEM6hzbexNsOBrZJ7fJJgBqrNDustnic
 eXBAK
X-Gm-Gg: AYBFou3BJYz5Cxhy60B/8H/TeD10qdbZ3WcrYwnZyyhqy40l6NA6BsaucS3UVyhCst4
 JSjg4K/ppc6pK5FIsO368RVaeBdXlB94NfVRIzqlA5s1oxJFjvoZWX1n6Xh5475ndFwozYxYS4h
 584dat1mSJWSya/JUQc2V+S4AlBAsDvOugdk4tfBJCc6B80LAkd5Te6fh2TIXMGUFpnoZqG/asD
 O78nXe2lXOYx0Wmvls02O4KM4afC2jtbgdh1tP5XNwEiJ20f8DxKQtHIgYzGVTqxNHp0GuSua0+
 HKNPDiTbD7e12AT0hOtzlmk+O1MX3MLVHJtgmWn0uK4B2js9RM33lo54UgJ7dwYtF+vyoA+P4Zz
 ogCH+KlKoneBeDrJo/HumnRI4MQtvVOcD5tc3xQexd8bXRCh07wTbmxUZ9i7eQ0blGPSdWvcaJz
 V1QCxfw56k21VoMc5GN4539zGZ05BT6wEVQgErO5UBhRLk/s6sGqbu+b9Cv1T/25EYCaC1y8Wqp
 0yLJOco5jPKYEcVCAnaTbydrAliyP3JEkjvd8tHXQ==
X-Received: by 2002:a17:90b:2f8d:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-396d0a3f016mr28592578a91.0.1788031661493; 
 Sat, 29 Aug 2026 12:27:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396dda7eb6bsm8175588a91.8.2026.08.29.12.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2026 12:27:41 -0700 (PDT)
Message-ID: <071bbd17-762b-470a-ab7d-f31342db792c@linaro.org>
Date: Sat, 29 Aug 2026 12:27:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] tcg/s390x: Implement INDEX_op_lea
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-17-richard.henderson@linaro.org>
 <CAEdQ38EaV29yWOAq7vjs-GxXQFpy+eMVnQROJCS_=ticYZnpfQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38EaV29yWOAq7vjs-GxXQFpy+eMVnQROJCS_=ticYZnpfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/29/26 12:16, Matt Turner wrote:
>> +static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
>> +                     TCGReg a2, unsigned sh, tcg_target_long imm)
>> +{
>> +    if (imm >= 0 && imm < 0x1000) {
>> +        tcg_out_insn(s, RX, LA, a0, a1, a2, imm);
>> +    } else {
>> +        tcg_out_insn(s, RXY, LAY, a0, a1, a2, imm);
>> +    }
> 
> Optional: could just be `tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, a2, imm)`

I considered that, but it does slightly more than I want here.

r~

