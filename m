Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F8BD3E798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cVF-0006CL-5D; Wed, 06 Nov 2024 04:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8cVE-0006Bv-07
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:39:04 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8cVB-0002gJ-DS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:39:03 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ec4e349f4so4204852f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 01:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730885939; x=1731490739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d3MYGvK6ylPEPKTamct27rF3fI6gYcrO0cE++scIUYE=;
 b=LuYR9y/wp8dX6hPpFRsdFxM8mBjDhS2KO7uX3Sp2dUZnmgUehrzYtIdbsngcf4Kqq9
 eI8kKTfczioFHEUOJhhd6KETyQ5n0MFOh3RsxsL6886bgY9BLb00akt2xCciNIjcRRa/
 Nuk6mGQDqme8KJL3MDyYsQsNDX9KHrOIZ4Sv5XqrDik3xrj/0F5DouM/v3Q7oKc18BGj
 ctszJRFE1L2T+3sxt/ltrGY5bqce37TJ8gkIAD9RYEuFhZXDjJamc19bLnMUHmr4RQXR
 /ip+ueI1zqTHWptKJyXMOKVH15vyD1bJJLTt9LHCXakBhOVnpEdG8lJ881EzckPyZB4a
 AnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730885939; x=1731490739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d3MYGvK6ylPEPKTamct27rF3fI6gYcrO0cE++scIUYE=;
 b=i9aYsmZadbFbJzZwI8qCvgbOkCiNic2pcwVQgzyvM1ust9YCrK9ksP7V3VqLahCDCx
 ExJ+fUV6nH2oLG6Sz9jS6CnqBDS8wP+hVJMejTsTr8jxiRZcpOHlg1b9UPNHxFJin/gi
 vKLthrE2lTsbd7Cly/0c6TX8U25rWkI1EY6i7XFjGQG9zZuZgMRyp5sNtI4r0ZFvkx29
 o5BAwfNnUk5Vfhk8PXRCkDNNpgzpexyzdy5rtQJV5wYTSl+8UPNxuZ/+hhYOZGNsfjSn
 6PxWhhW3en2lTCJ27MM6GnUnGS6F/mPeBBPehnSEsdb1pP6mRGU/xEgIwIxWxLxfTKqL
 syiA==
X-Gm-Message-State: AOJu0YyI0a9Ft8WXoMILhzApkCh/MlyeJOXTBYpkV8kdXiVStZOn2Z+P
 Ju44cbIDS2GWrukpeshnxElHSTLhumGvzIsSobDKK6PkoEB5dN47o5B9Dn83qiymaOEOydCh3tx
 6f8I=
X-Google-Smtp-Source: AGHT+IG5S3Gdm1Qys2lpk2EfHq8YgeAIia/GYC4fyp+MNmQL6E2eOrYTDM31SaGtTPxyeFbVPPZqdQ==
X-Received: by 2002:a05:6000:1f8c:b0:374:ba23:4b3f with SMTP id
 ffacd0b85a97d-381c7a484e7mr17594102f8f.9.1730885939254; 
 Wed, 06 Nov 2024 01:38:59 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7387sm18457417f8f.51.2024.11.06.01.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 01:38:58 -0800 (PST)
Message-ID: <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
Date: Wed, 6 Nov 2024 09:38:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

On 11/5/24 23:54, Noah Goldstein wrote:
>>> You still need to handle is_proc_myself, for the guest binary.
> 
> Would this by handled by basically do:
> 
> ```
> if (is_proc_myself(p, "exe")) {
>          exe = exec_path;
>          if (through_qemu)
>              argp[argp_offset] = exec_path;
> }
> ```
> Or am I missing something?

Something like that, yes.

>>> I wonder if those two cases are related.  Do we need to also add an argument so that we
>>> can pass the executable to the next qemu via file descriptor?  I.e. execvat becomes
>>>
>>>       f = openat()
>>>       execv(qemu, "-execfd", f)
>>>
>>> and is_proc_myself uses execfd, which we already have open.
> 
> How does passing a fd from one process to another work?
As long as the fd is not marked O_CLOEXEC, it stays open in the new process.  Providing 
the number via command-line, or whatever, is sufficient for the new process to know what 
is going on.

I now realize this is necessary for the AT_EMPTY_PATH flag, where we only have the file 
descriptor.


r~

