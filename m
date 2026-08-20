Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CD3C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4bm-0007Vx-5R; Thu, 20 Aug 2026 11:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4bk-0007Vb-St
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:23:08 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4bi-0002sw-NI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:23:08 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so867493a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787239385; x=1787844185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iyBfy6otSXwYAVW+Hoyto6VIuvUw+mnsF8n1UO+xuRM=;
 b=lVAKO08jnc5GIX5/aZUso2lz2Pw7+FRqnC9nFllI1RufWr/Kuvg0fjcRL1F5nE5RsO
 VQIOY5h4ndixdaAovRyQJ8nPvM4YNXH4zM5AH+6ko2whdG1a0QiULtn1N/5HcWHNembI
 bRYh9FhflhJ4bNpOwG0ouBTm6TrnJLKWQujdiUn2CvQKjQ+V+gSq7xLg87LHC2WWzB7F
 Z4L7230t6M8JtA+mzmO1MJuBh5vUq/zJA/qk1BzDbijfhYfkSCdknC7PFsimdDWi2YPm
 jPDpvHViwJP38Ogdj0h4b31Y51Lq3ZONCNaRKEygCHaNEwDRhXJHWygp3//dJxmfHk4x
 0LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787239385; x=1787844185;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iyBfy6otSXwYAVW+Hoyto6VIuvUw+mnsF8n1UO+xuRM=;
 b=qasvyisU1FxtOk948gARtBYAJYmgAfbj2x4+a9vdrXF6g4Pr5io1XlaFtpnlAFIM/B
 6ezlzi2B7pXv1Cc3FcPyJXzDKGYjQk88dvyG1ON9nWPgZjWgeqWspDb1WIidWTjbjcxe
 GRrMsnZLMy7Nr2aLKWByrqTWrPmhDSHMKBIFHa3jDWDwFom6qR8BOI/DcLfv6UzaLF2T
 I5C65zTin+XS9XTYEOEcxazZ1qHmhrxQqvJUQCrnXqEBw+5RcVPHEe4mJC/mPPrSASeq
 /lsJD6bzXUhnsYMqxCc18ejP3H2dOpYuNUG9m8ltxAyDDUss1d1Zwp6RdBJ8DvSM5t3Y
 p2Pw==
X-Gm-Message-State: AFuF++mbRmqTZUdyQC5TXVVBBmwcJ0h3CPmIVicRUpfx2+yxpw4fHl8t
 U0CywDQAVTB897/F0B9klWL/Q0r21libnwGAhuZeNeqCYafYPZknmJztbbQS6T0cSSfHjcqK1ml
 HeiAP
X-Gm-Gg: AR+sD138EU3FpGAzvVXXzYo0sGqdJ1Qtdv30S7hdSvDhzcvwJ7m5CkoXMhafi+T01dD
 kMHB+aO8TzfiAwAVgiHLJrZ+gcbaDYNL3u+I0FXaZ94k1yNtw7roYo01FN6Q7FdMxrrUDPpeZi/
 Ya1rAyaNwKw261omf0XZdrI7GBAJgXDjqBW8qmSrn4Q9COMMnOx6LdBwxze3mCkNqJFAhFKVplg
 0Vw+TSxJypOQ0cukgaRXruyr2sb8DDTU55psi5yUNt8o4iWYOGC+VV2APaAEOXP3g8Bo+9xditj
 9KgQLsyfmJBvG34Gh4r0OZye97wf8ZPat3oHT2TTiiHGSki86X3odEnEYrAmS/+DmgA5ycAQPpq
 g48Ae7c3O8/qihocgOkcTjv4E3Tf/GSU69XCkutqoHoTvrUzOtxL+EG7vIpoPMzZmZ+iN4AAdgE
 G+6z6eyFn8CZ0h0GHgtgN9cn2xgILirFQM4WOTnMdQJXTdNBAAn2LbPQTajj9aLlgMryw7DXpfh
 jh/00AfmyJzIUknJZMtSBvUsv0zfhH+V5p4GMKara2+gNuUcg==
X-Received: by 2002:a17:90b:5104:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-395a04e3ff5mr8096028a91.2.1787239384832; 
 Thu, 20 Aug 2026 08:23:04 -0700 (PDT)
Received: from ?IPV6:2607:fb90:331d:db6f:e6eb:39ca:2251:a26f?
 ([2607:fb90:331d:db6f:e6eb:39ca:2251:a26f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fbbf8a7sm7297439a91.16.2026.08.20.08.23.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 08:23:04 -0700 (PDT)
Message-ID: <756add92-a2b3-412c-874f-faa98f07a582@linaro.org>
Date: Thu, 20 Aug 2026 08:23:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore: Document architectural interrupts as not
 implemented
To: qemu-devel@nongnu.org
References: <20260820140401.26482-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820140401.26482-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 8/20/26 07:04, Philippe Mathieu-Daudé wrote:
> As mentioned in commit de680286b52 ("accel/tcg: Make
> cpu_exec_interrupt hook mandatory"):
> 
>   > Tricore doesn't currently implement the architectural
>   > interrupt handling.
> 
> Add a comment to help understanding why this SysemuCPUOps
> has_work() handler is simply always returning %true.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/tricore/cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

