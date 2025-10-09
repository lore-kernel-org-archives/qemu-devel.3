Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61DBCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sr9-0004Tj-AO; Thu, 09 Oct 2025 11:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6sr6-0004TY-W3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:47:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6sr0-000568-8A
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:47:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso1679124b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760024805; x=1760629605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxz7KFELTY+HmSmj9dsVAPC9MxL53j3vP0NgMx1O4jQ=;
 b=LE1eNQEjdtQUdmTuFq3gpv1AOh59aO/HG8cFCw0wxyM8GDl3yFD5VXxupBnJaSdQqe
 ywON2IRha8+BUVF2ev5KN18hVc04duhcc4R4bkkQcfUTzmjol1iSiQnQ4WkzdeXvFusd
 uu1k59Z8xcoEt7RgdEdvpccfWCt2zZKVRI/IOixSM89JSj7f8nATQujUNSgO9cI/3He+
 bun4IwIVlCds48LEppzZMyhHSnK9eRV3Vj785pK4LqhxmpXI7fkm8OPrDgH0loW9W2SR
 59G6nxLkQM8LIrvtYL33Z23FxnVF1OpgAJd9orwqafrKSSKtoEUVxKLMOv21CXI8uPMK
 y+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760024805; x=1760629605;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxz7KFELTY+HmSmj9dsVAPC9MxL53j3vP0NgMx1O4jQ=;
 b=DuF94L3ihJdgp1yQQaQUrPYNr/QRa0BvKKeVvWz/N5Ecrv9gIJ3yA7H+9RqUbeU0Ya
 K/aihT+n97PP9tW8j58Xeebo9qQrsCLK+l8J/R43sDM0U49yHUGzxYzYFBSqJljR5ux3
 aPyN42PMWgRTON/P48K7JsZG4qJD72J6z/mKSINVB3OYre5y5e9kNSn1ZNY9zvAJ+JpU
 IzR6TnPtjaCpohIOawGFgaPR6cKUqRzQ58hnvHe84Lqit+cLYDf/QTeEkfqFr1J713Sx
 Q68orgpEFqTym+uNeTTcyk/Mnr8N5hABiuYD/vwY/e+sKLGpPPp3UCIyogQqPEqaMGu6
 exqg==
X-Gm-Message-State: AOJu0Ywtfds3kUYh6BAxLoJHBvHrq/CdLNJ3zPb/orHImxpBF89kwBJG
 nY2MzwP+TyMK+/uPLYULP7fNgSU0A/uQhClmpFdVs68hUZTPDltIwqAG43ryMv/FQwgXDHCLFcH
 MMb0jW7Q=
X-Gm-Gg: ASbGncurVQROI7XYI+7DyQnlknizLkWWhchewFC9AP/uyUbQQKLpS7QykcAuoImvvZQ
 wCUR4jinzRmJyXd6Xun1I7KEKAM7O96GqFqY8X2p+6lHcR7Hdq1GQmQECP/SPeyWDZzarr+U+WV
 xbq3HEwYVsNB6D1vzgyyMMY8vvcSUJNuSDlOdoz9tht/DsrhASktunL/FaFDdIug8KBBiApGtte
 8CTii4CbCrmaFkoeNmTnp5LZKHqavHkOHOiXTeUlg1Ys2g4tke0eylUXPidKk7peKdBowPjskLX
 kGtDrMkhdahez/5KQ8N3Gce/5yMfxCleamRTwaDwfRs45sgpPt+gCjV0NPTAHdvHlK1sCHgyyN7
 jGQa09Y/X0tLRHTRkP/+ga3rHIWveGzMriZCuI1dolWUPLlkHcq759Sb70vvtuGHi
X-Google-Smtp-Source: AGHT+IHIjlrmSn3ntwG+uK44G7OiaOkgQ/XYqH5xiLn3HB4wYFJKLGWcpVJDds+3GM7gh5E2sTeB4Q==
X-Received: by 2002:a05:6a00:1149:b0:792:52ab:d9fe with SMTP id
 d2e1a72fcca58-793823b6278mr10503140b3a.0.1760024804727; 
 Thu, 09 Oct 2025 08:46:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b060962sm102919b3a.1.2025.10.09.08.46.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 08:46:44 -0700 (PDT)
Message-ID: <a5c404ed-067d-4f78-9381-a146986da534@linaro.org>
Date: Thu, 9 Oct 2025 08:46:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix layout of struct target_msq_id_ds
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <mvma520fd3i.fsf@suse.de>
 <9c3b5ce7-8106-48af-9d6c-0d8e26e934fd@linaro.org>
Content-Language: en-US
In-Reply-To: <9c3b5ce7-8106-48af-9d6c-0d8e26e934fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 10/9/25 08:42, Richard Henderson wrote:
> On 10/9/25 05:56, Andreas Schwab wrote:
>> The msg_lspid and msg_lrpid members are of type pid_t, which is a 32-bit
>> integer.
>>
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>>   linux-user/syscall.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 0956a7b310..3dcdb3ef42 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4185,8 +4185,8 @@ struct target_msqid_ds
>>       abi_ulong __msg_cbytes;
>>       abi_ulong msg_qnum;
>>       abi_ulong msg_qbytes;
>> -    abi_ulong msg_lspid;
>> -    abi_ulong msg_lrpid;
>> +    unsigned int msg_lspid;
>> +    unsigned int msg_lrpid;
> 
> This should be target_pid_t.

Ho hum, target_pid_t is private to elfload.c.

Since this is

include/uapi/asm-generic/posix_types.h:typedef int              __kernel_ipc_pid_t;
include/uapi/linux/msg.h:       __kernel_ipc_pid_t msg_lspid;   /* pid of last msgsnd */
include/uapi/linux/msg.h:       __kernel_ipc_pid_t msg_lrpid;   /* last receive pid */

I.e. not really just pid_t, then let's go ahead and use abi_int and have a comment.


r~


