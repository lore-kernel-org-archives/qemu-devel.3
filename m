Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C72CE7B08
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtdi-0003fD-0O; Fri, 14 Nov 2025 08:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtde-0003d9-VC
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:14:56 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtdc-0001sy-Ot
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:14:54 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-787df0d729dso19244947b3.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763126091; x=1763730891; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MtgBM3ikoQkJktFZIUCB2IV1PW10q0Nj18JD3W4Hps4=;
 b=sbpm0zPqJ49nFdL7LUE1kQZ6FgLEm4Gf58Nw/TOPgt5AzOB4icDRK2TqV5O/YoFD/2
 /fh8wi0mygkkbps5KVXdhq3p+dPcGQR14Z4/RhH1rnJW4qCE7oKpnHy2zs5vsE/Uqk3h
 IphxMzeV6Aeqf4tpG/62ezNTqzBFyx0PlnQsjskrt74yduoJovXZknQc1M8bD6B57meC
 tNwjUclNIKq30oYZc4S9Yc6DjyOE/HioffXg6tGr1JEMPGU3tM1ehU33ni4LaISKVzMJ
 TmU3LKEr+nppplVREdICCsSOrtOJINEOLv3wznG89KTiulS61WDwkvzn3rW5j8rAeunT
 6+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763126091; x=1763730891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtgBM3ikoQkJktFZIUCB2IV1PW10q0Nj18JD3W4Hps4=;
 b=JPsItFoPoatSC9aWWX2a/DP/6VVAHfvLFRATyreolDQk7BwXIMwr5mWVlz2nZcKGPl
 /vHFOPMz52jmDTzgEXeBGcSqBhXe2ehjyWBbqAIbn8CDemem9jSDyEYDr4Xxp8DW/Dpq
 eeViP6wAG3NRGFvC5+CSes/+vOdkwX7bQX/eRZYq7w19yuYLneUEEf0Q1WWdQX1rC5wL
 uZChLBLIUuO7yPqwCnaQ2rrHcdY+JudRe91IN0oAYXsmCiIP0pizBtWlgoVKry9K47Ue
 g1BQbzR7MsGATqWSLFl8XKgGwWEM5dYIxbs8Y+UE7QauBxXEyaC785fKrLqqjAHbcl7j
 65pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFx+wJUorn3J4HDSPFKb6zBkutoyvWkH14LKR3bDYr6zXnlkcQOB9Ia8EkIEM0jFu/p6PwHIz/GAR5@nongnu.org
X-Gm-Message-State: AOJu0Yzj8fQZzuPkZXutGmBmIpw8pRySMuJmvNJSvdw32u6n0tjepbAh
 gcWnRgPkyllaKZqPzHcIVEgDJ5nAIbKjBl6JDGu3guvDHsZis/E33fqOFSLa6cThcUMABUbML/+
 dmjcs30ZZ2L8xk8lidYMSIERaUMo8WDVzXzrdo4EL1A==
X-Gm-Gg: ASbGncutDqSaBgTaudOH8ylSe1tkJ4JbebTIwyU8w4RkWGDMQcrAqepNZKdyjPr+Fen
 A6ya21b/Bs9zo4nUuuuqjASF3w9YG8xTYToa53CFp55dfrwSx9YUieKIMPncOWB3La+qILxTRY8
 xRs9UNjV58XsCzLddRD6uSO8KephtSzoUBnFhBamCgOA5UFAB9U08OPvHG58ADV5qFFBQM19LFz
 mPweOzRS5PF9UeT+UGZLY8LOXOsgBJEx5ey9jJfcENF9ltcSR8zjcH2QbI99Q944nfI/aO3
X-Google-Smtp-Source: AGHT+IE/KbTIOOyMY5B44xM+bPQNCvfVDFiPrP1w/21N/y8gsNDQuw+KYm799GL5JGZ4KZ3fPyehfo2c9wCEKivLn9M=
X-Received: by 2002:a05:690c:e0a:b0:788:182b:a79c with SMTP id
 00721157ae682-78929eb6343mr24265057b3.35.1763126090774; Fri, 14 Nov 2025
 05:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20251106145209.1083998-1-peter.maydell@linaro.org>
In-Reply-To: <20251106145209.1083998-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:14:39 +0000
X-Gm-Features: AWmQ_blf3CaK4F0wSyrfohweo3ZJusObm7GQxJYSV3702ldpf_AYFbbVAJvjd5U
Message-ID: <CAFEAcA8tD9=UiKt02Jri-oK74ECHXgAhr+e4CELy7dbCECqLiA@mail.gmail.com>
Subject: Re: [PATCH 0/2] xlnx-dp: fix a couple of fuzzer bugs
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 6 Nov 2025 at 14:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset fixes a couple of bugs found ages ago by fuzzer,
> where a guest that tells the device to do silly things can
> trigger an assert() or abort():
>
>  https://gitlab.com/qemu-project/qemu/-/issues/1415
>  https://gitlab.com/qemu-project/qemu/-/issues/1418
>  https://gitlab.com/qemu-project/qemu/-/issues/1419
>  https://gitlab.com/qemu-project/qemu/-/issues/1424
>
> None of them are really very interesting, but the fixes are
> straightforward.

Applied to target-arm.next (with the abort() in patch 2
fixed to 'break'), thanks.

-- PMM

