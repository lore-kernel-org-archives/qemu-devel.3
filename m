Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0162D29FB2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRF8u-0002rq-AW; Thu, 04 Dec 2025 14:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRF8s-0002rG-RK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:37:30 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRF8r-0002Y3-Cw
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:37:30 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c75178c05fso531509a34.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877047; x=1765481847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=11+OPeU7x3ra1TWRRBfUBh/gILgyypyIKloGqlf8Tho=;
 b=xrasUQ64ccHm9ka/dtFlJOjBizywRs2u5tKmpOYHfUuZPuxZuVTLo5jPFCohV8yZRL
 NoQGO9LmKkV9DFUrG/L15OqGSz1L8LW7wDkE7GiqGiftjmsFa9a+m6/nljGD4ooGJhLt
 V/P9n2OUP674tHgsgt9HEBB9TuiW3iimv+I4OJ+4HpP4vwE9TGvH3xDhp8Hio7jsWnWl
 z4UL0liRtW/6gHlqryPzcmZggJYW8gVOs2aWjHnUKt0WhuI3vLVCgERKkpB7BCo4FEF+
 er0oOVFsXUBzzcAW0fyszaxNKhsLiwu0b/AcVRg0DWO2ay3pNU9X9Pi2wMLzzeimIf8q
 yoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877047; x=1765481847;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11+OPeU7x3ra1TWRRBfUBh/gILgyypyIKloGqlf8Tho=;
 b=jN2dJU9ZQYG1ORURLom1ZuNNlL29AISYdfwGf9DL+Amy3WWBKv+ysHLtSusRRR/DiX
 ktuXwr3j9ZCS719MesO+4M41A7ElMxRv7dOZSUiRwurY6nc8S5+QfR8iMk7k+YSEGjPO
 kdvSX7FLnOqU39V3d8cGG8LA/utwZlYLf4Rvlir9875uWhbzLIYRYErIbqVlEFv5ChyS
 mK2mJzkDrtcqi4g209DMrOmby7U/q4PUFNHiznFt6Uug2c68uLDag+BifqCU4VrzWdPL
 eArqXc+5LNZd9tHOkYc6Bq2Q8SNKP0ssrDsxzMrqN7YFH7Mtf3TL8ezcebuQ4oJYKC2p
 hsuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjUZsCN23/6y+VbM1TxW0TGBZetgf8TBzjDwCH+rp8qkeCLTw3h9IW7cXtgemhy68nUl+AnbHWAofb@nongnu.org
X-Gm-Message-State: AOJu0Yy8msG3JRqbm1LkWQ01r5hXZ9eIEonRTyAFShbdL+uzxgQUlLAg
 oNsnqCleedHi/POY5xtp8GtLceC7jni6MD9dwG9o4utfj62cT2G8XTbF0jc5qn1PYM4=
X-Gm-Gg: ASbGncvJd4ubIN8vINtaoG4YS4a26InnWRGsWmzvPCwzehZnNm+hq5zeFwOplXP+ZzN
 m93DSgh3cXv9bz2GKDEKwFMTo9sew8bzrv4Ux63zLcImV9AD/3MchnPmKhBLZROKswNbUvDVITm
 JuoLlCQomDfWrWxiZH9LfW5ImcCaHs3MOZ0UEXmpyx8opkRENP1VJUur86vjrd/oe7JxNZ4efp1
 DDo5GMRoYALN5aA0Eu2pSkHGdPP5d2R5L7ySZ8ltZiWtgfHr45/J2EsyOUgo7+4i22jqAuFJXYG
 Q0q0Co7yvsD6JjrhYWj0g1kXQfsrf9oc8plkJHvcnRkrYKWy4RSRrzgzxkOZ+d0YbLe9EV3XuVv
 iauGaEWmfNAtIqawFxyt0fAADQ/PAe9Gvi1MRzybJMBI7bJuC9HGfgC7uuUKeVgXKJdKhhQoBV7
 huugRIAlwj9w9M5VxAGn2a8BZUaBrV31k/8Ygn2s9gyc1ccXdJfhA/KgKwMlHDwveu
X-Google-Smtp-Source: AGHT+IGesLDcMwu9dADZQLydkKd76tZezabfLml77nQMJFPCqhhLqGKwoAOoscJlsYAUVLlFVkYnaA==
X-Received: by 2002:a05:6830:26d5:b0:7c7:2df4:faa3 with SMTP id
 46e09a7af769-7c94db7caeemr3951881a34.33.1764877047531; 
 Thu, 04 Dec 2025 11:37:27 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm1980827a34.26.2025.12.04.11.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 11:37:27 -0800 (PST)
Message-ID: <f56846bd-7bd2-4537-a5f7-d4e3f8b3b49e@linaro.org>
Date: Thu, 4 Dec 2025 13:37:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20251203151249.2707207-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251203151249.2707207-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 12/3/25 09:12, Cédric Le Goater wrote:
> The following changes since commit 05f36f7c0512c40a8f929e8ba2ca3c825198f234:
> 
>    Update version for v10.2.0-rc2 release (2025-12-02 20:09:51 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20251203
> 
> for you to fetch changes up to 23c586abf2e12843894189c4742c8ea55c594cd5:
> 
>    vfio-user: recycle msg on failure (2025-12-03 15:07:47 +0100)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fix vfio-user issues reported by Coverity
> * Update vfio-user documentation


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

