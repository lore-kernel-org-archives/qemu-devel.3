Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F1CCD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMV4A-0000eb-M1; Mon, 11 May 2026 14:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMV47-0000eL-2B
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:09:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMV41-0006Ea-Nl
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:09:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so2922413f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778522947; x=1779127747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6M2vC/5jMpg1K09n2YFUcQODvZ89jCVpV7ZbcwSdfk=;
 b=P0HO1KnvLhsy9F8AvuXshNoGpfbmnsYhPcAZeFd12vJwh/Z8WapF8/5RqKOO7eWhLN
 /wVsrxckbvQBsWrNorhHIleizVma5+oScZ1RPXf8xTAeKHXYeDAdwGruyUZDze/ec2Zz
 GVTrpdaDluuf28MdRFIXLQyYzvhihtY6sapGn/hG8ByksoNIPLRYbG1EFxBBHzGjdaFn
 6yCn98eeUBR0CDj+A6Ldd5+Qmr+0ogI7IQjL6TEWtRUZfMVdHyVe2xdwzan0GmQFN+/f
 kK1zLQQk7KX7NtwRiwFH6PdZDmNFjVK01keITduQnCrbAom9CF9Xxg/MffD+CLHXtstW
 oTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522947; x=1779127747;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B6M2vC/5jMpg1K09n2YFUcQODvZ89jCVpV7ZbcwSdfk=;
 b=al4cZupb29zr8eSZ6cjEFtaO3Usn9z0FTEMkdxW7vB482Y6M2oIlt2EtMuQw4b0eak
 cQ47dz+m8A7xyaOWC4H6IDm127zkQ3DcFSm+BJunAYa2v0FgkHu3hHYnZtVwj6jdGdlV
 RAx4oGQmMofdG5wCLE9oQErJkaqlKlir0czjL53RtXzQFJrEG0f0pgvcnmTalPZ03eYV
 OYSt/P/pghR+lsfd1OYWubzdfDO2p00ul4FSzx6Z3ogIjW3Rd3jOFh9etbtKbJMBA5yP
 ZYrWE0duYPWCwWhOSjuYQcMbcNMMMpM/HUqM9gjmGfwM/M9kJTh50B0Hk7lidbLNCSph
 Qkgg==
X-Gm-Message-State: AOJu0Yz/8/URmKsR5I0kfiiMbh9s1KrWva3KHAI6IX4P+weWSYkwUHTs
 XX6Nxxy6g8itZEOSAvupRxTxRNXVRjSkpnmH2WfRkGprUGY2WzWLgVmQWnpCcjgm09VjTU8ztBf
 QGYGC9Q8=
X-Gm-Gg: Acq92OGngSC25DfCJKrp44PD6wKm8/Crb+mRFCnongLelo4iOgF1Om+S96eICfKX2+6
 JhBcNb88rb/WD+D28ij6Iy2pDrX9tIC4FTiqHE2b3UlhUw2wZRaTRqRqraLVjDhBQo1sHTQzDyv
 4lcBID+0DbhXXZO8EL2M66+e4DkyQ3P61OTJbG/RweRirh76F5Hp8fRh3JJuH89/sWqOfoa65jS
 vUhjrxE+2HF9TsxtCSQaf4DB5rZciVM9b/EQetxu5hfHZalFI2o9TfYlyyLO4rlTssPgwOLevfO
 lBjqq7Ozcyf6iWX03n2C9ciXHcFGCoqWBpLuHtDNNZ6Dp5Kbafpm21tUYg/5KKIxJWoutUE0vl9
 1pM1tZsSYG09KByQdouupudQpZMPk8nkEII0kur838QRiosyTjFTPvpRLHAYvmiFkq93DwzuNCV
 i5MoJFB+7tezYaJIqjnj1w/Ys=
