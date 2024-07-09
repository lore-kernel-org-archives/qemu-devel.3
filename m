Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA91C3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRDcm-0002xO-Mv; Tue, 09 Jul 2024 12:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRDcQ-0002uB-4V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:23:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sRDcK-0000Xk-EX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:23:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367ab50a07aso2940456f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720542178; x=1721146978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Axp5eJASDeHFBaveeYPoKHphZh3l0ST5ik8OBfZqjN4=;
 b=adHobx6LIQJM1iAsHDMKekRDmwoszX1RmTl+79pzncYRx5jiCE9NNMlJQiXLYRFVn9
 XXfH3F00PlKJQT4VkGpuVY/OLvnt5usbz4Mg9H957TF2KLQ9OJsOSoxJnewEYM8elIVf
 8FYvqLRaYzl4ffY4kKk4YZ/1oqQUld7m0rP9uo9RH5cWLpL7feY+u4+EbV+Fobr8HyGS
 j2PX4kS8H0R+zojlHyUu7eemGDZTW5V/vdaEQg7IKvHo1rsc9C3zutMOMuVdQ/o07YJy
 LKS3Ey8IHFHLkX/1J3tn1PAE6P50H/miDJ/GcMpeaIYp4h7ErTtzXuRpO3bLS5ATou+R
 jxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720542178; x=1721146978;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Axp5eJASDeHFBaveeYPoKHphZh3l0ST5ik8OBfZqjN4=;
 b=lO+jzYXmgh/501ds2Gm6bnLdc7IyU1yYRfUN2xvUgnKRi5jFb3a8Ca+IpuK9hlzMVp
 YHKpz3jbosgLN45LOoTUGPlYXDVCdtaTgw9o42EuwEcUzcARbDcUrEwxarlcOU++dUIP
 Y7xEEhhnB3gpJOBly+pSq5N2g3JLHwk/PlSSuQMEAta0u300Zb2LS/evJBjx2cNRjDMH
 pUCqbd71MGpbiBqmKdwxZQiZs1BHgkCrbLvSNd/vX1LPn0/Ejt++EMlscF53pAm8AVWW
 5TxBmHAMKoXQAfzfzolEh+mu5QDf8dh9R2rd00vwFsp37DsaLLWnun7W9veDf98/Zo9l
 dJag==
X-Gm-Message-State: AOJu0YykIB/eeeQVFFzOVDpb4vH1U/XPDgqYZVxrJipqWm4GTCQ6HJEJ
 bGMuDY0vfZpdh87Xz6ZecmjLNLOyWxj6tGlkhVmwOXUl+pjyb1b9x+Oy4RrAI/U=
X-Google-Smtp-Source: AGHT+IG/EkCBQITvlvNp9qOtJpqob/UMUczGvi52Op2l3L8G584OSWHnntHOGaHk/+a+KAqfplEI0Q==
X-Received: by 2002:a5d:6790:0:b0:367:9988:7300 with SMTP id
 ffacd0b85a97d-367ceacb495mr1679885f8f.45.1720542177901; 
 Tue, 09 Jul 2024 09:22:57 -0700 (PDT)
Received: from meli-email.org (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab199sm2978685f8f.106.2024.07.09.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 09:22:57 -0700 (PDT)
Date: Tue, 09 Jul 2024 19:21:30 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v1 1/1] virtio-snd: add max size bounds check in input cb
User-Agent: meli 0.8.6
References: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
 <Zo1GOxXWjmxSBDPv@fedora>
In-Reply-To: <Zo1GOxXWjmxSBDPv@fedora>
Message-ID: <gd6u8.cj0fkm4a5di0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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

On Tue, 09 Jul 2024 17:16, Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
>Thanks Manos for sending this,
>
>On Mon, Jul 08, 2024 at 10:09:49AM +0300, Manos Pitsidianakis wrote:
>> When reading input audio in the virtio-snd input callback,
>> virtio_snd_pcm_in_cb(), we do not check whether the iov can actually fit
>> the data buffer. This is because we use the buffer->size field as a
>> total-so-far accumulator instead of byte-size-left like in TX buffers.
>> 
>> This triggers an out of bounds write if the size of the virtio queue
>> element is equal to virtio_snd_pcm_status, which makes the available
>> space for audio data zero.
>
>Do you mean that the guest driver has set up a request in the rx queue
>in which the writable chain of descriptors only contains the status? Is
>this correct? Is `available` indicating the available space in the
>virtqueue?
>
>Thanks, Matias.


Hi Matias,

See mentioned bug report, this was found by fuzzing, it's not behavior 
from existing drivers.

Manos

