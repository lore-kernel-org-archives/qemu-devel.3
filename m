Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C906C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wkL-0006d4-JT; Tue, 08 Sep 2026 10:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wkK-0006cu-8r
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:24:24 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wkI-0001gJ-My
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:24:24 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-861a2ae9c51so54294227b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788877461; cv=none;
 d=google.com; s=arc-20260327;
 b=lkSKGCuSHqbUbZvyQpYtpuAeEShNpY6ZgvP6pJXmcWgFeumYasxLeevgPjzIfujLCt
 TlGjMTd5lh37yr3R80PIwZR++xSVDJRJZGg/uxQJ6AKdsh+T2e8rQOlyoc7J7yQMCdA0
 qU7vG4qzFjvIKnVnQeaAKe+baMESZtB/bHkE00X9tECvgEkT/C4S7+1+1rldTfZku17z
 csLSyfbpcGBxGYnvFuHTHNxe39UTJS8vcQcBIAzG+huK+KnbwVBMEyp7WsHGXR9RMgDi
 TpZvn5tieBHV+NzKCTv64BClQLI0Zi0WHAfkcTFMauHT7v1yf4LHV3ryIE7oJgbCMFkZ
 fS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yU8EP+PrbggFY2U5+b0p2TGhdz73P/4O5iA8E7drwn8=;
 fh=rpGB3NvKeN3bzo0GuzjgwrLCmDY+TuJKG7jeGX4qgjk=;
 b=bhfYshAr8mKMl0Hj6qAHL/xxCEJrJiwUMSCRYJ5qKzuUDKGMaTBswr+mi2QWnOBZM4
 Zv5pbPfmvV4QGPoNOu6+yUt2OI7YGeuCEIYsNvG4GLqx+rvwL62n4hP9Sib4PCBcdYcp
 eRVBjJKPYOP8dE1zST/Pa4rgDu3uPHa1ZPDfvF9ZRPPdDAhrqA0U6lr4D2Q4e5c4UCS0
 DtJflfaZ+uSGj/GAN5bBo64RKNKDwvmzl0rkfzib6R7v2UmJwnnjIvkl7u+RoQYV5l33
 UI3BZUcZGAzeOHgD2VGTylyi8ORUMs1velQ4TwFHcP4PRqiCY5FhdQTMZXbB2+148Ybl
 bLTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788877461; x=1789482261; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yU8EP+PrbggFY2U5+b0p2TGhdz73P/4O5iA8E7drwn8=;
 b=FfF3QyikvNTumFq12kpLnk3LmhsMHRHkWzJbANL7maZdmgGmemxM4QruN2yg2qiMXq
 Rj2X/JNgb/q0UV7uqASgJlWuuTleIikfeNTdsZjms6PEERx/mGkTR1KL+gG/+VrVDxab
 iyhnjMklmR+4AClUaE9P5SqlSwa9Z6qY+b2JyFJZn9vD5sJe8P05vYRb8GbQ5uWJkiEd
 qMAk3//1r4bbTicj44M/g1G/EGGM0LQeL1iVu42Nti19hxO0ZYiiRlWlwb7sHaJTENeM
 0qyhGStbR24etAUr8ShKkdk0tUWVWdHWnCUD/IaB7aqMj6T2wC9iaHX2fJAQTLuP6F8s
 tsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877461; x=1789482261;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yU8EP+PrbggFY2U5+b0p2TGhdz73P/4O5iA8E7drwn8=;
 b=pYCKuS0rfN7Q4Hesc5j+kh2ftb4/66OJz0a+ssLc53C8dPALW0vd1VYhvrXrxkS+q2
 CK9fDRj3WAjQ6EXoeU3Mj+ZDVypacQO3xfPReCGT4koU93hIapM8npnzkPUpjAxRFUr8
 U4jK+ldkdtK/VTXow5IHteanlemucGme5MrbuBQF+BrkSqZAumNOohTZpFn75VcO93PP
 s/XyxgNAIqTReq1WmClKPpukL+HkPTKaJAqALSV+IY3U2L+8bAHPBgalZNz7kuLNcWTA
 Vdnp5lixB1DLDvh8vWd8AFYcDFTgCyL3V45NSb9QWw4Y10PK0Qj0NZKafw72yIQjtKRX
 WYyw==
X-Gm-Message-State: AFuF++l4e2hi9Zox4toHDV5gnT9HkQ5khBKN9TmHUEYGNhMK6Xz04B7/
 j3deP5J0/W03HO7SSM8Tyi1NLOjxdVnePL/6e3d3FzMic/MZDYBgQFM+uxJKQZM2BPzIO9GYcQ4
 DFLYJ6R4+28MwU39C5xztnlI/3Ght7yw3fywMYbHJrMbIt8kxFysDohw=
X-Gm-Gg: AYBFou1mm+irG+ldDAvG3IMz/Rg0qCI24TEzmA71D6xsrv/dXuc6thK6rhUghebNSU3
 slQjUwguIgj5DLD0iYGfaJTv0/ilUohAeXuMjfETmqVV/L2H/Sel4Cv2Nrirex35Bw5oolDkgW4
 vAO7un+v+ZtI9Fo+yYGzTKnYpGFQdvBW2iMArXozwDWMKJlS9vzy0x6184XQWzYxjH+kF05WR6M
 e78cMzD6o1p244eXifU5BQlLyJ40eFXQayr3QMQJ4mmhjYkHJ+Dtw5VgIWtDiea+UAMyitQuvXu
 5t2fB4Wu35vzFU8x67EIMMI3Dh45OLTLNvARGDuJCvU1ulcZIoTKQpK1JZQuVjKvUL3NHJiyfkD
 mG75Kc+J0LWIIPGdJJqYeCdFlvt9K
X-Received: by 2002:a05:690c:a604:b0:870:b039:9816 with SMTP id
 00721157ae682-8712cedde9fmr87301727b3.32.1788877460902; Tue, 08 Sep 2026
 07:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260908073548.3249551-1-maobibo@loongson.cn>
In-Reply-To: <20260908073548.3249551-1-maobibo@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:24:08 +0100
X-Gm-Features: AcwNN1VudyRtOW2VoB69dOHjnH8V_uK3p_PvawVc6c3OkmnCexGesnsL1A9P6po
Message-ID: <CAFEAcA_pvDUk1b6GooFWWqQGXAfydRGobxErFb=SVoxfv5RH_w@mail.gmail.com>
Subject: Re: [PULL 0/5] loongarch queue
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 8 Sept 2026 at 08:35, Bibo Mao <maobibo@loongson.cn> wrote:
>
> The following changes since commit 35500e5c41aec76cde59befe750600dac7a9e37a:
>
>   Merge tag 'pull-aspeed-20260906' of https://github.com/legoater/qemu into staging (2026-09-07 13:33:12 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/bibo-mao/qemu.git pull-loongarch-20260908
>
> for you to fetch changes up to 970657e490c05b0d2dd8ffbd68466d22685083d1:
>
>   hw/intc/loongarch_extioi: Add extioi interrupt status display (2026-09-08 15:26:56 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20260908 queue
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

