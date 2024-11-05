Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F05D12663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 08:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8FDv-0004By-Gm; Tue, 05 Nov 2024 03:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8FDo-00049i-5K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:47:32 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8FDl-0000F2-I3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:47:31 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so4136987b3a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 00:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730796448; x=1731401248;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9lx/PXV0Dppq7a1WCdCLmWcW2OTPkQgfNhcvY0PfGPk=;
 b=LaAVf008mXNiI/sjLRmpSkA2L4SoToHwRG9gQOxUj3S434h5JiU9O4yqvncRZ23T9x
 DjDFDlpLbZ2aIH2LTqmSAJUA31thsK6XZdItYSMUXW1lURjEV40WwZqLYIqUbuZ/SEPz
 a2rmAzOLECHEKFVyfXMNLtYaa08h7W5Xe+bftZxLJ5znD+eXGoOfmPYsVkiDkQI20bG9
 DyFFIGEH8Qm9u6swfWC/wfAUCM1iIlBhNPhdtY6uFcHaMViKaudtUEG0V8FcYK4v64us
 CLAyt/+8LOZtkEQgL+QK5ngLB9O3iO0qZTroobVrl9lexJELsWWt6LmOVYOvK1WygMho
 1dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730796448; x=1731401248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9lx/PXV0Dppq7a1WCdCLmWcW2OTPkQgfNhcvY0PfGPk=;
 b=oqBTueaqXYa1vgxkLNMI/Rid0P4Ynmyz2oCf75uJyAki1WlAm/b5Ybn8zi5okmz57n
 Skzki9z/ra9DFZna50WjJZKQ2UN5Gjy1iODMycnGMfsfxMuxMS05Ch4rJeeZlOVYqkXp
 HSq7X0KhdiX0uLasYyTBCy8mRqEFxYoVwFSdMuCSNAiRnL7G7Ff51CNrRTpe6nShMCU+
 B6iA8xPK7kdASiBw0MBZ/pdbMKkoiWTwseoj/It0rrkoPBquY1A7o703JaimQNc0eTmf
 SHG6WpZeog0/G0lZwGoWTf5uf8vWiaskhdLmB2kfLk4WJf9aUwXEbQgHhtvXRBOwicQo
 lbeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPd3Qa0Uf9rUP3V4+xTr/pgn8uzvZzzBg1ydyueeVtmjc/P0ZVYsALuvoPUT3gPF1TvZKleXe4X5Q8@nongnu.org
X-Gm-Message-State: AOJu0Yy8rns3QCOIgm6dL8bRGL6etPD+z8JM/mCcvCRx9Fj/O4lsx20R
 R1Qp1Rx1O+0DMZBWby/cngoeSZLKpMm3Nm82cGAHd7xnG8BzsoNaySbIz+7U+GA=
X-Google-Smtp-Source: AGHT+IGdJfKQe+5qG7st8FjD44uhWf1CV/uOpyj/6loS872+ydG6Btkfd4OQr4xOBgL0+mXUjG99ag==
X-Received: by 2002:a05:6a20:8c22:b0:1d9:c6a6:61d8 with SMTP id
 adf61e73a8af0-1d9c6a661dbmr31288175637.7.1730796448132; 
 Tue, 05 Nov 2024 00:47:28 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93daac772sm9128653a91.21.2024.11.05.00.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 00:47:27 -0800 (PST)
Message-ID: <c611b7b9-98a4-4648-97d8-a08d4f5f27e8@daynix.com>
Date: Tue, 5 Nov 2024 17:47:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/15] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241103150037.48194-1-phil@philjordan.eu>
 <20241103150037.48194-14-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241103150037.48194-14-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/04 0:00, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Apple has its own virtio-blk PCI device ID where it deviates from the
> official virtio-pci spec slightly: It puts a new "apple type"
> field at a static offset in config space and introduces a new barrier
> command.
> 
> This patch first creates a mechanism for virtio-blk downstream classes to
> handle unknown commands. It then creates such a downstream class and a new
> vmapple-virtio-blk-pci class which support the additional apple type config
> identifier as well as the barrier command.
> 
> It then exposes 2 subclasses from that that we can use to expose root and
> aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-virtio-aux".
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

