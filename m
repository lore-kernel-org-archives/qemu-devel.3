Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1ABCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76sx-00046Q-0g; Fri, 10 Oct 2025 02:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v76su-00046F-Vz
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v76sq-0000o4-N3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760078737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xancDwZPZpFhWkrvXLPRSE3JGTmlR9Mh2lNCFoPXGSU=;
 b=WTbwMmR9Hs42u6bcvueXtI2I6NEz5ZX29jMCLYtTAv8/LSJY6ZtFwHvN366GplN5jNCrPB
 sXBpysA47qMFHreRZaQt6/WaxQeXacPgqWNs/6YNIZd22xWyFghKzyuBx9p5as/deH+QqY
 wPHb529sgriKtlhFJUpLR/wF69BBMYM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-9PYNIVxTNzetckzcnFv7_g-1; Fri, 10 Oct 2025 02:45:35 -0400
X-MC-Unique: 9PYNIVxTNzetckzcnFv7_g-1
X-Mimecast-MFC-AGG-ID: 9PYNIVxTNzetckzcnFv7_g_1760078735
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-afcb7338319so216953666b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760078734; x=1760683534;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xancDwZPZpFhWkrvXLPRSE3JGTmlR9Mh2lNCFoPXGSU=;
 b=pplJLxtgCUBCWcPaEdzJ5cXV+YRLdW6TH7MagsPYjNI9JwPF/bN4Z3Fa/DNleubi6v
 wPrioIkRe/8rUkZZQy+YJBE+wCMfPqMMjzpjitsKRDsdzlkbtOzDcpEROoxtffDSHdhn
 vwGh3T1whJhN5oK8VGj0WI+N2LMfLplQqi9riEVCB8lpP3aIdl6lpE3X+xC2IP6GUSTf
 vMV2/0ckdNsaIYNbHqpkYXYs4pjt/1r6IFAK8CDK0cxTxn8e30t5EKd0xtbeZJbszMjF
 KbTPHdAXPe7ky+xIvdvHwmJk6j4Ko/rnz19CVRFV/XscyabieyA3tp3S3YeuvXmuETlo
 h+gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs37AK77o8tM91zi+XiSP6I/zQNhz+6mQILudZffHrQt0wbbsooYIpOL2fBeG2S+yonNNmPil7oIb2@nongnu.org
X-Gm-Message-State: AOJu0Yx035AEHQxQtCD+0WIo3CkEtFHb+UtunjO8Sk8+L2tHS4m8VIBZ
 7YIFBdzzRXX3sFojxHgXpCNAQWY3eOTdrG9pFrMWDp9Hpvu1SITxOylJoGtic9bo4jfvVUh1JC+
 h75lE9CaH0NxgRdwXG1qrSuxMIjYMK8JAPasvJa92FAqOvGYJOumlK64R
X-Gm-Gg: ASbGncvVpU8RR7L042vhYEyMaVwYphiUJSaTFIwRyT8mECCfnwgPn6XQ3lVlco5he6k
 HxaZ9m/gmq2FShesS3UJw+VFAulnf+SSb6SYdboDCEloSulDNZTbdDcw6xvngzvK2T5vvHKC33p
 UfaW6WXjF/k834+0U6XYZzR/WE2K8M+Tj79siy47cjCYGFBNWxbkofg8ojmvdAgoONQjfKrIeyj
 mtAqzL/HNobEC36JPZsacgO7WvA2cqJePeoOz1JKCjqM9wjN5uXp9y8fc2waovO7E+i4/nGf5IM
 +OpPA6u/rhIn111kh1MJayr0RRNl191S0v5BaN1JVFmkvgr4b4g0LxvwmW1JmrUgEelsryHG8FY
 APwjV
X-Received: by 2002:a17:907:2689:b0:b3e:bb87:772c with SMTP id
 a640c23a62f3a-b50aab9c912mr1157690666b.17.1760078734707; 
 Thu, 09 Oct 2025 23:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxOVarfa3eub/f8KfloF9g8pGawErBMkjbIXs134sn60XCcRodm6fFB703ph+ZRYTTJgH7aw==
X-Received: by 2002:a17:907:2689:b0:b3e:bb87:772c with SMTP id
 a640c23a62f3a-b50aab9c912mr1157687866b.17.1760078734325; 
 Thu, 09 Oct 2025 23:45:34 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cada4fsm165190266b.6.2025.10.09.23.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 23:45:33 -0700 (PDT)
Message-ID: <b7dbd362-cb0c-4853-9753-56b948557457@redhat.com>
Date: Fri, 10 Oct 2025 08:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] tcg/mips: Remove support for O32 and N32 ABIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20251009195210.33161-1-philmd@linaro.org>
 <20251009195210.33161-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251009195210.33161-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/10/2025 21.52, Philippe Mathieu-Daudé wrote:
> See previous commit for rationale.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/mips/tcg-target-reg-bits.h           |  9 ++----
>   tcg/mips/tcg-target.c.inc                | 15 ++--------
>   common-user/host/mips/safe-syscall.inc.S | 35 ------------------------
>   3 files changed, 6 insertions(+), 53 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


