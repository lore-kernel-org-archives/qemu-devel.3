Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE54D18125
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MqT-0003mY-67; Mon, 14 Oct 2024 11:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0MqL-0003kX-M8
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:18:45 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0MqK-00006M-3A
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:18:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c9428152c0so5484676a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728919122; x=1729523922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ixBpo5E4UD6mW/MDwWlu7q2/zraG8h16eYt9r0GoG0=;
 b=rw9q6E4pz6CXlp2+GNTE5ye13HyGqmkbD/i/jbjmCyaoh1dGtkSckbMyiFF5VnO0FN
 3NeqOceBQ2uFZDLcGSD9YT4jZJ9keERVaTE8DSMYWjnVhF9+5PvAH9Skc4ZTog6GYnY5
 jRCghsNzkqtHfdbfWbwWd4juVaGRojjrTBXY2Yp+rY//+1v3Z83niXqKUXjwUP62VH3u
 6QoaaALZcaUigFSNjeILigL9QXRr8HStti8YzQCyx17fxul7B6sLfo/yQeuGgnFnv5Xg
 Q63ZyxVX0+TMuahgnWPuyfgj93jouFTKPl0+q5EtMn+f5hliJe6dVxIEkO2gwkXjlyxR
 91Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919122; x=1729523922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ixBpo5E4UD6mW/MDwWlu7q2/zraG8h16eYt9r0GoG0=;
 b=fCAnjusGc2h0aQFd5iqiZGjX7BbQFW8Pz6/kMQs+rIYOmTHVghwLvGgyi+2HhJTZ9Z
 EaF7bKG7nOGUnlrMJ+J3SY0NvAhYLHroywBf8CfV9yGSd1A+F4MX7KyPOBg37DbwWTOa
 Ppmm8WiG3xDCDmzDsbZpUX1EuUvyLNhQz1MsIR6Ja++Lg8Zxq+XNnZnhbOZlamF4NFPB
 rp2tJ/LdQYAM4tUKHrbfFbkWSz/DKRkCBkPa4XTqNKaY789Z1WkObWlC6bYcSULJJ+Tk
 ml6XDa1Dy6DFgNy7wPZLPNbxWZUujoUsAc+Nb4e74mRxLCsclXQm+cee4q2zZEorpPEI
 7Auw==
X-Gm-Message-State: AOJu0YxikVjK5LO9v0tpgrX15lFv2SJfhhSeZsogG+CbhgRFkWm+C/BM
 V9n9G8L6EowZzy8HS6JizJIQWugdyxxfPVBUmyY2MtOWa8LHHKZOrhu/nX4Fx2Sx4oXLSVkCUcS
 2lDhOQ5eF0y90Xj+o1MAYD5esMz8Z88Af2A5xIg==
X-Google-Smtp-Source: AGHT+IETeuODDF4k7x6b0xLFoMJZlxMFJCQXSO7JH6cguRoQbYpeulqQChRPimCiZTtR/q65SjIJVSH9sWUBZianJZo=
X-Received: by 2002:a05:6402:3487:b0:5c9:2cf8:6a34 with SMTP id
 4fb4d7f45d1cf-5c948c728a2mr8381239a12.1.1728919122230; Mon, 14 Oct 2024
 08:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728299530.git.chao.liu@yeah.net>
 <211e7645ae2c04c361345514655c1ba0d4e10488.1728299530.git.chao.liu@yeah.net>
In-Reply-To: <211e7645ae2c04c361345514655c1ba0d4e10488.1728299530.git.chao.liu@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 16:18:31 +0100
Message-ID: <CAFEAcA9vmvoyjq=grmNEMHPtWGws50RbXJq=qcoPiHgmVYgPBw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] xilink_zynq: Add various missing unimplemented
 devices
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 7 Oct 2024 at 12:25, Chao Liu <chao.liu@yeah.net> wrote:
>
> Add xilinx zynq board memory mapping is implemented in the device.
>
> Remove a ignore_memory_transaction_failures concurrently.
>
> See: ug585-Zynq-7000-TRM manual B.3 (Module Summary)
> Signed-off-by: Chao Liu <chao.liu@yeah.net>

The list of new unimplemented devices looks good. However
we do not want to remove ignore_memory_transaction_failures
in this patch:
 (1) patch 3 says it fixes a breakage if we stop ignoring
     memory transaction failures, so we mustn't turn off
     the flag until after that point, or we break bisection
 (2) if we discover a problem with turning off the flag,
     it's easier to detect and revert if that is done in
     its own patch, not together with the addition of all
     the unimplemented-device devices
 (3) turning off the flag needs to come with a description
     of all the testing we've done that makes us confident
     we can do it

thanks
-- PMM

