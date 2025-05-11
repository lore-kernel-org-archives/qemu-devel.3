Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C030C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE71q-0004yJ-0M; Sun, 11 May 2025 09:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE71o-0004xk-1y
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:47:40 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE71m-0002tV-Dn
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:47:39 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e78f44034ffso3045195276.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746971257; x=1747576057; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T3gvSZGTVPKwW5jN0awbcE7LspiM6JmUghhSxyn5kAQ=;
 b=MAHD9eMMbxt6oFtRCbrjAm24cxZJ2I6j5jJlwtXluHQ5ToYaOOdO2G+NrFT3o6mlb4
 Sv8y/FRVvyb+nqi2IMUv62QqyF5wV7yxU+WXejAlyZpOzc+ngyeXhF3HbZayW0xv29+k
 NSUvAqncz0TD1OmoeZ4551BlBJAaZduRTKOu040VqIhBVOVeBOGPXx7+Z+xFFu4jxbR4
 IeaCqMp5GQLP/7EaJN15R6yNWjyzUdExzmaNnMmJgzBmJ4AlJecN8DqWpXfD0nFZtjZ7
 eXJvmJuiH0CJRRcyngAg8EoHoWbeg9GmhGHzvZqyXVwOtcYJ3AwTynBqAGMpNjISaxFb
 625g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746971257; x=1747576057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3gvSZGTVPKwW5jN0awbcE7LspiM6JmUghhSxyn5kAQ=;
 b=nvc34X/XTAUDnPZ/3l7Mbp5DyxooDh49jaTKuCSQgM99CnmGdM5y091850NUcj18Yk
 U5HND5+LrenetJb1FCv4aflugd+UecArwZlYj5reEG6wwNWhzOD5IeQG3CsIFO7fWqaa
 eiEy1TS+T9FnDiGz9Nffc8eNsSJ6NjNxDudcpqLfopefQjeYlFCvS98BfXLNypDjW9lF
 wKJeGhHgPLe7ycmzNyw5qGuERRRFpPzkJiCWT8MJ/5RI6zYycZHJzL6xmCH1Yrr6+5qM
 CzoJc1sNRDvUo0p4nusro+auVPxzBCJRXrr0xwt/Q5aiGnfds4sg2JHxon4osS1JQ6C3
 jcig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPdx+sWPPc/felbmPH+0W0C0S26RIM5k9QSPqk9EGEZoVHCG4KMe++dKvsjt0vbZ+LnqdOP5Bke0w4@nongnu.org
X-Gm-Message-State: AOJu0YzGCw2n4RwtonuZcDXYwOk50wQN19aeeQ20C7om690jjYLoLdgs
 5PUT8dHfHbVo8ju1sOuXDVe4Bi+nYGlhwoI8lm2ssQ2s9uuFyPDPVWPD0dE6yLVzwM5lbI7xrjo
 jlHfb9hVg67S14SrYTUxN2ZxatiU6kYEX5iLYVg==
X-Gm-Gg: ASbGncvIh9LLi1/YrQARkDchx8DimIhcWwxMgE/Y+2GygQcc+J5YvXfN4A26KdqNp0N
 RabLHDgAYzmO6gdhf6asYxNmy9fmJrns7oIJxAObHbWcF9fAqaybwB/K79RDOR1dlvmvhB3FNmi
 NAxcmLeA41Qkvk+2zyeRQU+sJLYTd59YHsZA==
X-Google-Smtp-Source: AGHT+IEuQ1euMZIm7PTNyMLZ8bWWidagZzzYnICPAbzFb/D1dR7CAnfExgis2KQK64SgfdoyYEJ63xOHse8rK3ZLWNo=
X-Received: by 2002:a05:6902:e0e:b0:e73:1ff1:ca2f with SMTP id
 3f1490d57ef6-e78fdd2dda9mr11898187276.32.1746971257212; Sun, 11 May 2025
 06:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250507091859.2507455-1-timlee660101@gmail.com>
In-Reply-To: <20250507091859.2507455-1-timlee660101@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 May 2025 14:47:26 +0100
X-Gm-Features: AX0GCFvCF5sE70k3F3ionhPDO0KEVLYk2jXjGcgs5eUwySsI75idcZzcapv2UZ8
Message-ID: <CAFEAcA82=0Pp9U=W5EAjcVkR0GL_o1iVPuUPA=w2SFy4mwd_5w@mail.gmail.com>
Subject: Re: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module
To: Tim Lee <timlee660101@gmail.com>
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Wed, 7 May 2025 at 10:19, Tim Lee <timlee660101@gmail.com> wrote:
>
> - Created qtest to check initialization of registers in PSPI Module
> - Implemented test into Build File
>
> Tested:
> ./build/tests/qtest/npcm8xx-pspi_test
>
> Signed-off-by: Tim Lee <timlee660101@gmail.com>
> ---
> Changes since v1:
> - MAINTAINERS file not need to change
> - Add comment for copyright/license information
> - Correct CTL registers to use 16 bits
> - Remove printf() in test cases



Applied to target-arm.next, thanks.

-- PMM

