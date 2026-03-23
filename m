Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86971D58CD6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 05:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4YJO-0000uM-5O; Mon, 23 Mar 2026 01:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4YJF-0000u0-Gt
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 01:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4YJD-0007YI-7S
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 01:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774245517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cdE05zo4n+w5JWHOGSIB3goiT+Mjq0ybY+NAXSvstmI=;
 b=dQyX+P8eXW90PYr6BSCJaIIrn8gMI0fKBfjuiiO00bpns8/uQxLkh1De5uF8x4UJpkBZkL
 2mEm7yzHX8axu39Q6aUcqskdW5AI13scPtCVYT04nGAJ6x9OR+8la8n47hPLq+vWHH1Lii
 b3TV84e5y4LPyFh3bHUSCeTYVCbd/SQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-1COBbq7jNOSCD6yqSVrKVQ-1; Mon, 23 Mar 2026 01:58:35 -0400
X-MC-Unique: 1COBbq7jNOSCD6yqSVrKVQ-1
X-Mimecast-MFC-AGG-ID: 1COBbq7jNOSCD6yqSVrKVQ_1774245514
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43b3da235dbso2721167f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2026 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774245514; x=1774850314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cdE05zo4n+w5JWHOGSIB3goiT+Mjq0ybY+NAXSvstmI=;
 b=Q5J14UYalcd826DZD1Oqs66WlCvY0BdkDIYTgvnxwQZDpXgAeFUT0MtjmvOi7MDHKH
 CXKqHAUMyxyy4MYJBNMoQrcc9zZ43yuq1rSNGisIkNScnlxWmWW7WxhCA91JJ6Q8t0hF
 8rAqrpUvviKu3gE+xVEr+pE57+a5mkGiGVHAIm0d1MqfKMZ4Is5UXqIgp3/OHce2qGu3
 ARtAzKI9ZZRkJCaDS/CT15KQpWrY9ROgIqw8WINxEHVsyB/U/g94LieP8LWt23s78vLB
 E4VrA7UXBRafNQvEabUx0gbVJilGXc76F/D4aThHk+rIK+C9Z/KvbcTsA2UZ+m4Ze9vw
 KKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774245514; x=1774850314;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdE05zo4n+w5JWHOGSIB3goiT+Mjq0ybY+NAXSvstmI=;
 b=SHDsJYUcbi7tG0mHsNvqTn8CGAslv93jpoNUU8g8bGKSOC/3G6StptzWXQ5ULfiax8
 H3Vt04qzBQqjuz7pGv15/OMqMtGnawViBiUmxZieJx+q+JQc4aRIXKp1mps3HY1lzSsv
 2XpvU5AUJgK4OWDv6EtvgogsmO3zph7QHXi9fbcPWwe7hG4E+MlZwMaP+ZMhRZIOiW1d
 f11JxtWtbw/RJ86QGJUNZIR5cuvXoI8Dwt+F8lkUZsj6+j34yWGylpJe8vKTbXCPiNS6
 BPU84j7NqO8bkRXCwmuoalULmhSlY2l+szJZObrRfSnZdDgnk5Q1QliMGEI0EJ+7cv/P
 809A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBaQP9YZ7AKKd0k0HG5i/xK2jRPBHqwCh/ZbXzQfK7faCJbE2iGSPxo708CFcNVn+xSmFUzWbWf7aA@nongnu.org
X-Gm-Message-State: AOJu0YzawrwRNrH/os/CMVdEBvQuttJTvLLFJu90HiXK0miHQLeqQoVV
 T+IJ4b5j5tDHFyqzExVTsAAkhZBzK5gMxTNi5bMcxEXHbaEkpJbzjv2Zqsmm9qsHGLRbzebZEWl
 aQ+QjHmcYiqJRPC/U062RD0ZMiouB3aZrbkjzElx3IfrbI6VOt5kdgYxe
X-Gm-Gg: ATEYQzxvYpiP+7wzy1Sg9NSM8N/3CqkLEb4eOVLqD9fpnG8AGW9AO+IKVpbvHnbQy1k
 A6KJ6/Y2LUtyN6v8IC81hwbbSffi4Yq+JlBzfdAgaqh4MNP4QUhAqSoizmDhqhQjfYVinAYz4qO
 E9UkH2pOwuqOdatofbord0J5rn8G8vLJ/NMlLd4DJ0Up2XsNGD7WZYD6vcc1SFTnBDl3VjdrAbM
 L1Tv11XTYU2PzXuotYAUUxRCJVhTN12IrxqkpwcUm51ZTxEjSkaURou/bSw4iAQuYhhVCtmrCJN
 eeGFki9XQ/Y+QVuU9COVJ0SYMBp2vIhpWTH91Jkn0eJ8yrT0Jqk32nAkfh8PKqlTaUc6aTL+X7P
 ruz6OQBn0mPwQaFh0nw==
X-Received: by 2002:a5d:5f56:0:b0:43b:3dcc:8b03 with SMTP id
 ffacd0b85a97d-43b6424ed46mr16284699f8f.21.1774245513901; 
 Sun, 22 Mar 2026 22:58:33 -0700 (PDT)
X-Received: by 2002:a5d:5f56:0:b0:43b:3dcc:8b03 with SMTP id
 ffacd0b85a97d-43b6424ed46mr16284681f8f.21.1774245513483; 
 Sun, 22 Mar 2026 22:58:33 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.47]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6cdfdfa9sm17533447f8f.9.2026.03.22.22.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2026 22:58:32 -0700 (PDT)
Message-ID: <3dab071a-2763-4564-b791-4939e2f7d383@redhat.com>
Date: Mon, 23 Mar 2026 06:58:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Monitor address printing
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/03/2026 00.38, BALATON Zoltan wrote:
> Hello,
> 
> Noticed that now addresses are printed with a lot of leading zeros in monitor:
> 
> $ qemu-system-ppc -monitor stdio -S
> QEMU 10.2.90 monitor - type 'help' for more information
> (qemu) x/x 0
> 0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
> (qemu) x/x 0xfff00000
> 00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000
> 
> I suspected maybe the recent changes around 42cc2028a43 might have something 
> to do with that so I tried to find a point to bisect but looks like some 
> build system changes also broke that:
> 
> $ git checkout 42cc2028a43^
> $ configure...
> [...]
> mkvenv: installing meson==1.10.0, pycotap==1.3.1, qemu.qmp==0.0.5, 
> setuptools>=44.1.1, wheel>=0.34.2, pip>=20.3.4
> ERROR: Could not find a version that satisfies the requirement wheel>=0.34.2 
> (from versions: none)
> ERROR: No matching distribution found for wheel>=0.34.2

FWIW, I think there were some few days where you had to manually install the 
wheel package to work around that problem, e.g. on Fedora "dnf install 
python3-wheel" should fix it.

  Thomas


