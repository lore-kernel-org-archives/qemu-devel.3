Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB0BC48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlTc-0004As-0c; Tue, 30 Jan 2024 05:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlS4-00038u-OI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:34:50 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlRx-00088J-NS
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:34:47 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-554fe147ddeso4227320a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706610879; x=1707215679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5kwvatoSmG/o2HsSbHnlknXhtTL5B0q5U35i7IAVtWI=;
 b=oxo37DIPyMLaE6y87Xq172c8nX41RZFfetIH9W7Po9k3hoTaY5NxT26FMsrCcu1xAa
 CEvBsholqpiRbRJRMzhhCKZReSXfO3EtqW/nSn8deRYTSK9pDS00H0XKILVqR2NMZvMb
 xVcHvDee7K9pmOmqfDLiFoJH1LwTQNgIS2DMWiPIG84ArTSo0h5oC/sonO7Cn/2HBMgc
 iXKciI1TcxErrvDvp6Xhx1dR1djt+ls8r32+Nxe22+RsBRL6JzKOAfCtiWC6L09hnVgn
 XCccBo9O69U8FpQxKjTZfEnTBW6AivIRjVbfiCjp1F0adwwP3UnhAN8QSMjPnV1ypnbX
 53Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706610879; x=1707215679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5kwvatoSmG/o2HsSbHnlknXhtTL5B0q5U35i7IAVtWI=;
 b=YI8ER9W04grgnDIQlooZ7OCFqdjsEKXIYfHRaoNCe0nD01kN98tJg17ccBMLNrpHQI
 7JE3fR4U+ahDGEew6viMDozyRMiWq2JX1EHsddlycvG8Q/vNepT6CzD77dSbz5zvAL+Q
 xHjBCzTAdklx7LxQcVeV30D0aDcPPCS9sV04YScVgaRSfatcDc5eFjLalCxTYAG+9pe1
 RftiD2YkqTJqZXz8r8TnfVrDPlLhXcQI6hN/tE9dkAnEUDHQhd2mv7Mzg5L9/fAGoG8g
 uZzwPjP6GvWY05NJDIe16dPC/7n/4Eb8JZzpx0BBCbDflo5XVUj95l7t+Dodu3MzN/Dp
 B7jw==
X-Gm-Message-State: AOJu0YyibuUXqDJv1VB2S2Rw8114q0+XLBn+c6GVwEkPBzXctYJFBO/R
 sJIRjYdSFVnkVgBHQM0dYnoZma/JIPEUebZcsCyTp7VdzsrOBUIKT7XJNy4z738TPS+0i1460uL
 bK6TEFuSAq/dv7+nUaQxtiWMzQUmwS9iIzl+oQg==
X-Google-Smtp-Source: AGHT+IFpZJyebq82en5CDeQv4XnkpYRwCVzExIV5Hx4SDOZgmFhryyW1S8ox319uXN0YMD+iD5mZIXQwFw3uFrIVoz0=
X-Received: by 2002:a05:6402:2692:b0:55c:208e:dd62 with SMTP id
 w18-20020a056402269200b0055c208edd62mr6705196edd.25.1706610878802; Tue, 30
 Jan 2024 02:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 10:34:27 +0000
Message-ID: <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Check if a file argument is a cover letter patch produced by
> git-format-patch --cover-letter; It is initialized with subject suffix "
> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> exist, warn the user.

FWIW, as far as I can see from my email archive, this particular
mistake has been made by contributors to qemu-devel perhaps
half a dozen times at most in the last decade...

thanks
-- PMM

