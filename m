Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A703FC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0To-0006fI-PJ; Wed, 05 Mar 2025 20:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq0Tk-0006de-BS
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:56:52 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq0Ti-00011m-M5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:56:52 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so278016a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741226208; x=1741831008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfH5uMBzMzEjrXJdfCIUqH6sA/1i3aQdgkki7GF9JoY=;
 b=Hp7ol/mkn4mFgT84DSNqZwc2s69EVg88Tt+yqc3K0W06mX/s2hmcHKWbAicV6kpSH4
 Etw58CAMnZ+iRi7JqeNk/Uiz3q4p19EjbZtICQuxD2RXHnPl10pC9Qj95O111NFWGYyr
 Kam1EWsW3tmqJaL0blNBuLvq954Euve1QZPdtmcAicVPXvyICUzcwdHam+4vEp7RJq9W
 nFuvz19BGER2zaPlCZ+rpB58Qb2VuSRUxjEba6A5mwlp8/5lXcQEXd8146c/W5UmC/nO
 AeWfPGcSFA894RxvKzELSun/rqdfmuUKOEyvQ0juNzlFAsI9/lAEVzlz4f2tM5/91hP4
 jgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741226208; x=1741831008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfH5uMBzMzEjrXJdfCIUqH6sA/1i3aQdgkki7GF9JoY=;
 b=R8vxUHCaXvQB78uzth1VIXjuy2zy+csWFGaRKrI10SiO+sRgqxMLuvetdbiuGZcUL5
 nJUUlJPh5JCY3QIvQHdRIy0DRsIEgXbETjJCGa53UmFYnbB5WxR08g2iIHZAfKhI6mNp
 PiiZEYiCCdLsLqq7vAnduxTku/rvapaDvb7Qd+nlXRFn3GQGAzvxnS0YvPmU5okCfyyO
 HdIqKqmOXW4t3gehtD2IYDby2nZ4kUuAeoqdu6MixlVIwpUrwc6UWBRFdLDSpv1A0eON
 UdOJBTDOHACGGhI3bmDNdwTil0kDGHnBvuQ0TbLI9Px/pJffRobrr0q6dJul6tC3XS3B
 LKSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Z27/9CGWGcy1ivIsgOx8ZmAiOOagRwbUxucra1aNTPfvNZBIo/eAlx1j6tbFNDB5oLVJzJEyeWZE@nongnu.org
X-Gm-Message-State: AOJu0YzvsTmnYNojoQpwa/rTuWSK99r1z49i/d4TmgansuU7lM2VJ4AI
 Jh593laofgSHS17I+NyhSvkyeJdo5sa25LjvZAgnUDQuZKa+KEzOheuZ7SgTcL8=
X-Gm-Gg: ASbGncurbeFc8N5K+tNmfsxAvFo3MZJj10vdoNRj0+uXX7tz9u0fCLa4cqx09ucZKpi
 FMRSl37LnUCitbxWetUKUSo057s1Hgd8vuKr8etAPpkrH+kyl+vhUUJD4uHSVlMMAdqHws8VUky
 KGsM8mcfVVyfTzk23/VWYI96YTBT/bTUWc8sUF5nE12LR5Nce3X7ubezGupTKCuteDVCSHYyysU
 4UwRsRZx6yaWC3Aviy6XSgrRJAf0jVFhf56jCfiWJeQTPYa7GafZQYp/pFsOl7C0th2L8mZ+yHx
 jHw1xh1sttsQjbedsoU2Luik5LtD4E7zBSJ+DIhkMXXxYP4P6JT+gh1fI/Ms5vSQzIKP6802sqD
 toxyP4iTf
X-Google-Smtp-Source: AGHT+IGqH+D1HbfLrMEWko3qdLKsgzhiZvrUS3zbiBCNz9q+PPTdPAMZGQepn6j14y2QkvNHljlfnQ==
X-Received: by 2002:a17:90b:5688:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2ff4971756amr7948262a91.3.1741226208598; 
 Wed, 05 Mar 2025 17:56:48 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7ffe18sm2024477a91.31.2025.03.05.17.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 17:56:48 -0800 (PST)
Message-ID: <b2971494-525a-4d39-820d-7bb8905d60d5@linaro.org>
Date: Wed, 5 Mar 2025 17:56:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305153929.43687-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
> +void legacy_binary_info_init(const char *argv0)
> +{
> +    g_auto(GStrv) tokens = g_strsplit(argv0, G_DIR_SEPARATOR_S, -1);
> +    unsigned count = 0;
> +    const char *binary_name;
> +
> +    while (tokens[count]) {
> +        count++;
> +    }
> +    assert(count > 0);
> +    binary_name = tokens[count - 1];

This is g_path_get_basename().

> +
> +    for (size_t i = 0; i < ARRAY_SIZE(legacy_binary_infos); i++) {
> +        if (!strcmp(legacy_binary_infos[i].binary_name, binary_name)) {
> +            current_index = i;
> +            return;
> +        }
> +    }
> +    fprintf(stderr, "Missing legacy info for '%s' binary.\n", binary_name);
> +    abort();
> +}

I'm with Paolo that this should not abort here; Error is better.
Even if the caller supplies error_fatal.

When testing for errors before and after a patch, I often rename
the binary, e.g. qemu-system-aarch64-good / qemu-system-aarch64-bad.
Leaving it in the same build directory is required in order to let
it find the uninstalled rom images.

Is there a way we can preserve something akin to this?
Do we need to add the -target command-line option that Pierrick mooted?


r~

