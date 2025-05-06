Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81611C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJEd-0008WI-DK; Tue, 06 May 2025 10:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJEX-0008Qu-A2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:25:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJEU-0007uX-Tb
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:25:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso4162410f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746541517; x=1747146317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HGN7LZW5h05uVTFFgG0v/lRX9EQAdrNJAa7Yx+upFeo=;
 b=MeIV+cB+UaEig8px2p48mMczLvOCVK1kl2Vk6HLuKZRFdUr93t0ZhvuD6srRWd9Zu0
 WEopOUxeDRJQSNmsJBCKh//pzBwuG2yQJyyOyM1bDOBq9JZ4+/ejYFnYzVtbqKLkerfo
 TdpsexwtHdpBv0XPP4l34jjBhG9WcH20hUD6UZZux6YHU/NW7kAgN6/XRmh1dhmtfh2G
 Sdhyo7+M7C95Bo03+9S/trZf5zONoaROyRq6Q3g5CcEDva8YQMKsxQyC9c4LwiKLVCR8
 ZZNhXmaw0GXP1wCmAXEvGSecwAnPz2EkR+HGb33/3YXL/06fWKu5FqwGifBVofvBrPQj
 2P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541517; x=1747146317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HGN7LZW5h05uVTFFgG0v/lRX9EQAdrNJAa7Yx+upFeo=;
 b=VIR1mOQTSgl/hXX/9wm+mOpv+qaIWf8NaHvlhTKqX60dHjZDL+hiU7dtQa1L73n6C/
 sMGpvigQO9Pv5isHLzcBldeyqEovrIpreB1/MHl4CZeEbh+TDan8C2kzsJb/aQEnI+rq
 DNJNdegAnBpo74LvG3yLwlLKVMZSES2PNthggT6aMV36yEperJV12Nog44JuCGPM+BGz
 2fNmafEEjE3LShaRCewGajFHb0wMkX3Mjjy0DfHAlSoHDtI/VuqkNzMzkRH+GtG2vV4K
 M7MYfQvBrjwcBkWptyuR7m9xDYrH04JUit1Gub2ZGBbNiluwq+B19c/r6OB9FV5g9VZT
 sJRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYBQXXHK2tpZ/3pdWLyo72vYYyNNFRqP6bT/89Hp8AkVoheoEyypTkZbsdwO3UKd8bUpeyD12ry65O@nongnu.org
X-Gm-Message-State: AOJu0Yxegc1PHDDay/kamS6PwNfsS7NQ6aZwyl7HSn0j+XcggbLdgkoS
 NX4pV1qQUifnU8AnUW2tYPQOKhhaFw+CX8Qk7wdPamq0FQMV9iO7FsD8x+oxZPI=
X-Gm-Gg: ASbGncv5rVRxkOrUT1aQTjkFeKxRYpedGrSjtMXddotVQ5nstWt4VAvt4jaQq/l7UNi
 1gFQ+4FvBkmKK7T6v4xJt30UuGC8NdjImpM0tQBorvlaKNx5u0lJtnOeeAcPhVrGTbq/T4qXIya
 o+zKuzHZr4q5GMhPMF2iDOUHs4NE2EZIsQw1J2teNqTZIcydpDe/jSnPRf0vbQn6Qd7K9CqCgt2
 gzRdkY2n9oJJQGj/jguS3d6kCb3pYKatzoImgiJnMMIMvD2/k+yFP+WtGVtSrApP0Oq3bpxoAAP
 RTrAMEJA0dD4OiZNlvrJGDkY5KeTm+Y9jiqMG54u3BkAzcE8oY8VINAjBqzJSs9bCb1XwLkqMxm
 5fIhfkA==
X-Google-Smtp-Source: AGHT+IH8Th3VTqTsCira8miNmJ0inxSWw1PRqIeruX7b6+5vYhmxGtjWxhyLvdjDb8FZIWvrFdppBw==
X-Received: by 2002:a5d:5986:0:b0:3a0:90bf:b9b with SMTP id
 ffacd0b85a97d-3a0ac0cb312mr2650627f8f.8.1746541516984; 
 Tue, 06 May 2025 07:25:16 -0700 (PDT)
Received: from [192.168.1.82] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3c49sm14116726f8f.39.2025.05.06.07.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:25:16 -0700 (PDT)
Message-ID: <eb980229-404d-442b-add7-59a050b135a8@linaro.org>
Date: Tue, 6 May 2025 16:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/6] qom: qom_resolve_path
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <1741036202-265696-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1741036202-265696-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 3/3/25 22:09, Steve Sistare wrote:
> Factor out a helper to resolve the user's path and print error messages.
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   qom/qom-qmp-cmds.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


