Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B89CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElOG-0008Qr-6F; Fri, 31 Oct 2025 05:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElO7-0008PV-TA
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:25:41 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElNx-00031f-Fr
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:25:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63c556b4e0cso4447802a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761902722; x=1762507522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6eCBtZUZtppW4hCPQeJRZGO4QJhLpI9/EYV0J+evNOg=;
 b=dGFkfNDQUDVfsgJ2WjFBCniXL4pWj7bE4ItTnrG1khOPhBhZB7yXRLaFyCMvti/sz8
 MTWZGth7wf65VuA3ajh1gCf/bI9AP8bhrg+mldosrrH9DuAz/YuWjRjitCN8XfE1O4KY
 ONeHv2a3fyqrP3PNUKTl8pfi2grVi3R5P86QCz3jP4pref0vfyYpBLBQbWabFhTHTXip
 fVupQgk01QKvLPNHX3kzQ4KaskzZcFVx9d/fUncVjQrYCezfz1YNsqiidLQ1MSQ5OYOF
 x6lm5Voonocp40z8UANdCQBExYMnTMnm6/vDZegB8C6wDf46zTzOUCF4xo0+w19qWNzJ
 rZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902722; x=1762507522;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6eCBtZUZtppW4hCPQeJRZGO4QJhLpI9/EYV0J+evNOg=;
 b=ntcXiQWNjwjOrllNvnbuenYC6kx4dPSZEmUWo/7YCIogwB5jujemfz2ouzH43iV8V2
 7IsymeFOM62nUOhQXMQrz+1eON/GSmRLyQXp2rfYfw5nbDofK7tDl2CwwC7xuAJC0+cP
 hxkqPbnSzt1qE6eJL6/y6m8O87YbGP3F0z1Yf7VZ10rd7HZRhQ38B41c2EUnx6JeWOYr
 RL+l+HdpP3yADtOzcIpxzkJmMPjBK30D4kqDROCPt6DTDIoFioTy0TNWfgI3UOYtH2Vv
 vAQEv4CPODUl0YgdBC4L7WjfEWHY/JzXDQ87aORDUd3CSmyk5O9Bfgvq8UBUDVIgXr8n
 V4wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6PsBXGYMSpYX8OIiyrAhsVXXh0zKvx4Dg7n9gP2b/9HU6i5BG/0BLvE74SWBjDIlh0sGfA52vRbkU@nongnu.org
X-Gm-Message-State: AOJu0YwyRoSpdj8sqEPa3vwSNsN7SjrS37M61IyuHnjXHeUz+vJX+Zy7
 Lw6HQ7VrOkLu1cHczF6drKSk6Sg0lyQQIH8U0oD9L2mXSpIGpMXfNWK7UU2BhfHg+IA=
X-Gm-Gg: ASbGncvRiy6opqlT+dLeowjFFwGKiiPpBNacl7zfQLNzUdTwu0q5WeubetbV5RY4FXp
 6n0LLbqhbHncyvFfRklLOJx/GiHn+1ssH19W1mrxeAGIh6CVnSZEvxBTnZRc2OC67tgICMBvHCA
 TdK22Fej7JwzjR0LWTrtp6JdJYT2Ff0GRL2AiRDLtH4yJjj2BsslyqqMynvs/aCcWpCYnUk1v9G
 pm+U5REnsadcA4J1N1zNNaau7vSX6ZDHzAczjrn8AinWlEmiYkdWNOFdBZ58GOVYL0k4Wmgu2pX
 98z0V2hmN+xCPBu2AHo09plf/cqKG/PqipLBAFp+mImXo+k00yETiTjkQDLxiQMQAPYlBWf7MN8
 RwolGkMLSHvLdiGjxoUYTd0L1coYTO6aLtvsHrVDM0nLHUSk11SvhFcX+ZTfifoPCou5YaDXZta
 Q6ymlPzCXMzy2zsSmsnvna54kFrg6ITzxvFrjla/j+hdgUKxnXMoChSDkgF++OYA==
X-Google-Smtp-Source: AGHT+IHhg6ZhSCttbk7Cmyi1HDo+Q9dJFbVQ9RvoVuRrEokZov+FdpXKuYiTEwVXSNqDD1bDbCcU8Q==
X-Received: by 2002:a05:6402:3596:b0:63c:3c63:75ed with SMTP id
 4fb4d7f45d1cf-640770bd087mr2159514a12.22.1761902722465; 
 Fri, 31 Oct 2025 02:25:22 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b34a728sm1156397a12.2.2025.10.31.02.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:25:22 -0700 (PDT)
Message-ID: <aa7a2bde-e18c-4f63-801e-15cd32507814@linaro.org>
Date: Fri, 31 Oct 2025 10:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 0/3] Microblaze signed division overflows
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@amd.com
References: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x533.google.com
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

On 10/29/25 15:17, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias"<edgar.iglesias@amd.com>
> 
> The following changes since commit bc831f37398b51dfe65d99a67bcff9352f84a9d2:
> 
>    Merge tag 'hw-misc-20251028' ofhttps://github.com/philmd/qemu into staging (2025-10-28 11:48:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xilinx-queue-2025-10-29.for-upstream
> 
> for you to fetch changes up to cfc1d54251d3b4c4cf21c4fa278c8aea2fe25a99:
> 
>    target/microblaze: Handle signed division overflows (2025-10-29 13:37:44 +0100)
> 
> ----------------------------------------------------------------
> Xilinx queue

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

