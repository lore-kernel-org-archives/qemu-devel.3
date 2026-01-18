Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F8C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 23:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhbz0-0005W3-2x; Sun, 18 Jan 2026 18:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbyx-0005Vb-FT
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:14:55 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbyv-0002NM-Q2
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:14:55 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c5513f598c0so1455961a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 15:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768778092; x=1769382892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XhAUbnqlPhbpyyOgoHFg3IWwc5lGnTET1sHtc7Z7qgs=;
 b=GHf4WqoBV3qYhvIi7QdWACA166xcML+jiSR62fpAS0UDA9qkbvVXs4Idvu/gyqH3Wj
 aO8MVmx2NlM8yPlLOo3Ccti8ySCRijmEd4NyyWeF7NaunaK5tnKerOGA3QUTeuTBcbXW
 eboqfi7c9DiRFpxPiflVsgXWcAYrOFnZwyOiWF7YA/vrtsV/I8uTAxGhlvOori4Xv3Br
 R2weg1tAUT/e7jjj2JwdpZOYMaqr9BthNaM9alu1GYb4u+C/Hq9ce8gmKEfavnkDQ2B3
 /uHxW3+Rmm6pl2rsmPLoFUVPsIf04TdVpgEL6O6NfwqRb720oPI3Sx/DWhonjfFFyPiu
 HcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768778092; x=1769382892;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhAUbnqlPhbpyyOgoHFg3IWwc5lGnTET1sHtc7Z7qgs=;
 b=mpby+FX0xRS7NZ8ahAjEn+0r7h+/Mev4DoVApIkfQLIJ4NcEgTQPuEWnuFBfvpzISy
 WBidzzcdfVguu76GLWIsaluWoW+dOwckOC24S5+xqkyhou0xGVdWwJRyHeIyKhudS5f8
 7ZHqLsZR8GvYA63+c87bpZNW9RjpzkOyciPgyIVnMNOikHAL7Dm+ynM6vqn/T4uZoeku
 ErvzJjsgCNp7u5Vai5k7ebJPAkLdL6KichbxKo9t0VuR4SXS+IR8ppBWGRRfReTMo3xb
 c+UFtT4RIQiMjQcbaKd/ng74VecNJPCDJqHatT9hAUmOU9cKf3p21kymb9/rZ/Bp0FKt
 Hs2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh5D4zoBfhGBOTLTHa+2rIM7DxX/wGf6r625iM+tEgzcB34M5HUnTz4sYhR3SU6wYy8YOefGw9kRh/@nongnu.org
X-Gm-Message-State: AOJu0YzV0/ZEJ2YtmbtdTjzuZG1aVbIawDNqh3ewp0dh2r+pRFY+YOgx
 Q/EwLLxnB2AYcVV/UAA7l4UWJorumE4X5wB+JXdtnDMydNmlIeCTK1lvR0sCCEZeN74=
X-Gm-Gg: AY/fxX5fEkh+hnl/1RiXyjLJ6s4rnvnt/dTYZBmzLReUq2Nd5QiuJp1UVvXcx6NzPnq
 Ed2jxH0kCbPean8vt8yHBQvcDCgt2ThqxGQoMvGpl/Yom8VuND90p5Ij32vX1TBoerwGvJ5Yvme
 87XpG3ZB2psib89s7RHSy5kBr1mPQJ7dYIebKGKpGIGgCMu4Ug+RdI/rJm1Ro5wmLjQd2svKa6R
 wiL1N4EKAdn38ZnjiUCzzGAF66GwTRJstVxY/BBIZw3YUASex2+BbTftVbKkHsf8pahkPrlf258
 nKQXKiZzBwLHnkFagko3GOgVj91Zcl+NpylPjbKpFwScJq3uS/J/7fh4PeIYyCTioBzJ+uDnPw9
 ZEDnTLDl+B4R9cRqa4OGnYWii/+sgrnsPnDDe3xhs1ojzGjd9zCJxehnIEiDHuRssD7shyt4wEF
 TfOeVxhiUn+Dc+T0wLTjD9KzEKAUsRIw==
X-Received: by 2002:a17:90b:3148:b0:34d:1d54:8bcf with SMTP id
 98e67ed59e1d1-35272f025e0mr8406727a91.9.1768778091909; 
 Sun, 18 Jan 2026 15:14:51 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352678af047sm9759292a91.10.2026.01.18.15.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 15:14:51 -0800 (PST)
Message-ID: <0b039878-da3d-4e94-af4a-4ccc94cfb0bb@linaro.org>
Date: Mon, 19 Jan 2026 10:14:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/18] system/memory: Introduce ldm_p() and stm_p()
 load/store helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
 <20260118193509.42923-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260118193509.42923-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/19/26 06:34, Philippe Mathieu-Daudé wrote:
> Introduce load/store helpers which take a MemOp argument.
> 
> Inspired-by: Paolo Bonzini<pbonzini@redhat.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Possible optimization:
> https://lore.kernel.org/qemu-devel/546f3a4b-64ff-4f63-bb07-f5cb52b6c64c@redhat.com/
> ---
>   include/qemu/bswap.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

