Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FE6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJqT-00007d-Uf; Tue, 23 Jul 2024 14:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWJqP-00005L-2b
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:02:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWJqJ-0008Ul-Sh
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:02:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3684eb5be64so3001009f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721757750; x=1722362550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7S3a2md43hb4zNMQ55AJJzTFm+D1MhDeY6mpisPvLAs=;
 b=YkxOKZwBE947A+zYX/IKwL2trU3qM0iX2tZN2ZN1F7dvZ0gHRuOfGyymTdyt0wY5Tc
 4QhfzheYChW6VDLS5W3CF0jAt10EJwrEYyeWbexDQ5uXX9fSIWSDQXcEcx+cDFy19mHb
 e/S8JAM/enNgHMFDGQ6HQg5qVlRNr07b7m5vlMBdKj4Oi9v9Nbk5QTkd3Hkf6ww3bWWB
 Qxv8bRz2kK3VDI7e3Ony6a9o7iDpQDAMTBqHAapuHaOXzfVaUwyNNuqHxyfkaX4l0wTV
 rB3Nn6o2QFzbiRzEByODlQL4mFESr6nkHU1eQ/c11o7Uun4yhSVugWT9vNAC7Oj+Jzkz
 erSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721757750; x=1722362550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7S3a2md43hb4zNMQ55AJJzTFm+D1MhDeY6mpisPvLAs=;
 b=gIdlVY48oHoFD80lzFP5hwlcqxUvTEwUgzxyGfqEnUzcMpbloC+wEmjsR6W3go3MFF
 3Fp5Jbwx2A3y0DBz95tduXmbSjYTFjlW9xqjho76Xm7QbitImqywj/ko76g7KfULRp2o
 c9lvED2XRQNomWaPuBkunEW+mSvT2LVJyFZvlDEdl5VkU6ohSRPIDE1fOlJz6/E72AMb
 x4CCwhIUU/Dr1RHoQBu2FDWJfQcQ2Dyit3adFaG5bIe7vqtOEL7L18wpvNB8rvaYwRDk
 80Sw8EADkFmMCyv/ye2kzcPFcb4YXkljtF2OLdM27jyUYCZLs5nxddYmsmfxLFbEFNUG
 +rQA==
X-Gm-Message-State: AOJu0YyuqZ7nfM8h6hpJb4nGxpA+YdPTFvDoGMGprkVsIhrDLFbl6oHO
 Fe/fNjr1HPwa7tF1BsRS0rQNmahpOO0cfZv0rRVz+TIA/vW6Gl/17eWUhNW6tSTTH9NfSfIWacS
 8/lc=
X-Google-Smtp-Source: AGHT+IFUeI0Zjy2nfRwYaAVd7jdvXj9nkUZDII/GiPETjFdDDMinEzyXd/gwc6DxVhxT+8e48m7HSA==
X-Received: by 2002:a5d:6206:0:b0:368:7ee2:b7c8 with SMTP id
 ffacd0b85a97d-369dec047bdmr2794723f8f.1.1721757749784; 
 Tue, 23 Jul 2024 11:02:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa171sm184554195e9.1.2024.07.23.11.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 11:02:29 -0700 (PDT)
Message-ID: <aeb3b761-7a74-45c0-bc6b-87e4f6eb1527@linaro.org>
Date: Tue, 23 Jul 2024 20:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] util/fifo8: Rework fifo8_pop_buf()
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 22/7/24 18:07, Philippe Mathieu-Daudé wrote:
> Rename current fifo8_pop_buf() as fifo8_pop_constbuf()
> and expose ESP's fifo8_pop_buf() which takes care of
> wrapped FIFO buffer.
> 
> Supersedes: <20240719151628.46253-1-philmd@linaro.org>
>    util/fifo8: Introduce fifo8_change_capacity()
> 
> Philippe Mathieu-Daudé (7):
>    chardev/char-fe: Document returned value on error
>    util/fifo8: Fix style
>    util/fifo8: Use fifo8_reset() in fifo8_create()
>    util/fifo8: Rename fifo8_peek_buf() -> fifo8_peek_constbuf()
>    util/fifo8: Rename fifo8_pop_buf() -> fifo8_pop_constbuf()
>    util/fifo8: Expose fifo8_pop_buf()
>    util/fifo8: Introduce fifo8_discard()

Series queued, thanks.


