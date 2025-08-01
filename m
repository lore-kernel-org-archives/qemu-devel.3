Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCB3C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv4j-0004Nm-JT; Fri, 01 Aug 2025 15:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtXJ-0000n2-Es
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:27:17 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtXH-0003Wj-E3
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:27:16 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70a57a8ffc3so20448577b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069234; x=1754674034; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J8dWfHOLcP3paT5Mxqe3VVA6NpqZ1Sq9qi+vnhhvN2c=;
 b=O1eOFKbi5Z42eOhS2cv8TnsnlOOJlV2u28NRRSoMQXwNggiE337VGHbIPsO3YKJX/M
 X83WmLstJM1e2sdGWFsXBr9Fli21qZh1xrZ0Hbp4FfGbzdEQdytdLdKLK3m6QzOmZ1K0
 3lO5cwIzzGFMVvInL4yuNwJir4q0LsaBAfdHj0P5hzWD8uzEsmsXHkbDqAHpCW0Nr0dn
 8uGG1S/Kaz6QSJFeo0HuHaO6s1hBvTIIJYxaj1ChBJXaqS+iMOO/i4NGMSm78jeaKsGo
 cJCYsstxKYjV43PSulgjb2W8CCkSAaQYEA1DCCRk5RBeaoQ+wxKfujb7ieOwmA3s9DzP
 6H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069234; x=1754674034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8dWfHOLcP3paT5Mxqe3VVA6NpqZ1Sq9qi+vnhhvN2c=;
 b=X+lm8OMBUoEgDS6QHdrXU7rnI4Ibmdtg8EkJl4rNbNalXbH7iA41cB1y/XLexlwSWg
 592RM8Hz156R9cbxtMeFtKujN1l2Q449rICXK9D4qPLeQaLSzK3DYEKlAH+4wXFtgvB+
 Hxqtft/rnSixiOqiqXrRwiDBSSothgh3u+xKlsw+W7uDk4Vsn3BSzNxzu6X20v2wJn/8
 z9owSSVfLWVCjdfHCe8zIRfsck4tcJ9DZCgDsJzHNOHrwhu8G79tMrcoO0dlabNPJ9Jo
 6eT4l8ffRpl6kCqtm2frWAiT+NlUoeh9Bfy8caD6kIcNiHe3u1zwXburPq2ZUBSuL/k2
 FwJQ==
X-Gm-Message-State: AOJu0YzAR2pq3QZ+WFubIYBylOvULHummYTKrXc3sOSuf7yiRrbCN1gi
 wLNQp73fBFESHBMmvjxZVmyJfAsfcr9Mv+TcW7SBOrugt/Hujl77bpbzuAo/LtZRE0yYgjVAaHQ
 YnIy1L8YiDpHDhh/BEozkZcloyJGSBJbVQxuUc9nyySGRmpvbcvE9
X-Gm-Gg: ASbGnct3HCmt8/lEncMhLNbtEcMPRSbQBfe5Kq2fJrT6LKZppCPDhRlG32zBMkg2aOo
 0OhNn/VBbnr8dyS56Lu7Ig4YNsFot3IXyf/+ss4A/5QIw+1+SLerpeivI/BXnCvAsPjz+B+oKIJ
 Dx00LRRimbOelYVwhP+SQMLgs6Le5cEFWSBw4h+M1pM9fNzN96aL5N7MlIkM3bKS4LFqDKBxqdm
 BBdjxhy
X-Google-Smtp-Source: AGHT+IEbE64MGSIkLY8ou8bJlWwEK+N8ywwgzF6P1jKeXKPzyb/fjT7Y2QK6NXLQGtTnrZYM+xyg143XIabrbn/NlR8=
X-Received: by 2002:a05:690c:1a:b0:71a:22e1:b32c with SMTP id
 00721157ae682-71b7f5bc0d9mr5835067b3.4.1754069233859; Fri, 01 Aug 2025
 10:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-29-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:27:02 +0100
X-Gm-Features: Ac12FXykhRDjhMeMOiEbHZvr7i7-7mGx75Gu9V9kwbMMjgP1Td81n-pT58bGrn8
Message-ID: <CAFEAcA_KE7CMfNT1MLJhJ7hp_hNN+ZwjPEJh3h7nHqXDotjWyg@mail.gmail.com>
Subject: Re: [PATCH 28/89] linux-user/loongarch64: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 30 Jul 2025 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Note that init_thread had set crmd in target_pt_regs, but
> target_cpu_copy_regs did not copy to env.  This turns out to be
> ok because loongarch_cpu_reset_hold initializes CRMD properly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

