Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E6CC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 18:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPkl-0005IN-TH; Sun, 23 Mar 2025 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPkk-0005I9-Db
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:08:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPki-00078s-Hz
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:08:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2260c915749so46160265ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742753331; x=1743358131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrGwYODeIkBtzkoNaVd3VqF8jOeE271ZHG8rl9Wp6aQ=;
 b=QCKI7PqIN/50c0obu1YEYWs2ZDKYsSryxd48+44/t9liT40Yl788ArpTSD5frSLZhf
 cMl5YWGW77tZdZbE5wNjYbCxApfPkCK2TCGosWPDXwPVTdXfWB/sj4w10f5uHeJYr7e/
 wyOvIR72aoooc7/+JwitSY8OCw9TF6Qqi9Td9+Ot76uD86xUYvl/7NAQxVykn+B6ViCO
 IsYEpNjIklWx8MXqcvyA/51++QUtRD6494SOeUQhVWCZSapLbFjj58SX3uViOFZmr/Jc
 BsLZW85NNmDVLoKBiwptjWImoYodDUAJcwmnBm14/ojHdi8/jPuSryCHwVEEGTSd5rM8
 CsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742753331; x=1743358131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrGwYODeIkBtzkoNaVd3VqF8jOeE271ZHG8rl9Wp6aQ=;
 b=A0XQ3ceaBN+eOxG5D5biPHvNNuTpYRMou7c5gAWlbWInpOkk7gpUjSIIqX8bLoXu4+
 7ksYn4PhIIZDi2/TcOtHvq4QnjI4/E0rc1jByQvuwBapxuaq738PSy5YWSEu2PK2b1sX
 CBUwPEN7fRwihxV9fEMQPuqOUzCa5nkbI1mrxMecjfNPH5S5RvdehCVwevaW5jGm/wIl
 qf8I0gZx2v9zeq9DTM4wSb8C5IxCUG0t5YAjTx6va7mHG/uKNiyjrCQe+IsKlqTY+IAE
 U3sATZUbGKpj7gOYHLS3S/2HEXgsmNBxUOsXaTFNRPIB/SIste1NznBzSjFGmwcbLmOY
 gf0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Mnd5c5+Komy+KiRA4nT1HHc0K5DkK+W2s8DkdnM3B7JzF2pNvC6NL332zU0XpKKD9xAmXO2RmRAz@nongnu.org
X-Gm-Message-State: AOJu0Yz+imrq7Q+Zq6AyrZD7Hb/mxbI55R0UdU9dzNCqfTaTdk1/w7bP
 V8dRkWHeSEZPZ8CKGClQSL2SsE1xItRGe4pyZkCr1G7zsTxLEwdGNZ7VZbx/oJ4=
X-Gm-Gg: ASbGncshupXhe9mfF9i0BW34UesRsUmDkN5UWgn2LB192njcUn+8PNEsnt4Takf6Ne0
 v31lYTJo941ghFH75Pc8RD9CZRiIiqAp0XwbvTxEcnc2XeuaIjTUZR8iuNymUeLW2VqdCtagEGi
 eVIhDm2kMPpSuYKC/5nMLZvCUSW9K+G1J9xuXAkySTfSkz8K38CAk91gRfyio1Vmcqf6iRY1QWj
 9iZIzj5OCU/nKYGAw7TMgmce2D+beHTpPur+lZX2xcIsmVoRcmhGOSoVNsMqpaqgAJFhqcM9Jil
 dp0+wLPC37tko/yr/h9zbFg9wN1HVwwI49a6fOfZyebC/VqSqOcMBTiMvGXHpZK7knNRteRTZjF
 NA5YtsBQC
X-Google-Smtp-Source: AGHT+IHff8iT9LuyVx94jYz3N8YABafjggeoZZ2M3b40lHqBZCs+N3YCMHbmQMnexrv0c0Wu3TfclQ==
X-Received: by 2002:a17:902:f548:b0:224:a74:28cd with SMTP id
 d9443c01a7336-22780dacae2mr130271905ad.31.1742753330918; 
 Sun, 23 Mar 2025 11:08:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3bb2fsm54507495ad.15.2025.03.23.11.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 11:08:50 -0700 (PDT)
Message-ID: <2650b68f-e705-4994-9791-0bf8b2e01d74@linaro.org>
Date: Sun, 23 Mar 2025 11:08:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/4] target/riscv: Restrict RV128 MTTCG check on
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321155925.96626-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
> Multi-threaded TCG only concerns system emulation.

That's not really true.  User emulation simply has no option to
run in a single-threaded context.

I really don't think we should allow RV128 in user-mode at all.
Certainly not until there's a kernel abi for it.


r~