X-Received: by 2002:a05:6000:100e:b0:454:353e:3f4b with SMTP id
 ffacd0b85a97d-45ac0b2d931mr728955f8f.3.1778522947226; 
 Mon, 11 May 2026 11:09:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a5b65sm28168705f8f.8.2026.05.11.11.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:09:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A10C5F7C1;
 Mon, 11 May 2026 19:09:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] accel/tcg: move jit thread manipulation into
 do_tb_phys_invalidate
In-Reply-To: <9794589b-0f4e-4f0a-9d67-ab7e9c1d749e@linaro.org> (Richard
 Henderson's message of "Wed, 6 May 2026 23:58:48 -0500")
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-3-alex.bennee@linaro.org>
 <9794589b-0f4e-4f0a-9d67-ab7e9c1d749e@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 11 May 2026 19:09:05 +0100
Message-ID: <87se7xddj2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/5/26 05:36, Alex Benn=C3=A9e wrote:
>> To invalidate a TB on MacOS we need to enable write access to the JIT
>> buffer. We were doing this for tb_phys_invalidate__locked but that is
>> not the only path into do_tb_phys_invalidate. Move the manipulation
>> into the shared function that does the work.
>> This enables watchpoints to work in MacOS TCG guests.
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3444
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   accel/tcg/tb-maint.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
>> index cd7c32361bb..9a648f97865 100644
>> --- a/accel/tcg/tb-maint.c
>> +++ b/accel/tcg/tb-maint.c
>> @@ -925,6 +925,7 @@ static void do_tb_phys_invalidate(TranslationBlock *=
tb, bool rm_from_page_list)
>>       uint32_t orig_cflags =3D tb_cflags(tb);
>>         assert_memory_lock();
>> +    qemu_thread_jit_write();
>>         /* make sure no further incoming jumps will be chained to
>> this TB */
>>       qemu_spin_lock(&tb->jmp_lock);
>> @@ -954,15 +955,15 @@ static void do_tb_phys_invalidate(TranslationBlock=
 *tb, bool rm_from_page_list)
>>       /* suppress any remaining jumps to this TB */
>>       tb_jmp_unlink(tb);
>>   +    qemu_thread_jit_execute();
>
> You've missed the early return path from the middle of the function, whic=
h should be fatal.
>
> But the place that needs this is tb_reset_jump, which is called from
> tb_remove_from_jmp_list and tb_jmp_unlink.  Which is entirely covered
> by moving this down toward the end of the function like so:
>
> ---
> +   qemu_thread_jit_write();

I think we also need to cover the spinlock:

    /* make sure no further incoming jumps will be chained to this TB */
    qemu_spin_lock(&tb->jmp_lock);
    qatomic_set(&tb->cflags, tb->cflags | CF_INVALID);
    qemu_spin_unlock(&tb->jmp_lock);

as that is what the original bug reported it was stuck spinning on.

>
>     /* suppress this TB from the two jump lists */
>     tb_remove_from_jmp_list(tb, 0);
>     tb_remove_from_jmp_list(tb, 1);
>
>     /* suppress any remaining jumps to this TB */
>     tb_jmp_unlink(tb);
>
> +   qemu_thread_jit_execute();
> ---
>
>
>> +
>>       qatomic_set(&tb_ctx.tb_phys_invalidate_count,
>>                   tb_ctx.tb_phys_invalidate_count + 1);
>>   }
>>     static void tb_phys_invalidate__locked(TranslationBlock *tb)
>>   {
>> -    qemu_thread_jit_write();
>>       do_tb_phys_invalidate(tb, true);
>> -    qemu_thread_jit_execute();
>>   }
>
> Might as well remove tb_phys_invalidate__locked entirely, and
> propagate the direct call to do_tb_phys_invalidate.
>
> The __locked suffix does appear to be for the user
> assert_memory_locked().  As evidenced by tb_phys_invalidate, for
> system mode, we only sometimes take the page lock.
>
> Given that this jit protection is via pthread_jit_write_protect_np, I
> assume the W^X protection is a magic Apple per-thread bit.  If so, we
> don't actually require cross-thread locking at all, and all is well.
>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

