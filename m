Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57323C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcLr-0004xg-S1; Fri, 06 Jun 2025 15:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNcLq-0004xQ-5c
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:03:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNcLo-0002el-9p
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:03:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2239998b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749236614; x=1749841414; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPb20cNx9l0pewyi7VxzazAt1qnYiUIWQ8MLnMDNU2k=;
 b=a105ObfT6wrehwfEF6K5dbina4vigud+a/vOxf4YzFFGMAaCeJKlvg61MplgCg9nWo
 K7b5QE9yx0v2XyKgsJ5SBb9M2VekMW/IoIaNIGcmTqlNvA0D59H75DrkfjvSJ6HEtaWu
 Tm5y1SrB6MR6JeaFRmhdGJpVYH8lecBC/UfToTjjymYWnwJzMVaKhP0gdZJJN3tS2u+R
 oPqYHcusa2xHSEpIcq61FtoD0of7KWvypAsPLKfBSn+o2zPh/N0Eq4fJoDlKFCdeQsgc
 pUsUsV24EZmUGyiQxfJ0LDsEXp7te8ATzG0oxCJQ5lAG+j7WfPYTyVhvVP1Qkh+yhfr+
 StDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749236614; x=1749841414;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YPb20cNx9l0pewyi7VxzazAt1qnYiUIWQ8MLnMDNU2k=;
 b=duJfVr21KpppnCMtoSiW6TVlAtShOt9Lspc5/hbraCzAuS/TnnT9Hr7lPEPstwT+Ck
 Loa6Gj+TLsSCOT5GelmYQu7TBhHOpxGzZVtd80CwTJXOyzgOg0X9ZYWPPybk67EImfRu
 gi99ZOlmOaCTs+LwgcCQdar9eKaNn247BbvBlezHeqKvn3fbXiR9rVmGUZs5zfsIza0l
 PZwvz59BmfeCJKiC8Z6+J8Lz0yiEyJNMjSqejthK0xuoQ+R7iW7zIZGeBmsDtoZzbmUH
 pprsT9xSL7IZLzroHhKgNkD7VwAEu+EUGH18SRRN6NWoeRax5LkSdx+D+cHg92gefpvX
 FpAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTlayLCIKkUqXDNClytiBrgcLcLqC/fRZ+YXt7TiAAUzsj+t/+dFIgq346O4TeDmpjhPwzEeXClIF1@nongnu.org
X-Gm-Message-State: AOJu0YzcjKQviWFYaIOV1XtMaNpdhhyyu7WXtcZJQqAy9vH6ty2fXM60
 WqiVGe8+/0Fyt+/CjxnCKXrSXtA7Un0dPbUboZhvWn/F0AsU3aE8AJDmnrPO0MGWf0Q=
X-Gm-Gg: ASbGnctuLnAvmpwI+wadjcaq5AhcbuYSTu8eyaQZn944UkV8yjwSCRzEebaPtrkitXN
 E13GerkkDc16cT1UWgrC4M1WtOIvvKOghTyUSt17F7L6HVGwNmoOzMGWlYpnWCk7ZbC0Z/NtMGk
 0KuPW5pdvjfTdmfbhQL6nHh7mmr/dZnOWOGXcmPhUybC7uepGLPSuySERltXDx9ctV6E6yI5YkN
 rGcHNNQTxqeyiFYKdIGCRsdgvtH3/uI7OLELP+xFOuB8fmkH5WSBDUTeTPYpL01x/vpFTl+QDly
 id5ywbPyUg7v3Q+qNPGCWRIqI9YqszTiL+W5U4sg8ukRsJJE2CVX9fd+krU1j1/j6wUAu8Bo6To
 =
X-Google-Smtp-Source: AGHT+IE0TLxIxrRUvvmLB/BCZpNan723F+fSSyxBvj59uAf0o0LOnLtAG76in4F5bb7/lGWxn6/h/g==
X-Received: by 2002:a05:6a00:14c2:b0:736:41ec:aaad with SMTP id
 d2e1a72fcca58-74827ea5cb9mr5769585b3a.14.1749236614163; 
 Fri, 06 Jun 2025 12:03:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847aesm1650237b3a.105.2025.06.06.12.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 12:03:33 -0700 (PDT)
Message-ID: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
Date: Fri, 6 Jun 2025 12:03:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Controlling time in QEMU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

I recently needed to slow down time within a virtual machine, due to a 
timeout being hit because my QEMU binary which was not fast enough (gcov 
debug build if you're curious about the use case).

Currently, people tend to use -icount shift=X with low values for that, 
as it roughly maps time to how many instructions were ran.
As well, I've been working on ips (Instructions per second) plugin [1], 
which allows to slow down QEMU execution by sleeping, as suggested by 
Alex. It's using a new clock update API [2], that is limited to move 
time faster (jump to future time), but not slower.

After looking at how all this implemented, I am wondering why we don't 
simply fake real time QEMU is using as a reference, which is based on 
gettimeofday [3].

Using faketime, which fakes gettimeofday I've been able to manipulate 
QEMU time:
- faketime -f '+0 x10' qemu-system-aarch64: boot timestamp is 14s
- faketime -f '+0 x0.1' qemu-system-aarch64: boot timestamp is 0.13s
In both cases, the real boot time (QEMU execution) is around 3s.

It works as expected, speeding or slowing execution without impacting 
QEMU speed itself, which can run without needing to do any artificial 
sleep or clock manipulation. If a program in guest vm sleeps with an 
absolute time, it will be multiplied by the factor, which results in 
significant slowdown. But it can't be avoided, by design.
By using a time factor big enough (x200), it can even trigger 
rcu_preempt stall detection in Linux guest kernel.

As it seems a bit too good to be true, time for questions:
- Has it already been considered?
- Any obvious downside I might have skipped?
- Would that be interesting to offer such a feature in QEMU itself
   (-time-dilation 0.10)?

[1] 
https://gitlab.com/qemu-project/qemu/-/commit/72db6d54a4a9203736261fc63f32f6cd3486b7e4
[2] 
https://gitlab.com/qemu-project/qemu/-/commit/847a65dd76bf1868c7966a2b2608dcd00cb68dc7
[3] 
https://gitlab.com/qemu-project/qemu/-/blob/master/include/qemu/timer.h?ref_type=heads#L809
[4] https://github.com/wolfcw/libfaketime

Regards,
Pierrick

