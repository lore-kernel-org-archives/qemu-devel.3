Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA648C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CLJ-0003Vk-0B; Mon, 14 Sep 2026 15:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CKs-0003Ag-Nf
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:27:27 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CKr-0002ue-A1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:27:26 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-878ed0f17bfso32664717b3.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789414044; x=1790018844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=72R6hDD+WJYl5RiYgiv/3BIyEbvQuSGVjrX4Hqydnew=;
 b=oRL8dGucGT1V8kZ3ta38aIJgOhJZiOFgHFFUFbr+YTcvAnWQzQAG2Au7E6iBrpsWYF
 /BEtyITIqBMKgUb/qy6FCnvwW7uJfqCkR8gVW3Vbekv5f3BkYtM42d8QfJeCiw1Fror9
 +ni+TXQgDtrChd7rMsUNRPlKWEosSIUZkTIjXHynPzf9QaTBJIe5Ya6fQUXc8lR/ejfn
 2PReqSTRw2cXWsB5L8d23YyqZXvkeQ89tSQpltSayC6Xa6K2MTjCYC0hdlcvJH1Dadd3
 SgvsRkcUkp+8T1sCnVMflMjG1/f6Rg2AJkLkS462Dt21cOS6pkXLMTY2s0gYIAPb9V0F
 bYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414044; x=1790018844;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=72R6hDD+WJYl5RiYgiv/3BIyEbvQuSGVjrX4Hqydnew=;
 b=D/dFLRPKjlSok8P0Rlr+d2keQ6oBw9WOuqWz42KhExrSg9Y0DuWBtn7hX+PkjvK2F2
 4835bm/m1M/E3aw0HG3wc+pV6Iohi4Gsqd3m3jAeng7EdkRbbthlhhBJA2fCbPhvCFK8
 kBeONAAnY/8kmbftab3VTtLmwNSfWbXzwfF3ioL0SFWkhN8SIT+ub0T17AzWB7eSoWOR
 sNtw7NoZ/zomDQR6y6FqOXtSwuxXG5zXTrTIW4Ojh21S+WugOQcNLrL5tQQYEfuHu1vf
 fWxCCubPHPElHvW+2fG5GYzE3ceY4Mo7i5gvB/VU1mx/w1HVy1Pb290rn6xe4szu80Lz
 r57A==
X-Gm-Message-State: AFuF++kG+mJ0HtoIBCPZRmnwrl8Iu5mIOVfi6tywJza4KWM8Uq4IT6xZ
 c3/h/udsBV4fjkY8Bl6f0cgKf2kEmBqHHoblSvzTo6fzcxGgtq8tneCLSZqTr47sYQJRLplDEJy
 X9pQwUWI=
X-Gm-Gg: AYBFou1ZeGI+yTkOTDnYL5EEMNbfCIpWDdhIesTrHqwMTk5kVkNje4UyPrRCSZLjdtW
 1HMzaQfTay3Retrb8ina2u5e1JIhdZJFyfrdyHbjiXMcsOv2doA974rQk5cBD2/2bkaKHWjd4E7
 nbEljptYhSHlz/mOhSy/9YRfNBB5iSstg9Y6iu//ijmxEQ5fSiVJ5rGcFU/mZL0TX57GAB82BiX
 X+vp6sXPDvNiLmOfuhg0gbJJv7obLjvyZs3ov4GXQ/yNDPFd7GF1s/clK5qfyoaaZIQnsXq+vUl
 +jT+/g2OmHAm8Lnmnr/sMzEZ2x3FoHsWWNIpCEAsSXNLzAV8HNJTIavkDBZYmIC4uFi/ng4NVVC
 g9vfiYdHW+/zr3WZQIcaDej571/UJPpz4T8oQkRMxirK6bYMylWeuuTJs91rYsoCrvuMGsQK531
 a2Ex3MzB6t2/+bu3oFUNRO9t3W5Q2wjexA3DlrPh3LLpZLL+0ZrCofKVXGu2cqAiXc/234Xmht1
 c74qZzExVdWkdWepIRv+nGVPqo7YWIth72x8HlpfOrtbAooAyeToMyjZVpfbQ==
X-Received: by 2002:a05:690c:dc9:b0:873:5ddf:d865 with SMTP id
 00721157ae682-88d22217b62mr12719537b3.48.1789414043910; 
 Mon, 14 Sep 2026 12:27:23 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-884b55c2744sm38054827b3.41.2026.09.14.12.27.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:27:23 -0700 (PDT)
Message-ID: <af473beb-b46f-4d29-950e-c0f2d3f94dd3@linaro.org>
Date: Mon, 14 Sep 2026 09:27:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/14] docs: expand security docs with info about
 security status
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-14-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1133.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> The description of virtualization vs non-virtualization use
> cases is a crude approximation of the security characteristics
> of QEMU devices.
> 
> Document how QEMU can be probed to obtain information on the
> security status of type classes, and how policies can be set
> to inform or control their usage.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   docs/system/security.rst | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

