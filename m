Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADD9C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA0jA-0006Ev-Rs; Fri, 25 Sep 2026 03:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xA0j5-0006Ea-NW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 03:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xA0j3-0003sp-7u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 03:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790322726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zFaIgch2vkwvFVm6/wR/04bHig+LuwJ/wCVOncsZOd8=;
 b=BqD95wtFhUPsFPtC6omHa9wkb0yP6lrRRtkOlaQxD32TVw6ZCagUDKTacQChztCndfBdZn
 1VWeTOKD19bvpRsNO8NQy0+mOqj0QO93xoTXp1ZMByxsy5IyDrFLioHnUvfdW3bO4+WID7
 SAmENgY5KBPQbh+pWmfJfg0WtW5Ha2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-d-xgY3qBOV6XC1ydtEz3nA-1; Fri, 25 Sep 2026 03:52:01 -0400
X-MC-Unique: d-xgY3qBOV6XC1ydtEz3nA-1
X-Mimecast-MFC-AGG-ID: d-xgY3qBOV6XC1ydtEz3nA_1790322720
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso6990995e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790322720; x=1790927520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zFaIgch2vkwvFVm6/wR/04bHig+LuwJ/wCVOncsZOd8=;
 b=fyKE5UADZrdyPTrAcWMGRssoFjZ79DKaJ3YDi/lzNGXlf/fwfoitI8Uoh16ByiW7YI
 7h9Nep6ZzxE9FyQEDfWkA7PzswTelM1fwJTWZ0AbVv1FxE4fhze4AA+JUHvs1YZMEKLH
 1UywJmtYao6XspQtDaDwtMySeGjz/a8yxBxBDovsO9KsjjivgsnkufIkZLClOKfut3i2
 LPj4yzzeTpDjAEQsdW+ZBXarUNWF+o3RgsmSvSpgSMRsn45dr/rm9zJeRIoEtd0h1IRV
 L5UKSmy7zB/6C2HyZq9tnUfFMrmlNg8mYFWVkHuwzL3QY4ZTkmLMIvcQrH16SQlGi9Vr
 YDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790322720; x=1790927520;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFaIgch2vkwvFVm6/wR/04bHig+LuwJ/wCVOncsZOd8=;
 b=y38Xl47WAl6JqzbjiIS48ehYYblyB3v9sgdt9tpBdHHzELElY0T4w+9ZcoWYwFzsdz
 WiuS50ZyEpEy+gcArKZsGqq9iBzBaZfgO8C0VRzp8OpSRtbeUhlCgBQbH5dnnReclXwc
 6P/0rLWsTsRUCuoTQy20WsbAtOPrS6POtVcNsYjITDa5GRJGr8XwcpaJvfFFUR00Ve5Z
 OB3kIDjJWBb9Lgu+d/qPohvlry1xD9irzusGTIaafyM6kHtuCqFvEZLlfyQ53t5XcomU
 ja80U06bCUofYUb1Zl5Ip++kNyji1hzbwrS5Mee9m1gjG4/Wbmr5pv9Hv5oqJWtQDS04
 kM1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0hydSW1VwNNzfwv+Nonj2oG1hy5boKDDn5Aiu+Raes7DQ6m9mruCTyrCR8vSLn7/B4hQV8iqNltkN@nongnu.org
X-Gm-Message-State: AFuF++k81tm+zTb1Zb6CQ6R/i/v7UljwsHn+NOZE5GxUkyuPiuoqTZ0L
 0EnoyZEJpYVpTtGl44SiwxKmHgODBJAYbAGFOxsviXqJSd0qJ96khpZRYhd70a1Ixd/8zz+eMag
 24PphuNnhYTSP/j+2QUYtmYtJw+ju2kAD7NQ8WOzfQrXPIYJiuuhx07sq
X-Gm-Gg: AYBFou2406j+URRyKK7fVYUh3gSuVEjbfIg0sdiSuBm/rNFtYN31MSWg+yfz0IrTzvw
 WvCgDFXHjfW8z2C2Ue+hKHMpt6HsNXV9o7dIzghAt79HEem0Cr+wGcKv6JqzkK07bLmykoxPdmx
 W2b59DUa70DXySFGHv3QfXXEyfNlGggQdJOY15pgFExqRjhe88lpxsEhYTGhKLYnVhgpiJuUK7A
 isK5/Ea0cE1fNb9EXpvgFGD/mb1ujjuX2Be+3ZqeuCsbfg8Glo/Z09XJrr2okAxPpirZhY/jxIM
 iLn8lp5eRzjLKDrjlE5R6VSExh2DTzOoDt9dpuN6X1meZt0+U+E8k42jknC82K7wXCXolAqt
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49fe66d8135mr81341045e9.20.1790322720556; 
 Fri, 25 Sep 2026 00:52:00 -0700 (PDT)
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49fe66d8135mr81340675e9.20.1790322720183; 
 Fri, 25 Sep 2026 00:52:00 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff06bdd11sm40552325e9.9.2026.09.25.00.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 00:51:59 -0700 (PDT)
Message-ID: <98a4b3e6-e538-4bd2-8cad-7307ce24b698@redhat.com>
Date: Fri, 25 Sep 2026 09:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260924135634.2626603-1-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260924135634.2626603-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 24/09/2026 15.56, Daniel P. Berrangé wrote:
> Recently QEMU has received a denial of service attack on
> its bug tracker in the form of 120 reports in 10 minutes,
> and now repeated by another reporter in the form of 50
> reports in the same day.
> 
> Prior to switching security disclosures to the bug tracker,
> single reporters have submited 18, 22, and 114 bug reports.
> 
> None of this is sustainable. It is an effective denial of
> service attack on the project maintainers' time. Every bug
> report is a TODO item added to someone's workload.
> 
> It is time to put hard limits on how many bugs, discovered
> with assitance of automated tools, we are willing to accept
> in a givenm time frame.
> 
> This patch proposal suggests
> 
>   * No more than 5 bugs per week, per reporter
>   * No more than 10 bugs are permitted to be open at any
>     time, per reporter.
> 
> This is explicitly scoped to bugs discovered with the assistance
> of automated tools. Bugs where a human puts in exclusively
> personal time / effort to discover a problem are not limited.

I think this is a good idea, thanks for writing it up!


> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index b506f9f..8fb7b0b 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -32,6 +32,43 @@ on GitLab, taking into account the following guidance.
>     triage of their output to validate all findings and reproducer
>     scenarios prior to submitting a bug report.
>   
> +* QEMU policy forbids the bulk filing of large numbers of
> +  bug disclosures that were generated with automated tools
> +  (AI/LLM, static analysis, fuzers). Such actions are not
s/fuzers/fuzzers/ ?

If you agree, I can fix the typo and commit the patch, no need to respin.

  Thomas


