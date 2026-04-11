Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D9DF3ED5C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgnj-00047c-0u; Sat, 11 Apr 2026 18:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgnc-00047H-RJ
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:27:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgnb-0004LW-CH
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:27:32 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4888375f735so30248505e9.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775946450; x=1776551250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T9Gi0ER9rMMnnH+MMWwe3IzPwjR8QlMbjBHS0hcOwNg=;
 b=OAvHhhrpDVmqCcs53unSC46TjavKeyXEINOnPgcrkk33hC65G5jwsFo8IZtyFKLL7e
 NbstKD5anIugPXE35BGOn6TwvsXp6G/L7gOaIkTizso+V/29euW295fUiWtHAw74Bgvx
 6WSnMiiqwn3b02lHcOqupQ2nr+kcZpsFoFPLV6hKeWgUSjFnXDKUu39IqVN8lm+LrfDj
 r0LdeFg0B2DeIRR4MV+ZSvtJ4Nq9lOcWQ6SY24Eld+lBZmYOmof0fjWAhXSD4fknuZDM
 /l7jdNVlu22nFVScZJ+/Xi/IeeB3sAWrmvID6WVbQEW9sRh/I0H9Gu/zAB2JHPxbPKaV
 LuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775946450; x=1776551250;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9Gi0ER9rMMnnH+MMWwe3IzPwjR8QlMbjBHS0hcOwNg=;
 b=F35NFNooJ2ISLM9sb7bHE8KywE+nJFWFS5Hzew6VIX1DVcSXety4dk1WYtRyXV99U+
 MyZYn4HNepyCsjpoR2ZLX7XuMQcJIYt1v4WW5VkmEACyE6lByKxxUI/I2hjL7kIk7c1k
 0eEmrBufd+T1yiB587saVmVLavdDuTiUjtZX5qV0FgK1o04B0k8GQPp49eFr6Wy490mh
 C6xjbKR+ntiOuGfj1sMOS5aoPq5sWj2SDbT8CUxIErCX6okGOCUf//e9wqSA2EPfUSLx
 gksiugK5kvrag+B4BH+UvJ67tcbMXfJqr8AGCBBNWQjl5MO2HlwrMR0GUKJ7scGlxJpG
 Tfeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXELGpp4wUfphpntRHbAeRCScmuTvDkKIPQoKwvAjHK+rN0nGvEsJiq1NLL9gXbw4R+f+FDH16ERHTU@nongnu.org
X-Gm-Message-State: AOJu0Yz2JVM2jQyl6A7v5TquoJtDXUjEx6QgnJoW9r7tKBtrFWtt+75S
 2bEuw5jUzvNol65SJ6KfX6g0si7/YI0iQNlMhhtfXwP04dZGVnzADzfra1Ysi30nPcJgYAQnHvu
 jN1vldyQ=
X-Gm-Gg: AeBDiesvgZ5jvll2OaVzjSnFFbjHwiDUBHe3b8JFEGQGfWAJwHShNz+vQPNOkd1biD+
 9tByHJG2FkNaYe5YDGoI9AdSW5sff8eNB2VvfMUcDi9XmkYUIfp33005KweuSXjku4DW0dq1rzu
 DtmI+Eltw6b9VxAQ1Waba70s/HF/WlgurREqjueEAXAL7HYO3mPwVBVgQYKUCQuUEfyx2nHTnmr
 NWgRUyfEvXiKTEtinSfNqBTLkFDuQo+/PojCdFS4/4HiNpsE0bR1ASQ6+G336zfPiwipTV4DRDh
 bnriI6XSHFFukMAZ+2OW9bGywbavVkgvefVfcCMkL8kJcZHW74XGffCL/27bbEzEHS4bNtQcHmk
 XSD5mNey1kxl849J3gYlXxBd4nDmVHsQauZ+okULQYYDjQMwBKLwhPuyIsfi1KqhIRC/7Nd8eXC
 /dYJQmP3Lq/9TmEbTwN4Tvac5Qkt1NP+i6fvcGFABnsUhXoPGp72VbeQEF2qP86hnYHg==
X-Received: by 2002:a05:600c:3b24:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-488d687a645mr105684965e9.26.1775946449740; 
 Sat, 11 Apr 2026 15:27:29 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f2b6sm192765735e9.2.2026.04.11.15.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:27:29 -0700 (PDT)
Message-ID: <9ed3632c-614e-440d-a188-5550a3d94996@linaro.org>
Date: Sun, 12 Apr 2026 00:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 45/67] ui/vnc: make vnc_disconnect_finish() private
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-45-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-45-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.h | 1 -
>   ui/vnc.c | 3 ++-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

