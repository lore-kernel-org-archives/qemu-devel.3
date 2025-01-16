Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A7FC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNTv-0003AY-C8; Thu, 16 Jan 2025 05:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYNTo-00032v-Cy
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:52:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYNTm-0006uv-P7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:52:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so432819f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737024720; x=1737629520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWAY9nFwSu7kgYW7ClZSo4bYY2o5wAOQVudqPA4FJNI=;
 b=CQz9C08SjzeSLrHRG7oE1ig4rI5+JkIwU0RIMu+xJ8bqfJ8X7Mslc3ZhQvbFQFHQ6C
 +ZcVXo61VRbNz/srCmvwjcDrntGB3w2pp+Cq21Suh2GzCUzwyGTj9dHDyCRYDq9M38/F
 NgJdgqDfQaWzxIvcTeI8LyQXlo35VNK0OlxGm4TTllucEZGX2pGd9AIn3Qz4V3j6Y/gl
 uPR8LTbk1xqErw81fTe5fqQ3dWq6hxs8cI3bYji2lYqDyTfs22aW0nmTtRnr9E1ZCkF6
 GYX2q1i9wJDnmHW9KmpFKVOAEWPz9pA6NRKi3qTdf4D4EjjbyH9bO2iabxgRoERovzRO
 B/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737024720; x=1737629520;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tWAY9nFwSu7kgYW7ClZSo4bYY2o5wAOQVudqPA4FJNI=;
 b=cIYYavU33JKYIyxSzuOzW8bMM53ubWd5/gHtafN4bHNg8OgXrGycdhdjDzJ7AANMA+
 81LCM7HGyoP7k6+n+ucW+6TmFrVzUuYDrogBBJpXRy9uFobsu0+bdkdSK2cL+N6ZZ5yz
 hsOYAT5eClaXVGZlGmZXgKh/z+C3O3mW1Vz6h1o5j8MRgC0cN+AS8ddQeBbqj7RoChh7
 3Lyci5kXXmm24SjiH6ONAYf/bdQt75ZxWwEe4k9GnLKP9ty7f/PYyd4fcx44allwU0JD
 erodup3NWmdQS3msliNdHW9yRuUXhr4lsozH5dmsb8mtrgxXh78dKZtiivC7o9x8r/lK
 ftyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfpi7stzdnBeTsw4bl+OyJTMrIHnO4AX4iQ2A8SO33Rr/tTPUKGOkMv7V98jZft6DYr/i1M8xewFcP@nongnu.org
X-Gm-Message-State: AOJu0YwiB5eoT+UBl8xXTrIAStntvZXQ8///ICtIWi5Iqq2mCvv34PFD
 q4HPVx821qLx1Sf9wukFkDSTsn36WzDqY2/pTrjzwKR0bnsxUpGIZaFlQ3DQWGA=
X-Gm-Gg: ASbGncsLtr5273QFhzVi6dnWqKLJik+hE7oKb85AUCb8+NIdKJuXrcUMn3eyrB03NSH
 dVKiqbqOQ6+yTKlqWppfqVQVf1olfyP5o/Kem9aZnanvcUzXjhYzxTzKoWoVna12+PCvEaTBzmR
 N3beEJUhSXhA0yeD5Bc5rk01el2HHEuVYjF7aIJ+fmdBxN9k2IrGfLtFxycKDRaotv/kTatnFsN
 AnEJmLNjI8BuccGFR/2z5wJ3FM9TU9sHJK9pYmqia8vZkX1/Ytr2p8=
X-Google-Smtp-Source: AGHT+IF0JZjsZr53E9gsxvIFP96yMGoH4Cm+VUlHj5v2ZhEUofChnS/X6KvBqa6VhLGTXIGio7Zz2Q==
X-Received: by 2002:a05:6000:1862:b0:38a:41a3:218 with SMTP id
 ffacd0b85a97d-38a8733899emr27204455f8f.36.1737024720548; 
 Thu, 16 Jan 2025 02:52:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383dedsm20444054f8f.35.2025.01.16.02.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 02:52:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EDE35F8B3;
 Thu, 16 Jan 2025 10:51:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Nina Schoetterl-Glausch
 <nsg@linux.ibm.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
In-Reply-To: <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Thu, 16 Jan 2025 10:19:30 +0100")
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
 <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 16 Jan 2025 10:51:59 +0000
Message-ID: <87frljhvzk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Wed, 2025-01-15 at 16:08 -0800, Richard Henderson wrote:
>> On 1/15/25 15:20, Ilya Leoshkevich wrote:
>> > Currently single-insn TBs created from I/O memory are not added to
>> > region_trees. Therefore, when they generate exceptions, they are
>> > not
>> > handled by cpu_restore_state_from_tb(). For x86 this is not a
>> > problem,
>> > because x86_restore_state_to_opc() only restores pc and cc, which
>> > are
>> > already correct. However, on several other architectures,
>> > restore_state_to_opc() restores more registers, and guests can
>> > notice
>> > incorrect values.
>> >=20
>> > Fix by always calling tcg_tb_insert(). This may increase the size
>> > of
>> > region_trees, but tcg_region_reset_all() clears it once
>> > code_gen_buffer
>> > fills up, so it will not grow uncontrollably.
>> >=20
>> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > ---
>>=20
>> This needs something else.=C2=A0 The reason why they're not insertted is
>> that they're not valid=20
>> for a second execution.=C2=A0 We need to not find them in the search tre=
e.
>
> I have the impression that code_gen_buffer is=C2=A0append-only, so after =
we
> create a new TB for the second execution, the first TB should not
> be deleted - is this correct? At least I haven't found=C2=A0code_gen_ptr
> decrements, besides the rollback at the end of tb_gen_code(). Then,
> since region_trees are indexed by code_gen_buffer pointers, and not
> guest pointers, this should not introduce any stale entries.

We used to generate a temporary TB, execute it and then wind codeptr
back. We simplified the code to generate the TB but then not add it to
QHT - I think the original reasoning was saving on scarce CF_ flags and
not over complicating the tb_gen_code function. See around 873d64ac30
(accel/tcg: re-factor non-RAM execution code).

This does have the effect of potentially regenerating the same TB
over and over again but usually there only a few insns executed out of
IO space.

However some arches do more of this than others. And now we have devices
such as CXL where people do want to run large amounts of code directly
out of io address space. This eventually exhausts the codegen buffer so
we do a tb_flush() and start again. This is obviously sloooooow.

>
> While we might not need to find the ones created for the first
> execution, we still need to find the ones for executions that fail -
> and there is no way to tell in advance, which ones these are going to
> be, so the idea here is to register all of them.
>
> Am I missing something?
>
>> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

