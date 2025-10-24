Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03571CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCEhR-0007QP-O9; Fri, 24 Oct 2025 06:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCEhN-0007Q3-Tu
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:07:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCEhL-00018U-UU
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:07:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-427015003eeso1742313f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761300421; x=1761905221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+d5w4Ms3ArSrHS6Jir+aMx3sEITvzS9GTWVVIsJYVgU=;
 b=HHhrotjxYeHa9Wy8Aa+OTVPBYKFiGm2xKjrl4X12kJwoSrK9yzywqEQuKY2Cl0/hKe
 yXUh7fsn/+pQ6vqSMkpECuXJPpkSzfX41MaWiUdSQgt7HknKSKVjcYo/HErAE+4NW/l7
 AoAd8ITZyG2r8u0K3avhQq5HFxfJtKeiei5GDukvWai9RUrmfynT8gMI7CCp06VlekdG
 GjaVu33uspVSFDjCQlDdXmEQf9+tf1A+/v6ZYIFlsMf7lK/MgahGrs/jU5CQ/MzkKTP0
 invMTJN+JJms2WGoSb2xBN/Z+mlrP5x62zbdhodsvkSouQ8yhjbIOWD8ia6K8f9xmxyJ
 RkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761300421; x=1761905221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+d5w4Ms3ArSrHS6Jir+aMx3sEITvzS9GTWVVIsJYVgU=;
 b=BA/41zoSJ1M2bi4saMcIrqTRbF4/eZOFjjhsxiJMoFF+W5/Iakyl+8fqATmvrqJe6t
 cjYA+243rnEPcLCv9G4GxdqQBav32Jv4r2RPs2Z7s0DfCfmmXOSKio0KHMOJs/fYd45O
 w2N07jalczaa/ynqig+SYM3YcC5PbrvOyJPD9NoF6YMFNlsvVGLgW66j51Izpe02x4TV
 Q+lxjla4q5pIcG6Jm8SUBRXGu6Uh9Q2Q5doJkoDzaGXamYVn8cXN+mlToIq75px1ptAL
 t1dWsFGY1kGu09+0d0MWUG4VucblNKz84cWX4Ihjos7iDKfnrwslEN1+/4GJOpAeM88i
 XG7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBN77qLTwCroITDpbbyt8Xg8g7UYZJsY9qf2vqcG+ezPjXZMEkYmA57jsF8nqT+fNLY2TvFgOOk7tj@nongnu.org
X-Gm-Message-State: AOJu0YwLtCkRKSw9vwfmCfF3cKvsgySKbpDETCfj4WWnCTEo/5PPhT5e
 9ubzEHVSrLM4NlUJAzCIiut6RUBUSbzbi22Tpbw+sbTe1282TxpOiFOMA7vtJbXQ2k0=
X-Gm-Gg: ASbGnctRX2MxVBVFuFrJ/YWOx1mRqS2ZfQn7F/kZI8t6dIDoRB9IJFR1EXA3lu+a1Ql
 AUAmj1/UD24Goo2dW8EEJxMkPPOO+0/P/bvnQ//4FK1ouYckQ+0yCsBAAZKnsbOn+w/iC/aQEDa
 wX5gJkWbHNC3FyeT2bL/6UdnISAQBCVwK3C42cWSqPvUnWPGvnpN7Hg0krCXMr8VymkaafYWyID
 e/gYJaosUKwX7/lmWucWUNPaaWaPffao2bWBD/a5AX0bX9ZiVRjpR90AHgUxvNON8lOASdwVuP9
 9robsNJMugnxIp4TAaLxGTEjatJ/QZUP4wrViRKE8mvYDNn53YO8dp3NTaOrEKBzjUOGCNgriV2
 8MrrO8/bgzFTeJPEU9zoqAf0FT+cEhv9pUD4nb/sJ/7yXYfxLkf01y5hWlC3zEOaNOkX55T+zHF
 9GLNNjkHrut3NdzweGwW6xfPF/iRbCvfYQRDBs0+IiZguN/yR5Q5HXsg==
X-Google-Smtp-Source: AGHT+IGQg5z7ZD+AxY1MbjqzzDXM//GUfZhO6dh1Wg06V2gDGRrlTBGzurtiENNEz4DCFKUntlzwiQ==
X-Received: by 2002:a05:6000:4008:b0:428:3bf5:b3bd with SMTP id
 ffacd0b85a97d-4283bf5b663mr16872652f8f.35.1761300421475; 
 Fri, 24 Oct 2025 03:07:01 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ebf82sm8598714f8f.42.2025.10.24.03.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:07:00 -0700 (PDT)
Message-ID: <5f54bcb6-ab0d-4777-be1c-ed50903f2333@linaro.org>
Date: Fri, 24 Oct 2025 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 2/6] core/loader: capture Error from load_image_targphys
Content-Language: en-US
To: Aditya Gupta <adityag@linux.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 richard.henderson@linaro.org, alistair@alistair23.me,
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com,
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn,
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com,
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-5-vishalc@linux.ibm.com>
 <pg226vepbq7c5ckwguxpysgirdj4sydgfl54c6wshed5ifqbvb@lu5rv4gaxokb>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <pg226vepbq7c5ckwguxpysgirdj4sydgfl54c6wshed5ifqbvb@lu5rv4gaxokb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/10/25 11:44, Aditya Gupta wrote:
> On 25/10/24 02:56PM, Vishal Chourasia wrote:
>> Add Error **errp parameter to load_image_targphys(),
>> load_image_targphys_as(), and get_image_size() to enable better
>> error reporting when image loading fails.
>>
>> Pass NULL for errp in all existing call sites to maintain current
>> behavior. No functional change intended in this patch.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> 
> All tests pass for me, and changes look good.

Does that imply:

   Tested-by: Aditya Gupta <adityag@linux.ibm.com>

?

> 
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> Thanks,
> - Aditya G
> 
> 


