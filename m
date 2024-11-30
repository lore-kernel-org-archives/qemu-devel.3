Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17B7D735F3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGqc-0004Qf-3q; Sat, 30 Nov 2024 01:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGqL-0004OL-Ho
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:20:37 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGqF-0004YE-Pd
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:20:34 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7250844b0ecso2167234b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947629; x=1733552429;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UaU0zOmZ0YAsn6aSvaKXwr7t6amJcWxMlrxWLIfv/DA=;
 b=Acrcms97wL2b61kWh10SRWWr9Aalck37P3b8Pec2gIOMYv7zTKZuGFYMT9yh/V15GA
 eB5x7v2LZkhJOiR/Bw1eFWSDmaQ2mrdy+PzkDiEDlzvtWtncU/3SFCZHvVB2P3RVq8kv
 nGjA/hskohvkbsjHYLNv17Bs3fQommrc72eB+vNVwAxuOqLvbhMZz5ris0dQzMXQJYWi
 HwhdW9By851I6Iooqem174mbzRgLGeW8y9gyTpBmubA1SxO/2h/t8uDLoE+PPXkwJQ8c
 Bm0DABxWlbzR1yRZapD2xEiRyvUrdWU2/ULZimIq3Imc/j+hUlYpDzEatLcUzSLPsV9H
 bl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947629; x=1733552429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UaU0zOmZ0YAsn6aSvaKXwr7t6amJcWxMlrxWLIfv/DA=;
 b=QpSZtnV0HC46HrKQ316lV7Jun2PtrT7Sf5ksZOwQoRYAWQ0lxxdsbqUfWEPdq4zdhv
 +rbI+HljIpy0HsDnGic8HZafuXyR/tcRGs1NR032K0UenrjKUbN8uSFM53/GVClOJpNL
 VRoOkoIug0bCDdAH/HYVsus9yQoXf/IxGmr12ort61rzO/u8+GBw02L8eCo0yDTDcFeb
 YduXlARg8je/wZpx2nyUxhuKmKyaZAUlTBOjbsZhcih/OTDF56J+8zYnbaS0bnEL6ulm
 fcNbQII9eHfWXczt+JrNNkqdU3zTrB4G8OeTSfG2n5ZkEqJyfc+AuK8LnHEfnNuOB8AJ
 ob+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPb4hF1Cfm67gFKEBzMXLBZqp0w7+Hp5EZA4KHHHdao/D9mSNK2tQIitf7dwzb/4SrGz8qUQJVSv3T@nongnu.org
X-Gm-Message-State: AOJu0Yx/vTWX0/Zkkq63HSg6RRMCyCtLexlHQS/5uTUSDiVWnwAnmNqa
 3NnTa2vUqYxQRkkFtCwsrKD2aovpxxraFc1ZpmllZ/i2DcQK1jxchhHZvHFcfZ4=
X-Gm-Gg: ASbGnctw1resRlUNuJkXUQy3RSOcnvfltG26GgC7gPhokdOo+XmtncsdsA8Kb+rLA6f
 zhLvaPljxqr2JxEFkIdvS8+XSk5Gx/I+OlIJKdv0w+YEi820X6PiVv1dY4yHZEcDhE9w7zsig6G
 M7CpLEa+BxMOK3bPf5J1LKLuj4UAwMOUmyjY60+rpWyNEPP7/SpBtpoWQC+9quKz3Q00oGbkAq9
 NvB7ftpIs8U3I9seduBQKi7RWrYzg4/vBD5DXcQCkDkUXB1Q+ulq9lwjCh0uxk=
X-Google-Smtp-Source: AGHT+IFQ+XVzhuNnk7Hti8MqwjGeN/nW20jZod/aVsCJJ9GiW94uSdKVt84qmOWnGFPLxiyC4OABjA==
X-Received: by 2002:a05:6a00:4f88:b0:724:5aac:1687 with SMTP id
 d2e1a72fcca58-72530142fcfmr20927802b3a.20.1732947628647; 
 Fri, 29 Nov 2024 22:20:28 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725442c086csm4374934b3a.189.2024.11.29.22.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:20:28 -0800 (PST)
Message-ID: <1e437634-ea0c-48cc-a2ab-2ad3c6256fc4@daynix.com>
Date: Sat, 30 Nov 2024 15:20:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 14/15] hw/block/virtio-blk: Replaces request free
 function with g_free
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-15-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-15-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/30 0:25, Phil Dennis-Jordan wrote:
> The virtio_blk_free_request() function has been a 1-liner forwarding
> to g_free() for a while now. We may as well call g_free on the request
> pointer directly.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

