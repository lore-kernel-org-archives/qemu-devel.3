Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA368CAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1rqj-0002uI-Th; Thu, 25 Sep 2025 15:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rqb-0002rb-Qb
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:41:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rqV-0000cl-Am
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:41:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-78115430134so50773b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758829295; x=1759434095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KWF7dYDz3Kuuo7uE3AqpQg0oa/WgI91fAuksLxrlHOI=;
 b=rCITKKy972TAHUiqDe2LaHf/oTF/sMOixd8ZVNIdfbsfXnciXcxhqRkuRQdVv8pVr4
 ThvR3RSD8xU3Q7x5JZ3HHW9DmxCmvzLOgELCkcZXYDm7UXLrQkoEPFG0Cesncw6zOBgg
 5Pst0wKC8Qy8J1PvTbsE+KP1NI76Iyl1dIaPw6MwF6mbj0l6S0L97RUJNPg9YkSMIpA7
 QFJpeOjzAz0Da47D+uS6geL9r/eNvhedH1nKVaRbJN2nilOkwwTl71TzmaLBsrJIgCfn
 gX9fVO0YWu6u+igAp3wLiAlMH0UUBPqmBRmjnXVEIIuXw8g9L8wnhnKwtcuvRIyb5V1j
 YNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758829295; x=1759434095;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWF7dYDz3Kuuo7uE3AqpQg0oa/WgI91fAuksLxrlHOI=;
 b=VKUtUe64uNwubaR6CHrQZO/FCz0YjE2fhyZAsxI67LdugI70eBE73HceegAmwWyJSt
 WruvP80z7JCP/q8twyrggRSgMqI3xXDqr/Gaqleb0zqVyCSga4lDiLKgNGFyMCW9FtNY
 6+drPrXEpZRvQW2T4W5998DBTCaoNZ1vOMeDvqSILTOBi9Wcl/rJqXOX88bwUBTZzozC
 5yB+LjYbwUxkjgl/+r7BGBo/UgkSZBYgB0fIv7+pd9ERts8EnhDqsG0GyrtxYOHsp03Z
 lufQa9KeArkHg3hm5T5GF4/pCE8bVCQs35+HHysfl5vSpoRKvtuZioMt1UXU6O6v7Ea+
 do8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvgZgJ4nNCRBqNphWA8uAGDLnq5GwiptuVHdoF8utmpMCvsm7b3x/40egNZLKWMOqPAgSpGmKDxEiZ@nongnu.org
X-Gm-Message-State: AOJu0YzBKJbZjjL9N+ebArYSD0O4qQ7xnDSOFoA50GFXzp5/e0ahmpmb
 c5XTYOY0iRy8Z53XZxfIEzGRmRDqrHP0duchNGvDL/uLS3onDrb94n5baEEP5i5F3D5XuSk6YPd
 Shfcz
X-Gm-Gg: ASbGncviKxEN/jLSMWTekvjK3fu1NutyQeW/oHkVd+AVCuX90fDRZoY6WBjnAxfkVD+
 443NCMnhinxOyAXlBA2H+KqRINepI3oFomrzLtBCmYd3Z812vQAMbyEP/Z1JhGjLFFcc2feq2X5
 Vr6E5fSJeVnzaINRisUB4irwvstY2dCqxdQQdgB2uHTKfaEknnIp37cM2w3XnxxNHmq7v4mBCTz
 UgLrDKlHFBKRHzXD4b3wlf2zqrtTqRS0KxvY+kGZZ1WEDRhDvHFSa7HSBtO4v2B1yWB02cZQAyo
 vtU83qpw31AmURlAd7XknXSLznSpAll5Ps+W560Y539ro2Qe/Annpjn1lYZr/9oJSSMxyMteHxe
 xP5iiKbINEKP5R96y8VFpow/g0SrAaJyWEgxz
X-Google-Smtp-Source: AGHT+IFp8anHItOeMFnQQIXkudQYYOeYMRgr63kmR4raIoKErwKvKdu8E4meRh5IZnOuCP3MxmBhrA==
X-Received: by 2002:a05:6a00:2e99:b0:77f:deaa:3570 with SMTP id
 d2e1a72fcca58-780fcddc9b5mr5461740b3a.2.1758829295526; 
 Thu, 25 Sep 2025 12:41:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102c2b70esm2511835b3a.101.2025.09.25.12.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 12:41:35 -0700 (PDT)
Message-ID: <180302d9-002d-4188-a100-fbcac7a7aadd@linaro.org>
Date: Thu, 25 Sep 2025 12:41:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/23] monitor: introduce monitor_cur_is_hmp() helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-15-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925094441.1651372-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/25/25 02:44, Daniel P. Berrangé wrote:
> Note that this is not simply the inverse of monitor_cur_is_qmp(),
> as both helpers require that monitor_cur() is first non-NULL.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/monitor/monitor.h      |  1 +
>   monitor/monitor.c              | 10 ++++++++++
>   stubs/monitor-core.c           |  6 ++++++
>   tests/unit/test-util-sockets.c |  1 +
>   4 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

