Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD305E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkxM-0002bf-5Q; Mon, 09 Dec 2024 16:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkxJ-0002b1-NT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:06:14 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkxE-00067f-Qv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:06:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434f09d18e2so23980705e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733778367; x=1734383167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SHpsg/5OjerCEGTsMfPsuGvDD8VlqxErsH3nBqaj/KA=;
 b=x6j+zsigNh72S9dofxQh3zinEEzlQ55piVvmF/hEO0HN2zgHs1Ie/qnG3Bk186yDi7
 1uWs8kogm9QU1C6fvbTEIKhNDB2ziSvXXC6s14hUWPzE0hyzQhbt8/sSxvwem0GG7d8Q
 2058pfWf8egR0b7YwLOYUH51Do+PQdb+m0Ib9fwcjRVMV5K66O7Gy4VPxt+QGtnGrxyH
 DOuCd8W0Gh6fhdBjUOuq7aB+UsoA8YIz86ZkWouQeBNA6EuPNMnen39CuwoVpMVbI7Nb
 UVnvJhrBXtKkT0U5FFjpcWvRniU2uRSWdsg3KKZ9+6Tn6StKhkFGTlYljXkJjaoIhvWJ
 Jb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778367; x=1734383167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SHpsg/5OjerCEGTsMfPsuGvDD8VlqxErsH3nBqaj/KA=;
 b=EUNhBkdipESF9tTaBKnCyZNDaeWYMKeguaZlW9RRrElBcwrq964kMMYbJOHOo8iPHj
 ZbE4l5oaluFMjTBIPqK8ZKfmLZ5RfAPkK+YWXnKj3LTunUYwE79VAHgfY7tIfmUwA5iz
 j/w7XWn31W75lrZXGEbZVNqIwB5YN5Zs9XVUM9At0OE0ARjsxmw/ttB7p4oNh6g+G6tv
 8NsB7SNQB1EPvp2gxFThUbuktMx6feSmJpMKrkNmPqfjkC2Y5p5ndjeNVbEUBxTpBn8o
 mV9HD0f44ubfPDyBUTWiQbpa3KvRzE1UMLG73HgaxqtLH2PDKLvhEraDcs5nofhhw2fM
 f8Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO9rA1QkEiwaNnZ2oBWAAjQ2qhrcUMQaU8FopzBiWVQB2Jd9ViI7CXaoLekEqD7/4qwTDx3uLlf6Sn@nongnu.org
X-Gm-Message-State: AOJu0YzzOz0LQy8cOqZcL35m6dO23VA88s5pWCAUjyJCWCBQmCmxzXHo
 xF/J5pdkx0CewFZTRwlVm50UPYc480CaF+Vbolm6b7Lf7EJAw9FOmLClOm/vkhk=
X-Gm-Gg: ASbGncsk5Uvy+Itq6megmTASN8I2E0hVv4CEyE3+IHGv0ABEh2GTRb2NQJJhA73RxLz
 bL/d2PlfILQUf9ZzI/xEzGeYHVQ6C6+yH9blH/3vCG200DOqpNk6GUU++VAE5XLHhHcci/+1l4/
 LolBb/Xh+BEp0EN87T/iD4o1RFSIn927ZRDNWjSfhcpcgMReFPOFTBOF/2oAUVVIzwWM+/giawg
 8izMustPFai/vP15/u5NRyBjibdrquBG7AJlZN5cK8U+uPoZOwHhM9W2ncBVgFJQs4WhG/pf+Gk
 /rgCYpVEnhxocQ8UX4IDfTdg05r/tBCZ
X-Google-Smtp-Source: AGHT+IEIu19wAxNWgAu7fwODPNn+aLAqajxmDaGqIOu3At5fgSe6ITGwBTPjKMQqhX6cgHN9xLI2rw==
X-Received: by 2002:a5d:5f48:0:b0:386:459f:67e0 with SMTP id
 ffacd0b85a97d-386459f687dmr1085729f8f.21.1733778367277; 
 Mon, 09 Dec 2024 13:06:07 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f1125e69sm87500835e9.32.2024.12.09.13.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 13:06:06 -0800 (PST)
Message-ID: <b8a4ed66-22b5-488e-bc63-e8d960943685@linaro.org>
Date: Mon, 9 Dec 2024 22:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tests/qtest/virtio-iommu-test: Don't pass
 uninitialized data into qtest_memwrite
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241209204427.17763-1-farosas@suse.de>
 <20241209204427.17763-5-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209204427.17763-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/12/24 21:44, Fabiano Rosas wrote:
> Valgrind complains about:
> 
> Use of uninitialised value of size 8
> &
> Conditional jump or move depends on uninitialised value(s)
> 
> both at:
>     at 0x5265931: _itoa_word (_itoa.c:180)
>     by 0x527EEC7: __vfprintf_internal (vfprintf-internal.c:1687)
>     by 0x528C8B0: __vsprintf_internal (iovsprintf.c:96)
>     by 0x526B920: sprintf (sprintf.c:30)
>     by 0x1296C7: qtest_memwrite (libqtest.c:1273)
>     by 0x193C04: send_map (virtio-iommu-test.c:125)
>     by 0x194392: test_attach_detach (virtio-iommu-test.c:214)
>     by 0x17BDE7: run_one_test (qos-test.c:181)
>     by 0x4B0699D: test_case_run (gtestutils.c:2900)
>     by 0x4B0699D: g_test_run_suite_internal (gtestutils.c:2988)
>     by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
>     by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
>     by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
>   Uninitialised value was created by a stack allocation
>     at 0x193AFD: send_map (virtio-iommu-test.c:103)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/virtio-iommu-test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


