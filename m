Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA2CCCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 13:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGdqp-0006eF-C2; Wed, 05 Nov 2025 08:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdqn-0006Wd-83
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:47:01 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdqk-0003Pf-U5
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:47:00 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so5148038a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 05:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762350417; x=1762955217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxrXHHC3/5F7YgaA3N69oT6RADgDFMo6NhEAbU0odQM=;
 b=N9Bd25k5uODyQSRjAJWm9mafZxQOP9s3FeE2jVJJplla4e04oLVRxCov60L+1k3o+e
 OBWGJ1ckjAvup5E0AoWHcUWuMXPdsIj1irknhRo5FfdZvVtd8BSKlTGHs0wCTX7oyKaj
 YSQRZGNHql1NbDMQxfwauxX78eR7zpXACzjXSgi54NoMboF7aKKRCBjoynArcwhfnvqg
 Nhu8hIx0fSwNJb/okHtxqOzimO15EPNAmiRAM9RvnXEOZzDzSYKB3ita9omfA5pqba9Z
 arL7WUoy5a70Qn+LouSt69l6EUwoNZKLfzpwXEvvi/g9jM9Re5A4EUWx39FboLZh466g
 d9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762350417; x=1762955217;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxrXHHC3/5F7YgaA3N69oT6RADgDFMo6NhEAbU0odQM=;
 b=XmTWCdLLVMYh7dDy+iae/wGu3Kf4Izq5S2SoQowpHchmyXhwUagHC3iPnIFd1vda/n
 wFjpMDhhp7PI8OTXmQDB9ufzkv6I1R19CFERfh+DLiGmKE7n/R35Uy3hURPn+w2s8vWI
 hYXLG+T/5S8lIJ7KEJ4BS+tDM+nDshoHIU7FtAGFhUSOP9lr7lORABit/HZILW8OoBFW
 0h9D/GqZF7n176CGeNccE36q2E1JgIjrGT3R5erRJHkEUBNmYUBrdgsOz5oIZpgOBv11
 PWnMd4Y343X5pHV9iDxnP7BNVqCf3QcN+K3i8P9GnFaVaA9wIuUC8/AhbKL1QPuK4Mg+
 Yp6A==
X-Gm-Message-State: AOJu0YyXqz1vMfDXFkZsOMxfwCpWcRIFrL4irea9i8pTFEQLuXmlZI5D
 JPhd4S0bnuubcG0QMFT1sPueXIxJIhTGpTskrBLAYKdf9l7nXYxTvn/qxQJgiru/4BQqYFVrPz6
 fEu8I8gY=
X-Gm-Gg: ASbGncvQTZ1agnBat3ckpukI5Bwu7hHli0LqjhX0/N20kPjy7zVygX+j4BsFhbkubqX
 FfxveKmfu0+5J5o4wMaHbSs/6XGjevJ4ThENHS5OA72H9CxVyOuMLFJKtvTzTKuFgAkZEmh5FaC
 y4idML3StnvwKShmeNBmujwASQHQgm5ssz6VWZBcGLM9vI1tYw7Yt0Bl2VcuDvRSMZK3IXmEsnf
 ZZC5iQ34WkS63jKirjRNLZUFlU9g545dtsdzsOwV2I71K9VP1nGiZlDJ91s/cP7En3ZV4xEiC8/
 r0IQHbutB8RqR6DCozRVE0ntuaXi/x13CBmqxx1NqDWRi4aSJwfzlNOoGFTtJxYmE5VVd3UjErG
 Brw6G/js0u65OczUNwzcLFECzH73p5oqAUnR9xFzHDb2pdcapxGl3PjfmaA/IJSpELio6ZF9PXm
 QihH6Cb18egVSxKEeORLEOELKhW80=
X-Google-Smtp-Source: AGHT+IFY0kxExx86VNMvqUkeBIiF/3psCzsrAaxQ5hX1XRlpf+RrMT53ZpClhCcrht3rAIlhY/jbRQ==
X-Received: by 2002:a05:6402:84d:b0:640:36d9:54fe with SMTP id
 4fb4d7f45d1cf-64105a4cce7mr2811752a12.24.1762350417326; 
 Wed, 05 Nov 2025 05:46:57 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a721f1sm4761013a12.32.2025.11.05.05.46.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 05:46:56 -0800 (PST)
Message-ID: <e7bd713d-7fc4-4d7e-a136-c4bf5edffc90@linaro.org>
Date: Wed, 5 Nov 2025 14:46:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Cleanup patches for QEMU 10.2 soft freeze
To: qemu-devel@nongnu.org
References: <20251104163102.738889-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

On 11/4/25 17:30, Paolo Bonzini wrote:
> The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:
> 
>    Merge tag 'igvm-20251103--pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to fdeeb448458f0ed808a62314b57974ab16d3592e:
> 
>    rust: add back to Ubuntu 22.04 jobs (2025-11-04 17:13:25 +0100)
> 
> ----------------------------------------------------------------
> * rust: cleanup Error, add &error_fatal bindings
> * rust: do not add qemuutil to Rust crates
> * rust: migration: allow nested offset_of
> * rust: add back to Ubuntu 22.04 jobs
> * checkpatch: remove bogus patch prefix warning


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

