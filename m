Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D778DC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 16:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryDoH-0005m7-UW; Sat, 20 Apr 2024 12:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryDoF-0005iQ-EC
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:43:27 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryDoC-0004lv-Uk
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:43:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so26440865ad.3
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713631403; x=1714236203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p2Qi3Z69q+iov6pHwb1AL1DKLkWOYopTR+eWFrUSnBQ=;
 b=LIJTEJ5M+xeBugeILPXqDCePwtOq3GwtkcMv0M9pnefAYujsqKHYlJblZwg9yeoUBF
 e/+KmScPELOs77cbMB1FXtvAhpGMkeGcDEvDoZ/jIq1KXQcG208g2aod9MoqPqGuJOiz
 05mIkquXDNEqGi9GwxU4++MOEsJf6lsrbm5wrQlKDv5gECyeKxOkB69oa4JUtshKOUty
 CCfbzCKgFkYqI3YkNDSZ9G9Q0fttYK9IoCUFu3c7gmqots5qypEPiO7NO34Naiit7RzJ
 1urHE5QMUB5ktn8yxMepv3hQwCHhW+SE2LjNLGDo6dUKQK6uz8i5r1frD05tj27eJ0St
 uB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713631403; x=1714236203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p2Qi3Z69q+iov6pHwb1AL1DKLkWOYopTR+eWFrUSnBQ=;
 b=nEwYxqLWOSpi/5P9oMtm1qRCuOCwpH56EUgchHcMaJFZ5baMl29a5mge4JYpxZlIIF
 BSRPhnkAmRRFL08Kb0IdjtB9U2ZXrMLj0nY1F6poabiIkj+KZQw/WOnZiUnMveq9+fTp
 LcYJMSLIUmCNbQy9nXjN28TOl4awZxP8rUWuycP5YB3pnG5NKally6UR9UafK5KzUhrf
 bAUVMiiwxfEyqz0mJ25dqyngrAJbimfnq2BdMTay4C7FejoLah3NFjHjF2o0nWhtTnrD
 9DwP2hiLzJ9aSOBnbfWmOcv1HwUAPe/dPvSR6cjCx0BPBONWecBugVm7rNKl6UfcgRwv
 LBfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0QY4da7P156dxf2IZKHnrxBZLtt/3QPBm0avV1whbaS0gpd0F0VfXr1sN2l/ennYTs3TKczUSoyX9cxLm9ppgeR4LKog=
X-Gm-Message-State: AOJu0YwGFdpYLjtMBij21yozuPDdIgmv4/EyIpkdZajeVP+7FuYcf+uG
 6vtt8UIN7PWe+ZQdcLqc+A2ku6i0TEVevnn96HG5xau6o+fNRmDQ7cRThis6o0M=
X-Google-Smtp-Source: AGHT+IGvaTzai2nBRgo7Bm9FYoXYHBi4etHXcMS5jNMBl0hFj7PArOjGcaZm7QUtRwp87hYjzVGkmQ==
X-Received: by 2002:a17:902:d48c:b0:1e6:11ae:dcde with SMTP id
 c12-20020a170902d48c00b001e611aedcdemr6937900plg.58.1713631403110; 
 Sat, 20 Apr 2024 09:43:23 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a170902e80900b001e7c05cf1a2sm5246142plg.112.2024.04.20.09.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 09:43:22 -0700 (PDT)
Message-ID: <b51ecf9e-ca5e-4548-b9c2-077ad9ccfd4a@linaro.org>
Date: Sat, 20 Apr 2024 09:43:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/unit: Remove debug statements in
 test-nested-aio-poll.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240419085819.47606-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240419085819.47606-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/19/24 01:58, Philippe Mathieu-Daudé wrote:
> We are running this test since almost a year; it is
> safe to remove its debug statements, which clutter
> CI jobs output:
> 
>    ▶  88/100 /nested-aio-poll                      OK
>    io_read 0x16bb26158
>    io_poll_true 0x16bb26158
>    > io_poll_ready
>    io_read 0x16bb26164
>    < io_poll_ready
>    io_poll_true 0x16bb26158
>    io_poll_false 0x16bb26164
>    > io_poll_ready
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_poll_false 0x16bb26164
>    io_read 0x16bb26164
>    < io_poll_ready
>    88/100 qemu:unit / test-nested-aio-poll        OK
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/unit/test-nested-aio-poll.c | 7 -------
>   1 file changed, 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

