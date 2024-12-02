Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4929E69E8C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICRr-0000rX-86; Mon, 02 Dec 2024 14:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tICRm-0000rD-OV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:51:07 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tICRl-0008VH-2u
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:51:06 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2eed4fa2b3aso931905a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 11:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733169063; x=1733773863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TaoMPp7nh8bDTtoPLZD0uEOqa3cCYYQ/w3vRNa4ptRY=;
 b=taNUcPE+12Ju/3Vl4T4g8OjVrSrNfHeNPIPLxPrJuOUBNwhubb3s/qy/bhjTVIBuXM
 YrO0/O7OU/13JxgnoGtAigJy+g7xpxC63zy8oLnFRM9sxNqHXtqrXhK4nHt684OO+P9H
 opvXVrI7Q41B5QbJl3qnEby6UrPAet+fAdZCN20oOiQ8SuZ1LbKoWxyW0kaGYMEhftIp
 i4BrF0CA50XPkl8spMNc4zt9E5VePb7UlNjvVQCIxcIywOhPZqYCvpIh5+4QC8ovohSb
 kuASr+FD2i3lVHRYfDKKbNI71NgGrTdMQLBnfwbhHebeWDonYctXHuaCAZfhGgsZiHir
 kcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733169063; x=1733773863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TaoMPp7nh8bDTtoPLZD0uEOqa3cCYYQ/w3vRNa4ptRY=;
 b=EeRCks96lyu9Ks4H643FvtCvaIIZvQftUEoRi6xK8E1VL8bRZibxLN3hMPNuWrJrwL
 aAePpWcsSzRU6xbe5dF/Iyrsi2XzrPjzEAeabEh6nC12zJp46WEkl3Wmh73tP74dmj4D
 gZe4ZU7dk2Ry1h2bK4xeBC9LSm027q20JbPV3wMzxa0XivBEgnK+bypHL+oKiWdcj79C
 7bBlELPEKNuoiL0qJZKcQcfSjPsh4G1wnjw+ENXdDGHAGP2SR5zK90ko4kl+PQk7aym7
 m62tIv2mMvWze0Zgg/LWLTDIqY3m2Cu/wUMbN/w9nbIW56+OMtPNmcZjmUj6G3txXAJb
 NRSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZZUIJZ5Mwn0gazewccEqxAvxoC37hAx1+oF7J17hdMr1lT+sP6YX5m9YM6rHjhMG665tB++saM1Wk@nongnu.org
X-Gm-Message-State: AOJu0Yx0tl5WZNh+2LDH6VLNLr8EwroGsh8qY+Y0NWYMSNsgXf3h0/g/
 Lt5rLi0UdhLJDiessRPXrVZOgN64hGpK34NWkoqf/qdQHE0sW7HqKVlQh8tDsB0=
X-Gm-Gg: ASbGnctSVg2dmpVloRc8pi5q6zcIMgDsx3XFtjnZJZabXQD6jN/R1scM3/mxH4fMXmY
 AjrTEzbmOEN+SuIkb2c5DVRH7L7tYR+jdT/3CABYDVzIoWUmltoaJ6mmS9AtWzyRXYi7IV6pFn0
 gM23S33bEs6E6IYGqNl+1e20qdtgkFo1Hu9guFHWbKnNCtGUmUbO3leLA3uTT7wLyX0GoAEzRd8
 zxVe0oG7giWPqKcACEw+8evDzfBw7bOi3zY8zk4RHObDteNcfMTsOzY/eogfSs4h8NxocG3+boh
 sL1qClYHKeHVLslgvd6+
X-Google-Smtp-Source: AGHT+IEqIvcb0Xh/f6RTlIJLpcFHaEkDX/ksgKSvdLE+U0cQAVgjL2RZ6w2X+6NLT+0jk7tA8WiQug==
X-Received: by 2002:a17:90b:3505:b0:2ee:b8ac:73b2 with SMTP id
 98e67ed59e1d1-2eeb8ac7528mr8723568a91.7.1733169063302; 
 Mon, 02 Dec 2024 11:51:03 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2eeab291c06sm3256063a91.22.2024.12.02.11.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 11:51:02 -0800 (PST)
Message-ID: <6bf49e96-8939-4ee3-aa4c-4ff5ae5e4e21@linaro.org>
Date: Mon, 2 Dec 2024 20:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3 for 9.2] hw/virtio: fix crash in virtio-balloon and
 test it
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Martin Pitt <mpitt@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241129135507.699030-1-berrange@redhat.com>
 <24ae6e7a-1cba-4898-bfbb-5f5d3e5c3256@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <24ae6e7a-1cba-4898-bfbb-5f5d3e5c3256@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/12/24 18:05, David Hildenbrand wrote:
> On 29.11.24 14:55, Daniel P. Berrangé wrote:
>> See patch 1 for the background info on the problem
>>
>> Changed in v2:
>>
>>   * Add qtest coverage for the crash scenario
>>
>> Daniel P. Berrangé (3):
>>    hw/virtio: fix crash in processing balloon stats
>>    tests/qtest: drop 'fuzz-' prefix from virtio-balloon test
>>    tests/qtest: add test for querying balloon guest stats
>>
>>   hw/virtio/virtio-balloon.c             | 16 +++++++-
>>   tests/qtest/fuzz-virtio-balloon-test.c | 37 -----------------
>>   tests/qtest/meson.build                |  2 +-
>>   tests/qtest/virtio-balloon-test.c      | 57 ++++++++++++++++++++++++++
>>   4 files changed, 73 insertions(+), 39 deletions(-)
>>   delete mode 100644 tests/qtest/fuzz-virtio-balloon-test.c
>>   create mode 100644 tests/qtest/virtio-balloon-test.c
>>
> 
> @MST, do you want to queue this or should I do it? We should get this 
> into 9.2.

I'm preparing a PR for tomorrow; I included this series
amending:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1c4abed65..51e3a79b6bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2227,6 +2227,7 @@ F: hw/virtio/virtio-balloon*.c
  F: include/hw/virtio/virtio-balloon.h
  F: system/balloon.c
  F: include/sysemu/balloon.h
+F: tests/qtest/virtio-balloon-test.c

  virtio-9p
  M: Greg Kurz <groug@kaod.org>
---

Tell me if it isn't appropriate and I'll drop it.

Regards,

Phil.

