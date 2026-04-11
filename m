Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B74F3ED67
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgt3-0005fe-NB; Sat, 11 Apr 2026 18:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgt1-0005fH-G1
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:33:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgsz-0005D8-VN
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:33:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so33438435e9.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775946784; x=1776551584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3JOOWd+nXMoryIxrNpHmQG7cMh3rWDpQjH+olW1uPc=;
 b=HenFH6BsYKZQv3VG7Yoh+vp22ryr2KPHwIPzXPTka5cymIi0My+8sCQwFbGZyvLDPh
 iOdoLursMfQxXvLLMFyJ84ODhOGPCPK4ixMnh9MyOGlqO3PL9cjBq7Cv85BxXtb3E6LM
 Jc1Wihh82S6/echc2iR6dvLdYDx1CrNJ7+tCJmLBNtgx+E3GYAAphV+XkBawRQd6ymNo
 G+HW7IHa66s97NCUYpUK+W98HYaLBW5ZxRDOsHG3bmorLnnB/GMqNBLpXAOjuy6qNlVa
 zDcebz9QnHDV9u+RHtTjPxRAH9kLwfetId2vA6lsHcFVX6Rrbl4M860dEKcF+2qIhuzM
 p1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775946784; x=1776551584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3JOOWd+nXMoryIxrNpHmQG7cMh3rWDpQjH+olW1uPc=;
 b=CgwJ6K11MlvC9THwMdkBDwfTpApWdlqSro8rSO0ScCKFFE7xvnMP43XZqN8QcKC+of
 8NQ0zcu0OtmWTfB2zh6kQ+Lp2thI4frT0NHeL9g4vJyqmw6V7WQJYh7GxuG6G5c+TBmz
 ESPSkXzhhv4d0jM3e98S7Pq3Gj43ghb+p39TU5nBG1YEo2nUtV+RtcPud997Zclf0qYt
 WqKo9QwHoqK44+goHo3V+VanDJbvTPMTrIanWcBB/HFxjd3rMa8ZFzDdkhElSszZFI3b
 JVZdft1wk2ORTgT2+Vmc9VyYt8vamv9XctTB8d+ZnTrBxciid274HBYDBsD0cOmgn9py
 /9Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXljFfLqD/nPLdMxv6ME8YYyGfBQIfRnuriTQuIftFoT/362WJwAIXcMrWTeFxzR/D7uJXHH7wvhwmo@nongnu.org
X-Gm-Message-State: AOJu0YwWlqLRESSyTxTI1KeDdnMQUBAUP6Yd6cOzfo8LpZK55LDApFay
 ZmgaDg91NMEg4eAakHxBylF4k28uKtFVPLj+IHXRwqp8rLE9AdTu/9FVwFA7N0RuHoY=
X-Gm-Gg: AeBDievANfg2NNlgvi2VuM3dJlGA277upXedlsyFyyrVvrb2hveJQOC9e05EwQUU60Q
 XS5b2ibz+S8TU1Hfxneycd6j5vFTAuaUtuzSV4Xw+PBgG+aHMTZhkMcfsENDnRZR7oPonnjO6As
 ZwJqo95JMqubQ03B7Wbr/ux4oOf0M0yjbAf5QQYIvfUbchnOdFRoZ3E89PzLtWW41jmtJtnXbqZ
 XRmVbdZqgPtlpAfZaiueAO93nTidL549LbwUPsLob4HEax7h7Vs5HoNEs30fW0HgxTLUngrYt2H
 sJkAtJJp2pZDVwExmzIA8Ze3Xxi0Txl+fnI4NvoEi6YrEOKFxIWqB8sGLFuFT5S/906VgYL8s9z
 J+gN7ADKu6WfJxRGEmI9L1A1PMMM+AYJZrroR4pBt/xvZjviVfEMGtn77F611gH93KKK8PmomN6
 LRHTLj3Fv20SZ78mXwwL5WFjz0Inazw3td0eoVJo1rc2pPuVGA+p7ytHTfAPZ2xLX/NIVKQS2b0
 qrN
X-Received: by 2002:a05:600c:45cf:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488d67b8dddmr103288235e9.6.1775946783886; 
 Sat, 11 Apr 2026 15:33:03 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d58a414bsm176775275e9.4.2026.04.11.15.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:33:03 -0700 (PDT)
Message-ID: <4030263a-78ea-44e6-a041-16c1f460b13d@linaro.org>
Date: Sun, 12 Apr 2026 00:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 50/67] ui/vnc: report an error for duplicate display id
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-50-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-50-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/4/26 21:19, Marc-André Lureau wrote:
> Returning NULL without setting an error is odd.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index c26b581f3ef..6f9cc3f25a3 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3430,6 +3430,7 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
>       VncDisplay *vd;
>   
>       if (vnc_display_find(id) != NULL) {
> +        error_setg(errp, "Display '%s' already exists", id);

Ah. That should get squashed in patch #48 "merge vnc_display_init() and
vnc_display_open()" and answer my previous question there.

>           return NULL;
>       }
>       vd = g_malloc0(sizeof(*vd));
> 


