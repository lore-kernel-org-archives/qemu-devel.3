Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0A6C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNck-0001dh-Sg; Thu, 03 Jul 2025 13:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNcW-0001d1-LQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:21:12 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXNcR-0003Rk-2b
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:21:12 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso134234fac.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563265; x=1752168065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7h8WlJzQAwJeaGJwL4lYtEAga+6iWiErbvvG27Y2RRs=;
 b=nSNqCKLGeKQmtZ7c49uNYN9UIwLaOo9A0k5nGPbuuhKpgYPSO8Z8RJwJvStWNM1qTK
 GuHLV4hbU7nl1i03Ugn2ZtiPK5YBcBJ3ET4jPnF6p7At6H8zAC7vSg3x1t/3q1O2i2R4
 WLuSk+aQq8zWhuD+lN6oFWo1evRzDDFRd6EBAdy2Ps8FIzGCKhUJvu/u1NGZOVuEPf1T
 YgkORWr8g29YognTnD7oBCEV7ICfrKdkqc7WkkWunzCAIBEFMXNcnJ97cDVqnoswKyaI
 Vtt42BSvlojv1JZ6ImU5/MSRpVF0LObAJ20mk3wxSadrDqFoLUQNf/NsuXwI3J36z/uA
 IV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563265; x=1752168065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7h8WlJzQAwJeaGJwL4lYtEAga+6iWiErbvvG27Y2RRs=;
 b=Q83z5xB48ATJfm+BSpRC0+Ap7rxqGYK/Cyc5SOHDdTYT8+hLLexk0+CoFjbkm4hfyI
 3r34xQopJmnr3iYDCBojkEiZQmPbS6up5OdOEe6cR929ndwwRG138x2Qy+xtIUeHEYI5
 3tgOwmS7QB2IpO6bAyenav0cQJkJug8mPQcmCc9NPdCaqyDv6kLCwV7ELrfnqJKb+Vrp
 ZqQPTmRx8fuenlYiuPoehUX0l3Syj0ZXpM81R/biGkop4NMkEnBUVub6YgTjVEpUUzry
 uUFiuY55//jzvchElxTUusB0WtplazL25yiVZrNa+NR8cxtHQ/2GVI+UtA812+fzEIav
 +a4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5uTzErMkN6Sg3Ysoy9BOMYu2FHGFiElsjpok7b+2pwhzVFxKZIPFNH7mxLAUlQsYEjq4ogtK5C/pB@nongnu.org
X-Gm-Message-State: AOJu0Ywwz1fuLXTZKU8qO/wY8wqkuOCIKtPKX5dTR9Z/lT/9gUMQEsRe
 hQm5Ut2JTozRdwgW138FbWArfacUDN501Bed+NzpOg9tkrAxhJxZ7lmdqYPZ48hzBPs=
X-Gm-Gg: ASbGncu63Pk7ndWrTyB/6DhKxVm3//ubzdlWvEDDjDeZ0/sm0gTnIitqY9loKWt80lK
 K3ADdoVwncypmG05ejZja5bNLZ25pDBG5gPNtE0vof0oUl5RSrf/rY8lCexrdRqcud0IL8+cOe4
 J4P/lJGPhjsTcoqXTu2Pg9abA9xHQ0E6MvJiM6tlk2vBT8C1jlqQ/2tEnjrDzEeCANIDKL77kKM
 qxbqiMVsqGC3+JZ/X7hVPznVAhnfu7U5BnzHoIsB9wNqkwZiUWUYyLUVVmsrUy/c3nHqBitiG1S
 UOhP8fPFnnxT4Ih2sT4b67Hqq07vORE6OEK4OPJe4UOHSlRUOy4fBuk3sH+rsSQWqGdEPDSxaph
 g
X-Google-Smtp-Source: AGHT+IFfHE4yB5fAUuSO5Mj6VTOUKhtk72Q+0rBdtIJQhhxI/8C12HLIZmvZANidb4VCxRuHI6DjpA==
X-Received: by 2002:a05:6871:650e:b0:2ef:eddd:690d with SMTP id
 586e51a60fabf-2f5a8ab9053mr5536944fac.24.1751563264745; 
 Thu, 03 Jul 2025 10:21:04 -0700 (PDT)
Received: from [10.25.6.71] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f790209b9fsm4002fac.37.2025.07.03.10.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 10:21:04 -0700 (PDT)
Message-ID: <22775328-96b9-46ac-b374-40ec73111ff9@linaro.org>
Date: Thu, 3 Jul 2025 11:19:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 49/69] accel/dummy: Factor dummy_thread_precreate() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-50-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250703105540.67664-50-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/3/25 04:55, Philippe Mathieu-Daudé wrote:
> +void dummy_thread_precreate(CPUState *cpu)
> +{
> +#ifdef _WIN32
> +    qemu_sem_init(&cpu->sem, 0);
> +#endif
> +}

Incidentally, why is this not in cpu_common_initfn, the instance_init for CPUState?  Given 
the placement of CPUState.sem, that would seem to be the logical place.



r~

