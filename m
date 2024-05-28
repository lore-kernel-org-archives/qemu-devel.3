Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899B8C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByaY-0006C1-U7; Tue, 28 May 2024 11:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByaV-0006Ab-U5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:18:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByaQ-0001OD-Jo
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:18:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-354ba5663c9so777348f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716909479; x=1717514279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3GPidNkvE7hjDr8Tb2VFal5rZ4pUkGWbicQZrjprVTE=;
 b=BKXgmAqqxbMhSz1fYRiLaIImEBCtz9/JMERYLISlavkfw/zFGtft5IvZM9F+cuJfeb
 JrmnFIeBcf40yfwj7ij8Ihk41I+JNSj3s6oAj//dcPNWGecMWQUKmy+mNoTbmH3MIXbT
 7vp0Aa82ob+SdFIvsOul6KIVGNhtRkWSPdpLgi9lqGM4zHz+2/kNydA8IuWxzCxbOYks
 WWIiOG4kbGkbQLYe1AIvNiys1GoiLVth4IBJi874K41x8LfJE2tsk3t8oTUwBv57Ncwr
 I60U8XGCSwhlgofuJuSR+7hAlGa3mIJp6XTLAvJbTxtt+1l1bNM4C4gWgClfCSjFWDnA
 jZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716909479; x=1717514279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3GPidNkvE7hjDr8Tb2VFal5rZ4pUkGWbicQZrjprVTE=;
 b=KvdSp/8P/uxXSDPFh2IWTeUHgg2PoSIiM/aYGjGSYuj9lPzrk0cQnth85AlUDYW/6G
 nhquqBYOLEl2s5+tS1VpSedDq5uQO/vvPraFPTK2JHHA8BlkviuwQG0HcNDiDF5gCdFV
 gquSRoZRT2su1OtLimqFGJnxR9IuGD8IERlJ8knumPVP0QCNAcJlSu61NvRaHXrILK/1
 yrPtEEZd6fD1OJrgUugr2uLFNu4GaD5HnZyvT5wGe5kpggAPjRhjrFjQUWKY0i+icMY1
 kdh6I2XQ4C9QzlI/eY3lfFUySyZ+jNcxzybIwhjfmZF6G2Wcr53VqOeO9dYOvn+NY1jb
 VZ6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+q83jOUuQ4OBi/wNx6brEIvxnQjsmARLI88FnsMPrhajpkKr/9XeD2ds+eLdZR6UruHCa05qLW1QSTLfEi5YBMrSAjgw=
X-Gm-Message-State: AOJu0YzuzYpwLG8aIev7K/LFSywgOm8Nkx4dwCA59arqnnkYVhbRMizj
 xdMrID/HBjbp27paw2ndH9KMEg0/efvqOFCMBHWlb7cx4x3EGqXzhOp+sJbm1Pw=
X-Google-Smtp-Source: AGHT+IGpRooaSo0K6VKPXTxZ32+3ceOcSohNNQHFLdXu7k6LD+NzoIoEU/RA9/vpm0A+vH14ITnfuA==
X-Received: by 2002:a5d:4f8e:0:b0:354:c329:90d3 with SMTP id
 ffacd0b85a97d-3552fddfa23mr8992819f8f.49.1716909479169; 
 Tue, 28 May 2024 08:17:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcefdd7sm12282561f8f.91.2024.05.28.08.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 08:17:58 -0700 (PDT)
Message-ID: <4d964d18-db2b-4282-b499-ca42ec8b6112@linaro.org>
Date: Tue, 28 May 2024 17:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/clock: Expose 'qtest-clock-period' QOM property
 for QTests
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Damien Hedde
 <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc@lmichel.fr>, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>
References: <20240523194441.21036-1-ines.varhol@telecom-paris.fr>
 <20240523194441.21036-4-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240523194441.21036-4-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 23/5/24 21:41, Inès Varhol wrote:
> Expose the clock period via the QOM 'qtest-clock-period' property so it
> can be used in QTests. This property is only accessible in QTests (not
> via HMP).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Addressing Luc and Peter comments, you can replace that line by:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   docs/devel/clocks.rst |  3 +++
>   hw/core/clock.c       | 16 ++++++++++++++++
>   2 files changed, 19 insertions(+)


