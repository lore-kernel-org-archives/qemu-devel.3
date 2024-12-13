Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021CEE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 21:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMCuu-0008PL-Ii; Fri, 13 Dec 2024 16:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMCur-0008Lh-Tl
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 16:09:41 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMCup-00059Y-Nh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 16:09:41 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6fc5bf609so81111885a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 13:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734124178; x=1734728978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JxA+gOKy7yEDPSnuOaHG/wTK1r74YhgKoXxHIa95ICQ=;
 b=kuldTCzvTrwGDDoGUPaNsFXnBoI87T3WtJs135gF+cTZ29XeoDe0mnTP7/Yb/e6PUZ
 10MSEWYJtJAKeclbvpJtcF2wE9eFPVq0aWj32u7/wCJlMLnA3mD8IOgW6zObqbuZDlRa
 FU0xmewY7UqGfPHhZgY0qTShoQKHXwwbEV4fzZvUn44Ua+p9qkCV+t+R7kATkUbOUbGb
 l6Zzk5DxK+mVZ7K+o3CXT8vWlGYEHf+JKJuUS7Cw9t3WIwyxUslN9tAczuecg/vnhqsN
 FcIAVY4TSnKwUOfkAZL61ns47rJ0LOqaKk75CWgoeXkubY6bFiIJ3tD7D1e9z6u+VUUt
 U/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734124178; x=1734728978;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JxA+gOKy7yEDPSnuOaHG/wTK1r74YhgKoXxHIa95ICQ=;
 b=TTmLuXsgOyQS0IRidqIbpvAu398O6aCQQqviQGd59BZ9hGIjpJBsifAiSMn3/gF7eu
 WimnTNidGPYlTwguFwDLk8KQQyieYw2gUXc8bmgQAYFoUBvFJ41gY8e7aZGB0+of7h++
 I53RQ7S9JHimEH/LXQVmoU8r8bNgoXvJtXYc2hn+sJENGitJ1bcsJ0sQ1jc+dtdhbkzG
 GnJtknpt3+znS4m5B0Isl3twJ4CMtOmFHG3LQ5yd9IMK3Bj873p8etFeS/AbDrET7tiZ
 7NIIC8UkJnfaS9puqXUwtf1ZJsSdepnnFGcX1dIY87BfRE/0TO5Zucv0UxnzORl+13Vx
 qEAQ==
X-Gm-Message-State: AOJu0YwDA8ca8e+Ly9zhZLbxfz/xOFLnv3KqxirpdhgAfF6xjZ9zPIop
 HkFIo/R/ZKow1vjrXayGuxBLsAKYlU1XeqPhnFK3ahq2SGFEQTMOJjhS5vRvkxzr5r9lLB9MjVT
 93vg9v9gF
X-Gm-Gg: ASbGnctVN8n1ngwIckQyMqr6pI7GoBbk4futmm3RcljsqpsyQeh0SYC644I7+DvcDD4
 Siuo/IsJWy/Hog8NhEtmtKLEbGI8yQsVLYORbUB75t6DutQqP7zolQ0DtN4eMgDh4W7xrqhofq6
 vg+DWvN7vk/6kW0aHwhUkghT52qQUlzxTAhrAM3Ve/mT+TJwA4X/cYz3qBwJDSJ7YVx+QPj7S5V
 xZuajpVTg06bLzx2AfiueGE9xcndjkivjIY+/IlAFObGwp7BJixYa9pijaFAMqtnwLIlL5RImeZ
 4Q==
X-Google-Smtp-Source: AGHT+IEX0D03E8h4A6NSGNPoLH9B1S6DBdXNdPg0wIkHiQieauFMw2INTSqnfjRDnSVTbjYLNjVEfw==
X-Received: by 2002:a05:620a:a001:b0:7b6:d252:b4db with SMTP id
 af79cd13be357-7b6fbf3a73fmr651366085a.44.1734124177801; 
 Fri, 13 Dec 2024 13:09:37 -0800 (PST)
Received: from [192.168.242.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047ee680sm14969585a.58.2024.12.13.13.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 13:09:37 -0800 (PST)
Message-ID: <fad62484-3e95-4899-a887-90d6d3fa3181@linaro.org>
Date: Fri, 13 Dec 2024 15:09:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/qdev-properties: Shrink struct Property by 8
 bytes
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241213210629.2525655-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20241213210629.2525655-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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

On 12/13/24 15:06, Richard Henderson wrote:
> Before, via pahole:

Bah.  s/by 8 bytes// in subject; moved to the summary at the end.

> Afterward there are no holes in either structure.
> For arm32, size 48, padding 2, saved 8 bytes.
> For arm64, size 72, padding 6, saved 16 bytes.

Also meant to say, there are 1700+ Property structures in qemu-system-aarch64, so this 
saves about 28k.


r~

