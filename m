Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCADCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v633E-0006pw-LT; Tue, 07 Oct 2025 04:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v633D-0006pa-7L
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:28:03 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v633B-0003DN-JU
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:28:02 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-749399349ddso76713667b3.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825680; x=1760430480; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNjLpGx1P1UwQzPXRsaQNEN9N+5FKgvGjX5p0wxxQio=;
 b=oV2RK+0GnY+PCNQ5PAqMjlZmgCq4fJfSoEjfvzQgGCiTQLD2e6O2JMoSY0S1YgJqlW
 8ZYTpKS/UlJ0PwdFnWGzNCfC2ahNPUeZl0kj0eoZTBSLPhtJjfUYQU7Hz29J545XNvuN
 DUqEMhHCYcrNMYIYVZMgFWJCsedcqm6TjMOefzopSNE/yLjDPeuTE4mKgu5YbjnN0eVY
 NG/uhGFFFy1CVSQ1OLnd+q/DYWA36zzWMVf7vHEhaO1dPem7AwneePhx2Z5PNYuwRjfU
 n9eRx43GJgcm2WTKnrLwiDFwVAvrbjCvQlbopgx8lrjVPMbYr79I34e+2eQa5aDbFHX2
 wGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825680; x=1760430480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNjLpGx1P1UwQzPXRsaQNEN9N+5FKgvGjX5p0wxxQio=;
 b=P1B26Ua/CbddcwylAdGnAaVH3+y5RrZj4y8Zl9Nge0MLYhvxGmkoipBfi4YJgKAiQV
 3ON2v1ALT6mrMPWJ+b7izIbGTMDWaXIicwg+iL8OuHiIZUkB4CuWnlsgUXZb3NturJfD
 LU9w8iu64FFN/8pEE6pfg4m54sOG/LhhYf+sy+JFHAEUPsmY3A1E3piv1lDBGLn/wAa4
 h7iWdZsRUzy9+e9MjE6EKrIg9RyLbg/J/CgrzwcgN80IAuDXf6nTGOoB9eFQ+YdF8HkU
 wSnVk0SZeCJSVW/jF/OglnRJcXClaKp48xInDSeZCyFV9MG4BVrIdNQOfgvNm5hy+MIw
 KqIQ==
X-Gm-Message-State: AOJu0Yy6A8zq/GxqMuMhGEug0ONbD+APft2uOPtHSzAuY1Colniy3YHl
 G1OuYGZQIqRf2DbiCAzSYoJ0Y9l6BKuFnyHw4giJ569WPGy9Xx0CnkB5A4UI6RfblAqcDrCO8v4
 8VosrqsZvIK4/W41KGiFWrPDoeoeksRZjOEHuLJdyJg==
X-Gm-Gg: ASbGncsCLSYMlBJlls7+De9i8IWB7NvuV2jApU+XeHbO2ljLIV+g6/v1t4A7J9aAOjy
 nZhkPcjSKTx8IP8J4m4B5Hly9dRQZRIDm61wn/G6oG1qDz03xafPlAhEWHy7Sb4tP0YFQ/hW7CX
 cfyLoTBozV8l+7/nCrZAFkuAszx3rcwGVTkTfYhKXzFgP0P8c8nFcfJAmCeFMsmjS1oF5fHkPpk
 BjFA4KqQVYr8twsuw38havrZYHtV0GWaGDHHaZgzV3zZhM=
X-Google-Smtp-Source: AGHT+IG7gliDXKbHxttnwNWKZ9H313WRShNBdS3kwuPk7XXlSA9tJcRY0AYDnxg5Rn4HLpPlxilk7Y5WvNgcV//zJgw=
X-Received: by 2002:a05:690e:23d4:b0:63b:8e80:c017 with SMTP id
 956f58d0204a3-63b99f35953mr14222164d50.0.1759825680014; Tue, 07 Oct 2025
 01:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251007024006.43166-1-philmd@linaro.org>
In-Reply-To: <20251007024006.43166-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 09:27:48 +0100
X-Gm-Features: AS18NWDLvhQOVDDYsnBFkgn-2H5She6TB-swOpu175Flh9op4jv2jCCGhL8o1dI
Message-ID: <CAFEAcA_ytH+AwTr9LAZBP2nbSTod0FkfuexbewW=T7Pbb3nkmw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/max78000_gcr: Do not ignore address_space_write()
 errors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Jackson Donaldson <jcksn@duck.com>, Jackson Donaldson <jackson88044@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 7 Oct 2025 at 03:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Convert max78000_gcr_ops[] to take MemTxAttrs and return MemTxResult,
> allowing the write() path to return error on failure.

*Should* it return a MEMTX error on this failure, though?
This is a question of what the hardware behaviour is,
and there's no reference to the datasheet in this
commit message...

thanks
-- PMM

