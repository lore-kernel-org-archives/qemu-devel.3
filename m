Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838C1C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmaEG-00059v-8z; Mon, 24 Feb 2025 10:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmaEE-00059Z-TQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:18:42 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmaED-0004rL-Bc
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:18:42 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-471ede4b8e5so23013811cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740410320; x=1741015120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbETeY2HesuLS7ZuA4vCEpXbGVV/pRBgiL2UcfcqRKo=;
 b=OkiozbbNRzT6aaP6eZVYqd7C9tDat9ChEgzDJ2aTl8mdKYBPnWuJjmd1z6vR/SW0AC
 20FkqH2C3T32XmcjOsxBjE6BslX4lsDibc/pQs1L6Fo4Cp0q6fmYjV/UUhaUdb0oqHdb
 fnSLrRrui7fuqEExu7vpA6tT4bqtUQIYMs5Qlc7xIan78SJd726V6bbG2SDeop4LuKRt
 HfdEPOvgHQgBhPpouUF21icDGwRD27ZiX8TTb1YHJfL+V6OIbtv6FYjBtR45YgCwExtW
 Gl9A6s8KeTIQmbRdyQ1bFnz/t33NvCQ/vo3gW48W1QL7clriGdvM/+d+H1WYH/LAeQNX
 PlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740410320; x=1741015120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vbETeY2HesuLS7ZuA4vCEpXbGVV/pRBgiL2UcfcqRKo=;
 b=wY5h/hQaY9OIqIM+huE4bm+4zjt0sr3LUj2eUHvX4bwmZyjSjE/XqwFDcrVdbv9pHw
 TaGtLBtp8ocikaeE3MHeAt+7Y4WLOdcq+Ixcnn/xNaixLDhAlzhZB5Ya318EDmOpoAwj
 hKUPjoPkR2b2ilEQIXOZJEw6ZVL0nrWrAZuSudUSf/8OTAPEhoAixx/U5R/LLGh9xgYT
 JkTW3QCk5JUlt9fBRQFesXalj56zWUsyHg+66Kk4W98dzCi5biot3q8EYqMVDKqJPUvd
 0GQ0aOpfS52MEzxbAdJTv85m4Zjw42bJ1iD1maWshpKScn7ornfVQ2xpUCqdrFROkbWN
 8zCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3KV8EgTw0AyJqZSSL5kKdqKMvWrwb3DD6vD7oCLaIfH9Qi7/RfD8YyHwTp/ECwb5sJ4k0zCFMozUK@nongnu.org
X-Gm-Message-State: AOJu0YytV5WZp8ojRRqA3IoC/DAmrrBpiO49HpIbZWa2eDP/781mzCRU
 2y5rP/77VQwRWEbtBbmCBlqVtXO3pK88cll3xH6IrnHa3S9rOPHv3NeQuITKgpQ=
X-Gm-Gg: ASbGncsMp0zWlCts8YKmNf7WemfRTlJhnAiNlE5UBW+7Rp35XgL4ZGnfUjND6k3YP6O
 Ee1xaRref0JG99XSSJTU4WoP/BqnHNQGuFMTCOCSkfCpUoFoY3w4VP6GcF92s2wIM3RawSYFUmL
 7GBE95akfitG1DN2ySMbYulz1h++K8sKa12u4hNnN4P67DQlkHbyImg/SJxOkT4AGCPWWiFDKx/
 I5TBrcSuXFMe4sTq4g3igHdjAyMV5S029DYe72U8hflLydlSnHwFoZsRSdRrU8Tgy3Zp2mEn9B1
 mvF9dOonlNR9p9Iprv7RHCvisrTo/fC0mihJZ/l2RHLpGLtzi/d2mK9bnK3sOM5oczyR0edztmY
 f4/6AESEPCGI=
X-Google-Smtp-Source: AGHT+IGVnocAqsFdi4PA8FBhwKh170DDy1Lb7+LyZ+5vI0+eYR4DhiOyks7wOIpTNKEDAPq624cc9Q==
X-Received: by 2002:ac8:7e8b:0:b0:471:f074:8bac with SMTP id
 d75a77b69052e-47222955148mr182471181cf.44.1740410320082; 
 Mon, 24 Feb 2025 07:18:40 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7?
 ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47207d1dc11sm70495621cf.6.2025.02.24.07.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 07:18:39 -0800 (PST)
Message-ID: <62cdaed5-54cd-4f00-b62f-44a70c774c21@linaro.org>
Date: Mon, 24 Feb 2025 07:18:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] fpu: Remove remaining target ifdefs and build
 only once
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82d.google.com
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

On 2/24/25 03:15, Peter Maydell wrote:
> So I think we can consider this series as fully reviewed.
> Does anybody have any preference for which tree it goes in by?
> I can probably throw it in to target-arm.next if nobody has
> a better suggestion.

That seems reasonable.

r~

