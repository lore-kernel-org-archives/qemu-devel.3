Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E69FCDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2dy-00061t-1w; Tue, 23 Jun 2026 11:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc2dm-00061N-TM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:02:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc2dk-0005y7-KB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:02:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c88eb5e7713so2292676a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782226935; x=1782831735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MIN0aFROdvzw/HSRo6TXyOQ/wBj+6PHJPIWvJXKdtsI=;
 b=sMC5C0BExWKgvDZ8KbA13Usz3U41rt5S9p7/eILVlPF3D7ilsoxutRPxh+EbqOoBCM
 08sdwfHAHJvZYg7kzLl/tZuriJCzgi8temz8yd7n3a7LHwKQGKRi7blxbHwc7aYw+1MG
 DJi734LlNTljQXpVYrZh4FdvsXK6ncM1amiAEPy3UhoTZ40Hw7PMk1evYlXOC8vMmsO/
 h68dk9yOxBN+57EfXvJPXUk78FGtLn/Omy43NTQC4G/cG3b50u/eqyTwWfRIpNYIePIZ
 k60tbIqtHIbzAnAcnKs/iioT/mJofAl6YbjGAZhxjkNcmAhiBuBlkJ1463xkhZtd/QMk
 TRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226935; x=1782831735;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIN0aFROdvzw/HSRo6TXyOQ/wBj+6PHJPIWvJXKdtsI=;
 b=KXCuWof61RPImivLPJItUvn1JyOi4r/dq1ARh0m8B3/sMD6fSJvDlE94eWN0r++TO4
 SC2KreradWd9Pef7J8Ae/XzZIAc2aBTR9+XwKoHGOX0+11KTzVKxEgJshTIn34zzHL4b
 Y/7oZeEMvN5HixtRvQkBhGvKqeKPglW6vtL+Yi4rquMT1qgaEldt6wxqxFhvApGA8b6T
 q3/UeBWEOr1QGnNSf5odC43BXZx9vktCAB2n9OcPhQQLtvw6RAStFNou/PRZSREUQhvT
 TKi9SSnKVaa3DT63klNQ2I59a7IO1BZ+nCeYyiRUKZM41Je6dig8fMR21y3PPP7TWXVC
 w4yA==
X-Gm-Message-State: AOJu0YzEHYXd8MWJlBrbPPUF8RoX7HqNaFGSXph/ci/VZRlwYYFpjqAB
 Yq3LqZxU3Iudc6brEtJI3QcSmBHAVmnxWf8/IAw+M3aAtksXlhW1mN6K90Brdy3cLZkn0h3Tntr
 MfUYw
X-Gm-Gg: AfdE7cnVi0y1E40IsZxM+R027SOF+/qsVceIkQO9XGdC2zBnBxEo4wDZ1mmDrQFdpi7
 ZG5Vqqa53pYv0UNapetsPzg9KLQ0pETnHRRyzJvX+ECSHCLQhlfHBVFYytKEG4G692zQ8OFzNJr
 ASHVv7iy4b5akvHg2nD93AJwmv1sXzNc0bSlcXr1h7TPOwKqqZjFO94/2VDn49IfE65pAV++wqP
 HFbQQsGu7+dgqjaXlirR5pW89L/SRubhQm6GarKg5zlCQ9Ivwt8/HY9Ym0LQP4dzXKKt5v4xPD5
 g+cWVFH6RZLlpu8nrKUXQfjY1/YMPlUeE7Jbp24A4IJRcQRuZlglkMuEFdtBuwzTQGab88VDI/N
 HIKeANMLVj1nzH9OFc78empXp6Vf6lRUtj8o6Ho1wuUKAs5nNbIf5AF5k1zAOLvcylGn+D5/4Ua
 mi5Q7bfFHbgHYwzi3cQ7O1x8E23DFUuyhdT7BtUm7TDquH6Ku2USYA/MmA4g==
X-Received: by 2002:a05:6a20:d50c:b0:3b4:8cc7:c6fa with SMTP id
 adf61e73a8af0-3bd14f53736mr4292463637.10.1782226934441; 
 Tue, 23 Jun 2026 08:02:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc326c487sm10285416a12.12.2026.06.23.08.02.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 08:02:13 -0700 (PDT)
Message-ID: <f84c28fa-392a-4fa8-825a-c85a7fb4c1fd@linaro.org>
Date: Tue, 23 Jun 2026 08:02:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] target/riscv: make some riscv_sysemu_ops TCG only
To: qemu-devel@nongnu.org
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-6-daniel.barboza@oss.qualcomm.com>
 <5bbeb7ee-2826-453d-b50c-60240df47954@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5bbeb7ee-2826-453d-b50c-60240df47954@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 6/22/26 14:30, Philippe Mathieu-Daudé wrote:
> On 22/6/26 21:31, Daniel Henrique Barboza wrote:
>> monitor_get_register and phys_add_debug are TCG only.
> 
> They aren't... And get_phys_addr_debug() seems mandatory.
Indeed, that hook is for gdb, and that's supposed to work with kvm too.



r~

