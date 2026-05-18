Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7573ECD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmtL-0004ZH-Pl; Sun, 17 May 2026 21:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmtK-0004Yi-2P
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:35:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmtI-0007CO-KY
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:35:33 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-837b39eb078so1165283b3a.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779068131; x=1779672931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23Bqhmu2k/rCrt8x0YWcjRN0yHqHkQ/877ddDTHJ2pA=;
 b=QRVsMLJsFGxNZxDBGKJDpTqRByx/T+p9XBcozNroUd2kKxIH1JokdbyV+txfOdniPC
 aS33aLvSyzSOB4xinO7Z8tJNx2GVzMl/Kiv6vI3gb4hG2JPrPp3unGcWs3209eko0o+c
 5pspSlehVV8qdnwF69Ivz5pHfrnGizbUOZm1fegO9SNVIzQgkNfeWcPI6PMZxhl/c/1Z
 a9kXWVuWibtcaUZxtamjeeUCYE4Vz4XROFphve7hy1ZhBOYuQajwGztxKo6l0QOD5h70
 ZFC8z4+SCBCi2tysy9Wisyh5n13kY0cPn4OPbjUjIsZ8i0BIfa6lPGu8D+yjotcsOUIh
 CusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779068131; x=1779672931;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=23Bqhmu2k/rCrt8x0YWcjRN0yHqHkQ/877ddDTHJ2pA=;
 b=GMXEtjokcqB6DcdV2IDDx9S0ArUxXv48AzEkICWuRcwKoWAZ1NDk8si2E0dD+o41sH
 FKj+HsvYF71t8+3yOAw18NALHzTuP4EVHDC5Fm6zVRfI8L8fmrTCUfQw1P88Rm3/v2Wa
 8jJ5iWTDrjGXAJPADIlNN1Ysj6iO5Z4skCDeCkbySHZwWMG7XDgviKCp2PKYVQF4xCY6
 IPrcoaCsjAdtA1N7WeoYmQv2grTs2EfiD4RNcbb3oaOBvwc41+i9xQvWUR/LDkC0L8d+
 pgjJj+k2wRTpM3Zb8IMbc4A7+tnR+4fF1z+YG80DIZo+4uvNiSl2jzWh3Hgh0fedumdW
 ccxA==
X-Gm-Message-State: AOJu0Yyxf8RclBL5xlkpH4h/v6nlkUV8Q6/DdvzjuQxQT/44zdzOAsZs
 N3Rzl1pGh2Dl0qgBIBIOp6qwPdphuYemAb6xGbOoAojb5hipPTC8O65R5BOLpRGezUi/wYh7vgR
 s8UlK
X-Gm-Gg: Acq92OFksNciZ9MzjDAdSxsqlFQxfB2JhcmmisPWfM2aJgt02XyZuipTpiUZmZrGRhw
 6SvGmuwUTVBLHIITCeI89G++bt5QYnwUHY6hvc37kEng1rrhjL8Qn+nY8VisTCQCIxPATXZ7nLY
 PQiyP+ndmzFhZYxdJ3h4pip8W8n4KNlb2DSa7RRSNJkXr7bQ+Yvq32MjmWTG5+rp4Gok9+FZIq6
 3GrrC60eC8cH8PqW1dtubRGus6ODOG1cyg/Hly9MBp2pcVBOUb1jyr02qabLGW7JB5TlVSfx5vV
 t2z1PfTvqPu1wYH2TLfqSIRk7PP2fi/jHuM/NWbhIVHUWJjUHEMMfRB/z8EV1RvB3sMQNDf4jWt
 oJaMcCRRqV24enO9oj4vVwB3hc+O5RwCQuV4cITllcYR8U7DKmY03Acxfwi8Hure1UOmUqNPe6y
 MmOp4iSaHFLmsTUWmh17B027KMPO72H17QahcZ6Y2FXTUWMck=
X-Received: by 2002:a05:6a00:bd8c:b0:82f:4f63:31e1 with SMTP id
 d2e1a72fcca58-83f33aebdb9mr13601675b3a.8.1779068131054; 
 Sun, 17 May 2026 18:35:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19664212sm14657836b3a.2.2026.05.17.18.35.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 18:35:28 -0700 (PDT)
Message-ID: <06abc22c-39f4-4ef0-8a43-bc3fe92a00f3@linaro.org>
Date: Sun, 17 May 2026 18:35:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 34/35] tests/tcg/mips: cover Octeon QMAC and CvmCount
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-34-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-34-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/14/26 10:37, James Hilliard wrote:
> Extend the Octeon linux-user smoke test with QMAC/QMACS fixed-point
> accumulator checks and an RDHWR $31 monotonicity check.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c | 57 +++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

