Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D00E6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 05:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smnpV-0002Ts-1Q; Sat, 07 Sep 2024 01:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnpT-0002N1-9L
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:17:47 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnpR-0007xJ-J1
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:17:46 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53653ff0251so3016210e87.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725686263; x=1726291063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5GawoGSl8V2d+Jms7j0s70XrmBmctMYkgbOnt6UI6qo=;
 b=oFXBg9GtyvV2X74neviZcC/opz4L7ioe/dpU9lq9A74h7HCRsmOZ0Em8fOxVM0/vdG
 IL1VIw8REvfpVUEpNSRvWjQiRa1ZEok3dZT12eAyarggClMBO2pV8jVrzb6U7AojNVi4
 vcMDnXFRoTMU14tKiyGZwnmdhs3X6By6zLXQkt/vd7XauTsG0dLbCsUk7WvmKIA7l537
 dr320IrIXv+73rh/d2XJlKK/w90PHHrFKTCDHRSfKxHhYXQQ8m+upjpDApeeox05/zYG
 aDwgoTkV3pEBKiBVdY6R950ILonr4LIRyTDiDsMjtGEM10IJ4Qr0kkR8Nq8y6snhEV8I
 aGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725686263; x=1726291063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5GawoGSl8V2d+Jms7j0s70XrmBmctMYkgbOnt6UI6qo=;
 b=mooaabos8JCnTtgsrO5ScCg62vj3LsGJgc/DRjk2VHzdD+FGwA9JCoZY8MHP6a67KV
 L8Tj70C64ukNncTBZ9SPac5vtIhvvGc+opLNgw+WOfcyC2aFLpDynlRT4vEM/1+cnHny
 C4V685vnGJaSO1+0UhxouZkwiSNhomjIUJmVGL2Dwp1/nxe2HWswDnXoOjU44YjqHqjT
 Lw2JJz0HbePbpzlclKdJCbNVtvvpxBx29k5jOPnqpjsnxqtxnPCLNiw0WIeGBk1A06kv
 gAudM+znuoTyEvgmzG8sTMt6ltVdQ9kfsLdaLizyaJNTeNYR+U8V9jd6fl97aLmw+qxk
 Aerg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu6pX8I91yHSBbVfskvabyAiCfBG75xTBIquAfQjMA983pZfDs4tZlX94u4oUheGIowHAM3WkWO44C@nongnu.org
X-Gm-Message-State: AOJu0YxNl6vrqXmESGWu9utgEfQYQHDiFjFtwHr+eoHrQ7819II2eKRF
 kSpbV1B/l12kM1MlZ4AAWCJE3AcXMPf14Kt5UFD40fCFVZpaPNWasJEVAdLyTEs=
X-Google-Smtp-Source: AGHT+IF1SnAar4fvKBvbMzwSDykoYFAqUO0AQcosGBAaCaBsWkqjwGINhi1gxQOfn4o3IGp8IRmr9g==
X-Received: by 2002:a05:6512:3b99:b0:52e:be49:9d32 with SMTP id
 2adb3069b0e04-53658812aaemr2903008e87.47.1725686263338; 
 Fri, 06 Sep 2024 22:17:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c726f8sm28773866b.121.2024.09.06.22.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 22:17:42 -0700 (PDT)
Message-ID: <aabb36c9-a486-433b-b117-2a15d77169e9@linaro.org>
Date: Sat, 7 Sep 2024 07:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] tests/unit: Slightly expand FIFO8 tests
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Octavian Purdila <tavip@google.com>
References: <20240906132909.78886-1-philmd@linaro.org>
 <cdcff9bc-64f7-4198-8af0-a3b61c780547@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cdcff9bc-64f7-4198-8af0-a3b61c780547@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/9/24 23:11, Mark Cave-Ayland wrote:

>> Philippe Mathieu-Daudé (3):
>>    tests/unit: Strengthen FIFO8 tests
>>    tests/unit: Expand test_fifo8_peek_buf_wrap() coverage
>>    tests/unit: Comment FIFO8 tests
>>
>>   tests/unit/test-fifo.c | 209 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 201 insertions(+), 8 deletions(-)
> 
> This is great! Thanks for taking the time to review the Fifo8 patches in 
> enough detail to be able to produce the ASCII art :)

Series queued, thanks!


