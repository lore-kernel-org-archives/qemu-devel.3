Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB4CCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5Xb-00019V-SK; Tue, 23 Jun 2026 14:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5XU-00018Z-Ob
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:08:01 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5XR-0005ME-QP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:08:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36bdda53d99so150172a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782238075; x=1782842875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KABiW3AIPfAzJry5OBjRYC0nW58ZNMNdNHzQAmFpCoI=;
 b=sK8JKlBJI7bRztPEnteQkEBzTmNcCmqrRVw0dJLly7EDymlh8PAJQLlFSvXC9u1ntn
 F7nmGqpUMi1s+QOmPzE8poZkV/rvBnEbu7AKVCKawWDqCUecloGY0hwsWaheqkRH7Lwf
 3Taaodh+eNRA+U5Jj8tP2tJk1CL+0JWik9r/BSVZM+vjGGHGhX9XPyNZg3XjteYhrx8F
 0RjOM+jIjCxbiEAXMMJ9y5xTXpulcQp6aeJAB2qUfKgbW1AwJlFqzix4NxCcE7V88jgY
 3vq6muzjoXRtBHk8ehkSpwHoTjxQeArNo8QLeq4wyma+BPRLk7NQ/TjI21zs0AbaZskR
 ITDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782238075; x=1782842875;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KABiW3AIPfAzJry5OBjRYC0nW58ZNMNdNHzQAmFpCoI=;
 b=crjs1uo6dXMK8G7+R1/92lR6H+LN3GSUj24DHEJm+nTuPwTVrglfBN6vmcDt5UHsRg
 o4zKWUtV0F8ksBZIqCsPuM9UbMFhGh//g1Xzlw7om7Ig8IKKho5NF7Mh/dIuC4dgvgAY
 TqwSn7G4TguMcGSca0tIR9XBY075b0tWIIRAnSSoTGOpMkYHiyEyHOK5Xx0CGZ3oG9uI
 iBq7lqF66oC3HKKCNk/ojizUgfoRTAmBOOHVYzJ8CUb67Xud0tuB1u9Qu0yJDLEwpBYr
 5Fi60yL8QyaGLgmjzthR9gEismQ3Roe4Ld5ZFyyyJ3HUS2U1mnWzUlondJ/WwVnVEag2
 bH+w==
X-Gm-Message-State: AOJu0YxE6ckEZ4+iiyU8wrkOGpePae4OHUYG64e/VUY5uDPpZs8QPrIR
 K9ZvQmAkKWMLaL3/12QR5Q/+hYIk2hDnZN6NMofmry4V9pvTvRQPQE59QZBBoF9zDaEdy9AUCYh
 ihrYR
X-Gm-Gg: AfdE7clOGOE4UkWMbdJgqw0s6pKwiu/N4Ka6WU6hV5FJ0hPaKF5NLGuzgbeLTupGRZj
 3zSDa9bVuSe8xrLt1RE5q5AbnX1HniryDyXMchi/rWUwCireeknqSgpTKGO7Thzr2NSfPt7PZcV
 SiGdqZfZy7itpWkImvgrp9n5p9nQwLdgdHXKSKi1CjgWPYXkC/ZX87g8mA7uJb4OCvd2D0qGzkI
 Uzooqpj4JfHAU/4PjvMNjXmk+T6zGFdAW/LE5yHnF0bkRR4kkCtJiPaeU+JEQet8a2BVI7CsMMg
 T4w7KKfWPc6IZqWk5JnEyklfkATx5j4gqcjwntuHvkRSb/b5FnX0pxbHjSUnZJs1Ci8OhqZ8Gxr
 WiLdksW/yOPEBfFfpRmw6Ywper3qxXgBFqWiwBZ5otx4u3WhuwBTMRFemmwlmuyHKdcyYe6zz7X
 1XzTzNdvEMFNxx98zBG4kvcOEg9GqtrSdQfm/VA0HES6WCjNtJhhIW88gNJA==
X-Received: by 2002:a17:90b:2687:b0:36a:d6dd:9fee with SMTP id
 98e67ed59e1d1-37d4e438541mr13925899a91.12.1782238075304; 
 Tue, 23 Jun 2026 11:07:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37de3ba0fb8sm33446a91.16.2026.06.23.11.07.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:07:54 -0700 (PDT)
Message-ID: <9264eb7c-a9af-4bd1-8f72-869dbc732a62@linaro.org>
Date: Tue, 23 Jun 2026 11:07:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/40] bsd-user: Remove accidentally duplicated
 prototypes.
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-4-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-4-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> Now sure how we mismerged these, but we have two sets of
> prototypes. Remove one.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>

Surely related to patch 1 rebase error?


r~


