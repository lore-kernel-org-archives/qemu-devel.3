Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B734FDEE28
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 01:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG5WR-0000VR-FZ; Thu, 23 Apr 2026 21:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG5WP-0000V4-PS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:39:57 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG5WO-0004Oz-9u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:39:57 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8ee62a19730so341222985a.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776994795; x=1777599595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DZC/Y1inO7f5oLYBu7wFyyybz8bXYtU4r4ccAgRFD7w=;
 b=fsScxD2e2uaHFSivcX+b9V2iwERVilm6c9QHy+45bucw7FMu9gsCJVK4L9e8HLBui/
 AcQGLzQLh4OO+7se+jzYKTSupaVlD33e2H+6X9dLCmJnygG0ScJWHnqo+hIC7QAt1xJn
 8c72AJQ5yZ/cmi2uN7Q/5lLc80jdZOcTCkJNPWZswHBkWtfFh1iGF9r/hQSmMgWqBdeS
 KvSQB2TkIUuMiP+L6Fq1WE/C2Avmesw9zhVQ/WEOrNDGM3FbsyHBXWQt8EE8mf7kBEnf
 orDWEIBnqwXVAuhsfZVJPgrn6G4ur9IcnRqdSqVoQsWw9IXi9wvA4NrUh4v0j4GjYnd7
 0uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776994795; x=1777599595;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZC/Y1inO7f5oLYBu7wFyyybz8bXYtU4r4ccAgRFD7w=;
 b=rbvEu7gsA34tSaOIDcQH0hbhVV6KpC2p1GK/X1+5UF7OqsqBEW7Ox5i5NwIqYoIRoW
 nLAJ1IwVMXl7CDVaRNRgWBIDrHqxsCDEWGYw1soHLE5KE4RW0j0hMqARBNN4X65FD2Mb
 JLQL1pm7G4jb24IMAzqLKkomEmS+jC+JhcTwQwC0DthlCTr1kvTuOQbRpRzQPFMuhS9K
 Cndz+zKdg8rXMPXI6X8HFzDYxRKj4Su7Jozoiq5yNdA0Sda3Ts3PWh5N927iWAn44Ia7
 C9ZZjfJYYoVYllCz69Zg7UHkuLyMAOAcJFYwgMgqTQjOjxGqIsTIabHBeQGOUpaUw8Tr
 5d/A==
X-Gm-Message-State: AOJu0YxYIxjYWkjsOboNZTqtNsWWE4hjXc8h396FRCSMaYmlxvRYpmng
 o4r6ZA0LZTZj/GymP1ZcWH82Ea4mY0BhYogbBXlqSBSbU5DkABIgrPlZBc+/hwdW5j3zlUeuuac
 oHgK4UPw=
X-Gm-Gg: AeBDieu6cAXRJBm6IrXsEMbn8G//vjz9g6hEeNMUn4utGwa6yUJEjfFkW674lh2ChDP
 BKhiKkpxkEZXTfk43NWNmggxm3t3qEBMmtnN3SZMhQJccX5kps6KVBl/44KEELtngeCiarIjigL
 ub8gmv5V+5SIjsXCy8ZkIXTzqs3B6DPPl1rzy8MTziqTwWaH1NR37kO6vMtftwJ+IqXinzmy/tM
 NYqodwl4wJYmmMFKcKERVjUwdf90G0oYwe1hET7dQV4hjUToFfAkP5mm3TrC6J+/YyeqnmbZO5n
 m47i51L5faOZV2tdVMTiqidPRBV5DbSmyx8BP00VLyzgthh4zZjlOBmfYVR9u0YnWnSEGxgmNtD
 dtF1LilD/sCHT2ihfu2WPMap7Nw+ePHShZbHROsXSdsFhCLekgTX6CqL0X5L3HbUpuSwjDheVwq
 Itjr7HBsjsuRwQNSBOWL19h3SNwmgNR3iHF2y+qp7n4u1CL45hPX1JLJ+Y3TvsfAPaxNxodQM=
X-Received: by 2002:a05:620a:7010:b0:8f0:5e11:d1d4 with SMTP id
 af79cd13be357-8f05e11d3c5mr1141062385a.9.1776994794738; 
 Thu, 23 Apr 2026 18:39:54 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.190.12])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe90afsm2066657985a.3.2026.04.23.18.39.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 18:39:54 -0700 (PDT)
Message-ID: <840431cb-70f5-4e26-9fd6-fe78e3514079@linaro.org>
Date: Fri, 24 Apr 2026 11:39:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tests/tcg: convert aarch64 asid2 test to use sysreg
 helpers
To: qemu-devel@nongnu.org
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
 <20260417164328.1009132-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417164328.1009132-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x730.google.com
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

On 4/18/26 02:43, Alex Bennée wrote:
> While we are at it we can reduce the number of temporary variables
> needed and fix a format string error.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/tcg/aarch64/system/asid2.c | 35 ++++++++++++++------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

