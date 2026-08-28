Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C36CC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x04pf-0007Nc-Qn; Fri, 28 Aug 2026 18:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04pd-0007NG-VR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:13:53 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04pc-0008GV-Fx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:13:53 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc1c8d4a959so1207698a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787955231; x=1788560031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6H997e5W3ZLzT+b54C4PoYFCR8oxh9+jGcti+f3yyaM=;
 b=QelgwTevZ8Ch8a3HNkXKp6C/fSCD9xg0X+hY/I7y7unuB02FiG4kMyBtaNk5KPv2hb
 lb9tOfNy+9SDbky9MVyDwcM1/MzWWYi0Sy4ZxAqlDSZw+MvCJCJ0ZMXlezLm7PcMebXg
 5MjwJxHXRaD5DsOumNVvq3ppMOfzH1BaI/ShqymzZvdP78/uNB30927TeBRdPzc4tLWd
 HUrR9iRoE4ISkJ4quUS31eWt3osaKuTQJ0OMmPpt5Xq63FAuZu7FgLcjKCFge7UIudSM
 ledFphce0XHMj+p7PM2xB4mdqJWNw6TBxP4QKWs9cJXcTmCQAR6DkJ3ErpTtrJ8GWOqZ
 4gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787955231; x=1788560031;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6H997e5W3ZLzT+b54C4PoYFCR8oxh9+jGcti+f3yyaM=;
 b=RzpiFlXTf5+HwjjXBZv5VvBIZKcE8Lyz2mThMUF8pYq5lnUq6gxCArLRMS84xWCXCA
 Nb2v21pTajoXrYRBQSHjQEXUdvdhOUhCsKkKImJmcaHnb+sRZ7Z4N33PWYc+E87JWi+l
 q++2pQxx5YbfhnV+msP/A0fJMhIiF5GgXp95Dz6diGuZZxsA0nqsRSvXhmLKF393Sic4
 CTDgpUN32ydX5nt0wIxXMQTlhbd68hhYlmXToy1KhAG4abZ4hG8vop+nxEjU2RVqqUqO
 ua8y264My74CJgvDs0jIaYhxkoumlPOYGLTRrGHG1EyNEeVwMJCCH+eQgsg78FhdSEM/
 5n+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXzEwo+5dJwsy2Id0Ep6/1czGJcYo0EQr4q33GZo5E1qAytclcINtmGlYN4KaGbkAkNPWuyllnknZI@nongnu.org
X-Gm-Message-State: AFuF++kc53QzpZ8M8vpWP0DuFYXv/043AZSrnstzPz1QgV/yCjUngqht
 z/Wp9qi5ZCU34Wtf/1ttF4Pq6l5uY0QUQlRlsom5gYJh+0DuG9ECx2M4yo2YdOQ7BPc=
X-Gm-Gg: AYBFou3RizQzzPbo/nXXbSsIiW2kZ9RI5rstg4X+JCLWYr7ywVphT+6iNTrX7/mXcp8
 fY3dFnQ1m/GQc+snmSJZ41v0LMYgekTt+oVMKLvMbdB4bElfE0x4dhZer78+R2+5KN3z7qklZhk
 vVMvY98i/c9h8tfrUKN1B/Kk9inE5usKWhSh25lV/XNw1wb0ElaVzQOSByrdoJnF+uPuqbcoE4n
 P6oVSB5G5k4CmdPsuEfoqyW9kOUVcmW/F0oOVxaUjDZ3/w900ty7tyfOdjWfzFvE5jXJm/8+MiX
 H+NlAavcJn2BBwKOTL8Uugn6RCzOoyW/Bi0iqOp6ZWOCjG5KDhNeozWltqtSVafzRYv8Zup0xDi
 IwGoMAhhG/3XdvE08t8+cqtU7134StpkMN8aGs6gMs3ig1T3YiBXmwerOyoe2pVB62IDd9bG6TE
 L8kpUbjgwgCK0vLcRsgR7YO6Vor6yq8MuWvxZtIOWJJjc8kz0/mkSasdDFMprhcyDWEelKgvquQ
 e85ZdR/9e1Gh2PQ1/sdqbc4OkArhm8=
X-Received: by 2002:a17:90b:5626:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-3989bd135fcmr4419738a91.23.1787955230821; 
 Fri, 28 Aug 2026 15:13:50 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b1ab4e12sm8720272a91.16.2026.08.28.15.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 15:13:50 -0700 (PDT)
Message-ID: <8de947bd-3dcf-4893-aab4-149ebad288a3@linaro.org>
Date: Fri, 28 Aug 2026 15:13:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/40] bsd-user: Upstream most of the remaining system
 calls
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stacey Son <sson@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
 <CANCZdfo9q2uO-WiJwT-=GSr1AwY_q0hMOLgtrO3ht5SriHc29A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CANCZdfo9q2uO-WiJwT-=GSr1AwY_q0hMOLgtrO3ht5SriHc29A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/26/26 15:18, Warner Losh wrote:
> First off, I'd like to express my appreciations for the reviews so far 
> on this this series. Thank you!
> 
> I have a process question. All the hunks in this series have a 'Acked- 
> by' or 'Reviewed-by' but many lack the former. The 'Acked-by' was made 
> by a linux-user maintainer, for which I'm thankful. I've not seen that 
> situation in the past, however. Can I submit a pull request for these 
> now?

Yes, please do.


r~

