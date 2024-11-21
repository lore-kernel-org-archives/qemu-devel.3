Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C30E6400B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tED1j-0008CS-Sn; Thu, 21 Nov 2024 14:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tED1e-00089o-1S
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tED1a-0005t0-N1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732217973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9uHUiDHEiA5T/ae8kSv/XoFq1++D1f8/nY3jVDMCG2s=;
 b=Z3Jl5v4fp8I0Xsztt7SMLQLmMlpMgM7T2f5yhKRWT2v2MvhqMwjAT60c6Xh5M6uqXYq1zC
 LvL+TJmSBlUzgXnTlueewy84D6lzUULpKxO/OYuCJk5HOdQzZ9kMx7iSczK4gWigLSC2S+
 LWqmPgzsey1xhXxMALBM5rtoGAIxank=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-qm9459PWOeSUmuCFXRML3w-1; Thu, 21 Nov 2024 14:39:31 -0500
X-MC-Unique: qm9459PWOeSUmuCFXRML3w-1
X-Mimecast-MFC-AGG-ID: qm9459PWOeSUmuCFXRML3w
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539f49f2443so1114833e87.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732217970; x=1732822770;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9uHUiDHEiA5T/ae8kSv/XoFq1++D1f8/nY3jVDMCG2s=;
 b=NdPXLhF4QC0YFaxIZPhyDRQu9Fx4vVDur7MKHfAMrlJCT3A4aA7NYALEChCD+Pgtwe
 oGdW2DtCj5fYo4Jlw8/HUVaxWeGuxKQMzjx97LREyewlyjyfR2RHN7DrJ5wQzhpNGaEI
 oDAmgIJ18Wnzw0tUNJiqNL3AeCaOE483e1AqSCb+Se1l6POTjpKP2Yex3Mx0GZ0fLw7S
 MOjVXARU+KFrQP7IuDO64Id/G2Q2+jpvZp9ENEGLPsqf5mXiGjKTpwSseEYwZxG73530
 ii84Nyhrc6BKlIjEot0WPrRoU+Jvg4Xzm35IReoTlQReeEMU2JfJxfCHrWQ7zr3CM/fG
 /UHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk0O69Gx4Xw+RDtm0FBDpu4HYLOivCx5zIlYvtPZjQoKohP0wgESCOT/lDADK5pUMpL9unt1vLngsu@nongnu.org
X-Gm-Message-State: AOJu0YxD/r8ty6kDqDI18OFwLc/OjojEVq5A8oghfi5pzfug4YWXqkYS
 aLxfg2ocXbPL7pFF4pk2gUbc56zyVUvKonx+B5gQoAlREd5/Tx4nAO2FQ8+5wydVDng/4b4IeCU
 QuwXDYZU0AYR9nlSnpJvtGN5yBqpXUlbRNfGEFR10F0ffY2UCCkQ/
X-Gm-Gg: ASbGncvRbmtmwCzX/qNP4GbwRXnIv0ggCevFYd9GPkmwmBMxwAy4Nxl2L93F2ggIq0R
 uD5WrKtYlmnon8EjWpQ8QEzIVv+oOLn1Jx6+sM8eqMAUE4ZDa6bIIUhUEgsYcJUZHC835FhFwzq
 tM6DVvA3wPawARwCvOCIrtA6c9FyAXFt6Mv3fSsKUKfx3p0P81m08TgvMAzSJUPFaOsEsGxkIZq
 IiGa9yDUOOYJPut5QRoytEz6XWug+OrE8ZPxt9p3AnfB6LT8Km1hU0WvObWksROOmkCKbh5afBn
 7kw=
X-Received: by 2002:a05:6512:12c2:b0:530:ab68:25c5 with SMTP id
 2adb3069b0e04-53dd35a335bmr17068e87.2.1732217970239; 
 Thu, 21 Nov 2024 11:39:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm3XlrjPuheONM82Ol+g7JS/gjE+kO7ObWfamAcDJgtUVPtWaMRpWgr8uSRCawKA/b1FxR0g==
X-Received: by 2002:a05:6512:12c2:b0:530:ab68:25c5 with SMTP id
 2adb3069b0e04-53dd35a335bmr17009e87.2.1732217969786; 
 Thu, 21 Nov 2024 11:39:29 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b5b764asm6810266b.175.2024.11.21.11.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 11:39:29 -0800 (PST)
Message-ID: <b4c87321-8b15-4201-9e59-49ad3b948451@redhat.com>
Date: Thu, 21 Nov 2024 20:39:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/39] tests/functional: remove time.sleep usage from
 tuxrun tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-17-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241121165806.476008-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/11/2024 17.57, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The tuxrun tests send a series of strings to the guest to login
> and then run commands. Since we have been unable to match on
> console output that isn't followed by a newline, the test used
> many time.sleep() statements to pretend to synchronize with
> the guest.
> 
> This has proved to be unreliable for the aarch64be instance of
> the tuxrun tests, with the test often hanging. The hang is a
> very subtle timing problem, and it is suspected that some
> (otherwise apparently harmless) I/O error messages could be
> resulting in full FIFO buffers, stalling interaction with
> the guest.
> 
> With the newly rewritten console interaction able to match
> strings that don't have a following newline, the tux run
> tests can now match directly on the login prompt, and/or
> shell PS1 prompt.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2689
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20241121154218.1423005-17-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/qemu_test/tuxruntest.py | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


