Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9A7FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITU2-0005LJ-5H; Thu, 30 Apr 2026 11:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wITTz-0005Ki-3r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:39:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wITTx-0001m5-OX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:39:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ba840146so9086995e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777563555; x=1778168355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7c7gE+DSEv7ZdAzEy/AHRGBXzOiwvdoVtjeIYzhkOT4=;
 b=Cld9uxyY7IsXjgbXztEwjl3O+TOD3SrOaBQ/q97JQ94qx+j8WZTZxYHRa/S7MiS5KK
 B37C7kzB/CI73vNZlOW9lkbFkLxtxBrcZ/JhB2zQdVNih2+YQk0bbZo63GeYX19v13OZ
 o6C4mqHwW/BvXgJZy4sXKnSgIxone1Vch5bqEvBFAZ0/iExQNWIrNtQ/WwYYw3HvwQVM
 +5wfuUKQubyRsdNwLw+HLADBM1yPpYc3yEyDriDRllvvbH0UyeY6WsCn+WY594HBuGip
 akkUPEHN6KrTDZBusK4kmY9ShOh8kKi7rddTdjk7JNnC3oiZgvxvGvqlee7UuO/kW49M
 KXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777563555; x=1778168355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7c7gE+DSEv7ZdAzEy/AHRGBXzOiwvdoVtjeIYzhkOT4=;
 b=PsjYw9kGlN4TTuY38u7LxQnqSqMKJX50eoZSkbp9AmvnsYvrklfRY+/Wu6WIyVlADY
 EeThLf8gzhizyMMLqjqLITcdYCKlnWngugJT8OsmHHbIA3gekafE5Ay0MKbMDb/AqT8w
 OP3MJLxD3Qnk0fEIdpau5isBGj51IKK/HzRJ3x2tbOtNgO5SSWaIBeRZFscujgLHFPqo
 1mxxX2Xs9qwQ6HzAC5JkNBi6P7KKBlURCHp9xmQqx5aqRNp8RD5W2LfKf3uDOx28XaCa
 OoYmhBEUtsGKj0AEyHJ1l3j7I8vG2LCWXsMxZ2Os1sZ4CdH1u1XJymc1KpzsFL2LWfHQ
 8ujg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k8d160jH5vIV9D+CGBKxtT1BQgA73JHG0oNncJuLt7wOCVsAMbUtkPQW2Sl4265wWT7DE8dDLhop0@nongnu.org
X-Gm-Message-State: AOJu0Yw2IDZFBtCb0d0Ekgkn2SMIZACNNgXcbQuW7xMkW4WDURjR5Om2
 GR/rmw+MH/j+XCY81JEegD+QC7MBRRoMIYlcE8nZWiZlxOrTGmNoqP5AapJVFO+I0p8=
X-Gm-Gg: AeBDietSmzq7S1lOW46jPfcCJn3FeO/z6b4QDidbhzYrA9gcSd5JgIka7/4jeSxLffz
 E39Do3/vQv66Iq5BWvDVsqH7vERsv5uiZBf5L7MZtXxe2H8Rb9i/8Tjpk3LURQ0FNhnOh8ZKm3+
 Rui/L9IHkeBFGLpIfruQjY4Kd87FZ9AtE3ri92GnINIwsaRtH96QtTTzQGnEzuXir1KE319YIGy
 AF3NwOFS3v/qsk4S079ImnNXSKarHve9Tah/Tav6NArjvNqyjCzAuldNn3cF9d6DFbqNhW1DUqH
 j844be2CliN0cK4TZGlz/inl0BS2pxD9IWKc9dhVXnKZhlWZSVDHk/pQEqqFT8HxOimZ14Mk0Lo
 v56c47BKKE4tL6kvyzicXishyItmzJVTkwdec8LxqBnRnfOi4bOjoreITsWLWCkjP2v4sz8IIu7
 PcNGTSArVQFfREggi/F8SaoPa8E8gMo31/uKyV4IxUDcK0UhS7hI1APHTeDdYhwtzd1Egj708YX
 h0i
X-Received: by 2002:a05:600c:8904:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48a84451b8emr44525235e9.14.1777563554807; 
 Thu, 30 Apr 2026 08:39:14 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c2ddc65sm69759595e9.4.2026.04.30.08.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 08:39:14 -0700 (PDT)
Message-ID: <3a981e61-67d4-45ee-8bb8-efce9c8849d0@linaro.org>
Date: Thu, 30 Apr 2026 17:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tpm_emulator: Reject a buffer size larger than
 what was requested
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com
References: <20260430142337.2104726-1-stefanb@linux.ibm.com>
 <20260430142337.2104726-2-stefanb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430142337.2104726-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/4/26 16:23, Stefan Berger wrote:
> When the TIS, SPAPR, or CRB frontends negotiate a buffer size with the
> TPM backend, then the tpm_emulator (swtpm) could still adjust this size
> of the buffer to within bounds supported by swtpm+libtpms if the chosen
> size was outside the acceptable range. This could theoretically lead to
> the TPM 2 using a bigger buffer than what was requested and memory
> allocated for. In practice this would not happend since the requested size
> of 4096 bytes for TIS and SPAPR and 3968 bytes for CRB are in the
> (currently) supported range of ~2.5kb to 4096 bytes. With PQC support
> the range will have an upper bound of 8kb and a lower bound that will
> support the (pre-PQC) CRB with 3968 bytes.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   backends/tpm/tpm_emulator.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

