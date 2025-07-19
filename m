Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4BDC83F3E
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 19:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udDgL-0007Po-2g; Sat, 19 Jul 2025 15:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDcC-0004dw-Ma
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:00 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDcB-000160-87
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:00 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-711d4689084so28259987b3.0
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752954778; x=1753559578; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qd3wERqKuiGBpuaOMT8GhHODwK3FVGCFy0OtpkHzt/U=;
 b=uE+GRB9EJHY+vnrWA0EX110lfPfSeFpK45yGHbtNrQVikW+hjLyGY8EL31mdtTW1hI
 zNHs43pyDW4kFQJcJONX7HPgMmexK1uJIomlonb6c/z16fSvm7FSmLjWDRJ4Eg+NNBX2
 v6kiQzbTIBDKji1Gpp8x53d4kJkwB3HLyW9UVpOXsj1NYVJN+PBIlaY03AaxW1F1BZ9P
 1/MQY7vvvrSJDNCfJi+BiS1ymzt46nRxDJMexA3ioh4twwutQjsuL/Ca9q4enGrjCaIx
 PAF9SxxW4J+zZGc3PLT3ZtEX4ftQPPqK0pKpjct6JkYgTqzmoHunh4DXKqdRDzCD55ju
 dLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752954778; x=1753559578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qd3wERqKuiGBpuaOMT8GhHODwK3FVGCFy0OtpkHzt/U=;
 b=isqfCShnEMZJ6QO/Lws3tpcALnRHlcQwpLbhvi3L1P14WsMFxHmFjtznpgINLZc5VU
 azAyDO+byurm1p3iGSUbj3AL4xn0YrRfXbhtYYOK2VGrs3ZTN47MDXfHvNv65qyEsVJl
 h1PZ9mxz11XEjJKvp6ZO+h6NbJJay/vMqu3BeFnvqX7G2726Qf7tlMXU9Ee6UvWlv/2t
 YxLniowid1N3cau74diXKbH5Y7v83N99KBUEPhea1a6SEWBCH9UnQGE6YmtX2jxbvzb9
 yXYySS+aNuRa70lmjhe/DJOYDR+kW8eS0+TMq24B4ir6r2ffrb/kitw4kXIPrVff978Q
 91Jg==
X-Gm-Message-State: AOJu0YyyFSHqDZik/UBaz25MhF6v8cYbZuEudlKgsAy4IriE+zEpaGtn
 aw7bStBdvVYTfgNTMcv35ovMqlDOhpOO2HqvEDXjcVqonSi6fGpLvZzhGtl9iA2pxc4ag+ns/9l
 3E4nhvfrM/b4LfH9C25NZ9NdhzfBuPHsi+8Igrb1UAg==
X-Gm-Gg: ASbGncsaMyL3AAdjATmxlvvAox5KwWSyk/Z0HE8obJ/JmAvyiivlHxTtjY6QwQM+mz2
 trQgic/YyvzGfVps2jYTKU9YvmhIDzulpUiZ7eMu1x7+BC4XS3Urq1mYwoWHYcUBFZBfC+7yseF
 4cowKPxvSM2NXcifeYWd7h9Vrp0p7SNJnO33ozQfBNrEfB7sE1pPZSXVU4XauNGx1/kBGftUJ8l
 ECHIx34
X-Google-Smtp-Source: AGHT+IEaMEp4C2RmpEoQCaU5cV+u3cBrNpP5wq4IvH0pcjkk11m0cH6MPW2ym2RWmB1A8HFgWLYWavu3cUk0Uvt9BYA=
X-Received: by 2002:a05:690c:688e:b0:70b:6651:b3e2 with SMTP id
 00721157ae682-71834f3630bmr216981467b3.6.1752954778114; Sat, 19 Jul 2025
 12:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250717150805.1344034-1-lvivier@redhat.com>
 <20250717150805.1344034-5-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-5-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 Jul 2025 20:52:46 +0100
X-Gm-Features: Ac12FXzvLnJ3_uSWmZmqSp46_IvejDAdcCDopvF765cEyuGK7_Y729Z9XyqvZN0
Message-ID: <CAFEAcA_ckDeTqSNXb=E-TmAhDYT-2yQOMoz4d5+6S9mbxC3AoA@mail.gmail.com>
Subject: Re: [PATCH 4/6] net/passt: Check return value of g_remove() in
 net_passt_cleanup() (CID 1612369)
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 17 Jul 2025 at 18:44, Laurent Vivier <lvivier@redhat.com> wrote:
>
> If g_remove() fails, use warn_report() to log an error.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  net/passt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

