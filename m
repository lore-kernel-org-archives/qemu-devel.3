Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FAAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkaD-0008QB-1e; Fri, 19 Apr 2024 05:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkZw-0008Lj-IQ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:30:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkZq-0006VN-JS
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:30:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-346b09d474dso1694529f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713519037; x=1714123837; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6qhPXL4PnQS82mTIgagr2m5JZBSAsT6rdH2okAy89c=;
 b=qsNJms8K4F+E7xA4xMRiFaqnBkGQs9iG7kSel65dpsNQdId2TwWZg6cZ4oUETTWMgY
 m05dxEZXaMW0cw0cWn0NLQAE8PcyCh41RtnzuGFdBC6pg3cis+/0e1XHDYBNclM4o1MS
 +7vl4dzg2ZkAGIHcIhwYnJhZB+xpQbZuFttigw6cjzixhiBUZ7fwgAxQ8ZipFT2V74JX
 HOeBIwmrRKlVyrloMKCcEMQIALA6pwC/C/utD9qIAyqtW2W9gWLDPkE1QrwqCcc85Uzm
 BWy+AzGRKtXFJyH1DWuVxpuD/iUk5Ey5GEbS6Ig9XUFaGghCgU5WOrvsFLWEsvgCw78F
 DHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713519037; x=1714123837;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i6qhPXL4PnQS82mTIgagr2m5JZBSAsT6rdH2okAy89c=;
 b=WwrO9IYcpJufV3HO7CyY1nvsy8uDy3AE6y57feOb7T5wRLP72tO3aIfgwpapW1eaTg
 iZ0+f2rf/dyawrkmolduaI84DtGb+3TaXNZmOBUlGBTlnBlVTbhZbICmMh+7S8+fwXEH
 4TpWMnWQYs3PWq3BaRMv+dDWWAW+nP2NL2sqElzwfqyx6OzF9F8uLbelCqgzJH1DXhm9
 yizcSftmlu8cBUJ+OplCEBa/3RgdiwuACWtYqR6eRcSN9A2/6xbWMdSIZ0PsIhdWgXSl
 0j/jg2g2XOHaqCWtDpNAPV4gvTWUnUD4nmi560wtLi5Rs7wVXSVzstHlk6K2iY7DRcbK
 OIfQ==
X-Gm-Message-State: AOJu0YyEM1Huc8Wc1YC28GqJNe7kH3442IfMW1Fx01jfs+gcf/He9+Cd
 85bmIw6XdCS+gQqBzxfm16bXFw995/3DSRnyj4O0R7Jx0CyqoC2Q98sKdy4CewM=
X-Google-Smtp-Source: AGHT+IFqGQVLSxUeT406OGtW85TBADrHqAiWjbfpmA0jyh/fC9efzPPjoMkQUXIqjjp/Zcx/b4W13Q==
X-Received: by 2002:adf:e542:0:b0:349:fa94:ef18 with SMTP id
 z2-20020adfe542000000b00349fa94ef18mr1268139wrm.50.1713519036926; 
 Fri, 19 Apr 2024 02:30:36 -0700 (PDT)
Received: from [192.168.235.175] ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a17090627ce00b00a525669000csm1956997ejc.154.2024.04.19.02.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:30:36 -0700 (PDT)
Message-ID: <5e020420-f18d-4536-82a0-f53bf0f498f2@linaro.org>
Date: Fri, 19 Apr 2024 11:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Li Qiang <liq3ea@163.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: hw/virtio: qtest failure in virtio_init_region_cache() on macOS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi,

On macOS, the fuzz-virtio-scsi-test triggers
virtio_error(vdev, "Cannot map used") from
virtio_init_region_cache():

QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/fuzz-virtio-scsi-test
# Start of x86_64 tests
# Start of fuzz tests
# starting QEMU: exec ./qemu-system-x86_64 ...
   -M pc-q35-5.2 -m 512M
   -device virtio-scsi,num_queues=8,addr=03.0  -accel qtest
qemu-system-x86_64: Cannot map used
                     ^^^^^^^^^^^^^^^
ok 1 /x86_64/fuzz/test_mmio_oob_from_memory_region_cache
# End of fuzz tests
# End of x86_64 tests

virtio_init_region_cache() is not documented, is it OK to ignore
failures that way?

Thanks,

Phil.

