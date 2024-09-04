Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F98CD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slrCR-0004yi-B2; Wed, 04 Sep 2024 10:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slrCO-0004fp-66
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slrCL-0007jk-Lv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725460888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AmaJgsrG02MIPWLM8397qkUTQ6KMNXAC2MVuMNFCE+U=;
 b=YGDjaoHrgGXjhzyYstCkNZ/K3oKww9mQxmUKfN+RfbgQubijCRgaYEeiwgUowYMeExamZg
 PTPY8n1aWFa+9K2jhNlsPZxjQjuyYUFcJRhwFCm1DLI3izsZSwdoADoRo9PU2siEI4tOZN
 /C9UIpXsGeY5FO3Hl31ozbuDoXdjSPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-zKUhzBn5MMq5DBibdiRaDQ-1; Wed, 04 Sep 2024 10:41:26 -0400
X-MC-Unique: zKUhzBn5MMq5DBibdiRaDQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42bb9fa67c5so12606775e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460885; x=1726065685;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AmaJgsrG02MIPWLM8397qkUTQ6KMNXAC2MVuMNFCE+U=;
 b=kOsEhnhoF7g7vh9O8fGPMd4zjtwGgJTzlqtkBSM2ORzX06ATF1+1WzcEouQVd/6ps+
 WI0+hV0S+FkqSZSKYfa6a/JEILpLtAQ4PNTZ5Hgen0o78oSuXFP+D3202Gx9T/mN9hNe
 MlmFHn0dQgDS+w9JeEJwoolzmW1K8PxkzJ/ecYZbXZHh4ZYNT1cIOGJuY17pUKYvmDkI
 Gb7P0hODT6EVqWkAYMu6yPus4Y3gvO7TDGtIM/OAEWgzm5VzyISScF3z/XGtDLvTvWua
 DpxVZZ1SajmpF1NNIYahiQudO7OcY3DXZLKqP1Ms7qxvThOj3yBaiyoaZoas+/alqI4A
 fWvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtRFG7ACxT/SJTbapwzjjajinpXcRy1JYMbvpDePIkIQkZsnwSoJ0CsiTg8Jd1n8c5d1tf8eXImLr2@nongnu.org
X-Gm-Message-State: AOJu0YyqZmk5AyFRk+LH6FTYWHfaphIiPs8fFeH9rE5IYcX/Fsq0ofBt
 lNFw9dqXZlC6c6Dkn716TUh7618bhFJmSoG0WVExOoWLZAis/p3K7nPSYOAisSt3Q5DFeVErfGD
 JPWUn7+xUCCYsRqOwYGH3dvocaN+hXZFAZKJy14tD/KhpEN5PQwkW
X-Received: by 2002:a05:600c:a06:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-42bb01c0f9fmr158164845e9.21.1725460885641; 
 Wed, 04 Sep 2024 07:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoCJ3lVVLkVyWV4Yv3DYBHLQ+n/STT4Y6rPYUXggEyvDeRkjPW1UdB3kpKEmyWt083qd/x/Q==
X-Received: by 2002:a05:600c:a06:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-42bb01c0f9fmr158164655e9.21.1725460885115; 
 Wed, 04 Sep 2024 07:41:25 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-181.web.vodafone.de.
 [109.43.176.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbdda3958sm173823525e9.26.2024.09.04.07.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 07:41:24 -0700 (PDT)
Message-ID: <bd761eb0-7623-44b8-a0dd-d2e1613eec88@redhat.com>
Date: Wed, 4 Sep 2024 16:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] tests/tcg: Remove CRIS bare test files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, devel@lists.libvirt.org
References: <20240904143603.52934-1-philmd@linaro.org>
 <20240904143603.52934-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240904143603.52934-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04/09/2024 16.35, Philippe Mathieu-Daudé wrote:
