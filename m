Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89455C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnue-0001EX-T0; Fri, 02 Aug 2024 04:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZnuY-0000oJ-B8
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:45:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZnuO-00044R-Jf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:45:11 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso8411782a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722588306; x=1723193106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I3O5YZSXhYuYAfurIwthezz4O9A89eFbOTsyuveVgrQ=;
 b=BTBUvPOVQhfWCHhdkuub2AzL3yoZzAlHbdo63nqaVBcIpdbcdjf/ai9HHeD1QBODEX
 JzpBSwh21S41Lgog9oiq57Df6rn3iBvHm8HtLz0tyhEGBv0ATv4zhdqiqjgm0p/GNaR2
 cCzIiRZndyv/ygpjmMFahLoS1y9UyDAJFhIVgFtLD6EujzdCWXFvFMImesmDKFX9j5Rq
 jhd4sjA/uzlAvIpnqaAePhvZ3HcjKo1jZKEGeoSAXpM4PKC2JLpW3QhTu4M7j11eFKUy
 drGQzWHXkFEz4YRr05wGgtFlKyJZtTp/ae8SLzjAaRKFibv2h1Skoomb4nskw3yATNS/
 iyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722588306; x=1723193106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I3O5YZSXhYuYAfurIwthezz4O9A89eFbOTsyuveVgrQ=;
 b=A79oDUMrMsy117pWEISO9qC8yW/473drAkxlak92PbBaST+TVVqWwE1bngVyLCJKfL
 mNKvHALQG1yk7VuRzgXjpvdiLqjvJkkvUW/Wj2wAV7/iF8QNvhXtF/l2rOaf+1e/Ul2g
 ucRCnuOBTGrjLqnOkMqp1aTYd1kTn8OWUqI0WNaGdq41Pq/eWo/Qt8pYtDReeANZqN3z
 wC9rQXfzzbMtQfC2gBXglI4HXdCX9J5TCKm3CR0ZTNxeT9DW2hAvwsOj/IDMtP8pGe6x
 IgHhPJEibZX96HD7/McZ+5MaNBBL71hBvfWO4qocO+Sx9Dvl1DkhqFwjcFpubi0oFEyJ
 AnVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOA9JGIwzCNdI/mhjqJNyV93HvevR84G+y7h/4jBI+MvmMHK2lVzuSiv6K+mxPvZoJPvRvqbbFiQc7mmBFYoXcQXDXFPs=
X-Gm-Message-State: AOJu0YzMnvtJiKYU4zaJr+GtU8NTZ7SQHSo3U0AUMWoYsSrqB/+SrM45
 5ov5ts59eLjTltanZi3tsTHi08MaGLTh9w33iaWRaY6V1QgbrUqjQfzr/EO99Sn8jWTn2TzJ4kR
 fEugeshgEEDfPMZkjSIz9j0nJBspM+M2xndtH8g==
X-Google-Smtp-Source: AGHT+IGNI2zRTur0pG7h1wM6TZhzZnVGBJq5SkmenFVGbM4Kvtc/EGWb2BNMaEqU8pFhkpelvkRbfwot02f8KPKzDac=
X-Received: by 2002:aa7:c50e:0:b0:5a2:87d3:6ee6 with SMTP id
 4fb4d7f45d1cf-5b7f57f41f4mr1968382a12.32.1722588306306; Fri, 02 Aug 2024
 01:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
In-Reply-To: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2024 09:44:55 +0100
Message-ID: <CAFEAcA_-bfGnQRc6cjp8Ej3WKTJGkKfELzv5j3Zc-2vyNHm9ng@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Fix hvf_sysreg_read_cp() call
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 2 Aug 2024 at 09:37, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Commit 05b8d7249109 ("hvf: arm: Do not advance PC when raising an
> exception") changed val from uint64_t to a pointer to uint64_t in
> hvf_sysreg_read(), but didn't change its hvf_sysreg_read_cp() call.
>
> Fixes: 05b8d7249109 ("hvf: arm: Do not advance PC when raising an exception")
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Richard: I'm not going to be back at work til next Thursday:
feel free to grab this and apply directly to fix the cirrus
build.

thanks
-- PMM

