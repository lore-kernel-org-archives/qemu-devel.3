Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7A9CCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 02:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v72RQ-0006wa-3K; Thu, 09 Oct 2025 22:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v72RN-0006wQ-GR
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:01:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v72RG-0004XA-1w
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:01:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so1560282b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760061655; x=1760666455; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZ+YTXoXxDfos6hEvgqSAEBzYEkyHnckX/N1c8lt7Y0=;
 b=M+6lCmSUL9P8gmLlBEWqek+sfz6U/IPtLV0PZRFRKsUj0T8o9BpeJRyz5eYAOe99RB
 aG5ojvKavVVFXwVudFLZel2wvoapKXCUY8YSyuw1Is1l5CfsJ807lfzO0tiN6q0T56gb
 Owqc5RMC0Ls3TSFq3mOOq1c3uvZj9FPyMl1ujW5lUGDQ58Ju+nmsdRzjLXLQeNjWSqW9
 9U0nZyXsORkyZ+kAvchZUbwxRl6qE5CoH4FPvjTAVdbYTdFN1jjXG5rb3VzPt3+VUkr1
 enl1ioZp3MNHfB3+TtqC747jh58JvrnCp19bz85neTRfuQe9GOz/Qabz6CF8HtU1vq1U
 mKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760061655; x=1760666455;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BZ+YTXoXxDfos6hEvgqSAEBzYEkyHnckX/N1c8lt7Y0=;
 b=ThzDLq7Nof1Rq7JAVJPLsbFISNMe5RaHqqyl5lED2ameCOyOhIDoTtsCx5+04hMwhG
 TpXozBGkircvhJ5NmrzvVviBvQGQ7Y74yeKKp25yz3y9iqq4Zu2FBzP/jFRMEj1Pg9hj
 CzhcVY6SQWJWQAiCZaM+JOHaqjYY+LtaSHPUfSAaCiOh2YQ+Tk25l0F1aG3a0DITITJK
 FiKQ2MfDlFyCoc9Lih6y1s4K+GCFsgj8mrH2yrGKOYSFZMdoGcip9NkKzIJDvuBCfRxo
 5ZrtaJiShjVVRrFeu0I3UFCjasx7mi3ECgktAuIyaHRe+ec77U7I+3VOr6M5LiQfFTvS
 O0Bw==
X-Gm-Message-State: AOJu0YwikbAFfSqK0ccFHafej4DB7+S7/f8NNJgy7VYfW7Y7IJnADSm5
 8mdbMPJjepEDR3BSV9zJMIM/Tkse6Bf+xXGadM8I/Gi5TtciI3UE/CKWUEgpGnegAWz9J9DS6RH
 BcwKc
X-Gm-Gg: ASbGncvoPH+VNZ8Kt/rD5T5eMJDANnZOmkkquLSktMt3qvFTHhP3IphIWtbexGveUW3
 hEuIifPlymwnwon3pyMedzXgj2PJu9jfJ4qFKSUN5qklAMq9RFd33fxQ7R+rIMvwcjd7vRWkgJb
 8ecSy4/flgGyqkuz//ZrzPPRnW8NpYdZZZWtBjU4aQl+3B11TaqGp4W+FGzFehSWVAmrXINr/0h
 Y3E991pp1I9FdsXJEc/+a8hfH49v46PjiLmIsNs5gEldc3tAfODb7QCJobiUr8EOV7rJPoruyea
 LNwm4nAAyT8NSBV2jJ0P31OuZZIor4PRdHmtHh4ShsVllBCjJVAC1f/pjpWQ8H3zQU8VnuWAqPx
 oAQCblKl/luWKs0EBkL7n86DTyEYI8Vfa6f/4KhPCrI/n4gapS5pVcfVxs1TOmvey9TXRlHwzTw
 ==
X-Google-Smtp-Source: AGHT+IH8b32D+RUk42jiblMogUEiQHgKtugUmU/9QkoYENI02mbKznVHAsCvGOlcvxX/pxmD8efaHw==
X-Received: by 2002:a05:6a21:790a:b0:32d:973b:e02a with SMTP id
 adf61e73a8af0-32d973be2aemr15789698637.30.1760061655030; 
 Thu, 09 Oct 2025 19:00:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df47919sm883133a12.27.2025.10.09.19.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 19:00:54 -0700 (PDT)
Message-ID: <25e9f54c-81eb-42d8-ba62-65fad6ad8e79@linaro.org>
Date: Thu, 9 Oct 2025 19:00:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eric Auger <eric.auger@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: IOMMU group for pci root port and attached devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Hi folks,

we are currently trying to enable the Device Assignment stack published 
recently Arm under QEMU [1].

Our test case launches a nested (Realm) guest with a vfio-pci passed 
through. The configuration expects a SATA device and a root port to 
attach it.

-device pcie-root-port,id=root_port \
-drive id=disk,file=out/disk,if=none \
-device ahci,id=ahci,spdm_port=2323,bus=root_port \
-device ide-hd,drive=disk,bus=ahci.0

We notice that iommu groups are identical for the SATA device and the 
Root Port, which prevents us from passing the device to the nested guest.

After investigating a little bit, it seems like ACS capability is not 
present on the root port, at least, it's not reported by lspci -vvv.
That's a bit confusing, because reading QEMU code source [2], we 
definitely add it to the root port (and the code is definitely executed 
at runtime).

Any idea if we are missing something obvious, or if there is another 
issue completely unrelated to ACS?

[1] 
https://git.trustedfirmware.org/plugins/gitiles/TF-RMM/tf-rmm.git/+/refs/heads/topics/da_alp12_v2
[2] 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/pci-bridge/pcie_root_port.c?ref_type=heads#L121

Regards,
Pierrick

