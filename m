Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4072DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1SWf-00059e-Lh; Wed, 24 Sep 2025 12:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1SWb-00055n-Hy
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:39:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1SWL-0008WN-Vd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:39:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77f2e621ef8so64489b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758731942; x=1759336742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xib1yeeW4VxdYdCEaHe4ye8jhO22FyajqAxMF3SO7pg=;
 b=hyLwPjB79mN7u2zMlJPGzhjALoq6dSKaoF4zMxK94FAMnkFNuLK/z6udqgdRC4bikm
 bifL0enLvH0vMT4Hei1fG1WwQko1X1MFDgO0GZdRQJW07XftiYM1HqD4sLsn2zDt2tLN
 Ie1YIXVhfvhMV9Pdklw5NBvQWk0RUlh0OG/pZhpWhZMI+gCb7gkH+nOetYci1GmP2HT6
 vyIZZkCre3NCF5cJmQjMmI+oqIzwU5mJQn6ngnn6gGIOsPaVe3Xl12LsTbo+dunfhAoG
 xhe5sjsFZptcNCtjrtrEHx2pHcT4JlyxS69MbVSn3c61quUkc71YYTGsQzu+kxEq6E4B
 P6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758731942; x=1759336742;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xib1yeeW4VxdYdCEaHe4ye8jhO22FyajqAxMF3SO7pg=;
 b=e5ul49shOpKV+XMid7tyTOD8phwmtpDS18URnw8mjNmIxuKdgFkcp0qlX8TanMkYo0
 5AiBt9UbNBY6R1bp748tTJpGUoxs7uiE5ebaPzjktJ4VR55X0ayVwcmNZHahsF8wVc5j
 SpFKYrnVUcslFe3ibkL9nhw3KESvyaCgPz9E6UGMgfClD1SUUvfzgrgWnSYawuV0eY2p
 nm8E7icPScgAa9WVobiMpEFLRDn/y8zNy872Y5qm2edIWTL8hbyU6xrByTRsjiffnbeh
 zTXsNibVhqW2BNHW8IAmqWP7XeA8BmbWPAM3mCbcqNezp8zOkKR8iKXWONyP5V6Dxf4+
 H1+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpVMJQt3Kli4f48f8Blv109zdWHOv5b2kSWsSiauTCPOkfsoFKj6Pk43pL/qODcQXKMlm9Cfy3rhuP@nongnu.org
X-Gm-Message-State: AOJu0YzXaE7TolC4/+F9C8rSG9yee0PWs/zTdGNcIjR2LseAMFP+F8bo
 +gkiYrMPHvlbZYMnv7mwquprAvXZ8wRY1nzI/RhiHhKpPw+ByJIl7hHWc9QAsAyAJtv/ApAuV5q
 KH0je
X-Gm-Gg: ASbGncsYR2qBb3bST3LGB0QaowPVIXdyWV5Dm2MogRe5HvFYMRd+lYk8DNW25E4sx20
 04OhyqywhbhtR/me3GuFnHMVNqO40hTH5lw23xWx8/9bEMc4VEV2C0RW7agQxX/qIiiX97yAuyf
 KiTDc2+YkHvvFQDqkoPXA0Pa97RAmAJDPSfGC8wXY4OknuaCc8NsbGFrhMpVFsqEr8+5n8Xf8tv
 r7SGmjXvcfgcI5tSQjP3SMPgLPDyser5SEruoKH5MFqFaDGQEHN5ekNAn25jOD/YVXSnoYibgLQ
 jwevZigw20RzZ7Gdk68NXvKDpuCIf3ah4geoD9ssAdTwVK+gJzQWBeN9DRQEjGNcuPB6D+rIRsA
 8ICXudB4jZCug80+hJgSYIuBek3DleKKpBei3
X-Google-Smtp-Source: AGHT+IE5KR+jjHmDKn+5BXEIUYkiU6jwPkTqKbzTcYwF/LZ6uoc6VUy94HaPbbvy1HKgk23h57t7Zg==
X-Received: by 2002:a05:6a00:986:b0:77f:2d28:8938 with SMTP id
 d2e1a72fcca58-780fcefa51amr529583b3a.30.1758731942356; 
 Wed, 24 Sep 2025 09:39:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f60e640cbsm3724167b3a.65.2025.09.24.09.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 09:39:01 -0700 (PDT)
Message-ID: <9758de22-e663-412a-b536-a8fcce30ffbc@linaro.org>
Date: Wed, 24 Sep 2025 09:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] accel/tcg: Improve tb_flush usage
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
 <6ef7e6e1-9ac1-466d-b4bc-332e135c258e@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6ef7e6e1-9ac1-466d-b4bc-332e135c258e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/24/25 05:14, Philippe Mathieu-Daudé wrote:
> On 23/9/25 23:54, Richard Henderson wrote:
>> It is too easy to mis-use tb_flush().  For instance, because of
>> the cpu argument, some parts assumed that it needed to call the
>> global flush function for every cpu.  It is easy to forget that
>> the flush is not complete when the call returns: we have merely
>> queued work to the cpu run loop.  So: remove tb_flush and expose
>> only the core as tb_flush__exclusive, to be used only when we
>> are already within an exclusive context.
>>
>> In some cases (gdbstub, alpha, riscv, ppc spapr),
>> we can eliminate the need for tb_flush completely.
>>
>> Changes for v3:
>>    - Rename to tb_flush__exclusive_or_serial; retain the serial
>>      check within, not updating to exclusive only.
>>    - Rename the existing tb_flush to queue_tb_flush; retain the
>>      sequence number check for duplicated flushes.
>>    - Drop EXCP_TB_FLUSH.
> 
> When using my split-accel branch, I had good results with v2.
> 
> I'm getting crashes with v3:

Are you sure you didn't just get lucky with v2?
There's little functional change to v3...

Point me at your branch?  While I can't test HVF, I can double-check at how you integrated 
the flush.


r~