> We are going to remove the CRIS target.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                           |   1 -
>   tests/tcg/cris/bare/sys.c             |  63 -------
>   scripts/probe-gdb-support.py          |   1 -
>   tests/tcg/cris/.gdbinit               |  11 --
>   tests/tcg/cris/Makefile.target        |  62 -------
>   tests/tcg/cris/README                 |   1 -
>   tests/tcg/cris/bare/check_addcv17.s   |  65 -------
>   tests/tcg/cris/bare/check_addi.s      |  57 ------
>   tests/tcg/cris/bare/check_addiv32.s   |  62 -------
>   tests/tcg/cris/bare/check_addm.s      |  96 ----------
>   tests/tcg/cris/bare/check_addq.s      |  47 -----
>   tests/tcg/cris/bare/check_addr.s      |  96 ----------
>   tests/tcg/cris/bare/check_addxc.s     |  91 ---------
>   tests/tcg/cris/bare/check_addxm.s     | 106 -----------
>   tests/tcg/cris/bare/check_addxr.s     |  96 ----------
>   tests/tcg/cris/bare/check_andc.s      |  80 --------
>   tests/tcg/cris/bare/check_andm.s      |  90 ---------
>   tests/tcg/cris/bare/check_andq.s      |  46 -----
>   tests/tcg/cris/bare/check_andr.s      |  95 ----------
>   tests/tcg/cris/bare/check_asr.s       | 230 -----------------------
>   tests/tcg/cris/bare/check_ba.s        |  93 ----------
>   tests/tcg/cris/bare/check_bas.s       | 102 ----------
>   tests/tcg/cris/bare/check_bcc.s       | 197 --------------------
>   tests/tcg/cris/bare/check_boundc.s    | 101 ----------
>   tests/tcg/cris/bare/check_boundr.s    | 125 -------------
>   tests/tcg/cris/bare/check_btst.s      |  96 ----------
>   tests/tcg/cris/bare/check_clearfv32.s |  19 --
>   tests/tcg/cris/bare/check_clrjmp1.s   |  36 ----
>   tests/tcg/cris/bare/check_cmp-2.s     |  15 --
>   tests/tcg/cris/bare/check_cmpc.s      |  86 ---------
>   tests/tcg/cris/bare/check_cmpm.s      |  96 ----------
>   tests/tcg/cris/bare/check_cmpq.s      |  75 --------
>   tests/tcg/cris/bare/check_cmpr.s      | 102 ----------
>   tests/tcg/cris/bare/check_cmpxc.s     |  92 ---------
>   tests/tcg/cris/bare/check_cmpxm.s     | 106 -----------
>   tests/tcg/cris/bare/check_dstep.s     |  42 -----
>   tests/tcg/cris/bare/check_jsr.s       |  85 ---------
>   tests/tcg/cris/bare/check_lapc.s      |  78 --------
>   tests/tcg/cris/bare/check_lsl.s       | 217 ----------------------
>   tests/tcg/cris/bare/check_lsr.s       | 218 ----------------------
>   tests/tcg/cris/bare/check_mcp.s       |  49 -----
>   tests/tcg/cris/bare/check_movdelsr1.s |  33 ----
>   tests/tcg/cris/bare/check_movecr.s    |  37 ----
>   tests/tcg/cris/bare/check_movei.s     |  50 -----
>   tests/tcg/cris/bare/check_movemr.s    |  78 --------
>   tests/tcg/cris/bare/check_movemrv32.s |  96 ----------
>   tests/tcg/cris/bare/check_mover.s     |  28 ---
>   tests/tcg/cris/bare/check_moverm.s    |  45 -----
>   tests/tcg/cris/bare/check_movmp.s     | 131 -------------
>   tests/tcg/cris/bare/check_movpmv32.s  |  35 ----
>   tests/tcg/cris/bare/check_movpr.s     |  28 ---
>   tests/tcg/cris/bare/check_movprv32.s  |  21 ---
>   tests/tcg/cris/bare/check_movscr.s    |  29 ---
>   tests/tcg/cris/bare/check_movsm.s     |  44 -----
>   tests/tcg/cris/bare/check_movsr.s     |  46 -----
>   tests/tcg/cris/bare/check_movucr.s    |  33 ----
>   tests/tcg/cris/bare/check_movum.s     |  40 ----
>   tests/tcg/cris/bare/check_movur.s     |  45 -----
>   tests/tcg/cris/bare/check_mulv32.s    |  51 -----
>   tests/tcg/cris/bare/check_mulx.s      | 257 --------------------------
>   tests/tcg/cris/bare/check_neg.s       | 104 -----------
>   tests/tcg/cris/bare/check_not.s       |  31 ----
>   tests/tcg/cris/bare/check_orc.s       |  71 -------
>   tests/tcg/cris/bare/check_orm.s       |  75 --------
>   tests/tcg/cris/bare/check_orq.s       |  41 ----
>   tests/tcg/cris/bare/check_orr.s       |  84 ---------
>   tests/tcg/cris/bare/check_ret.s       |  25 ---
>   tests/tcg/cris/bare/check_scc.s       |  95 ----------
>   tests/tcg/cris/bare/check_subc.s      |  87 ---------
>   tests/tcg/cris/bare/check_subm.s      |  96 ----------
>   tests/tcg/cris/bare/check_subq.s      |  52 ------
>   tests/tcg/cris/bare/check_subr.s      | 102 ----------
>   tests/tcg/cris/bare/check_xarith.s    |  72 --------
>   tests/tcg/cris/bare/crt.s             |  13 --
>   tests/tcg/cris/bare/testutils.inc     | 117 ------------
>   75 files changed, 5618 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



