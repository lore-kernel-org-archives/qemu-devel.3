Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F918CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 07:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uscUt-0002T9-Mu; Sun, 31 Aug 2025 03:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uscUr-0002Sd-Tm
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 03:29:05 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uscUp-0000Qg-VN
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 03:29:05 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b4c1fc383eeso2315026a12.1
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756625342; x=1757230142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aQzHNmcKKiyZxNwvg08LxCL2jWpYT5wDzfHZVsQnec4=;
 b=rVako83aSlyb7CTxFScbzldjGpi/ySvq6D1DzJBAHr5upWH8KdHPlIT3g0Fl/BjyHL
 aN65XMUYl4fiExpCk0tx0zyXsw5A/wOsAQ8KNI6LUej8fMd6ytZrb0wiMWBD02NJfa7y
 Sb8dFQyL6/7LztIvjxVy/1RKZAGl+ho5Iz32xCObXE2QbPlJ386FYfIKOD+AtywJQP7T
 qDSVS3lo5dZgLbORuNN1esvqE/IC3xS2+0zR6Eo/Q1Y23FBnZglfwxTPLJtM4Ang8SI8
 jeeAqs2ziqkNw7dfoLGUZMjXhBarzJugPoN8c6hA7AENGG4OFUEr0oB/Jan1WAZ4dUei
 rfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756625342; x=1757230142;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQzHNmcKKiyZxNwvg08LxCL2jWpYT5wDzfHZVsQnec4=;
 b=JK6MuWfxTJ0EPUu+yi6pdtBRnUGDtFMiTqOR+Yp586aoExYGnY60cFQeykBqUL/n/E
 PrmTY7FaqNesXk94+MjeujqmW2vUtVw0L9tTOyS5SBIzis7l9hyNqYqEjWq9pBs26mp3
 gD6KgN5qp4S9VuWwI1jaqs1txEXMdEFZ1IA54Ni5oxXXY/8LD5sDlnu8dzH2r9HyHf7i
 pjFDrK7XjgGmQpSVKm9OuVekY7bLh22rW5arLuv/cWJNzpedz79DLx8AOuhV0yrLv5Me
 Q3ZITppIQoGtZi2d3zrB5hzWbQv4Ec/wENbdlfXrMz+GS+K+l0zoLjCxZaEVVZSlDDA+
 x9bA==
X-Gm-Message-State: AOJu0Yza02eYmQmtrnzNK4OFWpnnj37VJYrDMCZAs1+RoehTBNGRGZGT
 dcczzKJPD2CrhJNoKoeYBqzGCYcOJgU1XUk0YLKQBKt7/OXR/7PtkMC3P9FKV2ffntQ0PMhqS5B
 lDGNaoN4=
X-Gm-Gg: ASbGncuosbnD5exr/oFsPEiThhG4t1lx5cfSJNLFyqeRWSq+tzeC1Rd0jwi7WJHFJoF
 FShaq4uBcPZzzEJvPj+lrif95fmyryhDTuxPMcYEdGO11YbvrgmMc5T1/ZScEJgzPptWwnyynix
 3rLomCzItHORfNMYtzBnMLwmPELCF86joJp2mpsLYT3yDx3dBWIqyf+se24o4RAWpEnjbFR8qg4
 P3wU9K6rXUZJsEGdQHrM2djvGTrhzbKKtj7DLoPFKqUfkU2lT+pv7MEI11O0glO39ABh7mHMZyE
 5R+lCiNajB1yMA5Ivgp+wA7JVVwFO65LolBprDNTGb76hZXui11ToILRe9S1/gu8MJSgyrUKTQW
 QJg06/DIBMzCDSfWmYDmfqJcXDgw6EpVzgUSE5ppu6GtReB16ecbUfMz4i979rpfINz4WKkJ3pf
 RxrgBO
X-Google-Smtp-Source: AGHT+IHB6F+nbOIyBfv6PuPjfBxkDUVS0aKin42DvXYGxgrTogLK/FgPk9FBEEuNmV+w0OzdrEPO1A==
X-Received: by 2002:a17:902:d2cb:b0:246:eb4d:80c8 with SMTP id
 d9443c01a7336-24944aa2cbamr54121065ad.34.1756625341943; 
 Sun, 31 Aug 2025 00:29:01 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249066dfa71sm70441445ad.140.2025.08.31.00.29.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 00:29:01 -0700 (PDT)
Message-ID: <26fc8179-2c83-4483-96f3-57a34cfdbfcb@linaro.org>
Date: Sun, 31 Aug 2025 17:28:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] i386, accel, memory patches for 2025-08-29
To: qemu-devel@nongnu.org
References: <20250829125935.1526984-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 8/29/25 22:59, Paolo Bonzini wrote:
> The following changes since commit 59f504bb43366594e97cf496c9a9ccf59be00b73:
> 
>    Merge tag 'pull-loongarch-20250828' ofhttps://github.com/gaosong715/qemu into staging (2025-08-29 07:44:50 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 83bd8e65bc70cef03a207df315004f8b1301dc53:
> 
>    tcg: move interrupt caching and single step masking closer to user (2025-08-29 12:48:14 +0200)
> 
> ----------------------------------------------------------------
> * hw/i386: split isapc from PCI boards
> * cpu-exec, accel: remove BQL usage for interrupt_request != 0
> * memory, hpet, pmtimer: introduce BQL-free PIO/MMIO


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

