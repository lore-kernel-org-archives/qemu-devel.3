Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56230C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVhO-0007B7-Bc; Thu, 01 May 2025 11:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVhM-0007A4-AX
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:19:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVhJ-0002ew-Ke
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:19:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22409077c06so17269345ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112776; x=1746717576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VNk59ZUe6VB2+qVVwcJX9X+M3hgSClHFSRBg0Eem0Gs=;
 b=Cs9ho6Vz+XUhBZh5Jxna8W17Ue2wv+ixsG2LR+rEjUscUdZZWxvVUIzGzyF+vdWAAQ
 Zd8DVHeph/7wRbSKx555tsKTz5W6iVBiWGf9XanuHI/0hZQH0bQ+PcX/iJjOhP6zQVPK
 2UB3a2aLbTYT/+f46EtnQn+xC4WW87UYTFoxNqUqjWaKfqfOrPggIayvkmJqif7q5ece
 KcKF0OY/6Xmif8w9SECs4EAtMYYZO+G2zzzDsEyh+BoCjqGEesnBmFSV330W7wDQHXZ/
 G7Ur/aeOWPoXFc7fF3a6gmt2zXCT22IB0lIAw0dADSB+kY/zxW+K7Oo7EG2VbY5vf0qO
 RA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112776; x=1746717576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNk59ZUe6VB2+qVVwcJX9X+M3hgSClHFSRBg0Eem0Gs=;
 b=EbJ6ldBUbfjfDTdiv6+jTRigvFLryw8/6AkvsBba2OXIWtPWbFJg5T0xL3brS5MFUv
 Kkj6pP4ON7aR400Vh3Xez/1eslSHnM7FR5YiY/reroQfjxgw0cxtXJLC1diAz/sayhTF
 e1qoVH4HNNCJX0Kxn9857OF/7597qKHgzBQ1hgptiW1HHmzn2mwNQTU6qgrsBtTWe8xM
 iyIsBl7ABCqcFsnhS5K4fJNSirVzGLY3pqIZCRBgDnOz5JOKlQCqzvfHpi7eQOTMnzXa
 wtD49bCA+qlEPkiy2xfSy7SwOQtprDF7pOieT4v+/gpJ2YV/tsI+2IJFKi5JFB/+VTYP
 Cmgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXVYUpOZWxtg97wx9ki2hfp16IPCGaFILYWUIprw1Jl6ziBpZIwLyMI80kj1LNQdLlBBRYA+BXz/h4@nongnu.org
X-Gm-Message-State: AOJu0YyTqAqhLeaDF8DEFitncMrK1odyP99N97po1X/xeAv7XICwJg+s
 BP1W0AkGy/11NwAP+ZxOqA2vBZTMW2kNhSWHLka0eJTBrteLGouE/ZI/dzaaXrA=
X-Gm-Gg: ASbGncscHmEH5IcbRGI9TxRIZgHLNzK1GZVLJMwDTB6ohTgCdnSa4jo8uWJx8MmOE2H
 rKNckyreaXUTJlhRGHrlFa3jI7rtB+6waJ/8yBi6bCTOdQws/1H8F2J9GKS0SBKCl8CLL1HQ7CS
 HGzXeZUTq5+QfxYT5/tfCYWma1tJtwD/PrPM+XM5j5fDMXnhZelrBJ0BPfcM646WNc+BvMY0mJc
 t9xewS+150kEyTnrHy4p0vtqeuWJD/f+LcjNJ0st734A7Dkl7RQ20rHsxWSQ8MkBWjfCESIKbNt
 UhTzEy9ytxMTugYW9jaJOXNdC+DidgSPEdGfv4EpaF5gv0dm3JInCP8o9cZsnt2r+vxAhVffA9/
 3b1r7V0Y=
X-Google-Smtp-Source: AGHT+IFiodq2dkzmVTJTMEgLtvCWG8RgNPy29GZm5v093C6tYwxz1yLGHlH2+5H29iUlSMv3iqh/fw==
X-Received: by 2002:a17:903:1247:b0:223:f408:c3f7 with SMTP id
 d9443c01a7336-22e08429b98mr46957485ad.16.1746112776216; 
 Thu, 01 May 2025 08:19:36 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc6d4e2sm7796945ad.149.2025.05.01.08.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:19:35 -0700 (PDT)
Message-ID: <f3b1cd1c-3ef5-4d63-a2d3-96bbd186ff3e@linaro.org>
Date: Thu, 1 May 2025 08:19:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/33] target/arm/helper: compile file twice (user,
 system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-24-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-24-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

