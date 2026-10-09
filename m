Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6890ACA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5UV-0005es-4a; Fri, 09 Oct 2026 03:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF5UR-0005ef-0Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:58:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF5UO-0002o3-2b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:58:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-487048857f6so3346743f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791532678; x=1792137478; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mM1C/nguFWvQsEt4iuBXhsxBtIKtHihXqP+anItvLjg=;
 b=Oh8Odw4eqvXtJAf0P9qKEMqrsqIQL/QpZ7U/78sGwwoSuqnUGaQpawGziN6f/NI5jF
 3X3hwQ8YF8Agk1wYG1qYI2JL6n12WtzPNZBE4s7ehLFwShcxqquRlSKPnd/79avInbIV
 ilSFyPtazsK19B+yfKLaURJy7YRNLiKLh1AEQ0Qme36STDXnLclp8//zgEAGub3G+i2H
 jY9VdCviVVjJn+FXYZ6qmka2bBP3iqElmwSwuvM02QKVy11sV1dEe3GteOhB3J3kCosp
 cKQZX//764XoWdLpFgmxs/tmWlSCBs4UxoPZDkQ2dU1YZt3fW4NkvCv8c70VPlOOTCCV
 F63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791532678; x=1792137478;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mM1C/nguFWvQsEt4iuBXhsxBtIKtHihXqP+anItvLjg=;
 b=AUPdXUg8keKX4RN7M99b9kfFbz+W9KmA7ILtwykjR9jWDcESxI7HQ7UP7f1GxS5uNu
 E8VvX3i8LFrgdQZlHOtiAh1TO863zfqrNNf6Ms2vR8/Fcn29WfElGSD3AXsf582YjFSu
 55hnP6CxUUXi0bLWvwuviQqtC7z4pVgVTRsVCidbEJEHGtdkTPOWb2YZJOrGdjafj8Zm
 ByYEG2hLV3r4JQwgwpVRpSls1uDZVkdPiLzX/nkqDpNTjGPA3yEk8s5AVQuxdZf6SZPJ
 9DJUCehVfNjZqr7JgFQJmPby9KjOMem5kPgO9msoKHt0ZoiOfqyN0A774JDXYQq4KliX
 RjUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4aA4OMWQpYESssePXtx4M7jliNxQR55CCX7nCxB+LMTckXQgexSNLr3QLI+IL/Q3Ke+Olb8S3mi2S@nongnu.org
X-Gm-Message-State: AFuF++krFD58eoC/tv0EIjCsrhZyyRqzmPDebtSpko3Mji/syTXUpdiE
 lVK85bthh7KAD/mXfn3Xth2rmmkDQED9Fr61MMyWDYcYmqyVMw1XDTcsMKkbq5MhRKa3eQwLhLd
 6YlvqqQs=
X-Gm-Gg: AYBFou3C2f0bHDSl7Ub7I7kxCFttssZO8g/UsmnOwO5FtCfs4IvdQrVA7pdQf5ZJnKN
 epMIyAJ0OQEuNJUKqYrGkDYPOgfgNiSzaIhgvD2vS1wl5F1tSJ/j02rm2Dn/KmIJVlfwbUAv4gK
 uhxQq6AKxTvjhaJvgc9sJFFhMCr3KuGS2za9yq5L6z3vzUqtTGJ3FSpyP121pn1a8KaPhBYvT94
 +os+g9T6rvFQVuz/C+EsOZ5SJRo/hk3c0bnxDM0Ws1Rnu0JXFhpS3Brb9jFt3zv4WDGb/ddzNhp
 RW8NiWK0btcES9a1aFyq3wf6AQ/CSyNEhSlVmuVU/G9yrDt6t1NOU2yIlIrxaNzVIE++be2Ur55
 MbSxvDZeHEIPnIG9L57Ll9o4N8G9T3S1Extbdo2T5uTMwVH++93sq82814hdRbbN//6JRYjg1tD
 PSIQ2RlKdqZlauE5b+QvAYvmjVJT63MykxPBeEk0N/1C+RANWTU04h6PON2OOJR4FWZbOtb9DQy
 xLBZ+SjhiHMISCEtTePXvCoJ3AuALPFxP6oRWwY3+/gSt9VoTyJdvki18IgJYkNszBvcu4Mjpu7
 BHJG0wmAMkXV
X-Received: by 2002:a05:600c:138a:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a18e4c85fdmr19173525e9.34.1791532678396; 
 Fri, 09 Oct 2026 00:57:58 -0700 (PDT)
Received: from [10.86.151.227]
 (ipservice-092-208-245-012.092.208.pools.vodafone-ip.de. [92.208.245.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bead84esm40334275e9.13.2026.10.09.00.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 00:57:57 -0700 (PDT)
Message-ID: <e85a988b-6454-44b1-94a8-d809fafc5cf2@linaro.org>
Date: Fri, 9 Oct 2026 09:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] TargetInfo fix 20261007
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 10/7/26 20:49, Pierrick Bouvier wrote:
> The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:
> 
>    Merge tag 'pbouvier/pr/plugins-20261005' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261007
> 
> for you to fetch changes up to 43e6a3898a30b7f751438c8d777bf2ffcd3b1766:
> 
>    tests/qtest: check query-target architecture (2026-10-07 18:48:11 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v2 0/3] target-info: expose full target variant (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261007184612.24073-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

