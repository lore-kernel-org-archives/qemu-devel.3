Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7137CC5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNtjz-0002Dn-2N; Sat, 07 Jun 2025 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtjv-0002Cg-0Z
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:37:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtjt-0003yA-Ep
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:37:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a3758b122cso1874829f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749303456; x=1749908256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ds5ywMLyUbUFb3Gf3zMR07mdhdtOfPLp+GpI7ibPPHA=;
 b=A2sdBuNgI2RTpWUNvMipGUX7dTZAqWajeftIeKullksShYlclZnV6RJcDUsjzCG5f+
 Werj8dN0yanKoVTNQ2sa75VbXWNFa5fhk886ng4dIjDCdLaupiRDtGedJmPL3Z5Rz3uu
 GKGz1efOigvNZsrBr25sfgrj1P5T8O/Oa1arICNuuisE5/A98qFJvSR6jTgeKwbTCLfs
 IFjDEbNsLUZgsqNiK2z1nw3xgnJHR8rL8BEBL+iV+QomAvuQ85JfznKzSzSwWp3ZXSo9
 TbS1rQE7eJqay/Ejj9c3wqZG1a6OyT47L5dR7hahI11DDScHRz+cRnP5B1vLmPVxyCTD
 VXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749303456; x=1749908256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ds5ywMLyUbUFb3Gf3zMR07mdhdtOfPLp+GpI7ibPPHA=;
 b=BU/0elM3TlnBF6WgN0B8xtEeJGvSU2b2WFpDhj9NRtvMEjkhK/Yl15ZFv2Jtm5vztz
 Ak6XsUDRf0GxLowQpDBXfiH7v8vYRzpOF05szRwv1JUJPmD48/pbvxuZb4G7AXdU9e6y
 7LXwDLKcsH6tH5A16dn8sSlcsAeA5fj9KtF3ws3jL1OFwCtj8yAu5q2dbStoe8AzZbNc
 dInvpELck/o1uiWUQ3iiO9akV3VR/uvtQ/Z70P0cZCRAoJUE46RL+6HScC3k68wZXQjg
 azPNtjc/5Lc3kWYQeJ7RRTKLDgemwYLAqFzo16ZE0Qzd9GWsWQR9gAg9WJFOTHZSWC/Q
 BtIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM9AJBABxCJ3XuSjZue/JZHSgnSeMnIM8oSq9pkG+ct5falZ3YRZfg9wM0z5SN4gyMUJrZuOwvVRoX@nongnu.org
X-Gm-Message-State: AOJu0YyJ64Fdx+EscGtbOzvFMoN8HZ8nMVAZKGZN78dJu+aa72jSBNfW
 Zi8uMZM6SOgNmAP0YJt+G8hQMLDUiaTgw+WXdI9iUAhJ0jsNzbn1Xkh9JE2IeVOWRCM=
X-Gm-Gg: ASbGncun+7YyR+PIqNDOmwqZxtKRS4NcLyEIgw5UlGrBp0wSOoi2y8NohXolijn2rB3
 OHm+f84VACANs1UXMqDIozhoLQJ0hBPGZO0xwvsQdMzDDRPlXjHz7O/lin4M/FG+lBqmbjhEAKX
 p0VThGe4ZZADTWJ0kvHFwAk0A/c0gxymfI8KdnpQxdNkMFByV3zZMrgP6+/+NkWhV5m2sAbpyJ2
 ER10webLEruQmQYt8pb9WonBmZ7D8FxThjpSPO8PKqIkSdR48FzFE/aJAnmjlQS0BQqR3pDOnkL
 8BoEPi3HHzgsm/yl+YeUMpQaIuW5GdbCH1ZNXx5G48Kwlexm8xGMuTprwwy/uOMH6ALBCx1exMq
 I5ucFGEMH+a9cDonnXkjsVnPzoi1mBdwI/GlxFSuEr+mKzvU+ug==
X-Google-Smtp-Source: AGHT+IHULdEnUz6Rrxx3o3GN1cNyCApL58ILxltieFVYasHMYYjBK8c2uMleqBmfYKWRKdk15FRCNg==
X-Received: by 2002:adf:e705:0:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3a539bb41abmr2364169f8f.27.1749303455755; 
 Sat, 07 Jun 2025 06:37:35 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53243688asm4763934f8f.57.2025.06.07.06.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:37:35 -0700 (PDT)
Message-ID: <021c7433-f4d3-437b-8cf0-00856f32bfa3@linaro.org>
Date: Sat, 7 Jun 2025 14:37:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/19] accel/tcg: Prefer local AccelState over global
 current_accel()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 6c5979861cf..4b1238ed345 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -82,7 +82,7 @@ bool one_insn_per_tb;
>   
>   static int tcg_init_machine(MachineState *ms, AccelState *as)
>   {
> -    TCGState *s = TCG_STATE(current_accel());
> +    TCGState *s = TCG_STATE(as);
>       unsigned max_threads = 1;
>   
>   #ifndef CONFIG_USER_ONLY

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

