Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3461C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 09:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujx9R-0006hV-Rn; Thu, 07 Aug 2025 05:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ujx9Q-0006cO-6f
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 05:43:08 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ujx9O-0002RR-1A
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 05:43:07 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e904114e1c0so182704276.0
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754559784; x=1755164584; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nNOj+Fog91d5AhklEuu/5oGoMorQcoVZ9r41Ehy9MHM=;
 b=SknZsAMIgPIvJu0i3YZwAboWj9uybjbngjedc8H5Uu2nB3nkvcth4YsWMfwTUSXbep
 L+skYUlCQtvEkhSF9ApDlAw/WIi0EG6rCyOJxC7j/dQpSio3MY39e4MQMTmB0vKCQVOK
 BEG/Z1Oz1J0D0yTQ5Aa7Ywjp7s2Zmqb2Xr1L8TbIpcxh1Cz1BiFUj03ZdwRtCfgk/6rz
 GbWfZAP4yIz/1GRY8EyEj7dpz9fGiF4qGjFwX2GgE3M8fVo5XgUgX2t0EoQ7B1dTm2Ly
 ZkB13vkM8zqWxSwjDdGLKE4cO28KdpOvg0o1Oz/garz+yw/ut0tT+10x3QqsqQizT5Ll
 l76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754559784; x=1755164584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNOj+Fog91d5AhklEuu/5oGoMorQcoVZ9r41Ehy9MHM=;
 b=irbazXyBXaeFcDEFy5r4OehSSer/JiE1YqsPrmMUQHcppHnXZn7ZGUXXKNH+zxnRQT
 u58Oe25DC0Ika+6Ahey6U/cO/mY4yJ1wRuetivOUQ9g7Kad2XB8bkf7AK7A3ghge2Mp9
 Wg64rlbA8Nq3ktAuTiwyDcIF6aqtEevH6YyEUFtoC3mUWPC1dr8I01Cf0EGT+kN2Or4p
 iPFSYmSthCwzI85idwMNkUPtaWL5xTvyb+3nqAP4foGn2t/W1sC+YWDDW9hhFvli2acC
 ZxAGwujP/kkBhWnoz7tT1UBMf8QqKasBYBu1Xt6vhOwfhHiG/wqMA2JFp2HN35BiUm8E
 9PMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRc1WTCIJw4ofIyO/Hsn0qNuq4il0UpssBPRv9Qx6FGS4Rezm6iB1pg5XuLZ4ompCjnJK7rUEhSrGL@nongnu.org
X-Gm-Message-State: AOJu0YzX7XBwextLSOtZUaL/yX3olCXkMnT2Du3cQhUYnXaV7UjIahwd
 e6XOCTsbsUo8z12oP0TbFtHSghicjJr+esK7Vrp3ojKVm0zztp2x8YzCAx054UG3od98zMHHDgW
 XNoJAsUXKvLSFukcz4m8KiUYPLaEBv1ZsCSPrmT4Q4w==
X-Gm-Gg: ASbGnct7xwwFarDmQbX2WhEvSv+44jesQrPfI7RcTI/sK2hqNdZvSzf3z7+6Z6bGtXi
 nOOw7YZfRHHoF3It3rvjpce1/q/xkOF7KdpzZflpvZ917U9lqt7tT/lLLCCJqm2+rt719z+wJFg
 arFi+ql5TeREtw80HdNFAonQn7aph740AmA6iX7j5dZHqqWXzIVdzyBsgIA4oEbqyRy3T5dUYpS
 KMtoGgf
X-Google-Smtp-Source: AGHT+IGyMYNRHQzSHhgea7B4Jb2jf7My4wczQ3l+DmQ8quU3P+6Rc3KAEvzClY3BD+QplutJOOFhmj2pPIVqozloLr8=
X-Received: by 2002:a05:690c:968a:b0:718:17b1:40d with SMTP id
 00721157ae682-71bc973985bmr85378337b3.7.1754559784091; Thu, 07 Aug 2025
 02:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
 <875xf36qyk.fsf@draig.linaro.org>
 <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
 <87ikj3545v.fsf@draig.linaro.org>
 <CAFEAcA-Y7utLb9cciGJOVAPF8Y0W4RxcOLDnNS7ptpHtYVG_EQ@mail.gmail.com>
 <CAEWVDmsOD-vNc6YbwfND9yzfz-G8kEsFfpEtJ5A+duhUzGU2Pg@mail.gmail.com>
 <CAEWVDms3R+_dv79GTdmzbJBJ3rb=hSi7rRj=f4rzRFwsHnzXJg@mail.gmail.com>
In-Reply-To: <CAEWVDms3R+_dv79GTdmzbJBJ3rb=hSi7rRj=f4rzRFwsHnzXJg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Aug 2025 10:42:52 +0100
X-Gm-Features: Ac12FXziHR0QgX7Lu1Vbwgf3rgW2LXJfit-0IrvjmFBIDgH3Odju9jUtVI78Hws
Message-ID: <CAFEAcA_Q-MhmFNvXUwUXF2_MJqHxujPL7C3=PxC8=hMprerDxA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 6 Aug 2025 at 22:18, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:
>
> Hi,
>
> I reached out to the gdb dev team regarding these questions
> on how to correctly handle the SME za storage. This discussion
> can be found here:
>
> https://sourceware.org/pipermail/gdb/2025-August/051858.html
> https://sourceware.org/pipermail/gdb/2025-August/051860.html
>
> It seems this approach of increasing the buffer size to above
> 131100 has also been applied to gdbserver as there currently
> isn't support for partial data transfers.

Thanks for chasing that up.

(1) I note that gdb bumped this to 131104, and we only
have 131100. We should check what the worst-case is and
make sure our number is big enough (maybe we count different
things in our buffer size than gdbstub does?)

(2) We should add a comment to MAX_PACKET_LENGTH, something
like:

/*
 * Most "large" transfers (e.g. memory reads, feature XML
 * transfer) have mechanisms in the gdb protocol for splitting
 * them. However, register values in particular cannot currently
 * be split. This packet size must therefore be at least big enough
 * for the worst-case register size. Currently that is Arm SME
 * ZA storage with a 256x256 byte value. We also must account
 * for the conversion from raw data to hex in gdb_memtohex(),
 * which writes 2*size + 1 bytes, and for other overhead like
 * the command itself or the checksum.
 */

(but ideally check the figures and be a bit less vague about
the "other overhead" :-))

-- PMM

