Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F7ED735F3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGlh-0006w1-MN; Sat, 30 Nov 2024 01:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGlT-0006au-OL
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:15:35 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGlR-0002lQ-4b
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:15:35 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso1273655a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947330; x=1733552130;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zsppy5mifOqwG1NxW07VQAvccK4JcXuvMoQenyGT+Gc=;
 b=ViOOAz/6GAW4HBd3SpXLAT0eVtuaglYcucFnTWXAwnstIwKS1o0b3RJ9VfMzDxBFrS
 henavile58fat4S0ldfcIt7bDzYwd17S6em4KxEo8PSJ0QNSp/+Z05J2y1Ler8GL7kkD
 leRq8KUC6W0SXymD0mY5tbix6g8G9kmpb/Vcoce8TQtNULBml7CZRIGRV1odsV8gSi5Z
 qhry41aHueA/SYFikLuWOJDB0zTOw3SrsBUnIqPTVIrsZ+M6ZCfwznmSGgLDl1dfGAVl
 T1W7DrjJ8qgsb3QFSr5sWw4PmbSO172rVXfFvOn/UEo0qKASk7GIZeBBqrNPoM0cTURx
 qE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947330; x=1733552130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsppy5mifOqwG1NxW07VQAvccK4JcXuvMoQenyGT+Gc=;
 b=QWZfbaZP5EG5qCl/+rF5cgN8Ps4Hr2ZxFSWTUD17cuyFBZ5MT5LV+CXaw8SKmR7yjx
 94T0uv/BXOE+nRFzsPiuRSzeRgWni4zY2QEBNshfNNn2/5LADHPYZ2ZeuabzTGuiv9ZB
 hh4BPLTUsAjEPEZLf3DbNeNE8fGe+vDE+VRMGZb/s9egaHb2fMuoA5JEMMi5bwH8SFpG
 EZiBsRvOqGXrD8PjAS9GTktV3w4MDCdPk8DOAoKKRni1Ui/nv17dJb8qDQFqKgX99iuy
 XdMhEp+P5rdO41AEkG+DTJGBcboTaTC89S6pUEOTE8IIGB+A+jmGujxfz1QyOlj+Meta
 pq4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsC3rrV69mLY7YGA2wxj/8ANCSURa9rlbJ3DKG/XRI1Bm54Se12T9042OfzTy0swt25eEbEGbaTf1z@nongnu.org
X-Gm-Message-State: AOJu0YzAyz1Inc1hCrlXJ0Vg3DQHYCpX+z4/4RLWfDFhtVM+VS2PXYC3
 +j+BJpXJxKBm7lxlC4rY3IzJjREda5JBnv0PfWS7YIyL20PhLkpRa0SGbgNfNdInGPcOiPJzfFB
 Ht7s=
X-Gm-Gg: ASbGncu9zBfuLz2CEi4mtgtY/tXqM9MyeXa/adO6LrHQToR8hGOFfpwpY1P06maqnKx
 5z7R5ahe0HjEDQVSnDjjxdLVfACNkO10m8M4PaFE/inbLaSNDLesqJk8TENs6KbXoDUEMIs+FnT
 nYIncQYYrhNbBFwrirz8bsFnUbdRGoRRJrgsp3Sm5E4ftIg6TtphI5SzeL/G02XDrUfgY8z13ZH
 RrEeQTARhuybH451z0GY1Mht2TM5h8q6cPvNtHLlfs2yC8rtWE0Lzhgd3EUgXI=
X-Google-Smtp-Source: AGHT+IGJC/VZm0+3G5X6Gkjz6X2p6djWd/jUnysk6eBHl6ffqPLEZpZRbZIGIxHZoQs//0cCGpRaSw==
X-Received: by 2002:a05:6a20:7349:b0:1e0:c8d9:337a with SMTP id
 adf61e73a8af0-1e0e0b4b612mr22970054637.27.1732947330730; 
 Fri, 29 Nov 2024 22:15:30 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254182c817sm4488095b3a.170.2024.11.29.22.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:15:30 -0800 (PST)
Message-ID: <9930c64c-f323-41ef-a4b7-30e39fbf83bf@daynix.com>
Date: Sat, 30 Nov 2024 15:15:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/15] hvf: arm: Ignore writes to CNTP_CTL_EL0
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
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-9-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-9-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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

On 2024/11/30 0:24, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> MacOS unconditionally disables interrupts of the physical timer on boot
> and then continues to use the virtual one. We don't really want to support
> a full physical timer emulation, so let's just ignore those writes.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

