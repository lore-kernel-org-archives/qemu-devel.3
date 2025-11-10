Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A45CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIT1q-0005Nv-6D; Mon, 10 Nov 2025 09:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIT15-0004EC-94
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:37:18 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIT13-0005rx-4T
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:37:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so11476115e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762785427; x=1763390227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vfww2zpCxfkoHkDpl/yxHyyfKAa7jWUY21pB+N3M8NE=;
 b=RumfbDidGATeUSceBzGYUWwyPQl0fea0pCVNP05fbk/2P2oQF1x+mixjCI2oaxzPZ5
 g4hck7BDAcyNeosuC/6yoaaYw4rpTgtmvccpPvpjWz4Hjx00DgTJGMsRHT35DCCcZ/e6
 tPeTQ0WaW4cUR5g5uB+4NyHRpMQAqpCzf3f3JIqSM1yl/Lf3R9m52flTaP9mM5tJOFvk
 bBmGGKaiyRGFMbtDyu+S5kJxGGyQEIrn6fq1mS4SKcXeNVbcsPhEXvVc/og5VlbkAJlA
 pvQJmttkoMLloAM3+W57cOS1dimXCLHKj3mpwv+beIbxzlv5Ny4DqPrMTU2y5KgE/GXh
 1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762785427; x=1763390227;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vfww2zpCxfkoHkDpl/yxHyyfKAa7jWUY21pB+N3M8NE=;
 b=t/TCzd27zke7oi53p7ZcmLhNCb00fbjRHH4Ajgor5M7DcdXOn52/pVnFjx2r071sV6
 bXK8DUCMzX0eIVGqCCrNQ3IxNMpwWlXleYF2ExJoRucVU5XvZuokpTuHgL0pEDEaQCIf
 DdfKIp5XiMO8wM0h1UuF4HKp4Ug34hXkc4AKFVZP9THsQDwmzadUN7OTuWCc/mCQ2hEe
 kpamP4jxKAmBXSQs7H5SuCrhAOf8LLvMGqwAhAdetQEcyfUVAivOrc3iokJt//Uf0n1X
 yPhmkOVAQRIYLxbsygetqjuy/vPSGCjiBIVELq7JIkLLw5fA3xoArXjoq+e/s/07AP/2
 83UA==
X-Gm-Message-State: AOJu0YwDvQoOVHxHScKUYFUtbg2NEFWJgUv/iyILJkLzR1XnY085wTMY
 Lyuup+Ozmy4RC6w3IhgOTod7kRY2Tmju/JW5vTj+BA2OVZ0ZMYdH7aHCmn3xB6F1mUuUU/Uf62M
 aBT8tJgw=
X-Gm-Gg: ASbGncsYv+b891mpnY6UALS4sR9dHk+wopdhOqSqn/3LXTcqoylllvxDyVSrlrogb/a
 GQTGXZF0SQSlySBeqw4caUSSC+46cSrRCMRdqjDDiHhCUGee88DZDeCPYXlmNOQJaFOw4/UXUoo
 F/PN/LDw5J0Dtt26JZOrRSLtC6gWGJSq8geR0U3JU45yfSk5TrAYj6PdhMslUGyJKMpcZHmzvlL
 7njdgiZIMfN57kwZU+LZtNMkpLZSzbNSm1Z9rZ53lPtFUQ+gDoazUlwYkrtG7cs7aIs4AEDO7dz
 x9S3DuGanukjb2hKX9gT8UniKeVYAxyIYleSxC1LbVh1ZFBUYd4ehI4QZwO1PSuNLb8S2pOazzU
 JfUT45DWevoeJvm6Yczoedrj/cl7F7/87cql9A++MNQfvDFLDIAjlwgmA1weuj6/By6FPrK5Zy6
 qAmksgK1+GuepHA4NeNA==
X-Google-Smtp-Source: AGHT+IGP0iTi/AIaKUgBL6tcwjIuUbbKH7+M7lJZa6ZsQJKNHmQTQWY+smJWxLogRqaGK7DKuvus9g==
X-Received: by 2002:a05:600c:4e93:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-47773239bf6mr70057205e9.9.1762785427269; 
 Mon, 10 Nov 2025 06:37:07 -0800 (PST)
Received: from [192.168.50.95] ([206.204.154.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4777d9447eesm51301705e9.16.2025.11.10.06.37.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:37:06 -0800 (PST)
Message-ID: <8958cfcd-66ff-4fb2-a33d-070ed09629eb@linaro.org>
Date: Mon, 10 Nov 2025 15:37:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/14] vhost-user: fix shared object lookup handler logic
To: qemu-devel@nongnu.org
References: <cover.1762698873.git.mst@redhat.com>
 <fde5930cc37175cfcd0f03a089e26f4458a52311.1762698873.git.mst@redhat.com>
 <CADSE00+FLWVdh1CGmy6i4hLdJOKGG6-4JZySXL=wFOyyTnnFpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CADSE00+FLWVdh1CGmy6i4hLdJOKGG6-4JZySXL=wFOyyTnnFpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/10/25 10:23, Albert Esteve wrote:
> On Sun, Nov 9, 2025 at 3:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> From: Albert Esteve <aesteve@redhat.com>
>>
>> Refactor backend_read() function and add a reply_ack variable
>> to have the option for handlers to force tweak whether they should
>> send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
>> flag.
>>
>> This fixes an issue with
>> vhost_user_backend_handle_shared_object_lookup() logic, as the
>> error path was not closing the backend channel correctly. So,
>> we can remove the reply call from within the handler, make
>> sure it returns early on errors as other handlers do and
>> set the reply_ack variable on backend_read() to true to ensure
>> that it will send a response, thus keeping the original intent.
> 
> Hey Michal,
> 
> This patch was
> Based-on: <20251016143827.1850397-1-aesteve@redhat.com>
> … for main.
> 
> As this was the first time I did this based-on thingy, I am just
> making sure that the other patch was not missed.
> If this PULL is only targeting stable, then it's ok as is.

This PR is targeting master, and "vhost-user: Add SHMEM_MAP/UNMAP requests" is not present.

Albert, thanks for noticing.
Michael, I'll hold off on applying this PR for the moment.


r~

