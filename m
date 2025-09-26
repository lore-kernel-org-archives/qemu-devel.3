Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A00BCAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22XH-00059F-HH; Fri, 26 Sep 2025 03:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v22X3-00057h-0n
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v22Wx-0006AB-HC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758870364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNCfnANLeAwQXGjgF69kjGnId8GtSPdw9TTyCKI3akw=;
 b=TMbcyIfMxzigjwYdhQdpKUMI25czhXiON/FUuV5eBQHJaggN6Pe9g/VId/YSfZwgaO7Q4T
 9cqszEyMY1pbTNAGqS+kn5APydaL4xJ7VU+ccO92yKPUTEW+W9BJRYOXmvGGCQcm/MWEsR
 dBnLvYNrkvF44JpaC5pzBdLt1f0ZKO8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-QAf4PmSNNPSTQz0EGWU3Iw-1; Fri, 26 Sep 2025 03:06:02 -0400
X-MC-Unique: QAf4PmSNNPSTQz0EGWU3Iw-1
X-Mimecast-MFC-AGG-ID: QAf4PmSNNPSTQz0EGWU3Iw_1758870361
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-40fd1b17d2bso645956f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 00:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758870361; x=1759475161;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNCfnANLeAwQXGjgF69kjGnId8GtSPdw9TTyCKI3akw=;
 b=lkARl84hNSHkSVAhdBr9VACrdmfB62HvBvGojmQQTS5+lQbx17SGIVSozEA0NywAq3
 BpOCxLcnI14zyyNUqggU3kT7sj1Etczphxcr+U0FT2GOdNfY0hZIlA5syjtlkjsyTLHV
 205qCH5eWbVSMPEjrTIlTfnamTrsUO/eQQbgGev7F1hI8jqdRS3Qge5ku4SJOjrvA2ft
 MUqnUSnHYTK0NDDGzoBpipFoTorO3Phquv5JDlkbdVQBs1zMkQzvGVQf9uJwJKnbm/Sk
 N+FyMrBylMhdgx/lEfisXWJydO8JcBtdMSESJLbM3FtvQJui6v6sdB47CKx6BPJjyjet
 6AWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqBn7SNVLS2NGxUKTeXFb+pgKdJGiUQvUZEZw8gwVDrNwdBOjJmzqcm7dnazjKCvhqF3lkU9WaGIb+@nongnu.org
X-Gm-Message-State: AOJu0Yw2E4T3G3TJ6szxAhuamA6QcK7DxaxSd2acWIfRTFTz7vRQuDGm
 px24X0g/sp76G7hfXfALkVyd6WYw1JgF6OAyOj76+JxbxeFQmt+5qLmVmItfXuXGcGLIGztAFxO
 fK7Z28haJnNKeF9uXDn1d/q/HM8J7Zo/CaSoM/kWWs9ab8VHcJYoZQgcT
X-Gm-Gg: ASbGnctpnPruFDqMs6XC04FxlClyZJNysJbQm6MAMFsmMqsizlJC11CqmUIfauD/dKo
 DqNGjdqlAKhhqtE017AlLXKyhF/61/i+Fsf0uJN4Tf+xhw5TH3DkB+9EqhWjtfP9hOPfjRXBJl3
 8Iphatxj4uaniLRy664OONCwaLzOgb4K9opXlrvnZHB8DISFUGS+v/z5YS/Wvf1r8ozNm5U2507
 yL5sBUVHYYNYmHjQEoEOl3Von+XefmVW2G/LcnZJvcMCb/1HVRKg25k8aAj/p8zguntb/qO+mTY
 nF13fGI/SKVRmRIPDymDkp3Gl1jUYebsVYJ9AN75W0nuuexhZzt15l7VcRaW3oDylW2wyvKtKZi
 EJ379fw==
X-Received: by 2002:a05:6000:26cf:b0:3ee:1125:5250 with SMTP id
 ffacd0b85a97d-40e46ad0128mr5681540f8f.24.1758870361141; 
 Fri, 26 Sep 2025 00:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHSmxQo8RYkDA+BfWkpEuOL66BATPqKyDtRnIIUdOhCtIIGFL8GlcHq5V/nvkEez276L35fg==
X-Received: by 2002:a05:6000:26cf:b0:3ee:1125:5250 with SMTP id
 ffacd0b85a97d-40e46ad0128mr5681508f8f.24.1758870360731; 
 Fri, 26 Sep 2025 00:06:00 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2965sm5784474f8f.55.2025.09.26.00.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:06:00 -0700 (PDT)
Message-ID: <551bd2c3-7366-46c4-ab2e-1bd4a5ed41ec@redhat.com>
Date: Fri, 26 Sep 2025 09:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] tests/functional: Add GDB class
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-5-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250926051542.104432-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/09/2025 07.15, Gustavo Romero wrote:
> Add GDB class, which provides methods to run and capture GDB command
> output. The GDB class is a wrapper around the pygdbmi module and
> interacts with GDB via GDB's machine interface (MI).
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
...
> +    def cli(self, cmd, timeout=4.0):

Please consider that tests might run on heavily overloaded CI runners ... my 
gut feeling, mixed with experience from the past: Rather use timeouts in the 
ballpark of 10 seconds or more, even for stuff that normally finishes within 
one second.

Apart from that:
Acked-by: Thomas Huth <thuth@redhat.com>


