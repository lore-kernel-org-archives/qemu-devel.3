Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8294C5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woK82-0004ul-FZ; Mon, 27 Jul 2026 08:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woK7n-0004u4-3l
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:08:03 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woK7k-000695-VL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:08:02 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66804667af2so1866546d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 05:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785154080; cv=none;
 d=google.com; s=arc-20260327;
 b=PRpMSHIn5KH5J09HX6MmJ6jW+Vlfu2Wpnr70Gl2MSVrCDgf9g1Tj7euCV1upV1wqT4
 qasLQK0sZCx8WxDROVUQDxz5NFvVhowSCmzxT4d3KTeqP39Cgy2g5vLJjiYClk7rKV9T
 VxEqdbozWBMbogEX0MqQhPrTx0Y6bijgNXeP5P0Z5Caw5mov4uHcegqqrM2UZVmtVTl2
 8u1XSMIdKj+c4AjRH6Q0XBEWX5V/H8Y/Mj4k0uUUUycZznBxO+NsyVetlLT7DZEAT9OP
 rFfTcyRWDk7Y/0MLwpgaqcTawc2BvX83ZQAKq4dOmV7u0hJaYGKriutT+tsWX/qUSimk
 6q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gkmJj+PSYlZ/UYhIQrLFlknwuPIlAfsGZizlk1PsWaQ=;
 fh=QazvCYQNrXtIXwWKbwmq33oJnLFfD87+q17Sk4VZwuk=;
 b=YaQ49t7L4B6swNye6zGrN5W45ZU/UvYszSZtE1AH/ac8d6x1N1MKSToGeUAAQmcglY
 WMTnij1AEX8nHfLKzUPPUhmEIozw1ggAQ0L/LBG9tA4xcrZCimg530hqK/WcLvw6vA5o
 B+18AsNsvMrT1jhc/HVDBDj+aNiwjhPM0Z68nOVUX+j4f/cFG/KhCLinSOCKThUkgXex
 F7i7FhnMz0WCDpR4ByMScfqe75wDqBLURUP2SqLCTqnMB3AFryJhfeEaJm5JYCkA8Qhi
 wOtjqcTjJO+lCyrZOJnccw7DlnT1q6ZnJYKZZot4MLhbsUruMrq5htjnOS/SR/wsidE0
 tucg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785154080; x=1785758880; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gkmJj+PSYlZ/UYhIQrLFlknwuPIlAfsGZizlk1PsWaQ=;
 b=bgUq4U3hYATb7dcTl2eg7JGp3RRhAenORMc08wmNhMk+sdJH2VrlpGU1fjqfXAi8h6
 vhhhJcioA9Jr399mGxNurPioZWlCaqkaghnUM/AbEQyvxMZLX9C/EFriQ272+5MZpufC
 77cAzOm5dXzqr0WfqOMZrHvd0xH16+fRuJXbxS5rxA3EkvW0q38RkYn37rsW7d1JgMCp
 vbzPHt6T1WL9sRmmvT31cRCkDzz0EFJfiuc8ezOLTTVCMFRpRAb2Hi0d9rt9QNfk8K0s
 C1b4yVENX19tsPchOcAKdv0uDkrz4/U7DhAPkdSdpWYjVzI7kh9ZIvTm9uTc5bGmDyvP
 OPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154080; x=1785758880;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gkmJj+PSYlZ/UYhIQrLFlknwuPIlAfsGZizlk1PsWaQ=;
 b=QAtRWdHAyUqgVjhUtRVbm4WlQRxZMUC1JHVregSYbukfSUz36yZIN4WSK4f8G3nPkV
 9cwhxRPUQV5h8vgJzykezek0sSlEpje8np+EKXpGwaC7+sEHVAjYAYEmCYtmFgxysFEm
 UyuNVx4XKf82CcBdxdJmtVg6aEkmIAslZd8Bx0VnOYvbfM4zsIbVZNQsPatinTJFxDwS
 boOU85YQlLp1562YbFjYQjL9cvkzK36zWQUREM2HAWJkWPCnil7SLIt8LUZAxGWUZKXy
 CTF62uHgUiEsHTnVu2dV1xxWjvAr5++zhOJnnin7uNCTjmCt9DhlnwNKKdRIiRbB0inI
 Xi+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPOdnzsWv6HzuMzOWsVRalL0g+TtkdY33E7GpeF20YDQE7PXIKCjxC7aYa73B5m9wyQqKbueWHEG1I@nongnu.org
X-Gm-Message-State: AOJu0Yy/uGnx9ozFqUSJCMvldl5POsKx27zl+NboYRMETMtazSh98F18
 b2syThFMvSvh9VSIXxcL9k6HWSOM/aLqQFTncaNvD2JjpJHpauJ5AodN97C3eYVnzRDNE9Ui98m
 qLeqXr7iS5KQNmdZElZRhMjYBKk39YiwGG6J4/beMOw==
X-Gm-Gg: AR+sD138cGN3YOEZRB/HZuplDnfY6pa8qbEtM2fXnaElT6EJXW1lvFItskT2LLrBnpb
 P8vaaJGwr0dvGK38wsSh7SpXotlBOa2Clc2F7Dm/gH+p7OQkN3RXkeSQgnLbkatZtHRe3BHECKf
 vfWbHpiGepMUEhQoiynI29WU8DxuSSSD8CR0nS1zVifZlHQ9aLmQmO2wb4nvDcVXXLpE3ESkZ7Q
 dXdZHxKcPxOX0IlHBp8Xvpg6HJFLgDWmcOfT727yGEEdHs8vbRycNFIqSHdrUa3FHgOj3jc57Zm
 uqmyDsz5imC9vo+4tTP3oPAn2mnq+sv5wOX5Qrc+4Xa0Lw==
X-Received: by 2002:a53:e023:0:b0:668:9148:17ea with SMTP id
 956f58d0204a3-668c7ab6386mr1545973d50.59.1785154079713; Mon, 27 Jul 2026
 05:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-4-gshan@redhat.com>
In-Reply-To: <20260727032649.145381-4-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 13:07:48 +0100
X-Gm-Features: AUfX_mzup-mtlBO4ev92vW0h4hcoH24EJ--or0sdvnyDcjb8PhbjWdaNAFDIxrU
Message-ID: <CAFEAcA9-1ATVURTH9hK4a0YcgKy3G41PnYdO38c8UQjsJHUqhA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] system/memory: Make ram device region directly
 accessible
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com, 
 mst@redhat.com, philmd@oss.qualcomm.com, richard.henderson@linaro.org, 
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com, david@kernel.org, 
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com, 
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 27 Jul 2026 at 04:27, Gavin Shan <gshan@redhat.com> wrote:
>
> This basically reverts 4a2e242bbb30 ("memory: Don't use memcpy for
> ram_device regions") to make ram device region directly accessible
> again. With this, the bounce buffer is bypassed in address_space_map()
> when a ram device region is involved, potentially avoid to overrun
> the (small) bounce buffer.
>
> Reported-by: Julia Graham <jugraham@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

